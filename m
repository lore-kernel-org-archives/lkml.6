Return-Path: <me@tobin.cc>
X-Google-Smtp-Source: AB8JxZowi7Xtnh5tnLor6+anc5tv0sCTyUf2YMsC5VT/AgN09Qa0SV5gQ/WJG+fGmgopUzBe6FCQ
ARC-Seal: i=1; a=rsa-sha256; t=1525218270; cv=none;
        d=google.com; s=arc-20160816;
        b=jn8wZQsvE+5yYGCo4hO42a0ZuVf1xn6dC/py4PkzQhbp/ecAPbGcs8G5K5Jm0NGwJ6
         sxmpeXfKL6Ss5Cx/sA8cCdKf6jTBhLcGbTNBBD3GHBeZYK+n7IGbl/Xg1c4n0wdHjtLx
         X49O8N9snNRO9GTVxQYyl4hksd4G2tJvqmDsml0xtGMESDh9yS0oCVOJTkuv9rT5bdUF
         y+ks+GvWhnutbqAvIivgAlauym+fgkfvriDoLsLbx4oa5qnT75wbweG3S6S1zhHEV/9N
         Igd2aTPawIi7kvGpiMia9ifPICH4fAww0okNttRXlcJ43HHvpdyYtY23/37QaT8b4WHP
         rJTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=5YSdNmSVOiv7CsHy1xC496cBTzIdiL75rAtgSMnL4ZA=;
        b=b3bRPLGkYyHsr1jeMdczOdMuyptSTgYwZsZiCrX9pJSr3LKNgO1q/VFAuwR+zTb3+Y
         15KZyrP78NgPEMBDCbiMQ7HLkMEHdlLid+C6NAqvj3uLG0ROnizq7O8aj6ZGoQUNxDEu
         oHN+ZNBKIQVEQl1azBxLel8jGE0qBXzcX90Fw6ccKmm3bo8im1DSIgTW/BkQD/IuVVb7
         V8R9s2yUWCi0ruj3WcG3qZGmYDs20JpR/hG+x1oHFNoTRmSoHFlQyw5lsOxvqFryOWC8
         Aa2SBaJ371uSIvViDsmcsYemUH3LKqJoK/cMaYFX3ol6cMi1nngU0P4Y0g6uyW5zTq+d
         SZfQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=GdfqTPLl;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=WGfbI1LC;
       spf=neutral (google.com: 66.111.4.26 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm3 header.b=GdfqTPLl;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=WGfbI1LC;
       spf=neutral (google.com: 66.111.4.26 is neither permitted nor denied by best guess record for domain of me@tobin.cc) smtp.mailfrom=me@tobin.cc
X-ME-Sender: <xms:3fvoWryF76IiTjEjUN-ZFqpuHWe475L0P9iFJaLVrdRv3f2jjOh-yg>
Date: Wed, 2 May 2018 09:44:25 +1000
From: "Tobin C. Harding" <me@tobin.cc>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Kees Cook <keescook@chromium.org>,
	Anna-Maria Gleixner <anna-maria@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/3] random: Return nbytes filled from hw RNG
Message-ID: <20180501234425.GB3791@eros>
References: <1525217620-4107-1-git-send-email-me@tobin.cc>
 <1525217620-4107-3-git-send-email-me@tobin.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525217620-4107-3-git-send-email-me@tobin.cc>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599306642017406992?=
X-GMAIL-MSGID: =?utf-8?q?1599307273696703795?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 02, 2018 at 09:33:39AM +1000, Tobin C. Harding wrote:
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
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Tobin C. Harding <me@tobin.cc>
> ---
>  drivers/char/random.c  | 16 +++++++++-------
>  include/linux/random.h |  2 +-
>  2 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 031d18b31e0f..3a66507ea60b 100644
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
>  
> -	trace_get_random_bytes_arch(nbytes, _RET_IP_);
> -	while (nbytes) {
> +	trace_get_random_bytes_arch(left, _RET_IP_);
> +	while (left) {
>  		unsigned long v;
> -		int chunk = min(nbytes, (int)sizeof(unsigned long));
> +		int chunk = min(left, (int)sizeof(unsigned long));
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
> index 2ddf13b4281e..308168c0a637 100644
> --- a/include/linux/random.h
> +++ b/include/linux/random.h
> @@ -38,7 +38,7 @@ extern void get_random_bytes(void *buf, int nbytes);
>  extern int wait_for_random_bytes(void);
>  extern int add_random_ready_callback(struct random_ready_callback *rdy);
>  extern void del_random_ready_callback(struct random_ready_callback *rdy);
> -extern void get_random_bytes_arch(void *buf, int nbytes);
> +extern int get_random_bytes_arch(void *buf, int nbytes);
>  
>  #ifndef MODULE
>  extern const struct file_operations random_fops, urandom_fops;
> -- 
> 2.7.4
> 

Tested by loading a module with this init funciton

static int __init test_init(void)
{
	const int size = 256;
	char buf[size];
	int got;

	pr_info("test: module inserted\n");

	got = get_random_bytes_arch(buf, size);
	if (got != size)
		pr_warn("get_random_bytes_arch() failed, got %d bytes\n", got);

	return 0;
}
module_init(test_init);


Fails on machine without RDRAND and succeeds on machine with RDRAND

thanks,
Tobin.
