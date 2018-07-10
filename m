Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F885C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 05:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CA3620873
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 05:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="MbwTgICS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CA3620873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=caviumnetworks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751213AbeGJFme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 01:42:34 -0400
Received: from mail-eopbgr680068.outbound.protection.outlook.com ([40.107.68.68]:7240
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750938AbeGJFma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 01:42:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMb03Db2F3C9TX9e1gsVh7jA5wSa6qnySkHJpRLxGVQ=;
 b=MbwTgICSofFfSkNJIeXrFKiDSYdQPAjCLR2t33IJYyWjwjOgs/qqi2uJbrWG/aLhDWJDHXOv4R4gM+dAznPcTTapoEHnO4ayzLDiG0Lp/QQ6Ae3ZTIpMhAu3dRGACXdU9flezVPaPAsCBxylKOE8GUEwf48h9MLRkEtuxVDAM88=
Received: from [10.167.103.249] (111.93.218.67) by
 DM6PR07MB4924.namprd07.prod.outlook.com (2603:10b6:5:2b::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.20; Tue, 10 Jul 2018 05:42:26 +0000
Subject: Re: [PATCH v3] cpufreq / CPPC: Add cpuinfo_cur_freq support for CPPC
To:     "Prakash, Prashanth" <pprakash@codeaurora.org>,
        George Cherian <george.cherian@cavium.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     viresh.kumar@linaro.org, rjw@rjwysocki.net
References: <1531131048-60762-1-git-send-email-george.cherian@cavium.com>
 <802dd310-a26c-3baa-696e-15393d6e1516@codeaurora.org>
From:   George Cherian <gcherian@caviumnetworks.com>
Message-ID: <3bfc37e1-e82b-c09d-462f-bf4f79aec91f@caviumnetworks.com>
Date:   Tue, 10 Jul 2018 11:12:08 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <802dd310-a26c-3baa-696e-15393d6e1516@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [111.93.218.67]
X-ClientProxiedBy: MAXPR0101CA0024.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::34) To DM6PR07MB4924.namprd07.prod.outlook.com
 (2603:10b6:5:2b::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9cef927-5fa7-4577-45b1-08d5e627ec2b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DM6PR07MB4924;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4924;3:s8rciuVlcMqCK6EJneSA8f482duAwknP6+Cquu+ECpMiWztaUAn9clvTDS3Qz2wFPrhx2APa8n7t6PeCPw928qXpRlwPvshJXxoXHf2L14/xkAI8chABKbgMZbLWGOQN8Tgk8ZvxpyryvHaf/XoGq+imHI1qwIHJTgZ9Zw4MxeN4jIeeqM+RHFDgzi60s+dL/kdm/VhsypxoGu+2em8vF7tfNxVfTnCpEJFS8dWypLyBjY3hv3vUmmqPWd/ec5Rv;25:dR2Z03/OB8s+hsePDd22mYdlJ5csPP6nLP8c0ZA5hKCe9IF4QxAuhKSvug3VUqT3xtlHE0Dn7nNafm3zcQXtS+lU2TWtsoqTJMqnErOmuRDP+qgbnEDlLar5SxDgTRM2YVDG/nRQXMb/FBMj/SqqxoMZMxntLCV1fe30QGESWTDzhj+v05wPWSyh0yZeW1gk+AOkcFOJhXblHusjGrUvVSkOUWwC4vKux13YSYM9xUm9TclSE8KVlqgqoDChBdC/1wmeWrMsHARvcQ+ZjiSX/7dfopjlWaM7c/TUJN5XQ5Y+EpmgNbCQiPNVG/Tyh1RSxhoym3A98jWwUDnIjM3Lkg==;31:3bP43U3symtX9cfXM6zfIrEQgYTJ4L4HCe5yLErBxflXuS3yu8aFaLAFgChVYsMqeKcnC/KHjbifHeCekETeVDcXxJ+u2RSc1vHY3AJ9X7d+dmc2H1eTTb0o1yu9Y1UY/7TZqxZazcgo5tK0K2FgSdQTCanIWf8jYrQeNty/1U2jiB05bX4ZjySlY+XQf71OfcCPXVcE4bunGfU5kpuSv7s+tm2SFN4psWnUxLUt1eA=
X-MS-TrafficTypeDiagnostic: DM6PR07MB4924:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=George.Cherian@cavium.com; 
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4924;20:Pao8voxzqhJCaDnNGun8guuHLWofMjKMCH4RyE3NrySfsJ0BDwYgrmI/E7GbIuQqPauoNqFUw/muGs4a/IFiqDL+g5WxD+OEyFE7LDH4j0flF1IM+pKoTDYGxEvFIBusX9SOzDBLeSGf/Dh9rLe3JE4lgRRncGfKlu61H95EPEWNW4HsBpGUeysBoUZSrJjNh8RQD97iCnqvQxvaZVq4qHJdIZ6OkG+N6Ycqh04EmkFDIvdpD4pfVypgMOO79z3jVimaW7vOHRLnRFbdlI4kEe9L7zi5PRVb6C96+VP02kKGZgfED9ZtdYWVfS/046d5VF+fZoIQ+n1y9dSIlSdFdxPycXZOat7QW6apqJgBgzdFO71z3jZFwLmI0VYZjJV3fePsK+WNnwHMCMYmMQUTq/IglbE3RZtALhCI0+9CY5EWUlgwMHzx96hIasJwQjO10MfzTqsXu6IKD2QEU6XKRqvBB9tQetutBdd8Ip38BxAvO4secXZbh3A40wRZ6y8Ff1ktQmhd38XXXpZjJaGPA1PNA041ZRwOggBOyJHe61bb+LybVTW/6SOoBgCwW1FoHmNX2l8GCfpHZJgH8v4Cg9Zk0gCEPBqSLNvGaqLxEJM=;4:cEvVysHCzlnyBHV7AEusphBCkzC/0+L9ovgEcCuxnHxiU3KHSpiavVaq7Kx8kwFZRZwrBPcnWOATV4gp6MpDeCMo45jgDp3C9G+KpzC2+HOQBLK7ChO9puaNwyzxt+CA2TiHblvVZGSZipiA0OaGUSTJTqRFbCnMU8joBybogVkadPizEzhChFJUdebXUuUHE5JeAsEQNqsnNCDX6+IihsQE460655ImLiKVry2HqAk8icSZwGrBJnOkMbVjnTJFkc9SUTXKOAy8z2joaaluxA==
X-Microsoft-Antispam-PRVS: <DM6PR07MB4924AE69D59E0487C48328DCF95B0@DM6PR07MB4924.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DM6PR07MB4924;BCL:0;PCL:0;RULEID:;SRVR:DM6PR07MB4924;
X-Forefront-PRVS: 0729050452
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(396003)(366004)(346002)(136003)(39860400002)(199004)(189003)(64126003)(446003)(2616005)(8936002)(11346002)(478600001)(72206003)(6486002)(65956001)(8676002)(956004)(476003)(486006)(66066001)(316002)(229853002)(110136005)(65806001)(6246003)(53936002)(58126008)(16576012)(305945005)(97736004)(47776003)(67846002)(68736007)(81166006)(81156014)(4326008)(25786009)(50466002)(106356001)(65826007)(42882007)(5009440100003)(105586002)(2906002)(53546011)(31696002)(386003)(7736002)(76176011)(31686004)(3846002)(6116002)(23676004)(230700001)(36756003)(52146003)(52116002)(2486003)(14444005)(77096007)(6666003)(16526019)(186003)(5660300001)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB4924;H:[10.167.103.249];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTZQUjA3TUI0OTI0OzIzOmNmblhta2hGbXZWU055ZXAwRzdwR0lOWEx2?=
 =?utf-8?B?OE0ydnpiR3pZaGswNVZERzdMQ0hzNlBlUE0vOUpvbzhJY0hiQ0paL2x3cTJR?=
 =?utf-8?B?alhsZStiYTdWVFc3NTg3R2pneXVJdW83MzI5dGs0aExrQmZRRGVZbnYxVE1P?=
 =?utf-8?B?UTlKK25hY3lySFhidVBsdXUxNDVVbUU2NjBkWFh5UVN6M0V4eVBOc0xHY2pB?=
 =?utf-8?B?N1lUenVVZ0IrQ3o0eWRtVDlwOHlrOWc3Y1VHcHpvcjA2aHRoZWhlb01DVitp?=
 =?utf-8?B?ZFF6RDdBdWZvK3lLdGFYT09CRWFEbk9zeFRkVkdrdGdJRjdWazFiS0M3Q2ZR?=
 =?utf-8?B?NVpLQSt3YnA0UWQrbnMxT3pib29mZFhRZDZqVm9DNEpZdm44K1NZa2ovZnB3?=
 =?utf-8?B?UTZ0Z1VWaG9Ub3FsQ25NRFBONEZVN015SGlTWGJYOGVxZ3JCZUQ1blh3ZzI3?=
 =?utf-8?B?dkxMR2dCYUFLWmlXL1VSVk50L0hLOFN0L1RhWGZFbFNKdFFPUlczSTdpUVd5?=
 =?utf-8?B?Z3dxS0c5Z1NENmw0V3pHUy9oQk9UVHU4cFJueS91UlNKMzBkR01ObUtyQ0pt?=
 =?utf-8?B?czhjWUVWRGxrN0lzY05EMDJWRURhZXdjRGJtZEEzcmUrby9hckpHUDZOVDc4?=
 =?utf-8?B?TG44RXFqTld6UnZKbVNnOWt5R3VMMnJMc09qRW1aamVNb0ZyOWJSQVREa2pt?=
 =?utf-8?B?dVNhd2UyTndlNFE1RnE4Y1JlQllrSG9XYnVzbndzT1ZYdlhRZldlcWZycVo4?=
 =?utf-8?B?TVJPUnp4ZDRxRm9YU0VPKytpRStESGpBYk1aWHhxZ0ZVOTUxb3lRRzA4MG4x?=
 =?utf-8?B?cHAxenNsVDdEYlYrYUxFTU5CRUNCOGJOMkJCMEg5dmo5WVdCV29XQkdjZDNS?=
 =?utf-8?B?Y3dvVU8yNHFrclBPWE1TZ0FtRWpSSyt1c0dpcEdsMnEwNDN2Z0JtWVRSQ08r?=
 =?utf-8?B?S1pnTmE2dkZrRVlJUHdZV3RzY2JJeE9wSkFIYTl2N1VhZHNmS1IxWVFYSll3?=
 =?utf-8?B?KzZzSEVEejc0cFJldzZSdmZXR3J0L0JJVVR6SmV6V3JqV1A5ZjBtYnpHZE13?=
 =?utf-8?B?ZmlmWWhuVk5kTWJjMjFmRkFXSWdHV1JnRUdTa3d6U1F4dS9PY0FCVkVXRzhk?=
 =?utf-8?B?TzlpL3RJcHpEWDFiMGdYQnZZUFlaZmpIOEhGOU5tUWIxbiswQnFmendyZzdZ?=
 =?utf-8?B?d3J1NjROYjQ5bmdaMWtYZ0VnNVk3K1ZOb2RRMmlIOFlGR3dGNjFRQlBvZlVM?=
 =?utf-8?B?TTlvaEdrOXZCTnpxVGhJVW1IWXhNSHlDYmczQzAxT05DNG5xL1FmNEwvRFVD?=
 =?utf-8?B?c0EwYnlCK3FQUFIvZVNtWThSSDBIbUt3ZlMwUWVlNUxQamxScC9jdEcxMmV4?=
 =?utf-8?B?bndrVGwzZHI3V1ZJZ0tmb21xeG55aDJVRlJaYTBub3Z0M0hFbTArNUNlMEN1?=
 =?utf-8?B?czhzNnBkb1NsOTdLc3dXMkx0MzdQbXdUMlhYUDRiR1oyWEtOcUV4RWtJWExo?=
 =?utf-8?B?emlUZkQ3Sm5kVkxpb0IzZUdoeEdsbVJ5aDdHVmtqeW9nck40NTdsOVowL1M5?=
 =?utf-8?B?aWpvS3ZSbVdFT0E3dXcrTDNPNFdQb1R6SVU3dVgwM0xrbW40NU1jZW41cFE2?=
 =?utf-8?B?aGY1WmtRV3FycTE4b3NKeGMvVjliR0FSdjljVHFBd1lmUS9LVDFySUh6NGlD?=
 =?utf-8?B?NU54cFZSTmlkdVY3R3Zia0Z6MXVxRzJRK0FuWFIzZzFJdjZjNjUxNXpWdWQw?=
 =?utf-8?B?bFJBTjh3VnhKOGxBMTlFUHgzYTJHVElTMm5VY203bERFblROdDV0OEdMSTRh?=
 =?utf-8?B?WXRJNzJtcy92TEdTZmxpVEhkYXNSMm9aRWtuMlB6Z1c2MFV0ZENiRk1kckd0?=
 =?utf-8?B?dTNrMXl4d1hQNjdQc3ROL29IY0hxc0NBQWhsRFVYYnhqaUQ2SEJsNGsva0NK?=
 =?utf-8?B?ZjUwQ1YyL2pHZk9FS3MzS3h3aHNHdWdKTjA5Tld4b1RDUmRBVVgyMld6NTlM?=
 =?utf-8?B?WUdqMUlKVHJkUitxNkVsOEVGU0p5NEltOVhuVEZtdXhBRWNMVkIraFZDYnlH?=
 =?utf-8?Q?fNNg=3D?=
X-Microsoft-Antispam-Message-Info: dm1An6D4TnXJB42XTv13wjeXs2JXnfjT2WHU1JTDrNGwd0naTfo8trwGcZRMma+usgiIKPcQA02Cq6JRpbXYxJbs03iTOf94AbxfCzZ5fCMHcIpjBZTePTj3SGzrj98uYR4Y1w6AU5AhCOJm6s0yobLS0Rn4IHOV1hS86LquoqmyrbtMJzzrSj2D/mjfK80Tym7HOSJG6bBKu9cgGRoNYhy09ChL2hz5rTZYWDZye674ZiVUg4loZqFkpjs6mKreNuW8Xy1ivu5jbaMzlRYmA2X/8HxhyWL9AB/Ev5Jd6PllZf7n7wrTye0ULluw1dyhzmlDEXjEcwC0lHwd96ZKJK3/SUyIwiLrCezoKajd7vc=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4924;6:YFOw9nzln0kD/u/N88K7l9SvL8Utih1PGxX3iRjkpud4ttAZv3JuhSQxpz8fQGR05hzJVlNJjdE2kVwnEHg+xUvowS888z5UwanYBUvFnOMuDQyTyZKIFtMZy22l/UMAD18LaKZhJhhwUw/9KGmYcu9vVy+sy2VfrNiIIjcwDlhoXphLfOe8tPoEz5X97L0NUbJxlQ8FMT2cBhhVSTF7kKBCB+yDoMtQ321g1PoQk0meZGS0SC5PBZ/1fSyAGQndl8hvpRjzX+G7bkNYjB/8IQ2ZmbcxeqAPgw+Quzr+bfCGXjrpsGFpqqpWeHUn/L9R1Di7nXZtxqjA0y1J9uGl6RtmsmwKp53lc3EH/9Lfp07skuPflOSG1IfnYQt3SUeQKsYseXpMsOlYGgf1HubsgP+z4QqiJrQeEZufJywBIxMzfSscxLIoQMzdsG096CMyUrMrU1KPMDLEv2fRF3Ia4Q==;5:AVFRk27PeEKMMibXo7rDlcoWq9VpdoZouNvxm5id0wQE3zwyh/6oaZ8OqpS7lL6yzzeSPBtL3PY1Wp0KXKr0pLZnjabiMQGi1xFYdb9d/EvfcTQBFnzpan5lAMjtJ/L8PDpQB7TBKjzX0yDkY0UOdP2N7H0jSk3PFbnJNYvo5kI=;24:jx/cBewqP3Y8xa7cA104xbpgyqjrzwVmFHwItbsMUT2ZynTLJLR4ODNZxnj5dFYDusR02kQ+k1ZeR9c4G70aY6MPSM8S9VILfr5Fy9gHcbY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4924;7:8ZuseIrPPFeD/njxM0U7VkIpK5meN8Sj+UM36/CR6tzOYer+O58HxisPegSWcwBHs515YmJnzt2FDdl3F15r1+lDxsGiS7NOYTIF4m/4A4hJstZOU3vfec49JnPU75r4CDNs68PDoOCtBKNl8qgN4H2Te2opmZdP0YuHgQe1Ut+fp4gm5p2SEcIF6GdcoiYsg/FniCjaCRmU/7ekLE8Kl9dWxVeKPjXiNYyGVZRWKZr5xeJSZIyGpjgZeGGJ5QLn
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2018 05:42:26.2850 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9cef927-5fa7-4577-45b1-08d5e627ec2b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4924
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prakash,


On 07/09/2018 10:12 PM, Prakash, Prashanth wrote:
> 
> Hi George,
> 
> 
> On 7/9/2018 4:10 AM, George Cherian wrote:
>> Per Section 8.4.7.1.3 of ACPI 6.2, The platform provides performance
>> feedback via set of performance counters. To determine the actual
>> performance level delivered over time, OSPM may read a set of
>> performance counters from the Reference Performance Counter Register
>> and the Delivered Performance Counter Register.
>>
>> OSPM calculates the delivered performance over a given time period by
>> taking a beginning and ending snapshot of both the reference and
>> delivered performance counters, and calculating:
>>
>> delivered_perf = reference_perf X (delta of delivered_perf counter / delta of reference_perf counter).
>>
>> Implement the above and hook this to the cpufreq->get method.
>>
>> Signed-off-by: George Cherian <george.cherian@cavium.com>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>> ---
>>   drivers/cpufreq/cppc_cpufreq.c | 44 ++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 44 insertions(+)
>>
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index a9d3eec..61132e8 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -296,10 +296,54 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>        return ret;
>>   }
>>
>> +static int cppc_get_rate_from_fbctrs(struct cppc_cpudata *cpu,
>> +                                  struct cppc_perf_fb_ctrs fb_ctrs_t0,
>> +                                  struct cppc_perf_fb_ctrs fb_ctrs_t1)
>> +{
>> +     u64 delta_reference, delta_delivered;
>> +     u64 reference_perf, delivered_perf;
>> +
>> +     reference_perf = fb_ctrs_t0.reference_perf;
>> +
>> +     delta_reference = (u32)fb_ctrs_t1.reference -
>> +                             (u32)fb_ctrs_t0.reference;
>> +     delta_delivered = (u32)fb_ctrs_t1.delivered -
>> +                             (u32)fb_ctrs_t0.delivered;
> Why (u32)? These registers can be 64bits and that's why cppc_perf_fb_ctrs
> have 64b fields for reference and delivered counters.
> 
> Moreover, the integer math is incorrect. You can run into a scenario where
> t1.ref/del < t0.ref/del,  thus setting a negative number to u64! The likelihood
> of this is very high especially when you throw away the higher 32bits.
> 
Because of binary representation, unsigned subtraction will work even if
t1.ref/del < t0.ref/del. So essentially, the code should look like
this,

static inline u64 get_delta(u64 t1, u64 t0)
{
         if (t1 > t0 || t0 > ~(u32)0)
                 return t1 - t0;

         return (u32)t1 - (u32)t0;
}

As a further optimization, I used (u32) since that also works,
as long as the momentary delta at any point is not greater than 2 ^ 32.
I don't foresee any reason for any platform to increment the counters at
an interval greater than 2 ^ 32.

> To keep things simple, do something like below:
> 
> if (t1.reference <= t0.reference || t1.delivered <= t0.delivered) {
>       /* Atleast one of them should have overflowed */
>       return desired_perf;
> }
> else {
>       compute the delivered perf using the counters.
> }

No need to do like this as this is tested and found working across 
counter overruns in our platform.
> 
>> +
>> +     /* Check to avoid divide-by zero */
>> +     if (delta_reference || delta_delivered)
>> +             delivered_perf = (reference_perf * delta_delivered) /
>> +                                     delta_reference;
>> +     else
>> +             delivered_perf = cpu->perf_ctrls.desired_perf;
>> +
>> +     return cppc_cpufreq_perf_to_khz(cpu, delivered_perf);
>> +}
>> +
>> +static unsigned int cppc_cpufreq_get_rate(unsigned int cpunum)
>> +{
>> +     struct cppc_perf_fb_ctrs fb_ctrs_t0 = {0}, fb_ctrs_t1 = {0};
>> +     struct cppc_cpudata *cpu = all_cpu_data[cpunum];
>> +     int ret;
>> +
>> +     ret = cppc_get_perf_ctrs(cpunum, &fb_ctrs_t0);
>> +     if (ret)
>> +             return ret;
>> +
>> +     udelay(2); /* 2usec delay between sampling */
>> +
>> +     ret = cppc_get_perf_ctrs(cpunum, &fb_ctrs_t1);
>> +     if (ret)
>> +             return ret;
>> +
>> +     return cppc_get_rate_from_fbctrs(cpu, fb_ctrs_t0, fb_ctrs_t1);
>> +}
>> +
>>   static struct cpufreq_driver cppc_cpufreq_driver = {
>>        .flags = CPUFREQ_CONST_LOOPS,
>>        .verify = cppc_verify_policy,
>>        .target = cppc_cpufreq_set_target,
>> +     .get = cppc_cpufreq_get_rate,
>>        .init = cppc_cpufreq_cpu_init,
>>        .stop_cpu = cppc_cpufreq_stop_cpu,
>>        .name = "cppc_cpufreq",
> 
