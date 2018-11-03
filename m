Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52724C6786F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E85D720833
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="otWjnx+L";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="QL8zaZ+q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E85D720833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbeKDDF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 23:05:29 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:48806 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728743AbeKDDEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 23:04:31 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wA3Hphjt029618;
        Sat, 3 Nov 2018 10:52:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=TRN3186kk02HBc+t9NzA8C5fsCBkVRoIr3BZUT9Tz2E=;
 b=otWjnx+L3Hv4qFksXhhEAoOaWAlM0ebNOZDxzqlyYSZx2J7TS+3P4rdaKyyOw195YVYz
 4ht+kM47SJfSLSrdoRnNIkgvuWwE/espqleed/6oegqbk9WRIJdhT0FD2VW9JgUxvCJ9
 SgozQ0h+I5PBfzAfIcnZKs1K108Ot65Lvi8Af3pgG0Zi4hT3my4EiYih+34+sJ856GNt
 GZGWX5V2+DX1PrvXIIfyFcLlGOi7jzxLqwdNHbH7SvJzH9towi4fqp3fMyCI8eNcLAKk
 wUVxAd1sJhhT/29JQHfeul3D140mSRj8eds4jvsI/wLJFqABm+Kmv5FjvbkECmHbD+Zb wg== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp0179.outbound.protection.outlook.com [216.32.180.179])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2nh87rhmuv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sat, 03 Nov 2018 10:52:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRN3186kk02HBc+t9NzA8C5fsCBkVRoIr3BZUT9Tz2E=;
 b=QL8zaZ+qUOacJmaVgv+VYizaJT3Q9bqw01QA86Ik9ZRUE7pqGmf4tuDHeLbhuH3uQFie8nKnbbSONKZzHt2uAY8ZkoaU2enN/2IhAgxjF9nYWxF2p2RQ+vCLrk2T3maAbsbribzblq8rPaujY2u0oFw7gSgQ5RSrJWr6VILTSZs=
