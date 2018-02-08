Return-Path: <willy@infradead.org>
X-Google-Smtp-Source: AH8x226ro37J0xJV74vWOT9VEsSAhJTgipZAypsY3ejlm8dswUWwbsQ/qDsV0xb89edgTkLRauqo
ARC-Seal: i=1; a=rsa-sha256; t=1518116439; cv=none;
        d=google.com; s=arc-20160816;
        b=IKA29oDMNHO1yCDd4hpPgNKn3017kPrirCVg8QY7ajtXldQYj9apkYRuRnQF81N/sT
         0xxIJTmdD74BSumhZ4Sauk1KaK2eMMab4SKXgChzEkAQMeUG3HJBIjU7kzPKABCO3N8p
         WFO+ksrVbfAF90QZc62KsAn0vKE50XwG92MDgr6DdspKYcnkVgATN9HeCIzDMxf8898/
         pPtApHF8ALR4XeklEVVrEWZ61Kh2jHUaq6UY+ZoLCJvotysvbKmc2shUBgOcf7ZbD/F3
         hj0YsanUSCCdukZsfljhyIwb078QvGth9HHDtv298G2KCVzY+S/lgc3TV2e6syqGl0rF
         wV1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=sCnTVimRGoc/UQEGZhf1r825yFb0C2qtFFKFbWQAMOo=;
        b=gKXKlumevY56VRum4HmsBUjBfGA58kKyK2JAwehjJksybFCMATDwb0VU5y9UvnLwWU
         g+u2xu7ySfnYMwybDhjkJa9AeU7eS9gW7iLllVQDPua1xMZSOnYB6gQaqGLzibmFztzt
         sJNd5v4k9KE3eayXBBNLBiv8mwAKnAtu2X8nNY4kr3/U5T2LCZKN2wxqWvNOK3zf03xi
         tGT3TVdsy6j661312pEdIzU7/rs6MHPlgVjSeXSQP6wepPYDC5U66e+qn+oPlF4wouaZ
         ReXUcDKzpFimEjvGP3aFQDQeKuVh7DCspdJhxg0qROmNxoG0OSbSBSA4X6Gjzo+xQBps
         GwzQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=UauH1JWo;
       spf=pass (google.com: best guess record for domain of willy@infradead.org designates 65.50.211.133 as permitted sender) smtp.mailfrom=willy@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=UauH1JWo;
       spf=pass (google.com: best guess record for domain of willy@infradead.org designates 65.50.211.133 as permitted sender) smtp.mailfrom=willy@infradead.org
Date: Thu, 8 Feb 2018 11:00:18 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Dmitry Vyukov <dvyukov@google.com>, Kirill Tkhai <ktkhai@virtuozzo.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Alexander Potapenko <glider@google.com>,
	Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Juergen Gross <jgross@suse.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kees Cook <keescook@chromium.org>,
	Mathias Krause <minipli@googlemail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	kasan-dev <kasan-dev@googlegroups.com>,
	Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH RFC] x86: KASAN: Sanitize unauthorized irq stack access
Message-ID: <20180208190016.GC9524@bombadil.infradead.org>
References: <151802005995.4570.824586713429099710.stgit@localhost.localdomain>
 <6638b09b-30b0-861e-9c00-c294889a3791@linux.intel.com>
 <d1b8c22c-79bf-55a1-37a1-2ce508881f3d@virtuozzo.com>
 <20180208163041.zy7dbz4tlbit4i2h@treble>
 <CACT4Y+bZ2JtwTK+a2=wuTm3891Zu1qksreyO63i6whKqFv66Cw@mail.gmail.com>
 <20180208172026.6kqimndwyekyzzvl@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180208172026.6kqimndwyekyzzvl@treble>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591759437440105803?=
X-GMAIL-MSGID: =?utf-8?q?1591860463746159618?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 08, 2018 at 11:20:26AM -0600, Josh Poimboeuf wrote:
> The patch description is confusing.  It talks about "crappy drivers irq
> handlers when they access wrong memory on the stack".  But if I
> understand correctly, the patch doesn't actually protect against that
> case, because irq handlers run on the irq stack, and this patch only
> affects code which *isn't* running on the irq stack.

This would catch a crappy driver which allocates some memory on the
irq stack, squirrels the pointer to it away in a data structure, then
returns to process (or softirq) context and dereferences the pointer.

I have no idea if that's the case that Kirill is tracking down, but it's
something I can imagine someone doing.
