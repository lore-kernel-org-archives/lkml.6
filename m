Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07484C65BD7
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 21:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6D8821479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 21:47:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6D8821479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbeJJFF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 01:05:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33092 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727961AbeJJFF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 01:05:59 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7DBA03001754;
        Tue,  9 Oct 2018 21:47:01 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3D357805E5;
        Tue,  9 Oct 2018 21:47:01 +0000 (UTC)
Received: from zmail25.collab.prod.int.phx2.redhat.com (zmail25.collab.prod.int.phx2.redhat.com [10.5.83.31])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id EE3674BB74;
        Tue,  9 Oct 2018 21:47:00 +0000 (UTC)
Date:   Tue, 9 Oct 2018 17:47:00 -0400 (EDT)
From:   Ronnie Sahlberg <lsahlber@redhat.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org
Message-ID: <716967702.32689579.1539121620152.JavaMail.zimbra@redhat.com>
In-Reply-To: <20181009201748.GA21025@embeddedor.com>
References: <20181009201748.GA21025@embeddedor.com>
Subject: Re: [PATCH v2] smb2: fix uninitialized variable bug in
 smb2_ioctl_query_info
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.64.54.29, 10.4.195.17]
Thread-Topic: smb2: fix uninitialized variable bug in smb2_ioctl_query_info
Thread-Index: bkRINFvPAxTgNLqsaumOYEpWoWiyDw==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 09 Oct 2018 21:47:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good catch, but I think it should be :

int resp_buftype = CIFS_NO_BUFFER;


----- Original Message -----
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: "Steve French" <sfrench@samba.org>, "Ronnie Sahlberg" <lsahlber@redhat.com>
Cc: linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Sent: Wednesday, 10 October, 2018 6:17:48 AM
Subject: [PATCH v2] smb2: fix uninitialized variable bug in smb2_ioctl_query_info

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

