Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FA7ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8849C20833
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="W+3lZsa3";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="ZMaOWti2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8849C20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733106AbeITVJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 17:09:33 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:38389 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727162AbeITVJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 17:09:33 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8KEqC3s025323;
        Thu, 20 Sep 2018 07:56:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=48uZw/gNhHvVq64SIoXnupfa/mJYZ+o3F6Ryu/42IVM=;
 b=W+3lZsa3DMxBFIzrMDgJvSu/3lTVfgVxsKr5ssFvMnUp31vYXv6twRQeMS3oqa4QIfAv
 vjUPtPNDu/FpMx/cAbpdvaKGaeqaHYP7dToH3z4CqFW1GGkAGvj1LAdvQ4DEWQaK4faY
 BCy0HWj1YrnbAinkY2furGUP7pvheA3XuGZzVzMgfmVt0vPilJQVOPtZXuwplw3Qgq/N
 JNNQcp+HuKgiGQWxEbvuamkZc2KAt2YCi1EW5rJCsaUnY7+2bltZ3SM7aOkiDYCp3bXW
 cCP3hgaZebxVpkkhdFADC/ipO+35DZaTHcQugbrFaUdZn56L+r93sICqi4nQaF2rJjf/ rw== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=dkos@cadence.com
Received: from nam01-by2-obe.outbound.protection.outlook.com (mail-by2nam01lp0176.outbound.protection.outlook.com [216.32.181.176])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2mm4h1a6tw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 20 Sep 2018 07:56:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48uZw/gNhHvVq64SIoXnupfa/mJYZ+o3F6Ryu/42IVM=;
 b=ZMaOWti2hyWfGbB9RqgEH5fN/0NbZ4pkodCHT+EhrHwbaNax/ZObfcSbIc/c+njVgrJfu1GHJLz2ZXY//tj9PJGu2a7zBGBpu+DWhGyr1GpvvCDXgm+buZJMrD/p51lLlI4xImR1xXdczALQwm3Cr/J/rj8PfaLnO+G+u7fKjEc=
