Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3841409-1519418945-2-11677642127997015253
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519418944; b=D6lF0GGmNiXj8WiBf1DB4uBokfjfSKf5DZJT7g/8pEx9fPC
    KBDDokMn/vJbdUW6g/vOAthYyN9uGbpSWlQYogH+m24fKd44S0cLYXgnD0yPyWQN
    jGCM998Z+IHGjK/CBHh7UbPYCAOFn+ULArVL46Nn9/rFgUDsLyiRE2ONZ6bK5pnN
    CMDnKb4P0N42rPgUDMDh9HOcVeZrLgiwoDVAchcFAjIIZp+Fsbrqe6LOvUGNaylk
    3JPFCRPhr63AAbcn6dPz+nAnxUIljofnQ8hHPYcYQmsIYTh8Scf+3KBVHNp7Ti83
    R5FaCBvr4mkEEr2mvaSlHnVtKWL7hmBsx7HzVNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519418944; bh=D+/0u/gueOyEwj+rKsLW3mi9aA
    DaoCVStWb4OqXxCb4=; b=fCY9FUuixiy5ZZmzFZovsbsmYw1m0kN1Ok1V3vrAQf
    Fetu12pNp4EvuYSHJWp4h2O74Lij9EJnJA0Av9Hv+6/f+Q0GtLk8Ygr2LKDCvX32
    QtT08IRbgOt+WCLyyPcBz5gnhNRiwJF7Hi3isTXTaBJWg0gS1XV0wJfzYUbBkYvc
    hJJYwPV8hoYlp4QEGMlsDgRWHZDmM4tOfwBssIifnRbMmhACtykbiPPt0Sp0TWcl
    nSlkNfcP6UP2mmBkYf8SebZye6ZaIrkV2v8mA2facfiiemw7l1lmNE6FN/61p0/m
    sE/CSdyekGddREJECwbQmHu0duG2VIDnUwiWmAfFXaug==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752604AbeBWSbg (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:31:36 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:35290 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752597AbeBWSbf (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:31:35 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH 3.18 05/58] arm: spear13xx: Fix dmas cells
Date: Fri, 23 Feb 2018 19:26:04 +0100
Message-Id: <20180223170207.489945611@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170206.724655284@linuxfoundation.org>
References: <20180223170206.724655284@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Viresh Kumar <viresh.kumar@linaro.org>

commit cdd10409914184c7eee5ae3e11beb890c9c16c61 upstream.

The "dmas" cells for the designware DMA controller need to have only 3
properties apart from the phandle: request line, src master and
destination master. But the commit 6e8887f60f60 updated it incorrectly
while moving from platform code to DT. Fix it.

Cc: stable@vger.kernel.org # v3.10+
Fixes: 6e8887f60f60 ("ARM: SPEAr13xx: Pass generic DW DMAC platform data from DT")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/devicetree/bindings/dma/snps-dma.txt |    2 +-
 arch/arm/boot/dts/spear1340.dtsi                   |    4 ++--
 arch/arm/boot/dts/spear13xx.dtsi                   |    6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

--- a/Documentation/devicetree/bindings/dma/snps-dma.txt
+++ b/Documentation/devicetree/bindings/dma/snps-dma.txt
@@ -58,6 +58,6 @@ Example:
 		interrupts = <0 35 0x4>;
 		status = "disabled";
 		dmas = <&dmahost 12 0 1>,
-			<&dmahost 13 0 1 0>;
+			<&dmahost 13 1 0>;
 		dma-names = "rx", "rx";
 	};
--- a/arch/arm/boot/dts/spear1340.dtsi
+++ b/arch/arm/boot/dts/spear1340.dtsi
@@ -141,8 +141,8 @@
 				reg = <0xb4100000 0x1000>;
 				interrupts = <0 105 0x4>;
 				status = "disabled";
-				dmas = <&dwdma0 0x600 0 0 1>, /* 0xC << 11 */
-					<&dwdma0 0x680 0 1 0>; /* 0xD << 7 */
+				dmas = <&dwdma0 12 0 1>,
+					<&dwdma0 13 1 0>;
 				dma-names = "tx", "rx";
 			};
 
--- a/arch/arm/boot/dts/spear13xx.dtsi
+++ b/arch/arm/boot/dts/spear13xx.dtsi
@@ -100,7 +100,7 @@
 			reg = <0xb2800000 0x1000>;
 			interrupts = <0 29 0x4>;
 			status = "disabled";
-			dmas = <&dwdma0 0 0 0 0>;
+			dmas = <&dwdma0 0 0 0>;
 			dma-names = "data";
 		};
 
@@ -288,8 +288,8 @@
 				#size-cells = <0>;
 				interrupts = <0 31 0x4>;
 				status = "disabled";
-				dmas = <&dwdma0 0x2000 0 0 0>, /* 0x4 << 11 */
-					<&dwdma0 0x0280 0 0 0>;  /* 0x5 << 7 */
+				dmas = <&dwdma0 4 0 0>,
+					<&dwdma0 5 0 0>;
 				dma-names = "tx", "rx";
 			};
 
