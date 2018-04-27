Return-Path: <dan.rue@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524846885; cv=none;
        d=google.com; s=arc-20160816;
        b=Lz2+yUl/9uLn9nmmumDuCNyL4a1fbp3TAsq4Vlo8GBnMIEg3QEOPt/P582jSKjafgr
         F5vjLxdpR2kpyMCcbcKYQgxSi4oAof3o+ReetnhwykjuDPY1gJ0cl66BNQCVx1p1ysdV
         iGZxkzGJY8HTP8D+bFNUmxT5BIq7yDZrY9e3PwmRywfppD/Q+/WzKCgYejFkn7wBLoM9
         0Ivc9IaDZGU1iCCfMNXDQSgV79E1yGgjaWwpunzBZ9xekXQNPgC7QH/G+21Tf3ijczGZ
         uXBQx6PyyOXmBUEaOCK7ood5vb1FGfQKmkdXs9t+ds+tRQSXOacENd4MBmLrc1UsFwYY
         qcyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=oFywfgTXT+dWZgWENVhDCqJuJymwTpwuyetSq0LB3VM=;
        b=V8iIX8Jc5MIrWN/scVKa/kzt4E7ycEaMcDiy+UNQzvL9qHiEg4IwB9JCq7Q/QRziAf
         X2ZB0LXWrXSha5Mn31tieGEP1yA5Kyg4wSWKKX7GrbHiEi32A1IfANoHe1dXHKhfODjS
         7jgycmb1Ey66SkMNe9YCJAYBdsmjyMKOVwxuXseMTrg8T+76rZXcDgfgj4AEicQJs2Ql
         NUrY6NaQKIl2dPXRec8mhg8+Hie8jmtSrBCrD1Xlwq5jRigvn23Qjgm7tRpy8L50ZSee
         U10KqsX55wHCr+t2yBWhEmAnjN7t78LYh8ubVlNyYxvntc73muZCuyWvedLDVYWJAEnG
         Lo3w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=dq9IqEbV;
       spf=pass (google.com: domain of dan.rue@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=dan.rue@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=dq9IqEbV;
       spf=pass (google.com: domain of dan.rue@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=dan.rue@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZqL2dMEPXdzyBvtLgOvvsPDEVtjiM5FVLh8GdX4uzgooYTAC2U/eQgfyKXeEWajZh/M2vR/rw==
Date: Fri, 27 Apr 2018 11:34:43 -0500
From: Dan Rue <dan.rue@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jann Horn <jannh@google.com>, Theodore Tso <tytso@mit.edu>,
	stable@kernel.org, Thierry Escande <thierry.escande@linaro.org>,
	Nicolas Dechesne <nicolas.dechesne@linaro.org>
Subject: Re: [PATCH 4.16 163/196] random: fix crng_ready() test
Message-ID: <20180427163443.fdsixdsrwwkycuhh@xps>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jann Horn <jannh@google.com>, Theodore Tso <tytso@mit.edu>,
	stable@kernel.org, Thierry Escande <thierry.escande@linaro.org>,
	Nicolas Dechesne <nicolas.dechesne@linaro.org>
References: <20180422135104.278511750@linuxfoundation.org>
 <20180422135112.655853962@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180422135112.655853962@linuxfoundation.org>
User-Agent: NeoMutt/20180323
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598455333623900338?=
X-GMAIL-MSGID: =?utf-8?q?1598917847643237511?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 22, 2018 at 03:53:03PM +0200, Greg Kroah-Hartman wrote:
> 4.16-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Theodore Ts'o <tytso@mit.edu>
> 
> commit 43838a23a05fbd13e47d750d3dfd77001536dd33 upstream.
> 
> The crng_init variable has three states:
> 
> 0: The CRNG is not initialized at all
> 1: The CRNG has a small amount of entropy, hopefully good enough for
>    early-boot, non-cryptographical use cases
> 2: The CRNG is fully initialized and we are sure it is safe for
>    cryptographic use cases.
> 
> The crng_ready() function should only return true once we are in the
> last state.  This addresses CVE-2018-1108.
> 
> Reported-by: Jann Horn <jannh@google.com>
> Fixes: e192be9d9a30 ("random: replace non-blocking pool...")
> Cc: stable@kernel.org # 4.8+
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> Reviewed-by: Jann Horn <jannh@google.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This patch has caused a regression on 4.16 using kselftest lib/printf.sh
- specifically, when it runs "/sbin/modprobe test_printf". This
regression has been detected on arm64 dragonboard 410c (not seen on
other arm64 or x86_64 devices).

    /sbin/modprobe test_printf
    [   22.725551] test_printf: hashing plain 'p' has unexpected format
    [   22.726031] test_printf: failed 1 out of 236 tests
    modprobe: ERROR: could not insert 'test_printf': Invalid argument

This problem has not been seen on 4.9 or 4.14 under the same
conditions.

Dan

> 
> ---
>  drivers/char/random.c |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -427,7 +427,7 @@ struct crng_state primary_crng = {
>   * its value (from 0->1->2).
>   */
>  static int crng_init = 0;
> -#define crng_ready() (likely(crng_init > 0))
> +#define crng_ready() (likely(crng_init > 1))
>  static int crng_init_cnt = 0;
>  #define CRNG_INIT_CNT_THRESH (2*CHACHA20_KEY_SIZE)
>  static void _extract_crng(struct crng_state *crng,
> @@ -793,7 +793,7 @@ static int crng_fast_load(const char *cp
>  
>  	if (!spin_trylock_irqsave(&primary_crng.lock, flags))
>  		return 0;
> -	if (crng_ready()) {
> +	if (crng_init != 0) {
>  		spin_unlock_irqrestore(&primary_crng.lock, flags);
>  		return 0;
>  	}
> @@ -855,7 +855,7 @@ static void _extract_crng(struct crng_st
>  {
>  	unsigned long v, flags;
>  
> -	if (crng_init > 1 &&
> +	if (crng_ready() &&
>  	    time_after(jiffies, crng->init_time + CRNG_RESEED_INTERVAL))
>  		crng_reseed(crng, crng == &primary_crng ? &input_pool : NULL);
>  	spin_lock_irqsave(&crng->lock, flags);
> @@ -1141,7 +1141,7 @@ void add_interrupt_randomness(int irq, i
>  	fast_mix(fast_pool);
>  	add_interrupt_bench(cycles);
>  
> -	if (!crng_ready()) {
> +	if (unlikely(crng_init == 0)) {
>  		if ((fast_pool->count >= 64) &&
>  		    crng_fast_load((char *) fast_pool->pool,
>  				   sizeof(fast_pool->pool))) {
> @@ -2214,7 +2214,7 @@ void add_hwgenerator_randomness(const ch
>  {
>  	struct entropy_store *poolp = &input_pool;
>  
> -	if (!crng_ready()) {
> +	if (unlikely(crng_init == 0)) {
>  		crng_fast_load(buffer, count);
>  		return;
>  	}
> 
> 
