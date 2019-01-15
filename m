Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45AC3C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0975120645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570636;
	bh=TXt5aRQFcwk8UTxrXsxEanTc0VKoP6pSVN6fKOX3hRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NArguXXomyuItTG1sEZrh/BrplFw472AOk74rr+I68ynr1bHP5YqeQM+6Zsc2gfC0
	 XGBmrNLf/XAAznsUMUe/1jzpZWbPV65WbCPfNz4Ee3Jj1Se1A4uL4ihR6aphxPomxN
	 6O9vHR1zpiZwyCM933E+ECACp7jgWYf45oSZKEj4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387418AbfAOQnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:43:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:33348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730622AbfAOQnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:43:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DDFA2054F;
        Tue, 15 Jan 2019 16:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570628;
        bh=TXt5aRQFcwk8UTxrXsxEanTc0VKoP6pSVN6fKOX3hRo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s8Ut6+fn3xXBrpcs2hS2Gf0YBKUBaYxC8sQSzb6PsHUwfM/Iuk4Oo3LBWCpwHkeTu
         +TkxSJnZhq79FiGQ7qQw4M3z4KqZ520trpY76Mh8AlAq+ZWwjhGQXZktDSKlzFJvR0
         ZBOXGgRaeqgTptrFeA55P4L1LjdN7pFCYxB6288c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Shilovsky <pshilov@microsoft.com>,
        Jeff Layton <jlayton@kernel.org>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 4.20 14/57] CIFS: Do not hide EINTR after sending network packets
Date:   Tue, 15 Jan 2019 17:35:55 +0100
Message-Id: <20190115154911.514830122@linuxfoundation.org>
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

commit ee13919c2e8d1f904e035ad4b4239029a8994131 upstream.

Currently we hide EINTR code returned from sock_sendmsg()
and return 0 instead. This makes a caller think that we
successfully completed the network operation which is not
true. Fix this by properly returning EINTR to callers.

Cc: <stable@vger.kernel.org>
Signed-off-by: Pavel Shilovsky <pshilov@microsoft.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/transport.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/cifs/transport.c
+++ b/fs/cifs/transport.c
@@ -385,7 +385,7 @@ smbd_done:
 	if (rc < 0 && rc != -EINTR)
 		cifs_dbg(VFS, "Error %d sending data on socket to server\n",
 			 rc);
-	else
+	else if (rc > 0)
 		rc = 0;
 
 	return rc;


