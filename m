Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D87BC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D364020875
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="ZwZttpyu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D364020875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732548AbeGLF5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 01:57:00 -0400
Received: from mail-bl2nam02on0085.outbound.protection.outlook.com ([104.47.38.85]:61873
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732344AbeGLF4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 01:56:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2TCbPx8Le8rPsVOlBTw1aEB+L6HXxVOwP1HlAYMpfQ=;
 b=ZwZttpyuHIR4xvbMg4Uodxj+Hd964GvHNpOA9y2XZFEffu1o6HCgMTWGtX0cZFA25p5RwUt3tfGikS+1Ht3AKb0pwcQmznHIfrPPOnQhjDnSoguziJu7x0kAha19uynj8DoF2hzXhVnoCIhdMsWYPS4VQakmslp4lSeyNVBgR+A=
Received: from BYAPR07CA0072.namprd07.prod.outlook.com (2603:10b6:a03:60::49)
 by DM2PR0701MB1344.namprd07.prod.outlook.com (2a01:111:e400:5119::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.22; Thu, 12 Jul
 2018 05:48:04 +0000
Received: from CO1NAM05FT048.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::206) by BYAPR07CA0072.outlook.office365.com
 (2603:10b6:a03:60::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.952.18 via Frontend
 Transport; Thu, 12 Jul 2018 05:48:04 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 CO1NAM05FT048.mail.protection.outlook.com (10.152.96.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.973.9 via Frontend Transport; Thu, 12 Jul 2018 05:48:04 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5luUX017906
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 11 Jul 2018 22:48:03 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 12 Jul 2018 07:48:09 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Jul 2018 07:48:09 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5lrMN029892;
        Thu, 12 Jul 2018 06:47:53 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6C5lrKp029891;
        Thu, 12 Jul 2018 06:47:53 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 27/31] usb: usbssp: implements usbssp_gadget_ep_enable function
Date:   Thu, 12 Jul 2018 06:47:24 +0100
Message-ID: <1531374448-26532-28-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1531374448-26532-1-git-send-email-pawell@cadence.com>
References: <1531374448-26532-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(346002)(376002)(2980300002)(36092001)(199004)(189003)(36756003)(126002)(8676002)(86362001)(356003)(11346002)(2616005)(51416003)(8936002)(4326008)(7636002)(50226002)(486006)(446003)(305945005)(87636003)(476003)(48376002)(50466002)(76176011)(1671002)(551934003)(246002)(426003)(105596002)(26005)(109986005)(107886003)(47776003)(42186006)(6666003)(478600001)(106466001)(336012)(14444005)(5660300001)(54906003)(2906002)(4720700003)(186003)(316002)(26826003)(16586007)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR0701MB1344;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT048;1:lq6TaGya6LCP07IAwXOu/udatw0XJgLRZ6qF91gl/39vxDxHj/W1UdfiJoWoM2gdqPeCRNDWSCTht/B2og7/0k3cfT1itjSob2IcBeb+wei3fwboBNTOmrlndJ+Y/Glk
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98c4807c-91f8-4fc6-573d-08d5e7bb0933
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:DM2PR0701MB1344;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0701MB1344;3:vJbfJXpN9Ysoa+w97D5hvuZFD7RBCRHXAnCEq2Pg6Z2W0Z64gVokO72R0PG1F997yCCNOLw/+UeH/hAo7a3FcEX/d45P0IdeHOu0IcDVnQpU9V2oaLRYnGmfN7Z47OCYpKyvsgFZzpzoizKD96MTyjqfGhRQMs1o9BVgYfcEu2hGvGE54yr795FnMrvaSKZfR9gU6/bWj9mFLHgkG3Alcv9iWfML2xmhX5CBl8j1SHy2z2HB6fTsCSRT9PPHwsMbaJ2bA4yrKxSk6UnAsRESTAZuCzXcrtnk8N3RUuLDVYOqLODkjbiq5/+UyYgtNyGI+428Bl9uVXeyXdU8rCeo1vurOWXeD0UtjX9z70/lxrg=;25:/rkNeOCEVDlcIzPsOWYp7kzlCHlUFMus4uyfZs6E7e9uOiNADji1IOBvXIUZtiZuUd2Qv90YEB1K+rcvcgLUP3EJmi/3kYUrD8tOeWH/oUM8bFx8rXo8+Db4kvoJbF3BWmJvKVK9aYOpTIiWPnMcm14YKZcdOQ3Zzqj5WuR8qdgoyuRlAUqmokbOObU5mYxnbzwMpx80E4ZYCctLzHLLCuPw0wN4NwB/kWSUO0fLflQ7UvmCL/SI3xaaqUjs7g8DniILrsiq9b3B/ypMlVWHBMi6TEARmkEtW20vplz/yXwDJR5KWQ/LZOPV1dJFoRcDhiNA0iMt6N+t+0+EnqtC1g==
X-MS-TrafficTypeDiagnostic: DM2PR0701MB1344:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0701MB1344;31:vmpGLE4vMe2DLKFfX0uGFA3P8J9QEkKbPBAzSR0IftN553Q04UGEyo2buc99jWwfwx946A9gCCY7MrK0zkS0kM7UVqrPnxPdAuMI4D/MgyjCqjQLI2Sij8G4uSxLE90bzUTDgn1GwoeAxpWuYU5K/qkYxBrgXYGeJ5/3UzpgXY3sPpaVpLDz+c69BZJc2Gl63285P6YoJNQNrwVYNLORCiAUlzzQigj6RacHapn/tBU=;20:bfbVq6ie3h9hxG1qiJ4labtAJDQJMuOYZ1aLEH8aJtZFPWbtA+fYL0dtf21vY6HVPpBSB4lpqzr7Kkr5RZK1ehh06dweEbh+ASwCxRq7VbCIw6F6djGdBg/Ag0PMCikihkpTtsTA/xHnnCU47+uFQ7/3wU4eVFYbIMOhDTg4arg82hVMBG78x+4BTeYuy1u1yERG3HSp/at1+WsEeyomHk+l2PPpWjR/C3sU8v1iHdXWxHFc3lg1XTtvFmowNUe9onhFB8+4We1mYRYCLQZoIIyvCp/iH8PL8TZSq/xK5ukH2rtWXlG+2c/D0/Kot8cAd7N0iA5GbHQmPKzcwwevu3KP+Yc5P2rG02J9wGIN3VrVqCa5XZZsmajKdRK/+/axDBrQp8qbfBHaLK1o3iUTMR8V/uFud+prFRpaokWhIxyGOs+7nsVsE70WvCBMIrQ2tbqaYpzbaDL+rQM9tz+mjPCN0Ful7TH3jmV9fK7eOoUxe8iGgnHebhswir+vgrsT
X-Microsoft-Antispam-PRVS: <DM2PR0701MB1344391F015CD0D2050CB5BCDD590@DM2PR0701MB1344.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93003095)(10201501046)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DM2PR0701MB1344;BCL:0;PCL:0;RULEID:;SRVR:DM2PR0701MB1344;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0701MB1344;4:GDtmHxsQYRgVzDZQLGbwv57ltw9Uuf08mEv286JKXkv9MtrBRDEkLNOE3ppWZpSd2MyEo68VFHilSyt7Apxc9jybAAy++xVdr9Uqr+HQdFxrvafo+9JFKxIqlyx/FPNZJGIZL1u4sXL9gOKDIuxiZpUg1u36E0PXskJnp35jvyLnXVB1Yd/gtDGbIz1xSY8rPRk/d19rbig/7ugP8Tyc5OF6k0JFxtkMStlOjd4ZhlzEQvmeQBP8q0auu7bHSijmk02V2WgyJ/MGn8esHoZ7dAp+YlQFcDOjIovbP1pXXTO9Rw+WmNBovwekoaBgGX/t
X-Forefront-PRVS: 0731AA2DE6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR0701MB1344;23:8NPJxmuSJMixUeYrPw+Xjw3xwrYCBQ9n1BY5OFb?=
 =?us-ascii?Q?ePfYoFGIJ+LvDh/OFKJHAmYWj02/bv/VceeA2w8ms1afh9LR0ygNRGM78zMj?=
 =?us-ascii?Q?D/kzIHQTQkhJWdFIWQ+mYS4RqVz40pVJVBsVeatHjo6zRXUvLPGR862ufv1T?=
 =?us-ascii?Q?ZJjZW/9ip/sVh+WDykkERn0qBgseNf/iqNWWEZo3QvYc/LMDN0eEXboz0tr4?=
 =?us-ascii?Q?MZ+RvXorYTq7JxuibT5kCjYAI/ksZjSSSlkxxBsASKURK14YiQGf9+I85qP0?=
 =?us-ascii?Q?4CA+FUm17f7r7VS/dsgFJtfHk97ccLJDL7UyZMWkYtX20pk4MrUSne6TdtQz?=
 =?us-ascii?Q?DAOHIWLnozmqm1oAqGD7Yzaa/OmvOjDLiXmMOV3LmCZrOgUFaQoOmANOAA1a?=
 =?us-ascii?Q?rLk1LaO4KzB4d4lMPj3WMcIqyNL5WwOvc/FqAG4t9m32qnqkDBYfoeb37gdA?=
 =?us-ascii?Q?TAQxlDXlHFwhPYPN49DVJ71JjujyJeEfDEyScyrneE4nHwUXd3TWGHgfOWN9?=
 =?us-ascii?Q?Y1bgny6FpRo3TZK5M5p28Cijy36864PtHZtb9HKIOTd8M20vkhMti0kYR6Wv?=
 =?us-ascii?Q?b/j0OeDEJyCYC1Vpfv7r+2Rm0SM+jyD7y7Nj+HWzSZoIuYHFW7YCKvpSIDtZ?=
 =?us-ascii?Q?5D0c9Awoees7CuLBf3ryhYocqp8EYXzZKKy81X4bN8tXgqRwGN78Ui3YgTRQ?=
 =?us-ascii?Q?E1AIgxf9MnMj3Bh59iYtfOwYaPgxEC3cbXsUFVGiBOjSaJAsCNYYZ34cv77B?=
 =?us-ascii?Q?KDvT3PqVqDWA6pbwc6s/YLOUj0KQcNJ0kq5OmZfp2x8VQVuU9fPENP850Bes?=
 =?us-ascii?Q?fpq603TEAmXdVAzBVMqYJ28r6A4icVvg8B74GoS3sJbuEY8MQMJhtaIlp8C0?=
 =?us-ascii?Q?gj+TPkDDYB357J1Z7eFMFzClCp5OL/OLFaUFaVjG2V7Z4PtP3QffQM2IMAUI?=
 =?us-ascii?Q?ePEwXWwqAjaeFObFwgLR2YmCaa2v+H8CoCkpJ1XLyJ9gXE11dpSoOVMGkzAc?=
 =?us-ascii?Q?+zlqWHtrJH0Py1QG3uZSvkFIWIT4bkiAst8FaGR6CR1pC5EC//5a7c80rXkq?=
 =?us-ascii?Q?bqGCNUCovzYLW3/jA+nyJjW7ArI3RxJUfYC5s5mhOQsclbwbGa7YMBgkgtrz?=
 =?us-ascii?Q?Nh0ZZmoukHVxLc67IT8z/4l92BZo7yT7YiiwP/Ep/g5eqadfZGwYhDCXSjTL?=
 =?us-ascii?Q?UZDKnLkp6V6eI2TM=3D?=
X-Microsoft-Antispam-Message-Info: 77YVJIDu7SG59DdyQgjsiFMVs3Sgs80dW3ODpxk4vergmHBxlgE22TcL6phDlLdge3qUUQKg4PInxPI9kzHWGKEBiE514yU8q6LnYE59zHiSnYvem/1giQx17pPIBLaPWcmbmO1GhlaqIHFC6bS4UQTeavofdeVDzEcZsk4R6UXJFRCCQeKf+3u1AIWCtkC/nFndF7MrBYVvgMfKzHDlcbkSuJTwWsmaavj2rTCVEO24MN6mO+Vh+pJxOfbiAeQaHQQeHzkmHc/kjQDsIvKGd60RF8Ju/GUJ73XkFR0OzdlSFNpwXXz/ApojoUTke2WJ5NTP0IWqTlVFe8e2Y9c9UEBrVbIK/oRYYlkKIzXWn8fPhlNWX2m83WlGYVLKTsgeMLvi9wugWhKPvzBk52w+Xw==
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0701MB1344;6:cv/hCC+7p/6qjJYPg8Rx0GYiDH83WlIz+AhdApy73/6rmSXpAnHJl+KzXvrGoWCIAgPkcWSiOFveYayRrrakgN0wfUWyN2WfdU2TmPDbRP0NdTZ8ygkqP9PvuLW4La8k7a9F2+wyidLIm1c3TMaqqSdCAkzr1ZFaObZMEDkJ5mdJeP8idVLGaJNAPgfagplzgd7mQVCiZg/pKCOCulEgrxr/f5crkNhPJqocDV6lwsoI2WhZmOibZ39+jVhSrZgYFnHLRvtjx+IXETr+CaKDhAQMX5VlZudSLC/SeFjMXXSc8IEmIdk3juGb7cg4np3UTUEY+/h/LApiCNoLc/4NxrXkhaOu3N/dFldg6u4ANlqp3W2vhuiQR8fajuj6OT59cRZYCXpIAWzeBbZzTC6OqvdiW/aETmyud4F/5YLO7+Ac4lJULXEwI22aDSePqZ2M5niKCPmTTpRuVnD8JhAQZw==;5:uVZBcX954tjeoOaGD2ejJ+knUPs6zrVX1KGF3lsQ0FeqBtrSmTp0gVq81wG4NUbeuKMWM7nCslxUtJbRdat69vlMxrua22LM6D2hm9xYomBg1q2tFdT3NHKiP3sxhFG79rOh0HhOd7XYo8SXOX2Nj9+qv/4JMDJddQ/5E7RCNIk=;24:hmHxUzWVZ+MPl27efFlS9w8YJLrvdWyHAMP8vXavbhPVciiKpcPABl7RsbgsgT4SLo1Z77fpBY6mwhcn6sqDR325Zf+FGqu+WYV9kbqIUgg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0701MB1344;7:/GajLuWC5HzE1XkULeExlbqW+QUgZ5somlmHIxNKooONURmsSfw7g9qUyxTFYQTB3fczzSnnv4IBofLOtAA2JtL6OoafiL2TGHecIoZnBvd05RyiXnpL7eFEFOKBB11zKO4dHjAEpfic5sm/MeDljNWuMaehf1BsSjgANMylYSDxdsVMuaYUoSLaftPr5mW/1x/dSo6XygXsJel0gO+qVNYtmFUld0uNe+qBRxAY3/y82R/5fYv/nibNtyTNK1zJ;20:J29f4k+myNkBPYX6C2bRI0n9rMyfQ+C/2Bn4bgrXz9CfbXaTlcU7AK9ex+UW3jq2OsPeZVTBDjjdF7PSlQT2g0oQBF15PyvITl/vyoaCBlbVpDOyUXrKPCm1wHhpBaGk0JZvqYS863nU4nfc69zZq/oviEzIBYu7C2/h+sjO3lNbWOj70mk3Vl95ftdaOPi/D4t3Fwp/jXfyAZ47U+vi6lbuNVgFU988Y2BEKZU0+y4Afyz7V+vQhz2VLu5becNL
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 05:48:04.0178
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98c4807c-91f8-4fc6-573d-08d5e7bb0933
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR0701MB1344
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch implements function responsible for enabling
and configuring USB endpoint. This function is called
from USB core gadget during handling SET_CONFIGURATION
and SET_INTERFACE request.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/usbssp/gadget-if.c  |  41 ++++-
 drivers/usb/usbssp/gadget-mem.c | 284 ++++++++++++++++++++++++++++++++
 drivers/usb/usbssp/gadget.c     | 261 ++++++++++++++++++++++++++++-
 drivers/usb/usbssp/gadget.h     |  10 ++
 4 files changed, 592 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/usbssp/gadget-if.c b/drivers/usb/usbssp/gadget-if.c
index 356571eadb3d..2fecc934cbce 100644
--- a/drivers/usb/usbssp/gadget-if.c
+++ b/drivers/usb/usbssp/gadget-if.c
@@ -39,13 +39,48 @@
 static int usbssp_gadget_ep_enable(struct usb_ep *ep,
 		const struct usb_endpoint_descriptor *desc)
 {
-	struct usbssp_ep *ep_priv = to_usbssp_ep(ep);
+	struct usbssp_ep *ep_priv;
+	struct usbssp_udc *usbssp_data;
 	int ret = 0;
+	int irq_disabled_locally = 0;
+	unsigned long flags = 0;
 
-	if (!ep_priv)
+	if (!ep || !desc || desc->bDescriptorType != USB_DT_ENDPOINT) {
+		pr_err("invalid parameters\n");
 		return -EINVAL;
+	}
 
-	/*TODO: implements this function*/
+	ep_priv = to_usbssp_ep(ep);
+	usbssp_data = ep_priv->usbssp_data;
+
+	if (!desc->wMaxPacketSize) {
+		usbssp_dbg(usbssp_data, "missing wMaxPacketSize\n");
+		return -EINVAL;
+	}
+
+	if (ep_priv->ep_state & USBSSP_EP_ENABLED) {
+		usbssp_dbg(usbssp_data, "%s is already enabled\n",
+			   ep_priv->name);
+		return -EINVAL;
+	}
+
+	usbssp_g_lock(irq_disabled_locally, flags);
+	ret = usbssp_add_endpoint(usbssp_data,  ep_priv);
+	if (ret < 0)
+		goto finish;
+
+	ep_priv->ep_state |= USBSSP_EP_ENABLED;
+
+	/*Update bandwidth information*/
+	ret = usbssp_check_bandwidth(usbssp_data, &usbssp_data->gadget);
+
+	if (ret < 0)
+		ep_priv->ep_state &= ~USBSSP_EP_ENABLED;
+
+finish:
+	usbssp_dbg(usbssp_data, "%s enable endpoint %s\n", ep_priv->name,
+			(ret == 0) ? "success" : "failed");
+	usbssp_g_unlock(irq_disabled_locally, flags);
 	return ret;
 }
 
diff --git a/drivers/usb/usbssp/gadget-mem.c b/drivers/usb/usbssp/gadget-mem.c
index 53292768a90f..303dc8fab8ad 100644
--- a/drivers/usb/usbssp/gadget-mem.c
+++ b/drivers/usb/usbssp/gadget-mem.c
@@ -819,6 +819,290 @@ int usbssp_setup_addressable_priv_dev(struct usbssp_udc *usbssp_data)
 	return 0;
 }
 
