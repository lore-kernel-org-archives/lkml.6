Return-Path: <jeremy.linton@arm.com>
X-Google-Smtp-Source: AIpwx497i7Cid9+iORk43VF20/1ZyNZnKRZdwqho1ksMiC8/Tik24g/gL9K+h60SDiofsYcTnhp4
ARC-Seal: i=1; a=rsa-sha256; t=1524702368; cv=none;
        d=google.com; s=arc-20160816;
        b=b7jx9MoeJ+O/2GOa8doWTCPrjgExXn1ONRgu6bjDktHn0N6aUZ7ZftEvdnN3sxjEHI
         QfoBKOQj8ii12rAaP7/N9+IdVL00b82hlt6g/D01iSisniFdv34+vrts4uyoL2KWGvOO
         KD+1TB5Z1P8RroHxsvQyK4A/wegdQKUisz8GhTsaQptVg1Q8ChOPldS9FN1PtpHoAlWs
         dVGwXBTRWqhqiaPe4vAGRpX869k9MeB3rENzilwPjKh/cObLWiR/Yc3BbjQAZO+sDZml
         kToo67Jj00kosyLR7W1miesfzDgVbmOjnxJGu4c5iiLk/Atc9V1vaGtoSqaNElJP8SiK
         vlvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=G/mW7CYEWNz73346+j1EU4qnXYjx7XGuHuC7R6yC6gE=;
        b=n82bReA/uwZsC5gRE2BXQMqr+niBAMRMRCvgDK7h8/R1UBB0UTfpVUlvDWLqUEHetu
         kJT7N35PsAJ2FA8I72dkph2JA/0soP53LMDFZPJoQuBE1r94fv2vAb8UNfl0zTnLBysf
         QpGRg8QzwUqXQU9eO3VR7Ei6W5cDtDvdtcwyCywfGrUyZtc5EBTwTJLCPu/1l99ks0qJ
         uC5z49kOfkOkDnrMdqRivn6CVh9vt+Yzd+QJfv74lzQFNozBa8yv5JSD8ZXk6UaQibEY
         kp+1Kmlo0v40hwHcAXKb3lbCoap0sMFGU8OsfE/d2kCsLG0OqJ8sLjYspb09u5fPDV9g
         Gx0g==
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
	jhugo@qti.qualcomm.com,
	timur@qti.qualcomm.com,
	ard.biesheuvel@linaro.org,
	Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v8 00/13] Support PPTT for ARM64
Date: Wed, 25 Apr 2018 18:31:08 -0500
Message-Id: <20180425233121.13270-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.13.6
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598766310843839266?=
X-GMAIL-MSGID: =?utf-8?q?1598766310843839266?=
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
branch: pptt_v8

v7->v8:
Modify the logic used to select the MC domain (the change
  shouldn't modify the sched domains on any existing machines
  compared to v7, only how they are built)
Reduce the severity of some parsing messages.
Fix s390 link problem.
Further checks to deal with broken PPTT tables.
Various style tweaks, SPDX license addition, etc.

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
 arch/arm64/include/asm/topology.h |   6 +-
 arch/arm64/kernel/cacheinfo.c     |  15 +-
 arch/arm64/kernel/topology.c      | 103 +++++-
 arch/riscv/kernel/cacheinfo.c     |   1 -
 drivers/acpi/Kconfig              |   3 +
 drivers/acpi/Makefile             |   1 +
 drivers/acpi/pptt.c               | 678 ++++++++++++++++++++++++++++++++++++++
 drivers/acpi/tables.c             |   2 +-
 drivers/base/cacheinfo.c          | 157 ++++-----
 include/linux/acpi.h              |   4 +
 include/linux/cacheinfo.h         |  18 +-
 13 files changed, 886 insertions(+), 107 deletions(-)
 create mode 100644 drivers/acpi/pptt.c

-- 
2.13.6
