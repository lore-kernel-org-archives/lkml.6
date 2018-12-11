Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0791C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 686442082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544532642;
	bh=CfT3Ldv5SKTeK8qAOFabwXkiDI4t2OgqJXEje2oEbck=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=RYVSKlKcc1mdLDtMeYTi5m2id8WpFQ/NbpUT5Z1u23Y207fKpjRYzxnGD1BGMn2MF
	 bZC+O+fT6j+PVG64UCKwSAXrT3L4mGX4E5UQRyRrsNoOFlwOHReDaIh/CxINy8leS0
	 QinwwlTbhIswkITk7c2egEe6/pnFOiBF6ITyhc9U=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 686442082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbeLKMul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 07:50:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:55624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbeLKMul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 07:50:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF6192082F;
        Tue, 11 Dec 2018 12:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544532640;
        bh=CfT3Ldv5SKTeK8qAOFabwXkiDI4t2OgqJXEje2oEbck=;
        h=Date:From:To:Cc:Subject:From;
        b=URvghkkunT59zUmHdhmYQ4RONAjUvl422tPd828nS3MG+DY3b6hN8tCqEZT5E04wa
         C/LjPrKKgnceC63bhFuBPeAzy6sTfDugd0Kz6VF4P0KILo9Q2gZeSGAGFUZXvuiJbJ
         5MXdmqo4nnloBs9Mj8AspHRiLp6+lUuaYHOkUJbc=
Date:   Tue, 11 Dec 2018 13:50:37 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org
Subject: Staging: lustre: remove two build warnings
Message-ID: <20181211125037.GA25594@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 drivers/staging/lustre/lnet/lnet/config.c   |    3 +--
 drivers/staging/lustre/lustre/lmv/lmv_obd.c |    2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/staging/lustre/lnet/lnet/config.c
+++ b/drivers/staging/lustre/lnet/lnet/config.c
@@ -354,8 +354,7 @@ lnet_parse_networks(struct list_head *ni
 				CERROR("Can't allocate net interface name\n");
 				goto failed;
 			}
-			strncpy(ni->ni_interfaces[niface], iface,
-				strlen(iface));
+			strcpy(ni->ni_interfaces[niface], iface);
 			niface++;
 			iface = comma;
 		} while (iface);
--- a/drivers/staging/lustre/lustre/lmv/lmv_obd.c
+++ b/drivers/staging/lustre/lustre/lmv/lmv_obd.c
@@ -645,7 +645,7 @@ repeat_fid2path:
 		memmove(ptr + strlen(gf->gf_path) + 1, ptr,
 			strlen(ori_gf->gf_path));
 
-		strncpy(ptr, gf->gf_path, strlen(gf->gf_path));
+		strcpy(ptr, gf->gf_path);
 		ptr += strlen(gf->gf_path);
 		*ptr = '/';
 	}
