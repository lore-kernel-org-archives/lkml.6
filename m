Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB7CC0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 201F020843
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="XDGY+7h4";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="oQumxYjJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 201F020843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbeKDDFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 23:05:50 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:48796 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727281AbeKDDE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 23:04:29 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wA3Hpx2u030375;
        Sat, 3 Nov 2018 10:52:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=TPqdZt71GMdE6fcexZ05jpCNuBAKohAkHplfsrV966E=;
 b=XDGY+7h46EZJ3tb6faplPlJe9XOMlpnpQOfdMVkQRjFs/BHZbRnidZcbbph0Za45enfB
 Ge24MSG95saChJD0aNAzsVr/0u2Vi8d0+m3ZSj7PDH1FzCQ5BATKooiIlmwRwYIwoE5l
 QyI92EFQ5Xv5LhlLKt2qev/DMZRVEAl7rBZsWEiTfhOG4GiOrWWdu5wG0Tr70iuE9IAu
 iXaIasFOJjVyldVeo2ndMiBjLJ8SYXbhKCmmBKz8UGUho0mQ2FycnPwgu1Idvqc3bn5f
 K2v+wl5W6dC4UawjhFXqn+eucBFudax1eZHVhenbL8mTEqcKcAYViBhLpGNG1igic3QX gg== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp0087.outbound.protection.outlook.com [216.32.181.87])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2nh87rhmut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sat, 03 Nov 2018 10:52:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPqdZt71GMdE6fcexZ05jpCNuBAKohAkHplfsrV966E=;
 b=oQumxYjJrebl48AYXJTfKUGTa+XuHrcs2JSB98kEd9FYt8iwIEjyIsd7lCjOk6ZWgb+tCxd/AtGfjPyUo03MwhlEr8i9vWURFahp8XW06QXPfBLcCfJ0QTkSsTnf+qcninGc7D79WhYhIvU0RCgz4ey4DkqCalnC7KgFJQKFOa4=
