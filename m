Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFE3C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E51C2084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="pcq6w764"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E51C2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbeJDWaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 18:30:05 -0400
Received: from mail-bn3nam01on0040.outbound.protection.outlook.com ([104.47.33.40]:8672
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727816AbeJDWaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 18:30:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+pGG3FMw9mEJZCm1XTU+8qGnxatwFkfFx+NIqS6uIU=;
 b=pcq6w764PHC79Ls93htubxk8ubU/LwUxkn2AJVtyi4/7uSSw4RVb8s7QIsS5lqzZrUHf6jEezB4NTJMLsqG4PJAiWQxfxor+B1plgcuxkmlfEW7M8vuRUtRpcEmMzwgybHv0+PXUiLw/tHIhFS7l0e41jIomvpnOtpXrAHCgoK0=
Received: from BN6PR02CA0025.namprd02.prod.outlook.com (10.173.146.139) by
 BN7PR02MB5108.namprd02.prod.outlook.com (20.176.26.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.25; Thu, 4 Oct 2018 15:36:12 +0000
Received: from BL2NAM02FT028.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::202) by BN6PR02CA0025.outlook.office365.com
 (2603:10b6:404:5f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1207.18 via Frontend
 Transport; Thu, 4 Oct 2018 15:36:12 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT028.mail.protection.outlook.com (10.152.77.165) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1207.19
 via Frontend Transport; Thu, 4 Oct 2018 15:36:12 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:55803 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g85ff-0002YR-Gq; Thu, 04 Oct 2018 08:36:11 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g85fa-0000EC-Bq; Thu, 04 Oct 2018 08:36:06 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w94FZue3030950;
        Thu, 4 Oct 2018 08:35:57 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1g85fQ-00005M-Kr; Thu, 04 Oct 2018 08:35:56 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id D1ECD121465; Thu,  4 Oct 2018 21:05:55 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <bp@alien8.de>, <mchehab@kernel.org>,
        <manish.narani@xilinx.com>, <sudeep.holla@arm.com>,
        <amit.kucheria@linaro.org>, <leoyang.li@nxp.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>
Subject: [PATCH v8 04/10] edac: synopsys: Make return type void for functions always returning 0
Date:   Thu, 4 Oct 2018 21:05:22 +0530
Message-ID: <1538667328-9465-5-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1538667328-9465-1-git-send-email-manish.narani@xilinx.com>
References: <1538667328-9465-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(136003)(39860400002)(2980300002)(438002)(189003)(199004)(90966002)(81156014)(50466002)(106466001)(4326008)(5660300001)(16586007)(63266004)(110136005)(336012)(6266002)(316002)(103686004)(36386004)(6666003)(42186006)(76176011)(2906002)(126002)(47776003)(2616005)(51416003)(26005)(7416002)(476003)(305945005)(48376002)(486006)(44832011)(8936002)(72206003)(426003)(11346002)(356003)(186003)(8676002)(446003)(50226002)(478600001)(54906003)(2201001)(52956003)(36756003)(106002)(81166006)(107986001)(2101003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR02MB5108;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT028;1:n6+iRLvS70orhqzyUu9hGH7RcmUBjOu3m2f5QeqJJwGzmCyweQBOpFlQOP4AMhhOvb09KW7o4b6YNcYDc3w2XO8MsfjstZBBmRiNq9M63bXvX30U9b6kvNOPFx7Fxzlq
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 159b65e6-5b78-44e1-d0b9-08d62a0f1d3a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BN7PR02MB5108;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5108;3:S/IY9a+3LK+8VJ0+KrrnnySUErfts/SEpkKwILx0R7yMOuOk9EdHs0M2SFuMB/WXWEVJySHWPK5emSY55expEEVDapzMhGaaeKmMYV+R5pKIXBbEOqyQfU4OVkL8D5Tw/6jgkI0Az3q+V7LYGtjcSDzFVLwTS1gvd+ZOTKknSYgxlsXyzOjhuv+Z62l246IlT8063epTcqLLkI07EljORZChW3bDwq7ZajRLFupLQ98rWGhKvFIe+w8AsivBo+Ht8IqtIOrtPDZ840020JLJbFwT/XGbouSPC7AU/spKsvVV89/TOcDrsvVCNSIHb9mPSBLAv4qJBpsTfEIp+l/tIVfEgiVU8doL/OpQ0JdKD1Q=;25:e3jmAbVTzAcnfXntigTNsNTSPjaJ4KdKPP1YvXcNdKPud2r9bDIkKa63TqDLWcIAXw+ewKOcrI1NBWaOerpflmhFciF0UnVDDCEQonosfUHg+bzWueC1iSZr2NM1bTG9cdKBhn+yxKfOUTyfzQCdqWPQDyBlkzOKtS+fX45bh/km1rgjmQJSuuYZ5J0hv9DRzg8m6kNJ/+q+q9RELFezC1LU36szA4m8U6HCPtLC9wtlo9gzKEXny6TAyBfoTGHY3wlCmGFbADXK3XTcSPL6DmUwMBE5+v5WwTNUqMC58yFe/kWnsLYcwpvMY+Touu1xI/XBfI0QP62VCoXvMs4jaA==
X-MS-TrafficTypeDiagnostic: BN7PR02MB5108:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5108;31:fPMft8dWWxIDraxQvuoSL0CUQ+FUOgiG44PvFlucpqMfCPqKrfwDXA6wuAYIyOriDFNHlZVdKs3FyMehqKPpNRFAqiLA5GGUhCrC2WUz/t+n+Lfdu+HLq7JcT/soGpiO8JyggMjLyWehjZIKXH7wZ4VNuHNCpRETDKi/NCaAVErYTTfpcqqgX1EqIHmoHjeHAL2jaeD8Mtq5+lp73jwV1GZfxjTU749A+lW/HlVB57I=;20:o92MHZhgPbib4/LZjgp47V4dlqrSePRTn1Xhb22HmTZr67CCK0B2LpjElJJKQUtHvQH41ForJdR2IEvAvnoycGoQpkfF4iegy6YIvHaeLkNOQe4xX49CeUokL2Y6jwbBADITKbS+Yq6/DixyQCKnWv9PMoEXcDXelZWK6qgdcOSAMY6nigak7ogRr3asTdvfb+4/KTBHK/nzIKRf8kPjHqh9yaDh8SyQlbWwZAWj+OXid6gDr+V3S7DRu7xBZGx1sfjDyiSS7t3B3B7mrEZ8rv8GmaMyVX//7j/fCOADzwwvuHGV5w0QF6M3bekt1SM0vnpvQfQ/o9+acSGjtsYcFBYUybktYloqOnVNimFxgEmLVAdXYDewq6kscbqPHyHdcUqKQInepdXu0PxrYGp73LQOz749RvQ2ZwfsYTGhiMJTfLH6utZgSreQpHZFrnXWnAWihGVTE1FHuOvvjerkPzsBjW/wFVRL3Dw95TpHy26efDcgccs1JrFhpBUzT1Wk
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN7PR02MB510811C8504EC61165117560C1EA0@BN7PR02MB5108.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231355)(944501410)(52105095)(93006095)(93004095)(6055026)(149066)(150057)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991048);SRVR:BN7PR02MB5108;BCL:0;PCL:0;RULEID:;SRVR:BN7PR02MB5108;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5108;4:8GGGOqpVGtgb+0zQVO8X+n7fW3RL7IHQMSrWLKJj26bu12fC2PxUQyjeH/4ARo8jooFBAhT/GZTV5p3uHmEMrsjfK6YbsyvwlEkYT8UNoG7fV/2lIrKGf4FRHiIsZe6GSgwVMiASA/ZnDTMr08kxvwe8B2/cHhAlBlfEjmYvbgeusRHmtBHlbWFwKzfnL3I/KSfuYN1i8IWfrNEns0yjZlvR/yJ1pEx9QyZ8IfBUkuMkXjvvQei6wM9noZzXiP4bAnhvD7mvztDiWduDIbOGeg8w8tA2HRyScy4haAD9BledE16NYzONyrjQA8l5ROnm
X-Forefront-PRVS: 0815F8251E
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR02MB5108;23:QPmaOysEb6br4Rn88bSEjnl4EPFCHmeAQrijEf851?=
 =?us-ascii?Q?Ofkm9hZUwjvnMQmjbYQMw9odwoeEEym1Pa2gaTzJb4XW9VIWTRghyrxI87b1?=
 =?us-ascii?Q?Fzn5Qirbmgoco3MVHv/G/qqNI4zA2SMpZb6D9t5IyheZbA6GysavY+Zd2mrc?=
 =?us-ascii?Q?aorLDgZf2Z6OfaQTanDFYIUHuX/JwGZziw7IS3ndk46rfwGt6ZBwpawVQyzx?=
 =?us-ascii?Q?kPpmCHufscectPcrH8S2b/xltPBLkgcsyA7dEzdWHFphlfyQM3z6/HQIhDP+?=
 =?us-ascii?Q?uY2zHsQalxbf8yhGv8f0c5PLGDR+3w+iNBUZ2zeKilZiBDW7gkZav+UhyhQa?=
 =?us-ascii?Q?CDDfFf9lvqI16zRlUT6k6rP1PWiWi43wNudtmPVk7njwlESm+k5DKkJ9OOH4?=
 =?us-ascii?Q?Uj9yoCPOakzVmJKl10l0Nro/VJWeWvk3rJ1X1+fJpVaeni8lhGGispwwu90b?=
 =?us-ascii?Q?WzK9IOBVpILZ1k8oFfquGfxrYJIixwq7PMuuxy5WCbQwRzXeQseyeKNhzIQ+?=
 =?us-ascii?Q?sQrfVL1BTO76nYHBqNyL8xsLuceYnOJuwnf30ilv1XWL+Hshe9lnm1Xxk+To?=
 =?us-ascii?Q?z+0pipmhyPm32YpYlxnDHE423JFugf+X4woH4uOIzb+REOdDhv78wdnwozqO?=
 =?us-ascii?Q?M//K15osllM9YB5O97MuzKF3rWsyRKDJhwkBLpI3VN8x0TCldGttsefY6Nux?=
 =?us-ascii?Q?cA60U4IxPJOpnseEg8wm/OFkNjTtyLqJR/sXBXSAt0CWFmbQno26ToWHwv09?=
 =?us-ascii?Q?rxoMaovVgmFnTBMWbrtSEvcJdGF4d9gw9Ozsh6BZnd0rm0Wbwo9lmyU4pR8Z?=
 =?us-ascii?Q?MMtfD6J68DykbBAulga+Y5Mxm/B8khTleUoJFIqWjKcf3x7E7muVLOQ7g7ES?=
 =?us-ascii?Q?glK1ILharjqugYlLWQ3R6EbGMN8VH1YGrmbhRJvrV3YhQvKlMZO6O/9P5h34?=
 =?us-ascii?Q?yvOudO1nALoYNFTOPJ1V8/WGAud0djrzCUwlgv9YtCEbBRP0Sq0czqk4UL8M?=
 =?us-ascii?Q?gcZspx+Ku5LdwnDOeTUNmTwcTojre4evhWGHJAFWFMvSeKp6/QQRGFWkHfBD?=
 =?us-ascii?Q?IsAdrAqmmMw0cbZaOTXiJ5QKMRIpjf3KT6oMo22yr4cxClxWpnNKouDdPJPX?=
 =?us-ascii?Q?XCVwL0YgQ+17b6vP88SeN1rSMtg+8LmpZhe015UnImCMqt3jGQl6vPndD1e/?=
 =?us-ascii?Q?0D8p9E2qbli6HjTNvx1Hosh/gVodQv3OZInje6Zdn03btzovzH986H/uIbVk?=
 =?us-ascii?Q?Wdlz7O0wN14kHwoUbL4KqOnbiINQZjreScgqQq7?=
X-Microsoft-Antispam-Message-Info: xTgoGnGwxxHpQ5EHAYTUakh8TKsjP3CXG5skjoxyASKZsHyKkn7sJsmP44t9+mlUR6YgVwlBk5PBG0I0gkcN4KsLbHxsHdRI96VkHtNaRONUqsfQPYNfvfvPMcw2tACO5+TWpn+IAkGWFgXZKaTFBS4KkZU+jcr3YZ3jRgrmMIJWeMztimWhiIsJwpsseCqj3GGOms0aLH5Q15Qio5etBXEgkM0JSsKSAXJUGs/h8ETJFS5tqFFAgshnWazaWeXSgeGJ0+zZK/sKUhDZ6H+3mTEbJVvWo9lh/IOQxQIT1tl6J9/pVQxiMTHTnUoN76Cv4kU7az4XNREMhxf5ZoLr13Qdwo4oCdGtbFCpSj+huf8=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5108;6:0OORb8v46SXvtwGfPSfEhLQkJ7n/7O1f2wwEI95aCmhYRDZDfTseBlCj17HuMgNoG2uiYe+BNHtB94OnWhqgy/3At11msVXzTjmlNevHIM1avmk4d8elS/j6nN6WfzT+wq2ytq/3s1hiuOkJYMctnyrZnHkxSOYayX+8pozOrlVr9LMDXxfN7t1QZe0b06+RjaRW9u/kBdKxu/nASigWqN5bCJcUVOxGKViWo28NY5uY8tUB6lDo/HErdOxkjxdo4EUrPgr3oKR83EdeDR898wdBMXOKdD11gwpmnJtIJ1P4cWXI1YOrk03s1kHAkEfDwebMk9pSyxvVfj2qoZeMMqHCz3rOoMCTXA5Z5DwmxSmo5NRO85uI5Kb0BvzKrlOsZ9o9697fW6qPk08eIIVYgLAzXKB9c+nai9EPonlOmXKV8xVgObFcMDgU/6TiAkSM2OHfIg25U5E8tlMWC3tubA==;5:g+Ep1PA7p1bNV25qx6AokFF42P7z93+ePsgc1JhW/xbC86f/NaapZWWMLNFoT+aTTN8akglvErRUsXupw8KHHWIQb2xcgeiugPra3s8qDVqac+sbHh1OEtskqDiTFRRZ/PNGKM/Qdl3fssOARCgB/j3saG4PaDHcgrZgQ0bAsDs=;7:8mZOhhwaLQvmp0omPLZQ111Ti7/EQ0L6bQd5/db9b1gez/fRSOdZLAQPhUwPHU+1/WlOHbu+OzJCVlgHdNtLT/7Avo4Edo/G9yJcqfDm2lR+xJNDaDN7mEVA09o2ZteffvNSKHy/mHl1vf+UAhtErkNS9Ac3gzbeqc6DRI4an6whk+k8dEpnzsVxTBSf2KTtE9hg7i5F3bSwLv4jXWtD0WBT7KhsV+UZsrUztQYoYbeK4s8sNez3di3T32fxMGvW
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2018 15:36:12.0898
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 159b65e6-5b78-44e1-d0b9-08d62a0f1d3a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current driver has functions which are always returning 0. Those
functions can be modified to void.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/edac/synopsys_edac.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 7db5928..675155f 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -352,10 +352,8 @@ static enum mem_type edac_get_mtype(const void __iomem *base)
  *
  * Initializes the chip select rows associated with the EDAC memory
  * controller instance.
- *
- * Return: Unconditionally 0.
  */
-static int edac_init_csrows(struct mem_ctl_info *mci)
+static void edac_init_csrows(struct mem_ctl_info *mci)
 {
 	struct synps_edac_priv *priv = mci->pvt_info;
 	struct csrow_info *csi;
@@ -376,8 +374,6 @@ static int edac_init_csrows(struct mem_ctl_info *mci)
 			dimm->dtype	= edac_get_dtype(priv->baseaddr);
 		}
 	}
