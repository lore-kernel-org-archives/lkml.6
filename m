Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E02C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24F5F2146D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543643;
	bh=8zTbsHwHUCj8Jm9rml+fBhopPS8d+Jj545p2/dKMaQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1Stj8NqbXrvwMSIsL+Qjg6ISVJv9cTKMKZfk5oXDcVP2iVQMIDPQEo1CskbOKkSgV
	 uu9Iy+dUkIyFRFWC/3ggRI94XQRvV4bBuutzwAZ5iGOJOS3gs8weYu0z7lDbx1SZkG
	 BYFX7UcVSfOQZmYc5nvuDisYYo0M81oYzphv5CNw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24F5F2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730053AbeLKPyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:54:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:42636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728117AbeLKPx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:53:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75CF320855;
        Tue, 11 Dec 2018 15:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543638;
        bh=8zTbsHwHUCj8Jm9rml+fBhopPS8d+Jj545p2/dKMaQQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oVTiJKSlwcwfKwJs+byzKXyi/k5py0RPzdWKiz06UxZOvEdFv66OC/SiBhpalPmul
         oOOpYconF2IW1wDh01Edf3taTXGaLia5uhTb+qyDTQ9ZxZdqXx1qlV+/pUYI/5putf
         Z5vZd3GdlTBAnyyByea5CcJItfft/haGxEoq08Ao=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bin Liu <b-liu@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 4.14 45/67] dmaengine: cppi41: delete channel from pending list when stop channel
Date:   Tue, 11 Dec 2018 16:41:45 +0100
Message-Id: <20181211151632.665406751@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151630.378216233@linuxfoundation.org>
References: <20181211151630.378216233@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bin Liu <b-liu@ti.com>

commit 59861547ec9a9736e7882f6fb0c096a720ff811a upstream.

The driver defines three states for a cppi channel.
- idle: .chan_busy == 0 && not in .pending list
- pending: .chan_busy == 0 && in .pending list
- busy: .chan_busy == 1 && not in .pending list

There are cases in which the cppi channel could be in the pending state
when cppi41_dma_issue_pending() is called after cppi41_runtime_suspend()
is called.

cppi41_stop_chan() has a bug for these cases to set channels to idle state.
It only checks the .chan_busy flag, but not the .pending list, then later
when cppi41_runtime_resume() is called the channels in .pending list will
be transitioned to busy state.

Removing channels from the .pending list solves the problem.

Fixes: 975faaeb9985 ("dma: cppi41: start tear down only if channel is busy")
Cc: stable@vger.kernel.org # v3.15+
Signed-off-by: Bin Liu <b-liu@ti.com>
Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/dma/cppi41.c |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

--- a/drivers/dma/cppi41.c
+++ b/drivers/dma/cppi41.c
@@ -723,8 +723,22 @@ static int cppi41_stop_chan(struct dma_c
 
 	desc_phys = lower_32_bits(c->desc_phys);
 	desc_num = (desc_phys - cdd->descs_phys) / sizeof(struct cppi41_desc);
-	if (!cdd->chan_busy[desc_num])
+	if (!cdd->chan_busy[desc_num]) {
+		struct cppi41_channel *cc, *_ct;
+
+		/*
+		 * channels might still be in the pendling list if
+		 * cppi41_dma_issue_pending() is called after
+		 * cppi41_runtime_suspend() is called
+		 */
+		list_for_each_entry_safe(cc, _ct, &cdd->pending, node) {
+			if (cc != c)
+				continue;
+			list_del(&cc->node);
+			break;
+		}
 		return 0;
+	}
 
 	ret = cppi41_tear_down_chan(c);
 	if (ret)


