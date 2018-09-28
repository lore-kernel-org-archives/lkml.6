Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6B1C64E93
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0107B20671
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="FkGhd0ja"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0107B20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbeI2EoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:44:18 -0400
Received: from mail-dm3nam03on0062.outbound.protection.outlook.com ([104.47.41.62]:10656
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726933AbeI2EoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:44:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vCzQhuRHarQbbE3PXhCcPtrd6OcslaCWvAzyxXFERs=;
 b=FkGhd0jagCsJ7zpqfMqcglBd65jLDD3gASiJ949udl8YhgmQ10GS0zVDD3Q4sz9LnYB4cVbnGWfBdbg+XCSEY5/MXkMF7YA5fZeAUtxNTUJyqiq+mpBaZJQhSWW03G7K2WBj2Qc8qYLBDx2GxIhOCKDYDxWq71zfH4PwwyvmFtY=
Received: from DM6PR02CA0025.namprd02.prod.outlook.com (2603:10b6:5:1c::38) by
 DM6PR02MB5113.namprd02.prod.outlook.com (2603:10b6:5:51::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.22; Fri, 28 Sep 2018 22:18:26 +0000
Received: from BL2NAM02FT023.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::207) by DM6PR02CA0025.outlook.office365.com
 (2603:10b6:5:1c::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1164.22 via Frontend
 Transport; Fri, 28 Sep 2018 22:18:26 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT023.mail.protection.outlook.com (10.152.77.72) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1185.13
 via Frontend Transport; Fri, 28 Sep 2018 22:18:25 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:38992 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g615d-0003vY-BI; Fri, 28 Sep 2018 15:18:25 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g615Y-0005vP-7a; Fri, 28 Sep 2018 15:18:20 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8SMIGtq021009;
        Fri, 28 Sep 2018 15:18:16 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1g615U-0005ux-F9; Fri, 28 Sep 2018 15:18:16 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <olof@lixom.net>, <mturquette@baylibre.com>,
        <sboyd@codeaurora.org>, <michal.simek@xilinx.com>,
        <arm@kernel.org>, <linux-clk@vger.kernel.org>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v5 3/4] dt-bindings: clock: Add bindings for ZynqMP clock driver
Date:   Fri, 28 Sep 2018 15:17:59 -0700
Message-ID: <1538173080-7597-4-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538173080-7597-1-git-send-email-jollys@xilinx.com>
References: <1538173080-7597-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(396003)(136003)(2980300002)(438002)(199004)(189003)(11346002)(446003)(34290500001)(44832011)(426003)(2616005)(476003)(107886003)(336012)(486006)(50466002)(48376002)(4326008)(47776003)(9786002)(305945005)(14444005)(106466001)(8676002)(126002)(81156014)(8936002)(81166006)(50226002)(2201001)(36386004)(110136005)(54906003)(106002)(2906002)(478600001)(72206003)(63266004)(6666003)(36756003)(16586007)(26005)(186003)(77096007)(5660300001)(51416003)(76176011)(7696005)(316002)(356003)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB5113;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT023;1:vPEWt+ZUvK8yqn814sRtWnKH1S1MnQreyjv66lZm3uEuPfR+/1n5cm+QZz9WECHAibzw/1EhGGATrrHAN5oFLnoyc/CarDFI53nnYLVePStryBP8T7n4SVdgIdX/wFJY
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46512b5f-7713-423f-86ab-08d625904fb0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM6PR02MB5113;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB5113;3:WmhEBsNkrbytN2Ufyg3ppinri16IhOq+E9goljeB5tKIxBiiI2Wg3r9VpSiLx+ADDg0ud1Y6j8PFS9nvbDVoFRK38keXT93dWcd1jEnIL8BymvPf8e6+5esJSSo1Smd5+rx2C0TbfhHYtdzT1ZgVnTSFPxmcUgePaWR3P0kZWf39/+bS4K+1syuDuMk+GFtunrsYj3EZ3Y7Q/LelpV7Ck5sJTinJ5Q8SW+vczttGvC71bfLW1TNmcyzOE9HNo7nKHNAVb7CAoejjZbDO9AwhtPo9mrHUe/HDW3Mcdo9/mPEwpG9NXcK/ggmufA2g92DPW5u23s1WzcKOiylu2MgLDDQ9eJ7gel5KNOQwGykenq4=;25:9mgp81Kk4HVweDBuEoi/XkBAdrF4ocTJ93lhCPEdMd9llDMGk5w9I8Lw8L/32l/NcGMy9LfkuPnCK5LLKblTcDDX+oWHCXRgmBdB8XzUhJa/JYrkyCWyVKoD6bdvORFAQ8k838ZS6n7TqQnpY0ZobAH7NZMIbScs0JBco0KtT3vhdaQxezjURVA/qOW7H580T7rq+SLKSC5IUg7XkT30wVavX2q3n7+JYcuYDN/lYoVaNjX/kM3hzd5BuUFwlBcGHR/MMM/5dcVXr49zQeAv5YTbKN9ae5+tTXXA1NSJ20XXgm49PQ71z8c7iUI/Z04ESn0RQtAfEMbeGT7wr9MWlA==
X-MS-TrafficTypeDiagnostic: DM6PR02MB5113:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB5113;31:dLog4H9MEeD5K+1/9lUThmXqpwpjWzvGGX+nErwEPZDa7Ns13049+AmEkOBYf4hDOeEYVGIkxgYZ4825QgK3fTj0fqpzIzcEjCEnpfkTJ/XItH8kS+FIiJQ1uqsR67kbODZ615LlkFdzIo6LSKpBKhCjroEmvM04i15MszrGlVwEI/t5hWgp3jQvIomcQ5m8SOB7q0msBQ5pWW4eoUxfC4m1hdi6BGrbR+GXgQLipi4=;20:RdaJgFgXV9UU3ErLXm3bBV0WrXSx3+hy7KxMAdtb8/9M0d9MmvR+kfawqG/updXGb0CpfepptVRacrYnW0uMJ75rGM7ZWEu4tQvbC+9Mw+W3WC/5p0vOO3gwS67M9LFWwGBYg7brI+pVJ1x8b37xiJ0CfcbtF+PWKcGJgxK47Vsbwyqo1jQm4ZDOpX02uAqbzBHJV/Jyd13TIeoh+1zrnS5J8dILNr2ycH+9ak6y8MuoY8HBo31CZAA7BgD5nLM18VraKJqsKIvTlc5pddX9U7AjLtiXmW+L79D4ckSc97LA6/Z/ymTt5nytXJi8EB24VzI0TT1BU+hW2fFRHbDAnj0rXmsW+R9xYPmu6/FBint3bEGLUjT7qXf0Rj9dxZuOssEUdKLdX9JF4fO+H0HHSK7rfKsGqdHhWyJiA615/vngdvrBCEooW/vqq4/kcTXKcHx2BwWFVGQxd1sIMWs2VWsmo9mOYsupOJbNf8fNbALYbhTfUY3kNNbaKcf0iaGT
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB51138BA2EDE4411BD30BFB0BB8EC0@DM6PR02MB5113.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93004095)(3002001)(10201501046)(6055026)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051);SRVR:DM6PR02MB5113;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB5113;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB5113;4:cNc/TmVkcF6fCdRFr6F9ZZ40dcya2SFpTdUXykpz+T4ZeKe+hxbVdMENwtb0GI9sw0fXjBGog+Cdl4diZhITkHUP8ExW5kXZZEilmRTH7VdQhsZN9pEfWNRkYgBjlZTBvKXSDc2v/HMbs8oPqhL9IAD5JfORLDGS85ztJxSVSHEJgfNrd0R9cAbvcbItc5FF7eqPhmFrkGuo/0X05sb8LSEqPg2HuupMn4iDsEbOBISBkJayStVUNVNvif6ZjwNGFglTCa8rRNpd6y7E6lsXtVQXBkTEx0zsDVlFwvPn6hsUzOgYBcbMXKUdEMNUnolx
X-Forefront-PRVS: 0809C12563
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB5113;23:Pt7ajxrftLt1JBah/6Paj0XP++os9YxhckEM9lY4f?=
 =?us-ascii?Q?8qYw0D+Iy6QFF13TF8YRTsX1L3rYnhSKGd4y1NeGibtX5XtUGvrfotsBNRpt?=
 =?us-ascii?Q?kpqiHWdIOjwceUMSGL2OXTHx9ybnwL9E1sE90BTy4KJXAY6g9rX2oLccBYcx?=
 =?us-ascii?Q?tbOVoLSdQ7tnL9N7x330B27E6Spw7JBGM5PZImXjdCSTZlM+3Tt5De1fj9Eh?=
 =?us-ascii?Q?DNNb+eASXKRRZxK7KD4a13w1P4+vwceG47ag3vNbOMJYBcqL+KhuzreE4n9X?=
 =?us-ascii?Q?lg3Ku/jT73uaNFSYrsuZCmY5xCngi+QrKTfLOIctRBS06gNcvFcH9mQVG+IS?=
 =?us-ascii?Q?qmW0pQbmc9rl4/mvmIAfs0AdaySl+TDH3UrcOAMqna6VIQM3yeeHYGICWjkX?=
 =?us-ascii?Q?0RTR5H3Nq3NJPqiB9oipk+59OR38KeLdgAdviTPctbVLY86dTjOerjIFA48/?=
 =?us-ascii?Q?GlkRvSCiojliTivLpqWfHLyfpl158iVgZ/lHv/U2nhVQWD+5dHNR/XLzgT+3?=
 =?us-ascii?Q?R/2eyPVTFgUYRJ0/UoL4ZJvMhI1qmhIVRkGQE5YaBzz+aEGHx96QnWikkhmy?=
 =?us-ascii?Q?MscNqjzc/o6dkcqnnTtNzekOZbiSqGwW4I8GIBOU8TqCa0Zm8cdi4kpTm9Qn?=
 =?us-ascii?Q?2undXM7Kq6bqxkhnsPRm0g4aQ6jeJWYZD8Y62ZmJixGLLW5jOTjZ78Jm+oMj?=
 =?us-ascii?Q?OvPLL7lBajR4ZU2K/BBFf6/Y4F5Vq3PZVBdy7VI5yQsRWymBbU+OvFbdJhsq?=
 =?us-ascii?Q?yOZrUQlNytsj3vuvUtQ6CZXN3+7WwN/3Jb0mdAwh+C3/Kkm8W63khlKTPL/s?=
 =?us-ascii?Q?BCO6pf4PY5mWGZYnRulsZnYjeSB8fp4mxxsR6d6D8BII6bGYmWWdZSrm27UR?=
 =?us-ascii?Q?BYn9JqycIM+4yBvH8zMVtZTDP0PWe6uzicgisnC6olsMuzkLRQ0oR+BZM+2j?=
 =?us-ascii?Q?6aM00IEWj/Y79jHwZBhuivKHudM108P0ZBnrlGE/boNfRzYIRxCXvXnHRFra?=
 =?us-ascii?Q?WO98Bw6o8QADpb2Efz1rcJzOrz/wc44DKTlKbv87t1OjIBXsiKh7R2kVQ3NQ?=
 =?us-ascii?Q?Eh2ltemFIrv0f3zq4908kV2RHwqPj8Uu+rTZrNK4zoN3XVkI3Nmzcwi8vq/p?=
 =?us-ascii?Q?1bsXqz97//zSzi74fjzdBLgmyxSc4mpYN4QTAgb3wUMtSlrS1CFWv0+ocfFh?=
 =?us-ascii?Q?X4r7fqljOKdT7nG2ppd14JOexsby5iIAbgV0JP2t1YCsRZIGMRXojK9YlFWz?=
 =?us-ascii?Q?QeOaQSSs7HadYBWLrY=3D?=
