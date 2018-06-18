Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDFEC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF864208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Fiap+gt1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF864208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965457AbeFRJrw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:47:52 -0400
Received: from mail-db5eur01on0116.outbound.protection.outlook.com ([104.47.2.116]:45289
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965376AbeFRJrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 05:47:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lkP62MGPWEKJGW2W0yI7qRhP4n2wivCy+SW0Mk0H0KU=;
 b=Fiap+gt1B9qf5D7EZNIwVHmcJH/6pb7vMTeyR4sio5lUbGZLbq1Bos6Et0iNEzgdjoGIrcZ3H5Tjj2I5oiIP8WcVm+OwuDvaQTxMtB4P6eYl7beN8+F52CPXJbLs4RzdvIzXP5y+Wq+ugDAsYbf/SyYtfscHZXkLqoex0yQhwic=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (195.214.232.6) by
 AM5PR0801MB1330.eurprd08.prod.outlook.com (2603:10a6:203:1f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.19; Mon, 18 Jun
 2018 09:47:43 +0000
Subject: [PATCH v7 REBASED 17/17] mm: Clear shrinker bit if there are no
 objects related to memcg
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
        aryabinin@virtuozzo.com
Date:   Mon, 18 Jun 2018 12:47:40 +0300
Message-ID: <152931526012.28457.1427959514045414573.stgit@localhost.localdomain>
In-Reply-To: <152931506756.28457.5620076974981468927.stgit@localhost.localdomain>
References: <152931506756.28457.5620076974981468927.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR05CA0186.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::34) To AM5PR0801MB1330.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23f11f38-320e-4ec1-c09f-08d5d5008ae6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1330;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;3:ASQHCGkUkpP68bUWlBiJd8fW6izOonwNoNv4FaZ/4QQxEqIm5bk06fNz+7TCNsH/3fFwhhImiUqVFtu1seyal/hjLVj+lQtaa7pBMQ0/k+NZCDDHzficst7jyN8Y0PX9F9l4a5e1GlQc496fKl9eDsi9m+vI6alCydl5lutMLPe5U9Sz+3WAElj1CIPvw+pMAhuKbjA4aSgvlNKS72XV14XipebMQgK75wZk65NK+qOUZ7092IDKUoozOu1chZpC;25:QDnHO9Ovzbpiu31/6YlFpPbQ/l94niytJ3CdF86nvUu1TUwYYGiiphTpK6HwW+EvMN8BzFGlG21HS/UASLBDKEWsAdLZRds4iKooRGmN3BlrwMRyBKSVZ7ioxM8cEubeqhFEM8I/YCLi6+BLlvF1hL5dQKU3W5D+SqRu7EwKYs2PYUJCnoDhhGbhzbhi5nvqXsqzWplY6Vhy0J1hvcxolg8AsOcrICRT/ZBcyYlN25jrDQNBG8y1y+Osdj8GznA7MIqWJU6C0vrasxuzGVUYwDjqdwH+8FQsOvZUY4IojcqkvhwDUi4jADwlMctBPuyyxtdmM47r6Gg0LCOVdrfogg==;31:OMhKbzF5ioOrxBBhXSmtfs8uTh4rHKMHJ79Nm2yMFMI8G0HGwBHqA/OE07UuJ0MoCTUNbgBNF5d8/IVikMBIKSY9dmoYlEtxU9xhJh9lDGs015TxgBe9ttEFCsaHZcVSzPM4qCNofF6O++kVNVIIsivTsBgB5jsGQhdqiFFzxf/wPssRU+uCAB7BhE/FiKbjbx/Hyji87YdIj5LHwRXxFnATJ7N2QhvnC9P+ukzA0Cg=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1330:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;20:O8EzPzcxqM0ncljBD74ahDOrgnvZEgJwDGRXaCj2bxFJ+1dqs+bBv+vsatsTSVLng6K/UXlvFTDDuDJsfXbRKiLepsD+ZE1m3sWOJPoIqjG5MfEO7hGRM1cJkVGffWjPkpXy+UGqAZlHcr6N81vuyLHVLl7ncuhHwf5smkWCjaKxy/y6jocLtG/qhped1gTWNkDuJRXCaO4FBWO/7aa2XdHVlJPp8iu607MkaF2cPKgydR9q/pHUSX9hJW/KQkYIhfbeE0izPnNM9U4yXTSScezb2GgwL7xqimPh5VjjMXUNWZ3N2mDYR9bwcAEwf29tgSZdqK1uvBD+8YNwm522BnF+AhkDUVhmORnhZCJsasSz4VQEzNhdTBs4J2Qi/Km8OFg47TRTPQ609bQo9vc/FBdYmSfXQbcpegHZ+s3ogsSpDVQ2G1Aqgd7dTyE56fIdG/V0vF3vSUN/HqCOJ6haj+/8NpvanGzndo4HjESbq83icfLRwihMqD3gSmZhVSFZ;4:N1m35621mTFvmFOIU+moIZGH87a5D0Nuu2Gw6WHa8TQ+UWKgPrWsi68OVG9wD5z+HEIUoip09XSe/Jvzi5mClA7DMaW7l5LmKL7EbbLkfj/q8MP1fra0bX3AukXrJjiIVPn4WbAkT5TYVzbr96Dt7vB7rE2KIC/k8JxjGdq2lLoLyaFFzvLZ5nyaEhbxM9FVwjMTmDC/Wx4z8A2+YuW8zG9/9KKKbkjH/1nqZoRBuNFPCccPZLpjalWaEKx6IzbdagcbLOiOLKsMM9L1jXcrLdBSDZ42d5qb9vOYjUsDtaBcU6W4MruGp09NImRFBtqzHgI0g6ems71fEu6ju6imVWWA0vGQ7+Fmb74yrIGq+1Tkwr1nRT6bcWdL+Me23DTWQPNjFpDkv5E/OCjZljbHukI4hy39OYnwczB+OJBbnaw=
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1330A4969EBFF980B5CB7E51CD710@AM5PR0801MB1330.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(20558992708506)(85827821059158)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM5PR0801MB1330;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1330;
X-Forefront-PRVS: 0707248B64
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(376002)(366004)(39380400002)(346002)(39850400004)(396003)(199004)(189003)(3846002)(6116002)(305945005)(86362001)(50466002)(103116003)(2486003)(97736004)(47776003)(8676002)(81156014)(81166006)(8936002)(478600001)(23676004)(7736002)(230700001)(66066001)(61506002)(76176011)(106356001)(16526019)(186003)(316002)(105586002)(446003)(2906002)(386003)(26005)(956004)(25786009)(39060400002)(55016002)(9686003)(53936002)(7416002)(6636002)(58126008)(6506007)(33896004)(476003)(55236004)(11346002)(486006)(59450400001)(68736007)(5660300001)(7696005)(52116002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1330;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMzA7MjM6MWliTVNTdzZUK2tOd1RuRHhuN0xkWHR1?=
 =?utf-8?B?TFVaZVZ5Vnk4L1RKY1R2KzVmOHVZYzFYZFJRZWc0U05xZlFVRXU5N1M3WllF?=
 =?utf-8?B?RUk3aWRNSEtWY2ZReFlyTTRnVEJJUlRlY2dmREdlTGx6aEFCOGpqdGV6RzUr?=
 =?utf-8?B?TE9KOC9kQnlNTCtobjNGN1BCOVlSVUtJY0laSVUxOU5tVE5yZlhIL3ljNGpK?=
 =?utf-8?B?cGpqOG9ud3l5RkpEUDhPM3BsbUx2dHR3ZVFTTnpyRk1objhQbWRza1VtSy9S?=
 =?utf-8?B?N1F1bkE5RjgrcE5pNDZINTZTaHlRUlZxaFJHRkhzMStBNTF0enZjWFRrOHNv?=
 =?utf-8?B?QkJvbXc0azQxY1NkSjlreWhGdDBXZTlMRjd4MW1XSnlsdlJJTzBkTnlzbzd5?=
 =?utf-8?B?ZFluUnRxcEdmTkFFYnM0WUtpOGpmTjR0dVdGdzF4RlpMK2E5M3FJcUJhRkt4?=
 =?utf-8?B?b0FCcFh5MWRkUnhMZTVEUnEzUloyQUg5eEJpQ2w5Q3I1SytLUmRUQUxoSmxO?=
 =?utf-8?B?RUFaZUV4VUVDVno1RjB3VUU1MXI2QlFLdm0vMmdvbDZwT2RON1hYb1lXK3VN?=
 =?utf-8?B?aGR3NWhiMFU5UlNGVVJKR3NQd2ZFdXVsMDUwSDVONU1vWWdmQWJjK3BzNWpW?=
 =?utf-8?B?aVlsMnUrckZ2VGFIQUpIR0doaEE2R1dhTUR6eVFRSlhjLzZEdWorTTVHUmxS?=
 =?utf-8?B?anczVGZhSXE1N2g0TldSS3BlSmVMNmY1RTJBRlY0RE9VZURzSlpiVThwZ2t3?=
 =?utf-8?B?UjlzTTBKWlc2L09wNytmRHlTcXRSS3RDcmRxeTB2QWxmV0pZbXE0K1RkT0Rp?=
 =?utf-8?B?T01ROTJqZXM5dDJKMEJ3aXBJNnF1cjJpQnZXYi9tN3BNbUt1bkNEWkZLYjhl?=
 =?utf-8?B?WmVwYWt6bW9FMnFkYlZTOFZSUXhmekdncm5ySjRkSjNLeXA3UDhacDdkajhy?=
 =?utf-8?B?MnAwQ0RDUDZJdUswVCtQazRBeHNGRzZmUVMvM3hzSy9uV2FCWjFLckwrbEdU?=
 =?utf-8?B?VUozM2p4WGtzQ2RHQmdOb2FHc2J4Ny8rQXlyWFdTWGwwYURzQ0NoTUUwUXpw?=
 =?utf-8?B?dHkvK0JUUjBsV0pTL2Rvcmo3bkZydzEyTU1uRW90bVJhOVFVTGMxU3dwKzkw?=
 =?utf-8?B?cFI1MDVMamorVXpVQk9rejNCZ0lSbDFIQ01VZVU2S0hKRFRSMkdlV29YM2Fz?=
 =?utf-8?B?aHJBMW9VcENHNG5kTmVyUW9NRUMyMHQ2dXA4ZFRXd1ZtQS9WU1FYQXNieWtQ?=
 =?utf-8?B?WmZvV3gxMGtFdGZ2YXBkODV1RUNGYnJKQi91Wm4vMDVQTjF2eVdCK211bkQv?=
 =?utf-8?B?Vysra0RyZCtYNDNYSGc4Q2IzSU04Vzk1dllJYlFLTU9Jb0kxTFUwSDJPUmty?=
 =?utf-8?B?VDdwcmZ3TFpLek1KWFFrTWdwRlRwNkhjTlRFK2NSazAxYTdTK0VaWFd5eGVN?=
 =?utf-8?B?ZklLUEw0SVBiRlNZOTVYaEpxSUxxSGxwZExQYkZRSlNMQmhiSlVaTG96Vmph?=
 =?utf-8?B?SlcydXJ0WkpSVlQ3WlVhSVlOU1NNaDMvUVMzS0pFTTZFNVZEUmJPY3JoZkdt?=
 =?utf-8?B?MnhQalFEWEllR0tudnl4NDZwVEJOSjJXck03eUxNS3VkRDhqc0k5VEs1b0tw?=
 =?utf-8?B?TmlCWVo5dHppTTJBYXpDRHZoWnRJWkkydDdjTXZVRGYvYXN1dVBqbjUwT3hV?=
 =?utf-8?B?Vm55TlJ4UlNrRzlWWVIyWlZrL2xEdlVYOFVxRkU3SkVKUUw0YU8yQmsxNlZE?=
 =?utf-8?B?cW8rbDhuNnlBU0lLa3hZcFNJblg2RGtZUEtSSGJnRUltZlFBZEx1elBETFE5?=
 =?utf-8?Q?lG6rp7nlXzhv2uP?=
X-Microsoft-Antispam-Message-Info: O0zK64VuXoUntqfM/PObUTAIBdAxJGHYh5bLJVBteCNWFHKfFDxRx+sABiM1IqvZEMkFv4YuEwfyPohST5cn4xKJEUlbEMzqMVrMBI+Z8LZEIV2wGDpTr1Sxq8wS46s4gzRhYOSjARUIgGpQmVFKnMOfvARCtkfZvtPed/ePnxjYtAoOHTkGerscWVfpOQlC
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;6:pLBLmhcBEqtDiDvkLEOepbVOccXnXceeHGvexRL5ZqCUyf4oAeWBL6mtqZfbYDbkeNzuOdJMhnjdBxIP9qBKKx1qAaKjk0HcW3T1jSwHdujdFMSaFaTzdD7+Ix78agzgt+IIAOz8yhGCPYZPHUwkchsQ+ljSPAXxfHHOhi8gAdDRE+sV4uB+mXTUDpKYSBoSJnRH4Q0+UK19QqJ4FjvHSYeTqGa2gQRQ9H282C5Bj36mQ96dH2I2KGq6E870PTvbe0O2tDH8YU6IHv54iC8gZyPEcMdmmFSPTizdYxJKWWtSVLKcj7yL0Dc+zl9T1usZfQwLJDvH8GYHKOZ/gwjdfXU7jr9PfsOP0G9WiAg0ao1yj014ZUXgvL7D/U9Ba5WwYL4Rd5kxhlgRsORLWGQZnCySSPDPVeITqFe0mALDBBG8QY2iUfd5hm7PPn/M+NaNX87dVxsZGO+LbJt2UJ9+xw==;5:hlYHg2/GQhsvqpksxetKLk2z84+XUZsPPff5cTdxlgeruS3uIoh46W37VVu28N45ovguEktwoR/ur7rHoVJEJkFwSn8CXUz0VM8AQQS9OdbeeCk2Sp3eCeUXwgSOWbjAqS4sFW/8O8Yi5XctxHjG8npSLjIoczpeI8HoSNiw6lY=;24:exnusjROL6Gs/t+59kpdlObYnKyqZA7kR/l0HLdxlpJptQi02WSrZ1F4PQIvfwRRM6wWX3fLYd8uVmDVgTqG/4fM34TzJdwN9PVY5K1gqPQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;7:B3/Vim2SG2cCYHdSEUEbXmmzsoSUzUuwUFL8rju3CbmDcmFxpv21VAjwQRGJOaSWP7gD+gBXLt26b4CBB62tKRjrjvj3vdMDUQWmrcEkCS/u2qZBNgrqufxXJeksgdN2tP6nCBqjGNX0+SSqO22WCdlmnwGl8j8pC6kt6DpbI5PJqo4lmCY9ZVirjIbx1yrcsNmr4mJiFa4CxQTEQR9tS+oSngPEq9v2diVxlS+z5yXBBnSi2/az4aY8yLSWbZhU;20:FISOH2z15SiuYVlUlOtu3PzGT3FLaoBL4S1VBEmv8nVi0HLHCd6gNwAy5Rt96GIe3v9JEeK+r4Iuc7+ttDXHyL4Tr0jFpexh/vE258n+GrW9zdndgGu5kwEyIx1fm5o7LeZeyjc9pTy5IWICnr4TMpw3Zy0ylMUjbtKql0C7CYU=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2018 09:47:43.3949 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23f11f38-320e-4ec1-c09f-08d5d5008ae6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1330
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid further unneed calls of do_shrink_slab()
for shrinkers, which already do not have any charged
objects in a memcg, their bits have to be cleared.

This patch introduces a lockless mechanism to do that
without races without parallel list lru add. After
do_shrink_slab() returns SHRINK_EMPTY the first time,
we clear the bit and call it once again. Then we restore
the bit, if the new return value is different.

Note, that single smp_mb__after_atomic() in shrink_slab_memcg()
covers two situations:

1)list_lru_add()     shrink_slab_memcg
    list_add_tail()    for_each_set_bit() <--- read bit
                         do_shrink_slab() <--- missed list update (no barrier)
    <MB>                 <MB>
    set_bit()            do_shrink_slab() <--- seen list update

This situation, when the first do_shrink_slab() sees set bit,
but it doesn't see list update (i.e., race with the first element
queueing), is rare. So we don't add <MB> before the first call
of do_shrink_slab() instead of this to do not slow down generic
case. Also, it's need the second call as seen in below in (2).

