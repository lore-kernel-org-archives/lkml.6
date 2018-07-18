Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A6FECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DF3E20850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=eurac.edu header.i=@eurac.edu header.b="WOvhtc0S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DF3E20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eurac.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731104AbeGROxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 10:53:23 -0400
Received: from mail-ve1eur01on0078.outbound.protection.outlook.com ([104.47.1.78]:11261
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728671AbeGROxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 10:53:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eurac.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HjiRv4FS8j4LoVT3OZwCJu94XqQwlvCRrfS5l6CWqrg=;
 b=WOvhtc0S8Xr1+H7jyJXGDjgnmSAwfi0/TM7Zmk4GED+KPgI/am4w4FVKUERVmHSIPoIZAssYUFzfPZ/wAeHks2h8BhQuifVjoxGIvoJ4V/ZPENdK0pzBz/rDOGSH+h3gM1+lGW7PVwFi+fmKRXC7ydOpH7SoEW4txzYAnNYSkQw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yuri.delia@eurac.edu; 
Received: from localhost (2a02:27e8:20:9049:4a2a:e3ff:fe02:7265) by
 DB6PR07MB3191.eurprd07.prod.outlook.com (2603:10a6:6:21::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.14; Wed, 18 Jul 2018 14:15:12 +0000
User-agent: mu4e 1.1.0; emacs 27.0.50
From:   Yuri D'Elia <yuri.delia@eurac.edu>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: CLOCK_MONOTONIC advancing while in s2idle state
Date:   Wed, 18 Jul 2018 16:15:08 +0200
Message-ID: <87a7qo4olv.fsf@wavexx.thregr.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2a02:27e8:20:9049:4a2a:e3ff:fe02:7265]
X-ClientProxiedBy: VI1PR0802CA0046.eurprd08.prod.outlook.com
 (2603:10a6:800:a9::32) To DB6PR07MB3191.eurprd07.prod.outlook.com
 (2603:10a6:6:21::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa8c3549-c0d2-4e93-0eed-08d5ecb8e04d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB6PR07MB3191;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR07MB3191;3:8k2M6or2NWJjPo3fLcJ5VB6T62FXmHZB+2QVmIt+97bnNfm8yau7RLl1MOwQMm7gOIL2xY1CJTPs2wbXjrmMXMU3QB4+luLjcjoV+Nhk6fgyUDHNgefIGjYUGM12ic56Qtm6cdPm4kIycU7BrVUZAIyyJFj/KCrqHhHwDA/10WQt5Sjint+qX/OTdKSW5ppl/0Jon0dqvF1fycmhMQ07Cd9COCQLtJC2TSWn0cUJ+DSUXmoBouLm8KO/a2MSohSu;25:N7m2HoOin1OANQ9p4wwGRMHJYTWezq+dibxodNjhJ7OwsgEAht7DkiK+LSXPCWDduuQU9jnUqVfi8OQOS3Y5NWY6CQVCKzvgFLi3iGILuSpYVn6dESpgDxc1kpPp8eMbLvcPOzxndtXL22KXIbl/TdRbxGsLxPjl5OGvcmgjzLajXOeg0rueQyJjnKxn5/hMcGLudGsV5QSE8vL1EHMF6hJInSYtC3Oqlz58rk/tqMrt4fhPmpK5JfGZE5wCz64RITnpYwbxp6gFBWFJXGIvfLPJKFzMxr3YxqmVZ8vxkBRO6+bOgeOUS+xkcJSe4H2W5o0hJmTi/xNZ+l68VuTeVw==;31:WpYUyp5+rzgt41Y9yOGMRvtU8kHrA5KT0K52bfH1/7NsomtAJaEHy7A6eMlIQQ2U4+6m9UZY9LxyejptKU+PhS8qs27wtvPoApmJctPAr5OrGkxbBopscDQsWcdtpq2ubFQcJu6U7pAm0IGqHRtENvTJMCpPOyEqCu4pRJaL4bcz2+ds3GPkzl30KUovrORoxmJ2Q8FCh87EPpCmVYwCGGCnL/bcwJFdKaN4DfP+e44=
X-MS-TrafficTypeDiagnostic: DB6PR07MB3191:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR07MB3191;20:E8mCSgOq9vvORYPOAE5MnoDQmp4cit1lsshuSZDExWGMbqaZcojYcxLtFQwQmtLkwhIitH2CtrGiMGTZDGg7nNQsqydcStHNdGS99wYaDBG6rZgr9YsyEEnEmDsAb0GWnRmdHWDoQJ5H/4gJXoOpIQVfQJDIXomzZ9Yq3fnHNDzjW8dI4R5WfCFF6PtxWvRojhUiwTsfhvU/h5DdTXyITo++Veadk5nw+EgsJOMEGj8UCUu4Y83ymuzLiy9BC3i0RusQliS2IvH0fPZ2mjGzM5DuQOOg5HHkcOGPkd1Zck8QkFNPRnqgyy9MMOAW5TVX7KaNpoa/7lGitWJAfeLrYw==;4:ce11bJ5sOXxJOKVoPfDKtLBBDBI/I3rlnHjUlEfkggURsHDE4mtpgyteoFlTGZr99Q7CnH1uHVgVsMmf2zDMJ0wLHvw60Gzj+yKBNSTWMoey0LBhj1Dllw2jsmD1fizjtAcXi/R/jY/Sw5U3W2wKiQNwrQGcv+UA3Jp8UIT97ewtZafGVGiqS+GqP6Ek70BUJR2F8ettpbpcYtzUuoL0MTwOb9QjwBTSixentAjejeqGXDzyT7TnYP2xLgpdPf3Y2r/MdTVs3qtk5Y4x9k0HqkQzmTR673mVNwNUnSGWtCj6Ut/PRAONFLI1kl5jbqW/upBHTpzPlfOflZN7q7IBAnCg1F4iphFnQbQXfexPUE9JZ+Q7A5akXud23UrQLEoV
X-Microsoft-Antispam-PRVS: <DB6PR07MB319137A10D3C52E83ACB8D8B9C530@DB6PR07MB3191.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(3940261145250)(166708455590820)(123828680558944);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB6PR07MB3191;BCL:0;PCL:0;RULEID:;SRVR:DB6PR07MB3191;
X-Forefront-PRVS: 0737B96801
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(366004)(39850400004)(346002)(376002)(136003)(396003)(53754006)(199004)(189003)(33896004)(58126008)(966005)(68736007)(86362001)(575784001)(478600001)(46003)(48376002)(6116002)(50466002)(6486002)(7736002)(51416003)(52396003)(6496006)(75432002)(53936002)(8676002)(81166006)(88552002)(14444005)(16586007)(47776003)(81156014)(52116002)(6916009)(25786009)(386003)(5660300001)(105586002)(2906002)(186003)(6306002)(9686003)(786003)(316002)(76506005)(16526019)(305945005)(97736004)(486006)(476003)(6666003)(106356001)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR07MB3191;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
Received-SPF: None (protection.outlook.com: eurac.edu does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR07MB3191;23:NzAvAwq2kxWQIC6AHLcg7aToH4J6VzK/RbhR+dXhA?=
 =?us-ascii?Q?WJZcGCpSdABl2BVRFwx7VEQdPAqICasraOIMFzrMXNKoiWWnLGf6KfVnEPXd?=
 =?us-ascii?Q?boeRY58lwd0tyC5dqLD8RP1l5Bi/qWESa1/NULbS3oV2tybGY4HfZ65J4CyJ?=
 =?us-ascii?Q?DnEwB2AnE6H9jSIRQsmKO0HfqWsrfckMRFpKEEY7vSP+cVifyMeYJDGwRRUu?=
 =?us-ascii?Q?YEFIdg2qq/qyLveSyc2rhghPFZPKCgDrcz/cal71Gym5lUBNFM+t5e1N6lew?=
 =?us-ascii?Q?gwoT6ltZMWPMPeqlKSoz42ZmuN8Wgha0MyqMACm7IiEHTKsnSwos5Q4V4dsv?=
 =?us-ascii?Q?xLewOxVBXht+X5/n5jbEc3hsOYJeim8HFRqqgrg4gY9h3j3ohyNX7SVTZPIo?=
 =?us-ascii?Q?sXRa+qXiGScVn53aqXlk/ljuzAgr4NMYxixIPmcBptyCKI/jmytY2EeaKSH4?=
 =?us-ascii?Q?2PRzxrz85ZTeQDQGis02dkHTW3CVhIMdjY/opZ3uGzUzbC43vm0I62H5TDFY?=
 =?us-ascii?Q?s+BiQgJgdvV9haGrtjV7C8Jq66whEc5z3WXZvJ38OvTpe5bOpSEGPcFpuE+a?=
 =?us-ascii?Q?sqKdUU9bSQrP+nP9CCLwWWRbwQhzQW6OhG7Z6aBwwWLKXxC7mW7cyIwPrKY2?=
 =?us-ascii?Q?gRwwK8zB/5hMu9mpGcDFl2fARxTOlK6pBhcjxCaxIRE8u5m7twtnIgmxmi6z?=
 =?us-ascii?Q?tRCeP/OM8FiV8aj0lzIuLXeclzlMChb/h/BpehNRvTMf4lOyWIX3iuXNkF9C?=
 =?us-ascii?Q?O+xZJpNrXoR98EAOy4pcRsRuC4jOOMViJdG2Y1hfMAcDkHb3yWBtmwNeCw4B?=
 =?us-ascii?Q?xZT516nxC4gbOdF/ASCB0YOaE+kzYunaauaI6TM+VffqJnkzHGF3iIsO7Pa3?=
 =?us-ascii?Q?vQp6RGdBQIu5qhPYTvh16s5XoyWRwgLi7ked4mo5KvymXpWxCpfwxz1fDxav?=
 =?us-ascii?Q?CaaxwpLMCvTGyKnlAG2YbgiI5ysh7lbTJ099sEQwUL+R4EAi0JEtyyPefsbP?=
 =?us-ascii?Q?HUcd2OyqINTNqGllZFTp0n/HbsmVOq1xzgt6t+inA8AdP5rsyhhvarq0mrWE?=
 =?us-ascii?Q?ZF6+jCLRZVhXrrP4Wr2rxy9FU8I9LUWyH4g8lVlRtohgksfdqsUTraoF0PsN?=
 =?us-ascii?Q?sUmgzpVS5cHP1b5RNrD/HEzc9EW8BVL5ENI9zGSHXcHXKIz/OpmVkPo6PLVG?=
 =?us-ascii?Q?t52HlUvIkRCDysswA9TkXFRkr5caM34P2og5sm1MPR09O5SCZORoWLjA3ydU?=
 =?us-ascii?Q?z58DlgYkivem28TKpM=3D?=
X-Microsoft-Antispam-Message-Info: mLvlw+IH8wHRrwfTSADFFnyEYn0GeJIlZfILBleNxYb2q/r0WE+ltf8sXPqvBn5HzmxnMlaXkqrjeWXYNuxpBtBt3WqW4OuBwxQ1wvFi2fBsUbvYiHD6dhRhJrEGNXbwE0ohV0AUt5rRvHX4KVKxsy8l1xkKKsthDNN1VkWZUbV4GfY0S7WpzG/GTB4pyS9hs111LkjXQOgDLrLIok+CEbYaD8ZTL1LYex2wia+pe5pQInyEo95yaleYJgqvyHEM++9g8gcpX4c2pTCqmb1civx06/+81mqUUHRskw0tuzV5hUV5Jo0cFIsRpS9QcafRQEEp2v3j9FPBjpwgF8aemdatBGB+gGW8CS8+DJ7FGqg=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR07MB3191;6:8JBB3jVK0W8pnPNRun/Zw5JI4f/2Gu7AbJKYa8IsbyRDTz97Ej+QAj8IsmwPVfidaX7T6LdA4Rje4V7jEEHw7uD2WAWa4wy43kplD/IZRllhqD3s0l4ALRJGw5YeVxIJ/Wd1MsgCZUo9bb40jzW0INs/kAkFWMY5NGzt+9lVYOVVq0kr4pHZq4gdWy/BjQClHB191Pdy3jjIYK2VbaD+znfQxd/p3E+7NWHJiLAPsD3k/JAi0GG8RK9rPo0N1xPYCY6vSkt4kbKndMteMExqmiALSD0XQFLm9Wecfj9xXdR22dIuG/vw+WGtDahveZcIsd7UTIWPnLX9mpYIxpyDvk3ZE20drdNZLIg6j6/ouXclj4MZPyeqAR2UywxrOSW467UX77B0tFRyOOwW2iBtO8Sv2fIRiXb7iqSOcbrmaPq0wDQqn5Zu0W4PbjFDurrqLLbWAIja1HUvwLXE4w6ycQ==;5:hqW432mFE1W9eaXk2wGdq3+xGs3cU/Ni2d9qMzzcpfZjBYJFjMpMzpdDijLnY82+xIO+SmeG6wYJ/LfTuI91H8itc9d5yu5gWXbD9aHX2eDI9P6JZ6Pkln91pA1BxdgyeCOjVb7tXMagQTUlCUl5xJG+JrcLaBMM0gSL9kbIk7Q=;7:HS2qIfTLZyyHylhxu9NvBC5dvaWU81ovPGgxnJd6/l8ysHgcCLV9XQgo9W+oCowKwObecYXqh2jvygzDztwuef2nxYbeBa7LWDHz1WRPm6W0H5XICYKIaDcc6YqFDOWmeVFX0pUDioieGhWGzZadndM/W9RayTeyLbnNeSPExZ5LbeLmeWDVVib3v0/tqz0C768MkgjdTlwjh/M96tKi4ZAZThWjtarT/ZWpMtJnvymFY7AdZy1grjycknU6I8xW
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: eurac.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2018 14:15:12.2175 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa8c3549-c0d2-4e93-0eed-08d5ecb8e04d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 92513267-03e3-401a-80d4-c58ed6674e3b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR07MB3191
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone. What should be the intended behavior of CLOCK_MONOTONIC
during the s2idle state? Should the clock pause during s2idle, like it
does in s3?

On my current hardware, it is not.

I randomly discovered that the Lenovo X1 Yoga (3rd gen) and the X1
Carbon (6th gen) do not advertise S3 anymore [0], probably to force S0i3
in Windows. Buggy bios aside, this causes this laptop to sleep in s2idle
mode instead.

When waking up from s2idle though CLOCK_MONOTONIC includes the slept
time. This causes the systemd watchdog to kill journald [1] as it
detects no activity during the slept time. According to systemd authors,
this is not the intended behavior in _any_ sleep state and thus it's a
kernel bug.

I verified this behavior from kernels 4.16 up to 4.18-rc4 (debian
packages). Is this a bug in the implementation of s2idle?

Thanks

[0] https://forums.lenovo.com/t5/Linux-Discussion/X1-Carbon-Gen-6-cannot-enter-deep-sleep-S3-state-aka-Suspend-to/td-p/3998182
[1] https://github.com/systemd/systemd/issues/9538
