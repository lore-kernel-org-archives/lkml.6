Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F884ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 21:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D059720661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 21:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vMzrjkWn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D059720661
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbeGTVzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 17:55:54 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40892 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728064AbeGTVzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 17:55:54 -0400
Received: by mail-pg1-f194.google.com with SMTP id x5-v6so7808036pgp.7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 14:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=WscAVpu58+ou8ZOorAhxC0hNnnYoLr5A61YjmVp/rkk=;
        b=vMzrjkWnC5N7KrNSvMWGl47F8yyDyTFRu9iYBbCsNrB1KbdJMfj9GwA8zxodiM8tQq
         6JomXilJP8QxLHaUh5Sv5PHgTcbtS9uOka4yegW53tje/SR1OxATRjR1kcYVloEjqR98
         42hEj0UYVhjbog44Z5oz2ohBh9sw3kCoxIJUYQhJv7fhT8LImko2ye9ExK+lB+X0P7XN
         RvJhkWoLvb05B1hpQkb8GZFzKpBo6p9Q3mBDs4yMalVsTknYH6isdpEYcGGRuWKH6heG
         hwTJDKsR7VeiP9sAGSYmIoawv2nfjSkG31RjyvpQNTyS6YXDDRewg5INV2EAvXsUcZbE
         E7bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=WscAVpu58+ou8ZOorAhxC0hNnnYoLr5A61YjmVp/rkk=;
        b=fEfzM4ZD6mlnLwhM8ziL87pWnngyrPrU7x7tj+c06/kSyKjoWDrSpj7ipeuIfuPEzW
         HllHUR+/Va44Vp2oPTG/Rpj0cQKFyZ2r+qY0HStnL3PBUR/olzqClUebJ3XLKM6s3jh4
         +hWhC+uS+kAzdtMY4FFf3v2g4KR6idNChLFg92gbNurAWyna0jBagle8SUjbuCZtv29Q
         cp2h1nf7kddcJqdXsikhglzaAUFqjcRFjMNd2n5mfdTtee6KegW7pbZmTUtGcjiN+VUc
         2Zc5hNtgAsMTNnes7XZiNxUW7dJ/htB9QI0PxjDem9uEqWsCjpIdpC+EpOewpUKsWxso
         QhIg==
X-Gm-Message-State: AOUpUlGPQhDf5yMpDvrqSdy+Nmselm9ugXtjIng4iL8IbdvcDCmXiHVg
        6qW7TgFNrg/Rh51a80upsTg2uQ==
X-Google-Smtp-Source: AAOMgpfdhlwPNVaTX6TcVezlN1inpfdGwiuM271soKfRYIjWYE5veLtyJHB+UMDLrxmWczh9bCJz4w==
X-Received: by 2002:a62:fc5:: with SMTP id 66-v6mr3660161pfp.237.1532120753307;
        Fri, 20 Jul 2018 14:05:53 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id m26-v6sm4046089pfg.61.2018.07.20.14.05.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 14:05:52 -0700 (PDT)
Date:   Fri, 20 Jul 2018 14:05:52 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Yang Shi <yang.shi@linux.alibaba.com>
cc:     Andrew Morton <akpm@linux-foundation.org>, kirill@shutemov.name,
        hughd@google.com, aaron.lu@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: thp: remove use_zero_page sysfs knob
In-Reply-To: <3238b5d2-fd89-a6be-0382-027a24a4d3ad@linux.alibaba.com>
Message-ID: <alpine.DEB.2.21.1807201401390.231119@chino.kir.corp.google.com>
References: <1532110430-115278-1-git-send-email-yang.shi@linux.alibaba.com> <20180720123243.6dfc95ba061cd06e05c0262e@linux-foundation.org> <alpine.DEB.2.21.1807201300290.224013@chino.kir.corp.google.com>
 <3238b5d2-fd89-a6be-0382-027a24a4d3ad@linux.alibaba.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jul 2018, Yang Shi wrote:

> > We disable the huge zero page through this interface, there were issues
> > related to the huge zero page shrinker (probably best to never free a
> > per-node huge zero page after allocated) and CVE-2017-1000405 for huge
> > dirty COW.
> 
> Thanks for the information. It looks the CVE has been resolved by commit
> a8f97366452ed491d13cf1e44241bc0b5740b1f0 ("mm, thp: Do not make page table
> dirty unconditionally in touch_p[mu]d()"), which is in 4.15 already.
> 

For users who run kernels earlier than 4.15 they may choose to mitigate 
the CVE by using this tunable.  It's not something we permanently need to 
have, but it may likely be too early.

> What was the shrinker related issue? I'm supposed it has been resolved, right?
> 

The huge zero page can be reclaimed under memory pressure and, if it is, 
it is attempted to be allocted again with gfp flags that attempt memory 
compaction that can become expensive.  If we are constantly under memory 
pressure, it gets freed and reallocated millions of times always trying to 
compact memory both directly and by kicking kcompactd in the background.

It likely should also be per node.
