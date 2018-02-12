Return-Path: <sudeep.holla@arm.com>
X-Google-Smtp-Source: AH8x224reQFofZHL7vZa6XI2vE++P4qIIgMjZAaACh2CzP/v6IdyB40LvSgSEBG6BELOxP3SKd3E
ARC-Seal: i=1; a=rsa-sha256; t=1518461144; cv=none;
        d=google.com; s=arc-20160816;
        b=T0GLUpzVUmNaTkqlynOhhuFzH9AucrwYqpAwH3uBE9AMU2L+Ivp2SnmCA5w936Vs9q
         vZjhYjEv6thdoH2I5U5sMYWa20JTUYuT2yU8EwA8uIfO62lvc6A2u7BVYD5p68k838JV
         dXS7fKXFUBW8oRq12k+EoQpp0Ro0BgvEFmRDqlUw6PhQmdYAZ2kaHG3M3OFE8kWNU+zc
         sASIoIUH5YHl1mJHpicxvzpk9LW0croRa6AqWKuZ9a37ERDESv3Q+mALu6sgcKOcMvh7
         GDzIEkA37j+jZ4OqgCzxEDO109GFOkZC4A8H44UTzp3D5SM15fX0moplOl8n60NiN+Nu
         c7DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=q3UXyp+tnqviAHY2DeuyyRpdyMaApC+pjq/q5ocp9lw=;
        b=lPQt3Fqdb5hht7rM2ZJ8EEo83t7y9svtFYiBACdXBY/5xRXcywQoVE3gnD/g+/2lGJ
         x2AixU47QdN5V3GVpo1fSu7JcxBiYWancXxhgnhf2TPXZ/7TeXLfg5y35gq69ya9pQ25
         VCEqqJ1G6rLsqSiUCMDhbm0doyQrlTI5uvuHQzcjBtBDzNV4hhPJrvTW5AHM7AtLPMGR
         1PxtlXDsaKGRp4/Q9oBRYinX3/6/zR+AvrTsY8pxOurAIVH3mj0KY/CXeFyUYkdPBvUP
         b/lJ4bhfsde83QyWby419ZdGnEHzcPI8rhQM0fKwCIUXogXz+I6zY1do2IG0rqA5FMo3
         6kZg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
From: Sudeep Holla <sudeep.holla@arm.com>
To: ALKML <linux-arm-kernel@lists.infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	DTML <devicetree@vger.kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Alexey Klimov <klimov.linux@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v5 01/20] dt-bindings: mailbox: add support for mailbox client shared memory
Date: Mon, 12 Feb 2018 18:45:05 +0000
Message-Id: <1518461124-17371-2-git-send-email-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518461124-17371-1-git-send-email-sudeep.holla@arm.com>
References: <1518461124-17371-1-git-send-email-sudeep.holla@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592221912917359291?=
X-GMAIL-MSGID: =?utf-8?q?1592221912917359291?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Many users of the mailbox controllers depend on the shared memory
between the two end points to exchange the main data while using simple
doorbell mechanism to alert the end points of the presence of a message.

This patch defines device tree bindings to represent such shared memory
in a generic way.

Cc: Mark Rutland <mark.rutland@arm.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 .../devicetree/bindings/mailbox/mailbox.txt        | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/mailbox/mailbox.txt b/Documentation/devicetree/bindings/mailbox/mailbox.txt
index be05b9746c69..af8ecee2ac68 100644
--- a/Documentation/devicetree/bindings/mailbox/mailbox.txt
+++ b/Documentation/devicetree/bindings/mailbox/mailbox.txt
@@ -23,6 +23,11 @@ assign appropriate mailbox channel to client drivers.
 
 Optional property:
 - mbox-names: List of identifier strings for each mailbox channel.
+- shmem : List of phandle pointing to the shared memory(SHM) area between the
+	  users of these mailboxes for IPC, one for each mailbox. This shared
+	  memory can be part of any memory reserved for the purpose of this
+	  communication between the mailbox client and the remote.
+
 
 Example:
 	pwr_cntrl: power {
@@ -30,3 +35,26 @@ assign appropriate mailbox channel to client drivers.
 		mbox-names = "pwr-ctrl", "rpc";
 		mboxes = <&mailbox 0 &mailbox 1>;
 	};
+
+Example with shared memory(shmem):
+
+	sram: sram@50000000 {
+		compatible = "mmio-sram";
+		reg = <0x50000000 0x10000>;
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x50000000 0x10000>;
+
+		cl_shmem: shmem@0 {
+			compatible = "client-shmem";
+			reg = <0x0 0x200>;
+		};
+	};
+
+	client@2e000000 {
+		...
+		mboxes = <&mailbox 0>;
+		shmem = <&cl_shmem>;
+		..
+	};
-- 
2.7.4
