Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38EBC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 15:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A72621928
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 15:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="nx30Vd2j";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="ZIgs2yKN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbeLWPPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 10:15:02 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:34412 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729078AbeLWPOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 10:14:38 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBNFEG7x000375;
        Sun, 23 Dec 2018 07:14:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=V7FIBn5+U46OV+GS1eHcIk35DIiRmFdDaz7ftT7o0BU=;
 b=nx30Vd2jcplRzWW9mo8FmcrtonXXg7XzEzq3ozAGXFd28KYzCtPZnqKXfjBKzCyQQyVj
 rIInKiuQw2h9Uf3yFeyfrXd02n0GT5KJ9ophANWv+MMwPnjdTZv7fsA6E/iAnps0i+6+
 odBmFa5fhGoXugpRY9tcyU2T1ILN9V1O4l3IQvzh2H1zGQc9Ra+ELF3faPJwU7qoBHFH
 9JLR0LLqdRofn5mKtKpjjaAlDGfbHH4blIPt/AoBtyriuG3+FAOnZWLPhcI4chzexQPv
 WuA98pgwcLTmc8eHBN/2kfOx/klDe55ju5IwpsSV7TcCCQdGHesPUEuZ8BHqfMJ9Me7R Dg== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2058.outbound.protection.outlook.com [104.47.36.58])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2phjq1n5cw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 23 Dec 2018 07:14:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7FIBn5+U46OV+GS1eHcIk35DIiRmFdDaz7ftT7o0BU=;
 b=ZIgs2yKNBjliAiElD0aUcPC68a3KE0VUwZskPGh8/EQE3Bg/ncGfBDDz6Xgm3KdFMldjXb+V9heavqMhTK3kh5PqeSWOBY8GpyJ3YozOx0sOQdii06FshtVaOsOi07ZKfwhomojzubNdbNRSeuqDvtn+iEt/RPvYWyF5Mez1mRA=
Received: from BYAPR07CA0026.namprd07.prod.outlook.com (2603:10b6:a02:bc::39)
 by CY1PR07MB2165.namprd07.prod.outlook.com (2a01:111:e400:59d7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1446.24; Sun, 23 Dec
 2018 15:14:20 +0000
Received: from DM3NAM05FT015.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::205) by BYAPR07CA0026.outlook.office365.com
 (2603:10b6:a02:bc::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1446.19 via Frontend
 Transport; Sun, 23 Dec 2018 15:14:20 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 199.43.4.28 as permitted sender)
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 DM3NAM05FT015.mail.protection.outlook.com (10.152.98.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1471.7 via Frontend Transport; Sun, 23 Dec 2018 15:14:14 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id wBNFE6He004426
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Sun, 23 Dec 2018 10:14:12 -0500
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sun, 23 Dec 2018 16:14:07 +0100
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Sun, 23 Dec 2018 16:14:07 +0100
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id wBNFE5bh007154;
        Sun, 23 Dec 2018 15:14:05 GMT
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id wBNFE5cF007150;
        Sun, 23 Dec 2018 15:14:05 GMT
From:   Pawel Laszczak <pawell@cadence.com>
To:     <devicetree@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <mark.rutland@arm.com>,
        <linux-usb@vger.kernel.org>, <hdegoede@redhat.com>,
        <heikki.krogerus@linux.intel.com>, <andy.shevchenko@gmail.com>,
        <robh+dt@kernel.org>, <rogerq@ti.com>,
        <linux-kernel@vger.kernel.org>, <adouglas@cadence.com>,
        <jbergsagel@ti.com>, <nsekhar@ti.com>, <nm@ti.com>,
        <sureshp@cadence.com>, <peter.chen@nxp.com>, <pjez@cadence.com>,
        <kurahul@cadence.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v2 3/5] usb:common Patch simplify usb_decode_set_clear_feature function.
