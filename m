Return-Path: <jeremy.linton@arm.com>
X-Google-Smtp-Source: AG47ELu6uysp1UFqhE7mdnAwNqTj0AmuFHhpdXoXn3CxmYl3FXHW9zXAR69CSaRyqvTMu/IHmvhA
ARC-Seal: i=1; a=rsa-sha256; t=1519855627; cv=none;
        d=google.com; s=arc-20160816;
        b=moi4Ec+2FPTpnGgcnNsaS0cBzrSKKw3ZZmlMPYBwywgQQxUjq26D3hYzazGxR6fceb
         lxBLcxYQ1sy3uI/iyZO7ljJk4HRsaq8KPwuKaoFwA8C6M/GzoJen9D4iSRx+h+5hCGaI
         uDAiVNFJ9gs+pgxLZrh3dYnX9aMa3HHtpf5zPUI2jQyiQDPM0oMwSrGutfBWXQz4z+59
         hpOUYqTDSnP1kxfWAOjeDBbWfBcVmUL2bMcV7qROcNfEwKPLgzZomg1TfTBCMKiLRVdK
         KW6oSmHHI291MowBZnEBvbD2g8E1KEe1NnTq2ujFhzD3Oy6RLiD8olLoav0hIdeeDHMx
         vUOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=TJnHEQNpkjd/L7g8njlDYco5WwDCujQX0INM2z3/VPQ=;
        b=Xw9gAyzQV9QSw8VdVyxnFPgOgFUU/rspSOvdA8kWTHyVqdpIDdkMq6p32JHoqCQ9+a
         d774fobD7vUqoGi2a0EzqD4jJ5nq8Haqmfw4PFqlJAWWqtKXcwSA7Uj1SxrhPOMt1Xdu
         dq7anMUIGXZBBzmtsSEJiaFJl5TVyIzmWNPWcfvebzZ28pXDzSgcNWADb7hAq2H++NdK
         7RGRmcbxy54hQkZfUx0FECGscAQeZi2R7oCu4+IQ7VIfHSPeyh3vRvBk0c/kP4PADWrX
         lCWyRus3/aTb+FnS8PsT52FAs0TjWDrzxydGc22BAFLaJrokmy5NZKPxPRc4xa6C+ipW
         j3CA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jeremy.linton@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=jeremy.linton@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jeremy.linton@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=jeremy.linton@arm.com
From: Jeremy Linton <jeremy.linton@arm.com>
To: linux-acpi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	sudeep.holla@arm.com,
	lorenzo.pieralisi@arm.com,
	hanjun.guo@linaro.org,
	rjw@rjwysocki.net,
	will.deacon@arm.com,
	catalin.marinas@arm.com,
	gregkh@linuxfoundation.org,
	mark.rutland@arm.com,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	wangxiongfeng2@huawei.com,
	vkilari@codeaurora.org,
	ahs3@redhat.com,
	dietmar.eggemann@arm.com,
	morten.rasmussen@arm.com,
	palmer@sifive.com,
	lenb@kernel.org,
	john.garry@huawei.com,
	austinwc@codeaurora.org,
	tnowicki@caviumnetworks.com,
	Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v7 00/13] Support PPTT for ARM64
Date: Wed, 28 Feb 2018 16:06:06 -0600
Message-Id: <20180228220619.6992-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.13.6
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593684134324692162?=
X-GMAIL-MSGID: =?utf-8?q?1593684134324692162?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

ACPI 6.2 adds the Processor Properties Topology Table (PPTT), which is
used to describe the processor and cache topology. Ideally it is
used to extend/override information provided by the hardware, but
right now ARM64 is entirely dependent on firmware provided tables.

This patch parses the table for the cache topology and CPU topology.
When we enable ACPI/PPTT for arm64 we map the physical_id to the
PPTT node flagged as the physical package by the firmware.
This results in topologies that match what the remainder of the
system expects. To avoid inverted scheduler domains we then
set the MC domain equal to the largest cache within the socket
below the NUMA domain.

