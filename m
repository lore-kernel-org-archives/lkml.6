Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBBCC43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8AD824FAE
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:30:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8AD824FAE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754419AbeFXPaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:30:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58980 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752150AbeFXPaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:30:16 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9B4952C;
        Sun, 24 Jun 2018 15:30:15 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Syms <mark.syms@citrix.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 4.14 32/52] CIFS: 511c54a2f69195b28afb9dd119f03787b1625bb4 adds a check for session expiry
Date:   Sun, 24 Jun 2018 23:21:25 +0800
Message-Id: <20180624142746.405529450@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180624142744.234164867@linuxfoundation.org>
References: <20180624142744.234164867@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Syms <mark.syms@citrix.com>

commit d81243c697ffc71f983736e7da2db31a8be0001f upstream.

Handle this additional status in the same way as SESSION_EXPIRED.

Signed-off-by: Mark Syms <mark.syms@citrix.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
CC: Stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smb2ops.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -1256,10 +1256,11 @@ smb2_is_session_expired(char *buf)
 {
 	struct smb2_sync_hdr *shdr = get_sync_hdr(buf);
 
-	if (shdr->Status != STATUS_NETWORK_SESSION_EXPIRED)
+	if (shdr->Status != STATUS_NETWORK_SESSION_EXPIRED &&
+	    shdr->Status != STATUS_USER_SESSION_DELETED)
 		return false;
 
-	cifs_dbg(FYI, "Session expired\n");
+	cifs_dbg(FYI, "Session expired or deleted\n");
 	return true;
 }
 


