Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0851FC5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B90C0208E2
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbqGtuc3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B90C0208E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933393AbeGISeQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 14:34:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:38708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932607AbeGISeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 14:34:15 -0400
Received: from redbean (ip5f5adbb9.dynamic.kabel-deutschland.de [95.90.219.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22EE6208DE;
        Mon,  9 Jul 2018 18:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531161254;
        bh=IYDA+MRTAVOEPn6c6Ha5ZyNs5AVyGuc9B6qLAMBHdAc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RbqGtuc3Jorangbu9omoV3cvbhUEts2iBZWJaNBSfuL+RMutdKtniy4aRLqjoqoWO
         Zf2uKBqnW8GpvqkoU3VwL8EWxA/I6m355Lndd7EiyiWK4ISdPEpzyF6cXr+Wh+qFDE
         CHBOs4s0V8LUpbBdSc8j25uycHDqkqm5G3pQREI4=
Date:   Mon, 9 Jul 2018 20:34:09 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: module: fix modsign build error
Message-ID: <20180709183409.34ir5xkulil7drn2@redbean>
References: <20180706124900.3294525-1-arnd@arndb.de>
 <20180706130055.GY17271@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180706130055.GY17271@n2100.armlinux.org.uk>
X-OS:   Linux redbean 4.16.11-100.fc26.x86_64 x86_64
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Russell King - ARM Linux [06/07/18 14:00 +0100]:
>On Fri, Jul 06, 2018 at 02:48:47PM +0200, Arnd Bergmann wrote:
>> The asm/module.h header file can not be included standalone, which
>> breaks the module signing code after a recent change:
>>
>> In file included from kernel/module-internal.h:13,
>>                  from kernel/module_signing.c:17:
>> arch/arm/include/asm/module.h:37:27: error: 'struct module' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
>>  u32 get_module_plt(struct module *mod, unsigned long loc, Elf32_Addr val);
>>
>> This adds a forward declaration of struct module to make it all work.
>>
>> Fixes: f314dfea16a0 ("modsign: log module name in the event of an error")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
>We used to have a general rule that where an asm/foo.h header and
>linux/foo.h header exists, and the linux/foo.h includes the asm/foo.h,
>then the linux/foo.h header will be used for including in .c files
>rather than the asm/ version of the same.  Is there a reason why
>that can't be done here?

Generally yes, it's just that in this case module_signing.c neither
needs nor includes linux/module.h. The needed load_info struct
definition just requires definitions for Elf_[SPE]hdr, Elf_Addr,
Elf_Sym, etc. and those are all defined in asm/module.h.

>That said, adding this is no bad thing.
>
>Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
>
>Thanks.

Thanks! Queued in modules-next.

Jessica
