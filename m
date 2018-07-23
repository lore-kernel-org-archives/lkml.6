Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893BFECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2449120875
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=epam.com header.i=@epam.com header.b="hz4MYhOj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2449120875
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=epam.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388126AbeGWJjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 05:39:15 -0400
Received: from mail-eopbgr00040.outbound.protection.outlook.com ([40.107.0.40]:2048
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387972AbeGWJjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 05:39:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f9RMkAWZzNIR0BWW/jRgZtXQ0oo9fNcWN+73EDKZzvg=;
 b=hz4MYhOjPd7So43o6ns50bD1b38ahUjbGuGad0YNAKGT0oZ5olj6K3TOTU2nQqQwygLN9RYIFQ7AatjveJIGTLXR09n3YU7OaUGvc5FNJqeg15i26t/5JEcF/KHgAwFQu0+rEw3vKaV4j1ubZh1IctybReryJV+Ng8dXmJvlCXY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com; 
Received: from [10.17.182.9] (85.223.209.53) by
 VI1PR0302MB3213.eurprd03.prod.outlook.com (2603:10a6:803:18::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.21; Mon, 23 Jul
 2018 08:39:03 +0000
Subject: Re: [PATCH v5 0/8] xen: dma-buf support for grant device
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        jgross@suse.com, konrad.wilk@oracle.com
Cc:     daniel.vetter@intel.com, dongwon.kim@intel.com,
        matthew.d.roper@intel.com
References: <20180720090150.24560-1-andr2000@gmail.com>
 <019c0eb6-8185-d888-ae6f-305ea2d44124@oracle.com>
From:   Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
Message-ID: <df3e8c07-c8b4-cb12-32ad-119498be114b@epam.com>
Date:   Mon, 23 Jul 2018 11:38:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <019c0eb6-8185-d888-ae6f-305ea2d44124@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [85.223.209.53]
X-ClientProxiedBy: VI1PR08CA0210.eurprd08.prod.outlook.com
 (2603:10a6:802:15::19) To VI1PR0302MB3213.eurprd03.prod.outlook.com
 (2603:10a6:803:18::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ebe14ad-a47d-4cf5-0a3a-08d5f077bf24
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0302MB3213;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0302MB3213;3:fHey5HQiECwLg6Cg+x0yc/qiP8gEWgjlGCz/prnx27z+KF8oPMCg098mxlJIicCxoSxbo+JzLcWYEA/ebZiXCnIBciDjSMvh8IclTReyuxoHfRdjnMW7P23zvOYKx4NKgqbFulZKgPOnRVE6muq/6arCKbImVjRyGY8BxkxwLYcxwZU4ZzV+xDs7ICHp+5yUghEpIumgJPiBVhATY6r6niAIR7AwQWMqFqMXCCVU76DoyKYwRU2qCnCnSSVkAmIu;25:Lk2XMdB1HXoIk+yvIpP5HhfV7IlgnV+sygrHrhUzr0MBUgXrRWJzKr10NZjHP+oEIofCEZAb19BXCL/8lWy7h0Sdx8H15wg5zLYHgfYCPyIC9CAGc9P2rGsnG0S7bpVX2kUq3hzXw/STCNFbLncNGyotrZ2hp0QrDLR4wXChdJGRjRX1lpIsT1SVen6+UwhrGzIQiaxeKxfLZBkAU8+YihaldjNzCg8ZjbWjQ5jh/FLUZzG+JgcYEFcUCJXPIQDZBqK00L5GrIbNBWgJ5X8vfHsWlyJExb5qcug/fRpJWEjaV3yLyiY1Q7osTc6F0j/tZwMynOvQ+adUuWqH1yVNDw==;31:rF+c1Mn9T0VBEBoNlskd05J2qiVPlvTVSwemSeeh6hT5SN4jaAJ86C/vBDBzd02BUu78I1b+RYHWeVfKk8P8WZ6iYZuttMEiT9P94GDMJmB5ZchGsN4lScYkWa14ueHOMNT5cwhRRkkzxB4IkjJDWHcS2cH3VXgLtY88v0OtUqql1+72uwTP8NnPlGfHBiTJ1/EE/JzsXLGvw9lQrYH3YW0ZR3vByua9fCIqCCQrH/Y=
X-MS-TrafficTypeDiagnostic: VI1PR0302MB3213:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0302MB3213;20:7p0P+1G68gp7RMkZQRyU/o1uVTFMifQHwrkurdJPX17b5MHBuddL6fiS7ROop+a+pQd8CkD5b2KnjT8H3kPZ6MDWUXkxG36qeXqUphvEzmmeZcZmNCb90YLrCEvQ+w/XcRY+94E6uQU2RHs1zJYhn85eCv+NQC6L8QQKBO4eDmhfrxiSLubrGbzPawVFQ6+dHE3wxTPPfX5TVrOQAciDsyUMoHGPU2GJK9xFLZUN39U/Z69349aaltNSpNTpfu0tvC8SGSxFCId0GPTyzWfFv/lCwGG9NdgLfhFD50utLOyzp00f25PwLH1c9ZYN5clVDIkTP+Lt6i6Za+Nx/LmAgmnirgkxyQEk9XMWrdXk50LfFmGfcYHlQ1iHNDhZnQoSuL1kIunVv5Shkl6Oy6FDHYT+aDrGhZZ3+9wzdU6VHnlJhuGBnuSmMPOwvnc3jyztgHIrPO0O/tVYzyBTLEFHUcRTxUfaQF8WXnyR2sCvV1L/7d5+NE4xvQDFLsack05j;4:F2+pTa2+OJCpu1sjpO+oCOu2yfFq6GPDbdfEizHH8ruWvLo4uJo2r9CXa9nwOaGtae0R1jnvMm5r4j1bPLwXxarfQwSRw7XP9IS2vL4ZokeeWtmUhjRaAJRWWXXZbEqeEwYgygNTOzt4qN8h0LpmleGD/FmUH84qxrAbPGoBjoOMfchqMNc4watfzuBC7wBysJApC5DZ3ayzuIglYpl35cm1zfViysTRJ4U/NZ0hOQZWcIZOvMgliuC80OQ5EkIezgevkslIQMw7z0bGgEZRU47v7aqH/UXZxJWjvhk2B2xgwL6KakYz2zETTdgMKQqn
X-Microsoft-Antispam-PRVS: <VI1PR0302MB3213E6C522EE512F6D3D8B5AE7560@VI1PR0302MB3213.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(4114951738403);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:VI1PR0302MB3213;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0302MB3213;
X-Forefront-PRVS: 0742443479
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(39860400002)(396003)(376002)(136003)(346002)(199004)(189003)(2486003)(52146003)(23676004)(76176011)(106356001)(80792005)(97736004)(31686004)(52116002)(105586002)(64126003)(11346002)(446003)(26005)(77096007)(386003)(186003)(16526019)(53546011)(66066001)(50466002)(2870700001)(8936002)(68736007)(8676002)(6486002)(14444005)(81156014)(55236004)(305945005)(67846002)(316002)(16576012)(110136005)(58126008)(2906002)(6116002)(36756003)(3846002)(229853002)(7736002)(81166006)(7416002)(86362001)(47776003)(53936002)(25786009)(966005)(65806001)(65956001)(6246003)(4326008)(478600001)(476003)(6666003)(956004)(31696002)(5660300001)(6306002)(39060400002)(486006)(72206003)(65826007)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0302MB3213;H:[10.17.182.9];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: epam.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAzMDJNQjMyMTM7MjM6eXM0V2hEMnluT2Z5T0ttTFFnQldPaVpy?=
 =?utf-8?B?eSt4SmhmUFdPTThKRGNmN2lOQ1lhUGQxQ3hnSE9QcjkrWUN1QjRCK1g2cmJj?=
 =?utf-8?B?ekw5SWVMSHZKMVFQdnA1S2JCelpyeU9vODZnMXhmdVlmcktjbkY3VXpieDlk?=
 =?utf-8?B?clVxY1ZKVmtnOWgxTmRoL3NRcXZDQU9mdmtxdCtpSUpPNzRnYVAwZG9tVHJJ?=
 =?utf-8?B?aHl5ZitzclllMWJodk9YaGhtUTF1bjF4bVovUDRSZFpzZk9LUVBFMkJvZzI1?=
 =?utf-8?B?R3RTSDZpK2FHd21XdmE0dzJUcVJWOVlrdXV3TDdsOGhkOHJQS3d4SS8rVVVC?=
 =?utf-8?B?b044VXVMWDhmeDYxd2NaV3Rod1BqUmx3TWcvekFSbFNFZ05MTGJaTldOWmJM?=
 =?utf-8?B?RzFKUkh4d2xzaDRvSTM1M2pWbjRpb2dET09ranF2aDlQSWpkOWtOaFRvVDBJ?=
 =?utf-8?B?QkkvaXFEWnU1Mm8rUDNiVmZHYU1uZ2JITkg3MFFWbGR4Y2V1RkN1eklSdU11?=
 =?utf-8?B?MHNrZFloZ0EvNkF6WnZoUVZRTWh2SzdEUWZCZWMzcmJ1MUE2TXIyL0Nubjha?=
 =?utf-8?B?VUVpUTQ2MWNhT3AyMXJIOG8vR0VSTW1od0JvL1hiZDdCQStDUkFOckZkK2t1?=
 =?utf-8?B?WGlMdEE4dC85OEpuRi9aclRjeEN1YmtTOVkzUHdvbGtlVHI2WWhjUzIwVFRv?=
 =?utf-8?B?aks5Y2M2VlpkTVRIcEt6eVBQWUJ1cEZJNFNRV3gvaXRYeDBBb3p2RHRtdmtO?=
 =?utf-8?B?Rk1vTE10VUg5TThRR3FVamV0NWpXWmJPYnJhQ09sTmNVdnI0cjd3ZUQ5d0Qy?=
 =?utf-8?B?VVRkakp6VDRYS0NhaHU5RWMyNGJUZmhqU3c2djdKSjM0Zk9ZV2NzTzRmUzVB?=
 =?utf-8?B?Sm16dXBKZ3duZHVDSjhCdkg3VlRqdktHUUFXc1dHcm5IeGtZdkNQN3lORGNH?=
 =?utf-8?B?RWQ2bVVjSFFzSkRSenVUWExzWkRROExNcTJMWHZnWm1DUGttUW9VdThMeVhX?=
 =?utf-8?B?WE1jVHFGRnpXMlc2a2cxNy92OGExU0k5M0hsb3FGWVRtZi8ycmtyZFlXaHBy?=
 =?utf-8?B?ZE94ejJELzBMM1RBZ2duSXNsUGovRUVZN1NsWGFqNVovYjBDODJlaEpSc3d2?=
 =?utf-8?B?c2ROQ21NQkl5YlprNTRiWXd0dFIzSzJybTc2YkFHTTMwQTBnUWtZUDExWm1B?=
 =?utf-8?B?OVcwKzVxYmc5TkFkdWpibThISDQvU0hsSDhQdlpCUmZXUkdsWXhaSTRNQ3hh?=
 =?utf-8?B?SUNZZ2hRbGpEdXNaR0dFank2eVdyMlU1UEphTEVQZXVXc1ErS2ZWd05OalZQ?=
 =?utf-8?B?c0JYYzNIclNReGx1R2EwTkFKS0p4UVhCMXRqN2ZRTG1Hb0JEWXBLM1R6OGo0?=
 =?utf-8?B?d09IekpuL1FOdlB3aEd4dXYvZzkwc2VxQlJWTUJESkZpWmU1aVZzK2JCc2gv?=
 =?utf-8?B?TzY4RXpBYTE4UUl5UlVHK290L1lsYkxyTGo3YldPSE1DeW4zUS82OWYxNVhZ?=
 =?utf-8?B?RGN1UDJ2RHpwT29PUGFYZytSMmQ2dzF3MkFLeGE5TmEzMEdKVmNGdERXOGpk?=
 =?utf-8?B?VDI3bWRmM2tDWVZpWmRVWjlJRTR6ZVJNcnpxS3Q1SjNFZkt3SU1iVktLVCtD?=
 =?utf-8?B?WkI1dUNFM1I1WFZjYjdSL2YzMkpWT0ZTRythN3Zrblp0Mng1U0xTTkhINEZB?=
 =?utf-8?B?VSt0S2VuVDYvbUEraFh5NU9sRm5aYkpQeFB3angrZ2Jja2dOMTVpUGVudHFy?=
 =?utf-8?B?bDJiQmx1b1dkYkZPRFFkTG9JcnVYbGRCRXZGVWRqL0V2WVVPb3dVbjNCZUhY?=
 =?utf-8?B?a1Fkb3U4a1pHbDVXZjJMY2ttekI3bWVwRlRuOWQrL2tTYlJNektlS0E4MFdV?=
 =?utf-8?B?ZVc1Y0xQaDlLUllGYWNHQlRmUElHZWhIMVdXeDhDSlFMNVk5R01NUloyOVdz?=
 =?utf-8?B?SXY4YSt1ZFUxM1VJSEtacXpCVmNQajdaQ2oxaEYwajE1cFBVeHZVQkI5aUlC?=
 =?utf-8?B?Y0o1bVphMWxjSjZuS25oVjBod1NNeW9KcnlPNk41bkw1eEJ3MlV0c2xydngv?=
 =?utf-8?B?aVVTWDJYZ2luTXhMNEhqRDRRbzNqUjNhUG5aSlVJMFVNVzdzem1YQUdQNzBt?=
 =?utf-8?Q?GdB1UpYEGe56ItUsgV3Hq2sAHRjoqmqYrU9cooQQvisIm0?=
X-Microsoft-Antispam-Message-Info: JShQsVsYo1t1h1VnlZZxbxU2+rYWO7oTa2WtAoSq10SR4+UHiVfvAp/O7DJiCi5htManUTe8hsTaQDt61mf2BGyYwU6zUV6+RhGkN1ixeeafuAUn53gorAoGp5Wm4JyZbAJNX1D8Rh8PoawG6yFOzkuNDfF2s6Z+t2yF7xh4aN8RcyNa//CZVDS4eOV4dez35SLpW+DW0+Pl8ouHrO3qeqJjZb0xdvWaaJoTjhjFk0iZFI15iKoErgs9sz6g8wbwZEnaaY192lisFHnaVgfAblgKIVRiOXteiDs6waRS8F/T54a0Ej1NkagBN31bbNHItOzfmWIEBscAw0KhFZZDJzb1xkDC8JHDeVe8DjlKI6w=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0302MB3213;6:osEkNnULfc5rSiT6DdVOUR1aHz/uIt+E7y0hEKi3SYDPJx2Aw7Uk3R7iG0q8/o35bWahDDDueroTbdUXVA0oKEOIdVUhNkwEnNAnNgIPs8Qvl+m44N0equhhs95b7iZ2RJbKDsw6+n/xU9+Dj+NBSU5UL4X3es8ReZsBTOTJFmvyEpfAaBsmg5Sg9BFh06TX10r3UbceCDjZMjhGF3ZtgzYaAMyv01PGQdZMqdxzakCJFNHbd+4zit3uN1MgmjZuGkUbzXjewwZPcjbrAk7dtgBddjwozFEDZod/q4DDzyz7TXAx+PhXc7wEOgewNGBCDuF+EMEFGcHVcTlxCcvc1SMJsdlOTbZnGTzXZ1kD9EMl41dl41H8BTEb3CQbhXWbgdFn10IZTZOo0I7/Acvhs2TF76H4vha39CHpANErrOc2GJM1JceuL8VUQWpiMSSSSyQDOyl32yqzs7IbXL8fDg==;5:Ve1WLY/lddm9wjmoy8mJVRID9qCIN20GJD7JsSaSc/re5k2j98UCcoSTrdcNtLa1sMls4W907abA7r4wM1wtdSiQHOj1k0SNSgn3FOeRCTgwubjI3+8NobN70ePbL56dzKKo1uUq/p8fC6VPXyKVtwrvwCHEgwK2YxTcqLf6Yl0=;7:yEFH2M0tRXvGvzm0nKGCwEpUrj2AKL5YI/G49ScpdJ1MaJWWVFP0EMOWeSQVA380tzVOLGdGeltMdHJLYghYPNRMobDV2Wpsk66U1WqE/sh3Ae0m5xIhjfGc8Q4hOzznnNtMuF4TMgCOP3DOSaKP++nlm6mCRP/BdYTpQdAKhzJZXYeLhGnzh63nfF2f+5DWYZOZ6lsLOo2YnhUaWLMnzkzq91P0RpQuJhlNMSnYy0RcRmxmxuHnSY0xvloBvE/M
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2018 08:39:03.5073 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ebe14ad-a47d-4cf5-0a3a-08d5f077bf24
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0302MB3213
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/20/2018 05:08 PM, Boris Ostrovsky wrote:
> On 07/20/2018 05:01 AM, Oleksandr Andrushchenko wrote:
>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>
>> This work is in response to my previous attempt to introduce Xen/DRM
>> zero-copy driver [1] to enable Linux dma-buf API [2] for Xen based
>> frontends/backends. There is also an existing hyper_dmabuf approach
>> available [3] which, if reworked to utilize the proposed solution,
>> can greatly benefit as well.
>
> Lot of warnings on  i386 build:
>
> In file included from
> /data/upstream/linux-xen/drivers/gpu/drm/xen/xen_drm_front.c:24:
> /data/upstream/linux-xen/drivers/gpu/drm/xen/xen_drm_front.h: In
> function ‘xen_drm_front_fb_to_cookie’:
> /data/upstream/linux-xen/drivers/gpu/drm/xen/xen_drm_front.h:129:9:
> warning: cast from pointer to integer of different size
> [-Wpointer-to-int-cast]
>    return (u64)fb;
>           ^
> /data/upstream/linux-xen/drivers/gpu/drm/xen/xen_drm_front.h: In
> function ‘xen_drm_front_dbuf_to_cookie’:
> /data/upstream/linux-xen/drivers/gpu/drm/xen/xen_drm_front.h:134:9:
> warning: cast from pointer to integer of different size
> [-Wpointer-to-int-cast]
>    return (u64)gem_obj;
>           ^
>    CC [M]  net/netfilter/ipset/ip_set_hash_ipport.o
>    CC      drivers/media/rc/keymaps/rc-tango.o
>    CC [M]  drivers/gpu/drm/vmwgfx/vmwgfx_fifo.o
>    AR      drivers/misc/built-in.a
> In file included from
> /data/upstream/linux-xen/drivers/gpu/drm/xen/xen_drm_front_kms.c:20:
> /data/upstream/linux-xen/drivers/gpu/drm/xen/xen_drm_front.h: In
> function ‘xen_drm_front_fb_to_cookie’:
>    CC [M]  drivers/gpu/drm/xen/xen_drm_front_conn.o
> /data/upstream/linux-xen/drivers/gpu/drm/xen/xen_drm_front.h:129:9:
> warning: cast from pointer to integer of different size
> [-Wpointer-to-int-cast]
>    return (u64)fb;
> (and more)
>
The above warnings already have a fix [1] which is expected in 4.19
>
> and then
>
> data/upstream/linux-xen/drivers/xen/gntdev-dmabuf.c: In function
> ‘gntdev_ioctl_dmabuf_exp_from_refs’:
> /data/upstream/linux-xen/drivers/xen/gntdev-dmabuf.c:503:6: warning:
> ‘args.fd’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>    *fd = args.fd;
>    ~~~~^~~~~~~~~
> /data/upstream/linux-xen/drivers/xen/gntdev-dmabuf.c:467:35: note:
> ‘args.fd’ was declared here
>    struct gntdev_dmabuf_export_args args;
>                                     ^~~~
Strangely, but my i386 build goes smooth.
Which version of gcc you use and could you please give me your
.config, so I can test the same?
>
> -boris
Thank you,
Oleksandr

[1] 
https://cgit.freedesktop.org/drm/drm-misc/commit/?id=9eece5d9c6e0316f17091e37ff3ec87331bdedf3
