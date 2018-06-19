Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11729C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B49D02083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aFKn/sFb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B49D02083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937471AbeFSJV3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 05:21:29 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:42115 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937314AbeFSJV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 05:21:26 -0400
Received: by mail-pf0-f194.google.com with SMTP id w7-v6so9625488pfn.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 02:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZCw6JnLVp05/7RW+Ta+9/QzQDzLLCOO4Hjg0AvR0vlE=;
        b=aFKn/sFbA8vssGXGdcH6CSO2lC7PVb4T3lxZPK1LdUt/oixb8RmbGmj+zlnoOa9ceJ
         zSpFu3uyB/lGqQFzwgjtTYZQJ6hq/hlx+yD2QuHDgZMt3HOjLai08UGZP2j31MGF0WlB
         oS5idkUjxUVBMI94A1gmHBsJPTd+CEeDdLBEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZCw6JnLVp05/7RW+Ta+9/QzQDzLLCOO4Hjg0AvR0vlE=;
        b=eABduRymt4DuzqRpgW32mzsVY3bX/5WDExXa9AaYDSXEH/p2GSJiQOCVucpA74tE/R
         aoQiIfyIkeSvZrnQBWFie8FJ0AlGKmkMhm5IMV1DBF4t31pGExrpXjUg+QB68dN9WbcF
         oatNDaUEhF8cudYOomDgi/PdtHYZkQ8LVNG4Mxl/dSKBcHIg/Saf0n1tCpwewHlJeBwV
         Cg7bJ0wUa64iyiq8MaIxF2vPZhjm/1TVTnAIm2H+Zk7T1w7eqox0yo9dEIoGSnX9k4j8
         JJzlP913HgAfCPaudyXaKPV8K5DTRfPT4nrj9s95KClcnfxV49Epqcq+HaHIG2G7qGXe
         ejDA==
X-Gm-Message-State: APt69E3evs7ln/DVUS3Of9wj9v/yWadEpJrs6aA/434FnbcAqjNQjhDp
        WFzBulkbI0Cn5U8C+0RSl4JAuA==
X-Google-Smtp-Source: ADUXVKKg3G2R0ZNsY0FdfvMsspslSM0IrtL9HefHVCGZcoBo37EFEPj5Mxqe/GQ3iJUeMMWoiKKG5A==
X-Received: by 2002:aa7:854e:: with SMTP id y14-v6mr16947949pfn.165.1529400085158;
        Tue, 19 Jun 2018 02:21:25 -0700 (PDT)
Received: from localhost ([122.171.103.96])
        by smtp.gmail.com with ESMTPSA id q8-v6sm37363690pfi.96.2018.06.19.02.21.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 02:21:24 -0700 (PDT)
Date:   Tue, 19 Jun 2018 14:51:22 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ FW
 bindings
Message-ID: <20180619092122.ul56qnh5uangti3e@vireshk-i7>
References: <1528801355-18719-1-git-send-email-tdas@codeaurora.org>
 <1528801355-18719-2-git-send-email-tdas@codeaurora.org>
 <0f3f0223-3539-dc66-5300-8f30d827445d@arm.com>
 <7abb2da6-c130-117a-5404-d07bb132d915@codeaurora.org>
 <f57f2708-28bb-dcdd-8b93-d41ade10fa18@arm.com>
 <bc6dc152-7def-fc1d-4535-11a44fd64310@codeaurora.org>
 <CAHLCerMCM1qf1MJ3bz+ZwBQMjshKSCWKXjHCiuqxJTDBdauamQ@mail.gmail.com>
 <32e8f874-a58b-8ba3-7a53-dc89cb34f7d9@codeaurora.org>
 <fad24065-bb2d-33f9-e877-425db3391e8f@arm.com>
 <514eea88-1f98-7959-2341-3d57cff6f66b@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <514eea88-1f98-7959-2341-3d57cff6f66b@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-06-18, 13:23, Taniya Das wrote:
> Driver code (The below representation is just for example).
> =============
> 
> V1
> #define ENABLE	0x0
> #define LUT_V1	0x110
> #define PERF_V1	0x920
> 
> V2
> #define LUT_V2	0x150
> #define PERF_V2	0x980
> 
> V3
> #define LUT_V3	0x120
> ....
> 
> Do you want me to use "compatible" flag to
> 
> if (compatible == v1)
>  enable =  readl_relaxed(X + LUT_V1);
> else if (compatible == v2)
>  enable = readl_relaxed(X + LUT_V2);
> else if (compatible == v3)
>  enable = readl_relaxed(X + LUT_V2);

You can have fields in a struct somewhere like enable_offset, which you can fill
based on compatible string only once during probe and then the rest of the code
would just do:

enable = readl_relaxed(X + struct->enable_offset);

-- 
viresh
