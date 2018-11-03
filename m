Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0B1C6786F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25C3020833
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="mKuCehTO";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="bxZVxVyR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25C3020833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbeKDDFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 23:05:15 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:49150 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727537AbeKDDFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 23:05:14 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wA3Hphjv029618;
        Sat, 3 Nov 2018 10:53:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=rvxUEa9zYeMGrzu3OuyMNsJDXUTQ1o70T/rg0bXttr8=;
 b=mKuCehTOLvIy+YZQ4ixLui+wGN/F4uARKmYnSGty3K9w2WWz9WxzccvSJ6ylJA4qSPKI
 UXH4In7klSkJwZYMVKqwLRCnEREkM8MNBx9KGL1Nw2bal1oUHVrK40jofODNBNJE/Hs/
 5nbcrJ53LNBFjJn8xXeGVGF9RqjkW82/yu5rotG0CGmZEwnd3NYEUQiiQXOVaGJR3m3H
 yjE+UPL6A4XRkXhkOutnchwh56t5S2b5LUIhp60FdrljQ/t/mRUfgO/hsClLfqKBmNPH
 J8WKz5DZ+npp3N3kvpzrHwagVYyTaABhtdn7Jo/f7dV8fNMdYe7uo8sm6FAGfjz8jgKr lA== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam01-by2-obe.outbound.protection.outlook.com (mail-by2nam01lp0182.outbound.protection.outlook.com [216.32.181.182])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2nh87rhmwj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sat, 03 Nov 2018 10:53:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvxUEa9zYeMGrzu3OuyMNsJDXUTQ1o70T/rg0bXttr8=;
 b=bxZVxVyRH050mxAaNl7MC9RxQ2RtWenmmnBnSya3SYNszha9Q+yKkuzpiLh9jEHRIr5sN8dFet4VG6g4x/Mm5TJFQ4Qzu71ZTQ1UIYO/qTheWQzcEYzYDBMCIpKuQt+Nhg4thb+tQcs+Jfwy93kvvg9iVKQdPvg8wHWAnKmArGw=
