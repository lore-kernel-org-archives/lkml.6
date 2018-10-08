Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC9BC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44208214C5
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQr7PfzE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44208214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732412AbeJICE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:04:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:54952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732400AbeJICE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:04:58 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C73C82087D;
        Mon,  8 Oct 2018 18:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024710;
        bh=yWltL2I//sUrtP59yoy/9lNihw+pB2w3Lonu71H0ngw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AQr7PfzErrLkoy/k4WigrTsbIaq7dIdpD44y/H09XqdMBgvWN6zIVrfSolBZoD/ZK
         sFmL//IXdBMlUGHuZ6Ltu6SBlL7ZyWBht8YwGbBEUncedxQSpTokIF+HpUAOi1z8oe
         S9crYQRu3Vmc71VI4Mbmd6wwlnjiYZjfL/yy3UGo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sami Farin <hvtaifwkbgefbaei@gmail.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 129/168] netfilter: xt_hashlimit: use s->file instead of s->private
Date:   Mon,  8 Oct 2018 20:31:49 +0200
Message-Id: <20181008175624.953245159@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cong Wang <xiyou.wangcong@gmail.com>

[ Upstream commit 1286df269f498165061e0cf8092ca212545dbb5a ]

After switching to the new procfs API, it is supposed to
retrieve the private pointer from PDE_DATA(file_inode(s->file)),
s->private is no longer referred.

Fixes: 1cd671827290 ("netfilter/x_tables: switch to proc_create_seq_private")
Reported-by: Sami Farin <hvtaifwkbgefbaei@gmail.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Acked-by: Christoph Hellwig <hch@lst.de>
Tested-by: Sami Farin <hvtaifwkbgefbaei@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/xt_hashlimit.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

--- a/net/netfilter/xt_hashlimit.c
+++ b/net/netfilter/xt_hashlimit.c
@@ -1057,7 +1057,7 @@ static struct xt_match hashlimit_mt_reg[
 static void *dl_seq_start(struct seq_file *s, loff_t *pos)
 	__acquires(htable->lock)
 {
-	struct xt_hashlimit_htable *htable = PDE_DATA(file_inode(s->private));
+	struct xt_hashlimit_htable *htable = PDE_DATA(file_inode(s->file));
 	unsigned int *bucket;
 
 	spin_lock_bh(&htable->lock);
@@ -1074,7 +1074,7 @@ static void *dl_seq_start(struct seq_fil
 
 static void *dl_seq_next(struct seq_file *s, void *v, loff_t *pos)
 {
-	struct xt_hashlimit_htable *htable = PDE_DATA(file_inode(s->private));
+	struct xt_hashlimit_htable *htable = PDE_DATA(file_inode(s->file));
 	unsigned int *bucket = v;
 
 	*pos = ++(*bucket);
@@ -1088,7 +1088,7 @@ static void *dl_seq_next(struct seq_file
 static void dl_seq_stop(struct seq_file *s, void *v)
 	__releases(htable->lock)
 {
-	struct xt_hashlimit_htable *htable = PDE_DATA(file_inode(s->private));
+	struct xt_hashlimit_htable *htable = PDE_DATA(file_inode(s->file));
 	unsigned int *bucket = v;
 
 	if (!IS_ERR(bucket))
@@ -1130,7 +1130,7 @@ static void dl_seq_print(struct dsthash_
 static int dl_seq_real_show_v2(struct dsthash_ent *ent, u_int8_t family,
 			       struct seq_file *s)
 {
-	struct xt_hashlimit_htable *ht = PDE_DATA(file_inode(s->private));
+	struct xt_hashlimit_htable *ht = PDE_DATA(file_inode(s->file));
 
 	spin_lock(&ent->lock);
 	/* recalculate to show accurate numbers */
@@ -1145,7 +1145,7 @@ static int dl_seq_real_show_v2(struct ds
 static int dl_seq_real_show_v1(struct dsthash_ent *ent, u_int8_t family,
 			       struct seq_file *s)
 {
-	struct xt_hashlimit_htable *ht = PDE_DATA(file_inode(s->private));
+	struct xt_hashlimit_htable *ht = PDE_DATA(file_inode(s->file));
 
 	spin_lock(&ent->lock);
 	/* recalculate to show accurate numbers */
@@ -1160,7 +1160,7 @@ static int dl_seq_real_show_v1(struct ds
 static int dl_seq_real_show(struct dsthash_ent *ent, u_int8_t family,
 			    struct seq_file *s)
 {
-	struct xt_hashlimit_htable *ht = PDE_DATA(file_inode(s->private));
+	struct xt_hashlimit_htable *ht = PDE_DATA(file_inode(s->file));
 
 	spin_lock(&ent->lock);
 	/* recalculate to show accurate numbers */
@@ -1174,7 +1174,7 @@ static int dl_seq_real_show(struct dstha
 
 static int dl_seq_show_v2(struct seq_file *s, void *v)
 {
-	struct xt_hashlimit_htable *htable = PDE_DATA(file_inode(s->private));
+	struct xt_hashlimit_htable *htable = PDE_DATA(file_inode(s->file));
 	unsigned int *bucket = (unsigned int *)v;
 	struct dsthash_ent *ent;
 
@@ -1188,7 +1188,7 @@ static int dl_seq_show_v2(struct seq_fil
 
 static int dl_seq_show_v1(struct seq_file *s, void *v)
 {
-	struct xt_hashlimit_htable *htable = PDE_DATA(file_inode(s->private));
+	struct xt_hashlimit_htable *htable = PDE_DATA(file_inode(s->file));
 	unsigned int *bucket = v;
 	struct dsthash_ent *ent;
 
@@ -1202,7 +1202,7 @@ static int dl_seq_show_v1(struct seq_fil
 
 static int dl_seq_show(struct seq_file *s, void *v)
 {
-	struct xt_hashlimit_htable *htable = PDE_DATA(file_inode(s->private));
+	struct xt_hashlimit_htable *htable = PDE_DATA(file_inode(s->file));
 	unsigned int *bucket = v;
 	struct dsthash_ent *ent;
 


