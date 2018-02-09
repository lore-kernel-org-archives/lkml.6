Return-Path: <jroedel@suse.de>
X-Google-Smtp-Source: AH8x225/QdgEN8bZjxixdHHL6teFF4spps9C53BLGCykJcaiCwtcYcW7yDsvHSX+Uo7xNqYEDoD2
ARC-Seal: i=1; a=rsa-sha256; t=1518203359; cv=none;
        d=google.com; s=arc-20160816;
        b=m/91Bt+kLeZuGNYFMcc/jks5LwSH8zvT2g+q6V4yRerp0MjzSbGKJZgUzacunnhRWp
         5bmHmWeoLsUm5o7wyvrojX3zz/YUiFNhWVufLUOsco9rf/wXx6zghKDi73D+80c6fc3w
         A9DLFtwf1D1/e6s0dWEpTwem/MC7/skKSRA2XRxnNTn46d9CR2smsR872O3vaEQbJJpp
         tRgchYBT3EABe80SlHbP78HxR+J9KuzP4kWXDAgAaUzkA8nsI4xTgViPmQq55iQta9nx
         nqVUO9Wn9G3yOP/vb85JPk6QzEBebWBE6/AecvQN2/+CE6wJI87RyRgNptM5+wGaiDYd
         Y+Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=tF/i6xNxrvaJJEuDdYOsyHFu+65WygS7BbnVtfWSQqI=;
        b=DRlvJ/wfl+ZbJqtMAI2V8gib4LRt7dqpf3sDoxGT1pnGRqAku/6gIDU43im1bRmRsT
         OrpdP6QIhoWT7bdmIarao3hmuAbIzLKbeFlnXbXyRjwhDskbMTWRx6oY1qjBDyV4z5H4
         ERrrvLGzBNDx0BnPj6hN0Z6X+k4XSMi2XRULngk4IiXwc4q5p8fasSbU0qYdeF3FAluu
         OzzREKtIXJyAQJGnQQrgMcsVc2DflzLoIxqQkjPdcnIJ2lP3m0bmxXJPKdgGZVIUnOei
         KQ788Gd7NDJ8rZL4W8zeXmeGXNhMWKYdHZE5sT+t/0+CU0j07Eed2hi+6vqehVAN4n/L
         oICw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jroedel@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=jroedel@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jroedel@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=jroedel@suse.de
Date: Fri, 9 Feb 2018 20:09:15 +0100
From: Joerg Roedel <jroedel@suse.de>
To: Andy Lutomirski <luto@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Linux-MM <linux-mm@kvack.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
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
	Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 20/31] x86/mm/pae: Populate the user page-table with user
 pgd's
Message-ID: <20180209190915.tevittkx5d3ngnyr@suse.de>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
 <1518168340-9392-21-git-send-email-joro@8bytes.org>
 <CALCETrUgk3s0uDZrHqy-HjudFXLeWN=oKz6EH9i-NCdWQEnAqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrUgk3s0uDZrHqy-HjudFXLeWN=oKz6EH9i-NCdWQEnAqw@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914910930783866?=
X-GMAIL-MSGID: =?utf-8?q?1591951605682083964?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 09, 2018 at 05:48:36PM +0000, Andy Lutomirski wrote:
> Can you rename the helper from pti_set_user_pgd() to
> pti_set_user_top_level_entry() or similar?  The name was already a bit
> absurd, but now it's just nuts.

Sure, I can do that, just pti_set_user_top_level_entry() is a bit long.
I try to find a shorter name.


Thanks,

	Joerg
