Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7108C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F63D20875
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="K89EAX50"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F63D20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754662AbeGIIiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:38:55 -0400
Received: from mail-eopbgr20099.outbound.protection.outlook.com ([40.107.2.99]:2060
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932628AbeGIIiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:38:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KV3MWILoQz12kP+iXeNvS3/kLviPBnPXXzBSnu+9hc=;
 b=K89EAX507homFWRyLYa3h9V1PkxJ6F2/K0QBxpo+kPKnLMYUj8OtsQBIVGi6q4pWGMk5ftFun7Cc8YOW44UT0bhuVZTmOUwGr7DtmiOXLhfNXsK+6LKoQ4JprDpO9HMQdMqz4bUSZU1nc3Bo4ROZ87iYtWp+YzdIUO/FNOtHoAs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (185.231.240.5) by
 HE1PR0801MB1338.eurprd08.prod.outlook.com (2603:10a6:3:39::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.20; Mon, 9 Jul 2018 08:38:45 +0000
Subject: [PATCH v9 08/17] From: Kirill Tkhai <ktkhai@virtuozzo.com>
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
Date:   Mon, 09 Jul 2018 11:38:42 +0300
Message-ID: <153112552271.4097.14161701828315972494.stgit@localhost.localdomain>
In-Reply-To: <153112469064.4097.2581798353485457328.stgit@localhost.localdomain>
References: <153112469064.4097.2581798353485457328.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: VI1PR08CA0115.eurprd08.prod.outlook.com
 (2603:10a6:800:d4::17) To HE1PR0801MB1338.eurprd08.prod.outlook.com
 (2603:10a6:3:39::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f0efc00-fef3-42e5-18cf-08d5e57763fa
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1338;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;3:uQRf7Jke3CoujQyTygtrqZOEmHPRSoQSBP+dcHtoHZSLfPHa2To1iAHMHgPO+ySjc1A8xJLB8ryDme3hf2/4S1TeTNRZ31+E8shc5MjmlqZ9+gjEiBq7bHJtzLNA1WD+hf5VGYdiwlF1cldS+hr+jaVDRr7D+cBT6yStj3PsDSUpyQs2kSiFyQKa5pWqVWTpIohZpjtF+IA0BLWkqME9zdK0zgv019dpa08LronsAsdI51uxbQ1lE+gzZEbUgJFn;25:pkvCJMRIIxASbQOOo8WQRllOHxJdU5TgAOBbBQG49zNAAt0meMAPQPYPxjw90LbmMFjrqBMHMjWhIWsMNwVrKxyjzhIUG5OJh4l7xhE2z4Gj6xJspa6BLyjv6bPik6l0zr50S6/dCK+VXvESm2P9e230j1rlrw2HtS8Bz1e+dhwTg0hr6LRrSwKLdzZejH7kx0p4NXZ1nw5uSzXKJCOlLgIQPA1w3oXzjtDda97fx4n9ye3KG7ExzIr6jYKoHSopF1ShTXIW5CqkxhTrC8NAamDRoPmVI+EUH/GK1I+qJNE38nEV7iAEMsdHzSKoCI42m4y0umOLqtuz31Gst9QkiA==;31:6zj+LjOuwlvgWzck9UrxDAmm7MSyv43e/ogtBo6i8CZjHEjUZ+9HVcEiCEa0LAfI97Ps7+fecdRnmraXUSzyDklctM/rVrPdD7AkM2dTtwPDLz7le0kPjeUmDOHKip7VbzcxnNy/oJUjo93xHr3LnafX6NUw4PQ1h3cFqgInqDIvKt0DXPwN0z4klVSLPZLJvuRQgBhhOma/v7NPJe9cykOInidSQQUlCVZMm9+DLCc=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1338:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;20:70SLl7/A7XCGdNz33ihfDP4gRznIPfrSrUuzAOUUEAuDSEPAM+q01f554EhnPD5eibFSaxJR6Xp9lua3giFQj1xRx2KCAGum1zDgnNy5YBKwv7L01/EksvExBOZuL3OMiIf4GkUUNq5ZnV9iFEI9zDT3E6mq1mSrAzEqLqdSP0JUehPjFsTKkHo3q8OO6lBGevLVI89WHuo10xCnf9kPPRMy4YyC4MuC9CxrYX0/O1ZPCoPZ6uqPhpRQCENvrjs2vAeC03oVMb5HEclRNFIQnCTmv/w+FocSiF889050lqHOkonW3kOiyfMGnUNozRfvBPsWL+P5uwq1R/OwRBlm4Z5TqZneObo/r6aLWsko7R29nRRG2vfjd6/xDtPmmiWmN4HVjBliX1ZHC+xoeK1oT/ExJhwRp7vCRphpk3ZhV/SJezhUt2jxdW89Iq47dg/ioieL74l+aYHPdcdYX+5hxm0pxFJVvSTQa9OzstKqsDBV4GEy4JNClN8UxFhQpwJd;4:5YFGBz+UTbZC+qKxvubxHx7CynO8YyDFb9gaCWonxwS84Svrlqu6BolERGXPaYuba3RpawNmSFJf35KdLExay+JVvWclA8VfmWZZuYYBJtRPySMNH9W8aUxbmsXLqvsg0OCGtYbx8F7X/5car1m8dYLzKG83mslwPZ8120krfJAE2Mr2U5Sc88/zojtcTXuhU5ZOQhycWL1dk3JRmJ9w45WbZ3i2BhY4rqcZsPR88E7lRUBcDdkJI2maD2BSAogD95LSyOCepou02aGOENLI/D2P3zU7JHDx0CfGNcdXnLUduNRSigH1zMYxHMu+BX7+du6eYI9I5nXnQCgKwhvXiy1LNJT65eD1PGZtgCNatwvr8CdZpjJkmOpMJ5x+910s
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1338471EEA0E56B149156BA9CD440@HE1PR0801MB1338.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB1338;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1338;
X-Forefront-PRVS: 07283408BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(396003)(136003)(376002)(346002)(366004)(39850400004)(199004)(189003)(23676004)(103116003)(478600001)(26005)(9686003)(76176011)(50466002)(106356001)(6666003)(3846002)(105586002)(6116002)(14444005)(6506007)(66066001)(53936002)(186003)(33896004)(55016002)(47776003)(68736007)(7696005)(2486003)(52116002)(316002)(39060400002)(61506002)(386003)(230700001)(97736004)(16526019)(8676002)(7416002)(5660300001)(2906002)(81166006)(86362001)(575784001)(8936002)(81156014)(305945005)(7736002)(486006)(58126008)(11346002)(956004)(446003)(25786009)(476003)(921003)(222073002)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1338;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzg7MjM6Q2FRaHVLQ05aT1M5TTkwb3lPRzhQYWJC?=
 =?utf-8?B?dHZlZU5tY0hqN0cyTG93VjBVeWFJc0pZYUJxY21Ga3JvTVFCLzJIN2Q2Z1NU?=
 =?utf-8?B?Tlp3L2dIV21xbHVSakxGMCt0cEQ3RGZ5OFdONGZ2QXAxVEN5SVp2WDlqZHJ3?=
 =?utf-8?B?YWdXdG1GWmxhb1J3SkhUTWVGc3JrUmY5SWhOYm44cHpZMDE2bUpmZFdpaXM1?=
 =?utf-8?B?elV3ZmJ0TkpBTWgyK3NKVkdjNkhXZksxM1Bvd1FZcnZnNjhoTldZUVVmUUpU?=
 =?utf-8?B?VWpRb0xTWWxPL25hNTZhbEwrUndVQ1dJSHk4RklTc1dxaEE3T0ZDbml4ME5x?=
 =?utf-8?B?QW1YbmpGYjVORmZ1YmprWEIxQU9Xb3hGaFpHa2k3eXJUVWZCalRGNlNuU1lV?=
 =?utf-8?B?UjVuUndFdFhjVjFhRmFxMmVoR2RMREtNYXJmbGg5RjRaNGhQbE9RNzNSV0Yw?=
 =?utf-8?B?aEk1b0Y4T2ptVHExLzBDWWIwS2hrVXRjZ0Z6S1R3dkRlZ2NOVDZQY1V5ZGhD?=
 =?utf-8?B?SVJJTnlpcGVXQTVlcEwzU2c4K2tiV0pWYjlRY3I4Z3hGZ3Z5KzU4NDRGWFhm?=
 =?utf-8?B?T3ZUVzFuaGdQcDRWU0RLYWUyYlpPVExIOTNjZTQ0c2g0ak12UHlNUFg3UTVx?=
 =?utf-8?B?VXp5OXFMY08vMlZFT2JLazNOeTNPZFVjczZvOUprbGQvK1dhOVVkcm5lcmpU?=
 =?utf-8?B?ZllDeXdIMVFNWkhNY053N0EvbFRCYTZmNUo3QlBtdGdXaS9idFQyYmVFdnMr?=
 =?utf-8?B?MFYzRGZRazlBN1VHVGlpNkdjb1B1aWRwK05oeEhOaWl5bVBaVFYxTDZZb0Vh?=
 =?utf-8?B?SHNhTHJ6U2doT2V5Y1hRYWpWbmpSRmdaT2ZERUF3SFFTN0o1WmFVeEc4alY3?=
 =?utf-8?B?MWNMQTJKcDlmZ2RIUkl4bzlZNXpLbU9uWUNhZTNWUU9DTTVZdW9WOEF4VHA4?=
 =?utf-8?B?cUFzYVpncjBCajRQRVhxeG9XY0FQZDNtanJKdHIwV2poaGJieFlqMkw4aVlz?=
 =?utf-8?B?VDNKNUx6dmQrR0NtVmJmOGkyT1BEamRCNVZRbUVIdVpxQWJMNzV5VkNJNENz?=
 =?utf-8?B?cWdnTmg2SkcwT2U4TTQ3ZTE3TEV2MHg2SzdnL3J0K25zZUNFTHROak1ld29k?=
 =?utf-8?B?VzNUSG9naEdBdHRSdE1STnJ0T1FLMkdkWkN4VnNrZVVlR1prUG1qenFjM1Mw?=
 =?utf-8?B?T0sxMFREN0JoMDRydjR0bC9FR0xjQkpWbVBKdHZsRExkeXhkUEJPazZ0NXRz?=
 =?utf-8?B?WjV0Nnh0KzJ3TTI5TXBKYkw1UXVXT1RRM3lQay8rSDY2UHZWMEZlS0xkZlNM?=
 =?utf-8?B?bUdzVEpsQVVHd0hpbjVjb2VmOUFXV0swYVJ3Sit5MmJoZzRGNGNKaGMrL0Nk?=
 =?utf-8?B?UjJzT3ZNVUxwbHJ0SGtmUXphSmtVUWoxNDhuUE51b05jZnRJNm5RWEFic2NU?=
 =?utf-8?B?R2xQT1VFVWZWTytVN2c1NlpLVHFLaGZ6L2t3ekxEU1FkYkd5dGFTYUFLcUdE?=
 =?utf-8?B?L0lTbVI2QkZFRFpzMUFZeThiZHZTeUpOWEt3czJxYm1nNzV3N3Jxc3VYR0dB?=
 =?utf-8?B?cHJNOWRZQXNnTGRLSXZGWGNoZm52Qk1xZ3dtTlFRMXJUV2R6UTdOc0FDZXUv?=
 =?utf-8?B?U0FCQzd2VlNaTmRyRy9uSk9ndHhTLzJLb1IwOEJFVjBBUVpYWjVTTlZHV0ww?=
 =?utf-8?B?blVKd2J4TnR4RkQ2dnNoR0JNT0t4THRoVitSMzBma1V6cm81Q2NuYnEvQ3Zw?=
 =?utf-8?B?Nis2STQrYmJYcUlhVGJMVG5kb0E0cWJHcVpSVTFHdnhhZkV1bUd3MHpIekxK?=
 =?utf-8?Q?M01tw6t2v/l7vWW?=
X-Microsoft-Antispam-Message-Info: 7cAK7mk1bbuVUrNiRzY6ZCPKkGt4AQOFgyy2oa06HX3aqHDM+R2P4kFfqMFlaOS2EUcaqpwY4Rx8OyQq2DNvir7Fto3wR9y71k57U5lDyxABYwIhHzGtzIRRdKa00XkrFX2RV7/lwGB5OMJAytqLyK6eu4AaU2aWMNEyt+snL5ERRB1Co1b+GwRrOaxCBEoEAbKeCLXhen2nwRz5/Fvq7VyZp5gpJhMwI+Z/tAhQ1UYPDASkVTYCdl6uI1pFMqV0OttCkEs9wkMpJsqE8XBKtyQV0XRcRBZl+4dJKw3r0SwZNCPexGCRS5qiE6wGhz1i7JuKqAxGBhHXn6WrzC4vmfKTVwUR62TNrEz72YkamRo=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;6:neJ6Ejqzk2eymCe5QbZQBzddue0NxI32//fhMpaUSgFjOrc8EvdckYhJaDMwjNQzVj94sgnQkknIz1FBVl4kg/wLBIWha9nGFHPktZzNjbqV8j78dm/Ki7K+bPvSOc1RxSZn2cnXCPlCI6jIWTyQ7MFmACzmlyTZxARd8z/fvgU5PUDMg9mLVnHY1KdbkllK74/TP967hhuhbd+UshEFxRVRv99tWKnxkVSQCot5OG8kVSG2+e0SiaKGZS816iDMxtxUxuzadMsqAXf6oIkXeWLlj+0OW7xkZFcqUOyCAo8LVT5O20uKHerZ+h/NekSUMfu/x7D8zI3DqJA8TXdf6r3iO0TDAdqKcTVko/7oluWshK98DLrv2aQ6Tf4oMx18K/TSn50lUoEoRNdo1fBnNuM54qwYMLsm80GTtG25yv6KNAE2xnHrFSGsrp8S+EbR2FmLuGl8Z1nGCU4QzU+t+A==;5:i/VjH/mDHmzzktOcIRV1OMdg8Fcu3l0iybcqjWipgFa2F/j3e+pa3SOz2vtz3JBD2cpZgns+whuYYMr5PdCkCbXj7CnCPh8urQJmuBB4fPhG4S/EJ6WSGlpiu0EooKZsi9VIvZ9KECpn+It4LQ4sZXOwqSN5Ux690a/k3QGtSjc=;24:TIaw5FD+hRUc4UHK/2IMYNT0hzGFQZfLe/DbjglF2HllJAZifjGr//w/29kExoAVOXxaxgMKXsxU6PxWTF8Zz04YiGoyBa11siM9ESnmN08=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;7:TtYgBLvzRl5sUg301PXL+5tV3B8sXJXnEUfMXK18aDll1+oCDOpgCpFpn2VnRHaE2c2pa5Mbmztz7kFX6QkCXEYbIC5BvvnWtE8P8A+5Xn/XD96E8tdBFJ5gT+l9fRYxUlSpzWZNduMz1scfDxJ2JBT/jcUU8eR3MwJr+B+NSDU28PrfZiTEyN6zAvH4yjtE6cGMunJ5+jSxch+vjPanKGODufeH0cb0qzkw34O2UY2br9klHrkdLkTObRoMFLuy;20:jl4m2F99QO3LxlYTRDOEoQC6b0NeXwPkNrKvXF75vwUgNnk4IS4dHj87DXPdwfy6j200I7W40TWE+S611oYw5ThyRF4D1I99cnri3LqKuLnZjtsdSEMn7IhadPIWxcfmzgUakMuOQGrdPk+cCPgvPZeNPe96P/HuBE1TsjQximc=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 08:38:45.4912 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f0efc00-fef3-42e5-18cf-08d5e57763fa
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1338
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fs: Propagate shrinker::id to list_lru

The patch adds list_lru::shrinker_id field, and populates
it by registered shrinker id.

This will be used to set correct bit in memcg shrinkers
map by lru code in next patches, after there appeared
the first related to memcg element in list_lru.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Tested-by: Shakeel Butt <shakeelb@google.com>
---
 fs/super.c               |    4 ++--
 include/linux/list_lru.h |   14 +++++++++-----
 mm/list_lru.c            |   11 ++++++++++-
 mm/workingset.c          |    3 ++-
 4 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 78227c4ddb21..f5f96e52e0cd 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -261,9 +261,9 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	s->s_shrink.flags = SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE;
 	if (prealloc_shrinker(&s->s_shrink))
 		goto fail;
-	if (list_lru_init_memcg(&s->s_dentry_lru))
+	if (list_lru_init_memcg(&s->s_dentry_lru, &s->s_shrink))
 		goto fail;
-	if (list_lru_init_memcg(&s->s_inode_lru))
+	if (list_lru_init_memcg(&s->s_inode_lru, &s->s_shrink))
 		goto fail;
 	return s;
 
diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index 2d23b5b745be..9e75bb33766b 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -53,16 +53,20 @@ struct list_lru {
 	struct list_lru_node	*node;
 #ifdef CONFIG_MEMCG_KMEM
 	struct list_head	list;
+	int			shrinker_id;
 #endif
 };
 
 void list_lru_destroy(struct list_lru *lru);
 int __list_lru_init(struct list_lru *lru, bool memcg_aware,
-		    struct lock_class_key *key);
-
-#define list_lru_init(lru)		__list_lru_init((lru), false, NULL)
-#define list_lru_init_key(lru, key)	__list_lru_init((lru), false, (key))
-#define list_lru_init_memcg(lru)	__list_lru_init((lru), true, NULL)
+		    struct lock_class_key *key, struct shrinker *shrinker);
+
+#define list_lru_init(lru)				\
+	__list_lru_init((lru), false, NULL, NULL)
+#define list_lru_init_key(lru, key)			\
+	__list_lru_init((lru), false, (key), NULL)
+#define list_lru_init_memcg(lru, shrinker)		\
+	__list_lru_init((lru), true, NULL, shrinker)
 
 int memcg_update_all_list_lrus(int num_memcgs);
 void memcg_drain_all_list_lrus(int src_idx, int dst_idx);
diff --git a/mm/list_lru.c b/mm/list_lru.c
index c5217d84c6e1..5aebbb9b2f5b 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -546,12 +546,18 @@ static void memcg_destroy_list_lru(struct list_lru *lru)
 #endif /* CONFIG_MEMCG_KMEM */
 
 int __list_lru_init(struct list_lru *lru, bool memcg_aware,
-		    struct lock_class_key *key)
+		    struct lock_class_key *key, struct shrinker *shrinker)
 {
 	int i;
 	size_t size = sizeof(*lru->node) * nr_node_ids;
 	int err = -ENOMEM;
 
+#ifdef CONFIG_MEMCG_KMEM
+	if (shrinker)
+		lru->shrinker_id = shrinker->id;
+	else
+		lru->shrinker_id = -1;
+#endif
 	memcg_get_cache_ids();
 
 	lru->node = kzalloc(size, GFP_KERNEL);
@@ -594,6 +600,9 @@ void list_lru_destroy(struct list_lru *lru)
 	kfree(lru->node);
 	lru->node = NULL;
 
+#ifdef CONFIG_MEMCG_KMEM
+	lru->shrinker_id = -1;
+#endif
 	memcg_put_cache_ids();
 }
 EXPORT_SYMBOL_GPL(list_lru_destroy);
diff --git a/mm/workingset.c b/mm/workingset.c
index 4e0b2523aae2..cd0b2ae615e4 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -526,7 +526,8 @@ static int __init workingset_init(void)
 	ret = prealloc_shrinker(&workingset_shadow_shrinker);
 	if (ret)
 		goto err;
-	ret = __list_lru_init(&shadow_nodes, true, &shadow_nodes_key);
+	ret = __list_lru_init(&shadow_nodes, true, &shadow_nodes_key,
+			      &workingset_shadow_shrinker);
 	if (ret)
 		goto err_list_lru;
 	register_shrinker_prepared(&workingset_shadow_shrinker);

