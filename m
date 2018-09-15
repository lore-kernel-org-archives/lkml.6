Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85ECECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70188208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="boVS+pd8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70188208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbeIOG4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:56:45 -0400
Received: from mail-by2nam01on0130.outbound.protection.outlook.com ([104.47.34.130]:13056
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729612AbeIOGvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vf2FAFtZK9nwaneoVyxo2iEpurZmrPk4gk8HnrLIdSY=;
 b=boVS+pd8KHmVYqPhlpgZ+EDTP7W748xXxRS4J5D7fBozAllgT6Df6zAadi8hYN9P/Y6xcH2RtfKU9oBqkDg878nELS0BM6EUA6oaYFa31nKsje38jh5aM5V47Dzw+YKmg7zI+2EWN9BI8J2x51Z/3JdG7Kzwbp69uQJMg/Kt4Io=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0823.namprd21.prod.outlook.com (10.173.192.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Sat, 15 Sep 2018 01:34:37 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:34:37 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Robin Murphy <robin.murphy@arm.com>,
        Robert Walker <robert.walker@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 19/34] coresight: tpiu: Fix disabling timeouts
Thread-Topic: [PATCH AUTOSEL 4.9 19/34] coresight: tpiu: Fix disabling
 timeouts
Thread-Index: AQHUTJRDvXu6c07yW0qoc4U69IcyLw==
Date:   Sat, 15 Sep 2018 01:34:37 +0000
Message-ID: <20180915013422.180023-19-alexander.levin@microsoft.com>
References: <20180915013422.180023-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013422.180023-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0823;6:mlXJ5Bg/EABriSie3gcHmlEqDz/tpxBkq3d7pKXvhGHM2iFj1IYtBYhdB2ponf20+/2sef8gkxR+dJ2CUrkWBNsDU4ihJtyax3cnV4Tk4YffWjiEElsDn8B/lty6VwgmgHvjjFRpm15r7zfTmtAgYxPKynLx8UuXi3SlINHHqDGlarcCp9+VmVAALEVua//uTMNqCoDwcvsVCSrPKo2LWHY6XPwJeLjECoHNu1NEZZCr3D44y8QL6hPAJdpmU0BA55GN63qlSAASHRYWS1F9/pUs3f2b9WPCooEz0HsITU07FkU7ECjZ1HRNv42C7zScq6LBBeB43vd2HBrTAq2dnRUT/oT0UFQyP9OQ1PDk/1ab0wOAQizMQ+1uvUuJ7lzNOn3oe48+CfTB0+7PXhKWapDjwCQoxJQNMXlrcpP3j9pmxLxsH8MhAHo2fbcS+2NkH4aoNe7emmUVcapzHztOHA==;5:07zbD82ipuGoJRpQN8gbnsgzoMXJlQXYZgQIztKzVT7sLT+L0+P+OPVeHE/wpzULNEwEAiC5EwIfXBbWf0Juy7whJETVhtZkFJ7IbW7IqwV31y8JDpSUm6MDesGSRAFAj+aZNo38cAbjc5c/MbEfBCoDy0BegMxAALcNy4XvnkQ=;7:aW4/mA62jlR3cWNGek/W/O6iSWwwe6SwTlcnaLfxerxjFdXkWX2U6h1REZVz74ZtQOPqRTeNob5/QfeAexkbm2THX9yxiW9M8wWF7dpPidtH/MxmuUYtxuZnLY8LYFVnfSlhJ4PqQXEdj3kGf8Ad2S172IMi3VvnD0EmgnpmvtJfI07qp36OtsJxT2jOssFjiZgfKF5eOuJu+JGHIs8/94uOCHSpR6OAdlYQB04ZEE48Iov38wELwFRpCVgxFuFy
x-ms-office365-filtering-correlation-id: 61ab8ac4-cef0-415b-ac51-08d61aab6651
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0823;
x-ms-traffictypediagnostic: CY4PR21MB0823:
x-microsoft-antispam-prvs: <CY4PR21MB08231C750D8752161EE9E277FB180@CY4PR21MB0823.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0823;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0823;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(136003)(39860400002)(366004)(189003)(199004)(53936002)(14454004)(2900100001)(3846002)(6116002)(14444005)(256004)(10290500003)(81166006)(81156014)(217873002)(76176011)(72206003)(478600001)(8936002)(25786009)(8676002)(86362001)(66066001)(6512007)(86612001)(7736002)(305945005)(97736004)(11346002)(5660300001)(5250100002)(102836004)(54906003)(2616005)(446003)(6436002)(6506007)(476003)(186003)(110136005)(2501003)(2906002)(105586002)(22452003)(10090500001)(36756003)(4326008)(68736007)(26005)(107886003)(6486002)(486006)(106356001)(1076002)(6346003)(316002)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0823;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: IbHhgk9QnFuNpAE1Ii9DlI+rUD6LzsWa6YIe1triLDza/UyHcY19KIL0nhPtniasL3I8XUHGP9X1SJx5AMc+lqC+XD5DEH/iIjdmFD1OatKs7/z1gZJh5LPGqLGdjNgoVPVSExMgZ1YbGq0oIrfI1GeIy7+uCVbK/c9GBFdB1Ui88j71pVlF3/G7M3Wv4CSDH6ejhvpQ1j2wJY/XbAaNOMZvyyUzU6xFvFdyLCFzlK9P/QLLA0G/AbpxR413RLV0A08WJcbesh52+HkznjXg2miqblKtU2K3p9rdLIDuT6H8zqrckf3NZxY2PfwQVFNSu1mxG2nTdi37f4iftiCEQ2sWU+FRFUMEpqn2L3Njrdc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61ab8ac4-cef0-415b-ac51-08d61aab6651
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:34:37.6924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0823
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin Murphy <robin.murphy@arm.com>

[ Upstream commit ccff2dfaceaca4517432f5c149594215fe9098cc ]

Probing the TPIU driver under UBSan triggers an out-of-bounds shift
warning in coresight_timeout():

...
[    5.677530] UBSAN: Undefined behaviour in drivers/hwtracing/coresight/co=
resight.c:929:16
[    5.685542] shift exponent 64 is too large for 64-bit type 'long unsigne=
d int'
...

On closer inspection things are exponentially out of whack because we're
passing a bitmask where a bit number should be. Amusingly, it seems that
both calls will find their expected values by sheer luck and appear to
succeed: 1 << FFCR_FON_MAN ends up at bit 64 which whilst undefined
evaluates as zero in practice, while 1 << FFSR_FT_STOPPED finds bit 2
(TCPresent) which apparently is usually tied high.

Following the examples of other drivers, define separate FOO and FOO_BIT
macros for masks vs. indices, and put things right.

CC: Robert Walker <robert.walker@arm.com>
CC: Mike Leach <mike.leach@linaro.org>
CC: Mathieu Poirier <mathieu.poirier@linaro.org>
Fixes: 11595db8e17f ("coresight: Fix disabling of CoreSight TPIU")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/hwtracing/coresight/coresight-tpiu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtraci=
ng/coresight/coresight-tpiu.c
index ff579a7c6d00..7473c6ea99e9 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -47,8 +47,9 @@
=20
 /** register definition **/
 /* FFSR - 0x300 */
-#define FFSR_FT_STOPPED		BIT(1)
+#define FFSR_FT_STOPPED_BIT	1
 /* FFCR - 0x304 */
+#define FFCR_FON_MAN_BIT	6
 #define FFCR_FON_MAN		BIT(6)
 #define FFCR_STOP_FI		BIT(12)
=20
@@ -93,9 +94,9 @@ static void tpiu_disable_hw(struct tpiu_drvdata *drvdata)
 	/* Generate manual flush */
 	writel_relaxed(FFCR_STOP_FI | FFCR_FON_MAN, drvdata->base + TPIU_FFCR);
 	/* Wait for flush to complete */
-	coresight_timeout(drvdata->base, TPIU_FFCR, FFCR_FON_MAN, 0);
+	coresight_timeout(drvdata->base, TPIU_FFCR, FFCR_FON_MAN_BIT, 0);
 	/* Wait for formatter to stop */
-	coresight_timeout(drvdata->base, TPIU_FFSR, FFSR_FT_STOPPED, 1);
+	coresight_timeout(drvdata->base, TPIU_FFSR, FFSR_FT_STOPPED_BIT, 1);
=20
 	CS_LOCK(drvdata->base);
 }
--=20
2.17.1
