Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00287C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B36B321901
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550497765;
	bh=cMrdofaaO/YIpGSm1kuKbc1UFiLTtxSFcwyPogoPLrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ghTWfelXzwBSsSOrHYaCQIXOHGeSVPIC2g8cwQEXcjF3eLg3bitqS2JPzIXU9mMo/
	 DgQQs7B7h7vJ9hUNKZiyYbLPZAQ43O7nb72KniEFB0DNwM90PRZ0jzdpmafBxreGnS
	 UViN2UideClUjYI9DiuTAvxr/gLb7E5bOBhObNZs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731299AbfBRNtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:49:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:56620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732007AbfBRNtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:49:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09ED420842;
        Mon, 18 Feb 2019 13:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497760;
        bh=cMrdofaaO/YIpGSm1kuKbc1UFiLTtxSFcwyPogoPLrU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dCn7qJZ4M5d70TaM/87zVvRfjlYDCQACa0tZFz9sMs4M0P7cOq3s6Eg1BUHsg4H9e
         OWcFYl9MQC0WDb7BEhyzh0aPPg9iEGoDSosq/K5C1KG11FhP85t0u7oPHhNuP59fZ4
         nkYJZXDBxEKAncUvOvNmB4B95eVJ6041aEu9R88w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Harald Freudenberger <freude@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.20 76/92] s390/zcrypt: fix specification exception on z196 during ap probe
Date:   Mon, 18 Feb 2019 14:43:19 +0100
Message-Id: <20190218133502.009646107@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133454.668268457@linuxfoundation.org>
References: <20190218133454.668268457@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Harald Freudenberger <freude@linux.ibm.com>

commit 8f9aca0c45322a807a343fc32f95f2500f83b9ae upstream.

The older machines don't have the QCI instruction available.
With support for up to 256 crypto cards the probing of each
card has been extended to check card ids from 0 up to 255.
For machines with QCI support there is a filter limiting the
range of probed cards. The older machines (z196 and older)
don't have this filter and so since support for 256 cards is
in the driver all cards are probed. However, these machines
also require to have the card id fit into 6 bits. Exceeding
this limit results in a specification exception which happens
on every kernel startup even when there is no crypto configured
and used at all.

This fix limits the range of probed crypto cards to 64 if
there is no QCI instruction available to obey to the older
ap architecture and so fixes the specification exceptions
on z196 machines.

Cc: stable@vger.kernel.org # v4.17+
Fixes: af4a72276d49 ("s390/zcrypt: Support up to 256 crypto adapters.")
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/s390/crypto/ap_bus.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -248,7 +248,8 @@ static inline int ap_test_config(unsigne
 static inline int ap_test_config_card_id(unsigned int id)
 {
 	if (!ap_configuration)	/* QCI not supported */
-		return 1;
+		/* only ids 0...3F may be probed */
+		return id < 0x40 ? 1 : 0;
 	return ap_test_config(ap_configuration->apm, id);
 }
 


