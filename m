Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 095E4C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 22:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A64CE208CD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 22:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GZ/rn4y7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A64CE208CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754591AbeFMWCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 18:02:25 -0400
Received: from casper.infradead.org ([85.118.1.10]:52334 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754526AbeFMWCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 18:02:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jT5Y1CEEGwtwJJvhXEbqLmi76nFK7XHPkBaGI7eDEWc=; b=GZ/rn4y71ObLdsjtSDdn+NQ0Z
        B72HP1vkCmrWDLhEQTKRdOkvRzR3xr6gFdPAM+RXjNvhQLRiM5+HIfufE7GCmSXdlySV0D6azqnIC
        VyW+6+/poEvWDNgDcS8s8okbFjo71C2breRX01xK6MhpD4iIg75G3jL9RNfFKTphmmL4dA/pgH/Jy
        EqFW3vEB+t9wdC89UufLfIQmp2F6Z2R3z/aqNaJsPW2loTMfO8DsNPzEopTw1wqF5GsSO0Vv0DF7G
        JniXpNT5ZvYI6C7P6asrlU3R5xutob5CaAqB0/JU0He/4dT9Txreu/9nE/LR/1y5XHNx48pLwYYK5
        cF5QShxBw==;
Received: from jsimmons (helo=localhost)
        by casper.infradead.org with local-esmtp (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fTDqK-0004L6-DL; Wed, 13 Jun 2018 22:02:18 +0000
Date:   Wed, 13 Jun 2018 23:02:16 +0100 (BST)
From:   James Simmons <jsimmons@infradead.org>
To:     NeilBrown <neilb@suse.com>
cc:     Andreas Dilger <andreas.dilger@intel.com>,
        Oleg Drokin <oleg.drokin@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lustre Development List <lustre-devel@lists.lustre.org>,
        Doug Oucharek <dougso@me.com>,
        Amir Shehata <amir.shehata@intel.com>
Subject: Re: [PATCH v2 01/25] staging: lustre: libcfs: restore UMP handling
In-Reply-To: <87muwiuiuz.fsf@notabene.neil.brown.name>
Message-ID: <alpine.LFD.2.21.1806132248500.12664@casper.infradead.org>
References: <1527603725-30560-1-git-send-email-jsimmons@infradead.org> <1527603725-30560-2-git-send-email-jsimmons@infradead.org> <87muwiuiuz.fsf@notabene.neil.brown.name>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20180613_230216_465301_AF0E0686 
X-CRM114-Status: GOOD (  17.92  )
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> > With the cleanup of the libcfs SMP handling all UMP handling
> > was removed. In the process now various NULL pointers and
> > empty fields are return in the UMP case which causes lustre
> > to crash hard. Restore the proper UMP handling so Lustre can
> > properly function.
> 
> Can't we just get lustre to handle the NULL pointer?
> Is most cases, the pointer is accessed through an accessor function, and
> on !CONFIG_SMP, that can be a static inline that doesn't even look at
> the pointer.

Lots of NULL pointer checks for a structure allocated at libcfs module 
start and only cleaned up at libcfs removal is not a clean approach.
So I have thought about it and I have to ask why allocate a global
struct cfs_cpu_table. It could be made static and fill it in which would
avoid the whole NULL pointer issue. Plus for the UMP case why allocate
a new cfs_cpu_table with cfs_cpt_table_alloc() which is exactly like
the default UMP cfs_cpu_table. Instead we could just return the pointer
to the static default cfs_cpt_tab every time. We still have the NULL
ctb_cpumask field to deal with. Does that sound like a better solution
to you? Doug what do you think?
 
> I really think this is a step backwards.  If you can identify specific
> problems caused by the current code, I'm sure we can fix them.
> 
> >
> > Signed-off-by: James Simmons <uja.ornl@yahoo.com>
> > Signed-off-by: Amir Shehata <amir.shehata@intel.com>
> > Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-7734
> 
> This bug doesn't seem to mention this patch at all
> 
> > Reviewed-on: http://review.whamcloud.com/18916
> 
> Nor does this review.

Yeah its mutated so much from what is in the Intel tree.
I do believe it was the last patch to touch this.
