Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C8AC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 22:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E57D5205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 22:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tcFHr0x2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E57D5205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbeJPGM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 02:12:29 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34454 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbeJPGM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 02:12:29 -0400
Received: by mail-pf1-f195.google.com with SMTP id f78-v6so4616664pfe.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 15:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=aA+y8iLkfp0PqXNnC0ftoRa9SP9ng4HKs19zN4KHz50=;
        b=tcFHr0x2H9I1vjAfKie2oYH5f93ZKGbhluptFrEsPoJm1K61P/wvwckDSB/67w4fyA
         nJwtaVm93EnJXqKI1zOYnFAPF3UwGNQAkB0b+Pl9WRcFDAK1kmCEzuY5+0y73e0G/lvQ
         Y892/zadSQuYy3ba4LU32Mbr2cZqDii89ULiCWAzPQUZMFHa53cgJesWYO2xwU6Nm/it
         sM3trvUbwugXski2I0qRbdxevWrGpGxSD2OlL/LIKK3LT+ACtmillno2RXzjsfxXG2NV
         ff3t4QmIpVI5WjnGb9VRTPknkSS4Bjl+/NLg8zTyameicCGudbnM7eSewy/sh16JE62q
         ZzZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=aA+y8iLkfp0PqXNnC0ftoRa9SP9ng4HKs19zN4KHz50=;
        b=TDw+zK4YVn2vglHgl1dXbjk9sWfOtnabqWZQ4tY9abJvdUwP/ox52syoRiFp4X3ewN
         0TiIRJrNj+xiJP7Rj/Kj65Do99fcGfz1jwLdiTnc/HePdN4UbGKk4uIn/g1xGvqyrnKf
         3RIjG2v0/ISj4tsEsC8Du+jfSED9AqcgaB+jjLRxD99OUp1qD2IRhUd0ueTDpos5KX8z
         wDjxurTAN6mKYKbPmDn5W13tF77ElRVigsiytrkEN8E0S5IBEu8OQ17G4LiGTqRxwzsd
         c76if8tXCNWqmEbwHugyOknB10VY+Bt+Z4+Q89rJWmA41lhU4YBIQX7I4aK8MVSjf9ci
         LktA==
X-Gm-Message-State: ABuFfoiN/3W9x7kwHxtFJUb6AaB9Dahb3JZJbLhDeIx+CgjnMlhMFRjX
        x+S5yRL2F6FSVz64vborIuAWlQ==
X-Google-Smtp-Source: ACcGV62esFFCRgboZxGkulLodhAkapVFn1UF8agTrmfqj1Ba3yrkf6s0RHMNLMfHhrJd/kxQA3PoEw==
X-Received: by 2002:a63:790e:: with SMTP id u14-v6mr17853642pgc.111.1539642316386;
        Mon, 15 Oct 2018 15:25:16 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id a11-v6sm12826812pgw.54.2018.10.15.15.25.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 15:25:15 -0700 (PDT)
Date:   Mon, 15 Oct 2018 15:25:14 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org
Subject: Re: [RFC PATCH] mm, proc: report PR_SET_THP_DISABLE in proc
In-Reply-To: <20181015150325.GN18839@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.1810151519250.247641@chino.kir.corp.google.com>
References: <20180926060624.GA18685@dhcp22.suse.cz> <20181002112851.GP18290@dhcp22.suse.cz> <alpine.DEB.2.21.1810021329260.87409@chino.kir.corp.google.com> <20181003073640.GF18290@dhcp22.suse.cz> <alpine.DEB.2.21.1810031547150.202532@chino.kir.corp.google.com>
 <20181004055842.GA22173@dhcp22.suse.cz> <alpine.DEB.2.21.1810040209130.113459@chino.kir.corp.google.com> <20181004094637.GG22173@dhcp22.suse.cz> <alpine.DEB.2.21.1810041130380.12951@chino.kir.corp.google.com> <20181009083326.GG8528@dhcp22.suse.cz>
 <20181015150325.GN18839@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Oct 2018, Michal Hocko wrote:

> > > No, because the offending commit actually changed the precedence itself: 
> > > PR_SET_THP_DISABLE used to be honored for future mappings and the commit 
> > > changed that for all current mappings.
> > 
> > Which is the actual and the full point of the fix as described in the
> > changelog. The original implementation was poor and inconsistent.
> > 
> > > So as a result of the commit 
> > > itself we would have had to change the documentation and userspace can't 
> > > be expected to keep up with yet a fourth variable: kernel version.  It 
> > > really needs to be simpler, just a per-mapping specifier.
> > 
> > As I've said, if you really need a per-vma granularity then make it a
> > dedicated line in the output with a clear semantic. Do not make VMA
> > flags even more confusing.
> 
> Can we settle with something please?

I don't understand the point of extending smaps with yet another line.  
The only way for a different process to determine if a single vma from 
another process is thp disabled is by the "nh" flag, so it is reasonable 
that userspace reads this.  My patch fixes that.  If smaps is extended 
with another line per your patch, it doesn't change the fact that previous 
binaries are built to check for "nh" so it does not deprecate that.  
("THP_Enabled" is also ambiguous since it only refers to prctl and not the 
default thp setting or madvise.)
