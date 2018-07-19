Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB13ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A8320684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="T8r8uyBC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83A8320684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387980AbeGSSoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 14:44:02 -0400
Received: from mail-eopbgr730070.outbound.protection.outlook.com ([40.107.73.70]:35633
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733205AbeGSSoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 14:44:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDFPBKDC3T8B1MxkAtbKIjkrmOFMN1h63n1KSOhRA0o=;
 b=T8r8uyBCaiKRNiN/jbGcEz1k7CD2Y0wu8eTA29wgiiRmsr104/tcaWtWWdyewpJOrBxMbiZqCBJl2VPuZWa3goHu9Jk3lc9RtcGNRRy5E4jNeiXAANOcgkm/cDWFxhEvlA5x6pg96uywMkTu820+7kwtw+TiGuDAFSkPxnX+9gE=
Received: from BYAPR07CA0070.namprd07.prod.outlook.com (2603:10b6:a03:60::47)
 by BN3PR0701MB1330.namprd07.prod.outlook.com (2a01:111:e400:4019::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.20; Thu, 19 Jul
 2018 17:59:26 +0000
Received: from BY2NAM05FT003.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::205) by BYAPR07CA0070.outlook.office365.com
 (2603:10b6:a03:60::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Thu, 19 Jul 2018 17:59:25 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 BY2NAM05FT003.mail.protection.outlook.com (10.152.100.140) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.20.995.0 via
 Frontend Transport; Thu, 19 Jul 2018 17:59:25 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHxNgB025447
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 19 Jul 2018 10:59:24 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 19 Jul 2018 19:59:30 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 19 Jul 2018 19:59:30 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHxFQD005944;
        Thu, 19 Jul 2018 18:59:15 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6JHxE4f005943;
        Thu, 19 Jul 2018 18:59:14 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 21/31] usb: usbssp: added queuing procedure for BULK and INT transfer.
Date:   Thu, 19 Jul 2018 18:57:54 +0100
Message-ID: <1532023084-28083-22-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1532023084-28083-1-git-send-email-pawell@cadence.com>
References: <1532023084-28083-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(346002)(39860400002)(2980300002)(36092001)(199004)(189003)(36756003)(87636003)(50226002)(478600001)(486006)(50466002)(76176011)(4326008)(8936002)(42186006)(16586007)(316002)(26826003)(86362001)(5660300001)(575784001)(26005)(14444005)(426003)(48376002)(107886003)(1671002)(109986005)(186003)(246002)(8676002)(2616005)(51416003)(336012)(305945005)(476003)(7636002)(126002)(356003)(6666003)(11346002)(446003)(4720700003)(106466001)(105596002)(2906002)(54906003)(47776003)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR0701MB1330;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM05FT003;1:WukJe6Fvs6n4C4eEeishgFSDqvTM/1RUcfk8n2QRAa3wXlzgQOPQzdQ4Q7cKEnHERWxX5nyAP7nfCiEve8mtZiijvL2cW5NpTLgmCWYReX+kuusN8H0Fq35n6k0sOfjL
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f192989d-12a9-42ae-a5db-08d5eda15d40
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BN3PR0701MB1330;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1330;3:BRkccvwxOHNqkCjcl7ODC/ZzV7gN0x44r40SrrIMPKfogsbaCIx2JiP3DO1BEgtjkvkovMOyY4Y5AlnH5r0PsS+3aBXl9716HhfEKt15Q1RXCv1out3VXzF9f0INxw0+aUc3qeqjXliWuKglKW1R5cbGRo2h86sCLod2vS3sw4ZQb/aXIs6N/DCV5nOCuUYzp0zPxM0XeOUh6bz708HaZbH5gvvWROxBAaMvKh25cq/bI31sF+CXAQ+0FH0bJ5hVcf9JPfbehQXYMdRUiFAF+fWQ2P1ryTsgxuLVqRBkypBZUkawFZoy9uW7EcUbby4u/1CsW9tWCGyjXsooSItShoR2VBeO8O9b2paFWppk230=;25:g5rY8u3kjj6orVHS5idUaiM9hC9+7y/Cxv49W1/mUMof8/uCi6pm2AxpM8A88gWZM02SfUNVtf5kWZpymgERNx5t2NA7luT8qgoEWdMs24N56xpK6NaLvvjX6xq8qpkbaE8vmZWPYCyje0UBFCQFIuBXb4/IUWF+E6LYsMl6LTnTl9UWLTAhvVzZlSyAoxSwa+0+ODvb0DHfMNX1QFlQKnmzwL7tfdC/6+R0H4r9rpDPN2sXjV6Fy46uY20QZodVejlV/xI1SxTgHBTDdEPogBhLmOAUE2F6fEbq7lvFMtqNZtQLLZG8khFDz/tE/k4DY2k/SfeKO1MXlGVNh2oAtg==
X-MS-TrafficTypeDiagnostic: BN3PR0701MB1330:
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1330;31:Azu7FT3r7x8S7DWwjmTHwlKkOtxJiJRoTrBDF1w5SsG4Xct7HO2obMiI7TicFMlVQYaivSHUp2/wAaLjKO36hrY9jt4WCoVL8+KzNg6qmQzBPTJAZRlAOeFdfM4XYsNfQWyaEB8Y4AfQGU4T9GiLm2kXCXAEGK0n0LddvlyvndY3zPDs8J5IPtNi8IJAacNUU3SXwSM55PnVQWXbb8nEOdEgNxIAelheqaxNh+2PExY=;20:A0JmLwVFEy/TsyiZhC/vvn+nKmhda+BQBM7cKzOyRKUfZf+jm8TyHIC63xBj1fmdsgjCYDjpZpK6gVipMsrKdMmtXBPuOJ9vhJUqG33qoJ63QMsuXj5Y2SuELZ/6t67yEDdNrqVsLQOuGM23oQU14QlXVXq61gTzObtQqTF6z36Qjg8CWkliRnMaX4rwhLRks9+oW74GkGgQcbnOo5mgD6NJPGrRXlhAcbAAr1Sasb1iOGJN0DO6HDcTamJtAKtloxTaccMsrX1sQizkb7fiVxOrvSnmY9bUeaaSWfpwqLL3ogxABA6OzaEvcad+zcS1CEeB59pLkWKHBcuy2xGe+Ps3pk4NHMtp7GFx1Rx5F8AiLR7RtOGlh4K3Wj+VlYuv9au1h8xnj641dcNTu6nVARkO1kkhaUULzCDztyUmbdQryUjOLy0tILT/BrJN464MnFxOJ5U23jlDNFZYxYYFcShddwBubfDZfGED89LCOeDMEKqx/78RT+mvD8fiiUQd
X-Microsoft-Antispam-PRVS: <BN3PR0701MB1330C984F58A268BB44F2668DD520@BN3PR0701MB1330.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93003095)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BN3PR0701MB1330;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0701MB1330;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1330;4:yG4ITvUGYDliitMyF34TcVO531qeGKO83peSjezzVz5b3E/wacb6RrxcVnwADSb7igO4ddnPSXCvq9lX5QU+sYTFp2b1MyaT6OHcJ2ZMWbOVH0M7qaOjFqkTyR2eo3+7qMZd/jGKb0Nfo9iVNIASExy7XqeMnkMVf5GB51EKISwDtGH3rDihbuzSFrK7jIPWQViw9je/EAjtSz2BPXN5dqgZIVC1YzqB0voODXwWVUyKi1rlUWWq6SGtJ+U/L2mms3YLs9jmwQ1fO7FB1GENDZgoEPaM7mYXNXESNgd3mxE3v4rxLUwI2KB0Ga4tQH/D
X-Forefront-PRVS: 0738AF4208
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN3PR0701MB1330;23:0JVcDeq8v+U/RXFRCviSHnnxH6PY7mabsrbxETB?=
 =?us-ascii?Q?VqMPb54hxsL7XPJOYMjuvfV7k57/W42V+Nc/hdowr7wNGvGMuNh9vpy6POaj?=
 =?us-ascii?Q?WEYeFiTWsyGdnabBqSg4jtc1XKyYATfAGzrd6Z4EqKag8lOiocdtsIxo34uw?=
 =?us-ascii?Q?zt+qO/p/WO02M5PVB1vqcejTaJMlc0coiZHTaFvPUJoDxjs1QDEimxRryHQm?=
 =?us-ascii?Q?OodsqT3OKtRc2ckOJDNVshTEezNJum3O45wAmhix8x1Hovi76QWgQKn1mNsO?=
 =?us-ascii?Q?fnp35xuHjrCxCY6QEwlgCMZ1wGnZ5hV3uh7J2Qm+uZs+U7CH3/BDCofU44YZ?=
 =?us-ascii?Q?Vd76WYH1NQx6h6jIrbt5KKJ0VmZFLKCDUJogOb4CkDiQL1tBaz1414bIQRNz?=
 =?us-ascii?Q?bZg2v9PkautswQmfrL4grAph41Qpnn8pwQjUn1ZvsqB5/Y1cQWzqZL8H4zeU?=
 =?us-ascii?Q?kGCAHJhfJIV9T1i8hnmEF449+gw+xTbKam2MTUINa3fYyFMokH397iU7jYnr?=
 =?us-ascii?Q?WCaxULPA3PSxI6CI8Uhem1ao5ukNTWoIcTPSuXzG8Jt7BmYjOwFwiKSjMCQP?=
 =?us-ascii?Q?AzhRMlKJ5CayrkQKZPlRd3/9WhGOw1LkOTxlrRDptPu7Q+HC7lqPp624kf+h?=
 =?us-ascii?Q?n8FHixrJBaZ2wlGp9TrCUpDL1bFS5xvuJeKtCkGzPgcmc4mUd341qWXhNt74?=
 =?us-ascii?Q?TmH/hT8AClzRtqWqz0NLy8Xzsf9j5QFyH6TT1lh1ni4OhwarDwyFMa5/CP6/?=
 =?us-ascii?Q?SyoKK7QQCNDfICLPRtgoqbQgNpLGaKfcilL53Pfy7l7eA25hOevBCwa55rvJ?=
 =?us-ascii?Q?YN+ayH/DYmg2Mej/xf65v1/i9Nx548nXmBybPO7seQZzPebnJyHCR2bMKNf1?=
 =?us-ascii?Q?a03GKeUvFBe+8a+LdCse4tiHdbRA0Z0iff+og5eAge4/DC06QD3rNrK/xbDx?=
 =?us-ascii?Q?nbhuO4ehDV8pRSvSO8dvXU0R5hvBJSoii2kY/sdNreIPWyqU5fVSjYX5ka8X?=
 =?us-ascii?Q?12jxdLZKUe4gkSb4JGWAb7+luFt1jqLQm/VZEO10IbAx+ri/QOZXrG6v/Pus?=
 =?us-ascii?Q?+7P98+uVYvwCNYzAiiggXmQA3X+qdjlyMbsajFlq2L3CSaEN6CgfHYZRNE8J?=
 =?us-ascii?Q?Z6d6NVa/FzQuH+BY4UfFBtgX+SBTVhH3QT8FTtAAFHLt+CuuFtDnzlnJPnVd?=
 =?us-ascii?Q?s9SgxfyxU1huieA8=3D?=
