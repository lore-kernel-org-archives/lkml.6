Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC697C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 05:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D084207DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 05:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YKF6u4GB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D084207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbeJZNrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 09:47:17 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36105 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbeJZNrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 09:47:17 -0400
Received: by mail-pg1-f193.google.com with SMTP id z17-v6so1772939pgv.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 22:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1L7LTEmOplJ0dgGgsahfwyq4YoVWgFKdhmm3eA4hf8A=;
        b=YKF6u4GBTDEaFLACGG3Uhw0OcunjYHTay6n303PnfDJiy8seJt9dgucfApjCQdEsHU
         6GmBGb3lr3miwIuJ3NkCrrlHoLzeRJWehOMtidPO81limxAr7jirghncJEeRCWq+ICju
         6kiifEraNVten4T7E47k2H0P2NYRUVixvJQ/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1L7LTEmOplJ0dgGgsahfwyq4YoVWgFKdhmm3eA4hf8A=;
        b=sUDZ3yElNIoyQCOsd81ow693YJ1t7rS9YQ59qs9ToLNCib88pHACla68h+kDBraE6W
         rfadnwqyxr6/210iGxQIlmCPiP7rjZ+kuLIUE58qfcSbmBhFdquy5CctWeRkpmAx1tcF
         DlahEvHq+g2d08DqJWOPaKlPu31HKkxXwqXEumaYaZtJKjt8l+fY0fNv8/yuMeTHXdoC
         fIzRoC5p+WbOjMA1scX3RLxGoS5IfCIeuxRTxTns0yzAqthUaodOyd5ocZ+iY/wM1QKY
         SxmoUe4zwyUd6C36WbM04pU26/ZiVtEWlcgYKPsT19vfX+s/q0UUyzZGwlTfdSGM/u2s
         rIDw==
X-Gm-Message-State: AGRZ1gJmMhlWAZI2P54FgDwIQblfb4PvM9Cb14Hb+NL8aJ4blU6gfDsD
        o+I0iEg2aZ+xqgOE1Q9QzSi7Bg==
X-Google-Smtp-Source: AJdET5d33rGdw4A7hmKkb3bdlWfMKl/EhO1O2HHd1stmdDbQdvXynS5mpamI2PL0yllNrMQa1LTKPQ==
X-Received: by 2002:a62:a50d:: with SMTP id v13-v6mr2217739pfm.18.1540530707259;
        Thu, 25 Oct 2018 22:11:47 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([49.207.61.165])
        by smtp.gmail.com with ESMTPSA id u13-v6sm9608912pgp.18.2018.10.25.22.11.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Oct 2018 22:11:46 -0700 (PDT)
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
Subject: [PATCH v4 1/5] ia64: add __NR_old_getpagesize in uapi header file
Date:   Fri, 26 Oct 2018 10:41:10 +0530
Message-Id: <1540530674-3824-2-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540530674-3824-1-git-send-email-firoz.khan@linaro.org>
References: <1540530674-3824-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sys_getpagesize entry is present in kernel/entry.S file to
support for old user interface. So we need to add an uapi
entry too.

Add __NR_old_getpagesize in uapi/asm/unistd.h in order to
not break old user space as it is reserved for backwards
compatibility with old __NR_getpagesize.

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

