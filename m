Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB9FECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB9B021477
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="gFpIvatz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB9B021477
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728785AbeIOHFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 03:05:49 -0400
Received: from mail-cys01nam02on0095.outbound.protection.outlook.com ([104.47.37.95]:24416
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728568AbeIOGr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:47:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZgy6JugKWOcYWXJCsX1TlP4CcFOVa0ixdWZ0UX80rw=;
 b=gFpIvatzrmGrgdI4dHlR96TARKZQCC8kgzd2yFqlUXDY+iYXD6OISWaKwBJ9Zs50hrz5kyGWjWSuBbC3KdFJ7bAgEV+QvFPkESF/zLcGc5MkzAjX+QEKYqIT9yIVPdWyS7HmcuXUdhpOw6fmGSId7+qxqWLWB/lGZ/PraveKK6A=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0856.namprd21.prod.outlook.com (10.173.192.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.6; Sat, 15 Sep 2018 01:30:53 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:30:53 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Eric Yang <Eric.Yang2@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 52/92] drm/amd/display: support access ddc for
 mst branch
Thread-Topic: [PATCH AUTOSEL 4.18 52/92] drm/amd/display: support access ddc
 for mst branch
Thread-Index: AQHUTJOtMRV4RBdt9kac33dsZQ+jIw==
Date:   Sat, 15 Sep 2018 01:30:25 +0000
Message-ID: <20180915012944.179481-51-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0856;6:xyE4z6CK/rtyBYHlJOuMsEoTHB+TG3VoaCn/lYlWrZVeH1QXb7cPQdiwOlYT32f1hijPcZtUGWCDpJHlXhq7T7U+biuQ1QE97yMkRPCtLvjZ+aVYpOaMNmILkuLXahUHVMOg789/V8AK2QjXnqnrOwLNBTgIOfr3b0+lqqpsIXkfbOoeRcIcwhkY2/sepIN4LISe/vhy/6gAbHgfbWk41ONrsB476VDsb6Z3weCUmBLj4PWnmt6jvVl9XWfDlOqusrllJtiVDVaSVtUJW8rFW1Z5DtHrMOLoj0+UhwuW3/2qILJTNvP/WGmn8AbxZfqbaywGFcUrQbBHu79yD3KEe67g2PgIZciKwkT7wxUFIQstP6lXEtmh+THgRSmb+yfTe2B6ymsLtc6/PmeiB3bd24dYR4Pb0jD6RVjoZG+QnK/owoTT/jEB2HUhOzHBdrcgVHCPhbINeaHeT/c2FGdEow==;5:4Xhf3X0QKePszLG4Ge0Nd07jkKHs7bBDo/fUMA5iAepyGYf3kU4KyTpDNv9yVTnKRNcefKJmLV9ZfzDRTwXAcVB7nzXJcPRT86lOBSV9b9qUTHxjuJMWoPC8bioqBj5pUYw9Pf9Fr/zQi3Xb6Et/ZtIp1jtyJC4YCYE89BH4SPc=;7:T8geMf3CxDi6Dt4RUmNrKvFNAR1hUlY+PldYqidW4sF6elS/880QS7oo2djD3lcqv8k1s+Bi3y8jH/qDFlgQmxjAS1109v1HeKkQn3RxVfr8LQyvHI/kvs5/+NRyP/Ohaxv53W6s0FWA2Y9mxNsZQXPD1QD9hCV7S8RIjzyxNN6XABSLmMyDRNi1jdSnHK8PWRQgjVLUR6DOmXX+2+hHLiRXFM7cwxxVlJJtCS+V6RgSJDdCjn2yFCtuDRg9811k
x-ms-office365-filtering-correlation-id: eff49c57-a566-452f-374a-08d61aaae093
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0856;
x-ms-traffictypediagnostic: CY4PR21MB0856:
x-microsoft-antispam-prvs: <CY4PR21MB08565B0BA94B5E3D2FD9E3B1FB180@CY4PR21MB0856.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0856;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0856;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(366004)(346002)(376002)(199004)(189003)(36756003)(6116002)(486006)(316002)(3846002)(8936002)(22452003)(446003)(11346002)(2906002)(476003)(2616005)(6512007)(107886003)(53936002)(54906003)(1076002)(110136005)(25786009)(102836004)(66066001)(4326008)(217873002)(99286004)(5024004)(14444005)(76176011)(68736007)(6666003)(86362001)(5660300001)(6346003)(8676002)(86612001)(256004)(186003)(81156014)(81166006)(6506007)(26005)(2900100001)(10290500003)(478600001)(7736002)(72206003)(305945005)(551934003)(97736004)(10090500001)(14454004)(106356001)(105586002)(5250100002)(2501003)(6436002)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0856;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: Y2b8zJ5XmnRojqeOMbFUm8G+XpyxAeFF25uXmlaB/JGrIhDhK2WjkypW5Sv4bLgTSOCrHRVvE/VllmFv68lVPDk6SSbhzGhkabT3UiCuJe5bx3IBBvJp4rYN3f5UGZ+fvXjrANIW9hmDHzt3ByePaEMNcm/nQRi+KlCFZfkn8E2HK6ImSnjvu8W6wtHj9kPSiHfu9t8N6n8F2gp0mQ7o4PDOxqqn4Bw6f8UEN79x0Yfr2D5PrSVD9iw5MmBwK4c8dMYOeIIPhezNZ6VEufCiO9UfGlXz2duG2XP0+d0Kkl3XLpQ19A037IvDAAxwym1FX6Ovwe684Tr12zRnQAdIotxBDLhsYnZaW/QZ3yDNCwY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eff49c57-a566-452f-374a-08d61aaae093
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:25.9012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0856
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Yang <Eric.Yang2@amd.com>

[ Upstream commit 0a14544661fad1606cc96aece30b2950fd9c4c81 ]

[Why]
Megachip dockings accesses ddc line through display driver when
installing FW. Previously, we would fail every transaction because
link attached to mst branch did not have their ddc transaction type
set.

[How]
Set ddc transaction type when mst branch is connected.

Signed-off-by: Eric Yang <Eric.Yang2@amd.com>
Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/dr=
m/amd/display/dc/core/dc_link.c
index 2fa521812d23..0351f7dc46e3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -497,6 +497,10 @@ static bool detect_dp(
 			sink_caps->signal =3D SIGNAL_TYPE_DISPLAY_PORT_MST;
 			link->type =3D dc_connection_mst_branch;
=20
+			dal_ddc_service_set_transaction_type(
+							link->ddc,
+							sink_caps->transaction_type);
+
 			/*
 			 * This call will initiate MST topology discovery. Which
 			 * will detect MST ports and add new DRM connector DRM
--=20
2.17.1
