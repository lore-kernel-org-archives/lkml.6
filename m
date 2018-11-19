Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B9BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A15322147A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4s/YZCn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A15322147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390793AbeKTDRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:17:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:56346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389985AbeKTDRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:17:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F242208E3;
        Mon, 19 Nov 2018 16:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646412;
        bh=LL82iOXyBwnwuKMu4mTYbEjv8GtaP3c+jr0v7bRAIZ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I4s/YZCnGnDTw+1AbrfuPOTQhcIaUDOZ30c5ag0PfCw9V32WQD+zWfDbyqij+3PR+
         SqUPKBF2zsTT3F95uwv/VV3qeJz3eI0vOMLP9WCfvjnJtchBKe8MCxHvVfiRLOlROr
         YVki8JK16f8yVw70HrQioHcEOMJLF7TqgTDWFWdc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 06/83] media: pci: cx23885: handle adding to list failure
Date:   Mon, 19 Nov 2018 17:28:32 +0100
Message-Id: <20181119162613.259718558@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162612.046511542@linuxfoundation.org>
References: <20181119162612.046511542@linuxfoundation.org>
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

From: Nicholas Mc Guire <hofrat@osadl.org>

[ Upstream commit c5d59528e24ad22500347b199d52b9368e686a42 ]

altera_hw_filt_init() which calls append_internal() assumes
that the node was successfully linked in while in fact it can
silently fail. So the call-site needs to set return to -ENOMEM
on append_internal() returning NULL and exit through the err path.

Fixes: 349bcf02e361 ("[media] Altera FPGA based CI driver module")

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/pci/cx23885/altera-ci.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/drivers/media/pci/cx23885/altera-ci.c
+++ b/drivers/media/pci/cx23885/altera-ci.c
@@ -660,6 +660,10 @@ static int altera_hw_filt_init(struct al
 		}
 
 		temp_int = append_internal(inter);
+		if (!temp_int) {
+			ret = -ENOMEM;
+			goto err;
+		}
 		inter->filts_used = 1;
 		inter->dev = config->dev;
 		inter->fpga_rw = config->fpga_rw;
@@ -694,6 +698,7 @@ err:
 		     __func__, ret);
 
 	kfree(pid_filt);
+	kfree(inter);
 
 	return ret;
 }
@@ -728,6 +733,10 @@ int altera_ci_init(struct altera_ci_conf
 		}
 
 		temp_int = append_internal(inter);
+		if (!temp_int) {
+			ret = -ENOMEM;
+			goto err;
+		}
 		inter->cis_used = 1;
 		inter->dev = config->dev;
 		inter->fpga_rw = config->fpga_rw;
@@ -796,6 +805,7 @@ err:
 	ci_dbg_print("%s: Cannot initialize CI: Error %d.\n", __func__, ret);
 
 	kfree(state);
+	kfree(inter);
 
 	return ret;
 }


