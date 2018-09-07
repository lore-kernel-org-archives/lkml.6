Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC70EC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 694902083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="GfZ+ITRR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 694902083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbeIGUsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 16:48:13 -0400
Received: from mail-ve1eur01on0097.outbound.protection.outlook.com ([104.47.1.97]:20505
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726591AbeIGUsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 16:48:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EaEBeDjQZOba4/NHyltull3Sk8NV/KijF41UkOQki6A=;
 b=GfZ+ITRRJSaXfG86JjM8tNxiGWj9/7neO1CQxlqGVMfPsRQcGQ2DjHle3nOG/15Hgl4jO9qErn9Jy25jU2lXUrk4QXr10YpCBYp2FRXQxJRk7YMgII22Yf0xuAx22/HPPx4r1HGLgjuTcbbpW+Q+1zxPG8H1e4XWtC9NVKY27Os=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com; 
Received: from [172.16.25.12] (185.231.240.5) by
 AM6PR08MB3254.eurprd08.prod.outlook.com (2603:10a6:209:47::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.18; Fri, 7 Sep 2018 16:06:25 +0000
Subject: Re: [PATCH v6 16/18] khwasan, mm, arm64: tag non slab memory
 allocated via pagealloc
To:     Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sparse@vger.kernel.org, linux-mm@kvack.org,
        linux-kbuild@vger.kernel.org
Cc:     Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Jann Horn <jannh@google.com>,
        Mark Brand <markbrand@google.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Vishwath Mohan <vishwath@google.com>
References: <cover.1535462971.git.andreyknvl@google.com>
 <db103bdc2109396af0c6007f1669ebbbb63b872b.1535462971.git.andreyknvl@google.com>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <3f2dee71-1615-4a34-d611-3ccaf407551e@virtuozzo.com>
Date:   Fri, 7 Sep 2018 19:06:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <db103bdc2109396af0c6007f1669ebbbb63b872b.1535462971.git.andreyknvl@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: HE1PR05CA0383.eurprd05.prod.outlook.com
 (2603:10a6:7:94::42) To AM6PR08MB3254.eurprd08.prod.outlook.com
 (2603:10a6:209:47::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32b2f565-820c-48c6-96c7-08d614dbdeb2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3254;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3254;3:aNfE3ZETDp14xy4P8Xm1gzkvP11rvchDnQHZopBo4vGHs2K/geZz5x2xdhVjoDK+1TqzCvpdIWt6RNL711toDLgXTK1gHlB/9dHrMJ5UHIXIAa6dgY8YK92W1oJDA+jCbDQSknSdbRvja2pcdkmo7wt8IsEADCmMt8sSmqEB2+LvZptOmAVNwzBvsX3fGsuc+Twvr2mSpcVh5m21wBT9s3SQ08HSxFZ3ywBXmPj1Y8I/a4EtLAprJjH47nsvUYqV;25:NU30sj3kDSohLLYkTCsAZcSo8mfc27saR6K2Cmz0J7Lq5mbLHzaEsHk5pnZMte6RLSMzEeDXXwCJviCXdeNggPCyniTKVGHwRsyBDJ3IxLQCaD5SQG8SYvKWciKh6t9B2gGZuA9RlSZA02MH401FHmYjFurawwZJL17XPWUK0MemUKKHrXNZx+fY7PKNcE0bFzpAhC+xWDp0pR/YJir70QvWwXIEZ5e/PwLwv3KKxFELF4/4cd4x05F2Y2U+M6H0XCYbpzRb0alYL3RZmvTgn9dXQ97F6CE+PemPh4kB0iR5HS6Q7YLW33RXCcXY+1OmTie28cmtBPZMhAUyfqCPQg==;31:C8AdaCP55sDzxICKBMMJ5/uW+KDf/JxJwYmcZLaw6/Yeo6Vfxljg/sCAtf7QEUvBDptQ6Gj1DFz5fbqm+09TSTciSTDf88jNIOZ1urfBY34oBFcvwWmam9dgdthGpCc7AleJ38PAnzuwtizZZ3MZZjJd0hl1EtfvFZAPRpbmckXXVimwibo4UmIynGSHuB0KDiEhj2wl6+TBkM2pBXFW7vpOsuc5hTYaMKOxiejNunY=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3254:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3254;20:uzEo2LDYvaBA6dnidnDA639ZSEQLapdzvEO2zG+BQmwWNH7lqS7q4gHyH0QrpAo+Sum4vrQPoYQu8VHrSlnMK76TEStbYMIVV2ID2inOJUuR7cfe9K/CLpxQIPLKWIb96Qsts3ROoP3kWaEM17s3N6IVvvmZXy7dUhOGrQHM2ZJP0ZsBUKe+qblQ5bt/WFR8jJzR47qu1eV+otSRUEVbkDale5znO/UFujeqLRD36dDkJhS88gj565Iv6EJoddKstQGhMazpvmbFffbLNRKOXM8kHu2fX0Q8IZy62s0zEppQzUUzToag1zoTXIOfchJ+kIOqKCahBWU2pmdrUpxyMZmMqXPG/pPFD8tLJbnYyBwFiRxgtR4CfjM2qOXqjCwCnLrUjCiACoSREdx3g4fUwocz4eHIoy+p8cJ45jiR/f7EovUaKEqLX2tFOCp2kpytyyiDhe7qKllqwgmCPfzev0r7UnVeSfboDCrpBltom2KTxiTmrXx8PvDkzd2HKr+H;4:TQIQQ3JBltOcoF1lZPphDQ39fr3Uxq2xmr/3mzKRS4IitJTZXL6QOPVaFHXN19MZ7xdh5c1r9rj/k1Jkle1zwjJG2I/dCLtb0sJlWliHOuXbFCB2IGrDUDLpkGQuXOnvRT/f4TfQnBevAQbq8E/LBa96uqyH2Gi6bkaAViwB3rgEUUOdjv2kuMX0GVOUS7l2TaWf+TDLgGS0jRoTfnkn0yjY+wxXHUY8LLsIFAw9J0qL8FKcDLoAOMaQf3HQihZn4BOkgCUv50vOnHMQMnD20w==
X-Microsoft-Antispam-PRVS: <AM6PR08MB32546FADCEF6FBE24E75B36CB0000@AM6PR08MB3254.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699050);SRVR:AM6PR08MB3254;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3254;
X-Forefront-PRVS: 07880C4932
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39850400004)(396003)(366004)(136003)(376002)(346002)(189003)(199004)(7736002)(105586002)(8936002)(2906002)(16576012)(14444005)(64126003)(106356001)(316002)(186003)(77096007)(16526019)(7406005)(5660300001)(446003)(65956001)(66066001)(76176011)(47776003)(52116002)(31686004)(65806001)(52146003)(23676004)(8676002)(54906003)(97736004)(36756003)(65826007)(7416002)(31696002)(26005)(4326008)(6666003)(86362001)(486006)(6486002)(386003)(81156014)(81166006)(229853002)(53936002)(2486003)(25786009)(6246003)(11346002)(230700001)(6116002)(3846002)(50466002)(478600001)(476003)(68736007)(305945005)(58126008)(956004)(53546011)(110136005)(2616005)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR08MB3254;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTZQUjA4TUIzMjU0OzIzOnpwRDNtcUtrQitnNjkzUVJsWHNIclhLeW9U?=
 =?utf-8?B?NUpDbDJvOVBMYzh5ZkI5dWN2MFVYcms1a0xlaXV2SDZYMXZjOFNCa2VKRlZt?=
 =?utf-8?B?by9lQUk5MlpJM2VpU09QV2hibXJDVmZaenVqUXAwY1B3K3hXa0VlOGtBRTEw?=
 =?utf-8?B?NmF2bitWRDQwODMxUzlENGdIN0E2cW9LNjNLYkhTREQ1TFNLdFlTRnZIU1RB?=
 =?utf-8?B?U3NJcGFhN2pCS3AySnUyZ1RIbnZOcXg3Tk5hT1VSSms5bnhDM09MK216ZnV2?=
 =?utf-8?B?TUswTzMrM3YyU1UySFJrem1sTnpzYTRVYWtHWjcvM3Bld1RUZXN3aVRyZ0pv?=
 =?utf-8?B?SXBPeUZuUG9iWU5lTEhIWUtzV2lqWTZkKy9oL2t5cjdUbHNtVHNpZDA0VUh6?=
 =?utf-8?B?VHhHdUFMdGVCUDNaczVjRnFnUENEU0lOWlk4ZWlST2RaYTk3OE9ORjRWSHFj?=
 =?utf-8?B?V1FTcTgvVGRlL1M0R3lGcldZQmdhM25JZDV4VGdWdytBckxoVDArcDBaSC9L?=
 =?utf-8?B?NWRGaFRVRlR0bXdDdjlPMVpQSXU0Q1VJemxVQWE4blp1czZTKzRCSzliWWVx?=
 =?utf-8?B?YTdlQ2FzV3A3MG1GQTNZbzlua0dzT3g0TjBHL01kNFBKRjRGTCsvVnpFbmha?=
 =?utf-8?B?b2w4TGJ5dFJnVkRad2t2S2FZaFFSN29vNjJoTXljUzBQZ2Y0MHUydnAvclpV?=
 =?utf-8?B?cks1bzBOb2UvYjZ3Y2t5OFZYemNkaFNreE9mU29yV0xENklPdy9qb2hvbDlh?=
 =?utf-8?B?TVN6L0dTeSsxMkEyR1BXYXBmNWNZbTUyRDA4cUVmVm45M29qR3JEcllFMzB0?=
 =?utf-8?B?YmgvTElwQlNidCtOcWN2VWFEVTZhK3JBbmNkb24wVmN5VVBQWXZHQ1ZWQXF4?=
 =?utf-8?B?ZDYxQW1wS1FrWVp6TnJGb1RTMDBVcWNzQ1JERUZVNWlxNEZ5Ky9ZeWFuajZm?=
 =?utf-8?B?eUtpSnJ2UmpKc0hTVDNqckxSazhPS1Z0V2xyak5aaGZEeitMcm94MWR4bFBN?=
 =?utf-8?B?TkhqKzk0MU1DOUgvOHJCVXlsQUVBSk1iaHVrMjg0aTFZZWZnZ3NKVmFyZ28z?=
 =?utf-8?B?Q3VWRm1aNSs3QWM0TUJpOXFvRmpGb1lnWUlYMndpSnNGVFJtMUFoeW5YS09v?=
 =?utf-8?B?cjhNbUtFYVBUZWx3c1FyaXRNaisyaUk4SW9wS0o2b3NvM3JKc2lYUDVQNGtI?=
 =?utf-8?B?a0Zucmp5ajhTeGpValdUMVZVTTJBbW0yb05lNFNmcnhyakJ0aXRFZ2RxTmtD?=
 =?utf-8?B?Wit1NUtFSkFjeXU3NmFoVDBtRFZXU3Z0Q0QxSitiT2V2bi9ZcVQ3VTl3Ukgx?=
 =?utf-8?B?ZlF2NzErQzh5aE05VjRtam9rRUVaZ0FtUW1DTHZMOGhZS3JqK21GSVlrcDc4?=
 =?utf-8?B?NVF1MjZlZEpLTGRmQXJad2NWaUZrYWhoS1JlMGlwVWJRdkRnRFFWWTdnSHBx?=
 =?utf-8?B?bTYxT1ZmOUJOQmpvMWhteGVrQ0Y4b0xpaVR3dnA4SGgvRHJMVkd1MHFodnFx?=
 =?utf-8?B?Z0JaSWtzVjhKZjlUMVpLZ1J5VmdzY2FvSmRwenJ6dmsxZGp5SS9lUW1ieXly?=
 =?utf-8?B?YllGVUt2Q3JFUEVlbTM1Wk1IK0NrVjYzM2ZUK2ZDR1A1TFgrYUJNOGRQVmp2?=
 =?utf-8?B?bGtqV0RwMFA1Z2hNTDhhKzZ3RzZnRDJ5T3E4RXpVby9QaGl5TU8xSnBsUmYv?=
 =?utf-8?B?VTZ6OUpWUmZza3hzOVFkQXk1K1I1NFlyaHcrSXhRdDE1dzUwZVN0QzEvV2lW?=
 =?utf-8?B?UEgvaERZL0xhSmpQaXloYjZtOWlMVUFQM0xCQVE5bVhxZnZIN2h1S05sMW13?=
 =?utf-8?B?SStBWVdwNHF5YUpkMm9KRlV4bmp1VHd1aERXZW11VXhza2VQRjZnU0FveXRl?=
 =?utf-8?B?QnBrV0dPNzMvUGpOTE9PdkZyWHI0bG5nQmFMTFlha0hra1ZCanh4L29hb0F2?=
 =?utf-8?B?WXluakt1VXpDNkxMeEwxOVdBS3BVRllRM3kxcm9QVGdINU5DT0lpcHltL2l5?=
 =?utf-8?B?Q3U1RTByVUlvT3d0VTVUc0FuTVFRMHpQb2F2L2pWeERNT0RtS3A2a0hSdlpp?=
 =?utf-8?Q?99lM=3D?=
X-Microsoft-Antispam-Message-Info: mG8g2R9NZGnrbCjQuCiHVzkhVxZn0cV54PwRHexu1Urk1lFYsvRYioLamRGAWzXiT6VflWwFLNzMbis0MCqxGAHOJtkfdglEz51OyrCw99dPsghcmQhT9geJoDrDlHPr60QnRn7PmEx08DOT7/24+D8AlF6mnPjyH/UJEccvoS+8/2W8AZknTRsFSRc8sROohZPtwQ8A81T/14/3vmENGrw2Emz0hQyzEaxSaSFnbB9xQ5zXumsdN6jh/a5XqeZySRn2D9AlLx5fxC6leNMXvNgbEpO1/uf84SpgzLyoY7yODu+afBEt147Bs/CgBUm0VZQS2qjASk+Pg+84Jf1Ka7wsjZjr6B0VL9MIkyAKy7U=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3254;6:8UlQ7rIq/WLOoKfpDXqbnuoi+rf0xt9NT3hy10+8AuAKKN+39ydfm/365Egp4fDNihxgKFq6V32vGUniqJGEjT/pMWuei69rMzaxJjVXBp+Zp6ikhjgtOxpypWHj2Ufr/dIve3n0dNf6mAp9rQJLHbZti463/N960K1wze9KFPMZDvFzq9iiNCRS0aQ8hQFlKoolFXHDWphosZdAG0YaXDiwpCALi0QgGsSDuY06pF91AwZMADOQcZoLmPnvUkw2X1YzGu6sJe+2zl/qXKHP553qnoHy6cEb/3WCb6o9ONt5YKx43g9YaA0m6VUGAc+EVk4zD8TJ1TTyFLYmTIGJBNjpDfl0souC63YDbZm0W30kcaYSg7hbqdI1CYVTSOQOEiQsQYyUeknK4GnzMHCfU55vAieSGdiisoj5HUOsojaJXgZmMFR2w5MUEXy1UVd81nQPmeG1MBeKfkAFdfc0xA==;5:LxJRQAZ0yb2xnUTihegbnQ6cyjZnv/EFIVg8J6irNcqUpuTZSUVz/YovRgPnsiHSFEPutaqK+CtKmbOMqT1uPcTE9TZ2Ap8GFWjcYRfbbRpXDHXmmE+SpRmKzZvipunhgc2WjCACI6Himpr4zBZ3zi88xBzq0XfkIVhXDCM+QKQ=;7:L1lCV1DfFPEyxnyegrpn8e8PM0vqxKlL+BUKJqe4NGabedMOoiHer3Ke08VQJU6SmYZiJj1geyNRvfMIcWBlNIEcjGNdpp5xr1Q7pWSqYpZE5FCflUaDUcdMDx2qwkGts65eAtVGAzBMvgQKM3Cf1fWNktGV9gw7gaGODWZK8SDdozQeVwvYO5Ns2SBeRFd5RzDZL98g1oiqMJYBoCH74qMhm40rAAkvR/4GsTcsiU41I3xjucZ/UWj+RF7Dxeo0
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3254;20:uDzqybRAmtqFUEapy8Re0cSf4ouh6aZ0PbA5sKk+dqfh2zXIaJUUT5Bwu4fNKeIZQpJ1R80g67bYCHhQEJBuUG6E5FHE85Zzo0ZK9C4FRyTXIbyQ8bCxHEgQxJI7c1dbCcYxKy9MTw+NuwqT3cnofAwc2CUIigeq2otZ2BTxpdA=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2018 16:06:25.3642 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32b2f565-820c-48c6-96c7-08d614dbdeb2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3254
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/29/2018 02:35 PM, Andrey Konovalov wrote:

>  void kasan_poison_slab(struct page *page)
>  {
> +	unsigned long i;
> +
> +	if (IS_ENABLED(CONFIG_SLAB))
> +		page->s_mem = reset_tag(page->s_mem);

Why reinitialize here, instead of single initialization in alloc_slabmgmt()?


> +	for (i = 0; i < (1 << compound_order(page)); i++)
> +		page_kasan_tag_reset(page + i);
>  	kasan_poison_shadow(page_address(page),
>  			PAGE_SIZE << compound_order(page),
>  			KASAN_KMALLOC_REDZONE);
