Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937486AbeBUOPu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 09:15:50 -0500
Received: from mail-co1nam03on0066.outbound.protection.outlook.com ([104.47.40.66]:14190
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935321AbeBUOPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 09:15:45 -0500
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
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <7f6a78ae-abab-2a03-aebd-e43e6fe168b4@amd.com>
Date: Wed, 21 Feb 2018 08:15:36 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <00583b68-d599-b709-133a-3741c258df13@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: DM5PR21CA0066.namprd21.prod.outlook.com
 (2603:10b6:3:129::28) To CY4PR12MB1143.namprd12.prod.outlook.com
 (2603:10b6:903:38::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0f3e5ca1-231e-4b71-8130-08d579359874
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:CY4PR12MB1143;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1143;3:OufnP6L5vWm84uS5hn7sPovZRg8b9QhImDSh+suYmPad/XG7I9m3YZ+T/cNGZCHDbeaODAJ5163uZFBPx9IJI7GW2cHmaJNUVfmo/98zfpy+6d31RbtUxckHpYhhANPs7f/AEe8lsPcy4fQ7Nxecc7YayCR0BeIxGklFUW86pYJac8yHpApSNzXl6sLOjuoZ89sJ6EIGCnMpo9Om2/ezXOeYKraqAqY1HJthfvA0M1Y6TtA4vktleVloztbkjI3L;25:gE7Z62Dk78VSK8RC07//3fOFmIDxxd7iDT6p/pAxbsxvo+GutEWX+DWrBk/IaOQxfLNOM+Ao4evtcuweuQ1xxsf1ikH9f7eg9aMXH3yuHxcpgypLAiB0YFecyyK66lgm7BEA7QNP20QR8nhNS1gvBZnLNnhvqp7G/05Q1fiHw+BL3ZNs/VhkH+ZQ15YIABEX3LRZruwMs//YjhYfBpNeclk1HmTfPU9ZHExI1w8WggoCa8xtdXeptEA0odpWYUmeOdJJOvEtj7x+JUgBuZQhERHp3b/Nn4Y6TL9ZdRKbiu0J55W8JvlyjIsLwhEUDAqAuD8eWg/2aIGXLrLzy2zDQg==;31:YtCeyz9FhZnVCT6yXwd5JpPH8Cv/z6GIRVJ/mmknnvm7ML0nEQtqOcFULZiXGVx3W69rsdT/yV6fv6Ay6ommgNQLtXXfvvJin8rPJXkXcrB9WWN+ytr3Kkqf28iA7IXYmn2MVHNkEGZ4hXV7u5ydh2vDaet2kQbq42iKCoDLXmnHw01iLhM45VEVslObQr/X+whzchAhy2QC08z60/oo114s4KudrbjD3Jrq/vnW4Zk=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1143:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1143;20:AHxMcirRWdq8UH+Hmuiccq49mhO5RGoxrJqrsU6m/xxHKdG48qeJWbApthN6EEeYdWtTpvgzNn/lVxUD4F2bxK96ITz5UvyFH080O9Q4xSqbFZYMGPJhDpibsc6V8Sg6RJHrkLhE9L4LF4dnNs4xo/iv/UuTItsG2DI9/JD/Xjs754dT909A9DIT4AM1EHQIdANcHvyQHrTgzp1dscNp56p1J0GMepi+o7Rv77qzRLfrKm9i6EqnRbK2scU3J27ljXizNa1XzYyLbGw0clcp+HiZWlDcNd5CTg/WENqiHTBdFmVCWGrgHWQP85nVjQ4C7MabIV/nzKSFLAj37MofNwZrH243ALZ9EffPfO+/G5LALHjfU/5PJWP2k/xRxMGEn1AYU+RCy6Sw9HCwdlH9WwBzxg5faOFk1rwLSzhGPnmS7uxK1XH0WFyHI9J4LtRpU4mph08xlDP/OVAuozUpGtB1XsVdJ7cphtFLMPzOsvXs1jQF31PmMQaYEFMsCcSU;4:TsP6Kn//XaihmCAZYoaxviEZSI5jQGi//CYWMJSks6en2pZazXoi149vk8Dn7lMeXKHWHfPEEPcyu+qLgz3xI0m81yxU5LvexURn5/ynthPJ6vu6HcQVqqqU5FEGv/Z1licNkOtk65qn4r0kWEiCkrIBSeh+QM5gttGuSTqaYIh6Vv5TvyL/7UmBonWJxcZ2jFOfocSeB/CSCPGmpyWM6YrIkkLO4zc4GgmKarqAyGo2sfIABvOsC/EeX4ITiKYQN2kqOGv1GjsgzJu68dkGMA==
X-Microsoft-Antispam-PRVS: <CY4PR12MB1143C131AA3CEA8BF606B3E4ECCE0@CY4PR12MB1143.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001068)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(944501161)(93006095)(93001095)(6055026)(6041288)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:CY4PR12MB1143;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1143;
X-Forefront-PRVS: 0590BBCCBC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(39860400002)(376002)(396003)(39380400002)(366004)(189003)(199004)(229853002)(2906002)(16526019)(105586002)(186003)(106356001)(54906003)(68736007)(31686004)(8936002)(86362001)(3846002)(6116002)(58126008)(8676002)(5660300001)(81156014)(81166006)(36756003)(65826007)(305945005)(47776003)(6486002)(52146003)(53936002)(2950100002)(7736002)(6246003)(65956001)(25786009)(31696002)(478600001)(72206003)(52116002)(53546011)(386003)(64126003)(76176011)(230700001)(6666003)(4326008)(77096007)(16576012)(23676004)(66066001)(2486003)(26005)(97736004)(65806001)(316002)(3260700006)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1143;H:[10.236.65.116];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyTUIxMTQzOzIzOmFNWDVWYkxsL0hRYVRRelFVL0VkcS9DeVpT?=
 =?utf-8?B?Y0xUaDVZaExYY3p2eWhPZGxiUFdmZUMya3A2VWVhZ1hTWEFRWnRrWGU1U2s3?=
 =?utf-8?B?NkV6Nng3amh4WnkxZ0JoOWNJS0ZJUEhlOUxLZXlMMXV0M2RDUkszemhPdkJh?=
 =?utf-8?B?alFRakczYTBDRlRKT1FxY0xYdjA0QTQ4c0k5Q0QralByZStDdzNvOWpSSENl?=
 =?utf-8?B?OE05anpLWG9IQXRVaGZhMkk1L3NqT3ZIeHBmb3JtMWE4dy8xQnpqa1FVb1Zp?=
 =?utf-8?B?d085ZEJDSlBwbjNPaVFYRXdzRGxPVlhJS2xLdkFlY08vZ3F3Zi9mMFpmaDBq?=
 =?utf-8?B?WHZVYUtNTEM2dENjL2FLWm1DTTVWUE9QdHloelJOQnJ3a1FrbzZ3SEdsNWUv?=
 =?utf-8?B?dDMyamgraGp6WDhWOTBqdnBDSFc4NU0wYS82RXhtSlQ0YWRIYjg4clhGNkZP?=
 =?utf-8?B?S1dKZHBJNU9OWDZhSDBlY1lkZzVDRk90emQwazl0dk9QZWpSbFFlL21ySytp?=
 =?utf-8?B?MkRzdUZBZ01pM0JIcUc4UnlXZ2xjKzZCeTh2emwza0U1WWlvcXhXU2NLSmky?=
 =?utf-8?B?eWdLaVlRbG50QitLZ1Z3cTMwYXRnRElsVnpzR0Ric0xlcUcwUTlkaXpMUisw?=
 =?utf-8?B?REl4cjhOcjRjRWFOdzJjYk8zOCtIZ0tZUlBKbHN2TUJBZlQ1bFRLMjdtNHNv?=
 =?utf-8?B?cWRJTWUwUFNHUXhDUVhBSHhWL28ydGlDSzYveFFVYnZ3QzZ4RGE4S1BQQTk0?=
 =?utf-8?B?YjFPSjZaWm02dVZJRVR0M0E1OGVKd0hhckt0eUJKZnNWdm5TSDRTK3BNbDJ1?=
 =?utf-8?B?N3kyeE1RcXFvWDhwdVpBRUp2Y25jbUVmcjB0aG9mdVZuaUsrelVVQlQrZE05?=
 =?utf-8?B?QjlLQnVLa1JsVVAyeGFHRzJaQjZQV281SXY1WHBBa1FtOWJhNTMzWVZOekNr?=
 =?utf-8?B?WW16cmVWbVhkVHlucGRVVC9PcVNxRHUvNklVdTR5SzJ2YUlwUGlwaWk4bGFh?=
 =?utf-8?B?TTBkeGlIT2hyTTQ0ZmM5NmV1d1c0WFMxN1hXV1dQeERJUXA4Mlo1dStjY2Uv?=
 =?utf-8?B?aUJhbDljQ29OWlRJK29WVllETitXVUJwL2ZxS0xySG9iS0NaMDZqaWcrNGd3?=
 =?utf-8?B?WUg2YkpDWENKVmc0MCtGanU0NDg2cEN1cXBjZkhON0xVSDZ4ck1rSlUybU96?=
 =?utf-8?B?L2FOVW9vS3JIVkpiWVRWSDNPWXA0b1VwZncxbHlMU01wV1NndUg4UDA1Yzhr?=
 =?utf-8?B?MGpVa21kTVRyTzc4WGpyWmFhaU5lSzgwZld0Y2habnk2ZFVwU3hKSHR2TnZk?=
 =?utf-8?B?OVBsaTMvU2NzYXlHQkUrWVZaalRCVjRybDMxRkdqa2RTT0FWVCtzL0FtWGlT?=
 =?utf-8?B?MDFGRlFWUmd3SHQ2Szc0SE1BbWV3T3NpMGI2dmtyOU1LVVBmTUZIbG16bVZ3?=
 =?utf-8?B?S3ppenhEK2JDNzZuYnMyQUduMkpPMEJhVnZiOXFja1lGRmp6UkJKVnAxMGJF?=
 =?utf-8?B?SGdWSkZTZTR3WkRwM2xHVDVlQjVad01BY2FaQXdlSGlhY1hPUlM1VEJEUitk?=
 =?utf-8?B?Q1J6SzBZQmdiTm9uemFOUHE4WU5McTVSZWRwMHFHcE5OR0JKdFo1eDl1UURU?=
 =?utf-8?B?aHpvR1pFdVo0NERidzVjWjRBMWdYM1FodzRXbWlsTHIyU1l1MitWQUZpNzEr?=
 =?utf-8?B?ZG02N29LN25KVHYwR2lROFNvbjRWZzRYTTUxeVQ4OFVEa3htc3g1eTQ4REE1?=
 =?utf-8?B?K1FFS2g4REs5WThoZEFGTlQwZnY1YkRXbCtHb3dtbzN3OWk4M1p2amxEZlVO?=
 =?utf-8?B?NktweHRjWDVKelVhNHg0YVR2aExuSENQOFIrUDZvcmdaeGJ0aXhFUzRXaG5R?=
 =?utf-8?Q?QU+Mr1TTuig=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1143;6:GYpWNv18Q75ofhwy6WBu24rrsf2242R4vdiCkHaXWpD6HAkAv3i5LbGoJ5sX1knVGptP8YaHn/BUzrXJB6/mEhSk/Y1iH83J+WdqB3bUtRR+XD+sdw1oplZ/0MVmr1m+jjHhaMjSt7/5oZZ3LUmCY2w4SdO6SchbiS1IC4uD/EmVvnnQiCK4sfwurpdReoU6ko3gK///2CuR/kt4vyHKIk+If78dRKEc8QvhJmu5e3k82JJTP+65rsS8EHMnjd12OVApW9d7PWc/uxqfKEFQVw3XCa227EGf0x8VPvMXX3XHgdb+6DaLbYWC7KF9SKTWz3jCtzG80EKQXLDAc+JBSwB9iU2LVktqwuOJvWV6dNU=;5:P3jH6BoQOAabYd5vpM0mmUgWMv45ZUUEV/lArvBkJn5nlDF/Cfpxq+Oyh8RFkklLyQHFsCi1Z3zpJDlBt04jZtuqr4jM1hZEMa0WAiAd9u5wXjueTALKft44uXLKigPsmkA8tN2h3l+WTsAEEMbKiJ+jcN4vF8+NN+6qPW91C1E=;24:f9xgficDc+yNa/weHC7YHiAM3rLHSsSNaJFmSagoArtpMb7rxLLRwhC8W3RLC+UXllfTZrWdMiPKZ86Lb2VPxyZKCc0J3nfbfnMKPUuSCLA=;7:wR2DEXWfk9TW4OmROdmuSQbPlhnIV2XLx3ADLtQx4Rjx2NnjGW5XNpqB+b2e/zbfMx6x088gcdmDzHqyzLciBBomUF2kdiuJ+uQxMOyo3YNpvfN7qfVf1PoJc7Y8gcmQyoEB3ratMxm4tId669v/LaNaf4oEknFFBu+aY0r0MkqasBR/fNvvpElFdpDxPWVrz7bIAd8xbxQsNo11s7RqDj+7xeJli6RBgHYZkiVbO6w3SXwNBBNrShJzVbp/KApw
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1143;20:xxQj7E6zsSeGr3dCNijiRjEH9o+FeMtHvliCMtubPVlg2jIazrPNY65uilJ4maoyU8uQZjFhoiaMi2izf+giaSbx3SdHq45WhndSNauOHIIi5mN5V+IXR9jb9qVROyn4j+M4INn4SupNQkEEU4kiR1Ud6b+ncetntZDPOtnPXPhRJv8lISuyxcwvR+VVAPNh+2LnqAgnbn5QS+W3H9rD5823uZ4QdGa6cXnm/lUyMatcyJ2jx1PLWvQT/7zaZx+T
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2018 14:15:43.6574 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f3e5ca1-231e-4b71-8130-08d579359874
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1143
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/2018 5:41 AM, Paolo Bonzini wrote:
> On 16/02/2018 00:12, Tom Lendacky wrote:
>> +static u32 msr_based_features[] = {
>> +};
>> +
>> +static unsigned int num_msr_based_features = ARRAY_SIZE(msr_based_features);
>> +
>>  bool kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer)
>>  {
>>  	if (efer & efer_reserved_bits)
>> @@ -2785,6 +2794,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>>  	case KVM_CAP_SET_BOOT_CPU_ID:
>>   	case KVM_CAP_SPLIT_IRQCHIP:
>>  	case KVM_CAP_IMMEDIATE_EXIT:
>> +	case KVM_CAP_GET_MSR_FEATURES:
>>  		r = 1;
>>  		break;
>>  	case KVM_CAP_ADJUST_CLOCK:
>> @@ -4410,6 +4420,47 @@ long kvm_arch_vm_ioctl(struct file *filp,
>>  			r = kvm_x86_ops->mem_enc_unreg_region(kvm, &region);
>>  		break;
>>  	}
>> +	case KVM_GET_MSR_INDEX_LIST: {
>> +		struct kvm_msr_list __user *user_msr_list = argp;
>> +		struct kvm_msr_list msr_list;
>> +		unsigned int n;
>> +
>> +		r = -EFAULT;
>> +		if (copy_from_user(&msr_list, user_msr_list, sizeof(msr_list)))
>> +			goto out;
>> +		n = msr_list.nmsrs;
>> +		msr_list.nmsrs = num_msr_based_features;
>> +		if (copy_to_user(user_msr_list, &msr_list, sizeof(msr_list)))
>> +			goto out;
>> +		r = -E2BIG;
>> +		if (n < msr_list.nmsrs)
>> +			goto out;
>> +		r = -EFAULT;
>> +		if (copy_to_user(user_msr_list->indices, &msr_based_features,
>> +				 num_msr_based_features * sizeof(u32)))
>> +			goto out;
>> +		r = 0;
>> +		break;
> 
> I think it's better to have some logic in kvm_init_msr_list, to filter
> the MSR list based on whatever MSRs the backend provides.

Ok, that's what I had originally and then you said to just return the full
list and let KVM_GET_MSR return a 0 or 1 if it was supported. I can switch
it back.

> 
>> +	}
>> +	case KVM_GET_MSR: {
> 
> It's not that the API isn't usable, KVM_GET_MSR is fine for what we need
> here (it's not a fast path), but it's a bit confusing to have
> KVM_GET_MSR and KVM_GET_MSRS.
> 
> I see two possibilities:
> 
> 1) reuse KVM_GET_MSRS as in the previous version.  It's okay to
> cut-and-paste code from msr_io.

If I go back to trimming the list based on support, then KVM_GET_MSRS can
be used.

Thanks,
Tom

> 
> 2) find a name for KVM_GET_MSR that is better and different from
> KVM_GET_MSRS.  KVM_GET_HOST_MSR or KVM_GET_HOST_FEATURE_MSR come to
> mind, but I'm obviously open to other suggestions.
> 
> Thanks!
> 
> Paolo
> 
>> +		struct kvm_msr_entry __user *user_msr = argp;
>> +		struct kvm_msr_entry msr;
>> +
>> +		r = -EFAULT;
>> +		if (copy_from_user(&msr, user_msr, sizeof(msr)))
>> +			goto out;
>> +
>> +		r = 1;
>> +		if (!kvm_x86_ops->msr_feature || kvm_x86_ops->msr_feature(&msr))
>> +			goto out;
>> +
>> +		r = -EFAULT;
>> +		if (copy_to_user(user_msr, &msr, sizeof(msr)))
>> +			goto out;
>> +
>> +		r = 0;
>> +		break;
>> +	}
> 
