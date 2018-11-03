Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA55C6786F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 18:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 535EB20868
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 18:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="qxPB1zTA";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Df9n1xXc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 535EB20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbeKDDUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 23:20:03 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:44776 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727497AbeKDDUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 23:20:02 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wA3I44pH028046;
        Sat, 3 Nov 2018 11:07:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=/Nrs+PiNipffx/rhwac/a9+w0XkLZmYJGgL4+aTkcXE=;
 b=qxPB1zTAshNiJ//cksLpw3KaUPC1T3+V45EhsG50SOIAJ/9avrcJd3K4K2KKfvVJkPeI
 2VZb8yNz6aLi2otPOnxY038glVd8tTeVo7TMR/yWNw4utzvU8vAMmzkaJQd+4mfcTpU4
 v2hLHVNTcbLCQDuVkWpgSgpO6FHOe4BqrXB+DxpzvzfWODJh+Gsj1hd/seLx9dgnF76Y
 fmNIXsbZvibKvUDkPcJnczuuk1bI103ZF3XxtSMrm1QWMVQURWKMC6/OQIrNLe2EXPj9
 wLGI+3AzuIrCqgzqhg36yEvnPOJNtXXgKopuqTv+Bycl0C6+PYljCySGoVrKpRahdnAa Mw== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp0083.outbound.protection.outlook.com [207.46.163.83])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2nh9ed9ewe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sat, 03 Nov 2018 11:07:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Nrs+PiNipffx/rhwac/a9+w0XkLZmYJGgL4+aTkcXE=;
 b=Df9n1xXcnM0gXd0BeT3SyrXnpWoCrVcSMnL2wuNSj0Or587E+10SxxBSZhVGwuGjs6l4SukdrkUy87G1SNNRlukKObDk9wyYj+utEi9AakKzQL9t/Ah4Kvky0LXG5Eyg5jKbP5tdN44Q97RlzFYAPBzA0oRXTHqqzuoNZUWa99g=
