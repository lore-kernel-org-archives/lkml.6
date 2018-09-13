Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DABC07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10CEB20854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:38:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10CEB20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbeIMSr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:47:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59618 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbeIMSr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:47:28 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7C433CF3;
        Thu, 13 Sep 2018 13:37:57 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michal Suchanek <msuchanek@suse.com>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 51/78] powerpc/pseries: Avoid using the size greater than RTAS_ERROR_LOG_MAX.
Date:   Thu, 13 Sep 2018 15:31:38 +0200
Message-Id: <20180913131810.904525110@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131805.732342940@linuxfoundation.org>
References: <20180913131805.732342940@linuxfoundation.org>
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

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

[ Upstream commit 74e96bf44f430cf7a01de19ba6cf49b361cdfd6e ]

The global mce data buffer that used to copy rtas error log is of 2048
(RTAS_ERROR_LOG_MAX) bytes in size. Before the copy we read
extended_log_length from rtas error log header, then use max of
extended_log_length and RTAS_ERROR_LOG_MAX as a size of data to be copied.
Ideally the platform (phyp) will never send extended error log with
size > 2048. But if that happens, then we have a risk of buffer overrun
and corruption. Fix this by using min_t instead.

Fixes: d368514c3097 ("powerpc: Fix corruption when grabbing FWNMI data")
Reported-by: Michal Suchanek <msuchanek@suse.com>
Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/platforms/pseries/ras.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/platforms/pseries/ras.c
+++ b/arch/powerpc/platforms/pseries/ras.c
@@ -357,7 +357,7 @@ static struct rtas_error_log *fwnmi_get_
 		int len, error_log_length;
 
 		error_log_length = 8 + rtas_error_extended_log_length(h);
-		len = max_t(int, error_log_length, RTAS_ERROR_LOG_MAX);
+		len = min_t(int, error_log_length, RTAS_ERROR_LOG_MAX);
 		memset(global_mce_data_buf, 0, RTAS_ERROR_LOG_MAX);
 		memcpy(global_mce_data_buf, h, len);
 		errhdr = (struct rtas_error_log *)global_mce_data_buf;


