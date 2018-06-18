Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBE0C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E453F20864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:17:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E453F20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934746AbeFRIRO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:17:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53982 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933700AbeFRIRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:17:11 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C6DCBC7A;
        Mon, 18 Jun 2018 08:17:09 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Leech <cleech@redhat.com>,
        Lee Duncan <lduncan@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 051/279] scsi: iscsi: respond to netlink with unicast when appropriate
Date:   Mon, 18 Jun 2018 10:10:36 +0200
Message-Id: <20180618080610.954835497@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chris Leech <cleech@redhat.com>

[ Upstream commit af17092810a887178195276255b7b31f8fbe7dbe ]

Instead of always multicasting responses, send a unicast netlink message
directed at the correct pid.  This will be needed if we ever want to
support multiple userspace processes interacting with the kernel over
iSCSI netlink simultaneously.  Limitations can currently be seen if you
attempt to run multiple iscsistart commands in parallel.

We've fixed up the userspace issues in iscsistart that prevented
multiple instances from running, so now attempts to speed up booting by
bringing up multiple iscsi sessions at once in the initramfs are just
running into misrouted responses that this fixes.

Signed-off-by: Chris Leech <cleech@redhat.com>
Reviewed-by: Lee Duncan <lduncan@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/scsi_transport_iscsi.c |   29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -2322,6 +2322,12 @@ iscsi_multicast_skb(struct sk_buff *skb,
 	return nlmsg_multicast(nls, skb, 0, group, gfp);
 }
 
+static int
+iscsi_unicast_skb(struct sk_buff *skb, u32 portid)
+{
+	return nlmsg_unicast(nls, skb, portid);
+}
+
 int iscsi_recv_pdu(struct iscsi_cls_conn *conn, struct iscsi_hdr *hdr,
 		   char *data, uint32_t data_size)
 {
@@ -2524,14 +2530,11 @@ void iscsi_ping_comp_event(uint32_t host
 EXPORT_SYMBOL_GPL(iscsi_ping_comp_event);
 
 static int
-iscsi_if_send_reply(uint32_t group, int seq, int type, int done, int multi,
-		    void *payload, int size)
+iscsi_if_send_reply(u32 portid, int type, void *payload, int size)
 {
 	struct sk_buff	*skb;
 	struct nlmsghdr	*nlh;
 	int len = nlmsg_total_size(size);
-	int flags = multi ? NLM_F_MULTI : 0;
-	int t = done ? NLMSG_DONE : type;
 
 	skb = alloc_skb(len, GFP_ATOMIC);
 	if (!skb) {
@@ -2539,10 +2542,9 @@ iscsi_if_send_reply(uint32_t group, int
 		return -ENOMEM;
 	}
 
-	nlh = __nlmsg_put(skb, 0, 0, t, (len - sizeof(*nlh)), 0);
-	nlh->nlmsg_flags = flags;
+	nlh = __nlmsg_put(skb, 0, 0, type, (len - sizeof(*nlh)), 0);
 	memcpy(nlmsg_data(nlh), payload, size);
-	return iscsi_multicast_skb(skb, group, GFP_ATOMIC);
+	return iscsi_unicast_skb(skb, portid);
 }
 
 static int
@@ -3470,6 +3472,7 @@ static int
 iscsi_if_recv_msg(struct sk_buff *skb, struct nlmsghdr *nlh, uint32_t *group)
 {
 	int err = 0;
+	u32 portid;
 	struct iscsi_uevent *ev = nlmsg_data(nlh);
 	struct iscsi_transport *transport = NULL;
 	struct iscsi_internal *priv;
@@ -3490,10 +3493,12 @@ iscsi_if_recv_msg(struct sk_buff *skb, s
 	if (!try_module_get(transport->owner))
 		return -EINVAL;
 
+	portid = NETLINK_CB(skb).portid;
+
 	switch (nlh->nlmsg_type) {
 	case ISCSI_UEVENT_CREATE_SESSION:
 		err = iscsi_if_create_session(priv, ep, ev,
-					      NETLINK_CB(skb).portid,
+					      portid,
 					      ev->u.c_session.initial_cmdsn,
 					      ev->u.c_session.cmds_max,
 					      ev->u.c_session.queue_depth);
@@ -3506,7 +3511,7 @@ iscsi_if_recv_msg(struct sk_buff *skb, s
 		}
 
 		err = iscsi_if_create_session(priv, ep, ev,
-					NETLINK_CB(skb).portid,
+					portid,
 					ev->u.c_bound_session.initial_cmdsn,
 					ev->u.c_bound_session.cmds_max,
 					ev->u.c_bound_session.queue_depth);
@@ -3664,6 +3669,8 @@ iscsi_if_recv_msg(struct sk_buff *skb, s
 static void
 iscsi_if_rx(struct sk_buff *skb)
 {
+	u32 portid = NETLINK_CB(skb).portid;
+
 	mutex_lock(&rx_queue_mutex);
 	while (skb->len >= NLMSG_HDRLEN) {
 		int err;
@@ -3699,8 +3706,8 @@ iscsi_if_rx(struct sk_buff *skb)
 				break;
 			if (ev->type == ISCSI_UEVENT_GET_CHAP && !err)
 				break;
-			err = iscsi_if_send_reply(group, nlh->nlmsg_seq,
-				nlh->nlmsg_type, 0, 0, ev, sizeof(*ev));
+			err = iscsi_if_send_reply(portid, nlh->nlmsg_type,
+						  ev, sizeof(*ev));
 		} while (err < 0 && err != -ECONNREFUSED && err != -ESRCH);
 		skb_pull(skb, rlen);
 	}


