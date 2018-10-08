Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86657C677E4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5021920C0A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRXXtdoe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5021920C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbeJIBqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:46:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:56090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726391AbeJIBqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:46:10 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0A3A214C2;
        Mon,  8 Oct 2018 18:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539023587;
        bh=8kXdofA31gJM5xYKN94LJj2vwEOAW6KwsmzmYTDKMvA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XRXXtdoeJT4JwYbnFxXUXan1BIPwxu4UfKLBzkSjQRTeJ+JLMYdfxJYyehZJLiN29
         abzXLVSFykMlVjFDvuqJL7hpJWCR+bC70FlP1aYkR7s/9rbDR9moK8xqP9E6dBf5AH
         gLwTidOQO1e/E3SsoVF+2EAeHWbezOXj7nK7vCv8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bart Van Assche <bart.vanassche@wdc.com>,
        Mike Christie <mchristi@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 017/113] scsi: target/iscsi: Make iscsit_ta_authentication() respect the output buffer size
Date:   Mon,  8 Oct 2018 20:30:18 +0200
Message-Id: <20181008175531.696714965@linuxfoundation.org>
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

From: Bart Van Assche <bart.vanassche@wdc.com>

[ Upstream commit 35bea5c84fd13c643cce63f0b5cd4b148f8c901d ]

Fixes: e48354ce078c ("iscsi-target: Add iSCSI fabric support for target v4.1")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Reviewed-by: Mike Christie <mchristi@redhat.com>
Cc: Mike Christie <mchristi@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/target/iscsi/iscsi_target_tpg.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/target/iscsi/iscsi_target_tpg.c
+++ b/drivers/target/iscsi/iscsi_target_tpg.c
@@ -637,8 +637,7 @@ int iscsit_ta_authentication(struct iscs
 		none = strstr(buf1, NONE);
 		if (none)
 			goto out;
-		strncat(buf1, ",", strlen(","));
-		strncat(buf1, NONE, strlen(NONE));
+		strlcat(buf1, "," NONE, sizeof(buf1));
 		if (iscsi_update_param_value(param, buf1) < 0)
 			return -EINVAL;
 	}


