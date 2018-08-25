Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56D7C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 17:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 405E22173D
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 17:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="T9KzqcXo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 405E22173D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbeHYVeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 17:34:05 -0400
Received: from mail-cys01nam02on0124.outbound.protection.outlook.com ([104.47.37.124]:60808
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726672AbeHYVeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 17:34:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpniL1PH9TW42ttDhccaMZjBXnObCHQiRCi1TMd/yb0=;
 b=T9KzqcXoT49q2bPYWWb/EblDTMoLyBzqnZEGRn2/2LaKfJ6ZZsIq37r+JVKVDIh0KBqM7vHLAanIct3MpoMFm6u9U0iDGQiYBl6Vc2srvjtZ5i3F9aUoViySs+Pt9km+ZLdXipAbYq4bUu5U5wZ/7mb5CPZhYsp8VmbBAF3lCLA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from pburton-laptop.mipstec.com (4.16.204.77) by
 BYAPR08MB4934.namprd08.prod.outlook.com (2603:10b6:a03:6a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.15; Sat, 25 Aug 2018 17:54:20 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     linux-gpio@vger.kernel.org
Cc:     Paul Burton <paul.burton@mips.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: ingenic: Fix group & function error checking
Date:   Sat, 25 Aug 2018 10:53:28 -0700
Message-Id: <20180825175328.16687-1-paul.burton@mips.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: MWHPR2001CA0003.namprd20.prod.outlook.com
 (2603:10b6:301:15::13) To BYAPR08MB4934.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 211833cd-39c8-4d99-89e6-08d60ab3c921
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4934;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;3:fcxQFD3XrK2uP3+uRSu0pVlCG/1IxGc3QhE+FVdZiBzMxV0MI1SyfqRCLm/Sz2rV40W9OBsC16VXhzXDjJn+rPO+NXef9Y+HLQ7Ry6LhYsz1jbCxMbHn88p/EzAkgbeMTqY+01GhpuJiNq+WS/0hbNZh+otJCEvswsWV2or9yqKaCib6ogAigX1cuNcs+D3NvEDpAQUb87TiExctVi/c30GkYcZvTSJRi55yEH0XTjNWd6nrO5puskx1P8PCHuse;25:11vas3CGmtwmlV+FV/LpK+EAwUzqtdPTaGLCS1XV1VQn3Knhz3sVaxI/9gTVawWghpoWhF74Na6qTP7nprl+kpanwr/itn8g+cXW71SevjIkLAliJMSURdOj0qTVx13nxFjN5OAqy0gnvjdqMrodiQq7ZT/2PP0Ag8QXSNApA/xkQgZssVsN10mOvh5xcVnMm2qM8TR+nmJOLXLpd4OaeAvUkB22zzLm0ziaeMm0BxzVcUUGsL2UFrE1ErRP0MwelIBgF2MvuP4kvriTBlC9RjpLyJfcHqk03qAehj5K2z4wLLdvIZk6997QTiHPcwnIpUJl6apAO2broxylPWezTw==;31:zNTa8YCizV/DC+ZAijK6GNXuRgIlRBgxOr06JD2kEfuDufVvXB2D6m93UxtJpnPWwVmhfj4FgE98qupyOkHg1McovNKtKMTY12fiFaOX5xDpra2mRB3lcRy9Qixm9Wx1J/pcrrKEEe8Dmec4sDEOOFFj5O7Z5oittQ1UD2kGxXu4ymLJOllJ+vVetkhAziyo1DciRkcCKG0moHIDkqWJO/jTLqf7+9HVCSfcUG4k7X0=
X-MS-TrafficTypeDiagnostic: BYAPR08MB4934:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;20:Q7CGoQ6BHlxsntVVm8pQK6Tgd24CilA1zNtcTnnAagUQIhOWKfLGdmutxdK1325SUQBBnx2mkGKfPtLTAANIMhwA2kQvh/3GsayKVvKq9KhKzI27boDsBAvjLyh62ceNKSIlIHeDPtK11/XC4FhY6/mWCKH+wKLUJ6BAsS+X15FSrUNaX9Y2EIJYDljF/pojfBDhmdYmkjFx2Eni8ZvFTbPPOTFc4BcJM/h2ffQXqLaG1UUb4zOLs5MiSTGAkHZ0;4:qZWNlrABBqYHvO0kkbmzOc5p4M0iHaCQ/PqEWD++/SP44ObCvBjXGeTakU4p5H+ihd7W2RA2heoZES/bfBfPT87d5jNjvUk8mdiGxNlMSN6JPeRU09mi1let4HaggDG+tg5Rp5SrG4LJHi7JAFa/pN47fIGSLmG7Tg4SPGbmMM+s9YB3c0KFjam2tlYJLiOoE0LwsCmEDDiYPjqEfosYNLf2SyCCHjxTiBTGvplVa1v6IL4HGMcYdoTu8J4Y1+wEMNt6wPiLaJO19cTZK8M4aQ1926MLspkkhtdxjjQAlAti14DbEtjP2Lm9FFfpT8sd
X-Microsoft-Antispam-PRVS: <BYAPR08MB493476E8779B650BCB3977A3C1350@BYAPR08MB4934.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699016);SRVR:BYAPR08MB4934;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4934;
X-Forefront-PRVS: 0775716B9D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39840400004)(366004)(396003)(376002)(136003)(346002)(189003)(199004)(5660300001)(50466002)(48376002)(25786009)(16586007)(54906003)(66066001)(386003)(6506007)(36756003)(6916009)(53936002)(47776003)(6486002)(97736004)(6512007)(316002)(8936002)(2351001)(50226002)(4326008)(105586002)(53416004)(68736007)(69596002)(486006)(44832011)(476003)(2616005)(956004)(2906002)(3846002)(106356001)(6116002)(478600001)(1076002)(81156014)(81166006)(51416003)(8676002)(2361001)(26005)(305945005)(52116002)(1857600001)(16526019)(7736002)(42882007)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4934;H:pburton-laptop.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR08MB4934;23:qb9BtOJ13fL9w5mgIsQ8/J13CsITWAY6VTnviuZyE?=
 =?us-ascii?Q?QMWOmyWjDu9ReFPRF6rQE45KY0I0Ch4zmAM8sHXVvowXKcAY2XyfIKlvTx6a?=
 =?us-ascii?Q?TrNkQHg23DNebeMxIbMc9iWkOll+hxCnwqAq4znSyJQmuSOinxSL278Y7eFK?=
 =?us-ascii?Q?a4GQtq9VVKqH7Co+Qf6OXYg9qFzix/ucOAFMQgjc/cb7RYkKZgnxU3sdxugv?=
 =?us-ascii?Q?Z3/XhS8A1T8jGeaDK5NkdDwR8deEXkWCOWqT1in5YOnWYwqDIIC/m6duAxoT?=
 =?us-ascii?Q?hgANKQc3QwAxwflt1JwxK/p7glM4s8IswXReDDz36iPdk0vEyq7T2lNUuBiw?=
 =?us-ascii?Q?jhnvjBvkFxO6sWnoSFXCEZwwtms/PjOmtfZKkbjnqpa93nc3XDCCpvm4dx5S?=
 =?us-ascii?Q?AwMzJM9RV1r9n41ou3a8L4FWcE7rQjYCvYRUOZ4meDyhUv6W81jGEgakI4jT?=
 =?us-ascii?Q?wx8ukL67JQcCNd1JMOVNRsUrxDIAyfFQv2vzvK24TxPwSZXrE2X2nlu9EK/L?=
 =?us-ascii?Q?ATd305Dty2ypu70roANChSyiwNeqtr2MRdsO4O4/D+yai23atNI/6vPFI66h?=
 =?us-ascii?Q?RF4PN/ke4u2tWrxedb1JiWuQ/cVvFej4sL8aCdcQnMm/2bgH0eF8FYN4Ua8Z?=
 =?us-ascii?Q?rojqRj4thzM02sCzGVF9QcWQCqWL3aKUHH5dejRSS2tHNKAGwF3uTv09YpYS?=
 =?us-ascii?Q?1UAfOK1k3FlrYfpMkn+onNvhSmDZ/xO/Ze30yj8hsgA19DpWMyMjnYynHqPO?=
 =?us-ascii?Q?WMBX+Sa8kMoDoJp0GeZbzoZEgW8cErraClQ2GTzxmcVGmNpHr5Av9L2W8bFO?=
 =?us-ascii?Q?6i1+mD1+G+AqVrq6p7gdruPpCi5vGu6tMm/Ypl/c6GchtDw5t71MQ6Ek12SP?=
 =?us-ascii?Q?QfPJuJPVCV6yHpbJkl1TaD94crYnKOVvv6M0EOvCRnbiQ+f5KPvBTV6Eva/J?=
 =?us-ascii?Q?pZ3fU86VzQmUUOlfM9ttnC6Pindq9GykZtOtGW8zd4l2VeQy5822pq3inl8Y?=
 =?us-ascii?Q?u0swaCKapNDrf1MtGuNQGcomePQeRhLiXwdDvTfmUxsdTwzY7WfjVNjlsROS?=
 =?us-ascii?Q?elYrUd4MN3qtsb8/NIIY4I3qShZ8oC9tEHFGZ2/+FRcPNmVK4R0LgUGB8p5L?=
 =?us-ascii?Q?xnRcQ8tF+2ppVlH2NJTd2Hf5dYMn3PYuTDARmE+6tjIShKMjsl5oy2X2cNbL?=
 =?us-ascii?Q?VcG0O95Uk9EQXxkwddPs7YviAMbL5wiU6ATD6aadHr4x9hwlwRuaaoW0P/EE?=
 =?us-ascii?Q?W+ynNQJYq7sH1VeZqw=3D?=
