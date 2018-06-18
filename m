Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE30C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA1C8208A1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="YgxDFYpy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA1C8208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965302AbeFSF4F (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 01:56:05 -0400
Received: from mail-eopbgr720044.outbound.protection.outlook.com ([40.107.72.44]:32640
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755586AbeFSFz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 01:55:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8RxUSiSJ5MvZkW2EBnr57KQte9xHDwI+CM+W5koJQAo=;
 b=YgxDFYpy6JqSPNSblwpqO/pYYib0H7R1Za/xrBopaOdyTgmInt0St4JBjOLN554+7tt9gDFfzjXoPjjNEUMQLshwuO8c365ArKHnFALOlCcTiHl0r6YiZAYfW7OKi4szvox4ayibg9GLCc2+vv0t4isBU08QY3+3EtTCg4zyU80=
Received: from MWHPR0201CA0036.namprd02.prod.outlook.com
 (2603:10b6:301:74::49) by BN7PR02MB5092.namprd02.prod.outlook.com
 (2603:10b6:408:22::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.16; Tue, 19 Jun
 2018 05:55:54 +0000
Received: from BL2NAM02FT021.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::205) by MWHPR0201CA0036.outlook.office365.com
 (2603:10b6:301:74::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.863.16 via Frontend
 Transport; Tue, 19 Jun 2018 05:55:53 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT021.mail.protection.outlook.com (10.152.77.158) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.863.11
 via Frontend Transport; Tue, 19 Jun 2018 05:55:52 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fV9cO-0003YU-B2; Mon, 18 Jun 2018 22:55:52 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fV9cJ-0002dx-7I; Mon, 18 Jun 2018 22:55:47 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w5J5tkOj030014;
        Mon, 18 Jun 2018 22:55:46 -0700
Received: from [172.23.37.150] (helo=ubuntu)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@ubuntu>)
        id 1fV9cI-0002dX-5I; Mon, 18 Jun 2018 22:55:46 -0700
Received: by ubuntu (Postfix, from userid 13245)
        id 96CC03C731D; Mon, 18 Jun 2018 05:08:30 -0600 (MDT)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <davem@davemloft.net>, <andrew@lunn.ch>, <michal.simek@xilinx.com>,
        <radhey.shyam.pandey@xilinx.com>
CC:     <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/5] net: emaclite: Remove unnecessary spaces
Date:   Mon, 18 Jun 2018 05:08:23 -0600
Message-ID: <1529320103-7711-6-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1529320103-7711-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1529320103-7711-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--2.512-7.0-31-1
X-imss-scan-details: No--2.512-7.0-31-1;No--2.512-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(39380400002)(396003)(2980300002)(438002)(199004)(189003)(50226002)(106466001)(446003)(186003)(305945005)(26005)(63266004)(478600001)(76176011)(4326008)(2201001)(52956003)(6266002)(356003)(103686004)(47776003)(2906002)(2616005)(486006)(476003)(36756003)(11346002)(126002)(7049001)(50466002)(8936002)(6666003)(336012)(90966002)(59450400001)(81156014)(81166006)(8676002)(5660300001)(316002)(42186006)(110136005)(54906003)(51416003)(106002)(16586007)(48376002)(426003)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR02MB5092;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT021;1:rtw5P8oEAql7qKnpZeRKmDgGx4ffBHvpKg+B/0FHVhx1Se7dpZmrQRAV/u5qTcQH0QHWqfgUaBPYYSk0B62Zz0/gB1tB3alMOBhlLpzKYXS0TNuAJ1o88BoeR3ULDXrX
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08b5741e-6962-4737-fd61-08d5d5a9514c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(4608076)(2017052603328)(7153060);SRVR:BN7PR02MB5092;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5092;3:GOO+I2y7Z0v7n34dSEbDmBE/Q3aQ8MfyPfW5q+XhWGigMigOOZJWMsSZO5wQB2ppJx6gM/k8irT0LsLuwV+muXGniuCGxig6rjih09lUd9YAwH6e+dJVIlBucQYClI6nGDQR075NiwIZcM4NDAqQCePgnnwygoYnPU+ZFJABYb7qNhW0mFVGnGWkKxji7cUHUeKbL9fDV2lrASUJfkLWvSumdkaX4/FQ071TkUoW5PPIp8dehH/7AjKoxs+6hPPIWnL37MlNZI20zVpxEEvT3SbGFXgexNzwQM9Zk5bxo4M9NaqhPm0aBv+bpegft4AAUpZS+2YSFWNynAzwtYL3QSrTlEpnW7hBAmHM1xfix+4=;25:apgZIDBrIeZ5BnxrPx3960cdE259vpkcJDxZ0TpM9riSMP66dfMEOF8my3oKVa2RTldwC08smziu3iJSgRF1KDgnpXTKfC4BxgP6qjh4pv8jc/kIT/SK76b7gUhpmbv8g+jZTYciv5gDwZUvfrmnyTdaes29fEJUpS3Sh0T+QxNa8tjkRX2LF8D2ISBpxvXO318fkcoUv2BJ1Hwd6fFA0l2FW+sZgC3f6R/sfj72URPza/j2jFeZZirXZgec8M45R9qUDonFfzSIt8OAyCfl+iKdq2o6UZZDgsZdhkwr3FQ3NwqLZ+Rh4T/ASUbBcxdcnxqxFD20oDEqRwn+Bh2mhA==
X-MS-TrafficTypeDiagnostic: BN7PR02MB5092:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5092;31:9YPD+TZlUqBfVcd8WR4yH52e4MivOrezBEORddIAPin25GX8IXw6dI0e7Kf4b+RGY00bbKgT6D3miGiIITazcSPEMHBIrTD9+8RlT+Dxn8/9iedDJ9L4LXu7Me6tuQRYi/d7UDSCNQmPFvqHgGYubNAR8ztGy3/Ij9D2vBTWipQ8kF2Eq7ayj0UYadLIJLTXIVrJY8/Es1SmJFOeJPNd741gjGY1GYdz3DAfk5F3kCM=;20:vqqUfGHTbBL/xPSAuzBP8HJNLURgJ5M3gnmkmpdZdKS5GyGjxgQk9+FQrkFzxt/M3/NKHwyw2Oy6i54OtO8dP2BMEfLf6dPfr+g6wsxYzClGEiA+LDcGSqvKQk6rFK7pgzkuWE+IW4QKeYb1YKsBO3ySHk8wUUXz+P78is4yE65HD53+PR3lxlLKJj0D3eA9U/KxpP+xZZsaW7BYB0n+bWYNmbZsylhAYLV/O5l2SkuGgMa+MwT7uV6glrHcONQQT80XFT2PXdRola52khF72NpNnqQqLaZPjSWy2khHcDgF6an/jEuWR03fwumypWUmrCjkzk/0SWn6TpyAg874rvgz22AH9xJsjX7qPl2Wm2lnNUeix2eGJShkJUyNQ2FITQiZ2eZhP6LFQYXAxGlx+VWraFXbIJIk8xNxuxKUIsp4hgO0hIDYDzKAgwgTKKF5/E6mzdzSXxdKBEbnimbPDe3NE/J4956R/LO4IIOPPgBzkETdEc+O5Rq7/RsTuLkI
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN7PR02MB509282AE9C68FC18B1CC79E7C7700@BN7PR02MB5092.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93004095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BN7PR02MB5092;BCL:0;PCL:0;RULEID:;SRVR:BN7PR02MB5092;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5092;4:fXm7Po+RyuILNOSjLvZSLB5+RDcHIYiLyUpcZSvae80loip1UbvvXwQyrMiEKp5/ksp9k7+stwQ2RyHnqNPGLUekLbdlXmjF2gP+4mzfKCTO8KbLh6uO9o/ee0Tnubdni5v71ZXsJScG6A1QSslEcOmuAJgsL93EtDgEfxVAp1fqgSLfa0px53p1m14OblEtNRg7IOcypz2m9ppL1vsHJJIK7lcq7Wc9VN3+P/EBqgLnslTLo2cSXcL34g0HMcIItN0LeLnUtrkYYzfPBhz/STNbMgEzSVn9Z1+89PzK1eeDjqPuTUtxEFdwmbGtz1dG
X-Forefront-PRVS: 07083FF734
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR02MB5092;23:S/Bbh5fyvRyufQzsts+sVs61REB+Rq/bPToZ0+E0U?=
 =?us-ascii?Q?gMgaGIng588uXPB7yqRVWSDYmGMerMsishdAI66h9fqKpLykTFC6FqmR8w1U?=
 =?us-ascii?Q?C780jXUlnPccbp97s05P3ow+EGcS/h3nttfe0eaQFUL2FMV9ywBrFdbz2+EI?=
 =?us-ascii?Q?myYJx/3e3KMVi3zDmkoTk93PzAKyQGsb8b+cl/sYrVhwOMn6c4/Lh1SdOgFY?=
 =?us-ascii?Q?OFzvqc+GVo5JuzeU08H0sC78fK4QVdz/CE4KzN+KFtXR7F8M+mQowdFx9Tvo?=
 =?us-ascii?Q?vr6PgGAVsYPLv14MLV7xIHS3gzM26xpfDrFCKx1mdKQdbSVB+55miiarok/+?=
 =?us-ascii?Q?gVML+97gnAnIw03Fz7xW6k13QasYVdUmx6yZd9T4HPl0V0gCl7N2pKzFae+u?=
 =?us-ascii?Q?Mqw1tF8hcjhJr1bm9o5dYiGIIEg1rzjRr+6Ppe0JsG7fd3qqHJon8QdJ6oMK?=
 =?us-ascii?Q?iWb0Rh0Vs32W9a6I+peuVgQO8reTOyP9DQkt00GcAmqW19vS9HwKZH8kEpaO?=
 =?us-ascii?Q?cYzITty1RSaY6dWz4jU8s5vAuI/Y7edz1fhyC7MNro/PuoloHfOVnuO4usNq?=
 =?us-ascii?Q?hkTVqAIFiGLC7gD5oPdFy/0uyfb65l0jC+C+GZb3oVmHql+EKQ3KQGeocH3R?=
 =?us-ascii?Q?nvJCUvf2yVlGiHr9kxpN27IqJOvSW0S8YXl7GoJqqK3xGceJq2AVaFyb044H?=
 =?us-ascii?Q?8QSR8rUVc2U2jH2vHqJzshzaO1PQbrtS9t8vdRLFp68laqeRPlZ4Cy+iMQeP?=
 =?us-ascii?Q?jVoYmvrJdPV6cYx4Tj2XWBCQr21HB3wF9h+R5RtDaJKhSdOS82gkHL4OMvov?=
 =?us-ascii?Q?27bKobFfJ8KWAo7Kz+HclSHMiiOr5zsb1ErBWyqiYlZGiyHLDxHrZYDuN85M?=
 =?us-ascii?Q?aBQaf+7niZ4L0HTrnNFfKMo/+0qBUZqZXuxUzeZpNCyCsyRWy5wWr1pw/lLU?=
 =?us-ascii?Q?0ytcqnYFpTmiFj8GZc0LTNeSDQDSOqGFVJIIXJE4tZmr+hql3fe0r3tQksWQ?=
 =?us-ascii?Q?4w18Ty1jGpj2FNf3zXZJGlX4HF2JV106RmybJJW2sAPGyDamlYfwSPNxMSG1?=
 =?us-ascii?Q?+4uFbklFMrfGWghljdCCGN5u+e5tkPLEMBLi75LABR5AByf2670ClbpzhI+t?=
 =?us-ascii?Q?SmNjZ5eyt7PRQu7XtDLrInWPkhYyqOwwB7hxuFmj5xqcKryg9Ap+zYKnNtpw?=
 =?us-ascii?Q?YSzDUY65IyDUrA=3D?=
