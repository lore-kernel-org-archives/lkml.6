Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0188C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F8C127404
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="J35/mqTh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F8C127404
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966171AbeF1NNV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 09:13:21 -0400
Received: from mail-cys01nam02on0065.outbound.protection.outlook.com ([104.47.37.65]:10496
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964921AbeF1NMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 09:12:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6sgsJDrV0QdYNur4PUcM7BPlQYSZB6O904uKUyD9dPw=;
 b=J35/mqTh5/nBuoIODVpYf45LZIGNcSpmOpwkC70cZKo811cS5sOKTpbxDERIH+eIL8ECph9yT7UBS9VbbH8hvSSJyoJlcFFpXkVlEgcQLLvsOYWz+stMMBOoZeFXnTbOTjL0UCNVQZ5fVPMfaU6ckLSEaEryyjRCaKkzH9vfjjw=
Received: from BYAPR02CA0026.namprd02.prod.outlook.com (2603:10b6:a02:ee::39)
 by BLUPR02MB164.namprd02.prod.outlook.com (2a01:111:e400:849::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.884.21; Thu, 28
 Jun 2018 13:12:06 +0000
Received: from CY1NAM02FT018.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::201) by BYAPR02CA0026.outlook.office365.com
 (2603:10b6:a02:ee::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.906.24 via Frontend
 Transport; Thu, 28 Jun 2018 13:12:03 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT018.mail.protection.outlook.com (10.152.75.183) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.906.15
 via Frontend Transport; Thu, 28 Jun 2018 13:12:02 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:53400 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fYWiQ-0007GP-DD; Thu, 28 Jun 2018 06:12:02 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fYWiL-0001yd-AQ; Thu, 28 Jun 2018 06:11:57 -0700
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w5SDBsW9027432;
        Thu, 28 Jun 2018 06:11:54 -0700
Received: from [172.23.37.80] (helo=xhd-paegbuild40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@xilinx.com>)
        id 1fYWiH-0001xp-Ti; Thu, 28 Jun 2018 06:11:54 -0700
Received: by xhd-paegbuild40.xilinx.com (Postfix, from userid 13245)
        id 18BECB20895; Thu, 28 Jun 2018 18:41:53 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <davem@davemloft.net>, <michal.simek@xilinx.com>,
        <radhey.shyam.pandey@xilinx.com>, <joe@perches.com>,
        <andrew@lunn.ch>
CC:     <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 net-next 1/5] net: emaclite: Use __func__ instead of hardcoded name
Date:   Thu, 28 Jun 2018 18:41:46 +0530
Message-ID: <1530191510-10310-2-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1530191510-10310-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1530191510-10310-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(376002)(39860400002)(2980300002)(438002)(199004)(189003)(2906002)(316002)(47776003)(110136005)(16586007)(14444005)(81156014)(36756003)(42186006)(50226002)(52956003)(50466002)(54906003)(2201001)(356003)(8936002)(81166006)(8676002)(48376002)(106002)(305945005)(90966002)(486006)(36386004)(106466001)(76176011)(26005)(575784001)(186003)(63266004)(336012)(6666003)(51416003)(11346002)(5660300001)(426003)(446003)(476003)(2616005)(4326008)(6266002)(126002)(103686004)(478600001)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR02MB164;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT018;1:IkYVBiklk1pGMKjEX5ZN6Xl/FWWpB2+i8h5FP1/zIer2gYMiP/JsBf1+HRy04BK252Kg9unuSPqKqdv7OjTwtvbRer4kiVfansRSPUR54eXurLHrrJWQUqnNQjfkHoFU
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c0be348-d19e-4993-605d-08d5dcf8bd8d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(4608076)(2017052603328)(7153060);SRVR:BLUPR02MB164;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB164;3:5nxKgR2yC/qhmm7p40vcocANX7Xoi7TuwIlQwHT30L9OOv3ApQitvT6P/Y8ZGLK9mCWIPc65T8IiBttqdIMf8bgtShUuAJ5nvzNXJFmgyZ2qlaVWgoPO7gGXBbUqcCAsA9IKvudtgu30A/Hkuv/Oxrwe9URFyB77V4cuo0MDCQp2mYpahHDhi0j8YGJVlqzcoVoXF8SrFjxubKu9Z8drtZWpzQ2TOT8aoh/jlbrSDaHaqLkVxaNmAURv+u3ltaRJ/feiikgH7SVRxxds9rRv9V2/gGZfDV50hJiuwD5lvvi5sgiMylQIiQZca1RSCQ4C2DXbYl8FS8gTgvDU1q3opAklr1/bnI9N62dgjTQY+ww=;25:zJ+vYXhAilzn4eA04BNtBWjThpVD5CxdXDiYliwN1uuRrlEWpHEayL/Ur2P12+ZCiUd4+Eckoh/bZuw7X3BXzjHmx/kKk20vcbQpDO9P4Qmo0L1S+1+B/M4LUJngDCgyB/WZM3sOp3L9LhPG9eCfz3A91qPyuzBxSRGRk0DkhKbnw4BGqLW6pt9yaJvEUyaBjOWjMLdEOwnqBg/SERrsMTa7TlPE7WVAVKtkgPlIIKMKFij+q2Fauc+6UoeBi8lT6Ztv5t+LzkXml1mlOJZkyT3gP/PyuSG1cNbVXJ5aJz329Rz6njzrtUctpVNlqy7sCcyjg8/CbtjJhv3BP3SETg==
X-MS-TrafficTypeDiagnostic: BLUPR02MB164:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB164;31:B+kQlNFfia3fx0JngsSq1zw6TmCQDK4Mp7yDpIXFrYbK6EgSkQsz+hg1zwQdFwwnPAJrbwT1184fryNwyWbAkrezShdKy0nvB4vmhGCrjDWecpIuNkwv1i6fKYWU6Xb0IfeL0nolnOM3/FVZW/4Ui+kT8s503pKkj1MywF77IUucSKNt+YnsYOB0AkBSYQWVTaF2iEcoT+Kum1xWbv7ML8EyWTEprmr8gXabCQuVmS8=;20:6uFjRT9x6HdxF/7PAISH1Ri+ZlkYwAu21rhw+Hv6oA+uypryW8NwiqC7asiZ9HTd7WEcq8GUXWcIRrw9xV8VacvdcMm5GU0nLVZIesSQ1aS5sNP1hta+UT3rfOlaCesn/hUGo+M0/ACtqIXFOxobHBJQZdAf+q0y7yR+LOLzlQrSb3NNJrgml5A6lHKAB4aX0baQ3kmW43S0IdVw+g+W+2BIU0XgoWNgj0IpzlV5reVAurqSdfAvWamQl1MLIe1GeSKwuZJVwsS83/0IsspvtXEs6NHoLurODYq7/5g9PPLnyiWZAQplcCt4FH7xzj8sPxe36CWVbh2o9wxBkxyzev9inxiCkrrsR17Xr9RUgHs5C3hZRFILKWgvymz8vcc9LiBkBWD+xv/IXSfAt4fLKw/mE7qUPDdqI51yHDat+Z+DFyIjUk4BXA2cZfqs5v/oFX9HhsrtQ3OOv9KDPqUVTsz6ohTbxvgF+FJBZdR1yaUnGHcTVHc4m8V/Aw+beeae
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BLUPR02MB164619960EB46D015F2EA3EC74F0@BLUPR02MB164.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BLUPR02MB164;BCL:0;PCL:0;RULEID:;SRVR:BLUPR02MB164;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB164;4:sH5tShsK5MeZVFhOPMvWPXdT0B6pWxZsT8i8okzuTchYa7HWm0rNogTnKEZidG66jJga78xD/rhH1apoLnf/kTCrnC6hGtFQ79E+xFe3Pu7scgyMAxmDUwRdmB4MThKnxeXKUo3M5EKw8XJVuVCpAKVOl/nzPd1X1ooo1EjbyyRmZdZzRX6wjcW6Jposfz8Mc83RSrsOUC6raWYHAOk1gDQ4Cf3/ZKkTLed2/Fzrcg/6s8N+7eOJwi29uO2AeK1BzaP+eM9m4I5qwcD006HUPq5/FK5Va/uq8eYvllWlAQzAG3XkHCR+a8qeOL+kaTyJ
X-Forefront-PRVS: 0717E25089
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR02MB164;23:r2VaTZVs2n4Ar8SWhMxOjgU7oNKMsg7mtDSnDaa2S4?=
 =?us-ascii?Q?e8C6ORHxq2yIac9j4wKcIrdlcJzmSMxJ5QAEIyw6Nmjq19hfEreDvX9VrkJ3?=
 =?us-ascii?Q?QjVdKUl/2JwI2We5d5peQ8CmJ7eo+2fUM2zii3UfdmLobwXnC0vxti9pme+Y?=
 =?us-ascii?Q?HLUkgsL6XnFVUsNeN7ahKRmXslff5Xg7fM7//Kc18ahqYbTRae9L8Q0+fNuf?=
 =?us-ascii?Q?waTOb7e5PApGWlikGC3VnBDvYkhwDVJ87Sp9vPORmyM5qlcEopwGDqNJ0Qsi?=
 =?us-ascii?Q?wa0u06HTDjLrLWBbAW2JGj75QWY+/7V3EjImuAzFax4UxNGyCV09H0l5s60d?=
 =?us-ascii?Q?pSN+1QdkjbKgAyHADsCAFeI4Ena94WaGq702xxQcnG+C/fC4r0hyFhj9Z3t9?=
 =?us-ascii?Q?slf+7Ao0NXJS9XsbbT7mOL9VDyciE4qdSNVMA+5wJpsJYcCAnbqQEAmJmdCa?=
 =?us-ascii?Q?etOF0L78puacTae3m30RZbutMOzxcMbBjJ4vbHChdvDv9+CdmyDefCCrm7pI?=
 =?us-ascii?Q?n9Rb88n0phdP+pMIBZMpcyKxsEoPd8SP/zbcrYWw0qDC/bhGL08eo/or8RIE?=
 =?us-ascii?Q?TsTtFAx7adn0UhZTxjsT5l1q4T8sOWdZPFbp2YfUg+s2mvYAEb9w4kL9OrTa?=
 =?us-ascii?Q?CX8G5r4v6vLBRyh4TI71a/9UjUrp43GtrGYrzLZmnpzfjnooVJ9roa24r4sD?=
 =?us-ascii?Q?WXtHZZbCGzX4yQe7Z17etESvI56YBNvMPpYKTl7e/8FlwxGeTxaxYjE6opnk?=
 =?us-ascii?Q?4F5fVDyzC5BHjs9CLAZZpop8RxWpPhrxPcUammOFEFdJydE1Wv5NxrAizyb8?=
 =?us-ascii?Q?TWVTQE7daUHA0Imqne5dkbjMjZCXZ62kZtIVxV/dr7qnlsMlKYKngg1FIPVy?=
 =?us-ascii?Q?ZR/pOFZGfenJ0rHDotODV6aQAOChBTf4Xcs9ueDUQyPwFTPZ/bg/LUfFUL/Q?=
 =?us-ascii?Q?PWbXxmWJHMSumJ4jkhF+FvVHdgukOp/u/gTa/QrY02DyQ7XREpStLbXNNK/E?=
 =?us-ascii?Q?gtkqky/kI2WcSpHwNh8KKForiR+prIiDj5E8mG9OrYuLj0PQkavziStnkzSw?=
 =?us-ascii?Q?MeE2/zeHK1wy9MA9yaJQiWqW5z8/ZKKpEE01eWIFj0dbPgslvoLWia6cfyz9?=
 =?us-ascii?Q?g0/KfRG8sGlEv3/soK4iuCtEmIJ6vl19Zuuy25laI3EfwBqerDrC8NvNZOY+?=
 =?us-ascii?Q?bjXLBA8EcJJ1etJ1enV0K7HZodhjngVvEZdhigLIq3csGOqdTkxbgBLA=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: R+qwAs6hiAONXn8avkDDKTTa+cbPhSlcL9LD0C6SmmKCXodLJOZEnMcpwSvUcRPYoV8k/keKeWVlaThqQIESk3jI7x0eIHtDI0AKFnvZra81m2YK6cPPDE52YkLuTJLUOMRCb5dxYnRGeVkJ6KNOGFj5SL94r1Su9S3ir56Vz9DR0YOp2vSy2ivbSEMcdayHzBhibJeFbi8E++WuVwVTLw1DB53s4Ymov1WGcjpR170hxC8DFbS5rrCB2fDR7C0DG20BjrrKcVlnFvjBvuEiHuMkobpLS4M/kNr244y5ZfqpGTMUjRCLEwvQp9xndNY5WsDCw41aX/N81OPtBGkRm2aWfx0AsBWJ9ZdKzd6RxW0=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB164;6:OQrYIhDyjMhStNphFB+VVMZtlZi7SmCVAXZwr96mZke0CmeGjmw/bWFOaw3cX5ubGXgrbAb5B8jAnfdH4tMLcVuNO1UluoqMp4LXht5aLzAK6DoPxPFc1za4kQirGv0U6RfIE/eB+1R2ya1PcdEwJZWRICXEWcVhiOq1/A2WqkvTMRRSdoVl4i9R4aVg/y36tMV6s2NnkCcvt64Glp0C//nHXyCNunr8Dwu0Ophuf32gIwdVrIFU65uExgdN5QGIQfOHZGqh8JJLZuMem0QWPRhT7R/X7Qcc7Fh7UkUFluUNZIl3DWxzNMJvq0VDeKMJPiL/1L2fblBJLA0pwteOiBSGgxBxPebi8xzkvHa+WoT3mKZZSZIn2N57qwLkTXOGEqGXrM7g2S2aJ/keOriBrX9X+x8QWspVYC5qQklVQJdVy2rgKr1gNuXWT02C2E8EfR/NMvpMCrYpAd9jCEDVSg==;5:xF72W/QPwDExYexHm2FexBe6U7m+GxlOH1ozNON6ViH3QjdCbLIztJlcctwPWo+Twdo8qH51qlSqQhfMlFRAdYU1+eRQ3jzO0TXxGEVJVVEkZtrui+iGl1laYlbwcJN24qs7U7wjKCqMcljYkogOqSi9zEAgaZaNApTWKQj5QGo=;24:7b+lzpv7F3nMl8Vzus3UDalN6BsGo78Map+ycew7h/BzFKAbcAxOtAzbXbeD0ePbAFVBqvNmnmE+6PHkK/jJYfyI7+ZAcunjT42TnP90iAw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB164;7:a3JuHZdjaHgmA1j+zIt7ULaWpQ4skOpXWR0tv3GHr7VwCWfd/VF39U7RFmeTZu0qSAFk2KBRpaPxOwE0yfJ0beOe8Swa5NRlf/Qv6OdOBPTkTjfUsLUnNG9ZnmCkD4yEDeU2nEJIpcOKI5w5fjfFiiaeF/NscqbKM+bkzOPcYy9sa9jsmakBA+Ndc5f9NHkV+ZRGIRF3o+vxUawik0vZSAGS79aNHA3nhKMT8hWlE2+nW7vzTxC+pnOCHvUUmvbm
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2018 13:12:02.8733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c0be348-d19e-4993-605d-08d5dcf8bd8d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR02MB164
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch hardcoded function name with a reference to __func__ making
the code more maintainable. Address below checkpatch warning:

WARNING: Prefer using '"%s...", __func__' to using 'xemaclite_mdio_read',
this function's name, in a string
+               "xemaclite_mdio_read(phy_id=%i, reg=%x) == %x\n",

WARNING: Prefer using '"%s...", __func__' to using 'xemaclite_mdio_write',
this function's name, in a string
+               "xemaclite_mdio_write(phy_id=%i, reg=%x, val=%x)\n",

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
Changes from v2:
	- None
---
 drivers/net/ethernet/xilinx/xilinx_emaclite.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
index 2a0c06e..0544134 100644
--- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
+++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
@@ -757,7 +757,7 @@ static int xemaclite_mdio_read(struct mii_bus *bus, int phy_id, int reg)
 	rc = xemaclite_readl(lp->base_addr + XEL_MDIORD_OFFSET);
 
 	dev_dbg(&lp->ndev->dev,
-		"xemaclite_mdio_read(phy_id=%i, reg=%x) == %x\n",
+		"%s(phy_id=%i, reg=%x) == %x\n", __func__,
 		phy_id, reg, rc);
 
 	return rc;
@@ -780,7 +780,7 @@ static int xemaclite_mdio_write(struct mii_bus *bus, int phy_id, int reg,
 	u32 ctrl_reg;
 
 	dev_dbg(&lp->ndev->dev,
-		"xemaclite_mdio_write(phy_id=%i, reg=%x, val=%x)\n",
+		"%s(phy_id=%i, reg=%x, val=%x)\n", __func__,
 		phy_id, reg, val);
 
 	if (xemaclite_mdio_wait(lp))
-- 
1.7.1

