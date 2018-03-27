Return-Path: <richard.gong@linux.intel.com>
X-Google-Smtp-Source: AIpwx48DZzrtPvZpQ8JZ3cYeO2288cV3x6ZvlPkBT0LhyH1tHbxNPuouDVo62LQsozbOcyoKa7X5
ARC-Seal: i=1; a=rsa-sha256; t=1522182204; cv=none;
        d=google.com; s=arc-20160816;
        b=JZd0ffhq28Hlmz/qDb/BQbmaZW66JwdPXKqbbxjA8fZRtqipFSamr4+819obXYT7kB
         5EfLZb3DVyHv18PliVMBfVB6A0yPX0r4zNfmi2c30FDOqaGDffF0+N2/bup6cOxcSGfF
         4hNcbXY9Z78A8+DwvLvAqN1QrtAWpEWAm2dx/CEUjZf24Er2vVQT+P19xG6Nb32KtusE
         p1YYLm1qq2pRpObSe5YdTk985qk92kqwW/oATSxY0iq6o24kOc+ibzFT9hG90x32j057
         +cUVowL77SyXTLGiDUPOXEfnFXoP9X4ZRItd/0zojDNelOFDwzyKZWezDdJz9VoIrdns
         yZVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=8UYQ3ktNu4ImZHzzvFQXpV15TVNvl7GrekaiBuu6rno=;
        b=zW4iHjQiSj8k91Ttmpn2/Dr3OgCtpXpJNuDwZVaAVtlHYtw71tLd5QT/nM0jMCRD5F
         L3PKXLd3/EDwVwuKRYx8q1NQFGLzhSd3FF0q+RtJnfkASF29ENMR5rDRhv/q86MsNIs4
         73nCO1dD5EZAEndq4o7MehZX7gTLqJ+n1lGyEwngDwt5kyUIkgud/BfbBFeg+hzdTGiO
         x3Ar5e8RGbMds1T2EQpTjwfpF5mWDOcKbV6SnVm0RbQweypq6BHgnaNWOtkCvm9xv3yc
         kP4m9b1G3GqDhQ1w4+InUyKnWdyINVvo0hU6RO1lrD4a/wOXPE7v0p/Z9Bp2Lj+63nbQ
         s9xQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of richard.gong@linux.intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=richard.gong@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of richard.gong@linux.intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=richard.gong@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,368,1517904000";
   d="scan'208";a="215401308"
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
Subject: [PATCHv3 1/7] dt-bindings, firmware: add Intel Stratix10 service layer binding
Date: Tue, 27 Mar 2018 15:20:08 -0500
Message-Id: <1522182014-7338-2-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522182014-7338-1-git-send-email-richard.gong@linux.intel.com>
References: <1522182014-7338-1-git-send-email-richard.gong@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596123727148714212?=
X-GMAIL-MSGID: =?utf-8?q?1596123727148714212?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Richard Gong <richard.gong@intel.com>

Add a device tree binding for the Intel Stratix10 service layer driver

Signed-off-by: Richard Gong <richard.gong@intel.com>
Signed-off-by: Alan Tull <atull@kernel.org>
---
v2: Change to put service layer driver node under the firmware node
    Change compatible to "intel, stratix10-svc"
v3: No change
---
 .../bindings/firmware/intel,stratix10-svc.txt      | 57 ++++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt

diff --git a/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt b/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt
new file mode 100644
index 0000000..1fa6606
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt
@@ -0,0 +1,57 @@
+Intel Service Layer Driver for Stratix10 SoC
+============================================
+Intel Stratix10 SoC is composed of a 64 bit quad-core ARM Cortex A53 hard
+processor system (HPS) and Secure Device Manager (SDM). When the FPGA is
+configured from HPS, there needs to be a way for HPS to notify SDM the
+location and size of the configuration data. Then SDM will get the
+configuration data from that location and perform the FPGA configuration.
+
+To meet the whole system security needs and support virtual machine requesting
+communication with SDM, only the secure world of software (EL3, Exception
+Layer 3) can interface with SDM. All software entities running on other
+exception layers must channel through the EL3 software whenever it needs
+service from SDM.
+
+Intel Stratix10 service layer driver, running at privileged exception level
+(EL1, Exception Layer 1), interfaces with the service providers and provides
+the services for FPGA configuration, QSPI, Crypto and warm reset. Service layer
+driver also manages secure monitor call (SMC) to communicate with secure monitor
+code running in EL3.
+
+Required properties:
+-------------------
+The svc node has the following mandatory properties, must be located under
+the firmware node.
+
+- compatible: "intel,stratix10-svc"
+- method: smc or hvc
+        smc - Secure Monitor Call
+        hvc - Hypervisor Call
+- memory-region:
+	phandle to the reserved memory node. See
+	Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
+	for details
+
+Example:
+-------
+
+	reserved-memory {
+                #address-cells = <2>;
+                #size-cells = <2>;
+                ranges;
+
+                service_reserved: svcbuffer@0 {
+                        compatible = "shared-dma-pool";
+                        reg = <0x0 0x0 0x0 0x1000000>;
+                        alignment = <0x1000>;
+                        no-map;
+                };
+        };
+
+	firmware {
+		svc {
+			compatible = "intel,stratix10-svc";
+			method = "smc";
+			memory-region = <&service_reserved>;
+		};
+	};
-- 
2.7.4
