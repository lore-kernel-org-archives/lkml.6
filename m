Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E22EC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40EA1208E7
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543910;
	bh=rm7OpMeeljMOVL1T1Yq9FWR0rU904UztWpyVoIuc3pM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DZUNv+ldAn8Me3Jr5WFkpyB/TkgW53ytC3eHGBvOeOi6NO/qQJSohqCp51yxQootk
	 J7nfYVySLvB9vgO/16QXzZWLucRBEV3fYL02AEnEDcxoVYAcV+t+lECNTd0nyvnTvi
	 iEy1PptR/9b8iC9nAagse8uUW931vZwuJ6DR/flY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40EA1208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbeLKP62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:58:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:47882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726859AbeLKP6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:58:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D445208E7;
        Tue, 11 Dec 2018 15:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543904;
        bh=rm7OpMeeljMOVL1T1Yq9FWR0rU904UztWpyVoIuc3pM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eBAIDS4/WEB++S92P6kVkler9pbk8Z1EM1saMHh9DTpliW7dicjtrVeWqmVIxvhOF
         /ZeRxtG6QKeIcdAIvOC/ADH/9Ru/e5Y2j4/Pj3sYsp6u1YwufNugKuK1BDe6dZiAJ9
         DxcyC/Q9eQLZMlKbsSlTmQFqL9xB8rXJ5JAKsPuk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.19 108/118] gnss: sirf: fix activation retry handling
Date:   Tue, 11 Dec 2018 16:42:07 +0100
Message-Id: <20181211151648.625438898@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 06fd9ab12b804451b14d538adbf98a57c2d6846b upstream.

Fix activation helper which would return -ETIMEDOUT even if the last
retry attempt was successful.

Also change the semantics of the retries variable so that it actually
holds the number of retries (rather than tries).

Fixes: d2efbbd18b1e ("gnss: add driver for sirfstar-based receivers")
Cc: stable <stable@vger.kernel.org>	# 4.19
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gnss/sirf.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/gnss/sirf.c
+++ b/drivers/gnss/sirf.c
@@ -168,7 +168,7 @@ static int sirf_set_active(struct sirf_d
 	else
 		timeout = SIRF_HIBERNATE_TIMEOUT;
 
-	while (retries-- > 0) {
+	do {
 		sirf_pulse_on_off(data);
 		ret = sirf_wait_for_power_state(data, active, timeout);
 		if (ret < 0) {
@@ -179,9 +179,9 @@ static int sirf_set_active(struct sirf_d
 		}
 
 		break;
-	}
+	} while (retries--);
 
-	if (retries == 0)
+	if (retries < 0)
 		return -ETIMEDOUT;
 
 	return 0;


