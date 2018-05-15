Return-Path: <SRS0=cHGH=IC=goodmis.org=rostedt@kernel.org>
X-Google-Smtp-Source: AB8JxZootiazezkrwUaZdPtFraZs8+2rceIjV8txt7/AViJLx2rZOZ07d3i32jjJoKTwER2r+NDi
ARC-Seal: i=1; a=rsa-sha256; t=1526392067; cv=none;
        d=google.com; s=arc-20160816;
        b=Efk9EyX4KZ2H3oQRnV7GmvbNg4fqoY9UpKuASEjUpPQVh4CGXDn3ECw3Z1mak61z5u
         9GwX1d1c7ybM7JRfc4CWEatl7h45yHdWOPgu0yFZsHKNH9wZwbD6eTEWC7RWlFa6YYjl
         HFLdXPACOng/8Ux5IKlIdxvDEPqM//d+TmJQkxsc+qCH4voGgklN1ftb4ggIlv87o06h
         z2SaWjrRMsr02b1+BANx4Zg99RrK5OzbWtAF5qC5Ne59m+K9brcxCvfCVxFrSd3otXmN
         wcYf6vX5ArYCZUzBgAFVp7+xY7Bq40p/n+3nqErmbhDhurmElUX7cBkHxxLqzb/XylmS
         rc0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=UH3yB4pxhWDOZmrrDEACAckcyAZnSoSAcFUAb3vDM2w=;
        b=FKGrRa/UAT/4aQzkGMJiTSN7VekrQFfPFKbodsiBB8vWKNTuLGIeUCxlmvh15j6Kd/
         Fc8JSs7W4UegGedbIubexGh1yWs5iY7qp2ZMwGVGU3lBr0ZPdOGBkUt36R8ziFp4C0UZ
         ssalzNStWTcrjiTqEM0kkHKVP/bgJurKab4n6Nix4Ru0BhMm5DRaCBVUOkPrQd3ZWsEf
         4448F5rxvJur/E+A3DgsOiEX2oc1HHtc6HelHbYVDB2dY7VMA8+4m1AYBGNoaTyNumdD
         fj0x6UamJRA7/5+p7nP3XkriUtUS/XwcDFwiIvQ66Z1OkE0V4HFVac2Nnmqylcsh95m3
         b3eQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of srs0=chgh=ic=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=cHGH=IC=goodmis.org=rostedt@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of srs0=chgh=ic=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=cHGH=IC=goodmis.org=rostedt@kernel.org
Date: Tue, 15 May 2018 09:47:44 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Tobin C. Harding" <me@tobin.cc>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Linus Torvalds
 <torvalds@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, Kees
 Cook <keescook@chromium.org>, Anna-Maria Gleixner
 <anna-maria@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] vsprintf: Use hw RNG for ptr_key
Message-ID: <20180515094744.45267e97@gandalf.local.home>
In-Reply-To: <1526353586-30092-4-git-send-email-me@tobin.cc>
References: <1526353586-30092-1-git-send-email-me@tobin.cc>
	<1526353586-30092-4-git-send-email-me@tobin.cc>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600497770894213434?=
X-GMAIL-MSGID: =?utf-8?q?1600538089162793761?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 15 May 2018 13:06:26 +1000
"Tobin C. Harding" <me@tobin.cc> wrote:

> Currently we must wait for enough entropy to become available before
> hashed pointers can be printed.  We can remove this wait by using the
> hw RNG if available.
> 
> Use hw RNG to get keying material.
> 
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Tobin C. Harding <me@tobin.cc>
> ---
>  lib/vsprintf.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index b82f0c6c2aec..3697a19c2b25 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -1657,9 +1657,8 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
>  static bool have_filled_random_ptr_key __read_mostly;
>  static siphash_key_t ptr_key __read_mostly;
>  
> -static void fill_random_ptr_key(struct random_ready_callback *unused)
> +static void ptr_key_ready(void)
>  {
> -	get_random_bytes(&ptr_key, sizeof(ptr_key));
>  	/*
>  	 * have_filled_random_ptr_key==true is dependent on get_random_bytes().
>  	 * ptr_to_id() needs to see have_filled_random_ptr_key==true

Nothing to do with this patch, but I believe there's a missing memory
barrier in the code.

Right after this we have:

	smp_mb();
	WRITE_ONCE(have_filled_random_ptr_key, true);

Where the comment says that have_filled_random_ptr_key must be set
after ptr_key has been updated. But there's no memory barrier on the
read side. In fact, I think this could be a smp_wmb() instead of a
smp_mb(). The read side has:

	if (unlikely(!have_filled_random_ptr_key))
		return string(buf, end, "(ptrval)", spec);

/* Missing memory barrier smp_rmb() here. */

	hashval = (unsigned long)siphash_1u64((u64)ptr, &ptr_key);

Thus we can have something like:

	CPU0				CPU1
	----				----
				   load ptr_key = 0
   store ptr_key = random
   smp_mb()
   store have_filled_random_ptr_key

				   load have_filled_random_ptr_key = true

				    BAD BAD BAD!

I'll send a patch.

> @@ -1669,14 +1668,28 @@ static void fill_random_ptr_key(struct random_ready_callback *unused)
>  	WRITE_ONCE(have_filled_random_ptr_key, true);
>  }
>  
> +static void fill_random_ptr_key(struct random_ready_callback *unused)
> +{
> +	get_random_bytes(&ptr_key, sizeof(ptr_key));
> +	ptr_key_ready();
> +}
> +
>  static struct random_ready_callback random_ready = {
>  	.func = fill_random_ptr_key
>  };
>  
>  static int __init initialize_ptr_random(void)
>  {
> -	int ret = add_random_ready_callback(&random_ready);
> +	int ret;
> +	int key_size = sizeof(ptr_key);
> +
> +	/* Use hw RNG if available */
> +	if (get_random_bytes_arch(&ptr_key, key_size) == key_size) {
> +		ptr_key_ready();
> +		return 0;
> +	}
>  
> +	ret = add_random_ready_callback(&random_ready);
>  	if (!ret) {
>  		return 0;
>  	} else if (ret == -EALREADY) {

But this patch looks good.

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
