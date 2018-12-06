Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF7FC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F98620661
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107310;
	bh=E9RUgt1vhiDsYqAc2Xq99/vAPGuv+lGqxvUj4RCgQUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BJnoRVq6j3Wbbk5wFNDZEE2FzN+BrJlwUz73mvEBrX7AM6rnl8mqXnYQQXKRA0Tl5
	 cV8hZRfaoVzGUrJzmmhJpb198uRXxLLK0Zd3qf/yhUy+iiWsW9HLUOZdMSwUudE6s7
	 VLK7L7DW6D7fHlTMRYyBYoo0Pn4tvXB/0dnneMyg=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F98620661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730345AbeLFOlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:41:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:46002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730323AbeLFOlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:41:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F09A2082B;
        Thu,  6 Dec 2018 14:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107305;
        bh=E9RUgt1vhiDsYqAc2Xq99/vAPGuv+lGqxvUj4RCgQUs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DLunNWq64HTeJR5FjztAVZkBlWS/wvu2nORFlrr0cY4pDihdocuwzn/34poWKgJkH
         0CLVEuyAlExF3N647FTK+An09eIpy+WBAAa7KSHEfFweWfj1i1edx7FsY2moszbKU0
         ttU6J21w54eneipLfu9M+s83bqQNE08CXoSgUVFs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.14 11/55] staging: rts5208: fix gcc-8 logic error warning
Date:   Thu,  6 Dec 2018 15:38:45 +0100
Message-Id: <20181206143002.333428054@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143001.749982936@linuxfoundation.org>
References: <20181206143001.749982936@linuxfoundation.org>
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
@@ -4125,12 +4125,6 @@ RTY_SEND_CMD:
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


