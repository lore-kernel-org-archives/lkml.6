Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4098462-1520452875-2-18069517625288015099
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
    t=1520452874; b=KrUG6OHClqxuuCqOoe4o3NWKDc+B12OMc3j//Z2k693Wf7+
    PgVoKBZna77NDyl91mkYOfXhVxgPY4yOEFbcOypWatIPAG5yKEdnIoFxAA5UNmpL
    5v2TA/p6llLvEHo8vmz0DSQmtQCtRey0fMl6rd85G+29BQacBq/dxWcuA6/JbDsf
    ZIYwpz7VtVJ/jNlHu7PbD1B8cp73kPmgDMD1sqxXkfpN3LakiGxRdwHah9FhSmRt
    7FBYHjYJrq48wK/O6jQBcT5AKNgjZfRzX9lTu5f61/rzsgx9WJ/91x0aCiiDW5xj
    /nodQvYn6nooGijD18kg6SCwQlWaczP+Nk2TfSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520452874; bh=rehVNyzVcPSGrOUWrztU300cWB
    Uh8toLdmIb6XoMjWA=; b=Z5huTyuiAe32q8II4EQRwFXX/RjzrNv9mhwUhGCM0B
    U+U0JHE0yHZ0DiVO6jFNodHm3xYmwXyPg6iLpXa3F8x3BdaBR1ZXArCc4DdH7U/N
    dMO7zOCrVcOIlbfYt9WJtJXrM0VCJ7Mmnz0SkLzCCuKLt4Yf+GYU1Ge0eqWeo7wK
    UFVAkoz5BFwelrkccnLZiHmioKAqhxMgZIufxAjMedH4b9fDG47hYMscQ3i6dkTi
    LxWserg5+KEYSshuqBu/pBkoWvZVcmru0p5ypGd3hzXkNeKb+3gQHcEz/2cEvwXN
    PxjNq49nJrRJ8KxMqHFd3LxFXHThXM5Sm9qwO1he/v6w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
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
        id S965647AbeCGTrA (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 14:47:00 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44842 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965642AbeCGTq7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 14:46:59 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ursula Braun <ubraun@linux.vnet.ibm.com>,
        Julian Wiedmann <jwi@linux.vnet.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 075/110] s390/qeth: fix underestimated count of buffer elements
Date: Wed,  7 Mar 2018 11:38:58 -0800
Message-Id: <20180307191049.269265984@linuxfoundation.org>
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

From: Ursula Braun <ubraun@linux.vnet.ibm.com>


[ Upstream commit 89271c65edd599207dd982007900506283c90ae3 ]

For a memory range/skb where the last byte falls onto a page boundary
(ie. 'end' is of the form xxx...xxx001), the PFN_UP() part of the
calculation currently doesn't round up to the next PFN due to an
off-by-one error.
Thus qeth believes that the skb occupies one page less than it
actually does, and may select a IO buffer that doesn't have enough spare
buffer elements to fit all of the skb's data.
HW detects this as a malformed buffer descriptor, and raises an
exception which then triggers device recovery.

Fixes: 2863c61334aa ("qeth: refactor calculation of SBALE count")
Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/net/qeth_core.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -834,7 +834,7 @@ struct qeth_trap_id {
  */
 static inline int qeth_get_elements_for_range(addr_t start, addr_t end)
 {
-	return PFN_UP(end - 1) - PFN_DOWN(start);
+	return PFN_UP(end) - PFN_DOWN(start);
 }
 
 static inline int qeth_get_micros(void)
