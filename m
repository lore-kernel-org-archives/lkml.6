Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4DD9C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 348C320836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oQQuGE2t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 348C320836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753202AbeFTM0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 08:26:54 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:42424 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750793AbeFTM0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 08:26:52 -0400
Received: by mail-pg0-f65.google.com with SMTP id c10-v6so1419204pgu.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 05:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jBC8owuoYNqjks91SC3dvZYyOm+rvpxctJjJr9LauWY=;
        b=oQQuGE2tWmmwOOIRj4jNkwHfThQscgwu8LDL2FecFy8GvX1LWW6ebuYkYz+NQde4Zs
         4vSwcicEXRJUxzqfF7XxV5I2aDl6HAUj/lIlYm2OQthLsECdcj7DbAPVXA4hsSG+TI1W
         tgWnPkeiSYkiItNtdZAL7DCGHA97IYn83KtaOmtSuH9hnMN7SB6VRXy8NN+EQ+PPQpXG
         HnfxdK92zvbJPqUj0pUVFxEZxh7IIdF2sRsxE6H8NghPzYxzOsk5VNXB+drdPrqyFrCL
         9IpZXUAxu8x2ANIssioLRnLUDeqnR3UiNc+S60FU84AAfxkykljWPFLGaovxyBWwM+mF
         XhNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=jBC8owuoYNqjks91SC3dvZYyOm+rvpxctJjJr9LauWY=;
        b=rp3EFfM6fdOHptx5AzSkLcLUAUl2ELYqtIE3o3A0nS8qtfK1IcMx6sWC2407odR/Sd
         pHaD1uJkkx/eWKypZP0nEM3NA1jrFGmwMAuFPmY8JA/P2K2RSaHGds9jD+9AoShKhXaU
         dg+PCwAYuK60kJ3zS7kmkHNWlDYUUGwAm9NCxCdIEPQO69DY+QYyivkcM0Wbufma/B03
         i+59ZF/E8xdsAap2mT+LYj7dVX1e2P3byUwREnkeNfbr+WiKsMAveJYoPXVg31FuYgT9
         4vXSSgnujdNvYphsb6inYTvMSpmQkBj1FgaGgX+0+BLqrxun/NpirA/ZenuBrZcrRlq8
         BBHw==
X-Gm-Message-State: APt69E32tiyOptuMXtNty+QQU/hlmV0Fv7VQb8GyslKG0nvo+5MdUHnn
        aoejyvY7bsLlrL/IQBu8qw==
X-Google-Smtp-Source: ADUXVKKDeUrNWnO72yUx+Cwlb/GVS09aTrEH4jOpLP1zQDHW3nvLPpBPiM6Wgs33DLwYFBAygo3zzg==
X-Received: by 2002:a62:6141:: with SMTP id v62-v6mr22541579pfb.197.1529497612031;
        Wed, 20 Jun 2018 05:26:52 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id u13-v6sm2451919pgr.36.2018.06.20.05.26.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 05:26:50 -0700 (PDT)
Received: from t430.minyard.net (t430m.minyard.net [192.168.27.3])
        by serve.minyard.net (Postfix) with ESMTPA id 2487B66B;
        Wed, 20 Jun 2018 07:26:49 -0500 (CDT)
Received: by t430.minyard.net (Postfix, from userid 1000)
        id 9682A3000DD; Wed, 20 Jun 2018 07:26:48 -0500 (CDT)
From:   minyard@acm.org
To:     Meelis Roos <mroos@linux.ee>
Cc:     Linux Kernel list <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net,
        Corey Minyard <cminyard@mvista.com>
Subject: [PATCH] ipmi: Cleanup oops on initialization failure
Date:   Wed, 20 Jun 2018 07:26:46 -0500
Message-Id: <1529497606-3857-1-git-send-email-minyard@acm.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <alpine.LRH.2.21.1806191553040.28622@math.ut.ee>
References: <alpine.LRH.2.21.1806191553040.28622@math.ut.ee>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Corey Minyard <cminyard@mvista.com>

Commit 93c303d2045b3 "ipmi_si: Clean up shutdown a bit" didn't
copy the behavior of the cleanup in one spot, it needed to
check for a non-NULL interface before cleaning it up.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---

This patch should fix the issue.

BTW, can you send me at least the IPMI portion of the output of
dmidecode for your machine?  I have seen a lot of these where the
address in the SMBIOS tables is incorrect, and I'm wondering if
it's something in the driver, or if it's really the tables that
are bad.

Thanks for reporting this.  On your tested-by I'll send this up
to Linus.

-corey

 drivers/char/ipmi/ipmi_si_intf.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index 3d0add6..a5987f8 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -2088,8 +2088,10 @@ static int try_smi_init(struct smi_info *new_smi)
 	return 0;
 
 out_err:
-	ipmi_unregister_smi(new_smi->intf);
-	new_smi->intf = NULL;
+	if (new_smi->intf) {
+		ipmi_unregister_smi(new_smi->intf);
+		new_smi->intf = NULL;
+	}
 
 	kfree(init_name);
 
-- 
2.7.4

