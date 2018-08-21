Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1FDC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 08:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 349FA214C1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 08:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="ToY8QYi3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 349FA214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbeHULil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 07:38:41 -0400
Received: from mail-by2nam03on0062.outbound.protection.outlook.com ([104.47.42.62]:15360
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726315AbeHULil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 07:38:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPmqiRNbPtifdF/feTV4T4sAHyXqTksTtFDp99PcqLo=;
 b=ToY8QYi3AQenI2bVdD+86PVOWwI4zYcqYILwUQ9bPT0hVE5mjk14IFZAYYWE+Xz5PmVJ2Rg7bw1AtUe+uvLL34xTlpJCLA73SsDsmuB8UfS+L9XRHWfHuV3eIyR62fVrbgSsK8eJAhWPddSBnANsFKHXF2XEOAfr5wQfeaBPMQI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
Received: from localhost.localdomain (155.4.205.56) by
 DM6PR05MB4587.namprd05.prod.outlook.com (2603:10b6:5:9f::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.11; Tue, 21 Aug 2018 08:19:22 +0000
Subject: Re: [Linux-graphics-maintainer] [PATCH] drm/vmwgfx: Fix potential
 Spectre v1
To:     Deepak Singh Rawat <drawat@vmware.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-graphics-maintainer <linux-graphics-maintainer@vmware.com>,
        Sinclair Yeh <syeh@vmware.com>, David Airlie <airlied@linux.ie>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
References: <20180816193015.GA12093@embeddedor.com>
 <BYAPR05MB41817986B00F59780A68D63CBA320@BYAPR05MB4181.namprd05.prod.outlook.com>
From:   Thomas Hellstrom <thellstrom@vmware.com>
Message-ID: <68b1a4bc-87d8-a93a-edd1-5794ca9e93f6@vmware.com>
Date:   Tue, 21 Aug 2018 10:19:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <BYAPR05MB41817986B00F59780A68D63CBA320@BYAPR05MB4181.namprd05.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [155.4.205.56]
X-ClientProxiedBy: DM6PR08CA0007.namprd08.prod.outlook.com
 (2603:10b6:5:80::20) To DM6PR05MB4587.namprd05.prod.outlook.com
 (2603:10b6:5:9f::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 803ee376-ac47-471e-99a0-08d6073ecd55
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM6PR05MB4587;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR05MB4587;3:8BtfXCOeBx116x3qCuvLW2FUlETJlfqfM9gX0K2d4l3xrCuUf9NDcKTfuZ8b5AVViouVhR4ixT43mfjFMd1Uwbz2hxWsGZeYVAoY5layD3FGcDmUlg7xOx3SIq1geOOA0ajQkr5V7iRId8e4KoOIvGkb8iS1JncqApvlncgFSaFH6lxz4mjlP2gojSpaZSr6FNzOwZp8EBGZQie3WUJQ4OAZZnySPfeKeBOVIz2VKe+R4iSvotTacebvhd+uXYQJ;25:m3+fyWlAl3+5yjBcRiLcCObZvA5Ri7Yp+jvkDD+Zi5ekd6nJjfNTbSxS5z22gwl1GFkuVi+a59vkILzr79aNsR/Y2zx0J+niqgoIl2U9Yj2q4I9P+LB8wvZK2TgENcVfBMA2RveC6IRsxq+62QYpKWPd0R7mn4esgHk4erE8qb91II6R4LL9EUJp6ANuwL2+qcYPkdy6pExNP8HuXb/GeXYH2Rwe9pYV8IueQlRovnO1UIc/zFeiGuIum4gWsbvrpzqaWruc+hw9RP21W5E7LCU/ekQvjmx8GLrd30VXuAtZBJKjHARkSaH0miuG+44XWvU6zvug3dSLks84w5+VQA==;31:J3/yBTEhordTb5LAyBM1bgFh3ozajq6NP11K1wGXEPAaJAY3dukDK0KEq8tuqVcjw9N+TjYi8IgDQGsIap06OcG6iI68y4nkL1s/vKMF6b2kPI9XCU08XtiAZQ+Ga1IXXnFOIEDxbabUMPwYWlDnEJHY31uydomQ/l9xEpEZE3TMVVRXVZIBq2iaNRBguyTxKjILvXbv8TB+eG9dX0oiXksIPdgzuyOiFF0buoleOuc=
X-MS-TrafficTypeDiagnostic: DM6PR05MB4587:
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
BCL:    0
X-Microsoft-Exchange-Diagnostics: 1;DM6PR05MB4587;20:8EfU/DinS64c6a8cPigOjey1ULQ143qxZnmXAuO9fHygeR8ffJ86Q7Fvp7dRzsqDNz8Ggr9SVVzlRDdxzCnIFtmR8Oe7pL8l34XrWbGh5h16/61CrogLiTgh+dLBw0ZVX7D0LXAW+GvLmLxVvY5OKNetVkt4Owj906Bb2CAFQ0vNbbaH4rRrTlxyeQyfzZZp11QMzYW320xTSpdxPtu39Dr5AXZK8G7sBpPOg2Bps+iG9NGZyvg4UZWfTJiFook8nGDAvnqpelmOhLygdyxOeTEN/8KsLxeloeq0Nhlg3W25gQgYfakSkfFTkNbPwHtyCcEAgbaO5HDH2mGaaYc5swHdIsSJIElvoaydsgGE+W+fo1A4ymw0QAlQGV7JmFj5VYui22zRtZNc2F5s0eF7IcPMAGJ7bZiCaJVHObIEFXk9K2zkGf93aWG2R1vbdweTnaEs9QxkTO6AJ0s8IRTjBxOZQy28A/gImuftr60g42cRbXyWIQZPnv2+CXS9M6pGZNiwRqY4F3yyjQUHLlomSwMnPe43xFYzKECvGEgdsjULgnYn8deguPm8X0dEEWxmchvHQwrNb7yRBCNexGFnBeUjP4pA5JTq6YrMJqbqBWo=
X-Microsoft-Antispam-PRVS: <DM6PR05MB45879E1023FCC5419CFD24D4A1310@DM6PR05MB4587.namprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(61668805478150)(9452136761055);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699016);SRVR:DM6PR05MB4587;BCL:0;PCL:0;RULEID:;SRVR:DM6PR05MB4587;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR05MB4587;4:66nX8ob+2EzaXp3F+YW56J7z6UJH2jyPUnbU3lkaUEMchaUuMqN8L1eK0jr77iVjqmjmE32dV7uWAeIWlSGWp60nSqQa0xrkX2cJn1ehLfsfU7eYijybkMUBcjtG+fT2Sqh7tgKbkWLP/+6IDQtB3qJP61177PVoYpcLdXitBWW4Xxu1iwFX3PekoRMo9QKkGmzFcV64+Q9kiI8/zKTwpBSJhscy8g8opJ5mFdZzIdgOqxl/xeGc9fY1aKohEfgc2IRFGBTQ7JMy5feZ2teY6RGJLKoGTGZe5+Px0ADot9X77pBviavvkZXw/dUR811n790P1hsQ15QlU6B0hG75Ev2MZSwsM9QMizIzedLeLys=
X-Forefront-PRVS: 0771670921
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39860400002)(396003)(136003)(366004)(346002)(376002)(189003)(199004)(478600001)(36756003)(31696002)(76176011)(316002)(86362001)(58126008)(54906003)(110136005)(305945005)(7736002)(52146003)(81156014)(97736004)(8676002)(81166006)(67846002)(2486003)(52116002)(23676004)(6116002)(229853002)(3846002)(476003)(11346002)(2616005)(956004)(486006)(446003)(230700001)(6486002)(6506007)(186003)(16526019)(26005)(14444005)(53546011)(386003)(50466002)(25786009)(31686004)(106356001)(105586002)(66066001)(65806001)(65956001)(53936002)(47776003)(6512007)(4326008)(6246003)(5660300001)(68736007)(8936002)(65826007)(2906002)(6666003)(64126003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR05MB4587;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTZQUjA1TUI0NTg3OzIzOkRzM2sxWW1PNXR4bW9jZnhIZ1JDNVJoYytw?=
 =?utf-8?B?RG1iSkFnOVEyQ1U5M09uSG8wQllwV3l0cnBmcFdVU3VBdVZXdkFBZVpraEsv?=
 =?utf-8?B?eTZlcnJ6QWlaM25FS2FVcGh2TXZjQTFhYUovU0xzTVNHMGE3NlNiUzFEV0JH?=
 =?utf-8?B?OXJ6NmNOdGhDVVRjUDZ3cW9MMUFGTStZbU55Y0Z4eStVRW1vcWRFTHdHRlpF?=
 =?utf-8?B?bzRpdzlNckxOSk1aUUJLdmVVcEZxRGRhdE1TdE5Ga3Fqb1JzWnNyVHJyNXJ0?=
 =?utf-8?B?cEZ1dnErUVh4TXFqQjlyMmdIU3lNVFRBRWd4UmM3bFBZQzZ0WnVBcXdyNUNJ?=
 =?utf-8?B?eSs0M2V4YlhhUzZpem1BaWhpY3plZU9aY21JMnBUWVA2aXFGK2E4SnhsVVVp?=
 =?utf-8?B?dEJQWDNjRWo5VTl1M1J3NDh2Ynp3bHJva2gzYWRGSkZ4QldhZ1B1Qy9idkw0?=
 =?utf-8?B?cTRvZHRydGtQdDlxVEk0SFBESkk2UUZiL0x1aEx2b1F3NzdYK2hFV3ZUbHRL?=
 =?utf-8?B?d0xDS1dvUlFDY1pNRVErNXo3K2xVN3ZrSG9BazY3ckw0SmVHQVFESWR6TEdU?=
 =?utf-8?B?Tnd6V3NMdTRzTU5JaWpvVU9FSjdOWTR3akVmNlk2eXVnZXVkNDhLK3p6cGo1?=
 =?utf-8?B?RlRUaCt4YTE5YUNWV0crek55eFh6UG92U2Y1SktMOE5LVWxCaHlsL0JYaU9S?=
 =?utf-8?B?NVY3SDVkaWkyb1NaemVpR3Z3dTNabnhrRnBDVlJiN1VZZFlrVzFwYTRCZFFS?=
 =?utf-8?B?WUN1My9tcDh3SWJMcUNHZkNiSjdDakZINkRNcU4vMi9CdFFnaGZnS3JZdXFw?=
 =?utf-8?B?cnZZL25zRVgwLzJmdGcwOUR1Qm9yenBrTGc1ZTNvU0JUa2pHTHpSd1g0NmQ1?=
 =?utf-8?B?ZWtIQmtTVFR3S2RoVmdmTVp3Q2czd0F5aTU3dXNKT01kRHJKYS9kV05zaVQv?=
 =?utf-8?B?ZlZoNW5JMUgxVCs1NmhYRENzcEl5cWxLaXhNZU1GbkF3UWtCSG96bjRESHBs?=
 =?utf-8?B?VnRJYXNEdlZtak01YkxMZlpqR0pqUWNNS1FOMGhtUm9aVS8vOVFiYUN0L1NY?=
 =?utf-8?B?VXprZk1vZzRqa1FMQkdHdGlENGdLeHR1WHZpdjFJemlxN0F2M0JOVENVcUpj?=
 =?utf-8?B?WG1QMWdJRWY1dW1yaDFuWVByQm5uUzhqR2pvRmF3SDIzaStjOTZLZisyK2hw?=
 =?utf-8?B?dUZHRXl3cEs0blBQZ3pFWWpNMHZMUlpFMGFxdUxaYSs4cy91SW5zQzJIWmlo?=
 =?utf-8?B?alp6bTQ3citjY1QyUC9wTG9kWGRyTVBuRjhVNGJabDNGcTRzd0ZCcE4zbGh4?=
 =?utf-8?B?U2N4V2NFajBnZC9jV2E1MVF2ZHU2TmYvTS8yV3R3TEs5OXlXbVM3ZWdUS3kr?=
 =?utf-8?B?NGdRU2FERGdwbGFNRkw5NmlMUEUxUjR6c05WcENJa2xUUG55VHgrZ08rNnk4?=
 =?utf-8?B?elVRVFAyaEtySW5ZVXI4eHNsclE0WWQvYlBXdExwcXd1QnRlTzZjdWFXS2dz?=
 =?utf-8?B?dzBPemp1N3h6UlFEdUk1Y09ZZFQyV1pMQjFIcjJkWURaTU44YzRIQjFBN1lS?=
 =?utf-8?B?bVNHaFVpVWNlTE5MRHNwaGNTVkxrNU5Wc0Y5aGtScUoxU3ZoQk1mT0lWT3I1?=
 =?utf-8?B?N09NN1h1clB4TmpoNDZvZW5yUTl1amp4NnpWTFZhWEN6T3FuZnBPS21zZGRY?=
 =?utf-8?B?VlowNDJocUZQU2swL2s2QUh2Ni9KRVFVbHhoOHVpUFBYdlkwWEFUcXpCKzFt?=
 =?utf-8?B?cHF6UXo2MTM1WVNKckcxSWdmNExQMFk5ZlFQT0FoTEZBeVFOeDNyWnZQN3Ni?=
 =?utf-8?B?eTEralNFcnNTZFZCSGNTekU3RHJuUmc3RmR4OFZBczkzMWVtYkVzaDR5Qytq?=
 =?utf-8?B?OHNCOHN4dVZiOVJHNS9LQXhqQ0xpb2JUUlovODlQaEJldXpMUFlyMjVnY2Fr?=
 =?utf-8?B?VnlNbFl3WnoyU3VTL0FzMVNRQVZiQU5CVUFwN1dVRU1hUGxlbld2VnU5VFJG?=
 =?utf-8?Q?uizxIJ?=
X-Microsoft-Antispam-Message-Info: CKMDRY9I+JdigCYgCCKMPUGBaKgxHHG4RnqvqjE8P603nW3oLoM05qqv1ju9+8bk6OpGp+Qy+lvDxz9I96YOGrDVmSHQDI5BXsw2UgruJIR13yh7wT6oECnIdGkwTngPQeX5a8XMdSxhuhG86RDDCxS9JYG7qs+uCwF/UYUL/SPCqJb6eOVoJ8+95WH5UnyUbivaKueNBrJ8GaNjVXEkgvvr/wzjrdaSrO3lclceBuz4RMCv7xV6YJbMMlPGwXrEuVvXsz6dMvOl0rzr2K26BFIbmS+vv3w7v1iWtdIOmOaAs6IkfXyOzi1BXGkY/kwEt9Ps2dWOBXthvH98Fu+UloDpGGxhCQHqMOXpALWsg78=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR05MB4587;6:Zd16Ld2x19dkPPX7PizhfIhVW4wYB1eiTl0eUknU9CN0TcUy48emYLOLIdjnptBwMtUwc3LJSsQ6zO2a25N1dqgBkhDPpGqC0qNTS32uedcKXZpI3PFmQGI2tPGYzpe+gaGrpBD75j2QZB8W7FaHpxojxEStdZwgAX35Ndf5LJZ4LfA0HDYQAM7I52/U/9u6OS4dp/YZSwiVW8arAyJGBYn9FgJMmokjRapDeqH4kvJoE7ZH2ij63ZcAeR5TMmgnYjF7GR8uIYDLFCfXv4eSTkabJcrpU78B/oP83KKC61xc/xWSZ3U5a8N0C/Yg4Kj5Kef/rE0g6ZIdK4DLJ7Ui5DTMedfY5U9TKKmfn4g9hT18xRgibF6buRJNtn0TNKwzn3e/ZJggIAxGiHFFgWLxVLFV8QoDzhC7Z/wbIsd685aMzxuthTE6W3wwI8APRb1KCZj8Yig7eQ23pjYjpLM2qQ==;5:RtvKj1Id2R0fA0ESCXf2V4IJAlWD68STougm4kz8o+4XUGOq9EyxFlcP8KbZCWoL4Rlj4TSyN1vSgxXLN05sf7VtHKNdAyZAWhYH+b0NNffqJKec6GuSry2kGZjCZOqcH8LE6sAiZ2xQxQ3LSVpBSO0ThyyU7CK46jbLS705cJc=;7:qH1wlPGMyygVwZQepDT4LD1bU4EV/9WYK13Wjrw4iDPgJ9iwUllXeNTZ1d00JS3h4zUk3bBGR3itfIB5ZxgX2OQi+eeY3i2yGlZ2fcQhyP8Ez+uiJffOZMP21vANPtAiAfxx3YMZ1LBPQYTKa8u7n+MRywQBq12U/Iw2IaorE2LUGjK5mwI5llem1IqRyjDxOUby3MAVxSn5yrVlMpnYaeH9ioxe9bsR8cA76EXXMsDVOpVRQbsCZkZJruWB62Gl
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR05MB4587;20:fObUca+mRQTWNOzfrttbxmRFTAh/O1p7ARklgafA3Ycsg7QXHF+Mx0MnN4txhOPn1x+XHEnYiv22Ktez+Ph3mOqI6EPJRzJoMQRt30juo2hYpde6oE4afHBRE7XgOC54yUSef8ifeC3HzwInP2byKFV5EkVst5MpF5VH5VftNI4=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2018 08:19:22.0997
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 803ee376-ac47-471e-99a0-08d6073ecd55
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB4587
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/20/2018 10:53 PM, Deepak Singh Rawat wrote:
> Looks good to me based on my limited understanding. Thomas/Sinclair can
> could you please review and then we can include this in drm-fixes.
>
> Thanks,
> Deepak
>
>> arg.version is indirectly controlled by user-space, hence leading to
>> a potential exploitation of the Spectre variant 1 vulnerability.
>>
>> This issue was detected with the help of Smatch:
>>
>> drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c:4526 vmw_execbuf_ioctl()
>> warn:
>> potential spectre issue 'copy_offset' [w]
>>
>> Fix this by sanitizing arg.version before using it to index copy_offset
>>
>> Notice that given that speculation windows are large, the policy is
>> to kill the speculation on the first load and not worry if it can be
>> completed with a dependent load/store [1].
>>
>> [1]
>>
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>   drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
>> b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
>> index 1f13457..ad91c6e 100644
>> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
>> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
>> @@ -25,6 +25,7 @@
>>    *
>>
>> **********************************************************
>> ****************/
>>   #include <linux/sync_file.h>
>> +#include <linux/nospec.h>
>>
>>   #include "vmwgfx_drv.h"
>>   #include "vmwgfx_reg.h"
>> @@ -4520,8 +4521,10 @@ int vmw_execbuf_ioctl(struct drm_device *dev,
>> unsigned long data,
>>   		return -EINVAL;
>>   	}
>>
>> -	if (arg.version > 1 &&
>> -	    copy_from_user(&arg.context_handle,
>> +	if (arg.version >= ARRAY_SIZE(copy_offset))
>> +		return -EFAULT;

I must admit my understanding of spectre workings in this case is 
limited, but why do you need to compare
arg.version against ARRAY_SIZE here, when it is already checked against 
DRM_VMW_EXECBUF_VERSION earlier?



>> +	arg.version = array_index_nospec(arg.version,
>> ARRAY_SIZE(copy_offset));
>> +	if (copy_from_user(&arg.context_handle,
>>   			   (void __user *) (data + copy_offset[0]),
>>   			   copy_offset[arg.version - 1] -
>>   			   copy_offset[0]) != 0)

Similarly, we want to perform this copy iff arg.version > 1. Why did you 
remove that check?

Thanks,
Thomas

>> --
>> 2.7.4
>>
>> _______________________________________________
>> Sent to linux-graphics-maintainer@vmware.com


