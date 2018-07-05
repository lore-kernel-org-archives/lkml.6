Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171DDC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 01:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B282824148
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 01:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VPWjAu+K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B282824148
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932197AbeGEBLB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 21:11:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54876 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753345AbeGEBK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 21:10:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vwSYxBL3Az5OX2QisUQAEa7n4dL9e01VxnEnGviVHjY=; b=VPWjAu+K/bpxtwswhndojgmgR
        LN9996ru/kP1EvmhQOHZPMxBZA+yHUei3MXWnD1168qiqWfuQAQTkZ5cDXGSk1V4s/NTWNuCUucrl
        JhthhoC6NZzo6okDNItiwUb+Yu6RsZVb6CTXTsmE97rz49CDHiW7q7fQJve6FTRkVaP9REb+alm0/
        GQwZMZyi+CskeHvxY5o5rRhH27r5JbyJVbgCSYZFZhbkFhv1E4bonHNjWkceyqDbLuZzmnkydUNN9
        a6ira7+FWm26gYIUbZKr8GAYeFm+Vjb03Cjwd1QAcM/xFWpEok+IKN/AEUDmPu7JjJvsVeLDLqHzn
        wP4ZlkzCw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fasnR-00016F-QS; Thu, 05 Jul 2018 01:10:57 +0000
Subject: Re: [BUG] Serial/dma stall/failure after "dmaengine: fsl-edma:
 extract common fsl-edma code (no changes in behavior intended)"
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Angelo Dureghello <angelo@sysam.it>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
References: <CAJKOXPcVFrkEA4YV3gi-gPYhtTXHeKtv4CvL29gstfTacz2sMg@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0f3e3ba4-d9fc-ee66-23c2-319db48cd622@infradead.org>
Date:   Wed, 4 Jul 2018 18:10:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPcVFrkEA4YV3gi-gPYhtTXHeKtv4CvL29gstfTacz2sMg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/18 01:54, Krzysztof Kozlowski wrote:
> Hi,
> 
> The commit 6ad069123f03bebe4315dea13d44845854ca6043 ("dmaengine:
> fsl-edma: extract common fsl-edma code (no changes in behavior
> intended)"), even though marked as no changes in behavior intended...
> make serial console with DMA broken after boot. The console just hangs
> - is not responsive even to SysRq. Usually after finishing boot -
> before or after login prompt. Sometimes login is allowed and then it
> hangs during printing dmesg.
> 
> Board: Toradex Colibri VF50 (NXP VF500, Cortex A5, serial configured
> with DMA) on Iris Carrier.
> 
> Commit found with bisect:
> git bisect start
> # bad: [bce40927669338cc4a361fc97d46bf650573ce5c] Add linux-next
> specific files for 20180704
> git bisect bad bce40927669338cc4a361fc97d46bf650573ce5c
> # good: [410da1e12ffed61129d61df5b7adce4d08c7f17c] net/smc: fix up
> merge error with poll changes
> git bisect good 410da1e12ffed61129d61df5b7adce4d08c7f17c
> # good: [decd57900d6fd743f7ddc1329400f4bd9cf54284] Merge
> remote-tracking branch 'crypto/master'
> git bisect good decd57900d6fd743f7ddc1329400f4bd9cf54284
> # good: [e9484bb660753ca8a35d219db000fff967b70a2c] Merge
> remote-tracking branch 'tip/auto-latest'
> git bisect good e9484bb660753ca8a35d219db000fff967b70a2c
> # bad: [20adee487b5f252d3f38197d43487c004273d3d0] Merge
> remote-tracking branch 'slave-dma/next'
> git bisect bad 20adee487b5f252d3f38197d43487c004273d3d0
> # good: [2df2577dce1d5fd98cac342fe857677a0556421b] Merge
> remote-tracking branch 'tty/tty-next'
> git bisect good 2df2577dce1d5fd98cac342fe857677a0556421b
> # good: [03b17ed8410a61f4f337c7bcfded1f744182edd5] spi: spi-fsl-dspi:
> Fix imprecise abort on VF500 during probe
> git bisect good 03b17ed8410a61f4f337c7bcfded1f744182edd5
> # good: [85e1d42663a0c163002961d2685be952067b0dc2] staging:
> mt7621-eth: Fix memory leak in mtk_add_mac() error path
> git bisect good 85e1d42663a0c163002961d2685be952067b0dc2
> # good: [b244f917acb7e1f492c40f6f4cf7be860a5065a5] staging: rtl8188eu:
> remove blank lines
> git bisect good b244f917acb7e1f492c40f6f4cf7be860a5065a5
> # good: [b244f917acb7e1f492c40f6f4cf7be860a5065a5] staging: rtl8188eu:
> remove blank lines
> git bisect good b244f917acb7e1f492c40f6f4cf7be860a5065a5
> # good: [b244f917acb7e1f492c40f6f4cf7be860a5065a5] staging: rtl8188eu:
> remove blank lines
> git bisect good b244f917acb7e1f492c40f6f4cf7be860a5065a5
> # good: [6c796f514b7f8d0fef4733b971a5ded9e9a74490] Merge
> remote-tracking branch 'staging/staging-next'
> git bisect good 6c796f514b7f8d0fef4733b971a5ded9e9a74490
> # good: [14dfa379ffd3ffd73729a72c289e9db6780a60ab] Merge branch
> 'topic/ste' into next
> git bisect good 14dfa379ffd3ffd73729a72c289e9db6780a60ab
> # good: [c1199875d327a9b3bbb3fb1cca0d467d3e625fbb] dmaengine:
> imx-sdma: Use GFP_NOWAIT for dma allocations
> git bisect good c1199875d327a9b3bbb3fb1cca0d467d3e625fbb
> # bad: [15efb0b488596a929bc00ce23aeb746ee6a7c14d] dmaengine: fsl-edma:
> fix trailing whitespace
> git bisect bad 15efb0b488596a929bc00ce23aeb746ee6a7c14d
> # bad: [5c1355ad87a2c138049bfafa753b44046492aebc] dmaengine: fsl-edma:
> add ColdFire mcf5441x edma support
> git bisect bad 5c1355ad87a2c138049bfafa753b44046492aebc
> # bad: [6ad069123f03bebe4315dea13d44845854ca6043] dmaengine: fsl-edma:
> extract common fsl-edma code (no changes in behavior intended)
> git bisect bad 6ad069123f03bebe4315dea13d44845854ca6043
> # first bad commit: [6ad069123f03bebe4315dea13d44845854ca6043]
> dmaengine: fsl-edma: extract common fsl-edma code (no changes in
> behavior intended)
> 
> Defconfig and boot log attached. I could not find any obvious error in boot log.
> 
> Let me know if you need more data.
> 
> Best regards,
> Krzysztof


BTW, there is also this warning in linux-next:
WARNING: modpost: missing MODULE_LICENSE() in drivers/dma/fsl-edma-common.o


-- 
~Randy
