Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5756BC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FD992133F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="c8gTA69v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FD992133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbeK1FCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 00:02:35 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:37212 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbeK1FCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 00:02:35 -0500
Received: by mail-wm1-f51.google.com with SMTP id g67so9739976wmd.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 10:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I1dCCKcSrdyMdX7ZtjZEmH50Fm7bA7CSIp+F9f/Y5l0=;
        b=c8gTA69vepmHvNueruytrRYeJgrKGlM7yU2i6zlOlPpoMfcu9yVth7tjusfay6cssp
         hr75q0Pq2P10Fpq5Fs8Ma6s4HC+dNLSHmjpNkrc6Nb0s1kPbX4YdSysW5sE8tjQUSf5a
         AWdnJz/FLbKEDASK0wDaeNvbZLcI8wz4F2XY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I1dCCKcSrdyMdX7ZtjZEmH50Fm7bA7CSIp+F9f/Y5l0=;
        b=X9Ti144OG7tXE7yx9KwWJNGdLv25ugCoiqZrg7xHNvEQfJFdADYlLzrJf+YJgw8mFJ
         ce20a5CcwfOVvOOsEo2B2G9GCsmHlgZ6EfZwoOg+hbxypsgifXPcxK3HN9zBweuxY/9C
         5yBBrVGJVsFmtBMaEAFGCfnuTQbW8aTuiir4kq/Tparoh9bL5duUSSjT49tFdOfzZG/U
         Q0E47LW2BJ0TY0NWfpyJEIuW+CKYLnuJBYfR0tqLCTm37fRzbk7gaXkmzSYqRZGqxLgS
         6V9V0tXuS5RHd2zFv3fsiy60plZZS5mDF+Utu513H/pDSlS6hXB02FLCppBlsMjmEige
         6iPQ==
X-Gm-Message-State: AGRZ1gLjrQeLf17hTqubOuSrw740C0hv1ctbDDuJmo1iwiBITh4ZSr6U
        FY84lW1JIa/7DOw3bBgvY1yI3w==
X-Google-Smtp-Source: AJdET5ejxgk6vLaUVXm8M46Vrm7owym9+1J2POKufgLIQPR1YA6S2kvfJbttxuaSm/fj2bnHPTDFog==
X-Received: by 2002:a1c:8089:: with SMTP id b131mr29247794wmd.141.1543341831101;
        Tue, 27 Nov 2018 10:03:51 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id a17sm6459921wrs.58.2018.11.27.10.03.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Nov 2018 10:03:50 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rjw@rjwysocki.net, robh+dt@kernel.org,
        mturquette@baylibre.com, khilman@baylibre.com,
        vincent.guittot@linaro.org, skannan@codeaurora.org,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        evgreen@chromium.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, abailon@baylibre.com,
        maxime.ripard@bootlin.com, arnd@arndb.de, thierry.reding@gmail.com,
        ksitaraman@nvidia.com, sanjayc@nvidia.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH v10 0/8] Introduce on-chip interconnect API
Date:   Tue, 27 Nov 2018 20:03:42 +0200
Message-Id: <20181127180349.29997-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modern SoCs have multiple processors and various dedicated cores (video, gpu,
graphics, modem). These cores are talking to each other and can generate a
lot of data flowing through the on-chip interconnects. These interconnect
buses could form different topologies such as crossbar, point to point buses,
hierarchical buses or use the network-on-chip concept.

These buses have been sized usually to handle use cases with high data
throughput but it is not necessary all the time and consume a lot of power.
Furthermore, the priority between masters can vary depending on the running
use case like video playback or CPU intensive tasks.

Having an API to control the requirement of the system in terms of bandwidth
and QoS, so we can adapt the interconnect configuration to match those by
scaling the frequencies, setting link priority and tuning QoS parameters.
This configuration can be a static, one-time operation done at boot for some
platforms or a dynamic set of operations that happen at run-time.

This patchset introduce a new API to get the requirement and configure the
interconnect buses across the entire chipset to fit with the current demand.
The API is NOT for changing the performance of the endpoint devices, but only
the interconnect path in between them.

The API is using a consumer/provider-based model, where the providers are
the interconnect buses and the consumers could be various drivers.
The consumers request interconnect resources (path) to an endpoint and set
the desired constraints on this data flow path. The provider(s) receive
requests from consumers and aggregate these requests for all master-slave
pairs on that path. Then the providers configure each participating in the
topology node according to the requested data flow path, physical links and
constraints. The topology could be complicated and multi-tiered and is SoC
specific.

Below is a simplified diagram of a real-world SoC topology. The interconnect
providers are the NoCs.