Received: from DM5PR07CA0031.namprd07.prod.outlook.com (2603:10b6:3:16::17) by
 SN6PR07MB5183.namprd07.prod.outlook.com (2603:10b6:805:6c::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Sat, 3 Nov 2018 17:52:24 +0000
Received: from DM3NAM05FT025.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::206) by DM5PR07CA0031.outlook.office365.com
 (2603:10b6:3:16::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1294.21 via Frontend
 Transport; Sat, 3 Nov 2018 17:52:24 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 DM3NAM05FT025.mail.protection.outlook.com (10.152.98.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1318.5 via Frontend Transport; Sat, 3 Nov 2018 17:52:23 +0000
Received: from mailrm1.global.cadence.com (mailrm1.cadence.com [10.209.213.2])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id wA3HqMu4027370
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Sat, 3 Nov 2018 10:52:22 -0700
X-CrossPremisesHeadersFilteredBySendConnector: mailrm1.global.cadence.com
Received: from mailrm1.global.cadence.com (10.209.213.2) by
 mailrm1.global.cadence.com (10.209.213.2) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sat, 3 Nov 2018 13:52:26 -0400
Received: from rmmaillnx1.cadence.com (10.209.208.46) by
 mailrm1.global.cadence.com (10.209.213.2) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Sat, 3 Nov 2018 13:52:26 -0400
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id wA3Hq9x6000566
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Sat, 3 Nov 2018 13:52:20 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sat, 3 Nov 2018 18:52:16 +0100
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Sat, 3 Nov 2018 18:52:16 +0100
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id wA3HqBk2006449;
        Sat, 3 Nov 2018 17:52:11 GMT
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id wA3HqBM2006432;
        Sat, 3 Nov 2018 17:52:11 GMT
From:   Pawel Laszczak <pawell@cadence.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <rogerq@ti.com>,
        <linux-kernel@vger.kernel.org>, <adouglas@cadence.com>,
        <jbergsagel@ti.com>, <peter.chen@nxp.com>, <pjez@cadence.com>,
        <kurahul@cadence.com>, <pawell@cadence.com>
Subject: [RFC PATCH v1 08/14] usb:cdns3: EpX operations part of the API
Date:   Sat, 3 Nov 2018 17:51:21 +0000
Message-ID: <1541267487-3664-9-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1541267487-3664-1-git-send-email-pawell@cadence.com>
References: <1541267487-3664-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-OrganizationHeadersPreserved: mailrm1.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(136003)(39860400002)(2980300002)(199004)(189003)(36092001)(14444005)(36756003)(2351001)(7636002)(305945005)(4326008)(486006)(2616005)(126002)(48376002)(446003)(11346002)(217873002)(50466002)(336012)(107886003)(478600001)(476003)(26826003)(87636003)(50226002)(51416003)(54906003)(76176011)(16586007)(2906002)(86362001)(26005)(106466001)(246002)(105596002)(186003)(47776003)(356004)(6666004)(426003)(4720700003)(6916009)(5660300001)(4744004)(8936002)(8676002)(316002)(42186006);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB5183;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT025;1:HRbyNYJOBCBTMsaJyAFFWpokND9IwLr4gG9s8wCXPVpHZ61qZhCs0LkYsWJ084Q/EFgzE5/pu4WXlvn3d03d9O9ygIQXgWEYuymcUPhS0D9RQ5BWkK8gO+fDhxF4nMAT
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1aff7546-d63e-4fcd-3c4e-08d641b51c78
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060);SRVR:SN6PR07MB5183;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB5183;3:fEMQSq8Yc9Uo2cz6OlHiojeDWOjWz9I+8BA7hJtxrNXQI3fNh8Xb+JYWe95/SlmqLck/001EmkaosiHehsP+TPGWyZUYQikqEbHwRWVuSIsg57dZ95R8C/64kMzYWi11+3x9gE+ki2opRSw3xrYbO3veJ6GJJaueglqufaDF6vgK47jEKC5IWF2pdITFEvinxbiPcPuBg6EeDNLif27juRBgXvdlIMhfdBp7i+1bXp1tLsWWJqGYzbK+5ibnwzC659MbpGgVnv/63M72NQBSGiS+IPIERuHWzl2EcaVeBu4QVneCBcq2Q/oyw3AiC3cr8fAKOw+RzpVWd3yoIqwWSCWp+bQZymVdW3tJijxWfZc=;25:PQ0vCxKkdFPfGC1u3+91QUtv3jn0pgSAqddKIUuM9RCFZf5fUl4bvXP0NEWV4vfxpL6WPB5Vwpja8dox4HBMSSxfUg+sNPIQ2jqzD3tLKlhiaL7VIMATWsO3tPQH6TAs4Jv8YcNOTdHbOKmi5fpjlfg5Ekk+OKAxYg13c/JWwieczOT/PLWF5Os7oDZwTI/ABhZtEyvR/ZpautVmfocxUUDl27TcMOEQT/QZ1aGnC2UwGj3TWDeAibN9GJDhEnAfrZrLPV/lO0OeClPmmeb5VbvgVzJhox+Yv3iWvVCVb1W0GJTS+bjdVYTuLHNCfO2tIDpxLMfTRwPibs7ZNjrz+w==
X-MS-TrafficTypeDiagnostic: SN6PR07MB5183:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB5183;31:9/VD9/Q3OSbGEDY8VEOMaiNrwThW0SXeTqQfzmhT/3Ez4MkXKYXH+sVY3dtJ5FlfaE6lPXxU5+LSzgYiQA1UPuqQbuSdR/Q0NyFgJW/8UF754Aciko2ixtmPR/ZahrZnQH4NHgUSiebZbx5caW72wQrDB4XElCuYllr/IavZUS1zuEdA0owXw1AwcyYxaZ8ZwwEW2t8eafPURRAPUicAMsAmaYXGaDdYGfyjSC6JnQ4=;20:Ja1swcLs7f33MH5A1WEDlbZV+r6yliI5MOdAPZ5WZDOfCZu/ct3NUaXA/adnBx9L4PCo6k9A0sSPGAKfe9besQvodKjX505uCm+qQova4Rgk70B8R8lNaqIxmEhcI06HGGewIFEpOD7IkujD9tO0pFY4BjPbHVSu48GRbTBDEzx2DK6QN7c+7Lb0DreXM2RYNTQSaSmPGCkSI/Kg9kCjzOujW3bzHkbImlD60te5x5lvMzRhLwTpaqrL6OMgtzfGNyXmsm5rO5oyiCyX6/SQvzrGF5Ok3DnhRIuXD6AuwI0nrGYz//EvWkwyVM7nnrcWG7VaBdlsSifK7RTTHxE/4L2hucsARMWWu8G4kfhGHCej/7mjKg2fI1l9hMgXFnUtnAYOe4elBoRlR5XCDT3+zaEpSzvOewK9g6ioqTX9WLBimRGC4G5Y/+PJRWnaVsXCjRzDiNU+Se6UAbK//wOe3xmofWJ6Li1yw1Ec9b2fMezt8Kxv37VTt4nBQswBJuEf
X-Microsoft-Antispam-PRVS: <SN6PR07MB5183AC390B6169D5AADA49BEDDC80@SN6PR07MB5183.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93003095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:SN6PR07MB5183;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB5183;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB5183;4:RAYCcntcozu+Vc5pOGrD65XXm1ncI3r3Lez2A6hB2LTV4pg9S7oC/gGDt081piSgP3MO2XC3qM6K/IdmhaYKGsQ7NWe4PK+3lNuSmT58kvESkCR7HB3H53mA95YIThXPUPkDecZ1+LLOC0ibgwiS3xU4OSGP4Fr3mFmlbEcUzXAkwp25qs5hSDtSLsK8BfhjMyL6I3gcRZ3BjHJFYiG17HRQM2IFcjDnH6v5pcRzJGG7qlTdF9FsNK8fN49Nrek5wHe6zlhtnoKyN2tGQa7KvpjswZE3qUUhd/tK+stqskUonJmKZ5mhiwyPzSvbOgNs
X-Forefront-PRVS: 08457955C4
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR07MB5183;23:oiVqw7D5iWg+3NCUptkcF3UXZcwcCAbZU4X8Q9V1v?=
 =?us-ascii?Q?e65iTdLcQM8ojcQS8bTkA/hN6901ju5o7X+BKXRvuuAqANIz0Z5Uw6waQ1VH?=
 =?us-ascii?Q?nNb6IgambxTqtLaZS0AwehA2FMOd5nGmXKh3I4JfuCITGStPtNJJHS2nc91k?=
 =?us-ascii?Q?TlD06I/qedyek2cdDQZoWg2tLcUfX0AihD0RSn+y05skoM/htvi/BbINM7si?=
 =?us-ascii?Q?kwL89N9HMsY81z/Tsj/BxDZTxtQYzHPpRz2Ma/O/SRNDWEA1ZaKGpvJZBZZD?=
 =?us-ascii?Q?SG/jeZiDklVStgozMUVLkqUWaNUmDike7A35r1VHIaPCfiXEBjHFC87JLMHS?=
 =?us-ascii?Q?2WuPG+JOXH3hrsSJkYGuIZTCYlT1VwBb0VPgI8XU8fMCZmI2FZCYQOR17xZ4?=
 =?us-ascii?Q?6Xq1rwEhNTCmh5FvLXY7/CArXpADwwPvhFlhTVpQMijIVV9kVPxp9B+NpO5Y?=
 =?us-ascii?Q?vbTEWeuv9Kdnok8O2xmL/PXuJ1vwJ6mkm+TAbBNevtdm4NqDA+jpF2M7Jod1?=
 =?us-ascii?Q?oM2wDND61fNsfeETxfbXcWdS+PnEDzHzY/bkV08IbsbBwGb1T7FccExk3KhG?=
 =?us-ascii?Q?Ydjk2pMSXNrJCYi1cU3kPKCe5Iii9DroLJG8/5U4XAcXtHdXvEDiCc6p5MW3?=
 =?us-ascii?Q?/Xr0pMH/QnEMdczCcpOVyuYx4AyEghFogsIdvUYXLzgH2vGzRDkkMMARUsNn?=
 =?us-ascii?Q?WL/zRuiFx/MfwUw+D3aAKO4Sf8IFwj2cKSsW+gv4QZMvxw5qSeYcxfOzGX9A?=
 =?us-ascii?Q?/YrtbssgHbVIlz3mYhvM86I9AWm+AcQSnV7vOATeyA7IcfxUZvuc4LoQ6sC3?=
 =?us-ascii?Q?8I+ZEfS5v+3/kQtxE5JE3uHIKqrXuQXTNaUCh4B1cN40c78dYGUG3CKSXn8o?=
 =?us-ascii?Q?xPMwWhjGbl3u7Pni1TIYOWSvYo8myjP669gwUW99zmH9uEQNcpROkJoGkyHV?=
 =?us-ascii?Q?WFYfT8/UXtoRTnIziSn08cMTvolp6Enj6gxSTiX9N5WNJmZFgM90J3rg60El?=
 =?us-ascii?Q?MX7e870LxfnyeKSlLWP6Q7pu0SDoGWZG7nUC0KBoTmWc1mQ5jRv9oM1EJO9S?=
 =?us-ascii?Q?bPFWR800BVZpumDNwgnk9pvvY9H7zNo13Q6La7VtvWvxjSlH3TJVwoObaCC2?=
 =?us-ascii?Q?3rHEWxAmn0YnesxxQPyBWT4IyOYCwlSckyU0ZXg2afYlC/1VvHgGF7FEYl1B?=
 =?us-ascii?Q?Ly9fgI70OTuhm4=3D?=
X-Microsoft-Antispam-Message-Info: +novW7EN6Aj0CTOils5ce/Oifvr2IDmvHjWCZ7fV38jAu96gARfqW+hP+CaA1KDaP/72nEYF6R2LCNz7dnw38AiKzEWU2kVeciIEKPT52ZwIB9tM5KXlYKufuCULune0jOsIEhneIugwGvV03qdKVqpkm63VOn7H3YLs1ndWTKsD3BXrI8mVCMFOSDimxWrt4GYmjgEXSquzwd1XyxF6z+Rvjv0aGTK07Ltk4/oYE+Zp+poI/qarwRkaSIVkqPjt8/hQ9vV2Fe5YQV5jxS4YQipDougPZaGPoe0CmuIgY413WWdsAsWXh/E4ChpRg0+NtKO5pCJBJKwO1YzpyZZouwEZzn0Trtv1jkI01H/mggA=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB5183;6:RUBySY1QR8qY+6S/SFODQwBd/u31lHlHML6VxxHZsVzZjbbjL9GqACYdX9ywQf7ZrJyyzisrPmausxSAq1pULlWS6t1TpjF0xL9CRofwTSn/P3qoV40On28VG93murqwFCNi5ftQrBPj/Wq/Kwm6N4fAKan8cTDjouWQE+Bwd5FscgnznE5+xLi+TVakeel8N4LGENQRqyREP89MuS23IXbsEdTAS6oRAD69RAgR3Egged0mog3qxSsfzQP2UyDjX86KvBo2xv1VBQeWz/mSzvwklyn5hGilB+knJPtSv3XHpbjTsS4gD+cNFqapObmEwAgLIk8aeYexA7BI6bKC009kjEqtkO/TZYyNyXCSbjCwVNquK0cRnJsOi1WMtQablPuRCLYOeh5Yv/3Rw4SisoU59DV+Vha2LJ1BvvjmQ0ZihAkhTaHz1RfYDqo0cyA8gZijrC6qH6KI4xFvzjNEeA==;5:lygidwRDeRGSr70Zd/LZtVQxrKDaw7GlWzWc5EGDW2dy9o1U+4IFntgt6sCwYaVKbjIprR9T3BaCX1EjwHAOMthUEIuxss3MKc96/LYEmWSVNMFT04W62d2u+9PCd5X7HgU2W30ZZsKWUxIYMBwmPITwHNvs7Hqeq6BsPW9CiiQ=;7:xhAzJU7gWlbAusOqLOBBbqsitfTwSwkOKLLftfcekQxmRzykN0wa/jS1ezjfxFadL6R1vrFytijiUHkWddYKTBAjBAMP5TLzjJncGArZtWJXBfBWMB3XBAOWN7zzQ6UZlhnaCCx0guygzSmKBYwB9Q==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB5183;20:Opg6lkPhmTtMk5m2ebHbbjCh5bUptx6HpiWs9BKfxXA6nW6xunF0Xk9kYL0wQXQaXH0Qeld79DyuRVnTW6cNqEq6yf/56t3/mH+go5CxrmFphjAktawYDuaCTHiO7CvgZbwhaLIST+JtmDmjb96unNcZOzDQ5iC2N1MS7TzZf1Vsi2fzyYAGw0INxyTsoi8TM49PuxM10NZWbIBayXNQLLt9WuMxoNaeHCuCW8Zrk0mdNvht7aBCTvk78bL9bUI1
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2018 17:52:23.7812
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aff7546-d63e-4fcd-3c4e-08d641b51c78
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB5183
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
 mlxlogscore=740 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811030169
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch implements callback functions for non-default endpoints
defined in usb_ep_ops object.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/ep0.c    |  18 ++
 drivers/usb/cdns3/gadget.c | 430 ++++++++++++++++++++++++++++++++++++-
 drivers/usb/cdns3/gadget.h |   3 +
 3 files changed, 449 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/cdns3/ep0.c b/drivers/usb/cdns3/ep0.c
index c08d02665f9d..ca1795467155 100644
--- a/drivers/usb/cdns3/ep0.c
+++ b/drivers/usb/cdns3/ep0.c
@@ -23,6 +23,24 @@ static void cdns3_prepare_setup_packet(struct cdns3_device *priv_dev)
 	//TODO: Implements this function
 }
 
