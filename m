Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934851AbeE3Fah (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 01:30:37 -0400
Received: from mail-ve1eur01on0064.outbound.protection.outlook.com ([104.47.1.64]:25759
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932557AbeE3Fad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 01:30:33 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com;
Subject: Re: [PATCH 2/8] xen/balloon: Move common memory reservation routines
 to a module
To: Juergen Gross <jgross@suse.com>,
        Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Cc: daniel.vetter@intel.com, dongwon.kim@intel.com,
        matthew.d.roper@intel.com
References: <20180525153331.31188-1-andr2000@gmail.com>
 <20180525153331.31188-3-andr2000@gmail.com>
 <b838fcb8-fa7f-5d75-d536-4dca47bd20aa@suse.com>
From: Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
Message-ID: <3d9360c5-5ee4-292b-3787-fc4d4cfc9cc9@epam.com>
Date: Wed, 30 May 2018 08:30:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <b838fcb8-fa7f-5d75-d536-4dca47bd20aa@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [85.223.209.55]
X-ClientProxiedBy: AM5PR0102CA0029.eurprd01.prod.exchangelabs.com
 (2603:10a6:206::42) To AM0PR0302MB3202.eurprd03.prod.outlook.com
 (2603:10a6:208:9::21)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM0PR0302MB3202;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0302MB3202;3:CE7KoYDHlO6eY7zts7+clM5MBjhBUye1LJHUvsyWcRG6ViWInftUYp/nkQaVrJzSIf+JOQMXSxEdu/lJ2kTwPSSrcjuqRRkftdFWKDBAiA/otOaG9dcbupDK7k2Jf+P20hH4WkdxUfQxeHIjrQ0H1j9pktL58b4eUP7x3i+vh1GapHs2acKBtAa/rIQrv/z0r9Aiy3lojptqpLr+yYqjZWMLUEqZAXkOXFRyZrXUOvZSzKlIwa9WJ5RgbK+h/5Oy;25:z5Wv3YTXqw9OYXsTlh4jv4bL8dVZLnyWfg2mTWOAAn/KNZl/TTud+qfolw8vzyPXTGXa9uNvtPfnPpxVkyJRC/Kv2pUHgBHbopsNPpR/RrRWhEEibEs4oGekQFtKa0cQYczSCjun3G9nKE125/T3LisAQUYv+mXYWMRlOcDuio2WnImeqUk/FzGTMaftFuLaJFK3+C+AaUORNnh4YmTRps2tmG0PZnGujavdcg03N5tUW03IK/HUKnlf/9ljycvzZ5DSVP7/5eLFEVrZu26tgXNCuoGYbeoVbFzaQvALSFMfO6jyMtEup9KWeTz89XQCsm8nTStESjHTFUZHbexxCA==;31:BH43ZZQu/yv61Tgaqauv1jT19Ld+3VHXWC9/d5FfEAylfrepJrFKgKem0tRVNFNwRH6UF6EhSvnmi5buU2n8H2XB22K4Lkcm9gAjdPHgtIUs11wE1WO87EcFJcmDb8vAs5PnhvOr42xSMHdgRvbtmbqtqB66vkNQSH/bCV4TVgJFp8ZtVgUzDxvBOTEZybw+CqMh1PSpuK21fAMPZDji0ZwXQDUIn0Ms8yi57t5IXcc=
X-MS-TrafficTypeDiagnostic: AM0PR0302MB3202:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0302MB3202;20:gPWYRRkvf6vfSU+vRpO9uX67/rqWQ2ITp5SmWtJJ+Y5EUNhTAyYZk8Oqsvp6gic/sXNH3tTEPI93YoJFeaDvguATAhm+dx8ZprScmEgG8ICEZ+1KoruhW4Gy9fukmrmHpK59hyaytNt8nAzHl3ohAYYFX9aXhakKzA1QRR/zOD00h8FiQeu16tjs2vfM8tGOduBXMeOax9iF3qlSRe6vEAzF6fPw6XhqP5FoJTMz9VjmPD88qooI+aWiAvivQGKeDuzqiMfijB733rjvZAYx5J1QmHSguyPj5rc7gRZujI5bYY5jNua8k5XiHOVHLW4TlsjuhGnqUaGk+mQo0wK7kGDKXOTautNZOYLcp3P7EjGFgUp7bgk4+4Qh1QN3Az6BCEv+E5v8EqXZfdWiAzyHkeGzgr2izHSPMW1VLNf1CK5zQZ4Y5qNI8w8kJXjyI2+jTwWf1we/BNsn+QzitYPFvWOdYkDO2De1j+BeGd1ceUJkSfRgEAwFe0Gi3cr0o8zs;4:nylYcAt4W+E6XYVHZR3rfr12i0TtfEe0qwINpvBdsc0ol02zG6WW+0aASH5y/WAdCYKJPCmDuwD+7Gkl8yPg4y0rthk6NsKpoExruVrVbe29fu5AoqFiRWmTfpl5CKva2o28BwH6xXBJd22d5oZnDxvnvjvrGib4epWJvPQ0LKFOtOh8NssxE6btqCuRiGxwgSw3Wjs/I+Ji2muNCbKR+Y2jO+E+CVV1qjRyVdCGUWpI+kKeIKO3ZAgY70xaEs/Ose9ibjHhIOiJr+N1fW1O/hjrGCGYOvjJpGopFcOm342OJdPLuIPxrpDRkUNZ/zRK
X-Microsoft-Antispam-PRVS: <AM0PR0302MB32022ECD3EAF4DF0DA8A9B18E76C0@AM0PR0302MB3202.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(4114951738403);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM0PR0302MB3202;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0302MB3202;
X-Forefront-PRVS: 0688BF9B46
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(346002)(376002)(366004)(396003)(39380400002)(199004)(189003)(39060400002)(6246003)(64126003)(36756003)(53936002)(68736007)(305945005)(50466002)(65826007)(7736002)(5660300001)(7416002)(446003)(16576012)(316002)(6486002)(229853002)(67846002)(2906002)(81156014)(31686004)(81166006)(8676002)(6666003)(58126008)(105586002)(478600001)(97736004)(106356001)(110136005)(80792005)(8936002)(72206003)(59450400001)(386003)(77096007)(11346002)(476003)(26005)(25786009)(2616005)(956004)(55236004)(86362001)(575784001)(53546011)(76176011)(31696002)(230700001)(47776003)(23676004)(52146003)(2486003)(66066001)(65956001)(65806001)(6116002)(3846002)(4326008)(16526019)(486006)(52116002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0302MB3202;H:[10.17.182.9];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjAzMDJNQjMyMDI7MjM6NTJ1SDAyZTVXTGFTWHJHdiszc3RVVTUz?=
 =?utf-8?B?V1ptb2RTSlV2REJRdGs0OFBmRVBRQW8wUnMyREU3Qk96TEE2eHJUUlZLc1Zx?=
 =?utf-8?B?OHRibzcrSmVtZGl5OE0vSmhsZnJzM09EUGdkY0ZsOGJGUEhsUFI1QzJzSlRJ?=
 =?utf-8?B?L0xEVnl6VDB1WWhsNEgrTlZHZXk0MVE2WjMxdmltL1AwS1F4dk1NZzI1R1hW?=
 =?utf-8?B?NFU3a3k5Sng5WUxUWGFPVHA2UTJ2RldKUjQ0MjEwRkdqbEJQelR6cDlCRDhU?=
 =?utf-8?B?UDI3Z0ZzZUZHQnM2dmR5ekNDZGU4SmV4Mm50VVdMYkEyRXhzZS9RS3dZRWNv?=
 =?utf-8?B?SThQa0V1bXAxejI2SUhIMmxJZlN3MXpaenFjUEttNVdDbHh4Tm1ldHV0OVg3?=
 =?utf-8?B?QkFhbndkajl3ZWhLR3poTXNHWjkyOGdrRm9YZFJCWElNL3ZoaFZLby9WK2ly?=
 =?utf-8?B?YjdWa2RvSy9HWGZhRjJWRjQzQUsrWWNLeHVVeGlhd2ducUt2ZDZGblBoQnhR?=
 =?utf-8?B?dHNUaHZ3a2dNR0lqK2RTMDBCQ0hINkt2M1FaZHVTZksrQ0x4b1pjVDdiM20v?=
 =?utf-8?B?Y3NoYVhCWWNLbnhIckZwOGZRWkdka2JHb1c4ZFdJY2NhUzNEMllyU1RUZTFP?=
 =?utf-8?B?azhOOEpoY241MGZ3R1ZPYnl0aUZBUWZKdXI3SXMxc3MwOU1VME14MVQ2dGlM?=
 =?utf-8?B?cWFMSm8yZk1LaEtkQnUxaWN3LytDa0ZNbzM4QTl4M3NFOGZ1UHNMUUY3YWtv?=
 =?utf-8?B?czU3Q1F1OVJLVEkxNXI4RnFSRCtKY1RIa0hUNHpmUklGVHZSTUg5ZzdZVCt4?=
 =?utf-8?B?czZmTStLN0Zab01MMFQvNDh0RFc1THFCMkU3MmNVS09laFB4aWd1K2tJcmg1?=
 =?utf-8?B?TXJuMU1yK0wzVFRQcnMrTld6dHNDbTBWWWVaQTBzNzNYR3hMMUJBWnhvQ1VB?=
 =?utf-8?B?RHM5SVROaElDN05Pa0tZNHRYMm9wUUt4N0dNV3pCbVNDOWN1MTVxNmNEdU1Q?=
 =?utf-8?B?OU1FZmVTUmhzV0VmeXVSQUxyK3loeDJvcDFwdXZYNTNyb0IvR0laVXNPVFM3?=
 =?utf-8?B?emxRZmt1NEN4anRwWUh2bXR4OVI5c0U0TG1Zdm02WC9OMHpqdkl2WWpPVnQ5?=
 =?utf-8?B?NS9VaEg0UnVyZU9jd3dlRkR5OFhiSEp3RFdEZDdRbGNYdGtwMW9SZlJqT3cr?=
 =?utf-8?B?VUYvVGdNb3dHMldRcXlPcm94Sjg4UVpLZWZ3b0p1TzFlYTZ4d1pXL1d6dFNM?=
 =?utf-8?B?ZmpacGlIUm14M2tSb3dWWjhJcTMyeHZ0MGZxOVp4MHorWUdaSnFOMjFXS1lG?=
 =?utf-8?B?c1lQUjRUR0lrUkhWYjlvdVd4T3I2QWxNbmZyVnk3OW5pUDhhdzNxNm5maTRP?=
 =?utf-8?B?QlhkREViNm9Zck12Ry9kdUpoWGFmRlRXcTVzdHczNlJ1aGpBWStpQTg5eUlT?=
 =?utf-8?B?ZXhpeXJtSFdWUjduZzFNYzZXekdLT0lsb20xSUg1RWloRlVYd1RBc1BaSjA5?=
 =?utf-8?B?NXhoUE9QeUswa2EzUS8weTB3djd2TW9DcVArTzlYWTlBd3c3RmlDT3dDVnAz?=
 =?utf-8?B?UjY3clpJb0VmK0VPZ0ZpeTU3dTJXb2ZxMzBzd09xQ2pDbFVYbnVhWE1sdm1C?=
 =?utf-8?B?R2czSCtrajRnd3h4Wll2TkZ0NXJuK0N3a3czb05iNmZ6TVdsY0R6dTk5TCtu?=
 =?utf-8?B?QkticHFMSVIxbnlWcWpPbGhxV3NYZnZ6K3ZNbUpmTUFkVExHbVYwWUo1NU4v?=
 =?utf-8?B?V0lmQnJ1NEFQeWNmQ1RBQkVkaUM4ZkdNVHE5dWcwZEJhN1JDUWtPYkp5Y0xB?=
 =?utf-8?B?Zng0b0pqN0RFNEd0NGFwcGFtTVRZbDRXcmZTcTNhUFBCTkxQZW44MkFsdlNO?=
 =?utf-8?B?TTh3aGFHM01rRmM2MHR1MVR0QVNaUHZ5OVlpbUlxSTdZcHpwSzZFUkpaWC9r?=
 =?utf-8?B?UzBrdlpXV3NjeVQ1VTJBZWE4aFFKNDlWYUdTbEl2c0l2SEtRQmd1V29ialcz?=
 =?utf-8?B?T1pwODg0QUNoVDNsSEdlMndMQjRtd0p2WU9IZjAwRU5oZ09RNnhnYmNtNVRp?=
 =?utf-8?B?Q3Uxb09oSjhteHRRNWh0enh3MkxrK3p3b0lvbWhSRTExaUs5cnJFS1ZqanQx?=
 =?utf-8?Q?yXbOvan43rzffc6gUo/m7RliQySLppmW3g3Vkq6Pgd9NRT?=
X-Microsoft-Antispam-Message-Info: S1mEllFkQ5gYj8eSpwIbNtw9LdiN0dJJm6t5p8TF/zlVirZwGn5vdMVFQMFBrHTHLRqXO7MPRqZlsqvvNULvnF31UbhHcPN0Rwclg7rrtQt8u4X1T2DUNoVuGi3GfkJgkIYDs7SB99kllYKJpyenX9A8Gk4nhxucUWqUvbKQ6dMmbLyzfvENDUwC1sRYAdW2
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0302MB3202;6:z9m1ny/8RnA3RvPX7ASuut9vwmJx6x+etb0nf4EJFnMnERb+wMHFj0Jmw7C/cKeDoaOwg2oyIRQ8wHQ9V1YCjuAguSuyF0LluAcOAUhQAZu2UGieMrCWpuDfpCnO45SN+WathjojLMSdV9a0gZfR1y2RN192fXj51jC0Fh7OCvIp/cgHnH+rlbLA7ylixfqwW7uUNOF7RV23DZKSaQEARj8rvxPxaY/tww2gHEH7TvumyYdWhouQ2UCfXF2Iaa/xnRi9hN2vEG085Cu7vt4YwpbVu4eGt72KXNVoarCgABtCZTUPw98MR7x1x4hE9M2/+G9LCcDdf9pLpZhCOmCN+zyTUgO+nDR3nbVHyiKSOTVb0INMlQG256Uw6a90BqtjYQk/I3CcSfP/Hb5mmHfz43ZNdf/blIRj3V1ZmqF+lJPVql7zadz+RGzOv6m8X7bnIpmKwxqmQMld0ZFLqJTb1w==;5:WOBfrrJ5mKe+OFulL3QZx4pbOLX2DjpesnrmDGaXL5mPxh5IP6XRdOvxVh6F/NNgUhXdr6h/GQWu1FmKUzHXkMPsF5T54KzaPyCU6bUdxwwTKwA+MRiRL2Svlkp0nZm/y0+dvyPSTRdN/EKrQd1gQLkgJJLFKe0XR9/cT20jw+4=;24:q+MvDRbZ55e9UQ1L5mhltyXxz2Gc9FLoGBtdWV+uM8FlVhVZrJoe3foUTEKhr8/6bBVxw6vwkqkgi5NkdYHKxi9v9W0MarNvznSn/gWOdNI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0302MB3202;7:Nlngr8Qvqe3u0l4AFYoc+HzzpKtv6p0Hqr4m3SnIIc+wfK/e/7iHBxGZzJW8eoBAUR/xXW/9VQE5Ecxmfj5iFiKcWnR8XYiBibMdv3/PXlwDY79f51JSvP205WrIlJ/H7MmbI/c6T9LCtAJ6IotmNleUS3YCsyy5i1uhD/KdLwvbCsDlGYUzdSxMFHe6/nkFMvEki+EH2giqqCFv81TYx4OLV6Yz0u9O5GJxXTWXZLh375rC3pi/M/5ZyiryeSR8
X-MS-Office365-Filtering-Correlation-Id: 5427b701-be1a-4018-8c0e-08d5c5ee752b
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2018 05:30:29.5665 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5427b701-be1a-4018-8c0e-08d5c5ee752b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0302MB3202
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/30/2018 07:32 AM, Juergen Gross wrote:
> On 25/05/18 17:33, Oleksandr Andrushchenko wrote:
>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>
>> Memory {increase|decrease}_reservation and VA mappings update/reset
>> code used in balloon driver can be made common, so other drivers can
>> also re-use the same functionality without open-coding.
>> Create a dedicated module for the shared code and export corresponding
>> symbols for other kernel modules.
>>
>> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>> ---
>>   drivers/xen/Makefile          |   1 +
>>   drivers/xen/balloon.c         |  71 ++----------------
>>   drivers/xen/mem-reservation.c | 134 ++++++++++++++++++++++++++++++++++
>>   include/xen/mem_reservation.h |  29 ++++++++
>>   4 files changed, 170 insertions(+), 65 deletions(-)
>>   create mode 100644 drivers/xen/mem-reservation.c
>>   create mode 100644 include/xen/mem_reservation.h
> Can you please name this include/xen/mem-reservation.h ?
>
Will rename
>> diff --git a/drivers/xen/Makefile b/drivers/xen/Makefile
>> index 451e833f5931..3c87b0c3aca6 100644
>> --- a/drivers/xen/Makefile
>> +++ b/drivers/xen/Makefile
>> @@ -2,6 +2,7 @@
>>   obj-$(CONFIG_HOTPLUG_CPU)		+= cpu_hotplug.o
>>   obj-$(CONFIG_X86)			+= fallback.o
>>   obj-y	+= grant-table.o features.o balloon.o manage.o preempt.o time.o
>> +obj-y	+= mem-reservation.o
>>   obj-y	+= events/
>>   obj-y	+= xenbus/
>>   
>> diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
>> index 065f0b607373..57b482d67a3a 100644
>> --- a/drivers/xen/balloon.c
>> +++ b/drivers/xen/balloon.c
>> @@ -71,6 +71,7 @@
>>   #include <xen/balloon.h>
>>   #include <xen/features.h>
>>   #include <xen/page.h>
>> +#include <xen/mem_reservation.h>
>>   
>>   static int xen_hotplug_unpopulated;
>>   
>> @@ -157,13 +158,6 @@ static DECLARE_DELAYED_WORK(balloon_worker, balloon_process);
>>   #define GFP_BALLOON \
>>   	(GFP_HIGHUSER | __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC)
>>   
>> -static void scrub_page(struct page *page)
>> -{
>> -#ifdef CONFIG_XEN_SCRUB_PAGES
>> -	clear_highpage(page);
>> -#endif
>> -}
>> -
>>   /* balloon_append: add the given page to the balloon. */
>>   static void __balloon_append(struct page *page)
>>   {
>> @@ -463,11 +457,6 @@ static enum bp_state increase_reservation(unsigned long nr_pages)
>>   	int rc;
>>   	unsigned long i;
>>   	struct page   *page;
>> -	struct xen_memory_reservation reservation = {
>> -		.address_bits = 0,
>> -		.extent_order = EXTENT_ORDER,
>> -		.domid        = DOMID_SELF
>> -	};
>>   
>>   	if (nr_pages > ARRAY_SIZE(frame_list))
>>   		nr_pages = ARRAY_SIZE(frame_list);
>> @@ -486,9 +475,7 @@ static enum bp_state increase_reservation(unsigned long nr_pages)
>>   		page = balloon_next_page(page);
>>   	}
>>   
>> -	set_xen_guest_handle(reservation.extent_start, frame_list);
>> -	reservation.nr_extents = nr_pages;
>> -	rc = HYPERVISOR_memory_op(XENMEM_populate_physmap, &reservation);
>> +	rc = xenmem_reservation_increase(nr_pages, frame_list);
>>   	if (rc <= 0)
>>   		return BP_EAGAIN;
>>   
>> @@ -496,29 +483,7 @@ static enum bp_state increase_reservation(unsigned long nr_pages)
>>   		page = balloon_retrieve(false);
>>   		BUG_ON(page == NULL);
>>   
>> -#ifdef CONFIG_XEN_HAVE_PVMMU
>> -		/*
>> -		 * We don't support PV MMU when Linux and Xen is using
>> -		 * different page granularity.
>> -		 */
>> -		BUILD_BUG_ON(XEN_PAGE_SIZE != PAGE_SIZE);
>> -
>> -		if (!xen_feature(XENFEAT_auto_translated_physmap)) {
>> -			unsigned long pfn = page_to_pfn(page);
>> -
>> -			set_phys_to_machine(pfn, frame_list[i]);
>> -
>> -			/* Link back into the page tables if not highmem. */
>> -			if (!PageHighMem(page)) {
>> -				int ret;
>> -				ret = HYPERVISOR_update_va_mapping(
>> -						(unsigned long)__va(pfn << PAGE_SHIFT),
>> -						mfn_pte(frame_list[i], PAGE_KERNEL),
>> -						0);
>> -				BUG_ON(ret);
>> -			}
>> -		}
>> -#endif
>> +		xenmem_reservation_va_mapping_update(1, &page, &frame_list[i]);
>>   
>>   		/* Relinquish the page back to the allocator. */
>>   		free_reserved_page(page);
>> @@ -535,11 +500,6 @@ static enum bp_state decrease_reservation(unsigned long nr_pages, gfp_t gfp)
>>   	unsigned long i;
>>   	struct page *page, *tmp;
>>   	int ret;
>> -	struct xen_memory_reservation reservation = {
>> -		.address_bits = 0,
>> -		.extent_order = EXTENT_ORDER,
>> -		.domid        = DOMID_SELF
>> -	};
>>   	LIST_HEAD(pages);
>>   
>>   	if (nr_pages > ARRAY_SIZE(frame_list))
>> @@ -553,7 +513,7 @@ static enum bp_state decrease_reservation(unsigned long nr_pages, gfp_t gfp)
>>   			break;
>>   		}
>>   		adjust_managed_page_count(page, -1);
>> -		scrub_page(page);
>> +		xenmem_reservation_scrub_page(page);
>>   		list_add(&page->lru, &pages);
>>   	}
>>   
>> @@ -575,25 +535,8 @@ static enum bp_state decrease_reservation(unsigned long nr_pages, gfp_t gfp)
>>   		/* XENMEM_decrease_reservation requires a GFN */
>>   		frame_list[i++] = xen_page_to_gfn(page);
>>   
>> -#ifdef CONFIG_XEN_HAVE_PVMMU
>> -		/*
>> -		 * We don't support PV MMU when Linux and Xen is using
>> -		 * different page granularity.
>> -		 */
>> -		BUILD_BUG_ON(XEN_PAGE_SIZE != PAGE_SIZE);
>> -
>> -		if (!xen_feature(XENFEAT_auto_translated_physmap)) {
>> -			unsigned long pfn = page_to_pfn(page);
>> +		xenmem_reservation_va_mapping_reset(1, &page);
>>   
>> -			if (!PageHighMem(page)) {
>> -				ret = HYPERVISOR_update_va_mapping(
>> -						(unsigned long)__va(pfn << PAGE_SHIFT),
>> -						__pte_ma(0), 0);
>> -				BUG_ON(ret);
>> -			}
>> -			__set_phys_to_machine(pfn, INVALID_P2M_ENTRY);
>> -		}
>> -#endif
>>   		list_del(&page->lru);
>>   
>>   		balloon_append(page);
>> @@ -601,9 +544,7 @@ static enum bp_state decrease_reservation(unsigned long nr_pages, gfp_t gfp)
>>   
>>   	flush_tlb_all();
>>   
>> -	set_xen_guest_handle(reservation.extent_start, frame_list);
>> -	reservation.nr_extents   = nr_pages;
>> -	ret = HYPERVISOR_memory_op(XENMEM_decrease_reservation, &reservation);
>> +	ret = xenmem_reservation_decrease(nr_pages, frame_list);
>>   	BUG_ON(ret != nr_pages);
>>   
>>   	balloon_stats.current_pages -= nr_pages;
>> diff --git a/drivers/xen/mem-reservation.c b/drivers/xen/mem-reservation.c
>> new file mode 100644
>> index 000000000000..29882e4324f5
>> --- /dev/null
>> +++ b/drivers/xen/mem-reservation.c
>> @@ -0,0 +1,134 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR MIT
>> +
>> +/******************************************************************************
>> + * Xen memory reservation utilities.
>> + *
>> + * Copyright (c) 2003, B Dragovic
>> + * Copyright (c) 2003-2004, M Williamson, K Fraser
>> + * Copyright (c) 2005 Dan M. Smith, IBM Corporation
>> + * Copyright (c) 2010 Daniel Kiper
>> + * Copyright (c) 2018, Oleksandr Andrushchenko, EPAM Systems Inc.
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/slab.h>
>> +
>> +#include <asm/tlb.h>
>> +#include <asm/xen/hypercall.h>
>> +
>> +#include <xen/interface/memory.h>
>> +#include <xen/page.h>
>> +
>> +/*
>> + * Use one extent per PAGE_SIZE to avoid to break down the page into
>> + * multiple frame.
>> + */
>> +#define EXTENT_ORDER (fls(XEN_PFN_PER_PAGE) - 1)
>> +
>> +void xenmem_reservation_scrub_page(struct page *page)
>> +{
>> +#ifdef CONFIG_XEN_SCRUB_PAGES
>> +	clear_highpage(page);
>> +#endif
>> +}
>> +EXPORT_SYMBOL(xenmem_reservation_scrub_page);
> EXPORT_SYMBOL_GPL()
>
> Multiple times below, too.
Ok, will change to _GPL
> As a general rule of thumb: new exports should all be
> EXPORT_SYMBOL_GPL() if you can't give a reason why they shouldn't be.
>
>
> Juergen
Thank you,
Oleksandr