Received: from DM5PR07CA0093.namprd07.prod.outlook.com (2603:10b6:4:ae::22) by
 DM6PR07MB5180.namprd07.prod.outlook.com (2603:10b6:5:4e::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.27; Sat, 3 Nov 2018 17:53:09 +0000
Received: from DM3NAM05FT055.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::205) by DM5PR07CA0093.outlook.office365.com
 (2603:10b6:4:ae::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.21 via Frontend
 Transport; Sat, 3 Nov 2018 17:53:09 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 DM3NAM05FT055.mail.protection.outlook.com (10.152.98.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.3 via Frontend Transport; Sat, 3 Nov 2018 17:53:08 +0000
Received: from mailrm1.global.cadence.com (mailrm1.cadence.com [10.209.213.2])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id wA3HqwJn027434
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Sat, 3 Nov 2018 10:52:59 -0700
X-CrossPremisesHeadersFilteredBySendConnector: mailrm1.global.cadence.com
Received: from mailrm1.global.cadence.com (10.209.213.2) by
 mailrm1.global.cadence.com (10.209.213.2) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sat, 3 Nov 2018 13:52:30 -0400
Received: from rmmaillnx1.cadence.com (10.209.208.46) by
 mailrm1.global.cadence.com (10.209.213.2) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Sat, 3 Nov 2018 13:52:30 -0400
Received: from mailrm1.global.cadence.com (mailrm1.cadence.com [10.209.213.2])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id wA3HqOFj000599
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Sat, 3 Nov 2018 13:52:24 -0400
X-CrossPremisesHeadersFilteredBySendConnector: mailrm1.global.cadence.com
Received: from mailrm1.global.cadence.com (10.209.213.2) by
 mailrm1.global.cadence.com (10.209.213.2) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sat, 3 Nov 2018 13:52:28 -0400
Received: from rmmaillnx1.cadence.com (10.209.208.46) by
 mailrm1.global.cadence.com (10.209.213.2) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Sat, 3 Nov 2018 13:52:28 -0400
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id wA3Hq9x8000566
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Sat, 3 Nov 2018 13:52:22 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sat, 3 Nov 2018 18:52:17 +0100
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Sat, 3 Nov 2018 18:52:17 +0100
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id wA3HqCG0006487;
        Sat, 3 Nov 2018 17:52:12 GMT
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id wA3HqCRO006486;
        Sat, 3 Nov 2018 17:52:12 GMT
From:   Pawel Laszczak <pawell@cadence.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <rogerq@ti.com>,
        <linux-kernel@vger.kernel.org>, <adouglas@cadence.com>,
        <jbergsagel@ti.com>, <peter.chen@nxp.com>, <pjez@cadence.com>,
        <kurahul@cadence.com>, <pawell@cadence.com>
Subject: [RFC PATCH v1 10/14] usb:cdns3: Implements ISR functionality.
Date:   Sat, 3 Nov 2018 17:51:23 +0000
Message-ID: <1541267487-3664-11-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1541267487-3664-1-git-send-email-pawell@cadence.com>
References: <1541267487-3664-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-OrganizationHeadersPreserved: mailrm1.global.cadence.com
X-OrganizationHeadersPreserved: mailrm1.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(136003)(39860400002)(2980300002)(199004)(189003)(36092001)(186003)(87636003)(26826003)(478600001)(5660300001)(217873002)(14444005)(48376002)(105596002)(50466002)(6916009)(4720700003)(2351001)(36756003)(426003)(336012)(106466001)(486006)(446003)(11346002)(126002)(2616005)(476003)(16586007)(42186006)(316002)(26005)(54906003)(7636002)(76176011)(51416003)(47776003)(2906002)(8936002)(305945005)(50226002)(8676002)(86362001)(4326008)(246002)(6666004)(4744004)(356004)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB5180;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT055;1:begjWrv5Lkn7OpcjlfZNavL/dDQBsH2X9vrE1dDIOXeZhR7D50skG8Mu+p0kWgysNGxuQB+WHEYvEwGBDbGIpiDMlcjzzh5r8+v4d74db9oPX7dfyDs3u6VOEPyA8mHT
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d447c0f-be3c-4f99-37b8-08d641b53747
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:DM6PR07MB5180;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB5180;3:+U+PvPNPeBNE2yBnfRX+vsxMRmPhKosOl6DY6am0UTzBIUzQ/9cY7cyTFKucb6uGFd77qAL4zp9+nJuMC7GslVeFrrrUJ6Qi+jf3ZIF2YmMRbD3UMpLqGSIqCGY+B46L7zvfc10phbqgMiFiMfKycQ4uDb7N4XpftdJCD0s46CnqeuqY0MPREXJxm/4uxAiNBKR1EfZe1b9I8zqEgohBwIC9sHnW4/k7KP+45wYy/zldbIETOtFESePsibDSIRg7FMcEELBcPmGnzbAdlFAxx2xTBARiLQZKSRWooPaxwLvX3KVPMbiEbn7qxBI8C2MeW9raTk8SKVRE9M95PJqqkK3h3DqpA8hMHHb1ILIeXX8=;25:6/mNHDlQDx2aC2kKDO9jo+km40kUqIk8IL+vrUbzpu/2fPxkv6zYYPAguW6wuh71fXQaWKYaR7sbhM/tymjjYjBsr3WNwagh3gpHgRUETU/kHcMwpUTmE2kzT5I1p7Cr1Pui5y1Q1N+P9OydS7W7Gipmco9lS9liO8OHmbtN6hYNi+qWdzLX8cUB2nlpoPUyOdQS7nWSyD1pu73wWa8wQI3frUesPquEv0ktK/4Si9w0zRQ8/8GKft1o2oW3dB3j8umXc3GQmnKZwaT5bWZpQ/tWq1Rf+f+nCTkLhKYukw/ausHww1+rzWdq4VeUz63UF7x5ymk69jeLg0CknbzXGQ==
X-MS-TrafficTypeDiagnostic: DM6PR07MB5180:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB5180;31:K1db7e6aqpCI3c8G17DNNgnHhoMCmTcEnns2kjt2RGPIW9EiZKLD22oIMj6ImA+En3iDstfTlu+QU0ECa6ODmCW9LGi1t8n8gCGUv0nc3kuGWRMJvyyR64nOc2tHqbRnlbWdiRmJFRXAca7+IuiBnxpwJSKly2h+RdeJzLTXwIMQI46pjzHmVaD2Rd/ToQXKTUY7jzpQ6Bchq1QyKq2RxF5kVFtPeW9AnvGFQGrVuog=;20:P9g7XsJzFPtlZd3lv0V02qMtip0jpnGiYkxtFuDh5oXkb+1t07ecGNTVtJyfU8i3tsWKU/4kFF0mHW3g1FRZjzNV+QPRgzO5AhBKh9zgkEwZtUnOeo3Bopnq7KMWh7S0f2fECTHF3kj2IfQoPgvrxE3pDA9libybRdC4PTWJ2UxgTe5qUJjuTEgIXT1FNGRXJtMGzmjsS5QleBJj8MFQPR8M5B9wIdf74Q6goR6PsUeqZBBcTLZPTsc9DEeUf/O7qhYL7yAEbRmZ9cszxR5auIBYtVyRQ7bhUfcmqaNJ1PiO8G8P/6qOPKa26+Sq/v5QD5thII2+HkiHklCGCbrEyR36czethS7/0cIFmHf4Gd8tmK36Bq9LqikZunSXKqcCnftVv0EHwDq9ZOvXIQQPJ+XddIrOTuXETHTVR5mJt76SG21ob9Uv/6uHX1vIu+tkz/Im1GnIQlZIfdIifLD88f1/7u0nrvmBbdX5kSzFm5nCHOnJEJ6IR9/uguLwApBs
X-Microsoft-Antispam-PRVS: <DM6PR07MB51809DEE79C8D4B19FCEB580DDC80@DM6PR07MB5180.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(93006095)(93003095)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DM6PR07MB5180;BCL:0;PCL:0;RULEID:;SRVR:DM6PR07MB5180;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB5180;4:7VZ6nOstSrzfpW6OMzt8d8hNqiOTOZHNuIuLVRcFNK7n7cgzT3y/IVW+V1tYehsQuFK48q5txXvD1UJTKBXW+HnQs/4j78zW7d3eNQk+CTJhhFNkp2qENiSmyUgXgEa2tBF/YIvnc7+tqSmylISvAmd0JCHZqLhpYtJWJgxNjd8+3gzrgBf8JARIiaM9ez9pUypJnRI5MtD6fFAmrgEYYaOkM9yfpSA01rznwgn5H0L8gDhmkKj1lyRl7QOGQQfQHyp2EpVjNWxViM3b8DqN1vr8TnM8Z/pn0r76g75HlK18DdUdY0MN5+6TnZzRHW65
X-Forefront-PRVS: 08457955C4
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR07MB5180;23:udi0an/2qZhzT0nQMds3PV2kd/JxDb9RblbG8ag3J?=
 =?us-ascii?Q?S5UzS3d/FBYhYA73Bo88f6DPG2uaPNprn7WUlKrN7l/+G/MWu5Fy6tHRxRkb?=
 =?us-ascii?Q?nnVpJ7Dut8GMiqDX4ZnBfebBZH1DQyCu4M1wL3b5gQHDZq88YBQuaDsWaVNC?=
 =?us-ascii?Q?HllsIb0Vqeg0ewNLzPGhG136BGU7+f6/hU1iHYzi5D7sNobano9gPpHkRRrv?=
 =?us-ascii?Q?PhyIGRxiSUWLv+/VDxVgzzj2d43BR/7P0yVUysm0s4Qx0XdZZBZOPfrmTW2W?=
 =?us-ascii?Q?AUUmDhPWgh/NFVamRlRGp9SHoALRphuYS5Nq9eP3eL8HJI31smSCBD6jWOEI?=
 =?us-ascii?Q?FF+Khi/pznvS9Ds6yH21UCoMETyzc6zVL9lZ6NefhLgt2zofpx7L4ujr9IkL?=
 =?us-ascii?Q?8ei5+yA7JO2baw/qzJGJtrKODE7Y2Uzw2xxvpu4wu/tmdX7H8QQkqN8g6zUQ?=
 =?us-ascii?Q?Lnp86O6hFk4Lx6xSD13D47N+r9Cuj+9PrRZ+X9IO+W8fRe8h7QnRxPYyK9JF?=
 =?us-ascii?Q?h5AygXnWN/QGCL9hxo20AXg0L7BxlM0DS6zTufOMvquWhIjKXbBDMqWCO8nr?=
 =?us-ascii?Q?xkoE1axA1RwjvM1nJYBMb80bJWNcWCekwg5O8ARbB0Lxqd6W3jVXRcn1dNNF?=
 =?us-ascii?Q?iGmZIvrkkWoOafXR3Kpgh/iMEiJaz40g7EUMrAfTFnUbu/CMRzAelBNonRqE?=
 =?us-ascii?Q?o+6KkNwSdHdEQcFv93Al0RK3aZ4v4XrA8aUmD/1tw7KT3QpT3yBNOPRLwicS?=
 =?us-ascii?Q?Ylyma0YsVOQuLm3092/ngSDnJciu/LV6VycfiuF+hIRj8dHy5hw9KqLaONtM?=
 =?us-ascii?Q?NHyvLKRpIgeNgBSF7ItZUHBRkZt78gYQ+1q9Vi8/2x99w/KjqRBhY5q+mz1l?=
 =?us-ascii?Q?+cq3dhbV1yln5ghd7N05xoC4uHZvB8Fe2+VTU/hvuRA6Tk+OfMpDd469jLGV?=
 =?us-ascii?Q?cBEL0+sjahi/LqOUgvElLJIMOqaIKdsJLiaIUe7Yks2WWgSZuV/cwF3iPhRM?=
 =?us-ascii?Q?NWprb+hsO1ilmjC8Q+36maI3eyNqzEod7ZH+vPZoc6O8tsFTpJHKrldj2KRC?=
 =?us-ascii?Q?8f63wX9e0WgXr1CUHGD4hHI5TZ4LTDUljtuj6fvcettFNhjHkN7zTn9sKtVx?=
 =?us-ascii?Q?nD5v784IgZNZaSv8RA57EAl8gViED2SsYSud7rmSVvzMkIIdHt9znBKiPjs3?=
 =?us-ascii?Q?Gcgu/8po0ROZrM=3D?=
X-Microsoft-Antispam-Message-Info: HoduOc5b6LVOugCN7Xo+NJLzFU7hxYS0a3YuiyMjssn1YLBfJ+WYt+7yWmiBUuHAgZnlbzfAWQxrNoThGxjcwNNwYm9Pw50NIZT2sw7G4uD8zL/eD/6r6o28XJb0ZnSufVarXDvgJRpNd4MNHuFVzggRsWPOQ9w0ahXu6UavcxeH6xKG6ay8+uF1e1j4ou7zmusdAvQe+bay8Z/vzW75ueYGUPG8H9bnz8QQTg3OeMvdfSAGQWFIFbQDXlMQL8J3VeklkCjzvbjCPu9dSGyt599wQhRyVrc2HL+wtY2Pgt/l8HVL5OJqjOf3yp7B8t4ToPlrUUB4/s5/BIzG7I/D5GzjWdtwqurynUHjA/2by4o=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB5180;6:Jd3c1ZpLicLK5WybXyTsDKN+n3JR/glRm5OA0AIo7yxauAqhymv0kF2de0jpwCXAudPoeRgRBIQarofSxrlNh+tXV9KBOTLlQ+bAn6MBrNXD/FhalzYYk1ntRjMx/H34vofcL2pN4ewPFjkYUu/+jbbN+dfRglDlm9DTCglTq9BVOxSn+r6Hn0Y4osEZciiBfntrI8z4vDJ6Hh3TlqmJoDIKMBo0mt52mSFIzHc5GBpnZOzR/iDGu6C+001EFCHjf8Rvy2YmxDGuF1xFfcD3fFYCLoHhytl6CykYXIO3+peV+FUt9wdRn96D9TicY3Ilvh9DmP0OqRDOM2NEv4ITsEAs3FhOE4W/ogjcgvWrh0k2iktoyfCayzvsAMXMEu1Oi+zgiuTWfL1cEY2XgUeP8z1X2Gsd4zwU3KHXtiGmy13fyCpvxhCj0C0zCS3nj/6f7DVvZKzBRYkIIaB1c91tRw==;5:i5P1ILskItdkhVx7BJPjvvvYcfshLX/Ts2Nea9ZR57fJXmNrj9NYnCWWktNhdu/G+p9fGEB2/dMNXeKBzjorezIWB4sAIEDRMEb+t5jGz6CPsKEBxaRC+NIHJayaAICSQRcQcWtIjep95Tivijw/R6AKS/58f0m4uvjKSgPAQOk=;7:QGEXC1XkelJ1S/p3VJJjVhQUMk7w3xVtp9a+PWx8zhPwBFYtrBbPsekR02oOb0PaZH/WaT94jwUg40By6/NSdDUyP0Ppg+WBCILBcbEdMelYVI2rX32ljGbMNknZ309cQaI3iPqw2rGKSd5csERDsw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB5180;20:a7jZaZHeGikZ6nRABwdpDAi3RJ1ApwSSb3uvEk6ucSCdxAI203AS2KYuIkPi8e85MohEv8L8gd+xjdSCMvJ4TMRl57Q4hUTY2JcGuAbyKbsNfFTsY7yfTej92F4DSVxNJKg4RRb20xkW4wXxCt5ZlsmDHd9kMECFlfhEouw3J9RjWF4Kv/s2O15R9vM0nX2CWXznketE6ZKGPNYyqY5qA+MMiauor88PrBo3rFsfDOtf/2Su1X1wza/vK117okPl
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2018 17:53:08.7272
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d447c0f-be3c-4f99-37b8-08d641b53747
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB5180
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
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811030169
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch adds set of generic functions used for handling interrupts
generated by controller. Interrupt related functions are divided
into three groups. The first is related to ep0 and is placed in ep0.c.
The second is responsible for non-default endpoints and is
implemented in gadget.c file. The last group is not related to
endpoints interrupts and is placed in gadget.c.
All groups have common entry point in cdns3_irq_handler_thread function.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/ep0.c    |  63 +++++++++++
 drivers/usb/cdns3/gadget.c | 224 ++++++++++++++++++++++++++++++++++++-
 drivers/usb/cdns3/gadget.h |   1 +
 3 files changed, 287 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/cdns3/ep0.c b/drivers/usb/cdns3/ep0.c
index f838e1e71183..369bd6748416 100644
--- a/drivers/usb/cdns3/ep0.c
+++ b/drivers/usb/cdns3/ep0.c
@@ -90,6 +90,69 @@ static void cdns3_set_hw_configuration(struct cdns3_device *priv_dev)
 	}
 }
 
