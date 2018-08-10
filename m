Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803AFC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 14:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17AEF223C6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 14:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ion807qy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17AEF223C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbeHJRW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 13:22:57 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54860 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727763AbeHJRW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 13:22:57 -0400
Received: by mail-wm0-f65.google.com with SMTP id c14-v6so2207894wmb.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 07:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=gtrw+r2QgrpuvSYudNNz/TSyycolmy5RRbrX57S87eU=;
        b=Ion807qye1morfD85wKX4tdMP1F8ZhXEse7JYWtWPBWRmoVOL6pefBiZKYbNwyjtcI
         bj+29Vc49IESBDlklaTyXVDNCP63MZQmTdcmXeHUMqx/qeSy7QM22qPwwFw1nctXJBpM
         RALWUVf0p/g3IhMlfnhEtdYRy4R9BEMF+MGQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gtrw+r2QgrpuvSYudNNz/TSyycolmy5RRbrX57S87eU=;
        b=Iybik6xMckIILbQZBEmhCmXzP5lr5k/2s/BC0PVtKjS+twYaW5AhsduFJe9hv1rirG
         K/89qbi+P/c5E23wP+qDyMWJCHA3AF34aS4ElY+tZn9YJhmf8RNMw+M2shEfQjL1euIs
         Wozh4I91wg5ilfEJ5t0AQ/hlzv8n0Drllp5dKP3IPdfYivSDgHhyQcluO7UTd3nqdRYd
         aAFbfdAyM9PTBFXheXjd0LW/Fanaa1HYEksoQG1FioNo6JKcKeUNGy6eo/5B0T33gd2J
         41wb3YHCSyvESrFQ2KvcRTcUdyzW+OV5H+TbSvUymgoZLimfnXi/w8Fh8uCsd3BGNczR
         Ox4w==
X-Gm-Message-State: AOUpUlE8RfmGUYgoLd0Je/mO5TPdA4YR0x0wGApoe7P9VqY22CpsOnUV
        i0f3sEsJWR0L7Z7g2r5KiXf8ww==
X-Google-Smtp-Source: AA+uWPwFCO2B4R4Z2bwQ4aIOCCimKdYPLYKwY2WKD9B9Bzm536mQdwvK1ZXzKPN1ugKFnojypmbSVg==
X-Received: by 2002:a1c:4d16:: with SMTP id o22-v6mr1662968wmh.49.1533912762102;
        Fri, 10 Aug 2018 07:52:42 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id 9-v6sm19842700wrb.48.2018.08.10.07.52.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Aug 2018 07:52:35 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com,
        khilman@baylibre.com, vincent.guittot@linaro.org,
        skannan@codeaurora.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        abailon@baylibre.com, arnd@arndb.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH v8 0/8] Introduce on-chip interconnect API
Date:   Fri, 10 Aug 2018 17:52:25 +0300
Message-Id: <20180810145233.16466-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.18.0
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
  QoS values.
* Convert from using global node identifiers to local per provider ids.
* Cache the path between the nodes instead of walking the graph on each get().
* Sync interconnect requests with the idle state of the device.

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

Georgi Djakov (8):
  interconnect: Add generic on-chip interconnect API
  dt-bindings: Introduce interconnect binding
  interconnect: Allow endpoints translation via DT
  interconnect: Add debugfs support
  interconnect: qcom: Add RPM communication
  dt-bindings: interconnect: Document qcom,msm8916 NoC bindings
  interconnect: qcom: Add msm8916 interconnect provider driver
  MAINTAINERS: add a maintainer for the interconnect API

 .../bindings/interconnect/interconnect.txt    |  60 ++
 .../bindings/interconnect/qcom-msm8916.txt    |  41 +
 .../bindings/interconnect/qcom-smd.txt        |  32 +
 Documentation/interconnect/interconnect.rst   |  94 +++
 MAINTAINERS                                   |  10 +
 drivers/Kconfig                               |   2 +
 drivers/Makefile                              |   1 +
 drivers/interconnect/Kconfig                  |  15 +
 drivers/interconnect/Makefile                 |   3 +
 drivers/interconnect/core.c                   | 729 ++++++++++++++++++
 drivers/interconnect/qcom/Kconfig             |  23 +
 drivers/interconnect/qcom/Makefile            |   4 +
 drivers/interconnect/qcom/msm8916.c           | 510 ++++++++++++
 drivers/interconnect/qcom/smd-rpm.c           |  91 +++
 drivers/interconnect/qcom/smd-rpm.h           |  16 +
 include/dt-bindings/interconnect/qcom.h       |  98 +++
 include/linux/interconnect-provider.h         | 125 +++
 include/linux/interconnect.h                  |  49 ++
 18 files changed, 1903 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/interconnect.txt
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom-msm8916.txt
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom-smd.txt
 create mode 100644 Documentation/interconnect/interconnect.rst
 create mode 100644 drivers/interconnect/Kconfig
 create mode 100644 drivers/interconnect/Makefile
 create mode 100644 drivers/interconnect/core.c
 create mode 100644 drivers/interconnect/qcom/Kconfig
 create mode 100644 drivers/interconnect/qcom/Makefile
 create mode 100644 drivers/interconnect/qcom/msm8916.c
 create mode 100644 drivers/interconnect/qcom/smd-rpm.c
 create mode 100644 drivers/interconnect/qcom/smd-rpm.h
 create mode 100644 include/dt-bindings/interconnect/qcom.h
 create mode 100644 include/linux/interconnect-provider.h
 create mode 100644 include/linux/interconnect.h

