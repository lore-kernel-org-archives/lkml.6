Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76AB0C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D4D12054F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570490;
	bh=x22OCmGHYKCXRpq0ZfjMFIcqprLfmwKC3GgywQMXNhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i9O8cWXRsUiIV1FOZcO/ifyV4Za6CO1iyBkNj8myOl2O13lwDe/hjT+piqQfh9x2B
	 /mvpF6Mc0iGGn52V8DSFHeKH6+23ft5h7uvZBWsTjajhr+qkpVxtc+PdsVTOSOEvct
	 Imhzb36XkpcX6pGFN5tm2x8Ds56gNKlPjTsjQCpk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732795AbfAOQl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:41:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:58054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732760AbfAOQlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:41:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 329A92054F;
        Tue, 15 Jan 2019 16:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570479;
        bh=x22OCmGHYKCXRpq0ZfjMFIcqprLfmwKC3GgywQMXNhY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MB7/R3mdouyzpsBtA1oD0ZgVmQQrxDMMq657dv19LC73X7lhYBb34j9EWE9sz8fYC
         Rumx3OBB0R9Nfm79yIV4ytyaFmJ1yV9Nuy8nBNGVcopnSsAbdXN9pr1HCZL/xb24TM
         OcPztfKdpKTgPVMDszbl1BGLZUpv9JBp5OuTvtpI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Shilovsky <pshilov@microsoft.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 4.19 10/50] CIFS: Do not set credits to 1 if the server didnt grant anything
Date:   Tue, 15 Jan 2019 17:35:46 +0100
Message-Id: <20190115154910.565903590@linuxfoundation.org>
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
@@ -885,8 +885,6 @@ compound_send_recv(const unsigned int xi
 	for (i = 0; i < num_rqst; i++)
 		if (midQ[i]->resp_buf)
 			credits += ses->server->ops->get_credits(midQ[i]);
-	if (!credits)
-		credits = 1;
 
 	for (i = 0; i < num_rqst; i++) {
 		if (rc < 0)