+----------------+    +----------------+
| HW Accelerator |--->|      M NoC     |<---------------+
+----------------+    +----------------+                |
                        |      |                    +------------+
 +-----+  +-------------+      V       +------+     |            |
 | DDR |  |                +--------+  | PCIe |     |            |
 +-----+  |                | Slaves |  +------+     |            |
   ^ ^    |                +--------+     |         |   C NoC    |
   | |    V                               V         |            |
+------------------+   +------------------------+   |            |   +-----+
|                  |-->|                        |-->|            |-->| CPU |
|                  |-->|                        |<--|            |   +-----+
|     Mem NoC      |   |         S NoC          |   +------------+
|                  |<--|                        |---------+    |
|                  |<--|                        |<------+ |    |   +--------+
+------------------+   +------------------------+       | |    +-->| Slaves |
  ^  ^    ^    ^          ^                             | |        +--------+
  |  |    |    |          |                             | V
+------+  |  +-----+   +-----+  +---------+   +----------------+   +--------+
| CPUs |  |  | GPU |   | DSP |  | Masters |-->|       P NoC    |-->| Slaves |
+------+  |  +-----+   +-----+  +---------+   +----------------+   +--------+
          |
      +-------+
      | Modem |
      +-------+

TODO:
* Create icc_set_extended() to handle parameters such as latency and other
  QoS values. Nvidia and Qcom guys are interested in this.
* Cache the path between the nodes instead of walking the graph on each get().
* Sync interconnect requests with the idle state of the device.

