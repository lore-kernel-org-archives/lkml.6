Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4469C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88CF32086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:24:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88CF32086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730528AbeICVpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:45:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45518 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729531AbeICVpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:45:30 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 12162D2F;
        Mon,  3 Sep 2018 17:24:23 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wen Xu <wen.xu@gatech.edu>,
        Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.14 105/165] ext4: check for NUL characters in extended attributes name
Date:   Mon,  3 Sep 2018 18:56:31 +0200
Message-Id: <20180903165700.788970414@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165655.003605184@linuxfoundation.org>
References: <20180903165655.003605184@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 7d95178c77014dbd8dce36ee40bbbc5e6c121ff5 upstream.

Extended attribute names are defined to be NUL-terminated, so the name
must not contain a NUL character.  This is important because there are
places when remove extended attribute, the code uses strlen to
determine the length of the entry.  That should probably be fixed at
some point, but code is currently really messy, so the simplest fix
for now is to simply validate that the extended attributes are sane.

https://bugzilla.kernel.org/show_bug.cgi?id=200401

Reported-by: Wen Xu <wen.xu@gatech.edu>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/xattr.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -189,6 +189,8 @@ ext4_xattr_check_entries(struct ext4_xat
 		struct ext4_xattr_entry *next = EXT4_XATTR_NEXT(e);
 		if ((void *)next >= end)
 			return -EFSCORRUPTED;
+		if (strnlen(e->e_name, e->e_name_len) != e->e_name_len)
+			return -EFSCORRUPTED;
 		e = next;
 	}
 


