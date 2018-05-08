Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755156AbeEHMuY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 08:50:24 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48276 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755136AbeEHMuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 08:50:21 -0400
Date: Tue, 8 May 2018 13:49:16 +0100
From: Roman Gushchin <guro@fb.com>
To: <linux-mm@kvack.org>
CC: <kernel-team@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>
Subject: Re: [PATCH] mm: fix oom_kill event handling
Message-ID: <20180508124743.GA26112@castle.DHCP.thefacebook.com>
References: <20180508120402.3159-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180508120402.3159-1-guro@fb.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c092:200::1:60b4]
X-ClientProxiedBy: AM5P190CA0031.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:206:14::44) To SN2PR15MB1086.namprd15.prod.outlook.com
 (2603:10b6:804:22::8)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN2PR15MB1086;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1086;3:i3T1IUjsNnIH4H+KiTKZDTPS/WlYJqQREoHguzBnjDqF5lK0Exka0nXDA+wewJKivMoSFP+yq/ubpe/r7cC7p37Gt/ousBOTFrr12zGgD2qJWNFlKpEB1sRVEjsLtDp0os0vxhgZe621YQ8abYFzDm6svNKK7L+ChqdFjCLSaCqXJbYViMXW5jMxvvOg2N8Xi3mDgZJBheXCMcxUG7wUGPC1598+yygNG9TrSklARPsyOyLyQK2Yd6IYb4iBkcZV;25:cRFOR1E6R7G+z/L9p1/m5LFoSqQtJOUv3lTJvtxc56FY5Mqr6IGYm4MNUtmGccwK5REDgtCYf1Be07M8KWIX13xvZkVTnKquIZBoVJBYU1XrYTEJpBQDV4uULEWn+hWgpSP/IQhiTwOBL4WkjytdEX7uyFpSFTCe0MGbfhW9oOTeX3lOL0Avq/MF1WIY4WK1roLqedbOg4oBHPstz1Siaa0tFe0tHPjxnsk8+4QMVLm0vCcBdgUpNMoCLWwSQ47hgaD+gMEVVh4v1OveYnQvGMM4c/0Bwqew2MnTRclLueWMFzAJcgDmpROOie0933vOQWnnfac9oCbkGoxs/0JYYg==;31:J6ChvqQhE5WMYG4F2wbAR1J5KF2vJMAWXxJh3Rq9zP17MSYPgkPVsnaKVDDaAnTt0c6hOQy8iU1ebrnJhaWYqznil4S1jn/6vP2I8OhUIahli9T8O5i7X1zwxTq1HLKB/Y49HPGbbQmiim6jVVlDnP0XqYhX7VLfBpFLvGWxu1q8j1Cmjh12WBQOIY7K82fhpZslvENAxA6ZFNH2kLG0ig+HvElQa7934mvvAMwqcEA=
