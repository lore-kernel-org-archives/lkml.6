Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751901AbeCJIw5 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 03:52:57 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:46346 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750829AbeCJIwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 03:52:55 -0500
X-Google-Smtp-Source: AG47ELtUOk4h2800nD9j4YNRS/3qju9DSUkk8FsnweilxaQ1CptZ+9xWWZO8BCFzTqR8W41EdJNq9A==
Date: Sat, 10 Mar 2018 11:52:52 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: viro@zeniv.linux.org.uk
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] seq_file: account everything
Message-ID: <20180310085252.GB17121@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All it takes to open a file and read 1 byte from it.

seq_file will be allocated along with any private allocations,
and more importantly seq file buffer which is 1 page by default.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/seq_file.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -29,7 +29,7 @@ static void seq_set_overflow(struct seq_file *m)
 
 static void *seq_buf_alloc(unsigned long size)
 {
-	return kvmalloc(size, GFP_KERNEL);
+	return kvmalloc(size, GFP_KERNEL_ACCOUNT);
 }
 
 /**
@@ -566,7 +566,7 @@ static void single_stop(struct seq_file *p, void *v)
 int single_open(struct file *file, int (*show)(struct seq_file *, void *),
 		void *data)
 {
-	struct seq_operations *op = kmalloc(sizeof(*op), GFP_KERNEL);
+	struct seq_operations *op = kmalloc(sizeof(*op), GFP_KERNEL_ACCOUNT);
 	int res = -ENOMEM;
 
 	if (op) {
@@ -628,7 +628,7 @@ void *__seq_open_private(struct file *f, const struct seq_operations *ops,
 	void *private;
 	struct seq_file *seq;
 
-	private = kzalloc(psize, GFP_KERNEL);
+	private = kzalloc(psize, GFP_KERNEL_ACCOUNT);
 	if (private == NULL)
 		goto out;
 
@@ -1112,5 +1112,5 @@ EXPORT_SYMBOL(seq_hlist_next_percpu);
 
 void __init seq_file_init(void)
 {
-	seq_file_cache = KMEM_CACHE(seq_file, SLAB_PANIC);
+	seq_file_cache = KMEM_CACHE(seq_file, SLAB_ACCOUNT|SLAB_PANIC);
 }
