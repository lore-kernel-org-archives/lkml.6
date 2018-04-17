Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AIpwx49fqRgDJEEDlZpLRozRCdu7tfDGfmJ2mCSWSsP718Qlt38p18N70IIAJtAKkgG29Hp/8zB5
ARC-Seal: i=1; a=rsa-sha256; t=1523980505; cv=none;
        d=google.com; s=arc-20160816;
        b=XX06GT6FsRFv00PJp5DB6h0QDu19RvIGR/rYpnjO/7hYiZ64TrogWitW6XSxwhHfJG
         Eh/S3Fhh7IW2QKx74HFOSYpyhDEUVCaaJIifKt7/ZKhYQFoRdhLQJGnNGdrKV/0nsPzM
         ocQWozCBAjKQ62suz5ipDwCxvh2eOdZFQdHonnLIDFkTOkGyYsSDZ6TiuZwp4u1q9mFT
         uHMSMDfnm4c3YQEOv7q+f0qhL4DMUPcQ11okm9PJ6nOKEaXFVoBbhQ8njAHRRjAmnkWk
         Rh0GfYNMezVaC6FPDOhVrSGNUK7WD7Yn9BtPXTp+Fjd4H8blYZxg77c2PczBBgokWit2
         usHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=f5GgLY/ZNqbkxS1fKTH8zJMW9BeVLWpCfzN6nYxaNfE=;
        b=iIbpaFiXu4opWP3smbpIVs23UPtuMRjBe8A2Yq2gGNEwq/mPVv7ckrR8cZdnbvAD5D
         Cn7xznoWHX7mJDv4uWJZ1ILwfsE4hyvbMrD7euDpYT/ZKBri0W87efHWI5YmbeUzkmLx
         apxjoKq+xOF6y7v9yqZ4S16gHvLB1mZb+BPyXLNgYnxhY68BqY2noRinnKnZO6yUVabr
         MhavMtLmAsU1VnwkLkTh3aPOrKfbilY9UeqGAwcoVAxLw4wttTMyi6+/nEBfgTWub1Aq
         ZMmlRSkixoRTwls+oTMyOhQCPSB9ANw3r9hfNUXR1Xy2mjlXX3ocy5xmWddmWp8NpX5c
         kovw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=ibivi/cX;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.3.136 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=ibivi/cX;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.3.136 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Subject: [PATCH v2 12/12] mm: Clear shrinker bit if there are no objects
 related to memcg
From: Kirill Tkhai <ktkhai@virtuozzo.com>
To: akpm@linux-foundation.org, vdavydov.dev@gmail.com, shakeelb@google.com,
 viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
 ktkhai@virtuozzo.com, tglx@linutronix.de, pombredanne@nexb.com,
 stummala@codeaurora.org, gregkh@linuxfoundation.org, sfr@canb.auug.org.au,
 guro@fb.com, mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
 chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
 hillf.zj@alibaba-inc.com, ying.huang@intel.com, mgorman@techsingularity.net,
 jbacik@fb.com, linux@roeck-us.net, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, willy@infradead.org, lirongqing@baidu.com,
 aryabinin@virtuozzo.com