+static void __pending_setup_status_handler(struct cdns3_device *priv_dev)
+{
+	//TODO: Implements this function
+}
+
+/**
+ * cdns3_ep0_setup_phase - Handling setup USB requests
+ * @priv_dev: extended gadget object
+ */
+static void cdns3_ep0_setup_phase(struct cdns3_device *priv_dev)
+{
+	//TODO: Implements this function.
+}
+
+static void cdns3_transfer_completed(struct cdns3_device *priv_dev)
+{
+	//TODO: Implements this function
+}
+
+/**
+ * cdns3_check_ep0_interrupt_proceed - Processes interrupt related to endpoint 0
+ * @priv_dev: extended gadget object
+ * @dir: 1 for IN direction, 0 for OUT direction
+ */
+void cdns3_check_ep0_interrupt_proceed(struct cdns3_device *priv_dev, int dir)
+{
+	struct cdns3_usb_regs __iomem *regs = priv_dev->regs;
+	u32 ep_sts_reg;
+
+	cdns3_select_ep(priv_dev, 0 | (dir ? USB_DIR_IN : USB_DIR_OUT));
+	ep_sts_reg = readl(&regs->ep_sts);
+
+	__pending_setup_status_handler(priv_dev);
+
+	if ((ep_sts_reg & EP_STS_SETUP) && dir == 0) {
+		struct usb_ctrlrequest *setup = priv_dev->setup;
+
+		writel(EP_STS_SETUP | EP_STS_IOC | EP_STS_ISP, &regs->ep_sts);
+
+		priv_dev->ep0_data_dir = setup->bRequestType & USB_DIR_IN;
+		cdns3_ep0_setup_phase(priv_dev);
+		ep_sts_reg &= ~(EP_STS_SETUP | EP_STS_IOC | EP_STS_ISP);
+	}
+
+	if (ep_sts_reg & EP_STS_TRBERR)
+		writel(EP_STS_TRBERR, &priv_dev->regs->ep_sts);
+
+	if (ep_sts_reg & EP_STS_DESCMIS) {
+		writel(EP_STS_DESCMIS, &priv_dev->regs->ep_sts);
+
+		if (dir == 0 && !priv_dev->setup_pending) {
+			priv_dev->ep0_data_dir = 0;
+			cdns3_ep0_run_transfer(priv_dev, priv_dev->setup_dma,
+					       8, 0);
+		}
+	}
+
+	if ((ep_sts_reg & EP_STS_IOC) || (ep_sts_reg & EP_STS_ISP)) {
+		writel(EP_STS_IOC, &priv_dev->regs->ep_sts);
+		cdns3_transfer_completed(priv_dev);
+	}
+}
+
 /**
  * cdns3_gadget_ep0_enable
  * Function shouldn't be called by gadget driver,
diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
index cd6023c04be9..cb8a3473449b 100644
--- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/gadget.c
@@ -58,6 +58,18 @@ void cdns3_set_register_bit(void __iomem *ptr, u32 mask)
 	writel(mask, ptr);
 }
 
+/**
+ * cdns3_ep_reg_pos_to_index - Macro converts bit position of ep_ists register
+ * to index of endpoint object in cdns3_device.eps[] container
+ * @i: bit position of endpoint for which endpoint object is required
+ *
+ * Remember that endpoint container doesn't contain default endpoint
+ */
+static u8 cdns3_ep_reg_pos_to_index(int i)
+{
+	return ((i / 16) + (((i % 16) - 2) * 2));
+}
+
 /**
  * cdns3_next_request - returns next request from list
  * @list: list containing requests
@@ -178,6 +190,21 @@ static void cdns3_ep_stall_flush(struct cdns3_endpoint *priv_ep)
 	priv_ep->flags |= EP_STALL;
 }
 
+/**
+ * cdns3_gadget_unconfig - reset device configuration
+ * @priv_dev: extended gadget object
+ */
+void cdns3_gadget_unconfig(struct cdns3_device *priv_dev)
+{
+	/* RESET CONFIGURATION */
+	writel(USB_CONF_CFGRST, &priv_dev->regs->usb_conf);
+
+	cdns3_enable_l1(priv_dev, 0);
+	priv_dev->hw_configured_flag = 0;
+	priv_dev->onchip_mem_allocated_size = 0;
+	priv_dev->out_mem_is_allocated = 0;
+}
+
 void cdns3_enable_l1(struct cdns3_device *priv_dev, int enable)
 {
 	if (enable)
@@ -186,6 +213,23 @@ void cdns3_enable_l1(struct cdns3_device *priv_dev, int enable)
 		writel(USB_CONF_L1DS, &priv_dev->regs->usb_conf);
 }
 
