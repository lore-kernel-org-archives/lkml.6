Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753479AbeDBSep (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 14:34:45 -0400
Received: from mail-sn1nam01on0063.outbound.protection.outlook.com ([104.47.32.63]:64378
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753072AbeDBSeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 14:34:44 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
From: Yazen Ghannam <Yazen.Ghannam@amd.com>
To: x86@kernel.org
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>, linux-kernel@vger.kernel.org,
        bp@suse.de
Subject: [PATCH] x86/smpboot: Don't do mwait_play_dead() on AMD systems
Date: Mon,  2 Apr 2018 13:34:24 -0500
Message-Id: <20180402183424.48222-1-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: MWHPR13CA0008.namprd13.prod.outlook.com
 (2603:10b6:300:16::18) To MWHPR12MB1917.namprd12.prod.outlook.com
 (2603:10b6:300:114::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a20e93a6-8be2-417e-dac5-08d598c86525
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR12MB1917;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1917;3:nfl1N6Ht6hjXU3nBCKA6uxLhnktFuKOtakQTTqDaFTIPBZEy9KDtA5GT6Ve8eb6P1CwsA8UcKRkAcqx94nsqt2ff5UtTNHmwQyuys8ZK1w546AtFSlKlmqMUSt2zVxKmZGZkhoYEw422GqYx4ud5Z7CP7zGKgn1Zxo7anCZ/uzU1csCSBe1tKmsOGQB/3osfbjSG/E8mtny2yMl+EleHnnxX5wGEldzyYWRVv6hbKP/QdlHZWJx9kp6yp9yPA0ho;25:MzuH4VxGLID0Vtf/kmeWnbqfNXBqE6sHrSfKYF43xN+pcKIHLzotkd8F1yr0OTdQBK5D89erUAVhZ/tNHkUZLZE45blsi+nf8CWJEnM7svEoq21sqPF6bPgg9cV0s8qx3T6HtiWPneYR640BVcduOd39R+DdUKqnmiIpAo63STjtHJA+gLlV+9j5ypLw35cK/6Uf/WMRMGVwVhcSDxQaDphI9rkM6YcQRPjY2duSCQd9zU4aVnGkHhKj1Dz85ghUE9Fny2LyIWcrq4PPAKVXWppqyQwLjKV9Fwd8gh9vMQL+USA6myn6HZQjEBLZK8MqhjzrISZof7oBPJVb4ctTyQ==;31:5TKvauWzI9UfLneaU8XVLgnZMKiyLsgEq0NnfkV7e1WLoBMO1M5YxB5wT30v8oiiQi6YdECaNXKg0pug3o+dnIhidUTeWOj/8jsoIMQgQNeOIOPRxhyHqhn72uf7WFslX7p+bzFaLlSqNujdSOycTVKQpOXmzuNadvPnrO5wrAm1WC6F36t92qb10krKChhQ4DEi0kOD63ByfisouaLo3c93mMusEFn6l4MXHxMId7w=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1917:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1917;20:pqG9FQG3L6OhzYOCHRChIuM3EEU5ILfcxGPUl+YoB9yG0jodWTaYLWbZ+0GkhC7MfbkErVXL1pi/h2eAwBRIdnwFEbFNNA2YRdoDIxAPaxKWBdKV95ncoAu5/Q0fNtBLXwvwPJHv5g4v91yf/4499gMpBXYzOnlxmJxPnIi3H6M7sTv9catY29d90ZFzH/IIIX5UaUUrClkVSMdkVpobHqKUmXktn2tVC7Ai9D/kU8Q6MV6EjLQEq8u27/ZQVPDqa1MPC0h9PPBTFjtyv4s6DEWEiq/cElkSkaPFmJY5chpQnZpzpi8TEqtfGPotLoqztxMnMk4XSYPeFYBj2/LWwPbcNhLorlZ2N/bDiCvSPgMoFqamEAXSd8DA7kqp8jlP4ALQH2toULuxD4ILqrOsYWsOt1opgzCGXrtQj8o48/1cM60XgmQz7s8Cka8iYqiXzmPvyYwBF4a4lQ9u1q8UPK4GVpzYQCBo0crCgas1S5mGQXB8AcojOJ7GPyPal2EI;4:icMrrnIFkG7KLV+n/IfeNF6nge0lIZ0vUV9ZIy4b2ijvX16LVayXlQL1FOH0t+F4vyBnASJhfrGg2Z3BoIgA6n9/MtH+zGZx014p8AF5jAFvkhufEIVJfnYwekhfsTZfdW7qKiC4HNxYGhHDOVymmtnVpjmhBhOEkpJoGEKBq5i/LPggm+yjsKs0VviM4gV8k9Rc2jrbC1y/rDUGRjlgDI6DkV/+Fg+OUBXDg/n70AjYWgsJr7yLykvaz8FQHs5XHnhwvoLfqxatrdLLvwOekneK5uZ2YNd60r1NGoZPuVno/N/9xsKO5Utbg2q1lBH/
X-Microsoft-Antispam-PRVS: <MWHPR12MB191788248EAE696531D8EACDF8A60@MWHPR12MB1917.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR12MB1917;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1917;
X-Forefront-PRVS: 0630013541
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39380400002)(396003)(39860400002)(366004)(189003)(199004)(72206003)(50466002)(6486002)(4326008)(48376002)(2351001)(105586002)(97736004)(81156014)(81166006)(8676002)(50226002)(53416004)(8936002)(478600001)(66066001)(2361001)(68736007)(47776003)(25786009)(6666003)(3846002)(6916009)(1857600001)(106356001)(36756003)(16526019)(186003)(305945005)(2906002)(86362001)(52116002)(51416003)(7696005)(1076002)(7736002)(53936002)(386003)(5660300001)(16586007)(486005)(2616005)(486005)(476003)(956004)(316002)(6116002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1917;H:yaz-diesel.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR12MB1917;23:Q+cBDatQYfrvohnufLFLe9RXYZq+DKMLsP1h3eenX?=
 =?us-ascii?Q?GeY2XCYyv0UCSSXSpsz0vJE1YjkiMpmMVnoKoW42LAz8eTLFAvAJCsi2QbIt?=
 =?us-ascii?Q?CU2JwsqEv5KsgOEXzpX7xmCoTHCTMf6FxlnWCuUvI62BoL5yaQ5CH3tr2eNx?=
 =?us-ascii?Q?AVd38F2AnUYyDeOFZvr5pyxc7WxJk0RYqcYd9WcksBOsLdHYQ0szZvXyZUzA?=
 =?us-ascii?Q?NYWhHdg2oki2ThqVKzzPT3gJRipn4P/ECNFdK1WnEMvPb5Y9HsaiiDkGYFP9?=
 =?us-ascii?Q?yr+d4Yrnz93JEDgtzKhkaGhB4ntRbEWLSBqN2FWyqXQy97wJSVBVbD6XaOBj?=
 =?us-ascii?Q?R9YOZfBYMDnFMyZbaVdyiGkTC3X2fNL4fKaAFRrq5X4G8cYzzW76XCj1HEo5?=
 =?us-ascii?Q?e3kU7LfaKGEKe6SHCSlSckOQK7OLC5uVI8DGp4BK3DF+Xgn9LTeLLGTVic7i?=
 =?us-ascii?Q?zqZAyaHSEWtcKuw9rusvppQl1wYbrX3Itg4waF9jhYqfTj5K+7JGjr0gafYc?=
 =?us-ascii?Q?j3xfF7oJcFniWTACKZqDG4wvywYXrkmvYc7sYm98Jp4TcWTR+4qDF+ztP/Yr?=
 =?us-ascii?Q?Ivfk0rezCC3iNZEQYaI22n6FrDiOp4AaqR2Rv0ECIt+Es9rEkXMuWGOQ8BPD?=
 =?us-ascii?Q?kHH642tbFSKcDlOoUnlg5d3cCN4qHEAUChM5oLpa6rjizW1UJmRjJfNQ1Zfv?=
 =?us-ascii?Q?Qfu0hWPT4lt2VDqpJgVK9GSM4Oe66sKIpwhTCYVrpfX8y3yjoyMz3P9/BkSv?=
 =?us-ascii?Q?Mu6FJ3nmTdP4GkSbt6HAoAgn+HNy7+btPa8rhyqBwFl7XmTn5yqTw45qOYHh?=
 =?us-ascii?Q?lw2mo9/2vTfmkfPvGTtP6mZnVkNQ6kz7Q/kiKlTocHtYJvF91jSkLUW4XWd5?=
 =?us-ascii?Q?O3iHbziz3jYQzo5MHRWhm6mlj/X5YSIOr5ZkClkU0CtsQVJmzaKZQm7pxLkt?=
 =?us-ascii?Q?oLdXsvQ2Wpgg7xXid0FRcPekd9GlIM3DZgYZEpY5O7P1BKCjeG/doTHHAehr?=
 =?us-ascii?Q?Rx7ALvStMUnNTH2g0iIwg7Hzs0Gl1H9aRX8FfVYhGv0ZG4dMHfRik2NubSnL?=
 =?us-ascii?Q?f+RnezVuHL9acderJ7kDv/zfCA9C7wZTveSNXnMVtawDSYd1zBH9lB4Nw55r?=
 =?us-ascii?Q?3R+rdlZn4rdE6SXeLOeauEgbLMiKBtG87T7nSJWZwDTQcFZHqr0IzsLw8XXr?=
 =?us-ascii?Q?RgOgRHpjPjcNfzer70ynrrGDLtw676EUwIrLVgx+lgd7uzzYEHbCF6th90Rj?=
 =?us-ascii?Q?tGJUbWSosGvauSyS8o=3D?=
X-Microsoft-Antispam-Message-Info: xkqcNI1hwzF4+6hmI1iR/YWzFNhMSBEIsg8iQ8i1dt+UxKEEVnAEXntt91g01GfejebbG5TcG8Ss400pdEa5l1AuhDZE+zxFYEtXr5Ovwq7qJ0wszSA6sg7D2TqADU5AugLdpdYeeXxxrgdQgnPY93kS+9BNSFXwUSFp8LLt7CDoPsJ7cVKHJL5sce/7KhmE
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1917;6:AabILXWTrWv8n+Kk74twWiRXvDxpuLjAN8TZ+N485A3wMWU3q4ElosKIrv5569l6m93J+YPHcv5sIEzymQbsi9+rNZxdweHxN6MWg+Y223+A+9dzTdDbALO5EfuWwXeZ/tWdb9IaD74N5MmOWoZYYXwxSRddN7s4VzXaMsbMH2J3k0j7KFGyP0Mh6CS/sA/Ltt6pIr3fI4HlBJ2ysW5dAfzKdn718SOty69wo5drb5ew84B2/MbbPpxS+fyxvv6ZmTKQi9lnHsWxf32tKc//G/AACtORy+yWTSmWDOI3xhY2cEyUzDmDdtPU+ODtslE77lRFE8qJoHdtRaNMnNmxH0tCkJ6h8A3q4hIrq+0JgQ0GjQOK5jHxmmhwrTBzGzIzbZHdYIrg6gjLD94nzbmD7c85fbu/13WKQlMAEC83DuUySd3wR05JqW77c32kcVPfgANM0S6wD72LUtMWrhjDIQ==;5:F4CHtaPK9EK0wIRFFajT4EiT6mS+twt+jMJdGYlr8O3k3ivrWBXuB/ZRhpSgv6INomBjwQ1CNpR0urJDK0AWZb6O12RwbAm33LeyAZurZss80JGSImsSa8zZtIAzBwN2GvMDB24BdEcRV54k5PEDDXy8jeHp1oXe2SB2/QaPQcI=;24:s+EdMAYqyElSpHVdvKVi54EqlHo/2q+vvXUeghDHs+ROzZhv4Nf1Y3R7UiY91KxmywOrIbtT6nuhaMXcjbXY3cEpCrUISAYT0BV1IX3EdCs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1917;7:UPxE/rGY3Q0kWh7GdqTC9TXrfz+GrUc/ixwsorQVknoi4o5JSaMsCxHnecIiVWSxTLZw7IAm+IhTYYKY8cvOsu/uCDMTHk8Qio9sbf8Z6V7a0XiYsJvl4quQOros2/VW88sveAkeX63ydhG6K73fGNlX7d9Hlv8rKak61N0mSj2JbHM6cKmFnnbmkaDKJI1IARRZojJm6ZhXPo8Eee85GKA6lxZeoFLfuYXPdjlZcqMErWWYMAZG2tPhtJD6/T3r;20:Eb5RiFd3TaLlKGbrWHvGaSurNsNsLCURsOfM/nf0eTqVAv+DMSkFw5/cJ55xsqUWY0Uz1YV2q5Jn9KzRuH5i9/kiC9Kf7LDCQxaIBJgTbxhnM8e1xPB+4CLom8gxqTdA8qduqYna7TGlvnbneH4TYIYazNyyNxJvvbjD1a1sMLdveZVQeOelubRoLi3xo3FPbYYj8QbW1rjWA/29F6ANTQ1WBpmaKgxzoABgviefvFhPPKZ3M2btfMyHQfdkWHKL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2018 18:34:39.5810 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a20e93a6-8be2-417e-dac5-08d598c86525
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1917
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Recent AMD systems support using MWAIT for C1 state. However, MWAIT will
not allow deeper cstates than C1 on current systems.

With play_dead() we expect the OS to use the deepest state available.
The deepest state available on AMD systems is reached through SystemIO
or HALT. If MWAIT is available, we use it instead of the other methods,
so we never reach the deepest state.

Don't try to use MWAIT to play_dead() on AMD systems. Instead, we'll use
CPUIDLE to enter the deepest state advertised by firmware. If CPUIDLE is
not available then we fallback to HALT.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/smpboot.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index ff99e2b6fc54..67cf00b25f83 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1536,6 +1536,9 @@ static inline void mwait_play_dead(void)
 	void *mwait_ptr;
 	int i;
 
+	/* Don't try native MWAIT on AMD. Stick to CPUIDLE and HALT. */
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+		return;
 	if (!this_cpu_has(X86_FEATURE_MWAIT))
 		return;
 	if (!this_cpu_has(X86_FEATURE_CLFLUSH))
-- 
2.14.1
