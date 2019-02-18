Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4241CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E0A21900
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550500090;
	bh=SPMAG4igAdygU6BU963VciuVoilrWvG8nV0EQdLiI/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=izEHzpjuiG4ifXlSbxbOKi0u69IugCGbVZYv5kMfyo+CLmQ9KRwwGVvVi8sv1AhR5
	 4C0VD0Wnyusb95O9iQshCI1wt+F7ClDCrlGS0jl4tKHY64alJkwB/lZ/h+u9JqW0ZB
	 r1F8Z6pwLY6n9saGVidxMUX2EAoDg7k2bS4/k8a8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389005AbfBROBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:01:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:42472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731415AbfBROBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:01:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B0FE20842;
        Mon, 18 Feb 2019 14:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498465;
        bh=SPMAG4igAdygU6BU963VciuVoilrWvG8nV0EQdLiI/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cQ4KkIHHoCU7AAMMs2MM9R0dBf4ry9dzl8onIZ0lHQR2o0vb8TyQje9iKRLdJokB3
         +1vVpMtCwre8fKAnri/5JnWFygk71R6TFwxu3x/MYJG1Fl3NlIcg8Mr1bdkITjO4OE
         ruAlxxdvmm6VMhEwIrU7Z6Ndx3+HvpUrThBqKXdY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 003/143] ASoC: Intel: mrfld: fix uninitialized variable access
Date:   Mon, 18 Feb 2019 14:42:11 +0100
Message-Id: <20190218133529.250159588@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133529.099444112@linuxfoundation.org>
References: <20190218133529.099444112@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 1539c7f23f256120f89f8b9ec53160790bce9ed2 ]

Randconfig testing revealed a very old bug, with gcc-8:

sound/soc/intel/atom/sst/sst_loader.c: In function 'sst_load_fw':
sound/soc/intel/atom/sst/sst_loader.c:357:5: error: 'fw' may be used uninitialized in this function [-Werror=maybe-uninitialized]
  if (fw == NULL) {
     ^
sound/soc/intel/atom/sst/sst_loader.c:354:25: note: 'fw' was declared here
  const struct firmware *fw;

We must check the return code of request_firmware() before we look at the
pointer result that may be uninitialized when the function fails.

Fixes: 9012c9544eea ("ASoC: Intel: mrfld - Add DSP load and management")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/atom/sst/sst_loader.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst_loader.c b/sound/soc/intel/atom/sst/sst_loader.c
index 33917146d9c4..054b1d514e8a 100644
--- a/sound/soc/intel/atom/sst/sst_loader.c
+++ b/sound/soc/intel/atom/sst/sst_loader.c
@@ -354,14 +354,14 @@ static int sst_request_fw(struct intel_sst_drv *sst)
 	const struct firmware *fw;
 
 	retval = request_firmware(&fw, sst->firmware_name, sst->dev);
-	if (fw == NULL) {
-		dev_err(sst->dev, "fw is returning as null\n");
-		return -EINVAL;
-	}
 	if (retval) {
 		dev_err(sst->dev, "request fw failed %d\n", retval);
 		return retval;
 	}
+	if (fw == NULL) {
+		dev_err(sst->dev, "fw is returning as null\n");
+		return -EINVAL;
+	}
 	mutex_lock(&sst->sst_lock);
 	retval = sst_cache_and_parse_fw(sst, fw);
 	mutex_unlock(&sst->sst_lock);
-- 
2.19.1



