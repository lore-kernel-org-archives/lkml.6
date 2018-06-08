Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id fxGwEfeYGluwLwAAmS7hNA
	; Fri, 08 Jun 2018 14:55:51 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 3910B607E4; Fri,  8 Jun 2018 14:55:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9F7FA60290;
	Fri,  8 Jun 2018 14:55:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9F7FA60290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752864AbeFHOzr (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 10:55:47 -0400
Received: from gate.crashing.org ([63.228.1.57]:42700 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751719AbeFHOzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 10:55:46 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w58EsYcA032671;
        Fri, 8 Jun 2018 09:54:35 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id w58EsOLR032633;
        Fri, 8 Jun 2018 09:54:24 -0500
Date: Fri, 8 Jun 2018 09:54:23 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, wei.guo.simon@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] powerpc/lib: implement strlen() in assembly
Message-ID: <20180608145423.GF17342@gate.crashing.org>
References: <85de16f5629ac9f4a815230cced361908758b53a.1528463979.git.christophe.leroy@c-s.fr> <ce98c6b8e80f85635a67093bbb59f13dae758112.1528463979.git.christophe.leroy@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce98c6b8e80f85635a67093bbb59f13dae758112.1528463979.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Fri, Jun 08, 2018 at 01:27:39PM +0000, Christophe Leroy wrote:
> ---
> Not tested on PPC64.

> +#ifdef CPU_LITTLE_ENDIAN
> +	rldicl.	r8, r9, 0, 56
> +	beq	20f
> +	rldicl.	r8, r9, 56, 56
> +	beq	21f
> +	rldicl.	r8, r9, 48, 56
> +	beq	22f
> +	rldicl.	r8, r9, 40, 56
> +	beq	23f
> +	addi	r10, r10, 4
> +	rldicl.	r8, r9, 32, 56
> +	beq	20f
> +	rldicl.	r8, r9, 24, 56
> +	beq	21f
> +	rldicl.	r8, r9, 16, 56
> +	beq	22f
> +	rldicl.	r8, r9, 8, 56
> +#else
> +#ifdef CONFIG_PPC64
> +	rldicl.	r8, r9, 8, 56
> +	beq	20f
> +	rldicl.	r8, r9, 16, 56
> +	beq	21f
> +	rldicl.	r8, r9, 24, 56
> +	beq	22f
> +	rldicl.	r8, r9, 32, 56
> +	beq	23f
> +	addi	r10, r10, 4
> +#endif
> +	rlwinm.	r8, r9, 0, 0xff000000
> +	beq	20f
> +	rlwinm.	r8, r9, 0, 0x00ff0000
> +	beq	21f
> +	rlwinm.	r8, r9, 0, 0x0000ff00
> +	beq	22f
> +#endif /* CPU_LITTLE_ENDIAN */

That isn't going to perform well on processors that have more than two
or so cycles penalty on a branch mispredict (i.e. all modern processors).

ISA 2.05 and later cpus (Power6 and later) can use cmpb and a single
cntlz, on BE; on LE you can use the cnttz insn on ISA 3.0 (Power9) or
later, or do add/andc/popcntd (on ISA2.06, Power7 and later) or
neg/and/cntlz/sub.

Lots of options.  You can also write branchless code for this without
using any new insns (less nice of course).


Segher
