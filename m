Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF07C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A61BE21479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0g4ngElr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A61BE21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbeJSCEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:04:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:52932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729137AbeJSCEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:04:42 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 629D921476;
        Thu, 18 Oct 2018 18:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885755;
        bh=k9LU5b6CzKxkPoMUOM6QPPp7mO8SqAsy6cIRSGZbofI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0g4ngElr24wFSXE5gPUhk5vErWR6zHVr1cmKnWoIn14yAQrZglYvkFlUDEmrR0tla
         Z82CGcn1SJqH6n7s436B71deYDlxUhtgxv1eY8eFeTaNnDssaSKWO7nqnaFuQzloPR
         +4RtD15d/t6+QhRLyy5wQjXXXs0vz/iIt6NeZrEU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 12/35] scsi: ibmvscsis: Ensure partition name is properly NUL terminated
Date:   Thu, 18 Oct 2018 19:54:41 +0200
Message-Id: <20181018175424.436803476@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175422.506152522@linuxfoundation.org>
References: <20181018175422.506152522@linuxfoundation.org>
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

From: Laura Abbott <labbott@redhat.com>

[ Upstream commit adad633af7b970bfa5dd1b624a4afc83cac9b235 ]

While reviewing another part of the code, Kees noticed that the strncpy of the
partition name might not always be NUL terminated. Switch to using strscpy
which does this safely.

Reported-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Laura Abbott <labbott@redhat.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
+++ b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
@@ -3345,7 +3345,7 @@ static int ibmvscsis_probe(struct vio_de
 	snprintf(vscsi->eye, sizeof(vscsi->eye), "VSCSI %s", vdev->name);
 
 	vscsi->dds.unit_id = vdev->unit_address;
-	strncpy(vscsi->dds.partition_name, partition_name,
+	strscpy(vscsi->dds.partition_name, partition_name,
 		sizeof(vscsi->dds.partition_name));
 	vscsi->dds.partition_num = partition_number;
 


