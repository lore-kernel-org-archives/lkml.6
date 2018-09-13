Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8B8C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0F8620C0A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:40:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0F8620C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbeIMSuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:50:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59906 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbeIMSuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:50:15 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0234ED19;
        Thu, 13 Sep 2018 13:40:43 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tyler Hicks <tyhicks@canonical.com>,
        Seth Arnold <seth.arnold@canonical.com>,
        Stefan Bader <stefan.bader@canonical.com>
Subject: [PATCH 4.9 64/78] irda: Only insert new objects into the global database via setsockopt
Date:   Thu, 13 Sep 2018 15:31:51 +0200
Message-Id: <20180913131812.124345947@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131805.732342940@linuxfoundation.org>
References: <20180913131805.732342940@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

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
---
 net/irda/af_irda.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/net/irda/af_irda.c
+++ b/net/irda/af_irda.c
@@ -2023,7 +2023,11 @@ static int irda_setsockopt(struct socket
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


