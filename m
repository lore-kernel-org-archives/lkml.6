Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FUZZY_AMBIEN,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BA1C4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 06:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1357421501
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 06:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="c+29Mm62"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1357421501
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728805AbeHOJ0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 05:26:52 -0400
Received: from mail-eopbgr70087.outbound.protection.outlook.com ([40.107.7.87]:61344
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725898AbeHOJ0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 05:26:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqQvDKX0awnMzmMfSj0S73XmL3qCF/iuQQv0XK6tH7Q=;
 b=c+29Mm62Wg/TZtaeVkEspRZ5cNHZ7RaLb/19Fa2FC0nM4wV/aLrOw1+YsdvXQCoVqy9DF7H2WKv3iEgf6b3K7v6ogbqnjF7bhbed+s6BISFfm5WjpYf54oltwYak829gjlQmhVkx3jT2G2qtT2rvfADQ+gp7d2Kxfl5mPCVFtWA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
Received: from lowry-ThinkStation-P300.shanghai.arm.com (113.29.88.7) by
 AM0PR08MB3523.eurprd08.prod.outlook.com (2603:10a6:208:dd::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.19; Wed, 15 Aug 2018 06:35:49 +0000
From:   Lowry Li <lowry.li@arm.com>
To:     liviu.dudau@arm.com
Cc:     gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        daniel.vetter@intel.com, seanpaul@chromium.org, airlied@linux.ie,
        ville.syrjala@linux.intel.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, brian.starkey@arm.com,
        malidp@foss.arm.com, emil.l.velikov@gmail.com, nd@arm.com
Subject: [PATCH v4 0/2] drm/blend: Add per-plane pixel blend mode property
Date:   Wed, 15 Aug 2018 14:35:31 +0800
Message-Id: <1534314933-23182-1-git-send-email-lowry.li@arm.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.29.88.7]
X-ClientProxiedBy: SG2PR01CA0129.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::33) To AM0PR08MB3523.eurprd08.prod.outlook.com
 (2603:10a6:208:dd::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db91d3e1-5521-44e4-59dd-08d6027959c1
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3523;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3523;3:tFz1F62iJn1bFqhb3eNEbXQflpAGkBoQKoUzo/5eywnWi1d+Ccz84zuNWSJLNHvZuKa6xIsIWCKfPGUg+uFM7xBSSnC90uCV2czjLIG8xFpi69LPyXDREcO08F0ESXNfTHshuOlSZxqUBnQhBcN20wi5FcqDa6sB3ncZpURitX0MD5RfPRUY0ZTN7Dv3baHggZMF/XySEsnsXaODEEirUgkmFtAEbDER4+g+1c/2yHW7jlalU1wYPSNf1RIJpPlB;25:tLRy5hKKYVzXWjL+gEdVNhWPSd9Ro/QXhXD20D4WFpSb82qP9RXUxvEUuR+4lEmfQb8him6NU00EQCeISpwra2MJkeBES7sY07FAejVHJVRtqU/E3n72UUl1+soZm4Syp0QgIr8h/6q1WOYkstDS5NqeKhpKtSpo1I/BBNXsjMXis5asDlGNAa+xLZVAZknivdP5RtJpTXHnkVp2dXmtqhrqg9RRF3Io+VJngRNr/sJUMyTs7YSV/Rh+b/Vpv43L/moTvaDRvWpBKkF0S2vyk76T2QYqImfKtbjFaX3Y9WldBHfTT/n3fRRUc7XHwwrZdVdQEYamyfvUmIdbaTTWwA==;31:KpeDeABv15D3/xTT8siyUCB8Xjp9vWlFtdz6TTWfFnC2ftPQSrhiyAgyAclUAjZQXluZBfPzONN01/KdGFAHC8CbhLf8whvevQcwmditEJ2oCwpLIULhC2NMUfDLjHcg38GGXNDFRhLUS6qB23AwVYktDFjD5jlCmCWSXtKRFF1/sRPKFwJFf5jvslJvTDfWj3zAb5FjyG8a9fbt4vDMz21QIfhkxe/WLluDxxQ9JYw=
X-MS-TrafficTypeDiagnostic: AM0PR08MB3523:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3523;20:AItguk8d5dWM/JPlc6bNcCojyGTzFrnsTLFjorlv35FKSpG9twq6H3Z3vsMcXPQy3wUEPQHdXIS7ALczCP4arRzruxsQGNztt1teM+jpLVH5+fEj2J2oxexKRSE0VZJ90oW2ixVj+ohkx1IcnIc9bk+4JMTLMfe0EFJmTutA3JnPkoRQT7q1COZHhxByrfzP65Cl7IAiq6dt+h8VKBGHXe43nqHHw72qkj6Yo1uew2DyrPwaUxWZ8wM0RoydoaTmK4ymH9dEtUmOoAl0A5Nza58OBZJhLrTSA+uwRFJ+4sG2A8X2AogGlZ4B3eK3u31UNH93z04heE69YA5mzsBCbA==;4:JAwzg0tTMIlkCwD+HrJZRNeDIojVsnMFnqQQezzRX52SPOO1hL71EHN4tjZdcSa+nXRs1mh9MIx1O4eMsFfgbxpjnY0RpKCWhbqYx++9LoOU4nhvKe7g5yii75Le6usyiBkGmsVUZ8BK1OWIaznqvtamzU+Ti8Pt4Eo1lh9Tkros87IaTi2DEYLQ+QG0C/4NZxSxUtsYYKJhJT8/F90CA2JYlMhTbH6H8jvNVqaBXyB94TNnjcoJh8aLCTkdeUio41bo0CX1vTbUE6x0iC9C+Q==
X-Microsoft-Antispam-PRVS: <AM0PR08MB35238D2FBFA7D9849FE5A3399F3F0@AM0PR08MB3523.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM0PR08MB3523;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3523;
X-Forefront-PRVS: 07658B8EA3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(136003)(39860400002)(396003)(366004)(376002)(346002)(199004)(189003)(7736002)(305945005)(16586007)(66066001)(37006003)(3846002)(50466002)(478600001)(72206003)(8936002)(48376002)(68736007)(50226002)(86362001)(39060400002)(316002)(6116002)(14444005)(47776003)(36756003)(97736004)(34206002)(25786009)(2906002)(5660300001)(51416003)(6636002)(2361001)(4326008)(6666003)(44832011)(6486002)(106356001)(81156014)(105586002)(2351001)(53936002)(7696005)(956004)(81166006)(386003)(52116002)(2616005)(486006)(8676002)(26005)(16526019)(476003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3523;H:lowry-ThinkStation-P300.shanghai.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR08MB3523;23:jiLoTtQVLfvCp93I1rpjmlHi27YaM0fb8WRJkaYMP?=
 =?us-ascii?Q?6Dva0wp63ce49XhsM3QnLJ5OVXw3OLg6xY7DVBNB1DFmSATvzTKSCDrA93+q?=
 =?us-ascii?Q?WQy8M1RMI0CC92N11UFyPYFDLaRxy3vkyN269H/W94tvc+8IHjPVL2tXbQyj?=
 =?us-ascii?Q?agl9fAKnubzcPFl6+hhhTj3ufYVa1+rQvcIrF7jI3Hgrm10FqNm1hSalyEw+?=
 =?us-ascii?Q?FeodtfofL6dD9CjHOkHgut2UsgRIgC92wsD/MW8xVGtRLB0QRTlLQwHNa/M8?=
 =?us-ascii?Q?7KZSO0mURoGDRO5uI5Rtev3asxZrw6X1GrSXpSIsrdDNKb1YSlSUx6Pr6PaA?=
 =?us-ascii?Q?jufqVQobLeKSgbyy/IWje8uaso4ggvvIYpoVfEsnLG5GoJnMJNpVzf6/UPO8?=
 =?us-ascii?Q?+8yub/gERz8uwrBsitWoUu722oxzoDdZXhxmB6OQ+G15blNqZKywnm1tONJc?=
 =?us-ascii?Q?2Vl2yTa4CB+xGhAlYd7u9eZiYEkw4AZGKtywkMD9ub7pLP7UfX59gNC9hE4B?=
 =?us-ascii?Q?dGCpiw6Tn0NyL33TfsT1eT8lTjQSKky09KWCQxnN0Doc6Raq4YlHfGk2CQsf?=
 =?us-ascii?Q?9MKu9CgDHLE/MdCua7j+0bYWrRlPN9wFehOBjexEhGX/rZgNyhe4nojAVgSz?=
 =?us-ascii?Q?f9RzG/rAu+7/ujBJwzHQxL62dBcTSV8aG61hPhDWRf5sSQLi6X0XXTO5uEpB?=
 =?us-ascii?Q?Vww5Z/RbuiPk8FLHRII+ZVWgYqdwjb2A3lB4pAJ/sVjijfymT8qC04bJLCsf?=
 =?us-ascii?Q?ByPfK21OcJecnydDPANXwvdd4x9dD4MiSWKKgeKB5HOFqWFiUh7lfKxSSFLN?=
 =?us-ascii?Q?PQOpFCPjvJgrxfmscrCZp86hu743sAv2td4EfC2oQOsE04Cj3ADEBrADr4SG?=
 =?us-ascii?Q?8k9TbfjlsDKRXDU+qDa4rTNihDheAlbT4XaxoEBQ2XM8H44ZS2n9VPPbIKPi?=
 =?us-ascii?Q?8VpqNY39RQ1hEMMRRsc8adUhAZqjL5L7Bwsy2dy2zByy3iBAaWerop9EXyGG?=
 =?us-ascii?Q?SKCRRjx/ua2PahpohqVn4KZSYrA4t2/6YUWJ5jlI+h1meWjmwg7V7a8VaHTU?=
 =?us-ascii?Q?zK56QHwbThG02jBNpubfY8pvRb8X1xGbHv/LlxaJU3hQFDLUop3zT1WEIgs0?=
 =?us-ascii?Q?BLvEj3kma1xtf97Rx3kOyoO2HzCqvXC3aimIrnemXHfvJLsJAp+pWy3m/Wez?=
 =?us-ascii?Q?YHe9kaLQnkhzoK9jZrOpFiYfw2pGNNisMIKOA8AaIdbhX8A+Aznpk+XrUTzC?=
 =?us-ascii?Q?F8O52NfmoobfPivmeU+OYwMp3MViVTM70/pMRtz9FXYT5CFPPRuLPNlvv6tN?=
 =?us-ascii?Q?wwOhp4A+kn1Uhb4voZlbt2avXK9TspmruMmnSjwW7gT?=
X-Microsoft-Antispam-Message-Info: L3gEFznEWKRI/HO+VVFi40fbsw7zXFnF7B1x2KFa9P9CdSPObVKSalIG0zmr5oe1eBda5ka1FTV/T0Qhz8lE36NXK31Vx9+phEmrAbU1Pna9MuBifvhsoTA1eJidM3iPJrF5kDRBsr00Ke/S4HM+13Wr1Ae8NMa4WfMceLwnFoGWRE/ef/fSozDSiP8XSj41494i4Be+Pzyp4Io4bsrTF5QtT8Y2ZGqQTPCmggPDSMD45S1xTFajYwtzCb78YayZQF5aajBiEw9IuzREujr5Y8yUEMjG4w0AQMGFhqbdW9lPLJbSUqBxITZkPmguUSfmmORAH1eFZZtuFHa0XNAOfiRFT+/wzLzKUVeTYr/PA0k=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3523;6:BRas+FXBqFvwaEd2gHxbmZBLQAlG64fcde0N8LBmuvtXQ7wXJxXgi95U/4FHCo7IMXr5xB8SdbxAEmiAw9J7I9yzwHwUPUUyMR+UltAkNpz/BDjBkWS6ZI+BjWz+BcUg+tfchSy9XE0MbWlFHghYdMj4lxiNbxyKQCboK/LWmGBegcXJD5PrYvFwF5KDsZsd9jzZ9tLdJVlnxJjloFSba3Fn7rduQ1BuLwMMpfqJse8ducYGX5Vj9bgtnmIW+aUT0H9DgJk43ZdRVNIbf72XEfHhjuMiusK9tiGIvW64tUPWWr8ZQyUbUA68FMY3ox5BpQYgbsXCaFsjHNDjvVJyX2K+zvSa80gUukP04sIrC2yugrTvP8Pjbo1JN4kTSctF9+3LRq5XM3I6oExHDOFoHlimPy97lyTFaVvhOcecqk9C0OIdDemJALAbBTU5/SpQIChuOLgcvRwY3zE92JAZHQ==;5:KdS+vMOZ1uwOjIdH9M2dnjlof8cOYx7+Sez3bfkIZ2pWLNmLaLOgHA0Rp2ShDDwQNchJH5IXc3NuAP0znxFI0BX8tYFryeSuatAoge0aNSb4YtlGpZLIxi8NHTU+hNWxwW8Y12NPYcUGkGDGJHR/xLAB7xqLkIe6UA9pqtx0VQ4=;7:NN1DMb5CRKg63oi4iTPc2IsDh5TwLCmTGcr/BaAFsgyb+i5n33kbDYHxiAScGTQWkaUZJJxO1R0fNbWwnQQ/xxWJrWH0BT4ii6QOTQeI4tox0bNs37idKCyL4ZNSV4Ts9wZ+Fa7S+i63dw2Fkl7sk192u1/cq00YF5AM8Aehn4r2GdBOA5LK2qUulXCFA/Zz5Br3i0rY3DFs8WMoKyRKJ5uhZ4U+bYifUwL4gb9Jhy8yrO+tx4pToqMnb4hyZW7C
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2018 06:35:49.5270
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db91d3e1-5521-44e4-59dd-08d6027959c1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3523
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This serie aims at adding the support for pixel blend modes represent the
alpha blending equation selection in the driver. It also introduces to use
it in the malidp driver.

Let me know what you think,
Lowry

Changes for v4:
 - Refines drm_plane_create_blend_mode_property(). drm_property_add_enum()
   can calculate the index itself just fine, so no point in having the
   caller pass it in.
 - Since the current DRM assumption is that alpha is premultiplied as default,
   define DRM_MODE_BLEND_PREMULTI as 0 will be better.
 - Refines some comments.
 - Updates on drm/malidp, hardware limitation check only when the format has
   alpha pixel.
 - Rebases on drm-misc-next and fixed the confilcts

Changes for v3:
 - Refines the comments of drm_plane_create_blend_mode_property:
      1) Puts the descriptions (after the ":") on a new line
      2) Adds explaining why @supported_modes need PREMUL as default
 - Refines the comments of drm/mali-dp patchset
 - Rebased on drm-misc-next and fixed the confilcts with plane alpha patch

