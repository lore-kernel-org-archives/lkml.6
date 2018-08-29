Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2893EC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C175E204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.se header.i=@prevas.se header.b="chtE878C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C175E204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=prevas.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbeH2Ovh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 10:51:37 -0400
Received: from mail-eopbgr80090.outbound.protection.outlook.com ([40.107.8.90]:58002
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728312AbeH2Ovh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 10:51:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmCLGxIzrA0BzKURmCaJ7azmpwLsxJV1xhzSat/D19o=;
 b=chtE878C2eJX0+wMNkJALEjzwjevxYWKRWmhbT/Q23yY+pN0TW2mC1WxCR50CJCEgwRHhKR2jZH4OPwm5GfuPJkHj0mAYy8gKiX2RHWyzkCM1yR5UZWQ+9JalbrZhfDW/QXexT0gB6bvYpVZgYNIv0xXrJAoSDgYZgT+qD3F7kk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rasmus.Villemoes@prevas.se; 
Received: from [172.16.11.40] (81.216.59.226) by
 DB6PR1001MB1336.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:b4::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.15; Wed, 29 Aug 2018 10:55:12 +0000
Subject: Re: reboot on wandboard fails with v4.14.67 (bisected to 2059e527a6)
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To:     stable@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Sean_Nyekj=c3=a6r?= <Sean.Nyekjaer@prevas.dk>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>
References: <b2ea002f-4fe8-0738-b346-69ed138cecd0@prevas.dk>
Message-ID: <b2505963-0fdc-81d2-6b8a-315a31eb922e@prevas.dk>
Date:   Wed, 29 Aug 2018 12:55:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <b2ea002f-4fe8-0738-b346-69ed138cecd0@prevas.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [81.216.59.226]
X-ClientProxiedBy: DB7PR04CA0009.eurprd04.prod.outlook.com
 (2603:10a6:10:12::22) To DB6PR1001MB1336.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:4:b4::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b603dbe-941f-4b1a-37ba-08d60d9de5a7
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB6PR1001MB1336;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR1001MB1336;3:KJHBGq9NkFCX52fW6S4HatUz+NupkXhLO2s0kn5RYeelz8oimO/zIL+tlktE3SxYVJcrER80hzvDyKKXVJJTvSUcxQpgCmUesvWNUMRw7iF3FiMuqvcaAOOfOMzS1n+i1GdUyvY6Red79k1E/84pVFUxf1Sw0p1+g8gW0R4wa7zRerVwIb+TZSL7KygOysrEI31hJDeeBZ9VFagnS5Aq7B4IsluCiyKnUwLmcsmUVJfQUYS+SAHNXoFSZCvcQi7e;25:seWfCbHFmroD/4rO7JNH7GVjfFy+3cDEFw5dqTwXYk6BbKTxF9ICZlH667qyEzZw4idR4aTTOq1VoD0hj4UuxNGGAwQp8r9lUvjPp1yj5rR+qq4kYg5Jl4O8qexoP4QDKjUIBAjJpr7VThud2dmzJqwrlhzYgHtL2pWuQJ0AazjKvTJv3UmeNJmLJPj97rLK19Flyk/Zuqmk6RxnnvpmT3S1EwXF7459jCH3KNBKdj1etfM3bTpRmK3toUZTebmPEfzXocW6AR44ztyulSuYuz7pLxyFscYMhcxQaMfSQIuoo+rn+HpisIg5l1+z6131RSRaEV1Yhs+92tBdGtSE1w==;31:yQpoaUMLRSHfhLIKPudkecDYG8EUKbu3Yg+mIFR67y6t9S0yHi5uGzVNqHCoHTW1zxBJ3E8eS5Te6sQ84lOsJyMDB01KZ0vy4TQrTu7xoI89sYhR0pmEjg4Sxq1b7dc4YEo341aMwlPcSWDfSCTD6HqtqI23hsyegCb1oJI6YhFxbtGvZCdZQAvpbBScENaVMSHkwnDDsqechNbZuaKfOo3soF1GgHoEKWYKgOqsP0o=
X-MS-TrafficTypeDiagnostic: DB6PR1001MB1336:
X-Microsoft-Antispam-PRVS: <DB6PR1001MB1336B41BB654166CBC75A8B28A090@DB6PR1001MB1336.EURPRD10.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(3002001)(10201501046)(93006095)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699016);SRVR:DB6PR1001MB1336;BCL:0;PCL:0;RULEID:;SRVR:DB6PR1001MB1336;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR1001MB1336;4:dMNISJRYB5SEajOrkJ7Mc1X6igePfFwgCFwGT/soO6DTDvvN2hQIuYUy18xHCRXBEM7MBA5txjzjcsaUNhjjQkh9zet6jXpsfJyHfikzdTevuel4nJegKcYtiUBrVDj5Kncz9fuQJ4XSZrLZhARUM9TtcX+DPMBxSxzQ5BIEsx1kre4CRx7hLQ6znwuzSPabrN1md9yGHadFB4aHjySlDBlntBL3ZI+q9xcGPIeKK9WuvcBsA6DytI/T5hiYbXDsRfiBcD+g3hq8eHKopmMCjQ==
X-Forefront-PRVS: 077929D941
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(39850400004)(376002)(346002)(366004)(136003)(199004)(189003)(47776003)(68736007)(66066001)(50466002)(105586002)(31696002)(65806001)(486006)(36756003)(7736002)(305945005)(39060400002)(6486002)(106356001)(14444005)(25786009)(16576012)(476003)(6666003)(6916009)(2616005)(65956001)(5660300001)(54906003)(81166006)(64126003)(81156014)(446003)(956004)(44832011)(97736004)(8676002)(31686004)(11346002)(58126008)(65826007)(229853002)(52116002)(8936002)(74482002)(72206003)(386003)(26005)(53546011)(77096007)(53936002)(230700001)(6116002)(186003)(16526019)(2486003)(52146003)(3846002)(316002)(23676004)(478600001)(2906002)(6246003)(76176011)(8976002)(42882007)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR1001MB1336;H:[172.16.11.40];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: prevas.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjEwMDFNQjEzMzY7MjM6WFlpWGh4OU5vZTkweEhDaGFTWVRpOWJY?=
 =?utf-8?B?cFAvazYvZXZXbHplbG9qL2g5M2ZQT2l0YjNMeEwxRFVCMitMQjJhemZaZjNy?=
 =?utf-8?B?dDdRalVNTmYrZmR4OXVvOG9FdjMrR2NZUHFFbUV1MjlTQkNVUWF2UXFhYkUv?=
 =?utf-8?B?OVFBaEswaUI1Y3VSbjYzekZ1d2NiUldNbldmYUVwOG1PSE5CN2sxRVhub2xM?=
 =?utf-8?B?dnNNWnNmQ21XUWZIZ05LZ0E3dG4xZVd6USt6bXdNM2xmdUczY1hhK0dST0sw?=
 =?utf-8?B?dUo5YytoaTUzb2o0WDcrOEdZUnVpMzJhc3htZTBobnQ0aG9PMisyQWVWSEJh?=
 =?utf-8?B?akFhZjZ4cVV1RE5SL2VOV3o5b0N0QWNBNDVnVUFOaXVvUUdmT3FuRGhZaWZM?=
 =?utf-8?B?akJZakt1ZTVaSVJoSzVnaTN5UDFqMG4ySVZUZCtKZnR3bW9CV1pIMU1heU1y?=
 =?utf-8?B?TElkdXBrUm1xRkRwaWx6VkdIVElibnpXMS9qa1JtVEF2T1R6OG9iVzNYditi?=
 =?utf-8?B?cExiTzZXTWRzdWs4ZWV5U3lUeTkrY3FKNjlLTzRHUElaamxhbEdYRE04Nyts?=
 =?utf-8?B?bTVhdGt4R2IyQjN5Q3VOWThWOWhYaWVOUkpKVm1Zei84bzNrdENFbXBmWkZQ?=
 =?utf-8?B?QTloN01tY0dDK3RRTVduV000YXJuUHdqcndKZ1U0WFdWQmNxbEQrelZtaVFt?=
 =?utf-8?B?WDN5U0VSOWZCMWhlVXBBVkhKT2xIWXFDVExZaWFtbDQwSy83YUtWN2ozL3Mr?=
 =?utf-8?B?WXBuazNITTlsYlVJTnUyYktvTU1GZnNIME4yOU5TV3c3Z2JLSGNkeHRnNGNz?=
 =?utf-8?B?N0d2ZUdJVXF2TUxWcHh1T2Z3bjdaM2haTks3bkpLTGVRSTRlak9PNy8yckdo?=
 =?utf-8?B?ZkhvTkVXMTd0Yi84VWd1cVRPeUEwbnVuek5KR2hpbDdNcUF3M082emFub0JV?=
 =?utf-8?B?V1BQblB1UUhVRjRraStOVjFjMUVyMGJHQXNXU1QrK1phcHNCUWEzOFJLaVNh?=
 =?utf-8?B?WEZWZlEvalhvbzAwb3FOWFltTTBMOHJia3E5YkFPMGVDbHB6NjVtcTRqWCtw?=
 =?utf-8?B?UTJDKytCRzFQWGxYTG1IdXVsQ0NWWFhWNmhkRzdJS2VDdit4R292UkFJaCtI?=
 =?utf-8?B?aTZaeDR4QWpBbFFOUGlBSUxkQ1lZTUhXQ1Z1djMycXZkSXBBMnh1Q1lwV3dS?=
 =?utf-8?B?by80b2FDd1dvdEN3U1NrZUJYWGFnY0JQVnF0NlZ3WHlUZTgwQkJoMnBVVnc5?=
 =?utf-8?B?d2dxWDViQTJENzZFc3BkVEZuektGV3p4a3p6ak1xaENuazVjdVNUcURiM2lS?=
 =?utf-8?B?Qm1WVWtMQXI3aU1WOGxxK1I5T1poK0Fodmw2bU4ycXYwZGp4MHpka0pvM1NY?=
 =?utf-8?B?Z1VNcTQ4dk4zYjFITjE1WUZVVjFhZk9ESGR5WFpUU3VXWU1OQkRHUC95Tk45?=
 =?utf-8?B?WlUrUENwNERxUFo0dG1mb3ZIcmdLcllScFNMYzhOODFvUEM3eEFMUDd2S1pQ?=
 =?utf-8?B?RTg1NnRBK1NXV3V4KzlZcnNxeHZSQVJRczBzUzMxckUyckxYeWROWk84NzJy?=
 =?utf-8?B?T2l2eUp6SHZEMCttTFQ3akgyNnhHZHk2WWRpNGxnUUtjWmF6MnpPbVA4R0Z4?=
 =?utf-8?B?L3EreVg0NE03WlFEaEszVVJkQzEzc0V2djdJYlE1M0FoRTNrd0ErcUo2V3J1?=
 =?utf-8?B?ZlZtMFJnWC9rMHhLT0RGTmQvSnJiMFNBeXVJWXRheVB5V3IzUW0vQ291ZGpU?=
 =?utf-8?B?U3VOcStwVzl6OEJoQzJka0xJTVhORURLV3A3Ry9ua2R0QzVuOFUxdHZZNnFE?=
 =?utf-8?B?M3dUK2s5TGZYRmsvYWZhUG15TTZGM1VRQ0lvazF3aXNpanFZMkNLUnZESDhk?=
 =?utf-8?B?WW9xUUZtRWpNenA1aUhuSlpjRHNPTmlqczV3K3o3QUdYSW1ycDRobmtUS3Bs?=
 =?utf-8?B?UzNMay9vUm00alBPVmdURk5ZL2NUcGZnK0xVUGlndVorSUoyeHNRSm15eVhj?=
 =?utf-8?B?Ti9mWXRtQzM1U0pmTFBLa3NEMGR1NTVDZTJ4TGs2UkFVVWFXdEpsakhWS2xV?=
 =?utf-8?B?czZlZ1hXUk5oc2tMaTZoMU04aXRMWEFPVTJHRDZTRjk2Y3pjVXB3NmxlRlRW?=
 =?utf-8?B?cXVtZz09?=
