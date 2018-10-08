Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DFEC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6BC220C0A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDwVPhpH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6BC220C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbeJIBre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:47:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:58850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726665AbeJIBrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:47:33 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B1872087D;
        Mon,  8 Oct 2018 18:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539023670;
        bh=Z5q3h5GzmJzU6ohR4DC9HAlL9STfjU92vOugySZdZc0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HDwVPhpHRoeUjJZw2sPgee2y9CyI3vPdTtA+fq/o1g2yPXYpNP0WUI/6ddYnpIP87
         fySn1sZrLqAuh/NUTwTtj/ykr5KdY6n0uaP1jNRKk6j5aq9i/cS+XbP64GXijxfX9i
         Oa1N64/1PqxfH6umusUYMxJ42qIaIb5LnGcBLPJk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andy Whitcroft <apw@canonical.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.4 043/113] floppy: Do not copy a kernel pointer to user memory in FDGETPRM ioctl
Date:   Mon,  8 Oct 2018 20:30:44 +0200
Message-Id: <20181008175532.968002656@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175530.864641368@linuxfoundation.org>
References: <20181008175530.864641368@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Whitcroft <apw@canonical.com>

commit 65eea8edc315589d6c993cf12dbb5d0e9ef1fe4e upstream.

The final field of a floppy_struct is the field "name", which is a pointer
to a string in kernel memory.  The kernel pointer should not be copied to
user memory.  The FDGETPRM ioctl copies a floppy_struct to user memory,
including this "name" field.  This pointer cannot be used by the user
and it will leak a kernel address to user-space, which will reveal the
location of kernel code and data and undermine KASLR protection.

Model this code after the compat ioctl which copies the returned data
to a previously cleared temporary structure on the stack (excluding the
name pointer) and copy out to userspace from there.  As we already have
an inparam union with an appropriate member and that memory is already
cleared even for read only calls make use of that as a temporary store.

Based on an initial patch by Brian Belleville.

CVE-2018-7755
Signed-off-by: Andy Whitcroft <apw@canonical.com>
Broke up long line.
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/floppy.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -3459,6 +3459,9 @@ static int fd_locked_ioctl(struct block_
 					  (struct floppy_struct **)&outparam);
 		if (ret)
 			return ret;
+		memcpy(&inparam.g, outparam,
+				offsetof(struct floppy_struct, name));
+		outparam = &inparam.g;
 		break;
 	case FDMSGON:
 		UDP->flags |= FTD_MSG;


