Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7EFC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 329612087A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dqqFKMaW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 329612087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbeJKXFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:05:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:33846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727569AbeJKXFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:05:31 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 020512087A;
        Thu, 11 Oct 2018 15:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272268;
        bh=noSkj90QdSodjf/AaO+4UpY8JBGTQACIZdL5gE6r8Ig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dqqFKMaWVFOvttzpz1PRRZvRyQy7en47HODuUu2gYYe80MEm7KMDPcifsuR2I4ovw
         T7Pq8/eTY/zVztc09eIEYhmLEgKIDSAkuyan/Y5t9gfOgMNwS2a+v0MIcmFyUTFvF5
         f2u77RKy+XV6ekJSs5CIRNR3o6Y28qrs8sD/aHWQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andy Whitcroft <apw@canonical.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3.18 048/120] floppy: Do not copy a kernel pointer to user memory in FDGETPRM ioctl
Date:   Thu, 11 Oct 2018 17:33:49 +0200
Message-Id: <20181011152551.722569432@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152549.500488630@linuxfoundation.org>
References: <20181011152549.500488630@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

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


