Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZqSvDrWgNpTh7MXM9Ebq76xp3cyIoCmDjwCyVmWlzzTSLcQhfOWWeZ+YtHt62uux+CW3A3a
ARC-Seal: i=1; a=rsa-sha256; t=1525945970; cv=none;
        d=google.com; s=arc-20160816;
        b=QYBOMkga/d7B/JJcumU7OrKnasi4DuX2Wk34xQS0Fif7Uk+/cUIoSIU2Ewi17kZRXr
         gAf4+PaDThPGkcPZeFS5x7VjkiDSvoCcdH06ERZ/NiwqZd8KFVyDzS+Sv+XifR887bIk
         IvlMJWbm0l/rA0PF6juMly6yOHOTm+FbuHUPWycnV0hAC1eY1chA77+lhE9NuNTJAZ6w
         ZWbHfBLOx2YvqrYKwd2LX1U1E4jayn85MmiOLG70HjpgM5eb0tFoTk6Ia3wmlXjn+CH4
         BJW6USQx89Ow909cviMrHT7kdOtlH05Bl6FXux76zMhB76xuCE8Bz1qq5hNzfh4DgjWM
         G71A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=p5DKsGBLogdybKk+PH0BJTytBdygtv2nnc8duG6DFqQ=;
        b=AiVF1OGzd5AsfntGDk963FBG8iS2zFwkY2KF1Vvt085hbQF/lHm8dqEJzfXY0fVdOI
         uQu60EcpmhEOMZX4pznP7dGZ8DehKnXpfwPIYf1jvssGLtdEfKYsXuwHqNpKYtKxs2Cc
         rfv+rDdEvq+XdY68/o0ZvEMWyVqMVjGdlubFD78I89+e55DXFA/+DzsM+P+MktlMqPvs
         c505FvR75GHTSAV/KnQCRSAGhCIdPhxcF//RgysUo/rYKf9DFv319g8p1a9eazNZxpE4
         fJnAGfjknmWt++OIEOVid6gq6RnBCDyJWefzDhJNpGRhA8le5CwbQSN3s+Vf8XNUSw1M
         t/Dw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=MWAx7O+c;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.2.94 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=MWAx7O+c;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.2.94 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Subject: [PATCH v5 03/13] mm: Assign memcg-aware shrinkers bitmap to memcg
From: Kirill Tkhai <ktkhai@virtuozzo.com>
To: akpm@linux-foundation.org, vdavydov.dev@gmail.com, shakeelb@google.com,
 viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
 ktkhai@virtuozzo.com, tglx@linutronix.de, pombredanne@nexb.com,
 stummala@codeaurora.org, gregkh@linuxfoundation.org, sfr@canb.auug.org.au,
 guro@fb.com, mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
 chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
 ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
 linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 willy@infradead.org, lirongqing@baidu.com, aryabinin@virtuozzo.com
