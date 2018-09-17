Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D1EECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A95E12146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:08:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A95E12146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731834AbeIREiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:38:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50012 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729124AbeIREiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:38:25 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9A109C7D;
        Mon, 17 Sep 2018 23:08:54 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 045/158] misc: mic: SCIF Fix scif_get_new_port() error handling
Date:   Tue, 18 Sep 2018 00:41:15 +0200
Message-Id: <20180917211713.298376769@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
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

[ Upstream commit a39284ae9d2ad09975c8ae33f1bd0f05fbfbf6ee ]

There are only 2 callers of scif_get_new_port() and both appear to get
the error handling wrong.  Both treat zero returns as error, but it
actually returns negative error codes and >= 0 on success.

Fixes: e9089f43c9a7 ("misc: mic: SCIF open close bind and listen APIs")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/mic/scif/scif_api.c |   20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

--- a/drivers/misc/mic/scif/scif_api.c
+++ b/drivers/misc/mic/scif/scif_api.c
@@ -370,11 +370,10 @@ int scif_bind(scif_epd_t epd, u16 pn)
 			goto scif_bind_exit;
 		}
 	} else {
-		pn = scif_get_new_port();
-		if (!pn) {
-			ret = -ENOSPC;
+		ret = scif_get_new_port();
+		if (ret < 0)
 			goto scif_bind_exit;
-		}
+		pn = ret;
 	}
 
 	ep->state = SCIFEP_BOUND;
@@ -648,13 +647,12 @@ int __scif_connect(scif_epd_t epd, struc
 			err = -EISCONN;
 		break;
 	case SCIFEP_UNBOUND:
-		ep->port.port = scif_get_new_port();
-		if (!ep->port.port) {
-			err = -ENOSPC;
-		} else {
-			ep->port.node = scif_info.nodeid;
-			ep->conn_async_state = ASYNC_CONN_IDLE;
-		}
+		err = scif_get_new_port();
+		if (err < 0)
+			break;
+		ep->port.port = err;
+		ep->port.node = scif_info.nodeid;
+		ep->conn_async_state = ASYNC_CONN_IDLE;
 		/* Fall through */
 	case SCIFEP_BOUND:
 		/*


