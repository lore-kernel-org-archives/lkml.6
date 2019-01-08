Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7785C43444
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87108206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="UqyDYHGZ";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="SGecylje"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbfAHMX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 07:23:28 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:45852 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729058AbfAHMX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 07:23:27 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x08CLg66030682;
        Tue, 8 Jan 2019 04:23:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=CSZ1EONgELlLgD/Dr30Tx7inAHcxidV0rYfjWl4s5M8=;
 b=UqyDYHGZD2apir4TORKpA/RQ2XazVUkhPo+dSnM2pu+q0d+pFthJ5tgYLipIATvXKBDf
 yv5rt1xyb98HzgDfISyFEoIrRN4YmMBOQa2fq17Rs3nSYH185OEcqnI5W9+2N5O76qgY
 0WKl2FYjSEhOLRIvT+UxciqF/Ukb0NgiaAved5T8+TgmhAL6U+kjdh0DfrokgiquqQ9U
 M8Fhyzb4Y17e3ta08IprLZeFLs4XOp50n7pa6Dc8L8Zn8Trk+tsUm8swziM6gIM9ylgy
 Zbe2Gm+zTjUc+D8gDtiSZARnGQV4SKuGx8Cp7v5YA9BcbYjiRvbo18tga7T7rLz67ebu IQ== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=jank@cadence.com
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2055.outbound.protection.outlook.com [104.47.44.55])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2pu6xwkeut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 08 Jan 2019 04:23:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSZ1EONgELlLgD/Dr30Tx7inAHcxidV0rYfjWl4s5M8=;
 b=SGecyljeBtJ7aXei4PnG9WlhtfroNbDvqH1SqiZ7yyB4d2DwY3TreSv59RIUoptexGdlhwEFppyI4vBtZh8ehVHqbi2IeWmypTIpLwhn0yleqYVmkvl4PC1LzEI5okjQqWulZQISkcbJN/m39D1ku3/Vm1/3/xLyAYCIk55eNME=
Received: from BYAPR07CA0105.namprd07.prod.outlook.com (2603:10b6:a03:12b::46)
 by CY1PR07MB2167.namprd07.prod.outlook.com (2a01:111:e400:59d7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1495.7; Tue, 8 Jan
 2019 12:22:58 +0000
Received: from BY2NAM05FT024.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::205) by BYAPR07CA0105.outlook.office365.com
 (2603:10b6:a03:12b::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1495.7 via Frontend
 Transport; Tue, 8 Jan 2019 12:22:58 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 199.43.4.28 as permitted sender)
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 BY2NAM05FT024.mail.protection.outlook.com (10.152.100.161) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1471.7 via Frontend Transport; Tue, 8 Jan 2019 12:22:57 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x08CMpDN022959
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 8 Jan 2019 07:22:56 -0500
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 8 Jan 2019 13:22:51 +0100
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 8 Jan 2019 13:22:51 +0100
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id x08CMou2012685;
        Tue, 8 Jan 2019 12:22:50 GMT
