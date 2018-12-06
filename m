Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF81C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D4672082B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107455;
	bh=a0pJjIEj6bfIMUdEQ13DX8JMnjIvdCIs7Iexdq0tafg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r65aFvhvqxPXeX1EAz+YQRb6jfI/4WKFphEmhpwFnRsH/3WmCJKvgyhTC2p7AFJ7J
	 0dDY5p+yHS9LEk6DVtnSWLMfg8fXuJaHeCq1tjtRPG+9/752k+Jc15QsqNGKHFaLtf
	 8KylbuZTvEsAOaRg2yYTq+7z1TgvS3JA9d8CGpyE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D4672082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730839AbeLFOoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:44:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:48724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730810AbeLFOoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:44:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 279E620661;
        Thu,  6 Dec 2018 14:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107447;
        bh=a0pJjIEj6bfIMUdEQ13DX8JMnjIvdCIs7Iexdq0tafg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YGZdA1Mp67WD9delgGHgmI0Vc6CWM31rx3tdzEmL3kQz2b2ArfQG+lbJaqeC36LfO
         5dZjsHShcN7vqxYRV76AZvEkhJGcTGqhVaxesY8AFYP6F3zoJqI+niflnx+jSksoqn
         QlwA8E+Z1h2/JMLdkyyPL6c93ow6EdLYpQ5cneFI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.9 010/101] staging: rts5208: fix gcc-8 logic error warning
Date:   Thu,  6 Dec 2018 15:38:09 +0100
Message-Id: <20181206143012.168547454@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143011.174892052@linuxfoundation.org>
References: <20181206143011.174892052@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4110,12 +4110,6 @@ RTY_SEND_CMD:
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


