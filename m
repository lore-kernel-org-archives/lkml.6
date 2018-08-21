Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA45AC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 09:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 500BA214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 09:55:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 500BA214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbeHUNOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 09:14:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42708 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726755AbeHUNOs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 09:14:48 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 455D17D84D;
        Tue, 21 Aug 2018 09:55:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-147.rdu2.redhat.com [10.10.123.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B5857112D163;
        Tue, 21 Aug 2018 09:55:18 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 3/6] afs: Move the source fs parameter to the first position
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 21 Aug 2018 10:55:18 +0100
Message-ID: <153484531821.1183.17951530333694057258.stgit@warthog.procyon.org.uk>
In-Reply-To: <153484529922.1183.17405985592221413059.stgit@warthog.procyon.org.uk>
References: <153484529922.1183.17405985592221413059.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 21 Aug 2018 09:55:19 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 21 Aug 2018 09:55:19 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the source fs parameter to the first position in the parameter list,
numerically speaking.  Note that it isn't moved in the key string table as
that's a sorted list.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/super.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/afs/super.c b/fs/afs/super.c
index 7c97836e7937..15c5eb9412bb 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -68,16 +68,16 @@ static struct kmem_cache *afs_inode_cachep;
 static atomic_t afs_count_active_inodes;
 
 enum afs_param {
+	Opt_source,
 	Opt_autocell,
 	Opt_dyn,
-	Opt_source,
 	nr__afs_params
 };
 
 static const struct fs_parameter_spec afs_param_specs[nr__afs_params] = {
+	[Opt_source]	= { fs_param_is_string },
 	[Opt_autocell]	= { fs_param_takes_no_value },
 	[Opt_dyn]	= { fs_param_takes_no_value },
-	[Opt_source]	= { fs_param_is_string },
 };
 
 static const struct constant_table afs_param_keys[] = {
@@ -900,14 +900,6 @@ static int afs_get_fsinfo(struct dentry *dentry, struct fsinfo_kparams *params)
 		if (params->Mth)
 			return -ENODATA;
 		switch (params->Nth) {
-		case Opt_autocell:
-			if (as->autocell)
-				str = "autocell";
-			goto string;
-		case Opt_dyn:
-			if (dyn_root)
-				str = "dyn";
-			goto string;
 		case Opt_source:
 			if (dyn_root)
 				return 0;
@@ -918,6 +910,14 @@ static int afs_get_fsinfo(struct dentry *dentry, struct fsinfo_kparams *params)
 				       volume->type == AFSVL_RWVOL ? "" :
 				       volume->type == AFSVL_ROVOL ? ".readonly" :
 				       ".backup");
+		case Opt_autocell:
+			if (as->autocell)
+				str = "autocell";
+			goto string;
+		case Opt_dyn:
+			if (dyn_root)
+				str = "dyn";
+			goto string;
 		default:
 			return -ENODATA;
 		}

