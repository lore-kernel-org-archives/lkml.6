Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123D8C070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 07:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88EEE20861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 07:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="gu7qu+Z4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88EEE20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbeINMcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 08:32:54 -0400
Received: from mail-dm3nam03on0078.outbound.protection.outlook.com ([104.47.41.78]:18512
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727300AbeINMcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 08:32:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KY9Ez2DB9AFYIrU6ssaAPdP5CeeWGuFe2k0rmarTQKk=;
 b=gu7qu+Z4Waj94sD7jH1P1PDvF+HShyzpMjaWOyicBpnaarDVvMXfJT2BgNjb9+sFgjqc00kaDWB6PAsP6mujSt8F4iPMz2ZjIfe9JLICWEM3vqTtLnYJO3Dnonh8wItQqSAiR9DyeSnAyjyLpaTia+W1hR0++CXAnXTsmxvIHcc=
Received: from BYAPR02CA0036.namprd02.prod.outlook.com (2603:10b6:a02:ee::49)
 by BYAPR02MB4469.namprd02.prod.outlook.com (2603:10b6:a03:10::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.15; Fri, 14 Sep
 2018 07:19:33 +0000
Received: from BL2NAM02FT063.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::202) by BYAPR02CA0036.outlook.office365.com
 (2603:10b6:a02:ee::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1122.18 via Frontend
 Transport; Fri, 14 Sep 2018 07:19:33 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wunner.de; dkim=none (message not signed)
 header.d=none;wunner.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT063.mail.protection.outlook.com (10.152.77.121) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1143.14
 via Frontend Transport; Fri, 14 Sep 2018 07:19:32 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g0iO3-0007Wh-S7; Fri, 14 Sep 2018 00:19:31 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g0iNy-0008LT-PJ; Fri, 14 Sep 2018 00:19:26 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8E7JGTC031810;
        Fri, 14 Sep 2018 00:19:16 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1g0iNn-0008KD-9t; Fri, 14 Sep 2018 00:19:16 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 7914D12159B; Fri, 14 Sep 2018 12:49:14 +0530 (IST)
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
Subject: [PATCH v2 3/4] iio: adc: Add Xilinx AMS driver
Date:   Fri, 14 Sep 2018 12:48:29 +0530
Message-ID: <1536909510-7166-4-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1536909510-7166-1-git-send-email-manish.narani@xilinx.com>
References: <1536909510-7166-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(1496009)(396003)(39860400002)(136003)(376002)(346002)(2980300002)(438002)(189003)(199004)(426003)(336012)(478600001)(39060400002)(186003)(47776003)(48376002)(14444005)(50466002)(90966002)(53946003)(72206003)(8936002)(26005)(50226002)(36386004)(5660300001)(106466001)(106002)(6666003)(42186006)(16586007)(110136005)(316002)(52956003)(51416003)(4326008)(356003)(44832011)(305945005)(76176011)(54906003)(2201001)(6266002)(575784001)(63266004)(81166006)(7416002)(11346002)(476003)(126002)(2616005)(446003)(2906002)(486006)(36756003)(8676002)(103686004)(81156014)(921003)(107986001)(83996005)(2101003)(1121003)(579004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4469;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT063;1:TZAEfKL003IHXH8cfOUC+PbElSw7w/omYfP4RO3jALgUbuNVolF8pM+kXBsGtzH1DIXJN+qsmEN7WZ9wn8p4ayXXojkQt/WySuwcKF7xLqVhXq62dldW5WAyz2maEll4
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f12e3841-461b-41f2-3907-08d61a126b37
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB4469;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4469;3:mFPeK7MhElbvQoL1lkiq8eSCucikkjDaG5NN+tHkafJMGvA+aommZRNI0y2KxHoGPK5xrEfHsS1JngLMMdg6thUl9OjRj3W8k447+p/bfXeGPKgmb40kBFx/onHa6Ph4mx9wjzHrza29GJ0dQp6pKSUOrGIy6PJ3uJkqIfr41p03b8inADFn6s7MFCrJPOlXo15RVwiOd1hWU1FU3wFCJ0vHJ71MdDqCEAabWCN8xwp3ktZDBbwVXMigV5d1wAev1V1ovSUW6DvaTA+VahzBOIhNzbfN0RsP5JhF/fWNU9QMOoaZVqSomsNC2k1Jp8Bvvbh2H3bbkaiQM2aSrNZz5VDgn6a70uvZbqziVfuosvQ=;25:6EVGTL9IxirNYbQZDULoJwvD1y6Nzao5NtoL7HD4yVP678X6JOdd6aqH0GPcxxDcgWWSOxPoQgjk2D1fBZLgLcgf/7zodsB+xbsNB0QPmfrRQOwo/jrzMyahYG7dDWFmwuwLPm5/gRcOq23fZi3Xyy/rFHAJ/BvzW5IGpOeJ9EnBjeVgFAASZjXGUzlQjjILRuyyLGDVsX6vcLWVsQFcsORtGoBlXI8MIzYCh+tgfPmPsNM/s8Fe08MIbvTrLLhP1g6+5/nK1pi5DCj/yCSsWT5HuKpoGJlBoWSxjvDppFjiqSWIMCAzchVWQrSjd+NzNob5+DXmd/uwRV+b6h17fg==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4469:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4469;31:H/jc7myoPYd8lTi7xmYjlfwMKUAb1qW/iSZE3Ztrj2a0Pt0H0B4yfbEp3dFm9U/VgAPK04a+2/Su179HEuBomMplkB9pdl2xazA9bRbgDSEpzsHQ6nkjfXKGrhRDcVzNwbYLyBLLIztL6X3po3VhSgAPupD6QCNCVEiRNt2YHuehrWfjh7oEz5IR2bDXadZbv9TxNcEYgIePVXWIBTsFffSdF4oih0BqWHhYwX2uXjA=;20:PRF0U9pB9JiI5gfyCHpYgnwYDsFqrRZwPEtNtGVsf3r3C/VZzLtNCHOjFyG0XAZyviWYxK2Sw9BMFqtke4fIDnhhyT8xvLRnCsvUJhAp+CDbEnOc9Sann7JWPlzpyUZHLBHiMYGFcLAGS7LsFnD39hG8QO+MnWdBvdTT+FzyEnEQKyv+XD4S49RRrvfWGz92l6gASieI3XndpxvZOKyqJgaGVq2EgeS7vPjvnyVoXrRHyTmdaNOQZbN6UtAPXoLKOZW7n/04NmJ0Op67x2pSK7cZa5kCWA4h86LyvOSeVO0aY/PcCCECKLQ7wsMgTzItgvBfWLrv4+a5w7+CGRJX2jz/8KCjSQ6e5mpvC6TmRkMRmlySQGrfmPvOK4JO+drUu9k8OPKAJrA2zDDanmXCWleX6KpE8xlFJKsZ6k5gOhhl4bDrZ4xDpYxumyElkapMbL1pstgGOX2BFN3f8eJyuh0/TwsWiQoE62yMmdUsRQIegMwwj0x1qT7UZu2LSCvx
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB446927E7A6790F5B1F19468EC1190@BYAPR02MB4469.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72170088055959)(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699050);SRVR:BYAPR02MB4469;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4469;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4469;4:RB732/GPuWc8o8xYY2pZ0rYyuIUnX7++xO4sIaU251l6tXcrHQvPyzUg3ReKoV47xSQ2jf0mOPV0yPBnQvx0r0M0Ynwh7brjiIlEJXAb845Mc4BOxK/ipQVm2h+8EuulmV3vzfRKHw8C/ghn6DFI4qk1/UzN3BORe+1szZ1NximrsLFNHcoIThSuRwtACqppVGDC2xP7Bju3ksLVXRJI2dnC4Gt1zVLNoa5mwdKrFNh4oDFvKEV1FQD00/hNWFJn0PKPc2EjK1f9IyPnR3ebyJw48tLD2YDb8UptDYY+t9lDCaXMecHoVQ0BrRKY5YB6MUKNOfJD/4jGWiiexPtbzsyzkQWcQs+Vr3jAfpoTq54=
X-Forefront-PRVS: 07954CC105
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4469;23:Lkb+VphIfhoezaS1EMln01TLxlDrqLt/88m0d1/os?=
 =?us-ascii?Q?kPP3YrIEk/IpMET5iFmLDZtLS4LrzwYULSaJYtV0VO9822POqjJT0MSBK3qw?=
 =?us-ascii?Q?aU8knuW4Ol9I/EpGlqyfC7snpMSltTPdjJty9yDym7VoKmqVUx7eOWk4UsUQ?=
 =?us-ascii?Q?aOegL5A/EVoeL/eGcEEJrbAWKRVEvUCuZNP93y+HW9D1VFVXxxXaXmeAnU/n?=
 =?us-ascii?Q?GpvUAa3i4kD/7lWVgD71AGoHI5XsMpeacZsm/o5iB7EeLQQP685f6MEczSmj?=
 =?us-ascii?Q?pEhFk5SvbRLRGcyaEaPsu0tH+jthxowkTF1n/6VM8okafAWLTpRjv5ndoOeJ?=
 =?us-ascii?Q?BMaTrMqa1aaDawxT97XDZ4N3QBii0WIV2ALjicvYPEPVzWUGUYbZKl6vJ2h/?=
 =?us-ascii?Q?uKTG51s6VewiJyVpBAMqrIDVo7a90kw2SLTJmWvstPRPvhEwsCTBlg5Iqt/M?=
 =?us-ascii?Q?YqrTMCIpVURRV8FwZes47sWKy+PTlpP4cRUfno/Fd6j/e+Ra/QHApR1yCnIJ?=
 =?us-ascii?Q?55pXfIc+IZfmPn3VM4t5ovhMPuiLwqTxlSA/HVnAGZ3hA8b+dPjy2YouvObs?=
 =?us-ascii?Q?+tuIMVHq+xwcui9TL4GSN8f41EOpndoqqh1antUsZPt2KbYM9BkXrVIqR6SF?=
 =?us-ascii?Q?tHPXX8SzbCcW2+gZiP3x/Wf07ar9k0vEU7+rMkEZC85uFbPdj2gdWF/s+Q0b?=
 =?us-ascii?Q?8XKhjJr7GPshiDcZoxdYtSuMavo+Dc3n51gBzrL38HkMz53SSU71Joi6ma2g?=
 =?us-ascii?Q?qNCg+REQ/3QSMeBT+96t1zSm77RDWOXQ0IdEL+FeVAtkYSfaFaVeSX7NYawI?=
 =?us-ascii?Q?9BOCsUBemThZZ/aLRszyAKbGssjGxeBDm/SFPiwrq+ZeDdK+HMjdZvvM4C/r?=
 =?us-ascii?Q?sX+5nCewajr1I0wDLI5tHOI9phFTTf/Kza/vnKsZYvsppMnEAMi1afMGQvZt?=
 =?us-ascii?Q?VJ0QEAp0MxtjGlXznt7us4Lbnb8ale1DPOUJl3Yw8jjuFikkaYgolCG37NNr?=
 =?us-ascii?Q?Es+Quv1VnudYstSSbcUV4DAaQQtu/tFCaa7kEPtPkFH4XIAWLBqtO4lIqPk/?=
 =?us-ascii?Q?JjEYPMqXZ+9jQh5xrT6Qdp1RXNl0+Lo2CIsL0sislxF8/5geGlezUNaqxhU8?=
 =?us-ascii?Q?pBchgd39IIP24V0T4HnBgZdb7Bt1Jl+8THDAj9GnZ1lkzj2IXcoNh+xQLzT2?=
 =?us-ascii?Q?z/qVksROyUej6OVb7fQw3YgBzqGJ7lNKSYEY3coTXhF09vA9neB4HlcNSjRi?=
 =?us-ascii?Q?P/CRAcnFULZ9lYiIf2nMe50UdFYlfM3SKngdiRUTtB6BOMSheZIACSzUch7n?=
 =?us-ascii?Q?JhZOw0XeP5r6DQcO2C/C1SGuIBJeKb+oUWVw167cQwAxttRE2eRAYyRkIkh1?=
 =?us-ascii?Q?57Z41riSBplmQKBsyr83XjxpDAqS5S8yrmYDM/6BUHCnbiHYw9pRo0Y++PWV?=
 =?us-ascii?Q?n2TOVMBrw=3D=3D?=
X-Microsoft-Antispam-Message-Info: vJNrzeJv6hJspYU9bE4ty5bbdzKoz4ils7d9jn7Ut0xKZGxhz36mi22cBnT8XIIXylR8kTIXLfMIUvqCZrDQEZQSymAy4mzDia1X89yXscUKiXkvIHV3h3n0k6JN2GwHuaZWFOJEk1/pyH/+O0eqs9iNPxMeAwHpbJitiABLg7cIj1QrxtEY4N7Pu8EylxxZKnujOMCnTQJYlZzTyur5/8l9yHHaEp8yxdKqbkWewsM5z99CGSxFglRm7cUPU1WR2bdRFb22IHHhrPekeSod9lywKU5THaSd24UgZpgqbR/x6s3smsktPXIt16voamA5YYdsAaMwL32SuEqkL4+LbKDL7WXlk0Y6/GiiDl45lLs=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4469;6:T5uZn1ShTiF8Nv5yaUxMaUCS9BcmbuTKo5WERmmr4nJR/GQx90QPEaNVJjpEppeVnGWIIb06g4mUOeoI3ipOYROPNAHsvRPju5FGxYIaNCYSHmqGJG5nKWNxm4/L9sq1K0pWJ0CSvGV+lgqnQe2XgwsM5vUh1JjsARLe9JCsLx/3XhWUhYogTH8YVqw0hCguqNcJOOTZIYh9oJZupyT+YLHCkuqaAeJBG8X27aduOMEjDLEe89Wee/7EMTElnXeYy+kdT93rdQXq88A25xVw+qKipixReaTPbwOTad4h/iL3FFVimYCzmSlvv+d3Bmy3F6weCwxGVVtXb3xF3TpQmR0iQBnwLTVY6xbH4wWHHNS2jKCCxTE45KFA8TEpmTREHgR13EnuusQRXymeICbNNsYaG6LMUEb0DF1y1Hbu/vfRSjOvbV5kQ+IH3VKXNXeoB6yPrdx37poq/Jai+dVz5A==;5:Ar6ZT6i/diIEAf+Eij4VCCYCzfnUhufzC402y98Oqv28OmGEpig6m/4W0MlvRLY4vulE8NC9vToHE61c5eNMl0+ksTDgOhG7JhkM7YNHDVfOx71Hk4BLYBoXskKtIPnvZZcrnPXETAZowtmT54EqtoTe1dDSny26YwqFMJ1oZmw=;7:HwoHyaAspll39zex9uVVqGQzaukrLyamLhjtIWUL9bhYEttnDD8xMUHcmKvZxvRfGJfKTaZ19pkL/kj5sJ8BY0cbw56+7zOwZSWsTzM7Zq3jleHxpYpxeG51ZziLAbNXvLCjU0+8obhytjoPmk9x5XLMuUlSszHeO9YiunwzyqKgyhdv6IgXZUHigC/pbU+34JUbtKjard0ntpWDZxxqZ7yu+E2Z443Z7OoGr+hIrDLbCDVOxG2J9HMGKlPg5JXi
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2018 07:19:32.5487
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f12e3841-461b-41f2-3907-08d61a126b37
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4469
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AMS includes an ADC as well as on-chip sensors that can be used to
sample external voltages and monitor on-die operating conditions, such
as temperature and supply voltage levels. The AMS has two SYSMON blocks.
PL-SYSMON block is capable of monitoring off chip voltage and
temperature.
PL-SYSMON block has DRP, JTAG and I2C interface to enable monitoring
from external master. Out of these interface currently only DRP is
supported.
Other block PS-SYSMON is memory mapped to PS.
The AMS can use internal channels to monitor voltage and temperature as
well as one primary and up to 16 auxiliary channels for measuring
external voltages.
The voltage and temperature monitoring channels also have event
capability which allows to generate an interrupt when their value falls
below or raises above a set threshold.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/iio/adc/Kconfig      |   10 +
 drivers/iio/adc/Makefile     |    1 +
 drivers/iio/adc/xilinx-ams.c | 1337 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1348 insertions(+)
 create mode 100644 drivers/iio/adc/xilinx-ams.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 4a75492..405ea00 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -941,4 +941,14 @@ config XILINX_XADC
 	  The driver can also be build as a module. If so, the module will be called
 	  xilinx-xadc.
 
+config XILINX_AMS
+	tristate "Xilinx AMS driver"
+	depends on ARCH_ZYNQMP || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  Say yes here to have support for the Xilinx AMS.
+
+	  The driver can also be build as a module. If so, the module will be called
+	  xilinx-ams.
+
 endmenu
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 03db7b5..fbfcc45 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -85,4 +85,5 @@ obj-$(CONFIG_VF610_ADC) += vf610_adc.o
 obj-$(CONFIG_VIPERBOARD_ADC) += viperboard_adc.o
 xilinx-xadc-y := xilinx-xadc-core.o xilinx-xadc-events.o
 obj-$(CONFIG_XILINX_XADC) += xilinx-xadc.o
+obj-$(CONFIG_XILINX_AMS) += xilinx-ams.o
 obj-$(CONFIG_SD_ADC_MODULATOR) += sd_adc_modulator.o
diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
new file mode 100644
index 0000000..c239a02
--- /dev/null
+++ b/drivers/iio/adc/xilinx-ams.c
@@ -0,0 +1,1337 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx AMS driver
+ *
+ *  Copyright (C) 2017-2018 Xilinx, Inc.
+ *
+ *  Manish Narani <mnarani@xilinx.com>
+ *  Rajnikant Bhojani <rajnikant.bhojani@xilinx.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include <linux/iio/events.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+static const unsigned int AMS_UNMASK_TIMEOUT_MS = 500;
+
+/* AMS registers definitions */
+#define AMS_ISR_0			0x010
+#define AMS_ISR_1			0x014
+#define AMS_IER_0			0x020
+#define AMS_IER_1			0x024
+#define AMS_IDR_0			0x028
+#define AMS_IDR_1			0x02c
+#define AMS_PS_CSTS			0x040
+#define AMS_PL_CSTS			0x044
+
+#define AMS_VCC_PSPLL0			0x060
+#define AMS_VCC_PSPLL3			0x06C
+#define AMS_VCCINT			0x078
+#define AMS_VCCBRAM			0x07C
+#define AMS_VCCAUX			0x080
+#define AMS_PSDDRPLL			0x084
+#define AMS_PSINTFPDDR			0x09C
+
+#define AMS_VCC_PSPLL0_CH		48
+#define AMS_VCC_PSPLL3_CH		51
+#define AMS_VCCINT_CH			54
+#define AMS_VCCBRAM_CH			55
+#define AMS_VCCAUX_CH			56
+#define AMS_PSDDRPLL_CH			57
+#define AMS_PSINTFPDDR_CH		63
+
+#define AMS_REG_CONFIG0			0x100
+#define AMS_REG_CONFIG1			0x104
+#define AMS_REG_CONFIG3			0x10C
+#define AMS_REG_SEQ_CH0			0x120
+#define AMS_REG_SEQ_CH1			0x124
+#define AMS_REG_SEQ_CH2			0x118
+
+#define AMS_TEMP			0x000
+#define AMS_SUPPLY1			0x004
+#define AMS_SUPPLY2			0x008
+#define AMS_VP_VN			0x00c
+#define AMS_VREFP			0x010
+#define AMS_VREFN			0x014
+#define AMS_SUPPLY3			0x018
+#define AMS_SUPPLY4			0x034
+#define AMS_SUPPLY5			0x038
+#define AMS_SUPPLY6			0x03c
+#define AMS_SUPPLY7			0x200
+#define AMS_SUPPLY8			0x204
+#define AMS_SUPPLY9			0x208
+#define AMS_SUPPLY10			0x20c
+#define AMS_VCCAMS			0x210
+#define AMS_TEMP_REMOTE			0x214
+
+#define AMS_REG_VAUX(x)			(0x40 + (4*(x)))
+
+#define AMS_PS_RESET_VALUE		0xFFFFU
+#define AMS_PL_RESET_VALUE		0xFFFFU
+
+#define AMS_CONF0_CHANNEL_NUM_MASK	(0x3f << 0)
+
+#define AMS_CONF1_SEQ_MASK		(0xf << 12)
+#define AMS_CONF1_SEQ_DEFAULT		(0 << 12)
+#define AMS_CONF1_SEQ_CONTINUOUS	(2 << 12)
+#define AMS_CONF1_SEQ_SINGLE_CHANNEL	(3 << 12)
+
+#define AMS_REG_SEQ0_MASK		0xFFFF
+#define AMS_REG_SEQ2_MASK		0x3F
+#define AMS_REG_SEQ1_MASK		0xFFFF
+#define AMS_REG_SEQ2_MASK_SHIFT		16
+#define AMS_REG_SEQ1_MASK_SHIFT		22
+
+#define AMS_REGCFG1_ALARM_MASK		0xF0F
+#define AMS_REGCFG3_ALARM_MASK		0x3F
+
+#define AMS_ALARM_TEMP			0x140
+#define AMS_ALARM_SUPPLY1		0x144
+#define AMS_ALARM_SUPPLY2		0x148
+#define AMS_ALARM_SUPPLY3		0x160
+#define AMS_ALARM_SUPPLY4		0x164
+#define AMS_ALARM_SUPPLY5		0x168
+#define AMS_ALARM_SUPPLY6		0x16c
+#define AMS_ALARM_SUPPLY7		0x180
+#define AMS_ALARM_SUPPLY8		0x184
+#define AMS_ALARM_SUPPLY9		0x188
+#define AMS_ALARM_SUPPLY10		0x18c
+#define AMS_ALARM_VCCAMS		0x190
+#define AMS_ALARM_TEMP_REMOTE		0x194
+#define AMS_ALARM_THRESHOLD_OFF_10	0x10
+#define AMS_ALARM_THRESHOLD_OFF_20	0x20
+
+#define AMS_ALARM_THR_DIRECT_MASK	0x01
+#define AMS_ALARM_THR_MIN		0x0000
+#define AMS_ALARM_THR_MAX		0xffff
+
+#define AMS_NO_OF_ALARMS		32
+#define AMS_PL_ALARM_START		16
+#define AMS_ISR0_ALARM_MASK		0xFFFFFFFFU
+#define AMS_ISR1_ALARM_MASK		0xE000001FU
+#define AMS_ISR1_EOC_MASK		0x00000008U
+#define AMS_ISR1_INTR_MASK_SHIFT	32
+#define AMS_ISR0_ALARM_2_TO_0_MASK	0x07
+#define AMS_ISR0_ALARM_6_TO_3_MASK	0x78
+#define AMS_ISR0_ALARM_12_TO_7_MASK	0x3F
+#define AMS_CONF1_ALARM_2_TO_0_SHIFT	1
+#define AMS_CONF1_ALARM_6_TO_3_SHIFT	5
+#define AMS_CONF3_ALARM_12_TO_7_SHIFT	8
+
+#define AMS_PS_CSTS_PS_READY		0x08010000U
+#define AMS_PL_CSTS_ACCESS_MASK		0x00000001U
+
+#define AMS_PL_MAX_FIXED_CHANNEL	10
+#define AMS_PL_MAX_EXT_CHANNEL		20
+
+#define AMS_INIT_TIMEOUT		10000
+
+/*
+ * Following scale and offset value is derived from
+ * UG580 (v1.7) December 20, 2016
+ */
+#define AMS_SUPPLY_SCALE_1VOLT		1000
+#define AMS_SUPPLY_SCALE_3VOLT		3000
+#define AMS_SUPPLY_SCALE_6VOLT		6000
+#define AMS_SUPPLY_SCALE_DIV_BIT	16
+
+#define AMS_TEMP_SCALE			509314
+#define AMS_TEMP_SCALE_DIV_BIT		16
+#define AMS_TEMP_OFFSET			-((280230L << 16) / 509314)
+
+enum ams_alarm_bit {
+	AMS_ALARM_BIT_TEMP,
+	AMS_ALARM_BIT_SUPPLY1,
+	AMS_ALARM_BIT_SUPPLY2,
+	AMS_ALARM_BIT_SUPPLY3,
+	AMS_ALARM_BIT_SUPPLY4,
+	AMS_ALARM_BIT_SUPPLY5,
+	AMS_ALARM_BIT_SUPPLY6,
+	AMS_ALARM_BIT_RESERVED,
+	AMS_ALARM_BIT_SUPPLY7,
+	AMS_ALARM_BIT_SUPPLY8,
+	AMS_ALARM_BIT_SUPPLY9,
+	AMS_ALARM_BIT_SUPPLY10,
+	AMS_ALARM_BIT_VCCAMS,
+	AMS_ALARM_BIT_TEMP_REMOTE
+};
+
+enum ams_seq {
+	AMS_SEQ_VCC_PSPLL,
+	AMS_SEQ_VCC_PSBATT,
+	AMS_SEQ_VCCINT,
+	AMS_SEQ_VCCBRAM,
+	AMS_SEQ_VCCAUX,
+	AMS_SEQ_PSDDRPLL,
+	AMS_SEQ_INTDDR
+};
+
+enum ams_ps_pl_seq {
+	AMS_SEQ_CALIB,
+	AMS_SEQ_RSVD_1,
+	AMS_SEQ_RSVD_2,
+	AMS_SEQ_TEST,
+	AMS_SEQ_RSVD_4,
+	AMS_SEQ_SUPPLY4,
+	AMS_SEQ_SUPPLY5,
+	AMS_SEQ_SUPPLY6,
+	AMS_SEQ_TEMP,
+	AMS_SEQ_SUPPLY2,
+	AMS_SEQ_SUPPLY1,
+	AMS_SEQ_VP_VN,
+	AMS_SEQ_VREFP,
+	AMS_SEQ_VREFN,
+	AMS_SEQ_SUPPLY3,
+	AMS_SEQ_CURRENT_MON,
+	AMS_SEQ_SUPPLY7,
+	AMS_SEQ_SUPPLY8,
+	AMS_SEQ_SUPPLY9,
+	AMS_SEQ_SUPPLY10,
+	AMS_SEQ_VCCAMS,
+	AMS_SEQ_TEMP_REMOTE,
+	AMS_SEQ_MAX
+};
+
+#define AMS_SEQ(x)          (AMS_SEQ_MAX + (x))
+#define AMS_VAUX_SEQ(x)     (AMS_SEQ_MAX + (x))
+
+#define PS_SEQ_MAX          AMS_SEQ_MAX
+#define PS_SEQ(x)           (x)
+#define PL_SEQ(x)           (PS_SEQ_MAX + x)
+
+#define AMS_CHAN_TEMP(_scan_index, _addr, _ext) { \
+	.type = IIO_TEMP, \
+	.indexed = 1, \
+	.address = (_addr), \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
+		BIT(IIO_CHAN_INFO_SCALE) | \
+		BIT(IIO_CHAN_INFO_OFFSET), \
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+	.event_spec = ams_temp_events, \
+	.num_event_specs = ARRAY_SIZE(ams_temp_events), \
+	.scan_index = (_scan_index), \
+	.scan_type = { \
+		.sign = 'u', \
+		.realbits = 12, \
+		.storagebits = 16, \
+		.shift = 4, \
+		.endianness = IIO_CPU, \
+	}, \
+	.extend_name = _ext, \
+}
+
+#define AMS_CHAN_VOLTAGE(_scan_index, _addr, _ext, _alarm) { \
+	.type = IIO_VOLTAGE, \
+	.indexed = 1, \
+	.address = (_addr), \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
+		BIT(IIO_CHAN_INFO_SCALE), \
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+	.event_spec = (_alarm) ? ams_voltage_events : NULL, \
+	.num_event_specs = (_alarm) ? ARRAY_SIZE(ams_voltage_events) : 0, \
+	.scan_index = (_scan_index), \
+	.scan_type = { \
+		.realbits = 10, \
+		.storagebits = 16, \
+		.shift = 6, \
+		.endianness = IIO_CPU, \
+	}, \
+	.extend_name = _ext, \
+}
+
+#define AMS_PS_CHAN_TEMP(_scan_index, _addr, _ext) \
+	AMS_CHAN_TEMP(PS_SEQ(_scan_index), _addr, _ext)
+#define AMS_PS_CHAN_VOLTAGE(_scan_index, _addr, _ext) \
+	AMS_CHAN_VOLTAGE(PS_SEQ(_scan_index), _addr, _ext, true)
+
+#define AMS_PL_CHAN_TEMP(_scan_index, _addr, _ext) \
+	AMS_CHAN_TEMP(PL_SEQ(_scan_index), _addr, _ext)
+#define AMS_PL_CHAN_VOLTAGE(_scan_index, _addr, _ext, _alarm) \
+	AMS_CHAN_VOLTAGE(PL_SEQ(_scan_index), _addr, _ext, _alarm)
+#define AMS_PL_AUX_CHAN_VOLTAGE(_auxno, _ext) \
+	AMS_CHAN_VOLTAGE(PL_SEQ(AMS_VAUX_SEQ(_auxno)), \
+			AMS_REG_VAUX(_auxno), _ext, false)
+#define AMS_CTRL_CHAN_VOLTAGE(_scan_index, _addr, _ext) \
+	AMS_CHAN_VOLTAGE(PL_SEQ(AMS_VAUX_SEQ(AMS_SEQ(_scan_index))), \
+			_addr, _ext, false)
+
+struct ams {
+	void __iomem *base;
+	void __iomem *ps_base;
+	void __iomem *pl_base;
+	struct clk *clk;
+	struct device *dev;
+	struct mutex lock;
+	unsigned int alarm_mask;
+	unsigned int masked_alarm;
+	u64 intr_mask;
+	int irq;
+	struct delayed_work ams_unmask_work;
+};
+
+static inline void ams_ps_update_reg(struct ams *ams, unsigned int offset,
+				     u32 mask, u32 data)
+{
+	u32 val;
+
+	val = readl(ams->ps_base + offset);
+	writel((val & ~mask) | (data & mask), ams->ps_base + offset);
+}
+
+static inline void ams_pl_update_reg(struct ams *ams, unsigned int offset,
+					 u32 mask, u32 data)
+{
+	u32 val;
+
+	val = readl(ams->pl_base + offset);
+	writel((val & ~mask) | (data & mask), ams->pl_base + offset);
+}
+
+static void ams_update_intrmask(struct ams *ams, u64 mask, u64 val)
+{
+	ams->intr_mask &= ~mask;
+	ams->intr_mask |= (val & mask);
+
+	writel(~(ams->intr_mask | ams->masked_alarm), ams->base + AMS_IER_0);
+	writel(~(ams->intr_mask >> AMS_ISR1_INTR_MASK_SHIFT),
+			ams->base + AMS_IER_1);
+	writel(ams->intr_mask | ams->masked_alarm, ams->base + AMS_IDR_0);
+	writel(ams->intr_mask >> AMS_ISR1_INTR_MASK_SHIFT,
+			ams->base + AMS_IDR_1);
+}
+
+static void ams_disable_all_alarms(struct ams *ams)
+{
+	/* disable PS module alarm */
+	if (ams->ps_base) {
+		ams_ps_update_reg(ams, AMS_REG_CONFIG1, AMS_REGCFG1_ALARM_MASK,
+				  AMS_REGCFG1_ALARM_MASK);
+		ams_ps_update_reg(ams, AMS_REG_CONFIG3, AMS_REGCFG3_ALARM_MASK,
+				  AMS_REGCFG3_ALARM_MASK);
+	}
+
+	/* disable PL module alarm */
+	if (ams->pl_base) {
+		ams_pl_update_reg(ams, AMS_REG_CONFIG1,
+				    AMS_REGCFG1_ALARM_MASK,
+				    AMS_REGCFG1_ALARM_MASK);
+		ams_pl_update_reg(ams, AMS_REG_CONFIG3,
+				    AMS_REGCFG3_ALARM_MASK,
+				    AMS_REGCFG3_ALARM_MASK);
+	}
+}
+
+static void iio_ams_update_alarm(struct ams *ams, unsigned long alarm_mask)
+{
+	u32 cfg;
+	unsigned long pl_alarm_mask;
+
+	if (ams->ps_base) {
+		/* Configuring PS alarm enable */
+		cfg = ~((alarm_mask & AMS_ISR0_ALARM_2_TO_0_MASK) <<
+			       AMS_CONF1_ALARM_2_TO_0_SHIFT);
+		cfg &= ~((alarm_mask & AMS_ISR0_ALARM_6_TO_3_MASK) <<
+				AMS_CONF1_ALARM_6_TO_3_SHIFT);
+		ams_ps_update_reg(ams, AMS_REG_CONFIG1, AMS_REGCFG1_ALARM_MASK,
+				  cfg);
+
+		cfg = ~((alarm_mask >> AMS_CONF3_ALARM_12_TO_7_SHIFT) &
+				AMS_ISR0_ALARM_12_TO_7_MASK);
+		ams_ps_update_reg(ams, AMS_REG_CONFIG3, AMS_REGCFG3_ALARM_MASK,
+				  cfg);
+	}
+
+	if (ams->pl_base) {
+		pl_alarm_mask = (alarm_mask >> AMS_PL_ALARM_START);
+		/* Configuring PL alarm enable */
+		cfg = ~((pl_alarm_mask & AMS_ISR0_ALARM_2_TO_0_MASK) <<
+			       AMS_CONF1_ALARM_2_TO_0_SHIFT);
+		cfg &= ~((pl_alarm_mask & AMS_ISR0_ALARM_6_TO_3_MASK) <<
+				AMS_CONF1_ALARM_6_TO_3_SHIFT);
+		ams_pl_update_reg(ams, AMS_REG_CONFIG1,
+				AMS_REGCFG1_ALARM_MASK, cfg);
+
+		cfg = ~((pl_alarm_mask >> AMS_CONF3_ALARM_12_TO_7_SHIFT) &
+				AMS_ISR0_ALARM_12_TO_7_MASK);
+		ams_pl_update_reg(ams, AMS_REG_CONFIG3,
+				AMS_REGCFG3_ALARM_MASK, cfg);
+	}
+
+	mutex_lock(&ams->lock);
+	ams_update_intrmask(ams, AMS_ISR0_ALARM_MASK, ~alarm_mask);
+	mutex_unlock(&ams->lock);
+}
+
+static void ams_enable_channel_sequence(struct ams *ams)
+{
+	int i;
+	unsigned long long scan_mask;
+	struct iio_dev *indio_dev = iio_priv_to_dev(ams);
+
+	/*
+	 * Enable channel sequence. First 22 bit of scan_mask represent
+	 * PS channels, and next remaining bit represents PL channels.
+	 */
+
+	/* Run calibration of PS & PL as part of the sequence */
+	scan_mask = 0x1 | BIT(PS_SEQ_MAX);
+	for (i = 0; i < indio_dev->num_channels; i++)
+		scan_mask |= BIT(indio_dev->channels[i].scan_index);
+
+	if (ams->ps_base) {
+		/* put sysmon in a soft reset to change the sequence */
+		ams_ps_update_reg(ams, AMS_REG_CONFIG1, AMS_CONF1_SEQ_MASK,
+				  AMS_CONF1_SEQ_DEFAULT);
+
+		/* configure basic channels */
+		writel(scan_mask & AMS_REG_SEQ0_MASK,
+				ams->ps_base + AMS_REG_SEQ_CH0);
+		writel(AMS_REG_SEQ2_MASK &
+			(scan_mask >> AMS_REG_SEQ2_MASK_SHIFT),
+			ams->ps_base + AMS_REG_SEQ_CH2);
+
+		/* set continuous sequence mode */
+		ams_ps_update_reg(ams, AMS_REG_CONFIG1, AMS_CONF1_SEQ_MASK,
+				  AMS_CONF1_SEQ_CONTINUOUS);
+	}
+
+	if (ams->pl_base) {
+		/* put sysmon in a soft reset to change the sequence */
+		ams_pl_update_reg(ams, AMS_REG_CONFIG1, AMS_CONF1_SEQ_MASK,
+				    AMS_CONF1_SEQ_DEFAULT);
+
+		/* configure basic channels */
+		scan_mask = scan_mask >> PS_SEQ_MAX;
+		writel(scan_mask & AMS_REG_SEQ0_MASK,
+				ams->pl_base + AMS_REG_SEQ_CH0);
+		writel(AMS_REG_SEQ2_MASK &
+				(scan_mask >> AMS_REG_SEQ2_MASK_SHIFT),
+				ams->pl_base + AMS_REG_SEQ_CH2);
+		writel(AMS_REG_SEQ1_MASK &
+				(scan_mask >> AMS_REG_SEQ1_MASK_SHIFT),
+				ams->pl_base + AMS_REG_SEQ_CH1);
+
+		/* set continuous sequence mode */
+		ams_pl_update_reg(ams, AMS_REG_CONFIG1, AMS_CONF1_SEQ_MASK,
+				AMS_CONF1_SEQ_CONTINUOUS);
+	}
+}
+
+static int iio_ams_init_device(struct ams *ams)
+{
+	u32 reg;
+	int ret;
+
+	/* reset AMS */
+	if (ams->ps_base) {
+		writel(AMS_PS_RESET_VALUE, ams->ps_base + AMS_VP_VN);
+
+		ret = readl_poll_timeout(ams->base + AMS_PS_CSTS, reg,
+					 (reg & AMS_PS_CSTS_PS_READY) ==
+					 AMS_PS_CSTS_PS_READY, 0,
+					 AMS_INIT_TIMEOUT);
+		if (ret)
+			return ret;
+
+		/* put sysmon in a default state */
+		ams_ps_update_reg(ams, AMS_REG_CONFIG1, AMS_CONF1_SEQ_MASK,
+				  AMS_CONF1_SEQ_DEFAULT);
+	}
+
+	if (ams->pl_base) {
+		writel(AMS_PL_RESET_VALUE, ams->pl_base + AMS_VP_VN);
+
+		ret = readl_poll_timeout(ams->base + AMS_PL_CSTS, reg,
+					 (reg & AMS_PL_CSTS_ACCESS_MASK) ==
+					 AMS_PL_CSTS_ACCESS_MASK, 0,
+					 AMS_INIT_TIMEOUT);
+		if (ret)
+			return ret;
+
+		/* put sysmon in a default state */
+		ams_pl_update_reg(ams, AMS_REG_CONFIG1, AMS_CONF1_SEQ_MASK,
+				    AMS_CONF1_SEQ_DEFAULT);
+	}
+
+	ams_disable_all_alarms(ams);
+
+	/* Disable interrupt */
+	ams_update_intrmask(ams, ~0, ~0);
+
+	/* Clear any pending interrupt */
+	writel(AMS_ISR0_ALARM_MASK, ams->base + AMS_ISR_0);
+	writel(AMS_ISR1_ALARM_MASK, ams->base + AMS_ISR_1);
+
+	return 0;
+}
+
+static int ams_enable_single_channel(struct ams *ams, unsigned int offset)
+{
+	u8 channel_num = 0;
+
+	switch (offset) {
+	case AMS_VCC_PSPLL0:
+		channel_num = AMS_VCC_PSPLL0_CH;
+		break;
+	case AMS_VCC_PSPLL3:
+		channel_num = AMS_VCC_PSPLL3_CH;
+		break;
+	case AMS_VCCINT:
+		channel_num = AMS_VCCINT_CH;
+		break;
+	case AMS_VCCBRAM:
+		channel_num = AMS_VCCBRAM_CH;
+		break;
+	case AMS_VCCAUX:
+		channel_num = AMS_VCCAUX_CH;
+		break;
+	case AMS_PSDDRPLL:
+		channel_num = AMS_PSDDRPLL_CH;
+		break;
+	case AMS_PSINTFPDDR:
+		channel_num = AMS_PSINTFPDDR_CH;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* set single channel, sequencer off mode */
+	ams_ps_update_reg(ams, AMS_REG_CONFIG1, AMS_CONF1_SEQ_MASK,
+			AMS_CONF1_SEQ_SINGLE_CHANNEL);
+
+	/* write the channel number */
+	ams_ps_update_reg(ams, AMS_REG_CONFIG0, AMS_CONF0_CHANNEL_NUM_MASK,
+			channel_num);
+	return 0;
+}
+
+static int ams_read_vcc_reg(struct ams *ams, unsigned int offset, u32 *data)
+{
+	u32 reg;
+	int ret;
+
+	ret = ams_enable_single_channel(ams, offset);
+	if (ret)
+		return ret;
+
+	ret = readl_poll_timeout(ams->base + AMS_ISR_1, reg,
+				 (reg & AMS_ISR1_EOC_MASK) == AMS_ISR1_EOC_MASK,
+				 0, AMS_INIT_TIMEOUT);
+	if (ret)
+		return ret;
+
+	*data = readl(ams->base + offset);
+	ams_enable_channel_sequence(ams);
+
+	return 0;
+}
+
+static int ams_read_raw(struct iio_dev *indio_dev,
+			struct iio_chan_spec const *chan,
+			int *val, int *val2, long mask)
+{
+	struct ams *ams = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&ams->lock);
+		if (chan->scan_index >= (PS_SEQ_MAX * 3)) {
+			ret = ams_read_vcc_reg(ams, chan->address, val);
+			if (ret) {
+				mutex_unlock(&ams->lock);
+				return -EINVAL;
+			}
+		} else if (chan->scan_index >= PS_SEQ_MAX)
+			*val = readl(ams->pl_base + chan->address);
+		else
+			*val = readl(ams->ps_base + chan->address);
+		mutex_unlock(&ams->lock);
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			switch (chan->address) {
+			case AMS_SUPPLY1:
+			case AMS_SUPPLY2:
+			case AMS_SUPPLY3:
+			case AMS_SUPPLY4:
+				*val = AMS_SUPPLY_SCALE_3VOLT;
+				break;
+			case AMS_SUPPLY5:
+			case AMS_SUPPLY6:
+				if (chan->scan_index < PS_SEQ_MAX)
+					*val = AMS_SUPPLY_SCALE_6VOLT;
+				else
+					*val = AMS_SUPPLY_SCALE_3VOLT;
+				break;
+			case AMS_SUPPLY7:
+			case AMS_SUPPLY8:
+				*val = AMS_SUPPLY_SCALE_6VOLT;
+				break;
+			case AMS_SUPPLY9:
+			case AMS_SUPPLY10:
+				if (chan->scan_index < PS_SEQ_MAX)
+					*val = AMS_SUPPLY_SCALE_3VOLT;
+				else
+					*val = AMS_SUPPLY_SCALE_6VOLT;
+				break;
+			case AMS_VCC_PSPLL0:
+			case AMS_VCC_PSPLL3:
+			case AMS_VCCINT:
+			case AMS_VCCBRAM:
+			case AMS_VCCAUX:
+			case AMS_PSDDRPLL:
+			case AMS_PSINTFPDDR:
+				*val = AMS_SUPPLY_SCALE_3VOLT;
+				break;
+			default:
+				*val = AMS_SUPPLY_SCALE_1VOLT;
+				break;
+			}
+			*val2 = AMS_SUPPLY_SCALE_DIV_BIT;
+			return IIO_VAL_FRACTIONAL_LOG2;
+		case IIO_TEMP:
+			*val = AMS_TEMP_SCALE;
+			*val2 = AMS_TEMP_SCALE_DIV_BIT;
+			return IIO_VAL_FRACTIONAL_LOG2;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_OFFSET:
+		/* Only the temperature channel has an offset */
+		*val = AMS_TEMP_OFFSET;
+		return IIO_VAL_INT;
+	}
+
+	return -EINVAL;
+}
+
+static int ams_get_alarm_offset(int scan_index, enum iio_event_direction dir)
+{
+	int offset = 0;
+
+	if (scan_index >= PS_SEQ_MAX)
+		scan_index -= PS_SEQ_MAX;
+
+	if (dir == IIO_EV_DIR_FALLING) {
+		if (scan_index < AMS_SEQ_SUPPLY7)
+			offset = AMS_ALARM_THRESHOLD_OFF_10;
+		else
+			offset = AMS_ALARM_THRESHOLD_OFF_20;
+	}
+
+	switch (scan_index) {
+	case AMS_SEQ_TEMP:
+		return AMS_ALARM_TEMP + offset;
+	case AMS_SEQ_SUPPLY1:
+		return AMS_ALARM_SUPPLY1 + offset;
+	case AMS_SEQ_SUPPLY2:
+		return AMS_ALARM_SUPPLY2 + offset;
+	case AMS_SEQ_SUPPLY3:
+		return AMS_ALARM_SUPPLY3 + offset;
+	case AMS_SEQ_SUPPLY4:
+		return AMS_ALARM_SUPPLY4 + offset;
+	case AMS_SEQ_SUPPLY5:
+		return AMS_ALARM_SUPPLY5 + offset;
+	case AMS_SEQ_SUPPLY6:
+		return AMS_ALARM_SUPPLY6 + offset;
+	case AMS_SEQ_SUPPLY7:
+		return AMS_ALARM_SUPPLY7 + offset;
+	case AMS_SEQ_SUPPLY8:
+		return AMS_ALARM_SUPPLY8 + offset;
+	case AMS_SEQ_SUPPLY9:
+		return AMS_ALARM_SUPPLY9 + offset;
+	case AMS_SEQ_SUPPLY10:
+		return AMS_ALARM_SUPPLY10 + offset;
+	case AMS_SEQ_VCCAMS:
+		return AMS_ALARM_VCCAMS + offset;
+	case AMS_SEQ_TEMP_REMOTE:
+		return AMS_ALARM_TEMP_REMOTE + offset;
+	}
+
+	return 0;
+}
+
+static const struct iio_chan_spec *ams_event_to_channel(
+		struct iio_dev *indio_dev, u32 event)
+{
+	int scan_index = 0, i;
+
+	if (event >= AMS_PL_ALARM_START) {
+		event -= AMS_PL_ALARM_START;
+		scan_index = PS_SEQ_MAX;
+	}
+
+	switch (event) {
+	case AMS_ALARM_BIT_TEMP:
+		scan_index += AMS_SEQ_TEMP;
+		break;
+	case AMS_ALARM_BIT_SUPPLY1:
+		scan_index += AMS_SEQ_SUPPLY1;
+		break;
+	case AMS_ALARM_BIT_SUPPLY2:
+		scan_index += AMS_SEQ_SUPPLY2;
+		break;
+	case AMS_ALARM_BIT_SUPPLY3:
+		scan_index += AMS_SEQ_SUPPLY3;
+		break;
+	case AMS_ALARM_BIT_SUPPLY4:
+		scan_index += AMS_SEQ_SUPPLY4;
+		break;
+	case AMS_ALARM_BIT_SUPPLY5:
+		scan_index += AMS_SEQ_SUPPLY5;
+		break;
+	case AMS_ALARM_BIT_SUPPLY6:
+		scan_index += AMS_SEQ_SUPPLY6;
+		break;
+	case AMS_ALARM_BIT_SUPPLY7:
+		scan_index += AMS_SEQ_SUPPLY7;
+		break;
+	case AMS_ALARM_BIT_SUPPLY8:
+		scan_index += AMS_SEQ_SUPPLY8;
+		break;
+	case AMS_ALARM_BIT_SUPPLY9:
+		scan_index += AMS_SEQ_SUPPLY9;
+		break;
+	case AMS_ALARM_BIT_SUPPLY10:
+		scan_index += AMS_SEQ_SUPPLY10;
+		break;
+	case AMS_ALARM_BIT_VCCAMS:
+		scan_index += AMS_SEQ_VCCAMS;
+		break;
+	case AMS_ALARM_BIT_TEMP_REMOTE:
+		scan_index += AMS_SEQ_TEMP_REMOTE;
+		break;
+	}
+
+	for (i = 0; i < indio_dev->num_channels; i++)
+		if (indio_dev->channels[i].scan_index == scan_index)
+			break;
+
+	return &indio_dev->channels[i];
+}
+
+static int ams_get_alarm_mask(int scan_index)
+{
+	int bit = 0;
+
+	if (scan_index >= PS_SEQ_MAX) {
+		bit = AMS_PL_ALARM_START;
+		scan_index -= PS_SEQ_MAX;
+	}
+
+	switch (scan_index) {
+	case AMS_SEQ_TEMP:
+		return BIT(AMS_ALARM_BIT_TEMP + bit);
+	case AMS_SEQ_SUPPLY1:
+		return BIT(AMS_ALARM_BIT_SUPPLY1 + bit);
+	case AMS_SEQ_SUPPLY2:
+		return BIT(AMS_ALARM_BIT_SUPPLY2 + bit);
+	case AMS_SEQ_SUPPLY3:
+		return BIT(AMS_ALARM_BIT_SUPPLY3 + bit);
+	case AMS_SEQ_SUPPLY4:
+		return BIT(AMS_ALARM_BIT_SUPPLY4 + bit);
+	case AMS_SEQ_SUPPLY5:
+		return BIT(AMS_ALARM_BIT_SUPPLY5 + bit);
+	case AMS_SEQ_SUPPLY6:
+		return BIT(AMS_ALARM_BIT_SUPPLY6 + bit);
+	case AMS_SEQ_SUPPLY7:
+		return BIT(AMS_ALARM_BIT_SUPPLY7 + bit);
+	case AMS_SEQ_SUPPLY8:
+		return BIT(AMS_ALARM_BIT_SUPPLY8 + bit);
+	case AMS_SEQ_SUPPLY9:
+		return BIT(AMS_ALARM_BIT_SUPPLY9 + bit);
+	case AMS_SEQ_SUPPLY10:
+		return BIT(AMS_ALARM_BIT_SUPPLY10 + bit);
+	case AMS_SEQ_VCCAMS:
+		return BIT(AMS_ALARM_BIT_VCCAMS + bit);
+	case AMS_SEQ_TEMP_REMOTE:
+		return BIT(AMS_ALARM_BIT_TEMP_REMOTE + bit);
+	}
+
+	return 0;
+}
+
+static int ams_read_event_config(struct iio_dev *indio_dev,
+				 const struct iio_chan_spec *chan,
+				 enum iio_event_type type,
+				 enum iio_event_direction dir)
+{
+	struct ams *ams = iio_priv(indio_dev);
+
+	return (ams->alarm_mask & ams_get_alarm_mask(chan->scan_index)) ? 1 : 0;
+}
+
+static int ams_write_event_config(struct iio_dev *indio_dev,
+				  const struct iio_chan_spec *chan,
+				  enum iio_event_type type,
+				  enum iio_event_direction dir,
+				  int state)
+{
+	struct ams *ams = iio_priv(indio_dev);
+	unsigned int alarm;
+
+	alarm = ams_get_alarm_mask(chan->scan_index);
+
+	mutex_lock(&ams->lock);
+
+	if (state)
+		ams->alarm_mask |= alarm;
+	else
+		ams->alarm_mask &= ~alarm;
+
+	iio_ams_update_alarm(ams, ams->alarm_mask);
+
+	mutex_unlock(&ams->lock);
+
+	return 0;
+}
+
+static int ams_read_event_value(struct iio_dev *indio_dev,
+				const struct iio_chan_spec *chan,
+				enum iio_event_type type,
+				enum iio_event_direction dir,
+				enum iio_event_info info, int *val, int *val2)
+{
+	struct ams *ams = iio_priv(indio_dev);
+	unsigned int offset = ams_get_alarm_offset(chan->scan_index, dir);
+
+	mutex_lock(&ams->lock);
+
+	if (chan->scan_index >= PS_SEQ_MAX)
+		*val = readl(ams->pl_base + offset);
+	else
+		*val = readl(ams->ps_base + offset);
+
+	mutex_unlock(&ams->lock);
+
+	return IIO_VAL_INT;
+}
+
+static int ams_write_event_value(struct iio_dev *indio_dev,
+				 const struct iio_chan_spec *chan,
+				 enum iio_event_type type,
+				 enum iio_event_direction dir,
+				 enum iio_event_info info, int val, int val2)
+{
+	struct ams *ams = iio_priv(indio_dev);
+	unsigned int offset;
+
+	mutex_lock(&ams->lock);
+
+	/* Set temperature channel threshold to direct threshold */
+	if (chan->type == IIO_TEMP) {
+		offset = ams_get_alarm_offset(chan->scan_index,
+					      IIO_EV_DIR_FALLING);
+
+		if (chan->scan_index >= PS_SEQ_MAX)
+			ams_pl_update_reg(ams, offset,
+					    AMS_ALARM_THR_DIRECT_MASK,
+					    AMS_ALARM_THR_DIRECT_MASK);
+		else
+			ams_ps_update_reg(ams, offset,
+					  AMS_ALARM_THR_DIRECT_MASK,
+					  AMS_ALARM_THR_DIRECT_MASK);
+	}
+
+	offset = ams_get_alarm_offset(chan->scan_index, dir);
+	if (chan->scan_index >= PS_SEQ_MAX)
+		writel(val, ams->pl_base + offset);
+	else
+		writel(val, ams->ps_base + offset);
+
+	mutex_unlock(&ams->lock);
+
+	return 0;
+}
+
+static void ams_handle_event(struct iio_dev *indio_dev, u32 event)
+{
+	const struct iio_chan_spec *chan;
+
+	chan = ams_event_to_channel(indio_dev, event);
+
+	if (chan->type == IIO_TEMP) {
+		/*
+		 * The temperature channel only supports over-temperature
+		 * events
+		 */
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(chan->type, chan->channel,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_RISING),
+			iio_get_time_ns(indio_dev));
+	} else {
+		/*
+		 * For other channels we don't know whether it is a upper or
+		 * lower threshold event. Userspace will have to check the
+		 * channel value if it wants to know.
+		 */
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(chan->type, chan->channel,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_EITHER),
+			iio_get_time_ns(indio_dev));
+	}
+}
+
+static void ams_handle_events(struct iio_dev *indio_dev, unsigned long events)
+{
+	unsigned int bit;
+
+	for_each_set_bit(bit, &events, AMS_NO_OF_ALARMS)
+		ams_handle_event(indio_dev, bit);
+}
+
+/**
+ * ams_unmask_worker - ams alarm interrupt unmask worker
+ * @work :		work to be done
+ *
+ * The ZynqMP threshold interrupts are level sensitive. Since we can't make the
+ * threshold condition go way from within the interrupt handler, this means as
+ * soon as a threshold condition is present we would enter the interrupt handler
+ * again and again. To work around this we mask all active threshold interrupts
+ * in the interrupt handler and start a timer. In this timer we poll the
+ * interrupt status and only if the interrupt is inactive we unmask it again.
+ */
+static void ams_unmask_worker(struct work_struct *work)
+{
+	struct ams *ams = container_of(work, struct ams, ams_unmask_work.work);
+	unsigned int status, unmask;
+
+	mutex_lock(&ams->lock);
+
+	status = readl(ams->base + AMS_ISR_0);
+
+	/* Clear those bits which are not active anymore */
+	unmask = (ams->masked_alarm ^ status) & ams->masked_alarm;
+
+	/* clear status of disabled alarm */
+	unmask |= ams->intr_mask;
+
+	ams->masked_alarm &= status;
+
+	/* Also clear those which are masked out anyway */
+	ams->masked_alarm &= ~ams->intr_mask;
+
+	/* Clear the interrupts before we unmask them */
+	writel(unmask, ams->base + AMS_ISR_0);
+
+	ams_update_intrmask(ams, 0, 0);
+
+	mutex_unlock(&ams->lock);
+
+	/* if still pending some alarm re-trigger the timer */
+	if (ams->masked_alarm)
+		schedule_delayed_work(&ams->ams_unmask_work,
+				      msecs_to_jiffies(AMS_UNMASK_TIMEOUT_MS));
+}
+
+static irqreturn_t ams_iio_irq(int irq, void *data)
+{
+	struct iio_dev *indio_dev = data;
+	struct ams *ams = iio_priv(indio_dev);
+	irqreturn_t irq_status = IRQ_NONE;
+	u32 isr0;
+
+	isr0 = readl(ams->base + AMS_ISR_0);
+
+	/* only process alarms that are not masked */
+	isr0 &= ~((ams->intr_mask & AMS_ISR0_ALARM_MASK) | ams->masked_alarm);
+
+	if (isr0) {
+		/* clear interrupt */
+		writel(isr0, ams->base + AMS_ISR_0);
+
+		/* Once the alarm interrupt occurred, mask until get cleared */
+		ams->masked_alarm |= isr0;
+		ams_update_intrmask(ams, 0, 0);
+
+		ams_handle_events(indio_dev, isr0);
+
+		schedule_delayed_work(&ams->ams_unmask_work,
+				      msecs_to_jiffies(AMS_UNMASK_TIMEOUT_MS));
+		irq_status = IRQ_HANDLED;
+	}
+
+	return irq_status;
+}
+
+static const struct iio_event_spec ams_temp_events[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE) |
+				BIT(IIO_EV_INFO_VALUE),
+	},
+};
+
+static const struct iio_event_spec ams_voltage_events[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
+static const struct iio_chan_spec ams_ps_channels[] = {
+	AMS_PS_CHAN_TEMP(AMS_SEQ_TEMP, AMS_TEMP, "ps_temp"),
+	AMS_PS_CHAN_TEMP(AMS_SEQ_TEMP_REMOTE, AMS_TEMP_REMOTE, "remote_temp"),
+	AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY1, AMS_SUPPLY1, "vccpsintlp"),
+	AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY2, AMS_SUPPLY2, "vccpsintfp"),
+	AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY3, AMS_SUPPLY3, "vccpsaux"),
+	AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY4, AMS_SUPPLY4, "vccpsddr"),
+	AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY5, AMS_SUPPLY5, "vccpsio3"),
+	AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY6, AMS_SUPPLY6, "vccpsio0"),
+	AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY7, AMS_SUPPLY7, "vccpsio1"),
+	AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY8, AMS_SUPPLY8, "vccpsio2"),
+	AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY9, AMS_SUPPLY9, "psmgtravcc"),
+	AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY10, AMS_SUPPLY10, "psmgtravtt"),
+	AMS_PS_CHAN_VOLTAGE(AMS_SEQ_VCCAMS, AMS_VCCAMS, "vccams"),
+};
+
+static const struct iio_chan_spec ams_pl_channels[] = {
+	AMS_PL_CHAN_TEMP(AMS_SEQ_TEMP, AMS_TEMP, "pl_temp"),
+	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY1, AMS_SUPPLY1, "vccint", true),
+	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY2, AMS_SUPPLY2, "vccaux", true),
+	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_VREFP, AMS_VREFP, "vccvrefp", false),
+	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_VREFN, AMS_VREFN, "vccvrefn", false),
+	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY3, AMS_SUPPLY3, "vccbram", true),
+	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY4, AMS_SUPPLY4, "vccplintlp", true),
+	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY5, AMS_SUPPLY5, "vccplintfp", true),
+	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY6, AMS_SUPPLY6, "vccplaux", true),
+	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_VCCAMS, AMS_VCCAMS, "vccams", true),
+	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_VP_VN, AMS_VP_VN, "vccvpvn", false),
+	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY7, AMS_SUPPLY7, "vuser0", true),
+	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY8, AMS_SUPPLY8, "vuser1", true),
+	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY9, AMS_SUPPLY9, "vuser2", true),
+	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY10, AMS_SUPPLY10, "vuser3", true),
+	AMS_PL_AUX_CHAN_VOLTAGE(0, NULL),
+	AMS_PL_AUX_CHAN_VOLTAGE(1, NULL),
+	AMS_PL_AUX_CHAN_VOLTAGE(2, NULL),
+	AMS_PL_AUX_CHAN_VOLTAGE(3, NULL),
+	AMS_PL_AUX_CHAN_VOLTAGE(4, NULL),
+	AMS_PL_AUX_CHAN_VOLTAGE(5, NULL),
+	AMS_PL_AUX_CHAN_VOLTAGE(6, NULL),
+	AMS_PL_AUX_CHAN_VOLTAGE(7, NULL),
+	AMS_PL_AUX_CHAN_VOLTAGE(8, NULL),
+	AMS_PL_AUX_CHAN_VOLTAGE(9, NULL),
+	AMS_PL_AUX_CHAN_VOLTAGE(10, NULL),
+	AMS_PL_AUX_CHAN_VOLTAGE(11, NULL),
+	AMS_PL_AUX_CHAN_VOLTAGE(12, NULL),
+	AMS_PL_AUX_CHAN_VOLTAGE(13, NULL),
+	AMS_PL_AUX_CHAN_VOLTAGE(14, NULL),
+	AMS_PL_AUX_CHAN_VOLTAGE(15, NULL),
+};
+
+static const struct iio_chan_spec ams_ctrl_channels[] = {
+	AMS_CTRL_CHAN_VOLTAGE(AMS_SEQ_VCC_PSPLL, AMS_VCC_PSPLL0, "vcc_pspll0"),
+	AMS_CTRL_CHAN_VOLTAGE(AMS_SEQ_VCC_PSBATT, AMS_VCC_PSPLL3, "vcc_psbatt"),
+	AMS_CTRL_CHAN_VOLTAGE(AMS_SEQ_VCCINT, AMS_VCCINT, "vccint"),
+	AMS_CTRL_CHAN_VOLTAGE(AMS_SEQ_VCCBRAM, AMS_VCCBRAM, "vccbram"),
+	AMS_CTRL_CHAN_VOLTAGE(AMS_SEQ_VCCAUX, AMS_VCCAUX, "vccaux"),
+	AMS_CTRL_CHAN_VOLTAGE(AMS_SEQ_PSDDRPLL, AMS_PSDDRPLL, "psddrpll"),
+	AMS_CTRL_CHAN_VOLTAGE(AMS_SEQ_INTDDR, AMS_PSINTFPDDR, "psintfpddr"),
+};
+
+static int ams_init_module(struct iio_dev *indio_dev, struct device_node *np,
+			   struct iio_chan_spec *channels)
+{
+	struct ams *ams = iio_priv(indio_dev);
+	struct device_node *chan_node, *child;
+	int ret, num_channels = 0;
+	unsigned int reg;
+
+	if (of_device_is_compatible(np, "xlnx,zynqmp-ams-ps")) {
+		ams->ps_base = of_iomap(np, 0);
+		if (!ams->ps_base)
+			return -ENXIO;
+
+		/* add PS channels to iio device channels */
+		memcpy(channels + num_channels, ams_ps_channels,
+		       sizeof(ams_ps_channels));
+		num_channels += ARRAY_SIZE(ams_ps_channels);
+	} else if (of_device_is_compatible(np, "xlnx,zynqmp-ams-pl")) {
+		ams->pl_base = of_iomap(np, 0);
+		if (!ams->pl_base)
+			return -ENXIO;
+
+		/* Copy only first 10 fix channels */
+		memcpy(channels + num_channels, ams_pl_channels,
+		       AMS_PL_MAX_FIXED_CHANNEL * sizeof(*channels));
+		num_channels += AMS_PL_MAX_FIXED_CHANNEL;
+
+		chan_node = of_get_child_by_name(np, "xlnx,ext-channels");
+		if (chan_node) {
+			for_each_child_of_node(chan_node, child) {
+				ret = of_property_read_u32(child, "reg", &reg);
+				if (ret || reg > AMS_PL_MAX_EXT_CHANNEL)
+					continue;
+
+				memcpy(&channels[num_channels],
+				       &ams_pl_channels[reg +
+				       AMS_PL_MAX_FIXED_CHANNEL],
+				       sizeof(*channels));
+
+				if (of_property_read_bool(child,
+							  "xlnx,bipolar"))
+					channels[num_channels].scan_type.sign =
+						's';
+
+				num_channels++;
+			}
+		}
+		of_node_put(chan_node);
+	} else if (of_device_is_compatible(np, "xlnx,zynqmp-ams")) {
+		/* add AMS channels to iio device channels */
+		memcpy(channels + num_channels, ams_ctrl_channels,
+				sizeof(ams_ctrl_channels));
+		num_channels += ARRAY_SIZE(ams_ctrl_channels);
+	} else {
+		return -EINVAL;
+	}
+
+	return num_channels;
+}
+
+static int ams_parse_dt(struct iio_dev *indio_dev, struct platform_device *pdev)
+{
+	struct ams *ams = iio_priv(indio_dev);
+	struct iio_chan_spec *ams_channels, *dev_channels;
+	struct device_node *child_node = NULL, *np = pdev->dev.of_node;
+	int ret, vol_ch_cnt = 0, temp_ch_cnt = 0, i, rising_off, falling_off;
+	unsigned int num_channels = 0;
+
+	/* Initialize buffer for channel specification */
+	ams_channels = kzalloc(sizeof(ams_ps_channels) +
+			       sizeof(ams_pl_channels) +
+			       sizeof(ams_ctrl_channels), GFP_KERNEL);
+	if (!ams_channels)
+		return -ENOMEM;
+
+	if (of_device_is_available(np)) {
+		ret = ams_init_module(indio_dev, np, ams_channels);
+		if (ret < 0)
+			goto err;
+
+		num_channels += ret;
+	}
+
+	for_each_child_of_node(np, child_node) {
+		if (of_device_is_available(child_node)) {
+			ret = ams_init_module(indio_dev, child_node,
+					      ams_channels + num_channels);
+			if (ret < 0)
+				goto err;
+
+			num_channels += ret;
+		}
+	}
+
+	for (i = 0; i < num_channels; i++) {
+		if (ams_channels[i].type == IIO_VOLTAGE)
+			ams_channels[i].channel = vol_ch_cnt++;
+		else
+			ams_channels[i].channel = temp_ch_cnt++;
+
+		if (ams_channels[i].scan_index < (PS_SEQ_MAX * 3)) {
+			/* set threshold to max and min for each channel */
+			falling_off = ams_get_alarm_offset(
+					ams_channels[i].scan_index,
+					IIO_EV_DIR_FALLING);
+			rising_off = ams_get_alarm_offset(
+					ams_channels[i].scan_index,
+					IIO_EV_DIR_RISING);
+			if (ams_channels[i].scan_index >= PS_SEQ_MAX) {
+				writel(AMS_ALARM_THR_MIN,
+						ams->pl_base + falling_off);
+				writel(AMS_ALARM_THR_MAX,
+						ams->pl_base + rising_off);
+			} else {
+				writel(AMS_ALARM_THR_MIN,
+						ams->ps_base + falling_off);
+				writel(AMS_ALARM_THR_MAX,
+						ams->ps_base + rising_off);
+			}
+		}
+	}
+
+	dev_channels = devm_kzalloc(&pdev->dev, sizeof(*dev_channels) *
+				    num_channels, GFP_KERNEL);
+	if (!dev_channels) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	memcpy(dev_channels, ams_channels,
+	       sizeof(*ams_channels) * num_channels);
+	indio_dev->channels = dev_channels;
+	indio_dev->num_channels = num_channels;
+
+	ret = 0;
+err:
+	kfree(ams_channels);
+
+	return ret;
+}
+
+static const struct iio_info iio_pl_info = {
+	.read_raw = &ams_read_raw,
+	.read_event_config = &ams_read_event_config,
+	.write_event_config = &ams_write_event_config,
+	.read_event_value = &ams_read_event_value,
+	.write_event_value = &ams_write_event_value,
+};
+
+static const struct of_device_id ams_of_match_table[] = {
+	{ .compatible = "xlnx,zynqmp-ams" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ams_of_match_table);
+
+static int ams_probe(struct platform_device *pdev)
+{
+	struct iio_dev *indio_dev;
+	struct ams *ams;
+	struct resource *res;
+	int ret;
+
+	if (!pdev->dev.of_node)
+		return -ENODEV;
+
+	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*ams));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	ams = iio_priv(indio_dev);
+	mutex_init(&ams->lock);
+
+	indio_dev->dev.parent = &pdev->dev;
+	indio_dev->dev.of_node = pdev->dev.of_node;
+	indio_dev->name = "xilinx-ams";
+
+	indio_dev->info = &iio_pl_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ams-base");
+	ams->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(ams->base))
+		return PTR_ERR(ams->base);
+
+	ams->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(ams->clk))
+		return PTR_ERR(ams->clk);
+	clk_prepare_enable(ams->clk);
+
+	INIT_DELAYED_WORK(&ams->ams_unmask_work, ams_unmask_worker);
+
+	ret = iio_ams_init_device(ams);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to initialize AMS\n");
+		goto err_probe;
+	}
+
+	ret = ams_parse_dt(indio_dev, pdev);
+	if (ret) {
+		dev_err(&pdev->dev, "failure in parsing DT\n");
+		goto err_probe;
+	}
+
+	ams_enable_channel_sequence(ams);
+
+	ams->irq = platform_get_irq_byname(pdev, "ams-irq");
+	ret = request_irq(ams->irq, &ams_iio_irq, 0, "ams-irq", indio_dev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to register interrupt\n");
+		goto err_probe;
+	}
+
+	platform_set_drvdata(pdev, indio_dev);
+
+	ret = iio_device_register(indio_dev);
+	if (ret)
+		goto err_irq_free;
+
+	return 0;
+
+err_irq_free:
+	free_irq(ams->irq, indio_dev);
+
+err_probe:
+	cancel_delayed_work(&ams->ams_unmask_work);
+	clk_disable_unprepare(ams->clk);
+
+	return ret;
+}
+
+static int ams_remove(struct platform_device *pdev)
+{
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct ams *ams = iio_priv(indio_dev);
+
+	cancel_delayed_work(&ams->ams_unmask_work);
+
+	free_irq(ams->irq, indio_dev);
+	/* Unregister the device */
+	iio_device_unregister(indio_dev);
+	clk_disable_unprepare(ams->clk);
+
+	return 0;
+}
+
+static int __maybe_unused ams_suspend(struct device *dev)
+{
+	struct ams *ams = iio_priv(dev_get_drvdata(dev));
+
+	clk_disable_unprepare(ams->clk);
+
+	return 0;
+}
+
+static int __maybe_unused ams_resume(struct device *dev)
+{
+	struct ams *ams = iio_priv(dev_get_drvdata(dev));
+
+	clk_prepare_enable(ams->clk);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(ams_pm_ops, ams_suspend, ams_resume);
+
+static struct platform_driver ams_driver = {
+	.probe = ams_probe,
+	.remove = ams_remove,
+	.driver = {
+		.name = "xilinx-ams",
+		.pm = &ams_pm_ops,
+		.of_match_table = ams_of_match_table,
+	},
+};
+module_platform_driver(ams_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Xilinx, Inc.");
-- 
2.1.1

