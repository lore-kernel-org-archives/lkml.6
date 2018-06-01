Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751972AbeFALau (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 07:30:50 -0400
Received: from mail-he1eur01on0130.outbound.protection.outlook.com ([104.47.0.130]:45463
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750795AbeFALar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 07:30:47 -0400
Subject: [PATCH net] kcm: Fix use-after-free caused by clonned sockets
References: <9f485659-6d6f-9047-b9ad-b0e4084be88d@virtuozzo.com>
To: "David S. Miller" <davem@davemloft.net>, ebiggers@google.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tom@quantonium.net,
        viro@ZenIV.linux.org.uk, Eric Dumazet <edumazet@google.com>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
X-Forwarded-Message-Id: <9f485659-6d6f-9047-b9ad-b0e4084be88d@virtuozzo.com>
Message-ID: <c1d76abc-5d6f-bd0a-9c84-1c5ed8119e8f@virtuozzo.com>
Date: Fri, 1 Jun 2018 14:30:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <9f485659-6d6f-9047-b9ad-b0e4084be88d@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: AM6PR0102CA0034.eurprd01.prod.exchangelabs.com
 (2603:10a6:209:14::47) To DB6PR0801MB1334.eurprd08.prod.outlook.com
 (2603:10a6:4:a::28)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1334;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1334;3:pojj4b0soi25M1aMwzrrsMzJr8PXfPMdZFbolPAak0WFII27B2DbP0UW9ulP5arv7igGJMGHOSgnv0kzw1SsI4JbE5xn5O/vIAc3QSFpA28jHNPsF9z2LRYQjB1xbXiujBh8HMtGBhStSAOSQvuSe6TiktGv0ZlND3aboZgJPSfTqV1LWyf/qALAsZEi/vJLntGi0yxKMON899g6RKnOn7Vp+VVq902ItQU8D9mwgOxJ9kMWAi6dvp7kOy9Phuzn;25:8fhlgckXhIVdZzBxs8qsj6kVh9V1ol30xMIDbM31nEmyKL2BZmOfY27rTQp/DeiukQ7p1KJmrFoaPqSk55XqJSeB5DFcjipAlA4w7I7sNAlmfXD6ma2z2A+v78H2Z0G7eWvQ5SXZEJjxs/BgPHIdPW8wvte4aNkk76YXXJbX7jE04vPk83YpstmBVM3J87/4dmAd7H1AQNN61gdBaorLgIXJ0pyqxLl+VkHn2FdnHhlgPE4nhWy9uzy9ZWrAGL4UKkTTK7wd6VGQ/VpjoD1fJptdmYNwHmVx6AcCBFc9tM4CN3rc2b927rNxGvt/qD60lyQCdVAKbT0r1MAMlqhxLQ==;31:WGCV9d4pEYWeqJN+ZGchLWsgZfr8Sle6ELuXHj8Y45/IUhk5TXj+7dZ+j5uH6p6BP0/G/3+eV+Gtq7y+JSbeXmLxLqCKotJLOVtwnhaxNqZ6nQu8VlAEPP8rPGhlmhnX5OIMDFbbmlll9IaxV5bVg1LLdcZWyO9aLVqD1riKBq0jhypdFMomsJa6gSEsMjI1wQneXjx9h/Bg2wSbInPFEgaNO/++nn6hEaD4vZiGlB8=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1334:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1334;20:BGc+9m5E4n288bze898+TrQwPoGExY31Vp0lfE+7B0xL7md/9ECh5tv/PmnuzqjZdGzOY1lZ/og+VAiZlpA7HwYFdkbMnaFEYF5NLyUGo4KaTdABjFTw8xb7KkodEO9A95D9jpuQz9d2nVJ1+N+ElEPE2tZKxKc7x7dG0wyo5ZPWUTqTdfGq4d107zsrv3uJqMKS4C+nWvHAoKv1LG/bxJzhIYyrVC2yLHEkZOgd1W4hXD6qvB7Gi1yzAExDB5FFt42lk756UjYgB6rDk89zpzZBYKJ5Ykiug4ieDkqvu2QZSVmoLPzxlyVjDIhdHVi9RH2cWPX4gc98TW6PBpQPldNLw96gwtnBZj0iKQ8cSVJx4BEiQe2L3xE1KVqgeZ2AkP2jDqai+aT5HrcycAJw5RNCPtNiuR77+ckjSg23tj5dSJV/ctwVm3PwDw14qXg+eAnlbHHPhv0e7Wk2AfmlOD/2+Ia8ACVZ1lU84l0Jjm0NjqZ9zWPD0vRmdbUVvL9Y;4:fj8lijRyvdGhRfPOBvuxttbeVMkwtPjahZ+zfpivZud56MOfEPuupD1pVv8+wsAiTj94GJMKjvCHCAEHQ3gFy2Wk9Soq4CFFIzQ7ukrh0IiUsJVDUfDkxTcEkzjd/AbelYlW5tVD4lGvsmWB/vnqmOZuKJ23MVf3y0xJ660VK7/fC3faUvqX4qri07q5UEnItMafQUAgzBJpEvA5BkWA3x8sy+zNUJEcDuR8vw88LTk+wtRnFFYiIHUMnTrpM31iDFelnkhUzYEiXIMT8DmUnQ==
X-Microsoft-Antispam-PRVS: <DB6PR0801MB13342B7F71ACAD9BD394529ECD620@DB6PR0801MB1334.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB1334;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1334;
X-Forefront-PRVS: 0690E5FF22
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(39380400002)(39850400004)(346002)(366004)(376002)(199004)(189003)(3846002)(11346002)(6666003)(478600001)(5660300001)(6116002)(66066001)(6486002)(65956001)(65826007)(956004)(31686004)(105586002)(64126003)(53936002)(230700001)(65806001)(476003)(97736004)(2616005)(25786009)(47776003)(31696002)(305945005)(8676002)(81156014)(81166006)(77096007)(52146003)(2486003)(23676004)(8936002)(52116002)(316002)(76176011)(26005)(68736007)(2906002)(486006)(386003)(58126008)(7736002)(106356001)(110136005)(86362001)(16526019)(50466002)(446003)(186003)(16576012)(36756003)(55236004);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB1334;H:[172.16.25.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjEzMzQ7MjM6TFRoS2paL1dLMks2Q1hmVDYwSXZNcWpT?=
 =?utf-8?B?eVh3YTU0SkRqR0QyUC9GOUUwUElJbW1SV3NLSUlSM3RWSHpucjBDV2RkVHNJ?=
 =?utf-8?B?eFhzQm90ajBjVGNVdVUveW9qemFTUWtLaHlITEZQcGhER1htdzdHQi9DYnAr?=
 =?utf-8?B?dElSa1psWG5oVVZ1Qmxxc1gyVzQ5NmhrTWJ6U1UrdXAya1NJS2RJWmt4Q3JO?=
 =?utf-8?B?LytwaGFyN2NDV3Q2eVRJcXA2bXJwaEcxUWk5aWUrVFN5LzFsYUZVZlh4KytG?=
 =?utf-8?B?OUNCak1BOTVkM2ttOGFmSnlCdUpmc0dHaTV3bzRZYTZudUtrU2JHaGZUL3pB?=
 =?utf-8?B?a3dtM1BGdVRXN1p0OFVzTmZUcXhQU1RkRHpzK2xxZHFmWW5HMnQyTDh2UUNC?=
 =?utf-8?B?UlVSUm56YXlscnF3SE0xbXI0SWprQlk1QUtuQS9xK0tpVjJuSnpDL1FqL2t2?=
 =?utf-8?B?d3NaMVo5TEVvUkFIZ2o1Vm9kMU4wYnpKVFFiVUcxc2R4K2xBNVB1NjJIZWly?=
 =?utf-8?B?c0lqRHk5UjF0RVdsd2ttNVVDam1CS0wrYlZrMGdGQWh4MGExbjRQOXlFaUtP?=
 =?utf-8?B?MmRxRTBoNW95a01mTkFFc0dXMFo3R0lGcU5KMEpvU3JWTzZVYXBnYXVyKzlj?=
 =?utf-8?B?ZnZ5MENCSkJmeHU0VWxSNHArTTZlOVdHckFjQ2QwNFVIN2ZsR0wyOElNSGtw?=
 =?utf-8?B?WDByRzA0QmpOK3NVdUh1MGM3d3kzTmdEZzRoQVo2YUhlVG0vQ0lPVjA0K0Iz?=
 =?utf-8?B?WXNvRnRBU2tZTnBKNFc0dmJLa1dNT29mZkxxZHZwNSs2Mkh3Q0I5cUdWdWN3?=
 =?utf-8?B?TDltbld6ZjRUVEF0YWRmVXEzdk1VZzdqT2tUZG50b3kwUlAxbjc2U0cxSWdw?=
 =?utf-8?B?ZjBmdjQ1M3l5WWVremZyeCs2L1FBcFhtQ2tCZG5Eb3IvUVdiMnI5b2RubkJU?=
 =?utf-8?B?Ulo4eW5hS3lXVmg2R21jUmxnamIyeWZWcU1TSFZWSFZFbm5Ub1pyQ0N2M01T?=
 =?utf-8?B?TUVVNmdUSkRSWDBTMFFMdU1UbkVOZ3JDbExSSlNTRzhFaHpoTEFLdUJzUEtN?=
 =?utf-8?B?c3BnVHVnQmdMRkZYY09DcFc1WHAyeVgrMGduWktQczFnbm5SeXFMcWQ2QzZ1?=
 =?utf-8?B?cFpHT29nRDdJVTZHcXZRRUw4dkNicG4rdEc3c3BuaE10ZFpSV3NubUYzSzNZ?=
 =?utf-8?B?TzNnZnVoeUJMc2hLUHlaRHhJQ1dzeHJDUXl4NW9samNZMTkwUnlwb3dWRHZj?=
 =?utf-8?B?SGxvcXVRdHFKRmVuTGptd09IanBYRzVnNWNNUXZTZWRueC9lMEg2YVdDZ3cv?=
 =?utf-8?B?T0pFbHhtOVJVOEFpQk5VU1ljaGlMR3NsZE5seVV2UldsM3FhdWxyYWwxbm5R?=
 =?utf-8?B?bWRqWEtxem1DVDhLNW1YSFE1UW1NZEtrVEdQWEJNUWMzeUpLZTV6MVAvQklw?=
 =?utf-8?B?cWxCYlorbUIxNjdqUXNIY2k1a2tONVR3WjVQWWFkVGZUTFVjUXdzS1VxQ251?=
 =?utf-8?B?cExhSW0rejQxLzc3VkpvNkUxVnFDZnVGR0ZaSHhsdGF4cDJkY2twZXFYd1dY?=
 =?utf-8?B?blFuNWc3M2EzYS9rVlNRcGhTTFJBZ05zdFRxTUVORHdPL3BYcG5XR0dJWm9N?=
 =?utf-8?B?dUZ4cU51aFIvcGJMZkYyVGc0clhmMUV0SitmVUR2UU1xUXJubWdVNmF0WEcz?=
 =?utf-8?B?dDFrOUJGRlBQNHM3aVpDWnQvakV0aTA4MXBGNHVXeWdxMElTN2o1SCt1RFdU?=
 =?utf-8?B?Z05jL29TTmNVL1NlZWhEaEdRVENoNDhTQXU1bkcrUk1nU1lzUEpQT3BxWEs1?=
 =?utf-8?B?T0hxZjBqYkFvL1d5dnF5ZGZPek9TVVhPblN0TmQ4bTBPUTBFZz09?=
X-Microsoft-Antispam-Message-Info: UfJzDC1lUh/mr7Lby0yWGxqVkf2VbhGIt58454hvLZ41a+fBVntV6LWcgYkQ3Xfor4zEjhE8cAocSfWm9zxpf8v5v2GteEfgAUEeBoHxE+h1763m9xG0HvZouZZG1m97vPB71ZEKEB6dyYRrLHYnMsDaC0O+0ZTPrjlKyc4vbZPAXJrmNZwXFLXhr/utMPvB
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1334;6:FJbLgFMcrmV4asj1lEscCtVpNFSiWn+rCaYnD5khmLAL+WSw6dcgqyyOuLZ9os/4xTzF3/pDkMAJ9f1cjIqTBKSJLwfkLRBuXNfM7Wx/5Yv5GMH/hOC/FDkX5nghHLhSCGKliypTIQtzFv34hsaoFI81AlEKz+iSvBqmut/lX6BjwFkoHYJBAvmuHYfm+tAwnr2L2Fy+bMi7AD5lM+S8EfbfWjjZYm/Jm/h+Lr1i3OeOBnw62S/FxQC4Ruh/cxFDdUGO4u490ZvF90lD0L4wf/rrxO00pw+Q271JMbgvE1vf1zu23heI84Dg/mL+g6sE4CjfxjN3hitcrRAHBgpzqgnoWs6kJsm4LDtzgH6+wNT8zYhCBVY68kmMZIjUitNqh55mkaycke3Nx89o0+CG1ndfZfJQFyQix16hfUzaHNCfwxl1g1AI0+Pbu48l6vUt5aD8uTSSuHivMZRqkLXDmg==;5:xtq13IxjKhwuH8yk30UFkeJhVpea/LTBtdpPhQAivNOKiDG+7m4NxJ2nOtcUB95vTcSxkSYSTIS06y1LKr4bC8kCrL61yoMS4Ma6T5G0GC+uZFvvaAytNFOigSnoXUqdHDwOscaOoS+iZhFQ+ysZF2vLrmHyJIAjRXi3ngTxpxg=;24:N6ZQlt/CIFOXVCtjI/Kfw9S0Mf17CXuT8zhQw8+9dv/hdH9yyovTZtF4wFqfU3zlo3kjIM9EW3Wk+Rlzv1TTnthFv+1SP1O3ZEMldzQu5ro=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1334;7:2T3k4G55l7VaD/UrFmHw5vUH6sC40/YQ7A8+L+aYbyo6JzvcSwd7efTE1q2qcsXj9LucJHXELWH9jUnD5fB2nS0SCQ4VN6myaa54sfOehqad+KXoeeFigxd5wxs3RXQTf1mzEieXpLEviv9GvM/kbfDrQgU89lNw6SW4oiXpnvjDgklCbFINWD+pecMOLib9fO+3KjKuJlfxXP/4mWK61YS2RGm2e+AinCdZm8tdNoKGD7rc8T7FNv6BI6I+/KNf;20:BU0ExQcdRI7QOHBFP/znIprHOcHMJBuDbfuYSo363lDqKrFahrsh4Aqqk+g+eFRWXox4BgLalmAHUutHzbXlx+ZkcUnuygTJGwBNYwONfJgEiRrydrQvPU6ztwnUt1YOrxfFv/qnD01MO5GDif/j6OUY1gdZV1EPo0EWQ1kTskw=
X-MS-Office365-Filtering-Correlation-Id: 2f17ec68-2439-45ce-44f2-08d5c7b31c3f
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2018 11:30:42.3880 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f17ec68-2439-45ce-44f2-08d5c7b31c3f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1334
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(resend for properly queueing in patchwork)

kcm_clone() creates kernel socket, which does not take net counter.
Thus, the net may die before the socket is completely destructed,
i.e. kcm_exit_net() is executed before kcm_done().

Reported-by: syzbot+5f1a04e374a635efc426@syzkaller.appspotmail.com
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index d67734c99027..84b7d5c6fec8 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -1671,7 +1671,7 @@ static struct file *kcm_clone(struct socket *osock)
 	__module_get(newsock->ops->owner);
 
 	newsk = sk_alloc(sock_net(osock->sk), PF_KCM, GFP_KERNEL,
-			 &kcm_proto, true);
+			 &kcm_proto, false);
 	if (!newsk) {
 		sock_release(newsock);
 		return ERR_PTR(-ENOMEM);
