Return-Path: <SRS0=nskh=FK=goodmis.org=rostedt@kernel.org>
X-Google-Smtp-Source: AH8x227WbcU1WHQQCGr3PP7nQPVjHfvUXr0+ln60kbGWq1MLXhUjknYo73sFM4dZHhGiXBLzUsr9
ARC-Seal: i=1; a=rsa-sha256; t=1518818629; cv=none;
        d=google.com; s=arc-20160816;
        b=rpSuteoK9L5YIvtrcizT3zyoP4qGu7JFVxo1j+1yVMlhhdA34BWH33W+EtpQTBMPU6
         uEovP40MD0T4fC2hk9OLMa0a7mISGvYZ7W9GS0F2xJUvbWqnu0UyEjBBc6mDi4EcySwe
         ua0CReSylLt6XohhvzAoGadsrjh9mjncrlBRVJElMqxw7FR0OG2Pt9YbpYXt0gkuYbMM
         FQdCqZZjabDg1FfYdmnIWv4+O4bmaG9fwmHCujzq3kGs4Dh7ZUV1HLMy8lOO9BW2WVMY
         KmOS40J0zrp7MoFkK13RN2euKN56LRtbzXGsOr4JjPVcx2jKGz/0yWebD/VbF2laJLlC
         COpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=3TAI1Xqd8qEMwM4wZLoIND8AR8hKpIEguxTIhtxZG2M=;
        b=wJ24mNYjyMJ7ODjAjqmTEiAu8WdJEMpODdSNLmn+Y+aFS6IEwIhrdwZ0Lf36+IIjRa
         TMVEcICdT6pWTK56lUARed4CXr1ToqI+Igt3GihNfrvsWraMBpK8cJ06VbfMO4hoN00N
         TYe+3per2At5PwCu4CV9cnbOiH0M6hatx7xJjThroKP1gqNNd14JAH44vpCsbKRtrhrL
         f8Pfkfu8aGhrgxrtZZ6V55RPDaicfenFetTi/wsesoiv8RiF6mPokJq49s4RwGMwknw3
         ZcfqWuan4s8/5AYq6viPiDLVmwSmx5EwNFRheFgqyorzyYNk8+QF9YZz0LgCgw6KCUio
         nTRQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=nskh=fk=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nskh=FK=goodmis.org=rostedt@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=nskh=fk=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nskh=FK=goodmis.org=rostedt@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65116217A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Fri, 16 Feb 2018 17:03:46 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kbuild@vger.kernel.org, "Yann E . MORIN"
 <yann.morin.1998@free.fr>, Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michal Marek <mmarek@suse.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Ingo Molnar
 <mingo@redhat.com>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 1/3] Kconfig: disable PROFILE_ALL_BRANCHES for compile
 testing
Message-ID: <20180216170346.497114b3@gandalf.local.home>
In-Reply-To: <20180216214117.1947175-2-arnd@arndb.de>
References: <20180216214117.1947175-1-arnd@arndb.de>
	<20180216214117.1947175-2-arnd@arndb.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592595400950841912?=
X-GMAIL-MSGID: =?utf-8?q?1592596763710596422?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 16 Feb 2018 22:41:11 +0100
Arnd Bergmann <arnd@arndb.de> wrote:

> This can easily double the time for compiling a driver but does not
> provide any benefit for the compile tester, so it's better left disabled.
> 
> In addition, any 'inline' function that is not also 'static' and that
> contains an 'if' causes a warning like
> 
> include/linux/string.h:212:2: note: in expansion of macro 'if'
>   if (strscpy(p, q, p_size < q_size ? p_size : q_size) < 0)
>   ^~
> include/linux/compiler.h:162:4: warning: '______f' is static but declared in inline function 'strcpy' which is not static
> 
> without this patch, and I could not come up with a nice fix for that.
> In combination with my patch to always enable 'CONFIG_COMPILE_TEST'
> during 'randconfig' builds, we can at least hide these warnings for
> most users.

This looks like it fixes the same issue that was already fixed and is
in Linus's tree.

 http://lkml.kernel.org/r/9199446b-a141-c0c3-9678-a3f9107f2750@infradead.org

See commit 68e76e034b6b1 ("tracing: Prevent PROFILE_ALL_BRANCHES when
FORTIFY_SOURCE=y")

-- Steve
