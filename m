Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1546708-1519219198-2-5748594149570884345
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519219198; b=MLj6xOqi69JwYGBVbyzG6LtJJWrmj4gX8yOJiovlwGIhEJB
    cCQipnLTcup6wbMlYUFi2djMJrkHAdmZLxYFrAuc8mvUV4nIyp7iHYq/B3F7UxJe
    ysPebRtr6UUBOUzPe3oa2WZyxMZONjxzcoDy+HtIBrTlDjBNImWvDPs9IDHmWWz0
    YhhnYxqT+mLqQF9mdIAtkkJc+KOyzgJBk8t+U4dVPiHV6ZzPVb0ErOc6J7z2Kaap
    NCK85s4Y1KIBLzRKz2oHB+6Iq0Ban/H6jpDjqJBh/FBU9qrER5KuF39dIJA5LhY5
    UsAuAgpyd7gQ4KII6fAp9T6AsUjUDwJ01wmpv5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519219198; bh=MY/P3unxPBbIzyhlt4WbutU2M7
    OQkcfLMQiZ3COd8ik=; b=I1IsKvaKfincR4G7YGkr352khl3b/OR1UtvP4O1K/t
    CO0UZmCCTl9PoEHG6qSn1R98zaK8UegMXp7/6t+auGorT8c6zHM8/rmdLo39Kzxg
    WqTSHP4yT5pMtQaarQo3jjpcAQXGuJMlRcR6ZB/zK8Vyxak5iIMzKa/cSQrMnpN6
    aTkuHIsQLSMeMCCWcUwI//PPRn3Bv6mPgFW3gvWMuma5fSBRaAemIYf2LXMqIQig
    GBRx1l1SH/4uop2BdepiFGCkRRB+brxvypwxHwOmiCGd58Urrf5Qyz/TNp6BEzhr
    Wg5aFpo9T2wLVpjaskJpACeTI8UercfXc38AuDXwjv9g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754048AbeBUNT2 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 08:19:28 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45628 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752558AbeBUNMX (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 08:12:23 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.15 131/163] blk-wbt: account flush requests correctly
Date: Wed, 21 Feb 2018 13:49:20 +0100
Message-Id: <20180221124537.408578112@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jens Axboe <axboe@kernel.dk>

commit 5235553d821433e1f4fa720fd025d2c4b7ee9994 upstream.

Mikulas reported a workload that saw bad performance, and figured
out what it was due to various other types of requests being
accounted as reads. Flush requests, for instance. Due to the
high latency of those, we heavily throttle the writes to keep
the latencies in balance. But they really should be accounted
as writes.

Fix this by checking the exact type of the request. If it's a
read, account as a read, if it's a write or a flush, account
as a write. Any other request we disregard. Previously everything
would have been mistakenly accounted as reads.

Reported-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org # v4.12+
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/blk-wbt.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -697,7 +697,15 @@ u64 wbt_default_latency_nsec(struct requ
 
 static int wbt_data_dir(const struct request *rq)
 {
-	return rq_data_dir(rq);
+	const int op = req_op(rq);
+
+	if (op == REQ_OP_READ)
+		return READ;
+	else if (op == REQ_OP_WRITE || op == REQ_OP_FLUSH)
+		return WRITE;
+
+	/* don't account */
+	return -1;
 }
 
 int wbt_init(struct request_queue *q)
