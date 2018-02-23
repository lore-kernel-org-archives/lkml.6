Return-Path: <sudeep.holla@arm.com>
X-Google-Smtp-Source: AG47ELtBka8SFGsUZvhtnMTDpvdSPqmCug3bE9f0aqRHyImcjor5nW+kIruZBl6Ccw4BnoR57EPS
ARC-Seal: i=1; a=rsa-sha256; t=1519403049; cv=none;
        d=google.com; s=arc-20160816;
        b=VCNvEjQ3H9FvHmKnCC5jowRgQdbWd5HkJNarKHYLE3nYso/bc57RM3CQxp4iHxIkak
         xnESuBXASV4GVq4oN4UMfMFOrisKhIPJLUOAnj5XuVbcVbScJQzJUkArqOk3fQNaLcUs
         rzVFxvIC0wnkXH3yTUvy2hsobxTlczovbK/hJ0maJZ21Xlf1g2n6Atqtx+3uqz+sRoZx
         X3ZURFPSAti+BPbofCvCFCYlS95T5LzK5gLuetU/WkeErmdOxEHYogs03BquyVITG1vz
         A+PGlFw73PsnijnZc9OLKFpTwrX58IF28adYHKMdLeNdwqUUV22UiHXOcmife8OVJu5C
         TiEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=q3UXyp+tnqviAHY2DeuyyRpdyMaApC+pjq/q5ocp9lw=;
        b=HfN18yILCddc9WzH9synlCvdUw4xPYDZ5zABBYkeP9qR9Af7090ikUOMn20XqFp7eP
         6FoAMnXAUKA3YtP/KwI0s1rveBKx8Hl3TtAtXdmYaB7C7cd1/6mrkc3ck5QtR6s+XDNK
         ZXZ3kE1kNAwjDtoMWOWHtJbnDOlv9d/kPbrahfxot+dVy0tHRsxY/IjAzON/8jjXAKMS
         bv/f22rfVx1PSNBzxgIHEEdsVIveJxkbiOpSK39ZX9ULdbGZhua9Uy16IUlOIn3kbGPC
         hYJuULurfvsTYp/FvGSzDURgvswjaTyV14GMp4dp7ftO+A3kdvKKeCiUGDodhkJoJblO
         4+cQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
From: Sudeep Holla <sudeep.holla@arm.com>
To: ALKML <linux-arm-kernel@lists.infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	DTML <devicetree@vger.kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Alexey Klimov <klimov.linux@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v6 01/20] dt-bindings: mailbox: add support for mailbox client shared memory
Date: Fri, 23 Feb 2018 16:23:31 +0000
Message-Id: <1519403030-21189-2-git-send-email-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519403030-21189-1-git-send-email-sudeep.holla@arm.com>
References: <1519403030-21189-1-git-send-email-sudeep.holla@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593209572102769304?=
X-GMAIL-MSGID: =?utf-8?q?1593209572102769304?=
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
