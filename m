Return-Path: <jeremy.linton@arm.com>
X-Google-Smtp-Source: AB8JxZp9KJHzi9hFosaMg6XcBXVWJXj5EdcqPEEvXdwycjLWkjz6koYGjRK5FmYXKgMsEJDDXYxC
ARC-Seal: i=1; a=rsa-sha256; t=1526083132; cv=none;
        d=google.com; s=arc-20160816;
        b=zwXvG8EEyOvPj7O3JAHQCmSQ00E3KazucpQNWn5WSUw+OBGu9HyGWYE/2+Sfq3fVEm
         WXvhwMnxQxzcbmzY8SSHzq0WWw6CBWrWWoqua011g4C1msWOSYDmxhSq6K6brLsuKKFO
         LkOu0mY3m7H89vd4sYTNqtW+8TLw7ekIpAnSr6YczXOlU9eJIGfoLxJpXI18y2Vx4HmL
         jr0sQZEWQ44AB9ooEWWL3/MLNw5iZRy5OZyOfUFegnn8LNyofRbNmbGCigsi0vFBgWmG
         1ZYF5VviFbDTaQgRyUQdnsvZY7702Mja7vaT3APcAXCJ/yvPYfeLBx5CqCbWNgs/kUxO
         wNmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=fL10GeYpzNDlH8MD1JvzN8eUClsNmjKm+4ey6E8aoCM=;
        b=EFHazSNoCugrqFrveVF/ZZkwD/bYWjvTVArbFCNfUxsssZJw12rrLkHri+Jw0ebnNr
         w58u4hhH2kNbOb1jW20xus5bibpkZz6w+/ns6lNaK6MVnA9HHWSLebNLmZdr8n1llmvr
         N8UiZTLIC0MLfig9nZ98LNQ/fHb8vKKqpv/eEuHQspw+Ywo/SevUE+UdjoVeJGAy7Q9n
         tPHgeNLkhouIi8fMEAqq1Dshsk3aTz6wZ4tHVbx8tH3g05b/PGI1uY2Olb0SeoB0pBtH
         rW+DgFccpMKSf0ge/afw8SVgDn4CnzGJkMgsrpj4pR256mWlHh5ktqTFX8FLJTv+hlxC
         yNmw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jeremy.linton@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=jeremy.linton@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jeremy.linton@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=jeremy.linton@arm.com
From: Jeremy Linton <jeremy.linton@arm.com>
To: linux-acpi@vger.kernel.org
Cc: Sudeep.Holla@arm.com,
	linux-arm-kernel@lists.infradead.org,
	Lorenzo.Pieralisi@arm.com,
	hanjun.guo@linaro.org,
	rjw@rjwysocki.net,
	Will.Deacon@arm.com,
	Catalin.Marinas@arm.com,
	gregkh@linuxfoundation.org,
	Mark.Rutland@arm.com,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	wangxiongfeng2@huawei.com,
	vkilari@codeaurora.org,
	ahs3@redhat.com,
	Dietmar.Eggemann@arm.com,
	Morten.Rasmussen@arm.com,
	palmer@sifive.com,
	lenb@kernel.org,
	john.garry@huawei.com,
	austinwc@codeaurora.org,
	tnowicki@caviumnetworks.com,
	jhugo@codeaurora.org,
	ard.biesheuvel@linaro.org,
	Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v9 00/12] Support PPTT for ARM64
Date: Fri, 11 May 2018 18:57:55 -0500
Message-Id: <20180511235807.30834-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.13.6
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600214146814792437?=
X-GMAIL-MSGID: =?utf-8?q?1600214146814792437?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

ACPI 6.2 adds the Processor Properties Topology Table (PPTT), which is
used to describe the processor and cache topology. Ideally it is
used to extend/override information provided by the hardware, but
right now ARM64 is entirely dependent on firmware provided tables.

This patch parses the table for the cache topology and CPU topology.
When we enable ACPI/PPTT for arm64 we map the package_id to the
PPTT node flagged as the physical package by the firmware.
This results in topologies that match what the remainder of the
system expects. Finally, we update the scheduler MC domain so that
it generally reflects the LLC unless the LLC is too large for the
NUMA domain (or package).

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
branch: pptt_v9

v8->v9:
 Add further ack/tested by's (thanks everyone)
 kerneldoc, general comment and patch description tweaks.
 Squash the pptt.c module (#5 & #13) back together.
 remove a redundant () in an if, and rename a variable.

v7->v8:
 Modify the logic used to select the MC domain (the change
   shouldn't modify the sched domains on any existing machines
   compared to v7, only how they are built)
 Reduce the severity of some parsing messages.
 Fix s390 link problem.
 Further checks to deal with broken PPTT tables.
 Various style tweaks, SPDX license addition, etc.

(see previous cover letters for further changes)


Jeremy Linton (12):
  drivers: base: cacheinfo: move cache_setup_of_node()
  drivers: base: cacheinfo: setup DT cache properties early
  cacheinfo: rename of_node to fw_token
  arm64/acpi: Create arch specific cpu to acpi id helper
  ACPI/PPTT: Add Processor Properties Topology Table parsing
  ACPI: Enable PPTT support on ARM64
  drivers: base cacheinfo: Add support for ACPI based firmware tables
  arm64: Add support for ACPI based firmware tables
  arm64: topology: rename cluster_id
  arm64: topology: enable ACPI/PPTT based CPU topology
  ACPI: Add PPTT to injectable table list
  arm64: topology: divorce MC scheduling domain from core_siblings

 arch/arm64/Kconfig                |   1 +
 arch/arm64/include/asm/acpi.h     |   4 +
 arch/arm64/include/asm/topology.h |   6 +-
 arch/arm64/kernel/cacheinfo.c     |  15 +-
 arch/arm64/kernel/topology.c      | 107 ++++++-
 arch/riscv/kernel/cacheinfo.c     |   1 -
 drivers/acpi/Kconfig              |   3 +
 drivers/acpi/Makefile             |   1 +
 drivers/acpi/pptt.c               | 655 ++++++++++++++++++++++++++++++++++++++
 drivers/acpi/tables.c             |   2 +-
 drivers/base/cacheinfo.c          | 157 ++++-----
 include/linux/acpi.h              |   4 +
 include/linux/cacheinfo.h         |  25 +-
 13 files changed, 874 insertions(+), 107 deletions(-)
 create mode 100644 drivers/acpi/pptt.c

-- 
2.13.6
