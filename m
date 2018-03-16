Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521235608; cv=none;
        d=google.com; s=arc-20160816;
        b=Tq5AJUdAsazgxtRgoon21uyvbZVoPLoUMiVLfF5t1Lu+haBJ1CHKDzNTLyHpPAGjox
         g8YKOvC4/Lq9Df/a3Pa/uuN/9B74ZsWt4eFFV9bUDV0ICKuNwyJtnwLnnRHibPnLgz1q
         P3mYhGApEagIPWcNsulCUhKnkgmyqS4HM1ykY4Xy2Gc0p356jpN9pcgVyAUUGUWvK6TK
         AJ0wl48l4yhBpeMQ8P000CmLG6iNXSr0+/eoepuzKpjygXV0t+bbitBl5yVTq/uc7T2l
         V65KsODJkdBbtIVDIteAiW+p0BczWUuJYKd2y6ZNHFFiNoRQ2ryJGf5zXIpM+yPLjXol
         CdeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=qb9iN9jD2Y6OxAGQTjs9258nOTjxQLmmriIJl94BicI=;
        b=m2h9MUjVJLxyitESgJtVC4558jybZOXD/HrYHFGhT0qRwOOGGeFNGs5DCb9eB9DBHj
         l2FyZdy8cvG+VPBM3bLFRRRb+N7o5AdXzzC7f9KVGvLgltKRBaL4Kc+3hIBwvVA3mymD
         k1zSEu+wG/Se1OiAR8Y0mCtT7Ka+zgPuG+vBryg2Ayh/bSXJbgfFoxnCB47K3t3L8IVs
         N+wt1VkEoGUjPh9nkN/MJqs1GhLcsxXugdsXFLpUTlUvX6XHUAIqVZ6GhCRtQDUd2zLT
         ujieOT6Qsi6CKKrdHoY2MSC0xPXjDCswr3vFQTwieAmS+e7gGX6keXNKemFTmKTRgN1R
         ZMQA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=bZRUkrej;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=iBFB49Wi;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=bZRUkrej;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=iBFB49Wi;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AG47ELvxuSIT507NDmlpTqX0664jQ2bZoEzOjDBRuVqV0uuW+64u5iX35OkqayqZcHY/LZvLupWB5XN9nY1bCARnLvY=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20180316205607.lr6nmrkkzzbw2tqh@node.shutemov.name>
References: <20180316182512.118361-1-wvw@google.com> <20180316205607.lr6nmrkkzzbw2tqh@node.shutemov.name>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 16 Mar 2018 14:26:47 -0700
X-Google-Sender-Auth: h-uNrhgQAnv1umDPBc7HeZDbFPY
Message-ID: <CA+55aFyLRhWZ-XD72xkZZm0FshhspK1RJezGfMo-7YPVGXweHA@mail.gmail.com>
Subject: Re: [PATCH] mm: add config for readahead window
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Wei Wang <wvw@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, toddpoynor@google.com,
	wei.vince.wang@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>, Michal Hocko <mhocko@suse.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Jan Kara <jack@suse.cz>,
	=?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
	Hugh Dickins <hughd@google.com>, Matthew Wilcox <willy@infradead.org>, Ingo Molnar <mingo@kernel.org>,
	Sherry Cheung <SCheung@nvidia.com>, "Oliver O'Halloran" <oohall@gmail.com>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>, Huang Ying <ying.huang@intel.com>,
	Dennis Zhou <dennisz@fb.com>, Pavel Tatashin <pasha.tatashin@oracle.com>,
	linux-mm <linux-mm@kvack.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595119752476729321?=
X-GMAIL-MSGID: =?utf-8?q?1595131149641549604?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 1:56 PM, Kirill A. Shutemov
<kirill@shutemov.name> wrote:
>
> Increase of readahead window was proposed several times. And rejected.
> IIRC, Linus was against it.

I have never seen any valid situation that wasn't tuning for one odd
machine, usually with a horribly crappy disk setup and very little
testing of latencies or low-memory situations.

And "horribly crappy" very much tends to include "big serious
enterprise hardware" that people paid big bucks for, and that has huge
theoretical throughput for large transfers, but is pure garbage in
every other way.

So I'm still very much inclined against these kinds of things. They
need *extensive* numbers and explanations for why it's not just some
uncommon thing for one setup.

                   Linus
