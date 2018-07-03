Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA87C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0239724972
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="fOi1aEh4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0239724972
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753447AbeGCTNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 15:13:07 -0400
Received: from mail-he1eur01on0098.outbound.protection.outlook.com ([104.47.0.98]:22400
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752019AbeGCTNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 15:13:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBwN2W1FuNa3kqq4v6HY9l8o8/r1A34pZn++pnDWg2I=;
 b=fOi1aEh4BOCPOgjaNa56MLso4Jkhz2DuYfQt/IA9Va8yIISEKu+6BnCgxKsEXnq8aIDSswgPdgaADCcLTOtYwA1C+XDKUzYRMlsV7crUAdbXv0W1HCSg2UbXWg6AG1zXWUqOqovnaelxgHgVpH+28mOI8tj2apPQjkbbqrYjaS0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (89.178.225.132) by
 VI1PR0801MB1344.eurprd08.prod.outlook.com (2603:10a6:800:3b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.26; Tue, 3 Jul
 2018 19:12:56 +0000
Subject: Re: [PATCH v8 03/17] mm: Assign id to every memcg-aware shrinker
To:     Matthew Wilcox <willy@infradead.org>
Cc:     vdavydov.dev@gmail.com, shakeelb@google.com,
        viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
        tglx@linutronix.de, pombredanne@nexb.com, stummala@codeaurora.org,
        gregkh@linuxfoundation.org, sfr@canb.auug.org.au, guro@fb.com,
        mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
        chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
        ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
        linux@roeck-us.net, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, lirongqing@baidu.com, aryabinin@virtuozzo.com,
        akpm@linux-foundation.org
References: <153063036670.1818.16010062622751502.stgit@localhost.localdomain>
 <153063054586.1818.6041047871606697364.stgit@localhost.localdomain>
 <20180703152723.GB21590@bombadil.infradead.org>
 <2d845a0d-d147-7250-747e-27e493b6a627@virtuozzo.com>
 <20180703175808.GC4834@bombadil.infradead.org>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <94c282fd-1b5a-e959-b344-01a51fd5fc2e@virtuozzo.com>
Date:   Tue, 3 Jul 2018 22:12:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180703175808.GC4834@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [89.178.225.132]
X-ClientProxiedBy: HE1PR05CA0254.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::30) To VI1PR0801MB1344.eurprd08.prod.outlook.com
 (2603:10a6:800:3b::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd08dd03-0894-415d-4584-08d5e118fd66
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600053)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1344;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1344;3:cuaKaNRwuE5TZtjEBZKcCY5OODAOY6PglGQIVkRffBRQb3cIWZ/If6O62rJaCn4lmdk92TS0P/expztiXatniePZGq0x4iIVmOwW+dvQsob9PgEtXcK6+QhVyTAWNS8zh48vS5eK1PN5doXPb2eaij9Zcq8qYyaD11GDWe7lPmQSfWR+yKz3vnFPwKOLNjyF+4HDn6qGtx/s/4yLFoNtMZfARf8ZBium48Mjn/ZBfYSPls7VYqksiaTVSOkCzUFn;25:kufHKG2m8iKkkC1qbPKhkcwT4w4C8WcTEbHsavHxJaMvg/dmNicqJL4swxJT1eBjTnY3ukIg4GsUoRj0mzRA7i4G3SNtOaZGJiHKIU9vwC49BU/i9XTdQA3Gnu7Vp3KaWMb/ZEre6Gc+g+vL5wsK4q4XcY5tNjRiElLWwsM32NmsYl6tbXPREJXqueiWW4t2Jr6bezwrgsreOczqqClSEBQw5KLeDxXD47DiT/nbslzF/8+C9OL5OQHyRsYLCidkmrL4UFmYfi5Ycuhz12lOhHze01TH27/OYyebTqsOWrFg1jQqghgzrhY5SXiuSqP59wkX1hDMVnD9eNovJH6wQg==;31:TIirNmdFPDP/SlYOUaVXWkRripwmqSkdgtq7Cwa20qFFkh94nJXh4z9KnHtWissYocZO30lyW44MRjGjWvrd4FOR3c2Vq4FNROdAxuadM8HZGhwTH78lDMeqfrjRnTIOt7Om5sb2oCcDplqmUO5eo2dSfiX5eOWKkADZvRSVETN2i6UpX5EvsLTHRA3fTgywGrUWAO1Kk9S+ZVNfgcHtXNJBAGNsGR4j6x2h/+OiRns=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1344:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1344;20:HGkE/3yG8ui5zlD1rpQoeS5MLdFKt4PBZn3UK5lFdTdYIN4aP2DvEC+8OWUQ63EToe7jWymRMYC24O5spJVTEPunxObtQBsF7FZTV7f+nh+OaA5npXYaI/nfPXA22PR9MU8R/qjQiEGREJAKMuDqXVHDRdeCCWDaVqhJ6ftKCiJnoOdq8beCFyzJhKG260fk3wmbd8VrPl3jYGXDctg/ThyP2Zajt4ogJ8qAIq0MUek6vgv3n4Ltz92R+OtbykNO4Sun0KVbc6LdabGr1dsj8l8DX10mzAKlGlnh1x/CncPjSADOv1RPIrzQ+SXSPCB67jFaZTAXU0Zf76juFgi7D6eko9/RY3fNtNvN2FsUskWv7kBkMrWISb5usYfo5XiZpQeXqnay8BqoDgkBL0ZzXTmEzygKaJ62ZGPIaUlX6ILFHs+KDOd37KkC9oVIzVRR2YWaVn/FWvWRXrBJDJzcZZX25srwMpEEZHpfEvcmdKfRv6B8hAv2N0Sd773b+o43;4:B9G4SKoOIBAteFK5gGZHYw4zou1W2WOLyCmygFaWB14lQAzLAl0EZnGqJ/1J3JkuY9T/UNhGhHPRa1+tklugZyfBPE/QzLz+ewDGaC0W+5ZAxVuPvBiRPadW4OZz/H+J/vp1i692Fl/Q92Zozh2b6XLJoIwuYobVJR7l3/05kuD7sxwft6RhFTd0vHf0UtQuhXSs47ruRVvF2Lq1TQKegyGY+DU3e+uKDrC7Y4YCsYNP8jAHrpavCti+8RqBQYyCbX/JK9FYXae6QhHxq2qIiQ==
X-Microsoft-Antispam-PRVS: <VI1PR0801MB13446F526D2DDBB80D4F3C13CD420@VI1PR0801MB1344.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR0801MB1344;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1344;
X-Forefront-PRVS: 0722981D2A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(376002)(366004)(136003)(346002)(39850400004)(396003)(189003)(199004)(11346002)(7416002)(446003)(316002)(486006)(47776003)(65806001)(186003)(64126003)(31696002)(53546011)(386003)(36756003)(956004)(68736007)(2616005)(6486002)(66066001)(53936002)(97736004)(65956001)(6506007)(6666003)(25786009)(476003)(5660300001)(26005)(86362001)(4326008)(65826007)(6916009)(58126008)(16526019)(105586002)(6116002)(93886005)(39060400002)(76176011)(6512007)(52116002)(52146003)(23676004)(106356001)(2486003)(31686004)(6246003)(229853002)(478600001)(7736002)(230700001)(81156014)(81166006)(8676002)(2906002)(3846002)(8936002)(50466002)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1344;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDQ7MjM6NkZjRWxZK1F4U0hRV0hidzhwdDdUbHhq?=
 =?utf-8?B?WElWRG0rMlphaXllaUlEZncwRUJxSUpKY1hGSWY3VTdaL0xLNkttZjFSMkl0?=
 =?utf-8?B?SUt5V0NMaUpKQzlYY2FaLzcrZkhDOGZVODdZN08zMkR6YUpNR3V4RmkzMFJ0?=
 =?utf-8?B?b081T2hDVWRoMGZHYjBxdTRZMHpKOWVSL0FUODlTc2tsRm1ZaUF2ek9FT0VI?=
 =?utf-8?B?Wk5UOTRXWjEwVE1GMVRURmFnTzJsak1HSzVMSHlSODJzVlh0VkNzMFdZUHhK?=
 =?utf-8?B?RXk4aFgxN0t6aEYrb3k0ZU10RW9GNHoyK2d6S1RVdTJQaUllNzlyUUVWQ1Vn?=
 =?utf-8?B?REQweEQ5Y1NIa2lkSDBqaWJGREU0alVkY0JvclRmS1JxUmZuOUZyd1Y0cHBO?=
 =?utf-8?B?d2xiWnR6UTYyN0duYzhnaEV2ZU5BR2dGZWw5MW1xL0p5MElMcXRvYU1tV2Q1?=
 =?utf-8?B?NWpXaDBWTXZCNVpLRDB6blNtV3E1QnBNeURCd0d5UDM0dVlFWlkyZ0xsYjRN?=
 =?utf-8?B?MkMzalJFM25ZdU9vSEdueUJBbG8zY1BwUENSTHJHajYvTjZDc203ajZPQitx?=
 =?utf-8?B?K2JNTkdDSlE1a3Zpbk1ZOWdmYVp5cGVLRUczeFVzTWI2b1Y1bnFtR3dGUktT?=
 =?utf-8?B?UjI4cGRXd3hwYmlxYU9GcXYrTHVWVjdOQTU2YkhxY2FxMWVyV1lHdFk3V011?=
 =?utf-8?B?Y3B2MHRKTDBEaGNIQk9JWDFtUzB6d2R0K3IwYkN2bHBac1RnVUpQeVpNRksr?=
 =?utf-8?B?ckprTzB5am1PdVM3cXhGaE1iZU84Z1Y1TFQ3YjRTL2p6aVVuWXBVQkc5ZXhw?=
 =?utf-8?B?d01IQVJoa2Z0SHhLdkpaK2lMSE5qYTlCNmFGdTM2MnlTSS80WXpHZkF2TzBS?=
 =?utf-8?B?S3FqWE5BSU52U3ZPano1N0pDOXdSRHFQc25DTzY1MytGcFMzampvT0hlWnI0?=
 =?utf-8?B?RkJyRVFndTZ6Rk5DeGpnVEIxU2pIMXYyZ25QWWMrY2dhSGNuc3lpNnJRU0cw?=
 =?utf-8?B?OEJ0Q1VoZkxMblBjbVlvUlF6RUJTQndoUERnMk5rQXdZaW0wWWNYdXgrWExk?=
 =?utf-8?B?Yzl1ZlVrYmJra3VraW9CRUgva25Oekg5YzJZVTBIS2N4Vm5Dd0hBY0JWR1Vi?=
 =?utf-8?B?N1JoQVJqb0E2cjIxRTZrVnpPRjh1T25tc2t3eHFCb0FYZEVackJmYktRRFE1?=
 =?utf-8?B?Q05vWnBYeDVWTjJSZHR4NFZLcC9tQjl0UGtZeXd5WjduTmJyNGtZdkNpTHN0?=
 =?utf-8?B?S0o5U0J4bDFSMzhuenJzRXdpbUUwS2tkTDFoMEVvZVMydkpKdEF0N2tHYWNO?=
 =?utf-8?B?Q2MyaHR0SklvVSt0VHZDendwamlQVzlPMCswd05QdHFBbVo1Rk5XU0tXM2Nj?=
 =?utf-8?B?OVhSMjZiL1U2S04yMkoyOS9XNzZRai9EQ1VWZ095QXM0cjRWRjlzbkEvdDVI?=
 =?utf-8?B?aVUxNGkzOGRrdm9oY2w5RGt6VUJrc0pETG5OMUxUcmxEREp2UHo0a2tqS2lo?=
 =?utf-8?B?dTVQdHRLbWVUVUVydUJHMWM1dnRubFQ2YkRKOVh1TG5lZnlubEZUQU9UNXpa?=
 =?utf-8?B?OXdmY1ZKd3NjVzBPOUU4R3RzMnFXck0zZ01WdVBZNjU4c2NDbWJGWmsrMmpu?=
 =?utf-8?B?aXhkblQyaVNoQ1hDck9RTHVETmc3T2pKSng1SEJPRzJCOWhCWmxUWStCZ013?=
 =?utf-8?B?aTFzeGVQdXdyb0lLNEtzNXJhS2dSaWNYekZZNlJ4azh6OE9zUWJwV3JraEVj?=
 =?utf-8?B?ekVsR0Mxd0J6QkJ1dElQSExqWGFtd04yTlhlOVRtc25WQVgxbHV0MXVmVmRj?=
 =?utf-8?B?d1pZRi9QcUhOYTVNS2EvZTlhdUM1anRoa3RwRm5MUnY4dkFXNzg0cm5ZeWpv?=
 =?utf-8?B?MGRkZjM5M3RZUTNwUE1YbEtXWGhlakhwV2pVRlR0N2R2UjJwbmhaWHdNejJp?=
 =?utf-8?B?U3o2dVhPQlV3L2hyMDhwSlJqUytJWTZPWVhRY2hZMmtPRTNBTWpDUG9lSjJ4?=
 =?utf-8?Q?MaZa3cNr?=
X-Microsoft-Antispam-Message-Info: Zb9877H+dBaR9oqDa6l7ZCC6J5lorxEHV1A/uL5EllTh1w01UsofTeeczTDlIxegDcyK/gQ8Z5Uf1Uim1AKCQ1SgqSHlvAtlnH1k1sF4iz5JxWMnCONGls1hKDGVlhGKlCjZlnLW9N+Fiu4KCEC8xyMvs2Ri+Au8AqGeUm7ZAt2tV6dqkkXNhhKXsRsYu4p4fJubALaYJjhbNerxPIw34WIrr3fbySniaEr1G2oVw4F1148sPoUIM4LU201jHjBL16upUTvDaBIhdYpJhQ0iBDLA/XtSLy/b8q7ydh2oX5fk1vclnVOY7mxYsyVRk/cpB3r1bD3C9xWlu1Z9dsi+iY8+/gtVUn/6Mz3zVm+cDDo=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1344;6:TTGaP6dpPjlpKb2ncNtjUGprU+52+WadkYV149GZg4JazgUoEHwLhc2RqAy9rBA8BzJl97qig0QKsFcWcuYbEuVnEkwcREmmmj6CfoNKZv7LO6RDUhX2sN2zgXkpkPZDlIdKdImX4DFBnFSP6IrPtNWrH/lotCcZN01pFU5QH+F82g4QWT2ZeCxb/wU4+NGx7JUSHO5ehVXXF5B+OWcv+NmAfUks+Eg+K1YGbImKplCzujp5RSJhHisPWG2sJfkPH2Y6End+ey8vohGKGoz7nTKpCdSabAQdErnv5RWgzfDPJ0tIfvvKBpNMeS5hAQw6WT8I5dvPraKNuzBwuDYp2V7MfZJPgzbUKzI57+QT6gimqLhD45+gSDQIsGDRWtKksxWSyq+mk3qIgUt4Od2e/VSsE2+fZp3Ok+L7LlHFRz+Ypg7NlfSGHZkkvU6pRJzYiBEW2jUJnu8/ysCz9QeJwQ==;5:PbqIEDkXI6DEs8VlJ7XUzZIXf7fx8BIge7qFc5i4t9ObqVQZ2n/knhonTyhF7XhhIm5+h4K3bSXk2R/79xTixvhXgmlqvsCXPxUFXQA7oy6ygJ0fuGx3+k5rpcesUyzqv8MoLORw4AmFfXqUmKt2fDR3ISBauQAz+TkINYZlKCk=;24:/SspqSHVuICWIqZ9l912KJCKKmGEtwq9fXgGIHEeXE5ayrd4pptkdC5CxQZkwqwwvYNVo3ohkEefdkvsFInP84lcDGLCg9FnoCRflCnjFQg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1344;7:ZmHhTf2HbWJVmh3+nP+UlVT53E7YgQK4jSQcc7hChBTg/QhApEO3zQHvFySaKI3Ox5yeJpRF7jXu0T0h5/oQ6ULFJl6AeIDH4RmI7EEuGF7sVKI3KVzMzBMT4rJft9y372NCiJHLAmC9YauhuZKCEEB8nAeGyQkQ0htLwTy0t4TvgX0zOzJByJ07+mcJIvqIOU1IMUiS+WgN8uQ8WjBuhPCpzDHwa/Xrbe3NInJYrr26ESnetToecsGvHGxjJo9E;20:VtKkeErfNKNGBcHwi5KyBXQBXglqDwovsCNIlwHhMYdfTy/wUGqw6dmK5JyTFYVJR3mCiEepnFF4A0P6WpdCgdKNDf1JBtx7mUKN0m5KBVhpWsP40EMSh5h7uwkeZCV6KIksQDy3uuUhdB2Wp8fNp58Ki1Y75gIo35pv9IfU46k=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 19:12:56.3813 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd08dd03-0894-415d-4584-08d5e118fd66
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1344
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.07.2018 20:58, Matthew Wilcox wrote:
> On Tue, Jul 03, 2018 at 06:46:57PM +0300, Kirill Tkhai wrote:
>> shrinker_idr now contains only memcg-aware shrinkers, so all bits from memcg map
>> may be potentially populated. In case of memcg-aware shrinkers and !memcg-aware
>> shrinkers share the same numbers like you suggest, this will lead to increasing
>> size of memcg maps, which is bad for memory consumption. So, memcg-aware shrinkers
>> should to have its own IDR and its own numbers. The tricks like allocation big
>> IDs for !memcg-aware shrinkers seem bad for me, since they make the code more
>> complicated.
> 
> Do we really have so very many !memcg-aware shrinkers?
> 
> $ git grep -w register_shrinker |wc
>      32     119    2221
> $ git grep -w register_shrinker_prepared |wc
>       4      13     268
> (that's an overstatement; one of those is the declaration, one the definition,
> and one an internal call, so we actually only have one caller of _prepared).
> 
> So it looks to me like your average system has one shrinker per
> filesystem, one per graphics card, one per raid5 device, and a few
> miscellaneous.  I'd be shocked if anybody had more than 100 shrinkers
> registered on their laptop.
> 
> I think we should err on the side of simiplicity and just have one IDR for
> every shrinker instead of playing games to solve a theoretical problem.

It just a standard situation for the systems with many containers. Every mount
introduce a new shrinker to the system, so it's easy to see a system with
100 or ever 1000 shrinkers. AFAIR, Shakeel said he also has the similar
configurations.

So, this problem is not theoretical, it's just a standard situation
for active consumer or Docker/etc.

>>> This will actually reduce the size of each shrinker and be more
>>> cache-efficient when calling the shrinkers.  I think we can also get
>>> rid of the shrinker_rwsem eventually, but let's leave it for now.
>>
>> This patchset does not make the cache-efficient bad, since without the patchset the situation
>> is so bad, that it's just impossible to talk about the cache efficiently,
>> so let's leave lockless iteration/etc for the future works.
> 
> The situation is that bad /for your use case/.  Not so much for others.
> You're introducing additional complexity here, and it'd be nice if we
> can remove some of the complexity that's already there.

You started from cache-efficienty, and now you moved to existing complexity.
I did some cleanups in this patchset, also there is Vladimir's patch, which
simplifies shrinker logic. Also there is already 17 patches.
Which already existing complexity you want to remove? I don't think there is
existing complexity directly connected to this patchset.
