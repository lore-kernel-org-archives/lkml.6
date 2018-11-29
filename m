Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B82C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D33EE21019
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="atnbKPOY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D33EE21019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730234AbeK3BWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:22:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:44224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728190AbeK3BWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:22:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E577208E7;
        Thu, 29 Nov 2018 14:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501019;
        bh=A4TYvWLog5vCbEjHgLR8Bpsyzid5q3FnpB5KfwSadYs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=atnbKPOYPAkGnv/UL+svDeh8QEzcTJ3gkuXIOvXl4+Ro6DHxN4OvpSEnu0eDfQ7ns
         DSsCx3JOmMkKoqKJEkK4X+pvMYVivYiAVq9Z069yJfdimE6oOnZmKwBVKUGYBVK01z
         /H2v2bTSyYfSG1WYnkdWFxAjL8Sb/56x4WHdrV5Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Y.C. Chen" <yc_chen@aspeedtech.com>,
        Jean Delvare <jdelvare@suse.de>,
        Dave Airlie <airlied@redhat.com>
Subject: [PATCH 4.4 10/86] drm/ast: change resolution may cause screen blurred
Date:   Thu, 29 Nov 2018 15:11:35 +0100
Message-Id: <20181129140110.761654710@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140109.832117862@linuxfoundation.org>
References: <20181129140109.832117862@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Y.C. Chen <yc_chen@aspeedtech.com>

commit 1a37bd823891568f8721989aed0615835632d81a upstream.

The value of pitches is not correct while calling mode_set.
The issue we found so far on following system:
- Debian8 with XFCE Desktop
- Ubuntu with KDE Desktop
- SUSE15 with KDE Desktop

Signed-off-by: Y.C. Chen <yc_chen@aspeedtech.com>
Cc: <stable@vger.kernel.org>
Tested-by: Jean Delvare <jdelvare@suse.de>
Reviewed-by: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/ast/ast_mode.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/ast/ast_mode.c
+++ b/drivers/gpu/drm/ast/ast_mode.c
@@ -552,6 +552,7 @@ static int ast_crtc_do_set_base(struct d
 	}
 	ast_bo_unreserve(bo);
 
+	ast_set_offset_reg(crtc);
 	ast_set_start_address_crt1(crtc, (u32)gpu_addr);
 
 	return 0;


