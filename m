Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42ECCC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BC182087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1ddPJO6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BC182087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732598AbeJICFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:05:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:56048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727260AbeJICFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:05:51 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D596C204FD;
        Mon,  8 Oct 2018 18:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024763;
        bh=0HNTmVqhTPjqQ/VTPHL1+mzxEZXQchjwPK5MCXfkHys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o1ddPJO6uepoL9ExRzGss7RJjtGBU9LXO8o+doPPlegtj6rHho7naT6RGfxXTQ0wn
         bl1w+UOAD0MMDbhqenfGNvatgoC7gI2HJWJ7+CnY4PBFT/O4hUM+OB6C0/xwAf24tW
         P4oZDzuTF0vgkFr23P0T+B125GAbkDBvfBL4PY4w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dr Silvio Cesare of InfoSect <silvio.cesare@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Steve French <stfrench@microsoft.com>,
        Aurelien Aptel <aaptel@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 138/168] cifs: read overflow in is_valid_oplock_break()
Date:   Mon,  8 Oct 2018 20:31:58 +0200
Message-Id: <20181008175625.283934273@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 097f5863b1a0c9901f180bbd56ae7d630655faaa ]

We need to verify that the "data_offset" is within bounds.

Reported-by: Dr Silvio Cesare of InfoSect <silvio.cesare@gmail.com>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Reviewed-by: Aurelien Aptel <aaptel@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/cifs/misc.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -404,9 +404,17 @@ is_valid_oplock_break(char *buffer, stru
 			(struct smb_com_transaction_change_notify_rsp *)buf;
 		struct file_notify_information *pnotify;
 		__u32 data_offset = 0;
+		size_t len = srv->total_read - sizeof(pSMBr->hdr.smb_buf_length);
+
 		if (get_bcc(buf) > sizeof(struct file_notify_information)) {
 			data_offset = le32_to_cpu(pSMBr->DataOffset);
 
+			if (data_offset >
+			    len - sizeof(struct file_notify_information)) {
+				cifs_dbg(FYI, "invalid data_offset %u\n",
+					 data_offset);
+				return true;
+			}
 			pnotify = (struct file_notify_information *)
 				((char *)&pSMBr->hdr.Protocol + data_offset);
 			cifs_dbg(FYI, "dnotify on %s Action: 0x%x\n",


