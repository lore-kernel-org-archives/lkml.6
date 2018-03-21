Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AG47ELuJlqXqJW8twWLgYyD00W+QPJYnnOIBJXQeMpQLzMwzsbuhALK71GkK+XBNWXf1DCo6SkK+
ARC-Seal: i=1; a=rsa-sha256; t=1521638626; cv=none;
        d=google.com; s=arc-20160816;
        b=YUyTjIjhOuzFncQDu1hdK0aJ4O2gGwIlkgouP7Id64fb/WfSYmbtk24pJnehGk/dT8
         OoL5tOLh5TgvKnbU2kspRt2BSD2mCmswBrIOq/9rFeZPGXmCi+vGBV6yz/7Xdk5XO7kJ
         HC/ByDXuosrqT/1N5WndsnZPA5sTbMc+Qj7YH+M/grNzU/K19MFah2mzZvWNbKuOvp7J
         jxJrmf6d9KPw04KEfF6LvQN5Dbp0R0vaSwPgnUsDALKHp1fPVaeYpNhLp3OHO1iRUmbt
         WCawwTHhcA59CroKAFzWvtF1s0kQCESV6lxkttKJBqAcUYJ38Zx625rkrGk7tNX4xkl/
         JV4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :dkim-signature:arc-authentication-results;
        bh=YDMbJXuwolQ4z8hnt8kSTyEuQZ43fW/jX3LDbkpSvuw=;
        b=GQZB7fcJU5PMyzpl5VXAEKqZ1eA7/hsCiS5R1Z6hEBnLFcpXXOncvr5+KSNphBNFHz
         8o+k4nSqcJxKwZesrQOHONpcNfuzgWZwkd9TzG5xahb1SYArwpizeaSOEJnob3p2hNqg
         9QGXgVNYTaWJHb2CejqAbbt+45DHE1pks48JI7UbVjesD4r3nkv55an2mpcUPdgsWj+w
         CEKCCMWdGcapyz9ehd3OEatUhja2RlJN0exUmpauXD2KDdyq/vgigoMxk9dhWXQuQ5v3
         cm6ntgdvuEZbAqJPYSdp+a8Lq+eh54EIPkaibXhMqUCOA34mHSZM050bSnEE8Pm8t9y5
         kLUg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=Aa/9frTP;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.0.128 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=Aa/9frTP;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.0.128 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH 00/10] Improve shrink_slab() scalability (old complexity
 was O(n^2), new is O(n))
To: viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
 vdavydov.dev@gmail.com, akpm@linux-foundation.org, tglx@linutronix.de,
 pombredanne@nexb.com, stummala@codeaurora.org, gregkh@linuxfoundation.org,
 sfr@canb.auug.org.au, guro@fb.com, mka@chromium.org,
 penguin-kernel@I-love.SAKURA.ne.jp, chris@chris-wilson.co.uk,
 longman@redhat.com, minchan@kernel.org, hillf.zj@alibaba-inc.com,
 ying.huang@intel.com, mgorman@techsingularity.net, shakeelb@google.com,
 jbacik@fb.com, linux@roeck-us.net, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, willy@infradead.org
