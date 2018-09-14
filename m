Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35552FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 07:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6F8A20861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 07:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="bKcX1o7s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6F8A20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbeINMcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 08:32:42 -0400
Received: from mail-by2nam01on0045.outbound.protection.outlook.com ([104.47.34.45]:28288
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727655AbeINMcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 08:32:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50nfndjYyuhnWjICavXOhZZ90kO1Lbajl0CXEeSopHQ=;
 b=bKcX1o7sORxEH7adZ7PtzAex1RzsD+j5EbX9AGK9RpyjwYRyNI909ELc8pEkrY2GG4XAKK9CzZ0PdDnuQVoTa2+gHlViwSH45k4q15uRGlRxPX4mhTlMbb5z+dNH4o8jdyFgOALw6muAFYNZs1YrudH8eHs++4wdcNcxGK9PkDo=
Received: from SN6PR02CA0031.namprd02.prod.outlook.com (2603:10b6:805:a2::44)
 by BN7PR02MB5106.namprd02.prod.outlook.com (2603:10b6:408:22::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.13; Fri, 14 Sep
 2018 07:19:25 +0000
Received: from CY1NAM02FT019.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::206) by SN6PR02CA0031.outlook.office365.com
 (2603:10b6:805:a2::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1143.15 via Frontend
 Transport; Fri, 14 Sep 2018 07:19:25 +0000
Authentication-Results: spf=temperror (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wunner.de; dkim=none (message not signed)
 header.d=none;wunner.de; dmarc=temperror action=none header.from=xilinx.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of xilinx.com: DNS Timeout)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT019.mail.protection.outlook.com (10.152.75.177) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1143.14
 via Frontend Transport; Fri, 14 Sep 2018 07:19:22 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g0iNt-0007WR-Nd; Fri, 14 Sep 2018 00:19:21 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g0iNo-0008KK-KB; Fri, 14 Sep 2018 00:19:16 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8E7JDBd031802;
        Fri, 14 Sep 2018 00:19:13 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1g0iNk-0008Jt-TT; Fri, 14 Sep 2018 00:19:13 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 0E4EA12159B; Fri, 14 Sep 2018 12:49:12 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <michal.simek@xilinx.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <manish.narani@xilinx.com>, <sudeep.holla@arm.com>,
        <amit.kucheria@linaro.org>, <leoyang.li@nxp.com>,
        <broonie@kernel.org>, <arnaud.pouliquen@st.com>,
        <eugen.hristev@microchip.com>, <rdunlap@infradead.org>,
        <geert@linux-m68k.org>, <ak@it-klinger.de>,
        <freeman.liu@spreadtrum.com>, <lukas@wunner.de>,
        <vilhelm.gray@gmail.com>, <gregkh@linuxfoundation.org>,
        <kstewart@linuxfoundation.org>
CC:     <sgoud@xilinx.com>, <anirudh@xilinx.com>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 2/4] iio: Documentation: Add Xilinx AMS sysfs documentation
Date:   Fri, 14 Sep 2018 12:48:28 +0530
Message-ID: <1536909510-7166-3-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1536909510-7166-1-git-send-email-manish.narani@xilinx.com>
References: <1536909510-7166-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(1496009)(346002)(396003)(39860400002)(136003)(376002)(2980300002)(199004)(50944005)(85664002)(189003)(16586007)(42186006)(486006)(476003)(54906003)(478600001)(110136005)(76176011)(126002)(2616005)(63350400001)(72206003)(8676002)(426003)(63370400001)(26005)(446003)(48376002)(44832011)(6666003)(50466002)(316002)(11346002)(6266002)(336012)(90966002)(186003)(51416003)(36756003)(81156014)(8936002)(39060400002)(81166006)(106466001)(7416002)(52956003)(5660300001)(2201001)(4326008)(305945005)(2906002)(47776003)(50226002)(356003)(103686004)(36386004)(63266004)(107986001)(921003)(2101003)(83996005)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR02MB5106;H:xsj-pvapsmtpgw01;FPR:;SPF:TempError;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT019;1:RGkANYp/kaBaQdyHabHVjdafxDr9g72z4voZn97rrOg+qpEPPxI+ZmM4ww2sG7JS7Dqea2DkMvX6/fdgdsiJMRna9mI0X2oX7fe7ZnURvVQeDx3ct9Uqugwhd6e9TqKX
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 033e961c-601b-4ea7-c58c-08d61a1265a3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060);SRVR:BN7PR02MB5106;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5106;3:N/PDYqzufRw6sRnXQsyKTVjVDj9O2b+mHcTDfpMA7d4HTm7ZKPHuhAOUI3C0CeMK472HgNDf0kMHTb7rI6sYnZ0KzQjuPWz2bb5HagcphQu3ok2GdW8IjmYhr5cCI5Ta74eAbVieWEjgtGT5Pcjyvlr8nsfhdHgWxQzuNtNaevnRd72/5MF9r8NHJY6hfpzcNgYqxfw0yVbUXzBkeH0rSmuy+2bVfisH3psDFbi8HAlSwVzVSqEtUffqcPUonNqJ5Ulk/6kWmHZAArgZWBX+bo2w3UhN5U1WfW77vxcMVYs6OioYrRO5JC3+IjUfiLubD3Zoklp9LhlHOPKBQUjjqUZQ9s/12YALmDaITOt3ahM=;25:1qUx4T9J68oR46fox2JWufhE8gRmRxseEVm+usjeD5+MgCQ1kvnly5Tt/N1r/hIHECdQ5lUZj5E9ZO7bKRKjS1DnAEA88j8LEjr5EPyvbVcIcsV9AoUk5NherhtlEVndUmRIeqYCEVq+Qr28NO4vbTONMSoES0yBqqAa2FCVYe3hRVpZB+uyB13gPGwqgy8R9AWsvd+vzCCSnYja0AI7L6kwaYh+KS0wKsOOTSlVpbH1EfLKPhEe4+0/TKuNWQEPELpXDG78RU+4Yxw9+zG9T5e9jd/wYat8dJ657davNMm5Cx2kEgqBfH4RzkImaroAhFNPJaG2e8VuAPhOPxUgLg==
X-MS-TrafficTypeDiagnostic: BN7PR02MB5106:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5106;31:WmvvgiGQaIwpvBPbGq04qf39bRrFHjQRDYqDyrd6jhjlAgmFGH7jQx3rBRNgYjg/7Pwk37tX2qSWlzUpVcg51sBTt1+Xx+7yucKvlT+241LxFnjmAoteTsisATcxBZoGyf/k5hsAQp6m7hzS6cMbQtxLHnftaqLDOkizwLlrUtgSitPGhfFADYUANOR3f612ChdZTlKHh9depZToJIFp+tImV8i1O5aBD3k57B9vgAU=;20:lO59a+bgL7zEHIIgiFEUizRzJj5vsVHclcneUMk2UxxL17ENhh87HdQW92Zzfif8bGT14Lttm+/txqfDBZKoxKNNtSGkzIDprKWlgdD1m/Z7FsF6GHTIXCzNx3q+64YRZ+9mPXNW3bVZralhU/pigrgtDpiGr8XULpgG4Py79cuMxX7fYCTDxjiMgwgJTWetCCsi720W0LQogbfPGv2IJ4sw81Uc1Q6ii6NmAK1qY5/1vLPloxjBa1YLFGzCKriW6M8SeOEw7ozFjCfkx7TboTYC5W5+7Q/Va+NcV8ZtRGY/bbZJxC/RuHLVYEpeWJCT/swUATkTJkRPwIg6quu79JwCYeoQkFq3tvpP6Yngf+mMY4Uxccfx9s31MxCLMBkMfVJlQy1fAQ1FKJFj34Wfb0Jo0shEyp4zoTJybBFc5mmns1VMl0P7hbrKOLVfH/MSF+GQ+lLvEnExSQnI+r77JklCo7v7J0B881wQ2Qi5sA1OWl7l925WmZKFSWJwiZUP
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN7PR02MB510660E3DD6030F3C5FE252FC1190@BN7PR02MB5106.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72170088055959)(192813158149592)(269456686620040)(105169848403564);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:BN7PR02MB5106;BCL:0;PCL:0;RULEID:;SRVR:BN7PR02MB5106;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5106;4:OLAH9Uypc5+UBwqbeqh3qVagwFtTi+2xtqZ3WnA4MACjAjTWysRn+TtCy3LFDKP8V9inkxM1D/Mq6x9wnrd/N5WJznUSvmSmPqoJWZ4x92+oYlj5E5VLdZWI/3kPW4SXi53iW1iPVUlaJN2dyfBo8ktPGZiMOAVqczI9oZZ4ByC7IRWN1Ter1tYpmNCiMwXYxcDEUhSokEYz05u8OeRfpp+lDdiGFl5UYDG9uiiwEVhlI7KNX99IF8D3zoeHFYx16HYfXsWx4fFaTqdtpzWpIP0SiPTXgMERN4BAn2zQANdj9q62lHv5DvIHGtvg28REa8m+LZCYsO/TfHEdR93NYKjMtBLo3su6afyAvSgJnihLdzIGe+IhG/6lgBcbPv9DDwM6QcWOq/DAPeOTlMvnLQQj64uQfJRcni7SpR0ZsAs=
X-Forefront-PRVS: 07954CC105
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR02MB5106;23:oILLgVJlOfxW2f2rZo4k8BRP7Mh0oLxrv+Z7gfJ54?=
 =?us-ascii?Q?EP2x2oEhu/3llFSo3i9USQKPK7Riq//MxLkjVzv7g/8Pp17+MqO2sdRZ9DSI?=
 =?us-ascii?Q?hBTZ/4EDh7ifs7pgYg1lCyDvi9uFqtNiZfM+ljd7SI9beDM5PqIUTbhY5vFc?=
 =?us-ascii?Q?g1x/TBxrujU9e7N3vciP7Ypo41viyl1z7pEx4fmu8HS7rbWFSQg7xcH+yfYP?=
 =?us-ascii?Q?X8j2mmdHNMYc3q7bv1TDu8adgSgRHDi5V8ST2+S+EhQJAq0ekiGxnlksENz+?=
 =?us-ascii?Q?VRmd4Dm0qcewz/1UK3Jp2vtVQmqmT41ySWc5s49VRXIZnV5GjgKbFcfXzKD3?=
 =?us-ascii?Q?CJNaevAKy/Vhmg/jda6Y2XcZoKIXwuJ0Bg6CTrePzlzqPbw5OUlhcAnyNsF7?=
 =?us-ascii?Q?mPNk2G4LwlX9GUvf+OClZefgiFJhm14eXWXHwEiDPbivOYl47oyo/V+zQv3P?=
 =?us-ascii?Q?Lu7d7o2/nTMJo+BNnhbo2IM/XuVz4Pt+8d0VW0AsTUf6awiLjBGPo3wsg80z?=
 =?us-ascii?Q?x4ki2RHloIajIkW6UHo8LahCVg0/WO7G5FuHP+t386v+b5DTGfufj1qNyEDf?=
 =?us-ascii?Q?pInpr69fMXUgo4gkraVG6YgovW0b5J6kuLHqHPfeMuOkrg2OQUf26JbEOHDl?=
 =?us-ascii?Q?DgUSVOdGJIc+VycAd4uNNA7M3Wosr/VPnoyBjq01WhyXirJCD1Ybji3xHViv?=
 =?us-ascii?Q?VUf+LhIIaVzOP0wFr70HgZdwqjv4PVSszfNSRRSuFb/B/CtmV7INpNpwIa+b?=
 =?us-ascii?Q?7pnoQhKJdaQCY0jFRzAaLqoqIkFnNYTXOdV9KII8C0Jn3LN7/jJSZwZhD+dN?=
 =?us-ascii?Q?CwsczvB/BKuKnuGbTlcTk5c+xzy0iybKe7YJwz+pUc33s2JHq+yF5JEOgq4Q?=
 =?us-ascii?Q?C43hcrg8cAbwPr5ddg+bWq3fhEpO4jZCNFnHdlDfLYnezkv65boZ8jZDT3nH?=
 =?us-ascii?Q?EMKoaD08400RZdsuVzI0CwYUO5leH/kAZjJ4J9Yv1Fg0FRI+u5Bd6UbTCUrI?=
 =?us-ascii?Q?Kl2rsp98t8b+AZFy0KCZ3pzqj/bbcMTLzvdkah7c3PWZxQxrbP7isN3ykUmJ?=
 =?us-ascii?Q?nPTGyvMDPsgkX7z3XKw8Omy3g4D8R9vzbwlc4OrKmbf3KQF16R2Z7g8IYQTv?=
 =?us-ascii?Q?Cv4slfiRYJJ8T7rWV+6tTn6YbrKgCuMDAe/OdpJ/ibkWCqsbZ4Ddjjkd6+Rl?=
 =?us-ascii?Q?hblCVt6QynTb16wqv2BZqEdDSVF7f2Vyz9sqvfJ1QSNNpOM+INzz5t0N/H/Q?=
 =?us-ascii?Q?22PTZpcB6pkiSRFkjwBs6nE+eGeFjea53P4TV29lZsUwm6ITjoQZjbWVgoFs?=
 =?us-ascii?Q?+FXaQZoRIiEs/1Meye0u8qnebwN6L4ua80jba6k+PY+t1IXOWn68gmWy7TXH?=
 =?us-ascii?Q?pHMs68muGxYENpr/bhEUkwmrWf4VIukvDHwZAWz7vg9t556?=
