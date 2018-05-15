Return-Path: <SRS0=cHGH=IC=goodmis.org=rostedt@kernel.org>
X-Google-Smtp-Source: AB8JxZqe7KZo6j8Og+LDxIPwv2QYgJmYxZpFooafrokqeUaLt352vpbBytJfpnOdXTrwf+Rd6z1A
ARC-Seal: i=1; a=rsa-sha256; t=1526391428; cv=none;
        d=google.com; s=arc-20160816;
        b=ld1+l3CAysCo7i5bXM7AS6TWTwd78Q70BoZerzMLvpoEM6wZcMr4l7MH0H4hinryNv
         W3MU1Vk7X38avf7271JI7O3bKtd0yeMisPxZWaA2HAFuDvxDB4HW7kBDr7bJ2vvZssK3
         FCmg4y3ffxrkY06aetkbMRUlNaOLddRG8x5OlL7Mxfi/b9QkS5/6NwMQMaPc+3nDGV+5
         KIxjMoMxgb6ZCKKBaxJ+fnz0qNqdW6b0NA4qVJABfrIFWsLJbyrJMsLf/VuFhMMd8nlg
         p4SnP8giOJcFmQqrNmySmLOm5eyAADFCeL6Sh8YhS9Lhg9+UaceM56lkKVS0BnpraYPZ
         cYKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=rV+tFjJOCNlhXLxii+7ZtSQhYpOun/0lJ73p/IGkQt4=;
        b=lIgpXTXlG+F7TApKvsv0VCLTRsqjp4BLfhtwEORBKFkgbdHUuERRiPodQ6DZdFnNUY
         h7lbOyHpewAvTNfhNJbHeSq7GJzfCsw3ND4WrIv841fqIRbajAqbC79kYr4brogS8QKv
         pN+fSQ9jCuLCK6sijZfUH/n4bx4woeWJ1yGh9nng3wj7iQLL+XrFr90aEUQ3Ts62FsC7
         MA0pjbUhjiOlQdH62ze0LGq6XbUh7L0DZ+YKtFbplAAb5BxC7SrAChmwLzf846V7X//I
         +aGHPg+RFYir5Xhni8miQ8aDZjZb8pbQG8Xf5LVvmDdsWlU6UnJjsUId4fE81y5HpneX
         p+EA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of srs0=chgh=ic=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=cHGH=IC=goodmis.org=rostedt@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of srs0=chgh=ic=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=cHGH=IC=goodmis.org=rostedt@kernel.org
Date: Tue, 15 May 2018 09:37:05 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Tobin C. Harding" <me@tobin.cc>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Linus Torvalds
 <torvalds@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, Kees
 Cook <keescook@chromium.org>, Anna-Maria Gleixner
 <anna-maria@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] random: Return nbytes filled from hw RNG
Message-ID: <20180515093705.03850c5a@gandalf.local.home>
In-Reply-To: <1526353586-30092-3-git-send-email-me@tobin.cc>
References: <1526353586-30092-1-git-send-email-me@tobin.cc>
	<1526353586-30092-3-git-send-email-me@tobin.cc>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600497767242955587?=
X-GMAIL-MSGID: =?utf-8?q?1600537418874372647?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 15 May 2018 13:06:25 +1000
"Tobin C. Harding" <me@tobin.cc> wrote:

> Currently the function get_random_bytes_arch() has return value 'void'.
> If the hw RNG fails we currently fall back to using get_random_bytes().
> This defeats the purpose of requesting random material from the hw RNG
> in the first place.
> 
> There are currently no intree users of get_random_bytes_arch().
> 
> Only get random bytes from the hw RNG, make function return the number
> of bytes retrieved from the hw RNG.
> 
> Signed-off-by: Tobin C. Harding <me@tobin.cc>
> Acked-by: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Tobin C. Harding <me@tobin.cc>
> ---
>  drivers/char/random.c  | 16 +++++++++-------
>  include/linux/random.h |  2 +-
>  2 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 031d18b31e0f..4b0ec597e783 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -1725,26 +1725,28 @@ EXPORT_SYMBOL(del_random_ready_callback);
>   * key known by the NSA).  So it's useful if we need the speed, but
>   * only if we're willing to trust the hardware manufacturer not to
>   * have put in a back door.
> + *
> + * Return number of bytes filled in.
>   */
> -void get_random_bytes_arch(void *buf, int nbytes)
> +int __must_check get_random_bytes_arch(void *buf, int nbytes)
>  {
>  	char *p = buf;
> +	int left = nbytes;

Just a nit, but I know some kernel devs prefer "upside-down-xmas-tree"
style of declarations. Which would make the above:

	int left = nbytes;
	char *p = buf;

>  
> -	trace_get_random_bytes_arch(nbytes, _RET_IP_);
> -	while (nbytes) {
> +	trace_get_random_bytes_arch(left, _RET_IP_);

Nothing to do with this patch series, but I wonder if we should move
the trace event below, and record how much was done.

> +	while (left) {
>  		unsigned long v;
> -		int chunk = min(nbytes, (int)sizeof(unsigned long));
> +		int chunk = min_t(int, left, (int)sizeof(unsigned long));
>  
>  		if (!arch_get_random_long(&v))
>  			break;
>  
>  		memcpy(p, &v, chunk);
>  		p += chunk;
> -		nbytes -= chunk;
> +		left -= chunk;
>  	}
>  
> -	if (nbytes)
> -		get_random_bytes(p, nbytes);
> +	return nbytes - left;
>  }
>  EXPORT_SYMBOL(get_random_bytes_arch);
>  
> diff --git a/include/linux/random.h b/include/linux/random.h
> index 2ddf13b4281e..f1c9bc5cd231 100644
> --- a/include/linux/random.h
> +++ b/include/linux/random.h
> @@ -38,7 +38,7 @@ extern void get_random_bytes(void *buf, int nbytes);
>  extern int wait_for_random_bytes(void);
>  extern int add_random_ready_callback(struct random_ready_callback *rdy);
>  extern void del_random_ready_callback(struct random_ready_callback *rdy);
> -extern void get_random_bytes_arch(void *buf, int nbytes);
> +extern int __must_check get_random_bytes_arch(void *buf, int nbytes);
>  
>  #ifndef MODULE
>  extern const struct file_operations random_fops, urandom_fops;

Other than that...

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