X-Microsoft-Antispam-Message-Info: eMZs8NJcMgS11ZO6fpknjIitfEdZ1kpnHm/a7ei7gn1TlJUHaEL0w0qNsxVYDLc5i6mBpprFqG7HMmPqizTcCGpLhcLrDHIOIhA6CK8mCpEaTk8Ih2RzHsBO46DOOhlx/sofaI9mk5W/2e9FEOZyLp77zw8Zf5vXU8FgC4aCElhCsnR68MzkIZonUnWsKAQHA09xBIci1FiJGXNlN+/Z5Mt0YLIrlTiRtPqD7IGopEh9pjMmfJPi59iqlY8pIbtH2IsBNZSNPLUUJovnipK96M9VvQGUkSdnWWotmnSTnQRT2jICvaoESASPeIKb+FmYqrFG8NoAME3Nbw5+Vy2v8nCIUj5o4B26CWbsnjbzQnqP1AW9LsjnQRbttVE0J5Y0RKxKqxJa9Lb9pqLwP4zA9g==
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1330;6:PrIYGlhE6dPCXS3emSnqSPgyMTfXTJdpzqFyCpHYOL6o/ckF1jVbDFAvIMHR/gXxPX1rLeiCErHaZUDZeKqLIJMZSfBfR6vu2AebB3PxY7J37amunS322+bl3SFvX/kVdXflsEQNcl9BMC4zzBzaNpkNftBRVwrAxRALDenrztKcA3/Ae/nW+DwQwYRGlhqiAU5xMY2LDcZS8Hjzirn2cWbLKdOpiQsT/pfXik0gOaKU8991xeKJBUGHsNrpmYDDQ5005K2dHpJdqz8hQqxuX00rr+ZeBeV8VX6/OCvda9WeDbgFlTxrlbJyTcw/BPeshI7B2jh6mS0+ePVZxfkyC4ZA3Pw5MRXPXLaqSMPjm9v7UUTZag1LkDLtprsjCk7d39dU7nT9wW5jE7awA9bnHMOV91V+Ky+w2upUzDchCYZGX0E/gV1OSnd8GhzCptgtFvEye7IpHqE3koQWMlggDg==;5:Hso5bsmC1ipH6qaOTRe1umMQSi4OWt8kLk+Ft9zsy0bBx6NnUIzcJqI6pB1VEgqPXl7N+9Amagmy/4RP8OveyEUJ1HjYE0cHPBbMWAITDdB1PGKdXpMl2vDpmBv6VMIOExSK0vMlLt/FU7xDY/Dn3YNWagFISUc9Hr2moT2GIHI=;7:jLjD1FW/PsWZ3JIJBr3ZYT7dVbkC3agIgbtIgk224DqAKYhvpg82ZqL++vYhCpKnICpXZmg4JKYHyUPue+73FDKFCUuftrW4LJPtt+ZMw4DbJB0d80q0zZZlnFdy3enamKNgu3CHf/46yysdxdOr1rdLVRVB2AZ2vGlNc52I7EYNtfqj6u6JNd1PxH8GuOxT7A6COm0jm8dBXpwS52t//oj2PitPWsXWtsa6ZXHc23LAW8IPr8TPSwBgTdOotS9H
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1330;20:y3yup4A20ZAR7muxXYiz7Lu9PdAbgLYsghGY/8GlHcGzFhRbI9dFwt8DyNGzeBPlxUKfVBwoGEmBgGZe1BThtQsbntt4A45rLxH4zLLa/4T7bsCSKrmIJGCuPuYZk8Gdz+kLZGidNMuJhqznOlMlqcHbzjQoZLmbOVKKsR3IINatDSyJvFXS/upnXcmrsG7pORtp6ZND8I1yFKWlPZvysE6qoqinLOHtuUaWHBf+o1IWQptIvPVgYagsDnmY139G
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2018 17:59:25.2359
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f192989d-12a9-42ae-a5db-08d5eda15d40
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0701MB1330
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch adds usbssp_queue_bulk_tx and usbssp_queue_int_tx function
that prepares TD, adds TD to transfer ring and arms the transfer.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/usbssp/gadget-ring.c | 286 ++++++++++++++++++++++++++++++-
 1 file changed, 285 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/usbssp/gadget-ring.c b/drivers/usb/usbssp/gadget-ring.c
