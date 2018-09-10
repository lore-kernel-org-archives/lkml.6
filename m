Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F56C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 458CA2086B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="VE6nYxmR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 458CA2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbeIJNSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:18:17 -0400
Received: from mail-eopbgr690070.outbound.protection.outlook.com ([40.107.69.70]:65145
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727875AbeIJNSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:18:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obXIzwyje4REGqog+wApcQyaeSm4yB00QeHzY6QSOyo=;
 b=VE6nYxmREpse7N00c2QZJe78mS9OXIU3yocWYyYaCofbT6QPv93W7/eHPb6rlGxmzUfsknGn16fp7rId1eRNVHkppGdgzt66jT3d2u1geA7BZgsRnV4qSloPINxfsipngZ4yMERpSFyX3pIcxi/yBncFefVFbuCoxVHClawEFtk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jampala.Srikanth@cavium.com; 
Received: from hyd1621.caveonetworks.com (115.113.156.2) by
 BN7PR07MB4612.namprd07.prod.outlook.com (2603:10b6:406:f2::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.18; Mon, 10 Sep 2018 08:25:19 +0000
From:   Srikanth Jampala <Jampala.Srikanth@cavium.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        sgadam@cavium.com, Jampala.Srikanth@cavium.com
Subject: [PATCH] crypto: cavium/nitrox - use dma_pool_zalloc()
Date:   Mon, 10 Sep 2018 13:54:52 +0530
Message-Id: <20180910082452.19842-1-Jampala.Srikanth@cavium.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [115.113.156.2]
X-ClientProxiedBy: BM1PR01CA0076.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1::16) To BN7PR07MB4612.namprd07.prod.outlook.com
 (2603:10b6:406:f2::26)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c28fa55-972b-4575-2891-08d616f6f309
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR07MB4612;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4612;3:WTQdKc9Leibj+v8Ii0LD+vMKulfJWoOjl1w8sjKvd7PJLC1zIB/gX7or0uytF61WW3rsxyJOH2lKoV1rAzShFrHgeidg4vJ7m9N7naXez1LWy7P4zgHEdmkKCBWAzC71/sKk3fnQt/0M18swk6srsEiAaR1kfZd5QxqD5/REBOvHDgDcS/ac3KMGZqFKAizaH1axP4/u33Za1ihSbj+KTtF9FJAhMlN11PA4fdrfriOuUNord0Ta/c1dObsWK2DA;25:/JwSAi9dE29O96+Y+h5KjZEzL++ecyU1SF/UcFGBvYMnG9lnaDlLS2E2cPTw2RIv6KwqSe5V7byqPUO70csqhJijxyur+BGmtvbCpjRJ0BLiLwNXbWSBZno2Lr1dUzv/ryyNQZAhtRiwCqzhHrvUSOC3bm3HS8W4UXjbu9shI1EP/xkCGEmxZ2/7q3fQbiOo9kJz25uPS7Y+M0WBTQ7A8Ri2UPT6YdwHl4U4Ov95S96lsa+814KHJ5KqEE+F5/cDk0NQ/U8dvyrCwQ9z/kRBQhsLJG4ZLSmClvIT3VW3vw1tm3otxDi8SvJBW9z65VRAXnRtJL1lAGYbxPWVPM1uWQ==;31:oapoQNhGPVdbrHlUMseAAsiLAjqos33f0DZdJ7Uz2a8tour/y9ECmnQxOAQ3gD9Gs5L6adq/PPbgXcMerDAgB25YWQzE+3wWrpb/C8gnr9whVMbwMNF96Hn3juqODcaNfp8W7W1ZL65F570RAqmxDa88nX4mhv8vkgu+tuyfEHhCkgrqQOHDbBQ0n6OO6PlbpoXxNEP14YoFCo15LYqj5Ul/qZkFu4Sn+d9eGgI1fOM=
X-MS-TrafficTypeDiagnostic: BN7PR07MB4612:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4612;20:l47FEqE+2k0rGFO0EGLp0n+86eeYRr84ByRktKJqlq+UuomEeyz5zVSpdPL/XoQ8MIlIvDt83TlL3kiOya3XLUXjg42LsCB10ARvpe8qP3tJATAON5r3k6Pf9Zp4eAFLKIVEmhR1bAI8tOs08jGyfqx8vAUZSg4MXS/zrjTQVjylucRsJRfnAjHl0q1F/4ApeOfbkhARPuA5nt20YqdQbvfObfCiIGT8PZ/KpAwslEaRZMWdnMZ0E19ZF6wxc2hDJ1+vsD9xEumwi5Dx0MKSzoirhk28uWdydliKZrZwylp0szUao97fJL7y1f9Vt954uF5/8wkDFZwvcLVFpKOCB+rEQxG/lPu1XIik9XKKmxAKQFGyDjOHjkcW7F8i7Nm0rZYcbRzSRc5lHtJHnYpDNPMjI8sSwEEtp8dH3hKGKt5eyaVODB5qOM4q3qOhmy4A8JGFNyvx6D/67TXc3o6Og5xChyxsMjzA5ppxAtpjkhDCMdJ8pzpmPOv1R3wDdx5q;4:xN9vbTXUsSI1GLnDl1yt2VNXxOIe4RqW6wM9dfJFs4BL2lyFpVDhE2MyVp0P2/4LRZy3Ly+vOVoE3KGa8J0TokNIv1CCZ2Zq9+RE5mlsA1yfbb7x+Hf4q4HeYGOp18XNLJ5ZgYhxJ3jfh+jpxaJ87gf49ko4Kquw9vSNzvIgnadrQ/FToAyRSIJNqTAlRPW7JMv4B4Y4vBkNUp+r0X70waqWN098oxDxF4xvfjfY/osVvc7PWq8GEXn1jkzpFMwtx6eWQB0sYR2AcDrKXwZW2g==
X-Microsoft-Antispam-PRVS: <BN7PR07MB461262AABB91DF8EAAB5013AF4050@BN7PR07MB4612.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699050);SRVR:BN7PR07MB4612;BCL:0;PCL:0;RULEID:;SRVR:BN7PR07MB4612;
X-Forefront-PRVS: 07915F544A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(376002)(39850400004)(346002)(366004)(396003)(199004)(189003)(16526019)(72206003)(1857600001)(476003)(26005)(68736007)(186003)(305945005)(956004)(7736002)(2616005)(8936002)(48376002)(478600001)(50226002)(1076002)(50466002)(25786009)(2906002)(4326008)(8676002)(486006)(47776003)(51416003)(52116002)(316002)(6486002)(86362001)(36756003)(66066001)(55236004)(6512007)(6666003)(69596002)(53416004)(53936002)(106356001)(386003)(16586007)(105586002)(5660300001)(3846002)(6506007)(6116002)(97736004)(81166006)(107886003)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB4612;H:hyd1621.caveonetworks.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR07MB4612;23:ekdhspyVaDY8TtkN3x19UfMwgqpYkpbLnb7yxeT6C?=
 =?us-ascii?Q?fT4CblWLuSoFxC7HrmblLrQT004YfRdDrvix+ask1WuDCeM1lDwKmwE5DxJL?=
 =?us-ascii?Q?PdZOkuakYbCiGLnBkfkIafccndMm7Lc8Iqi4KI7fFEIkASViYduCTWmDouCA?=
 =?us-ascii?Q?d/Sl74OB3ULrHP8klmWKQyxDDCQQyvCRwbhWgzq+AoFzwkH5efLKoDMsR9pu?=
 =?us-ascii?Q?5//anY4tB0bLtz11izF0MDiZC6ZqSTafqOlfR7Qo7bj98KxyvZL9oMYzhN/x?=
 =?us-ascii?Q?0XWTDuIjdWpABAFwDHK1HsboTQAXkPf6mWWc9ee0PRBLJ9gOFyozh5AfGfwN?=
 =?us-ascii?Q?Bc27dH39KrkBEpIdPapRv4zTeBIstqYvUyryWzS8IuCpgtNv/r1HH04Co1Ut?=
 =?us-ascii?Q?V7/Tvlp1FEaH2hEJtrdd1m6BhlXOQ37ViO68K8hhzx3HikU2L0N8yLdqLo8H?=
 =?us-ascii?Q?hr9wwizDrNyJs4fhugdTe1E0Xqu4O/HNupFJfesx7pcSdsKLmM1j+8lvn/Ir?=
 =?us-ascii?Q?4rlJvYak+07bpQDZZJcmncDi3IG9BYShRvkJKshmxrO9Do0FuWyzLixn1el8?=
 =?us-ascii?Q?aDBAQzTo62hvnL7E3XUTYLfdENMuoH7BdZP1lzYhMvvcxxEguWVmeBTUavIz?=
 =?us-ascii?Q?PFEFtu3iR4bhtSoiVB/ehIvlc/02BBJY8cXTwHHeYnbwfXj7WZdJcr/A0xb5?=
 =?us-ascii?Q?nXMkojWxlz7ZGXMlwbb2GdqxnJ+O0y+11GpkMYyx6pwFlK1mZJ3RpMDQWoqS?=
 =?us-ascii?Q?gGr4WZEwxVro0xvBZOhO5T4hRqxYpCSIi0Vjl3PFzuneHQG7EBsD5NArIjhi?=
 =?us-ascii?Q?NMskEDWE0CogOk6S6PrNZCBG8NknFSIQy9O8LWlspNNyZAgv8mtyzLXR9LFf?=
 =?us-ascii?Q?3QzPutuJu7rfmEsWQdRpnPkdTAAQtNuTNHHI2jiUBdkxI4BeaIERXcQ1/JWV?=
 =?us-ascii?Q?Vi1XMmtD8xZkjRMwFIfQOAMzaBNSm5M7iaX3q5RYGOWYWOWOQZFBZz4BJf23?=
 =?us-ascii?Q?2zee0VwdowhUpzf3Iub/WDPGO6X5LPirJP0XT61/JwPOsBT+bORIc+5nqJyc?=
 =?us-ascii?Q?35Z0xmfC0ZtomR1A82HronH8Ejo9jHsFZzlcDTCZgovYGMlw7veOUtVGU3i9?=
 =?us-ascii?Q?aCY6YOIQJnIm+HVtZAcoa1Ds+8WZYg8GYshUWSkpImPiGhfMHMIpurf4pdnS?=
 =?us-ascii?Q?amrNDqlQzfBVWU5wG3++3ev8r9gAq8zOxjeUiwpAKjCiBoQ7LVWeJA9533L4?=
 =?us-ascii?Q?8Qili3i0xVClwK/ruo=3D?=
