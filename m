Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E92C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 13:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6D0C223F0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 13:37:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6D0C223F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbeHJQHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 12:07:07 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33751 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727534AbeHJQHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 12:07:07 -0400
Received: by mail-ed1-f65.google.com with SMTP id x5-v6so4801801edr.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 06:37:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nC64HXh9s6xAhuP0k6nSaDLdVfafxPhLHIo55xqvySs=;
        b=Vil6cZPCbZ6WUpAgvdSGzjZ+eW8QiAOQBreuhTppYHwk8zS7esUhuZVfGuNVwXizPr
         cSVCZEY05676cbjydy1zGde/EXkJGQiIR9si4NWB53SgdCGdF7wPRjSEZzaOiwAgT5KH
         vW7c+9LO3tZz3gSNRzf4Ya7h6tjFUsnHPWIlc5iJs1B3OSCZZwc378E04/TQzVNZzdQA
         b1195ajlPttU2p9eEUsas8OmmMpv5WgVuhMZqUGS2hxJTEW0IpvbNanB5tv3qm98YWYu
         3Zktk2ShwZbGCVYs7jzk8EI/2XKsLi9dXLu9QHLuj7w1MD8+7+NbSZVBXyDcNniKgJ6e
         db2g==
X-Gm-Message-State: AOUpUlEhPL1lolXXRXrEPc3t3/sl+Ka3m/2C3uOEvw+ILMmFi1t4I6fp
        Oj08Cs2sY0z9JpgPBoel1a0=
X-Google-Smtp-Source: AA+uWPxnA91ybT7mZ+e3vmhYG6y6nyafAzhA+MVZq0lAReF0Bh97856nsF5rlJzEGgRV01rXHQ3ikA==
X-Received: by 2002:aa7:da16:: with SMTP id r22-v6mr8483480eds.54.1533908229338;
        Fri, 10 Aug 2018 06:37:09 -0700 (PDT)
Received: from green.intra.ispras.ru (bran.ispras.ru. [83.149.199.196])
        by smtp.googlemail.com with ESMTPSA id u25-v6sm6488052edm.45.2018.08.10.06.37.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 Aug 2018 06:37:08 -0700 (PDT)
From:   efremov@linux.com
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org,
        Denis Efremov <efremov@linux.com>
Subject: [PATCH] coccicheck: return proper error code on check fail 
Date:   Fri, 10 Aug 2018 16:36:36 +0300
Message-Id: <20180810133636.8340-1-efremov@linux.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If coccicheck finds errors, it should return an error code
distinct from zero. Current code instead of exiting with an
error code of coccinelle returns error code of
'echo "coccicheck failed"' which is almost always equals to zero,
thus failing original intention of alerting about errors.
This patch fixes the problem.

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

