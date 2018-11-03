Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7789AC6786F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEADB20833
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="p6F4C4Pa";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="KwyEB8pC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEADB20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbeKDDFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 23:05:06 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:40242 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728928AbeKDDFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 23:05:05 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wA3HmkV6013631;
        Sat, 3 Nov 2018 10:52:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=xrxtY/okd7RsL6Q2VRS8WNLNNjdLJ7O/rb7dbpsrmN8=;
 b=p6F4C4PaOlI5uywjjxxa6k5tyHxC4MdYAKsU6+5ioGq89nFK6J01ulXN9/r2xBsBL2lD
 eFBdj1AXh4XPsyQPorBezoBwq69+fJCNaDQ+nXfTLUo2HoqO/Tvtx6ce8xQv7GZbTckR
 DYg91FUzEmtUoAzcPRVNSzPFOSrvjs4W1bSK0+nAhsuah1fw7PDtgPii0Gom9MQHsms6
 9ez/xlZ6pJnScXLJTphx4ts1t1g9NyEr3SQ1JanpFWTK9CBC/r/HUk71q6kV8CJAt0ia
 S9yUQy47ORK0DSz9T2Az5tBBwsQDIfiYMwwQNO6OE5o19CXjh1skvS47oCWcmkRtfWg8 JQ== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp0115.outbound.protection.outlook.com [207.46.163.115])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2nh9ed9dns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sat, 03 Nov 2018 10:52:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrxtY/okd7RsL6Q2VRS8WNLNNjdLJ7O/rb7dbpsrmN8=;
 b=KwyEB8pCmJDL60OvFRwfk0NnMQI71EKpNcWwcsamzplk/nUmlwkuovs2nKXLUNc1TYOnoRL4Krk3ybS5tqY+yr7yekfVdQ1nQXWPCBr+zTH5NIJWTw8bc7U4xsykZRW8uP0u1sxhKChIWvXud4pK5sTRDbdmaAKIFTB/RWU2HEQ=
