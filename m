Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11CFC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96C3B2087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="h5+MWGrd";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Ls44Fu0h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732532AbfAaLxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 06:53:31 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:59280 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732320AbfAaLx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 06:53:29 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0VBhk2M025351;
        Thu, 31 Jan 2019 03:53:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=MqK5u59Ffsmaf6zXuZRIswDw7yVPI+nrQE28untZ1PY=;
 b=h5+MWGrdQfYIsEAuadfNk0P+1eozJn6d2TxF4WsaC/cySUtt6N4ZH+qiiBjDk0Cd6nwN
 gg2rQxoqm44BB8lHPdb55TkeQUX/zj9XaGKP28XcqCxNE/HTXeZugXyuwPmz3eGLZBsz
 WDVXPV2r0kzQiTI2TqNQkLj911v+k8EyYib1ygrNTp61vPF6WIBSd7qd1TDrx9BL/Rxk
 xUR17jl2jA1thOgX2RLIAdnUXL+O+U3LTJrmC/P+7lCAQyLxsnSvm8Rb2oIZPcWb2o2F
 an2wt3ubvzdIOM4HfGEhHjN5A0r+1WEL80JioixiHuMpaFTXbR/ScWEKrOlH7LfNI+I8 Tg== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2058.outbound.protection.outlook.com [104.47.32.58])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2qbn3fjydt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Jan 2019 03:53:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MqK5u59Ffsmaf6zXuZRIswDw7yVPI+nrQE28untZ1PY=;
 b=Ls44Fu0ha1AiVXT0io6nKGSWoA9GTyOJnMTnkpO/g82iduQtVZSykQTuHWtLKPCDlNm+gB0v6thCKHkx3kl0nqTY6H7LiqOsBuxwaN+f8RKb1UdS+p5o7WNPSiRRNyx4tt1vQ7E49XNj13cvI2v39xzq2PPh2yq+OZkbm6q1l4I=
