Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521149846; cv=none;
        d=google.com; s=arc-20160816;
        b=cXaVAqujh9O2KvLzouKw0w450cgLAlCMbmxmR6niUBtOQtCwl9Agi+h62vA8GBgmz0
         Zlynu5p+Mee34am3YE7Y9cvqbFBDtROAUPk7rP35BcmuhmLGI+ptYOhDMyh+2vPURgaZ
         Lu3qyoEn1+enjxi4CeL/M8DMg9phpZgGbd3FcQ/W7ofKAgal3kgKQR7pDYQG6qdiUpaW
         GijX9R4YZOoamI5sGNYxllxKbzvLvYPP5uv8OnQvKRovnACk75tgjfr+aOObI6Wrfi07
         MrtAVfmDzOvQS5NU1kiya2DRciYImp8vkHNYaa1nJBX539o2OnQ36nfImW9QXufoRMNY
         FQDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=DKBoUn6vPeWPe320PXGkYVlXIS3C3v/AusnLbUSF338=;
        b=KpmexayC9zXDE6/d62u5H7J4l3iZZocwhAUlALP0uNUDUs7HKb2nxodDPGti9jeJyC
         k5fRaW9a2/wgB3uU/16/sCHYZp96b87DtjOL2Pj/Wq1W2TubefoK5ul2UDopcVJnnbAU
         bODWAcAmKQyFaesIdk/B+m8/Fu/4CUKBGBSiebHCPTrIhDsdq101g9VVDFPyeFympEOP
         n1Nyd3YJ13umyZ0rci4X8V6b0HRno2dIu0j56iY354tUgqaEj0AjF/P9NWb9It5HD7Wn
         f4J9hVBvyxbRObuNcmbOtj9m1DpU6kCKuf985LS7TQIttj5jZn0zll4h7Uqd6MZAQ34V
         SSHw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=BmNlrcxY;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=Zy55fkjE;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=BmNlrcxY;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=Zy55fkjE;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AG47ELvA7kpOW7bFfJktVXbIp2Vce52zLw3sa4wNP4DF021IybgYLzf7liWlVRfjcFuq60QIEOFLktB6/WmIczbMJUw=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <32268431948dc1a32264a98a76d41d71ae7536b3.1521141122.git.msuchanek@suse.de>
References: <20180313200108.GA4082@hirez.programming.kicks-ass.net>
 <cover.1521141122.git.msuchanek@suse.de> <32268431948dc1a32264a98a76d41d71ae7536b3.1521141122.git.msuchanek@suse.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 15 Mar 2018 14:37:25 -0700
X-Google-Sender-Auth: iQ7cUsRUq3VE_Ip1UzWov4tM_Nk
Message-ID: <CA+55aFw8LJ7T_4jTe4q5q0d2JuP0iBWdwcTXZULKe-c4w7QrPA@mail.gmail.com>
Subject: Re: [PATCH RFC rebase 2/9] powerpc: Use barrier_nospec in copy_from_user
To: Michal Suchanek <msuchanek@suse.de>
Cc: ppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
	Michael Neuling <mikey@neuling.org>, "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
	Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
	"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, Daniel Axtens <dja@axtens.net>,
	Nicholas Piggin <npiggin@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>,
	David Gibson <david@gibson.dropbear.id.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
	Masami Hiramatsu <mhiramat@kernel.org>, Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
	Philippe Ombredanne <pombredanne@nexb.com>, Joe Perches <joe@perches.com>,
	"Oliver O'Halloran" <oohall@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
	"Tobin C. Harding" <me@tobin.cc>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595032347068746375?=
X-GMAIL-MSGID: =?utf-8?q?1595041221789459159?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 15, 2018 at 12:15 PM, Michal Suchanek <msuchanek@suse.de> wrote:
> This is based on x86 patch doing the same.
>
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
> --- a/arch/powerpc/include/asm/uaccess.h
> +++ b/arch/powerpc/include/asm/uaccess.h
> @@ -258,8 +259,10 @@ do {                                                               \
>         long __gu_err = -EFAULT;                                        \
>         unsigned long  __gu_val = 0;                                    \
>         const __typeof__(*(ptr)) __user *__gu_addr = (ptr);             \
> +       int can_access = access_ok(VERIFY_READ, __gu_addr, (size));     \
>         might_fault();                                                  \
> -       if (access_ok(VERIFY_READ, __gu_addr, (size)))                  \
> +       barrier_nospec();                                               \
> +       if (can_access)                                                 \
>                 __get_user_size(__gu_val, __gu_addr, (size), __gu_err); \
>         (x) = (__force __typeof__(*(ptr)))__gu_val;                             \
>         __gu_err;                                                       \

Is the above really correct? The barrier is *before* the conditional
branch that might be mis-predicted.

I don't know how the ppc barrier works, but that sounds completely bogus.

               Linus
