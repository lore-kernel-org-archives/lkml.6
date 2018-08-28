Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA48C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E75720846
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:10:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E75720846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbeH1MBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 08:01:01 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:42037 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbeH1MBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 08:01:01 -0400
Received: by mail-qt0-f196.google.com with SMTP id z8-v6so692941qto.9;
        Tue, 28 Aug 2018 01:10:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WKyapFwbBFQhhVcClwmWLTrEfmTNfTeiWLu3nuwHH48=;
        b=X79xMftXXlHyt6SVQQda5xczZmSPm8NUGHmZlG5BltF5wswCxT3cUCdU81OpG8QOEe
         eMGsTo7jlX22ho8Gm3mKvfGDx3eD8BVyS+1bN7qN9XgvfIKf6IGzIPwkhfhUbaLCeeD2
         ZiHAPga75JPg6f4tudLZNhS8Sklw6BpATYUTavWHqFyC2k1Dmlb4WTcWTurczyVSUziG
         jKjsDEX7TS6sueFcaiQ7WFFoZV9kl97Ujckiji4p+TDSYfTEyjhgY5BbmW6oJD/OQLpJ
         9QJ9Cnd8lyzFVaUUmP0LsTnN8kiv7i3cr2spxh9nwd1XVGlprAz4DzqpDzc/eMQHV4s8
         1sfA==
X-Gm-Message-State: APzg51Cx6vLkX32pavzPU2EE/5ePoOPRDGXK872Uhrb/aRz99B84wtMx
        EfmUT+6O8uu0p9cM6DoREJIGqjv6K5KyQBDmOY4=
X-Google-Smtp-Source: ANB0VdbGxUpshUo8LOkgDuzvwodPpx1B88QrrlYEVVi+Wstu4sJtneA/hRBblhun5BtWjP224vsAKQNQbCfekh4Jk4A=
X-Received: by 2002:ac8:c9:: with SMTP id d9-v6mr422372qtg.213.1535443831812;
 Tue, 28 Aug 2018 01:10:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180827200338.220211-1-arnd@arndb.de> <20180827200338.220211-2-arnd@arndb.de>
 <20180827202137.GD6515@ZenIV.linux.org.uk>
In-Reply-To: <20180827202137.GD6515@ZenIV.linux.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 28 Aug 2018 10:10:15 +0200
Message-ID: <CAK8P3a31DtuRQFwK=yfKJHC-Qx0Kb9xWib1Us+_tdtFNw0iwQQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] rtc: move compat_ioctl handling into rtc-dev.c
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        keguang.zhang@gmail.com,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 10:21 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Mon, Aug 27, 2018 at 10:03:09PM +0200, Arnd Bergmann wrote:
> > +     case RTC_IRQP_READ32:
> > +     case RTC_EPOCH_READ32: {
> > +             valp = compat_alloc_user_space(sizeof(*valp));
> > +             if (valp == NULL)
> > +                     return -EFAULT;
> > +             ret = rtc_dev_ioctl(file, (cmd == RTC_IRQP_READ32) ?
> > +                                     RTC_IRQP_READ : RTC_EPOCH_READ,
> > +                                     (unsigned long)valp);
> > +             if (ret)
> > +                     return ret;
> > +             if (get_user(val, valp) || put_user(val, argp))
> > +                     return -EFAULT;
>
>         No.  With the side of Hell, No.  This is bloody ridiculous - take a look
> at rtc_dev_ioctl().  Seriously.  Relevant bits:
>         struct rtc_device *rtc = file->private_data;
>         const struct rtc_class_ops *ops = rtc->ops;
>         struct rtc_time tm;
>         struct rtc_wkalrm alarm;
>         void __user *uarg = (void __user *) arg;
>
>         err = mutex_lock_interruptible(&rtc->ops_lock);
>         if (err)
>                 return err;
>
>                 err = put_user(rtc->irq_freq, (unsigned long __user *)uarg);
>
>         mutex_unlock(&rtc->ops_lock);
>         return err;
>
> That's RTC_IRQP_READ.  IOW, all that song and dance starting with
> compat_alloc_user_space() is just a way to get to rtc->irq_freq value.
>
> RTC_EPOCH_READ is in the bowels of individual implementations, but it's
> otherwise very similar; add a method returning the damn thing (e.g.
> rtc->ops->get_epoch(rtc)) and lift its call into rtc_dev_ioctl(), then
> this nonsense will go away as well.

Okay. I was basically trying to do one step of moving the code
in a more appropriate place without changing it much. The problem
I see with a get_epoch() callback is that we don't actually want more
drivers to implement it. At the moment there is only one (vr41xx),
so how about just moving the compat epoch handling there and
completely leaving it outside of the common rtc-dev implementation?

diff --git a/drivers/rtc/rtc-vr41xx.c b/drivers/rtc/rtc-vr41xx.c
index 70f013e692b0..05f981f7cd21 100644
--- a/drivers/rtc/rtc-vr41xx.c
+++ b/drivers/rtc/rtc-vr41xx.c
@@ -17,6 +17,7 @@
  *  along with this program; if not, write to the Free Software
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
+#include <linux/compat.h>
 #include <linux/err.h>
 #include <linux/fs.h>
 #include <linux/init.h>
@@ -195,6 +196,11 @@ static int vr41xx_rtc_ioctl(struct device *dev,
unsigned int cmd, unsigned long
        switch (cmd) {
        case RTC_EPOCH_READ:
                return put_user(epoch, (unsigned long __user *)arg);
+#ifdef CONFIG_COMPAT
+       case RTC_EPOCH_READ32:
+               return put_user(epoch, (unsigned int __user *)arg);
+       case RTC_EPOCH_SET32:
+#endif
        case RTC_EPOCH_SET:
                /* Doesn't support before 1900 */

> > +             return 0;
> > +     }
> > +
> > +     /* arguments are compatible, command number is not */
> > +     case RTC_IRQP_SET32:
> > +             return rtc_dev_ioctl(file, RTC_IRQP_SET, arg);
> ITYM
>                 cmd = RTC_IRQP_SET;
>                 break;
> > +     case RTC_EPOCH_SET32:
> ... and
>                 cmd = RTC_EPOCH_SET;
>                 break;
> here.

Just to clarify: do you mean I copied a bug from the old code,
or are you objecting to the coding style?

> > +             return rtc_dev_ioctl(file, RTC_EPOCH_SET, arg);
> > +     }
> > +
> > +     /*
> > +      * all other rtc ioctls are compatible, or only
> > +      * exist on architectures without compat mode
> > +      */
> > +
> > +     return rtc_dev_ioctl(file, cmd, (unsigned long)argp);
> > +}
>
> compat_alloc_user_space() is usually papering over bogosities like
> that; if you are moving something out to individual drivers, it's
> always a red flag - most of the time it'll turn out to be pointless.

Absolutely agreed. Eliminating compat_alloc_user_space()
was a bit lower on my priority list than killing off do_ioctl_trans()
(which is already fairly low at the bottom), but I've adjusted that
and will send an update.

I have a couple more patches for do_ioctl_trans() that started
out as a side product of my y2038 patches, I'll make sure
to do it the same way for any others. SG_GET_REQUEST_TABLE
was the only other command for which I chose to keep
compat_alloc_user_space() after my attempt to kill it ended
up in way more complexity, but I can also revisit that, or maybe
drop that patch until I get motivated to also tackle SG_IO.

     Arnd
