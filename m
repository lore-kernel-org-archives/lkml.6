Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B17ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A8712083A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:38:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A8712083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387942AbeIXSkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:40:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58768 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730741AbeIXSku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:40:50 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5A657107F;
        Mon, 24 Sep 2018 12:38:53 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Finn Thain <fthain@telegraphics.com.au>,
        Stan Johnson <userm57@yahoo.com>,
        Frank Rowand <frank.rowand@sony.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 4.18 140/235] of: fix phandle cache creation for DTs with no phandles
Date:   Mon, 24 Sep 2018 13:52:06 +0200
Message-Id: <20180924113119.652905591@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rob Herring <robh@kernel.org>

commit e54192b48da75f025ae4b277925eaf6aca1d13bd upstream.

With commit 0b3ce78e90fc ("of: cache phandle nodes to reduce cost of
of_find_node_by_phandle()"), a G3 PowerMac fails to boot. The root cause
is the DT for this system has no phandle properties when booted with
BootX. of_populate_phandle_cache() does not handle the case of no
phandles correctly. The problem is roundup_pow_of_two() for 0 is
undefined. The implementation subtracts 1 underflowing and then things
are in the weeds.

Fixes: 0b3ce78e90fc ("of: cache phandle nodes to reduce cost of of_find_node_by_phandle()")
Cc: stable@vger.kernel.org # 4.17+
Reported-by: Finn Thain <fthain@telegraphics.com.au>
Tested-by: Stan Johnson <userm57@yahoo.com>
Reviewed-by: Frank Rowand <frank.rowand@sony.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/of/base.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -118,6 +118,9 @@ void of_populate_phandle_cache(void)
 		if (np->phandle && np->phandle != OF_PHANDLE_ILLEGAL)
 			phandles++;
 
+	if (!phandles)
+		goto out;
+
 	cache_entries = roundup_pow_of_two(phandles);
 	phandle_cache_mask = cache_entries - 1;
 


