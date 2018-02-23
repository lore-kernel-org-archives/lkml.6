Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3841409-1519418695-2-7727245463457971659
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
    t=1519418694; b=FcC8sykj5aW0I/ToKPg+wpqHiWbj44ecZZonjjr/ke9nFr9
    msCyJOZCnN9vK5/eXU8e3beanFWDuoavZ4kUb05CDjjO5BjUx/mbySEqN7I7DjR1
    m+o14TKROOn9CliqMZmJKk3xjIlIDZGCOfJYwJyr58/PqzUsRMxXOJEE807kvg+E
    cl8RCQpTBP3tg567zwMvIP2avH8/YQfPE/m31bg2udTWJBgopi4MTGyS94KUOmYz
    8v3+ZmEg2NC7ldnOBTYDKGMPtvMeu8OlNUrfseopTInsmlJ51af4tIJs7frkKlxI
    zLJlCwPdRWIh2BuTjQueyF2dvZ0Z1U/TlNcWvYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519418694; bh=EOqPJetnv3lcSQBScYKksirOCv
    xeI72R1yk8ncOxdLw=; b=v4at4ANZC78mb8GwuN150ayqZl5nELgqjqttCSHbPc
    t7L96Pq5oEI8lbyJxyOQ97oA/LTrUTptIa22yIzsKVIPQbGLzQEmq3wQPfQnhgAF
    YMXoeeaZbi8mHkzp1eDanvcUjxKnAtrNmGu/rC2CiV7vLvQbqbkGf9ldRXrywZH2
    q7MgmWp80HkaAplxDCLBMk8toSr/hdQd4N3aACWCxDB4uJULNZRAnKityOhKV/Nd
    n6/hiKAyoCcvUgSRD2Ab00Kf9lFUNXg9KRpLBKhF2/6Xsu82Q19gd2fS1ZCSszxT
    Ljhq11wttlM3HsSp/pIXcr5jFcGsu7y0l0KPEXcgeDiQ==
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
        id S1752962AbeBWScq (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:32:46 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36304 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752929AbeBWSco (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:32:44 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        David Howells <dhowells@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 49/58] 509: fix printing uninitialized stack memory when OID is empty
Date: Fri, 23 Feb 2018 19:26:48 +0100
Message-Id: <20180223170214.476254669@linuxfoundation.org>
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

From: Eric Biggers <ebiggers3@gmail.com>


[ Upstream commit 8dfd2f22d3bf3ab7714f7495ad5d897b8845e8c1 ]

Callers of sprint_oid() do not check its return value before printing
the result.  In the case where the OID is zero-length, -EBADMSG was
being returned without anything being written to the buffer, resulting
in uninitialized stack memory being printed.  Fix this by writing
"(bad)" to the buffer in the cases where -EBADMSG is returned.

Fixes: 4f73175d0375 ("X.509: Add utility functions to render OIDs as strings")
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/oid_registry.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/lib/oid_registry.c
+++ b/lib/oid_registry.c
@@ -116,7 +116,7 @@ int sprint_oid(const void *data, size_t
 	int count;
 
 	if (v >= end)
-		return -EBADMSG;
+		goto bad;
 
 	n = *v++;
 	ret = count = snprintf(buffer, bufsize, "%u.%u", n / 40, n % 40);
@@ -134,7 +134,7 @@ int sprint_oid(const void *data, size_t
 			num = n & 0x7f;
 			do {
 				if (v >= end)
-					return -EBADMSG;
+					goto bad;
 				n = *v++;
 				num <<= 7;
 				num |= n & 0x7f;
@@ -148,6 +148,10 @@ int sprint_oid(const void *data, size_t
 	}
 
 	return ret;
+
+bad:
+	snprintf(buffer, bufsize, "(bad)");
+	return -EBADMSG;
 }
 EXPORT_SYMBOL_GPL(sprint_oid);
 
