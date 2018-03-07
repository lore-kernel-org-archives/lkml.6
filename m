Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4098462-1520452705-2-12805175520659261430
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
    t=1520452705; b=WmFLJHxTzwBT50I5bDE1K2SBIqwWfy+VeoPCspTvwl5Cabv
    Wvti1RV++36f6HyLyX92mJw0cLXK71+uw2gcPhVZxt113HP2Lu1n13aXHSMQEM4+
    nYlkCoLMfbFXUmG5lw4VU9cq90cs7kj6Obu0KjYaE15tj5dIUE20MWohvBQPt3KN
    uAtfPG4YAE4OwIQpPN5GrnTmQr9TVCXH4szZpu5LHpHaIwI+MnqO+XoZeHbP3jMT
    dCkFBEIc9HlT9z9IfPf+noku2xPi/F2azpA62wNZrDbrFGZdPe3qMY9C9K/p6PWh
    7mgkkFoYVqzmItRL6JKH2D5i7m8zvwdt6yNxO3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520452705; bh=onZitOd7hAZgpZu5kJs3CVJjP7
    7iiUpaejuvvtZZ1/M=; b=wpTJNA+GUjAWSSJdh2g7tiC8nOnrN3F5J0Yv4Zvccr
    /fmjmvhACpHCuLPNoMcd0EXjBvVroqf0nEgGb+53nDAkBb6u1z6FAU62rsb1fCGI
    WTL0R9pFSDUyCV4Isa3vzEhpWjk+0/m6VQfbjXB3Ze3RSmqo/ohSXjrA1lNE1Myz
    1ajFUqak1e3CLgZof7eaOvh+/2BgWTWambrOuqTczVRWQxBnWHokVGcnaLnjq4VM
    adJpfrrd5TrTDRMqZGjdeJZ1k3GhcyqHx+NDg4ToG6yHk8NEVfSiFePkudyhBb4V
    fvqZEV2eeoZDuu04k/qp2GOLXPbol3CtsJ/rFGoCruDg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
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
        id S965690AbeCGTrM (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 14:47:12 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44898 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965684AbeCGTrL (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 14:47:11 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julian Wiedmann <jwi@linux.vnet.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 079/110] s390/qeth: fix double-free on IP add/remove race
Date: Wed,  7 Mar 2018 11:39:02 -0800
Message-Id: <20180307191049.893684570@linuxfoundation.org>
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


[ Upstream commit 14d066c3531a87f727968cacd85bd95c75f59843 ]

Registering an IPv4 address with the HW takes quite a while, so we
temporarily drop the ip_htable lock. Any concurrent add/remove of the
same IP adjusts the IP's use count, and (on remove) is then blocked by
addr->in_progress.
After the register call has completed, we check the use count for
concurrently attempted add/remove calls - and possibly straight-away
deregister the IP again. This happens via l3_delete_ip(), which
1) looks up the queried IP in the htable (getting a reference to the
   *same* queried object),
2) deregisters the IP from the HW, and
3) frees the IP object.

The caller in l3_add_ip() then does a second free on the same object.

For this case, skip all the extra checks and lookups in l3_delete_ip()
and just deregister & free the IP object ourselves.

Fixes: 5f78e29ceebf ("qeth: optimize IP handling in rx_mode callback")
Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/net/qeth_l3_main.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -319,7 +319,8 @@ int qeth_l3_add_ip(struct qeth_card *car
 				(rc == IPA_RC_LAN_OFFLINE)) {
 			addr->disp_flag = QETH_DISP_ADDR_DO_NOTHING;
 			if (addr->ref_counter < 1) {
-				qeth_l3_delete_ip(card, addr);
+				qeth_l3_deregister_addr_entry(card, addr);
+				hash_del(&addr->hnode);
 				kfree(addr);
 			}
 		} else {