Received: from DM5PR07CA0035.namprd07.prod.outlook.com (2603:10b6:3:16::21) by
 CY1PR0701MB1867.namprd07.prod.outlook.com (2a01:111:e400:51df::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.26; Sat, 3 Nov
 2018 17:52:56 +0000
Received: from CO1NAM05FT058.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::205) by DM5PR07CA0035.outlook.office365.com
 (2603:10b6:3:16::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.26 via Frontend
 Transport; Sat, 3 Nov 2018 17:52:55 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 CO1NAM05FT058.mail.protection.outlook.com (10.152.96.176) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.3 via Frontend Transport; Sat, 3 Nov 2018 17:52:55 +0000
Received: from mailrm1.global.cadence.com (mailrm1.cadence.com [10.209.213.2])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id wA3Hqrcm009486
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Sat, 3 Nov 2018 10:52:54 -0700
X-CrossPremisesHeadersFilteredBySendConnector: mailrm1.global.cadence.com
Received: from mailrm1.global.cadence.com (10.209.213.2) by
 mailrm1.global.cadence.com (10.209.213.2) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sat, 3 Nov 2018 13:52:26 -0400
Received: from rmmaillnx1.cadence.com (10.209.208.46) by
 mailrm1.global.cadence.com (10.209.213.2) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Sat, 3 Nov 2018 13:52:26 -0400
Received: from mailrm1.global.cadence.com (mailrm1.cadence.com [10.209.213.2])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id wA3HqJjx000588
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Sat, 3 Nov 2018 13:52:20 -0400
X-CrossPremisesHeadersFilteredBySendConnector: mailrm1.global.cadence.com
Received: from mailrm1.global.cadence.com (10.209.213.2) by
 mailrm1.global.cadence.com (10.209.213.2) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sat, 3 Nov 2018 13:52:24 -0400
Received: from rmmaillnx1.cadence.com (10.209.208.46) by
 mailrm1.global.cadence.com (10.209.213.2) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Sat, 3 Nov 2018 13:52:24 -0400
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id wA3Hq9x4000566
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Sat, 3 Nov 2018 13:52:18 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sat, 3 Nov 2018 18:52:16 +0100
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Sat, 3 Nov 2018 18:52:15 +0100
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id wA3HqAps006404;
        Sat, 3 Nov 2018 17:52:10 GMT
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id wA3HqAvn006403;
        Sat, 3 Nov 2018 17:52:10 GMT
From:   Pawel Laszczak <pawell@cadence.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <rogerq@ti.com>,
        <linux-kernel@vger.kernel.org>, <adouglas@cadence.com>,
        <jbergsagel@ti.com>, <peter.chen@nxp.com>, <pjez@cadence.com>,
        <kurahul@cadence.com>, <pawell@cadence.com>
Subject: [RFC PATCH v1 06/14] usb:cdns3: Initialization code for Device side
Date:   Sat, 3 Nov 2018 17:51:19 +0000
Message-ID: <1541267487-3664-7-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1541267487-3664-1-git-send-email-pawell@cadence.com>
References: <1541267487-3664-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-OrganizationHeadersPreserved: mailrm1.global.cadence.com
X-OrganizationHeadersPreserved: mailrm1.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(346002)(396003)(2980300002)(36092001)(199004)(189003)(50226002)(19627235002)(217873002)(86362001)(107886003)(14444005)(8676002)(50466002)(48376002)(4744004)(246002)(356004)(305945005)(87636003)(16586007)(42186006)(316002)(54906003)(8936002)(7636002)(51416003)(186003)(26005)(2906002)(486006)(2351001)(5660300001)(426003)(76176011)(478600001)(6916009)(4720700003)(4326008)(36756003)(476003)(26826003)(2616005)(336012)(105596002)(47776003)(106466001)(446003)(126002)(11346002)(309714004);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0701MB1867;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT058;1:0NJYh28wuxKrIg5Lq/OteV96+9HikurOHieunGvF+DCYj4waycGSWucAfp2tGhadWYHmMB2U2zE20h+MAH3wmrnwfrsySOXnsnoo/+wzG7EO6JVZ2zdMLw23yiXY+hro
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e63fe261-a273-40c7-38f0-08d641b52f27
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:CY1PR0701MB1867;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1867;3:1zPb+xVoyCeiRSKK54s6wrADV4Xzc0Xo4kmcKeiIcBcA+ORlDBAITfmnTeAZOqRXl8zDRRrQ+2C57U3x5hGO24HIaDeFVbroArouapBjmTbWoQomWLOlxYnVqKqvjqllJoRModL2DW74D9UveFIHBJY4/ceIW/XJZUgfmqS3HHv/ajMezWWfLbVBgxdypLsWT7cyr820tPwTCdFEBK2waYilFdZlFYDV6yM6vAEZ7APrgjZ1Lt2kDQfn9z6Cd/4DW0qoqLHE2JGp1Qn/X8/R53xWt/RxifaS9pU7v73j6qqLfZwLE84qYehwMmRNWGV+V7tQGazLR74Q75WV3f4PRr1yEfaqaeCGD9TJg154tZw=;25:loHTLN1DaYVNHgxxKnRU58q91v00CZc7LSwtqKhk0hFrI3WSzJAdrO1ejTA69GX3svFo3BQgqNUItnBCTtvzVhi8xPH/87RixRPZY4VUOCSu3sYp4yixqjeS2PI8qz5YWyHU8kyccD40mYrzuMHs0oQ9QwXnVDJNk0N6TKYLyOCfw82DgybF1Vwwq7I6ApvIjzmNvNPEryWL9QtFXvPqUh1XR2u9Jmt4UcXjP6F33jybo8pwCw/lAlCKhEUdBDZBB1jS0a6TuEuDNtf9gYL273kIIlaz2UTYg4Lg7PR1itDhUL+cGH6iZ9aGZUmjXojXFPks0gh6XLoDXBR9RLwtjQ==
X-MS-TrafficTypeDiagnostic: CY1PR0701MB1867:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1867;31:dpasjS7e3elpMGVg/sd1EVW3oSRCi4jeRwn35qmjtkIvk/IDl/0QihhVzR3CBeyeHZgNo4D3rXk3+nqZZDw+YvOzzBJ3iWtT7JRjkTbmrnYu8E4uakYWKkCg/f2U67hLJWXTx0U/FdeOAyzYkIa8+n1iKUDtoD+OPok0bJilx+J8yIA+A8rvH+vVkvJ7khNYFIgxJmfJdKdeqo9ncXPiWxLY4qthg1UnVGVmrqYCcgE=;20:VKkwFwwbsUztGNgXSL8LKlszJxxfh1/nIcVGNKMYl97MJ9MkgsPQLXVGNMfhN5iCozUjN3PRv+6A44szMlJ+CmODRjsWxJkDde6jFlgbYF7u2ksJ7QK80Bo1NKzBVgnbVvWIwLOEniuzf/mRCaDphnuIHMt6wh0BvU+lgp3DnF0Sr+vit+swCqlbmI0U2eq5f3iAONjnDQfn0bHfTCkfAzjXDcEoHEm0oKXk3KLsqFo1GEoIPrsjx4ldKbCf51rUpcp5uuMrduK4POGxJikiDv9A/fAQOAMbCEs4lwlnmcB8zwUU6S+XvEZIJQ+zqgqvebGnF6dknGOwxEHBmjtGpTSunKRPEznD3DqhIRexN1aIZM8DemTzzK66o2l/c1gZyC/rw5PBkYOEGGWnMYDYZ5p4M07o1OYeLY3iDHgXrSWBQQfSPZaqDHtVRbJuJvljHFPXrDNiN33oLWWHYYT7tsutW7r8qFDRE4qcFt0l9gltcwsQc1WSq4+oI520xrpn
X-Microsoft-Antispam-PRVS: <CY1PR0701MB1867F8E77E9460882EAB9B8CDDC80@CY1PR0701MB1867.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110)(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(93006095)(93003095)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:CY1PR0701MB1867;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0701MB1867;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1867;4:d3I0qCsXMSZTVsl8D9Crw7pBo6Q7Da15fGMIgL40tyAsMJMZHbc8vd6+ICffmcUB/mOAO6nIY4SvJsZxxslx10SP+ALyUmhOZCOy/m57UZI5HQj/bkOF/vtRgy/SrnPd8PnEGS2EFOTEfBRTug0yQqOCj87GXWV+sV8wyXTVWiZZFrDfY9GThtMFW+YEEoCm8Lry70OKhJzHE3D4CNGmOc/C+U3m44csQeOZNw14NBZXzqxQDAWAnVqsaHNEk0l/NSjqbnKjatbJ6PEMmRVSZUZx1Yfd7nG0yiqKasvX5KHDD8dW9QhaQU9z+FLfvsuM4nwSP7l44NcpP6pDc7wlEOcjehmbCSsdU4XCgigxfZA=
X-Forefront-PRVS: 08457955C4
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0701MB1867;23:OskEhIF81GfElPTA/nHbqePam/jYA0lWHa4bVyj?=
 =?us-ascii?Q?ZvCkAJP2aRArar9+zshiw208lJuL6Dy2NBaFGpuI+ouA66WTG+6tq5t2+d9v?=
 =?us-ascii?Q?xUFk4JlDRqYTsyuWpMTCCLBIndMqbejnMWnIYjGS+tI7eR8DuSSPNGeU7unl?=
 =?us-ascii?Q?luF2tF1oDazJ8aOeEhLZuWh1ZWuYoCsOxf2qJPMs+yKvNVe+lqHAryNl8/Ru?=
 =?us-ascii?Q?d4Tdfp7n/4o6pnf7lv6r7sMjjxPlaVPWNCpHwOYFDfDXZ6agg29lK125iNH8?=
 =?us-ascii?Q?hwoxKeKXlaZA4ZS/s0pncTUtenOa/j22n3FaOqGWedEzsuhkjupoGcBiqMA8?=
 =?us-ascii?Q?FBZsxnbptNOwngQ88GA5VlOfe570+xvdyJ3H1vN7FMI6dUBf7AURW15Mgzfn?=
 =?us-ascii?Q?dAgnechUvbykl6mxP5pytb26qb+iJs5KXqS8CnzqxcS5PJMSMilVJSynfrT6?=
 =?us-ascii?Q?2EpdSNJUTcDkJj8cQbprNlZ5O4LwX1P3EZ07RX3Rt8mlR3LgoC9FdC+rs3ro?=
 =?us-ascii?Q?N+1syBQBUDM2hg6TNGnOq2iMUhdqvRvu5Q6deYBa2/Oq/cvxQF3SMa9TtYJZ?=
 =?us-ascii?Q?bvgAGWjOQ0R7zqFogbxa3nqX1BZntda/zyy5jCpn9HEn8AycCuwx67vZtBud?=
 =?us-ascii?Q?fVIIGGA2y2x7hLkOm6sw7YJIIVMYV2VnMio4XQo+cbb6jQ7A259TJpcfI7js?=
 =?us-ascii?Q?qYwTOwNsAl+iBgMPQls0nnOUxb3BWckhLcLZvxBpy49BPg2jfY7GJX9zqgvz?=
 =?us-ascii?Q?9p83kGuD5b/JhKU1/dqOk8EJR3goFzgDWa69JB7QFhOTOGzjBs2FXixkevQj?=
 =?us-ascii?Q?JKoSFuXXc5PcFzdaWZTPI1rjOCq8CjXgGXsmydykKP/s0Fh05yWuljlFQsZ8?=
 =?us-ascii?Q?fj4Wh5TcdbLQ1yVWJ9Z7yydVCjmRqYYbcvyrzQri0SCjgqtPguTScK8RDAkl?=
 =?us-ascii?Q?LhuyRkhOpQWSL8TUpTEyuS+PlI407EOHGbrXWyheTzocA8Qf2cu6kOHsO0/0?=
 =?us-ascii?Q?bp2uUqV36LstQ+SYdLi1eYILBaCZNes7iUcOq8bgu4B6EelkxHsxgTikCNXe?=
 =?us-ascii?Q?OVAqZtWlARwtpqTgHgqYnhzl9TAHgApnVSSptlAkpKVI9Pxd5zspDbHJNuch?=
 =?us-ascii?Q?2ThfsIsPgIpPGSULVg4e6n2rCMKid3BKZJTJ0iS42KSRbwxF7PFmHIIpfPSe?=
 =?us-ascii?Q?5yYmwkiPles5zw1HjI42IEUVBu+HlfdjurBO3?=
X-Microsoft-Antispam-Message-Info: /67Qitt8O3LOjCroc5FqlYK+9Ybuv/Noonnn1u71CpCdmaeBhH/+mLLvt784lfvvo1wSjpNQh+H3hb0QbHDpUmiF88Ld1WOw/pxIekAXEvgtKhndR/nuwOV4rCOortyqK5hemlW+zL86nnwxh6K7v+5Ih6xIXH2jYlzuBMXCBm7T2JxXehhw+eiVQlxGt42vMgULQ7VYp26Eg6zlnbMBhD9Kx9/b3CbFCeDbzfLfip4U/DiC3yT3182p9sVjvDLyK1D1GHe2bujhbAmNgdHmx+GPTZHkqlVMJaYfJTpmP+f7/y0Gp31CQYJKhC3vFRztnPs1/FN/jdIO8DMb8TtInyGQMeBngHOUADtSPCpYAqI=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1867;6:arfpwpfZLkzWfwEzP6jrZb5/no29LK/UsS4BH4Ppk1WUy9Y2v2ylaqSn614gmD+ebVsfGow6AnmtjnFh0WFUROEDNIXQfkcyDO3uMO0SaLIQq/4FaapN1WVBzGOUS//zNfZ4nn+VI6LjgKJ5jFw5q0QXT/3oWNo5Q0J714TGq6rDe3TncMR3KbPv0M74DeJVGpiNlbKodYX6/lLkuJ15u/v+325m/U8tR/ikWe3es0ckBD8QcIshgSDEluPXVA71OXyWwtkLuJPNUbaXyZzsSX9PRwzL15i1jf7qucubO6YPHnAOaUMhSC6Bh2maR6kJcJLG9k7TBmrBQKI/kTLicKBpCktQkKYQ6x3Q4yEKqTDgLv4qnvKH3pBVkM0hR88kbL6EZRVLllyO8s+eZngd76Rw/jqx/JqYIKsl7kGp9HcjwmemR4UDH/YK2d3X8yiE3uqCAxk1MBcOtscI+eTH/Q==;5:rc/JrwwsS49TwNe14TxPQERRYOwu9zZuhaqjdLtotHiHSkMQvYMz8PSgyPCLOQ3LZTna3UOPF0MppYvd3fH45/Yf9OnJhO0wl+9/kUgoIhBbPMTaB+WUlT4QFaWiRR1fvkusnTGyfutyU+w/3DJb11iAlt8+a9AI8pk6tciWtnA=;7:KdK3bhiSdNDaZ/SElDqo6/A/oYQe9Jpv/jao9/uKAJM5Vwgxk45cfqK0+SZ19Lg+mKxrK85ZxisSq4VPiegBU9YRZojHCtlvccikqWdgA2TfpQ7VtXm2dgKvBw3vafxD8VdtI2RgaY0mlJXOmcJr0A==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1867;20:SBl0v9q/wJRZbTglIT7DaA0zIr8r60kHa3BepiejLPATMHlNLjiiUCVFBiSB8hPplSTZAYbu3zDGrRZIDA8FS6gZIz6i5vLZpGlZ708mmGXAvqHEJpjo6eKMBXSZ/q8OIBJs+fwM4FRLkHxrHC4bCw1Pzct45Ax1VNzBR05jq8G7Uj1TC+Ni3t3I/D+ksoOI+n5lV6DRV6X1SopfKx4QJiMhxDKeVB7HqfKLfVzC3QwxMZNoD74bMUals0Jotwe9
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2018 17:52:55.3301
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e63fe261-a273-40c7-38f0-08d641b52f27
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0701MB1867
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
 mlxlogscore=883 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811030169
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch implements a set of functions responsible for initialization,
configuration, starting and stopping device mode.
This patch also adds new ep0.c that holds all functions related
to endpoint 0.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/Makefile |   2 +-
 drivers/usb/cdns3/ep0.c    | 105 +++++++++++
 drivers/usb/cdns3/gadget.c | 361 ++++++++++++++++++++++++++++++++++++-
 drivers/usb/cdns3/gadget.h |   4 +
 4 files changed, 468 insertions(+), 4 deletions(-)
 create mode 100644 drivers/usb/cdns3/ep0.c

diff --git a/drivers/usb/cdns3/Makefile b/drivers/usb/cdns3/Makefile
index d4ccfb49d844..f4cfc978626f 100644
--- a/drivers/usb/cdns3/Makefile
+++ b/drivers/usb/cdns3/Makefile
@@ -2,6 +2,6 @@ obj-$(CONFIG_USB_CDNS3)			+= cdns3.o
 obj-$(CONFIG_USB_CDNS3_PCI_WRAP)	+= cdns3-pci.o
 
 cdns3-y					:= core.o drd.o
-cdns3-$(CONFIG_USB_CDNS3_GADGET)	+= gadget.o
+cdns3-$(CONFIG_USB_CDNS3_GADGET)	+= gadget.o ep0.o
 cdns3-$(CONFIG_USB_CDNS3_HOST)		+= host.o
 cdns3-pci-y		 		:= cdns3-pci-wrap.o
diff --git a/drivers/usb/cdns3/ep0.c b/drivers/usb/cdns3/ep0.c
new file mode 100644
index 000000000000..c08d02665f9d
--- /dev/null
+++ b/drivers/usb/cdns3/ep0.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Cadence USBSS DRD Driver - gadget side.
+ *
+ * Copyright (C) 2018 Cadence Design Systems.
+ * Copyright (C) 2017 NXP
+ *
+ * Authors: Pawel Jez <pjez@cadence.com>,
+ *          Pawel Laszczak <pawell@cadence.com>
+ *	    Peter Chen <peter.chen@nxp.com>
+ */
+
+#include "gadget.h"
+
+static struct usb_endpoint_descriptor cdns3_gadget_ep0_desc = {
+	.bLength = USB_DT_ENDPOINT_SIZE,
+	.bDescriptorType = USB_DT_ENDPOINT,
+	.bmAttributes =	USB_ENDPOINT_XFER_CONTROL,
+};
+
+static void cdns3_prepare_setup_packet(struct cdns3_device *priv_dev)
+{
+	//TODO: Implements this function
+}
+
+/**
+ * cdns3_ep0_config - Configures default endpoint
+ * @priv_dev: extended gadget object
+ *
+ * Functions sets parameters: maximal packet size and enables interrupts
+ */
+void cdns3_ep0_config(struct cdns3_device *priv_dev)
+{
+	struct cdns3_usb_regs __iomem *regs;
+	u32 max_packet_size = 64;
+
+	regs = priv_dev->regs;
+
+	if (priv_dev->gadget.speed == USB_SPEED_SUPER)
+		max_packet_size = 512;
+
+	if (priv_dev->ep0_request) {
+		list_del_init(&priv_dev->ep0_request->list);
+		priv_dev->ep0_request = NULL;
+	}
+
+	priv_dev->gadget.ep0->maxpacket = max_packet_size;
+	cdns3_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(max_packet_size);
+
+	/* init ep out */
+	cdns3_select_ep(priv_dev, USB_DIR_OUT);
+
+	writel(EP_CFG_ENABLE | EP_CFG_MAXPKTSIZE(max_packet_size),
+	       &regs->ep_cfg);
+
+	writel(EP_STS_EN_SETUPEN | EP_STS_EN_DESCMISEN | EP_STS_EN_TRBERREN,
+	       &regs->ep_sts_en);
+
+	/* init ep in */
+	cdns3_select_ep(priv_dev, USB_DIR_IN);
+
+	writel(EP_CFG_ENABLE | EP_CFG_MAXPKTSIZE(max_packet_size),
+	       &regs->ep_cfg);
+
+	writel(EP_STS_EN_SETUPEN | EP_STS_EN_TRBERREN, &regs->ep_sts_en);
+
+	cdns3_set_register_bit(&regs->usb_conf, USB_CONF_U1DS | USB_CONF_U2DS);
+	cdns3_prepare_setup_packet(priv_dev);
+}
+
+/**
+ * cdns3_init_ep0 Initializes software endpoint 0 of gadget
+ * @cdns3: extended gadget object
+ *
+ * Returns 0 on success, error code elsewhere
+ */
+int cdns3_init_ep0(struct cdns3_device *priv_dev)
+{
+	struct cdns3_endpoint *ep0;
+
+	ep0 = devm_kzalloc(&priv_dev->dev, sizeof(struct cdns3_endpoint),
+			   GFP_KERNEL);
+
+	if (!ep0)
+		return -ENOMEM;
+
+	ep0->cdns3_dev = priv_dev;
+	sprintf(ep0->name, "ep0");
+
+	/* fill linux fields */
+	//TODO: implements cdns3_gadget_ep0_ops object
+	//ep0->endpoint.ops = &cdns3_gadget_ep0_ops;
+	ep0->endpoint.maxburst = 1;
+	usb_ep_set_maxpacket_limit(&ep0->endpoint, ENDPOINT0_MAX_PACKET_LIMIT);
+	ep0->endpoint.address = 0;
+	ep0->endpoint.caps.type_control = 1;
+	ep0->endpoint.caps.dir_in = 1;
+	ep0->endpoint.caps.dir_out = 1;
+	ep0->endpoint.name = ep0->name;
+	ep0->endpoint.desc = &cdns3_gadget_ep0_desc;
+	priv_dev->gadget.ep0 = &ep0->endpoint;
+	INIT_LIST_HEAD(&ep0->request_list);
+
+	return 0;
+}
diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
index 41ce696719d7..e7975b00b21a 100644
--- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/gadget.c
@@ -10,7 +10,261 @@
  *	    Peter Chen <peter.chen@nxp.com>
  */
 
+#include <linux/dma-mapping.h>
+#include <linux/usb/gadget.h>
+
 #include "core.h"
+#include "gadget-export.h"
+#include "gadget.h"
+
+/**
+ * cdns3_set_register_bit - set bit in given register.
+ * @ptr: address of device controller register to be read and changed
+ * @mask: bits requested to set
+ */
+void cdns3_set_register_bit(void __iomem *ptr, u32 mask)
+{
+	mask = readl(ptr) | mask;
+	writel(mask, ptr);
+}
+
+/**
+ * select_ep - selects endpoint
+ * @priv_dev:  extended gadget object
+ * @ep: endpoint address
+ */
+void cdns3_select_ep(struct cdns3_device *priv_dev, u32 ep)
+{
+	if (priv_dev->selected_ep == ep)
+		return;
+
+	dev_dbg(&priv_dev->dev, "Ep sel: 0x%02x\n", ep);
+	priv_dev->selected_ep = ep;
+	writel(ep, &priv_dev->regs->ep_sel);
+	/* memory barrier for selecting endpoint. */
+	wmb();
+}
+
+/**
+ * cdns3_irq_handler - irq line interrupt handler
+ * @cdns: cdns3 instance
+ *
+ * Returns IRQ_HANDLED when interrupt raised by USBSS_DEV,
+ * IRQ_NONE when interrupt raised by other device connected
+ * to the irq line
+ */
+static irqreturn_t cdns3_irq_handler_thread(struct cdns3 *cdns)
+{
+	irqreturn_t ret = IRQ_NONE;
+	//TODO: implements this function
+	return ret;
+}
+
+static void cdns3_gadget_config(struct cdns3_device *priv_dev)
+{
+	struct cdns3_usb_regs __iomem *regs = priv_dev->regs;
+
+	cdns3_ep0_config(priv_dev);
+
+	/* enable interrupts for endpoint 0 (in and out) */
+	writel(EP_IEN_EP_OUT0 | EP_IEN_EP_IN0, &regs->ep_ien);
+
+	/* enable generic interrupt*/
+	writel(USB_IEN_INIT, &regs->usb_ien);
+	writel(USB_CONF_CLK2OFFDS | USB_CONF_L1DS, &regs->usb_conf);
+	writel(USB_CONF_U1DS | USB_CONF_U2DS, &regs->usb_conf);
+	writel(USB_CONF_DMULT, &regs->usb_conf);
+	writel(USB_CONF_DEVEN, &regs->usb_conf);
+}
+
+/**
+ * cdns3_init_ep Initializes software endpoints of gadget
+ * @cdns3: extended gadget object
+ *
+ * Returns 0 on success, error code elsewhere
+ */
+static int cdns3_init_ep(struct cdns3_device *priv_dev)
+{
+	u32 ep_enabled_reg, iso_ep_reg;
+	struct cdns3_endpoint *priv_ep;
+	int found_endpoints = 0;
+	int ep_dir, ep_number;
+	u32 ep_mask;
+	int i;
+
+	/* Read it from USB_CAP3 to USB_CAP5 */
+	ep_enabled_reg = readl(&priv_dev->regs->usb_cap3);
+	iso_ep_reg = readl(&priv_dev->regs->usb_cap4);
+
+	dev_dbg(&priv_dev->dev, "Initializing non-zero endpoints\n");
+
+	for (i = 0; i < USB_SS_ENDPOINTS_MAX_COUNT; i++) {
+		ep_number = (i / 2) + 1;
+		ep_dir = i % 2;
+		ep_mask = BIT((16 * ep_dir) + ep_number);
+
+		if (!(ep_enabled_reg & ep_mask))
+			continue;
+
+		priv_ep = devm_kzalloc(&priv_dev->dev, sizeof(*priv_ep),
+				       GFP_KERNEL);
+		if (!priv_ep)
+			return -ENOMEM;
+
+		/* set parent of endpoint object */
+		priv_ep->cdns3_dev = priv_dev;
+		priv_dev->eps[found_endpoints++] = priv_ep;
+
+		snprintf(priv_ep->name, sizeof(priv_ep->name), "ep%d%s",
+			 ep_number, !!ep_dir ? "in" : "out");
+		priv_ep->endpoint.name = priv_ep->name;
+
+		usb_ep_set_maxpacket_limit(&priv_ep->endpoint,
+					   ENDPOINT_MAX_PACKET_LIMIT);
+		priv_ep->endpoint.max_streams = ENDPOINT_MAX_STREAMS;
+		//TODO: Add implementation of cdns3_gadget_ep_ops
+		//priv_ep->endpoint.ops = &cdns3_gadget_ep_ops;
+		if (ep_dir)
+			priv_ep->endpoint.caps.dir_in = 1;
+		else
+			priv_ep->endpoint.caps.dir_out = 1;
+
+		if (iso_ep_reg & ep_mask)
+			priv_ep->endpoint.caps.type_iso = 1;
+
+		priv_ep->endpoint.caps.type_bulk = 1;
+		priv_ep->endpoint.caps.type_int = 1;
+		priv_ep->endpoint.maxburst = CDNS3_EP_BUF_SIZE - 1;
+
+		dev_info(&priv_dev->dev, "Initialized  %s support: %s %s\n",
+			 priv_ep->name,
+			 priv_ep->endpoint.caps.type_bulk ? "BULK, INT" : "",
+			 priv_ep->endpoint.caps.type_iso ? "ISO" : "");
+
+		list_add_tail(&priv_ep->endpoint.ep_list,
+			      &priv_dev->gadget.ep_list);
+		INIT_LIST_HEAD(&priv_ep->request_list);
+		INIT_LIST_HEAD(&priv_ep->ep_match_pending_list);
+	}
+
+	priv_dev->ep_nums = found_endpoints;
+	return 0;
+}
+
+static void cdns3_gadget_release(struct device *dev)
+{
+	struct cdns3_device *priv_dev;
+
+	priv_dev = container_of(dev, struct cdns3_device, dev);
+	kfree(priv_dev);
+}
+
+static int __cdns3_gadget_init(struct cdns3 *cdns)
+{
+	struct cdns3_device *priv_dev;
+	struct device *dev;
+	int ret;
+
+	priv_dev = kzalloc(sizeof(*priv_dev), GFP_KERNEL);
+	if (!priv_dev)
+		return -ENOMEM;
+
+	dev = &priv_dev->dev;
+	dev->release = cdns3_gadget_release;
+	dev->parent = cdns->dev;
+	dev_set_name(dev, "gadget-cdns3");
+	cdns->gadget_dev = dev;
+
+	priv_dev->sysdev = cdns->dev;
+	ret = device_register(dev);
+	if (ret)
+		goto err1;
+
+	priv_dev->regs = cdns->dev_regs;
+
+	/* fill gadget fields */
+	priv_dev->gadget.max_speed = USB_SPEED_SUPER;
+	priv_dev->gadget.speed = USB_SPEED_UNKNOWN;
+	//TODO: Add implementation of cdns3_gadget_ops
+	//priv_dev->gadget.ops = &cdns3_gadget_ops;
+	priv_dev->gadget.name = "usb-ss-gadget";
+	priv_dev->gadget.sg_supported = 1;
+	priv_dev->is_connected = 0;
+
+	spin_lock_init(&priv_dev->lock);
+
+	priv_dev->in_standby_mode = 1;
+
+	/* initialize endpoint container */
+	INIT_LIST_HEAD(&priv_dev->gadget.ep_list);
+	INIT_LIST_HEAD(&priv_dev->ep_match_list);
+
+	ret = cdns3_init_ep0(priv_dev);
+	if (ret) {
+		dev_err(dev, "Failed to create endpoint 0\n");
+		ret = -ENOMEM;
+		goto err2;
+	}
+
+	ret = cdns3_init_ep(priv_dev);
+	if (ret) {
+		dev_err(dev, "Failed to create non zero endpoints\n");
+		ret = -ENOMEM;
+		goto err2;
+	}
+
+	/* allocate memory for default endpoint TRB */
+	priv_dev->trb_ep0 = dma_alloc_coherent(priv_dev->sysdev, 24,
+					       &priv_dev->trb_ep0_dma, GFP_DMA);
+	if (!priv_dev->trb_ep0) {
+		dev_err(dev, "Failed to allocate memory for ep0 TRB\n");
+		ret = -ENOMEM;
+		goto err2;
+	}
+
+	/* allocate memory for setup packet buffer */
+	priv_dev->setup = dma_alloc_coherent(priv_dev->sysdev, 8,
+					     &priv_dev->setup_dma, GFP_DMA);
+	if (!priv_dev->setup) {
+		dev_err(dev, "Failed to allocate memory for SETUP buffer\n");
+		ret = -ENOMEM;
+		goto err3;
+	}
+
+	dev_dbg(dev, "Device Controller version: %08x\n",
+		readl(&priv_dev->regs->usb_cap6));
+	dev_dbg(dev, "USB Capabilities:: %08x\n",
+		readl(&priv_dev->regs->usb_cap1));
+	dev_dbg(dev, "On-Chip memory cnfiguration: %08x\n",
+		readl(&priv_dev->regs->usb_cap2));
+
+	/* add USB gadget device */
+	ret = usb_add_gadget_udc(&priv_dev->dev, &priv_dev->gadget);
+	if (ret < 0) {
+		dev_err(dev, "Failed to register USB device controller\n");
+		goto err4;
+	}
+
+	priv_dev->zlp_buf = kzalloc(ENDPOINT_ZLP_BUF_SIZE, GFP_KERNEL);
+	if (!priv_dev->zlp_buf) {
+		ret = -ENOMEM;
+		goto err4;
+	}
+
+	return 0;
+err4:
+	dma_free_coherent(priv_dev->sysdev, 8, priv_dev->setup,
+			  priv_dev->setup_dma);
+err3:
+	dma_free_coherent(priv_dev->sysdev, 20, priv_dev->trb_ep0,
+			  priv_dev->trb_ep0_dma);
+err2:
+	device_del(dev);
+err1:
+	put_device(dev);
+	cdns->gadget_dev = NULL;
+	return ret;
+}
 
 /**
  * cdns3_gadget_remove: parent must call this to remove UDC
@@ -19,7 +273,96 @@
  */
 void cdns3_gadget_remove(struct cdns3 *cdns)
 {
-	//TODO: implements this function
+	struct cdns3_device *priv_dev;
+
+	if (!cdns->roles[CDNS3_ROLE_GADGET])
+		return;
+
+	priv_dev = container_of(cdns->gadget_dev, struct cdns3_device, dev);
+	usb_del_gadget_udc(&priv_dev->gadget);
+	dma_free_coherent(priv_dev->sysdev, 8, priv_dev->setup,
+			  priv_dev->setup_dma);
+	dma_free_coherent(priv_dev->sysdev, 20, priv_dev->trb_ep0,
+			  priv_dev->trb_ep0_dma);
+	device_unregister(cdns->gadget_dev);
+	cdns->gadget_dev = NULL;
+	kfree(priv_dev->zlp_buf);
+}
+
+static int cdns3_gadget_start(struct cdns3 *cdns)
+{
+	struct cdns3_device *priv_dev = container_of(cdns->gadget_dev,
+			struct cdns3_device, dev);
+	unsigned long flags;
+
+	pm_runtime_get_sync(cdns->dev);
+	spin_lock_irqsave(&priv_dev->lock, flags);
+	priv_dev->start_gadget = 1;
+
+	if (!priv_dev->gadget_driver) {
+		spin_unlock_irqrestore(&priv_dev->lock, flags);
+		return 0;
+	}
+
+	cdns3_gadget_config(priv_dev);
+	priv_dev->in_standby_mode = 0;
+	spin_unlock_irqrestore(&priv_dev->lock, flags);
+	return 0;
+}
+
+static void __cdns3_gadget_stop(struct cdns3 *cdns)
+{
+	struct cdns3_device *priv_dev;
+	unsigned long flags;
+
+	priv_dev = container_of(cdns->gadget_dev, struct cdns3_device, dev);
+
+	if (priv_dev->gadget_driver)
+		priv_dev->gadget_driver->disconnect(&priv_dev->gadget);
+
+	usb_gadget_disconnect(&priv_dev->gadget);
+	spin_lock_irqsave(&priv_dev->lock, flags);
+	priv_dev->gadget.speed = USB_SPEED_UNKNOWN;
+
+	/* disable interrupt for device */
+	writel(0, &priv_dev->regs->usb_ien);
+	writel(USB_CONF_DEVDS, &priv_dev->regs->usb_conf);
+	priv_dev->start_gadget = 0;
+	spin_unlock_irqrestore(&priv_dev->lock, flags);
+}
+
+static void cdns3_gadget_stop(struct cdns3 *cdns)
+{
+	if (cdns->role == CDNS3_ROLE_GADGET)
+		__cdns3_gadget_stop(cdns);
+
+	pm_runtime_mark_last_busy(cdns->dev);
+	pm_runtime_put_autosuspend(cdns->dev);
+}
+
+static int cdns3_gadget_suspend(struct cdns3 *cdns, bool do_wakeup)
+{
+	__cdns3_gadget_stop(cdns);
+	return 0;
+}
+
+static int cdns3_gadget_resume(struct cdns3 *cdns, bool hibernated)
+{
+	struct cdns3_device *priv_dev;
+	unsigned long flags;
+
+	priv_dev = container_of(cdns->gadget_dev, struct cdns3_device, dev);
+	spin_lock_irqsave(&priv_dev->lock, flags);
+	priv_dev->start_gadget = 1;
+	if (!priv_dev->gadget_driver) {
+		spin_unlock_irqrestore(&priv_dev->lock, flags);
+		return 0;
+	}
+
+	cdns3_gadget_config(priv_dev);
+	priv_dev->in_standby_mode = 0;
+	spin_unlock_irqrestore(&priv_dev->lock, flags);
+	return 0;
 }
 
 /**
@@ -31,6 +374,18 @@ void cdns3_gadget_remove(struct cdns3 *cdns)
  */
 int cdns3_gadget_init(struct cdns3 *cdns)
 {
-	//TODO: implements this function
-	return 0;
+	struct cdns3_role_driver *rdrv;
+
+	rdrv = devm_kzalloc(cdns->dev, sizeof(*rdrv), GFP_KERNEL);
+	if (!rdrv)
+		return -ENOMEM;
+
+	rdrv->start	= cdns3_gadget_start;
+	rdrv->stop	= cdns3_gadget_stop;
+	rdrv->suspend	= cdns3_gadget_suspend;
+	rdrv->resume	= cdns3_gadget_resume;
+	rdrv->irq	= cdns3_irq_handler_thread;
+	rdrv->name	= "gadget";
+	cdns->roles[CDNS3_ROLE_GADGET] = rdrv;
+	return __cdns3_gadget_init(cdns);
 }
diff --git a/drivers/usb/cdns3/gadget.h b/drivers/usb/cdns3/gadget.h
index c4b07827aae7..b57e863017b0 100644
--- a/drivers/usb/cdns3/gadget.h
+++ b/drivers/usb/cdns3/gadget.h
@@ -1064,4 +1064,8 @@ struct cdns3_device {
 	struct usb_request		*pending_status_request;
 };
 
+void cdns3_set_register_bit(void __iomem *ptr, u32 mask);
+int cdns3_init_ep0(struct cdns3_device *priv_dev);
+void cdns3_ep0_config(struct cdns3_device *priv_dev);
+void cdns3_select_ep(struct cdns3_device *priv_dev, u32 ep);
 #endif /* __LINUX_CDNS3_GADGET */
-- 
2.17.1

