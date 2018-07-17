Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FD8ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F093220657
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="a7Ok9IWP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F093220657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731703AbeGQQQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:16:52 -0400
Received: from mail-eopbgr40113.outbound.protection.outlook.com ([40.107.4.113]:56041
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730539AbeGQQQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:16:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3RAI8UIEah9v6V11KMuA6WEW6rThBSR0gN2TgnR2BA=;
 b=a7Ok9IWPuSOBYER+z9ZJ9v5RHoxXXXcJIoGhx76rxFONCRRUss/W+O+W3UHkqF3K7VbP2w8V3fuF0bCiJViNbjKrwknsE4ncizYihrHShv7XYsxW4x5IT1x2RexCjQBLTN4kwjDMBMjm2Tm7E4Cu6BTY5RDgC7Fk6HnzMd5gQsg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com; 
Received: from [172.16.25.12] (185.231.240.5) by
 VI1PR08MB3262.eurprd08.prod.outlook.com (2603:10a6:803:3d::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.21; Tue, 17 Jul 2018 15:43:31 +0000
Subject: Re: [PATCH 2/2] fs/fuse, splice_write: reduce allocation size.
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180716160344.7015-1-aryabinin@virtuozzo.com>
 <20180716160344.7015-2-aryabinin@virtuozzo.com>
 <CAJfpegvAAQTAjxLcQLefvFOQDJ6ug_G8Jggt=UZci+YnNP741A@mail.gmail.com>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <d1bcfeb2-8e74-f4a7-225e-9d78ffb4263e@virtuozzo.com>
Date:   Tue, 17 Jul 2018 18:45:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAJfpegvAAQTAjxLcQLefvFOQDJ6ug_G8Jggt=UZci+YnNP741A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: HE1PR05CA0213.eurprd05.prod.outlook.com
 (2603:10a6:3:fa::13) To VI1PR08MB3262.eurprd08.prod.outlook.com
 (2603:10a6:803:3d::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff1eda13-9699-439f-eb6d-08d5ebfc0c78
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3262;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3262;3:vSdX3iK6xkKM1egz5lqBPPJJGK3teCPuEqt7uhLoQ2AKUg/BPOLGSwKV31E8CIn4c08SDptAsm5fLisMs9y1QYamEn7c3KV47YZ07eT7PuXQOCXbL4l+0Kbk4KHaVRb0k9XLDursgVN1EAGGHMvw2K85VZRsk7iIl9LO2bpiI4MP1olLPLQ+NhyWw9dmANmQ7bs+z09d7ZejfgNazQ0ahOKWNSumt8Xmrk5p4ZCNwQzZX8xFzNNS0C8W9/ikZ2U+;25:7cjy/JL+nk7i0bC4RFSwpFIcQusACg02ylfpvkBa/KS6DGP2N747/Q+7Ptn279kdDBMKhVWuh0Ko+PrmP6UZq6fy3bpA2ZVrXP8gpmmc8x/z1f+TB5ghsKKsuc72lSKAb48g8OvvoYlaUk5ebIWwWmHGWelmvxWNc7AQ2ToX2y599S41JiKJPwX5vAiAxzSAGnkUG2ttv8MoKFCsfN9cJ+02ntUy4DMcWB0m3SeZ2cISjepaJs+DccY90F9SiNoKov5k8UTBzNMkivaEokFN4pxRrfJNnuB0FQVYgeNkVK9G4juriWwJU1Yfr512RalNlp2xznIp1ppSVL0zVGw+YA==;31:7hJGlZUYz9TAZ05b7cIHHuHMzU2mBun3+cJLYVBfkPxDAbdnnbmYPRjfz3ptKzXSge06oO/NqV5jt+dA8pYmmcbYk1UXNdzmfKn6HrqQwl69UpGQK9FMkHGfjJw1nn9V/HBD/NF5RFpILANQQrJ5+CCTEXhUYQytuARgMzc6QlFOXaEAzO24PgJBbrbh9tJB+rwWhuxs/EOvYPpxD4n3WjJej5Ii+U8TEWL2X/uF2mc=
X-MS-TrafficTypeDiagnostic: VI1PR08MB3262:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3262;20:TiATZzisly4xVNd01SyWRJUYENelYy80M0h7Q8HKZwaamr9xjSU8pMhl1WTZgSB4oaVsDGtl4vQu8i7NpfGbSFFjsk8/RAIrmuIv50kClxhR2jRAUK6nn72Jy/5KUOFO2FDLZzFGR7g5uyNguLwKtNQ4ltpfvs/Pq0TzLfplO6OA0jcach5OuZP1sRHcIvrU0mlhHZ9arPt8jAu03Gn3izLnl3u6iVrUDELqQ3FudJdLdx/JfPxGPYcORL7BjY2fbVukP2N3YUO3wVdMEmYluOfiQb2gmxwJNFI3IDtvf3Iolc3ZLkrjYPEeuz54hlMC0lhCfpWsRbukMCvvip2p+B68Qx9jyFlHeyfFdWxYLQwMcUaZ2OimWA5bClGn3RQVQOlUaDZuTuQWaJVxtKg1jmVEKGCGs6TlzT4Wmj2Li3Sy/Vog88LLBPoqirQMKgbFWNpIHzc0KIxZTjceCrl6xJ5WdPefE8Bzd458qBnxdP5gUZQf91yvhYvKB+QDSvIw;4:qCUHIQtITLKhg+4XCMsFuqsvhHeh2sCN7nqyB+Qp79a3zHX/obyGew2lky+ui4Rywzw+B1/F6ltdxXcwSjED9L/0VZP2TiMbn/zWP2Qj3YQ0zlDHigP8TNuBrt9quSsHhoL8QYfmOWbRgraF11th9CDtw/aBbTnNpcl6idJGVrJx3KQ+lSbJeMw4sBtWcA57qVaBsbhbh1A92z1o+nmNTj/b1z5pJtbj6UF3XM6he8Rib/hFJ8gAVfTroi1yROQVOpTxWbJPWNdnypCAsq1wJ70W+zWdXyDcDuaDtvNk8X9WJlZq5HsEPI5dyhrnZr01Sm2JSOzRqNTlkaze+N/J6hhpCIwOich0odzlI6a1iuI=
X-Microsoft-Antispam-PRVS: <VI1PR08MB3262F0CAABADC102983D9E50B05C0@VI1PR08MB3262.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(131327999870524)(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:VI1PR08MB3262;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3262;
X-Forefront-PRVS: 073631BD3D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(396003)(346002)(366004)(136003)(39840400004)(189003)(199004)(81166006)(4326008)(8936002)(8676002)(106356001)(65956001)(66066001)(65806001)(52116002)(2486003)(23676004)(6486002)(76176011)(64126003)(81156014)(229853002)(53546011)(36756003)(25786009)(105586002)(7736002)(50466002)(386003)(6246003)(305945005)(478600001)(2906002)(52146003)(47776003)(14444005)(53936002)(11346002)(77096007)(65826007)(5660300001)(86362001)(3846002)(446003)(6666003)(58126008)(6916009)(16576012)(97736004)(16526019)(186003)(2616005)(6116002)(26005)(68736007)(31686004)(31696002)(476003)(956004)(230700001)(316002)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR08MB3262;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:3;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4TUIzMjYyOzIzOmlDVGhKQXlxdDVqRkxiaHlEQ0gxOWdMajVo?=
 =?utf-8?B?WHpMVFNNMERjYXg3NzdyVFY3TjdUMFVLWEpvL3lHckQ1QjZTaENlNzVHYlpS?=
 =?utf-8?B?ZkFVc0trUGlnTWw2dk9ZQWEyNHhGR00rVWpIT25yc1FKODJyYUhRNm4xYi8z?=
 =?utf-8?B?VGJzLzQ4WTgrOUVobWViNlBidyt6QnVZUWZ1T2R0M2ZzK0pWT1ptdHBVVGd4?=
 =?utf-8?B?TklPMjhQa2NyNXBZTWkwaXB5TGRMb1hEZm55M3BOc1hNVmZodWZjYlhXOStZ?=
 =?utf-8?B?aW5ickFReHdFUUV1Z25UMmt5VUZpdmRyekNMZmdiT3U5M0VYZEgyV2FmcWpa?=
 =?utf-8?B?STJFb3draGhVc0dXRVd2UTN6OUl1Q3Q0d01VK1hkTUFPNFduZk9uWDlQclVK?=
 =?utf-8?B?T1BaNHNaYWY1L1l3ZjF2UnVMVlJDV2xiV2lXTGkzTjNYbHlnVnlzUjBRNEZP?=
 =?utf-8?B?N1ArRUxrc1JjTWlmVlh0S1UwYklYSVcwME1VTXdtbUtUbGJoUXlpb2RQWjY4?=
 =?utf-8?B?WWJyTjJRbi9pTmVTM0k4N3V6Qjc4SGk3ejQ5WkFKWmpuMlg0bm8ycFFBVFdV?=
 =?utf-8?B?OHR2SXdqbEx0Sm45SmhYZkZwME9Ic1BWeGZSZkNLQU5qRzZKVnNIZFROZXpl?=
 =?utf-8?B?TGk1S2oxZys1NVNLdXVocXpNdnZtQWpoSUNzenlSL21GOEF0MWJtckR3eDdP?=
 =?utf-8?B?RlRMdHcxVFdoQ1h3ZGROd2VMYW11QThzdlZmWHRJRWpiOXJBaC9DOWo4SmxE?=
 =?utf-8?B?eUZBU2ZUdng5WlJrUEl3WGJBRWJCdkNIMlI2Y2VkR2NoUVFpS2d0TzM0Rmtt?=
 =?utf-8?B?Wkw4TmREN3NBUkhnblBxZVo0WVlBZ05OS2RmZGp4Njd3ZU9MY1V4TzU4eHds?=
 =?utf-8?B?VTJtU2pEQitobWtjNFlIL1drek9BTHRUSEFTMnp3Zm02bmE3UXdjbzJVZGp2?=
 =?utf-8?B?UUJwYy80TzQyZjlvcTJqa2Z5TlhHZVhmdFJ5dWFxOXBCWFdMWmFkbk1sdzVT?=
 =?utf-8?B?L0hOa1ErbVV0MnlRNlcwWjRxNWM5MkJNcHZjNDVEQ3V4cXBmbHZZcW42SU80?=
 =?utf-8?B?dVJzcEV5bys0Wnc3SEJkQVJSdWxLaDZVa2ZkbUcydk9Rd09hQlNBVVAxUFpM?=
 =?utf-8?B?Q2w0NzZjcGxpb0VBamdHTEQ2bzNGbXJzbnNxeXpGMXo1Z3NrbEQ0WkJRUnJP?=
 =?utf-8?B?OTJqbURjZlUwalZ2M1ZGRjd2dDFXTDJqZVZNMkpjVFVIRkVUeVkrQjVYRm5V?=
 =?utf-8?B?S083elRFS3c5VUF2NXZGZWdZWmtjT1NUdHRWK0FmbEZpcWFrb1ZWKzAxdHJG?=
 =?utf-8?B?K3g1cVBLNUYvWkRXL3Z2M3VheXV0VFJ1dkc0MHc5OU5reGJxdUpwb21DTDBa?=
 =?utf-8?B?OVhPRlpCYmtsWFI2YTJNL0l5U1dQcUYrdnQ3Q1hSNmMzTGlrOG15WDBudFMy?=
 =?utf-8?B?Q3BPNUwrZVQ4Ylpjbk83RkVvNS9kNFN4VGMzZmRTRUZBNTVDWEJIMTBOUW11?=
 =?utf-8?B?N0lHZkU1QVo4bnJON2Q1TjRBT3RWdVk2ZG9tMzdvS2RIT1JrdENzS2hWYVRo?=
 =?utf-8?B?U005V1hvSytkWGxPTkZtNWRRSWxKenE0SkVvdzg1TVF2OUNKODFHUytORlRx?=
 =?utf-8?B?ZVpkVFo5cHNkMkJLRk5NWFRSOTlVcjNybmhsZytCSDNhdmdUY3o2SFlGQTM1?=
 =?utf-8?B?SlFLUVFzblNNSklrdXNNSFVxSDcyMlB5T1F1TERVRzljalkwdWg3YmdMcS9u?=
 =?utf-8?B?OFRKS0pEU2FlN1QyQmU4Q2x1dFlKTkJibTRxaE40NEovRkp3b241dnhTMGRy?=
 =?utf-8?B?T0NTb29nU2grY3p6M0JKWG1oMm5RSDh0dUN2RHNQTzk1TTBvV0k4aXAxWGJM?=
 =?utf-8?B?N1BWS2tzVkRNTytiV1RlRHIxeFQ0dlR2MnBhZldsL1kyK1l2N2dXM0hHV3RW?=
 =?utf-8?B?NG1HSzdseURnPT0=?=
X-Microsoft-Antispam-Message-Info: zK50hoBL8CRFCrBV1di6CnXRmxfxmChXKz1uGn/a6ZDk36fr59CiEQ7s5sPoizg6PxAWyu+M/dFJpc2k5YGJqgcKBt04dQ5pWyOWUthPckPvum/kph/3XAzi9Gk4+JujS0Dst++5UAjyGoOSugOBC5lwxZ8mG5iQWgbEmyfE6HBM3lj+W0lOS/VeXJ7bSz0bVlHINVvbZ3sjuiE1gqCTRRinRyS+VjLawdFCP1fK0E9oocFW3NFtjHjfdITy4Gs5F3un8Csee23CDnPmvCvRaZTV0aHnj51UUkD4qrdNqQYnBGqtHlk5KL7SjAqir5WpmddJ3WOvfvnUr9Gli1V970k+VfYqABXctMjh/qbIaQQ=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3262;6:6LiGJRrVDFv0Bx8Loy6Wf2GEJbrjSPHPmCb6ysm5eUvOCxKQDP7k7FdrCA6G7JI1mlUEeCrLejvA4ixSlKuEc5/ZDWnBM10H3N5cFzo0TCa6WCYr/OYwYjAFDPPgtfLWg2eDyolOBR1SPR74hQ/1JVSWPxkQeMcn0rpn6YLCUOH5YpZ4z8gMuaWo6jwRlsZuhozEN9w4V3a4Wn6c2bxcO22ch7LE4gxFH13lgfMhDMsezL85Z78/TO+4HjIFJQFke+6PtsxYNBY1Jf8AKJNJLEB3015gIQNtFMQlN2D6P1byJS1TY3Ffk80fb9pDWxZBS7PDxtS1I43fEd38ZNSWGqQIOcD63QMwjSrw68wDTQINaE3H5ukHW4EU4m8qZtzQlq7aHVWQ9clJg/nTMqdIWBy3oT9p6yzKesR3jDkUpixRFlAuAG1yVB7Z2coWgn6G8gYfrIInUmsfn9Vzgm/WSg==;5:5+7O0UGP2TvaI73yqg+7dPq34j7P+e5tpa5P76/ttYbRiTG2yPAiD0z0Y72BLdGPe/UuAkSCLzboh4hWTpHwevXbbSYn9+6w9bZLltj/dE3oDi4yj6UZ0pVEx7zCsEJNk9AjQx05tdXZS0EkFvBqp4mtXWZMqB0uzU8CmcJzB8g=;24:PvJqBSo1ln0mttMnxeYy/gVDCY+qbvV4HGqLc6M4c/4Cj5qhbHBm2z5+OdX8XCEMfRPycL2kqNf5tcVuSSEP6tk+atonBeFLdlxAzinr4ns=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3262;7:3oKh/s9ezZrJcUttYkZNlnwlw0Z6ZhPDIWXJ2xSvLdit4sSLjiBkGP5LdywEVXQYKD8UOx9SdWjjVDe1oHmefj+B9Ppmh1qddZ3GeEio0TUm1Viwh9T8ml/hpyNSeHy1XCOqKfZCE68N/MW84eATeuwfzf6Z2dIkp6cQEETzSiLZmWMKZ7ET3N5rYZYd2kR2Bvad6S0j1QIAJdZS+ZUZjyyj2paxMx9Fjp3smRieIfYMwGQo/zJg1afarMHicooy;20:PcwbQzXYji4lLRl7+G2uZMFONNvD8i0bechicFdR5CQvO9IVwpNRoDXw+tS02KXKn/GUTqB+L/KY3zwqUS6Kq3VgAx3C7p3YNLNizwy2VPu5qaSDBbd6h0RMZcfwkyCuyVFB+ENnWIGgnZ1uHz3cryqT3DHMWFqpUf2QQ685CoE=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2018 15:43:31.1955 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff1eda13-9699-439f-eb6d-08d5ebfc0c78
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3262
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/17/2018 05:47 PM, Miklos Szeredi wrote:
> On Mon, Jul 16, 2018 at 6:03 PM, Andrey Ryabinin
> <aryabinin@virtuozzo.com> wrote:
>> The 'bufs' array contains 'pipe->buffers' elements, but the
>> fuse_dev_splice_write() uses only 'pipe->nrbufs' elements.
> 
> Hmm, only valid with pipe lock held, AFAICS.
> 
> True for using ->buffers as well...
> 
> Would you mind resending this series with an additional starting patch
> that moves the bufs allocations inside pipe_lock()/pipe_unlock() to
> fix races with fcntl(F_SETPIPE_SZ).
> 

Sure, will do shortly.
I suppose the patch should go with a stable tag, right?


> Thanks,
> Miklos
> 
