Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14266C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A94062086B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="gkNCcJbI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A94062086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731364AbeIXWJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 18:09:55 -0400
Received: from mail-eopbgr80128.outbound.protection.outlook.com ([40.107.8.128]:8352
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730943AbeIXWJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 18:09:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZvQ4ea52KxXDFTFZLe0NAa0pixtpBrR5eyCdmsMX3Y=;
 b=gkNCcJbIpvp53q6SuZ3DqasRExIWuMJPKogQh+pLVxTL5j7PFmRUMhl8IfyuPRr0AuIbqtL+d9YubMOhnWvisFnfstK1kebJRjJJu0/QaG1QP7IHIMwqguB/N7Lb/0RqQKuhdZFrieD1GNLp3MLic56pX/Sv3P97BLCMyThOGxY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com; 
Received: from [172.16.25.12] (185.231.240.5) by
 VI1PR08MB3264.eurprd08.prod.outlook.com (2603:10a6:803:3d::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.22; Mon, 24 Sep 2018 16:06:55 +0000
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
 <c844c598-be1d-bef4-fb99-09cf99571fd7@virtuozzo.com>
 <1537804720.195115.9.camel@acm.org>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <10c706fd-2252-f11b-312e-ae0d97d9a538@virtuozzo.com>
Date:   Mon, 24 Sep 2018 19:07:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1537804720.195115.9.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: DB6P193CA0022.EURP193.PROD.OUTLOOK.COM (2603:10a6:6:29::32)
 To VI1PR08MB3264.eurprd08.prod.outlook.com (2603:10a6:803:3d::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8315d83-8cee-465a-3f00-08d62237c080
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3264;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3264;3:czKJIUts5zZR7JDekhJrjedcxakltMEWpho7QyOe5pNYXcOzH+hBgWrTPdmufLJ7ZeXTaMs4Alg+t2XO5GOL0GHbX9O0Wo/i5tyNvajvylC/u77VLZnifr6hmaoX51YsFBbD6T5EINw39iTa8G/OLidIt0rytDeJnCDg7+8ekvI7KiLtzf7XJ1vUxLy+LcYksAFBia2vHWH5awJNy4i5jRe3PwHnEnems+WmET2iKTXAaVBQubaDf3I+5x2M7yfk;25:rlsQmeleJJy7M05h1O21N2x6gEN/5DyovNdLAox76csuRYZXg8Sko4vkOo7BCtt/sRsNfGVRALDC8iMgyad7lDVPxqx2B2OC2pRDatKB2bhNtx4qmMwim6xBLadsNLkN6eg7E1rkBR/3q5WvQ3G2MYGKZ6Ig1j0mcvFYkBca5NCgD5/XgSEnfjunfAkRTPb2YQMEwPfXMh6/8QMhaZFF05dXIpS8h931HeIDW1CvHrILWcj1Nc+lS6BAUOVGR/oPBvp1u3qiXIenX1aarTjNi3ePW2JQtewhf86IjIFvVXOO7ClHLTySWZYKevI+p0LG2HGLYcRGbGaMIfL4H+FQ3Q==;31:R7nT+eSuUIvyOECyc9qKLn2FkH5eYFtCt2pW29bkj1m+oMr8eFl6a6K1hWsAPt519kup36aMIX9lIWy3NRtocxMMfRJBmD8KdtmZpCwXZBOMKv/nPIZxPj2battSHXFUPpEr/mx/6U+IDt3KUlnjLKVUrrGovFuWE6QEs+w72/xwflIMj+qQO7u9tbbmj75iqHGqfXtL1TYtLrcMiu7sOOuNzThr8AIFaWDvkCT368w=
X-MS-TrafficTypeDiagnostic: VI1PR08MB3264:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3264;20:8t4w89icfukBSghLbz+pf3x6/Ug03AAsZaV/R39aYyIvDrAJ0mhUyokM9Hmavqn4tURvQPn6SsNU/INQy58dVzd77MhVTYlWlVvW3rWM0eGmBtsKPgC5J0fm794xo4EO8fOpIdC7J3Lf3AfMtULx3xWN7AfNGxWDP3/MIEhTbHMJZfQEomPUQGf0JWg2vo+riFKbaaoTw0+oNqOYhvRmHiqSo5cdV/XBr+KoUhZiCQWXRpnPj5RDfaxwMTh1DqYpNE8XffUR6Bks+MPjrAhVuP/GCpEbZwEXe+vWS2ujEgb6EIewwyEB6DhC2NKzCmA1go0qjZ8InHFlMsXleJA4Hmuh2BKxbTtA9sfSKnIMG8B6H0RPDhVoNugez017txdjsleBFEhxWwQaUd4hYGX4K79cxek3lvtYXSfm7VPnP33Gqv4lOq4qD5ZAJJS/wvAed4m76nNMAXm2LqpO//+bqGFzlGtaRmqdqOL2sq6BgaVbucdxGDqM1D38eCY+s2Ev;4:Z5cmQWf9RU1UaB8UWacWkM5vgQvDiMgZGyWtcyCm+FgaKX5CXQx0BurU+CpJV97JpTdQm6BnXYGM52TbyRmYnPk+lbLtzPFrs28oNUW4cR+Bj4eE6hOYaVHaycekoxGtLJCtbH84ETpkXnjAfaTgz+DKJY+vin2h6Mvnk3Ocl/VBymbxrKTuz8hRN+4AIw01mMPpSFceAATZ1Q3vaWtp5q6retpDCjUEpH6r+iMH6DxwR+9l4y+r5czSqHKDwbDVmu8d6KNM25I9c6W7OyAeIg==
X-Microsoft-Antispam-PRVS: <VI1PR08MB326445FB3E5BAF2B93272099B0170@VI1PR08MB3264.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(149066)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:VI1PR08MB3264;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3264;
X-Forefront-PRVS: 0805EC9467
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39850400004)(136003)(346002)(376002)(366004)(396003)(189003)(199004)(7736002)(31696002)(6666003)(486006)(229853002)(230700001)(966005)(2906002)(2616005)(956004)(476003)(86362001)(575784001)(6486002)(53936002)(305945005)(58126008)(110136005)(54906003)(5660300001)(36756003)(386003)(53546011)(23676004)(65826007)(7416002)(76176011)(52116002)(6306002)(26005)(446003)(66066001)(65806001)(8676002)(16576012)(6246003)(77096007)(8936002)(81166006)(81156014)(68736007)(39060400002)(4326008)(97736004)(47776003)(25786009)(478600001)(11346002)(65956001)(50466002)(64126003)(6116002)(31686004)(93886005)(3846002)(16526019)(186003)(106356001)(105586002)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR08MB3264;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4TUIzMjY0OzIzOlNycDJ4UWVxdmlNZ24zVWxOY0FsR3hIWnFr?=
 =?utf-8?B?UzJJZm1wci9GWW9CbVdYbE1EWHdiS1RNVERaMHFhM0lQdG9vbERJejZLWThr?=
 =?utf-8?B?Q0lZWjFBTnMzeDBOT3hpcmFKVmtFeVl6dXZIZHpmbnp0NCtZMjJ5SEVnSnhD?=
 =?utf-8?B?MTVSMXBUMmh2a2lkb1QyMFgxQURMV2k1WUFFazZEWnpybCs1WWg0RWZPak5U?=
 =?utf-8?B?dUdFY1JlKzJOd2g1a2d2MWVxcnpuV0IxZG1PMWVNMmxNbzkwclNYYkIrWFdu?=
 =?utf-8?B?N01qUWx2WTI0T2U0a0lhdGFRR2dkeWwxR0VUb3dRRS9FT1A4NExmWTU0MUg1?=
 =?utf-8?B?QXY1eTlwM0JPa3pTbDgrWFczVWkxdHF3VFRhWGVXZldaYjRSK25DMnFqWTZl?=
 =?utf-8?B?YlFBSC9Wd1lZN2I4bi9obmJIMVlZR0pMeGFWcWhUQzUxZ2ROaDFsVUhZN3gy?=
 =?utf-8?B?K1FibncwdDAwbGFpL0dHTnZzUFlvdHhsR1psQXFpQm14RXYvOW1OR0RZRnFi?=
 =?utf-8?B?Z3Azd2NSMjU0ZTZiZ1gyT2oybEpVcWQ0R2RQK2M3QTRSSWtUVDdYekJzalJS?=
 =?utf-8?B?UFNLMmM1VDVFNHluQ05rRVZwQXhxYlk4OWFvYU5BbGtOS0JOWjkwYWdya3Jm?=
 =?utf-8?B?THNtb1FQMDBaZThpSGwwd0Fvb0Y2cXI2YzNmTzdEUjVIUUJiV2N5dXpkNXVl?=
 =?utf-8?B?TVhTSTd0TjhJVHdZbkU2TVhuWmdxNUorWUR2c1o3SWM0VUR2THNoQXp3VGlK?=
 =?utf-8?B?dXpGZC9lN05pMk4vNGw4RGs5ZjRLQ3NZTys3ejhENXE1dEswaTc1NlhWSkdw?=
 =?utf-8?B?ZkFzMDBPVjlaWjF3enpYKzJiYU9tR1Q3MTBSSTZyWVIrMEphR2tSb3F0OS9k?=
 =?utf-8?B?K3ljTUU1ZGIrVDltMHBnZHhsYWtCdGc4N0I5YjF5eTF5YjY0UEpiTnBzaEg3?=
 =?utf-8?B?ZWY3MStuS21Zb0VDdzNzOWNUTGdkUUpFN0xXWHdHNHJ4RGRhQ2tOVlpJbVZX?=
 =?utf-8?B?eCtrSG9NS1FNN3cvbXJRWFJGZVA3U1crYnVQUkgxUW9oWCsyZVh3YTNDdURL?=
 =?utf-8?B?UHVqS0xPczZRTmZwanU1bTBJeXNESVFHRXhOTVF0bjNVVEpNRmNPLzBYeWg0?=
 =?utf-8?B?ZU9xbUsvTldDK3Boa2NQTEJlTjhleGJ0VVNuYkNuT1hFVEluWDd3KzM4Z1Yy?=
 =?utf-8?B?YTl1QURrNkxiOEF3amI4TVEzakZONnRTdnBiZ2xnYmRtRUo2enp2OW9HM1Bl?=
 =?utf-8?B?NXg3TXZSZHZESnJpbEVFR0FmT2pHZ0xad296ejN5aFlWOG9XY3llTVR5c0RF?=
 =?utf-8?B?R0k2Q0p0b3hGdmxPbkFuTUdHaFZDSEplT09xNW5MTmYwUFdKaS9CTXcwb2dS?=
 =?utf-8?B?cXRzdHhXMXRCcVk2OWIyYkV5VEZadHcxa01ZZTRQY2o0eVdOSUZ6MDU1ZWxC?=
 =?utf-8?B?MzBzNEsxYTFBQ0luRFRIQ0pESzBZaEJ0REFyNDdwMzVLRzVaL3VaTmFwZk4z?=
 =?utf-8?B?S1Bab0VkTkNMRDg5dTdmUUQ5ckJHb25tLzhvTUZxTHZNTERoU2NqYUFLTU9Z?=
 =?utf-8?B?a1NzVFRjbDUxZ1k4OWRIQmpaMjFPck1wYnpobE5BR1RHbGVjSG9MVS8xaE10?=
 =?utf-8?B?UVlEbVJGZEczcjFBTkFTL0RHdHM0clZjVWFERy85VU1LNjQ0by9scnozTGtN?=
 =?utf-8?B?VWpqWnM2UitsenZQSDkrODcrSFRDdW50NXlqdkRVV0dWTXlUSlpQbjd6Ti9j?=
 =?utf-8?B?bGZQSjNvTEYwWnErOGpGb3F4ZGRWazRuTkNGTnBvVGVDNmk0QlFiZTNSRG1S?=
 =?utf-8?B?cTdhMzV5RDMyOU1CK3ArcTk4aDBPZkdocERDaHZuYnlERm8za2dDZlUzQ2J5?=
 =?utf-8?B?bVJvUDVmVkxZWmMvb2xjU1ZjTUlYMCt6QlpOL3R3S2JidDFPZkxETVk0aFhC?=
 =?utf-8?B?ZmdjeUlsMUxnZEVMdzU3eTNIbFYvbW8rS1k5WXg1bGloMHlSM2dBVmk1VEZl?=
 =?utf-8?B?RnZ3NWZkUmdjbUVyVS91SFVObk13L3NEZ1VlZjRXVGNzckVuYmtFVnBCdUc0?=
 =?utf-8?Q?A/Vk=3D?=
X-Microsoft-Antispam-Message-Info: /gBlM5H2XXKWfa7ndn4kgYDE2F3MiQ6eEAZjQTXe4DfaUwfbHhHOOSmLJrI9kVf8jER7jM4gnitVZvf3UL5pvP8ea88Hgaf4xCyqUm9+wnQ8nMBZlq4Kq/rLED/LnGzKrz586SGbNg5pHnzrNjqgo4xSmFzCyLYS8PClqVugn/Q38W6VMTaSjjCrWTkFzWov0G61Nf8pb6fXwmBkrFAlo7jNjZ3U/M4MNW01z17YX8r8P9U9obiiu3mPlj3l+vlWod36SFZNdu8LThLSSMPT7f3lw4avH/j6TvPZkHak5dpOmlGtx7BpxP0DFVa0JqzBRU5Xbj+A11/7lpCa2VtbW0eSbDjRl9TrsPuPXPaGlhw=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3264;6:Yj/cfuiCM0I8dapeVNJ03BcFiBSxnozokGFy/ipVYS+eT0qOgtSKaKhO2JtFWYwXIMCi+E4kyWtY3HDBMNVSZfejpXGDOI8fpMA6NjCRguNH5AH9pA52EMAkV/liuupcDp644KcRtuNwhTsQEueNrOkLyqZF3ZoWzJ67VJsPjGMCN613qOjFmkPbkvtxaPHIUJxMdf2bs1MLwfPqRP4L2/e6lWtRF7fD8Pc9jFeRYPes2MNgz3pU/T68BfBUYLRQuwWiDDQjC/d3jNax6esVqD8J+gGGcMECjD6GW4cu0k296IRHHspIRV1FMguIO25hfKvWX0KsU7vjvK3xNdmiZNvamKlUBkNgR53rsTNfCas/TSDY7uf8AB53Q5W0QLQwIuAGdsBmBsSN0Xy+LvzCtJrPFAmuWSGBBvWLmKg5DrHsrmhHnVtaBoGeSYO5Q/Jbb4aDzyAFJC3BFht9A64lhQ==;5:kP/bC0/PlYIjQQ+r9LBWWY5IwwUsHGFeW6K0jO1SqizhMtv1xiCi0egOlT7dnid9IBN0EGjVF+4ES3zXrdFubG4noWj2MJlV96sW3f8FzXY6a1MxZRJbPy1I6D3+jfEwXjByWDmzW2i4Y2OZwlkCnnb5/wDr3Jwcz/FRzj4MH8Y=;7:vfnugEnHY2i48ZDQ2TP/KZNsUr+SUYteH3QRGP0kpeOF0Ran1/mCoG9f4UT0zlOV+qmfPizKpHbl0Em3ruRtHTqZpcYAKG0A4zGOHR6jBozi0O3sCt4kX7fspk6zoOKtrSo5TKtwb4xsZDDU0+mqXAwBJGiCb4EyZHOkgukVDBvcSTNJ0J0INi2kvyXv3xcIm/znwuqQTQd6JXrPvZdJiO4XMJPsh0YJNEo5KUQE2jsA3VrQuk80FIH13sEL2KkZ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3264;20:HjSH29EMwi4pklrFn++Fa/2ehfb5eJ+NflK4ABpKbM0LiYZksiCA7RdDv1y7yLaRIUdeE6FqVXQNqQgjW5fQ+6ViOyNzmRqc+lzClP3XQHCaXBI3EUUXA/WQtFXprf4INOO4zbll34O+H51W1Sfd8WlYnYRnt19HARY9FSKC3kw=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2018 16:06:55.0336 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8315d83-8cee-465a-3f00-08d62237c080
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3264
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/24/2018 06:58 PM, Bart Van Assche wrote:
> On Mon, 2018-09-24 at 18:52 +0300, Andrey Ryabinin wrote:
>> Yes, with CONFIG_DEBUG_SLAB=y, CONFIG_SLUB_DEBUG_ON=y kmalloc() guarantees
>> that result is aligned on ARCH_KMALLOC_MINALIGN boundary.
> 
> Had you noticed that Vitaly Kuznetsov showed that this is not the case? See
> also https://lore.kernel.org/lkml/87h8ij0zot.fsf@vitty.brq.redhat.com/.
> 

I'm not following. On x86-64 ARCH_KMALLOC_MINALIGN is 8, all pointers that Vitaly Kuznetsov showed are 8-byte aligned.

> Thanks,
> 
> Bart.
> 
