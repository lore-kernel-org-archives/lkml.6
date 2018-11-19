Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262F2C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D6D215EA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTMZra0C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3D6D215EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406361AbeKTD2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:28:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:42256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405677AbeKTD2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:28:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D7BA2146D;
        Mon, 19 Nov 2018 17:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542647024;
        bh=3wjus9BBZ0eG/fL+nDKtBSs7hlXfomtX00TUysEeH3I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VTMZra0Cx7cT8gsQd+1F2al9XIAKrER2GPXFIpBIT6EiHtq5BHxcVCc9zRBeybS5P
         7RQYxwp5UUfjVAofwkO5zFTN3ZcQcHYkOZxsU+TsXxYmeu1xKewcyH32E5MnsPzKDZ
         MIHtLTQahEhCThis5+AFS9GK54Vr5iP1aRirzIDo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin Willi <martin@strongswan.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 21/90] ath10k: schedule hardware restart if WMI command times out
Date:   Mon, 19 Nov 2018 17:29:03 +0100
Message-Id: <20181119162624.402134251@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162620.585061184@linuxfoundation.org>
References: <20181119162620.585061184@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Willi <martin@strongswan.org>

[ Upstream commit a9911937e7d332761e8c4fcbc7ba0426bdc3956f ]

When running in AP mode, ath10k sometimes suffers from TX credit
starvation. The issue is hard to reproduce and shows up once in a
few days, but has been repeatedly seen with QCA9882 and a large
range of firmwares, including 10.2.4.70.67.

Once the module is in this state, TX credits are never replenished,
which results in "SWBA overrun" errors, as no beacons can be sent.
Even worse, WMI commands run in a timeout while holding the conf
mutex for three seconds each, making any further operations slow
and the whole system unresponsive.

The firmware/driver never recovers from that state automatically,
and triggering TX flush or warm restarts won't work over WMI. So
issue a hardware restart if a WMI command times out due to missing
TX credits. This implies a connectivity outage of about 1.4s in AP
mode, but brings back the interface and the whole system to a usable
state. WMI command timeouts have not been seen in absent of this
specific issue, so taking such drastic actions seems legitimate.

Signed-off-by: Martin Willi <martin@strongswan.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/ath/ath10k/wmi.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -751,6 +751,12 @@ int ath10k_wmi_cmd_send(struct ath10k *a
 	if (ret)
 		dev_kfree_skb_any(skb);
 
+	if (ret == -EAGAIN) {
+		ath10k_warn(ar, "wmi command %d timeout, restarting hardware\n",
+			    cmd_id);
+		queue_work(ar->workqueue, &ar->restart_work);
+	}
+
 	return ret;
 }
 


