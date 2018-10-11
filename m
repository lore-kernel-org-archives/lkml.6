Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF60C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 05:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F8BC2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 05:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-iscsi.org header.i=@linux-iscsi.org header.b="pFVLe1tK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F8BC2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-iscsi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbeJKNGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 09:06:00 -0400
Received: from mail.linux-iscsi.org ([67.23.28.174]:58724 "EHLO
        linux-iscsi.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbeJKNF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 09:05:59 -0400
Received: from [192.168.1.66] (75-37-194-224.lightspeed.lsatca.sbcglobal.net [75.37.194.224])
        (using SSLv3 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: nab)
        by linux-iscsi.org (Postfix) with ESMTPSA id D7DD940ABD;
        Thu, 11 Oct 2018 05:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=linux-iscsi.org;
        s=default.private; t=1539236429; bh=9Ca8iCQuBJcdzHHW1K6h19VK9Ql027I
        iPhDZFTqkiEY=; h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
         References:Content-Type:Mime-Version:Content-Transfer-Encoding;
        b=pFVLe1tKDN6UWM7eAUFR8SQlIwMYs4I8Scy/wvH6hhdblbIYe4IOtDSAtn4kzgI6O
        6UDI63ho8WvVmE2sd4lAOHw5Q3Qkv89Ijpd2ME+bkRtZsl9WdZnFUnNpmqsKEhi76AW
        jqmktQ6c9qIs+0KA6BSYk2nXXxOlc80Y9fAEsgA=
Message-ID: <1539236412.6150.18.camel@haakon3.daterainc.com>
Subject: Re: [PATCH 2/2] target: Fix target_wait_for_sess_cmds breakage with
 active signals
From:   "Nicholas A. Bellinger" <nab@linux-iscsi.org>
To:     Peter Zijlstra <peterz@infradead.org>
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
Date:   Wed, 10 Oct 2018 22:40:12 -0700
In-Reply-To: <20181010084335.GN5728@hirez.programming.kicks-ass.net>
References: <1539141790-13557-1-git-send-email-nab@linux-iscsi.org>
         <1539141790-13557-3-git-send-email-nab@linux-iscsi.org>
         <20181010084335.GN5728@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.4.4-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Peter & Co,

On Wed, 2018-10-10 at 10:43 +0200, Peter Zijlstra wrote:
> On Wed, Oct 10, 2018 at 03:23:10AM +0000, Nicholas A. Bellinger wrote:
> > From: Nicholas Bellinger <nab@linux-iscsi.org>
> > 
> > With the addition of commit 00d909a107 in v4.19-rc, it incorrectly assumes no
> > signals will be pending for task_struct executing the normal session shutdown
> > and I/O quiesce code-path.
> > 
> > For example, iscsi-target and iser-target issue SIGINT to all kthreads as
> > part of session shutdown.  This has been the behaviour since day one.
> 
> Not knowing much context here; but does it make sense for those
> kthreads to handle signals, ever? Most kthreads should be fine with
> ignore_signals().
> 

iscsi-target + ib-isert uses SIGINT amongst dedicated rx/tx connection
kthreads to signal connection shutdown, requiring in-flight se_cmd I/O
descriptors to be quiesced before making forward progress to release
se_session.

By the point wait_event_lock_irq_timeout() is called in the example
here, one of the two rx/tx connection kthreads has been stopped, and the
other kthread is still processing shutdown.  So while historically the
pending SIGINTs where not cleared (or ignored) during shutdown at this
point, there is no reason why they could not be ignored for iscsi-target
+ ib-isert.

That said, pre commit 00d909a107 code always used wait_for_completion()
and ignored pending signals.  As-is target_wait_for_sess_cmds() is
called directly from fabric driver code and in one case also from
user-space via configfs_write_file(), so AFAICT it does need
TASK_UNINTERRUPTIBLE.

