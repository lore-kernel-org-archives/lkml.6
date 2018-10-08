Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69D3C677E4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84BE0204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xtqsO1qK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84BE0204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732864AbeJICHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:07:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:57606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727670AbeJICHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:07:08 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5D2A204FD;
        Mon,  8 Oct 2018 18:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024840;
        bh=UC33/sQiYaV9AYdu0YgPgc+f0tj5WjweKj6i1RKLjNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xtqsO1qKxhdE8cWGKwbvbv14eLOXEn6EEfJVTjCk9Z1A7lWV81yR+wMX9ZOvVFMBd
         xsaKyp5IJNXHBG9XBWYaOOJnCF1gCkT8rO5IFXtfclDq4YiAnm3Lxr8pagOXzdoMA7
         Gkqna5hLh+vJ4vA+deF18x6cihrE5zqaCtElwuWA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julian Wiedmann <jwi@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 137/168] s390/qeth: dont dump past end of unknown HW header
Date:   Mon,  8 Oct 2018 20:31:57 +0200
Message-Id: <20181008175625.248817759@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
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

From: Julian Wiedmann <jwi@linux.ibm.com>

[ Upstream commit 0ac1487c4b2de383b91ecad1be561b8f7a2c15f4 ]

For inbound data with an unsupported HW header format, only dump the
actual HW header. We have no idea how much payload follows it, and what
it contains. Worst case, we dump past the end of the Inbound Buffer and
access whatever is located next in memory.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/net/qeth_l2_main.c |    2 +-
 drivers/s390/net/qeth_l3_main.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -425,7 +425,7 @@ static int qeth_l2_process_inbound_buffe
 		default:
 			dev_kfree_skb_any(skb);
 			QETH_CARD_TEXT(card, 3, "inbunkno");
-			QETH_DBF_HEX(CTRL, 3, hdr, QETH_DBF_CTRL_LEN);
+			QETH_DBF_HEX(CTRL, 3, hdr, sizeof(*hdr));
 			continue;
 		}
 		work_done++;
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -1390,7 +1390,7 @@ static int qeth_l3_process_inbound_buffe
 		default:
 			dev_kfree_skb_any(skb);
 			QETH_CARD_TEXT(card, 3, "inbunkno");
-			QETH_DBF_HEX(CTRL, 3, hdr, QETH_DBF_CTRL_LEN);
+			QETH_DBF_HEX(CTRL, 3, hdr, sizeof(*hdr));
 			continue;
 		}
 		work_done++;


