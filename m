Return-Path: <kernel-hardening-return-11657-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x226qbPglgPL0Wz4oRkU3SnekfWdM5PkXXcrHocFYuW7wwCj4eWfomcm6doCPLaOb0bQvkJnZ
ARC-Seal: i=1; a=rsa-sha256; t=1518113155; cv=none;
        d=google.com; s=arc-20160816;
        b=jZVcDPo1SOkEeSQhkruPyfGa9h/veFjgSfMPdX0gkdyXnoCLV7ydlB8/9o8TX9Y401
         81xypK4qvIyq+tYp+u7ccHw2jxSze3fXq4u+CM8bnPpZVBpIzgsQMVY3CFEFYA9nxdQc
         nO+ZRdODUGyrXcpD+Wv6H2a9n0uEQCEDwJVoMI4R4j4Ck6r+WWdEa8OrngsCPN+4ak1f
         3bzksefLax6vin5+PdN1wfOpKspnkxEVo9truBnAeaaR2LXMRfdqteaw1twUxaxTmWUi
         szNGwa6H3hTeCJPfgCODAwY1Xys+6IkVrUjQnKkJ+loZJlr5iwqkI8M8mff6KhLb/nme
         UVOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=Z1CAoITxgNUmVEtyVyxzcFDi7o2MR/Bb963tYSQ2AY0=;
        b=fOFMi3Vz9IkwIKsBIa9NZDqPVn62zFUGOuGvoTYaF2S41ZdRO2A2a14PFkzZAXoGfx
         3gT//n50ItTtnkaNn5k0VUL0EvHTDWMrY1T1y3DbiYnlEBIkNMDC+ad/FVWGZ4vD62On
         ZddAtvmSNN7FoYQePnrl9vVfoN8CuSlRA81g28uKFi8einXPAlCwN5APZN4Y7MnelK2S
         E0awbjF2fImdTwpWHp1PtowMuz4H4V8JP3M9Ma6pmeaxpIb0OyeLyogYII560s0GV3Yp
         lrNtRTlXpS/QwrA/sdllEUb768xoRy7rwhsJlAFW5aoktwPLapbuD1whbBxkJcdaHrn7
         rTlA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Px7M75o5;
       spf=pass (google.com: domain of kernel-hardening-return-11657-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11657-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Px7M75o5;
       spf=pass (google.com: domain of kernel-hardening-return-11657-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11657-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <CAG48ez2-MTJ2YrS5fPZi19RY6P_6NWuK1U5CcQpJ25=xrGSy_A@mail.gmail.com>
References: <20180208021112.GB14918@bombadil.infradead.org> <CAG48ez2-MTJ2YrS5fPZi19RY6P_6NWuK1U5CcQpJ25=xrGSy_A@mail.gmail.com>
From: Daniel Micay <danielmicay@gmail.com>
Date: Thu, 8 Feb 2018 13:05:33 -0500
Message-ID: <CA+DvKQLHDR0s=6r4uiHL8kw2_PnfJcwYfPxgQOmuLbc=5k39+g@mail.gmail.com>
Subject: Re: [RFC] Warn the user when they could overflow mapcount
To: Jann Horn <jannh@google.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	kernel list <linux-kernel@vger.kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591796976786547518?=
X-GMAIL-MSGID: =?utf-8?q?1591857019872628708?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

>> That seems pretty bad.  So here's a patch which adds documentation to the
>> two sysctls that a sysadmin could use to shoot themselves in the foot,
>> and adds a warning if they change either of them to a dangerous value.
>
> I have negative feelings about this patch, mostly because AFAICS:
>
>  - It documents an issue instead of fixing it.
>  - It likely only addresses a small part of the actual problem.

The standard map_max_count / pid_max are very low and there are many
situations where either or both need to be raised.

VM fragmentation in long-lived processes is a major issue. There are
allocators like jemalloc designed to minimize VM fragmentation by
never unmapping memory but they're relying on not having anything else
using mmap regularly so they can have all their ranges merged
together, unless they decide to do something like making a 1TB
PROT_NONE mapping up front to slowly consume. If you Google this
sysctl name, you'll find lots of people running into the limit. If
you're using a debugging / hardened allocator designed to use a lot of
guard pages, the standard map_max_count is close to unusable...

I think the same thing applies to pid_max. There are too many
reasonable reasons to increase it. Process-per-request is quite
reasonable if you care about robustness / security and want to sandbox
each request handler. Look at Chrome / Chromium: it's currently
process-per-site-instance, but they're moving to having more processes
with site isolation to isolate iframes into their own processes to
work towards enforcing the boundaries between sites at a process
level. It's way worse for fine-grained server-side sandboxing. Using a
lot of processes like this does counter VM fragmentation especially if
long-lived processes doing a lot of work are mostly avoided... but if
your allocators like using guard pages you're still going to hit the
limit.

I do think the default value in the documentation should be fixed but
if there's a clear problem with raising these it really needs to be
fixed. Google either of the sysctl names and look at all the people
running into issues and needing to raise them. It's only going to
become more common to raise these with people trying to use lots of
fine-grained sandboxing. Process-per-request is back in style.
