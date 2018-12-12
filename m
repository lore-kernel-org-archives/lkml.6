Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB8DC67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B60320870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:48:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B60320870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbeLLOs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 09:48:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:59740 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726240AbeLLOsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 09:48:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1E4A2AFC3;
        Wed, 12 Dec 2018 14:48:22 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D06BA1E0DB5; Wed, 12 Dec 2018 15:48:20 +0100 (CET)
Date:   Wed, 12 Dec 2018 15:48:20 +0100
From:   Jan Kara <jack@suse.cz>
To:     Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Cc:     Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: Unlinking a file on a broken UDF image causes kernel BUG
Message-ID: <20181212144820.GA2393@quack2.suse.cz>
References: <CAE5jQCddXGKTYV3WuCn7GUU2upvjhONVv2QojbHdp3ej200bTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
In-Reply-To: <CAE5jQCddXGKTYV3WuCn7GUU2upvjhONVv2QojbHdp3ej200bTw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Sun 14-10-18 18:27:25, Anatoly Trosinenko wrote:
> When unlinking a file on a fuzzed UDF image, the kernel BUG is triggered.
> 
> How to reproduce (with kvm-xfstests):
> 
> 1) Checkout udf/for_next (commit 3df77b04f)
> 2) Copy x86_64-config-4.14 to .config, execute `make olddefconfig`,
> then enable UDF support and compile the kernel
> 3) Copy the attached reproducer to
> /tmp/kvm-xfstests-$USER/dump_udf.img (1 Mb uncompressed)
> 4) Run `kvm-xfstests shell`
> 5) Inside the shell:

Thanks for report and sorry it took so long for me to get to this. Attached
patch fixes the issue for me.

Unless someone objects, I'm going to merge the patch to my tree and push it
to Linus in the coming merge window.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--oyUTqETQ0mS9luUI
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-udf-Fix-BUG-on-corrupted-inode.patch"

From d524d42ca22801418c3f2c1cb1bf6e79c1ee217c Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Wed, 12 Dec 2018 14:29:20 +0100
Subject: [PATCH] udf: Fix BUG on corrupted inode

When inode is corrupted so that extent type is invalid, some functions
(such as udf_truncate_extents()) will just BUG. Check that extent type
is valid when loading the inode to memory.

Reported-by: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/inode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 5df554a9f9c9..ae796e10f68b 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -1357,6 +1357,12 @@ static int udf_read_inode(struct inode *inode, bool hidden_inode)
 
 	iinfo->i_alloc_type = le16_to_cpu(fe->icbTag.flags) &
 							ICBTAG_FLAG_AD_MASK;
+	if (iinfo->i_alloc_type != ICBTAG_FLAG_AD_SHORT &&
+	    iinfo->i_alloc_type != ICBTAG_FLAG_AD_LONG &&
+	    iinfo->i_alloc_type != ICBTAG_FLAG_AD_IN_ICB) {
+		ret = -EIO;
+		goto out;
+	}
 	iinfo->i_unique = 0;
 	iinfo->i_lenEAttr = 0;
 	iinfo->i_lenExtents = 0;
-- 
2.16.4


--oyUTqETQ0mS9luUI--
