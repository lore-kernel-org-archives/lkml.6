Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIM_INVALID,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7516AC5CFF0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C0EF20660
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dghS29vC";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BqPiMCDj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C0EF20660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934204AbeFKR0Z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 13:26:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51768 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933350AbeFKR0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 13:26:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4E496607E7; Mon, 11 Jun 2018 17:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528737982;
        bh=O+0eCRdefnLHmE8fkQxdyCVhzbuAaSz1GhnwHQe8bsU=;
        h=From:To:Cc:Subject:Date:From;
        b=dghS29vCp4Usjo6Kf7Uoo92BUHC2UUj6mVNpkEumAAJgEfI34gd1Goo56eCF8uPML
         y0hevSw7mkpHKinJOJQJKTU1uqv+Cfhibtrgl+I+/Q0IpJzKrArc1TAzybSWMHsuYW
         IEf9/MwDCWMzKYI9gr+wiI/lV8pVBgGBlvenv+5A=
Received: from rplsssn-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C3A8A6074D;
        Mon, 11 Jun 2018 17:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528737981;
        bh=O+0eCRdefnLHmE8fkQxdyCVhzbuAaSz1GhnwHQe8bsU=;
        h=From:To:Cc:Subject:Date:From;
        b=BqPiMCDj6rG568xwuYwmB6MnPObpzErcQl7HXCq/Aqwj801v21uqabDsT9lMcpquW
         TfVMddIPi8mOlDuRlJJDflOB2e3m9n1LA7lRSore5wP/uWXPjZpzFam8t+poycZNz1
         qjyGXczUbnDlDo7K91qh8BPIcpB1dhZpphfKZmMU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C3A8A6074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
From:   Raju P L S S S N <rplsssn@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        evgreen@chromium.org, dianders@chromium.org, mka@chromium.org,
        ilina@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH v10 00/10] drivers/qcom: add RPMH communication support
Date:   Mon, 11 Jun 2018 22:55:39 +0530
Message-Id: <1528737949-17495-1-git-send-email-rplsssn@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>

Changes in v10:
- Remove export.h inclusion as suggested by Doug
- Remove rsc_drv_list
- Add EXPORT_SYMBOL
- Remove wait_count as suggested by Doug
- Free memory if cache_batch returns error as suggested by Doug
- Add batch requests to list and simplify error handling as
- return ERR_PTR if invalidate fails

Changes in v9:
- Remove EXPORT_SYMBOL as suggested by Doug
- Add Reviewed-by tags
- Rename lock variable as suggested by Doug
- Add WARN_ON if completion timeout occurs as suggested by Doug
- Fix the bound checks as suggested by Matthias
- Improve comments as suggested by Doug
- Add check for freeing dynamically allocated request object
- Rename label as suggested by Doug
- Fix IS_ERR_OR_NULL check to IS_ERR as suggested by Doug
- Add check to call rpmh_rsc_invalidate if -EAGAIN is retured
  as suggested by Doug

Changes in v8:
- Bounds check for cmd_cache
- Describe interrupts to other DRVs in DT bindings
- Rebase on top of 4.17-rc3

Changes in v7:
- Rename 'm' and 'n' and use tcs_id and cmd_id instead
- Bug fix in find_match() and other review comments from Matthias
- Spinlock around get_rpmh_ctrlr()
- DT documentation example fixes
- Rebase on top of 4.16-rc2

Changes in v6:
- Remove tasklet in rpmh-rsc.c
- Remove rpmh_client and use struct device * instead
- Variable changes and bug fixes
- DT binding changes to describe all DRVs in the RSC
- Documentation and comment fixes

Changes in v5:
- Add Reviewed-by tags
- Rebase on top of 4.16

Changes in v4:
- Rename variables as suggested by Stephen and Evan
- Lot of minor syntax and style fixes
- Fix FTRACE compilation error
- Improve doc comments and DT description

Changes in v3:
- Address Steven's comments in FTRACE
- Fix DT documentation as suggested by Rob H
- Fix error handling in IRQ handler as suggested by Evan
- Remove locks in rpmh_flush()
- Improve comments

Changes in v2:
- Added sleep/wake, async and batch requests support
- Addressed Bjorn's comments
- Private FTRACE for drivers/soc/qcom as suggested by Steven
- Sparse checked on these patches
- Use SPDX license commenting sytle

