Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BE6C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ECB32173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="c8wv7QKV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbfAJMaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 07:30:17 -0500
Received: from mail-ed1-f52.google.com ([209.85.208.52]:37887 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727623AbfAJMaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 07:30:17 -0500
Received: by mail-ed1-f52.google.com with SMTP id h15so10067934edb.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 04:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b5pwS76upqu7bf/WK5Q8xprKyMjmubH4YvD9bF2stR4=;
        b=c8wv7QKV90iU4qXqQd07I0F5nV9SFIYzw3qlmfVNHbVhBMGy5fE98sXcmuKj8ILBI+
         7fVnjxgY40+gTsvmhvX5YUVwNYHzw8SDWb3Zf8pmeon625KZScUyGmoGC0RcRzMyZCSx
         UvX8+1vpaPWL2ubc/bfz5i6aaLoexbgMgcnRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b5pwS76upqu7bf/WK5Q8xprKyMjmubH4YvD9bF2stR4=;
        b=EBzm52W0Lido2/iS/oK1T6g0w+wPT27q+BBRhVHJSRR6ThLqmisT+H3jPvR2hPoNQT
         iQLuZNJhbjS5cI6CdqtzrWsEVmvnvlI9Br9rIA+hM+IL3VwMxixTe2UryYBd9OKxwSOY
         +1G2OY2F69z3u5mMVUwhJHQnZRwcPiYq5kfjQSbqJZcojhTdllfW/kLaPdDcGFtAc/Fk
         voKm5VtmnQhSDZpCekuej4SIb/+loxZThy7mXZ8EMBWEYOiaBdtFjhP0r6z9OootUEQd
         yF3eKMiRYqpXy/pae+b/JXB/24WeQUdWBu0UVy2KDMem0u7WlajG+UTk1HMh+ajkL0Ox
         OPWg==
X-Gm-Message-State: AJcUukccPCcoX5ZuEsA3ABLiJazld4DSJfc34gaEBwUL7bfizzMINnPJ
        pB/NfpQUARj440uo3PcIES+v6e+v/5+4lQ==
X-Google-Smtp-Source: ALg8bN5+8wrhCNFbCCHA2eiJ2wlprZOBErcfIaqZvf1a1SOYmTlcEi+Y1OYmCKYB0BZg0My9ata+VQ==
X-Received: by 2002:aa7:c605:: with SMTP id h5mr9664169edq.9.1547123415557;
        Thu, 10 Jan 2019 04:30:15 -0800 (PST)
Received: from andrea (86.100.broadband17.iol.cz. [109.80.100.86])
        by smtp.gmail.com with ESMTPSA id 97sm1709025edq.45.2019.01.10.04.30.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 04:30:14 -0800 (PST)
Date:   Thu, 10 Jan 2019 13:30:08 +0100
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Anatol Pomozov <anatol.pomozov@gmail.com>,
        Florian Westphal <fw@strlen.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Luc Maranget <luc.maranget@inria.fr>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: seqcount usage in xt_replace_table()
Message-ID: <20190110123008.GA13625@andrea>
References: <CAOMFOmU=t9YbE68YpoQn0Ug0XN1F+0iuJp9J=htCRRrbdaPSVA@mail.gmail.com>
 <20190109000214.GA5907@andrea>
 <CAOMFOmUSttpLyeiRLjxw4rSN0tOiAq1jbwK=kRdCkuOKPOC3Rg@mail.gmail.com>
 <20190109112432.GA6351@andrea>
 <CACT4Y+YAr1XuwAy1qRL678VHZjzsbAQ05o1zoN9ZfC0muYzK8g@mail.gmail.com>
 <20190109121126.GA7141@andrea>
 <CACT4Y+azpzvjmUTdWj6H4qe4mELx924pGrY_VFZD9Hi+4VMj5g@mail.gmail.com>
 <20190109171053.GY1215@linux.ibm.com>
 <CACT4Y+ZZYxE5z4_wZ_Na3z6Y-RmhfrHt3y3sQzUcdUuR35Xc_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZZYxE5z4_wZ_Na3z6Y-RmhfrHt3y3sQzUcdUuR35Xc_g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> For seqcounts we currently simply ignore all accesses within the read
> section (thus the requirement to dynamically track read sections).
> What does LKMM say about seqlocks?

LKMM does not currently model seqlocks, if that's what you're asking;
c.f., tools/memory-model/linux-kernel.def for a list of the currently
supported synchronization primitives.

LKMM has also no notion of "data race", it insists that the code must
contain no unmarked accesses; we have been discussing such extensions
since at least Dec'17 (we're not quite there!, as mentioned by Paul).

My opinion is that ignoring all accesses within a given read section
_can_ lead to false negatives (in every possible definition of "data
race" and "read sections" I can think of at the moment ;D):

	P0				P1
	read_seqbegin()			x = 1;
	r0 = x;
	read_seqretry() // =0

ought to be "racy"..., right?  (I didn't audit all the callsites for
read_{seqbegin,seqretry}(), but I wouldn't be surprised to find such
pattern ;D ... "legacy", as you recalled).

  Andrea
