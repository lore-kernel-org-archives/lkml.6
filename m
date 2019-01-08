Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38E1C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6847F206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="YttKn1X/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbfAHK4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 05:56:32 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:33316 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbfAHK4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 05:56:31 -0500
X-IronPort-AV: E=Sophos;i="5.56,453,1539673200"; 
   d="scan'208";a="22335034"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 Jan 2019 03:56:30 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 8 Jan 2019 03:56:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxkZa9nA/bv+2ZamBOfPn1B/WEZr148ZjJQ8WZkDHts=;
 b=YttKn1X/gffiKpEAaJju8gUHc3aSygfolkI9HZxk9K4IJlSjWMNjyERNUgAIGF0qES3+FP1EJpns4gyVuK9csg8ce+XbasNXPb/OF6C4B+PjV5Ivve/QrERdYUOHXxOY+TlAklOKnnzQp6OTcPvtYK7tbFIGzbrc7ZifaaeTTZU=
Received: from CY4PR11MB1909.namprd11.prod.outlook.com (10.175.61.147) by
 CY4PR11MB1399.namprd11.prod.outlook.com (10.173.17.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.9; Tue, 8 Jan 2019 10:56:29 +0000
Received: from CY4PR11MB1909.namprd11.prod.outlook.com
 ([fe80::5478:c9ff:e5b2:2b4e]) by CY4PR11MB1909.namprd11.prod.outlook.com
 ([fe80::5478:c9ff:e5b2:2b4e%9]) with mapi id 15.20.1495.011; Tue, 8 Jan 2019
 10:56:29 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <linux@armlinux.org.uk>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <rjw@rjwysocki.net>,
        <pavel@ucw.cz>, <len.brown@intel.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH v2 1/3] PM / Suspend: Add support to check if platform's power
 is off in suspend
Thread-Topic: [PATCH v2 1/3] PM / Suspend: Add support to check if platform's
 power is off in suspend
