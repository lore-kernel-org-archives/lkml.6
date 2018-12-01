Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A020C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 10:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31EB62082F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 10:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z9xI8jRp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31EB62082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbeLAVjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 16:39:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44424 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbeLAVjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 16:39:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RC0XMj7cBuZY2h/Jo1Y0YJW7oIzCTo3QMi4CINewp8U=; b=Z9xI8jRpwyXNaS/kPfwOXrbR7
        O4C1SAAuCYg9mh63J7iSF+KKBeObVZfZAbiGIC9acCtOCipVT81vBuVwzgDCPwgAq4di60oigZ1Ez
        3gwZ/BGHyE+3xkbexTvfcNW70x3UYCG2fin6UelwxwfqlJud1vooD0ewI5XLTu2TImmh1mG6hPH/D
        pghbJ5ei0tZziz+ZFrPRGxSHLPO3ZG5i9lyNOPv3wtCH15aCF7m4WzV25/q74FjSzVUC4+RtMq8c9
        615LqjQhqI3MpJy9KOa+5Fihn5Zagp1KrVk+KhGqjk6uiOHU6a2RDHYUFB9ltpiz/5GFI1/oU4InB
        JcLrdruLg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gT2Up-0002eI-FF; Sat, 01 Dec 2018 10:27:35 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E6AA82029FD58; Sat,  1 Dec 2018 11:27:32 +0100 (CET)
Date:   Sat, 1 Dec 2018 11:27:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     tglx@linutronix.de,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, stable@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] x86/mm: Drop usage of __flush_tlb_all() in
 kernel_physical_mapping_init()
Message-ID: <20181201102732.GE11614@hirez.programming.kicks-ass.net>
References: <154362450646.2367148.16448130381211111341.stgit@dwillia2-desk3.amr.corp.intel.com>
 <154362453268.2367148.268782514142834053.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154362453268.2367148.268782514142834053.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


A small nit:

On Fri, Nov 30, 2018 at 04:35:32PM -0800, Dan Williams wrote:

> [1]: https://lore.kernel.org/lkml/9DFD717D-857D-493D-A606-B635D72BAC21@amacapital.net
> [2]: https://lore.kernel.org/lkml/749919a4-cdb1-48a3-adb4-adb81a5fa0b5@intel.com

I much prefer the form:

  https://lkml.kernel.org/r/${msgid}

over the direct lore links. Luckily both contain the full msgid which is
the important part.

(I still think lore has a horrible UI)
