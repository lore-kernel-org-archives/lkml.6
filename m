Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930ABC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CF8B21841
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="mFWj2GaP";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="DFxfkpir"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbeLRQLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:11:20 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:57358 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727137AbeLRQLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:11:17 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBIG8kKE008745;
        Tue, 18 Dec 2018 08:11:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=DoCNLXwKYkhNsxQZhdDQ5uZZ3MLBxxWJs6aInNA8vcU=;
 b=mFWj2GaPODOozGoIDp1gnAcOwdA1Y7SsX5D3C6TeJANxN1LCH+Ru+T5xiW8g++l3uC+P
 OYKYg2hPQCU7BH6C+R+JiIpE0Lzg504nAOlJk28AKElAOPocStbQVF96Txu5oqm8bnhP
 n4RlWEjlEmB14AEBl7iwVTQ9rUTuS2qkYGZfa4HSJmNjTY+SvoHiSyxF28GxnIMzPPKP
 AnItiAPbh6dMqzfZQKk0UCB86O+dGy6dBahxQX86DUJ3U4BtQbgFFVWcsDTwjbeyngAx
 gDgXKkZ9AT7ZKmjP9RIfJTTgazu3Vu3J2YVYZZJgZw+SGgOWmg2ksTYeNtnMNyS8gwN8 UA== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=jank@cadence.com
Received: from nam05-by2-obe.outbound.protection.outlook.com (mail-by2nam05lp2056.outbound.protection.outlook.com [104.47.50.56])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2pde96dahv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 18 Dec 2018 08:11:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DoCNLXwKYkhNsxQZhdDQ5uZZ3MLBxxWJs6aInNA8vcU=;
 b=DFxfkpirXNyi3xI8Vede76lUJumjJVbPY128EWmeG04+TD8Ec+/gV4ma/ve4jUQKt3UKkZA2xeFMnITPNfrGiX647EODN6cZHXcr2i7HqOJ7/TyGb+bivTT3jMZ2nDNw/39HF97hbqEyLT4U/8D0gV8URjgt9SiHeurmw4slT6c=
