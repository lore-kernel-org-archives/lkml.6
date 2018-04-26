Return-Path: <ard.biesheuvel@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524729438; cv=none;
        d=google.com; s=arc-20160816;
        b=uqq0W4yDJ4D1CSb/79f7mmlS7xLILzgKI5hRy4a4iwAP2CvrvfPx/ExRQEBAiJFGow
         h0rkhIkDt55lj5yc2zPI4JF297dsILjax82ryNh5/abfubF9EFRxNenYdYAe1hmRmaON
         plaGNVEZNor6q2hWEm8kUhVFxWaT2m6nKe0AEonI8Rdbbrh4Q+1stpZg2XVoS3vlfsgW
         Kkdnn4uyyYq9OU0M9GyK3x2gcRBoq0bfdUul/S5F4mezG4rqbd8n81aDT8mup68S7xON
         2Dsv05+4xmCn4d/q5QVLznkS788uTmq+zzN6QYrMJyIQmkBbRUdyp+OQ0yzsecensW09
         qWGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=pZ95vXiyTXG20Rq1b53VPjlDcLpPEAm6M8zh2NEUino=;
        b=EwM/pa+FeBVBuHQQVvYUztyMwvgTl8CatnBpld1t4LCEJv7fUDhSjrDT4Zsb1d7kox
         eIySxiu4XBgkBJFr2T6l9iaNVzZf6qvW6aZnse5bHtXFq2ikhmZ+e9YDMF+jTkCMU+EV
         d9YNm20DFVfTTmzsORhbj1+lBjXoT3atpinKarIjRXGN5XUQ7UeVmJuxPIaQ+DdCk8Ex
         RLf6z8g5AH3AqEbpFB5oIVGevX2SPlegge6PMuqTepw6Wq263zFZLzvFAmMuJ1Zo+Qu6
         qspdKKiQmlqncUNDAJpEguHcGzfqLUpnPYkJhQMoJez5z8yO9NvbnkFyv/fhjMd4s2tg
         /HuQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=GCvxK0UB;
       spf=pass (google.com: domain of ard.biesheuvel@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ard.biesheuvel@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=GCvxK0UB;
       spf=pass (google.com: domain of ard.biesheuvel@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ard.biesheuvel@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZp6X5iEIaAoz91GKziNxSF2K4uVj/oDdrGsMgayomFb6AmHCNDKH0g2nNsDDOHJXWb7WYGBMBRqzge0RRdy/Rs=
MIME-Version: 1.0
In-Reply-To: <20180425233121.13270-1-jeremy.linton@arm.com>
References: <20180425233121.13270-1-jeremy.linton@arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 26 Apr 2018 09:57:17 +0200
Message-ID: <CAKv+Gu-_QN1rHmz_554ha2srAv=ZyB+syiVEzdQ280juo2NFwg@mail.gmail.com>
Subject: Re: [PATCH v8 00/13] Support PPTT for ARM64
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Sudeep Holla <Sudeep.Holla@arm.com>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <Will.Deacon@arm.com>,
	Catalin Marinas <Catalin.Marinas@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Rutland <Mark.Rutland@arm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-riscv@lists.infradead.org,
	wangxiongfeng2@huawei.com, vkilari@codeaurora.org, Al Stone <ahs3@redhat.com>,
	Dietmar.Eggemann@arm.com, Morten.Rasmussen@arm.com, palmer@sifive.com,
	Len Brown <lenb@kernel.org>, John Garry <john.garry@huawei.com>, austinwc@codeaurora.org,
	tnowicki@caviumnetworks.com, jhugo@qti.qualcomm.com, timur@qti.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598766310843839266?=
X-GMAIL-MSGID: =?utf-8?q?1598794695244619014?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 26 April 2018 at 01:31, Jeremy Linton <jeremy.linton@arm.com> wrote:
> ACPI 6.2 adds the Processor Properties Topology Table (PPTT), which is
> used to describe the processor and cache topology. Ideally it is
> used to extend/override information provided by the hardware, but
> right now ARM64 is entirely dependent on firmware provided tables.
>
> This patch parses the table for the cache topology and CPU topology.
> When we enable ACPI/PPTT for arm64 we map the package_id to the
> PPTT node flagged as the physical package by the firmware.
> This results in topologies that match what the remainder of the
> system expects. Finally, we update the scheduler MC domain so that
> it generally reflects the LLC unless the LLC is too large for the
> NUMA domain (or package).
>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org> # SynQuacer

Machine (7974MB)
  Package L#0 + L3 L#0 (4096KB)
    L2 L#0 (256KB)
      L1d L#0 (32KB) + L1i L#0 (32KB) + Core L#0 + PU L#0 (P#0)
      L1d L#1 (32KB) + L1i L#1 (32KB) + Core L#1 + PU L#1 (P#1)
    L2 L#1 (256KB)
      L1d L#2 (32KB) + L1i L#2 (32KB) + Core L#2 + PU L#2 (P#2)
      L1d L#3 (32KB) + L1i L#3 (32KB) + Core L#3 + PU L#3 (P#3)
    L2 L#2 (256KB)
      L1d L#4 (32KB) + L1i L#4 (32KB) + Core L#4 + PU L#4 (P#4)
      L1d L#5 (32KB) + L1i L#5 (32KB) + Core L#5 + PU L#5 (P#5)
    L2 L#3 (256KB)
      L1d L#6 (32KB) + L1i L#6 (32KB) + Core L#6 + PU L#6 (P#6)
      L1d L#7 (32KB) + L1i L#7 (32KB) + Core L#7 + PU L#7 (P#7)
    L2 L#4 (256KB)
      L1d L#8 (32KB) + L1i L#8 (32KB) + Core L#8 + PU L#8 (P#8)
      L1d L#9 (32KB) + L1i L#9 (32KB) + Core L#9 + PU L#9 (P#9)
    L2 L#5 (256KB)
      L1d L#10 (32KB) + L1i L#10 (32KB) + Core L#10 + PU L#10 (P#10)
      L1d L#11 (32KB) + L1i L#11 (32KB) + Core L#11 + PU L#11 (P#11)
    L2 L#6 (256KB)
      L1d L#12 (32KB) + L1i L#12 (32KB) + Core L#12 + PU L#12 (P#12)
      L1d L#13 (32KB) + L1i L#13 (32KB) + Core L#13 + PU L#13 (P#13)
    L2 L#7 (256KB)
      L1d L#14 (32KB) + L1i L#14 (32KB) + Core L#14 + PU L#14 (P#14)
      L1d L#15 (32KB) + L1i L#15 (32KB) + Core L#15 + PU L#15 (P#15)
    L2 L#8 (256KB)
      L1d L#16 (32KB) + L1i L#16 (32KB) + Core L#16 + PU L#16 (P#16)
      L1d L#17 (32KB) + L1i L#17 (32KB) + Core L#17 + PU L#17 (P#17)
    L2 L#9 (256KB)
      L1d L#18 (32KB) + L1i L#18 (32KB) + Core L#18 + PU L#18 (P#18)
      L1d L#19 (32KB) + L1i L#19 (32KB) + Core L#19 + PU L#19 (P#19)
    L2 L#10 (256KB)
      L1d L#20 (32KB) + L1i L#20 (32KB) + Core L#20 + PU L#20 (P#20)
      L1d L#21 (32KB) + L1i L#21 (32KB) + Core L#21 + PU L#21 (P#21)
    L2 L#11 (256KB)
      L1d L#22 (32KB) + L1i L#22 (32KB) + Core L#22 + PU L#22 (P#22)
      L1d L#23 (32KB) + L1i L#23 (32KB) + Core L#23 + PU L#23 (P#23)
  HostBridge L#0
    PCIBridge
      PCIBridge
        PCI 1b21:0612
          Block(Removable Media Device) L#0 "sr0"
          Block(Disk) L#1 "sda"
      PCIBridge
        PCI 168c:0032
          Net L#2 "wlp3s0"
  HostBridge L#4
    PCI 10de:128b
      GPU L#3 "renderD128"
      GPU L#4 "card0"
      GPU L#5 "controlD64"


> For example on juno:
> [root@mammon-juno-rh topology]# lstopo-no-graphics
>   Package L#0
>     L2 L#0 (1024KB)
>       L1d L#0 (32KB) + L1i L#0 (32KB) + Core L#0 + PU L#0 (P#0)
>       L1d L#1 (32KB) + L1i L#1 (32KB) + Core L#1 + PU L#1 (P#1)
>       L1d L#2 (32KB) + L1i L#2 (32KB) + Core L#2 + PU L#2 (P#2)
>       L1d L#3 (32KB) + L1i L#3 (32KB) + Core L#3 + PU L#3 (P#3)
>     L2 L#1 (2048KB)
>       L1d L#4 (32KB) + L1i L#4 (48KB) + Core L#4 + PU L#4 (P#4)
>       L1d L#5 (32KB) + L1i L#5 (48KB) + Core L#5 + PU L#5 (P#5)
>   HostBridge L#0
>     PCIBridge
>       PCIBridge
>         PCIBridge
>           PCI 1095:3132
>             Block(Disk) L#0 "sda"
>         PCIBridge
>           PCI 1002:68f9
>             GPU L#1 "renderD128"
>             GPU L#2 "card0"
>             GPU L#3 "controlD64"
>         PCIBridge
>           PCI 11ab:4380
>             Net L#4 "enp8s0"
>
> Git tree at:
> http://linux-arm.org/git?p=linux-jlinton.git
> branch: pptt_v8
>
> v7->v8:
> Modify the logic used to select the MC domain (the change
>   shouldn't modify the sched domains on any existing machines
>   compared to v7, only how they are built)
> Reduce the severity of some parsing messages.
> Fix s390 link problem.
> Further checks to deal with broken PPTT tables.
> Various style tweaks, SPDX license addition, etc.
>
> v6->v7:
> Add additional patch to use the last cache level within the NUMA
>   or socket as the MC domain. This assures the MC domain is
>   equal or smaller than the DIE.
>
> Various formatting/etc review comments.
>
> Rebase to 4.16rc2
>
> v5->v6:
> Add additional patches which re-factor how the initial DT code sets
>   up the cacheinfo structure so that its not as dependent on the
>   of_node stored in that tree. Once that is done we rename it
>   for use with the ACPI code.
>
> Additionally there were a fair number of minor name/location/etc
>   tweaks scattered about made in response to review comments.
>
> v4->v5:
> Update the cache type from NOCACHE to UNIFIED when all the cache
>   attributes we update are valid. This fixes a problem where caches
>   which are entirely created by the PPTT don't show up in lstopo.
>
> Give the PPTT its own firmware_node in the cache structure instead of
>   sharing it with the of_node.
>
> Move some pieces around between patches.
>
> (see previous cover letters for futher changes)
>
> Jeremy Linton (13):
>   drivers: base: cacheinfo: move cache_setup_of_node()
>   drivers: base: cacheinfo: setup DT cache properties early
>   cacheinfo: rename of_node to fw_token
>   arm64/acpi: Create arch specific cpu to acpi id helper
>   ACPI/PPTT: Add Processor Properties Topology Table parsing
>   ACPI: Enable PPTT support on ARM64
>   drivers: base cacheinfo: Add support for ACPI based firmware tables
>   arm64: Add support for ACPI based firmware tables
>   ACPI/PPTT: Add topology parsing code
>   arm64: topology: rename cluster_id
>   arm64: topology: enable ACPI/PPTT based CPU topology
>   ACPI: Add PPTT to injectable table list
>   arm64: topology: divorce MC scheduling domain from core_siblings
>
>  arch/arm64/Kconfig                |   1 +
>  arch/arm64/include/asm/acpi.h     |   4 +
>  arch/arm64/include/asm/topology.h |   6 +-
>  arch/arm64/kernel/cacheinfo.c     |  15 +-
>  arch/arm64/kernel/topology.c      | 103 +++++-
>  arch/riscv/kernel/cacheinfo.c     |   1 -
>  drivers/acpi/Kconfig              |   3 +
>  drivers/acpi/Makefile             |   1 +
>  drivers/acpi/pptt.c               | 678 ++++++++++++++++++++++++++++++++++++++
>  drivers/acpi/tables.c             |   2 +-
>  drivers/base/cacheinfo.c          | 157 ++++-----
>  include/linux/acpi.h              |   4 +
>  include/linux/cacheinfo.h         |  18 +-
>  13 files changed, 886 insertions(+), 107 deletions(-)
>  create mode 100644 drivers/acpi/pptt.c
>
> --
> 2.13.6
>