X-Microsoft-Antispam-Message-Info: x92nHG7nrAXNg3WBE5p58hjWETgtVJ255g7F2DHHmhee4xdGnJkrDIb7WE7viW+Esav1ehaeVCQix/qRf0BhHHHneBlotJnu2tUwQKvutTqH17d8A4mFogwftm3e0QV/7olKdvCffPTNPiOyl6UtpcqEbQMaRwIK3X8HTCImXp+zOZrOUAxycCnvGPnMZPdAiel5Hwn2jALgtAONifYjFYPw7myvVnQPENwIR02TG3s//NSC+tiSWKk7nGFrhi6mvpxYdsNozDlIccdsmGtfc1FQugXlCCENoyHfL9H8iy7WIAPvps4MPv5C3hsjc2E/vDp+p5COJQL4WlgRgIbu64rdyLDxzLZ4a2wEbNSH9hQ=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5106;6:pu9pUK8hbxhvPSq3DnXazF/EVXpG+PmzKEHTsq3vxh66L1BpqqAhEW3/c0g7T3sIDTP5xyHtF4z4KHIU4VAIuNiIifObyKg2Q8av/+yQk3zRRhCBTj57fXTWhbLSrJORSvk8uxBvKtVmkdcCGan1yuJlwUPH76uagAkfhYUix1cfYpIK/wNezpW1NNEytaHJuLYctljlfqTCVKAbqaEe0IstN3ZV9rEp5vlrlckUclJ1WlgE5uFVZa0yVelr0P8W+Jcrvr6gM6O3DlVv0dv9+Y3/Ai1IX2S51hVktJsWd9I/4a++nJgSmvHCxJOj0JguIIrnBBT280rnOLAdAWdYC+3dTX49NENZQKIwPCRBK77W9/6eZJxk47umCgi7R+fSjcxU9cJaXjUiEPDnCeq4wXhSyH72mIjAH72eiOp2hRWU5Km9j7HbCy6MWSGoitjESpxVSwWRBlWtENi+LCrH7g==;5:JG2BZYYrg+UhTnYvDLP5Jdlx1hb1RINgZNrXE4pVA3eInzwORPsYn/Ck6nMYvV+i0QSZd5/0KkDU6M47VCPca1+/7DvEcqcWeXUrVTgJJPvGQTayD7ZAHEGXlUPQ+070koMfftYHq4TIUhRQnbDkEWKon1a671VFeAZi54TANlk=;7:FjmUGINkRZsIfb0xScUAvyZ2/yMmRhfXKaZ5Lr7787gBV+COrkZIabWY+JWdVpbuZDTBnrCluncSbJ36Fo2PdGXuRgyg7TLvVArXSHjySm7pkr1f81bCP7ZOqbIn1cyqApTOgKEjstWvoo+Kl8QMtROv42wIesIxXEkrSZtyXmEyVA9fAsCPRrsGyWWi89/A6F7VOlWF/gt8UjZ65rGS9dWQ3H62YcfdXl+agg3Hn4t9LuEdmu9USIvTlq6o0P+L
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2018 07:19:22.2406
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 033e961c-601b-4ea7-c58c-08d61a1265a3
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for xilinx-ams driver. This contains information about
various voltages and temperatures on PS (Processing System), PL
(Programmable Logic) and AMS Control Block.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 .../ABI/testing/sysfs-bus-iio-adc-xilinx-ams       | 246 +++++++++++++++++++++
 1 file changed, 246 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-xilinx-ams

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-xilinx-ams b/Documentation/ABI/testing/sysfs-bus-iio-adc-xilinx-ams
new file mode 100644
index 0000000..589c389
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-xilinx-ams
@@ -0,0 +1,246 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_vccpsintlp
+Date:		September 2018
+KernelVersion:	4.19.0
+Contact:	mnarani@xilinx.com
+Description:
+		Voltage input for PS (Processing System) LPD (Low Power Domain)
+		power supply.
+
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_vccpsintfp
+Date:		September 2018
+KernelVersion:	4.19.0
+Contact:	mnarani@xilinx.com
+Description:
+		Voltage input for PS (Processing System) FPD (Full Power Domain)
+		power supply.
+
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_vccpsaux
+Date:		September 2018
+KernelVersion:	4.19.0
+Contact:	mnarani@xilinx.com
+Description:
+		Voltage input for PS (Processing System) Auxiliary power
+		supply.
+
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_vccpsddr
+Date:		September 2018
+KernelVersion:	4.19.0
+Contact:	mnarani@xilinx.com
+Description:
+		Voltage input for PS (Processing System) I/O bank 504 (DDR
+		PHY) power supply.
+
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_vccpsio3
+Date:		September 2018
+KernelVersion:	4.19.0
+Contact:	mnarani@xilinx.com
+Description:
+		Voltage input for PS (Processing System) I/O bank 503
+		(boot, config, JTAG, SRST, POR) power supply.
+
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_vccpsio0
+Date:		September 2018
+KernelVersion:	4.19.0
+Contact:	mnarani@xilinx.com
+Description:
+		Voltage input for PS (Processing System) I/O bank 500
+		(MIO[0:25]) power supply.
+
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_vccpsio1
+Date:		September 2018
+KernelVersion:	4.19.0
+Contact:	mnarani@xilinx.com
+Description:
+		Voltage input for PS (Processing System) I/O bank 501
+		(MIO[26:51]) power supply.
+
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_vccpsio2
+Date:		September 2018
+KernelVersion:	4.19.0
+Contact:	mnarani@xilinx.com
+Description:
+		Voltage input for PS (Processing System) I/O bank 502
+		(MIO[52:77]) power supply.
+
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_psmgtravcc
+Date:		September 2018
+KernelVersion:	4.19.0
+Contact:	mnarani@xilinx.com
+Description:
+		Voltage input for PS (Processing System) GTR SerDes I/O
+		power supply.
+
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_psmgtravtt
+Date:		September 2018
+KernelVersion:	4.19.0
+Contact:	mnarani@xilinx.com
+Description:
+		Voltage input for PS (Processing System) GTR SerDes
+		terminators power supply.
+
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_vccams
+Date:		September 2018
+KernelVersion:	4.19.0
+Contact:	mnarani@xilinx.com
+Description:
+		Voltage input for PS (Processing System) SYSMON ADC circuitry
+		power supply.
+
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_vccint
+Date:		September 2018
+KernelVersion:	4.19.0
+Contact:	mnarani@xilinx.com
+Description:
+		Voltage input for PL (Programmable Logic) internal power supply.
+
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_vccvrefp
+Date:		September 2018
+KernelVersion:	4.19.0
+Contact:	mnarani@xilinx.com
+Description:
+		Voltage input for PL (Programmable Logic) ADC positive V
+		reference power supply.
+
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_vccvrefn
+Date:		September 2018
+KernelVersion:	4.19.0
+Contact:	mnarani@xilinx.com
+Description:
+		Voltage input for PL (Programmable Logic) ADC negative V
+		reference power supply.
+
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_vccplintlp
+Date:		September 2018
+KernelVersion:	4.19.0
+Contact:	mnarani@xilinx.com
+Description:
+		Voltage input for PL (Programmable Logic) LPD (Low Power Domain)
+		power supply.
+
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_vccplintfp
+Date:		September 2018
+KernelVersion:	4.19.0
+Contact:	mnarani@xilinx.com
+Description:
+		Voltage input for PL (Programmable Logic) FPD (Full Power
+		Domain) power supply.
+
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_vccplaux
+Date:		September 2018
+KernelVersion:	4.19.0
+Contact:	mnarani@xilinx.com
+Description:
+		Voltage input for PL (Programmable Logic) Auxiliary power
+		supply.
+
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_vccvpvn
+Date:		September 2018
+KernelVersion:	4.19.0
+Contact:	mnarani@xilinx.com
+Description:
+		Voltage input for PL (Programmable Logic) Analog Input Pins
+		power supply.
+
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_vuserZ
+Date:		September 2018
+KernelVersion:	4.19.0
+Contact:	mnarani@xilinx.com
+Description:
+		Voltage input for PL (Programmable Logic) Fabric Analog Wires 
+		power supply. Z is the number in range of 0 to 3.
+
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_vcc_pspll0
+Date:		September 2018
+KernelVersion:	4.19.0
+Contact:	mnarani@xilinx.com
+Description:
+		Voltage input for AMS (Analog Monitoring System) Systems PLLs
+		power supply.
+
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_vcc_psbatt
+Date:		September 2018
+KernelVersion:	4.19.0
+Contact:	mnarani@xilinx.com
+Description:
+		Voltage input for AMS (Analog Monitoring System) Battery power
+		supply.
+
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_vccbram
+Date:		September 2018
+KernelVersion:	4.19.0
+Contact:	mnarani@xilinx.com
+Description:
+		Voltage input for AMS (Analog Monitoring System) Block RAM power
+		supply.
+
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_vccaux
+Date:		September 2018
+KernelVersion:	4.19.0
+Contact:	mnarani@xilinx.com
+Description:
+		Voltage input for AMS (Analog Monitoring System) Auxiliary power
+		supply.
+
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_psddrpll
+Date:		September 2018
+KernelVersion:	4.19.0
+Contact:	mnarani@xilinx.com
+Description:
+		Voltage input for AMS (Analog Monitoring System) DDR I/O
+		PLLs [0:5] power supply.
+
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_psintfpddr
+Date:		September 2018
+KernelVersion:	4.19.0
+Contact:	mnarani@xilinx.com
+Description:
+		Voltage input for AMS (Analog Monitoring System) DDR controller
+		power supply.
+
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_tempY_ps_temp
+Date:		September 2018
+KernelVersion:	4.19.0
+Contact:	mnarani@xilinx.com
+Description:
+		Temperature input for PS (Processing System) RPU MPCore.
+
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_tempY_remote_temp
+Date:		September 2018
+KernelVersion:	4.19.0
+Contact:	mnarani@xilinx.com
+Description:
+		Temperature input for PS (Processing System) APU MPCore.
+
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_tempY_pl_temp
+Date:		September 2018
+KernelVersion:	4.19.0
+Contact:	mnarani@xilinx.com
+Description:
+		Temperature input for PL (Programmable Logic) SYSMON.
-- 
2.1.1

