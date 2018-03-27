Return-Path: <richard.gong@linux.intel.com>
X-Google-Smtp-Source: AIpwx49eTL/fCO5UirilkINuZgpCu+5AT33WZ5YXLZaMt95w9/o8sm+PMnxcp0ZlRzoV4NtgHkBz
ARC-Seal: i=1; a=rsa-sha256; t=1522182199; cv=none;
        d=google.com; s=arc-20160816;
        b=npTgA+NJmTOyuFDS1liBWpkOhBSyOIYv7hcX+zgRTbefjHVgFy4vo+Js5JHpBZaP0t
         bBsdg3NhvuEmibpvfT54Ykimz2JtmuHuIu/dqS5WOneqOKbtZSZXZM8yWLNGCxgjFU5z
         T2NB3NyP/lQ9cOast+XiwFbnnsQU62/TC3pruhe+pg2rGXtNFfhxp05cdDfgiPMWbEn7
         fS4C2ZUHl4D7f+Uui3/Q+IimEs+8fV1mL7HpYyN/tA+GC4XnM5LTX7YnJQSJFCRSyvWJ
         ttcPZDEvwnqHFmRItF2yhXG3ZhvIkvi+RXO1Btczt3me4STPnUYQy0qr+YtUS+Jw0k76
         MB2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=KxuvmcmrPIhnpG9+GcurvAWjAbbKnp+l9Gxb4dB346o=;
        b=RJXkV/Zo0cS/QccJRDHxxn/Q+PFmhSQxXgDfIcNumK/M41TP1B/h2Va4qIB+8r7zIx
         XSo5PGQTyCHuYe+/MJOwvRnryiPNReOdrewOL5EYgzanIKwaGxsOshJV+nYjK41Z/6pj
         k61uiaaOC9PFaOgKncrHBrmf2eObUIhpfnlvga7mrUNU4IeVjlH+bAiJJFaRWyS3L1/+
         veD2aiG1HiKxD1pyjYznXvGUj72R2jXyoBxZ+J6iSz9awZvZz0z4i7XcjeDekjwczU20
         UWSIOInlisoxkOk/k4Y7HYmjfPucf6Dd3io+tvb58X6ETEjIFUXsg7hJBvP6mIInne6T
         QSYQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of richard.gong@linux.intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=richard.gong@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of richard.gong@linux.intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=richard.gong@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,368,1517904000";
   d="scan'208";a="215401230"
From: richard.gong@linux.intel.com
To: catalin.marinas@arm.com,
	will.deacon@arm.com,
	dinguyen@kernel.org,
	robh+dt@kernel.org,
	mark.rutland@arm.com,
	atull@kernel.org,
	mdf@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	yves.vandervennet@linux.intel.com,
	richard.gong@linux.intel.com,
	richard.gong@intel.com
Subject: [PATCHv3 0/7] Add Intel Stratix10 FPGA manager and service layer 
Date: Tue, 27 Mar 2018 15:20:07 -0500
Message-Id: <1522182014-7338-1-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596123721525542053?=
X-GMAIL-MSGID: =?utf-8?q?1596123721525542053?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Richard Gong <richard.gong@intel.com>

This is the 3rd submission of Intel service layer patches. Intel Stratix10
FPGA manager, which is 1st service layer client, is included in this submission.

Service layer patches have been reviewed internally by Alan Tull and other
colleagues at Intel.

Intel Stratix10 SoC is composed of a 64 bit quad-core ARM Cortex A53 hard
processor system (HPS) and Secure Device Manager (SDM). SDM is the hardware
which does the FPGA configuration, QSPI, Crypto and warm reset.

In order to configure the FPGA from HPS, there needs to be a way for HPS to
notify SDM the location and size of the configuration data. Then SDM will
get the configuration data from that location and perform the FPGA configuration.

To meet the whole system security needs and support virtual machine
requesting communication with SDM, only the secure world of software (EL3,
Exception Level 3) can interface with SDM. All software entities running
on other exception levels must channel through the EL3 software whenever it
needs service from SDM.

Intel Stratix10 service layer driver is added to provide the service for
FPGA configuration. Running at privileged exception level (EL1, Exception
Level 1), Intel Stratix10 service layer driver interfaces with the service
provider at EL1 (Intel Stratix10 FPGA Manager) and manages secure monitor
call (SMC) to communicate with secure monitor software at secure monitor
exception level (EL3).

Later the Intel Stratix10 service layer driver will be extended to provide
services for QSPI, Crypto and warm reset.

v2: add patches for FPGA manager, FPGA manager binding, dts and defconfig
    remove intel-service subdirectory and intel-service.h, move intel-smc.h
    and intel-service.c to driver/misc subdirectory
    remove global variables
    change service layer driver be 'default n'
    correct SPDX markers
    add timeout for do..while() loop
    add kernel-doc for the functions and structs, correct multiline comments
    replace kfifo_in/kfifo_out with kfifo_in_spinlocked/kfifo_out_spinlocked
    rename struct intel_svc_data (at client header) to intel_svc_client_msg
    rename struct intel_svc_private_mem to intel_svc_data
    other corrections/changes from Intel internal code reviews
v3: change all exported functions with "intel_svc_" as the prefix
    Increase timeout values for claiming back submitted buffer(s)
    Rename struct intel_command_reconfig_payload to
    struct intel_svc_command_reconfig_payload
    Add pr_err() to provide the error return value
    change to put fpga_mgr node under firmware/svc node
    change to FPGA manager to align the update of service client APIs, and the
    update of fpga_mgr device node
    Other corrections/changes

Alan Tull (3):
  dt-bindings: fpga: add Stratix10 SoC FPGA manager binding
  arm64: dts: stratix10: add fpga manager and region
  fpga: add intel stratix10 soc fpga manager driver

Richard Gong (4):
  dt-bindings, firmware: add Intel Stratix10 service layer binding
  arm64: dts: stratix10: add service driver binding to base dtsi
  driver, misc: add Intel Stratix10 service layer driver
  defconfig: enable fpga and service layer

 .../bindings/firmware/intel,stratix10-svc.txt      |  57 ++
 .../bindings/fpga/intel-stratix10-soc-fpga-mgr.txt |  17 +
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  |  34 +
 arch/arm64/configs/defconfig                       |   5 +
 drivers/fpga/Kconfig                               |   6 +
 drivers/fpga/Makefile                              |   1 +
 drivers/fpga/stratix10-soc.c                       | 534 ++++++++++++
 drivers/misc/Kconfig                               |  12 +
 drivers/misc/Makefile                              |   1 +
 drivers/misc/intel-service.c                       | 962 +++++++++++++++++++++
 drivers/misc/intel-smc.h                           | 205 +++++
 include/linux/intel-service-client.h               | 188 ++++
 12 files changed, 2022 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt
 create mode 100644 Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
 create mode 100644 drivers/fpga/stratix10-soc.c
 create mode 100644 drivers/misc/intel-service.c
 create mode 100644 drivers/misc/intel-smc.h
 create mode 100644 include/linux/intel-service-client.h

-- 
2.7.4
