Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA81C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 06:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1190F20880
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 06:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="A8k7lWIL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1190F20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729301AbeJ2PWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 11:22:11 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35584 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729225AbeJ2PWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 11:22:11 -0400
Received: by mail-pg1-f193.google.com with SMTP id 32-v6so3400820pgu.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 23:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Jx0MB7MBcu1BCD6tsP6EDyztDQ8GkQKUVdfsslKgv6g=;
        b=A8k7lWILzDQRmyAdo5scv7k+gQdt5b77yWZQPSO9+QNG70PEw+B4R1kdB5Dfd90wVH
         0gsNxkfzGvfUOE7SN+65OfKj0iQjy1Knko6N1q8eZGQ0+aeGZtZ7DfNEz4PtpAK8SKyY
         LrPuchM5WTFDIa7O0fYqgnBnH32hhI8oCrTBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Jx0MB7MBcu1BCD6tsP6EDyztDQ8GkQKUVdfsslKgv6g=;
        b=DtR75IZtezLpcJyJm1yfjCNUzg0dz4TrVvEaLSP3nUnw3gIuDstDmje/kjNI6mHUIG
         pEKrlCFKCQnn6F3hnkzHLjnKu+TiHkZtWhn0GBrecgl2YZY3pbq3kw2qCaXVRz6Cvhby
         ttZjKIUxmLxCajqbLDWoX8rHqEumssEOSFJAaxGwL1Utfe5WU/hnvxgMmHeKpoJ/l61Y
         70aOtY3Vvi0KbxPDVdVzFLAZ81B6l8cVNCulVTNj+ZkaAKlZykGYxtcP/RICtUV723Hj
         mDTpP+iPXXJizaKOg101fioOXb+cJsBVw+Fb5YWj56tUaELSYGkmgiKkH3GCXDeu6iFm
         DUNg==
X-Gm-Message-State: AGRZ1gJLoZQRkKndcKch2/xFV+Cq9Vg59sqjZSZGhsHDtiIvcMzAuAEb
        GdK/rva1TnryhgHXbEk3mxF2rg==
X-Google-Smtp-Source: AJdET5dM9wf7wjuxZ4EQtTZtCSEtR1TtTmBPnLTV7utpGsGZGk7vbXIL6vegcbmb5HmJ5o/3BtFjVw==
X-Received: by 2002:a62:9015:: with SMTP id a21-v6mr13966798pfe.49.1540794894221;
        Sun, 28 Oct 2018 23:34:54 -0700 (PDT)
Received: from localhost ([122.172.56.94])
        by smtp.gmail.com with ESMTPSA id k72-v6sm38114501pfj.63.2018.10.28.23.34.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Oct 2018 23:34:52 -0700 (PDT)
Date:   Mon, 29 Oct 2018 12:04:50 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     catalin.marinas@arm.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: arm: Fix cpu capacity mismatch in example
Message-ID: <20181029063450.3o3ay7pazik5tgne@vireshk-i7>
References: <138600f5d504b41202a29a1e130a7aa4e51f1925.1540451976.git.viresh.kumar@linaro.org>
 <80206cb7-b550-1cf6-abf4-e4b17de4cdb5@linaro.org>
 <20181026041107.4hofhlcubbo5claq@vireshk-i7>
 <d4d6af05-61f1-4123-c2dc-4ee0946f79e8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4d6af05-61f1-4123-c2dc-4ee0946f79e8@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-10-18, 10:30, Daniel Lezcano wrote:
> On 26/10/2018 06:11, Viresh Kumar wrote:
> > On 25-10-18, 14:04, Daniel Lezcano wrote:
> >> I think it is actually correct. The example is confusing on what the
> >> numbers are. IIUC, it is:
> >>
> >> (after normalizing)
> >>
> >> dhrystone result on big CPU is 1024 at 1100MHz
> >> dhrystone result on little CPU is 446 at 850MHz
> >>
> >> We have to scale the result of the little for 1100MHz in order to compare.
> >>
> >> 1100/850 = 1.294
> >>
> >> dhrystone result on little CPU is 446 * 1.294 = 577 at 1100MHz
> >>
> >> So we put the normalized values 1024 and 577. The arch_topology will
> >> scale 577 back to 446 as it will compute the max capacity based on the
> >> max freq which is 850MHz.
> >>
> >> The *final* capacities are 1024 for cluster0 and 446 for cluster1 (read
> >> the cpu max capacity, the ones showed in the sysfs).
> >>
> >> Did I miss something ?
> > 
> > No. What about making it more clear in the example to save the next idiot (like
> > me) from wasting time :)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/cpu-capacity.txt b/Documentation/devicetree/bindings/arm/cpu-capacity.txt
> > index 9b5685a1d15d..d061e6575bde 100644
> > --- a/Documentation/devicetree/bindings/arm/cpu-capacity.txt
> > +++ b/Documentation/devicetree/bindings/arm/cpu-capacity.txt
> > @@ -61,7 +61,10 @@ mhz values (normalized w.r.t. the highest value found while parsing the DT).
> >  Example 1 (ARM 64-bit, 6-cpu system, two clusters):
> >  capacities-dmips-mhz are scaled w.r.t. 1024 (cpu@0 and cpu@1)
> >  supposing cluster0@max-freq=1100 and custer1@max-freq=850,
> > -final capacities are 1024 for cluster0 and 446 for cluster1
> > +final capacities are 1024 for cluster0 and 446 for cluster1.
> > +Note that the values mentioned below in the example (1024 and 578)
> > +aren't normalized based on max frequency of each cluster and that is
> > +left for the operating system to do.
> 
> Yes, it will help but if you want to make things even more clear, I
> suggest to elaborate the text a bit and give the numbers above to
> explain (1100/850=1.294, 446 * 1.294 = 577, ...)

I didn't wanted to explain way too much, but how about this..

diff --git a/Documentation/devicetree/bindings/arm/cpu-capacity.txt b/Documentation/devicetree/bindings/arm/cpu-capacity.txt
index 9b5685a1d15d..84262cdb8d29 100644
--- a/Documentation/devicetree/bindings/arm/cpu-capacity.txt
+++ b/Documentation/devicetree/bindings/arm/cpu-capacity.txt
@@ -59,9 +59,11 @@ mhz values (normalized w.r.t. the highest value found while parsing the DT).
 ===========================================
 
 Example 1 (ARM 64-bit, 6-cpu system, two clusters):
-capacities-dmips-mhz are scaled w.r.t. 1024 (cpu@0 and cpu@1)
-supposing cluster0@max-freq=1100 and custer1@max-freq=850,
-final capacities are 1024 for cluster0 and 446 for cluster1
+The capacities-dmips-mhz or DMIPS/MHz values (scaled to 1024)
+are 1024 and 578 for cluster0 and cluster1. Further normalization
+is done by the operating system based on cluster0@max-freq=1100 and
+custer1@max-freq=850, final capacities are 1024 for cluster0 and
+446 for cluster1 (576*850/1100).
 
 cpus {
        #address-cells = <2>;


-- 
viresh
