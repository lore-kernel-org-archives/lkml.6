Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5515C18E01
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BABA2146D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="O+euQ7cO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BABA2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730687AbeK3ETM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:19:12 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41339 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728551AbeK3ETL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:19:11 -0500
Received: by mail-wr1-f66.google.com with SMTP id x10so2665592wrs.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 09:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B3Orb74WwT6irLdvQjoh7i+GpPzyw+FEcB0oGPiZXlw=;
        b=O+euQ7cOPUSvTs0X63EO/sOSn7bDdrMGZJ5nE1modkea/IlEoTYp6VkHHZtZa/61aA
         B+VBxGQZ6y/i+q9i6B3V5aJqNEin4OkrJAnfp7SShnyPgSmw4KBttr4E/6qg8f0uY/Kq
         mPFOiayoNqoeagrCpxVdR1sjiUWaJgacNx0mA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B3Orb74WwT6irLdvQjoh7i+GpPzyw+FEcB0oGPiZXlw=;
        b=Aq25pkAYql6XfUaboU8DrDEv1dVlzBZ6Fo1inTYHiAJB7BkLNTz8kaaOheyTMtpEFR
         uyZ8/KRS8mI7Dv56Tc0k1qCptdRiqS3xLN9Y4ho8fzGu1Z6lNoln0pQBCCACk0s3d2zU
         pFZdpIqSJERcIC7bU8tttHUhqq0qQ975of9YNPKSSwLzr0efFVb63Etzm6eUJXMV5gs/
         n5R8EZVUKbEU4g7b8OVt/Ba80AZ8cqE2cApcGHFDu+eYwZNSI2ITgL6BhZ4Y+LU6hTrK
         6YRaqYBSrU/xjkH93fOBUAUXuKaelDj0HkIKLSslAL6yFhqoMhOcxRFGYP0OLZfBVrEC
         KBWg==
X-Gm-Message-State: AA+aEWbFElPFttcdDKYKvVnfBjsZbIZa+Kr98YutbygD5BmbdWP3ontO
        MS4ygdA9Vkff+OwctXTM6lLKgg==
X-Google-Smtp-Source: AFSGD/VXU3Gv8ZHfIWa1Y/lIBR/IIvc8fDnsn3MW5lTMJdLElHbXsGE2kJul1o7vEl37VNZ178NB1w==
X-Received: by 2002:adf:8228:: with SMTP id 37mr2092166wrb.160.1543511585964;
        Thu, 29 Nov 2018 09:13:05 -0800 (PST)
Received: from harold.home ([2a01:cb1d:112:6f00:f070:d240:312e:9f99])
        by smtp.gmail.com with ESMTPSA id y185sm1593882wmg.34.2018.11.29.09.13.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 09:13:05 -0800 (PST)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Joe Perches <joe@perches.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        YiFei Zhu <zhuyifei1999@gmail.com>
Subject: [PATCH 11/11] efi/x86: earlyprintk - Fix infinite loop on some screen widths
Date:   Thu, 29 Nov 2018 18:12:30 +0100
Message-Id: <20181129171230.18699-12-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181129171230.18699-1-ard.biesheuvel@linaro.org>
References: <20181129171230.18699-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YiFei Zhu <zhuyifei1999@gmail.com>

An affected screen resolution is 1366 x 768, which width is not
divisible by 8, the default font width. On such screens, when longer
lines are earlyprintk'ed, overflow-to-next-line can never trigger,
due to the left-most x-coordinate of the next character always less
than the screen width. Earlyprintk will infinite loop in trying to
print the rest of the string but unable to, due to the line being
full.

This patch makes the trigger consider the right-most x-coordinate,
instead of left-most, as the value to compare against the screen
width threshold.

Signed-off-by: YiFei Zhu <zhuyifei1999@gmail.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/platform/efi/early_printk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/platform/efi/early_printk.c b/arch/x86/platform/efi/early_printk.c
index 7476b3b097e1..7138bc7a265c 100644
--- a/arch/x86/platform/efi/early_printk.c
+++ b/arch/x86/platform/efi/early_printk.c
@@ -183,7 +183,7 @@ early_efi_write(struct console *con, const char *str, unsigned int num)
 			num--;
 		}
 
-		if (efi_x >= si->lfb_width) {
+		if (efi_x + font->width > si->lfb_width) {
 			efi_x = 0;
 			efi_y += font->height;
 		}
-- 
2.19.1

