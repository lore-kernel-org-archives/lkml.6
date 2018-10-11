Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7DCC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FCF7213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="x3at+oX0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FCF7213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbeJKXEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:04:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:60692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728128AbeJKXEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:04:55 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1FA3213A2;
        Thu, 11 Oct 2018 15:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272232;
        bh=ldYmrZZoUI2xa5gQiTrjMlIHYfis+cMhruqBuyVr0co=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x3at+oX06uUidoyxXDEZbsK7g+LDbqNhaCqUpWJlTgsUCcJqvVqQt+Zy0gcTYBNTd
         AfFEmjgYKyklN2WjH0Yxk6C1C37uNxv3sb/q1n3IqWYwEUfQtyyCzOvhdoZmRHqQ7P
         98JYeqjnUcwWRNpeNOzcYC6SBSToLVbIFLxcDd3Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Todd Kjos <tkjos@android.com>,
        devel@driverdev.osuosl.org, kernel-team@android.com,
        Joel Fernandes <joel@joelfernandes.org>,
        Alistair Strachan <astrachan@google.com>,
        Martijn Coenen <maco@android.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 036/120] staging: android: ashmem: Fix mmap size validation
Date:   Thu, 11 Oct 2018 17:33:37 +0200
Message-Id: <20181011152551.227639293@linuxfoundation.org>
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

From: Alistair Strachan <astrachan@google.com>

[ Upstream commit 8632c614565d0c5fdde527889601c018e97b6384 ]

The ashmem driver did not check that the size/offset of the vma passed
to its .mmap() function was not larger than the ashmem object being
mapped. This could cause mmap() to succeed, even though accessing parts
of the mapping would later fail with a segmentation fault.

Ensure an error is returned by the ashmem_mmap() function if the vma
size is larger than the ashmem object size. This enables safer handling
of the problem in userspace.

Cc: Todd Kjos <tkjos@android.com>
Cc: devel@driverdev.osuosl.org
Cc: linux-kernel@vger.kernel.org
Cc: kernel-team@android.com
Cc: Joel Fernandes <joel@joelfernandes.org>
Signed-off-by: Alistair Strachan <astrachan@google.com>
Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Reviewed-by: Martijn Coenen <maco@android.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/android/ashmem.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/staging/android/ashmem.c
+++ b/drivers/staging/android/ashmem.c
@@ -370,6 +370,12 @@ static int ashmem_mmap(struct file *file
 		goto out;
 	}
 
+	/* requested mapping size larger than object size */
+	if (vma->vm_end - vma->vm_start > PAGE_ALIGN(asma->size)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	/* requested protection bits must match our allowed protection mask */
 	if (unlikely((vma->vm_flags & ~calc_vm_prot_bits(asma->prot_mask)) &
 		     calc_vm_prot_bits(PROT_MASK))) {


