Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BEEC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11A98219E5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="Lomc/H6E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11A98219E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ni.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbeHFL0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:26:18 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:47248 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728787AbeHFL0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:26:18 -0400
Received: from pps.filterd (m0098780.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w769BDT1013912;
        Mon, 6 Aug 2018 04:17:50 -0500
Authentication-Results: ppops.net;
        dkim=pass header.d=nio365.onmicrosoft.com header.s=selector1-ni-com
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp0022.outbound.protection.outlook.com [216.32.180.22])
        by mx0a-00010702.pphosted.com with ESMTP id 2kn9nruyu4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 06 Aug 2018 04:17:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector1-ni-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwNWgyceaomRCS7vb9vv5zzJQp5DO/TXvTDJKzr7npg=;
 b=Lomc/H6EN+pbhVwFjnNVhJ3jJbs5CJ60qPMFR6ihZogwMNGb9pwaRxQ/m8nwqyqQ0yczaOtqXKS5GT6Fh2cTdlIKyeuprvGwPo8BU+/tXleMdoB/8Q3iJvxb7yPygm4Ae9qKxoT3eR1mmzj5CltnvIjHZOPybENv3Xetu1eRcmA=
Received: from jcartwri.amer.corp.natinst.com (130.164.62.116) by
 BN6PR04MB0965.namprd04.prod.outlook.com (2603:10b6:405:43::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.14; Mon, 6 Aug 2018 09:17:46 +0000
Received: by jcartwri.amer.corp.natinst.com (Postfix, from userid 1000)
        id F3CF8302F5D; Mon,  6 Aug 2018 04:17:38 -0500 (CDT)
From:   Julia Cartwright <julia@ni.com>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, stable-rt@vger.kernel.org
Subject: [PATCH RT 11/22] mm/slub: close possible memory-leak in kmem_cache_alloc_bulk()
Date:   Mon,  6 Aug 2018 04:17:27 -0500
Message-Id: <e01b9184383bd4cece79f22bcb500f2a2918e3aa.1533540554.git.julia@ni.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1533540554.git.julia@ni.com>
References: <cover.1533540554.git.julia@ni.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [130.164.62.116]
X-ClientProxiedBy: MWHPR19CA0012.namprd19.prod.outlook.com
 (2603:10b6:300:d4::22) To BN6PR04MB0965.namprd04.prod.outlook.com
 (2603:10b6:405:43::37)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 567d7c88-efe0-4f96-7b93-08d5fb7d7976
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR04MB0965;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR04MB0965;3:fzHPnLN2MDdxjsImGHY1EEzaOzzcOsawXNP5TYG7qCviWU+QJwOgDFSpN4vPEpZhui0AWzIhIrHuufFMkHcM2DfiILqzARUNmlcgR0quqoRfyLuvsXrjTuahnQXf7dYHhgcml1G+36o5MuEhkBOt0MCHDJieQXFjzuvjVQhty24Wx97SEj9zT6XJYqKv0Or/+ju0CjgGSKTN8n/sZf7Cqjar/2pqS5MWH2xencqKZbctovABeZe4PGAYe8OsxEbd;25:G1Sb8JliWtiBBnccryiWg699sea7Ohbhc9KEaa3qb2WimGCbq+qSzLF/3nF8iI/AKD8Xq42JKKcIzT1rhp5aaqnRK4NosbqMZsHa2z4Jl4Fj8zUPlADIydJPTxu88Mv7H2ayPS7l0kKiXEv6NZnv2aAKR4dSVg3NBC/4Kmr3szyg0L8qu7dPHcez4CCRgu9MqikG8nGNOKe3kmrO+fuDOQZYFBRi8cr1g8Kx+QSwggw2415QWCFMEpoDqoXAwcKFcgFrHz0aaKCIPmAEISg+BhJzPd7QUeA/JOUeH5lmuhrkqQ+dt9eT8T0r5gc5FxoLqRHP4W+rz8wto06epiSuxg==;31:3R+3iEKVpBB4lGqkAi70ArBYAjxdAEsB+TpHtZUdG6X/FzLYJFwF5D73DIunNoBhBkhaW46rPJ9OdfteDgzE6wQF3pb0LqU1cMqibbr3mCOFLt0tZ/KqRADRZu9VnenAAh05zyTJNK3ia7dXrAQav2N1Wbf8WTnb4BdWnlEEccrqG2+AN5yVH6Bsx6bPrfq+51+q4B4ICRailXGBCSURhoIOEVMPkCffmG3U5RYmzqg=
X-MS-TrafficTypeDiagnostic: BN6PR04MB0965:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR04MB0965;20:Fe5FrLOTpmCInYpclsQ04z6UhaE8ws05oYYHm3p43Iz+gJP7i5p8HZi/mqfVFMC+yB2Crg5TvVtbfF3Oof7MsWc6XUAvgt6jDjwQdwSfFLBBUIkWNVgS8BD0xKF0yvJJ7ryJW93X7YdIQ8tCeCnM4sAMG5v39QdY1Jlt5GNQaPnXCmiov3AiIjReigygLOFdxmsruiBkTk468HfEOQpxja2RHNqxzXblhgQ1BjoNLtT/3gRCL8JaLbsKH5BSxJvqDNBnLx0YZQfEcC3JqPcWs6rXNSmf7xuqhJKDxUMHVlRwjmKwKy6B7r/HBuFgcDodlRqm74BfFokMfH1AdI+hGjNgg3Rv/NR7TRBjvxZ3ABYR5xcHxQfU7Gvg47Xp9A4vrBE1HvisomiTSmMMazdRRypzmKm/Bhomoo1QjmxF3fzFvAnUdGIXSfJKPLpZZbRNJmLx1Q2exnpd10xMxGvDNaxA6wxjqRlXpQlactH27APH/hz+CHMoUQKagvUREDx5eFf2+lhMoMOwAWo4vjJuHj7g/Z0Iq6/0sEFk7U8/Up5+2ZcbUuNHaGEy765Jnceds6oPiuW6nO0H+Ujr+JQ5kKz1x6I+W7xgaiaiHy77aTE=
X-Microsoft-Antispam-PRVS: <BN6PR04MB0965444BE064C5CDF631C9DBF4200@BN6PR04MB0965.namprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(131327999870524)(145744241990776);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BN6PR04MB0965;BCL:0;PCL:0;RULEID:;SRVR:BN6PR04MB0965;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR04MB0965;4:cbCK0BurXSwjLnhzjxtGt/BuPGCdLp5gtChzgen053LD+EVrrnc97G9+tDuH6LQIk8F7cdVxDf62LvFWxe9Cl58O6gFdaTIYp5A0oJlkvFTw144g94eSQzOwME7eP5kaEkh08KelaKvwfoIOceYQ0UNOHsD0cAnk9IWGC3j9SLJOuEQIj7VAEgCqI6LkCBu/aPf1asEjMINxpALrWQ/425bkCAHumzb5lM2xCCuYpGSrkSvbN8ktGH7JWb0+qhJJNGKUFn4jFK2V+R5ACcXZKz9wyK0Qk6j0hXGtQXJ6XWy5DAKXJI2WGdFj3kd/5SJtbwgWZ2WBjtUkUKzU3Eye32ko4K5d2fNx7hNzBoeDD1VRuArSZ+xFG/ZP12OpoyPO
X-Forefront-PRVS: 07562C22DA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39850400004)(346002)(136003)(376002)(189003)(199004)(76176011)(5660300001)(54906003)(8936002)(66066001)(50226002)(386003)(118296001)(50466002)(97736004)(51416003)(476003)(7416002)(16586007)(186003)(42186006)(316002)(26005)(52116002)(90966002)(446003)(486006)(11346002)(52956003)(2616005)(6116002)(81156014)(7736002)(305945005)(3846002)(48376002)(478600001)(81166006)(8676002)(47776003)(105586002)(106356001)(122856001)(6666003)(68736007)(4326008)(36756003)(6266002)(2906002)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR04MB0965;H:jcartwri.amer.corp.natinst.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR04MB0965;23:SWRH5271bgNNyeOTNPIw30Exd4IHSCtp49kcVdr8U?=
 =?us-ascii?Q?rMBEGJsTqY8ijsYtWE8+uRYQ9OGIEv++wzLQBb7zAZp4UFca9V9z8Bb8g04S?=
 =?us-ascii?Q?i5EWuC/tltV8wpfLXW+y6aeMb05r00avo5XwCIQL30IigCYf640DmudAsTAO?=
 =?us-ascii?Q?DlhJiqw0nMDvSLpYO1CVrmd81eKN9wDsU0xJu9XIkB4fuiXDCbPwi+WS3VGn?=
 =?us-ascii?Q?WTnep/sfq2HVRTw/3Fg0dxOyOp9LbOHMzBUUWnidsrm3Co8E4McvkWKPxHob?=
 =?us-ascii?Q?9fDSjPbd9VeMoYATXr6vf+WOqtXqQAMa5DZRlJCYI+kopfqzIwdsB2e0j73E?=
 =?us-ascii?Q?+O/C5qAFivmXH85gNB+ZPlOEGpohVSZdIsJmXNzBdJt/tY74G6ItgqjP7Jbm?=
 =?us-ascii?Q?mlUNea8Tobq+9zViYuMVMqaaoPBj19l7szQtYLVQI8JkfqQNc4pA2TNlv1tp?=
 =?us-ascii?Q?8PvRGvry7B2pU5kLGX5Lcb650n9QDUmB0toz4N2lGIBRwBg7VA1WnxQRf9iB?=
 =?us-ascii?Q?Epu12Au0r2mV6AD7IBO51NNGxuZgc9JlId+0aPSS53eDBJKyRQpWhavSSQFM?=
 =?us-ascii?Q?DZJL+HbhuXr6acGw7SVdHPgzLcQ5t6Zl+B9Njsuvqf8mO5AaM6k/o3Uqz+tB?=
 =?us-ascii?Q?VCTxhBlkR/QB8MLsdDzjAnpmaRLp/7ua6cFYeduuHNp03aUNvu54RO4FplYj?=
 =?us-ascii?Q?obnxM1sfRMa8FjyUTCJ5drTo5SHI8Jiq6Esiu3bcWaAS+e/vACuujFZEiNA8?=
 =?us-ascii?Q?L94AJP8Qz12YHzIYX1UetMsAIjYNYdawYAmDrABXywEjIyyen+IyV2B6/Q/5?=
 =?us-ascii?Q?XA5KE6Nluc620LHkSMNGDu+bcZnYpSEmLgqWr1sSZqNYhE24BoMyWI9j32eT?=
 =?us-ascii?Q?03vFcrA+TGMoDXBNywIyBmO+XAmnprCstiW2AQgQB0fU741cDrxZivAH9rQJ?=
 =?us-ascii?Q?feJXMVhxr8jVNjsBmUO8l8xcDZfX5f0iNgfSklc4gZUUBMToLIxYyFWo64l6?=
 =?us-ascii?Q?+XzaQhgH7mT5GfsHxF+PeiH03po5R13XEmXCAxVqeaXtQlicNquFD1RhzGt2?=
 =?us-ascii?Q?DDgCPprky355ZS5iGGt6QvxtpxS4P+zkn9gtq7gqOw0gZGaRo1N4+KBM3//e?=
 =?us-ascii?Q?e5E8E7FxaLF8SaY9o+AHn5p51wQO2mh3OQFreEaJVy1jAUV28sTf9byJQqCq?=
 =?us-ascii?Q?ikWboT1YhYS6FM=3D?=
