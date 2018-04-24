Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AIpwx4/gmjN85p9m6qERyUTfH6Oddzp3kBdUoDyHKD+UmDzjjtbVunFk1vKmgrg8F0JRRAmRIkZ+
ARC-Seal: i=1; a=rsa-sha256; t=1524572047; cv=none;
        d=google.com; s=arc-20160816;
        b=vKrDs9TYTUoTW1P52xj7/Mzb+Eog0YrYU2Z2i+xUANcxVr36L0ROGqXt7340eQtnTC
         pdamnpIq6XPLBD/MfX+xT78TJPU6gYykNbwQenI7g/9PglUua3ymZKiKCmbxDH3yyCyQ
         LEJls69LSHe5N/MUIznfYCkyRiO1+XbzT5i3iaiBWdvBkiJyUX7Rr97gOTV45bi8ZPdH
         K0QNIOukLIgaqtubWjjn1VYwaqStV4go+ceNFgmpKEvQCvUF4z+85P1TfV30KkPnKbrx
         gsRuzpQiD+HFxitVT9Bs+uqGxX8QpqG2K6+uttWxoCHCEkNFJaaGFl3kIxR5Nm+Xq1Kw
         l3Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=A9qlOEDg3sxPHRZNYtOP4/Z4MmnjMBjPk67G0CkQHkA=;
        b=YQI9H4TkBWp6TuwSzluPp9Ueym/Zw+FCIyzBgl/0eJv3yFxuOMIEISoiul8BolGJmA
         3Ro3I5ZMIQJZTPx4qoUq/bLNC/HoahAcnB3DvHnO04MkV9ciQHu4xwVaqSAnHA+JxO5F
         3w2DQ63jsi+jyMFNuAWd9eggb8hU29DliyCq4YUp6X+ICsBoGN694BP+0GaV0GD9Efts
         G+rMaMlO2c2YgrfXS5tDxuHKUbuZ4P27diaNzug5Pf4602/3wSiSc9KMBCbYI3sLjfj/
         XHL6tuWD79OQYpmsa6rqTBxHVGIjUxv9l1xs7MbSInh1MzAJpgawlgIzm3RXi9xBRS75
         slEw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=KV82Kghv;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.2.127 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=KV82Kghv;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.2.127 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v3 12/14] mm: Iterate only over charged shrinkers during
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
Date: Tue, 24 Apr 2018 15:13:57 +0300
Message-ID: <152457203733.22533.8463847438320204068.stgit@localhost.localdomain>
In-Reply-To: <152457151556.22533.5742587589232401708.stgit@localhost.localdomain>
References: <152457151556.22533.5742587589232401708.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0902CA0037.eurprd09.prod.outlook.com
 (2603:10a6:7:15::26) To HE1PR0801MB1338.eurprd08.prod.outlook.com
 (2603:10a6:3:39::28)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1338;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;3:3vN+OKlcuf9z/CmOIWldqlgN4VtQt2yyyAyYiZJrVs0nVvE+gl9H785fWBeDxWC3tHlYPYY4jNqwcnzfIO9cVWLcmCsupcLGGFBNh8Svvf7GJgUJqySc/w8ZRzQPDXQ5CcJaCxaJWTWp9J9xCIYC3jphlmUfBcWaes+JyKbfLcumJHECBSOkNp2TM6rpPj1oDvOiN5Nzxg/3XlIlBV5hEfg53bO2Oy/sDg3/OR3hnwqfHipI+RMIMUNtPsR44wN9;25:eU9J1HXVprRNJYQmBI54Z0W2bUp8Yj6xBKq6fOnRLYhg5wjrEEEJwq6BrzD6X1BWUJ5kEmr3L0wDUW8MIHBuGDv6FdcRfPhNt7n8A7v00y1a57k8sbUjRtky888TrVkfsboztZ2GSphWfNephXm3tXbU8R7/i0KlUTDJpVKhjfy4CaX4OwCc0HOWffFlGRiQRy/wNEDhlshiRjqmj7AdkAbu2Kkrd7VZ9JoPpfb6mVPBP58J9vqF2lEj60C/8vw1tqyaMei467Psjz0FaDstLQ7183wH7/sY6ebAD6iHnt8fKyozE+wCscFdkbmPckaW759D2ra6wn46RZLssGST8w==;31:V2RXUFSETW82FWVmAKoXjIf5PYoWEXZqDSSotuhq6JIjsKKnN3V6DG3ChgMSA+0htcrSjF/V+qM5Xx1SHa/9TqgjZuWQO+3eKW1mNqkzD3z0Y+lj3nED64OE37SD5ZDwbEhlrDqNYZ2R3ZN/aPhfmlf+O92o2SA23UrqVvG2LL1XwWZPhfus1tLeImwgfewCaBtw9eEkzM0JM6xOEJgk2zkwU1Vwf398j9rHRsFKzts=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1338:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;20:ypZQFL01k0XrX+j8V4iCqiqBq+k2BGbnq5D9oNRKq07xThEws8sObffGPHyZWev/wAuEhPE0biWkzkO/u+g1AazQ3tDXorjOgKnVJKWa1WPQ8NoS+soD64iFFOWMeAwghbQ1vWv/hQxTmYdTLnTasFv9z29ALby8jOZxHODpPUYh8fXUtKLCrSOnXBQswmjR1SNO5XDRzHgGayU3W13hK9QXmM77UxdiZn3xOvlIkuRngGQsTEyCaO9M439UNIfoj8i2thhoGMuvC1p99Y9zC6mnVtishqeKQBcbSaaMtZ3JLkrD8FUcaHhoj4bJa9U8fR0B8e9x56m8uxUouPl7beYHps47Tml4huwQUyv3dI043rqQg412RYaJIw0pbDwg6nJeuP8nLLNyfsXZzyt1VypruXoU9CNdy085f/E11S79ZW0xAXEdkRSb8yNfMLJy3OrQ4y5Hf85gYDc1xb5fUmydhZJM/KlGbUr9DcziwH9QSFVoBq1LCy6DcQrdzJkt;4:udYqBLziN4lXRdQVJrwmIwALMjqdsnO3DnXWVG/OnDRdM+hmCrIO9D56K6JmidIEDtOQlmVdPbzH/63bjkfXw0FjITYFoK0opvx7k4KmpvALyI1m195OaD+AeOqRPhtTudPOY55UjsYo6Kqg71KeI/aCgRaCla+9N+FxDEM4B7qTxegGacYkhjWlskgv7Sf/75BwFXMiD/i6Dm7CIKDI3ZvcQxdPCfu46tW7vF/Q194mcsXpwdttSyizRwf68lZ0BUGXPX08SYXrS0RJtlCe7A==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1338D74AA9F37885238BF77FCD880@HE1PR0801MB1338.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231232)(944501410)(52105095)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:HE1PR0801MB1338;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1338;
