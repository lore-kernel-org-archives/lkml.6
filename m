Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A00C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5987921104
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543135;
	bh=TVKLsX38TiclIx/TQqYWCvTNdLMSbQYtQcDN7Uusnk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kuzmmR1JD1ZFZGD1BkXcMBsRzT7CnWn03GJ82g7OwJffaLuEFfmcwpGnhNuw00OeX
	 dsE5Y25QUfU0CnonoMTJxFHDVuSKGLhonf4O/zVM/aIDLiU0eWRKhwwufe7YoJwyhU
	 YTHg5oEQcXE+M9PX8t/qKDDYN8vhszYl7Q35jOQU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5987921104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbeLKPpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:45:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:33930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728119AbeLKPpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:45:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45D1F20870;
        Tue, 11 Dec 2018 15:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543129;
        bh=TVKLsX38TiclIx/TQqYWCvTNdLMSbQYtQcDN7Uusnk8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PpGnOYLCN3uu7ew3ZR36Mg314AUBC3BJwuUeYhzR1+RMA2WsDjjYfIXIk1IJJQnzb
         bVDkp/1cOODM3IDfGCBe0aRWnCNx2tVhp2vzJaN8ylcPmMySU9M9W2j8BOm8sMXt1P
         5KAVAgft7N/at4HXG3Qmie6uTRX4v3OSZB/YaVx0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.4 24/91] kobject: Replace strncpy with memcpy
Date:   Tue, 11 Dec 2018 16:40:43 +0100
Message-Id: <20181211151607.734672744@linuxfoundation.org>
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
 


