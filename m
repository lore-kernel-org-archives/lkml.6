Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932097AbeENMvF convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 08:51:05 -0400
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:41604 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753530AbeENMu4 (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:4:1>);
        Mon, 14 May 2018 08:50:56 -0400
Message-Id: <5AF9862C02000078001C27B5@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.0 
Date: Mon, 14 May 2018 06:50:52 -0600
From: "Jan Beulich" <JBeulich@suse.com>
To: "Boris Ostrovsky" <boris.ostrovsky@oracle.com>
Cc: "xen-devel" <xen-devel@lists.xenproject.org>,
        "Juergen Gross" <jgross@suse.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [Xen-devel] [PATCH v2 1/2] xen/PVH: Set up GS segment for
 stack canary
References: <20180509203318.2611-1-boris.ostrovsky@oracle.com>
 <20180509203318.2611-2-boris.ostrovsky@oracle.com>
In-Reply-To: <20180509203318.2611-2-boris.ostrovsky@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On 09.05.18 at 22:33, <boris.ostrovsky@oracle.com> wrote:
> @@ -64,6 +67,17 @@ ENTRY(pvh_start_xen)
>  	mov %eax,%es
>  	mov %eax,%ss
>  
> +	/* Set base address in stack canary descriptor. */
> +	movl _pa(gdt_start),%eax
> +	movl $_pa(canary),%ecx
> +	movw %cx, (PVH_GDT_ENTRY_CANARY * 8) + 0(%eax)
> +	shrl $16, %ecx
> +	movb %cl, (PVH_GDT_ENTRY_CANARY * 8) + 2(%eax)
> +	movb %ch, (PVH_GDT_ENTRY_CANARY * 8) + 5(%eax)

Is this meaningful / correct for the 64-bit case? I'd rather expect you to
write the GS base address MSR there.

Jan
