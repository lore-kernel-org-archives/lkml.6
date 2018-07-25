Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1005DC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF37B20673
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NpQf+GWX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF37B20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731545AbeGYXd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 19:33:59 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45131 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731259AbeGYXd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 19:33:58 -0400
Received: by mail-lj1-f193.google.com with SMTP id q5-v6so8005196ljh.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 15:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7iSybzDmIqLwKWBZIaRGtwBnUI0SFEpnPkyOYs5pykE=;
        b=NpQf+GWXXK6A8g4hvNaMO77KZUShNZrpXvya9BEjx4W9Bp8E6yvLDO4D3Kt7mbpVs2
         UpGnXAr2zfsGthrUKo/xig8Vd6FGLgxMkencGTXhAlLOZgdLqdgil0NRN+Z0tcyUP2kp
         kv9rjOTIacfJ5dIGCN7nlwE0+/Ul8yEl0Hj1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7iSybzDmIqLwKWBZIaRGtwBnUI0SFEpnPkyOYs5pykE=;
        b=bXvS7CVwKMs4p1khj9J/9YzVbmZyKJYtZVbtcneAE3AxmiGE2hy09D7Ge2lXJavfK8
         CUmqodixVyI2WT8Il0PfSr3bkQyxMYU/P5YJU3+IfvGBxQtuI7sROkM69lfS5cVSoKkV
         lwzuoeUpqLldM+g/3opWT0XC3YtNDjS3NluK1/cAGz0sBUqVplVIQtWWsCyIjoTwCiO4
         ThNan4Ar50VQI2G3aYFwgi/SKnhav2HqL6rndc+g6APop1jjDp0gKlNqr6j9WdLKKw7T
         gFDMbvRUPUv45l5OEc7pB3aJHOP01vEclyg7G+xL5GelCGYkc4J3mw98a6vRhQeXPWME
         QCrw==
X-Gm-Message-State: AOUpUlHQPROQPeZjswzHxoGcrqsWLKFOUifJTGcGycNLqJ/vWgMVQiUE
        ZZKTPB4QF7B8PSJafvj7eGAtCQ==
X-Google-Smtp-Source: AAOMgpcyO3LkViD5PxJIbAGzJuVPnaxPgUqekls78VbeF+CWC74Ell95wIaEK9GWGf/V2+WSq2gIYQ==
X-Received: by 2002:a2e:1609:: with SMTP id w9-v6mr16348435ljd.120.1532557213929;
        Wed, 25 Jul 2018 15:20:13 -0700 (PDT)
Received: from localhost (c-2c3d70d5.07-21-73746f28.bbcust.telenor.se. [213.112.61.44])
        by smtp.gmail.com with ESMTPSA id b87-v6sm2355529lfh.33.2018.07.25.15.20.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 15:20:13 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     davem@davemloft.net, santosh.shilimkar@oracle.com,
        ka-cheong.poon@oracle.com
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] net/rds/Kconfig: RDS should depend on IPV6
Date:   Thu, 26 Jul 2018 00:20:08 +0200
Message-Id: <20180725222008.32186-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Build error, implicit declaration of function __inet6_ehashfn shows up
When RDS is enabled but not IPV6.
net/rds/connection.c: In function ‘rds_conn_bucket’:
net/rds/connection.c:67:9: error: implicit declaration of function ‘__inet6_ehashfn’; did you mean ‘__inet_ehashfn’? [-Werror=implicit-function-declaration]
  hash = __inet6_ehashfn(lhash, 0, fhash, 0, rds_hash_secret);
         ^~~~~~~~~~~~~~~
         __inet_ehashfn

Current code adds IPV6 as a depends on in config RDS.

Fixes: eee2fa6ab322 ("rds: Changing IP address internal representation to struct in6_addr")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 net/rds/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rds/Kconfig b/net/rds/Kconfig
index 41f75563b54b..607128f10bcd 100644
--- a/net/rds/Kconfig
+++ b/net/rds/Kconfig
@@ -1,7 +1,7 @@
 
 config RDS
 	tristate "The RDS Protocol"
-	depends on INET
+	depends on INET && CONFIG_IPV6
 	---help---
 	  The RDS (Reliable Datagram Sockets) protocol provides reliable,
 	  sequenced delivery of datagrams over Infiniband or TCP.
-- 
2.18.0

