Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662F3C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 03:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 307A8208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 03:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WNgHNzlu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 307A8208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbeK0OJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 09:09:24 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:54990 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728511AbeK0OJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 09:09:24 -0500
Received: by mail-it1-f194.google.com with SMTP id m123-v6so7784598ita.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 19:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UNR7WQBsg6SMTrLbOHn0u1gL1Kd8gB6JnhT0P9RIk0s=;
        b=WNgHNzlu1vfMPm0OjpQTZzSHm8jb2ftPDjxJvmhhJzhhDOEqr+8o6gkRUMrsGp0WFZ
         x47aB00bfNqoTjF4WBMBXnXqHiWnDwsnN/rTUQiFEoBAxv1c3WOxafqNMJDwFqKzRjfU
         1h7AuRGZQVJW4tkfScQVfarboCg3f5uK5BZuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UNR7WQBsg6SMTrLbOHn0u1gL1Kd8gB6JnhT0P9RIk0s=;
        b=SssJs/VhpP90OtKXwgM6fICUUk1uU8k/Eke/ldiNHQhxJbOQ2i5nFOy+I3XmGKx8Tn
         x9tbDmygdXpDLvCmbvk6Ah6d/mPTAEOHJmKQmfEFh1w5I/JRtUm5TrbZ16LarIm6MdhF
         Df6aS6D7P8TkIRhZZG4EZejD3uWcQYJCob1+F1tcok4mSynon8OWNUUUf0hFbTdxnYIq
         cfQ2/5tqCYfV/575cMek7z5PgFQYItyP97gdetymBmZhBA/a3jZHwq+/vkg4Oh9B9DzW
         75Zd4YhFVB0+QNF2gNy7Qfn/k8bRgqoH4pyAZ4Qc7XPYNlTFlDFNXjcS60RbBmsNkZ5e
         ONyw==
X-Gm-Message-State: AA+aEWbPTk6nbSOUZ1j7MDleH1cqPd53HwWTuytpV9DK5ba8hTUP+c86
        yklFdgPMhvUqAfh6uDKAAzQ668l4pZ0=
X-Google-Smtp-Source: AFSGD/VXL+aSMH1u1OcEnwIrmxMibaXjSJ+Un++lK3iLSPGnrLODCRUiS7Lw7WDLuaA8DooKuW1Upg==
X-Received: by 2002:a24:d60a:: with SMTP id o10mr23558527itg.162.1543288380352;
        Mon, 26 Nov 2018 19:13:00 -0800 (PST)
Received: from localhost (c-107-2-67-121.hsd1.mn.comcast.net. [107.2.67.121])
        by smtp.gmail.com with ESMTPSA id w16sm1775480ita.38.2018.11.26.19.12.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 19:12:59 -0800 (PST)
From:   Dan Rue <dan.rue@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dan Rue <dan.rue@linaro.org>, Shuah Khan <shuah@kernel.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH 2/2] selftests: firmware: add CONFIG_FW_LOADER_USER_HELPER_FALLBACK to config
Date:   Mon, 26 Nov 2018 21:12:16 -0600
Message-Id: <20181127031218.24419-3-dan.rue@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181127031218.24419-1-dan.rue@linaro.org>
References: <20181127031218.24419-1-dan.rue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y is required for fw_fallback.sh.
Without it, fw_fallback.sh fails with 'usermode helper disabled so
ignoring test'. Enable the config in selftest so that it gets built by
default.

Signed-off-by: Dan Rue <dan.rue@linaro.org>
---
 tools/testing/selftests/firmware/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/firmware/config b/tools/testing/selftests/firmware/config
index bf634dda0720..913a25a4a32b 100644
--- a/tools/testing/selftests/firmware/config
+++ b/tools/testing/selftests/firmware/config
@@ -1,5 +1,6 @@
 CONFIG_TEST_FIRMWARE=y
 CONFIG_FW_LOADER=y
 CONFIG_FW_LOADER_USER_HELPER=y
+CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
-- 
2.19.1

