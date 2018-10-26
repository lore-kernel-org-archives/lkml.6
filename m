Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F976ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 04:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28A4520834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 04:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gp7DcROv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28A4520834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbeJZMqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 08:46:31 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37761 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbeJZMqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 08:46:31 -0400
Received: by mail-pl1-f193.google.com with SMTP id bh10-v6so4864308plb.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 21:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cVqDWZHaQMK6td6YKcxbezDFIcxCuYuotLzpYFI+QS4=;
        b=Gp7DcROvFOl2Zh4H39GutIKwlHkXGEygXPZVsz2oIjQubz/g1dzOpOew6QHUifPtwk
         4TMLHQuqjANudimlyNDNyjTT8NVxc767jrElVsBiscw1wudmxYkud7xap476l/PohB3E
         H7VAm0rBYwTzySkRKrDuF6AdiyMRdmllnXxTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cVqDWZHaQMK6td6YKcxbezDFIcxCuYuotLzpYFI+QS4=;
        b=SNiitXSpn/ZiTsClZ6WX9vUdGXNd8uBwePTlXu9zZ6F1KYYopapPmRF9mCdWXgLs6J
         CkLPf9yuIjNXxi8FViQddfprdetQSCf6G0p3jIyVgPMEuAjcgIvdnTlELMyQ1UYKO5it
         rQs+6xPq0YfBrFCbRX1YNGHf3dylgb2wLzGJm8JtmWk/LTr2cL28WJ66nAZC5AKFaUhU
         6PoFi0SxODbitaVDcXu1TAUjOGUa3oKLhW30IlFCWBFosZnjW4Xu7LmAZ3O002nP7OSa
         RezuoK2Wq1CF01Zwng2KzAd8lqxuH+7bqKubSEJiNxkdSoKZi0Vuad6rIxZ5PX3wmjdS
         eKSw==
X-Gm-Message-State: AGRZ1gJD3kX6N1f9yhA4pFFAK3shgyToCl0qoP/aVTGd0V8WQvQEUpfx
        VWmUazLNgdAWDGNRDE2fF8A3Zg==
X-Google-Smtp-Source: AJdET5eB4PHW0NVhJD51VW83zkccXPfm4mAySR5FkO4fPjgNpzx5fTPPfSeKIeJ02s6UsMv1Dq9Qbg==
X-Received: by 2002:a17:902:744a:: with SMTP id e10-v6mr1965752plt.61.1540527071685;
        Thu, 25 Oct 2018 21:11:11 -0700 (PDT)
Received: from localhost ([122.172.217.9])
        by smtp.gmail.com with ESMTPSA id s13-v6sm22281717pgs.76.2018.10.25.21.11.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 21:11:09 -0700 (PDT)
Date:   Fri, 26 Oct 2018 09:41:07 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     catalin.marinas@arm.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: arm: Fix cpu capacity mismatch in example
Message-ID: <20181026041107.4hofhlcubbo5claq@vireshk-i7>
References: <138600f5d504b41202a29a1e130a7aa4e51f1925.1540451976.git.viresh.kumar@linaro.org>
 <80206cb7-b550-1cf6-abf4-e4b17de4cdb5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80206cb7-b550-1cf6-abf4-e4b17de4cdb5@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-10-18, 14:04, Daniel Lezcano wrote:
> I think it is actually correct. The example is confusing on what the
> numbers are. IIUC, it is:
> 
> (after normalizing)
> 
> dhrystone result on big CPU is 1024 at 1100MHz
> dhrystone result on little CPU is 446 at 850MHz
> 
> We have to scale the result of the little for 1100MHz in order to compare.
> 
> 1100/850 = 1.294
> 
> dhrystone result on little CPU is 446 * 1.294 = 577 at 1100MHz
> 
> So we put the normalized values 1024 and 577. The arch_topology will
> scale 577 back to 446 as it will compute the max capacity based on the
> max freq which is 850MHz.
> 
> The *final* capacities are 1024 for cluster0 and 446 for cluster1 (read
> the cpu max capacity, the ones showed in the sysfs).
> 
> Did I miss something ?

No. What about making it more clear in the example to save the next idiot (like
me) from wasting time :)

diff --git a/Documentation/devicetree/bindings/arm/cpu-capacity.txt b/Documentation/devicetree/bindings/arm/cpu-capacity.txt
index 9b5685a1d15d..d061e6575bde 100644
--- a/Documentation/devicetree/bindings/arm/cpu-capacity.txt
+++ b/Documentation/devicetree/bindings/arm/cpu-capacity.txt
@@ -61,7 +61,10 @@ mhz values (normalized w.r.t. the highest value found while parsing the DT).
 Example 1 (ARM 64-bit, 6-cpu system, two clusters):
 capacities-dmips-mhz are scaled w.r.t. 1024 (cpu@0 and cpu@1)
 supposing cluster0@max-freq=1100 and custer1@max-freq=850,
-final capacities are 1024 for cluster0 and 446 for cluster1
+final capacities are 1024 for cluster0 and 446 for cluster1.
+Note that the values mentioned below in the example (1024 and 578)
+aren't normalized based on max frequency of each cluster and that is
+left for the operating system to do.
 
 cpus {
        #address-cells = <2>;

-- 
viresh
