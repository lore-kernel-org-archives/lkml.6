Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE16C43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 21:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B99924D3A
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 21:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="ghP0GiQU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B99924D3A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751949AbeFWVkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 17:40:52 -0400
Received: from mail-he1eur01on0119.outbound.protection.outlook.com ([104.47.0.119]:35203
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751838AbeFWVks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 17:40:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUcRub+xRx0y2h8aKmvnLmppsD0mOhuDcKwITxeXcBk=;
 b=ghP0GiQUE3HS4nB289EgB2BUS3w3fr9UiacWsHQ7xCgEnTkQPNuZzOHXHmDiHyQeDHRAL3ihaJ2niXobMOX/ascIhLnd3kNoQmmzFyikILJc8y+JQxgpkMhcIDwkAFIv9bKuyXR7oeZy4WTc9ravJ1Yk3SM4r5ETKTiBEIExGDA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from [192.168.13.3] (85.226.244.23) by
 AM5PR0201MB2449.eurprd02.prod.outlook.com (2603:10a6:203:34::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.884.21; Sat, 23 Jun
 2018 21:40:41 +0000
Subject: Re: [PATCH v5 01/10] i3c: Add core I3C infrastructure
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        linux-gpio@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>
References: <20180622104930.32050-1-boris.brezillon@bootlin.com>
 <20180622104930.32050-2-boris.brezillon@bootlin.com>
 <ed1add9b-ba21-d3d3-64c4-44d18af3d133@axentia.se>
 <20180623121705.1d618c5d@bbrezillon>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <d6e37e99-d0d1-bd59-c1be-f462d3086a40@axentia.se>
Date:   Sat, 23 Jun 2018 23:40:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180623121705.1d618c5d@bbrezillon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0402CA0050.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::39) To AM5PR0201MB2449.eurprd02.prod.outlook.com
 (2603:10a6:203:34::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4856e6c9-ccc8-43f2-67b5-08d5d951f8e7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0201MB2449;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2449;3:uNEtmHlV0aA9G5UYuN6BKYChe0oVOCBIt+2Xx86Vm+aKospq7gkui5GwH906KpxCznB23H6pJtVnlrwqny6lVpaAWeEzbkPuxr1jeGEan4cE077zSssmKZBtcYUG/jmwpEt5XNtXst6gWz/zS23y0MYOga2UmiVcYqhdfoq76V0VXONwr8bLj/AtqHP37vOS/ayTmbL0KgfuiQ8KNF7B8zD6YgFR8APjhLxdJU8vJtiM398svD7qmg+zd+nKNuBv;25:0tKHDHwpiWJBgbCvIrrVynqMAc4UzaiWbsx92tQfZiptvxcFKzZWTZcc5FUrLDAcLnY+4Wb86lm07WTLedEwFIjFtYvLZvSjahXbtMb8oSlUiiNMusJjw3RbEolwbLY+tU0pHoyWX3YvPVntt8t5MMoVZiDqMXc8FeGtdnd35QlM1Oh2EGSTj5sWWqY9XsNMP1kl/uDaPGSaTurM1NN13RedHjiZwLvMP+KymnSAJNoJpZw8Z4E0Cxkb8KGD0JPnFO9dNHhzjqlpRuCLumOiY+jweolZ2R3r43YmOv4pq/hG6aRsSUncdKYDP3h0pqbMZ2zOI/DZ+HecDH2sk6GFfw==;31:cqhvb9H3qDzW/jilk2A2ltclIyy0rT3MA9Gkg5n+ZtNZFskuKkI8bcinc0J43Q98iuF8Kp/CmVabuC1zeauyddRgM/aiqCxhXOiRG/hioyKZOvKYVGXTQimnArfy6csqLq0iMC3W35fTqlkW3sgDt7oQYCEMuFRTUcJ+0a1jfDGiv4KwkDbjGbzjw/dwg2Yh+aeD40i7iNh97NQm59utTPUAy034lbCezswkcfga4vY=
X-MS-TrafficTypeDiagnostic: AM5PR0201MB2449:
X-Microsoft-Antispam-PRVS: <AM5PR0201MB2449B8BFA63686882FD896A4BC740@AM5PR0201MB2449.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(35073007944872);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(2016111802025)(6043046)(6072148)(201708071742011)(7699016);SRVR:AM5PR0201MB2449;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0201MB2449;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2449;4:jf5ghoSa6bTVQsS7SivrlPV1Y6NVHTwzlNBZILFosszA9dwpiMnWbHoQHg7nnamQ42EhTGz8g1yQQZsZqk89e0vLJz4ua+kxnENWEdmYSIN5zsQVs4OWbsUEK64pfMMQ0CX56a21406dj62KbXZGmmbLKzMEC43BdNHN8cdRD/cwX+ZuibdryGU7Wt2sFexvFvdwp7BFR/MCRDdCcFi9U0n2ARWkQ0VuzeQTi2/FSfC1TYmSab2SVk9wHXf+t9rJomzqczhE+3jhjIuXD12mLFqYWqG3nWp6i17kpFxtp1PJ/wIudYx1IT72AvOS4Tou
X-Forefront-PRVS: 07126E493C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(39830400003)(396003)(366004)(346002)(39380400002)(52314003)(189003)(199004)(16576012)(97736004)(316002)(117156002)(105586002)(2906002)(7416002)(50466002)(25786009)(3260700006)(58126008)(7406005)(54906003)(478600001)(64126003)(86362001)(230700001)(8676002)(81156014)(3846002)(6116002)(106356001)(81166006)(8936002)(31696002)(36756003)(7736002)(305945005)(93886005)(65806001)(26005)(66066001)(74482002)(65956001)(77096007)(186003)(31686004)(16526019)(65826007)(486006)(59450400001)(386003)(53936002)(53546011)(229853002)(446003)(2616005)(956004)(6916009)(476003)(11346002)(68736007)(52146003)(36916002)(6666003)(5660300001)(6246003)(23676004)(2486003)(52116002)(4326008)(76176011)(6486002)(47776003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0201MB2449;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjAyMDFNQjI0NDk7MjM6aS9qR0VWNy9QZS9lQjc4M0psVXM5NjBi?=
 =?utf-8?B?ZVpzL0V5UWVsNlgySFFHUGVpd25CYUlMYmdqUStTQUdoZGtNS0pSWnBsSk44?=
 =?utf-8?B?eERldHdwT2hZbXdwRWdteEJMM2ZoUUlndVJFZ3FCZ0YraWNtUDBSRDBEbWRw?=
 =?utf-8?B?RmcwYlRTWmVYWVNNblpmZkNNQ244dm5CT3M0QjNvQmcxWmJEQVBQeU9JZG5y?=
 =?utf-8?B?YVZNS2Foc240L2dyeUw0T3d4YzZoR1BDVUVjYVFTcE9MRUVVckczMUl2cmg3?=
 =?utf-8?B?ZFRsbTY2Nmx3dnpXOVQ1RFc0NmxScUtsZTE3TjVNM3dHcHBJM2tIWitWMWVB?=
 =?utf-8?B?WDcwbEhKL2F1YUo3M0EvL2VsS1BCaHZZZWR4U2crdTU1SFBCZFMwVi9BK1ZQ?=
 =?utf-8?B?SEVtbHE3bml6UDZkUVlQNmFJNXZwbVYyYUkzaStqL1BBNzBKeTVVNmdERVJH?=
 =?utf-8?B?ditCUFlDbXR1b25Qek1hUVYrdTJoVFFnSkppVE1ydXZuY0VNOU9zUVpVM2FG?=
 =?utf-8?B?SkhpelRXaVJZSEV1TG5LMGhoVXVkaFBsT0RPb3p5VGp3RDdCMWZvUzg1ak04?=
 =?utf-8?B?NjBEZEZNcStFbXM3VkxwN21PdHV5RjJlTW5vbFhjU2dQa2dJcjZtejh3eHV2?=
 =?utf-8?B?YXRWcWNia1Jza1VVclNTcWdvVDNTaEZId0F3NGxINXlUQ1hzbFdqejdEYlVI?=
 =?utf-8?B?V3hPaUl5MEZSRmY0WmVhNVdobDFScGdFbkpYUjBjU3RncytGdjFoVno5VFVJ?=
 =?utf-8?B?ZkwwRTd2cGl2czBOSlhvZmJFQmZ0SENyalhrWDRXTC9LYXliZXRSeGhIWnlO?=
 =?utf-8?B?Y3BNSUR3K2RuUDZYbFErYmJBbTJ6alZ3Y0xiL3laSFlteHhUc3RqQjNNVjNX?=
 =?utf-8?B?MmRQU0hlbER2bklBVDJJSjdCS2lscWd1bFRHZVNUWEREeXU2Tm5YV1lBcVV5?=
 =?utf-8?B?NjlaTHZ3WUVsTGE1TjdZUVpoU05iQWRvNGpJcEs1dE5sYjhkVC9PbGlTWHhT?=
 =?utf-8?B?QldxQ3BBV0xRRmpVeFdyUEhOOXV4R0Q0TnIxNmZMcFRuc1p3cERWVUF1MWJV?=
 =?utf-8?B?ZjZWdUhrM3VlZ0J0ZWlzdXFzeEQrbUUzNi9jdCtxRXN1YXZmem9YeDNUY2VY?=
 =?utf-8?B?YXkwNk5mWHF4SkdRSFluNlJjNElrZjhBb2cxSGo3QUlHNFRoZkE4ZzQ3MGFX?=
 =?utf-8?B?ajUyditpY2VyZk5wN3cxVmx4Q0FSU3JobjZwWHFnN0xRRUdqUndOeU11ODQ3?=
 =?utf-8?B?djg5MmpQVjViT0lhRzVnb1o4dnl4cFZmaEpNSi9GYU00dXFCc3JKUitPZDZy?=
 =?utf-8?B?TUJmUnBkNTkzb2VYUDBvbHZNdDF5TGxTU3FmL3FXeVFDNWVCZ3NRbm9EK2Jt?=
 =?utf-8?B?MlpCNTBmRmhGck1jS3FHQ0Jma2pTZmxPVWJPOXo5MEVWZy8xQ1hkQUNIMGRF?=
 =?utf-8?B?NnNRdEM4anAvWGVrc3AyYjlZNVlrUS9aRWZTd0Nsak1EZ05Rc0NOK2JvTjJU?=
 =?utf-8?B?aEl3bHBLZnJqMXp2NllyeVg3TEdVKzFveTE0bDVJZnZreGZsSUhpbVhRdVNt?=
 =?utf-8?B?OEFqNnFCcFIrUC8yS2RyTkkrd1EvWDB5MWtKbnpzKy9od1NneWR6V3grOGZ3?=
 =?utf-8?B?eGdENDlBa3YwTDNBZTRYa1ZhVGJ3dVNIY1hHaWlHLzAvUGxRRDNUbWNmT0NK?=
 =?utf-8?B?L0huZWxEbW1JMWJsT3BGc1hKMHY1alR6dlgxbVNyNzRQR3NYQ0E2Z1h4ZHVh?=
 =?utf-8?B?clZEMUJRWGxNV1ZoUGxjT2EyZmxva3hnQVRCODdpVHJlTEQwZUtmUkhibS94?=
 =?utf-8?B?Rmg1emtDWW5Zb2RVbGNiSXhsencwR3cvOTlBVUZpSzlycThhb0xleVJhcmhl?=
 =?utf-8?B?ajhLSTN2M3NqS0k1cnVjbmJMOGZjdGsrTGRGNzZpRjczVE01and1WVRON1RY?=
 =?utf-8?B?ZFRHWXgyeE1GSjdEVzZPWVYvbmNIcit5aE9DcXpQeFptaGFINGowOU9TRkVY?=
 =?utf-8?B?cFhLcTdmb2ZJb3o3M1MwVWExT2k1OHMwVEl3NkhCc0Y3cDZCMVJvSHFTUENU?=
 =?utf-8?B?akZjQ09jV3dEWlJpaGFHb3YxNzA2Q1FlNGFjL1l3UHU3QVdoSjZseU85NjNC?=
 =?utf-8?B?TmdXOFNXQWRuZ1R2RXI0U0MzVE1FenZIZWFubHl6eDFlTU1NWlk2NVBtWDlU?=
 =?utf-8?B?Q3p5cVFtVy9nM0N4MEpORFZHeDU3N2MvTFh4UGVzcWVsQmx0TGdreHpUZllt?=
 =?utf-8?Q?mhsFq1fsfXi55WkJE6+F?=
X-Microsoft-Antispam-Message-Info: esJMALyahThqaKvdCSmUIEcHMIlgUkN1B1Zykz45puHyfa1DdkZ6yWgbZA9CNSzu40O5bsI6e+sdmmbufqpMso/iMZbu6IJVf/JuLgQeII/x8gy0WLD8xbfO5fFh+k1mwQmIakCEGS6VBV5+hZRAlrJ3idzRL41vmycCaQ4xrhqFYXQDBF+Sf8Ntx5HJts6eniaMkWUsYqae+JhTfqMeUoXBMHs3/7V9PoPsFHUTza2UOryb3lqWIVmPnKzrUNUsRO/yffZlwaU4h1IMIeJZ6cW9F0E7Hlw265k7bw3UijD0KmBQcgrJVGFsyKYOzzrYCgqt6oUwwZDuW9qSpkcquuYgbC5g/7wEm/mUMjNoTlo=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2449;6:DJh7semr4mtA6QN259rj2QkcWbadWjWd/E1tCGUUFn7rLVuEqDv7LC8vIcUCkpAY4XilEIMS7N/1TEGb32csJUjgE8pFf2ibW2WAkJadd4KkSfvyjh/OM3y6FKl219k+mVqnTpzd8u30Hmo0wnFAmk+hRIebNQgR8Z4MZsHou4YrFI/Awtb2JKyUfO4kh4Dvfg3SsdZ4d/UPssVJKWRHpEU6v+jVKxToMu/ZzRofyQm0neMGwrk5ew7L2gchNUYmDGJRs6XVcRh3tFR/ityDFdkpOn9B9PWNUV8wRPGky+pCeuDGsLCIrK9dauea3JLK3SILBta6/Pfwm3c9s53tvC9xQ6DH47JLJH3TxrN+3u4mjo3Bc/cKt4v+BLBjzQzXD/0Mc5jl/1ZZQeokHWfiaar38apuTYJRiWECk81/PYYGEjopp64SaQf7CKw75za5cC0FS3cj6SOvFPXiw1l6sQ==;5:YPuO1TRWGgg6bZALv0Ujdn+EUOtNZNkYkx7OP9EoOnNnU3YVSr7jnGzUFNK3NSmMHB2Mczsb3xy6/XgzUlGuuGP9/VRWmG4v5O2kS69XcOGT5E6ArWPVtAdUANuMmLL3NfyBz2+lRwqqD1m/pDvsAJqbZLYw+vLs7Awi1a28cIQ=;24:dDNO8UluHRW3wIEVQthDdLbNJmgt+JhCUvUkJtma/yBngXCf6F31YrdkzCadFhLlpDmiVtVD9VN9npr3FrDO/FZrFLUFM3Ek2lyUpZwN6k8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2449;7:UqQtijrsyhkVBOIYryvVHGfJcbbVMVEi7pwdaqN78YCjrDB0ZhtOfSmYjtnhrH33W5kL1Q1m6RhTmWvr/FqiN18fyeBZ+sgU1CkLshOybUQiJyJ0vBq7p4goiOloBAjY1g7VtZc1wIxrMrLd+tUn0/LekGNa9ljHw0DxvCz7VDyp1TupIby9WJOHj945qAAc/Q0PwjIfSFaeoRsMh3QLzko3CrjCAC5LAHX10/dnFbCDPi7yb4vbziN3dBkSKlI2
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2018 21:40:41.4409 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4856e6c9-ccc8-43f2-67b5-08d5d951f8e7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0201MB2449
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-23 12:17, Boris Brezillon wrote:
> Hi Peter,
> 
> On Fri, 22 Jun 2018 23:35:34 +0200
> Peter Rosin <peda@axentia.se> wrote:
> 
>> On 2018-06-22 12:49, Boris Brezillon wrote:
>>> Add core infrastructure to support I3C in Linux and document it.
>>>
>>> This infrastructure is not complete yet and will be extended over
>>> time.
>>>
>>> There are a few design choices that are worth mentioning because they
>>> impact the way I3C device drivers can interact with their devices:
>>>
>>> - all functions used to send I3C/I2C frames must be called in
>>>   non-atomic context. Mainly done this way to ease implementation, but
>>>   this is still open to discussion. Please let me know if you think
>>>   it's worth considering an asynchronous model here
>>> - the bus element is a separate object and is not implicitly described
>>>   by the master (as done in I2C). The reason is that I want to be able
>>>   to handle multiple master connected to the same bus and visible to
>>>   Linux.
>>>   In this situation, we should only have one instance of the device and
>>>   not one per master, and sharing the bus object would be part of the
>>>   solution to gracefully handle this case.
>>>   I'm not sure we will ever need to deal with multiple masters
>>>   controlling the same bus and exposed under Linux, but separating the
>>>   bus and master concept is pretty easy, hence the decision to do it
>>>   like that.
>>>   The other benefit of separating the bus and master concepts is that
>>>   master devices appear under the bus directory in sysfs.  
>>
>> Are bus multiplexers relevant to I3C?
> 
> Not yet, but who knows.
> 
>> The locking needed for handling
>> muxes for I2C is, well, convoluted...
> 
> Do you remember what was the problem?
> 
> Anyway, I'd really like to have basic support upstreamed before we
> start considering advanced use cases that do not exist yet. Don't get
> me wrong, I'm not against having the multiplexer/locking discussion,
> but it should not block inclusion of the I3C subsystem.

I'm trying to avoid the unfortunate situation in I2C where there
are two slightly incompatible locking schemes for muxes. There's
probably nothing to worry about until the first I3C mux is added
though. But since I2C devices are supposedly compatible with I3C
that might be the case from day one?

---

If I read your code right, I3C client drivers will typically call
i3c_device_do_priv_xfer (instead of i2c_transfer/i2c_smbus_xfer)
and i3c_device_do_prov_xfer will grab the i3c_bus_normaluse_lock
during the transfer. This seems equivalent to normal use in
I2C with i2c_transfer/i2c_smbus_xfer.

When muxes are thrown into the mix, you find yourself needing to
do more than the "real" transfer with some lock held. In I2C there
is an unlocked __i2c_transfer, and locking/unlocking is exposed.
Muxes typically grab the lock, set the mux in the appropriate
position, do an unlocked __i2c_transfer, optionally sets the mux
in some default position and then lets go of the lock. See e.g.
i2c/muxes/i2c-mux-pca954x.c

However, that is the simple case. There are also muxes that are
controlled with GPIO pins, and that gets hairy if the GPIO pins
are controlled from the same I2C bus that is muxed. The GPIO
driver would have to know that some GPIO pins need to use unlocked
I2C transfers for that to work with the above locking scheme. And
no GPIO driver does not want to know about that at all. I.e. you
have two fundamentally different requirement depending on if the
GPIO pins controlling the mux are controlled using the muxed bus
or if the pins are controlled in some completely unrelated way.
The latter case is probably the normal case, with the GPIO mux
controlled directly from some SoC pins. In the latter case you
also want to prevent any transfer on the bus while the GPIO pins
for the mux are changing, i.e. the total opposite of the former
case. It gets really really hairy if you have multiple levels
of muxes...

There are a some old drivers (e.g. i2c/busses/i2c-amd756-s4882.c)
that handles this by simply bypassing the GPIO subsystem, but
that is not really an option if some pins are used to mux the
I2C bus while some pins are used for other things.

I don't know if this affects I3C before muxes are added, but I
suspect muxes will happen sooner rather than later, since the
spec mentions that the bus only support 11 devices maximum. 11
don't seem like a lot, and it seems likely that there will be
a need to have more devices somehow...

But just maybe, in order to not run into the above situation, it
needs to be handled right from the start with preparatory and
cleanup stages of each transfers, or something?

Cheers,
Peter