X-Microsoft-Antispam-Message-Info: rlj9j20ggQY5odldbdEEG0QBg9YC7CWt/en/iZ5cZbFfNZgK668t1yusf+og3qBHIEPBts/FiR+3UuRpx6UOnojfNJAbvoiKHe+6HfKFk2NEomLNVesWji67yo57t+qoqkPV7wPF+593c88Rw+SGXEN/RHvLi84Y55HcfsvJWcM8+8wU4z1RHlvY3Fh3z4y4smXTnHHs3fFUIBYZiuiTg/xgSGJsh/Yad1XfPKPlj5t911lIJOquoCO2TfTOzckbp2/MpQQtfrJqCn30XyyEM0tknk915OzUErtd0EjC3rf68eg9NJkZPDhmdriTATVj4VFqTpGU/WQL2Iy60K3bmUgUUcFsjDrXXe0di6gfvCI=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB5113;6:dShqsLy8xzWeHfbXHmc5S49z4ArY0dyDTVEae9IdBSWr9GaItyQYuwKMs2/6aVmQjzPiudx5DfPXza+rLVRypia8WP7SBkrClPVu9oIJnWgqd3xd1h3mYG7DjRpxPp9TKIM7m38zzP6wW2LZXikag1WiB+Ncw1M/bn5HNSWLjgU1Appb2W5kVH85Pf0m1z4+dJXA8xzq3PExMmdgYxJFG+b6NSj5RWQ/TPo1dyQzw/Ki2GH0qcDOMu5CTjVXQb2nNe5ueLqauOUB8096crOIsl1DazJNEyUde1rhToVpqM1aEX5CK06/G2Yl5fMnWngTTQ7jTAoS926/FJ9zgmkkvEP9ZQ4JnlQAOeNOC7OgLudsIVx7t4Hi0T1/qHAd7D/wRk+1MbZP2QRrQ5P32fqQsoYUoZCjvA9jiByby+JFJHT/iizwH+mVfqj6xhRysW37JAjVo+LDDyocZ6CO0B5jIw==;5:/Opii1zxAkGq2tfTJVfejmlWtad5PFPb5RsgwkBHK1pP68prSuCIccSQ4j+sm5QbAVEZjUi01+7wK6cWG5nZe8YXg581YXJevpUJs/klTqT49XteEvUKIcEvF3Iiwx2ysVeYzbIRhFXVRWHx7fhTbPe6g06AqNIPl4MzkgGms6A=;7:z8GbQwpYKRMajRoe7R/u0h/SeRrICPgfmsvJyow/nuOSp9YJ2Eprgfh51MnozVpCsFjDrV0Lu53XWJuUApJ9MkbUnuFoiwP0g8CMnl5l1eFvAX/VNnKj22tnW70eLs0pFfb0L5/Yl2fJNNqB0wamMQn2QPVIcirCTAL/RESgeSmLTuaHFzygAjmVdm4FXtLVv8gRDBpfXMCgCZSefNpc6Oin6tWUDPCLvJ/BFJQPTewAKc2L4K3BetQJsZKepLiI
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2018 22:18:25.9490
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46512b5f-7713-423f-86ab-08d625904fb0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Add documentation to describe Xilinx ZynqMP clock driver
bindings.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 .../firmware/xilinx/xlnx,zynqmp-firmware.txt       |  53 ++++++++++
 include/dt-bindings/clock/xlnx,zynqmp-clk.h        | 116 +++++++++++++++++++++
 2 files changed, 169 insertions(+)
 create mode 100644 include/dt-bindings/clock/xlnx,zynqmp-clk.h

diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
index 1b431d9..614bac5 100644
--- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
+++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
@@ -17,6 +17,53 @@ Required properties:
 		  - "smc" : SMC #0, following the SMCCC
 		  - "hvc" : HVC #0, following the SMCCC
 
+--------------------------------------------------------------------------
+Device Tree Clock bindings for the Zynq Ultrascale+ MPSoC controlled using
+Zynq MPSoC firmware interface
+--------------------------------------------------------------------------
+The clock controller is a h/w block of Zynq Ultrascale+ MPSoC clock
+tree. It reads required input clock frequencies from the devicetree and acts
+as clock provider for all clock consumers of PS clocks.
+
+See clock_bindings.txt for more information on the generic clock bindings.
+
+Required properties:
+ - #clock-cells:	Must be 1
+ - compatible:		Must contain:	"xlnx,zynqmp-clk"
+ - clocks:		List of clock specifiers which are external input
+			clocks to the given clock controller. Please refer
+			the next section to find the input clocks for a
+			given controller.
+ - clock-names:		List of clock names which are exteral input clocks
+			to the given clock controller. Please refer to the
+			clock bindings for more details.
+
+Input clocks for zynqmp Ultrascale+ clock controller:
+
+The Zynq UltraScale+ MPSoC has one primary and four alternative reference clock
+inputs. These required clock inputs are:
+ - pss_ref_clk (PS reference clock)
+ - video_clk (reference clock for video system )
+ - pss_alt_ref_clk (alternative PS reference clock)
+ - aux_ref_clk
+ - gt_crx_ref_clk (transceiver reference clock)
+
+The following strings are optional parameters to the 'clock-names' property in
+order to provide an optional (E)MIO clock source:
+ - swdt0_ext_clk
+ - swdt1_ext_clk
+ - gem0_emio_clk
+ - gem1_emio_clk
+ - gem2_emio_clk
+ - gem3_emio_clk
+ - mio_clk_XX		# with XX = 00..77
+ - mio_clk_50_or_51	#for the mux clock to gem tsu from 50 or 51
+
+
+Output clocks are registered based on clock information received
+from firmware. Output clocks indexes are mentioned in
+include/dt-bindings/clock/xlnx,zynqmp-clk.h.
+
 -------
 Example
 -------
