Return-Path: <vitezslav@samel.cz>
X-Google-Smtp-Source: AIpwx49QR6/W8KiWfZqlx0YlYfNgcO/jZVUMvCMphPwXNOumVBbO7fENpc1rs7TtMfua85lmvP0l
ARC-Seal: i=1; a=rsa-sha256; t=1524221679; cv=none;
        d=google.com; s=arc-20160816;
        b=Ln1G546V/WUJF2vErgETNqF4dwcCOkSGKdtkg1JbBvEpHLyNEYpJrXBC1QO6tSp/0+
         EYcTF55Rimx/njck1owbH7+GU46NSfkP/p3nI/r8uERQx+l7cijMCKb9Iq/x8tFQoDUc
         o9DGenN+ogtGg82MLr7yebG//jt/8PJfvjZ6bRc/7bqVvlZZyMhxjcFT6k7Ogy1Y7KXX
         QBv735MUYYxa9JV+7CjhydVQMAqCi2Q0/1ITMljpuZ3Buhn/2ZymB+nz15vfOcJkkeMz
         7V4wJMIX/BaUfsgcNTDHjxdEtub+3oeq8PYnSDl/5Z5OjW8LAiSm/fA5YNhjWzqDLY76
         4UPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:mail-followup-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=UlcPcVo2r7x4XMUGSEhs8crUAVZkBtKp5Za1ZGm7bqE=;
        b=FeOtOlA3dPJzpoJ6nPZjVZRHtns5PSTxkvm3Dx3bF7p6dXzKe1sV8DUnoGFD4Z3HSO
         PgRRZ2+U+n4IVfMVqpONIEUneboyh+WqkW2tYOROaBE3Jsle4gHdJnuV8AHWK6z6KegJ
         zY3HAz3VDzWqdGQFXek1vo8zAdTpE7YDVdOhk8pDKxYzm4wWg6kh76G/xHXT5O2btVWv
         dVEkp7iKf6lbznYnQcYRGKCNarkgWzfhf+MOiCUysM5feMBge7yB/X4V6mYyZCB22K+p
         LjH13afp1zfsTpyvzdNNVv5bycylnZzXi0H4ZR8I1gh7mCVAoIAVZ8WJjCi3V6G+s6hI
         +4zQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 213.155.227.146 is neither permitted nor denied by best guess record for domain of vitezslav@samel.cz) smtp.mailfrom=vitezslav@samel.cz
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 213.155.227.146 is neither permitted nor denied by best guess record for domain of vitezslav@samel.cz) smtp.mailfrom=vitezslav@samel.cz
Date: Fri, 20 Apr 2018 12:54:38 +0200
From: Vitezslav Samel <vitezslav@samel.cz>
To: Borislav Petkov <bp@suse.de>
Cc: "Raj, Ashok" <ashok.raj@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, x86-ml <x86@kernel.org>
Subject: Re: [PATCH 2/2] x86/microcode: Do not exit early from __reload_late()
Message-ID: <20180420105438.GB2257@pc11.op.pod.cz>
Mail-Followup-To: Borislav Petkov <bp@suse.de>,
	"Raj, Ashok" <ashok.raj@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, x86-ml <x86@kernel.org>
References: <20180419104829.GE3896@pd.tnic>
 <20180419120239.GA2377@pc11.op.pod.cz>
 <20180419121840.GF3896@pd.tnic>
 <20180419134627.GA2387@pc11.op.pod.cz>
 <20180419163734.GB3905@pd.tnic>
 <20180420062021.GA2253@pc11.op.pod.cz>
 <20180420095220.GA13977@pd.tnic>
 <20180420100131.GA14217@pc11.op.pod.cz>
 <20180420103242.GB13977@pd.tnic>
 <20180420103708.GE13977@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180420103708.GE13977@pd.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598261173668216348?=
X-GMAIL-MSGID: =?utf-8?q?1598262271415266621?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 20, 2018 at 12:37:08PM +0200, Borislav Petkov wrote:
> Vitezslav reported a case where the
> 
>   "Timeout during microcode update!"
> 
> panic would hit. After a deeper look, it turned out that his .config had
> CONFIG_HOTPLUG_CPU disabled which practically made save_mc_for_early() a
> no-op.
> 
> When that happened, the discovered microcode patch wasn't saved into our
> cache and the late loading path wouldn't find any.
> 
> This, then, lead to early exit from __reload_late() and thus CPUs
> waiting until the timeout is reached, leading to the panic.
> 
> In hindsight, I should've made that function not return before the
> post-synchronization. Oh well, I know better now...
> 
> Reported-by: Vitezslav Samel <vitezslav@samel.cz>

  Tested-by: Vitezslav Samel <vitezslav@samel.cz>

> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: <stable@vger.kernel.org>
> Fixes: bb8c13d61a62 ("x86/microcode: Fix CPU synchronization routine")
> Link: http://lkml.kernel.org/r/20180418081140.GA2439@pc11.op.pod.cz
> ---
>  arch/x86/kernel/cpu/microcode/core.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
> index 10c4fc2c91f8..77e201301528 100644
> --- a/arch/x86/kernel/cpu/microcode/core.c
> +++ b/arch/x86/kernel/cpu/microcode/core.c
> @@ -564,14 +564,12 @@ static int __reload_late(void *info)
>  	apply_microcode_local(&err);
>  	spin_unlock(&update_lock);
>  
> +	/* siblings return UCODE_OK because their engine got updated already */
>  	if (err > UCODE_NFOUND) {
>  		pr_warn("Error reloading microcode on CPU %d\n", cpu);
> -		return -1;
> -	/* siblings return UCODE_OK because their engine got updated already */
> +		ret = -1;
>  	} else if (err == UCODE_UPDATED || err == UCODE_OK) {
>  		ret = 1;
> -	} else {
> -		return ret;
>  	}
>  
>  	/*
> -- 
> 2.13.0
> 
> SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
> -- 
