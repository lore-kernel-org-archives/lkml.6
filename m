Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZpeTOfulSUDhB1T1EaYLwxGPSC3C9o8Q1je3SHeOkkEZuILiq67Rz/NEks/mS5A4tCUZV/b
ARC-Seal: i=1; a=rsa-sha256; t=1525867125; cv=none;
        d=google.com; s=arc-20160816;
        b=Z+FItPNN7xMc8vuN0gbAXN0xDgL4Ypo+OtMmECE9GWb/a7WcRig1bAOFFUgnx9Z1TJ
         4X2f/kdkPK7RAHLaUXj092C5SH4KblSbee8ruTs1AFKybBwYY2AtN/Tj0ypRTBb+A3D3
         elnOclBJLn54M0POK+u/Dfr05zlFW1LFfs/cSnnSwYUhFeFwX8Ee+fJfdmF1RoysqDJv
         +s5kAS2Nhyy7eMsbKL1qPjOfJO/8Y5InTvGfVCG+RHFhiLpYOhpvdzZifLQQ/4wXb7SA
         zdKM2LdEvYpWEwKlncCG66GHExMbq2busnEDZo18Zb9+l+n2XQOGiReTof+dz/WX0j1p
         BHKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=SL/J3kZJd4MvhsdvB08PgzAZzS2cv/GCkCVunhyRVU8=;
        b=YcRpYqBg1JbIV5oLD0WUTC7olBE+R//McKqM209d48bKVsUOIiZYg/dUTY4H4xy30h
         McfUfQMULCnrMtnitzCzsCKiCrEDX0lkmAwQzw4Biicu0NwFZqTJAGVCxER0C2/lnWec
         x5wh3jYR1XrYcPWpZ9wZxmcE+Hmhg5mhEOZlUJjzMfGz2Ya5kZcek1HJcPL8CLWXzYCE
         chnxfXYFQaWKQU5Pl4BEf4YdYjVCaF+NwbvTLQfrK+ugDUPEz5Ie3EKxJMRONweZ7KUJ
         rsOcL51SIs8W7Lcro9JJUEqyuIS89VVR8TDAER2d/BlzBMa+RsyhJjBZTpLu+bGfAe1a
         QgkQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=cgh9KCYP;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.125 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=cgh9KCYP;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.125 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v4 11/13] mm: Iterate only over charged shrinkers during
 memcg shrink_slab()
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
Date: Wed, 09 May 2018 14:58:38 +0300
Message-ID: <152586711800.3048.17462409401469930692.stgit@localhost.localdomain>
In-Reply-To: <152586686544.3048.15776787801312398314.stgit@localhost.localdomain>
References: <152586686544.3048.15776787801312398314.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1P190CA0042.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::31)
 To HE1PR0801MB1337.eurprd08.prod.outlook.com (2603:10a6:3:39::27)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1337;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;3:ZfGFDYCJZafuzXS+OIbaHn6KXUbl0BnZkDBsMjBHeR5OtggnGFZLXEkeRycEmvlFADv+Dp2DVQ3xIkN1QK6AZ8X952KHsNUCtWlyiGyoiMoVZ7O7I+zQ7kC45Ifc0bt4FswWloqsEawKDHUw3af9nWgKEWRZgzH+WoM0p1L6nReHn3XjK01BclUmux6VyzJU889gbkqMtZEOlE8gm+LzhFgi0dkv2MQI1JsLkAdExGU3+3RGXf6z1bdDnFFETK+e;25:qTqFvXOcWLT0XPIo/YljWvLhco848zXe0uE7p2Y4GkMjJwD/6s2ksaSM2xp8VMbeNWYUZHnJNvOoHOCuk3F7pZYW1VspuxlKzfLyRpl5BRnaXnX1Ph3DayK8yDM2wr8xQ5o+82ng0D5g6OgjAp+FDqOdNG37WA0xLCppxi9IB22sn6D3CwjGVX5adi94OlCkViJwIWEPfH/kyLINiZEb/ATRL/KLgawFxHCjZq/D+K7OmLjsKLO7nvSDIhDrwi1uf0cRqPt/rIJjG5LU8pca0DSpBdjY058gBK2fiG1ygyrNNUKI+Jb62MGkcPfeA09L78otPqiQQvieiKIsyTFr0A==;31:eP/gUkSYEEyy8N7FCg4Dm8L3yyez60DATgzsWUEjrXIh3XlFDRPSTumDUOiffGUqNT8J7ApwBdxZD+LcYrX247JZyejDUHIAklKdshetEIzkJ7Cdev5Z6Y9QfUPfq4hynyxFE/j5iTdJhJ3kyb0HUlzTzAg8PGbiLLIhf0361vOoJIZTC2YUxnpUGpDHMSaFsPJttWZUaCnvrLBr70WxTNcK25SbXANaHqOtE3Oso8o=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1337:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;20:7CT3/0pzuVo8R28xqqU1qa0q9bpcvQJarh9SDOXd81M/upY3XcnL53Y3P1DnWSOr2wzw3+EvQfu4irqKY7Bl1nyqFyUzN+mlnljgD+qtWur+QkuO96H/eEFRiX5ZUTbAB7w5PNcg0PLltCtiQDOfo1fyG+8GIoXziZAwli9QAudu0iGQOcjbSpXPqvQyjMCxQxK2LNAHX1ObC40tJsbfE3Dn1PVEEAteC4zz2v59pI7+Tneh9lg5Na2sD6kkivvjoglDol2oD7i6bgDuBsHHhTcGlbI2+LmWeIAI4JAlGnPI9x6d7qiigFoCdJv5LxE31HVsGOxjUzxY0N72Gm29NYOJPVOE+PR4xZchBBts0CPKtPGxTUf/U3rr3z+fk5HsTVRbASlpParAo61QEPxkarbRgCF7yGtjOEvhtSpvY8nOEtvlvJBhOE8iM8cGa/BzvHlX/0NVLHPBnUm1xjUBw56VmCyVHsd3Xxj8OCyh6sEl00/qLseT+kNe2p3hPxOz;4:jb0ifeGzFBuCLC2xIk49RG64cJMH15o8+cksNIPSkhAh3XV41jIiDhBLPzs3HOc4U9lTDRm78mxkyYPGdIgp0G7oOjxjgzoT2K9quQRVxhqQ5tJMsAsl/NDJipV6Xo7SlVRFZ+Yts2tTyK4TUj6MVfBs/4v9toaR+crpsdafu+KF17bSnfslTtU9bmKwm6LTuP5iV+dYcp6zik678L8QR99cdhf39sJAbgFxBpNzedgUWsRDgC66NrDknV6jbQq3aCT2hVULOkb3Xzt1sxZS2A==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB13374C34D3D90FB1AEE99153CD990@HE1PR0801MB1337.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:HE1PR0801MB1337;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1337;