Changes since patchset v9 (https://lkml.org/lkml/2018/8/31/444)
* Converted from using global node identifiers to local per provider ids.
* Dropped msm8916 platform driver until we figure out DT bindings.
* Included sdm845 platform driver instead.
* Added macros for converting to mbps, gbps, etc. to icc units.
* Added comments about aggregation, other minor changes.
* Fixed uninitialized variable. (Gustavo A. R. Silva)
* Removed set but not used variable. (YueHaibing)
* Fixed build error without DEBUGFS. (Arnd Bergmann)

Changes since patchset v8 (https://lkml.org/lkml/2018/8/10/387)
* Fixed the names of the files when built as modules.
* Corrected some typos in comments.

Changes since patchset v7 (https://lkml.org/lkml/2018/7/31/647)
* Addressed comments on kernel-doc and grammar. (Randy)
* Picked Reviewed-by: Evan
* Squashed consumer and provider DT bindings into single patch. (Rob)
* Cleaned-up msm8916 DT bindings docs by removing unused port ids.
* Updated documentation for the cases when NULL is returned. (Saravana)
* New patch to add myself as maintainer.

Changes since patchset v6 (https://lkml.org/lkml/2018/7/9/698)
* [patches 1,6]: Move the aggregation within the provider from the framework to
  the platform driver's set() callback, as the aggregation point could be SoC
  specific.
* [patch 1]: Include missing header, reset state only of the traversed nodes,
  move more code into path_init(), add more asserts, move misplaced mutex,
  simplify icc_link_destroy() (Evan)
* [patch 1]: Fix the order of requests to go from source to destination. (Alex)
* [patch 7]: Use better wording in the documentation. (Evan)
* [patch 6]: Reorder struct members, sort nodes alphabetically, improve naming
  of variables , add missing clk_disable_unprepare() in error paths. (Matthias)
* [patch 6]: Remove redundant NULL pointer check in msm8916 driver. (Alex)
* [patch 6]: Add missing depend on QCOM_SMD_RPM in Kconfig. (Evan)
* [patch 3]: Don't check for errors on debugfs calls, remove debugfs directory
  when module is unloaded (Greg)

Changes since patchset v5 (https://lkml.org/lkml/2018/6/20/453)
* Fix the modular build, make rpm-smd driver a module.
* Optimize locking and move to higher level. (Evan)
* Code cleanups. Fix typos. (Evan, Matthias)
* Add the source node to the path. (Evan)
* Rename path_allocate() to path_init() with minor refactoring. (Evan)
* Rename *_remove() functions to *_destroy().
* Return fixed errors in icc_link_destroy(). (Evan)
* Fix krealloc() usage in icc_link_destroy(). (Evan)
* Add missing kfree() in icc_node_create(). (Matthias)
* Make icc_node_add() return void. (Matthias)
* Change mutex_init to mutex_lock in icc_provider_add(). (Matthias)
* Add new icc_node_del() function to delete nodes from provider.
* Fix the header guard to reflect the path in smd-rpm.h. (Evan)
* Check for errors returned by qcom_icc_rpm_smd_send(). (Evan)
* Propagate the error of icc_provider_del(). (Evan)

Changes since patchset v4 (https://lkml.org/lkml/2018/3/9/856)
* Simplified locking by using a single global mutex. (Evan)
* Changed the aggregation function interface.
* Implemented functions for node, link, provider removal. (Evan)
* Naming changes on variables and functions, removed redundant code. (Evan)
* Fixes and clarifications in the docs. (Matthias, Evan, Amit, Alexandre)
* Removed mandatory reg DT property, made interconnect-names optional. (Bjorn)
* Made interconnect-cells property required to align with other bindings. (Neil)
* Moved msm8916 specific bindings into a separate file and patch. (Bjorn)
* Use the names, instead of the hardcoded ids for topology. (Matthias)
* Init the node before creating the links. (Evan)
* Added icc_units_to_bps macro. (Amit)

Changes since patchset v3 (https://lkml.org/lkml/2017/9/8/544)
* Refactored the constraints aggregation.
* Use the IDR API.
* Split the provider and consumer bindings into separate patches and propose
  new bindings for consumers, which allows to specify the local source port.
* Adopted the icc_ prefix for API functions.
* Introduced separate API functions for creating interconnect nodes and links.
* Added DT lookup support in addition to platform data.
* Dropped the event tracing patch for now.
* Added a patch to provide summary via debugfs.
* Use macro for the list of topology definitions in the platform driver.
* Various minor changes.

Changes since patchset v2 (https://lkml.org/lkml/2017/7/20/825)
* Split the aggregation into per node and per provider. Cache the
  aggregated values.
* Various small refactorings and cleanups in the framework.
* Added a patch introducing basic tracepoint support for monitoring
  the time required to update the interconnect nodes.

Changes since patchset v1 (https://lkml.org/lkml/2017/6/27/890)
* Updates in the documentation.
* Changes in request aggregation, locking.
* Dropped the aggregate() callback and use the default as it currently
  sufficient for the single vendor driver. Will add it later when needed.
* Dropped the dt-bindings draft patch for now.

Changes since RFC v2 (https://lkml.org/lkml/2017/6/12/316)
* Converted documentation to rst format.
* Fixed an incorrect call to mutex_lock. Renamed max_bw to peak_bw.

Changes since RFC v1 (https://lkml.org/lkml/2017/5/15/605)
* Refactored code into shorter functions.
* Added a new aggregate() API function.
* Rearranged some structs to reduce padding bytes.

Changes since RFC v0 (https://lkml.org/lkml/2017/3/1/599)
* Removed DT support and added optional Patch 3 with new bindings proposal.
* Converted the topology into internal driver data.
* Made the framework modular.
* interconnect_get() now takes (src and dst ports as arguments).
* Removed public declarations of some structs.
* Now passing prev/next nodes to the vendor driver.
* Properly remove requests on _put().
* Added refcounting.
* Updated documentation.
* Changed struct interconnect_path to use array instead of linked list.

David Dai (2):
  interconnect: qcom: Add sdm845 interconnect provider driver
  arm64: dts: sdm845: Add interconnect provider DT nodes

Georgi Djakov (5):
  interconnect: Add generic on-chip interconnect API
  dt-bindings: Introduce interconnect binding
  interconnect: Allow endpoints translation via DT
  interconnect: Add debugfs support
  MAINTAINERS: add a maintainer for the interconnect API

 .../bindings/interconnect/interconnect.txt    |  60 ++
 .../bindings/interconnect/qcom,sdm845.txt     |  24 +
 Documentation/interconnect/interconnect.rst   |  94 ++
 MAINTAINERS                                   |  10 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |   5 +
 drivers/Kconfig                               |   2 +
 drivers/Makefile                              |   1 +
 drivers/interconnect/Kconfig                  |  15 +
 drivers/interconnect/Makefile                 |   6 +
 drivers/interconnect/core.c                   | 796 +++++++++++++++++
 drivers/interconnect/qcom/Kconfig             |  13 +
 drivers/interconnect/qcom/Makefile            |   5 +
 drivers/interconnect/qcom/sdm845.c            | 836 ++++++++++++++++++
 .../dt-bindings/interconnect/qcom,sdm845.h    | 143 +++
 include/linux/interconnect-provider.h         | 142 +++
 include/linux/interconnect.h                  |  58 ++
 16 files changed, 2210 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/interconnect.txt
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt
 create mode 100644 Documentation/interconnect/interconnect.rst
 create mode 100644 drivers/interconnect/Kconfig
 create mode 100644 drivers/interconnect/Makefile
 create mode 100644 drivers/interconnect/core.c
 create mode 100644 drivers/interconnect/qcom/Kconfig
 create mode 100644 drivers/interconnect/qcom/Makefile
 create mode 100644 drivers/interconnect/qcom/sdm845.c
 create mode 100644 include/dt-bindings/interconnect/qcom,sdm845.h
 create mode 100644 include/linux/interconnect-provider.h
 create mode 100644 include/linux/interconnect.h

