Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9B727C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 04:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53EBE20693
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 04:05:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53EBE20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754446AbeFMEFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 00:05:38 -0400
Received: from mout.gmx.net ([212.227.15.18]:41707 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751136AbeFMEFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 00:05:37 -0400
Received: from juanniu018037.ss.mogujie.org ([122.225.81.134]) by mail.gmx.com
 (mrgmx001 [212.227.17.184]) with ESMTPSA (Nemesis) id
 0McmFl-1fktYr3J0D-00Hsef; Wed, 13 Jun 2018 06:05:33 +0200
From:   Chengguang Xu <cgxu519@gmx.com>
To:     ooo@electrozaur.com
Cc:     linux-kernel@vger.kernel.org, Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH 1/2] fs/exofs: fix potential memory leak in mount option parsing
Date:   Wed, 13 Jun 2018 12:05:13 +0800
Message-Id: <1528862714-78150-1-git-send-email-cgxu519@gmx.com>
X-Mailer: git-send-email 1.8.3.1
X-Provags-ID: V03:K1:zZfIPePDmA/fUt0e1SUj4qykbbJwJ3MZxbQgq7Vua1q3b73Ckd4
 5udHNWdqqizXZXH9rErFNE9ycpVZJZTDl4E+oRyGwhiy/ovMzGbL3mi3ez19TFRX4YrcRPM
 2WnoC2ewsRrXDOEGwux2LRSQLQh61zOaEk/dH4YSBaEMHHsy/B2mUCHS2tGQf/jpiJOdGA7
 Wx0ZXqVnNKDMZXyvzE2jw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BtyDXVW06GA=:XxGVYHUjKdwRU7wHRJB/oL
 /UHRxFBql6UOUnwkhcAdG4bAGr635pUen3xqCNBzCyg3BCrNSVS8GTtb9gtzZbqjeW+mBam4q
 bgdk4BJ2uH2b1P10Ft5CK2XH3EnSjv3ao7iNGkSYHh/fFs07CmOVtTTflWPvA4HX6x+U8vnGQ
 +QT/L/WK4H5pkw+f1x7MQoAgxabps9drLGV5yiVRW2ZB4wAsrOycnsVYFsCjSwAOqoihse4Bh
 UwWinOAW5BR+vfW12WjQM3BMDlN9LUOFTXin4MS752KSMWNxekaNvJ/71yIFGJUvUkLFM9DMg
 /g9oCCDCf2L6zybS36cWPxvNj8IETGdiNSV4dWzc+99zdxzn6l2yUyfgGicmWEN/s9iokj3cn
 v6REWwwjVbWn3/j4oMXmLkiSTlk9NTA6dHJ6QSxw+MvSv8/YDGaLnlSb0SKPNxMyHCXxBig4h
 Yyx3IlITHNSREu4E2PKM/KLiH26nv0tAU1mMn4VJaL1aoEZzwj/F7zRl39syd6DfiQggdrb48
 BS/NqvtUIbGX0+OHsghNDF6pwiQ2iieTuI1n10RJOfIZNdR0tlOsFAz+diX0MhO8czcEWVd3J
 7f2lvXneIvcy2hJd+tL4IxEkFY0IZBjxHB4LjfbUQr4dqcL/vE6BWGs5J7DdY3Y9rXFhFc5yr
 9i+SjdgBzmV0ngKiaoEfgnC7sWdDe8olM9EFuiRLcEeIoQKvCKwK6N3fTtV+d8eDQgfZlXFSq
 R2qL/6Z6ErN6SINvK91VduD8NdEbluI2Wfc/oevh0bhqzb21NILS3MAEQV4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some cases can cause memory leak when parsing
option 'osdname'.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
---
 fs/exofs/super.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/exofs/super.c b/fs/exofs/super.c
index 719a315..f3e17a9 100644
--- a/fs/exofs/super.c
+++ b/fs/exofs/super.c
@@ -101,6 +101,7 @@ static int parse_options(char *options, struct exofs_mountopt *opts)
 		token = match_token(p, tokens, args);
 		switch (token) {
 		case Opt_name:
+			kfree(opts->dev_name);
 			opts->dev_name = match_strdup(&args[0]);
 			if (unlikely(!opts->dev_name)) {
 				EXOFS_ERR("Error allocating dev_name");
@@ -867,8 +868,10 @@ static struct dentry *exofs_mount(struct file_system_type *type,
 	int ret;
 
 	ret = parse_options(data, &opts);
-	if (ret)
+	if (ret) {
+		kfree(opts.dev_name);
 		return ERR_PTR(ret);
+	}
 
 	if (!opts.dev_name)
 		opts.dev_name = dev_name;
-- 
1.8.3.1