Date: Tue, 17 Apr 2018 21:54:51 +0300
Message-ID: <152399129187.3456.5685999465635300270.stgit@localhost.localdomain>
In-Reply-To: <152397794111.3456.1281420602140818725.stgit@localhost.localdomain>
References: <152397794111.3456.1281420602140818725.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0802CA0005.eurprd08.prod.outlook.com
 (2603:10a6:3:bd::15) To AM5PR0801MB1332.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::10)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1332;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;3:7J9XsdRz85hRWhDEt/GIfO3RrsTFECfSqo+AZohXq74VlGZ1MFe2klDsRSvEBq8/pws/Vyf+bszZTAFZSlpXjKAl0mNfVjCN7r+OMoM0656+fKSlLbusy/+ggvZJVe1WB9z5aZWme9QRq0ZMQJuQ6gvNZVcQ1wnj5jY0nslUCNBvHHlh2Oyt0WIhXZ11X/stvAsAz3cy2SQ7F6hiJepMTAWETgBFbVMQQ5DhjN5wJ4rJyR8EPKbpxK8q5B715h2D;25:dj7raF16mPTPfmyEP69tZAR0zR1b3/K+4ceb531C+thiTDYPnUM+t3uK1h9TcUTU9MuV3K7WNM5myB2o8WajftSsA0l81IipdFUyPuCtuy1lpTfxcUO5Sl755FXkuckNAXtw5Y7F+hYYKv4eu1suvorkJw6SaG0XGWb7zTBU6r6/6e8Oq80V61/5THBeAwtRp25l27iZK92FPFLcDkf/bYrd2NWkpK1hn8rbATKas6O3Ok13IZEaWKFj/RqgNBJGTIJveIJ2HjNPm7Xy7v06yUO9dUlTTAucz3ke2JxFZGdIkmURIbLRxdwzwvbyTfhu5+tn9R4ZsjPiAHoBzi3WXw==;31:rPR8qvKgzs6I3DywGqNd4CjsrWCHBLE0/8JD+JoNIVH3AwLHhn3FGP7xfcuDYAXPu6o7nWZuCG85HjU4pG19JMJOLv+wu5ulfj/ucpuPIWjwuiJ9zPMo8TYf2qzE1tCx+G8kgrTvDuUI6ew/gDD7h5G4GL8qfQVg2iLDs/p9GXFSuyZgqyMR9BbTGFU4A6YvudQ9Hje3c8fUNXOE9LtErbS/PScISVuTuds2uEYIayA=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1332:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;20:xhjmS3jaO4gqJc3yd+DiX0ZYQg6CmNIFrnA8xJwKJYMLLbQb2y2ypjnicRLrXZ3potWhUHJkQIW/Gh4ybLmJsuGMvSpYxx8Upxqs5XvVo+MKjT/8Af8thBxp9Qjgly+imY6RDn3TXCi15bk1dHbQvy+OKFpXQd3xCGF3Qpyxd/yLWitJTBviXGSIC74aCw0NpE9U9NdhuJKfKpDKHfLSY0SfQYn+4w/AEHWxPAn+KN8aJvnhPyR+G1MC+R48bVeeEZhljh/pb1idKnOf9PlUguRRauS64EiUlzkU4qJdt+f6Go0uxL7AJ4JNW7lrkWGgPd3Q0sEgxoOVL4LJK4cFFQsUPnWJmn/hV2Ccxa0/lUiHgywPanHY/qznZieZKljCo+yNKUNH+s5iU7tnPM17u3uxW3kr0G3BLysUw4xPNX0VyGH9vufxtLn8SGrbB+Uik9WbrtBJW/bAXF8ZtiilyUISq7C8Uk5WXXeFhXuFaqOt1vaBrNzu2F/gPdCL24BZ;4:g9rkU+6RSvOC3RbonWL5ZVlUpitiBU8RAVEUMjJNewO7VJfdOzZ0sSfF+RA6E0i/FfiB66E0fLia1IQ97Ua8jHjarbDNRYF+aeTAU9J/gF1mZmnkdjN48pRzTzcvuV6NQNHOYdc8SGghuL/HLNPydWKgk3uHv0YjRFCaKw+oj3hF/hrwyRjwUk3O/qfyQH1sxbfNSwctVqpdeOR5XVBbmHZkhnbuaJIlytgUDW9sTzAPLC9b8wN+CA1U61/WbhNLbCUm20v98gWHmKFIQRig0Q==
