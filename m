Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C8BC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 822AB20661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:14:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 822AB20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbeLIWOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:14:22 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:38044 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728323AbeLIWOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:14:14 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73F-0002if-LU; Sun, 09 Dec 2018 21:55:49 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72d-0003Nn-7o; Sun, 09 Dec 2018 21:55:11 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        syzbot+1a262da37d3bead15c39@syzkaller.appspotmail.com,
        "Tomas Bortoli" <tomasbortoli@gmail.com>,
        "Dominique Martinet" <dominique.martinet@cea.fr>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.602900197@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 131/328] 9p: fix multiple NULL-pointer-dereferences
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Tomas Bortoli <tomasbortoli@gmail.com>

commit 10aa14527f458e9867cf3d2cc6b8cb0f6704448b upstream.

Added checks to prevent GPFs from raising.

Link: http://lkml.kernel.org/r/20180727110558.5479-1-tomasbortoli@gmail.com
Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
Reported-by: syzbot+1a262da37d3bead15c39@syzkaller.appspotmail.com
Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
[bwh: Backported to 3.16:
 - Drop changes in trans_xen.c
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -934,7 +934,7 @@ p9_fd_create_tcp(struct p9_client *clien
 	if (err < 0)
 		return err;
 
-	if (valid_ipaddr4(addr) < 0)
+	if (addr == NULL || valid_ipaddr4(addr) < 0)
 		return -EINVAL;
 
 	csocket = NULL;
@@ -982,6 +982,9 @@ p9_fd_create_unix(struct p9_client *clie
 
 	csocket = NULL;
 
+	if (addr == NULL)
+		return -EINVAL;
+
 	if (strlen(addr) >= UNIX_PATH_MAX) {
 		pr_err("%s (%d): address too long: %s\n",
 		       __func__, task_pid_nr(current), addr);
--- a/net/9p/trans_rdma.c
+++ b/net/9p/trans_rdma.c
@@ -623,6 +623,9 @@ rdma_create_trans(struct p9_client *clie
 	struct ib_qp_init_attr qp_attr;
 	struct ib_device_attr devattr;
 
+	if (addr == NULL)
+		return -EINVAL;
+
 	/* Parse the transport specific mount options */
 	err = parse_opts(args, &opts);
 	if (err < 0)
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -622,6 +622,9 @@ p9_virtio_create(struct p9_client *clien
 	int ret = -ENOENT;
 	int found = 0;
 
+	if (devname == NULL)
+		return -EINVAL;
+
 	mutex_lock(&virtio_9p_lock);
 	list_for_each_entry(chan, &virtio_chan_list, chan_list) {
 		if (!strncmp(devname, chan->tag, chan->tag_len) &&

