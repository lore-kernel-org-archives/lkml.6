Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755997AbeDYRSv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 13:18:51 -0400
Received: from mail-by2nam01on0080.outbound.protection.outlook.com ([104.47.34.80]:3611
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755218AbeDYRRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 13:17:48 -0400
Subject: Re: [PATCH 3/3] drm/amdgpu: Switch to interrupted wait to recover
 from ring hang.
To: "Eric W. Biederman" <ebiederm@xmission.com>,
        "Panariti, David" <David.Panariti@amd.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
 <1524583836-12130-4-git-send-email-andrey.grodzovsky@amd.com>
 <DM5PR12MB244017F98FC732EB5DD86E0395880@DM5PR12MB2440.namprd12.prod.outlook.com>
 <b4309ea4-c1a0-5811-040b-4390ce6f297f@amd.com>
 <DM5PR12MB24408FF7C780D95307FB2BAD95880@DM5PR12MB2440.namprd12.prod.outlook.com>
 <87bme8bm9g.fsf@xmission.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <d5a1b82b-a9c2-e6e8-1957-aab8acac242c@amd.com>
Date: Wed, 25 Apr 2018 13:17:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <87bme8bm9g.fsf@xmission.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YQBPR0101CA0050.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::27) To BN6PR1201MB0113.namprd12.prod.outlook.com
 (2603:10b6:405:55::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR1201MB0113;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR1201MB0113;3:JFf1IWBIcDe2Ejr3QrtiRZJmes8fw7a3yMPl5O6zCMGuCG1wy1fG1SmCPO7gHcuGVwPcZNlPdq1hX6s2rXaRqmwkWlZ99N4GotPKFB6tOiVpNC4JRLwdxWC5KSd8/PUR522xJ8iFbbS/VQtwjWZRvGb7UvST3o5txz+9uj2JzsFRyjOg3ixL+S4jecDLoKVAgLEy19pdSKoE7qLvzdNg+82rH93T65SptuDBfQdMl8rtxrUbnTCdsS+ihYhsMxPV;25:FIM3Y8w3LRNbm4LfdenyeTsvIdU2RODetSdtjXStnypnsoW65d4Kt8H7yc5Gr5PWXd9Ba0R8bWDHlTHOzX3NJ2MBjS37alBfMkQRsYKumNXBwDB7SRdoyindkvwGAuOF84QDER9R6g5N9i/eFtILEJKG4LAErIP2Vmetgs8MqP7cH7QXqaq03W+MRqvTurQX6OAEHeAptV9Bir92M2JsikdBLMjaQIYPu5PFy2d8pHpKCk/EnBIlhjrtjnaP684bIXzkrm+XK29KGcwnTkaamgIOhL2pu0D/9T8V4c+nXtSIgc30c2RlrpvMDjHSWuDQNL7v/v4soNwSQuipIgHmHg==;31:NUY5NBGgjGtt9G6y2Vi1/uXGa9ikiXaqBMHU2dsZvs2BdN+ynQzncIx83IxqQs6k6tWFBKmwAQyoai0A0nFQYpZDmNLtAs75hwL9DCUCsJlO03iE7u0V6CEixvvo+r6K8FTP+odAGT7E2ffh1v4RABw9zFjp8DgqfnwF21G3IyN7+ksmacyNKv144/ZIvG0QA+UDFPwQp0CCQF2fJ2HA6IS3LuRpR2qvJrxM3OfL9dc=
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0113:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR1201MB0113;20:iJHi7H5BzvLJLgNueqGibGn0j9NKUMdGDHOIv6LKZhS03vJAREVWWiUvGf36eBM0XdK7tOWT4wCc8WbeiWwqFz0CRBzSpVPw+qFkHWQTEBYZaYqGoauHRI2gq4flkWS/ymM73Mj5v+I/NP+6FrKbJDkyrLC96t/GESDtNhSa5TpfORLSGgxl5yN0VQz8RwtjmhmGwuzrEY8f1Lbnt0d40+iCJHq9c7kFkANvcJVDh47X4p+uPExV98w0f620cR2/Nfrt54rlYnmhHwDsMVqtlB5v0db1z+guiS//Lgyf9e7YxBwcOM8gdmFz35+szWu1Elt1llu4yqGRBnthk+V+IfJuhWrg+wTHGchxY4ZmJ3wliUVhEStDvLtROrFXByWLhkh3657Jskc4IGEHgmJ2ZoVaXylvBK8Ssj0YswXgCU9sp/AUaYwoFETT3zhpmSm2PqS74bbLTUyngXsLiBhCllZFQ89lfjz9tGD9Cg0Vpv+vfzD4YUQwy/geOV3VaE/G;4:R64hVBps4nU6P3w9z08f6nUcBUCoMOKeirKTtuAnaypMD5yIv/zKb3z3IgiMaLHJ6G9ds1+27WKGDWwlrQqy+MlzRRV1fsGP6JM8PlL73tW57XSbvC6bihYuLzRRe807+Dqtjw17HQhE3mnUHO7bIneOy5FB1/XBvucU3rYnSgf/qrrHKQVuQh5c3K1t63Xx6nPviSK+SSXQI5Hm7rXOOlN5RcpVkAIUvtn+hV3S9sGcT86j34X5TRMJAnzcW2beQc+alUNtxgn4njEWysVMOgJ2sLmeYQipEvdGC6F3BBOzqpVBre27TJfZViHg0Bpm
X-Microsoft-Antispam-PRVS: <BN6PR1201MB01131B858BBFA1EDC0EB52F3EA8F0@BN6PR1201MB0113.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231232)(944501410)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:BN6PR1201MB0113;BCL:0;PCL:0;RULEID:;SRVR:BN6PR1201MB0113;
X-Forefront-PRVS: 06530126A4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(39860400002)(346002)(39380400002)(396003)(366004)(189003)(199004)(67846002)(58126008)(50466002)(53936002)(316002)(6246003)(16576012)(8936002)(106356001)(77096007)(26005)(59450400001)(93886005)(386003)(4326008)(97736004)(53546011)(105586002)(2906002)(230700001)(31686004)(64126003)(486006)(81156014)(52116002)(110136005)(2486003)(86362001)(23676004)(25786009)(31696002)(76176011)(6636002)(476003)(6666003)(47776003)(36756003)(6116002)(3846002)(52146003)(5660300001)(72206003)(7736002)(956004)(16526019)(446003)(186003)(68736007)(65956001)(6486002)(65826007)(478600001)(229853002)(8676002)(81166006)(2616005)(66066001)(65806001)(305945005)(11346002)(54906003)(21314002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR1201MB0113;H:[172.27.230.118];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjEyMDFNQjAxMTM7MjM6QWtPUDd1MVJzMEUxSE9ZUFJLbmJ3dktp?=
 =?utf-8?B?b1kralkyWk9aK2c5R3BpSGhxNGhMQVJHSW9hS3VWa2VLaUhmSGZ5NXRlUnB4?=
 =?utf-8?B?RTlPbnFmbHc1M2c2VU1LTUQyTXlOT25NTi82VDZlOCtJNHhFcHg0bG1zU0lN?=
 =?utf-8?B?NWVzQUFqblgzZHJpTitWMjBSaWJNR0pUZXBtZVgvL3Q0QWlVYzFaTGpzR1VK?=
 =?utf-8?B?a2YrbStXUnRpdVdHTlorK2RjdU5GMUtFb3VJcW9rNEtSWlJoSG5FMzZWM1ZM?=
 =?utf-8?B?TjVKRnloK0VVSWhUTjdhL2huRk9tbmJ1U3ljWGk4eEQ1bkxSeGNVWUxxaGZS?=
 =?utf-8?B?bzhaQkJLMDdYdVhHQWpSUUszcDZKQS9YcEdVMzNMbHd5bXBVSjYxdTBrazBk?=
 =?utf-8?B?SHVYdWxHMExZL1I4WG1QTnlYOGEyczFya2tocWNvUHdseEFlczlUVWdXQ0Zw?=
 =?utf-8?B?dnN6SGNySUNWWmk0TmNsRjZPdWtoWnd5ODhBendtNHVVcVRRMEVLSzhYVC9z?=
 =?utf-8?B?MEg4TVlkWkxRcjVRRUxDUXVqbEFQVnFaZzAxYWdqM29vZXZtTTh2WVFlSWdF?=
 =?utf-8?B?OHlMQklBK1VteS90RDdKakhpU1lrMGtvWWIybWk2VjVnSHFTVVlUYm53VXQz?=
 =?utf-8?B?cjBpQ05VRGZqNE9ISDRzVEZyTlozMGNWSFN0SDBzOVJyZDNoT1BYZWtqZHFQ?=
 =?utf-8?B?cDR6dHg3SXN6R0lETkI2VzV6V3h1aXM5dU5BU1dJUG90ZmszdGZxQUVjUU1B?=
 =?utf-8?B?RHMrSUlLQmxsWXdwV3kzOVNHcEZQMnJ1QkFEZjlwcU5mODJydDJzSWw2eXBp?=
 =?utf-8?B?NlJZTlNack1RMlg4azFQRE1WOHpkQk4xamJsSzJyOVZRZFBubEJhTzhDV2ly?=
 =?utf-8?B?QVNHSlorZmpZNVpBZ3N6ditIbUpqQjByTzVKV0dFQUhzNEh1K0RwSndBWlZ3?=
 =?utf-8?B?T2NDR3BnaVpmTTIrZ1k0U3RFU1BqU0NRYTBYY3N5L0VIL1huM3FQQVZ3NTRa?=
 =?utf-8?B?VCtvTDdJc0s1czJ3V0dWaEI3d0ZFUEhwemp4V2FPa2JSc0lvazZvUU4xSVps?=
 =?utf-8?B?WkgrRHk2VXdKVWJKb2szMHlUR3BLTHhNdkU0Ym9mY1RaRXBxSFhIcWpKQ1lI?=
 =?utf-8?B?ZWZOeGpkSVRjYXhheVZsbkxrcm9tdnlsQkhITkZ0QnYrTHErRjNKTFJFZW5Y?=
 =?utf-8?B?aVRaOXRzRE82eWwwYWZYUzBIdnFXZGZlcldSRGd4ZXZCWmFkbklybUxSckFG?=
 =?utf-8?B?b0xxM2ZBSjNJQUJVWkNKMFZFcFdSYkQ3M1FPL1pNVWdDdzUwWDh0N1BJenY2?=
 =?utf-8?B?Z1pqSExNaWpyd2JRc2xVUFdYSkhRR0VuT0F1RjZ0S0g3dzVTcDdIaXU2ZThl?=
 =?utf-8?B?M0puSzYwNjhUQjh5WjNwaEFXNXI3VDJhZURRNFB4cnNqUUtqMy9Dd3JMY3BV?=
 =?utf-8?B?T1VLR2ZRRGZHTlNsVkhEM1Q0OTYrcHVGNVJBOEZPYmpiemQxRkFIU0tNQVUz?=
 =?utf-8?B?YXFsSDhDK3NYNUUzYmZmNFo0MmFJTnBKZVcrRjFQL2V0ODJoeGZWU1g5dEQz?=
 =?utf-8?B?dkRzKzFpRURKbWhoVS9rMWJROTIzSFhWKzVXOXVQY1JyaDdSa05ta0tqY0R0?=
 =?utf-8?B?bHVlTHZONkpQTHg2a3NmS2VJRHU0SlFKMVpUbjlvMFBydEFkZHlLVVhydnBX?=
 =?utf-8?B?QzBacEV6Q0huQlBXc045SXVHVzUzVFZsdVhrb0JkMWJoMTV5S1lFaVNNejBu?=
 =?utf-8?B?VE5EZk5zbFl4MGdORmxUQmRVOGNtZ3pvVHdhek85UDNxdnNQUk41ZFdTNjRC?=
 =?utf-8?B?ejNJNUp2MFdWbjQ3WnN3ZjNlSmNSWFJ0ald0YW11NWFPME1Pd0pneEJONHRB?=
 =?utf-8?B?b0tGOWV6NlZJTEc0OENqd0RWOHplTU1nRDNObndraEF2QkxpU0l2blBWa09x?=
 =?utf-8?B?Qnp6VHRDZ2N2QUNXalNtKzZEY0UwQ25ITnNFTEQvRCtLVGNuWU1HR255aURF?=
 =?utf-8?B?SUEwTHJGNngrcHRCVlN4cERjOHJnRnVNQkRienNiVlF0V25wVUUyZnhPYURB?=
 =?utf-8?B?MWtNdjdFVEoreWJLdE50Z1luRFhGMmhCNVRYQkkzSXM1SjdmdkhHWCtNaVAr?=
 =?utf-8?Q?qmu4lIKYUA/mg/DAAwB322twg=3D?=
X-Microsoft-Antispam-Message-Info: Ablan6Z1wK9BBT+wjS8B6MfEfqgN0UFoU55763N6BB/OyQY4dUyTQLX+QNe9YVOlXUiON5cN796TtfIe3LJLexxjwBkCrIYj+bDcZo+9iow8kvOaJNCSyvJFUG7k9uHr7akISaSHuf1pVD6BIEvrNgjeSCm3WV9S6lIoMZtk53iT6U2oh6Js1sl+7sdcB6qv
X-Microsoft-Exchange-Diagnostics: 1;BN6PR1201MB0113;6:DLtMmDC7KLzSQ0GSP2drFlB5JMdblwWNU3SL2bUZR2QJmATk8WpQuwdvVbliVl6xh7aNBrqUU/pYu0E0gipm63mMktz3uuKAzorHL+pz1H5NY8Qn8WnBmGeNFupAooQWLmk1ccWNvMfzOxpSqzXraLnNyOVHIxc8rH+mLr3T9RfTKkynrseaa1uMDEhUxKgayq0D+h/lKVKgE4z+Fm73AXygXvypyuHi+h0ohX9MlCAh4hEH0XHQpZLmy6XSmL4tNoP6xftAcEOC5bwa8RMJ3MRXKVnk6t+vzRMrNFWLpkh2bdMWkNYF8Iyaq5+sQWxBSPejv987XNjB1N1jkHZeSU91YgTmgEWK70kN2lZC5gIMN7ANCWXF67iZQ8Cj9vAJKJwpAnptLVLOaGv3MZNFasjaYqs6l/K2vdw0EkJB793mR2ZrSKHpF6LtYSmTBEO9uijPBvN4Wy+cRvU8HVoI5A==;5:m4EL2Bxo0cS455TH8WNf2uVVQh/ZtjkxGs7tXvjktWJsAB7Iu/FFBEOlLu5Y6nTu4M/BNlLxYsK3yhnmy1FRdZeTWJgYrKJERoTBs2fiFgGQSpIDc5ztWC341rSNlSk2Bf4iFgVeycswm2PYKJut9Qn8BDWNcdMhDqGdu2MoUVo=;24:YSVjAWhRJpM9VVfV3WaJPTFRpdi/u2BMII7dasWXAgkDuD7WTAXaOcGfq4v3jrv8XCaUVrnznbWUiciV8OPJEpGI5RfdUtM2SlIG5WRlCt8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR1201MB0113;7:Jn2URNavGmPa3JKDFEpWO7P9hYSXWFfbN3dyOuU2ZyoMF9E7bcQtjSVD83kpxB+iZBlyo0DLIaX6c9wuN2rwwDGzIjtIUswK8h4UdP6f751RIW3xaI0BoZzpjPk3aEW7oV/ayPSZJfICKH4hjcGsdxpLKKmmnSPiIgBXS9m/dHO0gTGV01lBYMfXt443r7inqbE9VxWpvtfQYTYWnI7wmfxEUlN/wKkcFvJdhX+66zFl35PeS4KKWUGL8qrE9mj+;20:7+wdYsQ9nSGZ/V7aJxTrCj3h8jfexaIUrAcJRDi03mRQS/M9rMYOkqfkDEJYQcvMHoocOFpYXxeewbYL9LS7XLyzxShPpEK5p8uJOng5Xftj5WjLL3VYME+2T/eiXsD/RjgwF/iaaL1T6eaYKls0pr5S7O+DvZ9ojl2Zj8A5IhMUzuolqeZ51it54Z59ancovC1M7R7Iycg1wiq20wCT+snsQ2Ut/70BH+9vEzsTv0w99WnD1ig7E1groRxbj+ua
X-MS-Office365-Filtering-Correlation-Id: eeb852a9-6986-4eb6-0662-08d5aad07608
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2018 17:17:44.6700 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eeb852a9-6986-4eb6-0662-08d5aad07608
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0113
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/24/2018 12:30 PM, Eric W. Biederman wrote:
> "Panariti, David" <David.Panariti@amd.com> writes:
>
>> Andrey Grodzovsky <andrey.grodzovsky@amd.com> writes:
>>> Kind of dma_fence_wait_killable, except that we don't have such API
>>> (maybe worth adding ?)
>> Depends on how many places it would be called, or think it might be called.  Can always factor on the 2nd time it's needed.
>> Factoring, IMO, rarely hurts.  The factored function can easily be visited using `M-.' ;->
>>
>> Also, if the wait could be very long, would a log message, something like "xxx has run for Y seconds."  help?
>> I personally hate hanging w/no info.
> Ugh.  This loop appears susceptible to loosing wake ups.  There are
> races between when a wake-up happens, when we clear the sleeping state,
> and when we test the stat to see if we should stat awake.  So yes
> implementing a dma_fence_wait_killable that handles of all that
> correctly sounds like an very good idea.

I am not clear here - could you be more specific about what races will 
happen here, more bellow
>
> Eric
>
>
>>> If the ring is hanging for some reason allow to recover the waiting by sending fatal signal.
>>>
>>> Originally-by: David Panariti <David.Panariti@amd.com>
>>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 14 ++++++++++----
>>>    1 file changed, 10 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>> index eb80edf..37a36af 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>> @@ -421,10 +421,16 @@ int amdgpu_ctx_wait_prev_fence(struct amdgpu_ctx *ctx, unsigned ring_id)
>>>
>>>        if (other) {
>>>                signed long r;
>>> -             r = dma_fence_wait_timeout(other, false, MAX_SCHEDULE_TIMEOUT);
>>> -             if (r < 0) {
>>> -                     DRM_ERROR("Error (%ld) waiting for fence!\n", r);
>>> -                     return r;
>>> +
>>> +             while (true) {
>>> +                     if ((r = dma_fence_wait_timeout(other, true,
>>> +                                     MAX_SCHEDULE_TIMEOUT)) >= 0)
>>> +                             return 0;
>>> +

Do you mean that by the time I reach here some other thread from my 
group already might dequeued SIGKILL since it's a shared signal and 
hence fatal_signal_pending will return false ? Or are you talking about 
the dma_fence_wait_timeout implementation in dma_fence_default_wait with 
schedule_timeout ?

Andrey

>>> +                     if (fatal_signal_pending(current)) {
>>> +                             DRM_ERROR("Error (%ld) waiting for fence!\n", r);
>>> +                             return r;
>>> +                     }
>>>                }
>>>        }
>>>
>>> --
>>> 2.7.4
>>>
> Eric
