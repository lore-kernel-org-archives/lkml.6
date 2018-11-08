Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573F4ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1484C20892
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJrgK7Gq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1484C20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729573AbeKIHfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:35:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:52030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbeKIHfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:35:12 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E97420892;
        Thu,  8 Nov 2018 21:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714264;
        bh=H2noGOQP/QYpIKUqFTHz/2cHqjtgGEITEiikjQeKbyE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IJrgK7GqPhrh0YbnjD8e7tn84KLy3/1QvTk8LGfqty3DZk8FXvXPv7/QLJ0FbYREW
         /tUPA4iToldg2Zgj8kSLTAwK/1c293WJIMt33sbm0sujBQ/byuDYC8Zbre/P2lzn/g
         X5qWxa+BcOICK19JeoVT7suutVoL2aYEyg1u9ysw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <james.l.morris@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 122/144] KEYS: put keyring if install_session_keyring_to_cred() fails
Date:   Thu,  8 Nov 2018 13:51:33 -0800
Message-Id: <20181108215106.897907073@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
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



