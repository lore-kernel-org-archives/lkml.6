Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB130ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 13:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AD862150B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 13:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UXA73YXS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AD862150B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731791AbeISSqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 14:46:16 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42238 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730876AbeISSqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 14:46:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Q+n0GwVBprGByy3RVkbfyKiEKph3Um/+8ViwA64vn3c=; b=UXA73YXSyHclmaYHI5IA4i9fb
        ZNgwPndGZN1UfTQ5zenDVQEfJzLcZLTRNPfIHww+OEWG25f1vMg1smjt66jYjI5UxhggowwHPc1fq
        NkwDRsaELjs9nJCmiIsrTNarlytZP6PUYvMWVk2g5w/px8DPbXTdHeBm9L9l+FJBYEdaOaB4D7FkD
        BBMZeyNEqyy95pVwinJrt/FlAAxkKlXTATGHOYeApTz2PglHeG/TiAHraPhEE5bCAdQwWwj8LysO+
        0JEYAHnFpFVQIUfxeoYvXuD6gEkd96+mGZ++2OisDSlL/VFBqFGnokmo4ZGHemu6YTve7keX2egdT
        4fQFpfh9g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2cD9-0002ht-7J; Wed, 19 Sep 2018 13:08:07 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 269842024E441; Wed, 19 Sep 2018 15:08:03 +0200 (CEST)
Date:   Wed, 19 Sep 2018 15:08:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH v3 0/9] add support for relative references in jump tables
Message-ID: <20180919130803.GH24124@hirez.programming.kicks-ass.net>
References: <20180919065144.25010-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919065144.25010-1-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 11:51:35PM -0700, Ard Biesheuvel wrote:

> Ard Biesheuvel (8):
>   kernel/jump_label: abstract jump_entry member accessors
>   kernel/jump_label: implement generic support for relative references
>   arm64/kernel: jump_label: switch to relative references
>   x86: add support for 64-bit place relative relocations
>   x86: jump_label: switch to jump_entry accessors
>   x86/kernel: jump_table: use relative references
>   jump_label: annotate entries that operate on __init code earlier
>   jump_table: move entries into ro_after_init region
> 
> Heiko Carstens (1):
>   s390/jump_label: switch to relative references

This all looks good to me;

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Ingo, could you queue this?
