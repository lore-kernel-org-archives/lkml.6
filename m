Return-Path: <SRS0=S1Ig=HX=goodmis.org=rostedt@kernel.org>
X-Google-Smtp-Source: AB8JxZpsDpeJviqFZv2xx+dAEJq+SoFLeZCdy49j+rDiFb5KzMDVvOOUT5joJLo8nK/h3qjE/ICg
ARC-Seal: i=1; a=rsa-sha256; t=1525392590; cv=none;
        d=google.com; s=arc-20160816;
        b=U6mNO1FcrLsOGvHOreye0cccnZm1k70fk36j5KxT9k0m6fKcxrQa+b5etFKla44VKO
         2kcfjvKZyba/fGVhAlXqBzLrnZ6btz4YAVZaR+zca3Mr7gdPDoZlIOSrl5plm2JLRF7a
         QNLUgvbAh8+Q4khh5MADr7C0oefObPr64IQ3ClppdicIa2bTUuV9kp/CNzU6YwEXjDkO
         WTG/bb5L753XDAFkOekYSvA2+wyCYgDf2eIDJylzkvlnCSEP1QUttSdCwSbUZhCBe150
         HIzNq9hRPDUDMUwAuihhyVHbmVcCpaohdkilVGri59P2e2xwgVuvCAqL8qMBybG2YxNN
         J3uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=Wd9TJiBoOjsvNYyaa6ZPr5AuLysx3XNdSKJYkbpr3z0=;
        b=huL8vEe9H2FOazaBY3N3hNAhb9GWhfOuOmrT4+rPPpJkuy8d0JaUm+3w81azwqYnJD
         3Yu4njx+qRwES9NIX8wp8v89z+/i6UJhMF2JFNbBobqtMRFVhdT9zaBhY5ATRSXU5pfH
         nrFfAJ/OHDk3q2CsbSHhbo2175tnH9s877OTkGUwppoHAp+b7MGt4Eb0EnByt0VNQ35d
         TcpBA0Zb7a2s/IloHFObNoBcUaAwdkEjUxNe7ehqJdckqZRQuso+ekolXWWRHpp402Bg
         JbeJwzIeOFThfs7pISlsM+6TBg+YO0Rlm+6UQKTqGr9za0Vlni0BmRf/+rAZ71m9eAlu
         eiOQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of srs0=s1ig=hx=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=S1Ig=HX=goodmis.org=rostedt@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of srs0=s1ig=hx=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=S1Ig=HX=goodmis.org=rostedt@kernel.org
Date: Thu, 3 May 2018 20:09:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Tobin C. Harding" <me@tobin.cc>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, Kees
 Cook <keescook@chromium.org>, Anna-Maria Gleixner
 <anna-maria@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>,
 "Theodore Ts'o" <tytso@mit.edu>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 4/4] vsprintf: Add command line option
 debug_early_boot
Message-ID: <20180503200947.11193a6f@vmware.local.home>
In-Reply-To: <1525388861-27018-5-git-send-email-me@tobin.cc>
References: <1525388861-27018-1-git-send-email-me@tobin.cc>
	<1525388861-27018-5-git-send-email-me@tobin.cc>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599486200324402788?=
X-GMAIL-MSGID: =?utf-8?q?1599490061642675849?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri,  4 May 2018 09:07:41 +1000
"Tobin C. Harding" <me@tobin.cc> wrote:

> Currently printing [hashed] pointers requires either a hw RNG or enough
> entropy to be available.  Early in the boot sequence these conditions
> may not be met resulting in a dummy string '(____ptrval____)' being
> printed.  This makes debugging the early boot sequence difficult.  We
> can relax the requirement to use cryptographically secure hashing during
> debugging.  This enables debugging while keeping development/production
> kernel behaviour the same.
> 
> If new command line option debug_early_boot is enabled use
> cryptographically insecure hashing and hash pointer value immediately.
> 
> Signed-off-by: Tobin C. Harding <me@tobin.cc>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  8 ++++++++
>  lib/vsprintf.c                                  | 18 ++++++++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index b8d1379aa039..ab619c4ccbf2 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -748,6 +748,14 @@
>  
>  	debug		[KNL] Enable kernel debugging (events log level).
>  
> +	debug_early_boot

Honestly, I think this is a bad name for what it does. It doesn't
suggest anything about hashing algorithms. And looks like something to
set if you want to debug early in the boot process but you are not
printing pointers.

Maybe something like "debug_boot_weak_hash"? 

-- Steve


> +			[KNL] Enable debugging early in the boot sequence.  If
> +			enabled, we use a weak hash instead of siphash to hash
> +			pointers.  Use this option if you need to see pointer
> +			values during early boot (i.e you are seeing instances
> +			of '(___ptrval___)') - cryptographically insecure,
> +			please do not use on production kernels.
> +
>  	debug_locks_verbose=
>  			[KNL] verbose self-tests
>  			Format=<0|1>
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 3697a19c2b25..2c48884f00eb 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -1654,6 +1654,18 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
>  	return widen_string(buf, buf - buf_start, end, spec);
>  }
>  
> +/* Make pointers available for printing early in the boot sequence. */
> +static int debug_early_boot __ro_after_init;
> +EXPORT_SYMBOL(debug_early_boot);
> +
> +static int __init debug_early_boot_enable(char *str)
> +{
> +	debug_early_boot = 1;
> +	pr_info("debug_early_boot enabled\n");
> +	return 0;
> +}
> +early_param("debug_early_boot", debug_early_boot_enable);
> +
>  static bool have_filled_random_ptr_key __read_mostly;
>  static siphash_key_t ptr_key __read_mostly;
>  
> @@ -1707,6 +1719,12 @@ static char *ptr_to_id(char *buf, char *end, void *ptr, struct printf_spec spec)
>  	const char *str = sizeof(ptr) == 8 ? "(____ptrval____)" : "(ptrval)";
>  	unsigned long hashval;
>  
> +	/* When debugging early boot use non-cryptographically secure hash */
> +	if (unlikely(debug_early_boot)) {
> +		hashval = hash_long((unsigned long)ptr, 32);
> +		return pointer_string(buf, end, (const void *)hashval, spec);
> +	}
> +
>  	if (unlikely(!have_filled_random_ptr_key)) {
>  		spec.field_width = 2 * sizeof(ptr);
>  		/* string length must be less than default_width */
