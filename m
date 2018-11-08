Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 936EDC43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57A8520857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dANwcxkj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57A8520857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbeKIHdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:33:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:48800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727215AbeKIHdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:33:14 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86A6A20989;
        Thu,  8 Nov 2018 21:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714147;
        bh=AndK1FethAOJ112BIWbfZmRjOL+PzcjCFsTE8U73UZw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dANwcxkjp+uv1e54DRtDW+j4LVTgfT7nzb0zdAD3hEFueU6V/lVDmAk4FfagCPgQ8
         iYW8Dj1eWYIAYAhXSTnhQuKkRDX9/M2uJ9mwsFxskFRLkSD2Y6nun05ubggVMl6QzD
         vTjGryUjArAeyWz8ytD+A4R9NFY03ue177Mxf2F4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Sasha Levin <sasha.levin@oracle.com>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 059/144] scsi: ->queue_rq cant sleep
Date:   Thu,  8 Nov 2018 13:50:30 -0800
Message-Id: <20181108215059.117746183@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
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

[ Upstream commit 70a0f2c1898c6abf53670e55642b6e840b003892 ]

The blk-mq ->queue_rq method is always called from process context,
but might have preemption disabled.  This means we still always
have to use GFP_ATOMIC for memory allocations, and thus need to
revert part of commit 3c356bde1 ("scsi: stop passing a gfp_mask
argument down the command setup path").

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reported-by: Sasha Levin <sasha.levin@oracle.com>
Reviewed-by: Bart Van Assche <bart.vanassche@sandisk.com>
Tested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/scsi_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index a11837054d6c..0d5c218b7ad1 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -616,7 +616,7 @@ static int scsi_alloc_sgtable(struct scsi_data_buffer *sdb, int nents,
 	}
 
 	ret = __sg_alloc_table(&sdb->table, nents, SCSI_MAX_SG_SEGMENTS,
-			       first_chunk, gfp_mask, scsi_sg_alloc);
+			       first_chunk, GFP_ATOMIC, scsi_sg_alloc);
 	if (unlikely(ret))
 		scsi_free_sgtable(sdb, mq);
 	return ret;
-- 
2.17.1



