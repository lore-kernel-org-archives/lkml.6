Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0292EECDFB4
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 23:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8194D20693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 23:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8194D20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731186AbeGQX7R convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 19:59:17 -0400
Received: from ozlabs.org ([203.11.71.1]:49799 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730460AbeGQX7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 19:59:17 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        by ozlabs.org (Postfix) with ESMTP id 41Vbvl4rgFz9s0w;
        Wed, 18 Jul 2018 09:24:19 +1000 (AEST)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id 982D0EE78BD; Wed, 18 Jul 2018 09:24:19 +1000 (AEST)
Message-ID: <80bbdf47081e3e302ab5f28b5ddc9e2faabba842.camel@neuling.org>
Subject: Re: [RESEND][PATCH] powerpc/powernv : Save/Restore SPRG3 on
 entry/exit from stop.
From:   Michael Neuling <mikey@neuling.org>
To:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Florian Weimer <fweimer@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>
Date:   Wed, 18 Jul 2018 09:24:19 +1000
In-Reply-To: <1531843216-22209-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1531826849-31838-1-git-send-email-ego@linux.vnet.ibm.com>
         <1531843216-22209-1-git-send-email-ego@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>  	DEFINE(PPC_DBELL_SERVER, PPC_DBELL_SERVER);
> diff --git a/arch/powerpc/kernel/idle_book3s.S
> b/arch/powerpc/kernel/idle_book3s.S
> index d85d551..5069d42 100644
> --- a/arch/powerpc/kernel/idle_book3s.S
> +++ b/arch/powerpc/kernel/idle_book3s.S
> @@ -120,6 +120,9 @@ power9_save_additional_sprs:
>  	mfspr	r4, SPRN_MMCR2
>  	std	r3, STOP_MMCR1(r13)
>  	std	r4, STOP_MMCR2(r13)
> +
> +	mfspr	r3, SPRN_SPRG3
> +	std	r3, STOP_SPRG3(r13)

We don't need to save it.  Just restore it from paca->sprg_vdso which should
never change.

How can we do better at catching these missing SPRGs? 

We missed this one and looking at c1b25a17d249 we missed the AMOR a couple of
months back. I'd rather we had some systematic way of finding the ones we are
missing, rather than playing wake-a-mole.

Mikey 

>  	blr
>  
>  power9_restore_additional_sprs:
> @@ -144,7 +147,9 @@ power9_restore_additional_sprs:
>  	mtspr	SPRN_MMCR1, r4
>  
>  	ld	r3, STOP_MMCR2(r13)
> +	ld	r4, STOP_SPRG3(r13)
>  	mtspr	SPRN_MMCR2, r3
> +	mtspr	SPRN_SPRG3, r4
>  	blr
>  
>  /*
