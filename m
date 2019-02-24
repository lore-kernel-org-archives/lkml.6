Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C64EC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 10:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF08720663
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 10:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="erH3ROUn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbfBXKy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 05:54:57 -0500
Received: from mail-eopbgr60065.outbound.protection.outlook.com ([40.107.6.65]:11872
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725920AbfBXKy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 05:54:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twSjEa9Oyf4LXEHhL5blyrEWEj4jceKoZcVUcEzZug4=;
 b=erH3ROUnvGavbSDSz3n5ENfNg6aZj63YDVlnRAZ2/AEfmO+fYvJvSxLt1xAlGFhV6SHfreMnPlDyvV2y5LIyeO1zN3JcIGKK0r1qk8hUkCoQZy/3i/IgrN+SebS+UP0so86zQavpliM3xl+u5ivp9t6kZUxdG4yjQzTkmy3hKFQ=
Received: from VI1PR0501CA0021.eurprd05.prod.outlook.com
 (2603:10a6:800:92::31) by DBBPR05MB6585.eurprd05.prod.outlook.com
 (2603:10a6:10:d1::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1643.20; Sun, 24 Feb
 2019 10:54:52 +0000
Received: from VE1EUR03FT036.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::209) by VI1PR0501CA0021.outlook.office365.com
 (2603:10a6:800:92::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1643.14 via Frontend
 Transport; Sun, 24 Feb 2019 10:54:52 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.134)
 smtp.mailfrom=mellanox.com; lists.infradead.org; dkim=none (message not
 signed) header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.134 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.134; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.134) by
 VE1EUR03FT036.mail.protection.outlook.com (10.152.19.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1643.11 via Frontend Transport; Sun, 24 Feb 2019 10:54:52 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Sun, 24 Feb 2019 12:54:50
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Sun,
 24 Feb 2019 12:54:50 +0200
Received: from [10.223.3.162] (10.223.3.162) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.301.0; Sun, 24 Feb 2019 12:54:01
 +0200
Subject: Re: [PATCH] nvmet: disable direct I/O when unavailable
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Christoph Hellwig <hch@lst.de>
CC:     Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        "Linux NVMe Mailinglist" <linux-nvme@lists.infradead.org>
References: <20190221182234.22345-1-jthumshirn@suse.de>
 <SN6PR04MB4527A810D247541AA7C4A512867F0@SN6PR04MB4527.namprd04.prod.outlook.com>
 <6c3fa30a-d516-a453-a001-1014202ff9ce@suse.de>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <9d8e96de-d68d-8961-21e8-4cb8e79b4a08@mellanox.com>
Date:   Sun, 24 Feb 2019 12:54:01 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <6c3fa30a-d516-a453-a001-1014202ff9ce@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.223.3.162]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.134;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(376002)(396003)(39850400004)(346002)(136003)(2980300002)(199004)(189003)(81166006)(8676002)(81156014)(6116002)(7736002)(305945005)(58126008)(356004)(110136005)(54906003)(230700001)(2906002)(316002)(16576012)(106002)(67846002)(23676004)(2486003)(50466002)(3846002)(47776003)(76176011)(65956001)(65826007)(229853002)(53546011)(77096007)(26005)(65806001)(186003)(8936002)(64126003)(16526019)(36756003)(86362001)(486006)(336012)(446003)(126002)(11346002)(2616005)(476003)(106466001)(6246003)(966005)(478600001)(31686004)(6306002)(4326008)(5660300002)(31696002)(3940600001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DBBPR05MB6585;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:mail13.mellanox.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7843ef17-fa85-4892-2f5c-08d69a468104
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4608103)(4709054)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DBBPR05MB6585;
X-MS-TrafficTypeDiagnostic: DBBPR05MB6585:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Exchange-Diagnostics: 1;DBBPR05MB6585;20:ZDODp7FwkiJf0hV6Bv+pJInSuNirH5bA/33nCDwq2056BFpDadeac8unbN+4ht4btEy6CU+yZJkZURfN3Jc/Vo7TibbFJsXT2mgh2+ldBaXkRt8kR7jkWeYZm98bY5fAxOdweB9yVZxHUM0Li3gu4Gr76OOpGcId/Oi+Ktod7Swxcr/+1XpAbKrVm3b04DkDPaglguFLPPyY0Da22PLiYtzGPiZWpI25C4CYX8dkM+lbyV4Yw5opZrOSl4XBdUbJ8U0Bvc7kBXEvluaNDgGshq6mZq/mJaHbRkiAsHiIK8vyae3O8QPTt/5p4q63b+hy+by4n5MH2ROQ0s2ZSMWBtckaCQciXGjD3sdZa1mDScRzBJXTTRbBfaMB9OzKzMTKIkgt3UgsAx1wSh8ODbSVS25vkcJINtRHKVy8C5EHd4V8SA+mSxM/txC0h4Mhx8I4d/BtPr3+FOWcz/E3XzUAYyBfRKEDCHPVO15UxgMjxOdxxiyAchGEj84B2sWAgPYh
X-Microsoft-Antispam-PRVS: <DBBPR05MB65854F0A266BBBDB6DC0EA31B6790@DBBPR05MB6585.eurprd05.prod.outlook.com>
X-Forefront-PRVS: 09583628E0
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQkJQUjA1TUI2NTg1OzIzOmNwTDNYQ00zM3JpSW5yODRncFlCUFZSM2k1?=
 =?utf-8?B?Rm5jN3FVa0xFUUtqSHNHQ0xtL0dkZU9wd2tWWjdwOGN2RUFhU2Jjc3I1RGQv?=
 =?utf-8?B?SDU2aVlkbEtPcE10Z0Jwc3JvRExwZGo3L1FxQ25PWVgxWVMvSnlONEZONHhW?=
 =?utf-8?B?TWV0YWNpWEptK3pMcHVwTy9icVhmQmZ6ejFVSDVQc01WeE9ISS9zOG04OHJk?=
 =?utf-8?B?eWlQaEdpc3JJQStHQmkrVFlMSksxR1BBUXdGMmhYMFEvaktpUDdVOGNjNnJY?=
 =?utf-8?B?bWVHMG5NMFZwaWppcEtLdm54UlcvSzNMQzNEcy9PSTEwdGgzNnpZN0hCN2hO?=
 =?utf-8?B?TDdZZ0VtL2NtZ0plYkZFa2RqK3ZUbjcxZExTdDdNMFR3d3NkbS9BOUVrNHg5?=
 =?utf-8?B?OExjcU1uOXh2eXY1cCtUczBLbENmeUdkWGRaQUF3Y25LRXExbHFWUVkwR2hL?=
 =?utf-8?B?cUc4eVpqK2VrVFNndGl3MUdWcGNtVzVUeEZBeW9BL0NqUHdFNkIwbVRMK0FX?=
 =?utf-8?B?Y2pPZHF4b2JGL1NLVjBoY3dxQkpMSHdmOVFnak1ua1M0dGVJYU5yZysvcXJG?=
 =?utf-8?B?K2I4SWw5Ynl2Z1ZHZzQzN3lEY2NsZ2R0MGMvSmx3ZXVCejFDTm9Mdng4T0h5?=
 =?utf-8?B?djRsdVI0VjVXbTB4TVc3N2hjZTBwM1JPVzRNbkdQV0VHU0pGcDYxNDlxSXJz?=
 =?utf-8?B?UVNsWTl0VkxNUDlKRTdMRFNGWWN1QWt1ejVYb0FBVUhXYVVHc0dHZXdudGJ1?=
 =?utf-8?B?VXV6b1BrTmdrd2hNL3g2dS9hUjhHbkJhRTVGVU9FVnJBODdQV1dBY3NqZjJT?=
 =?utf-8?B?NVQrV3h1SFRxMFcxMkhJMFFoek5scVRFelFwb2FrdHdzWnFsUTRhcFpEZUlV?=
 =?utf-8?B?Ym5XdHJCam81UEpIKy9JRzhBQ0RmT2VNRG5NVTduQWhUc0hPVEZueXhHb2NP?=
 =?utf-8?B?UVZSSzZvZG9HMG9oL29BUXhlNy85Q3NqVHdlalg3dmszMDdNblhpRERFbDY2?=
 =?utf-8?B?WEQzUFlmRWM5L2oxTWl1Mms1VEgveG1YRXNjbFdjc3FVbWEzazRENzFHd2Zv?=
 =?utf-8?B?Y2lkQjdmbXhwdC95VEhnSEZWQmpNQUw3YmhOWks3VnpuN3E0OTd2MTVKUU5B?=
 =?utf-8?B?WWoralpkcFQ1YjZvdE9kWG0zNzV5aGtVOXJ0REpqdTcyNExFRk54TjRUTTBn?=
 =?utf-8?B?OGdzT1F5YVVXWWVjYVpoclp6MW90M29vTzlSbGpwdURRb25IeGJiaVp6WSs3?=
 =?utf-8?B?eCs4QVN4aUpDUVNublc5TFFaMTZNU1V2SDhHSXNjNFdvNVQ5YS9pL0xvTzhh?=
 =?utf-8?B?Y0hCd0VDcEt2a0Y0V2Z0eGtMd3k0K3Q5V0JVbEVJdGlhT0RhZXoyOW1xM1ho?=
 =?utf-8?B?S0ZBVFBGaVJ1b21UbzJjUFYzSXU2L3NIOTB3SG04cUs2MXZzZ1ZKemxBS3VF?=
 =?utf-8?B?ZHNDa0N2Y29kUDBhT2dLSTBuWXUwejJ5WlFTdEF6RDVyYk5QU0FoUXg5bjdU?=
 =?utf-8?B?L21tWmViVEVzd0dHOHFEWVFsM01ZQWNZdkVXWHlCc3ZOY3BkK2ZoVDdyZjZV?=
 =?utf-8?B?TUVBVGZ6VDAzTjhocVdiaUR4ZXVTNFNIWERRQkJyYmp3U2VLZ2ZoZ2xwUTh5?=
 =?utf-8?B?blpDa1JUSnQ3VlZqalBVNmVnVW51TWx1WkZkUUI5ZUhYMVJFS21wME9yaUVt?=
 =?utf-8?B?ZkpYSi9ZRUpKbkljejZ3Q1NseThOTW1hNWczTklicnIyU1BCeEhvdU0vZEdx?=
 =?utf-8?B?SUlQalVGakZ4QW1lejlPRGxNNHQrVWFLdWdwVGpFMXBid000ZmVUbTVFbHRI?=
 =?utf-8?B?eWl6b3dBN0tTSUlkOWY2OGpBNWpPbTArVC9jNzY5QkUzd1VmU25MYmJXM1ly?=
 =?utf-8?B?VHUrS2RYUlNQYTdGbDNuZnR0RHJTcUN0ZDNyNHdJMnp3NVgva1A0WFhhaU1l?=
 =?utf-8?B?cko0NFdvY3Z3PT0=?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: qVMoojVfi8fqS6XTHpofKrr5lo2JIh3yTsO0LKI06aDXz4wi8pWNjxS5KVm6kNGRhBBB6iVsLhCFY9P4IzTQxHygvQy/LNpB1cRiYV78WfeomGWmJIr8oANES10WdQWJhbTGQ5QiMNoKMgLI8IsCk/LlCdA4eJPyDzz3aLYT09w3qSjrAetUJePMy1TTbYGY/2Fjnn6Cvvoz9dWjenXU8R7mVLDa6kd+DgqzeYIzTJFnYfCcz68HEYcyI19ra6eA8/oZgJ1sdLier4FGzeiGFgScZ1u6xRCmh65iHBVG/YTJHUWcVdg4NNR3GVeZhq77wDH2XBqvaV3DiZ1rXSiTiX04SijNen81UaqVo3z3nszuGCIUuZZR4VAEjpicOc8bBc4CwRMmZbIEpYPgvTVoDa/3W9LqRLJyqkgeygd61cM=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2019 10:54:52.0135
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7843ef17-fa85-4892-2f5c-08d69a468104
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.134];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR05MB6585
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/22/2019 7:55 AM, Johannes Thumshirn wrote:
> On 22/02/2019 01:41, Chaitanya Kulkarni wrote:
> [...]
>> As per specified in the patch, this is only useful for testing, then we
>> should modify the test scripts so that on creation of the ctrl we switch
>> to the buffered I/O before running fio.
> Or on any other file-system that does not support DIO..

Do we really want to support these kind of filesystems for fabrics 
backend device ? only for testing ?

What is the status of iSCSI/SRP targets in this case ?


>
>> OR
>>
>> Similar result can be achieved by setting buffered I/O flag
>> buffered_io=1 before enabling the name-space in the test script.
> Frankly, we have a ton of testing related special cases in the kernel.
>
> This one is a) simple and small, only 10 LoC, b) far away from the fast
> path or any other place where it could have any impact on legitimate
> users and c) it prints an informal message showing you what happened.
>
> Sorry but this is a https://xkcd.com/386/ moment.
>
> Byte,
> 	Johannes
