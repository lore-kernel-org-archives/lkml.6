Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3E8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 03:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16FB32087D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 03:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-iscsi.org header.i=@linux-iscsi.org header.b="X86T1VvC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16FB32087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-iscsi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbeJJKvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 06:51:18 -0400
Received: from mail.linux-iscsi.org ([67.23.28.174]:53479 "EHLO
        linux-iscsi.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbeJJKvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 06:51:18 -0400
Received: from linux-iscsi.org (localhost [127.0.0.1])
        by linux-iscsi.org (Postfix) with ESMTP id DDC1540ABD;
        Wed, 10 Oct 2018 03:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=linux-iscsi.org;
        s=default.private; t=1539141795; bh=gTfSdxWSg/YkfEjdAi/RGhIDcrnaz5r
        Ql5P8awK1xXk=; h=From:To:Cc:Subject:Date:Message-Id; b=X86T1VvCxoMC
        XVaoeadBwIllh6NFUnXvSnPFAt+ljCQOZm+NQ0lmmNm4TiJwn9g15O+XCyqy/tnWn/E
        y0kx19O3ZuVeMQp5jAuEzF+Ww2Ja5Xiv6rCtMXn+B2eI6jxUc1xwyABQo7fuUYoNy9C
        xlGIshNeBuuEmom7kzn4by8eU=
From:   "Nicholas A. Bellinger" <nab@linux-iscsi.org>
To:     target-devel <target-devel@vger.kernel.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mike Christie <mchristi@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Nicholas Bellinger <nab@linux-iscsi.org>
Subject: [PATCH 0/2] target: Fix v4.19-rc active I/O shutdown deadlock
Date:   Wed, 10 Oct 2018 03:23:08 +0000
Message-Id: <1539141790-13557-1-git-send-email-nab@linux-iscsi.org>
X-Mailer: git-send-email 1.7.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Bellinger <nab@linux-iscsi.org>

Hi MNC, MKP & Co,

While testing v4.19-rc recently with simple backend I/O error injection
(via delayed BIO completion), I was able to trigger an end-less loop
deadlock with recent changes in commit 00d909a107:

  Author: Bart Van Assche <bart.vanassche@wdc.com>
  Date:   Fri Jun 22 14:52:53 2018 -0700

      scsi: target: Make the session shutdown code also wait for commands that are being aborted

It comes down to an incorrect assumption wrt signals during session
shutdown plus active I/O quiesce, which triggers an endless loop
immediately during session shutdown as se_session->sess_list_wq
waits for outstanding backend I/O to complete.

The easiest reproduction is with iser-target or simulation with plain
old iscsi-target/TCP ports.  However, any fabric driver who triggers
session shutdown from user-space processes with signals pending can
easily trigger it and bring down the machine.

The fix is simple, but requires a new wait_event_lock_irq_timeout()
macro to allow TASK_UNINTERRUPTIBLE to be set in order to work as
expected for all fabric driver session shutdown cases.

So short of reverting commit 00d909a107 now for v4.19, this is going
to be the best option.

Please review for v4.19, or v4.20-rc1 with stable CC's for both.

Thank you.

Nicholas Bellinger (2):
  sched/wait: Add wait_event_lock_irq_timeout for TASK_UNINTERRUPTIBLE
    usage
  target: Fix target_wait_for_sess_cmds breakage with active signals

 drivers/target/target_core_transport.c |  4 ++--
 include/linux/wait.h                   | 20 +++++++++++++++-----
 2 files changed, 17 insertions(+), 7 deletions(-)

-- 
1.9.1

