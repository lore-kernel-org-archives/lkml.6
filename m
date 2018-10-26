Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27ABECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 20:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A8C20856
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 20:03:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53A8C20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbeJ0Elh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 00:41:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51372 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725861AbeJ0Elh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 00:41:37 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E0E5680F96;
        Fri, 26 Oct 2018 20:03:15 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 28EA4183CF;
        Fri, 26 Oct 2018 20:03:11 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id w9QK3A85030069;
        Fri, 26 Oct 2018 16:03:10 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id w9QK3A1a030065;
        Fri, 26 Oct 2018 16:03:10 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Fri, 26 Oct 2018 16:03:10 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Paul Lawrence <paullawrence@google.com>
cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, linux-doc@vger.kernel.org,
        kernel-team@android.com, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        dm-devel@redhat.com, Shaohua Li <shli@kernel.org>
Subject: Re: [dm-devel] [RFC] dm-bow working prototype
In-Reply-To: <4a934593-1bd1-be5f-35c0-945c42762627@google.com>
Message-ID: <alpine.LRH.2.02.1810261558460.28906@file01.intranet.prod.int.rdu2.redhat.com>
References: <20181023212358.60292-1-paullawrence@google.com> <20181023221819.GB17552@agk-dp.fab.redhat.com> <296148c2-f2d9-5818-ea76-d71a0d6f5cd4@google.com> <alpine.LRH.2.02.1810241514310.4080@file01.intranet.prod.int.rdu2.redhat.com>
 <4a934593-1bd1-be5f-35c0-945c42762627@google.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 26 Oct 2018 20:03:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 25 Oct 2018, Paul Lawrence wrote:

> Thank you for the suggestion. I spent part of yesterday experimenting with
> this idea, and it is certainly very promising. However, it does have some
> disadvantages as compared to dm-bow, if I am understanding the setup
> correctly:
> 
> 1) Since dm-snap has no concept of the free space on the underlying file
> system any write into the free space will trigger a backup, so using twice the
> space of dm-bow. Changing existing data will create a backup with both
> drivers, but since we have to reserve the space for the backups up-front with
> dm-snap, we would likely only have half the space for that. Either way, it
> seems that dm-bow is likely to double the amount of changes we could make.
> 
> (Might it be possible to dynamically resize the backup file if it is mostly
> used up? This would fix the problem of only having half the space for changing

Yes - the snapshot store can be extended while the snapshot is active.

> existing data. The documentation seems to indicate that you can increase the
> size of the snapshot partition, and it seems like it should be possible to
> grow the underlying file without triggering a lot of writes. OTOH this would
> have to happen in userspace which creates other issues.)
> 
> 2) Similarly, since writes into free space do not trigger a backup in dm-bow,
> dm-bow is likely to have a lower performance overhead in many circumstances.
> On the flip side, dm-bow's backup is in free space and will collide with other
> writes, so this advantage will reduce as free space fills up. But by choosing
> a suitable algorithm for how we use free space we might be able to retain most
> of this advantage.
> 
> I intend to put together a fully working prototype of your suggestion next to
> better compare with dm-bow. But I do believe there is value in tracking free
> space and utilizing it in any such solution.

The snapshot target could be hacked so that it remembers space trimmed 
with REQ_OP_DISCARD and won't reallocate these blocks.

But I suspect that running discard over the whole device would degrade 
performance more than copying some unneeded data.

How much data do you intend to backup with this solution?

Mikulas
