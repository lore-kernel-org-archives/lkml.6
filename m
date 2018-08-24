Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5355C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A9F52173D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:07:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A9F52173D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=etezian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbeHXNlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 09:41:11 -0400
Received: from 10.mo173.mail-out.ovh.net ([46.105.74.148]:50477 "EHLO
        10.mo173.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbeHXNlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 09:41:11 -0400
X-Greylist: delayed 3623 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Aug 2018 09:41:11 EDT
Received: from player687.ha.ovh.net (unknown [10.109.143.238])
        by mo173.mail-out.ovh.net (Postfix) with ESMTP id 972DDC8AA3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 10:49:49 +0200 (CEST)
Received: from etezian.org (unknown [194.136.86.45])
        (Authenticated sender: andi@etezian.org)
        by player687.ha.ovh.net (Postfix) with ESMTPSA id 072BD2C00B0;
        Fri, 24 Aug 2018 10:49:34 +0200 (CEST)
Date:   Fri, 24 Aug 2018 11:49:33 +0300
From:   Andi Shyti <andi@etezian.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Derek Basehore <dbasehore@chromium.org>,
        Johnny Chuang <johnny.chuang@emc.com.tw>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        joe@perches.com, andi@etezian.org, gregkh@linuxfoundation.org,
        James Chen <james.chen@emc.com.tw>,
        KT Liao <kt.liao@emc.com.tw>
Subject: Re: [PATCH] Input: elants_i2c - Fix sw reset delays
Message-ID: <20180824084933.GA29856@jack.zhora.eu>
References: <20180823231013.254037-1-dbasehore@chromium.org>
 <20180823233028.GC53155@dtor-ws>
 <20180823233211.GD53155@dtor-ws>
 <20180823233424.GE53155@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823233424.GE53155@dtor-ws>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Ovh-Tracer-Id: 14316098794527769242
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtjedrfeehgddtlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Derek,

> > > On Thu, Aug 23, 2018 at 04:10:13PM -0700, Derek Basehore wrote:
> > > > We only need to wait 10ms instead of 30ms before starting fastboot or
> > > > sending IAP on the touchscreen. Also, instead of delaying everytime
> > > > sw_reset is called, this delays 10ms in the function that starts
> > > > fastboot. There's also an explicit 20ms delay before sending IAP when
> > > > updating the firmware, so no additional delay is needed there. This
> > > > change also has the benefit of not delaying when wakeup is enabled
> > > > during suspend. This is because sw_reset is called, yet fastboot
> > > > isn't.

...

> > > > -	/*
> > > > -	 * We should wait at least 10 msec (but no more than 40) before
> > > > -	 * sending fastboot or IAP command to the device.
> > > > -	 */
> > > > -	msleep(30);
> > > > -

moving from 30 to 0 is a bit alarming... what does the datasheet
say?

Sometimes delays are implicit in the system where you are testing
the driver, so that without any msleep it might work in your
system but it might not on others.

> +             /*
> +              * We should wait at least 10 msec (but no more than 40) before
> +              * sending IAP command to the device.
> +              */
>               msleep(20);

I agree though that it's not nice to wait twice here (even though
as Dmitry says it doesn't hurt so much). Wouldn't it make more
sense to remove this msleep instead?
This way...

> +     /*
> +      * We should wait at least 10 msec (but no more than 40) before sending
> +      * fastboot command to the device.
> +      */
> +     usleep_range(10 * 1000, 11 * 1000);
> +
>       error = elants_i2c_send(client, boot_cmd, sizeof(boot_cmd));

... you do not need to add an extra sleep here.

Andi
