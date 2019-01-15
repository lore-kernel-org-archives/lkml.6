Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8314C43444
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75EA820645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570629;
	bh=jok/EpH1o3jvskm95QHvUcwmPw+Q/2aJKstzyhjJ5KI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fClL9Uz1fO+r2vtzXkkAdBLqLSZUgGx/Pjed+XDdHyLkgsKrZZAWCuN03cyVrlGdd
	 QJY0XpEohrZgEL6KiAIxRlTNNoh+Zj3PngOEjyzgv5f/7YWWqdd5v0n/WkSOWOGYKT
	 5HvEpnl8GdHVTa66+sNhKyyg7Kum/1EsaLP/MPdo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387399AbfAOQnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:43:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:33256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731633AbfAOQnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:43:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA33F2054F;
        Tue, 15 Jan 2019 16:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570623;
        bh=jok/EpH1o3jvskm95QHvUcwmPw+Q/2aJKstzyhjJ5KI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1TWeXeaKWZ7qiFR0AHxBxKd1ow9KmBgs8hr+7Yis/YNqXUMIxcvzYyD8z2ZQHL+Pd
         96dzISBHuuODSMsS13S8zouaSL/qaY1hRilbKBK5qJHx4QeO3jv8GnuHMgCdJnD2m4
         5bciYbDKaUUDJv1KgWmNrGpqN+1HfT9D1DAWn0RY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Shilovsky <pshilov@microsoft.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 4.20 12/57] CIFS: Fix adjustment of credits for MTU requests
Date:   Tue, 15 Jan 2019 17:35:53 +0100
Message-Id: <20190115154911.413721821@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154910.734892368@linuxfoundation.org>
References: <20190115154910.734892368@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3197,12 +3197,14 @@ smb2_async_readv(struct cifs_readdata *r
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
 
@@ -3474,12 +3476,14 @@ smb2_async_writev(struct cifs_writedata
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
 


