Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D057FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FFBF20881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=landisgyr.com header.i=@landisgyr.com header.b="TPLmRmCX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FFBF20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=landisgyr.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731699AbeG3PhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 11:37:02 -0400
Received: from mail-eopbgr10109.outbound.protection.outlook.com ([40.107.1.109]:45246
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727045AbeG3PhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 11:37:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landisgyr.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Vq3gjwgMs/OaRsv3qs1gIiUQa8TjIGrktLa6CRgqxs=;
 b=TPLmRmCXFZC04/hU/z2/6JwrNOz10JifJrFb+dip5EI+RaACOfhWfltW4Yqx1KpjP6FReSiJxOBLNGi35fhzz/nADUF0oHDkhcr0SCLTZw06ZNdy7acoX68/3QlABMGLQRl4TTkltk0KOB2A2AYpAceRBYZkXq7ItK7Ea3Fc8zQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Onnasch@landisgyr.com; 
Received: from CHZUGPC352.eu.bm.net (80.239.165.1) by
 DB7PR01MB4265.eurprd01.prod.exchangelabs.com (2603:10a6:5:2d::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Mon, 30 Jul
 2018 14:01:48 +0000
From:   Alexander Onnasch <alexander.onnasch@landisgyr.com>
Cc:     alexander.onnasch@landisgyr.com, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net/phy: Micrel KSZ8061 PHY link failure after cable connect
Date:   Mon, 30 Jul 2018 16:01:27 +0200
Message-Id: <1532959287-360-1-git-send-email-alexander.onnasch@landisgyr.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [80.239.165.1]
X-ClientProxiedBy: VI1PR0701CA0046.eurprd07.prod.outlook.com
 (2603:10a6:800:90::32) To DB7PR01MB4265.eurprd01.prod.exchangelabs.com
 (2603:10a6:5:2d::30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b840737c-844e-4fc6-f111-08d5f624fe39
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR01MB4265;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR01MB4265;3:KnQZN0ARTT7frDXcqUMWFpE55wPmdF3tbI451XpsxN1j6IVWoYimvo7BRSwy47WGE+S2OZHLDZsZD/w+mJGEuEFZeiO+LogC2a/UYB9U1sZltNgsbMoHYIdeBgL6kcbunxFZNlH+rO6shQkK4cw/dvDEDAUtSwtG7iuGOAOj1S2sEeakuavXMozNEbS3lsdsyjZlHYQTN7jEuDxb5w+755b+hvpJURni6wyMfhoF5E+YXidEDFNditzuO29ZLsVU;25:kpzaocT00KD/epRzsVKFw2Ziz9GjT4UFikk1SMrxey8Vwr8/ffgyBeWk9L2OfjvxedJEWwKgHxnL5/QcL8UA6Y5Zw8UnfsQK72TjiwFDcehjKiwcByHIcDsdeFr8Vbk6zpl8YT4RqWaynBvdgYtfDM3kN4N9CnhxbiFmlsAtD38T5xdgVH6ikZ3kOepm9GwySFgXtKY/Q+VnDfpAUYjQ6It13OkLsbgiB6CGdWU81RQ1Yb7Y2GCS5fsSGmkPLHEweXOKR76Nobl7x/N4Fub5lBUu++mVz2BRP2c7AtseWsksh5zJfOkHJs1fj6emLJmFes+cFHAs3N3R3FNBrALAGg==;31:bzSTSLEQq26gmM842AbrewXGXZ2itL04KPmYt0Kj7pO1YCXxbH7twawa4lIayz4bVbGrkO0L2Ikkn53+oASrUq+4ARCNzjMF0y354EXdCuBhOqlz5JcapYk1tq6QuumboDUeqEMbnFCk4vBSAhCuYX82egMYJTUawD8XN+7hpLyboSfhxPfWKqP2oM2jmq+K+1d9fppjFAzAJ4FVFgpZlmDqAzMQaYAcScfEgJpen5Q=
X-MS-TrafficTypeDiagnostic: DB7PR01MB4265:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR01MB4265;20:foPgXZEDU6QC7ZlVr0Rqh/7wMaMoF8agqcpSvDfvsYm74/3PP/wkfE7NVaAn5z79ctSBcYgdPHDYKeHcoHbGI0KQV70XNtGRLgOghLottRMAkL6ESSfbmNImuA5lYAu1bxDuQeewiC0p+bz7KT8SIySMTm4DarudTrTtIAUHlhGTGK00C7ikXlINoP+tA/gg7uQy2FGuCwABZbeYa/Lhvz7fBiadzQ9ifaDz/zG+yNEqqpo8mCPwX+NcfXSk/wjAtNiols2ydN6HtjR467T/eFiWzp0S8W2J+XDup2wz3y25a2BY813FjEq7ddMxK/Mty6wavcK91xxS3m/GTIzlm4ByMNxyka6/aU0rGHznlDTT3+xM06TAubfQjBv3VemX8QE4NeDDtu7u0fBUEsLpWPAQ2eBBLUm8LKjp8jjCjwRzUwFGPNqR0uAMmlzaGBT/ZyJKNjOgV+zA+P0Ex2Dz0uhAJbKg3zTiN8XpZJjtoAgV6NH0hAIN0+nR9g5I0UlC;4:yivvNUw4q2mZm4FALvb3mTqHRq18awUIck7gEYKu/PEzqiRVmcsBQmwflgxcy7nVj9EkohRuPdBQKz/omAqW1mAchJ0nHkO1sgZaKyVbzUOaxKnb+/9r2bpdF4m0k3CRixKPGDGiFLlrAnXFJcdr2HfZp4JNupolamxlFzxkacbvEcCoNlRLUR9XcrT+Ziw0spPPEtuvsaqIdiF1IKimLnqKoZqjYO6+LEMOH1ZxFpYqeyWCn2xGoD+ucyD+g7Oqajb6dZZ/kzXnrg24MSESDtFs4zDYRefzZMVbnQ5MI0wdNiCxaPO71Y+hoYfHn60kLGulUahGq+uh6807kZFYL+lZA1zSF/hS3Yx1HC+rUys=
X-Microsoft-Antispam-PRVS: <DB7PR01MB4265F8FE10A6856CF00A29C7F02F0@DB7PR01MB4265.eurprd01.prod.exchangelabs.com>
X-Exchange-Antispam-Report-Test: UriScan:(144836121648609)(21532816269658);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DB7PR01MB4265;BCL:0;PCL:0;RULEID:;SRVR:DB7PR01MB4265;
X-Forefront-PRVS: 0749DC2CE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(136003)(396003)(39860400002)(189003)(199004)(39060400002)(25786009)(2870700001)(109986005)(52116002)(4326008)(23676004)(5660300001)(7736002)(97736004)(305945005)(316002)(106356001)(26005)(16526019)(81156014)(81166006)(105586002)(8936002)(6506007)(1857600001)(3846002)(6116002)(6486002)(53936002)(6512007)(478600001)(54906003)(68736007)(72206003)(50226002)(1671002)(44832011)(386003)(6666003)(8676002)(476003)(2616005)(47776003)(14444005)(66066001)(956004)(50466002)(486006)(36756003)(86362001)(2906002)(266003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR01MB4265;H:CHZUGPC352.eu.bm.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: landisgyr.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjdQUjAxTUI0MjY1OzIzOkk2NDJlK01CaElBYy8yL202NzJ6Y1dvbWVO?=
 =?utf-8?B?M0JIRUsvb3N5SU9ZcjhoRXNZWk95czJKa1owOHR1ZlQzcFMzbk5hRUNEZVpE?=
 =?utf-8?B?SWQvQ0ZjWlQ4alkzNWd0VzBjUHJiNTN3K1Y2YmZrWTNrelpZVHprNHVTK1Rs?=
 =?utf-8?B?TW4wR1Jra1kxSGVESjVNSXkvR25PaExjaVBXSGpEeFQ3N1pFSHZSbndjOVNi?=
 =?utf-8?B?NWJ5Vzh5U0gzK3pHYzRINU1FZVhscGZlT25YK1E2VHZhMFFjeHFEaEZwZTli?=
 =?utf-8?B?QWlyWUFCajg0eUY0WHdZcysxUTZIbTA4Wjc1b0pROGMzb21sTHRvSVdBQWJu?=
 =?utf-8?B?OFZQZVZRM0tRV3AzL0cvK3l5Mk5QRVJpY0xOR3VhY0daT1FCMEc3RTBLWFlp?=
 =?utf-8?B?QS9QbTRhdTZzUjk5WVJmMWtMbWtUUC9uNVBTMldIVnhCZXFab0VYVEI2dGEr?=
 =?utf-8?B?SDNyeWRKck1pN1AzbForN280aDlGWW9JZXIzNHRYaW05SXNDcVpOQUtXZnhq?=
 =?utf-8?B?UGhRV3R2SHpRZW9UWmd1R3lpVlgzV2hLTWF1K2o2VzU2dXU0THlGTXhpRUdh?=
 =?utf-8?B?eUErclBKTTVtcXU5TlN0OHVLNHpBZFh3RFBvZlc0Q0JmN25yNTc3REg3azAr?=
 =?utf-8?B?eWJZU2FnTjlMdGF1QjcwZjh6K0Zqa3FKWFpLQmowdzNiSEJuRGJxRlYrc3p1?=
 =?utf-8?B?blJhY0dUWnhiNlphY050NkZIMisrdnQ0MWp0N3ZEODl2NkJzM3NGUjdpZkhU?=
 =?utf-8?B?K0JRNlNTVWY5UXV3dlJPNmhQS2ZDbk5NNnFiYTVZYUJjK1d1RUlhNlY4MEls?=
 =?utf-8?B?VFhjRXVBUnhoK05NMG11ZlhpZlhUQUcveHF1aThlT0w2MW5TN2MwN0hSQ2VK?=
 =?utf-8?B?b282TFREZFhHRHFqNDE2ZzZBcm5Cdmk2QlVKNis0TGk0S1ZSaGRQaTZENDFS?=
 =?utf-8?B?ZWtnbVpNMjlHcmNPTzY3WU5pd3J6UWNpVis3VlpzZEl5azVIRDFvN0cxZ0hQ?=
 =?utf-8?B?YUsrQ2dBa3pmaFU0WnU1VjlBNE1WbmVxVWM0dFBhalZOOU5yZGFPUVFtREI4?=
 =?utf-8?B?M0hyd1ppdVVxbUVka3pFN0svV2p1cWNmTVg3VTVIYXJGdnpKWXdlVWJ1MFZy?=
 =?utf-8?B?blNzdkxNa3FBVit1Y1BIamRxSTJmb0U0SEhHcnhZc3lrSlBtbW9qT0o4cWg3?=
 =?utf-8?B?a1B3Nk5QbTNCSnJxOFA2ZGU4VDV5bmdoOUtBdERITVBFVEhYdE1HaThYeVUr?=
 =?utf-8?B?TW8wNldtN2o0VUp2WXQxeVZtRlU5ZnRRRmlSOGtjTFMyL3NPb2tXSmE2eEFX?=
 =?utf-8?B?WTdockd1N1EwWWI1R1l6aWVqc3ZHZ0NUUlgxUzExc1J0a21YbFd6T0JKclA3?=
 =?utf-8?B?dUZHOFY5Y28vUUN0Qzh2ZWw3QWJPVnBmam03MjhScU5QSk5pZTNsVmJ5VjQz?=
 =?utf-8?B?Zm9ZdXUxTk1aU2RHOTZiSkdacmk0WWZTbUJTYVRybGc5b3dKWUgweXk4dGlw?=
 =?utf-8?B?QW1ZSTlWQ1V4aGoyRmdBbEloNlpPL2RKczE4V0hJbGxWOFFlZnMxTFhyUUhF?=
 =?utf-8?B?OXkyM0pMQTZ4TU1DVWpYaGZuYnlMWlhTRzJaOERFRHVsS2tydVpHUmY3RFBF?=
 =?utf-8?B?RENmSHBZVDFZYUY1bWJEQThuZTB5TDg4WGQ4S01FVTE4NnJManJQRmVzbnZK?=
 =?utf-8?Q?Bi3Ut4plAdrrDr8NV0=3D?=
X-Microsoft-Antispam-Message-Info: heioKEl/98rrrxKTzIyznHddoA+PInzJHPY7bzhznediYhxeH8+L2YChRPLDQUXpbeCHHOG1duX9l5vEFEgVBAW5JF05O6kk6ov1LOBTo61iBriimnjqz6mDaw2VqnsXG2mN+E9SoEWhVEIZormdm8SeSuzMfD0apOi5QilCTskWviYEhiyA6QVjQRQWhX/vxj8kpWiHA04yqAbON+hSwiLKmjaC84uvlKDaa8/qk10kwNp1ZeqwSUwPDB1SvZBguiCGpFgIw2YHpRR00MN4RU74P6YVw5to9UUv9aw0qasXGlDUf44n2C/LHJC6qAPxwtw2AQ74Esy5hC9E8TGUpBt/Uq6TVqnpl+wDqfRtxyM=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR01MB4265;6:UfpMV2UBboYMP/pfKnzZJxL1N9aiXN7n6IUYnXT4qdPQegv4ajWs8FGIPyasxRRFsobpRnQ8/IT77M8p6Jb6XaF7XDPQDo6vViy+6npjn2r+6LWFumlsvnCnEXjq5zvBjGWZVmYI4jZ4NWDUPAnOnwmYXj6VknYcLeLcP7QATFxpB7k1a6qFljUU4FSvPV24IAxq08ugIJv8+qQ/rtK94bT8jMrO9rW0Sfb0G4ZeFQRS0PPl8sWLbOI3GmNFxxUA2blJgJHZgxiSKFZ2kABVumJACF+J6U9/Aw1akcPr9S9EazjGH0kGgFf7ZYsuui+aKH9CT6rHHnOGvmYam70H0dgjAx3tv77GCN+LR8l3eH/kTP1TgoPtwuxW0NuyOB1az/UcoUkMrECNgD6UCYWSMvUWkFo4O/sIUEOXbBd5RpZPs7xFrBpzcdvYiNQdsED8Kc9MNZCuDi9uy5a6OjWLIw==;5:6R8eSgl8+ygWCl3Tpt95vK/e++8I5h7syYA0AHne7Cj6WII31L56BeZLeqXSwUfNxJ3iaiLNswRerEOv5IsnkDjCwGiyFWZ/mwZyFb/Zf5z0K2zbAW6zqh5TX/yagjigIX/8BesKSbYTM0KB0U/i1x7by5JOXXQZ4Fq/Q0/vuI4=;7:qo8xIvxGuISp2JYQzdDwhUUfPbkIA19OUJ23mdLIEit7T8RUwPQEShrVwGJ08uClQN0oq2pcNqUYOtYGIMo+xD4MDh81K/Mt8RSTknb+D5ArhTUecLt4EW4/ZjE+ZaCbasCrTzOM1xLJGUPzbrAeHNTcllnSHtgxAOsq0dwDcKZsPoWu2FoOplKbISe6++6fYQaqr0/2qh9qvD/fd4GZ18RI5s9SkjgfAUrp01b9zmCQm7SIrLnUBThmIEUkVT7k
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: landisgyr.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2018 14:01:48.3226
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b840737c-844e-4fc6-f111-08d5f624fe39
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ee2cd48b-958f-4be4-9852-b8f104c001b9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR01MB4265
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With Micrel KSZ8061 PHY, the link may occasionally not come up after
Ethernet cable connect. The vendor's (Microchip, former Micrel) errata
sheet 80000688A.pdf describes the problem and possible workarounds in
detail, see below.
The patch implements workaround 1, which permanently fixes the issue.

DESCRIPTION
Link-up may not occur properly when the Ethernet cable is initially
connected. This issue occurs more commonly when the cable is connected
slowly, but it may occur any time a cable is connected. This issue occurs
in the auto-negotiation circuit, and will not occur if auto-negotiation
is disabled (which requires that the two link partners be set to the
same speed and duplex).

END USER IMPLICATIONS
When this issue occurs, link is not established. Subsequent cable
plug/unplug cycles will not correct the issue.

WORK AROUND
There are four approaches to work around this issue:
1.  This issue can be prevented by setting bit 15 in MMD device address 1,
    register 2, prior to connecting the  cable or prior to setting the
    Restart Auto-Negotiation bit in register 0h.The MMD registers are
    accessed via the indirect access registers Dh and Eh, or via the Micrel
    EthUtil utility as shown here:
    •  If using the EthUtil utility (usually with a Micrel KSZ8061
       Evaluation Board), type the following commands:
       > address 1
       > mmd 1
       > iw 2 b61a
    •  Alternatively, write the following registers to write to the
       indirect MMD register:
       Write register Dh, data 0001h
       Write register Eh, data 0002h
       Write register Dh, data 4001h
       Write register Eh, data B61Ah
2.  The issue can be avoided by disabling auto-negotiation in the KSZ8061,
    either by the strapping option, or by clearing bit 12 in register 0h.
    Care must be taken to ensure that the KSZ8061 and the link partner
    will link with the same speed and duplex. Note that the KSZ8061
    defaults to full-duplex when auto-negotiation is off, but other
    devices may default to half-duplex in the event of failed
    auto-negotiation.
3.  The issue can be avoided by connecting the cable prior to powering-up
    or resetting the KSZ8061, and leaving it plugged in thereafter.
4.  If the above measures are not taken and the problem occurs, link can
    be recovered by setting the Restart Auto-Negotiation bit in
    register 0h, or by resetting or power cycling the device. Reset may
    be either hardware reset or software reset (register 0h, bit 15).

PLAN
This errata will not be corrected in a future revision.

Signed-off-by: Alexander Onnasch <alexander.onnasch@landisgyr.com>
---
 drivers/net/phy/micrel.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 6c45ff6..eb85cf4 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -339,6 +339,17 @@ static int ksz8041_config_aneg(struct phy_device *phydev)
 	return genphy_config_aneg(phydev);
 }
 
+static int ksz8061_config_init(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_DEVID1, 0xB61A);
+	if (ret)
+		return ret;
+
+	return kszphy_config_init(phydev);
+}
+
 static int ksz9021_load_values_from_of(struct phy_device *phydev,
 				       const struct device_node *of_node,
 				       u16 reg,
@@ -938,7 +949,7 @@ static struct phy_driver ksphy_driver[] = {
 	.phy_id_mask	= MICREL_PHY_ID_MASK,
 	.features	= PHY_BASIC_FEATURES,
 	.flags		= PHY_HAS_INTERRUPT,
-	.config_init	= kszphy_config_init,
+	.config_init	= ksz8061_config_init,
 	.config_aneg	= genphy_config_aneg,
 	.read_status	= genphy_read_status,
 	.ack_interrupt	= kszphy_ack_interrupt,
-- 
2.7.4