+/*
+ * Convert interval expressed as 2^(bInterval - 1) == interval into
+ * straight exponent value 2^n == interval.
+ *
+ */
+static unsigned int usbssp_parse_exponent_interval(struct usb_gadget *g,
+		struct usbssp_ep *dep)
+{
+	unsigned int interval;
+
+	interval = clamp_val(dep->endpoint.desc->bInterval, 1, 16) - 1;
+	if (interval != dep->endpoint.desc->bInterval - 1)
+		dev_warn(&g->dev,
+				"ep %#x - rounding interval to %d %sframes\n",
+				dep->endpoint.desc->bEndpointAddress,
+				1 << interval,
+				g->speed == USB_SPEED_FULL ? "" : "micro");
+
+	if (g->speed == USB_SPEED_FULL) {
+		/*
+		 * Full speed isoc endpoints specify interval in frames,
+		 * not microframes. We are using microframes everywhere,
+		 * so adjust accordingly.
+		 */
+		interval += 3;	/* 1 frame = 2^3 uframes */
+	}
+
+	return interval;
+}
+
+/*
+ * Convert bInterval expressed in microframes (in 1-255 range) to exponent of
+ * microframes, rounded down to nearest power of 2.
+ */
+static unsigned int usbssp_microframes_to_exponent(struct usb_gadget *g,
+						   struct usbssp_ep *dep,
+						   unsigned int desc_interval,
+						   unsigned int min_exponent,
+						   unsigned int max_exponent)
+{
+	unsigned int interval;
+
+	interval = fls(desc_interval) - 1;
+	interval = clamp_val(interval, min_exponent, max_exponent);
+	if ((1 << interval) != desc_interval)
+		dev_dbg(&g->dev,
+			"ep %#x - rounding interval to %d microframes,"
+			"ep desc says %d microframes\n",
+			dep->endpoint.desc->bEndpointAddress,
+			1 << interval,
+			desc_interval);
+
+	return interval;
+}
+
+static unsigned int usbssp_parse_microframe_interval(struct usb_gadget *g,
+		struct usbssp_ep *dep)
+{
+	if (dep->endpoint.desc->bInterval == 0)
+		return 0;
+	return usbssp_microframes_to_exponent(g, dep,
+			dep->endpoint.desc->bInterval, 0, 15);
+}
+
+
+static unsigned int usbssp_parse_frame_interval(struct usb_gadget *g,
+						struct usbssp_ep *dep)
+{
+
+	return usbssp_microframes_to_exponent(g, dep,
+			dep->endpoint.desc->bInterval * 8, 3, 10);
+}
+
+/* Return the polling or NAK interval.
+ *
+ * The polling interval is expressed in "microframes".  If DC's Interval field
+ * is set to N, it will service the endpoint every 2^(Interval)*125us.
+ *
+ * The NAK interval is one NAK per 1 to 255 microframes, or no NAKs if interval
+ * is set to 0.
+ */
+static unsigned int usbssp_get_endpoint_interval(struct usb_gadget *g,
+						 struct usbssp_ep *dep)
+{
+	unsigned int interval = 0;
+
+	switch (g->speed) {
+	case USB_SPEED_HIGH:
+		/* Max NAK rate */
+		if (usb_endpoint_xfer_control(dep->endpoint.desc) ||
+		    usb_endpoint_xfer_bulk(dep->endpoint.desc)) {
+			interval = usbssp_parse_microframe_interval(g, dep);
+			break;
+		}
+		/* Fall through - SS and HS isoc/int have same decoding */
+
+	case USB_SPEED_SUPER_PLUS:
+	case USB_SPEED_SUPER:
+		if (usb_endpoint_xfer_int(dep->endpoint.desc) ||
+		    usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
+			interval = usbssp_parse_exponent_interval(g, dep);
+		}
+		break;
+
+	case USB_SPEED_FULL:
+		if (usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
+			interval = usbssp_parse_exponent_interval(g, dep);
+			break;
+		}
+		/*
+		 * Fall through for interrupt endpoint interval decoding
+		 * since it uses the same rules as low speed interrupt
+		 * endpoints.
+		 */
+
+	case USB_SPEED_LOW:
+		if (usb_endpoint_xfer_int(dep->endpoint.desc) ||
+		    usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
+
+			interval = usbssp_parse_frame_interval(g, dep);
+		}
+		break;
+
+	default:
+		BUG();
+	}
+	return interval;
+}
+
+/* The "Mult" field in the endpoint context is only set for SuperSpeed isoc eps.
+ * High speed endpoint descriptors can define "the number of additional
+ * transaction opportunities per microframe", but that goes in the Max Burst
+ * endpoint context field.
+ */
+static u32 usbssp_get_endpoint_mult(struct usb_gadget *g,
+				    struct usbssp_ep *dep)
+{
+	if (g->speed < USB_SPEED_SUPER ||
+	    !usb_endpoint_xfer_isoc(dep->endpoint.desc))
+		return 0;
+
+	return dep->endpoint.comp_desc->bmAttributes;
+}
+
+static u32 usbssp_get_endpoint_max_burst(struct usb_gadget *g,
+					 struct usbssp_ep *dep)
+{
+	/* Super speed and Plus have max burst in ep companion desc */
+	if (g->speed >= USB_SPEED_SUPER)
+		return dep->endpoint.comp_desc->bMaxBurst;
+
+	if (g->speed == USB_SPEED_HIGH &&
+	   (usb_endpoint_xfer_isoc(dep->endpoint.desc) ||
+	    usb_endpoint_xfer_int(dep->endpoint.desc)))
+		return (usb_endpoint_maxp(dep->endpoint.desc) & 0x1800) >> 11;
+
+	return 0;
+}
+
+static u32 usbssp_get_endpoint_type(const struct usb_endpoint_descriptor *desc)
+{
+	int in;
+
+	in = usb_endpoint_dir_in(desc);
+
+	switch (usb_endpoint_type(desc)) {
+	case USB_ENDPOINT_XFER_CONTROL:
+		return CTRL_EP;
+	case USB_ENDPOINT_XFER_BULK:
+		return in ? BULK_IN_EP : BULK_OUT_EP;
+	case USB_ENDPOINT_XFER_ISOC:
+		return in ? ISOC_IN_EP : ISOC_OUT_EP;
+	case USB_ENDPOINT_XFER_INT:
+		return in ? INT_IN_EP : INT_OUT_EP;
+	}
+	return 0;
+}
+
+/* Return the maximum endpoint service interval time (ESIT) payload.
+ * Basically, this is the maxpacket size, multiplied by the burst size
+ * and mult size.
+ */
+static u32 usbssp_get_max_esit_payload(struct usb_gadget *g,
+		struct usbssp_ep *dep)
+{
+	int max_burst;
+	int max_packet;
+
+	/* Only applies for interrupt or isochronous endpoints*/
+	if (usb_endpoint_xfer_control(dep->endpoint.desc) ||
+	    usb_endpoint_xfer_bulk(dep->endpoint.desc))
+		return 0;
+
+	/* SuperSpeedPlus Isoc ep sending over 48k per esit*/
+
+	if ((g->speed >= USB_SPEED_SUPER_PLUS) &&
+	    USB_SS_SSP_ISOC_COMP(dep->endpoint.desc->bmAttributes))
+		return le32_to_cpu(dep->endpoint.comp_desc->wBytesPerInterval);
+	/* SuperSpeed or SuperSpeedPlus Isoc ep with less than 48k per esit */
+	else if (g->speed >= USB_SPEED_SUPER)
+		return le16_to_cpu(dep->endpoint.comp_desc->wBytesPerInterval);
+
+	max_packet = usb_endpoint_maxp(dep->endpoint.desc);
+	max_burst = usb_endpoint_maxp_mult(dep->endpoint.desc);
+	/* A 0 in max burst means 1 transfer per ESIT */
+	return max_packet * max_burst;
+}
+
+/* Set up an endpoint with one ring segment.  Do not allocate stream rings.
+ * Drivers will have to call usb_alloc_streams() to do that.
+ */
+int usbssp_endpoint_init(struct usbssp_udc *usbssp_data,
+			 struct usbssp_device *dev_priv,
+			 struct usbssp_ep *dep,
+			 gfp_t mem_flags)
+{
+	unsigned int ep_index;
+	struct usbssp_ep_ctx *ep_ctx;
+	struct usbssp_ring *ep_ring;
+	unsigned int max_packet;
+	enum usbssp_ring_type ring_type;
+	u32 max_esit_payload;
+	u32 endpoint_type;
+	unsigned int max_burst;
+	unsigned int interval;
+	unsigned int mult;
+	unsigned int avg_trb_len;
+	unsigned int err_count = 0;
+
+	ep_index = usbssp_get_endpoint_index(dep->endpoint.desc);
+	ep_ctx = usbssp_get_ep_ctx(usbssp_data, dev_priv->in_ctx, ep_index);
+
+	endpoint_type = usbssp_get_endpoint_type(dep->endpoint.desc);
+	if (!endpoint_type)
+		return -EINVAL;
+
+	ring_type = usb_endpoint_type(dep->endpoint.desc);
+
+	/*
+	 * Get values to fill the endpoint context, mostly from ep descriptor.
+	 * The average TRB buffer lengt for bulk endpoints is unclear as we
+	 * have no clue on scatter gather list entry size. For Isoc and Int,
+	 * set it to max available.
+	 */
+	max_esit_payload =
+			usbssp_get_max_esit_payload(&usbssp_data->gadget, dep);
+	interval = usbssp_get_endpoint_interval(&usbssp_data->gadget, dep);
+	mult = usbssp_get_endpoint_mult(&usbssp_data->gadget, dep);
+	max_packet = GET_MAX_PACKET(usb_endpoint_maxp(dep->endpoint.desc));
+	max_burst = usbssp_get_endpoint_max_burst(&usbssp_data->gadget, dep);
+	avg_trb_len = max_esit_payload;
+
+	/* Allow 3 retries for everything but isoc, set CErr = 3 */
+	if (!usb_endpoint_xfer_isoc(dep->endpoint.desc))
+		err_count = 3;
+	if (usb_endpoint_xfer_bulk(dep->endpoint.desc) &&
+	    usbssp_data->gadget.speed == USB_SPEED_HIGH)
+		max_packet = 512;
+	/* DC spec indicates that ctrl ep avg TRB Length should be 8 */
+	if (usb_endpoint_xfer_control(dep->endpoint.desc))
+		avg_trb_len = 8;
+
+	/* Set up the endpoint ring */
+	dev_priv->eps[ep_index].new_ring = usbssp_ring_alloc(usbssp_data, 2, 1,
+					ring_type, max_packet, mem_flags);
+
+	dev_priv->eps[ep_index].skip = false;
+	ep_ring = dev_priv->eps[ep_index].new_ring;
+
+	/* Fill the endpoint context */
+	ep_ctx->ep_info = cpu_to_le32(EP_MAX_ESIT_PAYLOAD_HI(max_esit_payload) |
+			EP_INTERVAL(interval) | EP_MULT(mult));
+	ep_ctx->ep_info2 = cpu_to_le32(EP_TYPE(endpoint_type) |
+			MAX_PACKET(max_packet) | MAX_BURST(max_burst) |
+			ERROR_COUNT(err_count));
+	ep_ctx->deq = cpu_to_le64(ep_ring->first_seg->dma |
+			ep_ring->cycle_state);
+
+	ep_ctx->tx_info = cpu_to_le32(EP_MAX_ESIT_PAYLOAD_LO(max_esit_payload) |
+			EP_AVG_TRB_LENGTH(avg_trb_len));
+
+	return 0;
+}
+
 struct usbssp_command *usbssp_alloc_command(struct usbssp_udc *usbssp_data,
 					    bool allocate_completion,
 					    gfp_t mem_flags)
