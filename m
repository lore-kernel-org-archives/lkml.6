Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FDBECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 05:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ADA8208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 05:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SCpufbZ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ADA8208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730841AbeISLXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 07:23:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47844 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbeISLXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 07:23:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=w769l4DryJliqbkOTaEVzA0wJSaoPb4GMWS0wvpxOkQ=; b=SCpufbZ4N3LlXlQhJFV7944+d
        5YnWZ/xsKsE4YXhYnnRdewRObIt3Xb/ABKN4EpJ/zKN+HVQvFwMvFmAyf54AURAHzvjk6netknugk
        xxHzTiqs2q4EMW1tHrke4Oqz73YSjrT9nqv9ppiBWg7l44njuYN2IsvWPcfgm5NBvPa81ItH2TBB8
        +RaX0scDkQsm1yQH8nptHZOMB+n7rdCbSk0qMKd8CRaqyPa/tpFKcJUyB9PDGeU0ODRudXZWAvhYf
        /VPWMCCRPcYhf5/EMaIuRMXb8vBXXCqj2pKBdtB0q95SGjRcsVf4khEz5K9oNi0+wMgkXtwd07ys/
        FpakRsJww==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2VK9-0003Vd-QR; Wed, 19 Sep 2018 05:46:53 +0000
Date:   Tue, 18 Sep 2018 22:46:53 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org
Subject: Re: [REVIEW][PATCH 02/20] signal/x86: Inline fill_sigtrap_info in
 it's only caller send_sigtrap
Message-ID: <20180919054653.GA32263@infradead.org>
References: <87y3bzk6yv.fsf@xmission.com>
 <20180918000546.12552-2-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918000546.12552-2-ebiederm@xmission.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  
>  	clear_siginfo(&info);
> -	fill_sigtrap_info(tsk, regs, error_code, si_code, &info);
> +	tsk->thread.trap_nr = X86_TRAP_DB;
> +	tsk->thread.error_code = error_code;
> +
> +	info.si_signo = SIGTRAP;
> +	info.si_code = si_code;
> +	info.si_addr = user_mode(regs) ? (void __user *)regs->ip : NULL;

clear_siginfo already zeroes the whole structure, so this could be
written more clearly as:

	if (user_mode(regs)
		info.si_addr = (void __user *)regs->ip;
