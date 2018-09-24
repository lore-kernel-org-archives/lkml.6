Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6DBECE567
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4301B208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:37:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4301B208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbeIXRjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 13:39:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50318 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbeIXRjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 13:39:13 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 69D32106D;
        Mon, 24 Sep 2018 11:37:34 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tyler Hicks <tyhicks@canonical.com>,
        Seth Arnold <seth.arnold@canonical.com>,
        Stefan Bader <stefan.bader@canonical.com>
Subject: [PATCH 3.18 028/105] irda: Fix memory leak caused by repeated binds of irda socket
Date:   Mon, 24 Sep 2018 13:33:14 +0200
Message-Id: <20180924113116.566418010@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113113.268650190@linuxfoundation.org>
References: <20180924113113.268650190@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tyler Hicks <tyhicks@canonical.com>

The irda_bind() function allocates memory for self->ias_obj without
checking to see if the socket is already bound. A userspace process
could repeatedly bind the socket, have each new object added into the
LM-IAS database, and lose the reference to the old object assigned to
the socket to exhaust memory resources. This patch errors out of the
bind operation when self->ias_obj is already assigned.

CVE-2018-6554

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
Reviewed-by: Seth Arnold <seth.arnold@canonical.com>
Reviewed-by: Stefan Bader <stefan.bader@canonical.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/irda/af_irda.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/net/irda/af_irda.c
+++ b/net/irda/af_irda.c
@@ -785,6 +785,13 @@ static int irda_bind(struct socket *sock
 		return -EINVAL;
 
 	lock_sock(sk);
+
+	/* Ensure that the socket is not already bound */
+	if (self->ias_obj) {
+		err = -EINVAL;
+		goto out;
+	}
+
 #ifdef CONFIG_IRDA_ULTRA
 	/* Special care for Ultra sockets */
 	if ((sk->sk_type == SOCK_DGRAM) &&


