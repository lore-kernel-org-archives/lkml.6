Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD44FC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 05:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E399207DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 05:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NcJIvYQh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E399207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbeJZNtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 09:49:43 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39464 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbeJZNtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 09:49:42 -0400
Received: by mail-pl1-f194.google.com with SMTP id e67-v6so4918439plb.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 22:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0PBH0SiDBTS5A/xCIVzOHbzcxzD+kYNUD3TokR7YxPA=;
        b=NcJIvYQhdNJIAO6MZvPj9r2/cUbrsbW8Rm7RoSXpJuMhu++5LQ/txBjKU4qOKn1H/H
         ZLhkQb+aFVPPGhwukC35V8RckOXwWbT/PwCBEnN825YKze/yzZ+Ce/GTBSaD1ybyP50k
         rK3xYQiDUKdPpW+pIMqwjagkCMuZJZCCtNRhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0PBH0SiDBTS5A/xCIVzOHbzcxzD+kYNUD3TokR7YxPA=;
        b=ddu1bCFWEOmWQkWT/uaH3ecGFWDDDACAHDErm04rfbDivfe5HMh37vofyFA9zIhAuS
         +2VaionQTb6VB51fEat1g0tbaRRURrmpITc4yx1ki3mtpIIDP1Jaubv0BBDSrbj4D83W
         aEOBqZg/n/uOtO9HBzDa/khdut2DkH6j0zOEJWQT74Wipq7XItnPR2otwCN7SCRySsCl
         NN6F0zWJQTp6KH9fS0nLAl7387qhS7Scw3enBIxpfg9qx+Ii87vao4Ro5Si5A+SdoIQ3
         fkYhNKlHQxuxbCg6VWkXip6sQC+btr4j2dT+c4GJp45HheZFLGxNIBcMd2DVNappGMgD
         IAjQ==
X-Gm-Message-State: AGRZ1gJl0QZdTVNErgIERXZ94U1jRJUWynCYb74SETyn98wXIAN9JoM/
        ZIBqLWMReaKLathZYyBfjPEQ8bIzmHo=
X-Google-Smtp-Source: AJdET5fE83mDgW7QXknmg5fmbtPhZFGm9JbVqLfaydVTvIxpHYgHsR3f/lFBNqGZBZmhZiqt9MGhKw==
X-Received: by 2002:a17:902:7683:: with SMTP id m3-v6mr2155878pll.180.1540530851576;
        Thu, 25 Oct 2018 22:14:11 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([49.207.61.165])
        by smtp.gmail.com with ESMTPSA id m16-v6sm3329302pff.173.2018.10.25.22.14.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Oct 2018 22:14:11 -0700 (PDT)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linux-parisc@vger.kernel.org,
        "James E . J . Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v6 5/5] parisc: syscalls: ignore nfsservctl for other architectures
Date:   Fri, 26 Oct 2018 10:43:11 +0530
Message-Id: <1540530791-3961-6-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540530791-3961-1-git-send-email-firoz.khan@linaro.org>
References: <1540530791-3961-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an exception to the syscall table checking script.

nfsservctl entry is only provided on x86, and there is no
reason to add it elsewhere. However, including it on the
syscall table caused a warning for most configurations on
non-x86.

<stdin>:696:2: warning: #warning syscall nfsservctl not implemented [-Wcpp]

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 scripts/checksyscalls.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/checksyscalls.sh b/scripts/checksyscalls.sh
index ee3dfb5..cf93100 100755
--- a/scripts/checksyscalls.sh
+++ b/scripts/checksyscalls.sh
@@ -150,6 +150,7 @@ cat << EOF
 #define __IGNORE_uselib
 #define __IGNORE__sysctl
 #define __IGNORE_arch_prctl
+#define __IGNORE_nfsservctl
 
 /* ... including the "new" 32-bit uid syscalls */
 #define __IGNORE_lchown32
-- 
1.9.1

