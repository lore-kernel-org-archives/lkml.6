Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC33C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED682086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:23:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ED682086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730169AbeICVpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:45:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45436 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727516AbeICVpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:45:00 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4B2CFD24;
        Mon,  3 Sep 2018 17:23:53 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Hurley <john.hurley@netronome.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 062/165] nfp: flower: fix port metadata conversion bug
Date:   Mon,  3 Sep 2018 18:55:48 +0200
Message-Id: <20180903165658.230155897@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165655.003605184@linuxfoundation.org>
References: <20180903165655.003605184@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Hurley <john.hurley@netronome.com>

[ Upstream commit ee614c871014045b45fae149b7245fc22a0bbdd8 ]

Function nfp_flower_repr_get_type_and_port expects an enum nfp_repr_type
return value but, if the repr type is unknown, returns a value of type
enum nfp_flower_cmsg_port_type.  This means that if FW encodes the port
ID in a way the driver does not understand instead of dropping the frame
driver may attribute it to a physical port (uplink) provided the port
number is less than physical port count.

Fix this and ensure a net_device of NULL is returned if the repr can not
be determined.

Fixes: 1025351a88a4 ("nfp: add flower app")
Signed-off-by: John Hurley <john.hurley@netronome.com>
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/netronome/nfp/flower/main.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/netronome/nfp/flower/main.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/main.c
@@ -79,7 +79,7 @@ nfp_flower_repr_get_type_and_port(struct
 			return NFP_REPR_TYPE_VF;
 	}
 
-	return NFP_FLOWER_CMSG_PORT_TYPE_UNSPEC;
+	return __NFP_REPR_TYPE_MAX;
 }
 
 static struct net_device *
@@ -90,6 +90,8 @@ nfp_flower_repr_get(struct nfp_app *app,
 	u8 port = 0;
 
 	repr_type = nfp_flower_repr_get_type_and_port(app, port_id, &port);
+	if (repr_type > NFP_REPR_TYPE_MAX)
+		return NULL;
 
 	reprs = rcu_dereference(app->reprs[repr_type]);
 	if (!reprs)