2)list_lru_add()      shrink_slab_memcg()
    list_add_tail()     ...
    set_bit()           ...
  ...                   for_each_set_bit()
  do_shrink_slab()        do_shrink_slab()
    clear_bit()           ...
  ...                     ...
  list_lru_add()          ...
    list_add_tail()       clear_bit()
    <MB>                  <MB>
    set_bit()             do_shrink_slab()

The barriers guarantees, the second do_shrink_slab()
in the right side task sees list update if really
cleared the bit. This case is drawn in the code comment.

[Results/performance of the patchset]

After the whole patchset applied the below test shows signify
increase of performance:

$echo 1 > /sys/fs/cgroup/memory/memory.use_hierarchy
$mkdir /sys/fs/cgroup/memory/ct
$echo 4000M > /sys/fs/cgroup/memory/ct/memory.kmem.limit_in_bytes
    $for i in `seq 0 4000`; do mkdir /sys/fs/cgroup/memory/ct/$i;
			    echo $$ > /sys/fs/cgroup/memory/ct/$i/cgroup.procs;
			    mkdir -p s/$i; mount -t tmpfs $i s/$i;
			    touch s/$i/file; done

Then, 5 sequential calls of drop caches:
$time echo 3 > /proc/sys/vm/drop_caches

1)Before:
0.00user 13.78system 0:13.78elapsed 99%CPU
0.00user 5.59system 0:05.60elapsed 99%CPU
0.00user 5.48system 0:05.48elapsed 99%CPU
0.00user 8.35system 0:08.35elapsed 99%CPU
0.00user 8.34system 0:08.35elapsed 99%CPU

