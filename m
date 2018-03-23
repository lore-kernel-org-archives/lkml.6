Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1182164-1521806881-2-10089757724074870045
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
    t=1521806880; b=NbO5iy/cBrXB1Wg0KQPsZkj5ExVjDjEknUJR6g6qwa4DB9d
    5Zs1oQq+gYWE7d9/VCt7bfG7cuX7Uus7uN2iXrBD02t8BeOAAv4EAnLqZqx4zueb
    /tpkyVaOXh6vjYP+ny26XpXsbelZq4Cae9K9KWzewy6fJajP23OfSpYEUrowQTg6
    cK5A6+FPF6veCQedpFMseMLr4/ZeoqscL1Rul4ohaFav9ptsWJs3h95maDfHJrGD
    onNy/w8KajRGOa6yNATq3xPkawnXTPpD2AYnaNUXyXxFyWz70HxKmtrEjQypDf6O
    v+yUxfCxHV+Ibx3XB0muVwm52r3cNoilIPTdErg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521806880; bh=SDhnAWy1PLuU1yJi6xfjxtLbor
    Eswfe8Tl6CFXfZ1w4=; b=A+Ut4vb8H+HkjNh7jH95sKETFsI5dPoiN07vEZQR7K
    EtzKdHlPWNrwM+Np391yx6X2dEpsj+Zlkll4UUPK6XKROAcmjl9OAhWciXz41CP8
    1564R4gEJ5f6dbgpw+KSySEQhl+M8LXPRcp5I5f5oR9jaVACOfu1ap97TvHzYmNG
    TdrVsJUqm0MTbBwe3QXHicqpgAtTzA2X+e2rLxuFdNtmQjbrBI7zNTPUrhTRUO7q
    23wKUz4MD/IIIRvOwjMNlggb6VYjX6LlywfRbXS60sKUyPuVbJIFqNgh2R8SHTaP
    t6/BeClx1McbnOGYzzpK5c4QhcAEWmLuJ8bJY8etJkmg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
        id S1753177AbeCWJ6o (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 05:58:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35814 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753150AbeCWJ6l (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 05:58:41 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robert Walker <robert.walker@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 50/84] coresight: Fix disabling of CoreSight TPIU
Date: Fri, 23 Mar 2018 10:54:04 +0100
Message-Id: <20180323095419.563969489@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323095411.913234798@linuxfoundation.org>
References: <20180323095411.913234798@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Robert Walker <robert.walker@arm.com>


[ Upstream commit 11595db8e17faaa05fadc25746c870e31276962f ]

The CoreSight TPIU should be disabled when tracing to other sinks to allow
them to operate at full bandwidth.

This patch fixes tpiu_disable_hw() to correctly disable the TPIU by
configuring the TPIU to stop on flush, initiating a manual flush, waiting
for the flush to complete and then waits for the TPIU to indicate it has
stopped.

Signed-off-by: Robert Walker <robert.walker@arm.com>
Tested-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwtracing/coresight/coresight-tpiu.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -46,8 +46,11 @@
 #define TPIU_ITATBCTR0		0xef8
 
 /** register definition **/
+/* FFSR - 0x300 */
+#define FFSR_FT_STOPPED		BIT(1)
 /* FFCR - 0x304 */
 #define FFCR_FON_MAN		BIT(6)
+#define FFCR_STOP_FI		BIT(12)
 
 /**
  * @base:	memory mapped base address for this component.
@@ -85,10 +88,14 @@ static void tpiu_disable_hw(struct tpiu_
 {
 	CS_UNLOCK(drvdata->base);
 
-	/* Clear formatter controle reg. */
-	writel_relaxed(0x0, drvdata->base + TPIU_FFCR);
+	/* Clear formatter and stop on flush */
+	writel_relaxed(FFCR_STOP_FI, drvdata->base + TPIU_FFCR);
 	/* Generate manual flush */
-	writel_relaxed(FFCR_FON_MAN, drvdata->base + TPIU_FFCR);
+	writel_relaxed(FFCR_STOP_FI | FFCR_FON_MAN, drvdata->base + TPIU_FFCR);
+	/* Wait for flush to complete */
+	coresight_timeout(drvdata->base, TPIU_FFCR, FFCR_FON_MAN, 0);
+	/* Wait for formatter to stop */
+	coresight_timeout(drvdata->base, TPIU_FFSR, FFSR_FT_STOPPED, 1);
 
 	CS_LOCK(drvdata->base);
 }