X-Microsoft-Antispam-PRVS: <AM5PR0801MB133265C98A66D5050350EF26CDB70@AM5PR0801MB1332.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231232)(944501359)(52105095)(93006095)(93001095)(10201501046)(3002001)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:AM5PR0801MB1332;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1332;
X-Forefront-PRVS: 0645BEB7AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39380400002)(346002)(39850400004)(376002)(396003)(366004)(189003)(199004)(25786009)(230700001)(103116003)(478600001)(6666003)(6636002)(106356001)(105586002)(305945005)(7736002)(5660300001)(61506002)(97736004)(7416002)(50466002)(9686003)(53936002)(55016002)(68736007)(81156014)(81166006)(8676002)(2486003)(55236004)(11346002)(47776003)(956004)(476003)(58126008)(486006)(26005)(39060400002)(23676004)(66066001)(186003)(76176011)(16526019)(52116002)(316002)(59450400001)(386003)(33896004)(6506007)(446003)(86362001)(2906002)(3846002)(6116002)(8936002)(7696005)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1332;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMzI7MjM6aWtIZ2JXMnVERWd6TEtRUG94dFZIQndH?=
 =?utf-8?B?QTNhT2ZwRW1Kb3ArTUwrWEZMcmlraTB4UFM0Y3dML1lEQUtGejdRUEZ5U1Vj?=
 =?utf-8?B?eWtYSVU4Y3RmWCtWMDJCVlY2OERwdVZkWlJldDNsbGtuL01VNG9RRW1kTFM3?=
 =?utf-8?B?TXZPN29uNFRFbnE0SFkvaUNXNGFENk93dXpiemxGRlhkdndKdHVTY3ZPdWFU?=
 =?utf-8?B?OUZvYURRUExLT0dSSHpobmhuRnNQVU83VVRCdmpMK1p0ZjdqMUh0SFpUYlZ6?=
 =?utf-8?B?VmhnSGNLSnIxeG9SaFBUemZwWEFNSWJRa05vaFp2RWx0a3hUcjFjU01DKy9P?=
 =?utf-8?B?aldORlcxZkdTa1poRTBIWE4zWXJVUTA0eDExcVh0N0g4a3VJNW9vbHAwSGx4?=
 =?utf-8?B?WithclFJdnYrbElVUUdFNXBBbnkyMWk2cTVueTY2NkZHRnZZSncrdzYrK2s5?=
 =?utf-8?B?QWprUmwwUnV4bkVpOEk1d1NHTlRMd1Rqb1dpQ1MyZ1JVOXlqcHg2eVJGOXY0?=
 =?utf-8?B?dTh0WHppUEN4cjJWdytaK2NyQzZZamZUUk1DTURUemhnZGlERHpKUDliNnAz?=
 =?utf-8?B?WlRJblNlSGhmZ3phd2ZZcXNmMmMwUzFMZk5vejFrWlNwZ1E0RHhVVzFxL2dW?=
 =?utf-8?B?a2ovYjVhK0hJQm1GTDQ2NXY1SDRFd2h1dnlVdXZaZUw4SllUUkJkK2V5RHps?=
 =?utf-8?B?YjFOU1lVNWtBMzYvYXA5WFU3a0RIVmx4SmliZDRPaE1kUGZueDVnRG1pb2hU?=
 =?utf-8?B?UUcwYWlITC9XWmdBWXdCNi82K0RwWUdiM3pIZnl0Mmk0VHY1d3JsWjk1Lzky?=
 =?utf-8?B?MDZrcU9BWWFERi9maHlFVitMM2k3czY1RC9Ua3VGalA4SEloazBFMFIySzU1?=
 =?utf-8?B?M2FUcnFvMWJjZ3FhclpabXdjUUpyTlJKbEM2OTdQRTlKd1ZpM3ZSTyswNEVr?=
 =?utf-8?B?Y2NMVmZzUjA1T2tWd1hYbEw1aWxHeTE0OTNtYmdXaHI5OUFHeEl5bXQvQlZu?=
 =?utf-8?B?ZTBZTlBRQTRYeW10amZFWFFGU3l0UFRjVDdnV3pzN0lNQm0raDZDSXVoRy9D?=
 =?utf-8?B?bVBNVVBaZjdQYkhyMlllcjNOeFhONU5BNlNtdWM4K0YrSGJZV1FGVnFsRCtq?=
 =?utf-8?B?cXJ5Tm5qRXlDeXZmRGgrc0lBZVdQZ25uV0FieWFUTlVhaWJ4ZCtZdVhKVmVF?=
 =?utf-8?B?NktKMXVTaFZoZy96RXB2RXJiR2JXNENPdEFkT3RDRnZkcHdBckQ4Z1dGWnpL?=
 =?utf-8?B?dU1XVTl6SjBRN25SaFR5WkJTRlBMa1prcit3YStRbjN2cGdGN2s1TVZ1bm5J?=
 =?utf-8?B?VHFib2JzQitYOU1kVnJFR3dMc0RPN2JkODk3Vng2QlM3WjgzdDFDRWlheEkr?=
 =?utf-8?B?SDhkMnhzMEVYM0xVRm4rKzNaMWZWWi81N0xHSG5Ebm43Z3lUalhDN1JBTFNn?=
 =?utf-8?B?WWpnZ25udXJnSXVzdStHZXZaSUJkejBTUkpXNjJGVjMyQ0tRSGViYUx6VVNM?=
 =?utf-8?B?SWEvdENBZzgya3ZKRFkvcThBZEJWeFV6UXMvb0E5K2haSGd0d1dwMk5xV0NZ?=
 =?utf-8?B?ZVF2WUZFQVk5YnBuYnp4Z1J1NzA2UzdrWWQyaEVxKzhsWCsxUklGcWFhL1FY?=
 =?utf-8?B?WEVST08xYnhycDBYY2VRTS9JR254TjlGS3NWMjlyOW9zQnMwaHNTUHhiMmFQ?=
 =?utf-8?B?YUx2NmV4cHh5VC8rQ0xvTDA4M3EwTzZQc3BVbXB4cU9hZHVrc3lqQ3ZOK0hJ?=
 =?utf-8?B?R0hHSkJ1OW5RcUlyTGJtaTVDd0p2eW9pY3lza1hwdlVHMjFic0xrYlIvbGJv?=
 =?utf-8?B?NnVCSHpjNCtZUWlZWlRCWkF3a2ZUYVgrdWkrQkVYeXorbmIvUT09?=
