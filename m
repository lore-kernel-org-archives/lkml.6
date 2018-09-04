Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84ACC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6321E20867
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="RkFKZBYm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EdDM8mhg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6321E20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbeIDOs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 10:48:57 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:46539 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbeIDOs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 10:48:56 -0400
Received: by mail-oi0-f67.google.com with SMTP id y207-v6so5632443oie.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 03:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=U/UbSxqbodxB961RkopwHB03bM+eMFBzFvTzmJy4XOM=;
        b=RkFKZBYmLttcPdFMU4Hp/7uZOFMMnYss2lyCWbiXqUyMHc30eldBKE9viWH8zyo8NK
         kGC2WzCUeEVLAuOmY9iTooXZG8wE8tgVlRcwAfqNv8GPbFXY7cV8Ze0G0409ZWnW9fmE
         8rt8Z17Q+UAK2Z1gLMdtuioppQ8NVZeVZ1OGD3eI5B7/4/2z6VnXOE2dZ7ds7w80ztGv
         ipqEGOHF41t2GICsmrcdJRjxM1CeIBK0l16YNgUn8EJLK8ecgHGUiyQV4k5VD4zQ7YpH
         5oINYlOHo2oabtVXVfIHwpUH9z5E+HhEa5sFvLWus3GC20NqpQGkw6N4RS4VUbUZTT6o
         YVew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=U/UbSxqbodxB961RkopwHB03bM+eMFBzFvTzmJy4XOM=;
        b=EdDM8mhg648C71skjEbRwRnNJ/SEYreJ3d3PI/bKP3sJ847sgJUwxfot3cDXp3LRUh
         Jk/7oflw5xkVRc8B/HtqBX5KkL0gNQZl7rfi9eaXGD0dX/Q7s7Ga9mUWh/C+NjvIVNm0
         xw3WYptN5lPJfwiVnRDvGWDrH5Vsx1yoRyeZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=U/UbSxqbodxB961RkopwHB03bM+eMFBzFvTzmJy4XOM=;
        b=LMlmVGWP+Vy/ja8FD+dNgW7R3d8NrHKPc9zv0lCfGdtn8h4f0wP8fAR9UK1ArwBZXP
         EIOGoc+saoZwA22fYAS+ahVvAit9BEom5fzChuPHhXxuLUfR3oW6+AEeoC4HKw/HSyIU
         cOgHWDcoPoP5fvhHGZrFk0i32zUPaq2az6Z1pcLtgdavJlgDA3VMTed6fp1u44QypsKD
         ODLkibpe7phh0q6upq5Vb9znjGO0ljhzqPpMU9+n6yClPjN2y6/w3yjAZjMH1QNS0OUm
         eJs4BU+WoVd+0vO2BK0LK1BEIKi3sfpsPcovyZtojjchMFedQ2J2jcJlOy9VnnNMnKdg
         rCZQ==
X-Gm-Message-State: APzg51AIjQOFcMDkANll/BxaZWWwTV7LkZV81Q8hwBx1tK2PeGTuxbSe
        uvLo17UINdY/B8sqloiWX2vHsp7oRi8TqpcB4NE0DA==
X-Google-Smtp-Source: ANB0VdawgbGcNKiMGuqhl2lRlu+MctbrD1mqLGGnsk4cQy1CSN1BLzGo0FYvd5z7ZBq3Zioq/ziegIPr/JUVfqscKgE=
X-Received: by 2002:aca:d605:: with SMTP id n5-v6mr9520751oig.287.1536056667983;
 Tue, 04 Sep 2018 03:24:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:1315:0:0:0:0:0 with HTTP; Tue, 4 Sep 2018 03:24:27 -0700 (PDT)
In-Reply-To: <20180831140151.13972-1-georgi.djakov@linaro.org>
References: <20180831140151.13972-1-georgi.djakov@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Tue, 4 Sep 2018 15:54:27 +0530
X-Google-Sender-Auth: 21ZpTlGq8YBSXe0Wtz9EyQ-op2g
Message-ID: <CAHLCerNd0hrLKgbni95_RSYOtsNufMCVtHbAKa4W+eo8H2cL2A@mail.gmail.com>
Subject: Re: [PATCH v9 0/8] Introduce on-chip interconnect API
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        gregkh@linuxfoundation.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        khilman@baylibre.com, Vincent Guittot <vincent.guittot@linaro.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        evgreen@chromium.org, Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        abailon@baylibre.com, maxime.ripard@bootlin.com,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Georgi,

