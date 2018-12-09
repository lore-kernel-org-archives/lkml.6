Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CCBC65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E84820661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:05:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E84820661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbeLIWFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:05:55 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37012 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726870AbeLIWFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:05:52 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73H-0002ic-KJ; Sun, 09 Dec 2018 21:55:51 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72c-0003ML-I6; Sun, 09 Dec 2018 21:55:10 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Michal Suchanek" <msuchanek@suse.com>,
        "Mahesh Salgaonkar" <mahesh@linux.vnet.ibm.com>,
        "Michael Ellerman" <mpe@ellerman.id.au>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.114474681@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 114/328] powerpc/pseries: Avoid using the size
 greater than RTAS_ERROR_LOG_MAX.
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

commit 74e96bf44f430cf7a01de19ba6cf49b361cdfd6e upstream.

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/powerpc/platforms/pseries/ras.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/platforms/pseries/ras.c
+++ b/arch/powerpc/platforms/pseries/ras.c
@@ -309,7 +309,7 @@ static struct rtas_error_log *fwnmi_get_
 		int len, error_log_length;
 
 		error_log_length = 8 + rtas_error_extended_log_length(h);
-		len = max_t(int, error_log_length, RTAS_ERROR_LOG_MAX);
+		len = min_t(int, error_log_length, RTAS_ERROR_LOG_MAX);
 		memset(global_mce_data_buf, 0, RTAS_ERROR_LOG_MAX);
 		memcpy(global_mce_data_buf, h, len);
 		errhdr = (struct rtas_error_log *)global_mce_data_buf;

