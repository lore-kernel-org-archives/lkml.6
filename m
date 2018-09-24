Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247BEECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB8C921486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:25:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB8C921486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732924AbeIXS1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:27:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56942 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730683AbeIXS1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:27:13 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DE92E108B;
        Mon, 24 Sep 2018 12:25:19 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH 4.14 160/173] mei: bus: type promotion bug in mei_nfc_if_version()
Date:   Mon, 24 Sep 2018 13:53:14 +0200
Message-Id: <20180924113126.948932367@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113114.334025954@linuxfoundation.org>
References: <20180924113114.334025954@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@oracle.com>

commit b40b3e9358fbafff6a4ba0f4b9658f6617146f9c upstream.

We accidentally removed the check for negative returns
without considering the issue of type promotion.
The "if_version_length" variable is type size_t so if __mei_cl_recv()
returns a negative then "bytes_recv" is type promoted
to a high positive value and treated as success.

Cc: <stable@vger.kernel.org>
Fixes: 582ab27a063a ("mei: bus: fix received data size check in NFC fixup")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 drivers/misc/mei/bus-fixup.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/misc/mei/bus-fixup.c
+++ b/drivers/misc/mei/bus-fixup.c
@@ -267,7 +267,7 @@ static int mei_nfc_if_version(struct mei
 
 	ret = 0;
 	bytes_recv = __mei_cl_recv(cl, (u8 *)reply, if_version_length, 0);
-	if (bytes_recv < if_version_length) {
+	if (bytes_recv < 0 || bytes_recv < if_version_length) {
 		dev_err(bus->dev, "Could not read IF version\n");
 		ret = -EIO;
 		goto err;


