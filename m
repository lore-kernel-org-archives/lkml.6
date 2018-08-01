Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4DAC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BAFE20844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="ONlD6GGC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BAFE20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388718AbeHAKWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 06:22:44 -0400
Received: from mail-eopbgr60106.outbound.protection.outlook.com ([40.107.6.106]:58905
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387708AbeHAKWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 06:22:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYIrdYRvWRhUh6Qdq38QybufKjf9UGSZJxswSMDuNoU=;
 b=ONlD6GGCllWb/2kXY7FU9qsOCszqLK2ZmBvqbTVavSXJcLoKxG54Q2zi8Yj45htY/htDiVRlrQh4uAS01ckZa0K+8CXVEFaQQz4Ng1CjTsxWWf2ZsKUoV15v/6iB3fUQaVFqIS/gVz8nA7pFQxLwAjTUt4NcHLQHqVAziSYMzcI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from orc.pedanet (85.226.244.23) by
 VI1PR0201MB2461.eurprd02.prod.outlook.com (2603:10a6:800:54::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.21; Wed, 1 Aug
 2018 08:38:01 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Peter Rosin <peda@axentia.se>,
        Mircea Caprioru <mircea.caprioru@analog.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/2] mux: new driver for ADGS1408/1409
Date:   Wed,  1 Aug 2018 10:37:38 +0200
Message-Id: <20180801083740.29859-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: AM5PR0202CA0018.eurprd02.prod.outlook.com
 (2603:10a6:203:69::28) To VI1PR0201MB2461.eurprd02.prod.outlook.com
 (2603:10a6:800:54::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d12b9ec-ef5e-4f79-4837-08d5f78a1787
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600074)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2461;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2461;3:SqvRGsI1pwKULnhiSRGNa5REc3+zQMMnwOHH686MT7SaJecBqNVKc5CldtrDZuZ/EMvfFezawJtsZrvd5+QqCEI4RSOZK4rfgZsXhN2rIKSyplei6Ybd6SgIlltROBu5U5lfgL5b2Yr4JfwH+Ok2EDZpz4tTIpvtzBZAVtCe8wfjF55PpAUVWORFPP5/1aOSglBOG7BZFe1evwqWN7oSAIKohUHC3DbODeFbC1B2Uq3ykR6E6r0CnJj/1Hc9tbZY;25:/V9U3oFspYCYeMYaJRVTUitimquZbLdDSVn3PZL+skpz9dLEvuOPh39YKpmr9A7rPcJL+vhhX3UUzhxURf/pWuS4Il6+9COLc+8hzdlNZC1O8oQh/N8ZosAkZ9bLHH4xe5PZ/Vp3EryD+W+ghgAISpaM+C1rbgHB2ONcW325T0k2BUCY4giAqFLUvsM3Rv/l06QWKk8kaZp5sd+OVpXV8/Dyej5pDsdaIjxhBSu8Z7j0AkZlFXBYzKrWLudBFU6SXcgPjgyq7gcBzWENTGrWnOIW8rO/sDppwU22WYNDZnTlgecqZ5M4o3qqaQbgKn9Xhk3JL8DBwBgMwhOjX/ARZw==;31:kUs1LSzPFDYVdIKtEEZExLRLRqtou4on5Siw+y931FdzlMEcJa4l/RDkXLOXAhcqQItSK/2K4//t6zY4QG4i2Ij+7OzWJ607Yq2HOctF+YcC+Ts/ds4mSZjpOXGf3Cswrn4K1pgjW5sEbFNwfHhRJOAVfRR8n726CJH3JulaFyuV3ZkbboPFPiXEzL9g5AEjPLlfdOLqm6z8IBhPshpNkU1evdk0lmkTSL5hsOg+wTk=
X-MS-TrafficTypeDiagnostic: VI1PR0201MB2461:
X-Microsoft-Antispam-PRVS: <VI1PR0201MB24613FD006BC1DABD42209AFBC2D0@VI1PR0201MB2461.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(4782527817362);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(2016111802025)(20161123564045)(6043046)(6072148)(201708071742011)(7699016);SRVR:VI1PR0201MB2461;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB2461;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2461;4:gyBtinI2t0RZgeHxbABTMnNtYihXLx7x0b4uQqaFUn+ooAqdO2dnWeMK0rNsJ6iHlX4cbzL9/SZ+32vZ4ATzlmItweKe9lTkc71+3BoCsVyyDkon3FCBMz3TPLab1HdI5wzIQe/2nCdo/usQ+37wasCA4IwTGLsdQMessXXOxQU78kNKFcmkHo7W821Uy8ADvI7SWGVPQI9rO0FjPQQ/DT4DGe3vJEPle8HbsleGVzqK7Szgv6IvqUndQ31aegmWJlcUszi3AjvS+RWgGs64EeDVvOe7dint9lwVUyeZTI7AkUQ2A/bzoUSz10GsA0vk
X-Forefront-PRVS: 0751474A44
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39830400003)(396003)(376002)(136003)(366004)(346002)(189003)(52314003)(199004)(1076002)(51416003)(7736002)(81166006)(53936002)(97736004)(6306002)(36756003)(66066001)(106356001)(105586002)(6512007)(81156014)(47776003)(2906002)(26005)(305945005)(25786009)(4326008)(74482002)(52116002)(8676002)(966005)(3846002)(956004)(54906003)(6116002)(476003)(486006)(48376002)(2616005)(16586007)(50466002)(6666003)(6916009)(68736007)(86362001)(6486002)(186003)(16526019)(5660300001)(6506007)(8936002)(386003)(478600001)(50226002)(316002)(14444005)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB2461;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0201MB2461;23:reDxAuEFi5FzikJ1r3N5UVAAdJN2ZkHmsnCo3SP?=
 =?us-ascii?Q?azN8uSnHk06v4QAaYtnNR+uyjk46GYVp5wEu4HVk8H6+Z1OFzqyM8PHz1pLV?=
 =?us-ascii?Q?G7A/Ykao3Z4hGqJOxgBSzNlMbS6sMDMhl+cocQ29Pn5CPaMKeo/HyPzTd6xs?=
 =?us-ascii?Q?wh52ijWGeIKZoBzpuijZS/pYQn9M6H/vojrlT0nsfAY3u1o2ulnCiAah5XgD?=
 =?us-ascii?Q?z1IOpNg590wHCpNy9oSWyZ1JU09g+OM5lXxq0Kkj4ewQcVCdj0tec81tf9Po?=
 =?us-ascii?Q?zJ7JJQE09S+mz1bd8jcG8n7wdUBCMnrnT4M0IadekeRMi9kn1qzNzhyw3IyD?=
 =?us-ascii?Q?QZewMHtpg0m+mICG0rxIOj9TKep6x9+4+11y7+N14TA07bAzEQ48hk6p4eiP?=
 =?us-ascii?Q?wW1MZtmV2+vE9Hj8EIr1zwmunu3BVveZSnJi4iOYTlkd9WHq1qFh/NrfaGjY?=
 =?us-ascii?Q?rXrlcWQY0qrqioWuRaaX+LdUR0jG9I48Z0Ivxc4ygwnp44xZ5ufZqzybLW1n?=
 =?us-ascii?Q?Cm3H8ogD6JNh0oSonSaCQgLxZQolbtUBaQVw8+rNGK6vLkTJKNOY92Wr2Q7Z?=
 =?us-ascii?Q?TjUiPM/8xqISXZrWfJ1+56jUns/nLY7+VpvfmSVMdna2aQx7So1nwWbt9N33?=
 =?us-ascii?Q?opu/Uq86A46QT0DMGr8SbJe2jdPEvIcoJXh8djj7LGI8pmzyLGzdjrz0sP6z?=
 =?us-ascii?Q?VsY5FJoBLExtQILKtX9lfpBcq3nnJnRk4T49m22WzqbSyhhAjjtO+72EcYa9?=
 =?us-ascii?Q?Y4bHhFtsfUJVYGzxEAt5HhkFKRmdCt1QRlcdTLy5KVVrg02XZ3hkpMIQhw0G?=
 =?us-ascii?Q?dZiwT8svBdk8gL08mzrNCAuMrE4neFNLWZ0pOe7Mr9z6Bu1sfk4/gTc7eGX7?=
 =?us-ascii?Q?XaqCKgJ6MZWhRObwrYca6PW65KycgjguKk5Hs00eLTaQ+hGSmbMglOnmTQ5W?=
 =?us-ascii?Q?GzeDPSLYhASUPYFjFu1IcD5uuUSur+wk6xOcteRz++GoNuobESFPIr+oyMWp?=
 =?us-ascii?Q?sqZ3pin6ucw3AtCqrqckQZ/kWVa43EADxWtmx+Dc7ZKknzMR4m6IehNnR2/P?=
 =?us-ascii?Q?rleltunw0MMTcVuVi0FDlvT347/SJoF/feA3GuPVVKU43Gd05/T5xOHy18/2?=
 =?us-ascii?Q?5mDCy4bo4WsiCLtSGJOo50oN8NkYwS3DYfbx/TXK1m9e6BcPXARabHHwLg6/?=
 =?us-ascii?Q?jLTxFv3wKHvkUWRgQuVKs5RvN7zJYo3UdZ57ltNn2Q9Q4gE9sIzxpk1Ccnqw?=
 =?us-ascii?Q?stG1OOFKaPpzpXIIXKkNovktgpKUhsHOEEfo+gKVs?=
