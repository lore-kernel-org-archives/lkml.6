Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B99C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A68C206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/m06R64"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A68C206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389344AbeKTDMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:12:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:48686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387988AbeKTDMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:12:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DF652089F;
        Mon, 19 Nov 2018 16:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646093;
        bh=k/V2dCT1mkmckQ0+3mMyZjLgxDCOgpvbut7Thh7Us+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n/m06R64KESmcVBoQpEPpnu7K0RHNYX0OcKivwJfqZ2lCVZKQoel2snrvqBq4+D2x
         YHq6ecAFHFn5FFfdYe8VEh8Rv+uBlbLoTkbu/RntczfjI5dU/+jDrdYcupo8+io1uY
         I2shR3dwRyYAhgL3wS1TLfZgkG2lyQf0zYB7fX2Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sam Bobroff <sbobroff@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 004/124] powerpc/eeh: Fix possible null deref in eeh_dump_dev_log()
Date:   Mon, 19 Nov 2018 17:27:38 +0100
Message-Id: <20181119162613.833934720@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162612.951907286@linuxfoundation.org>
References: <20181119162612.951907286@linuxfoundation.org>
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

From: Sam Bobroff <sbobroff@linux.ibm.com>

[ Upstream commit f9bc28aedfb5bbd572d2d365f3095c1becd7209b ]

If an error occurs during an unplug operation, it's possible for
eeh_dump_dev_log() to be called when edev->pdn is null, which
currently leads to dereferencing a null pointer.

Handle this by skipping the error log for those devices.

Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kernel/eeh.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -169,6 +169,11 @@ static size_t eeh_dump_dev_log(struct ee
 	int n = 0, l = 0;
 	char buffer[128];
 
+	if (!pdn) {
+		pr_warn("EEH: Note: No error log for absent device.\n");
+		return 0;
+	}
+
 	n += scnprintf(buf+n, len-n, "%04x:%02x:%02x.%01x\n",
 		       pdn->phb->global_number, pdn->busno,
 		       PCI_SLOT(pdn->devfn), PCI_FUNC(pdn->devfn));


