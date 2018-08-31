Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84307C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 18:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A09B2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 18:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="OeAHd5e9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A09B2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbeHaWho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 18:37:44 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:41953 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbeHaWhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 18:37:43 -0400
Received: by mail-wr1-f42.google.com with SMTP id z96-v6so12041136wrb.8
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 11:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5RVh7IwAYc0JOpzOkafhgYi8+eZzOj2onbG9Prc6MlU=;
        b=OeAHd5e9XxJ/t7bIhiqcJkREkrgvBizB3NsDxChe7YtXHbKqrWEIYJUmcQK9vB0sp1
         wMKAWdtwbJd7GRYo89XpQnuA3YXE/9TaQZzXWpK2fv4MjosfNbbQlLEYKmSKNbH+7Lu5
         aV3obI8DzqZIM08rZ4KKhkmMzrv3xRyNXRwuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5RVh7IwAYc0JOpzOkafhgYi8+eZzOj2onbG9Prc6MlU=;
        b=ghszmpiwMNo3BO2YQvkmw050LZmcnEHgkDY2ODnTxC0N0d9z2HNAt/+YBYYbTTXO40
         Kw2F3Fz2KIcWOXHikvcr6kZVksXdApBmgOnogyJR8bk5ysLONJxkRhBV0TV+pjqyO0ju
         2nUdFQnJ24jjJu5RyETjuyMr05JROcUZuZahoLJMxZbzKLbyyj2TXazF6JLUOMrcLnoR
         p4scYj/a78ZUa6p9i1uiTqjP3QZbEVrJ4F1kV2ww7HFoaVSbhH0jp2lu3MB//HO5AQ7O
         +0FMylBD+1TKkMbYusdCdiDbnTti72ANoWbEX/z1vgdrH+RfLZSKKNNj3OR/wczjysEO
         3bBA==
X-Gm-Message-State: APzg51Bfni4jS1OszFb+qhuH8iVfcpd3GWTyaWb8pDsn4BS4KkvySutp
        HC+0vCCyaFZmJBWkdQtoGcVfag==
X-Google-Smtp-Source: ANB0Vdb0tH+QcXPGDJPto49gpuTZbwbJ6bIa6u6LBLeToJdboRjRs0mAQBIah3GQLI9Oh9/XEEiCnA==
X-Received: by 2002:adf:ae5a:: with SMTP id u26-v6mr3193527wrd.246.1535740139863;
        Fri, 31 Aug 2018 11:28:59 -0700 (PDT)
Received: from andrea ([94.230.152.15])
        by smtp.gmail.com with ESMTPSA id e14-v6sm7036706wrv.44.2018.08.31.11.28.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 11:28:59 -0700 (PDT)
Date:   Fri, 31 Aug 2018 20:28:46 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: [PATCH RFC LKMM 1/7] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
Message-ID: <20180831182845.GA4673@andrea>
References: <20180831091641.GA3634@andrea>
 <Pine.LNX.4.44L0.1808311042340.4901-100000@netrider.rowland.org>
 <20180831160640.GG30626@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831160640.GG30626@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Yes, it's true that implementing locks with atomic_cmpxchg_acquire 
> > should be correct on all existing architectures.  And Paul has invited 
> > a patch to modify the LKMM accordingly.  If you feel that such a change 
> > would be a useful enhancement to the LKMM's applicability, please write 
> > it.
> 
> Yes, please! That would be the "RmW" discussion which Andrea partially
> quoted earlier on, so getting that going independently from this patch
> sounds like a great idea to me.

That was indeed one of the proposal we discussed.  As you recalled, that
proposal only covered RmWs load-acquire (and ordinary store-release); in
particular, I realized that comments such as:

  "The atomic_cond_read_acquire() call above has provided the
   necessary acquire semantics required for locking."

   [from kernel/locking/qspinlock.c]

(for example)  would still _not have "generic validity" _if we added the
above po-unlock-rf-lock-po term... (which, again, makes me somehow uncon-
fortable);  Would to have _all_ the acquire be admissible for you?

  Andrea


> 
> Cheers,
> 
> Will
