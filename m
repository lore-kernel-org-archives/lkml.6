Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 36C6EC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 18:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D50AE208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 18:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Gr4Nc3qH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D50AE208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935558AbeFMSnq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 14:43:46 -0400
Received: from mail-by2nam01on0043.outbound.protection.outlook.com ([104.47.34.43]:19776
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935117AbeFMSno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 14:43:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUH7DshCP/AbZY70OmQv4nFg/CwCPAf7GG2kzTC7oQE=;
 b=Gr4Nc3qHY7e+TN/SiNQob2dYsC2Mzdw14+3rmTTlySy9vQBzuo6ddHN10gq4ZWXJ29ko/f3+PolMceRxGBlpAk82YDuoPPVf0VJaekPRFrMRVM+upalwk0lxSLRhRLoMH8FHFVjWwoJ2Em1jxB+0NYJ0xsxnbfn5CCfj5vZogEM=
Received: from ssuthiku-ubuntu-b2.amd.com (165.204.78.1) by
 BY2PR12MB0129.namprd12.prod.outlook.com (2a01:111:e400:585b::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.16; Wed, 13 Jun
 2018 18:43:41 +0000
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, bp@suse.de,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH] x86/CPU/AMD: Fix LLC ID bit-shift calculation
Date:   Wed, 13 Jun 2018 13:43:10 -0500
Message-Id: <1528915390-30533-1-git-send-email-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN4PR0401CA0032.namprd04.prod.outlook.com
 (2603:10b6:803:2a::18) To BY2PR12MB0129.namprd12.prod.outlook.com
 (2a01:111:e400:585b::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: db978104-386f-46ca-7d51-08d5d15d95ef
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BY2PR12MB0129;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0129;3:epkOLC6V3wEuvUkrPnvAKm6kFfuOnmVt8+YIk/iTlFVDXMRaezUrbRao2RmDcCi/Ls7IOtupmQeEakPBkjhbZHOlrndf9CYnUIGuOVz7w+n+pJ8XEU7fnM9TtqKiRX6v4AXvxo6bppttshvC42lAYVmngB9Ro6eZ18uXR1hTgBixclmdZdAsTFeV5lRpbX8myWEXYo5exXTO4tzICm1fxTOzV57STVDXa2sKuyViuar43dOBgknMGzUHSWwI4YPv;25:uC8ptWqYW2CuwgYwIAQ+ssxCF7f1tl3ayNYkHfUDM2kmGpUdFTI6tgOxQJUxzvP77KI+BRqonBpWsilP/2DkOL6mMeXvHbtBWni0CrmMZO52Ttw1ziHZ6BeebiPc6NRX/7sybInbnMxEksNEtHUQB/Ucj3FGkSqLLm+OVFyYzpej/zZ7TsMYMwrk5QT5O3LTZL4vQ1kzF37u+gXBcbav36JtC+wj6G+85wmM84A5fsonfzX/g5RDMkPHfI6JBZC+Xreu2a9WnK2UIOBfzCXFVEB5SAN/APPdJvnHVjrZ0L+M28TeF9s4Bz50QhSvvqQcnsHgI9m4YwmrHQBtqIkZxQ==;31:qtnzNBQ/yj3ywcI9rKywKaUVSqa1N4LHLI4gogCqODQO1NmI8BbZg/c8RASC50L48at6vx3fITC6YC4uVdbLVvnkTidvS9W4AVDj8ZSf1+Zsn1cS62/Xdh41StoD6YpCOXbuoo6gJb79ZM4oIJXua0iQuKgr4JMoaIddqIfbU+qBD6ckv4u6mZQtwciGr10Ygp2k//4HLfpzwoJdXYdwcQqCr4RZzRwzhdZX+PwagsY=
X-MS-TrafficTypeDiagnostic: BY2PR12MB0129:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0129;20:JvYpPcQNxb3RFz3IBxSCHMR3vg/Hq419/7duOwvfPfWhXQTRLeHRxpGyzizYIFhhvH7QnkqD8osY9zO1nL5xhXJqPyWsgJ2jp8D52lu0UA8x3als9ATkmfLbPLNW6nKaej7TkWyQSivO8F/CF38SpiOzB6HqyZRrafpqvUpZx5yHBEac7/yLLP4h68hZczGVpt4luoucC2ad55s+Ue6qX1N/QdKU1vL+SppzK2wRkFsrFLT3ISCRuSN8h7JKL0nXPJR6CcBRe2BUqPu1dfxXyN6T64sN6FzNC02H82G+NbWR3xnkRBiCmKxAOQMSxzBZsUMaS5vQjdxphOJzXB2G3cIAI688mBAUNOLY4PoNiOBu1/jvegPEH7/yOo48U1iNWCZwNEHAl/jMNmTW+zV6oIRRibmq5SgHKG4E65+JY0F5nZN3taYu6BtjWbYT/eA0iQvK9mLG6Tj+B4iW0xd+NoIZbYRkYnlYOnUSifPItFvApPhzW7BL3EuMN+9dqdEf;4:+LujksVCzSQcKlVHsKn+UQwMKhin6J21JOUc5HvmgudyTT+iYXa6OjOgWpNGhH7f/S1Un00CNP78hUtu8CbXk5z+aY3X8zKrv2MaGDLZRXkwsSldCXvKAQ1gYK6LM6Dx8x1PyCE9txB/w9yNJF8btjx90VA1i01eE5cLit7S8KAsECMZEjWR4ubw4q5kmR2NwFyULv6YAI5TaINV27omaIVZB37CllKXfHuWfrbQ2Fi9P/D0kMKEGaHmolFD0t2uMECowG7Eh8y1mC6UoY43OWJ4BfvAG0qxfO+Fz0ywdNVjXF5NQLP45IZXbzOVl5en
X-Microsoft-Antispam-PRVS: <BY2PR12MB012990D184D9A8C38C2B30F8F37E0@BY2PR12MB0129.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BY2PR12MB0129;BCL:0;PCL:0;RULEID:;SRVR:BY2PR12MB0129;
X-Forefront-PRVS: 07025866F6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(366004)(39380400002)(39860400002)(199004)(189003)(66066001)(68736007)(386003)(25786009)(44832011)(48376002)(4326008)(59450400001)(51416003)(7696005)(97736004)(6486002)(52116002)(5660300001)(50226002)(6666003)(16526019)(186003)(956004)(1857600001)(47776003)(486006)(26005)(476003)(16586007)(316002)(36756003)(478600001)(6116002)(86362001)(3846002)(53416004)(8936002)(106356001)(8676002)(7736002)(2906002)(72206003)(50466002)(81166006)(81156014)(305945005)(105586002)(2616005)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR12MB0129;H:ssuthiku-ubuntu-b2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR12MB0129;23:qwxNT2oswwH/DnCnAsC4dg9Q+m/quq+Mw7S7x2Z6Q?=
 =?us-ascii?Q?vAlY0K/a1j0ja1t18AClQNLAEFCE8CUqrIEtcFv0U8gAN7r3UCkbCJsOtona?=
 =?us-ascii?Q?khm6ixVMfiG/267efDZV0EJknXxqMf0X4nbOQULUnZOjM2Qg/QdE1V2pQLco?=
 =?us-ascii?Q?mRnJXsfQhJoBBKzK0h4436irvRqmvorRESxp3UkVtSbF/zWtKbRddVZFl5We?=
 =?us-ascii?Q?/obvQbe1e71IUcZ82U1NGmbk3Ei6uxoEBcMqyI0BBSeXCS6jCafQ4i8w8byZ?=
 =?us-ascii?Q?x0kq3+nGXzHPLNETuunIm5plepUOfbFA9WpEFsK9WeKTwGab++UkSOvD4d9M?=
 =?us-ascii?Q?pMrN+Y6Up3RLPcQVR2WjTXQxM7JHmgoCqnVPSyrg85MFFwRCicU0OlpOw3OE?=
 =?us-ascii?Q?ySOM/bSv5dy1ZJbz6X8kAZk3wvTmVnZG+6bLXxQNNfkKM7HbS2DqSHqkzyvb?=
 =?us-ascii?Q?To8OPoiA77noXjC7WevawwZZHyaYUrEUy6R03RUNlrWPbLfupe5DVAjsMnNf?=
 =?us-ascii?Q?HZfax1GH4QupO8cRCTvHszmNG3yNm8LXM0uDcPzTObowPV/ELQYG8ajbxQqL?=
 =?us-ascii?Q?t41ka/cFGn2emPqgfcnOh4SWu1KHJGV6TUDUAadsEn4tXA6+cMcs8obGfj/V?=
 =?us-ascii?Q?gUL4vLMEVT0JDbLoTFF3j57M9DrnN2kEL59nP/9goWDWZG+rEvg8SlO0151x?=
 =?us-ascii?Q?Cf3vbKB7lE/YpJoPMTQclKaf7nS7z7Q2iLZrE5S5HzuDjn5g8Ku2tgO3QNY4?=
 =?us-ascii?Q?GmGONp3rAG3lPqGElTjnZBcXP19gyqGgyqsbayKwMj9poIO0bvdzfL6D/Ozo?=
 =?us-ascii?Q?P5JX8CFzeLvfRwYjwVKfk+kIIPrtFpH6OPRV2nYb9nJZCfKblmoel3tzFynt?=
 =?us-ascii?Q?k6kRxqCU754/v6uoti4dg0nuA35s2k4dums+Dtsd4gJQCFufDuRiuxrJSs8M?=
 =?us-ascii?Q?B2A/8yuN/VLqzCkZMIbEwbLcnS4VEMhehxefcLtrdjT2hxDEw569T4ba27/z?=
 =?us-ascii?Q?/ubH/LuH/Cl2YOmbTz+OgUsMWx1gAO4mq+OQVNTGWLhH6ByUuMqyENqqWyWf?=
 =?us-ascii?Q?a9zv0HzGNdoCfdFDeMVj5dyqrzf1+PQq3UOvvvzUNdH1aMZtWtczPTIP7TgA?=
 =?us-ascii?Q?SQbmaAgOKPk3vrbDaOvo7e8zf2mV6cVBLPEa5CRPSIbjTCY9V/r+m5sfQFxg?=
 =?us-ascii?Q?NX092xjKHQdXdTbdvz62IayLvOAdGHqsri7?=
X-Microsoft-Antispam-Message-Info: fGo9RLsHbb3OzwkYGZq4t/kdkvbTLA/BVM9f3OCL6+5yGSkxzxwfBRy0IYQ7f6/WWoLlWG/LQKZcQIu6r5b/8+BcvA7/dLTQfQSuvPirTyofyqM4pDccAA+E82JgOPUrQAbSZPkszGej4U7Rx50fnLJ3HzY/1zTp7fz/W9Fg+TQYfCPpq2gbvyEIlsRMHiPD
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0129;6:h885fw7gKZgAwy6g+rDwK6V1GGcPOPOC4xkHlfkHVXpXVCHxNOd3h8TzAWNxyl4QJQIcvvJgYdm9rVkzeq4r5q7dDzDEGyP8yNfIv92fnoF2yKVAWl720xGwNR7KmDk03iS1CbWkTY5lOwSWlh6922O5Ufmd3f6vGnRfKmO7NalI9cJq59lYju82kv45rTm5t5/deyWvJ3LMS72eEt5K8mC4m59Iu+MlEllaxej0DvesPKA76wa8tAWlm1AIYgp34WgWBKQiknh7iTbl7XcqVAOiPV98gSGa3j08k+lBOKn6+EN3F2jY29w3rcB/yiVvAF9N2DR/n/TsCQy621TW65Q7+uL+3feQAqKqGTfdMae9/DKd9EpWlB9/ekus5sni9Z1II4RJfxn38XsZUua2Shry/Y2Uxl0pE76JmKZylfvQFOYnXY9JG3iOtkbYZa6faszq8kwnOp7hi0c3q8gQVA==;5:T21MDZPIN+69U3dZGac9faUmSs4ZK+TeStjqnnMAv4xYmw/N6Vx4vb3rYP99WEKBIN+Iv8rXdRvJVcbHWRFEnioNPcAS0ul+QCPvCvB3NTMQvZi2o+cfQ7J6BMM3Y2AzVl2elVgpctJ3MkCRauZTHATv2F8naOMxqOE3onkYyhM=;24:QmF/imLr92GsWSOsvg9I5+lFdmPx7MIPlw8apWRYNu29IoBEuVv669zngQIYmFSgeQycn66NUzC5+0EX7F9Y2AjRLd7/bBhYljamFwgyQjk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0129;7:8I7/xNCALt+Z7EwzHm4sP2DEVb2JwKPB54p2eIdkpWrQ3ISxCyg0ObaydRShRdvCGA/PUqhtNiIzoTNzL1vTdXahRGaggGpYGgNkM+iNBnCFkUp838yyfbTKYUYDfMZh2Rs6WV5paFyAMWWYXIaFXEuz3S/hbwhvRAySUGA9Ce38qjTfjJndyDFbkEdiGwCv/4BEdIjiFOiLDYaVjNV47hVzIgErHV6VJ3Kt+ImdmMHraP1UDsbBJwDPqHS3ppwL;20:O9NxPW7nuYM3Vefep5u29tA3Qi5bYXzV1J63kh1kGWyZq5GmvVjFv/enRwxcOguZNnr4p2ethXCpVP0zKj9EvpxliaIFxUDD/cji3B3TjUTu0FxdADPdwYwk+QyoQ8rP2I/8N0Myq+1O/xhGRZebe5fC4BESfxvUY5/EGoQgOt/s/QLHX9UxwOgDXcJE6imFba7ncPiCnsSdmiatUhl2BKe02t5FFF00dZxHPbUjuCoiW/R3G2PM1X97UCLbNjog
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2018 18:43:41.3113 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db978104-386f-46ca-7d51-08d5d15d95ef
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR12MB0129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current logic incorrectly calculates the LLC ID from the APIC ID.
Unless specified otherwise, the LLC ID should be calculated from
the count order of the number of threads sharing cache.

Fixes: 68091ee7ac3c ("Calculate last level cache ID from number of sharing threads")
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 arch/x86/kernel/cpu/cacheinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 38354c6..0c5fcbd 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -671,7 +671,7 @@ void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, int cpu, u8 node_id)
 			num_sharing_cache = ((eax >> 14) & 0xfff) + 1;
 
 		if (num_sharing_cache) {
-			int bits = get_count_order(num_sharing_cache) - 1;
+			int bits = get_count_order(num_sharing_cache);
 
 			per_cpu(cpu_llc_id, cpu) = c->apicid >> bits;
 		}
-- 
2.7.4

