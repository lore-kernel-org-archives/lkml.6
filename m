Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZqDpCXi9WmKaMuypCNCmB43/2r3+1VZdaBG2lfmwQrRHUqUQEwOU3jTLUf8tF3/GFgbQR0q
ARC-Seal: i=1; a=rsa-sha256; t=1525946061; cv=none;
        d=google.com; s=arc-20160816;
        b=b9EATIANYCLTMYJRu+thqTnOgtK6PJDIcZKlitnb+YqS6udhVeg3MbnIf+/N66/pM6
         Hy3ZpyfAWLyQAtRa2uJYrHxzYTEyUTgEnsP5phQfoXHmgO+lguc4yf/6PvVhnbmb5q2T
         hs3x2Nix5Rk5gmIFm/aY9QjIsgmetjZ66WQp8QiyU0clVNJ46dlVjvKQ5Sy0vW9AQRIN
         QXG4SBRijFGJbGUEk6398CtJBzW2N13hhfESQRr3rLFcL2Z8o52JGAmcNaO+F+adAUBY
         1O6KLUjJDamPdFSnkjCFXJOtO1KvZy14GhA0HUHHY07n1EsoK8HT4euaJrHIrIGLwXBO
         +SxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=nLiaIQEkR6LvoUDFu1uhT04EtxhfvJavbLrRQPcdzuI=;
        b=dab/5E7NdfRxyFyo+hgTASg0kbdlxmmT3K3bHGIx7d/cNQTzO5DR0qChgg+VcrD9rp
         tpDHoqXAWVxClSfZ5OcwYsTw7Y+NVcyI6wd5NFU0wb4UoQbjxTkKTqjvi74tfA8hwyqM
         UidIy62vARD+p1UEOh53ojOvyL2T6kC3WKJhVXyNZbnhcq2UM8ktO8ft54Q1b+8J/r3A
         FkH56tc64m+VII9S+J6ZpZxGzHIHSAu5CEvS4Y6hQJtCsCTZrUYF51aeX5Am+wu5qMu4
         5wqAG9ML9Qd9xtHOqJA0YosiwgCIGBrKaHUtINmZe7+cFdOSmGj7e18lZqpOA87ce9v1
         vbFA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=HaisNl3n;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.102 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=HaisNl3n;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.102 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v5 13/13] mm: Clear shrinker bit if there are no objects
 related to memcg
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
Date: Thu, 10 May 2018 12:54:15 +0300
Message-ID: <152594605549.22949.16491037134168999424.stgit@localhost.localdomain>
In-Reply-To: <152594582808.22949.8353313986092337675.stgit@localhost.localdomain>
References: <152594582808.22949.8353313986092337675.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: AM6PR07CA0004.eurprd07.prod.outlook.com
 (2603:10a6:209:2a::17) To AM5PR0801MB1330.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::8)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1330;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;3:wOA2VU1zo7DPjoHvWgMYFiR1489peMvh+fZdmeTCF14gJ1eRHB+mhi/z6D8VM3elcyftNfog0tFJQUCOrKlecCsoU/KNwCan3PjM0+lE+IVJQ7K38A3hqWY7g9FdSD0WxOXZGIlzXDOwCPLB2BpuPqDLEBAFzTYtEaEQPIyX3V2M19Watx+4ASlRqvdunW7mCEWjA6KTSU3b7TsqGNl3yIGSWcXzb+NV3mbn14JI46ufyYKHJ+k52nRmH0ZEsGqn;25:/q3C5Bqf9LXAoxISgbv+SAneGN9E+PodBAF13ii9XkJLMNYM0RYvanENhS1oKeYbMKYEmIY4ihdF3DHT5LVC5XkgtJVw8PxOwvVNFc3ecd8BnsW4kVQHmB9vQBZgT8IiMNjsZhcKm/pcVZGIhvOcvlL2YdkTBmyJntQQEjntTYEdKRmvdOWwXQ57DUqMXCFlpOo/wiqcinKfXCZvmZiNzmsAXF6/l3LyrBrCmDnx4N2NcNion13OY/pIfBwXTViN01r6C5/j7hbtGB8/d1SUbadiUnoGTmFT3BZAeA/+pZkNRenBS5JnG77GP1fzOkFzgWNpErAGLub4Wbm35tacnA==;31:nNePOsgx6/8lEV2oCq+9WSrnaqkdcyNArrK6DVCEkQFNi33KwwO22YxQZzLNfvAwhgc/pWM/QtwBqc2b/4OwjqAQhkFKfLb4WKgjjxA2lNnu8atH5njxkXNSnhtWvWJihtwj3Q15WiKWSocV9Lq4BxisFZaTZMymBzeaqHMK6N+XBb8IBJB6yDrLiG1Y/M+AZ1IqYjafT22R6vIW3SPtxVa4XA27i9Qu+sEuyVUUzfA=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1330:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;20:Oin6tvmQNlWGcuHOZ+u6fM3tuY3ecTCOGcbeCqD3Nl3q+4gcqtuhjgy27U+6RMaWbxo/QQB/ShKlu6933xgwTdJTbmdOlT9tGvgEFbfIaCX1ZHS2VWgB0gLf16SZMEl6/5JHFgAxGZuZUDTvJu6BTRqa4hxEeyWQpJLzWdlDr8EmloPOyxraozbO0DIvnnKcD4rbvJlo4ib+JPwEBcIwIKhd3iCu7d0+0fVbfZLeYmy9GDq/OooWles2tihnf0JvMxd9Vi4RyoURW/r8il/VsbBMmS5FJd7p8va8dV9FKcGmVaOMJNICBviA8ts1hnVBTG/4Ya7eSm6vvNpwVEnCe165vGTxjkKG4iWgHgIk2u/j5nCbewzDO7wlRsPb8Z4RrLhPWt7/KaPQvMiQ+sb0dWsdpBGGehHma+IxsaxJgm9JQZWFc99NgdqMakUrXqr4aEYMHEMuA+DEwxmr6khNYI0vyS7Vo1lma+0zI7XVRGiPZi7aglMDS+M1e6BleQXE;4:aUd2ZuYrZXbJKSe/5Uyd6XQRPB3S0TkoJ6wyqK2q4H+SO0kKA6PJac9UA3mk9hroTdR7ApS7aqs6j36/7cjcTrCjGYaWzfHYW7mOoVPrr9wn4lIccGqgxWANB5luDF/AqSpAJ5+Kpsdc869JSDnP7dPW6ForFEv52CdwGM7zZEXuljGIZ9LVKP+y7YBKmb7MU8c6DaspproYpt4YibfKYtWnfwo+pQfmT8AqplFjR631E7Gh+Hk9fPlg32LvUKW3uh6ogNeNwxVch3szh38cKQ==
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1330DDD80DC2AA3DF8B7B6E9CD980@AM5PR0801MB1330.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:AM5PR0801MB1330;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1330;
X-Forefront-PRVS: 066898046A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39380400002)(376002)(346002)(366004)(396003)(39850400004)(189003)(199004)(305945005)(186003)(575784001)(86362001)(103116003)(6636002)(2906002)(7736002)(478600001)(230700001)(11346002)(16526019)(52116002)(106356001)(97736004)(53936002)(39060400002)(476003)(58126008)(6506007)(956004)(76176011)(2486003)(7416002)(68736007)(316002)(61506002)(486006)(55016002)(25786009)(105586002)(23676004)(81156014)(7696005)(446003)(47776003)(81166006)(8936002)(50466002)(9686003)(55236004)(5660300001)(386003)(66066001)(59450400001)(8676002)(6116002)(3846002)(33896004)(26005)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1330;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMzA7MjM6QUFBTnUvakJsNHNYRDNsTlMrSURSblpO?=
 =?utf-8?B?bkxGd1VneFk2R20vNlkwcmgzK0RnYTB0bWJObXhCMHBLZnVKWFNlMDBMSVVu?=
 =?utf-8?B?QmlVRi9vZTJwVlJDUWgwZ1l0NVpaWUgxYzVQMEMrOXJjc1V5QWtnRXEyS04z?=
 =?utf-8?B?S3dRSDNNQU9RUWVOMDlMcWhaOU1zRUhwVmZQRUlyNmdQWW56U0J5MFlhbDJL?=
 =?utf-8?B?Tk5Mdk9NOFA2cTcyU0lIZURtTUF3OEk2Y3IvU2pxSkc3ZTdzWFVoZ3NxQit2?=
 =?utf-8?B?VHY2OWJpM09PY1FKMkJlOVNwSGhpQzFlMDQrclBFY1EvNnBSaXRYVDd4Smda?=
 =?utf-8?B?SVE4RzJJZjIxZ09oNXFsdk9jZzNlbTJNRzN2SzZoOWE4dFNOMjYrcXpPUW9M?=
 =?utf-8?B?Y2E3THdWRmNoQ1hCL3RGOWJzeGkrWGNNTm5EV1dzTDkwanNVa25nSnRnLzJT?=
 =?utf-8?B?QUFnRFlNY2NDVjlvOXpkeVpQUTRVbmo5VGFqdlcrS1RCWE81Nys2YmpnYlFj?=
 =?utf-8?B?UzZ3MGkwQUppck8vS01ubUtFK0ZhaG5FUWJ1dm16MXdocVJxRTU5RWVldjZk?=
 =?utf-8?B?QjNLNjdqelZqbVloWStRZWdWaUdFN1R1dENDU3E3TTRFb2dmZzFSSEd6VGsz?=
 =?utf-8?B?TFNaNFdqMHlWME5mZEtUM0kyZlVVc2pOS3M0VDdHajlHZzhmT0ZvR1Y5OGlZ?=
 =?utf-8?B?Rmt6aEllNkxTNUVDTmxOWkZnb0NERmlCeGdWNTRjZWlwWkYvaU1lcWVSRzE1?=
 =?utf-8?B?TEQ5em5XblVtZmY3UjFzL3E0MC8wdC9PL2Fqa3VnRlJQeXlwd3poYVNzdGFE?=
 =?utf-8?B?UnYvMWI3V3Q1eTJoZ1M2S2EzOVI3T3RXQkdUS1AwdlIweEQ5TjZxNEhtTFRj?=
 =?utf-8?B?dFRtSWJqbitQQ1VrSllmMkVlOG5TczZKNVdxRGdaSWFhUHpYeUJ3VkxLYm1v?=
 =?utf-8?B?anl1eGVGTWlUdy8yM25pT1hiTTJqM0tlSGw3WTJLZTFrWDZLRENJUzR6blVa?=
 =?utf-8?B?amJXL3hMOHRoMlgyMXBQY0doS2QxcldNRUtJTFZIakFWMDFZRm9QNCtsdEtF?=
 =?utf-8?B?cTJZSzJqNTRBMm5BSzhRWWZoWEpxS2F6NHYrK3JBZ3lNTTJVL0hYNWFZK0hj?=
 =?utf-8?B?YVA2blNwMTQ4Z0pxRWFPOVhPbkhjc08xMnNKRm5oU1NlZEJVMHR5NitrUzU4?=
 =?utf-8?B?NFh5S0JQbFdoMmxsWmptQkU0T01NdXB5Q0Noa1B0dnhZaHYraVBMdFBMd3dW?=
 =?utf-8?B?dG5aMzZFbm5namJjVEsxYkxLb0lCSDJNT1FacXRkR0hPS1pKeW9wNFJ2U1NF?=
 =?utf-8?B?Tll6REFKeVJEbG9yUFcrUUxRS3QyTmZzWFpRcCt6b0o5Y3QwQ21hU0lqaXNP?=
 =?utf-8?B?b1R3NytCTU5XVC90Q2gxYkI1ZklmZnRXTnFIcDVJanBPQzNoU1FaZWFHRW4w?=
 =?utf-8?B?UHVQaWJTajJKV1pEV1AyNFRYanpycWQyNXhRcDhkWnUxMnhBK3hUYmxPVnYr?=
 =?utf-8?B?WHZJaStkd3FoTzJ5VTgwOXh0b0pVODh6SWNwN2hCVE9rSDdpbm1hTW5iNkxP?=
 =?utf-8?B?emNCL0RYYitDOE1ucklDQiszRHpPd3RSRWI0cFRmdFZVQWxVT0FyaFY1cnRB?=
 =?utf-8?B?VXhIS2JzeXg1eVV5elI4L2NjemZUand2NzBvS1B1L2I4aldWVnhNLytlWjYx?=
 =?utf-8?B?MkE4RXgzZUtzNWdxdTladE5lUEQ3N29BRjRKZVp4UjE0Z0tvKzMvVkovaEd0?=
 =?utf-8?B?WDhkUEU0TDQvWFR3YjJXVVFQRnlRTlRySVJybkoyS2s0VHdWdDNOR3FCTkYz?=
 =?utf-8?B?SWNzR05mN1JzbjBLWUgrdWRGYndZelE4djFxN2c0QWw5aGxadz09?=
