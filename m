Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60048C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 23:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D60E2084E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 23:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="tVSHWm6N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D60E2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbeKZKRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 05:17:07 -0500
Received: from onstation.org ([52.200.56.107]:44252 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbeKZKRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 05:17:07 -0500
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 6D9D257D;
        Sun, 25 Nov 2018 23:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1543188291;
        bh=PMJlDVOMbbwly36sO9x/di5t70q0Mms+TjbNIUow8GY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tVSHWm6NvaHn4KXm6oX+f/Op78ky+62XETjVHKyZxjS8aGFKq8xQd/ldcYGG1itue
         0FYp/OF0BxI5itONPBZ7KGc1sL2r62RT1r6s6msCtKlb08O1aJ7g2ty5+SGoBNuvEj
         FgckXcWsgO0HVswLTYzJKzye/EBUijX2pJ2kQwlA=
Date:   Sun, 25 Nov 2018 18:24:50 -0500
From:   Brian Masney <masneyb@onstation.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Question about "regulator: core: Only count load for enabled
 consumers" in -next
Message-ID: <20181125232450.GA3774@basecamp>
References: <20181125093750.GA28055@basecamp>
 <CAD=FV=VuPerEgPPiUKk7-Ck9aVz=oR1CAAzg+0wag1WTrTGKxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=VuPerEgPPiUKk7-Ck9aVz=oR1CAAzg+0wag1WTrTGKxg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

On Sun, Nov 25, 2018 at 09:20:02AM -0800, Doug Anderson wrote:
> On Sun, Nov 25, 2018 at 1:37 AM Brian Masney <masneyb@onstation.org> wrote:
> > I bisected the issue to the following commit:
> >
> > 5451781dadf8 ("regulator: core: Only count load for enabled consumers")
> >
> > We have to increase the load for the sdhci in device tree in order for
> > the phone to boot properly. This change was made with the commit:
> >
> > 03864e57770a ("ARM: dts: qcom: msm8974-hammerhead: increase load on l20
> > for sdhci")
> 
> You have a 200 mA system load on this regulator?

Yes.

> I guess this is a workaround for drivers that don't set the load
> properly themselves?

I'm honestly not sure when the load should be set in the driver or in
device tree. None of the drivers in drivers/mmc/ call
regulator_set_load. The dt bindings describes the regulator-system-load
property in Documentation/devicetree/bindings/regulator/regulator.txt.

I see that there are 8 users of regulator-system-load but most are all
addressing this same issue with the SD card. 
qcom-msm8974-sony-xperia-castor.dts sets the load to 500 mA but all of
the other msm8974-based SOCs use 200 mA. I'm not sure if this is
correct.

> I wonder if there is a bug in my patch where the system load doesn't
> take effect if nobody ever calls set_load.  Let's see...  Does the
> below fix things for you?  It's totally untested and whitespace
> damaged but I wanted to get a response out quick and I'm just walking
> out the door.  I'll test more / dig more either tonight or at work
> tomorrow:
> 
> +++ b/drivers/regulator/core.c
> @@ -1344,6 +1344,12 @@ static int set_machine_constraints(struct
> regulator_dev *rdev,
>                         rdev_err(rdev, "failed to set initial mode: %d\n", ret);
>                         return ret;
>                 }
> +       } else if (rdev->constraints->system_load) {
> +               /*
> +                * We'll only apply the initial system load if an
> +                * initial mode wasn't specified.
> +                */
> +               drms_uA_update(rdev);
>         }

Yes, this patch corrects the issue for me. You can add my tags if you
end up applying it:

Reported-by: Brian Masney <masneyb@onstation.org>
Tested-by: Brian Masney <masneyb@onstation.org>

Feel free to send me any other patches if you'd like me to do
additional testing.

Thanks for the quick response!

Brian
