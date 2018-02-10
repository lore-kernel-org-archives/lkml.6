Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751299AbeBJP7h (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 10:59:37 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:41157 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751052AbeBJP7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 10:59:36 -0500
X-Google-Smtp-Source: AH8x224gQOfrPv2duYZCr3h2hDs7w/cSnoG6mngCr9rZwOGBgF+gptONXr8SN+72nGBxobYAZhvT7JGUqsACBgPn1j4=
MIME-Version: 1.0
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Sat, 10 Feb 2018 23:59:14 +0800
Message-ID: <CAErzpmu5o+tLJyY9GqkFEOn=KSs0q9pevCBWcvzpxDyV9RiC_Q@mail.gmail.com>
Subject: [PATCH] seq_file: remove redundant assignment of index to m->index
To: viro@zeniv.linux.org.uk
Cc: linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two redundant assignments in the traverse() function, because
the while loop will break after these two assignments, and after that
the variable index will be assigned to m->index again.

Signed-off-by: Peng Donglin <dolinux.peng@gmail.com>
---
 fs/seq_file.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/seq_file.c b/fs/seq_file.c
index eea09f6..2298656 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -120,14 +120,12 @@ static int traverse(struct seq_file *m, loff_t offset)
         if (pos + m->count > offset) {
             m->from = offset - pos;
             m->count -= m->from;
-            m->index = index;
             break;
         }
         pos += m->count;
         m->count = 0;
         if (pos == offset) {
             index++;
-            m->index = index;
             break;
         }
         p = m->op->next(m, p, &index);
-- 
1.9.1
