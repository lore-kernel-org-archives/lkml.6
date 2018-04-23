Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932680AbeDWVkQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 17:40:16 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:46812 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932460AbeDWVj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 17:39:57 -0400
X-Google-Smtp-Source: AIpwx4+vSftqfTafusCb8QGrAGyxSqiDrZ8fdj3X0mGl83Ul55Cy75nsgLadoOacgKE6JBaZirRLzg==
Date: Tue, 24 Apr 2018 00:39:54 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] proc: skip branch in /proc/*/* lookup
Message-ID: <20180423213954.GD9043@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code is structured like this:

	for ( ... p < last; p++) {
		if (memcmp == 0)
			break;
	}
	if (p >= last)
		ERROR
	OK

gcc doesn't see that if if lookup succeeds than post loop branch will
never be taken and skip it.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/base.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2485,14 +2485,11 @@ static struct dentry *proc_pident_lookup(struct inode *dir,
 	for (p = ents; p < last; p++) {
 		if (p->len != dentry->d_name.len)
 			continue;
-		if (!memcmp(dentry->d_name.name, p->name, p->len))
+		if (!memcmp(dentry->d_name.name, p->name, p->len)) {
+			error = proc_pident_instantiate(dir, dentry, task, p);
 			break;
+		}
 	}
-	if (p >= last)
-		goto out;
-
-	error = proc_pident_instantiate(dir, dentry, task, p);
-out:
 	put_task_struct(task);
 out_no_task:
 	return ERR_PTR(error);
