Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05AEAC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2EF021582
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WyUA22eO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2EF021582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404821AbeKLIYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:24:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:60436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731232AbeKLIYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:24:48 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 131DE21582;
        Sun, 11 Nov 2018 22:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975690;
        bh=WoqFtV62gsD+RnfJuelnS5y0Knl00lrTSYwTRR0Z3QM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WyUA22eOSJVDtY+XgqkKA6BCZX7Uoj5VV16+WhmEoA1G4VVCHv7n8zjOD2t1bl3Gh
         LP4KctQco4rjQxoEnfrEX3qEDObiNQgBm1NC4WEvzqXiJrdJSq6w1ADvQdTe2OyxF3
         mSZtQRXN/1M/YUcjMj8Nk7Lkzm8WA4qC4sBftA1k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@suse.de>,
        Aristeu Rozanski <aris@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>
Subject: [PATCH 4.9 093/141] EDAC, skx_edac: Fix logical channel intermediate decoding
Date:   Sun, 11 Nov 2018 14:25:52 -0800
Message-Id: <20181111221640.980038100@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221627.853046496@linuxfoundation.org>
References: <20181111221627.853046496@linuxfoundation.org>
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

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

commit 8f18973877204dc8ca4ce1004a5d28683b9a7086 upstream.

The code "lchan = (lchan << 1) | ~lchan" for logical channel
intermediate decoding is wrong. The wrong intermediate decoding
result is {0xffffffff, 0xfffffffe}.

Fix it by replacing '~' with '!'. The correct intermediate
decoding result is {0x1, 0x2}.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
CC: Aristeu Rozanski <aris@redhat.com>
CC: Mauro Carvalho Chehab <mchehab@kernel.org>
CC: linux-edac <linux-edac@vger.kernel.org>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/20181009172025.18594-1-tony.luck@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/edac/skx_edac.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/edac/skx_edac.c
+++ b/drivers/edac/skx_edac.c
@@ -606,7 +606,7 @@ sad_found:
 			break;
 		case 2:
 			lchan = (addr >> shift) % 2;
-			lchan = (lchan << 1) | ~lchan;
+			lchan = (lchan << 1) | !lchan;
 			break;
 		case 3:
 			lchan = ((addr >> shift) % 2) << 1;


