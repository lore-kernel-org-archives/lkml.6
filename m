Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1133089-1521805059-2-8638600138019252100
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521805058; b=e0FZ/QhE3EJbZoIqnJr7OCO2NnAWZwZNRNse4pe2mbZBG47
    +FwtNvKzlHiL8kw0p8dFvHATjSLKZiwhGFbG6yi2MT0NQjKWAnAEv453ZOu1Acii
    AcKmkbzA+na/MLmL9BsczMKnho+lLWFhXjrUxovzTbmmA6i8Ow3rhbslKjEeTZcH
    F7JA5BbMle86ZrzPafhxfYz9vruMeFw75oQazYVfy32VvnYAXB7ndFenzUPxF8g9
    +qBgNdRqHd+dqhuCUSe6VAM4TA4zIVHT5dg5E3lzvovCw1DXgV+gjydInUvH8eJz
    ARJS2z2uKi0inVogNf36CiaApq9IXggFMuXnD+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521805058; bh=7mP4wQ00Qq0tUuJKV3ua6yq/bl
    GMPyEb+ndDWUaAdvU=; b=T3tHTU4CB5soSpYVNh04XSaeWp5QhGoLOfwQK2io3z
    ABpd/7bqHGsIlMF30iiyOlG0nhHtj/T2HUID82lT9c5f9H5HrdUTsD+2scjFML3i
    tA5gaStRDKR6jI40vUO5CG4yHlqo7lwQUBLEAnT+VxcmxLYgNhhNEMjFCkmLW06d
    bC02OdmxjB+nqlpacu2Wnk8ykmvE9kGq0vLuVPM07qIMV93VLkGu867tsBZa3vTj
    p4fEJpFin/FbEHBLHRHntMC7fsjJrSoOcNhFGbxAeGwMmEhtcYS/MSPyMg8AOVWF
    4oQM7UkpelESePCqNl+ULcN5nRzpTay31RYMtdqxs91A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754747AbeCWKEw (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:04:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39304 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754389AbeCWKEs (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:04:48 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adam Borowski <kilobyte@angband.pl>,
        Liu Bo <bo.li.liu@oracle.com>, David Sterba <dsterba@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 023/177] btrfs: fix a bogus warning when converting only data or metadata
Date: Fri, 23 Mar 2018 10:52:31 +0100
Message-Id: <20180323094206.211588633@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
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

From: Adam Borowski <kilobyte@angband.pl>


[ Upstream commit 14506127979a5a3d0c5d9b4cc76ce9d4ec23b717 ]

If your filesystem has, eg, data:raid0 metadata:raid1, and you run "btrfs
balance -dconvert=raid1", the meta.target field will be uninitialized.
That's otherwise ok, as it's unused except for this warning.

Thus, let's use the existing set of raid levels for the comparison.

As a side effect, non-convert balances will now nag about data>metadata.

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
Reviewed-by: Liu Bo <bo.li.liu@oracle.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/volumes.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3765,6 +3765,7 @@ int btrfs_balance(struct btrfs_balance_c
 		  struct btrfs_ioctl_balance_args *bargs)
 {
 	struct btrfs_fs_info *fs_info = bctl->fs_info;
+	u64 meta_target, data_target;
 	u64 allowed;
 	int mixed = 0;
 	int ret;
@@ -3861,11 +3862,16 @@ int btrfs_balance(struct btrfs_balance_c
 		}
 	} while (read_seqretry(&fs_info->profiles_lock, seq));
 
-	if (btrfs_get_num_tolerated_disk_barrier_failures(bctl->meta.target) <
-		btrfs_get_num_tolerated_disk_barrier_failures(bctl->data.target)) {
+	/* if we're not converting, the target field is uninitialized */
+	meta_target = (bctl->meta.flags & BTRFS_BALANCE_ARGS_CONVERT) ?
+		bctl->meta.target : fs_info->avail_metadata_alloc_bits;
+	data_target = (bctl->data.flags & BTRFS_BALANCE_ARGS_CONVERT) ?
+		bctl->data.target : fs_info->avail_data_alloc_bits;
+	if (btrfs_get_num_tolerated_disk_barrier_failures(meta_target) <
+		btrfs_get_num_tolerated_disk_barrier_failures(data_target)) {
 		btrfs_warn(fs_info,
 			   "metadata profile 0x%llx has lower redundancy than data profile 0x%llx",
-			   bctl->meta.target, bctl->data.target);
+			   meta_target, data_target);
 	}
 
 	if (bctl->sys.flags & BTRFS_BALANCE_ARGS_CONVERT) {
