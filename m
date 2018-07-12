Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13763C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 965B02147C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="WE9iC5iJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 965B02147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732516AbeGLPAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 11:00:11 -0400
Received: from mail-sn1nam01on0076.outbound.protection.outlook.com ([104.47.32.76]:51362
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732310AbeGLPAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 11:00:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQnKtQJ76b6MbfWxJrlosBFlh34M96pOCNm7swTrBxk=;
 b=WE9iC5iJ5AWKTuAhX1PnXXwYq3m9SpKHOmswyCvTDMGKzqNy94usOV8Isrnvwbgmahd7byZZRJtW5hb+H/6iTiJIXkHbqkeVa6ti6Rl2kfhTNiH/e1x9mroSElxXboFUNunOKbJg6kmeq4Aqlo4CiHtS4tQ013aLZqxBVE80ijM=
Received: from BLUPR0201CA0016.namprd02.prod.outlook.com
 (2a01:111:e400:52e7::26) by SN1PR02MB1632.namprd02.prod.outlook.com
 (2a01:111:e400:519f::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.18; Thu, 12 Jul
 2018 14:50:14 +0000
Received: from SN1NAM02FT026.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::202) by BLUPR0201CA0016.outlook.office365.com
 (2a01:111:e400:52e7::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.952.17 via Frontend
 Transport; Thu, 12 Jul 2018 14:50:14 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT026.mail.protection.outlook.com (10.152.72.97) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.952.17
 via Frontend Transport; Thu, 12 Jul 2018 14:50:13 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:33136 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1fdcv7-0004kg-5S; Thu, 12 Jul 2018 07:50:13 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1fdcv2-0004mf-2I; Thu, 12 Jul 2018 07:50:08 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w6CEo40Z012205;
        Thu, 12 Jul 2018 07:50:04 -0700
Received: from [172.23.37.224] (helo=xhdbharatku40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1fdcuy-0004e2-24; Thu, 12 Jul 2018 07:50:04 -0700
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <bhelgaas@google.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH] PCI/AER: Enable SERR# forwarding in non ACPI flow
Date:   Thu, 12 Jul 2018 20:15:19 +0530
Message-ID: <1531406719-18606-1-git-send-email-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(136003)(376002)(396003)(2980300002)(438002)(189003)(199004)(7696005)(486006)(51416003)(1857600001)(186003)(2616005)(476003)(126002)(50226002)(9786002)(106002)(36386004)(63266004)(426003)(16586007)(106466001)(54906003)(336012)(316002)(356003)(110136005)(47776003)(5660300001)(2906002)(48376002)(50466002)(305945005)(8936002)(8676002)(81156014)(81166006)(478600001)(4326008)(6666003)(26005)(77096007)(107886003)(36756003)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR02MB1632;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT026;1:NLlW5b+exewtuOUHnUt1yyny+mTHIVKyW3jEMzf5lNQdlGeVxzXJltCnTVDLCzzQhAN9FcoxPQgHPFjJ/2NynFQn5mwZYJ/jZpn3FoMr74rfiO8gEI4y0Sj2DQIWwfDL
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61708830-d94f-4d1e-5f3d-08d5e806c675
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:SN1PR02MB1632;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB1632;3:Qy/3oL/ekGonlaXRmHXcJQ+X1JRrK8TeeUw9DKFkmBUjSJ2gTaDfR+Ht99VSlB42xwbY/JBS/2W/bezFUHA1b/Cm6x5/PomaV164yMP2PkeXmedzWw0RfIia26wNHijdYSZGBNAJ+j+QF0yL4D8sIzQsdyclKSbYVpBUFuEASu0sKAHkDXDRwDQPXPbcuAdVjFeYfICNFgewW+LnizcHDBNFlw9Ly/EpOJrr+6nRPbvb0ibkncnYe0pvS5Y3IL1H5oBsWWMLnYyz+GnVbmisej+GyUUr0oGlInFH7fou9YSH9eM0bvKNkB8eZzkzyIT3lA739vMiI0iHZUK66tDsxuSrQSRCOsDHHUGTr8z7S3A=;25:e6eKZul/oSygIgQS/2n/mhW5wAxzTLCdT/2Y5eJUjpmOSt7eIZy15iry8zX32jVRpf2UNih5/5U8PDFlVU7YyqEgCV4Oj2fQ1+LwMKC7JYw4R4c4WIs99YypDYp/SGzy36ZaFhLhgCd6nsmcelZ6bZGDK0J7a8uWC+C//W7laN5KNhPvi+o4DZjejeIxmPwMoxBn2KFpY642k2hVBtA2egG2gr9IGYDWE53fpWWVQyWlG9mmbJFVg8MXvwPyCR76kXUdg4csdnBmfKcz+7nw/UQHBvcxUc91Cq3TEYZkPAyfdjk/7vW1ROzWYAb2zFe5r69GoSIb0l3R1Y1TPipweA==
X-MS-TrafficTypeDiagnostic: SN1PR02MB1632:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB1632;31:ZL6Ra/aV83xufej42MkIf38mV8gu9EpCtiAl+eRC6CVqwcGiII/o+Zo0Z2OWD6u/AIri4uFyg3bjh+s7DcoGTe0hF8ZumCh/nr72NsV6IseRFOgtD4Jl1tQTK5JEIXIm5cKAVKH+Jt3rzsOyqrq2YreyGVsymoq3uOMOv+E+rmP64HpC6ktxRa9JPmUkcQ+ny9FKTGaUpfCK0WbfmlM+jBytFKxsZKITFN1D3e3b20U=;20:S2t5SLvuzVAOEXhSFvyPwIedNru1HQbmHB2wpY6iIxvwzP5WdeJEUoNqP+MH1wJv0OnfLYduKkw5anMNrb6OtwabcF+z3qBCV/bZ35IxVNyy4+sEfskljHdRIbGZSRMnH6wyY9O7QNzy9g9cg+qBBTzlzWLI87Pxy2dP1dyQHD6uyKk7KR+sCxFMQjgr90wppbOzMmxqiU9b11qKPIuisZlOolTSoe4VsdyRjABxghk5jv9idfi2cxHkg3UCX/8XM/84G3vyolj9uZRk0FVsNSveuYb89cjkmDellrLDbn3gSggn8X4swalayKrGRW9JnE8b9oMhvMaAePQ/JWIZgZorWy3PzfjOwZRkLeT7tQ9+It+25d+c+vkq5Wu/lXO7e1XHA0uQHT0cNYgtkVq8zrM4p+wNGLT+PIlqpilbTBCuFshJSKveP9KhHOy1mjcQtkVXmQEJnmaMsWDbXN3m/I6pNQI0rzLOB1CcXttz40F+/2X3o/ivAWqkWWC3u6Mi
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN1PR02MB1632C73501E457EBEB488EFEA5590@SN1PR02MB1632.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93004095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:SN1PR02MB1632;BCL:0;PCL:0;RULEID:;SRVR:SN1PR02MB1632;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB1632;4:RhpCiS4N9nPfcDH05g1YPomLwySkT/DbufiarOaPPfoTmrDaMRYbfQYJHh64qwe3IMuWABLft6gpCWpdb3LTRvYSKTotdJfBfUHU+36XzwLA0rsZ+EZ74019clq1zic2CsxMkde7JeUHA9FTps52/bKF/qfuc/c2kmLRflhODLnGhHcS3YEnVM+3ldabzUu4RGARQxL4JPRNmPh38y33Bv8gGomImGnhEgmvuopoERDs9l+oG8UYWsTLs8hlZAGPbnUucGgOAjkAw5tlunirg/Zvmd3LyBTfAEUy4pEHsKSh+T0zxR4wFPEWNwL/gFg5
X-Forefront-PRVS: 0731AA2DE6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR02MB1632;23:eUB5PnwdFN+x98+jWXm7QP1SJekt22JEpbA19cNd7?=
 =?us-ascii?Q?a28Yo8XDuYnRwENzWUYvsZvuWSIYcsHvWFiWyr4bkH+TjQX73oVASKw+ygYZ?=
 =?us-ascii?Q?I81ivbAFL7NNeezLjqEi2WJPdNDnl3Almg2xhvSS2DDxbjiENvHPashFX4Ov?=
 =?us-ascii?Q?Zz8mCvgDuQ9t7voGlZ6xJFSahAZXOkz0DC3umuQKJ7r7L2jgvZ2wX7JfYkfH?=
 =?us-ascii?Q?b5Ebh7Ju3aye95bFex7abB6yisfVUcLVqZp6GCzTTBCu53xUFQWIIaLbrBCX?=
 =?us-ascii?Q?Qdh7rKhlU2ufjgd5dS/kDQfxiZitnZd7JAFmwh3C3UC0+pREqzIuSKw7Izl8?=
 =?us-ascii?Q?E0TBltlCHJ93LPWZlo6F+k4MwMgueAKzqdKsA8auDX8TpNUAeYM0eHtu1vnf?=
 =?us-ascii?Q?y9fg9KKOSw8DPr9QdrFQOrIZTlQy/4E0HVB+4GQrMvZeZDIhreadMcvzwgU2?=
 =?us-ascii?Q?f9GAdFvzlL+08Q/dJDWTZmihSoffG/GzwVmSRL8kV1ksZJEwffBqPOsylT2R?=
 =?us-ascii?Q?Lz2DUVBirKSMwExwub+rnBK9z9WIKbjC9+zbWtKiHO/7MMZ/Vv8dUl2ibeuC?=
 =?us-ascii?Q?UQglbcfwLwNHgYxxHSx+kQKKSX+LGbD1DJWCJWNBFzUCZKaWO9tULiKWpNBi?=
 =?us-ascii?Q?NZ1+4stzXaC9Mb7ieidcoOLsNHxOUQvXJPRCa2rAVJogh61GlcF3qycqwNW3?=
 =?us-ascii?Q?5dfQAuwaMdtGbld6MxslwYVN7dKWXqb6Bbh7TK/ex1yoaCma3S8f8hXZjGQO?=
 =?us-ascii?Q?+1vFKjcjEImKu9XLlP+GdaqkUAlXi2rsafNZmLaK3aH7SNCZ+IP43w2yYDd9?=
 =?us-ascii?Q?oqMAwJ1Z90NJNHBnAaStBP8s+LBfge3TuUlJjgZSV6CZPPUtXSUCPrMgbkjM?=
 =?us-ascii?Q?CMO+4eiLwTD0a0Hj4UwJIt/8lm79Qwx8pJ3U63zQ4KRIK6UX7nI3TOzLl1C5?=
 =?us-ascii?Q?zA1s0n3P4+iB8ozK2U9Fb4rzkCOaSAQtw1/0lEd8s/tUeXB26Na7JuT3Pyty?=
 =?us-ascii?Q?zwa1JWXw4SE2qxR7Ik8f/d+Es1js1+LjlbqWJutdD4NFgTmnGvtish/8628Y?=
 =?us-ascii?Q?pSGoFEFW5fc/eqDhyv4cPsnAcfFUrkNCKgH5aU6TMOFa1SNNQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: FjAKOJW0cvq3rbKV6W78WFRGXjkpHuYDl+zjygR8a3AyDkDr4/4Gs4tY0Jfya4ktwVKOBpEcDADkUmSrIsUidhNKtizWanCIbWE2WTrdwldUfuh5Y/52DSAlENsHeTUACigcdMnPgIHAqURN72N+AFL+LA31/lFQxcZc5rs4+ZClfsa6NkYaHxnBm1UH5gqYuPct5o0BMzYTHqMO6cYTuRXVflZGuo0n5yMBbHDVeK92y+eZrBFQ3giXeDnrKwDls8SxrffeCRUgHlR6+I+Wcn4GjKbExamV08SoSkzqNdU4jucVAWqPNkGJk3x+U4sp/kzcV+HR0NtkRSvWfqdklZIB8AVcg1vTCb44S3mKKTo=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB1632;6:9QWwDWPXvH1+kz3TK9xfxUQJkirGJME8blcTFoBMx0JAK+lNTTwOm52Ec62jwUDVf5pEyas8dhP2YY7jI/RH8OrWHbirE7aT4HHaLCaxAwOFn3g9gULvZJP9g/i7n7WkgoAfVA9LLQzD1MnwDRw0fLrfMzbqAFXX782x7Jh5lfX58yhhxO2tOVykHhGPKnzeaUOUlqUOFGJMkhwYNswFK3EjIGQhx9YXMDhzsiMNOdXTO1omWHdYjlpC3iXRdXV4mNt0q07r+fceYbbO5NxuJhpjoaixoriwwyN7xYSN69EBk+kQIQzmFZoRx8mtGT6KYaIqBZ7A9vCsTYNzH179RDZINckcrEJPabGBkttq6//USyhkTO+l2NTboKv3ajGEeoERnxamKhD8M1GtBgOjVum4eX0Vu7D75WJ9OgPdseA44FwjWIgAwKLDs/HU4yRUMmvEuoHfNlHfStEsC3TUqg==;5:x2ZkJI3qF5z6DkMrQkntIQYbLAhQJSmid2Ec48kAcRJplLu1BwdcYl8ZdMGfxPSXSuUhzg8qmrLx/Fc5IICzLggM+QSuL8vKE2dfkYQBpPfmcjphpukHOiRt9v5ctA6+H0Iuswr+LgFe21W1eIRl/fqbjwmiYDUZDzl3d0Y2d7Y=;24:ZjwpNVohPbM26DC9YlgmGv3Ol/C/10ozGFrRuHOCFtKl7AUpTLQvsIRgCs041PKOHTqSFgffJGCyrV8nGNc09M4b9jP9okmCg1UgZ2ysusk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB1632;7:MhaSRUtFA4NPoui6+Av3QRopspT474mPtr0cnhMHxE+fwIrxRWtfN+ow/KhGBvdoUu4J+A9X1btQsjanfr6ojL/JYVBjLogwLZGTslwyYXR3zRgfoYWJz2kHAdQ9Xk4CKG0BaWYjom/PgA2swIBOxHfeFanaOJE9T2nfRZre9hmqVUg0eQ+li0x21kueLZ1rctPMauqyT8yu5HRwOV7rI89f1a2P3cm4UQSRoe9TcxEGavmtGp7CAUw431M76UeK
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 14:50:13.8259
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61708830-d94f-4d1e-5f3d-08d5e806c675
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB1632
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently PCI_BRIDGE_CTL_SERR is being enabled only in
ACPI flow.
This bit is required for forwarding errors reported
by EP devices to upstream device.
This patch enables SERR# for Type-1 PCI device.

Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
---
 drivers/pci/pcie/aer.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index a2e8838..943e084 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -343,6 +343,19 @@ int pci_enable_pcie_error_reporting(struct pci_dev *dev)
 	if (!dev->aer_cap)
 		return -EIO;
 
+	if (!IS_ENABLED(CONFIG_ACPI) &&
+	    dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
+		u16 control;
+
+		/*
+		 * A Type-1 PCI bridge will not forward ERR_ messages coming
+		 * from an endpoint if SERR# forwarding is not enabled.
+		 */
+		pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &control);
+		control |= PCI_BRIDGE_CTL_SERR;
+		pci_write_config_word(dev, PCI_BRIDGE_CONTROL, control);
+	}
+
 	return pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_AER_FLAGS);
 }
 EXPORT_SYMBOL_GPL(pci_enable_pcie_error_reporting);
@@ -352,6 +365,16 @@ int pci_disable_pcie_error_reporting(struct pci_dev *dev)
 	if (pcie_aer_get_firmware_first(dev))
 		return -EIO;
 
+	if (!IS_ENABLED(CONFIG_ACPI) &&
+	    dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
+		u16 control;
+
+		/* Clear SERR Forwarding */
+		pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &control);
+		control &= ~PCI_BRIDGE_CTL_SERR;
+		pci_write_config_word(dev, PCI_BRIDGE_CONTROL, control);
+	}
+
 	return pcie_capability_clear_word(dev, PCI_EXP_DEVCTL,
 					  PCI_EXP_AER_FLAGS);
 }
-- 
1.7.1

