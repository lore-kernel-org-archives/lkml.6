Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153886-1521805862-2-3850702073954045744
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521805861; b=ZibxNGfkUjAjIo4bHUdDTh7p4x+EEiC5haRAu3X3BUoi+Bp
    1g4lUVsks1MDhNflaXv0Y7e3p4Err8XEf4NtmkJibwHAm9DlS2lZ1/hIz7AOYDR8
    Ra4u+gh+b8LvwkgNUDNdTVQGG0+p4LQB1tQqHiOnbTtBPxBYOWP4N3m/rv1fkYa7
    Le+bjeJoiFfntt2N+VIYe2u2oSvWcnwLV1CT26+IlfwCkj72ccUXC9qRwHfcYe/R
    CR3D6uS2ILbJfLtW3WKDj8SBKsmNCwIOOeWeAH6vKODaPCEswDHzEp4RxgfylcSW
    LdO2PUCp9vRm8XVSerm4btjaGqXEC5gib4znLWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521805861; bh=08ixiMiicwGv4KuupdaCy0WcTs
    Vih/UyHiXRghAl1Mg=; b=tqIcSOHzm7TjlsXROCFkxddFst5/dtfmi8AP4q1PK4
    HzInNksX1A2nSUjgFcJ6yZYMbYx0IPObJGJcoW6hAeZW/ZSsgEUEaHzEVCHu+Kg5
    Y3qok7aJbIfiTZ/NAYcTpygpt+V1tHzsFRL0ESefpMOEQAwsNsRKFc1oQoZcKssq
    HE7QAgeYjZCH1nveXJ4WpB9w9gY8A0WZdWXdOqrpW+kqdgBoxPPDM74bhP9vkz6F
    tWhp9lkg+ls3s9hvKkchqI1q2o6ALKgRbttWiMDZBSvFyBM+yzXsofuAlPLvB0kS
    cAifpZJmWEXttLmbzr2xuV6O0FvCH0iM/SEXoUXuqgrQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754169AbeCWKCT (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:02:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38274 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754167AbeCWKCS (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:02:18 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Erez Shitrit <erezsh@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 35/77] IB/ipoib: Avoid memory leak if the SA returns a different DGID
Date: Fri, 23 Mar 2018 10:54:09 +0100
Message-Id: <20180323094144.608746231@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094142.260022880@linuxfoundation.org>
References: <20180323094142.260022880@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Erez Shitrit <erezsh@mellanox.com>


[ Upstream commit 439000892ee17a9c92f1e4297818790ef8bb4ced ]

The ipoib path database is organized around DGIDs from the LLADDR, but the
SA is free to return a different GID when asked for path. This causes a
bug because the SA's modified DGID is copied into the database key, even
though it is no longer the correct lookup key, causing a memory leak and
other malfunctions.

Ensure the database key does not change after the SA query completes.

Demonstration of the bug is as  follows
ipoib wants to send to GID fe80:0000:0000:0000:0002:c903:00ef:5ee2, it
creates new record in the DB with that gid as a key, and issues a new
request to the SM.
Now, the SM from some reason returns path-record with other SGID (for
example, 2001:0000:0000:0000:0002:c903:00ef:5ee2 that contains the local
subnet prefix) now ipoib will overwrite the current entry with the new
one, and if new request to the original GID arrives ipoib  will not find
it in the DB (was overwritten) and will create new record that in its
turn will also be overwritten by the response from the SM, and so on
till the driver eats all the device memory.

Signed-off-by: Erez Shitrit <erezsh@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/ulp/ipoib/ipoib_main.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -776,6 +776,22 @@ static void path_rec_completion(int stat
 	spin_lock_irqsave(&priv->lock, flags);
 
 	if (!IS_ERR_OR_NULL(ah)) {
+		/*
+		 * pathrec.dgid is used as the database key from the LLADDR,
+		 * it must remain unchanged even if the SA returns a different
+		 * GID to use in the AH.
+		 */
+		if (memcmp(pathrec->dgid.raw, path->pathrec.dgid.raw,
+			   sizeof(union ib_gid))) {
+			ipoib_dbg(
+				priv,
+				"%s got PathRec for gid %pI6 while asked for %pI6\n",
+				dev->name, pathrec->dgid.raw,
+				path->pathrec.dgid.raw);
+			memcpy(pathrec->dgid.raw, path->pathrec.dgid.raw,
+			       sizeof(union ib_gid));
+		}
+
 		path->pathrec = *pathrec;
 
 		old_ah   = path->ah;
