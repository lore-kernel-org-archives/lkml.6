Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A75C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 13:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43CF020895
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 13:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ojM9JpSH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43CF020895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbeJMUwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 16:52:43 -0400
Received: from mail-eopbgr680048.outbound.protection.outlook.com ([40.107.68.48]:5096
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726727AbeJMUwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 16:52:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SgdqNPTXSxEY8wz3p0JzQNIuIptOvujNPrI80mICSGE=;
 b=ojM9JpSHvebVrxjfY5N2bLa70/LoKHOf4SbK+KgeFsmYvO0azHk6VmxYrnmlmIAUchVZx6wRV8egin989KJ8t/YRZshNAsN+Y/L40YEeu1NMsvtjBZqG1IK8y5dxVdJjozHo0IJc89GZSs6IR54+LvpBgWMwSHNJTjA+fOcbIyw=
Received: from SN4PR0201CA0008.namprd02.prod.outlook.com
 (2603:10b6:803:2b::18) by DM6PR02MB4457.namprd02.prod.outlook.com
 (2603:10b6:5:29::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1228.24; Sat, 13 Oct
 2018 13:15:25 +0000
Received: from BL2NAM02FT008.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::200) by SN4PR0201CA0008.outlook.office365.com
 (2603:10b6:803:2b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1228.23 via Frontend
 Transport; Sat, 13 Oct 2018 13:15:25 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT008.mail.protection.outlook.com (10.152.76.162) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1250.11
 via Frontend Transport; Sat, 13 Oct 2018 13:15:20 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1gBJlG-00068f-VH; Sat, 13 Oct 2018 06:15:18 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1gBJlB-0007wb-Qq; Sat, 13 Oct 2018 06:15:13 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9DDF8aN026446;
        Sat, 13 Oct 2018 06:15:08 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1gBJl6-0007pN-0L; Sat, 13 Oct 2018 06:15:08 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 8ED2460504; Sat, 13 Oct 2018 18:45:07 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Johan Hovold <johan@kernel.org>,
        Jaejoong Kim <climbbb.kim@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Roger Quadros <rogerq@ti.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <v.anuragkumar@gmail.com>, Thinh Nguyen <thinhn@synopsys.com>,
        Tejas Joglekar <tejas.joglekar@synopsys.com>,
        Ajay Yugalkishore Pandey <APANDEY@xilinx.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH V6 09/10] usb: dwc3: Check for IOC/LST bit in both event->status and TRB->ctrl fields
Date:   Sat, 13 Oct 2018 18:44:57 +0530
Message-ID: <1539436498-24892-11-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1539436498-24892-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1539436498-24892-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(1496009)(136003)(346002)(376002)(396003)(39860400002)(2980300002)(438002)(199004)(189003)(76176011)(48376002)(51416003)(81166006)(14444005)(356004)(106002)(5660300001)(36756003)(54906003)(42186006)(81156014)(486006)(36386004)(107886003)(426003)(90966002)(2616005)(39060400002)(110136005)(2906002)(16586007)(316002)(11346002)(446003)(7416002)(6666004)(8676002)(476003)(126002)(2171002)(6266002)(52956003)(50226002)(4326008)(63266004)(336012)(186003)(106466001)(305945005)(8936002)(50466002)(47776003)(478600001)(103686004)(26005)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4457;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT008;1:DCgLg/HVtQoswAIzKPRuVI8hx9yo+CJWEIjRAXEPTGdaqt1OYZYcIFuOaHup99kW42+6VqAIO7+Vnfh/f794/TvRZ5YvpqY4O0U58E+VqqStyvR2XJci5wHxC9oZprZJ
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 678dc487-2c32-43f7-6cd9-08d6310defd4
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM6PR02MB4457;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4457;3:DN8pmOE96x9iI+oxVB3nnmIHP2e9m6wxQ+t887NttbZ9AU1DaHh2UP60RnuPafGXNMPQkqY7Znfz/Tw9t0ZMp2rUqswnKbUyepqIIN77djNC+UiYRmfngmYErqDAnN6d8O9HO7WLjwhlxSwxa8EICfXrSNKfRN+4a+zoI5l8PKhSPExO8+XzR3m/Uoqrp8CeBrfK6nl0d+Er8fabh8qdMNJw+gLtrRGKcO+Dgqrv/vuGUbg6xiHOCRcZiE+mRM2CL2PIZt2Jx3CSCI/8FRQsGjhtDxbhKn7t9XO/1iOclTcd625nHT2XUoTI3I6vSO/WnnDb3QoKfWrVDm91JcPCZnjSovN5FpmSvLgszDwGeLQ=;25:A2ue5GQ5cf0RgRR2qrJ6TlZ4YvYwX+dyMa+YuwTk+6mFwvlz3X45TbF5qf1SoQHDHhrupw1/LaLR0LD2OVO+qzqdxlEjaU05olbl0eqi7iOcaSCKJ/Dz1GfLRk8vLrwkzyiCQHuFUJBwRlFE5dFzxLJXkwk5aE1CxFMVpnN7FOEuSV3dptNxj3gga+ke5VjXHphsoRfuMBO9yJOv6blajnkM55skPxRqcBu7Yw7/qhl0OYErMZnEeRbyMAp5m5Zrxd+OjPdR8Bn1Nny87MWX1VrOr3Ch1j8Zhjw1a9XXmb/bH6VhDrV6lgSmwy0nFVhVv4qEHj1Yk1FGFbrITNuv9A==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4457:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4457;31:YAzPXh1woESjzSSdjOnbbd1SRB11kUr+53c+0mWkH1x1m8n9qFc4w/yvycrRxMSguLnrCnknzK1erf8hCUBdJzqOdg2RRN8v2wRIiy2OPk+pYc/bI62Mx0vkxThW+tmSPD34NCMnBxbFFm/Asi27SdnXMGOWhlcAjoU8LYX5NOwpCpGEKx2G5t5uuYPbrSOcN7G5VNr9c23vf6mOjkU/Q0rfk6vh/fA8XuICS8Nn+fs=;20:hzruOsfViZ7wx55IS5ioNZALOPxH99U2XUP2f3RPmu/gZ5Rr/YrrT/AxLONokI2rt/KA8476D4jje0rfnYibXOH8BC2cTZfXcFBPjgaLuAHjcVdTzP0bDDLOXt2Z3Wo95ijbhYYtaAvrUmycB64RAuV6TNow4ybKwjwXkLqm3+NCnSK5sN6jKUJqnOpraW2lW+cmQy+anVPNRUEUCht5fCo91wuXqLV0LA2435qGmGnOflMUl2QOmS3C2syvphCsQAWq1Umx3QkzdGfiZq4q2uvPXeou+S1gr0V3TD8r0wZ50GDTwPYO2IJH4p8ujAEM9Ffloc58OLGuF/63hci+64Re2hiU/DzzwIIdbQzKkIh308661Qo72IJPkmGrN2lQLQk4PfrKsPe4InWiaoZXcw8HYNNSOuLFJ39TqYNCdlI9KNntCk0W8PsUFBQ5KA6Nvx2wZoqmyW3EYbg9p4Q/8YhOzRcrSUGO6VLo4/nXaK9Bs0Jgp9XWcucvBIyaEUQ3
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB445792D56292D86302753012A7E30@DM6PR02MB4457.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051);SRVR:DM6PR02MB4457;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4457;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4457;4:YzgBF81j4uN2xI95u2edefvXiFiApIKEdv/BRQwvhjL1z5g+A4Zgp0lqVuRy2rp5H3UD6+0DBeGnjqzDy8a4Ztt7676Wv1IGpoCvbAWsaIgh72hsX8oAPMKcDeGocrXDqh0csntEi7NO/JwQb7gUD5bVBBrj0SB0inB3b8pIUO0NHDq+J6EJD6S0iA//fIdAt4Z3Z/OoVZRP01BjfYY/3tGwOU4WqyTAo1/vPt3DwdUTul5UVrKvJ3S8qjje2XuFeCa0sMvVp6iqpXbVY0KFLDAyaIzhLLvkilAAii+6b3dRk9DU0LitRuMZsT13RT3r
X-Forefront-PRVS: 082465FB26
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4457;23:Ziy5LqhJvf9glAx26hx6Nev4qsHJqrQIH85loXgWC?=
 =?us-ascii?Q?pXpJsnQDefhYBq1x3ffaD6/omTHngpncLdHjh8LeDjBfXNSEkdP4k2X6JCvE?=
 =?us-ascii?Q?bNRe5IqUNnFw5sKZ36CQakfRpBRspEYfQ2FmE+oi0Tqeop+ySNI7Ky887kIq?=
 =?us-ascii?Q?82aHurN3Feo5zcz4IukUVB8zeJp6drXYx5yiMWKTU7eLOI/n23awrGSNC/H4?=
 =?us-ascii?Q?unuOvW7D3MenMKoW1v3p1ils7G37SjE4gCPx5Sowffa9uPULEKdu9an1SPoL?=
 =?us-ascii?Q?JztRcCYxva0YMkhIlPlNEWlpxCEa2kCxsli4BSsBEVkZpLrnWaTAk2Utk7s3?=
 =?us-ascii?Q?XJ+YQa82S0tGOTn9Ys7Ro0klcy8SgRq4fDnyWxw0nFiCf4SrQwQgcT1JnWHG?=
 =?us-ascii?Q?SEfLmkveYwnmR2Rgz32HH4kew2DIvuP9hnL3lx2X2SeUeUkFPnOe6x5qFusG?=
 =?us-ascii?Q?i7rEdAPSni8/3n7TcByU+C7OeAtg0zlQMGpB3Y24Q0v1y9niNvtkICDiyGba?=
 =?us-ascii?Q?bv/pIpDJPcj3gmCS75/WcBO8uFINh58FRHQXLL5bfPBpmcgMIzR7PAO/UdnC?=
 =?us-ascii?Q?+lcHcUYdB79FPk3w8+3O0MVmtMTE4aquRWXOg6h5K3XRW/rrk9DfdAUEuPen?=
 =?us-ascii?Q?1yzAB8VxbxSRSntfmQlo9aKvOXHlu9U+fMJGpi5v286YWuqAC3Q/ML8pseiT?=
 =?us-ascii?Q?Le6rVESJOqugE7ZwaVjoZPtY7ZyLIG6bRgcIm52Z1BhChtryIiAaIZLv76Ja?=
 =?us-ascii?Q?nZLZ0GGZE2WWkdgmwJgDOU7W96rBIRyFx+yl5OadWNwC8wa/ZCUlc5ucXHPy?=
 =?us-ascii?Q?Npk04b5ud0unPlz9UHTr6J97E3AgI5fQkfLl6fQWSgBO8BJdz78z9r86pnSk?=
 =?us-ascii?Q?vwF36DbCiDgr8/X6P+YpJmU5mlkJoqcd1QBd/pKRtGhFm24JS5cqOcK93dbi?=
 =?us-ascii?Q?5cWR2t15ke4vYC7HMX6bQ7APWZEYQKK+ALTXQs/E40Psp+NsHInQs1uEpw9w?=
 =?us-ascii?Q?AyFOe9vqpyzz/pWmuK7rDXmVLg4Ikx6xIDTiKYqGyjhzboQcdyaqOW1dWkCH?=
 =?us-ascii?Q?fymaXYXpTfHiNS/c6zcinPoQiO3mDLO8QRVFVQuUiX7lhe21b15+PvsqUZdF?=
 =?us-ascii?Q?NE51ltjlG0jd4kQqE0vgIowAa6/cP+bq7KlbPR1r9cYot9GvprDX3y5fZgRH?=
 =?us-ascii?Q?ROmHH7Rsd5BilVWcWMVvvIbPHHKY5m95epsQfZPKiBhWToyQR1HVlusyS4VN?=
 =?us-ascii?Q?93LobgZqHS7QuxcoMY=3D?=
