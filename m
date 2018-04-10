Return-Path: <christian.brauner@canonical.com>
X-Google-Smtp-Source: AIpwx49IUbd/5+KCsy+iKdhAOffopVcYvqVTS5bXEDUyUtyqDDhKMsxAF6Eoa0w3zLQ0CIHMy3OE
ARC-Seal: i=1; a=rsa-sha256; t=1523353556; cv=none;
        d=google.com; s=arc-20160816;
        b=iTSE8jIuHi8xkuG9gqZwcJ9LaZrecmI60sJYTNMdDoiKO8Yo3pU8SLsZG1Nl5p9PvO
         yPq04Mrbs43PfbOAMzZIFgnw5t4DHhJ/gg//KaRIlQsXE8cC4yWjP/MOdSHysTyiXKrc
         87X1L0UuBCYy4fNc4peOLUvx9fRGU94IE7bGH1qBx9XMZdo4bgaPJsmOVBbd5IXKa/NP
         6jkSUx6zdRXM93IqD/c+4doqNiOQ8P8LubRPhsfGlJmBj9wRvMLHMHlx2vzVLISQPyNz
         Rb3LyWcvju45DXIjva937ae4ZeuK/Mw64C2Mk2DF+tuV/uAeJQUgBvphRAK2fG2HXQfs
         ycGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:date:from:arc-authentication-results;
        bh=T56J4vJuFd7gXRRaUmw73seQWF7s8or5RcZdMVqLTCA=;
        b=Vi9IOKS/ND7QGIVBJyV1NgQF6+NjsjD6SYJnRFdujgYJOrVw61R9bprGfprpp8U/tD
         +u2greSpW6JouRKvMGwRk4l/50bucuBJ2ysc41VPXnsbhF5yMvSVt0kv6aJwRwI0BDNp
         9Wl7A+1vMGB3NfA2TdzvEgjavGUYQ4TEOEDsaT4E6GX7e84O76KJVPCCKWUzKBv0WGkd
         pZHAcb2pZsD7Q5jfDn8gqUtN3MZNTP2y9xh676iJNJ1PIsBsFf/bkYg3pYk1nKvuNIm/
         4idXIyS16yBj5GSOLgAcuK3uxRZysIZb7utTzjnKi5Tq5k0y+iX6W20dOcmDhDoTa8rF
         3wXA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of christian.brauner@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=christian.brauner@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of christian.brauner@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=christian.brauner@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
From: Christian Brauner <christian.brauner@canonical.com>
X-Google-Original-From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Tue, 10 Apr 2018 11:45:54 +0200
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: shuahkh@osg.samsung.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk,
	ebiederm@xmission.com, torvalds@linux-foundation.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH] selftests/filesystems: Don't run dnotify_test by default
Message-ID: <20180410094553.GB3438@gmail.com>
References: <20180410062053.8816-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180410062053.8816-1-mpe@ellerman.id.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597339082431063754?=
X-GMAIL-MSGID: =?utf-8?q?1597351978871606209?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 10, 2018 at 04:20:53PM +1000, Michael Ellerman wrote:
> In commit ce290a19609d ("selftests: add devpts selftests"), the
> filesystems directory was added to the top-level selftests Makefile.
> 
> That had the effect of causing the existing dnotify_test in the
> filesystems directory to now be run as part of the default selftests
> test-run. Unfortunately dnotify_test is actually an infinite loop.
> 
> Fix it by moving dnotify_test to TEST_GEN_PROGS_EXTENDED, which says
> that it's a generated file (ie. built) but should not be run as part
> of the default test suite run (it's an "extendend" test).
> 
> While we're here cleanup a few other things, devpts_pts should be in
> TEST_GEN_PROGS to indicate that it's built, and with the above two
> changes we no longer need a custom all or clean rule.
> 
> Fixes: ce290a19609d ("selftests: add devpts selftests")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

I'm not sure if I should've made it to be built given that it wasn't
before but it probably doesn't hurt. It's either that or remove it I
guess.

Acked-by: Christian brauner <christian.brauner@ubuntu.com>

> ---
>  tools/testing/selftests/filesystems/Makefile | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/filesystems/Makefile b/tools/testing/selftests/filesystems/Makefile
> index 4e6d09fb166f..5c7d7001ad37 100644
> --- a/tools/testing/selftests/filesystems/Makefile
> +++ b/tools/testing/selftests/filesystems/Makefile
> @@ -1,8 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
> -TEST_PROGS := dnotify_test devpts_pts
> -all: $(TEST_PROGS)
>  
> -include ../lib.mk
> +TEST_GEN_PROGS := devpts_pts
> +TEST_GEN_PROGS_EXTENDED := dnotify_test
>  
> -clean:
> -	rm -fr $(TEST_PROGS)
> +include ../lib.mk
> -- 
> 2.14.1
> 