Changes for v2:
 - Moves the blending equation into the DOC comment
 - Refines the comments of drm_plane_create_blend_mode_property to not
   enumerate the #defines, but instead the string values
 - Uses fg.* instead of pixel.* and plane_alpha instead of plane.alpha
 - Introduces to use it in the malidp driver, which depends on the plane
   alpha patch

Changes from v1:
 - v1 is just the core changes to request for commments
 - Adds a pixel_blend_mode to drm_plane_state and a blend_mode_property to
   drm_plane, and related support functions
 - Defines three blend modes in drm_blend.h
 - Rebased on current drm-next

Lowry Li (2):
  drm: Add per-plane pixel blend mode property
  drm/mali-dp: Implement plane alpha and pixel blend on malidp

 drivers/gpu/drm/arm/malidp_planes.c |  74 ++++++++++++---------
 drivers/gpu/drm/drm_atomic.c        |   4 ++
 drivers/gpu/drm/drm_atomic_helper.c |   1 +
 drivers/gpu/drm/drm_blend.c         | 126 ++++++++++++++++++++++++++++++++++++
 include/drm/drm_blend.h             |   6 ++
 include/drm/drm_plane.h             |   2 +
 6 files changed, 182 insertions(+), 31 deletions(-)

-- 
1.9.1

