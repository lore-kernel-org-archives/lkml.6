Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955B8ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51E8320989
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYN/+isw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51E8320989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730101AbeKIHhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:37:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:54884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729500AbeKIHhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:37:06 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F7832146E;
        Thu,  8 Nov 2018 21:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714378;
        bh=ncOJ3tKK3EBtdYngCc9PlI3qrb+7Y1lzIjSKwWTQti8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pYN/+iswDxzIuw4rbrAVX2eNpSz+skY0bKaGKuU6+X0YxxFMerBiLzHzUHW6ZKU/N
         tREJiVebsiv81AZcUh5pMPl9CwUBuKx4zwFkcgClLXQGsab4bKpz+WiZp4+5AImcCE
         XJh5Ge+31sWhEguU+JBF9wwlqDLxs5oct37J+wJY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <james.l.morris@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 019/114] KEYS: put keyring if install_session_keyring_to_cred() fails
Date:   Thu,  8 Nov 2018 13:50:34 -0800
Message-Id: <20181108215100.897428351@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215059.051093652@linuxfoundation.org>
References: <20181108215059.051093652@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

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
index ac1d5b2b1626..a7095372701e 100644
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



