Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745AFC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44D42206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:39:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44D42206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732684AbeJBUXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:23:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36416 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731738AbeJBUUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:20:10 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A3B84C4D;
        Tue,  2 Oct 2018 13:36:45 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andy Whitcroft <apw@canonical.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.9 55/94] floppy: Do not copy a kernel pointer to user memory in FDGETPRM ioctl
Date:   Tue,  2 Oct 2018 06:25:09 -0700
Message-Id: <20181002132504.305314925@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132500.494838053@linuxfoundation.org>
References: <20181002132500.494838053@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

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


