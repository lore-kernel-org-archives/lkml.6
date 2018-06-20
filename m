Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D8BC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 22:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB036208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 22:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ards8LJN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB036208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754188AbeFTWo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 18:44:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52608 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753938AbeFTWo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 18:44:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gz6a9MAKUcUHj8vgXPbGcTLfhPrshJj7FYOD2kJNTEs=; b=Ards8LJN+SIbgZxsdgW+DVPFC
        v+CECLPhBClEWFPy3xukuj+0Z2jN23AhUGJUA1SU45NihHYBUxwiwBSL0CboJy+HlbocQo7jEPffb
        iAOfC2S8/cXFMQRD7sKhZEFzzCN2KKvKAVYQQ/I6y6N26wjNVRd46sANE7dEc95twUSIGSutiKQ04
        fdDDMloqLvPP2zzQIbTpiCq+aXobt9KyAy2Ljl0LUQvxTEZqW9HqcecG9PcpTLZTPCsjc/jZysNOI
        NvqKtJGMj5kWbGoV4v+3Bxdv05pfcjpp2RUNtzyr584yu9HQ22x0jafRyM6QzV0wr1AIo91o7tlCo
        1jRPgdqQA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVlqQ-0007RG-8j; Wed, 20 Jun 2018 22:44:54 +0000
Subject: Re: [PATCH 1/3] vmalloc: Add __vmalloc_node_try_addr function
To:     Kees Cook <keescook@chromium.org>
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        kristen Accardi <kristen.c.accardi@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>
References: <1529532570-21765-1-git-send-email-rick.p.edgecombe@intel.com>
 <1529532570-21765-2-git-send-email-rick.p.edgecombe@intel.com>
 <12014310-19f7-dc31-d983-9c7e00c8b446@infradead.org>
 <CAGXu5j+RgbMKqiBcsWMOZ-ci-rT19imgCoHtPKgDURF1tC+COg@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <778b2a1b-d810-815b-0fba-8a1d191acd49@infradead.org>
Date:   Wed, 20 Jun 2018 15:44:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5j+RgbMKqiBcsWMOZ-ci-rT19imgCoHtPKgDURF1tC+COg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/20/2018 03:35 PM, Kees Cook wrote:
> On Wed, Jun 20, 2018 at 3:16 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
>> On 06/20/2018 03:09 PM, Rick Edgecombe wrote:
>>> +void *__vmalloc_node_try_addr(unsigned long addr, unsigned long size,
>>> +                     gfp_t gfp_mask, pgprot_t prot, unsigned long vm_flags,
>>> +                     int node, const void *caller)
>>> +{
>>
>> so this isn't optional, eh?  You are going to force it on people because?
> 
> RANDOMIZE_BASE isn't optional either. :) This improves the module
> address entropy with (what seems to be) no down-side, so yeah, I think
> it should be non-optional. :)

In what kernel tree is RANDOMIZE_BASE not optional?

x86:
config RANDOMIZE_BASE
	bool "Randomize the address of the kernel image (KASLR)"
	depends on RELOCATABLE
	default y

mips:
config RANDOMIZE_BASE
	bool "Randomize the address of the kernel image"
	depends on RELOCATABLE

arm64:
config RANDOMIZE_BASE
	bool "Randomize the address of the kernel image"
	select ARM64_MODULE_PLTS if MODULES
	select RELOCATABLE


thanks,
-- 
~Randy
