Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9992AC65C30
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 12:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C6EF2087D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 12:47:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C6EF2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbeJFTuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 15:50:21 -0400
Received: from ozlabs.org ([203.11.71.1]:47737 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727161AbeJFTuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 15:50:21 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42S5xB05D7z9s5b;
        Sat,  6 Oct 2018 22:47:09 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe LEROY <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/9] book3s/64: avoid circular header inclusion in mmu-hash.h
In-Reply-To: <8055896d-f1cd-3560-2f08-ab367270beae@c-s.fr>
References: <cover.1538687073.git.christophe.leroy@c-s.fr> <3ae99c06f76fc89de00b801a6e839952850c7abb.1538687074.git.christophe.leroy@c-s.fr> <8055896d-f1cd-3560-2f08-ab367270beae@c-s.fr>
Date:   Sat, 06 Oct 2018 22:47:06 +1000
Message-ID: <87r2h3i6np.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe LEROY <christophe.leroy@c-s.fr> writes:

> The serie has been successfully compiled tested at 
> http://kisskb.ellerman.id.au/kisskb/head/358723b36b126a381d827c82d04ee226321416b2/

I guess we need to turn on BPF_JIT in some configs :)

This works (builds), but not runtime tested:

diff --git a/arch/powerpc/net/bpf_jit32.h b/arch/powerpc/net/bpf_jit32.h
index 6f4daacad296..dc50a8d4b3b9 100644
--- a/arch/powerpc/net/bpf_jit32.h
+++ b/arch/powerpc/net/bpf_jit32.h
@@ -106,9 +106,8 @@ DECLARE_LOAD_FUNC(sk_load_byte_msh);
 	} while (0)
 #else
 #define PPC_BPF_LOAD_CPU(r)     \
-	do { BUILD_BUG_ON(FIELD_SIZEOF(struct thread_info, cpu) != 4);		\
-		PPC_LHZ_OFFS(r, (1 & ~(THREAD_SIZE - 1)),			\
-				offsetof(struct thread_info, cpu));		\
+	do { BUILD_BUG_ON(FIELD_SIZEOF(struct task_struct, cpu) != 4);		\
+		PPC_LHZ_OFFS(r, 2, offsetof(struct task_struct, cpu));		\
 	} while(0)
 #endif
 #else


cheers
