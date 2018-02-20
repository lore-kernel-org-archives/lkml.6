Return-Path: <kernel-hardening-return-11826-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x225KMUkIhsqWfVjaJHngggFhaDDO2oRNThZc2qj1jXzZWI50bhEmaV2MDS0oybdNKeWlv7+y
ARC-Seal: i=1; a=rsa-sha256; t=1519127450; cv=none;
        d=google.com; s=arc-20160816;
        b=hXEpXkj/KGMgsgIJs3IdAgmrCuOwjLmoXyuiVLV26NlDtnl2bLchNUxp+J/Ba3RciE
         fepRtPjUqA3+VYqIMhdPTIZVyH0gepovfj3KGE5CSJRafSEyxwNdZ5OTano5FXHn+vwI
         ABY1Nmh2J+rBQ90emB23zdsvPCYUyPNqyePurwIZEfRDpZrwC4mE3VkutHsFiNwENEKu
         2n8W0IS8wbSqeQIUorbgNqnXL+lRJUUzUrV6ia5g3d8nc1E0jxtA6uafKiUfydUQcZkk
         40gU+mpplgU9MvmzmJSMxrQRD6UOM+rdmnUTmZxiSX2Nq6GhxVTjHPFmxRzz5HNKrFa9
         r5nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:delivered-to:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=dgR6GHrEcMU3fH2+byquxfkKNM1fM3eOofwtpTI+dV8=;
        b=bPbHXUOCqLdqSAgr/RdLaq45LqJ3U8aZFdXVzPDeEwaFRpdJvdz2nsLQ0Jc5D248qd
         /HdaeH2maI1YjmqdSu+Lmo7Je1jtY6s/SREU5Mgu4cvVSZ9yD+uiUuE9Gv/CAuS3d9GI
         UaryEps7HHggSh4coxylxjt2MdYaiB68qbeigkYD8a2Tr5EAZbuR1CPM+kSGdhNekrkm
         w4C/Jf5ZwvtOCZmZVzN9TdsXVHXaSbFrAu+YWmsa6T/nSammLQC9hXyLfllGPuxtHj5t
         Fd+eKlqFBGg/lElmQzFwKxTt7Q0KMyLdYGGY4l7mCFIlaKWLFNSuURfdujxwYET3g3Hr
         5zcQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11826-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11826-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11826-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11826-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Tue, 20 Feb 2018 12:21:11 +1100
From: Dave Chinner <dchinner@redhat.com>
To: Kees Cook <keescook@chromium.org>
Cc: Igor Stoppa <igor.stoppa@huawei.com>,
	Matthew Wilcox <willy@infradead.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>, Michal Hocko <mhocko@kernel.org>,
	Laura Abbott <labbott@redhat.com>,
	Jerome Glisse <jglisse@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	Christoph Lameter <cl@linux.com>,
	linux-security-module <linux-security-module@vger.kernel.org>,
	Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: Re: [RFC PATCH v16 0/6] mm: security: ro protection for dynamic data
Message-ID: <20180220012111.GC3728@rh>
References: <20180212165301.17933-1-igor.stoppa@huawei.com>
 <CAGXu5j+ZNFX17Vxd37rPnkahFepFn77Fi9zEy+OL8nNd_2bjqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5j+ZNFX17Vxd37rPnkahFepFn77Fi9zEy+OL8nNd_2bjqQ@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592214870438978682?=
X-GMAIL-MSGID: =?utf-8?q?1592920585863523027?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 12, 2018 at 03:32:36PM -0800, Kees Cook wrote:
> On Mon, Feb 12, 2018 at 8:52 AM, Igor Stoppa <igor.stoppa@huawei.com> wrote:
> > This patch-set introduces the possibility of protecting memory that has
> > been allocated dynamically.
> >
> > The memory is managed in pools: when a memory pool is turned into R/O,
> > all the memory that is part of it, will become R/O.
> >
> > A R/O pool can be destroyed, to recover its memory, but it cannot be
> > turned back into R/W mode.
> >
> > This is intentional. This feature is meant for data that doesn't need
> > further modifications after initialization.
> 
> This series came up in discussions with Dave Chinner (and Matthew
> Wilcox, already part of the discussion, and others) at LCA. I wonder
> if XFS would make a good initial user of this, as it could allocate
> all the function pointers and other const information about a
> superblock in pmalloc(), keeping it separate from the R/W portions?
> Could other filesystems do similar things?

I wasn't cc'd on this patchset, (please use david@fromorbit.com for
future postings) so I can't really say anything about it right
now. My interest for XFS was that we have a fair amount of static
data in XFS that we set up at mount time and it never gets modified
after that. I'm not so worried about VFS level objects (that's a
much more complex issue) but there is a lot of low hanging fruit in
the XFS structures we could convert to write-once structures.

Cheers,

Dave.
-- 
Dave Chinner
dchinner@redhat.com
