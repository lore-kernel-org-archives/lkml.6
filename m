Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DCFC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6B562082F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiw8v5KF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6B562082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbeLCOOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 09:14:50 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37889 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbeLCOOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 09:14:49 -0500
Received: by mail-pg1-f193.google.com with SMTP id g189so5772640pgc.5;
        Mon, 03 Dec 2018 06:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=r+D58vqhoh1PK9pBBnsuKM3XPy+YTPos1Cpkelo8ArQ=;
        b=iiw8v5KF2Di3Lm67csx1jvKUP/vKMEXNRC27Ewx1JbFt67jPECxNgMjMyFbwYO2vMN
         Op3iCcthLh4q07rXVBDjmuPqMCuMpsE4ZYf9CGsgCrlSmyfSlIX8tW7iOBHeuYrbzrsi
         nQ6Jw9PSvU3dMWvBHtnO/mF/Qvqj1mir7h/922NO6PbcZVPX1YADt/knqlPQo4XZpsTG
         usMd6Y9MgqAr4cnkuVmqoC1OiGYToxjbh3v/ffgyc1tTMoCrUax5SD6BoUK+ayv4nPgp
         WSuLLzCV7kolpXUA5XFmpoXZl3E9Nh8E6Y32/IUzmR/6Fp+0Eqb3utWymIdJgG5GLNMd
         EHKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=r+D58vqhoh1PK9pBBnsuKM3XPy+YTPos1Cpkelo8ArQ=;
        b=Wzdq4nCf3Qsil9H4fUI9V3TIsO0meJWZ7ZNnpyrpfTvD5FlojQxHxCikxxhdR2zlty
         tiAlvDGlKMFynLXmUDPyjndIoF1IjstU5wrqvBIA9jGSl2Ne6WEyDFi7eAuwniRsu2SZ
         kTwRtmXiolKl/ZhpALa5QyVIzkSRwjBqJZwEaIaGaHRSol1iyoK2Z2+qT09JJNZ4xsx8
         QHJvfxZM/XklUwMvJPJB5gJRbQ6hGIi6A695FeoBzt/UkyQ1ewIW/WYoOzRl/l+DJYeS
         gPt8Y4wo6J9/BR575kx1i+mpWdNsMf1qKdMRUI1JXmn2j9EXDaBV980OsyIKG1wYegk6
         7nOg==
X-Gm-Message-State: AA+aEWZgUew7vRk2p0Ry3eExGLz2+cU/7B8SYot8sLwyfYci9HARUxSY
        Uo4VYeDeTm9eg2cm+AtbdT8=
X-Google-Smtp-Source: AFSGD/XDP0H9ZfHI1EUjkBdXutbYhceeLEKE87D8FauAw5URK11GcuCUE/Er/2XI+axk0giw/QACig==
X-Received: by 2002:a62:60c5:: with SMTP id u188mr16104283pfb.4.1543846418408;
        Mon, 03 Dec 2018 06:13:38 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id b9sm19205995pfi.118.2018.12.03.06.13.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 06:13:37 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     jakub.kicinski@netronome.com, davem@davemloft.net,
        nick.viljoen@netronome.com, joe@perches.com
Cc:     oss-drivers@netronome.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] nfp: convert to DEFINE_SHOW_ATTRIBUTE
Date:   Mon,  3 Dec 2018 09:13:35 -0500
Message-Id: <20181203141335.12928-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 .../ethernet/netronome/nfp/nfp_net_debugfs.c  | 42 ++++---------------
 1 file changed, 7 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_debugfs.c b/drivers/net/ethernet/netronome/nfp/nfp_net_debugfs.c
index 69b1c9b62e3d..f314cc9966b3 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_debugfs.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_debugfs.c
@@ -8,7 +8,7 @@
 
 static struct dentry *nfp_dir;
 
-static int nfp_net_debugfs_rx_q_read(struct seq_file *file, void *data)
+static int nfp_rx_q_show(struct seq_file *file, void *data)
 {
 	struct nfp_net_r_vector *r_vec = file->private;
 	struct nfp_net_rx_ring *rx_ring;
@@ -65,31 +65,9 @@ static int nfp_net_debugfs_rx_q_read(struct seq_file *file, void *data)
 	rtnl_unlock();
 	return 0;
 }
+DEFINE_SHOW_ATTRIBUTE(nfp_rx_q);
 
-static int nfp_net_debugfs_rx_q_open(struct inode *inode, struct file *f)
-{
-	return single_open(f, nfp_net_debugfs_rx_q_read, inode->i_private);
-}
-
-static const struct file_operations nfp_rx_q_fops = {
-	.owner = THIS_MODULE,
-	.open = nfp_net_debugfs_rx_q_open,
-	.release = single_release,
-	.read = seq_read,
-	.llseek = seq_lseek
-};
-
-static int nfp_net_debugfs_tx_q_open(struct inode *inode, struct file *f);
-
-static const struct file_operations nfp_tx_q_fops = {
-	.owner = THIS_MODULE,
-	.open = nfp_net_debugfs_tx_q_open,
-	.release = single_release,
-	.read = seq_read,
-	.llseek = seq_lseek
-};
-
-static int nfp_net_debugfs_tx_q_read(struct seq_file *file, void *data)
+static int nfp_tx_q_show(struct seq_file *file, void *data)
 {
 	struct nfp_net_r_vector *r_vec = file->private;
 	struct nfp_net_tx_ring *tx_ring;
@@ -157,19 +135,13 @@ static int nfp_net_debugfs_tx_q_read(struct seq_file *file, void *data)
 	rtnl_unlock();
 	return 0;
 }
+DEFINE_SHOW_ATTRIBUTE(nfp_tx_q);
 
-static int nfp_net_debugfs_tx_q_open(struct inode *inode, struct file *f)
+static int nfp_xdp_q_show(struct seq_file *file, void *data)
 {
-	return single_open(f, nfp_net_debugfs_tx_q_read, inode->i_private);
+	return nfp_tx_q_show(file, data);
 }
-
-static const struct file_operations nfp_xdp_q_fops = {
-	.owner = THIS_MODULE,
-	.open = nfp_net_debugfs_tx_q_open,
-	.release = single_release,
-	.read = seq_read,
-	.llseek = seq_lseek
-};
+DEFINE_SHOW_ATTRIBUTE(nfp_xdp_q);
 
 void nfp_net_debugfs_vnic_add(struct nfp_net *nn, struct dentry *ddir)
 {
-- 
2.17.0

