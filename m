Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752840AbeDLLWG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 07:22:06 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:46233 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751589AbeDLLWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 07:22:04 -0400
X-Google-Smtp-Source: AIpwx4+gaGk/ae427f6/WqHs+l/ZWckGbQG25Iv7Tf+FBHKYgbY3y2ZGLOoNHFsv71ILrrpDL8vE7w==
Date: Thu, 12 Apr 2018 13:21:55 +0200
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: paulmck@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH] memory-model: fix cheat sheet typo
Message-ID: <20180412112155.GA9154@andrea>
References: <1523292618-10207-1-git-send-email-pbonzini@redhat.com>
 <20180409184258.GP3948@linux.vnet.ibm.com>
 <20180410203214.GA19606@linux.vnet.ibm.com>
 <8cbda122-6aa3-365b-fd09-52dca0644cbd@redhat.com>
 <20180410213434.GC3948@linux.vnet.ibm.com>
 <156ac07b-7393-449f-518a-6b1c2cff8efb@redhat.com>
 <20180412092303.GA6044@andrea>
 <eda463d8-aa4e-2e6b-9d1d-41a5a4eaa3a7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eda463d8-aa4e-2e6b-9d1d-41a5a4eaa3a7@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12, 2018 at 12:18:13PM +0200, Paolo Bonzini wrote:
> On 12/04/2018 11:23, Andrea Parri wrote:
> >>
> >> - smp_store_mb() is missing
> > 
> > Good point. In fact, we could add this to the model as well:
> > following Peter's remark/the generic implementation,
> 
> Good idea.  smp_store_mb() can save some clock cycles in the relatively
> common idiom
> 
> 	write a				write b
> 	read b				read a
> 	if (b)				if (a)
> 	  wake 'em			  we've been woken
> 
> > Yeah, those 'Ordering is cumulative', 'Ordering propagates' could
> > mean different things to different readers... IMO, we may even omit
> > such information; this doc. does not certainly aim for completeness,
> > after all. OTOH, we ought to refrain from making this doc. an excuse
> > to transform (what it is really) high-school maths into some black
> > magic.
> FWIW, what I miss in explanation.txt (and to some extent in the paper)
> is a clear pointer to litmus tests that rely on cumulativity and
> propagation.  In the meanwhile I'll send some patches.  Thanks for the
> feedback, as it also helps validating my understanding of the model.

The litmus test that first comes to my mind when I think of cumulativity
(at least, 'cumulativity' as intended in LKMM) is:

   WRC+pooncerelease+rmbonceonce+Once.litmus

for 'propagation', I could mention:

   IRIW+mbonceonces+OnceOnce.litmus

(both tests are availabe in tools/memory-model/litmus-tests/). It would
be a nice to mention these properties in the test descriptions, indeed.

You might find it useful to also visualize the 'valid' executions (with
the main events/relations) associated to each of these tests; for this,

   $ herd7 -conf linux-kernel.cfg litmus-tests/your-test.litmus \
	-show all -gv

(assuming you have 'gv' installed).

  Andrea


> 
> Thanks,
> 
> Paolo
