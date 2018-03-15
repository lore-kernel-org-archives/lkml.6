Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AG47ELuo/kPL+2kZv+kixoQFvufYGgTx8tJZkacva6cPFcIJhp8EKwG+1ZU8x9WsvXe+sw/8VFcr
ARC-Seal: i=1; a=rsa-sha256; t=1521117699; cv=none;
        d=google.com; s=arc-20160816;
        b=WWDNFfhG9HVZyGOXqaruapKzjWM893yPTRX79Bw0Jsi37SVXJYKeGVcuYY4VbWPoPv
         vktT1psVmDFwgEgsoZmHDuSn6PAZsEjSt64rKsBUl6RuF3b7WPBVWoReSYOBLP9yeSm4
         ba0A2iQl3IgOk9SFvH/YlySzBJ1Qjl0TLEUZtmGX3re6IqjGOWugP3CxcGYuAyneZmnp
         3o6epMJH1014JkJdU57nygHGMdIWjZvTJPQH3jIjgaW4EtVB0NdTJsb7tEnROo6j6YIZ
         /NNb0wLRtBB9AqjxnTuALX8sEOicNMiLpJ0FKJj16lAXgQanjTsVZ7sTL/2g6RaYUDka
         cPjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=NT4SwMWB/vrkE2LIMkV+IHwflU/1apDcuG/cihpCysQ=;
        b=Hj18Xnlq7EszVtKIzEauSzu6agBr8Am5WtBMDz4mFhRNRcHoUqW7JtOvIz/XVeyl0X
         IwPXuU9zC46mAlTyd0g9zxC0C3cqUMTaAfjz9LPNWwuIHUxsp/nE3phoLS2P5b8e9Yjs
         +pkrXF1jHvusaZchVZfIVIuG+wY6CAKZJDpnwdnAR45M9fh9tDnJWtjX3YpQ5mQoVjKi
         eBzf3qVXWHaZs7GFWAZxW578D0tRA00mPohceYnn77pnIv6leZFUIhgA4zb++UXeCI36
         lWLDnyxCYabnSwUJQln+sphTr0E1IvlnZ6s6O8TzShKUdHdAo2EtO68AAwoDJUGI3mEG
         2aHg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=ebg51rTO;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=ebg51rTO;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=peterz@infradead.org
Date: Thu, 15 Mar 2018 13:41:30 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Byungchul Park <byungchul.park@lge.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	DRI Development <dri-devel@lists.freedesktop.org>,
	Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
	Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
	Marta Lofstedt <marta.lofstedt@intel.com>,
	Ingo Molnar <mingo@kernel.org>, Tejun Heo <tj@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>, Shaohua Li <shli@fb.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>, Oleg Nesterov <oleg@redhat.com>,
	Daniel Vetter <daniel.vetter@intel.com>, kernel-team@lge.com,
	Amir Goldstein <amir73il@gmail.com>, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] kthread: finer-grained lockdep/cross-release completion
Message-ID: <20180315124130.GY4064@hirez.programming.kicks-ass.net>
References: <20171207100849.407-1-daniel.vetter@ffwll.ch>
 <20171208105419.jdzene5wrsriwm2n@hirez.programming.kicks-ass.net>
 <20171211091928.cpw3srz2rddmruxj@phenom.ffwll.local>
 <20171218071159.GW26573@phenom.ffwll.local>
 <CA+55aFwD+0hhehWHmh8PW9eDCVtEBTi9KCmCrJXZRUFj77r82Q@mail.gmail.com>
 <20171219095925.GY26573@phenom.ffwll.local>
 <aae95b90-a0c8-4825-17fb-b31eb1aecf80@lge.com>
 <CAKMK7uHdk1CT9YP00fb0mpBQdg_Di6CKv+z5ZXSS9Q4tbOcwAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uHdk1CT9YP00fb0mpBQdg_Di6CKv+z5ZXSS9Q4tbOcwAg@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1586119401963161178?=
X-GMAIL-MSGID: =?utf-8?q?1595007513287110539?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 15, 2018 at 11:31:57AM +0100, Daniel Vetter wrote:
> Is there any progress on getting cross-release enabled again?

Not yet, I'm still fighting the meltdown/spectre induced backlog.

We'll get to it eventually.
