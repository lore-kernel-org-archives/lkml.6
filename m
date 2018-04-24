Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AIpwx48Q8RGMr579gpimvmlxo7+ZM5K2jN9tYin/naBp4ruZQbzvZGwjbaDnKSDRbTYx3jg6xLlZ
ARC-Seal: i=1; a=rsa-sha256; t=1524572068; cv=none;
        d=google.com; s=arc-20160816;
        b=b9Pr90CU+OsoSb51sR3eUw3N3IXuJVcsH7lO6hdldUImYOsA5Nac2pQgwuVxDF3lHa
         n+JBoeeb+8CW+16E5Hrp1wqllmZ1SpyVxawovJ2VqDnH8KO/H2VZ9Cd5KnpyGb2zAioQ
         lR7s0Q3xXxanRUxKiQYNiv//bw5Artgyl4BO20ZpsELr35tUWXjWkencO63JADEKBo1i
         du1M2sNf/XAPDlW/6FsEES5n5IAQlLvvOPmbepw/rQq+gVL2NAO0XR29dLIYgQYa1Jpx
         Ky7Cip8m7qY5di4YehPoG/Sh7qJTF77ijZn3NdIDBOo/rAVSbbPFfjtx80x1DOgtVJTh
         GDdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=PIyzVH8Pxenm6+S99f8IIpXcu4VJ7bo6iwkeO7B1TTc=;
        b=zDRyIsnRhXap8t06mXsRrTc0B6oJiv2Zk0lJBJotjlUkW+udKZPJQfnwkvCRAWI6G2
         HWdJDXygNXmhHecMiBACz6Tn+nZiw5UR49fJAqWtjhSGx0TCGoUyLoJSVA12PPcEuMe1
         aexDIovCUdFhJw2eagY9kUyrMt/7tgaffnM+KLQgkdY3p+fhh40K45LSkHNyhJttJEV3
         5aqqxPsEp6QJyhRLeYC+0i8os1SSzh7pwYFczeywx6w01EKAIJHNA+1lOYdnqQrd1MDT
         dKachimadWuzbE6srlrFvhtThBYRQscZ+OOxNKDXjZJR765qCcRRCdTBqzCTi5i3TUN8
         eeRg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=eLUDHJ1U;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.2.125 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=eLUDHJ1U;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.2.125 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v3 14/14] mm: Clear shrinker bit if there are no objects
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
Date: Tue, 24 Apr 2018 15:14:21 +0300
Message-ID: <152457206121.22533.14178814305402011694.stgit@localhost.localdomain>
In-Reply-To: <152457151556.22533.5742587589232401708.stgit@localhost.localdomain>
References: <152457151556.22533.5742587589232401708.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0902CA0020.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::30) To HE1PR0801MB1338.eurprd08.prod.outlook.com
 (2603:10a6:3:39::28)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1338;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;3:cVzZ/Zx6/sk3OuKoE9aSAN8HDtkj96aD5+5HMv4qeWiB1Z+oRvNm7Yh+HQdD9VShJ32U0vF2aiBC8EBwLEynebfiszzsBeoZT1GW5GEM64jN+eKqlSXMKSXlTp8zA3YxiiWXjNVPsGdIyySrScIMvHYvVzvEQRg+4dax7LCB3EejF1bynWOWNkODZJDLUQ/EVtzmqLrEhk9pHlUJS/j+Pb/PD+8kWiFEOt1cUYY8BEqfIp9FBTlUY4S+VgTQJtZT;25:JzI8sjCZ+W5ZwlYvLqk11ll7XkBhHe0HJCSdq8DX+Ui579FMH2QA1jb8NLg4XvDsXqr5bD+9pvJvFCWmrfdhFeC7xduqbxL1YDeZo7WZq4i0KQ25wsX9BeRO9yXvoHCOU/ZjLWAtDcVU8xPd4scnvzWlbdanrqE67tocq+AiUgOxQlZri5wL8WRNp1vY0oyWk6FBF/Dt4TRXHRMC+8OkzgK9GzUMGKwN1IJeZxg+QaZ02Ulo882kQsEMj5gJmLLtdc6ToUNm+A71vKXUsW/J/hbF5K6fBUqRN5mozZB5JKysnu+rHsKMJAJH5VJjfK7CqJAght0jmSWVvi525e2BxA==;31:z/ORO3t6ldne2jo9LsUAH5sw0z6OLzOKQhXzyDZWRlR7SD8B18RNSR+FqAU5XLxLbuNhPzE+y2jtb/ZbkaExjrRWWCcE6Sv5Tiy/CuYfjJsojIDNGfEcdgeU7spxmPC9aS7oVIVLEdG5KxYhHvQX3FWiwL1pFze3DZ8A9hS6E/KnK8zxIwxSp5tXiZr2HG45sdR+XOxQ4Qifdj4cvDIIJGKhPxa1w6rWJmub5Pcuqfg=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1338:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;20:oM3T2wylzfOsDXyuzBXXPDSzgy9Z/sQZAsspVv1bOofVS/DDzRcDvbDEeX8p0CocCnt5ZLzhNM+m+5HXF64sTGR/iv06IyjWGR5avT8qrw7tG4nGHu59CCL2icecnY4FRoHmBH8PEH+WarZIavI3ITpBZiQSztPPI67fciVSPS/Jcs9JwseFXqE1K8Mu+dYu+cC2SQQIyXhr/nXMD98odfGUQgCKzaZSSZjw2mnV5TLKwfL4+D+wiYOzwA3/jJvX7Y81q/KQTjqv2D/f8sq1xXe5gRHgu7RHWRzmAZ24Xd/khLjMuP6L4Xvuf4LZiEO7GednwnqgLqCZJhGKbQais7PPZUjmjBKYrwXGGoI+Njgt2SVapHbnDz7CK3peUQ/qnEroH/JneyfP5ofYPq/5ykg2HOBuYuPs6oRghvgtOaE9nR/hGlGc9E/zs4ti8HXCMA/EC++enJdbNIu/gakeMm6CSp+xehgET+1sj3byya/G0pM6KCzPS/PGJHZmaZJu;4:ptvDh2KtSi7wsoYQMYeJff39I8T6VwDkzF2iVFqiBoTRQce9Tbhfs5m2Y5L648C+l4lVaXU/8vUgC+FRWPN9H7dumrynFHd4BDZejc+fUpAAbgpq8XsFI3Y9LQUpV7Dkgt1QmthPB3nJCLcv7yxpU0Xtzznuth58iB89EoBhBkOD2+Ue7EU9Vl61V/M774K+FEVyMOkcR+cBrH9IhL67gnhPZ/YOqO2foykzun0Twccw7A6TFqz0KzSUDnx+ZEkMchf8AQD6Xm+ioyrHTN/zug==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB133895EEE24E018128AF052ACD880@HE1PR0801MB1338.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231232)(944501410)(52105095)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:HE1PR0801MB1338;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1338;
