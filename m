Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45D5C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8DE9218FE
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358048;
	bh=S3z5Z7vwTmQ0Fp7AL/Eoltw3aCLKYcbnQoziOjfQ4Xk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W+GxEsxb+3nm87knOqJVq7Z07GP9fcQLEhuI4SpZ3vxX34z0OF7eBrIeaiM5oGUEg
	 zGc5DfnjAYY9nzcZP7BXLGhOstuTtLjdhKGqGVLBSd07XV/4IHwngtOnjgzrU5uKgr
	 dPV2PKwUf9gM+7Uk9DnrUPoVKEVmwA6okn133X6g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730765AbfAXT10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:27:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:53626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729344AbfAXT1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:27:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6004218A6;
        Thu, 24 Jan 2019 19:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358042;
        bh=S3z5Z7vwTmQ0Fp7AL/Eoltw3aCLKYcbnQoziOjfQ4Xk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C4CPyWr+RzbeK+Dtft0uCYnRJBTAp+5iIHS9Nh+nPiHSq+q/rt49ChlOu+gzyZA7X
         +FpPDKSWnqH+VzwBzAiLexdHCuAQFhBBlahgv75Dq/VeeYQHtrcVQsUnwwoaPRcf4p
         OXEYWdBolyeWzHMiE07IdI+wPkZV3joQo5EoPcZU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kanda.motohiro@gmail.com,
        Dave Chinner <dchinner@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 076/104] xfs: dont fail when converting shortform attr to long form during ATTR_REPLACE
Date:   Thu, 24 Jan 2019 20:20:05 +0100
Message-Id: <20190124190203.830027862@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190154.968308875@linuxfoundation.org>
References: <20190124190154.968308875@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Darrick J. Wong <darrick.wong@oracle.com>

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
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/xfs/libxfs/xfs_attr.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/fs/xfs/libxfs/xfs_attr.c
+++ b/fs/xfs/libxfs/xfs_attr.c
@@ -528,7 +528,14 @@ xfs_attr_shortform_addname(xfs_da_args_t
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


