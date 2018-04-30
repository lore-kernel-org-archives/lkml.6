Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752836AbeD3JGT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 05:06:19 -0400
Received: from mail.skyhub.de ([5.9.137.197]:59750 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751426AbeD3JGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 05:06:18 -0400
Date: Mon, 30 Apr 2018 11:05:42 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 6/6] x86/microcode/AMD: Check the equivalence table
 size when scanning it
Message-ID: <20180430090542.GD6509@pd.tnic>
References: <cover.1524515406.git.mail@maciej.szmigiero.name>
 <68fade9fda9e63c0722052abecaf4ed0c360beeb.1524515406.git.mail@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <68fade9fda9e63c0722052abecaf4ed0c360beeb.1524515406.git.mail@maciej.szmigiero.name>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 11:34:11PM +0200, Maciej S. Szmigiero wrote:
> Currently, the code scanning the CPU equivalence table read from a
> microcode container file assumes that it actually contains a terminating
> zero entry.
> Let's check also the size of this table to make sure that we don't read
> past it in case it actually doesn't.

...

> @@ -697,6 +706,7 @@ static unsigned int install_equiv_cpu_table(const u8 *buf, size_t buf_size)
>  	}
>  
>  	memcpy(equiv_cpu_table, buf + CONTAINER_HDR_SZ, equiv_tbl_len);
> +	equiv_cpu_table_entries = equiv_tbl_len / sizeof(struct equiv_cpu_entry);
>  
>  	return equiv_tbl_len;

Instead of adding yet another global var which needs handling too,
and touching so many places, just do all checks and preparations in
install_equiv_cpu_table() so that the rest of the code can get what it
expects: terminating zero entry and proper size.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
