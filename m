Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461C0ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB3102083B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="SQ2o/Rft"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB3102083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731114AbeGQQcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:32:32 -0400
Received: from mail-eopbgr30101.outbound.protection.outlook.com ([40.107.3.101]:10642
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730758AbeGQQcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:32:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3l4qoQQt6fVrfDRBNuX/0Ss+mYNE6Sl7bypEiaF7SeE=;
 b=SQ2o/RftzYBnftRL0EgcwhMGFiP6A4LlJf268jEixRrUX2BwAXAvNDU/1GgO+8hHN6e2GWzfp8D4TjBS5kpCCtJ+Rfp9vZrE+BjRnlYnLqMqL+/5v+R+u7MUqbgZys+2v2VobiR+S7EoBoLERHy+C+oeoEwb6Bju+kwIP8/UK9Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com; 
Received: from i7.sw.ru (185.231.240.5) by
 DB7PR08MB3258.eurprd08.prod.outlook.com (2603:10a6:5:1f::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Tue, 17 Jul 2018 15:59:04 +0000
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: [PATCH v2 3/3] fs/fuse, splice_write: reduce allocation size.
Date:   Tue, 17 Jul 2018 19:00:35 +0300
Message-Id: <20180717160035.9422-3-aryabinin@virtuozzo.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180717160035.9422-1-aryabinin@virtuozzo.com>
References: <CAJfpegvAAQTAjxLcQLefvFOQDJ6ug_G8Jggt=UZci+YnNP741A@mail.gmail.com>
 <20180717160035.9422-1-aryabinin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: VI1P193CA0005.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:800:bd::15) To DB7PR08MB3258.eurprd08.prod.outlook.com
 (2603:10a6:5:1f::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c2d8296-6b19-4f5a-dc7d-08d5ebfe391d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB3258;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;3:llcqzF8JIXIhzuipe0l5TC88svapSILN6HWZ0KFLIzFIyZ8LOxy5UBk/R+aZK5OUtLFcKOWpOgWwFNA2x/gM99hrBvMEgDSiKBvsbKAardjalR7x8j4M+YYL0QUWuCkG55DHJOGVJm/EpU/pfu7h9myuoRMY5PbTcr04JZND0S2ENEkzpJeTNpmKva1L+hVYKo91YIJjFCtBC2JTz8Ha+sZxMyvApncQiG32Fd7dBiT8pSEYMiP+587zKMmWI5Gb;25:W5Am0/bmwsJoG86IzWr5z+ti5N8LfpXmsAF6OcJVd+TY5LpqGlVtv0EQNMQmAjFdcmHKJPE5+0JqAE4gAUfgJU/qODJcUWvGGFkFf9ACz+qOAVCxw4mMcogfOG9on+rR/kyTtICsTn7Zq6RPyRNxxv7vqy8Gw/RoOmk+mFbXDC7T92hFFyPxXbpyw+N+PN5t14Or4eMT2DarvkoCSjj/JG2RcgGRn89bOPgf3Ip//338xvGkSoVdJij/PDJWZwOO748ofNExGv2fsAFR9+D11izCBGbpvKZzpEpqB+1zJqXeM8ESbUrILClubRhhINt/Id0oOxLd3fFXq1k8T0+yHw==;31:VQJl+62D4AwqpPc498+R0qwbcK0a1uQxn2dEFGUGMItS6kgvIMIQLM25f8U+YDaEPopmlPKWQtme1BcbSNLgpspdufO70bpvZebhsw6iSCJZxPH/xFzLhpYsSYNldHEY+QpsMWdw+4sGT55zYDVFfDAouptq1O7U5WNJw+QoyZNXhttIUSZeQtjTkozmzdukA1BYMqaoiUhzFo13hHrtKTWPkFIw6dzndhhQz47ieUA=
X-MS-TrafficTypeDiagnostic: DB7PR08MB3258:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;20:yBs6mCkpvsOWFJls00Bt1JobOdBQf2TPu8DK4E+UxdS4WXzn8C1AmO7uPeLrfWQD2H3h4u3i2zc53IMXQag0yUllwd8HU2tD+6oMgYisUc+I8vLpp1WIkCv0njo7YFcTWhu10kS1DpQIDlHQtXacKrJ/C13UFFmeg/ZHIZ4PIP4VAgRyc1g18HbTnUI+pGsXPWfbajJoZryPax21P54+IKlsEuiDWZNpLHucRSHlOecmOZ5GckA1vsgYDR9ZBIxypD3TMJvmBpk44Z8cVJbA3sj3oANMdORHAbGVVmyi++Mhr8k5QcNmni51GZetCY0oMHZwCLYppKnWeQSiTjd1w6fkvWVMDUFHJF77h5CepAhMWfslC6wk2F3ZAREvuZGKe9L3tbR4FiHKLcO7qHgJOaUtcVx93/YDeDTthvTca18aVjVX2PJO2YX8fSmLdJnjtCxq6d+/Apq68LRrfEMa2RLUFYoFV9RWFXd+i79n2m71lLjSLsJLJ+kEpRkOmgGV;4:jsPuaJFqwjPFYOIIRWE5dWHulSiVO05nwsNrLjqVs+ZAKvUiq9JFL/IClMEKxb5DFt5exTxULIdrY3/GykCpKugRtkJvayHqvK1pCSetngHjqdJ16bqN8fgRmWkjWdxK0MR0P2+dDS1VpI8WVL7+CxZ4/ZfiFYmPsywjBaFyW2yl/BVf44vy0CERIXRVoKm4gmVxUdOi6V9uETWblmSnkcamOJ44Fd8w7rnrkimRevx8RMVbz7E9BFdnPjETnvKuY+ySS/0ZD8K9yfrUCzuBlJcgR625ckSl+I21FXb72v0I924wo+73EfrZ6V/YKgwU
X-Microsoft-Antispam-PRVS: <DB7PR08MB32582850A520BC71B04B6707B05C0@DB7PR08MB3258.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(131327999870524);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DB7PR08MB3258;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB3258;
X-Forefront-PRVS: 073631BD3D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39850400004)(136003)(346002)(366004)(199004)(189003)(48376002)(68736007)(6512007)(2616005)(5660300001)(36756003)(476003)(11346002)(6666003)(446003)(956004)(105586002)(106356001)(486006)(81156014)(8676002)(50226002)(81166006)(7736002)(16526019)(47776003)(8936002)(66066001)(50466002)(2906002)(186003)(6916009)(76176011)(4326008)(14444005)(52116002)(6486002)(97736004)(6116002)(6506007)(26005)(51416003)(16586007)(107886003)(1076002)(25786009)(53416004)(478600001)(316002)(86362001)(305945005)(53936002)(3846002)(386003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR08MB3258;H:i7.sw.ru;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR08MB3258;23:svSjI9UjcKXIwWewxUl84KOYjzQRuTn7KPrWGfoSx?=
 =?us-ascii?Q?8hKD93ov9glOW2tlyW27CKeOu6Z7zd2PO+ksiZxv/dO7T6FnMrj/QzSdp4F1?=
 =?us-ascii?Q?nONcjOP3w48puNuGl+ZxkV/rrAFQbeHAVuE4/9KFtTlT9400pcTyECBIBNne?=
 =?us-ascii?Q?ubpiJXZhTwwK6JncZLcEGU63oWVOJoVaPmgED0zRZ35R4/w2PTUDxY+RBvt7?=
 =?us-ascii?Q?Z1h9qeG3aBPLOqxzmqnPwNtzW+tBVO0NNNxvTSnEOxbUb1u9vfeVVLxL+ZFF?=
 =?us-ascii?Q?2RJnazPc2OUsAlzpa8W3VZA2kcN7VbMEMYxyc8FnaVn38wkkCxYTCbrIkRFx?=
 =?us-ascii?Q?8xedilHxC1Sr6IbyRWmN6c9WkuldXB4WGHDO/zWBXYr75FHTvN6ZwmnjFyWJ?=
 =?us-ascii?Q?q2b8wo3odxbBjnXCM1nqQbBTPh2rwNGW2Acz9I/CjQryFTVc2idjpBP0sFpr?=
 =?us-ascii?Q?jFPja6siDfMAunVdt6QaBbWv3YXO6km013f8OkDbz6YGJr/Rn9/X17bnO75S?=
 =?us-ascii?Q?flRlbbqENiT0ynNb5Amzp1PXDLS4Q2SLo8bKA1pHLC+3m+HzvXNiOv2ZkmIn?=
 =?us-ascii?Q?dw14brP3bFT8IVqWXNak8s6Hb23fBTXFgd2HinmUYJgAaIo8v6buh5EA1rAw?=
 =?us-ascii?Q?+WbxbVrrqJkgCJpKFx0iS7XJlzP3EqATHLFEzMaVXNlP9aO1S7zYVyuENtie?=
 =?us-ascii?Q?SBHUjx+Go0aGSL4PkiYPL7IbMuT/s/I+xeB8dvqFVxLa6F5qYZBw6aqyaIPw?=
 =?us-ascii?Q?nEJeeQ+jFxJFBy0+Q5oy/xCRFmJmPU09H9TI/dCKSvVP3qnSiL1pPWhq+gQF?=
 =?us-ascii?Q?3Jn9MKW/SjpwOftr1KTL72fICPE1Z+30Em1/JDNC6xLj1wPfYJED31wPCSPm?=
 =?us-ascii?Q?vXeI9317crPRy6AZ10Oc71IMrCGeyP4Zb70sKgCdtDS4CokW2eOC8a2Ik+8s?=
 =?us-ascii?Q?tMfKKgd7B7p9U7NdbYAkAXwM0f9z/0CxbBWUEemc3VSCUgVuBCIiXDMH/rB2?=
 =?us-ascii?Q?l4XQIBIuS5U9knnlYip+sRlQmr7kQlrFBXkxOHXl+XUfSRanFPlUwKOZ80DS?=
 =?us-ascii?Q?EqefB5P5Pv2qw3QAyV1JLMOQU7zZWhf5FfsJEmceJOZGvD/TAle+P4AN9Tfp?=
 =?us-ascii?Q?IVSlZWKSGG/bTyq9G8jV98G1aZwZ+9KR470LPYUQCapzycf7+8lBtLcB+WLT?=
 =?us-ascii?Q?9wTYvaCUvVpdyA2/fu08d1pbzSNDGkRvzP8cEP18++pK80btp2HhPB+qaB7/?=
 =?us-ascii?Q?iLwzduEZTvnWLkUWkg=3D?=
X-Microsoft-Antispam-Message-Info: vNZqLlk50C0jNdNc82wO0wuS8BrwHFdSWwrugVs99eaaXBVA1IaqkLH49jBHsUjJBHmqXJ76JCdh7pP1ti6FMzBVRqoqIx+8mqsPtSasQzKbxx3QvScKkb2rftcJW1dyeC5OWFTcT3LYt4onqEEoSsNuD2RMVzwlcprDpxGi74pGk/XBezWVRZzYIc29SpeI6SBt0F9g3g3htXjFa43JY0yoAkYXB624T5B+DZwS+oZRoqkCWIhHMqOL+rcHTIKvyGrBNICYCYHTwDgg73F41PZhr2kziSXmxcqALFceT12PH1A6LGP1GC8Q5zfJhFIbkusxl3X6R8SjOAXH/ylNQqe5ReAuMz0ip8A8qpN43AE=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;6:NjlZTnHf2iAHyse2IAY1U6jFdyZCd/0clJ4+HMr8x6haqCcEdewaFk3FlJOszo1DQmhmb/e1ANYFaPWQYndrqjwA4Rio9CUyLyu+9ZOw7k18NOAayKt+20gn76tMh50U7Z7bbpHh2GTgo4VQbx+pLOK6jr9cRGX/nbx/QblSmSV17Z/X+dbOVFgsfXQn7eNA7yKujEfxkjJobHpnj7GNZlUJJV+FNFx+ykHqkEXsf96Q+X8apfC2omy6fNfseJNQdxZDT5Av0R57XVFYfF5Wqrbes/d1T/2yerK8/m5lGe0ncerXGTPlIRYaEnJUZ8yn6vShimSfTSoB05oa/z1pRFRb5iURmw2xyE2yvzSiMYWuO/MAfC3Y6uvMutT2zUCP3PRa6pQ3G3kZX0RAQJO5dwD0GztcxbdtKpQyXfadU7Y4XzKA92BNZvn3i57kyebTkEBQq6QUB2Dg29DJsXFU+g==;5:1mpfp4hjOdCkf1vopmncLC8oXyFu9PeV1pLdfmvhbGnMDojZto8HCBtx6Eq81sSL/RtMocvHfpSvD2opn8EYb2/DKXoga663ytduplUMMzUQFEmeXs87vwSOc3DPxYVc6D+IBzl1DrrzqUbvAuJDF8fctfu33XovWOnmwErYCsg=;24:HpY0n1DIHmNB3WYdRzEDanUQWAJQb9TtvRN1e7+ocfVD87ASrnDdo1jpPhYw3WVJ3mL2IPDFb2RKYmy4NWYIks/hg/YcLfKrSDlgTxAfBlw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;7:QK1ID5wD9KERElMbpnBGj15HP74pdIOvIcnxY8Uk69+E6C2YSTT6U3W2oBl8E2GVTdc2Yk0cv6qllWsiVi42cWkobfUxjGBqhmTda1t5ol8Y09QDmFxq3voYGP4ELOQ+PTNfZlLg3tKH0tAIoxK8qEUXFTGM1WvZ3n9LmdT76nM9MImYRinsn4hY5mBXjzA+eBDl+TCcIswFhIq9+2vE319/NYDfmbrx1GYKXkPDd9i9pft80D28L9FIucdZMV6W;20:m1KvYkwzUwY0D2Dj9NoN/L3OG7eI+uDPk0K2p/nPqHvPlh2I4VkOizM+pWFrXQcE/Mh8DUFbCgBrkxbZGVpOAcXxEUsdn2MpQ65h3g6xqt7aR99v94m+FirVWZtOMmwVmyso+5Tcp62k4fJ7yUMQ+gJqVOpJEq6SQJuMMMIg5rE=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2018 15:59:04.9538 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c2d8296-6b19-4f5a-dc7d-08d5ebfe391d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3258
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'bufs' array contains 'pipe->buffers' elements, but the
fuse_dev_splice_write() uses only 'pipe->nrbufs' elements.

So reduce the allocation size to 'pipe->nrbufs' elements.

Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
---
 fs/fuse/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index fd4a838c1673..d78af3c146f9 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1946,7 +1946,7 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
 
 	pipe_lock(pipe);
 
-	bufs = kvmalloc_array(pipe->buffers, sizeof(struct pipe_buffer),
+	bufs = kvmalloc_array(pipe->nrbufs, sizeof(struct pipe_buffer),
 			      GFP_KERNEL);
 	if (!bufs) {
 		pipe_unlock(pipe);
-- 
2.16.4

