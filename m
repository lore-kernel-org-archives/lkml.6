Return-Path: <kernel-hardening-return-12359-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsafchpMtNoSP6eKEtvN8ZbWa14Rdp0hs9bDlX6nD+xEzvQUu8lQbeQL2tt5aH5wUldsq1K
ARC-Seal: i=1; a=rsa-sha256; t=1520645524; cv=none;
        d=google.com; s=arc-20160816;
        b=BbXj3K+y6Q+N75qG1iH5D8k9dFvxGAOy+s4t/y7UwBePZzSjseM9aE2+2P5TGhWDPC
         1VPXnn5sjgUPxyW2/VKBkkFskYVdfHKrUDE51+Sjdrf7DWd9CXfPch7rDjOuKoYZEh2O
         tBPaIh4hgfFuN7uI/uGTr3GsbLsvYk4txGLBtD9qEcvGQeLQk6tDG0Wyyi9fhb6bcR0O
         PJsn5v9ONLOdy6NOA9coUZjIS5nWMboAzerP4XP1SlhlVDD+xKAmLJuPmK08bmXBeXmq
         0QGDm+oS4d2cpp7EAqGqoZjWUNV1tlQ8TLn3Cyb3XtgZe1rYSlEnN52D45SC5QDQ6C1r
         H6HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=O+BZfIxrYp/MkK/VA2DBjfvifkHaKPgztNM57PONceQ=;
        b=gTTKcsCU4HuBOJwKDACjQ88pUTsB49D2mQxEleJLpG6us098MLTOmnhVoBAmh1+3Vz
         sxRi3FaTxvmg+jnxuLY92e8ye8uh/Vc1mlYEoQ4U0NckgjT8ywQnl9FDxN3u1h+Oijci
         90gikkJYIuXRb1wTUq6VxTZcACsiAUrkxoiSZQgua5QgRRlnmcM2LvGt5gNRnJ3QMK/o
         +t7X96CY3fM0e2Iv9fGeEkG89G6lJkxwyMxAdjjalobFAt1QonyeL30OPxIgo8myWTkR
         ZWkBEhBAHt80GSju5ABdSBHUGCiVPo69D6Cc5cJWB8RXLYPoNANpQ+t7+Ig2rNxXi3o0
         UgCg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=DQgHy9+p;
       dkim=pass header.i=@chromium.org header.s=google header.b=jpGL1rsv;
       spf=pass (google.com: domain of kernel-hardening-return-12359-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12359-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=DQgHy9+p;
       dkim=pass header.i=@chromium.org header.s=google header.b=jpGL1rsv;
       spf=pass (google.com: domain of kernel-hardening-return-12359-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12359-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <CAGXu5j+D=zs8AMb969dhH05GmKPuBxKPcAs89KfKzVf47faL1g@mail.gmail.com>
References: <20180309200536.GA5670@beast> <20180309160719.154a3158e2d8ee56e43a918f@linux-foundation.org>
 <CA+55aFw9hWz1-YFVoHEiXDjqb9q7dz=rQVXr7YLkMuVLvbwaOg@mail.gmail.com>
 <20180309163241.a421e216999bd0b1f43a64c2@linux-foundation.org>
 <CA+55aFwbO2vUsjWzAwB6SZ65RM4r3P0+2JvyMHn=ry0CgWCBgA@mail.gmail.com> <CAGXu5j+D=zs8AMb969dhH05GmKPuBxKPcAs89KfKzVf47faL1g@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Fri, 9 Mar 2018 17:31:42 -0800
X-Google-Sender-Auth: KoSrw8PKB554zmd3aCsuucLSh-M
Message-ID: <CAGXu5j+4_2vZF9uPy_agcGymbHbVqohSqApKZZxwcTz4OC_Skg@mail.gmail.com>
Subject: Re: [PATCH v3] kernel.h: Skip single-eval logic on literals in min()/max()
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	"Tobin C. Harding" <me@tobin.cc>, Steven Rostedt <rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>,
	Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>, David Sterba <dsterba@suse.com>,
	"David S. Miller" <davem@davemloft.net>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
	Masahiro Yamada <yamada.masahiro@socionext.com>, Borislav Petkov <bp@suse.de>,
	Randy Dunlap <rdunlap@infradead.org>, Ian Abbott <abbotti@mev.co.uk>,
	Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Petr Mladek <pmladek@suse.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Linux Btrfs <linux-btrfs@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594491887701841138?=
X-GMAIL-MSGID: =?utf-8?q?1594512401452304684?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 9, 2018 at 5:30 PM, Kees Cook <keescook@chromium.org> wrote:
> --
> Kees Cook
> Pixel Security<div class="gmail_extra"><br><div class="gmail_quote">On
> [...]

WTF, gmail just blasted HTML into my explicitly plain-text email?! Apologies...

-- 
Kees Cook
Pixel Security<div class="gmail_extra"><br><div class="gmail_quote">On
Fri, Mar 9, 2018 at 5:30 PM, Kees Cook <span dir="ltr">&lt;<a
href="mailto:keescook@chromium.org"
target="_blank">keescook@chromium.org</a>&gt;</span>
wrote:<br><blockquote class="gmail_quote" style="margin:0 0 0
.8ex;border-left:1px #ccc solid;padding-left:1ex"><span class="">On
Fri, Mar 9, 2018 at 4:38 PM, Linus Torvalds<br>
&lt;<a href="mailto:torvalds@linux-foundation.org">torvalds@linux-foundation.org</a><wbr>&gt;
wrote:<br>
&gt; On Fri, Mar 9, 2018 at 4:32 PM, Andrew Morton &lt;<a
href="mailto:akpm@linux-foundation.org">akpm@linux-foundation.org</a>&gt;
wrote:<br>
&gt;&gt;<br>
&gt;&gt; I wonder which gcc versions actually accept Kees's addition.<br>
<br>
</span>Ah, my old nemesis, gcc 4.4.4. *sob*<br>
<span class=""><br>
&gt; Note that we already do have this pattern, as seen by:<br>
&gt;<br>
&gt;&nbsp; &nbsp;git grep -2&nbsp; __builtin_choose_expr | grep -2
__builtin_constant_p<br>
&gt;<br>
&gt; which show drivers/pinctrl/intel/pinctrl-<wbr>intel.h, so the pattern<br>
&gt; already exists current kernels and _works_ - it apparently just<br>
&gt; doesn't work in slightly more complicated cases.<br>
<br>
</span>Fun. Yeah, so all the PIN_GROUP() callers have either a literal or an<br>
array name for that argument, so the argument to<br>
__builtin_constant_p() isn't complex.<br>
<br>
git grep '\bPIN_GROUP\b' | egrep -v '(1|2|3|true|false)\)'<br>
<span class=""><br>
&gt; It's one reason why I wondered if simplifying the expression to have<br>
&gt; just that single __builtin_constant_p() might not end up working..<br>
<br>
</span>Yeah, it seems like it doesn't bail out as "false" for complex<br>
expressions given to __builtin_constant_p().<br>
<br>
If no magic solution, then which of these?<br>
<br>
- go back to my original "multi-eval max only for constants" macro (meh)<br>
- add gcc version checks around this and similarly for -Wvla in the
future (eww)<br>
- raise gcc version (yikes)<br>
<br>
-Kees<br>
<br>
--<br>
Kees Cook<br>
Pixel Security&lt;div class="gmail_extra"&gt;&lt;br&gt;&lt;div
class="gmail_quote"&gt;On<br>
Fri, Mar 9, 2018 at 4:38 PM, Linus Torvalds &lt;span
dir="ltr"&gt;&amp;lt;&lt;a<br>
<span class="">href="mailto:<a
href="mailto:torvalds@linux-foundation.org">torvalds@linux-<wbr>foundation.org</a>"<br>
target="_blank"&gt;<a
href="mailto:torvalds@linux-foundation.org">torvalds@<wbr>linux-foundation.org</a>&lt;/a&gt;&amp;gt;&lt;/<wbr>span&gt;<br>
wrote:&lt;br&gt;&lt;blockquote class="gmail_quote" style="margin:0 0 0<br>
</span>.8ex;border-left:1px #ccc solid;padding-left:1ex"&gt;&lt;span
class=""&gt;On<br>
Fri, Mar 9, 2018 at 4:32 PM, Andrew Morton &amp;lt;&lt;a<br>
href="mailto:<a
href="mailto:akpm@linux-foundation.org">akpm@linux-<wbr>foundation.org</a>"&gt;<a
href="mailto:akpm@linux-foundation.org">akpm@linux-<wbr>foundation.org</a>&lt;/a&gt;&amp;gt;<br>
wrote:&lt;br&gt;<br>
&amp;gt;&lt;br&gt;<br>
&amp;gt; I wonder which gcc versions actually accept Kees's
addition.&lt;br&gt;<br>
&lt;br&gt;<br>
&lt;/span&gt;Note that we already do have this pattern, as seen
by:&lt;br&gt;<br>
&lt;br&gt;<br>
&amp;nbsp; git grep -2&amp;nbsp; __builtin_choose_expr | grep -2<br>
__builtin_constant_p&lt;br&gt;<br>
&lt;br&gt;<br>
which show drivers/pinctrl/intel/pinctrl-<wbr>&lt;wbr&gt;intel.h, so
the pattern&lt;br&gt;<br>
already exists current kernels and _works_ - it apparently just&lt;br&gt;<br>
doesn't work in slightly more complicated cases.&lt;br&gt;<br>
&lt;br&gt;<br>
It's one reason why I wondered if simplifying the expression to
have&lt;br&gt;<br>
just that single __builtin_constant_p() might not end up working..&lt;br&gt;<br>
<div class="HOEnZb"><div class="h5">&lt;span
class="HOEnZb"&gt;&lt;font color="#888888"&gt;&lt;br&gt;<br>
&amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp;
&amp;nbsp; Linus&lt;br&gt;<br>
&lt;/font&gt;&lt;/span&gt;&lt;/blockquote&gt;&lt;/<wbr>div&gt;&lt;br&gt;&lt;br
clear="all"&gt;&lt;div&gt;&lt;br&gt;&lt;/div&gt;--<br>
&lt;br&gt;&lt;div class="gmail_signature"
data-smartmail="gmail_<wbr>signature"&gt;Kees<br>
Cook&lt;br&gt;Pixel Security&lt;/div&gt;<br>
&lt;/div&gt;<br>
</div></div></blockquote></div><br><br clear="all"><div><br></div>--
<br><div class="gmail_signature" data-smartmail="gmail_signature">Kees
Cook<br>Pixel Security</div>
</div>
