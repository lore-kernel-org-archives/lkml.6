Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BECFC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACCB42241E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="dXwlLE7G";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="B91P+0kP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACCB42241E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbeKMCgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 21:36:14 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:38102 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727976AbeKMCgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 21:36:14 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wACGbch1027691;
        Mon, 12 Nov 2018 08:42:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=xakoGgHeZAu9dKI1ALYQ+fTbnLvUJJytbI+KIevG67A=;
 b=dXwlLE7GSWnKAmWmOkJFKf3RibKlJWZFfNVsR1JKQUt/eXaTVwVNTfG7MPsprQXG5Dka
 s0UJ7piPnCOo3UMawxP0N+nlmp0URTxxy7uXPvjVnB4IgKl2zWAp3N4oX7sHscu8ZQgD
 CeWwvaRSVBlalf9UXmRk9aAcXE0LsbUGQjwaNEUHZ3y0EGwuJcsgpSVgmYV9of7J9wKx
 fh/bCPHrM46VFOrpzcj2NKv7FzgMnLvFDFc/mIxehCJdgARO11w5T7OJ5qAly9dsdAxx
 rIWtlHvPlUDrTZUthkDAQ9ArJ3kwV7tabKJwUKWDyTqTAUVPjmkM4/JXiDK3Jh3HCp2I UA== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=adouglas@cadence.com
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp0052.outbound.protection.outlook.com [216.32.181.52])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2nnvs1jr6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 12 Nov 2018 08:42:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xakoGgHeZAu9dKI1ALYQ+fTbnLvUJJytbI+KIevG67A=;
 b=B91P+0kP2MrGybJGGeXjNpVGohO7vBS3Ul5oyaRq2uQMFJov98f5IJrsbdNII0E4BdrkECyBsNi3GDNsG7D783dNYRlYAuYEroKjc33QD9oSsnitVt6rql1LymJadUGFLf5ylG8FweL7TKr4Y/xsDa4XB527GFDNNkjdLiU1Jm8=
