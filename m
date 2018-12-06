Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F411CC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA80B20700
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544108311;
	bh=m1PeOOd+wvmswooEF0g2uJ4B+81daG2qyIez2wvC54Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eQN9oP5Yas2zJTz6zhhiprYs4fdGWwdDW/A314xiCCzt+mxfPM9Cx3GZGXZGQyQVV
	 IpYymCzsxxsYmb23bKghEDjYXIFKon4vxfFg7QKT2lGmaE4jln/iQ90pSjnXSoPNWZ
	 3mjZg3iUNGc17Mi7MpZKAveqQgM8MsFuLQ0IjjRM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA80B20700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730407AbeLFOmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:42:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:46380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728482AbeLFOmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:42:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1872E2082B;
        Thu,  6 Dec 2018 14:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107325;
        bh=m1PeOOd+wvmswooEF0g2uJ4B+81daG2qyIez2wvC54Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1unSYaVJdA2L/MM30ahGMmQeQ06c3o4sBdlVwswKe+yfbsOLoc0MO4kMe3TZmPrY5
         y7Ffr/oV6+p5uwQtxlQPV36Xk5cG23wAuwStmTlwW0INUkU02rb/uqJvq91PDIwKV7
         mOCC2a5ZZ1VbxniQGbS5AJafeS5PXmLpiyIu13aU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.14 04/55] kobject: Replace strncpy with memcpy
Date:   Thu,  6 Dec 2018 15:38:38 +0100
Message-Id: <20181206143001.987978040@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143001.749982936@linuxfoundation.org>
References: <20181206143001.749982936@linuxfoundation.org>
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
 


