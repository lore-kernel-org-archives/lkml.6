Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D49C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 247752064E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="psldWJY+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 247752064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbeJBPKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 11:10:48 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38960 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727383AbeJBPKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 11:10:47 -0400
Received: by mail-wm1-f67.google.com with SMTP id q8-v6so1259766wmq.4;
        Tue, 02 Oct 2018 01:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f7BbdS5AMkoj7s+HNtl3QGBqiscDNb/dpwOy93R4ZSg=;
        b=psldWJY+UZQ03rYyfCJOolbuhZeT5exWTupwg5jyGcrftTw5fA4T75bToluRIPIsZh
         BEQQvSg2dOwaHktdGm3iDbsEqOeR5yhDZrSZZOZhaVlNF/urgSnAq0zHG9zoVERFrQEp
         kbXWkdVByXzLD8aLC/s7Vox+cl8oFwMimTlK1Kui2YXAvBglRmcpMTtRRM0Mh1Bcsv+o
         AhPA23l1NdwahveKW0fZYE3K+H3Ta+tL28dwetpZ3E8sXV2ELYU2z4zbD/h8KhpKH1DD
         6gJtLpKnEXZIaDj+PKP/cME9GfjgHfzmNLwitvuU2iH686l0tjTLscdqM/fucEOoqrqy
         Trrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=f7BbdS5AMkoj7s+HNtl3QGBqiscDNb/dpwOy93R4ZSg=;
        b=ix6g5RUV1hKDE1pTPrLf4RA0s1hP7GDp5Hlqg2xy83pIPC3LIw+04VPIXFShDWRboE
         0ExRiIyqSVZfq5BTda7vyGossFuNXsNp1vaLq2fM/naFpIOOzzUxDcN9rXbTnla/8MA+
         ka6izryk8Ph+AyvX6f6M5Q5nnMvJ6GwyB2X8jX+UZEnYduarKqP6ZhXg4RRvkXRGICuU
         G6Gr9r9KxJPfeTik/iMmmkqw4OfJJQ5CYfW8aMy2G04Hprh/rQBhqXxGTXBnrEih8aAD
         t04lLhE3UPkCjAgbkvMQbSl/LpqsvqMCs1gNAuAnkDJ6jasNYVctIAkhogP9iybzIVO2
         E3Zw==
X-Gm-Message-State: ABuFfojUzT1Wdz64sdhdzq4ihSXFJ+/5SPFL58Q4c4lSbqI0hWsmsgV3
        ws8DDkfNo/bur+/OTlh5Aj0=
X-Google-Smtp-Source: ACcGV61BZ6yDDGPIEWozUU9jR93XeOh2VMC/Ywbje1Z9/K5TOQdVLksgcDISxx6fy+1gtaV6tQktNw==
X-Received: by 2002:a1c:88c6:: with SMTP id k189-v6mr1060967wmd.32.1538468920798;
        Tue, 02 Oct 2018 01:28:40 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id r13-v6sm10418251wmf.34.2018.10.02.01.28.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 01:28:40 -0700 (PDT)
Date:   Tue, 2 Oct 2018 10:28:37 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        stern@rowland.harvard.edu, parri.andrea@gmail.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: [PATCH memory-model 0/5] Updates to the formal memory model
Message-ID: <20181002082837.GB69893@gmail.com>
References: <20180926182845.GA24839@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926182845.GA24839@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul E. McKenney <paulmck@linux.ibm.com> wrote:

> Hello, Ingo!
> 
> This series contains updates to the Linux kernel's formal memory model
> in tools/memory-model, along with corresponding changes in documentation
> and Linux-kernel code.  These patches are ready for inclusion into -tip.
> 
> 1.	Document litmus-test naming scheme.
> 
> 2.	Add extra ordering for locks and remove it for ordinary
> 	release/acquire, courtesy of Alan Stern.
> 
> 3.	Fix a README typo, courtesy of SeongJae Park.
> 
> 4.	Expand the list of LKMM limitations.
> 
> 5.	Replace smp_cond_acquire() with smp_cond_load_acquire(),
> 	courtesy of Andrea Parri.
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
>  Documentation/memory-barriers.txt                                          |    3 
>  tools/memory-model/Documentation/explanation.txt                           |  186 +++++++---
>  tools/memory-model/Documentation/recipes.txt                               |    2 
>  tools/memory-model/README                                                  |   39 ++
>  tools/memory-model/linux-kernel.cat                                        |    8 
>  tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus |    7 
>  tools/memory-model/litmus-tests/README                                     |  104 +++++
>  7 files changed, 293 insertions(+), 56 deletions(-)

Applied to tip:locking/core, thanks Paul!

	Ingo