Received: from BYAPR07CA0024.namprd07.prod.outlook.com (2603:10b6:a02:bc::37)
 by BLUPR0701MB1858.namprd07.prod.outlook.com (2a01:111:e400:5165::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.23; Mon, 12 Nov
 2018 16:42:03 +0000
Received: from BY2NAM05FT011.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::203) by BYAPR07CA0024.outlook.office365.com
 (2603:10b6:a02:bc::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.23 via Frontend
 Transport; Mon, 12 Nov 2018 16:42:02 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 BY2NAM05FT011.mail.protection.outlook.com (10.152.100.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.3 via Frontend Transport; Mon, 12 Nov 2018 16:42:02 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id wACGg0NY031062
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Mon, 12 Nov 2018 08:42:01 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 12 Nov 2018 17:41:59 +0100
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Mon, 12 Nov 2018 17:41:58 +0100
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id wACGfsk7010080;
        Mon, 12 Nov 2018 16:41:54 GMT
Received: (from adouglas@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id wACGfrrj010040;
        Mon, 12 Nov 2018 16:41:53 GMT
From:   Alan Douglas <adouglas@cadence.com>
To:     <kishon@ti.com>, <linux-kernel@vger.kernel.org>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
CC:     Alan Douglas <adouglas@cadence.com>
Subject: [PATCH v3 0/2] phy: cadence: Add driver and dt-bindings for Sierra PHY
Date:   Mon, 12 Nov 2018 16:41:46 +0000
Message-ID: <1542040906-9877-1-git-send-email-adouglas@cadence.com>
X-Mailer: git-send-email 1.9.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(376002)(346002)(2980300002)(36092001)(189003)(199004)(26826003)(336012)(186003)(426003)(47776003)(2616005)(476003)(486006)(126002)(2906002)(51416003)(26005)(106466001)(316002)(110136005)(16586007)(42186006)(105596002)(305945005)(8676002)(5660300001)(2201001)(7636002)(14444005)(86362001)(246002)(50226002)(356004)(6666004)(4326008)(107886003)(478600001)(87636003)(50466002)(48376002)(8936002)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0701MB1858;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM05FT011;1:q/1FAStYuqsm3Qs6II2nddRLlvAidRrzVpVYmXnjGGGQrETUJGB4bvZfkbbIPKbi6ujiwKwVmXJAgvajX9dtSVKHtZtrUMVzqURo2arp9H/qllgPgZHV005pZBGKe+IJ
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6f40610-c6a4-422f-1eff-08d648bdc5f7
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390040)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:BLUPR0701MB1858;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0701MB1858;3:QXSQGMWfr5RKUtWOTUs7saVjB5opk8UV4ybUjoohCM0l5dHzuzy0g9R6VLN9F2xRHg+lKcuSCsgMwGIAT/6LmyP9skTp4q0oZIaBZx6PkjLOPMSZX7rANVJI3d6cEa8dYuhY8UOKvKzQPq6xlWNzalpW8oRvw0vTomCjaL236aVDWN02Hhf/1aP7MgFr+m8av3cMTBK5jPuTrdxVWqGMsNro9nmYcCJtxrFF41LMRDZJItHB/7OaNioAazzpg3n4Ll6pdFxHG6Siw2xfwwISUDxyi33adpQ59RTziF3hkS3+QZ2DaubZxw7DN3R+9ZnofXzuCpEtyQfqrv7EnNPZSL00x0N/aq0TgKfghpVAStk=;25:JB8sWxLbxJZvj7oOm977nl81KlU/wNXZTUXfGj7l78fG3fH5aLgrz9Wi4KcqnQehTCVOy3EIpCgDKPDWRWfXyAxA2LthT+iloFhK+633mE/nHQDZmLGltAOJZqvKbP9KWL/L7SqY9E18g1/kpMJn/+RO3LjU1dy6oWiaLFoED0DA3DnBL7UDRgeoswu9QcShpOtZfPTHwSdhvmm+FTyHdGcR4UHLPNxDSeE6qOQFlokHmnxGKpr2C4axl4thRzbRUctEweCXP3Sliup8xc8Kpf8e9UaDe5inex4m4QtaezKxti/QRXrhcVwjSlFKhJSbH191CuCkkUK5SeK715txrnAf93z5Ujr+VBolW2c1kCE=
X-MS-TrafficTypeDiagnostic: BLUPR0701MB1858:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0701MB1858;31:jjbQUeN2K47Sk8UgiqM65ISYFPfmeSbfjFfZhQDkKpLOq52oqpkckD7tZwMbk6jpsw23HSIIkX9H3WagSoEVR1elRiKUyhIrBwjHBk9Kkb6ig/C9adx0UDwmYCMiOeQY1uIjuLd6vAsoYU1r02nTT6N9P9tgQfXxpPXGl4p6cDVVW7RKdasTONvsik3JimQY903vBqKf1kc0F1EhYl7Pwoy0pWxXSFQg9K09fchpXG0=;20:QMGJsOYnN4HVoGzJrGXyf7xjHjGwSSdoqb5EjNO2IaCkoL/bMMkkgzboA2oI9q3eBChE/Mf0RMJa3jGpxw0f/16An9XVqOoXgtO3wcNdEmpCKoNnGfrNJioqVFVIy/R9ypNDpS2yKeldsuF7DuNTbPxaut5kllJodnT1W7EUuNscT0/kTsMcECYgP9qPh3EEWTFkIMH3Sg7dBcnDPe5dUFgyGhXCcyX1yj0IlQL72iugej/nt2VF1CHRC9qYZeuYP5q9V8/iAcb4NizY2QL/w7hWqcrq/7YwgqpLpi1Sk+1fttNq6mQEXVqbgIHS3iYrhhTVcKH6y6D7VvxzNPMCLcqSmw1BnfxbwBjLJkjn898KrwJQH7OrPWpQZ81DbQbqXJn2aCZYc/rT1lA2RWMOTQiYDye5bvRBqfuKB9NE2p3yHUyOSbb94Yb5VZzh6WdUejY4mhGBrV6O3gERmoch6i7X3p+6DMVZyPghClg1wzDJy0nKqVPyC9J+l7YLWJzS
X-Microsoft-Antispam-PRVS: <BLUPR0701MB1858FE02C2FDFD34E5E0086CD8C10@BLUPR0701MB1858.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105112)(3002001)(10201501046)(93006095)(93003095)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BLUPR0701MB1858;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0701MB1858;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0701MB1858;4:+6Olcm4/EoeRvfEV1qYiHg2DsDbZ5n5I+yYnCMlP4ls9ILVgAcbOyGPthrJUSvGH3QxtD++oLFNgvIIbHnXMj4a39xF+BUaPsBMdDiXoSAL5jDUrlaoFAtthyt0mI99t+3NXacpatr3icMsLxPvKEcCIrjzC4tS/9GKZCP63pmpX1UAqyIGr+ONSEaI6BNAM7pZk6l7GgHATmyoV3lPjjLz9KpTWTRIxqx+jcYZaVgn7tP589Hnwj7nSp6t+Uo1ELlrrdfGaFz5bNp9sCu2QHw==
X-Forefront-PRVS: 0854128AF0
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR0701MB1858;23:XYqfpUD6NIdofAypSbc/HcBk27bYVnkObM2lnB8?=
 =?us-ascii?Q?qiru4GjT2A9kpw45NiAwQkOKWvLUfS8Z/Mqm7aGBXGwZMignLmYIQP+cSCYW?=
 =?us-ascii?Q?EI6tbnfED1ajQl0N141hEIhRldZf5pWKdFlZooaTfE37ZGfDk1RyP63FGMw+?=
 =?us-ascii?Q?HZb8WQjIGZG/3E2k8Bsb7qJ6jMYe57EA/GznZ4dmzqJsDHsXhKNGdTW6nGuG?=
 =?us-ascii?Q?PsJ8AHcpOrktAAPi2A/EsXQ1Mksnebq9gRkVrrFi7fs/RwiZ6ZJKTwM1AxlJ?=
 =?us-ascii?Q?zMaCNi9QUMQP/vJoE9yxrbbHCc6sSSXwoAHtvCqZMgWC0osRtyrLtEp5b0a4?=
 =?us-ascii?Q?xTN8duXSBYEBvscOlt9PFEKHK6OGUTt7MxfoevJbTeBmVYzQlxYtkx9kPaZF?=
 =?us-ascii?Q?4QlrE0tyhFzZDSE/tQEywlqIZSrxF9p/QXKdG/I7PeO3ULzQO4Oi8F3xGg+X?=
 =?us-ascii?Q?z8TcWSycaMxRxhY7pKpL7qVk9kR6KZgw/5ZJQS3YgXaRB209JlZ/4svMIwQh?=
 =?us-ascii?Q?LdDpFtgy6/+KgHlfb/bSPRcUjIBoVgZMDvGeo02Tfv1gFx+HFtIMsIesVb/4?=
 =?us-ascii?Q?7UtwOxc7CX0CeBevoUyXTwI3/tX+tLecouWSX6vUB+w0nsSM8iOBQeVKkCI/?=
 =?us-ascii?Q?y0VD+01O27f0kMJZV0ueu8lS95cAopNT41ZVGjbFK2hlxIjQzmITDzw3ATFc?=
 =?us-ascii?Q?ZSqLCW/+ijnD3zpgKij6/jdDR5FdpO40iuy+vc5nJECVemNGzAw5CKWxEzoN?=
 =?us-ascii?Q?5GG0YtvmAhoKbShkWqdFL5rZwSMhtwJ8evOZhXmNQUC2IT5bNTzyox4hAqiw?=
 =?us-ascii?Q?sgk/v7qV0TagNJFAdFx/uRT3yvODpNkeCvYdFYTjrxuT7UA+YzGF4MfvCiYo?=
 =?us-ascii?Q?ENVYyt4SbBTIfh3cAuA+YHIStCEGoonAo/J0sZgm40Ht633RVWnwPyMNWCYy?=
 =?us-ascii?Q?Q6QmodtRFEVvplbW2ImsGLbPihrMtzkrCXaeDV0vPLo9f2szhwKFAF63nPL/?=
 =?us-ascii?Q?2G2MIGh/rlrIAL++Sw+fgPpCTZp6g+gSjHKsoXRHFKSusxw=3D=3D?=
X-Microsoft-Antispam-Message-Info: w0CK5qsAVTXrzglIYKhoEW+dYKj+yGGH4CumRXtDomXXysg+XcBgWaZF9fGUGb1Qoa1Lh7z2QjRLI4if0PNgqR++Reg1/0iPjJ7XUL2uBUY2kvrUACtOuZovkY94gGo6ee1OhtqOU+BK40daSf/KfyN1bE+EcKuvqyPmxNKPtqpZvWkIa9D46AW/JAusb8O+wObXuTwWJVrfAcPN+ukGjHitLOZ6bbFGsSJ7bQ5jHj9FezDelgeVYorMrlYHetNwnqgDZCPrKX5TB3b8TDbO1hEHH1qRjeI1W19f3maxBXHvj9UEYJlkOAiJZONI4BDMgXKH+FOJZkAXu/U9OtZW03Z+gSUyBK4kj0cJpB7ar7w=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0701MB1858;6:sGYsxuzyxCO/nfQING6+gPWrKXSHl0+W+V3ZmJ9KVdz9VC403m2zuNfbL3qNjx152adWavi6ylNCGM4KKI50SeWP/wwtn7U3WnAje46Krq2+CG4wrPTIjSO7vfwyO/Eky+WJMdTz73dcdm9lrtdWc52sRFp02OYuZ7BsLTLztyWgB6YQwFP16VLLeKOOZg4YP3ByWYZkug7dG50wovAASq1NlqrcWTQF00zyZBbFo4w/16L/AI85gR0YAVNZtfYxqaceJvEbRVaIxp4OJa7op0501eNbMt0tfXLca7tiG+7uk+SyUUZ8s33y27aevbxcAdXqVbZ66FUYVjweE/lcAO3r0eiCHoBucHqHVSNZ79CPmxLzaIu+BC3h39syBAlfiiBZVYsZl68teULLllsbUJjIAHxcGKwWHwWxzsRdtqLkwGnX/gvOyjHvifPR4gxVDglAraixuLDACjlM3KxbbQ==;5:f8ZBMIuJzB0yMyokYKC1zRF7JqcaOPcdp+7lDOlDBcl6Bwtkl1Q5PEsIGIIhODXnlOSCxARbOegWOxbXIJlsegU5xWFGy0n+mIXLf63EMYBlLWDkeDH4MNAEQfGvd3X3QFEMKfekRgmVZXmGVFYpku8WVf9Ja7s0EsVzBP+GNis=;7:GZ8nhMseG3T8mR6dalzn/QpneZPkmhb2xJaep5yTuUWYV0zhcY4wfEa2/GqQYl19xwmOFqgCTIsSgXRJYwYwCQKp0uUk2LU9vj9FDfDzJn1tSN+vzmm8TD6Sp+fv+LBU7Qm/9WCjN66wfZW7TK1OwQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0701MB1858;20:LVHZCnR0iG7fqooszNLOgqnfT0wMW7NiS0+rxFU//m/sHH7vwK8mf7OYsBr/WBwXwc7UaRpvPfGRntraZ+3NjLDJ0U0vAKPImAoqT8rC2/J21BS3vtHNpNfCma7iQiltCKKTpruWpEeOkxb41/SH99GqRRB3WSMW7Xz+45HXJEeZFGBYJKT+xkZeWtOni6tw5p1HjGsHWTxjLsN63iSwM9IM/Q3jJnEKcXw/DbhBuGPK/bq43a67t0OaUY8yZExj
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2018 16:42:02.3235
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f40610-c6a4-422f-1eff-08d648bdc5f7
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0701MB1858
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-12_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811120145
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Cadence Sierra PHY supports a number of different protocols.  This
series adds a driver with support for USB3 and PCIe modes.

Only one clock frequency is currently supported, so the value of clock
provided in device tree is ignored.

Changes since v2:
* Rebased on 4.20-rc1
* Renamed cdns-sierra-phy.txt to phy-cadence-sierra.txt, to match DP PHY
* Renamed phy-cdns-sierra.c to phy-cadence-sierra.c, to match DP PHY
* Removed blank line at end of devicetree bindings description

Changes since v1:
* Moved subnode resets into each subnode in devicetree bindings
* Modified driver to put subnode resets on exit
* Changed driver filename to phy-cdns-sierra.c

Changes since RFC v2:
* Devicetree bindings modified as suggested by Rob Herring.
* Tidy up and correction of return paths in probe function.

Changes since RFC v1:
* Each group of lanes is now treated as a subnode, and a generic PHY
  device is created for each group.
* General cleanup based on comments
* A reset is now required for each subnode.  The complete PHY block
  is taken out of reset at initial probe, and remains out of reset.
* Added a binding to allow for hardware configuration of PHY registers


Alan Douglas (2):
  dt-bindings: phy: Document cadence Sierra PHY bindings
  phy: cadence: Add driver for Sierra PHY

 .../devicetree/bindings/phy/phy-cadence-sierra.txt |  67 ++++
 drivers/phy/cadence/Kconfig                        |   9 +-
 drivers/phy/cadence/Makefile                       |   1 +
 drivers/phy/cadence/phy-cadence-sierra.c           | 395 +++++++++++++++++++++
 4 files changed, 471 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-cadence-sierra.txt
 create mode 100644 drivers/phy/cadence/phy-cadence-sierra.c

-- 
1.9.0