I'm currently reviewing this patchset (long overdue), but considering
that we haven't added any major new features to the framework for the
last couple of revisions, can you get this patchset merged into
linux-next to see how things shake out there? We've had this merged
branch merged into a CI build on kernelci for a while now w/o any
major incident so we should increase its exposure.

You could ask Stephen Rothwell if he'll accept the a branch directly
from you or he needs an upstream maintainer (GregKH?) to carry it.

Regard,
Amit

On Fri, Aug 31, 2018 at 7:31 PM, Georgi Djakov <georgi.djakov@linaro.org> wrote:
> Modern SoCs have multiple processors and various dedicated cores (video, gpu,
> graphics, modem). These cores are talking to each other and can generate a
> lot of data flowing through the on-chip interconnects. These interconnect
> buses could form different topologies such as crossbar, point to point buses,
> hierarchical buses or use the network-on-chip concept.
>
> These buses have been sized usually to handle use cases with high data
> throughput but it is not necessary all the time and consume a lot of power.
> Furthermore, the priority between masters can vary depending on the running
> use case like video playback or CPU intensive tasks.
>
> Having an API to control the requirement of the system in terms of bandwidth
> and QoS, so we can adapt the interconnect configuration to match those by
> scaling the frequencies, setting link priority and tuning QoS parameters.
> This configuration can be a static, one-time operation done at boot for some
> platforms or a dynamic set of operations that happen at run-time.
>
> This patchset introduce a new API to get the requirement and configure the
> interconnect buses across the entire chipset to fit with the current demand.
> The API is NOT for changing the performance of the endpoint devices, but only
> the interconnect path in between them.
>
> The API is using a consumer/provider-based model, where the providers are
> the interconnect buses and the consumers could be various drivers.
> The consumers request interconnect resources (path) to an endpoint and set
> the desired constraints on this data flow path. The provider(s) receive
> requests from consumers and aggregate these requests for all master-slave
> pairs on that path. Then the providers configure each participating in the
> topology node according to the requested data flow path, physical links and
> constraints. The topology could be complicated and multi-tiered and is SoC
> specific.
>
> Below is a simplified diagram of a real-world SoC topology. The interconnect
> providers are the NoCs.
>
> +----------------+    +----------------+
> | HW Accelerator |--->|      M NoC     |<---------------+
> +----------------+    +----------------+                |
>                         |      |                    +------------+
>  +-----+  +-------------+      V       +------+     |            |
>  | DDR |  |                +--------+  | PCIe |     |            |
>  +-----+  |                | Slaves |  +------+     |            |
>    ^ ^    |                +--------+     |         |   C NoC    |
>    | |    V                               V         |            |
> +------------------+   +------------------------+   |            |   +-----+
> |                  |-->|                        |-->|            |-->| CPU |
> |                  |-->|                        |<--|            |   +-----+
> |     Mem NoC      |   |         S NoC          |   +------------+
> |                  |<--|                        |---------+    |
> |                  |<--|                        |<------+ |    |   +--------+
> +------------------+   +------------------------+       | |    +-->| Slaves |
>   ^  ^    ^    ^          ^                             | |        +--------+
>   |  |    |    |          |                             | V
> +------+  |  +-----+   +-----+  +---------+   +----------------+   +--------+
> | CPUs |  |  | GPU |   | DSP |  | Masters |-->|       P NoC    |-->| Slaves |
> +------+  |  +-----+   +-----+  +---------+   +----------------+   +--------+
>           |
>       +-------+
>       | Modem |
>       +-------+
>
> TODO:
> * Create icc_set_extended() to handle parameters such as latency and other
>   QoS values.
> * Convert from using global node identifiers to local per provider ids.
> * Cache the path between the nodes instead of walking the graph on each get().
> * Sync interconnect requests with the idle state of the device.
>
> Changes since patchset v8 (https://lkml.org/lkml/2018/8/10/387)
> * Fixed the names of the files when built as modules.
> * Corrected some typos in comments.
>
> Changes since patchset v7 (https://lkml.org/lkml/2018/7/31/647)
> * Addressed comments on kernel-doc and grammar. (Randy)
> * Picked Reviewed-by: Evan
> * Squashed consumer and provider DT bindings into single patch. (Rob)
> * Cleaned-up msm8916 DT bindings docs by removing unused port ids.
> * Updated documentation for the cases when NULL is returned. (Saravana)
> * New patch to add myself as maintainer.
>
> Changes since patchset v6 (https://lkml.org/lkml/2018/7/9/698)
> * [patches 1,6]: Move the aggregation within the provider from the framework to
>   the platform driver's set() callback, as the aggregation point could be SoC
>   specific.
> * [patch 1]: Include missing header, reset state only of the traversed nodes,
>   move more code into path_init(), add more asserts, move misplaced mutex,
>   simplify icc_link_destroy() (Evan)
> * [patch 1]: Fix the order of requests to go from source to destination. (Alex)
> * [patch 7]: Use better wording in the documentation. (Evan)
> * [patch 6]: Reorder struct members, sort nodes alphabetically, improve naming
>   of variables , add missing clk_disable_unprepare() in error paths. (Matthias)
> * [patch 6]: Remove redundant NULL pointer check in msm8916 driver. (Alex)
> * [patch 6]: Add missing depend on QCOM_SMD_RPM in Kconfig. (Evan)
> * [patch 3]: Don't check for errors on debugfs calls, remove debugfs directory
>   when module is unloaded (Greg)
>
> Changes since patchset v5 (https://lkml.org/lkml/2018/6/20/453)
> * Fix the modular build, make rpm-smd driver a module.
> * Optimize locking and move to higher level. (Evan)
> * Code cleanups. Fix typos. (Evan, Matthias)
> * Add the source node to the path. (Evan)
> * Rename path_allocate() to path_init() with minor refactoring. (Evan)
> * Rename *_remove() functions to *_destroy().
> * Return fixed errors in icc_link_destroy(). (Evan)
> * Fix krealloc() usage in icc_link_destroy(). (Evan)
> * Add missing kfree() in icc_node_create(). (Matthias)
> * Make icc_node_add() return void. (Matthias)
> * Change mutex_init to mutex_lock in icc_provider_add(). (Matthias)
> * Add new icc_node_del() function to delete nodes from provider.
> * Fix the header guard to reflect the path in smd-rpm.h. (Evan)
> * Check for errors returned by qcom_icc_rpm_smd_send(). (Evan)
> * Propagate the error of icc_provider_del(). (Evan)
>
> Changes since patchset v4 (https://lkml.org/lkml/2018/3/9/856)
> * Simplified locking by using a single global mutex. (Evan)
> * Changed the aggregation function interface.
> * Implemented functions for node, link, provider removal. (Evan)
> * Naming changes on variables and functions, removed redundant code. (Evan)
> * Fixes and clarifications in the docs. (Matthias, Evan, Amit, Alexandre)
> * Removed mandatory reg DT property, made interconnect-names optional. (Bjorn)
> * Made interconnect-cells property required to align with other bindings. (Neil)
> * Moved msm8916 specific bindings into a separate file and patch. (Bjorn)
> * Use the names, instead of the hardcoded ids for topology. (Matthias)
> * Init the node before creating the links. (Evan)
> * Added icc_units_to_bps macro. (Amit)
>
> Changes since patchset v3 (https://lkml.org/lkml/2017/9/8/544)
> * Refactored the constraints aggregation.
> * Use the IDR API.
> * Split the provider and consumer bindings into separate patches and propose
>   new bindings for consumers, which allows to specify the local source port.
> * Adopted the icc_ prefix for API functions.
> * Introduced separate API functions for creating interconnect nodes and links.
> * Added DT lookup support in addition to platform data.
> * Dropped the event tracing patch for now.
> * Added a patch to provide summary via debugfs.
> * Use macro for the list of topology definitions in the platform driver.
> * Various minor changes.
>
> Changes since patchset v2 (https://lkml.org/lkml/2017/7/20/825)
> * Split the aggregation into per node and per provider. Cache the
>   aggregated values.
> * Various small refactorings and cleanups in the framework.
> * Added a patch introducing basic tracepoint support for monitoring
>   the time required to update the interconnect nodes.
>
> Changes since patchset v1 (https://lkml.org/lkml/2017/6/27/890)
> * Updates in the documentation.
> * Changes in request aggregation, locking.
> * Dropped the aggregate() callback and use the default as it currently
>   sufficient for the single vendor driver. Will add it later when needed.
> * Dropped the dt-bindings draft patch for now.
>
> Changes since RFC v2 (https://lkml.org/lkml/2017/6/12/316)
> * Converted documentation to rst format.
> * Fixed an incorrect call to mutex_lock. Renamed max_bw to peak_bw.
>
> Changes since RFC v1 (https://lkml.org/lkml/2017/5/15/605)
> * Refactored code into shorter functions.
> * Added a new aggregate() API function.
> * Rearranged some structs to reduce padding bytes.
>
> Changes since RFC v0 (https://lkml.org/lkml/2017/3/1/599)
> * Removed DT support and added optional Patch 3 with new bindings proposal.
> * Converted the topology into internal driver data.
> * Made the framework modular.
> * interconnect_get() now takes (src and dst ports as arguments).
> * Removed public declarations of some structs.
> * Now passing prev/next nodes to the vendor driver.
> * Properly remove requests on _put().
> * Added refcounting.
> * Updated documentation.
> * Changed struct interconnect_path to use array instead of linked list.
>
> Georgi Djakov (8):
>   interconnect: Add generic on-chip interconnect API
>   dt-bindings: Introduce interconnect binding
>   interconnect: Allow endpoints translation via DT
>   interconnect: Add debugfs support
>   interconnect: qcom: Add RPM communication
>   dt-bindings: interconnect: Document qcom,msm8916 NoC bindings
>   interconnect: qcom: Add msm8916 interconnect provider driver
>   MAINTAINERS: add a maintainer for the interconnect API
>
>  .../bindings/interconnect/interconnect.txt    |  60 ++
>  .../bindings/interconnect/qcom-msm8916.txt    |  41 +
>  .../bindings/interconnect/qcom-smd.txt        |  32 +
>  Documentation/interconnect/interconnect.rst   |  94 +++
>  MAINTAINERS                                   |  10 +
>  drivers/Kconfig                               |   2 +
>  drivers/Makefile                              |   1 +
>  drivers/interconnect/Kconfig                  |  15 +
>  drivers/interconnect/Makefile                 |   6 +
>  drivers/interconnect/core.c                   | 729 ++++++++++++++++++
>  drivers/interconnect/qcom/Kconfig             |  22 +
>  drivers/interconnect/qcom/Makefile            |   7 +
>  drivers/interconnect/qcom/msm8916.c           | 510 ++++++++++++
>  drivers/interconnect/qcom/smd-rpm.c           |  91 +++
>  drivers/interconnect/qcom/smd-rpm.h           |  15 +
>  include/dt-bindings/interconnect/qcom.h       |  98 +++
>  include/linux/interconnect-provider.h         | 125 +++
>  include/linux/interconnect.h                  |  49 ++
>  18 files changed, 1907 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/interconnect.txt
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom-msm8916.txt
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom-smd.txt
>  create mode 100644 Documentation/interconnect/interconnect.rst
>  create mode 100644 drivers/interconnect/Kconfig
>  create mode 100644 drivers/interconnect/Makefile
>  create mode 100644 drivers/interconnect/core.c
>  create mode 100644 drivers/interconnect/qcom/Kconfig
>  create mode 100644 drivers/interconnect/qcom/Makefile
>  create mode 100644 drivers/interconnect/qcom/msm8916.c
>  create mode 100644 drivers/interconnect/qcom/smd-rpm.c
>  create mode 100644 drivers/interconnect/qcom/smd-rpm.h
>  create mode 100644 include/dt-bindings/interconnect/qcom.h
>  create mode 100644 include/linux/interconnect-provider.h
>  create mode 100644 include/linux/interconnect.h
>
