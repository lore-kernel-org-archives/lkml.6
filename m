Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0B7C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 03:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FF0C241B1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 03:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="N/Exen6+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FF0C241B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753185AbeGEDui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 23:50:38 -0400
Received: from mail-sn1nam02on0069.outbound.protection.outlook.com ([104.47.36.69]:6228
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753068AbeGEDug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 23:50:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1sD/3Guz+rb6mVGPJCmSoJmND9qwD8ivTbunHzSCZ9I=;
 b=N/Exen6+3HvWkmFw3EBAZECmfAD0vqUncxa54DF/BfknE9ffdimSMgwwWmzPJIXSiu9DPy8zbyl1LWUZT23+2k6jwQTfqD8yMBhhcUrjQelNQ0P8TGmNNcZXOfE02Ch85ojY3Cttmybtnu3vM9BwPCzZnP0pgHWTUvNO+jLjuRA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Shirish.S@amd.com; 
Received: from [10.136.6.55] (202.56.249.162) by
 BY1PR12MB0454.namprd12.prod.outlook.com (2a01:111:e400:51b3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.19; Thu, 5 Jul
 2018 03:50:30 +0000
Subject: Re: [PATCH] tpm: Fix NULL pointer dereference in tpm_transmit()
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Shirish S <shirish.s@amd.com>
Cc:     linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1530695020-21888-1-git-send-email-shirish.s@amd.com>
 <20180704171357.GB6724@linux.intel.com>
From:   "S, Shirish" <sshankar@amd.com>
Message-ID: <edc9b7ba-9b76-7708-31c9-b02a703c848a@amd.com>
Date:   Thu, 5 Jul 2018 09:29:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180704171357.GB6724@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: MA1PR0101CA0072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::34) To BY1PR12MB0454.namprd12.prod.outlook.com
 (2a01:111:e400:51b3::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 49444176-dd52-4b0b-83e3-08d5e22a7563
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(5600053)(711020)(2017052603328)(7153060)(7193020);SRVR:BY1PR12MB0454;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR12MB0454;3:BjvMeiy07cbouJprwKEKMgWJvxxJWw5sYqsN571ZsBh8IBgebY4MZPY4KgUAii9ue18HY6jPBYzAio7br2O6PXrXTVNzlojEqJsTz+TZoiJ06J7EcBztmZlc0HMWGftLSZqityaKfQ3zbvJQUfaNy6bcvmaXXD8UQdH1Skeh7vYtLVW/buj8VFpy1WCimcKs0L+fMgowx8aIBxmYBL7vRuy/p6BsI+HXfVMVldcjdDiE8PJGf4Cc7/hZuAPFD3q/;25:dQewc+7HqG2VUKROp8dLL6vNbhC+zetiGTA/QxUhizxhK9BgfsocCgK2mErUeRHB1FcA6/MkgIYS1SPs6lTDx3W4vTklma+wb3xbcevxS8iizsj29y9DDntQipEuUCA7jlGAhSMMBE8QWi0isMHmNg2mbc3Jr4KUFeFak0J69e95iySeehWz5H3Ttm9+02P6G4XhjXTQKTrhTrFJvBfin17fXhxG0Q9emKRJkHd3YoYJXJTH0UekBpl4lU+SwhOQYUc2x0FWfLDWCGXeQ9FsHXKCHHfCuEwewkCj6npH4Y2sZlW0lW8jeQUduwANye+7k3bWs1qUcvkJEkB1nDDuKg==;31:tqyPE503wmW4BsDRYJRGNTqc2BcBptmCjgpW3b1wKxjIcyy02tlR4Qh1VX6LskpsG+jsAOIDIBZi5h8/PQ1ZEGr0uLjmRMzsL9NORCfeLFqHJJdc3G5XeKc+APhw8WmiHoHuAlYx+KjqR3sY2YT5gUNf7/MVHmtahDG4l0vYBYzXmWDWf8W0eE1pEnTlAWzvnYGNJr7Rh7Pco/vP2lX+ssY7Wn8E96x6HbGnnhkFoPg=
X-MS-TrafficTypeDiagnostic: BY1PR12MB0454:
X-Microsoft-Exchange-Diagnostics: 1;BY1PR12MB0454;20:5U5hr+8HBaLNMXYFVibH7DDXipq8FGmx/cv2WH/Sb4KRrzGBvj4NbvirzCQfzF5whxkNP5mhWYe5zwGu2mnWCMsUqx+gwxhieXXw/06fcXCUOCRg2QOt4MC0uudNJyluUyyEJa3+Sz3nSIvpcLy7zl7T6oRbCGgchPHcPpTIu1uzsrC88gHtDJWBZrdZIQt5q+KDgsMBUH/8js27Gna9cFw7S04krKZ39iZ+gKS4UN/W1Sm9jCony2oF6PsQYh1I/OY4MecxzbdX/OcpofFbBmbbyb+w+nyhn0lBmwyLR4h01kbcOWSv+gC2/HOn40zMKmU+69ZZwAC5ImNmTzVC/TUcVeol4Vl2pjVpJBCiI78gBrlpVeVzB+9ASuDVLwxzvArs+AHc7xieRFoEkY6/sepr/Jyuj8Njg7Qh2LqnbIP+SvSx82QuXpaj0FFmAc2nTB1WYJkHWlAPawnuH/NE85c0nZ00DLc+q+fGq+/CNb1Lz9dvwq10WOjaWcf3j6iz;4:wrBGgeIHdgHF1XHLUnc9gMdV9WvKXr5sB4C9laaWEdc/L6xjXKe/F1IAQzUJVjnDWmgU5lDiIhdL9J1CWdJThB18DVBncCGu+R3ZjZ4qFCYROxXNh7/pxZwaGB7ncaf8KhrWeZT2Z2yWD/hKJ7JZe8OUEFLCH8pv618QeqJTwADQLl4vO8UHRJlr2zx/jsygDaoczG72CwfIHVIo4kBEJFVAlH3TNuIwJRqdUhJl/xWRT+fry9k3f6BKd6/hORwdKThpUlt3gSVI/WkCeMopOyUc9vaX6j3kdffefIGInF4gMJiMrN8wIUKDc9YwjFFv
X-Microsoft-Antispam-PRVS: <BY1PR12MB045462DCB298187536AEBD6CF2400@BY1PR12MB0454.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BY1PR12MB0454;BCL:0;PCL:0;RULEID:;SRVR:BY1PR12MB0454;
X-Forefront-PRVS: 0724FCD4CD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(366004)(136003)(376002)(39860400002)(396003)(199004)(189003)(230700001)(50466002)(186003)(72206003)(6116002)(2906002)(64126003)(16526019)(486006)(77096007)(3846002)(97736004)(476003)(2616005)(26005)(956004)(478600001)(105586002)(446003)(14444005)(81156014)(53936002)(11346002)(8936002)(106356001)(16576012)(65956001)(65806001)(53546011)(386003)(31686004)(47776003)(52116002)(58126008)(76176011)(110136005)(81166006)(3260700006)(25786009)(54906003)(36756003)(31696002)(8676002)(65826007)(6636002)(5660300001)(23676004)(67846002)(2486003)(68736007)(52146003)(316002)(7736002)(4326008)(6246003)(305945005)(229853002)(66066001)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY1PR12MB0454;H:[10.136.6.55];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTFQUjEyTUIwNDU0OzIzOkJvVi9KQ3A0VHdqVjJPKzdkeUdBT050OWFC?=
 =?utf-8?B?RWJrZExqTzM0OUQ3aWk4MGlJSFdpUzFHaDEzejVVS0greldycS8ydGpzUE8z?=
 =?utf-8?B?UWdQcFY3RXl0TVl3THlPaXBQcGdGWkZxVlJjeW1HbGZQQ011Y0dYdCs0emFy?=
 =?utf-8?B?UzRUbzB6UTdxbDE0QnI2d1pYRS9MM2FkMHN2RkdXWnc4Q1M5YWlhRHhYdThR?=
 =?utf-8?B?c2ljZ0JUcDJvQ2krd1BNZkdlV2YrNHZqWFJhMlZKZzBXV2ZLOEh1WVNNZXZV?=
 =?utf-8?B?UWJMbGxPaEovNzZDYnFhY0JoLzJ0NDU0R3R1akQxOWIvakp3bDR1dVJyaUNG?=
 =?utf-8?B?dGphOVhUR1NYTTl2S0VBKzBnSThUQTdHV2NiMnlHekZXazJ4dzlHRjFEZ2M4?=
 =?utf-8?B?VE5PeENQdEhMU0lJZFJOSDhuSXp4dXhXL0VHQ0FSdVY3Q0tPbUx2RlVyUyt2?=
 =?utf-8?B?MGhpSkRubE9xMVA1YXhkSFRFOStTNENtdjlETjFRbWpnZGc5Y04xSWlPZXdq?=
 =?utf-8?B?TnBFQlVsWjNhL3BHMUV0bzBMTTI5N3BCaWpBTDVwSWtBb3hrTWxXM1NGazBi?=
 =?utf-8?B?RzJiajRTMFdsZndxMFZVQ0JwemthQ1RMR2syVnhYVXZKZldJWUFreGxobVpl?=
 =?utf-8?B?ZnNiZHV3bWFjMUR6cHNEZEJOZlBBSGdJK3prWVhiT21tL1UrQlFEM2lCekJv?=
 =?utf-8?B?eEpUT1FUcmVCRlhVTi9WNU5HT2kvNWtyWEdCUFpmZnU4NnFzVDFJWVZXT1Vw?=
 =?utf-8?B?b0pUZzljTEw1elVJMnlNbHh6UlJXZmF6b0hkNkpJWnVqbXJuNXRFNkZxZzhl?=
 =?utf-8?B?aHF4SkR0YVpwbHJCR3BBQS9iRTBOaEUvdFI5YlFPMlBqOTRlM1UxbFVzRWpm?=
 =?utf-8?B?bmpUc3VMUHJVMXlqVjdzd0dZYnI2eFRMZmpOL0pxLy91eTJBbllsZUk2ZFVK?=
 =?utf-8?B?WTV5MlNMNFJTZ0lwZ2VPKzBDUWZIR1dSK0dJdWY1TzZla1hJYjdod2ZuUnFx?=
 =?utf-8?B?MUNrcjBDb2lnZjU1MG90UmhEY1UxcDJGTDU2L2pPWHltRnVKUlYyVCtleVlu?=
 =?utf-8?B?M3lXWjNWRFZCdnp6NmYrVGpSK3VQYUNPS2Y1a1ZSZ3hvYUk0ZUxtVlBrQjF0?=
 =?utf-8?B?R2pUN2ZnM1UvdXB6K09WQ3hYNDJtY21Tc2RLRzl2Qmk3Um1NODcvMmVlekk2?=
 =?utf-8?B?T3pPTjNmMVczWjloYmpqMXV6TzhiOXFZN1hscml3Q3FqeXF6MXBGOGJnS2lC?=
 =?utf-8?B?UDdFM0tpaVNXY2FsWUlTTzN1MjhLOStmSlNaaldnekcxaW1vUG5rUVBITi9t?=
 =?utf-8?B?MkFRMVh5c09vTmoxYzZMZ1Q0L2VLa01xdjZwVDZZWG5ITlVTSElwL2U4U1FX?=
 =?utf-8?B?QkJHVzVJSXlORnB0TW5FR1VQUVNIVTZhMDcwV1hiL3RvUEEzaEJnQTRtakNx?=
 =?utf-8?B?bzV5Zm1nTytySmxodVRYVDl5UGtLc1VySDhOR1ppTnVYckZ3R0lObUl2M2Ja?=
 =?utf-8?B?TDcvR1puSnA5UW94RnBUUHBzZ3ZPcFJhQlN1RzVWZFR0OGpMcWF6WG5tRUhZ?=
 =?utf-8?B?cEcxblZ1Y2xQL3JQTWkyUjJwekJtbXpmajVHdHBzR3pjZFJ2OXlGaHdyUWtk?=
 =?utf-8?B?VC9YMnlKT00vQWhXVk9OSlJPa3kzTnNkdzRHUDN5aVdadUh3RUloWE9QVHZW?=
 =?utf-8?B?K0RPT3RaM2xEQkxsUk9KSmtwN1JVb2xZVkQxdWFNYmlKUi9PczdLbWRnSG9W?=
 =?utf-8?B?QzNEWGJSbndhSW83Z2tsL0JIYWxxenExYWVRMjh4cFVvb3N6ei91Z0R0SkVi?=
 =?utf-8?B?cjNqMmhnWWJqUHZEYXV5dHZhVmdaSmtGbUd3RytNaVMxekVBVS9WQ1p2SU5i?=
 =?utf-8?B?Y3N4bzkzeUNBQkNqWWRwZ1NPWmFtUjBBTTR0TUc5LzRhZzJCV2RObDlRWld5?=
 =?utf-8?B?V2F2R1RuRVMvcFVkK1RCNU5kMzJ6TWE5QzBYRG5OdTdkVHE1TVNheUNiclJr?=
 =?utf-8?B?eHRiS3lKUUIzdTdvYzE3RkZXNXcyUEUxcGE3dz09?=
X-Microsoft-Antispam-Message-Info: m1QUlqvu83/LE8R2KMqjvQtWazTSRurVlj1JY9QqgcUeByiDO8coBWT0nugTJ/8PMNRNO3x0MEmGHPmoKBdn1pfmu/gCS9Qp3ygo7n1ba5LTo6rd43eWl0h+P6OlmePgNqcj2n7YPiZsV/88Hetu6mYupevcfFwMjGWJvN8bPT24vyBBIPgOkpXXsgarfarChlcL7U+vm8bxOETRsGfI1emIcV/hDkMMt0WSLb1XivUIRWaykpPQwjSj9/ihXvKPU1Hip13F8Wh42c9+KILP4Pujc5ylb1f3PFaDvuowRk6FkElPztdgUXEA84J2/mqzKf8IZMysWNAy6ltK4UfD/RLnMqA5Bc0a8r/vu460orU=
X-Microsoft-Exchange-Diagnostics: 1;BY1PR12MB0454;6:4OpO5wiJOANxZrzSKFQU9v3w9adzjUJBGerqbpHULVKeQHt1mkGknwudLIdSEGmicjPI5MHvFbgayKzEray7Ksem7KtOW9ue8+w0FDlKS6D8fUMvJpnUhMJOtzVgDuBUiK8EhI9qIr2x1hZNYEWX4MiByR7s/6xrzWdiMsiV4wR/rAUPOyHsoVE6U4nFP2NGACKjnAj4q4iJcdWRjRr7R0t4mDx74FcRWBODaBsr1Gfq4XYQJS7YGqbyyz5Hg52ZlTK2TttdfzGvedq8kwX1b0n8+cZtFPA86zBWbYXncY8vrgxidPXYjJcHQe002HhL3Sc6MeIPuRefHn5L7UVZi/0G4j6v0G8UcCJzMHYn+J3ZQMKPtxMfoiO0xzvIPHj5cgDMLW9Ip0mzSgmzengbJF50C6N2LJuXm3Eldi5r8cB+axUligaYxYCjZYX4GV0VYut0afw8WljkWGoNaCBB/g==;5:xDLHZ2bW0wVpqlo3NuKgmWc6t8n+OJbCSwXvWiVNpZ2Eorl0Vj/Zt1VDTcE61Rim/rknEePMLwnnRcodNo9WYphx6uGEW3dKRF34SIg3zBhfjhh02k/hWmPBDoDKDrvuiN9Pb3JAcH7mrKmhEu5opsckgYZoaNIsNhpgHySU15M=;24:T+gRMoPzEOmoY88aXW0Ds1oE17dNfll3tdTIQydOykcscW22NBe41QrNtqPF5YUkb+r2Z5SOWwRxcrRUjgUeMext4IwFfknw/s/Qvp14Agw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY1PR12MB0454;7:aOxTosY4s4rvqhEejeb4X/GHy5h1uaHuoSOoeJ0Jo9l8N7+CDHbEJE05qup/9f9VxUgP+S1zfBXCvKJE9JhLnyZ2eh/VwKP5I+MQufIVyLT0ER3KJaDoJSmVK3+7b/BmdrqHa2M6EsrYOE30FVTxlAnP61ikaHSkhduOhkp3PCZgeryPI7k08Rpi0He7wMj168wssZ6slAFz6CSQcEioU3FABgXBmj9oFHtNB1q+Is20S6j10d+R+TcrYaztHD/S;20:z7YRW61EP8yS308hfjihiwClSX2SAlokBVoMbeTbbhlKKm4NIbihWAQxBP1FBQSPqaa7W+DpHtyyE9xF7BwhCqae6nAyzQQNDMaH7FRKZDW+C/lxJdX+UczkZJxVGDmYBsgA/cj7z4CbNj+xuSB2eEZJTuXa7aloCeyFK/8Abi0rjGdfdao39+WOxWcNBFLDCIjeQCb3eURumLvzxrGMg0/aoCSKS6GuRcIC8i4QMLiTgjl40EfNJ2G13I3dCS40
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2018 03:50:30.6615 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49444176-dd52-4b0b-83e3-08d5e22a7563
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB0454
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/4/2018 10:43 PM, Jarkko Sakkinen wrote:
> On Wed, Jul 04, 2018 at 02:33:40PM +0530, Shirish S wrote:
>> During system shutdown,
>> tpm_class_shutdown() when called with TPM_CHIP_FLAG_TPM2
>> flag set, makes chip->ops NULL.
>>
>> However tpm_chip_unregister() called later in shutdown
>> sequence tries to access chip->ops in tpm_try_transmit()
>> leading the NULL pointer dereference.
>>
>> This patch fixes this issue.
>> Below is the trace for reference:
>>
>> BUG: unable to handle kernel NULL pointer dereference at
>> 0000000000000048
>> IP: tpm_transmit+0x267/0x565
>> PGD 0 P4D 0
>> Oops: 0000 [#1] PREEMPT SMP NOPTI
>> ...
>> task: ffff937c847fe580 task.stack: ffffa79f80b04000
>> RIP: 0010:tpm_transmit+0x267/0x565
>> RSP: 0018:ffffa79f80b07c08 EFLAGS: 00010286
>> RAX: 0000000000000000 RBX: ffff937ca9bc8000 RCX: ffff937c847fe580
>> RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffffffff98e3cd40
>> RBP: ffffa79f80b07c88 R08: 000000000001fff4 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000000 R12: ffffa79f80b07cd4
>> R13: 000000000000008c R14: ffffffffffffffc3 R15: 0000000000000000
>> FS:  00007ef31f747740(0000) GS:ffff937caed00000(0000)
>> knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 0000000000000048 CR3: 00000001243d2000 CR4: 00000000001406e0
>> Call Trace:
>> tpm_transmit_cmd+0x25/0x70
>> tpm2_shutdown+0x69/0xa3
>> ? __radix_tree_replace+0xd9/0x120
>> ? idr_replace_ext+0x92/0xb6
>> tpm_chip_unregister+0xaa/0xdb
>> cr50_i2c_shutdown+0x1e/0x41
>> device_shutdown+0x157/0x193
>> kernel_power_off+0x35/0x6e
>> SYSC_reboot+0x120/0x1a3
>> ? do_writepages+0x36/0x6e
>> ? do_writepages+0x36/0x6e
>> ? sync_inodes_one_sb+0x17/0x17
>> ? _raw_spin_unlock+0xe/0x20
>> ? iput+0x87/0x1bd
>> do_syscall_64+0x64/0x72
>> entry_SYSCALL_64_after_hwframe+0x3d/0xa2
>>
>> Signed-off-by: Shirish S <shirish.s@amd.com>
>> ---
>>   drivers/char/tpm/tpm-interface.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
>> index e32f6e8..b14d196 100644
>> --- a/drivers/char/tpm/tpm-interface.c
>> +++ b/drivers/char/tpm/tpm-interface.c
>> @@ -411,6 +411,14 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
>>   	unsigned long stop;
>>   	bool need_locality;
>>   
>> +	/* chip->ops is made NULL in tpm_class_shutdown()
>> +	 * This case is hit when tpm_chip_unregister() is called post
>> +	 * tpm_class_shutdown(), hence exit early and return
>> +	 * transmit operation not permitted
>> +	 */
>> +	if (!chip->ops)
>> +		return -EPERM;
>> +
>>   	rc = tpm_validate_command(chip, space, buf, bufsiz);
>>   	if (rc == -EINVAL)
>>   		return rc;
>> -- 
>> 2.7.4
>>
> What is cr50 anyway?
Please ignore this patch, i realised the cr50 is not yet upstreamed.
Hence the issue lies in in cr50 and not tpm driver.
Thanks.
Regards,
Shirish S
> /Jarkko

-- 
Regards,
Shirish S