diff --git a/drivers/usb/usbssp/gadget.c b/drivers/usb/usbssp/gadget.c
index 3e461fca855e..833647600485 100644
--- a/drivers/usb/usbssp/gadget.c
+++ b/drivers/usb/usbssp/gadget.c
@@ -474,6 +474,26 @@ unsigned int usbssp_get_endpoint_index(
 	return index;
 }
 
+/* The reverse operation to usbssp_get_endpoint_index.
+ * Calculate the USB endpoint address from the USBSSP endpoint index.
+ */
+unsigned int usbssp_get_endpoint_address(unsigned int ep_index)
+{
+	unsigned int number = DIV_ROUND_UP(ep_index, 2);
+	unsigned int direction = ep_index % 2 ? USB_DIR_OUT : USB_DIR_IN;
+
+	return direction | number;
+}
+
+/* Find the flag for this endpoint (for use in the control context). Use the
+ * endpoint index to create a bitmask. The slot context is bit 0, endpoint 0 is
+ * bit 1, etc.
+ */
+unsigned int usbssp_get_endpoint_flag(
+			const struct usb_endpoint_descriptor *desc)
+{
+	return 1 << (usbssp_get_endpoint_index(desc) + 1);
+}
 /* Compute the last valid endpoint context index. Basically, this is the
  * endpoint index plus one. For slot contexts with more than valid endpoint,
  * we find the most significant bit set in the added contexts flags.
@@ -703,6 +723,128 @@ int usbssp_dequeue(struct usbssp_ep *ep_priv, struct usbssp_request *req_priv)
 	return ret;
 }
 
+
+/* Add an endpoint to a new possible bandwidth configuration for this device.
+ * Only one call to this function is allowed per endpoint before
+ * check_bandwidth() or reset_bandwidth() must be called.
+ * A call to usbssp_drop_endpoint() followed by a call to
+ * usbssp_add_endpoint() will add the endpoint to the schedule with possibly
+ * new parameters denoted by different endpoint descriptor in usbssp_ep.
+ * A call to usbssp_add_endpoint() followed by a call to usbssp_drop_endpoint()
+ * is not allowed.
+ *
+ */
+int usbssp_add_endpoint(struct usbssp_udc *usbssp_data, struct usbssp_ep *dep)
+{
+	const struct usb_endpoint_descriptor *desc = dep->endpoint.desc;
+	struct usbssp_container_ctx *in_ctx;
+	unsigned int ep_index;
+	struct usbssp_input_control_ctx *ctrl_ctx;
+	u32 added_ctxs;
+	u32 new_add_flags, new_drop_flags;
+	struct usbssp_device *dev_priv;
+	int ret = 0;
+
+	ret = usbssp_check_args(usbssp_data, dep, 1, true, __func__);
+	if (ret <= 0)
+		return ret;
+
+	if (usbssp_data->usbssp_state & USBSSP_STATE_DYING)
+		return -ENODEV;
+
+	added_ctxs = usbssp_get_endpoint_flag(desc);
+	if (added_ctxs == SLOT_FLAG || added_ctxs == EP0_FLAG) {
+		usbssp_dbg(usbssp_data, "USBSSP %s - can't add slot or ep 0 %#x\n",
+				__func__, added_ctxs);
+		return 0;
+	}
+
+	dev_priv = &usbssp_data->devs;
+	in_ctx = dev_priv->in_ctx;
+	ctrl_ctx = usbssp_get_input_control_ctx(in_ctx);
+	if (!ctrl_ctx) {
+		usbssp_warn(usbssp_data, "%s: Could not get input context, bad type.\n",
+				__func__);
+		return 0;
+	}
+
+	ep_index = usbssp_get_endpoint_index(desc);
+	/* If this endpoint is already in use, and the upper layers are trying
+	 * to add it again without dropping it, reject the addition.
+	 */
+	if (dev_priv->eps[ep_index].ring &&
+	    !(le32_to_cpu(ctrl_ctx->drop_flags) & added_ctxs)) {
+		usbssp_warn(usbssp_data,
+			"Trying to add endpoint 0x%x without dropping it.\n",
+			(unsigned int) desc->bEndpointAddress);
+		return -EINVAL;
+	}
+
+	/* If already noted the endpoint is enabled,
+	 * ignore this request.
+	 */
+	if (le32_to_cpu(ctrl_ctx->add_flags) & added_ctxs) {
+		usbssp_warn(usbssp_data, "USBSSP %s called with enabled ep %p\n",
+				__func__, dep);
+		return 0;
+	}
+
+	if (usbssp_endpoint_init(usbssp_data, dev_priv, dep, GFP_ATOMIC) < 0) {
+		usbssp_dbg(usbssp_data, "%s - could not initialize ep %#x\n",
+				__func__, desc->bEndpointAddress);
+		return -ENOMEM;
+	}
+
+	ctrl_ctx->add_flags |= cpu_to_le32(added_ctxs);
+	new_add_flags = le32_to_cpu(ctrl_ctx->add_flags);
+	new_drop_flags = le32_to_cpu(ctrl_ctx->drop_flags);
+
+//	usbssp_debugfs_create_endpoint(usbssp_data,
+//		&usbssp_data->devs, ep_index);
+	usbssp_dbg(usbssp_data,
+		"add ep 0x%x, new drop flags = %#x, new add flags = %#x\n",
+		(unsigned int) desc->bEndpointAddress,
+		(unsigned int) new_drop_flags,
+		(unsigned int) new_add_flags);
+	return 0;
+}
+
+static void usbssp_zero_in_ctx(struct usbssp_udc *usbssp_data,
+			       struct usbssp_device *dev_priv)
+{
+	struct usbssp_input_control_ctx *ctrl_ctx;
+	struct usbssp_ep_ctx *ep_ctx;
+	struct usbssp_slot_ctx *slot_ctx;
+	int i;
+
+	ctrl_ctx = usbssp_get_input_control_ctx(dev_priv->in_ctx);
+	if (!ctrl_ctx) {
+		usbssp_warn(usbssp_data,
+			"%s: Could not get input context, bad type.\n",
+			__func__);
+		return;
+	}
+
+	/* When a device's add flag and drop flag are zero, any subsequent
+	 * configure endpoint command will leave that endpoint's state
+	 * untouched. Make sure we don't leave any old state in the input
+	 * endpoint contexts.
+	 */
+	ctrl_ctx->drop_flags = 0;
+	ctrl_ctx->add_flags = 0;
+	slot_ctx = usbssp_get_slot_ctx(usbssp_data, dev_priv->in_ctx);
+	slot_ctx->dev_info &= cpu_to_le32(~LAST_CTX_MASK);
+	/* Endpoint 0 is always valid */
+	slot_ctx->dev_info |= cpu_to_le32(LAST_CTX(1));
+	for (i = 1; i < 31; ++i) {
+		ep_ctx = usbssp_get_ep_ctx(usbssp_data, dev_priv->in_ctx, i);
+		ep_ctx->ep_info = 0;
+		ep_ctx->ep_info2 = 0;
+		ep_ctx->deq = 0;
+		ep_ctx->tx_info = 0;
+	}
+}
+
 static int usbssp_configure_endpoint_result(struct usbssp_udc *usbssp_data,
 					    struct usb_gadget *g,
 					    u32 *cmd_status)
