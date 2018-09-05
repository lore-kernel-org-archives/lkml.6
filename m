Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E42FC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE4A820857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="n006WzUr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE4A820857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbeIELux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 07:50:53 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43680 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbeIELux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 07:50:53 -0400
Received: by mail-ed1-f68.google.com with SMTP id z27-v6so5226461edb.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 00:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z7jmwhqR0ToEBKz29jaeG83cs/76ebLJCxEE8TDqqLw=;
        b=n006WzUrF+P5G//xc8L3Gpl327WDloE/iDLJKgqxqdL4PFo1a2oIH5SKUWjn9ccOgH
         3lTYX4KkFM1s6EH/J8zqP1PhwscPzkpGGzAF1IkWCjJo0BckjEelxwC2Rmom7coeG7WO
         QlyDt+W8zxBrrEKrB66ex/A5scCGRwaQieWgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z7jmwhqR0ToEBKz29jaeG83cs/76ebLJCxEE8TDqqLw=;
        b=Wj76NoLVo1FWjeuGEjkWurbMAPcjx7OCYIZTVG+HNaH4c1YYqQwVef9aQNl4yWkdyv
         jfv+cDttiTQKzcxYzTe9zKSI1oEl66On2v82z0DZSAtinhAIcW0/x2/EtwkhD/aBt9oG
         HHKLhJxJqm1RiKew/tEQ1O8ntGbYns5XP1/8UDTd9iPRey55GzrCMdJZmfiEHfU3Ec9s
         tW6K294/y2naviPIUAFEQJfEQVveafI0IcNwYNRcNfazZo4V7WRUxQqzqBm1PgR62WDS
         w6GK9AnM68L84y+1o6/EePGtbplK98rCk5pkNGCgTRr+0vPSDHUHC8LREwjCKrpyZxPX
         N9oA==
X-Gm-Message-State: APzg51CGGZQnS65EWMcZFOO1Dm39HqaqjxUDihOxjQmOcMYqZFzS//Lw
        ffXCUK6JaaXZX2lRvhy7AM1gTw==
X-Google-Smtp-Source: ANB0VdaFdEIw4p7CadJMT9kxFQFxdX1bfW43BwKnlLTmVsMdSRMDUFa2rKNS04D4gbwsvhULJlZYSQ==
X-Received: by 2002:a50:8843:: with SMTP id c3-v6mr41369416edc.146.1536132122062;
        Wed, 05 Sep 2018 00:22:02 -0700 (PDT)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id w2-v6sm981668edw.83.2018.09.05.00.21.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Sep 2018 00:22:01 -0700 (PDT)
Date:   Wed, 5 Sep 2018 09:21:51 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Will Deacon <will.deacon@arm.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: [PATCH RFC LKMM 1/7] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
Message-ID: <20180905072151.GA3185@andrea>
References: <20180904081144.GA4137@andrea>
 <Pine.LNX.4.44L0.1809041503470.17060-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1809041503470.17060-100000@netrider.rowland.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 03:09:49PM -0400, Alan Stern wrote:
> On Tue, 4 Sep 2018, Andrea Parri wrote:
> > Heh, your confusion might be the reflection of mine... ;-)  That was
> > indeed a long and not conclusive discussion (meaning there're pending
> > issues); and I cannot claim to find "arguments" such as:
> > 
> >   "More than one kernel developer has expressed the opinion that
> >    the LKMM should enforce ordering of writes by locking."
> > 
> > particularly helpful (I do tend to be convinced by arguments rather
> > than by opinions).  In fact, you can take the following as my only
> > current "constructive argument" against the patch [1,2]:
> > 
> >   THE COMMIT MESSAGE IS RIDICULOUS; PLEASE EXPAND ON IT, AND DO
> >   SO BY LEVERAGING BOTH PROS AND CONS OF THE APPLIED CHANGES
> 
> Do you have any concrete suggestions (i.e., some actual text) for 
> improvements to the patch description?  Earlier in your message you 
> mentioned that Will's comment:
> 
> 	LKMM offers stronger guarantees that can portably be relied upon
> 	in the codebase.
> 
> would make a good addition.  Suitably edited, it could be added to the
> description.  I can think of a few other things myself, but I'd like to 
> hear your thoughts.  Anything else?

Yes: I do sometimes have the impression that your "rules" for trimming
text in emails/replies are too aggressive...

  Andrea


> 
> Alan
> 
