Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DD5C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA6562077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="Ws/C7tPT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA6562077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbeIEMNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 08:13:14 -0400
Received: from mail-he1eur01on0067.outbound.protection.outlook.com ([104.47.0.67]:29216
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726401AbeIEMNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 08:13:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9U/tGeXgj8JdGj1NshzJBFKnz5G3BkLDgsSpkm5Y3k=;
 b=Ws/C7tPTAJvAZm2HIoJiUKIQzh45j4r978pgXkLgN7op9MlmGyhl05Gw/CyGui+aOjWGCqK7GP182BSLoNs1UPtiklCLTq95mzKmVa/6mtXZqa+OkvaKPrAmxGryXNVUnjXg9uwEs0ShFOhy7VIMKwjld7VY+aZk+qFx5mn97pQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
Received: from [10.1.8.111] (89.24.100.190) by
 DB7PR04MB4667.eurprd04.prod.outlook.com (2603:10a6:5:37::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.17; Wed, 5 Sep 2018 07:44:07 +0000
Subject: Re: [PATCH] leds: leds-gpio: Add a condition check for active low
 leds.
To:     Song Qiang <songqiang1304521@gmail.com>, jacek.anaszewski@gmail.com
Cc:     pavel@ucw.cz, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Song Qiang <songqiang.1304521@gmail.com>
References: <20180905023436.11826-1-songqiang.1304521@gmail.com>
From:   =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Message-ID: <13a8d001-a44a-51a0-146b-ba5aa3f6e621@ysoft.com>
Date:   Wed, 5 Sep 2018 09:44:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180905023436.11826-1-songqiang.1304521@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [89.24.100.190]
X-ClientProxiedBy: AM5PR0402CA0007.eurprd04.prod.outlook.com
 (2603:10a6:203:90::17) To DB7PR04MB4667.eurprd04.prod.outlook.com
 (2603:10a6:5:37::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6a37291-4eec-463b-bb84-08d613035c9a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4667;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4667;3:gBG9YTdWLcFZZl+qexQ+mZJVNipiC5poDD5PzZ1GxBuoxjrjc3Z8FZgYcjx5NcpGAj8dy6Sy4pl6uhOdUFcmLtdVuxeLGJsgNTtUO4kmR/b0yCwsBf4oXaIDTMDvNoeCK6XM1vs6ajZNE0D3ib109IlMVT04Sk+Exf02FHofDczoV+Xxa0uKa66EsokRpHzp+ACdWsrpHN3dk7Pr+dQkTtm0OutQPHXDdMEHJphVwyREF9oljmtUBsgWMAuCI+IN;25:T2HT7RY5YghAqQP7sDNO4gs4yttSpb7Osxf9anfvhwvsZ4XqK6VTmq+8+Mvkh9PfMWyNorDjkf971AJIVD1iqKr/KfTvoa8z18eg3A12uf+J+jWNJeJ9P0xmHF3PHfQK/FDP0pLFZTaCrrJOMs44DXtFLsQxMgfFLRq+VwI4v3DnbrgOnBxvQ7I3Z3A00GGBUN9kW4dkQoBC1TeSXn2Z+AsrcVpjeFc29QeErKQ1LYVMVKUgr4KNnuXOckURMVDLO32i/fpXikUdyvAhSTU9+NLR1sYC91ia6NlOLwp2lrmXKAyweaEIq456W+287Yw9SNmqevKwMnJ2X13edSs41Q==;31:NORIAlWSOMF8jVgoGsMwS2ArAjZmNequnyiVkRmTGDfFgWu2oOTD+9TU1J62W46UVwnLwfttRv6yGrXqCTeJ6k8eYdANUG+VKDvk1sjBKV204+PsBrvvQ5ywzHL5S0n22xmCa8ML/eSEg3Qbof20SsRBD7IlhkgD32raH4VtlIG5qhL6XirAO3qi1hycWjYtS2xFlYoK4J8zVpgkBI+jBdzfV00Lv6i8BmYAnawAowM=
X-MS-TrafficTypeDiagnostic: DB7PR04MB4667:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4667;20:IVaaCik+aB4R/zjzAI7rO3GK7IPDNHgYgN6V3ZiJLQ7pJLRXJhSBLOt1+z6uskRvE4wBGtE3dYlzcOzvlpbqGvbTsZVKIJ6cw5vRYDDMJipG8Qg8k7mSxVxL0GghcBeH+TwMIJfeaR5NbOVBFDtrC8m089IJ89UW6jGqDuNzBrHTTUiZFlnYTI8tJSbSrCuOisIDIgAbOXtv6Kpf1yuxCyMwV/O5e9ldtJxyNLSvB3l+0LXo2P7N+c6iUIOuAoVv;4:hRmKR+AZHfTFeLWlZZJYkXk6mpg/+9krJPG/fwChguq5son4dkJCwZDSsfGAXO3QxSPbWQkr/y0IauFLIrvxPQcYqOliJ1DFNgJ4fDYm04DLrNTXQ3TCRwmM7vrwLVeVQBL2mRUODfyjCYVq1JdApwtm34lkIGglTFX449+yi6CY1kaLNrTAmHCV3hh0MrIJIsOwbHRm1vldbZ8WsQorhQ3b8DcKfiK7odIgvxuQFT8jXAmf1WZw/CAnmO+bsrqAMzXY3y5PffemssKIpjQ2U1LgryyierJ2H9K03M9chTJ8JK17OgRmRgtZoorvqOz8
X-Microsoft-Antispam-PRVS: <DB7PR04MB4667BF26347477F4C22768DC9E020@DB7PR04MB4667.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699016);SRVR:DB7PR04MB4667;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4667;
X-Forefront-PRVS: 078693968A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(346002)(136003)(396003)(39850400004)(376002)(199004)(189003)(5660300001)(65956001)(3846002)(52146003)(2486003)(31686004)(52116002)(23676004)(65826007)(53546011)(386003)(50466002)(8676002)(4326008)(6666003)(106356001)(186003)(16526019)(58126008)(77096007)(76176011)(6246003)(486006)(476003)(67846002)(26005)(11346002)(105586002)(6116002)(230700001)(446003)(53936002)(956004)(2616005)(305945005)(6486002)(68736007)(7736002)(316002)(25786009)(85182001)(575784001)(86362001)(8936002)(39060400002)(65806001)(31696002)(478600001)(64126003)(97736004)(81166006)(229853002)(66066001)(81156014)(2906002)(47776003)(72206003)(16576012)(36756003)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4667;H:[10.1.8.111];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjdQUjA0TUI0NjY3OzIzOmY2azdnOG53dlBDMU8yU3ViZFd4czJ5NjFX?=
 =?utf-8?B?ZStlWUUxV2h3ck1SR0xMWCsyT2Y2aFB4N3p0RHVGS3BLWmw3WjdUU0ptMmcw?=
 =?utf-8?B?REZLem1ZREhWdWcxMnJrVUJvdFdldjlCT09tK2pxR0pCMVo1K1FlM0hndldZ?=
 =?utf-8?B?ekdSS2d6bDA1UWMyTWlQMUZ3MTVwZ0ZFNVN0Z20zWlc3VUxmNUVVdjh2Q09T?=
 =?utf-8?B?eWxvWTdUdENua3hLR3NaWFpneUR1T2RFTVhlWHRCYzBPRmpwMTZMWlJzQkhz?=
 =?utf-8?B?dUVQNmdMQXVPaEk2dFB0aHZaUWhCdzNJTmw3anloRzltTHppTENwdzRsa2cr?=
 =?utf-8?B?ZTE4Q1N3Wkg4eUZtWjdYTzBITUVTa25qMXpKdXBtVGdNM3BBaElNU2puL2Yy?=
 =?utf-8?B?RnFLaktoTlhYaHQ5WkM0ZGtoRUVBYUltSDUzRkhXSXBCU0xscTNYTTBCMk91?=
 =?utf-8?B?UlNFKzRjNDB5a3FXRUladDBFd0JLUzVGQmpRUFVZNjl3bmN2MHZVVnR5ejl0?=
 =?utf-8?B?SDlTc3UxZDBZK2hkQnZ3bzgxME1CSzBkcXU4UVAwaXRaRDFNcmZPVGVNTUUr?=
 =?utf-8?B?R09aa3p0TWRpcmhCMlRhblVJTm5zZFc1ZmUvaUFDWEU1WHo2M1VVeldtanhK?=
 =?utf-8?B?c28rRjdrT2szUElvN3dSTFBzaU56M0NCMVBhcXJQYjlUREdmUmNlRXlDcHkz?=
 =?utf-8?B?ZWwxRHBxdUNHSDN0cWp3V3RwNmVpbWI1VU1tWFNwN2oxUkRNQ2FqM3pacTFy?=
 =?utf-8?B?RkFaelo0bEszc0dZV3ZreWRJK2xSZWhKM1dxZkNUSm5zTTBOQ1padXRoYXV0?=
 =?utf-8?B?YlBsei9SQjZtNnM2QS8xVjA4UE5vUFB2R2hFNDhQcnZhUGZSV3BSOEhCTXV1?=
 =?utf-8?B?TGJ6S0Q0N2lEVzBnOGZxcTU0WTJZdUpwQ0ZxczlncEEyMkRPckFkWS9BTnFU?=
 =?utf-8?B?NzFONzd2UHdNWkVuS3lHSGl3bk1teDRFV0xvWUsvUXl5K1pZYTRDVVFBaVEw?=
 =?utf-8?B?bXlhRHhkSVRHUXFmbHYvNGxrY3Z1RFpOcy9XelRSdFBCcEcvSk9lSkZtSTdp?=
 =?utf-8?B?UUREbS8zeVFYRGtvUjNsSHRUSWhHTHJpOUp5amFZY2FxZFBHdnRnNVZPcEty?=
 =?utf-8?B?aDBUaFppenQwRllRMGpqZE5IcGc5TGFpNmxqRldRMWZ4VUdJdytwcGdycG14?=
 =?utf-8?B?djluazZpd0dJMmVrT3BjWTB1SDc3SUVMV2lYSEdMMTNxcUFvb1FsdjFJa1d3?=
 =?utf-8?B?OVlMcmswUlJPd2o5WTJRSkZ6dnFNNStJRVhyUTRjdmhscHY1Wm1lTEV4SWZR?=
 =?utf-8?B?dC9OOHdPZk1TdzJPZ1d6SkR1SlpRWENlbHFZOEZlWTJxNG9LS25UcHVlNUt6?=
 =?utf-8?B?WWE0MWlOYktBV2hYTHdNUUQvWFBGYm9nekdmeUJNSVpPN0NlRmlqSVNqNERV?=
 =?utf-8?B?YWNFQ055LzBwQ3loRGFzTktHY1VWbnluMjNEQ1JIZFJLcFhiMm1TajJxVCtO?=
 =?utf-8?B?QjNNZmdES2padE9nRkpGSU5zeFNXbGlSWmlEN0lIS0oxVlVHVDRUd3VHOWJB?=
 =?utf-8?B?aHM4VExLWkcxRnNnNTJmWEl0N29VejNQQ3JmWlE2bUhudnl2eTlxMkNCQUhZ?=
 =?utf-8?B?M0h3U3Z3c0hoZ3poTWZUN1BTN25mVHFxeG9oclQ1ZmMzd3YyZ1g1SWZtdDBP?=
 =?utf-8?B?SlRjUDk1ZHJTdjVUdzIxYmdEMi9aM0sxZlJtY1NDL3h5K3FBUlMrWHovSVh5?=
 =?utf-8?B?UmEwSFNDb0VscXBISm82Z3JZWXpvTDBabXVSYUlObXpNdnlpbDduTzk3NHFp?=
 =?utf-8?B?OXdFcWZKL1R0aFY4Y0dmQVRld09SVkJ4QzZBNFU2TXNsZy9TZ21vcWU4bURM?=
 =?utf-8?B?b2xYaHN6ZDJUcVlPQU41dHBCTlRlVDB3eFNnaFF3R3FJYXY1bFUvc0swdk4y?=
 =?utf-8?B?NEFPTGtsQzFEemE3aEN4NURRTWgwYWhhbzRHczk5QTZGMHduMFRrdW1WaGUr?=
 =?utf-8?B?SzNrSnZGcGZ6cXBndVd5aW5laU9UT1hibWo0M3ptcXU5RFNZd0R6Y2JpdllX?=
 =?utf-8?Q?d8CQ=3D?=
X-Microsoft-Antispam-Message-Info: 7wnkun4meIpB+DlDUd9YBdD7ujFc2C36K0/8lSaziANf9ZszprpLq5vLoc4Zutd4knT2jgoYdJBv5fyDhHQoCP28rmChHYDH0FZmMvrqjvt0rMNObKyotw/JmSKetATcznh3SrYLiBKipi5+ZzlarzEl2NUhnHMydf7aUReYWn6kOY7xc/0XU0Mjs1WASCJeN7v1ogg+5pCoe8BDXuJT0J6R73ajpFx055hJ9EeFzVbxk18m6O+V3LLsc6qTIWmfyB2+L4l8+Qc6EAT8ZuaBe91YJUJ0M1eMTNxhCcpmJDvamrmFlE3DVH9Y1DMXcGgL7aWtY0fy2yTrSXfNfzNgXFlx/R2KmalktIPn6jP2b2s=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4667;6:YShPmiCbcIqsTNwtFWmjbsv170VUU3UKljlY5ZpaVoZyptEQJnA8QkSHuClFMEv8MB9P2GZOk4W112DgAIsGCqYkd3pWGoDWVn3tAVgBUCI2MZxRTfJHz5xEy0yPz66C1Cc1HxGePYfROqr6sjiQMvFV5GQGt4hzFvYe3/TvWRju65aFCIPUn4q4ZjLvNRVDcQdTRBUBezpps7ffCgCoKJK3gVYpbUNzySP3if//4ulgKArAB2wLX0TxvkrSDwJz3n6Kyo0ImbJ9syxS2kTOSY7kY1MPI7WYhwRk2OEvY6fvV7SO6TEx4+qghsirRYyEVbCpgmw4Td4w9C3bS0bAWJP8IpE1hQAhUjfoTKr+KUcXxDEr1qjBW9x4UDFWgP8BqrMIcLNTuQt6pB165Zhst7KtYJjkZAPeU/NegIZD+o1lMO14xMjOMcssXRND6CtY6Hlw2RCevn8hH6YIg7zquw==;5:Ivc/XPb8YWrtBVbT9N6bImldIpiKxTJHvxFG/drSFciV6gqYoEtbpKYWWCetAwadlxqS4ErQ26uiSxbcTbTmTvleClS5rlU1xef/4nMuyVtpQFF0+prKR8fYIhHpYT3GQAVtbvepSG6hsZtVFgny+SC5x0oQeq3ytGqr0Pake3M=;7:ewpy6+PgL0WCZwRgvmF/95QvuZXRH5fSK0KyfvOpSDKci2CvKoxiJ6uLAKIZHNWKXvu0kd5xLfz76obmbejvQIKCXTvlpms4wrH2pMf4zjf1dJbK6t3vpi9rhXuKiRnJSTuYB/4Fkf/tzajmIIJ7gr5lyGfp4IoNvjha/LYm3gQ75kWzFguO5QzyokCP7yj6q0ofSPGIVjlA8xt8yMQC967k2IWoo25mAQE9PmMhrMtmo4UJiux27OHdro4Kve+h
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2018 07:44:07.3665 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6a37291-4eec-463b-bb84-08d613035c9a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4667
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Song,
On 5.9.2018 04:34, Song Qiang wrote:
> Some leds on our board are active low leds, which means these leds
> are lighted when the corresponding gpio line is low, while the
> original leds-gpio driver default all leds are active high leds.
> This patch adds a devicetree node "light-state", whose value should
> be "high" for active high leds and "low" for active low leds.
> The default value is "high" for compatible for the original driver.
> 
> Signed-off-by: Song Qiang <songqiang.1304521@gmail.com>
> ---
>   .../devicetree/bindings/leds/leds-gpio.txt    | 15 +++++++++++
>   drivers/leds/leds-gpio.c                      | 25 +++++++++++++++++--
>   2 files changed, 38 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-gpio.txt b/Documentation/devicetree/bindings/leds/leds-gpio.txt
> index a48dda268f81..0a8fad75c704 100644
> --- a/Documentation/devicetree/bindings/leds/leds-gpio.txt
> +++ b/Documentation/devicetree/bindings/leds/leds-gpio.txt
> @@ -23,6 +23,9 @@ LED sub-node properties:
>     remains up.
>   - panic-indicator : (optional)
>     see Documentation/devicetree/bindings/leds/common.txt
> +- light-state: (optional) Values should be "high" or "low", which indicates
> +	the state of the GPIO pin when the led is on.
> +  see Documentation/devicetree/bindings/leds/common.txt
>   
>   Examples:
>   
> @@ -64,3 +67,15 @@ leds {
>   		retain-state-suspended;
>   	};
>   };
> +
> +leds {
> +	compatible = "gpio-leds";
> +
> +	led0 {
> +		label = "led0";
> +		gpios = <&gpio1 19 GPIO_ACTIVE_HIGH>;

With this patch you are introducing one more way to invert the logic.
If your LED is active LOW, you should use GPIO_ACTIVE_LOW in your DT.
All should work as expected then.

Best regards,
Michal

> +		linux,default-trigger = "heartbeat";
> +		default-state = "off";
> +		light-state = "low";
> +	};
> +}
> diff --git a/drivers/leds/leds-gpio.c b/drivers/leds/leds-gpio.c
> index 764c31301f90..463ded0c71ac 100644
> --- a/drivers/leds/leds-gpio.c
> +++ b/drivers/leds/leds-gpio.c
> @@ -26,9 +26,13 @@ struct gpio_led_data {
>   	struct gpio_desc *gpiod;
>   	u8 can_sleep;
>   	u8 blinking;
> +	u8 light_state;
>   	gpio_blink_set_t platform_gpio_blink_set;
>   };
>   
> +#define LEDS_GPIO_LIGHTSTATE_HIGH	0
> +#define LEDS_GPIO_LIGHTSTATE_LOW	1
> +
>   static inline struct gpio_led_data *
>   			cdev_to_gpio_led_data(struct led_classdev *led_cdev)
>   {
> @@ -42,9 +46,15 @@ static void gpio_led_set(struct led_classdev *led_cdev,
>   	int level;
>   
>   	if (value == LED_OFF)
> -		level = 0;
> +		if (led_dat->light_state == LEDS_GPIO_LIGHTSTATE_HIGH)
> +			level = 0;
> +		else
> +			level = 1;
>   	else
> -		level = 1;
> +		if (led_dat->light_state == LEDS_GPIO_LIGHTSTATE_HIGH)
> +			level = 1;
> +		else
> +			level = 0;
>   
>   	if (led_dat->blinking) {
>   		led_dat->platform_gpio_blink_set(led_dat->gpiod, level,
> @@ -205,6 +215,17 @@ static struct gpio_leds_priv *gpio_leds_create(struct platform_device *pdev)
>   				led.default_state = LEDS_GPIO_DEFSTATE_OFF;
>   		}
>   
> +		if (!fwnode_property_read_string(child, "light-state",
> +						 &state)) {
> +			if (!strcmp(state, "low"))
> +				led_dat->light_state =
> +					LEDS_GPIO_LIGHTSTATE_LOW;
> +			else{
> +				led_dat->light_state =
> +					LEDS_GPIO_LIGHTSTATE_HIGH;
> +			}
> +		}
> +
>   		if (fwnode_property_present(child, "retain-state-suspended"))
>   			led.retain_state_suspended = 1;
>   		if (fwnode_property_present(child, "retain-state-shutdown"))
> 

