Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F532C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FF2620863
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="gwdxIWla"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbfBKIcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 03:32:31 -0500
Received: from mail-eopbgr120089.outbound.protection.outlook.com ([40.107.12.89]:11200
        "EHLO FRA01-PR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726663AbfBKIca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 03:32:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOiVASn7By808IbsH1zcM/yTRBWMUb/wqE5l7dgcxXU=;
 b=gwdxIWlaGLtlj+LYqw6i5P39bLq6Go4FGlkaeV3+a8NwCekjfupjrTyZlUBtgZBUelx2ShxKt3hlPPQe+R6BSnmcwIT2tHZLiA4BLSOdqrQSbpvPo5lPsq/pzvJ0GnNArSqxDDVjif17Th1JOH8F5c7SQJWdKKe86m0JhdUWHwo=
Received: from VI1PR06CA0145.eurprd06.prod.outlook.com (2603:10a6:803:a0::38)
 by PR1PR06MB4730.eurprd06.prod.outlook.com (2603:10a6:102:f::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.22; Mon, 11 Feb
 2019 08:31:48 +0000
Received: from AM5EUR02FT051.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e1e::208) by VI1PR06CA0145.outlook.office365.com
 (2603:10a6:803:a0::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.17 via Frontend
 Transport; Mon, 11 Feb 2019 08:31:47 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.48)
 smtp.mailfrom=cern.ch; korsgaard.com; dkim=none (message not signed)
 header.d=none;korsgaard.com; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.48 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.48; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.48) by
 AM5EUR02FT051.mail.protection.outlook.com (10.152.9.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Mon, 11 Feb 2019 08:31:47 +0000
Received: from cernfe03.cern.ch (188.184.36.39) by cernmxgwlb4.cern.ch
 (188.184.36.48) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 11 Feb
 2019 09:31:32 +0100
Received: from cwe-513-vol689.cern.ch (188.185.69.206) by smtp.cern.ch
 (188.184.36.52) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 11 Feb
 2019 09:31:31 +0100
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Peter Korsgaard <peter@korsgaard.com>, Andrew Lunn <andrew@lunn.ch>
CC:     <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/5] i2c:ocores: improvements
Date:   Mon, 11 Feb 2019 09:31:17 +0100
Message-ID: <20190211083122.32485-1-federico.vaga@cern.ch>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [188.185.69.206]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.48;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(396003)(136003)(2980300002)(199004)(189003)(53416004)(2906002)(6666004)(3846002)(356004)(6116002)(966005)(14444005)(50226002)(8936002)(1076003)(7736002)(246002)(7636002)(478600001)(4326008)(8676002)(86362001)(110136005)(16586007)(6306002)(54906003)(106002)(786003)(316002)(2616005)(956004)(126002)(44832011)(36756003)(74482002)(476003)(106466001)(486006)(47776003)(305945005)(26005)(51416003)(7696005)(16526019)(186003)(336012)(426003)(50466002)(4744005)(66066001)(48376002);DIR:OUT;SFP:1101;SCL:1;SRVR:PR1PR06MB4730;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx12.cern.ch;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d952c31-80a3-4e3e-6c10-08d68ffb5ca6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060)(7193020);SRVR:PR1PR06MB4730;
X-MS-TrafficTypeDiagnostic: PR1PR06MB4730:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Exchange-Diagnostics: 1;PR1PR06MB4730;20:6uPT6dWd31buDJRo+uTsipZUdmKBJL1C2eRXdU5Z/J5aEgAStZbdRiABZ/FQVGtG2FpuDKo/J2UXnX8uWEQtGoZKho6RNShmKgNIliKxXsDAvQQNg7V66V2zfUGC1jWgFmuuxjFtoGGz/VTMcgNRkJSUo5PYKKh3X7ouL5wp/xQt8XmX1N3VwO58siNRR3o8yIPkEw/Zb6UW2ks/wVCY/aXoQSWZtMblOS5EPfWhFukj6F307SWahFUGJ++32za9U2sDZt6Y/5xzFffmBP779UIfwEEP3FO/I5YfkAk+aGBeh8QvtRtic1Q5uUWUbacxZZwoksHokIvQBxkm4Wt+8p/ZTINhRJdlkhlX0e9ktt6xblS4MW7k7Qw8M4iKJZMlIBd/23AGEyJcuYhiW2vhP15ozHkTguQhZwCQ1k8xjMUPIGU6D2fgeKTU4bgghIJiRF9N78UV4tL6z87w45CwBITh3jr7YQBjoMX9e9q7/r1TB/xUttUTSkp/6Ha/nB/S;4:lZFoo8eFGompc/rkjnFQ+IGtIDC2YNWmMiogQ5C5p7rh5ovZU9XgPkQys58eVffn2UT0/HJYC/evmZhhKaNmkn6kk5yoQSb6lXStPKh+OiH48X4VWVmSoMLrVrUu0Hi/PHnXsvnff5F1PDEYGQy5EG9xKZNca5SyuBBICkHV4ZshaIwuuVsCzoZH/ZYxEF6zhcNAe4BxhwtWKil6c4Qqq311nXGAMwZNZyRZJHksYfiFXd6tSTGpIwe+3vMFQ1FJC4YzruE58dfw+YFiVixMKOZqq6Ga2DFK5Kx6hFzxal28kk6ZV6+P669ei80q94xt
X-Microsoft-Antispam-PRVS: <PR1PR06MB4730B7A5DB4CD05114A2D3D4EF640@PR1PR06MB4730.eurprd06.prod.outlook.com>
X-Forefront-PRVS: 0945B0CC72
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;PR1PR06MB4730;23:9Gbn4y/HnFGSJWYkTghpzswiZtOySPp40O+NSaVe4?=
 =?us-ascii?Q?VoBXC7AyY36xGEgLWtL8DoObulTuKgvBdYaLbHaAUBK4oTfjypNCNWO/qMj0?=
 =?us-ascii?Q?NHH5zgmHkBO6CVD7W9wwxUXM8ThXzS3QR9dsa/HwB5j+OuYs0OwFvOUxgN46?=
 =?us-ascii?Q?ceNec79+5H0cQoEQup4K0fhGAFTzSzqs9rODt2t7NDU4S5GU0vJBBzOSzkUI?=
 =?us-ascii?Q?CmDNAGnHJI5c0qKlmSRw5cijzkRKCUHzTTeaMRm/jZGIdabhZ9pOzNYaVxI3?=
 =?us-ascii?Q?kfPuVJO2oPBeCTuASE6opus/XeKsRiQ+UOkR4wumVlSvuiMsqQ9XQmgam1yv?=
 =?us-ascii?Q?ZVlmMXJk43b0VrZdPFAckwRYmlhxbR6FmgYBWqvedWdEZxnxWT3RvGjVUdsk?=
 =?us-ascii?Q?xxZM5sEbWlq7HJW4q4y05dsqu4oVYYs0YS54A1UfqNifUDqVLpyoFYI1N/jr?=
 =?us-ascii?Q?sDOzMQmQOxEcbB7KS+wdZY4rsZyC6IDRn8wDM5NjaJrlMQD0J6TYL0rTBWP2?=
 =?us-ascii?Q?Svx9auMgeZzdQLOQAI+CIufB0sClltoPHGvZEhjynOh+fZszrTJ7BXD2iOZ4?=
 =?us-ascii?Q?8U8Mk7KjlCXv/WI+GYjTPtjcRnxWgD9SnpozrR8uiD/IxtCPMHMLCYRIQy5S?=
 =?us-ascii?Q?aoRT5zGBDIam8pnau4KcaqtCjmkrUkAQkxAmLGMmzdDjuTiMbIAtfwCueDYB?=
 =?us-ascii?Q?3+k5GSyOlo4zh2m0gBzBxRKQAIqE8tXEubyD+08N8gq6Z3/xQY+Hte1yfRpg?=
 =?us-ascii?Q?as7tGbK34jE3E/vZZxsW0zIgnhSycAYnrIOUXJuibLiKDxiMxbOmxkyZ1Tf4?=
 =?us-ascii?Q?ufuZu4Gp7fHCekXJcM0YCNzaBZhDmDXLmUzonDf9YS/BLJk7pYXAc0AXAi/1?=
 =?us-ascii?Q?KV7NM6Mkl569GeFIl0rW//sCsWWt6tLEKJ4ZnSILqKwg4y8XOAgqT/wCNWkv?=
 =?us-ascii?Q?7R/TbE6axxumjRBa4jDW2NR+oxEK5Y5nmp5JOorjbnX5cei7z6z02lMV59dl?=
 =?us-ascii?Q?P++SI3j3YnWw+k1ZqJrvUGkexhZ9Py/LUuMXnry2UC3mFiZS8yHvHVf4JarR?=
 =?us-ascii?Q?dPqNxLaFPiA8qYLC2CJzCo8ztC8pVe/7N7RwtBmeZfoF2GKupzOeUQmBbARg?=
 =?us-ascii?Q?8l5cxW7BwDTL1HBHJVU5LiE5BrYc0JEWjcBSk9AV1ajCKOqln4HoS9Wh3mwj?=
 =?us-ascii?Q?xAO2AtIeR2Enr0=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: oT6qZnCFBrtnVLgxdlLnsOFqGGKBzAMRxUlYKOk3vJrOUFdOQNyixkBdHVz7TzeBGTmkMbMIJAltoxkENArZGcFzp8gPBR+zIb0bym37q0bOjyAJwIyObIThruJkeDoTVbyiWLyDKSIdozZfg5OjMJaG2/kVNCGQuILEIHl0j6KmxVwEp6MFhc0YxF9ltjmsdup0EUsZjGfvTTDQrOAaNTnem5cOWTICWM4a/dzDBvjjOOpUzNlMpc4MmiP2fbZMfol7IAmxrYckV9/xC2KViWA7fR4O8pzmOl+E3uNFChiBUf7ZaJ9Wgrs31kVuDmnqRy27Rh8udSa/rFkq6X5wS3Wym/uv1SR5TzKnxRWQiTitbxdgiPejeVQJ4GtMHnZ65fC3U4HrBJ77MKMTS804T0pBKMCMUp9ruTPtn1weJWk=