X-Forefront-PRVS: 0667289FF8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(376002)(366004)(39850400004)(346002)(396003)(39380400002)(199004)(189003)(86362001)(486006)(575784001)(316002)(76176011)(446003)(3846002)(7416002)(2486003)(2906002)(52116002)(23676004)(478600001)(26005)(66066001)(6116002)(7696005)(105586002)(106356001)(7736002)(59450400001)(68736007)(6506007)(386003)(8676002)(25786009)(55236004)(6636002)(39060400002)(47776003)(305945005)(33896004)(61506002)(5660300001)(956004)(81166006)(97736004)(230700001)(53936002)(55016002)(476003)(81156014)(8936002)(58126008)(9686003)(11346002)(186003)(16526019)(103116003)(50466002)(921003)(1121003)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1337;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzc7MjM6ZEVxWm41Z2dWOFFUb0gwM2ZrcXFKbXc2?=
 =?utf-8?B?WTRYalVGb3BKd2Z2NkNjY2VqVStZQXVVekNlU3VpazBvTm1vVlVSV01CclBY?=
 =?utf-8?B?RllyTzJkQjBkQUZ3OHpaWWZERDNFc0tJRk43bm0zTGhqWVViZFJSMlcxR1RV?=
 =?utf-8?B?TFd2RmMrc1VZRTRMQnBycW9paEppUGx3d0tJWUV6c3pneFIyOWp1ZVNkdWZu?=
 =?utf-8?B?eFFLMVp0aWs2SnhvQk56MVdiemU0MkdmejBvMlcvSkV4YWNYR3crQ2lUNzh2?=
 =?utf-8?B?SHMxaGpUNzVVaEo2Qm50dG8zKzRsek1ONFFUdUFIUUNGdDIzVFg4Q29TbWN6?=
 =?utf-8?B?TFMvRkFPbmQwdjE3TTBrdGN4eHV2dWVwZGNMQXRUZkIvNkFoc0szTnQyVUFQ?=
 =?utf-8?B?T1JBQnNYUlQ2YXZCWnhYRzAzd0M4aEYweVV5blc0VU9rNEJpUW5KcktCcnNF?=
 =?utf-8?B?QXlLRFdqTkloU0oyNkJVVkN2QUQ1cTZHYVUyeTdmS1JSUU5kZUx6M01oSk5M?=
 =?utf-8?B?NzhNOFVUTWNDZ0J3NW9sWnljamNXTzdQeXI1RmlTLys3bWlnaUxWMVMrSS93?=
 =?utf-8?B?N1BTUEJpTUdBRkNoS0crWTIrWTFwaWhidmp3bGU4bDQySitJOTFDZHF3V2JN?=
 =?utf-8?B?R3RzTWUwZWxib0NDbTVvdy9mRDQwT1U1M1hYbXRJWFZhRFJZWnhFeFBZaXNi?=
 =?utf-8?B?SGQ4aXZVcHhQQmZoNTZkSXM0My8zQk4xbG5YdmRWU3h4aXV6aWxTd2NsQmhZ?=
 =?utf-8?B?Yklqc2Fhc1ZIY3ozZzFyM2ZLeUxmN3pIcUE1VnBKODFIMFNJT1FOSlQvZmRv?=
 =?utf-8?B?eXhraWt2SzUrS3FoTzIvWkIwZ0VvN1FER3h3Q3JUUHpPdGZ5RGMwaVpXYnJu?=
 =?utf-8?B?NWc3ZnUyVnA0S2gvM0liMXVKV3FIOVFqNHJReWJnQUVnNHZRMC9pMXF4MlRj?=
 =?utf-8?B?TmMyZUxjZyszZ216c1pSK1hhcUY4c21JZUJxNWxXNis4R0JWczBuNWJ5dFJq?=
 =?utf-8?B?eGZ1QzIxWk8vRjVuT1g2Zll0b3grVzVlKzNTaWlpaGJvNUVhRCtJVW5aREh3?=
 =?utf-8?B?dkVFMDhWREk3SndrWDlCUERVWHphbDV4bGE1VFJhZldTWEE3aUZrd2FJc2FW?=
 =?utf-8?B?MS9xN3JYSmFBZFRPcVZUcXJGZ1VTVlNsN3prN2RTVkZsNVZzSFVLb0RWenlP?=
 =?utf-8?B?VVcvR29GV0djb29RVmFvejVqTEJBcVo3OGZZWmE2Sk1uNkVxQVVQZ3N1RGts?=
 =?utf-8?B?b2wyOFdsMnFObzVDYm5vbG9vNjBna0J5TGNJdjRVM0FJZHkwVm5kS25TZVdB?=
 =?utf-8?B?R1BYd292VnFScGF2V0MremgrN1poSHhxNGVIZWRoNjdhWitqNEtod0FaWlJI?=
 =?utf-8?B?d0VDTXJIZW5vd25GNFk5THNmY1pYVkREb04rYWR5VCtpNXFjeHFYaVlWVElV?=
 =?utf-8?B?Q0xic3g5Qjl0QWorQWMwK3VJS2VqNElBSlpGWFU1OG53d0Evdk43VkpsSDVU?=
 =?utf-8?B?alBIb2tuL2dtTFBrN0JYSDV5K01pSFdaRjNqS0doZDQxS3JEckhmOGlnRmlB?=
 =?utf-8?B?Ry9HaFNMSHByelJMMWNpc3FOaGRHelc2dnJnZThTMEJDeThuT2VwUkdZYUhB?=
 =?utf-8?B?L3FMdG1iN0hwSGU4M29ZQ2VJa2RUdGxHWU02eDdEMHRuT0hKc09zMHBFMHZE?=
 =?utf-8?B?N25Wc3hHU2dxMnVmbnN4TGVFNjF6bG1CVWZvSmRNM3ZEazQ0MEFJb1FUckJx?=
 =?utf-8?B?QnIvakVBa3ZQRUdQMXJONGpkcGlNMFU5TVJKdjB0NWo0bTkzUXFYaTFrZjJl?=
 =?utf-8?B?RHN6S29nWHBNMWZLWlNnMitkTzRGYmhuUEEyOUg0a0hXaGRlbEsxWHJGVWJD?=
 =?utf-8?Q?gxhoWH71fDEjA=3D?=