X-Microsoft-Antispam-Message-Info: eU2jJeXAhOA2avR2K+N+/TjqcOkeIYLGDhbx+/Cdyo80LMwkXM96TxrnKUTDxvHdEQIyBKVAoNY7aaiN79Z7/33fZ/JRj7E0uLvmamsfDGt6wdQhIjzEzaTXfnS/Bs/05XZ2HYPtel474IZnpUQJPoM3jvQGRERZi0TO+rLdCMjo+EruU8Dgogy1++7n7IBj
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;6:3I56Dba2JsAO1N9Hf2IM+3hYHS9ix0h1QQ592pg+OYz3f0PDQW+tGb+U/g8WtWnGfqzdd9gkehMvX58456I2DOsPhLS3W5byaQO1h6c2FL6YQ1G9si3aLwF7q0fUCF9g7VHJQxOQR54cAB4KKpZVL+S5yMr4YOCKbe89AmhKhg6zDg1fxZe/RANb+Gv9FPot/RkVeYndUkqf7D07RHNTMY2UgZ+ze9ScntCGjgz6YJ4UC2/k686N7GJ10Ks5IeoEhLXWrJFjtbWv6OmpW7UXUDbEH1X6UsRHOF6s0zqmjHMyYNz8Wi4HBOCWC0Cg/gE5keYXEQeZ2eixxXl18K+qZx8d2FsTVm1v3GbndySJ8AZZh/osSO4Jrk9tUPmPg5DDjGCY+2GZPQYEgNqpZvyIaZbCltQoJ3weCZETS/i+/SLqag3kdrL4OAzMQ6ZZUbnnZdevojysoANn8e0m8KUsEA==;5:ICDSCAe/8PWX67W/yivQkR6vnCvxhGeBT+zksh6T7CViopypu6k4ScLFyrs/Qz2y2M0IWHd6mo1mCAGON0+d/QMnfHk9mcDS7xaVRq2bBo4P/na08Ilad8sXbJa1rOkymbOAKReHIv+zN5pvScpthzuIzRDmBLrIBZQYw6W00ZA=;24:b57f852hw5E7gqGcH2BHeM5Lq/OgizoDLwh4mNiDiO0tF+qDrko5vCLc8F+aGYRJ3qRkV1Qgrr8rZKkkYoGZDeQ1YBkwrD0rW5GCRr4OQR0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;7:B7Kwe5pQMqUN+ngdKIK9mZfdAg4ZuHFAOBgUtDu3tJwNYEsRsdZiWisb63ADoTU29EtfGYT+Z6thR611FaQaTis/Tqar8RK34nPq4ShAKhvejC022R6n/KZIr3gRV8uGX6RUbbvTqZcleX4rAJbxQbrnDZiIx/wXGYGXoKa1R6t6wLzCcUKSGIHBJpD9zyFkCMAk3ncfbeF2BsJIeL1xWPuvon7kwohzPUQxputlbZzEKDmQkkirJIO5xJqmS4MA;20:jnBxuixnQsJ6HEnTuBKemO7O/j8eLBQFR6FmKjpl8VdGM3JlyOQudznWzH7o48s4mYa5feZSct4RRhtbyGIOnArKnwS92gYKpibKSjyOzY5dRNj3G/KVnj3nseZoOL/7uMtG0LfSrnRd4MnwIBFSVn9uD4A6JSJQfwGIQ5FKyuk=
X-MS-Office365-Filtering-Correlation-Id: 1440cdf0-7536-453c-deee-08d5b65bff3d
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2018 09:54:17.0686 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1440cdf0-7536-453c-deee-08d5b65bff3d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1330
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600070417544156760?=
X-GMAIL-MSGID: =?utf-8?q?1600070417544156760?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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
    $for i in `seq 0 4000`; do mkdir /sys/fs/cgroup/memory/ct/$i; echo $$ > /sys/fs/cgroup/memory/ct/$i/cgroup.procs; mkdir -p s/$i; mount -t tmpfs $i s/$i; touch s/$i/file; done

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

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 include/linux/memcontrol.h |    2 ++
 mm/vmscan.c                |   19 +++++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 436691a66500..82c0bf2d0579 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1283,6 +1283,8 @@ static inline void memcg_set_shrinker_bit(struct mem_cgroup *memcg, int nid, int
 
 		rcu_read_lock();
 		map = MEMCG_SHRINKER_MAP(memcg, nid);
+		/* Pairs with smp mb in shrink_slab() */
+		smp_mb__before_atomic();
 		set_bit(nr, map->map);
 		rcu_read_unlock();
 	}
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 7b0075612d73..189b163bef4a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -586,8 +586,23 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 			continue;
 
 		ret = do_shrink_slab(&sc, shrinker, priority);
-		if (ret == SHRINK_EMPTY)
-			ret = 0;
+		if (ret == SHRINK_EMPTY) {
+			clear_bit(i, map->map);
+			/*
+			 * Pairs with mb in memcg_set_shrinker_bit():
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
