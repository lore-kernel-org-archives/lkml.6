Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205E9C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE6A208B9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:52:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CE6A208B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=etezian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbeH0PiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 11:38:22 -0400
Received: from 8.mo68.mail-out.ovh.net ([46.105.74.219]:43658 "EHLO
        8.mo68.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbeH0PiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 11:38:22 -0400
Received: from player792.ha.ovh.net (unknown [10.109.159.222])
        by mo68.mail-out.ovh.net (Postfix) with ESMTP id CF357F545F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 13:51:57 +0200 (CEST)
Received: from etezian.org (unknown [194.136.86.45])
        (Authenticated sender: andi@etezian.org)
        by player792.ha.ovh.net (Postfix) with ESMTPSA id 48695A00CF;
        Mon, 27 Aug 2018 13:51:47 +0200 (CEST)
Date:   Mon, 27 Aug 2018 14:51:45 +0300
From:   Andi Shyti <andi@etezian.org>
To:     "dbasehore ." <dbasehore@chromium.org>
Cc:     andi@etezian.org, dmitry.torokhov@gmail.com,
        johnny.chuang@emc.com.tw,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org, joe@perches.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        james.chen@emc.com.tw, kt.liao@emc.com.tw
Subject: Re: [PATCH] Input: elants_i2c - Fix sw reset delays
Message-ID: <20180827115145.GA1567@jack.zhora.eu>
References: <20180823231013.254037-1-dbasehore@chromium.org>
 <20180823233028.GC53155@dtor-ws>
 <20180823233211.GD53155@dtor-ws>
 <20180823233424.GE53155@dtor-ws>
 <20180824084933.GA29856@jack.zhora.eu>
 <CAGAzgsqhTbgB2vAYDLMUFvuJ7F4pqHxRp+Xo+iny8g9ghTYM6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGAzgsqhTbgB2vAYDLMUFvuJ7F4pqHxRp+Xo+iny8g9ghTYM6g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Ovh-Tracer-Id: 16563395004698706471
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtjedrgedvgdefiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Derek,

next time, could you please avoid using html mails when replying
to the mailing list? They are not clear.

On Fri, Aug 24, 2018 at 04:07:41PM -0700, dbasehore . wrote:
> 
> 
> On Fri, Aug 24, 2018 at 1:49 AM Andi Shyti <andi@etezian.org> wrote:
> 
>     Hi Derek,
> 
>     > > > On Thu, Aug 23, 2018 at 04:10:13PM -0700, Derek Basehore wrote:
>     > > > > We only need to wait 10ms instead of 30ms before starting fastboot
>     or
>     > > > > sending IAP on the touchscreen. Also, instead of delaying everytime
>     > > > > sw_reset is called, this delays 10ms in the function that starts
>     > > > > fastboot. There's also an explicit 20ms delay before sending IAP
>     when
>     > > > > updating the firmware, so no additional delay is needed there. This
>     > > > > change also has the benefit of not delaying when wakeup is enabled
>     > > > > during suspend. This is because sw_reset is called, yet fastboot
>     > > > > isn't.
> 
>     ...
> 
>     > > > > -       /*
>     > > > > -        * We should wait at least 10 msec (but no more than 40)
>     before
>     > > > > -        * sending fastboot or IAP command to the device.
>     > > > > -        */
>     > > > > -       msleep(30);
>     > > > > -
> 
>     moving from 30 to 0 is a bit alarming... what does the datasheet
>     say?
> 
> 
> We're moving from 30msec to 10msec. We used to do this in an older kernel.

That's not what you are saying in your commit message:

  "... This change also has the benefit of not delaying when
  wakeup is enabled during suspend... "

and indeed, in resume the "elants_i2c_sw_reset()" function would
be called without any msleep. Or am I missing something? Would
it be correct based on the datasheet?

>  
> 
> 
>     Sometimes delays are implicit in the system where you are testing
>     the driver, so that without any msleep it might work in your
>     system but it might not on others.
> 
>     > +             /*
>     > +              * We should wait at least 10 msec (but no more than 40)
>     before
>     > +              * sending IAP command to the device.
>     > +              */
>     >               msleep(20);
> 
>     I agree though that it's not nice to wait twice here (even though
>     as Dmitry says it doesn't hurt so much). Wouldn't it make more
>     sense to remove this msleep instead?
>     This way...
> 
> 
> We still need this if the delay is removed from the sw_reset function. We have
> a total of 20msecs delayed between sw_reset and sending IAP in our old kernel
> which should be well tested. There seems to be no reason why the delays
> increased.

Yes, that's what I'm saying, removing this msleep to me looks
more correct than removing it from sw_reset().

>     > +     /*
>     > +      * We should wait at least 10 msec (but no more than 40) before
>     sending
>     > +      * fastboot command to the device.
>     > +      */
>     > +     usleep_range(10 * 1000, 11 * 1000);
>     > +
>     >       error = elants_i2c_send(client, boot_cmd, sizeof(boot_cmd));
> 
>     ... you do not need to add an extra sleep here.
> 
> 
> I added it here since I removed the 30msec sleep in sw_reset. This prevents us
> from sleeping on resume when the touch controller is already on for wake up
> capabilities. This is the same delay that we have in our old 3.8 kernel, so
> it's pretty well tested and shipped in production.

And here we fall in my first question (and also Dmitry's
concern), Are we sure we don't need to sleep after resume? Again,
what does the datasheet say?

I don't know the answer, you might be right, but I need to know
why you are removing the sleep after resume and why, instead,
the original developer added it there.

Two more nitpicks on this patch:

1. by adding the usleep_range() outside from the
elants_i2c_sw_reset() function, to another developer reading the
code, might not really look clear why we are waiting. The
comment you copy pasted does not, indeed, refer that we are
waiting because a reset has been performed and we need to wait
for the _reset time_ before sending IAP commands.

2. this is a matter of taste: to me "10000" looks more clear than
"10 * 1000", which doesn't add any better readability of the
number itself.

Thanks,
Andi
