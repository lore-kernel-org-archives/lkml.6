Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3100EECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C450F2146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="WiK2asyK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C450F2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730094AbeIRTUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 15:20:08 -0400
Received: from mail-co1nam03on0084.outbound.protection.outlook.com ([104.47.40.84]:10944
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729857AbeIRTUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 15:20:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZvQlLetrOvnw8lrfen9qbOgA86XlWbXmCec15g6RBM=;
 b=WiK2asyKBTYPpIuegcYFNU/XUyjUWCoSEDgbhGDR4qwzLkC7MY1epA6zB+w7OYpPbJv+nySypWLt3UjnHSgv4i2RPUeZu/Mc465C1yjTLaUBgxSefUzZTigdDpHoDURE1DZ1eipuXrngFAiwqUEkfedEKURJR0J55diflgi1+X8=
Received: from MWHPR0201CA0101.namprd02.prod.outlook.com
 (2603:10b6:301:75::42) by BL0PR02MB4754.namprd02.prod.outlook.com
 (2603:10b6:208:5d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.18; Tue, 18 Sep
 2018 13:46:18 +0000
Received: from CY1NAM02FT015.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::209) by MWHPR0201CA0101.outlook.office365.com
 (2603:10b6:301:75::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1143.15 via Frontend
 Transport; Tue, 18 Sep 2018 13:46:18 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT015.mail.protection.outlook.com (10.152.75.146) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1164.13
 via Frontend Transport; Tue, 18 Sep 2018 13:46:17 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:45983 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g2GKW-0002B2-PY; Tue, 18 Sep 2018 06:46:16 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g2GKR-00025e-LC; Tue, 18 Sep 2018 06:46:11 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8IDk96X000400;
        Tue, 18 Sep 2018 06:46:09 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1g2GKO-00025N-N3; Tue, 18 Sep 2018 06:46:08 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id DA44B12142C; Tue, 18 Sep 2018 19:16:07 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <ulf.hansson@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <adrian.hunter@intel.com>, <manish.narani@xilinx.com>,
        <leoyang.li@nxp.com>, <sudeep.holla@arm.com>, <olof@lixom.net>,
        <amit.kucheria@linaro.org>, <rajanv@xilinx.com>,
        <jollys@xilinx.com>
CC:     <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [RFC PATCH 2/4] dt-bindings: mmc: arasan: Document 'xlnx,zynqmp-8.9a' controller
Date:   Tue, 18 Sep 2018 19:15:37 +0530
Message-ID: <1537278339-9257-3-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1537278339-9257-1-git-send-email-manish.narani@xilinx.com>
References: <1537278339-9257-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(136003)(396003)(2980300002)(438002)(199004)(189003)(476003)(6636002)(6666003)(8676002)(81156014)(81166006)(7416002)(48376002)(106466001)(50466002)(14444005)(106002)(103686004)(2616005)(4326008)(356003)(426003)(486006)(8936002)(217873002)(72206003)(52956003)(126002)(110136005)(36386004)(5660300001)(54906003)(63266004)(478600001)(305945005)(11346002)(42186006)(16586007)(76176011)(446003)(2906002)(51416003)(186003)(90966002)(336012)(50226002)(47776003)(6266002)(316002)(2201001)(44832011)(36756003)(26005)(142933001)(107986001)(921003)(83996005)(2101003)(1121003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4754;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT015;1:DgpMeahOrd+FSAd+EOvBncnEhxabasYG93EPJGshqONxTTL9chv1Tb50O9VQFnAsI2PzNtMkdwLUjZcxqr6gJZV0BbZ+HzV4trGL2Y3U+jITG9OIRXUH/9qIdEC37RR8
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35ab860b-ccd5-4e0b-9464-08d61d6d1c12
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL0PR02MB4754;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4754;3:L+e8UyL/pWXLTGPydjpL0SsppqI2eaILZI6fAIyScnw8D/DRsiDv7/CUtTgPfITC/LJ4i8ArNZjnckkoySxMQNXXIlpCt5We5c8o4XMKgOz428CJUSxvdc7mebSdmjZLPoAIfpblFNJgr9tBFP0uypQ3ZlUi+oX38c2pCybkKoGYlQdCWnm6vLy9RVZrw3WRspPk4xtKxeWTZ83/pW9WfvNK/lg0Gi9JCojQY7sfiBnpHwsdvCN71+w7+dZ1Yt3Gj53a7RIsBdntQcX5RX5RmigtOIUpNizdpj1GNt6ETGl9rGRa2JetH7DnVQyIlYEeipGCGH7vXc5nZdodQ7STVpfjqRU1qjTu3/mSW9hKQKk=;25:HAkO82N/b0Wvxnp6jXKoPxSPw2lN4GDYaH1iVggg84ObjztWXPZxa6QG7hBSl1P7oLZvw1exHvF/sJq2kst+FQPAup/UCe+gE6D0hVldY/FiF8ML3m0hEPdY4PdxQ1ssV04qd/DeTrkONRzu1MWFFzbaqWiefW1aJIb5leAapP1StmuHnfT0FOmEVfQht20dEeKBLy5xCu0s045s4zh6mzGnS2thtsX4P5GjdHKplDgTeEnbZcXUMkjIy2vcw9XVqtWd9SvCjoytdhsNoNarchGIymCywmUYKBFvkCcMDVUw8x+3glXn5ebML4crJWfFEoEq8CxeHHOTMPv4CUG/Wg==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4754:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4754;31:Nd6aza5DXXBsI5lFjv1ZoG7n1r5sAvk0EJVwnhsly9fgQfJYVVXdI4pHUw+DA0NOU5rRF0udcx+wG8HGQjrW8RwXZhTU9P2qqBXgUOjZLnEc2rXrWP9Y7aw5xYtyVN/+VEcvl9y0A6TAnY+5q5zMSJM86i7Y6emQF8PT/ZdyUSuNVPYkbwXqfDvyaRYxrdWk/S22Mtz0mmgoEFiT4cbKpsLKedYsLCGxgWUTrDik1PQ=;20:dQUgHxNO5zFGsNwhhmlIFxz46rl8++z/HI3IZyjm5l8wYsC2U1FTf+DFhDHRaQqrCI9tv9f7EWYz0d3+SEWNJ/rcY51nzmt6us2wRs4kG/xQO8PWNyFBMd98CDZPPsyOCQ3rKm7O+9tI0AS+ugrbaNq+mw4HHF+aGkb4aJ3zfUSNUPf2nJCz7y5XtuJ1egYpXDnAPzLT/kgPptZw1YJHDzFbOg5zS818eoum1KTDA1G0OyVI8BGLcDFQduOmBFByrf7pd/Mrz30avMqrBEj7e0Ts1cfIPTKL52zPq3Uq160QduyiLAhtzoeR7VTe8+lCv+Hk6Kmiuf8Eu2X9ninXIxMc7jkuyVyqE3HOga+j4jF4va30MvUBrVSZpvrYsk5Zg+8xr0fvyIqJ51+EYU/YeFUlG3NoEV2xIRKGBsBCUHiOQ+AZdljRFwapD28C7uJzf5W2F5050Sr9bPaO91fmFDdP/qZvX7TWIFo6ks4+rPCBing6vED0RZ+1prVJJHsE
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB4754E08FD9B68F3004FC60F1C11D0@BL0PR02MB4754.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(93006095)(93004095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699050);SRVR:BL0PR02MB4754;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4754;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4754;4:IDgKASKu0vj9scAPLOapnVeyLhlh9Erhz29u90c6YueoOjWwrAYKDbfdfXqtoPja/FuoJurV3fLayuCLGPrJOZ7Ch6wFtKbrAgM4RM70fFceB8ZfDab6K2N6k2z1WHmb5KZdrHKUgTHX5z/UPeZk2sXaxZkck+jSTkBXjJSWVG7Qv3/dZbX672kctmEl9lMBPVuAPz/4uN1KU+PAgD+CaUCwE8bMLsZdLGIT5nOjvCHK51bENRwz5dZaiCX5zb+fNPf/988bB3jNLNSrZv2TlNCcq/IIJwKXo7RzRLcX0qsjjoA5rhGq8hzS3wPNOJGx
X-Forefront-PRVS: 0799B1B2D7
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4754;23:WPm+t7A/90/Gpi3FuyJenRxDCAblFeqxkloIEuEcB?=
 =?us-ascii?Q?5Fqhofa6c3Y7dgG0Ed6XuFtDp9ILX7jC7BNZqkWFZ9eKbU5plXiYs7WyliGO?=
 =?us-ascii?Q?dpBr7IaZ1yUXsLberiP7SRYunb8BVsgRVwIpad6MV7q1ImsY6KPsfZ3p3amw?=
 =?us-ascii?Q?qV4z0YOfY62mNjukIMPVvmQc21etDIXufh9/D18GHoT/GJKZa6TEKRGopOTK?=
 =?us-ascii?Q?aX8rq4mhx13cC6JW3q9mx6vKJWonkv0Xz1b0AIxJkR3vKAWzFFvvYkrXBBdF?=
 =?us-ascii?Q?rj8dUI7LZSxRgMX+DQGIMkUcURRosH5BdkZvs98NnmI3B9KcYDKAyz40bDCv?=
 =?us-ascii?Q?lP+vyBUOOPVhNqYCnvtpcMpGPdN1PozA2nsoVbHO3dH5NqHHAL0feI/2bAcV?=
 =?us-ascii?Q?4iVNKf/fUlK1wXwjhPCVfB6OoBP9o0cDQSqBpZ0NRVfHHwAcKPIboYMR71VM?=
 =?us-ascii?Q?6yynEN1QAisX5EH3zf4f8RiumdTv8zqTL9SOljmDBFxOO+q4FBviCDu2g5Td?=
 =?us-ascii?Q?ITMCMxlCEczLcqHSK+hfw0741+taI2qdaMR5tkrYzq6Allebltrka+JovBgt?=
 =?us-ascii?Q?m2s2Dx/woAd0S15IzRYP/bTQMYH362hzov9HGLvEzUupdBOxawaKbClZ6+x8?=
 =?us-ascii?Q?2e/xDV00EFuVIxkZu8veuWsrX5k7ZELsMhNqsG9fLCU1xBf/R1Vjyc+HuwKI?=
 =?us-ascii?Q?t67ZC02ux2TyTvlds9/2SPzHsUwXY5A3uBKgZE0eTYGgCeCZNyQVXQunFYfr?=
 =?us-ascii?Q?qhbq58FIy4ZH80DKHDR71YMZbAk+YqCYtClkLfd8FN0F/P2hEo4AsPalcwJu?=
 =?us-ascii?Q?xrEgkN1OLZxh0Bi/MLJ2O60wAY6UWCMfxMZCUECk1oMuL/ozCeKG7nq35Xj5?=
 =?us-ascii?Q?R1uoA4U1RAqFGbABs5IE1oMhLzGlMAIbgztJNstQmqI23ZdsFpqc9rkKqygF?=
 =?us-ascii?Q?nzPuo149k11nghPpWEONAbih25bDVRwajPiaaDG6glyOgcL6B6InSKuXGzsj?=
 =?us-ascii?Q?ry98ifN+UZaMf1GNMm32zyBtZXQ+Dnhd1CGyVl7KR27n/6MHPCbPNH8hsIRj?=
 =?us-ascii?Q?B0aLIb09KGzyKBb7jtjrVaQ62qjqiPdT1PanUmjHwrIK0kAq5suw+hk84k7y?=
 =?us-ascii?Q?LpnG3AFA8yRSxpykWfSUv63mL2+685ORnm7YQ8ZWfUi/xOnD+YsKJH55xXXB?=
 =?us-ascii?Q?ADHS7h+W1jrIwIuV80yfZmD8STohsDNO/+nDvyBT/4cssBSHMYZVKFGigYit?=
 =?us-ascii?Q?Ks97eH5U8/aZxORpaGJJRrDdtN3jgaCZnyVyJv/cGs4H7TpsJYnt85P04dfq?=
 =?us-ascii?Q?aiOod6KW7C/jnha0BsedxcIT5Oqvtrne02nmR+/rFdVYDuddNAoaShDzEJg3?=
 =?us-ascii?Q?8MdnJK2mOKyIIVU6zMH2TKuwW5pgkRc9G6Lr8Kphu0QhKjo?=
X-Microsoft-Antispam-Message-Info: 90jFe7SBhzaOnjuf/aCr8VG1V4aM79r1P9J+6GOEJcIHLziwoMo75iS4YU5bc1tRBZmX8GnnT2hPO4cPSQ8ip7HCPYVFanUpfOGwg/ph9MsAOfbDcEoBgWjZ9bg+ywf+tT/w1Br9PHc//xOVe42ShaE/wtYYFFTddJwLiZqJh5fS9WOIiPTsV0fph3ye8oNblRHdv6c6kIONrQpO3YBSBaOqLVP0V+jptKwrD/o6rmrtMjiBKCgI+7xgSSUqqIwNOVDZnb1DmA38sYlh8stfZj8zHUA3/HSPg2Uv+3Xc6Btz7svnyugTyJzUmIkhmJmgK2cqdZ0wGHDSguSuzEeBPWTURuuSLGuptnRZhBvacEM=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4754;6:Y0c4ggSTXXbi+nm/BRF3jcbhWbEF4lzaIUmoAGnI4PE/CWucjTYICb0QTvVVGIus5QRyuC5GYf4+znvrhXNVANhDRc9Y3a1Y9uXn1o+oGMlMyJwXzdWDbudMm6gnZWOGyyoLvQHlTyshZ56RfAUK4QVTCdLGmqmK4OYEQr+SW4fCCAcEeatx9G9juQyl8aS46ppLZzQFn8dleRZMvTYD1wBXEfYdlSKyJwu48kHSbdhv0InKryG4XfXdbk3wKJ3q72PUA9cdx9h4/xhlbk9tJjjsD5E51u7w7bTeAVHuHpSTRjyD7yvXnGCSldycYbvsw8wWSMXB6nMILv22kRQEyKZl4wISfR9OMFf1sbUpGr4tCo/gFyQOHyFcN5U3xAaUUvyvheEyJKFH344kQvVELV0J0NXUyVgY+Jnkq2p1UrWU8reeh5gZXRu3zU11iDreRlXB+Qv7cZqzCxTzlXPEFQ==;5:va2/HAAW7S027qzotYnPkF+KZ1sw4BGuEYREm9GxaPWm3ovz1AgQzyhuIkNLm/jFN+XjzKxaKnGfLL2fjC/bBrwIF2Omf+Gi4AmwemrrOV4gOw/5BYP8mXMdoqtQcuf09nXWx1q1C0/aE38MrvzQTQVadoueSFyKfjNb72oVXJQ=;7:jdsDwxtUs4R0eyBrjmy25CwHchaFqdUw431kxEab8rrhAoU79GBQVfiZKqgE0PsAyk/8qJnlzFbt4Lv+LIf0bdkcKEsXX/7FBHAif1j/3uhjCslHuAVkZfm8e5zu3p5H8yOhS+BmcIYtENVGZCJZMEHkdtvX/20Qlwyrx/1LZUJojgewfWjm29slGtrr0Ra6y0DIYmSjSy07VUR/7eWpC+Bk42YfpCx2ZM76nFJ3w3s1k28Gte5tyP7pKHyIDvRt
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2018 13:46:17.1936
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35ab860b-ccd5-4e0b-9464-08d61d6d1c12
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4754
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for 'xlnx,zynqmp-8.9a' SDHCI controller and required
properties followed by example.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
index f6ddba3..72769e0 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
@@ -15,6 +15,7 @@ Required Properties:
     - "arasan,sdhci-5.1": generic Arasan SDHCI 5.1 PHY
     - "rockchip,rk3399-sdhci-5.1", "arasan,sdhci-5.1": rk3399 eMMC PHY
       For this device it is strongly suggested to include arasan,soc-ctl-syscon.
+    - "xlnx,zynqmp-8.9a", "arasan,sdhci-8.9a": Xilinx ZynqMP Arasan SDHCI 8.9a PHY
   - reg: From mmc bindings: Register location and length.
   - clocks: From clock bindings: Handles to clock inputs.
   - clock-names: From clock bindings: Tuple including "clk_xin" and "clk_ahb"
@@ -24,6 +25,9 @@ Required Properties for "arasan,sdhci-5.1":
   - phys: From PHY bindings: Phandle for the Generic PHY for arasan.
   - phy-names:  MUST be "phy_arasan".
 
+Required Properties for "xlnx,zynqmp-8.9a":
+  - xlnx,device_id: SD controller device ID. Must be either <0> or <1>.
+
 Optional Properties:
   - arasan,soc-ctl-syscon: A phandle to a syscon device (see ../mfd/syscon.txt)
     used to access core corecfg registers.  Offsets of registers in this
@@ -75,3 +79,13 @@ Example:
 		phy-names = "phy_arasan";
 		#clock-cells = <0>;
 	};
+
+	sdhci: sdhci@ff160000 {
+		compatible = "xlnx,zynqmp-8.9a", "arasan,sdhci-8.9a";
+		reg = <0x0 0xff160000 0x0 0x1000>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 48 4>;
+		clock-names = "clk_xin", "clk_ahb";
+		clocks = <&clk 54>, <&clk 31>;
+		xlnx,device_id = <0>;
+	};
-- 
2.1.1

