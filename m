Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33F3C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 23:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66FF3262DC
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 23:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n0ZlcAXP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66FF3262DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934119AbeFYXve (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 19:51:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44536 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932457AbeFYXvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 19:51:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3A9VXHaUylH0z45s0b8QpbmmG37FwjCKyaRxsUrM0qM=; b=n0ZlcAXPl8IBY/76vhH0aafgX
        bK5W4dr1inUIWnv/8+scgdh8hDUytz+RXMv1273XLx6x1TUB9ecODeNjxg96Z8GuMXlof1j4umnTR
        8olsil7ehV40D1vtn/mdo3XF0k1vocYNTJHwEiqzCNTSAEmFFFGgomBN1jqlz7d4Xmn4btM+I360f
        XIdVEqxSdy9toNuTs96OZOj9qJipxQP9+i0cbf+beHLF/q4hf9ts/WQNN5cAANBzrChwNPX0BK4Th
        l6vdtx2kppoyTaFwiMtsq/PF3ctTxstxtEzyY0UxBPnxGnq/+EkjSGHFNTKp1UPefuB6dmh/F01px
        oJKpUIJYQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fXbGe-0007EK-4t; Mon, 25 Jun 2018 23:51:32 +0000
Subject: Re: [PATCH v5 23/27] x86/modules: Adapt module loading for PIE
 support
To:     Thomas Garnier <thgarnie@google.com>,
        kernel-hardening@lists.openwall.com
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Francis Deslauriers <francis.deslauriers@efficios.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, linux-kernel@vger.kernel.org
References: <20180625224014.134829-1-thgarnie@google.com>
 <20180625224014.134829-24-thgarnie@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c2c67217-e120-468b-b59a-05813a64c448@infradead.org>
Date:   Mon, 25 Jun 2018 16:51:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180625224014.134829-24-thgarnie@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/25/18 15:39, Thomas Garnier wrote:
> Adapt module loading to support PIE relocations. Generate dynamic GOT if
> a symbol requires it but no entry exists in the kernel GOT.

Hi,

This patch description (and a few others with the same sentence) is a little
confusing to me:

> Position Independent Executable (PIE) support will allow to extend the
> KASLR randomization range 0xffffffff80000000.

Is there a word missing after "range"?  May "below"?
As is, it seems to imply "range by 0xffffffff80000000."


thanks.

> 
> Signed-off-by: Thomas Garnier <thgarnie@google.com>
> ---
>  arch/x86/Makefile               |   4 +
>  arch/x86/include/asm/module.h   |  11 ++
>  arch/x86/include/asm/sections.h |   4 +
>  arch/x86/kernel/module.c        | 181 +++++++++++++++++++++++++++++++-
>  arch/x86/kernel/module.lds      |   3 +
>  5 files changed, 198 insertions(+), 5 deletions(-)
>  create mode 100644 arch/x86/kernel/module.lds


-- 
~Randy