+/**
+ * cdns3_gadget_ep_set_wedge Set wedge on selected endpoint
+ * @ep: endpoint object
+ *
+ * Returns 0
+ */
+int cdns3_gadget_ep_set_wedge(struct usb_ep *ep)
+{
+	struct cdns3_endpoint *priv_ep = ep_to_cdns3_ep(ep);
+	struct cdns3_device *priv_dev = priv_ep->cdns3_dev;
+
+	dev_dbg(&priv_dev->dev, "Wedge for %s\n", ep->name);
+	cdns3_gadget_ep_set_halt(ep, 1);
+	priv_ep->flags |= EP_WEDGE;
+
+	return 0;
+}
+
 /**
  * cdns3_ep0_config - Configures default endpoint
  * @priv_dev: extended gadget object
diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
index ff8306ac070e..b08e0836f9a5 100644
--- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/gadget.c
@@ -58,6 +58,19 @@ void cdns3_set_register_bit(void __iomem *ptr, u32 mask)
 	writel(mask, ptr);
 }
 
+/**
+ * cdns3_next_request - returns next request from list
+ * @list: list containing requests
+ *
+ * Returns request or NULL if no requests in list
+ */
+struct usb_request *cdns3_next_request(struct list_head *list)
+{
+	if (list_empty(list))
+		return NULL;
+	return list_first_entry(list, struct usb_request, list);
+}
+
 /**
  * select_ep - selects endpoint
  * @priv_dev:  extended gadget object
@@ -75,6 +88,46 @@ void cdns3_select_ep(struct cdns3_device *priv_dev, u32 ep)
 	wmb();
 }
 
+/**
+ * cdns3_allocate_trb_pool - Allocates TRB's pool for selected endpoint
+ * @priv_ep:  endpoint object
+ *
+ * Function will return 0 on success or -ENOMEM on allocation error
+ */
+static int cdns3_allocate_trb_pool(struct cdns3_endpoint *priv_ep)
+{
+	struct cdns3_device *priv_dev = priv_ep->cdns3_dev;
+	struct cdns3_trb *link_trb;
+
+	priv_ep->trb_pool = dma_zalloc_coherent(priv_dev->sysdev,
+						TRB_SIZE * TRBS_PER_SEGMENT,
+						&priv_ep->trb_pool_dma,
+						GFP_DMA);
+	if (!priv_ep->trb_pool)
+		return -ENOMEM;
+
+	priv_ep->aligned_buff = dma_alloc_coherent(priv_dev->sysdev,
+						   CDNS3_UNALIGNED_BUF_SIZE,
+						   &priv_ep->aligned_dma_addr,
+						   GFP_DMA);
+	if (!priv_ep->aligned_buff) {
+		dma_free_coherent(priv_dev->sysdev,
+				  TRB_SIZE * TRBS_PER_SEGMENT,
+				  priv_ep->trb_pool, priv_ep->trb_pool_dma);
+		priv_ep->trb_pool = NULL;
+
+		return -ENOMEM;
+	}
+
+	/* Initialize the last TRB as Link TRB */
+	link_trb = (priv_ep->trb_pool + TRBS_PER_SEGMENT - 1);
+	link_trb->buffer = TRB_BUFFER(priv_ep->trb_pool_dma);
+	link_trb->control = TRB_CYCLE | TRB_TYPE(TRB_LINK) |
+			    TRB_CHAIN | TRB_TOGGLE;
+
+	return 0;
+}
+
 static void cdns3_free_trb_pool(struct cdns3_endpoint *priv_ep)
 {
 	struct cdns3_device *priv_dev = priv_ep->cdns3_dev;
@@ -89,6 +142,73 @@ static void cdns3_free_trb_pool(struct cdns3_endpoint *priv_ep)
 	priv_ep->aligned_buff = NULL;
 }
 
