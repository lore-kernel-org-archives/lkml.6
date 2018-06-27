Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25E8C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 04:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5298F26518
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 04:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="AfLcJC/1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5298F26518
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751294AbeF0ETJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 00:19:09 -0400
Received: from mail-eopbgr20125.outbound.protection.outlook.com ([40.107.2.125]:61963
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751229AbeF0ETH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 00:19:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TjO1MYiAX9wsuF3luSqI3PUmDQ0bMiryEryeHeZW8RM=;
 b=AfLcJC/1Yq78L8Hi3Zl5lVmJXS7Rn4NKAIBhV7jinhb+sV9LZh0JIbHhhIFeOCn4230iRX2S+KYJuCsIhNDeaWgVJBiCot4m/MU7Mm0+tDSF3zL9FH1sBwSTZQZir0/hGU1w0qzav08iD6N6niRgyJdlSivsQgDQUh1LmH3GVUs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from [10.200.217.10] (93.123.104.254) by
 VI1PR0201MB2463.eurprd02.prod.outlook.com (2603:10a6:800:54::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.884.19; Wed, 27 Jun
 2018 04:19:02 +0000
Date:   Wed, 27 Jun 2018 06:18:55 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <20180626134606.h4ciolw23t6qnrjb@ninjato>
References: <20180620085157.30121-1-peda@axentia.se> <20180620085157.30121-2-peda@axentia.se> <20180626023757.l54suaryim2fieq3@ninjato> <79E4A06C-26EF-4FF4-AFEA-7E7769FDF995@axentia.se> <20180626134606.h4ciolw23t6qnrjb@ninjato>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/5] i2c: smbus: add unlocked __i2c_smbus_xfer variant
To:     Wolfram Sang <wsa@the-dreams.de>
CC:     linux-kernel@vger.kernel.org,
        Vadim Pasternak <vadimp@mellanox.com>,
        Michael Shych <michaelsh@mellanox.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org
From:   Peter Rosin <peda@axentia.se>
Message-ID: <58972586-68FD-4FD6-8B38-E7CA93D2131E@axentia.se>
X-Originating-IP: [93.123.104.254]
X-ClientProxiedBy: AM6PR0402CA0016.eurprd04.prod.outlook.com
 (2603:10a6:209::29) To VI1PR0201MB2463.eurprd02.prod.outlook.com
 (2603:10a6:800:54::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 963b1868-cfa6-4e43-e0fa-08d5dbe51d67
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2463;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2463;3:99VysUWyxpMEe3UTGCK6dinnp8q9rljws7Yw/jGJEL/B9lD+GWRjtKQ37R1IYyzO6kR6Fop8K4xG9Xj0bag52ubNxpvRR6ZK5Lj4rOIlNhCEHwBJWrnVRxJPwEtiknIlF9PPAe4mNJ7UCYYJ16R4lZx4jhRk8beCN1MHpiZZ78ZgcPxSe6xO47Lvr/ezzlCzUBlfMtLge5qWVPtbnKSH4hbJSCER5ZJv70L7f+8MjHEFcyCU3Qif0cdjD4nNC2xz;25:eXefL6B7mvnoHGf0M6dqhWWX7kG4Z95s1UZ8x3NpnuGHsfI03cmG0QkXeGhvqlaboTVluXkWNxRt1y7ZVIJ9Q6040eyK72NnW3bN9OZTFnIQFmPEm0pR+uAhPviaD2TfJTVaxEvyNPuCyKvHEKnH3WXSvHwh4OmaPFGTtZNSjUKfgHBFoMHYfMAQD79IFByHpazHfnEbh3sOyqMzMLQiQ2MIYZ/rojjiJuSPpd2tePKt4RVCGXwrR1NcSmxDwr6x0GSbIfOgwibvCtqYWAYJrxls5BwTanVc1k/S8b389INwrkFmdtB6lGk+PiFHNp5GpsORxW45k6vTaurfiocEJg==;31:sekxmxMc8FcrnuXOs/4TBZExVHwp2x1gtMif5/tUAu2wTeFOkLeGtxJQ6al+NuskaGvJQDdLC/sgwrWj2jh/ewBf0vOeNLjE6bK2butkylJarzkIMoEpp+4q0Hex2ysFDKEenBYvuEGT3kyvQBsS/c99nx1Qo2AQX6EAjzQETABQqzsvJiRdE6zBX1mxD4XtT7G12gRRzyVGUwEgCmDI6lxgoSZgmlGXDxKFBHiYJIY=
X-MS-TrafficTypeDiagnostic: VI1PR0201MB2463:
X-Microsoft-Antispam-PRVS: <VI1PR0201MB2463ECE0E8AE48B625978044BC480@VI1PR0201MB2463.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(2016111802025)(20161123564045)(6043046)(6072148)(201708071742011)(7699016);SRVR:VI1PR0201MB2463;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB2463;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2463;4:NzYqaN6IdYA/MjqL8PEG0ah5zAE2NUsca21Y+UHd0v58g6pci4k05mVS/WrPtRkKDMaEM1nc/V/tszE34n1hjo1ppIPyg/ZwuEilR629/8taUJPeg58QVgxvuFsXrfgsXYLQQ3K/cuK2oU3xvBSmVvOTk11if1E3SaNkGnhl1WEHgmvBUx7v7aU3w7bjQNd25umsTFzGqueBBkP42cHLDHXfg8n9Z6eDAiBZzARDje2UDSvHQsQeW2BOcS5Haq/ZsnXeZVCNNAFwBvVJPBXRLg==
X-Forefront-PRVS: 0716E70AB6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(136003)(396003)(39830400003)(346002)(366004)(376002)(189003)(199004)(305945005)(6116002)(478600001)(82746002)(6916009)(5660300001)(81156014)(8936002)(47776003)(66066001)(4326008)(39060400002)(956004)(53936002)(8746002)(6246003)(7736002)(97736004)(476003)(446003)(14444005)(81166006)(36756003)(8676002)(6666003)(68736007)(25786009)(15760500003)(2906002)(486006)(2616005)(11346002)(316002)(106356001)(54906003)(86362001)(6486002)(76176011)(105586002)(33656002)(50466002)(58126008)(2486003)(52116002)(93886005)(16576012)(23676004)(52146003)(3846002)(186003)(26005)(77096007)(83716003)(16526019)(229853002)(386003)(74482002)(70780200001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB2463;H:[10.200.217.10];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAyMDFNQjI0NjM7MjM6WitsT0pCa0ZHeGtSeW5YME9NUWRmT1dB?=
 =?utf-8?B?UWtnK3RuTGRZaVJXOXhuUnRteDA4a2swL3YwL3pEdnlreGl1NGhZNWF2anpP?=
 =?utf-8?B?cEVIMk1FZmpqK3Q4dWVHYUcxZ0JLT29CdFpkM0c3a0NSREw4TjZyZ1oxN0Nq?=
 =?utf-8?B?TUJUUUdxT0JJVDRmaUZaWFFDNTNYcVEySlV1dXIvUnB4cU5ac2hjdDhZWVV1?=
 =?utf-8?B?b29iSE1qVSs3TmVVNlJQekhXYzlHT3dUV2Fic0pmT3JmMExpL3RJdzlhRy93?=
 =?utf-8?B?TXdscGk2T09IZnhoZ09WQjQreHlvcjM0b0ZyK2Z0NXpVczBuREJMaGF0VVcr?=
 =?utf-8?B?RUt3OGRtS3duWW1uWGRTbUhqZmczMWlhYmZTL0JxeVZjalZLbVRqWkJ0T1JP?=
 =?utf-8?B?OEhOdzZ2dEFCMlpkOXhTakNHVzZYSmM3N2ZnY2pjclIyZk0xUkdDNXEralhL?=
 =?utf-8?B?eEtxOTZzbEZ1RDRHTzNOdVRtUWxEa0t4WklPSXEvdXVEL29EQkFadSsydHBP?=
 =?utf-8?B?VWhrcEd3Undrazc4cEo1UjFjTVlSS0lTaXhIYXJMOVhWNndNbUlkYlgvZGR0?=
 =?utf-8?B?NitGaWVhS3NHK0k3dnR5eFJod2szVUlIQ3BmMlFGcEIwTVdIbjV2YjVySUR4?=
 =?utf-8?B?R0xwM2xMenFDbll6eHRRWXNlN0xFb3JMSGtlc1NveE1RTGU4Q2M0SDJzSUpr?=
 =?utf-8?B?bzJKTjlCYWsyZlVINEdCOEpXVkEyZTFRL1piSnJjMEtNOXQ3OUp6Q2JaaFRW?=
 =?utf-8?B?dVM1WkNTVGMyU0htRno0WkRraTRYRU1TYnRsVlg1Nlh5VlFZT0s5N3lmeGFI?=
 =?utf-8?B?dXp3MHJ6OEMrMnZNNlg2WDZkQlJoVm9WU2N0cERtdjZBY3h2QWFteGZFNjRr?=
 =?utf-8?B?YnlpSGNCTkNvaW9mN3prRlZzUmJlc3cxU0dTZk1NZHd5UEI3UlZZY1ZQMXNK?=
 =?utf-8?B?MjdIUEhPK252VnRtWHJITy9FcGZ3aFJIZ3M3TXNCQ0lLcFhrMHl2V0hCZnNE?=
 =?utf-8?B?cVo2VEhQaDRUd3VIS3oveHVuckluN0RFNEEwY3FhOW1tSWNtZUNCSWwyb29h?=
 =?utf-8?B?SElHVlZ2VExPeUlkUFRhdy80d1BTb3dIcVFUK2Y2Y2ZUSlNlRGpCcUFWenVH?=
 =?utf-8?B?L0Z1Szl5eFBKUEVvNUZUcTNLWTdRTGU3alJDRlcxb2pjYWdiNVk2ZFcvL24v?=
 =?utf-8?B?SVEzQ3pNYTVUamRnQklIMVBTVzlZWGFXdW9wSDRHMWkzT2o3Ymo5YUxXWW9Q?=
 =?utf-8?B?OGRacnlEbWpuY1krSGRVZ1pySEpaaDdDMmhLV1JnTjdBaThwMFUya0NYZ2F4?=
 =?utf-8?B?WDZpVjdqMmFEOGRsdDZqSFJwVE1qOGIwbEJsSnpqUUZ1SXZoSWc4bUtxMDkx?=
 =?utf-8?B?K3NYRDV5K0tNa0k2ZHBjSXlJQUZ5RkY1bThMVEtSRHhDa1dXTy9IKzNRSHZD?=
 =?utf-8?B?U2pZZE8rYWlsZllZakxUejVTWnVJdEY5cW4wZmNFUFVEeVhKbjI0WXlCVVZG?=
 =?utf-8?B?TWU1YkN1VXcwNDIrdms4N1UybVdyRUlCa2wzeWxLRGJkYnBuVTVoYWVLbkN4?=
 =?utf-8?B?Qnh6bFpmL3VYbFRLamVQVW11U0dWdW5HRGd1ZGFoUDVVWHU1cmFWcnp1ZG5z?=
 =?utf-8?B?cmVEWWl5WDV0SGtNcVdqVHpjMTdPc2pKVmdVbjlGektJcUNyd1RGbnRoWGkx?=
 =?utf-8?B?ckFsWnIwZzBTN0RlRkxyMkowWE9oZE9tN2lBOHo0KytmRVhCcGhlNmxMRGZh?=
 =?utf-8?B?Nm9xeW9WZkNRdlJUbmhnUTYvVmhuYkgvbXJ2a2lRb3hNL2kxaWkzRFdERlVm?=
 =?utf-8?B?dDB5MmRNWnM1SEUxRUhrTTNkdjl1U3RsT0VXejRSSE1DZlF1UU9WckRrS21I?=
 =?utf-8?B?VEtrazBWMGZ4bDBZM2liTW56OHQ1aG9RVGM3NnBsWTlnd1VSSjlpaldHazZR?=
 =?utf-8?B?TDVTYVQ5T1NiMjhVK3RqdWIxaVkwTWI0VVVqbVF4RUZFMGx1WHhTNnMrejBm?=
 =?utf-8?B?WHFocE5ISXIzcFVBMHB2VUpScXNjSS9PdGYvbVRTSTJSNkNvSHZZL0FVS2U0?=
 =?utf-8?Q?gUkjqU=3D?=
X-Microsoft-Antispam-Message-Info: kE+amOdBqR9X9Nl35snLHaY1DV/RqQCWu5vhke37NRJBX2Sm1pn7GAQBAceHe4RI9ny9Xdv/aOPPgaHkKr1P+R4W1w3QL7z8E3pmF5SVWxxB+l1AtLxWvbipgfYMmY+FPdXDxnqKqtsoLDz5gybeQkGWE8kIfHBcjp9g9pzQUrHbgLdkO5ZoQjEFdMwlUP5fUmSF6fF+lQCC384jn5mCI8B9yhRQyCqHhzl3qmeK+NF0tyoi5K7V2HNvYF1i3Oz8r+TqUERjj+MPWU0bMcocIyvy3QK0JcLBplIy6i7IDPU4YgcjbEJBLxwqMUFwwBrQgiA24Eyr5GTTpXPaGPxlvUA2FeTXbS5v/FnQQJidgP4=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2463;6:wc6pPZJISBRb0Y7yWsOI6mBrDVzjdtL68lUyeurDsbet2oYdW2BNyacJ5IcZ+5JW3aHGa8j+OuKEW9pKU3NEhRXMVSSWzYGgb8ATSo21cqT3uMQlASQ/dd5HVe8/QnS1+mCG67Rx2MKj9IBTAx/Tkj6sBcpJHKlK911MwethKMcCtU4hP0TNPkGzaX08jCbrKUQR5Gwc84af8P7zxlfSFo9jQwLfRdyenxLEi/ZVFIQwk+1jOgCUEFN9cllnK6T1zbBc2RrAGWsJUdL8U1k8fafsBE8N+0hKT9lvBJnJfUMDF9M8Db/kjLOlpp85hVpZBfmAnejpuAL5osPG7KH/d3hR9qX0UhBZhK/fnwbEej8F+/Gq5ai8luVT/Cc091ja3F30ZTe35Uz38Ntf3C54HPlynhtK2W6QKb62e3jOagjwAcWoP8zyhfeKjGTXFihEYUQCg7uRngM6hoZPTW9ZXw==;5:a204scQEKdRSZySGUtpwvdgNJm92p/PYJyeVESbvZ2k4f6eddhTJqge7QeW0l1nrh441++oJs1mehM6AywahkL8fEm9XxApsQ2J5e+hNrQ6fJYLqdHKQK+C1lADXYmLv581ENnsoTQ4NP2Aab0XfwMdlxz26jdDsheog10VRfDk=;24:53XKzG56ZeI1Kan1rYdqUhgqz0VRBuNVPJVos0QHZ7MMhPvn0eMsV78H82Sc8f3hxazV7RYMrMStUPNXzm9ToKnBGyAjDS+MS+/9kFvaNuo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2463;7:Ulnd1VkNyvqQioF8hO8qVzw3RBvMtSm1W01rw14eZirRr//vb2LUbPvpbi+PKcwWZcc1kI8cMpGtMznn03qQD5tIz1GsoKbH6wTLlWVHlpDPU6gXOTEAv/O8OAY9G5+AMlvrBtWweEWyRFPugUwkXZBH0aYqOo+KdQ/Weew1nFGqK3zYeIzg7V+UPnDDdVP8o076hLoysAuasqID6l9U6dJg1BgIqvnKkEXQq+UIO4TcO+zaAtETHCxjUMYmfAHz
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2018 04:19:02.4508 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 963b1868-cfa6-4e43-e0fa-08d5dbe51d67
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2463
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On June 26, 2018 3:46:07 PM GMT+02:00, Wolfram Sang <wsa@the-dreams=2Ede> w=
rote:
>> I don't think it's that easy as I just thought about another problem
>> with lifting the locking from the emulation function=2E It calls
>> kzalloc(=2E=2E=2E, GFP_KERNEL), at least in some cases, and that's not =
a
>> very good idea from atomic/irq context=2E=2E=2E
>
>Right=2E However, we could simply bail out early when we are in atomic
>context=2E Simply no DMA then=2E=2E=2E

Yeah, we could bail out early, and perhaps we should=2E But we risk regres=
sions, see below=2E=2E=2E

And that should probably be fixed before we add the unlocked __i2c_smbus_x=
fer function=2E

Because, thinking more about it, the problem with those allocs are not rel=
ated to the locking details; adding another trylock to the mix just makes i=
t so much more obvious=2E I mean, first we would specifically handle atomic=
/irq context with a trylock "documenting" that atomic/irq users are welcome=
 to at least try xfers, and then we blattantly break the rulez with a GFP_K=
ERNEL alloc=2E=2E=2E

Also, the fact that the buffer is DMA-friendly does not mean that DMA is a=
ctually going to be used, so the patch that introduced those allocs might h=
ave regressed for this case:
- SMBus user from atomic/irq context
- SMBus emulated
- emulation triggering a GFP_KERNEL alloc
- the existing trylock in i2c_transfer succeeding
- driver not ending up doing DMA

Bailing out would break these users, always=2E Currently, I assume they ar=
e only broken when the alloc happens to need to do more than is allowed fro=
m the given context=2E Something which might or might not be common?

But as usual, I might be missing something=2E=2E=2E

Cheers,
Peter
