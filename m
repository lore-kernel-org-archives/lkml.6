Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7898C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AE0D21479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNWJziAi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AE0D21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730065AbeJSCGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:06:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:54654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728416AbeJSCGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:06:21 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDCC8214AB;
        Thu, 18 Oct 2018 18:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885853;
        bh=ze6KmlzeIGKkpqoBEfWzoNHc2p9HS7bxs4Y2eQBnsT0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FNWJziAiKCp7UV1opuOtzT0F/g3fqcb/KRi9r/WARU6LufVzaAIQD3ndoPcI/JLco
         0zEQUaQWyOApf9OUF+KYN0BAGxB+QZNaPSp5Zk9WulBlY5laMKvj54h2XqbwmZv8Pw
         vom9NO5mtBcdrHXHymbhsECMS84e1tdaOqYHIrAk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wang Jian <jianjian.wang1@gmail.com>,
        Dexuan Cui <decui@microsoft.com>,
        Long Li <longli@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 4.9 35/35] HV: properly delay KVP packets when negotiation is in progress
Date:   Thu, 18 Oct 2018 19:55:04 +0200
Message-Id: <20181018175427.755458013@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175422.506152522@linuxfoundation.org>
References: <20181018175422.506152522@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Long Li <longli@microsoft.com>

commit a3ade8cc474d848676278660e65f5af1e9e094d9 upstream.

The host may send multiple negotiation packets
(due to timeout) before the KVP user-mode daemon
is connected. KVP user-mode daemon is connected.
We need to defer processing those packets
until the daemon is negotiated and connected.
It's okay for guest to respond
to all negotiation packets.

In addition, the host may send multiple staged
KVP requests as soon as negotiation is done.
We need to properly process those packets using one
tasklet for exclusive access to ring buffer.

This patch is based on the work of
Nick Meier <Nick.Meier@microsoft.com>.

The above is the original changelog of
a3ade8cc474d ("HV: properly delay KVP packets when negotiation is in progress"

Here I re-worked the original patch because the mainline version
can't work for the linux-4.4.y branch, on which channel->callback_event
doesn't exist yet. In the mainline, channel->callback_event was added by:
631e63a9f346 ("vmbus: change to per channel tasklet"). Here we don't want
to backport it to v4.4, as it requires extra supporting changes and fixes,
which are unnecessary as to the KVP bug we're trying to resolve.

NOTE: before this patch is used, we should cherry-pick the other related
3 patches from the mainline first:

The background of this backport request is that: recently Wang Jian reported
some KVP issues: https://github.com/LIS/lis-next/issues/593:
e.g. the /var/lib/hyperv/.kvp_pool_* files can not be updated, and sometimes
if the hv_kvp_daemon doesn't timely start, the host may not be able to query
the VM's IP address via KVP.

Reported-by: Wang Jian <jianjian.wang1@gmail.com>
Tested-by: Wang Jian <jianjian.wang1@gmail.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Long Li <longli@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hv/hv_kvp.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

--- a/drivers/hv/hv_kvp.c
+++ b/drivers/hv/hv_kvp.c
@@ -616,21 +616,22 @@ void hv_kvp_onchannelcallback(void *cont
 		     NEGO_IN_PROGRESS,
 		     NEGO_FINISHED} host_negotiatied = NEGO_NOT_STARTED;
 
-	if (host_negotiatied == NEGO_NOT_STARTED &&
-	    kvp_transaction.state < HVUTIL_READY) {
+	if (kvp_transaction.state < HVUTIL_READY) {
 		/*
 		 * If userspace daemon is not connected and host is asking
 		 * us to negotiate we need to delay to not lose messages.
 		 * This is important for Failover IP setting.
 		 */
-		host_negotiatied = NEGO_IN_PROGRESS;
-		schedule_delayed_work(&kvp_host_handshake_work,
+		if (host_negotiatied == NEGO_NOT_STARTED) {
+			host_negotiatied = NEGO_IN_PROGRESS;
+			schedule_delayed_work(&kvp_host_handshake_work,
 				      HV_UTIL_NEGO_TIMEOUT * HZ);
+		}
 		return;
 	}
 	if (kvp_transaction.state > HVUTIL_READY)
 		return;
-
+recheck:
 	vmbus_recvpacket(channel, recv_buffer, PAGE_SIZE * 4, &recvlen,
 			 &requestid);
 
@@ -707,6 +708,8 @@ void hv_kvp_onchannelcallback(void *cont
 				       VM_PKT_DATA_INBAND, 0);
 
 		host_negotiatied = NEGO_FINISHED;
+
+		goto recheck;
 	}
 
 }


