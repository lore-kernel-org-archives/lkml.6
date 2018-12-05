Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29C0C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8933F20645
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HODZEPsJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8933F20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbeLESbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 13:31:42 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34231 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728316AbeLESb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 13:31:28 -0500
Received: by mail-ot1-f65.google.com with SMTP id t5so19620189otk.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 10:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KjQ36aVOOBWevKPNYjYvYEZ3HkAGFCzYyc8+nitudjg=;
        b=HODZEPsJ2mBlftE+QcwCw0nZvVzc51kOFVZBWsGKgvVZM/Wf37V4EEWJvwO9JktX5v
         tMNAF+vO3otnGV/CwrK71a2M1bGHDgviX97ple1P2LaZ10h007uY8X3vgG+3RQ5Sh6NU
         jV+09eLwY2HYYcxQm8coOal9AmpKqbciK/inM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KjQ36aVOOBWevKPNYjYvYEZ3HkAGFCzYyc8+nitudjg=;
        b=rc+94ZUa0u0Zho6w0ito4IW2BGQmZT4K3mJ/OJf+7UoKuoBUf94d33t/5jm9vRl2Fp
         geMXAtyzu9YhBMErj7Ghtn+zXfeAS2H2ggxsVDUsfhbG7rIH7sGwKsAPFlu+Fzb4OwHS
         dhye2R8zGlAJ5tCYOwAr/eE87KgcGBCXQNHfWWmhWRiSukYMPcKUBQEetjoRf+mn+ZN5
         H2K6P47FPxQ01dLIVD3Umm+xLHCjcVqjxm0XFZYAvWuzxg0TKBmrJbeAHA/Ii7uIUT/1
         xHCYNUoOKWWYu+uYGR89z7YOquQbaPDH3w9U4Tt+LNaHKR17R80AIB1n8+MgqwcC5ly7
         1ryQ==
X-Gm-Message-State: AA+aEWYWqhibyNtPo5fo4d7iYD7C30nBLmJ7taH0WlmrU/XTNc1XpodF
        7lQS5bQUbEO3Y96jl2LrbjZfaw==
X-Google-Smtp-Source: AFSGD/W0PEg+UScYa9ARunJVtqWLgGPe7FMOhDRUMPVP/U6OOSGnXTHRUvDUF0xRvQvjMrPLh1SROg==
X-Received: by 2002:a9d:63cd:: with SMTP id e13mr17155795otl.319.1544034687190;
        Wed, 05 Dec 2018 10:31:27 -0800 (PST)
Received: from localhost ([2600:1700:141:4960:545d:d91f:9ae0:9fd8])
        by smtp.gmail.com with ESMTPSA id l108sm8155569otc.23.2018.12.05.10.31.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 10:31:26 -0800 (PST)
Date:   Wed, 5 Dec 2018 12:31:25 -0600
From:   Andy Gross <andy.gross@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Kumar Gala <kumar.gala@linaro.org>, arm@kernel.org,
        Sean Hudson <darknighte@darknighte.com>,
        Frank Rowand <frowand.list@gmail.com>,
        David Brown <david.brown@linaro.org>,
        Grant Likely <grant.likely@arm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 22/34] dt-bindings: arm: Convert QCom board/soc
 bindings to json-schema
Message-ID: <20181205183125.GA5497@hector.attlocal.net>
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-23-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203213223.16986-23-robh@kernel.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 03:32:11PM -0600, Rob Herring wrote:
> Convert QCom SoC bindings to DT schema format using json-schema.
> 
> Cc: Andy Gross <andy.gross@linaro.org>
> Cc: David Brown <david.brown@linaro.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Andy Gross <andy.gross@linaro.org>