Received: from CY1PR07CA0029.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::39) by CY4PR07MB3096.namprd07.prod.outlook.com
 (2603:10b6:903:ce::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1558.21; Thu, 31 Jan
 2019 11:53:10 +0000
Received: from BY2NAM05FT036.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::206) by CY1PR07CA0029.outlook.office365.com
 (2a01:111:e400:c60a::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.17 via Frontend
 Transport; Thu, 31 Jan 2019 11:53:10 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 BY2NAM05FT036.mail.protection.outlook.com (10.152.100.173) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.2 via Frontend Transport; Thu, 31 Jan 2019 11:53:09 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x0VBr4Sk028139
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 31 Jan 2019 03:53:09 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 31 Jan 2019 12:53:04 +0100
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 31 Jan 2019 12:53:04 +0100
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x0VBr4J0002298;
        Thu, 31 Jan 2019 11:53:04 GMT
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x0VBr4Ia002292;
        Thu, 31 Jan 2019 11:53:04 GMT
From:   Pawel Laszczak <pawell@cadence.com>
To:     <devicetree@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <mark.rutland@arm.com>,
        <linux-usb@vger.kernel.org>, <hdegoede@redhat.com>,
        <heikki.krogerus@linux.intel.com>, <andy.shevchenko@gmail.com>,
        <robh+dt@kernel.org>, <rogerq@ti.com>,
        <linux-kernel@vger.kernel.org>, <jbergsagel@ti.com>,
        <nsekhar@ti.com>, <nm@ti.com>, <sureshp@cadence.com>,
        <peter.chen@nxp.com>, <pjez@cadence.com>, <kurahul@cadence.com>,
        "Pawel Laszczak" <pawell@cadence.com>
Subject: [PATCH v3 3/6] usb:common Patch simplify usb_decode_set_clear_feature function.
Date:   Thu, 31 Jan 2019 11:52:30 +0000
Message-ID: <1548935553-452-4-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1548935553-452-1-git-send-email-pawell@cadence.com>
References: <1548935553-452-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(376002)(346002)(2980300002)(189003)(199004)(36092001)(107886003)(126002)(426003)(2616005)(36756003)(4720700003)(11346002)(305945005)(446003)(486006)(4326008)(105596002)(476003)(2906002)(26826003)(76176011)(6916009)(26005)(47776003)(106466001)(50466002)(42186006)(87636003)(39060400002)(7416002)(336012)(316002)(7636002)(186003)(51416003)(16586007)(86362001)(356004)(8676002)(48376002)(478600001)(8936002)(50226002)(246002)(6666004)(2351001)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3096;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM05FT036;1:9ASd9bXET7Rdyhmh1cei3CuiexrEiKUUdM36oJRYEqbjSzzIeVlGM/EuryYlzT8TWn6EVwVo/mPp1U5FHHZUMAEubQ6tjh9UY6QMcg840dniZwGWRASOdQV2vn6/kwl1Fy/Z4ibmkRTcEprYktYdubycW93p8hfu9TDPw/ulCe4=
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 976eadf5-7dd6-409e-4e52-08d68772abbc
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060);SRVR:CY4PR07MB3096;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3096;3:hPCdYArDZXpT/FnqAdy7ctm2hoMOV9yMj5EHhTz1KZfRKJjsyx8G2PJ1tbW3ujtLkcKPP4QS1QVcSnNXD0DW1Zh5V2q50PnwQ6NGpcxWf5b3Ley1oJjXR7eF79OSRSwl+otOo2wOz2pD9BY2pDg2pPfSbsHCejjFrvYn6x+MQFNeOQMsDLRtOH4wY+DwxJszAJirQyeNVJsv46CabVLwQQrjwdIFyDGYhX3WUKzS8Iut6xyBwqN3P3qufXxn0MWPILt+JSwNahvEjZ8JB9hoPYXd4uQYuuO0+xLrJQJjfei/rWdHQkMVt4RFRmRT5hD5UyJGq/oxTQw2Ydd0ZPUydcfAY+07VgE3x43p+QQDCzRtKJqACCdXo7Ek2neVl5yS;25:0Zp+cImwp9zBR6JMTyBokT0Duq+3G35E/DP4NM9eqeH3wfIVyQuI8co5FrTUzA2bGmCLKPFrO23nmBNn6t3UKaFk1wNxn4CRzo/0bEgSNdGwNasYHUKjex6gbsJaJ9npqnLkG1NBA3O1uHCPOe9cmhWW9v5sQ3s4SZH6OHSidRcoCGD/lESA2qDCZugPMEh+ttmFoZZdNL9nPoYYnzBCKfjpnRln/hltid+L7tCkXasui9vA7moBR/TKtXgRkUsM2XV1UZ2w3tfTTJdEqJn2JmhDD8t4pJOU6EaLwnzKhHvqj8qvHmUm5ezTqHyzpq5HPdo4kTPFwItfkwjBFv2POw==
X-MS-TrafficTypeDiagnostic: CY4PR07MB3096:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3096;31:y3b7fyW0mg0bxCdxVGuPpE2DvZPSvwp+gst3g/vzP0beJYf5ARzoykK9pMCWyG8QgFpq3zSEaz98AkVy/rrTtH0NR0mstoJ4hEcxy5ZEO4dOed+5YJnkwewE7gzt1HkyfMJqH8DQ2vupLtHkL08GvCbESy1UnvB5LyC7SIrV8JWKUFuSqFeCX0Q+pNNqTJ5WE0yhR22jmY45+///pn1Tt4PHo/3JnfIVA5NlrImbJqY=;20:L3D3P+uyixFecM77rOl+bvp+RikSfX6MDitO1GEE6hB8+GmKKq5kPB+MfzPj0LC0AUJExXaJ9BOW/kn04X9qjB5TUb9YfHOQm6CpOcTeUCOIxMcVzfoX9uNyTi7U7niS36JcrihLO2pkzW2rnB2nOwemNURunrVi6W9GZH5R/SWn0XTt1R4xICGz1RTEIRtI0ambmDsvsuLkR0je55SJtPZIwTFEnHoIftSjdCXrX1AQBtyE392diVxoT4VaJDCaPRNgvxjPPmdSs+TwEhlXsHK58hyLAnum7pE5bkXA9EwyLnsEtTr7akpngnigFqnqGAhcKFQCXpXD3WyUXb1oqa6r9vuQJO1tCJXZQYmMquD1wgqSRIjUcFxIL5v4Rg0nGClcFoKRAIB3gX6DWp9mGrk9lHVm2rf29rhtJ9XbrxUrJTkWfVx8hyyifpJZS/UskUsZxxLPI4QaPCuj9uTxVVdl2y6/0mIuXNvQ/Ptwd8ZEqc5K485ekEv0X2wDw5BY
X-Microsoft-Antispam-PRVS: <CY4PR07MB3096802903FD6D6E27CC80EDDD910@CY4PR07MB3096.namprd07.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3096;4:/QvD4Jfw5smy+D9iB1ZMmPwh/FejTfcumxcPF3nimOBO+gZZISvBsQtxEjTbduboKdBYbFkNWwzJeBYuc2kagwvDeP8K3MgHkIQAUgwaiwrTxFOKDYY2GsAgw/TgsyDmwdl/D1VqiQXYW5D+7E65KQmTskIiL2+C1xm8uzkKp8P5P0OA8X3UtxFjqvKzek4WN1O0kK1bE5EHQbHJCdImh7DUER1yWx11BTRGEXXOrCjmftaAvpK1SKHLizGL2grfgeew4wKr7Hgk7gbxN0c3oi7vUGLteLg5tezMe2FAKKM=
X-Forefront-PRVS: 09347618C4
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3096;23:q3oDAnwBniTgzKXsKtggp0HKavxcHRwtpcZeHj3nJ?=
 =?us-ascii?Q?+ABELWism4h9xBbfOZ5xPLmgIlQIsElhg4s6QFn6WKlqZrHlNXubQgNCJQ0v?=
 =?us-ascii?Q?igmhrhl4eNMlVMGEc3Z7OP7kQcpOUA+ClcIdbvEnz++zXVsnYiok9b0hL/j6?=
 =?us-ascii?Q?V0fglZBZl1JWl9kNPEL781DaVw958yUpVV0mXYCTyRPJtBpVK72NB4FC9ygZ?=
 =?us-ascii?Q?beXEXZHiuZral81kZHDCKuopLFLHPiUByxyHJtGjPfSJBVOwU4aYqgkCk50p?=
 =?us-ascii?Q?0ZbcgIwJ7lPjvqVQqFP2LAxaDvrHIjxE8ctmQ6upw8BqbPUen35onYDVhzJ+?=
 =?us-ascii?Q?5l1corpZvStAEj8KzgNtcDcpYR5R7loaruQCraOLUgNOP0dCfp2Kj2ZW6PK6?=
 =?us-ascii?Q?WZbsg5d+3bIi/aI180uypbriEI9EsTUHHv2XE4kCuVOupOCZrtkgjmzFCIbV?=
 =?us-ascii?Q?3snXOP9UVIplPz0VRFZyyP/48PbTQpTortdC2D6hI87k5R23RUtocH0EwOgG?=
 =?us-ascii?Q?pqTC56x+Ldp3ylq0yWqRrUWRNT6RRR3TelTr8dFZpXre6I33/07phRYfksZX?=
 =?us-ascii?Q?u2yu39UbpDyz5xKwyQ4G19auew7YfDGc3z2WyVig4ZfwpfpMJFAkA3VVW2oM?=
 =?us-ascii?Q?IqQqbivQX3qIS06vUM4Q0V24e1Nhy2zWxXDq5WVQWUhVS8jRihyFd+Z7YBZA?=
 =?us-ascii?Q?TCr8P3Rha2zqm04776rr7RW/ILu3LizEczlpJs6ATZ6XUif2m8NtxWmC8zXo?=
 =?us-ascii?Q?09YpSBcVzdS9qih+WnQ5MevrLv90osBKVXmeHe46ybWNQGorxQMalv3TJSVP?=
 =?us-ascii?Q?SGSwTZDnEjS9Wl0t+mQr/9xmDvvTpK7/rbA2YutamQxzwPO/K2uqi/ztvMJf?=
 =?us-ascii?Q?Tl80g2cmLz0uPzecGTA57xjUUP9cQRlLExiAkt85a5PzfzfUgGxKi1nEpbV1?=
 =?us-ascii?Q?nPU7SEPHL7+4TnGe/H1Isfyy0w6Wa70hpg7UsN3iod46pf2+tTuLOtYsjzPo?=
 =?us-ascii?Q?MC8hj6eeap2AAvt+h/YiiewYntc6fBhl9fPxc0OhFCEyRhgFl3NKZI3wyn4f?=
 =?us-ascii?Q?OBZLYQKHjLB/WXvp6zAKvGpD2P63tiLL5B2vTKDrsWXMecQDK3WF40tKvA3I?=
 =?us-ascii?Q?3tTMsHtYOBGyUqw0XdKFiMB7vyZeTnl?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: WoqdpZhd2zDRaIYLOZHODkzM56H+sIYtjlGAzJUZSg97Gg7iTODI2KZJ8OL8aE6UnCrPUof3aUohqcshpRGX2dAx8Y7SKXVA2LiC7KXkqiEk3Dx1D+y+dgmmx3f+bxmg15R9lcrSbxNR/4vQOqRUiJDTJQrms0kq7P0QuWqpEF8+uv82TI6joEmCmUUqcETCFltcvbnANY5S6PQELnOt7gYjw0KJTn7WKz/vV9/wELjy02YBXYlJcpjvP9yrHckBya1YPFhJNgnz2Hod5pzkIkaj2R0SXUgkNJ17Qw2ON+ybiha/F/IWjDW/2RLf009S6MGKp5uzPjI2QWTVDrbgsCxHyh2y8Tk2KS/YuZXUqmBrEN+aZ+cH7cA4SqTMdBelof/Ual2qrYV4o7ixvH7zFYqsHKRve/rTeNS3VMzyiqM=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3096;6:mlY9SgTlDbiTeKqYAvRLtnTvv19vnmTpUsYzrQ9RoZ2Y7Ys0crhnfC0V192glsKv0nyAP9WCmvKT46un70UhmF7nVZB15pZcDjP1hpELo18IpTJ8YMAuGpKqFio2qVMhx1JQ2/pViQEGf7ixPXPl5L69X6CWKMwZcBM9i+JjPpsB08ZrhBvhZk0bLGTzDl5eJcAQvhG6ohPnCjgnUadJT9lmgapau+x9B/NeLO8XS+ssWrq7MXttYCxscgP/DJxYjUCToDWpSHDKcakom3AOEiJIvXpqJi/iO6+R+55ojn3Qap1aoSIZqww1fnlzXmVgv5gLjPQeqPhu2Fcq935rVCXdeajVgwpHlwA2LoZ3YUNPxET5B//IcpAwxmFeoAbsYpRASu1HfMlcvbLY/+oDcz4f21ba25koebiZufmhFH0cMN9hkzTUTjZfGh5T7GHBOto3vmX3ODXIV62eqJ6YYA==;5:bRLg9cOzRCtJHNzMOTxCsjrmvIrHGL/8AiYzfsr+KcRueQTTUk2RehnsWoX47uLgDOzRUeeeCZOxqoDU572kkSrA95UbvGJfQAGgEE0YNZ+aJkQsZLfxm7irGHAcYzHPlRijzzfIWKaJW8ruH8BU6gM9NitMYZHnrdZd/j359FEFG+/l8gQvYgMdnWfmPLAEcOpnlvbTLRVScXAJ0nXS1g==;7:6xTtc4N2hKgIH4uIvV+cI5xkRb6ekJiaU8c8T7i3oJ8IBCPlCNG84gJW48kS/yeTThg6fqbvz5GBmRUv4F3HFj6JgBHvjsDrWwLmCQaLTZ7lwZoDcz0hEYyWN5t7bxeFl1lmGbCdP+UhPmUIyxc+0Q==
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3096;20:v79iewGuBcMTHsuWLyWh7k6kJBANfqhZXtpEM8z9vD69rvYfLfKWoHbkC0TI3NVGaur+S7bWJIzHzVFSFgTFtLYqkns2jcZVvecAUM5z+ONOWb44yukVfxYD5pj+edbAiCp7suEqvivXiFENtZS/xfPdRE4xav63MIfr3+9rQS527sEUqcm5a025nTahHQ4reTXLb7FzzNKFsvgeVChJsEIgf7+LIIEECJIuI6W3y7x+6MXFQS9wCCc/T9hNYw4c
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2019 11:53:09.5459
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 976eadf5-7dd6-409e-4e52-08d68772abbc
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3096
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-31_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=664 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901310094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch adds usb_decode_test_mode and usb_decode_device_feature functions,
which allow to make more readable and simplify the
usb_decode_set_clear_feature function.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/common/debug.c | 83 ++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 43 deletions(-)

