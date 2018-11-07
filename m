Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787BAC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2426420882
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="hr2ORNV2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2426420882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730647AbeKHBEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 20:04:23 -0500
Received: from imap.thunk.org ([74.207.234.97]:49204 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727203AbeKHBEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 20:04:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=vw2VrDJF9DdfvhyfHCzWmQ9iYtihmvDvh/5DYB5EaTM=; b=hr2ORNV2jiP6+oaMv+Wy2EThiF
        zwb0Njmf517GSQ3LsMt9TvmyjA4uR/aTx+YxQlSeI99hXgF4Ha1eHTlp6odmo50yOOPGeta/1N/1C
        aKDvtJTPg562qEBdJHU+ia/+n9cCyGAst1XoEMN2rAR6Ec1SAJ0YJP5YQRDqeFFjeWpo=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gKPpj-00005Y-F0; Wed, 07 Nov 2018 15:33:31 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id B42E37A7D10; Wed,  7 Nov 2018 10:33:30 -0500 (EST)
Date:   Wed, 7 Nov 2018 10:33:30 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] ext4: possible sbi->s_group_desc leak in
 ext4_fill_super
Message-ID: <20181107153330.GC9919@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Vasily Averin <vvs@virtuozzo.com>, linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org
References: <cover.1541011937.git.vvs@virtuozzo.com>
 <4b554ca1-f46e-742e-4aaa-04b379baf5f9@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b554ca1-f46e-742e-4aaa-04b379baf5f9@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 10:12:27PM +0300, Vasily Averin wrote:
> Fixes bfe0a5f47ada ("ext4: add more mount time checks of the superblock") # 4.18
> 
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> ---
>  fs/ext4/super.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index a221f1cdf704..ed4d36506ec2 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4100,7 +4100,8 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
>  			 le32_to_cpu(es->s_inodes_count),
>  			 ((u64)sbi->s_groups_count * sbi->s_inodes_per_group));
>  		ret = -EINVAL;
> -		goto failed_mount;
> +		db_count = 0;
> +		goto failed_mount2;
>  	}
>  
>  	bgl_lock_init(sbi->s_blockgroup_lock);

Thanks for spotting this!

A better fix would be to move this check earlier, before the
allocation of sbi->s_group_desc.

						- Ted

commit 9fa8bc9b9d3c6864f8dddd83893a02fcc1b48b62
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Wed Nov 7 10:32:53 2018 -0500

    ext4: fix possible leak of sbi->s_group_desc_leak in error path
    
    Fixes: bfe0a5f47ada ("ext4: add more mount time checks of the superblock")
    Reported-by: Vasily Averin <vvs@virtuozzo.com>
    Signed-off-by: Theodore Ts'o <tytso@mit.edu>
    Cc: stable@kernel.org # 4.18

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index a221f1cdf704..92092b55db1e 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4075,6 +4075,14 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	sbi->s_groups_count = blocks_count;
 	sbi->s_blockfile_groups = min_t(ext4_group_t, sbi->s_groups_count,
 			(EXT4_MAX_BLOCK_FILE_PHYS / EXT4_BLOCKS_PER_GROUP(sb)));
+	if (((u64)sbi->s_groups_count * sbi->s_inodes_per_group) !=
+	    le32_to_cpu(es->s_inodes_count)) {
+		ext4_msg(sb, KERN_ERR, "inodes count not valid: %u vs %llu",
+			 le32_to_cpu(es->s_inodes_count),
+			 ((u64)sbi->s_groups_count * sbi->s_inodes_per_group));
+		ret = -EINVAL;
+		goto failed_mount;
+	}
 	db_count = (sbi->s_groups_count + EXT4_DESC_PER_BLOCK(sb) - 1) /
 		   EXT4_DESC_PER_BLOCK(sb);
 	if (ext4_has_feature_meta_bg(sb)) {
@@ -4094,14 +4102,6 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 		ret = -ENOMEM;
 		goto failed_mount;
 	}
-	if (((u64)sbi->s_groups_count * sbi->s_inodes_per_group) !=
-	    le32_to_cpu(es->s_inodes_count)) {
-		ext4_msg(sb, KERN_ERR, "inodes count not valid: %u vs %llu",
-			 le32_to_cpu(es->s_inodes_count),
-			 ((u64)sbi->s_groups_count * sbi->s_inodes_per_group));
-		ret = -EINVAL;
-		goto failed_mount;
-	}
 
 	bgl_lock_init(sbi->s_blockgroup_lock);
 
