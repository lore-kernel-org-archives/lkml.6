Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163486AbeCAXhk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 18:37:40 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38545 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163359AbeCAXhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 18:37:33 -0500
X-Google-Smtp-Source: AG47ELtER6vT/crf3EsWXdCWe9CseY2LtR9iEmx4OcDhAgiseFir0K7RAZuCYWxlYudvBdLvmLTMiQ==
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC 2/5] ia64/sn/hwperf: use seq_open_data
Date: Fri,  2 Mar 2018 00:37:21 +0100
Message-Id: <20180301233724.20440-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180301233724.20440-1-linux@rasmusvillemoes.dk>
References: <20180301233724.20440-1-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code should check the return value of seq_open(); if it failed,
file->private_data is NULL. But we can avoid the issue entirely and
simplify the code by letting seq_open_data() set the ->private member
to objbuf.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 arch/ia64/sn/kernel/sn2/sn_hwperf.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/ia64/sn/kernel/sn2/sn_hwperf.c b/arch/ia64/sn/kernel/sn2/sn_hwperf.c
index 55febd65911a..fba7f3ad99f4 100644
--- a/arch/ia64/sn/kernel/sn2/sn_hwperf.c
+++ b/arch/ia64/sn/kernel/sn2/sn_hwperf.c
@@ -941,14 +941,11 @@ static int sn_hwperf_init(void)
 int sn_topology_open(struct inode *inode, struct file *file)
 {
 	int e;
-	struct seq_file *seq;
 	struct sn_hwperf_object_info *objbuf;
 	int nobj;
 
 	if ((e = sn_hwperf_enum_objects(&nobj, &objbuf)) == 0) {
-		e = seq_open(file, &sn_topology_seq_ops);
-		seq = file->private_data;
-		seq->private = objbuf;
+		e = seq_open_data(file, &sn_topology_seq_ops, objbuf);
 	}
 
 	return e;
-- 
2.15.1
