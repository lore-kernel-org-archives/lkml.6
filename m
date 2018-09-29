Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E69FC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 22:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFDE02087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 22:00:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFDE02087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbeI3EaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:30:18 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51608 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727951AbeI3ESX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:23 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N63-0000Gz-2r; Sat, 29 Sep 2018 22:48:19 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5z-0006z0-Qq; Sat, 29 Sep 2018 22:48:15 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Stefan Bader" <stefan.bader@canonical.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Tyler Hicks" <tyhicks@canonical.com>,
        "Seth Arnold" <seth.arnold@canonical.com>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.843558429@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 126/131] irda: Fix memory leak caused by repeated
 binds of irda socket
In-Reply-To: <lsq.1538257386.330095874@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.59-rc1 review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/irda/af_irda.c | 7 +++++++
 1 file changed, 7 insertions(+)

--- a/net/irda/af_irda.c
+++ b/net/irda/af_irda.c
@@ -786,6 +786,13 @@ static int irda_bind(struct socket *sock
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

