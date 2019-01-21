Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2155C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81FD320879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548080025;
	bh=46JTS+2JaGx7yxohl37+I6+x9BsePGqpV8PJ3w5ty00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o2QB4WIniziWoINh5SOkhWt0rHLwkorc+dRtdp5UUuEHSqZW1jyIKfjfDA0/F8M2j
	 4SzJoxDLfEyNKGmaCtDRjgAIqguyRGDWt1F+7ooEFYLJRyppQxuwjtAPiCKcFaDGFz
	 Wk8mewDlW8kDB0CIu3qVF9bAg/L/peVsSZKfizCI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731510AbfAUONn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:13:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:36416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729993AbfAUNxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:53:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE36220879;
        Mon, 21 Jan 2019 13:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078780;
        bh=46JTS+2JaGx7yxohl37+I6+x9BsePGqpV8PJ3w5ty00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZEnjRefUhm1w5Hdu2wtefm0v0tWuZxh+ZmvsxVlD64djfbKuRcB80T40nQn5o+kAN
         4Yn2GsVGwdLmdJOppvqOLgRBkq0eoRqhFTpw11v5Gl5UJXdPxAHEVHeASkd/j+lmoo
         xJnL6VB/XoYOlHdl7MHyNm5IakCfBbG/WgekRpgs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <james.morris@microsoft.com>,
        syzbot+69ca07954461f189e808@syzkaller.appspotmail.com
Subject: [PATCH 4.14 41/59] LSM: Check for NULL cred-security on free
Date:   Mon, 21 Jan 2019 14:44:06 +0100
Message-Id: <20190121122501.358219812@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122456.529172919@linuxfoundation.org>
References: <20190121122456.529172919@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Morris <james.morris@microsoft.com>

commit a5795fd38ee8194451ba3f281f075301a3696ce2 upstream.

From: Casey Schaufler <casey@schaufler-ca.com>

Check that the cred security blob has been set before trying
to clean it up. There is a case during credential initialization
that could result in this.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Acked-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: James Morris <james.morris@microsoft.com>
Reported-by: syzbot+69ca07954461f189e808@syzkaller.appspotmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/security.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/security/security.c
+++ b/security/security.c
@@ -993,6 +993,13 @@ int security_cred_alloc_blank(struct cre
 
 void security_cred_free(struct cred *cred)
 {
+	/*
+	 * There is a failure case in prepare_creds() that
+	 * may result in a call here with ->security being NULL.
+	 */
+	if (unlikely(cred->security == NULL))
+		return;
+
 	call_void_hook(cred_free, cred);
 }
 