+static enum usb_device_speed cdns3_get_speed(struct cdns3_device *priv_dev)
+{
+	u32 reg;
+
+	reg = readl(&priv_dev->regs->usb_sts);
+
+	if (DEV_SUPERSPEED(reg))
+		return USB_SPEED_SUPER;
+	else if (DEV_HIGHSPEED(reg))
+		return USB_SPEED_HIGH;
+	else if (DEV_FULLSPEED(reg))
+		return USB_SPEED_FULL;
+	else if (DEV_LOWSPEED(reg))
+		return USB_SPEED_LOW;
+	return USB_SPEED_UNKNOWN;
+}
+
 /**
  * cdns3_gadget_giveback - call struct usb_request's ->complete callback
  * @priv_ep: The endpoint to whom the request belongs to
@@ -211,12 +255,136 @@ void cdns3_gadget_giveback(struct cdns3_endpoint *priv_ep,
  */
 int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
 			  struct usb_request *request)
+{
+	return 0;
+}
+
+static void cdns3_transfer_completed(struct cdns3_device *priv_dev,
+				     struct cdns3_endpoint *priv_ep)
 {
 	//TODO: Implements this function.
+}
+
+/**
+ * cdns3_check_ep_interrupt_proceed - Processes interrupt related to endpoint
+ * @priv_ep: endpoint object
+ *
+ * Returns 0
+ */
+static int cdns3_check_ep_interrupt_proceed(struct cdns3_endpoint *priv_ep)
+{
+	struct cdns3_device *priv_dev = priv_ep->cdns3_dev;
+	struct cdns3_usb_regs __iomem *regs;
+	u32 ep_sts_reg;
+
+	regs = priv_dev->regs;
+
+	cdns3_select_ep(priv_dev, priv_ep->endpoint.address);
+	ep_sts_reg = readl(&regs->ep_sts);
+
+	if (ep_sts_reg & EP_STS_TRBERR)
+		writel(EP_STS_TRBERR, &regs->ep_sts);
+
+	if (ep_sts_reg & EP_STS_ISOERR)
+		writel(EP_STS_ISOERR, &regs->ep_sts);
+
+	if (ep_sts_reg & EP_STS_OUTSMM)
+		writel(EP_STS_OUTSMM, &regs->ep_sts);
+
+	if (ep_sts_reg & EP_STS_NRDY)
+		writel(EP_STS_NRDY, &regs->ep_sts);
+
+	if ((ep_sts_reg & EP_STS_IOC) || (ep_sts_reg & EP_STS_ISP)) {
+		writel(EP_STS_IOC | EP_STS_ISP, &regs->ep_sts);
+		cdns3_transfer_completed(priv_dev, priv_ep);
+	}
+
+	if (ep_sts_reg & EP_STS_DESCMIS)
+		writel(EP_STS_DESCMIS, &regs->ep_sts);
 
 	return 0;
 }
 
