Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04964C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C180F20656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbfAOKWi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 05:22:38 -0500
Received: from ozlabs.org ([203.11.71.1]:51183 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727369AbfAOKWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 05:22:37 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43f5xk5hG3z9s9G;
        Tue, 15 Jan 2019 21:22:34 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Jonathan =?utf-8?Q?Neusch?= =?utf-8?Q?=C3=A4fer?= 
        <j.neuschaefer@gmx.net>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 00/15] powerpc/32s: Use BATs/LTLBs for STRICT_KERNEL_RWX
In-Reply-To: <b37e3635-9c69-0cfc-1283-25459b394033@c-s.fr>
References: <cover.1547132681.git.christophe.leroy@c-s.fr> <20190113181621.GA22334@latitude> <714e78ba-1e92-a856-3dd6-a1fb96ad3785@c-s.fr> <20190113210227.GB22334@latitude> <334b1b02-b652-499c-904e-09e6f7164b8c@c-s.fr> <20190115003353.GD22334@latitude> <b37e3635-9c69-0cfc-1283-25459b394033@c-s.fr>
Date:   Tue, 15 Jan 2019 21:22:32 +1100
Message-ID: <87fttuz0d3.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> Le 15/01/2019 à 01:33, Jonathan Neuschäfer a écrit :
...
>> 
>> - patches 7 to 11 fail to build with this error (really a warning, but
>>    arch/powerpc doesn't allow warnings by default):
>> 
>> 	  CC      arch/powerpc/mm/ppc_mmu_32.o
>> 	../arch/powerpc/mm/ppc_mmu_32.c:133:13: error: ‘clearibat’ defined but not used [-Werror=unused-function]
>> 	 static void clearibat(int index)
>> 		     ^~~~~~~~~
>> 	../arch/powerpc/mm/ppc_mmu_32.c:115:13: error: ‘setibat’ defined but not used [-Werror=unused-function]
>> 	 static void setibat(int index, unsigned long virt, phys_addr_t phys,
>> 		     ^~~~~~~
>> 	cc1: all warnings being treated as errors
>
> Argh ! I have to squash the patch bringing the new functions with the 
> one using them (patch 12). The result is a big messy patch which is more 
> difficult to review but that's life.

You don't *have* to squash them.

We like to preserve bisectability, but it's not a 100% hard requirement.

Someone trying to bisect through those patches can always turn off
-Werror with PPC_DISABLE_WERROR. But they probably can just skip them
because they just add new code that's not called yet.

So I won't object if you send them as-is.

cheers
