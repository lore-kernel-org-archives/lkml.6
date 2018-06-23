Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54550C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 07:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC5ED24B4F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 07:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="a3rj34yk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC5ED24B4F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=caviumnetworks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751605AbeFWHff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 03:35:35 -0400
Received: from mail-bl2nam02on0062.outbound.protection.outlook.com ([104.47.38.62]:5237
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751537AbeFWHfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 03:35:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7m6/trLI3Mdrj6dyJBDfuDyPuGK9qBvqhtuR7tDqTzA=;
 b=a3rj34ykMX43Ir5LIaEkrNnczX3kfn6mMiYLQuc0MS57+ZLuS3awgb3un6TF00h6wrNTfcX3AM4ECioJK+FQxU1cYajOvNxOIGbCnsDjFeR+f/Sckfmt+kk9FTL+Fl493odh+fGI1ZlgFfqw6hKziimufNC7oJl7aobgRhAr/Rw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com; 
Received: from localhost (50.233.148.156) by
 BN7PR07MB4370.namprd07.prod.outlook.com (2603:10b6:406:b5::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.19; Sat, 23 Jun 2018 07:35:26 +0000
From:   Yury Norov <ynorov@caviumnetworks.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        David Ahern <dsahern@gmail.com>,
        David Carrillo-Cisneros <davidcc@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>, linux-kernel@vger.kernel.org
Cc:     Yury Norov <ynorov@caviumnetworks.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 1/2] perf: drop unneeded bitmap_zero() in util/header.c
Date:   Sat, 23 Jun 2018 10:35:01 +0300
Message-Id: <20180623073502.16321-1-ynorov@caviumnetworks.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: AM5PR0701CA0024.eurprd07.prod.outlook.com
 (2603:10a6:203:51::34) To BN7PR07MB4370.namprd07.prod.outlook.com
 (2603:10b6:406:b5::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81ffdb32-4f55-443f-033d-08d5d8dbe535
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR07MB4370;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4370;3:dvcrT3sNkbVUtyhuaTyiAOSi14wbOjZuLsud8GhGL45NwSeghjPCoNF5ZKhMbyKjJ+5tGYR2GWm/zA5pj8TzN1gULmdHIYL275wQt3sYlJvhLOQm66ILlgJBy3FD6Utz7ibanP/fdSm88QKBYrIGhBil3/BB8zs5fdI2aDIvcNfnCr6dyYu2Uvx0OafaGlYwGy1xGTVm2doWoc6gOQtAUIUGyEii2xnpEJ4u/GFIP+/AH9VPhBdBpjlu7dMG5ssM;25:BMDCWkblFU11Q4wQWOOcIdzn/f0AlkDR0kAOxXAX0hWr2Nn2v1MPsbmm9sCPh6vCprH4qzxVRwDyxVeE3zBEEDwjDA36JCxViU8FkRwK7gWbnqFAngSJEUhAxSMq3+bA+GqeM+KH6ZFcr3IOcmc1+o4TXeI4cEQjRPztwGyXsuvJ2xC97qYHk6qUXw6yUJFj1SSTq5PyknOPkZWEBOBOhXHie0GzyeSZmO4GXTI8FLHYjioRmTziPEowoPTuLc8YBQk1Sm2cSE6MqtqhAewbOfYapU/fgMhepOLpnO75v/hKT6GtDsoA35pvfnasNq3QmDwSl0PUosZxOjhL8m2gbw==;31:iMofY2/zr8z83F2A+Gemknum/2fpZkCLmuYYEhdiHFFUC5ZOHDdgfbUYVYLLIoFQ/HKmH+oP/6zHUdnsqTTeiDjNrcSLJQuzNjwJEiD/xt4spGLtHB3xbdOmGEHgHa50xOBD5HQMnXLFG3vqfBwk5AUB9J4uDmQQTMeQ2m7fh+ZFETHsSvRnz3cyN09tNRXC2jRMheaK6eAdDGHnCefsmN/jSU9FqY9MzsfzscE8qwU=
X-MS-TrafficTypeDiagnostic: BN7PR07MB4370:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4370;20:MMj944jpU2nYH3kgokzJ91b5lPNYUBPReGbf3yrhZMFdl2VL20L/VKV/M/wRP0XsC4ANJ/5oZCff0yrPaeXLdVY2HA3wGooPmztNcnmC30rN183A2YI0EmtXkYWKjCqT69VYzqB7LKgUEljZ4fTyR8+yks2HF8ED9ti0d+LskCv1nDuUdznPyr2j8ZFhOReRIE9M3HWwvYabauBRPoES1IHum6CF6kADMdzJX4e/eXdMGLJ2QCVW3oDKArtnEGVQtBYodCSct5EztATzKemgAY/EgnrDZsuuMH5Rv+GBtH/d0VW4d3wdRVY813E0tfaJA9VAIP0jfrPCT8n8LciNsj+rZ/lDyJItks2tOVnT25NfYfZpwGVJw7aXEtL38p16yL6jPprXyETa5Z+CHqJtIoPfIOLiyNPEXZcVCIsMWcqGWFSW5hKuNlxbp9syJF0H27ttexcGMTwscLN5Z8zAPmSb70UXDQ7Fp8q5UjQR0fQiikiFkZkp355fNomhq+K7IqCder6AJvSRShaie4fe7hT5v+C+duTNFMhRGJqITgSZN66nJh3JMitoAw1I088y2fz/3o665QlF5WjppSu23Fm4QrxJF/ktxDPn0iRqZ0U=;4:I++qPCkGzJpDntcamPWH2iM3a7SA0H2Jl6gmAaarUn7zxW425Ogzqee09XIe/5AkJdXKIO0gdqz207wHs8AIW+d0sCc9hGGQ546FeRuydG0E/REvx9T4YXf4do7k7heRlxul/r9RWOPujHr6+p6s8tqs7iSROzhb90x8CFaiqzouZDFVxnvgA4K6AG4/2+9GWkOjXAHQHCkJfEMTFyxHGyotDafIjYJsoUS5fC04VUFOTiaYilKCSe7cIuNoSlOxXEhyRAInBqOFcxsthdp5qA==
X-Microsoft-Antispam-PRVS: <BN7PR07MB437059C82A42880028466251E3740@BN7PR07MB4370.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(3002001)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BN7PR07MB4370;BCL:0;PCL:0;RULEID:;SRVR:BN7PR07MB4370;
X-Forefront-PRVS: 07126E493C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(6069001)(39850400004)(346002)(396003)(376002)(366004)(39380400002)(189003)(199004)(36756003)(52116002)(386003)(186003)(16526019)(316002)(2906002)(7736002)(478600001)(6486002)(956004)(72206003)(5660300001)(2616005)(305945005)(7416002)(966005)(51416003)(48376002)(47776003)(50466002)(16586007)(6496006)(54906003)(105586002)(42882007)(26005)(106356001)(97736004)(110136005)(6666003)(66066001)(76506005)(3846002)(81166006)(68736007)(6306002)(53936002)(81156014)(476003)(8936002)(50226002)(25786009)(486006)(39060400002)(8676002)(4326008)(1076002)(6116002)(921003)(1121003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB4370;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR07MB4370;23:2DpQ9L9Q0isq3I+Ryev37woTRysNpZ4RDp+guLckG?=
 =?us-ascii?Q?oOBfFO+vbSYrgq1rdU2K/gn05YHeylVJwCEvCRxREtb88geahBMYZsUnke7J?=
 =?us-ascii?Q?AoacY0Tfq0NG+WAdOl3AwRxn8qFHJajqV4lBvlyVIIjzG89VnzgKt2yG0e2d?=
 =?us-ascii?Q?9eDlmKjGRCsadZsQQZmL+PyfbAsob5JszTn5hHjijSlzht5NVWtgkrxWItQB?=
 =?us-ascii?Q?DIRDiNrVQT/k1C+wmKKivgDifDdWJbOm68Cb1sH1lSGjtVieBz4LmM0EbznQ?=
 =?us-ascii?Q?Avhz3L/V+DaWFotWLUfsbW49bX17Do+J2rptE07C5D+Z0+vgfCW11+8JA28p?=
 =?us-ascii?Q?eRqHL8G93/SWRRxBEeap6PxE0nHK2EcWju548IHtYqh3HsoWzGtK3QDuZKSa?=
 =?us-ascii?Q?QOz5mteBdwCC76WQk1ife3Atz+QDrR1V02Hcc5XJasDt0eVbqkXq5A/rbcaq?=
 =?us-ascii?Q?9S/cThYbWL0lZvs9wn39IIJVku5f6rw/bvoG3Px2xV9Lf3oEoxum2P41wbpd?=
 =?us-ascii?Q?wu9z1sGzDKaGYheS9OdsJHLSiDPh044/OqnW6oPK2KQEzJVmn+a4h5PMIzbd?=
 =?us-ascii?Q?Hi8okVBfo/UL2o7IBqWw/uoUZrSzaWA75vOQD+S/6P35+Wwzo6uZkoC9S6mi?=
 =?us-ascii?Q?tpuYBkSDs/6v47niSZYgjgVVuQBeGtXoPz/cc98XsEEuKTDfHMLm6RGShOsW?=
 =?us-ascii?Q?CkhAoUijUcZsP4V4xlm0xajixU3hNP/EgP6P0aBvIG4Xj9loAuDSnABea0pH?=
 =?us-ascii?Q?n/UOU5924wVaEUFfGORp1Yv0I+05GGwi/1qkneMtaiHugZNqTFpvBzEPAigG?=
 =?us-ascii?Q?oHREy6p+t820SvQHGlMaC9ji+Bs7tP/iAsR5B2kYbge8qsTdkAsjZeaQ2ZuC?=
 =?us-ascii?Q?Blg0LdfOuDMPEQi+iwsFvDDf3KXdl5GrHmutVtfoRo17Dd+HvDAsTjxZHMRK?=
 =?us-ascii?Q?yTbEoAKJ5f5rJ8j5Qb41SC/1GQRZnjvST5iF3OEgo3pQEWsCrtKSGm7cS4pY?=
 =?us-ascii?Q?2i+th2wdXuVCqnt/g3Lz53xscg3zr71SyK5etUdYlhDNM0OLxpmqheysBviR?=
 =?us-ascii?Q?SOtgiD9bEXSRbLAHcX3rXIDqOtRhzLcd1fDKJrukGBCOKprOcgmHbW+4xvdt?=
 =?us-ascii?Q?56unmSKoCur680sMuEf5MvTWm8sHdfreVcqSuQ3WGr3tGmMZc9TsmCmj8x75?=
 =?us-ascii?Q?pTMHr1WTazWOOKHrMhT+l//vmKvhVoUVCpgjsJOgMRLjArDu3riiu8zd2hnO?=
 =?us-ascii?Q?rcKp6PwjEYg1L05zlqO9m3UYVCaMynll8vzCWBSbkhO5JIRTgvGCMlMFBy1t?=
 =?us-ascii?Q?DgiKKDSP9OCyXf5YMF5AI7498eHDUV4vfA44MDBagR4p9DNttmbi4doQhStl?=
 =?us-ascii?Q?JmQlKCjW+TYkYSnBynn5Za3RHyMtwpRoaeNEwMrpZZFSnELCriaOS/FgCVGX?=
 =?us-ascii?Q?y5lRL7eRg=3D=3D?=
X-Microsoft-Antispam-Message-Info: ghsGD67sfis03hIpZb6BEkB//Le6t0K//Av+BNEiru6U5NIMt0bdDo1AWomumo4IcWYmimMCjTKA5ffVbpOkOiAHupsOTKnaPgoO2+n6B+wKlD9Klbg5kLFTxZc8K12LCQWmuTM++B823sfBcVm2PbkvcVBquOe9MslBfe/ag/YAHDkSODtnA5NMtuotLhxjAKxtyZPk0T4Qijq+xoYUI2zksvmih3NigCPIGydXvU8T8j4rsMHbOnXipyHFwwhGoEW7DWXAJC1XEMaR+kqGVZ1ooj/sddIw+lPcwErOPwKtrBCUMXSFqu79pAAvsFbc7qyw84gL+SqHo1gm6p57IA==
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4370;6:mEtcLMOheijUfH3TjY66Dq7jgeFG5BrkkZtZ6d/RMPhAiqvWopbY7G2DORjGbC/cUAJkdbV/0KRACahM6XHwqo6hl7lsxsZhpPdgLfZ5sDHQx0UhalINmzBDW1THHoICfh6qJzn2UM9spMuAsJIMZdjDUBZZOnT+CTcuQV6zU3Kcd4YIM89+JS3XuctlyiV4/LLo/5xhwiX/R3p94uEMNsDw/FvKCkqDK2I/LiVM+nLv6DzLqlmrrdlZjYgdZO6upR42M+kg27ActPRU4tlK8omB+Z8vCxf55SZLXTK7/41sopRqWia0R+JqRhWv3OqRPssIMElhTqkxz4Fy6vm7+ywThIBBHpkUck3+GynXONygeewGcfGCWaaoY0R9pEhnVjPQtbC6uK2Aw85auJRXxhV7+5AVAYize90r7IYz1BOBwGrfNCpgHivFH5ma/LPulYazxyjhkayKaC5k63g1nA==;5:dh/hgteiFyCdrd1n/j0C6nSLcA32IMD7RLPuWIzI63FF6rIZgMFTEMD8HyAvh2pB7Zmtu1nroVbE9kreKGdXtWMPO5yEFlmwK+tcuml4dekROxou6kJr9EEAoyJ0XF4DZ2fTno+m7LMEvneHMeUJt17BVOhTX+2H0YBEX1Q8seE=;24:2H/3RyBDUqUZBXKHKuuRTDdkmwjzktdV8ZFOP4HRWUk/fJUvEoVK4+O9/z5RmPXZxxg2sr5rl1SfJ5H2tt4o+z69KRlLXYvjptCjj9UWEYQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4370;7:4lx/Gmghm4QuBqam/cRuWULKzhRqv3wKqF1abXmWGX5hP9lrDLNCDAdXKGDzDEjPG2U1HyfBrAYF6YxKIkzaE+Km76fSG8Q1gMy+wZXl5lpcvTxCRISo1oyPE9UE2zwYjA1ZXMa6JLHTmgEFlp9kVQmqgyNBZEdnq6zq25KGAQSsupdiP0EvdHafB/uIIxZJStDcazfN6AmGxVe3c3SjDL3X9cQ02loWD3cwQzbXDj8x4exLYQqjd43H7Bf6Pw5L
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2018 07:35:26.0700 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81ffdb32-4f55-443f-033d-08d5d8dbe535
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4370
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On top of next-20180622.

bitmap_zero() is called after bitmap_alloc() in perf code. But
bitmap_alloc() internally uses calloc() which guarantees that allocated
area is zeroed. So following bitmap_zero is unneeded. Drop it.

This happened because of confusing name for bitmap allocator. It
should has name bitmap_zalloc instead of bitmap_alloc. This series:
https://lkml.org/lkml/2018/6/18/841
introduces new API for bitmap allocations in kernel, and functions
there are named correctly. Following patch propogates the API to tools,
and fixes naming issue.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 tools/perf/tests/bitmap.c   | 2 --
 tools/perf/tests/mem2node.c | 5 +----
 tools/perf/util/header.c    | 3 ---
 3 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/tools/perf/tests/bitmap.c b/tools/perf/tests/bitmap.c
index 47bedf25ba69..96e7fc1ad3f9 100644
--- a/tools/perf/tests/bitmap.c
+++ b/tools/perf/tests/bitmap.c
@@ -16,8 +16,6 @@ static unsigned long *get_bitmap(const char *str, int nbits)
 	bm = bitmap_alloc(nbits);
 
 	if (map && bm) {
-		bitmap_zero(bm, nbits);
-
 		for (i = 0; i < map->nr; i++)
 			set_bit(map->map[i], bm);
 	}
diff --git a/tools/perf/tests/mem2node.c b/tools/perf/tests/mem2node.c
index 0c3c87f86e03..d8e3d49d3638 100644
--- a/tools/perf/tests/mem2node.c
+++ b/tools/perf/tests/mem2node.c
@@ -24,11 +24,8 @@ static unsigned long *get_bitmap(const char *str, int nbits)
 	bm = bitmap_alloc(nbits);
 
 	if (map && bm) {
-		bitmap_zero(bm, nbits);
-
-		for (i = 0; i < map->nr; i++) {
+		for (i = 0; i < map->nr; i++)
 			set_bit(map->map[i], bm);
-		}
 	}
 
 	if (map)
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 540cd2dcd3e7..3a6bec22baa3 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -279,8 +279,6 @@ static int do_read_bitmap(struct feat_fd *ff, unsigned long **pset, u64 *psize)
 	if (!set)
 		return -ENOMEM;
 
-	bitmap_zero(set, size);
-
 	p = (u64 *) set;
 
 	for (i = 0; (u64) i < BITS_TO_U64(size); i++) {
@@ -1285,7 +1283,6 @@ static int memory_node__read(struct memory_node *n, unsigned long idx)
 		return -ENOMEM;
 	}
 
-	bitmap_zero(n->set, size);
 	n->node = idx;
 	n->size = size;
 
-- 
2.17.1

