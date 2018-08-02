Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B1AC46467
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DB132150A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="yyPaj7Hj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DB132150A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732491AbeHBO0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 10:26:32 -0400
Received: from mail-eopbgr710076.outbound.protection.outlook.com ([40.107.71.76]:61600
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732415AbeHBO0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 10:26:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PrQ4OtiQiqnPVb7Yy5hDKC2Z9fmO2PYE87BeoM57KsA=;
 b=yyPaj7Hj6wXLWVxlIMpAONZA3hV/LMdrnkHXyx+4+fsa67HCwxLxkvYv8zPS35IfuvaNOGSNOxNmmHlnMqCHpudjSyM3RQiF0RrjVfDdZeMr1WdybfpwJtqopBvzMG/des4cq9OfVt7iNoWY07pXn+Q64/ewLqH5JpE1hkZyWkk=
Received: from MWHPR02CA0048.namprd02.prod.outlook.com (2603:10b6:301:60::37)
 by BL0PR02MB4452.namprd02.prod.outlook.com (2603:10b6:208:45::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Thu, 2 Aug
 2018 12:35:26 +0000
Received: from CY1NAM02FT062.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::205) by MWHPR02CA0048.outlook.office365.com
 (2603:10b6:301:60::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1017.15 via Frontend
 Transport; Thu, 2 Aug 2018 12:35:26 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT062.mail.protection.outlook.com (10.152.75.60) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.3
 via Frontend Transport; Thu, 2 Aug 2018 12:35:21 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1flCp6-0001wQ-1x; Thu, 02 Aug 2018 05:35:20 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1flCp0-0007PR-Ud; Thu, 02 Aug 2018 05:35:14 -0700
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w72CZ8Io026503;
        Thu, 2 Aug 2018 05:35:08 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1flCot-0007MO-Vh; Thu, 02 Aug 2018 05:35:08 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 2BA6B121417; Thu,  2 Aug 2018 18:05:07 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <michal.simek@xilinx.com>, <bp@alien8.de>, <mchehab@kernel.org>,
        <mdf@kernel.org>, <edgar.iglesias@xilinx.com>,
        <shubhrajyoti.datta@xilinx.com>,
        <naga.sureshkumar.relli@xilinx.com>,
        <bharat.kumar.gogada@xilinx.com>, <stefan.krsmanovic@aggios.com>
CC:     <sgoud@xilinx.com>, <anirudh@xilinx.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>,
        Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH v2 3/4] edac: synopsys: Add EDAC ECC support for ZynqMP DDRC
Date:   Thu, 2 Aug 2018 18:04:47 +0530
Message-ID: <1533213288-8771-4-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1533213288-8771-1-git-send-email-manish.narani@xilinx.com>
References: <1533213288-8771-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(39860400002)(396003)(376002)(2980300002)(438002)(199004)(189003)(81166006)(2616005)(81156014)(8676002)(11346002)(50466002)(106466001)(53946003)(72206003)(6266002)(478600001)(110136005)(76176011)(7416002)(63266004)(90966002)(48376002)(126002)(426003)(44832011)(356003)(54906003)(486006)(4326008)(52956003)(5660300001)(51416003)(107886003)(476003)(42186006)(6666003)(103686004)(16586007)(36756003)(26005)(186003)(2906002)(305945005)(14444005)(106002)(50226002)(446003)(5024004)(8936002)(217873002)(36386004)(336012)(2201001)(316002)(47776003)(921003)(107986001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4452;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT062;1:5LW0Kvm7h3iLQXlYg8zzTipbSGnmMGdi5b2LYkpmmG/xznNUs3AWJcmbLSekTjkSWKkj6/u+D4i/Zj4sduCkLkTvddxHP04GiOpki9NDJKOGfshk7ZCvXp8oS2FdmK6D
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22f02c4c-8881-4f2a-b372-08d5f8746c0f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BL0PR02MB4452;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4452;3:EZLFi8fvvEbJPA+qFzlhxIPCK44novj1dDdLAn0br79XiIp4IrUKWIhD3NcVijIW17Wn1JfeU5ovqglgGPAwMzC/UPyphFTVMZv3AOYhgq1wAKwklg1tfdVR0eangC301xTiD+iy35/c7b/1D/djGA54kXu/dWlh6VcfJgN3Uhd7EWjG1kHrs0uOwXP9YEwFH7Uhfs8fj9SMf7rRkAn8vENohL/UuG+6ESiGVaANntkXvRFdcVLbsNoVfKZd33+fSAdp+stNZTVI/6r+8cOYlgxJtyC8b1TflvPHkpSbnjhx8EHyfn47hdx04+yo3cnh+0g2D9ioaCTu23O+3jfyKx18m0lMpuWa1U3Qx6v9iDQ=;25:oAoW7sCa8ZHi4mBNWkTcQ46p0zM02j/6/Co5Ie465/dfmNohB+oqvNik/vVvGsS12WbGSW+rC1t09Ap+d5OLp82DhcWwqgMtaIXglPE8a7zbEWjvaVmInCNZ0tB1EeeH50vht9hWwmMG8/9v4JO51J8rVUfBsJ/Zq823geCtMGX82wVcm1Dq9WNgNur06fhzA+9ydKBjkKG3IEXyLDMCxtG6EEF5f1RV/B5y6AEcklWnt2eCW4Kh1dERq1zE/Acu/q0RsF07Aquei/VvuRzPC582id86JqgVB9Mv2jccDSbZ3oO4PQM6j3/d4XasUrCqODdnNovBuVwdt0sFOFfdWg==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4452:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4452;31:tenj61KBjzEiIyLrZREL7wH92t4yAF3r1vDSAmOcUM25u3MU0hodZdAWgbEcvvMF3Rm0zj8f/8SUH2/jcW6eeQlpQaosMJgdTa9+wL33092Q13B8cN6SxMiNXAnRcPoYGGhwhe3JdjHvgGPfCWqhPIxd3cB+WeOQrj3R9Yqv7y0YaQyBAFNa0DwbnY7EJEx+YudmFac5AL56QFhaXAajLTmEVPROwE/LVig2C8ewILI=;20:CjkcKlESdsDqdiUt+ejn05WqjeY1s1rfrNNe75Tyc6u1SQ3T6DgrV4ZSxCkyjfHAjXbR8R/Ze2+oqF5tsjhDjNaSvZhfnsTg2vycIwp9Z5YPLib9ldxpBEh1Tf75+a86gAo6G034cQUiDTR6opfhvs1HdxoHNCRs2JqTfWfb9Bx+bTqFHxsHKDwSqfdn0HI//HtUNno7YIWC42jnAkbIknVhhrnYnVynQX+pYCIRTDPl9ZQqVI/c9wtFE+Lx+4IZsunjA37cLIdyn3kEmIemj2mbOX+ZoFjmYz+iBcNq7w3OAQe31dqH942CSnI1dvCN54tXEtj5GfqkKjhxyQ8HzTiH3hn6b5Zc8uFsIkIxUci4Lgzm8YGBjVmLRQuEeqL0sBTdhT2IQL9MLIduMbgahZYPyLzk9OYROcC2oTPE7SlvN3DrEqFI53n/IwfwcAb1UKXNpQ0FUlrIhZaf+hFS/B5W1P60gdczCd/7BL+/URkSP0SHWytzRJcU3W2KpMTT
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB4452F485B9F4219EC1F70200C12C0@BL0PR02MB4452.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93004095)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BL0PR02MB4452;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4452;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4452;4:5ouWH/61UM9zDCdCCA9xl6QTDs5GRTK9MknRoEvIJPB5Y3sE2ln+nsBsYnZG1jYflfnKH4Ys2jJlJjGpFubrYwoZm8Uchow9WlCtgvfBaa9AG5Yiw25EVUI2t7yD9fjLq5vXkF+X+P0qZLJA4Jy4cV2m/oVb81zAnFd/fVSaBt7f9ImxyOCSkmPWRbsVwFfM8k2NKCYdVAHOoMTGz9yMXqGkwE+HaEIcyooXlLBiauVob5Avaswhg5dxAKVIdIatQQ/jidgoiJSoRj0l5Q4HfCjAWIt96w8h+kFw5jA430IFXBDhC6BH0Ch9L12DLR3V
X-Forefront-PRVS: 07521929C1
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4452;23:DwZ0ACsC3gkjuIX0XYgtubgLmMXnGMW1UvHODtMfd?=
 =?us-ascii?Q?8CtIHh2+tFOZQ05JGSQfshAhaBifh/FRULH2Zc9O9Fbs4iZRXisPyYpDy0Iu?=
 =?us-ascii?Q?Nb+xJroyFN1jyzKvRw1Kcu5DyDVRLZ6hYXjFbWCItLgtp40yg71bBI9WP8K8?=
 =?us-ascii?Q?uCBbTUPMN9Qe/LONEY7Vn3GNOkx0ttpSuTVs9dDQHVCjEaNqUt0jxdfUkXCu?=
 =?us-ascii?Q?GwtFA54Kpu7rrsNMu9MTdorq1ugrXJHqNL8cKoC5XzbOhVxd5HLT4mxAN38f?=
 =?us-ascii?Q?IN8Lg5lQHs9HD10gonjydRPg7t3QEEdzL8040NCKl+mTDQPBAX6FQJkKAKUi?=
 =?us-ascii?Q?IP5iDhSlajNAfZz34wZakMkVvOfZVoNORuDuC/rVI7vYv44yT/UAUdrhcWpS?=
 =?us-ascii?Q?zgD78vYWHGBsJeoAIPhbrwaZrQ1fmWe578vRO029r8h1mU/LCKDgy9iNOotg?=
 =?us-ascii?Q?M7PXyKH3jcyc2x3lJepgbmwvOrJUx97Tc8eJvzI3G/+uTp/4M5Zom8WMhT42?=
 =?us-ascii?Q?uWNr9L3cl2xaJkVAaJHJIokioIg6sDCsernf8+zk1CVpHKE0IApCs4nOXpI+?=
 =?us-ascii?Q?Xdbaph7JzmkLXhuxjj1EeaYb1ZW5jTmTJsr0itO2ekpaP+Yvhi6ax2SdHrfd?=
 =?us-ascii?Q?YC36zhcDKi7W7M4PqQiA3KdowcyuKicrg0oYFvtDfoimfevik0lclvCDGUMr?=
 =?us-ascii?Q?TNEQ4dpjIm6OHffNfpacghqksQ6UgwERrjQQzexo6p4sLNqsi4+0EWspfe+E?=
 =?us-ascii?Q?yjlngBd84mQufqJAvwi2bnEImL3uozDxLEzpPSm0rCrQe59KyaSchEvHb2+R?=
 =?us-ascii?Q?dD0yZ90F3MEp9ytLqWbp+5utok3fiD3iFTt/hBs16rBETOuH0lFJzCUWpNJa?=
 =?us-ascii?Q?eusSizZHtoi6d7nUlG3NwM2DXn+lvo+NLoAWw9rv8weYFtOh7VhCiFXv0BBr?=
 =?us-ascii?Q?G2jV2aDzc6BO/shtCJo58JxfPRiL5sbTeNdrO7z/w1RhYajFQ4P2JU1qmD/a?=
 =?us-ascii?Q?MpK9ZyDGAV6yCZE13OkaBmdGw9Z6Ghe961H7vDXLyd1tnYb603smOGpWRB67?=
 =?us-ascii?Q?koycBFHBGP20Eds5/naFNFc/PF608SQq9LdLKM3yqRT1o3XR0ZyxvXVJfc1p?=
 =?us-ascii?Q?Uoecpj2tcyf+6XE5h7bPugHCcC2ewLvwvPWeWtddJyC6SkPt97Hwt7iyw5+D?=
 =?us-ascii?Q?TacoxVe0JDBgDE3XOUEDLq7ToE74QNdyO8XU5D57bPd/EFeai52aMLwe7vWG?=
 =?us-ascii?Q?u+t2WXPHrbbG1kQ2wDCcGMbQ84p5p+4/LaKbZBcuFpdzVJptCAwF5DyXJmC9?=
 =?us-ascii?Q?lbe+p6AGWQWxkNtsDtdSPdCJR0dW61FBVzQG5XvCkhRJFZjrQ6wf/8H5bxj1?=
 =?us-ascii?Q?hTg4Q=3D=3D?=
X-Microsoft-Antispam-Message-Info: 4DEXb/zwr6n8GaNqdfdSCMtSNIDN5L2Wl6INOrvbjvg+3kKSEQHvKv7Rhu7QmzBGO5k8KFXvnoQzJ1cKikDkoTTtNrBaSUPryOA3AkrggQL4sjuaw/3jgofQbEIGuUBTyha6CcpYv/LgPXSARCwGCbbMmN0G/yVukL0lgCa4mvo1iiRiBgjeI8PsQW4w2Zxc80ex8XeTEtlBZusAzugCWXTRssDiP9uNe1hsuy5N27XBILoNgJ/BBpIhpQVLm/wxFkNcPBtpPIhtuBolTXOtfwg/vWhdU1N/EJszrsAfdeh7vWKk4VK7lHO9jDOHqe8DD/R2DKr3p6oqEIWZODEEdFneR4yr8KizJgL9nyRJBzM=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4452;6:G54U6LHZ8tmesW0LMtf0AGcyGtbBYxfXC50Z0e5zD/OJD5/w9DCujElpPPWYlzDglH1Bz1j9kYUJ+5qXmiAelnlHtt9gxwU7uvN56A4A8t8KVYj6kbuGHhjKoqEaNYdH8jhY0ouZr2oa/SqMeZOhihaBrPagRN5pVny4fmYTWFnxMCEPHq1kJqXJwZ7KE4Ax7fC+sMNK9YISCduP8n/rrZsDyvo17ivUnV+z+sx8hGP5CXi8QdSx8yrXwjcYhJgfQXWZs1PkR2f7QzP34F+omQ89C/47oP/iaz3ixI2U+fBDFm1wxB47i5dEN1n3lZfCAtpNqTBFSNvnFufYIGioybqj4/3nZVsoAwhXI/EOgH0oOMmBVCXCci0U2AoyCcasnLDW69brhP3LnO3FQ0E8A8bCWJ+hTAdfmH5nK6Eufl7Qq9ozoKGBeTN0V0WICmGXR3Lp+WSjEi+5uRe/XNzlXQ==;5:/MWm2nwiir1qf/ivzP49P3H6ynRpiGy27ZvUOP5vYPclS2+iEU1MnNDhEPDZHKHFQm+hF2W1SDMrDc42xuydFZ1PTPotdzSuUe/dsEBzoqZ7La+qmXZAlVwioo1yNTKsZZKX3eos9rSAC93e1bgZ56x8yetnn7+aQ62xml6ygJY=;7:/zR82E8NOayk+K/dzkHcFaXP4vQWLJuIjO4PbYLApyIql3Tm4zbxUs27kiAnd/X25HWmRe//7oRqA7b6mkXHSz6HNk+KiVOQG89Bi8bdTYsnRqRbHY7nWzS95h4lO9IiHgzYhYS5P9NrzFIiT9n7j8CUUCsZ0MUQcGLqWSqSSdgpS6R5A/YVrdQSn7K3IuNX17my7ecgNQ0MvtYJ28F7CZ7UHfNLenLaYbeWtlzt6c7J2uwvdi8wukVnInrNbFNn
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2018 12:35:21.0169
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f02c4c-8881-4f2a-b372-08d5f8746c0f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4452
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds EDAC ECC support for ZynqMP DDRC IP. The patch also adds
support for ECC Error Injection in ZynqMP. The corrected and uncorrected
error interrupts support is added in this patch. The Row, Column, Bank,
Bank Group and Rank bits positions are determined via Address Map
registers of Synopsys DDRC.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/edac/Kconfig         |   2 +-
 drivers/edac/synopsys_edac.c | 857 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 841 insertions(+), 18 deletions(-)

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 57304b2..b1fc7a16 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -441,7 +441,7 @@ config EDAC_ALTERA_SDMMC
 
 config EDAC_SYNOPSYS
 	tristate "Synopsys DDR Memory Controller"
-	depends on ARCH_ZYNQ
+	depends on ARCH_ZYNQ || ARM64
 	help
 	  Support for error detection and correction on the Synopsys DDR
 	  memory controller.
diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index d4798e8..8a1c327 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -22,6 +22,7 @@
 #include <linux/edac.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/interrupt.h>
 #include <linux/of.h>
 
 #include "edac_module.h"
@@ -96,6 +97,170 @@
 #define SCRUB_MODE_MASK		0x7
 #define SCRUB_MODE_SECDED	0x4
 
+/* DDR ECC Quirks */
+#define DDR_ECC_INTR_SUPPORT	BIT(0)
+
+/* DDR ECC Quirks */
+#define DDR_ECC_INTR_SUPPORT	BIT(0)
+#define DDR_ECC_DATA_POISON_SUPPORT BIT(1)
+
+/* ZynqMP Enhanced DDR memory controller registers that are relevant to ECC */
+/* ECC Configuration Registers */
+#define ECC_CFG0_OFST	0x70
+#define ECC_CFG1_OFST	0x74
+
+/* ECC Status Register */
+#define ECC_STAT_OFST	0x78
+
+/* ECC Clear Register */
+#define ECC_CLR_OFST	0x7C
+
+/* ECC Error count Register */
+#define ECC_ERRCNT_OFST	0x80
+
+/* ECC Corrected Error Address Register */
+#define ECC_CEADDR0_OFST	0x84
+#define ECC_CEADDR1_OFST	0x88
+
+/* ECC Syndrome Registers */
+#define ECC_CSYND0_OFST	0x8C
+#define ECC_CSYND1_OFST	0x90
+#define ECC_CSYND2_OFST	0x94
+
+/* ECC Bit Mask0 Address Register */
+#define ECC_BITMASK0_OFST	0x98
+#define ECC_BITMASK1_OFST	0x9C
+#define ECC_BITMASK2_OFST	0xA0
+
+/* ECC UnCorrected Error Address Register */
+#define ECC_UEADDR0_OFST	0xA4
+#define ECC_UEADDR1_OFST	0xA8
+
+/* ECC Syndrome Registers */
+#define ECC_UESYND0_OFST	0xAC
+#define ECC_UESYND1_OFST	0xB0
+#define ECC_UESYND2_OFST	0xB4
+
+/* ECC Poison Address Reg */
+#define ECC_POISON0_OFST	0xB8
+#define ECC_POISON1_OFST	0xBC
+
+#define ECC_ADDRMAP0_OFFSET	0x200
+
+/* Control register bitfield definitions */
+#define ECC_CTRL_BUSWIDTH_MASK	0x3000
+#define ECC_CTRL_BUSWIDTH_SHIFT	12
+#define ECC_CTRL_CLR_CE_ERRCNT	BIT(2)
+#define ECC_CTRL_CLR_UE_ERRCNT	BIT(3)
+
+/* DDR Control Register width definitions  */
+#define DDRCTL_EWDTH_16		2
+#define DDRCTL_EWDTH_32		1
+#define DDRCTL_EWDTH_64		0
+
+/* ECC status register definitions */
+#define ECC_STAT_UECNT_MASK	0xF0000
+#define ECC_STAT_UECNT_SHIFT	16
+#define ECC_STAT_CECNT_MASK	0xF00
+#define ECC_STAT_CECNT_SHIFT	8
+#define ECC_STAT_BITNUM_MASK	0x7F
+
+/* DDR QOS Interrupt register definitions */
+#define DDR_QOS_IRQ_STAT_OFST	0x20200
+#define DDR_QOSUE_MASK		0x4
+#define	DDR_QOSCE_MASK		0x2
+#define	ECC_CE_UE_INTR_MASK	0x6
+#define DDR_QOS_IRQ_EN_OFST     0x20208
+#define DDR_QOS_IRQ_DB_OFST	0x2020C
+
+/* ECC Corrected Error Register Mask and Shifts*/
+#define ECC_CEADDR0_RW_MASK	0x3FFFF
+#define ECC_CEADDR0_RNK_MASK	BIT(24)
+#define ECC_CEADDR1_BNKGRP_MASK	0x3000000
+#define ECC_CEADDR1_BNKNR_MASK	0x70000
+#define ECC_CEADDR1_BLKNR_MASK	0xFFF
+#define ECC_CEADDR1_BNKGRP_SHIFT	24
+#define ECC_CEADDR1_BNKNR_SHIFT	16
+
+/* ECC Poison register shifts */
+#define ECC_POISON0_RANK_SHIFT 24
+#define ECC_POISON1_BANKGRP_SHIFT 28
+#define ECC_POISON1_BANKNR_SHIFT 24
+
+/* DDR Memory type defines */
+#define MEM_TYPE_DDR3		0x1
+#define MEM_TYPE_LPDDR3		0x8
+#define MEM_TYPE_DDR2		0x4
+#define MEM_TYPE_DDR4		0x10
+#define MEM_TYPE_LPDDR4		0x20
+
+/* DDRC Software control register */
+#define DDRC_SWCTL 0x320
+
+/* DDRC ECC CE & UE poison mask */
+#define ECC_CEPOISON_MASK 0x3
+#define ECC_UEPOISON_MASK 0x1
+
+/* DDRC Device config masks */
+#define DDRC_MSTR_DEV_CONFIG_MASK 0xC0000000
+#define DDRC_MSTR_DEV_CONFIG_SHIFT	30
+#define DDRC_MSTR_DEV_CONFIG_X4_MASK	0x0
+#define DDRC_MSTR_DEV_CONFIG_X8_MASK	0x1
+#define DDRC_MSTR_DEV_CONFIG_X16_MASK	0x2
+#define DDRC_MSTR_DEV_CONFIG_X32_MASK	0x3
+
+#define DDR_MAX_ROW_SHIFT	18
+#define DDR_MAX_COL_SHIFT	14
+#define DDR_MAX_BANK_SHIFT	3
+#define DDR_MAX_BANKGRP_SHIFT	2
+
+#define ROW_MAX_VAL_MASK	0xF
+#define COL_MAX_VAL_MASK	0xF
+#define BANK_MAX_VAL_MASK	0x1F
+#define BANKGRP_MAX_VAL_MASK	0x1F
+#define RANK_MAX_VAL_MASK	0x1F
+
+#define ROW_B0_BASE		6
+#define ROW_B1_BASE		7
+#define ROW_B2_BASE		8
+#define ROW_B3_BASE		9
+#define ROW_B4_BASE		10
+#define ROW_B5_BASE		11
+#define ROW_B6_BASE		12
+#define ROW_B7_BASE		13
+#define ROW_B8_BASE		14
+#define ROW_B9_BASE		15
+#define ROW_B10_BASE		16
+#define ROW_B11_BASE		17
+#define ROW_B12_BASE		18
+#define ROW_B13_BASE		19
+#define ROW_B14_BASE		20
+#define ROW_B15_BASE		21
+#define ROW_B16_BASE		22
+#define ROW_B17_BASE		23
+
+#define COL_B2_BASE		2
+#define COL_B3_BASE		3
+#define COL_B4_BASE		4
+#define COL_B5_BASE		5
+#define COL_B6_BASE		6
+#define COL_B7_BASE		7
+#define COL_B8_BASE		8
+#define COL_B9_BASE		9
+#define COL_B10_BASE		10
+#define COL_B11_BASE		11
+#define COL_B12_BASE		12
+#define COL_B13_BASE		13
+
+#define BANK_B0_BASE		2
+#define BANK_B1_BASE		3
+#define BANK_B2_BASE		4
+
+#define BANKGRP_B0_BASE		2
+#define BANKGRP_B1_BASE		3
+
+#define RANK_B0_BASE		6
+
 /**
  * struct ecc_error_info - ECC error log information
  * @row:	Row number
@@ -103,6 +268,8 @@
  * @bank:	Bank number
  * @bitpos:	Bit position
  * @data:	Data causing the error
+ * @bankgrpnr:	Bank group number
+ * @blknr:	Block number
  */
 struct ecc_error_info {
 	u32 row;
@@ -110,6 +277,8 @@ struct ecc_error_info {
 	u32 bank;
 	u32 bitpos;
 	u32 data;
+	u32 bankgrpnr;
+	u32 blknr;
 };
 
 /**
@@ -128,12 +297,18 @@ struct synps_ecc_status {
 
 /**
  * struct synps_edac_priv - DDR memory controller private instance data
- * @baseaddr:	Base address of the DDR controller
- * @message:	Buffer for framing the event specific info
- * @stat:	ECC status information
- * @p_data:	Pointer to platform data
- * @ce_cnt:	Correctable Error count
- * @ue_cnt:	Uncorrectable Error count
+ * @baseaddr:		Base address of the DDR controller
+ * @message:		Buffer for framing the event specific info
+ * @stat:		ECC status information
+ * @p_data:		Pointer to platform data
+ * @ce_cnt:		Correctable Error count
+ * @ue_cnt:		Uncorrectable Error count
+ * @poison_addr:	Data poison address
+ * @row_shift:		Value of row shifts
+ * @col_shift:		Value of col shifts
+ * @bank_shift:		Value of bank shifts
+ * @bankgrp_shift:	Value of bank group shifts
+ * @rank_shift:		Value of rank shifts
  */
 struct synps_edac_priv {
 	void __iomem *baseaddr;
@@ -142,6 +317,12 @@ struct synps_edac_priv {
 	const struct synps_platform_data *p_data;
 	u32 ce_cnt;
 	u32 ue_cnt;
+	ulong poison_addr;
+	u32 row_shift[18];
+	u32 col_shift[14];
+	u32 bank_shift[3];
+	u32 bankgrp_shift[2];
+	u32 rank_shift[1];
 };
 
 /**
@@ -168,7 +349,7 @@ struct synps_platform_data {
  *
  * Determines there is any ecc error or not
  *
- * Return: one if there is no error otherwise returns zero
+ * Return: 1 if there is no error otherwise returns 0
  */
 static int synps_edac_geterror_info(void __iomem *base,
 				    struct synps_ecc_status *p)
@@ -216,6 +397,65 @@ static int synps_edac_geterror_info(void __iomem *base,
 }
 
 /**
+ * synps_enh_edac_geterror_info - Get the current ecc error info
+ * @base:	Pointer to the base address of the ddr memory controller
+ * @p:		Pointer to the synopsys ecc status structure
+ *
+ * Determines there is any ecc error or not
+ *
+ * Return: one if there is no error otherwise returns zero
+ */
+static int synps_enh_edac_geterror_info(void __iomem *base,
+					struct synps_ecc_status *p)
+{
+	u32 regval, clearval = 0;
+
+	regval = readl(base + ECC_STAT_OFST);
+	if (!regval)
+		return 1;
+
+	p->ce_cnt = (regval & ECC_STAT_CECNT_MASK) >> ECC_STAT_CECNT_SHIFT;
+	p->ue_cnt = (regval & ECC_STAT_UECNT_MASK) >> ECC_STAT_UECNT_SHIFT;
+	p->ceinfo.bitpos = (regval & ECC_STAT_BITNUM_MASK);
+
+	regval = readl(base + ECC_CEADDR0_OFST);
+	if (!(p->ce_cnt))
+		goto ue_err;
+
+	p->ceinfo.row = (regval & ECC_CEADDR0_RW_MASK);
+	regval = readl(base + ECC_CEADDR1_OFST);
+	p->ceinfo.bank = (regval & ECC_CEADDR1_BNKNR_MASK) >>
+					ECC_CEADDR1_BNKNR_SHIFT;
+	p->ceinfo.bankgrpnr = (regval &	ECC_CEADDR1_BNKGRP_MASK) >>
+					ECC_CEADDR1_BNKGRP_SHIFT;
+	p->ceinfo.blknr = (regval & ECC_CEADDR1_BLKNR_MASK);
+	p->ceinfo.data = readl(base + ECC_CSYND0_OFST);
+	edac_dbg(3, "ce bit position: %d data: %d\n", p->ceinfo.bitpos,
+		 p->ceinfo.data);
+
+ue_err:
+	regval = readl(base + ECC_UEADDR0_OFST);
+	if (!(p->ue_cnt))
+		goto out;
+
+	p->ueinfo.row = (regval & ECC_CEADDR0_RW_MASK);
+	regval = readl(base + ECC_UEADDR1_OFST);
+	p->ueinfo.bankgrpnr = (regval & ECC_CEADDR1_BNKGRP_MASK) >>
+					ECC_CEADDR1_BNKGRP_SHIFT;
+	p->ueinfo.bank = (regval & ECC_CEADDR1_BNKNR_MASK) >>
+					ECC_CEADDR1_BNKNR_SHIFT;
+	p->ueinfo.blknr = (regval & ECC_CEADDR1_BLKNR_MASK);
+	p->ueinfo.data = readl(base + ECC_UESYND0_OFST);
+out:
+	clearval = ECC_CTRL_CLR_CE_ERR | ECC_CTRL_CLR_CE_ERRCNT;
+	clearval |= ECC_CTRL_CLR_UE_ERR | ECC_CTRL_CLR_UE_ERRCNT;
+	writel(clearval, base + ECC_CLR_OFST);
+	writel(0x0, base + ECC_CLR_OFST);
+
+	return 0;
+}
+
+/**
  * synps_edac_handle_error - Handle controller error types CE and UE
  * @mci:	Pointer to the edac memory controller instance
  * @p:		Pointer to the synopsys ecc status structure
@@ -230,9 +470,17 @@ static void synps_edac_handle_error(struct mem_ctl_info *mci,
 
 	if (p->ce_cnt) {
 		pinf = &p->ceinfo;
-		snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-			 "DDR ECC error type :%s Row %d Bank %d Col %d ",
-			 "CE", pinf->row, pinf->bank, pinf->col);
+		if (priv->p_data->quirks == 0)
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "DDR ECC error type :%s Row %d Bank %d Col %d ",
+				 "CE", pinf->row, pinf->bank, pinf->col);
+		else
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "DDR ECC error type :%s Row %d Bank %d Col %d "
+				 "BankGroup Number %d Block Number %d",
+				 "CE", pinf->row, pinf->bank, pinf->col,
+				 pinf->bankgrpnr, pinf->blknr);
+
 		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci,
 				     p->ce_cnt, 0, 0, 0, 0, 0, -1,
 				     priv->message, "");
@@ -240,9 +488,17 @@ static void synps_edac_handle_error(struct mem_ctl_info *mci,
 
 	if (p->ue_cnt) {
 		pinf = &p->ueinfo;
-		snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-			 "DDR ECC error type :%s Row %d Bank %d Col %d ",
-			 "UE", pinf->row, pinf->bank, pinf->col);
+		if (priv->p_data->quirks == 0)
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "DDR ECC error type :%s Row %d Bank %d Col %d ",
+				"UE", pinf->row, pinf->bank, pinf->col);
+		else
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "DDR ECC error type :%s Row %d Bank %d Col %d "
+				 "BankGroup Number %d Block Number %d",
+				 "UE", pinf->row, pinf->bank, pinf->col,
+				 pinf->bankgrpnr, pinf->blknr);
+
 		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
 				     p->ue_cnt, 0, 0, 0, 0, 0, -1,
 				     priv->message, "");
@@ -252,6 +508,41 @@ static void synps_edac_handle_error(struct mem_ctl_info *mci,
 }
 
 /**
+ * synps_edac_intr_handler - synps edac isr
+ * @irq:        irq number
+ * @dev_id:     device id poniter
+ *
+ * This is the Isr routine called by edac core interrupt thread.
+ * Used to check and post ECC errors.
+ *
+ * Return: IRQ_NONE, if interrupt not set or IRQ_HANDLED otherwise
+ */
+static irqreturn_t synps_edac_intr_handler(int irq, void *dev_id)
+{
+	struct mem_ctl_info *mci = dev_id;
+	struct synps_edac_priv *priv = mci->pvt_info;
+	int status, regval;
+
+	regval = readl(priv->baseaddr + DDR_QOS_IRQ_STAT_OFST) &
+			(DDR_QOSCE_MASK | DDR_QOSUE_MASK);
+	if (!(regval & ECC_CE_UE_INTR_MASK))
+		return IRQ_NONE;
+	status = priv->p_data->synps_edac_geterror_info(priv->baseaddr,
+				&priv->stat);
+	if (status)
+		return IRQ_NONE;
+
+	priv->ce_cnt += priv->stat.ce_cnt;
+	priv->ue_cnt += priv->stat.ue_cnt;
+	synps_edac_handle_error(mci, &priv->stat);
+
+	edac_dbg(3, "Total error count ce %d ue %d\n",
+		 priv->ce_cnt, priv->ue_cnt);
+	writel(regval, priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
+	return IRQ_HANDLED;
+}
+
+/**
  * synps_edac_check - Check controller for ECC errors
  * @mci:	Pointer to the edac memory controller instance
  *
@@ -307,6 +598,40 @@ static enum dev_type synps_edac_get_dtype(const void __iomem *base)
 }
 
 /**
+ * synps_enh_edac_get_dtype - Return the controller memory width
+ * @base:	Pointer to the ddr memory controller base address
+ *
+ * Get the EDAC device type width appropriate for the current controller
+ * configuration.
+ *
+ * Return: a device type width enumeration.
+ */
+static enum dev_type synps_enh_edac_get_dtype(const void __iomem *base)
+{
+	enum dev_type dt;
+	u32 width;
+
+	width = readl(base + CTRL_OFST);
+	width = (width & ECC_CTRL_BUSWIDTH_MASK) >>
+		ECC_CTRL_BUSWIDTH_SHIFT;
+	switch (width) {
+	case DDRCTL_EWDTH_16:
+		dt = DEV_X2;
+		break;
+	case DDRCTL_EWDTH_32:
+		dt = DEV_X4;
+		break;
+	case DDRCTL_EWDTH_64:
+		dt = DEV_X8;
+		break;
+	default:
+		dt = DEV_UNKNOWN;
+	}
+
+	return dt;
+}
+
+/**
  * synps_edac_get_eccstate - Return the controller ecc enable/disable status
  * @base:	Pointer to the ddr memory controller base address
  *
@@ -332,6 +657,32 @@ static bool synps_edac_get_eccstate(void __iomem *base)
 }
 
 /**
+ * synps_enh_edac_get_eccstate - Return the controller ecc enable/disable status
+ * @base:	Pointer to the ddr memory controller base address
+ *
+ * Get the ECC enable/disable status for the controller
+ *
+ * Return: a ecc status boolean i.e true/false - enabled/disabled.
+ */
+static bool synps_enh_edac_get_eccstate(void __iomem *base)
+{
+	enum dev_type dt;
+	u32 ecctype;
+	bool state = false;
+
+	dt = synps_enh_edac_get_dtype(base);
+	if (dt == DEV_UNKNOWN)
+		return state;
+
+	ecctype = readl(base + ECC_CFG0_OFST) & SCRUB_MODE_MASK;
+	if ((ecctype == SCRUB_MODE_SECDED) &&
+	    ((dt == DEV_X2) || (dt == DEV_X4) || (dt == DEV_X8)))
+		state = true;
+
+	return state;
+}
+
+/**
  * synps_edac_get_memsize - reads the size of the attached memory device
  *
  * Return: the memory size in bytes
@@ -370,6 +721,35 @@ static enum mem_type synps_edac_get_mtype(const void __iomem *base)
 }
 
 /**
+ * synps_enh_edac_get_mtype - Returns controller memory type
+ * @base:	pointer to the synopsys ecc status structure
+ *
+ * Get the EDAC memory type appropriate for the current controller
+ * configuration.
+ *
+ * Return: a memory type enumeration.
+ */
+static enum mem_type synps_enh_edac_get_mtype(const void __iomem *base)
+{
+	enum mem_type mt;
+	u32 memtype;
+
+	memtype = readl(base + CTRL_OFST);
+
+	mt = MEM_UNKNOWN;
+	if ((memtype & MEM_TYPE_DDR3) || (memtype & MEM_TYPE_LPDDR3))
+		mt = MEM_DDR3;
+	else if (memtype & MEM_TYPE_DDR2)
+		mt = MEM_RDDR2;
+	else if ((memtype & MEM_TYPE_LPDDR4) || (memtype & MEM_TYPE_DDR4))
+		mt = MEM_DDR4;
+	else
+		mt = MEM_EMPTY;
+
+	return mt;
+}
+
+/**
  * synps_edac_init_csrows - Initialize the cs row data
  * @mci:	Pointer to the edac memory controller instance
  *
@@ -437,8 +817,13 @@ static int synps_edac_mc_init(struct mem_ctl_info *mci,
 	mci->dev_name = SYNPS_EDAC_MOD_STRING;
 	mci->mod_name = SYNPS_EDAC_MOD_VER;
 
-	edac_op_state = EDAC_OPSTATE_POLL;
-	mci->edac_check = synps_edac_check;
+	if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
+		edac_op_state = EDAC_OPSTATE_INT;
+	} else {
+		edac_op_state = EDAC_OPSTATE_POLL;
+		mci->edac_check = synps_edac_check;
+	}
+
 	mci->ctl_page_to_phys = NULL;
 
 	status = synps_edac_init_csrows(mci);
@@ -454,13 +839,409 @@ static const struct synps_platform_data zynq_edac_def = {
 	.quirks				= 0,
 };
 
+static const struct synps_platform_data zynqmp_enh_edac_def = {
+	.synps_edac_geterror_info	= synps_enh_edac_geterror_info,
+	.synps_edac_get_mtype		= synps_enh_edac_get_mtype,
+	.synps_edac_get_dtype		= synps_enh_edac_get_dtype,
+	.synps_edac_get_eccstate	= synps_enh_edac_get_eccstate,
+	.quirks				= (DDR_ECC_INTR_SUPPORT |
+					   DDR_ECC_DATA_POISON_SUPPORT),
+};
+
 static const struct of_device_id synps_edac_match[] = {
 	{ .compatible = "xlnx,zynq-ddrc-a05", .data = (void *)&zynq_edac_def },
+	{ .compatible = "xlnx,zynqmp-ddrc-2.40a",
+				.data = (void *)&zynqmp_enh_edac_def},
 	{ /* end of table */ }
 };
 
 MODULE_DEVICE_TABLE(of, synps_edac_match);
 
+#define to_mci(k) container_of(k, struct mem_ctl_info, dev)
+
+/**
+ * ddr_poison_setup -	update poison registers
+ * @priv:		Pointer to synps_edac_priv struct
+ *
+ * Update poison registers as per ddr mapping
+ * Return: none.
+ */
+static void ddr_poison_setup(struct synps_edac_priv *priv)
+{
+	int col = 0, row = 0, bank = 0, bankgrp = 0, rank = 0, regval;
+	int index;
+	ulong hif_addr = 0;
+
+	hif_addr = priv->poison_addr >> 3;
+
+	for (index = 0; index < DDR_MAX_ROW_SHIFT; index++) {
+		if (priv->row_shift[index])
+			row |= (((hif_addr >> priv->row_shift[index]) &
+						BIT(0)) << index);
+		else
+			break;
+	}
+
+	for (index = 0; index < DDR_MAX_COL_SHIFT; index++) {
+		if (priv->col_shift[index] || index < 3)
+			col |= (((hif_addr >> priv->col_shift[index]) &
+						BIT(0)) << index);
+		else
+			break;
+	}
+
+	for (index = 0; index < DDR_MAX_BANK_SHIFT; index++) {
+		if (priv->bank_shift[index])
+			bank |= (((hif_addr >> priv->bank_shift[index]) &
+						BIT(0)) << index);
+		else
+			break;
+	}
+
+	for (index = 0; index < DDR_MAX_BANKGRP_SHIFT; index++) {
+		if (priv->bankgrp_shift[index])
+			bankgrp |= (((hif_addr >> priv->bankgrp_shift[index])
+						& BIT(0)) << index);
+		else
+			break;
+	}
+
+	if (priv->rank_shift[0])
+		rank = (hif_addr >> priv->rank_shift[0]) & BIT(0);
+
+	regval = (rank << ECC_POISON0_RANK_SHIFT) | col;
+	writel(regval, priv->baseaddr + ECC_POISON0_OFST);
+	regval = (bankgrp << ECC_POISON1_BANKGRP_SHIFT) |
+			 (bank << ECC_POISON1_BANKNR_SHIFT) | row;
+	writel(regval, priv->baseaddr + ECC_POISON1_OFST);
+}
+
+/**
+ * inject_data_error_show - Get Poison0 & 1 register contents
+ * @dev:	Pointer to the device struct
+ * @mattr:	Pointer to device attributes
+ * @data:	Pointer to user data
+ *
+ * Get the Poison0 and Poison1 register contents
+ * Return: Number of bytes copied.
+ */
+static ssize_t inject_data_error_show(struct device *dev,
+					      struct device_attribute *mattr,
+					      char *data)
+{
+	struct mem_ctl_info *mci = to_mci(dev);
+	struct synps_edac_priv *priv = mci->pvt_info;
+
+	return sprintf(data, "Poison0 Addr: 0x%08x\n\rPoison1 Addr: 0x%08x\n\r"
+			"Error injection Address: 0x%lx\n\r",
+			readl(priv->baseaddr + ECC_POISON0_OFST),
+			readl(priv->baseaddr + ECC_POISON1_OFST),
+			priv->poison_addr);
+}
+
+/**
+ * inject_data_error_store - Configure Poison0 Poison1 registers
+ * @dev:	Pointer to the device struct
+ * @mattr:	Pointer to device attributes
+ * @data:	Pointer to user data
+ * @count:	read the size bytes from buffer
+ *
+ * Configures the Poison0 and Poison1 register contents as per user given
+ * address
+ * Return: Number of bytes copied.
+ */
+static ssize_t inject_data_error_store(struct device *dev,
+					       struct device_attribute *mattr,
+					       const char *data, size_t count)
+{
+	struct mem_ctl_info *mci = to_mci(dev);
+	struct synps_edac_priv *priv = mci->pvt_info;
+
+	if (kstrtoul(data, 0, &priv->poison_addr))
+		return -EINVAL;
+
+	ddr_poison_setup(priv);
+
+	return count;
+}
+
+/**
+ * inject_data_poison_show - Shows type of Data poison
+ * @dev:	Pointer to the device struct
+ * @mattr:	Pointer to device attributes
+ * @data:	Pointer to user data
+ *
+ * Shows the type of Error injection enabled, either UE or CE
+ * Return: Number of bytes copied.
+ */
+static ssize_t inject_data_poison_show(struct device *dev,
+					      struct device_attribute *mattr,
+					      char *data)
+{
+	struct mem_ctl_info *mci = to_mci(dev);
+	struct synps_edac_priv *priv = mci->pvt_info;
+
+	return sprintf(data, "Data Poisoning: %s\n\r",
+			(((readl(priv->baseaddr + ECC_CFG1_OFST)) & 0x3) == 0x3)
+			? ("Correctable Error") : ("UnCorrectable Error"));
+}
+
+/**
+ * inject_data_poison_store - Enbles Data poison CE/UE
+ * @dev:	Pointer to the device struct
+ * @mattr:	Pointer to device attributes
+ * @data:	Pointer to user data
+ * @count:	read the size bytes from buffer
+ *
+ * Enables the CE or UE Data poison
+ * Return: Number of bytes copied.
+ */
+static ssize_t inject_data_poison_store(struct device *dev,
+					       struct device_attribute *mattr,
+					       const char *data, size_t count)
+{
+	struct mem_ctl_info *mci = to_mci(dev);
+	struct synps_edac_priv *priv = mci->pvt_info;
+
+	writel(0, priv->baseaddr + DDRC_SWCTL);
+	if (strncmp(data, "CE", 2) == 0)
+		writel(ECC_CEPOISON_MASK, priv->baseaddr + ECC_CFG1_OFST);
+	else
+		writel(ECC_UEPOISON_MASK, priv->baseaddr + ECC_CFG1_OFST);
+	writel(1, priv->baseaddr + DDRC_SWCTL);
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(inject_data_error);
+static DEVICE_ATTR_RW(inject_data_poison);
+
+/**
+ * synps_edac_create_sysfs_attributes - Create sysfs entries
+ * @mci:	Pointer to the edac memory controller instance
+ *
+ * Create sysfs attributes for injecting ECC errors using data poison.
+ *
+ * Return: 0 if sysfs creation was successful, else return negative error code.
+ */
+static int synps_edac_create_sysfs_attributes(struct mem_ctl_info *mci)
+{
+	int rc;
+
+	rc = device_create_file(&mci->dev, &dev_attr_inject_data_error);
+	if (rc < 0)
+		return rc;
+	rc = device_create_file(&mci->dev, &dev_attr_inject_data_poison);
+	if (rc < 0)
+		return rc;
+	return 0;
+}
+
+/**
+ * synps_edac_remove_sysfs_attributes - Removes sysfs entries
+ * @mci:	Pointer to the edac memory controller instance
+ *
+ * Removes sysfs attributes.
+ *
+ * Return: none.
+ */
+static void synps_edac_remove_sysfs_attributes(struct mem_ctl_info *mci)
+{
+	device_remove_file(&mci->dev, &dev_attr_inject_data_error);
+	device_remove_file(&mci->dev, &dev_attr_inject_data_poison);
+}
+
+/**
+ * setup_address_map -	Set Address Map by querying ADDRMAP registers
+ * @priv:		Pointer to synps_edac_priv struct
+ *
+ * Set Address Map by querying ADDRMAP registers
+ * Return: none.
+ */
+static void setup_address_map(struct synps_edac_priv *priv)
+{
+	u32 addrmap[12], addrmap_row_b2_10;
+	int index;
+	u32 width, memtype;
+
+	memtype = readl(priv->baseaddr + CTRL_OFST);
+	width = (memtype & ECC_CTRL_BUSWIDTH_MASK) >> ECC_CTRL_BUSWIDTH_SHIFT;
+
+	for (index = 0; index < 12; index++) {
+		u32 addrmap_offset;
+
+		addrmap_offset = ECC_ADDRMAP0_OFFSET + (index * 4);
+		addrmap[index] = readl(priv->baseaddr + addrmap_offset);
+	}
+
+	priv->row_shift[0] = (addrmap[5] & ROW_MAX_VAL_MASK) + ROW_B0_BASE;
+	priv->row_shift[1] = ((addrmap[5] >> 8) &
+			ROW_MAX_VAL_MASK) + ROW_B1_BASE;
+
+	addrmap_row_b2_10 = (addrmap[5] >> 16) & ROW_MAX_VAL_MASK;
+	if (addrmap_row_b2_10 != ROW_MAX_VAL_MASK) {
+		for (index = 2; index < 11; index++)
+			priv->row_shift[index] = addrmap_row_b2_10 +
+				index + ROW_B0_BASE;
+
+	} else {
+		priv->row_shift[2] = (addrmap[9] &
+				ROW_MAX_VAL_MASK) + ROW_B2_BASE;
+		priv->row_shift[3] = ((addrmap[9] >> 8) &
+				ROW_MAX_VAL_MASK) + ROW_B3_BASE;
+		priv->row_shift[4] = ((addrmap[9] >> 16) &
+				ROW_MAX_VAL_MASK) + ROW_B4_BASE;
+		priv->row_shift[5] = ((addrmap[9] >> 24) &
+				ROW_MAX_VAL_MASK) + ROW_B5_BASE;
+		priv->row_shift[6] = (addrmap[10] &
+				ROW_MAX_VAL_MASK) + ROW_B6_BASE;
+		priv->row_shift[7] = ((addrmap[10] >> 8) &
+				ROW_MAX_VAL_MASK) + ROW_B7_BASE;
+		priv->row_shift[8] = ((addrmap[10] >> 16) &
+				ROW_MAX_VAL_MASK) + ROW_B8_BASE;
+		priv->row_shift[9] = ((addrmap[10] >> 24) &
+				ROW_MAX_VAL_MASK) + ROW_B9_BASE;
+		priv->row_shift[10] = (addrmap[11] &
+				ROW_MAX_VAL_MASK) + ROW_B10_BASE;
+	}
+
+	priv->row_shift[11] = (((addrmap[5] >> 24) & ROW_MAX_VAL_MASK) ==
+				ROW_MAX_VAL_MASK) ? 0 : (((addrmap[5] >> 24) &
+				ROW_MAX_VAL_MASK) + ROW_B11_BASE);
+	priv->row_shift[12] = ((addrmap[6] & ROW_MAX_VAL_MASK) ==
+				ROW_MAX_VAL_MASK) ? 0 : ((addrmap[6] &
+				ROW_MAX_VAL_MASK) + ROW_B12_BASE);
+	priv->row_shift[13] = (((addrmap[6] >> 8) & ROW_MAX_VAL_MASK) ==
+				ROW_MAX_VAL_MASK) ? 0 : (((addrmap[6] >> 8) &
+				ROW_MAX_VAL_MASK) + ROW_B13_BASE);
+	priv->row_shift[14] = (((addrmap[6] >> 16) & ROW_MAX_VAL_MASK) ==
+				ROW_MAX_VAL_MASK) ? 0 : (((addrmap[6] >> 16) &
+				ROW_MAX_VAL_MASK) + ROW_B14_BASE);
+	priv->row_shift[15] = (((addrmap[6] >> 24) & ROW_MAX_VAL_MASK) ==
+				ROW_MAX_VAL_MASK) ? 0 : (((addrmap[6] >> 24) &
+				ROW_MAX_VAL_MASK) + ROW_B15_BASE);
+	priv->row_shift[16] = ((addrmap[7] & ROW_MAX_VAL_MASK) ==
+				ROW_MAX_VAL_MASK) ? 0 : ((addrmap[7] &
+				ROW_MAX_VAL_MASK) + ROW_B16_BASE);
+	priv->row_shift[17] = (((addrmap[7] >> 8) & ROW_MAX_VAL_MASK) ==
+				ROW_MAX_VAL_MASK) ? 0 : (((addrmap[7] >> 8) &
+				ROW_MAX_VAL_MASK) + ROW_B17_BASE);
+
+	priv->col_shift[0] = 0;
+	priv->col_shift[1] = 1;
+	priv->col_shift[2] = (addrmap[2] & COL_MAX_VAL_MASK) + COL_B2_BASE;
+	priv->col_shift[3] = ((addrmap[2] >> 8) &
+			COL_MAX_VAL_MASK) + COL_B3_BASE;
+	priv->col_shift[4] = (((addrmap[2] >> 16) & COL_MAX_VAL_MASK) ==
+			COL_MAX_VAL_MASK) ? 0 : (((addrmap[2] >> 16) &
+					COL_MAX_VAL_MASK) + COL_B4_BASE);
+	priv->col_shift[5] = (((addrmap[2] >> 24) & COL_MAX_VAL_MASK) ==
+			COL_MAX_VAL_MASK) ? 0 : (((addrmap[2] >> 24) &
+					COL_MAX_VAL_MASK) + COL_B5_BASE);
+	priv->col_shift[6] = ((addrmap[3] & COL_MAX_VAL_MASK) ==
+			COL_MAX_VAL_MASK) ? 0 : ((addrmap[3] &
+					COL_MAX_VAL_MASK) + COL_B6_BASE);
+	priv->col_shift[7] = (((addrmap[3] >> 8) & COL_MAX_VAL_MASK) ==
+			COL_MAX_VAL_MASK) ? 0 : (((addrmap[3] >> 8) &
+					COL_MAX_VAL_MASK) + COL_B7_BASE);
+	priv->col_shift[8] = (((addrmap[3] >> 16) & COL_MAX_VAL_MASK) ==
+			COL_MAX_VAL_MASK) ? 0 : (((addrmap[3] >> 16) &
+					COL_MAX_VAL_MASK) + COL_B8_BASE);
+	priv->col_shift[9] = (((addrmap[3] >> 24) & COL_MAX_VAL_MASK) ==
+			COL_MAX_VAL_MASK) ? 0 : (((addrmap[3] >> 24) &
+					COL_MAX_VAL_MASK) + COL_B9_BASE);
+	if (width == DDRCTL_EWDTH_64) {
+		if (memtype & MEM_TYPE_LPDDR3) {
+			priv->col_shift[10] = ((addrmap[4] &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				((addrmap[4] & COL_MAX_VAL_MASK) +
+				 COL_B10_BASE);
+			priv->col_shift[11] = (((addrmap[4] >> 8) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[4] >> 8) & COL_MAX_VAL_MASK) +
+				 COL_B11_BASE);
+		} else {
+			priv->col_shift[11] = ((addrmap[4] &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				((addrmap[4] & COL_MAX_VAL_MASK) +
+				 COL_B10_BASE);
+			priv->col_shift[13] = (((addrmap[4] >> 8) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[4] >> 8) & COL_MAX_VAL_MASK) +
+				 COL_B11_BASE);
+		}
+	} else if (width == DDRCTL_EWDTH_32) {
+		if (memtype & MEM_TYPE_LPDDR3) {
+			priv->col_shift[10] = (((addrmap[3] >> 24) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[3] >> 24) & COL_MAX_VAL_MASK) +
+				 COL_B9_BASE);
+			priv->col_shift[11] = ((addrmap[4] &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				((addrmap[4] & COL_MAX_VAL_MASK) +
+				 COL_B10_BASE);
+		} else {
+			priv->col_shift[11] = (((addrmap[3] >> 24) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[3] >> 24) & COL_MAX_VAL_MASK) +
+				 COL_B9_BASE);
+			priv->col_shift[13] = ((addrmap[4] &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				((addrmap[4] & COL_MAX_VAL_MASK) +
+				 COL_B10_BASE);
+		}
+	} else {
+		if (memtype & MEM_TYPE_LPDDR3) {
+			priv->col_shift[10] = (((addrmap[3] >> 16) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[3] >> 16) & COL_MAX_VAL_MASK) +
+				 COL_B8_BASE);
+			priv->col_shift[11] = (((addrmap[3] >> 24) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[3] >> 24) & COL_MAX_VAL_MASK) +
+				 COL_B9_BASE);
+			priv->col_shift[13] = ((addrmap[4] &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				((addrmap[4] & COL_MAX_VAL_MASK) +
+				 COL_B10_BASE);
+		} else {
+			priv->col_shift[11] = (((addrmap[3] >> 16) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[3] >> 16) & COL_MAX_VAL_MASK) +
+				 COL_B8_BASE);
+			priv->col_shift[13] = (((addrmap[3] >> 24) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[3] >> 24) & COL_MAX_VAL_MASK) +
+				 COL_B9_BASE);
+		}
+	}
+
+	if (width) {
+		for (index = 9; index > width; index--) {
+			priv->col_shift[index] = priv->col_shift[index - width];
+			priv->col_shift[index - width] = 0;
+		}
+	}
+
+	priv->bank_shift[0] = (addrmap[1] & BANK_MAX_VAL_MASK) + BANK_B0_BASE;
+	priv->bank_shift[1] = ((addrmap[1] >> 8) &
+				BANK_MAX_VAL_MASK) + BANK_B1_BASE;
+	priv->bank_shift[2] = (((addrmap[1] >> 16) &
+				BANK_MAX_VAL_MASK) == BANK_MAX_VAL_MASK) ? 0 :
+				(((addrmap[1] >> 16) & BANK_MAX_VAL_MASK) +
+				 BANK_B2_BASE);
+
+	priv->bankgrp_shift[0] = (addrmap[8] &
+				BANKGRP_MAX_VAL_MASK) + BANKGRP_B0_BASE;
+	priv->bankgrp_shift[1] = (((addrmap[8] >> 8) & BANKGRP_MAX_VAL_MASK) ==
+				BANKGRP_MAX_VAL_MASK) ? 0 : (((addrmap[8] >> 8)
+				& BANKGRP_MAX_VAL_MASK) + BANKGRP_B1_BASE);
+
+	priv->rank_shift[0] = ((addrmap[0] & RANK_MAX_VAL_MASK) ==
+				RANK_MAX_VAL_MASK) ? 0 : ((addrmap[0] &
+				RANK_MAX_VAL_MASK) + RANK_B0_BASE);
+}
+
 /**
  * synps_edac_mc_probe - Check controller and bind driver
  * @pdev:	Pointer to the platform_device struct
@@ -475,7 +1256,7 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 	struct mem_ctl_info *mci;
 	struct edac_mc_layer layers[2];
 	struct synps_edac_priv *priv;
-	int rc;
+	int rc, irq, status;
 	struct resource *res;
 	void __iomem *baseaddr;
 	const struct of_device_id *match;
@@ -524,6 +1305,27 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 		goto free_edac_mc;
 	}
 
+	if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
+		irq = platform_get_irq(pdev, 0);
+		if (irq < 0) {
+			edac_printk(KERN_ERR, EDAC_MC,
+					"No irq %d in DT\n", irq);
+			return -ENODEV;
+		}
+
+		status = devm_request_irq(&pdev->dev, irq,
+			synps_edac_intr_handler,
+			0, dev_name(&pdev->dev), mci);
+		if (status < 0) {
+			edac_printk(KERN_ERR, EDAC_MC, "Failed to request Irq\n");
+			goto free_edac_mc;
+		}
+
+		/* Enable UE/CE Interrupts */
+		writel((DDR_QOSUE_MASK | DDR_QOSCE_MASK),
+			priv->baseaddr + DDR_QOS_IRQ_EN_OFST);
+	}
+
 	rc = edac_mc_add_mc(mci);
 	if (rc) {
 		edac_printk(KERN_ERR, EDAC_MC,
@@ -531,11 +1333,24 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 		goto free_edac_mc;
 	}
 
+	if (priv->p_data->quirks & DDR_ECC_DATA_POISON_SUPPORT) {
+		if (synps_edac_create_sysfs_attributes(mci)) {
+			edac_printk(KERN_ERR, EDAC_MC,
+					"Failed to create sysfs entries\n");
+			goto free_edac_mc;
+		}
+	}
+
+	if (of_device_is_compatible(pdev->dev.of_node,
+				    "xlnx,zynqmp-ddrc-2.40a"))
+		setup_address_map(priv);
+
 	/*
 	 * Start capturing the correctable and uncorrectable errors. A write of
 	 * 0 starts the counters.
 	 */
-	writel(0x0, baseaddr + ECC_CTRL_OFST);
+	if (!(priv->p_data->quirks & DDR_ECC_INTR_SUPPORT))
+		writel(0x0, baseaddr + ECC_CTRL_OFST);
 	return rc;
 
 free_edac_mc:
@@ -553,8 +1368,16 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 static int synps_edac_mc_remove(struct platform_device *pdev)
 {
 	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
+	struct synps_edac_priv *priv;
 
+	priv = mci->pvt_info;
+	if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT)
+		/* Disable UE/CE Interrupts */
+		writel((DDR_QOSUE_MASK | DDR_QOSCE_MASK),
+			priv->baseaddr + DDR_QOS_IRQ_DB_OFST);
 	edac_mc_del_mc(&pdev->dev);
+	if (priv->p_data->quirks & DDR_ECC_DATA_POISON_SUPPORT)
+		synps_edac_remove_sysfs_attributes(mci);
 	edac_mc_free(mci);
 
 	return 0;
-- 
2.1.1

