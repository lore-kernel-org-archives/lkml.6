Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690D9ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ABA520C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Je0fkLAk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ABA520C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731370AbeIXSKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:10:23 -0400
Received: from mail-ve1eur01on0128.outbound.protection.outlook.com ([104.47.1.128]:65184
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730784AbeIXSKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:10:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXk3NSTMTmj3uqlgZWXINvtakkwQ4DTpe8a32GDQQx0=;
 b=Je0fkLAkFnSYhWX8ha+gITCpk9orBjFu6MFC8gUbdZy2WL4fix0Ib1aEQI4s9nrJzWBM4hbz4wlv5IoKTVxVr3upXv5z2G572YCvt+vnV8XTR++gMzo5GK7mwy1CaXtDAgrav8DEI7gmPoOvuXOVYCpFo2ws8g7BwsnyDBrn/QY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from [172.16.25.169] (185.231.240.5) by
 HE1PR0801MB2026.eurprd08.prod.outlook.com (2603:10a6:3:50::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.15; Mon, 24 Sep 2018 12:08:19 +0000
Subject: Re: [PATCH 0/3] fuse: Solve request_find() bottleneck
To:     miklos@szeredi.hu, kuznet@virtuozzo.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <153666041612.19117.14667042009014596105.stgit@localhost.localdomain>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <8222c235-ff07-b16b-3389-0b9780145abd@virtuozzo.com>
Date:   Mon, 24 Sep 2018 15:08:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <153666041612.19117.14667042009014596105.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM4PR0101CA0072.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::40) To HE1PR0801MB2026.eurprd08.prod.outlook.com
 (2603:10a6:3:50::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6228cb1a-60bd-4ee9-45e1-08d622166ac9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB2026;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2026;3:mBfgM125J46ci4IhSVk9SBqNPMOBHuBjKyvOZzLgrcTn1ES9FvmjP8YZuZ3hEUtz9H/wkQ+dIJcPT82l0sl7hujJLt8voTADHjqVQPBRHAuyRDSsqj5lh3AsF2dLAEJeixs/1PLGy7s9epRYptpmax2hr5YeVbUB5hJLSMoJwgRliQMVAbl+gUaF3EDKk/1sqMMWine/JhH6RngcIwtxM/59AoRQIC7gG40rbU2RTpKNm4IxDCV9uNuoIeQS3apK;25:HV7ICtmLgesb9vdStUmon3gUWSLjx5Vnv1sUNCiDlSfb0MniKq+AgI/1evZ0wk7kVv+KJ0V41Upnjm5M+f5X0rqfm2l0tm3loUaIN3sokwXyokTPgoTHF+HQ8pTOQBcgEqBakJHB8IQZ6XOoMPa2qKBd5jle2BeM/xXzt29SSKevblr+OX2+Y+i4cw7aVSr0XbrpQk13UtmtSfTpzmlE3xEt0FRFQN9HmauaCg0OmvNI740ssv5hd5rmNNtR9DivNwpHfObtNgm9opcy9xd8RHXPI0t3OeMrAViZ2vBdGLZJCKvPSuhpp8NCrWjYZmY+7PGRnzlYF4fkgAIHSLmpTQ==;31:keDr3nd5Yis0VXydq729bnbNvGj3q05dt1uOkcpNhzjAUvd/NTLbRl1HdaSXPbvkLGCY3EOy+d01bsqIqCTQLD0HINtUVI5FzHwjW0zEl4ZIV5+Yz1AcIgKpY+Kyx1eJ+VhbcKyjDnM37RkBauXFHXs2wY9zSsJPYAlJjpeJhZEpyEZJfjyACaxCcxIMKi31ap3rHSp9dhAOwm3AcvxMSxtLs6jeBOQDpzItWpQhiTY=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB2026:
X-LD-Processed: 0bc7f26d-0264-416e-a6fc-8352af79c58f,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2026;20:2TRQ7BdAj0jpsY9kGxvLX7i4uwA4M8DdoJzIw6CSV91Zpt+InC7cxpBv4gzqaDCTHdAxNn5puSAxR4Z9ZYgpek2IVHwL4BFB/rSbB9fvYGYEK39Xae4v9GDhgY597ZN3C5F22+hag1x6eNISSSh+pyUcPjKX86mVNNxi9/+GBnsXxClqodCXXWZ0ymQ0ABiF+tm33hvTk77NmgC9jlMAYJNq0xWP6g/BnqoKxAcfBWPEGAXCp8ClwZJoH1fcq4x2lktzR2ImmgGa1bDNPN5j3G5jesn4xPHbdJUoK2mrQ7uyRGpv/i1Li5KN57KHryLzzWrGu/q4L7qSTCbn0N44kx6K1s6dRCQou21et3zwVC+jRpDwukuGFDWVOzQqnRqtMltPD3qqVftywv06f/xVx/7eCL0l0RuMJLcMTIyaRsqsw6LX2A+uN81zEtjpl9PQGiThmUZNBZom4ppqKAqr0JzsXSMzvPUPF0gFYk+VAfLg6egjBICUOTROIM21Z58o;4:zTJzhOQvDhH/ry+TUiOWbBP+lHKt++3FqIo+n1vpRbjpxmmhYnqbRrj6uZwCfQYWPqTJx/baN+7J/4y2GdBsCnjLA2RwIqXI4VtWmYcK4jZqY6GKEn6NiGCEZy9sc6FtcX9rnfqPKyeCuN6ItA/TRR4nW6sflVCSfPk7LuPWDDiYRSQgDnspacFpyYTri4HjF2PBA79kFWJ+BLtt7k6zyLeXpT1pPtLRjbT5FjzJespme/znr/dgoiK39RZRzuzGiF5Fo7YAL3esDmjtw55AWld5OCcsUW/2VIHQ3gbCFJWQjIsRZcOmVlzxPrUzovDS
X-Microsoft-Antispam-PRVS: <HE1PR0801MB20265E3570A411D8A2709EBFCD170@HE1PR0801MB2026.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(190756311086443);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(823302057)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(149066)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051);SRVR:HE1PR0801MB2026;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB2026;
X-Forefront-PRVS: 0805EC9467
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(39840400004)(396003)(136003)(376002)(346002)(199004)(189003)(8936002)(81166006)(8676002)(81156014)(16576012)(316002)(76176011)(2486003)(52146003)(23676004)(52116002)(97736004)(6666003)(53546011)(386003)(36756003)(31686004)(6486002)(229853002)(64126003)(58126008)(2906002)(25786009)(6246003)(68736007)(65826007)(16526019)(5660300001)(186003)(77096007)(105586002)(26005)(50466002)(2616005)(476003)(446003)(956004)(53936002)(11346002)(486006)(3846002)(106356001)(478600001)(6116002)(7736002)(305945005)(31696002)(86362001)(230700001)(65806001)(47776003)(65956001)(66066001)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB2026;H:[172.16.25.169];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjIwMjY7MjM6S29jbVE3Mzk1ekdZemhPQjVxYmxQTytp?=
 =?utf-8?B?TVFkekthaHdaOVZOMjcvU0srWFRoOUdmY25hNVhhY1I0Q2hQNkQ0RWw5dEJC?=
 =?utf-8?B?VWNMSXUrQmJvZnRVZS9KWXZTaVgrcEtlU0dCS1RPdkRGNVRrdnR4UW5OdUFY?=
 =?utf-8?B?R3FzZEk4T3lCc0NsOEdndTByQ28wM3UvWjl0dExhK1dJK2xnY21KeW15Rk9B?=
 =?utf-8?B?UmdmcGJYKzZ0OHlkRkhUbzAyUFlFclJRSlRFM0hKdENGNXZ0eWdUZlVWb0F4?=
 =?utf-8?B?K1B0a3BTMng5cGlhV3lwYTk0VTM3MFBGbTRNVTBDZXJLckJNdlJsbEtqdzlv?=
 =?utf-8?B?cGcwTHZQam1Qbm95ZXd2M1J3N2NDM2dFN3ZtU2xjSXhGdGpYOERBMEgzSHdM?=
 =?utf-8?B?Zkh1dWVYU1VkK1VFRGJUbW5HNmE0Mkl0dHQ2OU1uU2dIU1RtRW8xSnJnNFlI?=
 =?utf-8?B?MWIyWTBobWhTaFZVeThVQ1JTb0JRYVRxVFA5VW85VVdiaWk0YXZPYi9OWFcr?=
 =?utf-8?B?RDRCUnJTZ1R2T3NuaWxmN2dmblNGajArNnZ6ZjN6VnN2eHF4MVJ4Z0V2d3gy?=
 =?utf-8?B?SmFBMXpJZkNIaHZZZEp4cWxieit6cGJ4cTVSZTZjRm1OQk1RUTB3OFV2bnJ3?=
 =?utf-8?B?Wld5N3VuM1h3ZFdxWWgxWHkvcS9DQmxRQjFuanA5ZmhYNS9QbWVFNjJ1bURH?=
 =?utf-8?B?QXhMUi95TGpaOTR5anVRc2VWQW5kS1FzelhOdUtvUjZJbUE5bDBWb3pvMlZZ?=
 =?utf-8?B?OWdsN2dJMUttaDJEODNKYWxoVXhyMDMwY1dYcVlVWmh4YUFFTS9PMTcwWXE4?=
 =?utf-8?B?dml2eHFiNk10a1BtRjN2Y2tzRjVIbUlsWmZZTUhXU29kcnV2RjdVM1lGRFdp?=
 =?utf-8?B?SmNndUtrcnZhenRYRmQyUlEvM2lNdEk4YWd2c05ZYzhnbEhVQUIyTHl4UWpU?=
 =?utf-8?B?Z3ZtNjhqVzFCQVlEQnpITDl4QW5jd3h6b1B2d1ZWT0pqemltMEdLNkpGQXB4?=
 =?utf-8?B?bU9BRlhBRll3aldHR0UrYWoyUmZ0R1lxWlhNdEZscVFrdGRkLzMwTklLNXUy?=
 =?utf-8?B?UGdnQ0VrZm5lMlVVaXl0SURmRnJLUU1JWkdsRDBCZzV1L25KbGFGVUhrUXFK?=
 =?utf-8?B?VlhlRXBoU3V4cndBb2lhZ2hRUW5qMzlKTGRjeGxLcSthOWxPd0EyYUd6NVpz?=
 =?utf-8?B?TzdjN0VrejBHZUM1SGtMOEVYVWZicmUvZ3JxUUtET0JPakhYYTljcGlSNnZM?=
 =?utf-8?B?MFZtODBzWHQ2VnpIVlJHUXZUMTFxeVV3SmR1eVdpOHRoQXEzdXFOazV5S0JM?=
 =?utf-8?B?dS9JcHBOWFZBaDlGQURwdTcrZVRTZFdxSGFaZm96SFcyZmFDbG1GRVpvZEVN?=
 =?utf-8?B?TEN1SGpDVnlUbVZjOFRoRjRHTjZvV1k4enl4UjdwRHE2YmROeDBGWFYweDhx?=
 =?utf-8?B?cEdjWjl6dTYxZFA0dk9kTFNkOFRFaFU1OHo2SFRKaHordGRsQkd6ZVB5ek1u?=
 =?utf-8?B?ejk5Tk9DbnBFeVFPTTU0R0R0b0FoamN0RjZIVEo1YXBJNTdBNk8wT0s3YzZP?=
 =?utf-8?B?ZWZNTTNDZFFSdmdBbUlvNW91RzRoMDhubUJUSS85Y2dGMy94UURCSEUrSW12?=
 =?utf-8?B?TlhQRVB6QXg4TGhPNFFHUDNzNmdHSVFsL1RkT2pENXZzajVHb0JnY3d5TDM4?=
 =?utf-8?B?NW5hR0x6UUxONWo1alVjcnBYU1lUSWhWdGh3cXlUb050ZzY4SExXdHpzeUlu?=
 =?utf-8?B?MnFZdVlzUVI5ZG9OaFVHVklvemVGNnA3Y2lrN0tYZzI4ZW1PSDlSZ29PRG5t?=
 =?utf-8?B?UnllRmg2SmxVT0JLUGYzRFJUM2NKWGZNZUgzUmo2WWE5RHUxcldxUVo1bGFL?=
 =?utf-8?Q?FlfX+x1m5vyac=3D?=
X-Microsoft-Antispam-Message-Info: GK5gRLj/+VpkBHPfiu5NZJEj36x2RvxeOxDJFXVFQBrqVNas+4oNUuvBi4Vxq9E6lZ+OfFHg1sD8H2gSkNNWeZQRbsRWTYixhXPjFfiBi2/wtN+o6xnkFsSBXO/SLP+LGDYklM9eKJs5CkfLJLHYXWJHtPGrEeO7vT0lBp5xdtPLbHuOUcekULK9ozd6cYDeLh0TZnddzsmirpAAQhWN0SOvRFvdlqvL/pHXiAQezSeyehzbPeTy80ZtFxrtDjX3C8Yg8u2qZPbr5EQ+cxxj7Eezv+Bxm9+6H6OaCZGKfjGYjEEFlC+c1Sa0/FqHQfW+/B0/xqJkYFjHJzHr/go1U7zys1u5mI0/ZnUyyMI0rlY=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2026;6:ulcnFtssbjxDwMCobNKbVP1p19vf/wXKEXAFuG+bQXsaSs7gTSuFCX9UED8qCr1Tg9sHs2T7TRWAkcJJo7el3KDwV9UbRlW/llvgkkVCEAL2nbdQz06Zs1mYRZouozGiEVlRd4p3kr2kWhci74HxTUV1CRIqEteKmBwtZAXp0N5zUdR2M15iJ0WBqa+bwOgYenxjKkGd6OfauWaYJ9RWJvp5vTn/RKEDAJ/jwHL/+l5MDj2U1OMWMpa8KkgYQA2pktupBwxJM4O8bO2ZQu7qMK2nSST5asegkqeVwzECydfhMdy+iyC4ep6JKIDtT3NcKUyAQYvOdhPQ1tQurIgGQ38E5nzMIt0u7FB4thm+7NNB/kUBWs2UCq0+LLMH3+tMznpWi/9Ezg5ak9wMs9hyoUo4iMybiFLjQzC90jXJG9ZGl4S5RAaZDwWTyIp+6zadubmiQpYkvM54tofpWHIz1g==;5:1CbUfj4Sms5+wVTmA+vEjOmqPc5MBXK4l7Zv5+5gqtZTOLYqlTDA+4ygCl/rMUcBDe4WOzuR+mmSOv5ucWjTgPdnkbhT7rL57M+QmOlIkorHYmvF8CjbAdLAyuJIsiXMTw/4ymBfTLsSVfI2JQWcbrI6fD+BECNxAd9RzDYIuZw=;7:SpX0J81OL5jHv0YBX/7IB6iPQKxpBdkaB3wi6LLaipTgOLPacXRKva4VEnk5n0kQG8GQAzYdq5jekgugrF2Ro/codtEsjt3yB5DWU/pSFRxJIYld7tr02uGyDECt6PdqY5PQ3zZf+s7z2mcWZPPpU+VaG9HxDVnq35CewYRQL73qB9w8XhnE9K+Bv6I6V5hPFqOEzdJxRM/6QLkyG41yOqc7lQ+SYp0bFxzCBNSSwPFU8lDNE08teoWD9/tOEMhc
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2026;20:ceCWZe4oDf9dQqCpE4GUxqzOnO/RlFLZe1eEBA+l6St4wbxduFKhymUwyw5irQMbj9/VSLtsoMzkQUy1E6zskM+2+oV13PpuMLeiK0iWbb/L8K5Fm9J43cAsV59EpMbRH+7n7NqhLiwbSHKfZDAJYCv/tY5B01TFmLdkcYcwl2M=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2018 12:08:19.1130 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6228cb1a-60bd-4ee9-45e1-08d622166ac9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB2026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2 weeks passed, so ping.

Miklos, any reaction on this?

Thanks,
Kirill

On 11.09.2018 13:11, Kirill Tkhai wrote:
> Hi,
> 
> We noticed the performance bottle neck in FUSE running our
> Virtuozzo storage over rdma. On some types of workload
> we observe 20% of time spent in request_find() in profiler.
> This function is iterating over long list of requests, and it
> scales bad.
> 
> The patch introduces hash table to reduce the number
> of iterations, we do in this function. Also, algorithm
> of generating IDs for interrupt requests is changed,
> simplified request_find() function and killed
> fuse_req::intr_unique field.
> 
> Kirill
> ---
> 
> Kirill Tkhai (3):
>       fuse: Change interrupt requests allocation algorhythm
>       fuse: Kill fuse_req::intr_unique
>       fuse: Use hash table to link processing request
> 
> 
>  fs/fuse/dev.c    |   47 +++++++++++++++++++++++++++++++++++++----------
>  fs/fuse/fuse_i.h |   11 +++++------
>  fs/fuse/inode.c  |    5 ++++-
>  3 files changed, 46 insertions(+), 17 deletions(-)
> 
> --
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> 
