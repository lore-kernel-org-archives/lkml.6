Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24A9C282DB
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE0DD2084A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730275AbfBCOU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:20:56 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55602 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730213AbfBCOUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:20:54 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIdh-0006Mw-Gr; Sun, 03 Feb 2019 14:20:53 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9a-00071u-8y; Sun, 03 Feb 2019 14:49:46 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Pablo Neira Ayuso" <pablo@netfilter.org>,
        "Florian Westphal" <fw@strlen.de>,
        "" <syzbot+0502b00edac2a0680b61@syzkaller.appspotmail.com>,
        "Eric Dumazet" <eric.dumazet@gmail.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.641475682@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 131/305] netfilter: x_tables: add and use
 xt_check_proc_name
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

commit b1d0a5d0cba4597c0394997b2d5fced3e3841b4e upstream.

recent and hashlimit both create /proc files, but only check that
name is 0 terminated.

This can trigger WARN() from procfs when name is "" or "/".
Add helper for this and then use it for both.

Cc: Eric Dumazet <eric.dumazet@gmail.com>
Reported-by: Eric Dumazet <eric.dumazet@gmail.com>
Reported-by: <syzbot+0502b00edac2a0680b61@syzkaller.appspotmail.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
[bwh: Backported to 3.16:
 - xt_hashlimit has only one check function
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/include/linux/netfilter/x_tables.h
+++ b/include/linux/netfilter/x_tables.h
@@ -247,6 +247,8 @@ unsigned int *xt_alloc_entry_offsets(uns
 bool xt_find_jump_offset(const unsigned int *offsets,
 			 unsigned int target, unsigned int size);
 
+int xt_check_proc_name(const char *name, unsigned int size);
+
 int xt_check_match(struct xt_mtchk_param *, unsigned int size, u_int8_t proto,
 		   bool inv_proto);
 int xt_check_target(struct xt_tgchk_param *, unsigned int size, u_int8_t proto,
--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -380,6 +380,36 @@ textify_hooks(char *buf, size_t size, un
 	return buf;
 }
 
+/**
+ * xt_check_proc_name - check that name is suitable for /proc file creation
+ *
+ * @name: file name candidate
+ * @size: length of buffer
+ *
+ * some x_tables modules wish to create a file in /proc.
+ * This function makes sure that the name is suitable for this
+ * purpose, it checks that name is NUL terminated and isn't a 'special'
+ * name, like "..".
+ *
+ * returns negative number on error or 0 if name is useable.
+ */
+int xt_check_proc_name(const char *name, unsigned int size)
+{
+	if (name[0] == '\0')
+		return -EINVAL;
+
+	if (strnlen(name, size) == size)
+		return -ENAMETOOLONG;
+
+	if (strcmp(name, ".") == 0 ||
+	    strcmp(name, "..") == 0 ||
+	    strchr(name, '/'))
+		return -EINVAL;
+
+	return 0;
+}
+EXPORT_SYMBOL(xt_check_proc_name);
+
 int xt_check_match(struct xt_mtchk_param *par,
 		   unsigned int size, u_int8_t proto, bool inv_proto)
 {
--- a/net/netfilter/xt_hashlimit.c
+++ b/net/netfilter/xt_hashlimit.c
@@ -668,8 +668,9 @@ static int hashlimit_mt_check(const stru
 
 	if (info->cfg.gc_interval == 0 || info->cfg.expire == 0)
 		return -EINVAL;
-	if (info->name[sizeof(info->name)-1] != '\0')
-		return -EINVAL;
+	ret = xt_check_proc_name(info->name, sizeof(info->name));
+	if (ret)
+		return ret;
 	if (par->family == NFPROTO_IPV4) {
 		if (info->cfg.srcmask > 32 || info->cfg.dstmask > 32)
 			return -EINVAL;
--- a/net/netfilter/xt_recent.c
+++ b/net/netfilter/xt_recent.c
@@ -355,9 +355,9 @@ static int recent_mt_check(const struct
 			info->hit_count, ip_pkt_list_tot);
 		return -EINVAL;
 	}
-	if (info->name[0] == '\0' ||
-	    strnlen(info->name, XT_RECENT_NAME_LEN) == XT_RECENT_NAME_LEN)
-		return -EINVAL;
+	ret = xt_check_proc_name(info->name, sizeof(info->name));
+	if (ret)
+		return ret;
 
 	mutex_lock(&recent_mutex);
 	t = recent_table_lookup(recent_net, info->name);