Received: from BYAPR07CA0062.namprd07.prod.outlook.com (2603:10b6:a03:60::39)
 by CY1PR07MB2166.namprd07.prod.outlook.com (2a01:111:e400:59d7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.18; Thu, 20 Sep
 2018 14:56:02 +0000
Received: from DM3NAM05FT006.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::202) by BYAPR07CA0062.outlook.office365.com
 (2603:10b6:a03:60::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1143.15 via Frontend
 Transport; Thu, 20 Sep 2018 14:56:02 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM3NAM05FT006.mail.protection.outlook.com (10.152.98.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1185.5 via Frontend Transport; Thu, 20 Sep 2018 14:56:00 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w8KEtsWR002306
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 20 Sep 2018 07:55:59 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 20 Sep 2018 16:55:58 +0200
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 20 Sep 2018 16:55:58 +0200
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id w8KEtn3L022232;
        Thu, 20 Sep 2018 15:55:49 +0100
Received: (from dkos@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id w8KEtn2q022231;
        Thu, 20 Sep 2018 15:55:49 +0100
From:   Damian Kos <dkos@cadence.com>
To:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>
CC:     <dkos@cadence.com>, <pgaj@cadence.com>, <ltyrala@cadence.com>,
        <stelford@cadence.com>, <jartur@cadence.com>, <piotrs@cadence.com>,
        <quentin.schulz@bootlin.com>, <jbergsagel@ti.com>,
        Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH v4 4/5] dt-bindings: drm/bridge: Document Cadence MHDP bridge bindings
Date:   Thu, 20 Sep 2018 15:54:39 +0100
Message-ID: <1537455288-20223-5-git-send-email-dkos@cadence.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1537455288-20223-1-git-send-email-dkos@cadence.com>
References: <1537455288-20223-1-git-send-email-dkos@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(376002)(346002)(2980300002)(189003)(199004)(36092001)(486006)(76176011)(7416002)(50226002)(8936002)(2906002)(8676002)(305945005)(7636002)(106466001)(356003)(5660300001)(36756003)(246002)(4326008)(6666003)(26826003)(87636003)(47776003)(478600001)(50466002)(51416003)(446003)(105596002)(126002)(336012)(11346002)(2616005)(186003)(316002)(42186006)(476003)(86362001)(26005)(575784001)(16586007)(426003)(110136005)(48376002)(2201001)(54906003)(21314002)(921003)(83996005)(1121003)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR07MB2166;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT006;1:nAVarPn+4W+xZy3fpOrvlASmSZHDEMNMme4xHjCi5JVOoDkcYB7A5lW5wAxCsC+z9aTQuFX51Ok0AuZNn8XODByLv9eZ0Q069cRWpXPS8M26/L0boLVbxoaXZIDB3ljD
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bcf92a10-becd-4750-f6ca-08d61f092ebf
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060);SRVR:CY1PR07MB2166;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2166;3:TaCfKqyG4zhtFpldbAvHkcU9KqC5CXZQ/FLzpvOwWDz4A3D0XUpblIEgAq4sneuMlZc/bvNZTdD/zgmyhRoSaToeGMrIttC09OiqQqnNogq7ludSM6IJjroF1jyEm9ZGpSQ/dTLWvWxPkwmK3L6MnKZbRLRq9zwn7Yx1wuVxNjF9Tz49NTDofPDefM5sfLq0EPF7r/7WYAhhqEU6dTV+pvQe+Pfl4rBWJ+S7TGW7i5UlgoOBiLe5QbHeOij9be358ElmAJ3Atz/UJJy4IvRt3kx5Dh/wETvAwe00axxRfkX7uLJvxmUn1JSJoGXNZPRkKmuwCI73iBg+kOPLin0RG0Br2rs7xvu61wCoY827PEw=;25:xge8VBQZzzc6IR0OnhVqBW1nxuR3Q29LjLMwtBRkXsFVKBjLwJHxWjPd6t/vn4VE2Vw72wD4kOSyRvV1OZcunQwYJDRxmvLzPowTaZ5eWoxA27vGUCcDwJfeBXEVaxwlxOs2sfuWtnhCTHpF32g2LMWrkQo+WoWhhCRKmbEIZ6Lf6ekBlPKB+z+BCnayxHKXScZPR3RTsN4bn/lPPlrKeT7/Om8DNKx9PrfydP1s4471AzYdfH7IU7zoGrwivF/B1j5uKNTbC28RaasM9UpVIdOlQBIkTSywhU/m/qlL9O7rJVPM8PPFb704iuatI5ZpIrhOuXjIvJuZIcev4qwYxQ==
X-MS-TrafficTypeDiagnostic: CY1PR07MB2166:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2166;31:4Q/sYg/UBDOsB2LDMtbl6QC0QQkhf8qkgiotr6pa/dcUTtGJ9Q3UczawHpE4S8z2QjjhLORqMtWbBkPk3KpbB0MBSzLlLFxgOHEBnfKuJeIUv39eeU/zFlfd1edVJ82gHrc3T0QJ1uAC0Ig6vj/cJK8Gt1naaQ4+7hkqF9muOqSPUUhOwfCl9SszRsBfH+qQy3HHta9wrJf/fZZqCshlNYihHC6bXNwsx+E3GeHhZBQ=;20:iGkTfpkNarRmJYsTOyNExwYYOzm7RRQH7WlpFZe9Sbogtsob5PW08Pqk9f8Smfk/XOhnQ6WpkXHriCCB3/JObVzYPKLWAA9fmLY1VLPZlhnP4++P2Xd3+ufjKCyFUSik2g/5kPnIHTi1X5JaYzeiLzSV/LAtRg9l7Zrr3Bj0ATDWmuY377rxKdUMK/6wtUMhigfVGHzyCQ3CFF4sp7xkRz1Ru3ZXyEumv07vq1Zb7cs5RSjPRHxQHsydba//4AzmT4OpZC9bwPUimlxJbUbh/3Oo24GYqK1yU561JUr98l1V+UsPaTeE5CXwYIx0gT/ac3/6qDz4/dcXEYxqv2sq+dryifwAy5tYyTaOT23XZ0sOnv0WngIR0qw8CL4Ups4myeK64EHMi0X6GP6vQo6JgnUgzRzBwR8nbHCbQyte9DMQ2aPJLr3UuGbPthIkE+fLwbsKDQt0hwSTVX/JFNO8FG+XUL6It1a+IlOIiLP9fslQV8mulELnMsh7CQJ43T6t
X-Microsoft-Antispam-PRVS: <CY1PR07MB2166C0BA2F756EC633F5C6BCCD130@CY1PR07MB2166.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(58145275503218)(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93003095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051);SRVR:CY1PR07MB2166;BCL:0;PCL:0;RULEID:;SRVR:CY1PR07MB2166;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2166;4:yYvfemzNAWkP+SMx9PzqUBq+5xlBkMnp/Bed7YktNaSPp7ggXMRVzcv2SQWLO5wU37wu5jUPQX4CRu/C6TiQaMXlHX72MojnEIHjyjoajDFmW5Ft+/Ubh/sJDH9yNYCuXVjDtbOeTWSrS/EsMibreFVAhl3pUx8x4/2H+rNx0wU7isoblNiF04CojuvbGfOue5QO/RS3INQmN560daAIw9PVwHXJhSAyWN7RJy9NSsuKtmqgllJCvcCfieUoIqtFB99NAAgDYJT4USj+rTf06RLCIT8Kpc34CkPNBo0tBWXDWJg/STB0WogzbdU4Er7DL/7Zmj1XSwGYSusy5LnYPNwz4M7cfbqUwVagxnrbnZ0=
X-Forefront-PRVS: 0801F2E62B
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR07MB2166;23:5TnmzQ7lQx8Uy7evIyEEauhFE9CEjdJ3GFBFBSjwW?=
 =?us-ascii?Q?2KFHvfUOjiG+htP6sy6/EYA8D6pxgA4ux4RW70jMRAPK99zeM2EvKNLTIMmz?=
 =?us-ascii?Q?X+qBYDWsXfTxVWxsWgGpfePMBXpEY/a6fGz0DhY6qJ8lXrWJK8jKi8CDkweF?=
 =?us-ascii?Q?N+0DaYasduu7tCCbbhay74KhsGOlUJX/CbEDASQ0L6lHHV5ft5GMZXqnm7ul?=
 =?us-ascii?Q?Myh42tCxT+RSpPWgiiQ964fA9CwMEet0VOOYGBVKp2E/cPUqx3xWLQtVdAeC?=
 =?us-ascii?Q?J2eKnEATFncz7hGZ7OMZvIA0NAS/Ry+VCBKm2+22G7Tkc2MyShPXg/ict1nO?=
 =?us-ascii?Q?XR1zPkgR2XsarlDHQis1IFLgbRGXKqmLkmSvmnDl+PmBUHUBGkQhXUHaXwE+?=
 =?us-ascii?Q?XtRtcFUsfzAj5ZK7qj2naRl1GDLBR6E5SqYHm0xqBvkRGp3fd4cpK5e3ENzS?=
 =?us-ascii?Q?+CU8MFGQIV35LeJzcReMxAzMchfsYjVc9ynSI89Dy1pRGy4lblm+Oc4t7Eed?=
 =?us-ascii?Q?Z6mW76/YZ+WsYZigxjY00f+BsbyEh8Rb7bWSJHLi1JQ+32XlgJH5Zr4YSGtN?=
 =?us-ascii?Q?1oYSvAbtJG08VrIs6GNkTnj5BZeAc/OMG+zcVXzWkZQd0tEh0BJq7R/93EZu?=
 =?us-ascii?Q?605rn7gSPwk/5erKsdUDdGNqzKS2KTrd62Qz1IpSY3mY3oOp8+xiPIzWHnvj?=
 =?us-ascii?Q?NuNVlC5peMKLM4ml7tEeIowEqte+3u0cESadE+SO+PfbLt3UvbMbXG0ycZ7F?=
 =?us-ascii?Q?zLMBcwylWARa0O/8XvnqFTzWP1oAK94qLyygvjyHZzS0734h0lYNz9jvRXd/?=
 =?us-ascii?Q?/pSTsW8XtGPBNOYkjwF2fh7or2xuA8HFWRoldzOUjnzw1uMVoPEmh8ygsWAP?=
 =?us-ascii?Q?GCanKEzFTtWyDbDC0gEgbxofW2FZCBQ/HGqi+Wa0UG6ZJb3fqzuuhrBF8zlr?=
 =?us-ascii?Q?o2IMKICXMGyW4uiUOoRiKrlfBALfElqN4pVfShVrfFih970ioZmxUAEahjgf?=
 =?us-ascii?Q?X6dKaP3oZ2ERyAUUlVTHnwkfZ9Kdmqt9BXZDwB54N9Qujr68DHcL7iOtfrW2?=
 =?us-ascii?Q?F/WG1CAQdK8bz923/5L68X5XUTeHgvZ9RBTQV0XXkq0n/AFKK0OdXv6//NR5?=
 =?us-ascii?Q?DlFqIMvSuORRwY9grFW57doceZsc4Pt+DZLogArT3iH3KN2qgiEyrHn3dyBn?=
 =?us-ascii?Q?NCFb+7jUTgW/YIm9IXhg+i5f2rk6vP5jDTD?=
X-Microsoft-Antispam-Message-Info: +nmFnVABU5ORpYYnd5ZGlyxk1hQXhwmp30RSLei6sH+nTFPi5tVYaY4ML9mGrCMaxvyn+1txjn9DZBoNNs36yQQhy4l0AVHUpJpLbwGsxfvFar7+YEv+IhKp96v2/3aPYutpJT0uDCD75MMMV9gomB8lMsBggbEC5r2eaiPBV++glAmJS7347gD8zII2xme+VUJf3MnXm9VjBO8ScKUCpjEbA02HiJkG+zUKKr6B8xs6gA9RvS/4ay6SLYHTkqHq4X/ukf1STsk8tXrTNhQtjuxRVBewwDlgBHEg6icPNc4mhrBlRAuiY+ic1LfFFoOHZ36eSNi+o+MGBMu6TC/CC3FEPxEhkWf0qS/XFrF920OyerJjVwo9n/grezh6YQr6/7jL3TKmevkLrRrowDHTcA==
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2166;6:tMLwn+MRhL7vL3RqjybGYor+D4VoGVxOL8JkPp8wGP3Wy6qOMA+L36XBB0ecsw2yPxJxmQVRbfNWSmGWWuqMhqEeVTUN2qjq9ukg9LPHx2ThiK2PNHO43gjJuQOjE/x7fc95igazFq/42i+aE0phvtF3RAbUn0aVFsIZIfjVooZBWZ9kRYRbOQ2sYpGVuI93Ow/je/DrupyI/Ie8C8WLo2gwKeuCuoxuT/dZfLNFal7QfpXc4cCO8QOR3Wh6PqR7DFljvTRsC4I6BV+4RUSK9Mra7YSp4/g/KUpA7/4VtyAdXEejaZY8UGuM7rQ0BHlgggtRSoaKDhEm/YBHOVSE5FW9+N2189dnCjwc7BoBAHiuFusUGw7d5LAbPBPb+WvjzRwgxfZPKwhWqevZWeHzDTYwzkYYaW2GdYLLmoqrjgwozQxyYlK1Oekt4l/FXpPcoWKRhPfmOcvKEeyyysWPTw==;5:m3V5e2kCyLXuwZk9JRwxBfIkTFkdgfbEeAimCevvjSPkVxT4jkLnrdTRA0oUzIaHt6FvBHWjg66Ja24wtNlhTYCRhqfZHMEAK2XyQnMGQCsbqY2Ufh2jJnITjk7cEUSXnLfjNBtdy8l4L909DkQPI8iEomLa4CEDS4/DIYQYI5c=;7:4UqK0ectj6xvAByB4Ved4+sCqDCzpqavpdPLItAOvRelrg+zCd7xPHTY+Qzy5NgLF3kj8HlAhixNP+LTKi+7yiltu4/hiqRHjOAa87zLumyNxsAv6w3DUXUbVKk88KxoPSbFVU7cSw2ywSzDMAbIP9b4Rl8X5BCbe908/xERgooQg72Ywq4FBHcxyTUXqW88+AxEA7qJFXVyFXQ/u+a3pjrHnNnq2D5SJdGXYL1EsNavC7CSdGGWkS9T4aVm7xZe
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2166;20:QBgIxnBo6OaXfYzmYnTLjXpfLdpjf5uHVqZYScsrDv3+h1IWf+00USxgnfVbIC9wPQ4qkxWjZpQ4XiiqwbAtzEBQ57i5EtPCqqD2NU+11iWO+zjC04Kt0ZuCA+kVw4eJL4zQvWlYpYLXBjleNv8D1mwHW/BS9GxZOSu15U8QDQIgKc+ntUoCL7eiDvU7JaWEhZ5W8HzA944e3GkpJ+gk4EmffHh/cU88yx2ed+3y5yyTFum5hY86q+RQfa7W7z6Z
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2018 14:56:00.9940
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcf92a10-becd-4750-f6ca-08d61f092ebf
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR07MB2166
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-20_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=794 adultscore=4
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1809200147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@free-electrons.com>

Document the bindings used for the Cadence MHDP DPI/DP bridge.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Signed-off-by: Damian Kos <dkos@cadence.com>
---
 .../bindings/display/bridge/cdns,mhdp.txt     | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/cdns,mhdp.txt

diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp.txt b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp.txt
new file mode 100644
index 000000000000..f8334c520b98
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp.txt
@@ -0,0 +1,43 @@
+Cadence MHDP bridge
+==========================
+
+The Cadence MHDP bridge is a DPI to DP bridge.
+
+Required properties:
+- compatible: should be "cdns,mhdp8546",
+- reg: physical base address and length of the controller's registers,
+- clocks: DP bridge clock, it's used by the IP to know how to translate
+	a number of clock cycles into a time (which is used to comply
+	with DP standard timings and delays),
+
+Required subnodes:
+- ports: Ports as described in Documentation/devictree/bindings/graph.txt
+	Port 0 - input port representing the DP bridge input
+	Port 1 - output port representing the DP bridge output
+
+Example:
+
+	mhdp: dp-bridge@f0fb000000 {
+		compatible = "cdns,mhdp8546";
+		reg = <0xf0 0xfb000000 0x0 0x1000000>;
+		clocks = <&mhdp_clock>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				dp_bridge_input: endpoint {
+					remote-endpoint = <&xxx_dpi_output>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				dp_bridge_output: endpoint {
+					remote-endpoint = <&xxx_dp_connector_input>;
+				};
+			};
+		};
+	};
-- 
2.17.1