References: <152163840790.21546.980703278415599202.stgit@localhost.localdomain>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <9e15217f-5739-3d6a-679c-740571091429@virtuozzo.com>
Date: Wed, 21 Mar 2018 16:23:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <152163840790.21546.980703278415599202.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR06CA0145.eurprd06.prod.outlook.com
 (2603:10a6:7:16::32) To AM5PR0801MB1330.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1365917a-52e7-46f3-d0a6-08d58f2ef6c0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1330;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;3:w457B75l2NnzUuvR1zerTqLj6wZqFJrZCBzGL74ZR52X5Zb+RaCz4oUtLbzwTWDVGdqVLwRS52R1LFEuJZpPWamR2PX7BL5dq9aGii6iiuhMWHbRiEBTqzMIVcwc7661wVoIWwjCyx0q4ak+0+RouGuS5SG7OVlCiTrXXDEYxY587Gg1Emu7qe+7mQ+XK//ZVNSL1hd5CSjH1Yd1So0eFerMcuuNJH5fJ5WY7PsPczFzrP8fw719/mB8IKWWHyPo;25:gEY8ktm57+scw8MPGsMINmv+WQvH2pac+XhWpTmbOLj7f5ltUu9yYai7yxSJdihKeKenoDwkC6OSWJSY++jNbGXiFe+7AnZcGDFXicgj1IxwvCvTPEy0kgizt4EHoyj1jpBCrP7UsNXm4WxDhQ4eu6F32FOgNHqnbGkUxnyNFSJ0J6dsJ4mJfIMWPLXiLhUT1EqkjdvA3eOxElPYXc0lefgj6hV24JznFwW97oXn129pdzEdd3d/9ZJficeoKyjuwQyXwi6szkuja1AvAFpo5tm1qPkQ24tjBILM7eRQMYtbP54VsA8dShbyDo+TvEsEifskVAQm3UBQGir0LHgmew==;31:EJuefdiyYN9GgcidXDdQ2/b0fAD3tXBUCZAhIK5V1tZFfkrhjfx5LksY+BA4aSkBBgpGCbgkBZLat1/tVxPvQQ1NJeyCiD87wpeba82y7iqEET0oaDsWjtM8i8UtP3v91LKZdeOGvbjDeMyy0PtBBfDjjqewKwRnRpAXPnu1Qr3rfBVSZ4PqbBkO4zTP3N01IrFEpyBto1BZpXOv0ouL+VdIfh+4og01HjMt2VldoOc=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1330:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;20:aoytbe/vDyfzWQvcHPva1DxqX0nxmTjBja/2uEWeQgYOC4ZG96f3/XoIqs9qN1v3hrGEdqgpO5d94ZefaNGAgDzn0aBziEvcwsQNqOgN7LjogReWh279VbCq5TcYBxxpS/VprM0Vj+uggxr1p/geocUaKmPr2PkTSjpApP9RvZEUL9f5NVsDixt54uttVdvDe/0ZRWxF3f/DdyQSA0ExMeNF52VrStXqOCoPWmKidldsfOUL3kFvEvopvdWmH2dfNOXd3IgDJ/JWDZbs9vESA2tWMNXbm3J/8d6p6JkIa65C5CJ3z0+iLO6U4EYofJ2MmUM2m0MOcCAY8DRUXZTBJ9HOiGO1vNxiqnwNwiq5MjxmquoKiaVizdx1Jxoz0GD+xUhv6z3JVr1GKiLaUxS+Ed94srhmqXyCvrcIfg0ZTY2Q3DeFWfXejHrQ/WmlvSEexT4UnG+bwKGBTra7VIwPwzWxfcC4mii2bJaHIdE9BZJ6/LuBU0QHBq7EJ9r+UhOU;4:SiMDCyM6TGQspjg+Cr6/yZL7CvzCm5DEP4NVXJPtsKOWyLVOxDUrSxL/WJq1lnTAk3k7J0dVqNXVsBar1od9xy35D4J3fDKihEMGrb0S5k/Jyg3muaHUQqvqjJ9vKwJlsmdpFePyblBtnCZVbzN5EvSjpIs13ZQXiBD8Qc84RepHSeFPtl+EGJLr70o4CWEXB2HMq33xwrbT3PP2FtO+7dxovMWW0QjVP5Oq/BY3Idjg2laN8y6253ILace59pIlxefJWznzngGVoxEJ+TpZIBWjVSkApGtqoH5kAx6l1N0AAjIpFglbTk6ZxIVBPRPb
