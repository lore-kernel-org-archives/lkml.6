Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2430C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A44912087D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXSIXIDt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A44912087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbeJEWhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 18:37:10 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33432 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728562AbeJEWhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 18:37:09 -0400
Received: by mail-lj1-f195.google.com with SMTP id z21-v6so12009309ljz.0;
        Fri, 05 Oct 2018 08:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YUYTApf9Ln01p3Sm2mbrLepGXp6x8I4qUsUQMJjVy0E=;
        b=JXSIXIDt9ye5i5tS5idFZwmVlNz5jBt+8I+TQYH0b+S4UQ88bVAXn2ZhFITWNsr8rN
         Tv68UykrW1IQyTr91Gwu69J69PLRf35bfqA6p8LsYmGOU949GeKaKgQnIKwWdM5ctYSE
         dVkfcPWCnqnWOCTNsYcIkxgMQc93j50e4xUPGERIdlZVQe96zsWI7csefiGRdfet64Na
         UuBwyMe1wfqsqhVcLd90VWMfmNz4OTfMgBAVzsqF0a0hbZ+BDUjUwwoHPZYyIWb+95rs
         kUqZgid05T/Emz+92A7wt60qMyv/ks0OZ3liPGN581+BSoK3pROAzYOuVquq75TqS+wF
         ceeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YUYTApf9Ln01p3Sm2mbrLepGXp6x8I4qUsUQMJjVy0E=;
        b=c0icIQKIawXs46MJ85Cbha+sKs9BpCt4/f3O4u3FKmY4W+kM/nIjw5oIoWwf16h5og
         ZoUTbJt+ATOMbzcfF6GmxWJCnG7dxOSMWcfBpDFoBDe/+ixHaYe6IdlerCjemGt+IJ+N
         Fq87+vvryukpdlleY/5dmY0mJXy/qTQPJxYmgv/o1cH8+T80NA+45LaErvCYsVbsaBuP
         PZTVM52V2D9cavyUmgTbD2WrYfIVs2ydn6uk17UOrzYTMM7lBwo1Hfg3eAyd77xdktNf
         3feb2AGlfMILnYc/0glnH0rulUNNx1AcA9xy6fCHB69fjEFzdS/HdDHA5BMqR9722Ru0
         FQjg==
X-Gm-Message-State: ABuFfoi3lGixHHSg7CXB6nOhrpA3uuZCL6RO5KZT/DoG6iTCJ8Wbji0T
        MOX0bw0Sm35x8wb1eBpNP54=
X-Google-Smtp-Source: ACcGV60RWMV4tVtz//z/CUzMf3i2cF5nrMzVp3yvw/7BRzq0qrmtCddhVYUuXMn8oxDdW4A+mHIJYQ==
X-Received: by 2002:a2e:4502:: with SMTP id s2-v6mr7807939lja.44.1538753872745;
        Fri, 05 Oct 2018 08:37:52 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.gmail.com with ESMTPSA id w22-v6sm1879373lfd.72.2018.10.05.08.37.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 08:37:51 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Maciej Purski <m.purski@samsung.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org
Subject: [PATCH v1 00/11] Continuing the work on coupled regulators
Date:   Fri,  5 Oct 2018 18:36:27 +0300
Message-Id: <20181005153638.1886-1-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Maciej moved on to work on something else and kindly allowed me to
take over the coupled regulators patches [0] which I'll try to finalize.

I recently started to work on adding DVFS support to the CPUFreq driver
of NVIDIA Tegra20/30 which require the coupled regulators functionality.
Both Tegra20 and Tegra30 have the voltage "max-spread" constraint.
Tegra30 has an additional constraint, the "max-step" voltage.

What is done in this series:

1. Re-worked the original "Add voltage balancing mechanism" patch from
   Maciej by:
        1) Fixing infinite loop within regulator_balance_voltage().
        2) Handling suspend_state_t properly.
        3) Fixing broken compilation of the patch.

2. Added pair of patches to clean up regulator-couple resolving.

3. Changed device tree binding of the regulator-coupled-max-spread property
   to make it more flexible.

4. Added new device tree property, the regulator-max-step-microvolt.

5. Implemented wait/wound mutex which was suggested by Lucas Stach in the
   review comment to [0]. I've tested w/w locking extensively (including
   CONFIG_DEBUG_WW_MUTEX_SLOWPATH) and quite confident that everything is
   okay.

6. Patches were tested with KASAN on Tegra20 / Tegra30, I tried to cover
   various cases and verified that voltage constraints not violated under
   different circumstances.

Please review, thanks.

[0] https://lkml.org/lkml/2018/4/23/619

Dmitry Osipenko (9):
  regulator: core: Mutually resolve regulators coupling
  regulator: core: Don't allow to get regulator until all couples
    resolved
  dt-bindings: regulator: Change regulator-coupled-max-spread property
  regulator: core: Limit regulators coupling to a single couple
  dt-bindings: regulator: Document new regulator-max-step-microvolt
    property
  regulator: core: Add new max_uV_step constraint
  regulator: core: Decouple regulators on regulator_unregister()
  regulator: core: Use ww_mutex for regulators locking
  regulator: core: Properly handle case where supply is the couple

Maciej Purski (2):
  regulator: core: Add voltage balancing mechanism
  regulator: core: Change voltage setting path

 .../bindings/regulator/regulator.txt          |   7 +-
 drivers/regulator/core.c                      | 821 +++++++++++++++---
 drivers/regulator/of_regulator.c              |   4 +
 include/linux/regulator/driver.h              |   5 +-
 include/linux/regulator/machine.h             |   3 +
 5 files changed, 713 insertions(+), 127 deletions(-)

-- 
2.19.0

