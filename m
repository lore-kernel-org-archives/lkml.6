Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABE1ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81ABF214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="MD+75Ejr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81ABF214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731569AbeIQIfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:35:02 -0400
Received: from mail-eopbgr720091.outbound.protection.outlook.com ([40.107.72.91]:17664
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731537AbeIQIdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:33:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fI974TXPjHOtiGuJOZyUR7sh7TSlKfA1ZgtUxulTgME=;
 b=MD+75EjrYTqQ8bEAuVVlcLZNLiYi48F5R1nKh2ec/zlf3eqSFV9ujvHcMeHlAaf5Fw3DHvZWVItzB4N2gX/BFC3tJQe2gecm3u1YPmQcvyQHjSijH22krCjRE4XvsDsrfBzyJRtB4x8lZdsELRQRB2i657rclPAQrKA1gh7EWhM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0150.namprd21.prod.outlook.com (10.173.189.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:07:54 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:07:54 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Alistair Strachan <astrachan@google.com>,
        Todd Kjos <tkjos@android.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "kernel-team@android.com" <kernel-team@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 17/29] staging: android: ashmem: Fix mmap size
 validation
Thread-Topic: [PATCH AUTOSEL 3.18 17/29] staging: android: ashmem: Fix mmap
 size validation
Thread-Index: AQHUTjNVUgDYiW88bUGm1j5cuHdl8g==
Date:   Mon, 17 Sep 2018 03:05:48 +0000
Message-ID: <20180917030533.592-17-alexander.levin@microsoft.com>
References: <20180917030533.592-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030533.592-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0150;6:EUzwfl9Kgg4MTfVF03tkODavvWwPdBfK17IP3xj1jwNSK36gB/Rrf1ThYN065pHPYDqJWneAE6Xcaf6jk9AC2HQuIJX72Kqed77QF/LgLIr+bTjS9b+wQdyA33qe67HUOj5syj9bh1EvSNg1HFAEqhx82xH7gwpuF0wN7veEKtqoQO+rMO9gmFjI975I2McNzJvk5C7fk5ihJ6IBV8aoLboJp/mZBmg+reVNtGN428o3gzQOcZBhuCb8GwBTVGPOMkk81KVvQ2BJDdsK3aI7t/H6oS1vwzx5r+MoiUzqwvbKx2pZauQ9M5ByNtv9X5I8PeUxsTJTelk9Kh5E6zLrIMA3FD4Dr5X2pqgcK8/CnV7cdqwEmNiF6/O+PvlN7KnpF0ok7bzb60Dq2gZIj+5BzAlDtH6v6R77FFX7zPYjxjYJbJLrPqBW0EZ7iQYClAZF3usG2SC2U7IwUS7O3UC0aw==;5:QMg7twrsqUvlLDp8PfkU30OozCih2AbUd1wlyR5eZeE/TCGGUgLa48wsMX5thpbcoaeAsqsP9Wt0mC6LQaxMM5IJzvOttHYLqXg2DVA2nZIS7dJ3pUsHnn/CXkppBdd7e9qujo3FYWIvhtO9Dhz4bdqSvapYoGkFJfdJcfBd/Lc=;7:prm8ulJ2NVJOHs4ve08BSVrHNFQlNOMD6mgJ9L+5acSZQIiDpjB4tzexyAzKpJFa5lp0KTUlJLqyAno3TDJ05Yg7l1WktH83dI2GaxObjOJYJcqENv4goXOpr1pR9+hFwl4yxgN9IYz9+YyafCZRUXgJH2tAQ0Iv2JHoH8Qf/w9BzNZPwzgBdM9Fz8pwthiJb3X8ivJ7/P6R81zaf0jTIPBKvw0G4kusGXLWVWCUOes47kTDAdqV9jzwNLto3NeE
x-ms-office365-filtering-correlation-id: 6e485ba8-b4cb-425c-84c7-08d61c4ac30b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0150;
x-ms-traffictypediagnostic: CY4PR21MB0150:
x-microsoft-antispam-prvs: <CY4PR21MB015091F3F9A7D03B695277B4FB1E0@CY4PR21MB0150.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(211936372134217)(153496737603132)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0150;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0150;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(136003)(346002)(366004)(39860400002)(199004)(189003)(478600001)(2900100001)(2501003)(6666003)(11346002)(107886003)(5250100002)(14454004)(26005)(10290500003)(36756003)(217873002)(7736002)(99286004)(305945005)(102836004)(72206003)(2616005)(86612001)(476003)(6346003)(186003)(486006)(54906003)(110136005)(446003)(6436002)(5660300001)(4326008)(256004)(575784001)(86362001)(10090500001)(2906002)(6486002)(316002)(6512007)(53936002)(22452003)(66066001)(97736004)(76176011)(81156014)(81166006)(8676002)(3846002)(6116002)(8936002)(25786009)(6506007)(68736007)(105586002)(106356001)(1076002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0150;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 4RxqyzhKG9NQbyg7DWAjwAAkpwH0zeFbScQmlVHWlELauY0k3Kmav3IqK0dgMdnHpYcXawUoif5JsX7PC+jIAKMcWMTI2AFNujtYeQ6Zwz/mI++k+eFBgsPtGpZAN8VdPpOJInYHWP4iDMWG8WdFiP6UBRb2oaF8b5d9pmnptIprDAAcHA9coyJnlurG5Z078TqOSXmZtDRpHhGwf2UYYyylhjoH5z+fGeBdWu2FizDf+1rf2MlQ06q3z5raIOnF0doyLJGyHdjb3MRKrO3irz/doKJp6C0mE0BjU0mYe2Fc1e5dra5bbB1wHm/a3pp7mb/RTLny0MFUysDKS6uTmUvrTj4m4WIDkvURo7Vrqtg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e485ba8-b4cb-425c-84c7-08d61c4ac30b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:05:48.2170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alistair Strachan <astrachan@google.com>

[ Upstream commit 8632c614565d0c5fdde527889601c018e97b6384 ]

The ashmem driver did not check that the size/offset of the vma passed
to its .mmap() function was not larger than the ashmem object being
mapped. This could cause mmap() to succeed, even though accessing parts
of the mapping would later fail with a segmentation fault.

Ensure an error is returned by the ashmem_mmap() function if the vma
size is larger than the ashmem object size. This enables safer handling
of the problem in userspace.

Cc: Todd Kjos <tkjos@android.com>
Cc: devel@driverdev.osuosl.org
Cc: linux-kernel@vger.kernel.org
Cc: kernel-team@android.com
Cc: Joel Fernandes <joel@joelfernandes.org>
Signed-off-by: Alistair Strachan <astrachan@google.com>
Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Reviewed-by: Martijn Coenen <maco@android.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/staging/android/ashmem.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ash=
mem.c
index cf7c597e598f..22ddd4ce9dd6 100644
--- a/drivers/staging/android/ashmem.c
+++ b/drivers/staging/android/ashmem.c
@@ -370,6 +370,12 @@ static int ashmem_mmap(struct file *file, struct vm_ar=
ea_struct *vma)
 		goto out;
 	}
=20
+	/* requested mapping size larger than object size */
+	if (vma->vm_end - vma->vm_start > PAGE_ALIGN(asma->size)) {
+		ret =3D -EINVAL;
+		goto out;
+	}
+
 	/* requested protection bits must match our allowed protection mask */
 	if (unlikely((vma->vm_flags & ~calc_vm_prot_bits(asma->prot_mask)) &
 		     calc_vm_prot_bits(PROT_MASK))) {
--=20
2.17.1
