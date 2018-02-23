Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3723396-1519415748-2-12530859389760981593
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enroca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519415748; b=BQZ1Ux12h6pgvf+CmL+qzDAFWPunPZRLszYNLPXbId5K0zq
    paJJXDcsdKN9m5Os3DRe4e1AsAH2yTe12G0MOFhpwgRNphX9fX+eQBIIPqgvLawM
    HdIT6LtqnEFRL5jDTyKNFUAjkEUlysLLzL4I3oQGfnt/LOS03LDtZH6e7MEjUBDw
    vdanSnP/KLeLI/5CD4+RO1lkxNEuk4ldBoUzOA+hRB6uAe8vCwiKbLpPWinUMT74
    kgX4mWBhDeaIzoIsA3TSBxWUSVToGptQbTBRSnzv6P+ucHyqp9YNkC1zjbtwIoz+
    QL38lU4W91ypcJpgNqiTJ2dTUS1DqHpQNmoecCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519415748; bh=EUaTl+tA4OoF65ivQAYdbLkS1T
    qn/hUjHDyq3WM7G8I=; b=uf9fX+sD+lBIT3ncWvzRig0RrfFOispTgdlTv606tc
    OJwlRbSii8zqEgK2MDmL6ZzMR25gwteWsE1yTiMMpRNp9H119N5gBnNNFUFs1QQq
    fib8PU+cYXrBQ2FSz6XeodsvB0/IolHBMdy+alMECrr47s8IkfEpUtXACaFoIEKb
    0MWXZ4rxMbgvo4KXgQckXWqTEpL+52/37bocRL0BfyngxX/RYNcoJBap67qdB2G2
    XvIkOABZgNszhog2JfUPalyFP9EvTOBVgzTn8WeI9yhtgg3Z1DIbIv4//ycfRnQ+
    zQ9ZicICORbFtBslqkCiVXi+B74DNK7qfg4YOoteZ1FQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933692AbeBWTzc (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 14:55:32 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:43168 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933681AbeBWSo7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:44:59 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Haberland <sth@linux.vnet.ibm.com>,
        Jan Hoeppner <hoeppner@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 062/145] s390/dasd: prevent prefix I/O error
Date: Fri, 23 Feb 2018 19:26:08 +0100
Message-Id: <20180223170732.795025637@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Haberland <sth@linux.vnet.ibm.com>


[ Upstream commit da340f921d3454f1521671c7a5a43ad3331fbe50 ]

Prevent that a prefix flag is set based on invalid configuration data.
The validity.verify_base flag should only be set for alias devices.
Usually the unit address type is either one of base, PAV alias or
HyperPAV alias. But in cases where the unit address type is not set or
any other value the validity.verify_base flag might be set as well.
This would lead to follow on errors.
Explicitly check for alias devices and set the validity flag only for
them.

Signed-off-by: Stefan Haberland <sth@linux.vnet.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/block/dasd_eckd.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -521,10 +521,12 @@ static int prefix_LRE(struct ccw1 *ccw,
 	pfxdata->validity.define_extent = 1;
 
 	/* private uid is kept up to date, conf_data may be outdated */
-	if (startpriv->uid.type != UA_BASE_DEVICE) {
+	if (startpriv->uid.type == UA_BASE_PAV_ALIAS)
 		pfxdata->validity.verify_base = 1;
-		if (startpriv->uid.type == UA_HYPER_PAV_ALIAS)
-			pfxdata->validity.hyper_pav = 1;
+
+	if (startpriv->uid.type == UA_HYPER_PAV_ALIAS) {
+		pfxdata->validity.verify_base = 1;
+		pfxdata->validity.hyper_pav = 1;
 	}
 
 	/* define extend data (mostly)*/
@@ -3471,10 +3473,12 @@ static int prepare_itcw(struct itcw *itc
 	pfxdata.validity.define_extent = 1;
 
 	/* private uid is kept up to date, conf_data may be outdated */
-	if (startpriv->uid.type != UA_BASE_DEVICE) {
+	if (startpriv->uid.type == UA_BASE_PAV_ALIAS)
+		pfxdata.validity.verify_base = 1;
+
+	if (startpriv->uid.type == UA_HYPER_PAV_ALIAS) {
 		pfxdata.validity.verify_base = 1;
-		if (startpriv->uid.type == UA_HYPER_PAV_ALIAS)
-			pfxdata.validity.hyper_pav = 1;
+		pfxdata.validity.hyper_pav = 1;
 	}
 
 	switch (cmd) {
