Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4098462-1520453035-2-5634490763809036385
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
    t=1520453034; b=Omsia5te1fBRXcIvzpGF5vJbfwbHkaRO5rxU/7Xmf0zaXhG
    EN49LTyZSg7V9tlFXXY0rLFTlxr0abu48kAgUxkns3pwLLOZiQ5+3YepY7mKK1OG
    kxyyPhiAWlOktdYFs9UXWTC+wW9NnRqp+TFmftYBEhYsrW1JBKKNMmW1ft7CfBhV
    TTbmjsFJ9lCooSXYaPURtB+QVBR51U6LNXFUcMz+qO+PQXXysgbS3aR/s57DsKlM
    bSXmZwOg8DmCnNAUATaX82QPOIrWWVbhyow74uu5xHEBTmRs0XCo3/cf30aLuZq5
    iF28LEM/gR1ZP11WEGdAJX5JaOSyJdN+Ng2I+1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520453034; bh=0931gSh8jsr436Aeq227hdm8VA
    66DFhBQyr8DfFb+Kc=; b=SUET5iQwhdyFxBxBPSZRonuq0aSV1kG983TI+WfbPE
    Tio+ZV3050iyMewzILKY6V1qrsyLqYB+YpHC203qTtvIzl7Oo9sNf93jN+UGZTPH
    4NcRg9dJBdpX+ph5UX7+i4FUOVndNxzWXhUTcvGgzp2Pp+Ahi6UMsZtczFeOKqEh
    HVePD/ObXEWdzUXWJF9vOQ+5YsQXV4y1Nid3V2g6dgDHvfHwLBiPzJFm4K/XE92G
    J5PrHxGfNU6CDH8v//C61JcrtW7syWBv1RNmEvN4MeE1UymoacV88+UsJ8yvOcbQ
    R/DYFuzvlv+a/7l1G3y4InvG9Wqvf/rCcnuCSKPolQVA==
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
        id S965555AbeCGTqe (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 14:46:34 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44644 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965259AbeCGTqc (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 14:46:32 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Kodanev <alexey.kodanev@oracle.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 064/110] sctp: fix dst refcnt leak in sctp_v6_get_dst()
Date: Wed,  7 Mar 2018 11:38:47 -0800
Message-Id: <20180307191047.762065859@linuxfoundation.org>
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

From: Alexey Kodanev <alexey.kodanev@oracle.com>


[ Upstream commit 957d761cf91cdbb175ad7d8f5472336a4d54dbf2 ]

When going through the bind address list in sctp_v6_get_dst() and
the previously found address is better ('matchlen > bmatchlen'),
the code continues to the next iteration without releasing currently
held destination.

Fix it by releasing 'bdst' before continue to the next iteration, and
instead of introducing one more '!IS_ERR(bdst)' check for dst_release(),
move the already existed one right after ip6_dst_lookup_flow(), i.e. we
shouldn't proceed further if we get an error for the route lookup.

Fixes: dbc2b5e9a09e ("sctp: fix src address selection if using secondary addresses for ipv6")
Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/ipv6.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -326,8 +326,10 @@ static void sctp_v6_get_dst(struct sctp_
 		final_p = fl6_update_dst(fl6, rcu_dereference(np->opt), &final);
 		bdst = ip6_dst_lookup_flow(sk, fl6, final_p);
 
-		if (!IS_ERR(bdst) &&
-		    ipv6_chk_addr(dev_net(bdst->dev),
+		if (IS_ERR(bdst))
+			continue;
+
+		if (ipv6_chk_addr(dev_net(bdst->dev),
 				  &laddr->a.v6.sin6_addr, bdst->dev, 1)) {
 			if (!IS_ERR_OR_NULL(dst))
 				dst_release(dst);
@@ -336,8 +338,10 @@ static void sctp_v6_get_dst(struct sctp_
 		}
 
 		bmatchlen = sctp_v6_addr_match_len(daddr, &laddr->a);
-		if (matchlen > bmatchlen)
+		if (matchlen > bmatchlen) {
+			dst_release(bdst);
 			continue;
+		}
 
 		if (!IS_ERR_OR_NULL(dst))
 			dst_release(dst);
