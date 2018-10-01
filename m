Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F44C64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A0A2083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="XOQkdI3O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6A0A2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729952AbeJAHWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:22:25 -0400
Received: from mail-by2nam03on0114.outbound.protection.outlook.com ([104.47.42.114]:28569
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728877AbeJAHPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:15:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYCjkAG9q5NPg2Js/kc+jiJC1K8iPzcRGf4pmOBW3mA=;
 b=XOQkdI3OnDI+wqoyL3lE100yhXdYrOgUVHPenY4iLKeUkkS6exnGFZFcpZtbMdsEiMMXxvi+6cRQLxBKe8VytMY9Xmo1iZytX+IU6vj/6vfI2hflZRgps2CQy7V4Lh+z4KJapqjz+KntSbjxQHAaAwB3To3bvzqliZiPDXaAIhY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:40:20 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:40:20 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Steven French <Steven.French@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 34/37] cifs: read overflow in
 is_valid_oplock_break()
Thread-Topic: [PATCH AUTOSEL 4.14 34/37] cifs: read overflow in
 is_valid_oplock_break()
Thread-Index: AQHUWR8tuSmTgxOQy0+N6J+eolliZw==
Date:   Mon, 1 Oct 2018 00:39:14 +0000
Message-ID: <20181001003850.147107-34-alexander.levin@microsoft.com>
References: <20181001003850.147107-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003850.147107-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:zkRvz9mNW01g5Eg9KCIrvJKqePNl/JSF5Dj1/WcDVZQBbXHsjLfxZJGjH+Nyjb1Wdmy+u9hhqpv2RXNvpqky9e34XATQ5+RUyizHxkxyLb7UsNJlp+ZZu36y/CH5Zye5QU4yfN4N5EhyuWL2mxJgfeCpNa9yCySqjZt26xE+2Vr9sJekQaDdRGbdQOuU/0zo7REvqkY12wmoULD/wrQJOaeIAZNxzT+iIEREqU1LsCHbYRnVyKwmR3hE3kKm2dqlnXT6jO73IGiqYOdN03V0Menw9DoS/4HoUSHtNfJoaNOBZK6S857LX2vzsk3H2uk3cGrjOtIW7vbbMZVaHm0TdKdmYXDgiVqccPIRibqSctjqjdRNY3Pn9lz39jpaUX7l3+SUC5zWZwJb5z7mNM19Xm0uVhE6UOTC9bX/kFCV2/dxxMb135QW5IGadLTW+Cy8hE8Ki199yKnKPwsoJU8VjA==;5:f3qPE66USr6XX4oVXwWIFiZCvDu+x5CIAAdd51JKav+NByrJerCx9I/9+e0m2a3Mxaa2Oo3rx/kp/AVstTsFm3E6j1/LG9GiYRoO6J24YXovQ0sn6p6ZAT4BEPlgfbs3KOlH2ttf6gu6CcdSYqDFpojaiyasTu3WXhcB17TxMzQ=;7:cq+Q7qSmYsXUwDjwqy/cNO7/Zehnw8RGyElEv7ykd7AmXKSUYH474GbFr2ukwm7gRJHzI+EMBvd3Rz9neU6KraeU87IEjQyiT1nU2hTpQMWi55H8Eo/tb9UE9o/iUmDZTCYkCUy509YVRs1pUH5oh3vaoF4Q/6w7Ya6FLjssnvVPdERx74ui1NE73UQtv146d/nnE4y7B48HdQ70XDZPm+sFmLZIgEIwqTVDfJ79Lzx+SKF4b7vwHCHje8NfQo4I
x-ms-office365-filtering-correlation-id: 39a969fa-16ad-4692-6042-08d627367727
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
x-microsoft-antispam-prvs: <CY4PR21MB0120D6C4494EE5BFA76A0495FBEF0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(146099531331640)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(346002)(39860400002)(376002)(69234005)(199004)(189003)(575784001)(86362001)(8936002)(6436002)(99286004)(6512007)(305945005)(76176011)(2616005)(68736007)(53936002)(34290500001)(186003)(10090500001)(105586002)(106356001)(86612001)(6486002)(81156014)(81166006)(8676002)(71200400001)(36756003)(54906003)(5250100002)(2501003)(26005)(110136005)(97736004)(6346003)(6116002)(3846002)(1076002)(5660300001)(102836004)(71190400001)(107886003)(2906002)(486006)(6506007)(551934003)(2900100001)(4326008)(6666003)(66066001)(446003)(11346002)(14454004)(7736002)(476003)(25786009)(14444005)(256004)(478600001)(72206003)(10290500003)(316002)(22452003)(217873002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 7ptjFI35DjP2VYBa/7pBjl3m50LSI3lX5mH93A04CazAIw8kjIKMttY3rsZ3PZnyeTR9kt0s0bCZn/zqzBo/wwjmZzZZKXRa9EAl8z2R3HwGn3zPHqxQt4kOGRW8SYEJ+DfU9Cpd8P3ceAKeKmVTaOdT88UCcTYEIijJePDTOJAK4Expf4RMDDSJEnM52J5vtkWExoLHBUuOKPQTLCqz7gxcBC+7hnwgnCv82Gec0YPSg51MmlJzB8/F9jroY2E33uTJiFqDzjfMt1KewRdawS3H/704At+Mns86odHEEzTrUNDqK/39vQF1JPi5Pjhg13CxHYpv9RMjwEJncTbu6ZENSCTO+dY1Y1Onl8945zw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a969fa-16ad-4692-6042-08d627367727
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:39:14.1846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 097f5863b1a0c9901f180bbd56ae7d630655faaa ]

We need to verify that the "data_offset" is within bounds.

Reported-by: Dr Silvio Cesare of InfoSect <silvio.cesare@gmail.com>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Reviewed-by: Aurelien Aptel <aaptel@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/cifs/misc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
index 460084a8eac5..bcab30d4a6c7 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -398,9 +398,17 @@ is_valid_oplock_break(char *buffer, struct TCP_Server_=
Info *srv)
 			(struct smb_com_transaction_change_notify_rsp *)buf;
 		struct file_notify_information *pnotify;
 		__u32 data_offset =3D 0;
+		size_t len =3D srv->total_read - sizeof(pSMBr->hdr.smb_buf_length);
+
 		if (get_bcc(buf) > sizeof(struct file_notify_information)) {
 			data_offset =3D le32_to_cpu(pSMBr->DataOffset);
=20
+			if (data_offset >
+			    len - sizeof(struct file_notify_information)) {
+				cifs_dbg(FYI, "invalid data_offset %u\n",
+					 data_offset);
+				return true;
+			}
 			pnotify =3D (struct file_notify_information *)
 				((char *)&pSMBr->hdr.Protocol + data_offset);
 			cifs_dbg(FYI, "dnotify on %s Action: 0x%x\n",
--=20
2.17.1
