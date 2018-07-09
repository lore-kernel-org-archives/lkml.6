Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5142C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 04:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 028F7208DB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 04:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="iqfyenw2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 028F7208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932231AbeGIEpA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 00:45:00 -0400
Received: from smtprelay4.synopsys.com ([198.182.47.9]:37974 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750818AbeGIEo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 00:44:58 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 5AB5C24E229D;
        Sun,  8 Jul 2018 21:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1531111498; bh=yaiz/OMXY4OwQyCA8PAtPxBmZBM6Ex7xnI+AEj7QvtY=;
        h=From:To:Cc:Subject:Date:From;
        b=iqfyenw2syKVZszXl3odcpRkjkNAtl78WF3wvvQqSvjQE4UM7HlNaDuvXQAUnKYUS
         ZFFTrtMpMs8GV78gGLupiiun8CYPco/QrtPyAs7Zn2xLmcP4RtS4zRNxUozkuReIIJ
         CHs9KIN1gVts2gk4rZrfxBt2Q8gtRKHNOiCrVX7nknJvAoCozk3J0W68GyTR8DipCe
         JMittQNX0LA+ZfQPibFnNYN+4gJfgN9XnCVnnfWY2BW4lAlu04WrXhtFS0twD9prL6
         Mg7D1EcdlTcnECliG7PMNjKfNnP/6Ti7FinzbtGf76O+/da3EZD2M8llPuO4PiU+A4
         RM09ZxD0HPyHg==
Received: from abrodkin-7480l.internal.synopsys.com (unknown [10.121.8.87])
        by mailhost.synopsys.com (Postfix) with ESMTP id 939EC3A2B;
        Sun,  8 Jul 2018 21:44:54 -0700 (PDT)
From:   Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org,
        Greg KH <greg@kroah.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org
Subject: [RESEND PATCH v2] devres: Really align data field to unsigned long long
Date:   Mon,  9 Jul 2018 07:44:44 +0300
Message-Id: <20180709044444.6397-1-abrodkin@synopsys.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Depending on ABI "long long" type of a particular 32-bit CPU
might be aligned by either word (32-bits) or double word (64-bits).
Make sure "data" is really 64-bit aligned for any 32-bit CPU.

At least for 32-bit ARC cores ABI requires "long long" types
to be aligned by normal 32-bit word. This makes "data" field aligned to
12 bytes. Which is still OK as long as we use 32-bit data only.

But once we want to use native atomic64_t type (i.e. when we use special
instructions LLOCKD/SCONDD for accessing 64-bit data) we easily hit
misaligned access exception.

That's because even on CPUs capable of non-aligned data access LL/SC
instructions require strict alignment.

Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
---

Changes v1 -> v2:

 * Reworded commit message
 * Inserted comment right in source [Thomas]

 drivers/base/devres.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index f98a097e73f2..466fa59c866a 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -24,8 +24,12 @@ struct devres_node {
 
 struct devres {
 	struct devres_node		node;
-	/* -- 3 pointers */
-	unsigned long long		data[];	/* guarantee ull alignment */
+	/*
+	 * Depending on ABI "long long" type of a particular 32-bit CPU
+	 * might be aligned by either word (32-bits) or double word (64-bits).
+	 * Make sure "data" is really 64-bit aligned for any 32-bit CPU.
+	 */
+	unsigned long long		data[] __aligned(sizeof(unsigned long long));
 };
 
 struct devres_group {
-- 
2.17.1

