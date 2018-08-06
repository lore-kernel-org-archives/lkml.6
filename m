Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C959C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97C8321A35
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=advantechO365.onmicrosoft.com header.i=@advantechO365.onmicrosoft.com header.b="LnYlF5+C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97C8321A35
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=advantech-bb.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbeHFP30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 11:29:26 -0400
Received: from mail-oln040107225043.outbound.protection.outlook.com ([40.107.225.43]:62300
        "EHLO KOR01-SL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726901AbeHFP30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 11:29:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=advantechO365.onmicrosoft.com; s=selector1-advantechO365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tkMVR8xyOzPyffYgYdKOx26T9WFUTndDAZ9hXFGyR2c=;
 b=LnYlF5+CcrxABMXjEWFKcoQ9/EBR0VCn0xfVTac7YRgS67KlH5uqNK3HPkNF5teiOwFqoLnS0aG5Nyyw+hdh+bN4sSt3KiJEKgQtDSaNztoDtSbRv25kFLa7Y8pup5YA4Dg9tR0KxN1BBKCUFuc/UdfYXIY5er1JpVmUL9BbcGQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Tomas.Paukrt@advantech-bb.cz; 
Received: from [10.40.30.158] (46.13.7.58) by
 PS2PR02MB3064.apcprd02.prod.outlook.com (2603:1096:300:4c::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Mon, 6 Aug 2018 13:20:12 +0000
Subject: Re: [PATCHv2] musb_host: fix lockup on rxcsr_h_error
To:     Maxim Uvarov <muvarov@gmail.com>, Bin Liu <b-liu@ti.com>,
        Yegor Yefremov <yegorslists@googlemail.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        sergei.shtylyov@cogentembedded.com
References: <1461739918-9583-1-git-send-email-muvarov@gmail.com>
 <20160427154620.GB5604@uda0271908>
 <CAJGZr0JNgYccDdsPLPWGyY3ASnN4PBxfJuhxeEEWk87T0qh2fg@mail.gmail.com>
 <20160427191356.GA16821@uda0271908> <20160427212823.GA14645@uda0271908>
 <CAJGZr0JwefevBRxbG_k5jPqf8Bi9ndMMieTcAKfkgCRGcbfjrg@mail.gmail.com>
 <20160428143714.GA7222@uda0271908>
 <CAGm1_ksaa8P1fs03-DSsjvVQu_=cg4yqw7xumb9Gbm+t19O01w@mail.gmail.com>
 <20160503134813.GA690@uda0271908>
 <CAGm1_kvLh-+kJVdtv+7i_1nVsPTQ67uE_5ZizRRfK2iEoWcj+w@mail.gmail.com>
 <20180125154508.GB6590@uda0271908>
 <CAJGZr0+8FRhbMEsKke=DoCAQ7-7gqDKCNJZ+oE==aovqm1kHBw@mail.gmail.com>
 <8d667479-136c-a695-6eda-0ff654e8acad@advantech-bb.cz>
From:   Tomas Paukrt <tomas.paukrt@advantech-bb.cz>
Message-ID: <cae9bff6-241f-a4a2-fdeb-bab4d22c4290@advantech-bb.cz>
Date:   Mon, 6 Aug 2018 15:19:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <8d667479-136c-a695-6eda-0ff654e8acad@advantech-bb.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: cs
X-Originating-IP: [46.13.7.58]
X-ClientProxiedBy: VI1P18901CA0016.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:801::26) To PS2PR02MB3064.apcprd02.prod.outlook.com
 (2603:1096:300:4c::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 115c7d6b-32f5-4865-cded-08d5fb9f58fa
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:PS2PR02MB3064;
X-Microsoft-Exchange-Diagnostics: 1;PS2PR02MB3064;3:rdGvwgFp2a0ogi4OHCk7dktOCxVe4e5Ev1U87ydi+Z7MGSRaacKKS4J4o78/ICeWiZ1q5vv2RqDGkJcFQpkZO03mAmyCSlSTD1kViOoTpBoNzwGQSGWGJX6HHD9EygcVERBPRNb0rH9h3GVTrhgBDkZoVOfPdbofBcAUj3b2btA6eZNVB0WWNzvr61b60kN3rA2CXvkfZLsUDxJjB5R1RympFjfoD3gvCjCOpHqk+pMkWnoIFTNq6hA2fOP4kMNB;25:JqPb6JVhsJuDIWBJFqTnkrjkyGh4hQmSPK/DhelY5vCrytN+0PgfDncU0Byu7ScisLjRcQOyYUua8BCdv0X7MGY5w+kcYukYBMzTG2rVf+7izzha/FtbNWkJga9vZHNYnk/noErS5LoJMFwuWIMjufVxmD4BPzcYkDoz5UvPwO1gHlD4Ud2lQmgZa82t/POxym8KnrzR5czdnF22qnxkg2lDlBdHg45WVHUOpnBRBMlnJahuFNsklp7DOU11vFZG5vn6xcZRVfmvqXWvvagIpJp1mjdWsug29bSgjUH9j/oyno62ju9IjSCAi/NZd/OiDEtxoaYFiZRXV5pqJqN9Dw==;31:eaPlBpFT3gAacs1CwnC/G+DcZFLIXn19wgVbd8ZKAAqUWPp2nuLjQ+lod+ePHkTnVjTChkp8faa5Z/ztnXo/jde7I39RK0eu/xuvJUy08Zxc68IKV/jvjd16Bofim7Im5sf2KYKCG9eODQ/Csc+CBDR4/z+y1pQebe7tQu/Bs8S8CVx3pgfiXUtn0VX7BCgmR+90Uci4IIHc+5W2e6QBUoaHuEhvuJYwPwM+ZJd5a0E=
X-MS-TrafficTypeDiagnostic: PS2PR02MB3064:
X-Microsoft-Exchange-Diagnostics: 1;PS2PR02MB3064;20:AsZiU2giP1errKiRF/y+G9UHPib9sgY/yKJuI7g4vsFH3al1f/pCkLm0iIPCTaX8+FnFMm0MRjtffmahYssJl77VbeKXIrdhEuarUKLjr6ubKKtJ5pnfTeu8JYC51DXQgmERI2IdPUMwtcRkCmP0xVMLo5Borjqk2Zbtau5vmu3JeC5pAx3mH60nt0E0o6ntLLEb3I3IRAdBlt4fdf7Ajp7q9XTJWS7IvN/HsbF14+bo91fZUSNt3kUctUtEWC5HiBKVbhL1NPz63E3AflszTmdLov6rW/UMBvrvIazJXEiouZGRWm5GhT5efvBgIx906zuobhmUFJ3nxl+51FztCLdUnHuWNa0nAiwRGMp/Muj2zYSouZJKK5es9hslOZANqNX38w6yJ6NhY0LW1hpnp9cXD9M7bdeLbg+Et82AKjzC7qJOSuQeWArOEAG+hxkyGQpf3REZMNK40xNOe4R2EKo3Suh0yQxvjwP+G7PIeHDKeOGJcSUrYydtin6THk8D;4:LQyJY+CN9vB+/6Vjm/PU6z5lZlVQVdjpId8J9uyN/wtNamRC21IBcLTEv27MDAEVY29PIkSwiAnnZxrwvF66FP/VM8sWqddzyPbSmu6x0b66nISmcvR5zfCQFKWXX1Z09pF7DqlkG5eOqLei5Ke8SmTOPe3FR113FoQ0INDQuOlnpLKRBUYE7nucnz96OrytPodhI3kUzDVF4sSasqOO9kRg+Q2SRCi19AbEXuQ2MoZ4/e/KsZjFlqv1DJub6VXlqC9GHsHEFPTkGATUUnbd3Y2wmpGbHQyQMw0rWoEb18V9/KSMvOiwRzfy9wdLIazq+XFAbtwFAclzeDqpirwCnLwrRx44LybcWsLw3JbKIliZcgcEWH0XQrk4n5YTBygU
X-Microsoft-Antispam-PRVS: <PS2PR02MB3064E26D3E1C25EA39A35115C5200@PS2PR02MB3064.apcprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(31051911155226)(84791874153150)(8415204561270);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:PS2PR02MB3064;BCL:0;PCL:0;RULEID:;SRVR:PS2PR02MB3064;
X-Forefront-PRVS: 07562C22DA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(136003)(376002)(366004)(39860400002)(346002)(209900001)(189003)(199004)(186003)(6306002)(68736007)(956004)(72206003)(67846002)(65806001)(65956001)(66066001)(47776003)(50466002)(93886005)(16526019)(77096007)(26005)(446003)(2616005)(11346002)(476003)(229853002)(478600001)(486006)(44832011)(966005)(74482002)(58126008)(16576012)(97736004)(36756003)(110136005)(6666003)(25786009)(65826007)(2906002)(386003)(39060400002)(81156014)(305945005)(106356001)(86362001)(6246003)(53376002)(2870700001)(53936002)(8676002)(3846002)(81166006)(64126003)(31696002)(53546011)(5660300001)(2486003)(23676004)(52146003)(105586002)(6116002)(31686004)(52116002)(8936002)(76176011)(7736002)(6486002)(316002)(6606295002);DIR:OUT;SFP:1101;SCL:1;SRVR:PS2PR02MB3064;H:[10.40.30.158];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: advantech-bb.cz does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtQUzJQUjAyTUIzMDY0OzIzOjUrNi9pckxibUpiQjU1RDRwNy91WDhsaDVB?=
 =?utf-8?B?TlM2NEM1eEJEcS9UaVFtT0M2VkZhOEMveGwrOWNVTmROVEFpVklJZmtVUXZJ?=
 =?utf-8?B?eDkzSU9sa1B3VFJoajVEQmNPUHFFOU5IVEdNSEJ1M3FJNVVtT3hhTDV4QmVN?=
 =?utf-8?B?MzZnM3J4bi9wMllYQlRlZmRjcExPempzdFlUQXdMNThBL29UbEI0QWMvUzRX?=
 =?utf-8?B?ZjgranZlbU9JU3creHJoZW9wS0c2dWxvTGpVeWtXeC9Sbm9yUElsb2JXS0Rl?=
 =?utf-8?B?ZWExaDZkSjkxVVkreW5GUFo1YzRqZ2p6dzlSMmFYNUdqeElKVVJrSFd4S3FJ?=
 =?utf-8?B?OVVGRmw3dlZrTThZRGlqUFpuelJiUHJsQld1bWYwYllkQll3OXNPQjhVcWRX?=
 =?utf-8?B?bXdJRlMzWFc4WkhQcXluUlJFcjJnZ3JNdldwUitsU0ZweDR2T1dxWHJzT0pv?=
 =?utf-8?B?UFNoRGZBdHloRlVoS0ZUQkhPeTFmM1c3VVk3VFg1MzV5VWhEQU91SmwxQVVx?=
 =?utf-8?B?ZUpCMXZURVliVjU1cTV3UnltTklCNWZDdWJaZ1RmRW0xNTNCM1ppb1hVeFNT?=
 =?utf-8?B?WUZYd2VyWEI4azUvMkhFVDVFTFRoSUVodUNXS1lqMDVjRy8vRHI3NDQ4VlNN?=
 =?utf-8?B?cGdrMHhwU285UUptM3FoSzhnNUl0eG05bklRRFRnRWJmTmlMSGJHUVA3WlBj?=
 =?utf-8?B?NFhOZkZoMXd6eG9OZE1haFFSblFpeU9qOVcvV0hlMkMzQm1NSHJhUWk4S2ky?=
 =?utf-8?B?KzM0WkxsbFpGUmw3N0w4aVhxa2hnWjQwb1ArUWxWSm92M3RGWFNYcHRUT1Y4?=
 =?utf-8?B?TjVyNXhsblF6YWxXRWZ2eTdNUlFxeTdmTFpqUjR1TjBmWHVMQzJnT0ZKd2VO?=
 =?utf-8?B?NXJmV0FmS1RyMitFOGI3VTFPcUNPaG0zcmJrSExTMy9qUEprVGUvSDZMYzVS?=
 =?utf-8?B?RHkwNE9SNVFpY2VFeW5FUUlEeERwYlI0aGZtVmZJeXRNV3RFc2FnMVY2d3g2?=
 =?utf-8?B?YTFPQm1LcjM4NUtBcHI3TFZSVXYvTTRmUzZvOStyeFQ4c1ZjQUxzTVFiY2pH?=
 =?utf-8?B?Y1FpamdUK2krVFpIcFM5Rm9FL0dnYWZwV1dYd0g0NzNZM3ZZQ25PaTdzZFhK?=
 =?utf-8?B?MVZkNHg5T2FaUDJ4SE5VV1hLU2RhcGJjWnBycjBuWVdRaUtDZE85YTdXT2lP?=
 =?utf-8?B?ZjlYUVJUSUlWR0dBUFJ4YXpVcTQ2ZWJOZXAxVjgyejF6RG12N1hOMUtMaUlh?=
 =?utf-8?B?SGx6cGxSVFJwcjFmckxtSjJJVk4yUmVjMkIxemZDRXpVU1VtOTNVY0ZHOGcv?=
 =?utf-8?B?bkpsNWtDMGpaQmhOa1dVd2VxdUFYQ25yZDZ0c3BPSndIOVpkSEw5UXJTWmNM?=
 =?utf-8?B?NnhPS1FPSVg1NTBQZm9vZ09lSXNpb0NoZWxuaUNHT2JzOXA3OEJ6djVOSXVv?=
 =?utf-8?B?TW5YeXhXbHY5cFlxY2ZyUUFvQzB5TXUxVURxN2p1U3d0T0gwZncyMWtLT1Jl?=
 =?utf-8?B?elAvRjdsejh0N3V0RGFnek9uVmRtM2JDTmdpSTZ1MWlmT2l0S3VMV0hwMFE5?=
 =?utf-8?B?b1FRQnhRNzRKNjN1OEliTVR2VlRtYTZua1BjT3owSkN5WEdxZWZWSGZLMTNm?=
 =?utf-8?B?TlgxaFRYSTJjKzdGcHZDWXFQcDc2ek1lRmdOVWVKNEVqMC91MVNiNFZVTnk1?=
 =?utf-8?B?RlJobjQ0blZYcitWa3pnUmJ5aFZMQ0xZbTE0N1J5QXBKNVhWZkpKNC9UVi9O?=
 =?utf-8?B?czR3K1gzdW5QWTlDUUgxSXVscDUwcXVXbE9seG5UK3ZWR01sQTdrZFpaVjNN?=
 =?utf-8?B?SlcrZHMrK1g1VXE3WktDY2IxRlFoZlV6MnowOCtaS0g2a211Ynh1MTJJaGJE?=
 =?utf-8?B?K2I4VUpEa09oMUpjOVVVblNaTi81N1F4b2tORXBCSi9UcTJkQkw4MUo5TDE5?=
 =?utf-8?B?MVNIODJTMEhtWnZIQkVNbUMwaTRlTUVhZC9IYTRodmhFaHBGRnM5L1ExWUhF?=
 =?utf-8?B?S2M5M2w0ODJjeDBqTFk1WmJ4eTM3M1NyMFg4aXFSODdZb0tyMCtrQzhUc2No?=
 =?utf-8?B?K0UvTHhRb1ozblJKd2EwWjdJOTl5M1VDaUdqamhTYlJRQVJSQjZjeXhQQlFo?=
 =?utf-8?B?UThmWGRrOUhOMk9pd1dlUDkxbjFEcE8vMFpUeXhxVXdGOGN6UUZlT0ZPTXlt?=
 =?utf-8?Q?Yfhn93l5i8Z4RoFq8LshJH5ybyvjC27f4yPQ1LkhZc=3D?=
X-Microsoft-Antispam-Message-Info: pqOrOPr2EvRlgSDcjdX8KtC+vmGYSlfuuoW0K6d8BZmV2W0gQ0N35kGo8jBs+88zrt2GqSqtCy9xpDDP59ucQvkw0Z7ecjuXw36kUTwrZKtPAiTFP9IJUgvEsqWHO4it3t2dkJJEiRxWESkooQ7khdIwC2JpJXHBVk3iwvAKya/gZItWsuga3aHt/MW+Mn+HrKP/FNp0HfaBjYBypW2WHO5GOOD9VaAeqkSuo6L1issCKI77IAysx80ILiYtqTZXpZC9aKRpibFPNTGT8ASLAeatmPXGTUuWha0KmkAlI491LdUZVAAyhQsbburwkGKJQW0KpFXFlTdfhoVaIAIx74uQ2zVXrzj/REsFc4kBENg=
X-Microsoft-Exchange-Diagnostics: 1;PS2PR02MB3064;6:miNfb0P6sMt27NoLbm+SxwbwNSwoct7QhfEfbZjNiWD8c92jNPADHERW9dySqRHfwFl5Ml3OOZYyxDzCJppVx2rE9LUZ40Y8mSi3VEqHxC5On9wtE87rCOp8A34RHIertbjtyVw/DFossmgM1bkf1t3EpA+PbWET5SvUVZY84C+w8yjrEfXJuHfA7ZU0L+ju39e76WYqVT/iMTe0T6/lvW3SCMM5nkd+Ml/t0PQPQJCPED8MTOH0TZENZMZcGenVqZr3voHGx4oeP+oza7XijaW54sdeA1f+SW49te+vVschVWnFKLixIa9vhivXUOQuDM94xN5fQlKC00thKiToyM1b3hOgxrM7cyYhfZ6/Nd0dtzqny4l4q1RHkXFbKH2BF2n+R7AbtMP/kru9x8okaN9bJ0CASAtOSeaGUhzYGKTQ1XFa2FcQ3c3+H2eGYV0SjKLwYOamtVQXiGbmotIc+w==;5:0QEUm2PLlcP6cj7njAqkCRhjFcLt4LK5y8oLCgjKMsO4oTC7BgVWGAa3395PFePP8LsVBCtOSY8v0c15NDp/CjoUBZQnXbpdnVd0a0UzDYxV9uRCO2l2DNb7pTacCbyyeUU2Q+trQCJzzqCnFffbjmj+HR6GsIS2ZYOwkEfqmag=;7:sPavvhZLajNaoRKIi0OC3wfrAum+lVgKfDZfbR4FOhvZoG30g9PIo5TtoFE7cU4qpwX5fBgCF53SeWroN1H4n28eFUaIHT8dYLSDj/R+Z0vWoOyh/2wIuSnQIyc2CRTUnoI+2RPD7hsLuY9AzU1IkzVHT8HYehpjU3NfH3zcCbogf5qiuY17SYG7DAD25YgI4RMpLtX4pSmsFe4p5vTFb/3O7vZf2fbYM+ZHeBJrSzCDPNVuIOTZcj+QWRKiWcpe
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: advantech-bb.cz
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2018 13:20:12.4484 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 115c7d6b-32f5-4865-cded-08d5fb9f58fa
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a77d40d9-dcba-4dda-b571-5f18e6da853f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS2PR02MB3064
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxim and Bin,

I would like to reopen this issue, because we have moved to 4.12.24 and 
restarting two cellular modules using AT+CFUN=1,1 command at the same 
time leads to system freeze, because RX ISR is repeatedly invoked. Maybe 
*musb_start_urb* should be always called from *musb_advance_schedule* 
after a random communication error, but should not be called repeatedly 
if the device has been disconnected.

Best regards

Tomas


Dne 26.1.2018 v 11:42 Tomas Paukrt napsal(a):
> Hi Maxim,
>
> unfortunately we cannot test the latest kernel right now, because we 
> have custom drivers and additional changes that need to be ported, but 
> the MUSB driver in our kernel should contain all fixes from 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/log/drivers/usb/musb
>
> Best regards
>
> Tomas
>
>
> Dne 25.1.2018 v 17:24 Maxim Uvarov napsal(a):
>> [1] says that issue is with back ported driver to 3.12.10. Can the
>> latest kernel be tested on the same hw?
>>
>> Maxim.
>>
>> 2018-01-25 18:45 GMT+03:00 Bin Liu <b-liu@ti.com>:
>>> Hi Yegor and Max,
>>>
>>> On Tue, May 03, 2016 at 04:25:58PM +0200, Yegor Yefremov wrote:
>>>> On Tue, May 3, 2016 at 3:48 PM, Bin Liu <b-liu@ti.com> wrote:
>>>>> Hi,
>>>>>
>>>>> On Tue, May 03, 2016 at 12:03:52PM +0200, Yegor Yefremov wrote:
>>>>>> On Thu, Apr 28, 2016 at 4:37 PM, Bin Liu <b-liu@ti.com> wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> On Thu, Apr 28, 2016 at 09:51:37AM +0300, Maxim Uvarov wrote:
>>>>>>>
>>>>>>> [snip]
>>>>>>>
>>>>>>>> Hello Bin,
>>>>>>>>
>>>>>>>> yes, it also works with that reset and go to finish:
>>>>>>>>
>>>>>>>> diff --git a/drivers/usb/musb/musb_host.c 
>>>>>>>> b/drivers/usb/musb/musb_host.c
>>>>>>>> index c3d5fc9..8cd98e7 100644
>>>>>>>> --- a/drivers/usb/musb/musb_host.c
>>>>>>>> +++ b/drivers/usb/musb/musb_host.c
>>>>>>>> @@ -1599,6 +1599,10 @@ void musb_host_rx(struct musb *musb, u8 
>>>>>>>> epnum)
>>>>>>>>                  status = -EPROTO;
>>>>>>>>                  musb_writeb(epio, MUSB_RXINTERVAL, 0);
>>>>>>>>
>>>>>>>> +               rx_csr &= ~MUSB_RXCSR_H_ERROR;
>>>>>>>> +               musb_writew(epio, MUSB_RXCSR, rx_csr);
>>>>>>>> +
>>>>>>>> +               goto finish;
>>>>>>>>          } else if (rx_csr & MUSB_RXCSR_DATAERROR) {
>>>>>>>>
>>>>>>>>                  if (USB_ENDPOINT_XFER_ISOC != qh->type) {
>>>>>>>>
>>>>>>> Thanks for testing it.
>>>>>> Have tested your patch and now both FT4232 and Huawei don't 
>>>>>> freeze on removal.
>>>>>>
>>>>>> Bin, Max thanks for fixing this issue.
>>>>>>
>>>>>> Tested-by: Yegor Yefremov <yegorslists@googlemail.com>
>>>>> Thanks for testing.
>>>>>
>>>>> Can you please test the patch [1] instead? I'd like to use it as the
>>>>> fix.
>>>>>
>>>>> [1] http://marc.info/?l=linux-usb&m=146222355213935&w=2
>>>> The patch behaves the same as the previous one.
>>> Sorry for bringing up this old thread, but it seems to be too 
>>> aggressive
>>> to stop scheduling further urbs on errors [1]. So is it possible for 
>>> you
>>> to re-test your usecase by reverting commit
>>>
>>>      dbac5d07d13e ("usb: musb: host: don't start next rx urb if 
>>> current one failed")
>>>
>>> to see if only commit
>>>
>>>      b5801212229f ("usb: musb: host: clear rxcsr error bit if set")
>>>
>>> itself solves your issue?
>>>
>>> I know you have tested the patch in [2], which is similar to commit
>>> b5801212229f, but tha latter doesn't have 'goto finish' which does dma
>>> cleanup on errors, it makes more sense to me. But I'd like to have you
>>> tested with reverting dbac5d07d13e to be sure.
>>>
>>> [1] https://marc.info/?l=linux-usb&m=151689238420622&w=2
>>> [2] https://marc.info/?l=linux-kernel&m=146185425805967&w=2
>>>
>>> thanks,
>>> -Bin.
>>>
>>
>>
>

