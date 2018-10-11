Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F86C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F1152087A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xS6xSI86"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F1152087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbeJKXEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:04:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:60202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728128AbeJKXEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:04:43 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB2DC2147C;
        Thu, 11 Oct 2018 15:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272221;
        bh=NnIhdksCZqb+Dr0vRIBAIQxeKv0A+Ofxed59dCAsiy4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xS6xSI86seIoF+OfHt76EBJ1SS2vdPnq/rQZnVxG0caavTLJB855dPyF+0jdjNWq5
         2ZGtd9uFJFxA3dglQyFuP7HmLT1V++mJmmDXyVCOeTBwP68T47as2ZSyNbBJvhmGxO
         6lKk95DCDfiAADe8p9/AewlQ6mvMU6EzWKZUOAa4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 032/120] s390/extmem: fix gcc 8 stringop-overflow warning
Date:   Thu, 11 Oct 2018 17:33:33 +0200
Message-Id: <20181011152550.998527629@linuxfoundation.org>
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

From: Vasily Gorbik <gor@linux.ibm.com>

[ Upstream commit 6b2ddf33baec23dace85bd647e3fc4ac070963e8 ]

arch/s390/mm/extmem.c: In function '__segment_load':
arch/s390/mm/extmem.c:436:2: warning: 'strncat' specified bound 7 equals
source length [-Wstringop-overflow=]
  strncat(seg->res_name, " (DCSS)", 7);

What gcc complains about here is the misuse of strncat function, which
in this case does not limit a number of bytes taken from "src", so it is
in the end the same as strcat(seg->res_name, " (DCSS)");

Keeping in mind that a res_name is 15 bytes, strncat in this case
would overflow the buffer and write 0 into alignment byte between the
fields in the struct. To avoid that increasing res_name size to 16,
and reusing strlcat.

Reviewed-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/mm/extmem.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/s390/mm/extmem.c
+++ b/arch/s390/mm/extmem.c
@@ -80,7 +80,7 @@ struct qin64 {
 struct dcss_segment {
 	struct list_head list;
 	char dcss_name[8];
-	char res_name[15];
+	char res_name[16];
 	unsigned long start_addr;
 	unsigned long end;
 	atomic_t ref_count;
@@ -445,7 +445,7 @@ __segment_load (char *name, int do_nonsh
 	memcpy(&seg->res_name, seg->dcss_name, 8);
 	EBCASC(seg->res_name, 8);
 	seg->res_name[8] = '\0';
-	strncat(seg->res_name, " (DCSS)", 7);
+	strlcat(seg->res_name, " (DCSS)", sizeof(seg->res_name));
 	seg->res->name = seg->res_name;
 	rc = seg->vm_segtype;
 	if (rc == SEG_TYPE_SC ||


