Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965404AbeBMSHO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 13:07:14 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38637 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965168AbeBMSHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 13:07:12 -0500
X-Google-Smtp-Source: AH8x225ZL6xpD6caNWFD0WQaHDlgxBYxIRdTPcXLTZKgVH7fEvGxGi1hPohay0G9ve4DDKIHe5765g==
Date: Tue, 13 Feb 2018 19:07:08 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: matt@codeblueprint.co.uk, ard.biesheuvel@linaro.org,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: efi: Replace GFP_ATOMIC with GFP_KERNEL in
 efi_query_variable_store
Message-ID: <20180213180707.einsznaoghtctkqn@gmail.com>
References: <1516847386-5291-1-git-send-email-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516847386-5291-1-git-send-email-baijiaju1990@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Jia-Ju Bai <baijiaju1990@gmail.com> wrote:

> The function kzalloc here is not called in atomic context.
> If nonblocking in efi_query_variable_store is true, 
> namely it is in atomic context, efi_query_variable_store will return before
> this kzalloc is called.
> Thus GFP_ATOMIC is not necessary, and it can be replaced with GFP_KERNEL.
> 
> This is found by a static analysis tool named DCNS written by myself.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  arch/x86/platform/efi/quirks.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
> index 8a99a2e..b6dcb52 100644
> --- a/arch/x86/platform/efi/quirks.c
> +++ b/arch/x86/platform/efi/quirks.c
> @@ -177,7 +177,7 @@ efi_status_t efi_query_variable_store(u32 attributes, unsigned long size,
>  		 * that by attempting to use more space than is available.
>  		 */
>  		unsigned long dummy_size = remaining_size + 1024;
> -		void *dummy = kzalloc(dummy_size, GFP_ATOMIC);
> +		void *dummy = kzalloc(dummy_size, GFP_KERNEL);

Looks good to me!

Reviewed-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
