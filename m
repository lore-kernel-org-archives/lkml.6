Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626C3C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 088A921A89
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="K0psPjUE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 088A921A89
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933869AbeGCPLA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:11:00 -0400
Received: from mail-eopbgr10099.outbound.protection.outlook.com ([40.107.1.99]:42005
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932458AbeGCPK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:10:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lL4ik/QDNBKIKTSnB6FxD97tPjOAWFP9j8Z5Acm+6aY=;
 b=K0psPjUEIeyq1YyxJbwSvbMFrFs9gqV6nm7zBybjEFwbloYL72AHFk/kfmO2vBCswJFyjv8nXOc5/pyTxdAZEueomzzDqljFJtDA1f2Ww1vA53rvc2ITk1MODKa/cj+9yj3ibdPiZpIEUB5/UzduxyuvknyMdLyn7nrVJM0quj0=
Received: from localhost.localdomain (185.231.240.5) by
 HE1PR0801MB1339.eurprd08.prod.outlook.com (2603:10a6:3:3a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.23; Tue, 3 Jul 2018 15:10:48 +0000
Subject: [PATCH v8 12/17] mm: Export mem_cgroup_is_root()
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
Date:   Tue, 03 Jul 2018 18:10:43 +0300
Message-ID: <153063064347.1818.1987011484100392706.stgit@localhost.localdomain>
In-Reply-To: <153063036670.1818.16010062622751502.stgit@localhost.localdomain>
References: <153063036670.1818.16010062622751502.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: VI1PR0501CA0048.eurprd05.prod.outlook.com
 (2603:10a6:800:60::34) To HE1PR0801MB1339.eurprd08.prod.outlook.com
 (2603:10a6:3:3a::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6c7d112-8c6b-4507-e1d6-08d5e0f72a2e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1339;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;3:uUXE13LFVwZ3vI0ZuviJqjrGI2FVRanYMsjIrooqhOrv8JM1b3tdhr9mW6wbg4aOmRWaKV1VjVoRlUAw9F7rFidMhMqSt5N5pHA8eZCuFKR0siDjao1qyBQbYIYsGW6yfqoBlNa0+jn8MUx70jYNnXYoiN01Y8qJmT0hZoQ0A6B0YrK9GRbTWCGYTEKUwB0sIaAB4if6ihehliQaBQxLnOndGaGiT/4yEW3RjXpWA+oGvLgj3rypihAllYmHcF1z;25:iZSls+jGPaqW1ZeghqPfDIAt5IYfN0sVO2HhgqUKvTOUHSpSxgcCfNwAFEayTVdqYO8MSUogMc1Q6tdYqPX3TJjX74hxQBH8AJ000QqthO9DZOs9jtJEF7GAT5hlnYIzF/BK0EdZf6kr2s18LJfvIWGBM9m/P91wRWvPPGYaNJkDWNvVOLVZaGI4Zz8e/vEK9nsMlGkPeNK7NywlYDlzXWDFsVzqtZuz9ayIvHnPOvpUrmlHtscm24D6mXpTz6T4OuK/puRian3idtDTWtzAyjs01/BR7P1QU0WIr3IE8CgwowLQs7GU5D0LVcPeLZyCkiNsdze8IgyVySFW8ENcfQ==;31:Qvkt+q46tHlX2FpINYwP6iZ7F1BNCln33Y+Wn0Xap0abiCEdtHDDbXbETYsIPeFZzLe8k/MHNAdt/c6/jlI1LfzjH5sHx4kq+FadlHCDPXvXshXxjmghWVlLqyfAxNW9tIzvHRK+LDajfm4qlpXTq2W5c0dYcioTGn3MByIKfsd8w6Wwdq3XOcKWsRkECo5sCBPhVH/KP7REIFTAtvV0oOewu0hMCJYOIlMva8hShH0=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1339:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;20:Le1rfI0oKxHKPoIZAO0lue7uX0t+fBSA8k99bnUIueT3ATur4LBpXkwfe1b+Mz/6N56J0R8ZVaVHB/xdOrav4W+O/AkAp/kUqDcYoNXMYkouAbZpuu/L6/3wreunp93sAkl030zTZMDkLBKWtQW1Ki/v5YxyfWDxIpLkVPb1weB2AcA3k72RJ/UzzSqg4RJjMwk6/REV4nDWGmtvfhRHZl0PRpXOATLNhvDlXL0I9Y2xpjNwsSczWS2fZQ/yr23gVTXyWuDGSWPuSbbx/zy7QyYgtohyRnla5bkKeXQ5WmBPpkaUctUzeTz0Ea9azfPzcLPI22JLrN4CH+plHNcI1bifpm3oC6FeYhxJ1nxHEkFUUdXYdMXDwh0dcoVxZfbvoN/Y+D8TqAXy8vpGF95u87K0o3baqAWW1hF7PpVKsQv6JvJZb2YXciYo9rYfHYRa+wRAhfiNivnpjCygQQePq+jsptyWq80NS/ThKcN+5dCWGtKIw2X5+4RlAqciR94z;4:JCEJtvHu0O8jSa7dx3af5Hm8RNQAvalCdgOxsBSuPQbIBgb9lzigDX4be4gnKf9ktwRfLcbiC/vx7ROPfX2uw4MmUiQzPhTwtoalReo7tbiZWjBwHdZIWew6ZC5B4qKDWPw089qX6zNu8v3UZ56M3XfB39z3lh2oaxMHzyZ4t6IVHdZ0CldutmZHHMTlIf+loM+k0QsKb/pLBORgMtWwFSQ5uYU5zTASunSTfa4GRG2ku3zNRQu3yZJ+0c3g5u6xf4B1ntHLY7sQp7nsoDQrCcKlwwLp+NkPAyDAepfokyWOOnsLofm00u1CYhPoI2WiJq4L5iflK+e2siVxikXn71NK/w01vl0RytoiMXXlIup1v+wKmzdbc8pNWwGlhxi6
X-Microsoft-Antispam-PRVS: <HE1PR0801MB13394AD5148D7AF8A50AEC02CD420@HE1PR0801MB1339.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB1339;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1339;
X-Forefront-PRVS: 0722981D2A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(376002)(396003)(346002)(366004)(136003)(39850400004)(199004)(189003)(58126008)(8936002)(6666003)(53936002)(956004)(446003)(6116002)(3846002)(39060400002)(76176011)(11346002)(476003)(316002)(103116003)(47776003)(486006)(230700001)(50466002)(97736004)(5660300001)(105586002)(23676004)(25786009)(52116002)(106356001)(7696005)(7416002)(2486003)(186003)(26005)(66066001)(9686003)(33896004)(478600001)(2906002)(81166006)(68736007)(81156014)(386003)(6506007)(8676002)(61506002)(14444005)(55016002)(16526019)(305945005)(86362001)(7736002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1339;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzk7MjM6blFpTTBOYmlrR1hhdDFxd3N3YW9JaXpZ?=
 =?utf-8?B?ZEtuazd0dFMwWXVSYW5QZ0lzTzdIWml0MXRZUVp5Sy9UQkpJR1RNRVU1Z01j?=
 =?utf-8?B?SVJ1Nk1SMG9PdkJsK1RmQXVJSCtzK0JWMVBOeUYxZm9CWHFNTFUyRXM2cnN2?=
 =?utf-8?B?eGg3VXhubW5RMUhLN2MyY0oyRWJXNU5NL3dJdTdYZmExVktOSmduZ0xZUnBL?=
 =?utf-8?B?d3VGMmFFOGhxSDVEY2RhWXpHWnZzcE95U05iWlNITjIzV3ZSU2I4Q1BSNjBZ?=
 =?utf-8?B?WWVrdE1nQ1BlQysyTndSbEhEMEg5U3dmdUYxbi9HbGhxSWFSVU5DUC8xMEYy?=
 =?utf-8?B?TzJrTSt2SWYyWFE3bjZDcSt6cHpmbWdqTm5sVXBsU1I1cFVJb2I0MjhYK2dS?=
 =?utf-8?B?WUlMYVcvUTNxSXpJWUMxTkVnNGtXRXQ4Tk5zb0VNVHl1b1FLY0QxSU44aHRx?=
 =?utf-8?B?eDAvYmdaczhua0x6aGNhZm1pSWFzR3dXa2pTVHRtT2dXWUNQa0ROSDVMNHAz?=
 =?utf-8?B?V0hGNzNoMktxMFMwaTFJK0FhZHg2Rm5rQVI5NXV1ajd4eVJZQ1VQYS9WWkVR?=
 =?utf-8?B?YlhUbEZhRDZsQUVIakpsWHNwTGZ0aXR4ZkRTT21TVmE0VEFXeEEvbEFQY1dU?=
 =?utf-8?B?ejZMNHVNZlJYMGN1RWplYnFBSUZtdHV6VlBiRU5VbWsvUWdZZXBCMjhTZXF1?=
 =?utf-8?B?K0wxVTlaR0duKzRPVUpxOFZRZWxtMTRySWNTQ0kxdnV2dUYxdmU4SS9kR0lt?=
 =?utf-8?B?SHRQdUFEYUNQdC8zL3BZK1Q4YTYyN1I1eFc1U3R5OVVURGovN0h2aWhnOWZF?=
 =?utf-8?B?aEhaU3VubnpjaGdxbFdkWlJuUk5RNk5LTE9SenF4ZG0zY2VZWWxVelFiZXM2?=
 =?utf-8?B?NjhTZ3dJL1JQVGRydE9xbDU1WDJNL01yU0l0Z0lncWdhUzdERXF6NEd2anpG?=
 =?utf-8?B?NEd0MXZieW1vNEwwbTdCYmduRFdKOWdzNkcrNVN2VTJQSVR0VFE2dDgyRVo3?=
 =?utf-8?B?ZHBXbG1FQjhtOTQ5RUwyeDhYQjkxM3VJMGovUzk1blpBV3FyMENEQWxWMGtC?=
 =?utf-8?B?VEFEOXV2Q2k2V2gyL0dzcUNudlFyUVF1dkt3SXhJb2l1S0prWmlyMGdSaW5v?=
 =?utf-8?B?c2lQTGsrTmx1UzF1U0JSbWxnM3pwMlRQVjdCZnFlRUx2NXJ5eWpLbkw1YWpq?=
 =?utf-8?B?MXFzRzdoL3l0emhlb1lJM09lZzAxYS9FQ2pQMFFzMk45ZmhPaDY0bWpBTjls?=
 =?utf-8?B?VFJCc0VGR0czM0dwV2FWOEcyc1hMWDhqQzA5bmZHVW1yblJGTjhuTzhnSFhZ?=
 =?utf-8?B?YlMwdU9zMVhOd3N3MEFYNmFlNDY1dTlmUlp4eGRNVVFyTFE4NU0rV2E1VmM2?=
 =?utf-8?B?V01pMS9YU3pCUTdnM0NPaURIRWkwUGJrWHhIOGVVdzgwM1VtbkRZWGx6OExU?=
 =?utf-8?B?S0dTNXB3RUlTRkR5L3BzY2pnUkRCRWR6L3htN2dpV1NsSzFXaWFXZTB2eC8y?=
 =?utf-8?B?bmZnM0d2Wi9DeEZkYXM0VlZ0YkFDTGpyWTF2dE5FN3VEUU9YWGhiK0xmMWNh?=
 =?utf-8?B?dVR2SDJhQUxWdzRjSFZ1R21mbzNRemxlME9RTmlUcjJwVkRRbDFORHB5RjVp?=
 =?utf-8?B?RGJ4c0lRVDlzK0l4RVA0SldpSVVuV3ZFY0Y5QmFsRUdwUGczQ0dEd3Y2dEhw?=
 =?utf-8?B?SXFldHUzZEVjY1JTbXJDbHFqTm1RT0o1Uks0d3NjOGFvU3JJbHN6czZUby82?=
 =?utf-8?B?VnRPVGt5UmlLQmJKT01EbFdnPT0=?=
X-Microsoft-Antispam-Message-Info: S9UixPfGmp5biZvhXgsSKZfhi+cUZ6Enn1glIHaFNairPtphRFCyY9QbCUvox6g1yoCCg7jfT5GRAZCjUoQfUK2+v8H7YO8c4gdz6MAffPnc4IAjmXawaJn9SXZen6Fdiz7V7Ycki2SzaOwhYGJNUIS6sShlNYWSXDa5NynZ+pfzE+hmdKYrGuwUyyBhfkzIkhzbzR2Y8wrYNOBkK3ukB6a+KobWZ5HbSx2bHOYQva2IVpkgH1a0KesmwqTkkv78yD+0SzLL5hnsbXiQ6ajbLhKR98tHLvuuhnJHVW/wGFF/M2TUD7mFrFeOPLFTRhUYJ+3J/W9gAP180K+xwehdfSYvOMpKFghR4PnHMyQyJ2o=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;6:gbk4D7WDc2EErk3hKp8hbqQSVPn1P7T1vI5L9XWBvS7ZXwzKI4275uj8riG0lZiMLHOD4qUakOwjnQcx21cOMsH7ch+C/cBzJcNBYwYtV2eQ68E+Hg3n+25/tV/IXhYnfgDIBQhtY8j2wnDYfOnhhqW9kgnZYkJ+NSfXKhT25YMNWLkei8+X0eJeO26ZY/+2ywSeCbfGlotZ4I4l6y+PowAFUYsG7KxfAtTdHXb0/zyyeCGuVYUnpSg7Go/8pCqycUwpgJ9NXqC3qrNdSEpov8bQjGNRiOB17/RfVQpv59q3Rfzcu0s3xCRxA/FoRYbkn20b2ZU9+FrzgCWjsVmR0NNAGZmLGwj4AHEfUqMFPbgy7X53PZvjMBqtDc6KY1xnAlTXmexoCIuIzg0Wlb9YbteR8EFszJnENuliRTJT/2GJ5I0IEkBMGFDv7vbQrCsjXaCHBsr7W59DpwJr17yUnQ==;5:PQKz4W6NhsRnAAV6YrqhocHBkFZnotxABEHpuCkUbRUsbJhE3sAgIZkd+OzTW5lRISkH/Byvv5tLox2WIYqP5vYD0LmNFGMihsnLwcx01d/dRm3bygJiaCP0wQK9s8VRg9NmeDUA6ttG+SLgHpjSGVNMNZhAl7ppHToKlWbqmgc=;24:HXXwIFo0zdRiPGInXOOdzNNyqeXRQmYAU8WNJUAocVzehL85muIkMzkGpRl48pAJVPqSeaHIUw+Gwi77N7hMh8njhqMYK1shd6Z+v38GTz8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;7:Gd/+hmYRJkkmlfNjqPV+6wuKT4Tn+J2LP1hrisppYMCu7S9honIMBYYiS74u/kiKglMYgc3y6ByfRSwQIPFVpX9fsjIAe1vk12VdF5+reqTceKsRLF4sdBMg+RxD7dOwV2OujxzIjUM5O969mnRkkYJQ5hj0jKuP9gB4rYw5echdh95p+hzIhUjJa0ek47THbi9+/TS+/op5tm+Ky0S0kdomyZac26MxzLhbvTSdIK7AQ/x0n39wNu6QKDWX7KBf;20:iTDtQ7dg/VYX5ItbFOfIL3Q6v9OyhcVx7xA/peUdLxhqnipOu7f/SRqMdMfdsS1vL7JkIvNNGkoq0D8zCG7vAsHn5smsQcJjKPwvQq6i4c8sHr+ciIFTno37KHU/QllD5JibrxdBp5CWBLAk1n/2YQgY+WU1TxqUF/WmnH13rDo=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 15:10:48.3769 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6c7d112-8c6b-4507-e1d6-08d5e0f72a2e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1339
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will be used in next patch.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Tested-by: Shakeel Butt <shakeelb@google.com>
---
 include/linux/memcontrol.h |   10 ++++++++++
 mm/memcontrol.c            |    5 -----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index d8c38eafa251..2c52b4313117 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -327,6 +327,11 @@ struct mem_cgroup {
 
 extern struct mem_cgroup *root_mem_cgroup;
 
+static inline bool mem_cgroup_is_root(struct mem_cgroup *memcg)
+{
+	return (memcg == root_mem_cgroup);
+}
+
 static inline bool mem_cgroup_disabled(void)
 {
 	return !cgroup_subsys_enabled(memory_cgrp_subsys);
@@ -800,6 +805,11 @@ void mem_cgroup_split_huge_fixup(struct page *head);
 
 struct mem_cgroup;
 
+static inline bool mem_cgroup_is_root(struct mem_cgroup *memcg)
+{
+	return true;
+}
+
 static inline bool mem_cgroup_disabled(void)
 {
 	return true;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 510c435a15dd..1a6c61814dbc 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -261,11 +261,6 @@ struct cgroup_subsys_state *vmpressure_to_css(struct vmpressure *vmpr)
 	return &container_of(vmpr, struct mem_cgroup, vmpressure)->css;
 }
 
-static inline bool mem_cgroup_is_root(struct mem_cgroup *memcg)
-{
-	return (memcg == root_mem_cgroup);
-}
-
 #ifdef CONFIG_MEMCG_KMEM
 /*
  * This will be the memcg's index in each cache's ->memcg_params.memcg_caches.

