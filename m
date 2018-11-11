Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B483C43610
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33D6820818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZX1RDayp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33D6820818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387545AbeKLJhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:37:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:39252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733161AbeKLISs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:18:48 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9192C21780;
        Sun, 11 Nov 2018 22:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975332;
        bh=QMRfcFLPkojpwkaj+58X/PIDME6X3u4urRE5qTdJWWs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZX1RDayp/DI2divOktMw5ZZXexAoWkpkIJ6Cuq9NQikFJZp/KSOXxlgp+yLEZJ2yU
         whXpOV4iCjER7S4EBhvUMzkzN6nrbM1mxhyxZHkHleyespu62tz+wBhMTMc24vOErG
         zrkB48X2Z773ATnD6+4VTUkqYltKarKpuDy1NkE0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>
Subject: [PATCH 4.19 321/361] soc: qcom: rmtfs-mem: Validate that scm is available
Date:   Sun, 11 Nov 2018 14:21:08 -0800
Message-Id: <20181111221659.103707839@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bjorn Andersson <bjorn.andersson@linaro.org>

commit 137dc5843faeacabf48fc22a8dc58c4e0b4f0927 upstream.

The scm device must be present in order for the rmtfs driver to
configure memory permissions for the rmtfs memory region, so check that
it is probed before continuing.

Cc: stable@vger.kernel.org
Fixes: fa65f8045137 ("soc: qcom: rmtfs-mem: Add support for assigning memory to remote")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Andy Gross <andy.gross@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/soc/qcom/rmtfs_mem.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/soc/qcom/rmtfs_mem.c
+++ b/drivers/soc/qcom/rmtfs_mem.c
@@ -212,6 +212,11 @@ static int qcom_rmtfs_mem_probe(struct p
 		dev_err(&pdev->dev, "failed to parse qcom,vmid\n");
 		goto remove_cdev;
 	} else if (!ret) {
+		if (!qcom_scm_is_available()) {
+			ret = -EPROBE_DEFER;
+			goto remove_cdev;
+		}
+
 		perms[0].vmid = QCOM_SCM_VMID_HLOS;
 		perms[0].perm = QCOM_SCM_PERM_RW;
 		perms[1].vmid = vmid;