Received: from DM5PR07CA0052.namprd07.prod.outlook.com (2603:10b6:4:ad::17) by
 BN7PR07MB5169.namprd07.prod.outlook.com (2603:10b6:408:25::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Sat, 3 Nov 2018 17:52:23 +0000
Received: from DM3NAM05FT054.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::202) by DM5PR07CA0052.outlook.office365.com
 (2603:10b6:4:ad::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1294.20 via Frontend
 Transport; Sat, 3 Nov 2018 17:52:23 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM3NAM05FT054.mail.protection.outlook.com (10.152.98.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1318.5 via Frontend Transport; Sat, 3 Nov 2018 17:52:22 +0000
Received: from mailrm1.global.cadence.com (mailrm1.cadence.com [10.209.213.2])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id wA3HqLjh009429
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Sat, 3 Nov 2018 10:52:21 -0700
X-CrossPremisesHeadersFilteredBySendConnector: mailrm1.global.cadence.com
Received: from mailrm1.global.cadence.com (10.209.213.2) by
 mailrm1.global.cadence.com (10.209.213.2) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sat, 3 Nov 2018 13:52:25 -0400
Received: from rmmaillnx1.cadence.com (10.209.208.46) by
 mailrm1.global.cadence.com (10.209.213.2) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Sat, 3 Nov 2018 13:52:25 -0400
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id wA3Hq9x5000566
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Sat, 3 Nov 2018 13:52:19 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sat, 3 Nov 2018 18:52:16 +0100
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Sat, 3 Nov 2018 18:52:16 +0100
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id wA3HqBgj006422;
        Sat, 3 Nov 2018 17:52:11 GMT
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id wA3HqBwZ006420;
        Sat, 3 Nov 2018 17:52:11 GMT
From:   Pawel Laszczak <pawell@cadence.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <rogerq@ti.com>,
        <linux-kernel@vger.kernel.org>, <adouglas@cadence.com>,
        <jbergsagel@ti.com>, <peter.chen@nxp.com>, <pjez@cadence.com>,
        <kurahul@cadence.com>, <pawell@cadence.com>
Subject: [RFC PATCH v1 07/14] usb:cdns3: Implements device operations part of the API
Date:   Sat, 3 Nov 2018 17:51:20 +0000
Message-ID: <1541267487-3664-8-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1541267487-3664-1-git-send-email-pawell@cadence.com>
References: <1541267487-3664-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-OrganizationHeadersPreserved: mailrm1.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(39850400004)(346002)(2980300002)(36092001)(199004)(189003)(446003)(87636003)(217873002)(14444005)(11346002)(246002)(2906002)(47776003)(48376002)(26826003)(36756003)(2616005)(4326008)(54906003)(86362001)(16586007)(2351001)(42186006)(316002)(107886003)(356004)(6666004)(476003)(7636002)(50226002)(51416003)(426003)(8676002)(305945005)(4720700003)(106466001)(26005)(76176011)(5660300001)(478600001)(186003)(126002)(105596002)(8936002)(6916009)(336012)(486006)(50466002)(309714004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB5169;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT054;1:Iw/yqVAxDfFugl36hN0XVaJ24qjjcSAWFGjktUlom1iyndcuSDMX4uieIapR2CSKf5MRKDDnpifE7SEoQXZ+5N5U5Zi+45xUwIpwLqc3dya2m8PsSc1Q5bfHrlpdEoYL
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5c1bf9f-d92d-448c-2403-08d641b51bcf
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060);SRVR:BN7PR07MB5169;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB5169;3:6G+bsjvnk/sPj0ovl8Jrspt9C/fHxSc06JZP6lrcxHdRZtdYxips+1WwwYQdStdBajQtP+LZ3gbJNLQ4kUmoM/phuEqdZLOPaALwXdw9e/17Q/QedBeOxymdUdrcFUWlyk8LUg5ubPHHi/2YVrObOqASBsJURlfEDh8OHSwVQeAHbsYonTa7sdraDzhpIJK2o3RtzODcQjieHc9xAPm0HivlUC/AA4ABV/7RJ3jsVXlYA+XnfIAeyHaZBzMKlRSIpZEoav2qjXHzNpcn4ELVZ9kxvEL/bq6WEpbE+wzHBHvXZmOJ463BSpkW8PkY3zBNM7/I+htl6/rf/Y+2LoMND/7V/jXZYTGNqtFV3Z+gPyA=;25:vQAPeeE8hhZhtSr8tQgy9dej+E+sVpbrA76Rbqa2Az1eskMV0Z1osXXDc54GRnupP+tokVqrsnazXHr0EY2y5mK14mSE6Ms79mlY4wf2AmEh5yK69mvB4iZg4gJAAlm5p5KuWrVQo3VdfQIYdkDfdjwqJERHjHa5uTT9F2sJzZenFJxJBUf4jWkAU+FbBUBDv3BIHe7Ic4w9FPPneLI85aSFVC3M3+9VIEzXX+z4SlAbDoyyE9tnWzF0jSdPqHqe90zp5SqZT0lWA6bjEcD8lkTua1AY1u6hW69PwjAanZ0Vpx80ZinAcutx/fKIHpdGVJsJ/z+OXVVqtfIdBw26Aw==
X-MS-TrafficTypeDiagnostic: BN7PR07MB5169:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB5169;31:pvB4uP+nEnSHKt6kEBgtTQYG1I3hPG/2FQjmwd2QkG9gUphkfLi54cX+1h65m0AakEhidtSGnjUo986v6UXDcYJLA9YZwXXDnE+SASfdO6vV6ix5Eil0i/ttPTUBLjYqpNgGv0j2jEW0E2egXQbYZfwSy/OYeVtV/Lx6rjTE8YZ2u82mXlCCTAIfve4tTOeV2v3Ut87N9i4LHYRfPP7v9iNhgdrajME2XpY0xG0bbbY=;20:PgrpVlXgS1VtD+DH63vtkZaB5Pr4XM2DyKZo3Bw/6u9Uup8odsoYvESsiSzv23lt9B540itydV6xRVSn3FCBd5jug6447l9NS1VmhrhG4CCOG/0ajqVqY0HFGMYLvny618JYBrUIW9CUGe5cP8i2vdWpTjWS5Sveoh7zhbztrnTGKCIGAqxf1mVv28vexxuMDqQ3jI0tXxHSsz1hZFw0ZOvgi0vdqUTafuMkQCrgP3VQNhNpDhVXKi/urFvlTjbiEJNQdFbNN87dcMZoepl2EWha0wzNRRUWayYffUAhxIUpAyqqSf8J4aKBuWySUqPqy1AOabq3QHiJv/85TxzFhLrBaCE+ePqx/wkd69D8x4UKSH5ojscD626JOOdwvJHOuv1dJoTRy6CDcjGBWR54st7lDe0BQHv0QZarL9TBKQlsRaJ82M4W3aJsE08lzVeYPi7/J8CHdMxWQ2q+mKn9gFzoNlIQxvJjdX6qVbZv2VtxnCnZ1/LMJEqTbQL2M8JG
X-Microsoft-Antispam-PRVS: <BN7PR07MB51696E75822E4595260DE94DDDC80@BN7PR07MB5169.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93003095)(3231382)(944501410)(52105095)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BN7PR07MB5169;BCL:0;PCL:0;RULEID:;SRVR:BN7PR07MB5169;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB5169;4:a6LVmN6YOZogMengwjVvpj6bgar5Q77fylp9GLnksspOaqxSiMmrvFKtCO7qc/HQgOxA0Ae1BOmDvMy6NdTyVULAB4o+Bn8wpfan2W/tVuJNJQA+0V49HUFnWNdY51PHhdD62yn8THwqkid5+JPEo1//YjM1QXQrpDIQBqEtMdDSWn9gfI/K+rYOEVl3Lr9hr6AvWIDP0ZuJCNRdo9YIolaPUOaesXjBEjt1Mo9iXfDsRDN79gyGLKCWLYSksfw9e4w8cNgPXIoOcG6cPgiVwiZk8KjyWOlmeh0iebc/74I1RZ9+H4R+Ya/W97i/RLsM
X-Forefront-PRVS: 08457955C4
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR07MB5169;23:M8+gRJuyfWqAPRtDmaudULkhHHi79aFMGruc1nGR0?=
 =?us-ascii?Q?Yp5nDXCS1HS0ed+iqhA/pPbQzBK0SqrvcQ1by2eTiiy+/9svKkxdtMAulSnp?=
 =?us-ascii?Q?zh1cy8Ja9inPM68V8b+Ir8i4Y/pt0qWX8hWRBoh5zdMe2CAYtL9iPMxdAksL?=
 =?us-ascii?Q?n95wpdUth1X4VZBEM8Rc6s0VwGxQCmA6xd/W+6EBxT3QeqmHvb8h6vhy3J3K?=
 =?us-ascii?Q?bXs96MojssilLTOTayDCfbrilf5hSx++Uc8PwJpyUdtUZO1/7Gt9ljRG/08Z?=
 =?us-ascii?Q?luAfQOttVjEBy4YQRQKJp57rCCt3We0VSUhyK3tykag4tvQjwHhwzlqotKKL?=
 =?us-ascii?Q?HEPanfU+E8hkjBTHmmyV54cKB/mHRFwRkRxrVvwYAb/LMHqyE+/4AVHTI3zL?=
 =?us-ascii?Q?P2tYCRmEhQIsJYk6vs9lwJvCqF1yjx1NEzoaziuS3iiYawBUF+HIVXrdjI1N?=
 =?us-ascii?Q?ex6+o+ZGFKNJxj1t7pZILEwb+GsSjQ9w3WSjjmEvL3PU5aQlb2cmZwiqnsYq?=
 =?us-ascii?Q?8M0ty79VBChCqcH0UKowfBg7OszUs9+yCpBLHBSJkouGmgQMJo87btaEqdJb?=
 =?us-ascii?Q?fRVOqBE1RsHUvWa5IdSYRXrw/wVLluiywksUxrphYovVY5qjFpy8YNLTv3CP?=
 =?us-ascii?Q?8y/taYsxl9rnqHe3ZkjSGiPGe3WSFcw/wD5aUVb+To7HPcNOT+2IR2QEQaK8?=
 =?us-ascii?Q?VKaEp6Btj1OjdlSoWvxbQRU3mJEYiH9luNMUXUsZzNRzTn+57/hoM6LZg9lA?=
 =?us-ascii?Q?aTQyGMqicI3UQuTYCqXSRGEtUydai28vPA6G1RQgFKJ2PoGOsTqAmgVMkxqb?=
 =?us-ascii?Q?c2M2N7HA10AmsNfu3nwBFK1ZTIZ+kKTjTiutbNpwwyRJ82p2H28MjLDZn8fG?=
 =?us-ascii?Q?cXhdaKEWFbiWTfbHF6kaRwmgfeyeIRSEx4r60P8QoA7SSm033C4VefAyTiV4?=
 =?us-ascii?Q?nZ8pHMunGO6Yx+362FaPh+BA6daCqTd/dkhBL205s33i+ljskJga5tDeBogc?=
 =?us-ascii?Q?FAtB2wXwaEzVn6H21XGoW3/t6V9JiEOhNX5N9hpRdGwMVvg/2RJ1s8IDpVXh?=
 =?us-ascii?Q?JHwBnErCN4fi2DCzm5aNptifBUqlD253A2noQOtTjSkaPqg5KjEcju+ejZD+?=
 =?us-ascii?Q?82y6jTALjdTWDjWCko3mR4p9ZYG5YAKrC2bD6I0y/g5cxKOSfdEdBSa3+06T?=
 =?us-ascii?Q?k+RjsJmXC8JPj4=3D?=
X-Microsoft-Antispam-Message-Info: reHPMVzz8H99AMO6JZfzY2PF7fCgo3DKYtDtiaONRw83MsEVg/5BkcnpiBtMJ2SC7B2gw+eeXISjPdqtUPvjD9bBoJJ51ZUn9CzTXzwdnbKUqMBZQBTy5KtgV3S3EyPP2cDHKHbOKh8xP4RUm2+6d4RIMi05TjGq9lGShXshp1qCkO5lixpmVYcaEs3Uj9km55V3zJ3sMssniMf1FDA8SiaKhL72GTcC21SIaz2XPwmfJYZoLZCK5xsWw8am8eq4qPv+lMuuOrgTyb1S2qJvCb45r3t+HjOBnQ6bJDDbR5ijgM2pQrHBGEYhYrBz2sEpon22GrP4OShAoXJule0j8TbnSCpzyVYkLHKBaTk5nxg=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB5169;6:U/zKL9bJk+fRSRmCNADBNzPxmpfVwdo/Y47ZnKAsVJ+/NjVG+73Ynkk+Zy6Fx93o6r+fj1IA+vWlNQssED1QxvkeNj5pH1rNosSWKtoqaTH1xWDVe+w+ELXBrsiPNGLYBcFndl8a6BSj4GGjUPb7pjMGUdI1C0HA3ZNtZnyeqlEf91pjgbpJkgXNJlKzjRotLttB7pGLbK7pKDhpo5i9JF5CIxEqAqW0mEBKQSN4BQTtktgA37I89Sys14wcImy59Z89S1/AecLSau04BD5aywjpx54kZ11/uXML1P2n/xnF8YHy/0VDypYkf0qhr2qpb3HSLCIEHSI/h5E17P13N7dMUAbRdSUEysGvvZzpvaJzjN+0SfR32lw+wZPLXUmaYSc52bjtbb5epPytfBkloO5AYmROSkE4xtpXZb/qxJJ0qdE34+F/XuYsi8Z1sCjSLzmRGzrpDBVupxHFkhpZ5Q==;5:rTL/FSC8kFNWnrBIHrQdxrzuzesfutDfZkrWUMrwWZgHtVOC3J5+EhD6ffBZUy6YMYAIfM8A4fndpCMxs89zyf/F5p4nBxIsLObeqUxLVx7FumWATh//AOaGZpHKOSbVzsBi5vJ836qbp0S6JYp8+Ne68Xu7QKxgJdlTMhTUI6E=;7:gr2QTK/GVjH9I87RAQgEcveNDhzZ2Gdx5TU3DkP5t8nZk+67BIO/hnqcmLzgXSfUOIp4DQNq4rOneiYyzbNcp+oNUe3PFJz+Xp+wHHaZZAQtR6rTp6pET4GrFfwwzZAaShLfZFhmTAP3buv7mplwNg==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB5169;20:lkHoVMDF0okmKfx7bFO01XrQTov5IJ+PHsV+2U/VSaeHsmw26DGNp22oW7l7Z59cn5WD6WsJr2ttvu+nUF3rl9ckEHA6Py+91xgAYyHl16PnUy2nQHjPba4yCdRy0jtICHTTjOELdlQ+FiH63UQyuAv0z6We7wJR5IahWyCiBMQt6oa4vPkXyFBODMaJxKJWsCDpqXJUnCyzOoLr/dvZZsbEC6bWZ714ephHyoGrjBVArkb02s6OhqyzQ7MScZZE
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2018 17:52:22.6887
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c1bf9f-d92d-448c-2403-08d641b51bcf
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB5169
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-03_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811030169
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch adds implementation callback function defined in
usb_gadget_ops object.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/gadget.c | 244 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 242 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
index e7975b00b21a..ff8306ac070e 100644
--- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/gadget.c
@@ -17,6 +17,36 @@
 #include "gadget-export.h"
 #include "gadget.h"
 
+/**
+ * cdns3_handshake - spin reading  until handshake completes or fails
+ * @ptr: address of device controller register to be read
+ * @mask: bits to look at in result of read
+ * @done: value of those bits when handshake succeeds
+ * @usec: timeout in microseconds
+ *
+ * Returns negative errno, or zero on success
+ *
+ * Success happens when the "mask" bits have the specified value (hardware
+ * handshake done). There are two failure modes: "usec" have passed (major
+ * hardware flakeout), or the register reads as all-ones (hardware removed).
+ */
+int cdns3_handshake(void __iomem *ptr, u32 mask, u32 done, int usec)
+{
+	u32	result;
+
+	do {
+		result = readl(ptr);
+		if (result == ~(u32)0)	/* card removed */
+			return -ENODEV;
+		result &= mask;
+		if (result == done)
+			return 0;
+		udelay(1);
+		usec--;
+	} while (usec > 0);
+	return -ETIMEDOUT;
+}
+
 /**
  * cdns3_set_register_bit - set bit in given register.
  * @ptr: address of device controller register to be read and changed
@@ -45,6 +75,20 @@ void cdns3_select_ep(struct cdns3_device *priv_dev, u32 ep)
 	wmb();
 }
 
+static void cdns3_free_trb_pool(struct cdns3_endpoint *priv_ep)
+{
+	struct cdns3_device *priv_dev = priv_ep->cdns3_dev;
+
+	dma_free_coherent(priv_dev->sysdev,
+			  TRB_SIZE * TRBS_PER_SEGMENT,
+			  priv_ep->trb_pool, priv_ep->trb_pool_dma);
+	priv_ep->trb_pool = NULL;
+
+	dma_free_coherent(priv_dev->sysdev, CDNS3_UNALIGNED_BUF_SIZE,
+			  priv_ep->aligned_buff, priv_ep->aligned_dma_addr);
+	priv_ep->aligned_buff = NULL;
+}
+
 /**
  * cdns3_irq_handler - irq line interrupt handler
  * @cdns: cdns3 instance
@@ -60,6 +104,114 @@ static irqreturn_t cdns3_irq_handler_thread(struct cdns3 *cdns)
 	return ret;
 }
 
+/* Find correct direction for HW endpoint according to description */
+static int cdns3_ep_dir_is_correct(struct usb_endpoint_descriptor *desc,
+				   struct cdns3_endpoint *priv_ep)
+{
+	return (priv_ep->endpoint.caps.dir_in && usb_endpoint_dir_in(desc)) ||
+	       (priv_ep->endpoint.caps.dir_out && usb_endpoint_dir_out(desc));
+}
+
+static struct cdns3_endpoint *cdns3_find_available_ss_ep(struct cdns3_device *priv_dev,
+							 struct usb_endpoint_descriptor *desc)
+{
+	struct usb_ep *ep;
+	struct cdns3_endpoint *priv_ep;
+
+	list_for_each_entry(ep, &priv_dev->gadget.ep_list, ep_list) {
+		unsigned long num;
+		int ret;
+		/* ep name pattern likes epXin or epXout */
+		char c[2] = {ep->name[2], '\0'};
+
+		ret = kstrtoul(c, 10, &num);
+		if (ret)
+			return ERR_PTR(ret);
+
+		priv_ep = ep_to_cdns3_ep(ep);
+		if (cdns3_ep_dir_is_correct(desc, priv_ep)) {
+			if (!(priv_ep->flags & EP_USED)) {
+				priv_ep->num  = num;
+				priv_ep->flags |= EP_USED;
+				return priv_ep;
+			}
+		}
+	}
+	return ERR_PTR(-ENOENT);
+}
+
+static struct usb_ep *cdns3_gadget_match_ep(struct usb_gadget *gadget,
+					    struct usb_endpoint_descriptor *desc,
+					    struct usb_ss_ep_comp_descriptor *comp_desc)
+{
+	struct cdns3_device *priv_dev = gadget_to_cdns3_device(gadget);
+	struct cdns3_endpoint *priv_ep;
+	unsigned long flags;
+
+	priv_ep = cdns3_find_available_ss_ep(priv_dev, desc);
+	if (IS_ERR(priv_ep)) {
+		dev_err(&priv_dev->dev, "no available ep\n");
+		return NULL;
+	}
+
+	dev_dbg(&priv_dev->dev, "match endpoint: %s\n", priv_ep->name);
+
+	spin_lock_irqsave(&priv_dev->lock, flags);
+	priv_ep->endpoint.desc = desc;
+	priv_ep->dir  = usb_endpoint_dir_in(desc) ? USB_DIR_IN : USB_DIR_OUT;
+	priv_ep->type = usb_endpoint_type(desc);
+
+	list_add_tail(&priv_ep->ep_match_pending_list,
+		      &priv_dev->ep_match_list);
+	spin_unlock_irqrestore(&priv_dev->lock, flags);
+	return &priv_ep->endpoint;
+}
+
+/**
+ * cdns3_gadget_get_frame Returns number of actual ITP frame
+ * @gadget: gadget object
+ *
+ * Returns number of actual ITP frame
+ */
+static int cdns3_gadget_get_frame(struct usb_gadget *gadget)
+{
+	struct cdns3_device *priv_dev = gadget_to_cdns3_device(gadget);
+
+	return readl(&priv_dev->regs->usb_iptn);
+}
+
+static int cdns3_gadget_wakeup(struct usb_gadget *gadget)
+{
+	return 0;
+}
+
+static int cdns3_gadget_set_selfpowered(struct usb_gadget *gadget,
+					int is_selfpowered)
+{
+	struct cdns3_device *priv_dev = gadget_to_cdns3_device(gadget);
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv_dev->lock, flags);
+	gadget->is_selfpowered = !!is_selfpowered;
+	spin_unlock_irqrestore(&priv_dev->lock, flags);
+	return 0;
+}
+
+static int cdns3_gadget_pullup(struct usb_gadget *gadget, int is_on)
+{
+	struct cdns3_device *priv_dev = gadget_to_cdns3_device(gadget);
+
+	if (!priv_dev->start_gadget)
+		return 0;
+
+	if (is_on)
+		writel(USB_CONF_DEVEN, &priv_dev->regs->usb_conf);
+	else
+		writel(USB_CONF_DEVDS, &priv_dev->regs->usb_conf);
+
+	return 0;
+}
+
 static void cdns3_gadget_config(struct cdns3_device *priv_dev)
 {
 	struct cdns3_usb_regs __iomem *regs = priv_dev->regs;
@@ -77,6 +229,95 @@ static void cdns3_gadget_config(struct cdns3_device *priv_dev)
 	writel(USB_CONF_DEVEN, &regs->usb_conf);
 }
 
