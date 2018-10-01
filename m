Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3C9C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 07:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 531382089D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 07:16:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 531382089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbeJANxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 09:53:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:56348 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728747AbeJANxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 09:53:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ACB02ADCE;
        Mon,  1 Oct 2018 07:16:53 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org
Cc:     boris.ostrovsky@oracle.com, hpa@zytor.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, Juergen Gross <jgross@suse.com>,
        Waiman.Long@hp.com, peterz@infradead.org
Subject: [PATCH 0/2] xen: fix two issues in Xen pv qspinlock handling
Date:   Mon,  1 Oct 2018 09:16:39 +0200
Message-Id: <20181001071641.19282-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Xen specific queue spinlock wait function has two issues which
could result in a hanging system.

They have a similar root cause of clearing a pending wakeup of a
waiting vcpu and later going to sleep waiting for the just cleared
wakeup event, which of course won't ever happen.

Juergen Gross (2):
  xen: fix race in xen_qlock_wait()
  xen: make xen_qlock_wait() nestable

 arch/x86/xen/spinlock.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

Cc: Waiman.Long@hp.com
Cc: peterz@infradead.org

-- 
2.16.4

