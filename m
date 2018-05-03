Return-Path: <kirill@shutemov.name>
ARC-Seal: i=1; a=rsa-sha256; t=1525361072; cv=none;
        d=google.com; s=arc-20160816;
        b=iJ6wWc0/+DEJ/5J5ma9sSttFN/8LEdHFclFzJ2vs4H7C0HsoX+RSZrfSvN9bxTZdju
         XkdQYgS4CYIYe4kXltMN0WJBfBERKh2GeqMn1O6kEqlioAEH4BEdlg67kDX2MfBBchGN
         6Vp1NP9F1OMyGSTrvcEFHqhU9Gvf5e3DOoeKu3WK97/+lL1zFLuyiqrmF+Xevc/zmtNV
         QA0zLlST0QkON+1PziPUkJTJZkXNc3FiEpqZvX2dZ/R/gsdl8RRMjhKHHhBn9qDQBBP0
         Iw51faJMQ1cFfHVryOj2n0UmrgxePKEz0K/bkPQ5BPitaa2t7m2NyuMuUp44RZeZzpMS
         wRxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=Fu0dqtOQYCvqgLFGrs4lPTfH7EQrDai8s2KxRnVzuIE=;
        b=El+fIw70HtDuGYguCdZKtTYjxZrt1Vj6EAfT8r3XF/wOr83ijrh2sX7BT2ssHeZ+tv
         C6GCX0TgBiMQc3QBcBON/EIeRqLN2Hn0Re4nXtIgxmGcK6XrWgQDVWTB61RnLbfnlEFe
         cxmF2lTqtAThfE7IYzpvHzL3hltoRXugSaIpdDyc8LoYFwHxQishzTRIjeR1G6yzMmiw
         dsLAQ4i0whw4hQ4y++5Kxat6+0M4okDs9PdQF3ESONzFEmL4B98GHv+EZjKvhzS8xGZ4
         H2XCsnuZmQwexilUrfB2jiE84T7oz1TXUdKc/60dRvYYG6b4P3HBfg9z1P6A9acAS2Zb
         J2cQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@shutemov-name.20150623.gappssmtp.com header.s=20150623 header.b=awCjdz1q;
       spf=neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of kirill@shutemov.name) smtp.mailfrom=kirill@shutemov.name
Authentication-Results: mx.google.com;
       dkim=pass header.i=@shutemov-name.20150623.gappssmtp.com header.s=20150623 header.b=awCjdz1q;
       spf=neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of kirill@shutemov.name) smtp.mailfrom=kirill@shutemov.name
X-Google-Smtp-Source: AB8JxZpnvCkbx0rrQooi1G7FCEIVj/Mx2wGcFr4rWglc3Bu1nIEgpw6NV4Zq+9S3VvMO0CHBDKtA1A==
Date: Thu, 3 May 2018 18:24:32 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Andrey Konovalov <andreyknvl@google.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, Jonathan Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	James Morse <james.morse@arm.com>,
	Kees Cook <keescook@chromium.org>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
	Zi Yan <zi.yan@cs.rutgers.edu>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Jacob Bramley <Jacob.Bramley@arm.com>,
	Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
	Lee Smith <Lee.Smith@arm.com>, Kostya Serebryany <kcc@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
	Evgeniy Stepanov <eugenis@google.com>
Subject: Re: [PATCH 4/6] mm, arm64: untag user addresses in mm/gup.c
Message-ID: <20180503152432.q742zvdbv6xtvo34@kshutemo-mobl1>
References: <cover.1524077494.git.andreyknvl@google.com>
 <0db34d04fa16be162336106e3b4a94f3dacc0af4.1524077494.git.andreyknvl@google.com>
 <20180426174714.4jtb72q56w3xonsa@armageddon.cambridge.arm.com>
 <CAAeHK+zY8p9E4FZa7mbdgR=wR0u-RDS552dn=h9fKRC-ArYLdw@mail.gmail.com>
 <20180502153645.fui4ju3scsze3zkq@black.fi.intel.com>
 <CAAeHK+yTbmZfkeNbqbo+J90zsjsM99rwnYBGfQBxphHMMfgD7A@mail.gmail.com>
 <CAAeHK+zh0LSpq2VFJeHrV7AETnL1b9R+yex3iPMg5SetbEyxwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+zh0LSpq2VFJeHrV7AETnL1b9R+yex3iPMg5SetbEyxwg@mail.gmail.com>
User-Agent: NeoMutt/20180323
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598111199483906995?=
X-GMAIL-MSGID: =?utf-8?q?1599457011326568585?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 03, 2018 at 04:09:56PM +0200, Andrey Konovalov wrote:
> On Wed, May 2, 2018 at 7:25 PM, Andrey Konovalov <andreyknvl@google.com> wrote:
> > On Wed, May 2, 2018 at 5:36 PM, Kirill A. Shutemov
> > <kirill.shutemov@linux.intel.com> wrote:
> >> On Wed, May 02, 2018 at 02:38:42PM +0000, Andrey Konovalov wrote:
> >>> > Does having a tagged address here makes any difference? I couldn't hit a
> >>> > failure with my simple tests (LD_PRELOAD a library that randomly adds
> >>> > tags to pointers returned by malloc).
> >>>
> >>> I think you're right, follow_page_mask is only called from
> >>> __get_user_pages, which already untagged the address. I'll remove
> >>> untagging here.
> >>
> >> It also called from follow_page(). Have you covered all its callers?
> >
> > Oh, missed that, will take a look.
> 
> I wasn't able to find anything that calls follow_page with pointers
> passed from userspace except for the memory subsystem syscalls, and we
> deliberately don't add untagging in those.

I guess I missed this part, but could you elaborate on this? Why?
Not yet or not ever?

Also I wounder if we can find (with sparse?) all places where we cast out
__user. This would give a nice list of places where to pay attention.

-- 
 Kirill A. Shutemov
