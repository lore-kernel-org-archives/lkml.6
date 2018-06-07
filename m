Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id SKHUIjpRGVvEDQAAmS7hNA
	; Thu, 07 Jun 2018 15:39:32 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5CF3D607E7; Thu,  7 Jun 2018 15:39:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SORTED_RECIPS autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E252A601B4;
	Thu,  7 Jun 2018 15:39:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E252A601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935422AbeFGPi4 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:38:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54968 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933039AbeFGPiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:38:52 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 62B3740200A0;
        Thu,  7 Jun 2018 15:38:51 +0000 (UTC)
Received: from redhat.com (ovpn-123-113.rdu2.redhat.com [10.10.123.113])
        by smtp.corp.redhat.com (Postfix) with SMTP id A5ABB2026DEF;
        Thu,  7 Jun 2018 15:38:48 +0000 (UTC)
Date: Thu, 7 Jun 2018 18:38:48 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: syzbot <syzbot+87cfa083e727a224754b@syzkaller.appspotmail.com>
Cc: avagin@openvz.org, davem@davemloft.net, dingtianhong@huawei.com,
        edumazet@google.com, elena.reshetova@intel.com,
        jasowang@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, matthew@mjdsystems.ca,
        mingo@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        virtualization@lists.linux-foundation.org, willemb@google.com
Subject: Re: KMSAN: uninit-value in _copy_to_iter (2)
Message-ID: <20180607183627-mutt-send-email-mst@kernel.org>
References: <000000000000a5b2b1056a86e98c@google.com>
 <000000000000cf4578056ab12452@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000cf4578056ab12452@google.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 07 Jun 2018 15:38:51 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 07 Jun 2018 15:38:51 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz test: https://github.com/google/kmsan.git/master d2d741e5d1898dfde1a75ea3d29a9a3e2edf0617

Subject: vhost: fix info leak

Fixes: CVE-2018-1118
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index f0be5f35ab28..9beefa6ed1ce 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2345,6 +2345,9 @@ struct vhost_msg_node *vhost_new_msg(struct vhost_virtqueue *vq, int type)
 	struct vhost_msg_node *node = kmalloc(sizeof *node, GFP_KERNEL);
 	if (!node)
 		return NULL;
+
+	/* Make sure all padding within the structure is initialized. */
+	memset(&node->msg, 0, sizeof node->msg);
 	node->vq = vq;
 	node->msg.type = type;
 	return node;
