Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BABC43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 07:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A9524B4F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 07:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="SgJMPcO1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53A9524B4F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=caviumnetworks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751680AbeFWHgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 03:36:01 -0400
Received: from mail-sn1nam01on0076.outbound.protection.outlook.com ([104.47.32.76]:60723
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751652AbeFWHgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 03:36:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0uNZJcyhNqE9jCSOAH3PMLeVYAwhRN7al3fLUTmfSeU=;
 b=SgJMPcO1wSMU71eJTP0PzAq9otWZZ7GwecBzY0fHiRFSFvIIlOjKsrtxwOrQGULW80W2O4/a0kgXReaZOA1RH9qN4mO/EPBSTJf0cmqlH6EPh5GCPcCJB7e9y4Gjsg44ywZN1rWVBFKjb8YEQtcr1vtlxy4JYjgEiKz47LHqX6I=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com; 
Received: from localhost (50.233.148.156) by
 SN6PR07MB4382.namprd07.prod.outlook.com (2603:10b6:805:58::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.19; Sat, 23 Jun 2018 07:35:53 +0000
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
Subject: [PATCH 2/2] bitmap: sync tools with new bitmap allocation API
Date:   Sat, 23 Jun 2018 10:35:02 +0300
Message-Id: <20180623073502.16321-2-ynorov@caviumnetworks.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180623073502.16321-1-ynorov@caviumnetworks.com>
References: <20180623073502.16321-1-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: HE1PR06CA0141.eurprd06.prod.outlook.com
 (2603:10a6:7:16::28) To SN6PR07MB4382.namprd07.prod.outlook.com
 (2603:10b6:805:58::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ceb340c4-9031-483f-a385-08d5d8dbf5a0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB4382;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4382;3:z/QfJaaPtQs+Hbzw/bFFn3qHEePhUGaRHE2084/bwiO5sFlc4LGKHTOgrzO0zx1cEkBAxvT94q/JinRniAjpPh6WvBaOk+lsAzGugHS9OkxQ0LQMyihO+649l7hyQq0wLkQPVqczQUkQY5sv6KxLe7manX4lBu6AtoftDjvGEVXJGizzCkzWSmgf4/pNq815UWHcftOGakZvZWZRiFKynOq4rQgW+AyYlxWMMjG8hl9aSdbylTLvFBKZ8Fg8htig;25:Xl22K+5nQHNZfEjVZsemtOEg3X5LPmcnwV/bIYdDT0Y+rwR6PI1np+ySUuTYI50moEcVBHdUDmayhEvL4D7k3NBdiG0/JMuK9KtHLq3BRVrqE/39BycOneIofUE0arKTZldR+7eZ0VP0g+0I76GFvHeKutgyDCg5UN1xr89PFPAf/1QdHpTafoU3HrGmBVL33REX+M7J2yZv/3gOKHOA7O7Dz3locUEAXru6WSfsRGlf0bLbjWjRvd9xGiWDKoe1poulQu9nf4YUkExZAXvFOZYpiqE0HbJ/oFrbBPt/kQZKqfFnmgMH6D9RylBxQs44cRYKa/Oth89fWN1EM67j/g==;31:RPYZGeRN6mzGpWKzGThDU5Jqt0gpS5eQ3wFrXwJCuVxs+4BUZ/OVYTwJB476A/RQu8Dof1pdpMyHdXVg6QuNV73HNzE7Mwkm62/aUCTQ5C4ZEYkfcF6vd0QuB+wMIVX884ubYfQ+0rhDqSFi4uX1ETJeNiCalb8ddWco8efye5O4G55XlXS55wI889BqZthy09j+M+ek5jQVE9Yk2aUlsgMY+0IR47wc+tAqQbFJRpM=
X-MS-TrafficTypeDiagnostic: SN6PR07MB4382:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4382;20:XUogpQ5FvMrtGo7IemEsl4WLedFAb05roWeup6fK/QZShrHhdGeIw+YtvTdoz1jp5pBw5OUC+nzYuAcQj/BvYwDQh7xGOHOSA9gr96Ys6VvIrAVX6MSZdOL3OQ2ar8QTtR+qlOhs/ta/JhpYZ40pk/h2u61F/ufiwAePn9xR7XnOlJz4Dzb1yEiSGfrCv+HfNIXQIcFOO+0NXIX3jvxgP+GwhQJSCDf/osLMW0O8i7qGC05RZlpqcUQ35uXlqliA+NqhAQpt/Wkdu5l2O0CrGsjkKQVLs4rgA/XW+lS/v9euyomiI7drpjGpX4AusaFTgzc8c0hWkTtrldR+kCVu1bHH7Xy+xIaCVzENFp7GvhMJar2etus2WFspkpsdNG11Y3FzVaaaFsYE3UKm2SGH/MsXf6OHYWxLaVGCemVztJVmQBEumZjxScB/0i5Dea231BQwECN1BtBcoalWaTKQY+hDl7tCdjjDjz2Cac6TIYrqyHG0cPKTGXWakxuZy0ByuoNECmWZE5DnwDPBLEo/y0LSeuDPXLmZKdSP6hsgA/n1D42Vuf8esv2XVOrmYjfN7K44npu3CaUzbIXD4AdSHEbBW0B17aeDzHvlbP4zQP4=;4:izHew0B9oaQ3F9/rhI4DhBaUlVGg4XuwE6MH1CEV0971FdrJlYbPHNywLuvTkAx39vbhffs3zqmeAzYNJ+N1GXMnsWi31rM3DYj0qL9rQZavUQZDM2oX8rjUwRYUoTeQ+e+k/NmwR/FE84ZEClydDI3sDQOdLCn5IP4CsxbR6N5DMkVm0udruCkaUWV/eiRnNmqo+hHEmnE+mFJ6LlflGAKRKjqSi5VXPj9tRCUOqtNoNEzEcJJd8/gUtsc/7H9P7vSizpsIsDvhzoLu4KDiiw==
X-Microsoft-Antispam-PRVS: <SN6PR07MB43827711F3BED97B701EFCD9E3740@SN6PR07MB4382.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:SN6PR07MB4382;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB4382;
X-Forefront-PRVS: 07126E493C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(346002)(376002)(39850400004)(39380400002)(396003)(366004)(199004)(189003)(76506005)(478600001)(110136005)(97736004)(68736007)(72206003)(11346002)(2616005)(7736002)(956004)(476003)(446003)(50466002)(105586002)(6496006)(106356001)(305945005)(51416003)(6666003)(52116002)(3846002)(6116002)(966005)(316002)(76176011)(39060400002)(54906003)(4326008)(16586007)(53936002)(6486002)(81156014)(486006)(16526019)(42882007)(186003)(50226002)(25786009)(8676002)(6306002)(386003)(26005)(2906002)(48376002)(36756003)(8936002)(1076002)(7416002)(5660300001)(81166006)(66066001)(47776003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4382;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR07MB4382;23:iptOHEIHv7ZHPcHYTdFiYu62+N5T/sHNhFqxLa9uD?=
 =?us-ascii?Q?39SW2XYc6qxwaMISnxHRvhbTVVc/zRnPad/7aEjaCqD2vZvGRadvwK6ciIgk?=
 =?us-ascii?Q?9G57DLzAoulD7XzGj/tspfev+VxXBV4thU7YtWCOqVk6XvxZKFZUf7W9XTuz?=
 =?us-ascii?Q?r9gytFecv5n07ac259rzHbwuv3y3+8ls1HrDZ3j2CF97JAXEJ38uNDUIbK05?=
 =?us-ascii?Q?Eb/Slo4jeAVavcbbuJP7ZN0Do1eOVktUQPF+Ydbro0ojIDOTMryjjDQP0lJ6?=
 =?us-ascii?Q?QZ6E2FXA4v0H96IvlaVjLpsRvRfLUjrWgJfWGEtun5W7sbTLv8pMbggnRe19?=
 =?us-ascii?Q?u8akGcErJhbPM0SoedgVN/O+xQuCVhB1gut79+uNcHyPdjMtfThTQgJQORsr?=
 =?us-ascii?Q?ZQg5btxqH5Z1J0ni0VP0FQe5lX9Pe4fDgor/cKN85JieVI/reAhxXtthucVW?=
 =?us-ascii?Q?6IJckWvaq5bPgXvtoPSZFlI2fLU6OeYajI1+LV6ApR1tP0sz5rSzlcVkcoCM?=
 =?us-ascii?Q?8duNuGvFUqVTOlohUVuRBwtVxnq+nghMsjSpLdjTqQ5OR4XUs7mQPgUCdI/p?=
 =?us-ascii?Q?P2GsSXgQA1cnDXjEe/3nldGvlyDBvpETToUMy1WXxlWlD3weTZ1PSIPDXHKL?=
 =?us-ascii?Q?cxx9lbHF5yF7matSGqXr/WZbYbIetLr6pbGq+xk6lq0dRmcSoN2kOydCPZXw?=
 =?us-ascii?Q?4Gxe2oPmf5U+gD3BK53LE+bmlsJLksdd0GKKbdwY0dWW8fGEMQD9VltLSRcp?=
 =?us-ascii?Q?5ft20y5Y0NJAlNLXuKZemmWzR4Dyn8fso2lXvEHBwvOhGINUWRY2ARWdTTZ+?=
 =?us-ascii?Q?3hQy+odNp5Wx7MjXEQ63FVVt6fX9txnOZxxYEQFmPWD+KTOiS/jsFkiF34/H?=
 =?us-ascii?Q?2AQV6kY8aeqM153k8nbv8o4dHrd46AT6HS4g6cfbgI6pU331Z0j171Ao8pOv?=
 =?us-ascii?Q?e6FstLN5nEZYKoZLkn8cIUOjnsBwcsizYBPZAB3faBrip4zxsSDMCGIKhAu0?=
 =?us-ascii?Q?zDIGKo/P+0jHCvAfNxxliepxrZeuexwWqLsE80+HLSJHVcP6DLE2CL6KIWHD?=
 =?us-ascii?Q?Dr0/4qAazqVekxke4FRwv4fOyRQ47fGvGKilhcXs0tPN/S94CaXJqRKospGG?=
 =?us-ascii?Q?kpQ4rImL8oCBzDRwDzlbfbomg9WbG7fvNHbZqGiYQBBk3b4oj9DjYr5ANoMC?=
 =?us-ascii?Q?fkVz/IxW00xeqlK1n+nvlH4fYRI0S6Cl+TRieEhb0+9AckI9tqxS5niP2wBF?=
 =?us-ascii?Q?WLPLKP9dR716FrLQlTwoMsVgjDGZ5bNIGVmLN3LV+TiAD9sg3N75ccn7cbPj?=
 =?us-ascii?Q?/uX67xJ6Umy6ctwCeTQf9J3r8QNCvValorFd+zmzL/vrJZaSrFjKmag0xyGq?=
 =?us-ascii?Q?fz6auzX21C9Qz57Ld0WmHhmkNM=3D?=
X-Microsoft-Antispam-Message-Info: XXUDV0bZOefpVDNg/rVH4BDKQNCDINgwiIZN3w+W1emoFq8TQxLj+n3Rnn+orE1dR/D/ywOnwGukBw6+6HAGIYLOa2JuqBfzqJZeGsSzekKT66RPTnUjUNbZ+eRQlQAVmaATxf84KywnVFyGImyCZQbK3L54hhEC5dHAJ1n8gog1dTkLmN5MIDutMT+qOtSXdgLBuoUMutTJaGWUSU038mODj8CYhQzPEHBQoMfH6OcZSvh+JQMSTi+FV69levc6JgRvEC/3Db/wKAsgYL8Lj5V4RUhneP0K9X8mriaXFArd/PYyeqPOFP1+o2iKrT3b6+Q/5pBhiQaPnsLvGMRiA9OKat/Q1iJAHo3Js8h2zdQ=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4382;6:Nm0q/AfiIkX8OSDYce/DbeCXHUz2qF+OV+zyPJnMxAOmclOOISPtHZJvcz5cUYrvbt6GP4Dd07BSBQlYUXZ00Sfza2lspYyByru20mvogbFpvwjRHstI7Qyf9W0qmRJAcRZ3Po/vWJEwFrPmIWfvvxA9IHHgjYosVXDTZ1ayiM3r9ooiTTLDfRf6sp/3vcbwlFso02eMJyCo5P0BUVhXt1JzgAHayaKAmYEgnm6P5cZt9MYjWvW9hoXne/CPBdZqsZhJpiZNzAT5Du3xmwrMo22Mr6bG183fdYW80Mmkak0cf8lgMT2cnihpM4sAFm/e0T6OwHSaeHxb/pE37iN73E2LwhvXE/WgMVPJIyEOlA8sLlTLmiiUHX/EDa5SBuzzYJ3pxmM8tfHuVsz5KNUmBXE6VDaycg6IPENc/Fdw6vHthHgKTOJDxSJL4HyBttSrSktPfKI7fYeJU2/vRJPgvg==;5:+iAwtmil4CjoEu7AJPPxucbisjbV/7JKNJEPBhVVusOv0cPdhJI8hnP/7cPAlnUn4rlkUwVgzF9/1nvDwJRRoBVUWJx2qozy9ih927a36nDAzgt3ydqblsJ+fmBX241tugUriS36n00vqa3HnbIs0JJPpZAykW3GEdBjyCnXe2Y=;24:6IexgNfrGPVuJw4NDi/JEOmbhgvctg05QDB9ZNPUp/LArma5Vtg79WXWcl1OF5jr9ZI9YRXv++7qSrs8r+Xp1r/3JwhbdSz24rAbjaZhPx8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4382;7:c2e48tX7PHesr5u+rfWQ4io3/Abm5jrY7F6yX+qzomQH3l4EAvhVq1CuLXtVmGZqIVc3qVj7FOEQqiNJ5CMkOtMs08EJISNw2m+RsS5FKkuXkUE/hzGM+jIURU58l1cTW7jucn2t8NDqCLM+R0sh3Y++GkJRsSfCutzeUQS5HvuoNXkvgKNsmZwyaDEKXuXjPYeB8xas1IHOTyjBw0F+w6Ig0UqKIQJC23lXacG3HVBrul2Vp1fumS9hdNjqeAPH
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2018 07:35:53.3318 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ceb340c4-9031-483f-a385-08d5d8dbf5a0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4382
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On top of next-20180622 and Andy Shevchenko series:
https://lkml.org/lkml/2018/6/18/841

The series mentioned above introduces helpers for bitmap allocation.
tools/ has its own bitmap_alloc() which differs from bitmap_alloc()
proposed in new kernel API, and is equivalent to bitmap_zalloc().
In this series tools is switched to new API.

This is RFC because I didn't find counterpart free() call to some
bitmap_zalloc()'s. So I didn't convert them to bitmap_free(). Could
someone point me out? The functions are:
setup_nodes();
do_read_bitmap(); // Free is called, but only in fail path.
memory_node__read();

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 tools/include/linux/bitmap.h | 19 +++++++++++++++----
 tools/perf/builtin-c2c.c     | 10 +++++-----
 tools/perf/tests/bitmap.c    |  4 ++--
 tools/perf/tests/mem2node.c  |  4 ++--
 tools/perf/util/header.c     |  6 +++---
 5 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
index 48c208437bbd..b9b85b94c937 100644
--- a/tools/include/linux/bitmap.h
+++ b/tools/include/linux/bitmap.h
@@ -98,12 +98,23 @@ static inline int test_and_set_bit(int nr, unsigned long *addr)
 }
 
 /**
- * bitmap_alloc - Allocate bitmap
- * @nbits: Number of bits
+ * Allocation and deallocation of bitmap.
  */
-static inline unsigned long *bitmap_alloc(int nbits)
+static inline unsigned long *bitmap_alloc(unsigned int nbits, gfp_t flags)
 {
-	return calloc(1, BITS_TO_LONGS(nbits) * sizeof(unsigned long));
+	(void) flags;
+	return malloc(BITS_TO_LONGS(nbits) * sizeof(unsigned long));
+}
+
+static inline unsigned long *bitmap_zalloc(unsigned int nbits, gfp_t flags)
+{
+	(void) flags;
+	return calloc(BITS_TO_LONGS(nbits), sizeof(unsigned long));
+}
+
+static inline void bitmap_free(const unsigned long *bitmap)
+{
+	free((unsigned long *)bitmap);
 }
 
 /*
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 6a8738f7ead3..d747e98bc37d 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -127,11 +127,11 @@ static void *c2c_he_zalloc(size_t size)
 	if (!c2c_he)
 		return NULL;
 
-	c2c_he->cpuset = bitmap_alloc(c2c.cpus_cnt);
+	c2c_he->cpuset = bitmap_zalloc(c2c.cpus_cnt, 0);
 	if (!c2c_he->cpuset)
 		return NULL;
 
-	c2c_he->nodeset = bitmap_alloc(c2c.nodes_cnt);
+	c2c_he->nodeset = bitmap_zalloc(c2c.nodes_cnt, 0);
 	if (!c2c_he->nodeset)
 		return NULL;
 
@@ -156,8 +156,8 @@ static void c2c_he_free(void *he)
 		free(c2c_he->hists);
 	}
 
-	free(c2c_he->cpuset);
-	free(c2c_he->nodeset);
+	bitmap_free(c2c_he->cpuset);
+	bitmap_free(c2c_he->nodeset);
 	free(c2c_he->nodestr);
 	free(c2c_he->node_stats);
 	free(c2c_he);
@@ -2051,7 +2051,7 @@ static int setup_nodes(struct perf_session *session)
 		struct cpu_map *map = n[node].map;
 		unsigned long *set;
 
-		set = bitmap_alloc(c2c.cpus_cnt);
+		set = bitmap_zalloc(c2c.cpus_cnt, 0);
 		if (!set)
 			return -ENOMEM;
 
diff --git a/tools/perf/tests/bitmap.c b/tools/perf/tests/bitmap.c
index 96e7fc1ad3f9..a35d44ad54bc 100644
--- a/tools/perf/tests/bitmap.c
+++ b/tools/perf/tests/bitmap.c
@@ -13,7 +13,7 @@ static unsigned long *get_bitmap(const char *str, int nbits)
 	unsigned long *bm = NULL;
 	int i;
 
-	bm = bitmap_alloc(nbits);
+	bm = bitmap_zalloc(nbits, 0);
 
 	if (map && bm) {
 		for (i = 0; i < map->nr; i++)
@@ -35,7 +35,7 @@ static int test_bitmap(const char *str)
 	pr_debug("bitmap: %s\n", buf);
 
 	ret = !strcmp(buf, str);
-	free(bm);
+	bitmap_free(bm);
 	return ret;
 }
 
diff --git a/tools/perf/tests/mem2node.c b/tools/perf/tests/mem2node.c
index d8e3d49d3638..81a9b05dc632 100644
--- a/tools/perf/tests/mem2node.c
+++ b/tools/perf/tests/mem2node.c
@@ -21,7 +21,7 @@ static unsigned long *get_bitmap(const char *str, int nbits)
 	unsigned long *bm = NULL;
 	int i;
 
-	bm = bitmap_alloc(nbits);
+	bm = bitmap_zalloc(nbits, 0);
 
 	if (map && bm) {
 		for (i = 0; i < map->nr; i++)
@@ -65,7 +65,7 @@ int test__mem2node(struct test *t __maybe_unused, int subtest __maybe_unused)
 	T("failed: mem2node__node", -1 == mem2node__node(&map, 0x1050));
 
 	for (i = 0; i < ARRAY_SIZE(nodes); i++)
-		free(nodes[i].set);
+		bitmap_free(nodes[i].set);
 
 	mem2node__exit(&map);
 	return 0;
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 3a6bec22baa3..201c91db95df 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -275,7 +275,7 @@ static int do_read_bitmap(struct feat_fd *ff, unsigned long **pset, u64 *psize)
 	if (ret)
 		return ret;
 
-	set = bitmap_alloc(size);
+	set = bitmap_zalloc(size, 0);
 	if (!set)
 		return -ENOMEM;
 
@@ -284,7 +284,7 @@ static int do_read_bitmap(struct feat_fd *ff, unsigned long **pset, u64 *psize)
 	for (i = 0; (u64) i < BITS_TO_U64(size); i++) {
 		ret = do_read_u64(ff, p + i);
 		if (ret < 0) {
-			free(set);
+			bitmap_free(set);
 			return ret;
 		}
 	}
@@ -1277,7 +1277,7 @@ static int memory_node__read(struct memory_node *n, unsigned long idx)
 
 	size++;
 
-	n->set = bitmap_alloc(size);
+	n->set = bitmap_zalloc(size, 0);
 	if (!n->set) {
 		closedir(dir);
 		return -ENOMEM;
-- 
2.17.1

