Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB56C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C99020861
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Hp7KOnIG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C99020861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbeIGPi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 11:38:28 -0400
Received: from mail-eopbgr700058.outbound.protection.outlook.com ([40.107.70.58]:27003
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728829AbeIGPi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 11:38:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nq1SOm5SLTgZq/vaD2zcGDk433itUIkDa462trW8Crw=;
 b=Hp7KOnIGSzwuYB8x3M1r21AQRqXXsRWFsH1vbAcovjtHQjJTgu0mHVYU5hkSfQhnwlBOw6Sd9Ne/xevJUBvxUf0wbzIF/9LPdLc4sIATSbyMqTW1OUKUN8emAxiX7nFkMr5BMASO40EyCaMRNYKUOQsPa/kDJKP995Hfy7gTaSU=
Received: from SN4PR0201CA0020.namprd02.prod.outlook.com
 (2603:10b6:803:2b::30) by BL2PR02MB499.namprd02.prod.outlook.com
 (2a01:111:e400:c2e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.18; Fri, 7 Sep
 2018 10:57:56 +0000
Received: from BL2NAM02FT006.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::201) by SN4PR0201CA0020.outlook.office365.com
 (2603:10b6:803:2b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1122.15 via Frontend
 Transport; Fri, 7 Sep 2018 10:57:56 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; the-dreams.de; dkim=none (message not signed)
 header.d=none;the-dreams.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT006.mail.protection.outlook.com (10.152.76.239) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1122.15
 via Frontend Transport; Fri, 7 Sep 2018 10:57:55 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:39283 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1fyESY-0006x0-RG; Fri, 07 Sep 2018 03:57:54 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1fyEST-0008Iv-N9; Fri, 07 Sep 2018 03:57:49 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w87AviUJ012460;
        Fri, 7 Sep 2018 03:57:44 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1fyESO-0008HC-BX; Fri, 07 Sep 2018 03:57:44 -0700
Subject: Re: [PATCH] i2c: xiic: Record xilinx i2c with Zynq fragment
To:     Wolfram Sang <wsa@the-dreams.de>,
        Michal Simek <michal.simek@xilinx.com>
CC:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <linux-i2c@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Heiko Schocher <hs@denx.de>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        <u-boot@lists.denx.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <a36257084b0816bd84bb1caacdcde586b7fcb007.1536300108.git.michal.simek@xilinx.com>
 <20180907103407.GA2310@kunai>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <cb141649-98a8-3019-a869-485b78f04f66@xilinx.com>
Date:   Fri, 7 Sep 2018 12:57:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180907103407.GA2310@kunai>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(136003)(39860400002)(2980300002)(438002)(199004)(189003)(106002)(54906003)(478600001)(426003)(6246003)(50466002)(36386004)(446003)(76176011)(65806001)(8936002)(47776003)(11346002)(65826007)(356003)(4326008)(64126003)(5660300001)(31686004)(81166006)(26005)(63266004)(126002)(77096007)(106466001)(7416002)(476003)(186003)(2616005)(9786002)(336012)(53546011)(44832011)(486006)(65956001)(8676002)(31696002)(110136005)(2906002)(36756003)(58126008)(316002)(230700001)(305945005)(6666003)(23746002)(229853002)(81156014)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR02MB499;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT006;1:+sfxpANCFwYxcZTeof+IpHlgC/ICOowIbKo6DT3okO1ulERwofBriyRLh5dMtIh9tyngQD0mRTRyt60m/DXEqdP0HQLr43Z+tWYPHdgzAQxf72Fd12s19TpG66Pf3XRR
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18fe90f9-0858-4fbc-d62b-08d614b0c416
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL2PR02MB499;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR02MB499;3:3GldAJNMcHc0lCXEMKTagLoflJQ1dZ1ynzvtXGBKrELjRL/SSwFOdgt3hT8wffk6wiokA3hDWwlmgfldNFdM3hZcMaPiLqnDMRgeH+i8nb/mTInwwOV400MqU0xKtonkfN4wctjYl8VILcfM6hv/PV/2ufXPuThhcEgYBALAwxuaiKktpiAsu9Bje4y8q1REsT7WSBic7ERv9dQ/1XSCbdyeuLvdtko1/E63r1K81e1cv5POaa0yrl3il/bLzie5sFFNXTMfjnFq3Nh66N0eUJG428VaeMT6G+ypGBr96DZ5Y5qNkd1qCXFdIS/91G0J9CdUUPptD8z78sSv2pHJLXi3+lOrvvV9ItuzRcmh+pc=;25:XyEcLeHH36Z5tMPh4T9nR77fU1PQsit8UH/tA/EKyirtzO5II/4Bmmh/8f75Krk160cAq5zJMhkzu9WGZ6BpJx97ssaL5aNzAOsVnCz3MUR6o3JeRu4PMmooiNYeFW9VXMXKfA/RjQNhqXDrNqzjjl/nZ523NkuOdo314W4X3VmkQIhWIzCOTttCvs/FTmBwf8Zh3cSO2XMqD97OoOei/AqJzYU+ikqJ+k2cRVTqZTh/8dGlbrtBTEPZB7DPby7M+GlUKf2y7br+oDOC2cAayPbOOreq6AH9cmZnI+VzS9ah30rRnvfOuyqr6zrfBXwODsIUfAfyJADN4VFVqp0OOA==
X-MS-TrafficTypeDiagnostic: BL2PR02MB499:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;BL2PR02MB499;31:o4fPG7lCf81A6372zC//TE9ikVNh3fagKR16nugsn9Mv185uU2YWxEC26n7yyncz9hLPa/0SbiGxGcC5S/vjXQbpvwJWCbxCSMmkMqSK/hHaCWaa9qWxBVOmaKxLWNbYoCiiGU9c/b//QLRfDHtcuZyNps/M5GoOiHkSdMUgiAI2+0AtGOi/OM5tLaSDNhCk/lOZdFWgkgK45eVokvMLObS/oaVjLaUvgN+6y9LNCVs=;20:HaWG2nZeyWrAcNwVGybhv1KlWBjDDDznIigtVNfTjAjTlJBeREYXylp0p/7ROcvOOrbW2nG02nl7DIoDmjlopwDGKtvFWkqJLbKBdxU/LjAVbEVeKvoZZ3L8E/WjmLhD9Dpuz9/c47jlRYUSdr07NRjXKe4N17pjJ8/mvVvPkfH4jnqvv+LtYcYUCc/nANmCjot6r5OLnK4LEIugi9KldMftSzUoAWNpK/zG6VqqDWRD5WrQLxXVJG+v2NZgcsL/c2k3b/LAbLkSBI+MLcYD7QzJzahDqjHH4ns1VTas8QAGVbaL38tBA67jxAVMwcMqYvPwodIyF2m2F1Vx0nqaH1BddazMlTAe984BeJ8RUPT340Yux25SMRVpjaAHgfRdaZ/3VPW5eBR5age7oqttOB6xxSh8TkdwRMyfbOFtYXn0PGH2b8hgvIBepLtafsfzW2/QxG30ZPLorf9m+aG6gVH5xRY5fDoAiRQjE9E+lqFZsN5y8FOAAdjQpGJxfWFL
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL2PR02MB499B22063051B869911E97EC6000@BL2PR02MB499.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93004095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:BL2PR02MB499;BCL:0;PCL:0;RULEID:;SRVR:BL2PR02MB499;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR02MB499;4:GP9vsCYXS3E5pk5A9LWpNHNSchXYjC/RZBjjPhOzYH9D9r2yp/PsdfH8xPOYPjTD5zjmsvRyOGPn7yzc5nX6BCkvh3QKB2vF+ik9Ce73kVZUA+9gPixjMrL3NjEu+3WYiUXNC3ayAcmLSJDzZ7MUoMAJq7ejA5ILZNDnckhJjddnQp3BiAoIb5YZFD2nrZuBE37NMm8Oh0Pu1lA9Zma6UrbG0P7iEAQQCrIMeXb8oSr5UJ3Lqnvwkun58UHOTr9YCIcx/axvjSbpFNDn1szaEMQATPePQ0Y9Wm6yE0TdsYlrXG0lwKapINFGBdRSXij4
X-Forefront-PRVS: 07880C4932
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;BL2PR02MB499;23:WaFlC8Anc5ybdHHnsZekMvDaG5bFZftriRLaR0?=
 =?Windows-1252?Q?/fQ3vo83TLzVx4o6ZJPppnVa4dg4hF8sXsE3IxiIKLW+Z2BidmOP/L0r?=
 =?Windows-1252?Q?AYXTNCEftujSLG9cpnwv2oSHKr2sI6G7zXyHrxWqp94F0PCwlrjYLgH4?=
 =?Windows-1252?Q?pCWCl6ltTbf0NqpxmvvszGGlD5mHALWqrYevo4fvekNf7sF6zeALmmn2?=
 =?Windows-1252?Q?SYhZSDeS/tLkAnfPw7YBiKmQ9wcF+D0GceMEIlwF85UgA37tTbylMQHS?=
 =?Windows-1252?Q?qBb/QydUY2PWG+nIhPr7SXApO3YyeJoLKpWOTh3aYWhRj7+QaQUq/K+l?=
 =?Windows-1252?Q?yTQ5LLurzeptBZfCYnS8FiowTEcc238Cac7CpuoVUVyS1vE776OI0LDH?=
 =?Windows-1252?Q?i9bIqUMk6xihCBPP4HKyjiOCr/aBz9f5Bd5USTDC5aB9v/tbKWH8j9yG?=
 =?Windows-1252?Q?bUUfhl+8pC7wqO2+wQlcKtcF7NWiuT6v3/KJMO6CTx0E1HtNY65w4CGa?=
 =?Windows-1252?Q?YK0I5HoHq+MYANB5bK8lT4XsupXiDsFt4y3WZTHl47pYhtcpfkMNGiLu?=
 =?Windows-1252?Q?MNQIaJD6GuKdtoG5JFpU8ljBwpmyas7iSKKx+xUQKhKmtddnS0uVlHYK?=
 =?Windows-1252?Q?9me3JcHyNri/xWA/bOj/nHF8bizstHURSIW1w6eufew83GZpk4Basf7Z?=
 =?Windows-1252?Q?ToZ56EUGFpmxxOhbswrGDe2SoZU8TZZzAi0iUac/ZcYfnIffXj6UhrOo?=
 =?Windows-1252?Q?a2PwcxG/URMA2klXAkpPylglpx2PFIjdPQl+4FyujARy2mRJjZlKaTRA?=
 =?Windows-1252?Q?LHvY6mzTIryOh7PLg21ak8oiDVyb21Drm/TgQF3ejhXi5DiY3T7Xt8qa?=
 =?Windows-1252?Q?gJVyCXICz7XUB9OOqqD9JE0AhGUEeqkmYD0SpG8bm7BLU0/GzXQY73Cg?=
 =?Windows-1252?Q?B5yRlbnGtZUjpFOnTAmaDsjzInMKFVXSBqS2hLNfyXRs6vRrcdSoEjxu?=
 =?Windows-1252?Q?GwoEFrkYNZ/hdjSTUmSrxRaLLycCcyW/BwI6lKuyWTvA3rDIWPTt5oO7?=
 =?Windows-1252?Q?fa+cjXbnw/CcJ49f1+OMv76RD3hUHmkvBesFTvM1YjWLrDrmQJyCkEFa?=
 =?Windows-1252?Q?UR84G+gilsU8hjVgkgWGrcJRnedav+WLz8A2t3V2R4l9hd5/F35Ex8g9?=
 =?Windows-1252?Q?2YWS+QO4gXf7sb68GVfDpzAlbaFQMDGyIdBuCynSCWiCIZ4oEq1y6ms8?=
 =?Windows-1252?Q?jO55G70sTSznljqEHXxLzOuhB3RfaWBQz5a0hJDMe8WnGVrFCAz+sbZs?=
 =?Windows-1252?Q?/m0vdpv1/3Px1+sZdBxAMWglMQ7goY62tDIZ8Cyg+92UZZGhadgpIC3W?=
 =?Windows-1252?Q?KvlZFTRgDvcxwM9SasHWcJWrawTQFjKw6Tw70QWXbAypWvg/Gj0+4=3D?=
X-Microsoft-Antispam-Message-Info: CRhSDdSJ9W0AV2JpEnheW69a3EShb+tqaLNvM0jQOGYMNgzuYCIJRjZlt0YEb91EG2gRiAbe+kbffE1X/Wkn6O+VB2H7cFZwPrmvhuMhKTpLnIHmcG54d47Wp4JG1O3trkhkOOwvZfl+UUbnlIfFBruiDm4C+fHaSkDGhZddShWnym75vQRPHM/kQyQ8ggjIm2b0FQN92iDMMnTlPDkg0nOMl3Opca50H2SXgy/XI5l0Mo4odqVoPH1j8A3Q6Td9GJj0KA04M/Jkqufx1YLyYHL0nLvmiXgKRaqQUnlu8iwo6Rh1iwg2gjQ9Els4GJTFwN/i+M16c9q/jFd3GINxkiaihMUA7GrrDCHQ2oz1HV8=
X-Microsoft-Exchange-Diagnostics: 1;BL2PR02MB499;6:0oy2f3bttOdVvvzY+UD/rbpAomUwxpda1wNxwX8bDfut3OLcoQcVqUkqSgusP5yXaHV/rg0o2NCevGO3cF0J2BhyyvF3ConGAiYNMWQbE03D66QW7kFg2Sr6vJWCDIbzFmeHvCsy1CjAjRQ9s/+ik0EpPlR2exb1u66bk0Qujhnl3UMyTNDGkOwAchdLHBmmO+fxW+ZwMj/BPdok1jncBJjdds5DAMUeORAdL48XcsZGFpCZDx8uk2NGTYYul4XGY/OyqSoKTBymi8v0UpJ1TGNlaOL60L80pti7qs+UXwOcQJ2x/FGzPc2XqK9K8QwvkJUGucn1hJwDc9BfOCqeXTs8gb+X6TBsgPROGp8vbOR0cNjYUjhBMowOJoTeT76eCLjKltEiMO80vYBRlgLbXDOQvCVKWYOv0SCinzuLcZBLiD7BzMgrmpdnnDlbFXLWt3biJYQ5XgBpMa9eqWa6lw==;5:n8vY/TeGiFHXkISHpg9F9XH8CfgdTFaM36ZbMFlCfkLWkX8LmUIMh1ORXxcnDK/tAuxQYk1c6VBfF+AW2zqqi4H40jyuom0FPGZaaeAn0tS31cg3fBToDpm7Gmu3zXET7/g5V9ah2aoA+VGlu1fRk6Mm67L5Mvj8fj4IWSBIBVw=;7:y6UTDh7hJiDRp6bOp6e4CdSzLf87EmikqhrSwy9dA8ckbLsOjT3Dh3vKHVGCy74KtSRENvBY91hjJEOQ7rSPIzJrckceFSOvVfkOBTzjG3IGK9IhT9mI/bQFEsimKO+0rRmhcbMvVNDs4OxB5kwJNnFktGqCLJQDCy6BrkvSLomKL4rP+Fl2YkADZxM8CryfoxaOzmvPLx8UBfR5ktdUXgdOVi8/eFp0EADXxrFHhQnoUltWwi2bJcTFOZ2+QA96
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2018 10:57:55.4415
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18fe90f9-0858-4fbc-d62b-08d614b0c416
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR02MB499
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7.9.2018 12:34, Wolfram Sang wrote:
> On Fri, Sep 07, 2018 at 08:02:05AM +0200, Michal Simek wrote:
>> Include xilinx soft i2c controller to Zynq fragment to make clear who is
>> responsible for it.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> 
> Cool, thanks!
> 
>> ---
>>
>> Normally we are handling all these drivers via one fragment to make sure
>> that there is only one central contact. Another reason is that people are
>> changing and their responsibility is moving time to time.
> 
> This is fine with me, but what about sorting the entries? I don't care
> much because it is "your" entry, yet I thought I mention it. Let me know
> if I should apply this as-is nonetheless.

It is not sorted even now that's why not big deal. I can sort it later
with this included.

Thanks,
Michal