Thread-Index: AQHUp0DOM7WMwuf4TU6Qg1UGEhg3kQ==
Date:   Tue, 8 Jan 2019 10:56:29 +0000
Message-ID: <1546944944-13911-2-git-send-email-claudiu.beznea@microchip.com>
References: <1546944944-13911-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1546944944-13911-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR04CA0113.eurprd04.prod.outlook.com
 (2603:10a6:803:64::48) To CY4PR11MB1909.namprd11.prod.outlook.com
 (2603:10b6:903:11f::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR11MB1399;6:pGE9I4sJ+TJekKlBbjJkL5i6RMw0auPLJcr9DlU3ocMCwj/bhmnXdnpCjDVk6Z5AVG7O4TaoQhjCFaV58+AGOP/HleuKwYOY8AFfoq82/wSN0R/48Lg2ggwMdMhbQNrSU7vKMXY3HqioZwUiEpHMZ+u+a4flCG0VTKx15dq6h/C9Mtuz7p8gXYa+qGIff7/rV6t7uOiPGlGxSNDQa8eH2D0pXCkgD/IKzn89uJ5wsMfgl5zg9ve7lRClKQutua6xA4mWUidybE7Qx/2sYPj36crsGYoo0qQrfcSZSLgO5Y7/ppjGUxaqCuEOc35+qDb4/RFP1xPCF7zFoNNZ78+Hrr40nPilJ2udBIMD8QOqyPIjQnF+iNERB+U7C5T6pbmapz8zLbM+kTsEMnjkcpONbi26sCqp2U48Ph6R4W3D7USP48PyPXnNa/Wfl3zbPQDyXoqohALqO+bGvMGlBuGLRQ==;5:3Z9YwSlG7YN+BuwK0rGrM9Mf5DdLvxx2vRkT4RmSF6apaRGotneaD+oqPRxkvQ7td6qG19spYHS4q0XmavBqj94zV+vQBsWDXd4v3Cx/1WTBDGzY+3f2aC65qK3c2INIUg3g0RXz7uUiMUEoRtTJSBQfDfx91OlNYOVgXsQfRt86J1GGJdHgDHOvzcZlHKxTST0h/EwE0KH929rv6OHY9g==;7:GC1I9CNyz68FyBscPD5anyT+x0U/YUXoRs7OVRi+u0Zorh5mgmpgy1C/1T1bAzplggrL9/aLFBevc8YzmqDvj6qtLT4SLCWhUktE6p1MjOLH9TqmJqQCfR69OPFD4/ouNzRZhqV/uopMlzOV39wWbA==
x-ms-office365-filtering-correlation-id: 08bc4f42-f8ab-45c7-7ab0-08d67557f122
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR11MB1399;
x-ms-traffictypediagnostic: CY4PR11MB1399:
x-microsoft-antispam-prvs: <CY4PR11MB139963C7BA5A0B1AAFC366BB878A0@CY4PR11MB1399.namprd11.prod.outlook.com>
x-forefront-prvs: 0911D5CE78
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(346002)(396003)(366004)(189003)(199004)(6512007)(72206003)(8936002)(2616005)(476003)(102836004)(478600001)(11346002)(97736004)(36756003)(256004)(575784001)(14444005)(86362001)(71190400001)(2906002)(71200400001)(66066001)(3846002)(6116002)(2201001)(316002)(54906003)(186003)(2501003)(110136005)(305945005)(7736002)(14454004)(446003)(6486002)(6436002)(8676002)(7416002)(6506007)(386003)(81156014)(81166006)(5660300001)(25786009)(99286004)(26005)(39060400002)(107886003)(15650500001)(106356001)(105586002)(76176011)(52116002)(68736007)(4326008)(486006)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR11MB1399;H:CY4PR11MB1909.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pnRgqE5h8A70thdxtDiV16ezvMa7t69J+RivdNuWkshvY12G0XgiOHwq23ePXXk80ONkM8t/MA+HsC2qRRfj8YRhJSUZ8JMaM7Lc59nNQN1Zs9sCidQyiIJRhS+Hthxldg7sAqbPgzrfnUdhWLpcCrwmUNi3WvzwAgviu6YgOMRGdSCs24DS1ZcCiPP6Gs+9DYHMb+R3hj80YqsXLC6aacK26z9aa+832u4ogJHiW+UNqAwiVkFM9CkeQbWFsFMIQmm4/puRGT1/XtVrUhgKAulk9H7IZgfhae+r7so+u1iIdZ8hw6wzNmrquFTo4lW9
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 08bc4f42-f8ab-45c7-7ab0-08d67557f122
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2019 10:56:29.0176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1399
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add support to check if platform's power will be cut off in suspend.
This will help drivers shared by multiple platforms to take only the
necessary actions while suspending/resuming (some platform may not need
to save/restore all the registers if platforms remains powered while
suspended). In this way suspend/resume time could be improved.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 include/linux/suspend.h |  6 ++++++
 kernel/power/suspend.c  | 13 +++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 3f529ad9a9d2..21f19b167fe2 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -173,6 +173,9 @@ static inline void dpm_save_failed_step(enum suspend_st=
at_step step)
  *	Called by the PM core if the suspending of devices fails.
  *	This callback is optional and should only be implemented by platforms
  *	which require special recovery actions in that situation.
+ *
+ * @off_in_suspend: Returns wether the platform's power will be cut off at
+ *	the end of suspend procedure or not.
  */
 struct platform_suspend_ops {
 	int (*valid)(suspend_state_t state);
@@ -185,6 +188,7 @@ struct platform_suspend_ops {
 	bool (*suspend_again)(void);
 	void (*end)(void);
 	void (*recover)(void);
+	bool (*off_in_suspend)(suspend_state_t state);
 };
=20
 struct platform_s2idle_ops {
@@ -275,6 +279,7 @@ extern void arch_suspend_disable_irqs(void);
 extern void arch_suspend_enable_irqs(void);
=20
 extern int pm_suspend(suspend_state_t state);
+extern bool platform_off_in_suspend(suspend_state_t state);
 #else /* !CONFIG_SUSPEND */
 #define suspend_valid_only_mem	NULL
=20
@@ -287,6 +292,7 @@ static inline bool pm_suspend_via_s2idle(void) { return=
 false; }
=20
 static inline void suspend_set_ops(const struct platform_suspend_ops *ops)=
 {}
 static inline int pm_suspend(suspend_state_t state) { return -ENOSYS; }
+static inline bool platform_off_in_suspend(suspend_state_t state) { return=
 false; }
 static inline bool idle_should_enter_s2idle(void) { return false; }
 static inline void __init pm_states_init(void) {}
 static inline void s2idle_set_ops(const struct platform_s2idle_ops *ops) {=
}
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 0bd595a0b610..e1f60c8a17b9 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -319,6 +319,19 @@ static bool platform_suspend_again(suspend_state_t sta=
te)
 		suspend_ops->suspend_again() : false;
 }
=20
+/**
+ * platform_off_in_suspend() - specifies if SoC's power will pe cut off at=
 the
+ * end of suspend procedure.
+ */
+bool platform_off_in_suspend(suspend_state_t state)
+{
+	if (!suspend_ops || !suspend_ops->off_in_suspend)
+		return false;
+
+	return suspend_ops->off_in_suspend(state);
+}
+EXPORT_SYMBOL_GPL(platform_off_in_suspend);
+
 #ifdef CONFIG_PM_DEBUG
 static unsigned int pm_test_delay =3D 5;
 module_param(pm_test_delay, uint, 0644);
--=20
2.7.4

