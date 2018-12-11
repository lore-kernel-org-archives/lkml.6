Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF6EC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5CE920855
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543680;
	bh=cUuPPYPy2K6QBZr5pyg54aD0xwbXKhmFpY3WWYhaZB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Dx8isAvo4dNyrhz1iZUJkJgchn47E46n+qPZCKAwwMmz0rn3Q6xeGDfEzkZ6JOPUG
	 mS5eU+0qKZusiP8YGLur8n6UdC+hHA1xQMf/4KSQMVz25eeexjzUW3aTZClBu6c77N
	 K7FfPQyPj0bleyBO+1HaeB+DqYR5jtRHvZmG931Q=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5CE920855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730213AbeLKPyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:54:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:43176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730145AbeLKPye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:54:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B86032146D;
        Tue, 11 Dec 2018 15:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543673;
        bh=cUuPPYPy2K6QBZr5pyg54aD0xwbXKhmFpY3WWYhaZB4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VqWKGYlrCLNNbepnf2CaMDwzXXLu0lxUc9XN61pGDSo+XDfI9YRhEcD+PqnZhkwyO
         20k4AHS2rXsj+SdcIme3owbXOCEZ+eiNaXRGNplbh8lH/763D25Ela4eCwIidTX3rR
         VBlKnRrWTsz19hyU+hYdsEjNJVrjwisiaYui37AY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 002/118] media: cec: check for non-OK/NACK conditions while claiming a LA
Date:   Tue, 11 Dec 2018 16:40:21 +0100
Message-Id: <20181211151644.313948188@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 55623b4169056d7bb493d1c6f715991f8db67302 ]

During the configuration phase of a CEC adapter it is trying to claim a
free logical address by polling.

However, the code doesn't check if there were errors other than OK or NACK,
those are just treated as if the poll was NACKed.

Instead check for such errors and retry the poll. And if the problem persists
then don't claim this LA since there is something weird going on.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/cec/cec-adap.c | 47 ++++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/media/cec/cec-adap.c b/drivers/media/cec/cec-adap.c
index dd8bad74a1f0..a537e518384b 100644
--- a/drivers/media/cec/cec-adap.c
+++ b/drivers/media/cec/cec-adap.c
@@ -1167,6 +1167,8 @@ static int cec_config_log_addr(struct cec_adapter *adap,
 {
 	struct cec_log_addrs *las = &adap->log_addrs;
 	struct cec_msg msg = { };
+	const unsigned int max_retries = 2;
+	unsigned int i;
 	int err;
 
 	if (cec_has_log_addr(adap, log_addr))
@@ -1175,19 +1177,44 @@ static int cec_config_log_addr(struct cec_adapter *adap,
 	/* Send poll message */
 	msg.len = 1;
 	msg.msg[0] = (log_addr << 4) | log_addr;
-	err = cec_transmit_msg_fh(adap, &msg, NULL, true);
 
-	/*
-	 * While trying to poll the physical address was reset
-	 * and the adapter was unconfigured, so bail out.
-	 */
-	if (!adap->is_configuring)
-		return -EINTR;
+	for (i = 0; i < max_retries; i++) {
+		err = cec_transmit_msg_fh(adap, &msg, NULL, true);
 
-	if (err)
-		return err;
+		/*
+		 * While trying to poll the physical address was reset
+		 * and the adapter was unconfigured, so bail out.
+		 */
+		if (!adap->is_configuring)
+			return -EINTR;
+
+		if (err)
+			return err;
 
-	if (msg.tx_status & CEC_TX_STATUS_OK)
+		/*
+		 * The message was aborted due to a disconnect or
+		 * unconfigure, just bail out.
+		 */
+		if (msg.tx_status & CEC_TX_STATUS_ABORTED)
+			return -EINTR;
+		if (msg.tx_status & CEC_TX_STATUS_OK)
+			return 0;
+		if (msg.tx_status & CEC_TX_STATUS_NACK)
+			break;
+		/*
+		 * Retry up to max_retries times if the message was neither
+		 * OKed or NACKed. This can happen due to e.g. a Lost
+		 * Arbitration condition.
+		 */
+	}
+
+	/*
+	 * If we are unable to get an OK or a NACK after max_retries attempts
+	 * (and note that each attempt already consists of four polls), then
+	 * then we assume that something is really weird and that it is not a
+	 * good idea to try and claim this logical address.
+	 */
+	if (i == max_retries)
 		return 0;
 
 	/*
-- 
2.19.1



