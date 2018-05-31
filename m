Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755536AbeEaPge (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 11:36:34 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34781 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755421AbeEaPg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 11:36:27 -0400
X-Google-Smtp-Source: ADUXVKL4YOMAckFCPMnIa13BhfVBLamc3fR5Xqc04RHoG6LCMbyLZgdVjtqcsrfHPeRoOG05u4U9ZxN58CLUTIUrmtk=
MIME-Version: 1.0
In-Reply-To: <1527599737-28408-1-git-send-email-suzuki.poulose@arm.com>
References: <1527599737-28408-1-git-send-email-suzuki.poulose@arm.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Thu, 31 May 2018 09:36:25 -0600
Message-ID: <CANLsYkxStH5R0_8WFF1oe=PCCFr4Ko+0J+Xhn-wzopFFDgrRCw@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] coresight: tmc-etr Transparent buffer management
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>, coresight@lists.linaro.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 May 2018 at 07:15, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> This series is split of the Coresight ETR perf support patches posted
> here [0]. The CATU support and perf backend support will be posted as
> separate series for better management and review of the patches.
>
> This series adds the support for TMC ETR Scatter-Gather mode to allow
> using physical non-contiguous buffer for holding the trace data. It
> also adds a layer to handle the buffer management in a transparent
> manner, independent of the underlying mode used by the TMC ETR.
> The layer chooses the ETR mode based on different parameters (size,
> re-using a set of pages, presence of an SMMU etc.).
>
> Finally we add a sysfs parameter to tune the buffer size for ETR in
> sysfs-mode.
>
> During the testing, we found out that if the TMC ETR is not properly
> connected to the memory subsystem, the ETR could lock-up the system
> while waiting for the "read" transactions to complete in scatter-gather
> mode. So, we do not use the mode on a system unless it is safe to do
> so. This is specified by a DT property "arm,scatter-gather".
>
> Applies on coreisght-next tree from Mathieu
>
> Changes since previous version [1]:
>  - Rebased to Mathieu's coresight-next tree to resolve a conflict.
>  - Added tags for DT changes from Rob and Mathieu
>  - Split the SG mode backend support patch from the
>    ETR-BUF patch.
>  - Address other comments from Mathieu
>
> Changes since splitted series [0] :
>  - Split the series in [0]
>  - Address comments on v2
>  - Rename DT property "scatter-gather" to "arm,scatter-gather"
>  - Add ETM PID for Cortex-A35, use macros to make the listing easier
>
> [0] - http://lists.infradead.org/pipermail/linux-arm-kernel/2018-May/574875.html
> [1] - http://lists.infradead.org/pipermail/linux-arm-kernel/2018-May/579135.html
>
> Suzuki K Poulose (12):
>   coresight: ETM: Add support for Arm Cortex-A73 and Cortex-A35
>   coresight: tmc: Hide trace buffer handling for file read
>   coresight: tmc-etr: Do not clean trace buffer
>   coresight: tmc-etr: Disallow perf mode
>   coresight: Add helper for inserting synchronization packets
>   dts: bindings: Restrict coresight tmc-etr scatter-gather mode
>   dts: juno: Add scatter-gather support for all revisions
>   coresight: Add generic TMC sg table framework
>   coresight: Add support for TMC ETR SG unit
>   coresight: tmc-etr: Add transparent buffer management
>   coresight: tmc-etr buf: Add TMC scatter gather mode backend
>   coresight: tmc: Add configuration support for trace buffer size
>
>  .../ABI/testing/sysfs-bus-coresight-devices-tmc    |    8 +
>  .../devicetree/bindings/arm/coresight.txt          |    5 +-
>  arch/arm64/boot/dts/arm/juno-base.dtsi             |    1 +
>  drivers/hwtracing/coresight/coresight-etb10.c      |   12 +-
>  drivers/hwtracing/coresight/coresight-etm4x.c      |   31 +-
>  drivers/hwtracing/coresight/coresight-priv.h       |   10 +-
>  drivers/hwtracing/coresight/coresight-tmc-etf.c    |   45 +-
>  drivers/hwtracing/coresight/coresight-tmc-etr.c    | 1010 ++++++++++++++++++--
>  drivers/hwtracing/coresight/coresight-tmc.c        |   83 +-
>  drivers/hwtracing/coresight/coresight-tmc.h        |  110 ++-
>  drivers/hwtracing/coresight/coresight.c            |    3 +-
>  11 files changed, 1144 insertions(+), 174 deletions(-)

Applied after correcting indentation problems and rectifying the
kernel version and date in "sysfs-bus-coresight-devices-tmc".

Mathieu

>
> --
> 2.7.4
>
