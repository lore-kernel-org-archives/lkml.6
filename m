Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751498AbeFECAx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 22:00:53 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41321 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751297AbeFECAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 22:00:51 -0400
X-Google-Smtp-Source: ADUXVKJmGnvOWMSUOoGrOAimwQnIM+Q8+Q1NcdHq7z7Ju0rVi53E5dqrbDdRC/YLCGWIlSGqLJFvLQ==
From: Ilya Matveychikov <matvejchikov@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: [PATCH] ksys_mount: check for permissions before resource allocation
Message-Id: <D2317950-0DB0-4311-ADB1-FF677B676E04@gmail.com>
Date: Tue, 5 Jun 2018 06:00:47 +0400
To: linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.3445.6.18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w5520vGB001462

Early check for mount permissions prevents possible allocation of 3
pages from kmalloc() pool by unpriveledged user which can be used for
spraying the kernel heap.

Signed-off-by: Ilya V. Matveychikov <matvejchikov@gmail.com>
---
 fs/namespace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index 5f75969adff1..1ef8feb2de2a 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3046,6 +3046,9 @@ int ksys_mount(char __user *dev_name, char __user *dir_name, char __user *type,
 	char *kernel_dev;
 	void *options;

+	if (!may_mount())
+		return -EPERM;
+
 	kernel_type = copy_mount_string(type);
 	ret = PTR_ERR(kernel_type);
 	if (IS_ERR(kernel_type))
--
2.17.0
