Return-Path: <kernel-hardening-return-11892-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x226sLHhC5+vtHVF/cerfVa6uG6wjiYWsA12BKV2TU9G3kz5CyKFEVNueEkqpry46i0nGbRje
ARC-Seal: i=1; a=rsa-sha256; t=1519293149; cv=none;
        d=google.com; s=arc-20160816;
        b=MFDmC6sopUGnj6TMQrQmzHMmbiKoZz+lkwno9v4cPpjSNaCEc/WPlYYbfSmFdyr4Cc
         JEfS7WX4s7sBOqrA02Dt2oS26iRpbQTVN91d9XG7OEtrjS+tEnKv8R511759BDPCqYlP
         i8GCjdZgMmCu22A4n4u3nvTXHqWl/DlcxkM8EACq79fqe1UM3i/ukYaibECKlGodcLMm
         wxji+yuumhlNq+Cny2qEwYm3Q/gGJ6cTfxokeTD4ArrKcNWaCcmXJYBCBmxu/Fv/wvh/
         HduyexbBWJ25hn/X7nrYEoTnkqxIt/zHSHGUeeWXfUseMKlkSUPCyOmZTEedbL9e1YKs
         UJyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:delivered-to:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=WFJEJ+jJMEazbWtKYnhvW+CT9fUOMlH8ehaqnf/NCkM=;
        b=ZD1y6FfOaa5JS1v9QlCrBzJKWuFIjDJMv0LzXkcPgoEyjD5kYQ6CFb7/+w3fj6Nykl
         OTyUKcYsFPhuRWI4Zjlgw+WrnO7rC3pc4K1jrfZEwg6Yl5DgiVeRN8l0UsLVWT6dv8BU
         zONi7QcFHSB/c0E1ZKohJwZLCqLSXpehWsMnw9TOCT0UNHNGfEJ9QIxqIU4O3jrVj/En
         vg0W+9/I1wzxK7P3Kv7ayHp7D1SWqmsfc2Df8p+HAPTjlelJCE6CPDajXEz/KAywD90Y
         Z61HNlV5vTgprcEtE8vXxA8yy97qBtoAe6g/hqRGdRbNd/JnKgzVN8cuzgOZ5adU/d3S
         JRqQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11892-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11892-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11892-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11892-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Thu, 22 Feb 2018 09:47:58 +0000
From: Mel Gorman <mgorman@techsingularity.net>
To: Andy Lutomirski <luto@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
	Ingo Molnar <mingo@kernel.org>, Laura Abbott <labbott@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Sahara <keun-o.park@darkmatter.ae>,
	"Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>,
	Michal Hocko <mhocko@suse.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: Re: [PATCH] fork: Allow stack to be wiped on fork
Message-ID: <20180222094758.4qzvhoiu4hnmqkzq@techsingularity.net>
References: <20180117055015.GA15256@beast>
 <20180220163142.15366a82a7bece715b997597@linux-foundation.org>
 <CALCETrVNBAWPAyrKKaiasehxDXKku3GSjc0+mQrvc4RC4+jUGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CALCETrVNBAWPAyrKKaiasehxDXKku3GSjc0+mQrvc4RC4+jUGw@mail.gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1589817624643319879?=
X-GMAIL-MSGID: =?utf-8?q?1593094333490588987?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 21, 2018 at 01:56:33AM +0000, Andrew Lutomirski wrote:
> > It would be much nicer to be able to control this at runtime rather
> > than compile-time.  Why not a /proc tunable?  We could always use more
> > of those ;)
> 
> /proc/sys/kernel/hardening_features_that_cost_essentially_nothing?
> 
> Seriously, though, why don't we just enable it unconditionally?  It
> wouldn't surprise me if it really is a speedup on more workloads than
> it slows down -- it'll fill the kernel stack into the CPU cache with
> exclusive ownership very quickly (streamily and without actually
> reading from memory, I imagine, at least on new enough CPUs) rather
> than grabbing each cache line one by one as they get used.

Note that this is not unconditionally true, it depends on the calling
context that clears the page. If this is during fork, then the parent may
be doing the clear (I didn't check) which means it's quite likely when the
child wakes for the first time that it will not necessary wake on the same
CPU. Up until recently on NUMA machines, the child was almost guaranteed
to be running on a remote node (mitigated in tip for sched now).

I'm not claiming I've measured the overhead of this, just pointing out that
"cache hotness" may actually result in double the cache line bounces --
first clear, then write on first wake. If only zeroing pages was a bit
faster :/

-- 
Mel Gorman
SUSE Labs
