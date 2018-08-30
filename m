Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A00EC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A2442054F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="HcwU8CC0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A2442054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbeH3Mus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 08:50:48 -0400
Received: from mail-eopbgr70139.outbound.protection.outlook.com ([40.107.7.139]:4224
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727238AbeH3Mus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 08:50:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/s9uDMRbgcKnnh2a+PmLr57ZXRpkBQiRMuUD3AAxpA=;
 b=HcwU8CC0WaL8GwvO7sSIfogRhD76A+d7Q/cJoKGiGLEaut7F2pW+JV5nTz+BE+irx/ECBcsBCIGbp+jWB/9Ec/EPFgYS52+nKqkZm1nXcnYRIJzmUsWXtu2M4uIzGLnFctoHt+WoBeiOWL9jtypTwzzeqhznHCXNDYwm3fTt0qI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from [172.16.25.169] (185.231.240.5) by
 HE1PR0801MB2026.eurprd08.prod.outlook.com (2603:10a6:3:50::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.15; Thu, 30 Aug 2018 08:49:34 +0000
Subject: Re: [PATCH net-next 0/5] rtnetlink: add IFA_IF_NETNSID for
 RTM_GETADDR
To:     Christian Brauner <christian.brauner@canonical.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, dsahern@gmail.com, fw@strlen.de,
        lucien.xin@gmail.com, jakub.kicinski@netronome.com,
        jbenc@redhat.com, nicolas.dichtel@6wind.com
References: <20180828231859.29758-1-christian@brauner.io>
 <adc2fae5-e22b-3a74-d531-01570e7970ee@virtuozzo.com>
 <20180829181303.4sacopk7y3p5xyou@gmail.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <81379a4f-7149-10ff-2453-886314d0b0c4@virtuozzo.com>
Date:   Thu, 30 Aug 2018 11:49:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180829181303.4sacopk7y3p5xyou@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: DB6PR07CA0013.eurprd07.prod.outlook.com
 (2603:10a6:6:2d::23) To HE1PR0801MB2026.eurprd08.prod.outlook.com
 (2603:10a6:3:50::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b89625bc-7b73-4331-ad76-08d60e5583f6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB2026;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2026;3:0pz0D5ouR+SQTezFnp6SevJtSGrPX9tV4YGDE1fJ6KPho6uTY1KoU3xt9W/8VDu/RzpqSYYgYW20weaIDFy/479gj8N/QdynJH6/NeS5H4PrX+jnxUbLDtvqqgMCzEb/624mHT/de3/ujJLbe3hhGohEs6dRspjhsPMhOlScD9zNM/RMtaP2lGt5lYHlab9WK6AJIizbP9xblM1LKX4RQa0gM3qQi4+tcTqtuMDFpXlNV2FgGFOduIjiIgIeYYqY;25:O9EzNPW4mTT4WGkVduIBUy4KJHswySjEPGxkuHi3r1bqQF3rhQ3QtxqSSaqISGDMcraay2ChdM+kqSYAOvFzcnM11F3CuXVZJtslEp7WYcAMo0wxkLJWezZKxXGF+5+vDnUKemelmfL37RDHH9tu5YHx7AxmvjnXQ1gqb3bvdR4gsCVMcGYXlluHFXltuP6zCTdQ0ruiw46yUvid0v4ljHxh7f9b99IKhOL4m5KnBhzoNJAXImPyBHnCb97SrK5hjkBvQId0YBvHCRWFcWEIm7QUY8rodk8sPMmCyP8pqo/8gQrmJ5pjsoQjAdNAaZFzxKTlqwIQK42woFLTd82KxA==;31:wcIFPSwMvq+MBQMYo2SoKc4qWHSsR2TJPEe+S5ZpPahdP4ZEz3urt4elcvlx2UE+cGxhCcnJaNOpdjR66u12qso2gaoN65jaQ76q2EZJSTB9qJ8ftBJo7BlAuNQc/j+GccUNpK838vwsFHAAKtHAFkTJtdywmtBY7ip5NI8YZ8k4Cl3U+c7Ql+FObC/MWW8FwqtFpq1e+uEJZORVe7mbecrrFVK5pwDsh6Qt4IAiwHo=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB2026:
X-LD-Processed: 0bc7f26d-0264-416e-a6fc-8352af79c58f,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2026;20:BEpi0F9Qju2C4wUwlzfyxAG0BUY4N+130Ew9cENHue4Y9Qj+TzH2eqCHetzOR7FFoV5xY+CLI67BPUJYhi9b0UUjCJayehe/jJsAdvcT0yG6QfEZC+rU4hciduiGs+BU4E4wlgUuEYyffXNXjftoZfMvTGCkX47b8clPK9HqZMV1Cr6AvpOJSs7vX6uwZVmLgD32N2oV2XEEeBiob2ZOaqFJNinCeXP+tYNz0BNJjXo3YIq9a6gXyxKf6H4v+WsCpH77mLydNM6obL20xopoAZqtCNoJPWG6F50yeJCAc7LoSvk5ZIgdEOiD1aI0H2KPF8V25PTpHD+8oVKqEmxw91QWZdpBv224C/btYfD9s/98JAlegs9e3ree8wYnBHkPc4w6cLmwnTP5kbIdpmFY3nU602CtvleHGwi/uprbMaXhH9MtVnFuijdNMOBHORCX3rkn7KpfuVWWKqzta2lMxg9YIBLqxbsXEwkPgtr1F9bFfFTa+LD+xw4DkNSBzF7B;4:UMne4dx8hM+plFjrvzfy9NRC6kbXuomuJKD6eneez40OcAAH24kcCSK1OL+BQNgcEhzJ21djx3LFXrFf/Z/4vK0JN9bubcsvILyWj+RhD+pZAhqVwjNFpg2N66OEof78uwLz8o3+38vXGLkSBySpB9afb1T3KjjjSr0Gf1v1e4JWEoiYqvtgQ8d0chYpcXhhEKSfvulXXwrpfcHmPnJSrAumuMskEAhLLaHyIddgg7P3xN2s6mwWYCWfqeOXQxFEFpYXY9UJ8EUo4Im4d16p0ibX+UgD42mD+3Dh4I+BhD+TLIGzO1v0FPdhobp6DAJ+
X-Microsoft-Antispam-PRVS: <HE1PR0801MB20265E92049E7FD03335FCE8CD080@HE1PR0801MB2026.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699016);SRVR:HE1PR0801MB2026;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB2026;
X-Forefront-PRVS: 07807C55DC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(6049001)(376002)(39840400004)(396003)(136003)(346002)(366004)(51914003)(189003)(199004)(229853002)(81166006)(81156014)(16526019)(476003)(7736002)(3846002)(6486002)(2616005)(305945005)(31686004)(76176011)(11346002)(23676004)(486006)(446003)(956004)(52146003)(4326008)(2486003)(52116002)(14444005)(230700001)(68736007)(64126003)(6246003)(6116002)(105586002)(8676002)(106356001)(39060400002)(8936002)(53936002)(478600001)(6916009)(26005)(97736004)(7416002)(58126008)(31696002)(86362001)(386003)(16576012)(6666003)(316002)(53546011)(47776003)(25786009)(36756003)(186003)(5660300001)(77096007)(65826007)(50466002)(65956001)(65806001)(66066001)(2906002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB2026;H:[172.16.25.169];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjIwMjY7MjM6NFcrUkY4T3ZzaVBOTHdqSjA0SmtlTXg4?=
 =?utf-8?B?UTFveGxOZ1E5Rzh1aEk3NTZnZUJ2SUJEemJJUGdxWFlYdUpGa3B3SFBXdDJy?=
 =?utf-8?B?cE9TM05heVA5Rm5BY00vRjg0YnNVRlZYTTg2WmQzb2hZQWxQeFo0Ujl0b2Z4?=
 =?utf-8?B?Z2hFaCtVL3lPWllXZ1F6ZnhLS0s5aVZhQnU5YmJpS3JEd0lMcEs3S1hERC9E?=
 =?utf-8?B?d05FeEFzL0pXUFA3S2U1SWJMUk8zUmVWUDZ5c29CTWRZUWJ5MlZSUDREMDdk?=
 =?utf-8?B?TUlNaEhZc1FjN0QyNC9sYWsybXQrNlAreTlwNkJJMi9rQzlJN25KaDdsTFlL?=
 =?utf-8?B?TDRXaXN1VWZGbmc1cXppRHpqSWowOUZvamkvQUVyUlQ5QXNUMmtaeU14R1lu?=
 =?utf-8?B?dk15UHF1ZnZIZ3hzVWdnR2QvdXJqMWdtZVlCR3cyUnh2ZWNJRkhBTmtLKzlH?=
 =?utf-8?B?SGpvbXdsUkpwcXJxMnBCQXdXS2dpeDJsc3daOGFaUGZtajREQW9hNDcwQlhE?=
 =?utf-8?B?ZGUrUFQ5T3lkU2FlYXAvQi9LZElsbmV6NjZXOGo2WThoQmc3ZldDQlJ5Mlhw?=
 =?utf-8?B?Y1B3c3FsanJSSSt1MUdseE5ZTm5MS2RGTElVekJhZ0s5bWJVYnVjRDN3VDJL?=
 =?utf-8?B?RGV1WmUrVjQwODBHRGs3TERhMDJZSkhHSWNOS0VXRGNsTjBZMFgyL21xaHNs?=
 =?utf-8?B?aEkzUzB3T2w4ZG84UG44RkpkQUpZbWxhdDNkakFsTXVJWGJqRkpkMy9rdUxS?=
 =?utf-8?B?cjVDS1NLdFliMkdVc2tZSGh4Z3VZTW5zY3FoelIxc3V1R2RyVTJ3VDVlZmFP?=
 =?utf-8?B?NGluSzlrSjNGN2FiUER4VDRubTBlc0dKSmlnWXJXOVlzbHNQVUlpODZCSFo3?=
 =?utf-8?B?MGZEOVRINmY0ell0QlZwRWM3NHRuWWNuRXBFcU4zRzZNZFlYUXlNVVBYaW1r?=
 =?utf-8?B?bGNVNnNLb0c5K2JSZGJ4QU4zRFJmMmVabXN1eG1zaHdNUzg4cFlwbXlqdllE?=
 =?utf-8?B?NThKcEJBTThkM1YvWUcvRzBwUmI1cXI2NjA5azE4TERodEh2R2lkOVNtNVla?=
 =?utf-8?B?TUtXMkYrUG51dnJKMzBuazJQRlZoK2lVc21DMEtxOXBIRnV4a2lLOHZ5UE9i?=
 =?utf-8?B?clU0cHBET1VDNEkwZFJhSkhMZHdYOUlPNXVBcU5obmFCN3V2ci9Ub3hzWkJy?=
 =?utf-8?B?eU5OQ0daZmptNmo0MFdYeElVemtGcnVnWE45M1EyUFZTT0s2VVZiT285VFpk?=
 =?utf-8?B?WXZWOEhJYVN6V1Jna0Q2Q1ZCdDVYTmo2eDJiYW1pTFBmWWFhbmNSQmlnQVBl?=
 =?utf-8?B?QjRSNnM0VGJMdWJNN3o3aGpIdGFMQ0ZEUEVSZ0hDaGZJaFFNczVoZldhRUpD?=
 =?utf-8?B?Z0lucU56YUgxMCtJU1M2NjVRZC9uVjB4TGtHRCtqREgyY3FjbndGZFk4VnRW?=
 =?utf-8?B?aUNKODg1aGo0OEczYUc0bUdNVVMyZUFqMUN0Q3RWT3YwQlMrZDdIZFYwWDFv?=
 =?utf-8?B?MTJDdnJKbGE5NFZ5QmlNYU0zTFRTNHlmTjV5Y2xPSk1Jc2hTazRyN3paQjla?=
 =?utf-8?B?MFZrQmVkRWFBZ0RKdE1uLzlrVTdsM0VacTloRnRVdzVoWThFVWFIVmhJVmVP?=
 =?utf-8?B?SndwWldHMFA4SGkySGN0MWZZV0tPVHJuK2Y1S0d2anZFdjJuRXRhWkpRT2NQ?=
 =?utf-8?B?U0pHbzE5Vk5MSFhiSGdBdEZhcmU4QklsdkJkTGFPS0llNDVYWmF3ZEhHWlZJ?=
 =?utf-8?B?NnZiWkFqL2ROTjhudGM3RjN0RXpISzdaZFNIczgyMEJUdFUxb0lmNU5Od0px?=
 =?utf-8?B?MHJQd0VuU1VNdmFkZUVxRUdZV0ZRS2NvakFMVDVUbis0WlhXU0dUK2pBcEF1?=
 =?utf-8?B?Z3ZtaDFqY1lqS3pGWGNtTHJiWWtYNUw5V05ISFRVblh0UG9hai9BNDRsRndJ?=
 =?utf-8?B?dm9qUmhhaWtzajI0UXhmYUlXblhMZGIxVURRakpQNVBzYTFITGM3aHFuQ3Zs?=
 =?utf-8?B?Mm5ERnM1ODc1dFA0cGlTREp3TTZMSFh5bTN6eWF3b0xkNE9HMXJUeVhaYy9N?=
 =?utf-8?B?TlpaVnZ6Q2t2T0JwSW1La0dqeWlIYzJPbmM2cmZScXlFa1d0WU0yNFVrVXlC?=
 =?utf-8?Q?3W5s03KCxueOM3a1y17PwiKhz4xPpTV3FQcxBuldHqVp29?=
X-Microsoft-Antispam-Message-Info: 7TCpgWLhw7KC0MPHArcuimDDabzjsSOst5ipElZVR9j7esT4Xo7ecyfEVORR3BMwpQznqtuPsp2JqvEFLshKoLLsojQXDuYvl8hP+7vJJXmCWuJO4+sgTNL8O3Eu3aCGKRgEx7xnAwPXwIgxDeuqizLIRWPCdhyJgbGXP8RNatqL5XotEJoW1RkLM5em8k3dooxmATJ98J+4t19tnlbI+CvP0yWI1y3j62f5+qwtjK66nfw17PMW7VownoH7fJDOnei7L+dgZtXtNo53nVRu349GDIV+3JW4x0NYaYW+xFPDiMuPIwkDm4f6Rw7ncuoP+vQMegLO8EXjXFnagTYfYmUDD/CmqzwTKQ8eoh26pUk=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2026;6:nbKm7VermfwB91WoduXX0nHNrpc1bHsYVjlPENAAAIrJZnilg/ggKBi+cnx6edSJt4kFQd+cFBhsomZ1r0IUhId2DUT9IZ/b5cZCawq279A+reWESJgLHymziLeDlM6OFvPMnqPCcNdNQCEkQb8JfnTd2KLlYmn1cKwc2hoQ4oBuzpEMz27fowF5DMUs5xHpqx0s3Z2s8RfZ/aRLctbLBqOZDtfx5nP3qMcxtKVcCEfDrVbIpLAOQvKHN3E6aK0cFFLl5FwUV7OUe2Vd/eI+Ovw5ZryFYCSpomp7f0xCyUQj9RWRt57wfrAovVST2irrRXGGtY73FO4v8HspTyX1UvSlhn+7B9nqne3m2yuvgMrk32ivRa7PSgQGCKjBrVNFc+7uRJ4vLpqFWjwztCsjYautl9nqfz9Z5IAtkQuU20z6qyvdHlg38IHYY5qSym5QNkwPcKE+rRzNU8Jh/bHpqA==;5:VuWctMb6VokR6/TvYcR9C5wj3zQJ4hBVJrtR2kPm6W+r9/XXaaDWV8HhQMiMPbmFpzeOMoyWjA/X8hJN44Ea9FHMl6UhjOWhfVBTNGK0PkpfGthiwGou1HkGnd33KwTv1Mm6tMVzLDhI/nJEfwZvubVkZS+SVDoU8Eni8toHyKc=;7:Ifu0K5nx3DtVqIPstN/tfRB3Vgp13ZJlRO+tD/ItPZawIWx54J0Xz2sNT9XZp4YW8i1Kj4sOQKzicBfvs5S+wVWnNMqVw/B5Sx9BiPJrZca15M9/jMHGkXWqFJNyQv9851YALy1pydZaEPM8nqU7s4+zwM2ckdU3BAg7LA6uGo3ARRfibXfw8txK+qVTBXBVJki+etZPIB9pWcv18CYsIKUJ+bxuGLhOj1VCadHkAm36DFppQ4jRx+EVH6OFDnDw
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2026;20:/tCSDnq3PihUGUOHK//kLZ31YikDbeSx2u6NrbWLUIzCt8H5oBkMXBlFQbrD/veh17pSCUbi2s2H2m3ssRAk0VO0srekw/C3uEVGQV+aj603Tgf75LEsOiQ4a9lIyqQr0mGQCm4+Fa7EULp9euX64SqtGTdWFjS9s/onIYyg720=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2018 08:49:34.9778 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b89625bc-7b73-4331-ad76-08d60e5583f6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB2026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.08.2018 21:13, Christian Brauner wrote:
> Hi Kirill,
> 
> Thanks for the question!
> 
> On Wed, Aug 29, 2018 at 11:30:37AM +0300, Kirill Tkhai wrote:
>> Hi, Christian,
>>
>> On 29.08.2018 02:18, Christian Brauner wrote:
>>> From: Christian Brauner <christian@brauner.io>
>>>
>>> Hey,
>>>
>>> A while back we introduced and enabled IFLA_IF_NETNSID in
>>> RTM_{DEL,GET,NEW}LINK requests (cf. [1], [2], [3], [4], [5]). This has led
>>> to signficant performance increases since it allows userspace to avoid
>>> taking the hit of a setns(netns_fd, CLONE_NEWNET), then getting the
>>> interfaces from the netns associated with the netns_fd. Especially when a
>>> lot of network namespaces are in use, using setns() becomes increasingly
>>> problematic when performance matters.
>>
>> could you please give a real example, when setns()+socket(AF_NETLINK) cause
>> problems with the performance? You should do this only once on application
>> startup, and then you have created netlink sockets in any net namespaces you
>> need. What is the problem here?
> 
> So we have a daemon (LXD) that is often running thousands of containers.
> When users issue a lxc list request against the daemon it returns a list
> of all containers including all of the interfaces and addresses for each
> container. To retrieve those addresses we currently rely on setns() +
> getifaddrs() for each of those containers. That has horrible
> performance.

Could you please provide some numbers showing that setns()
introduces signify performance decrease in the application?

I worry about all this just because of netlink interface is
already overloaded, while this patch makes it even less modular.
In case of one day we finally reach rtnl unscalability trap,
every common interface like this may be a decisive nail in
a coffin lid of possibility to overwrite everything.

> The problem with what you're proposing is that the daemon would need to
> cache a socket file descriptor for each container which is something
> that we unfortunately cannot do since we can't excessively cache file
> descriptors because we can easily hit the open file limit. We also
> refrain from caching file descriptors for a long time for security
> reasons.
> 
> For the case where users just request a list of the interfaces we
> can already use RTM_GETLINK + IFLA_IF_NETNS which has way better
> performance. But we can't do the same with RTM_GETADDR requests which
> was an oversight on my part when I wrote the original patchset for the
> RTM_*LINK requests. This just rectifies this and aligns RTM_GETLINK +
> RTM_GETADDR.
> Based on this patchset I have written a userspace POC that is basically
> a netns namespace aware getifaddr() or - as I like to call it -
> netns_getifaddr().
> 
>>
>>> Usually, RTML_GETLINK requests are followed by RTM_GETADDR requests (cf.
>>> getifaddrs() style functions and friends). But currently, RTM_GETADDR
>>> requests do not support a similar property like IFLA_IF_NETNSID for
>>> RTM_*LINK requests.
>>> This is problematic since userspace can retrieve interfaces from another
>>> network namespace by sending a IFLA_IF_NETNSID property along but
>>> RTM_GETLINK request but is still forced to use the legacy setns() style of
>>> retrieving interfaces in RTM_GETADDR requests.
>>>
>>> The goal of this series is to make it possible to perform RTM_GETADDR
>>> requests on different network namespaces. To this end a new IFA_IF_NETNSID
>>> property for RTM_*ADDR requests is introduced. It can be used to send a
>>> network namespace identifier along in RTM_*ADDR requests.  The network
>>> namespace identifier will be used to retrieve the target network namespace
>>> in which the request is supposed to be fulfilled.  This aligns the behavior
>>> of RTM_*ADDR requests with the behavior of RTM_*LINK requests.
>>>
>>> Security:
>>> - The caller must have assigned a valid network namespace identifier for
>>>   the target network namespace.
>>> - The caller must have CAP_NET_ADMIN in the owning user namespace of the
>>>   target network namespace.
>>>
>>> Thanks!
>>> Christian
>>>
>>> [1]: commit 7973bfd8758d ("rtnetlink: remove check for IFLA_IF_NETNSID")
>>> [2]: commit 5bb8ed075428 ("rtnetlink: enable IFLA_IF_NETNSID for RTM_NEWLINK")
>>> [3]: commit b61ad68a9fe8 ("rtnetlink: enable IFLA_IF_NETNSID for RTM_DELLINK")
>>> [4]: commit c310bfcb6e1b ("rtnetlink: enable IFLA_IF_NETNSID for RTM_SETLINK")
>>> [5]: commit 7c4f63ba8243 ("rtnetlink: enable IFLA_IF_NETNSID in do_setlink()")
>>>
>>> Christian Brauner (5):
>>>   rtnetlink: add rtnl_get_net_ns_capable()
>>>   if_addr: add IFA_IF_NETNSID
>>>   ipv4: enable IFA_IF_NETNSID for RTM_GETADDR
>>>   ipv6: enable IFA_IF_NETNSID for RTM_GETADDR
>>>   rtnetlink: move type calculation out of loop
>>>
>>>  include/net/rtnetlink.h      |  1 +
>>>  include/uapi/linux/if_addr.h |  1 +
>>>  net/core/rtnetlink.c         | 15 +++++---
>>>  net/ipv4/devinet.c           | 38 +++++++++++++++-----
>>>  net/ipv6/addrconf.c          | 70 ++++++++++++++++++++++++++++--------
>>>  5 files changed, 97 insertions(+), 28 deletions(-)
>>>
