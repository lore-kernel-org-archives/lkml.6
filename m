Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CDFC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04C762083E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dBrHmwsU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04C762083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbeJRR5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 13:57:34 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:58937 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbeJRR5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 13:57:33 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181018095717euoutp0244b3117ec04057e0f96e184197362be3~eq3QpAt2j3210732107euoutp02q;
        Thu, 18 Oct 2018 09:57:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181018095717euoutp0244b3117ec04057e0f96e184197362be3~eq3QpAt2j3210732107euoutp02q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539856638;
        bh=23R/J6B8yoCfPOWlxldxP5D7mXL7n7ZMaMuWjzEhIWQ=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=dBrHmwsUvh/Emgqaf1MT1jV5kIXzQO2P6ajX08nU9XWBCn7i/oLIvaOFBmfKIs+8z
         XnmkVvViXf2k0RVF2f94zd2fUKIL1c+fK+PrxaJy0kkSicn/CWdco5Y3UpAeob0iJl
         3Th9Mx2gj+GRBruGfl7aGxD7IWkutIzZA1VfcOno=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181018095717eucas1p1d3672ab28cff9ac1551d45b80ea4a18a~eq3QKIJ891223412234eucas1p10;
        Thu, 18 Oct 2018 09:57:17 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 8E.D1.04294.DF858CB5; Thu, 18
        Oct 2018 10:57:17 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181018095716eucas1p103fb0d1a19c6122e885b15526c176967~eq3Pc6OL01224112241eucas1p1j;
        Thu, 18 Oct 2018 09:57:16 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-fc-5bc858fd08bb
Received: from eusync3.samsung.com ( [203.254.199.213]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id FC.D2.04284.CF858CB5; Thu, 18
        Oct 2018 10:57:16 +0100 (BST)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
        eusync3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PGS00GLZGZA2H50@eusync3.samsung.com>;
        Thu, 18 Oct 2018 10:57:16 +0100 (BST)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v4 2/6] clocksource: exynos_mct: Fix error path in timer
 resources initialization
