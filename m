Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032094AbeBNQHP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 11:07:15 -0500
Received: from mail-dm3nam03on0044.outbound.protection.outlook.com ([104.47.41.44]:36016
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1031649AbeBNQHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 11:07:10 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
Subject: Re: [PATCH 1/4] x86/speculation: Use IBRS if available before calling
 into firmware
To: David Woodhouse <dwmw@amazon.co.uk>, tglx@linutronix.de,
        karahmed@amazon.de, x86@kernel.org, kvm@vger.kernel.org,
        torvalds@linux-foundation.org, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, bp@alien8.de, peterz@infradead.org,
        jmattson@google.com, rkrcmar@redhat.com, arjan.van.de.ven@intel.com,
        dave.hansen@intel.com, mingo@kernel.org
References: <1518615874-13806-1-git-send-email-dwmw@amazon.co.uk>
 <1518615874-13806-2-git-send-email-dwmw@amazon.co.uk>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <6e3610be-cdcb-5c5c-fecc-7c41f2ebda73@amd.com>
Date: Wed, 14 Feb 2018 10:07:02 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1518615874-13806-2-git-send-email-dwmw@amazon.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: DM5PR16CA0004.namprd16.prod.outlook.com
 (2603:10b6:3:c0::14) To CY4PR12MB1142.namprd12.prod.outlook.com
 (2603:10b6:903:36::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c70b6b7b-94ee-4f92-2dfe-08d573c4fef5
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:CY4PR12MB1142;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1142;3:ZIL6yXo/4eiM9yeOY23qnCylfaRbnbZ4pxpsW0NK6rXt/0Bs4uXInh78yQlBrLGIsMTdgRs1jSPg733ZAbx/0qW8lxO/YhfSguYl+iWbfQH4pDhTDoXrfOF/kRmHhjF4fwTGnODj4rZcKSVUSes6gXGAHRvUTxnvk7xT4xgoZkhU1eALT1PqXL6tZmBXuP9IPZf13NRtfjzlfkcGurJuah6lz7eQzDgy2/EDp8tEYLNUvTYk92NMJhgkae5IUtaL;25:w8SQmF9Mvjo8lB73vKby6JNhHZKwEs6I7XPAsUnD3VsH31iO40t+jXsGqY0rfzq3hzkn1h2uBSO3tUE9slmOFjFxCWFw0XgRcbsoHnhDXJWZLpUoyPd+BQ6ReZ68x4vTh4zW3MH/84IiqZIzLH21qO5+218p4KampCha8XSJcoL6NI3j8CvlbcLg3OK3KaaiFrOH3pPil0mVfwzWsFhgMeyvSczu1UyO/iXQKOQfB9NDTnOHNx9IG0ijHssdXbOD2ddCjl97uBYEQAzyg1xE4pFvNQVmH/SaDFMCSdAqcS5De/f/Ud3Dm7Q+T6qIl1eCTGKBzyHX1WFu3GhL8A7NHA==;31:vZzNj8oz4trRakppcNDTatBlzYvp4a1Qs1ffZkNH4uc4UGRshUjA4ERJ4QS5I4bagYDXCUWjpmGM6XkuwxwIKU4CuhgiUvBCQejOleEifcK/+NVv1AM4Ly9Knk6DR0UIQvtltmzzF+E1NuAuVw9um/uJeIeKktdl0FYvH2uEnrqf4IwU5Lc0vz96bdihRSxgG2+3TPOy94ndbn1sWkAe+o3JSQo7UEOzsctudaqpgbU=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1142:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1142;20:6C2q4NP9pwLPKtbH0VD2J0h1lwMEsQOfH4aY86Js0I+tm5O7sJOIZotqkSg8/g+qbIQXOZtIXlqT3VO7JCD0afJ+xSWqqYDihPFSlbDC8DGZXZaSQ4o/zWIIjS5H3O0leMPyRN0fxD3y3GzuVwJHQ7x9oTEcGOM9x7pYDGeR3Mwo0LTKtwTykAKB0r86U3HwFMPScN6DLHU69ubaJEE6dkOcXxrfIXg/H9oGkDnEi83DyAhdkwEdzAhZpykjDTggDpvLYo8jpWlbp1tuI60W8DjnfyWVoCS0fKGbQ1j7WhXtDzL+Xm7QFPX7N2+MpB0RO4j3HnFxHmIlaGwH7KSb2djtmaAo/PES5D3IpCvNopXI+AIeFYV4DyLTcbpvdpa5zXFyFPmVLtBflh9LTnUUBXTPcIpMN22CkSWkj3YHb3e4pYqu2jPnLXBFS6RjVdtNvR3Zt1v3lqnnbOs6OSnJ8YAa3jU6lGz7vnGm4shA3hnamPYjWZ7fjD74Ry2psu9o;4:MBm43KgxMZ+wv9+L4SwcwJ8GwR8RymASJFA5nzQgHaHUtVLjpLRcMWEymvOx2814f5RYp7XJroRdyGiFhId6sqiFWz0TDbQnBF2Q6vplsZ+YlGHrCrjBOTFLRLKjUxQVsWN9VWmg7v6Xq0gxho+t6LF0bV1wrr3FJQnOf1spzdLN7pBacrM6TOsIB4kkOLdmm8UXEhAxGmU/Kywm05b/yaffxmakMpFAJxYwupLlhUcQwyyTF/4931J2X/YhCpD15ZYBkY7jk0XI74Be9NO63V5vXjG02Xyw0Y2pqts/+ssZT/q0jqBCexczWbGZgBhz
X-Microsoft-Antispam-PRVS: <CY4PR12MB114292BAEAFA675B070DAD87ECF50@CY4PR12MB1142.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(146755900322472);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3231101)(944501161)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:CY4PR12MB1142;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1142;
X-Forefront-PRVS: 0583A86C08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(396003)(39860400002)(39380400002)(366004)(346002)(189003)(199004)(97736004)(68736007)(7416002)(72206003)(86362001)(52116002)(230700001)(305945005)(7736002)(106356001)(31686004)(6666003)(65806001)(2950100002)(65826007)(83506002)(5660300001)(66066001)(47776003)(36756003)(6246003)(53936002)(65956001)(52146003)(105586002)(2906002)(81166006)(6486002)(64126003)(6116002)(8936002)(16526019)(186003)(58126008)(16576012)(316002)(59450400001)(3260700006)(3846002)(23676004)(50466002)(25786009)(386003)(8676002)(81156014)(229853002)(53546011)(478600001)(31696002)(26005)(77096007)(76176011)(2486003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1142;H:[10.236.65.116];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyTUIxMTQyOzIzOmJQOU1Lc21DTTNnWFFHZmJXVVJxU09SYU4r?=
 =?utf-8?B?Ymt3WExpQVNkdjJFRzdDZ2VYM2gzenFQN1RwcHR3WmpCUlhVcDVpZFVIUE56?=
 =?utf-8?B?OVB2b2NDZG5ZQS9KUFI0eTUwOVJTaVlrUUxDNE53b2xVRThWOUtkRklrWnpI?=
 =?utf-8?B?cHkzSFVpVE13TGg0SGxXQXBUN2tzbXRuZzdPNWdMTXBZOW94bkZrb2FBZ3BF?=
 =?utf-8?B?Y2hLM2o4alplK1c2ci8zT3hPeTRuKzJnaHZXSllRYXJDeGFlRmwyZGxWbkE4?=
 =?utf-8?B?Vm5PKzhROTNQQ20vVk5wZzJuYWtodTNMeGNZblJXSXV0WWRsNUlINzRwblkw?=
 =?utf-8?B?WWR6bFQvTlhOMm5oWjhEZ3dqZDhNdHZyU3JLMHQ4MVluVjJXZk55OUZ3R0h6?=
 =?utf-8?B?UzdDc0RGV1UrSTlFZVpOTWpxSmg1OWlVbHRUTDZ6WFozQWV1WXMwU1BGS1Vs?=
 =?utf-8?B?TEh1akJoNmJjaU1aNjA3SFEvekZzSkVzc3daZFprYVNvQkFraE5PZ2pRT0Zs?=
 =?utf-8?B?NVJKN3I2VW5lN2owYnVxTnlkRGhEZWtaVTZ2UStWWVZUOWJpUXR0NFFpdWVJ?=
 =?utf-8?B?ZDQ5L2xNbTU0UmdqVGJEZVQrejBFVGhXakZFUEc2SkFyd2w0UFJud0FDRGND?=
 =?utf-8?B?anRxZFhudkJBeUJabUk1WmtVTFZWaDVIcjVEaHFhN0FTUFVyMHdsKytqNDhF?=
 =?utf-8?B?ZkZhdEpWOC8zVkJzdytxM25kdzJCQU5ycWpITnRudGdlN21FeXpDQ29Ya2dG?=
 =?utf-8?B?V0JKVFJFOTM5b1dBdjA4RStIaHdqSUlrNTRxelhMSzV0cVVIQURmNGVsWDBY?=
 =?utf-8?B?Z1QwcHNXb2VKUDJrRXJpdnZQYTlaOGo1UDRqL0ViNXg3anFaejgxRnIxZ21i?=
 =?utf-8?B?ZldQcmVRVmpYNGNqV3VxcFRQb1d1NnNZVmRKWkNYazZFS2xRcFZsQ1pSb3ox?=
 =?utf-8?B?aHR1TlNoT3JEelZEZlBKU01mMUxleitNc0dPajdzcnBKdVdhdkxKVFBDaTNt?=
 =?utf-8?B?SS83RWgyYm1zN2hUNjFNaFJGdzRZdmloSmFFSFFGTDlHNXN0aGpETTAwZjcz?=
 =?utf-8?B?WlY3K3dFb096ZDhUNFdKRDhSWk5jcUJmOFpwaDBmbGJINXJIREd5Rm1rQU05?=
 =?utf-8?B?M0Jsdlh0L1JkTHVsSDlWUUV1VDllWFB1MFpkN3F2TEpkYTRiZmFRb2Nqd2tj?=
 =?utf-8?B?d29DSmZtMndRTnk5L09rcmtTTGc3ckJCK1U1VjY3UitLTmUxVkw0a1NIT2tY?=
 =?utf-8?B?L2k1Uk1nRnhhazhqb2xqZWs2bTRveXdBL1dUbjZuRUpheFc5OFYxUjJ4cHFy?=
 =?utf-8?B?YzVqcXp6OGJ6VXhyQUtncTExM1FNMDhWenUxcjc5LzhFV1MwL252ajJaOHpv?=
 =?utf-8?B?WWFwRDFvaHlnTEdqd0FXR1N6bWphU0RrMHZpT3JTdm4xdVNmbmNTK2NZSVpv?=
 =?utf-8?B?Rnh2YWNhNEFibEhSdnMxbE5VcVhCZ0Noc3FLRzVlSFE2TmwyYTh4NWxSMlh6?=
 =?utf-8?B?ZlZWMmJ3eGJtVVBiS2dxMWgwY3dNMkI1Q3hYMk0xQmtZaHFRSktEOFpQQjJp?=
 =?utf-8?B?bjZPZ3B5Snc3T29zdjlkWmt2VkhadTU0VDhob2NzMk41Q0VuelNXRjlKK3RV?=
 =?utf-8?B?Y3FQMFRLa0FXOTRFdlU3RkMzL2hMNS9WZUNtTC9SMXFBQmo5dEszV3JJRThv?=
 =?utf-8?B?WGQ3NWRhRVZ5TTFoMEVxRUJjb1Q1SStCUDdLL1l3VVZvNU9zd0laN2gvc1FB?=
 =?utf-8?B?WDR2RU9WWHJqM1RDZmw1aGhtL1c4TlN2bXJkN2dRTHlmaUdWOG1WMnV6WFdG?=
 =?utf-8?B?MU5oNStuVW1sRXhvdjJub2RsNFNPL2FOMms5TkVhZ3B1Q05JWDhndzZFaTdY?=
 =?utf-8?B?NWJSZ2c1MlNKcEp2elhZQlZSSSt1blR1cG9Db3YwTTA2SnAyblhoQyt5NWRv?=
 =?utf-8?Q?gTZWQs8sBxPTVL6aOd/H8Jusq76BbQ=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1142;6:qo010UUs/AYdkGJ7pkZ8r9A3wVC0nQgCRgZZOxUgTLJPeVBGATpJaXnNrrDwL4YEqrwXmG8SIjscZR0uJes/Y6DKUI/ZczRB0BKEdDKxVJglYlbvJfVQJ9+lEKH6h4sAJQRloGRd7l3Iu2cEWXHyd2YREZvKpD3algtdBaHemkNBghJZp5a6Mzis/4XQRDpE8pyGM3KkfXQ/9YOQKUS93mqjFzxtpvuebQKKKBnAqv/W74KPVtRY/M3Escj8i5zcgbHJN5OT5DP8qdqaCOVllXZVzqjR8AV/tEkZYqnXNDbA6F0VPR/pjn8jLi2IaHtsyZ+BwzUTZGhsvT6bcP3XSLscby35GhTqNZ8mDHoQn84=;5:wTtsytKdXPeqS7jNe7HMkQGzMAccn8NJ46u+5cJ/Ot6kgJs5yd7N+C9xSl7IiTCuc7FQa/APezckfjwkvNbSMqdsXZ2Yq8e/vlYoAhuCgHQ1CodvqKIDbbk7eD5IZKznMzFdQ7W9/UwDTchCSULjFULKTmUt04cIV0WhA5PiROY=;24:lNh9rifM8Phiw/Y7auv2GwW7eYtleuE7JQKZwSGwR5R2Uu1b4PyRQ/iAupkZ+ejOjAbwlzcRdh2cdYNi+UaB3tiVDNaOVcUjz2AKpWsbZSc=;7:eqkOWT/9KwhZ2qu5hrWYfPgr+kDpr6DfHrcetw3iM4kT7NiWW9lknK4lLQxuL9cQuTIlfdIEU/WTMIdXlDyZU7AgbbalhDBw3cr6ksSOE4U9Cnc1WKj0Itlk5bBJMkY2O6FbxBVMF/OFzRQkzMHd3rE61YsYUWUJ9xPCuvxFeilOUizVtQ5EgL013dvgcghmyE3b4gjX4qmR3SgHCX+vvwDEzdRfNOiBUqC4EHFIGS9Bqw6Artm6nuyRNyFuNR46
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1142;20:byW8NKd/6uFHrvTQ1lB2AMe5bM7glS178DthyiDCMFhz6C62Eiq4cNuIAeC2dSPKWYnJvF6RTXvfxchd32q1lmtQtnUufWl1vpyNMwQlxu1J6ug14g2+YVARFreVqyZXs6Yss9k+YsGDMiNlixlUUYY4P8/Cor+Nt789nvcZJhMPm28MeW0lIayRlIvk9AWxFjh4ESqTzVWvklXVkeroLTzb3ZZTNa1UF7NM5XQyohQKiiQr4DpOSVplh1ojoIT8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2018 16:07:06.3402 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c70b6b7b-94ee-4f92-2dfe-08d573c4fef5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1142
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/2018 7:44 AM, David Woodhouse wrote:
> Retpoline means the kernel is safe because it has no indirect branches.
> But firmware isn't, so use IBRS for firmware calls if it's available.
> 
> Block preemption while IBRS is set, although in practice the call sites
> already had to be doing that.
> 
> Ignore hpwdt.c for now. It's taking spinlocks and calling into firmware
> code, from an NMI handler. I don't want to touch that with a bargepole.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  arch/x86/include/asm/apm.h           |  6 ++++++
>  arch/x86/include/asm/cpufeatures.h   |  1 +
>  arch/x86/include/asm/efi.h           | 17 ++++++++++++++--
>  arch/x86/include/asm/nospec-branch.h | 39 +++++++++++++++++++++++++++---------
>  arch/x86/kernel/cpu/bugs.c           | 12 ++++++++++-
>  5 files changed, 63 insertions(+), 12 deletions(-)
> 

... <snip> ...

> +/*
> + * With retpoline, we must use IBRS to restrict branch prediction
> + * before calling into firmware.
> + */
> +static inline void firmware_restrict_branch_speculation_start(void)
> +{
> +	preempt_disable();
> +	alternative_msr_write(MSR_IA32_SPEC_CTRL, SPEC_CTRL_IBRS,
> +			      X86_FEATURE_USE_IBRS_FW);
> +}
> +
> +static inline void firmware_restrict_branch_speculation_end(void)
> +{
> +	alternative_msr_write(MSR_IA32_SPEC_CTRL, 0,
> +			      X86_FEATURE_USE_IBRS_FW);
> +	preempt_enable();
>  }

Shouldn't these writes to the MSR be just for the IBRS bit?  The spec
also defines the STIBP bit for this MSR, and if that bit had been set by
BIOS for example, these writes will clear it.  And who knows what future
bits may be defined and how they'll be used.

Thanks,
Tom

>  
>  #endif /* __ASSEMBLY__ */
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index d71c8b5..bfca937 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -300,6 +300,15 @@ static void __init spectre_v2_select_mitigation(void)
>  		setup_force_cpu_cap(X86_FEATURE_USE_IBPB);
>  		pr_info("Spectre v2 mitigation: Enabling Indirect Branch Prediction Barrier\n");
>  	}
> +
> +	/*
> +	 * Retpoline means the kernel is safe because it has no indirect
> +	 * branches. But firmware isn't, so use IBRS to protect that.
> +	 */
> +	if (boot_cpu_has(X86_FEATURE_IBRS)) {
> +		setup_force_cpu_cap(X86_FEATURE_USE_IBRS_FW);
> +		pr_info("Enabling Restricted Speculation for firmware calls\n");
> +	}
>  }
>  
>  #undef pr_fmt
> @@ -326,8 +335,9 @@ ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr, c
>  	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V2))
>  		return sprintf(buf, "Not affected\n");
>  
> -	return sprintf(buf, "%s%s%s\n", spectre_v2_strings[spectre_v2_enabled],
> +	return sprintf(buf, "%s%s%s%s\n", spectre_v2_strings[spectre_v2_enabled],
>  		       boot_cpu_has(X86_FEATURE_USE_IBPB) ? ", IBPB" : "",
> +		       boot_cpu_has(X86_FEATURE_USE_IBRS_FW) ? ", IBRS_FW" : "",
>  		       spectre_v2_module_string());
>  }
>  #endif
> 
