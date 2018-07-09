Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4F3C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BDA820878
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="T3K72tVN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BDA820878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932628AbeGIIj4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:39:56 -0400
Received: from mail-eopbgr70097.outbound.protection.outlook.com ([40.107.7.97]:38448
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754636AbeGIIjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:39:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vYlHy0Pnj+SEEOP+jgsRFUdOfc76+E+1KUo7Gtg+XU=;
 b=T3K72tVNqgQqtNpp1S9Vle4GZeofdtNkmEZJCz4heqxos2NKpJC7Uu2y/bdu3EOxRjVKu8U7cx7TyOGehY2ERpXmYlVq5vKUN6UvdccdwXQDI4P76wF9d0s7SO9zl4h8UgaFn2D1I2rT2KuU9w3JzMiY/k83ZfWy7kXD/njStIg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (185.231.240.5) by
 VI1PR0801MB1344.eurprd08.prod.outlook.com (2603:10a6:800:3b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.21; Mon, 9 Jul
 2018 08:39:48 +0000
Subject: [PATCH v9 14/17] mm: Iterate only over charged shrinkers during
 memcg shrink_slab()
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
Date:   Mon, 09 Jul 2018 11:39:45 +0300
Message-ID: <153112558507.4097.12713813335683345488.stgit@localhost.localdomain>
In-Reply-To: <153112469064.4097.2581798353485457328.stgit@localhost.localdomain>
References: <153112469064.4097.2581798353485457328.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: HE1PR06CA0140.eurprd06.prod.outlook.com
 (2603:10a6:7:16::27) To VI1PR0801MB1344.eurprd08.prod.outlook.com
 (2603:10a6:800:3b::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f72201da-600c-4159-bc66-08d5e577890d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1344;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1344;3:khmk7QGE/vnup1RnyNHbGa17IawO+SFauoKLw/Fn22iVWHbzVWMfVPocJgNeTtOo/IK0qLfe5K63WNOmhAWIrB0Oa4XfytmNfqpud4svDf+5wWv2oUVt7kLsOZ00Ggd9I3hyD9+OpfW/UCWI/A/ed9QmuOszXEi/Gkz9Etgg3iLg9Mhwl7tupUHehzqjSotO/b66XwubOmjX3KCBCu+rChZqDYdDPYmxrQ50wc5tDuSZa+nsWuuZYBna//mqKNo2;25:s8pMljbiy/pvI9I7zkGDU/6DPdhFSb10n9eAqDEHPUug+yOCuP9H+B4xEJTERJOez49unJ65evivHAS6QfdsI/B49wpE4cQfBv0K968NHTXiM8b6YIdE7UukOUCM4+jaOxVjkzfI3HLkXfztz7R9ADV8+grl01HoP/aGQYre+LnbS9dTIZ2ryHmm1BscGlqpxhg4b26dEE3HMxHBW4XDzYMgnNUWUWaJ1lf0GOYN8xClhZJhj2Dm7XkYbXpraDLQ6e6RHWSxOB0WgxUZnzs+dZ++gR+/0M76LTWoy03Oeade5KbIbi1mC2L8c4v2t3IcanE31KeSrRXfrZKu6GyNyw==;31:SascwOiYDTa1VoDngcgJ8XaQmUjFnVKUpWiGuv7bp5vHYRrXIZq3jnFFzkBomoP4R7uyPIEDcEOLLYDxrO0FmJ5t0npkmuThUb/6hjx5kUlCqLLwTiLztoJ/1KGjxskJHOhkYVt8Z4IKSiaU6fWhTYAJrRQtNSM0rSp1aA7qgHjK0ujYGAsTgjFwpRzFidEiU6OBQDDqunKj+HI2vcB47Z/Hc6SOPAfxJTOv2SKc5gM=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1344:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1344;20:rWdhG6eemvk4hvbBi2gJbcHlxMwVnh4FZvWXF4adOIHDN764iIN8uOwZ0x/RVBQ0LXDhAOJ2v3jm5Sxnus8f6VPwG6bJPIIhjXZGd0KmY7fio8tJzg0qByNmJBByTzxss6xStTyWntepl9F2o949xNGwMDhE8U59PaX2wzLVLxl9/3yBHoO8FDfSV3DguOv6XN0wm9doLfdzGwaFOzaZOWTGWM6nKlOqJVsgLxLI5n9AbY8YGWkD4HBfVmm6qYYHnHiePAfhTlDw98xtWYJHF1RC4kRu/axpzfuQ8BEGT2kG5oCZsJQcAiLM7kEC13NWjfAYyWN4FYIoEWXhiegKs5Rr+y+L+aApUlsTPGpAmpH2r7c2gpRSOLcZgi4YvcpPHV4m8WQrYFkvg3ImWP7roMOH86avHVdVY9cKFTJxG5g3SErfgwvCIMOO8XS0sljq69zQ4baxTc4g5A667BqP7vq23ld7JzBqGkZgD67eGX9SIBwRee9OENVp6YRb3i7x;4:KoZak0iyowso7t9k5il460vkw8pp3YYkbsB8L/lWuw2yk6tmp+gztxGo/jBth12/93ibH2wRfzdcLUlVhsQMZ+0rmh91eBDgCt5Pep7u/oJyPY7PnsPiffb4md/2OQ5YK8uPeH72tqtT1RT6NKy3qYFfOmxhRFBen7atIgBtJCyDkQd3pqr01jwZ6ZMGyGH9L4UouhIj3vHu0p4W2Y4AGLlu9T9jIj+j8KwTalAZrhZ2vk229Ke2E1tbKbpq9AOoGd2xbhTgENe1jdoiMlgTFodpAp6hGo1ETXrMQq28F5bOd++bmHYpcblwNpnkMmwWc+SjrzOsfyOnyH549tG0YpY+Fvv5irViGVUicHn7jbPN1Axubyb5q+Ybm1ibFkf1
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1344285FF187F29AFB7992A9CD440@VI1PR0801MB1344.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:VI1PR0801MB1344;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1344;
X-Forefront-PRVS: 07283408BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(396003)(366004)(136003)(346002)(376002)(39850400004)(189003)(199004)(2486003)(7416002)(5660300001)(52116002)(7696005)(106356001)(105586002)(7736002)(305945005)(2906002)(23676004)(68736007)(25786009)(86362001)(14444005)(58126008)(16526019)(186003)(97736004)(53936002)(6666003)(486006)(50466002)(39060400002)(386003)(6506007)(476003)(61506002)(26005)(11346002)(76176011)(956004)(33896004)(446003)(47776003)(66066001)(316002)(103116003)(9686003)(55016002)(230700001)(8936002)(81166006)(8676002)(81156014)(478600001)(3846002)(6116002)(921003)(1121003)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1344;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDQ7MjM6d1pjNkpHV1M5Mmw0T3E3Y3gybTZXNkFP?=
 =?utf-8?B?OW43SnNzM2ovTHhrRTNYM3kvTlZzRjFJNkVBRkFpQ0dFbUdGeVdZKy84NGhn?=
 =?utf-8?B?c1VQVDNZRElVd0ZFOXdIV1M3dC9LZkpWZFhwSjRYb0tpczRZelU4b1RjU2Y1?=
 =?utf-8?B?ekxWNGJNbDV0clJsZEdaOGtMR0k0V0VPY2hlSCtYaERDT0ZsTmRZOElrSjN0?=
 =?utf-8?B?Y3JzL1ZDbDFmUWg2cDZvSjhUZURkcVV1YkNWSW5UU09YTHhnUlRDb2RraDNW?=
 =?utf-8?B?S3dZbEtyMCs1T0dKYllRTVBTVENvd2k3ZlViNjc1RnA0K0dGNGVBbWVZZHR3?=
 =?utf-8?B?dS9jRDRMck1QVU4wc201S29odDVzajVMaUdZdEVaNU9EaDJwYXk0cGQrSGda?=
 =?utf-8?B?Q0FpZGFKejJxRE1GUUhJODJNWUo0NDlRa3E0YVVjb0xod3NFRElnR2pzcnVJ?=
 =?utf-8?B?T1lmR2U4ckJsSUhxc05TcUR2dHplNWFKcXJodm1EZG11WEIyQityakg1dEMw?=
 =?utf-8?B?U0JIL0kzdys2QU1ZQ1o2NEJkUitLMmNZV2pFNEdzeE4ySEJ2VHN4dHQwdHAz?=
 =?utf-8?B?ZGVrQXRwNEhiajFLNTNDdDNLOWNBV2tQYjJMUVJKMkRBckxyc3RHdDJCWXVO?=
 =?utf-8?B?Y0hFcUJLQjlNVFY4aFBsaG9kMUVlRisrcktrS0tudDg1STBNUzRoYnZyU1U1?=
 =?utf-8?B?UXFrbWdwMmlwc005aXpRSDJHVUZjbys2QkZjTlprVEtUQ0hqS0g5ZzFldWh2?=
 =?utf-8?B?SXdXSWkyRWtqcVBmSHlkc0QwbW5nK2YvS1FlTnNSUExzTTNQMHBaT3lHSFQz?=
 =?utf-8?B?NE1pOExNbGVHZDBrd1plQUlZa3lQVXdUcVVSQnNNK0Z6UDhSSjZLMmRLN2tu?=
 =?utf-8?B?R1hjaFNYSHlrbktEYUFrMVp4V2VTaTMwVXZBMmFyckhhaC9aQXNiekRCWFVI?=
 =?utf-8?B?eWdURERtalY1ZUxrVWNKS24weUs3Ryt3OW9ITEJSNDd2V2RoTTQzN25lTDR2?=
 =?utf-8?B?WjVrNnA1K2htU3BSRWxHRTM0NzZKQ3lHT05TQ0lqWE9oSDlRSkpQaXZVb3Ax?=
 =?utf-8?B?ZVZTMldlUzJwb1N1a1UzbVJjbWExY1VTLy8xb2s5T3FiT0c5QWtDTlV3V2g2?=
 =?utf-8?B?bVJBMTJaa3VmZHNyaHo2bHFKcXJyZThmTFV0SU9CZG12STVJbDBHZStoeUNv?=
 =?utf-8?B?ejBwKzdtRmpIbmRaMC90dmg5YkpRNE5Mcjg1WUlNWHNsd1BicHVEZGtJWVZz?=
 =?utf-8?B?WmpTbVMvMFFsVHJTOFFscEdXMDR2ZXRYVUd2N3dsUkpFTm0vdGFJc0RKNk0r?=
 =?utf-8?B?U3doYTduUW10NUozdmNLZFpNdXNrd0wrSGl0bEpKMjdDZXVIalBhTTZQaE9m?=
 =?utf-8?B?d20xd3BUVEMvNU11L2c3ZGw1NVlzdi9aVlhhL0ZCclBhclowTm1vaHFaVmYw?=
 =?utf-8?B?cW9nUWVFZVdzUXRXdGF2d09YOGxvdGlKbDFidDBzTjRtZTBtOTY4eWxJTGZS?=
 =?utf-8?B?elgrVGlGcnJEcjhYeUFWeERGbS9DbU9XZjY2YXZUK3hQb2szc3JSVXp1NnFE?=
 =?utf-8?B?NlVKUmJvOU5RM1ZXY21ibTBrRE5GNWVVQVBDYzJFWjk4QnFFaFhZTkZSY0Rh?=
 =?utf-8?B?WGNvY21RL3kzTk5LbUVXMUJ4dnYwL3pYaTIvZFBiVFBrZmZoUDhRK2oxUWNi?=
 =?utf-8?B?YVNDUUwrdUdkRU14MGdIM1pTUVdEd2hUbmJXZHh3NVRHNkpaNldJdFQ1b2hV?=
 =?utf-8?Q?wR2AlzFL1JIVAXjvEVNh+wIAhQE2E2Q5fsccdsU=3D?=
X-Microsoft-Antispam-Message-Info: FpcdGrb9hmgvaFCu/O9BQTErNj6TLJZQIpvnsvI4eL7TJUMy0FGAfI7Qvsodd4pYPhOnOloXmP5bdvNY6hECIt0WFk2141COJhcgOkSwqR0qPGEb66BnmOjBYlDDTaW49kciFqPQ+fDbVa7gUDAXm/ohVyA5UWd6JZNccs19Y1qENovZoQvGHjYun9bzVT/674tfFRxxebkXM23LIxrlw8t7T2YDE5Tq52HfOgxZDBwFdUfh1d3Ea1ND8YqKMwjW6eHvxDVInY7JKNtdGox7xdoT1JVtVoFkD856pTBHfIR55jOPuThyl1vKLGHi6D+ROQkM8VdnokaDYbfSF1BV0jQKrZj53anSu84SuZZbTVc=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1344;6:72bb+B32xb8/0lBruz18CL/ZYSYMlZfAIcA4zgWjUGpNqm7Oyc20TOGE1NvZRMrkXPipI1Fjd/oLNJ/Q9wLcqS+PxUeN3UlRTWgelFQaF8YGb5MsPJSE8vQzr8MTp1QCCYbin21uOG/OPfWO6Mt2AaEMukQPvhHl73NvDMCcSI8CiRUzpe+YlRnpjf8HBxlfuEptfnNqct1WSBN4IgWcE86HssdexjvWNYUkemsX+C6Ak+3LZs9adebwdXY8A+k2iZs2PjoxYVTUDP+O13jCJCb/svSaPb6YppFL0EmZxEo9q4hjVg4qEotcljl7RlRDyOC6mimhdZPtvZEEpoMNqJiqYL6F8/UZzON2+xsjfElRmjvr3pv5gI5RKUzOWwuKDwAnfepfqp5JqcC0KEQw/Hn17XwkYXdwtVZ7yQaT4YUj5jAr3xz/hmPELEfMErZ2AveV27gh1Q5Ee875qRZzug==;5:IomnAY2vqLCMd2AESLawhdjlaEhfOLhFI1U5ClAEkzAAjyRWkVVK131gcTSlAv1FlB6KLkugidD3cyiJ+Qm1IYbk5+lFJ7vVwFQxpOpuoDTxzcKBq8f+vjUyvLwIe4RVya/D1qT65mCdrFxFb3xdVVnj4JLhYdZscv+qSnfUywM=;24:llctBe4bEO6ZXQJQLNKdtJZuUD8SC69zZbVpXtpF2OHusWG5Bj3ClwAWr8CDgl3LjA2WkPojPmYGBiMLf6ZthP8GV8YlSX6pZGhFIivPusM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1344;7:+ObHeaNEgFniW1DWsqrkUpj58SXAtIOkSP+QVsS8YH5IKGi/IaBTroUEwMgYp83zu7LD/Sa80PaEjLnU0l3mBXSuI1v1viyEmcAig5e7BSfsx4Vd6gXdWZTB2j2ivja1S9czPNnxaa5EbhLVR+9VnM0FowWbmxTknQOcDQ//WbMAhNh9BGEb1LuWMo3RvPJ+/ylzp4tqt8fnP6OATj4ucuYM0iMape+LT/NDgKSL9B9j1oxjQC4L0BrD34wjjOgq;20:ckKCT0skUV1dRCrPvRc7FSr2IwRgoViLPfHe7/ygFFrtKwx7qlivDVbnsVXIK3NcNYd7vbWiaplR7FTgjz3BilB2rQsY/CahiK+1MEfRcoon1pi7h2MqTDJ2l/zJZUt/iKhCdoAcxD4egN6kXSwp1cOHAD/y0NlvYTk/3ZRaGsc=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 08:39:48.0889 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f72201da-600c-4159-bc66-08d5e577890d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1344
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the preparations made in previous patches, in case of memcg
shrink, we may avoid shrinkers, which are not set in memcg's shrinkers
bitmap. To do that, we separate iterations over memcg-aware and
!memcg-aware shrinkers, and memcg-aware shrinkers are chosen
via for_each_set_bit() from the bitmap. In case of big nodes,
having many isolated environments, this gives significant
performance growth. See next patches for the details.

Note, that the patch does not respect to empty memcg shrinkers,
since we never clear the bitmap bits after we set it once.
Their shrinkers will be called again, with no shrinked objects
as result. This functionality is provided by next patches.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Tested-by: Shakeel Butt <shakeelb@google.com>
---
 mm/vmscan.c |   84 +++++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 75 insertions(+), 9 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index db0970ba340d..d7a5b8566869 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -364,6 +364,21 @@ int prealloc_shrinker(struct shrinker *shrinker)
 	if (!shrinker->nr_deferred)
 		return -ENOMEM;
 
+	/*
+	 * There is a window between prealloc_shrinker()
+	 * and register_shrinker_prepared(). We don't want
+	 * to clear bit of a shrinker in such the state
+	 * in shrink_slab_memcg(), since this will impose
+	 * restrictions on a code registering a shrinker
+	 * (they would have to guarantee, their LRU lists
+	 * are empty till shrinker is completely registered).
+	 * So, we differ the situation, when 1)a shrinker
+	 * is semi-registered (id is assigned, but it has
+	 * not yet linked to shrinker_list) and 2)shrinker
+	 * is not registered (id is not assigned).
+	 */
+	INIT_LIST_HEAD(&shrinker->list);
+
 	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
 		if (prealloc_memcg_shrinker(shrinker))
 			goto free_deferred;
@@ -543,6 +558,63 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	return freed;
 }
 
+#ifdef CONFIG_MEMCG_KMEM
+static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
+			struct mem_cgroup *memcg, int priority)
+{
+	struct memcg_shrinker_map *map;
+	unsigned long freed = 0;
+	int ret, i;
+
+	if (!memcg_kmem_enabled() || !mem_cgroup_online(memcg))
+		return 0;
+
+	if (!down_read_trylock(&shrinker_rwsem))
+		return 0;
+
+	map = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_map,
+					true);
+	if (unlikely(!map))
+		goto unlock;
+
+	for_each_set_bit(i, map->map, shrinker_nr_max) {
+		struct shrink_control sc = {
+			.gfp_mask = gfp_mask,
+			.nid = nid,
+			.memcg = memcg,
+		};
+		struct shrinker *shrinker;
+
+		shrinker = idr_find(&shrinker_idr, i);
+		if (unlikely(!shrinker)) {
+			clear_bit(i, map->map);
+			continue;
+		}
+
+		/* See comment in prealloc_shrinker() */
+		if (unlikely(list_empty(&shrinker->list)))
+			continue;
+
+		ret = do_shrink_slab(&sc, shrinker, priority);
+		freed += ret;
+
+		if (rwsem_is_contended(&shrinker_rwsem)) {
+			freed = freed ? : 1;
+			break;
+		}
+	}
+unlock:
+	up_read(&shrinker_rwsem);
+	return freed;
+}
+#else /* CONFIG_MEMCG_KMEM */
+static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
+			struct mem_cgroup *memcg, int priority)
+{
+	return 0;
+}
+#endif /* CONFIG_MEMCG_KMEM */
+
 /**
  * shrink_slab - shrink slab caches
  * @gfp_mask: allocation context
@@ -572,8 +644,8 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 	struct shrinker *shrinker;
 	unsigned long freed = 0;
 
-	if (memcg && (!memcg_kmem_enabled() || !mem_cgroup_online(memcg)))
-		return 0;
+	if (memcg && !mem_cgroup_is_root(memcg))
+		return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
 
 	if (!down_read_trylock(&shrinker_rwsem))
 		goto out;
@@ -585,13 +657,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 			.memcg = memcg,
 		};
 
-		/*
-		 * If kernel memory accounting is disabled, we ignore
-		 * SHRINKER_MEMCG_AWARE flag and call all shrinkers
-		 * passing NULL for memcg.
-		 */
-		if (memcg_kmem_enabled() &&
-		    !!memcg != !!(shrinker->flags & SHRINKER_MEMCG_AWARE))
+		if (!!memcg != !!(shrinker->flags & SHRINKER_MEMCG_AWARE))
 			continue;
 
 		if (!(shrinker->flags & SHRINKER_NUMA_AWARE))

