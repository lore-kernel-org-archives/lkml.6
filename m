Return-Path: <richard.gong@linux.intel.com>
X-Google-Smtp-Source: AG47ELsuKGW2hL9iXWsfZ7QvrMNcZAxZkC2YqPMMKBjqM1KwZh01cqHWWMpuE/QbnKBNYawFRbCF
ARC-Seal: i=1; a=rsa-sha256; t=1519950203; cv=none;
        d=google.com; s=arc-20160816;
        b=ZvyfHYoilEfSpJeI1U10nrxaQny227JjZ/68MGIIRZf+ggCVuCn0t71hg9otntThja
         vC7ZJGCIYpUGvm6uhtYv85SqRpFHJYSYgjEblIWWQ+FYYAVagaOoC3G5uVB+rYUVvzzZ
         ytCv+9o3uV+uGghTS6g0B6moyfbECSTDe8YcdippwP6N02ZbLbi7owOo0QkZx0Z8IMFZ
         n+xj55mz2jpIOEDQ+2dJxZ97gpzlXqNjDFaH1Qpg3Nb3YByokG3ZP5doKgSBsZ8JxlsH
         4byOsUOmblu7zIhbPBXgesXPntR6Culd6g5mXgboyo3yZ5zHZ0/hxqCzn72Wvl/Eu90p
         fgzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=5xfg0EukzRTj34M0+J9KIrftJNsEq3fZpJ86sjDlSsw=;
        b=tt4iSjYO6r5Y+o9bOotdVscOFHKHsE3KcEBTs3luOjUiNLgFzgFRM0oCKkMQURti/m
         UB8wbMm+bQ3Q4wkIoIUmVODDQmwXxFw8GL41n4BHoakmvBPzX/QQC+WYaT0V5Gf6q4mN
         lTQfOwb9oCWQb0Dv4QvP+bL+pKGaEEiqAw/zitEhVTabi3jkGxh0/snyZBPgypzq9B49
         iNTfH5c4Fdrp8yq15T3ub5sFafduhupxWYO4GGR3iOUaP40QuSRvo49mUPnFVF8cvqRH
         0nAH7QltgaCuBsUAlwYjYHrQb71Y6lgKvRJWDhGJST9U5qYiIk3ayHJHaSN78AExm140
         Iq7A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of richard.gong@linux.intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=richard.gong@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of richard.gong@linux.intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=richard.gong@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,409,1515484800";
   d="scan'208";a="35279622"
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
	Richard Gong <richard.gong@intel.com>
Subject: [PATCHv2 0/7] Add Intel Stratix10 FPGA manager and service layer
Date: Thu,  1 Mar 2018 18:19:28 -0600
Message-Id: <1519949975-13548-1-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593783304889555222?=
X-GMAIL-MSGID: =?utf-8?q?1593783304889555222?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Richard Gong <richard.gong@intel.com>

This is the 2nd submission of Intel service layer patches. Intel Stratix10
FPGA manager, which is 1st service layer client, is included in this submission.

Service layer patches have been reviewed internally by Alan Tull and other
colleagues at Intel.

Intel Stratix10 SoC is composed of a 64 bit quad-core ARM Cortex A53 hard
processor system (HPS) and Secure Device Manager (SDM). SDM is the hardware
which does the FPGA configuration, QSPI, Crypto and warm reset.

When the FPGA is configured from HPS, there needs to be a way for HPS to
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
 .../bindings/fpga/intel-stratix10-soc-fpga-mgr.txt |  10 +
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  |  34 +
 arch/arm64/configs/defconfig                       |   5 +
 drivers/fpga/Kconfig                               |   6 +
 drivers/fpga/Makefile                              |   1 +
 drivers/fpga/stratix10-soc.c                       | 503 +++++++++++
 drivers/misc/Kconfig                               |  12 +
 drivers/misc/Makefile                              |   1 +
 drivers/misc/intel-service.c                       | 960 +++++++++++++++++++++
 drivers/misc/intel-smc.h                           | 205 +++++
 include/linux/intel-service-client.h               | 188 ++++
 12 files changed, 1982 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt
 create mode 100644 Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
 create mode 100644 drivers/fpga/stratix10-soc.c
 create mode 100644 drivers/misc/intel-service.c
 create mode 100644 drivers/misc/intel-smc.h
 create mode 100644 include/linux/intel-service-client.h

-- 
2.7.4
