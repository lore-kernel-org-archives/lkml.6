Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA599C64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4E9D2083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="OGGZZxbA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4E9D2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730225AbeJAHRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:17:04 -0400
Received: from mail-bn3nam01on0139.outbound.protection.outlook.com ([104.47.33.139]:31049
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729679AbeJAHRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:17:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0wIH0dkrLykTFZBG9jjtdIwzxfGjPgJSD3tIzEHvMw=;
 b=OGGZZxbAkoRdoC13g2uhev5xEPeg2TASQmTLWWLQwOQCMO163ba84TvBm8/8oOx1nZ6VI6ZCljVcesrqnv387NVjf11dQj6oNBj0G8lwbhp5EHHT0oxIiz3970cqT9tk/dY/I+AKIfubO3wqZdfo4FhlIXMDuBB8k3KH8awl/T0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0184.namprd21.prod.outlook.com (10.173.193.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.5; Mon, 1 Oct 2018 00:41:52 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:41:52 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Steven French <Steven.French@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 11/13] cifs: read overflow in
 is_valid_oplock_break()
Thread-Topic: [PATCH AUTOSEL 3.18 11/13] cifs: read overflow in
 is_valid_oplock_break()
Thread-Index: AQHUWR+L4+TXqCr6uUWEd1IzISYn1w==
Date:   Mon, 1 Oct 2018 00:41:52 +0000
Message-ID: <20181001004139.147341-11-alexander.levin@microsoft.com>
References: <20181001004139.147341-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001004139.147341-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0184;6:JThtb/YoF9MHxTnqJmrxxs2A0fztQQm06wt7Lsf91mnRW2aBdfkqH9M61DC9dVPjFTcmyXHDUs3TLVxua8UMUbFQkChG92qFyNzyek10OCePCewSg9BjSmHK83HSvsb3utYpITb+piPzCvwNiHbn/pMUGVM8y09lNiigQ4TL/U8yKHym5S7h7YEArVY2G9ufWham1UPcFchWqCsqtka2MRdYqzMiDIQ8Zf12PFi6HtXcWaZjN+QJ9XqCJQNXpWo/BW38VWNyup7XxTso/s2/F9Q/XFiKh77OtBcHM/5IxNEvQ6vGVD7MQpADLz7JgcV6xwL4RbRrkgjKpZLUMcoSCmJ25qDjddhGHa3ams4BXZzgI7tIL0a3VRd7AEpYcMyuIIyoBDlJ/dMxC4tDl+zHD3Pkr0kZLQyK5YZJXkMUP9+4gnkNyF6nCMrQeAzGYu2GduIQdJDsc9iTOqxYL0tX3w==;5:FVyCaH9ckToPJ6AXWTr39zDiJF5vJaCsIJKmoXFaBnYbksDSek3G5VZbX+mgHXj/hn6O9dzmmiBUMpmhPuGTMsp+E3/c47ydQJRD6Pf6TDtPcS88eKhm293HF331Ln4jFVU4YxDJ0dmvGxJN27PRKHsCs4K9H2Q5WJruFYcEV/w=;7:t3PR/cqV/s0eoLV8MLwIWYELWyjDxV4FYDemvT4Qd0x7o4IlxNlKNOhcYys2xUC1yNnNdXHXGzauNFLjAbnTdvXri58x6cP1972Su+v/NkV2jgyNKZM/qP/imlZw7F3NcXE+docFD3LERZS0UNToSpN4nzx7N+ac4rApif15dxu0i9uL/ZC0OwIaJzOih3tgDdhXsnBOli6rqq85YCf41Zob98xtqb1/dPB+bTAOG2w4O9r20XnAQRDMXPf3ro9m
x-ms-office365-filtering-correlation-id: dc281e36-b9ea-4d61-c982-08d62736ae24
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0184;
x-ms-traffictypediagnostic: CY4PR21MB0184:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0184EE428C139DE5E7D31E8FFBEF0@CY4PR21MB0184.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(146099531331640)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0184;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0184;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(376002)(396003)(136003)(346002)(189003)(199004)(69234005)(4326008)(72206003)(99286004)(5660300001)(102836004)(11346002)(1076002)(256004)(14444005)(186003)(107886003)(2501003)(36756003)(26005)(105586002)(478600001)(6512007)(86612001)(446003)(10290500003)(86362001)(575784001)(71190400001)(5250100002)(217873002)(2900100001)(3846002)(6116002)(66066001)(14454004)(34290500001)(71200400001)(53936002)(486006)(68736007)(2906002)(551934003)(22452003)(316002)(97736004)(2616005)(10090500001)(6436002)(54906003)(76176011)(6486002)(476003)(6506007)(106356001)(25786009)(305945005)(8936002)(7736002)(110136005)(8676002)(81166006)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0184;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ERakoAR04Mwhr/gUNMlOM3oHmxlfCjoMz+9Ro4p00K6/fkeXt24QdeJ5Lg+/RJt2F/rcYAvLlBEBz6OHC8p1Hk+KRZ3fsh2vuRcE3+8YL/c2bE3rOyofoMmjqD8G0tO/B3o56qoDSLGXEFInzvvTN92RFFq0e66IWphrZA4yHdNeNW+UNC0H9l1JJpzOhr3kMiBtFbreA0TVhw5TQ8/6aOx5SXcfLaK0G5rOOXR9Pw0BuiyoFmM9LHMOPXPeDinIJ5iKPhIEaaB+IF4n5ypKjiMgRW2fYbNQK1SPUA05xAkYzI8RgemfgYqVbC6BbwhhPZsemZVJZdbWCyCwy7m41H5m3Bfrkg2jEJdbIe34kNg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc281e36-b9ea-4d61-c982-08d62736ae24
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:41:52.1606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0184
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
index eedbc34e19db..c8662e212afc 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -405,9 +405,17 @@ is_valid_oplock_break(char *buffer, struct TCP_Server_=
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
