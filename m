Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7DEC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 10:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B9DB2080F
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 10:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="FQz6BEBd";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="CSUEf4Bl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B9DB2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbeKRUaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 15:30:55 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:36316 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726496AbeKRUax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 15:30:53 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wAIA6XnV016036;
        Sun, 18 Nov 2018 02:10:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=IU5xWtnQbDKlW2AMf56bgygAy4p4gNuRR8ruv0c9cKQ=;
 b=FQz6BEBdDcliFu+cMjHQpsg7diupt3AmRtnjbE6/LY+rFtwnvYgwX2WOztR8pt0IHRGC
 O8lC1reKtnMBkfJq+oXu0g7Db+Z7pSs/8jI/68xMrC5Bw/Hw1z4Wa5sDxcbIawCnzHYp
 AAfEyoBJmp3b6z4ZXpLPAQqA/GiWWf8kfTKOVRRYeDseS6aiV3prZxfz45CnMUk4JwqK
 oMwnVSBihl6dswJCFH7mb3PYoBPhzoYj2PE6tNX9oDEX/b+gjjXRpPYztbJSh4zXXfWm
 yLC45S6rlvxQQfD/JEauPgFOv2cQKKSyfg2rVUmiLPDU8h8NuE1ZlEQfpzuel3WPCM6q 5Q== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp0088.outbound.protection.outlook.com [216.32.181.88])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2ntge14vft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 18 Nov 2018 02:10:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IU5xWtnQbDKlW2AMf56bgygAy4p4gNuRR8ruv0c9cKQ=;
 b=CSUEf4BlWo/CKLRn9+EFx8EDyCGpWgOUirsLcgteWgIc3uYYCf+4Vj4Qh+/4McevnzwvBvVkhWOvvY0Vfime+6FVPUMVR+Xg+ub7Aj53oQvWspupDeYQqftMdlz55081Olulm7lwgf8DefUKibb6vjSj9PiJYJRjNKxEspodKfY=