X-Microsoft-Antispam-Message-Info: ydeDanIhCyM4ymQRC6+HtbP7iVyEr5nBXRsZwwJlKSWVRh6XMD2HUBozeggovOgPyJM0rLjZV94IQX+j7QSS7Z1Zowdy3cyOEUK8xKZf7ypOJgcw0tS22eXmQ7bVEzfgXhakQhMUBDtLFbV9iqTZY1Gv4ARc96odvGpiopdwQSeUPBiqvPknXjyAdrsTpARy
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;6:5HBLpmNxGmiTuvlBSq0yf542EZtGbwUfYNxTypOnbJsf3sVBy8VhrEbmusTvgb/Zj90OmSNS9fk8s6tTIfc82i4Yrj9VzU7xqmRYCFAsKZT/POoW5HZGtMUsp0h5orGYChW70ty+WS8OkcfVKOE3MdadniiI2YhmstK/wlIcSm4t9z4itqD4l0zE5kfX6dkSfWBeq0KqV3RdzRytmne+qgWKAXS33PyrK1oRo/OQe037UOlA6nBfFYQiZuwbF0KHBEhERTRbpDfobFnZNkYqOQ5mrBCwPN4vrKhYUftbTK4CAowLi8L//G2AnBnlMz3nyP0L+D/xZHzIGwpUfLXknaxim+n8E2nZo5kTIg51B57FpshsHS7dmC4JLZuKQ3Ebzf03/ZoOOINFaHEGYZYic9f/QxDJpJvAku+RCHNJTVo9TbF/OfvNm69wzBRXAOqagCrMgZeLfQRH4AwlNa9mUg==;5:/HRFD8zusFPvPZAr/k62g5g5ehQRWm2lG90ShOvvdHzow40T5evg9XILxVyp7tAJ6hMIsclQCX34BiUJrExZOJN1EVmp1LwcBxod2dwC1SUYSdzwv7puZOdNN/XV170+5msytBOgw6sS7ii/2O2msg7qk0iCOOyTUC0rL6/zsUg=;24:Q1ZAKUiMJfbBX3zyRA2pBew4B28Zpm5cgYWM1Fjg3QHcZc8RvYw41ncpmp6TSJHOsfKgZJMv4AVFAr5+WzzpOtAgvK9WLqLEucUduk3t0Ps=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;7:jxhhXl0JhCR7cNne5gbFTQ5TbMtsCgLoOGHEutRT5Ikz6s7amiGsRZelOlkFTSKYW6lSjWWyOFmyhRR8154B//9ndiFoLg3CgnCElagMTrsdf13mf+r29EwlE6Mmzq+w/jX1f4fRP8LhURsd6+tUO27LFLev+98EewY0tYiQZPiiCpYVlab5V8DwmnvnGar3yROD8+obfMCfmg9N0RqgKmCE5/KopcGaJv5EBlCu9+egp4lKZyldvjTd/nSPimH8;20:LNp1WGpfjJxOm7AxTHWGLwUVaDvRV9ElzD4NmGBz6kNoh8grSujmeCdt5P+PIvfsNwE2XJ/eQ6aME2n3VA/fi2+BYZJc3vLLpP0+463bCp6tsqIlr4dSTJkP/m8MmqUrtVrOOM0Nn+JdCc2Q/sDhmi5zTHPyTv7l4KF1a/OeIgU=
X-MS-Office365-Filtering-Correlation-Id: c9d4282d-b5e8-468d-2bb6-08d5b5a43537
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2018 11:58:40.6583 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d4282d-b5e8-468d-2bb6-08d5b5a43537
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1337
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599987646785813310?=
X-GMAIL-MSGID: =?utf-8?q?1599987646785813310?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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
---
 include/linux/memcontrol.h |    1 +
 mm/vmscan.c                |   70 ++++++++++++++++++++++++++++++++++++++------
 2 files changed, 62 insertions(+), 9 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 1fb2f96dc2f6..4548b09e44a7 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -756,6 +756,7 @@ void mem_cgroup_split_huge_fixup(struct page *head);
 #define MEM_CGROUP_ID_MAX	0
 
 struct mem_cgroup;
