Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C95C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C20420833
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="bkwOGU5G";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="cMC7N89Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C20420833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbeKDDFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 23:05:40 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:40022 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727162AbeKDDEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 23:04:30 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wA3HmjRP013628;
        Sat, 3 Nov 2018 10:52:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=mUpQ0B9FJlbYJ/fBq9W0oSTOiSPGJeal6PnLD2hbnGY=;
 b=bkwOGU5GH6MCHJRT82tMNKLW/iclWCIvespdok+vpa4ILnOQvEI4H/cuzrC5f3NPh7Ud
 fAycqAj3FjWAdFQA//rTeKJnLT4u7B468LwmAg5IC8tCdjUs4MxZLf54AGMhjxVISvcM
 pj+/k96PDpSOjo3h/zxQkqDEFtXihSfrnf5wZsXPU4nxMDlUhlOPbQ1VnlfM/CB12coa
 6HGmpCNoZSFyxr6KK5gjJXup2d7l5j2b1zNl4f/JwZcnDktx0T3c8Bz0OsRX+DDaUzyW
 5/jAztK69sDIoECM2NNfDX/yGNeuURMeFBf1tFF747C0+dlssagBP3VwDHZ/TSIuuzk5 WQ== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam03-dm3-obe.outbound.protection.outlook.com (mail-dm3nam03lp0018.outbound.protection.outlook.com [207.46.163.18])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2nh9ed9dmq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sat, 03 Nov 2018 10:52:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUpQ0B9FJlbYJ/fBq9W0oSTOiSPGJeal6PnLD2hbnGY=;
 b=cMC7N89Q+p12QJbIBiaCeIAjLRW7dS1z5u/2afqQKnA+CZatLunmLDiwJ9E1BTlOjBXn8kX3v4gnpY+NWG7vHX6PiBnSwyZcKbfpOXPiP7yoysNwiWwhU3pMQI9OIV/kk4TleyXMjlJz/1PZz/+Celtftuff8Yfvy8FlzSFtNU8=
