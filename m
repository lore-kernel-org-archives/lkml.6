Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C63C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6068120645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547571198;
	bh=RrA0arMF/Nz22sS6k0+LWbGPU/NOg5lL39yaPkHh5NM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q62ApB0NvHWtlRS1HXg5QDXWITSXUiZnA9XNEnRzTSb5onfkuUr99Qj1iot/PEFiz
	 6hAZgBLyBWAUoaIK99yFnlVkDaopyPViXD62aapF/OaGEw9Jq7ai1WprT4bo6u2h3a
	 fVqRvWs/eH9EOSZsark1vqDWnhdp5QX/UY3co0lo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732987AbfAOQxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:53:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:33312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730681AbfAOQnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:43:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70E642054F;
        Tue, 15 Jan 2019 16:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570625;
        bh=RrA0arMF/Nz22sS6k0+LWbGPU/NOg5lL39yaPkHh5NM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P+1pGGUoaxTzk/2WPwo7cTxpQY7p+bmnk9MVooePWZlQsnrNHUsoBVi/eia0023Ya
         luxSbVOsyTRZw2muYSOhfnT0lmFTG3XKgJGBH+olnu7kFwMBPlIBia9ZFxD/b/g0OE
         n8H9ag0o2kudug3cBA86tPrMaRp8xcn3ZzSzuFP0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Shilovsky <pshilov@microsoft.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 4.20 13/57] CIFS: Do not set credits to 1 if the server didnt grant anything
Date:   Tue, 15 Jan 2019 17:35:54 +0100
Message-Id: <20190115154911.473305262@linuxfoundation.org>
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

commit 33fa5c8b8a7dbe6353a56eaa654b790348890d42 upstream.

Currently we reset the number of total credits granted by the server
to 1 if the server didn't grant us anything int the response. This
violates the SMB3 protocol - we need to trust the server and use
the credit values from the response. Fix this by removing the
corresponding code.

Signed-off-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
CC: Stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/transport.c |    2 --
 1 file changed, 2 deletions(-)

--- a/fs/cifs/transport.c
+++ b/fs/cifs/transport.c
@@ -892,8 +892,6 @@ compound_send_recv(const unsigned int xi
 	for (i = 0; i < num_rqst; i++)
 		if (midQ[i]->resp_buf)
 			credits += ses->server->ops->get_credits(midQ[i]);
-	if (!credits)
-		credits = 1;
 
 	for (i = 0; i < num_rqst; i++) {
 		if (rc < 0)


