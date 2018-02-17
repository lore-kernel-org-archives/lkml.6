Return-Path: <linux@dominikbrodowski.net>
X-Google-Smtp-Source: AH8x227Jt4DYl381udLs/FXMpq1F4uC2b7trNXuZrg5TYUq1wM5/Km003jNzqUjGlXBJZ0shtsPL
ARC-Seal: i=1; a=rsa-sha256; t=1518870541; cv=none;
        d=google.com; s=arc-20160816;
        b=XEawSZHqvoE+jipWzGUfKVIgz0CxOXFLHyRkZDHuuzdczzPj/iLB3ix+ytYxrjQdX9
         xXmaN9VkzcHEVWH9W3M0C25djh50mOLjgt4MG1DY11W1505C7gH1P6nirh0bjqHKfJHW
         93X+Ia30GLUlhpeTF1e6yhskwq4XJpULrvf3wCT5+hpGfT9CirClS814KLUvodjJAswJ
         nafabHuReQQoGTKwMy87QKi108ahBBRiIYNE3bDdVCTyL+TLBLFsYWEupN5GZTGyAlU+
         Hz1Ufmo7Z3lIvGHtbq9QkSfoViu3VLUFXm9d9juaDZCMdM4Mf0lp3zVSKAf5UlnhJSW/
         KOFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=e8YvZJJW9S/f1qBKvttowB9MImEFTpm02hRDjjh+CWw=;
        b=pR/GudxAsjoSgP9GOcV60yhp2lOPUs7U4cvnO3Maa3Bz0D6hVPWg+LSwhTJJJTEe9M
         wrh3b3FwZiMceDLtMRKHVUI8KmkWs4wMyjOvkR4Sa28vQ+dyOU/fEy7+GyNNFJaMo7Fd
         iCzu2RHBkcNDnsa7RfRwzYTZMkK4P298B99VQ2HJVYwFu/GvqcLMbV2soHeJ3/o3wEiD
         dWjdNTXFUltMGXlzin/Fe7t95Tipig3ROiL66hWi9BjXUfPztJkgbNiyirVOZadkkAef
         DdZV4jKD1yPR6jRjwyEoie8UzBN7wBm8QzBNKtrZYyy1zg1ITtL9kef7IDkMWDyOC9X5
         0suA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 136.243.71.142 is neither permitted nor denied by best guess record for domain of linux@dominikbrodowski.net) smtp.mailfrom=linux@dominikbrodowski.net
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 136.243.71.142 is neither permitted nor denied by best guess record for domain of linux@dominikbrodowski.net) smtp.mailfrom=linux@dominikbrodowski.net
Date: Sat, 17 Feb 2018 13:28:59 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: arjan@linux.intel.com, gregkh@linuxfoundation.org, mingo@kernel.org,
	dan.j.williams@intel.com, luto@kernel.org, bp@alien8.de,
	torvalds@linux-foundation.org, dwmw2@infradead.org, hpa@zytor.com,
	dave.hansen@linux.intel.com, jpoimboe@redhat.com,
	linux-kernel@vger.kernel.org, peterz@infradead.org,
	tglx@linutronix.de
Cc: linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/pti] x86/entry: Reduce the code footprint of the
 'idtentry' macro
Message-ID: <20180217122859.GA13344@isilmar-4.linta.de>
References: <20180214175924.23065-2-linux@dominikbrodowski.net>
 <tip-9e809d15d6b692fa061d74be7aaab1c79f6784b8@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tip-9e809d15d6b692fa061d74be7aaab1c79f6784b8@git.kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592648851534933862?=
X-GMAIL-MSGID: =?utf-8?q?1592651197177950529?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Feb 17, 2018 at 03:40:13AM -0800, tip-bot for Dominik Brodowski wrote:
> Commit-ID:  9e809d15d6b692fa061d74be7aaab1c79f6784b8
> Gitweb:     https://git.kernel.org/tip/9e809d15d6b692fa061d74be7aaab1c79f6784b8
> Author:     Dominik Brodowski <linux@dominikbrodowski.net>
> AuthorDate: Wed, 14 Feb 2018 18:59:23 +0100
> Committer:  Ingo Molnar <mingo@kernel.org>
> CommitDate: Sat, 17 Feb 2018 11:14:33 +0100
> 
> x86/entry: Reduce the code footprint of the 'idtentry' macro
> 
> Play a little trick in the generic PUSH_AND_CLEAR_REGS macro
> to insert the GP registers "above" the original return address.
> 
> This allows us to (re-)insert the macro in error_entry() and
> paranoid_entry() and to remove it from the idtentry macro. This
> reduces the static footprint significantly:
> 
>    text	   data	    bss	    dec	    hex	filename
>   24307	      0	      0	  24307	   5ef3	entry_64.o-orig
>   20987	      0	      0	  20987	   51fb	entry_64.o
> 
> Co-developed-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Arjan van de Ven <arjan@linux.intel.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Link: http://lkml.kernel.org/r/20180214175924.23065-2-linux@dominikbrodowski.net
> [ Small tweaks to comments. ]
> Signed-off-by: Ingo Molnar <mingo@kernel.org>

Thanks! Just a minor thing:

> - * Switch gs if needed.
> + * Save all registers in pt_regs, and switch gs if needed.

...

> - * Switch gs if needed.
> + * Save all registers in pt_regs, and switch GS if needed.

If we switch from gs to GS, we should do it in both places.

Thanks!

	Dominik