X-Microsoft-Antispam-PRVS: <AM5PR0801MB133086C32C4396CD6DB3ED4ECDAA0@AM5PR0801MB1330.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(131327999870524);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501323)(52105095)(10201501046)(3002001)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:AM5PR0801MB1330;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1330;
X-Forefront-PRVS: 0618E4E7E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(39850400004)(376002)(396003)(39380400002)(346002)(199004)(189003)(77096007)(186003)(5660300001)(16526019)(53936002)(6486002)(55236004)(25786009)(7736002)(47776003)(305945005)(2950100002)(6246003)(65806001)(86362001)(106356001)(97736004)(6666003)(26005)(65956001)(229853002)(50466002)(66066001)(105586002)(31686004)(2906002)(52146003)(2486003)(52116002)(23676004)(76176011)(39060400002)(64126003)(81166006)(81156014)(8676002)(31696002)(478600001)(230700001)(65826007)(58126008)(7416002)(316002)(386003)(16576012)(8936002)(36756003)(53546011)(68736007)(3846002)(6116002)(59450400001)(81973001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1330;H:[172.16.25.196];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMzA7MjM6Ui9paVY2NndxZXkzMlVKVWZNNjRucmNL?=
 =?utf-8?B?UHZHNkVWMWhUQlpaVkZjcEpwOWl3Y1VKQ1dsYUoyUjU5elJwdEVnMm5CWUk0?=
 =?utf-8?B?U3JCREQ2K2JhbUhGR0IwcnRzQUFwMk5DMDgraW1KRHpCVWNwalFNSVorRVZn?=
 =?utf-8?B?bmx3OW53eTdRSktQYTlaNEI0ayt1WjVxZWpReU84aWxYMnRmSDVnQUp6VVlY?=
 =?utf-8?B?VHZMRjdsay9tNElkZTBhMzNQYWRXQkZBUUdjNlc1OVR4UC91Q1phNWhRaUVH?=
 =?utf-8?B?SWoxaW1QdXVWN2x2Ym9OeFJmdHVqYW15TWhvYkdwaDJHNEQ1YVF1YzZJTVhp?=
 =?utf-8?B?eUNyeDRNNkJKQmNrdDJlRFA3ZStsd0FtbVFUckh0UTJuaVZMenhzL1pNT3ll?=
 =?utf-8?B?R3d6SHdQTGtVSkRkcWdyU0dEejBVbmRLUTRsbXJmcm1yVDEwd0pCWXhBd2ZG?=
 =?utf-8?B?azNvRGpKaTAxTEdTV0MxSk9sRlhranVQZnlsWlZxUjJSWGMvdGF2TnpJVGlX?=
 =?utf-8?B?aVd5VnRJZ3JKZklSODB0azFNenhIeU1STC9mQ3c4V0F0dkJPcXRNSXBsZzJD?=
 =?utf-8?B?K2VaQnFhWWVUNksvUUd6Vnk5cUhOa1RiemYrSzVRcEx5Wks1VVlWakhrRjYw?=
 =?utf-8?B?ODAzaERMQ0lOUjlBalBQVWk0L090Q2hQQnJKZDB6QzAvRUJzZ0M3U3BEck8r?=
 =?utf-8?B?RmQwMmlORFk3U3JSZ2hmejhBQzJDRElQNlliT2prbnFPdFhzL0xZZlZ2a0pS?=
 =?utf-8?B?czNueVozd1VvOU9MMDVFZ0JpMlRnT3piZ0dDWEd5QWxWYlB0endtb3JWMTNP?=
 =?utf-8?B?N0RPZjBodEc0RGIwSEpockNZWUlibWh0R2JLcjJWNlYxVURvaVpTNTZuY3BD?=
 =?utf-8?B?OEdNMXdNUjBlSjlNT1NaQ1VnK0VaYWpxRHZWODZobXZyNzhWSmRBYXZqVmhm?=
 =?utf-8?B?UFBrS3lPYXdZb1hKUCtNcEl4c1hVd0h3MDJNK0tSWHV0ajh6N2hScWRWSURr?=
 =?utf-8?B?MFlNUmpoZFBLRXMxWjVqSVZwT2dEbCtTQVFMdnVNSStROHBMK1IxeFgyM3Ax?=
 =?utf-8?B?QWczWjdKZm9ubThsdGhoVmw0Wlc3ZzFnODdsZXpSREpBMStRSTlUV25nOUdu?=
 =?utf-8?B?YU5FUmZyT0luVzcvbFpoRlFYNWE3Q0RPZk1mSjh6cjlOOVNWbWgxU1NXS0g2?=
 =?utf-8?B?MGZEbHNtRXhEVFJzZVNKNVlsc3JySk9GdUJXbDFRNjRXQklYR3gydUtnVWF0?=
 =?utf-8?B?akVVS0xiWWFOMHUxMkhyRGVWZnIvVlYyb3pyK2toaEJyV0Z2dTlrd3FFN21h?=
 =?utf-8?B?L3V0VUJ1cXFYelN1emZTbEdJNThkbVozVHFVNkQ2UGQ2dW1WN1pqMk9ZSTVP?=
 =?utf-8?B?ZzNaYlhxVkJvOWlEdnRuNm4zdXQ4YTNYNnE1TDFpaUtZUERQdGljdzBVVEhQ?=
 =?utf-8?B?UUJERVprRDk5aW1mWmoyeU9aUzdWOGREY0gyRG9iU3hBamJuZUx1TVhxRTJk?=
 =?utf-8?B?Nk5hUnd3OTcvUXBqRDZiMUdldnZEQmdzZjl3MW9XT2ROdm14elUwM3k0SWtT?=
 =?utf-8?B?ekR6U0dRMzVVNFdNSkNSTFJuTnpES2RYd2MxTm05QmV4a3d6MkF2d1dMUzRV?=
 =?utf-8?B?d3RZN09TVzM1SGI3cGduM1lNd3lSVHJ1MFVqdEtuM3lwMWtOa3NpKzB3ZFlY?=
 =?utf-8?B?RUFVYk5BeVlNbXlCUndnQ0Zwb2dvcHFRblNvWGw4eVhyd1ZqeVVpdG44dUlS?=
 =?utf-8?B?U0hFcTNIY05wQXhXTnVkd3I2M05TZUhaVGJ0SnIwRjZoeEFVdUVpdm5Qc1lj?=
 =?utf-8?B?eWJNWU52d3lEbFZ2V1JaSXFtZWdTditPekJ3WCtFWGtjN0E3OTgxUm9UeXRG?=
 =?utf-8?B?SzY5citxWXFwNlpvbVd0eDJoNitXOFlQam1SbTBuUmYvNXBYaDRZdmxRbDlM?=
 =?utf-8?Q?Lc7lb94NJXibdF+TA7Vzr2b1TwmFLJWE=3D?=
X-Microsoft-Antispam-Message-Info: P9zxCkU1WDX+/YwIaUcL7tFKOAr3d6s4TYLh4yJ3nKzul9apa04L0zJF3bN9nvJm8y9R38AYgH3CTKENqnq+OFFOJq6evQ1ApNIE1FIsDZtO9T2T8+89ISK4bec6dNqGZ4h0c+Qi9EfB8HgdYkKfTOf9mhfSJiElmqH4I4HSgyoUnAwgborb76djqfu+cU8h
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;6:fZxC/X4en/32oMH/8dkHxQ4dKVgKWX/G/BS/Hz83FxY8V1fhiMP2KyLX4WXt1iFwlhWvcczl+TR+qc4j6X+E2IodH+ePxWXiDMemY71t02fpbjfrfZltygFqqEYKCVZZlYNhxuN/PiWBmtqIppSsxYNaZ2iFWfJDw4IqBO3dTqt2Q3Uc04/l0qIsWRi1h/dWXUr4RvDT1dDPioo1qS7ws4Jd+Or0SPXxRydsPTevBjNJ9ka0vqP92Ns4bq8Ln/2CBnmisz0mVkGl0mxmGWCHE7nnPmkjbhTsvnlfnocUZVC9tRa3ooKGqiTl7U5hRr9Kue8Ma9luGrILSCxpQ0EHb3KC92ZWTEyV/Vr3ltvOJrn8pwT5S0Mdsu5Z7+kDYiR/aHVi+G2z66Naur/pooiaBJcS7NaAZOKt94qUJO61SHWnfOXpzhWn9wJuT7idp7E4OfCRYPcpdX/8BOfjrFZteA==;5:rqgEfZUa8LJ2st9w6IgzJyhIFoW25ox+CDBntvvr4ffRoTLEs4TvRidBOoBwxVhPIVXv8FMTSU04b2zhUpo1sPDirCJ2DrSTsIfeZHwV33Vj2tgtWdlP+TadQcc2YM8BwvqRALZoxpvrvy/v5OH27yIyLJnYpX4o8JFpzfH7eaY=;24:ufK+Ok61nRksSp+FMaw80dk8WkxCRTkQaLAVhTZo+dUS3qSq832WmXzcgLBJMUlmOQi31ZW/FVyxpkXKMvPXC+bZUilrZ0rAjtjroei3FbU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;7:CettMcCJzyFASwuL2VHvl7FbLyBC6iLWMFB/4pV2RKaKvOz2FVk+BXqZpsmNEkaFf+04ia8KGlDqR3DKQ1HZ5DiIGcghih4TYZQaTt8IMmJu7Ay784llvHeo1BwIUnnMzq9X0CVCDCJOIoEbCVsgAxbH4XNmuXV16YxVf8xMq4FdZjw9TultQHjnNIGWzXAqW0OpqM57lbt83+FVgH7BVnZKCo6g9Ucu1tfjatS2dflCp8oXC2N9Sak1TVO11Tv5;20:3F92hm4LvNPO4LpojxyXAa6dxZkPlIqfShyqidIx7nkC/dOHUGFZn7rzAVS5XL72EDYm4EKkbPsusA+LRrLxH2YYKxtyJmI57Xp6MPnYl881v0gf/s68u3SiJKqHG88MTcKIyPhoHLOXtVeAsYQ2VhR3nXtM0Ez3Z1cv8d3XPjY=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2018 13:23:39.7172 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1365917a-52e7-46f3-d0a6-08d58f2ef6c0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1330
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595553585316029185?=
X-GMAIL-MSGID: =?utf-8?q?1595553744543117870?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is actually RFC, so comments are welcome!

On 21.03.2018 16:21, Kirill Tkhai wrote:
> Imagine a big node with many cpus, memory cgroups and containers.
> Let we have 200 containers, and every container has 10 mounts
> and 10 cgroups. All container tasks don't touch foreign containers
> mounts.
> 
> In case of global reclaim, a task has to iterate all over the memcgs
> and to call all the memcg-aware shrinkers for all of them. This means,
> the task has to visit 200 * 10 = 2000 shrinkers for every memcg,
> and since there are 2000 memcgs, the total calls of do_shrink_slab()
> are 2000 * 2000 = 4000000.
> 
> 4 million calls are not a number operations, which can takes 1 cpu cycle.
> E.g., super_cache_count() accesses at least two lists, and makes arifmetical
> calculations. Even, if there are no charged objects, we do these calculations,
> and replaces cpu caches by read memory. I observed nodes spending almost 100%
> time in kernel, in case of intensive writing and global reclaim. Even if
> there is no writing, the iterations just waste the time, and slows reclaim down.
> 
> Let's see the small test below:
>     $echo 1 > /sys/fs/cgroup/memory/memory.use_hierarchy
>     $mkdir /sys/fs/cgroup/memory/ct
>     $echo 4000M > /sys/fs/cgroup/memory/ct/memory.kmem.limit_in_bytes
>     $for i in `seq 0 4000`; do mkdir /sys/fs/cgroup/memory/ct/$i; echo $$ > /sys/fs/cgroup/memory/ct/$i/cgroup.procs; mkdir -p s/$i; mount -t tmpfs $i s/$i; touch s/$i/file; done
> 
> Then, let's see drop caches time (4 sequential calls):
>     $time echo 3 > /proc/sys/vm/drop_caches
>     0.00user 6.80system 0:06.82elapsed 99%CPU 
>     0.00user 4.61system 0:04.62elapsed 99%CPU
>     0.00user 4.61system 0:04.61elapsed 99%CPU
>     0.00user 4.61system 0:04.61elapsed 99%CPU
> 
> Last three calls don't actually shrink something. So, the iterations
> over slab shrinkers take 4.61 seconds. Not so good for scalability.
> 
> The patchset solves the problem with following actions:
> 1)Assign id to every registered memcg-aware shrinker.
> 2)Maintain per-memcgroup bitmap of memcg-aware shrinkers,
>   and set a shrinker-related bit after the first element
>   is added to lru list (also, when removed child memcg
>   elements are reparanted).
> 3)Split memcg-aware shrinkers and !memcg-aware shrinkers,
>   and call a shrinker if its bit is set in memcg's shrinker
>   bitmap
> (Also, there is a functionality to clear the bit, after
>  last element is shrinked).
> 
> This gives signify performance increase. The result after patchset is applied:
> 
>     $time echo 3 > /proc/sys/vm/drop_caches
>     0.00user 0.93system 0:00.94elapsed 99%CPU
>     0.00user 0.00system 0:00.01elapsed 80%CPU
>     0.00user 0.00system 0:00.01elapsed 80%CPU
>     0.00user 0.00system 0:00.01elapsed 81%CPU
>     (4.61s/0.01s = 461 times faster)
> 
> Currenly, all memcg-aware shrinkers are implemented via list_lru.
> The only exception is XFS cached objects backlog (which is completelly
> no memcg-aware, but pretends to be memcg-aware). See
> xfs_fs_nr_cached_objects() and xfs_fs_free_cached_objects() for
> the details. It seems, this can be reworked to fix this lack.
> 
> So, the patchset makes shrink_slab() of less complexity and improves
> the performance in such types of load I pointed. This will give a profit
> in case of !global reclaim case, since there also will be less do_shrink_slab()
> calls.
> 
> This patchset is made against linux-next.git tree.
> 
> ---
> 
> Kirill Tkhai (10):
>       mm: Assign id to every memcg-aware shrinker
>       mm: Maintain memcg-aware shrinkers in mcg_shrinkers array
>       mm: Assign memcg-aware shrinkers bitmap to memcg
>       fs: Propagate shrinker::id to list_lru
>       list_lru: Add memcg argument to list_lru_from_kmem()
>       list_lru: Pass dst_memcg argument to memcg_drain_list_lru_node()
>       list_lru: Pass lru argument to memcg_drain_list_lru_node()
>       mm: Set bit in memcg shrinker bitmap on first list_lru item apearance
>       mm: Iterate only over charged shrinkers during memcg shrink_slab()
>       mm: Clear shrinker bit if there are no objects related to memcg
> 
> 
>  fs/super.c                 |    8 +
>  include/linux/list_lru.h   |    3 
>  include/linux/memcontrol.h |   20 +++
>  include/linux/shrinker.h   |    9 +
>  mm/list_lru.c              |   65 ++++++--
>  mm/memcontrol.c            |    7 +
>  mm/vmscan.c                |  337 ++++++++++++++++++++++++++++++++++++++++++--
>  mm/workingset.c            |    6 +
>  8 files changed, 418 insertions(+), 37 deletions(-)
> 
> --
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> 
