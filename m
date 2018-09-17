Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6446BECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 142FF2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ThH4PHj1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 142FF2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbeIQI1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:27:05 -0400
Received: from mail-by2nam03on0108.outbound.protection.outlook.com ([104.47.42.108]:58413
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729016AbeIQI1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oS87lu1xwEo4rcn8uG0qa3wvNgU2alpdzTUA3hCwO3g=;
 b=ThH4PHj1J3FHsudMhPRF8qsMm9ZAZvxmlTHkNlbXnlUgZOPMWtxbWpr76EugcdaSCFI4ollM4liz7nuMqcIBZAe/6ux62MvItvnKHXSCxubf6KkIgdl6C0E0riDrCKq5ovyQNqlNfYP3B4q4WUoHzCqO/KGAcW2GZ0E73oh2trc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0502.namprd21.prod.outlook.com (10.172.122.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.7; Mon, 17 Sep 2018 03:01:48 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:01:48 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Vasily Gorbik <gor@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 062/136] s390/extmem: fix gcc 8 stringop-overflow
 warning
Thread-Topic: [PATCH AUTOSEL 4.18 062/136] s390/extmem: fix gcc 8
 stringop-overflow warning
Thread-Index: AQHUTjKkytLYVWLAXEm+gezsvVzTHA==
Date:   Mon, 17 Sep 2018 03:00:50 +0000
Message-ID: <20180917030006.245495-62-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0502;6:aN5EFho9di1AwCW10Yv5z8fcmuJyc9q02fjG8gRr/pYSJdz05G5sNHB7gAXJwiuWW7iq2G1tAsKPMdoVKdNFlEDZC+MWkL1k48Ci9+VEKoyMLNatHWPGmiVFuu1rrBR3SHw0xcXa6S7zmAvXlDh8vuDviR7onbD6mrVBiZVJ/re0B++4q3cADq6JXGWzDnNcwWPyEA6pjFQFZ+WWZo4/JfP5HgHA8DA8Pax7p3dFbZGJcZOqtR6aJDIHIO7IWHL1NoiLzhQaGsXjyxv4VET90kdpfFTC3GFqFJQD+JL2RcSeYWsUNV4hhE2+PSaVCLDUnnWf3/XvWvNIdWKs9of38ANKmF9E4i3eyF+9NcSIBF/LBaT5fd4cbHQO9TO6NOUqmOWcd6ZMukN5Zr2rds+tfEHuA4t0OoeKQROeIqofB76sWU0+QY7fyekq6oIqByBbN6cNhJZhRA8xh1ZwErqJjw==;5:zhRNwoYrRsqzEoLd6JZfIUZL4GOEfFUUYvMVDaOX8hS1bhZxOXIMe3uFSC+92/uU+eAgz4/FQSL0N9VHpnNWU5/34PYePXVXsuWcoCBM5T1pwfSYhU4WUR6EMwLu/Imb/o7P5sBM/FjlpqDhj2trgQSZvLBK6q5hg1HAM4mO77Q=;7:0mykU7j8MfHoRaPSrSYhTaTPVOKRRn6SeqneRJUUwtmPvAMWfGiCNNIwXF5lSAtaCK9WMtbeXCK/Wge5VeBEtpPDX1+mOQkGla5mE144t/kWaRDJ8FiSIrV0353ztD3fRD/yHOdBhHFDdQu6RXohpv2SPtWrRxpEblq77TcunZWx7AqVFJYpbJy+8GiZwNkxfVgA5EdEZ8w7mERrV83qd2O8d/EDWJSWeTdyPyLfsR2qodaQ0NcCkEVfzrvbbADW
x-ms-office365-filtering-correlation-id: 4335d2e3-adaa-4b09-d4fe-08d61c49e8d0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0502;
x-ms-traffictypediagnostic: CY4PR21MB0502:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0502E09C8B786FD11FF86613FB1E0@CY4PR21MB0502.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(104084551191319)(190383065149520)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(2017102700009)(2017102701064)(6040522)(2401047)(5005006)(8121501046)(2017102702064)(20171027021009)(20171027022009)(20171027023009)(20171027024009)(20171027025009)(20171027026009)(2017102703076)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0502;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0502;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(136003)(366004)(376002)(189003)(199004)(86362001)(2616005)(99286004)(5660300001)(1076002)(6116002)(3846002)(6666003)(10290500003)(2900100001)(72206003)(68736007)(8676002)(22452003)(26005)(217873002)(86612001)(486006)(76176011)(66066001)(102836004)(2906002)(476003)(14444005)(186003)(256004)(6506007)(446003)(11346002)(36756003)(316002)(5250100002)(6512007)(97736004)(2501003)(107886003)(110136005)(54906003)(6486002)(8936002)(53936002)(81156014)(81166006)(10090500001)(25786009)(305945005)(7736002)(105586002)(106356001)(478600001)(4326008)(14454004)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0502;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1fqDI8CjTThp5Z+nI8e948YlbqBsileCDdbrY71WWmSbVvLAWh1Xx/Pf0R6ORBkRCTkKQpKn5zTUOBs3EZdhxmO69rqopLIVWmtE1C0e2hI0otvp4HEjDqiX2bAcYOaWQMbThLhbsIGvsp92INSryeu9/6AUNus+yZ+4h+RsQDDs4cSLpfiJ19YU81H840yKtHHXS079W87C0lNRNiha5Zt5FlXemawDmwl2lhfxQpZMe+sDmx98Dxb5ywFlikZYNRe0nnyMhMT7usPZjPjX5TsPWGtnTvhKSGgn0gwYMlsNxlQIBHeDFtzgaGHZBJTsVYuseu9bn4pgpYvDvXzlyhw6jU8VpY5ByLdO+uAtGYQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4335d2e3-adaa-4b09-d4fe-08d61c49e8d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:50.8544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0502
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Gorbik <gor@linux.ibm.com>

[ Upstream commit 6b2ddf33baec23dace85bd647e3fc4ac070963e8 ]

arch/s390/mm/extmem.c: In function '__segment_load':
arch/s390/mm/extmem.c:436:2: warning: 'strncat' specified bound 7 equals
source length [-Wstringop-overflow=3D]
  strncat(seg->res_name, " (DCSS)", 7);

What gcc complains about here is the misuse of strncat function, which
in this case does not limit a number of bytes taken from "src", so it is
in the end the same as strcat(seg->res_name, " (DCSS)");

Keeping in mind that a res_name is 15 bytes, strncat in this case
would overflow the buffer and write 0 into alignment byte between the
fields in the struct. To avoid that increasing res_name size to 16,
and reusing strlcat.

Reviewed-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/s390/mm/extmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/mm/extmem.c b/arch/s390/mm/extmem.c
index 6ad15d3fab81..84111a43ea29 100644
--- a/arch/s390/mm/extmem.c
+++ b/arch/s390/mm/extmem.c
@@ -80,7 +80,7 @@ struct qin64 {
 struct dcss_segment {
 	struct list_head list;
 	char dcss_name[8];
-	char res_name[15];
+	char res_name[16];
 	unsigned long start_addr;
 	unsigned long end;
 	atomic_t ref_count;
@@ -433,7 +433,7 @@ __segment_load (char *name, int do_nonshared, unsigned =
long *addr, unsigned long
 	memcpy(&seg->res_name, seg->dcss_name, 8);
 	EBCASC(seg->res_name, 8);
 	seg->res_name[8] =3D '\0';
-	strncat(seg->res_name, " (DCSS)", 7);
+	strlcat(seg->res_name, " (DCSS)", sizeof(seg->res_name));
 	seg->res->name =3D seg->res_name;
 	rc =3D seg->vm_segtype;
 	if (rc =3D=3D SEG_TYPE_SC ||
--=20
2.17.1