X-MS-TrafficTypeDiagnostic: SN2PR15MB1086:
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1086;20:HoGJCue/kuUarrNdPqeRSIJUBTYiABV78SSfxmhWuIAblIsr6hdr2xL91XPDpvK3ANDDGoPvM+iFHJiHP1QTeyViQHlqk49oj/SX5IioAy7loKKlO9za40gAEMeAvF3Ia5eiPfeLhmkGG0GuLW1UwdhHwuXnj+7eLfygfjYPT8BqpCMGYJeuktBgw0pSvfhU4rexoAdXnE/GPmW1KuORZcXeGM3EuBjbrLugDIKz/CoA+WwSE5i1IGEvWVW+9Irv5OEI0lLKNYjPvgB4bFhXLz9pjjOepimCVivEVyvAzAxcUpkQI3IncFbJ1zfvuNWkJKauw1oi8VauMNTjyJKrnShOyj3hrgAWzdRTJA3x86KcHRAZc9xhL9hTtCFYPRiaoDG47WuoXz0Tp0Corw0zAsYnXYzFxTvuYOQm2BV/esXp4s/hRZeXS+hWjR0f76MflHTlJwg6hmJlQ6Xmed2f0j3wRzwKtqNqJaosBmfVS6jlmWEjvtVqvz/oljF7wCpS;4:HdAEDWFvjh8nUOXt2qHRX0jlZnHnua/TIVidUu3diVUEzfI9FifI4osHmhDjIq3P1Tq7wkfKpHqnOkbDJpiqay4K8vo2pLZqR7Mu0IINVDr2QveqpMdDTWhmltzQIBDEhW9zxjQUeYVhkAHa737wsFQIVKNJ55vIMMCmpM1Dv5KByUHmnXnD6keVQcj9xciiHiGMx0Q4EVLIUfdUTTsyC4qDUQaADl4RzEWNTmXLn70/F9108pKwAWbg8grPVRsADm+ZotdSc+5xoRD1VlfOcg==
X-Microsoft-Antispam-PRVS: <SN2PR15MB1086F2AE1B79C8CCACEFF155BE9A0@SN2PR15MB1086.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:SN2PR15MB1086;BCL:0;PCL:0;RULEID:;SRVR:SN2PR15MB1086;
X-Forefront-PRVS: 0666E15D35
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(346002)(39860400002)(366004)(396003)(189003)(199004)(54906003)(106356001)(6666003)(6916009)(81166006)(81156014)(2351001)(16586007)(5660300001)(229853002)(86362001)(8676002)(105586002)(58126008)(8936002)(68736007)(9686003)(7736002)(6246003)(316002)(2361001)(55016002)(39060400002)(53936002)(6116002)(4326008)(305945005)(386003)(47776003)(50466002)(1076002)(23726003)(2906002)(25786009)(97736004)(11346002)(52116002)(478600001)(7696005)(16526019)(52396003)(33656002)(46003)(186003)(76176011)(476003)(446003)(486006)(6506007)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN2PR15MB1086;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN2PR15MB1086;23:4MkEu1hmn+6uGGrpV5Q41aovupMW/tJ2vouFIXjr3?=
 =?us-ascii?Q?Dpr+vBKbQb26iIZap+stfIv0/yH0vWWRUzJQYZhndmQnLW0C7V86Gy9INJI1?=
 =?us-ascii?Q?kLVxoOd9Nzcvhekvw7wzuEBCKhVuCKpk/WR80z8Gosbvvrh0DmNQGXvVhLoC?=
 =?us-ascii?Q?radWhs756KaNzONQf40rgoH83Pa2A1e4MVMux5UnDPSKhKDQD2tBzqqp/oIN?=
 =?us-ascii?Q?8CeAvzH35aF7uu9WfKt90FSi4CQOe5Gd+6kWyGiVStjXb1wNvzF35sR68/xd?=
 =?us-ascii?Q?LJWAA9vj1iDui5k7maW70PGF6wRkJJbA+I5gKxkQCKZL8mWq6jzv/90LFi3o?=
 =?us-ascii?Q?sRWRomujoEBa0CgNRJlE6Py4Kk8UaP7V3CQMLPs7p7TfDHDVligXyqtuSOF1?=
 =?us-ascii?Q?SQEnEBuJFTUlrQIqJ84n8yRTu/R1EgtRdw4skVkn2sUxBemNedDhdiiClsQL?=
 =?us-ascii?Q?JlCXKCpN8I2gu7URr8N8v+0I12WA1HYkufZHUul/Qn6nWj4OuNwGiUEllV16?=
 =?us-ascii?Q?TLxt3A/d2FD4dpOe/8ayPx2Dn3snJ1PNcmZ8RfV2t4jnbXt94yMORwDtVnJY?=
 =?us-ascii?Q?bu3T3MF3xqHhg0eX4EnfapYZfNwRciqEi8X47i4bu1u/kn959oS05JD2E7ne?=
 =?us-ascii?Q?4Pvf3YKvCvfTOHNbiCSELUhVce9ykqAfobgc6QsS9XnCXBZqbc5gIvkJI6H4?=
 =?us-ascii?Q?zB1xnolrULJB0i4MTpPKYzz990znyrq3dreiIYLgerwj5MKI6kpIriTP7hh5?=
 =?us-ascii?Q?PtVZW/brZ+Gt6ZH2VI+7yW5XLsL3gEdI9Phb+24LnPtTTV5tq8EB4bXgg9xI?=
 =?us-ascii?Q?295qW5ZRnAgM3nQUIwS+PiZNyzf+T5OGBwR3JIy0M3hXDWxSc/+TISU4NUaR?=
 =?us-ascii?Q?7LVVsYiDUY1xfM/yOFsOjBveKeaL2nHEx7DC79sbQHD1Z+shT0hU1SAcJW6l?=
 =?us-ascii?Q?x5h7BY/xYwpGacsFJiOJOYxFR04hpXcOrl3yjl8b9tC3yhsitwGyrJHsyLUm?=
 =?us-ascii?Q?R7Cnf+R1HJ/4SuBMfGgmtIybUoG8lOzK1558mH+vxFcF3pMcTnjoBKhCDiL3?=
 =?us-ascii?Q?GoiRp3ZT4WRWL3oRdl00X3zs7EU5ighpY9pXUPEeexJPzKUwgLUIZD1Yefpz?=
 =?us-ascii?Q?MZ9AyHwSKMVe4i8KHpRz8z1iE3sM5sRqX6JfAuk4gcxzzIOpsVPee3cn+oSW?=
 =?us-ascii?Q?vsTqif6S4oZp4qBlhV1PegStoKpVfUJFJL/tDJfd1L4oFuYSdNJINwLsXJQ2?=
 =?us-ascii?Q?tY3C/5v0jFwmeFTuIWsNnoJoyWrkJB/MK79RQ817Nj+p9NB0dSrm6iW2+XIl?=
 =?us-ascii?Q?3SVYz26F3TUaE+msptW4H4=3D?=
