Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65B4ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B41320C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Kdj6fa2k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B41320C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731551AbeIXWJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 18:09:59 -0400
Received: from mail-eopbgr00102.outbound.protection.outlook.com ([40.107.0.102]:44697
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730209AbeIXWJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 18:09:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHHytRo5BQ5NEIVSTEfdcV93SDUESmrMQGnRDy5RYzw=;
 b=Kdj6fa2kbKFLwYjQc3YdlGcn6D09VPf75mcVPu/jPEO+2FFUQnYesjH0W4/EhK+SlaDIi5fRqkheFHfz2IH5JY81eDzwn9XcsAwfPrTLJSL7lnp1T2GTx7WGplT5YhCIM3nJsoA8yB1MDmRL/1arvlE5M7XMtDuaxfIEcOwCebE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com; 
Received: from [172.16.25.12] (185.231.240.5) by
 VI1PR08MB3262.eurprd08.prod.outlook.com (2603:10a6:803:3d::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.22; Mon, 24 Sep 2018 15:51:57 +0000
Subject: Re: block: DMA alignment of IO buffer allocated from slab
To:     Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Ming Lei <tom.leiming@gmail.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "open list:XFS FILESYSTEM" <linux-xfs@vger.kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Lameter <cl@linux.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <CACVXFVOBq3L_EjSTCoiqUL1PH=HMR5EuNNQV0hNndFpGxmUK6g@mail.gmail.com>
 <20180920063129.GB12913@lst.de> <87h8ij0zot.fsf@vitty.brq.redhat.com>
 <20180923224206.GA13618@ming.t460p>
 <38c03920-0fd0-0a39-2a6e-70cd8cb4ef34@virtuozzo.com>
 <20a20568-5089-541d-3cee-546e549a0bc8@acm.org>
 <12eee877-affa-c822-c9d5-fda3aa0a50da@virtuozzo.com>
 <1537801706.195115.7.camel@acm.org>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <c844c598-be1d-bef4-fb99-09cf99571fd7@virtuozzo.com>
Date:   Mon, 24 Sep 2018 18:52:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1537801706.195115.7.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: DB6P193CA0003.EURP193.PROD.OUTLOOK.COM (2603:10a6:6:29::13)
 To VI1PR08MB3262.eurprd08.prod.outlook.com (2603:10a6:803:3d::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a36e018-2273-4a64-4edb-08d62235a953
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3262;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3262;3:AruVW9sYMhMvBOleAMN6dJ86FAzcBpAGlu9KvWam3nHIiYqjERhS2Hxn1diQCmg1vHYcJGAEfDFKvB9GgIyL8eZosvVn7NZukQ6MuBvx8pBJJoAcJL62jKvEwfTrM8cXEUt1NWbAOYlBB15+G0qVZvL1HTkHQnpgckrVLk3i9P4x8SFkOJbuLdmjwZU9lXkzj3AExy9epr5bA7OemrQYz6oXFJgTUK98HYh0M1NINNTdXNcILqYxGsd1F8dijdN8;25:OX8EXqlH3vLBmSBlxwT6+ema8sQ1T8YATYdKA4gutwAQBD3n66dakG8ZK3oloZJZSIdl+MOPUbYJx4UWsTs0FveAiWPRz+5nboxLi3ZNqjQOe6HGfLkh3xQ+y0b0E3sgadbiUeX5znSYMjs588QUzWwcIyqPZY66QYekDJZUPIuUC8OjfvECekwERVxXe4jldRaoQWlnFfCvINWm7B/Y/fTgVhxxcE5WHCFM5tFcSgGyHMLZJdMZ3tO6lh4c6IarxHst/usDe/4y+iQ7DXCILE++iKfpcn/JTuFohbIKaERacUO1PtR54Y0zJtENlcR60oPr+6uDMUnnEldODJIlsg==;31:SSS/1xy/gFcvCjjYoEosSLOjXRujl+Giw8dcjRr3hU38ByhEOJqH8NMlgQJpdjQc+0vDloBEIzc65+KzLzWSRpPG2c552zTNUQKuJX7M6x524N96ArNBh2SIrO5nvin7FfDZkYKK8rAgRqfCPZb/4jzMD0yLUNkWuGjCGzZdvgNDvVn1Asv+MKEbLQmdDPeljYDFtrwAJb5lvIOLc/DlplZSMymkcoq33hmxfYIMsOI=
X-MS-TrafficTypeDiagnostic: VI1PR08MB3262:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3262;20:sd/kNeg4R15YT0CkE/4ABNdHne/TWmpVBBEnjaNdDIH7Crls5AXpSIQ+zQ5it6BUH8oizmckNIsHQO4LTZtBlA4O2N+B9tD60colUQa77EC2QAnUtFb6+CYzW5ipX7qEReJ56BzqNZk9BMUFT6WgHePYdvaa32JE0NcMBhO+qebjMjrUPXljOJ76q+NcU98rRgWIpY3jGxgKOU+Htr9ucwbEmpFgW3iu/YSUrAwcUO1QhqD8YBPRKkHemdUsTejmWEkkH+STCTL4BNIaDrk8K4T1owgbUIgNe2kTFUQ2flTeoQSAYSaqFiXyDltJGcaE5IQuj5dhtdK5hHYGoAY1L97wGvXD85SKxIq8KbDpjE9sKrliZLEyyKlOEndWHNnsK/EqbksGZe25tGE7+sJgNCS81QKaqjp858BXOD3W1dknHO/2+RZvqSRIjAaSIvc0zkz9X23ptk7xu4gwIuuIUwP6KENUob0tdtZumvVlb8Vd7W/uCCWU5pkJ7td2L4Aw;4:BQCikWq6Wrx3F7Bu6wWtHyNJhUo4Xo1Wi2Ve2iXkTXrGA2sU2WN+66vZILNVQoLrVQmwlbbbk3UvRqSRcGhEqmHcQjejBJxBqnYsuok/Y7JZoxr2iEQa6Mk/2+joU1VaV4DAS3tU58pwyEMPbs/8tIy+vx3cMC4huyEGZThrlo8pUOkCdfqsyrxUKrR60au5kn5mZaS32Eua5KLA+nG7gb9YNpigVraaSSQH5ImtN7nH0OZwFYobK361wKkWEoRPJ5CIcI6LsTrlxrmllvqWTA==
X-Microsoft-Antispam-PRVS: <VI1PR08MB3262F1771EEFD8682A676621B0170@VI1PR08MB3262.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149066)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699051);SRVR:VI1PR08MB3262;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3262;
X-Forefront-PRVS: 0805EC9467
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(39850400004)(376002)(346002)(136003)(396003)(189003)(199004)(53546011)(65826007)(7416002)(77096007)(16526019)(11346002)(16576012)(186003)(58126008)(230700001)(26005)(53936002)(446003)(7736002)(305945005)(2906002)(97736004)(6486002)(3846002)(6116002)(14444005)(31686004)(65806001)(66066001)(65956001)(47776003)(229853002)(68736007)(8676002)(81156014)(486006)(81166006)(106356001)(105586002)(23676004)(52116002)(76176011)(2616005)(8936002)(956004)(476003)(316002)(478600001)(64126003)(6666003)(50466002)(36756003)(110136005)(5660300001)(4326008)(386003)(6246003)(25786009)(54906003)(86362001)(39060400002)(31696002)(93886005);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR08MB3262;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4TUIzMjYyOzIzOkFmOFFLN2liQlhlS3hvcDFIS2hTbnlsUlZ0?=
 =?utf-8?B?bnFPNkxaR0lYYkYra21OVjRzOE1xWWlQYldHWjdVV2tDb2tsRVhZUzVQUVc0?=
 =?utf-8?B?L25YNklSU09lRnBVbWZwL0FLSkhIOWRsa1AyOEJmNmJEQkdYc3JiSE4zUExR?=
 =?utf-8?B?SmlHU3RJaWlXeU50L0E3dS9OMWRyaDQ1akc1KytaUmNKdmhsb3ZMcStocFdP?=
 =?utf-8?B?Y0pEK3BtYi9RdmhUYW1BZHVHOVpvUWlPMTlNT1UydXFNZ3daNndqMEpJa29O?=
 =?utf-8?B?UjdudnFWaE9sZzdtNUkxWnhZeWRxY2NEcHFBWDd0TXpZQ2dZcUhnajFXUXp5?=
 =?utf-8?B?MGJMTVZOTDZTVzNjZ2l0VjdHcFNGTit1KzZNa053RkJ4M2diOXFJU1llUEZn?=
 =?utf-8?B?bEdnc2JTNVRnY003QnByOFpsQkZtWlA5WjhYaW9mTFlYenZvdGJEVnNZM0Vp?=
 =?utf-8?B?R3VqY01USVVGNXdraVlTdHZGellxZEZqTG5jN3VaN1JlTzVPL1RrdHVXM2hn?=
 =?utf-8?B?Q3pPditrSHNnNk9MOEUwZHVZYjRBZVd3UnVaRkRDUFZ4MVZ3RWg0N3hja0l1?=
 =?utf-8?B?M3Yyenk4ODNoRmFrRTZLazZ0Rk9OL3cxY3orWWE2Q05EK2R0Z2dkbTFXZWNW?=
 =?utf-8?B?VVZZd21tSmoyVEl6M09OME1YQ0xNUHdSdTd2aVNRRUU1b2RTVXJ2VHRodlJV?=
 =?utf-8?B?bEQweFMvMUxtTlNpeDlvZ0RZbVI1WlRhOWFWc0dRNlJ5cVRUUU94Skc1YWhn?=
 =?utf-8?B?NURGR2FEYWRuY3BiS2V5MWV1SmNROTB3N0EvNlRCeXFxRTFhTzRRcldMUUNw?=
 =?utf-8?B?QXcycVNhSTRHb0ZuRHgzZXFNZjFDZVhaY0ZVRHJHNzAyQlVpZVV6akZOeXJN?=
 =?utf-8?B?WFJMZG10OXkwZmFBbGZxdDQ3MmpsNGZPa3k4bTQwOHJ2ZTlWRHhHanVIalRy?=
 =?utf-8?B?eDZKakZVWFhrVFVEMmRkanFqMzA5RXZNa1ByUnM2emNtSVRsYmNra0FXVjRU?=
 =?utf-8?B?S1kwb2dHU08yNkZIeHVTMCtqMUlveE4yY25McU1kL0dySWUveTRib3pSeHVF?=
 =?utf-8?B?ZEh2UGhhTkY5UWpqY2ZXR0xIUkFxUlpRUXlKZ0JXNWtiVXdyUCtITlZsKzQ1?=
 =?utf-8?B?dGxEV05na2xaTGd1QlEyV0Y0eUIrdDJudXQrMmIwenlUaWRTOCt3bmt5Wi9w?=
 =?utf-8?B?QlZNODZLNmsyaHh5L0krTWljc0d6dGR0blV5QkZWV1ErOWtCNURpUVh6S3dE?=
 =?utf-8?B?TW9iYk04RHBuWnBQMUFjcWZmcEtoR3JONC8wZWFWZDYzYlpTNEhyYnZqT1do?=
 =?utf-8?B?SXlIVCsrZjQ3anpXdGNVQUpYVEVCQVhNa0pnRWl3OWRheklXR0lORXl3cTQx?=
 =?utf-8?B?UDRvZlJTUEdyYTNUWXFGTFhwLy9GaDVlRU5PekNSV2h2ZzVCSWU0WndscUtV?=
 =?utf-8?B?ZCtOLzYxczNxeXRGdXQ0RjhoR0ZkckVoNDJnSEhNOTFqL005aHc0bU9xTVdi?=
 =?utf-8?B?Z1ljdjJ6UDRmME1ibzM3bzA2bWhMVXNwaVQvSW45ay8ramw3Z0hZRWVkUHp5?=
 =?utf-8?B?VXhwcmhQWlp5eHJtaVZxbUlTOFZlQUp6ZndFUHJuN0g3NXE0WExhZUcrczdl?=
 =?utf-8?B?bzIvQ1hFNmpKVU5WV25ZRS9NTnM1M080UHh6VkFHc1lqYlUra3YwOTdmN2xR?=
 =?utf-8?B?eCtaeENzM2FpUHBSYlZKTkZZcWNrKzVVcTYvc1packQxbUU3WjBQUFI3S21X?=
 =?utf-8?B?V1RndTNPejBLb0dmYkxpRXg5TTAvMVJ0TGtWVnZJVmlidUswV0tZZ2NMc3Jy?=
 =?utf-8?B?OWRBRnZGcUZ1MmlIV0Z1emdUeHNJSlVuNGQxUmZvTXdSNWZlZ2ltZWxWL3dD?=
 =?utf-8?B?ZnBKbVgzL3U0L3JCb28yRVhRdDlnSTRUL0xuVlZVN3gvYktWSU40UDBaZnJl?=
 =?utf-8?B?YXBLYUpIcmFNbzEweThjdGdnaS9xUG0xZ0FBRDE2Um5NL3haNERGQ2JRNjBu?=
 =?utf-8?Q?xJbW0+?=
X-Microsoft-Antispam-Message-Info: LDRsLnEKx696l3V7yFJa1ScvR8bIJHDdBd/oCt88Nv86T8S7rqYDyJh/ipd7FLgW3b6lPGMYdkr6aiyv/M/GM4bUqXay0Qr0jyeODK049nNH1BCE23BhqjUvv/LypsoTdPbTM5y82A0cXctCgPYRe0egDrFNdXNb4D8eWk2qUDumomAokbupvfmZ5No2D1DiHP2UVyrfo21lbjNAe+3vpHDsk5daRHtokAHt4+IDFFyVyZ/j35fIZPQdOaXhM+SwwEHDBCM69LODqtIgAfzJyR/JSto5zLXmmcDvGt5j/3HcDMuBuT8FwrUMeKwrBqvDftxxiOtNDCYqkLNGIgkrEXdkCUjPiUzZ54ZHSV0+8H4=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3262;6:leeSTVvWWL8BlGbF3MYcsSYA0/MJx9Y3BknS7r2HU3TveodMDeKyIWaJDgVe5jE7JaXL+/tlmK6C029xT3O5WpF71s/htkkDbXlaNDopjR87EoUU0D39C1tk7ttfkrqh0rz07UrSAB6pd0F0zojEQB0UbRyNCtTTJPbl44lkRFgB1EQDFQicqRFhlrPqU7rW+F+rIGWsCNXtQYD5KDdiM9sG9+FU+ktWnRR61gwQ0fkIEA+i4/0cLS1RFWsN0GfWE+2hjQPc8NzlCOuipfLju2GEsI+hdLg71QxHHFFvfXFQgUaq0jmeLP8WkM0qXCRmFn2hIDlLozxiCmo/5nD5cObGSbn6P3HwAzn/hIqvZqarJbYGubqzRBPSUH3LlqCexjOWyX9MQRYLKa/6D/68bXesKlTKwTR2oIrP2sfeKgevArHCtxWAZQjMLLdpsRRNcnOOubNxDmu+4HdOzQSHww==;5:Ri+NCmL5ng+DoE5WhZjdNcUOOJsipoELjQ9aj8nI5Zho+JPpqS/QrCaLx5E/IXuYHqhw1Vq/EVksk7AvDgl7HRNPKgLuemzsKMK/4coJlqJ75vVLAOMEH8pV6F4AToxsQnDNFpprmDbDPWtqTDN+lilI/JzMJkTxycZkqtleJ/s=;7:cp3T6rkDlWO8t4woznNPZ0KSJNZVwIEH/rBJzzP9JskdRIQXWznL9vG4uKx5eP+JnU8dygKHbBV2Gf5KoccP5Ud/7ck62lYDqA2FacVeVnXHgNONrkYOGCvAF331Y69QJcMHTzDvz8fatUaJl1gcPyZOViV4te10kGBbPuSXNByCEw3/9IvG8t9csgYMcWudsZ7Pf4NNZEO/AWgFO2WCaOLimZQh6kr35LSwSNI4MdL9ycciGOUqtM048UJyV5xA
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3262;20:2JVtjX29/WPURBaCS1Gfa+KWjrWVOtKdWpdnwEHsQMFArvOtOthf6Q/+fRGT4eQKjfCZIkMEKDVCPm91C48D2bTaHKhd5ZrpBa5LAR5/e8S6QcD71wHG8jZS8S2g/ea4ge1Ft3hMqwjiJOHNONlUBKjCB3tjcP4nWaE7GUUE4tQ=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2018 15:51:57.1892 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a36e018-2273-4a64-4edb-08d62235a953
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3262
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/24/2018 06:08 PM, Bart Van Assche wrote:
> On Mon, 2018-09-24 at 17:43 +0300, Andrey Ryabinin wrote:
>>
>> On 09/24/2018 05:19 PM, Bart Van Assche wrote:
>>> On 9/24/18 2:46 AM, Andrey Ryabinin wrote:
>>>> On 09/24/2018 01:42 AM, Ming Lei wrote:
>>>>> On Fri, Sep 21, 2018 at 03:04:18PM +0200, Vitaly Kuznetsov wrote:
>>>>>> Christoph Hellwig <hch@lst.de> writes:
>>>>>>
>>>>>>> On Wed, Sep 19, 2018 at 05:15:43PM +0800, Ming Lei wrote:
>>>>>>>> 1) does kmalloc-N slab guarantee to return N-byte aligned buffer?  If
>>>>>>>> yes, is it a stable rule?
>>>>>>>
>>>>>>> This is the assumption in a lot of the kernel, so I think if somethings
>>>>>>> breaks this we are in a lot of pain.
>>>>
>>>> This assumption is not correct. And it's not correct at least from the beginning of the
>>>> git era, which is even before SLUB allocator appeared. With CONFIG_DEBUG_SLAB=y
>>>> the same as with CONFIG_SLUB_DEBUG_ON=y kmalloc return 'unaligned' objects.
>>>> The guaranteed arch-and-config-independent alignment of kmalloc() result is "sizeof(void*)".
>>
>> Correction sizeof(unsigned long long), so 8-byte alignment guarantee.
>>
>>>>
>>>> If objects has higher alignment requirement, the could be allocated via specifically created kmem_cache.
>>>
>>> Hello Andrey,
>>>
>>> The above confuses me. Can you explain to me why the following comment is present in include/linux/slab.h?
>>>
>>> /*
>>>  * kmalloc and friends return ARCH_KMALLOC_MINALIGN aligned
>>>  * pointers. kmem_cache_alloc and friends return ARCH_SLAB_MINALIGN
>>>  * aligned pointers.
>>>  */
>>>
>>
>> ARCH_KMALLOC_MINALIGN - guaranteed alignment of the kmalloc() result.
>> ARCH_SLAB_MINALIGN - guaranteed alignment of kmem_cache_alloc() result.
>>
>> If the 'align' argument passed into kmem_cache_create() is bigger than ARCH_SLAB_MINALIGN
>> than kmem_cache_alloc() from that cache should return 'align'-aligned pointers.
> 
> Hello Andrey,
> 
> Do you realize that that comment from <linux/slab.h> contradicts what you
> wrote about kmalloc() if ARCH_KMALLOC_MINALIGN > sizeof(unsigned long long)?
> 

No, I don't see the contradiction. I said that arch-and-config-independent alignment is 8-bytes (at first I said that sizeof(void*), but corrected later)
If some arch defines "ARCH_KMALLOC_MINALIGN > sizeof(unsigned long long)" than on that arch kmalloc() guarantee to return > 8 bytes
aligned pointer, but that become arch-dependent alignment.

I just realized that my phrase "kmalloc return 'unaligned' objects" is very confusing.
By 'unaligned' objects, I meant that kmalloc-N doesn't return N-bytes aligned object.
ARCH_KMALLOC_MINALIGN alignment is always guaranteed.

> Additionally, shouldn't CONFIG_DEBUG_SLAB=y and CONFIG_SLUB_DEBUG_ON=y
> provide the same guarantees as with debugging disabled, namely that kmalloc()
> buffers are aligned on ARCH_KMALLOC_MINALIGN boundaries? Since buffers
> allocated with kmalloc() are often used for DMA, how otherwise is DMA assumed
> to work?
> 

Yes, with CONFIG_DEBUG_SLAB=y, CONFIG_SLUB_DEBUG_ON=y kmalloc() guarantees that result is aligned on ARCH_KMALLOC_MINALIGN boundary.


> Thanks,
> 
> Bart.
> 