X-Microsoft-Antispam-Message-Info: OpL407HnulCXiZ9Ek9Gk46/Bm9k7nc9xHaevuMpr7KV8cWL7NO7nLRhFZKuxs2S4ByJqoG6WdCmi4LqrYFL0CIz1X8N8B2PqXqOgiky+vwK+iiSKszPACFYOw70Wsdhv3mHNcITDbbZ2SGyHLzlsyeaquSLFPdloNnjQ5fpUJy4tUZIVxvsoKwc5hJJESm6i
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;6:VOnVzERS3Z+mrn33razBL/RVJWfgu7oSlho+liA/bpu9ue2tlECLDiBnH38KzByJl/0tYtao7fMiuGIxzgmoICoa8afbtuCDf/grU9fWpnVn58ONM80luvv2Vf4sHPcNpl+ierlLlX9Dwrq54RAlqGtWkkY4ceF1im9+mkNMREFs6/0juy7hkZ43qHQvcjNxEpuzrjgAu6aoSYj9V43/17xjGu31AIQrzSSAiqgmDZ5T0AtE1OkQCEJRGb0ev/Wu19YT7U0TULoeyxTRgsniXB32i5iLGj8cOmEDKtWXaVyyDmAB8eBfCU7v3hqc9P5dv93qweG55amW7RbTGGwKS5/ulUMg8KG9kH0b7CjpETaolkHukIr8cD+vkS2Nc9jE4acFEoIFcBXog+b9dPsHr64TYeI4hjysh0Pixwre2i2m2jkFU3F7WMFy9dg5iorKvaqzASr7n4DD7gbb43ipog==;5:NvO16aQ2WGD80GpQLmrGRkWKaloFxYhj0Yh7Eg+x4fWWUS7eTouyEXHhiUQ3XNZ5Bfs6zlUcG18wt22uXpzkdM3eAW5akxrsgJoX9BvoSGwobp0ZOrxr0AwbNw7/B2OSuDOBwUZuyYpd8ll23pdHwDhfgUfGwMd+x4IBfMunjqg=;24:5ptYQ0bWxZSB6pV7gBcc9pjObnCZHXywfSXy/OyJ5bbeOxB1V4j2/QOZLQ2IS60AxFfY05TnPPHOqbngQ0TN5khFeSogOEPoqk3VJpzYEqU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;7:H0PYfMtQSdTARDTsS5Z67zLQGOzrTrm6L1p7L1cIcfHoUxytmytfnnZKkulR+hxlSk8Xl1JO+7i15j8HgcpL4E1g4ZhJswfGzfQqrAzliXAoUIGh3Qkske3TSE+0BViUrooMKE3sIEAzFpxnw7PhFB6xA0SZglx9oc2gqViaofqYnknsCPWZGGfzpP8MrdZopey4bfuusFb0nSyCuZnQzgf7wfZXbpg4GeqqRI3R2aaqnZ8W9bCZcNDNqXo39cX+;20:VsUI4kWtVXhaxTd2MAuZcmVi2UJBdMwwtz98AxTIu0Slxy3BZ0SQR44z+/OESsWZS6csQ3i/n+SHxWgWExqR1LQ8myKgtKFoCZkp+SFV1shZ3SzO3HS/tdvcP20TE88DA0t0mWFpkSO0w5aZA/RU3FEYLwC1lPJX4fxTnZlWevc=
X-MS-Office365-Filtering-Correlation-Id: 2613c98b-4cf8-42b9-50aa-08d5a47b944c
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 15:55:00.0999 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2613c98b-4cf8-42b9-50aa-08d5a47b944c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1332
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598009382637676470?=
X-GMAIL-MSGID: =?utf-8?q?1598009382637676470?=
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