X-Forefront-PRVS: 0652EA5565
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39380400002)(396003)(346002)(39850400004)(376002)(366004)(199004)(189003)(2486003)(59450400001)(103116003)(47776003)(478600001)(68736007)(386003)(39060400002)(6506007)(66066001)(58126008)(316002)(7416002)(9686003)(76176011)(52116002)(7696005)(2906002)(55016002)(53936002)(33896004)(25786009)(97736004)(81156014)(8936002)(8676002)(86362001)(106356001)(55236004)(5660300001)(61506002)(105586002)(305945005)(7736002)(81166006)(6116002)(230700001)(3846002)(11346002)(26005)(16526019)(486006)(50466002)(956004)(6636002)(6666003)(476003)(23676004)(186003)(446003)(921003)(1121003)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1338;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzg7MjM6RWlXQ1AwMnNERmFkT1hhUmJZVW00dTNo?=
 =?utf-8?B?Zm16MmtEdEJDeWU0S0MwczhkcmlENHZVRHBKYXR6a3dyeENQWHM5S01ycENp?=
 =?utf-8?B?MitvNE91ZnFFejVVeUtrbHk0b2tSdmx1aEtEc1JrRndDWERZQ2pnVjlSTjQr?=
 =?utf-8?B?eDJBK2JFYnJhQXlTMHFIOUx0aGkrMW5IUVlNd0Fqa2hQclltdzNOSWxXZ0lq?=
 =?utf-8?B?ZEtyVUxpTEk1OGREWUp3cC8ySDRGNE9NdmdPZjNvU0ZISk1vQUIyaDhCMXND?=
 =?utf-8?B?b2pEa3hrTmcxZDJoa3J6TkNNc2lDeU5WMGhKNDZqbmhiQXhqRjUwb3NFZ3R4?=
 =?utf-8?B?eCtTcUx1bEx3MEd1UDVVTVJnQ2ZJaXYySnE0ZE1JZEsyaEJNMnQwaS9XdTRm?=
 =?utf-8?B?NjZjYWhuampCT0hjL0Zjd05zV25nelJoQTJJYmxWNk9QaWRnRm1lMnVFVWdm?=
 =?utf-8?B?OWloTDFNSTA4OE40eDJJSHQ2RHNnRGI2OFhkZ01GeWlUQWNld3ZjQUdzVTRX?=
 =?utf-8?B?Wk1VemwyZitiS0NzWlJBdGw1eVF2dWEvTXFCdGplSzZqTEs0RC9MU1FjY0po?=
 =?utf-8?B?M20ram5zT0hnL1hNbW4zV1RuQ0s3UFNWU3ZJSFNsRXN3MFpTQ1RVL2ptbFJi?=
 =?utf-8?B?SDdXbFJBL0ZwTm1XNmgraDlOd24xTEtSWGxMTzlWN1hnUjJLT21jTC9ONjkw?=
 =?utf-8?B?QUFTd1k0N2d3Q21CejhKQUZWMm9oSVJXVlQ5WFVXclZONGlzYVlLWHNtclho?=
 =?utf-8?B?MUt6YmprVGxMd0hLa2UxZ3krMC85ZVJkUUdlVHc0VzZVT2JEVU1sS1JGOC8y?=
 =?utf-8?B?TnpBOFJGeW9DQVM2QlNNdTJXWVNvK2xudDQ3bmhkaUlTOS94dFVMTGNSNGYx?=
 =?utf-8?B?d2pZVEllYVZsWlpFaHRGcU5ZZHhncEZSNTBIUThwTVpFcUM5ZlFVc2lPTUg2?=
 =?utf-8?B?WTl6UngyUndHQ1F4R3dsam9XeXdBZU1YUkgzV2s2ZVlRTDV0L3JQQTFDTGZ5?=
 =?utf-8?B?SUdOMzNKREMyMUZlOHkxaWJGYVhTQ0VqRjU1MHdGcmx5L2h1dXROYVd3RHcw?=
 =?utf-8?B?c2g0aVN5QWZRa0QrQncrZ1czck8rN002NUFnZ3o2b2lURTlyVDI0UjZJcU5z?=
 =?utf-8?B?eTljQTc2Qmo2VlRVWTFleHZSVzZ5YUNHYStraDlCR2M5UkVlMWpNdDEva3Yy?=
 =?utf-8?B?Y1MzYmdYOWhIUHFyMzRGcXMreFpmZTc1ajhTdEwwMHEvWUJBYlJQRm9ad2tQ?=
 =?utf-8?B?dUxoOUs0cCtoWjA2bUVFUGdQb1BmS1p5WWlXTDV4eWFSL0ZFTnVLOEhVY3Ju?=
 =?utf-8?B?UFhuV1c2UzV1U0l1VTJUbE5nZ252NkZLanFDYjM4MnZPRW5FcEdqVzk4eVBD?=
 =?utf-8?B?cG0vVXdURDBhUjBIUmcvWG9YN0c1T0VJRHpYM3JXK3F2UHlkRTg0eXpHYTRS?=
 =?utf-8?B?UEVzUXFKZG0zNHMxeVk5NkdUK0liNU1tR2F5WDdPTThJUWVYSlJ2aGd1Vk5S?=
 =?utf-8?B?dWg3bTd3UE9LYTZBYW1aOGh3RFhKSVg1d25PK2ZINkdxWmNVSnNiYklYbk8r?=
 =?utf-8?B?bXVVY1dxTDZreGZjN2ExRDNRNnUwVDdkN0xaRDAwcWpXcVJubThLaXpTRXZB?=
 =?utf-8?B?Q0ZhSHM3Mm5YaXRkRHFpOVBkdmNBb3drTEJaSjJXWFZxS2pDbURqV0o0UWF1?=
 =?utf-8?B?OTZIank4NTdldjhLNEREL1dabFpBOHBkRTZQbFE5cCtiSGQyRFBaTFVYWS9V?=
 =?utf-8?B?MitEYkRoOWFrMTVOSTZHbEY0dGZrdzZrRTEyUXBtODNRZXM2UmhhOXgyVUdk?=
 =?utf-8?B?ZnFvbVRlZllURGJXclVFUmZ3eGNrMG9nMEtNUEQwZTl6MFdFSEpDS20zNEdE?=
 =?utf-8?Q?uTWZwG9r8H9Rs=3D?=
