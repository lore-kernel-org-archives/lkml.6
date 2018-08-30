Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD0DC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C5462054F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RGZwKuim"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C5462054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbeH3SkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:40:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37374 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729008AbeH3SkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:40:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Hjks0naNoBODbs4+AgLquXmnnAJh63N0IE0oKLsGxkM=; b=RGZwKuimR2h1fgCCOLqJU5BtI
        xApwLPF1rnODjQSfF2iDE0gyuImV8W3Ahz5WIglgcqm84VBaoo9P6tIbTo/PSxNHPPEY+Jzy8G/K+
        j2INZyOq7HAJd2L/PGg+dwTldXJ0ksMRUZAYWhO05FEmPfs5OAVivrq6rzu3F40W7uDcCV1nywvjf
        oBev8KQIwqSApodEdv9tn1hofWTPn2cwl8IfxZjcO0JyHq1g6ASENH4/z0jGy0lLdVmZSx3mfyaKB
        o6gZAMevYV/0ZfLOI71xzT4N0gSH6hgA0if3zzmuQFK1xh5tlsVZYgTm9E7nC0hrToqyuk/qsBcK6
        JVTtGUcjQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fvO4p-0005Fl-11; Thu, 30 Aug 2018 14:37:39 +0000
Date:   Thu, 30 Aug 2018 07:37:38 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     linux-riscv@lists.infradead.org, daniel.lezcano@linaro.org,
        jason@lakedaemon.net, ard.biesheuvel@linaro.org,
        marc.zyngier@arm.com, catalin.marinas@arm.com,
        dmitriy@oss-tech.org, jeremy.linton@arm.com,
        linux-kernel@vger.kernel.org, atish.patra@wdc.com,
        aou@eecs.berkeley.edu, Greg KH <gregkh@linuxfoundation.org>,
        tglx@linutronix.de
Subject: Re: [PATCH 1/8] RISC-V: Provide a cleaner raw_smp_processor_id()
Message-ID: <20180830143738.GC11544@infradead.org>
References: <20180827184243.25344-1-palmer@sifive.com>
 <20180827184243.25344-2-palmer@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827184243.25344-2-palmer@sifive.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 11:42:36AM -0700, Palmer Dabbelt wrote:
> +/* Obtains the hart ID of the currently executing task.  This relies on
> + * THREAD_INFO_IN_TASK, but we define that unconditionally. */

Kernel comment style would be:

/*
 * Obtains the hart ID of the currently executing task.  This relies on
 * THREAD_INFO_IN_TASK, but we define that unconditionally.
 */

> +#ifdef CONFIG_THREAD_INFO_IN_TASK

THREAD_INFO_IN_TASK is always defined for riscv, so no need for this
ifdef.

> +#define get_ti()                ((struct thread_info *)get_current())
> +#define raw_smp_processor_id()  (get_ti()->cpu)

Please don't cast structs around.  This should be something like

#define raw_smp_processor_id() \
	(container_of(get_current(), struct task_struct, thread_info)->cpu)
