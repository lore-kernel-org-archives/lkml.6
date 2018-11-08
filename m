Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18FEECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F25420844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PnwFfVPy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F25420844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731422AbeKIHmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:42:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:33814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727288AbeKIHmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:42:04 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3420120844;
        Thu,  8 Nov 2018 22:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714674;
        bh=OQjZHO8ahQgTJoaPl/DTNm3wYhuhLWl5/e0QgRphjbs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PnwFfVPyzVk5RFhNm3UkvLhXDN9d62ICy6XK+IinisfHa+2LKfNllIhn2HiX/I/Me
         zcc0PhE9jcdhF7/cq5auYuph/mVjyAb7S93DoHaGboey+Sgs+47YcNrqot5YOzZwDP
         iAvFRjQ2lmZxv7VlDzbLOpGbaVuaaYjNM8GlCb0E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shreyas NC <shreyas.nc@intel.com>,
        "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 060/171] ASoC: Intel: Skylake: Fix to parse consecutive string tkns in manifest
Date:   Thu,  8 Nov 2018 13:50:30 -0800
Message-Id: <20181108215131.886039683@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
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

[ Upstream commit 0a716776914ed9d7ca90b48041e6767693bfb672 ]

Element size in the manifest should be updated for each token, so that the
loop can parse all the string elements in the manifest. This was not
happening when more than two string elements appear consecutively, as it is
not updated with correct string element size. Fixed with this patch.

Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/skylake/skl-topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index bef8a4546c12..b0c154d5924b 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -2325,7 +2325,7 @@ static int skl_tplg_get_manifest_tkn(struct device *dev,
 
 			if (ret < 0)
 				return ret;
-			tkn_count += ret;
+			tkn_count = ret;
 
 			tuple_size += tkn_count *
 				sizeof(struct snd_soc_tplg_vendor_string_elem);
-- 
2.17.1



