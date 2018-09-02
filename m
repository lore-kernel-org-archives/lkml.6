Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69112C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D8872077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="a1KrfNRN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D8872077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbeIBRUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:20:46 -0400
Received: from mail-eopbgr700098.outbound.protection.outlook.com ([40.107.70.98]:16799
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727495AbeIBRUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:20:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKa1Y1B1kjIBtjsyLtgWTVeHnb8OO78Eu4vKPu6vIPc=;
 b=a1KrfNRNodenCtGg7WIpchwDPgmhO7EjqnclY7xdZgD7IHR689+JEmleWKfANy3e16HAxC4r9LS3u78rKu+qwS7KBvaClxVtJYepVf1sh0BQWsMnUOl0Azfd5IanosIePCdGgSooZEEnPH67uyNI8wn7K080UM6BmOib/8gJJc8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:04:18 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:04:18 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mike Christie <mchristi@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 059/131] scsi: tcmu: do not set max_blocks if
 data_bitmap has been setup
Thread-Topic: [PATCH AUTOSEL 4.18 059/131] scsi: tcmu: do not set max_blocks
 if data_bitmap has been setup
Thread-Index: AQHUQr10V/xS2YKKJEyBKWZzl4Zk8A==
Date:   Sun, 2 Sep 2018 13:04:16 +0000
Message-ID: <20180902064601.183036-59-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:hEW/ZM8miupmNfa66u+JOA0XMZYPxXimy+73YXQQaiel11uoQls19mdU/32/Xmv8o5l+UBxAhd1u+QngqCXlRIfDqM+KXKkQ9xfKiFWByNsBUasJWNnVDhhsMd2IPkSc9ausRVs2Fe/yOWGO9mk7yffdNG2sVrZO+jUdqCUnSB3tiWgAILXqM6THLiZq3qtj6F8psQD6QQKfzPTPrMyjf5nPcUn/ArVVw6R9z+8LFvB2Ey2JIxaVnS6kj3ESX8ILdkhsz7lQvRcLjZICEXQgRZEBKivO9nfzU9Yh9kRDzHV0UpGNiCDHfyGuhxm4YF6bJA6mrmnbXMP6r0w1zubqiQ8oKlob/vWrdUy+goacudnlg5E1+V9p7qRFLAMEjUjmttrfZfRU75ETZ46O8/7EwD+YE1p4dWrxY6fJbZ7Xt1IabXDfnKkCXv4NJE04+Ym0bE+UJQELfObz8giu70ZDAQ==;5:AP9cAkdYx2PlfoWOM0EuSxqZrJjsNSd8/A2rdbbYFEG0uHtdA6RM76zzKijyvUY1zW8yLDE4chTSbU8RncKB7H6x8AK5cY7oiLPJrKBUFNRk/R7F5JGPNVlO7geChlTU+STNsw9ttWG4tffUKbekvE0C3uuY9yHgkWLjm/TULKk=;7:rEnbdgbCUo1duEo/RtK6IlNbgAGgLRbMuNbkCgQJaJg8g60G8dtGupoIhjd1D8SqJxcSnFUG/Jsw+9HwIsJQUEPZKpM4FDGnvXtCmP5YJ9EtgLonXlhaJMDxAWp1lWDgtRXOt7mWT8cCnWPWsoOjaUM+mvWuvw2wybj/aUCBG8cTOC3Ru+qjbLStXsM/gZ9+LRt+nSnscR1NO3EpM/3/qa3SvHMkRMzSGs8yqKYPvLZAutJnJc8DSB+engOcswa9
x-ms-office365-filtering-correlation-id: 6e2002f3-a791-429b-79c3-08d610d49786
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0120A34C83429DFC4F26ECE3FB0D0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(366004)(346002)(39860400002)(199004)(189003)(110136005)(5660300001)(107886003)(26005)(6506007)(2900100001)(8936002)(68736007)(66066001)(99286004)(76176011)(217873002)(2906002)(1076002)(316002)(3846002)(6116002)(86612001)(14444005)(54906003)(6436002)(305945005)(7736002)(256004)(86362001)(6486002)(25786009)(10290500003)(478600001)(14454004)(476003)(22452003)(5250100002)(97736004)(106356001)(72206003)(53936002)(2501003)(2616005)(446003)(11346002)(6512007)(10090500001)(4326008)(36756003)(105586002)(102836004)(8676002)(81156014)(81166006)(186003)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: IuacIm8CJUcdORPA9JyI47obnmGA9N8HGyfPnobgpCF2kRU8mtROAj+L6JF93kifnDI9LbawPca8emSNW5uPj7+JvueHJ80z3zb/H+khpp3bOlvfVZ66xy+cWRXa9MXhtY4IHExlwPOuERCKE9eJICm7x6YcjEM63do92nzgr7F1EyCom4MZRcd11rXq1WHkxsspCKf0O323Ee3RVEOBi85kQ9bpzKOjqyHvJMwLLj50DtC3m4y1e6rHNv4bKrFZRXkbc8q8+k/DDLbVC04UjMugBTwWlxarBsLEgMqG7C3NBGbS6+SRry4lKYGy4Drc1W00Os/KEnc2M8bM6OtzoEb7NOH45YdDLPRWFEJlXG0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e2002f3-a791-429b-79c3-08d610d49786
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:04:16.5785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Christie <mchristi@redhat.com>

[ Upstream commit c97840c84f5a4362a596a2751e9245a979377a16 ]

