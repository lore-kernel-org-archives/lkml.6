Return-Path: <acme@redhat.com>
X-Google-Smtp-Source: AIpwx48cqHLxktjL6jKysjIq5uZAvYqmroqCJGVn4aP1hGNowhSzYwKbWkX83Hw+drm18zcp4w+K
ARC-Seal: i=1; a=rsa-sha256; t=1521638988; cv=none;
        d=google.com; s=arc-20160816;
        b=e6PXEavt+tjEZoptllPQG93bboM1aOA/0/hwBd0KsSC0fec3iSHwSuRzVgAfd7yoaf
         JEP4HbtW4AakRaKo7shXjsG2BgfLzDm6Rp0Ug0Ga2gyhrxLiTigwAXb32kFMJPuzBwDh
         1i2AHGYHlxzSaz+Pu96lagn261/xWiaMRMOin+0aTS6iY5A8tYmEUGRlLm8zTayBGhne
         tyEPhN9Gch4nbjucuqGCBm42NSUrZrRsdtK6HbiH6aikl8t9cnRGZHpO1DGKVkNDOC2V
         XxkH+WrSnr8dCqIKt5fuilO+U58EuhJomShiiEgp/HZ9+fanoG+VybSjICCYaVcgRC4d
         S1Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=ny2k06OouqjRJF0lbcwzHTYBbCHbnqjKTO72x/Rltfc=;
        b=vUyQHWA5Rcf22V0SgqJLTqiOB6gFTiKgJEVhAkEXu1o7mjvs8P+5ZCdv21zaU2Fww4
         JBCwya4N2INKAgcbqlEGU/kF0+6UaIjg24vzpN0/SNbNsaZhyIq0nGkB9fiZit7E90xE
         1vVS1gt+QhozY+MVuKK2eqjbRzrGCsPTEpsAwe1hb/ZYGZuRqgkzcUDz1kAbYT+ZeJNX
         /xa3sZ9gkCFAqbfAmbbuPVhw6LAfKiP4oXYHNZOUuhJCNoh7zBKVqkTAgA8bZokPWYLR
         f8lD2LG2oInt5JPmJyJy/gsCYNaoI0/iq8phzPavAhm56sbOcnn/FReyzNXHKHJz2ThH
         ypKQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of acme@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=acme@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of acme@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=acme@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Date: Wed, 21 Mar 2018 10:29:38 -0300
From: Arnaldo Carvalho de Melo <acme@redhat.com>
To: valdis.kletnieks@vt.edu
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Laura Abbott <labbott@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: linux-next 20180320 compile failure - tools/lib/str_error_r.c
Message-ID: <20180321132938.GA3749@redhat.com>
References: <40533.1521564212@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40533.1521564212@turing-police.cc.vt.edu>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595475724335352111?=
X-GMAIL-MSGID: =?utf-8?q?1595554124224648281?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Em Tue, Mar 20, 2018 at 12:43:32PM -0400, valdis.kletnieks@vt.edu escreveu:
> Not sure who to blame here, or what changed in gcc between 0.16 and 0.19,
> or what the proper fix is here....
> 
> next-20180307 with "gcc version 8.0.1 20180222 (Red Hat 8.0.1-0.16)" built and runs fine.
> 
> next-20180320 with "gcc (GCC) 8.0.1 20180317 (Red Hat 8.0.1-0.19)"  dies a horrid death early
> during the compile:
> 
>   CC       /usr/src/linux-next/tools/objtool/str_error_r.o
> ../lib/str_error_r.c: In function 'str_error_r':
> ../lib/str_error_r.c:25:3: error: passing argument 1 to restrict-qualified parameter aliases with argument 5 [-Werror=restrict]
>    snprintf(buf, buflen, "INTERNAL ERROR: strerror_r(%d, %p, %zd)=%d", errnum, buf, buflen, err);
>    ^~~~~~~~
> cc1: all warnings being treated as errors
> mv: cannot stat '/usr/src/linux-next/tools/objtool/.str_error_r.o.tmp': No such file or directory
> make[3]: *** [Build:22: /usr/src/linux-next/tools/objtool/str_error_r.o] Error 1
> make[2]: *** [Makefile:46: /usr/src/linux-next/tools/objtool/objtool-in.o] Error 2
> make[1]: *** [Makefile:63: objtool] Error 2
> make: *** [Makefile:1681: tools/objtool] Error 2
> 

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=854e55ad289e

- Arnaldo
