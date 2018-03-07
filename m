Return-Path: <anholt@anholt.net>
X-Google-Smtp-Source: AG47ELv6m8t52aUOZuv2B8oCI1/SB3NaKzQYgzPLL0iaKBzA6o5sLkF+J3O5/eBYJc0RFts4zhNy
ARC-Seal: i=1; a=rsa-sha256; t=1520449044; cv=none;
        d=google.com; s=arc-20160816;
        b=cgYzHsnvYQ8SLQCtc3fMcxKhao1dTjIuBpDF9HDLp/tzgrtiAE/DEJ8liuf5wsOv3U
         53zPKaBL6hKerqht5eu3h1IXb5vd/KQLHvNvlQLkG/LRKtQgJVBrLoK+g1FdO67rEhcn
         Pij710gBXoK7KxpIpm0gKkL4rQvLM5/ceRLhDLHT3vqEfAU/64DwmWX6oK6bXyDbV3Ne
         CqQvck1Bav79y52k/a+GZ59hCJi+bTi1RK2OCKF3ZBpz8EhyQeYtVRjW68Cl1IIa1kAA
         AcwH/crnPZGYhHLsgbBHFaV5M/+zpTZVkf1Y5Qjv1IGMG07kTIhDTXKtce5eJDa38Pep
         0Inw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=tvpgBx58dxt8GFegU2pAoGgx9wz2SY1jFkets80T1gI=;
        b=cOSMWr7wHLbU8H4DmKi1DXL7EotT9IC30PZMkQHgawe+GzaEHRraTA33QRjxueCobv
         aYJqUPFYpk6N4cs/e0xr17Sau0MdvAKSNZjGF+u21bTJlutMBX651ylqWxud/fRjt7o9
         Pxw7QXb+cEqZTHEyix/Y4atC1haqNv8sOCy8sg/am4SJPV/ebW7tMc1IvJh6fMRZ/Kar
         aMNqS0t5P+F6EUcATBI++FU1ZqkNGq++lksXJLUE0d0jVT+qjqC0wCOQ6Va3Dd6sKpjO
         h9+6BySEqmRNracIR2ouR5PjZ5zcMPM7WJLchlEfYI+I9OxPQUENLZaReqyFKJW37Pds
         8W/A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of anholt@anholt.net designates 50.246.234.109 as permitted sender) smtp.mailfrom=anholt@anholt.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of anholt@anholt.net designates 50.246.234.109 as permitted sender) smtp.mailfrom=anholt@anholt.net
From: Eric Anholt <eric@anholt.net>
To: Florian Fainelli <f.fainelli@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Phil Elwell <phil@raspberrypi.org>
Cc: linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <stefan.wahren@i2se.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Eric Anholt <eric@anholt.net>
Subject: [PATCH v2 3/6] dt-bindings: soc: Add a binding for the Broadcom VCHIQ services.
Date: Wed,  7 Mar 2018 10:57:13 -0800
Message-Id: <20180307185716.17449-3-eric@anholt.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307185716.17449-1-eric@anholt.net>
References: <20180307185716.17449-1-eric@anholt.net>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594306376933935522?=
X-GMAIL-MSGID: =?utf-8?q?1594306376933935522?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The VCHIQ communication channel can be provided by BCM283x and Capri
SoCs, to communicate with the VPU-side OS services.

Signed-off-by: Eric Anholt <eric@anholt.net>
---

v2: dropped firmware property, added cache-line-size.

 .../bindings/soc/bcm/brcm,bcm2835-vchiq.txt        | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt

diff --git a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt
new file mode 100644
index 000000000000..cdef4abc5e47
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt
@@ -0,0 +1,28 @@
+Broadcom VCHIQ firmware services
+
+Required properties:
+
+- compatible:	Should be "brcm,bcm2835-vchiq"
+- reg:		Physical base address and length of the doorbell register pair
+- interrupts:	The interrupt number
+		  See bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
+
+Optional properties:
+
+- cache-line-size:
+		Size of L2 cache lines.  The VPU firmware detects
+		  this property and overrides it with the actual L2
+		  cache line size it's using when loading the
+		  device-tree.  Determines the required alignment of
+		  offsets/sizes of VCHIQ pagelists.  If missing, the
+		  firmware assumes an older kernel using 32-byte
+		  alignment.
+
+Example:
+
+vchiq@7e00b840 {
+	compatible = "brcm,bcm2835-vchiq";
+	reg = <0x7e00b840 0xf>;
+	interrupts = <0 2>;
+	cache-line-size: <32>;
+};
-- 
2.16.2