@@ -25,5 +72,11 @@ firmware {
 	zynqmp_firmware: zynqmp-firmware {
 		compatible = "xlnx,zynqmp-firmware";
 		method = "smc";
+		zynqmp_clk: clock-controller {
+			#clock-cells = <1>;
+			compatible = "xlnx,zynqmp-clk";
+			clocks = <&pss_ref_clk>, <&video_clk>, <&pss_alt_ref_clk>, <&aux_ref_clk>, <&gt_crx_ref_clk>;
+			clock-names = "pss_ref_clk", "video_clk", "pss_alt_ref_clk","aux_ref_clk", "gt_crx_ref_clk";
+		};
 	};
 };
diff --git a/include/dt-bindings/clock/xlnx,zynqmp-clk.h b/include/dt-bindings/clock/xlnx,zynqmp-clk.h
new file mode 100644
index 0000000..4aebe6e
--- /dev/null
+++ b/include/dt-bindings/clock/xlnx,zynqmp-clk.h
@@ -0,0 +1,116 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Xilinx Zynq MPSoC Firmware layer
+ *
+ *  Copyright (C) 2014-2018 Xilinx, Inc.
+ *
+ */
+
+#ifndef _DT_BINDINGS_CLK_ZYNQMP_H
+#define _DT_BINDINGS_CLK_ZYNQMP_H
+
+#define IOPLL			0
+#define RPLL			1
+#define APLL			2
+#define DPLL			3
+#define VPLL			4
+#define IOPLL_TO_FPD		5
+#define RPLL_TO_FPD		6
+#define APLL_TO_LPD		7
+#define DPLL_TO_LPD		8
+#define VPLL_TO_LPD		9
+#define ACPU			10
+#define ACPU_HALF		11
+#define DBF_FPD			12
+#define DBF_LPD			13
+#define DBG_TRACE		14
+#define DBG_TSTMP		15
+#define DP_VIDEO_REF		16
+#define DP_AUDIO_REF		17
+#define DP_STC_REF		18
+#define GDMA_REF		19
+#define DPDMA_REF		20
+#define DDR_REF			21
+#define SATA_REF		22
+#define PCIE_REF		23
+#define GPU_REF			24
+#define GPU_PP0_REF		25
+#define GPU_PP1_REF		26
+#define TOPSW_MAIN		27
+#define TOPSW_LSBUS		28
+#define GTGREF0_REF		29
+#define LPD_SWITCH		30
+#define LPD_LSBUS		31
+#define USB0_BUS_REF		32
+#define USB1_BUS_REF		33
+#define USB3_DUAL_REF		34
+#define USB0			35
+#define USB1			36
+#define CPU_R5			37
+#define CPU_R5_CORE		38
+#define CSU_SPB			39
+#define CSU_PLL			40
+#define PCAP			41
+#define IOU_SWITCH		42
+#define GEM_TSU_REF		43
+#define GEM_TSU			44
+#define GEM0_REF		45
+#define GEM1_REF		46
+#define GEM2_REF		47
+#define GEM3_REF		48
+#define GEM0_TX			49
+#define GEM1_TX			50
+#define GEM2_TX			51
+#define GEM3_TX			52
+#define QSPI_REF		53
+#define SDIO0_REF		54
+#define SDIO1_REF		55
+#define UART0_REF		56
+#define UART1_REF		57
+#define SPI0_REF		58
+#define SPI1_REF		59
+#define NAND_REF		60
+#define I2C0_REF		61
+#define I2C1_REF		62
+#define CAN0_REF		63
+#define CAN1_REF		64
+#define CAN0			65
+#define CAN1			66
+#define DLL_REF			67
+#define ADMA_REF		68
+#define TIMESTAMP_REF		69
+#define AMS_REF			70
+#define PL0_REF			71
+#define PL1_REF			72
+#define PL2_REF			73
+#define PL3_REF			74
+#define WDT			75
+#define IOPLL_INT		76
+#define IOPLL_PRE_SRC		77
+#define IOPLL_HALF		78
+#define IOPLL_INT_MUX		79
+#define IOPLL_POST_SRC		80
+#define RPLL_INT		81
+#define RPLL_PRE_SRC		82
+#define RPLL_HALF		83
+#define RPLL_INT_MUX		84
+#define RPLL_POST_SRC		85
+#define APLL_INT		86
+#define APLL_PRE_SRC		87
+#define APLL_HALF		88
+#define APLL_INT_MUX		89
+#define APLL_POST_SRC		90
+#define DPLL_INT		91
+#define DPLL_PRE_SRC		92
+#define DPLL_HALF		93
+#define DPLL_INT_MUX		94
+#define DPLL_POST_SRC		95
+#define VPLL_INT		96
+#define VPLL_PRE_SRC		97
+#define VPLL_HALF		98
+#define VPLL_INT_MUX		99
+#define VPLL_POST_SRC		100
+#define CAN0_MIO		101
+#define CAN1_MIO		102
+
+#endif
-- 
2.7.4

