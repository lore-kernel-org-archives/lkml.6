Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC00C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05B742146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbfBSOCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 09:02:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:59626 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725845AbfBSOCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 09:02:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BFEF2AE6E;
        Tue, 19 Feb 2019 14:02:40 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 40DE71E1570; Tue, 19 Feb 2019 15:02:40 +0100 (CET)
Date:   Tue, 19 Feb 2019 15:02:40 +0100
From:   Jan Kara <jack@suse.cz>
To:     Colin King <colin.king@canonical.com>
Cc:     Jan Kara <jack@suse.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][udf-next] udf: don't call mark_buffer_dirty on a null bh
 pointer
Message-ID: <20190219140240.GA31849@quack2.suse.cz>
References: <20190219114403.24771-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
In-Reply-To: <20190219114403.24771-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue 19-02-19 11:44:03, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a null check on the pointer bh to avoid a null pointer dereference
> on bh->b_data however later bh is passed to mark_buffer_dirty that can also
> cause a null pointer dereference on bh.  Avoid this potential null pointer
> dereference by moving the call to mark_buffer_dirty inside the null checked
> block.
> 
> Fixes: e8b4274735e4 ("udf: finalize integrity descriptor before writeback")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks for the patch! In fact it is the 'if (bh)' check that's
unnecessarily defensive (we cannot have sbi->s_lvid_dirty and
!sbi->s_lvid_bh). So I'll just drop that check (attached patch).

								Honza

> ---
>  fs/udf/super.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/udf/super.c b/fs/udf/super.c
> index a6940d90bedd..b7e9a83d39db 100644
> --- a/fs/udf/super.c
> +++ b/fs/udf/super.c
> @@ -2336,13 +2336,13 @@ static int udf_sync_fs(struct super_block *sb, int wait)
>  
>  			lvid = (struct logicalVolIntegrityDesc *)bh->b_data;
>  			udf_finalize_lvid(lvid);
> -		}
>  
> -		/*
> -		 * Blockdevice will be synced later so we don't have to submit
> -		 * the buffer for IO
> -		 */
> -		mark_buffer_dirty(bh);
> +			/*
> +			 * Blockdevice will be synced later so we don't have
> +			 * to submit the buffer for IO
> +			 */
> +			mark_buffer_dirty(bh);
> +		}
>  		sbi->s_lvid_dirty = 0;
>  	}
>  	mutex_unlock(&sbi->s_alloc_mutex);
> -- 
> 2.20.1
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--cWoXeonUoKmBZSoM
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-udf-Drop-pointless-check-from-udf_sync_fs.patch"

From a00eb52e3f2f815efa52a9e3bf1b730d86c05faa Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Tue, 19 Feb 2019 14:59:43 +0100
Subject: [PATCH] udf: Drop pointless check from udf_sync_fs()

The check if (bh) in udf_sync_fs() is pointless as we cannot have
sbi->s_lvid_dirty and !sbi->s_lvid_bh (as already asserted by
udf_updated_lvid()). So just drop the pointless check.

Reported-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/super.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/udf/super.c b/fs/udf/super.c
index a6940d90bedd..ffd8038ff728 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -2330,13 +2330,10 @@ static int udf_sync_fs(struct super_block *sb, int wait)
 	mutex_lock(&sbi->s_alloc_mutex);
 	if (sbi->s_lvid_dirty) {
 		struct buffer_head *bh = sbi->s_lvid_bh;
+		struct logicalVolIntegrityDesc *lvid;
 
-		if (bh) {
-			struct logicalVolIntegrityDesc *lvid;
-
-			lvid = (struct logicalVolIntegrityDesc *)bh->b_data;
-			udf_finalize_lvid(lvid);
-		}
+		lvid = (struct logicalVolIntegrityDesc *)bh->b_data;
+		udf_finalize_lvid(lvid);
 
 		/*
 		 * Blockdevice will be synced later so we don't have to submit
-- 
2.16.4


--cWoXeonUoKmBZSoM--
