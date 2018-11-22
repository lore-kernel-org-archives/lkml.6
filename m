Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB0EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D409520672
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxKzEiRN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D409520672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405593AbeKVXj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 18:39:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:37814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732044AbeKVXj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 18:39:57 -0500
Received: from linux-8ccs (charybdis-ext.suse.de [195.135.221.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBC2520672;
        Thu, 22 Nov 2018 13:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542891642;
        bh=X4Kd43W1JqD6e8K4KzxA1DpiPGFGDPAhZU5tykSWXpc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YxKzEiRNcSSTVQ370yXvNUeJjcvvK410JA2oJKs6MFeSEApWmDWcRVqL4kC2LSBnh
         ZGKFnOwIM5+m+IaVGG/R3HYaL3RKQR8aOY2ikHejfEsFM//W2ZTqSpLUjZi+j0XLmj
         gZSl0MGahEPj4V89yRV2zOyh++wIzl1R8AOHm1rM=
Date:   Thu, 22 Nov 2018 14:00:39 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: make it clearer when we're handling kallsyms
 symbols vs exported symbols
Message-ID: <20181122130038.GA21394@linux-8ccs>
References: <20181121175116.30025-1-jeyu@kernel.org>
 <alpine.LSU.2.21.1811221109220.6711@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.1811221109220.6711@pobox.suse.cz>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.22-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Miroslav Benes [22/11/18 11:19 +0100]:
>On Wed, 21 Nov 2018, Jessica Yu wrote:
>
>> The module loader internally works with both exported symbols
>> represented as struct kernel_symbol, as well as Elf symbols from a
>> module's symbol table. It's hard to distinguish sometimes which type of
>> symbol we're handling given that some helper function names are not
>> consistent or helpful. Take get_ksymbol() for instance - are we
>> looking for an exported symbol or a kallsyms symbol here? Or symname()
>> and kernel_symbol_name() - which function handles an exported symbol and
>> which one an Elf symbol?
>>
>> Clean up and unify the function naming scheme a bit to make it clear
>> which kind of symbol we're handling. This change only affects static
>> functions internal to the module loader.
>>
>> Signed-off-by: Jessica Yu <jeyu@kernel.org>
>
>Great. It should help a lot. Pity we cannot rename find_symbol() as well.
>
>I have only a naming nit. I think it is nice to have
><verb>_exported_<noun> convention. New kallsyms_ names don't hold it
>though. Wouldn't it be better to be consistent and have
>find_kallsyms_symbol() instead of kallsyms_find_symbol()? Or we could do
>the opposite and have a "namespace" prefix first. That is,
>exported_<verb>_<noun>. However, I don't like it that much.
>
>To be honest, your approach may be the best in the end.
>
>What do you think?

Hi Miroslav, thank you for the comment!

Yeah, that bothered me partially too. And a lot of existing helper
functions in the module loader already have a <verb>_ type prefix.

Hm, how about we use <symbol_type>_* prefixes if we are just extracting a
value, and <verb>_* prefixes for functions actually performing an
action? 

Kallsyms:

   kallsyms_symbol_name()
   kallsyms_symbol_value()
   
   find_kallsyms_symbol()
   find_kallsyms_symbol_value()
 
   etc.

Exported syms:

   kernel_symbol_name()
   kernel_symbol_value()
   
   lookup_exported_symbol()
   check_exported_symbol()
 
   etc.

I had left the kernel_symbol_* functions alone since I guess they do
describe what they're handling, they're handling struct kernel_symbol's.
But maybe I will change that to exported_symbol_name() and
exported_symbol_value() to be consistent with the naming scheme..

Thanks!

Jessica    
