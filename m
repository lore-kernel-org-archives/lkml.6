Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327C7C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED27220855
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543583;
	bh=z9wTR4dtP+MKO1A6ut9lSnpUL8XknMVLvCgjLmUU+2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qjLR02KnNpEkP/qpI0arA0hOi7D1YQvdYSzJZRWEyKXzGQEYsy02UdDEMewijsqvN
	 eqvlKJ+f6/5zxp/GMOAb7eeSEVHxZlRW+uiAWBUE6AgqsEyUY3ZE4ERcAySTyyrDfA
	 a7wvod/2sqrkK0lIcqWUH1KINjB5DQN30dEv/AZY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED27220855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbeLKPxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:53:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:41634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729818AbeLKPw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:52:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 591E42146E;
        Tue, 11 Dec 2018 15:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543575;
        bh=z9wTR4dtP+MKO1A6ut9lSnpUL8XknMVLvCgjLmUU+2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZASLnymATtTtNsy8VaR/wUPFb/GaEFGIgLN6K2qRbmIdcBAbswC1rR40aFnQmOeuS
         ifu1sNtEMUvqHojN8cOmYmcdbiy3cxVhjYSQRfXBknTsrn0fCKoFxi7WqVuIysy15D
         FaMUSPgv/lnoozgprRwAnWgtDr1jr5d1OU93HyIM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Subject: [PATCH 4.14 51/67] Staging: lustre: remove two build warnings
Date:   Tue, 11 Dec 2018 16:41:51 +0100
Message-Id: <20181211151632.967055213@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151630.378216233@linuxfoundation.org>
References: <20181211151630.378216233@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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


