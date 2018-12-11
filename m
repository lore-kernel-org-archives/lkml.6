Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B7CC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB0F620879
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544545215;
	bh=SIkK50BqF7lpxzTVb4B+qTp4nRS740r7O8/xmP1Jb4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BzrFpG6o7J53NUy3Q0aPAbC33L9Zjy6/TIQ3zYmygz8ZlSVWlDaqelkDVOqAUcrrr
	 YYoLe3BLGwDVdKs9tkfzNnuWtjaW53PCq08RaJrTfUoyWXJGQaZoZSrFoFbGRPN6Jq
	 +wHIhXn9PUnNkEcAzR9HzNS3yFHttF30bVxurR0o=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB0F620879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbeLKPpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:45:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:33746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728072AbeLKPpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:45:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6A8D20870;
        Tue, 11 Dec 2018 15:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543119;
        bh=SIkK50BqF7lpxzTVb4B+qTp4nRS740r7O8/xmP1Jb4A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jPDUHc+WiPgk1kmmuNGEDTu1ZiKGBwKxWHwUJD3SqOPn4uvQWv6e39VVHEcvK0hcC
         NGb4DKq2YZTNzmfZ/zbt6CjRUGSWGHXhYIzzCCvzuCOTtl47+rjz4aU04+4jsnf8Ny
         uJ9GoSQ9T5OzYMZl4UwgGJyYAXaezMhJZqbQIpXg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anand Jain <anand.jain@oracle.com>,
        Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.4 09/91] Btrfs: ensure path name is null terminated at btrfs_control_ioctl
Date:   Tue, 11 Dec 2018 16:40:28 +0100
Message-Id: <20181211151606.720304800@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151606.026852373@linuxfoundation.org>
References: <20181211151606.026852373@linuxfoundation.org>
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

From: Filipe Manana <fdmanana@suse.com>

commit f505754fd6599230371cb01b9332754ddc104be1 upstream.

We were using the path name received from user space without checking that
it is null terminated. While btrfs-progs is well behaved and does proper
validation and null termination, someone could call the ioctl and pass
a non-null terminated patch, leading to buffer overrun problems in the
kernel.  The ioctl is protected by CAP_SYS_ADMIN.

So just set the last byte of the path to a null character, similar to what
we do in other ioctls (add/remove/resize device, snapshot creation, etc).

CC: stable@vger.kernel.org # 4.4+
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/super.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2104,6 +2104,7 @@ static long btrfs_control_ioctl(struct f
 	vol = memdup_user((void __user *)arg, sizeof(*vol));
 	if (IS_ERR(vol))
 		return PTR_ERR(vol);
+	vol->name[BTRFS_PATH_NAME_MAX] = '\0';
 
 	switch (cmd) {
 	case BTRFS_IOC_SCAN_DEV:


