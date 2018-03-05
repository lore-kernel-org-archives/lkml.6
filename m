Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934367AbeCENki (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 08:40:38 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52584 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933100AbeCENiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 08:38:22 -0500
From: Roman Gushchin <guro@fb.com>
To: <linux-mm@kvack.org>
CC: Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: [PATCH 2/3] mm: add indirectly reclaimable memory to MemAvailable
Date: Mon, 5 Mar 2018 13:37:41 +0000
Message-ID: <20180305133743.12746-3-guro@fb.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180305133743.12746-1-guro@fb.com>
References: <20180305133743.12746-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c092:200::1:ec6d]
X-ClientProxiedBy: VI1PR02CA0076.eurprd02.prod.outlook.com
 (2603:10a6:802:14::47) To BL2PR15MB1076.namprd15.prod.outlook.com
 (2603:10b6:201:17::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53a82108-a68b-46dd-f605-08d5829e55e0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BL2PR15MB1076;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1076;3:/GGbY5ncdamxxYUV+rNg1grn3tvQvg04vU3bRc8QlFLEv5PJYv/qR5sFlOCDLRgN6tnOn2pofs81tcNX0NQq0HvLQyXY4w0NQ+wF+O+zodKS7qk1e+ynEGVxwJ1H8LrlxWSCQYb93l6bcPl0IIT9rGzn3YjhIRdjXvjv1KkmGZ7A3ICkB6ieQX8TOfjvVoc7yEzbxnXDX0adFEhWCiIDNUX2MKkJb47SDIjZSlF6POdy2UnuvxJaqRb2JJknBagV;25:92sfIn3fPEFxMHI2Bd6JZTXtDcJ5663RtyB8/8ge2tN6wEEZmIwqGLNFMcj4tTSfbxBhfU9JAV0ecdLRaAkblc3Mu1FiwCglLHKm16vWOgDJd0zWaopy4neKxrfCEa1pt89FWeRr596djCw2OYEOk8Kzl4VonL/CKsiy0YcVv4IuOGfG4bgEd05a8jSMpJI6sK6T4N2y7fAOn82iVtiH1J3UVDX1lfgCmOXgFC3qGFlFQ5TEd3LvmQCdnH4Tvsaq9Bwtvsd56WC4KMD/TqBMDKme3afMCtgzoV5YhrV3WCnZgUweFUAzMCdhrd2nZ+ue1cSQwPqqOKShlnx0M+pS7A==;31:DUUZ2jQALBO7a6iIKojZRJ4QM+vP3bA9Ov+KD3Bmw5vILAbQOCtOXucJrgDOoCURWtJRvoArt0tQTwFNFrHNC6XrOpsVbx095z50MDpzOqJxj0xv0BPNL1dattS2VnmabLASwosOtzA1IOd7o6BxH9EKdXZhwJQSv57zyyoMHl2sA9C44IpL6aLguDdLWQdTI9tXIatUFHu+OSNIYq5ISxDxaAz6YPciigZ92+NVsLE=
X-MS-TrafficTypeDiagnostic: BL2PR15MB1076:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1076;20:xx9lIT/zyx3+Jp5RrNpZ6pgeq1uklLkD/ESePb6v0WZx1XRj+9EGXukQQePoVnol+EK0Ybh6e3Ak+79iG0vNAY4ApDvCCbfg/7K/S0RfcJPV1o8kNWRZDLhzOvidSFO38Js8VakwDQpd9czSCXy7zushP3UifNOausJEJN0TU9iUv8OPEex3+/Zq35dcP7fU5f8HY4hxDaclML21h+4z0uf7QYKGAtokViE7Hsk3IAwV5b0SddgwEOBC988YeNqeo1jiwSIbi9xlwebaS7C29IN5H0jtouTcp+f6eDCGseVCqszdlHxg0SBSki08uhismvddnh+1NDxH0/f/gJUPmrJHUBRhnTudTrGD/9cjVFddMVRN0iIbYosPIddVt4ioXuB5d6zUKdXjJot1PAQGYDTyHAdQPy2VhJhoPb1n/t5kQODIzyEn6opTbgbFCmm1m2AO5Zqm+yYgu9fZq8JKwRTHt+oz3CbcsSTSqF37WU3v/CcWQyixcVWovRSDUA5g;4:Qjs9oJsIK+zuo68Na0GDrQZpMnDVbPzW01KuLy1UJE6Sht1eT0sG+UrszOEagyAh7M9uM0Q9tdtblpLtFhQxzHFWCANFMh20P1Egmo2a58Prw0xoFe23sArWFweW/F/Fbq5UrtrhaJJUTAa05Fc3E3K7rRoxNJxmpXKW7JdA/e51Vw1BymNLYWmj6yibhmjXykMoscPbW7bGbYN0gdYWaqr5g2R0V8JfpgsoMy31GAapQyHoQrjHmZRpFjoiNL2cAbtr/H0EpwtyZ+4w5KIwZaSsQUgSY3CXW9aGT6VFCaYSi2COVyVBy3DpOmlvlzN4uDjen4s8/xyAPL0kGFi08y5g2eBYaQf81RKju1M1qFE=
X-Microsoft-Antispam-PRVS: <BL2PR15MB1076850293B626C1250A8259BEDA0@BL2PR15MB1076.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(67672495146484);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(11241501184)(944501244)(52105095)(10201501046)(3002001)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:BL2PR15MB1076;BCL:0;PCL:0;RULEID:;SRVR:BL2PR15MB1076;
X-Forefront-PRVS: 06022AA85F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(39380400002)(366004)(346002)(376002)(189003)(199004)(8936002)(47776003)(50466002)(1076002)(50226002)(48376002)(7736002)(16526019)(186003)(4326008)(305945005)(8676002)(81156014)(81166006)(2906002)(6506007)(386003)(2950100002)(5660300001)(2351001)(478600001)(36756003)(106356001)(2361001)(6666003)(6916009)(6116002)(6486002)(16586007)(316002)(97736004)(54906003)(52396003)(76176011)(52116002)(46003)(51416003)(53936002)(6512007)(69596002)(105586002)(25786009)(68736007)(86362001)(53416004)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL2PR15MB1076;H:castle.thefacebook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL2PR15MB1076;23:L33LeEpP/oT1SWApvrc1P5wkprSxUl3oG2my9s5ey?=
 =?us-ascii?Q?3Cc2f/MCxBqQ6hMcJF2dG1OpzzbO17OqaRZ1MZSrg6vahWXAVxQErUqhJyTY?=
 =?us-ascii?Q?z5gI2wSy1FPPp6veDI6y2Wm1arkDmb9c9jn/LxWLHYlYLbNR3GRJ9o2GtcZc?=
 =?us-ascii?Q?7dOoxY5zgCsA1spbrjz0Jgh3QfX52Adtqrd9oMfwAv8wQ66EebcToOOSqEx7?=
 =?us-ascii?Q?X5Ve451i8M8ohqHzt72pwjp4T9yUCTIVuYE4ifUGIY4NbRKW/Jee4Ef1WxnC?=
 =?us-ascii?Q?AJ8CEgjWCQ1o8jVhPWW4YcYSCNBYRmM5RWLl95sMjXnyPG8mgICvlP9sto9f?=
 =?us-ascii?Q?X6Inko2mt05NyQHZqNlG2xiysKe5N+/pvabXzkS7awTJFREfZLWRxFbSEEaN?=
 =?us-ascii?Q?cTfoMch9WfNvcgKtQLH+UShGrJ/ZrsA6m3N1uX+vOm/zMI2WOlB2kyDKcyBm?=
 =?us-ascii?Q?BIFR9UzJcCfxTKjk/Jy/nHehDjtMlUsqmcNo2UHQeu0CYR91/+/iFHNmwm7D?=
 =?us-ascii?Q?ctYMNtyHXhbgYtOWmqbgzRbRxp67C1nBBVhclNr/5TkO2iMid3IzRJyfrYwO?=
 =?us-ascii?Q?bXaOWxpH7hdu6KMWOwtKRfctVurLdhQdShz/im4Lrr5ip3oV7w0bSybXQBh8?=
 =?us-ascii?Q?+YrKCiii3nNRNy+5RIMAb5rqa2Jgt9HrMyvOmHHZQiQ44ahItrJsjzMvJ7H7?=
 =?us-ascii?Q?sb2lCaJ2YFconlMtJc5U3tWFangV611whdvjBWjjv6JYA4fkF9zFXqRnfEYG?=
 =?us-ascii?Q?lE7u4b7lz8eOtB3QvtletLMLQgn0J3hpHJL/oNrKFjHLsy9n/wDnID0LYz0a?=
 =?us-ascii?Q?1+qKX8tLzv7HAGaTthAPP6Nr7bXHwSvpIci0jbi4olKXBlnKI1FdQqAyQwbO?=
 =?us-ascii?Q?q5F/8EXj4yyDpLDVtt8Vf0xB8IlxOI2HW/W54Wang4o8eJ4AsZk9YGiYT3LN?=
 =?us-ascii?Q?wA8Rdd3nBwT1RA9OTJwWF9NCyDDXLVcv1/XbUXq6TkAQU3KgsfFC8VDAuR43?=
 =?us-ascii?Q?QKu2687VATUkxtpEvmwBY9ul/6IHJE4VlazEbZfrS1Dukb7Eu89gj/rVVMds?=
 =?us-ascii?Q?mnKFw2Cbo859bRjn5BTubqeKX9YC3Z8Zr4TX3ZVtxydNuY39bW2A1aNC3r3c?=
 =?us-ascii?Q?AHFn2DL8/oUTRxz5dqkCSJipAjh9rDJ541toIETh7hRc0DR6YNwl9ohrZdIt?=
 =?us-ascii?Q?iBa+wdtPr7u0LahpcW33RwSd/m4om9lx7Bag6XkyoymeKPgGOqDHr5rcQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: tK1xZnp4er3AY3pyX32hgiNK+OeDiWIrbTQ+0SxrYvZ6Ls76umZBFFkprxNBLbMyHZqmA2HIVJQFkaCsjxZ9hzN1jupBFG1LYFzm0/KLvrPlbDaTwG386t5aK4yApc+kY07eFybSdz5/5aKVLCBeVhLOP/4ejGjhPzW+zqz24bwCfk2q/bewaC79PhvP1e1/
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1076;6:LfPHWHQoAr1Yw9j3VIJV3hEsUdE9c2kYKuxwLVRKnfjF4EmxNgIlkA92v67xx5yDTz7row7rPWDsvLyJA/ZKiyaM2NsV0+yVaNxvLPVBsb0wxXGY3Fk+32PXAosfqmTV4dtPNI8LOiSuY1jZ3y3Vdkcb9MeDUpYOh16xxRxX5RW2AOAlEW/Ynzanvu8GW9Cj3dL9RPCcSg3S9W0cqe9adpwvDAYXI3SPyGP/c7XpAIEQeP/QV4p/YiBKa0Lj86j/rJdBu5V4TDAJk5M5zOfvLfD0y6LEdl6QT1VY/7g7prCGTxkg4gIUY4XETImKRloUfUOjbAC+IMd3N6G7CqcML13KuIuGBHZxZV1s52rk3y4=;5:4+2eCM+R11kBtq/63ERzcp6bgtn6yz5yhWQdkywm6zJS4ndZqyVY55JsfxxqGxbBLpTG5HryixjZXjUqGnJgJywU4lBFPJTSkhRAurqJnVLNxSygzNQuaWjpERSg2FADmMQPS4t7KI3aEGagX7a3iTTMlVR5icrz5Yn6LGGkWs8=;24:UgqpnnRV1B1bj1aM85uMCO82mWBS6PisR4YRPqGCMwz6ExnVb4+cLcCw0oaGd+rgAgNo9Lg71MXuT59qOZegWz9UJ04/3aQMsFM6iNIhHFg=;7:5Z1XWj7WLmJkbSBRAdNFhpMJviWFJSYKAtnf95KMvy6raiJVVzsjcOrpbHQhIgIVZ/uDmiBtKREab3BO2b25Dh6MYmqo+YHABoBV989nwYF24pTVEmsbvoi16ZCCoYN6A88V9pIYUAbPBFWfOiG1YZCj2ySqVCxVIemVjcakVLzc8A6LPOrSg1Hv3ZBJPOJCdMs5EIvWdonisUSim0Yn2OvyfiRJiusiXUxDzTCctlZlpXMONtXaWvcerT4rxk9b
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1076;20:a5xHMUWA7GX2Kiu2MX5U5DfRhV/W6j1Kd5+cZZR1LiUexQe0RArP6a6ya5wrkguU/S4WJ6SwgIo+qwpIAkP8QLWwPbN6vLr/lfR7ydaCUMNrSMF1I9GHGE0UAdxqglkmiwui6iKhnQcozA4N6wJRwGdouCKOCYOi12BX081bvcw=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2018 13:38:08.5199 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53a82108-a68b-46dd-f605-08d5829e55e0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR15MB1076
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-05_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adjusts /proc/meminfo MemAvailable calculation
by adding the amount of indirectly reclaimable memory
(rounded to the PAGE_SIZE).

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: kernel-team@fb.com
---
 mm/page_alloc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2836bc9e0999..2247cda9e94e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4695,6 +4695,13 @@ long si_mem_available(void)
 		     min(global_node_page_state(NR_SLAB_RECLAIMABLE) / 2,
 			 wmark_low);
 
+	/*
+	 * Part of the kernel memory, which can be released under memory
+	 * pressure.
+	 */
+	available += global_node_page_state(NR_INDIRECTLY_RECLAIMABLE_BYTES) >>
+		PAGE_SHIFT;
+
 	if (available < 0)
 		available = 0;
 	return available;
-- 
2.14.3