X-Forefront-PRVS: 0652EA5565
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39380400002)(396003)(346002)(39850400004)(376002)(366004)(199004)(189003)(2486003)(59450400001)(103116003)(47776003)(478600001)(68736007)(386003)(39060400002)(6506007)(66066001)(58126008)(316002)(7416002)(9686003)(76176011)(52116002)(7696005)(2906002)(55016002)(53936002)(33896004)(25786009)(97736004)(81156014)(8936002)(8676002)(86362001)(106356001)(55236004)(5660300001)(61506002)(105586002)(305945005)(7736002)(81166006)(6116002)(230700001)(3846002)(11346002)(26005)(16526019)(486006)(50466002)(956004)(6636002)(476003)(23676004)(186003)(446003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1338;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzg7MjM6UXVxd0NuNXRwWllwZmcydUl1VmM2Rmkw?=
 =?utf-8?B?a3lBR2RzOGNGVmxPdHc4NnpZT1BIVHFneFJUMUxVWThuNm13NkRKQVI0OGVx?=
 =?utf-8?B?WWduUjZ0bWp3eWltWE95Mkc5T3E4QUdMVDdiRWVsd3JnMTZVb3RqcS93RFIr?=
 =?utf-8?B?V1pzbVhqWDMwaGZoYTdJbzVQWGUyV3B4T1FMYWZOWGxEaFNaZ1QyQjF4SGNV?=
 =?utf-8?B?QzVDcWJ5cXNvSitueXpqYXRaWWlicXowZm5jTngzV2NwSEhtUEZDSHBGZ2J4?=
 =?utf-8?B?OG8xaGMwZ2krQS9OS0hSOUt3U0RNczJRb3VubG1iQmVMaGVSSEtKWmF4NVN0?=
 =?utf-8?B?WUhCdUlhb0ExQm1QalNmT01NSno3Zi9OelpjN2NJWlQ5SzBrMFUwd0kwYkNr?=
 =?utf-8?B?Z2UrTHh1NDJ0YkU2R3pvcGV1ZGRtQXd3R1VQc042MlBDM3oxYmJmVC9iaWly?=
 =?utf-8?B?S0NQeFBWMG05VkZneGxWRTBGOG9SRXFmY2ZYSzBLalNkUk5wNndaUXpSM3lE?=
 =?utf-8?B?UmZJNVc3RVNXNGJlMTVBMStsTzBobzVuK1d3bUl6WWx1eEV5T2hXQnhpdTU4?=
 =?utf-8?B?bmxkeW5EQUhiT3ZnblViUWw5NFhkaXJBRTJsSlVrUGpTR21ieVo0dmh5YTRV?=
 =?utf-8?B?MGEvUkdjSnUxVmdob3ZuTzRLU3UrTDNvSHpwTGcwamZOcG5iSHd5QVlLTFFi?=
 =?utf-8?B?dEVQTWZ2dlB2b093UlI0a25HdG1rZHFsUitJTmhYYThBL2I1dkFQNHpXaWVQ?=
 =?utf-8?B?M3hTOEJsMlltYUg2T041T1R6WXFPMnJ1OExTRGcxemRDWnVGR2UvRzlRY0Ny?=
 =?utf-8?B?TnFidVowZ2JkMHFxNlp0dER4NXljblRRL3pnVmR2MDRRUjM0cmg5bmNNd1BT?=
 =?utf-8?B?VUlqcU8zK1VGVmRwejdlM25vaDd4Sm5Wc25kUEVwVllUemp6dTV0VCtodWV3?=
 =?utf-8?B?cE83RnVjTUFrUnZLeS9BYlk3U3daSThuRUlwVVFNeDVMMVN1N1NGSlNKbTgr?=
 =?utf-8?B?NUJ3dFErbjBwNlRiRnF4RzVLM0krRUhZdlMzY01iSmpXZTk4cUt3Y2wxOEpY?=
 =?utf-8?B?aTBmdnJ3RU9sL3F6VzZVOXlOUG55L29KUXBaSVZiblJQZlNZYTZkditJOVc3?=
 =?utf-8?B?bDNHc29QZkErVWlTa2ZrclhZTm5IWkxjVU9DdmpGM1VaTi9yT1BvWVBHN3hz?=
 =?utf-8?B?eFlTNEE5Yyt6ampoQzhNdmlCSUlnMkVXQTl5a1NacFM2YTRRMUdUa1BQdVBF?=
 =?utf-8?B?UENpenZsOURSQUJ3RjN5SGFLRWxFd3lXdDhpOEpza1BTVThIdnV4blA5NGhN?=
 =?utf-8?B?NFRnRG5QNU9mZk5UVWM4QlFPTjRacHloZ01NaG54WFNqb3lPTXNwZGtETlJI?=
 =?utf-8?B?L1FoNEdCTjQ1VGUrbGR2dVJZOHZYN1Z1THF5QUt2NUhTalA3RkcvbTBmRnAz?=
 =?utf-8?B?bEcvN0Z0VVBxdUgvL0k0K1VKd3YvN2pBbXNlWExNNzFiWER0VmRmMVh6RUpO?=
 =?utf-8?B?UHBLK01Wb3BMVDh4YWExa2k5czBJcXFBaVNWZE9DVVhuZG5ieFdkbmpTWHl2?=
 =?utf-8?B?bS93bW9ZZVV4OTJzM20yd2YydWRDd2EzTHl3azVPSzN0a2lGQWN1WkdhK3JE?=
 =?utf-8?B?ZWVVR1lod2FzdFIxZi90RFd0ZjFnMGJTOUNma0loL1hhbmI4b0MxYmR2eUhJ?=
 =?utf-8?B?ejdzVldqekVNai94UHlUMEo4bzA0Y0pOa3k5V3ZBZkduZDUyNFBHUTZkTzZ1?=
 =?utf-8?B?RXVnc2lKSFBvTW5XdG15YmowMStheVFTWURBeDk0TE9zanhsbXZ1ekxDRzNu?=
 =?utf-8?Q?Q2TUS62up+gCNwz?=
X-Microsoft-Antispam-Message-Info: yY/mSEbhbNkGsrU/jma87TXkImcL9/r7sx4MWTd4lfBERX8tu3VtUp7Y2aaLXlN8TsYofBaCTgJxe/6m/05aJqp/L5jqtJzUW1xNGd52m/qbFtVbgbfVXmehXvJKOBEaKwLCzz4zTCeJQGiJDN1H3RS5J8rqq4ABul0AIvcr7UtWft2JqQ7ZalPX4XsBa6+c
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;6:EXCV6WgYlSBNsOfKLXT0ZmSs9/F020A5EAtctOYmj9ttSk6VO01/d3kOkqI209p3ljnkRk6bgCi08Cpgofhr4KAmw90VdNB+YAJVPR5mVKvhnk7qHLTsZLDd78uHn/sYp77fEfxxzrj1nujjozuDLWE/UAKUua8jM4s56lA+IiYvmqffxmdXVd1xx1HUpSfQ6057Uka45ztIcxN1BfSOaY2oAhytgZVLYBkAyiz4oUsQ7JXufYs9WC9QDcv+lBZCIRm59BbIfupGeukmsw5DptmnANqCcjrRiq8B/cj5qIXwZaqNr/uL7Vv6B307pChP+1E99dv5uLfQMUCusRJa9OISRs+SMJlYx7ulhjpUefAfK4qNYMwvVVKvWxye7ihiXdOXGI3GjjnPzorQpu6U521Wl8XF3a8JCVmvaCEXCPGtlHwZPIIm9E/RL0PRej5srB+wHkJzIsRuixiUG4zNZQ==;5:T4rDA2Wx4QBwSj6Ir4qbVJFlu2pzXEENF2Q9Clkl70F8sCkzKspu6Dv3ST07n8cQTlT04CurJKmH0HC25ouaC7xRNXC6ONlnJqLsaXSbbFH1i6HtVyWyojjMnxYRBSyOP95TiZ6vpYYWFVvZ3r4e5pU8x5baykvbMTyCbxMYaMg=;24:Ct3Y06d3VMzQce46Y7+E5OiOu1R1R1dOa3i/cxeEMCQOQVKjE7/lKPSh+EaurUxjxI7rAeQaxuBgOzI6Vuig8dHS1qN97J+e6XAXQDdpqO0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;7:UO49x15fkPFP9VbnEB//hsO9DqYChEuDh7FnltpULTNr7+FPxYGiUeT2u28r3xncKNNfamrdjk25CbHXL2FSgNG3YAVa1n6y5KQ6M4LnR68x2+D/ysx9e/+SaCwYack8A9gS4k+8maM1KHQNoQCd5KkjhjpC/0FCWN3dBsGwxj8JvbwrtBqDHuMj3rix8Wv6KzzJ7FF7Adq5wA9zWdCzypZeMXtpRaJhl/VOa1sTiMV48WB/Tkodm4RN9+BDp5yX;20:KMRtDDDyl5JAQDgPFYDioMi5stmgHek3ymEjIzzpxRwMh9qdXo8rlQKnJzn43zIzXjX5gbTjGenvOZ+dOxV+dAg/NbmmjIHne3FQRGj0M176nR6DAWTy5mZezlWt7sO6q5iHytWInVrF1LvxdT33jXKMUUuKZSg6VJQVWRluS5E=
X-MS-Office365-Filtering-Correlation-Id: 229cfdd8-2b75-463c-1d45-08d5a9dcea8a
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2018 12:14:22.7329 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 229cfdd8-2b75-463c-1d45-08d5a9dcea8a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1338
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598629680919684368?=
X-GMAIL-MSGID: =?utf-8?q?1598629680919684368?=
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
index 7b9529534e00..94d9884caf61 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1251,6 +1251,8 @@ static inline void memcg_set_shrinker_bit(struct mem_cgroup *memcg, int nid, int
 
 		rcu_read_lock();
 		map = MEMCG_SHRINKER_MAP(memcg, nid);
+		/* Pairs with smp mb in shrink_slab() */
+		smp_mb__before_atomic();
 		set_bit(nr, map->map);
 		rcu_read_unlock();
 	}
diff --git a/mm/vmscan.c b/mm/vmscan.c
index f57f2893d58e..aba3977cde3e 100644
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
