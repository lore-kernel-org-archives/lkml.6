Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2120C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9293C206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:36:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9293C206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733055AbeJBUTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:19:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36096 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733019AbeJBUTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:19:35 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4ADDAB4A;
        Tue,  2 Oct 2018 13:36:11 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 41/94] rndis_wlan: potential buffer overflow in rndis_wlan_auth_indication()
Date:   Tue,  2 Oct 2018 06:24:55 -0700
Message-Id: <20181002132503.350912631@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132500.494838053@linuxfoundation.org>
References: <20181002132500.494838053@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit ae636fb1554833ee5133ca47bf4b2791b6739c52 ]

This is a static checker fix, not something I have tested.  The issue
is that on the second iteration through the loop, we jump forward by
le32_to_cpu(auth_req->length) bytes.  The problem is that if the length
is more than "buflen" then we end up with a negative "buflen".  A
negative buflen is type promoted to a high positive value and the loop
continues but it's accessing beyond the end of the buffer.

I believe the "auth_req->length" comes from the firmware and if the
firmware is malicious or buggy, you're already toasted so the impact of
this bug is probably not very severe.

Fixes: 030645aceb3d ("rndis_wlan: handle 802.11 indications from device")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/rndis_wlan.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/wireless/rndis_wlan.c
+++ b/drivers/net/wireless/rndis_wlan.c
@@ -2921,6 +2921,8 @@ static void rndis_wlan_auth_indication(s
 
 	while (buflen >= sizeof(*auth_req)) {
 		auth_req = (void *)buf;
+		if (buflen < le32_to_cpu(auth_req->length))
+			return;
 		type = "unknown";
 		flags = le32_to_cpu(auth_req->flags);
 		pairwise_error = false;


