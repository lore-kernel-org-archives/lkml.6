Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC53DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 08:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9944621502
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 08:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="honMeLma"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9944621502
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbeJJPxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 11:53:16 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57648 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbeJJPxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 11:53:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tep/GRtaPsB6kCE8rAZm1ALimaWPMOS6VQXfKLAFJ18=; b=honMeLma1eJ+UEFlVCySIE1nG
        tHxlzbGvySQf6n9EmKKnIB5Qi5rOoc4StT2Qx4EKGKsWnpDlzHVhf9WC6c9fCOlzjQ85OtQvukN2E
        c7nE6SvgZtC1/cAsqu79Xu7msFL8QzNhiI5jHapYLcO+WIgz0d/A/vtmoUkudeOFw4cV/+Sko5bKu
        6gBSSkp0SHPT2m/Lzw2K2ea1dTcPQUgUivTPxirmiMXDndihq3DviBWStssKdgEDmKaxb4SuOlXbP
        Tpa+Pak9Sc03fZWPnm9UuoaDSs4iE6GwZyIyBaaF892IAW6jfoVqPBfnTi+ZFkznj5qwkL8tuB1E4
        7pbDx/HMQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gA9tx-0003zh-Ee; Wed, 10 Oct 2018 08:31:29 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7B3522029856A; Wed, 10 Oct 2018 10:31:27 +0200 (CEST)
Date:   Wed, 10 Oct 2018 10:31:27 +0200
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
Subject: Re: [PATCH 1/2] sched/wait: Add wait_event_lock_irq_timeout for
 TASK_UNINTERRUPTIBLE usage
Message-ID: <20181010083127.GL5728@hirez.programming.kicks-ass.net>
References: <1539141790-13557-1-git-send-email-nab@linux-iscsi.org>
 <1539141790-13557-2-git-send-email-nab@linux-iscsi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539141790-13557-2-git-send-email-nab@linux-iscsi.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 03:23:09AM +0000, Nicholas A. Bellinger wrote:
> From: Nicholas Bellinger <nab@linux-iscsi.org>
> 
> Short of reverting commit 00d909a107 for v4.19, target-core needs a
> wait_event_t marco can be executed using TASK_UNINTERRUPTIBLE to
> function correctly with existing fabric drivers that expect to run
> with signals pending during session shutdown and active se_cmd I/O
> quiesce.
> 
> The most notable is iscsi-target/iser-target, while ibmvscsi_tgt invokes
> session shutdown logic from userspace via configfs attribute that could
> also potentially have signals pending.
> 
> So go ahead and introduce wait_event_lock_irq_timeout() to achieve this,
> and update + rename __wait_event_lock_irq_timeout() to make it accept
> 'state' as a parameter.
> 
> Fixes: 00d909a107 ("scsi: target: Make the session shutdown code also wait for commands that are being aborted")
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Mike Christie <mchristi@redhat.com>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Tested-by: Nicholas Bellinger <nab@linux-iscsi.org>
> Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
