Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011BEC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4AB9218A4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545151281;
	bh=mnjMX0797Uv3UdB7xBFPnFxvakE/x4AxwlLEW37WZ00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZWSgfrlj5InYV/NjFUvNk7gLQeRFtjlyWGQ6EemWprVxemQkrbq++1Ek3qeV2NzY5
	 J0j2H21nnIo1oIIzVDNbx+gNDwY/bt1YszUAPlNWB9jgrjHadWmiqNGeAq5ypYYGOF
	 onb47MnL3hzeEi8M+NXYS2driBG5H56dGFkjcv0U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbeLRQlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:41:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:38766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbeLRQlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:41:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DF69218B0;
        Tue, 18 Dec 2018 16:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545151278;
        bh=mnjMX0797Uv3UdB7xBFPnFxvakE/x4AxwlLEW37WZ00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=loMgYHt0B/h9CmDx2B+93E9HCcCO6I8Nvj0YwJ2Q6KSdIDO67P1oWXetysTlJNUFq
         rMYGGVSSXpnPAWyDOwRpBs5aiCR2g/urohGuuDRDI0k62o6k7UaA0bavlQq4fcJrCu
         6ktwmEgMKMPAGsNdR5gfKj8W3APyY7mC2/MLygIU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.19 26/44] dm: call blk_queue_split() to impose device limits on bios
Date:   Tue, 18 Dec 2018 17:39:38 +0100
Message-Id: <20181218163930.574401907@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181218163927.119623235@linuxfoundation.org>
References: <20181218163927.119623235@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Snitzer <snitzer@redhat.com>

commit 89f5fa47476eda56402e29fff3c5097f5c2a1e19 upstream.

Otherwise the incoming bios, of various types, won't be shaped based on
the DM device's advertised limits.

Depends-on: af67c31fba ("blk: remove bio_set arg from blk_queue_split()")
Fixes: 744889b7cb ("block: don't deal with discard limit in blkdev_issue_discard()")
Cc: stable@vger.kernel.org
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1592,6 +1592,8 @@ static blk_qc_t __split_and_process_bio(
 		return ret;
 	}
 
+	blk_queue_split(md->queue, &bio);
+
 	init_clone_info(&ci, md, map, bio);
 
 	if (bio->bi_opf & REQ_PREFLUSH) {


