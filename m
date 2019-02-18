Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2253C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A069621902
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550497617;
	bh=TplG2/ThW7x8vkZKnuJ4qSZu0CUu8r3t+hMxWwJvPjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zYs3z2Ftusw+A57VE8e0auntS2Q9DKMzWsswDLoGMePGW0HUR8MRzbwMErX+fMx/K
	 aRNRBZq5J4jAzynYAUf7/wXulj3rjq4FvDUIVULzhbFjEL0T4JoUD8F2j84JXK4pwy
	 +sjfxTda5ZzrW0/L9er4SfyfEZb1xkE2M7LosJgU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730034AbfBRNq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:46:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:53346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729672AbfBRNqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:46:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E75021901;
        Mon, 18 Feb 2019 13:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497611;
        bh=TplG2/ThW7x8vkZKnuJ4qSZu0CUu8r3t+hMxWwJvPjw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zXNoEEolPnKQWm5I6qrywqyDq64qbA6/Bci++mjeksyPRfJ7NkmZvLhEL0drSguHc
         /vjYqdoEh9wugMA87qMLdSjKvFEvQiSu1UkhzAhxwym4b1XZI8SydygUhUMEzTNvo/
         LEWleGbVFFTHRz7aj5wzDChxKwx4qr0uW08c4W+E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Shilovsky <pshilov@microsoft.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 46/92] CIFS: Fix credit calculations in compound mid callback
Date:   Mon, 18 Feb 2019 14:42:49 +0100
Message-Id: <20190218133459.016625465@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133454.668268457@linuxfoundation.org>
References: <20190218133454.668268457@linuxfoundation.org>
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

[ Upstream commit 3d3003fce8e837acc4e3960fe3cbabebc356dcb5 ]

The current code doesn't do proper accounting for credits
in SMB1 case: it adds one credit per response only if we get
a complete response while it needs to return it unconditionally.
Fix this and also include malformed responses for SMB2+ into
accounting for credits because such responses have Credit
Granted field, thus nothing prevents to get a proper credit
value from them.

Signed-off-by: Pavel Shilovsky <pshilov@microsoft.com>
Reviewed-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smb2ops.c   |  6 +++++-
 fs/cifs/transport.c | 11 +----------
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index d7dd7d38fad6..aa71e620f3cd 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -154,7 +154,11 @@ smb2_get_credits(struct mid_q_entry *mid)
 {
 	struct smb2_sync_hdr *shdr = (struct smb2_sync_hdr *)mid->resp_buf;
 
-	return le16_to_cpu(shdr->CreditRequest);
+	if (mid->mid_state == MID_RESPONSE_RECEIVED
+	    || mid->mid_state == MID_RESPONSE_MALFORMED)
+		return le16_to_cpu(shdr->CreditRequest);
+
+	return 0;
 }
 
 static int
diff --git a/fs/cifs/transport.c b/fs/cifs/transport.c
index 0dab276eced8..6f937e826910 100644
--- a/fs/cifs/transport.c
+++ b/fs/cifs/transport.c
@@ -784,17 +784,8 @@ static void
 cifs_compound_callback(struct mid_q_entry *mid)
 {
 	struct TCP_Server_Info *server = mid->server;
-	unsigned int optype = mid->optype;
-	unsigned int credits_received = 0;
 
-	if (mid->mid_state == MID_RESPONSE_RECEIVED) {
-		if (mid->resp_buf)
-			credits_received = server->ops->get_credits(mid);
-		else
-			cifs_dbg(FYI, "Bad state for cancelled MID\n");
-	}
-
-	add_credits(server, credits_received, optype);
+	add_credits(server, server->ops->get_credits(mid), mid->optype);
 }
 
 static void
-- 
2.19.1



