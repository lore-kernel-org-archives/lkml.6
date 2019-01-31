Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986A7C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6109D20B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="hLqARxqM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbfAaU5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 15:57:02 -0500
Received: from a9-54.smtp-out.amazonses.com ([54.240.9.54]:34520 "EHLO
        a9-54.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727077AbfAaU5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 15:57:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1548968221;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=dn2omShFf6Xl/TI/yPpPBfhfVyM/8Yd9LQa5Ur1JErE=;
        b=hLqARxqMr9+W+Ok+DIFrw9CPp+3zlJfVJa/aN5zpPnPUiEYJ9cx2U2tdkScPQyjA
        blWFeKeMdTgA+ZRttarhxygb5Em/0phqnV6ourGkyjN0ZWPrJFKXTIhLihD0i9qtcra
        f8rPa6gSVs+oLdbrsB3JonOZujQVmmFDp85YA7GY=
Date:   Thu, 31 Jan 2019 20:57:01 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Thomas Garnier <thgarnie@chromium.org>
cc:     kernel-hardening@lists.openwall.com, kristen@linux.intel.com,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Thomas Garnier <thgarnie@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH v6 14/27] x86/percpu: Adapt percpu for PIE support
In-Reply-To: <20190131192533.34130-15-thgarnie@chromium.org>
Message-ID: <01000168a5b35a86-b79bfe67-191e-43bc-a5c7-0e74eac06195-000000@email.amazonses.com>
References: <20190131192533.34130-1-thgarnie@chromium.org> <20190131192533.34130-15-thgarnie@chromium.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.01.31-54.240.9.54
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2019, Thomas Garnier wrote:

> Perpcu uses a clever design where the .percu ELF section has a virtual
> address of zero and the custom linux relocation code avoid relocating
> specific symbols. It makes the code simple and easily adaptable with or
> without SMP support.

We usually talk about this as offsets rather than addressess. The intend
here is to give every processor its own address that is unique for this
processor. Operations are always relative to a segment register and the
whole area can be relocated at will by simply changing the segment
register.

> This design is incompatible with PIE. While creating a PIE binary, the
> copmiler tries to make everything relative. The compiler will attempt to

This is very compatible with PIE because it is already relative.

> generate instructions with the distance between zero and any 64-bit
> virtual address. It will fail as the relocation range cannot fit within
> the possible instructions accessing a segment register.

Leave the offsets alone and just change the segment register if you need
to relocate the area of a specific processor?

> The assembly and PER_CPU macros are changed to use relative references
> when PIE is enabled.

They already use relative reference. What is the point here?

> --- a/arch/x86/include/asm/percpu.h
> +++ b/arch/x86/include/asm/percpu.h
> @@ -5,9 +5,11 @@
>  #ifdef CONFIG_X86_64
>  #define __percpu_seg		gs
>  #define __percpu_mov_op		movq
> +#define __percpu_rel		(%rip)

The percpu section cannot be IP relative since we need to have separate
address spaces per cpu.

