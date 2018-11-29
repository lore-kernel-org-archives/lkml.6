Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65011C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CE6E21104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7fpq+y5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CE6E21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732226AbeK3B2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:28:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:54484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731487AbeK3B2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:28:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE160205C9;
        Thu, 29 Nov 2018 14:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501390;
        bh=zJZa2Yi7BQsntlcItmkv38lcyr86JVx+B3tZ5bOZqiE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g7fpq+y5vEUGNA0vAkDDX42/ARpQaZf1Pg5s20Af92pQiv6ZLogP8cOzhiPUnRHCB
         OVoLMw0z86l1v7ve7fcTcrx5LQu6nbFslKDoEWf546/8KFCVl1Nnx6Ed/Pggujuhkk
         3XyLzUgQJXjuxDNXEFsF+NP58+4N5nE0ASVQmvyg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amitkumar Karwar <akarwar@marvell.com>,
        Brian Norris <briannorris@chromium.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 4.9 71/92] mwifiex: prevent register accesses after host is sleeping
Date:   Thu, 29 Nov 2018 15:12:40 +0100
Message-Id: <20181129140112.125124662@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140106.520639693@linuxfoundation.org>
References: <20181129140106.520639693@linuxfoundation.org>
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

From: Amitkumar Karwar <akarwar@marvell.com>

commit ec815dd2a5f110f627d7955e0027a3a008f68166 upstream.

Following is mwifiex driver-firmware host sleep handshake.
It involves three threads. suspend handler, interrupt handler, interrupt
processing in main work queue.

1) Enter suspend handler
2) Download HS_CFG command
3) Response from firmware for HS_CFG
4) Suspend thread waits until handshake completes(i.e hs_activate becomes
   true)
5) SLEEP from firmware
6) SLEEP confirm downloaded to firmware.
7) SLEEP confirm response from firmware
8) Driver processes SLEEP confirm response and set hs_activate to wake up
suspend thread
9) Exit suspend handler
10) Read sleep cookie in loop and wait until it indicates firmware is
sleep.
11) After processing SLEEP confirm response, we are at the end of interrupt
processing routine. Recheck if there are interrupts received while we were
processing them.

During suspend-resume stress test, it's been observed that we may end up
acessing PCIe hardware(in 10 and 11) when PCIe bus is closed which leads
to a kernel crash.

This patch solves the problem with below changes.
a) action 10 above can be done before 8
b) Skip 11 if hs_activated is true. SLEEP confirm response
is the last interrupt from firmware. No need to recheck for
pending interrupts.
c) Add flush_workqueue() in suspend handler.

Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
Reviewed-by: Brian Norris <briannorris@chromium.org>
Tested-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/marvell/mwifiex/pcie.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/net/wireless/marvell/mwifiex/pcie.c
+++ b/drivers/net/wireless/marvell/mwifiex/pcie.c
@@ -118,6 +118,7 @@ static int mwifiex_pcie_suspend(struct d
 	adapter = card->adapter;
 
 	hs_actived = mwifiex_enable_hs(adapter);
+	flush_workqueue(adapter->workqueue);
 
 	/* Indicate device suspended */
 	adapter->is_suspended = true;
@@ -1676,9 +1677,6 @@ static int mwifiex_pcie_process_cmd_comp
 
 	if (!adapter->curr_cmd) {
 		if (adapter->ps_state == PS_STATE_SLEEP_CFM) {
-			mwifiex_process_sleep_confirm_resp(adapter, skb->data,
-							   skb->len);
-			mwifiex_pcie_enable_host_int(adapter);
 			if (mwifiex_write_reg(adapter,
 					      PCIE_CPU_INT_EVENT,
 					      CPU_INTR_SLEEP_CFM_DONE)) {
@@ -1691,6 +1689,9 @@ static int mwifiex_pcie_process_cmd_comp
 			while (reg->sleep_cookie && (count++ < 10) &&
 			       mwifiex_pcie_ok_to_access_hw(adapter))
 				usleep_range(50, 60);
+			mwifiex_pcie_enable_host_int(adapter);
+			mwifiex_process_sleep_confirm_resp(adapter, skb->data,
+							   skb->len);
 		} else {
 			mwifiex_dbg(adapter, ERROR,
 				    "There is no command but got cmdrsp\n");
@@ -2329,6 +2330,8 @@ static int mwifiex_process_pcie_int(stru
 			ret = mwifiex_pcie_process_cmd_complete(adapter);
 			if (ret)
 				return ret;
+			if (adapter->hs_activated)
+				return ret;
 		}
 
 		if (card->msi_enable) {


