Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id xYQPF4hVGVvRNwAAmS7hNA
	; Thu, 07 Jun 2018 15:57:39 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 62FE26074D; Thu,  7 Jun 2018 15:57:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0BC5460590;
	Thu,  7 Jun 2018 15:57:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0BC5460590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934265AbeFGP52 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:57:28 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39383 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932747AbeFGOJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:08 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb7-0005Zk-Jm; Thu, 07 Jun 2018 15:09:05 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb4-0002wA-5L; Thu, 07 Jun 2018 15:09:02 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Daniel N Pettersson" <danielnp@axis.com>,
        "Steve French" <smfrench@gmail.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.705160280@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 165/410] cifs: Fix autonegotiate security settings
 mismatch
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel N Pettersson <danielnp@axis.com>

commit 9aca7e454415f7878b28524e76bebe1170911a88 upstream.

Autonegotiation gives a security settings mismatch error if the SMB
server selects an SMBv3 dialect that isn't SMB3.02. The exact error is
"protocol revalidation - security settings mismatch".
This can be tested using Samba v4.2 or by setting the global Samba
setting max protocol = SMB3_00.

The check that fails in smb3_validate_negotiate is the dialect
verification of the negotiate info response. This is because it tries
to verify against the protocol_id in the global smbdefault_values. The
protocol_id in smbdefault_values is SMB3.02.
In SMB2_negotiate the protocol_id in smbdefault_values isn't updated,
it is global so it probably shouldn't be, but server->dialect is.

This patch changes the check in smb3_validate_negotiate to use
server->dialect instead of server->vals->protocol_id. The patch works
with autonegotiate and when using a specific version in the vers mount
option.

Signed-off-by: Daniel N Pettersson <danielnp@axis.com>
Signed-off-by: Steve French <smfrench@gmail.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/cifs/smb2pdu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -541,8 +541,7 @@ int smb3_validate_negotiate(const unsign
 	}
 
 	/* check validate negotiate info response matches what we got earlier */
-	if (pneg_rsp->Dialect !=
-			cpu_to_le16(tcon->ses->server->vals->protocol_id))
+	if (pneg_rsp->Dialect != cpu_to_le16(tcon->ses->server->dialect))
 		goto vneg_out;
 
 	if (pneg_rsp->SecurityMode != cpu_to_le16(tcon->ses->server->sec_mode))
