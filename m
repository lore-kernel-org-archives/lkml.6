Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3AC1C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3BF520849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WZt/lpk1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3BF520849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbeLKL11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 06:27:27 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36520 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbeLKL10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 06:27:26 -0500
Received: by mail-pg1-f195.google.com with SMTP id n2so6507806pgm.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 03:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SA9o5mAjw2q28kPC9SbbnqGe1fygAS1n3wV7jQYTufA=;
        b=WZt/lpk1msibE5YcbQq0X/K7tRpJXNf/VtJB3gEWFGXIkxCTebWnM+w5EwMRaXMwvR
         p35usD2ij8+vBmMG+lv/XscEihhRnb69+yncip7koNmmTZE14H/217zN5qOugZQ59JCn
         URWc6IcC+oHnDYWdUlXnYIjbKW3rgaIAGf0bA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SA9o5mAjw2q28kPC9SbbnqGe1fygAS1n3wV7jQYTufA=;
        b=iHr2ox3huNEhWHsZTNTldAYZjkdh1FiPyew/yyT5X3dK12CGeYRmylxI0g8tMPQS18
         RESmv9mIRFPU6Wv+Z5UhDAMScDKHd9RPyTkoWL8tfu4CeaEUtF65eYMiwyi+QIug+vCy
         5rQz4MIJMph3ijvfIpzrgXrBCEUhfq7kssREnjxwu+4Ll1A4+NqyB5KnZZHfbMivIWbk
         S0kfcF8ZCnR8UD7Y4Lu/jQjeu4Em5bJ7DC3u4UapGYVb0kMVe/DLoEIscd5IgaoBNJg0
         qzjbAE479Vi+3+1fW5m3z3yWqCkNlFq3d6e7E7pUgOrRpXgTr0lGyNK7tzs0sCUFBGkb
         fOUQ==
X-Gm-Message-State: AA+aEWaIXZI77uqCLNkltrDYkBvG+zWDfymx98wHm4JFuwJ2QMWR0A7E
        Cydpn3g/aPSqnyVPELs7ME3UAA==
X-Google-Smtp-Source: AFSGD/UjAX0zYrGxVmy34PJ2Vc8pMqDRl3RBtc8NzFiduW82rRDiq0GmueFPEtl+LEUMu+rM66OVNQ==
X-Received: by 2002:a63:8c2:: with SMTP id 185mr14559027pgi.26.1544527645357;
        Tue, 11 Dec 2018 03:27:25 -0800 (PST)
Received: from localhost ([122.172.23.29])
        by smtp.gmail.com with ESMTPSA id z7sm15100454pga.6.2018.12.11.03.27.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 03:27:24 -0800 (PST)
Date:   Tue, 11 Dec 2018 16:57:22 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] PM / OPP: Always expose one supply in debugfs
Message-ID: <20181211112722.vu2zrpcdw3ez3kag@vireshk-i7>
References: <20181210113247.11412-1-quentin.perret@arm.com>
 <20181210115410.clyrxhp5plptrf5n@queper01-lin>
 <20181211092549.2ydogec7bnlfokwy@vireshk-i7>
 <20181211094908.2dzmmzu6aq6cs4yn@queper01-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211094908.2dzmmzu6aq6cs4yn@queper01-lin>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-12-18, 09:49, Quentin Perret wrote:
> So, on Juno we do get voltage numbers from firmware, and those get
> registered properly in PM_OPP, exactly like for Hikey960. So it's
> probably the same problem in both cases.
> 
> FWIW, this is what I get on juno with my 'fix' applied:
> 
>   $ cat /sys/kernel/debug/opp/cpu0/*/supply-0/u_volt_target
>   820000
>   850000
>   900000
>   950000
>   1000000
> 
> > Anyway, this should still be fixed irrespective of the "cpu-supply" property.
> > The other fix you mentioned about setting opp_table->regulator_count to 1 is
> > actually the right thing to do but the fix may require changes at multiple
> > places. I can help writing a patch for that if you want, else I am open to you
> > giving it a shot :)
> 
> You'll definitely know the code better than me so if you have a patch in
> mind, please don't hesitate. I'll be happy to test it on my two boards
> here :-)

Sent some patches, please give them a try.

-- 
viresh
