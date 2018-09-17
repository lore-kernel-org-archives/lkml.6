Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E23ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 728C7208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="E0BrRr/2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 728C7208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730086AbeIQIvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:51:06 -0400
Received: from mail-by2nam03on0130.outbound.protection.outlook.com ([104.47.42.130]:60384
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729856AbeIQI2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:28:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6N5Jnr4ENJv+xJ20d1YHW/mjdXT0m4uAwXL2R/j7gC8=;
 b=E0BrRr/288HkVAJAfZwBZA0S1szHSHbnnkHsHPSJzEjBPGLgVEFtKskGUEQFlUNsGnllaGCBjb2uF1SHFPINgfGN+fDeJb8UPjLqSm/cZt2+ZqGNNc1GHZ2dbMCAtxalcnwNig8JQ0ewsBc/Dk3vgHrd2vEN32yp7/gEoDU5Hak=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:03:35 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:03:35 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Vasily Gorbik <gor@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 17/87] s390/mm: correct allocate_pgste
 proc_handler callback
Thread-Topic: [PATCH AUTOSEL 4.14 17/87] s390/mm: correct allocate_pgste
 proc_handler callback
Thread-Index: AQHUTjLiWdjoODiweEqYPRwlyYu0xA==
Date:   Mon, 17 Sep 2018 03:02:35 +0000
Message-ID: <20180917030220.245686-17-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:RJYaT2lO7Li48izAFb4bPcA8abGhwW90HJ6ZsJuZMILzYfZaUD4S7xTbh+6CBjz53awrS148MAor7sAKNHg+gKlqkYMhpvL127iShFpQoSPm4ZRmaypnSHZooVZ2ftjcQT6+KCEJdwVs/TkRJZP+otuBWlEIjPoZe9Gm4R8QAO7yE9tIIfUe/jkOgNfj3MnEz79DNQSPJYtbVNxWKT+o4kKmXdlRlh7+p4lfhTPy+zE0WVggju6Mo7639FtlRrumyMXYeTsQeLNLO1dQB5z7cXlu3ZcVkO6RcGlHeD0LRfGgnCq3eLp0fnSdo7Kj9dtg1L8cg00BZbKV1ALeM6NKRvDKtSOOhYtsWGWVjc8BXawQReMXH6ZbZ/BfV/fJaMqdCoPMNQQJvSY3KNWtz8UAjUp0msK2eDh3X5XzR3adq7WI3+erESU6nhsnUOcVg3yOJI18QDMGPQFZ1Vu+xJsYjQ==;5:TkUNg2iXivlJ2ojonDHZOVZxGo/dRVdXWr2onbiUXOuv1vPLGvb7eoPM1JTpW29td1VSh6OAbY7s3WErTwbNVV1yfatRtuDGOKZDkU2scQupYQP71wslwB2vgAtVxFfn9hpgp9V9/3S5xjuZ/OmDgn+jZSLXO0dh43FSTBQrLyw=;7:ajHqoXRKUGr7O9OjIg2ikSALd78nbfbky3jLdfFIz9650yCX2iAFgWiZolof0Hqfc/inddhcJYi1x9u8mi55DdTUIpJpmpTlrNX+CH5vhS0s6Grw/CqW9sWuAqW/YrpjMAQJJ6QodxLxf3sa73BBy1PlW8TrTFIR7FOuwgEBdwenugVhFjKFPBTnG6liW8eu9EXb4TMUNd4vH/TlqwPae/IcZZk9LyEmNaFfMX9NvFyyAWMhTu5jcKzDhx4iKQnh
x-ms-office365-filtering-correlation-id: 2ff954c5-0ddd-4339-26a6-08d61c4a28b4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
x-microsoft-antispam-prvs: <CY4PR21MB0855B27DDB7DC6CA2DCFFE55FB1E0@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(104084551191319)(190383065149520)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(136003)(366004)(199004)(189003)(6436002)(99286004)(7736002)(110136005)(54906003)(97736004)(5660300001)(66066001)(446003)(72206003)(76176011)(86362001)(86612001)(81166006)(81156014)(2906002)(478600001)(305945005)(68736007)(105586002)(2616005)(106356001)(476003)(11346002)(22452003)(575784001)(6486002)(10090500001)(10290500003)(8676002)(36756003)(6346003)(6116002)(6506007)(3846002)(102836004)(107886003)(6512007)(1076002)(25786009)(217873002)(4326008)(14454004)(26005)(256004)(14444005)(486006)(186003)(316002)(2900100001)(8936002)(53936002)(5250100002)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: Gy0Vud1u9ICyPPKiOvp0bE+Na26w49CRHrbdTMLmdg87MqwCR6MPkg65eHB4Ggd/L9+uMgWgMGau7woRiRwWqvN28mcbOExT5oCo9grcyD7w+scbfypZ4Yo3OqSABvrLrctjaJBdKlM7Xn2gQJFkhjIr88s58mLgXCIEa6WyY3fvB+LPdrbp/yGEKdW47JSvm2EufNm7Niei2xgwT2k4V9GuahnrIMUT7MSqMFujTEct6JES5veZN8M9S0d1om+5d2bFZhhfk63v+Y0dyHe1jYdBTodX26WEX61YXHuNs7Cv65LI3nAiyBw5dcsaHOe0Pk9BkLmsAb9BI4ebhaV1rsLoixSKq2oIbfId+PZtgdk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ff954c5-0ddd-4339-26a6-08d61c4a28b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:02:35.0876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Gorbik <gor@linux.ibm.com>

[ Upstream commit 5bedf8aa03c28cb8dc98bdd32a41b66d8f7d3eaa ]

Since proc_dointvec does not perform value range control,
proc_dointvec_minmax should be used to limit value range, which is
clearly intended here, as the internal representation of the value:

unsigned int alloc_pgste:1;

In fact it currently works, since we have

      mm->context.alloc_pgste =3D page_table_allocate_pgste || ...

... since commit 23fefe119ceb5 ("s390/kvm: avoid global config of vm.alloc_=
pgste=3D1")

Before that it was

       mm->context.alloc_pgste =3D page_table_allocate_pgste;

which was broken. That was introduced with commit 0b46e0a3ec0d7 ("s390/kvm:
remove delayed reallocation of page tables for KVM").

Fixes: 0b46e0a3ec0d7 ("s390/kvm: remove delayed reallocation of page tables=
 for KVM")
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/s390/mm/pgalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index 334b6d103cbd..29653f713162 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -27,7 +27,7 @@ static struct ctl_table page_table_sysctl[] =3D {
 		.data		=3D &page_table_allocate_pgste,
 		.maxlen		=3D sizeof(int),
 		.mode		=3D S_IRUGO | S_IWUSR,
-		.proc_handler	=3D proc_dointvec,
+		.proc_handler	=3D proc_dointvec_minmax,
 		.extra1		=3D &page_table_allocate_pgste_min,
 		.extra2		=3D &page_table_allocate_pgste_max,
 	},
--=20
2.17.1
