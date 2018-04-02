Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754339AbeDBHfK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 03:35:10 -0400
Received: from mail-he1eur01on0050.outbound.protection.outlook.com ([104.47.0.50]:3360
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754213AbeDBHfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 03:35:07 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=talgi@mellanox.com;
Subject: Re: [PATCH v5 03/14] PCI: Add pcie_bandwidth_capable() to compute max
 supported link bandwidth
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
 <152244390359.135666.14890735614456271032.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <31e66048-e8b8-47ba-baf5-023560b4c124@mellanox.com>
 <20180402004049.GA131023@bhelgaas-glaptop.roam.corp.google.com>
From: Tal Gilboa <talgi@mellanox.com>
Message-ID: <50346f44-de3f-b226-69ad-6de45e94e261@mellanox.com>
Date: Mon, 2 Apr 2018 10:34:58 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180402004049.GA131023@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [193.47.165.251]
X-ClientProxiedBy: AM4PR0701CA0032.eurprd07.prod.outlook.com
 (2603:10a6:200:42::42) To AM5PR0501MB2596.eurprd05.prod.outlook.com
 (2603:10a6:203:d::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d4fd472d-5677-4f80-90ac-08d5986c3f4b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0501MB2596;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0501MB2596;3:yI+NeNK+qQp41GixYGZJl711X3m7w3Dkvfk+W0Ruqqvm6LlYC2lloAx8FQV8v1jJVMzssrfsNl03GV08JBCQVs7z/UMdmb+AXhI168ejpxKlVC477x3DqdtYdsdpEE+SR27YsICQ3dEKxPXwvhZbN13eQRE+NQCDoCMjx/oOdqqew3l577wH0daHD9Iv2KDxwOangsLOc+9QJQVEd6tPWk+FC20u5r9TuynXjeKsmHfYLvQV/P8+dFXpORD0Z4B5;25:ESPvEVpFGzfQj9y5cpaQYhlvc/5su5fB4Ji2s417fib7yGDlMqlwq/PwM4+T/XfTsWs3Tb+FLwOW8eC3/mqC5LOcpiMeOij4vRGojPwP9Lp7IdvcHk7AikcXcbCKyzOP5EAqNQDgrZ5iM8ohy4ki+C9TYS4hNgoBPAlb/lxzJU+8PtIhKws/K08+YfE84IfClukbnAMUNC5ksvm5dn4XzkgTgtVIxxlvm5ZGc+cLdm2N0XylHlGyJ+w+cFgp0X3heprIpbD+O6w0W/imO/OJJXNov1xnE0/PMLy1Tujbsc2hfAxlZzl7sd3MiHFxXdKuZoLe6zD79C9usoQ01XjnGw==;31:iGgLE6scTvpyT1bt/j4Q9kjOg5nXXkXUGWrErpsFgtciRiB4jtaHBzCzf0ude701wrXjWLgwRLsS5oajRoGGRwOYyeb5qclyl26BQZ2z4azvXH+7e5+A38oRHPJAXny/J9XpWRAgnH132RUjs89+4tX7kOOiZTMDjLKppoJbSO8htupRBIePMaUQFYoP4Fk5P89lMpYJ221RmVfFUTBMb5qSQlwL6hil7iZJ91XwfgE=
X-MS-TrafficTypeDiagnostic: AM5PR0501MB2596:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0501MB2596;20:M+wcSYnDeFR+M+7t+xsxv140mIqZ/fkhbTUbf3NnAHRa+BJ37YF+KPciC2WjyxDEi5SMmVOnaBEL27KUKDscZWANSadwUoGdHCuN7ZDJdQsnISbs9FgM6GjvsFihgZG0q7Udu8Dzu+NOKuWZAmjx+jAoDl3kR2vR1VWsBqdq7aL/keIBwHoN9DNhyC+g8crtyomoxhmcIPT0ZLyzAUS8EEhmo042QQMV/sbASWtxBwStG99z24ZW1g2KrUDlFZLF+PXBwywgW/dwfcSZjWEmZKfQdPrEiDLovSyk1NJ0yGFxLclgoR04XdqF1CfUZ5unGznOdDmLcSTSlz1Ga3OP8yWtLxYyqrrmqzbhoSwlTzwcpEIn848h6fG+UMXRvrEexBiappZ0mtcdCEyT/sNSyQv5EymASKnpBY7iiM5qOiMD5/pXPhDCFrer+r5sNE47r5PwxFNtDuNV7IUFmfheNBzkBjI12j+mxhdU2g+VaS3eiMJVuRpw06WX1JSbaLX8;4:rRD2Jy/ox2tdmIg2metv52XtBBypqDLfgGgA9ptO+8q7Yh1rc/HzcDJQ3VCQdDL2ndansZwsM9b4ZUmGl4e4M2w0jH3Gkhe3PsQh/awiHcwFiHXWgEigymqyQtUW4+i1H5VeY0VMacoVwscQ2hO3WWsD5Ut2BYy8MvSlArSWg3EP5TrPqrV3KJx08RlkNKzPrFBXETKHiPcc3Njp9uS2u5WoeptanuhUJa8T75L6uT+lVWvZNPYpnRw0vif5s45dzKWMrPvtLLymYEinx5KOHNnxu6p7ewLm1rxH9mCBpe3ZqP+zLS+1oxydJXEqcnGVP+uiEuKLBl+TFTvVl2DQidEQ0owB0ouc3uv0GeZCkcc=
X-Microsoft-Antispam-PRVS: <AM5PR0501MB2596A83B7D982BA324D24595D2A60@AM5PR0501MB2596.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(211936372134217)(153496737603132);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231221)(944501327)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:AM5PR0501MB2596;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0501MB2596;
X-Forefront-PRVS: 0630013541
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(366004)(396003)(376002)(39860400002)(39380400002)(199004)(189003)(51444003)(4326008)(59450400001)(186003)(16526019)(316002)(16576012)(50466002)(478600001)(77096007)(386003)(6116002)(3846002)(53936002)(105586002)(65806001)(26005)(65956001)(53546011)(23676004)(47776003)(106356001)(54906003)(52146003)(6246003)(58126008)(68736007)(66066001)(3260700006)(25786009)(76176011)(31696002)(31686004)(230700001)(97736004)(52116002)(2486003)(64126003)(36756003)(67846002)(6486002)(11346002)(6916009)(86362001)(305945005)(446003)(7736002)(229853002)(8936002)(93886005)(7416002)(8676002)(2616005)(81166006)(81156014)(65826007)(6666003)(5660300001)(476003)(2906002)(486005)(486005)(956004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0501MB2596;H:[10.207.0.54];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA1MDFNQjI1OTY7MjM6bDNVQVN5OG9MaFRscUdoVHM4VFpZeUVD?=
 =?utf-8?B?T2VmNUxpV1g0dkpodW1FQmQweVJDYWRkS1hxeU9Ma0FGa2ZxdGVNR3Y3V3Z5?=
 =?utf-8?B?bXlYSlZhUzdFVHVWZTM1QldZTEQ1ejgzcmNrdXJ4dk5NeEFseERNaDZMaGVN?=
 =?utf-8?B?WVpBeCtPSi85T0VCZXRnZUpMM2VhYWFjbU13d25SeEtQMSs2U2JTV1lrY2Fl?=
 =?utf-8?B?bHNKK0VWemU0d3hhSlBtY1RLcmtQYmR5R3drNnpEQjd6Q0tHYU9WTDdVWXNH?=
 =?utf-8?B?cVNSWTRTMmZwZ2pySjlnQ0RwNkdBZU41R1FncFkvTzAwb0UyazN6LzFNakJT?=
 =?utf-8?B?NVovQ3RUQUMyVW5nRFh6UXQzMmxJTHJKbTg0WGlFVk90Y0FiYkZUZlFidnRR?=
 =?utf-8?B?RGt5bGtyeDYyK05yL2FDNnUvSXE3RVRuQUlLT2EwYUtnZ2IzTU1kNUJQSTJj?=
 =?utf-8?B?UkNEWng3b2FBNWtFcVlSSTdHY082alI5dFVLbTZKVEFOV2taTnBzZ2ZxVTNU?=
 =?utf-8?B?SC9rbE5BL0huaEM3ME9xdXRkYzgzeS9BVURLUlg5dEgyKy9GK0Z2SzFiZlB4?=
 =?utf-8?B?S2hHN0FTRzBvSC9uL1dob1lFMjY2UVVKZHpCZm9vUk1jSytrMnVlM3QxVXNL?=
 =?utf-8?B?RVFCYUY1eVhnUEN3K2s4eGEzZWhrdmZGMzh5ODJzVmQvTXY1bTFJQ25XVFRL?=
 =?utf-8?B?dnFsQ0pjeXZjV1krdG05WHRCSG9rcnlEZEM0WmwyMXdzelNFRVRheFk4Qm5B?=
 =?utf-8?B?QlNIaGRmaEYxSkhzbkpGRWl1bGtNQ1NTUHNEUG1xdGdFZXZNZGI0Ujg0am5L?=
 =?utf-8?B?Kzh6UExqUWdlczcxTTJWeURBYityZGtVVVZTaWIvd05WMG5Wai8rbzNhOFMr?=
 =?utf-8?B?dXFJVHlRMUhRS0NqVHVXRU44eWFXZWsrcEFtalpIZ2FSSU9oOGNVMXh5ZnFM?=
 =?utf-8?B?MDFHZEN3cVd0b2I1eXlWc0tncllpZDFtRW9LWWk1dVhnUFozUGo2bUtLa0Jm?=
 =?utf-8?B?a3NUZU0raWw0SFhZTlRmSllOSERYYmZHY01Ca2NycituRkM3b1VMdFR5K1JG?=
 =?utf-8?B?N0pSRzlzWDA4V2RwaG5BMmZYOTd6NWpneUQ1SXg0K2ZWemwwV0xlT0VBSmxl?=
 =?utf-8?B?cEdtenR5YVM5Wi9KQmRTRloxWVNidkNnSEFOT2ErWm44LzRpNEVycDVKWXZ1?=
 =?utf-8?B?RlVwampQZkdKSzluSTg4Ukk4STJFeEZuekxOL0tvMjJwWU5UTXZEdGNXYjFz?=
 =?utf-8?B?NHVHdXE5cjJ3aGdhdVRYTUFvd1Q5amJLY1JmVDc1SUhXUkVhR09BemtoZ29B?=
 =?utf-8?B?NUFMOWRUNEhPa2VPd2ZuWEJ3VGJUSHJvdk4zbUZFc1RYSmdhZjlkbHd0U3Uz?=
 =?utf-8?B?bEh5Y25nQWN1NFdmM21pUzRCWlRURmE3RFN3MUJVMS9tOGJUOHFpZXlOTXNG?=
 =?utf-8?B?SU4vQ2F5QUYwV3B5ajJ5VHhIQjdpaGtqK2VSQ0orUFIvanBJdG9VckQwN0di?=
 =?utf-8?B?bWxrK1Jrd2F2NDFrZjNac1ludXZZaVMxVTQ5bUJ0NlFkU25mM2plMzNqOW1v?=
 =?utf-8?B?a2N0RU0wTHgyQlFsbWw2LzZ0TFlyK0hVcW1ncVh5bTViRkNEd3JYZXU5MlN2?=
 =?utf-8?B?S1Z5ZW02My9kSUwvNUFudStpVUIrdllPSVRmSlFQZUVwOWZoU25Jd3padWJt?=
 =?utf-8?B?bGJRK2U2Zkt2NWNsbXlSU3lNU3lXNzFXd1lSVUNoczFvczB4NFRZOEpRdTB0?=
 =?utf-8?B?bjhpc05WQ2J1aVR2SW4yRHpNa3Jib1VVMWdOdGVqczFYaVJPQ2E4MG1WbHBk?=
 =?utf-8?B?SjBoelE0eXZoRnc0cTN2N1c1QTFCVGxySi82dDlCRHJ3M1hlZHpzMzRVNmNR?=
 =?utf-8?B?cm9rUGlPUnlCTUNGOGN6MCtWY2FWNm1TWWcvL25nSDlHZ0NVcDdLTzFJemYv?=
 =?utf-8?B?S1g2ejZZM2t6MXl0QjZmaS9rclNXWjdJclQwbE05QmZKVmNmTjZYTlh4OTFs?=
 =?utf-8?B?RHNGcmxsNHV4YVZUTmUvTkF4d0Z2b3RhbjF2ZllveHkrTm1YMUZjMnpSUDNL?=
 =?utf-8?B?WHUrTnBXSlQ4OGlmZEpWMW5QQkN6dVFwRUZNVXV3cldoQS9lZzkwYksvbWpi?=
 =?utf-8?Q?vZc+gNap3JK1yDCv3u7UtrXTNDWBBcqPFtuM4CeZv4lPS4?=
X-Microsoft-Antispam-Message-Info: m8avAksBDxh7mjg1a4Vc6jAE1VFtm7vxZpB5q03YVILQJyJpy6kEXzNl17uhb89zFqgI/mb0w8a7iAIvIPQX3yz1M1nTFexD8A4vDwTOUeJgO3z3NAGHrvW3YiUjEW/bAnG9n1Ry4j/9iGPXG3fOLhY/0IF1InbCrXDg94FLOc+1bE3BLV7PBWr0f73Wy9C2
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0501MB2596;6:YVHCxzjxyUk1emPymYqpNN2/vVIDJfxZEn+ANDc4octHVcNE4P0Bx11BSZ+AuN7sOmhF4ZPUXOxemw7fOlvmIOs2ap4IdxfDxh1TKpyNFm5xAC4Bqlrstghajj5bzVvFu2lNn73/Aoca+rngsOJUZEP0JVNmRmnuwFIVVH8Is3Sq+SgeNfGzvexuUDjvQvfAwAAUZjI6Gdt25WUG6zUiHEb+sjH4KIXxtHwftodqcC6HFv3h1a/SjqSEdlcF5bvN+c0LCcJruFDpRPgBW915HZ0jnUwUeraQ7yslz5Va9NYkf8LJB3XQjXwOcZn7/7d78v79Pi2ZeYmDBhIEJJpvjeJJyHK/+Q8A8eVDL105VwGm32aT0S5aDpC+H2ZQis+x6GPsvXbPNGtI2NIre3lo0PLpRenMVp3im286gxEB/vUi91fKUXCr3dx548C/ewbOdGO4/+acek3Mosv9uZHU7A==;5:3b3X+mhhph39ArBe0mJzDynyFAsQJ95CWms79nwRJb4Ks9N1g/3yhrio1zxIWsYMqtbi2wB5rdT3R064dQacCnto0DGQUL2NSNEkreGYXiuKkntVzhmDFjOi9q0FG9OXRMleGKUQ5UdsXazszM79xvQiMpAxbXvMkTQLlhhQTEA=;24:pfRsGY1jEJB23aa10b/Ee4xSMhHd9r0KWyWtIE+knIxuJgKk4Bs6Ktws0lVbSLi1oqrpQBK0yh4nfFv20TwFSl3iavKU7M4CXCigaKh/Lok=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0501MB2596;7:hEsuYwdfAzWG6I7MJpoDfhTF2TipmhUhSAQ24ZytwAabYPIEh/BKr5cXxRmfuaCMklZgn4JCem7zvWJJWy0Qf/arIaUrWi9xWexRGYuCENT9gxxQBFA5j9SOhuDnMQwGL6VEyJDVx0zryIzBZnSUDlD+MMksEogpi6uop661/tjn/7CSGF47X7hiwkeyu8nohCS1MLJB5MtRyZ5jEIdRS11fLLXmGlKgghDyTsXWPLPL/SH06na88euESRxMbGNH
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2018 07:35:01.8761
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4fd472d-5677-4f80-90ac-08d5986c3f4b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0501MB2596
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/2018 3:40 AM, Bjorn Helgaas wrote:
> On Sun, Apr 01, 2018 at 11:38:53PM +0300, Tal Gilboa wrote:
>> On 3/31/2018 12:05 AM, Bjorn Helgaas wrote:
>>> From: Tal Gilboa <talgi@mellanox.com>
>>>
>>> Add pcie_bandwidth_capable() to compute the max link bandwidth supported by
>>> a device, based on the max link speed and width, adjusted by the encoding
>>> overhead.
>>>
>>> The maximum bandwidth of the link is computed as:
>>>
>>>     max_link_speed * max_link_width * (1 - encoding_overhead)
>>>
>>> The encoding overhead is about 20% for 2.5 and 5.0 GT/s links using 8b/10b
>>> encoding, and about 1.5% for 8 GT/s or higher speed links using 128b/130b
>>> encoding.
>>>
>>> Signed-off-by: Tal Gilboa <talgi@mellanox.com>
>>> [bhelgaas: adjust for pcie_get_speed_cap() and pcie_get_width_cap()
>>> signatures, don't export outside drivers/pci]
>>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>> Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
>>> ---
>>>    drivers/pci/pci.c |   21 +++++++++++++++++++++
>>>    drivers/pci/pci.h |    9 +++++++++
>>>    2 files changed, 30 insertions(+)
>>>
>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>> index 43075be79388..9ce89e254197 100644
>>> --- a/drivers/pci/pci.c
>>> +++ b/drivers/pci/pci.c
>>> @@ -5208,6 +5208,27 @@ enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev)
>>>    	return PCIE_LNK_WIDTH_UNKNOWN;
>>>    }
>>> +/**
>>> + * pcie_bandwidth_capable - calculates a PCI device's link bandwidth capability
>>> + * @dev: PCI device
>>> + * @speed: storage for link speed
>>> + * @width: storage for link width
>>> + *
>>> + * Calculate a PCI device's link bandwidth by querying for its link speed
>>> + * and width, multiplying them, and applying encoding overhead.
>>> + */
>>> +u32 pcie_bandwidth_capable(struct pci_dev *dev, enum pci_bus_speed *speed,
>>> +			   enum pcie_link_width *width)
>>> +{
>>> +	*speed = pcie_get_speed_cap(dev);
>>> +	*width = pcie_get_width_cap(dev);
>>> +
>>> +	if (*speed == PCI_SPEED_UNKNOWN || *width == PCIE_LNK_WIDTH_UNKNOWN)
>>> +		return 0;
>>> +
>>> +	return *width * PCIE_SPEED2MBS_ENC(*speed);
>>> +}
>>> +
>>>    /**
>>>     * pci_select_bars - Make BAR mask from the type of resource
>>>     * @dev: the PCI device for which BAR mask is made
>>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>>> index 66738f1050c0..2a50172b9803 100644
>>> --- a/drivers/pci/pci.h
>>> +++ b/drivers/pci/pci.h
>>> @@ -261,8 +261,17 @@ void pci_disable_bridge_window(struct pci_dev *dev);
>>>    	 (speed) == PCIE_SPEED_2_5GT ? "2.5 GT/s" : \
>>>    	 "Unknown speed")
>>> +/* PCIe speed to Mb/s with encoding overhead: 20% for gen2, ~1.5% for gen3 */
>>> +#define PCIE_SPEED2MBS_ENC(speed) \
>>
>> Missing gen4.
> 
> I made it "gen3+".  I think that's accurate, isn't it?  The spec
> doesn't seem to actually use "gen3" as a specific term, but sec 4.2.2
> says rates of 8 GT/s or higher (which I think includes gen3 and gen4)
> use 128b/130b encoding.
> 

I meant that PCIE_SPEED_16_0GT will return 0 from this macro since it 
wasn't added. Need to return 15754.
