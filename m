Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AH8x224xmbBaeWHJ9yqAiQC7twdfUWgchkXU3NijUQb/wiugzEfVxv+R7W3HWCOV8cvPMpt0h5AJ
ARC-Seal: i=1; a=rsa-sha256; t=1519135607; cv=none;
        d=google.com; s=arc-20160816;
        b=dpRs+X1LmfZ4cCFTeypy/qaDK9e+j+Gq74QFFlVwdfqYiPisgCmr9aGjGFKjvW6OY8
         N0067DPzvhE1nOOYM4/aTi1mSIxwAFwsOk6ofeD47+qW5fmEf6mvqrG63YHiUzRaGu4F
         A+QOq2XJMxk+H+xGiS5/DMZzl7b6OwKorr0xSctU2hTkF1msXA8n7XkhNLzYvtTSIAyg
         T/j81nRZDbbGAOtFDEy1wHAApZnCSDRJ/sOtG3jtr9UH1myS+j/mQeeRaWbHcwixX+Us
         YNzVUe+80P+b+YZb0K1KnNc3SbG6p0gvkCwYoT2bllQccuveorrSX6Q0gsRbrjIyFXUc
         xv8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=cOlBAcYslFrqTFt+c/zQXK+N4TiEvJVaZuQBUP7k9KA=;
        b=WGv39uDGwrhCWZmvu39XCmMc9utRTm3ERjsOaMSEnqGCxYflc8fHfPHP21TIkkfcTc
         P6rsFUepFrnk0uu4NFbPF2XV/U8h+JNqziQDtTGce2Wshojn3EOUyH8e8aF3p/+fbu8M
         wYuslcOTFJa4wD7UGwXbFrX0jLrcP5ewqzMC1+t4uCX9FaxgLkVwquZ5cpjNHGoEw4JK
         0JfvthwuhQOgLVmVSIR3GIRCubyDs5wEWItWgtGyxLrN0s89bjwzI2nSeLbmnQ2WjVuI
         FyniN1cjJQaJKjIlNaWn6jptlkOXXJ27aDn/QMkRpyC5DyT1Dux7ZCAfppIuEGFQ3A+T
         JV4A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=FTSbX7KK;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 2001:8b0:10b:1231::1 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=FTSbX7KK;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 2001:8b0:10b:1231::1 as permitted sender) smtp.mailfrom=peterz@infradead.org
Date: Tue, 20 Feb 2018 15:06:40 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>, linux-audit@redhat.com
Subject: Re: [PATCH 4.10 070/111] audit: fix auditd/kernel connection state
 tracking
Message-ID: <20180220140640.GE25201@hirez.programming.kicks-ass.net>
References: <20170328122915.640228468@linuxfoundation.org>
 <20170328122918.597715642@linuxfoundation.org>
 <20180220123757.GE25314@hirez.programming.kicks-ass.net>
 <CAHC9VhTOxzcJpVSFDign56jkkruQjujTp7GQzk107FNWYTXRYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhTOxzcJpVSFDign56jkkruQjujTp7GQzk107FNWYTXRYg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1563117219402183667?=
X-GMAIL-MSGID: =?utf-8?q?1592929137459661754?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 20, 2018 at 08:25:21AM -0500, Paul Moore wrote:
> On Tue, Feb 20, 2018 at 7:37 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > On Tue, Mar 28, 2017 at 02:30:56PM +0200, Greg Kroah-Hartman wrote:
> >> 4.10-stable review patch.  If anyone has any objections, please let me know.
> >
> >> +     if (!(auditd_test_task(current) ||
> >> +           (current == __mutex_owner(&audit_cmd_mutex)))) {
> >> +             long stime = audit_backlog_wait_time;
> >
> > Since I cannot find the original email on lkml, NAK on this.
> > __mutex_owner() is not a general purpose helper function.
> 
> Since this code also exists in the current kernel, I need to ask what
> recommended alternatives exist for determining the mutex owner?
> 
> I imagine we could track the mutex owner separately in the audit
> subsystem, but I'd much prefer to leverage an existing mechanism if
> possible.

It's not at all clear to me what that code does, I just stumbled upon
__mutex_owner() outside of the mutex code itself and went WTF.

The comment (aside from having the most horribly style) is wrong too,
because it claims it will not block when we hold that lock, while,
afaict, it will in fact do just that.

Maybe if you could explain how that code is supposed to work and why it
doesn't know if it holds a lock I could make a suggestion...
