Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7994ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B15020852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="hsI3G7uX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B15020852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388554AbeGWQET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 12:04:19 -0400
Received: from mail-bn3nam01on0071.outbound.protection.outlook.com ([104.47.33.71]:19040
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388410AbeGWQES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 12:04:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVS7GIumw9Lm6ZF2J9HmrDyoMZhD0vLIZvTS279xsZM=;
 b=hsI3G7uXDmv7iD1IK8WKK29EOt6m4ClUAmrW+MXP8+ueTq1g3nhIsW32KZk6PICfSki38ufWwFKNpsQPr7VTcYpdvQSiOyllnwu0GBghSSBBvpWzkRePMqQNduZnztoNa3K734eftfWTeAWUYv7QolPIi6GY6Nf5QSs2hLdj99w=
Received: from MWHPR0201CA0002.namprd02.prod.outlook.com
 (2603:10b6:301:74::15) by CO1PR02MB094.namprd02.prod.outlook.com
 (2a01:111:e400:101a::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.973.21; Mon, 23
 Jul 2018 15:02:38 +0000
Received: from SN1NAM02FT034.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::208) by MWHPR0201CA0002.outlook.office365.com
 (2603:10b6:301:74::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Mon, 23 Jul 2018 15:02:37 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT034.mail.protection.outlook.com (10.152.72.141) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.995.12
 via Frontend Transport; Mon, 23 Jul 2018 15:02:37 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1fhcM8-0001BX-Dx; Mon, 23 Jul 2018 08:02:36 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1fhcM3-00006E-AZ; Mon, 23 Jul 2018 08:02:31 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w6NF2KFj002955;
        Mon, 23 Jul 2018 08:02:20 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1fhcLs-0008V8-AR; Mon, 23 Jul 2018 08:02:20 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 65327121473; Mon, 23 Jul 2018 20:32:19 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <manish.narani@xilinx.com>, <michal.simek@xilinx.com>,
        <pmeerw@pmeerw.net>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <jic23@kernel.org>
CC:     <anirudh@xilinx.com>, <sgoud@xilinx.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>
Subject: [PATCH v2 3/4] iio: adc: xilinx: Remove platform_get_irq from xadc_remove function
Date:   Mon, 23 Jul 2018 20:32:02 +0530
Message-ID: <1532358123-23485-4-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1532358123-23485-1-git-send-email-manish.narani@xilinx.com>
References: <1532358123-23485-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(136003)(39860400002)(2980300002)(438002)(199004)(189003)(8936002)(81166006)(54906003)(103686004)(4326008)(5660300001)(81156014)(8676002)(106466001)(110136005)(106002)(50226002)(72206003)(426003)(36386004)(478600001)(48376002)(16586007)(50466002)(316002)(42186006)(305945005)(2201001)(63266004)(36756003)(2906002)(14444005)(6666003)(486006)(44832011)(52956003)(90966002)(126002)(476003)(2616005)(336012)(51416003)(26005)(6266002)(446003)(11346002)(47776003)(356003)(186003)(76176011)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:CO1PR02MB094;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT034;1:BSuX7EvV0PGq44SmlxvWGq8O05P0ekAcNwlnEaHpws7AOb4UlB48f/TIdVTYjhwnw4PSp6asvTzNwvkKt0907+pzEGHeonG8y/OJTeyF0Im9Csgjjn/KiMsf7Q3MrjdS
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 302f0686-fb53-418b-146c-08d5f0ad5416
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(4608076)(2017052603328)(7153060);SRVR:CO1PR02MB094;
X-Microsoft-Exchange-Diagnostics: 1;CO1PR02MB094;3:B4viRlo9cxgnIOIhVmIM6MfngpCBUYqpt+D8gH0hcZwrSVYOv4cJRpklB4EU7uihkmUqa94W2+pGcZZ3bqTI8ftgsyg+kd23sJrwMi4yA18Jt2GykKOpzeg80sO5AyYzuKtPj1o0v//Y/mpMJTi6yUG4YYmPpht/pHedNI2ekDv8NqKrYrw4u9LhOUss3qfDoSbf1kpy6ud7qF3E1YV0MOrSR3WIVM0je9G37nwRH52o2mGm9/9KzOB8+Ciko9pOqZmoH4ZNty1SzQsF1GhbPopFU6JO6fzvKnvfv4NCrhM+7Zqo43F7/nV2eLhkO5DJesAbIjtEtp+5GrS90tO6M/rOS4V3ZGg+mg88DjzTagQ=;25:EPb+5zLbwuvrRiAkYKmNLw5D08HwD7Cbvcr6v6pbML0MmsFmL3xy536yoqM3bLqZ+0AZsovMDzsOn0UaO709UQY0lWfaPRHqeyeQKUYHescpYp6V3SumnNmuIaaTWTNF06IHqoSytXl7qosBf/zHwd1XVML9r4TXVcO8LKvfnM1/QJUdZK+1Hem3ZKsdQK9JvDAK69DKoiU5SGCnfDXNb+STVh2gml5fO4idoYIc372cU6hx/YJNwvThm3K9ouLKaZ0uVndWfbUiPRwYff3FrxmfbSme40NiNRJTcZGGl1w4186wUqv0peiQTMlrBXJu6p0QEgDbhpHeZOMgRRZcGg==
X-MS-TrafficTypeDiagnostic: CO1PR02MB094:
X-Microsoft-Exchange-Diagnostics: 1;CO1PR02MB094;31:hFkWWKmoPzla2NZHqnqHoUbvZVHxo/YbvyBHbpUI1vRMBkCsY/roVJpfFfGiaO3DRbzYLzY6rwzAkZ/T16FcDeLZYzSdfaZIUpwjFOZbcfmWlStPvNMjoL+hJsWl5thtuejwWv+tla+85f9kmi9ZSB0Mv6RM978IjI4GyN7lGMQpdlrNdQkyYZxFOv1aQtSXU/BGdlx0WXErZmf6OKliJjzGz/J1SdfH+lzubKXOZJk=;20:zCy+Qi8gSoUZHYO1UnHF0xXupI5WtFSpvzkSg1LO0fwKYdS/uHqGRDvjkSVBXtCZeRHsf0LJulEFJMH8cW0DpfSDn+ROV0kxD8AR4Xx1VL6rB29BZd6vqtN/zZwqH5DQ9JuZmMOvRDkL4wHa47u4G6jd0Zx134nMhemNeHvzWChLMNcbTLEkzvDB8+cI86eynejckl0mQBX1fvqLWciq69IbmDgHbHr/2tC/XdMKR2MgoEwCXF4MvI3EcynGKhAK8T+vuuQgGexw3vTm8JfSXZBQYIX/lrbWNJAyM4AHniUtc//S2gA4n4MyRxVSzFlwIa14+/pCELP7Z/pwHVakg+dTApzh7cNYta9kb6299TW2Jt6MO9zcY4q3TEV38bRaoETW1XWEjBx3DC/v2MK3cnePwVVgO04z+0avicDpgyKuCfBrSqdTdMzDNP6GeRYyp7wTQtkF29UYu29uspIkN3T6Hy921MNa/k5GEVzpznaCICJZdtI2B76fcEX1Cyqd
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CO1PR02MB0948DC5CC01AA1690A6E8E8C1560@CO1PR02MB094.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93004095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CO1PR02MB094;BCL:0;PCL:0;RULEID:;SRVR:CO1PR02MB094;
X-Microsoft-Exchange-Diagnostics: 1;CO1PR02MB094;4:won8WF2qujddC3O8PL9i+EpagOOjVFhcJILSGUPVlkE1tILpfobXiUjxrhtR8gGRG0tdmyDrHkiP5NIyIwR0ylHZFGbbbY67UaJMpqVrYq8yH5cmBQ0zuPwuzAe4DczwIg5fQehtGnAGw10P/Vpp3aEjKRbcEzg8EbtWY7Qvk5Mo0GaM75QKiCIF8yz7T3XIASb+nJR5AVXHYzCpdLjO6QiVNUt9eRkQoDF0BL1Dc3dVxg3zj1uitNQwDGfyAvjlx4qyM1HF1DiDU+KpkT49YZjTA5WsMJ/OopHEoY0BI/FCfllTYvjW0MsrCBTNawI9
X-Forefront-PRVS: 0742443479
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO1PR02MB094;23:UcxGKWKb/F+TJ4168lvPwawLOF1ou8Qa1qfifngmnV?=
 =?us-ascii?Q?o0S8jpb6IhIebKZzuws0wMK5F4FAtEDTmeDtmhfWcUZgCvpNzPptYjL+DDFl?=
 =?us-ascii?Q?qJUXMDyv1iXuck0krvE3LuwSDHCBaWu8Nv+8UvypgAAW9tOtNWU0HKXBSmWS?=
 =?us-ascii?Q?cNNuSMTrArTkFSSYoTn7LC6KXcyLMcpSjLxkwK82bZCPyT7ROZl6io5s5ZwL?=
 =?us-ascii?Q?qDl5Gg3fHBseVmIuv2lrC1PNPAw3Jxm9lv3n4Ion0arTtzGE0XmjpigmVMCc?=
 =?us-ascii?Q?0+UyKKXiBI4mPeqKjhSNWEIKxiz1qstvCiJe8Olr/p6qIM1Jl8fcy0HDUKPU?=
 =?us-ascii?Q?eWqQT5w+erPclK/2hZIbPSrgOwOEv3NZyKD5my93nVdfjloT/m1lrGRGwXB7?=
 =?us-ascii?Q?ULtzWH73+IkFhToOU08NHp8GIs67yMvYglp0BpDpWxyOKKcuZgW5QuovRtMi?=
 =?us-ascii?Q?DFWl2IKUQTVbPkmeUBm6dE1LiuUWFLb0C3frxBdteX+gZup/0bkOjszjDoaJ?=
 =?us-ascii?Q?Fl7fEt2WliCvzDFEuPlY4vSjRjDkkV73R3xkOprdBVx98Jtx8/Zoh6y68eFu?=
 =?us-ascii?Q?+WnEzs3OLOqS4yaEwlFN72Lf20K0ITeZjpmFNIg9AZ/UM3cGQlFbXKBmTdOd?=
 =?us-ascii?Q?fnTm3an/6qpdu6R1vUghzCWd7s76WGOpRrHqE/xTdHmYusm36DklYViBPTrd?=
 =?us-ascii?Q?dj9v60RrI646ANy18yNNaqOnY7mweXP33xYY71/EUuN1btTb4fpryaPKd8pM?=
 =?us-ascii?Q?ByziFbB5TcbemxR8iTd8MEa/EqudTg1plsWtClrsLtrSOWK+qv6/TRyWYTf0?=
 =?us-ascii?Q?IuyROxkY0x2/0xnvMyzBBnzWlFZkMtryxnqZC9sVht2I5zON1XVbtIWq1dLA?=
 =?us-ascii?Q?G6N2YKB1CUvIbxxSQQu/tesRwqcPcRNvppLBTH9JecNZ1CQZlh0eFk5cUZG9?=
 =?us-ascii?Q?T0GSTglFF5as7MV/LnWlsU6F172Zruqrea+TeODHTfvAQSh0cniI3fopBUwl?=
 =?us-ascii?Q?4tvIuKLAY9uihYAzwaOmgd6Mktxt1Rau2IrnorXPcNqWyv6k9cMaxHQTuXkM?=
 =?us-ascii?Q?hPA7pNsLmRjC06DcKRk867UPF1sZN88BUStjlfKHVDP4on2qO1W0mq3R6sBh?=
 =?us-ascii?Q?CO0AaPq+nV75LFdLYWcxzFMCB4AiCnSCBPMYRwa8bgw/jN8z/5OgT4+A1+E4?=
 =?us-ascii?Q?NcFhnVEyobYMyBaFvFA3+jRbYQpXZILGSu?=
X-Microsoft-Antispam-Message-Info: PrVvNfoJmYFf/EU7yqFMf20cUgurymtWpYdj0OYOQoTyoQGUUnenyYQIselDrUUJ48H4lNy9M4Pi6GQvoNIT+DScL16BTfXN2u5uwGmapjRAA7U5tXLJeH4zyU/wjlgUBRS4wyhPKyqUc2xZ+NUK3eWgx3jnnsryVFnZ6J3PS6E/MRHw45JMHzb2NxJzRpBQUmDguBWXSpHaC6IW2L2vOnF/h8zXsW3d6GkXuD9EqrolkcqxeR/bPwVO4mZ6tBdnIMSkp6NhX8I6UCUC/ePiFWRpga0M/2DiyDUYLBKYlXZK0ubOkXGkEGhbmeaYmkQlL3fnCoqbHI3oyGUUBfWr5gThkJPkdNUI8WwvAYR3BV8=
X-Microsoft-Exchange-Diagnostics: 1;CO1PR02MB094;6:SZhAAGu8CnXCEm2Rg2+ZW97XfXjdL4mmv+ZBhDXNLnMhdaseViLU5JPAdYbmCVtYe90bcDKAhjIyU/C+xAKtIZDf0SzxRMbYpZRUQt+eAt4RGyJoN9qcMyxzIEgz60S0KX25MII/e6BbqI06HePENNFLRw+E3UjmT36PDClFbUJ1cbFIU3yAj8+T+ksG6BvHmyjdWgygawlGJ0vDt6a7hRP49Wl1lRYj4CSXqCdAxw14IxIDjJzHVcya4fjtzKkBHrfAWa5f5aZ16K4+A4pCjUACDeaHg+6OzD90Glf6m2VRccGX9GyWzCvKdwoSc8v/PEMQALoRXzLj8GJhP4gPitztGa0AtJO4/oWrFQ/7srF+JgTi0MUhqtws+KcXpJpLns6PQ/uN9ZiLAhIo8zHLmZTsV3EE6DIkbax1z8tsNoO4eufTcTyp4s9P5CHVvgYy+nNbg32A84c4xhVHEf0gKQ==;5:ehHw7nLao0tTCrR9BQjSMlK4sWIGc6Z8b/442v4aHVlELrov/0pewgtsor1K4G6Fkbg2qjflr0IYnDCq+tpvLxMCoVmjyp9wfjtuORbV5nZPTnzjZNvuF5dPLOA6Wwfyz3CwlOtw7yeLoYNRUwQoAF6JewogfDpczVSJ/jMGcBg=;7:rpuCs+Qa6gy2fCpipKxpF+NZ+Bn8b7+vPqY0KArbn2+m17wUAEf3TygOZtW1Amy2zIsvfRW+eu1B65E5Fmen57OVIP9MVXIIOU42eVX2lHD1FbRHY9Dg1UnTyMfYhjRXgIeSxaTpnL6rQ+yDUwPKxXF1TFyOKf18IJw645EKw3h0urLy65vQ6sHwpK5Kv+NVHws9vgfFrkqRYl/WWDFs/UPSRmg6ML+nwOP+yHHVmZSQLwY9FIy7qq+H+CpApQYC
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2018 15:02:37.0253
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 302f0686-fb53-418b-146c-08d5f0ad5416
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch avoids getting irq number in xadc_remove function. Instead
store 'irq' in xadc struct and use xadc->irq wherever needed.
This patch also resolves a warning reported by coverity where it asks to
check return value of platform_get_irq() for any errors in xadc_remove.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 10 +++++-----
 drivers/iio/adc/xilinx-xadc.h      |  1 +
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 0dd306d..44a2519 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -1175,6 +1175,7 @@ static int xadc_probe(struct platform_device *pdev)
 
 	xadc = iio_priv(indio_dev);
 	xadc->ops = id->data;
+	xadc->irq = irq;
 	init_completion(&xadc->completion);
 	mutex_init(&xadc->mutex);
 	spin_lock_init(&xadc->lock);
@@ -1225,11 +1226,11 @@ static int xadc_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_free_samplerate_trigger;
 
-	ret = xadc->ops->setup(pdev, indio_dev, irq);
+	ret = xadc->ops->setup(pdev, indio_dev, xadc->irq);
 	if (ret)
 		goto err_clk_disable_unprepare;
 
-	ret = request_irq(irq, xadc->ops->interrupt_handler, 0,
+	ret = request_irq(xadc->irq, xadc->ops->interrupt_handler, 0,
 			dev_name(&pdev->dev), indio_dev);
 	if (ret)
 		goto err_clk_disable_unprepare;
@@ -1288,7 +1289,7 @@ static int xadc_probe(struct platform_device *pdev)
 	return 0;
 
 err_free_irq:
-	free_irq(irq, indio_dev);
+	free_irq(xadc->irq, indio_dev);
 err_clk_disable_unprepare:
 	clk_disable_unprepare(xadc->clk);
 err_free_samplerate_trigger:
@@ -1310,7 +1311,6 @@ static int xadc_remove(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct xadc *xadc = iio_priv(indio_dev);
-	int irq = platform_get_irq(pdev, 0);
 
 	iio_device_unregister(indio_dev);
 	if (xadc->ops->flags & XADC_FLAGS_BUFFERED) {
@@ -1318,7 +1318,7 @@ static int xadc_remove(struct platform_device *pdev)
 		iio_trigger_free(xadc->convst_trigger);
 		iio_triggered_buffer_cleanup(indio_dev);
 	}
-	free_irq(irq, indio_dev);
+	free_irq(xadc->irq, indio_dev);
 	clk_disable_unprepare(xadc->clk);
 	cancel_delayed_work(&xadc->zynq_unmask_work);
 	kfree(xadc->data);
diff --git a/drivers/iio/adc/xilinx-xadc.h b/drivers/iio/adc/xilinx-xadc.h
index 62edbda..8c00095 100644
--- a/drivers/iio/adc/xilinx-xadc.h
+++ b/drivers/iio/adc/xilinx-xadc.h
@@ -68,6 +68,7 @@ struct xadc {
 	spinlock_t lock;
 
 	struct completion completion;
+	int irq;
 };
 
 struct xadc_ops {
-- 
2.1.1