X-Microsoft-Antispam-Message-Info: Gc5oFn6djr1ogqOlpc6C77HXyf4LjlQ9jZ3T1BADYYERFRJW+WVC07pJcfgaB3yfW9XD9x7UNGfovysEaysb3vHM6NHvyggd3PvREIAdCdGXu2RXX1jXfZSMnAd1qjbz/SoNSb818XbNnqP+PXDvB3FNWIv27M3ZPYL0pXeRpAiz4FiWyucG0Ywi+DPXP/PjHkxf6jhOs8FMt4lonJIQO3FTmsXVMTRyf/Od5lQ29oi7xYmjGA5Am3h4qAFCAYOsvNdsHLo3Je6Pco2un2pNRiwNBweW8UUAeMr4FUrrZ2JvTOTH9knI6dFTGis/XnEzjx51xSpq2YtiFoQ2L4xtsMyU2Jo79mSrjTBmDMsqHG8=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4612;6:gaJ80JnlptYDuwne2JM30zImbC0euk3FadVehbIXYigVuxBJNnLD9mtYERb/23gM9/prdKq2Cwacm97Jrz3T/pNsCie2UwJvv9DUzE4CccYIDALaCWNUJxUi/8ng7m84UcFukHFj94vqQmHH4Xrba0wR4ntolF7HY60F53qvMS5HHmYf0p0ctygl60sL2GlqX92vMB2N6iUBtr4yNVoJUg3FUWnRZTpDVejajd0W95I/EpuyXBdwj2LysgiZFXsi1lkM7WvX66HIOpThLPnhcsogMLKG8lbX4sRi7ni13m45CLtYUCfYe3+HZshWBEjv8Ms7nCYp9Occj71xZsPJOaNP0uVuzDpUesZpbOwHEDGjGppkKBxNvRsurANkXqlpD26C3ZQu80KYSH0pkU5F1dDuyAVC2OU8vy6cM0ViUlnE/go9BNaW1EOylCK0dI/h5iw+USBD2U3yZcO772h01Q==;5:8GXqdajoZ+8JFtIHv4hB9I3lZlJ0PaRZhqc7qpFBtTStmW4gDJUAaO5PzbG/SloE0ZYI7YDq/o8IvWnzlvWIg/T+VTc1BrVwPNgRbGlyWtadquH0ZwyGBvcjFrfaQWvUWc7GHUqToO6u39apu0OlnCrOiDw1QZm2jiG9Or5ch2A=;7:bqWmHcZ5/+BTDS5EeQo26ibuF5MMv1osygmLTzQzD7CbIsQJVHKinljFL847xlX5Iy62ULWFTqVbH/ZVtqzfogufIEQIO999oqeyWAKec4RGM9snjJuo8p4eT9NaadJmXxKzQydOHwMAA0ld/hUtss3VdsH0kSWAic7peRO67+DqnbtyXtJg+RPoURSmZHGWkqjg2ge23996ME48uKdOasKv016il4NlmIDb1r8t+7AcVPjbloya9ovqOA/QdAUi
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2018 08:25:19.7411 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c28fa55-972b-4575-2891-08d616f6f309
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4612
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use dma_pool_zalloc() instead of dma_pool_alloc with __GFP_ZERO flag.
crypto dma pool renamed to "nitrox-context".

