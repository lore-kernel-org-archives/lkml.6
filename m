Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2178418-1518719727-2-9153627917463644223
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518719727; b=gGF62NeSoYESCSaT/8AKskH6oydwsEwGEFq1nkQ4eU7Pa2R
    SHbmKWxK5TstuFfh+NTKvDOr4jaT/VrD6XOPs4MNQvf8HFMnQlFt1E1lCUsjjZMn
    +zfli7mgspvheqyXVPKzzEMJSox/ul4el6w6Y0h2FeWZ91sfoxXz91hxwAoXokJt
    oAcEDxqIaGToJXIGp00k+DR7U9So1qa8KCY87wnjYjYQ6Unp8uu3MPJT7q4eYPcr
    3u6lEZoylGRzkae90mwIDqCNrbYR5/aR354cQKmz8HSkyYsU42qv/BOyKsxvDHEf
    jH+vCOV/1HlVqEYsuGS4a7kmpV+Y4dpX/khf3YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518719727; bh=uUOOoB3lmgZha77LGi1Z+PZbnY
    TF9ABvs1yhIkky1p4=; b=f98P53U5hI0bYLZf2P2UY5iEeH1137kJSzAR4WdPIN
    uCgH1KuCkjv37vw+V0ZmPTSCSdEIEWsOyK1j2lErIrTGgsxtjcmN0wf5P+kpOg5h
    sPCG8xTsKOkTPG9rvuonB3hcwOZw8VmSf2/TV8GFZc9F+pO7KbBsjWoPRb7UbYY8
    Plr0LbCwQlcQvpDC0G4xmav7qN38yEw49s4fN4wR9O5j9pmT4SweCGWqVh08sWRj
    qQg6ZXmFl7YbEdND9hn+xlHkCSVOwNKH+qra8MGX4dsWezftvvRtedigpvL82Jo+
    h7TJzbm3XixjjUEsj+pViqfGZdKgOMS6bXdLvKh1kQ7w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162960AbeBOSeP (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 13:34:15 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51942 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162926AbeBOPYk (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:24:40 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Miquel Raynal <miquel.raynal@free-electrons.com>
Subject: [PATCH 4.4 057/108] mtd: nand: sunxi: Fix ECC strength choice
Date: Thu, 15 Feb 2018 16:16:54 +0100
Message-Id: <20180215151230.382173899@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miquel Raynal <miquel.raynal@free-electrons.com>

commit f4c6cd1a7f2275d5bc0e494b21fff26f8dde80f0 upstream.

When the requested ECC strength does not exactly match the strengths
supported by the ECC engine, the driver is selecting the closest
strength meeting the 'selected_strength > requested_strength'
constraint. Fix the fact that, in this particular case, ecc->strength
value was not updated to match the 'selected_strength'.

For instance, one can encounter this issue when no ECC requirement is
filled in the device tree while the NAND chip minimum requirement is not
a strength/step_size combo natively supported by the ECC engine.

Fixes: 1fef62c1423b ("mtd: nand: add sunxi NAND flash controller support")
Suggested-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/sunxi_nand.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -1046,8 +1046,14 @@ static int sunxi_nand_hw_common_ecc_ctrl
 
 	/* Add ECC info retrieval from DT */
 	for (i = 0; i < ARRAY_SIZE(strengths); i++) {
-		if (ecc->strength <= strengths[i])
+		if (ecc->strength <= strengths[i]) {
+			/*
+			 * Update ecc->strength value with the actual strength
+			 * that will be used by the ECC engine.
+			 */
+			ecc->strength = strengths[i];
 			break;
+		}
 	}
 
 	if (i >= ARRAY_SIZE(strengths)) {
