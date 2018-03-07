Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4098462-1520452839-2-10469784463858391167
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
    t=1520452839; b=pHZKn9GqIq7P8cnPXHwz65WqKiYWKYVzElkNXot9i9r5RE8
    lFpe+Cdj/efi6tBJ1KXp05Q1weyeZ9isYeka7u+wnxPrlWERO/szmx3CoSx86jdF
    yM5B7YvvQdF9f7ecpv7uLwWELFWop3WKLj2etpuop1xXkMViDtmq/XB4Dw6MwDeu
    wys9VaoNynwhc13mLRaMMu7Z3omTa7zeZqqr4IkOlYphkl59vFIqDj/kzSU8jJln
    tjlpSTbGSxkipLJYGoCvFn+ZknxtomW2b5yCesepTAioVgjBMTHyhjhuqisBeDbF
    uBuViFJOC4Y2MboD2yZj1dHybU7fm4BGapUDm4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520452839; bh=VJcszIFopjX1IjQW49o2atiEt7
    LLHV4FINcodO5REO0=; b=iLRYfFGhtth3l+m0JXtHaeD9OGLq7HDq3VSZIdVmhv
    +6uAtWaryK9MXZok9EwcO/wx9Nut9yBQuAUjH/klHRtPa8m7iy0xqICmpnwACDb/
    ZevAcI+PpDHqeQ5EyYJZ3KVXzgs1FX7+3brG4xqk5lPn2bhDkNzTaH6G74G43t/U
    zbL1LQEYlP4TD2+YM1i0ukXMgQP6P37vJJKefCOg2AtUgZJ3gMZguV6y9kfkYAYd
    pQFjzc1RbLmVd1jDRYoaAFuyzJMCpUSNDxAPLB7BYs6qAw1RUHAuJqfUoLbCinxg
    DWiSYMdMNT0nyJ6CGhR8HGQXcXGGMVaUKYnv+2BE1cCw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
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
        id S965668AbeCGTrG (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 14:47:06 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44868 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754916AbeCGTrE (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 14:47:04 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julian Wiedmann <jwi@linux.vnet.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 077/110] s390/qeth: fix overestimated count of buffer elements
Date: Wed,  7 Mar 2018 11:39:00 -0800
Message-Id: <20180307191049.591681083@linuxfoundation.org>
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

From: Julian Wiedmann <jwi@linux.vnet.ibm.com>


[ Upstream commit 12472af89632beb1ed8dea29d4efe208ca05b06a ]

qeth_get_elements_for_range() doesn't know how to handle a 0-length
range (ie. start == end), and returns 1 when it should return 0.
Such ranges occur on TSO skbs, where the L2/L3/L4 headers (and thus all
of the skb's linear data) are skipped when mapping the skb into regular
buffer elements.

This overestimation may cause several performance-related issues:
1. sub-optimal IO buffer selection, where the next buffer gets selected
   even though the skb would actually still fit into the current buffer.
2. forced linearization, if the element count for a non-linear skb
   exceeds QETH_MAX_BUFFER_ELEMENTS.

Rather than modifying qeth_get_elements_for_range() and adding overhead
to every caller, fix up those callers that are in risk of passing a
0-length range.

Fixes: 2863c61334aa ("qeth: refactor calculation of SBALE count")
Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/net/qeth_core_main.c |   10 ++++++----
 drivers/s390/net/qeth_l3_main.c   |   11 ++++++-----
 2 files changed, 12 insertions(+), 9 deletions(-)

--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -3861,10 +3861,12 @@ EXPORT_SYMBOL_GPL(qeth_get_elements_for_
 int qeth_get_elements_no(struct qeth_card *card,
 		     struct sk_buff *skb, int extra_elems, int data_offset)
 {
-	int elements = qeth_get_elements_for_range(
-				(addr_t)skb->data + data_offset,
-				(addr_t)skb->data + skb_headlen(skb)) +
-			qeth_get_elements_for_frags(skb);
+	addr_t end = (addr_t)skb->data + skb_headlen(skb);
+	int elements = qeth_get_elements_for_frags(skb);
+	addr_t start = (addr_t)skb->data + data_offset;
+
+	if (start != end)
+		elements += qeth_get_elements_for_range(start, end);
 
 	if ((elements + extra_elems) > QETH_MAX_BUFFER_ELEMENTS(card)) {
 		QETH_DBF_MESSAGE(2, "Invalid size of IP packet "
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2633,11 +2633,12 @@ static void qeth_tso_fill_header(struct
 static int qeth_l3_get_elements_no_tso(struct qeth_card *card,
 			struct sk_buff *skb, int extra_elems)
 {
-	addr_t tcpdptr = (addr_t)tcp_hdr(skb) + tcp_hdrlen(skb);
-	int elements = qeth_get_elements_for_range(
-				tcpdptr,
-				(addr_t)skb->data + skb_headlen(skb)) +
-				qeth_get_elements_for_frags(skb);
+	addr_t start = (addr_t)tcp_hdr(skb) + tcp_hdrlen(skb);
+	addr_t end = (addr_t)skb->data + skb_headlen(skb);
+	int elements = qeth_get_elements_for_frags(skb);
+
+	if (start != end)
+		elements += qeth_get_elements_for_range(start, end);
 
 	if ((elements + extra_elems) > QETH_MAX_BUFFER_ELEMENTS(card)) {
 		QETH_DBF_MESSAGE(2,
