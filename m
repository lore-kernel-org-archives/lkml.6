Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A007CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A30D2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="niNFsZaX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfARJsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 04:48:14 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39560 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfARJsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 04:48:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5yvaaMUnvBRGI6OXjgZWR2JQ8xSp5j4x0NB7WcwVHm4=; b=niNFsZaX0nQAD1gLC0g0thahT
        S5j2Tl8QtYroG0HS79wMiI88yNcM1kPfipiPvw94p6csKgjjSbu5Ocwtobb8onuPgwhTUWnJu7248
        U8nQg94O1OXX18Bl8Hi0poHpihRQSvCqdoK6lxDUWEgvtJMPsAj5SFixzHMiwDTFosc6/05RzCuC1
        IbcCZJ75wwcFd5dWtyHrQf6p5g/x38X2nNec2Fvnz5nmFCJRxiuePbaJs6UnKgdSolws/LknL0k1t
        ScJEpWLYdM1Rd25CobDcErrkXc04ATgNwqQnYru6C+FymtOKYndDyc3JP4ckND0A6YgRROOohNJLs
        DZDzDvWSQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gkQl1-0006Mx-Fl; Fri, 18 Jan 2019 09:48:11 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B5D8020578D1E; Fri, 18 Jan 2019 10:48:08 +0100 (CET)
Date:   Fri, 18 Jan 2019 10:48:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     mingo@redhat.com, tj@kernel.org, longman@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 00/16] locking/lockdep: Add support for dynamic keys
Message-ID: <20190118094808.GA27931@hirez.programming.kicks-ass.net>
References: <20190109210204.192109-1-bvanassche@acm.org>
 <20190111124835.GP1900@hirez.programming.kicks-ass.net>
 <1547222103.83374.72.camel@acm.org>
 <20190111165529.GA14054@worktop.programming.kicks-ass.net>
 <1547226101.83374.80.camel@acm.org>
 <20190114125235.GB20726@hirez.programming.kicks-ass.net>
 <1547484753.83374.109.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547484753.83374.109.camel@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 08:52:33AM -0800, Bart Van Assche wrote:
> On Mon, 2019-01-14 at 13:52 +0100, Peter Zijlstra wrote:
> > On Fri, Jan 11, 2019 at 09:01:41AM -0800, Bart Van Assche wrote:
> > > The list_del_rcu() call must only happen once. 
> > 
> > Yes; obviously. But if we need to check all @pf's, that means the entry
> > is still reachable after a single reset_lock()/free_key_range(), which
> > is a bug.
> > 
> > > I ran into complaints reporting that
> > > the list_del_rcu() call triggered list corruption. This change made these complaints
> > > disappear.
> > 
> > I'm saying this solution buggy, because that means the entry is still
> > reachable after we do call_rcu() (which is a straight up UAF).
> > 
> > Also put it differently, what guarantees checking those two @pf's is
> > sufficient. Suppose your earlier @pf already did the RCU callback and
> > freed stuff while the second is in progress. Then you're poking into
> > dead space.
> 
> zap_class() only examines elements of the list_entries[] array for which the
> corresponding bit in list_entries_in_use has been set. The RCU callback clears 
> the bits in the list_entries_in_use that correspond to elements that have been
> freed. The graph lock serializes zap_class() calls and the code inside the
> RCU callback. So it's not clear to me why you are claiming that zap_class()
> would trigger a use-after-free?

The scenario is like:


CPU0					CPU1					CPU2

lockdep_reset_lock_reg()
  pf = get_pending_free_lock() // pf[0]
  __lockdep_reset_lock(pf)
    zap_class()
  schedule_free_zapped_classes(pf)
    call_rcu()


  // here is wbere the objects 'freed' in zap_class()
  // can still be used through references obtained
  // __before__ we did call_rcu().


					lockdep_reset_lock_reg()
					  pf = get_pending_free_lock() // pf[1]
					  __lockdep_reset_lock(pf)
					    zap_class()
					      list_entry_being_freed()
						// checks: pf[0]

						// this is a problem, it
						// should _NEVER_ match
						// anything from pf[0]

						// those entries should
						// be unreachable,
						// otherwise:


										rcu_read_lock()
										entry = rcu_dereference()

<rcu-callback>
  free_zapped_classes()

										entry->class // UAF, just freed by rcu-callback

										rcu_read_unlock()




Now, arguably, I'm having a really hard time actually finding the RCU user of
lock_list::entry, the comment in add_lock_to_list() seems to mention
look_up_lock_class(), but the only RCU usage there is the
lock_class::hash_entry, not lock_list::entry.

If lock_class is not indeed RCU used, that would simplify things. Please
double check.

But in any case, the normal RCU pattern is:

lock()
add-to-data-structure()
unlock()

				rcu_read_lock()
				obj = obtain-from-data-structure();

lock()
remove-from-data-structure()
  call_rcu()
unlock();

				use(obj);
				rcu_read_unlock();


<rcu-callback>
  actually-free-obj()



Fundamentally RCU delays the callback to the point where the last observer
that started before call_rcu() has finished and no later (in practise it often
is much later, but no guarantees there). So being able to reach an object
after you did call_rcu() on it is a fundamental fail.
