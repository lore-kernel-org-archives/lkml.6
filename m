Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437E8C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7C0120852
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZU4t1Kti"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7C0120852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932824AbeGINvO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 09:51:14 -0400
Received: from mail-db5eur01on0124.outbound.protection.outlook.com ([104.47.2.124]:57216
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750996AbeGINvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 09:51:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7rhD+tYkViKh5vlKr6Gxtm1yzByT1ZSc0J65UhuZXs=;
 b=ZU4t1KtieYv8JwpSxpBhaVyDMV74c5agbrWOJ3+Oo1u0OpUbfM3/LPq3rV2Bk1lXJq/7bQbAW/l9ngIycSShndmGWATAIdx9FZp8diVN4D6O/accDrdKD2FNjuSCMifcs9pTAPx2JBx7zcYyoeegE31o6bg3uVgv0gQcm9heJGI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jan.dakinevich@virtuozzo.com; 
Received: from work.sw.ru (185.231.240.5) by
 AM4PR08MB2769.eurprd08.prod.outlook.com (2603:10a6:205:d::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Mon, 9 Jul 2018 13:51:06 +0000
From:   Jan Dakinevich <jan.dakinevich@virtuozzo.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Yuval Shaia <yuval.shaia@oracle.com>,
        Alex Vesker <valex@mellanox.com>,
        Erez Shitrit <erezsh@mellanox.com>,
        Feras Daoud <ferasda@mellanox.com>,
        Kees Cook <keescook@chromium.org>,
        Evgenii Smirnov <evgenii.smirnov@profitbricks.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Denis Lunev <den@virtuozzo.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>,
        Jan Dakinevich <jan.dakinevich@virtuozzo.com>
Subject: [PATCH] IPoIB: use kvzalloc to allocate an array of bucket pointers
Date:   Mon,  9 Jul 2018 16:51:03 +0300
Message-Id: <1531144263-24717-1-git-send-email-jan.dakinevich@virtuozzo.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: VI1PR04CA0089.eurprd04.prod.outlook.com
 (2603:10a6:803:64::24) To AM4PR08MB2769.eurprd08.prod.outlook.com
 (2603:10a6:205:d::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2080732-5ad5-44e7-073a-08d5e5a305a6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM4PR08MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR08MB2769;3:lGrgV5MQ6DXAhVIVdzGrH9PJMbYHSApWEfZWFBP97Ieypp/s4IfeGC3Mw6JpGiqkCwKF88pXqaajgI4JyxwaKpbSlDLHVhTAVydH61SuzxvppEUQJzmcX3owPumxB0219NcCyl3CqKwVDRmzz25QmOxijtyoPmak9TsmJ7jAJHRcharZCtsb51GZwdihGN0AHCNv/Ja3/zP6GS1vcpKPazMgruIJXtLC68Z2ekfOy1DW0FnLUHiAmFO7j8mMFeUe;25:/6oqz7Ja9uhpbJJjgVHS23Lh657rSKfPax8PuaB/d2emsRFvM/tDIwg1BlWNubER6JUBxNQf+6mwbwu9ry/IMRW4me1ajUDS4i2xMdY8wOx/zixA0PgFFnFgjCN4JvOQ/zhPAW+hOJOwmIYOyAW5/zBokVI+KZoE64o2N15YD/kSV6hdCMY5YHpVF5SKKoZ0M5mjz+u0xT64UifnHBF9BM7MAuvv/zZcs+bLgR202cWV4JA3TSt8gHeISjZ5TQruqFJKLu8HsGxg12iMpgiiQygayTEpifOYr0ZCaKuQV9lwMUnjGGf5LEUB4ErIv/yPGY27ovk60aVL3ICLdE2htQ==;31:RAHsq10CA9iV4OBgpnMS1xWVt2IP8iW/xaDGG8aEFPYyDu8rn030ZgS6HawX1snXKBpDPqYnaOkiaraqpqpbJ0+QZslTn99ibmeuKBYzhWl3Lp9xBcPlPfAIXdxmHuyMS5pM56NzNKSxAR92r2TN7Tdj0xz4i6zEkK0Of7OIKNPczUcygZIlYtyvaQib9cmE4IviZZWZrILPwszPklPYDDZNV1swv0H6Gs7jtq6t5sM=
X-MS-TrafficTypeDiagnostic: AM4PR08MB2769:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR08MB2769;20:OlA64l0+XI6Idw4yTedmVlw/Pdes06PzxZeJWRIaV17xVGuwRilxW27WQBdwiSnPv3RTqpzJMr3uVIjzOVWG1LCxdkajG7FNKNrFLWbA//2SqfIJd+FswJyolswBItUesLTO4rDp1HcEIurYrmuZ6/2SeBjF5uyKUdC/RQRo/pgyBeDDRrFDNo7iQOGLyJDtBo3zNU3ugYtiXAnng9ddK9XY2ity3QsdgftcoqMcwQji3cpE62hGpOeMP0mecDzlNQnL/wM7PHWOl5UL0u+K/ps5JRpWn41I05FPQW5lTRBM1+h2lN6lc5xpg+2VIXGNcVACmVMJBHojbm5jV3BjZN5A1AXOwpsBeoJsf+kv9xkNpssViQ88x4Vugft+rIeHFfe6bXDqwq45EBf1LDvM01Hs8vmIZ97WIdMq0tKzvUy5E+KwDs50YgYwvOMj8+QyTuhUy7l8S4g+tGU9ypa5248yjACaQOSqPC7nArJic2ic0lEVPQUBnVANnSYzqP3d;4:YQGtttsWl/1p3uMHw+SXQIKPan5SFCJKfmPlD2ST9rXlMMr4XXjO/i4h1dglno4kRnlGtKzaFO636r/qyL9kCU3kzowrznO6C9jkjek6HNw4eorskfvLaO3nGKfn193cqT4HRf2ra3JjC3Xe3b5YmQ5XitZlplz9OH6D8V8CPPMDAwfBh/O95MVmsYXlKYaTQ/6w9WO0YXF56UTA1Flz67qx6mMfOMYoPynXLMOQvMWNKpaBlAx6NdFxvtIy/WNPLqHcvQLXl6HaBUHXYxhDIQ==
X-Microsoft-Antispam-PRVS: <AM4PR08MB2769F5626E203CC202E516258A440@AM4PR08MB2769.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM4PR08MB2769;BCL:0;PCL:0;RULEID:;SRVR:AM4PR08MB2769;
X-Forefront-PRVS: 07283408BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(396003)(366004)(346002)(376002)(39850400004)(199004)(189003)(486006)(8676002)(7736002)(305945005)(6512007)(68736007)(6486002)(86362001)(44832011)(6116002)(3846002)(106356001)(81156014)(36756003)(8936002)(476003)(2616005)(956004)(105586002)(6666003)(5660300001)(81166006)(7416002)(50226002)(66066001)(14444005)(110136005)(1857600001)(186003)(50466002)(54906003)(2906002)(51416003)(53416004)(97736004)(386003)(6506007)(53936002)(107886003)(52116002)(16526019)(48376002)(4326008)(16586007)(69596002)(26005)(316002)(478600001)(25786009)(47776003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR08MB2769;H:work.sw.ru;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR08MB2769;23:hrPN4Y1UC2pgL2AxTEXPQ/BCg/TXq4NUrN8n+/0sP?=
 =?us-ascii?Q?+uS1SX8YITHTMq5SqXkW+XHpWHZCJsFCcagCMNWx/CZNGyLdJSJLFOhqR4dp?=
 =?us-ascii?Q?0YDNndDHQTGejs3yTC77o9K+mHNU6iplSLTfk8OsX0l7L8zHFaatnXHky5cj?=
 =?us-ascii?Q?xwTl3xGSzzklPu7zkd1oYPYkNIHMQLnhuXZGgjrhobv5+lMYdyeiiPeHfViK?=
 =?us-ascii?Q?mOuF/nq+NJowO5JacGOPL13asyA4+FsZpvysbmHlARF2Zla0ajemOiLUjJVg?=
 =?us-ascii?Q?RMks8d1fiEAwSACRxiyCXVQSV0GnoAZu+lYqQDKkeVMBRn7Ylp2R8jl2bjEz?=
 =?us-ascii?Q?HJbc6SaUo9E0mY6Q+Drg24jGbH/E/thrjjI1d53cuB0yd59e+KhnQWit/yK0?=
 =?us-ascii?Q?Suh4/W4BPHONcksxdOzTj8s71Ta1XgWvCgvYr6gGFFPfY3EduMOzPOMJAq0e?=
 =?us-ascii?Q?AJux0PCIPOAP/dS7TFOJpQb+c3OI3cVIWmROh5rx08vxpayjdr8n2eb2Mv2I?=
 =?us-ascii?Q?IiKw7iAuZLWaXudj9kgpsLUAljqgXFCv4OEaFe2YdgMKVbuYGnVEzk9egSIH?=
 =?us-ascii?Q?6y68JHn/O4Rkk5WFEr80dqV6fXnuDp4Mjvhe0wsOoDbOJkvuMpczX1hbC4Rl?=
 =?us-ascii?Q?VMCXRIjiXSqHT4UmbPTjwZFzThyAB4Gto70+lu6qYrXSooGUXt+TNKgerfQM?=
 =?us-ascii?Q?MogQqR6TbNAxI9qBeTUCRXwIq6YpnJanq65/gTjAZFq0S8+EZyC1BKCiW4Kr?=
 =?us-ascii?Q?EBzDU7oyCJXsHv+HIzBP2JMAGiaNh2n97Il9yzunNZKT8HctYroGMyTIf2lJ?=
 =?us-ascii?Q?jEkzYOVotcO19PwerSOj0KO6xZg9Z0gYdIIQsP5WczpLcQLRGgldGq5b/GAl?=
 =?us-ascii?Q?wxiQ1k9S7mYOK8yaN0GoVQT5ZgVgKOVGCK4IPA1Iwnh59H7Q5C5C8C2+c8+9?=
 =?us-ascii?Q?2OxOKxIVjN66YM0p8WapN4J1A84SHarqJxEh8C6aly2PXqwXqutqJ/A0SSo8?=
 =?us-ascii?Q?h4lf0ThS9H6vcKe2SsprbUt90kIV0XMvZGNV/Myl0q6y+0EE5dzngVKWHtIL?=
 =?us-ascii?Q?ToAfnHTQscSE/vbqa4FKnHmmlGDQ21gJE/52cwL6K6lS0XHpKZrdH05ZsKpN?=
 =?us-ascii?Q?ckQfr3IMk0ALg0fvvcvSXynFmfv0v+F2H3rrV1ZsopXqUfKylp+iWR8ziLxf?=
 =?us-ascii?Q?MijhVVKa3DHIoedgrJcoY9PWd3AkyY/cs5FkRxsBug2nteC1auVmn9smu/HQ?=
 =?us-ascii?Q?0dadKg4g6+hb0qrEjy6iqaxF63vwL+8AceOToYvzRtOAlw7ylt5Jz73a8cJO?=
 =?us-ascii?Q?KU1iWigsKWT1Pelavq4ZS8=3D?=
X-Microsoft-Antispam-Message-Info: gqm3achqFfVxxxQ73V4ZFWD4s0k28PjqMISW9t1fc7aZps0AkKCONrTAHp4ooPA/T0YnNgf2ebgt3RJ6HCMJcsL0wTQ6pdqO2i7RQ6iNfBR6lleY/VoDkIKkQKjGru/Yblh/b0KGVzqtiKIASS9qgmtLySGS1MZyJypUvdXdD7VImcWoZxFf2uvmOMNFDaseMSFWuBbu0JPEjZzTz04F03TTXCtaY7PyQsCcbYVZnjo3wI7mgQBNsD5ekGtCnw91djcrL3oBhRz6f04BqumnxmsgUIiIHIJbAINgCEMsg734EWtY7cPZlFHgF50BrSxAEaH6gZCdjqXVt1M3hgnhBLiEY/SJYU7/BBjvS7ZDs78=
X-Microsoft-Exchange-Diagnostics: 1;AM4PR08MB2769;6:P20p+YmpF9VuneAnY/DJpdGTxUcAS1lh1nGV6YCOAfRmbUKG9/EU+S0nSGbvXNZfLaBfzJDyvT5HgqHqRDGeKOnGX6UCx4WBPEWTdkB2IBa5jt0HNl2a1DG4puyGWzf+zj1fhi09w3656fw3CtECXiQnULbB0AENb5rdt/ood4H0GmLR+6hbTuSf3avOR2/Pz3yhyf4oi6nIzMDCU6Bo+d0YHHZXdcOlGpYtiTHDicH6CIPopZmGfo56tIBpQP5pXM9Aq+J/vXf2CYe4Ra0IZwnKlrtVMlvD5T9oIjAYM8VzlbEkYjd6FuWthbKVasqFDE+2rXpAXu+EA3KuT8qA9JNn6YA8FB+2dW669NLv933NFuIrC/eqwevzjdO5KSQc9iklDWhLLXZLoIMwAGv9vnx1NM0JRV/bkIdgThK75wdjnXkd1+Jceh0pcs23Qn+nt9epFoLY/1VO4c4ZpQdvow==;5:wPtWhUuYFGYRWqScyCTFpb/shAYlf5EhT1onyy+HJK+bD6XoIyJRqLqsX2VGd4XHUalPGzVmpMNPRZwfK4mApQbZUI6SgPegQSXkdJjqQsHh0FTt7v5h661HLh/NZxkojJCM9NlKAQQU/rfSi1QaXnkbvHeBU3+S4oDx/ZF+jiY=;24:JIB7l3AjF9Hb2yzvCJVMIa9OUg86+kO2ZzeESgg4R4iitLUlu8kATquaozqWOZyxTKFDN4jmOacdiuHr6FtFDhxGoSEz9Zf64oWojO6g/o4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR08MB2769;7:EwFlL1ZPjZZNsAO53xAd0FKG3tm6y8nwD7BcFTrl0QiOOrA1gwG6I0wBaw3YpBFSxc95QPw3JyOcxDydWmcQ6CWVA4naQLEChUXOEyggE8uD6Zh4QuSNaoJQmevVvW1YnGYc/dk/hwmQPaDC9ek84vqJTKp/czC+KEInvVUTr0JJ+WPck/Pv/IMZtURGGGMv7HjgPFpp14O65tGXdQCaXcxXo+/gNlRN2Els+DfhVc7IXPowzpg73m2LEc6ESEiF;20:gyH7zpQwzLFPqeqFPd6022fwcYLNk58rLjubOOQGgkvyiKWA6EZmXB3+BwMhq+UsLUoG8OuUUJfV2nV4+SsV+HfrDysQ6LIonIIlaIE8bNDMptCBdSmGG740QUWV0XsBt7G3iC0/rqeLmDShzo6EWHmmwD2APuNVlFdWDCeg3VU=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 13:51:06.5379 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2080732-5ad5-44e7-073a-08d5e5a305a6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR08MB2769
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This table by default takes 32KiB which is 3rd memory order. Meanwhile,
this memory is not aimed for DMA operation and could be safely allocated
by vmalloc.

Signed-off-by: Jan Dakinevich <jan.dakinevich@virtuozzo.com>
---
 drivers/infiniband/ulp/ipoib/ipoib_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index 26cde95..cb752df 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -1526,7 +1526,7 @@ static int ipoib_neigh_hash_init(struct ipoib_dev_priv *priv)
 		return -ENOMEM;
 	set_bit(IPOIB_STOP_NEIGH_GC, &priv->flags);
 	size = roundup_pow_of_two(arp_tbl.gc_thresh3);
-	buckets = kcalloc(size, sizeof(*buckets), GFP_KERNEL);
+	buckets = kvcalloc(size, sizeof(*buckets), GFP_KERNEL);
 	if (!buckets) {
 		kfree(htbl);
 		return -ENOMEM;
@@ -1554,7 +1554,7 @@ static void neigh_hash_free_rcu(struct rcu_head *head)
 	struct ipoib_neigh __rcu **buckets = htbl->buckets;
 	struct ipoib_neigh_table *ntbl = htbl->ntbl;
 
-	kfree(buckets);
+	kvfree(buckets);
 	kfree(htbl);
 	complete(&ntbl->deleted);
 }
-- 
2.1.4

