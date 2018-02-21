Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936272AbeBUOrx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 09:47:53 -0500
Received: from mail-by2nam03on0047.outbound.protection.outlook.com ([104.47.42.47]:12072
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932143AbeBUOru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 09:47:50 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
Subject: Re: [PATCH v2 1/2] KVM: x86: Add a framework for supporting MSR-based
 features
To: Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <20180215231156.31016.79657.stgit@tlendack-t1.amdoffice.net>
 <20180215231206.31016.78914.stgit@tlendack-t1.amdoffice.net>
 <00583b68-d599-b709-133a-3741c258df13@redhat.com>
 <7f6a78ae-abab-2a03-aebd-e43e6fe168b4@amd.com>
 <94f6ed44-07ab-ff0f-2a6d-b3d8ff4ff4b1@redhat.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <f1b934f4-e228-e6e3-496d-d8287018602e@amd.com>
Date: Wed, 21 Feb 2018 08:47:44 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <94f6ed44-07ab-ff0f-2a6d-b3d8ff4ff4b1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: DM5PR21CA0064.namprd21.prod.outlook.com
 (2603:10b6:3:129::26) To CY4PR12MB1141.namprd12.prod.outlook.com
 (2603:10b6:903:36::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bc09794b-a2a1-48d7-4241-08d5793a1301
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:CY4PR12MB1141;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1141;3:hItWavx2IyGhDwZOKfePyq6zYTNE3okiZwnl9k889u8xX9w09p3TnijaUungcBpDTZJWArwjrAAXeEPwI0r6H8a/DIHjnPQBQlxoxKepjuHwUPExkY9P8DYPR00hJG/hdvj0HT4d+6LMs90eaqr7tpCWpx7dIciS9GdNJUsNbIcsNqanBRfd18txlhMjaGVAJ9M/efNWg4p96yv4wTczartfDZQd0FPyVlQX0njytokci6YzxUV87MiBC0h3rmcP;25:j3CFRLg8KeTZTjEmQo/6veVlqTnnu1CcaV+FaAd9wuTBP/ZgQM9WpqyIcnac4IdIeHmuvcjK++txKGL4UOZuUG2/OnfO3mz5Mjw1RNgAh387epCb0Sxtk7Fu5sVmBPCO0EJFhcjnD4Pa8/WnA6+ZAIQyfaEUO5TNGiQMQipH6df28PaET/JBMAuEiNv5v+hi0/d3DXZIpms22WfIHYlaYfqZMLHB977vE5csOcUrqYUFHd3EuKIExfYgN0REP/vduCP7JbnQRKlIkuvFz7uXGpuhtKWvUL5xsX0OxwULusrslF148z2GAgD+wlj4u6f0a3PVby0sW5ubofrm69bF7A==;31:f8v9eTIXe6J8yQfe2bM6dc0lzA9cFdCSk+jxKXpASGk2BRIwabGOTYseBowGngMfyiXQSA4FU1tpX9G03wvJd1r0OCSNjJuh8/qJy88fgl0a5qukQQd0HPRzGDPmCywDo/gNKkRk1otx8SsaVYTR+A7Lv+DOFgQXOeDewq5bS5jLOu369RXWXc63RrSKTQ3IMatwJqE3XYle+0w+L+ctZ+AwxQ0Z3ohBTsHJd0zkV6U=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1141:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1141;20:qsQM3X1J/PGZWfTA7a1RYtxavAvH4jodBVj5L5iC3xLxlwQPBTcqAu39uRoel1spmxq1DuQ5tPPvJOcgUHDmEKGRODAYe1K/lgdG59/wijGpae7JR12fg0r5sj3o5WpCsJbVc4jWNokcEaLh14MvrCWVRiZjZy8kuqkYcm0PPpHEuq3w4C0LL0uuGC9bemRSkDMSWfaLQDmPX+ngcAZNCAjZCMu8IkPkV385vB3eescjXfl3crzcEjecUC4BLru0RUZlrbYTmgRKIrSLY3bvM357YrGk2qjnLlEIQ8v5HcG+Riv+37d0tVv4iRA8UMfBD05YKgQHrIIDxXc5jsXzXgJpD9WJnKjaK62PZrWw5cizkTjjqbu+XDQaJlo84dPwZZmS5LqaMSPXvqw4ymKAJg5+T/TlGXzdXgAUrX1amUMIMhp4TdcyN4TyQK9b+gP1VcrOskObfusYCmovi7kko8/CFtN6lm/6FD9/ScE33GlXP3VyUn+F52UkmM9wIIWC;4:v0W0QqGLkA5onlidgN0tx1/ASGEI3AK4IY7p1he7BHxy9TQboi5YM1eon6Yjj92aWaK/aU0Q5Ue4L4ds8m34+h++iZUoovwlLTE9v9emN2GEdsRDUcLD2heCZDb64xnef7Yy5565Z0lJcqapdIB6lEmCfCqVr5xRrsJRNCjWBwiYmED2kYhW2srl1C2pp9yZqWWFSY2Qmj7O3IqNyPss4wi4D1AtO0QxjhqJ+a/v2KwdAVePDQwbZlCZF18o1V3FhP65Ut9dE9L7JcIEyPM/6g==
X-Microsoft-Antispam-PRVS: <CY4PR12MB114195981CCF86E58EF645D7ECCE0@CY4PR12MB1141.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001068)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3231101)(944501161)(3002001)(93006095)(93001095)(6055026)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CY4PR12MB1141;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1141;
X-Forefront-PRVS: 0590BBCCBC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39380400002)(396003)(346002)(39860400002)(376002)(366004)(199004)(189003)(16576012)(50466002)(66066001)(81156014)(25786009)(97736004)(8676002)(106356001)(23676004)(230700001)(5660300001)(65826007)(65956001)(2906002)(52146003)(64126003)(31696002)(81166006)(966005)(86362001)(52116002)(8936002)(305945005)(478600001)(47776003)(3260700006)(65806001)(72206003)(7736002)(31686004)(58126008)(26005)(16526019)(186003)(36756003)(76176011)(77096007)(93886005)(105586002)(386003)(316002)(68736007)(53546011)(229853002)(6306002)(53936002)(4326008)(6486002)(2486003)(6246003)(54906003)(6116002)(2950100002)(6666003)(3846002)(6606295002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1141;H:[10.236.65.116];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyTUIxMTQxOzIzOmEwN3AxZWJVU3FrcVBvOHVRUmZNa21wMnFp?=
 =?utf-8?B?OExoZE9zZWh2eTBjK0hjL2FQSE4zS0ppQU9IenhTVXJycmx3bVRWN1ZIMjZP?=
 =?utf-8?B?eVBvdlhRbldUNHprZnVqVjErS0dvL1UrejRXbnBjdzFzdnNEU2pSZCtjQ0Z2?=
 =?utf-8?B?Y1ZWTjhYRS9OaGRHNlhsVE9qY0VhTFZsdFdGaXFuWnhLK05jUFptN2liTTF1?=
 =?utf-8?B?ajQyeGp2OFIybVpIQkVVTW1rdDVwV0R0aWNPcnlBbGVIeVlERjZmT3lsZ2Jt?=
 =?utf-8?B?ZXhWWmZsVG53Zk8vNTVIbTRUaC9QUUJUS1F4V0FxSGg1NmV4K0JlemRiRmRE?=
 =?utf-8?B?bndwWGZOaW9NUUhMK0Q2NDA0dmlWQmhkeXR6YnVUcnBKZTA1eXZLM0ZlMHBD?=
 =?utf-8?B?VUEyYXQ4TXdhUUtBV1NkZXdqUnFxL3J5ZHl6c0FHS1E5R0FJTE9DQmZvdE0r?=
 =?utf-8?B?dzdMRWVyS2xXY20wRVJRU0hOZ0NBbFRkSUMvaTRiNTRTa2xKQ0tFZ05iYnBJ?=
 =?utf-8?B?am1HS1hCVUlSTEp0RGhxY3VDUDVGbTl4dU9yTzRwRHlrSGduVmFURzdReHMr?=
 =?utf-8?B?VStOTGNmZzFWcWxsUS9HcVc1R24zWnVoVmRJMzhFckxlMlNyTTE5cGkxemZI?=
 =?utf-8?B?SjVuV0NTZ0xjY1duZ2RTcUhrSGx3amgyU0duT21YeDQ3RkJKKzVQUTNGZ2V6?=
 =?utf-8?B?TDBqWVF5bUVGeHMyaEp6ZTIvNjVJZzQ0QVlkWmpBR2hiWDdzWG0zQlcvbk42?=
 =?utf-8?B?UkdLclNzaExMZHRqTEp3T0R4alhMK0tBZ1hSVFJENEYzdDV1Q1Q4UldoYk93?=
 =?utf-8?B?K2NZcmF6RUYxN2FNTGhCTlJWWGZBNUEwSm5oNXpKdFAydVd4cWtWQks4VlRt?=
 =?utf-8?B?TUIzVFZESStnT1VsNlp3UXVYMWd5Zk9aSmVjWXZUSFAzbUFNMVB3Mi9iNkJ2?=
 =?utf-8?B?MUxLSmFqMkdWaklSWEsycG5qTE5GaVFiYXdaU3VGVzF2bnVYWGVLK0J6S1JL?=
 =?utf-8?B?blg0NENITHR5VXRkWE16bmdVSkRpTWIxVGFvV0ZNeWRyQ0w5SHRqSGlxY2dQ?=
 =?utf-8?B?dVpqWjlQZDNQbzRHeWZsVWI3M0ttaGR3Z3RSZ1k4aVMrRGVrUDFoeFlUNDRE?=
 =?utf-8?B?em9xYWQ1NEozQ2xPWUwycy8wWnZhWE0vSjdDaXIxVWlNdFVOUUdTb0g2NCsx?=
 =?utf-8?B?ZXBLTWtETmZPa3FqSUZUU1QwT2RUNVFIeWdpcE5xaTlGMXhZWDhvVHdIZGx6?=
 =?utf-8?B?bWtzeHg0aS9HdExHOXQ5UVBsRCtFS3YwdzNPemwwcUZCV1VwSHUrSkFLOUQr?=
 =?utf-8?B?U1lCK1Y3cTBSMUtSSkJVQzhpUHo5UldUT1hCdzd2YWhMU1dJRDN0c0VIQmxy?=
 =?utf-8?B?Q05HeHdhN252RlBlYW1rUmUyU1oxWnYvSis4dHgwS1BmV3dXb3haZ2tYSmdB?=
 =?utf-8?B?c2Q3cXlCbE9KbGhOZzdITEg3dUdSMXV1SkVVZG0xOEZIWDErKy9jVkJDem54?=
 =?utf-8?B?Q3gwT2ZNNmlQNVh6QUdpOG9veHFDZ1dvOVg3K0VRQjdlN3o2RWRCSzdrNEY2?=
 =?utf-8?B?T0ZOMTJ0R3BHOWFVYm5HR2gwZkd5dGtiNnNTTG5QdytacmdhTHRTSUU2NXpX?=
 =?utf-8?B?N0RKVHVuYkZVcDlSTnk5cnovTk9KNXhaSGFRQm5kdHBKeG1TSVBtS1FmdkNX?=
 =?utf-8?B?SXlKbm9PaElZbEZHVnlRK1BNZE1FUHFVSTlERjAzd0h2SlRSWFdGSGpGaEZz?=
 =?utf-8?B?TXNEcGVzSU9lTVB4TVdIcXNxSTVTTHFsS2szZTk3d3BsdGV2N1Jzd3ZMRHc0?=
 =?utf-8?B?SW9KRkNIRURGWDBhRkpGWHZ1MmRXVGE2YW80SGpjaHFrSnNRRE4rc2lTYWU2?=
 =?utf-8?B?RWRTMEV1Um9vT2dteHkrUzNndlljRXVZeGYxY2g1SzQ4NTl0dW05bDZsaWlE?=
 =?utf-8?B?YUVxdStzQXB0MFdDOGZTWHl3OU9mam00M2pvOFRCTmVEb0hxY2lnRFBVK2FL?=
 =?utf-8?Q?b425mC?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1141;6:32ZXPH5qOzcQJ3m1tWwX+dkm6rNjDdwdIy9qZYcpXDj0/eS8hWb25HijOCJI1HpqUuFxntekhze3xxdqcMnU4JMAcVxM1dCAGUcBtOmj95tcs3H/a9c/47DZhvcdk0VrUNXJhtV5uixzdumc7/+8haqKw+Q9J7lx0Ofh4759fpKG6g4YNAxhYwd/9DKhPSd2YtO1ib6PkujpD2bWunOw+LNcvDkpEBwa9q91uNM2uy9zQGw2hUu9CF5oJH5p0Zc4kCtK4WJjf3U5axokox995PGrHmdyQTkFOQRRXfRHdFXZeoGLs1GbKEeuGUoMArgie4gZ7xAeLZP2XD1Swz9I7qNa2zqVCB17wftb09ckWLA=;5:NqnG93UCq/vXxO4qqmVYxuahOnYakjy7Cwb9Z8mhjjz8DwFR8hNQtW2aKoFG7olCvayadRgHHikiRH/CP7UjRJcAcUxLoTkEmzP97nyYgGbZpbIvpil2MFh4qeIzwGAK3RdS31NQiuQqxmFRQDLA6S76KkYjC7+Nj8MYGqDOupk=;24:Xccqp8EyEjUIFyv0h6A0djBlNkLZpr1w3psdsFuG6uTIrMbkWkgxl7c0RMbyYLX4mL763Rm+Gcacv5lQNyv3IP8uuU05JH2IBa+HJNMVJ7U=;7:+o71NQJw2YAJMz669HRw6rQGPbEXOg161u23+6dNWASM1r8PxUR9nm7BlCaLQOYWr6zXaat2hEL2YfRGFJjtul1F1pMKJp6y/2nYmgGhMaxoXlHDNqAy8dyGw3TSp/pu1kdfrwNkguv/ntmg5LjbIdKL6kMScWWxbzDTJHOakpW9LWECh3G9V7YrEiYwnRGmKhCc1lpQcco4HOc32pIAwc7k0kKE/qYv9Uf3SHpCBdGYptlIYODXvQrUiTyQBuZv
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1141;20:u0icFh+x2LCoiTL930duGOBgB3JjfefGWsixWjcNy/g2tAOGPuXC6kn3fFgbPBMWFQryAu8VpF2RwtBDzAdmm/iZsrmfy+bjonRzf3xPEWwI/akqnoN7PTFIe+qB0KRtO8hppDCtokbw6400Fv0JSxOKMdHDZbjCdumTG28L9I01p4zD/AHfo9qHPJUBcSM4JahhcDYcs9V9cuWCpXSC/seUTO96Td2CCdHZd5T1fpQTw11Te8w0aGzjInr3Gd0l
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2018 14:47:47.1863 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc09794b-a2a1-48d7-4241-08d5793a1301
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1141
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/2018 8:32 AM, Paolo Bonzini wrote:
> On 21/02/2018 15:15, Tom Lendacky wrote:
>> On 2/21/2018 5:41 AM, Paolo Bonzini wrote:
>>> On 16/02/2018 00:12, Tom Lendacky wrote:
>>>> +static u32 msr_based_features[] = {
>>>> +};
>>>> +
>>>> +static unsigned int num_msr_based_features = ARRAY_SIZE(msr_based_features);
>>>> +
>>>>  bool kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer)
>>>>  {
>>>>  	if (efer & efer_reserved_bits)
>>>> @@ -2785,6 +2794,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>>>>  	case KVM_CAP_SET_BOOT_CPU_ID:
>>>>   	case KVM_CAP_SPLIT_IRQCHIP:
>>>>  	case KVM_CAP_IMMEDIATE_EXIT:
>>>> +	case KVM_CAP_GET_MSR_FEATURES:
>>>>  		r = 1;
>>>>  		break;
>>>>  	case KVM_CAP_ADJUST_CLOCK:
>>>> @@ -4410,6 +4420,47 @@ long kvm_arch_vm_ioctl(struct file *filp,
>>>>  			r = kvm_x86_ops->mem_enc_unreg_region(kvm, &region);
>>>>  		break;
>>>>  	}
>>>> +	case KVM_GET_MSR_INDEX_LIST: {
>>>> +		struct kvm_msr_list __user *user_msr_list = argp;
>>>> +		struct kvm_msr_list msr_list;
>>>> +		unsigned int n;
>>>> +
>>>> +		r = -EFAULT;
>>>> +		if (copy_from_user(&msr_list, user_msr_list, sizeof(msr_list)))
>>>> +			goto out;
>>>> +		n = msr_list.nmsrs;
>>>> +		msr_list.nmsrs = num_msr_based_features;
>>>> +		if (copy_to_user(user_msr_list, &msr_list, sizeof(msr_list)))
>>>> +			goto out;
>>>> +		r = -E2BIG;
>>>> +		if (n < msr_list.nmsrs)
>>>> +			goto out;
>>>> +		r = -EFAULT;
>>>> +		if (copy_to_user(user_msr_list->indices, &msr_based_features,
>>>> +				 num_msr_based_features * sizeof(u32)))
>>>> +			goto out;
>>>> +		r = 0;
>>>> +		break;
>>>
>>> I think it's better to have some logic in kvm_init_msr_list, to filter
>>> the MSR list based on whatever MSRs the backend provides.
>>
>> Ok, that's what I had originally and then you said to just return the full
>> list and let KVM_GET_MSR return a 0 or 1 if it was supported. I can switch
>> it back.
> 
> Hmm, I cannot find this remark (I would have been very confused, so I
> tried to look for it).  I commented on removing kvm_valid_msr_feature,
> but not kvm_init_msr_list.

I think this is the reply that sent me off on that track:
  https://marc.info/?l=linux-kernel&m=151862648123153&w=2

I'll make it consistent with the other MSR-related items and initialize
the list in kvm_init_msr_list().  I'll change the signature of the
msr_feature() kvm_x86_ops callback to take an index and optionally return
a data value so it can be used to check for support when building the
list and return a value when needed.

Thanks,
Tom

> 
>>>
>>>> +	}
>>>> +	case KVM_GET_MSR: {
>>>
>>> It's not that the API isn't usable, KVM_GET_MSR is fine for what we need
>>> here (it's not a fast path), but it's a bit confusing to have
>>> KVM_GET_MSR and KVM_GET_MSRS.
>>>
>>> I see two possibilities:
>>>
>>> 1) reuse KVM_GET_MSRS as in the previous version.  It's okay to
>>> cut-and-paste code from msr_io.
>>
>> If I go back to trimming the list based on support, then KVM_GET_MSRS can
>> be used.
> 
> No problem, renaming is enough---I should have made a better suggestion
> in the previous review.
> 
> Paolo
> 