Signed-off-by: Srikanth Jampala <Jampala.Srikanth@cavium.com>
---
 drivers/crypto/cavium/nitrox/nitrox_lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/cavium/nitrox/nitrox_lib.c b/drivers/crypto/cavium/nitrox/nitrox_lib.c
index 4d31df07777f..7a721c7c12a4 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_lib.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_lib.c
@@ -122,7 +122,7 @@ static int create_crypto_dma_pool(struct nitrox_device *ndev)
 
 	/* Crypto context pool, 16 byte aligned */
 	size = CRYPTO_CTX_SIZE + sizeof(struct ctx_hdr);
-	ndev->ctx_pool = dma_pool_create("crypto-context",
+	ndev->ctx_pool = dma_pool_create("nitrox-context",
 					 DEV(ndev), size, 16, 0);
 	if (!ndev->ctx_pool)
 		return -ENOMEM;
@@ -149,7 +149,7 @@ void *crypto_alloc_context(struct nitrox_device *ndev)
 	void *vaddr;
 	dma_addr_t dma;
 
-	vaddr = dma_pool_alloc(ndev->ctx_pool, (GFP_KERNEL | __GFP_ZERO), &dma);
+	vaddr = dma_pool_zalloc(ndev->ctx_pool, GFP_KERNEL, &dma);
 	if (!vaddr)
 		return NULL;
 
-- 
2.17.1