+/**
+ * cdns3_data_flush - flush data at onchip buffer
+ * @priv_ep: endpoint object
+ *
+ * Endpoint must be selected before call to this function
+ *
+ * Returns zero on success or negative value on failure
+ */
+static int cdns3_data_flush(struct cdns3_endpoint *priv_ep)
+{
+	struct cdns3_device *priv_dev = priv_ep->cdns3_dev;
+
+	writel(EP_CMD_DFLUSH, &priv_dev->regs->ep_cmd);
+
+	/* wait for DFLUSH cleared */
+	return cdns3_handshake(&priv_dev->regs->ep_cmd, EP_CMD_DFLUSH, 0, 100);
+}
+
+/**
+ * cdns3_ep_stall_flush - Stalls and flushes selected endpoint
+ * @priv_ep: endpoint object
+ *
+ * Endpoint must be selected before call to this function
+ */
+static void cdns3_ep_stall_flush(struct cdns3_endpoint *priv_ep)
+{
+	struct cdns3_device *priv_dev = priv_ep->cdns3_dev;
+
+	writel(EP_CMD_DFLUSH | EP_CMD_ERDY | EP_CMD_SSTALL,
+	       &priv_dev->regs->ep_cmd);
+
+	/* wait for DFLUSH cleared */
+	cdns3_handshake(&priv_dev->regs->ep_cmd, EP_CMD_DFLUSH, 0, 100);
+	priv_ep->flags |= EP_STALL;
+}
+
+/**
+ * cdns3_gadget_giveback - call struct usb_request's ->complete callback
+ * @priv_ep: The endpoint to whom the request belongs to
+ * @priv_req: The request we're giving back
+ * @status: completion code for the request
+ *
+ * Must be called with controller's lock held and interrupts disabled. This
+ * function will unmap @req and call its ->complete() callback to notify upper
+ * layers that it has completed.
+ */
+void cdns3_gadget_giveback(struct cdns3_endpoint *priv_ep,
+			   struct cdns3_request *priv_req,
+			   int status)
+{
+	//TODO: Implements this function.
+}
+
+/**
+ * cdns3_ep_run_transfer - start transfer on no-default endpoint hardware
+ * @priv_ep: endpoint object
+ *
+ * Returns zero on success or negative value on failure
+ */
+int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
+			  struct usb_request *request)
+{
+	//TODO: Implements this function.
+
+	return 0;
+}
+
 /**
  * cdns3_irq_handler - irq line interrupt handler
  * @cdns: cdns3 instance
@@ -167,6 +287,313 @@ static struct usb_ep *cdns3_gadget_match_ep(struct usb_gadget *gadget,
 	return &priv_ep->endpoint;
 }
 
+/**
+ * cdns3_gadget_ep_enable Enable endpoint
+ * @ep: endpoint object
+ * @desc: endpoint descriptor
+ *
+ * Returns 0 on success, error code elsewhere
+ */
+static int cdns3_gadget_ep_enable(struct usb_ep *ep,
+				  const struct usb_endpoint_descriptor *desc)
+{
+	struct cdns3_endpoint *priv_ep;
+	struct cdns3_device *priv_dev;
+	unsigned long flags;
+	int ret;
+
+	priv_ep = ep_to_cdns3_ep(ep);
+	priv_dev = priv_ep->cdns3_dev;
+
+	if (!ep || !desc || desc->bDescriptorType != USB_DT_ENDPOINT) {
+		dev_err(&priv_dev->dev, "usbss: invalid parameters\n");
+		return -EINVAL;
+	}
+
+	if (!desc->wMaxPacketSize) {
+		dev_err(&priv_dev->dev, "usbss: missing wMaxPacketSize\n");
+		return -EINVAL;
+	}
+
+	if (dev_WARN_ONCE(&priv_dev->dev, priv_ep->flags & EP_ENABLED,
+			  "%s is already enabled\n", priv_ep->name))
+		return 0;
+
+	ret = cdns3_allocate_trb_pool(priv_ep);
+	if (ret)
+		return ret;
+
+	dev_dbg(&priv_dev->dev, "Enabling endpoint: %s\n", ep->name);
+	spin_lock_irqsave(&priv_dev->lock, flags);
+	cdns3_select_ep(priv_dev, desc->bEndpointAddress);
+	writel(EP_CMD_EPRST, &priv_dev->regs->ep_cmd);
+
+	ret = cdns3_handshake(&priv_dev->regs->ep_cmd,
+			      EP_CMD_EPRST, 0, 100);
+
+	cdns3_set_register_bit(&priv_dev->regs->ep_cfg, EP_CFG_ENABLE);
+
+	ep->desc = desc;
+	priv_ep->flags &= ~(EP_PENDING_REQUEST | EP_STALL);
+	priv_ep->flags |= EP_ENABLED | EP_UPDATE_EP_TRBADDR;
+	priv_ep->enqueue = 0;
+	priv_ep->dequeue = 0;
+	priv_ep->pcs = 1;
+	priv_ep->ccs = 1;
+	/* one TRB is reserved for link TRB used in DMULT mode*/
+	priv_ep->free_trbs = TRBS_PER_SEGMENT - 1;
+
+	spin_unlock_irqrestore(&priv_dev->lock, flags);
+	return 0;
+}
+
+/**
+ * cdns3_gadget_ep_disable Disable endpoint
+ * @ep: endpoint object
+ *
+ * Returns 0 on success, error code elsewhere
+ */
+static int cdns3_gadget_ep_disable(struct usb_ep *ep)
+{
+	struct cdns3_endpoint *priv_ep;
+	struct cdns3_device *priv_dev;
+	unsigned long flags;
+	int ret = 0;
+	struct usb_request *request;
+	u32 ep_cfg;
+
+	if (!ep) {
+		pr_debug("usbss: invalid parameters\n");
+		return -EINVAL;
+	}
+
+	priv_ep = ep_to_cdns3_ep(ep);
+	priv_dev = priv_ep->cdns3_dev;
+
+	if (dev_WARN_ONCE(&priv_dev->dev, !(priv_ep->flags & EP_ENABLED),
+			  "%s is already disabled\n", priv_ep->name))
+		return 0;
+
+	spin_lock_irqsave(&priv_dev->lock, flags);
+	if (!priv_dev->start_gadget) {
+		dev_dbg(&priv_dev->dev,
+			"Disabling endpoint at disconnection: %s\n", ep->name);
+		spin_unlock_irqrestore(&priv_dev->lock, flags);
+		return 0;
+	}
+
+	dev_dbg(&priv_dev->dev, "Disabling endpoint: %s\n", ep->name);
+
+	cdns3_select_ep(priv_dev, ep->desc->bEndpointAddress);
+	ret = cdns3_data_flush(priv_ep);
+	while (!list_empty(&priv_ep->request_list)) {
+		request = cdns3_next_request(&priv_ep->request_list);
+
+		cdns3_gadget_giveback(priv_ep, to_cdns3_request(request),
+				      -ESHUTDOWN);
+	}
+
+	ep_cfg = readl(&priv_dev->regs->ep_cfg);
+	ep_cfg &= ~EP_CFG_ENABLE;
+	writel(ep_cfg, &priv_dev->regs->ep_cfg);
+	ep->desc = NULL;
+	priv_ep->flags &= ~EP_ENABLED;
+
+	spin_unlock_irqrestore(&priv_dev->lock, flags);
+
+	return ret;
+}
+
+/**
+ * cdns3_gadget_ep_alloc_request Allocates request
+ * @ep: endpoint object associated with request
+ * @gfp_flags: gfp flags
+ *
+ * Returns allocated request address, NULL on allocation error
+ */
+struct usb_request *cdns3_gadget_ep_alloc_request(struct usb_ep *ep,
+						  gfp_t gfp_flags)
+{
+	struct cdns3_request *priv_req;
+
+	priv_req = kzalloc(sizeof(*priv_req), gfp_flags);
+	if (!priv_req)
+		return NULL;
+
+	return &priv_req->request;
+}
+
+/**
+ * cdns3_gadget_ep_free_request Free memory occupied by request
+ * @ep: endpoint object associated with request
+ * @request: request to free memory
+ */
+void cdns3_gadget_ep_free_request(struct usb_ep *ep,
+				  struct usb_request *request)
+{
+	struct cdns3_request *priv_req = to_cdns3_request(request);
+
+	kfree(priv_req);
+}
+
+/**
+ * cdns3_gadget_ep_queue Transfer data on endpoint
+ * @ep: endpoint object
+ * @request: request object
+ * @gfp_flags: gfp flags
+ *
+ * Returns 0 on success, error code elsewhere
+ */
+static int __cdns3_gadget_ep_queue(struct usb_ep *ep,
+				   struct usb_request *request,
+				   gfp_t gfp_flags)
+{
+	struct cdns3_endpoint *priv_ep = ep_to_cdns3_ep(ep);
+	struct cdns3_device *priv_dev = priv_ep->cdns3_dev;
+	int ret = 0;
+
+	request->actual = 0;
+	request->status = -EINPROGRESS;
+
+	dev_dbg(&priv_dev->dev, "Queuing to endpoint: %s\n", priv_ep->name);
+
+	ret = usb_gadget_map_request_by_dev(priv_dev->sysdev, request,
+					    usb_endpoint_dir_in(ep->desc));
+
+	if (ret)
+		return ret;
+
+	if (!cdns3_ep_run_transfer(priv_ep, request))
+		list_add_tail(&request->list, &priv_ep->request_list);
+
+	return ret;
+}
+
+static int cdns3_gadget_ep_queue(struct usb_ep *ep, struct usb_request *request,
+				 gfp_t gfp_flags)
+{
+	struct cdns3_endpoint *priv_ep = ep_to_cdns3_ep(ep);
+	struct cdns3_device *priv_dev = priv_ep->cdns3_dev;
+	struct usb_request *zlp_request;
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&priv_dev->lock, flags);
+	ret = __cdns3_gadget_ep_queue(ep, request, gfp_flags);
+
+	if (ret == 0 && request->zero && request->length &&
+	    (request->length % ep->maxpacket == 0)) {
+		zlp_request = cdns3_gadget_ep_alloc_request(ep, GFP_ATOMIC);
+		zlp_request->buf = priv_dev->zlp_buf;
+		zlp_request->length = 0;
+
+		dev_dbg(&priv_dev->dev, "Queuing ZLP for endpoint: %s\n",
+			priv_ep->name);
+		ret = __cdns3_gadget_ep_queue(ep, zlp_request, gfp_flags);
+	}
+
+	spin_unlock_irqrestore(&priv_dev->lock, flags);
+	return ret;
+}
+
+/**
+ * cdns3_gadget_ep_dequeue Remove request from transfer queue
+ * @ep: endpoint object associated with request
+ * @request: request object
+ *
+ * Returns 0 on success, error code elsewhere
+ */
+int cdns3_gadget_ep_dequeue(struct usb_ep *ep,
+			    struct usb_request *request)
+{
+	struct cdns3_endpoint *priv_ep = ep_to_cdns3_ep(ep);
+	struct cdns3_device *priv_dev = priv_ep->cdns3_dev;
+	struct usb_request *req, *req_temp;
+	unsigned long flags;
+	int ret = 0;
+
+	if (!ep || !request || !ep->desc)
+		return -EINVAL;
+
+	spin_lock_irqsave(&priv_dev->lock, flags);
+	dev_dbg(&priv_dev->dev, "Dequeue from %s\n", ep->name);
+
+	cdns3_select_ep(priv_dev, ep->desc->bEndpointAddress);
+	if (priv_dev->start_gadget)
+		ret = cdns3_data_flush(priv_ep);
+
+	list_for_each_entry_safe(req, req_temp, &priv_ep->request_list, list) {
+		if (request == req) {
+			cdns3_gadget_giveback(priv_ep,
+					      to_cdns3_request(request),
+					      -ECONNRESET);
+			break;
+		}
+	}
+
+	spin_unlock_irqrestore(&priv_dev->lock, flags);
+	return ret;
+}
+
+/**
+ * cdns3_gadget_ep_set_halt Sets/clears stall on selected endpoint
+ * @ep: endpoint object to set/clear stall on
+ * @value: 1 for set stall, 0 for clear stall
+ *
+ * Returns 0 on success, error code elsewhere
+ */
+int cdns3_gadget_ep_set_halt(struct usb_ep *ep, int value)
+{
+	struct cdns3_endpoint *priv_ep = ep_to_cdns3_ep(ep);
+	struct cdns3_device *priv_dev = priv_ep->cdns3_dev;
+	unsigned long flags;
+	int ret = 0;
+
+	if (!(priv_ep->flags & EP_ENABLED))
+		return -EPERM;
+
+	/* if actual transfer is pending defer setting stall on this endpoint */
+	if ((priv_ep->flags & EP_PENDING_REQUEST) && value) {
+		priv_ep->flags |= EP_STALL;
+		return 0;
+	}
+
+	dev_dbg(&priv_dev->dev, "Halt endpoint %s\n", priv_ep->name);
+
+	spin_lock_irqsave(&priv_dev->lock, flags);
+
+	cdns3_select_ep(priv_dev, ep->desc->bEndpointAddress);
+	if (value) {
+		cdns3_ep_stall_flush(priv_ep);
+	} else {
+		priv_ep->flags &= ~EP_WEDGE;
+		writel(EP_CMD_CSTALL | EP_CMD_EPRST, &priv_dev->regs->ep_cmd);
+
+		/* wait for EPRST cleared */
+		ret = cdns3_handshake(&priv_dev->regs->ep_cmd,
+				      EP_CMD_EPRST, 0, 100);
+		priv_ep->flags &= ~EP_STALL;
+	}
+
+	priv_ep->flags &= ~EP_PENDING_REQUEST;
+	spin_unlock_irqrestore(&priv_dev->lock, flags);
+
+	return ret;
+}
+
+extern const struct usb_ep_ops cdns3_gadget_ep0_ops;
+
+static const struct usb_ep_ops cdns3_gadget_ep_ops = {
+	.enable = cdns3_gadget_ep_enable,
+	.disable = cdns3_gadget_ep_disable,
+	.alloc_request = cdns3_gadget_ep_alloc_request,
+	.free_request = cdns3_gadget_ep_free_request,
+	.queue = cdns3_gadget_ep_queue,
+	.dequeue = cdns3_gadget_ep_dequeue,
+	.set_halt = cdns3_gadget_ep_set_halt,
+	.set_wedge = cdns3_gadget_ep_set_wedge,
+};
+
 /**
  * cdns3_gadget_get_frame Returns number of actual ITP frame
  * @gadget: gadget object
@@ -363,8 +790,7 @@ static int cdns3_init_ep(struct cdns3_device *priv_dev)
 		usb_ep_set_maxpacket_limit(&priv_ep->endpoint,
 					   ENDPOINT_MAX_PACKET_LIMIT);
 		priv_ep->endpoint.max_streams = ENDPOINT_MAX_STREAMS;
-		//TODO: Add implementation of cdns3_gadget_ep_ops
-		//priv_ep->endpoint.ops = &cdns3_gadget_ep_ops;
+		priv_ep->endpoint.ops = &cdns3_gadget_ep_ops;
 		if (ep_dir)
 			priv_ep->endpoint.caps.dir_in = 1;
 		else
diff --git a/drivers/usb/cdns3/gadget.h b/drivers/usb/cdns3/gadget.h
index b57e863017b0..3930613aadda 100644
--- a/drivers/usb/cdns3/gadget.h
+++ b/drivers/usb/cdns3/gadget.h
@@ -1068,4 +1068,7 @@ void cdns3_set_register_bit(void __iomem *ptr, u32 mask);
 int cdns3_init_ep0(struct cdns3_device *priv_dev);
 void cdns3_ep0_config(struct cdns3_device *priv_dev);
 void cdns3_select_ep(struct cdns3_device *priv_dev, u32 ep);
+int cdns3_gadget_ep_set_wedge(struct usb_ep *ep);
+int cdns3_gadget_ep_set_halt(struct usb_ep *ep, int value);
+
 #endif /* __LINUX_CDNS3_GADGET */
-- 
2.17.1

