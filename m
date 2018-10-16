Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E69C169D4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 707EB20881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rt+Ro1nK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 707EB20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbeJPWri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:47:38 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:39274 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbeJPWrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:47:37 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181016145646euoutp02ed6851fc87a9ecc6eb1b6088aef09413~eHqKnUvLy0317003170euoutp02j
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 14:56:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181016145646euoutp02ed6851fc87a9ecc6eb1b6088aef09413~eHqKnUvLy0317003170euoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539701806;
        bh=vkNhkP6Pf3bAS0U4g+Ht9CEYBwZ0/+v0QfUAKe/DLQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rt+Ro1nK30YnU7wHcb9ilLzpE9ad0f1g+OOuzrDxAT0ivHJJ9XLkUPlTjJ6NhRgZT
         MVjYRmbMUblQqYLm1F+dwRe4OBggWe12Hl9rbGUCl5GraA174Wq4Y8AlUX3vMKQ1WI
         nct17Jg8lXarjGRDs5YZtgLw7+e9BOojcfg35bDw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181016145645eucas1p2d10b2a128ad1fd7355455a01ad911283~eHqJ5UH-02490024900eucas1p2v;
        Tue, 16 Oct 2018 14:56:45 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id AF.21.04806.D2CF5CB5; Tue, 16
        Oct 2018 15:56:45 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181016145644eucas1p2a75a10af4c741ded4836ddd9648a7289~eHqJJ1u9K2490024900eucas1p2u;
        Tue, 16 Oct 2018 14:56:44 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181016145644eusmtrp2056e60e106e6f1fc03a3d3120403e60c~eHqI6_bK53061930619eusmtrp2S;
        Tue, 16 Oct 2018 14:56:44 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-83-5bc5fc2dafa2
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id BC.AA.04128.C2CF5CB5; Tue, 16
        Oct 2018 15:56:44 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181016145644eusmtip275014cbca284398fecf10f9fc73af1c2~eHqIbDhp72763027630eusmtip22;
        Tue, 16 Oct 2018 14:56:44 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, corbet@lwn.net, b.zolnierkie@samsung.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH 04/11] Doc: thermal: new irq-mode for trip point
Date:   Tue, 16 Oct 2018 16:56:15 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539701782-26852-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSa0gUURTHuTM7s+Pi1DRandQ0FnoJbUVBQ2qpFE3UB78V+cHWHFZJ19pR
        ywqSynfJamA+clfbrdVFFHURNTXzkUj4DqvtnRKlFdgaKejarrPWt9/5nXPu/3K5FM7WEX5U
        gjZF0GnViUpSIWt+tjC8a9diX/Sej1X+XENJPcFNdWUjzuDYzBl7hwjO+GKC4OwZAVzjpAuq
        sswybrztPsk57vQi7uHLUYzL7OiVc1OfCshwmq811CK+teydnDe1f8P4Rmsuyb+daCf5JvN1
        3lRwl+Cf/mzH+AKbFfGOxsAoxRlFaJyQmJAm6HYfOquIz1uaxy8ssJdvDdbhGah8bR7yooDZ
        D68HzcjNLFONYMx4Pg8pXDyHoLhimZQKB4JPbeP46saNhj9IalgQLE62Ev9WOrqKXSsURTIq
        aLFedHtfphyBo9Mkdxc4M4DAbmnG3Ef5MOHwZHZa7mYZsxXma+sIKSIQXg/lrsR5MSfA/qrS
        E90pB1sN62aaSYPqKYtc8keg/2OpZ8YHpvttHh8Ay61GTGIRBnOspMTXIHugxTMTAj39o4T7
        0jizE+rbdks6At6ab65oYNbAqx/r3Bp3YVHzPVzSNORksdL0DrDdHvEEbQBLbbHncB6so0Oe
        5zEgKMq0YXoUVPY/rBIhK9oopIpJGkHcpxUuqUR1kpiq1ajOJSc1Itcveu7s/92COhdjuxFD
        IaU3Pf+yN5ol1GlielI3AgpX+tKasb5olo5Tp18RdMkxutREQexG/pRMuZF+ZGiIZhmNOkU4
        LwgXBN1qF6O8/DJQpN5aGlfzGcJmnhtMx68O+6PQEKcl7fSvTYVf8EpGH4slTFRtYAK+Hg0S
        CkdkS/Z0Hn8/TD1bKj8IsafAuWXPREPTyZiow+9D8tc/yDdn6YNVPSEnwmhyNrMsMWebj0Gz
        PWdmLCLOSB/73qWv8D7woU+BxUSyj53Kgbk3JUqZGK/eG4zrRPVfrCnOvEEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsVy+t/xe7o6f45GG3zcpG2xccZ6VosnB9oZ
        LeZ9lrWYf+Qcq8X8K9dYLW41yFhsegxkLGxbwmJxedccNovPvUcYLZZev8hk0br3CLvFk4d9
        bA68HmvmrWH02DnrLrvH4j0vmTw2repk87hzbQ+bx+Yl9R6L+yazehx8t4fJo2/LKkaPz5vk
        Arii9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DK6
        /v5gLvgpVNFydh1zA+Ns/i5GTg4JAROJpo3fGbsYuTiEBJYySvS0f2CCSIhJTNq3nR3CFpb4
        c62LDaLoE6PE4WNLgBIcHGwCehI7VhWCxEUE5jNKHN10GayIWeAyo0T3tD1g3cICDhL7P74C
        s1kEVCV+rFnHCmLzCnhJLPy7nQ1ig5zEzXOdzCA2p4C3xK0bC5hBFggB1VxczDiBkW8BI8Mq
        RpHU0uLc9NxiI73ixNzi0rx0veT83E2MwOjYduznlh2MXe+CDzEKcDAq8fD+uH4kWog1say4
        MvcQowQHs5IIb/qlo9FCvCmJlVWpRfnxRaU5qcWHGE2BbprILCWanA+M3LySeENTQ3MLS0Nz
        Y3NjMwslcd7zBpVRQgLpiSWp2ampBalFMH1MHJxSDYx7Ynq0LHs4FqolcUvNe5dyTVN/0UPt
        K8v3hd/M2JBrb/xEbId+ibVux7INKtcrLoXKmV7zuy6geVzjYrlg7vc3Ns6n6pX54jkf8i9M
        uee0xu70agPZJXevvXX/KbFs25mW68uaztsw9V4/OfFC7n1BxTnunqmzhZ+q3d7KGWyxK2gG
        s0iwC7cSS3FGoqEWc1FxIgBo3GSWpAIAAA==
