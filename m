Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52672C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0720D20872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:02:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0720D20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754011AbeFTPCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 11:02:02 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:42101 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752856AbeFTPCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 11:02:01 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue003 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MMrpj-1fYgcF1epj-008eEp; Wed, 20 Jun 2018 17:01:40 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     y2038@lists.linaro.org, Andi Kleen <andi.kleen@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jeff Layton <jlayton@redhat.com>, Jan Kara <jack@suse.cz>,
        Brian Foster <bfoster@redhat.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jens Axboe <axboe@kernel.dk>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] vfs: replace current_kernel_time64 with ktime equivalent
Date:   Wed, 20 Jun 2018 17:01:24 +0200
Message-Id: <20180620150138.49380-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:O7197BHrK3NK8I93Hj/GJR5jEGKx4xM3JUenyXkcW+fqxnC0Uuw
 6KHtZTE6SDXCmp7Qxq2k1MFDYERup10AXasOlXDYNzx4hxDPGZhohDMfartdp6bSAIk4Qbz
 AvxhylRK4jPVvxbq8VpE3v6u6s+2HoOg+oy0jUuuGWMFRFdVb0F9AYq2vjZai0eBY0UZkQz
 tMTVMjc1ctimZNkjIopKw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eYkw8y4A97Y=:noi7bxlkPjvNpKmLJeehyH
 Vc/uwX87Nfgsqg8VB7v7gfgbizSi3l06mhE0bEQK7p31TGn64sALzSY7UqgLE7D29dMNgrL6x
 +DykBOhpsJyEt89ULo+pjJkPHvdT9Z+7Ab57odaXJ4Zh4hSBCCtDg5NvouiX+D793Qg0av+tu
 7CWhlWlnVPjA6/cryV9oYgtOKhAOFpu2ZZ4oPu7cOxMJ5YzL3W29Mmow4LPCTAS8FpDEzPDrF
 fROmwUFk9WOIVAg73TYC7Nv7ssv77NjfVPBHRE1/PINl+jJg150v8eUtPKCUIwHNKTqpR0Gcv
 H0Sa/JTJQWcMknvm952hm48eKUUzzyhIiuBr1hfLpJFGBB74rcQj2cjzfFCxwPQXwqKVypZ2H
 LpDCxa2wJK/LiZfl1kaVi8gz5n9MYFH9+X3zRufNWJ6qFkCToz0sLtXaRkxlnupUY3grc56c7
 lTFFjwLXKvGc/sd+CuVm1w4TZoi5Mpd3vpGjq16Blx1sBP3x2xqvnRXFsHDF1IMlLBolzuS23
 GvAIh4b3Z7sZ8X1IXyEwhKhUsp1uYaM7ZhNHI6iAIi9Emg2MLLB9uYnLmGhFsRg/L994F4LLe
 Lc/wFyc/imZbAoYr9J9SxDnqctw+7zxxGrqsTI8/mQVj2DqzPPKWC9CfZBG8TcQPOFgJ1Plz1
 jg19NrCgtKcG4RGS92AE59TToDPU2UE6laJse0n7UZAoqVJUevvXgVJRO71PQUkoVm6w=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

current_time is one of the few callers of current_kernel_time64(), which
is a wrapper around ktime_get_coarse_real_ts64(). This calls the latter
directly for consistency with the rest of the kernel that is moving to
the ktime_get_ family of time accessors.

An open questions is whether we may want to actually call the more
accurate ktime_get_real_ts64() for file systems that save high-resolution
timestamps in their on-disk format. This would add a small but measurable
overhead to each update of the inode stamps but lead to inode timestamps
to actually have a usable resolution better than one jiffy (1 to 10
milliseconds normally).

I traced the original addition of the current_kernel_time() call to set
the nanosecond fields back to linux-2.5.48, where Andi Kleen added a
patch with subject "nanosecond stat timefields". This adds the original
call to current_kernel_time and the truncation to the resolution of the
file system, but makes no mention of the intended accuracy.  At the time,
we had a do_gettimeofday() interface that on some architectures could
return a microsecond-resolution timestamp, but there was no interface
for getting an accurate timestamp in nanosecond resolution, neither inside
the kernel nor from user space. This makes me suspect that the use of
coarse timestamps was never really a conscious decision but instead
a result of whatever API was available 16 years ago.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/inode.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index 2c300e981796..e27bd9334939 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2133,7 +2133,9 @@ EXPORT_SYMBOL(timespec64_trunc);
  */
 struct timespec64 current_time(struct inode *inode)
 {
-	struct timespec64 now = current_kernel_time64();
+	struct timespec64 now;
+
+	ktime_get_coarse_real_ts64(&now);
 
 	if (unlikely(!inode->i_sb)) {
 		WARN(1, "current_time() called with uninitialized super_block in the inode");
-- 
2.9.0

