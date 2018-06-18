Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F816C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2BD320693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="J8A22Jjv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2BD320693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965504AbeFSF4r (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 01:56:47 -0400
Received: from mail-eopbgr720044.outbound.protection.outlook.com ([40.107.72.44]:32640
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755611AbeFSF4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 01:56:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynaRtMBBtvQ+gi/s12fxuoSCX6OR38RiJPpygqjAh6o=;
 b=J8A22JjvOWf+GxKOA6zcZLigyypJCzq44bAK9s8Nr8o7od/Iu+VeytBZrjsaKRdhqmvz48GEoG4GWXYJUGtkB8ZnFspLs43fGZEbN8zjDq2JRsk6SiRzLX2vsLpbOatMWJOrwt78kC0nmvlHMJ2ka32W/9V2YpCRfbwoqFUABlQ=
Received: from MWHPR0201CA0023.namprd02.prod.outlook.com
 (2603:10b6:301:74::36) by BN7PR02MB5092.namprd02.prod.outlook.com
 (2603:10b6:408:22::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.16; Tue, 19 Jun
 2018 05:55:56 +0000
Received: from SN1NAM02FT034.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::208) by MWHPR0201CA0023.outlook.office365.com
 (2603:10b6:301:74::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.863.17 via Frontend
 Transport; Tue, 19 Jun 2018 05:55:55 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT034.mail.protection.outlook.com (10.152.72.141) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.863.11
 via Frontend Transport; Tue, 19 Jun 2018 05:55:53 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:60977 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fV9cO-0000Kj-9T; Mon, 18 Jun 2018 22:55:52 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fV9cJ-0002dw-5m; Mon, 18 Jun 2018 22:55:47 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w5J5tkJH030016;
        Mon, 18 Jun 2018 22:55:46 -0700
Received: from [172.23.37.150] (helo=ubuntu)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@ubuntu>)
        id 1fV9cI-0002dY-5P; Mon, 18 Jun 2018 22:55:46 -0700
Received: by ubuntu (Postfix, from userid 13245)
        id 920F13C730F; Mon, 18 Jun 2018 05:08:30 -0600 (MDT)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <davem@davemloft.net>, <andrew@lunn.ch>, <michal.simek@xilinx.com>,
        <radhey.shyam.pandey@xilinx.com>
CC:     <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/5] net: emaclite: Fix block comments style
Date:   Mon, 18 Jun 2018 05:08:22 -0600
Message-ID: <1529320103-7711-5-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1529320103-7711-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1529320103-7711-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--8.201-7.0-31-1
X-imss-scan-details: No--8.201-7.0-31-1;No--8.201-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(39380400002)(396003)(2980300002)(438002)(199004)(189003)(50226002)(106466001)(446003)(186003)(305945005)(26005)(63266004)(478600001)(76176011)(4326008)(2201001)(52956003)(6266002)(356003)(103686004)(47776003)(2906002)(2616005)(486006)(476003)(36756003)(11346002)(126002)(7049001)(50466002)(8936002)(6666003)(336012)(90966002)(59450400001)(81156014)(81166006)(8676002)(5660300001)(316002)(42186006)(110136005)(54906003)(51416003)(106002)(16586007)(48376002)(426003)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR02MB5092;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT034;1:Yw/rQ6pBrb9vax0aks/VaWwBc6y0oHcYLcLo1AZ6MSw/lXeqVoeDrU3qycGJGVZRBJ8rJ6Llofe/gzW5RTYjo8d2GpoCSn54P6PP7/mwbrCWSAoxH0INkqoOSkzBEI48
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6732872-07d5-4866-3228-08d5d5a95249
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(4608076)(2017052603328)(7153060);SRVR:BN7PR02MB5092;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5092;3:j302dHnngdDiX5/A9s3jqKPSGEFDb9MyOwgKcdAU2iplqkhCWrfoUPMs0eQq5oQpyx/Nxw/+EJYa4TAvSAIbWd67RP6fdwu6s6CC7gkDkcSeXyoMahx36fxfKieUZ6Xp9AXJOXOiNb826E6XAWweE/X3uf53hmD/qEvFko7iOyDqf04dlmEMJ08FkBkuEc5KhMSyydMGFJrotcPdy5tr7+nQiLf02Ej9rYglaIDHWtiqC6t3ygIikM/KBFfpZDWUVFSSETEAtUYwBCTdtJjiT7I7r9qAP1aAarvNx9LBUcssjICGYBAIpqcG1qm/Q0622ELt1K4UaQo7CPXRsxWc16wOI33gj+/CCuxPf0uk7oc=;25:nyJHKuEfAqsczVMXdbl8JhWPMDma1IJXXFTH5MyFT+LBliAxGJ3DXiM9h/gMhUKnOkc44iL2RC7xARM0Qj4ewOiAFcsbPhZ4zgZnT0n2JEhVI1pSNdrQ2SxiFjuH/PUiNSm4wO88/guInGQ6vIiHLAJAr/DcYrOJxaYydDYSXB+v0S35G1U5MFr64Wbqx9JbJwPceWF2PfuAdmVWojTKHt74szhjSuIk/HbE/Fm4hwIx/SntKf/R02627FlFMlSOmHAy7fj1s37oURNIga3L6NC14Kgv1Ucml7yGgzhUxNsCPexpvdYh11a3XoMnpbyl2PZFGckSckshxzMZCLNtug==
X-MS-TrafficTypeDiagnostic: BN7PR02MB5092:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5092;31:gKkRwshjP3i+Yd1tXbdaQJ72qcjKLOjOnfNUgvwPPBuvuMrdqzVuPTakCgORCtcBquwCW9K8caQGdiVy93lv+aoA6yacrYlvrrMfd0La6h3BrvOlDq3pENPd6tPZ4sSAtMw77u5uHBuDjakTtK+mhuSDlCOAHSjuG3zAX/Dw0REMAmdIHBbzFVhtUmB6FqqOPLv51TfkbPfN4lkXe5tHFbVO/t0N8cN5//R01FKYX78=;20:S2lNktgI6nfjvPFTaRDrXD+noC5znxTMYXtjmGBDHGcOI2olwUjr3HfL2xSED/WJ8EYBSXSwZ60r6ZbeKiLqI9XEyvDzOr5K0S1r96GjFQ2rlFcW0PBiildiQ0hlGf2XqiNAFAf5PgIXCxKJAyrZazR0sYMN3eG+26JO8AmOIOt6uGopOMosO9XZzKbsSArERgqBvkXo8ktrjxF2lktKkHlwAn4pUclHJ77sbckPmQfDziPpUe7MZDZ38lhDylnZwhGPhehpd6+yO3F1z8eOyYpnEJvsy4mGtw3d0UMetwHDZcyBwpUnjJXW7Y22piLSX8WHPQMNLPP94c5/0otKQPupTp9yMdVS4qAXrsOhHYKtBdE25sFpIqT9qRfQPczR21/N6lCsxn6krFDMGwiujs0y2jRzlaYa8hDKY8ATGrHfL3sa3Ok0fxPQwkjdpd/dT8L4OH1bh/fQv53JncA9eWwS6ZO7aCsCRdX85z6gB6v3HhCPBwxJ2xwV3ZfVtlEa
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN7PR02MB5092F8E77E87EB27ACC7967DC7700@BN7PR02MB5092.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93004095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BN7PR02MB5092;BCL:0;PCL:0;RULEID:;SRVR:BN7PR02MB5092;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5092;4:VUuQb48Aqgy9G1Xvg/EolWoAAXUctGWT0X4Uxd2lugxppXvczhMZvt8t5rBRwWcvvCdb2Iafd+poTiOSqZeiyNbwWAgGLPdTPs4ZQOy3r1Fovni18KUF4Ekr6G1nEbdHf/RfIcEkSGM7t5xDF+S2d6wDeZAv9dLuFvK7fECLgQYNpZiRxi+M8DuKzXRTqq0Zv52SvROKp8dDMB+ORw6EDFT0dFOOgvh9FuV3DtCd7kpT3xnCc2NnRYvbAKAxHNiPuLpPqnzqUXACRuzUH8UQ9fQQ41oplILkNhW4VBOS8HovGjXHCl9+SX+TiGxslXXw
X-Forefront-PRVS: 07083FF734
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR02MB5092;23:ZJ43SRLGIu7wPXv8cLGNBnrDfHuu8Fj9PvkgQPKYD?=
 =?us-ascii?Q?aaM40aRBl3FmdHPQ09FiIKUzGW9yrWIo2z1tABMOV8JLdkt+2z37l3Q23xme?=
 =?us-ascii?Q?aAhE8B5IOEirNM26XPCeH5BbiIpunaCrdm0eI4bEulZ+b2XFWBdBTNVdQb0e?=
 =?us-ascii?Q?X0wAQKkO9f2742tmzqfH2k91MOyq28n6qjBXgJtJGaocI54AZovPtdAaQ/HG?=
 =?us-ascii?Q?PzeO/TXjg/jCyjvZbiTU+bg4fUmTDtWJBZYqvUgjv+EEXdz6wClTaa+KFr1g?=
 =?us-ascii?Q?J6sZi33msKa2U/5zoDUQP0quXPjsev90rLHfZzFBp5Esd0BcHG4DZ857CBEL?=
 =?us-ascii?Q?PIMlh7Q0NW4Cjt+5EVLsjzsZ80ED9WWMlh3eQwtTC2cxnfdTRYnhHfhimeTN?=
 =?us-ascii?Q?LSQM/6CTGphTV6Z5tiYkuINdxC0ldZXSwgoLtnsdVmr8NpCNrmawzmWOmzIu?=
 =?us-ascii?Q?YXp1EdG4sIynw+laq05jb6HZvDyVK3mlhkh+DdsRJ2J9fIl9SQn2o4Yr/QSh?=
 =?us-ascii?Q?iN76p24Cvty9TeWn8nMSm9bK4cJ/y53TwQi5e+n0Amw+kUNLkv6MW7zHhy+5?=
 =?us-ascii?Q?oBb8P7NAezcUXepLOzCH9fJZFjsk32x9u/20dt0d3GSHPWJiqsRxc6R4xSAU?=
 =?us-ascii?Q?nvaDq7ZI2/GiQCoCtTjORY7LVRfSQseZvIiR10eRslKQRdJ/m6hPhfH1XpMS?=
 =?us-ascii?Q?oFPSDl6kkehCvPYws3v+tHQEkCmYrb9cH6YC9ShOY0YZ1WzcEBKRSTuRcBG2?=
 =?us-ascii?Q?HF/LTrxucwKH82yAZ1sUIcd49viT0NaPHuFurURrSb3S2TqdxzGUm2/diXqF?=
 =?us-ascii?Q?Tu234gYaAeT656slcYlg+CZBXvMo+I5fB2KC4RCYFqo2Tg9RpzFAc4ORjr2f?=
 =?us-ascii?Q?OIom+37GeV6WIlBg9oiG/nz1yh23wgv9XIVhFCFpM7cV1GN0f2uhtpWycxn0?=
 =?us-ascii?Q?KH/CQIzn6oOei9uJgloBYVeWHXE1+IyTTFa4Kwh7uC8kiAglnwseOtMh9gIi?=
 =?us-ascii?Q?BYRBL+kKqtUEKARI8k3K4AkV+RihQErMKNFscRGkXKVY8rN30Cm4p6qJrmix?=
 =?us-ascii?Q?zSz4Zq1nZRC7qqZDHa8PVRGbkn5c+erZUHXO5Xka6SgLvD98Q5oNzkpvLYxH?=
 =?us-ascii?Q?jb34dAz6Jy/fFiWMDaxFwRXClBnFYmS11opbdLzusR12z/V8lR97sepV/tqb?=
 =?us-ascii?Q?+TDeGF2UBHKqbG7RuaJtv3C7QVWwvjN7f6Z?=