For example on juno:
[root@mammon-juno-rh topology]# lstopo-no-graphics
  Package L#0
    L2 L#0 (1024KB)
      L1d L#0 (32KB) + L1i L#0 (32KB) + Core L#0 + PU L#0 (P#0)
      L1d L#1 (32KB) + L1i L#1 (32KB) + Core L#1 + PU L#1 (P#1)
      L1d L#2 (32KB) + L1i L#2 (32KB) + Core L#2 + PU L#2 (P#2)
      L1d L#3 (32KB) + L1i L#3 (32KB) + Core L#3 + PU L#3 (P#3)
    L2 L#1 (2048KB)
      L1d L#4 (32KB) + L1i L#4 (48KB) + Core L#4 + PU L#4 (P#4)
      L1d L#5 (32KB) + L1i L#5 (48KB) + Core L#5 + PU L#5 (P#5)
  HostBridge L#0
    PCIBridge
      PCIBridge
        PCIBridge
          PCI 1095:3132
            Block(Disk) L#0 "sda"
        PCIBridge
          PCI 1002:68f9
            GPU L#1 "renderD128"
            GPU L#2 "card0"
            GPU L#3 "controlD64"
        PCIBridge
          PCI 11ab:4380
            Net L#4 "enp8s0"

Git tree at:
http://linux-arm.org/git?p=linux-jlinton.git
branch: pptt_v7

v6->v7:
Add additional patch to use the last cache level within the NUMA
  or socket as the MC domain. This assures the MC domain is
  equal or smaller than the DIE.
  
Various formatting/etc review comments.

Rebase to 4.16rc2

v5->v6:
Add additional patches which re-factor how the initial DT code sets
  up the cacheinfo structure so that its not as dependent on the
  of_node stored in that tree. Once that is done we rename it
  for use with the ACPI code.

Additionally there were a fair number of minor name/location/etc
  tweaks scattered about made in response to review comments.

v4->v5:
Update the cache type from NOCACHE to UNIFIED when all the cache
  attributes we update are valid. This fixes a problem where caches
  which are entirely created by the PPTT don't show up in lstopo.

Give the PPTT its own firmware_node in the cache structure instead of
  sharing it with the of_node.

Move some pieces around between patches.

(see previous cover letters for futher changes)

Jeremy Linton (13):
  drivers: base: cacheinfo: move cache_setup_of_node()
  drivers: base: cacheinfo: setup DT cache properties early
  cacheinfo: rename of_node to fw_token
  arm64/acpi: Create arch specific cpu to acpi id helper
  ACPI/PPTT: Add Processor Properties Topology Table parsing
  ACPI: Enable PPTT support on ARM64
  drivers: base cacheinfo: Add support for ACPI based firmware tables
  arm64: Add support for ACPI based firmware tables
  ACPI/PPTT: Add topology parsing code
  arm64: topology: rename cluster_id
  arm64: topology: enable ACPI/PPTT based CPU topology
  ACPI: Add PPTT to injectable table list
  arm64: topology: divorce MC scheduling domain from core_siblings

 arch/arm64/Kconfig                |   1 +
 arch/arm64/include/asm/acpi.h     |   4 +
 arch/arm64/include/asm/topology.h |   9 +-
 arch/arm64/kernel/cacheinfo.c     |  15 +-
 arch/arm64/kernel/topology.c      | 132 +++++++-
 arch/riscv/kernel/cacheinfo.c     |   1 -
 drivers/acpi/Kconfig              |   3 +
 drivers/acpi/Makefile             |   1 +
 drivers/acpi/pptt.c               | 642 ++++++++++++++++++++++++++++++++++++++
 drivers/acpi/tables.c             |   2 +-
 drivers/base/cacheinfo.c          | 157 +++++-----
 include/linux/acpi.h              |   4 +
 include/linux/cacheinfo.h         |  17 +-
 13 files changed, 882 insertions(+), 106 deletions(-)
 create mode 100644 drivers/acpi/pptt.c

-- 
2.13.6