diff --git a/drivers/usb/common/debug.c b/drivers/usb/common/debug.c
index 824b3d793745..bdd529a686e4 100644
--- a/drivers/usb/common/debug.c
+++ b/drivers/usb/common/debug.c
@@ -29,6 +29,44 @@ static void usb_decode_get_status(__u8 bRequestType, __u16 wIndex,
 	}
 }
 
+static const char *usb_decode_device_feature(u16 wValue)
+{
+	switch (wValue) {
+	case USB_DEVICE_SELF_POWERED:
+		return "Self Powered";
+	case USB_DEVICE_REMOTE_WAKEUP:
+		return "Remote Wakeup";
+	case USB_DEVICE_TEST_MODE:
+		return "Test Mode";
+	case USB_DEVICE_U1_ENABLE:
+		return "U1 Enable";
+	case USB_DEVICE_U2_ENABLE:
+		return "U2 Enable";
+	case USB_DEVICE_LTM_ENABLE:
+		return "LTM Enable";
+	default:
+		return "UNKNOWN";
+	}
+}
+
+static const char *usb_decode_test_mode(u16 wIndex)
+{
+	switch (wIndex) {
+	case TEST_J:
+		return ": TEST_J";
+	case TEST_K:
+		return ": TEST_K";
+	case TEST_SE0_NAK:
+		return ": TEST_SE0_NAK";
+	case TEST_PACKET:
+		return ": TEST_PACKET";
+	case TEST_FORCE_EN:
+		return ": TEST_FORCE_EN";
+	default:
+		return ": UNKNOWN";
+	}
+}
+
 static void usb_decode_set_clear_feature(__u8 bRequestType,
 					 __u8 bRequest, __u16 wValue,
 					 __u16 wIndex, char *str)
