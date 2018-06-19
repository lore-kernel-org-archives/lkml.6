Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A633AC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 20:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A7D20693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 20:30:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62A7D20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757006AbeFSUaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 16:30:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44838 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755265AbeFSUaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 16:30:02 -0400
Received: from localhost (unknown [61.115.201.97])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F2AD3EB6;
        Tue, 19 Jun 2018 20:30:00 +0000 (UTC)
Date:   Wed, 20 Jun 2018 05:29:59 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [RFC PATCH v2] driver core: add a debugfs entry to show deferred
 devices
Message-ID: <20180619202959.GA19129@kroah.com>
References: <20180619183356.32106-1-javierm@redhat.com>
 <CAHp75Vcn39N9rZ0UO3szGrODVLxek4X746uWs+RPXwy4i0s1Ug@mail.gmail.com>
 <CAHp75VdpHdanWJmcwLBRTSDoDkbpPxuAGwwVO0hosXSRn4PUoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdpHdanWJmcwLBRTSDoDkbpPxuAGwwVO0hosXSRn4PUoA@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 10:55:20PM +0300, Andy Shevchenko wrote:
> On Tue, Jun 19, 2018 at 10:53 PM, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Tue, Jun 19, 2018 at 9:33 PM, Javier Martinez Canillas
> > <javierm@redhat.com> wrote:
> >> For debugging purposes it may be useful to know what are the devices whose
> >> probe function was deferred. Add a debugfs entry showing that information.
> 
> >> +static int deferred_devs_open(struct inode *inode, struct file *file)
> >> +{
> >> +       return single_open(file, deferred_devs_show, inode->i_private);
> >> +}
> >> +
> >> +static const struct file_operations deferred_devs_fops = {
> >> +       .owner = THIS_MODULE,
> >> +       .open = deferred_devs_open,
> >> +       .read = seq_read,
> >> +       .llseek = seq_lseek,
> >> +       .release = single_release,
> >> +};
> >
> > Isn't this DEFINE_SHOW_ATTRIBUTE() ?
> 
> Besides that, you are summoning Greg's dark side :-)
> See below.
> 
> >> +       if (IS_ENABLED(CONFIG_DEBUG_FS)) {
> >> +               deferred_devices = debugfs_create_file("deferred_devices",
> >> +                                                      0444, NULL, NULL,
> >> +                                                      &deferred_devs_fops);
> 
> >> +               if (!deferred_devices)
> >> +                       return -ENOMEM;
> 
> This must not prevent the execution. So, the check introduces actually
> a regression.

Awe, you beat me to it :)

Also, I don't usually comment on RFC patches, as that shows the author
really doesn't think that the code is ready to be reviewed/merged...

thanks,

greg k-h
