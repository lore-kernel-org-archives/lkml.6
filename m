Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80533C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 448E62177B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="jZGiPvlf";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="CJ4K3htj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392085AbfAKPOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:14:47 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:37658 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732584AbfAKPOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 10:14:45 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0BF8oPP013126;
        Fri, 11 Jan 2019 07:14:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=NWesqUfIA+mE3K755IgmJw4x7JF/WyTASlo64KlCvxg=;
 b=jZGiPvlfWyNVW5nDGSrqheyl3JO0f6l7PHxGn6CMNl48J7JGi5NOJy14EMCOzV7CwtY/
 v2Mh+QzS43Iun4r8WOmC73S7+jqGNO5ezWyWeTYF63RNY/p0kksuwKGZiKPc90vl6aoQ
 fkQscJT20NZdthIlF+XaaUhPnC9iRUPMxfPbwVoCR0RJeL7RdnTrYDlLKgnns4Ajpxdd
 B+okro0Gv63oivo8msSxXgiM7rR7csWU6MnQgaI4HBxh4S/HEdp30Ecwa6TJhI7cxfFl
 BmDAy36j77AtLaiCSYcg/cKgSHYxcHZLBEkkaYDoHCnwQ67SWlmI9DMo9/JouSQAWit9 xg== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=jank@cadence.com
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2050.outbound.protection.outlook.com [104.47.45.50])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2pts22dryp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 11 Jan 2019 07:14:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWesqUfIA+mE3K755IgmJw4x7JF/WyTASlo64KlCvxg=;
 b=CJ4K3htjO7syw5yg9/aGQXQuRg4yTYr4lBuVeWnfZxP1/96NzrqiU/G97Ce0iR0Marzfk9OJLzTjwb6KohyWfybgqx6aBXZu2cze+tZIw/bta7xeIbt24z6GGmfC1mUpp5MGFeL+woLPOlUA56GWcLRtK1/hJO44MZKfdUkyP1g=
