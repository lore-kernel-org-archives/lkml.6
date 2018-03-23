Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1098017-1521804170-2-14609813343482828071
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
    t=1521804169; b=jaZUulE+qgqYV/Oz47/akUmfF64jPxPo3VOcKJ417qsYmle
    dFgrSKW0AAsA/8jPz7Imzpyp5vtuzSbb+YSWLUZNYhFBFEEXv6XN/SsLcEs7Wf9f
    Rt6D6E3/fJW/YhXSMpgiCU1iLITCWVO5vHiJH4rR6PeSuaEcdtJv0L/JH5kzWs0U
    cHNn+C2DNXLlx3ADJYykn6MVqHbnr9cQ2bd9/OUuDOKG1zk57U7SVGt3zVVNmhrO
    swXA98xD3z23hlLKsx+G8vjmQDEMHvnAFzFobVZA3o76S/BSMLGtUGK+7UXssJqa
    t7C9jzFwt89C/Q567ZuT2V4E8y/eQ7RlXE8v6yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804169; bh=kdI0BQu38fxa4oO9yGPTzr5eU0
    7cla9PszG5pe2L6Fk=; b=Z+8E40ttaN8whduiNPEpeo2FDvENNGc/qcrrrwUVHH
    WcV6JtIKV2KJYqUMdpDXB9k++NDGd70knEtCuP+qWD4BumqaIGKZelQk4u6xsmN+
    LckNMLwZz3Eflmx3AthytnTmKGP1sDWnv1pRpIHB3PIAwfw8yqzHjQply/vUnXwS
    8EY7hEoi4UgyRMAv8Xx2czFJhSeoEcWYC2q089e/JNLhPM1AA1aXfKV3Ne3Nk4hs
    4pHFM+9gi/uVbKOX5tfNHm78rhZup2XTvCwNrYX4QzL8lpna7y+ZC0HHci2HLigr
    tUbxrtt+kiIk5Whnc4/DP8/Uab0s0wQ9yPamrMd79yUA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
        id S1751730AbeCWLWd (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 07:22:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41576 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755474AbeCWKIK (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:08:10 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        Liu Bo <bo.li.liu@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 077/177] Btrfs: send, fix file hole not being preserved due to inline extent
Date: Fri, 23 Mar 2018 10:53:25 +0100
Message-Id: <20180323094208.708796451@linuxfoundation.org>
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

From: Filipe Manana <fdmanana@suse.com>


[ Upstream commit e1cbfd7bf6dabdac561c75d08357571f44040a45 ]

Normally we don't have inline extents followed by regular extents, but
there's currently at least one harmless case where this happens. For
example, when the page size is 4Kb and compression is enabled:

  $ mkfs.btrfs -f /dev/sdb
  $ mount -o compress /dev/sdb /mnt
  $ xfs_io -f -c "pwrite -S 0xaa 0 4K" -c "fsync" /mnt/foobar
  $ xfs_io -c "pwrite -S 0xbb 8K 4K" -c "fsync" /mnt/foobar

In this case we get a compressed inline extent, representing 4Kb of
data, followed by a hole extent and then a regular data extent. The
inline extent was not expanded/converted to a regular extent exactly
because it represents 4Kb of data. This does not cause any apparent
problem (such as the issue solved by commit e1699d2d7bf6
("btrfs: add missing memset while reading compressed inline extents"))
except trigger an unexpected case in the incremental send code path
that makes us issue an operation to write a hole when it's not needed,
resulting in more writes at the receiver and wasting space at the
receiver.

So teach the incremental send code to deal with this particular case.

The issue can be currently triggered by running fstests btrfs/137 with
compression enabled (MOUNT_OPTIONS="-o compress" ./check btrfs/137).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Liu Bo <bo.li.liu@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/send.c |   23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -5156,13 +5156,19 @@ static int is_extent_unchanged(struct se
 	while (key.offset < ekey->offset + left_len) {
 		ei = btrfs_item_ptr(eb, slot, struct btrfs_file_extent_item);
 		right_type = btrfs_file_extent_type(eb, ei);
-		if (right_type != BTRFS_FILE_EXTENT_REG) {
+		if (right_type != BTRFS_FILE_EXTENT_REG &&
+		    right_type != BTRFS_FILE_EXTENT_INLINE) {
 			ret = 0;
 			goto out;
 		}
 
 		right_disknr = btrfs_file_extent_disk_bytenr(eb, ei);
-		right_len = btrfs_file_extent_num_bytes(eb, ei);
+		if (right_type == BTRFS_FILE_EXTENT_INLINE) {
+			right_len = btrfs_file_extent_inline_len(eb, slot, ei);
+			right_len = PAGE_ALIGN(right_len);
+		} else {
+			right_len = btrfs_file_extent_num_bytes(eb, ei);
+		}
 		right_offset = btrfs_file_extent_offset(eb, ei);
 		right_gen = btrfs_file_extent_generation(eb, ei);
 
@@ -5176,6 +5182,19 @@ static int is_extent_unchanged(struct se
 			goto out;
 		}
 
+		/*
+		 * We just wanted to see if when we have an inline extent, what
+		 * follows it is a regular extent (wanted to check the above
+		 * condition for inline extents too). This should normally not
+		 * happen but it's possible for example when we have an inline
+		 * compressed extent representing data with a size matching
+		 * the page size (currently the same as sector size).
+		 */
+		if (right_type == BTRFS_FILE_EXTENT_INLINE) {
+			ret = 0;
+			goto out;
+		}
+
 		left_offset_fixed = left_offset;
 		if (key.offset < ekey->offset) {
 			/* Fix the right offset for 2a and 7. */
