Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC99C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F2DE20851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="BBwNgxcS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F2DE20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbeKSU4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 15:56:54 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40750 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727947AbeKSU4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 15:56:53 -0500
Received: by mail-pg1-f193.google.com with SMTP id z10so13659674pgp.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 02:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pfk17pduLrrmmy1RCURdhpMiDwOWVPCBsvdRFX8G//Y=;
        b=BBwNgxcS+t4Ebk4vrZvTFSNs9/zXdIwZlcPQhEpiz45Wc4gH408AAAxSOHtCliu4xH
         SXAF2XL0zGSwoyrnyXuQ7QYugfPVeegiZzGw46Az5kSeVVFHgIhy8JDEWYCyEjXrBb0N
         VKsXtzt9w3e1KjAeF3Q5Ztlc27KJ2PGxQLG49xV4ksZiU96hQzaf9unC3scauJShPhdp
         NITbxwTpqa624dT7LpI10mH8/TtxKKYDFwBk0uzCbMKxAHSt0UxPLlxrtSYo9BC+d+gd
         RqcEuFfG0cF7dGGKFhBZHiYA1qqQWlHhHnVRxGLTUXtveEa1rJdhE2tuNBO7V6LNVOHb
         0sFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pfk17pduLrrmmy1RCURdhpMiDwOWVPCBsvdRFX8G//Y=;
        b=tUmy0VrmjYD2v497BZqaYBIlwSQrwRugZCLEsuLcWCrrGaeL77uHM91x8E4jViuOnJ
         kwLfJQnVyWD3deCg0w3VAV76hv5pyHn0VtdGhhEjY2Ge4+1WJAJT/yYw/mszy71Lsiev
         FJGFBce0FuMXXvIeVhdL8UaaLf1AxKXpVOLrRMMPLMzItSFKN8Kw7BmVnkPftk66Ppeg
         n5v56dzqVV2BAyEj/vyETrYKVaOdf4IpNpdxOXSnzxPlbym5HHo6Bpj+wB72AjdgWllL
         R5BYY0RcLjFxP+pfohCMH+rMfeRgXwAPSoIpfrMYx7Kdb8pVB43N5SwJqc33QnkanCnq
         jh4Q==
X-Gm-Message-State: AGRZ1gKfTY84BTA2hWHPWOwEQbK+pjmT7/+VIP2godnEuupnejidZ/hN
        vWIkQdTVxt5bwh7n62OxdeYlvQ==
X-Google-Smtp-Source: AJdET5fineJx07A2aAOW+uwCqOS5ZORJf1bz2v1J9oGk4GcmIQOQgWMpKYd5GdMEyabhHmXHZ8VUoA==
X-Received: by 2002:a62:ed09:: with SMTP id u9-v6mr21926577pfh.188.1542623620044;
        Mon, 19 Nov 2018 02:33:40 -0800 (PST)
Received: from localhost.localdomain ([2404:4404:133a:4500:9d11:de0b:446c:8485])
        by smtp.gmail.com with ESMTPSA id d21sm32958139pgv.37.2018.11.19.02.33.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 02:33:39 -0800 (PST)
From:   Christian Brauner <christian@brauner.io>
To:     ebiederm@xmission.com, linux-kernel@vger.kernel.org
Cc:     serge@hallyn.com, jannh@google.com, luto@kernel.org,
        akpm@linux-foundation.org, oleg@redhat.com, cyphar@cyphar.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, dancol@google.com, timmurray@google.com,
        linux-man@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v1 1/2] proc: get process file descriptor from /proc/<pid>
Date:   Mon, 19 Nov 2018 11:32:38 +0100
Message-Id: <20181119103241.5229-2-christian@brauner.io>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119103241.5229-1-christian@brauner.io>
References: <20181119103241.5229-1-christian@brauner.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With this patch an open() call on /proc/<pid> will give userspace a handle
to struct pid of the process associated with /proc/<pid>. This allows to
maintain a stable handle on a process.
I have been discussing various approaches extensively during technical
conferences this year culminating in a long argument with Eric at Linux
Plumbers. The general consensus was that having a handle on a process
should be something that is very simple and easy to maintain with the
option of being extensible via a more advanced api if the need arises. I
believe that this patch is the most simple, dumb, and therefore
maintainable solution.

[1]: https://lkml.org/lkml/2018/10/30/118

Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Serge Hallyn <serge@hallyn.com>
Cc: Jann Horn <jannh@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Andy Lutomirsky <luto@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Christian Brauner <christian@brauner.io>
---
Changelog:
v1:
- remove ioctl() to signal processes and replace with a dedicated syscall
  in the next patch
---
 fs/proc/base.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index ce3465479447..6365a4fea314 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3032,10 +3032,27 @@ static int proc_tgid_base_readdir(struct file *file, struct dir_context *ctx)
 				   tgid_base_stuff, ARRAY_SIZE(tgid_base_stuff));
 }
 
+static int proc_tgid_open(struct inode *inode, struct file *file)
+{
+	/* grab reference to struct pid and stash the pointer away */
+	file->private_data = get_pid(proc_pid(inode));
+	return 0;
+}
+
+static int proc_tgid_release(struct inode *inode, struct file *file)
+{
+	struct pid *pid = file->private_data;
+	/* drop reference to struct pid */
+	put_pid(pid);
+	return 0;
+}
+
 static const struct file_operations proc_tgid_base_operations = {
+	.open		= proc_tgid_open,
 	.read		= generic_read_dir,
 	.iterate_shared	= proc_tgid_base_readdir,
 	.llseek		= generic_file_llseek,
+	.release	= proc_tgid_release,
 };
 
 static struct dentry *proc_tgid_base_lookup(struct inode *dir, struct dentry *dentry, unsigned int flags)
-- 
2.19.1