2)After
0.00user 1.10system 0:01.10elapsed 99%CPU
0.00user 0.00system 0:00.01elapsed 64%CPU
0.00user 0.01system 0:00.01elapsed 82%CPU
0.00user 0.00system 0:00.01elapsed 64%CPU
0.00user 0.01system 0:00.01elapsed 82%CPU

The results show the performance increases at least in 548 times.

Shakeel Butt tested this patchset with fork-bomb on his configuration:

 > I created 255 memcgs, 255 ext4 mounts and made each memcg create a
 > file containing few KiBs on corresponding mount. Then in a separate
 > memcg of 200 MiB limit ran a fork-bomb.
 >
 > I ran the "perf record -ag -- sleep 60" and below are the results:
 >
 > Without the patch series:
 > Samples: 4M of event 'cycles', Event count (approx.): 3279403076005
 > +  36.40%            fb.sh  [kernel.kallsyms]    [k] shrink_slab
 > +  18.97%            fb.sh  [kernel.kallsyms]    [k] list_lru_count_one
 > +   6.75%            fb.sh  [kernel.kallsyms]    [k] super_cache_count
 > +   0.49%            fb.sh  [kernel.kallsyms]    [k] down_read_trylock
 > +   0.44%            fb.sh  [kernel.kallsyms]    [k] mem_cgroup_iter
 > +   0.27%            fb.sh  [kernel.kallsyms]    [k] up_read
 > +   0.21%            fb.sh  [kernel.kallsyms]    [k] osq_lock
 > +   0.13%            fb.sh  [kernel.kallsyms]    [k] shmem_unused_huge_count
 > +   0.08%            fb.sh  [kernel.kallsyms]    [k] shrink_node_memcg
 > +   0.08%            fb.sh  [kernel.kallsyms]    [k] shrink_node
 >
 > With the patch series:
 > Samples: 4M of event 'cycles', Event count (approx.): 2756866824946
 > +  47.49%            fb.sh  [kernel.kallsyms]    [k] down_read_trylock
 > +  30.72%            fb.sh  [kernel.kallsyms]    [k] up_read
 > +   9.51%            fb.sh  [kernel.kallsyms]    [k] mem_cgroup_iter
 > +   1.69%            fb.sh  [kernel.kallsyms]    [k] shrink_node_memcg
 > +   1.35%            fb.sh  [kernel.kallsyms]    [k] mem_cgroup_protected
 > +   1.05%            fb.sh  [kernel.kallsyms]    [k] queued_spin_lock_slowpath
 > +   0.85%            fb.sh  [kernel.kallsyms]    [k] _raw_spin_lock
 > +   0.78%            fb.sh  [kernel.kallsyms]    [k] lruvec_lru_size
 > +   0.57%            fb.sh  [kernel.kallsyms]    [k] shrink_node
 > +   0.54%            fb.sh  [kernel.kallsyms]    [k] queue_work_on
 > +   0.46%            fb.sh  [kernel.kallsyms]    [k] shrink_slab_memcg

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Tested-by: Shakeel Butt <shakeelb@google.com>
---
 include/linux/memcontrol.h |    2 ++
 mm/vmscan.c                |   25 +++++++++++++++++++++++--
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index f2292ea7892d..d41c9350e6be 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1257,6 +1257,8 @@ static inline void memcg_set_shrinker_bit(struct mem_cgroup *memcg,
 
 		rcu_read_lock();
 		map = rcu_dereference(memcg->nodeinfo[nid]->shrinker_map);
+		/* Pairs with smp mb in shrink_slab() */
+		smp_mb__before_atomic();
 		set_bit(shrinker_id, map->map);
 		rcu_read_unlock();
 	}
