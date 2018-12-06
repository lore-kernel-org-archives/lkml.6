Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E11C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF22F20892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107609;
	bh=AXjUXRs6rvA34829rkJfL+HTLqXPa9iLZCgnhhVfYcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XgY30uebe4e6fCdHEshd//C3XS5Uj5aaWj0fMnrLio4nBSP0mifgcXPs50B99kGZR
	 nmh5i7ucu5O1IjTcBtztekTibem3UAYGL4qZNPAA84FNj1OlMOeHjIY+U//ja/tv7C
	 LFwcH6d6V+Wq4anxBVUEM3CnDC6JVfRNe8SZvxAw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF22F20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731318AbeLFOqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:46:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:51520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730843AbeLFOqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:46:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9732D214DB;
        Thu,  6 Dec 2018 14:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107605;
        bh=AXjUXRs6rvA34829rkJfL+HTLqXPa9iLZCgnhhVfYcs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=thV+ixVBauMeLZKUpfzs5qNQjaxR0ezkW27bB7B2r/RhkEAohcZFSRVQ4H/U7mntm
         gpRTRp4rCd1qRDzwnb1yWo6YHH9LwbIgNgEFrhpzXxviyxq18THiTO7D+EJRgboTBJ
         MstbrdutfyXOFWgWccE33qI5qbrTVDIR8p2yGP74=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.9 068/101] btrfs: Check if item pointer overlaps with the item itself
Date:   Thu,  6 Dec 2018 15:39:07 +0100
Message-Id: <20181206143015.734862750@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143011.174892052@linuxfoundation.org>
References: <20181206143011.174892052@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qu Wenruo <quwenruo.btrfs@gmx.com>

commit 7f43d4affb2a254d421ab20b0cf65ac2569909fb upstream.

Function check_leaf() checks if any item pointer points outside of the
leaf, but it doesn't check if the pointer overlaps with the item itself.

Normally only the last item may be the victim, but adding such check is
never a bad idea anyway.

Signed-off-by: Qu Wenruo <quwenruo.btrfs@gmx.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/disk-io.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -637,6 +637,13 @@ static noinline int check_leaf(struct bt
 			return -EUCLEAN;
 		}
 
+		/* Also check if the item pointer overlaps with btrfs item. */
+		if (btrfs_item_nr_offset(slot) + sizeof(struct btrfs_item) >
+		    btrfs_item_ptr_offset(leaf, slot)) {
+			CORRUPT("slot overlap with its data", leaf, root, slot);
+			return -EUCLEAN;
+		}
+
 		prev_key.objectid = key.objectid;
 		prev_key.type = key.type;
 		prev_key.offset = key.offset;


