Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F57CECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD82208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="j8xUd5QF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AD82208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbeIOG47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:56:59 -0400
Received: from mail-by2nam01on0130.outbound.protection.outlook.com ([104.47.34.130]:13056
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728819AbeIOGvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yhJHpJJAHcS/A6qf7rgHUpJY6PV+dyBKmD3pzzcIX0c=;
 b=j8xUd5QFmhhexS6cHMGOty1v0TENnOt/8+VUCWA+fWIu1TK6dQeMyX4wc3Jqopw7me4GUSYqWkGC/+QsTAbGzwqMOtZB8mZ9bJ+OkjbX39bobc2Fpo8eyneYDfhngiG9i7DFVprnR7oGRwB2uQpJco7T5RAkr48ryVeZ3+D4kmg=
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
CC:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 18/34] coresight: Handle errors in finding
 input/output ports
Thread-Topic: [PATCH AUTOSEL 4.9 18/34] coresight: Handle errors in finding
 input/output ports
Thread-Index: AQHUTJRD2BowUGIYCk+h32JwXMcStg==
Date:   Sat, 15 Sep 2018 01:34:36 +0000
Message-ID: <20180915013422.180023-18-alexander.levin@microsoft.com>
References: <20180915013422.180023-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013422.180023-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0823;6:FxUWeeJ+ij/d7bU1mhc2eR9DWP+pleRJnQ3QHR7MswJXy9HI05qBM2n+Tw3sC6mXUvbr6E0Tb2Nlldwb7YoLplIE4S8nJAoLS+mQVb1jM9l9Wpwjdh9ymO+WCoPH5J9LxuaKe7QplTT4vCe2BL8WxPHHJAbzjUN06CHC3E90cK82+ipfNUDftqTf5mYwMd3Cf+wUMFayTtZ1YDkkiYn/wb35bdRylpFbBVFz8HIxrC2/+TGZR5xD54g7hyCiqDJmrKSlpKVqk1h4QhP/NZiD9z5i53lzrlxknjOKiTcgSPNMhNr4or60pS0vUJyXRTfBJzb9SI5tdrFmdeb6UCw4oIqy4LKnP4GDcLKE910+K2x2IKmTtn/CjWhpH78H1PGVXVEFD3q7JNk8Ujbr1KKUdEabLi/akU8YJbeIbQfwsGRjarFYdUiHurv/tr2+1ijhakkw62DcB36GBYzGBDf9gw==;5:8bAnIiONtPZ5k2LkYXxhSoBw60iIFLv7ovdaa+okkQKtDrAPCEDX1Mccj1UoS0bkayMNO6Ex0rBRdSZu0keaCoi1CdZ5Ycxq9HhwZaqjsCsSJSECfOv9lsTmrQWyvi1+by5ieUI5oN1IksmC/yUSy8vSSMcb/BmzIsvczGSYYA0=;7:PsAN5aq2nOq+MGhomShWdwSOleCQSHUzTXr+dI3gmsYBLbUPdUqxGmubwTBHUMpuc0Egl2iuT7rep7OyJQa9/3waj9/5RY40Y2d/rNGlB7AwdTtwiA6KjphJOGHpG9AWsjFu4ppneGNDU9uHk4jMVB9WGYrAh1RREqBczT1UurBLPpUvekLNg4uQPufyyQjI/4yQc3NpSMkUVzuaOscDDBGpzddx04wgm/HsrDWO/DDD8oTuqLDhpOmb88WUyKjz
x-ms-office365-filtering-correlation-id: 1f72c73b-22bd-42d9-635f-08d61aab65e6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0823;
x-ms-traffictypediagnostic: CY4PR21MB0823:
x-microsoft-antispam-prvs: <CY4PR21MB08239302F7633847FCCC12FCFB180@CY4PR21MB0823.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0823;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0823;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(136003)(39860400002)(366004)(189003)(199004)(53936002)(14454004)(2900100001)(3846002)(6116002)(256004)(10290500003)(81166006)(81156014)(217873002)(76176011)(72206003)(478600001)(8936002)(25786009)(8676002)(86362001)(66066001)(6512007)(86612001)(7736002)(305945005)(97736004)(11346002)(5660300001)(5250100002)(102836004)(54906003)(2616005)(446003)(6436002)(6506007)(476003)(186003)(110136005)(2501003)(2906002)(105586002)(22452003)(10090500001)(36756003)(4326008)(68736007)(26005)(107886003)(6486002)(486006)(106356001)(1076002)(6346003)(316002)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0823;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: ZNTgOZskYZG2VQlkb8lst2qbqzVtOyUtkzkjREzoGFb8kt2LJ0dT7TrOoKWAWxlugxCxHXI5q3SOPC4NlqUfU5l8Ja6Ccbcx6bUQU8/HTa5yy3f8Z3pfYrKKzY7If8xtJaCsC3Zt9RYA0EY6gavstGxlSvQjl+PT4k7h5CLF38SrSRV+D9YyDgfIcFfdNNqJ8jfZBVI7bbZOYCnOL5I4pYn+lTjao1vYpM4Pgc9wN1mJLGhXyRXRWRh+Armyy4pwYysHSbmdQV6EU8LMCpSnyyiof/PAw1ygoW6nSRtgJ28o7wgzVWtinVjbRWUfICSxvwAZBWkCN/1kRJD2pOLvQWexwvxMO13LKOvEnS1k7YA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f72c73b-22bd-42d9-635f-08d61aab65e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:34:36.9893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0823
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

[ Upstream commit fe470f5f7f684ed15bc49b6183a64237547910ff ]

If we fail to find the input / output port for a LINK component
while enabling a path, we should fail gracefully rather than
assuming port "0".

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/hwtracing/coresight/coresight.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/co=
resight/coresight.c
index 4383324ec01c..398e44a9ec45 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -107,7 +107,7 @@ static int coresight_find_link_inport(struct coresight_=
device *csdev,
 	dev_err(&csdev->dev, "couldn't find inport, parent: %s, child: %s\n",
 		dev_name(&parent->dev), dev_name(&csdev->dev));
=20
-	return 0;
+	return -ENODEV;
 }
=20
 static int coresight_find_link_outport(struct coresight_device *csdev,
@@ -125,7 +125,7 @@ static int coresight_find_link_outport(struct coresight=
_device *csdev,
 	dev_err(&csdev->dev, "couldn't find outport, parent: %s, child: %s\n",
 		dev_name(&csdev->dev), dev_name(&child->dev));
=20
-	return 0;
+	return -ENODEV;
 }
=20
 static int coresight_enable_sink(struct coresight_device *csdev, u32 mode)
@@ -178,6 +178,9 @@ static int coresight_enable_link(struct coresight_devic=
e *csdev,
 	else
 		refport =3D 0;
=20
+	if (refport < 0)
+		return refport;
+
 	if (atomic_inc_return(&csdev->refcnt[refport]) =3D=3D 1) {
 		if (link_ops(csdev)->enable) {
 			ret =3D link_ops(csdev)->enable(csdev, inport, outport);
--=20
2.17.1
