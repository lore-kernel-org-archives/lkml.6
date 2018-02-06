Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752678AbeBFKTy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 05:19:54 -0500
Received: from mail-he1eur01on0136.outbound.protection.outlook.com ([104.47.0.136]:26688
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752356AbeBFKTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 05:19:45 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH 0/2] rcu: Transform kfree_rcu() into kvfree_rcu()
From: Kirill Tkhai <ktkhai@virtuozzo.com>
To: paulmck@linux.vnet.ibm.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        mingo@redhat.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        ktkhai@virtuozzo.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date: Tue, 06 Feb 2018 13:19:29 +0300
Message-ID: <151791170164.5994.8253310844733420079.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1P190CA0031.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::20)
 To AM5PR0801MB1331.eurprd08.prod.outlook.com (2603:10a6:203:1f::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12138cbb-4122-4ab2-ea3e-08d56d4b1e76
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:AM5PR0801MB1331;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;3:M+vD3dQ6w3ZtKYljwRx6mcnRJGKPEv8M+8VRaohkNbJgB1DYqOp3YkXWwj8qqPHiCpMf6MW9Hpot4XjJYZv/uQs8UBr9DMWLCGrI0bFYdfwnh7tIWP+FRB/nw6fr2RupZtEKThOlR+2POJU6vJPklYYKiP55xOj981Ya8xfpUMpSMjiUpOr4i4XKjnCI0MO6WoTApLq69qpKfxgMKoIpf0lnw5CIBcOob9yyI+UU3yQMu3VkKUSH6sKZvB1s/hoP;25:vkaaCUVquP85nAznu1UfvIF3w4DoA9gGloFXWZ0dtoU9TgtwmdMN7YHBQQ0wSPkIeRzs1dQrR5Vux/XxKjVLAyvxANCBAT9iOVGULtzovQMfWI3n2HKq7o+1c7YlA2aqKN9c+xl6ny6rILMiH/6aitFfbtJv2nOE10IM3qy2w+IIy2J/n/gMztej2G9Hu0Y37Sr/o2cqjT25hWZAl+W+uP3U4thhMvME7hLQihhts3tTo8AeXkkgMasQ2nCzKQlFE5RFf2kVsR4wpw8zeOcTJ9N5cl+m0XRrH1i2O/K0S2lUo28ODG5oGPUE8I3v1ASeUWGluiSAfOEWGdzCCNT+yg==;31:PW5ww+13CvMHK1/fTrvc5q2sge5SNoYOOOI84T5Sn14mhrYqkJk6HSnXr6HCQPqx0ngHVrCcmAJ1k1yZO0vOIqlKj82W4nP4fsyETRoG76WSMoGVBVqHHGPVkCDxYJf9PKMntx9yELg8+cLNpzoctD2Z/5uwPpzOZvigTcHgQtpaV6O+8DF4o6OCIblifwT6O7TQoAm9FNUlrTTfOpbGBGV3zgFBTydAqe/qjva3js4=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1331:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;20:jjCGwnszoMha/2gbKKLVp6bpaazbF3YrHXkeGcLkVyO/HBfiWE6q/1QnUT9Mlv+LRUGBHt/XqfFPt0NyCuut6uOaiS11gIoEqC6bMRg5f8usiurf8vkSy/5bEDrcNCkmQVJHmSfD1ft8Hl50yuElFr9cJaIuAm4rvEZYjV9B+YBLea0c5XmueLRrXlj9QTQePaHZXbf8xtm4KMvn31rcEtz6v7RAXQnz3kZqx45RVTY3n0wGMbMmXHvMu8NduuInYVZ/NfLyRFkUl6IyGGlNF/bM222nmg/Dg6o4a2yJfqIt81yMGQVXDkdPMH20EQIt/M8yAMHHiOfOO7Qwe69/JFvdmk+rXWtmhSgq2LJHf0RNPFnvNWE0duyacHp0Vy1ce7i32pZSSl5U5TggPB6KZ/ull/lYICijkIC3hH/SVd8=;4:IGO3FECW2Ef3sr4Q4zr8eLwg23QDp6LalB7zy7qIOrJ0rf9SzXX6BchGPfeY1DW4Yir328L9QxEcLxrMSUuINTCQUn7CIvMKMszLs7LUSEf1xiTlCn4E0EgG6LGUAEeHWMdRNgu0/UlA7vo5emMsegxphgHiSY6JGmxCdRH1HhgLYs8cQlpg6oglMGNbN32EnKL5+wns4LUABqHSpN1U+eEFNfcef/kzVk/NS1UycVC/W0vdd+umKkQW+Xf+GKFQqEHo1H8inEpH/fdED/xTPg==
X-Microsoft-Antispam-PRVS: <AM5PR0801MB133182FC73F5FFB18E19C9C5CDFD0@AM5PR0801MB1331.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3231101)(2400082)(944501161)(3002001)(10201501046)(93006095)(93001095)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:AM5PR0801MB1331;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1331;
X-Forefront-PRVS: 0575F81B58
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(376002)(396003)(366004)(346002)(39840400004)(39380400002)(189003)(199004)(9686003)(8676002)(3846002)(58126008)(53936002)(59450400001)(33896004)(478600001)(103116003)(186003)(105586002)(55236004)(7416002)(6506007)(26005)(16526019)(386003)(6116002)(106356001)(55016002)(230700001)(61506002)(305945005)(316002)(68736007)(7736002)(86362001)(2486003)(7696005)(47776003)(81156014)(50466002)(23676004)(52116002)(8936002)(6666003)(81166006)(97736004)(39060400002)(5660300001)(25786009)(66066001)(83506002)(2906002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1331;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMzE7MjM6SGN5QU16MmRPRklSeDh6NTRFeXFvSkhY?=
 =?utf-8?B?Y0djZjZKaTlyTmFWeGY3bkdnMWNYTU8xQWFONTVFbFJMNEQrN3h0MXM5RFBs?=
 =?utf-8?B?aElFZHNMK2dzYU9wVy9ka3B6ek1MTjlUNTV2eVZoemxYVHBDMGovbmxNdk5C?=
 =?utf-8?B?dEdvUnBPMHRNVHhIQldaOHdLcThJRWoxS2hYUDVQTitZWXVFOWVpVm5lT1lP?=
 =?utf-8?B?R2s2a1BZTzRBZGxIN1JGcGJpUzBQTGtoVEZXSkZHSVpDU0tLV2J4Q1FlWTJZ?=
 =?utf-8?B?RTJTWW1vSzdibDQ3MzIzM0lLZ1d6ZEhzenAwVXpTdVNTdDdlYjJqS0pFdDNS?=
 =?utf-8?B?QklVYWN2dGpiZHJXQmVMai9Lc2RGNGhSU3hack42bktkNkhYRTZnS2tlb0NF?=
 =?utf-8?B?SCszVmMvdkJQTGQzSm9FalUxenhZMGVQeW1tcDZUZXgxcXVZVExWb3E3WENU?=
 =?utf-8?B?WVlJdmF4aEFpdEViVWQvK2ozNThsOFplSDJzTFV5ZXFLVzZVV0NtOTk3YzND?=
 =?utf-8?B?dHJMOElmalZrL1QxT1dpbzZ6YVFUNkFoREduVEwvWllZcVBjTHJ1Z3FUcEwy?=
 =?utf-8?B?TUM0UTFaM0I2R0FrRW1UWXlvYzY0SE9jYkc0MTJTaDFpYVh1Zm1reXRUZXha?=
 =?utf-8?B?OHd3QXR6M1pDdHllbFcwNzdodFR0N3JoekpiSWNwaXhvekdzZDJZN2c0Z0Qx?=
 =?utf-8?B?UWx0dUpWTEhTTDk3ZlpabU5iWTUvc3NDZUR6aW9TUFgvL25iSmRKOHdXUzU3?=
 =?utf-8?B?aU03ZFdwVW1paHhScWM4Q2N3Ny9rTGJJOENPNFNTeGRlbk5md001UEVSRmJB?=
 =?utf-8?B?SnpjdHVUL3RNbmNjQ2Fkb1dSeTE3cjZURzdaUVFvQk9HZlR0SG04QTNQZEcz?=
 =?utf-8?B?VFBmbDdqUGZPRXNJZEw5aXVDd0szeW4vT2o3Y0VKa1RZMlZZZ3hRRU5mbnh3?=
 =?utf-8?B?bGZGcXI3Q0VqUVFwcVBIa2RMWE1Wcm1WYUxrcFV5ZENTeHMvbk1SMlJvZUtv?=
 =?utf-8?B?RGthZHd0T21ldWYyQUVWVGdxQ28xSzdwMWNJTGFvU1grTzFqVEJ5YzNyT2Vl?=
 =?utf-8?B?TjBCSERNanE5ZTRCNjRFNlpIK0o2eFpaczZKYllQc1ZjWGREeStac0s5TDlP?=
 =?utf-8?B?VzJxWmo3dFZMZFFOU01ObTk1eTNXR01LOU5hczdSOTZjQTBrQy85dDllc0Jz?=
 =?utf-8?B?Tll2MHJiWGtuTDNCYU44NUJMOXkyWWxCelBRYk9nUytYcE1oN2EyaWJYK3Ir?=
 =?utf-8?B?eG80NjFnajZyVWgwSmJMMmZZWFExMGYzekhiMU96bGF4L0ZkMTVxeWQ4cnNx?=
 =?utf-8?B?TnhZYkZHcStoWmVDV0pDQjZXWFJKd3dRdkw2d1UrbXZEZ2NFSHZqclJaNVJr?=
 =?utf-8?B?ZGo1alpjU0lhcGNueW1BeUVWVG9rL0VzU1RMK1d2UWRQSkVzNDdocVdtVG1u?=
 =?utf-8?B?cjRmNUh6MVk3MnlFV2MyTjkwNHBybEhSR05Yd3NLSzhKME80YVphM2w3Zmo3?=
 =?utf-8?B?VTAxVkFEaERQcDFFamJ0RTlhbjhBNGkrUUd4bTdiMU43RUdlRW8xQ3gwV1JE?=
 =?utf-8?B?QzR6ZUR4TzloQkI0MUJtYmFKUDNhTFdKUFNWdEZkY2htbERVQ2RRbGRPL25v?=
 =?utf-8?B?SnZRMHRZNmV0enl2c3dPM3paeGUzWFo5Z3MzVXN2ZXFBY2JYY3BJaG9jZVhq?=
 =?utf-8?Q?28CkPa+GDdsKP4QQTvP8=3D?=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;6:60uFEV5S/vlKMmaY95AC/WOr0qdZTeOc/BgSd0URXN6OhhXxQvs7Q5GHRGVvJ3aT5nLVtWU8JJZNT+cRsyJOxigNOGSwhpfmqP15++1djIFdxNhYx9Z8KST5vjm7KUTh4YcSqO0KyfeoCjdLWHX3xqHL2J8PwC645u++d776RhhMlfHhNZqR/aj51avQFwkk45cdFLulqzfMM0OiqK2911ouJp3SviBb1vusywdFoOAuhUCiE31sppDi2QS7uP8PU7KOmDu+FQXU+EAK/du6YPzfNoip8Pt3xzKUEEx3bgzgZLepbbQh6ivbLyLX/Z46H5IpMI2HTUQxl2Ws38E4DeMMR2aFLTZpTlAcY3lQY6c=;5:dugOIOSDhKnu8hGso3Ua8VUV6VmLu5qHSOfsvIsv0HsbEkCLqNy+08c7fHk7Z6ZNnq/0F+73ov//cAD4F7QTn8VZgXgyu5waEyF2sDJX90vVkOeVK5MIRTONWgkXJPZ/Clfdk0VF3r05f3oF8xSxKX3bnVEeWuzJAF1f4+DWy64=;24:ebPr0n1Lb2uv7AsrrWTIQBIMo4in2tNI1fIgHMLQ/Q28Xd3mk/Bk/BC7Uw5E+nujF80fvIwdUh/5cQhOO0o4fBDVWgd969OZjcxEELyk5jY=;7:lU4bLmGhh57Vhb8VZKx4ASJ7xVqRrkFu2n+pljuiLlU3AOChJXdUpBybCZzLAYs5l14fBsLTcDNbMx8DWyFLloy70X9ZcMC1Hwf9MsXlixhQnWPaKmyvCoRgp3Tun2+6Gx8m+Dk33T4yw7/73LkRG6Y9uGbDom0+sw/PpN/5uQgko+XCLd1mXo/6skEwITXCNyP4XTs16TJRZmKCw8krG5K2rK39XPsM11Ti7EW5rJqpd+jgeozUvEs51e3BJxDM
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;20:7LLKqUTXidsDVuOG6PAPNNFt8Jo0if37b/1cuts+5lY4aSOKcgjl2yMybKacUqEyZywh5PrOAi7mB3I8rMgnLTXhw21KkFEqMfcT0fN1Tc5SW7Z6fgu3qqEtSf5Y2YI84Vrv8mjOlC6FuWsThpS0yPPGdnhz58cNVHbZsaSJKkc=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2018 10:19:33.4502 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12138cbb-4122-4ab2-ea3e-08d56d4b1e76
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1331
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent times kvmalloc() begun widely be used in kernel.
Some of such memory allocations have to be freed after
rcu grace period, and this patchset introduces a generic
primitive for doing this.

Actually, everything is made in [1/2]. Patch [2/2] is just
added to make new kvfree_rcu() have the first user.

The patch [1/2] transforms kfree_rcu(), its sub definitions
and its sub functions into kvfree_rcu() form. The most
significant change is in __rcu_reclaim(), where kvfree()
is used instead of kfree(). Since kvfree() is able to
have a deal with memory allocated via kmalloc(), vmalloc()
and kvmalloc(); kfree_rcu() and vfree_rcu() may simply
be defined through this new kvfree_rcu().

---

Kirill Tkhai (2):
      rcu: Transform kfree_rcu() into kvfree_rcu()
      mm: Use kvfree_rcu() in update_memcg_params()


 include/linux/rcupdate.h   |   31 +++++++++++++++++--------------
 include/linux/rcutiny.h    |    4 ++--
 include/linux/rcutree.h    |    2 +-
 include/trace/events/rcu.h |   12 ++++++------
 kernel/rcu/rcu.h           |    8 ++++----
 kernel/rcu/tree.c          |   14 +++++++-------
 kernel/rcu/tree_plugin.h   |   10 +++++-----
 mm/slab_common.c           |   10 +---------
 8 files changed, 43 insertions(+), 48 deletions(-)

--
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
