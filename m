Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB0AC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 02:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EC3E2536F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 02:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fr0bEkao"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EC3E2536F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932819AbeGBCCS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 22:02:18 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35943 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932182AbeGBCCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 22:02:13 -0400
Received: by mail-pf0-f195.google.com with SMTP id u16-v6so6721263pfh.3
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jul 2018 19:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=l2gD8nsnz8VUrNNwPFfbFuldrxIZnsIqjPjXr3tI6pw=;
        b=fr0bEkaokC6i/JZVZrEZxIeNnxMhNUWgNiU1BgdlKwuAL+ZT9KwSEhD9UR6LuKC/P0
         k/46qKZ0ZoilsdQVNRPsvZ1cPQwS1goouVfYOU3GeRC86KEWsWs/xkXsRacWVjNeQztD
         +RG0hUEpsmqgsCBKlgPvVGjyHKffCJIZtPKdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=l2gD8nsnz8VUrNNwPFfbFuldrxIZnsIqjPjXr3tI6pw=;
        b=cqC2DbOOwC+FMAkWegaYm2vVMMlRwgKQdT9106ERY+7cSC7YZt1mE2FxntqjaGoRvA
         ARfvs7NXD89K8Cbs7CbZ4S8Wc/HvCMbOuPumBGRHNkClg+MWVCD2FaN7h1bbqFA4dkH1
         gTMOzd2xdlCTrl9MO4qXV9NBrXhIBlNaLqMsG/NflFjxLzEgVaUwFmNGdy2jn6VudojJ
         yF89lTG4PNCf46otGXUK1T/K53zLYbcIy9m0KJj6qlL+c1uUf6rZl5AUPmw8uVFm0KRQ
         yp6gMc7bDmS9yYXbLNTtO+IkBgqthX3CxDMEunmKX3rBvBBFfzfZLm0ektuDauIsuyOE
         N+2w==
X-Gm-Message-State: APt69E1TcPXd2mvfBzXweU4ZBMnxJ6gmZiQB0063HdWHseZ+Yvl68tAZ
        8wSf1CAtAiE71JxG+pKiQxjc
X-Google-Smtp-Source: ADUXVKINfHEFQfD54F8aoIgYyT3qTC3SBhGG8cwragBETHAJ/Y/NVhWfPubTj1NHmicaAQXmqbhqIg==
X-Received: by 2002:a63:6b86:: with SMTP id g128-v6mr20471740pgc.344.1530496932944;
        Sun, 01 Jul 2018 19:02:12 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2405:204:7306:b83a:9cb4:3c5a:9392:b00f])
        by smtp.gmail.com with ESMTPSA id 14-v6sm3777874pfw.19.2018.07.01.19.02.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 01 Jul 2018 19:02:12 -0700 (PDT)
Date:   Mon, 2 Jul 2018 07:32:01 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     Saravanan Sekar <sravanhome@gmail.com>, sboyd@kernel.org,
        pn@denx.de, linux-arm-kernel@lists.infradead.org,
        mturquette@baylibre.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        devicetree@vger.kernel.org, Jeff Chen <jeff.chen@actions-semi.com>,
        "Thomas C. Liau" <thomas.liau@actions-semi.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: clock: Modify Actions Soc clock
 bindings
Message-ID: <20180702020201.GA2654@Mani-XPS-13-9360>
References: <20180626192820.28237-3-sravanhome@gmail.com>
 <20180628191805.3722-1-sravanhome@gmail.com>
 <20180628191805.3722-4-sravanhome@gmail.com>
 <20180630093202.GB7320@Mani-XPS-13-9360>
 <15070ea0-aebf-2b7d-89f0-b21e729c927e@gmail.com>
 <20180701173706.GA15895@Mani-XPS-13-9360>
 <88ce01d4-2694-eca0-770e-d4bd2869a258@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <88ce01d4-2694-eca0-770e-d4bd2869a258@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On Sun, Jul 01, 2018 at 07:58:15PM +0200, Andreas Färber wrote:
