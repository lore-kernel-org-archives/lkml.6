Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426CDC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA98021480
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:06:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA98021480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732813AbeIYAKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 20:10:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54100 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbeIYAKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 20:10:20 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5E480F06;
        Mon, 24 Sep 2018 18:06:57 +0000 (UTC)
Date:   Mon, 24 Sep 2018 20:06:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        alexander.levin@microsoft.com
Subject: Re: [PATCH 4.18 177/235] gpiolib: dont allow userspace to set values
 of input lines
Message-ID: <20180924180654.GA31233@kroah.com>
References: <20180924113103.999624566@linuxfoundation.org>
 <20180924113122.447077803@linuxfoundation.org>
 <CAMRc=Mc92mF18Tax+6hPdAYnw4t4_pD3FjVOGAzxttJCRP5gdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mc92mF18Tax+6hPdAYnw4t4_pD3FjVOGAzxttJCRP5gdA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 02:57:38PM +0200, Bartosz Golaszewski wrote:
> pon., 24 wrz 2018 o 14:41 Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> napisał(a):
> >
> > 4.18-stable review patch.  If anyone has any objections, please let me know.
> >
> > ------------------
> >
> > From: Bartosz Golaszewski <brgl@bgdev.pl>
> >
> > [ Upstream commit e5332d5437764f775cf4e3b8ca3bf592af063a02 ]
> >
> > User space can currently both read and set values of input lines using
> > the character device. This was not allowed by the old sysfs interface
> > nor is it a correct behavior.
> >
> > Check the first descriptor in the set for the OUT flag when asked to
> > set values and return -EPERM if the line is input.
> >
> > Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/gpio/gpiolib.c |    8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > --- a/drivers/gpio/gpiolib.c
> > +++ b/drivers/gpio/gpiolib.c
> > @@ -449,7 +449,13 @@ static long linehandle_ioctl(struct file
> >
> >                 return 0;
> >         } else if (cmd == GPIOHANDLE_SET_LINE_VALUES_IOCTL) {
> > -               /* TODO: check if descriptors are really output */
> > +               /*
> > +                * All line descriptors were created at once with the same
> > +                * flags so just check if the first one is really output.
> > +                */
> > +               if (!test_bit(FLAG_IS_OUT, &lh->descs[0]->flags))
> > +                       return -EPERM;
> > +
> >                 if (copy_from_user(&ghd, ip, sizeof(ghd)))
> >                         return -EFAULT;
> >
> >
> >
> 
> Hi Greg,
> 
> FYI Linus suggested that we don't send this one for stable:
> https://lkml.org/lkml/2018/7/20/1065

Ok, that was hard to dig out.  This was sent as review last week.  I'll
go drop it, thanks for letting me know.

greg k-h
