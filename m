Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754315AbeDAUmB (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 16:42:01 -0400
Received: from mail-he1eur01on0052.outbound.protection.outlook.com ([104.47.0.52]:36592
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754269AbeDAUlz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 16:41:55 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=talgi@mellanox.com;
Subject: Re: [PATCH v5 04/14] PCI: Add pcie_bandwidth_available() to compute
 bandwidth available to device
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Tariq Toukan <tariqt@mellanox.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Ariel Elior <ariel.elior@cavium.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        everest-linux-l2@cavium.com, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <152244269202.135666.3064353823697623332.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <152244391143.135666.12548496808512444463.stgit@bhelgaas-glaptop.roam.corp.google.com>
From: Tal Gilboa <talgi@mellanox.com>
Message-ID: <7b82d160-002f-9687-ad80-5aaff639d7ab@mellanox.com>
Date: Sun, 1 Apr 2018 23:41:42 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <152244391143.135666.12548496808512444463.stgit@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [79.177.226.85]
X-ClientProxiedBy: VI1P18901CA0004.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:801::14) To VI1PR0501MB2608.eurprd05.prod.outlook.com
 (2603:10a6:800:6a::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 354b8c78-03bc-452a-399f-08d59810fec0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2608;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0501MB2608;3:EDl5Gmp8megAwM3xXKIDbBJgOclGUZvVxZUn6KKafk9R/EreZaHH5CltvHjD9O1AxVvqwFkyxK6JDO9u00i/CvlaTZ6LbfGo/71Rt442TET4EyAnN3HInsEtSRAYzqa5FJTShkEniiyzxitWgyd6e03zXFzo+1cwfC2e6jlxyignzANLshcG088D3Ds/6QEvZoECUxzBh8QUEujhJUqlPkZf6akicFJqX7XZ/3Mq9TV7DMyri0Ub+tGn5lDA9FFP;25:TlHVq5ClRFxQQFDcJYaZ4qr5WzQEehSSIgtSMA/mIUNylhfMRDHrYG8jb2cfblnP3vHeHa2/u/AtmWKoWJK8PI2vrpWHcXhDorO2nl8fxb8UknWlI0iLhYCG9lbBw4CWPOoIROvinnQfWnoRkwADayPiLAezdSqT7WRnyyhahAmhqca+UIaMW/H/I90R2rMjq20vC4qeFvEct1kxdaMwHCEtafP/NhzWg2As2A8bqY5qebmPJovC1jtKbQjIcXr6ryVc/2CazXzmSmYQWnxbyh6JXK/FdiXfyvqoKapN6PVlF+xE2q5G/0bFy1mGKm70v4kYnK1/qL9igIsVgVpvNQ==;31:sI+BX4pWvPpvczepJC3DNLGQ+BLmbhWcslRr1x7P4leV7IBZQhl9Ni0iVhsdpCUggdxKac9hNcxKDVy+TbE4DCoJezgDtTzuciVL4HIRmUbIkXkl6Wf1l5ROsi8FeryYgzn1el5xfJT8KwrvD3w2mDwRJ9+4w0gXAEJ+EkjzwUcPTnR5e+FSJtXw1iywjzx4KMsbvPJAII3rwJPXcfG+BpWAXfFUOqJS/578rpfhpkw=
X-MS-TrafficTypeDiagnostic: VI1PR0501MB2608:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0501MB2608;20:pLo1vFYBLzaTmWHSP5uPeL5y9XQo8dSWXg87TaSSFaQ9uuSV6kQ8XGEg22sbwd2NvAnIyDffp6AaCTkQk8XabTmSa657VgfG1Pijvt2L16kpbct59De70tF3Hb7JHck9HwHth0pM5zDT4PMjwl8ylyKDX946lQcFsnHe0jsWBYbYRGtWtGlA5JBjaquTT+pvPoSRk/5OrarlnKmXkgsI19CQblDhElF1qVmRtJi89t8k+717Zy05T7PhnK727Gipfe3kyiizOJc5j83Ve3FqdFlRMFLzWoc3hQqQ+hJT/7xT+cP85ljxgx4VG2VfPNCcra6coCjGj90sKB6pjZxLc3zksYgnBNzJitJsWt7mx6CfIzKTV1wMWiwZJrW2mkHCPfD1G+TyucEyA3r1kwvXJkSJobL2UfwoGTR/njUlbt9vaPS3ZVIF4x3J9Yp3exL62zV3IL79C0FR2eZcBf+zQysWG1f+ymuQP5qATLNGQUZ+DOn8Zm90LYXQ4PjaHsG3;4:5HD0G6MPZ/5VQB4xh9jfVsaNq5zU2wAxjdovDkPkmiS51F3gqZ6/YKW1VE7PDdtv0WIvwCip7COae6OeDNZZr7FkLEZe/DUc/tkXy5D+lxkLsKlhZrUqwRV8NcagP3Yh3MrqIMNTinSMl1Mg29tKSgzgd792joKdZcrtn+2gDuCyjX11PvSdvF6D1DrDtI/OWuSKvcCURbwKFy9sGj/RoCmE0pyZglWfS2qReIfupc/DRB/ePsku52jMVIeTgPdjM2Qg0kVFRFwyj3Sle/h2HpSowh1iAvvjMKMLa16gS/K6y4XOt4orsnqhu3FvTn/ObeHRgVRLfgPUJ+ytAUHFCW+prWVw6DlsGMAKhlu1iNk=
X-Microsoft-Antispam-PRVS: <VI1PR0501MB2608D43B3747A7AD6729916DD2A70@VI1PR0501MB2608.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(211936372134217)(153496737603132);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:VI1PR0501MB2608;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB2608;
X-Forefront-PRVS: 06290ECA9D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(366004)(346002)(396003)(39860400002)(39380400002)(54534003)(189003)(199004)(2906002)(26005)(31686004)(31696002)(36756003)(105586002)(6666003)(97736004)(6916009)(53936002)(68736007)(229853002)(65826007)(59450400001)(4326008)(6246003)(6486002)(52146003)(5660300001)(316002)(52116002)(117156002)(65956001)(65806001)(66066001)(386003)(53546011)(76176011)(58126008)(16576012)(7736002)(23676004)(2486003)(956004)(67846002)(486005)(54906003)(476003)(486005)(2616005)(64126003)(8676002)(478600001)(305945005)(50466002)(106356001)(81156014)(3846002)(16526019)(230700001)(86362001)(7416002)(8936002)(186003)(81166006)(6116002)(11346002)(25786009)(77096007)(3260700006)(47776003)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0501MB2608;H:[192.168.14.130];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA1MDFNQjI2MDg7MjM6TnBMbi91c1JjdTU0SEpSNlJVNjhuQld5?=
 =?utf-8?B?dThvN0F6TTJsMVlQWnRYN0xJQlVTbDArSjlwNEhkZG1QZExML2Z1S1dGMU9N?=
 =?utf-8?B?U3Vpd2VtTUZrdjgrUmQ2eE00N2tkRGlzVXdnS3ZDWklzNE5qRFp6VksxVGx2?=
 =?utf-8?B?R21hZS9taVJvbFh4T2tycW9LeGJBUmJqZEZvNkd4bzNEbzRzSU9wT3h0S290?=
 =?utf-8?B?enJzS0Q5NFhaRFh1cEIvd0pjdmdYMXJianZyWjdVOG04OHpvV0hGSUxZZXZG?=
 =?utf-8?B?S1JHZFl3MUxFTzBDTS9rV01vdGQyeWVGeUpYR0NUQVByVmpFVEVLVUFzcFQx?=
 =?utf-8?B?SVFQdWRuZ3NNdWpuQnRlVU9jcGJoeGFBT0pXNVlDUlZ2Sk5SaHdheFE5akNF?=
 =?utf-8?B?K3NnYXQzMVZ1S3A2NVRKZmdmS1dzWFdPQU53SEFhSDg2YnZTTHNWbzA1MFh5?=
 =?utf-8?B?RHlOVUYrRnh6eEJxMDN0bHVRQUhOSzJiNEJCSm9VcmsrRk5temc2SEtpUXZ1?=
 =?utf-8?B?dmxrTjNNTHlMeFNGY2VqK3dDUW9pYnpweVp2Y0VKL1FCQkRNalEwTUpKWmlk?=
 =?utf-8?B?RmM4VDEvRGdOQzd0UmlBSkg1Q1FOc3B3eFFTU01YSHBvZVc3UTNqVHc2MGdU?=
 =?utf-8?B?TXQ0dXJteXJkMkpkZ1JvdE95QWlYaHdzOWM3b0NnTUJrKy9mNnJKUU05UXkv?=
 =?utf-8?B?NTY1cGk2SUUwSWQ5NmFVYlRLWjhJZnBIVi9manZ2NWpTeVlzUVZLcTlxQmJK?=
 =?utf-8?B?K2dLT09kTnMvYW83b0VwZjE5c05KcmxEMjBtWTh5bmlaK3JpcmF0Q3A5MGI4?=
 =?utf-8?B?R2tmbERPSjBrMkFUa2dmWXl6WjlGL043d01ROWw4TWs2anhuaXVaMFU1RXlp?=
 =?utf-8?B?VWpmZWM0bFJDS0RqczNhdjhLV244Z2taWDZGclJjTGM4RktuU3JJWEdtbEpB?=
 =?utf-8?B?VS8relMxdkQvRlJKNWpPSmZEWmt6SmlvbjV5MlcrS29GSXYyN25xMDNrd3Bk?=
 =?utf-8?B?TkJ5dHJlYkdBMG1LM001MHM4NVByeEQrbWdYbGJFNUw2YnVBY1FxTnZMMjZK?=
 =?utf-8?B?SjFEaEZDb0ZoNzMzdFpwTFp0aXBiNTlPQkdwSzZxcTB3MUg1WUJGYUNNVWMv?=
 =?utf-8?B?K0FCTUJkcUcrQTRCQ0RhbEQ2L1Zrd0NiZXdncHV1Wmg0cVF5VDFTNW02YjhY?=
 =?utf-8?B?Y1k0ckQ5WTBZSXJKTnNSejJJQWVYMlRER3lhRklOaGtHQTU3VjN3UlRCWisy?=
 =?utf-8?B?aDlGaWhrT3RTSklwS05MOXpwWkpCZ0dYRHZ1bndFLytVWjZVb0EvT0wyWEhm?=
 =?utf-8?B?QndFck9RaERzelRNcFk2MHdsVlE4QU5RUEp1SlV1K3FSYVlTOFlKa1BYQVRD?=
 =?utf-8?B?SUhtQy8xUzduWTA4OXB5dVVyWmtrbVZpQStyTW4rRjdvRW5VNGNZQlROR21u?=
 =?utf-8?B?ZUhUR2dYUTVud2RKNlJ4ZWg5L2QzajVaZ3FDcEhxTzZzeDNmYWZieWZIa2c0?=
 =?utf-8?B?dzhjTzVPMnZrT01UMmZRZWJHcWwyeDJ3K3ZZZlhCK1M1djVneklpQ3g3d3NX?=
 =?utf-8?B?N1h6dlF2eVdaWERFZjI4bEk0TWZDSWRHQXdHdUE4VXVGU0FWcVoyaTlzOTJG?=
 =?utf-8?B?UGcvTDhMNW52NHI3VUhrRmNtSXcvaXBKcjRzWndHdm1iZlpsckpiTlZ2aG05?=
 =?utf-8?B?VGYwNTF4bHlHS1pFQXFTZnBhdkNKSHZlS2p1dmZMN1lsdXBsMVdubForZ1dQ?=
 =?utf-8?B?WktCU3hmc05PWCtRTXg4dlF4c1hKQzJZSUVURW0rVlMrWkVGVHRtUnJaTERE?=
 =?utf-8?B?TFMyVFhOSERPSTRkM011a1FnTEkwdkRVRE1Xc292KzcwZTF6eXRzOGFlSFVC?=
 =?utf-8?B?U05FWGVhdWEzTzNtTjh1bFAxSENVNFlBazRnbGVoTGV5TC9IY0Y4RHY3SzBD?=
 =?utf-8?B?WHAydytXOGZBcUthdW94L1Q5RFhVZ0R0Zm1NVVFTVi96ZlJ1bG1Pc1lLa1p6?=
 =?utf-8?B?ZFJYckxvWlAzWVI4SFBxUS9RRzB1WjV1ZkdWbFJqRXl5bU40c1dXSWp4M25l?=
 =?utf-8?B?V2x4NnZ2NHpFc3pyRllKYjN1R1gwOElWRnZtOTViUGJacnZVTWhFcFdzTXVv?=
 =?utf-8?Q?2SKZFs/0PRKjxsHJqwNlIvqenJHULOs357mniNeoUp/qcH?=
X-Microsoft-Antispam-Message-Info: ZkX+UmFME93mIU6h6x7r1FSV5+USI9YW3Iu2vIJD7pOsoNFBFbTVaxaPmR1gV7qq5mWzSFG/dV1QbFzexElduSPgs2WWo8di8krhb5OsgdiFst38TGGnDFS2Zbkt/An5fBLqaxAs7scNNx5FHoj/pm6TChW3MK7QcWcbn2YwFyYAr/FeHQQNCXD1EV0ZGX5R
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0501MB2608;6:r4KbPq4hBKa3oBL91R+QQmZdjLxPVpuIMh5tF4ma2Ndbp358VAZAjdq6gho7+4C1QvVkZVLEfxS1VW1uHlVyBDte35iTtWuR8acrDjAS3XrTBFUtGW1ookGYqLL/Ql3vCre0m4xvynixuVTbYtiSTlPCE4X90RNeFlE2hMC9airKSrZmSwW5hYPvKER/ZrgezcuETkCp+osaToeRPmQQiE2NrE3rkZ/1v8FnxTKN70UUrbhA1e+p+qpSlRtJzmD5sRKvDG1M6F3Tr0EiB29H3AxFMyVgDXTPTF+izs1q3onExRyrsHOlNOKgRh+UYIjrXNeESxLfjBpF/fKR5dnziQ4s23+XpUeDCuKXe4EQRv+iLEGZC2NyvOe2gk316+LgbE6FpHnIVYb5E6znDNC62+isTw3nti16gNOWPVxzM1eTdOs275fSeu5d9lRoZay8J92zpwZMwviHqdlEvye7fw==;5:xvuc2dhiLD0ufxmA38stmUXhcWwbPSC7LpZOGBglwMxk7YVkFREEdZFogeRCsFgiRF+ExTZMJbmxrIgcVww1OVzwk3QP2xKroh0V9xjXPcCESpvALYBXwzGqXE2zD25EagKnBT4htfQf2c3OyUUZzu2TO5rhq6ebjhShOzjmLIk=;24:S5X7LEh9eSDtuM1B0GpevizzUrrkBZ7O8ZJn6TOay6mvASH5HfqR7e8oNoTcbYr+F8P+D86PQWFz9OmQrIbAy0Ln/37MR7vmPGeAMR+EBi8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0501MB2608;7:fS0t5EQuWKtZWu9v7OntsUXwnTC6wtdb+gKy1GfYGJrMn2ohLkxKpV+RTdzEtHDPEhr+lgCmrf4w95zaJAhssalphRbzIQ3x+YAwwOL243yMmf7hiES/tQU6BwMs+cawgoyiLA+uVmbj83bFu2lqX77ErE2RhT6urxXsxkR8iQ+Mgn9PVWy5sodMmEikw8E701y1nx6k1wns8+gicro2XS6GeB48YjpHZwoqc2Fj5NICTBZjLZsA9W4copN4adnk
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2018 20:41:49.1202
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 354b8c78-03bc-452a-399f-08d59810fec0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2608
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/2018 12:05 AM, Bjorn Helgaas wrote:
> From: Tal Gilboa <talgi@mellanox.com>
> 
> Add pcie_bandwidth_available() to compute the bandwidth available to a
> device.  This may be limited by the device itself or by a slower upstream
> link leading to the device.
> 
> The available bandwidth at each link along the path is computed as:
> 
>    link_speed * link_width * (1 - encoding_overhead)
> 
> The encoding overhead is about 20% for 2.5 and 5.0 GT/s links using 8b/10b
> encoding, and about 1.5% for 8 GT/s or higher speed links using 128b/130b
> encoding.
> 
> Also return the device with the slowest link and the speed and width of
> that link.
> 
> Signed-off-by: Tal Gilboa <talgi@mellanox.com>
> [bhelgaas: changelog, leave pcie_get_minimum_link() alone for now, return
> bw directly, use pci_upstream_bridge(), check "next_bw <= bw" to find
> uppermost limiting device, return speed/width of the limiting device]
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>   drivers/pci/pci.c   |   54 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   include/linux/pci.h |    3 +++
>   2 files changed, 57 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 9ce89e254197..e00d56b12747 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5146,6 +5146,60 @@ int pcie_get_minimum_link(struct pci_dev *dev, enum pci_bus_speed *speed,
>   }
>   EXPORT_SYMBOL(pcie_get_minimum_link);
>   
> +/**
> + * pcie_bandwidth_available - determine minimum link settings of a PCIe
> + *			      device and its bandwidth limitation
> + * @dev: PCI device to query
> + * @limiting_dev: storage for device causing the bandwidth limitation
> + * @speed: storage for speed of limiting device
> + * @width: storage for width of limiting device
> + *
> + * Walk up the PCI device chain and find the point where the minimum
> + * bandwidth is available.  Return the bandwidth available there and (if
> + * limiting_dev, speed, and width pointers are supplied) information about
> + * that point.
> + */
> +u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
> +			     enum pci_bus_speed *speed,
> +			     enum pcie_link_width *width)
> +{
> +	u16 lnksta;
> +	enum pci_bus_speed next_speed;
> +	enum pcie_link_width next_width;
> +	u32 bw, next_bw;
> +
> +	*speed = PCI_SPEED_UNKNOWN;
> +	*width = PCIE_LNK_WIDTH_UNKNOWN;

This is not safe anymore, now that we allow speed/width=NULL.

> +	bw = 0;
> +
> +	while (dev) {
> +		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
> +
> +		next_speed = pcie_link_speed[lnksta & PCI_EXP_LNKSTA_CLS];
> +		next_width = (lnksta & PCI_EXP_LNKSTA_NLW) >>
> +			PCI_EXP_LNKSTA_NLW_SHIFT;
> +
> +		next_bw = next_width * PCIE_SPEED2MBS_ENC(next_speed);
> +
> +		/* Check if current device limits the total bandwidth */
> +		if (!bw || next_bw <= bw) {
> +			bw = next_bw;
> +
> +			if (limiting_dev)
> +				*limiting_dev = dev;
> +			if (speed)
> +				*speed = next_speed;
> +			if (width)
> +				*width = next_width;
> +		}
> +
> +		dev = pci_upstream_bridge(dev);
> +	}
> +
> +	return bw;
> +}
> +EXPORT_SYMBOL(pcie_bandwidth_available);
> +
>   /**
>    * pcie_get_speed_cap - query for the PCI device's link speed capability
>    * @dev: PCI device to query
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 8043a5937ad0..f2bf2b7a66c7 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1083,6 +1083,9 @@ int pcie_get_mps(struct pci_dev *dev);
>   int pcie_set_mps(struct pci_dev *dev, int mps);
>   int pcie_get_minimum_link(struct pci_dev *dev, enum pci_bus_speed *speed,
>   			  enum pcie_link_width *width);
> +u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
> +			     enum pci_bus_speed *speed,
> +			     enum pcie_link_width *width);
>   void pcie_flr(struct pci_dev *dev);
>   int __pci_reset_function_locked(struct pci_dev *dev);
>   int pci_reset_function(struct pci_dev *dev);
> 
