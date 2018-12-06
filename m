Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D606C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E1A20850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544108013;
	bh=SxmSdbJfkit948WoCRofnAJqsJXA8wxuz4dV6ql06Cc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2OA5p6BotyxOY/wyu2TweDMav8CtmBDOGsBZEKkjs0ZHeUmZGrDLD69h3XEHrZF7C
	 6ywtImPq2ZmpeV9kvBRqordSmlI1r2C7j459fHUptnCe+8/Vd87jSAwTjx6nd/TQpn
	 /wtJoPfQf/zRF7PiF3woXlHjJ8uIpdebhHtV6lhY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23E1A20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731064AbeLFOp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:45:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:50046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731039AbeLFOpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:45:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99EA820661;
        Thu,  6 Dec 2018 14:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107518;
        bh=SxmSdbJfkit948WoCRofnAJqsJXA8wxuz4dV6ql06Cc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kasEts0wWkFL7aeDsgxoEmMyuDhSY5zKG29JrJg6Kt/GNsPmixcPJhN28LTw6TxTS
         ZQNpQYjEvZmWrMI9fumn1neuD33HeEoOA1lmOkpVqJ1jDtdyr7Dc3Wcv4vJr8N0A6r
         LYNUgRuFL1JtBZRs3jnkejQS6UZD4Mu39jVnS9U4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.9 004/101] kobject: Replace strncpy with memcpy
Date:   Thu,  6 Dec 2018 15:38:03 +0100
Message-Id: <20181206143011.869256388@linuxfoundation.org>
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

commit 77d2a24b6107bd9b3bf2403a65c1428a9da83dd0 upstream.

gcc 8.1.0 complains:

lib/kobject.c:128:3: warning:
	'strncpy' output truncated before terminating nul copying as many
	bytes from a string as its length [-Wstringop-truncation]
lib/kobject.c: In function 'kobject_get_path':
lib/kobject.c:125:13: note: length computed here

Using strncpy() is indeed less than perfect since the length of data to
be copied has already been determined with strlen(). Replace strncpy()
with memcpy() to address the warning and optimize the code a little.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 lib/kobject.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -127,7 +127,7 @@ static void fill_kobj_path(struct kobjec
 		int cur = strlen(kobject_name(parent));
 		/* back up enough to print this name with '/' */
 		length -= cur;
-		strncpy(path + length, kobject_name(parent), cur);
+		memcpy(path + length, kobject_name(parent), cur);
 		*(path + --length) = '/';
 	}
 


