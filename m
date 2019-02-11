Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E56C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F2EB21A80
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="HkAzSu6g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733195AbfBKQGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:06:23 -0500
Received: from mail-eopbgr140080.outbound.protection.outlook.com ([40.107.14.80]:59269
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729451AbfBKQF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 11:05:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fak0eOZ1pwoLIba0cpm5cLqoFaXlLjegdda1mc2BLwE=;
 b=HkAzSu6g2f331F2d3ngKFw6ERIRs78/T8IREvIxruyy9COjOs3mMC0Jg90s4kkwplzDHI5p4qXDf1gUF3+8azbs9hzTAzAlRt+MkKZREee+rHsEkzfFrVH6IDuwJzjrObS75+C+eUk7T3IPkshNb1vlJN4f6X1c1r0OaZlx/i5A=
Received: from AM5PR0601CA0035.eurprd06.prod.outlook.com
 (2603:10a6:203:68::21) by VI1PR06MB4736.eurprd06.prod.outlook.com
 (2603:10a6:803:91::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.21; Mon, 11 Feb
 2019 16:05:55 +0000
Received: from VE1EUR02FT012.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e06::205) by AM5PR0601CA0035.outlook.office365.com
 (2603:10a6:203:68::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.17 via Frontend
 Transport; Mon, 11 Feb 2019 16:05:55 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.48)
 smtp.mailfrom=cern.ch; korsgaard.com; dkim=none (message not signed)
 header.d=none;korsgaard.com; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.48 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.48; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.48) by
 VE1EUR02FT012.mail.protection.outlook.com (10.152.12.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Mon, 11 Feb 2019 16:05:54 +0000
Received: from cernfe03.cern.ch (188.184.36.39) by cernmxgwlb4.cern.ch
 (188.184.36.48) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 11 Feb
 2019 17:05:37 +0100
Received: from cwe-513-vol689.cern.ch (188.185.69.206) by smtp.cern.ch
 (188.184.36.52) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 11 Feb
 2019 17:05:37 +0100
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Peter Korsgaard <peter@korsgaard.com>, Andrew Lunn <andrew@lunn.ch>
CC:     <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 0/5] i2c:ocores: improvements
Date:   Mon, 11 Feb 2019 17:05:24 +0100
Message-ID: <20190211160529.23858-1-federico.vaga@cern.ch>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [188.185.69.206]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.48;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(136003)(39860400002)(2980300002)(189003)(199004)(106466001)(14444005)(6666004)(74482002)(356004)(4326008)(50466002)(956004)(2616005)(486006)(126002)(476003)(1076003)(426003)(44832011)(48376002)(336012)(36756003)(53416004)(16526019)(26005)(2906002)(186003)(6306002)(966005)(7636002)(7736002)(305945005)(316002)(66066001)(106002)(4744005)(478600001)(54906003)(51416003)(7696005)(786003)(246002)(47776003)(50226002)(8936002)(8676002)(110136005)(3846002)(6116002)(16586007)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR06MB4736;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx12.cern.ch;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5845bf6-09ef-4cb1-435e-08d6903acd63
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060)(7193020);SRVR:VI1PR06MB4736;
X-MS-TrafficTypeDiagnostic: VI1PR06MB4736:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Exchange-Diagnostics: 1;VI1PR06MB4736;20:vM5CTwoqDDZwkdoKxNCe79SjOxT8JBTrK7x0bJWUfhaAei/kxDee4EQBoT0oBZF6Zz1i4ozdiZ+mIcv/EPhFRXRGUYiAR0VDpgGZz1QqEuWqVcg+ldYxnxloNlC9XP6WmlU/z+hlEpXzn7RsoUw1pT1OQe8bvHn6pkTT8xNratDQPMPu2LOgpfja9bDUWs6THY9aSobWPLY0mgrscP//L0DXn419qGszCcAJMzrQ9TPgt6xA8gp377AeM6WERgdlBeP+QvfyQz+jM9j8PA1bSb6cJZyA5R0nZJJavXltrUy0NuzUbmXmle4IPVBJhVElhR34QESlMsCNTEMoLPJQFoWlTl2Of1teKUCyzMfUpT/fM0ju1INzhVH0+oOeALAqZA3UsZuT8r7Li0JJBPMVqIx2P6oX8LErK0ljo2P5VNWRTWdOIOJZhdgDiijG4DBrmo3vzQ76oD+aVOWD8JE+bkXvZ8NGb8ci1L1IZWqy83QhMy/YDgBeTFEYG7cTDbFy;4:FODyInrxjSHNcykrhsNlefWqlt/r14wTfLJ8bOwWIIKsh78v7gSoiuOegtS7tg4+pyZ9qXhTlgwNIqqaVD3MPXRIL3EtJH7RS0yM0UoGt/MXYpxd+ruGUDWQBjWZp+NIjN0nZxtc6A5Dw8XXfM6cDuyrat7kKc/QqobdngAB9WwK4xlvJfd5bnHTLaiRXWd7d8PdHIu2C6M8bGi1Lyd0idfv23DjwUjDbMtX84t0SRNwA1RQqDgMAEG18CDArAb499LUIb9LyiCafg7HxxaowuJGHvKRZ+FQcjT+kaT41TFBnJts5kICTOjeGjNTdgey
X-Microsoft-Antispam-PRVS: <VI1PR06MB47362BCABF4C0EC5FF5C82ECEF640@VI1PR06MB4736.eurprd06.prod.outlook.com>
X-Forefront-PRVS: 0945B0CC72
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR06MB4736;23:XP2CILd6ZrwvI8/v6+KSZ7VqwW/Q+pdtxqGPCpz+6?=
 =?us-ascii?Q?6B36hreMFSOOwRFV6VtL0hE8VU+Wi/nLcFb1CcVvgUcxVdZFEEUXzQ+TAcD8?=
 =?us-ascii?Q?jhZhMJpES3z681bqLxTBVexrUuY6bn7ZGZA90QK+sB7zHHSX4WQnrqBbD3xI?=
 =?us-ascii?Q?3L0SGA3Giwvad0/C8niNDAt9Y5ZgGOOry98Dhc12LPQWlt0V7ExHA2SGC6JW?=
 =?us-ascii?Q?CfI1gsUWXnDBkLX0pdbd3/RlxspJ4VlHBXMVTSVlmCkX0G3JH/stNiJ6+lqm?=
 =?us-ascii?Q?22Uw9esXeCZIJPDOmJngjAxDbt/ROAjA7RJ/lAPoibQkgTnHn+PCPjpZnSO0?=
 =?us-ascii?Q?YbqUBtCAeGE2ttovxHpyIQnXjqabgd8Avku5LkB74KvB8DuW1QLK5xmEZUT1?=
 =?us-ascii?Q?+yK1Vjv0DyzXxn+7E8rebU8YG7iOq7AcUUAF/HQAg2DFNEFULMveGR9E8070?=
 =?us-ascii?Q?g048H1Pfrsuvqz+JRDxoxjL0tP+E/iLvU7G+S5HfO2yVBOgBxieu+cKT6e/4?=
 =?us-ascii?Q?ANkIzwA0tOtEzdDtJjtYkgQR8uoVilEwLhf2Zk31c6UckQPBjGnbDW9de/V7?=
 =?us-ascii?Q?jVH9JUpgOcDVRVpTIDAQAL/v4MZ7KBjn6/eiJZ5KINLFGFRCpU9rFvqESrW0?=
 =?us-ascii?Q?Trn/TrPZemlHB3INoXpfsMtxD5dZpPwVBnRmGmCDfPj2KIUNIdXsQ/xsROdC?=
 =?us-ascii?Q?7P2JTnCAslDJ1yFUKw6lp2/rJd/IZin6dUk7mXd2LrEGRVJ2gixW5jTIt5wu?=
 =?us-ascii?Q?xYbYTKb3Z8TqaZ/bONmFnxZ6WjEr5FCqhnSlBQWGK7SQEQUW39KZ2MIyKJ1n?=
 =?us-ascii?Q?T983oD81+DkVowjGOF1c66xhttSDdtFSi9c3eg8f++HY+GiJFIzC6KpSm/9r?=
 =?us-ascii?Q?crjt/xPaE86gB+HN+SjHTnjlnp6Mp6bD5ZRvnS4DZs+0cjAVeQPnmIE3/xJe?=
 =?us-ascii?Q?Dc1ptPXUgvElV2cVEcSGFR9zO+h/U+8OS/YnKinxHg7MYh1yrKmxmchGO8l3?=
 =?us-ascii?Q?UCviNlqzjAmKGPLeMLzROQmUlCiHqx7He4wb2RQnLozGn4OCQG3sgpdr/3zI?=
 =?us-ascii?Q?IEfe9rCis1i+T97q6xvxWLAPU4qZCi1UvrNsjvdVs9Zy5Xr4dpdU/yz8oPdO?=
 =?us-ascii?Q?WX+mcUmAQziw9PQSL2TIHopKjCzayErXE7kwYdrmniH1VyNb+/i4eVS3EfI2?=
 =?us-ascii?Q?HiYMcY5PrNenbU=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: s6pS8njcLl8GLfYgzYtsQfVQaVfXYNr8fpI+5y93wiWvE0KIfnV/cJ9PZqVCLJbZYPLpZZptJxFZEURSQJgGnmCJ9CdOZoMkJXUj2L3wBUj0R4YDckqLgizYfOeYpkDqSHQafbwhfTFhdx8cu43G193MwTvVFarVGde0z9m2rO7wY68Q6YP1M9l/9ZVD1tzixO7fmFUVXJbZJIMow0Ia+ZnaHBe3xt3KWDllGssjF8Whkimdj2G+wiUKzlPosq0y/LAB6zPbXJMF/eGXU2c//PgAQOMwU3SjS6FruJaXABDDGPQS50R0MKqshRKJbAAUQ7jHR6T4wIJ0QTazTUg+yOtfwyrQGLdRZGFeZsg3HG6K3mAcqLnso6RlJ3rQglxTDbQ8UtECl7OT4RtZYOUcVeruUTv84duWGb++XccELDo=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR06MB4736;6:amC8XA9PZ7OtK5LuiH77NyJzjpRVWsnnkPBJDeAIeJCwc3Bd9uoIcwSXxSIAJpnPXBY2TgdBVXJdInoSukXxiYpf9JkEH4Bv6GSRS4TgzWIPoepuPcQlNlAz0YwKe/W5YhJj7BBDBehI2/gj2in3qSVqf06NZLUKAneylXHQe6zYxzalEMWU363Abe4AIcA6eViXYab2PGxfBDcwNOl47aw/yWjNsAW73erknegsPlQMIqRuNfc9yMZMwxwj1/U8ocuJNqqZbbsu1gkVuMWnwl5sqiMCPtv2GZnohL9qQNaq8uOQJ2gDnA/Y501vVs0t9cUCLaHR29o91TAPEBysC7kfiCSZBC5InwtO69kvGTsdJH+n9/tPfSY/aSMTRdA/Tm9sW5sTG/Tys+zi8bwhBeQReCOmdwoKc1JeYMVS8X0qkQI2Kc0Ty7CHbdBtqhFeDdCrSPFPmzO8teQxJlYByw==;5:mwkTQJ1maMlPhOp7/zoGsTvvfkYC8Mc+hhEjnUBMJ3uy63sztBOTglh5hoOcMB1DtTrrvLP5bzAqQAsy6g2elSyqHAf3oz7lM/vc1skofGeLeY1jTmcbAMa30aF/CYuds5Izx+IlsTbUwSnaLgAWa8qDVbJwb2RM57vdHcYJ4MCRAW5LD8eB1Ry2Kl7yDYSQnr6RHz4NrOk1qmSMxxGQzQ==;7:rHi8eIyePutfz3VGnGJo2VJk/hhX4f3Xkacl+yUvj2f++ofYEm/VXtiAqwfDCxgBsHClp/SbODgqdJ/SCqQh/T84NhZUKP0UW2VkgsW4Sd5dco2s6mfF4Ek4GQflDR2zocWU1eGBBJspvV0tlXYubg==
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2019 16:05:54.5259
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5845bf6-09ef-4cb1-435e-08d6903acd63
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.48];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB4736
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set provides improvements to the i2c-ocore driver.

[V4 -> V5]
- deterministic status of IEN bit in register "CONTROL" at the end of
  ocores_init()
- more style fixes

[V3 -> V4]
- add reviews-by/tested-by
- add comment to justify the formula in
    udelay((8 * 1000) / i2c->bus_clock_khz);

[V2 -> V3]
- fix particular error condition on platform_get_irq(). Copied from
  https://patchwork.ozlabs.org/patch/1038409/

[V1 -> V2]
- replaced usleep_range() with udelay() so that the polling version can be
  used in atomic context.
- added dedicated patch for minor style issues
- fixed delay computation
- use spin_lock_irqsave(), instead of spin_trylock_irqsave(). IACK is always
  necessary and a trylock would generate an extra interrupt for nothing
- make the driver ready for an eventual master_xfer_irqless()

