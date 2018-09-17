Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1903ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1B7F2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="a95oAINl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1B7F2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731403AbeIQIcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:32:46 -0400
Received: from mail-sn1nam02on0110.outbound.protection.outlook.com ([104.47.36.110]:23375
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731379AbeIQIcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:32:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZhslA920M3oYyu7IJBgkU99sYY4M8tFVG/tdPjktUl8=;
 b=a95oAINlSvMPWGITW7tNw6lBhHSUtF7pYleZUOMzcR+6FUuvjh/LTBVFp0gaeVPJ3zpPLSt4UTOphy9MhZN3Ni4fRLEF7hgPwuZEuswLuY6EIuBYETdObsFXNedUR1EZmzG2rpqyEChyjhJlzevL1UmhyUQ+78KBWvCagkzvkP0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0742.namprd21.prod.outlook.com (10.173.189.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Mon, 17 Sep 2018 03:07:08 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:07:08 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Breno Leitao <leitao@debian.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 19/43] scsi: ibmvscsi: Improve strings handling
Thread-Topic: [PATCH AUTOSEL 4.4 19/43] scsi: ibmvscsi: Improve strings
 handling
Thread-Index: AQHUTjM51k5AUKkX2USHHniwjopLoA==
Date:   Mon, 17 Sep 2018 03:05:00 +0000
Message-ID: <20180917030445.484-19-alexander.levin@microsoft.com>
References: <20180917030445.484-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030445.484-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0742;6:xjXTNhukOP4S9jxIYO3ILsepBZcc8Q9gUc2hcHu1mNuyz7u0nX3PRPntKekii/V2tzIqMZzMR8rq09exbcRrKHV0Mm6bkDYi92OA5C8wk24Z7Cg/pns/N4qkDYDlSmZ8zDfWp8xOwGTiTUwFb5OaeUcGjSotskxG0n4sboZWGgICgqbjzQLeu8rzk0sVibUxXFC6i8FwcqwpzRsttUSM+T7BqghZXm4/nPq+eVEZCzJ0Qz0dImQUiltDKEQA03TrRa6UxfnJ1F94iPQfajjbzKS0iHC+TKPnMXzVQvggflYRfWZuNxTTM5JK8acr76Cb/lsZhshotmPzS3HyPEMPo7z9IwEU6LwqfYotN3illHRFj71B6Vjxdbq9IfwldEjID5T0n/VwsbY8Qtt92BRlXsrn+sCcRPSfFdyD+N2ULgaKktpKxFXeOAtOqexNQ97NItZB3C7Zb3pM8HU0S3S7BA==;5:FDgzTG2GnNlFvRFBnJC44yZFQ/l44KmlcqEXXCBg37/rCmS4uHFO9df1jRcK916Z19D24dRCpLawXOyZzXoIfcXxkiHF7jYvJOD7b8vrYxfAPtsiPwhbfzwYDBf33oMRyWP8i35+9w247XNdE5MDSo/P5A+HmKDSvfJFr6jfTsw=;7:C4NIrpjjFvGg0Js2VTdk8YgDf0vkSTlG45UuTIGnX9PNrENFrtLKi0DExkFzS9QP/OVP1Ty/9tsDGt1WSSuIfD6WXq42y52NDlvCV8iKp0jf4yXM+zpgtxjKFUZDqAOj4qNDkg/j1c/34uQ/zcsOW0w75IZfyoeiAKp2vHcomIyKVdgW4AV/P6wyWTGV5JnSiVRcUKeC4EKDF4xgrM7Dp6XXW315D7nuPH2zvTHsEGNLldDrqY+VrEPeGvKP1NDg
x-ms-office365-filtering-correlation-id: d50a40c0-c3cb-47a8-f5a6-08d61c4aa7d4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0742;
x-ms-traffictypediagnostic: CY4PR21MB0742:
x-microsoft-antispam-prvs: <CY4PR21MB07426F85D48B9FD97E428880FB1E0@CY4PR21MB0742.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(163750095850)(104084551191319)(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0742;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0742;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(346002)(366004)(396003)(376002)(199004)(189003)(6486002)(6436002)(6512007)(53936002)(4326008)(3846002)(217873002)(25786009)(2616005)(1076002)(14444005)(6506007)(186003)(6346003)(11346002)(446003)(26005)(2900100001)(6116002)(486006)(102836004)(256004)(107886003)(476003)(86612001)(86362001)(2501003)(14454004)(97736004)(66066001)(76176011)(6666003)(316002)(54906003)(110136005)(99286004)(68736007)(10090500001)(22452003)(81156014)(2906002)(36756003)(8676002)(8936002)(81166006)(7736002)(305945005)(105586002)(5660300001)(106356001)(10290500003)(478600001)(72206003)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0742;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: invc/+SNVBbTN+0RUlwDU0H2xKPbxYJ0srLsSpnv8M5/UtEkFfsWRJVeSDB7/5luv3+jHOrMavavy5qCAFthAW5Z0nFzYmJ6bw7v6h6DMsKtn6/fYumyRhw7IGBSC4qUyP65on49+hCDYnTR0IL67kjcP1KwzPOO1ZDbQMrsfTMcIXgzatleF2HI8mti6NHW6IhNEJTp+5en9zJ0CbqfVsJtZSBAyy10OrVskyMxKTt+4ojin+roIh2g/p/3ifvTGBkE28rhE2Hw1MiDzzetaxBxiR/pFBrxG/ud1Xnii9meJ+elad/Btlf2uGxV5s6Mmj1eIym16YgRRH9FBcKnIHiWaevpU3D2Us3gdsRCEpg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d50a40c0-c3cb-47a8-f5a6-08d61c4aa7d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:05:00.7579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0742
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
index adfef9db6f1e..e26747a1b35a 100644
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
