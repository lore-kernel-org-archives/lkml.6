Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209F4C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 06:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B83DF2077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 06:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="41N/TG+W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B83DF2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbeIELKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 07:10:48 -0400
Received: from mail-by2nam03on0056.outbound.protection.outlook.com ([104.47.42.56]:31059
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726215AbeIELKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 07:10:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycf/AG8aWzKGhUh3rHp71cSVd8aILkGQPft4sxJCOLE=;
 b=41N/TG+WbmN1DHxY+rN1cBkIeuxUuGYWij6aQEL/UVbjWmMGsvoNm9HoHQPkzSUI/U7GD2HHpe9Fi7pwkJeoghaPw5I/LY38Rp3uuSDx+gtV/ZKTITVCihoEbg9nDEU9Av95xMTTx+fXGJmzVxjG38n89JSLUxTp9S5sXYKtpKM=
Received: from MWHPR02CA0035.namprd02.prod.outlook.com (2603:10b6:301:60::24)
 by DM6PR02MB4939.namprd02.prod.outlook.com (2603:10b6:5:11::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.17; Wed, 5 Sep
 2018 06:41:01 +0000
Received: from SN1NAM02FT025.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::208) by MWHPR02CA0035.outlook.office365.com
 (2603:10b6:301:60::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1101.14 via Frontend
 Transport; Wed, 5 Sep 2018 06:41:00 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT025.mail.protection.outlook.com (10.152.72.87) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1101.10
 via Frontend Transport; Wed, 5 Sep 2018 06:41:00 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:37426 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1fxRUp-0001Xg-P4; Tue, 04 Sep 2018 23:40:59 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1fxRUk-0000kn-LT; Tue, 04 Sep 2018 23:40:54 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w856eqqP009916;
        Tue, 4 Sep 2018 23:40:52 -0700
Received: from [172.23.37.94] (helo=xhdappanad40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1fxRUi-0000hO-8M; Tue, 04 Sep 2018 23:40:52 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <p.zabel@pengutronix.de>,
        <nava.manne@xilinx.com>, <rajanv@xilinx.com>, <jollys@xilinx.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v2 1/3] firmware: xilinx: Add reset API's
Date:   Wed, 5 Sep 2018 12:10:40 +0530
Message-ID: <1536129642-7049-2-git-send-email-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536129642-7049-1-git-send-email-nava.manne@xilinx.com>
References: <1536129642-7049-1-git-send-email-nava.manne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(136003)(376002)(2980300002)(438002)(189003)(199004)(486006)(106002)(476003)(110136005)(2616005)(48376002)(50466002)(50226002)(47776003)(426003)(336012)(217873002)(186003)(126002)(2201001)(77096007)(14444005)(8676002)(26005)(316002)(76176011)(7696005)(36756003)(36386004)(11346002)(81156014)(81166006)(6666003)(305945005)(16586007)(356003)(51416003)(8936002)(446003)(478600001)(63266004)(2906002)(9786002)(106466001)(5660300001)(107986001)(921003)(1121003)(83996005)(2101003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4939;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT025;1:Cdf73CM767m665V8y8hcnzOQnYiMgkZrhIbmcqdSrfdNaTxJJgmWAgdC8mq0vyQ/U5rYwNvdKEhEY2hC/zmJhhablTZc13XyZvBY0pbyLEsc65uq7qkq2aHmOQTS24FL
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 023b6963-a3e7-4bf7-1e2d-08d612fa8b1d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:DM6PR02MB4939;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4939;3:KGt1qNxYrehrkPxp9dDOHo+ZIx2y1qYdk4fKis8ucybl/hkqkQmlRU4EGLdSyPkx4fwlCyl8U/vda0QVoUWPmxbVlN8j5Y17yYVTP/BK9GS9wE+LlyptF+/fQaudgFYFkR3kncuE5XR1XBw176VIaLpbOpFs8abXJ759fmmM+bvEIaOuPHvKZThvwisj+TF6Bu1R6WFxlr2et+GscczV7ULUyvJUdgKvyasvI0TEbZgTYzo+psMMCBc37tIKePgnl09so+fBg/fCqnLU0WLWEqIxxp5PNZ/qr+coPnUJmWfDzrgSOjz5iwzby4RQ/al/kkUApGBd90FSgfrV/7Wn1Yn3a1XdiyEPzPBkfJJvofQ=;25:iBYifCXd0PyDoYql+tplV2F80HdHMPTjKq2uYaODn2/4OfSv6q423fFIdiHnWZXs+9LMc/995lgiqms45VMGjJZn9PfqSq0hxExf2l/PU64jSwLq71QYhGp9e8hAGa+voPlaX5nnp5/CNRbcCDWv5XWUUaM94iN66z71AjzPg9dZ5qvZziBhMkK8fuh7igXgFjs3e/A9fLdtn8cLV2TatSAiwy1e6xXPJukWdx4YAkr/GcbVKa7cb3OQh35jq5Fa04x4SmCRgkfaRRisRF0PMNEr/DGOmnnloiC88wG8Qsgq3QS8D9ajirzXNe1qCyx+7Cjt9dN5KbQS0RN5fzt2Nw==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4939:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4939;31:z2kcKUaV0rVPXoT5hDQOsGCbWcabXhH/kkMoXCfu7d6RxEUTBO6ygLsSEjV+yzKcqWWJbp5UGyYltIyNHi2tLoOqdMJgeIqabQjUahtO46MZTdg5Bfc5qBbpjrwT61ccO4z4qmO//qDUGXrZqmLHdPZQdtA55DdtxYWOlqhKhTlwJfTP5xurnHvR0vFCiZvjT1neCsP9/KDpQ4kv8JolytHOkC4EkVTFPBgxn7nizS8=;20:x5GHErDU4taEb1/1L9B4VFadzMoAkxYIZLXYnNPAk6uehAxjweAEspI985Sv3CAIeN89wy5Rfyn0xqJueZXrMmszCAilYRfLHryNE0nC+fnDPN9iqcfw4JkF34u84Zr0xh/Ev+T4/kLYV5JmgGKterPV7losbrBXeU/vcXPw7oZMONCOpJ5iEju9crTEKA3eC6qW2bZH4eZ81gfDudCwspmlyiXqEPE4e12rp37RsGY6kGgI+YXeBoM63dbTSjFEwFQenbzKZFKqGK/HiZDfTHsEtuZjLfz6/2Vg44YUJJ/ZVsdQIn9LtnMyKopQEufbP6b8l4LOKbbzL6oY0qK26TfRikwVrVYl8UNHN7tFxRPj5KaQLzvW66xGeoQ3HwIm2vHULeRFcVkZll1Ynme8wvhE2hqmByFrHuKSKj7RPST9JeS0kW+M6EWcMY2kWcPKyFRSrcB817FluVZlu+HveBww7O5eHW0gtXsuVMbi8rjtTW1NZKSASPnpHE0FAHYY
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB4939AA323655762F58C025C0C2020@DM6PR02MB4939.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(10201501046)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(201708071742011)(7699016);SRVR:DM6PR02MB4939;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4939;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4939;4:XMGon8fw0ZRvo0P5/MFXYq3OsM/TOnz3W0MNXAowqPdFptX8R+bAqG924+5mWNCVsJ4U6m0C2JjZ/PsNV7gXnO0zINvf05HevFoBnPaiswHIIvfJVecShxEoFeFbZGcYLsalUvRqC93hxocF2KPs/MArGaO8Rbb4jPLTN95vVCsF0fctIrgxPJ7OIp6pAoLejstH0/k7/U8vP1eOM7H0BCoXAPICwFf4mJQDO70GxMJCiN7O5ddzTYG7l1r+hwchAoXbAvPk0Bu4P/fMat8MmyM0MLTXfJQpAZGiZ8vZDKOURPpOPhzGJOHzRfVY+xoi
X-Forefront-PRVS: 078693968A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4939;23:AWzcf93S2rxPkh/05pS/MkGQOedMh8X8S4Nwc8j8O?=
 =?us-ascii?Q?AipbdM3PuMZXWQeQDYg5RjHAJ+PTJKOfmAa89IXB20VWyv2m94JGzrsbNJY5?=
 =?us-ascii?Q?OuEw9KhxYsxORvtD8O/sWxbZ1sYgaQ5ZUyMsEOvI5Bxq5Qj3Rzsax+P/P+FP?=
 =?us-ascii?Q?UqcPVlnR5jNLkdxHIF0LwcXPEdK8d6vKNXS5QN3i/LqRWr8xg0k6JrIHTbxy?=
 =?us-ascii?Q?sO7wgPxnWcMUb9Hfar2GCBXt3TsjfrEY1lPOkeewohJYK6f8MjHhGED0Fljz?=
 =?us-ascii?Q?g+Ec0YJBb59G1AUa+IBNQRAL4nIq7TgbEODO6IXcoixXoqDVFwq+MwXH3+1d?=
 =?us-ascii?Q?H6NXPVTAIATpeXZOq9soQPeJSj4od3AFex1CQYRaIoNOkGEodwPgLKudLxMy?=
 =?us-ascii?Q?HknGoYm1JjBkO94wsx32o+6+OaQbJwIPdnz/dQR57CRwDVqs7pahOzP/3qfI?=
 =?us-ascii?Q?w09vqhg5KnrR0xnYJ0/FK3dQHdbwvtq8DwcrcMRQ/65iCVc8XsokaUJzH2Qy?=
 =?us-ascii?Q?SgG/HgiUPv92V0uW60Zkshg1PgsNKeEPNth9SGTyxviis5Cn7cM7JYlTHGHl?=
 =?us-ascii?Q?aBoBIQXoeJbxMLAQ5u0n6E+GWTqJiqrkhoRkH9pmn/odnWK24pllAMEBZUQD?=
 =?us-ascii?Q?km8QptwG5UQzWkMXtn6/WLLv2QmLXpG3S2u1JFG1uj4o1/kVoijcAufDMBbg?=
 =?us-ascii?Q?rTSH2ZDlp31h/S+KQSSNrFUZ2pxRcutYNznZEsD3UGKG+dBrMv97GSt6xvdi?=
 =?us-ascii?Q?CTKbYVS8kCzgVYFrb8WuCpfb7CZhgKvIAzkM/oa6ODHJtRG9N/LXoC9Mg8yu?=
 =?us-ascii?Q?x4n7RyM1Ub/r2GL3r2XvJatL6G1g86vsZ03NVq9b2EJ2ppYYw1EymxuuH5Sa?=
 =?us-ascii?Q?ZZSLhM4UtMH3NJb9oB4711S9h5nv9Y/bvXgCyP327hyNhHrZdj4j4pprJroQ?=
 =?us-ascii?Q?lP8A/b7FOVwz82VjTIoimaR9UblGZLHvCa8IjGzfB8bBb9lLXaWosWd/XIZl?=
 =?us-ascii?Q?Om7+JnaO0fqRnMWKyn3HkagO9ZAkOFG7zMrkDcSpEVq/Zcmf8QSNXq1zQul9?=
 =?us-ascii?Q?6mGMQY6yUkNAVjGok2BNCzfSkL3rh4Mmklhlf2l6h5MSB4udgNQsjaNz41mq?=
 =?us-ascii?Q?zmFAaCU0CMetIPLU3JKoQP8JDUd9NouuycSrDHyU6WCJgAT+AvRWfHm/N8fR?=
 =?us-ascii?Q?ZCqg0SsYj3T9ANgX+MZvmTLDJI9OdfJUG9g?=
X-Microsoft-Antispam-Message-Info: jpaWP9xd06XDh60W+1LBfSU8BxO/AuSClyzJAiPtFRrUIhoT/xCWNI7TlS+R9ZE41iVx0P0EPwp7bTaZZtrTw9NJYfVUIKMvhoS+m/PSMB5Gu4k6nmrM8gJu5ALx8MGq2X+kwulUoaHeIDylnQ961PPm5I7dUYqhWTp5dO5BK6ZUoZXme5ZYDBfWXt47mIaEUU7chDBJZpxhZADBDlO+sb44qXokOQKOaWcDbc4KbCUdDXjbtddGtxh/b4rGf3IuDLy8EynfKVtiK1r/1n8P3pVQwbkDs80Rluff7AiKgO3PLqEzGaoEUdMltTipMmP9Q4Da1bVeVkljVxC10hY5SBvaNGt/OyYSrQMi2K2hkZA=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4939;6:Px7k9Y1j72dri0R8QmwJNy9DVFmPjnxnWEqAMVDxfGHWLl3xcXMCSp3WqNGyrc1nA/FwehjtpxDbNossYJ72idstRkdTfTDKkh1JMZKEUP6qP/4GUPPJ1pEnwqVJZtTE7yRV7og0JWXIzEskoVzymFI5s6iBJxNXKqPJiPnaOxsXLx+PwcX+d9FH8XDOvUtGktav1T46HMPyHlS+NxghV2hw+Z3PdmyMkd7dGor/d5e30XJucA6fQrLd/dS1/f0aQJpcUwzicVGCVcgGTUo0xt7DlVfgQTZ4jXLl7+5XFhcZifABVY4VaqJ8iOMRlFejoD7vyHsvQHfcet2WpvHappfoiyepYjuH+yEc+wZLCPQdyAv2HycWz7Di1IRPHh+5rX/u1oLBLFAIqGwDzQrOsr3pcHkcZ6kHaUGU95YHEgpGiGlOPUSxjmU9ANd9hmzffneTe9W5nPaSdnLiqo/cAA==;5:9vPakSdrj79mRBkIbbnmgEjV4nbjyNBadMe4C4hx4IbLkqtKbIarJuu84Sx3fXrY5/SF1cP1OaTUfSNRv2igjeEQC2LDRQ1OI/FX93uwcjG/Lgkvpx1k9LnMJ2OyZ9Vs1IhXMIrshpmKw6bTobvf3BEZrWR0CH5jzaXQeQgIvDo=;7:mjch17xIDQzB6PI2QcCJz40cB0sXWtSvpCD8KKZGg9/cxGYoxee9QQTDOQ0/VDaf4GQq98suP0qucZNPIdmarH2k8BloN+VmIVFJ+vDjaVPTY/hJTv/2e3z4vo3VwJ8S/9Ey/t9g0uyzZJSRrBd/SeyZqnXasAq7kdAQBxV1bAhqZfbRdDvnFb5uOVGe777vLBeUElmcu63Yl+azdEZ0Vx9UcbrI144FprBHn+Jp6/DwPcEjrAe/uE5eZcF07Xhb
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2018 06:41:00.1444
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 023b6963-a3e7-4bf7-1e2d-08d612fa8b1d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4939
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This Patch Adds reset API's to support release, assert
and status functionalities by using firmware interface.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v2:
		-New Patch.

 drivers/firmware/xilinx/zynqmp.c     |  40 +++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 136 +++++++++++++++++++++++++++++++++++
 2 files changed, 176 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 7ccedf0..639c72f 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -447,6 +447,44 @@ static int zynqmp_pm_clock_getparent(u32 clock_id, u32 *parent_id)
 	return ret;
 }
 
+/**
+ * zynqmp_pm_reset_assert - Request setting of reset (1 - assert, 0 - release)
+ * @reset:		Reset to be configured
+ * @assert_flag:	Flag stating should reset be asserted (1) or
+ *			released (0)
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_reset_assert(const enum zynqmp_pm_reset reset,
+				  const enum zynqmp_pm_reset_action assert_flag)
+{
+	return zynqmp_pm_invoke_fn(PM_RESET_ASSERT, reset, assert_flag,
+				   0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_reset_get_status - Get status of the reset
+ * @reset:      Reset whose status should be returned
+ * @status:     Returned status
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_reset_get_status(const enum zynqmp_pm_reset reset,
+				      u32 *status)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	if (!status)
+		return -EINVAL;
+
+	ret = zynqmp_pm_invoke_fn(PM_RESET_GET_STATUS, reset, 0,
+				  0, 0, ret_payload);
+	*status = ret_payload[1];
+
+	return ret;
+}
+
 static const struct zynqmp_eemi_ops eemi_ops = {
 	.get_api_version = zynqmp_pm_get_api_version,
 	.ioctl = zynqmp_pm_ioctl,
@@ -460,6 +498,8 @@ static const struct zynqmp_eemi_ops eemi_ops = {
 	.clock_getrate = zynqmp_pm_clock_getrate,
 	.clock_setparent = zynqmp_pm_clock_setparent,
 	.clock_getparent = zynqmp_pm_clock_getparent,
+	.reset_assert = zynqmp_pm_reset_assert,
+	.reset_get_status = zynqmp_pm_reset_get_status,
 };
 
 /**
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 58a7478..93decf5 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -34,6 +34,8 @@
 
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
+	PM_RESET_ASSERT = 17,
+	PM_RESET_GET_STATUS,
 	PM_IOCTL = 34,
 	PM_QUERY_DATA,
 	PM_CLOCK_ENABLE,
@@ -74,6 +76,137 @@ enum pm_query_id {
 	PM_QID_CLOCK_GET_ATTRIBUTES,
 };
 
+enum zynqmp_pm_reset_action {
+	PM_RESET_ACTION_RELEASE,
+	PM_RESET_ACTION_ASSERT,
+	PM_RESET_ACTION_PULSE,
+};
+
+enum zynqmp_pm_reset {
+	ZYNQMP_PM_RESET_START = 999,
+	ZYNQMP_PM_RESET_PCIE_CFG,
+	ZYNQMP_PM_RESET_PCIE_BRIDGE,
+	ZYNQMP_PM_RESET_PCIE_CTRL,
+	ZYNQMP_PM_RESET_DP,
+	ZYNQMP_PM_RESET_SWDT_CRF,
+	ZYNQMP_PM_RESET_AFI_FM5,
+	ZYNQMP_PM_RESET_AFI_FM4,
+	ZYNQMP_PM_RESET_AFI_FM3,
+	ZYNQMP_PM_RESET_AFI_FM2,
+	ZYNQMP_PM_RESET_AFI_FM1,
+	ZYNQMP_PM_RESET_AFI_FM0,
+	ZYNQMP_PM_RESET_GDMA,
+	ZYNQMP_PM_RESET_GPU_PP1,
+	ZYNQMP_PM_RESET_GPU_PP0,
+	ZYNQMP_PM_RESET_GPU,
+	ZYNQMP_PM_RESET_GT,
+	ZYNQMP_PM_RESET_SATA,
+	ZYNQMP_PM_RESET_ACPU3_PWRON,
+	ZYNQMP_PM_RESET_ACPU2_PWRON,
+	ZYNQMP_PM_RESET_ACPU1_PWRON,
+	ZYNQMP_PM_RESET_ACPU0_PWRON,
+	ZYNQMP_PM_RESET_APU_L2,
+	ZYNQMP_PM_RESET_ACPU3,
+	ZYNQMP_PM_RESET_ACPU2,
+	ZYNQMP_PM_RESET_ACPU1,
+	ZYNQMP_PM_RESET_ACPU0,
+	ZYNQMP_PM_RESET_DDR,
+	ZYNQMP_PM_RESET_APM_FPD,
+	ZYNQMP_PM_RESET_SOFT,
+	ZYNQMP_PM_RESET_GEM0,
+	ZYNQMP_PM_RESET_GEM1,
+	ZYNQMP_PM_RESET_GEM2,
+	ZYNQMP_PM_RESET_GEM3,
+	ZYNQMP_PM_RESET_QSPI,
+	ZYNQMP_PM_RESET_UART0,
+	ZYNQMP_PM_RESET_UART1,
+	ZYNQMP_PM_RESET_SPI0,
+	ZYNQMP_PM_RESET_SPI1,
+	ZYNQMP_PM_RESET_SDIO0,
+	ZYNQMP_PM_RESET_SDIO1,
+	ZYNQMP_PM_RESET_CAN0,
+	ZYNQMP_PM_RESET_CAN1,
+	ZYNQMP_PM_RESET_I2C0,
+	ZYNQMP_PM_RESET_I2C1,
+	ZYNQMP_PM_RESET_TTC0,
+	ZYNQMP_PM_RESET_TTC1,
+	ZYNQMP_PM_RESET_TTC2,
+	ZYNQMP_PM_RESET_TTC3,
+	ZYNQMP_PM_RESET_SWDT_CRL,
+	ZYNQMP_PM_RESET_NAND,
+	ZYNQMP_PM_RESET_ADMA,
+	ZYNQMP_PM_RESET_GPIO,
+	ZYNQMP_PM_RESET_IOU_CC,
+	ZYNQMP_PM_RESET_TIMESTAMP,
+	ZYNQMP_PM_RESET_RPU_R50,
+	ZYNQMP_PM_RESET_RPU_R51,
+	ZYNQMP_PM_RESET_RPU_AMBA,
+	ZYNQMP_PM_RESET_OCM,
+	ZYNQMP_PM_RESET_RPU_PGE,
+	ZYNQMP_PM_RESET_USB0_CORERESET,
+	ZYNQMP_PM_RESET_USB1_CORERESET,
+	ZYNQMP_PM_RESET_USB0_HIBERRESET,
+	ZYNQMP_PM_RESET_USB1_HIBERRESET,
+	ZYNQMP_PM_RESET_USB0_APB,
+	ZYNQMP_PM_RESET_USB1_APB,
+	ZYNQMP_PM_RESET_IPI,
+	ZYNQMP_PM_RESET_APM_LPD,
+	ZYNQMP_PM_RESET_RTC,
+	ZYNQMP_PM_RESET_SYSMON,
+	ZYNQMP_PM_RESET_AFI_FM6,
+	ZYNQMP_PM_RESET_LPD_SWDT,
+	ZYNQMP_PM_RESET_FPD,
+	ZYNQMP_PM_RESET_RPU_DBG1,
+	ZYNQMP_PM_RESET_RPU_DBG0,
+	ZYNQMP_PM_RESET_DBG_LPD,
+	ZYNQMP_PM_RESET_DBG_FPD,
+	ZYNQMP_PM_RESET_APLL,
+	ZYNQMP_PM_RESET_DPLL,
+	ZYNQMP_PM_RESET_VPLL,
+	ZYNQMP_PM_RESET_IOPLL,
+	ZYNQMP_PM_RESET_RPLL,
+	ZYNQMP_PM_RESET_GPO3_PL_0,
+	ZYNQMP_PM_RESET_GPO3_PL_1,
+	ZYNQMP_PM_RESET_GPO3_PL_2,
+	ZYNQMP_PM_RESET_GPO3_PL_3,
+	ZYNQMP_PM_RESET_GPO3_PL_4,
+	ZYNQMP_PM_RESET_GPO3_PL_5,
+	ZYNQMP_PM_RESET_GPO3_PL_6,
+	ZYNQMP_PM_RESET_GPO3_PL_7,
+	ZYNQMP_PM_RESET_GPO3_PL_8,
+	ZYNQMP_PM_RESET_GPO3_PL_9,
+	ZYNQMP_PM_RESET_GPO3_PL_10,
+	ZYNQMP_PM_RESET_GPO3_PL_11,
+	ZYNQMP_PM_RESET_GPO3_PL_12,
+	ZYNQMP_PM_RESET_GPO3_PL_13,
+	ZYNQMP_PM_RESET_GPO3_PL_14,
+	ZYNQMP_PM_RESET_GPO3_PL_15,
+	ZYNQMP_PM_RESET_GPO3_PL_16,
+	ZYNQMP_PM_RESET_GPO3_PL_17,
+	ZYNQMP_PM_RESET_GPO3_PL_18,
+	ZYNQMP_PM_RESET_GPO3_PL_19,
+	ZNQMP_PM_RESET_GPO3_PL_20,
+	ZYNQMP_PM_RESET_GPO3_PL_21,
+	ZYNQMP_PM_RESET_GPO3_PL_22,
+	ZYNQMP_PM_RESET_GPO3_PL_23,
+	ZYNQMP_PM_RESET_GPO3_PL_24,
+	ZYNQMP_PM_RESET_GPO3_PL_25,
+	ZYNQMP_PM_RESET_GPO3_PL_26,
+	ZYNQMP_PM_RESET_GPO3_PL_27,
+	ZYNQMP_PM_RESET_GPO3_PL_28,
+	ZYNQMP_PM_RESET_GPO3_PL_29,
+	ZYNQMP_PM_RESET_GPO3_PL_30,
+	ZYNQMP_PM_RESET_GPO3_PL_31,
+	ZYNQMP_PM_RESET_RPU_LS,
+	ZYNQMP_PM_RESET_PS_ONLY,
+	ZYNQMP_PM_RESET_PL,
+	ZYNQMP_PM_RESET_PS_PL0,
+	ZYNQMP_PM_RESET_PS_PL1,
+	ZYNQMP_PM_RESET_PS_PL2,
+	ZYNQMP_PM_RESET_PS_PL3,
+	ZYNQMP_PM_RESET_END
+};
+
 /**
  * struct zynqmp_pm_query_data - PM query data
  * @qid:	query ID
@@ -101,6 +234,9 @@ struct zynqmp_eemi_ops {
 	int (*clock_getrate)(u32 clock_id, u64 *rate);
 	int (*clock_setparent)(u32 clock_id, u32 parent_id);
 	int (*clock_getparent)(u32 clock_id, u32 *parent_id);
+	int (*reset_assert)(const enum zynqmp_pm_reset reset,
+			    const enum zynqmp_pm_reset_action assert_flag);
+	int (*reset_get_status)(const enum zynqmp_pm_reset reset, u32 *status);
 };
 
 #if IS_REACHABLE(CONFIG_ARCH_ZYNQMP)
-- 
2.7.4

