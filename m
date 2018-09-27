Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99BCC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60073215E4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="i1gh5XHW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60073215E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbeI0Uec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 16:34:32 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33627 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbeI0Ueb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 16:34:31 -0400
Received: by mail-pg1-f193.google.com with SMTP id y18-v6so2095901pge.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 07:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/wF1jLcWL/IcUFy/ZxgNBzB/pJX1oExug5AGTF5cexw=;
        b=i1gh5XHWQsQ+kAKg4WjRim6vj1abbn+4wFk9k0MY0eqGYrUfNG2g3VPeblBh2ykdM9
         IAt7oZ9WoDBY0iVxd8zzyesbF3IVlTvi4f3GdCaH01+yx9huL6sd82pwxGHl85TRpKxl
         7T8zknlAjJpZ0ZIWBPNHDwpB11ZdvPmKWufO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/wF1jLcWL/IcUFy/ZxgNBzB/pJX1oExug5AGTF5cexw=;
        b=UYT/YFrrutY13so63suRza+ygTXKWSa5/mZ30ElJKJBpx6Tpx4fknhw5HkpIF5xTjo
         qQDrNIGpSCpYl0qD4RXU2mC55BAZRNmNTaR4LQKYTR89OFbxjRTZFq1ZKj191mRG8kKB
         FXEjRH05rvSG9q9Q4iF3sgvZYHArT7Z/uMcRqQBKE6Jtj9tDefqxPhcJ7qumB9j+ZAz5
         aWCeeqBrePJo5rOLu4fJKBIcCmlsRfLnPLk1yBmoGewE9zO6UFdICIRGl7kjrjAPvSJ3
         y3qwniTMn3v8HIS2rSCbXbt4DqsaP23OZBAlksTj6HXSTNq2m63omV6OdTd7lYEkNojv
         AbOg==
X-Gm-Message-State: ABuFfohsHzuZ17/wlqH1cDF95IBcLywDKuVnJ5OfN/5/u9BOhFMjjPrn
        ITst+8QleZHZJyjMz9LPMAKOwA==
X-Google-Smtp-Source: ACcGV63e3P8e6te2oUoNomaKma9rE759234d6ZADr63bKME5+CbzfH8+X0SIO9eZuLrGLTLF43hG/A==
X-Received: by 2002:a63:f848:: with SMTP id v8-v6mr10365652pgj.82.1538057763739;
        Thu, 27 Sep 2018 07:16:03 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([106.51.105.186])
        by smtp.gmail.com with ESMTPSA id m20-v6sm110399pfj.171.2018.09.27.07.15.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Sep 2018 07:16:03 -0700 (PDT)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linux-ia64@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v2 1/7] ia64: add __NR_old_getpagesize macro
Date:   Thu, 27 Sep 2018 19:45:14 +0530
Message-Id: <1538057720-3392-2-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538057720-3392-1-git-send-email-firoz.khan@linaro.org>
References: <1538057720-3392-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add __NR_old_getpagesize in order to not break old user space
as it is reserved for backwards compatibility with old __NR_
getpagesize.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/ia64/include/uapi/asm/unistd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/ia64/include/uapi/asm/unistd.h b/arch/ia64/include/uapi/asm/unistd.h
index 5fe71d4..4d590c9 100644
--- a/arch/ia64/include/uapi/asm/unistd.h
+++ b/arch/ia64/include/uapi/asm/unistd.h
@@ -161,7 +161,7 @@
 #define __NR_nanosleep			1168
 #define __NR_nfsservctl			1169
 #define __NR_prctl			1170
-/* 1171 is reserved for backwards compatibility with old __NR_getpagesize */
+#define __NR_old_getpagesize            1171
 #define __NR_mmap2			1172
 #define __NR_pciconfig_read		1173
 #define __NR_pciconfig_write		1174
-- 
1.9.1