X-Microsoft-Antispam-Message-Info: q7KmbB177XbuGq6xMt5QgHgJbfxVOw4a6s0+xRWLkPu8N8zW/CxajnlzWILuXydgieSJx4OXl9liWHcOGHCa+TZBKNHYfpVs/3sRcQzHo9AXeJrRQYyZ0W9dHSxQY54IKeKw9k39HVJP1bMsh3PENAks8ytRWRgqiKYk/qKaPAoJDBFz8CmDkniUfdbLzdmK9TmhQSgIYaIEFbNTNVeyopB1+aZJZBr9zY5pJCQbLmhZuuCyGiVJSE1kEMOOLs1dOiqSbRSOqn29wSFhw3uVoIJAPQ7K+1v9zJMo8U4M2GB4UBzV6lZQDSgjp7ICUWfo
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5092;6:m2NOSenw4LcPvIkqhgfOQ3+Fgdlqsl6lN1LC5kVNHwmSSMp7xr30GRYJhbZzMo7tnGNcAFlSce9m2Soc5tzl0AZEU+xFp35ua8XKbSCHLfh56Usq23k4E+i5j7KJw/Au1ZKbIxl+4PrlBpMzYr3E5/G7yGAAsC1K6gwAKogWLLExNtBUSYzViEjrNrbiRpO7PmXBZCNSmDmkL5/s4gHhH/8iGH8CcfInbbzl0ux33NiJmmgNf/Z8dT5r6qSDqV7euVdY6JKtFEruysquhL0pe+7MlKplxXjEawNwVdrq0zwWvwHV/2iOrHNATi++7aLMZNL7RNgojnNlycT8lA6YRjyUQub0qnSRFqBZlAZaoXusHTDi1kpMwVRk8pBytp5BzMB07/u/qtjSEtOULspSOUAKbhQjxikQv0VJYLpKZXnWEMPFZ768qMHfCmBmACw/vmEfysuVg9nQHhqpWVRSvg==;5:v8K9fzYT7x3ub7jIHB/AttHD9/zUXunSmCT1SwOU1NNcQBODpJcCyh7731mGr7WoTSS8rz2L2zcrUXoMOPaEl7tzC74zEFw5qgMTtGt8yahKHtIOCASfRphtwbcvpCzNcNMkbyMBL46lNbIte0qkrQa3Lw7ulNYURSqL4bZkB94=;24:uJrj59EJTvnqNZ1IQRHk+i9jntbu7eDBTIF4t2iNBxlImXdyztQxmT7ciwkeUGZd9eoT9o5MViVUZybkSsr3vgyg9Wz+z0KstHXMaGX8ZsE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5092;7:ODPjud0bh31abPT3IH8DYC6nnRS3YbidCsbMhkNVVoO/Tbi+qrybfE0FcfVuJ2/d2Dd1O02a4Jpcm37ChJOBhWA/hxgYxM/Qafri9CqG5qYta0lb1RBatxgoBuvyFJ1F6anhQl7reCCO0g43nUxlG+u5w3ztIY16uaHh640E22ZvHqenZiaA0zRNf14JGirzs9i7o3Eeyd9S31xExjKA5ZPd/LwvK1U9mbacJZ6QSIjKzY8NtKytHyjLe992svoA
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2018 05:55:52.7506
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08b5741e-6962-4737-fd61-08d5d5a9514c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes below checkpatch checks-