X-Microsoft-Antispam-Message-Info: WMdIAQksP38uUyU91TXBbJe9DMeERVQ7vlX0sVZh07F676eWIhkG57/2yGsdt//trhLx4vJrDKIYuifdx+t5724ibGHDgAe3JEvslsUZ1UkBs71n3ubdoFVHJqq3ZJIQbrJDQ0iy8H7OruHElDsRJOhaWTVfkxcFPzpO2ZMhBpH75ktitskOKE0HleHDgZBmqt0HAVynkwk2aCmDwc0b/H4etBROjh0Q1zB3ZebSwQ8NRKSIzGvjq2Tq6jbV9k07t8gzcSKTnqlcXK5N1keNdRVma43GmnLGYRIvQtjIDHq4EcsS3an8jlZcJgCC0KL1xtDhtZRbJ7mQQGn3Oe+EkkJeEVQf5ycSa5ebKh+8Q0g=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4457;6:9irZOKWZp9wnIZsRhtEpu70ihf/3K7ipMRTPEt7ABCxWzmCcjp1j8wC9TKnpLl1I3HhffR+Fa/3z8sumINvv8tE5xrpGG0qK/U78kMXJwVBmBfRZJryQjUzcknuPXS2C7IM5rnFjhwNyNnMJ6HKCC92y4Rx3SzBy36xnhX4Fk1AKLzSkPO6lt+hiJaaHcDs3yujb0z7CXY5zXCBhh63g4BtPYsiCRBVLweTRjzAUpR/7QUZ7GtMSrRZuV0B2MQ5LulHSZWqgPZyJ5RgJzyoRbaMVYH/StJoqTWTjKe2LpTXSLTF+T6/2E/qRbK0rmLjz1dXBJHY1Axxwdvcz3Lx0U5OXH+q4HMFX2OdTX1/cn2iJsundKM8R5BpXgwPC4h3FN1oBcaYyEkmfDDaNWawu9admC6IeHZy9y9xhPXnvM93XFPYC9DplPWVS8rvIbyom53tGE90RoiBLYQ12a/CiKw==;5:AzNxZ+oJiRRT6LsGmgZGHZHMxOCbVWzF6meTp7+Cyyecb66QkpQq4/wIZe28lu7QXNApBwbTzbNO41WQ93rvb3EGS8yXOlX+xtidBLlhUkX8Ey0WhCcxz3m3DpdMByQiV/DIy71ydEhaJEqYM80kpqyQqXV7ZT6+jFLuCVP48Kg=;7:E60t5cgmClROtP4014p9FDM1g+4fJPB5wcHhTQMzFQVMEcoUbjPpsUSUV0XGlV/rhwuwCCLfDRmMlfxQ4HqLGQR/AaOrmMEACE8hpnjto7xCaoq6hIgBZfvGP8mSnD+R09C7sHxN07mEN9tt11fvCsrBuKkevi9WxPd2tWUZXcX8PA2xqHr4qlcY28NJgLrk1LJfN0sj0olsNf/8siY862sRm6J4keioQ4ZSUt6PLhyE+ubxNKYo6hSS+OPT+D1f
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2018 13:15:20.2983
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 678dc487-2c32-43f7-6cd9-08d6310defd4
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4457
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The present code in dwc3_gadget_ep_reclaim_completed_trb() will check
for IOC/LST bit in the event->status and returns if IOC/LST bit is
set. This logic doesn't work if multiple TRBs are queued per
request and the IOC/LST bit is set on the last TRB of that request.
Consider an example where a queued request has multiple queued TRBs
and IOC/LST bit is set only for the last TRB. In this case, the Core
generates XferComplete/XferInProgress events only for the last TRB
(since IOC/LST are set only for the last TRB). As per the logic in
dwc3_gadget_ep_reclaim_completed_trb() event->status is checked for
IOC/LST bit and returns on the first TRB. This makes the remaining
TRBs left unhandled.
To aviod this, changed the code to check for IOC/LST bits in both
event->status & TRB->ctrl. This patch does the same.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Reviewed-by: Thinh Nguyen <thinhn@synopsys.com>
Tested-By: Tejas Joglekar <tejas.joglekar@synopsys.com>
---
 Changes in v6:
	1. None

 Changes in v5:
	1. None

 Changes in v4:
	1. None

 Changes in v3:
	1. None

 Changes in v2:
	1. None
---
 drivers/usb/dwc3/gadget.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 2d4b184..f54de80 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2293,7 +2293,12 @@ static int dwc3_gadget_ep_reclaim_completed_trb(struct dwc3_ep *dep,
 	if (event->status & DEPEVT_STATUS_SHORT && !chain)
 		return 1;
 
-	if (event->status & (DEPEVT_STATUS_IOC | DEPEVT_STATUS_LST))
+	if ((event->status & DEPEVT_STATUS_IOC) &&
+	    (trb->ctrl & DWC3_TRB_CTRL_IOC))
+		return 1;
+
+	if ((event->status & DEPEVT_STATUS_LST) &&
+	    (trb->ctrl & DWC3_TRB_CTRL_LST))
 		return 1;
 
 	return 0;
-- 
2.1.1

