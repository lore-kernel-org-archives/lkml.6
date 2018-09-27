Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870AEC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21A2B2150D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="1Z03YufO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21A2B2150D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbeI0Po5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:44:57 -0400
Received: from mail-ve1eur01on0050.outbound.protection.outlook.com ([104.47.1.50]:48730
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727505AbeI0Po5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:44:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2BMra5JZUXtb9QzesBMf7k9W7rBPAYVPPOX4dQm3LJ8=;
 b=1Z03YufONm2KvExIdcoyMUZYY0QmNWrhZzjLEmco4Ix3FZMGzZwKDK0Pn5efP4g0sl84Rh7/HiqLayC3TTFsZ+TygTf9wrVGhF4Ej1e6Cg2kkT4vTSJ+b9vS12UbcowSVJtdwCvpgjYFg6sparShgaqvM0jnNejo/XmvRyNHAfk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
Received: from iota-build.ysoft.local (89.24.100.190) by
 AM0PR04MB4660.eurprd04.prod.outlook.com (2603:10a6:208:75::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Thu, 27 Sep 2018 09:27:30 +0000
From:   =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [RESEND PATCH v2 1/3] video: ssd1307fb: Use gpiod_set_value_cansleep() for reset
Date:   Thu, 27 Sep 2018 11:24:39 +0200
Message-Id: <1538040281-21319-1-git-send-email-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [89.24.100.190]
X-ClientProxiedBy: HE1PR05CA0360.eurprd05.prod.outlook.com
 (2603:10a6:7:94::19) To AM0PR04MB4660.eurprd04.prod.outlook.com
 (2603:10a6:208:75::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9dab4e8e-82ee-4be5-929e-08d6245b7365
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4660;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4660;3:svqcGGM1SossD5VrIF8tvIVLYsrb1Rv9IqzdwcXkNFWgHPoeaL0UYJ0C+aiCou79dDpNlAH0Fxh8W8cqDxFYuVCkSd2pxjOPZUvOCnlw2/lFUMlPCYetgNEnob4waEl3kt67IvQNEaul1nC2Zlbjeg/sM0kdf1gtu9ZUQy2ZSEoTvRQgBvv1zE4G2E2kTBlptvlF2sO3PStFXOpMv0C8Gh5ItBe6InIXJTiM63u+ThKM8timBNBRPW7D5NAUD2it;25:m5jSCfeTS3m+JtJpCkIhewmjS6cUarw3T0BDw3gn0f8aLf5eVXXzHUhvmIl5Lbr/N97XGy0QdtegmM4jZLOjFsg32qGUGDOEHgnHMo9rWuXx34XVoaIMugRpRgJ83LDhtusgYjmPn5tiphdL8RXp1aLNicO2FWo5YgGSk4oAiI8avg8s0WJQRJ9kOOSsSrroCeuY9GbYOQaRbOLugH2xy21Z/oqUtDfrMXbjjXBCgfW+b1WeInBWPoNqfPhRIZdTX/HWWTGYwswpeiZVddWYnW6WMsAISEavQ7ElSWLp0DHaR9S7wco1+AxXYyAiQ6+YiLeFgt5sPiRjO2mb7N2yuA==;31:+k7CfEfTwzpuPxoJT3jpSnSHlwPAIyRgiMSZ9NqGjHPMN/iGxOB6ZniqrzaDNF7y2H9gWFwJod/qs97v6X0mGuaNpAmmR8ONJCB5eqIwmmCxAhqCWdyiU02IFz+JFGpzca7I2VRqc3LtzoTHZj95NFp1lIf24N4dr+QV4X8egF2+CFP0j9uixStOsuTWMJOWW1QlKPv5HY0WrtRxv59SMb7bYjEAKgPTvTwwHCySMSs=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4660:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4660;20:8ouyH+bkkRyZTxJB5QEg/l7UrH0JLBnnXVB7BdeqhlcZVqnMO3R5cuh9vSwEDKy1EY+2jTba+/PbaImdZifgMMMJPDgKw/Q0Eh7pmHUx1WUyR/ngjiVDqtIQsYtHtKIrXO/B+GMN3gMP3f0LLaQz26kpO19cLZyWZregIImOMfxz5dhlhwBL9Y683wXQS5r88Ddgjb6mE7YNQ4BkgawDRjLyCBjzGs88DFuHS4wqbCOHzuBZb+YtWEpvTnuuzKzi;4:hRwViQrChsVJnZKwyp6nADhWBEweIRsGtFE50JeP1hVWWmQB2hqxql7UpTEI+ae/z9b6Yy/WJGepG+6R45d+5A3L2cJn2NEj43e97EpoXovbmbggB/0BUyXoi/Ywe8HRDNVuJGXAZU2u9OBCWcI9thld9yajJU7kYsCPLvynr8x9CDdrseFlrnnWUwhrN1g5WktqrrL9NOv7ho5l/9w1TrTwdnpk6A32+DT3YmO5zn0a21JamjSgV+1JFhQXGqoOpk4FN47MRhrC+AS+EIkkLRxVEDQur2vroAoCzHu6r7Wz6STAWLw1q8kdlo/wVbLu
X-Microsoft-Antispam-PRVS: <AM0PR04MB466028C03DB5A23209F3ECFA9E140@AM0PR04MB4660.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051);SRVR:AM0PR04MB4660;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4660;
X-Forefront-PRVS: 0808323E97
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(366004)(39850400004)(396003)(199004)(189003)(6116002)(3846002)(26005)(476003)(97736004)(2870700001)(81166006)(81156014)(8676002)(486006)(86362001)(316002)(8936002)(72206003)(50226002)(2616005)(186003)(956004)(36756003)(16526019)(53936002)(2906002)(52116002)(6512007)(23676004)(47776003)(305945005)(217873002)(50466002)(478600001)(6506007)(386003)(107886003)(5660300001)(106356001)(66066001)(54906003)(110136005)(4326008)(25786009)(7736002)(34290500001)(105586002)(68736007)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4660;H:iota-build.ysoft.local;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjA0TUI0NjYwOzIzOjg1YnR5bmhhaDd5ZlRpa1FqcUxlS1VWQVc1?=
 =?utf-8?B?MnV4Y3pjdHlzQTZYM09VSFJibk1QcUlEMElZbWxBTVQ2NzJoVFZCbVBtdDZa?=
 =?utf-8?B?SCs3Mk41N2FBNUJ3ajZmb1U4dE5pNVB4N3l3TldGMG9jMHY1ajFsRGJnOUli?=
 =?utf-8?B?WlFCRFBZUVp3akhJdTA0SlluMlVCUmU5RUt2VEswN3hCbHZhM0tuQnRnZk5I?=
 =?utf-8?B?dGNVdnY1b0UwLzl5VHgyLzNlMFZSZGhOdDBFL3ZUdFdESGRpUXF6bkxncmtC?=
 =?utf-8?B?bncyMzIzRkxxTFlBZnI4VDlqSThZYnNEcHJMaWpUYmFoekhBSmtQaDN5b2FQ?=
 =?utf-8?B?eUhLQmVTZTY2MVNwb3FQSVRvSFNIM01OSjhUTEZqb3RKMnlTSFZpcHVhbjdz?=
 =?utf-8?B?ZXh0d0R4d2RLUGpBcmhjRENpbnViQWp6aHVoVklHdGNVK1dyTGpMTkhtbTdm?=
 =?utf-8?B?MGxmbDZpY2t5dE5IRlcwY2kxeGhqK0hqK2MrWGdiMlFwR0lHek9yUGszL1Nl?=
 =?utf-8?B?bkhQZE80TE9rWU95NzZBTFdsOGxVN05xT2hKSm5mMjJubVAzZ1djRnFKZHo4?=
 =?utf-8?B?MmJJb2R1NmlQYXorcnB3ME84ZlFmWFdGNC9SaUE5TlhMU3lzdEo3VXViNTdJ?=
 =?utf-8?B?em1KVVg4ZjhaRFl3N2RTRFM5V0c0eE1TUDljMVBOeVc0QVBzNW5aaUlZS1d1?=
 =?utf-8?B?ZkJZT3lBVzllTnFvQ09rVEpDbWNDTVplT2ZuSG9raGZGZENkMXJ3bTV6anYw?=
 =?utf-8?B?Y0lSZHcyZjhvS0VBNkZCcFJ1Um9vY1N3SEtKZjNYTG00eEJFeVZrMXp5bEY3?=
 =?utf-8?B?cFdPS2hnM1JrVWNSMFgrcTV0YTFxbW1QditRL3FWMEhXV0REMk1ESmlzTVdY?=
 =?utf-8?B?RDltalB3bVFEdkg3ZTRvQjcxSXNZSEEvTVRocXJwa1VadEszS01nY0p5UGJX?=
 =?utf-8?B?OGxtQnBUUUJsQXNMV0J4NnhoQ3lqU00xdktVWkRIQzdOeUpYT2hKY2ZpTVhn?=
 =?utf-8?B?bElSRkplcEhHWWY4SmRVRFBpMUVmaW9Xanp2aG15cTlRbzVwZzJEVzdIRGRw?=
 =?utf-8?B?NmlGbTAvZWhydURpeG5WVXRPRG15VWMySCtXb0Fha29zVXhzMHR1UHNFV0ZH?=
 =?utf-8?B?Tk9ETEh2WG1JTGx1SzB4S04xbUt1dFNTWVJEVFhXTlo1NGlMNFF0MUx6UDJ2?=
 =?utf-8?B?R0RzRE1ySEQrdnN5Q3liN3Nackp0Q3JVZyt6TDIwK1FkamhkcERzQnowNFZC?=
 =?utf-8?B?aTk3dTFrdjdrbVY4b29rcXp3dTc4STBzU3JRaWlxS25qRVpNOFFsajNxQ3NV?=
 =?utf-8?B?Yld5dUV6dmdVRk5kYXFLU1lWdXdRN0ljN0dtOVM5RUFFUW9LQ2NXRVZYK1JU?=
 =?utf-8?B?Z2lxSEt6UEh1QnI3clE0a1hIcUNudndxVUZwczBLVDF1c2JieWlKelVWWVo1?=
 =?utf-8?B?Z25uTUE3bVRvVFd1SFd6R0p2ZFFYVXBOZnpkVkxDOW16VWVVNEJ5SnVnOVRE?=
 =?utf-8?B?bStyaFVkK09BQjZQQ1I5c01aYlZia1FtbDdaazc1TDJaV2diSXdhM0F6RDVm?=
 =?utf-8?Q?mAVq82/NiH3DcsVBqTTvnKJcfV5Vpb6BQHHuCRMSjwnc=3D?=
X-Microsoft-Antispam-Message-Info: b/tUMZDlb6ZWKQHA3agNaL+qUjv0RMavyWrDDYplf9U/Ca1fTa7KfVShRdCdkqublxdD5TbfTCTwQw/wetzVdTqPkCetE7uXHL5mFXEjKeFD0mqIWxI8Kuw1RqFf5HMNhPeHlmHKLk+X0xEegyoVJ7SBd9qwmDPTnByH+ROYK76ChGlig4rAT0nZHJlf46cpOT/0DWGLxbICPG2JG7IV/BKDV58/z5MsUq/PaGOW2ykG0ub7LxlOLp3xeTIaYCZGjt5Ewn9pTpXi5fiS1Wlc3F+nnS+kF+bP+It6a1azrDlkmPJ28pDWDgRVdO7rdX9cgRjG3BqkUIaxNW5ujxjS/pusz+VJU5nlTwxK+1/Mtn4=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4660;6:95XS8FQyg+b4EmTawdf/THG3vMTf0MjRxPQr2qcSbpmw/TQcORhE1J0Tku286xwZ5LkQzORK7HSG/XL43D0K8l338B9P0/YyYLevxmU3bLloUkRLGXwELpA9Sanky7W/ivMtMymSDIbQvnPj1m7mw1fuRO20hrZDXVu4ys75CuFzIhwP5fz2p2c8M/+lVlm+9ZQi/St7u1RairesG41NJ9ifhQIK4Myhvf1xESsV91RsFINbj59fer2jrA76KcFMnoE1uBVYOYN0Opl3Vw8QKiPK2USdU9ic4NOy230UIu1Ody3r3uXtsrvvx1+A2cHOZWiN2oPt+yWdK9iKKV6DMn+omKe1rHAtgdfbJjh1dY1gTyQADVD2WuB90ZeNF6yxcZA6aTzFNSkhP6RWzyMwgibVlYPa0EbXsLb+XKXimEouNB03oADQ0xQuVnJM3gK23RTDh0Oq5Nlwf4u3QXd2yQ==;5:h1X+vfKwuAXJMzaN7khP0nNROrxBqYcFPKrqCd3qm7/Lf1HDiqvi4aL57ditJRHPpIiEstHvFldnfdya82wPP3EVSshydo6eI1YpP9j6MeymdfRsdTk0Wc39vZPGEzDjoD7Z1R0Z1ievEJHoi9XiWEqpPvZjMgGEvMq2O17/iE0=;7:rs5EyX8IEvlCcRaWVlAQ8ne5T34OQHtxsyO9+oPIma/4407jgw0wAvuFmcgUxJgodhBDif0Lgj2tYVkcIU+lLx3z1IROUk1vXeosaXmiVJh8ZAEW8qnCc7gs3vnkawDCd5xaoT8sBw/Sb9PLI3EvX3SjHEVnYHRuhWCL/bC0oY802hRl1OqTZRoSkeyKimyeIZyu4QkUaY0T0qZxBEQzSd097i9HDQjTBvvkqSK1ZL13dSCrzTKEI10JQdw486FE
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2018 09:27:30.8195 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dab4e8e-82ee-4be5-929e-08d6245b7365
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4660
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reset signal can be produced by GPIO expander that can sleep.
In that case the probe function fails. Allow using GPIO expanders for
the reset signal by using the non-atomic gpiod_set_value_cansleep()
function.

Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
---
v2 changes: add R-by from Fabio

 drivers/video/fbdev/ssd1307fb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index ba66c02..e7ae135 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -728,9 +728,9 @@ static int ssd1307fb_probe(struct i2c_client *client,
 
 	if (par->reset) {
 		/* Reset the screen */
-		gpiod_set_value(par->reset, 0);
+		gpiod_set_value_cansleep(par->reset, 0);
 		udelay(4);
-		gpiod_set_value(par->reset, 1);
+		gpiod_set_value_cansleep(par->reset, 1);
 		udelay(4);
 	}
 
-- 
2.1.4

