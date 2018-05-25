Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933409AbeEYMjv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 08:39:51 -0400
Received: from mail-sn1nam02on0065.outbound.protection.outlook.com ([104.47.36.65]:10239
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753754AbeEYMjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 08:39:46 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com;
From: Thomas Hellstrom <thellstrom@vmware.com>
To: maarten.lankhosrt@linux.intel.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc: Thomas Hellstrom <thellstrom@vmware.com>
Subject: [PATCH RFC 2/2] drm: Change deadlock-avoidance algorithm for the modeset locks.
Date: Fri, 25 May 2018 14:38:55 +0200
Message-Id: <20180525123855.28956-3-thellstrom@vmware.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180525123855.28956-1-thellstrom@vmware.com>
References: <20180525123855.28956-1-thellstrom@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [155.4.205.56]
X-ClientProxiedBy: HE1PR0902CA0038.eurprd09.prod.outlook.com
 (2603:10a6:7:15::27) To BN7PR05MB4579.namprd05.prod.outlook.com
 (2603:10b6:406:f2::13)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN7PR05MB4579;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR05MB4579;3:oLp37euGGwePHGRdRgArgTxG+ARDzOisgXR5/qehBcXUGLkhLs63fKxY5UhIKc/w81g/GcSCZ8jl6tg0sCI2tUJ5FVXn6Jgwzux5FLkeq/C05ZrPB/5faj50CaUGeH5ntiwrATu4C3lSLvl8BCPzCClAffm6eQEwaA0iYLelhm3gLiYTvPgkvSfCK1F51ArBtqLXH4WIH0Q0XKIA186DDB6bul41pGrp2ZcNM8A4SVmpuJTfHxxXQ9rD9QLZUDmQ;25:I6pC+1lJdw3NhwH2Sjg4SUyLDivblv4qMUSL74Wq9gzee6vWtQoZ1eDZk38y3KYCE/0h8B6hSG6blqbilNOTh752ladAeviMb2UStpfjt9IGpvNxI7YZGr7fqPK7YUVH3BgIaie8vXg4ryzdrRErJXPJCSdsBhLeEoCcTo8N5KFBhTRQeKnZShUrFeoYPdBSQFT0iC/ifOfyIiTGtIvjoOvO6xLRa9qE5U7qUVF5psR+msL4WJW9Brjj2l/9LFxpgOMgyNa2kMIfwkLHL01bHAGtBc0yg2zH7tbuoDz9EACdGFTUh2vQYBuYBd6qH8ERkA6CV3f+zd0kcMi6m6Ylcg==;31:KdDi4vDCdUFubWI9qR41X0HOCwF3ylX1F8YNY2dB43rQAhEM3lgm9jy7xJfM51gPMzZdsNHbDmXAhMwnAZQgk7RtmOf4zgumUwU4PzQ3RA+bijLJeADRoybGnxX2VBn70zMqDL9yt9Uvg85KYLmHUHTmcv9dQoMXM42r/k6d7gGpHu/zjZCqV/7usWA9U7od22BeDkVGf10nAwHMC/iF8cQMAY00Ch127KoviPyDNUY=
X-MS-TrafficTypeDiagnostic: BN7PR05MB4579:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR05MB4579;20:PsIZ8IqyhI5cAzQ9I9RcKMxktLTRprvybcMTxFaJz5OPGFrWK2uVKIZJYmULhEmKfzExnju+wnhyr98uqtHllrtCCccUhVv1pLvepCkHMQYsU/PV44cv9JPYbBXSGtTEilaQEuFjrNNahfPemuKKJcJ5AI/0zWiZ07/nVfwmk17PS6AttpZ+BQC3Td+dfWz6U5zOVn2RrBjqrSWgyVuZB5BbrTc0Ow+Mm9Zrx3YH0yU3lqcUlJGhrKzl6OGXSEMtyc09I+CQTuBaSccxWTs7d5KHTDJ2OGyBQg04qu0w/9dUPZEMI4UETTOB/HJTgbtSadrSh4C3Tmha6GWPijCoQy9aeaBUfxRGjqIgEaN7u6OZla9Gx/6ElxyM1M4cSpdx3fCxlDzW2PhnzLy6LfE15HaBE8Os3AYbkS64EidbXY87mXF8AaCVwcxslvNz/89hfvDPKpNJh3XbNafMTjmldpbTjNEbBw1IbtQvgtDYcWolNjBMpKERGJRSwIUiFllM;4:usBm2nNC7lZFa4rC72JH6aOnsoZtgYgu7rHFlOjY5JIDFnW17F5qOciazD3Z/SeAjZvL67ReXAij/Oib6iKx6kONGg9KxK4k6aDVfXR9X4AT5HF4QBdnW/q+vohC75fgWPWf4cH5LuA7yIs+VKc5+hSWDxd9vBwc7ENAwwv0K373fqxU5uSOIrxiPfYLwMWULkr7FyhIbXW2M/b74GiXYFZSdIeEksAgvZcO1mzR6/T9ZXKdukXb40y1ievbJKtSGFUAQOgLhGFhin+HJcsUpvn8UMXYH+gOm7GFCRIgeqBNjWYI0hbkJ8JxeRVuzHSd
X-Microsoft-Antispam-PRVS: <BN7PR05MB457933B35DD7E77E5DDE6915A1690@BN7PR05MB4579.namprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(61668805478150);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BN7PR05MB4579;BCL:0;PCL:0;RULEID:;SRVR:BN7PR05MB4579;
X-Forefront-PRVS: 06833C6A67
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(376002)(346002)(366004)(39860400002)(396003)(39380400002)(199004)(189003)(36756003)(446003)(48376002)(50466002)(6506007)(386003)(25786009)(6486002)(5660300001)(476003)(11346002)(26005)(68736007)(76176011)(956004)(2616005)(59450400001)(7736002)(51416003)(52116002)(478600001)(4326008)(305945005)(186003)(16526019)(486006)(6666003)(97736004)(6116002)(8676002)(81156014)(106356001)(50226002)(107886003)(1076002)(86362001)(3846002)(81166006)(105586002)(8936002)(6512007)(2906002)(53936002)(316002)(16586007)(47776003)(66066001)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR05MB4579;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR05MB4579;23:IqETPxWKDFmdUm9IS6Ad02IrlfE2Rz7B88M68Qz2I?=
 =?us-ascii?Q?NX48WqOIW5KegpJF50sRfDG8x3YjYBzwfc+MuSWgoPusbKRES2vRerjKUr48?=
 =?us-ascii?Q?XV3QgOjRmIG3VorWRpw76PTZY5jo7w9yiw9P2FKHSmcN0C1DEaPTCk6V84ia?=
 =?us-ascii?Q?mInEXH97oCMphG4jBYjIyFYPnbgh4RHA/I3A9933QOrHvH/CbIC6oPZ8w4lM?=
 =?us-ascii?Q?byr6UDfVaPbiArDSObfL5RtM46XOM7x2LF9Wa/C0zFxJ8VdqsIpQ7l1BW8WK?=
 =?us-ascii?Q?O7xzT9/UdS6agN9rrGI4+4WVyxCp8fhym7nUTuqxjT6+fIeQfDJSSinqjotx?=
 =?us-ascii?Q?1WiPNDPqnjl3nByI3og5jlHaYWa4wVzwRiTbsyQ7ou4DsZG4BUSLGZTx1zWD?=
 =?us-ascii?Q?HcHotMrBRmlBbC72yrWUqQ3SDjXZJz5wHOSkUHG7Lq0q8ZcMl16XKqFyNOXJ?=
 =?us-ascii?Q?DYBwz3fURgY6QkiFV/H6GZwWyf8YLHGhb2eEA187hP3tIWA07Td/Ilt2w36c?=
 =?us-ascii?Q?zbYdOYkkiYs/hKnXs2tDQsGnAX0lr3Zul5Diwy9bdYj3QqX/41QQ5tvArwYK?=
 =?us-ascii?Q?ETCBHqtFs/7TRLmjTnNfO+Wf5ef80hCJKtH1ax3ilCbptQvoX/e6uVtMsARD?=
 =?us-ascii?Q?zAmUZOva2Du2UUQjwYTZuvaSVatqiq42whKosgm0zVUK2l+vYj3v1+V1OL9k?=
 =?us-ascii?Q?9CLMzIyRuasljs/7e2SwV24HWRyXdqMZf5vUMNgy4Z+LBHF6Lr+TjQAK0dL3?=
 =?us-ascii?Q?0K1Ba5arCTtZERiULjrXrNIAdyWmZWJq9yNkwQa5VIDP6t2HgEgtR6H8OiGB?=
 =?us-ascii?Q?O6TDiSzpJpXXFTGsWaoEUaAE929rHE3UV7t/TGxTVku+x8qPjebu2wcf1eDg?=
 =?us-ascii?Q?BPb/aVaNfO5d+msoE8BmzyleNsFbVygc24qYJ8na8x881FcNxFPq2/zpFlzp?=
 =?us-ascii?Q?XE3LCo0F4MaTgYUZgpvSMM0QNqoBEOw3KfQ9omJ3Jy+yFGBU/MGAsH4ZFegv?=
 =?us-ascii?Q?jxGXcioKAUsfTnvkPFjax9uMBkFJKftyBWFoaIaztuTnZdMnc1C1YjQFJPkc?=
 =?us-ascii?Q?CEtmjitZLBqFFNGwpeHbZFdtpFn4q5v5WIEzV/cEBNtvqBQa1IIbuchL+x1z?=
 =?us-ascii?Q?FsbLzqk1nnuxE6JCcXknC9PPBnM/sx7foJQzqJ9H3Gvkmf5783mC8kMs+57Z?=
 =?us-ascii?Q?SP49ZI9w4u4Nl6cE0KBdpVXke6qaIOg2Envi1Qs7ANE0PcclHUUsvcenTBp8?=
 =?us-ascii?Q?Aavwq+rTOp2Kn/JGWrP/gHrz6BSRh0402KynsiT?=
X-Microsoft-Antispam-Message-Info: OQC+L67J2hNnNzY7BRwrGlmZQ2MJG8KcfRMRW7s7HkqjFsHaK0Jo3tgYZFAKNfmuWBLr/QDmHSUwPGIuB3mY4V4T96qqdsDlbRaqBUB8O8VahhFpmLMYJcqbTmvz8aQr1KKPisDBjtTlub9q3Pd0FgdSyuQmtCOlO/gilCgkzhub0uvL+aOUhwEzgDPQOeeo
X-Microsoft-Exchange-Diagnostics: 1;BN7PR05MB4579;6:ZlIKfQfdqMybp7PwbHU0KGscqxavBmhpzdrlPEJximiaRwplx0c1gJyfc99Qg084NkGPs6Y2uMpjofVHlqbTdBJ3zlIUoMN4vkzDM4NgJ6WDffIYUteVDiq2011192wAOimZ7bH3DgcMNCRBHvsfsnWwkQQzN7wgPm6ktOJQ5s13j5atPG2U2Z6ZgSNzfUL2fYN3G8YuAmkTiyG3zSonc03zDH0DXFG4qELHgGDhee4qJBGmyRtKg+KPxw9Gk3p0txzn8e+R4cytYAxNYKvdXNA35GvHZjShDklx+XcKACeVyNpxfW5g0TjiJrOnlrrgDumKdhj1UWxeWyrgW1WogKkqUcOqCtlXQ655wYzmBEFel01ViREyBPQhewx9Pl702J9qubMfVzZnTfb/mIxXIVWb7pVpPb3odn6a2xSGjct+XJKw/pAQ0gtcMAECgg2rtlmDJ13F0MXPzZt+jbS/dg==;5:yWE7BVdRn2pbwUa5hdKJFmzEWMEAuIm3/1EAMqsan15Dr+TDJUFNRS8G9wh6zEqXO5IN/63T4FVFhzoXfVf2T5rTtH5yudlR0fl4BzxP1aq8ExA+eqs9//rHWKdeQw9ALig3x/tZwljsQVpLzT5aM9misj0ICo0FRqk6aD32M8s=;24:0OcjIKPSNMvQGL0rg3z8td3zChEz4uE9ffxCz1zH1jXWsSCmGYtUQHqYdfyxUTBG2auDKPZY52r58kkbIifMB7mMZEHskQ95vcaqL0MzmC4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR05MB4579;7:tCRUZ35FNFkP8oOKQQ2d5f4HAf7omYTouj1YhS6XjTxZ1oRIPqP1k8vjNk5nLliCmWOnU4t5x+cFAud+CG7TSIfrevhiQ+HckNUHyAXJqlkEhA4ECzZmJ2xwqORC/VszSWvqlbIyHf7Chckj6hunDbNc4FdEnmkfwOlOLoapi/H5LcNAyxFS4/rhY0nEi1wmM021Kg1utHHwmTV0yfVDDk2L/FrlEeQdsO0xwG/qqc41DvkFfNeUHafz13WtLjOE;20:HfF1h7G1kPitRopkYbZpbsB1JaNWae8RjR6/g3RH31iZ5pXuERz8/U4zzCAAS+s7SgFmsv3F5qRQbsfnyBYJIoQ6pYHQwWdvRuMmHOKKI3sD3U5M8NrO1e5ngXytkv2DcFGwOoRT9NO+wiH6eZwNwl0qK4u4wG7v40Firrew3/0=
X-MS-Office365-Filtering-Correlation-Id: edb79d94-5bc5-40f0-0795-08d5c23c9806
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2018 12:39:43.8475 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edb79d94-5bc5-40f0-0795-08d5c23c9806
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR05MB4579
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For modeset locks we don't expect a high number of contending
transactions so change algorithm from Wait-Die to Wound-Wait.

Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
---
 drivers/gpu/drm/drm_modeset_lock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_modeset_lock.c b/drivers/gpu/drm/drm_modeset_lock.c
index f22a7ef41de1..294997765a2c 100644
--- a/drivers/gpu/drm/drm_modeset_lock.c
+++ b/drivers/gpu/drm/drm_modeset_lock.c
@@ -70,7 +70,7 @@
  * lists and lookup data structures.
  */
 
-static DEFINE_WW_CLASS(crtc_ww_class, true);
+static DEFINE_WW_CLASS(crtc_ww_class, false);
 
 /**
  * drm_modeset_lock_all - take all modeset locks
-- 
2.14.3
