Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48F4C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 524362085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ztu2q52G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 524362085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbeJKUyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 16:54:31 -0400
Received: from mail-pl1-f176.google.com ([209.85.214.176]:39581 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbeJKUyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 16:54:31 -0400
Received: by mail-pl1-f176.google.com with SMTP id w14-v6so4240039plp.6;
        Thu, 11 Oct 2018 06:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JbfUEr4vaso61qHEkCWSYw6kSROaQscqL9hCinhoEe4=;
        b=Ztu2q52GKRFXwMmBhtUrjoW1Q0pOtoF4yvO2fHXOycb9VI2wjb6gmvRXwlRDtV5fHR
         A+d8D1mythFz4+w6z8W4pEsq8g9p/11YtVJTMq0ONgGpZeSg4B7EZjciZMvRi3meYpWu
         wt0xhJDkYE8WJfJzZga+pKn9/TCYci8VpRNSK/rxCDyaA9knvl9dlRgZ9ue5sLw2VvRs
         0c6J52wUFbiSWVfjJV0V93eYLARiC98JNaM9sQ1U7aGAHOPeWkL6NlGxgGM3ocOWOdPT
         BLx3yW50Exm+zi66ZCk2D5HY9ROu24RlskxjqIvPMBTSL0KbAJnobIIGvzPHgWczxFTU
         DkJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=JbfUEr4vaso61qHEkCWSYw6kSROaQscqL9hCinhoEe4=;
        b=GuFJYDgzIGxBtWst8eoFVXqOb1bhRpsgW4PEcD9yo7l5Hq3CycDyYLpPU45jLXzoqy
         Wx8eu0/35/zpp9anVkfYm3Vzwg3+6TGRNiNeOnB2w+adMu7BnwE8J5FVICENgAJU92N5
         kNu6XDF0wf6Rs1qskz0OF3c8dLuo2UPNNYaltJJaKi8BpGIgwzeNlQOhUNPyvlTWR5cZ
         Bmzf+Jjg0lsdmp37hi5whZrNUOxJ1R564ZALvIZoqojKk92kMUDrX+v7qqwuX9BCOJPX
         XSwpEvhKNgMRbaXQiwXFuOz9e+s4m9HXXJulDkuKIEcLn8eutxicLgr74FuquuMTas02
         G3lQ==
X-Gm-Message-State: ABuFfogNz7B4PFDKjRYUhmrMRirR2xENjivhJKm9l2tPbJi7UsYLJCvi
        LB2N/psXb9ImyN/fDPzNNBO0DSUg
X-Google-Smtp-Source: ACcGV63Y4QAPkD2krLVPFpgVxcx99UKs3ZBvx5Khbx/9hM3yPw/D15t/JevZPt0HtMwLgENeQ3kW4w==
X-Received: by 2002:a17:902:e088:: with SMTP id cb8-v6mr1618524plb.31.1539264439135;
        Thu, 11 Oct 2018 06:27:19 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id o12-v6sm37651635pfh.20.2018.10.11.06.27.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 06:27:17 -0700 (PDT)
Date:   Thu, 11 Oct 2018 06:27:16 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Oct 11
Message-ID: <20181011132716.GA18892@roeck-us.net>
References: <20181011162343.17787168@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011162343.17787168@canb.auug.org.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 04:23:43PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20181010:
> 
> The crypto tree gained conflicts against the mac80211-next tree.
> 
> Non-merge commits (relative to Linus' tree): 9625
>  9096 files changed, 465434 insertions(+), 197078 deletions(-)
> 
> ----------------------------------------------------------------------------
> 

Build results:
	total: 135 pass: 123 fail: 12
Failed builds: 
	alpha:allmodconfig 
	arm64:allmodconfig 
	m68k:defconfig 
	m68k:allmodconfig 
	mips:allmodconfig 
	parisc:allmodconfig 
	powerpc:allmodconfig 
	powerpc:ppc6xx_defconfig 
	riscv:defconfig 
	s390:allmodconfig 
	sparc64:allmodconfig 
	xtensa:allmodconfig 
Qemu test results:
	total: 318 pass: 277 fail: 41
Failed tests: 
	arm:palmetto-bmc:aspeed_g4_defconfig:aspeed-bmc-opp-palmetto 
	arm:romulus-bmc:aspeed_g5_defconfig:aspeed-bmc-opp-romulus 
	...
	[39 more]

In addition to yesterday's failures, the above two qemu tests crash
silently, ie without console log. That means they crash before the
console is activated and I have not figured out how to get earlycon
to work.

Guenter