X-Microsoft-Antispam-Message-Info: 1BhIHfereq4JgIEx6yf2lsiPE+QRhKAsPrfutCe/9MOo0fZLVU4g4A3PPMYTDDDQAmvjb+JOoAs2ZPafirmhoml69U9ryamp1cCLqJLgxipjZgauk/PsfB0vNqeye5E96NWJ0VtnKI/uG7RRyCkiRrwoYpmhyazLpte+aJvY5J3+Ug0+utRWpFE9D9/V3cMw
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;6:JU9t0sQ9qL8jbLmE2wd026HtDTsq24NNRCno1vG4zE5npnBYj10yDrSYR5VU6qZ4JogbYPAEgQdrmlKp6EDdQQpSTfWG3LV2SnJ6vAJxtLu53po6EBVSast2X9LXH39zVSKDrSyCgujHOijSpM91xu/SDyNcYTr/jNcPfznj8EiWFCbkU4QRl/n7noRrRTyhomqmcdt5MhU0nDzpKoNJM3weuLa+ZfHUH+eMnAz0BMgjUdb3jeE8ke6lL/xP6veCsIAEcBtr0xFk62Kfyyx2fBt78L2+KXtxC1BYjJ6k8Hztrdtwl3VrBAk65MFFdFapFuApwhyxCCeh+ZQjetkbRROacZQ0ZJCXxFiIq+r1hIGHl3BZ7twn8UJex67UVJZEIXfqH48sfGTwNsoM2cg5opNJ4zDx+y94gloi1E6odjTZNai85ZUBcJ3Sgy6kYZLu+8eCaEVTYyGyzVtYjZclOw==;5:OsQ+PPxSn9mF5vvWD4So1y0GsmYe0siEV7jTAZmtU64wUEO/oWNxgWCayQefsmk1JEmdn89d5GHuoGBHGiec+3zyHuqRcW/CMlSTsGkc5b72RACl2oTKlDGeL//7KXm1ntyM0mFaRiLyLdq/XfoXWSOyqUjoMWeZ6QR7OW5NDmA=;24:vHBC0pKUPt+OV378Vn8jWQNWc0ttpyemlMqDP4ETr41XIDQZ9y7jH3TM8+GCzUtbVVSyBx3n/Am70oYSc8LJj87ofz8wwyFZwwq9SEvwxKc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;7:nAIKTi1pq5A/j4NkLqIQmQLU5LQDa/IOT6FgfKuHEhoBZiTsy3e/H/8vcU+SL2yPPZRg+J5thO/Yrb4obr0m0dHXuKYdmRSzgjf9YFqdq7TuWCWntfbkfHPNeAgFqHgTxsbMUgtJBRfClIQBZyQnj05KlDgkkQxk0V/GMQIpe79jueQ/GiP5mAzRnrM8OEtbMxF8q6TdYtUUnvDsADAnc2FBic6fl2aPZlzXS6Lj9axyrPdVXrlEPPqnyXg+i+cC;20:0TG+6DKofZxp1FTgdRbs9YOvgDlvtinuMo0pZnHJbWGhcXcQT3B367Bl8ioTz9rsY2YaM3TtFZ7uqWfmn882OyADuxt4/blAzOBaVUKzIeNbpUlYv4ibwvxfXedE1LHXqaOSXBQc9gv75NJkOQDTJsEUo7aMiTMP+TSQuk4k1gc=
X-MS-Office365-Filtering-Correlation-Id: 27fb6726-7fb7-4204-8c24-08d5a9dcddd0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2018 12:14:01.3841 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27fb6726-7fb7-4204-8c24-08d5a9dcddd0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1338
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598629659025697199?=
X-GMAIL-MSGID: =?utf-8?q?1598629659025697199?=
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
index 4d5af7e399a3..7b9529534e00 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -755,6 +755,7 @@ void mem_cgroup_split_huge_fixup(struct page *head);
 #define MEM_CGROUP_ID_MAX	0
 
 struct mem_cgroup;
+#define root_mem_cgroup NULL
 
 static inline bool mem_cgroup_disabled(void)
 {
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 5f30e33faed2..f09a6104b28a 100644
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
