Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E10ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2EC921477
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="CkMEwtz2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2EC921477
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbeIOGrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:47:43 -0400
Received: from mail-cys01nam02on0090.outbound.protection.outlook.com ([104.47.37.90]:32953
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726128AbeIOGrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:47:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XdgPDJoWpY6d8hjTicgdZ+2hyY06GuVl8k+HVgZNFho=;
 b=CkMEwtz2h6pqNivhLdcY0D6rWfwEP3JY/WIxgfKfonj/mo8dLTNsh1aKCpY0gQwKvEI1OBd7Tq969kbBAscg2tjGHnnczifMmATVfa3dqFQt0dWw+coULINNvNIEcmxbqUOQPYrRi9xD9Lr+D+4WdacoBX3lLqQ6kgjf0i17Ik0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Sat, 15 Sep 2018 01:30:42 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:30:42 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Rick Farrington <ricardo.farrington@cavium.com>,
        Felix Manlunas <felix.manlunas@cavium.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 31/92] liquidio: fix hang when re-binding VF host
 drv after running DPDK VF driver
Thread-Topic: [PATCH AUTOSEL 4.18 31/92] liquidio: fix hang when re-binding VF
 host drv after running DPDK VF driver
Thread-Index: AQHUTJOlpMUaV0hK3UakjfuraClSTQ==
Date:   Sat, 15 Sep 2018 01:30:11 +0000
Message-ID: <20180915012944.179481-31-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0741;6:LuZ6GO9G5TqdD9fO9vONG4hoETQCps9EiYPDNq+c+0wNWOV99pJWXTjvmRDt2sPODi6wOZTOCwWGsuSgEzgszhTOQQsoCZU1hhx6etC+8vOtMUGs8nOoEMaoKCktTgx7ZHkrQM/z6nlNO77DCnuVmJdUrRzsDJ63S3Bv+yrRixpya2CiUU4LRnlKQ5VYMjcl1661qtRSD5ixlpS5mQvkHc0Acm0cdrbxHHcYhy/3gE5m/29gZJcQx2tWQQVugldzepmiRuuG2jzywSxG+q+bUlXYa6wy3k4PNZVws4AyM9aUaa/DU+R+DkGo9QWufyCL46JAherB83IdQx/WwU50OWpKJDtoOdw/pAScBbsvceAOS6mZzci/EWHSCPHrGQl5CRUVmFLN2RjBq1kCht4J7j6sopTpveL6zdvOhH2Y4ARpkxXEy/8xOhUKXDGVg8dxwPeqGRhQ9OqkkygvVrVNSg==;5:0QOwtUZMmgsezaPCrBvHHwxN2uV52dRW9KHvOmno+k2ZIlm3Gpu6yAogi5Kwgv2+n4wQzXp3Sp8ratGVB5WrdMLSnQ4TSlGvxIIFjP3hrN9MQmHvD3PY7foCMclBcjhxXs+Qk+PY/Uuf+ocRxePMhJGmanTLZCHNV9CbmbSR/TA=;7:yi4qEmkVK8HzA8YbATM8YM9MCCFG1ImL/sQbiJK2U4ql7TiI501hJC0Ipb1NZM/Ufig0nV0bJ2hb7EyBt3rGI7mLuc7F43L7UC1zJHQzBOduOvaAyvTGNMnj0oLY7xmw9G5YPnF7b7QrSfkY30FTdAdYdWqKHSFaziNmMb+T2X3MeZ8nq5dy4lFFRNFRQlLI+Emz/ToLB3fKyTS8eOAzt+GC45gfZ/EiUQ47RrKURDajxTg8dAAMwxqR1pe/Dah1
x-ms-office365-filtering-correlation-id: c26000a2-fb16-410c-d7e3-08d61aaad9d9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0741;
x-ms-traffictypediagnostic: CY4PR21MB0741:
x-microsoft-antispam-prvs: <CY4PR21MB07414B6FEE8F26A33CC5B899FB180@CY4PR21MB0741.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0741;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0741;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(376002)(396003)(346002)(189003)(199004)(186003)(106356001)(25786009)(6346003)(6486002)(6436002)(476003)(102836004)(11346002)(5660300001)(2616005)(26005)(217873002)(105586002)(486006)(446003)(4326008)(53936002)(5250100002)(14454004)(10090500001)(14444005)(2900100001)(256004)(6666003)(2501003)(10290500003)(6512007)(22452003)(72206003)(8676002)(478600001)(110136005)(97736004)(68736007)(66066001)(81156014)(81166006)(2906002)(99286004)(86362001)(86612001)(575784001)(6506007)(76176011)(8936002)(6116002)(3846002)(1076002)(54906003)(305945005)(36756003)(7736002)(316002)(107886003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0741;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: FrHJxRowtv31uVMk9O+wtHNhEvVUUmrpfmtIVudz0iSWVAR6dxyZ3Ko7yciyicqS6DI9ZSY8cmGDn8rV3uB2OpMXdaLOMYxhz14WywsUPxVAZUTNSxwRB3c0n2TQRLJs0e/SIp8igr+HRDtDhHjyLaAwdLtWocRbXlEiy5bKqSXjnGvY1hvbQGnL1FpzkoLbbDlszliwCWB44Wl5sYSmQcK4fMqcrqHUQaj37A2BMYft/BAZs0ig7RaMEgp6My4PgmbBh5fV5V6YiC15VPYR9hL4Bh/mNoE8ZSOWMQheUqxngU7OMihZf2UrgqHTied0Dq783WhW2Ld8AmPBN++tylYc4QsNH922SEMjQOuEvtk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c26000a2-fb16-410c-d7e3-08d61aaad9d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:11.9794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rick Farrington <ricardo.farrington@cavium.com>

[ Upstream commit ac13d6d8eaded15c67265eafc32f439ea3a0ac4a ]

When configuring SLI_PKTn_OUTPUT_CONTROL, VF driver was assuming that IPTR
mode was disabled by reset, which was not true.  Since DPDK driver had
set IPTR mode previously, the VF driver (which uses buf-ptr-only mode) was
not properly handling DROQ packets (i.e. it saw zero-length packets).

This represented an invalid hardware configuration which the driver could
not handle.

Signed-off-by: Rick Farrington <ricardo.farrington@cavium.com>
Signed-off-by: Felix Manlunas <felix.manlunas@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c | 3 +++
 drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c b/driv=
ers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
index 929d485a3a2f..e088dedc1747 100644
--- a/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
+++ b/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
@@ -493,6 +493,9 @@ static void cn23xx_pf_setup_global_output_regs(struct o=
cteon_device *oct)
 	for (q_no =3D srn; q_no < ern; q_no++) {
 		reg_val =3D octeon_read_csr(oct, CN23XX_SLI_OQ_PKT_CONTROL(q_no));
=20
+		/* clear IPTR */
+		reg_val &=3D ~CN23XX_PKT_OUTPUT_CTL_IPTR;
+
 		/* set DPTR */
 		reg_val |=3D CN23XX_PKT_OUTPUT_CTL_DPTR;
=20
diff --git a/drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c b/driv=
ers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c
index 9338a0008378..1f8b7f651254 100644
--- a/drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c
+++ b/drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c
@@ -165,6 +165,9 @@ static void cn23xx_vf_setup_global_output_regs(struct o=
cteon_device *oct)
 		reg_val =3D
 		    octeon_read_csr(oct, CN23XX_VF_SLI_OQ_PKT_CONTROL(q_no));
=20
+		/* clear IPTR */
+		reg_val &=3D ~CN23XX_PKT_OUTPUT_CTL_IPTR;
+
 		/* set DPTR */
 		reg_val |=3D CN23XX_PKT_OUTPUT_CTL_DPTR;
=20
--=20
2.17.1