-
-	return 0;
 }
 
 /**
@@ -388,13 +384,10 @@ static int edac_init_csrows(struct mem_ctl_info *mci)
  * Performs initialization of the EDAC memory controller instance and
  * related driver-private data associated with the memory controller the
  * instance is bound to.
- *
- * Return: Always zero.
  */
-static int edac_mc_init(struct mem_ctl_info *mci,
+static void edac_mc_init(struct mem_ctl_info *mci,
 				 struct platform_device *pdev)
 {
-	int status;
 	struct synps_edac_priv *priv;
 
 	mci->pdev = &pdev->dev;
@@ -416,9 +409,7 @@ static int edac_mc_init(struct mem_ctl_info *mci,
 	mci->edac_check = edac_check;
 	mci->ctl_page_to_phys = NULL;
 
-	status = edac_init_csrows(mci);
-
-	return status;
+	edac_init_csrows(mci);
 }
 
 /**
@@ -466,12 +457,7 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 
 	priv = mci->pvt_info;
 	priv->baseaddr = baseaddr;
-	rc = edac_mc_init(mci, pdev);
-	if (rc) {
-		edac_printk(KERN_ERR, EDAC_MC,
-			    "Failed to initialize instance\n");
-		goto free_edac_mc;
-	}
+	edac_mc_init(mci, pdev);
 
 	rc = edac_mc_add_mc(mci);
 	if (rc) {
-- 
2.1.1

