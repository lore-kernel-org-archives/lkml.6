Return-Path: <linux@dominikbrodowski.net>
X-Google-Smtp-Source: AH8x225r3a9G8t3H+hU+32af3Vik4o0NEvV+nlyHYgVw1Bs6HzSOJl7ZwqO4hX5XRKqrpzLTUG4K
ARC-Seal: i=1; a=rsa-sha256; t=1517773282; cv=none;
        d=google.com; s=arc-20160816;
        b=WLxiRJRjnqpj+L+hz94Q3NLYF8MfUL3tw7S8nbQBvajhVd2/o6J+au2pTl4Yz0qyTA
         eQzVctsnW5GCx48UT8COtvNVO87yi1L2L+EYenVtrtozjeB0MqFYHLd+zFBO/NJIXeBI
         RcXU+ed55FUlZeTnntP801b9X05nWVfyv10JTAAK4NWthkckQIHJNRCNjkaEoWmdCg4k
         qITHOh0aLBKWwKAbyHVJGeL5ATjK2Hyk0vQUJmHkH5Nu0f9vJt1i1XZLkdeGPmZgTy7C
         30Ivp8AcJvnwUWkqcueISAg1gpd5/bfUjovg6QYThsj7iS8hudJZH2qinGmDj4LhGXHo
         KosQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=AkMIERttXWK4WNHNk0+Hqbq+aRESUgYMpYo8aqtPSBo=;
        b=RgUqLi/YX1ERPGd3f3PKmAPQfh+yZ9Mosep+Sc2to8qHNJpqIXaD8NnJDsD+ts28e/
         Yt6Rx4CbNzHBjiTmeDVi5KXt8bPaBSmpbtr599njklwo40yMNCKqUdTDhy1tShe2QVYa
         mdxv16s8guXipyBsltlMQLuvUVMXw5pKe+VFdN00+ugXPscCu7/DEzoIYDUrnzmpO2YM
         6WQrm07q31ZWWDmyIn9fUWIJ4UpHnom/eWTCmSxNBuyfiKHVnQpNyee4kH7f79gUgo99
         tZRvRVx/wgATOyFlqUNYIdVfvTL7GoE/mKE0aoWXn/yQYu1NHwUHQxKBhRFWN5eTifkv
         Nrnw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 136.243.71.142 is neither permitted nor denied by best guess record for domain of linux@dominikbrodowski.net) smtp.mailfrom=linux@dominikbrodowski.net
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 136.243.71.142 is neither permitted nor denied by best guess record for domain of linux@dominikbrodowski.net) smtp.mailfrom=linux@dominikbrodowski.net
Date: Sun, 4 Feb 2018 20:39:02 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: David Woodhouse <dwmw2@infradead.org>,
	Tim Chen <tim.c.chen@linux.intel.com>
Cc: mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
	tglx@linutronix.de, jpoimboe@redhat.com,
	"Wieczorkiewicz, Pawel" <wipawel@amazon.de>,
	David Woodhouse <dwmw@amazon.co.uk>, arjan@linux.intel.com,
	karahmed@amazon.de, x86@kernel.org, bp@alien8.de,
	peterz@infradead.org, pbonzini@redhat.com, ak@linux.intel.com,
	torvalds@linux-foundation.org, gregkh@linux-foundation.org,
	luto@kernel.org
Subject: Re: [tip:x86/pti] x86/speculation: Use Indirect Branch Prediction
 Barrier in context switch
Message-ID: <20180204193901.GA29757@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2f5614a5-b7c4-52cf-a66f-6f62c2602bee@linux.intel.com>
 <1517473913.18619.281.camel@infradead.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590966106432961445?=
X-GMAIL-MSGID: =?utf-8?q?1591500637153082436?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 01, 2018 at 08:31:53AM +0000, David Woodhouse wrote:
> On Wed, 2018-01-31 at 08:03 +0100, Dominik Brodowski wrote:
> > Whether a process needs protection by IBPB on context switches is a
> > different question to whether a process should be allowed to be dumped,
> > though the former may be a superset of the latter. Enable IBPB on all
> > context switches to a different userspace process, until we have a clear
> > mitigation strategy for userspace against Spectre-v2 designed and
> > implemented.
> >
> > ...
> >                 if (tsk && tsk->mm &&
> > -                   tsk->mm->context.ctx_id != last_ctx_id &&
> > -                   get_dumpable(tsk->mm) != SUID_DUMP_USER)
> > +                   tsk->mm->context.ctx_id != last_ctx_id)
> >                         indirect_branch_prediction_barrier();
> 
> 
> I understand your argument and I sympathise.
> 
> But that's going to hurt a *lot*, and we don't even have a viable
> proof-of-concept for a user←→user Spectre v2 attack, do we? It's only
> theoretical?

Wasn't the PoC in the Spectre paper user←→user (though on a different OS)?
And what makes KVM←→KVM so much more likely/dangerous/..., that IBPB will
be done there unconditionally (AFAICS)?


And, somewhat related, @Tim Chen:

On Wed, Jan 31, 2018 at 03:25:44PM -0800, Tim Chen wrote:
> For people who opt for more security, it is reasonable to consider
> alternate policies to distinguish friend and foe so we know if we are coming
> from a potentially hostile environment.  Ptrace is one means to do so, and probably
> there are other ways depending on usages.  I hope we can have a discussion on what we should
> use to determine if two processes are friend or foe.  Say do all the processes
> from the same containers are considered friends with each other?

To my understanding, the concept of "containers" is meant to be kept outside
of the kernel. What *namespaces* / *control groups* can be considered
friends with each other?


Thanks,
	Dominik
