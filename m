Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DDBC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F17BA2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="x8IcbpqO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F17BA2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387955AbeK3Bdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:33:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:34366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731863AbeK3Bdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:33:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C4DC2147C;
        Thu, 29 Nov 2018 14:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501685;
        bh=jYfZxsUAZxMztUw3UtO7YqsyZLpPyJm3LP7IPltutrE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x8IcbpqOK7S4Z0oTj0vUVLZun5yI61JXLSP+sCIE1lcNA9dVkK5u9BbOVKdzLTjKc
         DuwZtyus6wYbTqEN0+RacUwxLDrBCL69boz8OeoiK0kthhOzZh5u9FU7LzQOQrD/Xj
         ouu/q73Cgo/JpJof0g0cAzO7aodTJmBAnUNCa4eA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        James Morris <jmorris@namei.org>,
        Aditya Kali <adityakali@google.com>
Subject: [PATCH 4.14 100/100] ima: re-initialize iint->atomic_flags
Date:   Thu, 29 Nov 2018 15:13:10 +0100
Message-Id: <20181129140107.366467966@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140058.768942700@linuxfoundation.org>
References: <20181129140058.768942700@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mimi Zohar <zohar@linux.vnet.ibm.com>

commit e2598077dc6a26c9644393e5c21f22a90dbdccdb upstream.

Intermittently security.ima is not being written for new files.  This
patch re-initializes the new slab iint->atomic_flags field before
freeing it.

Fixes: commit 0d73a55208e9 ("ima: re-introduce own integrity cache lock")
Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Signed-off-by: James Morris <jmorris@namei.org>
Cc: Aditya Kali <adityakali@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/integrity/iint.c |    1 +
 1 file changed, 1 insertion(+)

--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -74,6 +74,7 @@ static void iint_free(struct integrity_i
 	iint->ima_hash = NULL;
 	iint->version = 0;
 	iint->flags = 0UL;
+	iint->atomic_flags = 0UL;
 	iint->ima_file_status = INTEGRITY_UNKNOWN;
 	iint->ima_mmap_status = INTEGRITY_UNKNOWN;
 	iint->ima_bprm_status = INTEGRITY_UNKNOWN;


