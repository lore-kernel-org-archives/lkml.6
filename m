Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B746CC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CFB221473
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="xnMVwLFj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CFB221473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729775AbeHHSRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:17:07 -0400
Received: from mail-eopbgr50088.outbound.protection.outlook.com ([40.107.5.88]:24286
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727533AbeHHSRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:17:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0difTN5gbIak+btOeaTQ/9shhQJaWPCg/68QHvl7d8=;
 b=xnMVwLFjzpmfSok4bb6V7PWW8L4dAggvdJVG1+ZMd6IMDuJAlPOlJEO9rMFIUjB9N9mWDQgZG/j2II3DUHST7MAh3WAxtJOnHN2unftwRkVZI0Ydz/xlU0bkxBkCqTR9gRYHEVO+yKUM6j/vuuqXbE1hbTCV20yftJ2XAlmCFXo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=talgi@mellanox.com; 
Received: from [10.207.0.55] (193.47.165.251) by
 AM0PR05MB4644.eurprd05.prod.outlook.com (2603:10a6:208:ae::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Wed, 8 Aug 2018 15:56:40 +0000
Subject: Re: [PATCH v6 8/9] net/mlx5: Do not call pcie_print_link_status()
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        linux-pci@vger.kernel.org, bhelgaas@google.com,
        jakub.kicinski@netronome.com, keith.busch@intel.com,
        alex_gagniuc@dellteam.com, austin_bolen@dell.com,
        shyam_iyer@dell.com, Ariel Elior <ariel.elior@cavium.com>,
        everest-linux-l2@cavium.com,
        "David S. Miller" <davem@davemloft.net>,
        Michael Chan <michael.chan@broadcom.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
        oss-drivers@netronome.com
References: <CAErSpo4PK+SQLNfdkLNt9eLc7bpbxbkZCsa8T-tQpid601n0SQ@mail.gmail.com>
 <20180806232600.25694-1-mr.nuke.me@gmail.com>
 <20180806232600.25694-8-mr.nuke.me@gmail.com>
 <20180808060848.GQ13378@mtr-leonro.mtl.com>
 <05056a70-ee78-ea3c-0b9b-6d64a8663b11@mellanox.com>
 <20180808154142.GZ13378@mtr-leonro.mtl.com>
From:   Tal Gilboa <talgi@mellanox.com>
Message-ID: <5578cd9a-e4f0-85ab-4a86-bfa23eec136c@mellanox.com>
Date:   Wed, 8 Aug 2018 18:56:29 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180808154142.GZ13378@mtr-leonro.mtl.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [193.47.165.251]
X-ClientProxiedBy: VI1P189CA0003.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::16) To AM0PR05MB4644.eurprd05.prod.outlook.com
 (2603:10a6:208:ae::33)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15f285ed-7838-4fb5-0fa7-08d5fd47896c
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR05MB4644;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4644;3:lRQSjRf5+T5lOrv4CE9Ua7WQSgD5217k/CUZc7LcxzxXRtDjgXR59L6tTaE0CQsEYsJOAQc1rB34vLULK695F6hJaK+BqKIBGdZuouFFKaiPjuUWISe3eB44VjIHlA2h0YzIKMWsmTXVCreDg6t/EvobsnNzoxkbZyGQtF1EEHIFOe0bk7DsFmflgfttqaVvsffEWgnDFF2F1DV/NF9MzHj9q8s91BOn+eF/8uAwb6ytNS2IcKE65IOTF3sVaVOG;25:HTRzuGa3mjYlW9RPjcscg6UaT73lIZN821qwK+mJ4wUCtL7dSKKk7g+iCk/gFNR5g1Yzwd7vrVWqRrILGhbde0e9kVolaxODOQ6s4QitXvgvDE6ZW6US5qshGHei2L3bRWsgeplnFNOOt5cZ6Xk8E+GnUhLyGnYBIhN2dCXj2jbBE5GViiM4yh/20lQujHxofFKKQVwSzwNekoApFITbUF/iykdJGAktvgdeByV6XSvAiE7PdVPsEUxhabqbgigZ/2Yr1jsZO63Rr4/Ia1QMKUWJqERIkoDmpm2ZdVdSEUU4BZoLAJszJEXZ9SJy2z598d900cTPlDNQ0Msc2oWY0g==;31:wzf+TbLdpXFzHpwMEIJSC1bwWyd7eyPQB8RwF6GI2zEfmbc1pBX2s6L58PCD6XM+HS8McFCMGCgmRA99jcHYpciV6420hRBw+ipe+/cxNfaHy+7C1crSKm+NzGrwdjg96gP/c2+zXWMh4+6bnMgY41k4DX20hLwdgONbs35zsvNwALxu6HXGtTPkO58rm7gaUDujDn1qkvWNTux6CHNfydTrRBTP8Tzy86AROMJ3Sjs=
X-MS-TrafficTypeDiagnostic: AM0PR05MB4644:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4644;20:fiURmP9bwaqHh2ehenuc/YB/pJACnS3vdBmB9FHxUtsOT5lEUi+zlefudTxYrajDizwU95sYKeqbEe2ZSUnjmJ5VYQea8f7E+/tkzVuYZ53KGHin6MfjcXyvrzCV8kOPdp3QCHnBAx9Q0pRJY67OzcswnsL+Qn6czg5kOZrqLtZgKzpTPegKMv0/33BNJ5dLIctBnCZEbyvIbQb42/kuKpoEVseuiqLT+UAad4MY6UcQu7WZFT9CPQbbenzpvv6hXS/A3lC02DMy9AEksTs0kEyrQ6TNQ6DRe/4FaV5+faZxWBGr3/vlaEoo1aI4pdDtB+fSAc0RPS8GxY/nrDn3NpB6AETnxaYTOcgOB3skefBLTQo16Je2EJyx5GJF62Od7g9mXXGE5r0mieVCXskyONpwxcWxX8+yrneI0vOlvE3Y7NGbSd4Te+ijXmkqmE4LOOaxKv4aqIOdLHiYwyivGc7eJ7k/DwqAshDCG1gMhBdaWjnI4OMvsge+bTCQlT3N;4:UGai7HWVS1E69vLBAl5dNVFkdWC9z3wTpPgSxh6B4VJEkbVx5BuCrD/8HYHhI2j4/XJCgJe1RA4aKBHT6lRMCI3dGYGFq0mAZuXsxy46Q2UeyfLLA5OMc1Ez1/GvTaiikkFvbQc3daAfDaLhd54HEZo8Se7viPaZUXLJSune5aEcLVmcTBQiu21DmaF9hIAlc+5OpWT56E+VCIOBo6mtptTXajyCI71dYPbo95qIoBVWIOCqLNep+DYvYCMGAC3/MhDdtfs8xjHsrDJ41cS6CW2EL+n1HzLua45AomGZnOxwQZgri1nh6qZhDAeyFrGi
X-Microsoft-Antispam-PRVS: <AM0PR05MB4644D4FB79476BB1066A44EBD2260@AM0PR05MB4644.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM0PR05MB4644;BCL:0;PCL:0;RULEID:;SRVR:AM0PR05MB4644;
X-Forefront-PRVS: 07584EDBCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(39860400002)(136003)(396003)(346002)(366004)(189003)(199004)(446003)(6916009)(54906003)(25786009)(476003)(16576012)(97736004)(486006)(26005)(14444005)(7736002)(39060400002)(956004)(11346002)(6666003)(2616005)(305945005)(6486002)(53936002)(7416002)(6116002)(36756003)(230700001)(3846002)(6246003)(58126008)(52116002)(3260700006)(93886005)(316002)(47776003)(68736007)(31686004)(8936002)(67846002)(53546011)(81166006)(64126003)(386003)(81156014)(23746002)(50466002)(186003)(77096007)(31696002)(65826007)(5660300001)(86362001)(105586002)(106356001)(8676002)(16526019)(229853002)(76176011)(2906002)(66066001)(4326008)(478600001)(65806001)(65956001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB4644;H:[10.207.0.55];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;AM0PR05MB4644;23:5k2KlYeFbGPGyYAUmubWFbUdU14imAEHkgJSz?=
 =?Windows-1252?Q?5NdQB+T9C093qC/OsWqfZJ6uOWlmWMvBI9mPGKPFmtXh9FxUltpc6Ns8?=
 =?Windows-1252?Q?6kRGEuSZtqGFsJ4D70igaIRjFwat+X7oW+Lzqzut+bTkNQPq1303j6Wu?=
 =?Windows-1252?Q?BxMbHK96oSV7dGtBJDbBA8e/nriaZ5/hZt4AATtlzQiibx1eOU78Db/m?=
 =?Windows-1252?Q?MGvydy63C70IMGuip/fHn6wkC3cv4sGirNIQgdtYdUGBtV51vbAHOr5H?=
 =?Windows-1252?Q?P/HZkI/m3VyN1b26UNruxmDDnqRBKzj2z0JY+6ymrbMqGYsQAo0tsCDB?=
 =?Windows-1252?Q?beWUDf0+zVaDscO8eAouIkHhsOzeZv6TlhhcmzDuH4ChKwSq/JKryGFK?=
 =?Windows-1252?Q?dWLZMttu7xoe1V94euLSOe9szCC2vcojyNWhlYCiPNju4xth6n5mAJtk?=
 =?Windows-1252?Q?tPogz1uh4yyLh3To4+aXZEWEOFrNq7E5mH+wizd3CWostOeoQOulQbtx?=
 =?Windows-1252?Q?2mK8J7OBSZihBww+qAaZNwQZ/tWoT1QwDZeVKnSRSrbbDTT2iS514kzV?=
 =?Windows-1252?Q?jW6aV3QDKcW8lASW7O/3SYK5yXbHyr3t9kfsrPsdSN1sfH+WMX+OetAz?=
 =?Windows-1252?Q?O1CehlWUcK7YZVNnUSWDODYnAiZGE/+qmijVCq/T8pKlaNOzHBaGo1QD?=
 =?Windows-1252?Q?hdwTuoB8x0ukKOBMxNRoOEtPWpLkErDBM3Mk/J4F0V+olI9DM4OHUDCD?=
 =?Windows-1252?Q?Eif+1eqOiR90nYgNSNyYk0fCfW8xSe1yWcFpQEoyyDlYM9T+I+ycaTBh?=
 =?Windows-1252?Q?4D0gBFC0C4EumVIzSO1mkhschgib4ObINz4oGPd2GeeGfFUEDUI7EdhT?=
 =?Windows-1252?Q?ACVrjmnCk/WV+xEVnEt9IurjV1Kl/cC3CuSR07cljftxc+NJo+5/SgDy?=
 =?Windows-1252?Q?nE+Bj68/NrGDsJ7YaXW4M6c73oLVyDwoEbbGBvur1ALu4anBsrsEh8Bp?=
 =?Windows-1252?Q?jCwQenR2zpM92PjCln4OWW5c5i4RzB9ZvAh2X+zvkUKSXnNBjth1spPe?=
 =?Windows-1252?Q?AVoboDgrFOGAsgT62tMd9mt6UmyILFZfsbwCR/t2ksZ9xrXwzyG97aEf?=
 =?Windows-1252?Q?G8gz312TZ4C4a8vngu7NC+pFUxKg/NVj5v2inpQOUB9Ad1Gs9aOD46mw?=
 =?Windows-1252?Q?8QtC/o3hmK0P5vm1nDy+kLybHU103FFkCB+4QyNDRVn5iVRAqmCMmoUC?=
 =?Windows-1252?Q?Lbktuj4cF04bajzOPE8yU7EdUEQMljthUqLmFJSp7Qa+mGDf6hjbGPJS?=
 =?Windows-1252?Q?U8iDS4ABh7czZry0cTBYat8hzJ43EOPSdhk7EeIuQ5Wm9uBUhpHSS1aB?=
 =?Windows-1252?Q?Own2iTO8wESTXwDKcOGSvpfVK873tThu8vPu3Hbc0ol/BRiz/Yyc/kBd?=
 =?Windows-1252?Q?9jPT5hXIecmBwdoHcaXMsAgzNuPd2V4QS5Z+9cmtg4R3ITxpVc8fNIQB?=
 =?Windows-1252?Q?e8jVVfmcItmdquEGrpHOW/Vv9HFtCXS9bWXwJwj1vW4yAQGdMM9wB75p?=
 =?Windows-1252?Q?kvlqntNsnMLo32lCsmFtiXkEVYx8C5aDKUiFe2YrPQ7rsMHBl5OUzu/6?=
 =?Windows-1252?Q?XgeTWJtBUM4qr18IC54wi0=3D?=
X-Microsoft-Antispam-Message-Info: dZS1gIRG8XOlNC2hztOddM756ic0kV3thgDB3nj13oXCsxXqMc1cHHCr3J22minsJekNt3/UaBPwKJrYHjH5DHUh2Ce1GhlLEkTlbLdedy08HRmjdzQfITErAqK1MjA5tsPJ+nE9ehVHHhbfeqEf9kKOuBiOE+9ZKkP4ddAGIolTFSbZLF59NRu5kwm3cbvGxJ1rBl70u7z4+Z5RLfBdUfdu1d8g5IYaEq3O7xPNdChohFklf9etPLgvFxm2b6TczrkM4/DsrLsIT1Jof1LKxd8z1ziWkPYas2oQk+cwXL0qOivJ06P5mzY8UG7LNboXxLhBKwBiZkGI0D+lpwr81u1HHLozjWuaKrxjkCqHoqw=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4644;6:fP7i6PO9T4xfZujlnbxNMGgeLIBz7f45oruAnWAnJ/U5pYcoC+C/EFpmb3+ATHNZQhidWAtzS9SrO3ItAKSl9+oMMJIAc5aftbA1IHyJZA8gY/WZfsQ6BnVNSHe4ZZynFeDnJcOrqePfNLAm32LOsDynGXfXJRWCoiEHNf+nlNylOr63ndSUE2Avzh7pMh1Z2+qNHSXFicJhpi94HnvFkMrjsIh7uSLq9NERTdJDLqPKO4aAVnCryGrMUWENTyHVeZnKoazXing6kr9Kgdxv3ql+WvLhvFcoaWH6pSyaapL1xB+g7ImL6HyywYWPaiGJ4MLy2uU0Vy10MenPgiEgselwATK0d6RWzLRmIDVnNJ/gjRux+s8SG8k7nx58sWhqBvCaQ2YTcRlJL9VwliwtiuToKqXql/WAWi9qTT8IeQT1s5LM7ynIl5ucBEvQ8y3AN3zJLqALUeI3ugi5Xgbaew==;5:gs2yRNr+Xch6udXdV8R/jj4C71Gp+skRGh1LuoMcyZma6Q01jpVn3vGihJr+T0ReiNZUUEb/RIEsgwKJJXJSZmI7qFf2idD+lo84CvCKq8B177cXhRK565zcEhn2IAL2PDaoP7HZDNlD9ymeG1/vYfpkxWhUTaFGjbMM8uIo1SY=;7:LSElWUdr/T1y4CHinKk3ZcrI4tn1PUtzPki4WoI/N4Zppxsw4gkqxe4vl508yhQ8rGBV9fnCY/3UMMS79iXOTk8dUNQz3uU3Q98TOP4wleK72r2IMGufBsZHi7apCyARS6l7cdStQI2ZE2AUUfd6geQwhe2zmAiM43RPS24ZtG6ZoMqahtnPqOJa7Ph2Gd6Di7a2laC8fNKOfFmqfxywyU7kmWe60tS8Z/GMHMOTMUeygblMMDFPOWi8N0Faf7Ku
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2018 15:56:40.6170
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15f285ed-7838-4fb5-0fa7-08d5fd47896c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4644
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/2018 6:41 PM, Leon Romanovsky wrote:
> On Wed, Aug 08, 2018 at 05:23:12PM +0300, Tal Gilboa wrote:
>> On 8/8/2018 9:08 AM, Leon Romanovsky wrote:
>>> On Mon, Aug 06, 2018 at 06:25:42PM -0500, Alexandru Gagniuc wrote:
>>>> This is now done by the PCI core to warn of sub-optimal bandwidth.
>>>>
>>>> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
>>>> ---
>>>>    drivers/net/ethernet/mellanox/mlx5/core/main.c | 4 ----
>>>>    1 file changed, 4 deletions(-)
>>>>
>>>
>>> Thanks,
>>> Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
>>>
>>
>> Alex,
>> I loaded mlx5 driver with and without these series. The report in dmesg is
>> now missing. From what I understood, the status should be reported at least
>> once, even if everything is in order.
> 
> It is not what this series is doing and it removes prints completely if
> fabric can deliver more than card is capable.
> 
>> We need this functionality to stay.
> 
> I'm not sure that you need this information in driver's dmesg output,
> but most probably something globally visible and accessible per-pci
> device.

Currently we have users that look for it. If we remove the dmesg print 
we need this to be reported elsewhere. Adding it to sysfs for example 
should be a valid solution for our case.

> 
>>
>> net-next (dmesg output for 07:00.0):
>> [270498.625351] mlx5_core 0000:07:00.0: firmware version: 14.22.4020
>> [270498.632130] mlx5_core 0000:07:00.0: 63.008 Gb/s available PCIe bandwidth
>> (8 GT/s x8 link)
>> [270499.169533] (0000:07:00.0): E-Switch: Total vports 9, per vport: max
>> uc(1024) max mc(16384)
>> [270499.182358] mlx5_core 0000:07:00.0: Port module event: module 0, Cable
>> plugged
>>
>> net-next + patches (dmesg output for 07:00.0):
>> [  331.608472] mlx5_core 0000:07:00.0: firmware version: 14.22.4020
>> [  332.564938] (0000:07:00.0): E-Switch: Total vports 9, per vport: max
>> uc(1024) max mc(16384)
>> [  332.616271] mlx5_core 0000:07:00.0: Port module event: module 0, Cable
>> plugged
>>
>>
