Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6BFECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 07:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E6B32083E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 07:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="F936x9qx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E6B32083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbeJSPxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 11:53:10 -0400
Received: from mail-co1nam03on0073.outbound.protection.outlook.com ([104.47.40.73]:62496
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726609AbeJSPxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 11:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xds/MlIiKFOFyCx2B3RNPrTtR3avuf+3113aEQm/CL0=;
 b=F936x9qxcN/50lQhLOg1A+JuHGbQwg5yEmKZMFjIw9kypfflL9Kc0s+cp1hWzWlkenHdceO+u880FzrU1oGJWUa2dxkgl9WzN8jCut9gaZSRd1aSyontrTMCvNp8SQFNCguzYIfxX94zvA8UQci+TMfOMXas0XfALgHf1kBWxko=
Received: from BN6PR03CA0086.namprd03.prod.outlook.com (2603:10b6:405:6f::24)
 by BN3PR0301MB1218.namprd03.prod.outlook.com (2a01:111:e400:403d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1228.32; Fri, 19 Oct
 2018 07:48:06 +0000
Received: from BY2FFO11FD011.protection.gbl (2a01:111:f400:7c0c::115) by
 BN6PR03CA0086.outlook.office365.com (2603:10b6:405:6f::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.22 via Frontend Transport; Fri, 19 Oct 2018 07:48:05 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BY2FFO11FD011.mail.protection.outlook.com (10.1.14.129) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1250.12
 via Frontend Transport; Fri, 19 Oct 2018 07:48:05 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w9J7m4EW019097
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 19 Oct 2018 00:48:04 -0700
Received: from linux.analog.com (10.50.1.118) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Fri, 19 Oct 2018
 03:48:03 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <Michael.Hennerich@analog.com>, <gregkh@linuxfoundation.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stefan.popa@analog.com>
Subject: [PATCH v2 3/3] dt-bindings: iio: adc: Add docs for ad7124
Date:   Fri, 19 Oct 2018 10:47:45 +0300
Message-ID: <1539935265-8904-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(396003)(376002)(2980300002)(438002)(189003)(199004)(356004)(6666004)(50466002)(478600001)(2870700001)(54906003)(36756003)(110136005)(316002)(1720100001)(5820100001)(72206003)(6306002)(966005)(4326008)(7696005)(486006)(106002)(47776003)(305945005)(5660300001)(23676004)(107886003)(126002)(476003)(2616005)(44832011)(2906002)(53416004)(8676002)(8936002)(77096007)(26005)(186003)(336012)(50226002)(106466001)(426003)(7636002)(7416002)(246002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR0301MB1218;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD011;1:usSfjzoLJXnykchLVmCmGdtGTHRAE2AaAh6est0hxPje+3SdZG4/sIURZMMSJHwFP1vKdfUY0xXlbbSPLcV3Oc6c1YXX7NFSUS/VFlpbVLExKge4+mKjV+s3xLPPjGM8
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9d4770e-3e2c-4400-6b39-08d635973464
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:BN3PR0301MB1218;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0301MB1218;3:cR5Sx3luL/STkZSoqy3sgwy7z69Pf5zDNxd8iJw6zcD3l4gJe5e+w+NcqXvBQPWe6Pv7+1z4Pu/ps8YT08EqYaXPyOQeX3c9Vcn46+eBOXufPsMFtyIFKUYqhV7I64go5ODAloGHNnM01qv23vd8cDQS0EG4m3ZFARsr2C2FyWcJy3Lj5xSk8ZT1MinwOoNxmTrf3keI4pt++NZTVh77PpxH6H+UJOzEHStV9EhSydZ/th8tZgpPxZ3/dhaKaIsz4vukdy2k3/XjW0b5EkWNd3Dy0A2HzD6XCxxc4F/V94n0/KLNIluGH7lt4wVeZB8xjnB0gi2TuTczE1OrX7vX/lPAN1IF86RYfbKS4dBYSDA=;25:Rzls3T2p9yCVPs95AU9Uk7ITBkfgmQmJ/pHfiOMEy8r/v8d21/KjeaWJw5i4Rk5bmH5D/CrwHEtnf4QYU5SCCFN7tuLzrYjqGupfr1mx9jm9PtEwpJ/bFTJ7AWwPvOZsaVSTYv4NIqqkPfIhVBpYuK3lSwdxzcfs8gr+VJ5joWZnauQtEgoQg8bvKbkgCwlBYgM2kCeDEyCxMZPQ+mCTTZSAfGv1fm+AtRQBF/TykuEFgzLlj+08drtOr4GlKS/WS8QGIiYOI6biC2AcxH5e+1yeID2Vxena8mL3ugi4j/qa6spSlbu+5Lv2Dan1h8VyAzCs6gzXqzf7tTeVeQuzgSQqI3ldUatUGXRVUGhxtNg=
X-MS-TrafficTypeDiagnostic: BN3PR0301MB1218:
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0301MB1218;31:2gRdO98zF6uy+BOTRnmrZicU/yq4nm0EALqgRv+PjEV05yBWpHzrp8pt1I302/cWcleUb+FyJRunNEjOtUj9UUPV9ejoV/74ThH0lP2QOg3+xw8ej2dwea2dHhTa26dPw0+oRtcuTr2E/oTkLRXPtT5KCreRoBXYBgzh8A1kY06BIy/5wyZvD4nmFnEQ0a+MD1Tj6Eg2rOOWnyKK0UuFfh3Lxasn1q0WIPFokL8eNIU=;20:S1LHzHROKv/3yZjaMNwCLz7Z9gaaRHnVhCOVtjw/ZdPYTRXDeRPaUvsaoMJgXreQB+xTypoCuVoKEozJe7I9F+8cN3TZvSgFG0qD6nDBKB0I4Nj2x13QhP8UPvx/3OU66kFoh9OiEbUj4SwgSRxj0nKkzoQjkmv0y0g84zsJbhJFrWowXOrw7f9ioW65iTTwfAFa7IoQlXac7+DgHkJjAMtPpioNpRsQzUaeMwmT2Dnd7en9cO1dKBV2H2h+Q4ho40VoFPzShFKKujGJXU45UrsUk0CCsfnMIZrVLQP+UW1L5SsVdl336KsuzggiIZH1HbBA7Gsg6OknDGXKf6YRD92jgHLNqlr9oCFFTjqvAl3mWULRch3nGOA946jHklYfQsTLnOWxoFaYF6tSzHs09FflZBCSPTSjkHcIVhY8YaoENJRI9VM3ogfWggijU3+kjdGRSYTySkybHq5H5cjffA5RURc8M3h4FjWz51Zbf4mDdta940737VDrwRIUgRsR
X-Microsoft-Antispam-PRVS: <BN3PR0301MB12182749C4D99B7D32B9E3199DF90@BN3PR0301MB1218.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674)(9452136761055)(170811661138872)(95692535739014);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93004095)(3002001)(3231355)(944501410)(4982022)(52105095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BN3PR0301MB1218;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0301MB1218;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0301MB1218;4:JoI5ddROUfLrxNmIYl/RhZ/4l5vbZHt58KFOPH9uOYTb9aR1F3m8BGRUXP9qq7W8751Ddn9fhaGvu8gQajJcolLEciDlqRpS3QR87pzciiV2A6k4jz/WkZ3YMjBi62CZDk1imw+ewGY/qHUtigWWIXlmEvMvif6kgebElg7QdAleJMQWjl3aF1kIvlM1ZGocPsdyHZ2Yb0XivlzycoyZ3bytwVkkdxbZzFxsLCQd8psdv/mY2fbN1+IKDLWqsEO+x2DGq9qFVmD2A9kwewyb7HjFFSgjsdbHynpytaY/eGwLGtnuKB0/8w7C0A3w2W3+nqh/MhGXl7Qc6aZLNn2euG7GsX+OAmxZmcm3an4AOYFG0WMGw13f5vUwZyvsyOUKUe5x/t16vn91tNlcJIoVHqK+z6Ga+jz4a8PccdTRpkE=
X-Forefront-PRVS: 0830866D19
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjNQUjAzMDFNQjEyMTg7MjM6UXRuWTlnTitHbituaWhWeFp6UEVqMkNS?=
 =?utf-8?B?M2VWVDl3N04yNGc3VThHSkFvVnhJMUZkWUJjTU56TE1xUFVIODJ0b0NmbkhP?=
 =?utf-8?B?OEJuL29zVTAzWGFmSVRZRzZ2Q0hsR3Q5UGZ2YlE4eVorN2swY1pBSkxkYlAr?=
 =?utf-8?B?Y0VIbkkrQm1Nc0VvZnhoWTR0MGltWS95NEpYQXRaZ0Y2ZnY3VzZqVFpWQVRI?=
 =?utf-8?B?eHJvZWtGQU5UQTFTSHUyK1YzREpJeVJneUZMYTlYVUZXUTFWVzdFQjkyU01y?=
 =?utf-8?B?d2F3eUpscy9YbUY2Wm5CMWpjeUw0R2t0UTdNVTBMSTZ2aWtQOHA4RFEzVnhk?=
 =?utf-8?B?Rjk5R0puVG9ValRRMWkwQTdsZElISEhJNm9jY3FGNENHUW9QRlM0Y1AvOWU5?=
 =?utf-8?B?SnZtWWxDdERKS2Y0UVpJTE1mZ044YjVXZmJFYXVpSFZXRTV5Q2Rabjdiek1N?=
 =?utf-8?B?Ly9xbXJuSnR5bzlhdDlpaW5zaUllL3BxY2l0N2c5N0ZtUEZkOVF1cnJuSHI5?=
 =?utf-8?B?YU1ZM1JnWFVZRmw4UGE1NTdhSU5BL1pGb2ZSd1hqcFgwamdtblAzTDNSRlMv?=
 =?utf-8?B?eEtHZC80RlQwQVg2cTJWb1lSZ3RmSHh3bkNRYWMyTXRqZ2JMVzM5NVFwQkJI?=
 =?utf-8?B?NjkyT1hOeTVCZFM0VlpmZjR5YWUwK0dNS2pSY095aXlhcmRYV1FmdnJDV1Zu?=
 =?utf-8?B?K3RTUlU5b3NOZUo5WmVrUEs0TFc2MjhwMzhnMC96dUF6TzVWdjgvbnVlVXNC?=
 =?utf-8?B?RTlqZ1g3MVZrMDhFdTRaamVuaDZETHdmNlFxYml5Q29LRG9uV2VaQXFzcTBL?=
 =?utf-8?B?MFdBL1prcHBQTnh1NHo4UGNsLzA2dTg3dkMvaThaQ3hSaVVBT21SQVNYQm9u?=
 =?utf-8?B?aVdkK0I4NUZJMUlQTWp1NTgyUEhSdFFzSTlLSjNwdzl5aG9KQWdDR0NIdlZJ?=
 =?utf-8?B?Y0dhbkU4WTFIN0RvbjBwbkI2cG5yZ3FYWFJZQzBUaEZMRzdPc2lkWW9DM0I4?=
 =?utf-8?B?SlllUFBjN0F3bGdiYXpYRmJpSTZyQWhOUGVGMjJxaDJEQzV3ZVF2d1NTNjNM?=
 =?utf-8?B?a29CNjNYOGk4YUtvU2Y4ZkwxeE9ZZk02RG93NzlORDdRY1Ewd0pMTU9YNVBQ?=
 =?utf-8?B?TFIrZldCbXk4RmNoc1dzVStsVEszcnFubVlFcExPZmZpcE56TnR4UHp3cmpM?=
 =?utf-8?B?N2N0c2s0OXdramNhcUNrOVVMQzFYczJSWUhteVFsRS9zTkhzckdVRUZLSGtT?=
 =?utf-8?B?aFg0Ny9CaGpjTGdyWS9GVVkrZGJ4R0QzWjIveVplcTh6SGNqYUFpak1BUG9L?=
 =?utf-8?B?YncyTlZMN3haVWhGOTJDSko4Wm1BcmdkVGFsMEtMZzhaRVRzM0ZKb3Z6M1VZ?=
 =?utf-8?B?NE9RMTFIb0MwdllEZTFTNHlubXozNldsZnFKbU9WTWh4SHQ0L1JNU09OSmtp?=
 =?utf-8?B?S0lKWUdnbkkzQ3pUZDNIeGgwNUQ4YUwxem10aW8xRGo2TjFuQXZCWjVFMjRz?=
 =?utf-8?Q?DiGzCBIthJrgtzCkC5EUqzjx9GY=3D?=
X-Microsoft-Antispam-Message-Info: wTqG2doFxJEYgcrzKE9rzINNMca43rVOYP2EbAV3RJw8dnWZyBWrf4EykEGAMpivUgemXOLYWPuUfAHtkkxDZZF2kgDd5c3sbEaR9mmvYOAu2zgxFkEc727VkxGV6ujwz4VvDMbgCCKGTRODEnomgoRDXiBfYVBwh//gmh9fa5jRakT8k+lVHPlNQsIdS0Z1N6vwgMHPnA8NORc8BcN9w2lVJyD/PDEeq23y5YftZtzJtAZGuSgaHsD+b2JoGXCQuWpJF3eLAbZaDVcmRigopPKPOLoY2fIET/mgdkVO4oVQhHpuqwaWhbZnaDew5RTPdt9dHALwCz9kUkLiDdxYAFiRFzmWdF3rC3TIyKDS76U=
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0301MB1218;6:yjtpZ9rLDgyQWH3NSeF9M4VE6DMBnghwfrLzepE7W7uVSwGqXTWSlrW6pc1CYnnHvh6xLu35iWSW6msPyi0JMlSsXlVQ9o8tlcsldf+5QqmuWIv5zMc7dud2B0JXg1AU7maaIEdAMVOiHue5J0IR3SLjExxCC5Pdd1TpBsM2CVnqEdoo1RTj2P/nbkwHEOTG5aAIMgFzeN9BRIg7wAKwH0i4HxWg5CG3URQO6dkgpAfyXr2chsChSbZbFiloWAIPNtx+au8xaDm6D7SFmJx+mboGaDJtmRewk/xBJISaQ9Ax9M4R6LB2vyEOwBO6UXb8NPCaMNID4JAa7yWutslQvKLDJD/9fAvfAaLtNgVSlsE4jyr1ZwSqXPaiY2Q6lmlpHBJec4KVuINBG67O2Q8nR4SeWFW0Dn/2Q4I6e1iWD3DDklw4kDf9VjKlj3X2MFFHlfSxrGRnQhKuihAYccF64A==;5:N/O2xJmYXOCyJX94upd4p9p5/eoCo/lYg/cRlGklGB0TGTin6705sBQYwq13mUcGCGKiOnNFd7fEaOSTzXjKJr5ZAakuv1jZO4HP3k+KXy+x0MkwcZ76s4C0udJEEq8ubheAVFsscorGsCtc0UreKjIIzk2MaCVR1JA01bZa6Aw=;7:hjM6cq+gD92Ger+fNHtHFYtAx7QIqPNcgu5V10Ly/N/Xw09svShOmjc7tHmAv/ae1bVEa6d/bubLhdT4fnGzZo580nEtylXcaFDAYp2Ac5+GNtptlPq09qXBbJNRtJrcVWrdvukO9ocNC5QefQ2HcTxw2xAuC6hKzw8EudOtCrZ45abYHg5OToHn30Hz1P2xOK1YQ80KXGtawo9PnUc59VE9dYWap2xa45R8GkdRnuZYO7/CWx1Pm++wsQtRYoHN
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2018 07:48:05.1864
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9d4770e-3e2c-4400-6b39-08d635973464
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0301MB1218
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Analog Devices AD7124 4-channels and 8-channels ADC.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes in v2:
	- Nothing changed.

 .../devicetree/bindings/iio/adc/adi,ad7124.txt     | 96 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 97 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt
new file mode 100644
index 0000000..77a7b92
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt
@@ -0,0 +1,96 @@
+Analog Devices AD7124 ADC device driver
+
+Required properties for the AD7124:
+	- compatible: Must be one of "adi,ad7124-4" or "adi,ad7124-8"
+	- reg: SPI chip select number for the device
+	- spi-max-frequency: Max SPI frequency to use
+		see: Documentation/devicetree/bindings/spi/spi-bus.txt
+	- clocks: phandle to the master clock (mclk)
+		see: Documentation/devicetree/bindings/clock/clock-bindings.txt
+	- clock-names: Must be "mclk".
+	- interrupts: IRQ line for the ADC
+		see: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
+
+	- adi,channels: List of external channels connected to the ADC:
+	  Required properties:
+		* #address-cells: Must be 2.
+		* #size-cells: Must be 0.
+
+	  The child nodes of this node represent the external channels which are
+	  connected to the ADC.
+
+	  Each child node represents one channel and has the following
+	  properties:
+		Required properties:
+			* reg: Pins the channel is connected to. The first value specifies
+			  the positive input pin, the second value the negative input pin.
+			* adi,channel-number: It can have up to 4 channels on ad7124-4 and
+			  8 channels on ad7124-8, numbered from 0 to 15.
+
+		Optional properties:
+			* adi,bipolar: If set the channel is used in bipolar mode.
+			* adi,reference-select: Select the reference source to use when
+			  converting on the the specific channel. Valid values are:
+			  0: REFIN1(+)/REFIN1(−).
+			  1: REFIN2(+)/REFIN2(−).
+			  3: AVDD
+			  If this field is left empty, internal reference is selected.
+			* adi,gain: Select the gain when converting on the specific channel.
+			  Valid values are: 1, 2, 4, 8, 16, 32, 64, 128.
+			  If this field is left empty, gain of 1 is selected.
+			* adi,odr-hz: The output data rate can be programmed from:
+			  9 to 19200 for full power mode (when the master clock is 614.4 kHz)
+			  2 to 4800 for mid power mode (when the master clock is 153.6 kHz)
+			  1 to 2400 for low power mode (when the master clock is 76.8 kHz)
+			  If this field is left empty, odr of 9 is selected.
+
+Optional properties:
+	- refin1-supply: refin1 supply can be used as reference for conversion.
+	- refin2-supply: refin2 supply can be used as reference for conversion.
+	- avdd-supply: avdd supply can be used as reference for conversion.
+
+Example:
+	adc@0 {
+		compatible = "adi,ad7124-4";
+		reg = <0>;
+		spi-max-frequency = <5000000>;
+		interrupts = <25 2>;
+		interrupt-parent = <&gpio>;
+		refin1-supply = <&adc_vref>;
+		clocks = <&ad7124_mclk>;
+		clock-names = "mclk";
+
+		adi,channels {
+			#address-cells = <2>;
+			#size-cells = <0>;
+
+			channel@0 {
+				reg = <0 1>;
+				adi,channel-number = <0>;
+				adi,reference-select = <0>;
+				adi,gain = <2>;
+				adi,odr-hz = <10>;
+			};
+
+			channel@1 {
+				reg = <2 3>;
+				adi,bipolar;
+				adi,channel-number = <1>;
+				adi,reference-select = <0>;
+				adi,gain = <4>;
+				adi,odr-hz = <50>;
+			};
+
+			channel@2 {
+				reg = <4 5>;
+				adi,channel-number = <2>;
+				adi,gain = <128>;
+				adi,odr-hz = <19200>;
+			};
+
+			channel@3 {
+				reg = <6 7>;
+				adi,channel-number = <3>;
+			};
+		};
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 3a1bfcb..f2fa508 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -845,6 +845,7 @@ L:	linux-iio@vger.kernel.org
 W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
 F:	drivers/iio/adc/ad7124.c
+F:	Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt
 
 ANALOG DEVICES INC AD9389B DRIVER
 M:	Hans Verkuil <hans.verkuil@cisco.com>
-- 
2.7.4