Date:   Thu, 18 Oct 2018 11:57:04 +0200
Message-id: <20181018095708.1527-3-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20181018095708.1527-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsWy7djPc7p/I05EG2yawW2xccZ6Vov3y3oY
        La5/ec5qMe+zrMWk+xNYLM6f38BusenxNVaLy7vmsFnMOL+PyWLtkbvsFn/v/GOzWHr9IpPF
        5k1TmS1efjzB4sDnsWbeGkaPTas62TzuXNvD5vHu3Dl2j81L6j36tqxi9Pi8SS6APYrLJiU1
        J7MstUjfLoEr4+eGi+wFX7kq7p7YxdTAOJezi5GTQ0LARGLCq71sILaQwApGidP9Fl2MXED2
        Z0aJPS8/McMU3Tzdxw6RWMYocev/YRYIp4FJ4u+GE2DtbAKGEl1vu8BsEYFsic7HDxhBipgF
        TjJL/Lu5iR0kISyQLHHr3l1WEJtFQFVi84LnTCA2r4CNxO01Vxkh1slLrN5wAGw1p4CtxJn5
        78C2SQgcYZP4fPYoG0SRi8SV/jPsELawxKvjW6BsGYnOjoNMEA3NjBLtM2axQzg9jBJb5+yA
        6raWOHz8ItgZzAJ8EpO2TQdaxwEU55XoaBOCKPGQmDbvDRvEnxMYJa5sW8w+gVFyASPDKkbx
        1NLi3PTUYqO81HK94sTc4tK8dL3k/NxNjMDYPv3v+JcdjLv+JB1iFOBgVOLhfZB6PFqINbGs
        uDL3EKMEB7OSCG+12YloId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzL5m2MFhJITyxJzU5NLUgt
        gskycXBKNTDK6cdzS9V4Vf67uvmi/7tmWYvGtOPHO27Zmp986rYqSyArLOGu2dS+BMk3xUl/
        ZRYcPNl+LdOltnHCtQn3g9+VzlQJ8HO32533vE3vYD+P+qTPl+Q9C54GnJR+/Ve5V/2yjc39
        dcf83Q+xb1gT0JdQmTF//bM8recH8u7Mqb/wvuXYVKFpR9YrsRRnJBpqMRcVJwIAaGnTcukC
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrELMWRmVeSWpSXmKPExsVy+t/xq7p/Ik5EG1ybqG2xccZ6Vov3y3oY
        La5/ec5qMe+zrMWk+xNYLM6f38BusenxNVaLy7vmsFnMOL+PyWLtkbvsFn/v/GOzWHr9IpPF
        5k1TmS1efjzB4sDnsWbeGkaPTas62TzuXNvD5vHu3Dl2j81L6j36tqxi9Pi8SS6APYrLJiU1
        J7MstUjfLoEr4+eGi+wFX7kq7p7YxdTAOJezi5GTQ0LAROLm6T52EFtIYAmjxL3eqC5GLiC7
        iUmia2cjC0iCTcBQouttFxuILSKQLTF/bzc7SBGzwElmiUuP34EVCQskS9y6d5cVxGYRUJXY
        vOA5E4jNK2AjcXvNVUaIbfISqzccYAaxOQVsJc7Mh+gVAqrp/rOefQIjzwJGhlWMIqmlxbnp
        ucWGesWJucWleel6yfm5mxiBIbnt2M/NOxgvbQw+xCjAwajEw/sg9Xi0EGtiWXFl7iFGCQ5m
        JRHearMT0UK8KYmVValF+fFFpTmpxYcYpTlYlMR5zxtURgkJpCeWpGanphakFsFkmTg4pRoY
        ZdONLE6G+S/kfSnou2mOeSDPJO9XrHmWP+dlZvBduq7+7Y9hcnvOux+P7uUkiP7OkbrMkFye
        KP1Hf///+ksx0S+tvc89zJjpfF71xZ5E9QDXD6+WOqiutO5kNkg6oSW+IVPbLaVeQVU0vXj3
        GV+HXlaeR5t691mrGM1fUr73y4vc8y4J+68osRRnJBpqMRcVJwIAH9crDEUCAAA=
X-CMS-MailID: 20181018095716eucas1p103fb0d1a19c6122e885b15526c176967
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181018095716eucas1p103fb0d1a19c6122e885b15526c176967
References: <20181018095708.1527-1-m.szyprowski@samsung.com>
        <CGME20181018095716eucas1p103fb0d1a19c6122e885b15526c176967@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While freeing interrupt handlers in error path, don't assume that all
requested interrupts are per-processor interrupts and properly release
standard interrupts too.

Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
Fixes: 56a94f13919c ("clocksource: exynos_mct: Avoid blocking calls in the cpu hotplug notifier")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/clocksource/exynos_mct.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index ef18bbf8d20c..49413900b24c 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -561,7 +561,19 @@ static int __init exynos4_timer_resources(struct device_node *np, void __iomem *
 	return 0;
 
 out_irq:
-	free_percpu_irq(mct_irqs[MCT_L0_IRQ], &percpu_mct_tick);
+	if (mct_int_type == MCT_INT_PPI) {
+		free_percpu_irq(mct_irqs[MCT_L0_IRQ], &percpu_mct_tick);
+	} else {
+		for_each_possible_cpu(cpu) {
+			struct mct_clock_event_device *pcpu_mevt =
+				per_cpu_ptr(&percpu_mct_tick, cpu);
+
+			if (pcpu_mevt->evt.irq != -1) {
+				free_irq(pcpu_mevt->evt.irq, pcpu_mevt);
+				pcpu_mevt->evt.irq = -1;
+			}
+		}
+	}
 	return err;
 }
 
-- 
2.17.1

