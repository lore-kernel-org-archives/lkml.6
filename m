Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1164852-1519981106-2-6842055653409912395
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519981105; b=tzovcSY1rCL4NmeZW+dSOs2xnEh8ixW6okHjhDJ7dBCVknw
    BQE1P12nTfs4TRM1XLmyobyiU2Q89KhDhoL7DsGjKJmdWYjFx1moWvky/iB3mn5x
    Aw1XSw4lOj7vEASSEFBOvxoP8e4OQKW6/M3t2Vnhksm++n3LsEE+nWGvThinqZXZ
    fUnXIXz4BZxhDD7j32o5qP78F8pvj7xNPEFBNqSTFpxETFtT+hSE+rRbHTJfJAJa
    pvpT8hVjE+JnxC55qwvGWgg0z34rU+0MKWYWcEfZ2I6kBSbabSpul93gXvwuITF9
    b+GnS84MoT1Rrr0bdKys8QUAVlN5KcoGswUcmdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519981105; bh=k+jfQfmdO80Vdw9if7nRAm58hq
    whQHif/QU5Cra37B8=; b=XcShRAMIejgh+w9dZ3JrbYN13TgekRK9auBb1ExbtX
    K+Q4sMpErx4OU3js9BE1Vh3eF9/WmcbE01KXO5CO49n+E7Plj673dVFbfuP8kZyO
    9PTiEa2yRd3FR0PooIRaz+JVDYnyNp0G92B8E25O6BoJqnC0b2RYON+aitFRvKXi
    mCHqs/HJ+iS+uDT9x37e9xsU4py4t4FeOBg85BiEXXaLv8YDPb1sMLdE0G/fAju7
    eWtBWQnwczfheon1fthczkH1Ort/zr9+aw6vyPKoH0QnN5EOEOGsw9L5YATUfRQY
    6s7lw8WPZApQdsRjkVnLsagYgCcRsXM4zqTe2gVwOe5g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424201AbeCBI6W (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 03:58:22 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:52666 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424200AbeCBI6S (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 03:58:18 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Venkat Devvuru <venkatkumar.duvvuru@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 47/56] bnxt_en: Fix the Invalid VF id check in bnxt_vf_ndo_prep routine.
Date: Fri,  2 Mar 2018 09:51:33 +0100
Message-Id: <20180302084451.939882994@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084449.568562222@linuxfoundation.org>
References: <20180302084449.568562222@linuxfoundation.org>
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

From: Venkat Duvvuru <venkatkumar.duvvuru@broadcom.com>


[ Upstream commit 78f300049335ae81a5cc6b4b232481dc5e1f9d41 ]

In bnxt_vf_ndo_prep (which is called by bnxt_get_vf_config ndo), there is a
check for "Invalid VF id". Currently, the check is done against max_vfs.
However, the user doesn't always create max_vfs. So, the check should be
against the created number of VFs. The number of bnxt_vf_info structures
that are allocated in bnxt_alloc_vf_resources routine is the "number of
requested VFs". So, if an "invalid VF id" falls between the requested
number of VFs and the max_vfs, the driver will be dereferencing an invalid
pointer.

Fixes: c0c050c58d84 ("bnxt_en: New Broadcom ethernet driver.")
Signed-off-by: Venkat Devvuru <venkatkumar.duvvuru@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
@@ -68,7 +68,7 @@ static int bnxt_vf_ndo_prep(struct bnxt
 		netdev_err(bp->dev, "vf ndo called though sriov is disabled\n");
 		return -EINVAL;
 	}
-	if (vf_id >= bp->pf.max_vfs) {
+	if (vf_id >= bp->pf.active_vfs) {
 		netdev_err(bp->dev, "Invalid VF id %d\n", vf_id);
 		return -EINVAL;
 	}
