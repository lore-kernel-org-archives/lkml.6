Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933657AbeEWPl1 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 11:41:27 -0400
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:39496 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932578AbeEWPlY (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:5:1>);
        Wed, 23 May 2018 11:41:24 -0400
Message-Id: <5B058BA002000078001C523F@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.0 
Date: Wed, 23 May 2018 09:41:20 -0600
From: "Jan Beulich" <JBeulich@suse.com>
To: "Boris Ostrovsky" <boris.ostrovsky@oracle.com>
Cc: <brgerst@gmail.com>, "xen-devel" <xen-devel@lists.xenproject.org>,
        "Juergen Gross" <jgross@suse.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] xen/PVH: Set up GS segment for stack canary
References: <20180523143002.29252-1-boris.ostrovsky@oracle.com>
 <20180523143002.29252-2-boris.ostrovsky@oracle.com>
In-Reply-To: <20180523143002.29252-2-boris.ostrovsky@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On 23.05.18 at 16:30, <boris.ostrovsky@oracle.com> wrote:
> @@ -98,6 +101,12 @@ ENTRY(pvh_start_xen)
>  	/* 64-bit entry point. */
>  	.code64
>  1:
> +	/* Set base address in stack canary descriptor. */
> +	mov $MSR_GS_BASE,%ecx
> +	mov $_pa(canary), %rax
> +	xor %rdx, %rdx

Why rax and rdx instead of eax and edx? In the former case, the
relocation produced might confuse whatever entity processing it
(it'll have a sign-extended 32-bit quantity to deal with, which
wouldn't allow representing an address in the [2Gb, 4Gb) range).
In the latter case, while surely neither performance nor code size
matter much here, it's still a bad precedent (people copy-and-paste
code all the time): Zero-ing of registers should generally use the
32-bit forms of the insn. Gas has actually gained an optimization
mode recently (upon request from Linus and the x86 maintainers)
to silently "repair" such inefficiencies.

Jan
