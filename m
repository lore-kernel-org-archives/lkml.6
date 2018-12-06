Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245E6C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D74D820700
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544108225;
	bh=MzA5iKNYccFloCOq7qddigWTtPNYL/7nsoJRAD+Fn+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lH6NTQN29xLjLl0Fe1d6Vrp7/HSvF5dAu8mSOmZ2/4eG/JJw3tNI0gAtiiFNzAv9W
	 0J1SRH4Vvd4W9Gkw3QfETbnZaXmOXPwf+z24RfIW3KomWVRTmdaQgfW+mpqKkqEysr
	 AIbHHwYEU9LTyEC77/odB2sXdv/EeGTxXnxScjFs=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D74D820700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbeLFO5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:57:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:47448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729726AbeLFOnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:43:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50ECF2082B;
        Thu,  6 Dec 2018 14:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107381;
        bh=MzA5iKNYccFloCOq7qddigWTtPNYL/7nsoJRAD+Fn+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=In+yPXFGhoxGg32uC+dTUyJ7XJP1bSaV9mTJhQmlGjapQ/euCfwJVgzm0P0stucbD
         dXOeRCyJxvhVWyasPeH108l3qZWhyELDWo+1ItycybNSnXY+OUKt7gtPH6plrHlo2i
         0TWhpkyxC5cuB8RlnMudTjyrcyJ9h4+A6EXJKCBI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wang Yugui <wangyugui@e16-tech.com>,
        Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>
Subject: [PATCH 4.14 40/55] btrfs: tree-checker: Dont check max block group size as current max chunk size limit is unreliable
Date:   Thu,  6 Dec 2018 15:39:14 +0100
Message-Id: <20181206143003.870816990@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143001.749982936@linuxfoundation.org>
References: <20181206143001.749982936@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qu Wenruo <wqu@suse.com>

commit 10950929e994c5ecee149ff0873388d3c98f12b5 upstream.

[BUG]
A completely valid btrfs will refuse to mount, with error message like:
  BTRFS critical (device sdb2): corrupt leaf: root=2 block=239681536 slot=172 \
    bg_start=12018974720 bg_len=10888413184, invalid block group size, \
    have 10888413184 expect (0, 10737418240]

This has been reported several times as the 4.19 kernel is now being
used. The filesystem refuses to mount, but is otherwise ok and booting
4.18 is a workaround.

Btrfs check returns no error, and all kernels used on this fs is later
than 2011, which should all have the 10G size limit commit.

[CAUSE]
For a 12 devices btrfs, we could allocate a chunk larger than 10G due to
stripe stripe bump up.

__btrfs_alloc_chunk()
|- max_stripe_size = 1G
|- max_chunk_size = 10G
|- data_stripe = 11
|- if (1G * 11 > 10G) {
       stripe_size = 976128930;
       stripe_size = round_up(976128930, SZ_16M) = 989855744

However the final stripe_size (989855744) * 11 = 10888413184, which is
still larger than 10G.

[FIX]
For the comprehensive check, we need to do the full check at chunk read
time, and rely on bg <-> chunk mapping to do the check.

We could just skip the length check for now.

Fixes: fce466eab7ac ("btrfs: tree-checker: Verify block_group_item")
Cc: stable@vger.kernel.org # v4.19+
Reported-by: Wang Yugui <wangyugui@e16-tech.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/tree-checker.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -348,13 +348,11 @@ static int check_block_group_item(struct
 
 	/*
 	 * Here we don't really care about alignment since extent allocator can
-	 * handle it.  We care more about the size, as if one block group is
-	 * larger than maximum size, it's must be some obvious corruption.
+	 * handle it.  We care more about the size.
 	 */
-	if (key->offset > BTRFS_MAX_DATA_CHUNK_SIZE || key->offset == 0) {
+	if (key->offset == 0) {
 		block_group_err(fs_info, leaf, slot,
-			"invalid block group size, have %llu expect (0, %llu]",
-				key->offset, BTRFS_MAX_DATA_CHUNK_SIZE);
+				"invalid block group size 0");
 		return -EUCLEAN;
 	}
 


