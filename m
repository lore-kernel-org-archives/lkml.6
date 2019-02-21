Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66C8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9576D20700
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550760250;
	bh=NuKQ1XZa6D3giSs49+v0vCiRCDjMqZlB9ttkXzu3zUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uWVmjp1by1Ic0BRpeZAlVo/cxBHyU4pbvKVv0w096hFNAgB1y1IxddJ9dWN2jyxQ4
	 17xBb4PXJbQouqaDSv0q2+yWWVOx++3zlNUUVdEaLdFX1B1l8dQebSHfV8EsHZfyXo
	 bErXkDoBhWk1lKFhnMCvJqn9jPJoS1OlNG62Gfi4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbfBUOoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:44:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:40214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729835AbfBUOoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:44:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB00E2075A;
        Thu, 21 Feb 2019 14:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550760245;
        bh=NuKQ1XZa6D3giSs49+v0vCiRCDjMqZlB9ttkXzu3zUk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NlVaoLhg2tBtwWWWybB+NMBRqCSe4r1+pQWmyW3NFYuW1YOOp64JFvOoCt4rPOKvI
         jz//Iix3wu1bmUMN1/oYB5AEjMQ7vj8Y9HAke+fByix1P78H2+Ag2sy9D7aNUHiyGH
         Q2GfmTXo9FHKQKGCyYiSYxGaKjeuscpcXFInpQkA=
Date:   Thu, 21 Feb 2019 15:41:59 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org, Ammy Yi <ammy.yi@intel.com>
Subject: Re: [GIT PULL 5/7] intel_th: Don't reference unassigned outputs
Message-ID: <20190221144159.GA9283@kroah.com>
References: <20190221134959.15121-1-alexander.shishkin@linux.intel.com>
 <20190221134959.15121-6-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221134959.15121-6-alexander.shishkin@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 03:49:57PM +0200, Alexander Shishkin wrote:
> When an output port driver is removed, also remove references to it from
> any masters. Failing to do this causes a NULL ptr dereference when
> configuring another output port:
> 
> > BUG: unable to handle kernel NULL pointer dereference at 000000000000000d
> > RIP: 0010:master_attr_store+0x9d/0x160 [intel_th_gth]
> > Call Trace:
> > dev_attr_store+0x1b/0x30
> > sysfs_kf_write+0x3c/0x50
> > kernfs_fop_write+0x125/0x1a0
> > __vfs_write+0x3a/0x190
> > ? __vfs_write+0x5/0x190
> > ? _cond_resched+0x1a/0x50
> > ? rcu_all_qs+0x5/0xb0
> > ? __vfs_write+0x5/0x190
> > vfs_write+0xb8/0x1b0
> > ksys_write+0x55/0xc0
> > __x64_sys_write+0x1a/0x20
> > do_syscall_64+0x5a/0x140
> > entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Reported-by: Ammy Yi <ammy.yi@intel.com>
> ---
>  drivers/hwtracing/intel_th/gth.c | 4 ++++
>  1 file changed, 4 insertions(+)

Shouldn't this have a cc: stable?

And what commit does this "fix"?

thanks,

greg k-h
