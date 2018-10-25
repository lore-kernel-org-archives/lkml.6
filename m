Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5FAC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43BD120870
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LgGVBhu5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43BD120870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731491AbeJYWyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:54:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:37204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731391AbeJYWyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:54:17 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A20412085B;
        Thu, 25 Oct 2018 14:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477279;
        bh=46u7Ri/GaPGJJR7KCBCAUh1nLhznMM0OpHkFyk94cKU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LgGVBhu5Int+TJoAPO5qV78xtikMUQ3bhhkjICwmBGl5fLa4O0mL76ujZWyIGZptQ
         pHxb5AYT0RRzlP8T6WDF+YC5KZjRtaDH3tHk5EsVSTz0daE2v8k/CQv1J3NhwVnkYB
         D+pGmzjoAKBfSx0vVcbBWznetBrPIxe6XJOANof4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Eric Biggers <ebiggers@google.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <james.l.morris@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 94/98] KEYS: put keyring if install_session_keyring_to_cred() fails
Date:   Thu, 25 Oct 2018 10:18:49 -0400
Message-Id: <20181025141853.214051-94-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

[ Upstream commit d636bd9f12a66ea3775c9fabbf3f8e118253467a ]

In join_session_keyring(), if install_session_keyring_to_cred() were to
fail, we would leak the keyring reference, just like in the bug fixed by
commit 23567fd052a9 ("KEYS: Fix keyring ref leak in
join_session_keyring()").  Fortunately this cannot happen currently, but
we really should be more careful.  Do this by adding and using a new
error label at which the keyring reference is dropped.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: James Morris <james.l.morris@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/keys/process_keys.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
index 85b61a3ac981..6f32ca53456a 100644
--- a/security/keys/process_keys.c
+++ b/security/keys/process_keys.c
@@ -808,15 +808,14 @@ long join_session_keyring(const char *name)
 		ret = PTR_ERR(keyring);
 		goto error2;
 	} else if (keyring == new->session_keyring) {
-		key_put(keyring);
 		ret = 0;
-		goto error2;
+		goto error3;
 	}
 
 	/* we've got a keyring - now to install it */
 	ret = install_session_keyring_to_cred(new, keyring);
 	if (ret < 0)
-		goto error2;
+		goto error3;
 
 	commit_creds(new);
 	mutex_unlock(&key_session_mutex);
@@ -826,6 +825,8 @@ long join_session_keyring(const char *name)
 okay:
 	return ret;
 
+error3:
+	key_put(keyring);
 error2:
 	mutex_unlock(&key_session_mutex);
 error:
-- 
2.17.1

