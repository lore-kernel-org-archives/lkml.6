Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F361CECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB4A0208FC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:37:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB4A0208FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731645AbeGPIDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:03:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46716 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728460AbeGPIDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:03:30 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 460E9C03;
        Mon, 16 Jul 2018 07:37:29 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Murray McAllister <murray.mcallister@insomniasec.com>
Subject: [PATCH 4.17 13/67] staging: rtl8723bs: Prevent an underflow in rtw_check_beacon_data().
Date:   Mon, 16 Jul 2018 09:34:42 +0200
Message-Id: <20180716073445.113707440@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716073443.294323458@linuxfoundation.org>
References: <20180716073443.294323458@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Murray McAllister <murray.mcallister@insomniasec.com>

commit 920c92448839bd4f8eb87a92b08cad56d449caff upstream.

Dan Carpenter reported an integer underflow issue in the rtl8188eu driver.
This is also needed for the length (signed integer) in rtl8723bs, as it is
later converted to an unsigned integer and used in a memcpy operation.

Original issue is at https://patchwork.kernel.org/patch/9796371/

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Murray McAllister <murray.mcallister@insomniasec.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/rtl8723bs/core/rtw_ap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -1059,7 +1059,7 @@ int rtw_check_beacon_data(struct adapter
 		return _FAIL;
 
 
-	if (len > MAX_IE_SZ)
+	if (len < 0 || len > MAX_IE_SZ)
 		return _FAIL;
 
 	pbss_network->IELength = len;


