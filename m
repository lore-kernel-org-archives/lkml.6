Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8B4C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 132C721479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pdHfRkPF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 132C721479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbeJIBzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:55:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:42596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729698AbeJIBzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:55:03 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E996B2064A;
        Mon,  8 Oct 2018 18:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024118;
        bh=2x+4E1wt+vgvq0wjj+aVU5IhygXGauqWB+0s1pVznd0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pdHfRkPFGPR4jGVU33Y/tUvZbyRvAys2mJgpQqrehzPoOQvEZQOIrO4tRN/jYQK+e
         +u0z7AXK3zW0D3VK1spjGTG7Tt31FEJn5ifwjCT8/JFlEcbOtJUTBiGMZHvDtTPBHO
         XkRZihbhTt8CZYsaLPtGL3uvyojnKhX0AG3f6SDE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Len Brown <len.brown@intel.com>,
        Alakesh Haloi <alakeshh@amazon.com>
Subject: [PATCH 4.14 04/94] tools/power turbostat: fix possible sprintf buffer overflow
Date:   Mon,  8 Oct 2018 20:30:45 +0200
Message-Id: <20181008175605.268740961@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175605.067676667@linuxfoundation.org>
References: <20181008175605.067676667@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Len Brown <len.brown@intel.com>

commit 46c2797826cc6d1ae36fcbd966e76f9fa1907eef upstream.

Signed-off-by: Len Brown <len.brown@intel.com>
Cc: Alakesh Haloi <alakeshh@amazon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/power/x86/turbostat/turbostat.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1485,7 +1485,7 @@ int get_mp(int cpu, struct msr_counter *
 		if (get_msr(cpu, mp->msr_num, counterp))
 			return -1;
 	} else {
-		char path[128];
+		char path[128 + PATH_BYTES];
 
 		if (mp->flags & SYSFS_PERCPU) {
 			sprintf(path, "/sys/devices/system/cpu/cpu%d/%s",


