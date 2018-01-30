Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753850AbeA3WwX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 17:52:23 -0500
Received: from mail-by2nam03on0059.outbound.protection.outlook.com ([104.47.42.59]:22977
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753615AbeA3WwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 17:52:21 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
Subject: Re: [PATCHv3 0/3] x86/mm/encrypt: Cleanup and switching between
 paging modes
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20180124163623.61765-1-kirill.shutemov@linux.intel.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <830ed299-53a7-f357-9301-5b6577d55f30@amd.com>
Date: Tue, 30 Jan 2018 16:52:13 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180124163623.61765-1-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR14CA0048.namprd14.prod.outlook.com (10.171.172.162) To
 CY4PR12MB1141.namprd12.prod.outlook.com (10.168.163.149)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 938b7d9d-1f44-4c6f-a782-08d568341dff
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:CY4PR12MB1141;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1141;3:+IvGSlcW0rpNsU3aNx0IvBr+rRsikKULnKEx2ISswQx0xxZib2n9wuAzFrtcjjYnq2WJWa3naELkOze9FyxG6iFEr609wXGNUVhTToGoHMmW6Huxqy1zcZ3A8ni6hI784WsTZs0Bo5K77aFuHPmMFzqZywspJKmbmaVBwCzd1X7lTvGN1Qf9snSQGF9/22pUVd0gTbecjrQHLHa1wmjeTTeOSMyo3m2Zl9bc/Pupds6xQ+zgBe5/eALdkdbr7ro/;25:RCffJu1duwdGRdUIUvuvIOUsvixXEjgSp58F1bFGK20lA3f2i3Zyi3pDwvBN3v5rVbQ3gM4hiwxyFqV1LvJJWms312KwYUCxepm5yrX9OnDXnJgIiBfMwEmwooo3zi2fvDsxoaHbtlEXzJrgHlWc7QUwCmQpyzlKj5k6HyfBQcLGSWRIYybUcY3bP4p+gEvYchA1paNNKna95SQ5Ynt8SATcAAi+ytUvf8UPpfTizQbECh47aib7Y3oCtEbOrpejfzHIPhPo+a3pwl18P6WcIgQ2pBJQdtgkjny5h8v9WpbxUuRJ49ZOEl1HpNgRrwrlqz6FUqVmtyHQCsebSQldXQ==;31:CFczYZ7KGdxwcgZ5bmO8fGZ+mpfYM9Hi1Ec2rlaDy6b9sqE8DObgivO6Aa26oNxN0J1/imoatsvr1THDviNWSTR29xrTm3YAh9wnIkv02L5zSaeo+p8GPOiFrwT22mjQ9UhczWUbQoUUJQN+mA/y/pfJm2RaKZd5MUEKfrGidgnW0xPBKH+WDZLAsWRPcRy7Rr0r2HMGeQY95+BaxzJGFFRKn3uiKP3emTZ0nCJcb4M=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1141:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1141;20:+vPh3eSFbNHTuCtbaSF4xBefohDZVEeflSWXKCGrV1pFHYgWH+zHW6OPlQ82nVJJySlX+8P5aQ9a22mW2RKE1N13sZSRvegdoRYMoMovfygNJkqUksrrVRZgIMNGjt3pO2lt3D2TuUyRJB2W2vXCN1Vxl8YgeWS10GqBdAbyrGFECkN0qyrX38wBLqsHV3PpAMCBEo4FNGmdvsyWQrAzfqfM8gLU9SzjkbhUygndyZgyI9bSsNR0Wp66ybQrwgBHEjBiuZKLgWElfUmXcmT7rBiwTYTNEqHEhY6RdkidoHEcv3pxflVgnRvnnzX9ehG/B1WRdRkFPKxy/32KX6CznOf6AN3fUrzaCXQKg2k9vpPUaO+lFt7TqKTLmfkZf8aQC6ROOhy5k2PXSTFeq7iGpqWwPB0qfZyW5VcogPs9hoQZkfjmLx93wFa0eg0dFAJlA2vYcZRQhXjPSuZ+kZzLtzU/dSnzxrr5SW+1NeE4ZcFZJj6Vtg7hLLkikB5G+Tu5;4:TfhkofHhjL1k/A5GDI9PBNbhzHGW8/r8JfUblTyQXqPH1xW4lRxsUbmWityKNtLjVoQbKmcY7yczPkv831OMuLYtWWliPSR+WnZkl9yQhcUoiRf1gK4DZW97sELCNVaO0gYQxXxzp3lA2v3QRcvJZjHoYMbkqbaVTpNFf1aBFsTDn0/3h28OS80CrGCjDGLc1xxPEQDxXC/SNXH/tKBmWS3LZ+bEql4B4iznt4Xd5xpcn06VsDCD68d0ElPjAWO5xnJDIyxBGLXFgXaRzW9yB0nbz5t2s057BvroUrHJJERx0+k/kP2ryXo2+Y976S0E
X-Microsoft-Antispam-PRVS: <CY4PR12MB1141B754151C371B1B412436ECE40@CY4PR12MB1141.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231101)(944501161)(6055026)(6041288)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:CY4PR12MB1141;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1141;
X-Forefront-PRVS: 0568F32D91
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(366004)(39860400002)(376002)(346002)(39380400002)(189003)(199004)(23676004)(52116002)(386003)(53546011)(58126008)(31686004)(77096007)(76176011)(52146003)(16576012)(66066001)(65806001)(2486003)(64126003)(65956001)(83506002)(25786009)(47776003)(97736004)(50466002)(81166006)(6246003)(106356001)(316002)(3260700006)(81156014)(230700001)(68736007)(8676002)(26005)(72206003)(36756003)(86362001)(8936002)(6666003)(54906003)(2906002)(4326008)(53936002)(305945005)(65826007)(5660300001)(110136005)(2950100002)(186003)(7736002)(105586002)(90366009)(3846002)(16526019)(229853002)(6486002)(31696002)(6116002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1141;H:[10.236.65.116];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyTUIxMTQxOzIzOlZFSzhQa0h6WTIwNlVjY29pSWttTVNnQzU5?=
 =?utf-8?B?TFl3bFBRNWZlREFaMFI3ZkowR2FXR005K1E2MmVKVzhmbjFuWmJQVHgxbnM3?=
 =?utf-8?B?VjlRY3BwQzBIYmhrdkhqMjN6TW5JcDRzWG9RMFRqejJJaU95MUFUYjNUbE8r?=
 =?utf-8?B?SEJjTkI5SHRTTUUvSWQvczd3RjRPWjdUMjZKdnpEcE5BQUpyYWJ0V1BwQytm?=
 =?utf-8?B?SmsyL3JoVUFMajJwQ0tRRzBVeXA5b2VpZUN2YWhURi9ld0xucGk0ZU9SeFFL?=
 =?utf-8?B?WkUwc1hhTEkrenUwaHlLTU9FWU5SNEp0Z09LKzhEMkEyWU5DTGJHSjlWa0VL?=
 =?utf-8?B?d0tYRlZObHNlSGczL0pQMDl0TDMzYzBjRlJZUFFrRjJTSnJ4UDZxQUVOYlNj?=
 =?utf-8?B?Ymk4MFRuR3RTSHhTUnNIWll4c3JMS3Qxb3hPRURkbTAzTVp6dmJJSXpYaUlU?=
 =?utf-8?B?emFBK01oUUpadmp4a0JGNmpFT0tPWTlySnRKSW04Q2N0QzVnWnZoVmpBbFNw?=
 =?utf-8?B?eUQxdFo2V3JJaDZuK3g1SUhUQmFRNCtGNFdUV1A3bnRZZm85TEdJY2VFMjJG?=
 =?utf-8?B?ZmlISWhVRjhsdHA5UmlRM29GNEpxSldBMGxzbzJyQ3hUWTFYcVdIV0lvNFVs?=
 =?utf-8?B?TlY3L3NPLy9aQjV0cGhrZTZsalJEaEtOWmdOaUNMSUVZSDdSSXorVzFrOTky?=
 =?utf-8?B?VmJ4YlU3SHV0ck9ic3RGcTNpQUtuTDltVndudCs5SUo5VUxqc3R5ZGlWZkI5?=
 =?utf-8?B?T3F4WjU0NjhrMVFyNnVxZ2NGTlMzSklqaWpSUDdwWWdhcTNqdEJ2SmFQUysz?=
 =?utf-8?B?SVJSeDF1T2FTWW5zejM5dnJKcDVPN2dEbHVlaVViVmVqOFIyeWdyellyYVp2?=
 =?utf-8?B?MDZtLzlvUG10d0pCakIvTXd3dVBPWlVQODVydnA4Ym92dlRHODdZWUdmZkFP?=
 =?utf-8?B?alA2QWRaYWRJdE9wT0RLNmUreWw2SHNQNU4wbDgvNEpDNU5ZRklVdTJObmVj?=
 =?utf-8?B?QjV5dkdxaC9CRWRFSFhKMlRPOVVLbDNpVzhYTWNsVzhVMUJ3TjlyNFBvcnA1?=
 =?utf-8?B?RnJ6VXpBUVI2YTZIN21va0trWmk1NG9kckczM2lidDlWQzJqbHcxNnIwczBq?=
 =?utf-8?B?MVhVL0JOVzNjVmxYeTlLWkRvYkxIbDRBalJNd2V3aERudFhMcHRvaW53OW1z?=
 =?utf-8?B?aVFYWW9ObVoveVlFLytwVVJLS2QrQ284b1IrS2Q4RHloK21NNmpwY3J1aGlD?=
 =?utf-8?B?M2xwVnJHeWlWa2J5RnNtcVpDa2dLRW45SC9ZcTFDWktHbDBZeHNOdXRyU2ww?=
 =?utf-8?B?aVJvdG9OdXpzZlQyQXVycXdpTFd3Y3NORUxFdDVjdEh5aU5KUTF0dDFHWENP?=
 =?utf-8?B?S3lIR3lRMklTUXg1MU1iZUt0NXk1ZU52YzFmV1F5S28yaC9BN3VHMjFPb2l4?=
 =?utf-8?B?SWlZNXdhWmdsb1hERm5kWERoZ0JlazdlWDhhRzZSRjhlMENobEdiTGdDckZQ?=
 =?utf-8?B?VnBDMkhFcktKUm5hTkNhR3daT21QblFIYTV3ZzZ3aE9CNG1rSWlJZHFPcEpK?=
 =?utf-8?B?YmVhTStKVE5BcVZGZ1lsVko2Si85eGtENTA0Qitzd3locjl3THEzYzVVdXRr?=
 =?utf-8?B?eWg1R2g1cU1Od2taeGFoM3FkY3ZkMXpvclB1VkozOTVKL1JRTXlxV3JFZGZG?=
 =?utf-8?B?UDhzbmo0SXJzMWJSTEJoMWZkVkNCczRlSW05d2RoZzZWMXVQTEdmSmpXSFpz?=
 =?utf-8?B?K25tcVE4bVYrUUtHRE5GNGs2ZjJKZXIza0NDTnA3eEFxek11N0NtTjVVNnE5?=
 =?utf-8?B?TS9QSHdMNTZRcDBGQ1B5cnpnbTI1VWZ5UzVyZFA5KzZrTUdxYWFwYVd3ZVRT?=
 =?utf-8?B?TFhNdFVwOTZub2I4aDNVeGNySHJTOTQzaXRZN1l6K1BucHAyME1yOHpWWHg5?=
 =?utf-8?Q?hziSR8cw7PG4oE2TOv2fxeMXK6uI4s=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1141;6:mHb1/oB1EuldDE/rvsaUCVOTMlPoX9dxfLzkPaFbh/lv6I8pTmAeKe1aJ8s4nfvTxaqaE0yG3nPy/c+Zn1Z5Q9tIb+3pXOSQ+EO+9sjTEwR19xs5BdLPxCYbPsitxLKgzONWwSpCJ8heiGS0wgF2wBEXpeMtp9rdECBNA9NnhjOt4q6ByvVr0w0gNpSYNBPzTGSb6YAkqWp7t8Lt2/C9I5lYWC6o90T8O4OQ/A8t839g9Y6it7bDqqkjpHG51IJadjg335RbQdggUbyG5u36UPgYWj3UJ1RlMdIqRtcuPdFlE4pUojiujBI8j0mrMuZP70duocC6rGY4yl32mbrtSUHjgd/er2GQ6k3JrKY5HoE=;5:tTtRDZf/46uXyuoLx0Y2WeXovmgwhF6yjqX4pQFPKFi0+qKTTnhxAiTtdUZxUnGRT73qekzXaEdUyzW3o9FZKZ71jGddD6XN0AGse+i7ZVL8GNLgQtrB4QdfZLjfpCt8fbCxN9TbF9Q1tGQ1uU6MXQNUP4fuYZ1dP7BtITIDSG8=;24:3lYLbAPKBdLQoeyXL0u0Cvdy+EvdZCp7t3Rgp4XawRG7O/HDZPqlFQYfrosaBFsil6G5iFaXwYdDpEkhwuWY/i2X05/jCrMlfjexuS70M1E=;7:ioCEcDox/EII0Vh103IWOp8Iv332bx27DzVjFdwq5OH2yNLEZLj9psws6x1IOEk6+MNcIiKOkSQsaH6RrGBXIS+PYZgq12cMMzHU9wspUVYVmsiruVVyHxmX2W/+0UilCll0YDtigK+G39O3/Fbf8/pbvKma9hQnxW8fKj89FYRQr+d5T0cRiv6a1l0lkMiYM9C1EI/n1s+5BbxVI4uZ7rI+A4eb/l9wcxzpg+F6Lchq/vzKML4Jq0SCyFViYxUt
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1141;20:TE/dYjfiEpKSVVXD/D8J1xDgQe6fET+lI51BvGcmnMe7kuXyAzCyj685lSm+VcjRVcdzCdZnw8wtEW6s93rIEMJJRTp97+/3xGcx+BxAUhz0PqH2Q3HOUZudayObivYM+vHWSjws/YG8zaoe8gkaFsVcrQxtFolLuY8hBmMzQJqcqSR7lyjTOW+GvRYMe64DwgSbp8u1i4lNiZN1eowwcctWnlDydiVFvsI6FdNH4BqN8fmcRGDTUo/3RVgDZZWL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2018 22:52:18.0706 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 938b7d9d-1f44-4c6f-a782-08d568341dff
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1141
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/2018 10:36 AM, Kirill A. Shutemov wrote:
> This patcheset is a preparation set for boot-time switching between
> paging modes. Please review and consider applying.
> 
> Code around sme_populate_pgd() is unnecessary complex and hard to modify.
> 
> This patchset rewrites it in more stream-lined way to add support of
> boot-time switching between paging modes.
> 
> I haven't tested the patchset on hardware capable of memory encryption.

Tested-by: Tom Lendacky <thomas.lendacky@amd.com>

> 
> v3:
>  - Move all page table related functions into mem_encrypt_identity.c
> v2:
>  - Rebased to up-to-date tip
> 
> Kirill A. Shutemov (3):
>   x86/mm/encrypt: Move page table helpers into separate translation unit
>   x86/mm/encrypt: Rewrite sme_populate_pgd() and
>     sme_populate_pgd_large()
>   x86/mm/encrypt: Rewrite sme_pgtable_calc()
> 
>  arch/x86/mm/Makefile               |  14 +-
>  arch/x86/mm/mem_encrypt.c          | 578 +------------------------------------
>  arch/x86/mm/mem_encrypt_identity.c | 563 ++++++++++++++++++++++++++++++++++++
>  arch/x86/mm/mm_internal.h          |   1 +
>  4 files changed, 574 insertions(+), 582 deletions(-)
>  create mode 100644 arch/x86/mm/mem_encrypt_identity.c
> 
