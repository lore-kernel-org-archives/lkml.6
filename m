Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D22C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 570852085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgwAhqAu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 570852085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbeKFFKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 00:10:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:46606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725777AbeKFFKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 00:10:49 -0500
Received: from redbean (ip5f5adbf7.dynamic.kabel-deutschland.de [95.90.219.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAA0520685;
        Mon,  5 Nov 2018 19:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541447370;
        bh=oxxD/Ue4BKli74qshVxM/p19Z7685Npxu+mzjYjArR4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GgwAhqAuON5C6C0WVKRwh7IkeMBoCC/5kNpHc5dGLZXY3C6rpg8rbLAO3RL66vHL+
         1JNBFixhFol8dbLgWjadh+bHqNzjKJmPgLrAuF/2x0KrHSq3cd1CTpJblGM6h+FuOo
         N2k8IKQH7zjCnHn02uRKcPOCCx95MKhEIT1XL0YM=
Date:   Mon, 5 Nov 2018 20:49:09 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Torsten Duwe <duwe@lst.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org
Subject: Re: [PATCH v2] arm64/module: use plt section indices for relocations
Message-ID: <20181105194909.djdmrpqkgu26nbp5@redbean>
References: <20181001140910.086E768BC7@newverein.lst.de>
 <20181001141652.5478C68BE1@newverein.lst.de>
 <20181105175722.removbbpilqxu7tr@redbean>
 <20181105185323.hgoflyvkyujdyjxj@redbean>
 <20181105192637.GB25023@brain-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181105192637.GB25023@brain-police>
X-OS:   Linux redbean 4.18.16-100.fc27.x86_64 x86_64
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Will Deacon [05/11/18 19:26 +0000]:
>On Mon, Nov 05, 2018 at 07:53:23PM +0100, Jessica Yu wrote:
>> Instead of saving a pointer to the .plt and .init.plt sections to apply
>> plt-based relocations, save and use their section indices instead.
>>
>> The mod->arch.{core,init}.plt pointers were problematic for livepatch
>> because they pointed within temporary section headers (provided by the
>> module loader via info->sechdrs) that would be freed after module load.
>> Since livepatch modules may need to apply relocations post-module-load
>> (for example, to patch a module that is loaded later), using section
>> indices to offset into the section headers (instead of accessing them
>> through a saved pointer) allows livepatch modules on arm64 to pass in
>> their own copy of the section headers to apply_relocate_add() to apply
>> delayed relocations.
>>
>> Signed-off-by: Jessica Yu <jeyu@kernel.org>
>> ---
>>
>> v2:
>>
>> - Do sechdrs[pltsec->plt_shndx].sh_addr instead of pointer math
>>
>> Note: Addressed Will's comment about the pltsec -> plt_info rename and
>> removed that change to reduce unnecessary code churn. I didn't include the
>> Ack's for this reason so let me know if this version is OK as well.
>
>Thanks, Jessica!
>
>Acked-by: Will Deacon <will.deacon@arm.com>
>
>> arch/arm64/include/asm/module.h |  8 +++++---
>> arch/arm64/kernel/module-plts.c | 36 ++++++++++++++++++++----------------
>> arch/arm64/kernel/module.c      |  9 +++++----
>> 3 files changed, 30 insertions(+), 23 deletions(-)
>
>Actually, I guess I should just queue this for 4.21 given that it's
>completely self-contained.

Yes, that's fine :-) Then Torsten won't have to include this patch to his
patchset.

Thank you!

Jessica
