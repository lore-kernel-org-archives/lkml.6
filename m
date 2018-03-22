Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753452AbeCVKHN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 06:07:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51110 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750982AbeCVKHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 06:07:11 -0400
Subject: Re: [PATCH] KVM: X86: Fix the decoding of segment overrides in 64bit
 mode
To: Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <1521707651-9375-1-git-send-email-wanpengli@tencent.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <aadc47c3-9d5f-b4d5-92d3-cb888a29563c@redhat.com>
Date: Thu, 22 Mar 2018 11:07:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521707651-9375-1-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2018 09:34, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> Explicit segment overides other than %fs and %gs are documented as ignored by
> both Intel and AMD.
> 
> In practice, this means that:
> 
>  * Explicit uses of %ss don't actually yield #SS[0] for non-canonical
>    memory references.
>  * Explicit uses of %{e,c,d}s don't override %rbp/%rsp-based memory references
>    to yield #GP[0] for non-canonical memory references.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  arch/x86/kvm/emulate.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index dd88158..5091255 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -5148,8 +5148,10 @@ int x86_decode_insn(struct x86_emulate_ctxt *ctxt, void *insn, int insn_len)
>  		case 0x2e:	/* CS override */
>  		case 0x36:	/* SS override */
>  		case 0x3e:	/* DS override */
> -			has_seg_override = true;
> -			ctxt->seg_override = (ctxt->b >> 3) & 3;
> +			if (mode != X86EMUL_MODE_PROT64) {
> +				has_seg_override = true;
> +				ctxt->seg_override = (ctxt->b >> 3) & 3;
> +			}
>  			break;
>  		case 0x64:	/* FS override */
>  		case 0x65:	/* GS override */
> 

Testcase, please...

Paolo