X-Microsoft-Antispam-Message-Info: NpOVBdzdkuJhlhDb2pRIYxPVFFLdTd9QQ0w+3BgoqNAtCn9jOVL/JiC0jUFZv3MUAHFHkVRldik8soL9q06Y8Fir2hhkge16h5zwyETJcFmBHGayS92X42YXblUnnnZvCroKm6U66SFJf2WSEy4jABOwhkx1DSTUboFVQu1ewrRJQ7yjSQJ1jhkjt6vlwVewyin6qoCC+RcO4TYQf3t8b31gA3rziKf9klfriGTpuPmqFZGKU59BAfw8Tc5836Oz+zemaQw0ZD4/gILSsdOd+2lEJ9XDM8KbAjdmXe/VT1v6RmMwtHiXi5hZ4gGNmTi/ZWg6Y80VFd1gz3Dig3AIsdpUyiwhM7GkUhwkdzwpjBE=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR04MB0965;6:yoUz4Yho4p8fkOBgOGy3OHJitBaYPrDkNlZVJvjmsFDy5B2NlZRnGOvrzReE9Pnxc9dj2fMKtQaTrT6g3b8J/P756ItvyYRsmHyRe9sLv+g34c5iTBYLGWamGCYfglqPiO+GEirhoPjWPSlC1z7BPFDQkUnUHJIWvDxoloPtjxb+pm4mkoe4DIzRSEReUT8yB+76RXDaWHnymGReuPiINrPfsxu+rNgbwFAA9P7CRI4nj2P3epPUTGklv37GSFKV+0c5QicJaz6DaGe1K+H46/0PzqlFAj66XhobyXJaGA4mboQ8tAqg0aFVAjBvNswua2q1IgBMLP/rbwWZgHbbSnyvuEtrI1d1ntuw2RBSirZdOew7M5BcxV4E9l+bFG7Xtxcu3EoXbbe3a57DUutxMGvtjd/91vKFwu8MUQ+Q9fLKF20zC7nRZf0kl5bMoN9dUPVgLSHq0BE/6TXzvnNLbg==;5:0e4A6c5M4z9whZ6YvFQKYyLGTcWN0EvLFNjreJ5PUiwEt0ICzc7+/KS6p+F4zEWG9ENrbf6d+JZfL2Wyq8MqA6SDZnTzusaH2kCuO7mPlYbwk/S1FNz+pDPGRkH13Yz4raVwZ7OMAF0Xmr1VWmlM9Pg13++ZHGBhVUfcKqaAoWc=;7:5+gg4bDy8taOqYQWyYmIR1F5EWw7bYvCvoeM0hfpdKBQEUjG5ne8VSUn9RFtB4JUrtJtYMjEUJTIZwzO2KrWBi583Km2nRLUoLfXj/54Y+N74HUPCqd5E1oPjEIleN98XfelXKZLi1kZ5cAH90dZnFVm90XVHmJ+yrRAU1fr2BYnXN6z+iRxAjFH/FIBVRojVwcLH0iDX6ok13Dek15wUIt5xCOzdYIFP8R49vWa6K++nRlhgPfY9SwiFYQJI9+p
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2018 09:17:46.8835 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 567d7c88-efe0-4f96-7b93-08d5fb7d7976
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0965
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-06_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30
 priorityscore=1501 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=944 adultscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808060100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

4.9.115-rt94-rc1 stable review patch.
If you have any objection to the inclusion of this patch, let me know.

--- 8< --- 8< --- 8< ---
Under certain circumstances we could leak elements which were moved to
the local "to_free" list. The damage is limited since I can't find
any users here.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
(cherry picked from commit 5022166d3b225bf5e343efb3ea01b3c5a41d69ba)
Signed-off-by: Julia Cartwright <julia@ni.com>
---
 mm/slub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/slub.c b/mm/slub.c
index 67eb368b9314..738b2bccbd5f 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3209,6 +3209,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 	return i;
 error:
 	local_irq_enable();
+	free_delayed(&to_free);
 	slab_post_alloc_hook(s, flags, i, p);
 	__kmem_cache_free_bulk(s, i, p);
 	return 0;
-- 
2.18.0

