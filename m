Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABEEBC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 740E921479
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107528;
	bh=4cInqkkOLKGeSAcTtKyxDrsWh10+PP4rrIWYlcL2xK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iH10Rtn+NOVORp4I6FruMgFc81GCL7dxmVrF9pIWhqaEgiWJS5Tenm+0aOiYgpkCg
	 kkS1twXsgYI3buq0dBxJBXQ2lORlROEBhxK3S5EtBU+hRHxuYWAAqFT6AAdladaFDl
	 CnyQ00KbohoGIkRr6AYUfMPCBlnFnJ/Wy0i6XKAs=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 740E921479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731077AbeLFOp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:45:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:50110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731049AbeLFOpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:45:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF2962082B;
        Thu,  6 Dec 2018 14:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107523;
        bh=4cInqkkOLKGeSAcTtKyxDrsWh10+PP4rrIWYlcL2xK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mQUX6gzzSxoeFiiyfQMt6iHZXRP3NkF08SAH4a0qZZYMoABfInHkWKwyvwi9NfzFm
         DWepVFthbHOTT0hwv23z1zfOFElgFGt5YFp0sqhtAn2QWULhwhT4L2Xu2nMay1A7MK
         vmDEBEGOPaO28KDJupyTJls6or50MQXmEos/hhVY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 4.9 006/101] kernfs: Replace strncpy with memcpy
Date:   Thu,  6 Dec 2018 15:38:05 +0100
Message-Id: <20181206143011.974644275@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143011.174892052@linuxfoundation.org>
References: <20181206143011.174892052@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
 


