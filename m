Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3B3ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75AFB2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GvIoPmlv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75AFB2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729817AbeIQI2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:28:48 -0400
Received: from mail-by2nam03on0130.outbound.protection.outlook.com ([104.47.42.130]:60384
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729758AbeIQI2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:28:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jnaoH0S3V4TkjLWiwdVDQWbItIymWbxHUBb2m5LioY=;
 b=GvIoPmlvVRRMPojzJ6eQcngzqT6vbq5CpvYzRunHzgUy24a30XaBuvRKeNoohzfrcmAZhCKfogO41hF0Aq3EkoXIbJraqDgz6EFdbRpBfHEv8MD9NQBTCOw+pE7jwCUrNbH8ZM2lcI3ddAV0hwLcMxEkqFeMSKjkWkxvinpp+g0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:03:29 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:03:29 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 04/87] vmci: type promotion bug in
 qp_host_get_user_memory()
Thread-Topic: [PATCH AUTOSEL 4.14 04/87] vmci: type promotion bug in
 qp_host_get_user_memory()
Thread-Index: AQHUTjLd2H6zwutJ0EyZqm2KlvdDfQ==
Date:   Mon, 17 Sep 2018 03:02:26 +0000
Message-ID: <20180917030220.245686-4-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:spwcqE1aiawTA7X83lzFffYxf4G4VLmBXlZb6nMaBW57dKZ4yZXyuLixb8f/01PfNUrb/NFjN00iTL2AhWaZLFuAzQTdGw5tJo+3NBJgpG6ZwcVRLUPTFqb2xD+uvdx5PdmAZR5UR/CZfKmg6DRDEsoe19FO79AyOrSmxFsUz88JbmQbmZ8r8ZEfGa5HuqhjeZHMgocfliTI5rydxIoDrqWmU4lGKeEB+HsTPfBwtmKw+j1Wt0koPo1RL7DKaMDfV0SWu2vHHfjUMWyDM/oOqzvzlaq0SrabdYvEEegPdbJSGArYrW6tQqe2QolXigeZzhvOZ+Twp12odZ9k16+ShWb19AuPq/OhupGp3QSFNGt8s2Vev230p8irdSphoBYnNj32oUXNN1dpuzEugFlWdrJShCGVLSFNrwFZPdfQ0je8aA7PHptUSfqCDgCpDcTONi40bWsp6ZnLFcHdTD5BcA==;5:+rodRIeTI9NL61eOGJ3tCIiKQJPeMGK6IHTh25vNUkDxWfnGH9m1dIELV4Phi2OrOGFAsSMJzAk1inw5P0MHWrYnbf43O+E4JhgHEyNcrZW45bTb/zu5f6+dpqKLdpcM3V36Cri4qFP+j6v39HQznWB8E8wRlzqhkIzFE5m634Y=;7:blP+2enODkP2cET5LqhyzyPQretakVw5kIrBa1FWysKz9GwoHNoqUn4Siqg/1piv4diHJYPk3HdIO/F7rCjVkuzFZaUrMwBl7gcjHJg0XZ1wJyuIXq3UMeS98u5dQXWxxtiIA3tJv3M8aAnc8Z+25DLL8sW2ph8MPHYQyBFBLXid9CVVq9TcsWKmbT4ul5nV7jU8+4dz14LytMHtn61Em0AwayK70+Fn/cHr/s3/qr9LOCwwi93ILJfYKYmlom4+
x-ms-office365-filtering-correlation-id: 45dbd05c-0b96-446f-b853-08d61c4a24f5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
x-microsoft-antispam-prvs: <CY4PR21MB08554F79ED23C600D80A2B91FB1E0@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(136003)(366004)(199004)(189003)(6436002)(99286004)(7736002)(110136005)(54906003)(97736004)(5660300001)(66066001)(446003)(72206003)(76176011)(86362001)(86612001)(81166006)(81156014)(2906002)(478600001)(305945005)(68736007)(105586002)(2616005)(106356001)(476003)(11346002)(22452003)(6486002)(10090500001)(10290500003)(8676002)(36756003)(6346003)(6116002)(6506007)(3846002)(102836004)(107886003)(6666003)(6512007)(1076002)(25786009)(217873002)(4326008)(14454004)(26005)(256004)(486006)(186003)(316002)(2900100001)(8936002)(53936002)(5250100002)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: Whi2qlJR6DnwXmls8pLQwcDW86kEOb7Nl/leR510Djj/1CXPyR7ly2H8j0uyy831ie9RCCYxRkI3z17vw/PqLnxa0herLXWTFMvIV0c0urCPePpdP16e/PzVmbE4Nq8ZcCYaPmzgCvtBASR1NJ8D0GBujP7iWCYzeAmiynYRayqKB4I+mEDcr0J10wgW5qhTyc4EM5C6WsaWK7D3mEYeSY3cZX0J/uahR329nM2f+LyOYfq/i4xt49K0ibCogGF5RX+j9M1xkLKcewrJwSJsU+e4omkqnvMzJDwKzKTvOlEr/eVEpt6r4E4LynKNqemAPnGucthpXOy7hIZOVBRxuzXrLMFCzFE7DPiBbPtc0YY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45dbd05c-0b96-446f-b853-08d61c4a24f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:02:26.9314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 7fb2fd4e25fc1fb10dcb30b5519de257cfeae84c ]

The problem is that if get_user_pages_fast() fails and returns a
negative error code, it gets type promoted to a high positive value and
treated as a success.

Fixes: 06164d2b72aa ("VMCI: queue pairs implementation.")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/misc/vmw_vmci/vmci_queue_pair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_queue_pair.c b/drivers/misc/vmw_vmc=
i/vmci_queue_pair.c
index 8af5c2672f71..b4570d5c1fe7 100644
--- a/drivers/misc/vmw_vmci/vmci_queue_pair.c
+++ b/drivers/misc/vmw_vmci/vmci_queue_pair.c
@@ -755,7 +755,7 @@ static int qp_host_get_user_memory(u64 produce_uva,
 	retval =3D get_user_pages_fast((uintptr_t) produce_uva,
 				     produce_q->kernel_if->num_pages, 1,
 				     produce_q->kernel_if->u.h.header_page);
-	if (retval < produce_q->kernel_if->num_pages) {
+	if (retval < (int)produce_q->kernel_if->num_pages) {
 		pr_debug("get_user_pages_fast(produce) failed (retval=3D%d)",
 			retval);
 		qp_release_pages(produce_q->kernel_if->u.h.header_page,
@@ -767,7 +767,7 @@ static int qp_host_get_user_memory(u64 produce_uva,
 	retval =3D get_user_pages_fast((uintptr_t) consume_uva,
 				     consume_q->kernel_if->num_pages, 1,
 				     consume_q->kernel_if->u.h.header_page);
-	if (retval < consume_q->kernel_if->num_pages) {
+	if (retval < (int)consume_q->kernel_if->num_pages) {
 		pr_debug("get_user_pages_fast(consume) failed (retval=3D%d)",
 			retval);
 		qp_release_pages(consume_q->kernel_if->u.h.header_page,
--=20
2.17.1