Message-Id: <20181016145644eucas1p2a75a10af4c741ded4836ddd9648a7289~eHqJJ1u9K2490024900eucas1p2u@eucas1p2.samsung.com>
X-CMS-MailID: 20181016145644eucas1p2a75a10af4c741ded4836ddd9648a7289
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181016145644eucas1p2a75a10af4c741ded4836ddd9648a7289
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181016145644eucas1p2a75a10af4c741ded4836ddd9648a7289
References: <1539701782-26852-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181016145644eucas1p2a75a10af4c741ded4836ddd9648a7289@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thermal trip point gets new flag in DT: irq-mode.
Trip point may have a new explicit flag which indicate
irq support when the temperature is met (so the thermal framework
deos not need set polling for it).
It is useful for 'passive' cooling trip point,
which now will not be register for polling the temperature.

Update documentation about irq-mode for trip points.
The new sysfs file shows 1 if the trip point supports irq.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-doc@vger.kernel.org
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 Documentation/thermal/sysfs-api.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
index 9113997..e405724 100644
--- a/Documentation/thermal/sysfs-api.txt
+++ b/Documentation/thermal/sysfs-api.txt
@@ -272,6 +272,7 @@ Thermal zone device sys I/F, created once it's registered:
     |---trip_point_[0-*]_temp:	Trip point temperature
     |---trip_point_[0-*]_type:	Trip point type
     |---trip_point_[0-*]_hyst:	Hysteresis value for this trip point
+    |---trip_point_[0-*]_irq:	Trip point supports triggering irq
     |---emul_temp:		Emulated temperature set node
     |---sustainable_power:      Sustainable dissipatable power
     |---k_po:                   Proportional term during temperature overshoot
@@ -365,6 +366,10 @@ trip_point_[0-*]_type
 	thermal zone.
 	RO, Optional
 
+trip_point_[0-*]_irq
+	Boolean which indicate that the trip point triggers irq.
+	RO, Optional
+
 trip_point_[0-*]_hyst
 	The hysteresis value for a trip point, represented as an integer
 	Unit: Celsius
@@ -544,12 +549,16 @@ method, the sys I/F structure will be built like this:
     |---available_policies:	step_wise fair_share
     |---trip_point_0_temp:	100000
     |---trip_point_0_type:	critical
+    |---trip_point_0_irq:	1
     |---trip_point_1_temp:	80000
     |---trip_point_1_type:	passive
+    |---trip_point_1_irq:	1
     |---trip_point_2_temp:	70000
     |---trip_point_2_type:	active0
+    |---trip_point_2_irq:	0
     |---trip_point_3_temp:	60000
     |---trip_point_3_type:	active1
+    |---trip_point_3_irq:	1
     |---cdev0:			--->/sys/class/thermal/cooling_device0
     |---cdev0_trip_point:	1	/* cdev0 can be used for passive */
     |---cdev0_weight:           1024
-- 
2.7.4

