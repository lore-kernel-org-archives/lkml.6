Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751706AbeCTRyX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 13:54:23 -0400
Received: from mail.skyhub.de ([5.9.137.197]:54214 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751186AbeCTRyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 13:54:22 -0400
Date: Tue, 20 Mar 2018 18:53:36 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 03/10] x86/microcode/AMD: Check equivalence table
 length in the late loader
Message-ID: <20180320175308.GA9360@cz.tnic>
References: <cover.1521150415.git.mail@maciej.szmigiero.name>
 <1f29f9f9-0a9e-11e2-8e61-ba7c171e2bd9@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1f29f9f9-0a9e-11e2-8e61-ba7c171e2bd9@maciej.szmigiero.name>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 12:08:04AM +0100, Maciej S. Szmigiero wrote:
> Before loading a CPU equivalence table from a microcode container file we
> need to verify whether this file is actually large enough to contain the
> table of a size indicated in this file.
> If it is not, there is no point of continuing with loading it since
> microcode patches are located after the equivalence table anyway.
> 
> This patch adds these checks to the late loader.
> 
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> ---
>  arch/x86/kernel/cpu/microcode/amd.c | 32 ++++++++++++++++++++++----------
>  1 file changed, 22 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
> index 138c9fb983f2..ed24200cf936 100644
> --- a/arch/x86/kernel/cpu/microcode/amd.c
> +++ b/arch/x86/kernel/cpu/microcode/amd.c
> @@ -551,28 +551,40 @@ static enum ucode_state apply_microcode_amd(int cpu)
>  	return UCODE_UPDATED;
>  }
>  
> -static int install_equiv_cpu_table(const u8 *buf)
> +static int install_equiv_cpu_table(const u8 *buf, size_t buf_size)
>  {
>  	unsigned int *ibuf = (unsigned int *)buf;
> -	unsigned int type = ibuf[1];
> -	unsigned int size = ibuf[2];
> +	unsigned int type, equiv_tbl_len;

Ok, as a unification, let's make those u32 too.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply. Srsly.
