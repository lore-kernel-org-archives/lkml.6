Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751630AbeEVSib (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 14:38:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54642 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751319AbeEVSia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 14:38:30 -0400
Date: Tue, 22 May 2018 12:38:29 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: kwankhede@nvidia.com, Dong Jia <bjsdjshi@linux.vnet.ibm.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org, cohuck@redhat.com
Subject: Re: [PATCH v4 0/2] vfio/mdev: Device namespace protection
Message-ID: <20180522123829.4e758646@w520.home>
In-Reply-To: <c666f6b7-bd49-79e4-703d-2724f7549c53@linux.ibm.com>
References: <20180518190145.3187.7620.stgit@gimli.home>
        <c666f6b7-bd49-79e4-703d-2724f7549c53@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 May 2018 19:17:07 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

>  From vfio-ccw perspective I join Connie's assessment: vfio-ccw should
> be fine with these changes. I'm however not too deeply involved with
> the mdev framework, thus I don't feel comfortable r-b-ing. That results
> in
> Acked-by: Halil Pasic <pasic@linux.ibm.com>
> for both patches.
> 
> While at it I have would like to ask about the semantics and intended
> use of the mdev interfaces.
> 
> static int vfio_ccw_sch_probe(struct subchannel *sch)
> {
> 
> /* HALIL: 8< Not so interesting stuff happens here. >8 */

This was interesting:

	private->state = VFIO_CCW_STATE_NOT_OPER;

>          ret = vfio_ccw_mdev_reg(sch);
>          if (ret)
>                  goto out_disable;
> /*
>   * HALIL:  
>   * This might be racy. Somewhere in vfio_ccw_mdev_reg() the create attribute
>   * is made available (it calls mdev_register_device()). For instance create will
>   * attempt to decrement private->avail which is initialized below. I fail to
>   * understand how is  this well synchronized.
>   */
>          INIT_WORK(&private->io_work, vfio_ccw_sch_io_todo);
>          atomic_set(&private->avail, 1);
>          private->state = VFIO_CCW_STATE_STANDBY;
> 
>          return 0;
> 
> out_disable:
>          cio_disable_subchannel(sch);
> out_free:
>          dev_set_drvdata(&sch->dev, NULL);
>          kfree(private);
>          return ret;
> }
> 
> Should not initialization  of go before mdev_register_device(), and then rolled
> back if necessary if mdev_register_device() fails?
> 
> In practice it does not seem very likely that userspace can trigger
> mdev_device_create() before vfio_ccw_sch_probe() finishes so it should
> not be a practical problem. But I would like to understand how synchronization
> is supposed to work.
> 
> [Added Dong Jia, maybe he is also able to answer my question.]

vfio_ccw_mdev_create() requires that private->state is not
VFIO_CCW_STATE_NOT_OPER but vfio_ccw_sch_probe() explicitly sets state
to this value before calling vfio_ccw_mdev_reg(), so a create should
return -ENODEV if racing with parent registration.  Is there something
else that I'm missing?  Thanks,

Alex
