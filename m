Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10258C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 08:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA58D214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 08:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SMZ+Eb/Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA58D214FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbeJJQFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 12:05:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49304 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbeJJQFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 12:05:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Vk562HwpN6073DhKe/aQen9rxT2/LXMJnfWRg8ItKMI=; b=SMZ+Eb/ZcH7SqlDmq5V8/DSn/
        idBvgjfBPyydzr87I7sgA5yTxC02BA4AQXorstZeCnqPWDWyr0EuT914+Wb2LGAhARHsOpm5ydkBv
        iJ0FZKJHIHfWastVU6aji37R6pWVOtEVStLvGqZKaQkvUIEsjcyQQwb2t/RIEx2vkdyMD9xp4eB/Q
        pDZdRV4K9C45lNTeQ6twJFJq+4Se+59h1Nr9YqH9Cxil2Hrvek9xMVojATxg/6o2T+AvMZfwMzK7A
        84AZg0J4r9OSzESHNLMs/lL21AZ5OUBbTy/Bk09I1mXq1EcLGPFKFpxTJIE8MDSxg7936rpxTQait
        C/7N7DWzA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gAA5h-0006am-QJ; Wed, 10 Oct 2018 08:43:37 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D3AEF20298569; Wed, 10 Oct 2018 10:43:35 +0200 (CEST)
Date:   Wed, 10 Oct 2018 10:43:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Cc:     target-devel <target-devel@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mike Christie <mchristi@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 2/2] target: Fix target_wait_for_sess_cmds breakage with
 active signals
Message-ID: <20181010084335.GN5728@hirez.programming.kicks-ass.net>
References: <1539141790-13557-1-git-send-email-nab@linux-iscsi.org>
 <1539141790-13557-3-git-send-email-nab@linux-iscsi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539141790-13557-3-git-send-email-nab@linux-iscsi.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 03:23:10AM +0000, Nicholas A. Bellinger wrote:
> From: Nicholas Bellinger <nab@linux-iscsi.org>
> 
> With the addition of commit 00d909a107 in v4.19-rc, it incorrectly assumes no
> signals will be pending for task_struct executing the normal session shutdown
> and I/O quiesce code-path.
> 
> For example, iscsi-target and iser-target issue SIGINT to all kthreads as
> part of session shutdown.  This has been the behaviour since day one.

Not knowing much context here; but does it make sense for those
kthreads to handle signals, ever? Most kthreads should be fine with
ignore_signals().

