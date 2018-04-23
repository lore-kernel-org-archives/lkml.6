Return-Path: <jroedel@suse.de>
X-Google-Smtp-Source: AIpwx48JtmxBtmrETTPxV4JoqlBM6M6gYlxZYBOmrBG3yE69STw5ZIlAWnXuE7l9TRdQbWigyzUh
ARC-Seal: i=1; a=rsa-sha256; t=1524505514; cv=none;
        d=google.com; s=arc-20160816;
        b=HKzf7TAkw+TgMbwbdqG3fb+4jhR0UEXwxWNCO1z4jUfq0tBzA8PcxfVAUpYPcFzAsx
         18Ru59GllcgCtQJ5pkxE6wb32+MThqJfvYZbuy4igByhZ4SG36pQz6sIw7zNqevgSkL+
         XLE8xa7x3jwbULUI4Y8CGJRYDVQ8G/5UIor0gXMlPmG5yrxPlpSNfPCCr1Uye5+0/EoV
         S8xRF81PPXKF51D7YtjYkCMNbRDpuONDn7KSJp6TdEswW1d0osawP7RafJRGhk2aOY9z
         ndWidtu9WflwvqfxqXjuOQpebxCcui4uSe3GhKPI4UTCI7/yVJzPmnHk0RyG7MEUg0rN
         3YZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=D8EzFyPzjra5MgkjxCCubukBWI7H/uncvrHQx4CP86I=;
        b=1K0SVQtKUaYH/Wt6+2CpsEd/xfzh2apNQVPLlQwhkNnMESOyvYfz3hrzr+wtzbHhBs
         Zdp3JaU242YaArF33oZYX1X4UmCU9DYxhWNwkoHAy/eMxAwSMYbilxEwx0xXX9lm1OTr
         tEW0fGT/gGBCSAj54EeKFp0+t69BoYjn3UF4pjpGlpOmjQij6yvcKaFHcm270LdfPOhL
         LK6rLbVuwWljsGdY50ZbtRzrlg/hZcw1Z/PFWm0hw57NiRxaVUCYW2INpjS6s515bP1y
         +WvVS++2W5ejLtYj/3tVzJv/PnbmAgN8XecXcUIEojqlehs/K116mLnYZBQNGxY5HoyT
         eYEA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jroedel@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=jroedel@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jroedel@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=jroedel@suse.de
Date: Mon, 23 Apr 2018 19:45:06 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Joerg Roedel <joro@8bytes.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	the arch/x86 maintainers <x86@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-mm <linux-mm@kvack.org>, Andy Lutomirski <luto@kernel.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Brian Gerst <brgerst@gmail.com>,
	David Laight <David.Laight@aculab.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	Eduardo Valentin <eduval@amazon.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Will Deacon <will.deacon@arm.com>,
	"Liguori, Anthony" <aliguori@amazon.com>,
	Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
	Hugh Dickins <hughd@google.com>, Kees Cook <keescook@google.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
	"David H . Gutteridge" <dhgutteridge@sympatico.ca>
Subject: Re: [PATCH 00/37 v6] PTI support for x86-32
Message-ID: <20180423174506.mpbpnvfzv6fmpbzy@suse.de>
References: <1524498460-25530-1-git-send-email-joro@8bytes.org>
 <CA+55aFwg75rOXN5Q0qHf_GF-hnVo8mjxnTo2FbM993fuc8x7Gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFwg75rOXN5Q0qHf_GF-hnVo8mjxnTo2FbM993fuc8x7Gw@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598552504711746562?=
X-GMAIL-MSGID: =?utf-8?q?1598559894865525347?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 09:45:38AM -0700, Linus Torvalds wrote:
> Just one question: have you checked the page table setup for the
> basics wrt the USER bit in particular?

Just checked that and there are no pages with GLB and USR set, not even
a vdso page.

> No global pages should be marked PAGE_USER, with the possible
> exception of that nasty old vsyscall page.

The vsyscall page does not exist on plain 32 bit, no? All I could find
there is the vdso page, and that has no compat mapping anymore in recent
upstream kernels. To my understanding the vdso page is mapped into the
user-space portion of the address space. At least that is what I found
while looking at this, but I might have missed something.

I actually ran into a vdso issue when porting these changes to 3.0
(where there still is a compat vdso mapping in the fixmap) so I checked
my upstream code too, but didn't find the code to setup a vdso in the
fixmap.

> And it would be nice to verify that the page tables for kernel
> mappings also don't have PAGE_USER on them, although again that
> vsyscall page can cause problems.

Checked that too, all USR mappings are below PAGE_OFFSET.


Regards,

	Joerg