X-Microsoft-Antispam-Message-Info: wWmi1sAu05xKAfTDuGnRYznNOkIdHkl+0zgdNNah/Qu8rP+Wjono0/ZldUm9QOUuyZcbWYIDApqaLGX2jYsnet1/Je7GgAGWPxCpXxBAWIA1hHBmUSYS1ZUV1PwAHLPz2kYqkoySQHcqejQDAGxnTR/84GtkPiqwE8ZiKXveKkWkwn20Yp582O19kCyM8W5hjfKM35KMYUyttyl97YfT3I8x5DRSYUWG8svtjPmMPIM9/atqijsRCQHHUCE2Ai6cVzhwv1tT//xS9hAS/orhbESX4b0ZRCmZaifT464VP2yrlzV6SJsRzyclsrfmkmmVgjNrnA1tfYHTuMwMPGrEb5s/XVjvw740lyxzzXEp1NM=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2461;6:ZEdO7gJvj0NefB9QbBN+DxQymtPIRfbEt5KkQ1LWudNUYht+v38ncXA6LyEu60SHx1Kaf+1ITCeBYcbKI6Up3IBEazLgv9BkDgzqZ1r5DwgxUM/7xmE26k4ZzAaC0EfoC5Z9FEnovo/hIdtKszUhyXjVLoUwqNfSe9dpFaEIWnWNyxfKeNwbcHhX+gpIycaRdN1OCCT9Qs0LJZFs5uKgXeQaoldwL8Q+WGMTeof3f1oOjJpFvc1dmHezq+4zpap9m59ypwghkzDV+FHez4pJL4H/BnmzXYlNfcsF1tMjz4OaOfSyeMkPdR6ZBubitvFnc8V6w1nkMPP4Rpwj2ksMNN3+qV8LlajcsxleQo/gjuigXZhlnKLri2R2L3YKUKcaIEXoITz+pcoKks9IsxpZADnRulzev1qHXunEOxzF4598L2TCblY+cnzj7wybQsAXkSqOUHHweLJpL3wqvu6UFQ==;5:Mgm4xexJQ+iXQVpqzAW0l5q4FJMHXHJRm3FM2/Sh//J8y5glZz00ZAVl4GRiQ6uoK5EFQOPWUH8vk/a23wVGDQ70nmpBNzTBAsS2jwiunqkfRv4VjQENe/21W5J6fZ8VqYicvS64bLJEKerNWqdz7gK3qNKzjewldbNS21kByvc=;7:vDN4DaLzXoTQ7Wspg1VfFtpm50D0KeuiXUy61wuGkPWhEbd77vsiJ3kDVtg5oHvpkh+xDVk3Hm6z+Ok3boLJAfaoMVpFy9CH+8OBT4i/jom4BaSaov+ptGX4IEU4O57qJ0kGvenyqzZfpeRjjE5OqVr9yGt/Nj5IpGzVSuiD+MvgVzHTv5IIDvFCOMGXLkp216aBwv44IpL+eeaOCJP/vg8aI5Li7D0jqwRcw+QOmR9U58tR+Z0WCKplOyzk/gfA
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 08:38:01.2113 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d12b9ec-ef5e-4f79-4837-08d5f78a1787
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2461
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here's a new mux driver for v4.19-rc1. It's been in -next for a
couple of days, and the risk is low since it is a completely
new driver with no strange entanglements. And it's tiny.