X-Microsoft-Antispam-Message-Info: eBm/QEp2CPTqv0B/Ep5Ahn0hIHvARsrOPAkikl+vuzZBtSaf3vY3a2DK9PKvfoqJHMD/wExPkXSpj08cn79hRSfmWUkf/sBZAcHUBa5UsbREX5mpBKPA+hl7vISoDQrsRY03WwmbpjrGMuRXB6ys2qkmk38A2fSxdzIClJDl0YaJBWgUG/zQnH6ylN245xn9lQK3qTN5I7vsKVmmKrQhscTq4fZxsdz2u3Xa6tsUeRDvcdn8G0eZA6PSwIBLDKDtZSOTVk6RuN9/jimYoaPoH/3Y9hp7M/b52HYU2Df4Sge/5U2kw0uTEeVCmDoBFDh9BxOHK6YKNZue+CotO52he8Sk1ANf63VoibfAopXdp80=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;6:EljiJjoBS++FjJHzfV3EueIOb3aAkoF16WSHT/NdxI95ZHvK7LN28rI5WFui6PbjaQSU9zfNmvpgPgbNDDc9yrtmnVRakcOiR1NGshGhmZXzJQO06OJCxsprO9iOd9MG007WV1V04kqeFvUuMuC7H5ggtSAXEVVWIx4OtqPdfFWgzFjp5/ezp1Vm1fBtWCaBayI6/rPfi7oWR1etpbiuTIur7GZ0/EWnCXMII5TwIWLWYTiUOGErD8KGZovqWGvLswp7X/Lmd32V7dSQ0/A5LpouJ4iH/CF1c94ayF6zO91xY7Veo+w6cHIjJfS+67mSphkvP3kspQZKe+DVgxdCe7mt7bNYqSQ1Tqbma//7KP0Ks/XSQtYcmt7Z1E30RvoIUL8243Jzl9i0zQOi2NAVadG0yHba1qh84XgcYqYRZ89wwEO06fmi3Yx1w2dud3GCMtPzp+zsz2RABx+3OO481g==;5:PJY/4auCnU5wGOME5dTTtp7CmWt2X5JrMo3nFdy0FelQ3Rys2rPkeQ36ZgbgTg6mMNo7y4Dv/Vdvb6eQ4hQHYa7GybhVuYOvE8k8QyRoK0Jo0r6f9f3H7BVcFv13ETlrc191JSmUT/G5VTNFnbZcz0W028GBhV1asHR/jDx8Wmk=;7:1xxxZaVaK3fGfBh/k/ct50m8gG7Z0emAd8lV4lFvA5BGPm6xFH9JJWA8jVrWOpvqrgqZh2XIOqYPbqFgOZoNhQ+2rGmCPPquUnruBXDvuqjlP8If1b9uXwgJcP1OldK+L18ZU+vtFzIajd/3NgQApeyOh9mZvOE8o1QffkPTjBXXIwNMeLo7jSTCLyQ1jk3ZZ6YhO11RNPYcRfIrJ4A5EUo+OXgxx4JYaCH4SPShs+WF6aNasvsgOeXEOzZ72Npy
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2018 17:54:20.5703 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 211833cd-39c8-4d99-89e6-08d60ab3c921
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4934
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a203728ac6bb ("pinctrl: core: Return selector to the pinctrl
driver") and commit f913cfce4ee4 ("pinctrl: pinmux: Return selector to
the pinctrl driver") modified the return values of
pinctrl_generic_add_group() and pinmux_generic_add_function()
respectively, but did so without updating their callers. This broke the
pinctrl-ingenic driver, which treats non-zero return values from these
functions as errors & fails to probe. For example on a MIPS Ci20:

  pinctrl-ingenic 10010000.pin-controller: Failed to register group uart0-hwflow
  pinctrl-ingenic: probe of 10010000.pin-controller failed with error 1

Without the pinctrl driver probed, other drivers go on to fail to probe
too & the system is unusable.

Fix this by modifying the error checks to treat only negative values as
errors, matching the commits that introduced the breakage & similar
changes made to other drivers.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Fixes: a203728ac6bb ("pinctrl: core: Return selector to the pinctrl driver")
Fixes: f913cfce4ee4 ("pinctrl: pinmux: Return selector to the pinctrl driver")
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Paul Cercueil <paul@crapouillou.net>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-gpio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/pinctrl/pinctrl-ingenic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-ingenic.c b/drivers/pinctrl/pinctrl-ingenic.c
index 6a1b6058b991..628817c40e3b 100644
--- a/drivers/pinctrl/pinctrl-ingenic.c
+++ b/drivers/pinctrl/pinctrl-ingenic.c
@@ -793,7 +793,7 @@ static int ingenic_pinctrl_probe(struct platform_device *pdev)
 
 		err = pinctrl_generic_add_group(jzpc->pctl, group->name,
 				group->pins, group->num_pins, group->data);
-		if (err) {
+		if (err < 0) {
 			dev_err(dev, "Failed to register group %s\n",
 					group->name);
 			return err;
@@ -806,7 +806,7 @@ static int ingenic_pinctrl_probe(struct platform_device *pdev)
 		err = pinmux_generic_add_function(jzpc->pctl, func->name,
 				func->group_names, func->num_group_names,
 				func->data);
-		if (err) {
+		if (err < 0) {
 			dev_err(dev, "Failed to register function %s\n",
 					func->name);
 			return err;
-- 
2.18.0

