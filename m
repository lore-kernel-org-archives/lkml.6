Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC72EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B247E20A8B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:19:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B247E20A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbeHWLr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:47:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46378 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727760AbeHWLr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:47:28 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A2E32C74;
        Thu, 23 Aug 2018 08:18:58 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Paul Menzel <pmenzel+linux-hwmon@molgen.mpg.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 013/217] hwmon: (nct6775) Fix loop limit
Date:   Thu, 23 Aug 2018 09:52:06 +0200
Message-Id: <20180823075506.152846666@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823075505.090246914@linuxfoundation.org>
References: <20180823075505.090246914@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit 91bb8f45f73f19a0150c233c0f11cdeb6d71d1e9 ]

Commit cc66b3038254 ("hwmon: (nct6775) Rework temperature source and label
handling") changed a loop limit from "data->temp_label_num - 1" to "32",
as part of moving from a string array to a bit mask. This results in the
following error, reported by UBSAN.

UBSAN: Undefined behaviour in drivers/hwmon/nct6775.c:4179:27
shift exponent 32 is too large for 32-bit type 'long unsigned int'

Similar to the original loop, the limit has to be one less than the
number of bits.

Fixes: cc66b3038254 ("hwmon: (nct6775) Rework temperature source and label handling")
Reported-by: Paul Menzel <pmenzel+linux-hwmon@molgen.mpg.de>
Cc: Paul Menzel <pmenzel+linux-hwmon@molgen.mpg.de>
Tested-by: Paul Menzel <pmenzel+linux-hwmon@molgen.mpg.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/nct6775.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -4107,7 +4107,7 @@ static int nct6775_probe(struct platform
 	 * The temperature is already monitored if the respective bit in <mask>
 	 * is set.
 	 */
-	for (i = 0; i < 32; i++) {
+	for (i = 0; i < 31; i++) {
 		if (!(data->temp_mask & BIT(i + 1)))
 			continue;
 		if (!reg_temp_alternate[i])


