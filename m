Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id mZ4XANlzGVsjewAAmS7hNA
	; Thu, 07 Jun 2018 18:05:39 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0FBE06089E; Thu,  7 Jun 2018 18:05:39 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Zo/iZwrJ"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0180B606DD;
	Thu,  7 Jun 2018 18:05:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0180B606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936008AbeFGSFf (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 14:05:35 -0400
Received: from mail-ve1eur01on0099.outbound.protection.outlook.com ([104.47.1.99]:19328
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933080AbeFGSFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 14:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mp4fV90AxSi1QNCVUjbtAUM3O1P20FZ1N8eGeh3+6ww=;
 b=Zo/iZwrJuoHT27qQRJdw5z1oKpe9UrlIOGFbrLxrqc8PD2Kph6DzheS75MxplWMsxf+3Yqv6V3QV696XdqFwnZqrVMhF7jA2TtFrMIRgTKY+aBm2Tz3cNyKycHZVMpFRP6jpCbZ32wWcswBEfL1abZvvVKrWMw73nds8o20eXVU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Received: from [172.16.25.5] (195.214.232.6) by
 HE1PR0801MB1338.eurprd08.prod.outlook.com (2603:10a6:3:39::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.13; Thu, 7 Jun 2018 18:05:24 +0000
Subject: Re: [PATCH v7 00/17] Improve shrink_slab() scalability (old
 complexity was O(n^2), new is O(n))
To: Shakeel Butt <shakeelb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        stummala@codeaurora.org, gregkh@linuxfoundation.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Roman Gushchin <guro@fb.com>, mka@chromium.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Chris Wilson <chris@chris-wilson.co.uk>, longman@redhat.com,
        Minchan Kim <minchan@kernel.org>,
        Huang Ying <ying.huang@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>, jbacik@fb.com,
        Guenter Roeck <linux@roeck-us.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>, lirongqing@baidu.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
References: <152698356466.3393.5351712806709424140.stgit@localhost.localdomain>
 <CALvZod5==RV=emZ_gqC1UhGsx7W=YkMtSXJ-Uzc04HQH29zERA@mail.gmail.com>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <8d3d8b28-8b80-2953-45ac-cbaee6147ccd@virtuozzo.com>
Date: Thu, 7 Jun 2018 21:05:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CALvZod5==RV=emZ_gqC1UhGsx7W=YkMtSXJ-Uzc04HQH29zERA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: AM5PR0102CA0003.eurprd01.prod.exchangelabs.com
 (2603:10a6:206::16) To HE1PR0801MB1338.eurprd08.prod.outlook.com
 (2603:10a6:3:39::28)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1338;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;3:FUu7qBAasPVL/8GRgflGSt5jT/+rHZJRFPrQGZi8kgfnWeuqwVYjCjPrRctwwqVKdH90iMRUErCkIOBzlOZ1M81jYCDw9xVr9nLYSAgLg/FbqWFKTh+ovpwGm0DbNuZ8LWfvhOVL3EEiThtgf2No492tD9DIJWGSo6WdQW7Tbclyso2GIooMMnwXojnWTqpauXR4y+2Huv5liclKI6frSo4sFfL1Pztfk7S17fkWXUyEvHc9NzA7u2vFqAd58sDv;25:i7mxbj02Df4cTVvOKSeABEjte05Gbp/4Olt059rILygdLBCvYPWuuWOHk9vdhi215yHGlNEPmi3idbwW5DOfQOCpkKwlCGptWxrhrdm8NCE6RFBGoD/lBRcd1w8BHs1biba5K5evhr3Acge4gmvJIM1l4MBEfs2g+YXcOME4hjfiBRTIV9EeY6BaihBugp4iYM6Soh1YYT36qU+m6tJJJxcsfHvV3LupkraQc2XTeZs1R9ezMJumfw7VsDLVAGLNjM1mgFLOimGv6Lrq/ncBLgLoDqNNjg5WmRzNzyLv4oR8gRCwT3Gwa12Vip8Z9k2t5S1wXz8wansYOu2nq9cDCw==;31:oO7P4PffBnUDFSihOBOh4P5fiwKVwq/EDlf4aYTl6DJwZlBWED7OVs4BjABGfI7T1Ue0fJ8mVL3tzqmQ+aMSSJ7GlyoKdz0mtYmjEr/krIii1OeyJcPZpstAhxJbQC6bvV3NJiAoKBuaV/uPwYTgV1uFBujOxS3q339zH0lFu+Ea6fx3tvE5oWHM37W8Tj2mSDaNbveBhmTDJrMa49yuIjGeOteZ8/7TBvbai54Heds=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1338:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;20:nL8EOcsiPBHPJltNu1D5XDScDAfEoCatQRLcWCJS4XHFPMM24WFGzCBL07sAKYXTGVTNVr7GiduS9V3FLteKNpOzgKIAumY/TMdNxEoge004BPfCLzn+AwF+azQsSR/tBjHVKqpELTe4OHaozzHpdA5ny+8rF5czKTulcjesW77qlFky6nVp5AKufd/eIDYQmqwhfl8LW7I3omv9rtVkw4k2v9VzhsM86BSp9yAeynWXWjpyyZDYbjLqH3ZCe50lL3/0li2sDV5VCd2RW9ixeuR1VhQsqmMEXMiwPY8hWUlYp4DG7rCnyej/NtEOTdl785l7DWjPTixvGEHWf4/hDVw1h3Vo3whdZr5bHxxty6WUJdmbzadrXwt1K1Tr729jhsM0sSDFXxoWIJLJ1xfeLlMykeB9keuS5uy+AkFXsxVIc4acGG+dGW6i/uK5au8OwgdVtVBp+b4phZP+gxbwC6nDJbUrkp3zoXpB9lkux/doYQyHVPxPe0mhmZSsCnTO;4:yN3BAyoY/5AlOrOzxOS2Ggl5ZrBE/DqYTq5oe94h7AW3f0+zyZchdJyafe5ypGXoWsUSIXqmYrrHGxOAp25CCXS0MDVJ2Z+LeRxwWrb+vhdk9lv+1r/U8pKbilODRIgBW9gcC84o+aQkaVzjYc+Cvp+CWJrjXj9TXJoopWfdZ3e6RF+E7Dk/37SXsCkxbGYk5xRJc7yGowQFgAs8/umNttBQwqaCrkPFhreVziFRZgtmAT15NINzMt9h/ufclmglBSOPolH0UO4Vk34mscj0cg1tZ2nxD3ZHIQGXDHpOOwGgljMkFBaOlfjov4xIYXL4
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1338941B92FCB9B205A32742CD640@HE1PR0801MB1338.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(131327999870524);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB1338;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1338;
X-Forefront-PRVS: 06968FD8C4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(39380400002)(39850400004)(396003)(346002)(376002)(189003)(199004)(51914003)(31696002)(3846002)(16526019)(77096007)(39060400002)(386003)(53546011)(16576012)(25786009)(4326008)(31686004)(54906003)(106356001)(105586002)(58126008)(316002)(6246003)(76176011)(26005)(65826007)(107886003)(59450400001)(2906002)(64126003)(6116002)(229853002)(97736004)(305945005)(5660300001)(2616005)(50466002)(7416002)(478600001)(2486003)(23676004)(52146003)(230700001)(53936002)(36756003)(52116002)(6486002)(6666003)(6916009)(956004)(81156014)(86362001)(68736007)(81166006)(476003)(7736002)(65956001)(65806001)(446003)(8676002)(47776003)(11346002)(8936002)(486006)(66066001)(81973001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1338;H:[172.16.25.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzg7MjM6N0JwaC9Sd3lKZkw4Y1RCM1IxN2JXcG9Q?=
 =?utf-8?B?NitMc1NnSWgwbCtjNmFzT3RtRFFRL01rbVh3NlVHM3Rxd2RHdzh3S1pRRkpr?=
 =?utf-8?B?TkpYbXhya1ZlL2FMZ1pKOU5Qbi9OYkMvWCtVV3ViNU5UZkFSMmNBeVdSWHM4?=
 =?utf-8?B?TlVMNmo3U0xlTm5oYmx4WnJNNVp4dksvR3FPeGlwYmZHRGxScUVTUVF5WWRN?=
 =?utf-8?B?bnExT1Y1Vzh2akRvRFZEbjUrSStCdlFTakxnZCtBUFk4WHFRRU5YNi9mRlc0?=
 =?utf-8?B?RVhkUFYyRzI3eXhPYUFoaEcydWhPSktybllDZHVzWU5RcFZGa3BnU0pEaE1C?=
 =?utf-8?B?MFVETVFmRWlPSHJrWE16R1NlSWUzZW9VU04vY3h5bmMxQXVzdWlycyt5dWJS?=
 =?utf-8?B?b3Bqbjc4QmpCZTJRajgya2N0T0ZUcUdQSVp4ZmYyS3pRTWYyNm9VUk0xZ1VW?=
 =?utf-8?B?MTltbEtmWWE5TXhvaWNZK0RKMjd0MVlvNTNGeCttVjFVaHJiNkN3TVkvN041?=
 =?utf-8?B?L3Q4eG1HK3RQSnFreFNWVVRmVlNhSzNSNDFvNWl4ZkF2ODZaNWFHa29vQjhV?=
 =?utf-8?B?WVJDZFBkV1pKTjdMbm5udjROTmlIUEZJUisxRXBnZHJLYnAxTHN5bGQySU52?=
 =?utf-8?B?LzJDVHE2anN3V21hNjhaSStwWURBbSs3ME5ONitaM2Rrb3l6cW5CMGxjVnhK?=
 =?utf-8?B?eHZ5YTdwZ05lNmRFNGVoVlpDNlpVUndtaGk3K0NIT0lBeG82SVZ3V1FmNWd2?=
 =?utf-8?B?U2EvbGdhZUZuT21saXdaaFB3bEtIUjlrZ2FPaWl0MlpyQTI3anE2WHhuOE51?=
 =?utf-8?B?N3VJZm9iWTRSWFZ1dlRHSjQ2aXg3Y3BuQlZ2eFNOMTVVaUE0NE8xa2UxZGxM?=
 =?utf-8?B?ZVJzMWYvT1U0MWxIMXUzTmE1cnVxUW5ieU40Ui9YNG0zVjRSU3lCa3ZES1Jh?=
 =?utf-8?B?QVVERVMyTGpBNXhxYjgySVdLN0JzSHJaYWp4QUlFOU5za0s3VW1CTnhqM2lC?=
 =?utf-8?B?Q0ZrdDFsQWVTR2J2eXdpdkdhdDcvd2U4WFR2dnQ5THpTamw3Y2xuL0tya3c5?=
 =?utf-8?B?dmZNV3p4Qlc4SGIzbFN3aC9aclVxcFN0bUs2WlI5VUphVTFKNUlEaVhTOHFu?=
 =?utf-8?B?VjNWR3ZKTmJaWDdKNUhxczExTU0xQmtaTW8wT1czUURud0c1NmNNdnUraGZZ?=
 =?utf-8?B?NEU1Z3A2VmFQY1ZWOWI5S2gwblRlWDQ4NjJlLzdzUWxHZHJVUVBDZXc4bFd5?=
 =?utf-8?B?L0R3OGxnblphZkp0MnNPRldBWVg3citsNTVZM0J5TE95NXRYdld6UlYxZzZ3?=
 =?utf-8?B?MkNnUEZUdHNOdHV3eUNxcHhqcHRtR2s4TVlXU3htbXg1eUlQTGFoU0Nsd2Yy?=
 =?utf-8?B?dENITXRnQW55czlja0JjQ3JEbHNyblZidjQyZGZMV01aazl2NGxHZUFpTUt4?=
 =?utf-8?B?ZjY0UWQ5ZFpaeTcxYStMcFkwbzBUK0xKcFJlYkZLQU9vNkR5YzM3Vzl6R0lr?=
 =?utf-8?B?UUNLdFlZTFZEVURCdUFSbENTWkpUZnVxMmFpNlhleWZIWWxmblpQL0tJb3NH?=
 =?utf-8?B?R09BSmVESXNIV1Y0dEpGdi81dVJObTlWTmhJUWZ6Yk1NMy9aUzVwVmNkQ1pV?=
 =?utf-8?B?aWlsbEtpY1FnQm5WbWs3K0lUbU1tMVpSaW03ZVp1d2dpV0E2UnpHbW82bXBo?=
 =?utf-8?B?N2labVE1eWxOMnp5SEppTjJja1dsblhBTFJVNmY4WHJGQ3RKOHFhZllSYVR6?=
 =?utf-8?B?UGxYM3ZPTFVwak9qWTdXZlBhYjJmN1hFMStwT1VIRnhwUnZ4eWdiak9Nek44?=
 =?utf-8?B?OFBnVEc0V0NBNjRvZEtLaDk4MnNEOW5NWUY5SUpMcncyalFzZktlb2pqdVgx?=
 =?utf-8?B?cTZCbWpCZW5rbS92a1hjTGdGRHdvdi82TzNDbUxndHlvbW4yeGlwbHlaY3ZI?=
 =?utf-8?B?MC9SdlY1U2NuYjd3c05FcWV1bDJvTlJSTnB4TzdMS0pOdlUwZlU3bXA5T2JO?=
 =?utf-8?B?Z2RkTHJQMi9RaXl3amZHSTc1UVljTVRaMVZDSUJFK0hlVHpzTit5ZXFyQVQr?=
 =?utf-8?B?c1RYUzhpYnFZc0FLeXZVYy9nSzkyMkxqRG0vQmxaenVtUGdLblpTbEtTYXhO?=
 =?utf-8?B?Y2pqQT09?=
X-Microsoft-Antispam-Message-Info: K+zwMR+6MlS07k9g1QqeFpbLbs/DSw2mt+sJQGcAB60D9xl0aSrO8gCUz4TA9xz3qYO2sy6sJ523682SQTh+F4G8matOv0pmpB1eM4UdcOclVFwSzJOkc3h8ZgnYBRd7NqOyDtExvTFg8cl+Hqpg/EahmLmcy5KNT0gF/pu5E8BKQnqPXpnIlNjF0IK1wRcn
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;6:l44GbhVEe0Z2tNbOC9vfGzJrD3TMSI6p9oICKELT3UU5qcTGNrqsKURoEdgwtFOX9mnCw9JTV3g6SWUSponGM+GnAe7EieVSkla8IK5ISjrXYEkMRtFTs4mh56wBTZ3sIZ6wgLrrHLavGEdyRzAk4qzzrUl63swiUA9C60UPZTYnI3p/NCFylOh6+HJ0JyYNGgfU71rAeVPr85gAdXwh/2wy4pOz3qZsCfWbW+u/fJrw+y5cNtuAV11vrGHc6gr5z8mF3cgsfxBl67nyPsHzWiuDJcrnThAx5tbkf5rwzb0XKHAmgC58MGW7yVHPKbxmNL6RezN/2ZgvBRuninaJmoXj3V4HR4dLPISnAzjrtPlkarCFVsIyUGnBUVQEaiXlaVMnId9jarYxEluJ3fYKRbh5PQgHXZlfOE6LZYPrG1peKnQrqNBG8AvIUoj+lBJBeTgMGITeYYV+JWSsqoK3+w==;5:sv0lK+03yYrtDO/drYtNsow+PDTOA/xubFXV/Bo3r6SHCqRfkLJS3oJwxZfb9sJG8i/p+NGA++hCqm5x6CyPcMFMMOtxjCRhniSBEhdc5/EBKof4Uxph5Jz2GfORk1IbG4OjP77d5eB4vX2zdQ9sgPmUyAV4SxSStKoy7+j6MCw=;24:hzJpmg4Y3ztAEad69R+3pf5g3lEvwXmTEb+qBsc7YCsqbRJw1z8cfisttYzcpOEZ+d7ghcrPqVTNO9OuZyZt4RjWUxEsVlSnmXla8oFeMvY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;7:8/s7n92oLNXOI6TB3XCB6n0eTknJNkC1cLS8G1skDYwawoZlq099nm0ZiN8+N7bJZ65mT2N8xlO3QO6PABOSHt/bTYM+g7b/Q8aKvS8Hycr81RaT2aREvs3zijXB4jkiZAkVdzhWBZRUpAwQpXqrsF07FM7vGsgIWDMcf8SpK5sqr4wmwJ0PyBkVYjeUAO0Pn2/ffkwU83lpr449I4M6uiy9woMW8MlPuRW5vviTfEvr5gUVMt1shKcMJO74XD+r;20:X5kgSq/ZPO8j78QwzWNcK0g249GbDsmlHycqty7gU2UAJN02L/ftNzHuMAwhL7Xjvn+iF7xG8yut2AUTEYn8yGuRD2JS6E7GhAuYvzyrnw6oHLBHVhIYQtOKsGQMGKfXrDUVvZ4m493ULoXzxw506NkiFgENwagCk4i8iKZXF40=
X-MS-Office365-Filtering-Correlation-Id: 09aa456f-f503-4363-87a7-08d5cca13f6c
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2018 18:05:24.7944 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09aa456f-f503-4363-87a7-08d5cca13f6c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1338
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Shakeel,

thanks for the testing results.

On 06.06.2018 23:49, Shakeel Butt wrote:
> On Tue, May 22, 2018 at 3:07 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>>
>> Hi,
>>
>> this patches solves the problem with slow shrink_slab() occuring
>> on the machines having many shrinkers and memory cgroups (i.e.,
>> with many containers). The problem is complexity of shrink_slab()
>> is O(n^2) and it grows too fast with the growth of containers
>> numbers.
>>
>> Let we have 200 containers, and every container has 10 mounts
>> and 10 cgroups. All container tasks are isolated, and they don't
>> touch foreign containers mounts.
>>
>> In case of global reclaim, a task has to iterate all over the memcgs
>> and to call all the memcg-aware shrinkers for all of them. This means,
>> the task has to visit 200 * 10 = 2000 shrinkers for every memcg,
>> and since there are 2000 memcgs, the total calls of do_shrink_slab()
>> are 2000 * 2000 = 4000000.
>>
>> 4 million calls are not a number operations, which can takes 1 cpu cycle.
>> E.g., super_cache_count() accesses at least two lists, and makes arifmetical
>> calculations. Even, if there are no charged objects, we do these calculations,
>> and replaces cpu caches by read memory. I observed nodes spending almost 100%
>> time in kernel, in case of intensive writing and global reclaim. The writer
>> consumes pages fast, but it's need to shrink_slab() before the reclaimer
>> reached shrink pages function (and frees SWAP_CLUSTER_MAX pages). Even if
>> there is no writing, the iterations just waste the time, and slows reclaim down.
>>
>> Let's see the small test below:
>>
>> $echo 1 > /sys/fs/cgroup/memory/memory.use_hierarchy
>> $mkdir /sys/fs/cgroup/memory/ct
>> $echo 4000M > /sys/fs/cgroup/memory/ct/memory.kmem.limit_in_bytes
>> $for i in `seq 0 4000`;
>>         do mkdir /sys/fs/cgroup/memory/ct/$i;
>>         echo $$ > /sys/fs/cgroup/memory/ct/$i/cgroup.procs;
>>         mkdir -p s/$i; mount -t tmpfs $i s/$i; touch s/$i/file;
>> done
>>
>> Then, let's see drop caches time (5 sequential calls):
>> $time echo 3 > /proc/sys/vm/drop_caches
>>
>> 0.00user 13.78system 0:13.78elapsed 99%CPU
>> 0.00user 5.59system 0:05.60elapsed 99%CPU
>> 0.00user 5.48system 0:05.48elapsed 99%CPU
>> 0.00user 8.35system 0:08.35elapsed 99%CPU
>> 0.00user 8.34system 0:08.35elapsed 99%CPU
>>
>>
>> Last four calls don't actually shrink something. So, the iterations
>> over slab shrinkers take 5.48 seconds. Not so good for scalability.
>>
>> The patchset solves the problem by making shrink_slab() of O(n)
>> complexity. There are following functional actions:
>>
>> 1)Assign id to every registered memcg-aware shrinker.
>> 2)Maintain per-memcgroup bitmap of memcg-aware shrinkers,
>>   and set a shrinker-related bit after the first element
>>   is added to lru list (also, when removed child memcg
>>   elements are reparanted).
>> 3)Split memcg-aware shrinkers and !memcg-aware shrinkers,
>>   and call a shrinker if its bit is set in memcg's shrinker
>>   bitmap.
>>   (Also, there is a functionality to clear the bit, after
>>   last element is shrinked).
>>
>> This gives signify performance increase. The result after patchset is applied:
>>
>> $time echo 3 > /proc/sys/vm/drop_caches
>>
>> 0.00user 1.10system 0:01.10elapsed 99%CPU
>> 0.00user 0.00system 0:00.01elapsed 64%CPU
>> 0.00user 0.01system 0:00.01elapsed 82%CPU
>> 0.00user 0.00system 0:00.01elapsed 64%CPU
>> 0.00user 0.01system 0:00.01elapsed 82%CPU
>>
>> The results show the performance increases at least in 548 times.
>>
>> So, the patchset makes shrink_slab() of less complexity and improves
>> the performance in such types of load I pointed. This will give a profit
>> in case of !global reclaim case, since there also will be less
>> do_shrink_slab() calls.
>>
>> This patchset is made against linux-next.git tree.
>>
>> v7: Refactorings and readability improvements.
>>
>> v6: Added missed rcu_dereference() to memcg_set_shrinker_bit().
>>     Use different functions for allocation and expanding map.
>>     Use new memcg_shrinker_map_size variable in memcontrol.c.
>>     Refactorings.
>>
>> v5: Make the optimizing logic under CONFIG_MEMCG_SHRINKER instead of MEMCG && !SLOB
>>
>> v4: Do not use memcg mem_cgroup_idr for iteration over mem cgroups
>>
>> v3: Many changes requested in commentaries to v2:
>>
>> 1)rebase on prealloc_shrinker() code base
>> 2)root_mem_cgroup is made out of memcg maps
>> 3)rwsem replaced with shrinkers_nr_max_mutex
>> 4)changes around assignment of shrinker id to list lru
>> 5)everything renamed
>>
>> v2: Many changes requested in commentaries to v1:
>>
>> 1)the code mostly moved to mm/memcontrol.c;
>> 2)using IDR instead of array of shrinkers;
>> 3)added a possibility to assign list_lru shrinker id
>>   at the time of shrinker registering;
>> 4)reorginized locking and renamed functions and variables.
>>
>> ---
>>
>> Kirill Tkhai (16):
>>       list_lru: Combine code under the same define
>>       mm: Introduce CONFIG_MEMCG_KMEM as combination of CONFIG_MEMCG && !CONFIG_SLOB
>>       mm: Assign id to every memcg-aware shrinker
>>       memcg: Move up for_each_mem_cgroup{,_tree} defines
>>       mm: Assign memcg-aware shrinkers bitmap to memcg
>>       mm: Refactoring in workingset_init()
>>       fs: Refactoring in alloc_super()
>>       fs: Propagate shrinker::id to list_lru
>>       list_lru: Add memcg argument to list_lru_from_kmem()
>>       list_lru: Pass dst_memcg argument to memcg_drain_list_lru_node()
>>       list_lru: Pass lru argument to memcg_drain_list_lru_node()
>>       mm: Export mem_cgroup_is_root()
>>       mm: Set bit in memcg shrinker bitmap on first list_lru item apearance
>>       mm: Iterate only over charged shrinkers during memcg shrink_slab()
>>       mm: Add SHRINK_EMPTY shrinker methods return value
>>       mm: Clear shrinker bit if there are no objects related to memcg
>>
>> Vladimir Davydov (1):
>>       mm: Generalize shrink_slab() calls in shrink_node()
>>
>>
>>  fs/super.c                 |   11 ++
>>  include/linux/list_lru.h   |   18 ++--
>>  include/linux/memcontrol.h |   46 +++++++++-
>>  include/linux/sched.h      |    2
>>  include/linux/shrinker.h   |   11 ++
>>  include/linux/slab.h       |    2
>>  init/Kconfig               |    5 +
>>  mm/list_lru.c              |   90 ++++++++++++++-----
>>  mm/memcontrol.c            |  173 +++++++++++++++++++++++++++++++------
>>  mm/slab.h                  |    6 +
>>  mm/slab_common.c           |    8 +-
>>  mm/vmscan.c                |  204 +++++++++++++++++++++++++++++++++++++++-----
>>  mm/workingset.c            |   11 ++
>>  13 files changed, 478 insertions(+), 109 deletions(-)
>>
>> --
>> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> 
> Hi Kirill,
> 
> I tested this patch series on mmotm tree's
> v4.17-rc6-mmotm-2018-05-25-14-52 tag. I did experiment similar to the
> one I did for your lockless lru_list patch but on an actual machine.
> 
> I created 255 memcgs, 255 ext4 mounts and made each memcg create a
> file containing few KiBs on corresponding mount. Then in a separate
> memcg of 200 MiB limit ran a fork-bomb.
> 
> I ran the "perf record -ag -- sleep 60" and below are the results:
> 
> Without the patch series:
> Samples: 4M of event 'cycles', Event count (approx.): 3279403076005
> +  36.40%            fb.sh  [kernel.kallsyms]    [k] shrink_slab
> +  18.97%            fb.sh  [kernel.kallsyms]    [k] list_lru_count_one
> +   6.75%            fb.sh  [kernel.kallsyms]    [k] super_cache_count
> +   0.49%            fb.sh  [kernel.kallsyms]    [k] down_read_trylock
> +   0.44%            fb.sh  [kernel.kallsyms]    [k] mem_cgroup_iter
> +   0.27%            fb.sh  [kernel.kallsyms]    [k] up_read
> +   0.21%            fb.sh  [kernel.kallsyms]    [k] osq_lock
> +   0.13%            fb.sh  [kernel.kallsyms]    [k] shmem_unused_huge_count
> +   0.08%            fb.sh  [kernel.kallsyms]    [k] shrink_node_memcg
> +   0.08%            fb.sh  [kernel.kallsyms]    [k] shrink_node
>
> With the patch series:
> Samples: 4M of event 'cycles', Event count (approx.): 2756866824946
> +  47.49%            fb.sh  [kernel.kallsyms]    [k] down_read_trylock
> +  30.72%            fb.sh  [kernel.kallsyms]    [k] up_read
> +   9.51%            fb.sh  [kernel.kallsyms]    [k] mem_cgroup_iter
> +   1.69%            fb.sh  [kernel.kallsyms]    [k] shrink_node_memcg
> +   1.35%            fb.sh  [kernel.kallsyms]    [k] mem_cgroup_protected
> +   1.05%            fb.sh  [kernel.kallsyms]    [k] queued_spin_lock_slowpath
> +   0.85%            fb.sh  [kernel.kallsyms]    [k] _raw_spin_lock
> +   0.78%            fb.sh  [kernel.kallsyms]    [k] lruvec_lru_size
> +   0.57%            fb.sh  [kernel.kallsyms]    [k] shrink_node
> +   0.54%            fb.sh  [kernel.kallsyms]    [k] queue_work_on
> +   0.46%            fb.sh  [kernel.kallsyms]    [k] shrink_slab_memcg

