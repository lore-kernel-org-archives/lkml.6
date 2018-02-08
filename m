Return-Path: <kernel-hardening-return-11655-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x226LD1zecE74tZqYOaBfoIwHaJJ1tWCN/NFcAM+L6LdQnO+W7IptITWbDxKAb2QXFHzJfCUU
ARC-Seal: i=1; a=rsa-sha256; t=1518062716; cv=none;
        d=google.com; s=arc-20160816;
        b=QRPywyRBa/MyKjhhkg2NLlDv4vjxhOJLQFsrPduEHUnMVTwyBJLwz1lVpVByLdGfzU
         NUQqWX8EQeEET+ELI7UFJUxp8t6LYekEzwq2MSOrBlzNXGy5BbbcjIaHeGRf8vL0FsED
         WRo3lur7YzomHlnZB1FzuEGZght62DE6VQM7q0GldlHu3f0EB/30q+m/OemtnksW0vFz
         qCyv88sctD1Ih1TfxOj9XOvPDnwMi0vNNI2lqswydJ9rXDAxTVb4slmRFrc3FC+Tx1dY
         ElIuElFVCiIRPyMd13uf2cUC0zjViW4HGUTeLX7aVQYWWHPrxiG2n2VODHUjLyfxM3vz
         fntQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=EY0nM7visqBv8f40UKRzqz/yUY0BC6legCi+dMJ2SYs=;
        b=ngDg1Y8P0WZJDsQiaYsxYk3XwlWpSpj7EjTHUNXU+4Svhq1qJprPnYXb/j3N+V7HjY
         TTk3LIPcapMzUG6fZIsN3CQI/GCZLOY0PbA60aoha26pya+3PXoqclraVJtDOGcTkQL6
         RmjERbL+1d1nhuP8Ud/WIrAJuy5vQW0LHAJUIESHPORdkBKLg7FSsHvG3yzyYR98tGS9
         JQxSqiWRwM2Xyr4bIJieWLs01Y+HrAB6fqhUv2svgb9tLsEuuy9yD862DAP0WkLT/WKq
         lKrBPulmWVqLIrx8sNcCjwH+MhuhGASE2pYXTWATe2NkwJGxoTPr1xCDqcalh5ci4Q+N
         IJ9Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=QCyaNoCh;
       spf=pass (google.com: domain of kernel-hardening-return-11655-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11655-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=QCyaNoCh;
       spf=pass (google.com: domain of kernel-hardening-return-11655-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11655-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Wed, 7 Feb 2018 20:04:55 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Jann Horn <jannh@google.com>
Cc: linux-mm@kvack.org,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	kernel list <linux-kernel@vger.kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [RFC] Warn the user when they could overflow mapcount
Message-ID: <20180208040455.GC14918@bombadil.infradead.org>
References: <20180208021112.GB14918@bombadil.infradead.org>
 <CAG48ez2-MTJ2YrS5fPZi19RY6P_6NWuK1U5CcQpJ25=xrGSy_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez2-MTJ2YrS5fPZi19RY6P_6NWuK1U5CcQpJ25=xrGSy_A@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591796976786547518?=
X-GMAIL-MSGID: =?utf-8?q?1591804130585648665?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 08, 2018 at 03:56:26AM +0100, Jann Horn wrote:
> How much memory would you need to trigger this? You need one
> vm_area_struct per increment, and those are 200 bytes? So at least
> 800GiB of memory for the vm_area_structs, and maybe more for other
> data structures?

That's a good point that I hadn't considered.  Systems with that quantity
of memory are becoming available though.

> On systems with RAM on the order of terabytes, it's probably a good
> idea to turn on refcount hardening to make issues like that
> non-exploitable for now.

_mapcount is a bad candidate to be turned into a refcount_t.  It's
completely legitimate to go to 0 and then back to 1.  Also, we care
about being able to efficiently notice when it goes from 2 to 1 and
then from 1 to 0 (and we currently do that by biasing the count by -1).
I suppose it wouldn't be too hard to notice when we go from 0x7fff'ffff
to 0x8000'0000 and saturate the counter there.

> > That seems pretty bad.  So here's a patch which adds documentation to the
> > two sysctls that a sysadmin could use to shoot themselves in the foot,
> > and adds a warning if they change either of them to a dangerous value.
> 
> I have negative feelings about this patch, mostly because AFAICS:
> 
>  - It documents an issue instead of fixing it.

I prefer to think of it as warning the sysadmin they're doing something
dangerous, rather than preventing them from doing it ...

>  - It likely only addresses a small part of the actual problem.

By this, you mean that there's a more general class of problem, and I make
no attempt to address it?

> > +       if ((INT_MAX / max_map_count) > pid_max)
> > +               pr_warn("pid_max is dangerously large\n");
> 
> This in reordered is "if (pid_max * max_map_count < INT_MAX)
> pr_warn(...);", no? That doesn't make sense to me. Same thing again
> further down.

I should get more sleep before writing patches.

> > -               if (unlikely(mm->map_count >= sysctl_max_map_count)) {
> > +               if (unlikely(mm->map_count >= max_map_count)) {
> 
> Why the renaming?

Because you can't have a function and an integer with the same name,
and the usual pattern we follow is that sysctl_foo_bar() is the function
to handle the variable foo_bar.
