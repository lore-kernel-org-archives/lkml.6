Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CC2C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 795CB216F9
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:48:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 795CB216F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933968AbeFXPsh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:48:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33250 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932073AbeFXPsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:48:35 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A57792C;
        Sun, 24 Jun 2018 15:48:33 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kevin Easton <kevin@guarana.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        syzbot+87cfa083e727a224754b@syzkaller.appspotmail.com
Subject: [PATCH 4.17 68/70] vhost: fix info leak due to uninitialized memory
Date:   Sun, 24 Jun 2018 23:23:00 +0800
Message-Id: <20180624142744.742890010@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180624142740.481662434@linuxfoundation.org>
References: <20180624142740.481662434@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael S. Tsirkin <mst@redhat.com>

commit 670ae9caaca467ea1bfd325cb2a5c98ba87f94ad upstream.

struct vhost_msg within struct vhost_msg_node is copied to userspace.
Unfortunately it turns out on 64 bit systems vhost_msg has padding after
type which gcc doesn't initialize, leaking 4 uninitialized bytes to
userspace.

This padding also unfortunately means 32 bit users of this interface are
broken on a 64 bit kernel which will need to be fixed separately.

Fixes: CVE-2018-1118
Cc: stable@vger.kernel.org
Reported-by: Kevin Easton <kevin@guarana.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reported-by: syzbot+87cfa083e727a224754b@syzkaller.appspotmail.com
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/vhost/vhost.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2345,6 +2345,9 @@ struct vhost_msg_node *vhost_new_msg(str
 	struct vhost_msg_node *node = kmalloc(sizeof *node, GFP_KERNEL);
 	if (!node)
 		return NULL;
+
+	/* Make sure all padding within the structure is initialized. */
+	memset(&node->msg, 0, sizeof node->msg);
 	node->vq = vq;
 	node->msg.type = type;
 	return node;


