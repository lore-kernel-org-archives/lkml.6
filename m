Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932527AbeCMUrM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 16:47:12 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50084 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753096AbeCMUrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 16:47:08 -0400
From: John Ogness <john.ogness@linutronix.de>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: dcache: remove trylock loops (was Re: [BUG] lock_parent() breakage when used from shrink_dentry_list())
References: <20180223035814.GZ30522@ZenIV.linux.org.uk>
        <20180223040814.GA30522@ZenIV.linux.org.uk>
        <87h8q7erlo.fsf@linutronix.de>
        <20180223150928.GC30522@ZenIV.linux.org.uk>
        <20180223174216.GD30522@ZenIV.linux.org.uk>
        <20180223201317.GG30522@ZenIV.linux.org.uk>
        <CA+55aFyP9JtyzUzA_S2sdKCK+8CZtNoA3UkXg5X4J0Hf2_ekjg@mail.gmail.com>
        <20180224002248.GH30522@ZenIV.linux.org.uk>
        <20180225073950.GI30522@ZenIV.linux.org.uk>
        <87bmgbnhar.fsf_-_@linutronix.de>
        <20180312191351.GN30522@ZenIV.linux.org.uk>
Date: Tue, 13 Mar 2018 21:46:48 +0100
In-Reply-To: <20180312191351.GN30522@ZenIV.linux.org.uk> (Al Viro's message of
        "Mon, 12 Mar 2018 19:13:51 +0000")
Message-ID: <87zi3bn1on.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-12, Al Viro <viro@ZenIV.linux.org.uk> wrote:
>> If someone else has grabbed a reference, it shouldn't be added to the
>> lru list. Only decremented.
>> 
>> if (entry->d_lockref.count == 1)
>
> Nah, better handle that in retain_dentry() itself.  See updated
> #work.dcache.
>
> +	if (unlikely(dentry->d_lockref.count != 1)) {
> +		dentry->d_lockref.count--;
> +	} else if (likely(!retain_dentry(dentry))) {
> +		__dentry_kill(dentry);
> +		return parent;
> +	}

Although the updated version is correct (and saves on lines of code), I
find putting the deref and lru_add code in the "true" case of
retain_dentry() to be pretty tricky. IMHO the code is easier to
understand if it looks like this:

	if (unlikely(dentry->d_lockref.count != 1)) {
		dentry->d_lockref.count--;
	} else if (likely(!retain_dentry(dentry))) {
		__dentry_kill(dentry);
		return parent;
	} else {
		dentry->d_lockref.count--;
		dentry_lru_add(dentry);
	}

This is what your version is doing, but that final else is hiding in the
retain_dentry() "true" case.

My suggestion is to revert 7479f57fecd2a4837b5c79ce1cf0dcf284db54be (and
then fixup dput() to deref before calling dentry_lru_add()).

> FWIW, there's another trylock loop on dentries - one in
> autofs get_next_positive_dentry().  Any plans re dealing
> with that one?

I will need to dig into it a bit deeper (I am unfamiliar with autofs),
but it looks like it is trying to do basically the same thing as the
ascend loop in d_walk().

> I'd spent the last couple of weeks (when not being too sick
> for any work) going through dcache.c and related code; hopefully
> this time I will get the documentation into postable shape ;-/

Thank you for all your help in getting these changes cleaned and
correctly implemented so quickly.

I've reviewed your latest trylock loop removal patches and found only 1
minor issue. I'll post that separately.

John Ogness
