Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05B5ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9041520658
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6ZF09ol"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9041520658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730572AbeJSCI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:08:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:58216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729150AbeJSCI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:08:57 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41B05204FD;
        Thu, 18 Oct 2018 18:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539886009;
        bh=9pAGrqXcytAeRffkWl6O7Fh2zOEXigxSvBLbQDoTL4I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d6ZF09olk4LNSpjfmFI8aQYzIi0VzJ+zjxg2eUlTHID1Spy6brzPIaMIEKc6gxz3u
         QzNNqSGBFuChpFoC402rfmoLXa4/RUv3zIy1PJvEdRVjfFNoebmw2xHp2TOqXIKe2Q
         KuNYyeh8/mt8rFT+xEwYSvS284vu9c4HUxOCAAlk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
Subject: [PATCH 4.4 45/48] Drivers: hv: utils: Invoke the poll function after handshake
Date:   Thu, 18 Oct 2018 19:55:20 +0200
Message-Id: <20181018175430.310703510@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175427.133690306@linuxfoundation.org>
References: <20181018175427.133690306@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: K. Y. Srinivasan <kys@microsoft.com>

commit 2d0c3b5ad739697a68dc8a444f5b9f4817cf8f8f upstream.

When the handshake with daemon is complete, we should poll the channel since
during the handshake, we will not be processing any messages. This is a
potential bug if the host is waiting for a response from the guest.
I would like to thank Dexuan for pointing this out.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hv/hv_kvp.c      |    2 +-
 drivers/hv/hv_snapshot.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/hv/hv_kvp.c
+++ b/drivers/hv/hv_kvp.c
@@ -155,7 +155,7 @@ static int kvp_handle_handshake(struct h
 	pr_debug("KVP: userspace daemon ver. %d registered\n",
 		 KVP_OP_REGISTER);
 	kvp_register(dm_reg_value);
-	kvp_transaction.state = HVUTIL_READY;
+	hv_poll_channel(kvp_transaction.recv_channel, kvp_poll_wrapper);
 
 	return 0;
 }
--- a/drivers/hv/hv_snapshot.c
+++ b/drivers/hv/hv_snapshot.c
@@ -114,7 +114,7 @@ static int vss_handle_handshake(struct h
 	default:
 		return -EINVAL;
 	}
-	vss_transaction.state = HVUTIL_READY;
+	hv_poll_channel(vss_transaction.recv_channel, vss_poll_wrapper);
 	pr_debug("VSS: userspace daemon ver. %d registered\n", dm_reg_value);
 	return 0;
 }


