Return-Path: <prvs=577c13ff8=Rasmus.Villemoes@prevas.se>
X-Google-Smtp-Source: AH8x227ALeG8/Bc3ahC4zmW9eSMBziKN0yUr5XvKeOsWlWl6t59HTMPMbxVechBKxU6MNCjP1QkE
ARC-Seal: i=1; a=rsa-sha256; t=1518703522; cv=none;
        d=google.com; s=arc-20160816;
        b=V3St0mHAgG66n6ZsdNk0SRz3qEEwCmXaBI+IN87nGGrnuXyCRNKlmW61YWbrZg80pB
         w8/06p537vEhjKj1Yn7g9SWsRpUSTtK1EOaIxbOosP//WEKOrIOe3hbKEbS0FgyZa6gX
         TIOwyMaMWjMDDl5q9KMmRsu8V1F4Xz9zwx6jzNM/iM1ye9LOSpMqMD8Y3Z4T6z+LqmJ+
         7JzZ9rrFKSD6zbiL8VOY0gxnMGY7x1hAMUGekRF4UKkMzBgQ5HuxmEEOcOd9TrjtcNYw
         rKSr4CnUTKmUXvhkSbwoEUNeQStI/CYAOzxoHg7bSbemMKMZAhJgzCCA/WEjAccb/rTY
         EjCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=F0mpWxBSUL/bc1P4fwCE/IPvjmz2v+OtgMY4PWU7UnM=;
        b=N4yBDvj4rkAfUdlQrj8eDrShPN6k2DII6kUp36wFW+RptTwJ15zC15xcpZPRNXtzTY
         p/qF/sQsJtyffYB8fGtCimjquC5TxBv8cp9AWAyrBqtLSfqJCkpmd77uukG5N86ACZzj
         s5mgSA8Wfh1Fs3X8kbQJhjPjFtulrrFX1AbBDj5I/6uItaZF3SLNyIDXJ+9lJs73o4yy
         poPCeJn6GG3YIC/X5IiMbRQjslg/wIrKUQ6GdZDXXe8Nj9gKQe96sKXc2mFBt4r2bQMT
         mCrWr0HeRNP+SAy560xYCfGmwKkeL5EMu/zyPWCewSj2gKkZowROUhYMuGDghU77u4Wf
         Ucbg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@prevas.dk header.s=ironport2 header.b=X2Jo6LzM;
       spf=pass (google.com: best guess record for domain of prvs=577c13ff8=rasmus.villemoes@prevas.se designates 62.95.78.10 as permitted sender) smtp.mailfrom=prvs=577c13ff8=Rasmus.Villemoes@prevas.se
Authentication-Results: mx.google.com;
       dkim=pass header.i=@prevas.dk header.s=ironport2 header.b=X2Jo6LzM;
       spf=pass (google.com: best guess record for domain of prvs=577c13ff8=rasmus.villemoes@prevas.se designates 62.95.78.10 as permitted sender) smtp.mailfrom=prvs=577c13ff8=Rasmus.Villemoes@prevas.se
X-IronPort-AV: E=Sophos;i="5.46,517,1511823600";
   d="scan'208";a="3070565"
Subject: Re: [PATCH] posix-timers: Protect posix clock array access against
 speculation
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
CC: Ingo Molnar <mingo@kernel.org>, Linus Torvalds
	<torvalds@linux-foundation.org>, David Woodhouse <dwmw@amazon.co.uk>, Dan
 Williams <dan.j.williams@intel.com>, Greg KH <gregkh@linuxfoundation.org>
References: <alpine.DEB.2.21.1802151424490.1296@nanos.tec.linutronix.de>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <45f8dece-e235-0831-4fe5-89ee7d27b959@prevas.dk>
Date: Thu, 15 Feb 2018 15:05:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1802151424490.1296@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.8.31]
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592473683460033132?=
X-GMAIL-MSGID: =?utf-8?q?1592476065553077530?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-02-15 14:27, Thomas Gleixner wrote:
> The (clock) id argument of clockid_to_kclock() comes straight from user
> space via various syscalls and is used as index into the posix_clocks
> array.
> 
> Protect it against spectre v1 array out of bounds speculation.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: stable@vger.kernel.org
> ---
>  kernel/time/posix-timers.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> --- a/kernel/time/posix-timers.c
> +++ b/kernel/time/posix-timers.c
> @@ -50,6 +50,7 @@
>  #include <linux/export.h>
>  #include <linux/hashtable.h>
>  #include <linux/compat.h>
> +#include <linux/nospec.h>
>  
>  #include "timekeeping.h"
>  #include "posix-timers.h"
> @@ -1346,11 +1347,14 @@ static const struct k_clock * const posi
>  
>  static const struct k_clock *clockid_to_kclock(const clockid_t id)
>  {
> +	clockid_t idx = id;
> +
>  	if (id < 0)
>  		return (id & CLOCKFD_MASK) == CLOCKFD ?
>  			&clock_posix_dynamic : &clock_posix_cpu;
>  
>  	if (id >= ARRAY_SIZE(posix_clocks) || !posix_clocks[id])
>  		return NULL;
> -	return posix_clocks[id];
> +
> +	return posix_clocks[array_index_nospec(idx, ARRAY_SIZE(posix_clocks))];
>  }
> 

Stupid questions from someone trying to learn what the rules for when
and how to apply these _nospec macros:

(1) why introduce the idx var? There's no assignment to it other than
the initialization. Is it some magic in array_index_nospec that prevents
the use of a const-qualified expression?

(2) The line "if (id >= ARRAY_SIZE(posix_clocks) || !posix_clocks[id])"
still seems to allow speculatively accessing posix_clocks[id]. Is that
ok, and even if so, wouldn't it be cleaner to elide the
!posix_clocks[id] check and just return the NULL safely fetched from the
array in the following line?

Rasmus
