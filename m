Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A2EC43612
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2166A20645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547571282;
	bh=3EPtAtcsBx7m5XKN2ufBecNXB8g9AcivaP2XFQAcmN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=btk7jPinCeLya8zk6FMrxfs9gBNtD/2Oz53xd3wLVHX9Nu8A1HzN+ru5czWPY5N1Y
	 ojs8rv6YHzb6919OhgI4bz3r9ZuS9pX2ug6lkXhB6r7d1VvrVMCYcAy1Ph5654ztRa
	 qZ0FScwljrW/O4LnIKwe0bzajxXsHT4ZU7DmR3dA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733089AbfAOQmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:42:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:60308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729583AbfAOQmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:42:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A511520873;
        Tue, 15 Jan 2019 16:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570567;
        bh=3EPtAtcsBx7m5XKN2ufBecNXB8g9AcivaP2XFQAcmN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t9uBhWCt2rAJedgYNuzeGgYmiBuQAzjvOoVjXTco+Di6pgoSDLscSUnQ0Gzj3DWbT
         R6TkN7WCxsiNi7vIDbEh3WNF0lh5jaOSD4hHdeXToSxzA//v6sE/+Tpthj5I+eNm6T
         A0MBxjAfpP0RzgZVmbrRIZ9af0eyUpwS941YMzM0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Shilovsky <pshilov@microsoft.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 4.19 09/50] CIFS: Fix adjustment of credits for MTU requests
Date:   Tue, 15 Jan 2019 17:35:45 +0100
Message-Id: <20190115154910.519249925@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154909.933241945@linuxfoundation.org>
References: <20190115154909.933241945@linuxfoundation.org>
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

From: Pavel Shilovsky <pshilov@microsoft.com>

commit b983f7e92348d7e7d091db1b78b7915e9dd3d63a upstream.

Currently for MTU requests we allocate maximum possible credits
in advance and then adjust them according to the request size.
While we were adjusting the number of credits belonging to the
server, we were skipping adjustment of credits belonging to the
request. This patch fixes it by setting request credits to
CreditCharge field value of SMB2 packet header.

Also ask 1 credit more for async read and write operations to
increase parallelism and match the behavior of other operations.

Signed-off-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
CC: Stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smb2pdu.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -3185,12 +3185,14 @@ smb2_async_readv(struct cifs_readdata *r
 	if (rdata->credits) {
 		shdr->CreditCharge = cpu_to_le16(DIV_ROUND_UP(rdata->bytes,
 						SMB2_MAX_BUFFER_SIZE));
-		shdr->CreditRequest = shdr->CreditCharge;
+		shdr->CreditRequest =
+			cpu_to_le16(le16_to_cpu(shdr->CreditCharge) + 1);
 		spin_lock(&server->req_lock);
 		server->credits += rdata->credits -
 						le16_to_cpu(shdr->CreditCharge);
 		spin_unlock(&server->req_lock);
 		wake_up(&server->request_q);
+		rdata->credits = le16_to_cpu(shdr->CreditCharge);
 		flags |= CIFS_HAS_CREDITS;
 	}
 
@@ -3462,12 +3464,14 @@ smb2_async_writev(struct cifs_writedata
 	if (wdata->credits) {
 		shdr->CreditCharge = cpu_to_le16(DIV_ROUND_UP(wdata->bytes,
 						    SMB2_MAX_BUFFER_SIZE));
-		shdr->CreditRequest = shdr->CreditCharge;
+		shdr->CreditRequest =
+			cpu_to_le16(le16_to_cpu(shdr->CreditCharge) + 1);
 		spin_lock(&server->req_lock);
 		server->credits += wdata->credits -
 						le16_to_cpu(shdr->CreditCharge);
 		spin_unlock(&server->req_lock);
 		wake_up(&server->request_q);
+		wdata->credits = le16_to_cpu(shdr->CreditCharge);
 		flags |= CIFS_HAS_CREDITS;
 	}
 


