Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2EEC5AC78
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 14:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC85A2184A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 14:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="b37rW2Ll"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbeLXO06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 09:26:58 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41433 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbeLXO06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 09:26:58 -0500
Received: by mail-pl1-f194.google.com with SMTP id u6so5643292plm.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 06:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=icjQTW3x6UjcsbYwELCUWBNGNwIM9zb4XrsIvHI9ZYo=;
        b=b37rW2LlnpC3BbmHr+BZB4oGNAvcbpE2PyquWC00zLdY+lzf/Nq3FTXvliVQaAyqWA
         VBnEQrbbkxQ/lNpH0tKW+j5v8r5InV33/IDIo6mcczBI4VwwF4X9xHawxHe1Do7p5dOt
         5Qu1z6idOIe3w36S0i+E0R2e/hOu3LziQ1qn5XBb+TAfX3wdJOUEeb/0SnzpPgRtEnEx
         K0lgfV3jS6ICDVmEyl/WDbEglOmJX1kHuhCNfvntFDGDy3kp+iI3jrlMH36mkN7WNyey
         jcZ6K1nveblKlxq+Hz91R9eH4p7PjW/juZecbeAZOMD7ts94OxlFPflTGkEciPBnBcY+
         ZP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=icjQTW3x6UjcsbYwELCUWBNGNwIM9zb4XrsIvHI9ZYo=;
        b=Kglg5RwXJvvxRjw1toJUI7A9hg739XQzCDOZv/6smnph4trQrrCpMt8E6DbhXTgdFw
         RQmkwWVGpJagFQ3HbGZV43eF7/i2maw+i4K2DQ6xik/+V+0hMEDEviAHPZ0YiI5K8R16
         XEEdj3q61378OqEohorpkIqGtkHSoz6s5ROBZeN6Y8HJUp0oYNaedDf3HZkPMxNUx6D4
         t9/y/BBIip0BWx53LfkvPTut0OGd48Io65ceHvgPg9Ux4isZ9fxJvG5k9wgh8bj5vr/+
         0QkRxvwJ/4s3D7yiig3CTBx1Rx0DyefLu+jV8+WJOh28ecpJILiHrXTNZBn1FwN/uTlV
         IJCQ==
X-Gm-Message-State: AJcUukcWTB1+ACLPYBjrnHkyToNVkfPiGVxz78V/8YVcOO5eq0AXM95q
        PiWmDXyBLS7ydAJE70mJNkdQNg==
X-Google-Smtp-Source: ALg8bN4n0aY4sIFr9aOTHAObxjfAV5uFAdVbQho4PJFipPvitTEMqaOopdk8YRL6uQSH9O3UEtCbhw==
X-Received: by 2002:a17:902:20b:: with SMTP id 11mr13180587plc.57.1545661617675;
        Mon, 24 Dec 2018 06:26:57 -0800 (PST)
Received: from localhost.localdomain (23-24-209-193-static.hfc.comcastbusiness.net. [23.24.209.193])
        by smtp.gmail.com with ESMTPSA id x3sm101731522pgt.45.2018.12.24.06.26.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Dec 2018 06:26:56 -0800 (PST)
From:   Greg Hackmann <ghackmann@android.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Omer Tripp <trippo@google.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        Greg Hackmann <ghackmann@android.com>, stable@vger.kernel.org
Subject: [PATCH v2] fs: fix possible Spectre V1 indexing in __close_fd()
Date:   Mon, 24 Dec 2018 06:26:42 -0800
Message-Id: <20181224142642.7385-1-ghackmann@android.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Omer Tripp's analysis of a Spectre V1 gadget in __close_fd():

"1.  __close_fd() is reachable via the close() syscall with a
     user-controlled fd.

 2.  If said bounds check is mispredicted, then a user-controlled
     address fdt->fd[fd] is obtained then dereferenced, and the value of
     a user-controlled address is loaded into the local variable file.

 3.  file is then passed as an argument to filp_close, where the cache
     lines secret + offsetof(f_op) and secret + offsetof(f_mode) are hot
     and vulnerable to a timing channel attack."

Address this by using array_index_nospec() to prevent speculation past
the end of current->fdt.

Reported-by: Omer Tripp <trippo@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Hackmann <ghackmann@android.com>
---
v2: include Omer Tripp's analysis in commit message, and update my email
    address

 fs/file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/file.c b/fs/file.c
index 7ffd6e9d103d..a80cf82be96b 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -18,6 +18,7 @@
 #include <linux/bitops.h>
 #include <linux/spinlock.h>
 #include <linux/rcupdate.h>
+#include <linux/nospec.h>
 
 unsigned int sysctl_nr_open __read_mostly = 1024*1024;
 unsigned int sysctl_nr_open_min = BITS_PER_LONG;
@@ -626,6 +627,7 @@ int __close_fd(struct files_struct *files, unsigned fd)
 	fdt = files_fdtable(files);
 	if (fd >= fdt->max_fds)
 		goto out_unlock;
+	fd = array_index_nospec(fd, fdt->max_fds);
 	file = fdt->fd[fd];
 	if (!file)
 		goto out_unlock;
-- 
2.19.1

