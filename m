Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD871C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33B0820843
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="HsqwMwBi";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="nERIyMpI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33B0820843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbeKDDEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 23:04:40 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:40142 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728862AbeKDDEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 23:04:37 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wA3HmjRQ013628;
        Sat, 3 Nov 2018 10:52:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=5224VinKccHXPflKHxC6/VG48PR5WQpcqxDK65YAa2c=;
 b=HsqwMwBiaH1fUODhOZjxQaaBtK51Chd6Y2xq47ocMvzrs5rE41LFEczMIg40TZJvW1Yl
 87caspAPdmfse17GY4X2HHvGe9zy+6D7iZmj+yq2dtiMKyRzI2fe6649nCOXSmeEPGtG
 lDyyAyFnxbvUOvUnJunVJXqUbzEqWYwsqE5Be3N7qDml94r6DuKv26OB5bmVPj0GSxTE
 fsOjWR8w3rYMb837YzJLTgBOHQ8N20iwXT8hpwVjkZvwCSqHsPAx7Dni3g6akEwqAmpl
 r8dS2xAEimRi/Mw+MJ/q+bQQhjVuPmfw5rMGVSPjHj8GVUjICSYyNKSiyIiVQpk3Y2DO Cg== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp0119.outbound.protection.outlook.com [216.32.181.119])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2nh9ed9dna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 03 Nov 2018 10:52:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5224VinKccHXPflKHxC6/VG48PR5WQpcqxDK65YAa2c=;
 b=nERIyMpII1ZnedFrwL5F1FQd0IdZjjr4Wke2/Jww5cBDjEUIKRQSoYBtt+MlqtixZJu9wHT1a2I4RvnheXvCxI4FP1XOEbCJAlXIcm6UHGBYft4lloyK80P9ieXwKQNOY/wV3Zr6W4iQoDH8L4L311QLBrPOffy0hePvacwgdT8=