Then, 4 sequential calls of drop caches:
$time echo 3 > /proc/sys/vm/drop_caches

1)Before:
0.00user 8.99system 0:08.99elapsed 99%CPU
0.00user 5.97system 0:05.97elapsed 100%CPU
0.00user 5.97system 0:05.97elapsed 100%CPU
0.00user 5.85system 0:05.85elapsed 100%CPU

2)After
0.00user 1.11system 0:01.12elapsed 99%CPU
0.00user 0.00system 0:00.00elapsed 100%CPU
0.00user 0.00system 0:00.00elapsed 100%CPU
0.00user 0.00system 0:00.00elapsed 100%CPU

Even if we round 0:00.00 up to 0:00.01, the results shows
the performance increases at least in 585 times.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 include/linux/memcontrol.h |    2 ++
 mm/vmscan.c                |   19 +++++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index e1c1fa8e417a..1c5c68550e2f 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1245,6 +1245,8 @@ static inline void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int nr)
 
 		rcu_read_lock();
 		map = SHRINKERS_MAP(memcg, nid);
+		/* Pairs with smp mb in shrink_slab() */
+		smp_mb__before_atomic();
 		set_bit(nr, map->map);
 		rcu_read_unlock();
 	}
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 3be9b4d81c13..a8733bc5377b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -579,8 +579,23 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 		}
 
 		ret = do_shrink_slab(&sc, shrinker, priority);
-		if (ret == SHRINK_EMPTY)
-			ret = 0;
+		if (ret == SHRINK_EMPTY) {
+			clear_bit(i, map->map);
+			/*
+			 * Pairs with mb in set_shrinker_bit():
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
+				set_shrinker_bit(memcg, nid, i);
+		}
 		freed += ret;
 
 		if (rwsem_is_contended(&shrinker_rwsem)) {