X-Microsoft-Exchange-Diagnostics: 1;PR1PR06MB4730;6:KxgTp5zf/NLpGO1XZfXlYZPkmYH/Sq0K1/dQiMSnTgQBZZTjRK79ospizXjlAcTLHhmHAu8ajKsGvaW0shFe8Cf7H/nYVUDiYQLlSIl2oyGl7Ohaunj33WENXJU71bXbnQH+YO0LqJ7LWD4BP/99c1Bxzam+C0HoMCGzXDyD5ZnXO7kCTr1EC7eltp5swsCfX1zRH2KZESvCXJw6mIEJzMsHOs86cHyP7Uq0yuExS9EYUrZ3jBgJK6v53ZobJ4yQvCxXvHhH8SQtMTQteHYFZpI8gMk3tNLWZGj3iutCRk4Dzt6nMfChFBq486Isb2zNBI65Lnx3nXHIJWBrdjAhb4TkKo0wUhjam7/Z6PkkRi1oRyuqIu6atkkWltOUSQFh2MBkLUZzwugIBlXSM6HAzwVg2Pblw4HB9IT0ItSjihCC+z76HRYyXvKUu49wlXLR6ilKSbPsc2Izm6ryHAEt+A==;5:pA11RwusxuEv4wo2Ju7aNFO0oRof1Dm0lGJyD3XhpIXHL9oPFrvm3CEPv1+d8XucmQ2WNLAFeud5hWqby5MudvIzCJVCumXIzW+JuKqpcR8kZWKtfiWDXIZcQiWQAjeXKlbyqP8qXngmTHJ/Yu3w7Wqir4tC0jFSG0tLnmrJyg3t7lEosaCxSMH1PxR4AQKxQ8+VCaOxThn2D8g+Nj0ryQ==;7:/MXivIiQsyojnFz/Hpoq0204pxl2jgZaLPZ+cXJSvuQTf2qZaefjUQk13vTACRJnJ1nIFmgWftqXw0NYMpnLfn8evtFbuAH+1413uab/3jy3c4bmzouOcE0acTk4Nc5vRzj1vOd17NFxjLv0m5ppXA==
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2019 08:31:47.1095
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d952c31-80a3-4e3e-6c10-08d68ffb5ca6
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.48];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1PR06MB4730
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set provides improvements to the i2c-ocore driver.

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


