Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6BEC282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7979C21726
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548359658;
	bh=Bf9Nu7iY00ub8IMnp4J4smw4uBCoCSeE6b7BKMiSbk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b6Id3vZFk8SDNI2dP0S2kp7+sEUxRdCg8nCkELLhmhsRHbtcLzwDk9Yun47D8oNU+
	 bONhrqUK7QlF2Duslh+0swz752cuH5oi//mH1EHicM7/o/Z+QAIs65WQAkvGqsfsLb
	 l8es2+EDVIevDX9fi+rDeCTC9ARhXUq6LymH6aMM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732503AbfAXTyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:54:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:37598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732122AbfAXThd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:37:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C37F218FC;
        Thu, 24 Jan 2019 19:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358652;
        bh=Bf9Nu7iY00ub8IMnp4J4smw4uBCoCSeE6b7BKMiSbk4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n6lrme+4WNth2/bUtvU7kgQsRkA1J8NWNC56tWzQVqEdmwN7PDIPQMfMuUu5tUtQI
         hnsn8SVx5fIa8mQG6OdS8doaJex5EeVdkiOWNI9hazVimVF297xC940vDISGu9GUyL
         O9+GFMzw4C89RFL9CmFv7MIxLFeSzR3oFFcaxjEk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Milan Broz <gmazyland@gmail.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 084/106] dm: Check for device sector overflow if CONFIG_LBDAF is not set
Date:   Thu, 24 Jan 2019 20:20:41 +0100
Message-Id: <20190124190211.481093306@linuxfoundation.org>
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

[ Upstream commit ef87bfc24f9b8da82c89aff493df20f078bc9cb1 ]

Reference to a device in device-mapper table contains offset in sectors.

If the sector_t is 32bit integer (CONFIG_LBDAF is not set), then
several device-mapper targets can overflow this offset and validity
check is then performed on a wrong offset and a wrong table is activated.

See for example (on 32bit without CONFIG_LBDAF) this overflow:

  # dmsetup create test --table "0 2048 linear /dev/sdg 4294967297"
  # dmsetup table test
  0 2048 linear 8:96 1

This patch adds explicit check for overflow if the offset is sector_t type.

Signed-off-by: Milan Broz <gmazyland@gmail.com>
Reviewed-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-crypt.c    | 2 +-
 drivers/md/dm-delay.c    | 2 +-
 drivers/md/dm-flakey.c   | 2 +-
 drivers/md/dm-linear.c   | 2 +-
 drivers/md/dm-raid1.c    | 3 ++-
 drivers/md/dm-unstripe.c | 2 +-
 6 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index f192ba38f332..f2ec882f96be 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -2780,7 +2780,7 @@ static int crypt_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	}
 
 	ret = -EINVAL;
-	if (sscanf(argv[4], "%llu%c", &tmpll, &dummy) != 1) {
+	if (sscanf(argv[4], "%llu%c", &tmpll, &dummy) != 1 || tmpll != (sector_t)tmpll) {
 		ti->error = "Invalid device sector";
 		goto bad;
 	}
diff --git a/drivers/md/dm-delay.c b/drivers/md/dm-delay.c
index 2fb7bb4304ad..fddffe251bf6 100644
--- a/drivers/md/dm-delay.c
+++ b/drivers/md/dm-delay.c
@@ -141,7 +141,7 @@ static int delay_class_ctr(struct dm_target *ti, struct delay_class *c, char **a
 	unsigned long long tmpll;
 	char dummy;
 
-	if (sscanf(argv[1], "%llu%c", &tmpll, &dummy) != 1) {
+	if (sscanf(argv[1], "%llu%c", &tmpll, &dummy) != 1 || tmpll != (sector_t)tmpll) {
 		ti->error = "Invalid device sector";
 		return -EINVAL;
 	}
diff --git a/drivers/md/dm-flakey.c b/drivers/md/dm-flakey.c
index 32aabe27b37c..b86d2439ffc7 100644
--- a/drivers/md/dm-flakey.c
+++ b/drivers/md/dm-flakey.c
@@ -213,7 +213,7 @@ static int flakey_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	devname = dm_shift_arg(&as);
 
 	r = -EINVAL;
-	if (sscanf(dm_shift_arg(&as), "%llu%c", &tmpll, &dummy) != 1) {
+	if (sscanf(dm_shift_arg(&as), "%llu%c", &tmpll, &dummy) != 1 || tmpll != (sector_t)tmpll) {
 		ti->error = "Invalid device sector";
 		goto bad;
 	}
diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index 2f7c44a006c4..caa08c4b84cd 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -45,7 +45,7 @@ static int linear_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	}
 
 	ret = -EINVAL;
-	if (sscanf(argv[1], "%llu%c", &tmp, &dummy) != 1) {
+	if (sscanf(argv[1], "%llu%c", &tmp, &dummy) != 1 || tmp != (sector_t)tmp) {
 		ti->error = "Invalid device sector";
 		goto bad;
 	}
diff --git a/drivers/md/dm-raid1.c b/drivers/md/dm-raid1.c
index 79eab1071ec2..5a51151f680d 100644
--- a/drivers/md/dm-raid1.c
+++ b/drivers/md/dm-raid1.c
@@ -943,7 +943,8 @@ static int get_mirror(struct mirror_set *ms, struct dm_target *ti,
 	char dummy;
 	int ret;
 
-	if (sscanf(argv[1], "%llu%c", &offset, &dummy) != 1) {
+	if (sscanf(argv[1], "%llu%c", &offset, &dummy) != 1 ||
+	    offset != (sector_t)offset) {
 		ti->error = "Invalid offset";
 		return -EINVAL;
 	}
diff --git a/drivers/md/dm-unstripe.c b/drivers/md/dm-unstripe.c
index 954b7ab4e684..e673dacf6418 100644
--- a/drivers/md/dm-unstripe.c
+++ b/drivers/md/dm-unstripe.c
@@ -78,7 +78,7 @@ static int unstripe_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 		goto err;
 	}
 
-	if (sscanf(argv[4], "%llu%c", &start, &dummy) != 1) {
+	if (sscanf(argv[4], "%llu%c", &start, &dummy) != 1 || start != (sector_t)start) {
 		ti->error = "Invalid striped device offset";
 		goto err;
 	}
-- 
2.19.1



