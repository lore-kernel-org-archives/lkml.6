Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_MIXED_ES,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CB8C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 617F0208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="PI7JXbyj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 617F0208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbeLMLUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 06:20:08 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34001 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728727AbeLMLUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 06:20:06 -0500
Received: by mail-ed1-f66.google.com with SMTP id b3so1730394ede.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 03:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mMX6OBgczGKgREVlBAc+Cx3Zl3lpeS31D8IJu4mm39U=;
        b=PI7JXbyj/Mdr1lOjpjaGpCm3a0TZZs/pIjCjh7AGSxCES7fMmBgnuvppfgN0GD6tvN
         vLHeVcVE+IvjzvRicD9eWYhSVumPX4DYC7NZNuKfzhWxGqjmVxDrFAPgzxhzr60AoffL
         1yeB0DN4tBkshBSrLo3IIcY+WTIFCkPH9euYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mMX6OBgczGKgREVlBAc+Cx3Zl3lpeS31D8IJu4mm39U=;
        b=VvZQpshORO3bvL67A/E7NZ7u9s8zzA5ROSKx0gscHdf6d008h11hX/w05ZGs/sMNMJ
         RzzndAGve/bmpy/AyFIPCv4wgZdqzKDf83W3C0zuecVdZToBIwenHfleekn/qsRrHO4A
         mheKbb9WbR77Xa2k9cN5PS14DzhgZfYLg+K/MwDtvbA6P529A788+P85DpnoGJeRF8fo
         +h/Vabsnzv4TXB/ti+0NaNGe37xF5UUxkHEXZqBNS9ekjMa5UluU/H2T13LGAB/18V5E
         8L5WEuJ5fkoLr3Rjdb1mcTnY48bfMTH1qHKwu10C5lZg0/CPgZkfSoQ2nh+2F3rNYzDx
         Al8g==
X-Gm-Message-State: AA+aEWYcyAU6G9vFa2UJl1vAAjJ1A0jkQot85TpkrCbcfJ65SLzVkTPe
        apteiAhlv7SY6u21q3SC1f8vNQ==
X-Google-Smtp-Source: AFSGD/UE24/lWaJwkZwQ2F61/NDvNW/y+TFIZsv7wCFk+s3RNAU6odl7MNEkuO7Xcl60XPaoTV9a1A==
X-Received: by 2002:a05:6402:170d:: with SMTP id y13mr22536746edu.45.1544700003912;
        Thu, 13 Dec 2018 03:20:03 -0800 (PST)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id v20sm541221edm.29.2018.12.13.03.20.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 03:20:03 -0800 (PST)
Date:   Thu, 13 Dec 2018 12:19:57 +0100
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     Davidlohr Bueso <dbueso@suse.de>, Jason Baron <jbaron@akamai.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] epoll: use rwlock in order to reduce
 ep_poll_callback() contention
Message-ID: <20181213111957.GA8459@andrea>
References: <20181212110357.25656-1-rpenyaev@suse.de>
 <20181212110357.25656-4-rpenyaev@suse.de>
 <20181212171348.GA12786@andrea>
 <a30306ad68b4b7171fbb587f5f845ea5@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a30306ad68b4b7171fbb587f5f845ea5@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 11:13:58AM +0100, Roman Penyaev wrote:
> On 2018-12-12 18:13, Andrea Parri wrote:
> > On Wed, Dec 12, 2018 at 12:03:57PM +0100, Roman Penyaev wrote:
> 
> [...]
> 
> > > +static inline void list_add_tail_lockless(struct list_head *new,
> > > +					  struct list_head *head)
> > > +{
> > > +	struct list_head *prev;
> > > +
> > > +	new->next = head;
> > > +
> > > +	/*
> > > +	 * Initially ->next of a new element must be updated with the head
> > > +	 * (we are inserting to the tail) and only then pointers are
> > > atomically
> > > +	 * exchanged.  XCHG guarantees memory ordering, thus ->next should
> > > be
> > > +	 * updated before pointers are actually swapped.
> > > +	 */
> > > +
> > > +	prev = xchg(&head->prev, new);
> > > +
> > > +	/*
> > > +	 * It is safe to modify prev->next and new->prev, because a new
> > > element
> > > +	 * is added only to the tail and new->next is updated before XCHG.
> > > +	 */
> > 
> > IIUC, you're also relying on "some" ordering between the atomic load
> > of &head->prev above and the store to prev->next below: consider the
> > following snippet for two concurrent list_add_tail_lockless()'s:
> > 
> > {Initially: List := H -> A -> B}
> > 
> > CPU0					CPU1
> > 
> > list_add_tail_lockless(C, H):		list_add_tail_lockless(D, H):
> > 
> > C->next = H				D->next = H
> > prev = xchg(&H->prev, C) // =B		prev = xchg(&H->prev, D) // =C
> > B->next = C				C->next = D
> > C->prev = B				D->prev = C
> > 
> > Here, as annotated, CPU0's xchg() "wins" over CPU1's xchg() (i.e., the
> > latter reads the value of &H->prev that the former stored to that same
> > location).
> > 
> > As you noted above, the xchg() guarantees that CPU0's store to C->next
> > is "ordered before" CPU0's store to &H->prev.
> > 
> > But we also want CPU1's load from &H->prev to be ordered before CPU1's
> > store to C->next, which is also guaranteed by the xchg() (or, FWIW, by
> > the address dependency between these two memory accesses).
> > 
> > I do not see what could guarantee "C->next == D" in the end, otherwise.
> > 
> > What am I missing?
> 
> Hi Andrea,
> 
> xchg always acts as a full memory barrier, i.e. mfence in x86 terms.  So the
> following statement should be always true, otherwise nothing should work as
> the same code pattern is used in many generic places:
> 
>    CPU0               CPU1
> 
>  C->next = H
>  xchg(&ptr, C)
>                      C = xchg(&ptr, D)
>                      C->next = D
> 
> 
> This is the only guarantee we need, i.e. make it simplier:
> 
>    C->next = H
>    mfence            mfence
>                      C->next = D
> 
> the gurantee that two stores won't reorder.  Pattern is always the same: we
> prepare chunk of memory on CPU0 and do pointers xchg, CPU1 sees chunks of
> memory with all stores committed by CPU0 (regardless of CPU1 does loads
> or stores to this chunk).
> 
> I am repeating the same thing which you also noted, but I just want to be
> sure that I do not say nonsense.  So basically repeating to myself.
> 
> Ok, let's commit that.  Returning to your question: "I do not see what
> could guarantee "C->next == D" in the end"
> 
> At the end of what?  Lockless insert procedure (insert to tail) relies only
> on "head->prev".  This is the single "place" where we atomically exchange
> list elements and "somehow" chain them.  So insert needs only actual
> "head->prev", and xchg provides this guarantees to us.

When all the operations reported in the snippet have completed (i.e.,
executed and propagated to memory).

To rephrase my remark:

I am saying that we do need some ordering between the xchg() and the
program-order _subsequent stores, and implicitly suggesting to write
this down in the comment.  As I wrote, this ordering _is provided by
the xchg() itself or by the dependency; so, maybe, something like:

	/*
	 * [...]  XCHG guarantees memory ordering, thus new->next is
	 * updated before pointers are actually swapped and pointers
	 * are swapped before prev->next is updated.
	 */

Adding a snippet, say in the form you reported above, would not hurt
of course. ;-)

  Andrea


> 
> But there is also a user of the list, who needs to iterate over the list
> or to delete elements, etc, i.e. this user of the list needs list fully
> committed to the memory.  This user takes write_lock().  So answering your
> question (if I understood it correctly): at the end write_lock() guarantees
> that list won't be seen as corrupted and updates to the last element, i.e.
> "->next" or "->prev" pointers of the last element are committed and seen
> correctly.
> 
> --
> Roman
> 
> 
> 
> 
> 