CHECK: spaces preferred around that '*' (ctx:VxV)
CHECK: No space is necessary after a cast

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
 drivers/net/ethernet/xilinx/xilinx_emaclite.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
index e8bb7b3..f62e4b6 100644
--- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
+++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
@@ -95,11 +95,11 @@
 
 
 
-#define TX_TIMEOUT		(60*HZ)		/* Tx timeout is 60 seconds. */
+#define TX_TIMEOUT		(60 * HZ)	/* Tx timeout is 60 seconds. */
 #define ALIGNMENT		4
 
 /* BUFFER_ALIGN(adr) calculates the number of bytes to the next alignment. */
-#define BUFFER_ALIGN(adr) ((ALIGNMENT - ((u32) adr)) % ALIGNMENT)
+#define BUFFER_ALIGN(adr) ((ALIGNMENT - ((u32)adr)) % ALIGNMENT)
 
 #ifdef __BIG_ENDIAN
 #define xemaclite_readl		ioread32be
@@ -239,8 +239,8 @@ static void xemaclite_aligned_write(void *src_ptr, u32 *dest_ptr,
 
 		/* Set up to output the remaining data */
 		align_buffer = 0;
-		to_u8_ptr = (u8 *) &align_buffer;
-		from_u8_ptr = (u8 *) from_u16_ptr;
+		to_u8_ptr = (u8 *)&align_buffer;
+		from_u8_ptr = (u8 *)from_u16_ptr;
 
 		/* Output the remaining data */
 		for (; length > 0; length--)
@@ -273,7 +273,7 @@ static void xemaclite_aligned_read(u32 *src_ptr, u8 *dest_ptr,
 	u32 align_buffer;
 
 	from_u32_ptr = src_ptr;
-	to_u16_ptr = (u16 *) dest_ptr;
+	to_u16_ptr = (u16 *)dest_ptr;
 
 	for (; length > 3; length -= 4) {
 		/* Copy each word into the temporary buffer */
@@ -289,9 +289,9 @@ static void xemaclite_aligned_read(u32 *src_ptr, u8 *dest_ptr,
 		u8 *to_u8_ptr, *from_u8_ptr;
 
 		/* Set up to read the remaining data */
-		to_u8_ptr = (u8 *) to_u16_ptr;
+		to_u8_ptr = (u8 *)to_u16_ptr;
 		align_buffer = *from_u32_ptr++;
-		from_u8_ptr = (u8 *) &align_buffer;
+		from_u8_ptr = (u8 *)&align_buffer;
 
 		/* Read the remaining data */
 		for (; length > 0; length--)
@@ -351,7 +351,7 @@ static int xemaclite_send_data(struct net_local *drvdata, u8 *data,
 		return -1; /* Buffer was full, return failure */
 
 	/* Write the frame to the buffer */
-	xemaclite_aligned_write(data, (u32 __force *) addr, byte_count);
+	xemaclite_aligned_write(data, (u32 __force *)addr, byte_count);
 
 	xemaclite_writel((byte_count & XEL_TPLR_LENGTH_MASK),
 			 addr + XEL_TPLR_OFFSET);
@@ -448,7 +448,7 @@ static u16 xemaclite_recv_data(struct net_local *drvdata, u8 *data, int maxlen)
 		length = maxlen;
 
 	/* Read from the EmacLite device */
-	xemaclite_aligned_read((u32 __force *) (addr + XEL_RXBUFF_OFFSET),
+	xemaclite_aligned_read((u32 __force *)(addr + XEL_RXBUFF_OFFSET),
 				data, length);
 
 	/* Acknowledge the frame */
@@ -479,7 +479,7 @@ static void xemaclite_update_address(struct net_local *drvdata,
 	/* Determine the expected Tx buffer address */
 	addr = drvdata->base_addr + drvdata->next_tx_buf_to_use;
 
-	xemaclite_aligned_write(address_ptr, (u32 __force *) addr, ETH_ALEN);
+	xemaclite_aligned_write(address_ptr, (u32 __force *)addr, ETH_ALEN);
 
 	xemaclite_writel(ETH_ALEN, addr + XEL_TPLR_OFFSET);
 
@@ -574,7 +574,7 @@ static void xemaclite_tx_handler(struct net_device *dev)
 	dev->stats.tx_packets++;
 	if (lp->deferred_skb) {
 		if (xemaclite_send_data(lp,
-					(u8 *) lp->deferred_skb->data,
+					(u8 *)lp->deferred_skb->data,
 					lp->deferred_skb->len) != 0)
 			return;
 		dev->stats.tx_bytes += lp->deferred_skb->len;
@@ -619,7 +619,7 @@ static void xemaclite_rx_handler(struct net_device *dev)
 
 	skb_reserve(skb, 2);
 
-	len = xemaclite_recv_data(lp, (u8 *) skb->data, len);
+	len = xemaclite_recv_data(lp, (u8 *)skb->data, len);
 
 	if (!len) {
 		dev->stats.rx_errors++;
@@ -1032,7 +1032,7 @@ static int xemaclite_send(struct sk_buff *orig_skb, struct net_device *dev)
 	new_skb = orig_skb;
 
 	spin_lock_irqsave(&lp->reset_lock, flags);
-	if (xemaclite_send_data(lp, (u8 *) new_skb->data, len) != 0) {
+	if (xemaclite_send_data(lp, (u8 *)new_skb->data, len) != 0) {
 		/* If the Emaclite Tx buffer is busy, stop the Tx queue and
 		 * defer the skb for transmission during the ISR, after the
 		 * current transmission is complete
-- 
2.7.4

