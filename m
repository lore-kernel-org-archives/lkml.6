Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9CCECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C232064D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="ku/asnBK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40C232064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbeGTI6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 04:58:55 -0400
Received: from mail-sn1nam02on0063.outbound.protection.outlook.com ([104.47.36.63]:19585
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727529AbeGTI6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 04:58:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKuj9zlhzFwV5g9O/aAjWpahPdLiafHk4bP2qThY57A=;
 b=ku/asnBKGYxgo0CwsipPNMNxiF8h/OuCemvn64Xh+hKLMqsYMJPH9RSHAwumzS2LCYRpj+ppH0keFTTKQaFtn5dhZlqivpUXDnsB9mFyaHGKPuPKHNXqz0RvyGQ8v21J1Iv8rAl6r+YeHpjPYx1ua6UIjuPmnquNkICpxhNqiIE=
Received: from CY4PR03CA0014.namprd03.prod.outlook.com (2603:10b6:903:33::24)
 by BY2PR03MB553.namprd03.prod.outlook.com (2a01:111:e400:2c38::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.16; Fri, 20 Jul
 2018 08:11:06 +0000
Received: from BY2FFO11FD006.protection.gbl (2a01:111:f400:7c0c::195) by
 CY4PR03CA0014.outlook.office365.com (2603:10b6:903:33::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.973.16 via Frontend Transport; Fri, 20 Jul 2018 08:11:06 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; linux-foundation.org; dkim=none (message not
 signed) header.d=none;linux-foundation.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BY2FFO11FD006.mail.protection.outlook.com (10.1.14.127) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.952.20
 via Frontend Transport; Fri, 20 Jul 2018 08:11:05 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id w6K8B4cV021425
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Fri, 20 Jul 2018 01:11:04 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Fri, 20 Jul 2018
 04:11:04 -0400
Received: from mircea-Latitude-E6540.analog.com ([10.50.1.102]) by
 zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id w6K8B2o0022014;      Fri, 20 Jul
 2018 04:11:02 -0400
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <peda@axentia.se>
CC:     <davem@davemloft.net>, <mchehab+samsung@kernel.org>,
        <akpm@linux-foundation.org>, <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [PATCH V4 2/2] =?UTF-8?q?mux:=20adgs1408:=20new=20driver=20for=20Ana?= =?UTF-8?q?log=20Devices=20ADGS1408/1409=20mux=20=E2=80=A6?=
Date:   Fri, 20 Jul 2018 11:11:01 +0300
Message-ID: <20180720081101.27317-1-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(396003)(376002)(346002)(39860400002)(136003)(2980300002)(438002)(54534003)(189003)(199004)(5820100001)(2870700001)(2906002)(50226002)(336012)(53416004)(107886003)(106466001)(186003)(4326008)(50466002)(1076002)(426003)(77096007)(26005)(47776003)(8936002)(86362001)(5660300001)(126002)(2616005)(23676004)(476003)(305945005)(246002)(14444005)(478600001)(6916009)(36756003)(356003)(2351001)(316002)(44832011)(106002)(54906003)(72206003)(7636002)(486006)(7696005)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR03MB553;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD006;1:IuvN2i5tJA98Nt6613HBEXH75HghAJUMNHTou++Zu5oAns0urO4vju/6ClAgJRbRSIa3r4TyVWX+W2jIJa2DJWZCBSe0RtbbbQWZmnZ42WkIF3YslV3lSxL/EJ2V+EmW
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18099255-cb84-4f70-f20c-08d5ee185760
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BY2PR03MB553;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB553;3:163jyllVjIe5uI8ffuIJGF1+CP40NY44Uy6yW7bZceuG9PgunElSzA3K0+NC8F++wxlBUTQWipH+xsfRv9IAraAFJd9cNKtt2znhK30WjnQEhlKxKeJ91okzFmKfoah3hpj4p3EJ2c6zbLWI/1RUQMzvoGd/9QmfNfWpH+THg4bzticiFMzLOI97EpMKz71YgNwgJo/Vmt1Uv+rpyirZ0q6Y5qx3A8oSiLvwqp+Bq2apfNhFvAdjPnER9Xgzr5Uj0+jgSlXfH5c+zL/jNS1/qzRmSZoRHBhilaWakrwTLp+jOugZE8qKMkg9xWyWxZ1lVz5SBIhli3K1cnNt1drttQYEsaSBgFhlqqF8R/OkXq0=;25:L1yUBEQ3JB3hO1hvNC2ztqpSDoNLXWqIk4Ma67Uu/bH0+orwTkI9tLndz/nRDne+TvRaUYcSsPOgfVkCmYm3UKBrp85L690NcPogpJUZtlNQCT8u7KouoRUm3E7dtd3MGQp95l5dVM7nbHLGaHdHzZt6TUvCastvCQ8jiB5W3ooBkamPsRsQ7cRRz0PGuia8H1GrrnEkY6nwWJnGLP1HGaK3bOqjAJ9gxhZDBxq8MT3UGYjvCUXEyt3OASNM0TsT9tP0j/Eg+hyj6cw66ye13EJkl4HmD1I127t7Zxit/pZrRvdqwUJJsGVwOAUY3yP4fmveTRTjNeWBzhKqFKRYKg==
X-MS-TrafficTypeDiagnostic: BY2PR03MB553:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB553;31:j4r6M+YjQHChom4RXxGUKLfBHpN/fLar+AplVFcrJbeaiLTwt2Luai/7IsCDgo4RT/GPBtBq3/oenItSIaznE2GqeJBlw2LEu1+T6P8ZyloUzZfGwKR+7yJd7D/+uofiaKGFGG/egUk7eeUW43bdagH2xHjq0AIKsvJW0+nVWtDcl01GVp70kFVNoaT4XW2FlerDn6vqLB6Oj7eoZTSKqKQiIyqIAEYw9HeqkyoV29U=;20:MAN4By69I+J3NJCTFaKkKbiIZQRxQVf9pdNikWlEQLr3ai/p0QehxrSjddTo5itZlVruFrJJ/CSSBvOwgmsQfH+/w1BEtZnXEbLBVXlJehckZiHMzQuraFaLDeB7L4ngpbynEfbCUpvP6ZGk71YZGebGAipSGZYvd4OtrhhCJxVnhDY8xEZLO8fhdQnSK8Z7D/4nv0f4zMV9L//stN/Qw4KMubpaYzlcWBpTkJhDbUuMt+2BaY3a6/0ZrRmSO42zhyPABn3YDvoZAMAjVMA9f246Y7T/tTDm38ARCN4pdLgYKy849D0rfgGlZ8V4iY2nBKIXSpixEVtjPl/I7HQ7NggHXen1qzdRehWaVtpHmRpySh89XRFeYDr2vvjgaKlp26jLmIyuqjMQJnQjIw1743MH3dxYZYLGcMtYBwwM94d/c0iFTXOc6xJFaYmiKTYjy8l/mCHhBsOEZd7lsxVZfCMGRMtSgSnrGdx8Qe2RxWo4ahRydfgJsPVZF6BspOK9
X-Microsoft-Antispam-PRVS: <BY2PR03MB5532BC02CD5975A2CFEEA4681510@BY2PR03MB553.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BY2PR03MB553;BCL:0;PCL:0;RULEID:;SRVR:BY2PR03MB553;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB553;4:tvYWsn8htrR2bLu1nRp0YPP04S6ZyPbAPGG+0F1DyQRKnGzRTQwW3trGs7qq+B6xBEsn9nnS/CxOR+9DbA78Gja6t43rzOC8lhd7Jfl51Vi0oII34jdKn8uNwzqzSzGIkZBNEVQ3RUa/RHvXIkOOYSeiw72sF7IJ1QuzHyODlG802ZqvWOwEqE6afFDfxx1Q1Es5taC0paO/RtAPjh8aPO97Ng1L9f8gaB9Iz0ITg6jj7ZuPLZftFOBF7cVxqpEr+nEgbgbwEggcUmxQaKoC0BBFX1ektFyS0A2tzohjv/3sKup1FWAkfeMuB93sTH02
X-Forefront-PRVS: 073966E86B
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjAzTUI1NTM7MjM6Z3NoSGFJRndDRlNJbHRoc1ZCZDNqOUJtTFpB?=
 =?utf-8?B?UmNDRXNyazNuemRpcXdTNnJZUU9NWE9sTlplQlI2OHMwREZrSWwwQi84TW02?=
 =?utf-8?B?a0p2KzQrWmFpWWZWWTZUaVI2NnZTMVN3QWphMGd3MnFEeXFlQi9DeWJkK0xh?=
 =?utf-8?B?Uy9vWTc3N1Bqb0UvbXN0Zmg3N3ZzQkpFeFNUem9SamlqTkc5bjVnRXhhNzE0?=
 =?utf-8?B?TjVQU3NtYkxIM2lwVWFWTGJvRXF6TVZucTM4cGRJS01XUUUxVkRuN29GWS9S?=
 =?utf-8?B?bkVWbHdNaXZuTld4TVhIVzhJa2poRmNtMkZLaVM2OW1ZM1ZtVll0ZFM1RDBG?=
 =?utf-8?B?aTF0KzlRbzFadHZLVkR2WTdjeUZ2UmkzaWxXaExFOU1TQ0RrSTMxWGJMYUF2?=
 =?utf-8?B?U1pIUkFEUVZsajVtcTlVa1lPUUVzTTJRYVR4RUVkUzArZGJQYXQzVHR2ajhq?=
 =?utf-8?B?STBKRklIa3krV3dvWXZQclBnYzl4NEpua0NsNXg5V1RIeUlXT3laSTc5bnlp?=
 =?utf-8?B?ZWZONGVyejB3ZUQ2MmkzVktxZlRJdTRVZllaT0ZUYnkraTQwOWt1RHhMNUhT?=
 =?utf-8?B?WmNWZHFpOGpNb0NDWGFQdzRtYmpac3lCUjdTKzFmd2xQZFBkWXlQaDNuQ1lx?=
 =?utf-8?B?R2ZmSXp2ZmYvMHNTbWkwYkFXcW5qNEJvUUdHOUx2WjRhN0wwSEV5SVRRMlp1?=
 =?utf-8?B?cVNBU0NWNnVrUnVXNnRkWm45R2huTENoSURJYXNHU3h6RitnM0FEOEpaMVVZ?=
 =?utf-8?B?QVBGMjR6ejlzeUtlOU5aNm5URmJqWlF0TFgrYlYyVmJCZEY3VTVRVWN0ckUw?=
 =?utf-8?B?VXVDb205RWpONGlFcVhXL3FLaGU0anJOR3ZSckFGdmdOWFc2V2xhem51WFhK?=
 =?utf-8?B?UEdFT0xLOFJEWEpKcHlOMXRaZW9UMmRNT2VBak0wVGlYSDlQTWVOWTYveDVi?=
 =?utf-8?B?eFNuTWlWay8zZkUvVUJSVWlzY2pFTWFwamJmOXFaTTZqYXAyZ095TjAzTUpK?=
 =?utf-8?B?OXFSenYyME5lVEdXMHM5TmdhMXNuUnJCTk1qa3FGN0JkZDVNalBiU2k5TWo5?=
 =?utf-8?B?UGtuMGI1QlcwSFZaZzRURXcvbUd2TG9lb01XTHpFMXZBNndxeW9ucGo5dUlm?=
 =?utf-8?B?Kyt2T2YwcVMwL1VCb1NsTml4YU4wK1JFQzZQd1ZKbmtvQ21FaXNkVGtvMnda?=
 =?utf-8?B?Yit0OENLUmVIU0puWHl4cmVsTjhGQmw1Q0RIOUVnVUdpS09kNTJKZTBsZTVh?=
 =?utf-8?B?ejR1eWZaS29IQzB4R25GZHgwaUVoeVFTa09acmQxMUxvYTdSeFEyREN4aHQv?=
 =?utf-8?B?U1dSeFc0bWFJYWR4SE5MV0FWV1FLYjhXZ1hyeEpkekVoZXp1ZkJwQ3l4clBM?=
 =?utf-8?B?SHR2MGFDNXRDVXVJOXdaUWMvY2ZoVzE3elc1ZGdLbllFa2xjVGlJT3BTK3d6?=
 =?utf-8?B?RFZTVUxpaXMyMTNId2dFaWg4T2ZBTmd6MTdQcXVGSEl2czhuV09GRmdwU29L?=
 =?utf-8?B?aVR6UW9KbXpWZFMyaWlpV2VPQTNJdWhIYXRKVkk3clZtMGV3RGNNTmdVS2lk?=
 =?utf-8?Q?X4N0RjaZXcu+QJDvKbNsU3OebR6QfO0RbL92jGZkdXs=3D?=
X-Microsoft-Antispam-Message-Info: BG5aEL+2QmGAIjWBHwU0XDGZwFC/2FCmWNTxONMxp3wD4uwIHqAbV8prIIGTV2XM0MUF/JdusMceP1L9hCB9UIGvn8TW+7KOseNHnVmyWjijB4ITYLu1KRWJb53TeNx/kJkV8tl2pW29hPgoAuDKzjFljjz9DzUlkCs+zkKVH1VbnkgJ72ixkV16/aQ/yb8vVvJxUBtCGhcj0F9oHquIT63gkBvniU7+8UysP1Fpvn02KDBrKaTEwNKautmflIpmp2UyrC9fIqM2+Aq5fOljF0NqDP1uJTtFNLiP5bWCGZnynRIoxPr03t+hByt24EmDgUN2IYvM+UfJYZq5ZbO++R3Bgm5t8o1E6Cs8Myzn/us=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB553;6:X2uNndC2Zp9hzo2JhV9bMjuxG2cnDYIL5L1zJGbDNhOYSI/sLUN+Y6tJTMV629W3iSUYKPf6izlZlaybPZfMSSDQ0BCoxiMk1tG6rflTEeSs/3K67KUECr7Pw47I1AgsAJ/Sjswokm6jJuZuuPvE7aElknsEHv7TESOPMWii1wONwCEjbsNVQGl0q4Kdn27c0qDdh3x1A88YAk2QzYHI0Iog6oLEZ9BK0kRLgWRapnG22p+oopO0NFNVJLBprwEXJuvuYKT3xVVSF3AjOFwRzeWxxpQzfuPO4QEgO9hEzLJGOBnOtbCK2JoWD6aWb3teLybSmL2wJyd6+8RF7MlaiKuaQIwZOcaNXRTrgUnvFyOPCPE/Ct2DQmmigddzCXpnB7AdXqmnKxJ4vzCiaBuCG3ntmsxdCxYNapWi5FLqJnvazb8mc/hSoBin4zAxyd21iickmIARloVcVm5M57GIZw==;5:dyx+CDMOORvXhS+9M3zV+vfJk37INkbm50wBH+IwzJdT4p9o+KHAqLsfrxGihoi/sqEtJ5XDVwprvwu6x8xPyUOUB7w8FOgiZ9Gjm+xwcnEqJQ635EZGXI+TZ/M4W09NfrHG+OvXCeB+vsg0PiicjEzWvOkUq1zrnigaiD9ykPw=;7:G/dsAM+aFxiJnzqvURArwyojLJ/GobEa52Znxq2aoMxL34/xFOuQeCEHpl1NP4sWywg9dQpr6wqepCFvTaqKORiWxS97mDGNsOA19FSLOwMwZCvAfMKjSH5weXvR983Lw91QUwXaWy9NuyAgtYTkQvZxuXzL1zvfDZSgyFdjsBw0RJJbxdY83XLhLUDZSABLeeVVAZzImoSKa7goFf1x6nWW0vt6W/8EwSG/ioCbQddpRPlWa6lt2RI9HUpDIO5O
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2018 08:11:05.2265
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18099255-cb84-4f70-f20c-08d5ee185760
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR03MB553
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds basic support for Analog Device ADGS1408/09 SPI mux
controller.

The device is probed and set to a disabled state. It uses the new mux
controller framework.

Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
---
Changelog V3 -> V4
- named enum to adgs1408_chip_id
- added .data with id enum values
- added chip id verification for of_device_get_match_data

 drivers/mux/Kconfig    |  10 ++++
 drivers/mux/Makefile   |   2 +
 drivers/mux/adgs1408.c | 132 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 144 insertions(+)
 create mode 100644 drivers/mux/adgs1408.c

diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
index 6241678e99af..7659d6c5f718 100644
--- a/drivers/mux/Kconfig
+++ b/drivers/mux/Kconfig
@@ -21,6 +21,16 @@ config MUX_ADG792A
 	  To compile the driver as a module, choose M here: the module will
 	  be called mux-adg792a.
 
+config MUX_ADGS1408
+	tristate "Analog Devices ADGS1408/ADGS1409 Multiplexers"
+	depends on SPI
+	help
+	  ADGS1408 8:1 multiplexer and ADGS1409 double 4:1 multiplexer
+	  switches.
+
+	  To compile the driver as a module, choose M here: the module will
+	  be called mux-adgs1408.
+
 config MUX_GPIO
 	tristate "GPIO-controlled Multiplexer"
 	depends on GPIOLIB || COMPILE_TEST
diff --git a/drivers/mux/Makefile b/drivers/mux/Makefile
index c3d883955fd5..6e9fa47daf56 100644
--- a/drivers/mux/Makefile
+++ b/drivers/mux/Makefile
@@ -5,10 +5,12 @@
 
 mux-core-objs			:= core.o
 mux-adg792a-objs		:= adg792a.o
+mux-adgs1408-objs		:= adgs1408.o
 mux-gpio-objs			:= gpio.o
 mux-mmio-objs			:= mmio.o
 
 obj-$(CONFIG_MULTIPLEXER)	+= mux-core.o
 obj-$(CONFIG_MUX_ADG792A)	+= mux-adg792a.o
+obj-$(CONFIG_MUX_ADGS1408)	+= mux-adgs1408.o
 obj-$(CONFIG_MUX_GPIO)		+= mux-gpio.o
 obj-$(CONFIG_MUX_MMIO)		+= mux-mmio.o
diff --git a/drivers/mux/adgs1408.c b/drivers/mux/adgs1408.c
new file mode 100644
index 000000000000..9cc749e10383
--- /dev/null
+++ b/drivers/mux/adgs1408.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * ADGS1408/ADGS1409 SPI MUX driver
+ *
+ * Copyright 2018 Analog Devices Inc.
+ */
+
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/mux/driver.h>
+#include <linux/of_platform.h>
+#include <linux/property.h>
+#include <linux/spi/spi.h>
+
+#define ADGS1408_SW_DATA       (0x01)
+#define ADGS1408_REG_READ(reg) ((reg) | 0x80)
+#define ADGS1408_DISABLE       (0x00)
+#define ADGS1408_MUX(state)    (((state) << 1) | 1)
+
+enum adgs1408_chip_id {
+	ADGS1408 = 1,
+	ADGS1409,
+};
+
+static int adgs1408_spi_reg_write(struct spi_device *spi,
+				  u8 reg_addr, u8 reg_data)
+{
+	u8 tx_buf[2];
+
+	tx_buf[0] = reg_addr;
+	tx_buf[1] = reg_data;
+
+	return spi_write_then_read(spi, tx_buf, sizeof(tx_buf), NULL, 0);
+}
+
+static int adgs1408_set(struct mux_control *mux, int state)
+{
+	struct spi_device *spi = to_spi_device(mux->chip->dev.parent);
+	u8 reg;
+
+	if (state == MUX_IDLE_DISCONNECT)
+		reg = ADGS1408_DISABLE;
+	else
+		reg = ADGS1408_MUX(state);
+
+	return adgs1408_spi_reg_write(spi, ADGS1408_SW_DATA, reg);
+}
+
+static const struct mux_control_ops adgs1408_ops = {
+	.set = adgs1408_set,
+};
+
+static int adgs1408_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	struct mux_chip *mux_chip;
+	struct mux_control *mux;
+	int ret, idle_state;
+	enum adgs1408_chip_id chip_id;
+
+	chip_id = (enum adgs1408_chip_id)of_device_get_match_data(dev);
+	if (!chip_id)
+		chip_id = spi_get_device_id(spi)->driver_data;
+
+	mux_chip = devm_mux_chip_alloc(dev, 1, 0);
+	if (IS_ERR(mux_chip))
+		return PTR_ERR(mux_chip);
+
+	mux_chip->ops = &adgs1408_ops;
+
+	ret = adgs1408_spi_reg_write(spi, ADGS1408_SW_DATA, ADGS1408_DISABLE);
+	if (ret < 0)
+		return ret;
+
+	ret = device_property_read_u32_array(dev, "idle-state",
+					     &idle_state,
+					     mux_chip->controllers);
+	if (ret < 0)
+		idle_state = MUX_IDLE_AS_IS;
+
+	mux = mux_chip->mux;
+
+	if (chip_id == ADGS1408)
+		mux->states = 8;
+	else
+		mux->states = 4;
+
+	switch (idle_state) {
+	case MUX_IDLE_DISCONNECT:
+	case MUX_IDLE_AS_IS:
+	case 0 ... 7:
+		/* adgs1409 supports only 4 states */
+		if (idle_state < mux->states) {
+			mux->idle_state = idle_state;
+			break;
+		}
+		/* fall through */
+	default:
+		dev_err(dev, "invalid idle-state %d\n", idle_state);
+		return -EINVAL;
+	}
+
+	return devm_mux_chip_register(dev, mux_chip);
+}
+
+static const struct spi_device_id adgs1408_spi_id[] = {
+	{ "adgs1408", ADGS1408 },
+	{ "adgs1409", ADGS1409 },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, adgs1408_spi_id);
+
+static const struct of_device_id adgs1408_of_match[] = {
+	{ .compatible = "adi,adgs1408", .data = (void *)ADGS1408, },
+	{ .compatible = "adi,adgs1409", .data = (void *)ADGS1409, },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, adgs1408_of_match);
+
+static struct spi_driver adgs1408_driver = {
+	.driver = {
+		.name = "adgs1408",
+		.of_match_table = of_match_ptr(adgs1408_of_match),
+	},
+	.probe = adgs1408_probe,
+	.id_table = adgs1408_spi_id,
+};
+module_spi_driver(adgs1408_driver);
+
+MODULE_AUTHOR("Mircea Caprioru <mircea.caprioru@analog.com>");
+MODULE_DESCRIPTION("Analog Devices ADGS1408 MUX driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

