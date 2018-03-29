Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751210AbeC2Onk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 10:43:40 -0400
Received: from mail-he1eur01on0070.outbound.protection.outlook.com ([104.47.0.70]:25952
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750708AbeC2Oni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 10:43:38 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jules.Maselbas@arm.com;
From: Jules Maselbas <jules.maselbas@arm.com>
To: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Chris Redpath <chris.redpath@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Dietmar Eggermann <dietmar.eggemann@arm.com>,
        Stephen Kyle <stephen.kyle@arm.com>, linux-kernel@vger.kernel.org,
        Jules Maselbas <jules.maselbas@arm.com>, nd@arm.com
Subject: [PATCH] cpufreq: schedutil: Prevent unnecessary mutex unlock
Date: Thu, 29 Mar 2018 15:43:01 +0100
Message-Id: <20180329144301.38419-1-jules.maselbas@arm.com>
X-Mailer: git-send-email 2.16.2
X-ARM-No-Footer: FoSSMail
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: AM4P190CA0019.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::29) To HE1PR08MB1099.eurprd08.prod.outlook.com
 (2a01:111:e400:7b75::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6aa0aa81-30f4-4a0a-9b9e-08d595837356
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR08MB1099;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR08MB1099;3:EqugdT/Uqj1LeVLsZJMvMVXe2mMoGmaObvsz0UF/flZB5Vc3Dhc4ZOd0QD7WmN7TYRcRmayJP9F6xi4Z1B/CRfq8/QjZ1TBvTCvzwduLwmHT5iGdQUki064IugPq4fBq/UIBWVEU3ZOV2PoCnppZJnCGjcDp/p2uywoiAGdY38y5yIqbEu5PDjv5+IUbXUD4frj7QWylVSSgGBZsAZemSWcGG0IcCH9Wa1CwdjNAdRfDH/9aHuD6JAea/yWrH5Up;25:lKkefCoFbhMsEP4b3Qr3Rv5Yeoke4Pk6deAAHYnLYgG0+/2Rzvdzq7Akzeh0Ik1E7ie0rKSssGPUzpAnYHShqWrbpGzZ/uJIL/krid9EL9+Wm2qEaUx99Hje2ND/0If4XEnrNQMNtfPwOPy64PbaM1YEGTYOn6p7hLr6aR0fRWyhmSQ1AAUGuUi4zgszAclsMs1Y6mS7g1WilyC+k8Mx69Gy7UV9tOcEpIy0LG2kRS077ZLmXySSoqePdHqs1c4MTjB1hT4tAPOUPUVI5u+RCLVND9vGWsoM+gqL4E5TVUhGfaeJ8fFY6eh/XU5H6qWs+qQ0ocuF6QFf3r7TkzM+8w==;31:2v3Pb6bbBRhIyIBpiuZaLppXBwrPJ2FO7bgbSunqsUa87WmP5YgF0XQGF18+NGy7FPJOU+TJ7Ay4kkOCRJL6A+WJVw4HK8VnPBFDWLaEU2QVxa7SSSJ7LUn0lEcjX9mv0c1UC5TOBKtlHANFhxewsETe6GUekzZICJTL16AUOw0VhS8bvPWRqlM1ir8w5PjMOkS4HAT1nBxv8crHYJ1jcd99JhWh4Ms15iYuBOam77g=
X-MS-TrafficTypeDiagnostic: HE1PR08MB1099:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;HE1PR08MB1099;20:ew2zypDzZzzSuouDft/xbGJgjF81ATN6ZGYVcqOb5treRYxrDl5NQ2Fnn6jthPdZE0r9ZrlMXhCenvFHbZhEZaoWUgOmmU5CZiYz0RaraSInws+8WLfkLTdfGNof/pP3Wepr+JZ8evv3PtlM8RxpTofjSI0mRZ0fJ716dGmS6Xo=;4:E+yg7Q4Y67SuxssVJZGnarV6OasIX+CwtyMOmGEwe9+fhLJ2LdUws3AkWDdbdYuh36T3UjbjnPKxeu7F56mAUen2IE+OMjpL42cjVUm4ZEv3XZujWC3bd2hkZiuqldk8/h789fGb1NGXtAF3G76DFDDbHi0eVBirR9T/MEdmt00nqkLNIAasFbPQSwIG4Wi/WGmnEN9EOal0x1W7W+za4/I5+4FWhyCP3yGFEa7W9doq8UMgkLT2Qt7q+uH49xff47zGYtK/klfDKVizBUAARCf6s1AoVb3oGNzNmG17zcLAXn6/LvHpQHBgC0+ZF7bT
X-Microsoft-Antispam-PRVS: <HE1PR08MB109925624BD37A6F59E945C386A20@HE1PR08MB1099.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:HE1PR08MB1099;BCL:0;PCL:0;RULEID:;SRVR:HE1PR08MB1099;
X-Forefront-PRVS: 0626C21B10
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(366004)(39860400002)(376002)(396003)(346002)(39380400002)(189003)(199004)(1857600001)(72206003)(26005)(97736004)(53936002)(186003)(81156014)(81166006)(68736007)(16526019)(2906002)(86362001)(105586002)(8676002)(956004)(4326008)(8936002)(66066001)(6916009)(6486002)(386003)(6116002)(316002)(59450400001)(36756003)(3846002)(106356001)(25786009)(478600001)(16586007)(50226002)(54906003)(5660300001)(52116002)(47776003)(476003)(51416003)(7696005)(48376002)(6666003)(486005)(486005)(2616005)(50466002)(1076002)(305945005)(7736002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR08MB1099;H:C30.cambridge.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR08MB1099;23:Ln94uPKdE9DV7OjO41iD4XTB/pgRyo8vEJlP89mzq?=
 =?us-ascii?Q?yirG3eAU+RLq8Bfq08WfTdZPgSkh4UlwNs08cpdWqCdOBRprLJD4oS5AzcGx?=
 =?us-ascii?Q?3ddnTPClwk/Y5jjBT6mjiraxhQJbLZDB24M1ZIDJi4z5iqGDR/pVLaNO0WUj?=
 =?us-ascii?Q?4P8re1GlXuBPioUW2sBHWkbxOFvG3tPezBf4Scy0KFwq+543vG7OZ5GZtaMW?=
 =?us-ascii?Q?pUJJQ8I1oVWSuSvPh2UJq66qG9hUdVZ+rGc5jIaDFO/dntKBX6kQUmw60yg2?=
 =?us-ascii?Q?mV+/ih88CpfD4wIhHjQ3OxUZgkjaeKy417j6nH3htie0MaGKnSQYsIyIx3VT?=
 =?us-ascii?Q?6NJZuL37k5c7/Fi1wAQInmupetmKxww1Ae2zo50BLx2n2ll4Vsc3tM7fDA29?=
 =?us-ascii?Q?PRY/rtpQxtJlqpUTVLFYHUhMaQ3MBOduChgKsawtQ2IexQ5ZkbkNMmSzZGxJ?=
 =?us-ascii?Q?1Q5Qo6kiq+NAVYtfQAxtEDinuqQaN0nkCijpN/r9StYcwJrkcizF07n/5Z7H?=
 =?us-ascii?Q?cYXrfX4k7yGmHaWU6dH1brqoQ272xSKluGY8wOnflI7a8d2sRFZ4NE3Tni0/?=
 =?us-ascii?Q?KR18ti6Q0gpBAEDxHS0lDBA2p8kJ8kZK8ZiCMcPCHLojj0YFfkp9sUd4+i8h?=
 =?us-ascii?Q?WTQ4bCzsHndR1gvYtOfKio+yjbxD0Dbd4wEL8coxiN2yC+HqAC6MNfSDjH5R?=
 =?us-ascii?Q?Nv2WOBMQikmjJZXh06S2tD6B3CwDf+uKA3ZWMhrPoFuyOzfZVAVLhWjQmPof?=
 =?us-ascii?Q?PU28VjnfFl4/3oH62kmvCb2L5nKxFxP7A+hoDeAblJZanqjc+VLFcIDrdbwl?=
 =?us-ascii?Q?yrfBg0wmZ59VFDih/jbOMVgsCCCYfwyW1lowk+LPeQHkawKoY5uQxzZDA4Dm?=
 =?us-ascii?Q?+gIO88NVGeSzXr+64f603ooDG+6nfMnoH5FwRp14n6kyAcZy7xo3GpArAkK/?=
 =?us-ascii?Q?Vhj7tqvHvxbAOf5P7j9DkbyaKCX+E8RoXUHQ0noTRPIK85Za48Rs488TZKqa?=
 =?us-ascii?Q?MpAvXhKGcntMMBUIeG/uO0Tx6zBX2fLuPJtT6xypzk6UM+ar9/AQXgSSfF7B?=
 =?us-ascii?Q?tl0FuUo1zMkj1RXY/IUGu/J9HDrw+dLoyprDtkMctZ5EjMF2rcV8cVz76gE0?=
 =?us-ascii?Q?9MG4eIp27Oa7XRalTgn6NFSX9Jm4rVmgTe/EiP4g6CY0cr5IiRcGx0Nl3CsO?=
 =?us-ascii?Q?VirBYtDfMQCXhI/gBHAYinwFFE4g7rV5thfpkqENIKUYb0GWblnykoh/Uh05?=
 =?us-ascii?Q?Sa9mpsqdBHZk8XIfAC1YuTV2rthMsGJNSSz+IgycrLT+Mm50oU+4Cnri0ixV?=
 =?us-ascii?Q?wnJ/Up5zkslb8VxONSLhjZQYNh9AcH8NhM3FYZQ68Ld?=
X-Microsoft-Antispam-Message-Info: xudzFAsPgRB3FaOwqmdYe1zPCRySP6hqQvPCRZ2s9upggFA58kM87+keSgtidKxEmtzIVayz1cRns7UtlY/4XKUzeuD+UOaoQBBFWzsuHWBVBlVLoC88Q29c7IBOmUulyMZmW+f45bPdGQXH016WmgLdaVl0lKv+U7HPjYboCCdvL0lY2y4NKNc0488qW63t
X-Microsoft-Exchange-Diagnostics: 1;HE1PR08MB1099;6:fgpkAG2jZdw3O7usCUiwwvadaIT10pIWCTYPpLCipBKD9O8PYPJHYDsqr2ZFcnxVgd3aqUDhOuyCusteLslzKuxo3bRO8ESPLgWhKzpex8wzNo2CFXv9ITFL81YzDJdm8bfHqaycMgWpKSqvUppqXgscsfJPh4aUf2V2IBUzok9sbG8I2qHOZwb3eK+gTGjuErIOpw6sOuBuGvkRW+81SsTXgfV/gGM9owxsIzFjQ2ECJRHklNrqZmwbdPcR2pQYvCx4CZO7QkB5i91P/vCOH0n/MyEtj1+ObeX99JBKI3jQ/5CtSBCmqNkEHR5nYCNxG4DG/upKQE2U6eCqjBZnYoLrR6pGNONpPuKeMHFsi5kaUDQMH1h8RTjPuwlwPvQoVFVxaLpcQa0UWd4ypsUtFr5C3l9orObAgVqhcx4SPOAOIRKYDN9FndBdxkhvSutAGKXvuZM0cC0szioZxn+byw==;5:/1CRFhE2lCTDwz31ZC+sgiDSvcikYuWKzRWOw1cN3kiB3RoivQbcYKO2J3JRtSK2uAlR+cDnqw6eoAznShEiYpLOwKK5IgUDhiuvqaeXqHKXT3TOd8zygEM7tIf3Z5YR00qsnNB38oAet/ivvWw000CWNR4BefMgO+uYSWXBY6k=;24:zHnoXcz9wr7plWOc1CI0fCBrmQ/YSATY4gAHwY5V0H145o4Q8yFFW3TQ5mYIp1iLPEOspihC/qAh7oOWchxspu/ahnMcMyXvcxDY000cMrk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR08MB1099;7:rimhs2eI/cu6ZvVk3RJWlfj69NoDeFqCIv+HE3IBqoKxIwI7W+2IiBTKMchxzANqUGCZo39UOFS++bJQvwktt5RYfWwn9+NE2nRCuR7dQVdkHn1CMdel8ziW37iuNf6zouBtg4EuN+T8nBwnmrqBh5EWUVGH5SHF14nVZhIxuKh9itlj1B1lpQSV5F/LgHh+ZkYP4PSAud3iINSEmh6z3XoKLKwpzNbYTNxDJv50fqZ4m61rMoKDY/CEHG1c3ykR
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2018 14:43:34.5321 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aa0aa81-30f4-4a0a-9b9e-08d595837356
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR08MB1099
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch prevents the mutex global_tunables_lock from being
unlocked before being locked.  This mutex is not locked if the
function sugov_kthread_create fails.

Signed-off-by: Jules Maselbas <jules.maselbas@arm.com>
---
 kernel/sched/cpufreq_schedutil.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 7936f548e071..617c6741c525 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -625,10 +625,9 @@ static int sugov_init(struct cpufreq_policy *policy)
 
 stop_kthread:
 	sugov_kthread_stop(sg_policy);
-
-free_sg_policy:
 	mutex_unlock(&global_tunables_lock);
 
+free_sg_policy:
 	sugov_policy_free(sg_policy);
 
 disable_fast_switch:
-- 
2.16.2
