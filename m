Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F019C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 562082147C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789029;
	bh=rmTb5UOv47vg4kth5Zv6gCy5saXcBqdhnMZlaBAIuNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2bNmegtwnWkJZ0jR0jKM2p69amgY70dHVuzWhiJ9VnL0mhUFVnb34R1NeiRJzm70o
	 riGGIC1//GNG+ufAvZ7WUZDF8x3vZxyUC68SMvttjG1dGtIwU7kG4xh2vBDdu8FQZa
	 cQGFnMOkICVyMGRnb7GU+BKbtJopJr/EykZ99b+o=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 562082147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbeLNMDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:03:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:47856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729821AbeLNMDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:03:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A50B2146E;
        Fri, 14 Dec 2018 12:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789024;
        bh=rmTb5UOv47vg4kth5Zv6gCy5saXcBqdhnMZlaBAIuNA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w3aVwJpUUAbjFNEuxl/6/a6ktyY/akKOczmki/kBNLGyfn3n2sJwU8fmkgGDT4HxJ
         mW2rXgg4x07dVDNkL77aEBtmqmJs+KoJ0wnQpKEQAb2LHjmIPcqD3r0cZziVdXMFnz
         6uOFcuvQeoGsMxvVaZ6DBRnak+yZybTHNzZsIxoo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Keyon Jie <yang.jie@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 064/142] ASoC: acpi: fix: continue searching when machine is ignored
Date:   Fri, 14 Dec 2018 12:59:09 +0100
Message-Id: <20181214115749.617884539@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
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

[ Upstream commit a3e620f8422832afd832ad5e20aa97d0c72bada8 ]

The machine_quirk may return NULL which means the acpi entries should be
skipped and search for next matched entry is needed, here add return
check here and continue for NULL case.

Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-acpi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-acpi.c b/sound/soc/soc-acpi.c
index b8e72b52db30..4fb29f0e561e 100644
--- a/sound/soc/soc-acpi.c
+++ b/sound/soc/soc-acpi.c
@@ -10,11 +10,17 @@ struct snd_soc_acpi_mach *
 snd_soc_acpi_find_machine(struct snd_soc_acpi_mach *machines)
 {
 	struct snd_soc_acpi_mach *mach;
+	struct snd_soc_acpi_mach *mach_alt;
 
 	for (mach = machines; mach->id[0]; mach++) {
 		if (acpi_dev_present(mach->id, NULL, -1)) {
-			if (mach->machine_quirk)
-				mach = mach->machine_quirk(mach);
+			if (mach->machine_quirk) {
+				mach_alt = mach->machine_quirk(mach);
+				if (!mach_alt)
+					continue; /* not full match, ignore */
+				mach = mach_alt;
+			}
+
 			return mach;
 		}
 	}
-- 
2.19.1