There was a report from -next about a trivial conflict in MAINTAINERS,
but I guess that's more or less standard...

That said, the commit time is really fresh, that's because I initially
forgot to add Robs tag and only just realized. Sorry about that.

I know you don't want to pull, but I included the output from
request-pull anyway, so you may do as you wish...

Cheers,
Peter

The following changes since commit d72e90f33aa4709ebecc5005562f52335e106a60:

  Linux 4.18-rc6 (2018-07-22 14:12:20 -0700)

are available in the git repository at:

  https://gitlab.com/peda-linux/mux.git adgs1408

for you to fetch changes up to fad6692ba25138cd127d12569062e9fcc4674cb3:

  mux: adgs1408: new driver for Analog Devices ADGS1408/1409 mux (2018-08-01 10:11:59 +0200)

----------------------------------------------------------------
Mircea Caprioru (2):
  dt-bindings: mux: add adi,adgs1408
  mux: adgs1408: new driver for Analog Devices ADGS1408/1409 mux

 .../devicetree/bindings/mux/adi,adgs1408.txt       |  48 ++++++++
 MAINTAINERS                                        |   6 +
 drivers/mux/Kconfig                                |  10 ++
 drivers/mux/Makefile                               |   2 +
 drivers/mux/adgs1408.c                             | 131 +++++++++++++++++++++
 5 files changed, 197 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mux/adi,adgs1408.txt
 create mode 100644 drivers/mux/adgs1408.c

-- 
2.11.0

