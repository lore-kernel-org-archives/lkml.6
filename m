Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B32C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 08:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1766270BD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 08:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dkpD5Tvq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1766270BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934955AbeF1IbU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 04:31:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41512 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933589AbeF1IbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 04:31:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8wshj8M6vE3K5HF83ZDUFF8rUGIgQu/KFjEighiAUnc=; b=dkpD5TvqFSFAqMMS3QAvkny1A
        JkFAwUG8Vr4yNh2HK6o2e5mSd9HIWT0uPXwDYW2YzfTrqinTi+F/dJck85431YoUJEsnUTcOGVIVN
        39N2hphF3/X2pqzmVQSt45n8aMhJb3wcZnU6vaKJ45oRuSC0pgLZUDd5DGmILEJ5NUnJi0p8Gs/zT
        B0QLo2ZucwAxuojPKAYZNmHnodAnwPF3jUzv1luquUwDXzCHeVz2OxDjz3H2Cui7RbQMlcge8jkb9
        CDAMLxPlPSxcpsySJlRgedK/TnW7P7Wovl7PM5SFXjQVE7NzwSShl7hE8H1fKwlVbj7h2CrRR28sI
        0XBM8MqLw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fYSKb-0006BQ-IW; Thu, 28 Jun 2018 08:31:09 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1EBBA20297645; Thu, 28 Jun 2018 10:31:07 +0200 (CEST)
Date:   Thu, 28 Jun 2018 10:31:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>, namit@vmware.com
Subject: Re: [PATCH 5/5] x86/kernel: jump_table: use relative references
Message-ID: <20180628083107.GY2494@hirez.programming.kicks-ass.net>
References: <20180627160604.8154-1-ard.biesheuvel@linaro.org>
 <20180627160604.8154-6-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627160604.8154-6-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 06:06:04PM +0200, Ard Biesheuvel wrote:
> Similar to the arm64 case, 64-bit x86 can benefit from using 32-bit
> relative references rather than 64-bit absolute ones when emitting
> struct jump_entry instances. Not only does this reduce the memory
> footprint of the entries themselves by 50%, it also removes the need
> for carrying relocation metadata on relocatable builds (i.e., for KASLR)
> which saves a fair chunk of .init space as well (although the savings
> are not as dramatic as on arm64)

This will conflict with:

  https://lkml.kernel.org/r/20180622172212.199633-10-namit@vmware.com
