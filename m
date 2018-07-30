Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DD213F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2BD720873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:37:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2BD720873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731941AbeG3QNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 12:13:12 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39298 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbeG3QNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 12:13:10 -0400
Received: by mail-wm0-f68.google.com with SMTP id h20-v6so13995935wmb.4;
        Mon, 30 Jul 2018 07:37:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DrRW/Hn8A9KP+1fA5hKZ/J+h0jcvXtgHoVpA5bqReIA=;
        b=rOpOvV3mClDndCHipbW5A9YYw179S98Rqz16gaJw/x37woOnhYbU9iY4mpGee2YjFx
         ZzKDdbdHt2L0qlbJ/1rpMgJA/fOYnF7sf7j4NfrjrZ7rJmHfRatwhClmVBnm9UOjRIFh
         8Y0RpEHfZsA+AnzD5Q2cg0B1wIdi9jdxITJ7Rmb/DAFqP8gCILG9e6mvJ5xN0FHqNUkY
         atAzGvfEap9wIN1VSPm8mMXB+7Fwu2rXqAW0M8DSCgP9saLCxOtOgz8UcJlO4jTKKpoY
         53D06Hie6T9G4va0Ozjg1fx9NRMuNQBtX90kFBijL5eUSKoR4vDUZq+rjUkTTPCQ/lU4
         yYng==
X-Gm-Message-State: AOUpUlELLI+I4ll0VYpgG4qvpzzaoc0eZQSY+/D7y1658ELL/v13ks4K
        SUwCPrMLCk4qfwdUee8PeOw=
X-Google-Smtp-Source: AAOMgpcPHnHzqRcRIn98ud1pp4RfYFyOqIqgh7LqHsFIVfBgrgJhIctZob4tNq7KiLBR2tfi1+h8Pg==
X-Received: by 2002:a1c:8c12:: with SMTP id o18-v6mr14870093wmd.120.1532961471556;
        Mon, 30 Jul 2018 07:37:51 -0700 (PDT)
Received: from localhost.localdomain (u-084-c050.eap.uni-tuebingen.de. [134.2.84.50])
        by smtp.gmail.com with ESMTPSA id 71-v6sm16599753wmq.17.2018.07.30.07.37.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 07:37:50 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     arve@android.com, tkjos@android.com, maco@android.com,
        rlove@google.com, ben@decadent.org.uk,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH 1/4] file: export __alloc_fd()
Date:   Mon, 30 Jul 2018 16:37:07 +0200
Message-Id: <20180730143710.14413-2-christian@brauner.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180730143710.14413-1-christian@brauner.io>
References: <20180730143710.14413-1-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Android binder driver will be turned into a module. Since it uses
__alloc_fd() we need to export this function.

Signed-off-by: Christian Brauner <christian@brauner.io>
Cc: Todd Kjos <tkjos@android.com>
Cc: Robert Love <rlove@google.com>
Cc: Ben Hutching <ben@decadent.org.uk>
Cc: Martijn Coenen <maco@android.com>
Cc: Arve Hjønnevåg <arve@android.com>
---
 fs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/file.c b/fs/file.c
index 7ffd6e9d103d..90382c3ac6e7 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -533,6 +533,7 @@ int __alloc_fd(struct files_struct *files,
 	spin_unlock(&files->file_lock);
 	return error;
 }
+EXPORT_SYMBOL(__alloc_fd);
 
 static int alloc_fd(unsigned start, unsigned flags)
 {
-- 
2.17.1

