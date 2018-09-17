Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F009BECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 770112098A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="nEt5II9C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 770112098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbeIQTMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 15:12:24 -0400
Received: from mail-by2nam01on0062.outbound.protection.outlook.com ([104.47.34.62]:61888
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728057AbeIQTMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 15:12:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uw4+tFmCs4GbBPomUtRqG/zgNkVmjIbd1nd1c1TlvQA=;
 b=nEt5II9CjK3V8A9YsET7EfDW2s/YhBF1D1OeTcfm6FCUjNEB4ULkVQFK9o/TeqkGA4nCH4gjmXohP/OVmHdBy+TXn6THiyYQGxC+eCcBV6nUlYyDi4/zSx4vNUhUZuVKiX8nRvw43aHuB2+YVdkYOTubKnUks2YGzTVOh3D4kzo=
Received: from BYAPR02CA0039.namprd02.prod.outlook.com (2603:10b6:a03:54::16)
 by BYAPR02MB4757.namprd02.prod.outlook.com (2603:10b6:a03:4e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.17; Mon, 17 Sep
 2018 13:44:53 +0000
Received: from CY1NAM02FT033.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::208) by BYAPR02CA0039.outlook.office365.com
 (2603:10b6:a03:54::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1143.15 via Frontend
 Transport; Mon, 17 Sep 2018 13:44:53 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT033.mail.protection.outlook.com (10.152.75.179) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1164.13
 via Frontend Transport; Mon, 17 Sep 2018 13:44:52 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:51760 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g1tpc-0000bR-Fg; Mon, 17 Sep 2018 06:44:52 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g1tpX-00056M-Bi; Mon, 17 Sep 2018 06:44:47 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8HDie09028439;
        Mon, 17 Sep 2018 06:44:40 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1g1tpQ-00054K-7I; Mon, 17 Sep 2018 06:44:40 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 631C012142C; Mon, 17 Sep 2018 19:14:39 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <bp@alien8.de>,
        <mchehab@kernel.org>, <michal.simek@xilinx.com>,
        <manish.narani@xilinx.com>
CC:     <sgoud@xilinx.com>, <anirudh@xilinx.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-edac@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v6 0/6] EDAC: Enhancements to Synopsys EDAC driver
Date:   Mon, 17 Sep 2018 19:14:27 +0530
Message-ID: <1537191873-6582-1-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39850400004)(346002)(136003)(376002)(2980300002)(438002)(189003)(199004)(72206003)(6266002)(36756003)(336012)(478600001)(90966002)(81156014)(47776003)(36386004)(8676002)(2906002)(26005)(186003)(81166006)(8936002)(50226002)(316002)(7049001)(486006)(4326008)(50466002)(305945005)(63266004)(48376002)(110136005)(16586007)(42186006)(103686004)(51416003)(356003)(106002)(54906003)(44832011)(6666003)(106466001)(426003)(5660300001)(2616005)(126002)(476003)(52956003)(2201001)(107986001)(5001870100001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4757;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT033;1:kB9CCGeByX918b5g3iDxusFQfuQ5cnrWOyyyNxxUh14qWDtMIAWpTPdUGikTi2edPa4xOwQ1EVzaYncUaW7aIqn1DfZfYOUiG5PLmJ9/oeE4XXgTPE/t8pJGmuXg9L4M
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 459393af-3682-440d-87e2-08d61ca3bf4d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB4757;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4757;3:A5KgxHPzQ5sYBNo37KzwhyvH9TFkOb19cmT8QwogJAtt10oTACpC1dI1D0jX+0tEyr4bWqWC7X9cx8lAsauRIWUP+5qpP3VY36cuOXbPzU564ZdbylAFDIFL1QauJw9wfZmK2oN8eGtT/fK/8bIWpbaJUFGvteqw0ncy/1KGV+CyqMGvmrZX3KG/w5l3lMrMGNLFdMj3cHxEImPo4uYpAg0n2lYzOylwL6GIJyZ49gwUDldtFbMDLBVjKSSqgqc2AJYP9L1OqcxHcxuu0EPmuq8P9WVvc9YJ9B60jBeGfTfkVFHdO9GCt6KmTe4HtI32u+RLEMNfXiyi6qxXVN3jy8X0whHq+mV15YY2f6HkSd8=;25:dmsdFnW8Sg+5poQl4y3VKGihYsAVIBJYaUtHrOctCFP/f3XimFqMVM5+Rvz6UKgtcFyItzOzNAFXa2oDaD3eL0xGhxmoLKqR33GbnvZxziyS1LYjVflR9rlBIGbfv/Jvgr8YmwvlSaJupkR1kh1sBhVFCESD03P50CWrh3SmyqSlmhxW0r+QOcjUVuibd5h87MoTVoZNRpOcquWYcei5NjrG9aqXbqKveS5lFV7XUwkvrqTA1Cnr5GAZomXnPPst+e1z7Q/VCIayF05XsBCrsasEvhmdUMj60hHicPjeCdtGobi670S0gUbzVpyqb05K/9xyALErt+Jygxvj0RMvWQ==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4757:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4757;31:ONQ3S2CjjfjLMHawwMElkwda6BtXD03w6dPP9bRRS1YhhABhihk+V9en0ttV5teBnCdhal/e6tODWLqb3V7GrQHMTzTNwjgnd9Yh/Wn0GrnEmWQ3qaOxCGOqY6GYp0XMfvXMN8MZnn/dEQDvd6pCVMEuH44t/ifEbQOY/4sIpMRmn3jW6lDxgvppFFQZa6M28E22D0JH591JkuG3yjST9ugflTn+QuHXwIAIoch3cSI=;20:O2o750OeqvJVQTBonOZFhdgk/inRSX+gNDTGa2rTxUCjYRdhSjMONQyOUrQguKhg67lvzmZw+zoknJ+Zx6egkYXyoX1sZJBz0nNFLAoRbk9wtOyG4OQP9ud8bCZuHGsYAqD/14OvCJyQwRVhhlhqSyLhftE2GfFNEvy7ArDunAhOhEhwhNUIV28lsR8VJciG9SapTPjiCOKjGzvfwhwF4gg65LCHqbcTVrKDU5b4/qaKpgdl+9fRYku9LEsG5S2mI0xcyu0ySPRL9YLVJmF0RwgXtbIqpeRm01il4MXiwD2p+hDWVCjSAWXO5LmJdyLSQr5EOrfsGRmZzTr8LaU33R+5jAhCVCXh5vYAJoBTxgFASBJLtiL4RMuSiRHrP34vx6hhvemNkcgj+tFR9Er2bPHAh3/epvwULi6jibY1MabL+n/K2iXBQ5mCIskQLln9i7ST7oho6v1u+9LSWuaiJdyKXeq4oSmh8r54GcfaIhAjbTXO+e/ShKjAaZemvV/1
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB4757CA7813DF1B77B04DA420C11E0@BYAPR02MB4757.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93004095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:BYAPR02MB4757;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4757;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4757;4:/nYYG1hibV8j7m0IYv6unSq73JEvXp241T6ENXDl6cb1yTqJ0NQsjGXPlZbqQo0TewB5JMCMsxiFUT+xLWtCXfGKGKHHdpJe2nMSWwaJXiBl2Oe+mK25n2w08SK1vnMqbEIuQUw74wSjoyC5efP34VwHiMmlvUJrxq8cjxqR7Prl0oAO4OHdQLeCW8onJoKM1ZYoV887tqm9wEjQRYnCStnHv5OlYrsQ5EARgpXuzRDEQeaOd+jXw5j8MzliKUDvCxnwLtPdtLy2qOBP/G7WMQ==
X-Forefront-PRVS: 0798146F16
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4757;23:nuXppJcSREWAtxkOnvvTRULae708eqQIQazbw1U4K?=
 =?us-ascii?Q?XJXkV8Unm8s6vKcTb77I42QJQpT3RZB0P0eYpbgjEz6qMdRBl+wUreA2H9Oj?=
 =?us-ascii?Q?XWZfId9JfWTidU6fgfvC8KOnj5KGfYUGGRDpotFi93CIuyGWxkVYXbSvG1wx?=
 =?us-ascii?Q?WSe8td8eUzLe+5VTUxrElw3DuGy3Sl4XvBNcYKPlToUCpxVNd+wuv06Ge09d?=
 =?us-ascii?Q?4xD4pNTfo5XmYdHBq6G4/ue6/lXZ+l+KSD+YRKd8Z4OQs+NbVqFU7dikqqwB?=
 =?us-ascii?Q?rOM8uhMlR7mhuLMYuYKWjxHy2KdXg8O5SVXELVMd1/3UFRDyFKqRXm4ggLQx?=
 =?us-ascii?Q?zZsBP08y4M0DgD0fOkRXoYvrk+EAzqlphB2ta/azn2yCZSdxetYjDf2HpqCM?=
 =?us-ascii?Q?Ujyrkw7IZMs9D0F2xp4cjKwcwnQIHV/n7J+ccln6T8+lFZPco1v7Zak4WKqL?=
 =?us-ascii?Q?Z+LrZrcm43lfUJX1t0/exUgbxZIzuMQaCu9hyUMm9VsR/xno+x0uSUi1GNK+?=
 =?us-ascii?Q?9MLWnJGUYC1Woe5D2RIyqAnwfqx48bBI0ar+tBeFmMTT+6PosBId641UxEFi?=
 =?us-ascii?Q?d0sZeELm/NjTVLAYcVa7wWKAMhv1ANQAYZhRcGa0G44cekW1ioqN7yxrESAt?=
 =?us-ascii?Q?nbCPyA72lh9J7KljCGX7UJBNlndSnasHroWq1eFVr9Adwz/E4R4AXrFqCjHh?=
 =?us-ascii?Q?9nNUvzngrr0gbQrIZnHgKhD1Vp7DhlZWaDHNYSmR5GLJr9tfEQ4ToMPGo5lp?=
 =?us-ascii?Q?ZmfNGy/Q5sRL5sUcbvzPLVNXeI6seY75O3oYYIUA6C2YieKABIcVcm1Ou0Xz?=
 =?us-ascii?Q?PswgkFIM4avMqv57AxzPHxvEEikTnYmMD02DHwP3cEeyGE9m3wh7J5l9f234?=
 =?us-ascii?Q?EiQ+Lmyg+y8XcPgdqSqhQ0MJFGdeHQjXXJXWILAoKouilh9vj0grjUxguLZT?=
 =?us-ascii?Q?iRezymefqRjQnHX9aMST/yiy6osXlQReo2on+u3pLaTq4Az0vnMijf0SxSLl?=
 =?us-ascii?Q?oc0LmLMTyymXLZsIUd4DoxYq3efBSI7C28nDQKZ/th4im5G69SpWq3+py8Ne?=
 =?us-ascii?Q?tDD9Hin9xyA4GUD4BbyIsDcEzb354eb4X4ga5NRozjnsaWJ48ufhFFVabNZy?=
 =?us-ascii?Q?Skyne3NdGLLw7hKXr/52DR8Nkf7k4vSioG6H800DXZT8TLd9gr1VgKh7n+v7?=
 =?us-ascii?Q?vopIjReMhiCdqQ2ytPB7qIlR/KhN2TbYqxd?=
X-Microsoft-Antispam-Message-Info: YIfWVD/fJ7x0VzDmAl+E4TppqxuX6P08tPdRixGcJWWKstrDZAhPeGl98smJnX2RMF8is6sIVlQXh4TxIqRbRZh5PH9JNAFEyTh8xagNzwPuD/jI8NRXYVFNJ/RLtHDNNr1zie0oSJ68WdwJKk5lnuUbbioZpViM788VO77x+rOzg0L/mJI5zk8+KX+UoUAyKXtQCBnDFQqlKBn8IAHoXqeJGnfkklxtD7B1fZgvTSuh96mC38ng4gVCisTQTGST3BTrK20Zf88U0yZJ1XwW13gAXaTfac15wWaA3siMUuaoN9G18nkjSh/1vlMP6erht1EDUUk3k3MCSeR+xNArzAt7dzpGdImVCzrQVC1sfVo=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4757;6:1MRGIcz+FHquZopSe71SXlFBteNQZdfHXExHAGSv47JPfB8Z5HRzZaRY3pBWLbqzwVd/jcEjtmuy0AhpzsIJKfKc+xs3hDAul9W9QVjKxXvFixDkuEynZjng3PkdMdbsuYLnWzxNbdxp3ElCB27bN7dSTpLIYIy4siHQAkoejEd1SmsPCAIg3SBWP0wYoaoilZ0TPl8LKD3/526jOmi2V/SQtxF59gTsUIELGW9rLABX6idPjK/uIy8mP1royTiKmlcJNwgcuONTmyMFsOFGW5ZRcFLY5v1QmVqNO38qnKi9FM2wIJVcZAmncUM7jkd8nTSofao+kYR5isV/B6aLCL0Ldqo0rPnt25O5rnV58q73oNE1pVDJb6xM1+vGOViYZy7s9u552yAwl3NgkmEV/y6xqmlQLkxbRNLpcCxYZw2KJ4gjMMKENWIvfma+Wj0vkfLiNkpfY4Df6Veo4XZ+qQ==;5:MIlC3D27aYL9rMxUhCj0FuLq7dODy4UUddK9fZWtr1kDmUElRAw0H1WN8M7ggLHVQtWv/hEoyZ7h0KD10ylHn8MwF6yWuJWgzmE3A/Z1J2mldRdEXAk/CziZfZ/uGSV8GJ1MqsrP6/guRvq8sQ+xwo5SueMgpAJApdfdIopem3U=;7:aVVgsYStUgEjtZc0HJS0jCWKWqGFblbPPCvKxbR1N/e75JEerrUSbTqarGk62sOTLf2gVpsFE1Pl76DCcrsTkqZ5mSvCRZXrX8ef4U0GMwrMggPJz+199NBHT2Hgv1ZRVgDt76reXkVi4SRftvvZZWNRabL0zeGqsAgp94IqBKJywHG9tB9VMeH6QgQpq7R+q8et0/UPy34NAAmpJMYewZssZSINe66tOemQu/a1L8jiTNkkoeHAnzC+MlxElF3o
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2018 13:44:52.9592
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 459393af-3682-440d-87e2-08d61ca3bf4d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4757
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series enhances the current EDAC driver to support different
platforms. This series adds support for ZynqMP DDRC controller in synopsys
EDAC driver. This series also adds Device tree properties and relevant
binding documentation.

Changes in v2:
	- Moved checking of DDR_ECC_INTR_SUPPORT from (1/4) to (3/4) as it is
	  a feature of ZynqMP DDRC
	- The Binding Documentation in (2/4) is modified as per the review
	  comments

Changes in v3:
	- The commit message in (2/4) is modified (Synopsys EDAC Driver -->
	  ZynqMP DDRC)

Changes in v4:
	- Updated the commit message in (1/4)
	- Renamed function pointer names removing 'synps_' in (1/4)
	- Shortened unnecessary long lines as per the review comment on (1/4)

Changes in v5:
	- Updated the commit message in (2/4) and (4/4).
	- Removed the unnecessary check for match data in probe() in (1/4)
	- Some Indentation changes for better readability in (1/4) and (3/4)
	- Removed repeated code in (3/4)
	- Used 'zynq' and 'zynqmp' instead of 'synps_enh_edac' in function names

Changes in v6:
	- Splitted the patches according to functionalities
	- Addressed code style comments from v5 review
	- Moved the Error Injection to CONFIG_EDAC_DEBUG mode

Manish Narani (6):
  edac: synopsys: Fix code comments and naming convention
  edac: synps: Add platform specific structures for ddrc controller
  dt: bindings: Document ZynqMP DDRC in Synopsys documentation
  edac: synopsys: Add macro defines for ZynqMP DDRC
  edac: synopsys: Add EDAC ECC support for ZynqMP DDRC
  edac: synopsys: Add Error Injection support for ZynqMP DDRC

 .../bindings/memory-controllers/synopsys.txt       |   27 +-
 drivers/edac/Kconfig                               |    2 +-
 drivers/edac/synopsys_edac.c                       | 1098 ++++++++++++++++++--
 3 files changed, 1007 insertions(+), 120 deletions(-)

-- 
2.1.1