Received: from DM5PR07CA0035.namprd07.prod.outlook.com (2603:10b6:3:16::21) by
 DM5PR07MB4101.namprd07.prod.outlook.com (2603:10b6:4:b3::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Sat, 3 Nov 2018 17:52:17 +0000
Received: from CO1NAM05FT058.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::205) by DM5PR07CA0035.outlook.office365.com
 (2603:10b6:3:16::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.26 via Frontend
 Transport; Sat, 3 Nov 2018 17:52:17 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 CO1NAM05FT058.mail.protection.outlook.com (10.152.96.176) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.3 via Frontend Transport; Sat, 3 Nov 2018 17:52:17 +0000
Received: from mailrm1.global.cadence.com (mailrm1.cadence.com [10.209.213.2])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id wA3HqFiF009411
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Sat, 3 Nov 2018 10:52:16 -0700
X-CrossPremisesHeadersFilteredBySendConnector: mailrm1.global.cadence.com
Received: from mailrm1.global.cadence.com (10.209.213.2) by
 mailrm1.global.cadence.com (10.209.213.2) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sat, 3 Nov 2018 13:52:19 -0400
Received: from rmmaillnx1.cadence.com (10.209.208.46) by
 mailrm1.global.cadence.com (10.209.213.2) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Sat, 3 Nov 2018 13:52:19 -0400
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id wA3Hq9x0000566
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Sat, 3 Nov 2018 13:52:13 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sat, 3 Nov 2018 18:52:14 +0100
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Sat, 3 Nov 2018 18:52:14 +0100
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id wA3Hq9YA006343;
        Sat, 3 Nov 2018 17:52:09 GMT
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id wA3Hq9vB006340;
        Sat, 3 Nov 2018 17:52:09 GMT
From:   Pawel Laszczak <pawell@cadence.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <rogerq@ti.com>,
        <linux-kernel@vger.kernel.org>, <adouglas@cadence.com>,
        <jbergsagel@ti.com>, <peter.chen@nxp.com>, <pjez@cadence.com>,
        <kurahul@cadence.com>, <pawell@cadence.com>
Subject: [RFC PATCH v1 02/14] usb:cdns3: Device side header file.
Date:   Sat, 3 Nov 2018 17:51:15 +0000
Message-ID: <1541267487-3664-3-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1541267487-3664-1-git-send-email-pawell@cadence.com>
References: <1541267487-3664-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-OrganizationHeadersPreserved: mailrm1.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39860400002)(396003)(2980300002)(189003)(199004)(36092001)(50466002)(48376002)(336012)(53946003)(4744004)(4720700003)(11346002)(107886003)(6916009)(217873002)(26826003)(86362001)(446003)(486006)(478600001)(87636003)(246002)(50226002)(8676002)(8936002)(105596002)(2616005)(2906002)(14444005)(36756003)(356004)(106466001)(6666004)(4326008)(186003)(76176011)(5660300001)(54906003)(51416003)(551934003)(316002)(16586007)(47776003)(476003)(2351001)(42186006)(26005)(7636002)(305945005)(426003)(126002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB4101;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT058;1:pbN8baekKKWSquXNwUHlCFlw5onx/e27Plr4eIjlCr82E1PJ9a9Iw3JAbogWTnTLVpzE8iGDhwodujbGZAIn+kFyxIvagOXMgErc3Kv58OXml1htkxm5vP7Nv8Rs9kJJ
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e086b032-66c6-4f29-8ce0-08d641b51868
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:DM5PR07MB4101;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB4101;3:h9G6DASKPHi2DPYW5prp7a5rBfSjpvEQgnTvaG50ig18mhN7ZU5P8/65/p7+UesOOn4EqH97lCpqpMytbGfvP8tj7A74zBQbO+FWr8EeRkPcTUAREPc8yXoL56rnlCiAuuhyQJ/vLX28RCMzY0ZWMbZPjQUVJ7wWUc7Exu5tHzATO1YtTSW4AdeNAW1i9n1YojNP/L8ZLFTbN0PipEHStsEMvlpvDyfgIeF4bsszqxEJ1a19URBXrBegM7WlRUTnfoLg1fhAEVTn6eZVIRIblEGXk49BjvRgWeaNQt+gXsMABN6t+NXQIOlx675QgzLZ65WRcaw4xcr1izInB1F0bWx/MMX4G/MsGfgU5kYQjr0=;25:+gqu3BQX1q+MEFgdut/RoI7aU4xBMZNt5/TFRSG//OM2RrH6JpoV1lYxEGXfk4XTIEY9b0H0YLnj0NqaJTY6zaw30iLDM6akKP+Nr+ZuPQI8AfRZ9wnSAChwwbz5R6OoJv3cmJjDZN5CbZu8YBLtbTjgkqBSIwEzUnofL6BS37Uzgsdn/HFeLCnd+rnSoQ/WrulolQYPT+ptMkEnicKCj2D7snyjpOlCVnkZAn8FRBFltyN/VeRFJY4VYz+/JukG8vFG6aC/sCj3OWfpfe5NbH4A0CFRBTkrlBS9bFX5kU/WmUHMUsvEN0RJrupGZUtTLHmYxp4rKSHNllRLP65VfQ==
X-MS-TrafficTypeDiagnostic: DM5PR07MB4101:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB4101;31:pXDoqkeWQDzWqaD8xc4m1qfEHGMipva7BwW6JJDgdE8YOrCdICyJG1pYaj5hJdoLf7s18zpN1W/eF4ao1VRmHamGxG+8uiaY/Um+Dljod4xmKt65wJey8OOBAO8pH2ALeKwUPOjMyWnEI1ADsnHT14V3HilZq5Z9P8tEx9fuCwNAqb9iSD4gtdBP57XxHVDZVZY07Qrup+YOM7QKRRVvByFSHd+sXigGHsa2M+VLjYk=;20:yrByNa2xE4kXvY84S2bhZUR7xxRJN33mSPMT1NbEhvyyXy/DdUgdQFN/XMrURrWIC1PFlMy/PI38RV15ao7UWw2L4pPOYxvYv4cS4K3wlSv5wvk2Kbf74+K3k2MtPK+eO7uz9eA4Xyodxmh+rd3Loj1kO4NbPOJudTadu7x2yniG2y+H1jPWsyUCvMuCr8HhBUUxMn44DZeWD60RrolqCuExP+Mh2SshjVg30PPA19lBY0HjyeBSA+xpNXpRIca2S8R7B7+9OfNb302H7E6rvRBhzAzds4GdPJg8kBPFvaophH8JJQ+wqxmcJGX4LsAYbj6mYCvusKizAxug+D+cqerRYiiPh2YwbHM8mZKuMcDReIi/5ht56cawiBmmbPtMHBdch3fAJXEWypB4mv2y7nheY00xXZT0hxY5pJ88pakQY7sZ2f0W9jW7a3EcMyTYSM15/BuwK5GsF51lLQCXWyRpk2OksdrXmCn+aasfDsBUXUN/ULm8omzEBzbvX6yu
X-Microsoft-Antispam-PRVS: <DM5PR07MB41018D55D6E7D884AADAC039DDC80@DM5PR07MB4101.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110)(185117386973197)(60795455431006);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(93006095)(93003095)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DM5PR07MB4101;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB4101;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB4101;4:FxipUNO5RrprZudEl7IZRXKBqAGPBbaeQ5RN3x+QlQ+u33wMDwmnpU0VKEU6Aq+UsHlhkgWsHLjP67PrI5gEO2wSfazcdt0Dif5grZqGYcNWVSGMPIZCuXlJR1FCEldfN7xO7fXifS+bQ6R46UGUthT3krqk2A/qqtFk+btkcmnlZKU0v4FJoUsD7G762D6ujgsr2VQ35qhBZxRZ7oE8LUjRAT2L99wlXKD5Y6DDME1E8DIKyplk33XRMoqjYnCVjO/YxJ1b4zi+oFjWM9O1bOudDB5qCnZaVi2dOYz04n9bDLbwGXCuIi2WTOxqaXSK7Kce0nOszYLKYTVg9IGBliURYXncySt6f4IeF4sHbWBabl69uZH1ZREH1h/6nE8A
X-Forefront-PRVS: 08457955C4
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB4101;23:xB9XUqwa4a45zG9w9ONpXO+44fVbF17e3Ah/arlAj?=
 =?us-ascii?Q?3tHOuadlZw1WieDmRXCIUz44ueRDom4PIx9qiEZFs6p77UvPfKiclyeB5r89?=
 =?us-ascii?Q?Tmi/2+tMTBqP54LDU4E/aHhx0KPFc/9/CvSdwv5zXxaBDgkBQhOare/h3v/j?=
 =?us-ascii?Q?YMDDjEmuWfZltGMZIqxSw8OjsYHicXan4oHRDHK4e7Cb/zZUfpeTgHjyn1vK?=
 =?us-ascii?Q?/2692S2HYhhPH/zT9XWxh/GG1Tm7V+yUszw2miTV86swaKIHi3Rjv38DbQZo?=
 =?us-ascii?Q?dHAP0b7LMNAnPwJFntqH1UbrSUtyFLDmQdZ+Mdtq8JSxsH+vTMd2GFV7dzz3?=
 =?us-ascii?Q?aPyedkkzOjVRpxkqllmyNWDoGPixAtr0uCDAtUvRwEu0LwQSxGef/g1zriVL?=
 =?us-ascii?Q?1V9heYS+RVTDEnq0hsPBONsE731AtbTdhgZ+yF3P6WXZpfI7vdUCBDXvqICK?=
 =?us-ascii?Q?ucXkvb6rOmYm1qXlsV81qD7bQVgixJXp2jOQr0fLatsm063cv7KXKLg6I2Xj?=
 =?us-ascii?Q?ZD+Tl1y+cmf5r86hH4UFzQsW2YtCxN3GZ1gOaX24KBUct5j78m/YzZLaSqBl?=
 =?us-ascii?Q?I++ZsJut+kqu7jhuOW6+YGMChUq2nAkcj9yjFggkFJMsDeG0X2VOkCtiapp8?=
 =?us-ascii?Q?uJdvq+9zideDceHoz45jQcNPcmvUu2mnuGS3eNJgyb6LbVT0RMxDrdIBpfpx?=
 =?us-ascii?Q?ah3zVagxBKavog0JBOTdx+F2X8jWy8uYPfK2eyugaab12UMtL9pYfgd+wBgn?=
 =?us-ascii?Q?b5HmTCIIJcW9Tf26K/WU9VjBwU/Jg3ZlDMX4ogANwMXr2aGYO5gKaC3mIzZp?=
 =?us-ascii?Q?Ftcx00hBBhLqIUwJ9WA/sG+FCcO67It76f1C4IT3KbiAhmKPnA1IE73w84ty?=
 =?us-ascii?Q?1gt6OU5zD9AYYT4dk16ZA0t5uU35iRXSZCM+g3CSYvGetvBah3Ruy2bxEFdi?=
 =?us-ascii?Q?TuJ1YQmMoiyz0nLnUmHyCruaIsDJJN09cygbN8hMX1QgZZWRq5vKKenhnkHl?=
 =?us-ascii?Q?vjQjZayjwdoLC5K0K1AZQghuHW9Tn83zxe/wwbmcw655g+haxMvpzJJs4J6L?=
 =?us-ascii?Q?oAnEFKD6YMkp6DZgS23PSHQtvYOqjwp/mk9PbdrtfnlxkUqjXLlzEN8pZJY2?=
 =?us-ascii?Q?x3qEQ7M+F/+WbqtoXOnppEkjDHqNIHFiO5mlY0qKt442nYKarue/fh8OcWJs?=
 =?us-ascii?Q?4EkioT6barQ8HF0+cDC7ddJDgePMDWQJflG2yiw8FOs6ZSbSKuVMyoTAg=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: nv3/wMiXnM5gJ9vMKH9R2V0GVT0eIylG6tfZu1DDxCwrgUwjo8UUE5AAzmt+dDaSnX7VanUTEt348LYs+94xVLQFXdmPKI1D7wEqKb5xu1ofdPeCVAY7A9y8lDID/s55YZ0iQFQBoxWsLvu51QJcUiqB1Ol8+5ZVk3mOM1IYUDN1EiF7ldgheprBhDxcW3bgSRpNlGAZaj2YcA3OQNyPmnkyC+7VIPBV+1jcOPlWhpmWJ5jbSRy7mhFexug5wcxRlEjYlzKpg83Chb2+Nm2zm27/WHuTMYq8Fa5lGfgfmv1/XJp5oq1ZVWZy6invoy2He+eRfKVqSK6GHRIDmjC6uMQb3xBpexQn7bgv41a0Ang=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB4101;6:Wul1qYt60Ydyd1kkO7omL5RB7lBwvCJo2iPfnDng1hDumWfdLdTeh+Y2mt3B1vpmI4HclPeFSHKZKlYPuSX5YXznSGcfPgWrW8QYw3iL0haHwYEdY5QJmJXXi1g5FE05PNGy4C/O/NmnSALWCbZFj+tJAhSRZ6FAaE5vj0Go8XFDGGLRGO+KcHAMrYaUD8zjNOjoZ6Il8ILwpSPoiQsDMeEYg+oA/RHTSvf4zgJlntYwsxR0uUeq5Y+Zk2YVxQCgFlsmnbifwIpMUyfqUalyRflOAgupN/vS7V44QYa2/OGpuR/7Fk3JzCr2TXV5BiY9lXgTA/uK85AshEnyvRkBYVBql94LKsru3BzO0WeJzES0ktnijNXF7mgQeLEXkH8JowQYHzVp0RkvVTAtoWjVpCkRfS9HXqhAQs5pGR8ruDTbbhL9MB5R3sGEe++811Gewl61eJUxdeiDzZ+psrcCiQ==;5:9MfkvAJkV1I/yBWrHJTyve6s7XwLAOr+B1/2TahGTWK7l/9VRDurdfac3U6yTRzh0GqrCNI21TvYWhlg43pwV3NMT0WvgmkEBFxxrOjXuK1E1PBXOazJCsUhWWUQxFBri+yXNTiLf3aa8OY8h7BzIC6b3fkIKu3rTCP3b3SZ6PE=;7:I8nDMC1Gp7ViRff1xyIT82C0jUKFudfGz6yM+9KxhKJVqWh5hk3Xzl2ddNoNGN++YIZU1zw+emcosa8XsOq4ugnVDH77kSuitGYruzhYNfWWG7CivplgYkbbuwS9K7k9lhWDbdHQtqRfWog6uC7vUA==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB4101;20:ysmhL0EoPUE5WtsyHHd9Pj4iky3q4F1ymmYCsgN0Ef+RsWUsTPIZHmNfxNpIQoaq0Phh4iZvBlmK6iNFYBIDy47VcXceLKmt8BOpwSdWaeBwW1bxqSLNB8fm49heCOn8jtcf6Hfy5WiJnF6WUG3SzaIw51rfriP18q686s/jBzeDrIoPcx7gBh9PLXuE6pco8bidJc469CEoPZDnm07ug33uG++h7jqFfamoH1yImtwbM0sbvzCjwFJgrFixuZ/Y
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2018 17:52:17.1550
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e086b032-66c6-4f29-8ce0-08d641b51868
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB4101
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-03_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811030169
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch defines macros used by device side of controller,
structures holding registers, and some other
object used by device controller.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/gadget.h | 1067 ++++++++++++++++++++++++++++++++++++
 1 file changed, 1067 insertions(+)
 create mode 100644 drivers/usb/cdns3/gadget.h