> Hi,
> 
> Am 01.07.2018 um 19:37 schrieb Manivannan Sadhasivam:
> > On Sun, Jul 01, 2018 at 07:26:20PM +0200, Saravanan Sekar wrote:
> >> Hi Mani
> >>
> >>
> >> On 06/30/18 11:32, Manivannan Sadhasivam wrote:
> >>> Hi Saravanan,
> >>>
> >>> I agree with modifying the existing binding to accomodate other
> >>> SoC's of the same family. But the binding should be
> >>> "actions,owl-cmu.txt" since it reflects the family name.
> >>
> >> Agree, will modify the name
> >>
> >>> Andreas, what do you think?
> 
> I concur that sx00 is insufficient. Older models were called ATMxxxx.
> Unfortunately with owl- it then no longer matches the compatible, but I
> wouldn't mind.
> 
> >>> On Thu, Jun 28, 2018 at 09:18:05PM +0200, Saravanan Sekar wrote:
> >>>> Modify clock bindings common Actions Semi Soc family S700/S900.
> >>>>
> >>>> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> >>>> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> >>>> ---
> >>>>   ...tions,s900-cmu.txt => actions,sx00-cmu.txt} | 18 ++++++++++--------
> >>>>   1 file changed, 10 insertions(+), 8 deletions(-)
> >>>>   rename Documentation/devicetree/bindings/clock/{actions,s900-cmu.txt => actions,sx00-cmu.txt} (71%)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/clock/actions,s900-cmu.txt b/Documentation/devicetree/bindings/clock/actions,sx00-cmu.txt
> >>>> similarity index 71%
> >>>> rename from Documentation/devicetree/bindings/clock/actions,s900-cmu.txt
> >>>> rename to Documentation/devicetree/bindings/clock/actions,sx00-cmu.txt
> >>>> index 93e4fb827cd6..8dc7edb4d198 100644
> >>>> --- a/Documentation/devicetree/bindings/clock/actions,s900-cmu.txt
> >>>> +++ b/Documentation/devicetree/bindings/clock/actions,sx00-cmu.txt
> >>>> @@ -1,12 +1,14 @@
> >>>> -* Actions S900 Clock Management Unit (CMU)
> >>>> +* Actions S900/S700 Clock Management Unit (CMU)
> >>> Same as above. Should be Actions OWL SoC's Clock Management Unit (CMU).
> >>
> >> sure
> >>
> > 
> > During the review of I2C controller driver, Andreas pointed out that
> > we should use Owl instead of OWL in all places and also Actions should
> > be replaced by Actions Semiconductor.
> 
> Actually I was just asking to include the company name and not just say
> Owl. Whether it's Actions, Actions Semi or Actions Semiconductor is not
> that important to me - that would be for the Actions Semi colleagues to
> comment - which I see are not in CC... Please fix that! You don't need
> mp-cs I think, but the others please.
> 

Okay, cool.

> > So, please change it in relevant
> > places. For this binding, title should be:
> > 
> > Actions Semiconductor Owl SoC's Clock Management Unit (CMU).
> 
> "SoC's" looks weird there, do we have such precedence to add it?
> "Actions Owl Clock Management Unit (CMU)" might do?
> 

Let's keep 'Actions Semi' everywhere unless Actions Semi people say
differently.

> Saravanan, please compare other patch titles and adapt your subjects
> accordingly: "modify bindings" is not very meaningful, since a patch
> always modifies something and the prefix already indicates dt-bindings
> as target. "Soc" is misspelled. The time-saving information to put there
> would be addition of S700.
> 
> >>>> -The Actions S900 clock management unit generates and supplies clock to various
> >>>> -controllers within the SoC. The clock binding described here is applicable to
> >>>> -S900 SoC.
> >>>> +The Actions S900/S700 clock management unit generates and supplies clock to
> >>>> +various controllers within the SoC. The clock binding described here is
> >>>> +applicable to S900/S700 SoC.
> 
> "S900 and S700 SoCs"? (keep the slash above)
> 

Agree.

> >>>>   Required Properties:
> >>>> -- compatible: should be "actions,s900-cmu"
> >>>> +- compatible: should be one of this
> >>> Change to: compatible: should be one of the following:
> >>
> >> sure
> >>
> >>> Thanks,
> >>> Mani
> >>>
> >>>> +	"actions,s900-cmu"
> >>>> +	"actions,s700-cmu"
> 
> Mani, should we order alphabetically? I.e., will S500 go before S900, or
> will people just always append at the end now? Not saying we have to,
> but keeping it consistent across Actions bindings would be desirable.
> 

Yes, we should order alphabetically IMO. That way it looks good!

> >>>>   - reg: physical base address of the controller and length of memory mapped
> >>>>     region.
> >>>>   - clocks: Reference to the parent clocks ("hosc", "losc")
> >>>> @@ -15,9 +17,9 @@ Required Properties:
> >>>>   Each clock is assigned an identifier, and client nodes can use this identifier
> >>>>   to specify the clock which they consume.
> >>>> -All available clocks are defined as preprocessor macros in
> >>>> -dt-bindings/clock/actions,s900-cmu.h header and can be used in device
> >>>> -tree sources.
> >>>> +All available clocks are defined as preprocessor macros in corresponding
> >>>> +dt-bindings/clock/actions,s900-cmu.h or s700-cmu.h header and can be used in
> 
> actions,s700-cmu.h for humans please or at least ...,s700-cmu.h.
> 

actions,s700-cmu.h looks good to me.

Thanks,
Mani

> >>>> +device tree sources.
> >>>>   External clocks:
> 
> Thanks,
> Andreas
> 
> -- 
> SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
> GF: Felix Imendörffer, Jane Smithard, Graham Norton
> HRB 21284 (AG Nürnberg)
