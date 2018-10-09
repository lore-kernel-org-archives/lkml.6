Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FB3C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AC9F214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="UY+Osic1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AC9F214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbeJISac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:30:32 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45804 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbeJISab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:30:31 -0400
Received: by mail-pf1-f193.google.com with SMTP id u12-v6so659895pfn.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cVE8QAHSKwbZCuFwtDriA/w50/SsD44nW2TsoCxLFiY=;
        b=UY+Osic1dkywK30vBG/0XDMGI01PhPRWkMwdxlhmIvy6IXreiMLCxf7W12cRrqWiHy
         EHVzacC51h7is1t9qqWvixGOr/pAlBW5sOE2feXa3eDE6CNZQdpZYDhk9+QnKkFu99zT
         5HAsbt5laVRKZ5AskDW65elwm9YRyP7Caj5wx6Hk/oPrzSvE8MGY3YXozzhFfPmkdGs7
         nCASKLrrwUP1G6DiE1p1mB3OkWj1ufPZGXMgg3Ooh9oJUAP+dyQMw/xB0D7PmL0r4uMC
         S51Xv0UWqctZQ+xsVFfOP0buYdet5D5+PQx4YNmPtoB7HjjKg214xJLlSfNkb02zOE+X
         dnmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cVE8QAHSKwbZCuFwtDriA/w50/SsD44nW2TsoCxLFiY=;
        b=gcfGCX5A1WbIzpaBBOaKaBwYySVYRLANHNhdN6WNfGaQ/C0HmpAvy/0Hd8UcsRwPVE
         4AANMD7TMXFW+9hGUoY+ND8Z07H6uxT2ZhlA0fOQUMkCBiwbZqO4XvytY2/AVfs/5m10
         /o1d6FjCf4+73OrwnuC08jSTUv7fjNR+dY8gPQAPF6qIAz3OtoLLBerOhVMBiWMWZ+Qy
         NH0wDmW/PPz5sDbJ/ZfRA57suTjwgZ07zPrWgzU3D9ri7pVfj3Po/lo/ISH08z18UBFN
         sQTaiS9/m8Poay1M0uP+Eg1TjnAr/4w5UoetCKyHvUoNnJ2w1YXcVDigjhatxLq0Wl1o
         Xzbg==
X-Gm-Message-State: ABuFfoifF/zv9jEWMyOR4R/o+Ddg+QTuY4f5U41bzKCGQdmCZeNGB5JR
        iz9Gbf2ALgsCOhZ7mWuOSWq+Bw==
X-Google-Smtp-Source: ACcGV608Kg/hsZNoz1ZZEjvkEV35ZHVimSwf9G/716lUdHDjy61X5KL63z7nxS4WIQdEof/SXQMRLQ==
X-Received: by 2002:a63:cb51:: with SMTP id m17-v6mr24565179pgi.105.1539083644658;
        Tue, 09 Oct 2018 04:14:04 -0700 (PDT)
Received: from skyninja.hgst.com (rap-us.hgst.com. [199.255.44.250])
        by smtp.gmail.com with ESMTPSA id p1-v6sm25342380pff.128.2018.10.09.04.14.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 04:14:03 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 15/45] lightnvm: pblk: guarantee emeta on line close
Date:   Tue,  9 Oct 2018 13:11:45 +0200
Message-Id: <20181009111215.7653-16-mb@lightnvm.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181009111215.7653-1-mb@lightnvm.io>
References: <20181009111215.7653-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Javier González <javier@javigon.com>

If a line is recovered from open chunks, the memory structures for
emeta have not necessarily been properly set on line initialization.
When closing a line, make sure that emeta is consistent so that the line
can be recovered on the fast path on next reboot.

Also, remove a couple of empty lines at the end of the function.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-core.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 36ac9eff8ebd..a31417682c90 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1775,6 +1775,17 @@ void pblk_line_close_meta(struct pblk *pblk, struct pblk_line *line)
 	wa->pad = cpu_to_le64(atomic64_read(&pblk->pad_wa));
 	wa->gc = cpu_to_le64(atomic64_read(&pblk->gc_wa));
 
+	if (le32_to_cpu(emeta_buf->header.identifier) != PBLK_MAGIC) {
+		emeta_buf->header.identifier = cpu_to_le32(PBLK_MAGIC);
+		memcpy(emeta_buf->header.uuid, pblk->instance_uuid, 16);
+		emeta_buf->header.id = cpu_to_le32(line->id);
+		emeta_buf->header.type = cpu_to_le16(line->type);
+		emeta_buf->header.version_major = EMETA_VERSION_MAJOR;
+		emeta_buf->header.version_minor = EMETA_VERSION_MINOR;
+		emeta_buf->header.crc = cpu_to_le32(
+			pblk_calc_meta_header_crc(pblk, &emeta_buf->header));
+	}
+
 	emeta_buf->nr_valid_lbas = cpu_to_le64(line->nr_valid_lbas);
 	emeta_buf->crc = cpu_to_le32(pblk_calc_emeta_crc(pblk, emeta_buf));
 
@@ -1792,8 +1803,6 @@ void pblk_line_close_meta(struct pblk *pblk, struct pblk_line *line)
 	spin_unlock(&l_mg->close_lock);
 
 	pblk_line_should_sync_meta(pblk);
-
-
 }
 
 static void pblk_save_lba_list(struct pblk *pblk, struct pblk_line *line)
-- 
2.17.1