diff --git a/drivers/usb/cdns3/gadget.h b/drivers/usb/cdns3/gadget.h
new file mode 100644
index 000000000000..c4b07827aae7
--- /dev/null
+++ b/drivers/usb/cdns3/gadget.h
@@ -0,0 +1,1067 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * USBSS device controller driver
+ *
+ * Copyright (C) 2018 Cadence.
+ * Copyright (C) 2018 NXP
+ *
+ * Author: Pawel Laszczak <pawell@cadence.com>
+ *         Pawel Jez <pjez@cadence.com>
+ *         Peter Chen <peter.chen@nxp.com>
+ */
+#ifndef __LINUX_CDNS3_GADGET
+#define __LINUX_CDNS3_GADGET
+#include <linux/usb/gadget.h>
+
+/*
+ * USBSS-DEV register interface.
+ * This corresponds to the USBSS Device Controller Interface
+ */
+
+/**
+ * struct xhci_cap_regs - xHCI Host Controller Capability Registers.
+ * @usb_conf:      Global Configuration Register.
+ * @usb_sts:       Global Status Register.
+ * @usb_cmd:       Global Command Register.
+ * @usb_iptn:      ITP/SOF number Register.
+ * @usb_lpm:       Global Command Register.
+ * @usb_ien:       USB Interrupt Enable Register.
+ * @usb_ists:      USB Interrupt Status Register.
+ * @ep_sel:        Endpoint Select Register.
+ * @ep_traddr:     Endpoint Transfer Ring Address Register.
+ * @ep_cfg:        Endpoint Configuration Register.
+ * @ep_cmd:        Endpoint Command Register.
+ * @ep_sts:        Endpoint Status Register.
+ * @ep_sts_sid:    Endpoint Status Register.
+ * @ep_sts_en:     Endpoint Status Register Enable.
+ * @drbl:          Doorbell Register.
+ * @ep_ien:        EP Interrupt Enable Register.
+ * @ep_ists:       EP Interrupt Status Register.
+ * @usb_pwr:       Global Power Configuration Register.
+ * @usb_conf2:     Global Configuration Register 2.
+ * @usb_cap1:      Capability Register 1.
+ * @usb_cap2:      Capability Register 2.
+ * @usb_cap3:      Capability Register 3.
+ * @usb_cap4:      Capability Register 4.
+ * @usb_cap5:      Capability Register 5.
+ * @usb_cap6:      Capability Register 6.
+ * @usb_cpkt1:     Custom Packet Register 1.
+ * @usb_cpkt2:     Custom Packet Register 2.
+ * @usb_cpkt3:     Custom Packet Register 3.
+ * @reserved1:     Reserved.
+ * @cfg_regs:      Configuration registers.
+ * @reserved2:     Reserved.
+ * @dma_axi_ctrl:  AXI Control register.
+ * @dma_axi_id:    AXI ID register.
+ * @dma_axi_cap:   AXI Capability register.
+ * @dma_axi_ctrl0: AXI Control 0 register.
+ * @dma_axi_ctrl1: AXI Control 1 register.
+ */
+struct cdns3_usb_regs {
+	__le32 usb_conf;
+	__le32 usb_sts;
+	__le32 usb_cmd;
+	__le32 usb_iptn;
+	__le32 usb_lpm;
+	__le32 usb_ien;
+	__le32 usb_ists;
+	__le32 ep_sel;
+	__le32 ep_traddr;
+	__le32 ep_cfg;
+	__le32 ep_cmd;
+	__le32 ep_sts;
+	__le32 ep_sts_sid;
+	__le32 ep_sts_en;
+	__le32 drbl;
+	__le32 ep_ien;
+	__le32 ep_ists;
+	__le32 usb_pwr;
+	__le32 usb_conf2;
+	__le32 usb_cap1;
+	__le32 usb_cap2;
+	__le32 usb_cap3;
+	__le32 usb_cap4;
+	__le32 usb_cap5;
+	__le32 usb_cap6;
+	__le32 usb_cpkt1;
+	__le32 usb_cpkt2;
+	__le32 usb_cpkt3;
+	__le32 reserved1[36];
+	__le32 cfg_reg1;
+	__le32 dbg_link1;
+	__le32 dbg_link2;
+	__le32 cfg_regs[74];
+	__le32 reserved2[34];
+	__le32 dma_axi_ctrl;
+	__le32 dma_axi_id;
+	__le32 dma_axi_cap;
+	__le32 dma_axi_ctrl0;
+	__le32 dma_axi_ctrl1;
+};
+
+/* USB_CONF - bitmasks */
+/* Reset USB device configuration. */
+#define USB_CONF_CFGRST		BIT(0)
+/* Set Configuration. */
+#define USB_CONF_CFGSET		BIT(1)
+/* Disconnect USB device in SuperSpeed. */
+#define USB_CONF_USB3DIS	BIT(3)
+/* Disconnect USB device in HS/FS */
+#define USB_CONF_USB2DIS	BIT(4)
+/* Little Endian access - default */
+#define USB_CONF_LENDIAN	BIT(5)
+/*
+ * Big Endian access. Driver assume that byte order for
+ * SFRs access always is as Little Endian so this bit
+ * is not used.
+ */
+#define USB_CONF_BENDIAN	BIT(6)
+/* Device software reset. */
+#define USB_CONF_SWRST		BIT(7)
+/* Singular DMA transfer mode. */
+#define USB_CONF_DSING		BIT(8)
+/* Multiple DMA transfers mode. */
+#define USB_CONF_DMULT		BIT(9)
+/* DMA clock turn-off enable. */
+#define USB_CONF_DMAOFFEN	BIT(10)
+/* DMA clock turn-off disable. */
+#define USB_CONF_DMAOFFDS	BIT(11)
+/* Clear Force Full Speed. */
+#define USB_CONF_CFORCE_FS	BIT(12)
+/* Set Force Full Speed. */
+#define USB_CONF_SFORCE_FS	BIT(13)
+/* Device enable. */
+#define USB_CONF_DEVEN		BIT(14)
+/* Device disable. */
+#define USB_CONF_DEVDS		BIT(15)
+/* L1 LPM state entry enable (used in HS/FS mode). */
+#define USB_CONF_L1EN		BIT(16)
+/* L1 LPM state entry disable (used in HS/FS mode). */
+#define USB_CONF_L1DS		BIT(17)
+/* USB 2.0 clock gate disable. */
+#define USB_CONF_CLK2OFFEN	BIT(18)
+/* USB 2.0 clock gate enable. */
+#define USB_CONF_CLK2OFFDS	BIT(19)
+/* L0 LPM state entry request (used in HS/FS mode). */
+#define USB_CONF_LGO_L0		BIT(20)
+/* USB 3.0 clock gate disable. */
+#define USB_CONF_CLK3OFFEN	BIT(21)
+/* USB 3.0 clock gate enable. */
+#define USB_CONF_CLK3OFFDS	BIT(22)
+/* Bit 23 is reserved*/
+/* U1 state entry enable (used in SS mode). */
+#define USB_CONF_U1EN		BIT(24)
+/* U1 state entry disable (used in SS mode). */
+#define USB_CONF_U1DS		BIT(25)
+/* U2 state entry enable (used in SS mode). */
+#define USB_CONF_U2EN		BIT(26)
+/* U2 state entry disable (used in SS mode). */
+#define USB_CONF_U2DS		BIT(27)
+/* U0 state entry request (used in SS mode). */
+#define USB_CONF_LGO_U0		BIT(28)
+/* U1 state entry request (used in SS mode). */
+#define USB_CONF_LGO_U1		BIT(29)
+/* U2 state entry request (used in SS mode). */
+#define USB_CONF_LGO_U2		BIT(30)
+/* SS.Inactive state entry request (used in SS mode) */
+#define USB_CONF_LGO_SSINACT	BIT(31)
+
+/* USB_STS - bitmasks */
+/*
+ * Configuration status.
+ * 1 - device is in the configured state.
+ * 0 - device is not configured.
+ */
+#define USB_STS_CFGSTS_MASK	BIT(0)
+#define USB_STS_CFGSTS(p)	((p) & USB_STS_CFGSTS_MASK)
+/*
+ * On-chip memory overflow.
+ * 0 - On-chip memory status OK.
+ * 1 - On-chip memory overflow.
+ */
+#define USB_STS_OV_MASK		BIT(1)
+#define USB_STS_OV(p)		((p) & USB_STS_OV_MASK)
+/*
+ * SuperSpeed connection status.
+ * 0 - USB in SuperSpeed mode disconnected.
+ * 1 - USB in SuperSpeed mode connected.
+ */
+#define USB_STS_USB3CONS_MASK	BIT(2)
+#define USB_STS_USB3CONS(p)	((p) & USB_STS_USB3CONS_MASK)
+/*
+ * DMA transfer configuration status.
+ * 0 - single request.
+ * 1 - multiple TRB chain
+ */
+#define USB_STS_DTRANS_MASK	BIT(3)
+#define USB_STS_DTRANS(p)	((p) & USB_STS_DTRANS_MASK)
+/*
+ * Device speed.
+ * 0 - Undefined (value after reset).
+ * 1 - Low speed
+ * 2 - Full speed
+ * 3 - High speed
+ * 4 - Super speed
+ */
+#define USB_STS_USBSPEED_MASK	GENMASK(6, 4)
+#define USB_STS_USBSPEED(p)	(((p) & USB_STS_USBSPEED_MASK) >> 4)
+#define USB_STS_LS		(0x1 << 4)
+#define USB_STS_FS		(0x2 << 4)
+#define USB_STS_HS		(0x3 << 4)
+#define USB_STS_SS		(0x4 << 4)
+#define DEV_UNDEFSPEED(p)	(((p) & USB_STS_USBSPEED_MASK) == (0x0 << 4))
+#define DEV_LOWSPEED(p)		(((p) & USB_STS_USBSPEED_MASK) == USB_STS_LS)
+#define DEV_FULLSPEED(p)	(((p) & USB_STS_USBSPEED_MASK) == USB_STS_FS)
+#define DEV_HIGHSPEED(p)	(((p) & USB_STS_USBSPEED_MASK) == USB_STS_HS)
+#define DEV_SUPERSPEED(p)	(((p) & USB_STS_USBSPEED_MASK) == USB_STS_SS)
+/*
+ * Endianness for SFR access.
+ * 0 - Little Endian order (default after hardware reset).
+ * 1 - Big Endian order
+ */
+#define USB_STS_ENDIAN_MASK	BIT(7)
+#define USB_STS_ENDIAN(p)	((p) & USB_STS_ENDIAN_MASK)
+/*
+ * HS/FS clock turn-off status.
+ * 0 - hsfs clock is always on.
+ * 1 - hsfs clock turn-off in L2 (HS/FS mode) is enabled
+ *          (default after hardware reset).
+ */
+#define USB_STS_CLK2OFF_MASK	BIT(8)
+#define USB_STS_CLK2OFF(p)	((p) & USB_STS_CLK2OFF_MASK)
+/*
+ * PCLK clock turn-off status.
+ * 0 - pclk clock is always on.
+ * 1 - pclk clock turn-off in U3 (SS mode) is enabled
+ *          (default after hardware reset).
+ */
+#define USB_STS_CLK3OFF_MASK	BIT(9)
+#define USB_STS_CLK3OFF(p)	((p) & USB_STS_CLK3OFF_MASK)
+/*
+ * Controller in reset state.
+ * 0 - Internal reset is active.
+ * 1 - Internal reset is not active and controller is fully operational.
+ */
+#define USB_STS_IN_RST_MASK	BIT(10)
+#define USB_STS_IN_RST(p)	((p) & USB_STS_IN_RST_MASK)
+/*
+ * Device enable Status.
+ * 0 - USB device is disabled (VBUS input is disconnected from internal logic).
+ * 1 - USB device is enabled (VBUS input is connected to the internal logic).
+ */
+#define USB_STS_DEVS_MASK	BIT(14)
+#define USB_STS_DEVS(p)		((p) & USB_STS_DEVS_MASK)
+/*
+ * DAddress statuss.
+ * 0 - USB device is default state.
+ * 1 - USB device is at least in address state.
+ */
+#define USB_STS_ADDRESSED_MASK	BIT(15)
+#define USB_STS_ADDRESSED(p)	((p) & USB_STS_ADDRESSED_MASK)
+/*
+ * L1 LPM state enable status (used in HS/FS mode).
+ * 0 - Entering to L1 LPM state disabled.
+ * 1 - Entering to L1 LPM state enabled.
+ */
+#define USB_STS_L1ENS_MASK	BIT(16)
+#define USB_STS_L1ENS(p)	((p) & USB_STS_L1ENS_MASK)
+/*
+ * Internal VBUS connection status (used both in HS/FS  and SS mode).
+ * 0 - internal VBUS is not detected.
+ * 1 - internal VBUS is detected.
+ */
+#define USB_STS_VBUSS_MASK	BIT(17)
+#define USB_STS_VBUSS(p)	((p) & USB_STS_VBUSS_MASK)
+/*
+ * HS/FS LPM  state (used in FS/HS mode).
+ * 0 - L0 State
+ * 1 - L1 State
+ * 2 - L2 State
+ * 3 - L3 State
+ */
+#define USB_STS_LPMST_MASK	GENMASK(19, 18)
+#define DEV_L0_STATE(p)		(((p) & USB_STS_LPMST_MASK) == (0x0 << 18))
+#define DEV_L1_STATE(p)		(((p) & USB_STS_LPMST_MASK) == (0x1 << 18))
+#define DEV_L2_STATE(p)		(((p) & USB_STS_LPMST_MASK) == (0x2 << 18))
+#define DEV_L3_STATE(p)		(((p) & USB_STS_LPMST_MASK) == (0x3 << 18))
+/*
+ * Disable HS status (used in FS/HS mode).
+ * 0 - the disconnect bit for HS/FS mode is set .
+ * 1 - the disconnect bit for HS/FS mode is not set.
+ */
+#define USB_STS_USB2CONS_MASK	BIT(20)
+#define USB_STS_USB2CONS(p)	((p) & USB_STS_USB2CONS_MASK)
+/*
+ * HS/FS mode connection status (used in FS/HS mode).
+ * 0 - High Speed operations in USB2.0 (FS/HS) mode not disabled.
+ * 1 - High Speed operations in USB2.0 (FS/HS).
+ */
+#define USB_STS_DISABLE_HS_MASK	BIT(21)
+#define USB_STS_DISABLE_HS(p)	((p) & USB_STS_DISABLE_HS_MASK)
+/*
+ * U1 state enable status (used in SS mode).
+ * 0 - Entering to  U1 state disabled.
+ * 1 - Entering to  U1 state enabled.
+ */
+#define USB_STS_U1ENS_MASK	BIT(24)
+#define USB_STS_U1ENS(p)	((p) & USB_STS_U1ENS_MASK)
+/*
+ * U2 state enable status (used in SS mode).
+ * 0 - Entering to  U2 state disabled.
+ * 1 - Entering to  U2 state enabled.
+ */
+#define USB_STS_U2ENS_MASK	BIT(25)
+#define USB_STS_U2ENS(p)	((p) & USB_STS_U2ENS_MASK)
+/*
+ * SuperSpeed Link LTSSM state. This field reflects USBSS-DEV current
+ * SuperSpeed link state
+ */
+#define USB_STS_LST_MASK	GENMASK(29, 26)
+#define DEV_LST_U0		(((p) & USB_STS_LST_MASK) == (0x0 << 26))
+#define DEV_LST_U1		(((p) & USB_STS_LST_MASK) == (0x1 << 26))
+#define DEV_LST_U2		(((p) & USB_STS_LST_MASK) == (0x2 << 26))
+#define DEV_LST_U3		(((p) & USB_STS_LST_MASK) == (0x3 << 26))
+#define DEV_LST_DISABLED	(((p) & USB_STS_LST_MASK) == (0x4 << 26))
+#define DEV_LST_RXDETECT	(((p) & USB_STS_LST_MASK) == (0x5 << 26))
+#define DEV_LST_INACTIVE	(((p) & USB_STS_LST_MASK) == (0x6 << 26))
+#define DEV_LST_POLLING		(((p) & USB_STS_LST_MASK) == (0x7 << 26))
+#define DEV_LST_RECOVERY	(((p) & USB_STS_LST_MASK) == (0x8 << 26))
+#define DEV_LST_HOT_RESET	(((p) & USB_STS_LST_MASK) == (0x9 << 26))
+#define DEV_LST_COMP_MODE	(((p) & USB_STS_LST_MASK) == (0xa << 26))
+#define DEV_LST_LB_STATE	(((p) & USB_STS_LST_MASK) == (0xb << 26))
+/*
+ * DMA clock turn-off status.
+ * 0 - DMA clock is always on (default after hardware reset).
+ * 1 - DMA clock turn-off in U1, U2 and U3 (SS mode) is enabled.
+ */
+#define USB_STS_DMAOFF_MASK	BIT(30)
+#define USB_STS_DMAOFF(p)	((p) & USB_STS_DMAOFF_MASK)
+/*
+ * SFR Endian statuss.
+ * 0 - Little Endian order (default after hardware reset).
+ * 1 - Big Endian order.
+ */
+#define USB_STS_ENDIAN2_MASK	BIT(31)
+#define USB_STS_ENDIAN2(p)	((p) & USB_STS_ENDIAN2_MASK)
+
+/* USB_CMD -  bitmasks */
+/* Set Function Address */
+#define USB_CMD_SET_ADDR	BIT(0)
+/*
+ * Function Address This field is saved to the device only when the field
+ * SET_ADDR is set '1 ' during write to USB_CMD register.
+ * Software is responsible for entering the address of the device during
+ * SET_ADDRESS request service. This field should be set immediately after
+ * the SETUP packet is decoded, and prior to confirmation of the status phase
+ */
+#define USB_CMD_FADDR_MASK	GENMASK(7, 1)
+#define USB_CMD_FADDR(p)	(((p) << 1) & USB_CMD_FADDR_MASK)
+/* Send Function Wake Device Notification TP (used only in SS mode). */
+#define USB_CMD_SDNFW		BIT(8)
+/* Set Test Mode (used only in HS/FS mode). */
+#define USB_CMD_STMODE		BIT(9)
+/* Test mode selector (used only in HS/FS mode) */
+#define USB_STS_TMODE_SEL_MASK	GENMASK(11, 10)
+#define USB_STS_TMODE_SEL(p)	(((p) << 10) & USB_STS_TMODE_SEL_MASK)
+/*
+ *  Send Latency Tolerance Message Device Notification TP (used only
+ *  in SS mode).
+ */
+#define USB_CMD_SDNLTM		BIT(12)
+/* Send Custom Transaction Packet (used only in SS mode) */
+#define USB_CMD_SPKT		BIT(13)
+/*Device Notification 'Function Wake' - Interface value (only in SS mode. */
+#define USB_CMD_DNFW_INT_MASK	GENMASK(23, 16)
+#define USB_STS_DNFW_INT(p)	(((p) << 16) & USB_CMD_DNFW_INT_MASK)
+/*
+ * Device Notification 'Latency Tolerance Message' -373 BELT value [7:0]
+ * (used only in SS mode).
+ */
+#define USB_CMD_DNLTM_BELT_MASK	GENMASK(27, 16)
+#define USB_STS_DNLTM_BELT(p)	(((p) << 16) & USB_CMD_DNLTM_BELT_MASK)
+
+/* USB_ITPN - bitmasks */
+/*
+ * ITP(SS) / SOF (HS/FS) number
+ * In SS mode this field represent number of last ITP received from host.
+ * In HS/FS mode this field represent number of last SOF received from host.
+ */
+#define USB_ITPN_MASK		GENMASK(13, 0)
+#define USB_ITPN(p)		((p) & USB_ITPN_MASK)
+
+/* USB_LPM - bitmasks */
+/* Host Initiated Resume Duration. */
+#define USB_LPM_HIRD_MASK	GENMASK(3, 0)
+#define USB_LPM_HIRD(p)		((p) & USB_LPM_HIRD_MASK)
+/* Remote Wakeup Enable (bRemoteWake). */
+#define USB_LPM_BRW		BIT(4)
+
+/* USB_IEN - bitmasks */
+/* SS connection interrupt enable */
+#define USB_IEN_CONIEN		BIT(0)
+/* SS disconnection interrupt enable. */
+#define USB_IEN_DISIEN		BIT(1)
+/* USB SS warm reset interrupt enable. */
+#define USB_IEN_UWRESIEN	BIT(2)
+/* USB SS hot reset interrupt enable */
+#define USB_IEN_UHRESIEN	BIT(3)
+/* SS link U3 state enter interrupt enable (suspend).*/
+#define USB_IEN_U3ENTIEN	BIT(4)
+/* SS link U3 state exit interrupt enable (wakeup). */
+#define USB_IEN_U3EXTIEN	BIT(5)
+/* SS link U2 state enter interrupt enable.*/
+#define USB_IEN_U2ENTIEN	BIT(6)
+/* SS link U2 state exit interrupt enable.*/
+#define USB_IEN_U2EXTIEN	BIT(7)
+/* SS link U1 state enter interrupt enable.*/
+#define USB_IEN_U1ENTIEN	BIT(8)
+/* SS link U1 state exit interrupt enable.*/
+#define USB_IEN_U1EXTIEN	BIT(9)
+/* ITP/SOF packet detected interrupt enable.*/
+#define USB_IEN_ITPIEN		BIT(10)
+/* Wakeup interrupt enable.*/
+#define USB_IEN_WAKEIEN		BIT(11)
+/* Send Custom Packet interrupt enable.*/
+#define USB_IEN_SPKTIEN		BIT(12)
+/* HS/FS mode connection interrupt enable.*/
+#define USB_IEN_CON2IEN		BIT(16)
+/* HS/FS mode disconnection interrupt enable.*/
+#define USB_IEN_DIS2IEN		BIT(17)
+/* USB reset (HS/FS mode) interrupt enable.*/
+#define USB_IEN_U2RESIEN	BIT(18)
+/* LPM L2 state enter interrupt enable.*/
+#define USB_IEN_L2ENTIEN	BIT(20)
+/* LPM  L2 state exit interrupt enable.*/
+#define USB_IEN_L2EXTIEN	BIT(21)
+/* LPM L1 state enter interrupt enable.*/
+#define USB_IEN_L1ENTIEN	BIT(24)
+/* LPM  L1 state exit interrupt enable.*/
+#define USB_IEN_L1EXTIEN	BIT(25)
+/* Configuration reset interrupt enable.*/
+#define USB_IEN_CFGRESIEN	BIT(26)
+/* Start of the USB SS warm reset interrupt enable.*/
+#define USB_IEN_UWRESSIEN	BIT(28)
+/* End of the USB SS warm reset interrupt enable.*/
+#define USB_IEN_UWRESEIEN	BIT(29)
+
+#define USB_IEN_INIT  (USB_IEN_U2RESIEN | USB_ISTS_DIS2I | USB_IEN_CON2IEN \
+		       | USB_IEN_UHRESIEN | USB_IEN_UWRESIEN | USB_IEN_DISIEN \
+		       | USB_IEN_CONIEN | USB_IEN_U3EXTIEN | USB_IEN_L2ENTIEN \
+		       | USB_IEN_L2EXTIEN)
+
+/* USB_ISTS - bitmasks */
+/* SS Connection detected. */
+#define USB_ISTS_CONI		BIT(0)
+/* SS Disconnection detected. */
+#define USB_ISTS_DISI		BIT(1)
+/* UUSB warm reset detectede. */
+#define USB_ISTS_UWRESI		BIT(2)
+/* USB hot reset detected. */
+#define USB_ISTS_UHRESI		BIT(3)
+/* U3 link state enter detected (suspend).*/
+#define USB_ISTS_U3ENTI		BIT(4)
+/* U3 link state exit detected (wakeup). */
+#define USB_ISTS_U3EXTI		BIT(5)
+/* U2 link state enter detected.*/
+#define USB_ISTS_U2ENTI		BIT(6)
+/* U2 link state exit detected.*/
+#define USB_ISTS_U2EXTI		BIT(7)
+/* U1 link state enter detected.*/
+#define USB_ISTS_U1ENTI		BIT(8)
+/* U1 link state exit detected.*/
+#define USB_ISTS_U1EXTI		BIT(9)
+/* ITP/SOF packet detected.*/
+#define USB_ISTS_ITPI		BIT(10)
+/* Wakeup detected.*/
+#define USB_ISTS_WAKEI		BIT(11)
+/* Send Custom Packet detected.*/
+#define USB_ISTS_SPKTI		BIT(12)
+/* HS/FS mode connection detected.*/
+#define USB_ISTS_CON2I		BIT(16)
+/* HS/FS mode disconnection detected.*/
+#define USB_ISTS_DIS2I		BIT(17)
+/* USB reset (HS/FS mode) detected.*/
+#define USB_ISTS_U2RESI		BIT(18)
+/* LPM L2 state enter detected.*/
+#define USB_ISTS_L2ENTI		BIT(20)
+/* LPM  L2 state exit detected.*/
+#define USB_ISTS_L2EXTI		BIT(21)
+/* LPM L1 state enter detected.*/
+#define USB_ISTS_L1ENTI		BIT(24)
+/* LPM L1 state exit detected.*/
+#define USB_ISTS_L1EXTI		BIT(25)
+/* USB configuration reset detected.*/
+#define USB_ISTS_CFGRESI	BIT(26)
+/* Start of the USB warm reset detected.*/
+#define USB_ISTS_UWRESSI	BIT(28)
+/* End of the USB warm reset detected.*/
+#define USB_ISTS_UWRESEI	BIT(29)
+
+/* USB_SEL - bitmasks */
+#define EP_SEL_EPNO_MASK	GENMASK(3, 0)
+/* Endpoint number. */
+#define EP_SEL_EPNO(p)		((p) & EP_SEL_EPNO_MASK)
+/* Endpoint direction bit - 0 - OUT, 1 - IN. */
+#define EP_SEL_DIR		BIT(7)
+
+#define select_ep_in(nr)	(EP_SEL_EPNO(p) | EP_SEL_DIR)
+#define select_ep_out		(EP_SEL_EPNO(p))
+
+/* EP_TRADDR - bitmasks */
+/* Transfer Ring address. */
+#define EP_TRADDR_TRADDR(p)	((p))
+
+/* EP_CFG - bitmasks */
+/* Endpoint enable */
+#define EP_CFG_ENABLE		BIT(0)
+/*
+ *  Endpoint type.
+ * 1 - isochronous
+ * 2 - bulk
+ * 3 - interrupt
+ */
+#define EP_CFG_EPTYPE_MASK	GENMASK(2, 1)
+#define EP_CFG_EPTYPE(p)	(((p) << 1)  & EP_CFG_EPTYPE_MASK)
+/* Stream support enable (only in SS mode). */
+#define EP_CFG_STREAM_EN	BIT(3)
+/* TDL check (only in SS mode for BULK EP). */
+#define EP_CFG_TDL_CHK		BIT(4)
+/* SID check (only in SS mode for BULK OUT EP). */
+#define EP_CFG_SID_CHK		BIT(5)
+/* DMA transfer endianness. */
+#define EP_CFG_EPENDIAN		BIT(7)
+/* Max burst size (used only in SS mode). */
+#define EP_CFG_MAXBURST_MASK	GENMASK(11, 8)
+#define EP_CFG_MAXBURST(p)	(((p) << 8) & EP_CFG_MAXBURST_MASK)
+/* ISO max burst. */
+#define EP_CFG_MULT_MASK	GENMASK(15, 14)
+#define EP_CFG_MULT(p)		(((p) << 14) & EP_CFG_MULT)
+/* ISO max burst. */
+#define EP_CFG_MAXPKTSIZE_MASK	GENMASK(26, 16)
+#define EP_CFG_MAXPKTSIZE(p)	(((p) << 16) & EP_CFG_MAXPKTSIZE_MASK)
+/* Max number of buffered packets. */
+#define EP_CFG_BUFFERING_MASK	GENMASK(31, 27)
+#define EP_CFG_BUFFERING(p)	(((p) << 27) & EP_CFG_BUFFERING_MASK)
+
+/* EP_CMD - bitmasks */
+/* Endpoint reset. */
+#define EP_CMD_EPRST		BIT(0)
+/* Endpoint STALL set. */
+#define EP_CMD_SSTALL		BIT(1)
+/* Endpoint STALL clear. */
+#define EP_CMD_CSTALL		BIT(2)
+/* Send ERDY TP. */
+#define EP_CMD_ERDY		BIT(3)
+/* Request complete. */
+#define EP_CMD_REQ_CMPL		BIT(5)
+/* Transfer descriptor ready. */
+#define EP_CMD_DRDY		BIT(6)
+/* Data flush. */
+#define EP_CMD_DFLUSH		BIT(7)
+/*
+ * Transfer Descriptor Length write  (used only for Bulk Stream capable
+ * endpoints in SS mode).
+ */
+#define EP_CMD_STDL		BIT(8)
+/* Transfer Descriptor Length (used only in SS mode for bulk endpoints). */
+#define EP_CMD_TDL_MASK		GENMASK(15, 9)
+#define EP_CMD_TDL(p)		(((p) << 9) & EP_CMD_TDL_MASK)
+/* ERDY Stream ID value (used in SS mode). */
+#define EP_CMD_ERDY_SID_MASK	GENMASK(31, 16)
+#define EP_CMD_ERDY_SID(p)	(((p) << 16) & EP_CMD_SID_MASK)
+
+/* EP_STS - bitmasks */
+/* Setup transfer complete. */
+#define EP_STS_SETUP		BIT(0)
+/* Endpoint STALL status. */
+#define EP_STS_STALL(p)		((p) & BIT(1))
+/* Interrupt On Complete. */
+#define EP_STS_IOC		BIT(2)
+/* Interrupt on Short Packet. */
+#define EP_STS_ISP		BIT(3)
+/* Transfer descriptor missing. */
+#define EP_STS_DESCMIS		BIT(4)
+/* Stream Rejected (used only in SS mode) */
+#define EP_STS_STREAMR		BIT(5)
+/* EXIT from MOVE DATA State (used only for stream transfers in SS mode). */
+#define EP_STS_MD_EXIT		BIT(6)
+/* TRB error. */
+#define EP_STS_TRBERR		BIT(7)
+/* Not ready (used only in SS mode). */
+#define EP_STS_NRDY		BIT(8)
+/* DMA busy. */
+#define EP_STS_DBUSY(p)		((p) & BIT(9))
+/* Endpoint Buffer Empty */
+#define EP_STS_BUFFEMPTY(p)	((p) & BIT(10))
+/* Current Cycle Status */
+#define EP_STS_CCS(p)		((p) & BIT(11))
+/* Prime (used only in SS mode. */
+#define EP_STS_PRIME		BIT(12)
+/* Stream error (used only in SS mode). */
+#define EP_STS_SIDERR		BIT(13)
+/* OUT size mismatch. */
+#define EP_STS_OUTSMM		BIT(14)
+/* ISO transmission error. */
+#define EP_STS_ISOERR		BIT(15)
+/* Host Packet Pending (only for SS mode). */
+#define EP_STS_HOSTPP(p)	((p) & BIT(16))
+/* Stream Protocol State Machine State (only for Bulk stream endpoints). */
+#define EP_STS_SPSMST_MASK		GENMASK(18, 17)
+#define EP_STS_SPSMST_DISABLED(p)	(((p) & EP_STS_SPSMST_MASK) >> 17)
+#define EP_STS_SPSMST_IDLE(p)		(((p) & EP_STS_SPSMST_MASK) >> 17)
+#define EP_STS_SPSMST_START_STREAM(p)	(((p) & EP_STS_SPSMST_MASK) >> 17)
+#define EP_STS_SPSMST_MOVE_DATA(p)	(((p) & EP_STS_SPSMST_MASK) >> 17)
+/* Interrupt On Transfer complete. */
+#define EP_STS_IOT		BIT(19)
+/* OUT queue endpoint number. */
+#define EP_STS_OUTQ_NO_MASK	GENMASK(27, 24)
+#define EP_STS_OUTQ_NO(p)	(((p) & EP_STS_OUTQ_NO_MASK) >> 24)
+/* OUT queue valid flag. */
+#define EP_STS_OUTQ_VAL_MASK	BIT(28)
+#define EP_STS_OUTQ_VAL(p)	((p) & EP_STS_OUTQ_VAL_MASK)
+/* SETUP WAIT. */
+#define EP_STS_STPWAIT		BIT(31)
+
+/* EP_STS_SID - bitmasks */
+/* Stream ID (used only in SS mode). */
+#define EP_STS_SID_MASK		GENMASK(15, 0)
+#define EP_STS_SID(p)		((p) & EP_STS_SID_MASK)
+
+/* EP_STS_EN - bitmasks */
+/* SETUP interrupt enable. */
+#define EP_STS_EN_SETUPEN	BIT(0)
+/* OUT transfer missing descriptor enable. */
+#define EP_STS_EN_DESCMISEN	BIT(4)
+/* Stream Rejected enable. */
+#define EP_STS_EN_STREAMREN	BIT(5)
+/* Move Data Exit enable.*/
+#define EP_STS_EN_MD_EXITEN	BIT(6)
+/* TRB enable. */
+#define EP_STS_EN_TRBERREN	BIT(7)
+/* NRDY enable. */
+#define EP_STS_EN_NRDYEN	BIT(8)
+/* Prime enable. */
+#define EP_STS_EN_PRIMEEEN	BIT(12)
+/* Stream error enable. */
+#define EP_STS_EN_SIDERREN	BIT(13)
+/* OUT size mismatch enable. */
+#define EP_STS_EN_OUTSMMEN	BIT(14)
+/* ISO transmission error enable. */
+#define EP_STS_EN_ISOERREN	BIT(15)
+/* Interrupt on Transmission complete enable. */
+#define EP_STS_EN_IOTEN		BIT(19)
+/* Setup Wait interrupt enable. */
+#define EP_STS_EN_STPWAITEN	BIT(31)
+
+/* DRBL- bitmasks */
+#define DB_VALUE_BY_INDEX(index) (1 << (index))
+#define DB_VALUE_EP0_OUT	BIT(0)
+#define DB_VALUE_EP0_IN		BIT(16)
+
+/* EP_IEN - bitmasks */
+#define EP_IEN(index)		(1 << (index))
+#define EP_IEN_EP_OUT0		BIT(0)
+#define EP_IEN_EP_IN0		BIT(16)
+
+/* EP_ISTS - bitmasks */
+#define EP_ISTS(index)		(1 << (index))
+#define EP_ISTS_EP_OUT0		BIT(0)
+#define EP_ISTS_EP_IN0		BIT(16)
+
+/* EP_PWR- bitmasks */
+/*Power Shut Off capability enable*/
+#define PUSB_PWR_PSO_EN		BIT(0)
+/*Power Shut Off capability disable*/
+#define PUSB_PWR_PSO_DS		BIT(1)
+/*
+ * Enables turning-off Reference Clock.
+ * This bit is optional and implemented only when support for OTG is
+ * implemented (indicated by OTG_READY bit set to '1').
+ */
+#define PUSB_PWR_STB_CLK_SWITCH_EN	BIT(8)
+/*
+ * Status bit indicating that operation required by STB_CLK_SWITCH_EN write
+ * is completed
+ */
+#define PUSB_PWR_STB_CLK_SWITCH_DONE	BIT(9)
+/* This bit informs if Fast Registers Access is enabled. */
+#define PUSB_PWR_FST_REG_ACCESS_STAT	BIT(30)
+/* Fast Registers Access Enable. */
+#define PUSB_PWR_FST_REG_ACCESS	BIT(31)
+
+/* USB_CAP1- bitmasks */
+/*
+ * SFR Interface type
+ * These field reflects type of SFR interface implemented:
+ * 0x0 - OCP
+ * 0x1 - AHB,
+ * 0x2 - PLB
+ * 0x3 - AXI
+ * 0x4-0xF - reserved
+ */
+#define USB_CAP1_SFR_TYPE_MASK	GENMASK(3, 0)
+#define DEV_SFR_TYPE_OCP(p)	(((p) & USB_CAP1_SFR_TYPE_MASK) == 0x0)
+#define DEV_SFR_TYPE_AHB(p)	(((p) & USB_CAP1_SFR_TYPE_MASK) == 0x1)
+#define DEV_SFR_TYPE_PLB(p)	(((p) & USB_CAP1_SFR_TYPE_MASK) == 0x2)
+#define DEV_SFR_TYPE_AXI(p)	(((p) & USB_CAP1_SFR_TYPE_MASK) == 0x3)
+/*
+ * SFR Interface width
+ * These field reflects width of SFR interface implemented:
+ * 0x0 - 8 bit interface,
+ * 0x1 - 16 bit interface,
+ * 0x2 - 32 bit interface
+ * 0x3 - 64 bit interface
+ * 0x4-0xF - reserved
+ */
+#define USB_CAP1_SFR_WIDTH_MASK	GENMASK(7, 4)
+#define DEV_SFR_WIDTH_8(p)	(((p) & USB_CAP1_SFR_WIDTH_MASK) == (0x0 << 4))
+#define DEV_SFR_WIDTH_16(p)	(((p) & USB_CAP1_SFR_WIDTH_MASK) == (0x1 << 4))
+#define DEV_SFR_WIDTH_32(p)	(((p) & USB_CAP1_SFR_WIDTH_MASK) == (0x2 << 4))
+#define DEV_SFR_WIDTH_64(p)	(((p) & USB_CAP1_SFR_WIDTH_MASK) == (0x3 << 4))
+/*
+ * DMA Interface type
+ * These field reflects type of DMA interface implemented:
+ * 0x0 - OCP
+ * 0x1 - AHB,
+ * 0x2 - PLB
+ * 0x3 - AXI
+ * 0x4-0xF - reserved
+ */
+#define USB_CAP1_DMA_TYPE_MASK	GENMASK(11, 8)
+#define DEV_DMA_TYPE_OCP(p)	(((p) & USB_CAP1_DMA_TYPE_MASK) == (0x0 << 8))
+#define DEV_DMA_TYPE_AHB(p)	(((p) & USB_CAP1_DMA_TYPE_MASK) == (0x1 << 8))
+#define DEV_DMA_TYPE_PLB(p)	(((p) & USB_CAP1_DMA_TYPE_MASK) == (0x2 << 8))
+#define DEV_DMA_TYPE_AXI(p)	(((p) & USB_CAP1_DMA_TYPE_MASK) == (0x3 << 8))
+/*
+ * DMA Interface width
+ * These field reflects width of DMA interface implemented:
+ * 0x0 - reserved,
+ * 0x1 - reserved,
+ * 0x2 - 32 bit interface
+ * 0x3 - 64 bit interface
+ * 0x4-0xF - reserved
+ */
+#define USB_CAP1_DMA_WIDTH_MASK	GENMASK(15, 12)
+#define DEV_DMA_WIDTH_32(p)	(((p) & USB_CAP1_DMA_WIDTH_MASK) == (0x2 << 12))
+#define DEV_DMA_WIDTH_64(p)	(((p) & USB_CAP1_DMA_WIDTH_MASK) == (0x3 << 12))
+/*
+ * USB3 PHY Interface type
+ * These field reflects type of USB3 PHY interface implemented:
+ * 0x0 - USB PIPE,
+ * 0x1 - RMMI,
+ * 0x2-0xF - reserved
+ */
+#define USB_CAP1_U3PHY_TYPE_MASK GENMASK(19, 16)
+#define DEV_U3PHY_PIPE(p) (((p) & USB_CAP1_U3PHY_TYPE_MASK) == (0x0 << 16))
+#define DEV_U3PHY_RMMI(p) (((p) & USB_CAP1_U3PHY_TYPE_MASK) == (0x1 << 16))
+/*
+ * USB3 PHY Interface width
+ * These field reflects width of USB3 PHY interface implemented:
+ * 0x0 - 8 bit PIPE interface,
+ * 0x1 - 16 bit PIPE interface,
+ * 0x2 - 32 bit PIPE interface,
+ * 0x3 - 64 bit PIPE interface
+ * 0x4-0xF - reserved
+ * Note: When SSIC interface is implemented this field shows the width of
+ * internal PIPE interface. The RMMI interface is always 20bit wide.
+ */
+#define USB_CAP1_U3PHY_WIDTH_MASK GENMASK(23, 20)
+#define DEV_U3PHY_WIDTH_8(p) \
+	(((p) & USB_CAP1_U3PHY_WIDTH_MASK) == (0x0 << 20))
+#define DEV_U3PHY_WIDTH_16(p) \
+	(((p) & USB_CAP1_U3PHY_WIDTH_MASK) == (0x1 << 16))
+#define DEV_U3PHY_WIDTH_32(p) \
+	(((p) & USB_CAP1_U3PHY_WIDTH_MASK) == (0x2 << 20))
+#define DEV_U3PHY_WIDTH_64(p) \
+	(((p) & USB_CAP1_U3PHY_WIDTH_MASK) == (0x3 << 16))
+
+/*
+ * USB2 PHY Interface enable
+ * These field informs if USB2 PHY interface is implemented:
+ * 0x0 - interface NOT implemented,
+ * 0x1 - interface implemented
+ */
+#define USB_CAP1_U2PHY_EN(p)	((p) & BIT(24))
+/*
+ * USB2 PHY Interface type
+ * These field reflects type of USB2 PHY interface implemented:
+ * 0x0 - UTMI,
+ * 0x1 - ULPI
+ */
+#define DEV_U2PHY_ULPI(p)	((p) & BIT(25))
+/*
+ * USB2 PHY Interface width
+ * These field reflects width of USB2 PHY interface implemented:
+ * 0x0 - 8 bit interface,
+ * 0x1 - 16 bit interface,
+ * Note: The ULPI interface is always 8bit wide.
+ */
+#define DEV_U2PHY_WIDTH_16(p)	((p) & BIT(26))
+/*
+ * OTG Ready
+ * 0x0 - pure device mode
+ * 0x1 - some features and ports for CDNS USB OTG controller are implemented.
+ */
+#define USB_CAP1_OTG_READY(p)	((p) & BIT(27))
+
+/* USB_CAP2- bitmasks */
+/*
+ * The actual size of the connected On-chip RAM memory in kB:
+ * - 0 means 256 kB (max supported mem size)
+ * - value other than 0 reflects the mem size in kB
+ */
+#define USB_CAP2_ACTUAL_MEM_SIZE(p) ((p) & GENMASK(7, 0))
+/*
+ * Max supported mem size
+ * These field reflects width of on-chip RAM address bus width,
+ * which determines max supported mem size:
+ * 0x0-0x7 - reserved,
+ * 0x8 - support for 4kB mem,
+ * 0x9 - support for 8kB mem,
+ * 0xA - support for 16kB mem,
+ * 0xB - support for 32kB mem,
+ * 0xC - support for 64kB mem,
+ * 0xD - support for 128kB mem,
+ * 0xE - support for 256kB mem,
+ * 0xF - reserved
+ */
+#define USB_CAP2_MAX_MEM_SIZE(p) ((p) & GENMASK(11, 8))
+
+/* USB_CAP3- bitmasks */
+#define EP_IS_IMPLEMENTED(reg, index) ((reg) & (1 << (index)))
+
+/* USB_CAP4- bitmasks */
+#define EP_SUPPORT_ISO(reg, index) ((reg) & (1 << (index)))
+
+/* USB_CAP5- bitmasks */
+#define EP_SUPPORT_STREAM(reg, index) ((reg) & (1 << (index)))
+
+/* USB_CAP6- bitmasks */
+/* The USBSS-DEV Controller  Internal build number. */
+#define GET_DEV_VERSION__INTERNAL_NUMBER(p) ((p) & GENMASK(7, 0))
+/* The USBSS-DEV Controller  version number. */
+#define GET_DEV_VERSION(p) ((p) & GENMASK(31, 8))
+
+/* DBG_LINK1- bitmasks */
+/*
+ * LFPS_MIN_DET_U1_EXIT value This parameter configures the minimum
+ * time required for decoding the received LFPS as an LFPS.U1_Exit.
+ */
+#define DBG_LINK1_LFPS_MIN_DET_U1_EXIT(p)	((p) & GENMASK(7, 0))
+/*
+ * LFPS_MIN_GEN_U1_EXIT value This parameter configures the minimum time for
+ * phytxelecidle deassertion when LFPS.U1_Exit
+ */
+#define DBG_LINK1_LFPS_MIN_GEN_U1_EXIT(p)	(((p) << 8) & GENMASK(15, 8))
+/*
+ * RXDET_BREAK_DIS value This parameter configures terminating the Far-end
+ * Receiver termination detection sequence:
+ * 0: it is possible that USBSS_DEV will terminate Farend receiver
+ *    termination detection sequence
+ * 1: USBSS_DEV will not terminate Far-end receiver termination
+ *    detection sequence
+ */
+#define DBG_LINK1_RXDET_BREAK_DIS		BIT(16)
+/* LFPS_GEN_PING value This parameter configures the LFPS.Ping generation */
+#define DBG_LINK1_LFPS_GEN_PING(p)		(((p) << 17) & GENMASK(21, 17))
+/*
+ * Set the LFPS_MIN_DET_U1_EXIT value Writing '1' to this bit writes the
+ * LFPS_MIN_DET_U1_EXIT field value to the device. This bit is automatically
+ * cleared. Writing '0' has no effect
+ */
+#define DBG_LINK1_LFPS_MIN_DET_U1_EXIT_SET	BIT(24)
+/*
+ * Set the LFPS_MIN_GEN_U1_EXIT value. Writing '1' to this bit writes the
+ * LFPS_MIN_GEN_U1_EXIT field value to the device. This bit is automatically
+ * cleared. Writing '0' has no effect
+ */
+#define DBG_LINK1_LFPS_MIN_GEN_U1_EXIT_SET	BIT(25)
+/*
+ * Set the RXDET_BREAK_DIS value Writing '1' to this bit writes
+ * the RXDET_BREAK_DIS field value to the device. This bit is automatically
+ * cleared. Writing '0' has no effect
+ */
+#define DBG_LINK1_RXDET_BREAK_DIS_SET		BIT(26)
+/*
+ * Set the LFPS_GEN_PING_SET value Writing '1' to this bit writes
+ * the LFPS_GEN_PING field value to the device. This bit is automatically
+ * cleared. Writing '0' has no effect."
+ */
+#define DBG_LINK1_LFPS_GEN_PING_SET		BIT(27)
+
+#define gadget_to_cdns3_device(g) (container_of(g, struct cdns3_device, gadget))
+
+#define ep_to_cdns3_ep(ep) (container_of(ep, struct cdns3_endpoint, endpoint))
+
+/*-------------------------------------------------------------------------*/
+/*
+ * USBSS-DEV DMA interface .
+ */
+#define TRBS_PER_SEGMENT	32
+
+struct cdns3_trb {
+	__le32 buffer;
+	__le32 length;
+	__le32 control;
+};
+
+#define TRB_SIZE		(sizeof(struct cdns3_trb))
+
+/* TRB bit mask */
+#define TRB_TYPE_BITMASK	GENMASK(15, 10)
+#define TRB_TYPE(p)		((p) << 10)
+#define TRB_FIELD_TO_TYPE(p)	(((p) & TRB_TYPE_BITMASK) >> 10)
+
+/* TRB type IDs */
+/* bulk, interrupt, isoc , and control data stage */
+#define TRB_NORMAL		1
+/* TRB for linking ring segments */
+#define TRB_LINK		6
+
+/* Cycle bit - indicates TRB ownership by driver or hw*/
+#define TRB_CYCLE			BIT(0)
+/*
+ * When set to '1', the device will toggle its interpretation of the Cycle bit
+ */
+#define TRB_TOGGLE			BIT(1)
+
+/* Interrupt on short packet*/
+#define TRB_ISP				BIT(2)
+/*Setting this bit enables FIFO DMA operation mode*/
+#define TRB_FIFO_MODE			BIT(3)
+/* Set PCIe no snoop attribute */
+#define TRB_CHAIN			BIT(4)
+/* Interrupt on completion */
+#define TRB_IOC				BIT(5)
+
+/* stream ID bitmasks. */
+#define TRB_STREAM_ID(p)		((p) & GENMASK(31, 16))
+
+/* transfer_len bitmasks. */
+#define TRB_LEN(p)			((p) & GENMASK(16, 0))
+
+/* transfer_len bitmasks - bits 31:24 */
+#define TRB_BURST_LEN(p)		((p) & GENMASK(31, 24))
+
+/* Data buffer pointer bitmasks*/
+#define TRB_BUFFER(p)			((p) & GENMASK(31, 0))
+
+/*-------------------------------------------------------------------------*/
+/* Driver numeric constants */
+
+#define DEVICE_ADDRESS_MAX		127
+
+/* Endpoint init values */
+#define ENDPOINT_MAX_PACKET_LIMIT	1024
+#define ENDPOINT_MAX_STREAMS		15
+
+#define ENDPOINT0_MAX_PACKET_LIMIT	512
+
+/* All endpoints except EP0 */
+#define USB_SS_ENDPOINTS_MAX_COUNT	30
+
+#define ADDR_MODULO_8			8
+
+#define ENDPOINT_ZLP_BUF_SIZE		1024
+
+/*-------------------------------------------------------------------------*/
+/* 18KB is the total size, and 2KB is used for EP0 and configuration */
+#define CDNS3_ONCHIP_BUF_SIZE	16	/* KB */
+#define CDNS3_EP_BUF_SIZE	2	/* KB */
+#define CDNS3_UNALIGNED_BUF_SIZE	16384 /* Bytes */
+/*-------------------------------------------------------------------------*/
+/* Used structs */
+
+struct cdns3_device;
+
+struct cdns3_endpoint {
+	struct usb_ep		endpoint;
+	struct list_head	request_list;
+	struct list_head	ep_match_pending_list;
+
+	struct cdns3_trb	*trb_pool;
+	dma_addr_t		trb_pool_dma;
+
+	struct cdns3_device	*cdns3_dev;
+	char			name[20];
+
+#define EP_ENABLED		BIT(0)
+#define EP_STALL		BIT(1)
+#define EP_WEDGE		BIT(2)
+#define EP_TRANSFER_STARTED	BIT(3)
+#define EP_UPDATE_EP_TRBADDR	BIT(4)
+#define EP_PENDING_REQUEST	BIT(5)
+#define EP_USED			BIT(5)
+	u32			flags;
+
+	void			*aligned_buff;
+	dma_addr_t		aligned_dma_addr;
+	u8			dir;
+	u8			num;
+	u8			type;
+
+	int			free_trbs;
+	u8			pcs;
+	u8			ccs;
+	int			enqueue;
+	int			dequeue;
+};
+
+struct cdns3_request {
+	struct usb_request request;
+	struct cdns3_trb *trb;
+	int start_trb;
+	int end_trb;
+	int on_ring:1;
+};
+
+#define to_cdns3_request(r) (container_of(r, struct cdns3_request, request))
+
+struct cdns3_device {
+	struct device			dev;
+	struct cdns3_usb_regs		__iomem *regs;
+
+	struct usb_gadget		gadget;
+	struct usb_gadget_driver	*gadget_driver;
+
+	struct usb_ctrlrequest		*setup;
+	dma_addr_t			setup_dma;
+	dma_addr_t			trb_ep0_dma;
+	struct cdns3_trb		*trb_ep0;
+	void				*zlp_buf;
+
+	struct cdns3_endpoint		*eps[USB_SS_ENDPOINTS_MAX_COUNT];
+	int				ep_nums;
+	/*
+	 * field used for improving performance. It holds the last
+	 * selected endpoint number
+	 */
+	u32				selected_ep;
+	struct usb_request		*ep0_request;
+	int				ep0_data_dir;
+	int				hw_configured_flag;
+	int				wake_up_flag;
+	u16				isoch_delay;
+	/* generic spin-lock for drivers */
+	spinlock_t			lock;
+
+	unsigned			is_connected:1;
+	unsigned			in_standby_mode:1;
+	unsigned			status_completion_no_call:1;
+
+	u32				usb_ien;
+	u32				ep_ien;
+	int				setup_pending;
+	struct device			*sysdev;
+	/* The device mode is enabled */
+	int				start_gadget;
+	struct list_head		ep_match_list;
+	/* KB */
+	int				onchip_mem_allocated_size;
+	/* Memory is allocated for OUT */
+	int				out_mem_is_allocated:1;
+	struct work_struct		pending_status_wq;
+	struct usb_request		*pending_status_request;
+};
+
+#endif /* __LINUX_CDNS3_GADGET */
-- 
2.17.1

