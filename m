Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751462AbeCLTtA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 15:49:00 -0400
Received: from mail-cys01nam02on0051.outbound.protection.outlook.com ([104.47.37.51]:7872
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751303AbeCLTs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 15:48:58 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
Subject: Re: [PATCH 11/13] dma-direct: handle the memory encryption bit in
 common code
From: Tom Lendacky <thomas.lendacky@amd.com>
To: Christoph Hellwig <hch@lst.de>, x86@kernel.org
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Muli Ben-Yehuda <mulix@mulix.org>, Jon Mason <jdmason@kudzu.us>,
        Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20180305174655.9878-1-hch@lst.de>
 <20180305174655.9878-12-hch@lst.de>
 <114e27be-5814-4258-4985-af08763c8a74@amd.com>
Message-ID: <0c9d3e4a-8407-282a-73eb-21d28047e0e3@amd.com>
Date: Mon, 12 Mar 2018 14:48:51 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <114e27be-5814-4258-4985-af08763c8a74@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: DM5PR21CA0057.namprd21.prod.outlook.com
 (2603:10b6:3:129::19) To CY4PR12MB1141.namprd12.prod.outlook.com
 (2603:10b6:903:36::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d968b6f3-ca9d-4c30-9d25-08d588524a68
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY4PR12MB1141;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1141;3:Sm6M33J6aOjPziyBEeNUfJfJJKs9OSNJWKzm4vSaAfIEjbDiGaRXP6cCNRv9zipcQUuTYGeOFYboaWKGToBQgGyMB5prYu4u9fN9MApIwZh+0rPyOvlws0jccZaEnaW/hFQh5sOtyxMT/c45w3ApJ/7YK3CKcIXOCJctIn16zS3Dz0oKQy53DCO4IKCMZjxYNsxOnUrVpLaeZHvz/vAU3nCI5oT2AGmzXZQI39kW16bb8WyZLkUslMs3mBI3nIID;25:UQGRnS8busoRbzvHDB2+E3RXZMFt56yTewQUVKEkTZSiOLLzSnRrKyAX2yMX0dE66Xu5RGFte2ru+Gx+7HE046GENjGBf9lEhacaGaeB0I3RNAJZYNjD7cP40EUVdEVkFWrn59/+QPkaOAIb/35AH70YEFKDpo62G4I6TrZjuf9Q9OfKpmXlZYl9vn9hXrhyx8GcZu2s3KEWC3n3XjjXtSXFHud+Nl8gldjxGN13NVSdvlWnaKjN/w2++VHADNvTLOmZ2c904KY8+UKiDL1mPnHwk5crFiQm3ls7LHi7NwehZtv/fOA8vY6t5t0w1Cob/3mzmufzILsMR2o6LHr5nQ==;31:84RSvBGsPSOh3Ppy3ISKfwSuxh7Cr+J9SWGxeKGu4D+ZyQxHXu6AXvAd5LgWvNnMhKFEWuIn4QY4XiCWa9vTExbLisIFa+U3gZS+f84DfHZl9zezjIbWYZGZ2WuCoBlUfyOzniVxBB5w1skMvx0dnjLTONw2bWsZtxlQTqbIo0KOsGn0vRB1gHCxrcViKJUh/3Hw3Ih1/j7Gv/4ClUtcZBtCsGtqJL6R9Gc1E17tR+A=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1141:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1141;20:JaCbDXgvNNgLnaYWhQQLHgK8f8lO+maCF3h964G5/SQEszwtzt0T13g9XXSOeZQs/tZ/jklQ9Fs/oFvGXczA611O7py/W4Fc84YzAes2RN9I9SXsphnLOFurJcH8tY/OIuObwvQmkmfq7o5HRP0Z/4ojRo8I/u3BFOzPRT+iNYey08TT4/49ON8ta1X/ciu0MlgMsMfbRmw1ZBDpLqIsIwvybNp59s/YJOpfL9NUxjHsO+y+4TJOurNC4luyGqw1OZztpMAkNcXtqmgrCb279mpwYX7BdltD+KyBh2dkqnpcMStZ+DDW1zXyBJ7w3/gWAx3G0r3zTKhFEn49i8Hc5tNNwTa0Zk3BzhdJSAT8Bn1cqKEWcxDJ0DvuUqLXxaR2//N5VyKTpx96eobTKokIP+zPmCU+OlLsY4fuWHkuUX8SaVqLsE0y0DxvbxKSklkv/jUfX8UEdTmmjKtSXWG5GI3ZBzc7g6Lw+adsIAxgglQPUSRonr0lbIWPZOTndPDg;4:fDkfEyrzI2Q0blEla5x2+LIkR/bBzYh819v4l4gzEG0DHvN+bpY1LWDWADIjbZhDn96pJsHuA0FO0sPHqATmxOhKrorZgsYfAzAD3N27WX4nBTRW7buXIliJsOq/Yg3Z4hZnT6rq/L1RKsv/U/UYBGaiTx3safcxg3sHwGY62QxxZYi4XyOU+BLKZFXrzLTCDr/3KLoHoEwtg4IbOcu8gj6uX8R6fEUkf5Hr6Ol2hS+DbJ2aks5L0zAKJbroLk4Th7lzFySF8KoUeyrQgN1xGg==
X-Microsoft-Antispam-PRVS: <CY4PR12MB114121E0A25F8B04F91CC6BBECD30@CY4PR12MB1141.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(6055026)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:CY4PR12MB1141;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1141;
X-Forefront-PRVS: 06098A2863
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(39380400002)(346002)(396003)(376002)(366004)(76104003)(189003)(199004)(229853002)(6246003)(97736004)(3846002)(478600001)(31696002)(36756003)(65826007)(6666003)(230700001)(2950100002)(72206003)(106356001)(25786009)(6116002)(64126003)(65806001)(66066001)(65956001)(3260700006)(6486002)(2906002)(47776003)(4326008)(53936002)(68736007)(59450400001)(77096007)(26005)(86362001)(305945005)(52116002)(50466002)(52146003)(31686004)(8936002)(316002)(5660300001)(105586002)(58126008)(386003)(53546011)(54906003)(81156014)(8676002)(186003)(23676004)(7736002)(2486003)(81166006)(76176011)(16526019)(16576012);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1141;H:[10.236.65.116];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyTUIxMTQxOzIzOjJlTzJ3bXJTV3RwSmJ1ZVh6eXhBWlhNem5N?=
 =?utf-8?B?ZWdhOER5a1hIYjVmUm9PQ2x5cm5hSUlrYVBoZHhLSDJ0SXllZUUxR1lXRjh2?=
 =?utf-8?B?WlFqaGJVTUN2amJiNDRVTm5UU2VHem43c1RGQ2dCVHpHWnFFMUNPQ29GaFh6?=
 =?utf-8?B?blVoL0tLbGJWcHdUNFEwaFRvT1NiMUlNVW5wcEZpUVpONEg2VjZGa2Nsbmp6?=
 =?utf-8?B?RDNMemVEbWhVeXFENUxxNVdNdlQzclNZNEJySUdIWEYyWm5xZjBhekRZVTlY?=
 =?utf-8?B?K3VxMVdtOUFCMHlNV2FkRy82dUJtdGJqdllNUlJYMVQ3VFJYY1NjYTBIekly?=
 =?utf-8?B?VU1NSURTVDJmNndBRG1yTlpaM1hVRGl5WWFTUEVMZDUrM2xMbk1mdlZ6a2li?=
 =?utf-8?B?QUlySHVXR05nSFgyb2ZJendlYkloZTg3RDBqaHBzUjRCY0lacjhBYW9rSnR6?=
 =?utf-8?B?bHdXQndrelNCeDd5ZEZpWjFvemc5OHhMcm1tY1RwYU1iS2ZUSkZyN2taTTZ4?=
 =?utf-8?B?M3RGRWM0SUtnTTFBeXk3cmxZYVZLQnFWSEk3RDE1RFBmd00vem1OeGhKRU5Y?=
 =?utf-8?B?KzZlR0daNEZ6QTNrdXJVeVp4YTcvSDM4YVRoQ2pDRzNSc0hYY1JMZ0d5MlpS?=
 =?utf-8?B?cExuYWxXV1ZlQmd0VTFRN3M2ZW1JeEt3K0N3ckJyYU16UEdDdmFHSWtEYzBz?=
 =?utf-8?B?c0daS3dPcWNTRVNZVkRLTGNlN3lraUN4T2V4T0JJWWpWOUVLb2YzZFpEbVli?=
 =?utf-8?B?aWJwZTM5bkRVRXJxeUtzZ0hiZnJPQnpLR2w1by9zbm50bVZza1BrVWhUaXNT?=
 =?utf-8?B?em1HZHpvaXVUbnFBVVF3OXYwbmt0VUlxMjBVSWlSVHpCYmNtZEhwVUZnZ3Vh?=
 =?utf-8?B?c2ZJNk9jYjBFdlRZYkU5ei82bGNEY1luclFLM0VWOWk3VVh4NGFQcEJFbVVj?=
 =?utf-8?B?TG1MZzREelJjREF1MS9hNmIwYjBtdjFQRDhJZDVTK2MvRUdZc2lybFRSVTdi?=
 =?utf-8?B?YzZka0cyWkNWV283U0dUaHZmK09XZ05KMVpUd1M3OEhMQ2NZL0JqMG1ZM2Ji?=
 =?utf-8?B?dFFEdFMzajQ5UkwrUkxOeFNXaVRReEhsa2Z6NzBIVHZ2d2xhRENvSmk5NjJ5?=
 =?utf-8?B?bVpyMm00QWh3VGFuaTdzeUJRSjRkNXpHc2pXMWUwOGY3Q2h5VTAwMGhhZ3hG?=
 =?utf-8?B?c3E5eDlVUzRyWllnQ3VmRUR2ZmlXcHFGWmVkRnBXaVVmOE51c2xVQmQ4RDJq?=
 =?utf-8?B?NUtwd2dxK3ovTW9BeERmT3U3RzYrMURYUXNtbXN3VmJqVXBJMDhYYUVLTU5S?=
 =?utf-8?B?YWdKQXlTVVNvR1VDamM4VE51aExTSkpwRGlZMmdLd0U0WGR4U0NZNnNHemYz?=
 =?utf-8?B?bThFVmtnTkRQZC8rQVRPZHJJS2dmZ01TK1Z6SDk4Z2dWT1kvNjZwTnZ1ZzFI?=
 =?utf-8?B?V1ZCaTlOWFNRNStQLzlMWkhZakVmaXcvZURIRTdBVkdCNGY4V0xQcmtvRCtL?=
 =?utf-8?B?dnpLMzJ0U21mbU8wenZPam5NaVJxbTNiRk93WVgvZERUMHVrV3JKakJJYUxn?=
 =?utf-8?B?ZmdMN1ZXaFBFLzF5aTgyN0VIV0wzRjBkNEFhYm94WjNXUGxLQ1ZVc1A1end3?=
 =?utf-8?B?ZG8wTlVUMDlpeFlGd1I4dnRUVHgwSDREb0ZNSUY4K0hldWZVM2dvTUUxU0Rk?=
 =?utf-8?B?b3JPdUdCNy90dXlrTmhaVjg4VUxYMWlBSGZ1OENkZkh4aXhMcGRDZXdreHBE?=
 =?utf-8?B?U1BwUGFxUnpjVXl4U2JWZ0VaMHp6K2JxTkJMSmdjUHVLRWE2cmh5SzFaajhT?=
 =?utf-8?B?RzBVS1BRRXZQckE5N3FzQXl2TjluRzVhcy9mK1F4TzlQSnhYRVJrb1lRYThy?=
 =?utf-8?B?bU5ZbzNvUFNGeUxFWVRYb2dQT0FnRWxaS2hsVEFPeTY3QmxsVitrQWdvUUxy?=
 =?utf-8?Q?8a4ObBlysgbdsZtcT3ABXaFYqcdPyk=3D?=
X-Microsoft-Antispam-Message-Info: OsNy9Sg3VW/0kdN7RfCFVzkFXQVMC4gucwA8ARsJNbJbQow2LIQUBRSwutRlxMwyP2vBJuIxy+JUoGWOwp2V/7ow4pivonMa/xKFp0s4AGzCXCze8J79Ka9kyAg46xNfuBCQ6P3Wj5n2q/pvM1fxU1R0sfmsR7zQmHDyhXJmPB2UZLVnYIO7PExWkMPJfWsn
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1141;6:XR9L18OJY8GgcGYpxX9VbOkQT9kzI6beGXpBiohRK6vGQLAzSNY4uGeQ4yofZZil62JqB7mnktjqq9ErNQrGaV3E83owPl7/CPvSk8nvYifEhUFYA3kKYTJFoCxDWgHMU68x63BAoVqRzzl7O/0Uywx6fT0LDMdjtV8zsOSdX0koR3TYXjgUF8U6JwQdfdpKSB0mBfIdpJjskNS7QfSZXmSzBG7gH5MWOFfkQzEwE0YHqTmqS4Czt3Ya1Nln8xEolT48402huWqdgaNP63ev9+8ZkEsTIJIJbwceS2DW6hJBd8NoGTJnN6JUbBQbuaqqHNmjMk2CVHQ2c2bQIwtAgRPlNyYe9GAtT1/v0NNtmGE=;5:adqe0+CuQW6vURKtGbRryhipO0eAymKhYmaWWfS/PKmSxmq6/DbHua7tLrmqduH4dC0dhj7UABl8272aRGeyX5NpVYn3TuUpp5+WSjtm1YnZstBsMrVDvN9AA3CEdK8ZgqL0LIg1nwRfTjEhWUTO2oo+zK+ADM199CdIPmfSMxs=;24:mrVsYkV7rvEER7mGeG9odOi2Obbal/U1BifqqctdJPbRLHMOlXLqBpjPE5FzdOhGDpOuWGhV9Lq0Ehc1pdhKnPqRwHt3S+y11c4dSN6eCMM=;7:/N9yI5AcziP6Hh1riOo9cjklcVVi0/H8BtUvAqnI5qnossHVUArnVNN6NPR8wLuz1kZPmnYV3rWY9DapYTsI4ZgilsOi5DE/b6rQORJ7rp04rlGeGviFufmTkosWtppv2ihSqNm4jSHRu6FSORx5u4tUKXw2+yO6DCFyaffsYuTSUWOHYEtE1tNUJzgzWtPvE5rm7tERFD786gDsLSJNhqarH/RMIgpxHq9aqr/rpnStVKddkMhhroUikZ3t8OFh
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1141;20:VG4pwX4bkZcrx0NvoutmBASvdIaxDkxBQQcUUxO6J72SBp57El7Ogx330eQmRwDxRvQSxkoVKc1jQKB8oXcG4+4c6mpID1CAK5SdhYVo6s5+FND8Lmm4P4k6F6CKP0FS4mx14oE8e5wKgrxkC0L9XBSfbPe70UAjv1EKgwniZBGhAXQqLryvucF7UMc7LlGnRvekKKcpJiP76raf+55hPIRgKaAUi/6ExoJ8+gstufttG8mG8FINMiMAXwFXMH83
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2018 19:48:54.9858 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d968b6f3-ca9d-4c30-9d25-08d588524a68
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1141
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/2018 1:29 PM, Tom Lendacky wrote:
> On 3/5/2018 11:46 AM, Christoph Hellwig wrote:
>> Give the basic phys_to_dma and dma_to_phys helpers a __-prefix and add
>> the memory encryption mask to the non-prefixed versions.  Use the
>> __-prefixed versions directly instead of clearing the mask again in
>> various places.
>>
>> With that in place the generic dma-direct routines can be used to
>> allocate non-encrypted bounce buffers, and the x86 SEV case can use
>> the generic swiotlb ops.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> So this patch results in my system failing to boot when SME is active.
> I'm investigating further to see why.  I'll follow up with more details
> as I find them.

Ok, I found one issue that allows this to work when the IOMMU isn't
enabled (see below).

But the bigger issue is when the IOMMU is enabled.  The IOMMU code uses
a common mapping routine to create the I/O page tables.  This routine
assumes that all memory being mapped is encrypted and therefore sets the
encryption bit in the I/O page tables.  With this patch, the call to
dma_alloc_direct() now returns un-encrypted memory which results in an
encryption mis-match.  I think keeping dma_alloc_direct() as it was prior
to this patch is the way to go.  It allows SME DMA allocations to remain
encrypted and avoids added complexity in the amd_iommu.c file.  This
would mean that SEV would still have special DMA operations (so that the
alloc/free can change the memory to un-encrypted).

What do you think?

> 
> Additionally, when running with SME (not SEV), this is forcing all DMA
> coherent allocations to be decrypted, when that isn't required with SME
> (as long as the device can perform 48-bit or greater DMA).  So it may
> be worth looking at only doing the decrypted allocations for SEV.
> 
> Thanks,
> Tom
> 
>> ---
>>  arch/arm/include/asm/dma-direct.h                  |  4 +-
>>  arch/mips/cavium-octeon/dma-octeon.c               | 10 +--
>>  .../include/asm/mach-cavium-octeon/dma-coherence.h |  4 +-
>>  .../include/asm/mach-loongson64/dma-coherence.h    | 10 +--
>>  arch/mips/loongson64/common/dma-swiotlb.c          |  4 +-
>>  arch/powerpc/include/asm/dma-direct.h              |  4 +-
>>  arch/x86/Kconfig                                   |  2 +-
>>  arch/x86/include/asm/dma-direct.h                  | 25 +-------
>>  arch/x86/mm/mem_encrypt.c                          | 73 +---------------------
>>  arch/x86/pci/sta2x11-fixup.c                       |  6 +-
>>  include/linux/dma-direct.h                         | 21 ++++++-
>>  lib/dma-direct.c                                   | 21 +++++--
>>  lib/swiotlb.c                                      | 25 +++-----
>>  13 files changed, 70 insertions(+), 139 deletions(-)
>>

< ... SNIP ... >

>> diff --git a/lib/dma-direct.c b/lib/dma-direct.c
>> index c9e8e21cb334..84f50b5982fc 100644
>> --- a/lib/dma-direct.c
>> +++ b/lib/dma-direct.c
>> @@ -9,6 +9,7 @@
>>  #include <linux/scatterlist.h>
>>  #include <linux/dma-contiguous.h>
>>  #include <linux/pfn.h>
>> +#include <linux/set_memory.h>
>>  
>>  #define DIRECT_MAPPING_ERROR		0
>>  
>> @@ -35,9 +36,13 @@ check_addr(struct device *dev, dma_addr_t dma_addr, size_t size,
>>  	return true;
>>  }
>>  
>> +/*
>> + * Since we will be clearing the encryption bit, check the mask with it already
>> + * cleared.
>> + */
>>  static bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
>>  {
>> -	return phys_to_dma(dev, phys) + size - 1 <= dev->coherent_dma_mask;
>> +	return __phys_to_dma(dev, phys) + size - 1 <= dev->coherent_dma_mask;
>>  }
>>  
>>  void *dma_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
>> @@ -46,6 +51,7 @@ void *dma_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
>>  	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
>>  	int page_order = get_order(size);
>>  	struct page *page = NULL;
>> +	void *ret;
>>  
>>  	/* GFP_DMA32 and GFP_DMA are no ops without the corresponding zones: */
>>  	if (dev->coherent_dma_mask <= DMA_BIT_MASK(ARCH_ZONE_DMA_BITS))
>> @@ -78,10 +84,11 @@ void *dma_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
>>  
>>  	if (!page)
>>  		return NULL;
>> -
>> -	*dma_handle = phys_to_dma(dev, page_to_phys(page));
>> -	memset(page_address(page), 0, size);
>> -	return page_address(page);
>> +	*dma_handle = __phys_to_dma(dev, page_to_phys(page));
>> +	ret = page_address(page);
>> +	set_memory_decrypted((unsigned long)ret, page_order);

The second parameter should be 1 << page_order to get the number of
pages.

Thanks,
Tom

>> +	memset(ret, 0, size);
>> +	return ret;
>>  }
>>  
>>  /*
>> @@ -92,9 +99,11 @@ void dma_direct_free(struct device *dev, size_t size, void *cpu_addr,
>>  		dma_addr_t dma_addr, unsigned long attrs)
>>  {
>>  	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
>> +	unsigned int page_order = get_order(size);
>>  
>> +	set_memory_encrypted((unsigned long)cpu_addr, 1 << page_order);
>>  	if (!dma_release_from_contiguous(dev, virt_to_page(cpu_addr), count))
>> -		free_pages((unsigned long)cpu_addr, get_order(size));
>> +		free_pages((unsigned long)cpu_addr, page_order);
>>  }
>>  
>>  static dma_addr_t dma_direct_map_page(struct device *dev, struct page *page,
>> diff --git a/lib/swiotlb.c b/lib/swiotlb.c
>> index c43ec2271469..ca8eeaead925 100644
>> --- a/lib/swiotlb.c
>> +++ b/lib/swiotlb.c
>> @@ -158,13 +158,6 @@ unsigned long swiotlb_size_or_default(void)
>>  
>>  void __weak swiotlb_set_mem_attributes(void *vaddr, unsigned long size) { }
>>  
>> -/* For swiotlb, clear memory encryption mask from dma addresses */
>> -static dma_addr_t swiotlb_phys_to_dma(struct device *hwdev,
>> -				      phys_addr_t address)
>> -{
>> -	return __sme_clr(phys_to_dma(hwdev, address));
>> -}
>> -
>>  /* Note that this doesn't work with highmem page */
>>  static dma_addr_t swiotlb_virt_to_bus(struct device *hwdev,
>>  				      volatile void *address)
>> @@ -622,7 +615,7 @@ map_single(struct device *hwdev, phys_addr_t phys, size_t size,
>>  		return SWIOTLB_MAP_ERROR;
>>  	}
>>  
>> -	start_dma_addr = swiotlb_phys_to_dma(hwdev, io_tlb_start);
>> +	start_dma_addr = __phys_to_dma(hwdev, io_tlb_start);
>>  	return swiotlb_tbl_map_single(hwdev, start_dma_addr, phys, size,
>>  				      dir, attrs);
>>  }
>> @@ -726,12 +719,12 @@ swiotlb_alloc_buffer(struct device *dev, size_t size, dma_addr_t *dma_handle,
>>  		goto out_warn;
>>  
>>  	phys_addr = swiotlb_tbl_map_single(dev,
>> -			swiotlb_phys_to_dma(dev, io_tlb_start),
>> +			__phys_to_dma(dev, io_tlb_start),
>>  			0, size, DMA_FROM_DEVICE, 0);
>>  	if (phys_addr == SWIOTLB_MAP_ERROR)
>>  		goto out_warn;
>>  
>> -	*dma_handle = swiotlb_phys_to_dma(dev, phys_addr);
>> +	*dma_handle = __phys_to_dma(dev, phys_addr);
>>  	if (dma_coherent_ok(dev, *dma_handle, size))
>>  		goto out_unmap;
>>  
>> @@ -867,10 +860,10 @@ dma_addr_t swiotlb_map_page(struct device *dev, struct page *page,
>>  	map = map_single(dev, phys, size, dir, attrs);
>>  	if (map == SWIOTLB_MAP_ERROR) {
>>  		swiotlb_full(dev, size, dir, 1);
>> -		return swiotlb_phys_to_dma(dev, io_tlb_overflow_buffer);
>> +		return __phys_to_dma(dev, io_tlb_overflow_buffer);
>>  	}
>>  
>> -	dev_addr = swiotlb_phys_to_dma(dev, map);
>> +	dev_addr = __phys_to_dma(dev, map);
>>  
>>  	/* Ensure that the address returned is DMA'ble */
>>  	if (dma_capable(dev, dev_addr, size))
>> @@ -879,7 +872,7 @@ dma_addr_t swiotlb_map_page(struct device *dev, struct page *page,
>>  	attrs |= DMA_ATTR_SKIP_CPU_SYNC;
>>  	swiotlb_tbl_unmap_single(dev, map, size, dir, attrs);
>>  
>> -	return swiotlb_phys_to_dma(dev, io_tlb_overflow_buffer);
>> +	return __phys_to_dma(dev, io_tlb_overflow_buffer);
>>  }
>>  
>>  /*
>> @@ -1009,7 +1002,7 @@ swiotlb_map_sg_attrs(struct device *hwdev, struct scatterlist *sgl, int nelems,
>>  				sg_dma_len(sgl) = 0;
>>  				return 0;
>>  			}
>> -			sg->dma_address = swiotlb_phys_to_dma(hwdev, map);
>> +			sg->dma_address = __phys_to_dma(hwdev, map);
>>  		} else
>>  			sg->dma_address = dev_addr;
>>  		sg_dma_len(sg) = sg->length;
>> @@ -1073,7 +1066,7 @@ swiotlb_sync_sg_for_device(struct device *hwdev, struct scatterlist *sg,
>>  int
>>  swiotlb_dma_mapping_error(struct device *hwdev, dma_addr_t dma_addr)
>>  {
>> -	return (dma_addr == swiotlb_phys_to_dma(hwdev, io_tlb_overflow_buffer));
>> +	return (dma_addr == __phys_to_dma(hwdev, io_tlb_overflow_buffer));
>>  }
>>  
>>  /*
>> @@ -1085,7 +1078,7 @@ swiotlb_dma_mapping_error(struct device *hwdev, dma_addr_t dma_addr)
>>  int
>>  swiotlb_dma_supported(struct device *hwdev, u64 mask)
>>  {
>> -	return swiotlb_phys_to_dma(hwdev, io_tlb_end - 1) <= mask;
>> +	return __phys_to_dma(hwdev, io_tlb_end - 1) <= mask;
>>  }
>>  
>>  #ifdef CONFIG_DMA_DIRECT_OPS
>>