index a0cfce0dc49d..4bb13f9e311a 100644
--- a/drivers/usb/usbssp/gadget-ring.c
+++ b/drivers/usb/usbssp/gadget-ring.c
@@ -1573,6 +1573,74 @@ static int prepare_transfer(struct usbssp_udc *usbssp_data,
 	return 0;
 }
 
+unsigned int count_trbs(u64 addr, u64 len)
+{
+	unsigned int num_trbs;
+
+	num_trbs = DIV_ROUND_UP(len + (addr & (TRB_MAX_BUFF_SIZE - 1)),
+				TRB_MAX_BUFF_SIZE);
+	if (num_trbs == 0)
+		num_trbs++;
+
+	return num_trbs;
+}
+
+static inline unsigned int count_trbs_needed(struct usbssp_request *req_priv)
+{
+	return count_trbs(req_priv->request.dma, req_priv->request.length);
+}
+
+static unsigned int count_sg_trbs_needed(struct usbssp_request *req_priv)
+{
+	struct scatterlist *sg;
+	unsigned int i, len, full_len, num_trbs = 0;
+
+	full_len = req_priv->request.length;
+
+	for_each_sg(req_priv->sg, sg, req_priv->num_pending_sgs, i) {
+		len = sg_dma_len(sg);
+		num_trbs += count_trbs(sg_dma_address(sg), len);
+		len = min_t(unsigned int, len, full_len);
+		full_len -= len;
+		if (full_len == 0)
+			break;
+	}
+
+	return num_trbs;
+}
+
+static void check_trb_math(struct usbssp_request *req_priv, int running_total)
+{
+	if (unlikely(running_total != req_priv->request.length))
+		dev_err(req_priv->dep->usbssp_data->dev,
+			"%s - ep %#x - Miscalculated tx length, "
+			"queued %#x (%d), asked for %#x (%d)\n",
+			__func__,
+			req_priv->dep->endpoint.desc->bEndpointAddress,
+			running_total, running_total,
+			req_priv->request.length,
+			req_priv->request.length);
+}
+
+static void giveback_first_trb(struct usbssp_udc *usbssp_data,
+			       unsigned int ep_index,
+			       unsigned int stream_id,
+			       int start_cycle,
+			       struct usbssp_generic_trb *start_trb)
+{
+	/*
+	 * Pass all the TRBs to the hardware at once and make sure this write
+	 * isn't reordered.
+	 */
+	wmb();
+	if (start_cycle)
+		start_trb->field[3] |= cpu_to_le32(start_cycle);
+	else
+		start_trb->field[3] &= cpu_to_le32(~TRB_CYCLE);
+
+	usbssp_ring_ep_doorbell(usbssp_data, ep_index, stream_id);
+}
+
 /*
  * USBSSP uses normal TRBs for both bulk and interrupt. When the interrupt
  * endpoint is to be serviced, the DC will consume (at most) one TD. A TD
@@ -1628,12 +1696,228 @@ static u32 usbssp_td_remainder(struct usbssp_udc *usbssp_data,
 	return (total_packet_count - ((transferred + trb_buff_len) / maxp));
 }
 
+static int usbssp_align_td(struct usbssp_udc *usbssp_data,
+			   struct usbssp_request *req_priv, u32 enqd_len,
+			   u32 *trb_buff_len, struct usbssp_segment *seg)
+{
+	struct device *dev = usbssp_data->dev;
+	unsigned int unalign;
+	unsigned int max_pkt;
+	u32 new_buff_len;
+
+	max_pkt = GET_MAX_PACKET(
+			usb_endpoint_maxp(req_priv->dep->endpoint.desc));
+	unalign = (enqd_len + *trb_buff_len) % max_pkt;
+
+	/* we got lucky, last normal TRB data on segment is packet aligned */
+	if (unalign == 0)
+		return 0;
+
+	dev_dbg(usbssp_data->dev, "Unaligned %d bytes, buff len %d\n",
+		unalign, *trb_buff_len);
+
+	/* is the last nornal TRB alignable by splitting it */
+	if (*trb_buff_len > unalign) {
+		*trb_buff_len -= unalign;
+		dev_dbg(usbssp_data->dev, "split align, new buff len %d\n",
+			*trb_buff_len);
+		return 0;
+	}
+
+	/*
+	 * We want enqd_len + trb_buff_len to sum up to a number aligned to
+	 * number which is divisible by the endpoint's wMaxPacketSize. IOW:
+	 * (size of currently enqueued TRBs + remainder) % wMaxPacketSize == 0.
+	 */
+	new_buff_len = max_pkt - (enqd_len % max_pkt);
+
+	if (new_buff_len > (req_priv->request.length - enqd_len))
+		new_buff_len = (req_priv->request.length - enqd_len);
+
+	/* create a max max_pkt sized bounce buffer pointed to by last trb */
+	if (req_priv->direction) {
+		sg_pcopy_to_buffer(req_priv->request.sg,
+				req_priv->request.num_mapped_sgs,
+				seg->bounce_buf, new_buff_len, enqd_len);
+		seg->bounce_dma = dma_map_single(dev, seg->bounce_buf,
+						max_pkt, DMA_TO_DEVICE);
+	} else {
+		seg->bounce_dma = dma_map_single(dev, seg->bounce_buf,
+						max_pkt, DMA_FROM_DEVICE);
+	}
+
+	if (dma_mapping_error(dev, seg->bounce_dma)) {
+		/* try without aligning.*/
+		dev_warn(usbssp_data->dev,
+			"Failed mapping bounce buffer, not aligning\n");
+		return 0;
+	}
+	*trb_buff_len = new_buff_len;
+	seg->bounce_len = new_buff_len;
+	seg->bounce_offs = enqd_len;
+
+	dev_dbg(usbssp_data->dev, "Bounce align, new buff len %d\n",
+			*trb_buff_len);
+
+	return 1;
+}
+
+
 int usbssp_queue_bulk_tx(struct usbssp_udc *usbssp_data,
 			 gfp_t mem_flags,
 			 struct usbssp_request *req_priv,
 			 unsigned int ep_index)
 {
-	/*TODO: function musb be implemented*/
+	struct usbssp_ring *ring;
+	struct usbssp_td *td;
+	struct usbssp_generic_trb *start_trb;
+	struct scatterlist *sg = NULL;
+	bool more_trbs_coming = true;
+	bool need_zero_pkt = false;
+	bool first_trb = true;
+	unsigned int num_trbs;
+	unsigned int start_cycle, num_sgs = 0;
+	unsigned int enqd_len, block_len, trb_buff_len, full_len;
+	int sent_len, ret;
+	u32 field, length_field, remainder;
+	u64 addr, send_addr;
+
+	ring = usbssp_request_to_transfer_ring(usbssp_data, req_priv);
+	if (!ring)
+		return -EINVAL;
+
+	full_len = req_priv->request.length;
+	/* If we have scatter/gather list, we use it. */
+	if (req_priv->request.num_sgs) {
+		num_sgs = req_priv->num_pending_sgs;
+		sg = req_priv->sg;
+		addr = (u64) sg_dma_address(sg);
+		block_len = sg_dma_len(sg);
+		num_trbs = count_sg_trbs_needed(req_priv);
+	} else {
+		num_trbs = count_trbs_needed(req_priv);
+		addr = (u64) req_priv->request.dma;
+		block_len = full_len;
+	}
+
+	ret = prepare_transfer(usbssp_data, &usbssp_data->devs,
+			ep_index, req_priv->request.stream_id,
+			num_trbs, req_priv, 0, mem_flags);
+	if (unlikely(ret < 0))
+		return ret;
+
+	/* Deal with request.zero - need one more td/trb */
+	if (req_priv->request.zero && req_priv->num_tds_done > 1)
+		need_zero_pkt = true;
+
+	td = &req_priv->td[0];
+
+	dev_dbg(usbssp_data->dev, "Queue Bulk transfer to %s - ep_index: %d,"
+		" num trb: %d, block len %d, nzp: %d\n",
+		req_priv->dep->name, ep_index,
+		num_trbs, block_len, need_zero_pkt);
+
+	/*
+	 * Don't give the first TRB to the hardware (by toggling the cycle bit)
+	 * until we've finished creating all the other TRBs. The ring's cycle
+	 * state may change as we enqueue the other TRBs, so save it too.
+	 */
+	start_trb = &ring->enqueue->generic;
+	start_cycle = ring->cycle_state;
+	send_addr = addr;
+
+	/* Queue the TRBs, even if they are zero-length */
+	for (enqd_len = 0; first_trb || enqd_len < full_len;
+	     enqd_len += trb_buff_len) {
+		field = TRB_TYPE(TRB_NORMAL);
+
+		/* TRB buffer should not cross 64KB boundaries */
+		trb_buff_len = TRB_BUFF_LEN_UP_TO_BOUNDARY(addr);
+		trb_buff_len = min_t(unsigned int, trb_buff_len, block_len);
+
+		if (enqd_len + trb_buff_len > full_len)
+			trb_buff_len = full_len - enqd_len;
+
+		/* Don't change the cycle bit of the first TRB until later */
+		if (first_trb) {
+			first_trb = false;
+			if (start_cycle == 0)
+				field |= TRB_CYCLE;
+		} else
+			field |= ring->cycle_state;
+
+		/* Chain all the TRBs together; clear the chain bit in the last
+		 * TRB to indicate it's the last TRB in the chain.
+		 */
+		if (enqd_len + trb_buff_len < full_len) {
+			field |= TRB_CHAIN;
+			if (trb_is_link(ring->enqueue + 1)) {
+				if (usbssp_align_td(usbssp_data, req_priv,
+					enqd_len, &trb_buff_len,
+					ring->enq_seg)) {
+					send_addr = ring->enq_seg->bounce_dma;
+					/* assuming TD won't span 2 segs */
+					td->bounce_seg = ring->enq_seg;
+				}
+			}
+		}
+		if (enqd_len + trb_buff_len >= full_len) {
+			field &= ~TRB_CHAIN;
+			field |= TRB_IOC;
+			more_trbs_coming = false;
+			td->last_trb = ring->enqueue;
+		}
+
+		/* Only set interrupt on short packet for OUT endpoints */
+		if (!req_priv->direction)
+			field |= TRB_ISP;
+
+		/* Set the TRB length, TD size, and interrupter fields. */
+		remainder = usbssp_td_remainder(usbssp_data, enqd_len,
+						trb_buff_len, full_len, req_priv,
+						more_trbs_coming);
+
+		length_field = TRB_LEN(trb_buff_len) |
+			TRB_TD_SIZE(remainder) |
+			TRB_INTR_TARGET(0);
+
+		queue_trb(usbssp_data, ring, more_trbs_coming | need_zero_pkt,
+			lower_32_bits(send_addr),
+			upper_32_bits(send_addr),
+			length_field,
+			field);
+
+		addr += trb_buff_len;
+		sent_len = trb_buff_len;
+
+		while (sg && sent_len >= block_len) {
+			/* New sg entry */
+			--num_sgs;
+			sent_len -= block_len;
+			if (num_sgs != 0) {
+				sg = sg_next(sg);
+				block_len = sg_dma_len(sg);
+				addr = (u64) sg_dma_address(sg);
+				addr += sent_len;
+			}
+		}
+		block_len -= sent_len;
+		send_addr = addr;
+	}
+
+	if (need_zero_pkt) {
+		ret = prepare_transfer(usbssp_data, &usbssp_data->devs,
+				ep_index, req_priv->request.stream_id,
+				1, req_priv, 1, mem_flags);
+		req_priv->td[1].last_trb = ring->enqueue;
+		field = TRB_TYPE(TRB_NORMAL) | ring->cycle_state | TRB_IOC;
+		queue_trb(usbssp_data, ring, 0, 0, 0,
+			TRB_INTR_TARGET(0), field);
+	}
+
+	check_trb_math(req_priv, enqd_len);
+	giveback_first_trb(usbssp_data, ep_index, req_priv->request.stream_id,
+			start_cycle, start_trb);
 	return 0;
 }
 
-- 
2.17.1

