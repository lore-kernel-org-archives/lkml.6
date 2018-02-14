Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2578571-1518606106-2-8015959250901557439
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='at',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518606105; b=J/fgU5abyrF/z4CNJ1pF+TaBywCCfp6qGHX41rLh/uuLZhr
    GzsW0iQpnbJbbe4FwQL+aa9gfbPfwIDhy3PoS0OkanxYWV2LVjfI1hTZVoisdCQR
    g5LUqkaKoTACP46grK+PyHeZJIdHTMeFDCau/kYLZhnOJ0gULYqyMBHrR7QdXUs5
    wGGdpblR6ICgvwGBkZHN04B3nm8JQgpbJ7Bj1w9wXY2bxnwyYH82mnQIGUh11GMu
    UJEsRqsvBmcTEKjQyDRoL7ERYfzncBYzJm6oRvmiodRKb4Ebq4enEFBn5TneWw+A
    Xa+REfmsVbmS4Pw9ph/D1x7rvIPYi4kdKSE7b4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1518606105; bh=FC4iYXWowVl185DDuMFFzdBXvV
    TszOiR5cbtExOxKUs=; b=F0LsO/KIgzU8d6XQ3ghDzCnXJDROhlNnqeqmkClFxr
    /8062svWr0hoUT8w+T1tN0kc+FBqBHM3oIIly8w/rizEjBT0tkTOD+rakazBZeqP
    zAJfckBZk4KPO6ZEKa2xLe0j23NDTFFO/2qQCpwyl18mUNefQfFKpx0QXI3mtEeT
    TGDQZrxIbqr3tbG4P5y2zd0bOkcVIfCHLotOdCszhakCiF6G8zpnaWvBK+PrB455
    3tfMzY14d6XQF65eKFbKwFhKTkWHMNJmiJZ6UpcNDvjkn0ytyEsa5E4cwQDJYMbV
    zpJk4ysXZqAhJd+Lju7BqAQy2tgKnQTe2u/Y5eAsFmlg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=nod.at;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nod.at header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=nod.at;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nod.at header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967240AbeBNLBm (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Feb 2018 06:01:42 -0500
Received: from lilium.sigma-star.at ([109.75.188.150]:47780 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967239AbeBNLBm (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 14 Feb 2018 06:01:42 -0500
From: Richard Weinberger <richard@nod.at>
To: linux-mtd@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        stable@vger.kernel.org
Subject: [PATCH] ubifs: Fix synced_i_size calculation for xattr inodes
Date: Wed, 14 Feb 2018 12:02:48 +0100
Message-Id: <20180214110248.26325-1-richard@nod.at>
X-Mailer: git-send-email 2.13.6
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In ubifs_jnl_update() we sync parent and child inodes to the flash,
in case of xattrs, the parent inode (AKA host inode) has a non-zero
data_len. Therefore we need to adjust synced_i_size too.

This issue was reported by ubifs self tests unter a xattr related work
load.
UBIFS error (ubi0:0 pid 1896): dbg_check_synced_i_size: ui_size is 4, synced_i_size is 0, but inode is clean
UBIFS error (ubi0:0 pid 1896): dbg_check_synced_i_size: i_ino 65, i_mode 0x81a4, i_size 4

Cc: <stable@vger.kernel.org>
Fixes: 1e51764a3c2a ("UBIFS: add new flash file system")
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/ubifs/journal.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
index 04c4ec6483e5..e3e1e093db81 100644
--- a/fs/ubifs/journal.c
+++ b/fs/ubifs/journal.c
@@ -664,6 +664,8 @@ int ubifs_jnl_update(struct ubifs_info *c, const struct inode *dir,
 	finish_reservation(c);
 	spin_lock(&ui->ui_lock);
 	ui->synced_i_size = ui->ui_size;
+	if (xent)
+		host_ui->synced_i_size = host_ui->ui_size;
 	spin_unlock(&ui->ui_lock);
 	mark_inode_clean(c, ui);
 	mark_inode_clean(c, host_ui);
-- 
2.13.6
