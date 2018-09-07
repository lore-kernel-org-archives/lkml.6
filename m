Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9208C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE4720645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:14:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AE4720645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbeIHB5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:57:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42256 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727799AbeIHB5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:57:31 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5850EF07;
        Fri,  7 Sep 2018 21:14:44 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tomas Bortoli <tomasbortoli@gmail.com>,
        syzbot+1a262da37d3bead15c39@syzkaller.appspotmail.com,
        Dominique Martinet <dominique.martinet@cea.fr>
Subject: [PATCH 4.18 050/145] 9p: fix multiple NULL-pointer-dereferences
Date:   Fri,  7 Sep 2018 23:08:36 +0200
Message-Id: <20180907210908.654463762@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210903.617721278@linuxfoundation.org>
References: <20180907210903.617721278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tomas Bortoli <tomasbortoli@gmail.com>

commit 10aa14527f458e9867cf3d2cc6b8cb0f6704448b upstream.

Added checks to prevent GPFs from raising.

Link: http://lkml.kernel.org/r/20180727110558.5479-1-tomasbortoli@gmail.com
Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
Reported-by: syzbot+1a262da37d3bead15c39@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/9p/trans_fd.c     |    5 ++++-
 net/9p/trans_rdma.c   |    3 +++
 net/9p/trans_virtio.c |    3 +++
 net/9p/trans_xen.c    |    3 +++
 4 files changed, 13 insertions(+), 1 deletion(-)

--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -940,7 +940,7 @@ p9_fd_create_tcp(struct p9_client *clien
 	if (err < 0)
 		return err;
 
-	if (valid_ipaddr4(addr) < 0)
+	if (addr == NULL || valid_ipaddr4(addr) < 0)
 		return -EINVAL;
 
 	csocket = NULL;
@@ -990,6 +990,9 @@ p9_fd_create_unix(struct p9_client *clie
 
 	csocket = NULL;
 
+	if (addr == NULL)
+		return -EINVAL;
+
 	if (strlen(addr) >= UNIX_PATH_MAX) {
 		pr_err("%s (%d): address too long: %s\n",
 		       __func__, task_pid_nr(current), addr);
--- a/net/9p/trans_rdma.c
+++ b/net/9p/trans_rdma.c
@@ -644,6 +644,9 @@ rdma_create_trans(struct p9_client *clie
 	struct rdma_conn_param conn_param;
 	struct ib_qp_init_attr qp_attr;
 
+	if (addr == NULL)
+		return -EINVAL;
+
 	/* Parse the transport specific mount options */
 	err = parse_opts(args, &opts);
 	if (err < 0)
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -650,6 +650,9 @@ p9_virtio_create(struct p9_client *clien
 	int ret = -ENOENT;
 	int found = 0;
 
+	if (devname == NULL)
+		return -EINVAL;
+
 	mutex_lock(&virtio_9p_lock);
 	list_for_each_entry(chan, &virtio_chan_list, chan_list) {
 		if (!strncmp(devname, chan->tag, chan->tag_len) &&
--- a/net/9p/trans_xen.c
+++ b/net/9p/trans_xen.c
@@ -94,6 +94,9 @@ static int p9_xen_create(struct p9_clien
 {
 	struct xen_9pfs_front_priv *priv;
 
+	if (addr == NULL)
+		return -EINVAL;
+
 	read_lock(&xen_9pfs_lock);
 	list_for_each_entry(priv, &xen_9pfs_devs, list) {
 		if (!strcmp(priv->tag, addr)) {


