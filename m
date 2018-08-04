Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A69C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 13:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F7F9217CD
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 13:01:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F7F9217CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbeHDPCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 11:02:19 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:34905 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726753AbeHDPCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 11:02:18 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="43067538"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 04 Aug 2018 20:59:56 +0800
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id B3A004B66A09;
        Sat,  4 Aug 2018 20:59:50 +0800 (CST)
Received: from fnst.localdomain (10.167.226.155) by
 G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.399.0; Sat, 4 Aug 2018 20:59:51 +0800
Date:   Sat, 4 Aug 2018 20:59:48 +0800
From:   Lu Fengqi <lufq.fnst@cn.fujitsu.com>
To:     zhong jiang <zhongjiang@huawei.com>
CC:     <clm@fb.com>, <jbacik@fb.com>, <dsterba@suse.com>,
        <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] btrfs/extent_map: Remove unneeded variable "ret"
Message-ID: <20180804125947.GF2049@fnst.localdomain>
References: <1533381223-16734-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1533381223-16734-1-git-send-email-zhongjiang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.226.155]
X-yoursite-MailScanner-ID: B3A004B66A09.AD2E7
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lufq.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 04, 2018 at 07:13:43PM +0800, zhong jiang wrote:
>The ret is not used after initalization, So just remove it.

So why not change these two functions to void function?

-- 
Thanks,
Lu

>
>Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>---
> fs/btrfs/extent_map.c | 8 +++-----
> 1 file changed, 3 insertions(+), 5 deletions(-)
>
>diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
>index 6648d55..b48ab41 100644
>--- a/fs/btrfs/extent_map.c
>+++ b/fs/btrfs/extent_map.c
>@@ -276,7 +276,6 @@ static void try_merge_map(struct extent_map_tree *tree, struct extent_map *em)
> int unpin_extent_cache(struct extent_map_tree *tree, u64 start, u64 len,
> 		       u64 gen)
> {
>-	int ret = 0;
> 	struct extent_map *em;
> 	bool prealloc = false;
> 
>@@ -308,7 +307,7 @@ int unpin_extent_cache(struct extent_map_tree *tree, u64 start, u64 len,
> 	free_extent_map(em);
> out:
> 	write_unlock(&tree->lock);
>-	return ret;
>+	return 0;
> 
> }
> 
>@@ -430,14 +429,13 @@ struct extent_map *search_extent_mapping(struct extent_map_tree *tree,
>  */
> int remove_extent_mapping(struct extent_map_tree *tree, struct extent_map *em)
> {
>-	int ret = 0;
>-
> 	WARN_ON(test_bit(EXTENT_FLAG_PINNED, &em->flags));
> 	rb_erase(&em->rb_node, &tree->map);
> 	if (!test_bit(EXTENT_FLAG_LOGGING, &em->flags))
> 		list_del_init(&em->list);
> 	RB_CLEAR_NODE(&em->rb_node);
>-	return ret;
>+
>+	return 0;
> }
> 
> void replace_extent_mapping(struct extent_map_tree *tree,
>-- 
>1.7.12.4
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-btrfs" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>


