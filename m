Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AEAC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35883207DD
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mAltxJwX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35883207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbeJWFFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 01:05:23 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33201 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbeJWFFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 01:05:23 -0400
Received: by mail-pf1-f196.google.com with SMTP id 78-v6so18118528pfq.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 13:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=msqS4RKF1mEugZL5tume/ycelvRiVwR7DkoKhlUMkwo=;
        b=mAltxJwXlKWU/VsjWWGkjp5EYBzH72taQx3NhcQoxPsY3cHYNX8pnMoSkzAd4f91w0
         uyIzhbF0/OEt1Vc3L6B+nvJVRj3mukc6cM2z3eXEK5EaoJqmq4EKEbL7RlMwFimtG1Ko
         MFljBwdObpNfKP5k716Zcr4WhSdBtBsXHeOSYxY6BpUnIk7TcrrXwWb39TweRPgTiIYq
         1QT6uIrWfhLFOiOaw/80UwH2hZI7mbxxylVqC5juAUSb2Rpi7PIUMKZl+g8+j5D3/4ZA
         tTJwaleyVL+8R5csiQxS9H3ayoczYEMs+ycCzYdu3ZCaKJ740B+2udvRtOZDx7XMp4HT
         FVQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=msqS4RKF1mEugZL5tume/ycelvRiVwR7DkoKhlUMkwo=;
        b=VrhtbeA/PCntzb6FCLLsMM90M2wfWSCxIIobxbfstO6aFYOfGEV2wWzeiVaVl5Pphr
         AULBscKz92nTYMwFNWvjLw99SndmL/gztZ+JO0p2ssRd1ppkF5FOd1jJmseSdYooz9s1
         wySfpEjwyaDxJSD5YKIFY4gMCfaaAlJUn7ipjinYbE7lvMSg5nKZ55oFthBrDD++AU06
         nkwqMsDd79b9Ne39ZSdH/3QlOHWXt8A1RgmbNkzAh+0KKPqGZkvJRVt7Zssfnuu7JDzE
         M3RfK1VTtrZDmUroQCDgXHjqh4VPitC00kF24YhNKh2iPbvqpYrWUL+xLx65288RT9CL
         3NzA==
X-Gm-Message-State: AGRZ1gL+8+J4SJ10k63TA9s2jtj2iZgx9aY/nyV3t53eKiLRnIa3jMQy
        gpJjlF2/EvmRL+BUZHXNY1YCXA==
X-Google-Smtp-Source: AJdET5fdArkNvFo6xqJUVYsdj4PoKSJ8Gl4i5nAApOhsXznz7BeQrFSTOgVH1GCJHw8mLnMFdVzb9A==
X-Received: by 2002:a63:3f44:: with SMTP id m65mr4898315pga.115.1540241118321;
        Mon, 22 Oct 2018 13:45:18 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id r73-v6sm51487507pfk.157.2018.10.22.13.45.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 13:45:16 -0700 (PDT)
Date:   Mon, 22 Oct 2018 13:45:15 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Andrea Arcangeli <aarcange@redhat.com>
cc:     Michal Hocko <mhocko@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Argangeli <andrea@kernel.org>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Stable tree <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: thp:  relax __GFP_THISNODE for MADV_HUGEPAGE
 mappings
In-Reply-To: <20181015225743.GB30832@redhat.com>
Message-ID: <alpine.DEB.2.21.1810221337270.120157@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1810051320270.202739@chino.kir.corp.google.com> <20181005232155.GA2298@redhat.com> <alpine.DEB.2.21.1810081303060.221006@chino.kir.corp.google.com> <20181009094825.GC6931@suse.de> <20181009122745.GN8528@dhcp22.suse.cz>
 <20181009130034.GD6931@suse.de> <20181009142510.GU8528@dhcp22.suse.cz> <20181009230352.GE9307@redhat.com> <alpine.DEB.2.21.1810101410530.53455@chino.kir.corp.google.com> <alpine.DEB.2.21.1810151525460.247641@chino.kir.corp.google.com>
 <20181015225743.GB30832@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Oct 2018, Andrea Arcangeli wrote:

> > At the risk of beating a dead horse that has already been beaten, what are 
> > the plans for this patch when the merge window opens?  It would be rather 
> > unfortunate for us to start incurring a 14% increase in access latency and 
> > 40% increase in fault latency.  Would it be possible to test with my 
> > patch[*] that does not try reclaim to address the thrashing issue?  If 
> > that is satisfactory, I don't have a strong preference if it is done with 
> > a hardcoded pageblock_order and __GFP_NORETRY check or a new 
> > __GFP_COMPACT_ONLY flag.
> 
> I don't like the pageblock size hardcoding inside the page
> allocator. __GFP_COMPACT_ONLY is fully runtime equivalent, but it at
> least let the caller choose the behavior, so it looks more flexible.
> 

I'm not sure that I understand why the user would ever want to thrash 
their zone(s) for allocations of this order.  The problem here is 
specifically related to an entire pageblock becoming freeable and the 
unlikeliness that reclaiming/swapping/thrashing will assist memory 
compaction in making that happen.  For this reason, I think the 
order >= pageblock_order check is reasonable because it depends on the 
implementation of memory compaction.

Why do we need another gfp flag for thp allocations when they are made to 
be __GFP_NORETRY by default and it is very unlikely that reclaiming once 
and then retrying compaction is going to make an entire pageblock free?

I'd like to know (1) how continuous reclaim activity can make entire 
pageblocks freeable without thrashing and (2) the metrics that we can use 
to determine when it is worthwhile vs harmful.  I don't believe (1) is 
ever helpful based on the implementation of memory compaction and we lack 
(2) since reclaim is not targeted to memory that compaction can use.

> As long as compaction returns COMPACT_SKIPPED it's ok to keep doing
> reclaim and keep doing compaction, as long as compaction succeeds.
> 

Compaction will operate on 32 pages at a time and declare success each 
time and then pick up where it left off the next time it is called in the 
hope that it "succeeds" 512/32=16 times in a row while constantly 
reclaiming memory.  Even a single slab page in that pageblock will make 
all of this work useless.  Reclaimed memory not accessible by the freeing 
scanner will make its work useless.  We lack the ability to determine when 
compaction is successful in freeing a full pageblock.
