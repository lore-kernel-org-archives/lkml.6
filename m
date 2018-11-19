Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D028CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B2E0214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DS+vXlJd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B2E0214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406588AbeKTD2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:28:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:43346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405880AbeKTD2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:28:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07D9B2146D;
        Mon, 19 Nov 2018 17:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542647074;
        bh=WGomX2UA6nf5WkPZF4QKCYtj27vGu+G0Y0nMg32S9do=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DS+vXlJd69ehyA0DHPGdXhzKqg7DGm8Fjpmy+DexV3ayjIx6mnQxtOuIg4hXHb86O
         +dG4hjsB/P6q1jJiNtmfMfCq3bWLDK4bI7tjn2soQKRcQS4U0odcDYK7+ERws/IiFO
         RhCtGyTkjqbMjQ5voz+R/qRS9lllxuC/8FHC8wJE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve French <stfrench@microsoft.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>
Subject: [PATCH 3.18 41/90] smb3: on kerberos mount if server doesnt specify auth type use krb5
Date:   Mon, 19 Nov 2018 17:29:23 +0100
Message-Id: <20181119162627.376688952@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162620.585061184@linuxfoundation.org>
References: <20181119162620.585061184@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

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