Received: (from jank@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id x08CMo5x012683;
        Tue, 8 Jan 2019 12:22:50 GMT
From:   Jan Kotas <jank@cadence.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jan Kotas <jank@cadence.com>
Subject: [PATCH 2/2] rtc: Add Cadence RTC driver
Date:   Tue, 8 Jan 2019 12:22:42 +0000
Message-ID: <20190108122242.12411-3-jank@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190108122242.12411-1-jank@cadence.com>
References: <20190108122242.12411-1-jank@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(136003)(396003)(2980300002)(36092001)(189003)(199004)(8936002)(107886003)(81166006)(8676002)(81156014)(356004)(6666004)(68736007)(76176011)(53936002)(14444005)(4744004)(476003)(126002)(486006)(575784001)(1076003)(86362001)(4326008)(2906002)(186003)(446003)(478600001)(426003)(87636003)(2616005)(97736004)(36756003)(48376002)(11346002)(26005)(336012)(50466002)(42186006)(16586007)(316002)(69596002)(51416003)(110136005)(50226002)(106466001)(105596002)(305945005)(5660300001)(47776003)(54906003)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR07MB2167;H:rmmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM05FT024;1:bYizF7HGAHlsKUDatbLN11cVS+/ow9yQjNw+ydbEt8L91ztOnAcEjDqKMJ8fYVDBMmMyFbEQsunxVxSdvRMT9lYFluGCV1eoAj4bMbwGuP3HPkPNvyEMlDPIMc/h5yhg
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fdf20adf-dfa8-435f-60f8-08d675640644
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060);SRVR:CY1PR07MB2167;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2167;3:vhcezWZA1hTEoWU2N4GYb6rvk8JSdt9qmmDbGklpecSrWQiC3zqCtfcB87mxCiKxWZxsI7PUe7/95NlmtmeB3kx/eB0nLXf3SOBvl9h73LdYCh1gQ3qd8/y5/rP2Bo3OVCdJx7T29XVRgc3eIEjM3NlRAiUw798Ue5E4Om/6QpX5AhCK+ehZjN5ZngBWK7LXZAIX8wxOrfZbt5K6O0YnhZd4jr0VEIiqrt5Qy/z419MbrwnZMIt6lDcwpjJlg5x/6t/wrR5qoVXr7J2tPvzPDOXq2xli4bP0oKxzZRHNsMSsuboiymul7WtiBS4qyx0utMdR/a5/wzCJKPskzcrT/+6o8YdRgZMlWxw7WFQe3pHiZpS3OE3X85Pfs6L5L0fO;25:BZv4gVPQ7qtWT/ZEqwQ4DXJz2PAr83yAADm3RYrPvyjOcpBQxJd/iLSAc0Ncm6B815bRIuNG2myRMFJvbEyVvdcDpq2L1aRk/3qZPqdqQDA1+3iheWIU/cqzNyD2/3TkMRVqhXOLB+A5ljtfYx/ErS2K9N/CoMysYtIukMfYDioh25NncYIPZgBj2XNOR2njNoKBCXVqQOWFf/PwojnGBwmNy5Hew101ktBRI/4r3AH7Fr6HkjIvOxXU8b7QGp7woobRX7V/W5iO/BjKW79X0zulUZC/MUpVLOOJW1MonrG9iS8vLJL5D8JPGrIBjJQUWZ/DbpxPVkzAy357QTe1kA==
X-MS-TrafficTypeDiagnostic: CY1PR07MB2167:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2167;31:ptpck1mCe9tKo3tseeRQLau9Y9GBcfKWJEXfCMO/5eu2PpQ989XeO8+3TB7k3rJAp0x79pPaO9o+wSZduvte/uUEriWM4Gc9ySJV6M01ji2eOPDLRMtdoyjIhii5ndni2tAqOL6Osv+gO8fkNnjp6pcqyGEhE0IMDpRO5IdPyHcmK3LZAvfkTPPOkpEraHawtC+rjlm/kpVQRx9tWifnKXrsLu5TSP+KrTiMZEJVbwI=;20:YC4SR3rhFFezUJ/1AklgDY7R0QfDxwO9iA6tyw0Ib84Dn+9Az0ASr2YUsYlW5VYtrCzZtYmq6evXi0pHigTJnclbtAX3FCPPuDTXcdT9yhDqKoGot0Yc6M0pyWY/zkVKP3ycbHk2naOaYsojBCRrtNx4W1oeMiff9020GRpUsVzG3MpmPzAXd7qugBRcI5ufwukoOEw6hacQKA9q0t1xz3WRgy3EKknlrBfYzi3LSRB8HNH/iEbP2wgng49vFNvXB8aUOyxMPvIgSNvEVULNQgO64fDhjNzGljUkpEa/IAGh+jV9s/p1XdbBr/6SoFN1tTtuU7X1tKezhstOf+kh6fSZ0FiJELJCO1EXSKhv88TPdNFbN3yJhc6BrqYn+fuHDe9FCqMMzcJgWusQPui+bMfqU2BMbxatqPzqvLtD4OzeZ/VOdF1uh/UAhdTnjG5prpjuIkBq65Q2oA0nGZ1j5R+hnYdIBKRt5czFeqHpz2XO1F4hrDsztkjFcg5TSNCV
X-Microsoft-Antispam-PRVS: <CY1PR07MB2167E0DC8E2F14BF3127B155D08A0@CY1PR07MB2167.namprd07.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2167;4:qxlZiGbHaon52Z2rchQWZ5p17DCoOHbPHBs5juyNLIHey5cZ2jJ/UyufRk9GtPuoNKjDCf95TRC+3KygdAd0NP01HIxdbk+0ddpcS2gx+QCTkjx+pxWkx2TpPc3wRPTjq9Y/VBfLNizAyhs2RDuL0JWAQQOJnG2sist5fNPGSKxJXnPA025vmsb0SbrDwrDjxmDom3wY27g5soyCtXrxnOXAfdnNJ9b/uSdtdT/56xWVmUwty0ij6vnJAEeh1sHiEyDeG2F2Rjn3+a/SLiCI/JQZ2Kx/gpFgLlOv5iEzdsXoE3c6Ea1RGvG8QN/4MY7k
X-Forefront-PRVS: 0911D5CE78
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR07MB2167;23:QdYqYINAlzoH2fLlsKKqdi5CcAbpenC0IKP65xIl1?=
 =?us-ascii?Q?ygXExERuSs6EKLHhlf8IDbqWsgKaAKcBrGe5Z0LKB3+gx01JKltY8YIXPn8T?=
 =?us-ascii?Q?FkitbzpZSWT50QHq0SvaUxg+5xXHCnGE+9b8xllCpLIwu1LVbeifGyKrW/Og?=
 =?us-ascii?Q?SZ3y1umzAu9qKryIQa4o82HlGUtFOgxAul+niUtTi0nlr1Me987Vugv7oQIS?=
 =?us-ascii?Q?x5V/27GR08t3VeuluQDH8v38NU9bsBTrMHaYh9WrcdiR4tA3labMisyrAfLd?=
 =?us-ascii?Q?c4s9WfPVjtKZmNMLyd0fQAZxYASjNS4cvZTOzXc8VLjcYuZScYAOeo3jmiie?=
 =?us-ascii?Q?+b/zBeMhJteFCNKRTlVu39c6kveOWvD8/qvrvSDtK7CIF6WNh1NUNJBrTlmT?=
 =?us-ascii?Q?WLkM7LpQGZcGb7S9XusO3Ya0vic95y8Lvga5SVDgTBj6bqEVoHYeJZDbCFMm?=
 =?us-ascii?Q?h5+XHV3d5JvSgQvrADOi6/5pezJqQZHrCDNF9fhN+4BBb8+dRis5GiBBr4U0?=
 =?us-ascii?Q?UXHh9aq85zeDO475Al2BrguzvStlNyEvebtL9yWJOhYBMDKNpOnpoTujgWCz?=
 =?us-ascii?Q?zP2TkEHcEb/xtIcp7aDtiRkIGPYXT1AS9RFCHAScCrh6+kMIEE+ocslkqoT/?=
 =?us-ascii?Q?t35DfVixSW2CazHV7Rida8RkZY46lFywImihA6UUSZsaAeHv9gzDSefGcwM0?=
 =?us-ascii?Q?ZeTWQKtM+ozJ/Ezkl0M8RI6uTDTWJ/vL2fhZ6CTZmOHZqJT6tfA5U6VFesds?=
 =?us-ascii?Q?SzNY5HPbSU6/fiJM4BPtLyl0TlZlH+i6NaFuzCdQxm4VSCWBNQscw/hz2s9D?=
 =?us-ascii?Q?xV/cB4xSUJzwQkAStJE4s2dIKh3630BARzRgPcxBNKrUXgIDJOqNmf8eYZf+?=
 =?us-ascii?Q?KsCYw+U7n8/rRH+UxpCx5kQanMC5pXqObPXvPL3p1xBxUjh0TbIWYifoJDMi?=
 =?us-ascii?Q?YFxXkxPfVOSO1T2hckWHOptvvEm9oUyqvrEGfqanTyF571QA9+p5bUt+1l+p?=
 =?us-ascii?Q?Ipc78HfllABqYH8uF0dHdEyy1hD7Haek7Pq9G7MJjZqCsOWUxlrn5+5WfYxf?=
 =?us-ascii?Q?gUxI5KFP/g93lYMNetqTqQvsEHOMpU9yMktdxngcZZButaBdDXsBnefIwi6U?=
 =?us-ascii?Q?L2bALtXNDVdAYFzSjwoSa9vt6k5qLjK2D08C12NRIHLPEhlG57Xw8U1wM0OX?=
 =?us-ascii?Q?hO75lErx0jJDUolfZPijRq5OEYIBP6CxTu5ROVF4dzRYAcrF/sGJpdXJoL8a?=
 =?us-ascii?Q?Y1w14GU0UYbeVs0YPo=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: d9ZaeDaN0xeNFFiqkfhJMWh0L6ND+OLcyBWaXMpUmndougMTDt8VKvax8/dPJXdpjhpAyECI7Z0IzuA0xZ10lQyb8ywBN5JB7e56Eb2be5Qnl/A0vlSewQJnzIxUOhdVBMFfsack4SJzZMSIpo0xTXV0iG2iWNlhcKm8wGgfAl5Ss02SESIySfEgidoxHqe0piJYl8V0hO6I+U29FPx+W6u/L7SentB/A1tljXT4GJCg6FQe3rFdLC0n0DemfGem8Tc782F2qv6Yu/EGN+v3ADDMwxsb0Rv24GnGZ0+K5p1duNYPSp7cgFNSrF5zjkSA
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2167;6:mi3Bd3MBPfOdQtY1BEn+ZBPsd8a3FRx6uPR0nfoyMipgC98xxQdHabviaY4ERBCcMkdpeBnuJ84LBRaDIVE5+vfezoWlBqrH9Wj3i2q1jbxWWX/Qiq1qkq8lVIqXRkPfjZ1WSeQAqLREZiNNnjKBSRYndEt35XUwROa+xaBXSNCd0y0Y63l+cVJOIbohziQSueEJVINIfY9PCpvBaR6RImLUS32jFRS5yyrli2H1cN8iyQU7xWiCd1aA3zgJDB4C7goc3wJhZBn2bzKgza7Oy5JfYuf582jVD4Q3eyyAWiF5HUHVhditRSYWpSrKjh8/YDhzYR2rasfAN04rhue9CUvn4AGzcYL9lO5V655Ys66abh1RtvsJeq0EVPgpqshGQHQw49RUS5t9SCoUbL5LhxGt4QaT/zUyVSFqpCLahCWzhhmpqXtfSlVezO4UEQI59Fu03t/puogxHqIVyMZ8JQ==;5:06wAmhI2ZPdNt2YY6qy6S2hCOq5E2anpSpogJ0LhPAWlLo/qOk9g57Q0+55slBTJOCvqIScfgqFutKVqyD/E7UTMKMV4FfUwca0pbBZl+FIf48TLt+4Lg0g4O6QOxJHYh1LO5ys8Ls5REnjxlYuj5RgfF3Ht32NBz79eS7Lvt6YkMFfLgqj0WJGN1/GItMzaURnXLl0wVCjANrUIeC/Z0Q==;7:8tZh50NCWYI3GKhpO6S8YvRdkM0hQZvh4Xe3dBvwG3sFOS86qBp7t+akip8DMBMJjQX6DoZpbdh74V1aYClaAYkGwdWv9RVsAtX3BOskJUuSyHbUhTc4RM7kKK/OEvZdG9ZCMf068yIL3dLyYdLSng==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2167;20:PRsKO0fyciV/QHA9mYTjfxjXR+FKUDLgAjTusEX4VSRmpGkVJXSTRe6tPsIiWogoUzz9m5hUSEUAJxyYGm5YgMPDcYXXtjEdWTaG4SELQl3gedFM40qZiZcbozD8fN0a96F/vOomVj2Vz1pNAtm4xxCbu/hXpFec7A6TrSBRaDNQ7EtM/6r+Gmnk1NU976oBa4ZEuDmMawj5fEbBPdbne0/HUeUuUnk3QmIFdYEhSd/DRaXjRi2vDIISrrR6gcdh
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2019 12:22:57.9171
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdf20adf-dfa8-435f-60f8-08d675640644
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR07MB2167
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-08_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901080102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a driver for Cadence RTC controller.

