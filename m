Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7270C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA3F121841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216418;
	bh=ylGCu8carYQ079TL1i7emMz73KkhocXSOChmqk16988=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pcelekXnb1vSS3b2jSpuvlX52qCYaQFHqUqDBEXFU/Ma0gzRSfbA8UG1oSL1lEsqO
	 yKdDHrSCQ3OETxDFvqjfPdSToj6MeQOjAHuLVLykBY6nRvneIYQPPzDeBE58IfhcRs
	 1O2AHKSFAEZfFnC82uGW9/PqVmKIxN9KQhlW1jPI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388083AbfAKOUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:20:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:37824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732575AbfAKOUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:20:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E38212183F;
        Fri, 11 Jan 2019 14:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216412;
        bh=ylGCu8carYQ079TL1i7emMz73KkhocXSOChmqk16988=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m0xZ7X+y17pPdsW8g1T5NVkgAvu5SJAgOYS69KKhJXZMge0T+8DbCpwObc4an3f31
         yYpUjH5VsL837TQQrXo2mRrmR7ndLbL/ZmSIHhXaJGO5DazGsFhe/xWsnsfZj6WZiG
         HB2SJxGdWiQe53RynjYWXV+6OTxn7QNj4cPAYJvs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Maurizio Lombardi <mlombard@redhat.com>,
        Theodore Tso <tytso@mit.edu>, stable@kernel.org
Subject: [PATCH 4.4 43/88] ext4: missing unlock/put_page() in ext4_try_to_write_inline_data()
Date:   Fri, 11 Jan 2019 15:08:12 +0100
Message-Id: <20190111131052.454835921@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131045.137499039@linuxfoundation.org>
References: <20190111131045.137499039@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maurizio Lombardi <mlombard@redhat.com>

commit 132d00becb31e88469334e1e62751c81345280e0 upstream.

In case of error, ext4_try_to_write_inline_data() should unlock
and release the page it holds.

Fixes: f19d5870cbf7 ("ext4: add normal write support for inline data")
Cc: stable@kernel.org # 3.8
Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/inline.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -701,8 +701,11 @@ int ext4_try_to_write_inline_data(struct
 
 	if (!PageUptodate(page)) {
 		ret = ext4_read_inline_page(inode, page);
-		if (ret < 0)
+		if (ret < 0) {
+			unlock_page(page);
+			put_page(page);
 			goto out_up_read;
+		}
 	}
 
 	ret = 1;


