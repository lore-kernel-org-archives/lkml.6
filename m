Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944D8C6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20D1F2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="a3YkJIO7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20D1F2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbeILV2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 17:28:23 -0400
Received: from mail-eopbgr700040.outbound.protection.outlook.com ([40.107.70.40]:54880
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726866AbeILV2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 17:28:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6gDEfdj74ATLlqbfMVeQnSs8nZxWxUwN53m0A31/To=;
 b=a3YkJIO7Iw5OpojlcQ8p4ISLITb8HRQ2edi3hVg6fZTR2cKAztP8XzEdruv11Vu4reMiHRNVi+tADruuNO4lL8tjAGcX6OEScVoxB9QNOUoIkWZic2pN/SUf4gDRPs80eOyQtWvZva2WshyCWxeAx5/zjSCcIE0S9zcWx9z1Cos=
Received: from BL0PR02CA0073.namprd02.prod.outlook.com (2603:10b6:208:51::14)
 by DM6PR02MB4476.namprd02.prod.outlook.com (2603:10b6:5:20::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.15; Wed, 12 Sep
 2018 16:22:59 +0000
Received: from CY1NAM02FT041.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::208) by BL0PR02CA0073.outlook.office365.com
 (2603:10b6:208:51::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1143.15 via Frontend
 Transport; Wed, 12 Sep 2018 16:22:59 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT041.mail.protection.outlook.com (10.152.74.156) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1122.15
 via Frontend Transport; Wed, 12 Sep 2018 16:22:58 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:54900 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1g07ur-00062u-IZ; Wed, 12 Sep 2018 09:22:57 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1g07um-0002PT-ES; Wed, 12 Sep 2018 09:22:52 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8CGMmjU006929;
        Wed, 12 Sep 2018 09:22:48 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1g07ui-0002OE-80; Wed, 12 Sep 2018 09:22:48 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 6760060508; Wed, 12 Sep 2018 21:52:47 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <vivek.gautam@codeaurora.org>,
        <kishon@ti.com>
CC:     <v.anuragkumar@gmail.com>, <APANDEY@xilinx.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH v4 0/2] phy: zynqmp: Add phy driver for xilinx zynqmp phy core
Date:   Wed, 12 Sep 2018 21:52:44 +0530
Message-ID: <1536769366-31398-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(376002)(346002)(2980300002)(438002)(189003)(199004)(36756003)(478600001)(63266004)(26005)(2906002)(106466001)(47776003)(186003)(356003)(36386004)(305945005)(107886003)(6266002)(39060400002)(50466002)(4326008)(48376002)(103686004)(336012)(42186006)(50226002)(426003)(6666003)(2201001)(316002)(81156014)(81166006)(106002)(110136005)(8936002)(54906003)(52956003)(8676002)(486006)(90966002)(51416003)(476003)(2616005)(126002)(16586007)(5660300001)(107986001)(5001870100001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4476;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT041;1:fVbYjqw9f34WMVnlFL73HiA1cKAYhcCtBE3nnOdSp3BTac/OOnZPkKBBLg0FDUE6Bi26F02RIvlH/wkmJEBugpG37XM8ngIeF50uF0cDIK25k2Lc8P1FzKlE/xU+G6Wb
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e8ee155-89f6-464d-e6de-08d618cc00e9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM6PR02MB4476;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4476;3:02FNLUAStw2AymsLYVFJMlyxHHavOJXjHaAbQfJNkN75ZCBLXApAL0eb+Jy3T7Q/+mpmJmSuylexxVlDc4whHm0WF53Ian6GyREpTmHxLX8y6ncD90i9S8Dv0QOaUQ7mwPKntqVNNH17OgiE9LV37i7xJc0liXLJq2qVmZQ5WyywAh0EBJFacc+rgISyXIcgBAiqxdeQo2hatIXcnoqYr2g+QQD+ZBCO6SBm3zkASTwr5q+HMTOqord5obxLstdX/axnwtgPXrtCzQxTxSSURNvSkbqFzlmZl17YbWMUo3db5Gp60xNhXIZIwwrcHx+mQqwW8j/Zgp15wE2cD3a+BPCohlW0vT2ebBOZGv47tLY=;25:qUoh6gHU9MEMtqM8zftDF2JXHJG+sU7gTwT5j6ByT+dnKZM4/w1rXsTbSGJjSvKqr7xCXtEbk1ZaVa7bYXBVgvmP0rHWphntfZvMwcybEg5Bq6vzsPxLaO0nRTeDmgoZr/1i4+dEFJ/jKK0Qi3OlBkPNarMruzU7gOSrFAqjengfPh5Tsyli2gMzLTcpqK3eFdj5ZPlG9rPos2noRr6hZ/k4rgVfQx8jJW0p2uvww6BMkalGWsaOrgQ5isMWmr3D+JIAf5MZPhx8ZhLd+NZuUwBFvRi9cbIC2Pi1Bm0ATV44H6hXNaRl2K/Fdvv00MN5Za+3NlQNG0OsWJ9l2yBnSw==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4476:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4476;31:dr9Rl3xSkjbfE2r9oVl8hQsAThJfpak5y/++so/VJl4Er8j3tVF4xazcgzeBuKuL2HgXpuZjApFZfWiCuIIhWBCB7Vi3cW5j5k64P9tH/HpAHKmHv3p00zl0BB+JNmXXZmQBDFH0R7exFLy70sFjONb0UPQc78uh+033ckcUCs8ZktbUPVLtG1eM860GBYLreO7JMVvPipfl/PIqe/as2ZxKgF5164nQxioa6ZOv0aw=;20:cv86eLxfZgtWRkbqp3qgosEkEREQSxojHoBwIkmQ8+Ls6yOFiD9zmiNOXqed2SgG5ZjIZeoDCISVSAxHCzdnEFm256i3YUxkYmoxD8PZUIDBPPOneLUpg4aKAYRsZ7sJGOB/m2RnD+BjetWoYxs83B9GlsQZiQmq6go8JGr75HASn7WDHVeRCWPEqCkRO4ed0OZYiKd9ef9D6BvrV5KiA4bPx6U649N/tnZfNEaXXJtR8M1B9CS76QkOdYUE8wPNnckEVrgQlugAWzzu0msaml1YjxKI9f4R0Ej/RLlMQOmMuBhTr+o+Wn1H5MaAoGqq3bc4hKO/jWOjBYcFj7KLUkSwwzyr+0LrCLAQSnP8nZ+B8I7Q4ihoCWFYkGK+vC/0q0/r2+cw3l6G2ksntbeOD4J1LD4ugF+kGmbQKlScYWBGCgh1aUaeWUC5fTRilVHOXByNHom2Ulrt/6UESVZAH9rQVoh0YpKOa7KdQ7Rw9I++JUuILI+UDZxFMtNCfC7/
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB447635EFF85EFF9E4CF36101A71B0@DM6PR02MB4476.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:DM6PR02MB4476;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4476;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4476;4:7Tr5g3SFqvVJOTM9cLLyznB7IlagI/3BNsRiCWrskFN/geh7g0Vt7fRSEpme8zRiprAI7gVCsPKJaXF/+/UbJ6h/55eq0gLhVk9eBbgSuM4cNZjivbRsSVGJjW8KPVhVxVDducf9fEQWHs0p1+/1jHaNNiNOXjMe3mQVqh8lsMwBmMAh/01xpD3CNKe3/H3aWW90yXggdkRIBlJ6eBJYUcKmnFcxd4NnIWVEcpqwzBsLgq53/QAaxrMh6L1E5ydauAjhD/vZj6cUQ9aqk2GjQw==
X-Forefront-PRVS: 07935ACF08
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4476;23:cb6YwwiH8vHeI0qPAWx2rI47LpGn+TTEpTI53JGA2?=
 =?us-ascii?Q?N3ZY390QutL3c+fg8Oc+8Fx9IaEDFLJ6s0DCFAyNUYdCi8Pa5T4I/RzhGyqD?=
 =?us-ascii?Q?79MR3odTzHHkdyr9fWIqEadDa3uk1KXKR6nFzLxaOK8AooPPPdjryK+A+hYR?=
 =?us-ascii?Q?CgX4eSKe00R0CzvB4AVQXZm0+79gxU0izZPR9wq9qYTDonTNHHopYtGkOj3L?=
 =?us-ascii?Q?U1uhbfqYOJl2HZkP79upNXe624QelyhYlhTKKo47//NTewU9BhhcA2NBxD8a?=
 =?us-ascii?Q?swfqdM4JnEmGcnxIC347IVzOC2XpAddY3gfpgJ5sKk9e/V9liu4OKCTB4etP?=
 =?us-ascii?Q?OWu1bIGj99My0wofbHCnaYLPx1HxEu7yHoyl6dCNgmwG7GJuMlDxGFQssnfz?=
 =?us-ascii?Q?yu8QbajOLTaSpiaokrDppqj7ARqfQ1LGtGTVJUBcuITYHBtlmvjIu5MdHv8l?=
 =?us-ascii?Q?Rf55hvzEdDl6vzEF9gXRERxWG23M44/0q6tnDcXqgkMp3gcMgsMdnlN0u609?=
 =?us-ascii?Q?aQ323POu6OEdoAlUbTj57zszDdg19JXc3pjos5iQj7WNEHsPdb0rbihlGAn1?=
 =?us-ascii?Q?KA5yncEca55o0k72tGVl9QL0ntHVoMNyesA9nPY+UQwuvHm2pfiH68tyk78r?=
 =?us-ascii?Q?3+ker7dgUJDlstYJ2DzFBEpiEdfZjkC4ePQJ9jPg+m5dtTqmrcH474h4oXpQ?=
 =?us-ascii?Q?QpqwtcjJr4s7PGSwoeRUmOZgjHI1e1s+OtvBAnVZNzDDi6Ka99L9oFReIdvh?=
 =?us-ascii?Q?BinFRMVg9U/VUjtG+h1FrZBdk6Pnc8ttKDlNTSPOgcSI9KQsyjgabMDUyVX7?=
 =?us-ascii?Q?bhnHGoef1IEsJ9hD4q7dR4IFC2ZoPeIxsuwwv8nRgALEuHQwCRbTlQSaPPBI?=
 =?us-ascii?Q?IeNErqfjhRQL5mnSXlKBcch9XI0JKAuJQ+jYRtll7thzR7921NnE5A9UnxQZ?=
 =?us-ascii?Q?X5k7en8ZyCQVnxZAps3P3uViT2qFkFAWGzpLCqD5LSHMeoA14OpA1GrxMz9u?=
 =?us-ascii?Q?j+Cd8TUlSHpJScJwweB686YrRapZTIKh/mZhL0VFKdzZocSoQumJKbcmr0rr?=
 =?us-ascii?Q?xUL5ZExpzckOfEVkmzKQKqO+nNkHFNv11913CP0bxkRtvqaAMe8nWuulQiiZ?=
 =?us-ascii?Q?44iBV7YVE2hJsVgwpyjU4rJQjJOczFNp+kK+3z86qPfcPdcGy+DmvShJePxA?=
 =?us-ascii?Q?5w2e9fzhUVhfvE=3D?=
X-Microsoft-Antispam-Message-Info: IdAqivfW4wr+bbQ/EcGYQ3h8+tWud2GrDy0oKX2FL/jrWy71S+6O1qhQW4cBmZmCjY80XSGCThLLIsWNbAJXaI+95x3iTWduPfZSfRswoNinAKZn1qG/4IjkG7OR30uti4yah4w3QC75fBIMkyJyCK49IKstIs3XJugnjiiUJOiEI4OiUuM+Rn+0TFB/nsvsiNirEE33U45GV/mz3GQ7B+wTt3r7RdbOsrOrnYOyDwch3BAbCi09K8CL5OiUBbjz1qe09cTgRA50QODkOeycfPtGEIC9WMKew+ghVB1FWgCVaht8QwaGkwD4Jzjton4l0lGIx0hdSwIARwlODJJ0HCMLkj3kL+4mtKdXpE1krpA=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4476;6:l8AVG/0cNZp0Q7p58b8mElAYjEA34Z78hAoNsNo/cvm1rj+rgiGUJvZFFRGXvrLKMqPPSMHbo/oviQCds5eeO3KMeqb4uYAIEWObIE4aj/azLGigvJl6ESgEyqzjp8yvBdrOzDi/hI7xRA1buRz8+LXLuKa/WZeEjNstkbVwrtT2aLaO1H8bdv18Hg3/MYqWkYvPClZ6ipyeAaB8wshOvWZ7z8fTmF0ruFGrMJjRg2NvqWKREG1e8WAZUgn/IogBJJ+nOy+G+n3JtDCnvRTkL5t2U9cMrPOb5V9yNa3HIiXSwVm58fL1AuZHhHpEGe1ZOqVNWXc+5s6lpGTKqMm1jNKiNrRIdamn8hscaX0VOhvQD4Nl1Z+b5+g0WkfvCe5Ybgb73j7zEfa+pEg/r7JIGT+M3W4OJTvUR7yQirz4Y7QDvbi76gVqKU5fOy8sLH6Vo0QPq90RDwXdY4QnZ7Vl5w==;5:LRi6EVfdK9FDtiVlbEhlLPY/WjEILyyIo7dugKkt4uQSNKnk6qa/8MA44gOwJtIeHg/ZmcuAhJnDc82oZygEpuiVFBtD9wHDztQv0Wu3Rw5wWzWYCT24Uf6lf39pqEyxINV08L5X+TwNTUo2sWJHF3feMinXw/qxU1jZORrl/zk=;7:AB93PC/0vaSkwttwCRqoaZeT8RzBVspHo9OLCKSjWY+QEe0Yn8s+W2C0p5dUKeA0NIXmw1J1a7QIjFer9fwS2r3F7ztDJ9852qFT6taw+KvSAsWlgYql/Dc7v5s/XMt3MuAzVaHXQOSk43H1N7V2oQYQG3xBocC1TgwDTp6RhPPc9ng+m+QGySNrzcP/6pQ6ej8HLXE0RX/+vEY9rPzfrSgAuZYP7mp4XEoQ7vPDTQDiEZV1hZ3doO5UtWOnSsKI
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2018 16:22:58.2540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e8ee155-89f6-464d-e6de-08d618cc00e9
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4476
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ZynqMP serial input output unit (SIOU) is a high-speed serial interface block
that acts as a phy interface for the PCIe, USB 3.0, DisplayPort, SATA, and
Ethernet controllers. These controllers use any one among the available four
multigigabit transceivers for high-speed communication with their link partners
outside the SOC

ZynqMP SIOU supports multiple protocols working at different reference clock
frequencies to operate simultaneously. Each of the four lanes will be having
a dedicated PLL associated which generates the desired frequency required by
the protocol configured based on the reference clock input given. Using this
driver, user can select the desired reference clock frequency for each of
lane 0, lane 1, lane 2, and lane 3 respectively. Each lane can be programmed
to have its own reference clock or can share reference clock from its
neighboring lane, this is called as "Clock Sharing". This driver supports
clock sharing aswell.

These set of patches add support SIOU support by adding zynqmp-phy driver to
linux.

Changes in v4:
	1. Fixed the changes in phy-zynqmp.txt as suggested by "Rob Herring"
	2. Moved the dt-bindings patch from 2nd to 1st

Changes in v3:
	1. Corrected the Documentation as suggested by "Vivek Gautam"

Changes in v2:
	1. Fixed the compilation error when compiled phy-zynqmp.c as a module
	2. Added CONFIG_PM macro in phy-zynqmp.c driver

Anurag Kumar Vulisha (2):
  phy: zynqmp: Add dt bindings for ZynqMP phy
  phy: zynqmp: Add phy driver for xilinx zynqmp phy core

 .../devicetree/bindings/phy/phy-zynqmp.txt         |  109 ++
 drivers/phy/Kconfig                                |    8 +
 drivers/phy/Makefile                               |    1 +
 drivers/phy/phy-zynqmp.c                           | 1581 ++++++++++++++++++++
 include/dt-bindings/phy/phy.h                      |    2 +
 include/linux/phy/phy-zynqmp.h                     |   52 +
 6 files changed, 1753 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-zynqmp.txt
 create mode 100644 drivers/phy/phy-zynqmp.c
 create mode 100644 include/linux/phy/phy-zynqmp.h

-- 
2.1.1

