Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E531CC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9EAB20989
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543291;
	bh=tkqLM6lFWKcrtN6dVs+yPtP+P5D4sR+NlWwH7jW6Pt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0EMG5OVKLvWNGVM3yFrvf8L6JyxVGCl2uoO3szF5rA6mTZjC9OmKU0XKc5qMsexck
	 NRRiLeiZ0tRMf+M00FKPSOC3u2BAWlF47tBbQcyNFDRh9+yoAofa9dNrHzH4wlyyVD
	 a50iqMTkhQNy4RhFITAMBMPQTDNewPLot1gEv1sI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9EAB20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbeLKPsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:48:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:36474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727974AbeLKPsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:48:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80B5C20870;
        Tue, 11 Dec 2018 15:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543288;
        bh=tkqLM6lFWKcrtN6dVs+yPtP+P5D4sR+NlWwH7jW6Pt8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OWkoOyiXieDoH/pEg674GgU27sU85tyBGRH9/MTKFHNX/MdPBebf+AIYgRAghfkin
         zQiJ4kwECxyt7SLv5xwgRz3TGsJ21mikG/PrL+puM4sl8k4Cknz/ziMMdtCYl4nG4a
         E2UC3ywPt2zGtD+x06xVc/0UfNHW9QCrxDmaAyAM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Subject: [PATCH 4.4 83/91] Staging: lustre: remove two build warnings
Date:   Tue, 11 Dec 2018 16:41:42 +0100
Message-Id: <20181211151613.563272606@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151606.026852373@linuxfoundation.org>
References: <20181211151606.026852373@linuxfoundation.org>
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

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

[for older kernels only, lustre has been removed from upstream]

When someone writes:
	strncpy(dest, source, sizeof(source));
they really are just doing the same thing as:
	strcpy(dest, source);
but somehow they feel better because they are now using the "safe"
version of the string functions.  Cargo-cult programming at its
finest...

gcc-8 rightfully warns you about doing foolish things like this.  Now
that the stable kernels are all starting to be built using gcc-8, let's
get rid of this warning so that we do not have to gaze at this horror.

To dropt the warning, just convert the code to using strcpy() so that if
someone really wants to audit this code and find all of the obvious
problems, it will be easier to do so.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/lustre/lustre/lmv/lmv_obd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/lustre/lustre/lmv/lmv_obd.c
+++ b/drivers/staging/lustre/lustre/lmv/lmv_obd.c
@@ -700,7 +700,7 @@ repeat_fid2path:
 		memmove(ptr + strlen(gf->gf_path) + 1, ptr,
 			strlen(ori_gf->gf_path));
 
-		strncpy(ptr, gf->gf_path, strlen(gf->gf_path));
+		strcpy(ptr, gf->gf_path);
 		ptr += strlen(gf->gf_path);
 		*ptr = '/';
 	}


