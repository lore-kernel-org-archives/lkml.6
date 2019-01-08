Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4203DC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 100132063F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546976705;
	bh=BiqCQWm8xNbuUPFzmpiOz2GyzPnupbrzUiKhm21e0LI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ECNos/Z3KhYv2MaHbuIUs21G2FmcdKNMFVKcPpMmTQpKINz2AK/8+U+eC9ZlpwEGi
	 7MO4sJcDR5LyL8qB+s/0dsmohzDjZe7dOM/XYprCiP5RL6hg6LhY2p3DYnjrw0UAe1
	 3q91Kxh4hAz0uaGWSUdBorjBy0y5rtwzZm/32MKE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732363AbfAHTpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:45:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:42184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731665AbfAHTdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:33:25 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D5FE20645;
        Tue,  8 Jan 2019 19:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546976004;
        bh=BiqCQWm8xNbuUPFzmpiOz2GyzPnupbrzUiKhm21e0LI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RYFEQR5uPbhOistXUaSg1NmXm6709NkdOsF0Qq824H/ReLImwRY2jxWGudZQq5/Fz
         GKQESN6IhnY9dPm4cNykVnNiTPLdHqweNCJdhiMkcVdqB8EwvXF3/3tfgmuAqSxDK4
         5xRUaorNjGosTh/QQE2vz/qaWNlDYs6ZcBGjKvQg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     AliOS system security <alios_sys_security@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 38/53] dm crypt: use u64 instead of sector_t to store iv_offset
Date:   Tue,  8 Jan 2019 14:32:06 -0500
Message-Id: <20190108193222.123316-38-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108193222.123316-1-sashal@kernel.org>
References: <20190108193222.123316-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: AliOS system security <alios_sys_security@linux.alibaba.com>

[ Upstream commit 8d683dcd65c037efc9fb38c696ec9b65b306e573 ]

The iv_offset in the mapping table of crypt target is a 64bit number when
IV algorithm is plain64, plain64be, essiv or benbi. It will be assigned to
iv_offset of struct crypt_config, cc_sector of struct convert_context and
iv_sector of struct dm_crypt_request. These structures members are defined
as a sector_t. But sector_t is 32bit when CONFIG_LBDAF is not set in 32bit
kernel. In this situation sector_t is not big enough to store the 64bit
iv_offset.

Here is a reproducer.
Prepare test image and device (loop is automatically allocated by cryptsetup):

  # dd if=/dev/zero of=tst.img bs=1M count=1
  # echo "tst"|cryptsetup open --type plain -c aes-xts-plain64 \
  --skip 500000000000000000 tst.img test

On 32bit system (use IV offset value that overflows to 64bit; CONFIG_LBDAF if off)
and device checksum is wrong:

  # dmsetup table test --showkeys
  0 2048 crypt aes-xts-plain64 dfa7cfe3c481f2239155739c42e539ae8f2d38f304dcc89d20b26f69daaf0933 3551657984 7:0 0

  # sha256sum /dev/mapper/test
  533e25c09176632b3794f35303488c4a8f3f965dffffa6ec2df347c168cb6c19 /dev/mapper/test

On 64bit system (and on 32bit system with the patch), table and checksum is now correct:

  # dmsetup table test --showkeys
  0 2048 crypt aes-xts-plain64 dfa7cfe3c481f2239155739c42e539ae8f2d38f304dcc89d20b26f69daaf0933 500000000000000000 7:0 0

  # sha256sum /dev/mapper/test
  5d16160f9d5f8c33d8051e65fdb4f003cc31cd652b5abb08f03aa6fce0df75fc /dev/mapper/test

Signed-off-by: AliOS system security <alios_sys_security@linux.alibaba.com>
Tested-and-Reviewed-by: Milan Broz <gmazyland@gmail.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-crypt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index c60d29d09687..2652ef68d58d 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -49,7 +49,7 @@ struct convert_context {
 	struct bio *bio_out;
 	struct bvec_iter iter_in;
 	struct bvec_iter iter_out;
-	sector_t cc_sector;
+	u64 cc_sector;
 	atomic_t cc_pending;
 	union {
 		struct skcipher_request *req;
@@ -81,7 +81,7 @@ struct dm_crypt_request {
 	struct convert_context *ctx;
 	struct scatterlist sg_in[4];
 	struct scatterlist sg_out[4];
-	sector_t iv_sector;
+	u64 iv_sector;
 };
 
 struct crypt_config;
@@ -172,7 +172,7 @@ struct crypt_config {
 		struct iv_lmk_private lmk;
 		struct iv_tcw_private tcw;
 	} iv_gen_private;
-	sector_t iv_offset;
+	u64 iv_offset;
 	unsigned int iv_size;
 	unsigned short int sector_size;
 	unsigned char sector_shift;
-- 
2.19.1

