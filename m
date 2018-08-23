Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C627C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 06:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D95A208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 06:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tW+sKyDN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D95A208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbeHWKQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 06:16:13 -0400
Received: from mail-co1nam03on0061.outbound.protection.outlook.com ([104.47.40.61]:20619
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725909AbeHWKQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 06:16:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XoP559X7GInN3tQmF8J3+MfX7t/l87BMt1/gsw3G9AU=;
 b=tW+sKyDNT5eIOsVJf9W5Y2MisA2fgbv3mv2sNxMNvZa5GWkCiPUyI2O06BFDDGiKdyRlBmmP4YffZtx2WbF90o5yD4kAATs1uqhSQD8sNX4WvBJHU6vRjT6bvtFKvMtcewGorBsPZiAhqcHWiS4lrURjdjmirgi3OI9uqQVOxv4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from [IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740]
 (2a02:908:1257:4460:1ab8:55c1:a639:6740) by
 DM5PR12MB1724.namprd12.prod.outlook.com (2603:10b6:3:10f::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.23; Thu, 23 Aug 2018 06:47:59 +0000
Subject: Re: [PATCH 1/1] drm/ttm: Set memory as decrypted for ttm framebuffer
 mappings
To:     Jiandi An <Jiandi.An@amd.com>, dri-devel@lists.freedesktop.org
Cc:     airlied@linux.ie, linux-kernel@vger.kernel.org, ray.huang@amd.com,
        Jerry.Zhang@amd.com
References: <20180822185754.104729-1-jiandi.an@amd.com>
 <d22f2dce-7229-aac8-036b-5312927632e4@gmail.com>
 <2eeaae95-181c-b856-09ae-4ee2423fe3fd@amd.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <92cfac31-a408-210a-d901-1e6511a1cb9a@amd.com>
Date:   Thu, 23 Aug 2018 08:47:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <2eeaae95-181c-b856-09ae-4ee2423fe3fd@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: HE1PR02CA0090.eurprd02.prod.outlook.com
 (2603:10a6:7:29::19) To DM5PR12MB1724.namprd12.prod.outlook.com
 (2603:10b6:3:10f::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 062660e6-fd02-41ee-85be-08d608c45ee4
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1724;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1724;3:B6XmZ1BYoD2JLiIPyigjbxl75URcvHO42rZkJlMEe8rZqY3nFipxB/uheWR7nmuLqgUQdXebXQJF67i57O+NOU6Gt8z2WlXOOHPZtdb6B+HNMQRf2ROgG0COtHAYw+qhu6gnrblGYQmunv+EZD7S9wWLyOQr3k9aIjalZ9jwK2tVBLjDGJLbjgfEvccDonL4N6Q8TH0iZzHZqS/t/D9A3h85YzMEbI9DrLoGTJjDC1tV2OXLhzPx5KCVRscVyuMa;25:oEdQCM0PDcqnvqQ0gy9XP4E8F1icz2chbEy+HK+qiBHhoagF8Yrnb3bcLjdCobZuSoMr8Msy+OIRyTiRzRCZGntvYYLfYaGu5TdvyXp9I4pubsCity3DYcnL3ILi9ci4N7LQpYICAzrAy7DcnC0q7qfeJ+J7+wFPOWHXFHI96e19ongSxi3voxpDqFsjHooFvzTSdS/M551gf78KkwedjMiiuYaMhw60KnlWzVX7vZXKZBwLgNPW+fUwFcoFCc/T2RaWZfbxP4nUKg26P8eJI1T7IE/fSSo0iX+LpZ3g+CUhpffI+FGI/xJ+gEun+jorZRybiJI+kqe94v2HRyQFkg==;31:nXl2SkAzr6zZ+TRXHIsFC752CpHtCB0EdHa5dG+oljGrI4xjGqRTvXKr8j/bJLJlA/m8aDTPl+hGqQetrAl0b31U4Rb/qVJg//piYAwn4xeHKmTMmes2FGVfmfRyl5AzJMdkZnJ7DbtgZ1UbIEHrlJmk9dTfZvH+lZw0pwlV/JGzdQD0RkdxTzfoPULs3hZyKrfKh4+yJ1CfC4nr9X+wn3rtJRgrC7xycIagcaf93rQ=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1724:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1724;20:3Ctppk7pSHa00LEUch21sc8GENV24s1qIcC9+mv2aWPJGlLm0I6loGdA7Q/IXyS4ZtsiUMsXeboj1+xL7dPZxd9udMdLHyIi5Vycklbed3EyfkyNbpUAA2KgGyfMj18ZLKSvhTTLopwgbvFAuoMum3f5JefXk8xn1ENgjxK/rEnxSpkFwbzhPPiXgLHEQSeTAz1zlxqlNOGLIPhEvB1fMtsy7Wei9B2k9+W+scpt6GuEjC0v8ink3/WKRxnF7JWA/T48bhhkutdBFiwCJilxWI4+hPEestOgKdZ7J+tvSmo+kSyVUBP1RHil87LG6EhHH/r9as1w4SEhN5FqzzqaQRSz1v/vEF8iKatuLps+TA3bUf4s0qiiOjpYlEupAkhU38sgqTKjDUMpFJxjr4TwF4+ewn2ljACwAIZgb0peqsTAbbpesT53/+srXCNEvXntRhRbYNoRiUAQT1z6TwUe2iLXYq/NINebMwaR5ETQJ0IufT8Nt+xQgRhjknN2MIOO;4:6n41gpkYM49WO0QvCvZF/jE9UnVuVTwVlpMLedfGP+y54cl0N7AJsu0w0SvQntPMeaYdBI5SKbyCj0KnbTSPv0+GK/+j8DxIA/fTzUXuJ9yPruSmR+4C3k8lc4rRXtEVUEaiovQ9qB35xHk0x/DkPjXlk2ZdIMDWMZI6XNLcB7C4CTyNPts8Xx1jYZ/xq/9Qt0EHE4IYkUH+4dqep9duva0zfJFP8jXX6gNdwHyL0NjcECqnlt6txVnIUfE76LxIB6cfmWKsgr5bBX1jcXyY/6mPtHh2D3j04s4zhW/FtkMzOejzl91ASONagGf0rnN3
X-Microsoft-Antispam-PRVS: <DM5PR12MB17249D6DBCA5C2CA8540370A83370@DM5PR12MB1724.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:DM5PR12MB1724;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1724;
X-Forefront-PRVS: 0773BB46AC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(376002)(346002)(396003)(43544003)(189003)(199004)(4326008)(5024004)(65826007)(50466002)(31686004)(8676002)(14444005)(476003)(5660300001)(6246003)(486006)(2616005)(2870700001)(68736007)(229853002)(25786009)(106356001)(6666003)(67846002)(305945005)(65806001)(31696002)(1706002)(2906002)(86362001)(65956001)(6116002)(76176011)(46003)(53936002)(52146003)(52116002)(2486003)(386003)(58126008)(6486002)(316002)(446003)(53546011)(97736004)(7736002)(47776003)(72206003)(81156014)(36756003)(16526019)(8936002)(81166006)(64126003)(105586002)(478600001)(52396003)(23676004)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1724;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIxNzI0OzIzOm80VG1HYXF4UjVIZ0FFMFljSGFBa0pmbDFL?=
 =?utf-8?B?S0FkVWhvc0pneDdubkZ6VnphWnFFRmdIZEhkS2IwTHNIaWg3VE9QaXMvZGt1?=
 =?utf-8?B?d0RhdFNRNXJSSjRTSlcvOVNpMUtFR2lJT2V5cjliRys1U05iOHVEYms3Q0xG?=
 =?utf-8?B?MElwOWRTQmI4RmgvdFVKOU9DSW9HeERteVJEVlpsM044aFJBM0tmYXBpWG15?=
 =?utf-8?B?WWREeXdvdzg5dWo3MmhmWXVYZElYc0w1Y3BVYnpFVUlad29Gd3ZBZnQyYThO?=
 =?utf-8?B?Vjdtd0ZBMVFlSjM0RHIzK3NmQkFEV2RDcTNBOGhVZ3N5N0QxcTRVT2pnWm1a?=
 =?utf-8?B?VXM4Q3YzV04rWEYwMkpUaUpsY1RvWE4wMkVNRW9QNkx1YTdOM3NydGdqcWJN?=
 =?utf-8?B?OUtxZWM2Zmw5U3lWbU56b2hBUEF1ZlRFa3AxZHlMbnM3ankwb3RpQ2JBSmE2?=
 =?utf-8?B?Z1NQckJlQVlsL2JHOWpPUDZqY2lPSFdPeWN6cmpWeUVrbTNhWEFUcDVrOGxn?=
 =?utf-8?B?d3d1b3Z3ajlQUHlkNWttQ3pHSkpJYTZWVXVKZkc4N0Z6LzB1c0pwcGtmYXZT?=
 =?utf-8?B?VWpCUHNicVE3Y3crL2lHeEJzOUkvRUVVUktlbXpveS8vL0h2eWgyazJSN0Zl?=
 =?utf-8?B?OGRyaWl0ckpoaDNtZ1grUHlvTWM2NzIxcmxjZERwRXhoS1IveFVBN3QrY2tq?=
 =?utf-8?B?MlVlcWluTWN0bE8rMFFPR1IxcmFtbXZXVlhKQi9kV2hlVE5GQUh6WE05MExs?=
 =?utf-8?B?WlZYdy9FbkRFRktLMFkycjIralBhdWZ4VkdrakI4azZDVjhYaUJNRi9oQXA4?=
 =?utf-8?B?eUU5c2ZlWXdmdmZxaDhBMUV6b0U5OUdyWGdiVzVvNXRhT0Fac0FUVEMvZFVD?=
 =?utf-8?B?Z0ZGdHh4WjR0bVRIalZ4SWNwUDdXMWRLWEl5UHlnOHpKZWVRc2NEZlFSS3pv?=
 =?utf-8?B?QXBQRFk1TDVUYTFHa1NFdzRILzJqTTZLUXUxUDFmdzFncXFqNFZvVlE4enEw?=
 =?utf-8?B?L2NTS0llaXgwYzdIK3gzZ1BRdm1CdzljZjBaWTJKMUFEWHMrTU9qbmlCMVo2?=
 =?utf-8?B?anJsWU5nRGNDTThMREVvRC9oMjJicm11NW5TS0t1R0htdGxNTzJqb00xd3pp?=
 =?utf-8?B?UmI4SE9pU1d2L2hoZDRNbDh0WjhqWnhSV3hGSS9vK3VBcTNNN1VvaXF6RVE4?=
 =?utf-8?B?NGJhY3hkT2tuV2FteVU2dGVldXh6YUFsSDRmdTFqY09oOWVOS1NycEh2akFX?=
 =?utf-8?B?NDEyTFdSZGpxdU1sbW9UMFlkRVZlVHdsb2h6RjdsUlczMDIyaisza0VWUHQz?=
 =?utf-8?B?VmZWcjRvNHhoa1l2VklvL3Blakc2ay81a2pXQi80dWN4VmF6aVp4WEswcXA3?=
 =?utf-8?B?bkdYaG04bWwvL2RZejlna1h3LytoM2M5TWFxS3BWUzZQWlBsOHFSRXZBdGJt?=
 =?utf-8?B?ZWtHb21iaDVVWWRTM0JZekdpdHcrRzNuQ2JoaU9WbGc3L2F5ZG9kT3pPZ0pi?=
 =?utf-8?B?RVYzd015QnlCWXJid2dqMWlYMW9COTY3NXJBVmVtRUVqSTNzWEZGaERFOUhM?=
 =?utf-8?B?YzZYOGt0aHVWelo2U29Nd0hjem5QSFdtODEwbVY2TVFlbE43bHJoVm8xTm1v?=
 =?utf-8?B?UFR4MGVGU3IwOEhJVDVtdFB4N04rRTJoUm9jSEN5SE1iUjJMRXpPRnY1TUp5?=
 =?utf-8?B?NGxnOUw4UXFzNlFoWUhKZllEc0JoaHZaREVHTlpIQlZiK0JOK1NMVFpwZFVZ?=
 =?utf-8?B?TWYvZzNSQ01GaFJPeTZRdFM1ZnVCQnJDaVdFU0dwdkV4MTVzU0gyek9hdlE1?=
 =?utf-8?B?SVRpWXAycHp4VXlCSzZqRy9nbzZCbGJmMXM2L1paWDJHdENoZjBEL0FiUFBJ?=
 =?utf-8?Q?jkAqNXREQLI5lc774DIgS52E3y8uGYxP?=
X-Microsoft-Antispam-Message-Info: xWQiO4i61NIWPLF/+G0Nv0P3K0LLsLj6Sf7Pg1ps0dF8O+NBH8WXpo8vojuzVaOhXYGRk4EfKlNRGRDf7HkHvHGOzyAsOs49RU2RVovHYM980fhtgQ9gQ0Op630y+Xj+0L1eltSHERWx0gWMjTJqodc3ly/sk9NBTs5kZY2ZJFQccnHJqxbEYyrNhby96uUwJiVhxluJ7JAmrMFzQP7j0H0tknXLVXzusjz6j2JGPvEDR9kMSj0NKgfdFz92byBIN6S1pPG5IW3tuvfjj0d+bP3Dxu24A/pXCU1y45D0eiXr5N0LaHV88WIGFOa5Se9Zvxi2VV3g9c/QNavwdYyvpNMRGIMykyXL1ki++o9gujQ=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1724;6:tFQ0QdP5tr+Nmsk+hXL6XueoCOf3H+3Bs7OTA86/Vlwlm+BbAolnmrEqhNYoHHyyurR5LIPrcqjEUUSdv9jjBP9CtsWC1UdJEr938fgzZmUBXCGU+aBm6Qlfm9wIx3rmv1HnncU02wuav4vqNgbZ8ORLvR+YRM1Nohu3Kh8/gXNeNC3mcvQJEJz3mln0B6f5ocm0UZZrCPsIOjejowGjzjpoNW5NAjIy2eRFLPTh2D3gQE8T8sRDqPJzWrIQ1SQrRGqQKNuME+OHh6PTR3TNkSyOYwqoGqMiEBz09u8t+qhMFyVyxXxPN7RQMM64RXmmId+pyVM5x8xOMPHhrOiXC+VWpljZTpM4gzXxDgXadq6m5tsiNOyQjggW9kmvpCRn1q2xJgHAD1BhobjV0ILpFYzw1qS9zlv72zHMdPL3I7mZpphiT8Ai8mEXj1S9DMrdcGcrGlJuxf/NbbwI07BQlQ==;5:mXmX0tfzIJVXxbEW6/b6A06YYzdTCIt8TmcYec6ZYOn58fPXDsLI6hrSTnygkLRL4bIubWJ1YcafcskzD2o3Ihzm/r8KVtLFk1llvBF3f2CE/uMXewqksual74nnat6vIk5BPU7uNHMAAcuVOQDM1Xf21ot37EZ9ZCY45rdRqvA=;7:zsQFK3OCSEd1mgeWFj92h3qw17izF1YNOGdBmXHqYO4l44PbgmcNhlMaGpWqnLc6Zfs+uno7W7FmBzmJkfJOZ99AyayX80JRqLPCTOdQLdrrigusH34LNGX06EpojVj46Lk2+buAQeYTwZcGo9RfEwMDIT1Ea2r2sljCXs4gZJLl5OHfn5XpvnWFVg0ZahULoYtuWtvAUGISsLGyh67K4pHlpK2j8w8m4S3sivhDx2guijTivHbnZH4gUgaaOapP
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1724;20:x4ZZ1FoaPhBkmxNkJSemoMCANEOAVS5lypIvgZbbW51Ul90W59y6fzdHZ0INmLhFeRIJ4cNE9SstDvSyXLjTbDf7bcsgkZvU1dm2qiEft02lLhGyIj0FjGNWX6osVdpMJSlLOcvkjQzcs/DDkG6PazTqyNgyjTYyCf18eiTL/CdM3sDCl8m9GLqhB55AEFodW5oPVejrQxLJjXfVcBP5DFEIaSOsl2W4zIOogwGKuHgvoV7tEfJs3Bjq8z0tusgU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2018 06:47:59.7463 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 062660e6-fd02-41ee-85be-08d608c45ee4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1724
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 22.08.2018 um 22:57 schrieb Jiandi An:
>
> On 08/22/2018 02:09 PM, Christian König wrote:
>> Am 22.08.2018 um 20:57 schrieb Jiandi An:
>>> Framebuffer memory needs to be accessed decrypted.  Ensure the
>>> memory encryption mask is not set for the ttm framebuffer mappings.
>> NAK, the memory not only needs to be decrypted while CPU accessed but all the time.
>>
>> ttm_page_alloc.c and ttm_page_alloc_dma.c should already take care of that while mapping the pages.
>>
>> Regards,
>> Christian.
>>
> The path where the issue comes in is booting guest with AMD SEV enabled while using virtio-vga device.
> The ttm->pages doesn't go through ttm_populate_and_map_pages().

And that is the point where you need to jump in and fix the problem.

When a driver implements the populate() and unpopulate() callbacks 
themselves it needs to take care of all that handling.

>
> In the kernel path, the virtio_gpu driver calls virtio_gpu_alloc_object() and goes down to ttm to
> allocate pages in ttm_pool_populate().  Driver in guest then does virtio_gpu_vmap_fb() which goes
> down to ttm_bo_kmap_ttm() and does a vmap() for GVA to GPA for those pages.  If SEV is enabled,
> decryption should be set in this GVA to GPA mapping.

That assumption is what is incorrect here.

TTM can't work with encrypted pages, so you need to set the pages as 
decrypted directly after calling ttm_pool_populate().

And obviously set it to encrypted again before calling 
ttm_pool_unpopulate().

Probably best if we add that to ttm_tt_populate()/ttm_tt_unpopulate().

Regards,
Christian.

>    Guest then sends object attach command to host
> via virtio_gpu_object_attach() which stuffs the pages' physical addresses (guest physical address)
> in a scatter list and send them to host QEMU. Host QEMU maps those guest pages GPA to HPA and access
> via HVA while guest write stuff in those pages via GVA.
>
> virtio_gpu_alloc_object()
>     virtio_gpu_object_create()
>        sturct virtio_gpu_object bo kzalloc()
>           ttm_bo_init()
>           ...
>              ttm_tt_create()
>                 bo->ttm = bdev->driver->ttm_tt_create()
>                     virtio_gpu_ttm_tt_create()
>                     ...
>                        ttm_tt_populate()
>                           ttm_pool_populate()
>                              ttm_get_pages(ttm->pages, ttm->num_pages)
>
> virtio_gpu_vmap_fb()
>     virtio_gpu_object_kmap(obj, NULL)
>        ttm_bo_kmap
>           ttm_mem_io_reserve()
>              ttm_bo_kmap_ttm()
>                 vmap()
>              struct virtio_gpu_object bo->vmap = ttm_kmap_obj_virtual(&bo->kmap, &is_iomem);
>
>
> virtio_gpu_object_attach() <<== Sending attach backing command
>     virtio_gpu_object_get_sg_table()
>        if (bo->tbo.ttm->state == tt_unpopulated)
>           virtio_gpu_object  bo.ttm->bdev->driver->ttm_tt_populate(bo->tbo.ttm, &ctx);
>              bo->pages = kmalloc(sizeof(struct sg_table), GFP_KERNEL);
>              sg_alloc_table_from_pages(bo->tbo.ttm->pages)  //Getfrom ttm->pages and put in sg
>                 __sg_alloc_table_from_pages()
>
>
> There is a separate userspace path for example when displace manager kicks in,
> virtio_gpu_alloc_object() followed by virtio_gpu_object_attach() are called through
> the ioctl virtio_gpu_resource_create_ioctl().  The mapping of the pages created in this
> page are handled in the do_page_fault() path in ttm_bo_vm_ops's ttm_bo_vm_fault() handler.
>
> do_page_fault()
>     handle_mm_fault()
>        __do_page_fault()
>           ttm_bo_vm_fault()
>              ttm_bo_reserve()
>                 __ttm_bo_reserve()
>
>              ttm_mem_io_reserve_vm()
>                 ttm_mem_io_reserve()
>                    bdev->driver->io_mem_reserve()
>                       virtio_gpu_ttm_io_mem_reserve()
>                          mem->bus.is_iomem = false
>                          mem->mem_type == TTM_PL_TT
>
>
> I originally handled setting pages decrypted for the kernel path for GVA to GPA mapping in guest
> in virtio_gpu_vmap_fb() at the virtio_gpu driver layer.  But for the user space path
> virtio_gpu_vmap_fb() is not called.  Mapping is handled in the page_fault handler.  So I moved it
> to the ttm layer.
>
> What layer do you recommend as more appropriate to handle setting memory decrypted for GVA to GPA
> mapping for thos ttm->pages?
>
> Thanks
> Jiandi
>
>>> Signed-off-by: Jiandi An <jiandi.an@amd.com>
>>> ---
>>>    drivers/gpu/drm/ttm/ttm_bo_util.c | 12 +++++++++++-
>>>    drivers/gpu/drm/ttm/ttm_bo_vm.c   |  6 ++++--
>>>    2 files changed, 15 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
>>> index 046a6dda690a..b3f5d26f571e 100644
>>> --- a/drivers/gpu/drm/ttm/ttm_bo_util.c
>>> +++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
>>> @@ -29,6 +29,7 @@
>>>     * Authors: Thomas Hellstrom <thellstrom-at-vmware-dot-com>
>>>     */
>>>    +#include <asm/set_memory.h>
>>>    #include <drm/ttm/ttm_bo_driver.h>
>>>    #include <drm/ttm/ttm_placement.h>
>>>    #include <drm/drm_vma_manager.h>
>>> @@ -639,7 +640,11 @@ int ttm_bo_kmap(struct ttm_buffer_object *bo,
>>>        if (ret)
>>>            return ret;
>>>        if (!bo->mem.bus.is_iomem) {
>>> -        return ttm_bo_kmap_ttm(bo, start_page, num_pages, map);
>>> +        ret = ttm_bo_kmap_ttm(bo, start_page, num_pages, map);
>>> +        if (!ret && sev_active())
>>> +            set_memory_decrypted((unsigned long) map->virtual,
>>> +                         num_pages);
>>> +        return ret;
>>>        } else {
>>>            offset = start_page << PAGE_SHIFT;
>>>            size = num_pages << PAGE_SHIFT;
>>> @@ -661,9 +666,14 @@ void ttm_bo_kunmap(struct ttm_bo_kmap_obj *map)
>>>            iounmap(map->virtual);
>>>            break;
>>>        case ttm_bo_map_vmap:
>>> +        if (sev_active())
>>> +            set_memory_encrypted((unsigned long) map->virtual,
>>> +                         bo->num_pages);
>>>            vunmap(map->virtual);
>>>            break;
>>>        case ttm_bo_map_kmap:
>>> +        if (sev_active())
>>> +            set_memory_encrypted((unsigned long) map->virtual, 1);
>>>            kunmap(map->page);
>>>            break;
>>>        case ttm_bo_map_premapped:
>>> diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
>>> index 6fe91c1b692d..211d3549fd9f 100644
>>> --- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
>>> +++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
>>> @@ -249,10 +249,12 @@ static vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf)
>>>         * Speculatively prefault a number of pages. Only error on
>>>         * first page.
>>>         */
>>> +
>>> +    /* Mark framebuffer pages decrypted */
>>> +    cvma.vm_page_prot = pgprot_decrypted(cvma.vm_page_prot);
>>> +
>>>        for (i = 0; i < TTM_BO_VM_NUM_PREFAULT; ++i) {
>>>            if (bo->mem.bus.is_iomem) {
>>> -            /* Iomem should not be marked encrypted */
>>> -            cvma.vm_page_prot = pgprot_decrypted(cvma.vm_page_prot);
>>>                pfn = ttm_bo_io_mem_pfn(bo, page_offset);
>>>            } else {
>>>                page = ttm->pages[page_offset];

