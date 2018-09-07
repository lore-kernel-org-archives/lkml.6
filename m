Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DABC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E71F62083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:43:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E71F62083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730195AbeIHC0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:26:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56860 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728272AbeIHC0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:26:04 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6A2B5BBF;
        Fri,  7 Sep 2018 21:43:08 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tomas Bortoli <tomasbortoli@gmail.com>,
        syzbot+1a262da37d3bead15c39@syzkaller.appspotmail.com,
        Dominique Martinet <dominique.martinet@cea.fr>
Subject: [PATCH 3.18 14/29] 9p: fix multiple NULL-pointer-dereferences
Date:   Fri,  7 Sep 2018 23:10:35 +0200
Message-Id: <20180907210910.576246097@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210909.523240901@linuxfoundation.org>
References: <20180907210909.523240901@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

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
 3 files changed, 10 insertions(+), 1 deletion(-)

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
@@ -617,6 +617,9 @@ p9_virtio_create(struct p9_client *clien
 	int ret = -ENOENT;
 	int found = 0;
 
+	if (devname == NULL)
+		return -EINVAL;
+
 	mutex_lock(&virtio_9p_lock);
 	list_for_each_entry(chan, &virtio_chan_list, chan_list) {
 		if (!strncmp(devname, chan->tag, chan->tag_len) &&