@@ -37,50 +75,9 @@ static void usb_decode_set_clear_feature(__u8 bRequestType,
 	case USB_RECIP_DEVICE:
 		sprintf(str, "%s Device Feature(%s%s)",
 			bRequest == USB_REQ_CLEAR_FEATURE ? "Clear" : "Set",
-			({char *s;
-				switch (wValue) {
-				case USB_DEVICE_SELF_POWERED:
-					s = "Self Powered";
-					break;
-				case USB_DEVICE_REMOTE_WAKEUP:
-					s = "Remote Wakeup";
-					break;
-				case USB_DEVICE_TEST_MODE:
-					s = "Test Mode";
-					break;
-				case USB_DEVICE_U1_ENABLE:
-					s = "U1 Enable";
-					break;
-				case USB_DEVICE_U2_ENABLE:
-					s = "U2 Enable";
-					break;
-				case USB_DEVICE_LTM_ENABLE:
-					s = "LTM Enable";
-					break;
-				default:
-					s = "UNKNOWN";
-				} s; }),
+			usb_decode_device_feature(wValue),
 			wValue == USB_DEVICE_TEST_MODE ?
-			({ char *s;
-				switch (wIndex) {
-				case TEST_J:
-					s = ": TEST_J";
-					break;
-				case TEST_K:
-					s = ": TEST_K";
-					break;
-				case TEST_SE0_NAK:
-					s = ": TEST_SE0_NAK";
-					break;
-				case TEST_PACKET:
-					s = ": TEST_PACKET";
-					break;
-				case TEST_FORCE_EN:
-					s = ": TEST_FORCE_EN";
-					break;
-				default:
-					s = ": UNKNOWN";
-				} s; }) : "");
+			usb_decode_test_mode(wIndex) : "");
 		break;
 	case USB_RECIP_INTERFACE:
 		sprintf(str, "%s Interface Feature(%s)",
-- 
2.17.1

