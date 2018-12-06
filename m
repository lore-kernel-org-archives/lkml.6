Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E0EC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1697420661
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107696;
	bh=JdRx9pDh2HzSi52UtyZYQNSxcJiNNXFl2l/owIrXfm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sT1baQKFuBNxW/pXF22UhfOLnKIS0rNrV0B/lHEEyMrZFfQFtqNnxGjRJZLoWGYv8
	 RaW1GBB3tiUkvjagyluDDZsqr1c6zIAs7nEaLw6d76EWu3QQbZTBHS9hiX2RPNJY72
	 BmQkF+mJqFkLrK6ff2CyVsDpNq56ug/gGWDVpsnk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1697420661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731568AbeLFOsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:48:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:53310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731545AbeLFOsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:48:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D40FD2082B;
        Thu,  6 Dec 2018 14:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107689;
        bh=JdRx9pDh2HzSi52UtyZYQNSxcJiNNXFl2l/owIrXfm0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wZxPbhWmTMVsLGj8PjEbuzbTVfVU/DoP4sStkuZ5aWhna+agbji7S/RpjaO7L2v74
         pjriWA46oodEa+LZT32+yF7RdcEKq5PHMfW3MvDdCXjkqBVLZUdhjt+2a9xsHf+W1c
         4EkpGQdhODOZRztLO2C9pP4fphZFQyMhqY+sA9zE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kanda.motohiro@gmail.com,
        Dave Chinner <dchinner@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.9 101/101] xfs: dont fail when converting shortform attr to long form during ATTR_REPLACE
Date:   Thu,  6 Dec 2018 15:39:40 +0100
Message-Id: <20181206143019.063026750@linuxfoundation.org>
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

From: "Darrick J. Wong" <darrick.wong@oracle.com>

commit 7b38460dc8e4eafba06c78f8e37099d3b34d473c upstream.

Kanda Motohiro reported that expanding a tiny xattr into a large xattr
fails on XFS because we remove the tiny xattr from a shortform fork and
then try to re-add it after converting the fork to extents format having
not removed the ATTR_REPLACE flag.  This fails because the attr is no
longer present, causing a fs shutdown.

This is derived from the patch in his bug report, but we really
shouldn't ignore a nonzero retval from the remove call.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=199119
Reported-by: kanda.motohiro@gmail.com
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/xfs/libxfs/xfs_attr.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/fs/xfs/libxfs/xfs_attr.c
+++ b/fs/xfs/libxfs/xfs_attr.c
@@ -487,7 +487,14 @@ xfs_attr_shortform_addname(xfs_da_args_t
 		if (args->flags & ATTR_CREATE)
 			return retval;
 		retval = xfs_attr_shortform_remove(args);
-		ASSERT(retval == 0);
+		if (retval)
+			return retval;
+		/*
+		 * Since we have removed the old attr, clear ATTR_REPLACE so
+		 * that the leaf format add routine won't trip over the attr
+		 * not being around.
+		 */
+		args->flags &= ~ATTR_REPLACE;
 	}
 
 	if (args->namelen >= XFS_ATTR_SF_ENTSIZE_MAX ||