It can be enabled with RTC_DRV_CADENCE Kconfig option.
It supports waking system from sleep modes.

Signed-off-by: Jan Kotas <jank@cadence.com>
---
 drivers/rtc/Kconfig       |  10 ++
 drivers/rtc/Makefile      |   1 +
 drivers/rtc/rtc-cadence.c | 404 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 415 insertions(+)
 create mode 100644 drivers/rtc/rtc-cadence.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 225b0b851..0aba341ad 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1508,6 +1508,16 @@ config RTC_DRV_ARMADA38X
 	  This driver can also be built as a module. If so, the module
 	  will be called armada38x-rtc.
 
+config RTC_DRV_CADENCE
+	tristate "Cadence RTC driver"
+	depends on OF && HAS_IOMEM
+	help
+	  If you say Y here you will get access to Cadence RTC IP
+	  found on certain SOCs.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called rtc-cadence.
+
 config RTC_DRV_FTRTC010
 	tristate "Faraday Technology FTRTC010 RTC"
 	depends on HAS_IOMEM
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index df022d820..5adb41b45 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_RTC_DRV_AU1XXX)	+= rtc-au1xxx.o
 obj-$(CONFIG_RTC_DRV_BQ32K)	+= rtc-bq32k.o
 obj-$(CONFIG_RTC_DRV_BQ4802)	+= rtc-bq4802.o
 obj-$(CONFIG_RTC_DRV_BRCMSTB)	+= rtc-brcmstb-waketimer.o