@@ -865,6 +1007,21 @@ static int usbssp_configure_endpoint(struct usbssp_udc *usbssp_data,
 	return ret;
 }
 
+static void usbssp_check_bw_drop_ep_streams(struct usbssp_udc *usbssp_data,
+	struct usbssp_device *vdev, int i)
+{
+	struct usbssp_ep *ep = &vdev->eps[i];
+
+	if (ep->ep_state & EP_HAS_STREAMS) {
+		usbssp_warn(usbssp_data,
+			"WARN: endpoint 0x%02x has streams on set_interface, freeing streams.\n",
+			 usbssp_get_endpoint_address(i));
+		usbssp_free_stream_info(usbssp_data, ep->stream_info);
+		ep->stream_info = NULL;
+		ep->ep_state &= ~EP_HAS_STREAMS;
+	}
+}
+
 int usbssp_halt_endpoint(struct usbssp_udc *usbssp_data, struct usbssp_ep *dep,
 			 int value)
 {
@@ -971,10 +1128,112 @@ int usbssp_halt_endpoint(struct usbssp_udc *usbssp_data, struct usbssp_ep *dep,
 	kfree(command->completion);
 	kfree(command);
 	return ret;
+}
 
-	return 0;
+/* Called after one or more calls to usbssp_add_endpoint() or
+ * usbssp_drop_endpoint(). If this call fails, the driver is expected
+ * to call usbssp_reset_bandwidth().
+ *
+ */
+int usbssp_check_bandwidth(struct usbssp_udc *usbssp_data, struct usb_gadget *g)
+{
+	int i;
+	int ret = 0;
+	struct usbssp_device *dev_priv;
+	struct usbssp_input_control_ctx *ctrl_ctx;
+	struct usbssp_slot_ctx *slot_ctx;
+	struct usbssp_command *command;
+
+	ret = usbssp_check_args(usbssp_data, NULL, 0, true, __func__);
+	if (ret <= 0)
+		return ret;
+
+	if ((usbssp_data->usbssp_state & USBSSP_STATE_DYING) ||
+	    (usbssp_data->usbssp_state & USBSSP_STATE_REMOVING))
+		return -ENODEV;
+
+	dev_priv = &usbssp_data->devs;
+
+	command = usbssp_alloc_command(usbssp_data, true, GFP_ATOMIC);
+	if (!command)
+		return -ENOMEM;
+
+	command->in_ctx = dev_priv->in_ctx;
+
+	ctrl_ctx = usbssp_get_input_control_ctx(command->in_ctx);
+	if (!ctrl_ctx) {
+		usbssp_warn(usbssp_data,
+			"%s: Could not get input context, bad type.\n",
+			__func__);
+		ret = -ENOMEM;
+		goto command_cleanup;
+	}
+	ctrl_ctx->add_flags |= cpu_to_le32(SLOT_FLAG);
+	ctrl_ctx->add_flags &= cpu_to_le32(~EP0_FLAG);
+	ctrl_ctx->drop_flags &= cpu_to_le32(~(SLOT_FLAG | EP0_FLAG));
+
+	/* Don't issue the command if there's no endpoints to update.*/
+	if (ctrl_ctx->add_flags == cpu_to_le32(SLOT_FLAG) &&
+	    ctrl_ctx->drop_flags == 0) {
+		ret = 0;
+		goto command_cleanup;
+	}
+
+	/* Fix up Context Entries field. Minimum value is EP0 == BIT(1). */
+	slot_ctx = usbssp_get_slot_ctx(usbssp_data, dev_priv->in_ctx);
+	for (i = 31; i >= 1; i--) {
+		__le32 le32 = cpu_to_le32(BIT(i));
+
+		if ((dev_priv->eps[i-1].ring && !(ctrl_ctx->drop_flags & le32))
+		    || (ctrl_ctx->add_flags & le32) || i == 1) {
+			slot_ctx->dev_info &= cpu_to_le32(~LAST_CTX_MASK);
+			slot_ctx->dev_info |= cpu_to_le32(LAST_CTX(i));
+			break;
+		}
+	}
+
+	ret = usbssp_configure_endpoint(usbssp_data, g, command,
+			false, false);
+
+	if (ret)
+		/* Caller should call reset_bandwidth() */
+		goto command_cleanup;
+
+	/* Free any rings that were dropped, but not changed. */
+	for (i = 1; i < 31; ++i) {
+		if ((le32_to_cpu(ctrl_ctx->drop_flags) & (1 << (i + 1))) &&
+		    !(le32_to_cpu(ctrl_ctx->add_flags) & (1 << (i + 1)))) {
+			usbssp_free_endpoint_ring(usbssp_data, dev_priv, i);
+			usbssp_check_bw_drop_ep_streams(usbssp_data,
+					dev_priv, i);
+		}
+	}
+
+	usbssp_zero_in_ctx(usbssp_data, dev_priv);
+	/*
+	 * Install any rings for completely new endpoints or changed endpoints,
+	 * and free any old rings from changed endpoints.
+	 */
+	for (i = 1; i < 31; ++i) {
+		if (!dev_priv->eps[i].new_ring)
+			continue;
+		/* Only free the old ring if it exists.
+		 * It may not if this is the first add of an endpoint.
+		 */
+		if (dev_priv->eps[i].ring)
+			usbssp_free_endpoint_ring(usbssp_data, dev_priv, i);
+
+		usbssp_check_bw_drop_ep_streams(usbssp_data, dev_priv, i);
+		dev_priv->eps[i].ring = dev_priv->eps[i].new_ring;
+		dev_priv->eps[i].new_ring = NULL;
+	}
+command_cleanup:
+	kfree(command->completion);
+	kfree(command);
+	return ret;
 }
 
+
 /*
  * This submits a Reset Device Command, which will set the device state to 0,
  * set the device address to 0, and disable all the endpoints except the default
diff --git a/drivers/usb/usbssp/gadget.h b/drivers/usb/usbssp/gadget.h
index 97ccc29792a2..a3288cd16c4a 100644
--- a/drivers/usb/usbssp/gadget.h
+++ b/drivers/usb/usbssp/gadget.h
@@ -1688,8 +1688,16 @@ void usbssp_copy_ep0_dequeue_into_input_ctx(struct usbssp_udc *usbssp_data);
 unsigned int usbssp_get_endpoint_index(const struct usb_endpoint_descriptor *desc);
 unsigned int usbssp_get_endpoint_address(unsigned int ep_index);
 unsigned int usbssp_last_valid_endpoint(u32 added_ctxs);
+int usbssp_endpoint_init(struct usbssp_udc *usbssp_data,
+		struct usbssp_device *dev_priv,
+		struct usbssp_ep *dep,
+		gfp_t mem_flags);
+
 int usbssp_ring_expansion(struct usbssp_udc *usbssp_data,
 		struct usbssp_ring *ring, unsigned int num_trbs, gfp_t flags);
+void usbssp_free_endpoint_ring(struct usbssp_udc *usbssp_data,
+		struct usbssp_device *dev_priv,
+		unsigned int ep_index);
 void usbssp_free_stream_info(struct usbssp_udc *usbssp_data,
 		struct usbssp_stream_info *stream_info);
 struct usbssp_ring *usbssp_dma_to_transfer_ring(
@@ -1828,6 +1836,8 @@ int usbssp_setup_analyze(struct usbssp_udc *usbssp_data);
 int usbssp_status_stage(struct usbssp_udc *usbssp_data);
 
 int usbssp_reset_device(struct usbssp_udc *usbssp_data);
+int usbssp_check_bandwidth(struct usbssp_udc *usbssp_data,
+		struct usb_gadget *g);
 
 static inline struct usbssp_ring *usbssp_request_to_transfer_ring(
 		struct usbssp_udc *usbssp_data, struct usbssp_request *req_priv)
-- 
2.17.1