X-Microsoft-Antispam-Message-Info: AobohpFVuQ8dFHoTya3NsQfeq1UiUF1PXcMXzslwVkEFDjp/awWQaV0TPGOq2uFT3EqGhXRIdB+spSKhDla/qL2SeT0tPud77LsiK1JWTGkCfxUCSV3G5lYJj0knfXzbxP/D1HAyPLbiSb2vFKb3FeAl568Y1yCFvVGBQ3DjKl/A68XllSFYxf0w216ZnnOw
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1086;6:eq8lSQ/gvYF8DdYvh6uYcr25befKfNZA80DRh4ultiQk8TMp9uik0V091YKNhakfMBKUShuFG2lnbalP5baU+8LkopumlsBLxprFmV7Zgf5y8ZpUJGbORb+kPt/I2EbidjVzVK887vkdCaTSu/mgsrXcXHSIc2vWHr3IZzLoVZJtWg1rlBN+O34LbZqFMsWLgsvYjYTk8SYeXDCrU07U1BJrb1U2mNK5YdmOkPeJh6itErnJuVdj7ZUt57MB3XG1nrIPdrn/QqOrPBDZnQwbfpGdtMZKy3hMpCQtGG8yMlsknu89jQeHxdczBpktf0fuE06f9DWuP8oMGulIfM1V8r/sBbRIiJ3y1dG68JdIUzh8e/xRKp1GqmJwttgAooXedbL1a5o87oy0j4wdYNK1ndj8oQmKqecsQh3EdBcSmLvhFJiqSpOKdAtkOrajEhFfgFNZ59CvNALTOdPLTXu8oA==;5:q+50HRB37lsY4pgAMP4oLqmrJ/nTCLXjagcdqMYBajeapBzh7Dsbp4rv7RRkKHS9kw1cNbwC24CMgyN4QtCOIDKmWBX/NFVlBa7vt/Q/NpEumDqQ6m9E39P7Aw8vL5uPOJ7VL+HCRrpXCNhe8KxGEzQSG4HyJKUoCr26C067CSg=;24:YZw3YbkKcNT5tmmngFF0MhPkd0hkyOVBdDOC5DxbRGuq+K39lj1Sa9UR4RYISTd2AK7/UydcedvmMwUMZ81qnFowbhvQ21JAkhB8f9GJxFs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1086;7:9/3qMHr/gpX1U4MieL+kbM4XAR4YWJlDdSfI/hE6iPHNw+HSfsFAoo6tcf9cdZtGN3NICCgiyU3qsZL18VCx8YKVEuRRobRS/4e+FxX6YkapyuaOGPToIVu+z/Btmcr9fxV7FarKqrXSS5/DWUEWsakQj0ltd1ppeILcOZnYQtlolWkDO42HdT/OcDV9Qfsc6Y5seNGHyZQgUzA8gefScEr7Q50cBN3n5v+ZNLBo8EvJnEyJE0EepnQNl9XaiAVV;20:d571bnvqWsS4XKnMV339W5HSxnRnMJYfYjbkkPcmH+2RqYjmibBBU3uDKIJV7j48RSkapMj28Fi27ynFzfl7U+Ian0qk2mCG46iu0kSaPD8TDjTnMJpkB53dtq8bmf+dyZ0gFFRUdcqi5Pcdhl2L2iPCYq5GaRnW57HWp4x54p8=
X-MS-Office365-Filtering-Correlation-Id: 2cba6c49-d527-4cef-f616-08d5b4e22521
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2018 12:49:30.4352 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cba6c49-d527-4cef-f616-08d5b4e22521
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR15MB1086
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-08_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 08, 2018 at 01:04:02PM +0100, Roman Gushchin wrote:
> Commit e27be240df53 ("mm: memcg: make sure memory.events is
> uptodate when waking pollers") converted most of memcg event
> counters to per-memcg atomics, which made them less confusing
> for a user. The "oom_kill" counter remained untouched, so now
> it behaves differently than other counters (including "oom").
> This adds nothing but confusion.

Please, ignore this one. Version 2 is properly rebased on top
of the mm tree.

Thanks!
