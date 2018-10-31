Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D52C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A59A620847
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pDYLoP5q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A59A620847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbeKAIIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:08:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:57258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729597AbeKAIIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:08:24 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E25952064C;
        Wed, 31 Oct 2018 23:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027293;
        bh=42DA8Gcd7UySTRbtMG9kqar9y/sSvVbbDhuGHs2fD5A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pDYLoP5qJwCdPA8ykcebsn47bFGy+RxlKy802RqChtgMSTBoAL8ToFBitM9cxr6TH
         xL9eo16wrb7q7/u1z2FQoWywlOCr82ELt1+OHi5Q0IDkuhkvSJ09O3+2jHGZJejvOp
         serT+cou9BJeQObsXGTllJl3uMnD9FRSWRbyBGPc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ben Peddell <klightspeed@killerwolves.net>,
        Coly Li <colyli@suse.de>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 020/126] bcache: Populate writeback_rate_minimum attribute
Date:   Wed, 31 Oct 2018 19:06:08 -0400
Message-Id: <20181031230754.29029-20-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230754.29029-1-sashal@kernel.org>
References: <20181031230754.29029-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Peddell <klightspeed@killerwolves.net>

[ Upstream commit 7567c2a2ad9e80a2ce977eef535e64b61899633e ]

Forgot to include the maintainers with my first email.

Somewhere between Michael Lyle's original
"bcache: PI controller for writeback rate V2" patch dated 07 Sep 2017
and 1d316e6 bcache: implement PI controller for writeback rate,
the mapping of the writeback_rate_minimum attribute was dropped.

Re-add the missing sysfs writeback_rate_minimum attribute mapping to
"allow the user to specify a minimum rate at which dirty blocks are
retired."

Fixes: 1d316e6 ("bcache: implement PI controller for writeback rate")
Signed-off-by: Ben Peddell <klightspeed@killerwolves.net>
Signed-off-by: Coly Li <colyli@suse.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/bcache/sysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index 225b15aa0340..34819f2c257d 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -263,6 +263,7 @@ STORE(__cached_dev)
 			    1, WRITEBACK_RATE_UPDATE_SECS_MAX);
 	d_strtoul(writeback_rate_i_term_inverse);
 	d_strtoul_nonzero(writeback_rate_p_term_inverse);
+	d_strtoul_nonzero(writeback_rate_minimum);
 
 	sysfs_strtoul_clamp(io_error_limit, dc->error_limit, 0, INT_MAX);
 
@@ -389,6 +390,7 @@ static struct attribute *bch_cached_dev_files[] = {
 	&sysfs_writeback_rate_update_seconds,
 	&sysfs_writeback_rate_i_term_inverse,
 	&sysfs_writeback_rate_p_term_inverse,
+	&sysfs_writeback_rate_minimum,
 	&sysfs_writeback_rate_debug,
 	&sysfs_errors,
 	&sysfs_io_error_limit,
-- 
2.17.1

