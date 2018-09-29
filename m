Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD95C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C106206B8
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:59:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C106206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbeI3E3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:29:53 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51605 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726672AbeI3ESY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:24 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N63-0000Gw-3H; Sat, 29 Sep 2018 22:48:19 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5z-0006z8-SD; Sat, 29 Sep 2018 22:48:15 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Tyler Hicks" <tyhicks@canonical.com>,
        "Seth Arnold" <seth.arnold@canonical.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Stefan Bader" <stefan.bader@canonical.com>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.153977661@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 127/131] irda: Only insert new objects into the
 global database via setsockopt
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

The irda_setsockopt() function conditionally allocates memory for a new
self->ias_object or, in some cases, reuses the existing
self->ias_object. Existing objects were incorrectly reinserted into the
LM_IAS database which corrupted the doubly linked list used for the
hashbin implementation of the LM_IAS database. When combined with a
memory leak in irda_bind(), this issue could be leveraged to create a
use-after-free vulnerability in the hashbin list. This patch fixes the
issue by only inserting newly allocated objects into the database.

CVE-2018-6555

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
Reviewed-by: Seth Arnold <seth.arnold@canonical.com>
Reviewed-by: Stefan Bader <stefan.bader@canonical.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/irda/af_irda.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/net/irda/af_irda.c
+++ b/net/irda/af_irda.c
@@ -2053,7 +2053,11 @@ static int irda_setsockopt(struct socket
 			err = -EINVAL;
 			goto out;
 		}
-		irias_insert_object(ias_obj);
+
+		/* Only insert newly allocated objects */
+		if (free_ias)
+			irias_insert_object(ias_obj);
+
 		kfree(ias_opt);
 		break;
 	case IRLMP_IAS_DEL:

