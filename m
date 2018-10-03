Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4634C64EBC
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 16:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 576DA2089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 16:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="qCz1adpV";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="EoJ5nDPb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 576DA2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbeJCWvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 18:51:48 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:44178 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726833AbeJCWvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 18:51:48 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w93G2E5e028498;
        Wed, 3 Oct 2018 09:02:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=hzPJkYeOiLRYOrQNeqZiwRBYl2WuEdYSshlcogVqL1g=;
 b=qCz1adpVbicpGpGrk8S74dmSjNZ3bhJxPkbjzYAsvylJ5BB63UTb0DFxMDFGZuZg3XjR
 AnVT3LuGU9hPPGclVbN4/JPgM09M+qlwkMLWUapvxu/Dnbr/IPB1ndTYp3LwPoJuss6q
 CMZmJmDc2ltvEPsLziG+s0Jec7oUQsTJdADcDBTvjIPpjOQF3N2aArlrHpWlFGXuwsMF
 KarrBU28Z8Min3JTYtHJr1M2FBBc+FMcJrrROXVOVdPa63xoDKHcl3kwVTxjDZqsuNZl
 W8efFwEuCjO3PtcMt6Kle+MvMLIlkg2y55CWvEBluEYXJG5A/wW04fBrh/oRXm8PxDxj tA== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=adouglas@cadence.com
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp0020.outbound.protection.outlook.com [216.32.180.20])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2mvw32s0tu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 03 Oct 2018 09:02:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzPJkYeOiLRYOrQNeqZiwRBYl2WuEdYSshlcogVqL1g=;
 b=EoJ5nDPbOMUzWyGCWOnLfSMOtIT6tbg00Oyh7Lsw6/MF6GPVOjZc9qKd9MMnBk40RTyh3BLq0k69Zg7OE4vPmQU0EVlwQDLmiSfsbv3eiL39L3ZIQKr5AhHzGvHcaTiE8DD08YX/Ea/Fv9gb5XP/HVT4i1pVCfFzgS+ShBXoizo=
Received: from DM5PR07CA0097.namprd07.prod.outlook.com (2603:10b6:4:ae::26) by
 DM6PR07MB4411.namprd07.prod.outlook.com (2603:10b6:5:bf::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.21; Wed, 3 Oct 2018 16:02:36 +0000
Received: from DM3NAM05FT029.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::204) by DM5PR07CA0097.outlook.office365.com
 (2603:10b6:4:ae::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1164.22 via Frontend
 Transport; Wed, 3 Oct 2018 16:02:36 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM3NAM05FT029.mail.protection.outlook.com (10.152.98.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1207.13 via Frontend Transport; Wed, 3 Oct 2018 16:02:36 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w93G2RUY008653
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 3 Oct 2018 09:02:35 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 3 Oct 2018 18:02:35 +0200
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Wed, 3 Oct 2018 18:02:34 +0200
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id w93G2RtK022139;
        Wed, 3 Oct 2018 17:02:27 +0100
Received: (from adouglas@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id w93G2R2R022136;
        Wed, 3 Oct 2018 17:02:27 +0100
From:   Alan Douglas <adouglas@cadence.com>
To:     <kishon@ti.com>, <linux-kernel@vger.kernel.org>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
CC:     Alan Douglas <adouglas@cadence.com>
Subject: [PATCH 1/2] dt-bindings: phy: Document cadence Sierra PHY bindings
Date:   Wed, 3 Oct 2018 17:02:25 +0100
Message-ID: <1538582545-22041-1-git-send-email-adouglas@cadence.com>
X-Mailer: git-send-email 1.9.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(136003)(346002)(2980300002)(36092001)(189003)(199004)(36756003)(14444005)(50466002)(87636003)(246002)(7636002)(305945005)(48376002)(356003)(2616005)(126002)(486006)(476003)(86362001)(426003)(51416003)(336012)(26005)(8936002)(8676002)(50226002)(186003)(2201001)(107886003)(42186006)(110136005)(105596002)(16586007)(106466001)(316002)(4326008)(47776003)(2906002)(26826003)(478600001)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB4411;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT029;1:ffAsNg1c1lXJGlINHbncL1nUkoE3KnBEMlCuG6Z0u7s7rNdZBTljBumn7uK+SYRBeJrV1QiExNeF12BugYXfu1zOFgB3QsJVXDa5NY+3SrAod9UcLr9Vj03wFuX3/dVH
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8cbfbeee-7d31-4f49-17c9-08d62949a318
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060);SRVR:DM6PR07MB4411;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4411;3:nm57D2MZfZGgcdt+m9ysL1dvc5176djfurWKMOlSczVcmyfYAR3NFwtng8aAJs5E4NdgVU8+7FfCidhO9ZrybhP5eDGGhUFJK0ppY/gjnxlPU2hvQFQegysluxjCWernQ5k+Tp0SADdDR4zIzFr/b3lF2hSzDogqMZpGbPNfhcX6N86cGKH8t/h7yJFUwhmhJavAHqyBV60ExaCJPo5M1DWgloEc9MDz/bIgXhtFRLeijIXvIZrhBY1yabIbS/G2doL1Ui/laGCZ1Dg/ekrkBlKCCWxO23RIAPmSsnHNjdM2KDHT2Qi78A8UWUIvDK6LI8QVHIOpiATelas7YGuukDOfYX1Hgo5BeA2VIVxlQmw=;25:pObAuUQLX9U6W7+9WhUSe0DPYoB5RZTkR3JAmUCMFA2sMY6spGQ1ddo1fxVKcDbgbLfriTYlz0J4aiSRyvgPInvgb1Xg8txpZTNeyndc5yGEzBdCpEEZioZthYQZTNYy9kD8aQ1V51VOaS8S87RvPJ48jtIICzXAUvXbYDGUfQXo0P5x3FJlV4FI4XNXS3LEhEELIL2giRMv7jfkHqYdOBmOey54Hn7qlZdGCE4/cTpapc7JQXjIeOKFmgpKGVyrrh20XXwUubWFrMngP8DLV/kABll/rfE/WzLNbqmvLq7sTh4KsmrT2ShWnk3VQJiFcJzMVuqac1V/WePEPZYG4A==
X-MS-TrafficTypeDiagnostic: DM6PR07MB4411:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4411;31:OOZGVkOJHvCXXxmV6cjrtsXC1Ed9tsD6a0bFN8sTPmrv9He89KYtozfhJT9yx+bCCAisoMlZ6yFSHFQSzBvIZzzBjBbMd1tMlW+UIGMfN9ThC/ompOoi8AJteHo+xWtbAibuG93HW87K+pEQi3w5SQfOm2obEkzA4rma87Hlrk6EjAaOW/kWPMRh9NxwkDwYjd1uKKPHIOyL0OGkqWdqm6MCt//fAdUR/VzEnt4PjbM=;20:F6nQYNEWW8a9Ww2Nk/mf0SZwKYmPrVjqF4GjQezPRKmKrg6uCzO5KW8Tx94GJ2ZmhYhsLcKLelMzUSrkgitt0vRZ/ca/Urg77yvGy3OdaC9X9SXs24PFge36eySo5Ur9Ri6HGMRCW555z6EP5ClF9tV8rJA2F2BnafD0o5uC2fEHTujVTlyDmgHoYNGL7Hp07iy1lyr/Go8K5lC05qOLTHJpe3I/2Udm2OhNxQ792eAvaHSO7oI/tQf5UZFZC/6dnibysFRlPVZ6/dNEDy69UTWRWfTscwZf2Xw1wl+KVQrZHC+oebPmAZRYksOrfQDeUi8RV+33iIf3JqPa29HpabKfwZYb8HFBuNJxH6eK5xD34rEAi2lrEgLgzs+/jXzt2GYouSX52xhYPQ9jYmiSVhM78JOMCyKhO11a0Vbm2KUseUDbYBiwYq8EnJMnVDYHFRSFXSY9oMfzlzGgAhXM9+xYUKQrJ88c0vRj1vxzscum7e5L4wnFuva3y9gMcSlN
X-Microsoft-Antispam-PRVS: <DM6PR07MB4411242EFC5645D37053A6A2D8E90@DM6PR07MB4411.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93003095)(3002001)(10201501046)(3231355)(944501410)(52105095)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:DM6PR07MB4411;BCL:0;PCL:0;RULEID:;SRVR:DM6PR07MB4411;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4411;4:GHzbgUVQotRSHdb2smdz7LyVknpA6S1oj8ICFpu9JJxnHm7MQzJeykYivB5vJrcQpaiQE1DzCVKJj0+bhVEcz8Q79Q9uaC3b8BIDvVbkC0Nnxv/qgIQ5amyj3mvnuZvfAmtcbNmBJu6aPyxbziO2zZwb9Ablcnt0PSY28GPhkqHU501Hzqj8m4kR9C+xxCtqDCd+Ot4zNK1cjc+Xvy6svIWgXMEoGjugVzgPFYe5AIlDOXv+PJGYb7rEK4L/mHm4QlCbZh79WeLfKEKWoOhZVUSjkt8Rot54/EXg2af9Eieu5d3xdr1pCScTzjYkE9z8
X-Forefront-PRVS: 0814A2C7A3
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR07MB4411;23:VNkUherSWthAIPH0EyG0+OJCJ8bPesSGohuYMmNmY?=
 =?us-ascii?Q?PxfC7gdL8pYrHOn7ddG7Pjond42my9wYPlM8ex4ugAjfc1wloFQD8oNCebVu?=
 =?us-ascii?Q?DyBJhk4l3RPfep+UKV0TWhw2p1ntwbLfWljU6v4Q/mxrxzxHEV43c+kYnQ9A?=
 =?us-ascii?Q?3QsOssg6tOZWyzte2WuCVkaqRgLP6+RhT68c7ISjXZ9drHpm4Z09XKkyRolF?=
 =?us-ascii?Q?BEW03KWfUmVoGpcpiUimPc4Rtit9fEkfGcpYJq9OUGZKnSgElwaeDAFRqXie?=
 =?us-ascii?Q?TJ6R6orA9VY0IDvktJ/iTKQiwPlNp5vAVrjAXR04ZZtQ8NiateffDGx/EYfn?=
 =?us-ascii?Q?vEMcCVoRw32I3GeWo3qTXsETE3y/Ywukmo2nzqNMmaDrwukjBN+7KftUHcIT?=
 =?us-ascii?Q?GF17Z9C0iYCPRp/vjQt9GYIVWSM1K3ChsDAE3V6nimF995vvLXhoLSZe/UJX?=
 =?us-ascii?Q?OikhahepK2kL21qy5xVChaDyfUAZuHfhcKA6LL3wQXcXORUoA11TZ5iZsJvX?=
 =?us-ascii?Q?jWCzpJ5NZY2tOJEgIA9ZQmpcHa2ny87Hpw9AKp/qbxRePKprTm758PVvL7zh?=
 =?us-ascii?Q?VpJa9OzF80HO6A8PQ5j/TOL0vIDvlpH5LBJd6ABBT74GmYQ0rod+bibMCBPR?=
 =?us-ascii?Q?f3r4sl/2cL7j+D0yfb755ncduIna6MFw627PsLG1/c00obAOew3wEjPEN0gF?=
 =?us-ascii?Q?PfDs98zPSSNqjHOW3xCAjO62QqNUrY19zWBFaP/DI+hJMQ9JC41y2Vj9AXb9?=
 =?us-ascii?Q?Ranc4b+bsSkM5Ogx3me/TEhjVmk8mU20xsPlY2FlJe/jCMCzR5XF/XTVdXcP?=
 =?us-ascii?Q?OfKka/RbP641vBEYmSooGR0CubUe98DGNeucTYCwdv5CyFwPGgOiIIOfhRY8?=
 =?us-ascii?Q?E1breE8854aAdDVn6HxIVmyYIZNIM7kxKJcu5x+ZBpI0Lj5+rtmjLzTAohHg?=
 =?us-ascii?Q?Hseublp9ZqcLf1dtjv7/ZIHvpjjl702vx84BzWd/29rU15urz5EAKla/kh6v?=
 =?us-ascii?Q?Ujw8xOgYlZbxt6VkXcXB6mF?=
X-Microsoft-Antispam-Message-Info: mBmiwpSxUrYIKoz0c+jCCrY+Us74nqDZuuQTnTsJNPZ6P3oyEGjnLgC/F4cBqJuJ32uhBzkM1rJiTq8AhzN/5Y98JA54UjEbWxtzQWljmj+sFC6Hb3RHhdj/WMhB/ojrJ7JnnDf6xnYRzLYWw2e1v6lZ44lmeoYoU/VRPVh+Uc27Yxp8tPZYKzpTDG6z6/vQJrjo1t7no47TAjYRXLP+xJY40QWWFYJWARZsOrVka2ToCZV0BVKOZkqlLJcxDxf0jRyih5gwmnDT7mGsowYoavAaq2GoP1aLNQV2DuDxu4z5U8w/Is6cQoZj5VFPOk80Sxs6NNKgDYV8QdEDufZiNTCHtdNxzrZQLLXSPr1tduYBJJGLNhzkEuHpFd3oGYQbNiMiVq4DiorgqmlQGtVpng==
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4411;6:e0qa6BtiEiFjijH8zRUPHF9CMrdKsId5/VgpUHzolJ+SjIM6EwQeGemP4GlTiCtoISaQwcq0PO3FOS72iDwizBLZ/m826DNdJ/piODeQ+pZiDmMZ7sqG3lub4FJuVg8+W3pd1Qz6VSAar3pMZ64niTU+iyNUFGtfcxntNb84WtFzI7IiFrmi2wd430M2eZOzzhlgJYlPZeVVRRO9gzKmpLO2Sg2579YVBu+dd4YvWZgBsQil+fbQQEbTa9Kk22t9UvQdoK5gr9xN2SydJqKohsZ3rX0chkYyCqzVKY7av6Qt+6cnWFiNPJOBzNG1gnwbGOT/SjWjsHgZSPtvT7GjOEQ1EkHPHeYP+JuBvmZC0eWgesor71+BTQdGiG0sUJycCS71TMNrzQ70b2gJIzRzsOsVQAdHCFDWo/zUCK0PKJ9x0QcxiDgQqlVzqI34/i7fMLVRr0Bz1I2XF//sgWUYdA==;5:tcZfmDF5e9VLYmRRrLb3XqNoDbDDn7UahvzGR8ta9TWrUZmfJw/TvOGCepngPEgZahNtNPpNDXXBTEuHrScXMLLS7AAMm8/MVrB7eLHQg9ZeBl9DallJzQV9ZUWDidRM2bjuyBSYu9h4+jwLJycxUVIcQAj6zzVyWyBZEk2qRr8=;7:p6KCc8a3HHs8JBaOLwfyGH77qkdQOXRhZHk53MVDJIMhQJyvXkI++t4gS7XmFsVnZg7Ek5mVOl4DUlN78yVcAq5JrxZO1FzwaBpHxnKEwJv+82hyQgi1gv/kDzRsaRS82VVVTHpIE2qtrBEkTCJtgNq8ZhLn9NN3IlFXGoHQBgf38EDDSGwOcohJGYXevEJ0DegiDyiGtAVBec0PMkeqPVj1lqm1CAkB1YlIkzOp0UaPINeOjpJDScYOk1Ca3xeU
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4411;20:1xNwNemfJGyf6UEbeM97N/UcgovC40kqOAMz0Qocs1XGFrPfaW/bPI7r17KQ0arMpkEGwzBla2ZfOILIxiaN8M6ypA/NY3RWKjeJQlRWoovDqwPuWzLyP8F+1KNTJMH1kp95bKxG3fLSJooY6Vns3oac/+SkldCdpL9gDHhCvpdO2jGH2KJwvBfd2eoh9EFxEJwOrfJPhBJTNRNBXM1r75q8ojudStZamvfG1CUs3eiCTkV48hP2xLV+trWaaVOP
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2018 16:02:36.1682
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cbfbeee-7d31-4f49-17c9-08d62949a318
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4411
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-03_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1810030154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT binding documentation for Sierra PHY.  The PHY supports
a number of different protocols, including PCIe and USB.

The PHY lanes may be configured as single or multi-lane links.
Each link is treated as a separate sub-node.  For example, if
there are 4 lanes in total the first 2 might be configured as
a multi-lane PCIe link while the other two are single lane
USB links, and in this case there would be 3 sub-nodes.

There are two resets for the PHY block (one for APB register
access, one for the PHY link) and separate resets for each
link.  For multi-lane links, the reset corresponds to the
reset line on the master lane, the resets on other lanes
have no effect.

Signed-off-by: Alan Douglas <adouglas@cadence.com>
---
 .../devicetree/bindings/phy/cdns-sierra-phy.txt    | 68 ++++++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/cdns-sierra-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/cdns-sierra-phy.txt b/Documentation/devicetree/bindings/phy/cdns-sierra-phy.txt
new file mode 100644
index 0000000..0e2f3e3
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/cdns-sierra-phy.txt
@@ -0,0 +1,68 @@
+Cadence Sierra PHY
+-----------------------
+
+Required properties:
+- compatible:	cdns,sierra-phy-t0
+- clocks:	Must contain an entry in clock-names.
+		See ../clocks/clock-bindings.txt for details.
+- clock-names:	Must be "phy_clk"
+- resets:	Must contain an entry for each in reset-names.
+		See ../reset/reset.txt for details.
+- reset-names:	Must include "sierra_reset" and "sierra_apb" and one for each
+		sub-node.
+		"sierra_reset" must control the reset line to the PHY.
+		"sierra_apb" must control the reset line to the APB PHY
+		interface.
+		The name of the reset for each sub-node should match the full
+		name of the sub-node.  The sub-node resets must control the
+		reset line for the master lane of the sub-node.
+- reg:		register range for the PHY.
+- #address-cells: Must be 1
+- #size-cells:	Must be 0
+
+Optional properties:
+- cdns,autoconf:	A boolean property whose presence indicates that the
+			PHY registers will be configured by hardware. If not
+			present, all sub-node optional properties must be
+			provided.
+
+Sub-nodes:
+  Each group of PHY lanes with a single master lane should be represented as
+  a sub-node. Note that the actual configuration of each lane is determined by
+  hardware strapping, and must match the configuration specified here.
+
+Sub-node required properties:
+- #phy-cells:	Generic PHY binding; must be 0.
+
+Sub-node optional properties:
+- reg:			The master lane number.  This is the lowest numbered
+			lane in the lane group.
+- cdns,num-lanes:	Number of lanes in this group.  From 1 to 4.  The
+			group is made up of consecutive lanes.
+- cdns,phy-type:	Can be PHY_TYPE_PCIE or PHY_TYPE_USB3, depending on
+			configuration of lanes.
+
+Example:
+	pcie_phy4: pcie-phy@fd240000 {
+		compatible = "cdns,sierra-phy-t0";
+		reg = <0x0 0xfd240000 0x0 0x40000>;
+		resets = <&phyrst 0>, <&phyrst 1>, <&phyrst 2>, <&phyrst 4>;
+		reset-names = "sierra_reset", "sierra_apb",
+				"pcie_phy@0", "pcie_phy@2";
+		clocks = <&phyclock>;
+		clock-names = "phy_clk";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pcie0_phy0: pcie-phy@0 {
+				reg = <0>;
+				cdns,num-lanes = <2>;
+				#phy-cells = <0>;
+				cdns,phy-type = <PHY_TYPE_PCIE>;
+		};
+		pcie0_phy1: pcie-phy@2 {
+				reg = <2>;
+				cdns,num-lanes = <1>;
+				#phy-cells = <0>;
+				cdns,phy-type = <PHY_TYPE_PCIE>;
+		};
+
-- 
1.9.0

