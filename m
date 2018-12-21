Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F67C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 22:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D422021920
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 22:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SnuvSJOm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403791AbeLUWSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 17:18:48 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37072 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730887AbeLUWSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 17:18:48 -0500
Received: by mail-pf1-f195.google.com with SMTP id y126so3195188pfb.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 14:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=U40y65+ZH6O/HTrNcmmelQb4memE4GhHq1SvommW0g0=;
        b=SnuvSJOme33VXVLmAj3KwMQJ7rP5EsHTXSb7w4ruUQUjCGctfS77aW4uuud4/v5TTz
         HTXZYPMfupfCJ2oezP06V++DM1O3lwwL3HlKSBPwMB3wFA4S5KbpF5A4uX9pe9tzOFzg
         /kUQ8rUJ0zda/5Qj8DY2RtgTTQX2ARcGCSLPhPVCEq+Oo30pFp+yOj4kRwkLTZ5FLf02
         kK6N3FNUnoAJm36zF6OTdD2YShYOK/QeXsP6Xme9zHI+eFtiIrmHXrZk/YfeXJ4JO9ok
         swn8q7xm56TU6iTXeaPvEb0fzU2gENE3uLch1uZ2VcDd6UaVwpYPAM4dYB+r07k0MUQ0
         dFVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=U40y65+ZH6O/HTrNcmmelQb4memE4GhHq1SvommW0g0=;
        b=J87FaHULCMbxIeTXPTvDdJwN98ebPwZYDseLrSBth+mm9HRkMHTE2JQzeqxAG5Drwp
         5gfYAIBli+hZZu2KwLqG2jUWecKs651Mdiq9cR+YfArlinPxFm0d+XmYkvGZ91IOIW6t
         WqKMClq+t+gNum9B9DEOXA/lOru6tuC3S4uMJeBvVMfnQyDwBrpq3oefc8v6Zcr4RSpw
         Qp6ETHUohAMAi/Cfpg6TGd++d1hyvGkyVUzSFokj78fMXFB0XPAKh+2FBuD2v1KnmtiK
         WxgdSHx7ukEfd188Nm9Vjg9GqaZFFiEsa1ME+yEl05uxYFrqS5rNY8fm4KPMqAziSAux
         NasA==
X-Gm-Message-State: AA+aEWbyLwC4VALzJtaWSZIRq5MWYbDja3yvBdgXTbIvI4FnnDIfx876
        RtpE6emu78uTJ3M/e7f3PX4M5w==
X-Google-Smtp-Source: AFSGD/UnrwAoCASh7zIOvgMh0kR5aJPKSAJ5y04tNiAjSj9X0kItaQH4nIMGPxe4Zysuq8T9DEZjvw==
X-Received: by 2002:a62:509b:: with SMTP id g27mr4360329pfj.48.1545430727243;
        Fri, 21 Dec 2018 14:18:47 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id r76sm37856735pfb.69.2018.12.21.14.18.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 14:18:46 -0800 (PST)
Date:   Fri, 21 Dec 2018 14:18:45 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        mgorman@techsingularity.net, Michal Hocko <mhocko@kernel.org>,
        ying.huang@intel.com, s.priebe@profihost.ag,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu, Linux-MM layout <linux-mm@kvack.org>
Subject: Re: [LKP] [mm] ac5b2c1891: vm-scalability.throughput -61.3%
 regression
In-Reply-To: <0700f5c3-66a8-338a-0ba0-2231cc3bb637@suse.cz>
Message-ID: <alpine.DEB.2.21.1812211416020.219499@chino.kir.corp.google.com>
References: <64a4aec6-3275-a716-8345-f021f6186d9b@suse.cz> <20181204104558.GV23260@techsingularity.net> <20181205204034.GB11899@redhat.com> <CAHk-=whi8Ju-cTDL4cYtwuLA7BYgGJYyy6HVMoknZaLHnRc83g@mail.gmail.com> <20181205233632.GE11899@redhat.com>
 <CAHk-=wguXjkbK8BUU998s7HD7AXJgBkuc9JmuNxiN7uGQyfSfQ@mail.gmail.com> <CAHk-=wjm9V843eg0uesMrxKnCCq7UfWn8VJ+z-cNztb_0fVW6A@mail.gmail.com> <alpine.DEB.2.21.1812061505010.162675@chino.kir.corp.google.com> <CAHk-=wjVuLjZ1Wr52W=hNqh=_8gbzuKA+YpsVb4NBHCJsE6cyA@mail.gmail.com>
 <alpine.DEB.2.21.1812091538310.215735@chino.kir.corp.google.com> <20181210044916.GC24097@redhat.com> <alpine.DEB.2.21.1812111609060.255489@chino.kir.corp.google.com> <0bbf4202-6187-28fb-37b7-da6885b89cce@suse.cz> <alpine.DEB.2.21.1812141244450.186427@chino.kir.corp.google.com>
 <0700f5c3-66a8-338a-0ba0-2231cc3bb637@suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Dec 2018, Vlastimil Babka wrote:

> > It would be interesting to know if anybody has tried using the per-zone 
> > free_area's to determine migration targets and set a bit if it should be 
> > considered a migration source or a migration target.  If all pages for a 
> > pageblock are not on free_areas, they are fully used.
> 
> Repurposing/adding a new pageblock bit was in my mind to help multiple
> compactors not undo each other's work in the scheme where there's no
> free page scanner, but I didn't implement it yet.
> 

It looks like Mel has a series posted that still is implemented with 
linear scans through memory, so I'm happy to move the discussion there; I 
think the goal for compaction with regard to this thread is determining 
whether reclaim in the page allocator would actually be useful and 
targeted reclaim to make memory available for isolate_freepages() could be 
expensive.  I'd hope that we could move in a direction where compaction 
doesn't care where the pageblock is and does the minimal amount of work 
possible to make a high-order page available, not sure if that's possible 
with a linear scan.  I'll take a look at Mel's series though.