Received: from DM5PR07CA0116.namprd07.prod.outlook.com (2603:10b6:4:ae::45) by
 BLUPR0701MB1859.namprd07.prod.outlook.com (2a01:111:e400:5165::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.20; Sat, 3 Nov
 2018 17:52:30 +0000
Received: from CO1NAM05FT018.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::205) by DM5PR07CA0116.outlook.office365.com
 (2603:10b6:4:ae::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1294.26 via Frontend
 Transport; Sat, 3 Nov 2018 17:52:29 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 CO1NAM05FT018.mail.protection.outlook.com (10.152.96.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1318.5 via Frontend Transport; Sat, 3 Nov 2018 17:52:28 +0000
Received: from mailrm1.global.cadence.com (mailrm1.cadence.com [10.209.213.2])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id wA3HqR4E027388
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Sat, 3 Nov 2018 10:52:28 -0700
X-CrossPremisesHeadersFilteredBySendConnector: mailrm1.global.cadence.com
Received: from mailrm1.global.cadence.com (10.209.213.2) by
 mailrm1.global.cadence.com (10.209.213.2) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sat, 3 Nov 2018 13:52:32 -0400
Received: from rmmaillnx1.cadence.com (10.209.208.46) by
 mailrm1.global.cadence.com (10.209.213.2) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Sat, 3 Nov 2018 13:52:32 -0400
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id wA3Hq9xB000566
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Sat, 3 Nov 2018 13:52:26 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sat, 3 Nov 2018 18:52:18 +0100
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Sat, 3 Nov 2018 18:52:18 +0100
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id wA3HqDUx006582;
        Sat, 3 Nov 2018 17:52:13 GMT
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id wA3HqDWb006581;
        Sat, 3 Nov 2018 17:52:13 GMT
From:   Pawel Laszczak <pawell@cadence.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <rogerq@ti.com>,
        <linux-kernel@vger.kernel.org>, <adouglas@cadence.com>,
        <jbergsagel@ti.com>, <peter.chen@nxp.com>, <pjez@cadence.com>,
        <kurahul@cadence.com>, <pawell@cadence.com>
Subject: [RFC PATCH v1 13/14] usb:cdns3: Adds debugging function.
Date:   Sat, 3 Nov 2018 17:51:26 +0000
Message-ID: <1541267487-3664-14-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1541267487-3664-1-git-send-email-pawell@cadence.com>
References: <1541267487-3664-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-OrganizationHeadersPreserved: mailrm1.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39860400002)(136003)(2980300002)(199004)(189003)(36092001)(48376002)(50466002)(217873002)(107886003)(8676002)(246002)(14444005)(6916009)(4720700003)(54906003)(2351001)(105596002)(106466001)(87636003)(4326008)(47776003)(26826003)(478600001)(336012)(86362001)(575784001)(50226002)(2906002)(316002)(11346002)(186003)(446003)(6666004)(26005)(7636002)(8936002)(356004)(426003)(16586007)(2616005)(126002)(476003)(42186006)(486006)(51416003)(36756003)(305945005)(76176011)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0701MB1859;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT018;1:FWIlIMB8ijVOTjn5qVUF+78fmvSisCLPItDsSLKYcLnmBjUt49wUfVbnYyku8kNLCDN53cuHgIpuOmOFQ2L9UOP7kHWn0Ph6bVLDi/6HoZ99xMLT+5Qwz4CJpuPUZ7XP
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce713d37-e4b4-4048-96aa-08d641b51f66
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:BLUPR0701MB1859;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0701MB1859;3:nGz/GzELiwceZp2mJzgNzg0MgtF+UJdKzo34aWnKFP57LE/EdnTDSqTboMIDGmiJkGpMq9/DjQIECi7V+NfqyU68X/ItGUKIIsjFTHD2Ltrbkmvtitpi3fzWjF7L3EfS5TJ0WpAcFjE8PK7aS7zwn+xm6ARTNkwkiQMamb9F8Ol8ZSABLIIOT2Phxmt8cKijaXC8ocMTcRHXHaPo4EIDSubr48VQnqjfNUJ0E/E3mJR3D5voYzh6Po2HIw/a55dQ6YRUflo4+IRaGOA0ratNl0vIekfiFmQj8ifrYgdffVJv9TKFMplavtBanQXwYCKK+5d52Lgth4YwBjDASub6acPtIc/Sp1HvfEQFrdvuOpA=;25:zojqQ+Ue5fJJhxqa+QU4CUlAslmEA47z64DxMhb55S8T/S68xAG/1rUKonuKj9dAQ88P7zUBUm2Dx34FRG9ATloErwxvxaU7Wdg7mGq24JBPhdQtX1dfPEMeUb2Xk50Qe1BXytSnoI/Csqta2ah44eX8KL+OPuQO7RzgHKIVxcIsdR2bU0QMCo8L4g4RqIkZBfsm0Ls4L6RFlNLx5qpMV6wjy973v3wj2NyfF8hKBnrpgFR91JwjiO4+93yrt2tOI+uRkOcVg+q2mFqaj8KV8BFCFndkG6ScVl87yTUEFHG9pCNvRZRwCqAxa4wN+Sno61JbnEe+zuJpusYBEsnbXQ==
X-MS-TrafficTypeDiagnostic: BLUPR0701MB1859:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0701MB1859;31:rca27IabuGaplwobs8yjF5YljBwMxARmFIxF6c3SJUndLBPwY5mcKvR/eUcrIqvoGTJntXk+W0/BEhpRIwx5w32OkNXDBREnUUun6hjVqlkY+ZjoavipY9XqvvZfFA5Hc86yg2elSwzipnE+q6g+6lnv/Unb3wE0BRmQDpAKsyg6JDO/4lvLPkBBcYeTuA9oa2xG/p+9C8C7eExMFGckcXMfDh7S3IHXMR5RJckHNNc=;20:SllTVwbBvQPuWC+1qupNWlprGy0kU3NeHB4+uY3ldEHuW+nXKHVnGZXxTD2kqu+ZReXFRWFyNZy2NDx05hIYCnQk52m/zV8cYktWiytOdS6whqaWUaLTudeEsBrjdYjaQRDxUr/gWdkRnbHFd9xTecmm02up3Q+2jKTdtFuecMT6mbTIb7bBAjyb5wn0HRK2eWlwcRyekhxDJQAXG9JJ0MfwH15OQHHgGKRmHX+7bijxXUmfO98iygb4TOLiijz4Wk2BjTkWTZz+gkrH0DiO34CiswOtSOq+G2RlaKFyJqMSDUtcoB/mi0mqj6XWzIDL82hwf6PiExeyJGp8KM/AoASh7dU93uztuB2Q4YPNh2h6bH1EzKDKI5JVAqUEZYIBPPyBbs06WPIT3VKnj1A4gUvqEdPT5CsSWNK1ByA7MFxY6Pqtu/RKXuM8S7dYzaNwndM8rlpoqjXI5+J/w1tlVslwLIJhpO++GRMflFUJX09pKhelQu2ENfe89lWSOaUR
X-Microsoft-Antispam-PRVS: <BLUPR0701MB18593DA09E17A2F85947FDB7DDC80@BLUPR0701MB1859.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93003095)(3231382)(944501410)(52105095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BLUPR0701MB1859;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0701MB1859;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0701MB1859;4:+69KedOlzzHsbvMh+BT5m+sKfHqs8ipu8m10Nb6ldxhfE3oAdO53P4koOrTFjJcYqK+1tLKVzSk39xuYHZhDryaaqstq55f+h03dnJebqjwG9NBePwhQ4lQ6ZrB5fIazVwCAX/vRR0Zdts1c072q1dR3JB0kIS4d+B8IYnvN0JQ8goQGj5L2p/pw5KXjlO10mbFnsND5VgHO/IEXc3gz+WRyWVBrP+aZxkhxg1WYqrVIOAK34oXiDppkdfNMewGoOOewafVTpzXz4CamBJWLu1s2ilOJphfNFFwTuuqorHIT3lMuGhvQOuUWR0LNDuc0
X-Forefront-PRVS: 08457955C4
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR0701MB1859;23:hwDECL2qD/eF2j2JnWSUb8wKs+DQajSAmCFiYDr?=
 =?us-ascii?Q?zOtKMyGHLEbgmA7DPqdOkbe3aXyb2Wqt/u2OgUwGDFqDgCge2i6TNBN8LXQm?=
 =?us-ascii?Q?nGWewanM7YygAkEJBqOHbH1gsjkNCJBDlkAXaJLFumErp244m5WkI0/+MUpZ?=
 =?us-ascii?Q?Ofu4/JSlJZctwPxkrJOti2xx1aAe/o71WAyZSm4gfmQpUC7TdjaWzNLt/stM?=
 =?us-ascii?Q?lan+AJnyK84cHcAd1mbulXhN/SXuVtHa07teSZb2fCbp+jXXCogdccky75CH?=
 =?us-ascii?Q?3vycOeH227nY2FEWuaSSsvoICWr6i/cXeFD2HcwkOLFbrZHryopAOCDTkATs?=
 =?us-ascii?Q?PL1vN8b/n2/LWcIDdDSyUgHPRcgh5S7KOmklcgr3NUkU8hwwmTccHjt/v4NU?=
 =?us-ascii?Q?3/WzlanJvk99mzW8KyrII0RdTYhkMSjNFPGsEMmEpxPzca6yLxbfSS0dqx9d?=
 =?us-ascii?Q?yCbK+Lg8BCc9EsB6d0/tx6tIZ23ExSUkmDR0Dh73amt8GVnXKODRFxmvwsDp?=
 =?us-ascii?Q?yaqZkNGO6eO2qcdPqoUswprVkB5Ya/7+CcX7uTzpxw4bQRnOM7zL+qVFxLrb?=
 =?us-ascii?Q?22q9BOSLwKNfGOoep7dFbFm4LA8iLVXr+l0CmKEO4mdtcidRMtFiovuNGYBJ?=
 =?us-ascii?Q?MMeUukez5sL0mcbUEpqXgqD2d3n3CEX1LZZL0+NFpksxc0KWMAI+3ahWo4Bb?=
 =?us-ascii?Q?1djd1NTbDm+gQFMdyE+kv/PfBdMHxlgG8fq2eHFaxZUjISCkEElb6vf226SC?=
 =?us-ascii?Q?JZJMSZykWnkBhqJuxSDBU12m9hJ2tljjiP37aYmHekuUQ2AGleyn585Wv0ti?=
 =?us-ascii?Q?0Cok5c8B9zr58XD8e9eZYfbcKb1ixs+IXmftpKzNVrZq7wEFMZp7a+mzyDjm?=
 =?us-ascii?Q?elnvOeSHd+mnrNNAfUzmnBDAG2294EZN/ub9JsAcNgZs9ylBEuvkmWmhQiXw?=
 =?us-ascii?Q?k0tBzXcaetncAVfkQclqi2stE0iI4F1vfMXtCpCX4G8+sf7cbez1u/tl2xtN?=
 =?us-ascii?Q?us1v1L4dM0i7kn9ODU3RTuT067bpVMrQiQ7R03cPlYSqZ4zHjjZZgueOa/OX?=
 =?us-ascii?Q?8HqePl4knZAAEGzKm4muwctkLfBqy8HLWaXY5dhV5RSieJcl2zCrIiwsf4FI?=
 =?us-ascii?Q?81cFsgZwkdzfNln9rLgjF1L+XyNud4kePbDKGHKdSaC6lVdeePd+Xrt2MSQo?=
 =?us-ascii?Q?Ac2ru+yU11X+Lmlw=3D?=
X-Microsoft-Antispam-Message-Info: lV1Dyp1GYSheAsqPTtcS5842M0eIbTO8FdCsclabXvJDNgAIjAvtq2JFdmGm1uRz7EVBx5DJxOlipR8d52dhhstgiuaYvy01ZJqSK1d7nLi9tm3D2vAU3hrb4BNmLvxlVRKuCH0jqu0JFDi21TIROUxoBlatdeJS50uROeS7Vg1T7zlroPliweyzErZwYZXP/4ybGREeexBz+TWrq+t0hhwrRDgZhZCpt32M5NkF3JyWmXz5Axn3PMjOb8uCq1x4GWOOWjEOA6HOFDPFoPUZ4DViW1g4+esDEKvOfCJ/KemShRtdZu78QlDKJ2ZM3nQZS1L3OdH8uoZ7fxQQSPXQW4qcGZ2xPKXgekwEPiHlQ+4=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0701MB1859;6:TixvnY2w0zFcj6JFOWtH8gjXSDSjOGpuSd5N1X+b9xmzwovrkmESrJ2xQB9mNWKkpv7Qry4NtI0uH2FEgaA1Gm/IQnB7GCv3MDW2Hz08uOhQaHF3hIGkml45/AvMorvAoFKsQEIiRHsVHaImuT7R8RAZrMBCoJ5UjvoptgquuFd07rcfFvqYbLeWITN/vb3C5Y9wots2UqIq7+yuVgDm8IvSm9ydmP6x2RN9/+Rg1QeyvPag6D/8fzQnMdaaIggEjVCJdekfpR666o+J8k5d5Zim+XTduaMGw+SqIbTeDKdm/3RBO+PhOQ7nK3Ox6NXeoBSK6SwByAEW3qIhRXpZPK/imiKQRBoqsWB7WCU82y5PX9V7cZ4Lfh3KlMHThyd2dlTSf44O4hrUxwvRAEU/Ve4NOyEN5uAVx+f1Nl7t5zt28E+tACPvGLQrDp+Zr8i02VFXuAITjXzbYOIQSUCUIw==;5:Xp8LQI3J6HksUj41qIISfZG6ebPFpl4itsL8ccJOtenj8YaQZAWuQUY9CWaYwi7kbpmvgS+bypnLj0EQ7osDFeE1488vF5jkNOO1YanExcSiKd0tQ2PCN2rbL/A9f6O6lvz+UhlRwgDylSH731rvwhwsD6x7tIV9GjJLBXiatj8=;7:aLJ32zMFPlZJCwuNKc3MG3GUd1ua/8t7SBRU/QkQvy83BMmgzNod9AiIOGFdrMMsrDCT2t8PbKAvScShjVNSteKnt/Sl4q2D1uRJ6DXothQbew6oIIuS+38BRLYNV/n4UPZO3imZGANioxr1haQ5eQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0701MB1859;20:0OZ3UHlbWWzb+HkS/vYfeTGVYgL9VgQduMxXHs9hfAd0BA7lO72z7gG7lqUHnZvSlgalaljuSBAdP8yZCNzYCSIh6LLk1uBKJelqfJiASSXqK/zEMKZQKYzShYkQ4k7pkkdprAqaepKew1pbEUfQNYxPplDdfdo9kiT3b/qlLqPKfDwGZ38BkuyFIZQT0KIMZ+J2QUAkwJHCq9qZvrGuVsqPyJ0qH/rIQ3cBwPBc7MeU2V/2GD7Ij7NDN7wUbsZI
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2018 17:52:28.9019
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce713d37-e4b4-4048-96aa-08d641b51f66
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0701MB1859
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-03_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=947 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811030169
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch implements some function used for debugging driver.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/Makefile |   2 +-
 drivers/usb/cdns3/debug.c  | 128 +++++++++++++++++++++++++++++++++++++
 drivers/usb/cdns3/ep0.c    |   3 +
 drivers/usb/cdns3/gadget.c |  12 ++++
 drivers/usb/cdns3/gadget.h |  13 +++-
 5 files changed, 156 insertions(+), 2 deletions(-)
 create mode 100644 drivers/usb/cdns3/debug.c

diff --git a/drivers/usb/cdns3/Makefile b/drivers/usb/cdns3/Makefile
index f4cfc978626f..34e60d03c4ec 100644
--- a/drivers/usb/cdns3/Makefile
+++ b/drivers/usb/cdns3/Makefile
@@ -2,6 +2,6 @@ obj-$(CONFIG_USB_CDNS3)			+= cdns3.o
 obj-$(CONFIG_USB_CDNS3_PCI_WRAP)	+= cdns3-pci.o
 
 cdns3-y					:= core.o drd.o
-cdns3-$(CONFIG_USB_CDNS3_GADGET)	+= gadget.o ep0.o
+cdns3-$(CONFIG_USB_CDNS3_GADGET)	+= gadget.o ep0.o debug.o
 cdns3-$(CONFIG_USB_CDNS3_HOST)		+= host.o
 cdns3-pci-y		 		:= cdns3-pci-wrap.o
diff --git a/drivers/usb/cdns3/debug.c b/drivers/usb/cdns3/debug.c
new file mode 100644
index 000000000000..bebf22c4d18e
--- /dev/null
+++ b/drivers/usb/cdns3/debug.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Cadence USBSS DRD Driver.
+ *
+ * Copyright (C) 2018 Cadence.
+ *
+ * Author: Pawel Laszczak <pawell@cadence.com>
+ */
+
+#include "gadget.h"
+
+static inline char *cdns3_decode_ep_irq(u32 ep_sts, const char *ep_name)
+{
+	static char str[256];
+	int ret;
+
+	ret = sprintf(str, "IRQ for %s: %08x ", ep_name, ep_sts);
+
+	if (ep_sts & EP_STS_SETUP)
+		ret += sprintf(str + ret, "SETUP ");
+	if (ep_sts & EP_STS_IOC)
+		ret += sprintf(str + ret, "IOC ");
+	if (ep_sts & EP_STS_ISP)
+		ret += sprintf(str + ret, "ISP ");
+	if (ep_sts & EP_STS_DESCMIS)
+		ret += sprintf(str + ret, "DESCMIS ");
+	if (ep_sts & EP_STS_STREAMR)
+		ret += sprintf(str + ret, "STREAMR ");
+	if (ep_sts & EP_STS_MD_EXIT)
+		ret += sprintf(str + ret, "MD_EXIT ");
+	if (ep_sts & EP_STS_TRBERR)
+		ret += sprintf(str + ret, "TRBERR ");
+	if (ep_sts & EP_STS_NRDY)
+		ret += sprintf(str + ret, "NRDY ");
+	if (ep_sts & EP_STS_PRIME)
+		ret += sprintf(str + ret, "PRIME ");
+	if (ep_sts & EP_STS_SIDERR)
+		ret += sprintf(str + ret, "SIDERRT ");
+	if (ep_sts & EP_STS_OUTSMM)
+		ret += sprintf(str + ret, "OUTSMM ");
+	if (ep_sts & EP_STS_ISOERR)
+		ret += sprintf(str + ret, "ISOERR ");
+	if (ep_sts & EP_STS_IOT)
+		ret += sprintf(str + ret, "IOT ");
+
+	return str;
+}
+
+char *cdns3_decode_epx_irq(struct cdns3_endpoint *priv_ep)
+{
+	struct cdns3_device *priv_dev = priv_ep->cdns3_dev;
+
+	return cdns3_decode_ep_irq(readl(&priv_dev->regs->ep_sts),
+				   priv_ep->name);
+}
+
+char *cdns3_decode_ep0_irq(struct cdns3_device *priv_dev, int dir)
+{
+	if (dir)
+		return cdns3_decode_ep_irq(readl(&priv_dev->regs->ep_sts),
+					   "ep0IN");
+	else
+		return cdns3_decode_ep_irq(readl(&priv_dev->regs->ep_sts),
+					   "ep0OUT");
+}
+
+void cdns3_dbg_setup(struct cdns3_device *priv_dev)
+{
+	struct usb_ctrlrequest *setup = priv_dev->setup;
+
+	dev_dbg(&priv_dev->dev,
+		"SETUP BRT: %02x BR: %02x V: %04x I: %04x L: %04x\n",
+		setup->bRequestType,
+		setup->bRequest,
+		le16_to_cpu(setup->wValue),
+		le16_to_cpu(setup->wIndex),
+		le16_to_cpu(setup->wLength));
+}
+
+/**
+ * Debug a transfer ring.
+ *
+ * Prints out all TRBs in the endpoint ring, even those after the Link TRB.
+ *.
+ */
+void cdns3_dbg_ring(struct cdns3_device *priv_dev,
+		    struct cdns3_endpoint *priv_ep)
+{
+	u64 addr = priv_ep->trb_pool_dma;
+	struct cdns3_trb *trb;
+	int i;
+
+	for (i = 0; i < TRBS_PER_SEGMENT; ++i) {
+		trb = &priv_ep->trb_pool[i];
+		dev_dbg(&priv_dev->dev, "@%016llx %08x %08x %08x\n", addr,
+			le32_to_cpu(trb->buffer),
+			le32_to_cpu(trb->length),
+			le32_to_cpu(trb->control));
+		addr += sizeof(*trb);
+	}
+}
+
+void cdns3_dbg_ring_ptrs(struct cdns3_device *priv_dev,
+			 struct cdns3_endpoint *priv_ep)
+{
+	struct cdns3_trb *trb;
+
+	trb = &priv_ep->trb_pool[priv_ep->dequeue];
+	dev_dbg(&priv_dev->dev,
+		"Ring deq index: %d, trb: %p (virt), 0x%llx (dma)\n",
+		priv_ep->dequeue, trb,
+		cdns3_trb_virt_to_dma(priv_ep, trb));
+
+	trb = &priv_ep->trb_pool[priv_ep->enqueue];
+	dev_dbg(&priv_dev->dev,
+		"Ring enq index: %d, trb: %p (virt), 0x%llx (dma)\n",
+		priv_ep->enqueue, trb,
+		cdns3_trb_virt_to_dma(priv_ep, trb));
+}
+
+void cdns3_dbg_ep_rings(struct cdns3_device *priv_dev,
+			struct cdns3_endpoint *priv_ep)
+{
+	dev_dbg(&priv_dev->dev, "Endpoint ring %s:\n", priv_ep->name);
+
+	cdns3_dbg_ring_ptrs(priv_dev, priv_ep);
+	cdns3_dbg_ring(priv_dev, priv_ep);
+}
diff --git a/drivers/usb/cdns3/ep0.c b/drivers/usb/cdns3/ep0.c
index 555ac7f6842e..46c943a74f77 100644
--- a/drivers/usb/cdns3/ep0.c
+++ b/drivers/usb/cdns3/ep0.c
@@ -604,12 +604,15 @@ void cdns3_check_ep0_interrupt_proceed(struct cdns3_device *priv_dev, int dir)
 	cdns3_select_ep(priv_dev, 0 | (dir ? USB_DIR_IN : USB_DIR_OUT));
 	ep_sts_reg = readl(&regs->ep_sts);
 
+	dev_dbg(&priv_dev->dev, "%s\n", cdns3_decode_ep0_irq(priv_dev, dir));
+
 	__pending_setup_status_handler(priv_dev);
 
 	if ((ep_sts_reg & EP_STS_SETUP) && dir == 0) {
 		struct usb_ctrlrequest *setup = priv_dev->setup;
 
 		writel(EP_STS_SETUP | EP_STS_IOC | EP_STS_ISP, &regs->ep_sts);
+		cdns3_dbg_setup(priv_dev);
 
 		priv_dev->ep0_data_dir = setup->bRequestType & USB_DIR_IN;
 		cdns3_ep0_setup_phase(priv_dev);
diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
index 905cad1a8229..ba4a36ce6e9a 100644
--- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/gadget.c
@@ -124,6 +124,14 @@ void cdns3_select_ep(struct cdns3_device *priv_dev, u32 ep)
 	wmb();
 }
 
+dma_addr_t cdns3_trb_virt_to_dma(struct cdns3_endpoint *priv_ep,
+				 struct cdns3_trb *trb)
+{
+	u32 offset = (char *)trb - (char *)priv_ep->trb_pool;
+
+	return priv_ep->trb_pool_dma + offset;
+}
+
 /**
  * cdns3_allocate_trb_pool - Allocates TRB's pool for selected endpoint
  * @priv_ep:  endpoint object
@@ -428,6 +436,8 @@ int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
 		trb->control |= first_pcs;
 
 	priv_req->on_ring = 1;
+
+	cdns3_dbg_ep_rings(priv_dev, priv_ep);
 arm:
 	/* arm transfer on selected endpoint */
 	cdns3_select_ep(priv_ep->cdns3_dev, address);
@@ -537,6 +547,8 @@ static int cdns3_check_ep_interrupt_proceed(struct cdns3_endpoint *priv_ep)
 	cdns3_select_ep(priv_dev, priv_ep->endpoint.address);
 	ep_sts_reg = readl(&regs->ep_sts);
 
+	dev_dbg(&priv_dev->dev, "%s\n", cdns3_decode_epx_irq(priv_ep));
+
 	if (ep_sts_reg & EP_STS_TRBERR)
 		writel(EP_STS_TRBERR, &regs->ep_sts);
 
diff --git a/drivers/usb/cdns3/gadget.h b/drivers/usb/cdns3/gadget.h
index 3f67ef1e5cda..3b2c01ff655b 100644
--- a/drivers/usb/cdns3/gadget.h
+++ b/drivers/usb/cdns3/gadget.h
@@ -1085,5 +1085,16 @@ struct usb_request *cdns3_gadget_ep_alloc_request(struct usb_ep *ep,
 void cdns3_gadget_ep_free_request(struct usb_ep *ep,
 				  struct usb_request *request);
 int cdns3_gadget_ep_dequeue(struct usb_ep *ep, struct usb_request *request);
-
+dma_addr_t cdns3_trb_virt_to_dma(struct cdns3_endpoint *priv_ep,
+				 struct cdns3_trb *trb);
+
+char *cdns3_decode_epx_irq(struct cdns3_endpoint *priv_ep);
+char *cdns3_decode_ep0_irq(struct cdns3_device *priv_dev, int dir);
+void cdns3_dbg_ring(struct cdns3_device *priv_dev,
+		    struct cdns3_endpoint *priv_ep);
+void cdns3_dbg_ring_ptrs(struct cdns3_device *priv_dev,
+			 struct cdns3_endpoint *priv_ep);
+void cdns3_dbg_ep_rings(struct cdns3_device *priv_dev,
+			struct cdns3_endpoint *priv_ep);
+void cdns3_dbg_setup(struct cdns3_device *priv_dev);
 #endif /* __LINUX_CDNS3_GADGET */
-- 
2.17.1

