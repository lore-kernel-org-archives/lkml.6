Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E53EC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 21:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32E5420671
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 21:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UGZRVLIx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32E5420671
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbeIZDy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 23:54:57 -0400
Received: from mail-pg1-f177.google.com ([209.85.215.177]:43136 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbeIZDy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 23:54:56 -0400
Received: by mail-pg1-f177.google.com with SMTP id q19-v6so11646345pgn.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 14:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ciiUMi44kIfOLR99BwPzex6sw5E4qxgsdUklbFEs6IU=;
        b=UGZRVLIxgO/Ce8D36FEPK4vnrVhPhDx7wjT0twwdWQX9LVZvlZWvGAmeq3GrI0/CDN
         OmkL2lCkRtS9DV+ghBHNlV7ng1DscBqul86qhuj2iGQ/5PKKGj37tCUD+qqj+e3IlOHp
         DN9pqrgT5MhjNutMlpmyv6nIGuk3KeWLTTrSw8pn+WoRBbHCLoq5o8gwFsYO+jWByIbY
         KdwFDrONwGPu/jmMbN51twb/zNDB7RHsI61jnIccT79jezygIA/UDyDQsurP8iS+/ig7
         G9siSDPFajUKZ1AfY6Zgw9MFN+oDs6A8bfNK1aGbFGGNq5xU3FdUMGkZhGT0kfOnoEP2
         mIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ciiUMi44kIfOLR99BwPzex6sw5E4qxgsdUklbFEs6IU=;
        b=Yyq7VPFNQaGIfSCc0HedeHV8uKM9Mg6RYCxatwhKEtAnsTVVK1k4blot91KpG3VCEK
         bZkyTzv8w/nQPy6bCHHM1wcTP4LEBBPSGTIv2C/u18+r7HAwzSbHNhi0R5By0zoqkWnc
         zusnM9Lg/VQQbnOTQMxyusSSYDu5Vy1CXBgmA/yVnKyIDVO0+4fd0dVv2CAbqQWP+Y9b
         D/UNekWzg+Fp11xVSthoIZlb8GqwW50F8izm/7GuNDZp9I8+icfjFjnyTPDqX/H5Wew/
         knfINSGXCjlSJVjSGfJFqTofQnjoABa94J9jba3kkXD0QdV/RrZSGxTxWZy0WmPzLZpL
         FAFQ==
X-Gm-Message-State: ABuFfohjBdsiXZcmBV4olgModCwobiFAlrqZogIe+gzZTSUGQig6zzTH
        qVs8FfGCWTcMK8n/2D9sgBwZKg==
X-Google-Smtp-Source: ACcGV62aMTzhQDFIQ7Wp/2PNGELcG8bIc49qu0BzkrFMDmv6eFXvg8dJPCcnH48U6bD8GopRELtvgg==
X-Received: by 2002:a63:595:: with SMTP id 143-v6mr2831541pgf.244.1537911921115;
        Tue, 25 Sep 2018 14:45:21 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id c2-v6sm4810135pfo.107.2018.09.25.14.45.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 14:45:20 -0700 (PDT)
Date:   Tue, 25 Sep 2018 14:45:19 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org
Subject: Re: [patch v2] mm, thp: always specify ineligible vmas as nh in
 smaps
In-Reply-To: <20180925202959.GY18685@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.1809251440001.94921@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1809241054050.224429@chino.kir.corp.google.com> <e2f159f3-5373-dda4-5904-ed24d029de3c@suse.cz> <alpine.DEB.2.21.1809241215170.239142@chino.kir.corp.google.com> <alpine.DEB.2.21.1809241227370.241621@chino.kir.corp.google.com>
 <20180924195603.GJ18685@dhcp22.suse.cz> <20180924200258.GK18685@dhcp22.suse.cz> <0aa3eb55-82c0-eba3-b12c-2ba22e052a8e@suse.cz> <alpine.DEB.2.21.1809251248450.50347@chino.kir.corp.google.com> <20180925202959.GY18685@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Sep 2018, Michal Hocko wrote:

> > This is used to identify heap mappings that should be able to fault thp 
> > but do not, and they normally point to a low-on-memory or fragmentation 
> > issue.  After commit 1860033237d4, our users of PR_SET_THP_DISABLE no 
> > longer show "nh" for their heap mappings so they get reported as having a 
> > low thp ratio when in reality it is disabled.  
> 
> I am still not sure I understand the issue completely. How are PR_SET_THP_DISABLE
> users any different from the global THP disabled case? Is this only
> about the scope? E.g the one who checks for the state cannot check the
> PR_SET_THP_DISABLE state? Besides that what are consequences of the
> low ratio? Is this an example of somebody using the prctl and still
> complaining or an external observer trying to do something useful which
> ends up doing contrary?
> 

Yes, that is how I found out about this.  The system-wide policy can be 
determined from /sys/kernel/mm/transparent_hugepage/enabled.  If it is 
"always" and heap mappings are not being backed by hugepages and lack the 
"nh" flag, it was considered as a likely fragmentation issue before commit 
1860033237d4.  After commit 1860033237d4, the heap mapping for 
PR_SET_THP_DISABLE users was not showing it actually is prevented from 
faulting thp because of policy, not because of fragmentation.

> > It is also used in 
> > automated testing to ensure that vmas get disabled for thp appropriately 
> > and we used "nh" since that is how PR_SET_THP_DISABLE previously enforced 
> > this, and those tests now break.
> 
> This sounds like a bit of an abuse to me. It shows how an internal
> implementation detail leaks out to the userspace which is something we
> should try to avoid.
> 

Well, it's already how this has worked for years before commit 
1860033237d4 broke it.  Changing the implementation in the kernel is fine 
as long as you don't break userspace who relies on what is exported to it 
and is the only way to determine if MADV_NOHUGEPAGE is preventing it from 
being backed by hugepages.

> > I'll reword this to explicitly state that "hg" and "nh" mappings either 
> > allow or disallow thp backing.
> 
> How are you going to distinguish a regular THP-able mapping then? I am
> still not sure how this is supposed to work. Could you be more specific.

You look for "[heap]" in smaps to determine where the heap mapping is.
