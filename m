Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9D6C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C399C2088E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="WRvEIFeH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C399C2088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbeH1VPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 17:15:52 -0400
Received: from mail-cys01nam02on0121.outbound.protection.outlook.com ([104.47.37.121]:51168
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726961AbeH1VPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 17:15:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYlSSjvMrl/FUnf4G4RTDXMzUJcLqN8/x5tdh3Qgz44=;
 b=WRvEIFeH5reqBqt7ZpMOK/Mnqy6vDKgEjF/lNo6CuKJc4ICEaU8RX5xYr4OfS3h1560rbqbC+yva2B1tTSUrmSPTdl+arfnNdg196peLiC/ijL1OOVYqQNGxWbAECTUkeU9L0kTxAgz+cgGrZRwJ+MaBJDknBB2j+AE9or5MsTU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BYAPR08MB4934.namprd08.prod.outlook.com (2603:10b6:a03:6a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.15; Tue, 28 Aug 2018 17:23:09 +0000
Date:   Tue, 28 Aug 2018 10:23:05 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jonathan Corbet <corbet@lwn.net>, od@zcrc.me,
        Mathieu Malaterre <malat@debian.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v7 05/24] clocksource: Add a new timer-ingenic driver
Message-ID: <20180828172305.bohg6cggnzm3wsuj@pburton-laptop>
References: <20180821171635.22740-1-paul@crapouillou.net>
 <20180821171635.22740-6-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180821171635.22740-6-paul@crapouillou.net>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: MWHPR15CA0058.namprd15.prod.outlook.com
 (2603:10b6:301:4c::20) To BYAPR08MB4934.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20d84fed-0324-4cdb-ab8a-08d60d0aecec
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4934;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;3:PbD79V2gK4pxgAUmuC1MAEUuqUeOzquO9mfB4TMP8CefYlJgMWUURbF2bpIlpoVhg7YDOVeMFCi/xGDiv8y0DPuOPftkWo7mySUG82ilMI+yYGSPPuMGKwq+obB2+7NmE8emgsDbnZBOljSaY4tocoPyT2C8PEKR2FXgog7aol3fZCVDm/1M4CPbai9PG9A8DnIsmFOE5EtnF+ZY3dh1tHsFRXRdNtGZc+JmyJK8VilOgTp9fhAavp+4joL67hyo;25:POpwW0LmfzDJikW3FB/0R80UYg+BTmxw9eAu46UAha24EKFHXtHQhooXJRbAzDjjIDlFL7OldidlVpD4pjZ14K5hyUVE8TTQbZ/8NnocbCaV1iL43hBvbkWaikJ3IDWwoqKBp9s3fQV4a9zkoJBGJsYPP9IsDmw6aF4W0mK0+wfdPZlqy8eHn2VHm0UiFwOlN4oHRdSLKjMNzC4OuOdzmXcspRPuSVjoIs24Fe7dIc0p5O7mbZBznVOw6Q2X6KhveqQCo+UfWNCoHQa0+9W175KSvv7PrSPQnrXejTPsbm5YvofgjzRhhoUXoWpWSoPy3UzSVh4xgWgUHOJEPmbNkg==;31:v4O/UrM3roH1dLy1qoUHHULMBDhp177lKsaBmL2UlJiKFI/YmOmmERgX1yp0NxtxqEU/pp/AOqsUaZHfOumSTEcVVqWfAhpF2uR49LjZ1iUGfft1lpKNBP+TYjHRSeV3dG7+2f6cCslKK5ULAPyA9cbsZ1D/ewpv9tKdSB7eIDlKLKZ2KpUatUAeLhs40BNbAk4L6o80BKiqOO2ZTWR6NqDlKdIFGrmHDhx5ryd1tg8=
X-MS-TrafficTypeDiagnostic: BYAPR08MB4934:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;20:rYQc/KcCig3E4IzTnFViAHBbkga/wOinVCsSj/O7igseEQP3b4ktY9nnuRmkFz3bndM6uHx63+90LG2RyzlMlMoGPztaotT7vbBeBEQ4Gp0TNrGt684zthZwMov6kLyarWFKaiaCvpgW1SMBV4O7ExdJnBZ+zK7VUqxS/N8ClsN+DH50cNmMucsNjU8/++B5w7Xbv+uOBheKQmIBT5H/K+AbafjdOLmzHp3/0Fk+Wki54eC7lfFNK9CaZvcWxlaj;4:2m6/PjPmTSY2y9DhpH9v56zGXIoht8mXgy1g4ggCj6IFJ2HTsjGRmVbqgOPRsIgb6y95R4tsqiVne3W0r0RiFVSRBvdbY6QSeFaN9Q4pS6N5Vxv5VUAjecDkF2rVEDN/2v9i/vEe2zdkCffVzgon7fngL1fgCcp+y+0om8Tu+bcnrUjY+Kd0ZG/Aw6TnTIvFprWNFw1zcCGRgpGPihg/rnjJuA6CcCNnzFsdgGW+hzBqKm5tgOaQZA3B51cWT0I9AJDYZMlN5plHAOCDCS8KEw==
X-Microsoft-Antispam-PRVS: <BYAPR08MB4934078B2D9FB24DC614E8DDC10A0@BYAPR08MB4934.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(93006095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699016);SRVR:BYAPR08MB4934;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4934;
X-Forefront-PRVS: 077884B8B5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(396003)(346002)(366004)(136003)(376002)(39850400004)(199004)(189003)(6666003)(11346002)(5660300001)(956004)(476003)(14444005)(26005)(53936002)(33716001)(106356001)(8936002)(47776003)(97736004)(16526019)(42882007)(386003)(105586002)(76506005)(6116002)(446003)(68736007)(3846002)(2906002)(186003)(6486002)(50466002)(478600001)(486006)(7416002)(9686003)(52116002)(25786009)(229853002)(1076002)(16586007)(305945005)(6246003)(23726003)(66066001)(58126008)(7736002)(8676002)(54906003)(110136005)(316002)(39060400002)(6496006)(33896004)(76176011)(44832011)(81166006)(81156014)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4934;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR08MB4934;23:eFwmgid4gcxxKvablZqm0L3kwWjgrm//GjIoZyk+d?=
 =?us-ascii?Q?vlTnt4zu2UVKPE9dn3K2DMgmJgUO01HgI3d2irPNIiAiVAOkors7SAfNz6Ez?=
 =?us-ascii?Q?v/yUjIT6fD9/clOli2UMd2/gU/d8VVqvHWTX7uS5iYCHkXoar2i4O8is5+gl?=
 =?us-ascii?Q?I1TPad+j6sTl5znRkopEqHvMQj6KtUxguHck2AMYyCNFNCpcJL0ULv0aETD3?=
 =?us-ascii?Q?j3E1XiZLEorhk0Pb9LBMK6rrg0akl/EZ+NxA4P90QNrKTheRJrFLhlMGsiBs?=
 =?us-ascii?Q?hNQGQ+cgLp+Lwbs965nX6fNaRy5U+IMgjaTCTeBvcoIZd19p+aopCvpbyvxu?=
 =?us-ascii?Q?1hWBE10iXmj2F0v/RYQ9q++9fGLf3YojOz6LfcakzRKNdN9arRHrnCSTtPop?=
 =?us-ascii?Q?/oyD+w08D0qRNNyQuAbK+UpMeqkkQqwchGD20oir9K0MdAvoNOVcwDdIE/V5?=
 =?us-ascii?Q?XOisezX2Hx9Ojsv1GKaBx2xbRojWYLrYDApjbbMPrhj/EitiFLtwpnv9f8hs?=
 =?us-ascii?Q?gO+NF4ns5nnW2lDnreXjGn1zx1QlzCWNXxZ15gfA3wjT4JVUacxU3tELZfAq?=
 =?us-ascii?Q?pk7hrPAsTYp783csKObskzEHtSfUVq/dS+0O65YveXhkuE8w5RMwZuHlTsh2?=
 =?us-ascii?Q?pRHmmfVn8R2zxRY9I1NkXN8PQ/Knc1Dnu8A5v/wjBhl26v6aswAJtPCRE0zU?=
 =?us-ascii?Q?i6BxJazdWtjTrMEnEAat+9/GV1bGOoESC4F2sXnGUakONjNHP40ekYNzIZDl?=
 =?us-ascii?Q?7hNXVUPVuvPq6rI2B9xkuklVs7xHUvKwdBznaVblB8O0QKrjLbux+SW1Os9d?=
 =?us-ascii?Q?vIv2f8vgP2POKiFmv8wOpbqnlxfPnhTSy7/KM2p3CFl5+z/7OgbaS2Jokkq+?=
 =?us-ascii?Q?WCK8uKQ7iX16q0WjbDD9y0TAOjMyMTC7MUiIaAM6bRq9dDLJCJvD5r3nRVoq?=
 =?us-ascii?Q?jObCJB+4A21ymeI94U5KW9dscD1c5q8Gnp0eOV1M2ouT6enuBhUq+rL71Tmh?=
 =?us-ascii?Q?gYqPYCgaviaYpaYQBclkSy5H7ipXWCDETwI8O3+AnHEaM/sYB4RWzptp7hB9?=
 =?us-ascii?Q?LFmPe48qLXhaptrMzrt4Ycr4b3Y4uh0/fFNbcC4Rnn/6S/0Tc44VTzJwqIfL?=
 =?us-ascii?Q?KwtzmIIoYOb0ArxSOl1IkGTl2CDJRuo2bxMAMXDTblXK2Mx16YKOfjg/fA6/?=
 =?us-ascii?Q?oY95oCghkDxRc/40wGMuByXzTCBOX6YJg0aaYN5inU/tz2KShkqSKfzdWECy?=
 =?us-ascii?Q?HQ0KH2dOhel64jjVVIO7wC6cO7/AcSv8uTnn0jnhMJ/6HX1TilpkdsopVp2W?=
 =?us-ascii?Q?1wkNSi1ad+hsB0nQZ1GIakZCVu1qaFMt7ypRGWmUYZumH/eCz1FuDbEaKR0Y?=
 =?us-ascii?Q?nnd3YKm70NVhzf1XVL4wd0OrMg=3D?=
X-Microsoft-Antispam-Message-Info: Mt53RD86QyXanH8NBI/Dlc4zhItnC49YT5gbrkbXjpH2BHJpTO6FoEqLVe87IvKiDvo8EN0FxhEhShliO0Y4Q2je+4WzNtCFTDFSp9n+UxgbTDgStQ6l3cdsrMYdMvvWJCcz+MXz6qfiwgSXFc6SIk0voUffJ5q8NFQFzmbTwiTXm1NslDHfXBxRqtW3Qt3PocVcQiKFR/X4oeVc/esfd9d5XVTczvyC6oYl0fovAminR39uFSX0UlsoTIIIkE6sJNqKP9e2oe+2JUFlyRcaS2bdAH7Svujdr03DrTa/+Spy+hKNDXUg4q4rQz0Cwf2ZkDTuwndQ0KCerh4oX/2NWA==
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;6:Sh7Gtqn+M+MdeMYnhwoZiNuSjccLgv/YZqTQvbeSJOqRUAkRtz4w3mUq/tb3W9NH4PdTZDoYu8J6a3/iYBYen8ISaCfy+5bf0m8mmgZqH+eyfxfhBwsz7gUuxXIih5nsnNFhPGOx9yvV2ICrJ5PFM61ZSO3ExpuUZ9/XpUlZ/eLpnWx4Df8FYAck8xTXBm4tS+UmNDtav0oQtPDN9MbfeATexYEqJXh5oMp5sbZKHMwja6aNM83ta9PzW57fsqnT1apRqM49mEYC0wFig0Jq7YEEYtX2lyizrt09DgMNGOo4C5Xi4sf+q8l4gwlUkM1Ea4z26ohGud/Cb4hEvembXMaBog2xLliSF5jJhi68RgbQPe+xyx8Ue+a56fGquaDG3bnLtPhV/seE7iJ9Tkem65Ll8JMIrxMvRkLyx8FsAVb7r+546POrQRR7heYTYpFHysTEnymGraBgrQY+3GY1jw==;5:OF/9CClp7gLFDxACO7UJW2RdqLaM5pmYTNCXo48/M3BtMfzS/0O9W3xAnlfP0WSKUAQV8Jl2lA9QfHX46JwfId4J7kXwVnAZ+0C2NLcSDtknKJOHITmOz8t3qLnD93vL8NFS7To3Tk6bmd7oiPo+XdpfzgJEJKx27dFL3mY+pIY=;7:tb2V6arIbusy/ddx4qR7lPQ/tbarTBV4NokNoMcXX4jcqBAM+IwzBajo+q5eLEjrSctNMM75w6w5moMK5r2/8b4BR+dRZzFez4W53GVVALYzcLgxlbav/A2exa9LA4yBw2E/CQi8h6G+80kvX+w7CfBwPb5YcdqjgjkG7bYbiFz/haIaKvADsJsSB+QsvBWGwM1e1vZjM4K9qwG28lP2WYbOqVA7XynbMUBCcnhoDCMjzfoWuTdldrKRRcU5rLzk
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2018 17:23:09.4090 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20d84fed-0324-4cdb-ab8a-08d60d0aecec
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4934
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel & Thomas,

On Tue, Aug 21, 2018 at 07:16:16PM +0200, Paul Cercueil wrote:
> This driver handles the TCU (Timer Counter Unit) present on the Ingenic
> JZ47xx SoCs, and provides the kernel with a system timer, and optionally
> with a clocksource and a sched_clock.
> 
> It also provides clocks and interrupt handling to client drivers.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Notes:
>      v2: Use SPDX identifier for the license
>     
>      v3: - Move documentation to its own patch
>          - Search the devicetree for PWM clients, and use all the TCU
>     	   channels that won't be used for PWM
>     
>      v4: - Add documentation about why we search for PWM clients
>          - Verify that the PWM clients are for the TCU PWM driver
>     
>      v5: Major overhaul. Too many changes to list. Consider it's a new
>          patch.
>     
>      v6: - Add two API functions ingenic_tcu_request_channel and
>            ingenic_tcu_release_channel. To be used by the PWM driver to
>            request the use of a TCU channel. The driver will now dynamically
>            move away the system timer or clocksource to a new TCU channel.
>          - The system timer now defaults to channel 0, the clocksource now
>            defaults to channel 1 and is no more optional. The
>            ingenic,timer-channel and ingenic,clocksource-channel devicetree
>            properties are now gone.
>          - Fix round_rate / set_rate not calculating the prescale divider
>            the same way. This caused problems when (parent_rate / div) would
>            give a non-integer result. The behaviour is correct now.
>          - The clocksource clock is turned off on suspend now.
>     
>      v7: Fix section mismatch by using builtin_platform_driver_probe()
> 
>  drivers/clocksource/Kconfig         |   10 +
>  drivers/clocksource/Makefile        |    1 +
>  drivers/clocksource/ingenic-timer.c | 1124 +++++++++++++++++++++++++++++++++++
>  drivers/clocksource/ingenic-timer.h |   15 +
>  include/linux/mfd/ingenic-tcu.h     |    3 +
>  5 files changed, 1153 insertions(+)
>  create mode 100644 drivers/clocksource/ingenic-timer.c
>  create mode 100644 drivers/clocksource/ingenic-timer.h
>%

How is this & patch 6 of the series looking to you from a
drivers/clocksource perspective?

If you're happy with them it'd be great to get an ack so I can take this
through the MIPS tree with the rest of the series. The alternative would
be to get the drivers in first then the MIPS bits in the next release
cycle.

Thanks,
    Paul