Received: from BYAPR07CA0001.namprd07.prod.outlook.com (2603:10b6:a02:bc::14)
 by DM6PR07MB4412.namprd07.prod.outlook.com (2603:10b6:5:bf::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1425.20; Tue, 18 Dec
 2018 16:11:01 +0000
Received: from DM3NAM05FT006.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::200) by BYAPR07CA0001.outlook.office365.com
 (2603:10b6:a02:bc::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1446.17 via Frontend
 Transport; Tue, 18 Dec 2018 16:11:01 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 199.43.4.28 as permitted sender)
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 DM3NAM05FT006.mail.protection.outlook.com (10.152.98.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.5 via Frontend Transport; Tue, 18 Dec 2018 16:11:00 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id wBIGAt4A031456
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 18 Dec 2018 11:10:57 -0500
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 18 Dec 2018 17:10:57 +0100
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 18 Dec 2018 17:10:56 +0100
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id wBIGAsin016818;
        Tue, 18 Dec 2018 16:10:54 GMT
Received: (from jank@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id wBIGAsFv016817;
        Tue, 18 Dec 2018 16:10:54 GMT
From:   Jan Kotas <jank@cadence.com>
To:     <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jan Kotas <jank@cadence.com>
Subject: [PATCH v3 1/2] dt-bindings: gpio: Add bindings for Cadence GPIO
Date:   Tue, 18 Dec 2018 16:10:41 +0000
Message-ID: <20181218161042.16366-2-jank@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20181218161042.16366-1-jank@cadence.com>
References: <20181218161042.16366-1-jank@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(346002)(376002)(2980300002)(199004)(189003)(36092001)(106466001)(486006)(2906002)(446003)(86362001)(50466002)(356004)(6666004)(53936002)(305945005)(5660300001)(105596002)(26826003)(47776003)(1076003)(107886003)(48376002)(4326008)(81156014)(36756003)(26005)(16586007)(316002)(69596002)(51416003)(186003)(87636003)(478600001)(476003)(68736007)(8676002)(50226002)(2616005)(8936002)(126002)(54906003)(76176011)(110136005)(97736004)(426003)(336012)(81166006)(42186006)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB4412;H:rmmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT006;1:4E00ihAEckFdJXgoPWQ4EG1m+uZFmHL4QdmVjw6Mqm9W20bOWdi1uTRe5qrAjEksDeJPHIIhNplth/VPfJUyD8jIStJ1EGOYM1j5PamWe3kdWf71E1wWoHT1po5p5EWN
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5798cbb-60e7-4429-7d34-08d66503672d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:DM6PR07MB4412;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4412;3:/hOA32vvRN12hCdWDBQMXF+ds/Maw1+TkTuedLlK6FuVVgWLJXgtyRaGBD/gQm0O/ld4g1jeI0stVunSh0cIdGJrly/BwjCXTzXRWNEOziA2zAtTKFBL6mtB8f86uHPoFllgmPPL1qIyGoRumAhpMm6Y1rDsTnan623ceydFz/n5+jSsyMAosYr7PmDAGWr6MpNkwicuijsweGe6ZOBMiYnjdl0i/M8K064IAAeL0g6JaHufnyQ4wr1reOkU1WOutJnUGWjBFnXCjCkT9azFtB7IhC6OYcI9mKhbdfD4epK8bhzC7J6eW+AT5htIjCzvkKCubFzT+dbsSKZ++pwJUA==;25:ijhhDByYW/1FAz8LYzfoJs6lrRYXorbqez4LZmgJ/1Yg/ZC+pH1kAi+Z+DMC764EuONkWuVYViJtHm272H6L/HaEsr0V4c4IeIQYuCX3ExbmZ5szJo+1oE0ijgu4VkrVhtvc7shoG+XHwXHjP32DH7LIheBqgrrHzZhORn8DizPix+5Iie3spLmAbl6UcUMLRq1M5GkoJ4872S7PNqmnHic2ttAlL2A7PCdp658sN4RPskU+VCjkBI536ZX5zFAz+6fjxxxfLI17hm9nAIc49urMpDa958to9GL0axBkSDDDpfIrSWbbCfekr03YgpNPq8GuxEtrxFf7pmIz402xcg==;31:ejVPwkIR17XpdcEB7gjBs/8j7DNOR1RzbtJT12q18GxC2JEm2B+MlqgIRmsbzXQYIqgV/CLYj19vLb+DF0aIhaSIyRSohG9JBVqBnL9Qv7LXdbegHgen8LwJKqVmPqVYMyLctbg9bihfkoYQxQ3RyX/9ZJE9Rn0eIiOX+PFG0Ip0eiUrJNh8D+1VAq6Se2bmuahut77Xwzq2KFxwVmtsvBnWgKW2BPeck/7bjyfwfZQ=
X-MS-TrafficTypeDiagnostic: DM6PR07MB4412:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4412;20:ovdN72DscFDxRHsUON482H5Z196rF3l5p4s5qEPsZ6EUc9pCfFiDh6VWgHMV9ugQnuEMre0ShTsLlA6VdNYDDrx0pKc/bo/9bvg+xnPpPfY1xfmGy7/7ZeMDmCuDwSiMJoHC7uZfJB1jqAg3oHNJIPVnfbCKcJxQhhcJGEQtPr+5v+f5b0n/zWw5s2SzBqchT80W6nTk7vUe1n7xJzfZs5iOQRCXfV5tVAmEJsgOjV+PwrS9ZlNycXLaxf6RirBgHne9hU5X045zCAeXGBeo+4vYO17HRgw8jTcvc6Gk+lUWeoMhglIB85WnPCuit1vc4sm0T0pnYSZDW6YW0Tsj4RBqiX15J0j2lF5fTjIYkxz2N8H7K3cweJQipjL2BWl2nqBKdIPtteM2X2earSV/+keQ8cGswb9m1xDnRI2NWErgGxuhPm0L/+ylCrU6g1Ei98b98SfsSBnNyG/HoMVnUxhhlCw+ikhUN4QNmDRATTRqiHQTm7/nMYePuIAcvOx5;4:jiyNFfmYjKiNLhnOwSNhPik0Fycctq2+SvvIMWM99efKY5IDhaqh9gb9DT01RKrvheDvr2iCFgEcWuYnlbOX+xCnHAj4CSUpenHfxVxEUSJggAO5AiU7V5eFiLD7gDdHOqUAEZQTrCOTNf0DXxDELFljZxiDP9HqrqCCQYDseH0boNiyJANeOP1t8ROajFDFruHj+U8a1thqoqDeEIq3ErclxrccxLm2v2jM/CqB4DJMMuvP2oPg9a4yvkV8jXNYTu6j2wA2MltKf3sHyK0KwA==
X-Microsoft-Antispam-PRVS: <DM6PR07MB441203BABDAED93BAE860B69D0BD0@DM6PR07MB4412.namprd07.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93003095)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DM6PR07MB4412;BCL:0;PCL:0;RULEID:;SRVR:DM6PR07MB4412;
X-Forefront-PRVS: 08902E536D
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR07MB4412;23:oeuvCsMbW6Js0+qyw3sVTwKTla6zVWpIyzC5uBL6k?=
 =?us-ascii?Q?a5rvEcpdk32uVhy0v3HGyFrpgeRQ5RDAUT6/A51Ejmbx9esHpLYKzcCYnGrK?=
 =?us-ascii?Q?ZymZOO9j4yUrDkgItNDzaEBfN6YxHaYx2FXrG6feNT+n7cywT+l2Es0kFDVI?=
 =?us-ascii?Q?N8e55f8chkDL3Z+mxfXWB0VUMi+LqHmFR5HcmyQXJONP9D1ak7c4YqWl1LXQ?=
 =?us-ascii?Q?EfVQXsEYhZJXINwxnrb2Ex0jC+/s7uJOemGFLhf1QHb/UeoXftAbmu16zoBO?=
 =?us-ascii?Q?+bbrMLQDr7iZlDbHVmrb4m9prZ3oMEDi04ATTH4W91we7lXZ8DDeRnqSVoYq?=
 =?us-ascii?Q?HrbVaqdWxBL0Wpo7/6Vy/aiIBr22gBpgJPoCd61QJmKYc4k89CpXoIlnkKww?=
 =?us-ascii?Q?KoEEcOoal5jRc/oxgniOrCdphvDURSPg1RNA5HVLAQEUG52jNmNF5rd+w8D+?=
 =?us-ascii?Q?Ql8iJCyTs5o/TbofvKIX27fB9R3Ivbwr0aqIvmgBlv6tVPEp0gCk/daz4YQz?=
 =?us-ascii?Q?SaWmlC3jhtPpVr4DJi+slB9TIBzrvt6DHK6q2JNaFIlB7sMiK9VwB5F6m6V3?=
 =?us-ascii?Q?l7aqQp0VdqE4B3wnceBpu22wYVIZtVmx6+GoGiEAIfDs/gv+YNk1LfdANFzU?=
 =?us-ascii?Q?Q/ihAEDTfqzttzenSeUkRFh5T7Tisd2TIUccGIVeDt/2Ro/rJJjzPFWOvLHQ?=
 =?us-ascii?Q?uDoEqx4pVa3782pOJcMqsHy55wIW0CkdGCEpiu1XqUsdvTHa59dlKpbSMZCS?=
 =?us-ascii?Q?urs/Z9vhGr9Iet5ABoc2xiMrSUU81X5QUSX/aM3VRwYO0G0zajVIQN9aFuUB?=
 =?us-ascii?Q?iKw77Z9GjDEnm1O+ull0kQ7G4B4qJga5xMMwsrU9s5/85Vb9bOJoV11roMHt?=
 =?us-ascii?Q?lOauSOVGPNFHp1NUMJd55czp9aLTwktpC+ohNNXlcNa1Wt53VLrCeVC8iiOx?=
 =?us-ascii?Q?0/SRvpQ7JsUDurhV6mQwBgagEGOFi2wop0XQht3lzulEXQZ2gLWAYX4vZHjx?=
 =?us-ascii?Q?tAM26tyzAQaFgGHQ2/+8cVVNHwWEE4S7uabE5DbrJA3JVN9lHAfQKHWicJAw?=
 =?us-ascii?Q?oCmPTO7u6nMOJkTs2b/zGUf57Gn3jhxz7S0vaTJUDtPwZm72vQzcl2DfEJw7?=
 =?us-ascii?Q?poDnS69HSguCzgJD865gANDmQ9+ura4k41JV1iFDwSOIoSYow/a9lS+6gSQ7?=
 =?us-ascii?Q?dN45dQQ8wRlNqE=3D?=
X-Microsoft-Antispam-Message-Info: /Pb+baM2kFEqL2zLdXfVchAe2iu90yqltKaikHE8X3eXZnpDK/14jVstKMwwxjXEkT3xA6l9BBmc7L0Eey6EON/kHD0/FDGzv3F7o1c01kW4++U//Na/GEOisNoxGgAwh+KmZfnx6fZK7Gb8GF9OLmmXWAgn5wgQbZvP3gRrONnF0gYdsbiN01sPP6vw/R8TA7rde2FxoUGY+nynndVPNoJTIYJzj2FN4Tra08G8Uulk/pBxwQP26i/RHW8ksbceIg0PyA08FKaZOFs+mY2apIPyoVqWbD8SuoTjDMtv1p3pj1LXYpqYKQuTThENWHXK
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4412;6:+vieLjD6Cn3CB5XuZOjSGUMXL6bUlqvROqVBXEUJhr6TdgYnkxdP8Y3H8n1bAxO07UUJ4KKI0lW7y18RP2/DKCzomJ9rfQT8brKQjx3hGA2WzPJ4LFSx4dz4LAaXz57ot84tO7NKR9NA8ODFSuCdeXlb7fAOz/lA883HCimSAYpL7SQfzIm7GlmOpeI3P4rdnuFO7RfTMKG+JirZEQwVhqGQWib1TBBXLt/HWI6HX26kqo58PpaYVbESP850L9U3Oi7U6VcmOrixqygYwm9teo95Sa1hjzULNsJ2o0/wclyehxA7rXZOyN14+9VUN40Kgfy1eVTqCHbokSH6l91PdI+h00RyLJdnH+ifsMNxXLjywMWylEctLHasCjKE1Gx8rLsvbU9Bkz47xlmfsU/VsCOvtplerCWMeXh2N8SexKws5M+iWg4MkSqmCZ/nrU1QgMPLNjYCRVYYT02u9zcwGg==;5:z9vn4nPmvn6PtkgnvutBbjtnsOEqKQVUhpdCkkE9O4h2koqS8YeDMsvxbTPxnZxulm6SYoSUJ7wkDgzSGURZiZJizbu8dzat0SptXBP3NrczNM1jyCuDJidrQsJv6h92Oj1vqbdaaJ27rF+CdXSE4r+W6dPrU6ntbUQFoHYkGtE=;7:YFafUkvKDs7Ei9UEUCmBDSsSBATkz+b64TSbkAjSaxKenc2+z+npHpE288Nm3kN3wOlpkfcOUNWlrhrjqNqO5mNgkvLw6IvPQYb78AKMNav5ruSYwehepi5Edpm5ljyABOHdXKRaniRDLWxrOOoP8A==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4412;20:tV+YlRhrBpDa62FyzWs9kfqYcy0ipPVwwklDZT8KUxBjNbkgTeTZShcoVIEOqCwVT0WEeUVgxIdpBBzkU878hu5OMDMq9C7xVp2fJaL8SbvYpJGsoDtKGbaomJmhXdwQgFvgTmz5/06u/TEZF1n1u8gVVDK/WjAs5IMp/h7hhOt2ukFGcCVkHb40MfvjJyDSGh5MpJBF6so79ehsS09ygXDtl8CbMIQQ52BUOke6HQP8tVohPjoCtl71qZmHHySd
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2018 16:11:00.5626
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5798cbb-60e7-4429-7d34-08d66503672d
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4412
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-18_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=523 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812180136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a DT binding documentation for
Cadence GPIO controller.

Signed-off-by: Jan Kotas <jank@cadence.com>
---
 .../devicetree/bindings/gpio/cdns,gpio.txt         | 44 ++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/cdns,gpio.txt

diff --git a/Documentation/devicetree/bindings/gpio/cdns,gpio.txt b/Documentation/devicetree/bindings/gpio/cdns,gpio.txt
new file mode 100644
index 000000000..c87a47827
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/cdns,gpio.txt
@@ -0,0 +1,44 @@
+Cadence GPIO controller bindings
+
+Required properties:
+- compatible: should be "cdns,gpio-r1p02".
+- reg: the register base address and size.
+- #gpio-cells: should be 2.
+	* first cell is the GPIO number.
+	* second cell specifies the GPIO flags, as defined in
+		<dt-bindings/gpio/gpio.h>. Only the GPIO_ACTIVE_HIGH
+		and GPIO_ACTIVE_LOW flags are supported.
+- gpio-controller: marks the device as a GPIO controller.
+- clocks: should contain one entry referencing the peripheral clock driving
+	the GPIO controller.
+
+Optional properties:
+- ngpios: integer number of gpio lines supported by this controller, up to 32.
+- interrupt-parent: phandle of the parent interrupt controller.
+- interrupts: interrupt specifier for the controllers interrupt.
+- interrupt-controller: marks the device as an interrupt controller. When
+	defined, interrupts, interrupt-parent and #interrupt-cells
+	are required.
+- interrupt-cells: should be 2.
+	* first cell is the GPIO number you want to use as an IRQ source.
+	* second cell specifies the IRQ type, as defined in
+		<dt-bindings/interrupt-controller/irq.h>.
+		Currently only level sensitive IRQs are supported.
+
+
+Example:
+	gpio0: gpio-controller@fd060000 {
+		compatible = "cdns,gpio-r1p02";
+		reg =<0xfd060000 0x1000>;
+
+		clocks = <&gpio_clk>;
+
+		interrupt-parent = <&gic>;
+		interrupts = <0 5 IRQ_TYPE_LEVEL_HIGH>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
-- 
2.15.0

