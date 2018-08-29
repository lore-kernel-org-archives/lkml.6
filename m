Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8631C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 514F72083D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="OEf8EyGH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 514F72083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbeH2SE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 14:04:56 -0400
Received: from mail-by2nam03on0057.outbound.protection.outlook.com ([104.47.42.57]:63682
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727316AbeH2SE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 14:04:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0oGs8ffcBM5Pph3gfoNBPguFyZrHohNZG/evu9OIIz4=;
 b=OEf8EyGHH3JPJTka7VzeZ+4Lnc+Xa81Gd05HjUyN7QyoXTq3rJruTF7xvLpYnchW59H4tOPh39N5U7ECErRsq0Y2ouN5ZhC4Nw36Y2Tw15NRbG5sMqqGr0mHXu9ktYqvew6xm5dMRtr3b0BOhZFbwJh0c5aGOSL+dDUzzY3M7Q8=
Received: from BYAPR02CA0002.namprd02.prod.outlook.com (2603:10b6:a02:ee::15)
 by DM6PR02MB4939.namprd02.prod.outlook.com (2603:10b6:5:11::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.17; Wed, 29 Aug
 2018 14:07:46 +0000
Received: from SN1NAM02FT064.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by BYAPR02CA0002.outlook.office365.com
 (2603:10b6:a02:ee::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1080.17 via Frontend
 Transport; Wed, 29 Aug 2018 14:07:46 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT064.mail.protection.outlook.com (10.152.72.143) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1101.10
 via Frontend Transport; Wed, 29 Aug 2018 14:07:45 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fv18L-0005rz-1n; Wed, 29 Aug 2018 07:07:45 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fv18F-0002hl-UO; Wed, 29 Aug 2018 07:07:39 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w7TE7UmT009406;
        Wed, 29 Aug 2018 07:07:30 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1fv186-0002h7-5B; Wed, 29 Aug 2018 07:07:30 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 52E97604FC; Wed, 29 Aug 2018 19:37:29 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <kishon@ti.com>, <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <vivek.gautam@codeaurora.org>
CC:     <v.anuragkumar@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH 2/2] phy: zynqmp: Add dt bindings for ZynqMP phy
Date:   Wed, 29 Aug 2018 19:37:28 +0530
Message-ID: <1535551648-29534-3-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1535551648-29534-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1535551648-29534-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(396003)(136003)(2980300002)(438002)(189003)(199004)(90966002)(106466001)(63266004)(8936002)(6266002)(36756003)(103686004)(50226002)(2906002)(4326008)(478600001)(106002)(39060400002)(107886003)(16586007)(48376002)(316002)(305945005)(476003)(50466002)(186003)(54906003)(42186006)(110136005)(81156014)(8676002)(81166006)(51416003)(336012)(356003)(126002)(76176011)(26005)(11346002)(575784001)(486006)(36386004)(426003)(5660300001)(52956003)(446003)(14444005)(2616005)(47776003)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4939;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT064;1:WfPI4xZkxOleUNzauO2aeBBnJf8ugXH1m3zFQprmrnblfW511qtLqJ0qZd6SvS3whR6bePjXgnN/ciUv20VKwzSKEaW/GseGKB/ZkjQVhiLODzLOEta1TP0A6nalzCSs
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6db49073-75b0-4171-b0d5-08d60db8cb6f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:DM6PR02MB4939;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4939;3:nSjdbnVyhJmHaVf38bv5yoxYjW7rNeURhe17BJlwBsNHmaGUonq9ygpRKmQoN6n19kDfocVKsTx7lyKspw09zrEM/+rmEWyQHu+EDkUU1LS6tmLra8Uiu1ivfp0+3dYU+yl45nnArz3whPeoTYqo5bRW3yxb/GFJw9lf1Wu+FIX6FGX5h30YxgypA2tsK5unYGGXSxL7MHOl+MgJNOYSB3ICTjlEXlQlfLF4TgbvV8oDHNaNeH3zxQonCZjM0r9aLe2ASDRfyixYPB3avgxRuVmLviGOfo3ET4S7WalvjPLC2R+w1douk3G5vSNQS9DDhnqxMX/QbarrXnG7LvziAXI+MlpB7wfobTFSJafuOeY=;25:5kFtUpWI1Ff+L93aGbd5felxdZtCivQ5wPfp1fXz1+MlJa0pPsZ6UVUTUrBvqYkQNtnCjNGOPWX/MKHZp55w3yp2fjv9QQeHbztThMsySCcARJGSaPwOXmLtjjpGWlZYik4RJCA2S6XV7Skl3Vbuu7gx586GKyyRk5D5gLsoIpPDncSGJfY6KRcSMM2a+agFLpiDzTTKGy5NEBXeGWtrYPosKgTE3WB3egHEhBDYodVFXHyMdYtURZ4ndZ3kSmwo0yqfbwPOK7v+F/O3W1lzVEEhcCf1T/MsDqi7TMynmkMXomPNgbVc8G/W0IYK6RVscItaRxS5CxoF6xnfGiCGJQ==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4939:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4939;31:2JCJjL0qBGoAhB75uJ/26JcIp7rYimCQCNXp116foGxSQ0U+z5su0u5+ZXfie9fr/upsfZIbxUidzohF+qWsODDzSzdit2VvAxvnQQH6lwIz5YTglRsrpA06N0TSOOnmvtJZ0iYZz2sTA/oPpXcVX8udy+WovXpTEF5Xb2E9ylNG5zJ3dDWtdlTjCCUIebUgNprwHpMI2V6yXI+iqqM2RhVyHnnolcOS/iTFKVqWMCk=;20:oFavELIp5Eojps8cBMa1AraulcTSa9TifsQQOO4YaEdJ5vRAiWuY6tWzED41edF4xHIU6oLd6wETPb85wX7Z9B+o9KzVZQ7BzeJ7JkFnkzTTv8Kzdjl6f6+SC2tWz/2c7KigAp7WqfyJpj6Ip8PRq0wnEaynB0iSyMbV4Sdo3pElPemHrW0Ce/8Tjq2AVqaeEswvlCRraotZlcrWTzrrfE8fUr7a40+gS8es4JAS5fClCdZbo0Z5J2lkhntt1xlR7VgC9IZePREV2iJd9Gb62Hbh2XVTgvhhBzjienGgaHOJRLP40N1FDIFWRtC0HO6/sji5QIGWNbsvrsX6DagQNtvRyhYjzof660HT4IxqrggVQ/gvU/CR84+pEgwl3AIjCcu94IiUZtUXv1sZc+gyaZvoYimBnKvt2ZqEMChJseVksBsr/bX8/06rQM+RplTjlnZZYllrYVXS71Sr0PtgP4bIeM+yHzzwtZdVsND7lqq7e452sjSMyZbNBgVK6CVd
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB4939122F2876F9CBCCBCD15BA7090@DM6PR02MB4939.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(10201501046)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699016);SRVR:DM6PR02MB4939;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4939;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4939;4:+cARxUxpjBpEdo7MiN91zaTH5JEap3sruapw5bCgxRt1w24U6PMm7NpPuBRZU/NY9JKmAlJpoA9DMIsA8eHTCjM+JgKUTolj0rMFiSpQBnMmCoCiG8gQPVGy9H0Os5dHTjD+fjA7zZw2rnsKuUDBbE78KNgu6N5g0MVqE04yOfDP0n77x28pGCDZk+licj6nz8vnmyCvyv6dNq60XW4bO7uNTLXjnGl2Pg5rHXnR1h6DxRirdprrjsqbX0UuP6OXeqa3G4X9XJofKBrehL8uoE4ubBmghz+61IH9hiunrbMvUnfJwEaUfnSnl8pRrcd6
X-Forefront-PRVS: 077929D941
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4939;23:Z/a8jWVIw9RPR9rTfZLQpC+ZI7mtyVqyYb1iKugIv?=
 =?us-ascii?Q?ULT1mAQFH/eSPvQM/LmHNaU5vzi1s1LELrg0xPuac90/vLalsPvj8jV706yZ?=
 =?us-ascii?Q?X3hLDFPfZFsXJ90duR31yEy2A8M0psN0GxpBFzC0n084uBy3kK35O10l8Cjw?=
 =?us-ascii?Q?MeU/ftxqXuECOEkT7FVvEwBZtwKpSIcJ6GJgziuUkAkw6WWXcmnJBACNgXwD?=
 =?us-ascii?Q?yML//bnMNXCwvimk5vIeZOStX9+sbO/Lwi2E58S9mUqjWJfS/K3zkkWvVLaO?=
 =?us-ascii?Q?wndamPLM4+JcTAyDqoFlBBYBq8qtwXcrsG8/QY3REHcF/zTG8xnuIMhx47g2?=
 =?us-ascii?Q?WZlNBnpmm3GHbLCM5ZGpOOmE7s/e4V0u3MioWprc6OsnvpF2NZ/RK0u29b2g?=
 =?us-ascii?Q?VDnPxKYX7sTLKo+PlCrVRf6x6coLxipnFWvPw8E7M+DEY5erxJ0nl+1Kaf6x?=
 =?us-ascii?Q?cnu8CiL3qOw8BeBdT3xtoGd4q8TbNrHrMzWh5stanp9IGNy7rnJg2WuoPx90?=
 =?us-ascii?Q?TTwiupcZr1qPcQduh+Lj3il704UWhLDYPQfDoM3R5gUH4a1wkiKTjiM5gzST?=
 =?us-ascii?Q?2NxT0r3Pygm1Ewile2pYJYBBV3LvlfxmpuR/49aGa9HytWwSGRGhT9dpXyVK?=
 =?us-ascii?Q?9qpsZnvUvSv16QfLc8K34S3rQMSNeGSHJOILbixDHonSH68frQD6GJmBHw1U?=
 =?us-ascii?Q?FvI4S1RzgrbMIvATKguvTznmw0KfItDHJtEjX+zIPCa6/1b1X6nAu2UHj9GP?=
 =?us-ascii?Q?k3fJ7ocAH5yS5TO4iV7GOPFRczePWeLgDTNz/B8JuHJTxp41lH0+d1WqVtFF?=
 =?us-ascii?Q?ChX5iuMnFB+aWGgpbJSgKOI5wLKd10WPCwz34bK6sICvcRWincO3/3MZvCn7?=
 =?us-ascii?Q?nGXZQ9HcmCJa/4ZWHqSPIip0B2TJsl//8u+gqnjDZlDD3DjKxs7mYkhPJPus?=
 =?us-ascii?Q?DS+9VGEzdR2ywe5ti5EcW53QDNWpjmxTHL5YG42ph0cw3rQCB53FRw/YZgXs?=
 =?us-ascii?Q?W+kUUxprLzBAPLN3ot8qc/A0dJ01Rsw4RVNyJP+tlG4oHrobcue5Jsx24I8w?=
 =?us-ascii?Q?TVIOf/S4Pp2m18DDQXkc2Q/cpRD6ZNBz0J6r5jov+38hNpudRcpHfJ/ZYEty?=
 =?us-ascii?Q?bf6KW7JrP4AkK85qA18U1etxJFbxJI5XQNpTYrGiYqe3D9oQYHFzZc0Kq5EW?=
 =?us-ascii?Q?DrR//Xh7717LWxg+RnsPRk1P2m9Vc+uh5AW?=
X-Microsoft-Antispam-Message-Info: 1CWqIffNn47u0BZrZy0EcwvTVOTHofCAUgJFx612LNMi1SlIOlysKEgVSsmy58o/yz7WtCirBW9hP3kyY4ZLiIK3hMmAGCM61UIwoTW1CYm6iLSvFicRBLFnOp4nJ7vA8ZL5oEcYwQAOWkCfwl3moM0b7IJ87OEx4KIIpaBpd/5bA4OPULFdHpI8fx3y6i6fSVCrBE+c2YTE4f6sQjZj+YdVlEDcbZ3NF5+D8bdEjimq5N2bkufdOMgZUpy6NlKmmXqndGNISQflHBwznEzcIPHZT4SKTZIAh9JYhWiTi8sL8ZeFutUEQGdA2ds6miusAN2DwZre37wlM48BWcqA66YFMoU41NcN3BK9k4HJJcM=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4939;6:EDEQvimnAeKzzrzLqT5L35DcmSA84pv1dy23MRZ6a2Vtw6/XssPC0UcQSRB0obTRnAfTGUVQ3kpCn6xMDv30a++odRqHo8VliKG8xoYsVPYskBoh1ZaGla4lYp5PaquO/SO4sRc/QlNQk+sJemdB47KRNfAO1wxuv4hWNpc6Qc53K4zMVPJyU3f1Vd7ftscoHg80+x5o5pf7pnDdtYIFyMM4MUbQ7e3632fJjZjBpqs4c3Hwyk8A+oYyX5aRyeYi+Q/25yh8zBBcchTiXcmHPGGjp0ONB+QtLpKjSkWOmmZIwQ5lk7FwyVhKHhYqX3PhTftQ6nkKdGie4Lpv+4xidVQ1IZzJLe0vmhu/A8HGT6uMN+Xl3zRfBMlm2oxKtKe8C6q3sySdPqM/LY//Jh/MCY0A8dnaDaznHa3KX//qAIFb2XLW4kqEHVt7TIJldr9gOnEfa5UPXRH38/Xod+/2pA==;5:ykUjg73Frm+aArvfolnouEt+bkGdotIbBw2/S7vLJMz9MSD/96yMsqKzIhs7BHtwjWf3eFzherefvHJhTCbVDHSZrHE2b6eooQDBC4/zMSaKb8iIL0aDAJSR59Sw/LYHxMYHPb68AByH4/BlZLzNzKSl8PGuxWzrwSprl7LD1lU=;7:C4hbUJbVE0dyX6O8pVwhnu0aNQBC2Lx0Tj1say+NMJHeQu2FX3iLsWd3kTzSuYHcWfs0ay8wo+il/AMSsxsmrsRDgbdL3Pok8nkvMt9JyggakiRHdD0sV/evy92lfOdux981w2xcHYG4ayJA9sDwA/KFFxRlIhGueFssVssqLgzGwTBKkfKKGiDXZvfD4axvxzUBhzHrVwdYT8D7eG42FJt8Przwk78jH+i8+GjIBQNixzpJOwajTgCKaicvynqn
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2018 14:07:45.4148
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6db49073-75b0-4171-b0d5-08d60db8cb6f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4939
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the document describing dt bindings for ZynqMP
phy. ZynqMP SOC has a High Speed Processing System Gigabit
Transceiver which provides PHY capabilties to USB, SATA,
PCIE, Display Port and Ehernet SGMII controllers.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
---
 .../devicetree/bindings/phy/phy-zynqmp.txt         | 104 +++++++++++++++++++++
 1 file changed, 104 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-zynqmp.txt

diff --git a/Documentation/devicetree/bindings/phy/phy-zynqmp.txt b/Documentation/devicetree/bindings/phy/phy-zynqmp.txt
new file mode 100644
index 0000000..2eed553
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-zynqmp.txt
@@ -0,0 +1,104 @@
+Xilinx ZynqMP PHY binding
+
+This binding describes a ZynqMP PHY device that is used to control ZynqMP
+High Speed Gigabit Transceiver(GT). ZynqMP PS GTR provides four lanes
+and are used by USB, SATA, PCIE, Display port and Ethernet SGMMI controllers.
+
+Phy provider node
+=================
+
+Required properties:
+- compatible	: Can be "xlnx,zynqmp-psgtr-v1.1" or "xlnx,zynqmp-psgtr"
+		  "xlnx,zynqmp-psgtr-v1.1" has "xlnx,tx_termination_fix" removed
+
+- reg           : Address and length of register sets for each device in
+                  "reg-names"
+
+- reg-names     : The names of the register addresses corresponding to the
+		  registers filled in "reg":
+			- serdes: SERDES block register set
+			- siou: SIOU block register set
+
+Optional properties:
+- xlnx,tx_termination_fix : Include this for fixing functional issue with the
+		  TX termination resistance in GT, which can be out of spec for
+		  the XCZU9EG silicon version.
+
+Required nodes	:  A sub-node is required for each lane the controller
+		   provides.
+
+Phy sub-nodes
+=============
+
+Required properties:
+lane0:
+- #phy-cells	: Should be 4
+
+lane1:
+- #phy-cells	: Should be 4
+
+lane2:
+- #phy-cells	: Should be 4
+
+lane3:
+- #phy-cells	: Should be 4
+
+Example:
+	serdes: zynqmp_phy@fd400000 {
+		compatible = "xlnx,zynqmp-psgtr-v1.1";
+		status = "okay";
+		reg = <0x0 0xfd400000 0x0 0x40000>, <0x0 0xfd3d0000 0x0 0x1000>;
+		reg-names = "serdes", "siou";
+
+		lane0: lane@0 {
+			#phy-cells = <4>;
+		};
+		lane1: lane@1 {
+			#phy-cells = <4>;
+		};
+		lane2: lane@2 {
+			#phy-cells = <4>;
+		};
+		lane3: lane@3 {
+			#phy-cells = <4>;
+		};
+	};
+
+Specifying phy control of devices
+=================================
+
+Device nodes should specify the configuration required in their "phys"
+property, containing a phandle to the phy port node and a device type.
+
+phys = <PHANDLE CONTROLLER_TYPE CONTROLLER_INSTANCE LANE_NUM LANE_FREQ>;
+
+PHANDLE                 = &lane0 or &lane1 or &lane2 or &lane3
+CONTROLLER_TYPE         = PHY_TYPE_PCIE or PHY_TYPE_SATA or PHY_TYPE_USB
+			  or PHY_TYPE_DP or PHY_TYPE_SGMII
+CONTROLLER_INSTANCE     = Depends on controller type used, can be any of
+				PHY_TYPE_PCIE : 0 or 1 or 2 or 3
+				PHY_TYPE_SATA : 0 or 1
+				PHY_TYPE_USB  : 0 or 1
+				PHY_TYPE_DP   : 0 or 1
+				PHY_TYPE_SGMII: 0 or 1 or 2 or 3
+LANE_NUM                = Depends on which lane clock is used as ref clk, can be
+			  0 or 1 or 2 or 3
+LANE_FREQ               = Frequency that controller can operate, can be any of
+			  19.2Mhz,20Mhz,24Mhz,26Mhz,27Mhz,28.4Mhz,40Mhz,52Mhz,
+			  100Mhz,108Mhz,125Mhz,135Mhz,150Mhz
+
+Example:
+
+#include <dt-bindings/phy/phy.h>
+
+	usb@fe200000 {
+		...
+		phys	  = <&lane2 PHY_TYPE_USB3 0 2 2600000>;
+		...
+	};
+
+	ahci@fd0c0000 {
+		...
+		phys	  = <&lane3 PHY_TYPE_SATA 1 1 125000000>;
+		...
+	};
-- 
2.1.1