The interesting results. In the first case we had iterations over long list
of shrinkers placed somewhere in memory. Since there are many allocated
structures (not only shrinkers) on mount(), the most likely case I think
is the most shrinkers do not share the same cache line. These actions
are so bad, that we don't see the trashing from down_read_trylock(),
since it's a small subset of introduced trashing.

After patches are applied, trashing from down_read_trylock() is the only
trashing and it's visible.

There were: down_read_trylock()/mem_cgroup_iter() = 0.49/0.44 ~ 1.1
It became: 47.49/9.51 ~ 5.0.

This looks like shrinker_rwsem is a good candidate to be placed in separate
__cacheline_aligned place (to prevent its impact on neighbours,
e.g. almost read-only shrinker_idr and shrinker_nr_max). This shouldn't
change perf trace (I assume), but this should be good for real workload.

> Next I did a simple hack by removing shrinker_rwsem lock/unlock from
> shrink_slab_memcg (which is functionally not correct but I made sure
> there aren't any parallel mounts). I got the following result:
> 
> Samples: 5M of event 'cycles', Event count (approx.): 3473394237366
> +  40.13%            fb.sh  [kernel.kallsyms]    [k] mem_cgroup_protected
> +  17.66%            fb.sh  [kernel.kallsyms]    [k] shrink_node_memcg
> +  14.78%            fb.sh  [kernel.kallsyms]    [k] mem_cgroup_iter
> +   7.07%            fb.sh  [kernel.kallsyms]    [k] lruvec_lru_size
> +   3.19%            fb.sh  [kernel.kallsyms]    [k] shrink_slab_memcg
> +   2.82%            fb.sh  [kernel.kallsyms]    [k] queued_spin_lock_slowpath
> +   1.96%            fb.sh  [kernel.kallsyms]    [k] try_charge
> +   1.81%            fb.sh  [kernel.kallsyms]    [k] shrink_node
> +   0.91%            fb.sh  [kernel.kallsyms]    [k] page_counter_try_charge
> +   0.65%            fb.sh  [kernel.kallsyms]    [k] css_next_descendant_pre
> +   0.62%            fb.sh  [kernel.kallsyms]    [k] cgroup_file_notify
> 
> From the result it seems like, in the workload where one job is
> thrashing and affecting the whole system, this patch series moves the
> load from shrinker list traversal to the shrinker_rwsem lock as there
> isn't much to traverse. Since shrink_slab_memcg only takes read lock
> on shrinker_rwsem, this seems like cache misses/thrashing for rwsem.
> Maybe next direction is to go lockless.

Yeah, this sounds reasonable for me. Maybe we may simply use percpu rwsem
for this (if it also has something like rwsem_is_contended()).

Thanks,
Kirill