+/**
+ * cdns3_check_usb_interrupt_proceed - Processes interrupt related to device
+ * @priv_dev: extended gadget object
+ * @usb_ists: bitmap representation of device's reported interrupts
+ * (usb_ists register value)
+ */
+static void cdns3_check_usb_interrupt_proceed(struct cdns3_device *priv_dev,
+					      u32 usb_ists)
+{
+	struct cdns3_usb_regs __iomem *regs;
+	int speed = 0;
+
+	regs = priv_dev->regs;
+
+	/* Connection detected */
+	if (usb_ists & (USB_ISTS_CON2I | USB_ISTS_CONI)) {
+		writel(USB_ISTS_CON2I | USB_ISTS_CONI, &regs->usb_ists);
+		speed = cdns3_get_speed(priv_dev);
+
+		dev_dbg(&priv_dev->dev, "Connection detected at speed: %s %d\n",
+			usb_speed_string(speed), speed);
+
+		priv_dev->gadget.speed = speed;
+		priv_dev->is_connected = 1;
+		usb_gadget_set_state(&priv_dev->gadget, USB_STATE_POWERED);
+		cdns3_ep0_config(priv_dev);
+	}
+
+	/* SS Disconnection detected */
+	if (usb_ists & (USB_ISTS_DIS2I | USB_ISTS_DISI)) {
+		dev_dbg(&priv_dev->dev, "Disconnection detected\n");
+
+		writel(USB_ISTS_DIS2I | USB_ISTS_DISI, &regs->usb_ists);
+		if (priv_dev->gadget_driver &&
+		    priv_dev->gadget_driver->disconnect) {
+			spin_unlock(&priv_dev->lock);
+			priv_dev->gadget_driver->disconnect(&priv_dev->gadget);
+			spin_lock(&priv_dev->lock);
+		}
+		priv_dev->gadget.speed = USB_SPEED_UNKNOWN;
+		usb_gadget_set_state(&priv_dev->gadget, USB_STATE_NOTATTACHED);
+		priv_dev->is_connected = 0;
+		cdns3_gadget_unconfig(priv_dev);
+	}
+
+	if (usb_ists & USB_ISTS_L2ENTI) {
+		dev_dbg(&priv_dev->dev, "Device suspended\n");
+		writel(USB_ISTS_L2ENTI, &regs->usb_ists);
+	}
+
+	/* Exit from standby mode on L2 exit (Suspend in HS/FS or SS) */
+	if (usb_ists & USB_ISTS_L2EXTI) {
+		dev_dbg(&priv_dev->dev, "[Interrupt] L2 exit detected\n");
+		writel(USB_ISTS_L2EXTI, &regs->usb_ists);
+	}
+
+	/* Exit from standby mode on U3 exit (Suspend in HS/FS or SS). */
+	if (usb_ists & USB_ISTS_U3EXTI) {
+		dev_dbg(&priv_dev->dev, "U3 exit detected\n");
+		writel(USB_ISTS_U3EXTI, &regs->usb_ists);
+	}
+
+	/* resets cases */
+	if (usb_ists & (USB_ISTS_UWRESI | USB_ISTS_UHRESI | USB_ISTS_U2RESI)) {
+		writel(USB_ISTS_U2RESI | USB_ISTS_UWRESI | USB_ISTS_UHRESI,
+		       &regs->usb_ists);
+
+		/*read again to check the actuall speed*/
+		speed = cdns3_get_speed(priv_dev);
+
+		dev_dbg(&priv_dev->dev, "Reset detected at speed: %s %d\n",
+			usb_speed_string(speed), speed);
+
+		usb_gadget_set_state(&priv_dev->gadget, USB_STATE_DEFAULT);
+		priv_dev->gadget.speed = speed;
+		cdns3_gadget_unconfig(priv_dev);
+		cdns3_ep0_config(priv_dev);
+	}
+}
+
 /**
  * cdns3_irq_handler - irq line interrupt handler
  * @cdns: cdns3 instance
@@ -227,8 +395,62 @@ int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
  */
 static irqreturn_t cdns3_irq_handler_thread(struct cdns3 *cdns)
 {
+	struct cdns3_device *priv_dev;
 	irqreturn_t ret = IRQ_NONE;
-	//TODO: implements this function
+	unsigned long flags;
+	u32 reg;
+
+	priv_dev = container_of(cdns->gadget_dev, struct cdns3_device, dev);
+	spin_lock_irqsave(&priv_dev->lock, flags);
+
+	/* check USB device interrupt */
+	reg = readl(&priv_dev->regs->usb_ists);
+	if (reg) {
+		dev_dbg(&priv_dev->dev, "IRQ: usb_ists: %08X\n", reg);
+		cdns3_check_usb_interrupt_proceed(priv_dev, reg);
+		ret = IRQ_HANDLED;
+	}
+
+	/* check endpoint interrupt */
+	reg = readl(&priv_dev->regs->ep_ists);
+	if (reg != 0) {
+		dev_dbg(&priv_dev->dev, "IRQ ep_ists: %08X\n", reg);
+	} else {
+		if (USB_STS_CFGSTS(readl(&priv_dev->regs->usb_sts)))
+			ret = IRQ_HANDLED;
+		goto irqend;
+	}
+
+	/* handle default endpoint OUT */
+	if (reg & EP_ISTS_EP_OUT0) {
+		cdns3_check_ep0_interrupt_proceed(priv_dev, 0);
+		ret = IRQ_HANDLED;
+	}
+
+	/* handle default endpoint IN */
+	if (reg & EP_ISTS_EP_IN0) {
+		cdns3_check_ep0_interrupt_proceed(priv_dev, 1);
+		ret = IRQ_HANDLED;
+	}
+
+	/* check if interrupt from non default endpoint, if no exit */
+	reg &= ~(EP_ISTS_EP_OUT0 | EP_ISTS_EP_IN0);
+	if (!reg)
+		goto irqend;
+
+	do {
+		unsigned int bit_pos = ffs(reg);
+		u32 bit_mask = 1 << (bit_pos - 1);
+		int index;
+
+		index = cdns3_ep_reg_pos_to_index(bit_pos);
+		cdns3_check_ep_interrupt_proceed(priv_dev->eps[index]);
+		reg &= ~bit_mask;
+		ret = IRQ_HANDLED;
+	} while (reg);
+
+irqend:
+	spin_unlock_irqrestore(&priv_dev->lock, flags);
 	return ret;
 }
 
diff --git a/drivers/usb/cdns3/gadget.h b/drivers/usb/cdns3/gadget.h
index 9732273f1b32..2ad3addf8bd7 100644
--- a/drivers/usb/cdns3/gadget.h
+++ b/drivers/usb/cdns3/gadget.h
@@ -1068,6 +1068,7 @@ int cdns3_handshake(void __iomem *ptr, u32 mask, u32 done, int usec);
 void cdns3_set_register_bit(void __iomem *ptr, u32 mask);
 int cdns3_init_ep0(struct cdns3_device *priv_dev);
 void cdns3_ep0_config(struct cdns3_device *priv_dev);
+void cdns3_check_ep0_interrupt_proceed(struct cdns3_device *priv_dev, int dir);
 void cdns3_select_ep(struct cdns3_device *priv_dev, u32 ep);
 void cdns3_enable_l1(struct cdns3_device *priv_dev, int enable);
 struct usb_request *cdns3_next_request(struct list_head *list);
-- 
2.17.1

