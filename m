Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7F7C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C09120811
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083986;
	bh=yFXLqjeu9qNdKAIFmWoX/OfDgjq6Z+tKhgyabcxMKcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pCnQXAo1Rvl1inMvXvhBPce64H0s8iIcZXszr4GnTP30Acr43cZB6MjSyOxsOpPjb
	 j3Cr34rPzjjsyMNQjXR5DNWnGHH6yEZ/lxgOGBC5ZQ4OvdEN1e+C7LsQaF8GA35nb6
	 adG7z5tyRhx6iV6CMEnYxU21sB1vyGDD5AO+eOM0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394209AbfBMSxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:53:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:41564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405767AbfBMSnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:43:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5415E20811;
        Wed, 13 Feb 2019 18:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083380;
        bh=yFXLqjeu9qNdKAIFmWoX/OfDgjq6Z+tKhgyabcxMKcE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bRuhgBhEGQHdHCG2mE6qrKePVQvnQAbtOv0f+23tYp6lgoSCLoLFa/zMXo5oAHxVH
         nmM8cDUQNbDyh8tcuAVm2UTeYoui6d53iYW600IE0g5F4zyDZQDNiPWiDGcZ6HSbu7
         yTx4HH2AlRLfZZDmJRDZN8Gh5V2GcmnJ6Ke3CViI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Vladimir Kondratiev <vladimir.kondratiev@linux.intel.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org
Subject: [PATCH 4.19 19/44] mips: cm: reprime error cause
Date:   Wed, 13 Feb 2019 19:38:20 +0100
Message-Id: <20190213183653.333809582@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183651.648060257@linuxfoundation.org>
References: <20190213183651.648060257@linuxfoundation.org>
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

From: Vladimir Kondratiev <vladimir.kondratiev@linux.intel.com>

commit 05dc6001af0630e200ad5ea08707187fe5537e6d upstream.

Accordingly to the documentation
---cut---
The GCR_ERROR_CAUSE.ERR_TYPE field and the GCR_ERROR_MULT.ERR_TYPE
fields can be cleared by either a reset or by writing the current
value of GCR_ERROR_CAUSE.ERR_TYPE to the
GCR_ERROR_CAUSE.ERR_TYPE register.
---cut---
Do exactly this. Original value of cm_error may be safely written back;
it clears error cause and keeps other bits untouched.

Fixes: 3885c2b463f6 ("MIPS: CM: Add support for reporting CM cache errors")
Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@linux.intel.com>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org # v4.3+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/mips-cm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/kernel/mips-cm.c
+++ b/arch/mips/kernel/mips-cm.c
@@ -457,5 +457,5 @@ void mips_cm_error_report(void)
 	}
 
 	/* reprime cause register */
-	write_gcr_error_cause(0);
+	write_gcr_error_cause(cm_error);
 }


