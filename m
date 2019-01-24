Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072F6C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9DDA21903
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358629;
	bh=cLptTS6a8IonYDqB4smxFTzC4MvWVFNzT3ssPFlAXos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Amc1T3komVfA0GBXaQovFU2sSLgi+g1TYObOarpst1xOSiEllNcj5wYDy1xfWf3xV
	 hsHx3+laV83AaepZBR3Ik+PoSRn7knqfwdtO1OfZSXqXfbMhlMAbmZwb+/Ds3sJU7r
	 G1VIAoFkBAKJCapC5JXl1++c8BfHLzTGBAQah70Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732599AbfAXThI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:37:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:37022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732582AbfAXThD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:37:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AEC621905;
        Thu, 24 Jan 2019 19:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358622;
        bh=cLptTS6a8IonYDqB4smxFTzC4MvWVFNzT3ssPFlAXos=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nU2mpA5fB/VCRetdcZH9olVlrjtKSamWrVRfHmWlTPkponks39Hizdu4/10SdqjEh
         sHIiLdOWSVgFNgGrniq8IxDk7/VFKAn4B6QinhoJF6pGBOniIUAxA+7VtxH4X5Os/K
         8DexGtuhr6KQiU86mOaKnC/Al94FuljjGR31liY0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        AliOS system security <alios_sys_security@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        Milan Broz <gmazyland@gmail.com>
Subject: [PATCH 4.19 074/106] dm crypt: use u64 instead of sector_t to store iv_offset
Date:   Thu, 24 Jan 2019 20:20:31 +0100
Message-Id: <20190124190210.990653609@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190206.342411005@linuxfoundation.org>
References: <20190124190206.342411005@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 0481223b1deb..f192ba38f332 100644
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
@@ -160,7 +160,7 @@ struct crypt_config {
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



