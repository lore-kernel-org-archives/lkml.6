Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CABC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 948A023E65
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Ul1rbk68"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 948A023E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933840AbeGCKDP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 06:03:15 -0400
Received: from mail-eopbgr680058.outbound.protection.outlook.com ([40.107.68.58]:61291
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933565AbeGCKDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 06:03:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXD+lJnEPUjQc0tt13+OGmQ7dZd0AURZo11F21V2JHg=;
 b=Ul1rbk68x9LgKor4OxqILNgv7g5RJOTNCxN3kE0VM5B6colLAmqEoOrZ88BrHuj58evg96NHKgW6Y3Jv+OaBLScfM6MDFoM7hgOd9khNo6+nsssqEzQ17ZuxokCqF1oS10cgBxD7/OGBYrVe0k5NK5PJFH432p7NTiOunQTktvY=
Received: from CY1PR07CA0022.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::32) by BN7PR07MB4707.namprd07.prod.outlook.com
 (2603:10b6:406:f0::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.26; Tue, 3 Jul
 2018 10:03:05 +0000
Received: from DM3NAM05FT051.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::202) by CY1PR07CA0022.outlook.office365.com
 (2a01:111:e400:c60a::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.906.24 via Frontend
 Transport; Tue, 3 Jul 2018 10:03:05 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM3NAM05FT051.mail.protection.outlook.com (10.152.98.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.930.2 via Frontend Transport; Tue, 3 Jul 2018 10:03:04 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w63A31Ym024683
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 3 Jul 2018 03:03:02 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 3 Jul 2018 12:03:17 +0200
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 3 Jul 2018 12:03:17 +0200
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id w63A30GB028534;
        Tue, 3 Jul 2018 11:03:00 +0100
Received: (from dkos@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id w63A2xPd028509;
        Tue, 3 Jul 2018 11:02:59 +0100
From:   Damian Kos <dkos@cadence.com>
To:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Damian Kos <dkos@cadence.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>
CC:     <ltyrala@cadence.com>, <pgaj@cadence.com>, <stelford@cadence.com>,
        "Quentin Schulz" <quentin.schulz@free-electrons.com>
Subject: [PATCH 01/12] HACK: increase timeout for drm_atomic_helper_wait_for_vblanks
Date:   Tue, 3 Jul 2018 11:02:12 +0100
Message-ID: <1530612152-27555-2-git-send-email-dkos@cadence.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1530612152-27555-1-git-send-email-dkos@cadence.com>
References: <1530612152-27555-1-git-send-email-dkos@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(39860400002)(396003)(2980300002)(3190300001)(36092001)(189003)(199004)(316002)(16586007)(42186006)(105596002)(106466001)(51416003)(76176011)(36756003)(54906003)(186003)(50226002)(110136005)(26005)(4326008)(26826003)(246002)(8676002)(356003)(5660300001)(8936002)(87636003)(478600001)(7636002)(7416002)(305945005)(50466002)(2201001)(426003)(48376002)(86362001)(6666003)(11346002)(446003)(2616005)(486006)(2906002)(126002)(476003)(47776003)(336012)(921003)(83996005)(2101003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB4707;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT051;1:ocNW+cdYmbvvGIRapIJLR5VNcJ7itB3MtK1wb3P6iMwUuBmek90wPIB/N4iTAhULpOQOO6IMxtse4+5F1jAg3N/u5125zNMqFW0FGZ5ZxXHaAfnGdimCNmxmSNBdVzmj
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cdd92dc3-58af-4d8d-77ad-08d5e0cc2baa
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BN7PR07MB4707;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4707;3:ye3JKpms/xtFTmRFOYsE3u2soWzdEXa/DwPQ9JZOY3NbkD79eIBbDfswBEapeeyfnbEdoQTec3fwbaGVa3psHULVMlV8L+DEua6L4VYBFi/8fAYNOgACC0+D0E7VclyyodklsMOJzfjQqUAYa/0jSycVfmvay7Xz1LMuqCZWTemtc5wVXrqO0/3iNN+LNm+fpHrED0XczkJ9YJfFIQ85dwa8QsdpSqju0aJQDB8+xRQVMpEQlGtDmrrL0QP5TRsBrKRtoPhoWcgAycGuwF/x1YQZdBh/DZMlbi9ePipdnNdVcZ0IGcbT2s2YaNA5APt2ByYD4CKQUMOAkn43KCioUoZAMW9TSjVc5U1VgUvl+Xk=;25:Iheudv7bJwde+T89fy+XqR5EV3x1IxSK7xzPJleIQKtKOJN8LE1T+Ty7zkaRgqwXVEyFCOAxFavW8Nro7hFJgEQgasBbHvXVRnNgF1S4en+IugOPneLRYIMzZdVXGZc8ABiNFu/twQOPhB52Qv2Ga65ftv0DH4dG/yqdG/zjgkb8qt7aXVXJSHfODtD8H4HWy/TFpPSNrpP1imdmVwF0VFfqRhyutfXqHJaSs6Bc6spqmacTcfRg/vjf/5EZZIqclCMSJw4VtnFfsbrajln8A3SfndyvPr6Zw5Cw7xMurgP+VOf09wfUdHSJw9yZMNrGlAOucInpijFt72suKwcTvg==
X-MS-TrafficTypeDiagnostic: BN7PR07MB4707:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4707;31:EVlZqFSHMYQxPitl3gV4DudcIANXQ2NAo8jcbusTnd/HRag6ty6lsxoUAveISnrgr1nLfSv80UU7DJvZuNK0YsOYxr+vLUd/5YfG95+p0fANzuO2SUfL2MR5T0R0TipF2ddPXajVeagqOuf2h8SeyBDOlKP9Fj6rlj9/y6GNkw1bPq0xO6W33RB498TT3tNyoqTAQYzkKtxxdzXnC3rnA3QEO4S1tPl8e5QtNTEYoAs=;20:Ta9AKWS15WGFYiGYYH/3ymNo9jXskWA3Kb/blD/uiPOCTxDDz/yS2nxTildEhxGnnvAU+QKLAskrJexldSSCMtqiuu7m5toRbi1DM2aJRKoeksFa+6BnY+OPFRzVWem4ujaz/FSF2rQTtvQ9tRBJvle5E56wTUy+KWWFlE3TB0lWuIUjPikH8Ehq+Li6RD5/vP/svG8B3I7VIdu3wgFGZUBmKhzrd46dvKtyFv938hkIh/ij6a+D8+SYJZOG4vmZqCWXwOA1caiOi+N53xp9sSwIlMsJl9MO/EzeUPCb1lHDrE6m0a82JQ9m9KeFLzfMuLsZ8MOWZVT53TP4/a9H3hIXCiSwdY9ocNryOE3CAZXNBRC0YgioGtlxU7VlVEz0swYr/2Sv0XqTEgOZFV/XxOOEYQWBtxufEfDn0XOuBcLJ1BVJckKqwomJKRlmNBEwdi9298wKPTeSiVOqskgjaMRaN2zRi7Rl70W7a/gOuk90W7fX9YCyQbhUS6W/Ohmu
X-Microsoft-Antispam-PRVS: <BN7PR07MB47070146C0BCB6F18B359DDECD420@BN7PR07MB4707.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(58145275503218)(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(3002001)(10201501046)(93006095)(93003095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BN7PR07MB4707;BCL:0;PCL:0;RULEID:;SRVR:BN7PR07MB4707;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4707;4:K816rGReQ8KzhdF0x+ClxUeFPPwaXpXLtqPmvi+L/OlZu7iAW0Ozn+J5Suhyo2M8g18RQaB0pcVRXCnDBG1D/0bVNdHdtrdEtZ11prbmlPR2qcK+MHxSWabviL4nUnB+/xt0isGkPCKRzNpPRK5qlOXVBiwS7zQoZxA2qI8CIDt6mdYx/QOuo4CEquHEKqcD07EMMMQbd36hSrmb05mne000w/dJ12hc1ZEGw+fekxRX5ckaD0RTbL406FTIOZ5Pm/B6AAUUG3ubl7s/vkZu5R5+LUyBPUHQ5acBSjZN6OVsX+I+9IMS6H4ZAenZSF1JCluHV4Gm63+LaiGeBSxEYxzZwsIBJWuzXfKugONgs+k=
X-Forefront-PRVS: 0722981D2A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR07MB4707;23:586ArfL7+fWqv/Pk4ZUt/1GEy+FvbOufqIjxRbJOy?=
 =?us-ascii?Q?hAe2FgrraSMfHmcLG/FQHvqYJQO0XYYKiRfAYwHC4aNsQhWdq2GKt3+Qumer?=
 =?us-ascii?Q?NYrZ8A1bAzf/EtQ3Y0jC+B+/GUKhwAC7s46VTT3ijRvndeJGZUquIQRy5D90?=
 =?us-ascii?Q?0DQhLwFb2kjnX+MjBeVcg4lqM1GCLv0vC6hsgk8viRIIpLB0T/5z7dlEg0c6?=
 =?us-ascii?Q?LW0ohGDTFavyUBpwm2lZYryVA1sqpu1RZc0K/1zfIOudmD4/xpe2BhtCMxhK?=
 =?us-ascii?Q?fkxUvLmsK33GRNJfJzjR7m1rzB/cBBBNVSNB/JiuuygrMIYiKHaUbjvFffsK?=
 =?us-ascii?Q?vphCllx05h+sANJzm40aoiA0yhXw//hqqSnUSWpz9zlL9md29qmxxmq79mwr?=
 =?us-ascii?Q?D8IwgYp5VbUGAQ8vaTP4jOWYzv1oQe5TmSePuba/EXH/DWhxDadiGTO1tn4D?=
 =?us-ascii?Q?4j8D21GcGmqnJlgp/3jlAE5R+bjaYkGosxOT5lqvfownxHj/gMEQaqB58qQD?=
 =?us-ascii?Q?OG7rkGMFCYQ7CLXOrsldU4nKs7N3f9SspmvH+IyKBcoOlospSs6TH46xxunM?=
 =?us-ascii?Q?uh8AzZglEidVTz4ndnSd/3FXeaogRCQsbDBz4Dx2eOxkkSYhEH/AvM7cFTjc?=
 =?us-ascii?Q?lS5VMHExXbRZiXlpkohqI9RABgFucZfC1+JfbGFnjMLvZb0ebLewqlZOdYtD?=
 =?us-ascii?Q?j6jjCh1zMmvKbGHPDV9pdwwneEkE9xljQLCwnwvCJVN1+F8r6Egw00rWJgE1?=
 =?us-ascii?Q?meJD2AjtIRxhNaN0khCXxLkVsDggyoxYNcZu9kjFLHxxKdc45sPTPXOSQYnE?=
 =?us-ascii?Q?A4TMqy1kF/srUjPYTBylwMK+Df7GKfzYLhaZ5V6Ja7FA04GaTf/HtkIt2p1s?=
 =?us-ascii?Q?of3+07Jppxs3JsXQtwTx3wpQ85LqqJ2RQt0ndYuWTipCtfp9/OdTDBA/NyKC?=
 =?us-ascii?Q?DgmRSCbQ4Q+Gz1P2pE0Sn7ql05BGILgEReCiHSjQ5Deun39puv3cfLhRkbXU?=
 =?us-ascii?Q?GR5pPVdEtACSCcjBNHV9rNdanxIX6SINlZWSg/NFuECWoOlqn72lxXmAJuDh?=
 =?us-ascii?Q?PM+EDi85DgtcgY0PynXHyqYEuVQe2SL5/NFeEo2JMPMPBQwvr6eoTY6EraFB?=
 =?us-ascii?Q?Uh+Ti4YLwCDLwep+IU51/RL2Zd69Dskss0sKrOWgFGtxu/PXao37TuqoWG6j?=
 =?us-ascii?Q?RIZNnspqF8XrBs=3D?=
X-Microsoft-Antispam-Message-Info: JPz4rBTzucpPIOoE7WXfJdUXbQuADcmq5pTLovCN9/M8cwwWe20gfu77O2RCzg2KPA/wZ610pVJRb2x4EDMAXhViKZ6aG05es7vlBKld3hG38lFeBYV/AOX8ZurRRsPZ4Lqm6vQvUL8HxT9uIZd/iPV73Mp39Nc8vOifxHdWT3uqFfBVEA3Oatt1fZn+tAeD9kYms/qTV6a25jMsAkpwtB7SOyTH8/p9xF9Hb+rGn5udMr6gZfI7Oad12c10XXasZACC/VgJ/IxRC+HgBrty4Xvadfxg7JD/bnlCGAR255c3N/ECCNonkAzhn78Ctaf7xF6+lLeTfK/jcoSuMRLudwAoN7DcFMDFvOBJ43LU4rpdtLRgVgKNaHwKRpMCJ0hpCHd0+uZ/bp1xNKCQjnmMdA==
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4707;6:kfgxycoyHON3sgUllLzSf0DHJ4hkCAK8fuGFPw+k6RozgGH7w7HBodZjZLcGwHKOswD8d0TZ2Dwmz/lqqh1kMvq59TebmMSTQ8BOIwYRQ69zQET+QvJsT6rGfdkhbQqV9ckVf2NbigVGbFAjh6kSWTnLewhMX2ZGfSGc11+36tMOZaRDuFYUhpv3/cUVz0BTi+p2c+/GfKYzbOJutVsYl7F3/HR+9leYDAGv1wEmXSQ9fzR2TVmD8iYAqtA/zwnRI6crPuWjUAHkSRQoRcNWCvjihvOzLMwAfSSz+Reu97dxuOQThl+WZ6Z2DAAhtFrQZmLX01uxqiSSS+Sfx5a0wSPJPXMDb3hmfu0x8T0b5CjtGDq0reLGc27bP6D0CXG2ztFzuK8zKIQJoYTuiV1MqHXyxNly38i00CH8RGyINLFVJWCRoxtXeSdwFW8ngbObHWFZTcd3qePUAhPWo2EY8g==;5:SUdOaprmBu9d9xJ64Q7xD6eowmbN6bif+n2eUUF32H9XOBLqNQxDDQQPQ6FCbfD4niHGoTOVeRfhSj788HWeEwbPQam+W+pMX8SEI077NyN44JdiWuAwMoBmWIVdl7y7wsRx5uuNSOyY37QWpMzcytg+YuCQzqmWRnH+nIoGLbU=;24:SSFhTXLa61PcOCyeWbmiOs+aWAzyELFxUb12+VD8g2gWsWEP+1auoBFRVMC51peCbcdBhQAvJ+uSv6iDlN/EpdjXqN+IQvX8RbwxoMjJQbI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4707;7:7kOFdmnTU5e0J0gwTHIYOsBtsvgNwe+EWVDgSAvwXwcWxKXkqb8YUdQOO6qKxMhKL5fu8EUclG4k7XGax27zI1cp2cmin2dmTuMaJUta60vqegKesNs+EtqLmU4l4dFw4LfBwcXBHalLwvoQzBPC852oiLKiX24VQOMzS+H5DifhmD7f6xF2sYk2rC3xDsRIrnhkrrKhz6fh8qRLdpGee1W2uZci9nrG7qu45BxnLbUiGVHEgSmmqEPBYrP3WeR2;20:E2NvS68A6Qbn+NuFXkr2WWG6QqSZoPXHDnVx8WoA0o6+aOuyZSyBXctb8ZCSHEkdsLbJYswgq9aJKqX2MaKu2K4BikbjHOLpVLahA5ZU+pIkCOFJMRvH9TeoYR8SyaazmJpUx/gXwkpqs7hPiNhg7sLxLtSDO5GkaCs5vOthQtqB4WTLHCXJnxr34Z2pQYuf/jDb9KkxLBBdZUlXejVzzEwTThtd73+/NBKmtlv+hTP0uk7SY6zOjPdohMgcjqyZ
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 10:03:04.6616
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdd92dc3-58af-4d8d-77ad-08d5e0cc2baa
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4707
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@free-electrons.com>

Due to the DP IP being simulated in a different and way slower way than
the rest of the hardware, increase the timeout in
drm_atomic_helper_wait_for_vblanks so that we don't miss the vblank
event.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Signed-off-by: Damian Kos <dkos@cadence.com>
---
 drivers/gpu/drm/drm_atomic_helper.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index c356545..0171249 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1345,7 +1345,7 @@ int drm_atomic_helper_wait_for_fences(struct drm_device *dev,
 		ret = wait_event_timeout(dev->vblank[i].queue,
 				old_state->crtcs[i].last_vblank_count !=
 					drm_crtc_vblank_count(crtc),
-				msecs_to_jiffies(50));
+				msecs_to_jiffies(4000));
 
 		WARN(!ret, "[CRTC:%d:%s] vblank wait timed out\n",
 		     crtc->base.id, crtc->name);
-- 
1.7.1

