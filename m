Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97147C004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 518CA2083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="IOkH/VxB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 518CA2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbeJAHQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:16:03 -0400
Received: from mail-by2nam03on0136.outbound.protection.outlook.com ([104.47.42.136]:2896
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729971AbeJAHQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:16:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rKp4Z5No91QSROT1Ol2PkABQmMBRiGlt0mkzvCdICo=;
 b=IOkH/VxB2vFE9xKjTwcO9gSsn+DqPgOtLyfiOR1OtEtsCitYX02pGvI8n0uWr5uv9YVzQhTHXbld6mcer+1KPNfpsLfPptmnmtaDzNblgL4xVo36HZqoHTW6R8DTP0niKHan8em9BCUeTmowwk/dgfN5XGzI8UeRKFCqDP4Kfzc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0165.namprd21.prod.outlook.com (10.173.192.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.5; Mon, 1 Oct 2018 00:40:43 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:40:43 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Steven French <Steven.French@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 23/26] cifs: read overflow in
 is_valid_oplock_break()
Thread-Topic: [PATCH AUTOSEL 4.9 23/26] cifs: read overflow in
 is_valid_oplock_break()
Thread-Index: AQHUWR9izkK9jmhcFkymP6Suh7uwsQ==
Date:   Mon, 1 Oct 2018 00:40:43 +0000
Message-ID: <20181001004026.147201-23-alexander.levin@microsoft.com>
References: <20181001004026.147201-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001004026.147201-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0165;6:kXstJSfhlQDDynWp6gy/zWaDgZBCP/KyqvKbtvDtCluOCuNRGcGScsYznf+7boiiDaRrpmlhLzw0e/gMGYsoP70j/rGeFLcn874hQ6/C2s6LRnkc1X43gmxWoYGtFUhB6ISJzM8rKKakvCkID8b8PcHcA3TfRfPRBtpuSK8yzI+bV8VqaJ4rvrsSxyfhvQF2QTcQA2KEtzeLHO5ndpuOIiTIAJigVYggqDfZaslZ96s3eN3qyWOI+1X+VTX6cfoJOiz5vws+6vV7syzBM+aphqm6FohCKVSp0rvh+VgVe9vIDCXoYrXfuaxWXBQo7xavwVd/pLbQxjjp/lLwIvcxZGkJCVlZzDINTE5ceTuPPDCdEp7qQyYF/ZgHdm6xB+Qy4xoqLOLo5FWCOVFRerls/L0M6jF4q0M86H60rpVHy18b7nVqQzUjFyMknDUsinIVHA/Iy3KRxzwJqUOn6n0BIA==;5:y+YNATlM5NJYhibTyEEpdvFS5Qns/Iqsdwwb5D4b7FVpfaf5FNiOHdXDYn4kn1mXvWCg9KVV+fJgRjNU4o7ntu6AHKhR65O6CL3++WkMQ2EEcpVwj6DhTqHtBfS90FskKTM/bVdTFl2zPKWIAajLFEPJn+moXqX/SUCRy0twU+Y=;7:rzPXnKsrUz4vhMQ9xWtXJqFK2nvLybdHOzFjgVHWKO0J6WjARBIWi+ZpTRbtxvIaQ7GCqmf3WzKgzkAkzdYUSav0PAQn8PZ1Lc4s5SPqtBLqH0uopnvSPK4AmF0eRxZLb4yodeo8KjIjHke2naMCOb9p1rDNiEOsc5691EAAIm8b97Z/6HGf7zhyObZOywiogjUb1s636LBh5vzn2pEKWAgYHvvXnlRr492LoKUVJo/AmcZujvKF/5BBfFydwlUa
x-ms-office365-filtering-correlation-id: 79119a08-8644-4d8b-6078-08d627368528
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0165;
x-ms-traffictypediagnostic: CY4PR21MB0165:
x-microsoft-antispam-prvs: <CY4PR21MB01653F38A238F013D1815178FBEF0@CY4PR21MB0165.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(146099531331640)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0165;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0165;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(396003)(366004)(39860400002)(69234005)(199004)(189003)(476003)(2616005)(256004)(217873002)(486006)(6486002)(575784001)(1076002)(11346002)(446003)(86362001)(97736004)(2900100001)(3846002)(6116002)(2501003)(110136005)(478600001)(54906003)(2906002)(5250100002)(6436002)(551934003)(8936002)(316002)(53936002)(14444005)(81166006)(81156014)(68736007)(5660300001)(99286004)(8676002)(10290500003)(26005)(6346003)(4326008)(86612001)(6506007)(305945005)(106356001)(7736002)(76176011)(6512007)(72206003)(102836004)(25786009)(105586002)(107886003)(186003)(14454004)(71200400001)(34290500001)(71190400001)(22452003)(36756003)(66066001)(10090500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0165;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: iqMU4NmmJudstM6kT20Xe+EvfTW58umS54MiRJoQR7bcbsja21X476eBiY5bQm4ZlJ6EEvQHm1Wv1OMrCOg1196WIqiFSq/H4+laADL1bLsKfp7ZQLoJ93IWk/9vB92iQBEjcwurNCjbGK9gkniEogrROsDbaXvY7wwy21fUkwSzkAPh2pZr6U56f4XsR6BHOp7nSBLuwA5wsX7VbJomhAComx0Dh4K8PDib+v+nJWJ2j9wYBMZWZnHP9+4UYUl54pW9Kz/mYJ8ZbeH/Re6PodYhTcbVNrCNT8gYCpEhm+u7y72e0cGA9NwDXx+mLQRjQxNYPdf/Pq5aeEvNHcGloh6Cs2VKXBz88rYiL96zEZk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79119a08-8644-4d8b-6078-08d627368528
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:40:43.3635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0165
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
index 323d8e34abde..50559a80acf8 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -406,9 +406,17 @@ is_valid_oplock_break(char *buffer, struct TCP_Server_=
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
