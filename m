Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3559911-1519410763-2-14125561200838724046
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519410763; b=IGv8yp3ec0eRnvwZP5YmJZCNn4jZ7cKxuDOQeLKuU14vNvR
    BLiorw5CrCJWL0IeqNpBiqu0LTkzcCkCWicd2Z9Zogj1/4VvH9SinI1Bh409oIUC
    zKpCmYHlNKq9urtNMcpZFOQqT84SzsSEdzS9Zkkb0Wh/srqEGIRbhCBmfE9bMTe8
    qI7pOX4BQ0a1MT8WnU3tKqpQ5wAILuEvTenv4+j5HxR7qThCRVwzY/Csv1Nlk0tH
    1EQ+9WAKaa9QM9A1wEf9RULQKn6/fx5M2ycT94VNXuuPKU9eBxczrKMWIFsm+fF1
    mgwFAdKscWn/6NwQj8SceSQoFOEeWrQTXbGu41Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519410763; bh=dRKnNIcU8dSWO+S8R/VgVpGTSj
    h1AzglHzMOc/j7tX0=; b=HznuOZCso3zyIg75tXgP5H5Wcqk3xUrupw83s3jwmt
    Vqwhij34ymJmpONCUz+g3dkNyss79/MlTgMgP8hAaXFVzt6SPVTtv2P4j05BdFq4
    Y6T1Qgchb9MvSuVuVyULm0Zf2ryYugYhfSr4aj5PCS46l7zQ7lgs3NYGzYTi2aAZ
    1cLVRI8/DUxiN5P+6qfaHZPnXcvXdruyC/MC6RhHHU70prpS9pYsK31zptLfEBd3
    21DLQtT8fEZTzYKF9OVfcEdGsF59OZngueOE/7yoxHGoNqvKaM5PYSCvwTcXtfwC
    Lbsi0zihLAVgQS9mMTik9NDY5V5gMLWjguEfd2/lwy0g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752919AbeBWSci (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:32:38 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36234 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752914AbeBWScg (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:32:36 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nogah Frankel <nogahf@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 46/58] net_sched: red: Avoid devision by zero
Date: Fri, 23 Feb 2018 19:26:45 +0100
Message-Id: <20180223170214.013846882@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170206.724655284@linuxfoundation.org>
References: <20180223170206.724655284@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nogah Frankel <nogahf@mellanox.com>


[ Upstream commit 5c472203421ab4f928aa1ae9e1dbcfdd80324148 ]

Do not allow delta value to be zero since it is used as a divisor.

Fixes: 8af2a218de38 ("sch_red: Adaptative RED AQM")
Signed-off-by: Nogah Frankel <nogahf@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/red.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/net/red.h
+++ b/include/net/red.h
@@ -178,7 +178,7 @@ static inline void red_set_parms(struct
 	p->qth_max	= qth_max << Wlog;
 	p->Wlog		= Wlog;
 	p->Plog		= Plog;
-	if (delta < 0)
+	if (delta <= 0)
 		delta = 1;
 	p->qth_delta	= delta;
 	if (!max_P) {
