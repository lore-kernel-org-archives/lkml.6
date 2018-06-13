Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 79E6CC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AD8F20020
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=epam.com header.i=@epam.com header.b="Kb6x3ttI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AD8F20020
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=epam.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964781AbeFMMD1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 08:03:27 -0400
Received: from mail-he1eur01on0069.outbound.protection.outlook.com ([104.47.0.69]:29563
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935365AbeFMMDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 08:03:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mxzjp9fl5Xi75hav/ZbsDgHRwrF+gYSAZ+F7wou6+A4=;
 b=Kb6x3ttIO6U+WNZQr0A2ezh0fLTGFZtis/fNeqwdJnPAjH/SShI0KMOUilUtbDtLQjt1H+QvuztkLMzxYxilbYIpAtR0GO0hr/3cMFe0UAgY7YDFa9HvY01ip4PGD+vo4DMj214WUMEMUWL6QxMX+GWOFt0hjJUbUDlJnJZb/+U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com; 
Received: from [10.17.182.9] (85.223.209.53) by
 VI1PR0302MB3215.eurprd03.prod.outlook.com (2603:10a6:803:18::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.841.18; Wed, 13 Jun
 2018 12:03:19 +0000
Subject: Re: [PATCH v3 3/9] xen/balloon: Share common memory reservation
 routines
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        jgross@suse.com, konrad.wilk@oracle.com
Cc:     daniel.vetter@intel.com, dongwon.kim@intel.com,
        matthew.d.roper@intel.com
References: <20180612134200.17456-1-andr2000@gmail.com>
 <20180612134200.17456-4-andr2000@gmail.com>
 <d63f0cf5-5154-f2a3-155e-fdb6dd0959e2@oracle.com>
 <cbaeec5c-0d69-881c-2b42-54855e53015a@epam.com>
 <b79713a9-3a2d-6465-3b22-622bfb7a4d3e@oracle.com>
From:   Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
Message-ID: <cceefb52-d1bf-c6cd-1b73-489015602f57@epam.com>
Date:   Wed, 13 Jun 2018 15:03:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <b79713a9-3a2d-6465-3b22-622bfb7a4d3e@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [85.223.209.53]
X-ClientProxiedBy: AM0PR05CA0058.eurprd05.prod.outlook.com
 (2603:10a6:208:be::35) To VI1PR0302MB3215.eurprd03.prod.outlook.com
 (2603:10a6:803:18::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e52b0f3-0c20-4757-4709-08d5d125a7f5
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0302MB3215;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0302MB3215;3:N49rZZmOBHsJTMiMo6rqbGqX0aIJUtnE/7acGsjlJfdwW1gTs9NLa7NX+LDNSFzoz52U9earvBhqbNW5uMDnwBMrdGrpc2sHo+8wZF1H5sWPmlUKJud/cSS0cZNRwddV85gE5P7INP7JBwAObyMTvoZ6MI+fRE2Xm13nICoTRaekOQSUF8FE2FfKS/zcC7LrBKoeH9iw5GYPpaaoQTQmqhdUhqmuS7jCYPuzzTL9pogkwGEukFzihCC7V1exKl/3;25:JeTGUOlleZCOwrMOZ7HWppS4OgfGyhsLrY29zMSuNZ9QmV7Pkc+y0kxeIgPJCm4dCRO4ej0W6zbvYb25ZMuxVfF9Gu91j0mkCcpT3+zHKiaH7K3SYlLXLCovrWD8hLx66UcnCI7eS34XaUg4QnVSDDf8sWle83cpRXQVPJzHHr20F90bHiFRUwG1ozIC7L/0mOAD7YMEcYMXh68NEpDGFIPJXk70QmE04KmgbPOCO2j+/EY/uwSN/MJiSFcVuuYifl+5ptVe9KeB+IBq3Yryd/F1Fqd4aTryq0p3zCPsSxB+l0MUIZ4WcC00Y0SHPTN9me4rHhTstRoWoyisS4WKGQ==;31:QMtiwvSzjM0wyGsvZf/NnFKKrUidJMbIDmFyFN8VKt4zx5oJgTGYjjteXLTMpwmui70i5iRjiZzTx/aTtvSYL0LL44ZIjlgvzuvqlLJd5YL2l0b35Myc1DFuFQk8ooWcr/UfAmBflK5JjVikwHO60h5ix3KlDB5apHS6ROO8oqdAXZ6MQsjQoVNy+louzSeyb85Io6Qwiss/16Ae/9EX56DSCg1dVdV0WSPuIdJnscM=
X-MS-TrafficTypeDiagnostic: VI1PR0302MB3215:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0302MB3215;20:pOMIIwR1x4Zq9GieqqAcrG2QNYHZyGA+n5+g33CCIOfo1raDdfVpXC39RE5HijMQH8asBzCUdeIeodiWORkNfyv3TlvqPogazEIz6eLc1lv1a/VAML5RndxFrqv34wyhJHvWYVEPU2JOvLTE4QHbJRh2hB4pAPiYpyeGkJIKWCuQwcuQXJ/e+wYEF10JpmbRxcvz0EvxeGuIVetSBKgOBTg4L5QnDZhmQM9c+QTA6JTcx/SEapTU+bn6ULt0vhKIxXQWZxFDNuN2HNEYjJpSy/QDsqmi2UQsSsVxHILDpBRMyWtdBcIz5tRK7HAGz4koQjlTAqUj/lzv17S5WoFXcmbD2Qk8NTCIy2wg9u1moAD6pM/50xL8ofMKuz4QfpL8xABjQlfssTPoRfZGKWLpFzfTh0/AINpSdUnSQS1B0pxEKjge1XUIgqme+oSiNzeHpBD7eK704nkH8QrLZb2ecew7ZIIhRY4dg2Tyb4E5EaXMr/hsZ5/+d4LIXdZnYxeM;4:ZLB9QUV3unEIiXRL4/6m+JZct7qbvRRxH0qOhHdZBOjiYUxGoGpcgVKFT+mxzlhjYIPe78FFthLpSt5cUjsA9/7QJ9jWEv/s/tYl0E1Cb0o+CJgKt/p8X9MhPXFhAgYXIP/rqfVtZmIzz8IvrIy2pGmzX1c/17SUstVqxpNRF7b3njtKwn2mEgJw8j4RZMvjGXyynbGgbkXtPO7AXM2A4zhOLuMcs44aNxkew69u3kItATlw97o66tErz2pLjJ5rOkF+7w0A8WRjFl+eRHC9Nd6oT/kWl6xa+y1yZKavHvob0oEcc+2xlMn69vbIyZe6
X-Microsoft-Antispam-PRVS: <VI1PR0302MB3215730C841F1CFCAE1D654BE77E0@VI1PR0302MB3215.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(4114951738403);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR0302MB3215;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0302MB3215;
X-Forefront-PRVS: 07025866F6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(376002)(39380400002)(39860400002)(396003)(346002)(199004)(189003)(2486003)(67846002)(77096007)(110136005)(50466002)(7416002)(53936002)(58126008)(26005)(59450400001)(36756003)(76176011)(52146003)(23676004)(52116002)(55236004)(6246003)(316002)(2906002)(16576012)(186003)(2870700001)(16526019)(6486002)(93886005)(68736007)(106356001)(386003)(53546011)(64126003)(229853002)(105586002)(3846002)(7736002)(97736004)(6666003)(11346002)(39060400002)(80792005)(65956001)(65806001)(66066001)(31686004)(956004)(486006)(2616005)(8676002)(446003)(476003)(31696002)(81166006)(6116002)(86362001)(25786009)(5660300001)(478600001)(72206003)(47776003)(81156014)(8936002)(305945005)(65826007)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0302MB3215;H:[10.17.182.9];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: epam.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAzMDJNQjMyMTU7MjM6YWpCUExiSXBpcE80M2FEcy96ZlBib3FO?=
 =?utf-8?B?dFpQTEErYXRVRFdrOTNMd2pqR3NPREg5UUlxWXpvZDN4U0F0VzBUUmZZR1lR?=
 =?utf-8?B?YmZoVFNrdnJWVzNzcy8vZEduNG1aMTZ2T01KY2dLdCs5NTh1aFljOXY2bWcr?=
 =?utf-8?B?MDhoWnpQT25OZG9OWnN0Vk0xMUhINCs1VW5iRXp2Q1VSQUFTSUhDMG9SWHI3?=
 =?utf-8?B?UmJiUzZ6LzBXMVgzc2hUaCsvMDR5TkFsYzRlTXVyaG1QcDdiLytHaVlnd3Y2?=
 =?utf-8?B?T1MyajdaZ3p0NktzVE0xTEZ5WGwxeWYxQTNQSUt4RjRURG4zajRIS2VkeWlN?=
 =?utf-8?B?VE9nRXNyMW1GdHRCZS8rZWQ5aUJoVTZQQ0FOWkNuZmxkeXZXeS9MUnhhRUIw?=
 =?utf-8?B?SVFuTDh0SEgwQUYvOXhxeUd2d0FXTUFOcVZvMlhyN1k1OWxISEs5Nk5DeXlj?=
 =?utf-8?B?ekl3bFRIMkRGaU5kQjBoV1E5ZHNiSml5VUZLM0dLZ3RmeDRQek5SVWJQcHYx?=
 =?utf-8?B?MVVUQUlhMEdwZzN0c1V6dTh4VFcxcE9oWlFkZjFsSVhyc1BIb293OEpnVHRu?=
 =?utf-8?B?ek0vQVJ1VCtuenQ2T1UxbWhIUDE5L1pMa2JQQjNFZE5OVWo4S0JvbGd5cHNa?=
 =?utf-8?B?UzJqZkd5bTZSV2xVejBJZ3NabXNUY0pTaHcybXoxZ3YxYkFNZ1hnM0hCZTAw?=
 =?utf-8?B?V3BpM1JxQnBWdHV1eFVjaERWM1pWMFlkeTVlajBSWEtKaWpKZVRld3d2SG9Z?=
 =?utf-8?B?dklvL0xnUGRnR1ZKVVI1d2RwM3lQOE5OeEJRd3YrU2xOd09kU3JyUVFZRDIr?=
 =?utf-8?B?WFB5RkIyNGJPNGpuMDc2aUdIazJIL3JaRVZDdnhoTVN0RWpjdC81TDBLblpx?=
 =?utf-8?B?SHNweEh6THY1WEV5VGZUUE1qdUZnTDBzZUxzN3ErcFRsKzNBR0l0eG5wOWM4?=
 =?utf-8?B?Z0N0MTJqLzVKZ0RrZ1U4UzZlNm12Zm5UbTZWZlM0NUFnb3hrVXluN3VYZUNR?=
 =?utf-8?B?bkJzNS9hNmdId3lKdjZTenZLcHNSUTlmTFBPeDE2UEV2bVlpbUdMd0hoVDl3?=
 =?utf-8?B?MWk5RzFidGNQZDNWWW1pY1hsUmlyaGx0RFlzYkFwVWVoNnZGbjcrME9XTVRB?=
 =?utf-8?B?cTBmWldtMGR6cHBWWEVRWWNVSTdXYXpqbmk2NkxoZkVSS3dWcGQyblh0MFkz?=
 =?utf-8?B?dzNXUWhEODdjdi9DZGdZb1NmR0lESUMxdWllWUJ1bnljMnVMbjNxa2FMN1ZN?=
 =?utf-8?B?TTdpdUpBVGhBaHd4Z1BSRG1QK0QvTHRpTmg5Tkl0VzNTRXhDOXhDUWlFYTdh?=
 =?utf-8?B?NGh4S0FIV0hRS0lZa1padTlsRkFKM3NKRzJJODROTW5FT296UWFVMjRZWkg3?=
 =?utf-8?B?T2poc3RSRFd2eUxtc1U1RnFCbHB6S3lCNEM5VERsTDMvUlVqNUs3T3did1J0?=
 =?utf-8?B?azBpaWcvdEZkemtIRmw3aWNhWnNjbFE3L0lJblRXc3JQbUsvdCs0OHBlT3Jr?=
 =?utf-8?B?U1FhMzlvMVVLN1RTYzExaUs5aVZoOFR1VTd3MU0vbHk1cC9NRVZVR0NibFUw?=
 =?utf-8?B?cnJoL1hDN09rMEpFSmtiNEJUSERZR2JuZitabk1FdW9ET3BFN3BydTQxbTFX?=
 =?utf-8?B?RjNKT0dpZkhxeWs4M0ljRmQ1cWhSa3RpNEJwUHhtRWJudEtOam96OUt1bHJL?=
 =?utf-8?B?OEl1YWtUWmZvOFpJeDdWVDVoN3ZGRGVHN0pFVWZxdEFJZm03dmhCaU91SnZD?=
 =?utf-8?B?b2o3TEZZbzVTR1U3RjdPL1JrbHZ2dXFkUjFNYTBwcVdtazhKS0dXMlhNT1V2?=
 =?utf-8?B?WlN6MHM2d0pER3BFNHlZdnVGT1JMZkFuNDdrT01yR01YZzZGeGYzSE9rbitT?=
 =?utf-8?B?OFZiUS8rYUc1RmtVK0FEUkRKMEYwRm1QRzVDYjVXYSt0Qk1tWFlwVXZOMmd0?=
 =?utf-8?B?ai96WnlmN21XMnNQUzZWdkZ2M2VxNEt3RG0yTTJsaTBqR01HQ0RmTU1yb0dU?=
 =?utf-8?B?L3RPdUpteTZZZWFxZkhPSXZoVHlzdGRNQ3pjS0dncmZrNGFEVlA0QTV6RTB5?=
 =?utf-8?B?MmxIR1RsOGdpSlNCYWYzQlkzZm1kODNLM2F6ZTU4SERXd3Z0R0dHRmVGZ0xE?=
 =?utf-8?Q?XfAfYg+eC+eGvs+fIbx5jdun/D9IAlGABY9p0qqRn2oh/s?=
X-Microsoft-Antispam-Message-Info: MzTWmFgcCqxYO2yg57ddUXIipl6MrerqCBnft/CFlDrYI05mxC6FK3YMmkr+AG03I2OLVE/yIPQD+1QnKB9wFn9rxxf2nMiJjKLDFcHeOVdalmD/OMyXl5WXclI1kJBQHVyBehmybFC3zEgYvkaFTGgrGUohrVY/YX/i4nOTazw6aGFJKX6tmgNMHesYLVP1
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0302MB3215;6:DIHnj7beMIeBSthWxnt/+pdEQlYWbt0nopi684zirwQuGy2PagRpN+RtiAJYUMuyqvj0ZN/DuPNbQOIZT+iHj7Og0XgU1lpj5VKNnXsjoZyTVJ38q2xvk3MpoBoLLnoAL2shsUy2NE3wDSWF7aB6MIy6pyPETH5vx5ZowwIMcd++AY+LLKeEmeMGK3V//lvxoUjS99fWE07WxohjKm8yIRA5zV0dG2Pos37NvHdVNPQc3loJcMS0z8wER3LsHmvJ8hrRvrF3s1aHTwKMpL4EheKVnmQuJIoEm8IvZMSwg9bKm/R2EnA6vjAOgOhcaySuWoewsjCEm1sDOH0oOPzEoQrPR+WUVMvtDeBHpawNHiagv16oc34o9vMwv+/uvNFfVjYgRuSrCZs8Swtt7tcWBx1c7zcUw0APNaxS1yGFY8Y1p2cJahV1N4vkhMiFZqBnUJjkp8w6tiBHQaueC9IVbA==;5:z+iWtomI1N9LgEvgB10LzTljI0VVXR7QZrXDm9D7irYlLVFKVnfXQcuU8BPldVB9B34neFnmxWxybCry1f6KbqWLOT3RVB5rkb+Rza0Qutk29BglBmGlBJReEbiOa3zetrL8FPCabkRL6EPU943xMIMW1IndcL7TnDynuqhWydo=;24:ETN2XsNkUdewlHQ7oCS5P6w5plXTRvS1dH0nfjNk1ATwrJww4+IJYa+uzZgjP+Fs/iwgVVvhb+GyP6wO8jGgwVNykPTfg05wdOYRrBfAptA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0302MB3215;7:jy0phINcwB1xi/TPDVqz8ePMZeX1kdHVpveSPao5+5hvAjFazOp+46qsmM9cAIPzdhS5MNUxgNgzb7aha/QSp3WB681IP4tsAHEVF6L9hA86lY2nmtQssH9HG2B/inWab+fW3dQDrgkiaWzNmx57jlmt6W3gEoITe8HXmXocn5KtT91SOWYrLfMUycByuALccXC6YNdtMjtr60WxAW1kas4LSBv2kOAzS9chkxb1nyKlE7qQql4JkChAnAb7EyLg
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2018 12:03:19.4760 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e52b0f3-0c20-4757-4709-08d5d125a7f5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0302MB3215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/13/2018 03:02 PM, Boris Ostrovsky wrote:
>
>
> On 06/13/2018 02:26 AM, Oleksandr Andrushchenko wrote:
>> On 06/13/2018 03:47 AM, Boris Ostrovsky wrote:
>>>
>>>
>>> On 06/12/2018 09:41 AM, Oleksandr Andrushchenko wrote:
>>>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>>
>>>> diff --git a/include/xen/mem-reservation.h 
>>>> b/include/xen/mem-reservation.h
>>>> new file mode 100644
>>>> index 000000000000..e0939387278d
>>>> --- /dev/null
>>>> +++ b/include/xen/mem-reservation.h
>>>> @@ -0,0 +1,64 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>> +
>>>> +/*
>>>> + * Xen memory reservation utilities.
>>>> + *
>>>> + * Copyright (c) 2003, B Dragovic
>>>> + * Copyright (c) 2003-2004, M Williamson, K Fraser
>>>> + * Copyright (c) 2005 Dan M. Smith, IBM Corporation
>>>> + * Copyright (c) 2010 Daniel Kiper
>>>> + * Copyright (c) 2018 Oleksandr Andrushchenko, EPAM Systems Inc.
>>>> + */
>>>> +
>>>> +#ifndef _XENMEM_RESERVATION_H
>>>> +#define _XENMEM_RESERVATION_H
>>>> +
>>>> +#include <linux/kernel.h>
>>>> +#include <linux/slab.h>
>>>> +
>>>> +#include <asm/xen/hypercall.h>
>>>> +#include <asm/tlb.h>
>>>> +
>>>> +#include <xen/interface/memory.h>
>>>> +#include <xen/page.h>
>>>
>>>
>>> I should have noticed this in the previous post but I suspect most 
>>> of these includes belong in the C file. For example, there is no 
>>> reason for hypercall.h here.
>>>
>> Yes, it seems that the header can only have
>> #include <xen/page.h>
>> Will move the rest into the .c file
>
>
> You may need something for clear_highpage() and maybe for Xen feature 
> flags. But you'll find out for sure when you try to build. ;-)
>
#include <asm/tlb.h>

;)
> -boris
>
>
>
>>> -boris
>>>
>>>
>>>> +
>>>> +static inline void xenmem_reservation_scrub_page(struct page *page)
>>>> +{
>>>> +#ifdef CONFIG_XEN_SCRUB_PAGES
>>>> +    clear_highpage(page);
>>>> +#endif
>>>> +}
>>>> +
>>>> +#ifdef CONFIG_XEN_HAVE_PVMMU
>>>> +void __xenmem_reservation_va_mapping_update(unsigned long count,
>>>> +                        struct page **pages,
>>>> +                        xen_pfn_t *frames);
>>>> +
>>>> +void __xenmem_reservation_va_mapping_reset(unsigned long count,
>>>> +                       struct page **pages);
>>>> +#endif
>>>> +
>>>> +static inline void xenmem_reservation_va_mapping_update(unsigned 
>>>> long count,
>>>> +                            struct page **pages,
>>>> +                            xen_pfn_t *frames)
>>>> +{
>>>> +#ifdef CONFIG_XEN_HAVE_PVMMU
>>>> +    if (!xen_feature(XENFEAT_auto_translated_physmap))
>>>> +        __xenmem_reservation_va_mapping_update(count, pages, frames);
>>>> +#endif
>>>> +}
>>>> +
>>>> +static inline void xenmem_reservation_va_mapping_reset(unsigned 
>>>> long count,
>>>> +                               struct page **pages)
>>>> +{
>>>> +#ifdef CONFIG_XEN_HAVE_PVMMU
>>>> +    if (!xen_feature(XENFEAT_auto_translated_physmap))
>>>> +        __xenmem_reservation_va_mapping_reset(count, pages);
>>>> +#endif
>>>> +}
>>>> +
>>>> +int xenmem_reservation_increase(int count, xen_pfn_t *frames);
>>>> +
>>>> +int xenmem_reservation_decrease(int count, xen_pfn_t *frames);
>>>> +
>>>> +#endif
>>>>
>>