Date: Thu, 10 May 2018 12:52:36 +0300
Message-ID: <152594595644.22949.8473969450800431565.stgit@localhost.localdomain>
In-Reply-To: <152594582808.22949.8353313986092337675.stgit@localhost.localdomain>
References: <152594582808.22949.8353313986092337675.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: AM5PR0502CA0008.eurprd05.prod.outlook.com
 (2603:10a6:203:91::18) To HE1PR0801MB1339.eurprd08.prod.outlook.com
 (2603:10a6:3:3a::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1339;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;3:aksJC6xDWcvR29u8vVl6Mkrgo5Yz4TUTBvqsHz5+rtwp1qD4AD2ClHPwZjj2elg21l+x3Uk7JSE0QYfjRHL/jnpCFgvyegLESorly7+WWAbmb1TclyIPZv5cB1ZyG8uZlz5NSFJzXiTqD09YH1kANLEzViwtaEZMu60HJJRsgHdBrJ2CzwNKoiv5N9asJocrVrCi526U2mMrYGxPPQ6K5S03GQ2IwvsXW8cLtScv3o+btA5ycBY5M2VBMN0IfLVa;25:rsPPc/9Iv2dlHTYHrEeIPGDrNEeOBhQbMzV9wfcX6r33W9jQtwj1OkLNfVJ2hm2YdEapBtDe589PRVly+5xsk95IRCdqqwC6onnCKCKpozUG9BaJQeYsLJtk53IPWED31zfBTnSp7VWL3OXwA736mNRkF2h6DY16gBZQthUZN47Aoc0vvyo/jgjgEhjP4DrzO/Fsr+2/otma9qC7hDZtsjd60q6R0/EnVrV6s8G1ZCGvrqcweL8vxCcUHm5De4SAlfxqLSRX0EQj9w+lqYXycyqyxm5scbanlC9ZwzbZKPFX2P3r2K5X3jerN+fuLJn7pa5Up9GeNimnscXdGJL4Dg==;31:ZCLJZGHPjSQYW3IxtXXEzzZnOh1w0OTB/KNgtshffg8H/mmoJZP/7ky1UlwKOlB5jNkhnqd5YhhKFkK2jutujlOU3GjqpO9D4yzdN2f1nLDRJNq2I2Ccuq2dSd/8hSOiKe3JVLsXJUfTnjb/7rp0e+Y1n0/2X+Kqt5gZ2AD4bE4K/qxGzBvmSEslhWxfGCr8uAC/EMo5/dWlD/r4MvhXvSC9C87JImfkuk5qUSmJLCA=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1339:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;20:nwVgtSPoWTzwTWdCKop2XeJzqfwWHrD9fViCGtPlV1y1H10t/wzeyKkkjtaCaswts3ddpufoL7//J6+WYCjVulw/HBX45vUiqz+2Xv73c8NAPdrBRP7fyr2Wr9wwliu+84iCyqgsKX1ERH34SZIWCEMt6bAi55PKuTZbuRSE8QCac8LQHWjHC28aCauZHvPzix9cU0MSYM+uYHBNdqEdacsgt9u/pTJqAaoWly6JpBYSsQFs2janTQFcHTqSz9U4jkPdSpWpaX2riUkGfCYbgRQObcmssoIAhBirAQSZuFO2EOsXdIsX20MK86f9J5KIVPpRPa86tzwjbWTKodCt0GSHHeX99Ci+0Be39+deFWVSi3jMx1Ws+8LaUQvSfddUlhFtKSW9b7+sKecQ7qkUi3daH2XIHO61NjiwnaqBSnllBmvuD/U3LYYuEj13K/Hc59Sqa32jQmhRn78Pj4WoTaxUuRigYKg3YF/KxJftf/MHfezxqv1ED9yhv+CyZmjH;4:P7XIu6feaLNwWm8kw9m77EKjN4rm61P+rN6qYCY4FaanUeqmehL7IbOk+yhNUy+ARcPLR+kvjl3BqUPdbTnPhzUE7XpJz4b7k9leNFgPcuAxpmlmgn7Fcy8yW/ApB4LWsgWf0gAJ9Hqz6liVp7JeT7SBnDmp6+YmqHyMdWdAl8b8QIigP4x2SALMrw6ei9dP+Rt6n8CywZvZh6FgoHnIHdSx76H1xAlSmidX1mtWwyqhuy+0tXA0g3jQUrpiu6ijKpP9j5l7QjaCysvmYKFDqtTVwtbv8WV5aR1ukqxKXpnXF9Yf+pxHVlDShxp5nQ37gmVJbs9Peou584VXenFrZ/uGQuJX3kEJCMY2ilCnI+I=
X-Microsoft-Antispam-PRVS: <HE1PR0801MB13390ECC67A34757A8F83C7ACD980@HE1PR0801MB1339.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(209352067349851)(131327999870524);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:HE1PR0801MB1339;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1339;
X-Forefront-PRVS: 066898046A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(346002)(366004)(39380400002)(376002)(396003)(39850400004)(199004)(189003)(316002)(5660300001)(58126008)(52116002)(7696005)(7416002)(25786009)(7736002)(2486003)(478600001)(186003)(26005)(8936002)(106356001)(305945005)(81166006)(105586002)(76176011)(97736004)(103116003)(23676004)(16526019)(8676002)(81156014)(55236004)(3846002)(86362001)(575784001)(6116002)(446003)(11346002)(486006)(230700001)(66066001)(476003)(6636002)(6666003)(956004)(386003)(53936002)(6506007)(9686003)(50466002)(39060400002)(68736007)(55016002)(33896004)(2906002)(61506002)(47776003)(59450400001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1339;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzk7MjM6cnBzYVMzcmVaTWRwKzdlTUY5Q0doTGtz?=
 =?utf-8?B?c0lleGowcnlHWThZZVRzbU15aFdrTTd5a25yRzc2a1l2bmNpUC9NbndDaXhP?=
 =?utf-8?B?NEwyc2xIVy9Vd2Z2dHdrTUl1WUdtYXJIT09RNERyV2QwZ1JyRVB6a0s0Q3pj?=
 =?utf-8?B?TFZYMHA2RHZ3ZCtvNDc3bk9DamtIMThNUitYVjdTUHU2UmpzU3RVTnpBeFpD?=
 =?utf-8?B?OTRCK2dBbVd0dFdSMzh3WXYrcERJU3o5MUdLSmtPUVN2L3RHSjhqc2tIenpi?=
 =?utf-8?B?N0xLOWh2VkV6Vzg1TS9YUThBNG9tWEVJQUlLUFg0TitBZCtsNzJRMGNEVUtO?=
 =?utf-8?B?Q0FYOUdEMkwvVGMzaFQ1NUdvZ0RXR2xEMkROY0JZUkhWOU1hQklXTkduRElS?=
 =?utf-8?B?d3lIcG4vRFpkTFZjUU9abGlUV2xEbFh4MGJ4U3R4MDh1clFzYnNnSFptV0tr?=
 =?utf-8?B?OTh4N0h6N1NYZWVzTzFZZVRVVmwzUVp2K0hXRSs1dHdiaWErVjZ6WExzb2c2?=
 =?utf-8?B?alQ3ZG0xTGJ6T2dWUk1FZmtQL0duSzJkMkM4UHVHV3MrUUFuSnc0bTJmTmVU?=
 =?utf-8?B?bXlmbXBoVFRqRmRrVUxOSkt0bUoyUjN2ZVhsOEwvS2JiQXJzMnRDS21EU0RE?=
 =?utf-8?B?V25vU1dvSUdPMlJlbnhJdk1aTmNpb1pNODZpcG5rYnpUZzFVcGtUNVRqa0dM?=
 =?utf-8?B?SXc0QlRTR3MrNm5lRVk0RHlyM2pDdGpUL0ZQOUNZamJKT2Zpc2VCczJSUi8y?=
 =?utf-8?B?ZUJIZWRZaWJWVGF5T3ZxT2drN0Z4NkNPQ0lKOVRjOVo3MWtFeFZZdVRxSTlh?=
 =?utf-8?B?LzgrVDZzbnk4OWtOMmhOdUtScXhEWE43d0NOZG9VLzBVSVlXWDR1WkI4bHZm?=
 =?utf-8?B?ZXhSQWtpbExEb05KTllEKzluTHJ6bHNERnV1UU91SnVjV3Y1aVVpTVMrWk8r?=
 =?utf-8?B?QXNEWDNkaUxzQnowZlh1REdiUCsxNk9lM3M4c1VxejNHdlplVEVyOXV5ZGtC?=
 =?utf-8?B?YklMUys2U1ZHYVRYVGN2aGMvRCtGMUVRSUZRUVk2dCt0QXUzQVo1dHJTR2tZ?=
 =?utf-8?B?UUc2RG1mL0tvQ1pRelk4TE5LK1hsWldIYnIxa2c3YzRQM05rbVRLUGNjdlN2?=
 =?utf-8?B?cmpLTU8vY2hvYzhwczZPQUtueEVaNE9QbnFlYXBHQXhFM0h4akE5bWM1YzF3?=
 =?utf-8?B?YUFwUFd5elJkN1owd0FLaVNIMUNjMGR4ZjZlWllJc3ZTQW4yeHpCbGdGVGF4?=
 =?utf-8?B?MTZhcmd4M0ZUNkhRc0VRWXdFTFBYb1pxSUdqNm9idktPbjUwVVRObkJVUS9J?=
 =?utf-8?B?ekFVTHYxdWUxUTN1amE0cFdFK2pTSFNPMFliRE83Y2E1MzdZR2sxMDNFTnc3?=
 =?utf-8?B?ZHNzVDhJbmVjK3JtQU05bW9KTGJ4TGticmxlZ1Nya2xmZ1dPaUtReFdQRnIv?=
 =?utf-8?B?cjFRaDVubzJwUWNDVjh4RUJyVmttMVc4NDVRNEcxSXJFekgrZWVDWk41L2dU?=
 =?utf-8?B?VFVUTmNGYk5Xa2p0Qk1UQnhPZ0ovYytvVENZTUxBaVRlaE1aS3R0TE9zSTBi?=
 =?utf-8?B?Yzh1ODIrSEkySnEyZEQ3Q0hBSmRwa3d0bXROS280cE9tYzlpQ0x2bytBYStJ?=
 =?utf-8?B?NWJldXFnbnJlOUJZdDBvNG1lMzNxOGMyVFlMdHpjM1ZoK1cxMmZTUGhBVTFN?=
 =?utf-8?B?MWdZUHhtbkd3Q1VaVG9XQmVwNlRFQk5OcWlLcDFZYXN5cStKbTN4MUhna3hD?=
 =?utf-8?B?bFE2dk9XSVQ3RGp0L2pTcVpTZzAyR0hqdmxHeW5QT01NeXhYSnozNmJWUnlB?=
 =?utf-8?B?NEZnK3FSL1d2QmN2cjQ0akpzZ1dkOUpOWWZlMng0Q0xmV2FURmluOXVsUGIv?=
 =?utf-8?Q?MrfWPU88zZU/M=3D?=
X-Microsoft-Antispam-Message-Info: YRMYvz/kx/z602J4Ehi4tE3kJa6ZTVn/m6LaG4UaELkAWB4XSTRw0Fk+a2nMSA28yZCcBtHG5en/nyUzY7yo+cABiONvT0Pv8e9SjWfzC+5dGG5oXT+JuBYZwGB+LFWhhAi8Ug2af2Y+lkrG/IsnN5JNzWftmbchPSSSMH2R8gn8dWGl7kGCDjdwsL0hQpHA
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;6:Tllb4BC8p44dKqAWcUWh34MeO5qMK7OpVvsMUlpntW6+bc9+kfrjmlMRnmT0qbfIK7Xq+Ik3qEi2vZKISU4rtBr32jddD17W8O9drhsLbHmuxZQ3q2Kw+mDH7qiowubHVqDzn9zvOetA+vZEmHp6/kKcel/fiYjJHzAowiEPN0N3zgvLZ6UL31uc1BDJH0E+lrSiuqpOXylowjdC+PrBuvHbt8/W7luCHFc1CtGUq5B8Kt+zuo030u18v/QkemXgBGQBTGL9RsrqTJGX+8I3z+lt30AWC43jhDIvxUWofmfEBpMlMU7/AmTXI3dXIAj9RBXL6xEGcBOsO1h1WhedLjQ/Iw2FWDuLYtjboWKMP/aIiGT7FHdxGjYSiASENHTmiW4/DxqlQFxRiBsUg1CvhHXuXtLarD1pU/mU/XMMuAiYjB94alTot21a1cRLV4zSjmUwEknNAIW0CRZ+cJKL+w==;5:qFTOSDVdjW03orNdcOhPH+otXcQ0eCLuXlpC4mBSUhUmXw8as69vHBODbALVzjKMr5sYyPmFBEWn4JakIgtCaY1NykVwNiQSaxMhffx71rxrZwen8uKW+VF/SuKcGNvZ+ifivKZFXYLulxd0rWtwLnTKCg05PTcaaummd4xVJg8=;24:hXu9JaGssjKB4oyvFJzb0MXrmByYzdXodnYWNUen0pObW4jolQrn7M6xgGLtyeZ01LPBKZuTOluYOtpc2XmDJC3pt5eqpqxGDqt/od4Ls3Q=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;7:BKdvButigbKipjPhI/3Qj2q3/7TTxSv1o5RnF38Uuv+4JuL7sIBK1GO4rw7CAxuDvJsJnjCy8s8XWGOrHwC6XCahcenAA/IN0vmReXud11UUIEhi+Lp2EfmuUKx+63jFIxl+zd4XWX79Xo6Ix2O4fVXmNUJmKGiy7c2+TnQ/Nvf2ZbWq7C2bG+uRZtBENdMsJ/g7EA2O/3fT+8kDawAlQzejBmpBMH68OjjnLJOms/rAnhCYjyGlMIIOjfvboTXr;20:QyMCsPaH7DBd60enAPsBR4BQIwGubuHFl/YiQnfPsRn5QbLlb2+V97oGdsM00g0DFwqfCer8+16LTzrSwVLSN5yjpEJqQAej6eaGmsZEBFzkh84McRmudrlTrOZ0w3ZJXK8DIlRRlZyIEIrDgcoc7RIA2xZa++KGJbf6YH0y4JE=
X-MS-Office365-Filtering-Correlation-Id: dcb70ac6-638b-4062-7484-08d5b65bc576
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2018 09:52:39.2696 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcb70ac6-638b-4062-7484-08d5b65bc576
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1339
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600070321367125899?=
X-GMAIL-MSGID: =?utf-8?q?1600070321367125899?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Imagine a big node with many cpus, memory cgroups and containers.
Let we have 200 containers, every container has 10 mounts,
and 10 cgroups. All container tasks don't touch foreign
containers mounts. If there is intensive pages write,
and global reclaim happens, a writing task has to iterate
over all memcgs to shrink slab, before it's able to go
to shrink_page_list().

Iteration over all the memcg slabs is very expensive:
the task has to visit 200 * 10 = 2000 shrinkers
for every memcg, and since there are 2000 memcgs,
the total calls are 2000 * 2000 = 4000000.

So, the shrinker makes 4 million do_shrink_slab() calls
just to try to isolate SWAP_CLUSTER_MAX pages in one
of the actively writing memcg via shrink_page_list().
I've observed a node spending almost 100% in kernel,
making useless iteration over already shrinked slab.

This patch adds bitmap of memcg-aware shrinkers to memcg.
The size of the bitmap depends on bitmap_nr_ids, and during
memcg life it's maintained to be enough to fit bitmap_nr_ids
shrinkers. Every bit in the map is related to corresponding
shrinker id.

Next patches will maintain set bit only for really charged
memcg. This will allow shrink_slab() to increase its
performance in significant way. See the last patch for
the numbers.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 include/linux/memcontrol.h |   21 ++++++++
 mm/memcontrol.c            |  116 ++++++++++++++++++++++++++++++++++++++++++++
 mm/vmscan.c                |   16 ++++++
 3 files changed, 152 insertions(+), 1 deletion(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 6cbea2f25a87..e5e7e0fc7158 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -105,6 +105,17 @@ struct lruvec_stat {
 	long count[NR_VM_NODE_STAT_ITEMS];
 };
 
+#ifdef CONFIG_MEMCG_SHRINKER
+/*
+ * Bitmap of shrinker::id corresponding to memcg-aware shrinkers,
+ * which have elements charged to this memcg.
+ */
+struct memcg_shrinker_map {
+	struct rcu_head rcu;
+	unsigned long map[0];
+};
+#endif /* CONFIG_MEMCG_SHRINKER */
+
 /*
  * per-zone information in memory controller.
  */
@@ -118,6 +129,9 @@ struct mem_cgroup_per_node {
 
 	struct mem_cgroup_reclaim_iter	iter[DEF_PRIORITY + 1];
 
+#ifdef CONFIG_MEMCG_SHRINKER
+	struct memcg_shrinker_map __rcu	*shrinker_map;
+#endif
 	struct rb_node		tree_node;	/* RB tree node */
 	unsigned long		usage_in_excess;/* Set to the value by which */
 						/* the soft limit is exceeded*/
@@ -1255,4 +1269,11 @@ static inline void memcg_put_cache_ids(void)
 
 #endif /* CONFIG_MEMCG && !CONFIG_SLOB */
 
+#ifdef CONFIG_MEMCG_SHRINKER
+#define MEMCG_SHRINKER_MAP(memcg, nid) (memcg->nodeinfo[nid]->shrinker_map)
+
+extern int memcg_shrinker_nr_max;
+extern int memcg_expand_shrinker_maps(int old_id, int id);
+#endif /* CONFIG_MEMCG_SHRINKER */
+
 #endif /* _LINUX_MEMCONTROL_H */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 3df3efa7ff40..18e0fdf302a9 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -322,6 +322,116 @@ struct workqueue_struct *memcg_kmem_cache_wq;
 
 #endif /* !CONFIG_SLOB */
 
+#ifdef CONFIG_MEMCG_SHRINKER
+int memcg_shrinker_nr_max;
+static DEFINE_MUTEX(shrinkers_nr_max_mutex);
+
+static void memcg_free_shrinker_map_rcu(struct rcu_head *head)
+{
+	kvfree(container_of(head, struct memcg_shrinker_map, rcu));
+}
+
+static int memcg_expand_one_shrinker_map(struct mem_cgroup *memcg,
+					 int size, int old_size)
+{
+	struct memcg_shrinker_map *new, *old;
+	int nid;
+
+	lockdep_assert_held(&shrinkers_nr_max_mutex);
+
+	for_each_node(nid) {
+		old = rcu_dereference_protected(MEMCG_SHRINKER_MAP(memcg, nid), true);
+		/* Not yet online memcg */
+		if (old_size && !old)
+			return 0;
+
+		new = kvmalloc(sizeof(*new) + size, GFP_KERNEL);
+		if (!new)
+			return -ENOMEM;
+
+		/* Set all old bits, clear all new bits */
+		memset(new->map, (int)0xff, old_size);
+		memset((void *)new->map + old_size, 0, size - old_size);
+
+		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_map, new);
+		if (old)
+			call_rcu(&old->rcu, memcg_free_shrinker_map_rcu);
+	}
+
+	return 0;
+}
+
+static void memcg_free_shrinker_maps(struct mem_cgroup *memcg)
+{
+	struct mem_cgroup_per_node *pn;
+	struct memcg_shrinker_map *map;
+	int nid;
+
+	if (memcg == root_mem_cgroup)
+		return;
+
+	mutex_lock(&shrinkers_nr_max_mutex);
+	for_each_node(nid) {
+		pn = mem_cgroup_nodeinfo(memcg, nid);
+		map = rcu_dereference_protected(pn->shrinker_map, true);
+		if (map)
+			call_rcu(&map->rcu, memcg_free_shrinker_map_rcu);
+		rcu_assign_pointer(pn->shrinker_map, NULL);
+	}
+	mutex_unlock(&shrinkers_nr_max_mutex);
+}
+
+static int memcg_alloc_shrinker_maps(struct mem_cgroup *memcg)
+{
+	int ret, size = memcg_shrinker_nr_max/BITS_PER_BYTE;
+
+	if (memcg == root_mem_cgroup)
+		return 0;
+
+	mutex_lock(&shrinkers_nr_max_mutex);
+	ret = memcg_expand_one_shrinker_map(memcg, size, 0);
+	mutex_unlock(&shrinkers_nr_max_mutex);
+
+	if (ret)
+		memcg_free_shrinker_maps(memcg);
+
+	return ret;
+}
+
+static struct idr mem_cgroup_idr;
+
+int memcg_expand_shrinker_maps(int old_nr, int nr)
+{
+	int size, old_size, ret = 0;
+	struct mem_cgroup *memcg;
+
+	old_size = old_nr / BITS_PER_BYTE;
+	size = nr / BITS_PER_BYTE;
+
+	mutex_lock(&shrinkers_nr_max_mutex);
+
+	if (!root_mem_cgroup)
+		goto unlock;
+
+	for_each_mem_cgroup(memcg) {
+		if (memcg == root_mem_cgroup)
+			continue;
+		ret = memcg_expand_one_shrinker_map(memcg, size, old_size);
+		if (ret)
+			goto unlock;
+	}
+unlock:
+	mutex_unlock(&shrinkers_nr_max_mutex);
+	return ret;
+}
+#else /* CONFIG_MEMCG_SHRINKER */
+static int memcg_alloc_shrinker_maps(struct mem_cgroup *memcg)
+{
+	return 0;
+}
+static void memcg_free_shrinker_maps(struct mem_cgroup *memcg) { }
+#endif /* CONFIG_MEMCG_SHRINKER */
+
 /**
  * mem_cgroup_css_from_page - css of the memcg associated with a page
  * @page: page of interest
@@ -4471,6 +4581,11 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
 
+	if (memcg_alloc_shrinker_maps(memcg)) {
+		mem_cgroup_id_remove(memcg);
+		return -ENOMEM;
+	}
+
 	/* Online state pins memcg ID, memcg ID pins CSS */
 	atomic_set(&memcg->id.ref, 1);
 	css_get(css);
@@ -4522,6 +4637,7 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
 	vmpressure_cleanup(&memcg->vmpressure);
 	cancel_work_sync(&memcg->high_work);
 	mem_cgroup_remove_from_trees(memcg);
+	memcg_free_shrinker_maps(memcg);
 	memcg_free_kmem(memcg);
 	mem_cgroup_free(memcg);
 }
diff --git a/mm/vmscan.c b/mm/vmscan.c
index d691beac1048..d8a2870710e0 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -174,12 +174,26 @@ static DEFINE_IDR(shrinker_idr);
 
 static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 {
-	int id, ret;
+	int id, nr, ret;
 
 	down_write(&shrinker_rwsem);
 	ret = id = idr_alloc(&shrinker_idr, shrinker, 0, 0, GFP_KERNEL);
 	if (ret < 0)
 		goto unlock;
+
+	if (id >= memcg_shrinker_nr_max) {
+		nr = memcg_shrinker_nr_max * 2;
+		if (nr == 0)
+			nr = BITS_PER_BYTE;
+		BUG_ON(id >= nr);
+
+		if (memcg_expand_shrinker_maps(memcg_shrinker_nr_max, nr)) {
+			idr_remove(&shrinker_idr, id);
+			goto unlock;
+		}
+		memcg_shrinker_nr_max = nr;
+	}
+
 	shrinker->id = id;
 	ret = 0;
 unlock:
