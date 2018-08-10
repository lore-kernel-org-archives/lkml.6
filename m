Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39882C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 20:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5BFC21476
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 20:26:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5BFC21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbeHJW5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 18:57:48 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:43623 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbeHJW5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 18:57:48 -0400
Received: by mail-ed1-f44.google.com with SMTP id j21-v6so5371797edp.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 13:26:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e2lCaN4bxj0wTc7Kvb14h0zjyZeV2bNNdC1rVqx10+w=;
        b=d2ccoWF9D1ZgPiblAcRRZE5Ro3+3v5lG0osfQ2/1BNHlihm1y7hWdpb4xG1u23ZRBU
         yEnw4fysClqeIxGKjAPDnxqn8qTLGXzQq/SUzUlwbAnEryF4kAJTZNk4KkMyBfpXyily
         ZcKmoZBUod71iACmN8c2uON8dMkRIhw5LgxgWXv7ZjChDv9djsrCv+Trh68mu4S5Cj6C
         JhItNIhHZAGcdPkFN8d4um0WH55W4OPwfbDyqGoDoRsjRcPJvLBGkbP0wwOx/1rb2rsO
         CnkL4FrCEz/NkxJmbj7+L3plEFl55GqmAF2Thak8nkqerHTq0rfdeoG419geExZhCIy7
         ZEaQ==
X-Gm-Message-State: AOUpUlGnrK0K5R21hyXQQOYfT2EySZ46bJ+icyyMpAfDFHAYjmf+qEnB
        sTPXQ04OJCsCot94N8BRvh4=
X-Google-Smtp-Source: AA+uWPwj+pf4zGSdtKj85p+MBYThrBFUnwJPK+i4wwBVa7K0lZZbdJ2nmxeBJtlNaBOhs+wQG8h+uA==
X-Received: by 2002:a50:8b88:: with SMTP id m8-v6mr10530543edm.165.1533932783720;
        Fri, 10 Aug 2018 13:26:23 -0700 (PDT)
Received: from green.intra.ispras.ru (bran.ispras.ru. [83.149.199.196])
        by smtp.googlemail.com with ESMTPSA id b41-v6sm8956327eda.38.2018.08.10.13.26.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 Aug 2018 13:26:22 -0700 (PDT)
From:   efremov@linux.com
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     Denis Efremov <efremov@linux.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: [PATCH v2] coccicheck: return proper error code on fail
Date:   Fri, 10 Aug 2018 23:25:55 +0300
Message-Id: <20180810202555.11034-1-efremov@linux.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180810133636.8340-1-efremov@linux.com>
References: <20180810133636.8340-1-efremov@linux.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Efremov <efremov@linux.com>

If coccicheck fails, it should return an error code distinct from zero
to signal about an internal problem. Current code instead of exiting with
the tool's error code returns the error code of 'echo "coccicheck failed"'
which is almost always equals to zero, thus failing the original intention
of alerting about a problem. This patch fixes the code.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 scripts/coccicheck | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index 9fedca611b7f..e04d328210ac 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -128,9 +128,10 @@ run_cmd_parmap() {
 	fi
 	echo $@ >>$DEBUG_FILE
 	$@ 2>>$DEBUG_FILE
-	if [[ $? -ne 0 ]]; then
+	err=$?
+	if [[ $err -ne 0 ]]; then
 		echo "coccicheck failed"
-		exit $?
+		exit $err
 	fi
 }
 
-- 
2.17.1

