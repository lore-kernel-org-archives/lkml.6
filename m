Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C38C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 20:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 739782150F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 20:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="kabsK+Xj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iOBstO1v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 739782150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbeHWXd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 19:33:56 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33046 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeHWXd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 19:33:56 -0400
Received: by mail-oi0-f66.google.com with SMTP id 8-v6so11501242oip.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 13:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=YbFcAooqKIQkjX78z70dLXSy3jhfHs8DUkm94R+mC/s=;
        b=kabsK+XjbLzUQfgCzUiFj6s4Deh067VT0vMEggRgsJlK6b7MbPPiKBCL2SaMAmxjpp
         0zy5sPZ2CGOuNCEDwOKX2Ho4OLn2Ok2yK0ueWKgvNtLHzwlzHgtcKg5kaJOwgxh+eGOw
         mQ6Miwfv3265CdkedwLUKa7f90Rr7aRmlWO+q8r4juR64UD5QMC8IXov3tWd/Dm4UUJL
         KrxpPKWjWLsjWY3NRUAAur3HtpPHQ4NP0FbsuQb/vGfm2o3b3zH55blJt+yvn1CdGJ1c
         Cj/qHOmuTe4WpQe6zZ1bfcGU14Bqc2pN50lQVoxvSy4rvpRd8oKksTJYxTmJolxBbMx+
         tOag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=YbFcAooqKIQkjX78z70dLXSy3jhfHs8DUkm94R+mC/s=;
        b=iOBstO1v4tefSfu7y8mX03WOrtqkusWzSjnZN3vZjjgN2C3H6pz5dd9EH7YW86NAYQ
         UOZM6KMN4tIMpC/btsVU2SAbeznh95pl9aL+ea8TP2l6gH5m1RtREoFOcrNVinXyEocO
         UPaqhRnkK9fagleOsz53eQcDk89O61czarp1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=YbFcAooqKIQkjX78z70dLXSy3jhfHs8DUkm94R+mC/s=;
        b=mZIP973u4Wn+Her8hwzDFFSliHNsZA+qXq+qqlV9n0+I3iWvVzIjdiG8VEqes6Q3Rs
         rwt2UP3VCXkvapiB7SMALbeujXRanZkw1NAxkObx4XtSGtaQHzpz0J8bEGk+Z3mwK6g+
         i9vkBSYafkGyiq4l7UMp1Wbc5pdEnkPTlinZosq43RpBsiDKAMSYgo5/8Q+B9k95ZGjz
         CBmX1oKP5UJI3cum5BBtBFTnmW7ZGsIpQHN37cpRXO+FoMJz7qINTTJxchGR2Khm1n1N
         4MHTP8LEM5gKQEcnrjm9luxLZAaQV4crIx/bnKGhl6n7G3BHUojMqLdibl8Kv591IWZo
         UokA==
X-Gm-Message-State: APzg51Bs7+PJ5lYJFisrXue15WwepLGaWymHeuc3YBI26CivGjcYM8QU
        VI/hrpDyHPLkLrE0fz47/jlGbZ9BgGgf5mvEhdgEAw==
X-Google-Smtp-Source: ANB0VdY+8SKJb7R0CjwZ5XDoL9Uc6DYnPkQMm4wq7Lmcbw6LGryHa8eW3mc28Oatlm3JQ7Nh/MOY12n1Rdo7RhedbRM=
X-Received: by 2002:aca:a6d4:: with SMTP id t81-v6mr9373921oij.113.1535054560194;
 Thu, 23 Aug 2018 13:02:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:190f:0:0:0:0:0 with HTTP; Thu, 23 Aug 2018 13:02:39
 -0700 (PDT)
In-Reply-To: <20180823153110.GA19131@e107155-lin>
References: <113f28acbc55f64762c9f0bcefe076a811f2ed82.1535014078.git.amit.kucheria@linaro.org>
 <20180823153110.GA19131@e107155-lin>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Fri, 24 Aug 2018 01:32:39 +0530
X-Google-Sender-Auth: DLyXIZgUNKrwo7Vtg5YVq2ppfCA
Message-ID: <CAHLCerNoRj6GQRF=NJXwc0U+mJNe=06JGADQr7uT-chD2W-J+A@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: Fix various entry-method properties to
 reflect documentation
To:     Sudeep Holla <sudeep.holla@arm.com>, arm@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Yuantian Tang <andy.tang@nxp.com>,
        Ran Wang <ran.wang_1@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Yuan Yao <yao.yuan@nxp.com>, Sumit Garg <sumit.garg@nxp.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Li Yang <leoyang.li@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Adding arm-soc folks)

On Thu, Aug 23, 2018 at 9:01 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> Hi Amit,
>
> Thanks for fixing this.
>
> On Thu, Aug 23, 2018 at 02:23:29PM +0530, Amit Kucheria wrote:
>> The idle-states binding documentation[1] mentions that the
>> 'entry-method' property is required on 64-bit platforms and must be
>> set to "psci".
>>
>> commit a13f18f59d26 ("Documentation: arm: Fix typo in the idle-states
>> bindings examples") attempted to fix this earlier but clearly more is
>> needed.
>>
>
> In fact, I assumed I fixed things with commit 978fa436231a ("drivers:
> firmware: psci: unify enable-method binding on ARM {64,32}-bit systems"),
> but I was wrong. I left quite a few instances including juno dtbs.
>
>> Fix the cpu-capacity.txt documentation that uses the incorrect value so
>> we don't get copy-paste errors like these. Clarify the language in
>> idle-states.txt by removing the reference to the psci bindings that
>> might be causing this confusion.
>>
>> Finally, fix devicetrees of various boards to reflect current
>> documentation.
>>
>> [1] Documentation/devicetree/bindings/arm/idle-states.txt (see
>> idle-states node)
>>
>> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
>> ---
>>  Documentation/devicetree/bindings/arm/cpu-capacity.txt | 2 +-
>>  Documentation/devicetree/bindings/arm/idle-states.txt  | 4 ++--
>>  arch/arm64/boot/dts/arm/juno-r1.dts                    | 2 +-
>>  arch/arm64/boot/dts/arm/juno-r2.dts                    | 2 +-
>>  arch/arm64/boot/dts/arm/juno.dts                       | 2 +-
>
> For all the above files,
>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>

Thanks for reviewing, Sudeep.

> How do you plan to merge ? I prefer if you can send it via arm-soc as
> fixes for this cycle with all the necessary acks. Otherwise you may have
> to split this to send via platform maintainers which is bit mundane.

I was hoping to get this merged thru arm-soc tree instead of creating
a patch per platform. But if anybody feels strongly about it, I'm
happy to split them up and feed it through the platform maintainer
trees.

Regards,
Amit
