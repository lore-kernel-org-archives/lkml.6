Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4A7C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6196E20851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544545168;
	bh=ZSGqd1NAli5Ab2xFx2uehipnfPy5UBKt6f0ptsxX7Yo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sEMXr6S+i5U28FCCpxir0ZjdBlH3omKI9vgAUcpQedprIu+vcdmotlCUSA1r1t2Wt
	 fEs2Z6VQjndRFdEoyImzoX4ftvAi8ydjFwTu3i3Df+bLFRuB1SpOZu/rS67Crk1D89
	 x473tm9r4LoO73/dnuvbU61XOoGNeA/iFN/yJYpQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6196E20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbeLKPpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:45:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:34166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727677AbeLKPpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:45:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DB282087F;
        Tue, 11 Dec 2018 15:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543145;
        bh=ZSGqd1NAli5Ab2xFx2uehipnfPy5UBKt6f0ptsxX7Yo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g5T1rG69rZJcJABE0UJPOU9dAuBRqjY89SxB/hl6fu8IJjcTJkl8lALfOVWjX3she
         MO5dRyd3ntZsiPIVHzf825Kak28RDHo28dbRo71lFymzYJH1XW08cPk5n1CXacyocm
         91NUYcqjIIFBUwm4BFkOYC6YJkySzzbhSBamqPwQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.4 30/91] staging: rts5208: fix gcc-8 logic error warning
Date:   Tue, 11 Dec 2018 16:40:49 +0100
Message-Id: <20181211151608.246810750@linuxfoundation.org>
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

From: Arnd Bergmann <arnd@arndb.de>

commit 58930cced012adb01bc78b3687049b17ef44d0a3 upstream.

As gcc-8 points out, the bit mask check makes no sense here:

drivers/staging/rts5208/sd.c: In function 'ext_sd_send_cmd_get_rsp':
drivers/staging/rts5208/sd.c:4130:25: error: bitwise comparison always evaluates to true [-Werror=tautological-compare]

However, the code is even more bogus, as we have already
checked for the SD_RSP_TYPE_R0 case earlier in the function
and returned success. As seen in the mmc/sd driver core,
SD_RSP_TYPE_R0 means "no response" anyway, so checking for
a particular response would not help either.

This just removes the nonsensical code to get rid of the
warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/rts5208/sd.c |    6 ------
 1 file changed, 6 deletions(-)

--- a/drivers/staging/rts5208/sd.c
+++ b/drivers/staging/rts5208/sd.c
@@ -4165,12 +4165,6 @@ RTY_SEND_CMD:
 					rtsx_trace(chip);
 					return STATUS_FAIL;
 				}
-
-			} else if (rsp_type == SD_RSP_TYPE_R0) {
-				if ((ptr[3] & 0x1E) != 0x03) {
-					rtsx_trace(chip);
-					return STATUS_FAIL;
-				}
 			}
 		}
 	}