X-Microsoft-Antispam-Message-Info: vL9SAWDFnVR1LLeg8SnGOykMtG7OR8cGz6TbLuATWztm4xHMB12QgN3dgvxehIS+oyugW8gRDZMH/0ityOcjDkG6S5MFMhT000bl9FzRCodRuBi5V245vbC/Z9120XF5AIYgTzssvPCNOOpJJ2XrxrmFgeEJiinDbMKklHddZnMUxTbxJG702sZoIEhB19rcDNDafNxTMczyBI9TUXqsdqSDfkeoBrCGnEmP5c0HVBsSDuXaHJ9yjON22wZDDSJcC0oHyI631I9pCDyAzn7FXkw0ur6eJoWKxbgvd9m9gnmrvmEyHngcv2wqLgoVWiUjSV58jLLzz/tZXJdLPmnT1w==
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5092;6:dEp4YcNklW0JAWzV1xIF9gxyxcyds2bM/j+orgssvx+h9NP8YRgUSzGD3VjYUhQTdmjTEuRhCVTlt9GHoTp98swsv+uV4LdnWrqW0l0fixiS/VIWz1mephqGNcPWz9TXIaHFRWVk7vqbb+JiX69d5dUJz+M61cQHKFCfAiPbvfT8KxjtdrXuXW7gM1xCtKw76YjdygqPkWVnOWN8O4FOhWEo4CHwtWyRHO6d8aMAs6aDKhYXYIrigJFQETZZgdcIa+XLXKwzA2jElhl0rLGl0tsZHuITAqvtFA+ScQObEJOYu6Z6n0h11f4RiPaW7nJGnsndhD/n0YsXgRncYlkAjRl1mJ8GGz0UuyqQR2/SPNMNbjA3lPz58P7txXHw5XXKjc5oTJ+J6h6mtIwRwv5lWHY60gtOokJ+U2V4GrJq5ggo/adSgyHXXb2fNSjxTT5cOtBYjG0lzySyFx61AnJlhw==;5:lrbuBP0qLm3DQbeM15JQYdHxtZrpi7BAhB7EWV5hWrflJeb6e/MMDQneadkHXtx/kajQRamsyvavkQmmeTdEkukJjaFkqGKS7VXzbnt8DFNlaTmiYYjkO5rHmvRksiCbBOpZx8BUicDfBU/HHnswGTbHHlDkaLc685197yGWyv8=;24:3IwxKr+rDqKMUwcELQF8VGt11ufTT9PSaKOOSZUWSJjyaQRVAxTUlg5AMULA3QT/jo5TB/wrUzk356Ft4BA+7bPZGkVVyvY6ltgw4ueoDsM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5092;7:bsNOSA7H4mOwTzSGXqjy4E6QgZc7YS9iJVjR+6J6TKe7CnCPGRWxRkpMafns5tRx7TTRtuegCwY+DivhAINz6ipsGr3ij6wUh1937sr2yNmkIvUw4xj2bYVEc0t5mUHlYkiz5sXS0gCokJulw+sVvwDATS7/h+40rR/noxvPD38Kzhk2MCzY8SLRRZUBAWHRkbYzRzJOuzd8ep8hj4rXankcz+dNtS/B0DVxgANBjCbh2xYjOK70urgSCpwG4vnY
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2018 05:55:53.0448
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6732872-07d5-4866-3228-08d5d5a95249
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes below checkpatch warnings-