Received: from CY1PR07CA0027.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::37) by CY1PR07MB2168.namprd07.prod.outlook.com
 (2a01:111:e400:59d7::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1516.14; Fri, 11 Jan
 2019 15:14:21 +0000
Received: from CO1NAM05FT013.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::203) by CY1PR07CA0027.outlook.office365.com
 (2a01:111:e400:c60a::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1516.14 via Frontend
 Transport; Fri, 11 Jan 2019 15:14:21 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 CO1NAM05FT013.mail.protection.outlook.com (10.152.96.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.10 via Frontend Transport; Fri, 11 Jan 2019 15:14:21 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x0BFEHAA001005
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 11 Jan 2019 07:14:20 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 11 Jan 2019 16:14:16 +0100
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 11 Jan 2019 16:14:16 +0100
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id x0BFEFqZ025518;
        Fri, 11 Jan 2019 15:14:15 GMT
Received: (from jank@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id x0BFEFAF025509;
        Fri, 11 Jan 2019 15:14:15 GMT
From:   Jan Kotas <jank@cadence.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jan Kotas <jank@cadence.com>
Subject: [PATCH v2 1/2] dt-bindings: rtc: Add bindings for Cadence RTC
Date:   Fri, 11 Jan 2019 15:14:00 +0000
Message-ID: <20190111151401.25047-2-jank@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190111151401.25047-1-jank@cadence.com>
References: <20190111151401.25047-1-jank@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(376002)(39860400002)(2980300002)(189003)(199004)(36092001)(486006)(26826003)(86362001)(26005)(336012)(50466002)(6666004)(48376002)(1076003)(356004)(5660300001)(476003)(126002)(51416003)(105596002)(106466001)(76176011)(16586007)(54906003)(110136005)(2906002)(478600001)(87636003)(316002)(246002)(42186006)(8936002)(186003)(107886003)(11346002)(2616005)(446003)(8676002)(50226002)(7636002)(426003)(47776003)(36756003)(305945005)(4326008)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR07MB2168;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT013;1:RgRQjHvq1AhL5x45hU+cGpjibb1xyYFdtfwpNs+h+k2szk/dBUw+t+7f7lBkKZbGqk90GxAhW4sP4NdMghN7t7voCeiMPpGLPah/lJ0zvJ3ies0R1Dy9jOXMV3s53Q/Npv1QigGHL7bjDcrPYy9lEw==
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 870b5f10-07a8-4f6e-b549-08d677d776b6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060);SRVR:CY1PR07MB2168;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2168;3:DWxUvIcETKjjRElXpJcUCqEyqUF3tqaVEV2Cb8qbn5pZCoaPR/84gK1Fb+FhSe70dgsfDPHFUxwukymcxrTPh2Xkg/anctS63t8zD7RNvafIaV413ATs7xe8Tvd94ukZDDTO9UHnrQRO9AQ88++kzVNxuwEBKnCvD9bG5muzswYWonvN7JxiCsBlR5xJ8np8J0wZgDH9X8bFgXxP/h58eZOH8fEc+zb6opHnH1nuIuWH9dPZQkQn7NZuwlHGWpVp9OC4Qgxagc3kbW8DL2HYNOsfMbwOPbqvDChe91CbMt7wE8rAqVUxjXs+Lki2ugZz0a+WXCeaZyhmNyMfSfwhQa2re/crDVGWF4E592248itS5IdMV9zQ2+P/z9Hh+mKQ;25:GogK35Ixz9F3VIK379wDdxNwZj76FX8nRUE54P4FhzPl1O4/PzmkMnmzS9KEhnRgxIXrWaU6PnACM7TIr12yfzS6OU6r9iPU9uG04/N+7fhAOGv7w/B77z/XG2hQwSNqEqtxVMk6rGntZjmAEOvJ8Zu4cpv+PM4sODIK8kkdcP9vlIvOqAvkMwQ8F1B3Zvpob5FE+MPtscUT5lZ7KQ8UGYPnbwrha4liKK0zh2SBlqNmOQec9RMpBkxp2zrRwi1YauDMR2KPK+XyM++4QWNzV5rCs9S8uhPqisZo8PDBl2b5plRvw+6ixuS5A3yJvIsuBK4SsM5kEX/b3SX7MmdePQ==
X-MS-TrafficTypeDiagnostic: CY1PR07MB2168:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2168;31:EHTSpr/B6sLWmMSBVGkEpqWLaCmwihrHQL68EfQiblcOe5CQr1IdF78ovPDUGoey6ZSungVasetwxDPZz+aLFXccHU5mcDcbZAUrO9EsUUr19mYA7P9aVnRGvjJd34VwWUCepjsOYBdpCe76NbxvdLBDIMhyw5sacQOBh9699Mf+6c1BAjSM7sOBrMPxV6GIfsIxvmIQCKkjW4CTLgev4xfYHeNUmyX+xfc4ciCBtgw=;20:yrPvlX0KFdUuUiX4+knMGeNcZdYTmpLiH6q2iqsNTfG5wOy73GmOievhfrwpM4B/9oBo8o8/czD0vf7RtLFS1g3hlnE6FlRdlsOoO1rYScElHIgYcB7KOCYtrGnAA2GS6eZ0QYoAuTL/uIy6Wkua9R6Sd22hyLgSQ7L4xF4Q2/UUW4GwdmoIcShDAtAy7zVVKyZRHLEFXSW7hZTMiRUFahRtpaIKO2aGuNjsYOnM4rQLjMxOxxuUyi1I9q37/4wmsX51MbU3GXftPAG8fqLsJi/WS7fyXlXV8Zh47XsAzBEymP1Xdiwz3MQGHgt9MAe8SHjnJqQMqlyxyJuZOZcynFq6mRyxW/g3IbyTcM0agnwgs6g4bPAeWrT91wnyfJGvTy0TChK0i+f+90cgvUXORVIvX8olaquCZjA0gN30DmVgvvqyr3iNhIxCFmRYfcoctJwWboioESy1LxjI6f4/zECrpJE91EnCj3z8gA4+fjcolYywPHu6flHEW4lxAtD6
X-Microsoft-Antispam-PRVS: <CY1PR07MB2168C88DA2A91D7DE0AE0270D0850@CY1PR07MB2168.namprd07.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2168;4:6wAaK6Pm0E9xzHGBzIZ4vvYING1GHbE7h7nG+hHLUtKLpwzihtszwR7IgKKlUPXwmXNFFJJvp76OTYuuy5+YaEP/42VlcTjSYDeDKr79Y62kg2q32kdbr2fsSqgYMY94bvWLyvnYnWTHrQZsGJiniwWUlfhv69yfw8qTqiwDS37x59SUjfS8zYPXM77dcyGOL3Zik4pi2xe+kNdSyJdmfbvquZPyT9I9RtRPn1Q0scTvAgKxxEvS9yXbeacir55kUG9/mSoWOnWcI5AV8PLi8fEwoWV6kmuRjRteYLS+mf4=
X-Forefront-PRVS: 09144DB0F7
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR07MB2168;23:rXzqYNIScpXHoLXnPD6Xti37H/x9kbNo4oqQGFUH2?=
 =?us-ascii?Q?p9U+jb4OC4T+8/ogl1FUDMbgxfIBqCOIqWpWBb+FjLDG3l0kXFl/DhV1TEKH?=
 =?us-ascii?Q?X68tKJwTwuHcmB4pCk58wuk00jj2z3jxj83ANNtfuvxB36yLc5GHo19p1ddp?=
 =?us-ascii?Q?V3PXVMQZG4g/EJiPHBOU0CkGhlP8bITqbT5AX3AgbgnSu1JB6tyiIEfpQpwg?=
 =?us-ascii?Q?Tz/BnZxWHeeADaWh2XIeSjmkthgGhYIvMIbnM7M2rQ83g2kwRa364eKUwHSm?=
 =?us-ascii?Q?A8zy/rkO55F4MzCAwKwMQyTtCYT7fA7h4HC6ZoFFYSpE9kk42EUuSy7Px0p4?=
 =?us-ascii?Q?6US26tCGhg4IHfq9TMSEtCshcCaIQzQkMtXxB56bY2NB3KT88EzCN/7j9iyf?=
 =?us-ascii?Q?lOvtWjGDus7t2I18wsrpTIyyI4tI9yC8hzPXdO1kzgcUrkYLjv8DPhNkTZ/7?=
 =?us-ascii?Q?Us4LY3cZdDkoMtH5Mle9rTY03Ii/9JR1gpZ2cUS4qRbnhT/Cv4K3ve4u4UlW?=
 =?us-ascii?Q?ouIPj9IDF9cX1MOiUTvK9apeNSrmmY889iEUET0+C/v9DybWOwIFUIvaX0HN?=
 =?us-ascii?Q?MFBk9pRXwbXOKORXgYeUDCQpKRNztQWdbpJTISf2b92OtoWPYUzFwRWIaPvs?=
 =?us-ascii?Q?/JwDzfVQp9sk9tAK5QKuRE6sPP7hqJEfdvQKeJfQU5RYSmsJKu5fjRFJmn+H?=
 =?us-ascii?Q?+15PJmrBYSDQqeSyOJ7wCxw/UiSEdzmwEmDWrfG0No3oRokO8lWyDD+uPXkx?=
 =?us-ascii?Q?Dzmp89ZCIfaM411MHNUTaXh7Ut3QFh3XSXFXXXgnkSvU1kqj/f3gqSdMyBpA?=
 =?us-ascii?Q?uHZ7LHTmmIbw/HbkVLWzYVr0nDxuETrwCGheiida+TcHZAELsP1RcO3GoE1o?=
 =?us-ascii?Q?7hbwk/h43YwB4U9iFAcqZPqgAUFwi4U1SUyG9sdL9v3kylECQ7HJxlmsJ6F4?=
 =?us-ascii?Q?bBk4f4lC8+CJKLViazdP2w63iSdCdA4phrXD1CWUGCz7dE5h6zNgS/bMWXRp?=
 =?us-ascii?Q?fGDkmQR8oDRG/MeOqUz1g2vx4VMrIpRDiN/xMYf+XrOQ+S86ZD6wR8mfCQP5?=
 =?us-ascii?Q?VtOcvgbF7XPQHcKPtqAgTIdx4OM0NeptPZAsYBh+v41IF3F6T5Cnj6gh83TE?=
 =?us-ascii?Q?e//CcNQ4ZM=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: QfQ0EdIzpYs58B0rQseQXuNGsySh/MfoJbj0RbN/gelsgcciZkeCh6CswTZbhXOtToJ5briAU7/7DyUEYA55EG3o3Ia9igehgMFuBAJthqYepAmLbYuzAQ23davjh4RQ0/VJv5/EaJRPQ7xIYvmOjA/xg71nBa30Ad1BcWKQ2bsFcdEhIdwuSZbL49hOj+L9yO+56aqPdXSROpWqikDi+57cP0lb7C3++AXWwO9rdeEjIPaLqlX7p7E2/GKYZMbbkQG0wsdBIQPh+M565KaxR+3JrEqPLeohlNvz0bzDlqHZTlw7zp3l02JzfAOkokqjFGuKltXavPkreUCfIUhI5TT2nviUOnIVwZWcfmhvPVgeNmIn057516KOL7YYV1YJNq7Tvubug1irD0hYprrOso/DZKnBePbG43RyaHQHtaU=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2168;6:CSdJtBbcodvu3Ss7Cp1+NIqSfCw5WoTFJGH9VSeG+2Ll6JOdqmzaQrIAn+L+frPANfCre/SgXY/7Z0v+2yXef1NOiGkKCAlfwb7820QZZdA+KW2k8cZ+Eu8RveWiQTa0UOpNxlRt9K43Hiq6/6JMZc7IBH3Hje96PtQRlUgP0Js+cllY2FxF+sl/KvGW4OKpLA+DQMG77C5Ge+PW7qMGO4hU9npjWX2fPrSxF2XLZ+HdyHtmrIL08uGrfniFeV+w16yrAoC3KODyMZHcURT30qfDsyzlSvxjqVp27owqkysb4dgR4rZOoUiVqEp14Mwzr03TSpJPSkHd+iIQnQCV9IEHXotbE4kaDPL0KclVptQOKc+kfb8ZkmwwcG/Pbn2CZBMm/2gFwrbYo+BJSKwiwrFLe0vtnGBU1dozl12l6mOBxpHow7uwAyqrcZHmc1M56JOLNLTfRsv/4jbpsO9bHw==;5:GCphn0etrFj9jf7+fa91dc0jiayNTZPn8Iq3L/yTXN1M6VrxbdozQiPhI3HmOojmqiC4dF+upbUcC0/Bc6LWDCZY9B6IBYU3DXPdr9cuqZzZkoK1BdCx+6PBQV3f9pMl/1qr+X275MJPSuaAMBSE4EPb9R/usxW/RrV83fz0abuVTgPk4F9Jbba6YTJ8rt34vS3m4imd1zEqanV+bw6rhQ==;7:E4hi8qo8muxfUZtwTCduaUN+Q+SSOFlZ0USqItmEq0fbrBLDgL8VSfLhX3PIbZeTaq6UDj/tCotfIoM8rqambxxNeg+ZMP/a94WRnjax9VNMykz8TTUIh12SvrfIUo+3M7Oq3I5kSlprAwnQfQASqw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2168;20:Mf/loft6SN7+6SmNvcs3TRgND/2ucUH4g01k5XD4ijqg6tFWyDrNqldKGqHWaKJG/Mpkkx/f3axNYg9XOqDu/GHdvkDRzTndGc3fMEX5oWPV2ISkPNBw4O1pa0De5LWulr5YqAfwYx9ig/MKNBNmcuruE63kgoA0N3HKVgdyxEIJeyJxXvS2ysamevDZUD7irRgrou2LcmFaFTcW2xo+2CW4hfL/nrfINeEZeSploe2Kb3oWrBrbbj2zF6P5HhFq
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2019 15:14:21.0363
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 870b5f10-07a8-4f6e-b549-08d677d776b6
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR07MB2168
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-11_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=668 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901110125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a DT binding documentation for
Cadence RTC controller.

Signed-off-by: Jan Kotas <jank@cadence.com>
---
 Documentation/devicetree/bindings/rtc/cdns,rtc.txt | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/cdns,rtc.txt

diff --git a/Documentation/devicetree/bindings/rtc/cdns,rtc.txt b/Documentation/devicetree/bindings/rtc/cdns,rtc.txt
new file mode 100644
index 000000000..40713bbbe
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/cdns,rtc.txt
@@ -0,0 +1,25 @@
+Cadence Real Time Clock
+
+The Cadence RTC controller with date, time and alarm capabilities.
+The alarm may wake the system from low-power state.
+
+Required properties:
+- compatible: Should be "cdns,rtc-r109v3"
+- reg: Specifies base physical address and size of the register area.
+- interrupts: A single interrupt specifier.
+- clocks: Must contain two entries:
+	- pclk: APB registers clock
+	- ref_clk: reference 1Hz of 100Hz clock, depending on IP configuration
+	See ../clocks/clock-bindings.txt for details.
+
+Example:
+        rtc0: rtc@fd080000 {
+        	compatible = "cdns,rtc-r109v3";
+        	reg = <0xfd080000 0x1000>;
+
+        	clock-names = "pclk", "ref_clk";
+        	clocks = <&sysclock>, <&refclock>;
+
+        	interrupt-parent = <&gic>;
+        	interrupts = <0 6 IRQ_TYPE_LEVEL_HIGH>;
+        };
-- 
2.15.0

