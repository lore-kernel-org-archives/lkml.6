Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9435AECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE46E20C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ekAB0y9f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE46E20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731186AbeIXSIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:08:34 -0400
Received: from mail-db5eur01on0117.outbound.protection.outlook.com ([104.47.2.117]:39703
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729023AbeIXSIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:08:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rau6LFO3DkWNAqj5QLH/v16MivoqdJaI7t/lLCXwFHA=;
 b=ekAB0y9fxdoZsFbSZeGHkkR4ZvCqbmswac1IQldYUcSfGvDzUKxYQh56b8r5uD8MQxDtfMaYA70W3j7ci7qWcV1jzD6W0/3UDo4M2C5tzbmCX3HjXpPH3x4ZpOZqfTgXwIFSkVnT741wgSNozZSzDzmk4XKBGzt7BXxh/P1872w=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from [172.16.25.169] (185.231.240.5) by
 HE1PR0801MB2028.eurprd08.prod.outlook.com (2603:10a6:3:50::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.15; Mon, 24 Sep 2018 12:06:37 +0000
Subject: Re: KASAN: use-after-free Read in fuse_dev_do_read
To:     syzbot <syzbot+4e975615ca01f2277bdd@syzkaller.appspotmail.com>,
        dvyukov@google.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, miklos@szeredi.hu,
        syzkaller-bugs@googlegroups.com
References: <00000000000059484105767ac88f@google.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <be262e04-df8a-c248-26a8-d42bf081be1c@virtuozzo.com>
Date:   Mon, 24 Sep 2018 15:06:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <00000000000059484105767ac88f@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: VI1PR08CA0238.eurprd08.prod.outlook.com
 (2603:10a6:802:15::47) To HE1PR0801MB2028.eurprd08.prod.outlook.com
 (2603:10a6:3:50::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f14671c9-3e05-4359-1029-08d622162e73
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB2028;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2028;3:vj/2bzqooDvJlZnyQOK72tuIubGvVcEq6//7T3YZXS9z6t5Vuii06uNzpr060YCf3UGlBw3iqrzdkP+n1hC6WMv0KoOwo0lH0CmzDyqI8kuVFIcfWgwHt/kr4KH0KTLm3qMTWSpBTOZD/hu6qSDfnknH3mAhYeEKTWdSwGpTl+4TKVRIl2vfxwFN/WRBJasGSq1CZ5im21++1RdOZEMcMUTcXqbcXqPjYFpm0oUAv5VM5yWh4mrENH2RFhCyB7Oe;25:vUb3OIYufydghj/SMXrBbbiI4D00p3nHwftmiEFsHnt8jny+yXVdmV+lYnL2FBxknztJVaaN9kOjFquEf1AR5vH6lf8KulSy9zMGoZsQ1eZXUy9DGPcLp9NY/igpBalEQmRRjFn80rmzVPkXLBKWdq+ZFBljQ73RYxiymvh8Xd71GQDqb5qR4D8EX3VATbIM4V0362rO5nqT2RloqvCwOVrc/ZeMdoP/0tWuQR0gDlxnRWmi3BQ+YinLZRMvQPmWMoxmrGp5ddRRsSgiFmXF++ff3il+MH+ZU36hLcTGH2gaUmEpeovupB51oYodjB87R838JtFy6NCUGaPq8JGopA==;31:JlL0VqBXlI4FPlyQNsrVyxer0f60ZcBkUrLvljrUfnZ1bW29yNdW2LAT0XxMWaw/lNrFkLdD3t51xjvRfE0zZPuw0XFIWAoN23Xvelj9SSHDdhwd0D8qkgcCdry+9ZAZCS009bPsglJyjvDlwnGtO3G9HsC72VgnlSsnrVIG0l/L1TlYj8GJYX1cLPnnjSKa13cKk/0EWqsY+J0SIIfovh/eGWPmL9R4ETYT8tJZVEI=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB2028:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2028;20:8Z707ON1u6Yopwm5GzrwqsrDsCNxtYqdgZTBCcKPn9oQtR7eiaDPTkzb2U1SezkPTcz6AMGK4po24YaszJIWL2J516NOXy4344IQvhXSEQkm+92S0O7jcVJBcqdIgbitNWbOPBfxJK9HLt906JNQzOuogjr43EzWTtAIkiF30je4Sjzw+F/+do9yLA+Qtpni1PDVgTZ5mbCK3UypC9qy0c2RLGrcvdiIK5AgRqEGdD7A/kD8tuuRfZJa96i8oTVqO8teXW2z1ePQDh0KscP4l1QI8YUJxjaci/kNQq91k9L9Kc8z/VPur1e0UiD+VwvhYTjpHMAMZJ8knKlDjogTkTDEbxAdObnm8Ns49cnur3WfRF5Ar2hsS6eJTTkRKPe8rMt9TiNVhQ7BJsSJMnw7HA/tLypsZR5XtVBGlQcpd77gJ6xNYs7RhEijYb6DedkMedT6R4qamsxXwKjd5K+wN8n6LlcROGlc9rhHHX2AhdVuYPk2EpehxFfq3b5osY/5;4:UoB1h1gfZgXMFzSAabR6DLDhBqf3azordi9DybSNlGdcbn7mtTNzaTryRiJHkVI8U/+fkR416mhMfFPLPQh5RyzTKPAA4s6a0SdjPX4231niM3XAuOGFV32tIsQL+vQGrQgmuWfusHJN8z5d90l25e91PeqaiR8GZluvQxStiRcVn+2ZXNc5AbCx+TE/x7jJbaVPmDviApgpxU5aMFjymQU8bKJYVn9mmORTh9+Um9o5pxIoAtGQuoYYkCj08L05zhDm1SB+nR5ivIg8ZsA+HWcyrRFBKc56LGq7JiCTAdx+BXfgIMvE7ubHUJ4EVSf9
X-Microsoft-Antispam-PRVS: <HE1PR0801MB20289DCC653DAB2E12F9B599CD170@HE1PR0801MB2028.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(93006095)(93001095)(10201501046)(149066)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699051);SRVR:HE1PR0801MB2028;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB2028;
X-Forefront-PRVS: 0805EC9467
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(346002)(376002)(136003)(39840400004)(366004)(189003)(199004)(106356001)(3846002)(36756003)(5660300001)(8936002)(50466002)(81156014)(6246003)(81166006)(65826007)(486006)(11346002)(97736004)(8676002)(31696002)(53936002)(14444005)(6486002)(2616005)(956004)(575784001)(86362001)(6666003)(66066001)(65956001)(105586002)(65806001)(47776003)(966005)(6306002)(68736007)(186003)(476003)(386003)(16526019)(77096007)(26005)(446003)(305945005)(7736002)(23676004)(52146003)(229853002)(16576012)(316002)(25786009)(53546011)(6116002)(2486003)(76176011)(2906002)(478600001)(31686004)(58126008)(2870700001)(64126003)(52116002)(99710200001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB2028;H:[172.16.25.169];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjIwMjg7MjM6by92MDZoakI0RlZOaEdkVmsyR3FqWU53?=
 =?utf-8?B?a3dla25HQlNPQnRielprUGRtTHVmckVDWGxwN2ZwSkpaMWFQdjBDanIyRW9w?=
 =?utf-8?B?M0xjSUZ3emhBakRCdlUxMzBKMG9VSFdwL1JsNURKSklBOG0zVjBqcy9MZzY2?=
 =?utf-8?B?OCtoTXdaUjQ4ZHJsSDFwcHFsdmFhNjQyL01meVZ6QUpsMjN5Sk5TS1RaajE5?=
 =?utf-8?B?QklyRkNlVHR3RXFrYVZPSGh4aGh3MW5XL0ZWQnpCR0dKVkRzSHhlUmtJWDZ3?=
 =?utf-8?B?VGdwaGYyNWJ5YVk4MktEb0dGL2pIaU4wQUJEL3pXSHBrUC82QWQ0WnFWdlVs?=
 =?utf-8?B?SFY5MGg5YmhYME9YVWYwVG9JVlFkTU91aHJ5NnljblhNSTJiaHVOQktKSlRC?=
 =?utf-8?B?NmpEUEUrVFlGK3BxYlFWM1AxU1NzRWk3eTdValhzMWFNV1EwWm5xclVta21Z?=
 =?utf-8?B?RUtEU2M1b1FjNWVMakU5dFVjU1I1UlNqMHVkZHZvMmN5Ykh1ZDRZV2p4d1l6?=
 =?utf-8?B?V1g5V0FCa3Bwd3BsQlh4R0ZzaGR1dU1MUlNqOWdLOE1XRzV0UUFUelJnNmIw?=
 =?utf-8?B?WFo4b3VkejBibTA4bGl4S0N5dTl0d2JtZzBXSEs5cGtNYkx0enZCY2h3Zmcv?=
 =?utf-8?B?NDhmb2x1Q09kM2hwaTIxQUtBak5IY3RLM3RoRUhjTHY2UUtHQWRmVVV1MUZK?=
 =?utf-8?B?QlI3TTIrMXhvYmpyazZZWFkzeEVHa1BxMm0vSzNjUmVScmRmMmlnZE5iQTZN?=
 =?utf-8?B?R0VHU25tTVpGb2J4YmdBTFJRUi9MVjY3WHlQOUNuTzI2RVEzWm1Kcm1XelJB?=
 =?utf-8?B?TjM1YlpNQ3RUY2VOWC90V3B0dU9CdjFyK3Y4UFd1YjdhVmdoT1NiSzQrQlNh?=
 =?utf-8?B?N0xPZ1drZDBsNmtKZElleEFlaC9kb2tveEZ4M2YwdGhSMUwvOGtvWjFVR1Jm?=
 =?utf-8?B?alAzcUwvWVRDcjdmREtmci94WEZCdmhCdmIzcm56M0dhcytPMTYrVTFzbFhr?=
 =?utf-8?B?Ykh5RXl0NHcvTmZpMlA5V0xLOFZOeFBLbWsvNmRsdUlONFQ1SEVBdllkd2gx?=
 =?utf-8?B?cTNyVmZ5N0s4UE1CQ0wrWnROcGpDeEVFQXlGUm0zdHZCTnlwd1N0ZVd4WXU0?=
 =?utf-8?B?UWlvSmNXWGRLajJaSWJSNnRQdGdCTWk1MVJNYm9NSzNYczhvRThxZVhuM1d1?=
 =?utf-8?B?V3hrT3ZCMEs3Z1BhZ2Z1YVppUHFJNGJjcUpiUmF6dUNOQ09zNlY1OGdLNUpR?=
 =?utf-8?B?enRXVTg1cWtCbkMrWGlKSlcyQUZqRFJMUnV0VDI3L21JRmE1WTJiSmo1WkJN?=
 =?utf-8?B?T1EwSHlRQ2poVlV5ZXdlQ2lWcE1MZDB5dFhNSG9zRlM2R1hmT0JvV0xYSWRM?=
 =?utf-8?B?SlY0b3R5dlpCQy9vWmNSaVNyeGV6b2VDMUZ4ZTV1dENmdlI0aE93Z29UTUln?=
 =?utf-8?B?YnlBVHRXNGdSeWgvNEdKbWNZdUxRV0ZBV3lUL2ZuTURKM0o0MTV3Z05FNldv?=
 =?utf-8?B?VXlaOFI3MDRhcjlIS2N6VzdSM3M1eGM1UmpUckRPL2lka2V2SExmZXlac0Y2?=
 =?utf-8?B?ZVJYYUNmODNFNXAwWVdaWWhWTjNXeVh2NWpPc290MkcvaWNDNVJQcWRLOUFo?=
 =?utf-8?B?RVorSVFmY0lLWFNwWE0ySndEWFNvM0lGVWh2S0MwUTNyMGhiY24ySW1jVTRE?=
 =?utf-8?B?NURBVDlHOERKQmpIbjFPOGppaGJtdlNraFgyY3Z3RHpJcHFteFVLYnFRc0Yx?=
 =?utf-8?B?Snd4TmRsK0dLcXFNTnZwU0xkdk90RW5wTDdqQVoyR0NvQ3hvTHRUY1doRGV0?=
 =?utf-8?B?cFNGMHJEeWFYdkxjNDVReGNVbWgyd0xNanRxbitHM3UvWUN4UmdCMGQ0RGNE?=
 =?utf-8?B?VUtTdXM2V1ZGcTA2THJPTjBIOTZMWi9waWJ4V2tFOHdhWFB6QU5Sblp3K0c2?=
 =?utf-8?B?Smlna1JwQjVtRng1czBldDN5T2dka2ZOMm9ZRFpBRjJSMXZYZUpaZ1lvMDVY?=
 =?utf-8?Q?QhIAyaIE?=
X-Microsoft-Antispam-Message-Info: 12cesQxktz2hcWyUbCpUi/vjeH2UAmNjQQKeMn35oqkk34UBxMN4x2YD1j7mx8w8/INBBKNBZlWOGsd4lqPEP+KPUiiV2pKxuVYqVcOMup++V/Ig2XM7ldfCHVhqm+1QHnIYRg14D2yRkoTnn9fzoEWYh4eE42/FRkA4R4Q6gtbBV+5U7kKqlBzo3wfB2M6sZ8PE05Et4/u6YyjFrlA0EokpJtXVUils8BKU522VK0SMDRfq0uaNCEgpIDN2c+UTt5E5Vdro61vv7JzPLxfCreGgfUDXtoxq0ZAIzj9LtlWPmGm12BrfGjlN2vosdaBLbs1bR8rCnmkAluTshViXk7dauGa1n2M2GPCRZqbvcps=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2028;6:TAPXtUPPc/mRWvPGc6acryYzTm8BhQrwAGVt9CdFGn8wTrMudBp9qzGQ8G/On4b09bmXwdedpba8ZLhPjXC65dECbkUsaINbX5cyPPoFuKoM+7FYf/U4sXdOsP9czk2E64ToAaPkFHLCDROXnRfZ2GXwKSiKk4FEPUWKh4aF7T3yleT5RCpCLaffIV2HOWAXSdDnPNi9cv7h8ypDgL6GZV4hqGybvDYVPjE5KyNi/aSCVdvZYNtsmxTItZCQL1ZHfyYCGk4G+DQ5PMWEWxu1f/l8uViFVRU/uEg/ZA/0Lww8SYwHS06bvpW9xL5FBJgF/942UWCPPma2uurq/z3mSx8HEHaWSfAEz4E39c8Ycr4+Ucf8NwWBLWs8P81UUuMA71LH3IrBIxI086OeH9sm2jQC8wtTBwdHxVYwWbE40G4335KPI3x08b8W8MDU2DQm3xfhouCr4a7om12p6Sk9EQ==;5:gsF9QocOMEc4phBGIMcDX592+xA9BWOGvFQ1tEfSKMbNz/ugZZI8zq7CdHH0sInv9+0fPzN189T82Du+ACbc3v+7ZPjDSUYK+Pu7AhCZQ6+D+2IM5akZoGMZm8XWR5DQ/obqbyn5+wtwrFMF4s7E+3aCca4hPGRSlRdnrr/tyeU=;7:M2TTw/2wW8newiM32Y0x2hUaTCZn9bashvu/oyGDzEbWMAwTdBxqzOmQ1/H7BWYPvyCliDMHiFg2nXUDvXdaFWyL7ev1hCaJIC0SFkqmEzDsU5a6EdDgHXgIGuj4sjX6eS7Ny835IClPTGgxMb2NoPm7SMZeECoYu/fSIg/E7Fz9OmwN4IRBCY4uu6TRlpMT7jcVgKPX2ZSaB18G8E3tzB/mY3RuJ/vrRyfaWqHZ3vgCMC7RWY+byAiji0FgjSsS
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2028;20:Bmmy3hzRK7jkK3voXtHZQhwA+dGWZwpiUJslt3YotwLKTSJMjDlkS0rXgEsReIcw8FhDZ/aKTsCwetekhO7boKr20fPOyVaoqqq5e0s2r8q//ZdFXiFBS+EYIxvU7lXkrDSc4B+9XKW+6RztFD3DxtFmU8OvoRJhbXH2G0j8ONI=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2018 12:06:37.5609 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f14671c9-3e05-4359-1029-08d622162e73
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB2028
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.09.2018 22:30, syzbot wrote:
> syzbot has found a reproducer for the following crash on:
> 
> HEAD commit:    10dc890d4228 Merge tag 'pinctrl-v4.19-3' of git://git.kern..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1631cfbe400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5fa12be50bca08d8
> dashboard link: https://syzkaller.appspot.com/bug?extid=4e975615ca01f2277bdd
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15ffb766400000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+4e975615ca01f2277bdd@syzkaller.appspotmail.com
> 
> 8021q: adding VLAN 0 to HW filter on device team0
> 8021q: adding VLAN 0 to HW filter on device team0
> 8021q: adding VLAN 0 to HW filter on device team0
> 8021q: adding VLAN 0 to HW filter on device team0
> ==================================================================
> BUG: KASAN: use-after-free in constant_test_bit arch/x86/include/asm/bitops.h:328 [inline]
> BUG: KASAN: use-after-free in fuse_dev_do_read.isra.27+0x1659/0x1920 fs/fuse/dev.c:1318
> Read of size 8 at addr ffff8801d8702630 by task syz-executor1/7794
> 
> CPU: 0 PID: 7794 Comm: syz-executor1 Not tainted 4.19.0-rc4+ #26
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
>  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
>  kasan_report_error mm/kasan/report.c:354 [inline]
>  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
>  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
>  constant_test_bit arch/x86/include/asm/bitops.h:328 [inline]
>  fuse_dev_do_read.isra.27+0x1659/0x1920 fs/fuse/dev.c:1318
>  fuse_dev_read+0x1a9/0x250 fs/fuse/dev.c:1360
>  call_read_iter include/linux/fs.h:1802 [inline]
>  new_sync_read fs/read_write.c:406 [inline]
>  __vfs_read+0x6ac/0x9b0 fs/read_write.c:418
>  vfs_read+0x17f/0x3c0 fs/read_write.c:452
>  ksys_read+0x101/0x260 fs/read_write.c:578
>  __do_sys_read fs/read_write.c:588 [inline]
>  __se_sys_read fs/read_write.c:586 [inline]
>  __x64_sys_read+0x73/0xb0 fs/read_write.c:586
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x457679
> Code: 1d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 eb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007f6a5aeedc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> RAX: ffffffffffffffda RBX: 00007f6a5aeee6d4 RCX: 0000000000457679
> RDX: 0000000000001000 RSI: 0000000020001000 RDI: 0000000000000003
> RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
> R13: 00000000004d4ad0 R14: 00000000004c31e5 R15: 0000000000000000
> 
> Allocated by task 7801:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>  set_track mm/kasan/kasan.c:460 [inline]
>  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
>  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
>  kmem_cache_alloc+0x12e/0x730 mm/slab.c:3554
>  __fuse_request_alloc+0x27/0xf0 fs/fuse/dev.c:58
>  fuse_request_alloc+0x18/0x20 fs/fuse/dev.c:89
>  fuse_fill_super+0x12bf/0x1ea0 fs/fuse/inode.c:1157
>  mount_nodev+0x6b/0x110 fs/super.c:1204
>  fuse_mount+0x2c/0x40 fs/fuse/inode.c:1213
>  mount_fs+0xae/0x31d fs/super.c:1261
>  vfs_kern_mount.part.35+0xdc/0x4f0 fs/namespace.c:961
>  vfs_kern_mount fs/namespace.c:951 [inline]
>  do_new_mount fs/namespace.c:2457 [inline]
>  do_mount+0x581/0x31f0 fs/namespace.c:2787
>  ksys_mount+0x12d/0x140 fs/namespace.c:3003
>  __do_sys_mount fs/namespace.c:3017 [inline]
>  __se_sys_mount fs/namespace.c:3014 [inline]
>  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3014
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> Freed by task 7801:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>  set_track mm/kasan/kasan.c:460 [inline]
>  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
>  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
>  __cache_free mm/slab.c:3498 [inline]
>  kmem_cache_free+0x83/0x290 mm/slab.c:3756
>  fuse_request_free+0x8b/0xa0 fs/fuse/dev.c:104
>  fuse_put_request+0x2a6/0x350 fs/fuse/dev.c:304
>  request_end+0xba/0xaa0 fs/fuse/dev.c:414
>  fuse_dev_do_write+0x192e/0x36e0 fs/fuse/dev.c:1915
>  fuse_dev_write+0x19a/0x240 fs/fuse/dev.c:1939
>  call_write_iter include/linux/fs.h:1808 [inline]
>  new_sync_write fs/read_write.c:474 [inline]
>  __vfs_write+0x6b8/0x9f0 fs/read_write.c:487
>  vfs_write+0x1fc/0x560 fs/read_write.c:549
>  ksys_write+0x101/0x260 fs/read_write.c:598
>  __do_sys_write fs/read_write.c:610 [inline]
>  __se_sys_write fs/read_write.c:607 [inline]
>  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> The buggy address belongs to the object at ffff8801d8702600
>  which belongs to the cache fuse_request of size 448
> The buggy address is located 48 bytes inside of
>  448-byte region [ffff8801d8702600, ffff8801d87027c0)
> The buggy address belongs to the page:
> page:ffffea000761c080 count:1 mapcount:0 mapping:ffff8801d4a0e240 index:0x0
> flags: 0x2fffc0000000100(slab)
> raw: 02fffc0000000100 ffffea0006ec0e88 ffffea0006ee91c8 ffff8801d4a0e240
> raw: 0000000000000000 ffff8801d8702000 0000000100000008 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>  ffff8801d8702500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff8801d8702580: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>> ffff8801d8702600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                      ^
>  ffff8801d8702680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff8801d8702700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================

Fix from my previous message makes the use-after-free does not reproduce
with the reproducer in my setup.

I can prepare the patch, but before this some comments from Miklos would
be welcome.

Miklos, what you think about this?

Kirill
---
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 11ea2c4a38ab..675caed3e655 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1311,12 +1311,14 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
 		goto out_end;
 	}
 	list_move_tail(&req->list, &fpq->processing);
+	__fuse_get_request(req);
 	spin_unlock(&fpq->lock);
 	set_bit(FR_SENT, &req->flags);
 	/* matches barrier in request_wait_answer() */
 	smp_mb__after_atomic();
 	if (test_bit(FR_INTERRUPTED, &req->flags))
 		queue_interrupt(fiq, req);
+	fuse_put_request(fc, req);
 
 	return reqsize;
 

