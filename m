Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57EA613F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B3C220873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:38:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B3C220873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732050AbeG3QN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 12:13:29 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38194 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbeG3QNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 12:13:11 -0400
Received: by mail-wm0-f67.google.com with SMTP id t25-v6so14003628wmi.3;
        Mon, 30 Jul 2018 07:37:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SJqFqukzCDbRFCUc2qyoBpYW1tChkYYlKTY4vfkJbYc=;
        b=nivmkgohdmwgFRJAfpt1MNmNwoFwVIe660l64xEvvu5W8yNE76Syytbdrk89/Wb3co
         xqnMMt70xhjWR09Y8TfSFuoUNDCA51+kr67nondm00280Di3MTYU6cJBxyHRxgnij7xp
         KJstsyVdd5VnJuf4chrur0Nex2Ri0uZX8BUq3HlBuZgDNjlDKh8+dgKtTeSGXQgBkxt5
         Zq/hskeHZnLMJ36dIqBe2Wk53Lypx6UtUQcf7vJO0QefNwoPgemnuCGTHHN8xeLoNwAr
         +0DExas1wLyvXxjZfIomJMUzBtJ9Oo/6ZfuEcBQKbkjCLHYJou54tX5QelKpNsD+2Dx4
         xGTw==
X-Gm-Message-State: AOUpUlFeZwuP5G/RliXWTP2K32CJRurTib+XktEYq9AdwYHHAyQrkREl
        v+LPguMmESZLBWUe4rsfZMg=
X-Google-Smtp-Source: AAOMgpc+VS2tej5t9/mnsVH5t0nQjkZMzqxWcrVwtLFfJvZYScOfCPRMRvH0QDgTtESyGmY9KJ5vDQ==
X-Received: by 2002:a1c:adca:: with SMTP id w193-v6mr446041wme.147.1532961472706;
        Mon, 30 Jul 2018 07:37:52 -0700 (PDT)
Received: from localhost.localdomain (u-084-c050.eap.uni-tuebingen.de. [134.2.84.50])
        by smtp.gmail.com with ESMTPSA id 71-v6sm16599753wmq.17.2018.07.30.07.37.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 07:37:52 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     arve@android.com, tkjos@android.com, maco@android.com,
        rlove@google.com, ben@decadent.org.uk,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH 2/4] file: export __fd_install()
Date:   Mon, 30 Jul 2018 16:37:08 +0200
Message-Id: <20180730143710.14413-3-christian@brauner.io>
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

The Android binder driver will be turned into a module. Since it
uses __fd_install() we need to export this function.

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
index 90382c3ac6e7..b1ffa7acff69 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -607,6 +607,7 @@ void __fd_install(struct files_struct *files, unsigned int fd,
 	rcu_assign_pointer(fdt->fd[fd], file);
 	rcu_read_unlock_sched();
 }
+EXPORT_SYMBOL(__fd_install);
 
 void fd_install(unsigned int fd, struct file *file)
 {
-- 
2.17.1