WARNING: Block comments use a trailing */ on a separate line
WARNING: Block comments use * on subsequent lines
WARNING: networking block comments don't use an empty /* line,
use /* Comment

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
 drivers/net/ethernet/xilinx/xilinx_emaclite.c | 34 +++++++++++++++++----------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
index 0b41cc5..e8bb7b3 100644
--- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
+++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
@@ -70,7 +70,8 @@
 #define XEL_TSR_XMIT_IE_MASK	 0x00000008	/* Tx interrupt enable bit */
 #define XEL_TSR_XMIT_ACTIVE_MASK 0x80000000	/* Buffer is active, SW bit
 						 * only. This is not documented
-						 * in the HW spec */
+						 * in the HW spec
+						 */
 
 /* Define for programming the MAC address into the EmacLite */
 #define XEL_TSR_PROG_MAC_ADDR	(XEL_TSR_XMIT_BUSY_MASK | XEL_TSR_PROGRAM_MASK)
@@ -336,7 +337,8 @@ static int xemaclite_send_data(struct net_local *drvdata, u8 *data,
 			drvdata->next_tx_buf_to_use ^= XEL_BUFFER_OFFSET;
 	} else if (drvdata->tx_ping_pong != 0) {
 		/* If the expected buffer is full, try the other buffer,
-		 * if it is configured in HW */
+		 * if it is configured in HW
+		 */
 
 		addr = (void __iomem __force *)((u32 __force)addr ^
 						 XEL_BUFFER_OFFSET);
@@ -357,7 +359,8 @@ static int xemaclite_send_data(struct net_local *drvdata, u8 *data,
 	/* Update the Tx Status Register to indicate that there is a
 	 * frame to send. Set the XEL_TSR_XMIT_ACTIVE_MASK flag which
 	 * is used by the interrupt handler to check whether a frame
-	 * has been transmitted */
+	 * has been transmitted
+	 */
 	reg_data = xemaclite_readl(addr + XEL_TSR_OFFSET);
 	reg_data |= (XEL_TSR_XMIT_BUSY_MASK | XEL_TSR_XMIT_ACTIVE_MASK);
 	xemaclite_writel(reg_data, addr + XEL_TSR_OFFSET);
@@ -395,7 +398,8 @@ static u16 xemaclite_recv_data(struct net_local *drvdata, u8 *data, int maxlen)
 		/* The instance is out of sync, try other buffer if other
 		 * buffer is configured, return 0 otherwise. If the instance is
 		 * out of sync, do not update the 'next_rx_buf_to_use' since it
-		 * will correct on subsequent calls */
+		 * will correct on subsequent calls
+		 */
 		if (drvdata->rx_ping_pong != 0)
 			addr = (void __iomem __force *)((u32 __force)addr ^
 							 XEL_BUFFER_OFFSET);
@@ -409,13 +413,15 @@ static u16 xemaclite_recv_data(struct net_local *drvdata, u8 *data, int maxlen)
 			return 0;	/* No data was available */
 	}
 
-	/* Get the protocol type of the ethernet frame that arrived */
+	/* Get the protocol type of the ethernet frame that arrived
+	 */
 	proto_type = ((ntohl(xemaclite_readl(addr + XEL_HEADER_OFFSET +
 			XEL_RXBUFF_OFFSET)) >> XEL_HEADER_SHIFT) &
 			XEL_RPLR_LENGTH_MASK);
 
 	/* Check if received ethernet frame is a raw ethernet frame
-	 * or an IP packet or an ARP packet */
+	 * or an IP packet or an ARP packet
+	 */
 	if (proto_type > ETH_DATA_LEN) {
 
 		if (proto_type == ETH_P_IP) {
@@ -431,7 +437,8 @@ static u16 xemaclite_recv_data(struct net_local *drvdata, u8 *data, int maxlen)
 			length = XEL_ARP_PACKET_SIZE + ETH_HLEN + ETH_FCS_LEN;
 		else
 			/* Field contains type other than IP or ARP, use max
-			 * frame size and let user parse it */
+			 * frame size and let user parse it
+			 */
 			length = ETH_FRAME_LEN + ETH_FCS_LEN;
 	} else
 		/* Use the length in the frame, plus the header and trailer */
@@ -601,11 +608,11 @@ static void xemaclite_rx_handler(struct net_device *dev)
 		return;
 	}
 
-	/*
-	 * A new skb should have the data halfword aligned, but this code is
+	/* A new skb should have the data halfword aligned, but this code is
 	 * here just in case that isn't true. Calculate how many
 	 * bytes we should reserve to get the data to start on a word
-	 * boundary */
+	 * boundary
+	 */
 	align = BUFFER_ALIGN(skb->data);
 	if (align)
 		skb_reserve(skb, align);
@@ -707,8 +714,8 @@ static int xemaclite_mdio_wait(struct net_local *lp)
 	unsigned long end = jiffies + 2;
 
 	/* wait for the MDIO interface to not be busy or timeout
-	   after some time.
-	*/
+	 * after some time.
+	 */
 	while (xemaclite_readl(lp->base_addr + XEL_MDIOCTRL_OFFSET) &
 			XEL_MDIOCTRL_MDIOSTS_MASK) {
 		if (time_before_eq(end, jiffies)) {
@@ -1028,7 +1035,8 @@ static int xemaclite_send(struct sk_buff *orig_skb, struct net_device *dev)
 	if (xemaclite_send_data(lp, (u8 *) new_skb->data, len) != 0) {
 		/* If the Emaclite Tx buffer is busy, stop the Tx queue and
 		 * defer the skb for transmission during the ISR, after the
-		 * current transmission is complete */
+		 * current transmission is complete
+		 */
 		netif_stop_queue(dev);
 		lp->deferred_skb = new_skb;
 		/* Take the time stamp now, since we can't do this in an ISR. */
-- 
2.7.4