+/**
+ * cdns3_gadget_udc_start Gadget start
+ * @gadget: gadget object
+ * @driver: driver which operates on this gadget
+ *
+ * Returns 0 on success, error code elsewhere
+ */
+static int cdns3_gadget_udc_start(struct usb_gadget *gadget,
+				  struct usb_gadget_driver *driver)
+{
+	struct cdns3_device *priv_dev = gadget_to_cdns3_device(gadget);
+	unsigned long flags;
+
+	if (priv_dev->gadget_driver) {
+		dev_err(&priv_dev->dev, "%s is already bound to %s\n",
+			priv_dev->gadget.name,
+			priv_dev->gadget_driver->driver.name);
+		return -EBUSY;
+	}
+
+	spin_lock_irqsave(&priv_dev->lock, flags);
+	priv_dev->gadget_driver = driver;
+	if (!priv_dev->start_gadget)
+		goto unlock;
+
+	cdns3_gadget_config(priv_dev);
+unlock:
+	spin_unlock_irqrestore(&priv_dev->lock, flags);
+	return 0;
+}
+
+/**
+ * cdns3_gadget_udc_stop Stops gadget
+ * @gadget: gadget object
+ *
+ * Returns 0
+ */
+static int cdns3_gadget_udc_stop(struct usb_gadget *gadget)
+{
+	struct cdns3_device *priv_dev = gadget_to_cdns3_device(gadget);
+	struct cdns3_endpoint *priv_ep, *temp_ep;
+	u32 bEndpointAddress;
+	struct usb_ep *ep;
+	int ret = 0;
+	int i;
+
+	priv_dev->gadget_driver = NULL;
+	list_for_each_entry_safe(priv_ep, temp_ep, &priv_dev->ep_match_list,
+				 ep_match_pending_list) {
+		list_del(&priv_ep->ep_match_pending_list);
+		priv_ep->flags &= ~EP_USED;
+	}
+
+	priv_dev->onchip_mem_allocated_size = 0;
+	priv_dev->out_mem_is_allocated = 0;
+	priv_dev->gadget.speed = USB_SPEED_UNKNOWN;
+
+	for (i = 0; i < priv_dev->ep_nums ; i++)
+		cdns3_free_trb_pool(priv_dev->eps[i]);
+
+	if (!priv_dev->start_gadget)
+		return 0;
+
+	list_for_each_entry(ep, &priv_dev->gadget.ep_list, ep_list) {
+		priv_ep = ep_to_cdns3_ep(ep);
+		bEndpointAddress = priv_ep->num | priv_ep->dir;
+		cdns3_select_ep(priv_dev, bEndpointAddress);
+		writel(EP_CMD_EPRST, &priv_dev->regs->ep_cmd);
+		ret = cdns3_handshake(&priv_dev->regs->ep_cmd,
+				      EP_CMD_EPRST, 0, 100);
+	}
+
+	/* disable interrupt for device */
+	writel(0, &priv_dev->regs->usb_ien);
+	writel(USB_CONF_DEVDS, &priv_dev->regs->usb_conf);
+
+	return ret;
+}
+
+static const struct usb_gadget_ops cdns3_gadget_ops = {
+	.get_frame = cdns3_gadget_get_frame,
+	.wakeup = cdns3_gadget_wakeup,
+	.set_selfpowered = cdns3_gadget_set_selfpowered,
+	.pullup = cdns3_gadget_pullup,
+	.udc_start = cdns3_gadget_udc_start,
+	.udc_stop = cdns3_gadget_udc_stop,
+	.match_ep = cdns3_gadget_match_ep,
+};
+
 /**
  * cdns3_init_ep Initializes software endpoints of gadget
  * @cdns3: extended gadget object
@@ -185,8 +426,7 @@ static int __cdns3_gadget_init(struct cdns3 *cdns)
 	/* fill gadget fields */
 	priv_dev->gadget.max_speed = USB_SPEED_SUPER;
 	priv_dev->gadget.speed = USB_SPEED_UNKNOWN;
-	//TODO: Add implementation of cdns3_gadget_ops
-	//priv_dev->gadget.ops = &cdns3_gadget_ops;
+	priv_dev->gadget.ops = &cdns3_gadget_ops;
 	priv_dev->gadget.name = "usb-ss-gadget";
 	priv_dev->gadget.sg_supported = 1;
 	priv_dev->is_connected = 0;
-- 
2.17.1