+obj-$(CONFIG_RTC_DRV_CADENCE)	+= rtc-cadence.o
 obj-$(CONFIG_RTC_DRV_CMOS)	+= rtc-cmos.o
 obj-$(CONFIG_RTC_DRV_COH901331)	+= rtc-coh901331.o
 obj-$(CONFIG_RTC_DRV_CPCAP)	+= rtc-cpcap.o
diff --git a/drivers/rtc/rtc-cadence.c b/drivers/rtc/rtc-cadence.c
new file mode 100644
index 000000000..18fc3f8e3
--- /dev/null
+++ b/drivers/rtc/rtc-cadence.c
@@ -0,0 +1,404 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2019 Cadence
+ *
+ * Authors:
+ *  Jan Kotas <jank@cadence.com>
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/io.h>
+#include <linux/rtc.h>
+#include <linux/clk.h>
+#include <linux/bcd.h>
+#include <linux/bitfield.h>
+#include <linux/interrupt.h>
+#include <linux/pm_wakeirq.h>
+
+/* Registers */
+#define CDNS_RTC_CTLR		0x00
+#define CDNS_RTC_HMR		0x04
+#define CDNS_RTC_TIMR		0x08
+#define CDNS_RTC_CALR		0x0C
+#define CDNS_RTC_TIMAR		0x10
+#define CDNS_RTC_CALAR		0x14
+#define CDNS_RTC_AENR		0x18
+#define CDNS_RTC_EFLR		0x1C
+#define CDNS_RTC_IENR		0x20
+#define CDNS_RTC_IDISR		0x24
+#define CDNS_RTC_IMSKR		0x28
+#define CDNS_RTC_STSR		0x2C
+#define CDNS_RTC_KRTCR		0x30
+
+/* Control */
+#define CDNS_RTC_CTLR_TIME	BIT(0)
+#define CDNS_RTC_CTLR_CAL	BIT(1)
+#define CDNS_RTC_CTLR_TIME_CAL	(CDNS_RTC_CTLR_TIME | CDNS_RTC_CTLR_CAL)
+
+/* Status */
+#define CDNS_RTC_STSR_VT	BIT(0)
+#define CDNS_RTC_STSR_VC	BIT(1)
+#define CDNS_RTC_STSR_VTA	BIT(2)
+#define CDNS_RTC_STSR_VCA	BIT(3)
+#define CDNS_RTC_STSR_VT_VC	(CDNS_RTC_STSR_VT | CDNS_RTC_STSR_VC)
+#define CDNS_RTC_STSR_VTA_VCA	(CDNS_RTC_STSR_VTA | CDNS_RTC_STSR_VCA)
+
+/* Keep RTC */
+#define CDNS_RTC_KRTCR_KRTC	BIT(0)
+
+/* Alarm, Event, Interrupt */
+#define CDNS_RTC_AEI_HOS	BIT(0)
+#define CDNS_RTC_AEI_SEC	BIT(1)
+#define CDNS_RTC_AEI_MIN	BIT(2)
+#define CDNS_RTC_AEI_HOUR	BIT(3)
+#define CDNS_RTC_AEI_DATE	BIT(4)
+#define CDNS_RTC_AEI_MNTH	BIT(5)
+#define CDNS_RTC_AEI_ALRM	BIT(6)
+
+/* Time */
+#define CDNS_RTC_TIME_H		GENMASK(7, 0)
+#define CDNS_RTC_TIME_S		GENMASK(14, 8)
+#define CDNS_RTC_TIME_M		GENMASK(22, 16)
+#define CDNS_RTC_TIME_HR	GENMASK(29, 24)
+#define CDNS_RTC_TIME_PM	BIT(30)
+#define CDNS_RTC_TIME_CH	BIT(31)
+
+/* Calendar */
+#define CDNS_RTC_CAL_DAY	GENMASK(2, 0)
+#define CDNS_RTC_CAL_M		GENMASK(7, 3)
+#define CDNS_RTC_CAL_D		GENMASK(13, 8)
+#define CDNS_RTC_CAL_Y		GENMASK(23, 16)
+#define CDNS_RTC_CAL_C		GENMASK(29, 24)
+#define CDNS_RTC_CAL_CH		BIT(31)
+
+#define CDNS_RTC_MAX_REGS_TRIES	3
+
+struct cdns_rtc {
+	struct rtc_device *rtc_dev;
+	struct clk *pclk;
+	struct clk *ref_clk;
+	void __iomem *regs;
+	int irq;
+};
+
+static void cdns_rtc_set_enabled(struct cdns_rtc *crtc, bool enabled)
+{
+	u32 reg = enabled ? 0x0 : CDNS_RTC_CTLR_TIME_CAL;
+
+	writel(reg, crtc->regs + CDNS_RTC_CTLR);
+}
+
+static irqreturn_t cdns_rtc_irq_handler(int irq, void *id)
+{
+	struct device *dev = id;
+	struct cdns_rtc *crtc = dev_get_drvdata(dev);
+
+	/* Reading the register clears it */
+	if (!(readl(crtc->regs + CDNS_RTC_EFLR) & CDNS_RTC_AEI_ALRM))
+		return IRQ_NONE;
+
+	rtc_update_irq(crtc->rtc_dev, 1, RTC_IRQF | RTC_AF);
+	return IRQ_HANDLED;
+}
+
+static u32 cdns_rtc_time2reg(struct rtc_time *tm)
+{
+	return FIELD_PREP(CDNS_RTC_TIME_S,  bin2bcd(tm->tm_sec))
+	     | FIELD_PREP(CDNS_RTC_TIME_M,  bin2bcd(tm->tm_min))
+	     | FIELD_PREP(CDNS_RTC_TIME_HR, bin2bcd(tm->tm_hour));
+}
+
+static void cdns_rtc_reg2time(u32 reg, struct rtc_time *tm)
+{
+	tm->tm_sec  = bcd2bin(FIELD_GET(CDNS_RTC_TIME_S, reg));
+	tm->tm_min  = bcd2bin(FIELD_GET(CDNS_RTC_TIME_M, reg));
+	tm->tm_hour = bcd2bin(FIELD_GET(CDNS_RTC_TIME_HR, reg));
+}
+
+static int cdns_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct cdns_rtc *crtc = dev_get_drvdata(dev);
+	u32 reg;
+
+	cdns_rtc_set_enabled(crtc, false);
+
+	reg = readl(crtc->regs + CDNS_RTC_TIMR);
+	cdns_rtc_reg2time(reg, tm);
+
+	reg = readl(crtc->regs + CDNS_RTC_CALR);
+	tm->tm_mday = bcd2bin(FIELD_GET(CDNS_RTC_CAL_D, reg));
+	tm->tm_mon  = bcd2bin(FIELD_GET(CDNS_RTC_CAL_M, reg)) - 1;
+	tm->tm_year = bcd2bin(FIELD_GET(CDNS_RTC_CAL_Y, reg))
+		    + bcd2bin(FIELD_GET(CDNS_RTC_CAL_C, reg)) * 100 - 1900;
+	tm->tm_wday = bcd2bin(FIELD_GET(CDNS_RTC_CAL_DAY, reg)) - 1;
+
+	cdns_rtc_set_enabled(crtc, true);
+	return 0;
+}
+
+static int cdns_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct cdns_rtc *crtc = dev_get_drvdata(dev);
+	u32 timr, calr, stsr;
+	int ret = -EIO;
+	int year = tm->tm_year + 1900;
+	int tries;
+
+	cdns_rtc_set_enabled(crtc, false);
+
+	timr = cdns_rtc_time2reg(tm);
+
+	calr = FIELD_PREP(CDNS_RTC_CAL_D, bin2bcd(tm->tm_mday))
+	     | FIELD_PREP(CDNS_RTC_CAL_M, bin2bcd(tm->tm_mon + 1))
+	     | FIELD_PREP(CDNS_RTC_CAL_Y, bin2bcd(year % 100))
+	     | FIELD_PREP(CDNS_RTC_CAL_C, bin2bcd(year / 100))
+	     | FIELD_PREP(CDNS_RTC_CAL_DAY, tm->tm_wday + 1);
+
+	/* Update registers, check valid flags */
+	for (tries = 0; tries < CDNS_RTC_MAX_REGS_TRIES; tries++) {
+		writel(timr, crtc->regs + CDNS_RTC_TIMR);
+		writel(calr, crtc->regs + CDNS_RTC_CALR);
+		stsr = readl(crtc->regs + CDNS_RTC_STSR);
+
+		if ((stsr & CDNS_RTC_STSR_VT_VC) == CDNS_RTC_STSR_VT_VC) {
+			ret = 0;
+			break;
+		}
+	}
+
+	cdns_rtc_set_enabled(crtc, true);
+	return ret;
+}
+
+static int cdns_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
+{
+	struct cdns_rtc *crtc = dev_get_drvdata(dev);
+
+	if (enabled) {
+		writel((CDNS_RTC_AEI_SEC | CDNS_RTC_AEI_MIN | CDNS_RTC_AEI_HOUR
+			| CDNS_RTC_AEI_DATE | CDNS_RTC_AEI_SEC),
+		       crtc->regs + CDNS_RTC_AENR);
+		writel(CDNS_RTC_AEI_ALRM, crtc->regs + CDNS_RTC_IENR);
+	} else {
+		writel(0, crtc->regs + CDNS_RTC_AENR);
+		writel(CDNS_RTC_AEI_ALRM, crtc->regs + CDNS_RTC_IDISR);
+	}
+
+	return 0;
+}
+
+static int cdns_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
+{
+	struct cdns_rtc *crtc = dev_get_drvdata(dev);
+	u32 reg;
+
+	reg = readl(crtc->regs + CDNS_RTC_TIMAR);
+	cdns_rtc_reg2time(reg, &alarm->time);
+
+	reg = readl(crtc->regs + CDNS_RTC_CALAR);
+	alarm->time.tm_mday = bcd2bin(FIELD_GET(CDNS_RTC_CAL_D, reg));
+	alarm->time.tm_mon  = bcd2bin(FIELD_GET(CDNS_RTC_CAL_M, reg)) - 1;
+
+	return 0;
+}
+
+static int cdns_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
+{
+	struct cdns_rtc *crtc = dev_get_drvdata(dev);
+	int ret = -EIO;
+	int tries;
+	u32 timar, calar, stsr;
+
+	cdns_rtc_alarm_irq_enable(dev, 0);
+
+	timar = cdns_rtc_time2reg(&alarm->time);
+	calar = FIELD_PREP(CDNS_RTC_CAL_D, bin2bcd(alarm->time.tm_mday))
+	      | FIELD_PREP(CDNS_RTC_CAL_M, bin2bcd(alarm->time.tm_mon + 1));
+
+	/* Update registers, check valid alarm flags */
+	for (tries = 0; tries < CDNS_RTC_MAX_REGS_TRIES; tries++) {
+		writel(timar, crtc->regs + CDNS_RTC_TIMAR);
+		writel(calar, crtc->regs + CDNS_RTC_CALAR);
+		stsr = readl(crtc->regs + CDNS_RTC_STSR);
+
+		if ((stsr & CDNS_RTC_STSR_VTA_VCA) == CDNS_RTC_STSR_VTA_VCA) {
+			ret = 0;
+			break;
+		}
+	}
+
+	if (!ret)
+		cdns_rtc_alarm_irq_enable(dev, alarm->enabled);
+	return ret;
+}
+
+static const struct rtc_class_ops cdns_rtc_ops = {
+	.read_time	= cdns_rtc_read_time,
+	.set_time	= cdns_rtc_set_time,
+	.read_alarm	= cdns_rtc_read_alarm,
+	.set_alarm	= cdns_rtc_set_alarm,
+	.alarm_irq_enable = cdns_rtc_alarm_irq_enable,
+};
+
+static int cdns_rtc_probe(struct platform_device *pdev)
+{
+	struct cdns_rtc *crtc;
+	struct resource *res;
+	int ret;
+	unsigned long ref_clk_freq;
+
+	crtc = devm_kzalloc(&pdev->dev, sizeof(*crtc), GFP_KERNEL);
+	if (!crtc)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	crtc->regs = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(crtc->regs))
+		return PTR_ERR(crtc->regs);
+
+	crtc->irq = platform_get_irq(pdev, 0);
+	if (crtc->irq < 0)
+		return -EINVAL;
+
+	crtc->pclk = devm_clk_get(&pdev->dev, "pclk");
+	if (IS_ERR(crtc->pclk)) {
+		ret = PTR_ERR(crtc->pclk);
+		dev_err(&pdev->dev,
+			"Failed to retrieve the peripheral clock, %d\n", ret);
+		return ret;
+	}
+
+	crtc->ref_clk = devm_clk_get(&pdev->dev, "ref_clk");
+	if (IS_ERR(crtc->ref_clk)) {
+		ret = PTR_ERR(crtc->ref_clk);
+		dev_err(&pdev->dev,
+			"Failed to retrieve the reference clock, %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(crtc->pclk);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"Failed to enable the peripheral clock, %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(crtc->ref_clk);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"Failed to enable the reference clock, %d\n", ret);
+		goto err_disable_pclk;
+	}
+
+	ref_clk_freq = clk_get_rate(crtc->ref_clk);
+	if ((ref_clk_freq != 1) && (ref_clk_freq != 100)) {
+		dev_err(&pdev->dev,
+			"Invalid reference clock frequency %lu Hz.\n",
+			ref_clk_freq);
+		ret = -EINVAL;
+		goto err_disable_ref_clk;
+	}
+
+	ret = devm_request_irq(&pdev->dev, crtc->irq,
+			       cdns_rtc_irq_handler, 0,
+			       dev_name(&pdev->dev), &pdev->dev);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"Unable to request interrupt for the device, %d\n",
+			ret);
+		goto err_disable_ref_clk;
+	}
+
+	/* Always use 24-hour mode */
+	writel(0, crtc->regs + CDNS_RTC_HMR);
+
+	device_init_wakeup(&pdev->dev, 1);
+	platform_set_drvdata(pdev, crtc);
+	cdns_rtc_set_enabled(crtc, true);
+
+	crtc->rtc_dev = devm_rtc_device_register(&pdev->dev,
+						 dev_name(&pdev->dev),
+						 &cdns_rtc_ops,
+						 THIS_MODULE);
+	if (IS_ERR(crtc->rtc_dev)) {
+		ret = PTR_ERR(crtc->rtc_dev);
+		dev_err(&pdev->dev, "Unable to register the rtc device, %d\n",
+			ret);
+		goto err_stop_rtc;
+	}
+
+	return 0;
+
+err_stop_rtc:
+	cdns_rtc_set_enabled(crtc, false);
+
+err_disable_ref_clk:
+	clk_disable_unprepare(crtc->ref_clk);
+
+err_disable_pclk:
+	clk_disable_unprepare(crtc->pclk);
+
+	return ret;
+}
+
+static int cdns_rtc_remove(struct platform_device *pdev)
+{
+	struct cdns_rtc *crtc = platform_get_drvdata(pdev);
+
+	cdns_rtc_alarm_irq_enable(&pdev->dev, 0);
+	device_init_wakeup(&pdev->dev, 0);
+
+	clk_disable_unprepare(crtc->pclk);
+	clk_disable_unprepare(crtc->ref_clk);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int cdns_rtc_suspend(struct device *dev)
+{
+	struct cdns_rtc *crtc = dev_get_drvdata(dev);
+
+	if (device_may_wakeup(dev))
+		enable_irq_wake(crtc->irq);
+
+	return 0;
+}
+
+static int cdns_rtc_resume(struct device *dev)
+{
+	struct cdns_rtc *crtc = dev_get_drvdata(dev);
+
+	if (device_may_wakeup(dev))
+		disable_irq_wake(crtc->irq);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(cdns_rtc_pm_ops, cdns_rtc_suspend, cdns_rtc_resume);
+
+static const struct of_device_id cdns_rtc_of_match[] = {
+	{ .compatible = "cdns,rtc-r109v3" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, cdns_rtc_of_match);
+
+static struct platform_driver cdns_rtc_driver = {
+	.driver = {
+		.name = "cdns-rtc",
+		.of_match_table = cdns_rtc_of_match,
+		.pm = &cdns_rtc_pm_ops,
+	},
+	.probe = cdns_rtc_probe,
+	.remove = cdns_rtc_remove,
+};
+module_platform_driver(cdns_rtc_driver);
+
+MODULE_AUTHOR("Jan Kotas <jank@cadence.com>");
+MODULE_DESCRIPTION("Cadence RTC driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:cdns-rtc");
-- 
2.15.0

