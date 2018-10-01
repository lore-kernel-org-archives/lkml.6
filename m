Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CE2C64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F15ED2083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="nANXKUyZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F15ED2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbeJAHO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:14:57 -0400
Received: from mail-by2nam03on0120.outbound.protection.outlook.com ([104.47.42.120]:46043
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729495AbeJAHOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:14:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHzmngXDY+fEd4szAz8peeuPuq7fX4I05zsojM2pd+0=;
 b=nANXKUyZwZ8GVd4WOmLVwrlv6xOgEwPlYw6rMK4nL1/hjvN46FNHQ43rQBPiWEHyL6myGSq+EwXoPnzjeNEiGUUajSf0t2D0GaQ/dH7uHwqwo675DoFdCUyXqvNHVkUT+VuFPzeX5pMSzoCnFxizvZlWMbHLnaPn1+12Qh8Lmkc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0696.namprd21.prod.outlook.com (10.175.121.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.6; Mon, 1 Oct 2018 00:39:40 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:39:40 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Chris Phlipot <cphlipot0@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 09/37] perf util: Fix bad memory access in trace
 info.
Thread-Topic: [PATCH AUTOSEL 4.14 09/37] perf util: Fix bad memory access in
 trace info.
Thread-Index: AQHUWR8kzhoJuFyqaEmNRqL+ZI7FbQ==
Date:   Mon, 1 Oct 2018 00:38:59 +0000
Message-ID: <20181001003850.147107-9-alexander.levin@microsoft.com>
References: <20181001003850.147107-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003850.147107-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0696;6:VxzlkcmHbYUndAS56RmCH8OajrPNgMhS/95hdUDWJ5OT+lABKDS7PBrBXxgZ9HQiYdnUB5K4zEge0c7PdXwdUzpYYosVAG9r06YwqlDtA08OYDS2kRbgHtJjkcIUA34SDIohWEtIgWaRDIg1sNGVvcCp8LOwReylQW6J7RaW4MPc+VxEuAGZOHhR5oqKr2ouWxoSQJfxD/Q+AfjesBiLehckozWcD6ebZJuD3jFWaxbA43JZO+UruG0zkDwk0f2ACDO/n4IRGwrn/aFLDU8slomc/VHmmYHcjj/A1cwdm9heq/874XjrJUaEWAHqS0G90mClYXW7mIvU9T+QTby/nK1/ccA9GAsnyIyVOUQaiRwUzdeqJd22JZWtmK1ruN99V84lFly39B8LqO4Ld+bDLGsh+pwwswe+uJajiDqIoi5IzdUbj9kcQRp3Ok99QZqJAkJwTuypVQ790fxd+JkueA==;5:8glKrEg+bNAexUyNIKNvXASD9oM8Fa2rhrlBYp/HkCNoebKqdwZuU7E+0mdlIbCppTnk0YOjQJWmKZqRP00wwEcqLUrBomnrjsizz03wG2gmxRcmlY4hRUUC85GXV7b+x16uImx2qu5D51QEezUte0IROEhrle5HFgX9q4NTe/o=;7:U4aZepMV4zXKIb3uNuXcidH5ihhOW7zwq6mzbeu4v9N6LhNQ3lUczJogMhZD2lYWVmwi1SqvgdAOcftf0VgizcM9AyKbSWjPFsj5xxr5c8XulGHxd0oGhGZo6sXwGXGa/nLz5w1goyhAzlhPqriZbUo9/EOtCYXh5Qvy1nFF6MckBNYMD8KEmWF/MpFyXQbGFz5+ZAgYVWsLR7aH9lAWffZFkIFbJliANNcyOWLNiHApqtxvMWHufYlV1XtVgO4x
x-ms-office365-filtering-correlation-id: 28852613-248f-45ec-6590-08d627365fd8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0696;
x-ms-traffictypediagnostic: CY4PR21MB0696:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB069643874D9F5FCBACDFFF33FBEF0@CY4PR21MB0696.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(42068640409301)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(4982022)(52105095)(2018427008)(93006095)(93001095)(10201501046)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0696;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0696;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(396003)(346002)(136003)(366004)(189003)(199004)(3846002)(6116002)(5250100002)(71200400001)(97736004)(217873002)(71190400001)(1076002)(76176011)(6506007)(966005)(99286004)(11346002)(26005)(86362001)(39060400002)(36756003)(2501003)(446003)(2906002)(86612001)(102836004)(2616005)(476003)(14454004)(107886003)(10090500001)(14444005)(4326008)(34290500001)(316002)(486006)(22452003)(256004)(186003)(66066001)(53936002)(305945005)(25786009)(2900100001)(106356001)(6486002)(105586002)(7736002)(6512007)(6306002)(81156014)(81166006)(6666003)(8936002)(8676002)(5660300001)(68736007)(54906003)(110136005)(6436002)(10290500003)(72206003)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0696;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: GShEQnjtjdFwfGRwXbV4RFV+zGgdeHqqMm4ZkruAJoMRRW9ejd1N1Ng6+sG5fbwiTQ5Xov1cwNRVVQI8AuPU6XqKYfs4KGTX1iSQmx5BubtPUwweE6dwn0PcCUeFdE8xbFXjus+qQjQxqtdSFI2xGxH6+fr34AMw46f3xKnPsZ9SuDvByHypNN6LbbleDD54Gs7/bk1D6aUChx1EHPi5JSyoJJ/jOrHYLc9wQtD0ks5TlEk3ugeBpghNdRkIJ3opbtLJZ1TC0M3uUdJhOtt/S115XON3YJjU8G9djsf81N6f8JlrCMX3qGYJcXLq7NEYufONbDQlSieLYZy669ni5cZwnKeJ6ACwAe4yF31G9mc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28852613-248f-45ec-6590-08d627365fd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:59.1392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0696
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Phlipot <cphlipot0@gmail.com>

[ Upstream commit a72f64261359b7451f8478f2a2bf357b4e6c757f ]

In the write to the output_fd in the error condition of
record_saved_cmdline(), we are writing 8 bytes from a memory location on
the stack that contains a primitive that is only 4 bytes in size.
Change the primitive to 8 bytes in size to match the size of the write
in order to avoid reading unknown memory from the stack.

Signed-off-by: Chris Phlipot <cphlipot0@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180829061954.18871-1-cphlipot0@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/util/trace-event-info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/trace-event-info.c b/tools/perf/util/trace-eve=
nt-info.c
index e7d60d05596d..8f3b7ef221f2 100644
--- a/tools/perf/util/trace-event-info.c
+++ b/tools/perf/util/trace-event-info.c
@@ -379,7 +379,7 @@ static int record_ftrace_printk(void)
=20
 static int record_saved_cmdline(void)
 {
-	unsigned int size;
+	unsigned long long size;
 	char *path;
 	struct stat st;
 	int ret, err =3D 0;
--=20
2.17.1