X-Microsoft-Antispam-Message-Info: N8SlaQJMYgBf8z4ytwKROZ5YbTcnHYkZ8/FJGLWAT/4BW+9bAnqne64kqr5S068BIQiMSx1w2kP4BmBBIJh10Xi3Bh2zOTraM4olhRpjwNwJFEpCaNnqF/LXC7Gv9qlmng8bSnyswxPUvO5d7MJA8MyAP9KZgEi2tdKbX0KWRKDWZtbpRdpkNZh+jdKHQOzU/Q6Nwv5RNXQo1a97i6v+NPnXte4/hZAUWGGoqaWZoJnMZKCcNyV1h91OEglfJ6TWJEUB54ojhhHUNFRwEDXoa1V25rL3dqYW8yZJjIUIji4+iU4R48Tssu7MP2BpX2JpqgcO0ljsWIqHEC1um8CgNel8ocLY0DKajdrU7ZM4oVU=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR1001MB1336;6:R2Kg2fzIDYZf2qTSCC7HrekKgNR4zT9+TsElV7q8BbGkVZ3OBWI7RvW07i4NjjeiMIiOfmf+gXw30tyHSEqgWjhJIld6KE20FS8toJXK+RkxQYopf0+b4K2v7+ZUiGDEKkk+YEIqABoM63LwrxVidYveMIoRstb66k+Q+qqjetJAhEoyhzIgUsscHUED8SxjvcXZBmZ7UUpi7UQsWlRbtqpzddWXAhOXMmHmeqPvyLgkysLWqfH8du04YcnrBsHOao+yopiDvnLlYIvJejOAbBTOttbYhhAgH3bQQ0inVcliH+zL7QGMD/xPZVozSI1BOIQR75D228m3qi1vkfMJi706jEshF1O6tjwKEjg7If67UwPwo/TAxJU1tbumQZz9LVUobdkMETIAAL2lpIdqW1R3uvWejelrvEsJuSjOrNfXhLSR1vO85oQNzE2L0HBvgOix11cyYa0k+WM4+tilVA==;5:7G3TrUc5zIPJkd4NmZA2pJCf4UeIR/BO0LXIp7L4Vg8I/VIt4DQLP7cetEwvbOIuAfbpoLowVDiZZdKQhh+etO7KDmldht7HeSvKyu99JKj4v3wFlIQwI1Z7TOKwhM+gES2u7vOTqVx+quvwhWSFK4tnpcW6dXT/0SfpxeoJ2iA=;7:VGscdCa/dejTUXEnFm199P1KMzLvjfiK3JOShD50DNt4PYolh8LebODJ/498j3ZoDlqmh3MiIybVGmBYmytZ7UmH1XO3wmNGZjuhunnKBHqQiefUTxLislrwTWV2ofUY/C5OdrL5jFmQJTW5tfgW+VMfZZjNO/xOw0m00h4j/yM9OvSjBxm2gz4tlXZ3CcG5AkQPDITTQM1Oiu8YZXFvg0YliJf6Vf6dr3+LL4EkiHqZibiKYsQazI1J4TCvhb3p
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2018 10:55:12.8117 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b603dbe-941f-4b1a-37ba-08d60d9de5a7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR1001MB1336
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-29 11:55, Rasmus Villemoes wrote:
> We're using imx_v6_v7_defconfig on our Wandboards. After upgrading to
> v4.14.67, reboot no longer works (or, well, takes a very long time when
> the watchdog is configured).
> 
> v4.14.66 works fine, the breakage bisects to
> 2059e527a659cf16d6bb709f1c8509f7a7623fc4 (ARM: imx_v6_v7_defconfig:
> Select ULPI support), and reverting that on top of v4.14.67 again works.

FWIW, v4.18 (the mainline release containing the upstream commit
157bcc0609) works fine, while v4.17.19 which also has that commit
backported (as df06ca1f56) fails. So I'm guessing there must be some
other commits in v4.18 that happen to make imx_v6_v7_defconfig work.

Rasmus