This patch prevents a bug where data_bitmap is allocated in
tcmu_configure_device, userspace changes the max_blocks setting, the device
is mapped to a LUN, then we try to access the data_bitmap based on the new
max_blocks limit which may now be out of range.

To prevent this, we just check if data_bitmap has been setup. If it has
then we fail the max_blocks update operation.

Signed-off-by: Mike Christie <mchristi@redhat.com>
Reviewed-by: Xiubo Li <xiubli@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/target/target_core_user.c | 73 +++++++++++++++++--------------
 1 file changed, 40 insertions(+), 33 deletions(-)

diff --git a/drivers/target/target_core_user.c b/drivers/target/target_core=
_user.c
index d8dc3d22051f..b8dc5efc606b 100644
--- a/drivers/target/target_core_user.c
+++ b/drivers/target/target_core_user.c
@@ -1745,9 +1745,11 @@ static int tcmu_configure_device(struct se_device *d=
ev)
=20
 	info =3D &udev->uio_info;
=20
+	mutex_lock(&udev->cmdr_lock);
 	udev->data_bitmap =3D kcalloc(BITS_TO_LONGS(udev->max_blocks),
 				    sizeof(unsigned long),
 				    GFP_KERNEL);
+	mutex_unlock(&udev->cmdr_lock);
 	if (!udev->data_bitmap) {
 		ret =3D -ENOMEM;
 		goto err_bitmap_alloc;
@@ -1957,7 +1959,7 @@ static match_table_t tokens =3D {
 	{Opt_hw_block_size, "hw_block_size=3D%u"},
 	{Opt_hw_max_sectors, "hw_max_sectors=3D%u"},
 	{Opt_nl_reply_supported, "nl_reply_supported=3D%d"},
-	{Opt_max_data_area_mb, "max_data_area_mb=3D%u"},
+	{Opt_max_data_area_mb, "max_data_area_mb=3D%d"},
 	{Opt_err, NULL}
 };
=20
@@ -1985,13 +1987,48 @@ static int tcmu_set_dev_attrib(substring_t *arg, u3=
2 *dev_attrib)
 	return 0;
 }
=20
+static int tcmu_set_max_blocks_param(struct tcmu_dev *udev, substring_t *a=
rg)
+{
+	int val, ret;
+
+	ret =3D match_int(arg, &val);
+	if (ret < 0) {
+		pr_err("match_int() failed for max_data_area_mb=3D. Error %d.\n",
+		       ret);
+		return ret;
+	}
+
+	if (val <=3D 0) {
+		pr_err("Invalid max_data_area %d.\n", val);
+		return -EINVAL;
+	}
+
+	mutex_lock(&udev->cmdr_lock);
+	if (udev->data_bitmap) {
+		pr_err("Cannot set max_data_area_mb after it has been enabled.\n");
+		ret =3D -EINVAL;
+		goto unlock;
+	}
+
+	udev->max_blocks =3D TCMU_MBS_TO_BLOCKS(val);
+	if (udev->max_blocks > tcmu_global_max_blocks) {
+		pr_err("%d is too large. Adjusting max_data_area_mb to global limit of %=
u\n",
+		       val, TCMU_BLOCKS_TO_MBS(tcmu_global_max_blocks));
+		udev->max_blocks =3D tcmu_global_max_blocks;
+	}
+
+unlock:
+	mutex_unlock(&udev->cmdr_lock);
+	return ret;
+}
+
 static ssize_t tcmu_set_configfs_dev_params(struct se_device *dev,
 		const char *page, ssize_t count)
 {
 	struct tcmu_dev *udev =3D TCMU_DEV(dev);
 	char *orig, *ptr, *opts, *arg_p;
 	substring_t args[MAX_OPT_ARGS];
-	int ret =3D 0, token, tmpval;
+	int ret =3D 0, token;
=20
 	opts =3D kstrdup(page, GFP_KERNEL);
 	if (!opts)
@@ -2044,37 +2081,7 @@ static ssize_t tcmu_set_configfs_dev_params(struct s=
e_device *dev,
 				pr_err("kstrtoint() failed for nl_reply_supported=3D\n");
 			break;
 		case Opt_max_data_area_mb:
-			if (dev->export_count) {
-				pr_err("Unable to set max_data_area_mb while exports exist\n");
-				ret =3D -EINVAL;
-				break;
-			}
-
-			arg_p =3D match_strdup(&args[0]);
-			if (!arg_p) {
-				ret =3D -ENOMEM;
-				break;
-			}
-			ret =3D kstrtoint(arg_p, 0, &tmpval);
-			kfree(arg_p);
-			if (ret < 0) {
-				pr_err("kstrtoint() failed for max_data_area_mb=3D\n");
-				break;
-			}
-
-			if (tmpval <=3D 0) {
-				pr_err("Invalid max_data_area %d\n", tmpval);
-				ret =3D -EINVAL;
-				break;
-			}
-
-			udev->max_blocks =3D TCMU_MBS_TO_BLOCKS(tmpval);
-			if (udev->max_blocks > tcmu_global_max_blocks) {
-				pr_err("%d is too large. Adjusting max_data_area_mb to global limit of=
 %u\n",
-				       tmpval,
-				       TCMU_BLOCKS_TO_MBS(tcmu_global_max_blocks));
-				udev->max_blocks =3D tcmu_global_max_blocks;
-			}
+			ret =3D tcmu_set_max_blocks_param(udev, &args[0]);
 			break;
 		default:
 			break;
--=20
2.17.1