Date:   Sun, 23 Dec 2018 15:13:10 +0000
Message-ID: <1545577992-4013-4-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1545577992-4013-1-git-send-email-pawell@cadence.com>
References: <1545577992-4013-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(136003)(376002)(39840400004)(2980300002)(199004)(189003)(36092001)(4720700003)(2351001)(26826003)(69596002)(486006)(53936002)(26005)(186003)(305945005)(68736007)(48376002)(97736004)(2906002)(87636003)(105596002)(106466001)(50466002)(36756003)(6666004)(356004)(478600001)(39060400002)(5660300001)(16586007)(42186006)(54906003)(6916009)(47776003)(4326008)(107886003)(7416002)(81156014)(336012)(316002)(2616005)(126002)(86362001)(476003)(8676002)(51416003)(426003)(76176011)(8936002)(50226002)(11346002)(446003)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR07MB2165;H:rmmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT015;1:1WAerBJckEuRIigVLhKQbT/l1Cr6PO0v0XVa+LU+alvYwogH8wdcHhI++hR/YdWlGqJFIGR+Ua0Zw0C+quQfO6kWtXkTwraAF4F9EG1uEaJbmn+M7DQ5CdZ2Eenn8TLh
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 087ebb61-4105-440a-63b2-08d668e94fd7
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060);SRVR:CY1PR07MB2165;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2165;3:oGn7Qu3pmaiW1IT8uddkZW5VACEYFOZhIxep97Ag9x77ZKQ92qKkXeHrEzgxw8Lubksg+XdxTWTwLjM0hnihNX9A9UQFkrUJiaPlMT6yPsnKq9elI9xXPLX+bfd7IHMJYU3VrS2JiZvfKGNrHDQw0/E8UibCy7AxBvMKbGDBBpYi2jHlO+PxpPkIpiWFzBNJnSk/KYFJPIF9MSnqOb6S0xsregP/BTXUF2ZsHb7SLgXyQqBkaBTqegNInb9IJr0JXoUyjHCMB6fDAoxcMrNBH5AFD1FJ48u274zBrDEr5TBQznLT1mc4Vk3t5m061NV8owKuXotI6OzkpR3wTzKqCw==;25:uneShWC/FzqxHCTguzoQoqe71vrisweFMUsPmSiesVZC77oaLl2mCmsWQwevcc9pln8G2b5kK2uxEC6p+7hY6rIG4+6iOrREJ6oq0PqfTz2A3Po7PVBXmuKPGW1e+xPqSx+KuYbXQ9zDPh7CxzvxoXqWOhEjoDfq/SZna+UqA6d49MacIeV/PpF/89Y2lhOYoN+syNxY6IicHkjdlGyAsxRjYgaTeKU/+jf7Oajw8lWJAVkqqza7NCstaILjCsEOVI9Rmtc+0i2QSpMozAFKsCGSBvY5ZtyzSDKMzTO6EN9RthBBcny7eKu0ANuGLHj+PgU5AClyNbs44C+vkINIoeeQnWfoGxR5R0V09zYfDOo=
X-MS-TrafficTypeDiagnostic: CY1PR07MB2165:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2165;31:gVR66urrRRhbnVCEcS1TNP0ID8jyP4pPWHnX9rkugArHN2xIGsVBEVKrrwaHQt+qOLKh9Mwe909fOtx2udRjH1SsT9O8n7EmHGmh8zkteps3ScRjHupexX/1GodX/45P+fDDIuHx9WD0vm7QeugaJD9Wkv0WYpSsStfAVxgWw4BkmzS+UchSkFYAUSfoNCQXNJ7b3DZ9373A29On8pRTZHhVIqIdXGE8ZWteX7LtfpA=;20:Qn5YtvqMvicXXV+4jbPw/6VW6cr0uxAhDM8rWmonFKrk6TAJ0ERlbOpWbuDNgEEiurIUV1CtqadttpRhMaFjVj1GyoQItSPynJSFKlBrrW58cwx06V0Ic49pMEYmxY9Y95tIluyQFtz6FxD+9xYwAMSKiHDEKywXf6xpKqgmBBsF3jahlvBbFyiw4K6bL85rA/AEPobBG0LAkkJ9EJC7TuEBsjoEaqrENApAP+N2L3ya15ndgVLBRTv+2sOBOx7oC3x3RmC66qJgEvVGwyTk0C0rmCKcgjsQCsTUJjpMS7uHwGtcAbgqzdFJx5ileEtGLKqJg3AvzmKGNfmeSbM8+V2EzFRjJsV6F/PpoM37K4oQ8Ch9amongOJExmXB++ZBkSk/4i3o4hQ3HB6wjz3qzql2J64skGwQ2JtousyAHadZrEGpDleYrC4r8YwaVXZbXx4T4SLnkLAd0lTz10xm6PucuilBcjyyBRbqCeMd5li0rnEdP+HBJ3J7SDhGtAib
X-Microsoft-Antispam-PRVS: <CY1PR07MB21656AB281EDAC871AD22A42DDBA0@CY1PR07MB2165.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93003095)(10201501046)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:CY1PR07MB2165;BCL:0;PCL:0;RULEID:;SRVR:CY1PR07MB2165;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2165;4:n5ct/WBa6Bo1fHtmSEKkPPUWSAwq4bvGz0cuD8l/9vpWoWT+WZlARrjCkV2P0yBG6mq8mKzLgrKybMU4k4AEeKZ9j1uJkFrizH6B21BW7LBgO7emrpc86+G2pdNYZ1jEfrzV55WN2LuMNvOxdSTMkcOWIplzAMhdTEv8Qgh7bSuJF4meO27V8AHOiiq/CJgaQOFxJzd+96nDPyGtHRQx5u4tu54Oj9JrQfTeTwzQdAHyNChmBVFLvGkfCpu2nVPlRzF6cmGr7rMmvKtHJbLn9g==
X-Forefront-PRVS: 0895DF8FFD
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR07MB2165;23:jNiBAJRaaRJC6jRHdKNjwaleYwMAiLJTDTa+eaPe9?=
 =?us-ascii?Q?hdFH5KWLrQOderjTOdWblXunoi7hK6qcydVEKBAh5cu0Qwvc3SCzlHF1F93O?=
 =?us-ascii?Q?lsx/s0za3lSAkSSZSlfMc4clVDmEMrUFjxeUagcIrb1qdV8ZGb2scrIrq6FA?=
 =?us-ascii?Q?rLRBmB2qM1hbkDzpix0Ou01oV/pULBagOqDoOKybttG1XUnXrupEv+NwwJyk?=
 =?us-ascii?Q?/0AIYkYsLFkrkA04HptKXNEpVbyvqydcrr4rk49eldGShMhI6XDBtcRWb6V0?=
 =?us-ascii?Q?q3MMnvxY5QeICMyuZclqZlg5E8pU0WFUfpqiDClq24kNLXKbct+3S2sXIk/J?=
 =?us-ascii?Q?x7hHwVeP3ZPT5Oid8wwRFtJXVDSUUwtI/IqZuMzx5GJWMTyBH0j3Gaw9nFtu?=
 =?us-ascii?Q?mWiHtYrB5lSAmLHx8SJF0FRRbm5UmOC5uSbADWN6MNvAVoAQ13ShcTu0QV9k?=
 =?us-ascii?Q?8Cn6ooNFa4yoEWwnRDcXyJ+hYyk8q/MLCcT9tJZNrWuO1KkUjVEMrUzfU72s?=
 =?us-ascii?Q?V83vBwGXRR9f6mx2MXiHX+NFhOTzfVLqvYC2T/rJzcK6Q5YrW0HAXQ2z4C9X?=
 =?us-ascii?Q?BjLMcvqrBcYntQW5wzgs9cxqOlfErsg6q4a3olN9/2KGjXfSoPiivMyhX3/p?=
 =?us-ascii?Q?ZubV/nQ34e9v0/RwKFNdhzN7063lI2WDcB6xfjZngmaVu0cndvK8dRw4amwH?=
 =?us-ascii?Q?GdUGg9iUKKOzK2imenmqxwKwUkSQ2C1iLc4AOE5bPxZXLyo+CDViPTCkxcg3?=
 =?us-ascii?Q?aFttl0isrNspHgoSFyEu0xDezn2QLDKL+eEjzGDkX9rtxEnxEH5apzXmM31R?=
 =?us-ascii?Q?RcRLCG7/tbwD6M094783CRgxMCHiI+AFCq+Sz4VVa4/MAroHK9AaBk5OWwO+?=
 =?us-ascii?Q?+JCvEg0ifeWGMm/5KscBGrp0WFVkR99Hf1DU5gFbsENnu5e25Rp3EYbEi4Qs?=
 =?us-ascii?Q?lRsW26FCpYZTWkhbc8eMPwgeHb5880pN2ENXWQeUNi1rsMoZSVl0QXAOsLyX?=
 =?us-ascii?Q?qAouVGN3D9YOljf0vlJCPdrUpLgKp8NfaZqg/xYXEAP+v0q9i4Uea/VnpYqi?=
 =?us-ascii?Q?pMLeE+CoG07sjJE7/GAQR49L4ZQ5dJrICestRksB+nzECLSqjhF1BD2Fg6pE?=
 =?us-ascii?Q?UIB/6gmZG5tlwRJN9QSILG1bUNqGUcM0f/dxJdvDBiyR+lP7rMbFN2GtWd41?=
 =?us-ascii?Q?OoBeVqx/z3rOyk/K0sDOTCCPWNbWpJ4FJgejMXCxGUWBHe06uSVDKeSUd7UB?=
 =?us-ascii?Q?+P6uxeUa2pOzU2kyuE=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: ZQv28ydKSOqY+QFOQC4IIIkbB0HS4ICnc8IPhJ3YmduxF9MrraeBJeZj6xZgn3M8nsY2F3VtbNuQil/MZkiMQteCmvmZv4tGiPpvo9DqJkHF3oTt1XPifjnsdU9uMrgKkM8CIa/wV71MjthopFJySngLYv/5ppv7Y1wY8bB8vahQeDtoxsW3ec6DAt0CXeyq1UVqOuq64T0dE9mzHpn+v9d2AB7Cp5OnIpmBtERE4YuOjEn+Xb6Xr8WKawTJihHgPglvBlPM9JDrphVVV+vUgnle11PnmLTvx8iomxEpSgXXVfKx6BnMIdI/zPZjdTbJ
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2165;6:kv791f4YmKytTkTB9DUvNBxxhYj0SUNygLxXST9dDNQcwxTyY2lFyxabfiky64O/ulew/Kaf3RWgPTLYwMLdtnYqRFuS1vjMoY1Ovc0ihR7ouRktdzGmbS0VYyg6n3jshrWDHHCJ1er2Y3Ohtg6+hF31PY+eg57w2i3uwTYLxJI4CiNU0whQRGiOpWRWzpPtrdp2nUZ7HBng9CkG2X2Z7o1fp8HB+HjSSZEvnL5cEFQb7s/i3FrsOnaFXRY1Zz0xBqpFWstVuEvMuOoEMvjVaarQYAbOzAO90ZC7UBIjIZLj3mtf317gCimIkfjZdCfOFBtqtu6PKi2Hiv7O6wz6wMwcPQaxqZpD86s0S2n2ggCYz2A4oto88Dp8pOGgPhHoxUsWAzmIFD9x8sYQOr+KihzNb5vwMTRmcme6nTo406WSdDVqtaEBab4YDZf74irh+TgPiU908vAC60CQtM9Wmw==;5:qgvccBnMNLHAkLpaWPFD9lByTPt5McBhFw0mbtfqkYOeH6cU+RzaYlqvowFOOrdXN/1VMMuaGj4i/bVF4GZLGAOrs9ipHqjh8mbyqnPiqwvhGjo4rQ9js9MFHAvUYmngfqy32ZfIFSAz1YAG6cU1QxidKDD0bYB1XzZisqVWt30=;7:CHo90OW1ubXJYodmDCbtfBSRDdRB6lFuH8S6RLCglSzc5Z4lCjoTXoIWSP8UIkP7IzVBJvIi3Jko0dwhdciO6d1Lyro3dg34J/ECMWEdgg/Ky6FXb/iF2fMPCyRldqLY4+vhCY375pPqIknT2Ysd4g==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2165;20:K6002+NX+hUUr8A7WVLlp41IoygwrjcAZTO/f1bwlTzYjC37zTxrP6h5bsgiJB3SeaDgIw+R4YpOS3tQg+rVS5EkEhVILqx0FraMzJP4KBKDdgBCPZe9l1dkpPcSG5SBQ/T/SwOLowjw/uxUBbmBILYgKGZJqc1xEuaFQpWWgi/3dM6n5Qz0PY4luDifB9ezs3027TIV0BQJBTkNCimsqKFS17DYAkP3/k6yn0CjN35z0G2HrWCLB/TiV8IvHlOD
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2018 15:14:14.3654
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 087ebb61-4105-440a-63b2-08d668e94fd7
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR07MB2165
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-23_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=685 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812230137
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
index 374fb9e94f37..77e565a38f29 100644
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

