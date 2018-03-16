Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3303463-1521214109-2-6900195013505215118
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
    t=1521214109; b=ruy+D/8Wzn6CsEVvt9XDS96Ljjt5lcjCLAftvfZeKFGcp+J
    gJNNoQG//DcNUshMaTgdIesBg7LSfZ6+uNh3nMDmzzHnPddgGpF1DLmii7lls+eB
    9T6gVYxS6WF3AN4HA+OYwu0FPQbc9JeQtKpjARSvmsRr+h2SGKeVlVuoP214txNg
    y1tQ5j+FQXMh82zPvJpOVFkwKHEGaKNTL55mUvmzOi37WxIb1XZKunvi1VwFL+d7
    jgwpGcBMbXKshBImBW/T/ounAir+ET2U2wUxrszBISNgwv9GCKryjcLAPjys/H/E
    KMN+NpBOCawfsKnkc0y+aO25I3tB5BGkEle+kWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521214109; bh=k2fZLwGNh6r2TRSHMyUsXztaDN
    RHYwD2BOhsM2WRUWw=; b=Khp7jgFe2SDzy3HonKWj40/VG5a9NhpyW7cGIaY5rM
    Iw6q3iuCwmH+0WYqHpeo1kQL9SVp4OLJtHhhyUVuAy9iOMqDSFskQWz7HXkFbs00
    BJLf3ot6GxefOX35Jb7lWWOS99wwtcHvK+7/mWKHz5aSN255LXkT3Mat7GNAzxN+
    nlW8KEFo0PNQDLPI34m2d/ucu+1p6LBbUa2yzq2asfcrTlOnEbs2M0hm3XOSG6cP
    s9DfRwn0giwukNtSV9ursA/s5bh0ZfzyNQf3qzySg15Jx0z9qLGxABQ2yLlFyVLa
    tepzaxhxEyOQDNbU6e4JW2l0jYAD26QlKG3TaeuP/Ttw==
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
        id S1754104AbeCPP2Y (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:28:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35280 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932832AbeCPP2X (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:28:23 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>
Subject: [PATCH 4.4 14/63] MIPS: ath25: Check for kzalloc allocation failure
Date: Fri, 16 Mar 2018 16:22:46 +0100
Message-Id: <20180316152301.624796460@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152259.964532775@linuxfoundation.org>
References: <20180316152259.964532775@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King <colin.king@canonical.com>

commit 1b22b4b28fd5fbc51855219e3238b3ab81da8466 upstream.

Currently there is no null check on a failed allocation of board_data,
and hence a null pointer dereference will occurr. Fix this by checking
for the out of memory null pointer.

Fixes: a7473717483e ("MIPS: ath25: add board configuration detection")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 3.19+
Patchwork: https://patchwork.linux-mips.org/patch/18657/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/ath25/board.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/mips/ath25/board.c
+++ b/arch/mips/ath25/board.c
@@ -135,6 +135,8 @@ int __init ath25_find_config(phys_addr_t
 	}
 
 	board_data = kzalloc(BOARD_CONFIG_BUFSZ, GFP_KERNEL);
+	if (!board_data)
+		goto error;
 	ath25_board.config = (struct ath25_boarddata *)board_data;
 	memcpy_fromio(board_data, bcfg, 0x100);
 	if (broken_boarddata) {
