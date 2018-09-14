Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B831BC070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 07:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E58B20861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 07:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="j+jviXF8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E58B20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbeINMcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 08:32:32 -0400
Received: from mail-eopbgr680086.outbound.protection.outlook.com ([40.107.68.86]:22336
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726527AbeINMcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 08:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lKmn0/c9S0i15xhavgwtBx/xsywKe3sBmzi3K1biGnY=;
 b=j+jviXF8GDMRyhAGY7Gk+hcFLjeWFRaxx7CJfqzR+IdXAiSvTmPDE24gB6cXd+Kv20PkbKwHOefgtU0u43vv5Ds+Yy0pQgp9Qsg5ZgOn+gtdhyl29YJQlJZiiAm8rrGdqiRqnEofMWaaItTuvLMKHHEcqTG83BtEpnk5ioUuWB8=
Received: from SN4PR0201CA0027.namprd02.prod.outlook.com
 (2603:10b6:803:2e::13) by BL0PR02MB4466.namprd02.prod.outlook.com
 (2603:10b6:208:4a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.18; Fri, 14 Sep
 2018 07:19:13 +0000
Received: from BL2NAM02FT051.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::203) by SN4PR0201CA0027.outlook.office365.com
 (2603:10b6:803:2e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1122.18 via Frontend
 Transport; Fri, 14 Sep 2018 07:19:13 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wunner.de; dkim=none (message not signed)
 header.d=none;wunner.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT051.mail.protection.outlook.com (10.152.76.181) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1143.14
 via Frontend Transport; Fri, 14 Sep 2018 07:19:12 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g0iNj-0007WI-Dc; Fri, 14 Sep 2018 00:19:11 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g0iNe-0008Ix-AF; Fri, 14 Sep 2018 00:19:06 -0700
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8E7J17h005096;
        Fri, 14 Sep 2018 00:19:01 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1g0iNZ-0008I4-Dz; Fri, 14 Sep 2018 00:19:01 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 80D7712159B; Fri, 14 Sep 2018 12:49:00 +0530 (IST)
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
Subject: [PATCH v2 0/4] Add Xilinx AMS Driver
Date:   Fri, 14 Sep 2018 12:48:26 +0530
Message-ID: <1536909510-7166-1-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(1496009)(376002)(39860400002)(136003)(396003)(346002)(2980300002)(438002)(199004)(189003)(316002)(2906002)(8936002)(47776003)(51416003)(4326008)(39060400002)(50466002)(478600001)(81166006)(81156014)(48376002)(8676002)(6266002)(110136005)(5660300001)(72206003)(26005)(14444005)(106002)(16586007)(186003)(426003)(356003)(2201001)(6666003)(42186006)(7416002)(52956003)(36386004)(54906003)(44832011)(336012)(476003)(36756003)(2616005)(486006)(50226002)(305945005)(63266004)(126002)(103686004)(90966002)(106466001)(107986001)(921003)(83996005)(2101003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4466;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT051;1:srQcyfesTBf2PL2vUuo7Dg5ssQBjPX8hPkUyTVBcXP0e4C9+8ONQF1Q2L4rW3bekQxP4VDOewqp9ULNjkH4NBKxuxMnFgb8GRKj4egbr2GnQrMZe/CoV8IypGAs31goh
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f6b3dd5-86f2-403c-8e6d-08d61a125ee9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL0PR02MB4466;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4466;3:zRyg1ipSds/kwZxljUHFUE1Wp57523XvzQWqxt0Nuf9pG2tSX+JUQaw4lHwgaxrIarKKmel+XVgYNrrTYK1Oa3DWodZkZo499D/GmJseGTryewwqnjC5ILJoxiGfQH+EiAMEI38Zi5MVAy/eBUYgPfn+AhTCGmtEJl81FlnS/Z7OksOxLRC19prLDoLy/cZoN0vuKrEdAeur6dE/a2Q6/UwwQpg9ieR2W2+LIXIa88sCNXyM0oNlEmWd8Kv4zLe1jgnzmHZo+r1CAHBXxmxoI0crfOG/6mB/RklnubLEeUR7MnNajkc2Z99o8s6VGV9ct41DQ2UpInNMWCvr4JZSMvEePBL3ix6QdQNs3Wlxng0=;25:eN987GSUdSt33MC4dnv1SmYeHxCKhZPNKeKELuROm7lrzFLN9eV95Gd9maNfw2Ico7K3USbMME687qluKrcp7qCWGZfXbQa5FOgeMsFZCHuHumb+HWyDAkBb4wpPOEPfhepUagCM8ht0U8+GV2rRN3spNH6j2Zuh+KQ4GGU02JtKVOhrrIVyb6FaiUqzmLaGS01jMV0KuANiPqHbWSvWVAR7YGklGtMp3sZH3Xo3CRnAHKToJsp3F7VQHWKLDt84iHycAVvkJiwkeUqmTVj+uhxHUMfsraykSGsIJn8H4vXVRQUkndmkg7e8rKzDDnX2IGoPoKCWcFw7XEtgKqF69Q==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4466:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4466;31:CXOqDj757lzkCG2gAwbNynOGDsmpsmXpSZs6u/9l/lezjX1nAkTnDfzxvlwiOmbMwumXxKmb7gi/QOp2p5WwSLXWa1rk3GrbLNwHQaWUgyrku0uZxk5BsxuRp39hafrfRCjHcS3wS21Y9AEOgloYbtHkCKLBUF8u9lxv2DL8TBVssM5W2mhFYxxept/nnqCVC8WYEBJumMyPt6f00CprMJH1f8EcjgGnGsjWjLkku4s=;20:C9zjPG/XLZotHnRlfyXBns0l6S1G2KaWPyy/u3IlHWZDwYi8KedAN0NDWWYQYucCey/e7ba8fG0vBSZQPCwxJSaBVaN8dN8Rbgnc6Xlw4pOmISyXGpMwxwaR+f0/Fd7JVvZQy/1cjmlCTHj/4bq8VNO0xYu/TG2P0CF5ZLcZtlNrjuLCOkRG3ypJVCYomG5yfuip9ZbD43wIs0pY56iqQBU2ot9w0LvDnsCygWarhONgd6bdqOJ6EKhZxeQ0MT2axTGYt2O0/kt7q2qG+mNrrHbBL4+ywBb5lG7B4kKuUVZmd2vsx6uKzdCIwbM1XEe3vfDGX4hT03atNKqeHcrM8+beFb+fsLM7z2v2T/i+i+CIELnve7PvcxIuHi9vdoB/z8KDuJnrXdpZPDP923ZKFAu3lb4tzJxXxrnGZaQG542x1x+dGgcFNA19gbt1rSX82XSB+KTLEXNUnrXzjHmKV/JFAiP0zdE0xIAZxl3KwJ2sr+KTwlGAcRB2ASXgq1IJ
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB4466BDE1CB7B783177667CA1C1190@BL0PR02MB4466.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:BL0PR02MB4466;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4466;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4466;4:EzQBfqZY4nIQ+XqlUA6ohN/Co35PAbTUA3eYXaw2x/5LSYntbcnfn1Q8q/BEZQ/1HwRQw3nqN6nWZJVsTCk2O00UFwTUN6Rto7yloAkCIo88hzn82lN/AHiQ0LlMjzr9A6OCpszAJhL83ANj78x8vJvVO8k6y8cxpBLHLosiO20Q8pyx1mKR4TdGX+g6oOrLr+elwIQi4thpUttZwjjwvQ85r/5afkRg5KRXjysgGFskIswK5rgkP1dRFio/b9kGoFwclL0VmBmCDZ64iRYfvQ==
X-Forefront-PRVS: 07954CC105
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4466;23:XFzStfDrUZZ7xBpzS4ESnsdxhGF/vCQxD9HM2vm8I?=
 =?us-ascii?Q?k4ENAEJaqC1SW6iB42lwESqWPOCYLvIHnTqwImkkt4PJsZt0jAvdwZpZg39y?=
 =?us-ascii?Q?amlPHAoBTezVYDgakgT6IDGBu34wXHB0MZoQdu9GSwNQp/VkQ2YI+iBtvzDv?=
 =?us-ascii?Q?O2YL4+WMx42Us63fHHQRRYclIAy3knyc4qZ+f0dR3mkahIe1jS4o38MnFN5C?=
 =?us-ascii?Q?W9iYUOCxRzlIDaHw6jwRNSx4ROxa1AH6yzTkmo32SfYiZ9XbdNxwUkc5qcBg?=
 =?us-ascii?Q?nHmy9AEnlO2sbyRw0AUZyUTSfTcwR0031510K1Dm6BNxunqdAbECThzBao7D?=
 =?us-ascii?Q?nwoq5rjdcinK4l3vfLNhQRw4YgpOBM7Kdv/oLhhncS5isjZRkRVX3xhIs/l9?=
 =?us-ascii?Q?boEYZcRgq0onKCK+bhydNU7lrdXSeohM0sdmWt2GAXiRUte9RUB9qe/wiVMD?=
 =?us-ascii?Q?EsD7AxMs+DJCEgIpCIcvchSRfiLFM0zWyRms0aaaXXY3LLamh7RIj9CbT8QS?=
 =?us-ascii?Q?I93J8ZX/WTETsPP8tZZBehkxfN0ke16uvKAUYQCmZLN4106FjWAJOegtgJe7?=
 =?us-ascii?Q?ZORl5iiLlfyr1h+FdZu0D6zcKN6zaWMiaNWxlTV5E7z7h8xhJdVkYIVer+Ar?=
 =?us-ascii?Q?l6XJ/bKGc4vEWZoUcRYhwHvmKIhPuGo05YYfbG3eQOBMSraT/jgtcNqNJ04Q?=
 =?us-ascii?Q?AsDc0PrQrPSkiEYDz1LbiusvOi2H5sdS3ce80nB/YaL6jSKgLJTc1D585h/d?=
 =?us-ascii?Q?T553+k6Wi0KzngNj4zxIsmhZCRWcsHd0tnu/W/uk9hgwMM3vdFL+K0SirFB/?=
 =?us-ascii?Q?Ifr3MueO4Rhk2W2vFAE5XagyEJ7gj7e5igT9bXkSIROrB6JpECBskPaeL2mC?=
 =?us-ascii?Q?NFgPahx4bij3K5h3RssXuMawuFRY7OkVsyXsF4qwJ2zBEssA8lzoWG0h4xAF?=
 =?us-ascii?Q?t60QJOgjlQQWa3uiLfH+JREbHjyfNgm/NVZrv7Daa9eELc1MM0q2RH520Znk?=
 =?us-ascii?Q?lsXivBUGqXIrAVVBaXsR+1UqpHVF29MaTZhCobxJYvTNKHg4mhqhfhIFhBZD?=
 =?us-ascii?Q?bgPK6qXbnru9kNpCnTY2ESiqLUxlwoaqpBM5F/BdxFIGmKnBRRQuJu1fiFCD?=
 =?us-ascii?Q?zEkcMEDInQVIkC6jqfACSQyS7KSnwPlhjhBWzVYCjTUnRx6yalRXOsVi6u94?=
 =?us-ascii?Q?nXruuHbYzgiWpy5nP3DehFunV5Hpy68HtJTHXfdgMbW8NM9m0DLV5cxO7+U6?=
 =?us-ascii?Q?9mJZwcAfn0kCCutsdpyTCKtXsY+L/5jewf4Qf5xHSg0LCdO8W12onwwOf5St?=
 =?us-ascii?B?QT09?=
X-Microsoft-Antispam-Message-Info: /mL0g8TofeySqoYb1IPrP0+Nea8ApaaR/YoXEEM6J065Rd8PphxY6DqG1pXX4kEpkbrp1R4t22Peh4UVIc6FWEQ/OkvIlzNdFV61vwDpAyxRxrAC8rey+t3MU5QmBztxnXxbvVtnnXo0JtV9CfmE0TGgom5ZU9kzUIV4wwPrnxE3FKjHjwefrWFNjOmaItZ50kZrDRcXKALMXgbyMck6WYgo1HDviRFVVQlN5+WMg1vKkGoC558iKFLa1vnJnntHEgWbulMJyfg3XCc1h3zE3wcAWO8+ixrDaMuvlEk1QqKUT7zbqNCVkxFhpR2y8VyqOnZRQCPW2mEqLVyE5QAFMOE1Vw09rbJ4xIlx2Hdc17M=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4466;6:8oY7X1vOE12jMXmQPVtCEBIRD8SAPfPqUoewrEhLusQx2+qASb/qdmRYZ5PmEc0pN0cBNqAR4x2yBDMLpvdJP6YpougfwPrJu6a86QP9v/LP1cjtrFWLMGlpLTduZ3Ovs0sg8hxxamGSKAZ3tPU4PgqbwsvLKlbOVMCYCwGHLFGCdq5yKFTeWOyGF1AN2G5TyqiU1d67CeUzf7vqjfOdjvf28fXCRi3+eVk6aVXtI0T+EmnyxtyH/sQJhLc3tuoydm0MjFsJgrGeBuj7rSt9QBJVZsg32ITlsDuLxt4LaY92wn9nbzUrMyyMowk/ttuojNfRbiVmoTf6T5fokX1hgUSdSln3QfoX/75BLrkE+2BYqcFjBBFttenDgiiDfuTQoVt3g4GuIMVgu9HQm/VrrbdTCV9TpbqdG5+rRGA8e8A0EekphpYbRI32QfXMms+eP71B17Q996oZz2ogxWnS/Q==;5:D7nOiZGbOashGtoDlOZxuOLmksM4n/rhpr/epmbZfER/6IIgh55JjCErOyZpCRdu7cpHBOTl53KX6o+RfrHzRuXqrByrGb+r0qUawdtsb3a/dFyglvtFZxe7rnAKetBGKuUhqbUG2OCiMV1BflPmZCGewHOmzXc1tZLJutwbi00=;7:E/xJMYp/riaDKwyGFvr/RKUd582WfdNL5+X3frBc9hKCciJOhEveUKNPMXXbTGAyCyRLMCYshHyktXAoS59aJRVMO1R9xE83jMEUSq3Fa8XYW82EI8fjOlK+coZ2KA24MQDcxTPe73Hk7peIhuj0VEIxBvG0oo3L+QLQ4kx8V2zNRNogg25RIUvDp+Fem5Yk6vMPtoLHvv08YXpXpPuRN78s4uDat3gw85+3pFQVWS9ruQrevm0pk6TvJ5mgslnV
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2018 07:19:12.1726
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f6b3dd5-86f2-403c-8e6d-08d61a125ee9
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4466
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Xilinx AMS driver which is used for Xilinx's ZynqMP AMS controller.
This AMS driver is used to report various interface voltages and temperatures
across the system.
This driver handles AMS module including PS-Sysmon & PL-Sysmon. The binding
documentation is added for understanding of AMS, PS, PL Sysmon Channels.

Changes in v2:
	- Added documentation for sysfs (Patch-2)
	- Addressed code style review comments
	- Patch-2 (Now it is Patch-3)
		- Arranged the includes in alphabetical order
		- Removed the wrapper 'ams_pl_write_reg()' and used writel
		  instead
		- Removed the unnecessary delay of 1ms and used polling of EOC
		  instead
		- Removed spin_lock and used mutex only.
		- Used request_irq() instead of devm_request_irq() and handled
		  respective error conditions
		- Moved contents of xilinx-ams.h to inline with xilinx-ams.c
	- Patch-1
		- Addressed Documentation style comments

Manish Narani (4):
  dt-bindings: iio: adc: Add Xilinx AMS binding documentation
  iio: Documentation: Add Xilinx AMS sysfs documentation
  iio: adc: Add Xilinx AMS driver
  arm64: zynqmp: DT: Add Xilinx AMS node

 .../ABI/testing/sysfs-bus-iio-adc-xilinx-ams       |  246 ++++
 .../devicetree/bindings/iio/adc/xilinx-ams.txt     |  180 +++
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi             |   26 +
 drivers/iio/adc/Kconfig                            |   10 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/xilinx-ams.c                       | 1337 ++++++++++++++++++++
 6 files changed, 1800 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-xilinx-ams
 create mode 100644 Documentation/devicetree/bindings/iio/adc/xilinx-ams.txt
 create mode 100644 drivers/iio/adc/xilinx-ams.c

-- 
2.1.1

