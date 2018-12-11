Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BFCC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C0452084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544545184;
	bh=MR52ceTF3CQ2z5/6MOkj4ExVyz9Z6pins38wddcvWmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x7R57CPDVuQccz6D2GJwCiC2mW5Gkqqjwocgdyf8nKguj4tvaBKtvqGqPep6XiaNF
	 JlrbnPWTxUC3YR2RIGhVNgUNL3PgF4qx7GXUyQrmzMgxw0ew55JiPiC3Kx+ZNXsUJ8
	 fUk8CSCPmTuI2jLFOtWHgWxLQpm1G2Qd1IqyGwoo=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C0452084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbeLKPpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:45:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:33998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727613AbeLKPpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:45:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95314208E7;
        Tue, 11 Dec 2018 15:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543135;
        bh=MR52ceTF3CQ2z5/6MOkj4ExVyz9Z6pins38wddcvWmI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gSHhi4FuGK66MqobYgoa7Qql5I+nCZPxIlhe/1MYInPu6RIxRpZW8ARsuwhv/7t10
         A2/SwrjFDBV2R/cb8vTOLQXYpBVHSdgk5VxLtpxms/YywYbH1rjK7k1biTQfVymcdh
         TlpzbFmxBZJOBrWL4h6g6kF5akL6yFlbti4+XnRo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 4.4 26/91] kernfs: Replace strncpy with memcpy
Date:   Tue, 11 Dec 2018 16:40:45 +0100
Message-Id: <20181211151607.925552714@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151606.026852373@linuxfoundation.org>
References: <20181211151606.026852373@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guenter Roeck <linux@roeck-us.net>

commit 166126c1e54d927c2e8efa2702d420e0ce301fd9 upstream.

gcc 8.1.0 complains:

fs/kernfs/symlink.c:91:3: warning:
	'strncpy' output truncated before terminating nul copying
	as many bytes from a string as its length
fs/kernfs/symlink.c: In function 'kernfs_iop_get_link':
fs/kernfs/symlink.c:88:14: note: length computed here

Using strncpy() is indeed less than perfect since the length of data to
be copied has already been determined with strlen(). Replace strncpy()
with memcpy() to address the warning and optimize the code a little.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/kernfs/symlink.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/kernfs/symlink.c
+++ b/fs/kernfs/symlink.c
@@ -88,7 +88,7 @@ static int kernfs_get_target_path(struct
 		int slen = strlen(kn->name);
 
 		len -= slen;
-		strncpy(s + len, kn->name, slen);
+		memcpy(s + len, kn->name, slen);
 		if (len)
 			s[--len] = '/';
 


