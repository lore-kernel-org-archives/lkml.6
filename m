Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DD4ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BEDD20880
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=epam.com header.i=@epam.com header.b="ZMRdaBmL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BEDD20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=epam.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388266AbeGWO14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 10:27:56 -0400
Received: from mail-eopbgr10045.outbound.protection.outlook.com ([40.107.1.45]:53664
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387986AbeGWO14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 10:27:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTbpgESP4WHhFR0fFk99SOw/fT2fyPG9qVw70mT09qE=;
 b=ZMRdaBmLM4Tr0YNpvX3Y5LtSMSVJzisnlNhExqmEdgZwa8WSXtHTnboAfF/YiPDV7pA/pizjaUr+sz78ztrFpL9Sdbjaped96rsfdyvBfVKszMtCfzG+5kFiWdPIvGn2cKmdxf+jdyYWqrGF18nrEkWIrk4HM0x/i+CDdxzlcxk=
Received: from [10.17.182.9] (85.223.209.53) by
 AM0PR0302MB3204.eurprd03.prod.outlook.com (2603:10a6:208:9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.16; Mon, 23 Jul
 2018 13:26:35 +0000
Subject: Re: [PATCH v5 0/8] xen: dma-buf support for grant device
From:   Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        jgross@suse.com, konrad.wilk@oracle.com
Cc:     daniel.vetter@intel.com, dongwon.kim@intel.com,
        matthew.d.roper@intel.com
References: <20180720090150.24560-1-andr2000@gmail.com>
 <019c0eb6-8185-d888-ae6f-305ea2d44124@oracle.com>
 <df3e8c07-c8b4-cb12-32ad-119498be114b@epam.com>
Message-ID: <80a074ac-91db-82db-d094-660d859cf903@epam.com>
Date:   Mon, 23 Jul 2018 16:26:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <df3e8c07-c8b4-cb12-32ad-119498be114b@epam.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [85.223.209.53]
X-ClientProxiedBy: VI1P193CA0019.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:800:bd::29) To AM0PR0302MB3204.eurprd03.prod.outlook.com
 (2603:10a6:208:9::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0675f527-93d5-4c82-a527-08d5f09fea46
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM0PR0302MB3204;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0302MB3204;3:m2mLZMMMvrEpGIVCs6eEMZ3+HjEycbd1KRDvhhwrVGGmpmVOvtc/QCL9oARm5IGQw6Ku6LHIFK6U/sNBp/35A2ecg2ULuFw7buB0yGSs75kmNB1+vsXrqpK3yRNCy1Hw7lhdxrI63oYZxVZGGMCUS3LLgkZwp26WCogiEwHELlYt7VnRFmWYD51kdDjomIcGFr4Xfgozs7QexByh9/WKFRRqxFM5sEmxZqJFPKf9qnYENamvu92I2mS3M3NH6jci;25:hoh98JXchJEK3xy3l85C2fb9IyW0+Vd8+X+C6+fZtuuDvf0C2KeuI1WmNVTpBrGXex1StzX641J9XyS7VaGf2o0ad8bFGDSrmwgjA//o0ujHvXwv0mhzMZg/TQY37eL46+TkirkU1fxvU8KNg5a09HBtMYQFNdomztA6V+CztcM7R/CjInVsIDFb42Ihwo6CpyXmfPpH0cFEflOY59bnLobGrGIa+1BENVC/WMi7rSea1oIGvPEe449mu656c3hfwU29lsOwmWhdmmm/6NJYJZz2I/mg12uvQh6yidk7VlAA3n7hBJDCBfwq6gcrhmY4lpxP2PgqUo4Kd8zitqXGfg==;31:ErxX8Dph9eYjZsPvD6XmG3UO3L1CISvEqpN7FAzyw8DFSCrA513TdvlJroAfroUvy0/Jrurv0VHySHhlT+Bt6WvmeL89XzESeQsljlTHQ58Gjle653wqM88RbACymyC+bg2T6DN84wUZLopPjZv9FQfmUp9DO7/eWY5pC1RXhU+P0/mXsTCPl925EkFjzIRp1Sp1UPSuLHn3hNlgvv/jHNTK88qIVOGARNJ2nAZBshs=
X-MS-TrafficTypeDiagnostic: AM0PR0302MB3204:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com; 
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0302MB3204;20:zGNceC+Kb0s2ZhBJpDyD74WLhePH5kuEdm4z+7vDffA4WE3q06MW3dy8sCjuY1DUBIeKO9vVhkQfMEAhxVdw7cEcAqipYEJChD6pUQBextoA+4iBhRKyXRWdznDrq02B71qR+ucSWqbkFsabk2dFibP5n5j4nshxjauLVnGXNu7WAx0nWaygFQ+cG2WD0e55ETy40U/iHRM9uflaVCGQtRsfff2itxVj7VRbkxK19CX6BkgJ8zo5v8kq2NWbeGiYEnnuuQKwrNvJoUmBPQE4/5I4E1OmeWjVg6pHhWdvjs16xS/y9/CRv5S6nxpGkld8jQvMt2er1aE6Xw0/Zt94R1dYwWFJLWYVZ/2IUVRIAfol82w/4iiRoCkR/P+UEfrqIUOWrW4Sufhl6VcB0MDh9K6sWJnl5y4KJwJ1jsXOxPntQHtzViNOo/s4jYny6QtHbPi94dyxqonPXenBl/KrFPXf3qAv66vu/hKRP+H2K6c/2mgA7F9T7f39p2m1nOFB;4:h9O2CiVXuwK49y22uuzoHa7NuOHFHtPqdAXKu0rl4kPuSOSSxtjuBi9MKPoBNHs6W9KJXe+YLbC13ZXw5VjAyV0grDOquJQUt+cjELHZGR487RuxWA2YZoev1SjU/MdX50ICBqHmH9votdkJ46vNOtSZC1zcpFyPLCY02eAYvIWh/KFv2MQjoGA3HsMvlndS+l/45+YOQJ6FHCrUxeC4UzqWmf4i9S3cpl4dzPoPmE5kPwNpE93rNuEWGCqq6QfKUllKM/FKLiSgNjnGQrrQmEA6LzVnsxmWVkNcpZ4CefKmKGPV+MB8NviCSMHlgOyn
X-Microsoft-Antispam-PRVS: <AM0PR0302MB3204E3B6D48F2052F5E78EF9E7560@AM0PR0302MB3204.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(4114951738403);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM0PR0302MB3204;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0302MB3204;
X-Forefront-PRVS: 0742443479
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(136003)(396003)(39860400002)(376002)(346002)(199004)(189003)(476003)(6306002)(7416002)(47776003)(956004)(2616005)(6246003)(110136005)(446003)(58126008)(11346002)(8676002)(65806001)(67846002)(55236004)(53936002)(65956001)(64126003)(81166006)(966005)(8936002)(66066001)(14444005)(81156014)(76176011)(7736002)(478600001)(2906002)(229853002)(23676004)(50466002)(53546011)(3846002)(36756003)(31686004)(65826007)(186003)(86362001)(6486002)(6666003)(25786009)(52116002)(386003)(2870700001)(39060400002)(316002)(6116002)(16526019)(31696002)(16576012)(4326008)(2486003)(486006)(52146003)(5660300001)(77096007)(26005)(97736004)(68736007)(305945005)(80792005)(72206003)(106356001)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0302MB3204;H:[10.17.182.9];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: epam.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjAzMDJNQjMyMDQ7MjM6SS82b2lnTzF0MGhJY0tIWktTWnpqWkhL?=
 =?utf-8?B?LythNHlhNGJiK0lDTzZIYkxWdU14MUhmYUg4R2NBU3RMUUdPYmRLWGd3dkwv?=
 =?utf-8?B?eC9UY3RKZ2NTYW8ya1gwNmpCQUtqcWhuWFJCLytXdHpCZU9kTUV5aUVJNWlQ?=
 =?utf-8?B?MkNuTitQMDduNUFROFVoWFNLQUtxNzY1VDJnUGE1SkNxZmd5UnNDN2NSYjkv?=
 =?utf-8?B?THdnamFOdjdkR0J5Z0dWUXo3czhNTk9kVmthTUJwV3lpQWNwdGUrSHNUWjdp?=
 =?utf-8?B?bHdNSlpaV0JqWXZLenpPVjAzTEJUZy92QWx3cjBGVVd2UER0emVxQ1oyTENN?=
 =?utf-8?B?RXNMUE4yMGJDT2JNaDJScnJRNUhLbDkyNUNKYVIyY05iaXMzMWd6MVhwK0Fl?=
 =?utf-8?B?bVBvZkJRV1B5ZHlIVmpTRWJtNEhCS3FkTGVPeUh2T0VRK1lvOU1VaDlLZnRl?=
 =?utf-8?B?OGIwalh1VTRIajRheDBzWG1PU0o2dmVobU5XbDg2SFdXa3o5MUk3cy9lRVRh?=
 =?utf-8?B?MDZoT2IrNkdTUHp5ekZBTk5sLzdkM3lSajVoVGE1Zjh5ZXczMXFUZ0tuQm1C?=
 =?utf-8?B?M0trUDcyQy91Q1AvQU5vNnE2bEhpa2Q1c1ZCa2c2cDVNWmZEendxUWNQdHc4?=
 =?utf-8?B?Ri9yME9pcUJNSitTcVM1WStFL0hYRUFHL2QvWUFHQVJjMFZ5V3EzRU9tbEFD?=
 =?utf-8?B?dWNNeGZZcldlVUExckRIKzRqQjhOcjk1NEkzbzF6b0tiUFRIQ1N6UDhxWVdZ?=
 =?utf-8?B?SzZLajdoc0grblY3enV6V1BCaWt1MWl0bVFFT2xZWWFMRlYvb21Qa2RBL3hs?=
 =?utf-8?B?ZHlRblhhSzZnWFBNL0hSVjU0aXdUbTJzSVJJMis2Nzl1cXlEcXpkR0I2MW4v?=
 =?utf-8?B?L1J3bXczNXh4d3VBamtBa0FRSEpCdXE5ZVQ3T1pHM0xMUlJtM1grTm1vVHFI?=
 =?utf-8?B?bmRsMzQzYkdWRDNuajNDQ2t0V1EydE5yZnc5RVkxTUFuMWI0dndkb3lObjZj?=
 =?utf-8?B?Y0VvWFhIRkhaTHovRi9sQ2x3elQ4MWlqajNWcGtOOVY0TXBXcTRnVVVUOE82?=
 =?utf-8?B?WVZycElyOENPNkRrSk9KTVEvbEl6MDNiVXBUZHBjR3B6M1BBWHFxSlh5aVp2?=
 =?utf-8?B?eUFtdzhEZUh6Zmc3aDFqWTNqcmtGcCswRHhaVCtOS3hKK1FWc0pMdXJzOHJl?=
 =?utf-8?B?ZTlRNHBFelNaR2x0NHlSR0tMMVZKblNUZ2FrdWFnRW0vUzBTcTY3OWRvT25T?=
 =?utf-8?B?eDBZbS8wa3FWQ2crbmtxYjBuUndPNHFoeno1RVQ4QjBsZklOMWY1elR3R1dY?=
 =?utf-8?B?clZaaXBNK2NKdUZ2NDRBcStNZ1RMRFVPeDJHNnQ2WTBhSVpuZ1U2cTlNSThY?=
 =?utf-8?B?UzNLT2dVY1JjUzNNOS9VMjEvRVlVSEZqM2NMUzU4V1hOaHkyUFlIMTQrb3pJ?=
 =?utf-8?B?eGVmL0d1WVJGWVp2Y2F0amlMMWF3Vzc5SHZKbDVPNkkrTHVPQlJJSjZLYkx5?=
 =?utf-8?B?aE9panBDY3BDejNxcFFmT2kxdkd2VWFHaGxqRHhtc1hqcmdjM3RxZGFPSVBR?=
 =?utf-8?B?Rm9xaDhpSTFzZlNJRkhmbTM0NVpNbUZ4RkUyUERxWnE3aTdVTHd3VVh1TCtO?=
 =?utf-8?B?dVY0VnN2NEx0OUpYYTJRMk55NDFJSXdzS0xOSXQrSC9TcHh1MmhrU21CdDA3?=
 =?utf-8?B?YThySk9mYllkdEtuNXF1cFU4SGdhV2VvTVBqdkVzblVSa0FVVUprQmYyRkJI?=
 =?utf-8?B?TkF5TXVOSUNpaEtIZmF6OXpEWkZLaGtJY05FVk9TU2ZJd2NnUUU1dk4rdHFh?=
 =?utf-8?B?TmtuRGxFNU1XeEdJcFl1Yjl0b2FvL3FXaFErM293ODJkcE54TzFGcWd5cUtT?=
 =?utf-8?B?Tng2b2dhOGtRczZtYWJmVzF3aGRmSWs0b3RrWGJaMWwyNi9tOHlmeHMwTUgz?=
 =?utf-8?B?TEZYVDZ3TXlvOVo4S2h6cFQ0bzdnRGhCd2xNOW90aXhsKzRuTDhBR2dyQW13?=
 =?utf-8?B?MmFTTkpBcUlkaGt2SStvSmFQZ0FmR1NrS1I2L0tqVjJMMGdBUEpsMkp6RnUz?=
 =?utf-8?B?bnc5akp3Skh4T242MjlSa2wzV3lzR0Z1QWYxa2J6SXhPb3VMOWZLei9mb1NN?=
 =?utf-8?Q?41KlJX0mR5LqQA0JH+9UhrD4p2tGa7S+OcQ7SD2zqKTilz?=
X-Microsoft-Antispam-Message-Info: o7gAdPyZ/BM1HXuOWvA3OY3z1ZocXpT3HSju0wrgjqcAz6oVZpj86oowBBqLztLRTT2zpVHEjR+Pp758RS9MbBjXZSM7xvtr60hfWAS8g5NqUww51J05TM5SV9GCKppLmtkm9m7T2109L6cKpO6upeLuO6C4lgm10Bnuu2/eGYu8X/QdQ9nEBRKQ77BrUxQxBtI0fLTneWXXyB+sZ6eC0W8yYN+ft4+bB54KExw0X2j/oJGdBv4gNJTrliDm72OedLjdG6qIDWctTIbu2LB64qRXYsc93iOCWViuajLq94Gt6zyNuaJ9rp+5V/rhMZQaq7QecPdo82/ovK05Fk9b7W6n8IRopUSTNYhDIGUpnbM=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0302MB3204;6:gut1rrt7CVkxLKx3//G8Hdp3CJyRvxv7BZPmfzoHsFnBsn6PtQyXHSt4duMr5vIkn1s04bhyLXjd4MuH1ZNrSLwZ35IPzyhCyUxxf/jUqCeCJZlK7agOA9I9xmRcQMDM8uy5XrhNPz4Bek9dcnFb56mixuINEwWZqvQ6wt0jrwVh/r6BEFDSBvAHrujOJfTeZ6T9OSto4R42hENE+n1HCq7qD3vZ4pseu5+9UIAOWWIh9zUGADuvvnpNtqtR0ltYbFBEnL/m+T042EjlviRu96QPmq3g53nwtrvyUoanmOz/VbIN0jvvNYhtIkMMDrMJYwhfrA5kKmHa3cY7MPYXsGnxMAn80t5V4gTC+J/7PoDEkC1BibCINt5r8dOWypbQfXTqmPipoK+lKIAeaURDk5tXDc8v4Kiw4GHgsEGgSRflWoxW9D5OyC4QeU82LBK8oZbfOQHlVI91KdezWbBX9Q==;5:/B8Vfgdqsn/q5BHIYl8QEs1Gp1+y12T8oHSgYk6czOdiH8sIWVIMs7IwBW79HSz89klMD8BVzw0+/y6NElhxIsdYd2RjcqMDh7co0mkkSCDFA5FqDMSwcsHXy74CwmI0UPoNVNkZ5rrNaTHKOTipP82U8PBh9suxzzpPGZj3GYk=;7:OqDNVkc6HgWuWoqlMTjnfU1xEE8QygCeHwXsnKQjNdDaYgXmDWY2dMKslgj7lp4Zy2VNqnzZXIj1yF+greyr2ry6ZZqkN8TRq0AXk52IMfZ5lrFMhBE6NqFDRfh60nWlC90KZHxEw6qMuC8Oux3l4lUJPLtKiHoo410Xa+TtqjkliUJUiCcKSryMytBjOl3es+1omceU9X1K9y89yFFbICr7UApE8oNxKjN9wdRl7tELhQXUeLbqamC9UbB9ZMM5
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2018 13:26:35.4539 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0675f527-93d5-4c82-a527-08d5f09fea46
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0302MB3204
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/23/2018 11:38 AM, Oleksandr Andrushchenko wrote:
> On 07/20/2018 05:08 PM, Boris Ostrovsky wrote:
>> On 07/20/2018 05:01 AM, Oleksandr Andrushchenko wrote:
>>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>>
>>> This work is in response to my previous attempt to introduce Xen/DRM
>>> zero-copy driver [1] to enable Linux dma-buf API [2] for Xen based
>>> frontends/backends. There is also an existing hyper_dmabuf approach
>>> available [3] which, if reworked to utilize the proposed solution,
>>> can greatly benefit as well.
>>
>> Lot of warnings on  i386 build:
>>
>> In file included from
>> /data/upstream/linux-xen/drivers/gpu/drm/xen/xen_drm_front.c:24:
>> /data/upstream/linux-xen/drivers/gpu/drm/xen/xen_drm_front.h: In
>> function ‘xen_drm_front_fb_to_cookie’:
>> /data/upstream/linux-xen/drivers/gpu/drm/xen/xen_drm_front.h:129:9:
>> warning: cast from pointer to integer of different size
>> [-Wpointer-to-int-cast]
>>    return (u64)fb;
>>           ^
>> /data/upstream/linux-xen/drivers/gpu/drm/xen/xen_drm_front.h: In
>> function ‘xen_drm_front_dbuf_to_cookie’:
>> /data/upstream/linux-xen/drivers/gpu/drm/xen/xen_drm_front.h:134:9:
>> warning: cast from pointer to integer of different size
>> [-Wpointer-to-int-cast]
>>    return (u64)gem_obj;
>>           ^
>>    CC [M]  net/netfilter/ipset/ip_set_hash_ipport.o
>>    CC      drivers/media/rc/keymaps/rc-tango.o
>>    CC [M]  drivers/gpu/drm/vmwgfx/vmwgfx_fifo.o
>>    AR      drivers/misc/built-in.a
>> In file included from
>> /data/upstream/linux-xen/drivers/gpu/drm/xen/xen_drm_front_kms.c:20:
>> /data/upstream/linux-xen/drivers/gpu/drm/xen/xen_drm_front.h: In
>> function ‘xen_drm_front_fb_to_cookie’:
>>    CC [M]  drivers/gpu/drm/xen/xen_drm_front_conn.o
>> /data/upstream/linux-xen/drivers/gpu/drm/xen/xen_drm_front.h:129:9:
>> warning: cast from pointer to integer of different size
>> [-Wpointer-to-int-cast]
>>    return (u64)fb;
>> (and more)
>>
> The above warnings already have a fix [1] which is expected in 4.19
>>
>> and then
>>
>> data/upstream/linux-xen/drivers/xen/gntdev-dmabuf.c: In function
>> ‘gntdev_ioctl_dmabuf_exp_from_refs’:
>> /data/upstream/linux-xen/drivers/xen/gntdev-dmabuf.c:503:6: warning:
>> ‘args.fd’ may be used uninitialized in this function 
>> [-Wmaybe-uninitialized]
>>    *fd = args.fd;
>>    ~~~~^~~~~~~~~
>> /data/upstream/linux-xen/drivers/xen/gntdev-dmabuf.c:467:35: note:
>> ‘args.fd’ was declared here
>>    struct gntdev_dmabuf_export_args args;
>>                                     ^~~~
> Strangely, but my i386 build goes smooth.
> Which version of gcc you use and could you please give me your
> .config, so I can test the same?
Now I see this warning which seems to be a false positive.
Boris, could you please apply the following:

diff --git a/drivers/xen/gntdev-dmabuf.c b/drivers/xen/gntdev-dmabuf.c
index e4c9f1f74476..0680dbcba616 100644
--- a/drivers/xen/gntdev-dmabuf.c
+++ b/drivers/xen/gntdev-dmabuf.c
@@ -495,6 +495,7 @@ static int dmabuf_exp_from_refs(struct gntdev_priv 
*priv, int flags,
         args.dmabuf_priv = priv->dmabuf_priv;
         args.count = map->count;
         args.pages = map->pages;
+       args.fd = -1;

         ret = dmabuf_exp_from_pages(&args);
         if (ret < 0)

or please let me know if you want me to resend with this fix?
>>
>> -boris
> Thank you,
> Oleksandr
>
> [1] 
> https://cgit.freedesktop.org/drm/drm-misc/commit/?id=9eece5d9c6e0316f17091e37ff3ec87331bdedf3

Thank you,
Oleksandr
