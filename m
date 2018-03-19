Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933333AbeCSOBJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 10:01:09 -0400
Received: from mail-bl2nam02on0053.outbound.protection.outlook.com ([104.47.38.53]:13573
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932528AbeCSOBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 10:01:05 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
Subject: Re: use generic dma-direct and swiotlb code for x86 V3
To: Christoph Hellwig <hch@lst.de>, x86@kernel.org
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Muli Ben-Yehuda <mulix@mulix.org>, Jon Mason <jdmason@kudzu.us>,
        Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20180319103826.12853-1-hch@lst.de>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <8fcf5cf4-5db4-8197-0012-e69dc8f41b18@amd.com>
Date: Mon, 19 Mar 2018 09:00:56 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180319103826.12853-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR21CA0019.namprd21.prod.outlook.com
 (2603:10b6:404:8e::29) To DM5PR12MB1145.namprd12.prod.outlook.com
 (2603:10b6:3:73::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9164649a-af91-4dcd-fe2c-08d58da1da46
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1145;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1145;3:aUKL9jp5CjRWdaJxz391LsXlW11oRszQRECgi3dWMUcrO1oxXBOHYjSs3lPfHAAwdoNUtQ6E5pWIz0cMNFKy7vxZltLcImdRa08ewkdUMtys4ZoPyySYRww13HH0rQmtwyl16xYw5b5fbUxI7cIMDu8Ofd5uFN8bHjVKqfR77ACHQ2mvzjZoPgkcwx83XuuYSv0ath6D7Nftf8/u29FzvnwRfOr1f/4RUb5pVpkfJqYRXZg8AeKcI6kS/58QLsPd;25:e8vlFU+L2n53GsDTwHYrzq3XfikU+XsUqmf6oUni4WcCf067zdO//xDEcNyZIcBPORmaA5nEYbU3Qri3x8+TQUjRHOCYHyuwX0hOAnfR7FB+2sEWP/4Ba7hThZyCre/ZifQruRkJDWu7lEx4nJITvfsEoIKW8V398DYylS+GsO+jaUeuAr6Nggq8U1IkzRcqLutb/NKtnmgdsHjy5tpZ5Jrx6XgNHxtZsRvgdyw/7tymq/niLOfCfhaz33hjwQ8e25lrfQgmU4xVNOSlvsobl3AR5uYMI36lSeiAsy7K22glYHCOqxr2tGiBYVE1yZAUPPyJxDJdY9lajyW64ucNHw==;31:JtPQQfRLFKQ4EmV9SjE6DKm1FXlMa1p9EBp8KFXAy1UnPqJFTRW/UH4ZeyJmwePUKWvZZ2QizybCenz74Zld5f00ENXD7+clInirPIPyAdcxbCSnO8B2olgJ5bR+gmpDvqDidOgcT1hEvKerbJQxtP7Ucflc1nAYZkLl4xe+Hl8UcC37lxrEJXvysyYky4lbG4fAVwqJA8szEaSpktBCK28rE2O4eu7T13JODoxQs18=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1145:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1145;20:a3xTpB6XChOuAxXocty6TZpBmqVaAWlJtJJDC6MSNYJa9EbO2Fi/dCdwaNZejEYaZ5UEKg8Qkwu182P63wIWCBco8tQ8A87a3ArrLlVy0L0x7AUji/CDnXhmTnh9c0n53Q3gZfi00xM+82rNpbmi36YtFaQR8b08QcDyBnQw2DegJzuly9dD8swtpjwWS3DNFRyJp3ZR53zW6zmx4XICQc3ARufB7/vvysDYQazT10MC2yAepkiS66Y86YgIowMkHWJ9ruD3BaxxeRXnRUBGElWbekw4zRg72Dh89f9A3J/vjUAiLkHlcNllt9qbLhm4xxvzYjO+TbuvfHP0W10nD3nGaVHF1nWpqGCQFL8vPFI0MApHeLblDtGN0sQZjdTJQFxLsVt/SAUuWFPsyD/dO/uCX30+2BrMGEseWlFtiwmcwGODNfldkt1mIv5dgXsuegPNxV4ZrKU5M2Ycat9emciv4kZBsbxAROEBMcJWsH6ehq3zm4h55bbaXLaNBgJf;4:gHqBscfyMGyo6dryzXOz8h9yLPM4KMhFC5k3u0s17rgDpdxtCw3KN8KazWP87LcInlIcHwR2NGNz/UPNJzIUfsf+wusjVypfx0tF03pUG3aXNyDlMgkaA8BFxO2xjnF7pLPyx6AzKIoolAcMqdfJcOeWuAqMi1rZi4OwzePoiXysf7K/CalSOvSKDV72YQ3HLBMDpE25vxInRBD+09pj6afDWjtRl1J4pDbqlgO3tXiMGQ5+DFNe+krhq33iLjZDdMLv+D0qJvUvEVpP1zBigsaHYXUedxxWBDTrLJSdEnONLYy7Q3JPQWwYKMBWKNtk
X-Microsoft-Antispam-PRVS: <DM5PR12MB1145E8633E0B9DDA0D3318DBECD40@DM5PR12MB1145.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501244)(52105095)(6055026)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR12MB1145;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1145;
X-Forefront-PRVS: 06167FAD59
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(346002)(376002)(366004)(39380400002)(39860400002)(54534003)(189003)(199004)(53754006)(186003)(316002)(478600001)(47776003)(105586002)(230700001)(68736007)(86362001)(52116002)(52146003)(76176011)(2486003)(386003)(23676004)(72206003)(5660300001)(16526019)(53546011)(8676002)(81166006)(36756003)(81156014)(77096007)(66066001)(8936002)(65806001)(26005)(65956001)(6486002)(305945005)(6246003)(16576012)(54906003)(31686004)(31696002)(106356001)(6666003)(25786009)(50466002)(6116002)(3846002)(4326008)(7736002)(65826007)(64126003)(2950100002)(97736004)(229853002)(3260700006)(2906002)(53936002)(58126008)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1145;H:[10.236.65.116];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIxMTQ1OzIzOi85TE5UYlB0OUZVWVJWZEE0eU01ZkIrc29n?=
 =?utf-8?B?MkFHOFdQdXdXVEJEbUt6UFlCV1pjZkV0MXdYSXpTTVVaallDbW1KN053S2sw?=
 =?utf-8?B?aWJUWG1hWUNUZ1JhM3E4aTJWT2ZsN1RBZW1JNE1zNFJUU2MvUU5KQmk2ZFlZ?=
 =?utf-8?B?NHJYMTY3QmpvSE5wQzYzZWhER2ZJU2RJc0REdExEUmlLRmRBVVFnSmdmMU5i?=
 =?utf-8?B?ZFZHVnNlbDJLdnVDODIwVEhUVjV3NUg5T3EwQXhTNUc3dG1wb1pWdnM0Ty9F?=
 =?utf-8?B?eVlZbXNQVnE4b0VYTHRQa2NsRDRTV01Mc3FLck9nNmtYUGNFYVBvM3FRMGJC?=
 =?utf-8?B?RVhDRTR2b3FFYnhHekkrK0VuNUxhRzFuVHNtd1N0dVVDTUFpSFl2TlJqZmM1?=
 =?utf-8?B?M3h4YlRlUkdEc1Rlcjc1Z1N2dUVFNy9ONTVoYjg2MDNHSmxlSVVPMWRkeXhN?=
 =?utf-8?B?SU5WUVFzbEFLYS9YbXVDckZnSmpIRnZDNVd5UGZnWWRVbmZ4RnZWbFAvRldV?=
 =?utf-8?B?bHcyTExKbXRLZ2xoamJGbTg5ZmNrZ05UVUZ6ZHcxV2RvSVBIcFlqV3g4cHd2?=
 =?utf-8?B?alpUcUVMSUU5ZThLTVVIZmFRd2hyVmtkSXZ3RWVmVmsxbVg4aWo3c2tySjJC?=
 =?utf-8?B?d01rR2pNZmpqbllyQXV6NE9QNHo0V0duNmVDOGtYbTkxcS9NOEtrVXozSnAz?=
 =?utf-8?B?TnhlMHYveXNnREpDdEQ1NmFWUGdmUG5pc1lNOVdNTkg2ZHpwc3AyK1NQbzE3?=
 =?utf-8?B?dE5jVnU4blpmVkdYR3ROMmpPL2YxYkpBaGZTTVBlUzlBMDg0aCtkYW83OWNE?=
 =?utf-8?B?V09TeTNoUEFsVUxqaDhuOEg1U05ydHlhWW4vZUJoVFlMRWdnRmppNW1FKzRa?=
 =?utf-8?B?eHkxZ0FGc0t3MER5dTNaS0RDcksrK0hMQWhFQmNSRCtXZHlNakxqMnM4MkRK?=
 =?utf-8?B?dnRObUxITnBFQmExZVNMQ3A3RVNyZWgveFpIMWsrM2FFV05wRmliT2pFNC9X?=
 =?utf-8?B?R2ZDd1djaExwOXJLYWdUTXFYbjZERVJzVjB5bWpPa2NvOFc1K1ZyYUN1U0l1?=
 =?utf-8?B?Y0pyZjJld0N0djIrdEhJSU1WRTB3R2tuSk1rSkZZVEovb2ZhbHhiWkxrRG10?=
 =?utf-8?B?eEFOOVAwaWFNU0RrUE1lZWdVdHNiSm5tSEczUVlVbmJOY1RKcDZTZVZHb2Rr?=
 =?utf-8?B?eCtVbE0yUXMvdmhyTkRCVDVMUHlqcWoxTjA5MEFNbWZvQjBwN2oycEtYRmJP?=
 =?utf-8?B?TXowYnU5bGVuaFhzUm1sSTB4R1JDR21jeDhnQnBiRS9xYmdCRmtHYU5Rakxx?=
 =?utf-8?B?R3dBMDM4dXFibVNReGFFMUJtTzVIKzVsQ2JORTJrbFhLTlBQUkhyZ1NLZm1p?=
 =?utf-8?B?OFRwQVVFMTY4ZjgxUVlvcjdKZ0h5R2ptSmRtb2swSDZUMzNPTkk2dldLOGJa?=
 =?utf-8?B?VXM0cFp5VVU4Z1ZHdm8yMjc1NS83QWYrSzg3OENWU3REanNFU3dOQ3o4Rldo?=
 =?utf-8?B?NWc1N1NtS1hjOWRuRkVJZ3Bydk1pam9ib1dNMUQ1ZFptWVRJT0F5SUZMUFY4?=
 =?utf-8?B?N2dvRnpteWtDQ2pBakw4Nm1CUmw5YzJaWlFVd1Nzb0pUaDdjaE5aWTE4MkRV?=
 =?utf-8?B?cGx0U2xlRC9pYjlHTXdPbFBKS1NoUGo3T0Vadml6R1VNSnpJcUJxckVjeERD?=
 =?utf-8?B?RGZMeEpQaEg4NkxWSlM2bDVGblJKR1gxQk0wRmVCQzFSSVJsNTdHMDl2UjhT?=
 =?utf-8?B?dnBSM0FENkMydlhsZUVIcnhLTGMreSttNmw5QUM0Zm9uek5qdHkvMzdod2xw?=
 =?utf-8?B?U2F6OGFOMWNFbHhiemVuL3NNT0pLQWlvSnBlcjg5S3AwcXBnOFBrYi9WQmxR?=
 =?utf-8?B?T3pidCsyOGRUMzk2cUZiN3JzYVdQTC9NcXJjY2VUUERhVktJYXJPTktiYXBS?=
 =?utf-8?Q?ykU/XqifurjzwFzNhmMB/PWsDjiZWc=3D?=
X-Microsoft-Antispam-Message-Info: nCfHXSqLCu82aHLlPOmbY7D4ewKD47jYb70AQcUkwaPZaiPDf2RCyKFEsHVjbHr9PCuxCBe0uOHhLDCczAe925sgTKwKn05gCbrSkvlWW7knaJWYyk3hMGzxb6Es+h7Ksf4idza0sA5zCLT3CP5+bYy6zKh2v1PzSqxrR7m0c4sub0kTAQCIBOdFCGQrbLMZ
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1145;6:dv2zZf6Gc9WIhK5QVynhmK72J/syhKL3UDWIW2cfB4qJwOEg37R6YqlwR2hnQ0s1KJwIaCNco+tZ9f7M8lWYCmHYUR4ALvqWDcnwZmHIC2EG7uSMl95wmcbq/tdIO8pMUfXq0rzBP0eIDpHMLvDYWOI84kxWxGOEyfE5wIv8ufNOvH6H6KSu/apPLK7aw0FpoIedjeGpBKFWnVTJdv7X6wbL3Nks1FEOlHQtTc33tIxxSaLfsFUfMnNIlf1njv3MYfRiw8W1Jp6SFaeZ4n05+UZDgm6l4Xv2fpr5q1nV8oYuEFvIzfuBwNwqB6y/XsvLz0t3a+fjG/9t8m2delm4z9xr7EnOoXvkwDGxYZizMeI=;5:z7m1+Aw6FjmoiVxfwKx3b2bqfDRf0lsgVJjoy1LqTy26B9uUS+KblJqnxr8V2tsVAfRahlk+x4J60C0uBuV5T+1aPsYH6g9bf1EZKqVXKE3BFeDJe3U5GlAmnwNrZr/WpL6Lq0kWd4zKswB5nxX2+wcotKy6m7pW12iPm+Yi3cY=;24:TgRjRBsaJ9+2qw/vU7cY4UiLP9AWQA8V1ZUSiS22QuMgXzzTN1G+poYdjgvg+jKzhQaqWaxH0Fx23Vl3qNlBWA2BxRXUKh5dp6XJvPTO4SY=;7:6GgZZMyWgYUHw0X4TvW9B4JDVLyYpCU3XWZwhyy4vI8eHacU5/cS3cYvGPhCfVcaMOeqk6YcdtPgva4RbV81VeDVuwLVVCGrsCahk4uGrfZa423P4fOOJRqZr4jaFtE6t9X8IK7pE1TBl3yP/jYu17IplfMZKyFEOlA2qlVo5WiWqDiVEStnM1/n8CaaX6W9YVxrG3lA05IbP2B79MAuz0N2RxZ0PKizc2runQvVqW6Jp5IszoW1sq0xUoSdkL2U
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1145;20:AXgBxMHna1VYc5zNXTknV2fecqKcValG5Au6JxwEhtglgzmTXHe+1qVeodQy8hsSyjwfIEtHsUx+2o2t6DXDW4N/0g0hjS/CfMMsH185bu7E5g5ScMxT1zn2/YPS7sqFbEMfnpMYpd9iSlB/c8MPckmN3nxqDfri3RRKc32tImVMvFEWmKapkW2bh4aPC3HnTwexPo7ppsr8yyRAOzbe+U6aR2REdWheo+oj7ktE16lheAaX1yKYxT+xlF9y+X4E
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2018 14:01:01.3348 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9164649a-af91-4dcd-fe2c-08d58da1da46
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1145
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/19/2018 5:38 AM, Christoph Hellwig wrote:
> Hi all,
> 
> this series switches the x86 code the the dma-direct implementation
> for direct (non-iommu) dma and the generic swiotlb ops.  This includes
> getting rid of the special ops for the AMD memory encryption case and
> the STA2x11 SOC.  The generic implementations are based on the x86
> code, so they provide the same functionality.
> 

Booted the system with SME on and off and the IOMMU on, off and in
passthrough mode without issues.  In each case, booted an SEV guest
without issues.  I'll be able to do more extensive testing later, but
for now...

Tested-by: Tom Lendacky <thomas.lendacky@amd.com>

> Changes since V2:
>  - minor changelog tweaks
>  - made is_sta2x11 a plain bool
> 
> Changes since V1:
>  - fix the length in the set_memory_decrypted call
>  - fix the SEV case
> 
