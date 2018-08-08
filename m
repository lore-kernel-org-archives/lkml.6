Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD7DC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 19:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC1DA21A28
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 19:12:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC1DA21A28
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730232AbeHHVdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 17:33:15 -0400
Received: from g9t5009.houston.hpe.com ([15.241.48.73]:34112 "EHLO
        g9t5009.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbeHHVdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 17:33:15 -0400
X-Greylist: delayed 99113 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Aug 2018 17:33:14 EDT
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g9t5009.houston.hpe.com (Postfix) with ESMTP id 49ED57C;
        Wed,  8 Aug 2018 19:12:11 +0000 (UTC)
Received: from anatevka.americas.hpqcorp.net (anatevka.americas.hpqcorp.net [10.34.81.6])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id ACDFC46;
        Wed,  8 Aug 2018 19:12:10 +0000 (UTC)
Date:   Wed, 8 Aug 2018 13:12:10 -0600
From:   Jerry Hoemann <jerry.hoemann@hpe.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] watchdog: hpwdt: Claim NMI from iLO
Message-ID: <20180808191210.GA6695@anatevka.americas.hpqcorp.net>
Reply-To: Jerry.Hoemann@hpe.com
References: <1533244541-42310-1-git-send-email-jerry.hoemann@hpe.com>
 <1533244541-42310-3-git-send-email-jerry.hoemann@hpe.com>
 <b4de8a19-00c6-fcca-2414-197056ef27bc@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4de8a19-00c6-fcca-2414-197056ef27bc@roeck-us.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 04, 2018 at 06:09:05PM -0700, Guenter Roeck wrote:
> On 08/02/2018 02:15 PM, Jerry Hoemann wrote:
> > The hwpdt driver is overloaded for handling both the iLO
> > watchdog and the explicit "Generate NMI to System" virutal
> > button.
> > 
> > Claim the iLO NMI virtual button even if we are not claiming
> > the iLO watchdog pretimeout.
> > 
> > Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
> 
> Guess you know what you are doing here.
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Unfortunately the underlying documentation isn't publically available.
I am going loosen the check in version two, but current upstream
is definitely wrong for reasons above.

> 
> > ---
> >   drivers/watchdog/hpwdt.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> > index 369022d..8a85ddd 100644
> > --- a/drivers/watchdog/hpwdt.c
> > +++ b/drivers/watchdog/hpwdt.c
> > @@ -162,7 +162,7 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
> >   	if (ilo5 && ulReason == NMI_UNKNOWN && !mynmi)
> >   		return NMI_DONE;
> > -	if (ilo5 && !pretimeout)
> > +	if (ilo5 && !pretimeout && !(mynmi & 0x4))
> >   		return NMI_DONE;
> >   	hpwdt_stop();
> > 

-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------
