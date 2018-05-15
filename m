Return-Path: <SRS0=cHGH=IC=goodmis.org=rostedt@kernel.org>
X-Google-Smtp-Source: AB8JxZooVSOTa88ZCUI9P2HHSuDX3sqWxawqdwQWSYs1lf/HTHgwbXo5Xbmh/C+5aovSUc64oP5m
ARC-Seal: i=1; a=rsa-sha256; t=1526394811; cv=none;
        d=google.com; s=arc-20160816;
        b=kBIeuLoJW0p7nXyHzk4hVjdiPDt8uGPMYU7HRCQHdZiRbhqW5BMSY1sIHILHTp+IJY
         KBwsuo8L0VGyoHHjgnTBJHnA/a3Uun9f6bOC7FUGaABnCTRs6YOl76RxhrrlS5+iujFJ
         OhfgQEOstlaC1M7a8z86T1uTQI6Sa4TJFpG4vp7zMDdVJt4Hr1Xuz8/RgYZmJfH1l/Z5
         cHMQptzQh7bAQhEKaCAkHdzl6NA7KOVdUhmQZheAnt+sE2XRxoyHQXmn0aZXvzyQJAXJ
         gX6XncX5Bjush6KaWJibJleT2g/+s6QUSlYTGwiJs0EbNtn5XnOfoiPnuQ6dz6JET3Iu
         MIlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=2wwZbnXCsOrVxwC3iYBmDHMHXbULlGmJNYz+0yweTbc=;
        b=Px6ySLXJYkL8S9Alq1qJ5xDO5EBcTPC1Lj7d1x1G8meT7940s7KMguuz6q2ICEHzhx
         q8HxNx1sllhgVjgz9M0DC8mshtkkmmSws1hjb7gtY69zzGvz+TU4++AZ9wsh4aZG0ufe
         bau5Id9O6W+3iAEQp8HBeMDCaT4in9QLsjupZXDpyn+Kpqsbm82lAJdPnkSvtiZiRKyO
         0WUIjVSlDTqwUnfwjLBjId5GTgt0equZel4odg8mRZWOR5uiumM2MOCDake6Db4QBO/r
         eB6zllR0srZA7CQ9q2c7FUrdOP57VDYCnHfm66zIblOKHQtApWk1aFF+/QZXbbG+b8FH
         BAvg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of srs0=chgh=ic=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=cHGH=IC=goodmis.org=rostedt@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of srs0=chgh=ic=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=cHGH=IC=goodmis.org=rostedt@kernel.org
Date: Tue, 15 May 2018 10:33:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc: "Tobin C. Harding" <me@tobin.cc>, Andrew Morton
 <akpm@linux-foundation.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, Kees
 Cook <keescook@chromium.org>, Theodore Ts'o <tytso@mit.edu>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vsprintf: Add command line option debug_boot_weak_hash
Message-ID: <20180515103328.4dc32cd8@gandalf.local.home>
In-Reply-To: <1526359115-5489-1-git-send-email-me@tobin.cc>
References: <1526359115-5489-1-git-send-email-me@tobin.cc>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600503563774077130?=
X-GMAIL-MSGID: =?utf-8?q?1600540965767467064?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Anna-Maria,

Can you test this patch on that kernel you were having issues with (the
one triggering the RCU stalls, and not having entropy to show the
pointers of the timer events).

And report back what you find.

Thanks!

-- Steve


On Tue, 15 May 2018 14:38:35 +1000
"Tobin C. Harding" <me@tobin.cc> wrote:

> Currently printing [hashed] pointers requires enough entropy to be
> available.  Early in the boot sequence this may not be the case
> resulting in a dummy string '(____ptrval____)' being printed.  This
> makes debugging the early boot sequence difficult.  We can relax the
> requirement to use cryptographically secure hashing during debugging.
> This enables debugging while keeping development/production kernel
> behaviour the same.
> 
> If new command line option debug_boot_weak_hash is enabled use
> cryptographically insecure hashing and hash pointer value immediately.
> 
> Signed-off-by: Tobin C. Harding <me@tobin.cc>
> ---
> 
> This patch was previously submitted as the last in the set
> 
> 	[PATCH v3 0/4] enable early printing of hashed pointers
> 
> Helps debugging using ftrace.  Original problem reported by Anna-Maria,
> solution requested by Steve.
> 
> Changes since above mentioned patch set
>  - change option name from debug_early_boot -> debug_boot_weak_hash
>    (suggested by Steve).
> 
> 
> I have only tested this by enabling the option and printing some
> pointers.  This does not _prove_ that it fixes the ftrace issue.
> 
> thanks,
> Tobin.
> 
> 
>  Documentation/admin-guide/kernel-parameters.txt |  8 ++++++++
>  lib/vsprintf.c                                  | 18 ++++++++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 3b8032431585..c95dd6704592 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -748,6 +748,14 @@
>  
>  	debug		[KNL] Enable kernel debugging (events log level).
>  
> +	debug_boot_weak_hash
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
> index b82f0c6c2aec..5ff18f8fe3bd 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -1654,6 +1654,18 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
>  	return widen_string(buf, buf - buf_start, end, spec);
>  }
>  
> +/* Make pointers available for printing early in the boot sequence. */
> +static int debug_boot_weak_hash __ro_after_init;
> +EXPORT_SYMBOL(debug_boot_weak_hash);
> +
> +static int __init debug_boot_weak_hash_enable(char *str)
> +{
> +	debug_boot_weak_hash = 1;
> +	pr_info("debug_boot_weak_hash enabled\n");
> +	return 0;
> +}
> +early_param("debug_boot_weak_hash", debug_boot_weak_hash_enable);
> +
>  static bool have_filled_random_ptr_key __read_mostly;
>  static siphash_key_t ptr_key __read_mostly;
>  
> @@ -1694,6 +1706,12 @@ static char *ptr_to_id(char *buf, char *end, void *ptr, struct printf_spec spec)
>  	const char *str = sizeof(ptr) == 8 ? "(____ptrval____)" : "(ptrval)";
>  	unsigned long hashval;
>  
> +	/* When debugging early boot use non-cryptographically secure hash */
> +	if (unlikely(debug_boot_weak_hash)) {
> +		hashval = hash_long((unsigned long)ptr, 32);
> +		return pointer_string(buf, end, (const void *)hashval, spec);
> +	}
> +
>  	if (unlikely(!have_filled_random_ptr_key)) {
>  		spec.field_width = 2 * sizeof(ptr);
>  		/* string length must be less than default_width */