Received: from DM5PR07CA0078.namprd07.prod.outlook.com (2603:10b6:4:ad::43) by
 DM5PR07MB4101.namprd07.prod.outlook.com (2603:10b6:4:b3::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Sat, 3 Nov 2018 18:07:53 +0000
Received: from DM3NAM05FT038.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::208) by DM5PR07CA0078.outlook.office365.com
 (2603:10b6:4:ad::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1294.22 via Frontend
 Transport; Sat, 3 Nov 2018 18:07:53 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 DM3NAM05FT038.mail.protection.outlook.com (10.152.98.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1318.5 via Frontend Transport; Sat, 3 Nov 2018 18:07:53 +0000
Received: from mailrm1.global.cadence.com (mailrm1.cadence.com [10.209.213.2])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id wA3I7ppO028834
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Sat, 3 Nov 2018 11:07:52 -0700
X-CrossPremisesHeadersFilteredBySendConnector: mailrm1.global.cadence.com
Received: from mailrm1.global.cadence.com (10.209.213.2) by
 mailrm1.global.cadence.com (10.209.213.2) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sat, 3 Nov 2018 13:52:55 -0400
Received: from rmmaillnx1.cadence.com (10.209.208.46) by
 mailrm1.global.cadence.com (10.209.213.2) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Sat, 3 Nov 2018 13:52:55 -0400
Received: from mailrm1.global.cadence.com (mailrm1.cadence.com [10.209.213.2])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id wA3HqmJb000616
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Sat, 3 Nov 2018 13:52:49 -0400
X-CrossPremisesHeadersFilteredBySendConnector: mailrm1.global.cadence.com
Received: from mailrm1.global.cadence.com (10.209.213.2) by
 mailrm1.global.cadence.com (10.209.213.2) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sat, 3 Nov 2018 13:52:19 -0400
Received: from rmmaillnx1.cadence.com (10.209.208.46) by
 mailrm1.global.cadence.com (10.209.213.2) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Sat, 3 Nov 2018 13:52:19 -0400
Received: from mailrm1.global.cadence.com (mailrm1.cadence.com [10.209.213.2])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id wA3HqD5R000571
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Sat, 3 Nov 2018 13:52:14 -0400
X-CrossPremisesHeadersFilteredBySendConnector: mailrm1.global.cadence.com
Received: from mailrm1.global.cadence.com (10.209.213.2) by
 mailrm1.global.cadence.com (10.209.213.2) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sat, 3 Nov 2018 13:52:17 -0400
Received: from rmmaillnx1.cadence.com (10.209.208.46) by
 mailrm1.global.cadence.com (10.209.213.2) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Sat, 3 Nov 2018 13:52:17 -0400
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id wA3Hq9ww000566
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Sat, 3 Nov 2018 13:52:11 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sat, 3 Nov 2018 18:52:13 +0100
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Sat, 3 Nov 2018 18:52:13 +0100
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id wA3Hq8qp006276;
        Sat, 3 Nov 2018 17:52:08 GMT
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id wA3Hq7hS006219;
        Sat, 3 Nov 2018 17:52:07 GMT
From:   Pawel Laszczak <pawell@cadence.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <rogerq@ti.com>,
        <linux-kernel@vger.kernel.org>, <adouglas@cadence.com>,
        <jbergsagel@ti.com>, <peter.chen@nxp.com>, <pjez@cadence.com>,
        <kurahul@cadence.com>, <pawell@cadence.com>
Subject: [RFC PATCH v1 00/14] Introduced new Cadence USBSS DRD Driver
Date:   Sat, 3 Nov 2018 17:51:13 +0000
Message-ID: <1541267487-3664-1-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-OrganizationHeadersPreserved: mailrm1.global.cadence.com
X-OrganizationHeadersPreserved: mailrm1.global.cadence.com
X-OrganizationHeadersPreserved: mailrm1.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(346002)(376002)(2980300002)(36092001)(189003)(199004)(2906002)(4326008)(6666004)(14444005)(356004)(106466001)(36756003)(8676002)(50226002)(105596002)(2616005)(8936002)(16586007)(2351001)(47776003)(476003)(316002)(126002)(426003)(305945005)(42186006)(26005)(7636002)(5660300001)(51416003)(54906003)(186003)(4720700003)(6916009)(107886003)(48376002)(50466002)(336012)(478600001)(87636003)(486006)(246002)(86362001)(217873002)(26826003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB4101;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT038;1:laSCRpt+22gbbhxNycaUtClZwJjhGfuQxdkuSi6a2apRTFDzQiZ1fE7of56FRqnne61amDCBx2XrRDQ4YNyk3xW/ftujzrjqoN1idiaF3QHJq0e84gtqjUIy+UZ2bEZs
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d03319c2-b962-4024-b627-08d641b74683
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:DM5PR07MB4101;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB4101;3:bEriC4tbFj79gHV3VOcKnWVrD+9MDhAVw9jNR7iT14nk5VbVPzVChMXPXRPmsnl0vg8+wsMj1bqqPO/70Pa86TgwJXEdetcfojaZ7RE3jl/1I96OEmvXURW6+cj9wnGBNSf2q8qd5ueRl8pjyuz1HtlrJRphM1oIxVyARc5dOwXmEr6PQGqe2ecxS3YxyX0zLa27l6Tsq6Ya0ROkbUlxWbbgfWSsN4p/5CHXZlCQpdvurL90f1mMvRvysVdaje+XBLrt4NF8LpRXn6nEewEB2mbU+o/gHyJ9tvVZRomrbh1YvgMssMLNW998NjNUNDI2CK9f9Ue8QWOkTwXqE5QG7jsW+YckAi2GTgygDq1rUIM=;25:rrp8nenAPz4sz2mUcvuOKR5wxs65hM06Fp4L8uv/DeFaMqJtiKLUdZUZXKebMpvjHS3+ozzz8L7Dzk5GIKnOdik1blMZmAxkA6VRO+IDRG+kkBM9MQn+ehdeUt9SFx8wcckYEyRsMVLhSAQFU43Y3yjzj4PhtThG3cKN8lZE36mSmGKPQWuFjVE7aBmLbwj7w7PdcuRCkIG/2weVa3aMiMdmTRTKJnQi2OhiHtTUUD1z8wi6dDOZ6nwkj94T2Pt3f83Fp5v9gw1epgL25wS5+lnqd70NOs9xXkcQHtWlDU2LGPSJTNnyrGzocn2YPUIWpXqWKC5HELzehV+a9n7AoQ==
X-MS-TrafficTypeDiagnostic: DM5PR07MB4101:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB4101;31:laKplAsZWGhEcesilIFptehVwB7EKrDj5VbvjYd/muxp2IZgliFXTh6OR9JjPr8hR9mkaVe2Y3mNcbccT3rU98qMs9Km7ybZtCt0nF+qyho0zQmup6m4MwGhjGcVgOa+0vSOG9hTqX2Wg6iit25kjBfxADqBVILeRxmKrYTy2qu5ioE0t6uH55IPYMuLD+n82v74+UJNvoFbFA0iVtPm0tPnD8VlKqcI8Mjz9Xvu15I=;20:Os3MfsXpfKz/pJqGCOH9QOsbkmV/e/Aq866YLKRdzGnVu8y1UHHVOiJN4ExmQm/vdrc5KNWItE6iH52S5LZTxjZKXATfj3M/tCrGns/dYTzQhyIwVcl2lc3ORUjJnjhigz5tVl/qPzpqYymxd16idiScknkOzDe8mTCil9np2dDVz/cHOOOMSlqo5CKZXSZP/AGfKKfUosazOyY1+h0lABn558hSNdoR1VlleGTwoEVV74Rr1NI5wSYeID4jp9sqlkqBT2G9EdAPAktsmb1kwToKtUtJito9hinjYKPXPwcmyMEXBuT35QDhu/4fXdCGE63RpgVVNKvfH81V17BiMDNnM0GJh26USKdsv9uFlOSUHRvvS1/qVAV5Y31kgCuYLH/0PJUbM0jz1G6cCnDvkXn3Vz6dfBR/ibnUu1u983cAPtQX3snV7pUI4HV0DRrrohhBOSBl33LhbRauBXeSWPSSN7rw1IJiiCvY+gSJIk4eS0O8jY5vtVn3FIiV4edz
X-Microsoft-Antispam-PRVS: <DM5PR07MB41015EB29E8949D7BE1BB3E4DDC80@DM5PR07MB4101.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(93006095)(93003095)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DM5PR07MB4101;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB4101;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB4101;4:QdirpuNqjYWC3GBdQWTbvpw6KzdfGn7w4rlExvKLgbX2QLXRsPn3uf8JKCh7exDmETr1IKDO1RoBwuYQEFjmc1uJYLG7ov1BOTN2YilkJBYUqbvxjC9XA61CGEryZ3eLY2T+bgxJ/BqWgG2BE4bEf7APeWJH4mmNqKnMwqnIS8vs5NgoPjqZqwM8ZfMcZXnjEeDjpGfQunr2+xrjMzJDqswgQQko5v69LIEGLKX/+mCwI6tNjMcoTJQAxoVtArn+xQYV+bC8RHOUiy9A+3fBGg==
X-Forefront-PRVS: 08457955C4
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB4101;23:FOpYSl4rkhRayJ17ybsuZKN1DhWjKKjRQSfTnZ5rZ?=
 =?us-ascii?Q?baBDKAaKk+9g5H7m9UdbSUkP2j3pVmN68ymc5/X960FgwcBx5NQKV+m1if2N?=
 =?us-ascii?Q?IKzhr/9CwO0tJS4j7keRYeZhtZAQ8kU+gnaiFD6eYHClM8zCA3tNIp19zLCu?=
 =?us-ascii?Q?qt4LmSXHPTxP0nMAktx4cdOPodyqAeK19b393lGj+WI6k43cE4Jb/Pt23PEW?=
 =?us-ascii?Q?utALcgO55R0WuULwjI50dU4Rs5Q/rydDKoetiHm8j5TksKq4d4d6bt2oLwoE?=
 =?us-ascii?Q?3GHzwj3NKCE8NfvC/AyWLayQLAEXvUALeyYN9JS/gZKLTJYxqecpZHfMKkS9?=
 =?us-ascii?Q?9tHLJ0NUwk+SZsbeP/AUoeNX512HJhU+/lIu8HvPdlJNlCYxXTpXgyQLxRjd?=
 =?us-ascii?Q?LDjj3savcNlXNHo28LYPSiGqT/D96d9ZLN3cPwN0HSq3lnxYPTK+XXypQQdo?=
 =?us-ascii?Q?Tju5Omzp7ri9yZkrNGbhzAC145rLdQa6B7Wjn+/oKaRKUoN6ZIUY72eYYPHy?=
 =?us-ascii?Q?+9GAcs3rY5DAUm7Ssyk9a0S840gTKggQl8+LnRQwbCJEUoIlIP5VvvLpEDv7?=
 =?us-ascii?Q?tMSmmRUhpQAS3NUI2ID1AOtq5rqXOaRQKnYb83kyB5y+JsKWfPUAoLGK16wo?=
 =?us-ascii?Q?9KYTt3EYOUC+gRWeAFkZvG9VPhYhhim+CDsxMU+zcRU8KWazDUim8e1q5HqZ?=
 =?us-ascii?Q?Y5WuvCI9vfr1zZTG1F1q5axU+F7EKtGVJFbKmaWZxzunzehpw1tZ3YWezsg8?=
 =?us-ascii?Q?nJSKfiTkaJQKNmskmZdgAZIUzyIEUY0FqYkhP7RL56VTu/v/HNb0plJSkPUR?=
 =?us-ascii?Q?bJNDJBBaPSju5Yi+MuwZZou6xLIE1n6OCqQ1rIJjbYVAek2RVmAgFliTIvZo?=
 =?us-ascii?Q?gDKuyrb8U4rYbyKlQiQiTKdcXmCzjyHFy+hxxhPWPscA0AoSbeXyg5hyoUuc?=
 =?us-ascii?Q?XcCvb4QY6dei6S7Dnd9OU/OCHdt/TnsKX1eoIVdAXaAEfzw8pDNBpDTZnTCH?=
 =?us-ascii?Q?XeaV9d5vlJbC0ZkFgj15CI6OgjkgHUwJOUp+X0YuFpMtRU6MAt6Y9aOeyusg?=
 =?us-ascii?Q?5+jLTbTQBy6zG3ij9qZCabNJ4+V0gmxTbx9vWxqOR4a4DPdYw=3D=3D?=
X-Microsoft-Antispam-Message-Info: Ps4owQEik1ELR4XRO0DwAiQSZaw8GfEaF4pnCXHhyGbfb3T6VK7ruYORC3xsj9OAdY5l6J19s40LQVI4CyiyQYodIh6u7PMUYNsmWY6ssW4cntI4Q01gpFhrPpg4Ds9qo6m9Fm/X19HXWHJ5fdomVLqFEEEbSiDBy1sBNVCVIW9BwrXrN+FK3eVBSVCsm0Fori3GAJntW+zcC8eGrcZ+u7WrKnbz9nskVWEykqpkcOUxmdVUPBkRR6TrWvt0d8UulHh/JUYaxNx+XdDew6vdcydlOrlajpLrDLtW/adB5PcQsBlumJHPv8gWXaopEqqMNIGIeEXf1CN7MzhZ1z45QPF+B00SaEOIiE0KeCJCvVI=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB4101;6:7sZ8jaslrLtZdhnZfkQrbfBLaGwbIJhVSdU4M/DtoVSpTujUjDK47bkzwo8Zpzjhx7RKfOYc33Z7fJqIVu4EFQ3aN0BjzP1yqmHnBe7Ik18e9FjUS+u/vdY/fAuktrZZM8LT27QBYAgKWha4dXnpXTthVS+tO2SiGBYJz+45yocBWa5+3hleQRMhUGLYquUiJPX8OvGZddOZ46cCmIZy+KzPntsW9u5bPa4o34fVcvR5T1XL61Trxg8g9/M3KRi6ZyrtnPK/gJIaiFe9kHcZk0z/YG+vvGNeRSPuK9sx3T91cLch1ZZhJE0gugInAmJKeG+rcouZLtHXH/8OPGQ/IUSeidLJE0JN9AqEcf7qvJAx8apqKAnWL2+3elEKoE1UyFhgabA+SxX9NUITaD2jYs8oripk8uXesxfhsZfFi34Bv61RhegLIUnkNmZYWSFPiT1CdQ0d1wi+h7QSz/3OKw==;5:jerP6Hoy4034vCB0sSdwMHTePSmBpmIQ5sOKrldQyyuadvYNdE/btlhofIxxItD0Guxd2xtifJCue41VasZl5Ja/6vPSGtGY3Yd07m2j0HHWiKEwfb+4d9fGCkkqKDdekA4s4IL6wn9LovGl7ejE1DLRunIArenmXKhkP2dp8KE=;7:WJQR4/RfQm+ramUR5NsHOmWIdwq5nWti79dkYuAtpmITuET91onmhERkLM41Na6JMPfIbAYsxsvCHXRe0sWLnVHHAAAH4HvrQxKB5ekb+JaslpJqGqO9W7EWQWMjH5aRb3lpI42ha5hz1GQrLIrKsg==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB4101;20:ewDhfLlBD81y2erKxKTjg6VyZKNkSLRw5sH9Mih+OoRIUuhkKn8edVrcRgRwTqsy7Eqe65pq8BDEUW/C0YQK4HGuAUqw/4o+3bfcpr67539Wy5SzMr3dObZASdS2776pEIE2ySsBIjDrrSGsCAkewOGQGWHnDZX8Rkw5AhsCgSA3vKbJJbDOFFOgKHwTqaYp/y6zMzgSGLNg3K4Sj26U6Nm78lnP8hPhmT9EU4baclZQ9RMtQSL1dnINeByb+l5O
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2018 18:07:53.1892
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d03319c2-b962-4024-b627-08d641b74683
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
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
 priorityscore=1501 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=391 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811030171
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

---

Pawel Laszczak (14):
  usb:cdns3: add pci to platform driver wrapper.
  usb:cdns3: Device side header file.
  usb:cdns3: Driver initialization code.
  usb:cdns3: Added DRD support
  usb:cdns3: Added Wrapper to XCHI driver
  usb:cdns3: Initialization code for Device side
  usb:cdns3: Implements device operations part of the API
  usb:cdns3: EpX operations part of the API
  usb:cdns3: Ep0 operations part of the API
  usb:cdns3: Implements ISR functionality.
  usb:cdns3: Adds enumeration related function.
  usb:cdns3: Adds transfer related function.
  usb:cdns3: Adds debugging function.
  usb:cdns3: Feature for changing role

 drivers/usb/Kconfig                |    2 +
 drivers/usb/Makefile               |    2 +
 drivers/usb/cdns3/Kconfig          |   44 +
 drivers/usb/cdns3/Makefile         |    7 +
 drivers/usb/cdns3/cdns3-pci-wrap.c |  162 +++
 drivers/usb/cdns3/core.c           |  381 +++++++
 drivers/usb/cdns3/core.h           |   88 ++
 drivers/usb/cdns3/debug.c          |  128 +++
 drivers/usb/cdns3/debugfs.c        |   94 ++
 drivers/usb/cdns3/drd.c            |  219 ++++
 drivers/usb/cdns3/drd.h            |  125 +++
 drivers/usb/cdns3/ep0.c            |  855 ++++++++++++++
 drivers/usb/cdns3/gadget-export.h  |   27 +
 drivers/usb/cdns3/gadget.c         | 1649 ++++++++++++++++++++++++++++
 drivers/usb/cdns3/gadget.h         | 1100 +++++++++++++++++++
 drivers/usb/cdns3/host-export.h    |   30 +
 drivers/usb/cdns3/host.c           |  252 +++++
 17 files changed, 5165 insertions(+)
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

