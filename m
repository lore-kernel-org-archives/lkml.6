Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F88C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 04:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EDBA20685
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 04:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="ISuQrwSN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EDBA20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbeKEOBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 09:01:12 -0500
Received: from mail-pl1-f174.google.com ([209.85.214.174]:40603 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728165AbeKEOBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 09:01:12 -0500
Received: by mail-pl1-f174.google.com with SMTP id q19-v6so815143pll.7
        for <linux-kernel@vger.kernel.org>; Sun, 04 Nov 2018 20:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fks9JqoS8Tas8PAY9mHiXxOvVDtJlgh1vPNwZ/RNCFM=;
        b=ISuQrwSNkaQNf4bkbhRyJsgR+GYhfFsc6sUMhJEtq1R4CeccQX4RDfl6hCE3z82+7t
         tKo2o0BZwaIkgNQktjIcpf2IARlMb49ycI0300P4C4g4fwGg3SnczytIEVlz/LQY+TgH
         jsrdx18tRKCFPIjYymF/9v0s96VezUI1Gkcnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fks9JqoS8Tas8PAY9mHiXxOvVDtJlgh1vPNwZ/RNCFM=;
        b=PZGC5nUTfS1KNcIlPFCGxD9/N27HjltE9RQ/MNaWzK5/2O3d3JzEZ5l10sICUNlyD3
         4WPZoXzaSpaUUjZHM82XoMz6Pki/U4ahBpqqg9m/e2hqpiSy40LnAp0q/MlY1tDWv9ak
         CAbd4uo1hY0/ei5GoRNbZQNd806uUJjzqBaYPWGMtFEv8yIvNkQqr6dYuQZEmUp5MA0t
         hkY5hn4O0eS1sPwTy0WDDz+Wq5sUmthVDaELjRY8gYjohE0n5S5ED5A9a/yCm8LWYNOT
         9sLxKd1kqPB1XOs7Z6PBYZEYgLf2edmSS7pp5tHplGAWEsYdN3Yw1Z35uFDL+oRVGP7/
         3V3Q==
X-Gm-Message-State: AGRZ1gLLQJSdbI4Hobvh8Ap7fp/bYXC3jTTVqkkkYvRv+SvIBocjUlyw
        xbFk8hUT8mizF+VLprvzHoHr8Q==
X-Google-Smtp-Source: AJdET5c0WGOS5fMfWeZfOVLTNTNYv7XzaSWq8Qr4qzcnHRoBRfj761kWjMTmeLE1ptCmAqfwRzQs8Q==
X-Received: by 2002:a17:902:1122:: with SMTP id d31-v6mr20818422pla.259.1541393008948;
        Sun, 04 Nov 2018 20:43:28 -0800 (PST)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id o30-v6sm35253049pgm.89.2018.11.04.20.43.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Nov 2018 20:43:27 -0800 (PST)
Date:   Sun, 4 Nov 2018 20:43:26 -0800
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [RFC] doc: rcu: remove note on smp_mb during synchronize_rcu
Message-ID: <20181105044326.GC56850@google.com>
References: <20181030222649.GA105735@joelaf.mtv.corp.google.com>
 <20181030234336.GW4170@linux.ibm.com>
 <20181031011119.GF224709@google.com>
 <20181031181748.GG4170@linux.ibm.com>
 <20181101050019.GA45865@google.com>
 <20181101161307.GO4170@linux.ibm.com>
 <20181103051226.GA18718@google.com>
 <20181103232259.GJ4170@linux.ibm.com>
 <20181104034956.GA112512@google.com>
 <20181105034330.GP4170@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105034330.GP4170@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 04, 2018 at 07:43:30PM -0800, Paul E. McKenney wrote:
[...]
> > > > > > > > Also about GP memory ordering and RCU-tree-locking, I think you mentioned to
> > > > > > > > me that the RCU reader-sections are virtually extended both forward and
> > > > > > > > backward and whereever it ends, those paths do heavy-weight synchronization
> > > > > > > > that should be sufficient to prevent memory ordering issues (such as those
> > > > > > > > you mentioned in the Requierments document). That is exactly why we don't
> > > > > > > > need explicit barriers during rcu_read_unlock. If I recall I asked you why
> > > > > > > > those are not needed. So that answer made sense, but then now on going
> > > > > > > > through the 'Memory Ordering' document, I see that you mentioned there is
> > > > > > > > reliance on the locking. Is that reliance on locking necessary to maintain
> > > > > > > > ordering then?
> > > > > > > 
> > > > > > > There is a "network" of locking augmented by smp_mb__after_unlock_lock()
> > > > > > > that implements the all-to-all memory ordering mentioned above.  But it
> > > > > > > also needs to handle all the possible complete()/wait_for_completion()
> > > > > > > races, even those assisted by hypervisor vCPU preemption.
> > > > > > 
> > > > > > I see, so it sounds like the lock network is just a partial solution. For
> > > > > > some reason I thought before that complete() was even called on the CPU
> > > > > > executing the callback, all the CPUs would have acquired and released a lock
> > > > > > in the "lock network" atleast once thus ensuring the ordering (due to the
> > > > > > fact that the quiescent state reporting has to travel up the tree starting
> > > > > > from the leaves), but I think that's not necessarily true so I see your point
> > > > > > now.
> > > > > 
> > > > > There is indeed a lock that is unconditionally acquired and released by
> > > > > wait_for_completion(), but it lacks the smp_mb__after_unlock_lock() that
> > > > > is required to get full-up any-to-any ordering.  And unfortunate timing
> > > > > (as well as spurious wakeups) allow the interaction to have only normal
> > > > > lock-release/acquire ordering, which does not suffice in all cases.
> > > > 
> > > > Sorry to be so persistent, but I did spend some time on this and I still
> > > > don't get why every CPU would _not_ have executed smp_mb__after_unlock_lock at least
> > > > once before the wait_for_completion() returns, because every CPU should have
> > > > atleast called rcu_report_qs_rdp() -> rcu_report_qs_rnp() atleast once to
> > > > report its QS up the tree right?. Before that procedure, the complete()
> > > > cannot happen because the complete() itself is in an RCU callback which is
> > > > executed only once all the QS(s) have been reported.
> > > > 
> > > > So I still couldn't see how the synchronize_rcu can return without the
> > > > rcu_report_qs_rnp called atleast once on the CPU reporting its QS during a
> > > > grace period.
> > > > 
> > > > Would it be possible to provide a small example showing this in least number
> > > > of steps? I appreciate your time and it would be really helpful. If you feel
> > > > its too complicated, then feel free to keep this for LPC discussion :)
> > > 
> > > The key point is that "at least once" does not suffice, other than for the
> > > CPU that detects the end of the grace period.  The rest of the CPUs must
> > > do at least -two- full barriers, which could of course be either smp_mb()
> > > on the one hand or smp_mb__after_unlock_lock() after a lock on the other.
> > 
> > I thought I'll atleast get an understanding of the "atleast two full
> > barriers" point and ask you any questions at LPC, because that's what I'm
> > missing I think. Trying to understand what can go wrong without two full
> > barriers. I'm sure an RCU implementation BoF could really in this regard.
> > 
> > I guess its also documented somewhere in Tree-RCU-Memory-Ordering.html but a
> > quick search through that document didn't show a mention of the two full
> > barriers need.. I think its also a great idea for us to document it there
> > and/or discuss it during the conference.
> > 
> > I went through the litmus test here for some hints on the two-barriers but
> > couldn't find any:
> > https://lkml.org/lkml/2017/10/5/636
> > 
> > Atleast this commit made me think no extra memory barrier is needed for
> > tree RCU:  :-\
> > https://lore.kernel.org/patchwork/patch/813386/
> > 
> > I'm sure your last email will be useful to me in the future once I can make
> > more sense of the ordering and the need for two full barriers, so thanks a
> > lot for writing it!
> 
> Hmmm...  I have had this argument before, haven't I?  Perhaps I should
> take some time and get my story straight.  ;-)
> 
> In my defense, I have been doing RCU since the early 1990s, long before
> executable formal memory models.  I kept it working through sheer
> paranoia, and that is a hard habit to shake...

Sure no problem, thanks a lot for taking another look into it!

Regards,

- Joel

