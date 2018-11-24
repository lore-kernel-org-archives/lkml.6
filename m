Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A04DC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 00:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFDBC20892
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 00:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="1rm5n5zy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFDBC20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbeKXLJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 06:09:48 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36108 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbeKXLJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 06:09:48 -0500
Received: by mail-qt1-f194.google.com with SMTP id t13so12050185qtn.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 16:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=Gf9Mk298VLgFGxylm5pkIB6u/8/o4S3rzo5MqHgHO5s=;
        b=1rm5n5zyTUyNMM3ZO/tkcTWGp/Pi4Tr1dc3VVp+G2UJ343VJJPT2yXcSon5EcU/eE3
         4QQjN3PCkQafhVeyOIQg5DrM88xMjDiCPcRK4NrQkPm4oE3flznqPL5KA659XYxTPZcD
         9n37NVmefgk0+qvbi8fLCPq04u9sO9kcyiKPHqRtcMjy/URbUAvLFtBEna6ngZ3rci1P
         u6Z28cqamg5J3FeSAUTACpdt1e+gtGwVf4QKbCRpRsI2qpnwOSJ+d6no094FiinhwTMp
         CCYLpgFdgi/1g4Oz+mo2GMM9QSWMRkFTL+5OEwaYLIcHrXFYa2p792JICY2KKnjdmanz
         haew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Gf9Mk298VLgFGxylm5pkIB6u/8/o4S3rzo5MqHgHO5s=;
        b=Yj3xcS50xrsEut9a/88cT04J+GnHrBjEfLQQTgWECVm1ODftdLeoQ8S0ihtSSeiKct
         TDzh4HERvikAy1Uyted1A8Wes2diswODAsSFv5yrcplM7hSIWVJlJdSZ88AeprswKpAt
         LHE6p2yh95N6Z2+Zn9q8OkKQKA19suhPr7xSECPQTvUevWwFC/cn4yrpini6jYMe7fAd
         P4ub5Q1bph2ZujfqE5qJgP+556KEyttrF6iumxkZEIk8DXh4+mLeDEhvbwg5Nwei8a5q
         HF9eD23xdmdAggXg3kKSxUAKojwz3oIyVQ8j2uIFiBW2OYMnd5bIRmlWYWetAkkRIAx/
         ooIQ==
X-Gm-Message-State: AGRZ1gKaT6tnJngZpfb/sPZznLAhS35AGhB/Zog1ZZSptz3v8qs6mF1V
        KNIDquC8flwepwR2joAlaDktew==
X-Google-Smtp-Source: AJdET5cEibZgV2gxIYCPYTiSQGf+tSy1daDpda4pmF/Hp5udM3rddJc83tr3q7kBKnW5+Y9MypXESA==
X-Received: by 2002:ac8:12cc:: with SMTP id b12mr16416975qtj.90.1543019006589;
        Fri, 23 Nov 2018 16:23:26 -0800 (PST)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::3])
        by smtp.gmail.com with ESMTPSA id o34sm26707515qte.4.2018.11.23.16.23.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 16:23:25 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        kernel-usp@googlegroups.com, victorcolombo@gmail.com
Subject: [PATCH v3 0/7] staging:iio:ad2s90: Add dt support and move out of staging
Date:   Fri, 23 Nov 2018 22:23:05 -0200
Message-Id: <20181124002312.6923-1-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds device tree support to ad2s90, adds the respective dt-binding
documentation, solves all remaining codestyle problems for ad2s90 and move it
out of staging.

This patch set completes all the remaining itens listed to be done before moving
the driver out of staging, enumerated in this mail thread:
https://marc.info/?l=linux-iio&m=154028966111330&w=2.

Alexandru Ardelean (1):
  staging:iio:ad2s90: Add max frequency check at probe

Matheus Tavares (5):
  staging:iio:ad2s90: Add device tree support
  staging:iio:ad2s90: Remove spi setup that should be done via dt
  dt-bindings:iio:resolver: Add docs for ad2s90
  staging:iio:ad2s90: Replace license text w/ SPDX identifier
  staging:iio:ad2s90: Move out of staging

Victor Colombo (1):
  staging:iio:ad2s90: Add comment to device state mutex

 .../bindings/iio/resolver/ad2s90.txt          |  31 +++++
 drivers/iio/resolver/Kconfig                  |  10 ++
 drivers/iio/resolver/Makefile                 |   1 +
 drivers/iio/resolver/ad2s90.c                 | 131 ++++++++++++++++++
 drivers/staging/iio/resolver/Kconfig          |  10 --
 drivers/staging/iio/resolver/Makefile         |   1 -
 drivers/staging/iio/resolver/ad2s90.c         | 127 -----------------
 7 files changed, 173 insertions(+), 138 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/resolver/ad2s90.txt
 create mode 100644 drivers/iio/resolver/ad2s90.c
 delete mode 100644 drivers/staging/iio/resolver/ad2s90.c

-- 
2.18.0

