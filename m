Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C600ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6832B2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="kWaQ4jxJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6832B2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbeIQJDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 05:03:35 -0400
Received: from mail-eopbgr710124.outbound.protection.outlook.com ([40.107.71.124]:62784
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728036AbeIQIZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:25:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+gCOm8k/oKPb/uwWtsy266IU0wyj0BgqvtC/ZiqPto=;
 b=kWaQ4jxJ80m1opXCAVVSAg8WVtyD2yqu61JY23Dc5OlTE0f6pT8UeiVNytreBT+AtRhzUr5IrzX37InQxTMihpXaBVC4PkHqQt+u5eTpJMj7t6PurcotounbkbzKexfnxDJb+Z30YHjMxViiupTT8GnYBtnCyT5E2VWLmnJrGao=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0134.namprd21.prod.outlook.com (10.173.189.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Mon, 17 Sep 2018 03:00:14 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:00:14 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 005/136] vmci: type promotion bug in
 qp_host_get_user_memory()
Thread-Topic: [PATCH AUTOSEL 4.18 005/136] vmci: type promotion bug in
 qp_host_get_user_memory()
Thread-Index: AQHUTjKO4PYqOSy6V0GMYHxZIZGsMw==
Date:   Mon, 17 Sep 2018 03:00:13 +0000
Message-ID: <20180917030006.245495-5-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0134;6:/mcITmbCIHhPwZ6jNcoymkQohavOUsNEUJMQ+PT9FuYppJ2AHFVvpr6U1uDJwYZnKoz1/BzObI/ebKSq/xxj+AToqHtnzgAzNxHIuG7tU2V/sF2AH7z44LuIRwtLhvLwKDPz91nR8C4oLeh7EA0KAqBzchoH3KTZO9N7dKFxDxnMz6wqPwSsCpwvRI1DA3R+14OrLj7a2S5yTNmikzS+LrOSBw0/j/JVD72vHPfB+RSkwuQBAlxcgVoE7SFa8ybc53I3kp3Icn9ywRffunCzgCahqe44Yl32pNQxBtWMvRWNNkAS2ng4OLnUaS8WesJc/FBKp06LGnMp4RlUZiViOXfvMN4mDxqd+BwCBQ9JlgZw9kmQ0bWJydtDTbsPTJQ+Aai9vnm0EMRAp0JdBQq86QfTloZPSWV7LNf2P/DI53SG0ZC0KntJRbwmP7+LYGdgflTgs8+DeqbCJL1U+QXPvg==;5:/ImV8+LkpcOwlevC+aJ9unuYVypWERQ4ZzFDfL2wmRKthq8oi8Xmw3BsPR6SR1oM/PeRwtGR+R0oM7/nUJVABvtM6GzlKw//60bIbMug75BKEkgpqDtmNHErg9A2X77wfnfPuO60hdJBCZ4xGYF2eoVB2U670IcCeHFmNqUqAiQ=;7:wwow3yi/pTjtvbB8LbKlpz6osdlc8ZsnO1fg9KUwf8RsuZVjJeJEu1ARS7QvixxlZGtGszZH5ovN1FPiACmGMUZz79UY+pFT9W0nzIt2pp+1pedngj6KoNMuB3ntbogesGfWpY03fom97XX4n6TuKYzd7e0jLivZ0V07y7iB/bSvb3cRI+j/I2MMlvG+UZ7JBCWysJPAhtYRaLt5CjTyXf9YfOhL1M3M245GPpaKBZcLC9/S3ixaUNchDzT/NptB
x-ms-office365-filtering-correlation-id: 3bdd61e9-ab5b-44cb-5d12-08d61c49b0a8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0134;
x-ms-traffictypediagnostic: CY4PR21MB0134:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0134C08F73276FE83E3666B6FB1E0@CY4PR21MB0134.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0134;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0134;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(346002)(39860400002)(136003)(199004)(189003)(6506007)(10090500001)(14454004)(99286004)(76176011)(68736007)(6512007)(4326008)(25786009)(217873002)(107886003)(72206003)(22452003)(256004)(36756003)(54906003)(110136005)(8676002)(6486002)(97736004)(10290500003)(6116002)(11346002)(26005)(7736002)(86612001)(5660300001)(86362001)(53936002)(316002)(486006)(476003)(2900100001)(5250100002)(105586002)(102836004)(305945005)(106356001)(66066001)(81166006)(81156014)(1076002)(2501003)(2906002)(6436002)(8936002)(446003)(478600001)(2616005)(186003)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0134;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: qy1NHNHEn2Tkd1mV9bjpgyx9Xbt5WdVpRCLIBHDs0zjGmNPZsUibmiG+QFPa3FBrPSH/bF9svw9H3tLA9P55Og/F0LCv86ntVtGkvt2b8VJytlkCCxxTWu6ISU+DVfOXbkSK91IYbNI07UqIdMV06V9tELmraVvoWM4Y/cqWdJvczLHwl6Hrko7ZgKDUuRv4ejhEFN/3zjzAuUhqpkpaXzVPTdE5Ga1TcSn3JkFpm9B33+uzmVZO+yLTgCvFeYbNdiZ4WzmkgnbgTA68z06tnmjeLYHwAg8GzMRpu55s1NUWPYPQrHk+B0hmkjMmjVL7ZTZFhEQUnWobZ3+dnyUlgY2SLc6vqApaqFnY3uTYha8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bdd61e9-ab5b-44cb-5d12-08d61c49b0a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:14.0424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0134
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
index b4d7774cfe07..d95e8648e7b3 100644
--- a/drivers/misc/vmw_vmci/vmci_queue_pair.c
+++ b/drivers/misc/vmw_vmci/vmci_queue_pair.c
@@ -668,7 +668,7 @@ static int qp_host_get_user_memory(u64 produce_uva,
 	retval =3D get_user_pages_fast((uintptr_t) produce_uva,
 				     produce_q->kernel_if->num_pages, 1,
 				     produce_q->kernel_if->u.h.header_page);
-	if (retval < produce_q->kernel_if->num_pages) {
+	if (retval < (int)produce_q->kernel_if->num_pages) {
 		pr_debug("get_user_pages_fast(produce) failed (retval=3D%d)",
 			retval);
 		qp_release_pages(produce_q->kernel_if->u.h.header_page,
@@ -680,7 +680,7 @@ static int qp_host_get_user_memory(u64 produce_uva,
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
