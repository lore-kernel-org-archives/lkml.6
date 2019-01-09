Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500A9C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 04:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D1EC20883
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 04:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbfAIEK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 23:10:59 -0500
Received: from [223.203.96.18] ([223.203.96.18]:35253 "EHLO
        barracuda02.hxt-semitech.com" rhost-flags-FAIL-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728398AbfAIEK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 23:10:59 -0500
X-Greylist: delayed 862 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Jan 2019 23:10:58 EST
X-ASG-Debug-ID: 1547006192-107606139f168010001-xx1T2L
Received: from HXTBJIDCEMVIW02.hxtcorp.net ([10.128.0.15]) by barracuda02.hxt-semitech.com with ESMTP id 5EThfOD1x4QWd1H3 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 09 Jan 2019 11:56:33 +0800 (CST)
X-Barracuda-Envelope-From: yuanyuan.zhao@hxt-semitech.com
Received: from localhost.localdomain.localdomain (10.64.5.29) by
 HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 9 Jan 2019 11:56:26 +0800
From:   Zhao Yuanyuan <yuanyuan.zhao@hxt-semitech.com>
To:     <marc.zyngier@arm.com>
CC:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <yu.zheng@hxt-semitech.com>, <dongsheng.wang@hxt-semitech.com>,
        Zhao Yuanyuan <yuanyuan.zhao@hxt-semitech.com>
Subject: [RESEND 1/1] gic: its: Make sure a LPI is discarded before free.
Date:   Wed, 9 Jan 2019 11:53:27 +0800
X-ASG-Orig-Subj: [RESEND 1/1] gic: its: Make sure a LPI is discarded before free.
Message-ID:
 <e37e3f5e0146be65c60092a457ca5c82e25581a0.1545292748.git.yuanyuan.zhao@hxt-semitech.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.64.5.29]
X-ClientProxiedBy: HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14) To
 HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15)
X-Barracuda-Connect: UNKNOWN[10.128.0.15]
X-Barracuda-Start-Time: 1547006193
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA384
X-Barracuda-URL: https://192.168.50.102:443/cgi-mod/mark.cgi
X-Barracuda-Scan-Msg-Size: 835
X-Virus-Scanned: by bsmtpd at hxt-semitech.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: SPAM GLOBAL 0.9335 1.0000 3.5889
X-Barracuda-Spam-Score: 4.19
X-Barracuda-Spam-Status: No, SCORE=4.19 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=MARKETING_SUBJECT
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.65361
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.60 MARKETING_SUBJECT      Subject contains popular marketing words
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20190109035327.inWbzG5B-UJhAbhnN9Gz4J2UZqENEk88m0yBbQxJPxk@z>

Its device will be removed after all events be freed.
Undisarded events can lead to unpredictable behaviar.

Signed-off-by: Zhao Yuanyuan <yuanyuan.zhao@hxt-semitech.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index db20e99..4fee008 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2572,6 +2572,10 @@ static void its_irq_domain_free(struct irq_domain *domain, unsigned int virq,
 								virq + i);
 		u32 event = its_get_event_id(data);
 
+		/* Discard irq before free */
+		if (irqd_is_activated(d))
+			its_send_discard(its_dev, event);
+
 		/* Mark interrupt index as unused */
 		clear_bit(event, its_dev->event_map.lpi_map);
 
-- 
1.8.3.1

