Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB2BC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4347020852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=epam.com header.i=@epam.com header.b="HSnl8c0H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4347020852
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=epam.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934536AbeFRLL1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 07:11:27 -0400
Received: from mail-db5eur01on0066.outbound.protection.outlook.com ([104.47.2.66]:35920
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932762AbeFRLLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 07:11:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItyXu4DVukYCKWXJBMJ19eplHmHN8s5j4lxK6D0ZdHs=;
 b=HSnl8c0HVKYj41+Nr/ercZ3rYODvkToVErmcjA15ZHQqb2c2/+gY7Ud/UMZslpZPx5YC1o5XOsf4lwq3slyZGQR9LEkfHAm8v9yR6B/o4GtDsDZaYLf2SUzREkMEGxCfFcA22KC5piTh9q6/Kiy6Y8chXWxzJY/LxBKnfkOiAWE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Volodymyr_Babchuk@epam.com; 
Received: from EPUAKYIW2556.kyiv.epam.com (85.223.209.59) by
 AM0PR03MB3761.eurprd03.prod.outlook.com (2603:10a6:208:45::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.17; Mon, 18 Jun 2018 11:11:20 +0000
Received: by EPUAKYIW2556.kyiv.epam.com (sSMTP sendmail emulation); Mon, 18 Jun 2018 14:11:16 +0300
From:   Volodymyr Babchuk <volodymyr_babchuk@epam.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org
Cc:     Volodymyr Babchuk <vlad.babchuk@gmail.com>
Subject: [PATCH] optee: allow to work without static shared memory
Date:   Mon, 18 Jun 2018 14:11:15 +0300
Message-Id: <1529320275-30079-1-git-send-email-volodymyr_babchuk@epam.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.223.209.59]
X-ClientProxiedBy: AM6PR0402CA0001.eurprd04.prod.outlook.com
 (2603:10a6:209::14) To AM0PR03MB3761.eurprd03.prod.outlook.com
 (2603:10a6:208:45::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57b62cc4-4234-44a5-f842-08d5d50c38a6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:AM0PR03MB3761;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR03MB3761;3:1TzKm5rRFl4cVMtHQtWnl0F3GJGAmsYehJ+LNa3WaqEpBFGaLZiJd61QqCq54ps6rc/cDf8fO0JDe7Rmm4tdysQG+iIk4QYj4hnFwUD/JDnkGfExK/hcYgo7R9qgFgDV0CKlj0yuN6L6WSN77nPujVjJ9FoNjV2EduGrIONBGLfimu3MSsUxQsbtkxpn4YuqRrWLzUeyYksXk+u3+wKYpndNh3Fm9DaQObg11C1oQjx43dogWJ9KUGpP/9WHF9iO;25:z4M3o0bVQPMkJJmJrT+1YF32JPoPzz3VB7dJJ86/XHZoMEfJUDoeKvb/iY9mW02TM0KWyijfwPxiqm4Szf+z/nDNE9SI7AWKulTYuPG9hVI4NZAUS7S4OOy9LdRhCCOzWu5sMeD+SNhCCSwP295aKTnu7Wc+FWiYlVHxb53dL0m2AoDB0IQl5i/tdyfyliPs0YJKEOJOOP8jd4+361yHwzDbLjstOKnY2iK9yc6Vwd1NURVnwDlVguPWiulLK1cGA30XglrNEuIDTh8SEC/MpNpshSjiOadlsfdYYW9TgBHepLMEw3Mj+neeTZGq20iFoSg16CF3NGpCJ3WltRmIog==;31:NDaJ04ryVYzzChKYD4zPh6wHhMlNJoO1Bwm1Pg84wlqx2aC+FMlxGK/6VHQ6w9OZKwofHlOVflYGcWmXznafxoLwRFgSLrxAG1qv//u7TpxB5OTNgdKNItC0mAWNfOlV2jhhCdOQqH8j0D2Km9xahJ/ggMuVa8MVT1/oiMxa37FHasWIefkWC/UUOHqHb2NoVSIZRBDRpdjeAk/oti/ysMC6B32br60KiOGObSLWMRI=
X-MS-TrafficTypeDiagnostic: AM0PR03MB3761:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR03MB3761;20:DeV5ylqafkYRQ8N7s9KObRbYtv8Fzq/F280eXaks8PEYs5SQ12JuayGf2NTXisGKu1YEtIvVUQ3w/dlu7OiI+kAg63OL1iYqevNSo+bh9ivw2FAaveBdPCfuKwQzeflvmQ8VJsKUztcBqSvz8T2a2xKswtR3BaRxkLvhNho3v4OXSEwF5A8OjZN9qQQUalUOQ1nmZ5wwk3cBp36ykqjTWQTeW3+m4nc0PhZUtW2AGTxlpU3Oa499mUQ0K5C5AC4qcVfNXoRQBbTAtIpVOwSBZtbXEL50j9fx31uDH8Kubg9iH5K7/SgqcBygJhK2eL+Lc6+or6n564m/CKjjtoh8WdZf7iAV2Ps/Ev47nMGMIann75h/RDC3QnaVa13yAPTj8h9SrCKbmoxQzRFR4xcAUDMbWynhJaTb9aYMHuveOsaLzwiOD/1Ymk2mPqnOjm87LC08XQiT40ao0IKusT5vgzfpOz+T/EDQiGlCgJQg4A65QsEoHtaROQhIEY1wVS32;4:eosNuPTGCwivzQSTf6kMZDcOQkzGi7U//tByhmjrIu2TIyY8g3j2Rkvxe8fjG3fCsp4YAvVm+oRU5slvw0tiv2g9v/oRPvg1ERegRqXFnDvcrrVNIOio5Bpcb93uQReC+Qn59T3YJbgYV6VEIR4eICtsIUaelSqNsmEsyr/OJ/ewKj4LFhRUgjP3BGyvtwwlU9f82tKhs4SD2B+ImNU44Lt7iNyaXpBxVphWvfXqTpCe3JKOgzD6D+0so+0JwIkkAeOLaB3Xs0lrRw1po0BMVxvVe4wOS2EpveXFQ5YJmXmXyH6fd7p6d20v0MQKxrex
X-Microsoft-Antispam-PRVS: <AM0PR03MB3761DB37442A7F3DB9298A89E6710@AM0PR03MB3761.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM0PR03MB3761;BCL:0;PCL:0;RULEID:;SRVR:AM0PR03MB3761;
X-Forefront-PRVS: 0707248B64
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(366004)(396003)(376002)(346002)(189003)(199004)(50466002)(478600001)(305945005)(4326008)(72206003)(7736002)(66066001)(39060400002)(53936002)(81156014)(81166006)(8936002)(8676002)(48376002)(47776003)(86362001)(1857600001)(50226002)(97736004)(26005)(16586007)(36756003)(51416003)(80792005)(52116002)(386003)(106356001)(186003)(42186006)(316002)(68736007)(55236004)(476003)(105586002)(6116002)(2616005)(5660300001)(2906002)(426003)(3846002)(122856001)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR03MB3761;H:EPUAKYIW2556.kyiv.epam.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: epam.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR03MB3761;23:CnRD85jOcAxZ4dGJjHAlZs4go2PSVDtOvzhRr1LvI?=
 =?us-ascii?Q?CAVxnvK9fVRIxs0Y37C/UOT70tUXQhJO2UryVebqMnBN3Z7fZEW2poKIzi2E?=
 =?us-ascii?Q?fKV/4CC4yZuOkWpFsTZKnBvckul6YWYCpSEcEcw+TWbGw3XL8/IpVHAfefDH?=
 =?us-ascii?Q?dZnGjSMdPXgJzSaMvGQHXoBPWWgWveKYKkkV/L1ntgiHED7LsqONcrOPi4Ne?=
 =?us-ascii?Q?2TnvcUueJriOfr+ExuHhQqwjsIpXRBKHMlP5Pn0QrxLPi0rZVtaZv88GkREv?=
 =?us-ascii?Q?YHn8fmPHcMBi/8ppFez4PSISe8CSl+WW6ZD06oWsoE1seu1q1ufiZKhs+INI?=
 =?us-ascii?Q?ydtjyQs5BulFp2qmZ63nf5hvGETvDCrO9N/3IHSWjvC6hPnU5GryEt9FeKSB?=
 =?us-ascii?Q?B10FkevEj2ZMF8jyl7syB482K1GyM1g20LUYbk9ZElnZfHREJI7swIvGCQFc?=
 =?us-ascii?Q?R+C2VHLL1XDlIe4Kq7RFWtJt9t0IcDwGq8Orepcl64lMmSdHaamKrUKd4fSK?=
 =?us-ascii?Q?9ptPNQw6WLWja0xjZ2RkGqBcdhWuE0/Z8MRJDt/VW9VjJ1b+LqatyYAWl76/?=
 =?us-ascii?Q?na+YcUgQ4I5lYPM39A+83Po7Rf1fCfZwS8n9d5+NY97br0NbzE/dkJaWowHo?=
 =?us-ascii?Q?E8NP9+mslV+StmNO6X702Ay+9O/FkXzo1NlG/6xQaaJ4IYHbquB+JVIrv8Ic?=
 =?us-ascii?Q?WANkDIBxGodjV2ktuZvtbbbKAl5NoS+QBa7FYQpTGlxMv+TA4nkDI2HrOuxn?=
 =?us-ascii?Q?68mmeEdZacHM9sT6KR7uVh1Xd9O3QEZ9mbcfu47EJU480GuH74UG2CxkK9z9?=
 =?us-ascii?Q?K5lpNt0L8MldKQZG9MGwo+nPZPtdnjwS3UClaXlK2uSJkIQzU8ptoM3joFpP?=
 =?us-ascii?Q?UjBLgbW/vZr4QGewJaNw2x2JynOkbXW6VfHPTmS7QLWuYDT1Z08SrW6jC0nP?=
 =?us-ascii?Q?2esEhdoEyuwA9LFGGsR+b+rZv4+EBgnc3HtrEW5UErVkdMwklbI+bUER05ev?=
 =?us-ascii?Q?HAkv/2zOCDm/AexRITIRRrfdHOCbxPzi7zcSnw2o3e2Y5fz2WeEVPhov04+H?=
 =?us-ascii?Q?yx7ioTZXp5p+pMAFiYaHlDDeUhC6l1H17bRUlTdYP28fKHn6hBdyNTmAYfEu?=
 =?us-ascii?Q?/nAdc9jIg79URvR/E9WQyqFMy2XfxkK?=
X-Microsoft-Antispam-Message-Info: GQ/PP1KgOC/ixtH/iV6sVfSmn6zvrsN2HSohycKLyA8AI2Itr04Hb67yfe6TyGFwp137mS3U2PVagAJNT6j3aMSmICRlpyMMxEvdTCtuaSBnzS3m2FyXIcGwh1sp5QE70kJYSTh8PwBRPw2Ah9FerajDrn0JwJr1EtPY1Jdp42KmaYb+E2pqzpKzyskfNxXlbQjyq0Hsq49I9HwAZ7kPNRootrFnCD+n54Qii/3UR1XBXHpIfRyQGnsl3tm0Zi/nHwyNL6JDROFlotJeQy+3wlpJNop19FECLu5X00tYnOXMmo0Y0Yih9M3X8VOBXO4mFex1b6TcOSC4OFHnsUADYA==
X-Microsoft-Exchange-Diagnostics: 1;AM0PR03MB3761;6:zf8idXtT8EXww4ofCx2jEuivO97E6GUt/IkUUE9AFMqiWHcCg5hzcg1UE+Hw6iJRMjQS1Kcay3mbdlT1+k1XDDKg9JvN+NCCE6UF9o1Qb8a37ed1/v8LYoaZ6YyOu1TlHIaFZS867ZYmFowKK5qjzDyBIDufAidVL5kOrw1ApQePyQ8JihX0Pycpxnsc/rl+EtUnTwNkP82bu7TcwDRC8wMujW6hZSB2ZwkE2INhLiuwcfTxFeCvdTwJB6i9bj0Xiw+WvHd2mqQSa8RA5gP7mRqpW80ibkqhlKIsB/dSGY1fxnBVB6sCmbrFBtkNmHFvaKPo1f6w4qFspGmF1JMQDzYB0g/uz6KyGrUXe93CViNNFRs+aq4EbDX56mPJjS3Dss90+M6sjVgo4mhM46W0J86TMIVEUpn3yvmSxgODeuXP52IK1ybLpNKnER6/vgT7mJx6VzqgZ0cnhRyzAsFeiQ==;5:j9rpbJg0PWdQTEoJqgmZ0x9DJMABxiMQz9vmGjHqWbUZwvdOvHKzFGcy7IcynNvz+CSGhw90wbDQ/B+eTu757x00KBAyCDS/p9MM1Wrjo6+ONaCAYFhSgZPFKx7sasEt73BJh5emIc9ufjhFabH1vgWLaMky1VJGxGgs+sQKXJs=;24:rpINkL/Sq89yoWZbN30DFFHaMzoPJT2rBVyLMW4tjzjUv5Zm7DBHaGjozVeDSZG15DiYm7erE2PtQYGnq+F8/7E/jvknBuZuFKXARG1vssY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR03MB3761;7:vOq6IHGShipbJdOyw1gOMN5cpJV/jWjiP+rh4Qld3PyS4FJ3MsTETMVDDit8mIc/x6sm0EKaZ4SeJFpugGGHe5gZA+X0fmKEsH0htDWWLv2JMn/GAP8NlYUUhC026y/aoI5JoAaIfON89M23TMsa5ZF+JPw8lC/EXdrqN0inEy1mDPAIxsbKyhy5+cX5lzQsh029kJQHFoICbKEkMcYoX8xRludIdFTsA6V9JgK7vi0kVS1UMDXPPYtQaOahAdrS
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2018 11:11:20.6561 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b62cc4-4234-44a5-f842-08d5d50c38a6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB3761
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Volodymyr Babchuk <vlad.babchuk@gmail.com>

On virtualized systems it is possible that OP-TEE will provide
only dynamic shared memory support. So it is fine to boot
without static SHM enabled if dymanic one is supported.

Signed-off-by: Volodymyr Babchuk <vlad.babchuk@gmail.com>
---
 drivers/tee/optee/core.c | 83 ++++++++++++++++++++++++++++--------------------
 1 file changed, 49 insertions(+), 34 deletions(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 4a2c420..d80da29 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -420,9 +420,35 @@ static bool optee_msg_exchange_capabilities(optee_invoke_fn *invoke_fn,
 	return true;
 }
 
+static struct tee_shm_pool *optee_config_dyn_shm(void)
+{
+	struct tee_shm_pool_mgr *priv_mgr;
+	struct tee_shm_pool_mgr *dmabuf_mgr;
+	void *rc;
+
+	rc = optee_shm_pool_alloc_pages();
+	if (IS_ERR(rc))
+		return rc;
+	priv_mgr = rc;
+
+	rc = optee_shm_pool_alloc_pages();
+	if (IS_ERR(rc)) {
+		tee_shm_pool_mgr_destroy(priv_mgr);
+		return rc;
+	}
+	dmabuf_mgr = rc;
+
+	rc = tee_shm_pool_alloc(priv_mgr, dmabuf_mgr);
+	if (IS_ERR(rc)) {
+		tee_shm_pool_mgr_destroy(priv_mgr);
+		tee_shm_pool_mgr_destroy(dmabuf_mgr);
+	}
+
+	return rc;
+}
+
 static struct tee_shm_pool *
-optee_config_shm_memremap(optee_invoke_fn *invoke_fn, void **memremaped_shm,
-			  u32 sec_caps)
+optee_config_shm_memremap(optee_invoke_fn *invoke_fn, void **memremaped_shm)
 {
 	union {
 		struct arm_smccc_res smccc;
@@ -437,10 +463,11 @@ optee_config_shm_memremap(optee_invoke_fn *invoke_fn, void **memremaped_shm,
 	struct tee_shm_pool_mgr *priv_mgr;
 	struct tee_shm_pool_mgr *dmabuf_mgr;
 	void *rc;
+	const int sz = OPTEE_SHM_NUM_PRIV_PAGES * PAGE_SIZE;
 
 	invoke_fn(OPTEE_SMC_GET_SHM_CONFIG, 0, 0, 0, 0, 0, 0, 0, &res.smccc);
 	if (res.result.status != OPTEE_SMC_RETURN_OK) {
-		pr_info("shm service not available\n");
+		pr_err("static shm service not available\n");
 		return ERR_PTR(-ENOENT);
 	}
 
@@ -466,28 +493,15 @@ optee_config_shm_memremap(optee_invoke_fn *invoke_fn, void **memremaped_shm,
 	}
 	vaddr = (unsigned long)va;
 
-	/*
-	 * If OP-TEE can work with unregistered SHM, we will use own pool
-	 * for private shm
-	 */
-	if (sec_caps & OPTEE_SMC_SEC_CAP_DYNAMIC_SHM) {
-		rc = optee_shm_pool_alloc_pages();
-		if (IS_ERR(rc))
-			goto err_memunmap;
-		priv_mgr = rc;
-	} else {
-		const size_t sz = OPTEE_SHM_NUM_PRIV_PAGES * PAGE_SIZE;
-
-		rc = tee_shm_pool_mgr_alloc_res_mem(vaddr, paddr, sz,
-						    3 /* 8 bytes aligned */);
-		if (IS_ERR(rc))
-			goto err_memunmap;
-		priv_mgr = rc;
-
-		vaddr += sz;
-		paddr += sz;
-		size -= sz;
-	}
+	rc = tee_shm_pool_mgr_alloc_res_mem(vaddr, paddr, sz,
+					    3 /* 8 bytes aligned */);
+	if (IS_ERR(rc))
+		goto err_memunmap;
+	priv_mgr = rc;
+
+	vaddr += sz;
+	paddr += sz;
+	size -= sz;
 
 	rc = tee_shm_pool_mgr_alloc_res_mem(vaddr, paddr, size, PAGE_SHIFT);
 	if (IS_ERR(rc))
@@ -553,7 +567,7 @@ static optee_invoke_fn *get_invoke_func(struct device_node *np)
 static struct optee *optee_probe(struct device_node *np)
 {
 	optee_invoke_fn *invoke_fn;
-	struct tee_shm_pool *pool;
+	struct tee_shm_pool *pool = ERR_PTR(-EINVAL);
 	struct optee *optee = NULL;
 	void *memremaped_shm = NULL;
 	struct tee_device *teedev;
@@ -582,13 +596,17 @@ static struct optee *optee_probe(struct device_node *np)
 	}
 
 	/*
-	 * We have no other option for shared memory, if secure world
-	 * doesn't have any reserved memory we can use we can't continue.
+	 * Try to use dynamic shared memory if possible
 	 */
-	if (!(sec_caps & OPTEE_SMC_SEC_CAP_HAVE_RESERVED_SHM))
-		return ERR_PTR(-EINVAL);
+	if (sec_caps & OPTEE_SMC_SEC_CAP_DYNAMIC_SHM)
+		pool = optee_config_dyn_shm();
+
+	/*
+	 * If dynamic shared memory is not available or failed - try static one
+	 */
+	if (IS_ERR(pool) && (sec_caps & OPTEE_SMC_SEC_CAP_HAVE_RESERVED_SHM))
+		pool = optee_config_shm_memremap(invoke_fn, &memremaped_shm);
 
-	pool = optee_config_shm_memremap(invoke_fn, &memremaped_shm, sec_caps);
 	if (IS_ERR(pool))
 		return (void *)pool;
 
@@ -632,9 +650,6 @@ static struct optee *optee_probe(struct device_node *np)
 
 	optee_enable_shm_cache(optee);
 
-	if (optee->sec_caps & OPTEE_SMC_SEC_CAP_DYNAMIC_SHM)
-		pr_info("dynamic shared memory is enabled\n");
-
 	pr_info("initialized driver\n");
 	return optee;
 err:
-- 
2.7.4

