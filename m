Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B62C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E31982084C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXIeUQ+v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E31982084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389232AbeKLIU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:20:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:46846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731111AbeKLIUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:20:54 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B44C7223DD;
        Sun, 11 Nov 2018 22:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975457;
        bh=yHqhZlFOtFFm8tURFNuIs+QD+FzjuA2KwMO54ac+2Zg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mXIeUQ+vFFbQi8Y3UJCAzpBexeOKswB/xgMR1gU6tCSQ3Xq574j4MxcmhDq0NSL2Q
         pceC3vpqiK3Uw3xrguVKrbuDzcyMxfJtO3dv44WIwgQd6GUdjyKrlaW9F1FttZVzps
         JUIFmFjN6tjJm3Lz6eZrJPXck4wuO3k7vdKVitAw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@suse.de>,
        Aristeu Rozanski <aris@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>
Subject: [PATCH 4.18 230/350] EDAC, skx_edac: Fix logical channel intermediate decoding
Date:   Sun, 11 Nov 2018 14:21:34 -0800
Message-Id: <20181111221717.656068872@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -668,7 +668,7 @@ sad_found:
 			break;
 		case 2:
 			lchan = (addr >> shift) % 2;
-			lchan = (lchan << 1) | ~lchan;
+			lchan = (lchan << 1) | !lchan;
 			break;
 		case 3:
 			lchan = ((addr >> shift) % 2) << 1;


