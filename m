Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5BCC43615
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13A242083A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:40:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13A242083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732301AbeHWMJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:09:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49762 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731298AbeHWMJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:09:20 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 09259BC1;
        Thu, 23 Aug 2018 08:40:43 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve French <stfrench@gmail.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 015/324] smb3: increase initial number of credits requested to allow write
Date:   Thu, 23 Aug 2018 09:51:21 +0200
Message-Id: <20180823074956.669164546@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steve French <stfrench@microsoft.com>

[ Upstream commit d409014e4feeab486fb36b350abfc4c94de8be37 ]

Compared to other clients the Linux smb3 client ramps up
credits very slowly, taking more than 128 operations before a
maximum size write could be sent (since the number of credits
requested is only 2 per small operation, causing the credit
limit to grow very slowly).

This lack of credits initially would impact large i/o performance,
when large i/o is tried early before enough credits are built up.

Signed-off-by: Steve French <stfrench@gmail.com>
Reviewed-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/cifs/smb2pdu.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -923,8 +923,9 @@ SMB2_sess_alloc_buffer(struct SMB2_sess_
 	req->PreviousSessionId = sess_data->previous_session;
 
 	req->Flags = 0; /* MBZ */
-	/* to enable echos and oplocks */
-	req->sync_hdr.CreditRequest = cpu_to_le16(3);
+
+	/* enough to enable echos and oplocks and one max size write */
+	req->sync_hdr.CreditRequest = cpu_to_le16(130);
 
 	/* only one of SMB2 signing flags may be set in SMB2 request */
 	if (server->sign)


