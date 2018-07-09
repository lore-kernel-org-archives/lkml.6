Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25002C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB90E20878
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="RJRo0nux"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB90E20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932743AbeGIIkR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:40:17 -0400
Received: from mail-db5eur01on0094.outbound.protection.outlook.com ([104.47.2.94]:11232
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932494AbeGIIkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:40:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/w2SmYyKMOHk76kuJud2BaUi9JV6ac4idzBxiXGBYE=;
 b=RJRo0nux35lqecE3pq3sheLvkTdd5TO5MCWOLQpjkDhLqqE3mwQ+zp4uTAw/bIfBDPjQ3nGZ9tlxe4Y+oYgOM+2tyjuxdlUC8rckW87vpCCXppa/UG3lxprTjDXlGqOaLEU5HjH1T1cpAVeIFSm5XGkY8plheljR8QnPdrRmnJA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (185.231.240.5) by
 HE1PR0801MB1337.eurprd08.prod.outlook.com (2603:10a6:3:39::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.19; Mon, 9 Jul 2018 08:40:10 +0000
Subject: [PATCH v9 16/17] From: Kirill Tkhai <ktkhai@virtuozzo.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     vdavydov.dev@gmail.com, shakeelb@google.com,
        viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
        tglx@linutronix.de, pombredanne@nexb.com, stummala@codeaurora.org,
        gregkh@linuxfoundation.org, sfr@canb.auug.org.au, guro@fb.com,
        mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
        chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
        ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
        linux@roeck-us.net, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, willy@infradead.org, lirongqing@baidu.com,
        aryabinin@virtuozzo.com, akpm@linux-foundation.org,
        ktkhai@virtuozzo.com
Date:   Mon, 09 Jul 2018 11:40:06 +0300
Message-ID: <153112560649.4097.6012718861285659974.stgit@localhost.localdomain>
In-Reply-To: <153112469064.4097.2581798353485457328.stgit@localhost.localdomain>
References: <153112469064.4097.2581798353485457328.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM0PR01CA0022.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:69::35) To HE1PR0801MB1337.eurprd08.prod.outlook.com
 (2603:10a6:3:39::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c04140c0-48ae-47b9-8d71-08d5e5779615
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1337;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;3:UP0sCpix+Sr1Pjwk7n9rl3lKk4Qt4f1FOwOXslCubmpms0jD4ctjrCpHhElfEcZ7OHpi1VGsL8KSOfXAU3vOXypL6KbqB9tVRXQnmY8Oq0k+CBYHJktmeH7Z2dwjJ2cp/78Caa6N5HiVQrX739UBfaC9AxO/YQGAY6rsch/ZpAnsPacIJ4HKEmdBJ3qCxuDzgW4XNs/i7OJ2B0pEY5pQ6q0GS1oD3aXyqwygEsmuq4lmGnEKFCkWNJpGg8/SxBmH;25:4Jj0gzWLz33hsowqhpka6yBu6U6m4w1yn3s1G8zzRor9H/+WZjgR7OnrGuFcPnHjmwQhm8lnxH0rkjt3JYNDjzgnZXwJeWo5keF+BCThLBX4DmEA/DxlGQTq58D7cqAjIXpImSp0l0emFCMAoOYrhrk1LUY7sjliT1j88zLAZem64uBKTR65musluUvQ6OYNVJBcsvTLkxnADPQ/75PHUFiNroyeEwi3rt+IsqBLSwMYc8LQ1V2MaAvGLMz3ginEVMpX2Mc9Qx/0UoB8M6Z/tIJqPFsuX/773P70YHw/jlilJorn6U0gQyDd/fGkV/1+wDYT4Y7P1gEGc+HXx7iCuQ==;31:uO9OW7nxnKXd7D4bPPjYXqSzT3VBSmazxJY1NYqRtw8i894YACgB38rfF0KwIBA0BZZusCzHvVZbmRZMIQ/9Mk13C0OwON59BFWYfJ8HnbpRgB2cPliSMZtHhmFbdBfwYZLyG+UxgVfkl783bDD3hG7FPoDo5VpDQ5phfsAjlnb79NNk9rQIP33MD8C8VdXtlZdPx7v4/VL7im3OYZdUxwzT7860x3HfON77g/nlhT8=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1337:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;20:8TAvsmIF2EcfFt0x4LkhC0udxmqyrYnZAtmfwWN6xBsMDpuHLp5cIvdbOXXmb4cWgvobFxFiBaYLTwr3tX46BfyL01byXfCzsRZlaXAz64Q6sR+0Y8bNjb6z1v+3tooSTdunbPEsFycSxY26LGoceTIwvR0Gh+uWpPy+zrh6UC7IsUtQC45Lx3R1LFxyfiiiszdcmvlFxk2dVm/+qhxv/S0x42QRgzNeuN3Ls6I0fyx2KgBwoNDne/+4T+R1lTeESmN4wSA8cmk/yXnW/AClhXTOhmiIXxnUztIPeC/whYTRShagJVF/ekfYKdv3he+J08D81gvpda3JTN6PmchPSSydfnr9/itdjP+jIE1CfvCWFXoq2eaGCKBpCufN5FfiaOoP3XmLt6sMnlK8x8tRL7a5sb3uhZjMaLg8+8uyknkiFlhm1LN4tvlV2hSne6mFBI7pDeCtgxPl7zEhd5Q+BwWR9nSfGvHtWX06mpIvA0MT0RW8mZukj5h86mYwAY5U;4:BqgyhiM0nuS0KKA9mg3o+qpL3dQvFry3HiiEebT4tS4/APBPdud+2aG2w5kBrTqMr3ICsVXONDGhPr/RMVd8pTN5Kcx7f9T9hWVodySLbvm7SjXb+z+IKcqyssYlOGB1Eey322d34Nvpek8nJJNtD1ST14xYLyGmM3hwakz8w9CAPtObKLe4ezv6aZW68oYsuhCSpRah3/tgpItyKKeGzy++IKSl92K2Kt1dazKFTUaCw4TogZIfT07U/T8lkNVr1xTF+evv8/9Gg3CIN3GnL4i/aF5vaSBXdDlIDYyWjXh4BrY/dMdHOl1ww8bMhbbEiNQ41A+v+wpDP3rfrEx11iEr/dqJDMZo3OK9VRBO8hy6h1gdlV/0vyyL6fFMruQX
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1337044097072C84F1D3B256CD440@HE1PR0801MB1337.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB1337;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1337;
X-Forefront-PRVS: 07283408BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(396003)(39850400004)(136003)(376002)(366004)(346002)(199004)(189003)(9686003)(14444005)(61506002)(68736007)(230700001)(11346002)(446003)(956004)(476003)(8936002)(53936002)(55016002)(2906002)(47776003)(486006)(81166006)(81156014)(66066001)(7736002)(3846002)(305945005)(6116002)(58126008)(23676004)(2486003)(6506007)(386003)(8676002)(575784001)(76176011)(316002)(52116002)(478600001)(106356001)(105586002)(50466002)(97736004)(16526019)(86362001)(25786009)(103116003)(7416002)(39060400002)(5660300001)(33896004)(7696005)(26005)(186003)(6666003)(921003)(222073002)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1337;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzc7MjM6REN5NDNNM0UyeGpKaWtlMWJJWkwzaHFk?=
 =?utf-8?B?ZHlhNVZKb203WDBtbUJJS3VsMTNlWk56K0o1bzdMQkN4YTJZWGY0c0pDZFJn?=
 =?utf-8?B?UzJ3REwzVWtMR002dkNZdmcvSWZXeDB5VDVpNUR6aXUrMmpDcURsZ0RLdTJo?=
 =?utf-8?B?QXFKb3hmZ3NFUVhad1B6Z0hLT3hQZmJIekxwWWN6STd6a0VvellHejN0WitP?=
 =?utf-8?B?UGhHdyswR0srd3BKN1BGQ1MybFhqUVhyRnowaDJBOWt5SUg4ZjBCdEo3MkQr?=
 =?utf-8?B?bGpZVnFqaWZ5ZENSQnAwc1ZQTlpaSytYTXM4M041bFhlUWxoVENUM2FzTnVv?=
 =?utf-8?B?em5qV3ZtUUJlaDNnM09QOUtSd1FpVmZ1MSthemFlNkQ0MitIbXQ4Snl3eTFJ?=
 =?utf-8?B?anpUbCtEcUdpZ3pNcWpuWEhXaXlVTy9EamZuM3JlYm1taFo0QWJsbTZJNW52?=
 =?utf-8?B?UXcyWGRBV2pQRUFlb1h3RHo5MkI4NmViZUg3NG9raURaT0dzdU82UEQ5VTdW?=
 =?utf-8?B?NmlJTzczQUt2QlVNbTBiSWhDVEJ6VWZCZkhlQThXSDRGOFA4eSt2VHAvNHNO?=
 =?utf-8?B?TGpUamxId1Y4VWZkd25LRTQrUExiOG1qMmtIUTlVZEp1ekxVcWttd3dweGQy?=
 =?utf-8?B?czFnanljcUw1K3hMT0NpM2thdDhvRDRHcTg5bUtJL2ViVUpZeUdqR2t4Yi9U?=
 =?utf-8?B?OEpVY3dTSEh0NVJUZGlGNWpCWGFXd3o2bjVyZkRUa2hRNGRXK3haOTVGY1Jv?=
 =?utf-8?B?V2w3dUhWei9PQnFocnRWOXJEVGFza21KKzFZbFE4bjFwMVE5cG5BUzV0MXpj?=
 =?utf-8?B?MTRzdGEwQjc5UGZBWWRYeDQyU1U4R212K2NSd0JSSTRrQjk5OGV6bUdqRVdV?=
 =?utf-8?B?ZEYrYm04MDFiMThKbis1OTBOdFlML2QyN3UxVjBlL1lLK2ZicVh3U1o5a3Zj?=
 =?utf-8?B?MWVhc3RXWldZQ2poZ3JraW92NjZTY1MrNjRmQndIK3FiMlpxamxPVTcvamlO?=
 =?utf-8?B?VXdjSXdOY01KK2xjSndhRzVXR25OdzNiMHVKUVJqRTJ2aHdKQWhsYlhuMldX?=
 =?utf-8?B?QUxSUWtiZFdlNld5Qk1sb2xnRkxqNnNPYS9HUWErRDFndXVvTzY0UDhFVm1n?=
 =?utf-8?B?Tk1qUE5pbXVWSVAyY0xKYkc2d041by8xUWJHbGtYL1QyWnhLVS9tQ09Qck1H?=
 =?utf-8?B?YkdISTNYVll2UkNxS3VBbUV6RkRMcTd0VU9tRHlXNHV0Lzhxd0hzT3ZkaXZl?=
 =?utf-8?B?QXlmbTFiVkw1VnpiUTJ3ZzI3NVJsNVdzVzlUT1RRUGpSKzBrM2l6elVKNmF1?=
 =?utf-8?B?SDBrWTlNaWtSTDFGS3RMTk8zU1VKWnk2ZTRTR3NhbUtnZHlOWW9vbE5uT3M1?=
 =?utf-8?B?YzRtNmRsQ1RURjRqUEtVbUUzZlRpRWc2ekNCcHVIdHV4a0tmbTFvYW13Tk9P?=
 =?utf-8?B?M1N2K2dVZ1JjWWVnVU1EVlF4ZkQyZHJ1TUpzVmQ1VitzRWF0emJ5QVlFd1N0?=
 =?utf-8?B?aU1kQ3BWS2VjNDlXVXNxOEluQTBKamVaNHplQmxiRlJwSGlRRGRBY1RSTzFy?=
 =?utf-8?B?Ynd2TXJoYzdZTVJBcVRlUGJ5ckVZazhITG5tekN4RWUxb0pXSklUWVUvS2Za?=
 =?utf-8?B?MnEwdVh3WEVuWjZ0WlFHOENUWjhoWHZQTS9VamNVcW1JUVVSVDRWZmN4SU9w?=
 =?utf-8?B?UWw1ajhkTlBxeUFQVjA2c1hDNjdFdzF3d2M4WnBqRHJWci9XZnR5ZUZSb1Zk?=
 =?utf-8?B?Sk9vN0RmQk1ybnRHdFI3TGI4VXZ3b2dmQzNUakxJK0l2a29wMS9KbmZnVFBy?=
 =?utf-8?Q?+sD1MkZy0+BdEvP?=
X-Microsoft-Antispam-Message-Info: PhM0g2gL0Qrp/IMDm7SiqxEPZq3nnFOeiufURBdVABcLTlYlQjGW/4KraZ6Y2WReS0cIBM6mW4B4NsnVxdL8wtx6GyFpx24yZHT3nquoNwBcvSefT+uMhd8mazDNnlGHjZrlvxP1+x+CSPSevKcXvCLOsewxDwOZRuh5PoiK30pIRQ9rpgUogEBAaioEdUxv/GddhdpEZVBq5JTfSj6QjuUuF/rD3Fl/10GrC6WSeve4hlm+KR+mqG61agGqi7E91mglEuKALjoOeHcSeRs1WPhugjSRW8hhSE+RAT/WHW6WUhaeBT5DbXSkJzd6rwx2wDgRlg9rcZqZnkcBZ38/IfvHkDSMoZqSatDviieGpSA=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;6:GSuNWABUB+dt8uxJYAZifNcPiqrfRP27h7Xdh84hw+2yH812OeMVipe/EhcM1tFPAwhoxhByisyPjNLJFgzGWVHZUmXOoKPKkzR+zjTjBe40Snvj1js+uBPQaeEu9irwhcTlGd19TsJkPC4W+LOczh0LTDxCPbOTSBFcNn0zElZAD0rWzrIpbD8Ss/NCQbi9zUVoG/1i6Af1DBNhx0TsnxZPxXgYoOr3QgxF+d0+59uhNvGVumwRd4j46bsBUUlKSZ9jaAoeqdKO7LfzBvKDQu6VQX0yLxFKyLVvHM/7u/xa/qUEdyfn46CWg7bcDMQfoB/w+W9NJW7Xk17AnzYU1THE8iUGJvku/KbHUaVdMeubqW3p66Xt9+Fnqmwm1Cve3HZvyhHZZn7hF15R0KF/GSeJuglyL8lSEPADJ9xjW3xw3iSTJDTaDe9gD/oEBTwK9vursDCFfOe3P2wCLloSBA==;5:FqQPX335mwRkT0faLf0KoJL0Nuq9N1aaYteh2X0BMMTbuyleWcEVsuiFMd8rfCk1CmmOIZTT7iSQ9rA5Rsl16Exr33dt7b/XKBfuF5jGDIQRQ8nufBvmKpQpzGUvSRh6NnLDTz5wYp9Qohm42ImeW/nsTxhhRNuDg9veYQaW05Y=;24:6nx06xX7+u4ayvFeABNJw6eKBEqxntKpv2QISs8UgqhwqrdNk89YwRchLRIzbEryLFDlXfPy0NMyZeN5ZFf8l2kbgjhxGP0deC7WCkQceyg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;7:3W0hZXxyFPThYAmWVjCzHrhXE/KMqTPHvlhPimv4rYfSgARx7uO71JTfmVPN+OcEUpOq2TS3Omc2uQ4zvpKa3wPGRrxLCDuWAuRiGzGZGuB17JJnERGhz3E2xcUj/uVcbnovq6O5U09L/rdfJ3tzFPr6l4pnVfMqvuQphFJQI8uMI7QPUcE5jO6taXTS2VyuSDVQy4nN5T8+HcgEHQTGQbOcPwjKJuXoK2dFITCAwN3AxEqpqTgYzLlVfKHv5eI7;20:yP7ISsLsq0Tp+V8SCJe/iWkKfqdUJU4TqAUio5QBV0oTko65DKWFpVHxQlqao7L6bM+j/gxduWITGktMjnI5yOBHaeUb3pxMOB3kAR/0LpV8ekuLPFhONG5kFDXlKj5444oIvEt+4FKJAyKwIwdVUtKDnvfvs4AU6ScPCn09JYE=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 08:40:10.1530 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c04140c0-48ae-47b9-8d71-08d5e5779615
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1337
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mm: Add SHRINK_EMPTY shrinker methods return value

We need to differ the situations, when shrinker has
very small amount of objects (see vfs_pressure_ratio()
called from super_cache_count()), and when it has no
objects at all. Currently, in the both of these cases,
shrinker::count_objects() returns 0.

The patch introduces new SHRINK_EMPTY return value,
which will be used for "no objects at all" case.
It's is a refactoring mostly, as SHRINK_EMPTY is replaced
by 0 by all callers of do_shrink_slab() in this patch,
and all the magic will happen in further.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Tested-by: Shakeel Butt <shakeelb@google.com>
---
 fs/super.c               |    3 +++
 include/linux/shrinker.h |    7 +++++--
 mm/vmscan.c              |   12 +++++++++---
 mm/workingset.c          |    3 +++
 4 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index f5f96e52e0cd..7429588d6b49 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -144,6 +144,9 @@ static unsigned long super_cache_count(struct shrinker *shrink,
 	total_objects += list_lru_shrink_count(&sb->s_dentry_lru, sc);
 	total_objects += list_lru_shrink_count(&sb->s_inode_lru, sc);
 
+	if (!total_objects)
+		return SHRINK_EMPTY;
+
 	total_objects = vfs_pressure_ratio(total_objects);
 	return total_objects;
 }
diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 7ca9c18cf130..b154fd2b084c 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -34,12 +34,15 @@ struct shrink_control {
 };
 
 #define SHRINK_STOP (~0UL)
+#define SHRINK_EMPTY (~0UL - 1)
 /*
  * A callback you can register to apply pressure to ageable caches.
  *
  * @count_objects should return the number of freeable items in the cache. If
- * there are no objects to free or the number of freeable items cannot be
- * determined, it should return 0. No deadlock checks should be done during the
+ * there are no objects to free, it should return SHRINK_EMPTY, while 0 is
+ * returned in cases of the number of freeable items cannot be determined
+ * or shrinker should skip this cache for this time (e.g., their number
+ * is below shrinkable limit). No deadlock checks should be done during the
  * count callback - the shrinker relies on aggregating scan counts that couldn't
  * be executed due to potential deadlocks to be run at a later call when the
  * deadlock condition is no longer pending.
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 2aa3cb760189..8199e1b9a204 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -456,8 +456,8 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	long scanned = 0, next_deferred;
 
 	freeable = shrinker->count_objects(shrinker, shrinkctl);
-	if (freeable == 0)
-		return 0;
+	if (freeable == 0 || freeable == SHRINK_EMPTY)
+		return freeable;
 
 	/*
 	 * copy the current shrinker scan count into a local variable
@@ -596,6 +596,8 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 			continue;
 
 		ret = do_shrink_slab(&sc, shrinker, priority);
+		if (ret == SHRINK_EMPTY)
+			ret = 0;
 		freed += ret;
 
 		if (rwsem_is_contended(&shrinker_rwsem)) {
@@ -641,6 +643,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 {
 	struct shrinker *shrinker;
 	unsigned long freed = 0;
+	int ret;
 
 	if (!mem_cgroup_is_root(memcg))
 		return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
@@ -658,7 +661,10 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 		if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
 			sc.nid = 0;
 
-		freed += do_shrink_slab(&sc, shrinker, priority);
+		ret = do_shrink_slab(&sc, shrinker, priority);
+		if (ret == SHRINK_EMPTY)
+			ret = 0;
+		freed += ret;
 		/*
 		 * Bail out if someone want to register a new shrinker to
 		 * prevent the regsitration from being stalled for long periods
diff --git a/mm/workingset.c b/mm/workingset.c
index cd0b2ae615e4..bc72ad029b3e 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -399,6 +399,9 @@ static unsigned long count_shadow_nodes(struct shrinker *shrinker,
 	}
 	max_nodes = cache >> (RADIX_TREE_MAP_SHIFT - 3);
 
+	if (!nodes)
+		return SHRINK_EMPTY;
+
 	if (nodes <= max_nodes)
 		return 0;
 	return nodes - max_nodes;

