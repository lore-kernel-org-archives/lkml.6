Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B693ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39BDE214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="jcWZEWnS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39BDE214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731602AbeIQIdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:33:16 -0400
Received: from mail-bl2nam02on0121.outbound.protection.outlook.com ([104.47.38.121]:19879
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731514AbeIQIdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:33:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSqX6xAyk97+TbRGUIbTEZdxc8gLUCWcPmR6Wd2UE7g=;
 b=jcWZEWnSIQI2ubBWVh8o0i4PANI2i334NwmfnFdyluX5Z+3rMp094b01tj5wrxMI/v36VUtekIRbhUHBkxu/dkJMEYRpjAn/2AoTY08aAJG/u0Xv1q3IZjSs+QB2gCrw7lPoJkiysxXj1m8FMnZCSRjzKS9lYv9XbD06UsfLxV8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0839.namprd21.prod.outlook.com (10.173.192.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Mon, 17 Sep 2018 03:07:51 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:07:51 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Breno Leitao <leitao@debian.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 10/29] scsi: ibmvscsi: Improve strings handling
Thread-Topic: [PATCH AUTOSEL 3.18 10/29] scsi: ibmvscsi: Improve strings
 handling
Thread-Index: AQHUTjNSbFzxKcjp6ECO+VFKuzbugg==
Date:   Mon, 17 Sep 2018 03:05:43 +0000
Message-ID: <20180917030533.592-10-alexander.levin@microsoft.com>
References: <20180917030533.592-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030533.592-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0839;6:F/Dd9IzRYJSzjgay2hVR4IL9CLMJBMgZzneShZMk5sWxDj4NgV2g02pM6Uf7gLuMRq/JcxgvPd2A24hJb1piI7O4JoRPhxY/B97AlJgq4kyRo+9WnWBISucHjHpNIf4fWVG2ls2oVNeB79E8mlcAT0dPFedjOZDMr/TrVAvxzxZcUkKhyfKwPM0U7sC+zp/AmF/AoeNCgAPfJd+IgpYiDVwR0ERNRt631HQhzyLolCH0jg+fhJKkAfjNusI3EfT35xg5kLYIaBQhngrfar6hyUpMYazkSIsrAqAkIJw0nOgr2pf3DHKSexDYKMFosSP8N5Zv4O3E09XkcPs7ng7C9IibFGvy40mW62iQWxRT9rHjWNrQ2zSmcs1vHnyCoj//9ERPNZKcitnLvTIJeHO5KudQR8bDW9cdhJRSEtn4DiiUJU68LCO3SiTS5lBKl0mduiVCQdDDNTOwsCogpXNslQ==;5:xcUW6HA51ebCuBy5Y5Q8d+oLZ6UNJzFFtKN8XIok09GXyaTKtVtyZihKMjsEcFzXTyQwpBQsZz8husyDdXMKAlGo43ZtGbumAhe5STR6lhvikurK6ToS38tS0DIH66MVoKtuB/Sxdu9D28rWl/Iw1gAZMfCClMlNgTjbhXZnN4g=;7:wVX/Rfyy4WFrKz8VI53nG/GYauCGN5T3oQZ2E/L56c80sY16nCxku1PKLqLgdxtfEthJ9P9Xhb0a7olXTmoGj5reZPnpSkfdGqb5KstLMVfLLH/2VgBItEDe2nl1KtQjakQlTqWzwzTrYoc4aJ3oBrh0/z2PPuziUpfv1HW0wrw158BmhTV/NtDTgDbyyPbxZQ0Pb9AJJkFkyiB2d+MIGCJbPeuoXeVvQW+7mLNFADWgTFN3ABQMv4R/35Lgrnxz
x-ms-office365-filtering-correlation-id: 88954eb2-6422-48fd-c327-08d61c4ac122
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0839;
x-ms-traffictypediagnostic: CY4PR21MB0839:
x-microsoft-antispam-prvs: <CY4PR21MB0839D48082F821CDAB614990FB1E0@CY4PR21MB0839.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(163750095850)(104084551191319)(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0839;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0839;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39860400002)(136003)(376002)(396003)(189003)(199004)(8936002)(6116002)(86612001)(3846002)(53936002)(81166006)(25786009)(217873002)(5660300001)(68736007)(5250100002)(6666003)(107886003)(256004)(14444005)(305945005)(7736002)(2900100001)(1076002)(86362001)(2501003)(6506007)(4326008)(22452003)(10090500001)(6436002)(11346002)(446003)(76176011)(102836004)(6486002)(186003)(105586002)(6346003)(26005)(106356001)(54906003)(110136005)(316002)(478600001)(6512007)(2616005)(476003)(486006)(10290500003)(2906002)(81156014)(36756003)(66066001)(72206003)(8676002)(97736004)(99286004)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0839;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: kOye0h8wslmw+5ci7mh0tgHsI0dz0rSQCr5XrVUcPI6cyMVyP2iQUfX51F507GA4CXbuaS3xed7BimcqybkPc6KU3Kuzx7ObI9bfSZhzLweQiw8CGirM9NeJUJJ3DbYLjIXBa1CckAfdox3JdA2KPnNaHM2ghpOa0xBih3G/xPXK5SbhV8Y0Y+tM6uXyeMOAEo42DM4IYA7DUsEV8IafYxJXLOMThEcOIi44i1j9gEfrRPMo+sH4mJCiekFtqCVlFVsSaTuasdi4hlf+0mYjM0AqiVMsPmVnSr7QU0c8gPK9YiWd98qYAng84j2c8i85gXY44Au/cwgvAqNzcLLrTTs+S/lAFjIdFZuKspKmNMA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88954eb2-6422-48fd-c327-08d61c4ac122
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:05:43.1390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0839
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Breno Leitao <leitao@debian.org>

[ Upstream commit 1262dc09dc9ae7bf4ad00b6a2c5ed6a6936bcd10 ]

Currently an open firmware property is copied into partition_name variable
without keeping a room for \0.

Later one, this variable (partition_name), which is 97 bytes long, is
strncpyed into ibmvcsci_host_data->madapter_info->partition_name, which is
96 bytes long, possibly truncating it 'again' and removing the \0.

This patch simply decreases the partition name to 96 and just copy using
strlcpy() which guarantees that the string is \0 terminated. I think there
is no issue if this there is a truncation in this very first copy, i.e,
when the open firmware property is read and copied into the driver for the
very first time;

This issue also causes the following warning on GCC 8:

	drivers/scsi/ibmvscsi/ibmvscsi.c:281:2: warning:  strncpy  output may be t=
runcated copying 96 bytes from a string of length 96 [-Wstringop-truncation=
]
	...
	inlined from  ibmvscsi_probe  at drivers/scsi/ibmvscsi/ibmvscsi.c:2221:7:
	drivers/scsi/ibmvscsi/ibmvscsi.c:265:3: warning:  strncpy  specified bound=
 97 equals destination size [-Wstringop-truncation]

CC: Bart Van Assche <bart.vanassche@wdc.com>
CC: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
Acked-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/ibmvscsi/ibmvscsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvscsi.c b/drivers/scsi/ibmvscsi/ibmvs=
csi.c
index 7b23f21f22f1..e9331cf5478d 100644
--- a/drivers/scsi/ibmvscsi/ibmvscsi.c
+++ b/drivers/scsi/ibmvscsi/ibmvscsi.c
@@ -93,7 +93,7 @@ static int max_requests =3D IBMVSCSI_MAX_REQUESTS_DEFAULT=
;
 static int max_events =3D IBMVSCSI_MAX_REQUESTS_DEFAULT + 2;
 static int fast_fail =3D 1;
 static int client_reserve =3D 1;
-static char partition_name[97] =3D "UNKNOWN";
+static char partition_name[96] =3D "UNKNOWN";
 static unsigned int partition_number =3D -1;
=20
 static struct scsi_transport_template *ibmvscsi_transport_template;
@@ -261,7 +261,7 @@ static void gather_partition_info(void)
=20
 	ppartition_name =3D of_get_property(rootdn, "ibm,partition-name", NULL);
 	if (ppartition_name)
-		strncpy(partition_name, ppartition_name,
+		strlcpy(partition_name, ppartition_name,
 				sizeof(partition_name));
 	p_number_ptr =3D of_get_property(rootdn, "ibm,partition-no", NULL);
 	if (p_number_ptr)
--=20
2.17.1
