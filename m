Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755506AbeCSOv5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 10:51:57 -0400
Received: from mail-by2nam03on0048.outbound.protection.outlook.com ([104.47.42.48]:41120
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755392AbeCSOvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 10:51:55 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
Subject: Re: [PATCH 13/14] dma-direct: handle force decryption for dma
 coherent buffers in common code
To: Christoph Hellwig <hch@lst.de>, x86@kernel.org
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Muli Ben-Yehuda <mulix@mulix.org>, Jon Mason <jdmason@kudzu.us>,
        Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20180319103826.12853-1-hch@lst.de>
 <20180319103826.12853-14-hch@lst.de>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <aa92adb4-2d93-831c-3f62-9f7281e18fc9@amd.com>
Date: Mon, 19 Mar 2018 09:51:46 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180319103826.12853-14-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: DM5PR06CA0054.namprd06.prod.outlook.com (10.168.110.144) To
 BN6PR12MB1139.namprd12.prod.outlook.com (10.168.226.141)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c4de4ca2-3a5c-4a47-c4e2-08d58da8f34d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1139;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1139;3:u8oaV1Cca9jaD8U+nYim41osM7UZzDvH75G1M2iB8TPhjhqOQ4nj+q8FW32pPWhF2vp4uxNR09VKD1+W+luuodxwgGNj5rXf+fUEfsZEQRMNdECQMewHHslP1o2dcbciMdf/l+5PV3UyrOrUSaqkWq9LkF+LplvWUbF47HWriCrMtfSYIZKH272JLjVY5DSDnIczlOK7xgYwEHNzJORCtTn1yalWKmRditlhBBvzT+9WAIRyaMiPxKQXe59IJBdA;25:rXCjzRvUMyiDLMBXk8Np+OcScULiTl/0jS4QjelNLZmA8gaQ7+wfWRQMbBZmggHE3FwzZuSEUeITQeZ2xc1g2PXW+wZbubrSJOGU02UCOZ2kGUwpr4W2+bUsZbeI5sHfot0xIEXnG8kDc+UTwB6MH7Zg0fos4FspTdNxD5DlwHQs2aYN2SNPxX5ybXbcecCub8AoHYyzyrh0PlXLHypqw8InS4FU6SV1sCJsOSrcjaos3JU7nn4v8zMD99/mKCFiUaaarN67aISo82/vV0UaobyEQfG7mYVyXhB9w68a28IbyzfvEposOw6GjtLIgXWDIiCR2OjnXAR8+SVAVzvUXw==;31:I9xexswtDRF3yFByorzFUM4/AWF8ZvPj6YlRMfF47cIQw5yKKtg066CcfOR/8atmJzBC8zT2hJ8E4NYX1VJgoc4E3rAgv1/Th5h7uKuKd7qJQJqwDHFK3A9ZC15gUepx3bCeBktjf2R7QNHiUm98PShMF6Rnx03jrguPA5KKvSlOIJVDcqHS30tn11Pu57fvQpu/8eexMm06fZwjLXjC1xw7czZKQSGgEs2eQeFwjKA=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1139:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1139;20:GMAzPfHLjW5BOb16dFf7DacxZam5tE5gV0w8/evsyPsF21bK8ufs6PzWGZs8ErfyGuPg8yIzKAyARlmH59MCqypAUN+RsiQ7mM+EzgcaP6h8G5SZHkfSRYMlGp0KRTVRt8Bok1cN4Ltiykmk0BC/L6yt/xVKLhtoggfsT+nU1U7n3dPicvGx0Ca8MBBQ+JV7cr1BmQZTImKVFHsxslPZAmi/TM6fMBxRUQuhNgNp6dPZZMM5iFfyh68Ztur7K8fEgDtjsKToLEeejxShiFQZ1kk3DrCwzzV6QNdyrCnsSpCboTamApdn43N0wNAPmMoq+eopoOk7RBsdGZrE3WbyECZkdBtp17FOgy93ZMJErqTfoOhJnHHvfJYTC6LsaAhWYcC12GUb9MCzXa0D6okj2FDhIRX00lyJrwD9X9+KtQRmVDWBmmLNBN8LvKGXyfwFwhTG32gmt472URnPhCn3nnNzYZUUMi7ycjaICprhQKZhq2LrcJmntATFb7FPsGBM;4:CYc2JgHESYxbvWqhIJl3kR4DcphlH5n/PJIup+ZVPJPMy4uJURz8pbrK85NPCG8ofVur1651z2UM+mpT7bSnDwuGfvF5Neu8Ig8qw05MfzoYf/hvj2kmIRDRUHcvdVfqMyIdG6q0Se233xMHzcpkqx+foUVxxulEvp/TVZv/j2Km7sA5KaCRxQEDxtK7TAKSu4yW6dc95DwTyOim/k29Wxi8OA5IEALraePzTCKIbKOCWW12k8s/KQfDn93IU+2mI2D3JCTfJHpXLOaAuO/62oUEKOzzkra1sSq9fwzQerXcjoZ//T1NAYOwJACcwU64
X-Microsoft-Antispam-PRVS: <BN6PR12MB1139F8BC45A9CAAE656EE4E5ECD40@BN6PR12MB1139.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501244)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:BN6PR12MB1139;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1139;
X-Forefront-PRVS: 06167FAD59
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(366004)(396003)(346002)(39380400002)(39860400002)(199004)(189003)(106356001)(6246003)(305945005)(81166006)(2906002)(5660300001)(81156014)(6486002)(7736002)(68736007)(66066001)(3846002)(47776003)(6116002)(8676002)(65826007)(65956001)(65806001)(54906003)(97736004)(6666003)(86362001)(58126008)(575784001)(31696002)(4326008)(53936002)(3260700006)(25786009)(31686004)(386003)(53546011)(229853002)(16526019)(52116002)(52146003)(76176011)(478600001)(2486003)(23676004)(64126003)(50466002)(72206003)(59450400001)(230700001)(26005)(16576012)(316002)(36756003)(105586002)(186003)(90366009)(77096007)(8936002)(2950100002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1139;H:[10.236.65.116];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjEyTUIxMTM5OzIzOjFNRy9OSVlHaHkyYnA0RU1KTFhHNW81SXBw?=
 =?utf-8?B?MmhiUmJFNDI2czFEV29iQkVDcjlnMlZUQWZvb2lwVWZrbXUrNFAyRDUyaUFi?=
 =?utf-8?B?U2lRc0RZQTVuVDk5YVNlU0pteEdxOFVFWHpWalBHL3YzWElwZDJtT3VETmYy?=
 =?utf-8?B?enVSNUtGaURUdGJMOG1tdHJ1djBsUE12WE9YY05HMjJwVTBsZGhuRWdaeGNO?=
 =?utf-8?B?K01DNXR6M0M2Sm1wK3Z2dHhFOG1VbTVHd0duem10VUlYM1NCcWZoLzh1eGtZ?=
 =?utf-8?B?TFc3Mjc0TWljOG13dWo2N2x2VDFxaCtxSjE0T3lNa3BSamxrNi93MjQxUVg5?=
 =?utf-8?B?eVZOZFVyUUltV2hUODRCMGpwK3QvTmltdWQ5ZU1YczY1MnNFVEljdHRpRlRO?=
 =?utf-8?B?dytycVRsbXpuYUw1b3ZGRmpVam94NC9MUm9nVGNRRWQvU0RVNWdyT0hUek03?=
 =?utf-8?B?NzFCaFJSdW1IS1hMcGxybkJ4OTIvY2lvQW96cUdDdDJ2OUJaRHA2YXBWN092?=
 =?utf-8?B?WElCamNRNWxoWlkyMTNzcFJKWTRUZ3l1dXJuR21kMEg3Mk1QaDJDMFZsWlRi?=
 =?utf-8?B?aVg0M016WXhMd2JVeWMzWFR3SENzVExRMmszTElGS0ZhWEdCY2dzRmk3RFRr?=
 =?utf-8?B?b0JZaWxnUVRGeUhaL0c1M1BEajdwbGtoZXBSNG9ZcUk5Z2w3M3MxT1h6OUNv?=
 =?utf-8?B?UGNNcWpYZE1ub0dmL1ZDOExRYXJ3V093NlFWakJ5bTlncWRIdXZpTWJRRlVs?=
 =?utf-8?B?V1JsUzZieUFralp1TmJPZXdPM21EY2UwK3M0WmFYNHpkT2VlVnJsbnRGOTJj?=
 =?utf-8?B?b2RKRlJXOFpydGdqM0kzVmo5QVlCLzRySWR0WjFjeUp0dk5wN1RNVFh2S1Y1?=
 =?utf-8?B?dm05VWRjalJTS0RsS1I1dzBjK3dNUmF6YlZiaUpBVnBiWjhmeVNaU00zSk1k?=
 =?utf-8?B?aHhiT1A5NWVWSHlxVnZiU3B1em16MUNSakIycE9CYjRTdnNLU3dEOHpoSCs4?=
 =?utf-8?B?RDVBR3Jna1V3U2VCTHc5c2dKQTJkdHJqR2MwRmt6TEFRRnFGUjYzb0wwd0dO?=
 =?utf-8?B?RHQ0bVpzL2I5RGZJQnBVNFA3R0FrVWU2N3p1MDhjMDZ2WXR2MWRRUlJ1aXRt?=
 =?utf-8?B?QkZzUDdxN1dmMC9mS1Y2THFOa1FidFdoa0p2cGFPdHdRL1Z1ZFlGWjM1TElv?=
 =?utf-8?B?SEtuTmJvRmRYNnhQbHcwZFU5WUczK01zNFR6VmY4QnJNUXRZNGdoNnczN0d4?=
 =?utf-8?B?M2pqN0ZRZzNPK3A5cWZCZ2lVY2JzREhGWm94aHVYT0t4cEwxaTNCWVQ2U0dG?=
 =?utf-8?B?S0NhTXVqWDdBNkJmWnpQbFZLSTdObjZ2MnZ2WmdMMWZWbTcvMDZxNU5XRkJj?=
 =?utf-8?B?aHpXa3B3eGV4SHpXTlNJYTA5NkJSSWZyajRwbm1WeGNCT1crQUtVbkVKZ2Fo?=
 =?utf-8?B?eDdhNmh0eEJEdHJ4Zi9VYWkrUTUzRnVKVlBTTGlCOVJCcVdSV0R4NlNndWxm?=
 =?utf-8?B?enM0eENrUnJPVy9aS3V1bWh6WGhkczN5NW44RmRDcDhjUUFkelNEaWJyT0xY?=
 =?utf-8?B?bmQ4NXdnMnBpRW5UTHJZRXN5RWRmSmhUeWNYUmVBS2s3NGNSc3UzZ0V3WU1T?=
 =?utf-8?B?amVzZXpDdUFBN05mNE9XQ3paYkd3TUVPMklwV0J1VVNZRzdaTEpwS0x4OTRE?=
 =?utf-8?B?ZTEzMmZYM2tKN2NKa1habXdZSmQ4RjN1dU5vUk5MY01YK3VId0hleHF3S2tT?=
 =?utf-8?B?YjhlUU9TZVd1U0dxWWZPSHBTM0trUFBES1pKMVpQNG96WlE4NnFUYmtkenRG?=
 =?utf-8?B?by9GUUVkMnRSN3A2Yi9EZHQ3WjZMK2UzVUIyRG1VOHpnbXRlOUNqbW4yN1R3?=
 =?utf-8?B?bHlVVGFVd2RRL0tRZlRNVDZLaFE0RFZPS3lQaWVtWFBWWTh5UmdrYndPYlJk?=
 =?utf-8?B?c0FKY3dRUWFndWRXM0ZkOHh1Ty9JdS9kcE0reEYyaityVnFCRHZpOVN1Q2Mw?=
 =?utf-8?Q?DELsLQ?=
X-Microsoft-Antispam-Message-Info: gnlB1QhW35B6bwNc6gA/suSna+hWW3ClinvTAN9xbOP36nxGn7BNhqwScPsC7Inb6dGc4yOxTHfN9RuLzLgfIJIAolAv8IWp71D2ZFdgBplE4JNTXYMxlcKTXQxI3apgfN2CB09NI1TNuSQ3d1dvwQ2w0r+cof8Sf1yu9NG1i3IMFG72QDNmU0CvADNWMqFJ
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1139;6:MGUJAYGlljpz25itzZTSHY2C6YE8cZPTrbD1y6MvNRGiyohLJSLWZWDOO1O07vf5nwugaV5Uty/x399jHb4X8ydKMUK8JNYwj1/fEvgtbZEk0KdUWxxQZGWnpFT6Ux9AGOq1X2C/CybejkuesZ2aTSCwIMgV53vdRihwEYMzd3nGXFvfCLaXfbL6LGRGsTbLOsVW2wP3YT6x1PUivLgErwYephhcJeq0JhCGovqh2LNEFSUeHkccnKcpmgWJo8bbG9mufGspwZHrdIJsvxqbJDbilxZgxe0cbzdeCOO8Wich8i1urG/hI0CbhMSA9baQuyQfD/vq3jAU8DWEgW4dzNbN10GsRn6BHlikOEdjtzo=;5:4Ueik/lP0Ey8B8voSVQiuEl4fbyTd/6h9OdZdc7+ij2T6DVB5WzUmOTgmPVHgtPqtZSSXb+Ias+gsLvZnfp+RgcSI4mh78ZOo0ip83dhgnz0w3xiG7xrC58TguDMpASsjAoKwiJ6vTmLyljDyXOyJBSu9mIuGoTOIXITvT+r8z0=;24:RjlUzUqWa69MbbIPiitOevWuHx+G8+HkL4BJpae1t+cnLdjH6Vmy8J2Jx8crJSZ7h9ateMa4FVfqoDNJRunL23t80SID69e+vFdqgsdZPZ8=;7:nPy2tTQaCjQDgXGTkvnGMti3vGIz+8Gsi5AalxYaryO/2gxQeYeNim/EE47KlqlKmQwYXYcPeRm1bM9BLICygCPg7YmAeYBtNoq4IvNaCHVrkpf1mcQKDm9FDqyvaLArBxVx9TG9gY/97xQpXMChNOy6RnbRGcgVldU/w4fHnDM4eXo0vXRfy/ly7U9h/cpjD6fiwadQNOPZWwpv0frrokgCgfYzBb7qtSVkgmsyJz1Vrq3f1UjrcrnAMinFctKg
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1139;20:BieKoHT6QRivrlDty3doA1VgzNlnefBlPPhuXlqIHS/i8N0UKTJWV7z7wN4eu9zKb7V/tVmbkEroBNa+p4fQ6KarlFrkgqSltAaafH2uE+ZCFhMd6vLz+KZS2bxTRO9MrjJ15o15JLncNX6TGZS667poYY/qVrlkprFBfZogpk1L6cvP2YPpTzRkIqi5V2kSmbiQCMXs18V+6dAY5V09r/UjYXZ6X/ASe5JDm/es1x0nZXYNbd3U8xAen5mACxaI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2018 14:51:50.8106 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4de4ca2-3a5c-4a47-c4e2-08d58da8f34d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1139
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/19/2018 5:38 AM, Christoph Hellwig wrote:
> With that in place the generic dma-direct routines can be used to
> allocate non-encrypted bounce buffers, and the x86 SEV case can use
> the generic swiotlb ops including nice features such as using CMA
> allocations.
> 
> Note that I'm not too happy about using sev_active() in dma-direct, but
> I couldn't come up with a good enough name for a wrapper to make it
> worth adding.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>  arch/x86/mm/mem_encrypt.c | 73 ++---------------------------------------------
>  lib/dma-direct.c          | 32 +++++++++++++++++----
>  2 files changed, 29 insertions(+), 76 deletions(-)
> 
> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index 1a05bea831a8..65f45e0ef496 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -200,58 +200,6 @@ void __init sme_early_init(void)
>  		swiotlb_force = SWIOTLB_FORCE;
>  }
>  
> -static void *sev_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
> -		       gfp_t gfp, unsigned long attrs)
> -{
> -	unsigned int order;
> -	struct page *page;
> -	void *vaddr = NULL;
> -
> -	order = get_order(size);
> -	page = alloc_pages_node(dev_to_node(dev), gfp, order);
> -	if (page) {
> -		dma_addr_t addr;
> -
> -		/*
> -		 * Since we will be clearing the encryption bit, check the
> -		 * mask with it already cleared.
> -		 */
> -		addr = __phys_to_dma(dev, page_to_phys(page));
> -		if ((addr + size) > dev->coherent_dma_mask) {
> -			__free_pages(page, get_order(size));
> -		} else {
> -			vaddr = page_address(page);
> -			*dma_handle = addr;
> -		}
> -	}
> -
> -	if (!vaddr)
> -		vaddr = swiotlb_alloc_coherent(dev, size, dma_handle, gfp);
> -
> -	if (!vaddr)
> -		return NULL;
> -
> -	/* Clear the SME encryption bit for DMA use if not swiotlb area */
> -	if (!is_swiotlb_buffer(dma_to_phys(dev, *dma_handle))) {
> -		set_memory_decrypted((unsigned long)vaddr, 1 << order);
> -		memset(vaddr, 0, PAGE_SIZE << order);
> -		*dma_handle = __sme_clr(*dma_handle);
> -	}
> -
> -	return vaddr;
> -}
> -
> -static void sev_free(struct device *dev, size_t size, void *vaddr,
> -		     dma_addr_t dma_handle, unsigned long attrs)
> -{
> -	/* Set the SME encryption bit for re-use if not swiotlb area */
> -	if (!is_swiotlb_buffer(dma_to_phys(dev, dma_handle)))
> -		set_memory_encrypted((unsigned long)vaddr,
> -				     1 << get_order(size));
> -
> -	swiotlb_free_coherent(dev, size, vaddr, dma_handle);
> -}
> -
>  static void __init __set_clr_pte_enc(pte_t *kpte, int level, bool enc)
>  {
>  	pgprot_t old_prot, new_prot;
> @@ -404,20 +352,6 @@ bool sev_active(void)
>  }
>  EXPORT_SYMBOL(sev_active);
>  
> -static const struct dma_map_ops sev_dma_ops = {
> -	.alloc                  = sev_alloc,
> -	.free                   = sev_free,
> -	.map_page               = swiotlb_map_page,
> -	.unmap_page             = swiotlb_unmap_page,
> -	.map_sg                 = swiotlb_map_sg_attrs,
> -	.unmap_sg               = swiotlb_unmap_sg_attrs,
> -	.sync_single_for_cpu    = swiotlb_sync_single_for_cpu,
> -	.sync_single_for_device = swiotlb_sync_single_for_device,
> -	.sync_sg_for_cpu        = swiotlb_sync_sg_for_cpu,
> -	.sync_sg_for_device     = swiotlb_sync_sg_for_device,
> -	.mapping_error          = swiotlb_dma_mapping_error,
> -};
> -
>  /* Architecture __weak replacement functions */
>  void __init mem_encrypt_init(void)
>  {
> @@ -428,12 +362,11 @@ void __init mem_encrypt_init(void)
>  	swiotlb_update_mem_attributes();
>  
>  	/*
> -	 * With SEV, DMA operations cannot use encryption. New DMA ops
> -	 * are required in order to mark the DMA areas as decrypted or
> -	 * to use bounce buffers.
> +	 * With SEV, DMA operations cannot use encryption, we need to use
> +	 * SWIOTLB to bounce buffer DMA operation.
>  	 */
>  	if (sev_active())
> -		dma_ops = &sev_dma_ops;
> +		dma_ops = &swiotlb_dma_ops;
>  
>  	/*
>  	 * With SEV, we need to unroll the rep string I/O instructions.
> diff --git a/lib/dma-direct.c b/lib/dma-direct.c
> index c9e8e21cb334..1277d293d4da 100644
> --- a/lib/dma-direct.c
> +++ b/lib/dma-direct.c
> @@ -9,6 +9,7 @@
>  #include <linux/scatterlist.h>
>  #include <linux/dma-contiguous.h>
>  #include <linux/pfn.h>
> +#include <linux/set_memory.h>
>  
>  #define DIRECT_MAPPING_ERROR		0
>  
> @@ -20,6 +21,14 @@
>  #define ARCH_ZONE_DMA_BITS 24
>  #endif
>  
> +/*
> + * For AMD SEV all DMA must be to unencrypted addresses.
> + */
> +static inline bool force_dma_unencrypted(void)
> +{
> +	return sev_active();
> +}
> +
>  static bool
>  check_addr(struct device *dev, dma_addr_t dma_addr, size_t size,
>  		const char *caller)
> @@ -37,7 +46,9 @@ check_addr(struct device *dev, dma_addr_t dma_addr, size_t size,
>  
>  static bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
>  {
> -	return phys_to_dma(dev, phys) + size - 1 <= dev->coherent_dma_mask;
> +	dma_addr_t addr = force_dma_unencrypted() ?
> +		__phys_to_dma(dev, phys) : phys_to_dma(dev, phys);
> +	return addr + size - 1 <= dev->coherent_dma_mask;
>  }
>  
>  void *dma_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
> @@ -46,6 +57,7 @@ void *dma_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
>  	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
>  	int page_order = get_order(size);
>  	struct page *page = NULL;
> +	void *ret;
>  
>  	/* GFP_DMA32 and GFP_DMA are no ops without the corresponding zones: */
>  	if (dev->coherent_dma_mask <= DMA_BIT_MASK(ARCH_ZONE_DMA_BITS))
> @@ -78,10 +90,15 @@ void *dma_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
>  
>  	if (!page)
>  		return NULL;
> -
> -	*dma_handle = phys_to_dma(dev, page_to_phys(page));
> -	memset(page_address(page), 0, size);
> -	return page_address(page);
> +	ret = page_address(page);
> +	if (force_dma_unencrypted()) {
> +		set_memory_decrypted((unsigned long)ret, 1 << page_order);
> +		*dma_handle = __phys_to_dma(dev, page_to_phys(page));
> +	} else {
> +		*dma_handle = phys_to_dma(dev, page_to_phys(page));
> +	}
> +	memset(ret, 0, size);
> +	return ret;
>  }
>  
>  /*
> @@ -92,9 +109,12 @@ void dma_direct_free(struct device *dev, size_t size, void *cpu_addr,
>  		dma_addr_t dma_addr, unsigned long attrs)
>  {
>  	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> +	unsigned int page_order = get_order(size);
>  
> +	if (force_dma_unencrypted())
> +		set_memory_encrypted((unsigned long)cpu_addr, 1 << page_order);
>  	if (!dma_release_from_contiguous(dev, virt_to_page(cpu_addr), count))
> -		free_pages((unsigned long)cpu_addr, get_order(size));
> +		free_pages((unsigned long)cpu_addr, page_order);
>  }
>  
>  static dma_addr_t dma_direct_map_page(struct device *dev, struct page *page,
> 
