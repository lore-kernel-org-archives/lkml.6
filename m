Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782FCC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C442086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VA/3pjuo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40C442086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731039AbeKTC5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:57:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:55884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730994AbeKTC5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:57:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53FE920831;
        Mon, 19 Nov 2018 16:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645189;
        bh=h6AjJtYJ6IwQYxJYPeFEa62odsMb8A+BmxZjGfgOT4g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VA/3pjuoA1v6VFnHhuYWW/r4J4U082kJQEUk33jr8g2x5tk/N9ooPCTkQfH8eOykG
         jY/4t2yCUKbiFchQdkaJv1mpeI40imwYqFHV2wBmGAW1aCMX9m/WCvlfXzYdiqhELW
         3fOUZTNOz82laCt9eEV2ix9KaNFBQ22+YHWuZHlU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.19 063/205] vfs: fix FIGETBSZ ioctl on an overlayfs file
Date:   Mon, 19 Nov 2018 17:26:10 +0100
Message-Id: <20181119162628.429957848@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amir Goldstein <amir73il@gmail.com>

commit 8f97d1e99149a7f1aa19e47a51b09764382a482e upstream.

Some anon_bdev filesystems (e.g. overlayfs, ceph) don't have s_blocksize
set. Returning zero from FIGETBSZ ioctl results in a Floating point
exception from the e2fsprogs utility filefrag, which divides the size of
the file with the value returned by FIGETBSZ.

Fix the interface by returning -EINVAL for these filesystems.

Fixes: d1d04ef8572b ("ovl: stack file ops")
Cc: <stable@vger.kernel.org> # v4.19
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ioctl.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -669,6 +669,9 @@ int do_vfs_ioctl(struct file *filp, unsi
 		return ioctl_fiemap(filp, arg);
 
 	case FIGETBSZ:
+		/* anon_bdev filesystems may not have a block size */
+		if (!inode->i_sb->s_blocksize)
+			return -EINVAL;
 		return put_user(inode->i_sb->s_blocksize, argp);
 
 	case FICLONE:


