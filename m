Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D64C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C342083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:09:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0C342083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729708AbeJBUxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:53:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60670 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728964AbeJBULW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:11:22 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 07FCBC4D;
        Tue,  2 Oct 2018 13:28:01 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 080/228] ASoC: qdsp6: qdafe: fix some off by one bugs
Date:   Tue,  2 Oct 2018 06:22:57 -0700
Message-Id: <20181002132504.760009438@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit c54c1c5ee8e73b7cb752834e52e2129b1dab00bd ]

The > should be >= or we could read one element beyond the end of the
port_maps[] array.

Fixes: 7fa2d70f9766 ("ASoC: qdsp6: q6afe: Add q6afe driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/qcom/qdsp6/q6afe.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/sound/soc/qcom/qdsp6/q6afe.c
+++ b/sound/soc/qcom/qdsp6/q6afe.c
@@ -777,7 +777,7 @@ static int q6afe_callback(struct apr_dev
  */
 int q6afe_get_port_id(int index)
 {
-	if (index < 0 || index > AFE_PORT_MAX)
+	if (index < 0 || index >= AFE_PORT_MAX)
 		return -EINVAL;
 
 	return port_maps[index].port_id;
@@ -1014,7 +1014,7 @@ int q6afe_port_stop(struct q6afe_port *p
 
 	port_id = port->id;
 	index = port->token;
-	if (index < 0 || index > AFE_PORT_MAX) {
+	if (index < 0 || index >= AFE_PORT_MAX) {
 		dev_err(afe->dev, "AFE port index[%d] invalid!\n", index);
 		return -EINVAL;
 	}
@@ -1355,7 +1355,7 @@ struct q6afe_port *q6afe_port_get_from_i
 	unsigned long flags;
 	int cfg_type;
 
-	if (id < 0 || id > AFE_PORT_MAX) {
+	if (id < 0 || id >= AFE_PORT_MAX) {
 		dev_err(dev, "AFE port token[%d] invalid!\n", id);
 		return ERR_PTR(-EINVAL);
 	}


