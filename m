Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07FDC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 723D021736
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546864714;
	bh=A+6gH5gzc9Jw/TP++eq0LZgGr2I642YoFwoaZGJAiiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0UGtcWMwjzmTfCOZOSW7BQMXueep4SSbW5uPe4+p8GrpsEBKKaYbvLSHFsjTEqECe
	 c5e2U5JZg3lAVeD2pNhwzljdlFvwbptWG+GqiULDnQ0MLsElfMA233Hi2hlnjoH/dn
	 /heZj3FyMLjFHypHAmWL0awSviyubH+7KDEgtMQE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbfAGMid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:38:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:53632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727460AbfAGMib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:38:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8FC320859;
        Mon,  7 Jan 2019 12:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546864710;
        bh=A+6gH5gzc9Jw/TP++eq0LZgGr2I642YoFwoaZGJAiiQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZR4CeeAjLXgpI4yfnIX/7Bl6uvulOwDoAW3NviTjo8+ewyCt/mNYYNGPpWaDzd1NH
         RlWI6jUaMo6X2Irg1iVFKYkf4Uq+sOGMpYg+dmjJCZQMI5heo9j9km+/AJCWOCjNyI
         Iv2ai6QfN5O5yPyPfih/S+gjoabE79piQZJ05keM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Greg Kurz <groug@kaod.org>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.20 071/145] ocxl: Fix endiannes bug in read_afu_name()
Date:   Mon,  7 Jan 2019 13:31:48 +0100
Message-Id: <20190107104446.543638829@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
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

From: Greg Kurz <groug@kaod.org>

commit 2f07229f02d4c55affccd11a61af4fd4b94dc436 upstream.

The AFU Descriptor Template in the PCI config space has a Name Space
field which is a 24 Byte ASCII character string of descriptive name
space for the AFU. The OCXL driver read the string four characters at
a time with pci_read_config_dword().

This optimization is valid on a little-endian system since this is PCI,
but a big-endian system ends up with each subset of four characters in
reverse order.

This could be fixed by switching to read characters one by one. Another
option is to swap the bytes if we're big-endian.

Go for the latter with le32_to_cpu().

Cc: stable@vger.kernel.org      # v4.16
Signed-off-by: Greg Kurz <groug@kaod.org>
Acked-by: Frederic Barrat <fbarrat@linux.ibm.com>
Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/misc/ocxl/config.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/misc/ocxl/config.c
+++ b/drivers/misc/ocxl/config.c
@@ -318,7 +318,7 @@ static int read_afu_name(struct pci_dev
 		if (rc)
 			return rc;
 		ptr = (u32 *) &afu->name[i];
-		*ptr = val;
+		*ptr = le32_to_cpu((__force __le32) val);
 	}
 	afu->name[OCXL_AFU_NAME_SZ - 1] = '\0'; /* play safe */
 	return 0;