Received: from BYAPR07CA0011.namprd07.prod.outlook.com (2603:10b6:a02:bc::24)
 by SN6PR07MB5181.namprd07.prod.outlook.com (2603:10b6:805:6c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.23; Sun, 18 Nov
 2018 10:10:40 +0000
Received: from DM3NAM05FT018.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::204) by BYAPR07CA0011.outlook.office365.com
 (2603:10b6:a02:bc::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1339.21 via Frontend
 Transport; Sun, 18 Nov 2018 10:10:40 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 DM3NAM05FT018.mail.protection.outlook.com (10.152.98.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.3 via Frontend Transport; Sun, 18 Nov 2018 10:10:39 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id wAIAAb5I029622
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Sun, 18 Nov 2018 02:10:38 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sun, 18 Nov 2018 11:10:40 +0100
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Sun, 18 Nov 2018 11:10:39 +0100
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id wAIAAaxY030887;
        Sun, 18 Nov 2018 10:10:36 GMT
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id wAIAAZga030825;
        Sun, 18 Nov 2018 10:10:35 GMT
From:   Pawel Laszczak <pawell@cadence.com>
To:     <devicetree@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <rogerq@ti.com>, <linux-kernel@vger.kernel.org>,
        <adouglas@cadence.com>, <jbergsagel@ti.com>, <nsekhar@ti.com>,
        <nm@ti.com>, <sureshp@cadence.com>, <peter.chen@nxp.com>,
        <pjez@cadence.com>, <kurahul@cadence.com>,
        "Pawel Laszczak" <pawell@cadence.com>
Subject: [RFC PATCH v2 00/15]  Introduced new Cadence USBSS DRD Driver
Date:   Sun, 18 Nov 2018 10:08:56 +0000
Message-ID: <1542535751-16079-1-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(346002)(136003)(2980300002)(199004)(189003)(36092001)(6916009)(16586007)(42186006)(316002)(54906003)(356004)(6666004)(50466002)(36756003)(4326008)(86362001)(4720700003)(478600001)(87636003)(26005)(26826003)(14444005)(107886003)(51416003)(5660300001)(426003)(126002)(476003)(2616005)(336012)(50226002)(486006)(8676002)(217873002)(186003)(246002)(2351001)(7636002)(8936002)(47776003)(305945005)(2906002)(48376002)(105596002)(106466001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB5181;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT018;1:YTl30p8dQ4xHMz+S96/vJq3d6H/h+dk/PPlUnpekhzNgLnGxNEfNMJiscPmDHEuyZHC9+Z7UQCF7tNqS6Hp4whbLUZxSRfV9RoTzLXvMwkfvEsg0Vf8qxwxqN5DGGJtw
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5cb2189f-868d-4c8b-df0c-08d64d3e17ce
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:SN6PR07MB5181;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB5181;3:8RMSHeoGmYnH1E4M6KEg+z/x1/8qzLhyPCFCJHKuLPUbt9xxLmnfmQ76pzbt5wFKO1anEEblwbCan6CczgsliWsv3HnuA93pPKlEVaXpxi1vWHbrTTlEAW4OrYbr5h7RldOGc9xE3V+Xp/pDfqjp7g8vR1PUEDtRU/y2vmYyxgIs2DA0P/9jAknXnw/e38DTTh3p17omi0SwI5zsRxGmMtyKepEhgOienFux7mbCezjqYwviZ3eyXE+uBL1df7Ntrth9chm7NPHizGJi6xs8Ow+8UglUfG1lf2TGl57NQIrkJrhYJ5OSUT5mBHJvmEt3Qzs6dlFK0xyfHkWIzGFL1oxX9RDaqevNcpSMSY2UtQM=;25:mD6+8Utq+GCXm8I4ju6B4qE/h5e22FQf5iJQzqa+5a4itAHUIXy6TnSpdIzQSD6ln5IHx/swjnFXhnIKScTFP3Hprz+ctZakPRTOklQssrW4IpHhvRXmQc58Bth0b2be5swxmGZZpjKk8k2O//XVtcLZd/sr72KczqVN44F+MbbUj4Ra7VBM7yGJXVoJNyyFQ7BqyFL8dI51KFCb0aR6c/egrT2W55JmqMGSSbs46JyPbuZl6kkmTGjr2hO0Wcq8W/VVU82lxOwU5iI2tlb2w4R9FrEWGYcmKXM9MaNqE3mHhE7R5Objfuoo/uY8B5fRiMoXP1KNub1+ZDOqyti/gw==
X-MS-TrafficTypeDiagnostic: SN6PR07MB5181:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB5181;31:l0bFPvfh2o7+BFsy+lDUs7CPTA02hZc4gKo4rdwemm7gA9vtqXqIcC8CvGK0st9ebUNzM1l7+R6c+wkFPzDJDgv1vuQP276IK1+hD5sbHQCENV2EkKzkje8O7/UnysOs+ECW6dL/iDvbiZ7oD6ufVKCn2nfWk3AuFu3KN0nEcfNm21/y+0OAjonrPRxuStXzT1jW36Ga4XpMwedeauKLNh7KGaxBslbB907igFYTdZc=;20:x7fScjA4Rxd5MU3Pm98rdspetPWawRExgNqBr4CN6lWJxLNqBK43Fl+a955NhAB8NwhIDkce78e3Pp8C5JFMzlNo+b6XjN86J0XFkbAqyqLFKn2O3I5Hq8ITVYbtk90WouNIYx+FueK8ciTqhTUSMY0CfyooAIf3R97qi1b36t+tkOolCJfkLRpCycx6bMu1hsaqqv6S/0b13Xl370CORE7wHu7LZkJFGA9zRPeZoOByMZpMoYI2nInXXhD38/YmnTvBn5Z2d1dxpnDvWtSdw02TAyf1yKBnVrwjuoJ+TKyvULNMuwm93ElnT+imSohM0gOiv3sA7E9wXb+c0V5uGD94JUfP4nWKEX96A78Yi/FIYUyGR2MWERwbUxCnf7IFAJ3uTmb1prwkJt8FMFfE7QwitksENlbUdyINoqhk0roMFk9c/u3c1H3zrfQBmsJHH36cjA5xuSubrZoNrUfG76oMvZ8kTLoCoXz7X2ihPYDjY7bO6YsXott49FX/ALKt
X-Microsoft-Antispam-PRVS: <SN6PR07MB5181B35E8F79493A487D7F98DDDF0@SN6PR07MB5181.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93003095)(3231415)(944501410)(52105112)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:SN6PR07MB5181;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB5181;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB5181;4:WHJfQK9uOU2/fGGYja3Uyula2unllMU9seC8vHezPDt6x37SfkxeUsT3bbcn/kMmmNa7teSLVcJ8BgtrHWePau/UkvNq0POwJO01zAhKNjW8VKi6cPwKoX8kH94nv3EDrMG35zFzF9dXMtDmtiAqR22SNtc74i8NTfV/Zo/RALwaCWaNv4IJdtIXmlHPihkMJYRMI1yFqi4J7RzqJFGrOX32AIDvmdZasR5liHP0sk4SqXax/DA9XTEWqeh0Zob/3riKkzWjJFHuXDTLS5eb7wbhWZNsI4tMHN9eo1XO5rrTNFY8JFSAmGzxnDTtBGUO
X-Forefront-PRVS: 0860FE717F
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR07MB5181;23:qFrT9lMLra6I0Lln3r9kLmMB5s268Cnzj9oNkQpPC?=
 =?us-ascii?Q?M24vn23wj7W8nSCp30bOtUNXi7xkgTFY5OTbf+RdSszJpZxQ09qTSK6lQgy4?=
 =?us-ascii?Q?K+RoFQtO8XNysLjOOaqocYLTtlguVEKA4tKgJrZH9ZbdlylHxroTlaAzhyPr?=
 =?us-ascii?Q?ZOFJktQ+oPUZ0uW0Yr5GYQfo5fhHHuucHHc9wYEt4pciFXM0SKXEnMfCnJFw?=
 =?us-ascii?Q?sQdqOG/8RdoaHl1wTW25UjSKaeL3s3qL5FuH7M4p8DyCACNQ/sFKjCzd9NbJ?=
 =?us-ascii?Q?lWGxUIqMtzA1XBkvKyqalwL8ZNz851kNQoOs8TMP/H8JP0NTK+iJFYpO2/7U?=
 =?us-ascii?Q?2EWA+rnvnwNzDLvvlt4Dj9g7OC3OPTK6pP0FyTO2rDk3BjYtl2/qf4Ek4gRb?=
 =?us-ascii?Q?7ZPpjYYQlzZ9rvsCnjb5c8bCr49RRyL9rPpftuzhg1mK/KhTEl9K9PNbezDQ?=
 =?us-ascii?Q?bIloFDHSsqdaWcD2wDAgkkIQeZ+zCjrIksPVhrI1HG9epprilWAZTYSnW6Us?=
 =?us-ascii?Q?sIpXsI8OU4GGeV2WphBB+QSy+m8Q0hq1rOJxng4UCe1xHlIU4lp7Wwe3uuTq?=
 =?us-ascii?Q?dJY4phww2SId/85CdvelkioHk12xXBPo8KIIOdSrxRk+6zdvbsobNLv9uKQp?=
 =?us-ascii?Q?jx43vB0NwSuHWYOyPH0sC6okGSU18ykaKXqXcCSAgOaj5f0T/i4SkPJ7qd8P?=
 =?us-ascii?Q?wb3VNZ7bdqMANFYyL0jY1G98u86idcq3mxKWjod3sRxN9dX4oPfPXMR9eooz?=
 =?us-ascii?Q?OyS0FRSWqRIVeJaZDAj/GlcPk/W4vUiFq5zqG2ODi44YA7uDWiCK82a/hoam?=
 =?us-ascii?Q?PAQg6yW+VkkrqXY6OwRa6hSlTZwX+eWxhis3o26mHELDhEnHQ2xrKv40OzHJ?=
 =?us-ascii?Q?6JJUSSRQefGO1Vb9z1MXDWCjQ2UnXksi1pdDCLb6qdODUg/1NpBjDFk/gxLV?=
 =?us-ascii?Q?rA8J4l5STCC5SzGTeicXV+yLwIDoTT43MqmbtcnRGWMts1d6JuWPDjAjFuXv?=
 =?us-ascii?Q?mkexgaChjjioIp0GW5ADlAFsjtapqkNOkczqlCDuZ3a5tok7FYcnHe0ALRTV?=
 =?us-ascii?Q?nPcXQsWm7ggDrttHaVIjQYGz9DzFbWRaw0i5eKqSgp4eObDoQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: Y4nwxVjviItme8uaBxPsx/gGfdvJMaJ/qM4QEcRGfzBubCTZc+gjLc1todMPoXkeq3mPa+pnJNlyM1129RDpPLDCr7Ku5HyajCdtbOXJ8tQQ9mqtiQKsqsDF2cRoK3EjqpP0bBrTdiZx2oPWbRn4YQ6/NY1kUjV7VzXTcps2OFI/4uvw8Wa1LoL2Zo1e4UuN6NGzrTJxg8j3AEJ8GRc2oDwqQ6X2UYtw8wQflPxBnSdN/WfxuT8e8NMWJX2GVx5g5z0AUTOUGizFNiL5ZrKpHSJbTkFhpSVkfN5ZZ0uIv4mZej7GW4DX8TnQwMzBvVQuw+Q9Lc4lecweesJ955aF2SLFks9dy26qsFCg8LQeoIA=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB5181;6:AzsGXmaedP+8Ol+KhYl42PtHcbUcNL7leDApn+kE+EPkxrFscBL4xW9o4jY+DjzeyWnUUi1KT+0XLuG5Mvt/h6i90oVtEB6JriQxCZkel6vA6ASamIJdl4ETGuHVq0uwSr2ccnC02vW+bWPV1S1vMzvy93MjTgIcVJNVt6MeTZ28PFF/8QYCpoaYMpiwFYiq9rDr3AHX7Gx5zUQ97EihCVsprDM8bLE06DiR3+AoO2l+MdCVffX7DpTuVKzO9PGYFh+S2vsThj2l2lpnPxcGFfOWGzh85TDJzjoo2V3lvVCR+uGJwiwCE18G4L9Id6mHlsJLXtli+QILIVc05KXllwlU7rzbPFUAWkG/6K1RRJWpc+lASyrON7EQR0iHUvTLj/bb3hhvjuNn9gSpUK6gZscQgxiKlJ1ATJqQD7OoBrSKZi2Ggv5R7slq/vZ3x7osO36yM1GQU8J0OmC2xU5gvg==;5:OmEZRXgOyxJ7KyKZnwq2acvePNmcqW03OUFJkZ2mI5LXNn1iYWJn6JGklPLhINcb/0mS1FdqWoRYZh5iALv5YKS8E76l93H0j5WdM+JwtDwKi46+Mm2jebKZ9UztK0tTnYBMq1YEIgVim9vnWDhaEV1K1RP1jtgkA3gaECRowiA=;7:duepZtWNUBVUqIF0DwjgiwXbIhHUmBFVk0izdkKC1h9ot9oHVVTwovIN0z29nDVU4Ib5XQOdUSFcAJeWjbI5L0hTljlMWaVdnExyxMaEtfECXjPSCvzzWMJ9TYsNfuIuw0IUofSsyCDhvQtYMwtkRQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB5181;20:PdClikwsUj1ZaaMp4UtY6jMyfK475MCL12RLgkPQBw366WBQIUKBEM/JRitg5wZ2UJcn/HYhcBS6b562FEwGAmZ9MbvMwWgceV8PAhwu7sxcscbVH3WouyFTCwhXF6Sbf137wOsO8YykskRqu5zTpVVD1rjTTtMDvKa/pJwmBfH0JnnaGpK9B+YIeEk4kdhx5PqqaflQx9B72nwW6XU6UZ2mfccqPInA4rzQYOozBnF1A8W6sqzAl+rg4F0oMyCh
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2018 10:10:39.6779
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb2189f-868d-4c8b-df0c-08d64d3e17ce
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB5181
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-18_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811180096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set introduce new Cadence USBSS DRD driver
to linux kernel.

The Cadence USBSS DRD Driver s a highly
configurable IP Core which can be
instantiated as Dual-Role Device (DRD),
Peripheral Only and Host Only (XHCI)
configurations.

The current driver has been validated with
FPGA burned. We have support for PCIe
bus, which is used on FPGA prototyping.

The host site of USBSS controller is compliance
with XHCI specification, so it works with
standard XHCI linux driver.

Changes since v1:
 - Reorganize patch 3, 5, 6 as suggested by Roger Quadros.
 - Remove inline in debug.c file according with Joe Perches suggestion.
 - Fix condition with no effect in drd.c file.
 - Remove compiler warning generated by sh4-linux-gnu-gcc.
 - Fix bug with xhci_suspend/resume undefined, that appeared for PM disabled.
 - Add CONFIG_OF support in core.c file and dt-binding documentation.
 - Add template function related to CONFIG_PM configuration option.
 - Fix bug: CONFIG_USB_CDNS3_DEVICE instead of CONFIG_USB_CDNS3_
 - Correct depend on condition in Kconfig as suggested by Roger Quadros.
 - Remove Config options from cdns3_pci_wrap.c as suggested by Roger Quadros.
 - Replace dev_info with dev_dbg in cdns3_pci_wrap.c file as suggested by Roger.
 - Change cdns3_role to cnds3_get_current_role_driver as suggested by Roger.
 - Addressed other review comments from Roger.
 - Fix issues with ENABLE_U1/U2 Set/Clear_Fature request.
 - Fix issues with Cycle State bit.
 - Some other minor code changes related to readability.

TODO:
 - Test isochronous transfer with some class or tester.
 - Test changing role according to ID pin.
 - Resolve issue related with shared on-chip buffer for OUT direction.
 - Add tracepoint. 
 - Implement suspend/resume functionality.

---

Pawel Laszczak (15):
  usb:cdns3: add pci to platform driver wrapper.
  usb:cdns3: Device side header file.
  dt-bindings: add binding for USBSS-DRD controller.
  usb:cdns3: Driver initialization code.
  usb:cdns3: Added DRD support
  usb:cdns3: Adds Host support
  usb:cdns3: Adds Device mode support - initialization.
  usb:cdns3: Implements device operations part of the API
  usb:cdns3: EpX operations part of the API
  usb:cdns3: Ep0 operations part of the API
  usb:cdns3: Implements ISR functionality.
  usb:cdns3: Adds enumeration related function.
  usb:cdns3: Adds transfer related function.
  usb:cdns3: Adds debugging function.
  usb:cdns3: Feature for changing role

 .../devicetree/bindings/usb/cdns3-usb.txt     |   17 +
 drivers/usb/Kconfig                           |    2 +
 drivers/usb/Makefile                          |    2 +
 drivers/usb/cdns3/Kconfig                     |   44 +
 drivers/usb/cdns3/Makefile                    |    7 +
 drivers/usb/cdns3/cdns3-pci-wrap.c            |  157 ++
 drivers/usb/cdns3/core.c                      |  434 +++++
 drivers/usb/cdns3/core.h                      |  100 +
 drivers/usb/cdns3/debug.c                     |  128 ++
 drivers/usb/cdns3/debugfs.c                   |   93 +
 drivers/usb/cdns3/drd.c                       |  229 +++
 drivers/usb/cdns3/drd.h                       |  125 ++
 drivers/usb/cdns3/ep0.c                       |  859 +++++++++
 drivers/usb/cdns3/gadget-export.h             |   27 +
 drivers/usb/cdns3/gadget.c                    | 1665 +++++++++++++++++
 drivers/usb/cdns3/gadget.h                    | 1104 +++++++++++
 drivers/usb/cdns3/host-export.h               |   30 +
 drivers/usb/cdns3/host.c                      |  256 +++
 18 files changed, 5279 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/cdns3-usb.txt
 create mode 100644 drivers/usb/cdns3/Kconfig
 create mode 100644 drivers/usb/cdns3/Makefile
 create mode 100644 drivers/usb/cdns3/cdns3-pci-wrap.c
 create mode 100644 drivers/usb/cdns3/core.c
 create mode 100644 drivers/usb/cdns3/core.h
 create mode 100644 drivers/usb/cdns3/debug.c
 create mode 100644 drivers/usb/cdns3/debugfs.c
 create mode 100644 drivers/usb/cdns3/drd.c
 create mode 100644 drivers/usb/cdns3/drd.h
 create mode 100644 drivers/usb/cdns3/ep0.c
 create mode 100644 drivers/usb/cdns3/gadget-export.h
 create mode 100644 drivers/usb/cdns3/gadget.c
 create mode 100644 drivers/usb/cdns3/gadget.h
 create mode 100644 drivers/usb/cdns3/host-export.h
 create mode 100644 drivers/usb/cdns3/host.c

-- 
2.17.1

