Return-Path: <georgi.djakov@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520629801; cv=none;
        d=google.com; s=arc-20160816;
        b=bm6zmbUfpihOmmtYqTiuTuoyLypyF0TA+JxpFkrSGXrp4lD/q/Tt2A/fziCKbx/U+E
         MYZaAobU9RXOGMU4Fj0xLfzyFBq137aStof28SsmbPcm/0sIIVGIPGnqnfRAPbx7lLt9
         EAZA8cyzfwW2LDtc36NpjPHgnQe4NqfWCg6ts7EbLsacTtAD6cv9hSwB4rAHjdcu3giB
         /UZc96H2coBMXZs3lx21TFH8VA+p8Mquje/ukqlnA2HU2Tp9kmr7ri8I5eSnvM98I2c6
         3bhggRONpPxqlUgDwOU04+C42m8piMF3aWCI5PXld7PDuamGpsGr60WNjn2/mupqMyzI
         fFEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=c2tTM+18yJuLazLFw8tp9zidIdNr8+QuQ2lRk4Q3kMw=;
        b=zWBWU1zqDz/TTiWTgYDZfjWH5zK9HmwwRTZmp1yfwhCerqLdNIRmHtMgN3lSHUzeXD
         jrbe6ySUgy4aROSIvaYUxCV4xGfhntOPIUQcsB7lNnFPbIg7fR7EBVkSSwMQl3FJyKsD
         QWhh4la0Rrx6ytN2jmVzo6TKF61Q2DpT6PraQ8gn9gnarKEMMZLVHIN/WDnrBRZjh3v0
         2Yx9Qe0YO8tXDQ0RXH4kZbSGRMPXGBNIajprYnRChXllGzGdW510MVFG5r4snG4Sz/Qp
         ZJgOsh5/lYyS7oBMszc6uD/xunc+raq0w+OqpRdsxsLLXoLzXvhbPyBxyjlEoT4Epdhr
         4PDw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=ItiOOHGY;
       spf=pass (google.com: domain of georgi.djakov@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=georgi.djakov@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=ItiOOHGY;
       spf=pass (google.com: domain of georgi.djakov@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=georgi.djakov@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELuxujfPsV3WAhMJeSg9MKi1EhoattHJGU2ldxuyhoEt8HlXYFa8MCu1+p8Yr124qtWyy43feA==
From: Georgi Djakov <georgi.djakov@linaro.org>
To: linux-pm@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: rjw@rjwysocki.net,
	robh+dt@kernel.org,
	mturquette@baylibre.com,
	khilman@baylibre.com,
	vincent.guittot@linaro.org,
	skannan@codeaurora.org,
	bjorn.andersson@linaro.org,
	amit.kucheria@linaro.org,
	seansw@qti.qualcomm.com,
	davidai@quicinc.com,
	mark.rutland@arm.com,
	lorenzo.pieralisi@arm.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	georgi.djakov@linaro.org
Subject: [PATCH v4 0/7] Introduce on-chip interconnect API
Date: Fri,  9 Mar 2018 23:09:51 +0200
Message-Id: <20180309210958.16672-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.16.2
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594495914539180835?=
X-GMAIL-MSGID: =?utf-8?q?1594495914539180835?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Modern SoCs have multiple processors and various dedicated cores (video, gpu,
graphics, modem). These cores are talking to each other and can generate a lot
of data flowing through the on-chip interconnects. These interconnect buses
could form different topologies such as crossbar, point to point buses,
hierarchical buses or use the network-on-chip concept.

These buses have been sized usually to handle use cases with high data
throughput but it is not necessary all the time and consume a lot of power.
Furthermore, the priority between masters can vary depending on the running
use case like video playback or cpu intensive tasks.

Having an API to control the requirement of the system in term of bandwidth
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
 * Create icc_set_extended() to handle parameters such as latency and other QoS
   values.
 * Convert from using global node identifiers to local per provider identifiers.
 * Cache the path between the nodes instead of walking the graph on each get().
 * Sync interconnect requests with the idle state of the device.

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

Georgi Djakov (7):
  interconnect: Add generic on-chip interconnect API
  dt-bindings: Introduce interconnect provider bindings
  interconnect: Add debugfs support
  interconnect: qcom: Add RPM communication
  interconnect: qcom: Add msm8916 interconnect provider driver
  dt-bindings: Introduce interconnect consumers bindings
  interconnect: Allow endpoints translation via DT

 .../bindings/interconnect/interconnect.txt         |  70 +++
 .../devicetree/bindings/interconnect/qcom-smd.txt  |  31 ++
 Documentation/interconnect/interconnect.rst        |  96 ++++
 drivers/Kconfig                                    |   2 +
 drivers/Makefile                                   |   1 +
 drivers/interconnect/Kconfig                       |  15 +
 drivers/interconnect/Makefile                      |   2 +
 drivers/interconnect/core.c                        | 597 +++++++++++++++++++++
 drivers/interconnect/qcom/Kconfig                  |  11 +
 drivers/interconnect/qcom/Makefile                 |   3 +
 drivers/interconnect/qcom/msm8916.c                | 482 +++++++++++++++++
 drivers/interconnect/qcom/smd-rpm.c                |  90 ++++
 drivers/interconnect/qcom/smd-rpm.h                |  15 +
 include/linux/interconnect-provider.h              | 109 ++++
 include/linux/interconnect.h                       |  46 ++
 include/linux/interconnect/qcom.h                  | 350 ++++++++++++
 16 files changed, 1920 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/interconnect.txt
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
 create mode 100644 include/linux/interconnect-provider.h
 create mode 100644 include/linux/interconnect.h
 create mode 100644 include/linux/interconnect/qcom.h
