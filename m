Return-Path: <wvw@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521238410; cv=none;
        d=google.com; s=arc-20160816;
        b=laXgfVQUIBzAIiR+kWSWQr00O2CO614g5RwQ9FtG+XjaZnBI29erPjrYPNX4d4xFz+
         ycE3nckdSmEzM2TrANhs2IX7guS4sPl6K7YQLMgbpmQcGv5r4b5MM3D40H48OUynYVi/
         zv17Q6YqKHleUPTSsZz+H2ZK5TVmKKlzMlM9+rby12FjY93Q6JIo3NoaLxTN8TDJivyU
         RyMYS/8uzt8llyS4Qyra4J+gtJhkVPM8bvnQ4myizH2ZZS2+6imvNRx3mdzuEEjN3gjQ
         /AihM5vnFdxbH2RVGiq34A3pfLHeRK5GtOfyuIV6RNpowQ5ICMi+szxMWQdXNlpvBz/N
         +9KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=WF3KUwhuLYqK8laI1KhKhl29ZLrYgbhSqZwWq7o5Au0=;
        b=JUPgFORPIjwm7Vofiu7vKPemFPdI8KEGehXidAwkj3VjEqbiS5RiVZVdyBi8lRDjJz
         xtdVkv4hb1sSbLrzBBsa3L68mHQFOwAIUhXz8ijHFm6PjYwr9whafnJU4oGL63E1jTuK
         B3cp6NBXSKPgADV/ctIwlLu3v2fCgkgbFU0os0qWgYCMN54h0eOxHhqaJ0rQH4JnmrhG
         io4jQEZx3xZ8NVIeXqKIyaxoDmYrKhnEi8Y/yFOLKsMlpvs40eTiyNboC5zPHagcx2aB
         9loBDIvoLCazCbaFAyjjCiXdhJq98Xe5T+GWnlAYAEwbWJEyrhvH+oB/1pFRfPQI9hKN
         x3Ow==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=WELoSDSU;
       spf=pass (google.com: domain of wvw@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=wvw@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=WELoSDSU;
       spf=pass (google.com: domain of wvw@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=wvw@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AG47ELtyoGI7N8L9bF8qWxiDxXkCjqJDG5Y+AcVst8ObhO25DhveKnh2e9QqujxN0PDxg2jx2/+uL+z1VjKPK9rz/RA=
MIME-Version: 1.0
References: <20180316182512.118361-1-wvw@google.com> <20180316143306.dd98055a170497e9535cc176@linux-foundation.org>
 <CAMFybE7EKyJMmR=Ntn1UX1ZMWJ=32v9G_kYdXh4LhinDv_JO8Q@mail.gmail.com> <20180316145942.9e2d353ed10041fbac42e5a3@linux-foundation.org>
In-Reply-To: <20180316145942.9e2d353ed10041fbac42e5a3@linux-foundation.org>
From: Wei Wang <wvw@google.com>
Date: Fri, 16 Mar 2018 22:13:19 +0000
Message-ID: <CAGXk5yoL=NuW1d1VHD9_CXi3kg0gmKeWFubNC7Ro053yDnR9vA@mail.gmail.com>
Subject: Re: [PATCH] mm: add config for readahead window
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Wei Wang <wei.vince.wang@gmail.com>, gregkh@linuxfoundation.org,
	Todd Poynor <toddpoynor@google.com>, Dan Williams <dan.j.williams@intel.com>,
	Michal Hocko <mhocko@suse.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Jan Kara <jack@suse.cz>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
	Hugh Dickins <hughd@google.com>, Matthew Wilcox <willy@infradead.org>, Ingo Molnar <mingo@kernel.org>,
	Sherry Cheung <SCheung@nvidia.com>, "Oliver O'Halloran" <oohall@gmail.com>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>, Huang Ying <ying.huang@intel.com>,
	Dennis Zhou <dennisz@fb.com>, Pavel Tatashin <pasha.tatashin@oracle.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595119752476729321?=
X-GMAIL-MSGID: =?utf-8?q?1595134087857086459?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 2:59 PM Andrew Morton <akpm@linux-foundation.org>
wrote:

> On Fri, 16 Mar 2018 21:51:48 +0000 Wei Wang <wei.vince.wang@gmail.com>
wrote:

> > On Fri, Mar 16, 2018, 14:33 Andrew Morton <akpm@linux-foundation.org>
wrote:
> >
> > > On Fri, 16 Mar 2018 11:25:08 -0700 Wei Wang <wvw@google.com> wrote:
> > >
> > > > Change VM_MAX_READAHEAD value from the default 128KB to a
configurable
> > > > value. This will allow the readahead window to grow to a maximum
size
> > > > bigger than 128KB during boot, which could benefit to sequential
read
> > > > throughput and thus boot performance.
> > >
> > > You can presently run ioctl(BLKRASET) against the block device?
> > >
> >
> > Yeah we are doing tuning in userland after init. But this is something
we
> > thought could help in very early stage.
> >

> "thought" and "could" are rather weak!  Some impressive performance
> numbers for real-world setups would help such a patch along.

~90ms savings from an Android device compared to setting the window later
in userland.
I was using 'week' words as I agree with Linus's point - it is all about
the storage, so the savings are not universal indeed.
