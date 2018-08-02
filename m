Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFE6C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE2012150A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="c/6PR5xd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE2012150A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732407AbeHBO0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 10:26:25 -0400
Received: from mail-sn1nam02on0053.outbound.protection.outlook.com ([104.47.36.53]:30881
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731447AbeHBO0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 10:26:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9qoUpOg9ZO9st+BmqgvKZw1O9Rbwkwlel6/FXDGjqE=;
 b=c/6PR5xdMkwSf1cXNkXJRFPqCpLC/Nstww18GVrHNZnHbdHCefH+thLFITUZIUHv+bIcm7S5AVSyS1IHe/AYBp8ZQe0+c11Zylh9CCbCS6ImMmcjKPnfWCCq4z//Ob/tGdgjMcNXXk8WEnIeFiI8r2LfOdNCjdItMlVjCQOOE3w=
Received: from BN6PR02CA0037.namprd02.prod.outlook.com (2603:10b6:404:5f::23)
 by DM6PR02MB4457.namprd02.prod.outlook.com (2603:10b6:5:29::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.15; Thu, 2 Aug
 2018 12:35:22 +0000
Received: from BL2NAM02FT031.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::207) by BN6PR02CA0037.outlook.office365.com
 (2603:10b6:404:5f::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1017.15 via Frontend
 Transport; Thu, 2 Aug 2018 12:35:22 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT031.mail.protection.outlook.com (10.152.77.173) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.3
 via Frontend Transport; Thu, 2 Aug 2018 12:35:20 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:33617 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1flCp5-0001lz-VR; Thu, 02 Aug 2018 05:35:19 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1flCp0-0007PR-Rc; Thu, 02 Aug 2018 05:35:14 -0700
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w72CZ9sY026583;
        Thu, 2 Aug 2018 05:35:10 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1flCov-0007O6-Il; Thu, 02 Aug 2018 05:35:09 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id C51AB12144D; Thu,  2 Aug 2018 18:05:08 +0530 (IST)
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
Subject: [PATCH v2 4/4] arm64: zynqmp: Add DDRC node
Date:   Thu, 2 Aug 2018 18:04:48 +0530
Message-ID: <1533213288-8771-5-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1533213288-8771-1-git-send-email-manish.narani@xilinx.com>
References: <1533213288-8771-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(39860400002)(376002)(2980300002)(438002)(199004)(189003)(50466002)(336012)(305945005)(426003)(11346002)(4326008)(5660300001)(446003)(14444005)(48376002)(7416002)(81156014)(8936002)(2906002)(6666003)(8676002)(81166006)(356003)(106002)(76176011)(110136005)(72206003)(50226002)(486006)(107886003)(186003)(51416003)(103686004)(44832011)(63266004)(36386004)(575784001)(476003)(2616005)(47776003)(54906003)(478600001)(2201001)(90966002)(316002)(16586007)(6266002)(126002)(26005)(42186006)(36756003)(106466001)(52956003)(107986001)(921003)(1121003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4457;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT031;1:lhZ1bUL/oHEqJKKx8+8S8W6v3/gRPrR4XqZdRvro0K4nEPuOQpuoy3EhA5MYVal8m6NyHaeVNTqs9SlcPg7DU8CZZZ5XuCDV8niIfr0KL3kMke1TN81hEoBAaDYaT6cL
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97cfe674-59d6-4cb0-8e17-08d5f87469cb
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM6PR02MB4457;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4457;3:JGh53O95sKIOgpWGyfHx4wz6nE9vdfHuLDnWvK+AOdnHu9EFDMNo2mx++Iymwq/IrZBR4+CEFzoOvchTCXs/0wn8roSl0MPkXDDH7svrEEZ9OWAqMrYwTod3qZOZXV/BTfz1S4K7MAWUp+f485Gxv9Kp/KrgufV4Df1S6sdjY8nj7jjQ7sH5vVdTVWuRrV0J8jKntwwbf1igo7kfT3hDeE0u4Xj+f42s0oubrpf/yqtWOv3+cOBVg8xuDqeeuj5jTgj7uaphTBbnbrcdr8wQfVLHiu5c3nXUw3CYFmZXXXcC++STJXmIztYmfp8k9kfzPGNlHzf4LF+/U/AfGCj0hrvZ8DaPhp7Du+5zheTCZtI=;25:Q7qm+8Xj9qX66SH4M+60YfZGYXtE2hsHgt30a4lwKh0EgDZdt8dLACAhH1V2M83J+toBK1DIX6xXOZHzH17b/oFDG63I2Cv3imilpJhDxh1JKZXtlvjL6idtJnhQwS8KldJY9x2kfwP3es2BFYQbuZQI9J/0X/elsBnCGZYryX+/0lW8zuxAKIoEBM2ccGsBIXxude4VxvOszGolxq2bZvC2dspXEkNxdh4v3BfLzDMNX6GZ+HUAVlKix09n+PDrnNb5QFSNm1fnwvB6MNy57udA1Upt4t45ZTmCDc5tpsuhjAC+/m2AKyG088tOimvjAqny8iosIB9hDMzKZ1S/0g==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4457:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4457;31:CIR/2/za0wYNlWq3OvEcvcQGG50kYaNVbb5Jy1l5CkKpUiwLw2L2bnPAoBJ8BLIiaVjwJ0A6WNwo62mGT4Va+jpDCQEb3DHQ+G8WQ4oaprxKlvZ+ZHqz5Hf2r4jaD4Xx5OWQzbp5KJrgrv2aae3JW/TnHO3nmyr3NNsCMzJSY20E1BTxhiam7GXO6V6PTxKKnqTlLZcEoqP52lyiojtKinVH3nctwRkmHOm7MDjNS5E=;20:hS9WtMj/zlPHmlxiLQE5Qzuh5AZNG3CsRmjkGRHWUXBZgJIjfETXo88XzgaY0PFYR/jXLpUOkYJzY2MT8/ZZh4k/yXCdrCf9hcsJjGjUaXgdGzBsLI1gTgrSkzzTipVx0B7PJC7i9feYnndSOjm/KV1TXMRhB6zRgEZuArIANAsB/HxRE1gum3Nm5DLtPqTrcSelVtXlduXGI0ThS6hyJymdQUALcCXXLNE3DDFNa9zySlKP/F84GDtAgU52wlApmfeQk/QGCKna3tfmxveIM9Devi/iAq0sQpjmOv3X2HJ4QgviaAlVQcUHx5OK8mGUEW4LyyYyVMWQwd9I+p47c1B1A61V0f2njzQvf+QKkLe9ChGL8p5/T26YmoKwC2dBDMhYwbOzVmxLmwqDuOcgUDtZIs8aQ02Ib8LhgZzz6TjO7N/qHXRcE3JUL3tmSZtxppn/iN8U/1X2AVhb0az0cF6pU23y5kVtEfKF2aRrAYyFcRu/kqebTtBh4pEHUEFY
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB44572391722125E11EBED714C12C0@DM6PR02MB4457.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3002001)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM6PR02MB4457;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4457;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4457;4:NmDl0ZKqx8ekya5ZCB7hV1c6FQrcjDbKJZ3SqPhwGuHXfSjT81LYhM3nKeOGutu3ZC4s2Lp+eCoAnZWMrQ26VcRDIVqPYl2VlCVYUDH8ZZOxqVH4QaToGAKQ9m7r96eWFtS84axDJsZwBbbW6PoRPEGJe2NWx9hXAQb2uHsw2liGN3FBCVQhsC1F66VRmE/yZEfzYwF5yusWsRleAZudZBbMZ5XT9VGYyi5fOVBfWnZCpGC7gePL+7NNj4lS66M+u8mKyABvHNl2Ym6qo9W5s+A4FjZ+h1WyeX8UTS1oXpkXwQdGFUGnn5M27sU7v8wu
X-Forefront-PRVS: 07521929C1
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4457;23:uJFB5Ln9GkbtTgH0eMYW7oWJmpyslKYkgsY0dSwbl?=
 =?us-ascii?Q?y28sS1Pa7sFNHDqnVLWBg8oyfsEr/yJOaodOaeEA5OIHO0jQj0mzjqRr78a7?=
 =?us-ascii?Q?BM0comJBQlSdbRV6H38GO+taKkDM6X45f2csRP35emEDlvVvyxoEeqOgRX3u?=
 =?us-ascii?Q?bYOo9lFRi+imTZKzjgRjZbIsGvIAgqChrXc9TfsC6UT2X122Hib6EnuNR9Wp?=
 =?us-ascii?Q?p6Zu1G51Oxz3PHAnOz4uPw/98RrNk0Rmm+Pz4yTXhd3i1tcjsqaCKmsp6oPh?=
 =?us-ascii?Q?cp9dOJnH3pOYNBPsbzw05QQDF0E4/MeQQ2+WhYW/HzK9Clj0w77G72/2bq9c?=
 =?us-ascii?Q?DdGAUPw/k8eoLAqfDbEG+AEwLpzTVAXPwvycTEdQMcD1VVMvMYBfZXe4EqCe?=
 =?us-ascii?Q?RjAnjC5PmqVzc7B+VmXtJfk94e96thzHEXwItdWigUNoyBqf+yeAKnSo3ysX?=
 =?us-ascii?Q?vygRwZV7ELLKahP32WoAouOH814CjgE4hBqrKAwuFq7tPX03enWn5mYofUul?=
 =?us-ascii?Q?TelJPQqHZtTGob43GJvWwDwOFw+xNr/NA6+z/yXgBktBzvtC8knUegxDAzFc?=
 =?us-ascii?Q?2Rmgq/ZIXn/e0L8bd349XRC/eDzuu/oIGMD2n1iZpmkEEo1cIW1wMfwlELM9?=
 =?us-ascii?Q?2LTjn5cGiW0QyU9YPlITFmVOyItUJjuZmHvORmX9L88JYQqXyoqi+KDtSTqC?=
 =?us-ascii?Q?rT+99kgRxHUmFAU+BGPFhUgE68h5XnC0WaG4oqrRG+rwvftVpZR1a1lJAkRy?=
 =?us-ascii?Q?Zl1tRQG74SqcHvyr0E7Frfk4kMmjer4qCcNPum1fJzvC74nUEayJy6YDAN+7?=
 =?us-ascii?Q?xm6cIuFOHdh7FOiysYFtkttErxgrrJ1Azbby5ZsVt29XReDn6OlrJ+fpNUJJ?=
 =?us-ascii?Q?mX7zlrREqxv9iRvKNBgm0w11lExGhLk2sZLFHlqXiMJEoR/EgsO9RJkjc7Ns?=
 =?us-ascii?Q?u9R64s7rDKp7Z8//inssB357ioSbHT5JdrwuIn/v7nkzonplvIKQGectuCm/?=
 =?us-ascii?Q?M7eTGUfSh3E6IW2UAPKFcv9ULLj+G455T9WmsURxGOOj+Neja7e5V7gUYOMB?=
 =?us-ascii?Q?Nv9KWKUWmfTA3FjhCCVBSnySTcBX894Jdyx1PSg20n1hg+aJqP2Xcg2B+tl8?=
 =?us-ascii?Q?UaEeq4nNDvJnT6xOw/JS/O3nhjHrGdfSte6iRhxhMMB0drerKoBKpTNwyB2M?=
 =?us-ascii?Q?VMsytyqmoBAYNcMaTjxXMVoCIgOLzDQ2KvD50NPQqUWPfaFH8qGJMGKpPg1h?=
 =?us-ascii?Q?Cdde77mmwxfdNYEGujyvzoGr+MaZNvWUyb/uxGJthGflgB90mLcVRxyVCnOP?=
 =?us-ascii?Q?W7BN17xkXrNitp0Q6ZAhFI1PQbU5a8pQoICKuNVOd0e?=
X-Microsoft-Antispam-Message-Info: u3EUtoYMQeeQ+vx+B6O2wyXVYCrs0ez4QW5pd3NC55rWFqOK/YkClh2jGuiL0ETrfBxrjmVwq801vw/CBk4cAZkB3+8XUyVUxP5UQkXj34dOBrdrIF2zJtzGFT1KsBDjuMlls6EqaBenXCHiNhaiGeHfJdUQK8q0ZiTFNRpmjgex6kHCuRAHW/+EoRjeS55YtROfNXrgu+6vCwr4jVS21olyS1k6iufMa6ABaIrZXG4kqzy+ixewW8mszZF6dPorFmNsFFxjpWndRDuqtbrUflqJYxSwqRtkj0QtYHaUz7A1Dv/aPpzq46s264qJNh568B0o9sPuIQjCo8NThbUss5dmxKFlQt97GHEWW+0eCpU=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4457;6:zFlOs7qHUR+dZg7sNrlcbVIUCmhRzVNMtyk16Iy2oBTQI8Jf8Fx8A1X2KHn5G0QG48Dk0SRllVrckwJxkBusHX/7CFs0TFkK4R9cjT3BBWrGqksa/b2yk+lXcmVw4gGN60wqJZoG6KUeYk8LPG8JZYwoDeU/VL9OsvebjB2ebigz+CNgwrU0z2kmmYMD4fwfsdBUiTlsdf8+WCi5QciBoqHfatmKUWC7BtdVWeY/q9LYMBtytOhu7110GAMQSMAee18UvLAxsxDaFDdHoarcpsIfq0wb7ulmOal1di+IIlS4ni8/IojtMpDz0Nk+OU1v48Q1+yTHEqfHdKxbUKQyaGGkHMpXV1kly/vjTYp8bH2OsIRMmaAJyWCDJMGoHnZAHwFtfOVaHhq4A6qG0N17IjiGKqol6kp0qFrr8mGsN2y7jnmIAAEGiSHUqPgBtkn8PI58uLjLz9DMobsUT2tJDQ==;5:SXzcRXGeyJWGlDlgRBCfpSSktthpfbfohLjsjLod35/NPNcmrWmPV4u0x+uQeVCulB0c0BJkb7FkxGKT/fYgGrMiQLMpuQdNP5GHOAnfbZFyaWir4g9xRKqX1d9evKZ7q2LniwY0Z3c9srRGEXKk6IDcUTkUfMlwPkR+aSGCZjM=;7:inIiHvJgoyfGHjbQkY5WuW7bH/1yIkBSbdTI7gLoPvPHHigla04FI/O8U/8bnpOIVk2SkQKHz9ySrqlGiklq/AzOGDjSeRUMpLD3/fdQcoIQ+ArYEfhat0U0r7mXHMjSw1DHZm0NLkU4IBz5Mi+pagBBPK47CF0aVjnmSo3nkZE8c8o5R1aedb739CjwO/CKsP8xBf1mN+NFcfV8Kpfcq97VaPNg0c/+h3iOXPJmV822w5DnPeRuOVqDy2Gm5OrL
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2018 12:35:20.6854
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97cfe674-59d6-4cb0-8e17-08d5f87469cb
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4457
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds ddrc memory controller node in dts. The size mentioned
in dts is 0x30000, because we need to access DDR_QOS INTR registers
located at fd090208 from this driver.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index a091e6f..7d6a3cf 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -355,6 +355,13 @@
 			xlnx,bus-width = <64>;
 		};
 
+		mc: memory-controller@fd070000 {
+			compatible = "xlnx,zynqmp-ddrc-2.40a";
+			reg = <0x0 0xfd070000 0x0 0x30000>;
+			interrupt-parent = <&gic>;
+			interrupts = <0 112 4>;
+		};
+
 		gem0: ethernet@ff0b0000 {
 			compatible = "cdns,zynqmp-gem", "cdns,gem";
 			status = "disabled";
-- 
2.1.1

