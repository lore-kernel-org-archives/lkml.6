Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656C8C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 335A620827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546976991;
	bh=PNfLpMWRzwLfayFhU4wPL2/ACMrNB3x7q0CRQD1S9m4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZDhpQ/3Wund3QfLlLlUvrm+lrC4DM7W3g1DT67wSPs/wFKkKHVS3SbDFcZj3vHAZT
	 OvyhyA16zE4cJoUnya8Ls3vHR+/j3yLxZ9eNe0LcvnOSOBT3KQcSWFDVW0wPtipECK
	 0uu7eF/RsOnTDWyeUzbPn3Jpg1azsymSgL0kd61M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731537AbfAHTtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:49:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:40250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731235AbfAHTb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:31:58 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF3DF20665;
        Tue,  8 Jan 2019 19:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975917;
        bh=PNfLpMWRzwLfayFhU4wPL2/ACMrNB3x7q0CRQD1S9m4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GBDjsPcCU/NgFY0Oa5xhMVAK1nTGrnzmphywQeuH4l9Zu11V9LJIcmFkuGK14SP5h
         TgFOJn92YwE6RpL9yYk7yl/yhcYLMVQO4WhImzwBTwzjkUl0FyHyjXMTNgJchdg1DK
         8E+/+q69Ooe+VD9Rvd4LTYFaZhRraGnsR/bRihoc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Milan Broz <gmazyland@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 82/97] dm: Check for device sector overflow if CONFIG_LBDAF is not set
Date:   Tue,  8 Jan 2019 14:29:31 -0500
Message-Id: <20190108192949.122407-82-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192949.122407-1-sashal@kernel.org>
References: <20190108192949.122407-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Milan Broz <gmazyland@gmail.com>

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

