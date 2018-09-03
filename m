Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6117DC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 296532086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:24:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 296532086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730548AbeICVpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:45:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45536 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729531AbeICVpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:45:38 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8E4B1D0A;
        Mon,  3 Sep 2018 17:24:31 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Anatoly Trosinenko <anatoly.trosinenko@yandex.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Eric Sandeen <sandeen@redhat.com>, Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.14 107/165] ext4: reset error code in ext4_find_entry in fallback
Date:   Mon,  3 Sep 2018 18:56:33 +0200
Message-Id: <20180903165700.890913716@linuxfoundation.org>
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

From: Eric Sandeen <sandeen@redhat.com>

commit f39b3f45dbcb0343822cce31ea7636ad66e60bc2 upstream.

When ext4_find_entry() falls back to "searching the old fashioned
way" due to a corrupt dx dir, it needs to reset the error code
to NULL so that the nonstandard ERR_BAD_DX_DIR code isn't returned
to userspace.

https://bugzilla.kernel.org/show_bug.cgi?id=199947

Reported-by: Anatoly Trosinenko <anatoly.trosinenko@yandex.com>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Signed-off-by: Eric Sandeen <sandeen@redhat.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/namei.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1397,6 +1397,7 @@ static struct buffer_head * ext4_find_en
 			goto cleanup_and_exit;
 		dxtrace(printk(KERN_DEBUG "ext4_find_entry: dx failed, "
 			       "falling back\n"));
+		ret = NULL;
 	}
 	nblocks = dir->i_size >> EXT4_BLOCK_SIZE_BITS(sb);
 	if (!nblocks) {


