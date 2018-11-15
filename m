Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B21C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 23:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C0872133D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 23:15:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C0872133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbeKPJZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 04:25:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34922 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbeKPJZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 04:25:34 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 17F9630832CF;
        Thu, 15 Nov 2018 23:15:42 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3B052611BF;
        Thu, 15 Nov 2018 23:15:35 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id wAFNFYxa027298;
        Thu, 15 Nov 2018 18:15:34 -0500
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id wAFNFY4e027294;
        Thu, 15 Nov 2018 18:15:34 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Thu, 15 Nov 2018 18:15:34 -0500 (EST)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Paul Lawrence <paullawrence@google.com>
cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, linux-doc@vger.kernel.org,
        kernel-team@android.com, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        Shaohua Li <shli@kernel.org>
Subject: Re: [dm-devel] [RFC] dm-bow working prototype
In-Reply-To: <fba91b2e-4b2e-8daf-ff64-a12c9139cada@google.com>
Message-ID: <alpine.LRH.2.02.1811151809380.25860@file01.intranet.prod.int.rdu2.redhat.com>
References: <20181023212358.60292-1-paullawrence@google.com> <20181023221819.GB17552@agk-dp.fab.redhat.com> <296148c2-f2d9-5818-ea76-d71a0d6f5cd4@google.com> <alpine.LRH.2.02.1810241514310.4080@file01.intranet.prod.int.rdu2.redhat.com>
 <4a934593-1bd1-be5f-35c0-945c42762627@google.com> <alpine.LRH.2.02.1810261558460.28906@file01.intranet.prod.int.rdu2.redhat.com> <fba91b2e-4b2e-8daf-ff64-a12c9139cada@google.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 15 Nov 2018 23:15:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 29 Oct 2018, Paul Lawrence wrote:

> 
> > The snapshot target could be hacked so that it remembers space trimmed
> > with REQ_OP_DISCARD and won't reallocate these blocks.
> > 
> > But I suspect that running discard over the whole device would degrade
> > performance more than copying some unneeded data.
> > 
> > How much data do you intend to backup with this solution?
> > 
> > 
> We are space-constrained - we will have to free up space for the backup before
> we apply the update, so we have to predict the size and keeping usage as low
> as possible is thus very important.
> 
> Also, we've discussed the resizing requirement of the dm-snap solution and
> that part is not attractive at all - it seems it would be impossible to
> guarantee that the resizing happens in a timely fashion during the (very busy)
> update cycle.
> 
> Thanks everyone for the insights, especially into how dm-snap works, which I
> hadn't fully appreciated. At the moment, and for the above reasons, we intend
> to continue with the dm-bow solution, but do want to keep this discussion
> open. If anyone is going to be at Linux Plumbers, I'll be presenting this work
> and would love to chat about it more.

dm-snapshot took 9 years to fix the last data corruption bug (2004-2013 - 
the commit e9c6a182649f4259db704ae15a91ac820e63b0ca).

And with the new target duplicating the snapshot functionality, it may be 
the same.

Mikulas
