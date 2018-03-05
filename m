Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752848AbeCETlO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 14:41:14 -0500
Received: from mail-bl2nam02on0057.outbound.protection.outlook.com ([104.47.38.57]:1576
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751462AbeCETlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 14:41:11 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: Re: [PATCH] crypto: ccp: Use memdup_user() rather than duplicating
 its implementation
To: SF Markus Elfring <elfring@users.sourceforge.net>,
        linux-crypto@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
        kvm@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <ccd82e60-ba87-d224-3662-365662fa4e6e@users.sourceforge.net>
From: Gary R Hook <gary.hook@amd.com>
Message-ID: <f4ab2412-04ec-738a-0e82-65f4f4fb9bb3@amd.com>
Date: Mon, 5 Mar 2018 13:41:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <ccd82e60-ba87-d224-3662-365662fa4e6e@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR14CA0029.namprd14.prod.outlook.com (10.171.172.143) To
 BY2PR12MB0694.namprd12.prod.outlook.com (10.163.113.16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 44820a76-2ec7-45fa-ae6c-08d582d10af0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:BY2PR12MB0694;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0694;3:hwjlQO9NCSSqKXdzar/mGcOJaYqMtik9EYz98KO0Kwky99E3sOCU+KzXKKtffBqPpAuChAAVh8hgrKOd5WnKU+7ZVKRGV75N5L5AyLLg4v4GOvcvzWcTQs0sSKeJJF0NaKP7/ZgYjc3tJfr1M2M9PvBKBRnKuohFYLh3buirDP1Lc5AYpQEqqKsdqqE7OovReXXCHdP8WCwOhotDT1A+BSCKfB1eO67c19mrES17lmKbqfPzyniluQ1DCvqqA96+;25:w9ekO3n6dsvXifpKwc9be/PjzPqoOrZmuoiDTDPPmmDvpBZmRFe0Vt76yDqBZw1nY5lrFO4OsU+gnqcH5qaJ33aVbDzUbHKHO9af6EfcD38rw1cGVi9b86pP0T8xxpyVY5y7Z9Y39shJqz07v0Fh+X5tW+HDBekAbOCAP/vgIbtHj6c6x3WLo7KCZCS/G25yY9ssORPF39yQjZLOkT02ZmVOf7nlxPZ/79Ta2dfUx7dwgvRajTibNnFtFfGnPHwWfQTcIo61iPo7uUyz/DkqaAX6jbvIoXgU6VpkfYzLzyXtsAtNMnC32l6NVLIJtqWRgIbmDTZtjP64WzKEVpL1ew==;31:55UWLB7hmiB8mZGpTuruvUz6x4s2JgWQVigT+IDjwnGVeW0wC+6pU1nQ6cCU1cAbmGeiUmNzAcpju/8FnIjyb1/S5x7FWURr0uFAdVzot6x7fj5flkVZY+uMvh4IYlsYRVuSGg5J9kHetx1TMBvyvEPpf2/y3QB7UnxRELJ29jXG+zMvCmOy8uFqnb5AxRTMEkqu2YDMwlgQS7ZNb1BJXYPTJSt5u41TzqZRq9mq3f8=
X-MS-TrafficTypeDiagnostic: BY2PR12MB0694:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0694;20:70h2EXTj+6myboXyx/cWN5NGgVer86EjC2Xbmq9wMuiSnioeRx6cTPt0yYY0XFU9APa2Zw58/mAMt5w0t0AM1fojtBUx2kPhcbaSeF26iyLl+PtZnX6y/f45cHAE+bdhMTYx9SJ8c7EhtUervhlJvBLYpltPQsT38nB+jzfL9Yj9W1CpSu+ygU2KfSiKll0iK0DR8v0SEMveyM5HnGin2Sz+Omh9TNAPzKcXtxfY/N3ySG01zUSZEcJAD+EcUV88tFZDSxDE9EPEWq82hQVG9sL68j9QqxJLtevqBWwy4oDz6hAikdqyCB4dX9TBLSqqEziqp4wuEtSlrRRVxODOuRrq1Q/4xq+tMRNIBYrHC/WiRgE5G79s3DwO4xQShi+28gokVn69YMdRoFJ3dU222gSHzAQodxR/xi7Gj+IAyiW8SNXoJjCfue0llPNOOf9USuqwmblYrqE+PgY4pEsMtMqmsHnlwZQ6TIN2vGIgBGUEkK1n2t8afHFGgqidEQss;4:a3N82MxPl5zUMfiP1k9gIZ8IBMS8cF6giKG8wgA4T9NdN4DBhvvPaE+UOgNer7sGryaUVp7D/tSLZ8ejS1oZOVKv/78onH1RBCYLvI31J9O0zytK86hk08hDw9Q5CxfTG8DXmmRp0YDuAVCU7v06zQvNGdOzHq09vlPXCDV2sHOe5pKYUeGDLY4MPT5kg+HtrKfQrJYfUOzTO/Z8HWOl8DvX5UPOXxnpREZPSPhSrQwHJjwcw0v8ZzObTMMgsve9wi4T6ahjqyQm8thCMXHyNGuy7hQBEDEkSEqxUs5enDhWKhAvrx2UnfVxXAveYrTB92Mp7MYjGjoUMdgF4/gaCw==
X-Microsoft-Antispam-PRVS: <BY2PR12MB0694296FD406AFEADED29009FDDA0@BY2PR12MB0694.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(42262312472803);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(6055026)(6041288)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:BY2PR12MB0694;BCL:0;PCL:0;RULEID:;SRVR:BY2PR12MB0694;
X-Forefront-PRVS: 06022AA85F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(39860400002)(39380400002)(396003)(376002)(366004)(189003)(199004)(31696002)(97736004)(3846002)(25786009)(66066001)(6246003)(386003)(2906002)(65806001)(65956001)(90366009)(47776003)(105586002)(7736002)(4326008)(16576012)(77096007)(72206003)(478600001)(305945005)(106356001)(16526019)(186003)(26005)(316002)(53936002)(68736007)(53546011)(6116002)(31686004)(65826007)(6636002)(76176011)(36756003)(2950100002)(6666003)(8676002)(64126003)(8936002)(2486003)(23676004)(52146003)(58126008)(52116002)(229853002)(6486002)(7416002)(81166006)(86362001)(230700001)(50466002)(54906003)(67846002)(5660300001)(110136005)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR12MB0694;H:[10.236.109.62];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjEyTUIwNjk0OzIzOkRpNWhqWUU4Y1o3b3hIZ0ZLNmh3MUZvMTls?=
 =?utf-8?B?ZGVxMmM5bkw2UVlSQVJhdllOOUZZQkR2Z3Z6bjdUTnhlZkVHeldNZGdqeFI2?=
 =?utf-8?B?ZGhEeGJUY09MMW5hMmNTWnRsa1JTTGVnVlIwS04xeHhKSjIrQlVTbkpPK1BE?=
 =?utf-8?B?OHVMTVFtQUJvZjErM3lxYUdsd0tlTE50ZUwvYVorRDVvaUtTTFIwWlZjTzRv?=
 =?utf-8?B?MkUyQUIrZVJJUUZWcXFCa3V1NVoxUm1KUU5zVytaQ1A5TWpTcnFQWXJOTUc4?=
 =?utf-8?B?TmFWYWRoZHpydlhJYWJRNmtzNjZLMk1DQkxpWGNabkJhNGQ4WENlZi9QUEpJ?=
 =?utf-8?B?MElHN2pwbnRoYlN5U2V6Rjd4akNRN3I3dTNMYXlrZTdmOXV3Z3R2VE41Ykxq?=
 =?utf-8?B?SHdPbEY5WU9id3ZxcGZtUGlXWUpwVWwweU1yYWF3VTlCS2Evd3dWTXhNRFky?=
 =?utf-8?B?US96MDhLVE5BUm1GVjFMOWVWbWQ0cHI1RzYxT1VydmVLRWdsQitHS0h6eWph?=
 =?utf-8?B?blRCZTczMmFBVGE5SmI3aUVaRGVnNHhWUS84TXArZTNWdVBpZmIyemhOYWlP?=
 =?utf-8?B?SFBpTEhIV3B1NWs4Y0tYejhGVkN2ZGhVaU1Tdmcyb2x6L0NhNDZMSnVEb3E2?=
 =?utf-8?B?MzFXNDNONm1wb3lsQXFYVUJQaVdwYm1LYXFnL3dXeHVqSjB1Tlo0N2FzYTg2?=
 =?utf-8?B?NWVJNzYzVWd6MUJwdTZQVmk3OWhHVXB1YVZsN2pXZGFtYk1NOXArYVR3dUIx?=
 =?utf-8?B?VlNwVzQ5RUtvTGtxRkZyMHpMUUNsV0d5akM2SVVTaE15K3pPdVVFQnkvM09p?=
 =?utf-8?B?UGI0V3B5RnJ1a3dZUEQzQ3RCTlhOWnI1TlJIci9LUmRUdzN0U2lYVjNaMU5K?=
 =?utf-8?B?Zm41d3R2NVpEaWJ4citBQmtrSzVac0xrNjA0M1E0N2VHdWdMQUk0ZHA4eW5j?=
 =?utf-8?B?dEkxZUZ4UnZFOHZnTWp5UmtiZ1YrOTlrRGJSSksxUkFlWkFzV3ozM1BtODF0?=
 =?utf-8?B?WjlxMHg1NFJyby9EYXpLSWMwTjAyVjd6alhHN292Q1lrUlFxSGFLUWNzK2pY?=
 =?utf-8?B?eFNRY1pWNmdISUYxQVQ5SVJ3Tmd2ZFpGQlYwd0lqSHRGVEhaUmZ3RzlqKzdE?=
 =?utf-8?B?NlgyeHFwQUNsNk1VbmhaVEY3T2Z4aVdkNmVOVEwwTjdLQVN3ZnVnUk93OXFj?=
 =?utf-8?B?b0xBTnpVZ1ZZMDlMekFrZ2ZQeWliZE4xTFZDMktzWWhEbE1CQ3dqRnMrSjZo?=
 =?utf-8?B?TlZwdXpLbDByeWNyTDk4ZHNZdC9Hem5JLzFob3MvSXpiSjJkcHR3YUg0M2NR?=
 =?utf-8?B?K0ZHNlVRNlNXbmRSa2dLNUxQdGFvajg3SExLSTNSU2VuRzZpTDByTlU0WlNJ?=
 =?utf-8?B?L1A3aUlxaEVCbXB0V3lKKzJCZW4veDA4UjBNdGFzSGNSdklPRWV2RmhWWWU1?=
 =?utf-8?B?d2pNZVVjOTNhaXowRUNkUStwOFcyNW5uRHc3dDlNcGNDL2pkMXRxd1VySng1?=
 =?utf-8?B?alJldEcrdE9pNVpZaHNvWXY5bTFRTytTV2hOTHgvMmkvUnRsRkFERzJFNVJn?=
 =?utf-8?B?aDROUjZpdytwNG5iZXQzK3c5aHFqSFBQN0NmbFZFcTNZSjdLQW5iSUhMby9D?=
 =?utf-8?B?c2ROdy9qWkluYk5lYzBFRFVUUFBxa3ljcGJIV0JWTlBaODMydFgrMGlmRTV1?=
 =?utf-8?B?S0t3NWZUYTdHcS9Wa1RWRmJZT2RaU3Eya2tYVk1HOGZZVFNxWGVYMGN5TGUw?=
 =?utf-8?B?WEFYOFhwYUNRQkdTZkh4cjN3WDBhcmF2a0pLWXlaME94ZGt4cTlFL0YzcGlJ?=
 =?utf-8?B?d1U5TGpIUGIyZUtGd3p6U2hxSmZ5UXB1NzkwVS81em1HaXJUQlY3RmN2T2tp?=
 =?utf-8?B?TFcvVm1iUE80RFdsdmZLNk5CVm1qUVEvN3lBMGZ3UnlsT0NTcCsrcElQVlVu?=
 =?utf-8?B?V2c1RmNHTTE1ai82UkNiVk9YWlExOGtsMFc3RkZPK2lEVitpSUR2bG1CQVBS?=
 =?utf-8?Q?siZ1Wq?=
X-Microsoft-Antispam-Message-Info: 6X3WyMLcaqWFcUfixXdgjtmDwRDoddU5KqZZ+4zpSeUJ1aEf4RQym9HAaTs3MjG57Au9drHtZCP6lO+5X/OtpxA54gfa4neimxGCX95leITPwhTs6vDnXfWmUDDN8hOEFPmpC+z/IBtICqUXJ1dgFP+5aSDJGA1ebwCrCyuFluGpH8g/EWN9N6ihEOF6FaRn
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0694;6:JOdhXEYssW/Lk0hT7XXG55Y5QYF5Z8BqKFo/H3RswxbAYyi/uARgE4PheW61lVpzlKOcEz/pjME2084QykztyhYuKVOvdOSeys3uzBAHkzl0OCKQDjbLa5vBWOz/pmbGjIqaHUaa261DS/Qbpx/C10iK/05ybFnuObihVkVN8YGrU7Q2R0crQP5mSaht+hhCOmjxxUknAzkhT/ZH7C8jvQq8AlLV2AROEg45xt45nMROJ2jF8GMaXePveFZtRec6Jqb6569HU+F0dH14hx44FiyLOKHoLmJucZz568Z1zXb1g3DaqdONmC8Hjxnid561Nn5d42sSA/2Vgbe0sfv0xRRj8+z9wGZqcADEzmD6Zig=;5:oQ18IeGgbs3oPTU38XLbyDlHyfNtFAFca0CFxl7oo7zxC2ZhU4Z3DuTP0wsHSBuukMhv10nTub7/hCOZnC2hvmyJEXocJts/DACW2lfBlsn++tFVJzuwoL+WgVnUZvly0JKbjZGlqTD9ATSmuknDslwS+FTz3t6JRNF81BfF0N4=;24:o6h+PtK2sPqYh2ya3mUwwRH6hwA9kB+nWzbzwhQrQClIRlIaflfcbJLY+d0D1oeejFqH9ftBfzj+POQZhkEXwfuviESJJGvUEySr8M0kneU=;7:sjW2R9uLVVHCioPLbuasc8NGNYhciVZM5KYlbkjQyGTO/0MT61WwbX9R3BVH2Z61rWmQV73mbmc5TyJTg+jM3KEiPEmy80M8VJr/5cJ1/2q9TrEI2dLzpEj8pN+N/xjRvbUkPLsBay/dhBc2bghuHb/umQWx9nFOn2nioD6ohb3JAbMBt2ysHTrld2ViSdUt8t1ovTzRI4+7zC2JCq5kmJ23PoFTBQaGCZgwZjQzM/BV0QSqby9utg2M2Lq30DSN
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0694;20:CU+5st4ciSrPyrmtWf7Val0MSicsgshrC3Zzd411oL+2YetlgfbN8CLzzrqdrWSV6ZmEfSplF76toNVjvIHDaDHIUOByswD7uQocebwy1NYVwnenJ8LvsilHbk1XYle1TqK7iVxOZu2AvFFMR5ZOugUeOY6ofKcmJ2DINQszC/3dnUZpDSEHWNwUp7cO4B6B4K78v3cJM5SVwOvXyi4k2DamwAgj9ahFq2XH4RTNSJvxmzLA5ONHXSBQUjNTXl63
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2018 19:41:07.1082 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44820a76-2ec7-45fa-ae6c-08d582d10af0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR12MB0694
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2018 07:10 AM, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 5 Mar 2018 13:50:13 +0100
> 
> Reuse existing functionality from memdup_user() instead of keeping
> duplicate source code.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Acked-by: Gary R Hook <gary.hook@amd.com>

> ---
>   drivers/crypto/ccp/psp-dev.c | 15 +--------------
>   1 file changed, 1 insertion(+), 14 deletions(-)
> 
> diff --git a/drivers/crypto/ccp/psp-dev.c b/drivers/crypto/ccp/psp-dev.c
> index fcfa5b1eae61..8255258cd040 100644
> --- a/drivers/crypto/ccp/psp-dev.c
> +++ b/drivers/crypto/ccp/psp-dev.c
> @@ -367,8 +367,6 @@ static int sev_ioctl_do_pek_csr(struct sev_issue_cmd *argp)
>   
>   void *psp_copy_user_blob(u64 __user uaddr, u32 len)
>   {
> -	void *data;
> -
>   	if (!uaddr || !len)
>   		return ERR_PTR(-EINVAL);
>   
> @@ -376,18 +374,7 @@ void *psp_copy_user_blob(u64 __user uaddr, u32 len)
>   	if (len > SEV_FW_BLOB_MAX_SIZE)
>   		return ERR_PTR(-EINVAL);
>   
> -	data = kmalloc(len, GFP_KERNEL);
> -	if (!data)
> -		return ERR_PTR(-ENOMEM);
> -
> -	if (copy_from_user(data, (void __user *)(uintptr_t)uaddr, len))
> -		goto e_free;
> -
> -	return data;
> -
> -e_free:
> -	kfree(data);
> -	return ERR_PTR(-EFAULT);
> +	return memdup_user((void __user *)(uintptr_t)uaddr, len);
>   }
>   EXPORT_SYMBOL_GPL(psp_copy_user_blob);
>   
> 
