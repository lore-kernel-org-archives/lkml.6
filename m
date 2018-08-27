Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4538AC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ACB7208D8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="vHdl/SUU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ACB7208D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbeH0O5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 10:57:23 -0400
Received: from mail-he1eur01on0047.outbound.protection.outlook.com ([104.47.0.47]:51613
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726809AbeH0O5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 10:57:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4gBk1xqqNJfHISDAm15pKgA8JH5dKyDeDRjeh0dLLU=;
 b=vHdl/SUUM8nVbZYUkS/R49BPhFzHQaiUZ9WhJugiBgXxDt2KzAJXRxNmPAA8qrbzHjs9H0kTEZJpeemTqKT133P/Vfaa0shsBloGQEPzL9zpJobKV/nju9ulxAGsoMNnewI8pBBLLbLLAtQ3UYSF+1qfvq24T5WXdTECOSLCdOU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 DB7PR04MB4297.eurprd04.prod.outlook.com (2603:10a6:5:28::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Mon, 27 Aug 2018 11:11:02 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Marek Vasut <marex@denx.de>, Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Stefan Agner <stefan@agner.ch>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        David Airlie <airlied@linux.ie>,
        Robert Chiras <robert.chiras@nxp.com>,
        Marco Franchi <marco.franchi@nxp.com>,
        dri-devel@lists.freedesktop.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND 0/5] drm/mxsfb: Fix runtime PM for unpowering lcdif block
Date:   Mon, 27 Aug 2018 14:10:36 +0300
Message-Id: <cover.1535367027.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: HE1PR0802CA0012.eurprd08.prod.outlook.com
 (2603:10a6:3:bd::22) To DB7PR04MB4297.eurprd04.prod.outlook.com
 (2603:10a6:5:28::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80ee3096-7d60-4d9a-f645-08d60c0dc7df
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4297;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4297;3:weEo7OPIrx1lWdcZ/lS/Ky6X3jAaxz/vpkw5gV3zvavPaMxNjVgQ+/oqFfvGdLxrokmzJNipiWXPEItwYABwcQT3YSztiAz4P4ceVhTN3BmF+au9nE66/GPfDaqkJrniqJqOx0YB+sSNxvC6VXIT3eQGL8RaEdpXn5p4qYsBl/T3qCbi+/I95kP8NpvBdV1G47Q2GcpWujSN6U6Ap5rmxEOcreOASBBfMDF9Ac9Umzen0QQzmQWnczrrkNXxy0hO;25:19NJ2pmwq95MzAMdhELgVYH/nyAPbTqcov2063L8yfjeNxW/S8khuCILmmSWc4tNlKxSnL0xEn5AUC1qCrA0nEQYSJAyMkWhvAjq+Tl2ngU8T6212vQbD7r5jwe4kM6JnQw/sSTVEyf9DWFqN/tZI2orIEojhfHUuKyoeIIy3NkP3Xb8pdrvKG/D6pQVgaRm4lyqBPRBKaFoF7bLEJ8F3cjOZZ/BfZ3i5gYeRrhfgQHYkGQvEMKp8JDQz7but9bQ54Qw0xbW9v8QmOL1IHeDGpffuwhvLq2BaaD6pZR/DEC171xbe0s67XkPg4nCC/bC703+XJtkEK/x3IaSl6ihOQ==;31:gsT7G6cnmlPYMDXG4+ncT8wcSHDlYU9BUK+bl/dhefrVOi4ejngG205WlM//0SF/3WAVHMKP1/xZfFd0yJ5cCV7WfIuyvSnjVFDZl/JSjsK56s7cFp2g6IyPoY/70I65QxCs9fwAAlN5Vssrk/TSgpMei41KuPs3dRckSap/dCscYpvYS4hnFv9Po9S4ubPzQAg845HC4RDzXCrgIkXdEeYehZZrosvwiztj9JFfTIk=
X-MS-TrafficTypeDiagnostic: DB7PR04MB4297:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4297;20:NY6UlOp2Jy80dNaGA5fcTeiRQlk0unbysyvIONyDHETRQYFCvFApzaToOWRUuYM6Ph1IObLVoql9bU+GwMFRIa/Yzg24CZDBAkQE2POQCclVZyZCCXWv4B5jIX+ZD5bRdHtmKD2p3ViNgASHXn2LKxKgPMzl8XUAmfD/e7mY5sVgYjHzXJhhy8s53wifrdejXB8Nnf1WtvRV/HaJ6tnr71hodpgs1TqA3m3T2EomiIAoEemnn84q998/3e2PcFxni/AwuY8psrEr5/F9wnMq5AgTHkId6Gg/iRXRqgmVqztgo7doKCkUl/94ykYZyv9IPqjJxizeHUkL+LzmeYfjhyN7SNENVDxq1E42qcv6ta7cm4LlJxaZchNnciDII3xGVAvgeITVsmBcNKYIeB/merpg6dH3cCS3M+F4rM/uEL2Q7ufp4ynmJUeWVi2x3iM6TX6H0GLnd8wLax+O+eBudRm5AkN3xi2pAJvCb0zrE8K8SzgM2v1ZMdLv51G5tLdr;4:zbUNmJo+7F7V8bEoeHB2fjtTBNxdOVt+8+KTr6zitzWWv0v+ZcZ0dcmwb5BJs+LGof9Zr0ls42kCfZuuyzFuJjYdr0hQPLDTsvKfF7oAs2U5kmK328JwCkDM31ktck+k2ppoplTy5n77XND+O4Yvb+PdoJdIpBz18i9pd88zfeNeMTh3c4CsUG1JC4H0gwFHAL8MCkj10c6AeF3LUvIAT2s6kFQ+zb1lJxDx+rGfuKwMj2uMQ4Ztx1iJIlqFrxVA+TU6Oem+FW1Z0lS9IBAmDg==
X-Microsoft-Antispam-PRVS: <DB7PR04MB4297430A5BDF408DCDF91E93EE0B0@DB7PR04MB4297.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:DB7PR04MB4297;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4297;
X-Forefront-PRVS: 07778E4001
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(396003)(376002)(136003)(366004)(346002)(39860400002)(199004)(189003)(4326008)(305945005)(478600001)(6666003)(2906002)(36756003)(476003)(2616005)(956004)(81166006)(8676002)(81156014)(44832011)(7736002)(486006)(3846002)(6116002)(47776003)(6486002)(66066001)(97736004)(86362001)(54906003)(5660300001)(966005)(53936002)(6512007)(16586007)(110136005)(316002)(50466002)(48376002)(50226002)(6306002)(105586002)(8936002)(106356001)(51416003)(186003)(26005)(52116002)(16526019)(6506007)(386003)(68736007)(25786009)(69590400005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4297;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR04MB4297;23:vKX4oM2RE7mgzqxFE6KL5Gv5wFZBrQRSAV/SNOP3C?=
 =?us-ascii?Q?Mahyxs9ULvBKl6CYgbkIzi6GRmlsQLa+DJp0E76s45yoEEulEi9uib96F8QG?=
 =?us-ascii?Q?19eB+dvFrREKblECId6KUyPlP9Kk509aiCHg88JDpBDO+sL31pxcvPdIueNz?=
 =?us-ascii?Q?42gumvZVNDAk0Tv2/dG3tYdD/sgyzXxrASDc1BPsTEpg/V8lxsLMKQIFncHF?=
 =?us-ascii?Q?Gu/dNmuYPzTRNF+823NjnTpKZWDIEsmGWNelfVwgcaTOCaYDh5J3sOveWiK/?=
 =?us-ascii?Q?Ldx49T98DznHGzvSL/MbHYJNyWl4IW63KAqS0YDWo9B5oyHA7ee+Wkw4wRFg?=
 =?us-ascii?Q?FhzXy9Ylw2XLAxmbKSHUDHigPK97BDnwPkkEt/nq7D6xs/JKGpPj0gD0GQwf?=
 =?us-ascii?Q?EuVacpxGJPDRGp4aVUCb9lUo6GwuJDAq/q1swnIam+1xgXuM9P2UTRmshEVu?=
 =?us-ascii?Q?KsSwBi56zKfCwlzzPwtus8tqoZxp7idLa64pgvcwmS4EzYWEdHhbRnDIzOu8?=
 =?us-ascii?Q?81tcRjI2WBTfm/3qnCFbSyh5lC6o4WwFxqNr2fNb0HnHfcskSzZBmV4LKnQq?=
 =?us-ascii?Q?fOHSpOZ2wjWx5YbtMuUoJd70ftSdoMUT8xE2UI2okkY6uOLoOmVXSb3kpt9q?=
 =?us-ascii?Q?yAOJH7kBkInZ3j0B9wyBqG+/eNot9dEdXMsAVRCfZldKVJmK/9GSVmUdlKrf?=
 =?us-ascii?Q?FExOdJ4Cc3f8+6BkeOnOOYqPi5J85BEs8sRe0TAWcpbLnmhzUChD3Ulo6XXn?=
 =?us-ascii?Q?BOxfqaF9RYGg1OFqiTBUqXT7yyqcJjBjL6kHhWiuXTbwzuJ/OVtpLuH05Hjo?=
 =?us-ascii?Q?3wF6H1h8LmAAWY6okst9f3G63bhilNVll+PtN8ZalRts6viYPAMCAPe4YItP?=
 =?us-ascii?Q?57k0sl2kEUu7eLzZdgZIzVflqe/QJMDEpm5QYIQDWsoBRohbhKTbu55cFB66?=
 =?us-ascii?Q?/V+XMt/uHLeMgPZyMz9Fx5/yEgtGE6aq90DnzlE+XePyWTY1tDNgZ45aoVFL?=
 =?us-ascii?Q?sb3n2/or0nAx3U+4sHGuH9S1WMcXDG2Lm49FHr/CUUMpwoQge/0IaQGmCbIP?=
 =?us-ascii?Q?+xUln1ZT/CcBVQeQOhAgr7cLTJxj9YzWjef6E6/j0zPNs9KI8y9yTVwYaVsD?=
 =?us-ascii?Q?VsG+D5MUP3ZkChd+XlVp8m3H35S4ZGAFJCchB7LGaBH7Lv8oXVRsFmKCchld?=
 =?us-ascii?Q?sj4tEnXvKwy/xpurT0SUvOwkkFhpgP84gStlsIXea3Cfs4thjMZ5hxYyxXY3?=
 =?us-ascii?Q?3+5HSgpTTdBsEPlj/w=3D?=
X-Microsoft-Antispam-Message-Info: ox1a634N4f3L/Mo4IiZoiXyEV4xjWUAOsJavF+M9HKuq58JtARJDCRPc3mLEWlboAL/ZgNCNwZSz2fWWRZM416BAZwQdbMGNVfNU+ln/SrDuma2kA1lfBkf8WOQUkuO9zlBjGMadq/uo0DzV54NvF0aDcssg7rg9uegUBEGu/qFpNrvGS7fvL3JKClB/7MtYVLzCJlf0OE2eCSQ9EjoryDDRNxV1Utrgu8Wms+a6Hyc+t+u0pxsqbDBsooS+by9rUGnyUWKoTxXkV/73CMPcVTwphN2c8A4fqfPWyfyYvLaZ1VtQLCp2UsohROVKAPisrbAbdN/WLKYxJsAQawKkg++5A9n0kL+mpPGc6QI0lK4=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4297;6:TNz8K0HrbbJt+UE/EZE2bOFw7YdmB3krtMk1aAp6PhUD0G4DdIUkKz+kEisY4swd6m8ZG3HykkdxxXz0iq69aMr697xC/Qj9lTf3zhLti4rsmdVq/ZwzaZ+CC/8Ea/LLF8+6iTU3P1CjX0mOcSMl8DGDmRyvfIw8UuPK4tgYqZl3jSGYjstL2Xqh8mO2+1DEy1l6X2PdNimNTuafca0VDDAFtSHjU0IREAXxIx6jNkNKgfeXPowVf1TTvGm6AtaP+dp1b8aaloT8zHeJpAy6cOracPnGru8zO5Gq71J7CObPa+syaSID+h10tZ3u/1bD0TebVWqjY4pJ32X3u5tl+cE3cazMqqjgils2oUaV99EiSmWL6cl2di/W3lwNGW2dyWVINnm9aybUoWCt/RJQfD8Y8vxnfgkLk3fyFSNRsb7TDJaRnhiWm7E7RK1/k5NZk9ajhxVFzexjeb76QLEVtg==;5:tk53TeWSU0L/od2S5R3OfvefifkaVB59Xn9AF/hbVGsaApHndWEkRlchk73Ax2Lqx3Vcd1M1Mol4fe7C1zNx89XxSkRHyEpkPsSmQ3oQ887a7q4Dy3SittmuL68pdJu2v7Ovx64rso7RPBFO0ZVjvThOX6eJfsh6MYKDCJYrqC8=;7:jjzOgb7/1kb/27jdBEWO8FcXl3RMnG9fU//EqM32ZwgC9JavBbygB5UiJ0aPoruiYY5gBjOqhenhvsgwbv4LaYelZ8sY4/TvNy3U5/qlpVzX2CfBsYnPM29/9Lrq6kgb85HJmuxF5dLh62I6BVbVFDBNQ38TujZ4Ya0nc4s1iHJt7mVRBjSawnzlR2PrURt15RA9Pi1QkbtjyQgxUQin2ky/NmUZv2cmic2ZNQHojtSYLbJwSim5mj5/SELcuCi+
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2018 11:11:02.9103
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80ee3096-7d60-4d9a-f645-08d60c0dc7df
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4297
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding lcdif nodes to a power domain currently doesn't work, it results
in black/corrupted screens or hangs. While the driver does enable
runtime pm it does not deal correctly with the block being unpowered.

All patches in this series have review tags from a few weeks ago. I'm
resending this today because 4.19 rc1 was released. I'm not sure if this
matters for DRM but in some areas unrelated series get lost during the
merge window.

Marek/Phillip: Is one of you going to pick up these patches?

Link to v4: https://lkml.org/lkml/2018/8/8/573

Leonard Crestez (5):
  drm/mxsfb: Move axi clk enable/disable to crtc enable/disable
  drm/mxsfb: Fix initial corrupt frame when activating display
  drm/mxsfb: Add pm_runtime calls to pipe_enable/disable
  drm/mxsfb: Add PM_SLEEP support
  drm/mxsfb: Switch to drm_atomic_helper_commit_tail_rpm

 drivers/gpu/drm/mxsfb/mxsfb_crtc.c | 53 +++++++++++++++++++-----------
 drivers/gpu/drm/mxsfb/mxsfb_drv.c  | 40 ++++++++++++++++++++++
 2 files changed, 74 insertions(+), 19 deletions(-)

-- 
2.17.1