diff --git a/mm/vmscan.c b/mm/vmscan.c
index d24a3e16ade2..ef5f53411a57 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -597,8 +597,29 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 			continue;
 
 		ret = do_shrink_slab(&sc, shrinker, priority);
-		if (ret == SHRINK_EMPTY)
-			ret = 0;
+		if (ret == SHRINK_EMPTY) {
+			clear_bit(i, map->map);
+			/*
+			 * After the shrinker reported that it had no objects to free,
+			 * but before we cleared the corresponding bit in the memcg
+			 * shrinker map, a new object might have been added. To make
+			 * sure, we have the bit set in this case, we invoke the
+			 * shrinker one more time and re-set the bit if it reports that
+			 * it is not empty anymore. The memory barrier here pairs with
+			 * the barrier in memcg_set_shrinker_bit():
+			 *
+			 * list_lru_add()     shrink_slab_memcg()
+			 *   list_add_tail()    clear_bit()
+			 *   <MB>               <MB>
+			 *   set_bit()          do_shrink_slab()
+			 */
+			smp_mb__after_atomic();
+			ret = do_shrink_slab(&sc, shrinker, priority);
+			if (ret == SHRINK_EMPTY)
+				ret = 0;
+			else
+				memcg_set_shrinker_bit(memcg, nid, i);
+		}
 		freed += ret;
 
 		if (rwsem_is_contended(&shrinker_rwsem)) {

