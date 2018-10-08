Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8978C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 935FE2087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MctL3d6w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 935FE2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbeJIBs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:48:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:60684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726522AbeJIBs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:48:26 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C6B92089D;
        Mon,  8 Oct 2018 18:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539023724;
        bh=ZZh6uE9ntjxtCFk8zuMX5UdymPmXX6y1Wy54Znv75bo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MctL3d6wYAY7egng4c0YvcY8wl+sg4a1hNBy2BNPln1N517Eo1Cb60Ay7eL/hVNn0
         dsLInlZ0KdJ8GdP3F6ASfRP5tNic9HyxSTti+DqOK/efqe03t5gEhTJhqrk3NF3TLu
         3UXIVLpfoG18Bs1gZKoxUP74SOBbDt9S0BfsnIU8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        stable@kernel.org, Zubin Mithra <zsm@chromium.org>
Subject: [PATCH 4.4 063/113] ext4: never move the system.data xattr out of the inode body
Date:   Mon,  8 Oct 2018 20:31:04 +0200
Message-Id: <20181008175534.444027719@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175530.864641368@linuxfoundation.org>
References: <20181008175530.864641368@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 8cdb5240ec5928b20490a2bb34cb87e9a5f40226 upstream.

When expanding the extra isize space, we must never move the
system.data xattr out of the inode body.  For performance reasons, it
doesn't make any sense, and the inline data implementation assumes
that system.data xattr is never in the external xattr block.

This addresses CVE-2018-10880

https://bugzilla.kernel.org/show_bug.cgi?id=200005

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
Signed-off-by: Zubin Mithra <zsm@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/xattr.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1386,6 +1386,11 @@ retry:
 		/* Find the entry best suited to be pushed into EA block */
 		entry = NULL;
 		for (; !IS_LAST_ENTRY(last); last = EXT4_XATTR_NEXT(last)) {
+			/* never move system.data out of the inode */
+			if ((last->e_name_len == 4) &&
+			    (last->e_name_index == EXT4_XATTR_INDEX_SYSTEM) &&
+			    !memcmp(last->e_name, "data", 4))
+				continue;
 			total_size =
 			EXT4_XATTR_SIZE(le32_to_cpu(last->e_value_size)) +
 					EXT4_XATTR_LEN(last->e_name_len);


