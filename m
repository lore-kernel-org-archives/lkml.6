Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DC4C64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 20:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0186C213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 20:39:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0186C213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbeJJD6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 23:58:02 -0400
Received: from gateway23.websitewelcome.com ([192.185.48.251]:16331 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726596AbeJJD6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 23:58:02 -0400
X-Greylist: delayed 1269 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Oct 2018 23:58:02 EDT
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id E2AF62FFF3
        for <linux-kernel@vger.kernel.org>; Tue,  9 Oct 2018 15:18:14 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 9yRzgo6eD8YaU9ySDgFqgs; Tue, 09 Oct 2018 15:18:14 -0500
X-Authority-Reason: nr=8
Received: from 57.154.24.109.rev.sfr.net ([109.24.154.57]:39686 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1g9yRy-002Jkd-H0; Tue, 09 Oct 2018 15:17:50 -0500
Date:   Tue, 9 Oct 2018 22:17:48 +0200
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Steve French <sfrench@samba.org>,
        Ronnie Sahlberg <lsahlber@redhat.com>
Cc:     linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH v2] smb2: fix uninitialized variable bug in
 smb2_ioctl_query_info
Message-ID: <20181009201748.GA21025@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 109.24.154.57
X-Source-L: No
X-Exim-ID: 1g9yRy-002Jkd-H0
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 57.154.24.109.rev.sfr.net (embeddedor) [109.24.154.57]:39686
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 15
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a potential execution path in which variable *resp_buftype*
is passed as an argument to function free_rsp_buf(), in which it is
used in a comparison without being properly initialized previously.

Fix this by initializing variable *resp_buftype* to -1 in order to
avoid unpredictable or unintended results.

Addresses-Coverity-ID: 1473971 ("Uninitialized scalar variable")
Fixes: c5d25bdb2967 ("cifs: add IOCTL for QUERY_INFO passthrough to userspace")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
Changes in v2:
 - Fix Coverity and Fixes tag.
 - Update commit log.

 fs/cifs/smb2ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index c6c6450d..927aadd 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -1133,7 +1133,7 @@ smb2_ioctl_query_info(const unsigned int xid,
 	struct smb_rqst rqst;
 	struct kvec iov[1];
 	struct kvec rsp_iov;
-	int resp_buftype;
+	int resp_buftype = -1;
 	struct smb2_query_info_rsp *rsp = NULL;
 	void *buffer;
 
-- 
2.7.4

