Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D9DECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B26F21528
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:08:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B26F21528
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbeJQPCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 11:02:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:59734 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727257AbeJQPCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 11:02:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 909B9AD25;
        Wed, 17 Oct 2018 07:08:26 +0000 (UTC)
Date:   Wed, 17 Oct 2018 09:08:25 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Argangeli <andrea@kernel.org>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Stable tree <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: thp:  relax __GFP_THISNODE for MADV_HUGEPAGE
 mappings
Message-ID: <20181017070825.GD18839@dhcp22.suse.cz>
References: <20181009130034.GD6931@suse.de>
 <20181009142510.GU8528@dhcp22.suse.cz>
 <20181009230352.GE9307@redhat.com>
 <alpine.DEB.2.21.1810101410530.53455@chino.kir.corp.google.com>
 <alpine.DEB.2.21.1810151525460.247641@chino.kir.corp.google.com>
 <20181015154459.e870c30df5c41966ffb4aed8@linux-foundation.org>
 <20181016074606.GH6931@suse.de>
 <20181016153715.b40478ff2eebe8d6cf1aead5@linux-foundation.org>
 <20181016231149.GJ30832@redhat.com>
 <20181016161643.9c16164889b4d99d6eff6763@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016161643.9c16164889b4d99d6eff6763@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 16-10-18 16:16:43, Andrew Morton wrote:
> On Tue, 16 Oct 2018 19:11:49 -0400 Andrea Arcangeli <aarcange@redhat.com> wrote:
> 
> > This was a severe regression
> > compared to previous kernels that made important workloads unusable
> > and it starts when __GFP_THISNODE was added to THP allocations under
> > MADV_HUGEPAGE. It is not a significant risk to go to the previous
> > behavior before __GFP_THISNODE was added, it worked like that for
> > years.@s1@s2@s1
> 
> 5265047ac301 ("mm, thp: really limit transparent hugepage allocation to
> local node") was April 2015.  That's a long time for a "severe
> regression" to go unnoticed?

Well, it gets some time to adopt changes in enterprise and we start
seeing people reporting this issue. That is why I believe we should
start with something really simple and stable tree backportable first
and then build something more complex on top.
-- 
Michal Hocko
SUSE Labs
