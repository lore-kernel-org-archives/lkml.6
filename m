Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2951739-1517591356-2-4095999515606945114
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enfr,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517591356; b=dztRqknakD3NNGP06tMT+wRz1VbKYLSZC0PSu2TEpppRuQu
    gjXeJnouqs+/rTagdD5r+3VNNLEuuH+Iy43Q0WrFaAiLLC/dJGjmUp7cdDzNnjdt
    /ejT1KsVCqLotG2MyXy1a4GSv6LW8bnTGMxKity1wXcySuan/iU9yM9zyIT3F0PA
    Ssta5bxYBO/PSWdTNJx8p2HO4AXmCTt4eOvpBx82VHEmJyqVdcywC4St8FMJVMwb
    60lsjeuw1Wrb1G+JboD6z6o8DUryWsPciNC6EAAiEXgFQ5T3RAZkICy5PG5iMRWv
    iAItdDTqNPK2HQHs1tdlsE97N4Uk+ttkZwHVbYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591356; bh=DsQTHpx8GJx7/nIW69kAdC5H5+
    dmAwhGpK7MbaNCb+M=; b=VIQpGSifggSWbXem0xHdiVq7j6h3wOkpx9tlhFTYVr
    IprCl/XZb2KPJba7lp5ImPtEAKNNezYceTJvda61NeQrsGEysm7lu3jbyhxUP9Xc
    F4LHMsTrItnPF6tmeNAqADGex2pLvTQ2bOOmImxo87PEUDmQ2+fFncdB672zS8TV
    TQLtz2F5aizU4jf3zX4UBei+elo/5zyU/qxLQY30MNS7spdMLfezLZdIfVDvMR9b
    PzC7qo5DUHWUjuAdn6++nEJoJrt6UxlgrYV/IM2lRAJWWaCZ/6kjCAjuYZiRDANN
    4PpscyuY19ggoY/Gp/Rqh/GPKDepMTLcGKYyC46L3iYg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753137AbeBBRJO (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:09:14 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:37814 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753043AbeBBRJK (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:09:10 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 032/156] btrfs: Fix transaction abort during failure in btrfs_rm_dev_item
Date: Fri,  2 Feb 2018 17:56:53 +0100
Message-Id: <20180202140841.784049008@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nikolay Borisov <nborisov@suse.com>


[ Upstream commit 5e9f2ad5b2904a7e81df6d9a3dbef29478952eac ]

btrfs_rm_dev_item calls several function under an active transaction,
however it fails to abort it if an error happens. Fix this by adding
explicit btrfs_abort_transaction/btrfs_end_transaction calls.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/volumes.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1765,20 +1765,24 @@ static int btrfs_rm_dev_item(struct btrf
 	key.offset = device->devid;
 
 	ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
-	if (ret < 0)
-		goto out;
-
-	if (ret > 0) {
-		ret = -ENOENT;
+	if (ret) {
+		if (ret > 0)
+			ret = -ENOENT;
+		btrfs_abort_transaction(trans, ret);
+		btrfs_end_transaction(trans);
 		goto out;
 	}
 
 	ret = btrfs_del_item(trans, root, path);
-	if (ret)
-		goto out;
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
+		btrfs_end_transaction(trans);
+	}
+
 out:
 	btrfs_free_path(path);
-	btrfs_commit_transaction(trans);
+	if (!ret)
+		ret = btrfs_commit_transaction(trans);
 	return ret;
 }
 
