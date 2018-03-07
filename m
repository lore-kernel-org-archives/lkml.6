Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4119318-1520453081-2-5889137002634780423
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
    t=1520453081; b=RM2R5QKszLyN4Z3dJKMpZs7+Dl93Es0DlxjrtjFcMvYJ9Qp
    rSps8N7nac1baJD2KIM08ofg36uZo94Lk0aUSmkEasAgstiWrgQz4jfJfsIYP0sY
    ci38pd6sKexishc427UdfRaZ+MU+YxHi77+EsSGPIyRsH1dCl67UsQ8fSgdTcSff
    W9++YZG49GZE2BvK8sr5UnweKv+d14VPjdpT4SY7Lgb1aDm2nUCECAm6z5HJgduI
    dTO0jI6BvykJvQnBxHMpkA8n8ZmidJgjJhb8otsPKwQTPi/eIroEWaFxjjgmfMY0
    aWaQ+/f6P5IrVFs44OoM0YVaQa0g43BNGKG0v7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520453081; bh=2o6vibiwBSiRe1lwXSJeA5SZRa
    ULBju4INxCj7O5V9c=; b=smxUEDZ32tJaKC7kZnlGboYmsVeZoi/9s7Mv77NswE
    FNQRlgft6trniWkWPR/WTYULEHHMwUXlcvBnw42miSl5Ndj1UDtDFJ8d62M62Epj
    YP7dMhsawrxE6W631bUxuEQ5YghqsXs9F/jaVS3PiRGMpsl9OtX2B0Afvf/Fl6k+
    BO7BoJn+gELpPpYifyQCHkWPktoNLaDGxmcyV4njVjb8zrvw49JwCHiJPhk8OvEY
    4EbEWA/ZH72OYqm+EaPGx5yaaCXOZAWtgDtHX3N7Xywp4pwFknmVPbDoZMdOt7Ac
    30j+/ARRtA0vEYTExc3ZMl+566oxRWZmXlKwUTJ7mEQw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965523AbeCGTqX (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 14:46:23 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44552 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965521AbeCGTqV (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 14:46:21 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wei Chen <weichen@redhat.com>,
        Xin Long <lucien.xin@gmail.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 059/110] sctp: do not pr_err for the duplicated node in transport rhlist
Date: Wed,  7 Mar 2018 11:38:42 -0800
Message-Id: <20180307191047.131907085@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
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

From: Xin Long <lucien.xin@gmail.com>


[ Upstream commit 27af86bb038d9c8b8066cd17854ddaf2ea92bce1 ]

The pr_err in sctp_hash_transport was supposed to report a sctp bug
for using rhashtable/rhlist.

The err '-EEXIST' introduced in Commit cd2b70875058 ("sctp: check
duplicate node before inserting a new transport") doesn't belong
to that case.

So just return -EEXIST back without pr_err any kmsg.

Fixes: cd2b70875058 ("sctp: check duplicate node before inserting a new transport")
Reported-by: Wei Chen <weichen@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/input.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/net/sctp/input.c
+++ b/net/sctp/input.c
@@ -897,15 +897,12 @@ int sctp_hash_transport(struct sctp_tran
 	rhl_for_each_entry_rcu(transport, tmp, list, node)
 		if (transport->asoc->ep == t->asoc->ep) {
 			rcu_read_unlock();
-			err = -EEXIST;
-			goto out;
+			return -EEXIST;
 		}
 	rcu_read_unlock();
 
 	err = rhltable_insert_key(&sctp_transport_hashtable, &arg,
 				  &t->node, sctp_hash_params);
-
-out:
 	if (err)
 		pr_err_once("insert transport fail, errno %d\n", err);
 
