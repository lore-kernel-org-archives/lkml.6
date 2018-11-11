Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDD7C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B00E920817
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrKWhe9q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B00E920817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389602AbeKLJLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:11:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:47678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389415AbeKLIVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:21:12 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A345223CB;
        Sun, 11 Nov 2018 22:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975475;
        bh=VCJSsT7JghEFXH991BDB+YNgREMPLSN2KLgaQ8PUvtU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YrKWhe9qPdpJ+8/jvEAePtqPIvkqOvOguAFCkxP+obHy/2ZdktB3Q3HtsRf69jlJd
         z3io313oigaKYK792h3W0/KY9A/63g/QoB03AqHW6psLIYdk/BMAkWiIhEYFTACKTX
         TZ2oBXpJqpCMWhmch/yfHb/uXBFzpq4HC7X0Vho8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve French <stfrench@microsoft.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>
Subject: [PATCH 4.18 258/350] smb3: on kerberos mount if server doesnt specify auth type use krb5
Date:   Sun, 11 Nov 2018 14:22:02 -0800
Message-Id: <20181111221718.810748357@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
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

From: Steve French <stfrench@microsoft.com>

commit 926674de6705f0f1dbf29a62fd758d0977f535d6 upstream.

Some servers (e.g. Azure) do not include a spnego blob in the SMB3
negotiate protocol response, so on kerberos mounts ("sec=krb5")
we can fail, as we expected the server to list its supported
auth types (OIDs in the spnego blob in the negprot response).
Change this so that on krb5 mounts we default to trying krb5 if the
server doesn't list its supported protocol mechanisms.

Signed-off-by: Steve French <stfrench@microsoft.com>
Reviewed-by: Ronnie Sahlberg <lsahlber@redhat.com>
CC: Stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/cifs_spnego.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/fs/cifs/cifs_spnego.c
+++ b/fs/cifs/cifs_spnego.c
@@ -147,8 +147,10 @@ cifs_get_spnego_key(struct cifs_ses *ses
 		sprintf(dp, ";sec=krb5");
 	else if (server->sec_mskerberos)
 		sprintf(dp, ";sec=mskrb5");
-	else
-		goto out;
+	else {
+		cifs_dbg(VFS, "unknown or missing server auth type, use krb5\n");
+		sprintf(dp, ";sec=krb5");
+	}
 
 	dp = description + strlen(description);
 	sprintf(dp, ";uid=0x%x",


