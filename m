Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70416C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E860F20843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="eII3LlbG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E860F20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbeICS2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 14:28:01 -0400
Received: from mail-eopbgr720080.outbound.protection.outlook.com ([40.107.72.80]:29703
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726763AbeICS2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 14:28:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WyOO+12uLYYkO+RXhTd90PHhSCma1ZRe9tG1qblrsGU=;
 b=eII3LlbGpAGM+2Wo9q0XYOSTrmrwAq4SygnAzvKYidQGGpZaCTOk3Jqv8jTvw2y08SUtZqskqe7EZyp/Jvr0TctdNsZp9OEpfRkqU43hvgv/0GDKqIrmxQvV6WtEZwYvm2v1+JNmechBlio0+yd+zzI408MgcGCyYNbVthN+fBE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
Received: from fedoratest.localdomain (155.4.205.56) by
 SN6PR05MB4589.namprd05.prod.outlook.com (2603:10b6:805:38::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.10; Mon, 3 Sep 2018 14:07:37 +0000
From:   Thomas Hellstrom <thellstrom@vmware.com>
To:     peterz@infradead.org, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Thomas Hellstrom <thellstrom@vmware.com>
Subject: [PATCH] locking: Fix mutex debug call and ww_mutex doc
Date:   Mon,  3 Sep 2018 16:07:08 +0200
Message-Id: <20180903140708.2401-1-thellstrom@vmware.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [155.4.205.56]
X-ClientProxiedBy: CWXP265CA0093.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:39::33) To SN6PR05MB4589.namprd05.prod.outlook.com
 (2603:10b6:805:38::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e7e3b1b-a545-4224-bbe3-08d611a69b39
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN6PR05MB4589;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR05MB4589;3:QK0MSXQds5cFoOCXRS9Wp+TJdC5VfdbrfcPwqOvUFlIY8WzEuo3VBAQyfkC0kYtRFbCErBc6ytuxucpKzeqcHAdsnSStrk9DHwOQIpxzI1HMVgBD+2YOkxgSVQCfeXALBrN2VGIbmFh4t5KfdmwhSVYjgt51sz76Bl/9ixWywHPzWbfdQnNzMtOl4phbsgGacZ+xSgH4NAim53wqZ/E2AAK+RmKnOYZNxRqOThZufK7ZhS5bV2hKCewWEkkhNO2x;25:gQoS/qCPaDy2b9aLr1fhPNBCdizgRQsyhtAcDP3MYLmVnr4LTwO5VogWSrG+svnoMfV42P+RLbxR9JlPtK8e8pXI9sIKXVmaM4779IyvAybrKwE/O202SjB0Usx0zcKNp7KC2M1FHORZxrAz1B+zmwjzmeTKgEMznEajwwAwrmD7ZMnveIg5ZHy9TDkJlGZWh5U3bHN6MTEGyy5tZHoacfwa5md/b3EUl0XjD8krNZQLRLVf/0hTuu9Ks3Q96sf1Gd2+jxiOYUF5yohYnjcGbvbq2lVg3GwC7NXtoq4/jYdAdadC5OdA5lST6snNc+9xD20VE8tsgkNyGb98On5IGg==;31:7gJn+rioL0Bu9Ltnndpjq5ALuK57sRYUTJc4PhDxeF7uOd1vJl2i837QA3FYh70oJa81QAR0EcQGbn5HD9v2/9NhXKZx4irEj/5dpukRFcEV/py18ecwGPrK79lHUoF5olRyV78RCJJdv2d4wQEG+AImvn9fhlaGoKUFzMAwfpntCTlBK95QXDNP55NT091Ht7GJEvmQ69iytOq0IRxI+dAAQZ6tNO8DtzzBb+ySJTo=
X-MS-TrafficTypeDiagnostic: SN6PR05MB4589:
BCL:    0
X-Microsoft-Exchange-Diagnostics: 1;SN6PR05MB4589;20:tl3Pkkhc7AQfeAHNUSZiufW45Z38x0chO2iZfduF69JFygRuqWxUnhLNQpzgVsy4kS/6HH6prbtwtDQ37U2mTtKBlg3mJQsyVJtDYl7u8iSV2q6f2zvsStUX6jzzHpjxtIUOLEGO8TyyvEdduiEsg6LfzCE0VXS1gdMl1E52EoOphd9+9ZBcPSNhUjgEM+i9is0miPF4vAQ1nOKYSVT+8AldGy2X6t/2oBP8uRHhQlUaeXiP+5A3Hfogbqswf22CBfycD9IP+Ix4oebK+Cisas23+CFgPKv0tkz96AD9wqYgQGN3bLhGxdofMEou/4IzMVnyl7Qaij1TKNHwOCDicsQbZnPEblpUV9hS5yjmwKtsTUm6X+pousPY5cQaZv4qKxL4yf7iHPQzdhDpplU4Y1jAd9M+1gCtdfPUwBQxRe5wemFHlH6MagBYmUILdeSmyhsZB+0AAdD7PX/yxsMrKKdqUWBy/X8U/LrLMVVo0kAKk8iQR+om0NAob9R/EdRD9s7D4nZ4+uIHpJMDEj8MXsNxsRWAKQlqWvAF4xbpmzkNoMLx+uxgCl88tZeO89wJLypbLxDHEKSBRidJyj2GvIqdBS5E9/h17NTKIVP90os=;4:06eo+veKHc7KJv8lFCxsIeoLGx8xnjORx45LzbQJ/vhsbTZYCSKROT3hnMlhV64WSlseKqTgAb8PiB7LYrxSIFmx0wBwoHEscNrji1+rE8/h5H8qDMd1hmb/ApFsSO0kkvD+ZFzFqgATBq43UOOBbm10MFEoLvbBe9S1dKmiMexNsnIA600EwSzed7o0Ax7wyDqiSpHnm5UwfXS5wsq7Ha30Qa9sCseHg7RYFZmQu3g0NQRi+VlexcOzlxT2+TuU+YVEioV+FKIDeNtkYkbHdJrXihsuq42cbOa4fJLy7hZs8CkTFwbAKzyk737NXxl3
X-Microsoft-Antispam-PRVS: <SN6PR05MB4589BDF6A5C293A4FC53BF80A10C0@SN6PR05MB4589.namprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(61668805478150);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(10201501046)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699016);SRVR:SN6PR05MB4589;BCL:0;PCL:0;RULEID:;SRVR:SN6PR05MB4589;
X-Forefront-PRVS: 0784C803FD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(376002)(346002)(366004)(199004)(189003)(107886003)(48376002)(50466002)(186003)(16526019)(6506007)(386003)(6486002)(26005)(106356001)(36756003)(68736007)(105586002)(8676002)(14444005)(4326008)(81166006)(25786009)(81156014)(478600001)(2616005)(476003)(6666003)(47776003)(3846002)(956004)(6116002)(97736004)(52116002)(7736002)(86362001)(486006)(51416003)(8936002)(6512007)(1857600001)(53936002)(305945005)(316002)(1076002)(66066001)(16586007)(5660300001)(50226002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR05MB4589;H:fedoratest.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR05MB4589;23:KoB/z3NnQG4eAovO7kL4oHnf2I/7t3CIEH3q30seA?=
 =?us-ascii?Q?XdxKvwjZu9IiH6XY5A5pp3DMYTAs6pAhxP7M1TKETItQ6t9y1kCh6aOmt7BE?=
 =?us-ascii?Q?i/fkuNFVxW4qa2U1NcjkzAoZCCUcByZccm5GqeEQ4+0S/sly3S8K3zq5+Fev?=
 =?us-ascii?Q?ghsE4wUOfQMTDuQQx81J5i2QyhnTbpdwdegzPvyBfiDOGjo3mvPQlnoSFM8A?=
 =?us-ascii?Q?jxEsb8vOxN0YgHwjHVWcjgFQP2lyzpIPBaxMu6MQLPCLdIMMnY+FRqPb6CD9?=
 =?us-ascii?Q?HCinSX6zO5FXYjMpKV8A2gRWoLca4D7RpPqDk2ujy/Y99w0BBroPhJAZpzdv?=
 =?us-ascii?Q?W/SKs4LvvWP/2YodbGSJ7faQFtSyd9ttH7aXCKddsWO5Ex/tJ++/yna0iJJ2?=
 =?us-ascii?Q?PKO/i4rRqv2QHlswJTM95HKM+nhd1829bWE4OzfoT+kERXHch8/WkEVtSLBi?=
 =?us-ascii?Q?uckZTRIjwwfvYxNtDx8y3FUjWIsq2eqnjNNm+NEZLAfbp07iGIFBMVtc0WA7?=
 =?us-ascii?Q?wxz/pDSUJPzCyHPG+IkCF5lmaQ1ysxbxZGPCwrcXuhhwmOtXjdf/JH8kehp9?=
 =?us-ascii?Q?GAQcHL8WTEJDHgemWKR1/CRzDPu67IXnVTdNNYBxKf6YeCI3sxxurWc/cgK1?=
 =?us-ascii?Q?G+v/n7d5uRbPNxUwb/RjGvtFX1RzJIfV1bGmoHnEo0xuVMh2vn2NKMM+qj+O?=
 =?us-ascii?Q?ZH1L4FBKNt8hJf7Pj4btA5HHCM8tMlmE0F9eF6DSvNxVNdcwM/4y5ZggpuYA?=
 =?us-ascii?Q?mc9WTl/LZHuUnqOWGKRnkfxZyTV+CydEht670llKlU9IicLKpMOGwrPth8QR?=
 =?us-ascii?Q?FgmLw6PbveCleDH1LqAvwhofqj3azWoHxyd7Z3n5um3ZT3LAz34FHZ+LPtts?=
 =?us-ascii?Q?JyQJBMDrJnrh4lp+dgm58Ba0PEk16nJWan81rXo6irZCBgGbD+FB2H/2s4ZU?=
 =?us-ascii?Q?TKuu5owqQQpi6rcnvyj+TigKCdJBHJI7H5kDdBHl1qX6C/hfqavzJWSlzyOv?=
 =?us-ascii?Q?8ae66NDnctVAxvZwy5IWn+Z06aCp8XSLgVmK/ux7i55Gmylb/X7FKWjDsjMV?=
 =?us-ascii?Q?x7Z1W5HpKrW2fZ2westIykFdp14QV2e9G1i4eZ5XU6ieWGQyUOGysQ1bym0t?=
 =?us-ascii?Q?7VNJDErJmjLeEhUfsxkaVaoPAjSWg/T4S1vbWDJajXNV83crXTWwuvWqThlE?=
 =?us-ascii?Q?Od8npg+xGD3izE=3D?=
X-Microsoft-Antispam-Message-Info: ANQ6QKtumx9lg2T77w+th7+fN+RPUzZMkeiM+b7xV8GcHYdCfgOwPi9q3UOxrxGH0jSWU4WhoEBLSWNsgk/nEiPDkLQyjGUfd29IPvOfsIkJ+sKSrabahkWn2EfAy1DUvIXt49W6Mw0GBk3sMPr3eMoaK1rilgTpN+BdcCiOquAqi80vUCh06QUf/tjxktFonglj5K4bABU6gCZ+hJocI9shECtpvSwkOWV9RKjv9yyVuch35ZiCf2W/52HmeaHEWTOqckPkwAfmb1sbHTPaUFG61cybQHS/Q1O8rhlzld2SbBXX+JtAAENq24Io7AzTPTGmBFY0nJQ2jIOAsftYgXLacW6wLcPNDzIgNixDl7A=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR05MB4589;6:lc42bO+7T5CBIQ2uatXoMuPBiXPYoiKWwV61l/+pAStQi8og/cAspihPjMc9cWYZt8y5p8VdBo20Uocb6Jbixn+QaRc6rWkgi/oW8MKp8RwDBoB2trhdmOi4zg/6QY5wi9reZWHm2QyI3noj0888ZOrxSuIDYXa/Mp3oZVgOMLzbhAwfQ0m+TeAl7pkdGAYED+0YURsy5StUPW1+jOLgmls4IHeJuHOsPs1tJOAlAa6Kytana8OwEWYe5vGY2KcevLqSDH9GYd6utrxvglw3GsPEMLYfm3wAxyWRmjLNAAzsNl8Daw3jZfNpXUokVec1f6EOGcfjGHW1h0F7CeEIfG4m8R4Okacjwr7iB/yjHePXs6hupJjAYwpHDqYgn64REwP69NDENLlZHz/zHutqmgt3LEGdG0njMcChz1K1prn4uiWDYXkjTYhYx6EjEm6CuVTAk4cVwsPCeBTgJBa0Tw==;5:jgzXnYV76B65WlbJHNHdZh3dbz46Ts+/jWxUUCR8q8kC9kEWIFeON+IKMVBOAg2uQcEPaaGz3eHv+PrxOMmaWGsHz/cNmGxArMihNkdkea0S2kYyAg52WIsehNhajP3t0WzMHPXFQZbEN8Q01vUOnvGkuszZcieWIWxDPoyIGNM=;7:5ZsLHZ0xb79hkE6yyHGrOHX/kFt1npNSZAavFtE4MKIe/N4+SumKVmvRUDUK0WFGpadnvmyn16Fwm0gv0wKc2zhpti3n0FDTwnn4YczKubuY+H9zq888GhaLitTRjgts+csZOxi2O9UNfBPzgw14OvFqjF0DKsO34+c74WN45po6TD10zGEoOCeT29gbD3G+gEzg4KTXosfBjCRME6JYmy0bXt6Spp6PNRIE0STJyZVRpH6L86oTIKDYpok7WQAU
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR05MB4589;20:gcS2PaMc7TWhJxjoXRb0Aq3cUkq5Ivg9lIB0OJlzSEgFShbGwHCOHXzlX/pNvjGJ0C++AuaRQxg/ijd1Tu5cLutlXZJAgnwR+xdvdbI3gNv2GKvZJblLOsYJwYu1ZALidj12KLhRv3YGXbCOBjEoNzU4VB6D7MKovN9GTBkvOmI=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2018 14:07:37.7483
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e7e3b1b-a545-4224-bbe3-08d611a69b39
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR05MB4589
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 08295b3b5bee ("Implement an algorithm choice for Wound-Wait
mutexes") introduced a reference in the documentation to a function
that was removed in an earlier commit.

It also forgot to remove a call to debug_mutex_add_waiter() which is now
unconditionally called by __mutex_add_waiter().

Fix those issues.

Fixes: 08295b3b5bee ("Implement an algorithm choice for Wound-Wait mutexes")
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
---
 kernel/locking/mutex.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 1a81a1257b3f..3f8a35104285 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -389,7 +389,7 @@ static bool __ww_mutex_wound(struct mutex *lock,
 		/*
 		 * wake_up_process() paired with set_current_state()
 		 * inserts sufficient barriers to make sure @owner either sees
-		 * it's wounded in __ww_mutex_lock_check_stamp() or has a
+		 * it's wounded in __ww_mutex_check_kill() or has a
 		 * wakeup pending to re-read the wounded state.
 		 */
 		if (owner != current)
@@ -946,7 +946,6 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 	}
 
 	debug_mutex_lock_common(lock, &waiter);
-	debug_mutex_add_waiter(lock, &waiter, current);
 
 	lock_contended(&lock->dep_map, ip);
 
-- 
2.18.0.rc1

