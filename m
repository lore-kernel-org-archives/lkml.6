Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971091AbeEXTnC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 15:43:02 -0400
Received: from gate.crashing.org ([63.228.1.57]:48710 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967421AbeEXTnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 15:43:00 -0400
Date: Thu, 24 May 2018 14:42:06 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3] powerpc: Implement csum_ipv6_magic in assembly
Message-ID: <20180524194206.GD17342@gate.crashing.org>
References: <20180522065701.9DE696CCB4@po14934vm.idsi0.si.c-s.fr> <20180523183447.GV17342@gate.crashing.org> <3848a4ad-2c0e-691f-e98f-347cfe3484e8@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3848a4ad-2c0e-691f-e98f-347cfe3484e8@c-s.fr>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 08:20:16AM +0200, Christophe LEROY wrote:
> Le 23/05/2018 à 20:34, Segher Boessenkool a écrit :
> >On Tue, May 22, 2018 at 08:57:01AM +0200, Christophe Leroy wrote:
> >>+_GLOBAL(csum_ipv6_magic)
> >>+	lwz	r8, 0(r3)
> >>+	lwz	r9, 4(r3)
> >>+	lwz	r10, 8(r3)
> >>+	lwz	r11, 12(r3)
> >>+	addc	r0, r5, r6
> >>+	adde	r0, r0, r7
> >>+	adde	r0, r0, r8
> >>+	adde	r0, r0, r9
> >>+	adde	r0, r0, r10
> >>+	adde	r0, r0, r11
> >>+	lwz	r8, 0(r4)
> >>+	lwz	r9, 4(r4)
> >>+	lwz	r10, 8(r4)
> >>+	lwz	r11, 12(r4)
> >>+	adde	r0, r0, r8
> >>+	adde	r0, r0, r9
> >>+	adde	r0, r0, r10
> >>+	adde	r0, r0, r11
> >>+	addze	r0, r0
> >>+	rotlwi	r3, r0, 16
> >>+	add	r3, r0, r3
> >>+	not	r3, r3
> >>+	rlwinm	r3, r3, 16, 16, 31
> >>+	blr
> >>+EXPORT_SYMBOL(csum_ipv6_magic)
> >
> >Clustering the loads and carry insns together is pretty much the worst you
> >can do on most 32-bit CPUs.
> 
> Oh, really ? __csum_partial is written that way too.

I thought I told you about this before?  Maybe not.

> Right, now I tried interleaving the lwz and adde. I get no improvment at 
> all on a 885, but I get a 15% improvment on a 8321.

It won't likely help on single-issue cores (like the one 885 has), yes.


Segher
