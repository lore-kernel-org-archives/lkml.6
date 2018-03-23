Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1061450-1521802454-2-15663812088134945959
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521802454; b=u7r4H8+0ZIy8/D0EavO6+7fQWIopcbUI4zk7S/mWcwuNGZz
    bfBy3IJ8aAfdWgjqAMMD61UpYhC0NU0uGWNfYnZzooSx13hASseyb07pGImAxd3S
    c4BkXsFCPkIunrWLLJUnEbEbYni4SsP7s9aVuLFMLnKKSU9H8FNJwtqSSWrfg7KM
    YrlAAKhyCRZ4eZbxo8wBQTkf5yweEtPTpPlcPa2d8eOQTe1XQnhK5cTZdlzxdWLn
    1x9BVAbS5fXJxiGThPb5bNiprHFe1QPDgovzf5/WUBDPAZfwaQtabzLjUeSis3BL
    Fyx9ec1zJH70CF6423sV9Wa7IdWepisLmVSZkdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521802454; bh=6T4m/h0QvtoRVsZ+nXPtJFenMN
    WcAEQnl8B15+pu3wU=; b=p/lXqoW6e4oqMdqLXcslyG/JerxYvgVA1CxqpjFi3h
    NEnI2sy6aBEc+OC824FrQWZSiS4XNfjh8osGnICTwGbB/63Q9ZNqkB/JXUAracde
    zBnZIeIP0dn7WY/HnJRy2l3wNX7HlyUplDiJewvY1W57jdurKqXx4exiGje0PCjw
    T9W/bOloq91AV+cBGOlkmewau9uU2vth5Yzy0AGue9dpizAjd19lEaROOtxggtP2
    2pE+V50o7rJFbWRRgxwZ47xFpt0dGKSdr+uvNPYkKGfp6dAthjwqG/OT1UoAOacI
    Or20ZDvlt9G2/jKBywm8oBViygr2tHvN+0WEX6jSffwg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752275AbeCWKx6 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:53:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44902 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755860AbeCWKNj (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:13:39 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 09/97] rtc: cmos: Do not assume irq 8 for rtc when there are no legacy irqs
Date: Fri, 23 Mar 2018 10:53:56 +0100
Message-Id: <20180323094158.028433526@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>


[ Upstream commit a1e23a42f1bdc00e32fc4869caef12e4e6272f26 ]

On some systems (e.g. Intel Bay Trail systems) the legacy PIC is not
used, in this case virq 8 will be a random irq, rather then hw_irq 8
from the PIC.

Requesting virq 8 in this case will not help us to get alarm irqs and
may cause problems for other drivers which actually do need virq 8,
for example on an Asus Transformer T100TA this leads to:

[ 28.745155] genirq: Flags mismatch irq 8. 00000088 (mmc0) vs. 00000080 (rtc0)
<snip oops>
[ 28.753700] mmc0: Failed to request IRQ 8: -16
[ 28.975934] sdhci-acpi: probe of 80860F14:01 failed with error -16

This commit fixes this by making the rtc-cmos driver continue
without using an irq rather then claiming irq 8 when no irq is
specified in the pnp-info and there are no legacy-irqs.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/rtc/rtc-cmos.c |   17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -41,6 +41,9 @@
 #include <linux/pm.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
+#ifdef CONFIG_X86
+#include <asm/i8259.h>
+#endif
 
 /* this is for "generic access to PC-style RTC" using CMOS_READ/CMOS_WRITE */
 #include <asm-generic/rtc.h>
@@ -1058,17 +1061,23 @@ static int cmos_pnp_probe(struct pnp_dev
 {
 	cmos_wake_setup(&pnp->dev);
 
-	if (pnp_port_start(pnp, 0) == 0x70 && !pnp_irq_valid(pnp, 0))
+	if (pnp_port_start(pnp, 0) == 0x70 && !pnp_irq_valid(pnp, 0)) {
+		unsigned int irq = 0;
+#ifdef CONFIG_X86
 		/* Some machines contain a PNP entry for the RTC, but
 		 * don't define the IRQ. It should always be safe to
-		 * hardcode it in these cases
+		 * hardcode it on systems with a legacy PIC.
 		 */
+		if (nr_legacy_irqs())
+			irq = 8;
+#endif
 		return cmos_do_probe(&pnp->dev,
-				pnp_get_resource(pnp, IORESOURCE_IO, 0), 8);
-	else
+				pnp_get_resource(pnp, IORESOURCE_IO, 0), irq);
+	} else {
 		return cmos_do_probe(&pnp->dev,
 				pnp_get_resource(pnp, IORESOURCE_IO, 0),
 				pnp_irq(pnp, 0));
+	}
 }
 
 static void __exit cmos_pnp_remove(struct pnp_dev *pnp)
