Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD07C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 11:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0C8720836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 11:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VwynEvLR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0C8720836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753987AbeFTLMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 07:12:45 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:28213 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751841AbeFTLMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 07:12:44 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20180620111242epoutp03a5ccde2f2efcab889e13893dc5a98a14~52e11c9yh0079300793epoutp03n
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 11:12:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180620111242epoutp03a5ccde2f2efcab889e13893dc5a98a14~52e11c9yh0079300793epoutp03n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1529493162;
        bh=3FuepOmFb2KY+caor8GLSzWeGZE6U4NZkgQsCUDwbxM=;
        h=From:To:Cc:Subject:Date:References:From;
        b=VwynEvLRrIMvtWHaJRvJ9y95v8EuhXGnmD0pvoEKzPmMuwvaAH27HNin71vEnWwaa
         1n78BCmgjuSYsbeQjQtiCDBl3bM2QDY1B9TROZyTsAunbY476/0dlCC2uIw84P5pOD
         pLlt3g8rXEqWfO/6NMigA1GgaMf72Il/FEx/HKNI=
Received: from epsmges5p2new.samsung.com (unknown [182.195.40.195]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20180620111241epcas5p4f6e0d10c3e9d4f359664b6d18ede5daf~52e0-XRjN1689916899epcas5p44;
        Wed, 20 Jun 2018 11:12:41 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A2.9B.04409.9A63A2B5; Wed, 20 Jun 2018 20:12:41 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20180620111240epcas5p309e7e578ebbc07b00347c3c1d23ab278~52e0B1WnI1857118571epcas5p38;
        Wed, 20 Jun 2018 11:12:40 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180620111240epsmtrp132da57eafdccd322e4ae07ad2a4f1a24~52e0AbwIk1177611776epsmtrp1u;
        Wed, 20 Jun 2018 11:12:40 +0000 (GMT)
X-AuditID: b6c32a4a-abdff70000001139-62-5b2a36a93166
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        42.F1.03632.8A63A2B5; Wed, 20 Jun 2018 20:12:40 +0900 (KST)
Received: from localhost.localdomain (unknown [107.108.92.210]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180620111238epsmtip278fe69f3aca61d56b38e8d98dca35b76~52eyX_snY0059100591epsmtip2p;
        Wed, 20 Jun 2018 11:12:38 +0000 (GMT)
From:   Namit Gupta <gupta.namit@samsung.com>
To:     pmladek@suse.com, sergey.senozhatsky@gmail.com, rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, pankaj.m@samsung.com,
        a.sahrawat@samsung.com, himanshu.m@samsung.com,
        Namit Gupta <gupta.namit@samsung.com>
Subject: [PATCH 1/1] remove unnecessary calls of kmalloc and kfree from
 syslog_print_all.
Date:   Wed, 20 Jun 2018 16:39:11 +0530
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEKsWRmVeSWpSXmKPExsWy7bCmpu5KM61og4lLJC0u7k61OHjgNKvF
        vJbzLBaXd81hs7j3ZiuTxf/HX1kt9nU8YLJY+/kxuwOHx85Zd9k9WvbdYvfo27KK0WP9lqss
        Hp83yQWwRqXaZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl
        5gCdoqRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVYo2NDTSMzQw1zMyAtKmsVZGpkAlCakZ
        3edfMhccka1YsHUyUwPjTLEuRk4OCQETiYML/rF1MXJxCAnsZpR4vXMrE4TziVFi2pJjzCBV
        QgLfGCVWfi2H6Tjx+ApU0V5GiVnzfrJAOF8YJWZP/sYGUsUmoC2x7f9ksG4RAXeJT98/gO1g
        FpjIKDGp6TsTSEJYIFpi+tlDjF2MHBwsAqoSd5pYITbISZw8NpkVpF5CYAKbxIynh8CG8gqU
        SZy9No0FoshF4sTyVkYIW1ji1fEt7BC2lMTL/jZ2iOZmRokVm48yQjhTGCVans+DWmEv8eDG
        UXaQzcwCmhLrd+mDhJkF+CR6fz9hAglLCPBKdLQJQVSrSuy4eoQdIiwtMXu5AUTYQ6Lt13V2
        SAjFStya0884gVFmFsLMBYyMqxglUwuKc9NTi00LjPJSy/WKE3OLS/PS9ZLzczcxgtOTltcO
        xmXnfA4xCnAwKvHwMjBrRguxJpYVV+YeYpTgYFYS4WU4pREtxJuSWFmVWpQfX1Sak1p8iNEU
        GGYTmaVEk/OBqTOvJN7Q1MjMzMDSwNTYwsxQSZz3x3WBaCGB9MSS1OzU1ILUIpg+Jg5OqQbG
        9KSVLEVte6vb7avs+hYu3c9/y1Beeu39bvlpXIXyWfs85K978n6bYrwrUvM6w/TrmXcr+Ncn
        aC6+/NHJk8tg7/3Xi06mtvw90MfP5aNzhJn/1aoN37hNH91/HnC7zVJ/SW/PvofKT3jLTtwR
        1cwXvPPrmO+ZW1NYmH43J6mJC6abf58bl9inxFKckWioxVxUnAgAhQNXUWUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprALMWRmVeSWpSXmKPExsWy7bCSvO4KM61og43zBCwu7k61OHjgNKvF
        vJbzLBaXd81hs7j3ZiuTxf/HX1kt9nU8YLJY+/kxuwOHx85Zd9k9WvbdYvfo27KK0WP9lqss
        Hp83yQWwRnHZpKTmZJalFunbJXBldJ9/yVxwRLZiwdbJTA2MM8W6GDk5JARMJE48vsLUxcjF
        ISSwm1Hi+p87TBAJaYmJzV+YIWxhiZX/nrNDFH1ilLi5+w4LSIJNQFti2//JYEUiAt4SU6//
        YgQpYhaYyijx5OYWsISwQKREf+cuti5GDg4WAVWJO02sIGFeAXeJlvWrGSEWyEmcPDaZdQIj
        zwJGhlWMkqkFxbnpucWGBYZ5qeV6xYm5xaV56XrJ+bmbGMHhpKW5g/HykvhDjAIcjEo8vAzM
        mtFCrIllxZW5hxglOJiVRHgZTmlEC/GmJFZWpRblxxeV5qQWH2KU5mBREud9mncsUkggPbEk
        NTs1tSC1CCbLxMEp1cCYen6ZCp/VKcnlTrbH63eK7ki7NTmH0+CPToACU4n77q+crZJsy9UX
        t7qtVNluX7sqgJHFgyNMvaEhb/X3bWYH3VK1899JMhv/zJtc/ESn7dxOL/NNG8Udupi/LLbN
        Fvy84+u5Pu1n7ZOCjetXz/f6ukPr3gRDjmt+ZqrhXYF6SvvOlwY+s1FiKc5INNRiLipOBAAo
        8JUXIwIAAA==
Message-Id: <20180620111240epcas5p309e7e578ebbc07b00347c3c1d23ab278~52e0B1WnI1857118571epcas5p38@epcas5p3.samsung.com>
X-CMS-MailID: 20180620111240epcas5p309e7e578ebbc07b00347c3c1d23ab278
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180620111240epcas5p309e7e578ebbc07b00347c3c1d23ab278
References: <CGME20180620111240epcas5p309e7e578ebbc07b00347c3c1d23ab278@epcas5p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the request is only for clearing logs, there is no need for buffer allocation.
So, the indexes could be reset and returned. This will save unnecessary kmalloc/kfree 
calls also.


Signed-off-by: Namit Gupta <gupta.namit@samsung.com>
Signed-off-by: Himanshu Maithani <himanshu.m@samsung.com>

---
 kernel/printk/printk.c | 111 ++++++++++++++++++++++++++-----------------------
 1 file changed, 60 insertions(+), 51 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 512f7c2..53952ce 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1348,71 +1348,80 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 {
 	char *text;
 	int len = 0;
+	u64 next_seq;
+	u64 seq;
+	u32 idx;
+
+	if (!buf) {
+		if (clear) {
+			logbuf_lock_irq();
+			clear_seq = log_next_seq;
+			clear_idx = log_next_idx;
+			logbuf_unlock_irq();
+		}
+		return 0;
+	}
+
 
 	text = kmalloc(LOG_LINE_MAX + PREFIX_MAX, GFP_KERNEL);
 	if (!text)
 		return -ENOMEM;
 
 	logbuf_lock_irq();
-	if (buf) {
-		u64 next_seq;
-		u64 seq;
-		u32 idx;
 
-		/*
-		 * Find first record that fits, including all following records,
-		 * into the user-provided buffer for this dump.
-		 */
-		seq = clear_seq;
-		idx = clear_idx;
-		while (seq < log_next_seq) {
-			struct printk_log *msg = log_from_idx(idx);
-
-			len += msg_print_text(msg, true, NULL, 0);
-			idx = log_next(idx);
-			seq++;
-		}
+	/*
+	 * Find first record that fits, including all following records,
+	 * into the user-provided buffer for this dump.
+	 */
+	seq = clear_seq;
+	idx = clear_idx;
+	while (seq < log_next_seq) {
+		struct printk_log *msg = log_from_idx(idx);
 
-		/* move first record forward until length fits into the buffer */
-		seq = clear_seq;
-		idx = clear_idx;
-		while (len > size && seq < log_next_seq) {
-			struct printk_log *msg = log_from_idx(idx);
+		len += msg_print_text(msg, true, NULL, 0);
+		idx = log_next(idx);
+		seq++;
+	}
 
-			len -= msg_print_text(msg, true, NULL, 0);
-			idx = log_next(idx);
-			seq++;
-		}
+	/* move first record forward until length fits into the buffer */
+	seq = clear_seq;
+	idx = clear_idx;
+	while (len > size && seq < log_next_seq) {
+		struct printk_log *msg = log_from_idx(idx);
 
-		/* last message fitting into this dump */
-		next_seq = log_next_seq;
+		len -= msg_print_text(msg, true, NULL, 0);
+		idx = log_next(idx);
+		seq++;
+	}
 
-		len = 0;
-		while (len >= 0 && seq < next_seq) {
-			struct printk_log *msg = log_from_idx(idx);
-			int textlen;
+	/* last message fitting into this dump */
+	next_seq = log_next_seq;
 
-			textlen = msg_print_text(msg, true, text,
-						 LOG_LINE_MAX + PREFIX_MAX);
-			if (textlen < 0) {
-				len = textlen;
-				break;
-			}
-			idx = log_next(idx);
-			seq++;
+	len = 0;
+	while (len >= 0 && seq < next_seq) {
+		struct printk_log *msg = log_from_idx(idx);
+		int textlen;
 
-			logbuf_unlock_irq();
-			if (copy_to_user(buf + len, text, textlen))
-				len = -EFAULT;
-			else
-				len += textlen;
-			logbuf_lock_irq();
+		textlen = msg_print_text(msg, true, text,
+				LOG_LINE_MAX + PREFIX_MAX);
+		if (textlen < 0) {
+			len = textlen;
+			break;
+		}
+		idx = log_next(idx);
+		seq++;
 
-			if (seq < log_first_seq) {
-				/* messages are gone, move to next one */
-				seq = log_first_seq;
-				idx = log_first_idx;
-			}
+		logbuf_unlock_irq();
+		if (copy_to_user(buf + len, text, textlen))
+			len = -EFAULT;
+		else
+			len += textlen;
+		logbuf_lock_irq();
+
+		if (seq < log_first_seq) {
+			/* messages are gone, move to next one */
+			seq = log_first_seq;
+			idx = log_first_idx;
 		}
 	}
 
-- 
1.9.1