This set of patches add the ability for platform drivers to make use of shared
resources in newer Qualcomm SoCs like SDM845. Resources that are shared between
multiple processors in a SoC are generally controlled by a dedicated remote
processor. The remote processor (Resource Power Manager or RPM in previous QCOM
SoCs) receives requests for resource state from other processors using the
shared resource, aggregates the request and applies the result on the shared
resource. SDM845 advances this concept and uses h/w (hardened I/P) blocks for
aggregating requests and applying the result on the resource. The resources
could be clocks, regulators or bandwidth requests for buses. This new
architecture is called RPM-hardened or RPMH in short.

Since this communication mechanism is completely hardware driven without a
processor intervention on the remote end, existing mechanisms like RPM-SMD are
no longer useful. Also, there is no serialization of data or is data is written
to a shared memory in this new format. The data used is different, unsigned 32
bits are used for representing an address, data and header. Each resource's
property is a unique u32 address and have pre-defined set of property specific
valid values. A request that comprises of <header, addr, data> is sent by
writing to a set of registers from Linux and transmitted to the remote slave
through an internal bus. The remote end aggregates this request along with
requests from other processors for the <addr> and applies the result.

The hardware block that houses this functionality is called Resource State
Coordinator or RSC. Inside the RSC are set of slots for sending RPMH requests
called Trigger Commands Sets (TCS). The set of patches are for writing the
requests into these TCSes and sending them to hardened IP blocks.

The driver design is split into two components. The RSC driver housed in
rpmh-rsc.c and the set of library functions in rpmh.c that frame the request and
transmit it using the controller. This first set of patches allow a simple
synchronous request to be made by the platform drivers. Future patches will add
more functionality that cater to complex drivers and use cases.

Please consider reviewing this patchset.

v1: https://www.spinics.net/lists/devicetree/msg210980.html
v2: https://lkml.org/lkml/2018/2/15/852
v3: https://lkml.org/lkml/2018/3/2/801
v4: https://lkml.org/lkml/2018/3/9/979
v5: https://lkml.org/lkml/2018/4/5/480
v6: https://lkml.org/lkml/2018/4/19/914
v7: https://lkml.org/lkml/2018/5/2/779
v8: https://lkml.org/lkml/2018/5/9/729
v9: https://lkml.org/lkml/2018/5/24/530

Lina Iyer (10):
  drivers: qcom: rpmh-rsc: add RPMH controller for QCOM SoCs
  dt-bindings: introduce RPMH RSC bindings for Qualcomm SoCs
  drivers: qcom: rpmh-rsc: log RPMH requests in FTRACE
  drivers: qcom: rpmh: add RPMH helper functions
  drivers: qcom: rpmh-rsc: write sleep/wake requests to TCS
  drivers: qcom: rpmh-rsc: allow invalidation of sleep/wake TCS
  drivers: qcom: rpmh: cache sleep/wake state requests
  drivers: qcom: rpmh: allow requests to be sent asynchronously
  drivers: qcom: rpmh: add support for batch RPMH request
  drivers: qcom: rpmh-rsc: allow active requests from wake TCS

 .../devicetree/bindings/soc/qcom/rpmh-rsc.txt      | 137 +++++
 drivers/soc/qcom/Kconfig                           |  10 +
 drivers/soc/qcom/Makefile                          |   4 +
 drivers/soc/qcom/rpmh-internal.h                   |  79 +++
 drivers/soc/qcom/rpmh-rsc.c                        | 678 +++++++++++++++++++++
 drivers/soc/qcom/rpmh.c                            | 586 ++++++++++++++++++
 drivers/soc/qcom/trace-rpmh.h                      |  82 +++
 include/dt-bindings/soc/qcom,rpmh-rsc.h            |  14 +
 include/soc/qcom/rpmh.h                            |  51 ++
 include/soc/qcom/tcs.h                             |  56 ++
 10 files changed, 1697 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt
 create mode 100644 drivers/soc/qcom/rpmh-internal.h
 create mode 100644 drivers/soc/qcom/rpmh-rsc.c
 create mode 100644 drivers/soc/qcom/rpmh.c
 create mode 100644 drivers/soc/qcom/trace-rpmh.h
 create mode 100644 include/dt-bindings/soc/qcom,rpmh-rsc.h
 create mode 100644 include/soc/qcom/rpmh.h
 create mode 100644 include/soc/qcom/tcs.h

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project