+#define root_mem_cgroup NULL
 
 static inline bool mem_cgroup_disabled(void)
 {
diff --git a/mm/vmscan.c b/mm/vmscan.c
index d1940244d0bf..648b08621334 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -376,6 +376,7 @@ int prealloc_shrinker(struct shrinker *shrinker)
 			goto free_deferred;
 	}
 
+	INIT_LIST_HEAD(&shrinker->list);
 	return 0;
 
 free_deferred:
@@ -547,6 +548,63 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	return freed;
 }
 
+#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
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
+	/*
+	 * 1)Caller passes only alive memcg, so map can't be NULL.
+	 * 2)shrinker_rwsem protects from maps expanding.
+	 */
+	map = rcu_dereference_protected(MEMCG_SHRINKER_MAP(memcg, nid), true);
+	BUG_ON(!map);
+
+	for_each_set_bit(i, map->map, memcg_shrinker_nr_max) {
+		struct shrink_control sc = {
+			.gfp_mask = gfp_mask,
+			.nid = nid,
+			.memcg = memcg,
+		};
+		struct shrinker *shrinker;
+
+		shrinker = idr_find(&shrinker_idr, i);
+		if (!shrinker) {
+			clear_bit(i, map->map);
+			continue;
+		}
+		if (list_empty(&shrinker->list))
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
+
+	up_read(&shrinker_rwsem);
+	return freed;
+}
+#else
+static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
+			struct mem_cgroup *memcg, int priority)
+{
+	return 0;
+}
+#endif
+
 /**
  * shrink_slab - shrink slab caches
  * @gfp_mask: allocation context
@@ -576,8 +634,8 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 	struct shrinker *shrinker;
 	unsigned long freed = 0;
 
-	if (memcg && (!memcg_kmem_enabled() || !mem_cgroup_online(memcg)))
-		return 0;
+	if (memcg && memcg != root_mem_cgroup)
+		return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
 
 	if (!down_read_trylock(&shrinker_rwsem))
 		goto out;
@@ -589,13 +647,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
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
