Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBE2C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 924FC2084C
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="St4UmANz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 924FC2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730272AbeKLIRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:17:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:59734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730201AbeKLIRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:17:07 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16D42223C8;
        Sun, 11 Nov 2018 22:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975232;
        bh=ysx8oaMaiUOyh3GfgdCNBS/mqA02WfF0PQiw1KQ+up4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=St4UmANzBX7d3539L8djS8CcT3H88ZUM4lyQHkiUnbpHEEV/lYSQPW71ZYhS7yHcY
         cUTBeTUddTTuyCZDb8mUtGep40ZC+ScIsN56OzZtHynZvYfe2C7NlMtFyxAQQgli58
         Ly/CgSVai97j1NoGYpZ+VXyxoR3QLlTu9CPXPfEQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Janosch Frank <frankja@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 058/361] s390/sthyi: Fix machine name validity indication
Date:   Sun, 11 Nov 2018 14:16:45 -0800
Message-Id: <20181111221628.092862253@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Janosch Frank <frankja@linux.ibm.com>

[ Upstream commit b5130dc2224d1881f24224c0590c6d97f2168d6a ]

When running as a level 3 guest with no host provided sthyi support
sclp_ocf_cpc_name_copy() will only return zeroes. Zeroes are not a
valid group name, so let's not indicate that the group name field is
valid.

Also the group name is not dependent on stsi, let's not return based
on stsi before setting it.

Fixes: 95ca2cb57985 ("KVM: s390: Add sthyi emulation")
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/kernel/sthyi.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/arch/s390/kernel/sthyi.c
+++ b/arch/s390/kernel/sthyi.c
@@ -183,17 +183,19 @@ static void fill_hdr(struct sthyi_sctns
 static void fill_stsi_mac(struct sthyi_sctns *sctns,
 			  struct sysinfo_1_1_1 *sysinfo)
 {
+	sclp_ocf_cpc_name_copy(sctns->mac.infmname);
+	if (*(u64 *)sctns->mac.infmname != 0)
+		sctns->mac.infmval1 |= MAC_NAME_VLD;
+
 	if (stsi(sysinfo, 1, 1, 1))
 		return;
 
-	sclp_ocf_cpc_name_copy(sctns->mac.infmname);
-
 	memcpy(sctns->mac.infmtype, sysinfo->type, sizeof(sctns->mac.infmtype));
 	memcpy(sctns->mac.infmmanu, sysinfo->manufacturer, sizeof(sctns->mac.infmmanu));
 	memcpy(sctns->mac.infmpman, sysinfo->plant, sizeof(sctns->mac.infmpman));
 	memcpy(sctns->mac.infmseq, sysinfo->sequence, sizeof(sctns->mac.infmseq));
 
-	sctns->mac.infmval1 |= MAC_ID_VLD | MAC_NAME_VLD;
+	sctns->mac.infmval1 |= MAC_ID_VLD;
 }
 
 static void fill_stsi_par(struct sthyi_sctns *sctns,


