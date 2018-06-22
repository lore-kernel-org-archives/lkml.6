Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB345C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6903722BCB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mscc365.onmicrosoft.com header.i=@mscc365.onmicrosoft.com header.b="efl2yByX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6903722BCB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microsemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934142AbeFVRXf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 13:23:35 -0400
Received: from mail-eopbgr710082.outbound.protection.outlook.com ([40.107.71.82]:8044
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932721AbeFVRXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 13:23:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mscc365.onmicrosoft.com; s=selector1-microsemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fY35hzSwKFE8101r43d09YLUjHWE+xV+asaoNrYsDOw=;
 b=efl2yByXC6efm6XtxC3Tiih5r9dlyQxERFMCnkhRUwgZB1sHu1lhbzbpXumOoLRMnMJZekUR73kdti7FCPTMvR/g68nAR7GBWnravIc4iJHhlgKQr+MgvOstdjpPFUq8ptqezMCSMDBt48JwgZIcwzeNC/AttQzwtQ4UNiiiVT4=
Received: from BLUPR0201CA0003.namprd02.prod.outlook.com
 (2a01:111:e400:52e7::13) by SN1PR02MB3677.namprd02.prod.outlook.com
 (2603:10b6:802:2d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.19; Fri, 22 Jun
 2018 17:23:20 +0000
Received: from BL2FFO11FD007.protection.gbl (2a01:111:f400:7c09::140) by
 BLUPR0201CA0003.outlook.office365.com (2a01:111:e400:52e7::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.884.20 via Frontend Transport; Fri, 22 Jun 2018 17:23:20 +0000
Authentication-Results: spf=pass (sender IP is 208.19.100.21)
 smtp.mailfrom=microsemi.com; arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=bestguesspass action=none
 header.from=microsemi.com;
Received-SPF: Pass (protection.outlook.com: domain of microsemi.com designates
 208.19.100.21 as permitted sender) receiver=protection.outlook.com;
 client-ip=208.19.100.21; helo=AVMBX1.microsemi.net;
Received: from AVMBX1.microsemi.net (208.19.100.21) by
 BL2FFO11FD007.mail.protection.outlook.com (10.173.161.3) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.20.820.5 via Frontend Transport; Fri, 22 Jun 2018 17:23:20 +0000
Received: from AVMBX3.microsemi.net (10.100.34.33) by AVMBX1.microsemi.net
 (10.100.34.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1415.2; Fri, 22 Jun
 2018 10:23:18 -0700
Received: from AVMBX3.microsemi.net ([10.100.253.33]) by AVMBX3.microsemi.net
 ([10.100.253.33]) with mapi id 15.01.1415.004; Fri, 22 Jun 2018 10:23:18
 -0700
From:   Raghava Aditya Renukunta <RaghavaAditya.Renukunta@microsemi.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        dl-esc-Aacraid Linux Driver <aacraid@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     "y2038@lists.linaro.org" <y2038@lists.linaro.org>,
        "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
        Dave Carroll <david.carroll@microsemi.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] aacraid: stop using deprated get_seconds()
Thread-Topic: [PATCH] aacraid: stop using deprated get_seconds()
Thread-Index: AQHUBxjpKJjBrbWmSkWAJhfweJi8qqRsjN6g
Date:   Fri, 22 Jun 2018 17:23:18 +0000
Message-ID: <910e59ca484243edb838be21daa71547@microsemi.com>
References: <20180618152734.1705907-1-arnd@arndb.de>
In-Reply-To: <20180618152734.1705907-1-arnd@arndb.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.201.34.7]
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:208.19.100.21;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(39380400002)(346002)(396003)(2980300002)(438002)(199004)(189003)(36756003)(486006)(4326008)(2616005)(8746002)(102836004)(53416004)(11346002)(316002)(54906003)(446003)(336012)(108616005)(476003)(126002)(110136005)(106466001)(14454004)(23746002)(76176011)(186003)(24736004)(8936002)(72206003)(6246003)(81156014)(8676002)(77096007)(81166006)(478600001)(53936002)(7736002)(305945005)(3846002)(6116002)(2906002)(229853002)(356003)(97736004)(50466002)(69596002)(68736007)(2900100001)(26005)(5660300001)(47776003)(106002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR02MB3677;H:AVMBX1.microsemi.net;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD007;1:VVd9SffqYztc/cmVGVxvn3sUTWK5sC/pJaD4ZznfrUAVLHlHrcRKmHNOy5nWLn4dfzBzYz4/lSE2zLuLGdhtmAqfdBVv2yTx8IKhNmyd/9/lgFQUew2dg8V5+0z0FQhq
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8244e68-9050-417f-da8e-08d5d864d9ae
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(4608076)(2017052603328)(7153060)(7193020);SRVR:SN1PR02MB3677;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB3677;3:+NxmRJ7jzSCvFr9f3oH5gqgKipHLcXfbYS5Dl8uUgaxlb4KXSx9GIFLnsOy0+2tC6uKfwzGUCZGwNUhbKCbUXrAJ+EcT9UjBaPnS8NNDcPMEmCwwAKh6hvOQNCanHQipsTNdaJXr9WiqvWHI+CWPZU2eP3Bf40YpTjv4Op8zfD2AurW9O97fUtjSpfeyBkUuKqTmt6to9TdVcIyhd05BgZS70j74vzxxdgsG9Y3+ZnZvJaSNc74pjUdDpUOM4lKOJcdFuT/Z/W9oeAUD6dOkaGM+EyxjE2TlmQerSR3GDACS3QME1+UIFEclANdCQtu7eASBLRZNe+Tvbtnsefd6A5h2onyHtP5mmcTXI4LNRWQ=;25:p7HGtIYDM6IuJFrGC0wVZWq2lTLOQNs+2AjIZFw0gmuU1wpYDk+LTcD590hHEb/XJ5HVc05juLMtFBUqgxTm2d/pBTvEvKU/N7ltLxAXUFnpe6RiYCPEoi2tU/G1ObzhiEEROZ43DtNpP9NfzgqkbDj1Zn/UXHeZhb7IY7bT1CX23zbi3EYRBFyy4/QiBotp+ih0Jxi37EH0QSMwI/wWVbak/no3Wa0qYHsvD75slnLUja0Np2JJiof+TLDzo3H8K263HLZcHy5QjGp0A5NHXZ3a6qb6USST5C1QhCMfy82ZX/LXGMLLSpa/svVsBQgItY3ujEYnLnxqSZcdM/yoAQ==
X-MS-TrafficTypeDiagnostic: SN1PR02MB3677:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB3677;31:MJ9cH+lvSt0JIk3OTxKnZXj/N/r5CfUCxxM0eruFMbgNFhvr8t/jbwh+Maw/rJ3U1Mm9i6doM0FZrM5360S4d9PRcECvzE+WI6nVVhwxbrncRH6Y+hQfu9O7cHOCy6RXpoBwcb9qBK+lAUAdenal2CoX8IpxZmOz26XgawuBPt3GVqm505dg065ArhSudiq559JluwCbO50ec27SqIADj5ampGpzGv7DpIzxuvZaROA=;20:x76thpQ4o7e+M2DcA8Ru56WWSXwBfEv3mX/6NZCbclJdUg52thThj8TQh1ZJlICrSnIMBNePb+Fu+Xf5UDFJ+WC8rff4KfpwdQz95TgVA8+TzAytYWEulnmx++DBlAVK90b4RyPZ1T/THOnv7e3dBahO8qkEXNZ55vSzkbMT1GfB1zrZJ/vsPDcOTmoKANKlgJPeIPeES/YqhGraZG0HV5EjpG4buT/tweq5GwjfG5mp9zwFTt4c69zA/TFPpqGuTZSKLsWQdFim07XwteAfvuDBjNEtOnXFEY27DtUHRHNeFs2TlQt9fenuVDZdU3Yb4CyOF/nOrCmvf4vk2A+LfrDoLXPKcatQPcts9OOSUFg+FYwjLHdYvXWxFPNAUZVk5nR/8vxqFzKuLL8LZguNsxk9Nqy471EY5BBPvWJeTyjuo1B+oBCLCeiehrF6GpeSoZKCrX5RShdNLAAPZTKaKCetF1u95wa20oKo5yTwn1BJuV/QvK4yRBpfw2mEjwX1hLOUUpWSygN1nIOM4ox876wDxgcfmdPwz70YfzbFpHhxLNBQSBTDa1M4te/g9wtD13wsTZtQueaiXDQF+0eOzNQAtIID4MGgdoDZ0cVrRuQ=
X-Microsoft-Antispam-PRVS: <SN1PR02MB36779D05924D49E4BFE14A01F0750@SN1PR02MB3677.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72170198267865);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93004095)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:SN1PR02MB3677;BCL:0;PCL:0;RULEID:;SRVR:SN1PR02MB3677;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB3677;4:SmyEIeR3pxHqIZL+IHmFEXf1jWjGXgjxAE/ZRPm6iHbq4zCqMpGElLVyC6y1nl9BFWRud7FBnNwB6EQNAznpyNePZWYlX+QFBa4EtQtkqE8RDsWEERvbwIM7rXS5KdFMoM6frU0YYaIhcOpdxRVElQQ9sR9Bk8ByFZKA55fdDGa8kWdbCt8z1gSrqh8NGRhD1KS1QHOp+qceh28ogDrjrZLUZ7cadX7woj/D71NoDxo32iKFQa3g/GuMN3DWuWyIbrsfOakZk2XaTdtqJW4KlxfD1f9Rg07Phu3E/pa4KRzp1D2FQLXzoFJN2oUwGrY4
X-Forefront-PRVS: 071156160B
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;SN1PR02MB3677;23:skkh3Qsprx2DyxiWlW3gBaGVRzMw7QDd9Bsrr?=
 =?Windows-1252?Q?yRe+YUyjkYoxY4WwQk3fjj8sZp1en+vtWXTLjOCVzU/cSD7Uw5oDDBB3?=
 =?Windows-1252?Q?mg0YUJKMIFBE+8FFWmDYd7CIZxD7biFlh+4M+YnEILOdM1Rz7el6O3qp?=
 =?Windows-1252?Q?MhdHAtN3vfM6W5V75sDT3yOQEXkigakd18O/sCUb6V3FU0wmWESicKX9?=
 =?Windows-1252?Q?EPjX52l/1EhXmQy/hnBnivoj+ZRH13BRXFrrLifUhVZFIJzzJxmrybyN?=
 =?Windows-1252?Q?A+m4on0AwFXDwxS5olSKgbqvPWzgHu7d/Pdda3u1tMHGhnG+50ra6L1K?=
 =?Windows-1252?Q?XVMiWyrelGIgeEjc9KFaZQ85YTvvDTIXAOFvsFLGwI9nrHJLWw1lB7pt?=
 =?Windows-1252?Q?2SvWHN0bGVR6//gML+ECnAhyTXw6oBuKk64IevH0j61QWPRC3Llumz6x?=
 =?Windows-1252?Q?7FA5BHerv9/gVhC38bl1zR8Lp+4M3VQkoaRbSzjnqOOiqM93m1G31fDF?=
 =?Windows-1252?Q?AksBCYMw95Jgf5ZFkDZhnQSh6NPFh3gliyjdaa+wjmFwKuVV63W+oUkW?=
 =?Windows-1252?Q?Ke2nWHMGAdkMbzJL2Ta+8IpQ3aYcKoQ90C85IsKd4/HK3T/ZRiNdbWHR?=
 =?Windows-1252?Q?QvM65D8s6dcSNwTI0OWSqn2PwqBlHg3XGqsNrHUXRkcliiwjldMKNVdh?=
 =?Windows-1252?Q?r3lGK2l17u8yA9pxpC/L9c5DjxwWSp9h+74kXtRbOvhsTD3Y4tpfluyH?=
 =?Windows-1252?Q?/6P9dmtCZhuDfqRW7uhMwjVEvtTQvb2Qqm9p+gDLt3j21NjjOohp0wVn?=
 =?Windows-1252?Q?wwdy1FHDwOMCaJb9xXNKajrscwnb2ySi7a0ojwG6EXp0EvtEhaz10IAJ?=
 =?Windows-1252?Q?Dv16Cot2Zom9OPY2WnfzR7WvI1R1ckuIgAHZdKfE+Au1XbBetd67cxau?=
 =?Windows-1252?Q?47nZ1Jyax24cZhYL0YKuZWvEcu4JjTvhxVxS/7VEw8UYobG2Kkh3RX0R?=
 =?Windows-1252?Q?y3EUKc1i2es/c/oB32Z43s8c/maQRYjNVXLVQxeo50fim6hVvK1qPN2k?=
 =?Windows-1252?Q?hPqiOQfWXtD5W3eSmDc+DKIu/ObdHOydou19iXv1Rs5GF2t3hT2OYfc3?=
 =?Windows-1252?Q?2EHCBLRrYbyVjvY3axUPv9a8pf+b5C0vpsp8qyCG1TKF/pUwsTUSc1OO?=
 =?Windows-1252?Q?7P0iGklKgH+fRs6o7kNKlVSUxzqDU3pXclKgzXKDLXZ+n/RnDStzzJYp?=
 =?Windows-1252?Q?wAhpfpylbXI//x1WsEx4RzfbfriKMX2414r6W/lbZuk/QrsXvrN9Skco?=
 =?Windows-1252?Q?tinHoTh7ypTrKsZHjA7A8o1LHGGmMol5uMyA3K4Iv71Zoq7peXmSwzU/?=
 =?Windows-1252?Q?CfX9EiAd2Dl?=
X-Microsoft-Antispam-Message-Info: KZT2uX26HGJMQtjxQRzwu8tRS2sPqah+1rTcxv8PTbLTIqM7pC0N7qWqQnG13hiWaVqw7rNjKJb0QuKKDzMrKxOm5nQ+UhCwFuh0iY+pIGuS32j5jeRjPeOoDbf9DmEKNwIiebFGhqRJ/V9diDhFTh4P82AbFqF3kIGECEXE0qvRifdgiwHOd9mJAWiOHrGZJu2S9nJLfzutIlIOwzAovIEc/ysfyhJOG1+uWdjvWuq/HWcC3qr/C2PYjL9cTUcG2yVoWSo+P1DcKqUMl6B3T3zYVFLl4hYkpsRNyIw3e2T1RQTLNoHUaDYK5PUswbOzaMharoSV68gUqoi2foOVmw==
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB3677;6:oETqL1M9/BA7S+O/BuMD3s7/iUMtgOGJSc8zGrw5QL8Fep2hS6+BXBizx4Z43ksELahqc/8mjWlgAWgI94Kv9HaG99eOmTdCdk7DuBYEkEi562uEvjSnB0cvYm7iSrMh/Mx4sfiDhUs66+b8zL5cVj4VV+WKQC6kfmWTr6lMHPJnwRvg06vk4VlL1Qteyx6U+RWfwqnOoek2zLwBos0x234R7XSYauwwbJXc10+ddViDHT/gbrn7EowawVmiASNK9zJen9YTolI6Y2BdlAWxsV5+JacI3z+pbN1X+9M4tfmgUBa2cKPgajfqlSzKvbJ2QAQhOd+Fg8NFpIWTFkN6rWfg4RH12P0WSh82sgAGdFwnKOIvytRhPRIAQ5vXdfGFfr2aaBjAHQKufRuzyxmQTkwalNVPp+flnOPqCkndNIbSRRnwhds9fzxshSi0cqGK+VXEOXdj13Kp2l/7w+3+iw==;5:GYmVAERaYUVXprhR4o9Oqa59xUr0zeRgyUE2GxY12HBhLfq0Vh/2XX5aqiSdEgXivLdIhDCTd7hKIDwMV94Xx5lNy8Y8r1vJDdM/fD9CduNISrcPNclB8vw7gGMhWv/sgzDbk4revH33JsZFneysxDCbUqRCMviqUTC713alce0=;24:aBqThbzoc/t8XCWn18AQJ6UCEBvgX9J2Gj9Uka1xNcpOFoDZKsABDYaZ8HGEtdL7go9f81bIPzx+4bBRZ1qbD4wtRzzwdwf0k2OmLdpPkE0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB3677;7:ErxopARp9kP+myxywJJpKIvM/p89GlN4/QlrXCcULjijhom1qhfftPl1F6r3MMxfP8hdjipzADAS4wWgd/V+CQx93d6jThdhyjLTmXwj0Us0OxRTZlKkB6rzcJw5XHYKztJEMabqGEH1kU9hHWmBt4NoecXbg286OsAQYAGPjl3IB724teD12L63+cgul8Ix1fwzi/sn6oIjv29p2tc5uJIg5qYPWYUPu2Q83bIBmb+7sAphxGwl9Oz0Vb5TM2tw
X-OriginatorOrg: microsemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2018 17:23:20.1677
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8244e68-9050-417f-da8e-08d5d864d9ae
X-MS-Exchange-CrossTenant-Id: f267a5c8-86d8-4cc9-af71-1fd2c67c8fad
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f267a5c8-86d8-4cc9-af71-1fd2c67c8fad;Ip=[208.19.100.21];Helo=[AVMBX1.microsemi.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB3677
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




> get_seconds() can overflow on 32-bit architectures and is deprecated
> because of that. The use in the aacraid driver has the same problem due
> to a limited firmware interface, it also overflows in the year 2106.
>=20
> This changes all calls to get_seconds() to the non-deprecated
> ktime_get_real_seconds(), which unfortunately doesn't solve that problem
> but gets rid of one user of the deprecated interface.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
[...]
Reviewed-by: Raghava Aditya Renukunta <RaghavaAditya.Renukunta@microsemi.co=
m>
