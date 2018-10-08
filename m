Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64305C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AEDF2087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LEjRF0Yh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AEDF2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730895AbeJIB6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:58:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:46098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730200AbeJIB6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:58:06 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38AE22064A;
        Mon,  8 Oct 2018 18:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024300;
        bh=Tt62fx2IAlLYKtFG4xvsJprTfvRkFjZijynlY1GCBZw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LEjRF0Yh4cwZRcKp4jFfKVkAJlk8NGNXU9HqoUpgDqfm2j8VdZTa7LZiu+I3/QCYb
         z7XPXevWPdf0+l8GWqabfhdhesM+3nCIS4BFTzl5K+avljwVBRqERQ3YwPcz3lzLcl
         UU7igQRZjQnE7iXcs9syGHR3NCFfwjqmeu+wGWfw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: [PATCH 4.14 90/94] Drivers: hv: vmbus: Use get/put_cpu() in vmbus_connect()
Date:   Mon,  8 Oct 2018 20:32:11 +0200
Message-Id: <20181008175610.839100740@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175605.067676667@linuxfoundation.org>
References: <20181008175605.067676667@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dexuan Cui <decui@microsoft.com>

commit 41e270f6898e7502be9fd6920ee0a108ca259d36 upstream.

With CONFIG_DEBUG_PREEMPT=y, I always see this warning:
BUG: using smp_processor_id() in preemptible [00000000]

Fix the false warning by using get/put_cpu().

Here vmbus_connect() sends a message to the host and waits for the
host's response. The host will deliver the response message and an
interrupt on CPU msg->target_vcpu, and later the interrupt handler
will wake up vmbus_connect(). vmbus_connect() doesn't really have
to run on the same cpu as CPU msg->target_vcpu, so it's safe to
call put_cpu() just here.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Cc: stable@vger.kernel.org
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hv/connection.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -74,6 +74,7 @@ static int vmbus_negotiate_version(struc
 					__u32 version)
 {
 	int ret = 0;
+	unsigned int cur_cpu;
 	struct vmbus_channel_initiate_contact *msg;
 	unsigned long flags;
 
@@ -96,9 +97,10 @@ static int vmbus_negotiate_version(struc
 	 * the CPU attempting to connect may not be CPU 0.
 	 */
 	if (version >= VERSION_WIN8_1) {
-		msg->target_vcpu =
-			hv_cpu_number_to_vp_number(smp_processor_id());
-		vmbus_connection.connect_cpu = smp_processor_id();
+		cur_cpu = get_cpu();
+		msg->target_vcpu = hv_cpu_number_to_vp_number(cur_cpu);
+		vmbus_connection.connect_cpu = cur_cpu;
+		put_cpu();
 	} else {
 		msg->target_vcpu = 0;
 		vmbus_connection.connect_cpu = 0;


