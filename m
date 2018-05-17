Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752491AbeEQPCs convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 11:02:48 -0400
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:57143 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751533AbeEQPCr (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:4:1>);
        Thu, 17 May 2018 11:02:47 -0400
Message-Id: <5AFD999402000078001C3B29@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.0 
Date: Thu, 17 May 2018 09:02:44 -0600
From: "Jan Beulich" <JBeulich@suse.com>
To: "Boris Ostrovsky" <boris.ostrovsky@oracle.com>
Cc: "xen-devel" <xen-devel@lists.xenproject.org>,
        "Juergen Gross" <jgross@suse.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] xen/PVH: Set up GS segment for stack canary
References: <20180517144723.21585-1-boris.ostrovsky@oracle.com>
 <20180517144723.21585-2-boris.ostrovsky@oracle.com>
In-Reply-To: <20180517144723.21585-2-boris.ostrovsky@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On 17.05.18 at 16:47, <boris.ostrovsky@oracle.com> wrote:
> @@ -64,6 +67,9 @@ ENTRY(pvh_start_xen)
>  	mov %eax,%es
>  	mov %eax,%ss
>  
> +	mov $PVH_CANARY_SEL,%eax
> +	mov %eax,%gs

I doubt this is needed for 64-bit (you could equally well load zero or leave
in place what's there in that case), and loading the selector before setting
the base address in the descriptor won't have the intended effect.

> @@ -150,9 +170,12 @@ gdt_start:
>  	.quad GDT_ENTRY(0xc09a, 0, 0xfffff) /* __KERNEL_CS */
>  #endif
>  	.quad GDT_ENTRY(0xc092, 0, 0xfffff) /* __KERNEL_DS */
> +	.quad GDT_ENTRY(0x4090, 0, 0x18)    /* PVH_CANARY_SEL */
>  gdt_end:
>  
> -	.balign 4
> +	.balign 16
> +canary:
> +	.fill 24, 1, 0

This is too little space for 64-bit afaict (the canary lives at offset 40 there
if I can trust asm/processor.h).

Jan
