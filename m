Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABE3C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51A6721476
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="h2ou7Qhc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51A6721476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbeGLF4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 01:56:00 -0400
Received: from mail-eopbgr710068.outbound.protection.outlook.com ([40.107.71.68]:64272
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727113AbeGLFz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 01:55:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=in/d4LcxfPe5L0sgq2Sn8WTgyBZLlb9GBRdMKSv4j7Q=;
 b=h2ou7QhclPx5pdxytxbEcl/SxeR09UpUpMm+goiV4NCJJhN5lWUC8zGCdoA/ZF0rxXUW50eWCQODQkzi/vUSBq9X3fisYEQKR4aJ0Tk0MDNyDJ6jDVGPJdMg6cflxlSjKXi6RSTzQQooXXGZMwsexKvFxQ93dc+D+uLr/cSTxWg=
Received: from DM5PR07CA0027.namprd07.prod.outlook.com (2603:10b6:3:16::13) by
 BY2PR07MB2296.namprd07.prod.outlook.com (2a01:111:e400:c50d::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.17; Thu, 12 Jul
 2018 05:48:01 +0000
Received: from DM3NAM05FT017.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::209) by DM5PR07CA0027.outlook.office365.com
 (2603:10b6:3:16::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.930.21 via Frontend
 Transport; Thu, 12 Jul 2018 05:48:00 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM3NAM05FT017.mail.protection.outlook.com (10.152.98.126) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.973.9 via Frontend Transport; Thu, 12 Jul 2018 05:48:00 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5lkwA032054
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 11 Jul 2018 22:47:59 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 12 Jul 2018 07:48:06 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Jul 2018 07:48:06 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5lofe029759;
        Thu, 12 Jul 2018 06:47:50 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6C5loNp029758;
        Thu, 12 Jul 2018 06:47:50 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 18/31] usb: usbssp: added handling of Port Reset event.
Date:   Thu, 12 Jul 2018 06:47:15 +0100
Message-ID: <1531374448-26532-19-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1531374448-26532-1-git-send-email-pawell@cadence.com>
References: <1531374448-26532-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(39860400002)(396003)(2980300002)(199004)(189003)(36092001)(51416003)(109986005)(478600001)(107886003)(36756003)(4720700003)(105596002)(106466001)(6666003)(5660300001)(47776003)(4326008)(8936002)(87636003)(8676002)(246002)(1671002)(48376002)(26826003)(7636002)(305945005)(50466002)(356003)(2906002)(50226002)(476003)(126002)(2616005)(11346002)(486006)(316002)(76176011)(446003)(54906003)(42186006)(16586007)(26005)(336012)(86362001)(186003)(14444005)(426003)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR07MB2296;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT017;1:1R8NzMvAjvWvR7KWUI7qvY807uJntTWbCMHMrHC+sZcMkc6d8riHW4SzakbyxQXr3fB+g34yuP0dSiYfnQ898HkiRPbg0cKjXtj5wqfKAJ7meCoKXscaMTY4m4tLDMGK
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24b902e3-f5ae-4ba9-c242-08d5e7bb06fc
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BY2PR07MB2296;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2296;3:1RDRTg2EtQq+oPXks/bJPHgy0Dqrw+Dam3GUmVB3Ag+zqfFB1taxJXnZCp6dfZHNnv1aXl43KVk6ovENj4fTnWJz5LRca2lHqtcafEeU+T/3CQ/Da/fQ61XQ5nhawrc9BmeNj28rgyLN4BJoUCcpKc0anW+92e7XRLC9Ubh0N+QO9Q3ABOa2S8dmhwfcqk0MdERsDVd8HtnOe2gVJf4oTKLUrjzzjRBF8fQFjRwgfc0UQpMkTzHFP6tBcaiwedtwh9cgS1XtognLCBkRoxhN0wcep9l2XVZtOGiKBX2ltwohrJs04G6hXzyyKhUERC4yokZ3a4PziMFDQZ2ttrcJLw9KmvyJ6/pLzK1CiiS8bf4=;25:dDWeyO1b40TKGr18L3sheX7uonTprnma/V63yJwPZT8U1G31mziLE+JMMwyAnnw1hod/GAiUUAPsOoVRz02RgSy/0/gQ1Ui3DTR28+gPtWXp/NoED31om9Ai8cD2w9sRAK4YSW8MNBc1SKSkIF/oYsG4LQdoCHSZVsepuAFyBfZYnxrquho0ldVFDTTR8e0ZNpqsWr9MaZ3QvDblfddFfwlNOIqLJgw0nuXadIvel5UPFSQS0T+xGedIDj0uFlTJV+TpfMgJl8dFZ4ohI3cO6NUamU3IBlEmBGq2mji2Tl+nevKkUuBWzJjzfvn36oKP/rwuwwBKn8/WkvJxNUZLkA==
X-MS-TrafficTypeDiagnostic: BY2PR07MB2296:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2296;31:jfKHnR/syTjqHDAZKfwEtZLyN0LkkTIgb85NhNOp05zvfruIrHTsmJrme496JugaH/9lTMY7qAaoxZTb5TdCyyeBe55RW4/IG0G+a/JWrE9jZqVwqL8sHljlagdZ9BwEvLZR9pmX29kT/56htHSEEyv/w/uEq3p7UOAk34DwZBWwumpNkyPsKxr6NTRGocOgJKiM77a6HxFXV5GnIE4qOTW5Mw8tI4umEy38WLSazco=;20:Z8bWWbaQLjZ4N4cdLfO7oWfBCbLAeAhYo/5459HkffOPAifDl85ht94A8UtrRGMynlvwLPW3wo7PSZ9jlcjYg0ZytctLj8srYoeyPqRFvt5i4HYc3BnXv3Mp+tdUorulEqarB12LXRV9UJ0/DdDyCgoF58Y3kWaCX0+M4TWONRxxyAZBWYnhvH6URlxdMnKBaYukkLssP5OE2CDICKUmyt6cVlsxQmqLQAZCNexzfCUWFBZ/Xad4djl+uiKi45BidQOYme5XsN/rgx5GW4923UzHra1He02b4LJoFebwHWNAOCRl7Ey9nU5/lOphW1fXN0v0Y9CxV2ppu+I3CcZCTRwbipM0FVcLV+y8fohkQ0hYLU82FqOJpaniWj8Vq1Pxg+9V+eSAjfo5ovNJ0toBS2jYrgLUSu+7MeRCqrz/ohxDYvNvKOPdcuILWaobVVpNLeVxFWpG3R7buULkqqsEy2E2nwBBxTY16jXxtYanMMDT51sW2+y1eH0adCZCiHFp
X-Microsoft-Antispam-PRVS: <BY2PR07MB22964CF8186C087543BCD64BDD590@BY2PR07MB2296.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(93006095)(93003095)(10201501046)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BY2PR07MB2296;BCL:0;PCL:0;RULEID:;SRVR:BY2PR07MB2296;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2296;4:sOzmyw+qQJg/1Vk4+/WWQSysBN+HcUrb9qAdQ8KuaSrxJcbT5pbr8OOB6jvEvh5+kUzWacrbWbcVZyFSpS6MwDB1Ls2YCleehKfr2X8ZV1y3fi9q1JT7gcAvM3M7+0GY2r6Hqz2qSIbD488mVt5DNFezNz+d6MgPJ4ZYCKTiginsnvlcKx7lOjnhKtUlxOG17XfJ1H/8clJXKE+O/AZH9eu9Vjmw+ujkZ1Ql6FAPZS5SWBTjSm15xGwWh128ZU3b2mTXvy1v99DTEmYbd2feHr6l67po9uoH9J11i6mnTdd0IeqyFvyO3pyJJr66naiY
X-Forefront-PRVS: 0731AA2DE6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR07MB2296;23:joqU4+Q0DVhrNExMYL2CfW82GoQkkKu53erRiyF21?=
 =?us-ascii?Q?+HdDev/st090gUv3vLh26R4Vxzhm3PBIY5OntXMuyGbldLSroxkwZ4h0vCez?=
 =?us-ascii?Q?NgM1W0kik/3oJ+ddFgrK4RP1Pxaon5Xo/FPFUiHo0Ne9uzgHQG/11Pcg6vJs?=
 =?us-ascii?Q?Vr4vS4OkokosJAvWx6Cp6QQpC46NwHPri3i7hWMewAE6XfvPbqvkEw1d6Qxu?=
 =?us-ascii?Q?NuTDyCby5jh4doaYyKpKFS5j4XAB6CPMNtEkrkVZ7+Hxq5ZLUUxNjqTzSAp+?=
 =?us-ascii?Q?cbzXQsjXviodxUr+Ca+NWB+KpkvfsFvQDBKtFPz7NawG4UiIad4gos1PqXMy?=
 =?us-ascii?Q?wbTCHZu5RndD2cKyADENKNPZWLiCgpzpyGO4WKJkMA22t1qOrBuuKHI3hYJL?=
 =?us-ascii?Q?FOQ8Z9l8ZWUm2cClKOKL+TzxIPN41I+qUjJL53dDmNeH6awLCwTkBxhDmm7D?=
 =?us-ascii?Q?mXP7ii1zBYZEnUt6YiqY9eYoTZGtQvngqEnbzLMNg9pVEnbmGtgP2qR6CJOt?=
 =?us-ascii?Q?NhTVMDmtz2Eo+KCFRRkA6Gf1fvcmjhWk7ZLacVJHT6zWUtpTOCRRCuyiSeDQ?=
 =?us-ascii?Q?H13PHg2bPTDEOoJurE3wQezDJ0dhN+hW+YzkYiZxkONDaYSJKqCuFA384gsR?=
 =?us-ascii?Q?ltVTEn8dnY02Y8iWIi5FvDjrHIWOvRgkj1h3TsCaBr/iHE/iHQX/sriwH86Z?=
 =?us-ascii?Q?a37c+F4AtuVjks4tMXL9eyS917UANFqUf6OQ8CLljvt1KLZw9VZsDTNVVsf6?=
 =?us-ascii?Q?WioMGCROZK4NYQt1Z6EQfrALRDCE0qSoOfkGDrA2VVxwZbk0h08jKHDdrMTq?=
 =?us-ascii?Q?wvjQHj3I3pjFjzvGZuKDjH/X4nU+8dDVA/pEhvPY1rlnGscIvzwK/VykHLrj?=
 =?us-ascii?Q?bhebIZmvMf+TICA2PiwDUcWwV9A4Kfjz+plap/ohyvCQWPgho9vKE+4+iVNV?=
 =?us-ascii?Q?RyuJYDUffxIX7zHkXgSSFv8hc9Ib/pmz1SUQTD4Is1OXs5cQRKPce4a1GyaE?=
 =?us-ascii?Q?lg3hBNK4vw6rjbzLvcmrodbkbF0DRVzdXZWwAk1eTtmGjt5kpt3kVLy+3Xkm?=
 =?us-ascii?Q?P9VFbgLgxffFbl+fFBI3RavMA9jJDqa5WxE7CFr3ZP3S/mmfs/JPVZirL1OT?=
 =?us-ascii?Q?OVcFqn8vNLngn2Ib60Bsnf3TIWLrxm2c4cT6ZpjQBdaxn6kBbsXXg=3D=3D?=
X-Microsoft-Antispam-Message-Info: LcRoqk6uxm9gifkDEKtlwhaOZ1HbBjSm8QJ+5dkK94T87vNmKbYjjY0nBoW+4/GgLgkFvMS8kg/+bP2HLecMhvFdvjS1Cx6zMyFAPdZgHaPTrFbJNZvCgn+xHIWRN3h8Py6XHuw8glzHZoP7h9OPDxgEUm6YM5hVzZMR6Ldu7TEfV+8H49XxL/jQeicF7PIjLOgDhmUg+YCYpwHgz3EH3iWtT2sY3+x56aRyb5fMNOObvqFAClxY7GIoPMzfuqeWhOcufYRtuvVUgVzlUguQUyGAhRPgPWijVqWs2wTR5lao0MsOIttoKMBw8dZcHNbTrC3n4PR1aMv2CfRMHU6bmyM3ZqYpcXYxjonCq10Q4hJOVqJDrXwTp0FU/cA0rCgphZKQ+S14iAXtKA5dxCvKgQ==
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2296;6:jwKW+wOYxPcKKv8kmmppFGAlNaocPphn6HszxzOLj94nA7NLlVCJuk0xdnX2AfoHTVpRnGLaSWL2PvMErWdm8CocqpNF6ILKyjQTAPRyorJYOBQ3jbAykgZ3DQSp/0veZXSAV5E1vGFlFJY4Jc1OsuoM+ii1GqgkX7CY/SApu313DpxJdT3TRMu9yFpx1SdFqXpTRqIY/2IRMYXaAi8lX6isJi2wue2ekASgiePgEaPe3PCBVcf7LHPpwxYf6g70EtnIiLMHTmCkvuIThi2nJScoOr98B8FkqirnxowYzeatD+w6lYSHfuNUIHKdc7FzTcMOKVoz1oq+dDYgzx8CxGFZ958FrI3QxSJFDMD0XLOmr+KcKm4mAvPtXzt70M2eEcFyrgdF3hfVWb5fq/jXvoiZRCRRFzr374dVuPX4b3HjEU0xGqbFMM4FmceNq46aJhfKO0VWZHWoDjbPB3YhUA==;5:eYPzwMyNfsMJ4cTVhH+vOXQ9XVRCRX4aVI12YAbQxwZcGWcfnchvLvkNOPmmRo/YRqxyvL7W2xBWhzo+m9+Q8AuvXdAHllqTxVo5+OcGAcnePO5iZM+JX76ZM8YXV88vSxg0pu0s5hgSa7c5xszYib7uuaLsec6jjnjue4CVqe0=;24:Xt0xKhx2zAIfPnM25lp67Lfkg/SUnWgTjxw0tEBXgwh5DN4vRuYKprGwA1iDOzeqdxwNsTlumsL6Y38fd87Co8dO8pDHP56A6mQuH1+mCig=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2296;7:hoM53vuBlb6tqEvZPZKtuaNU+2b/uZU0frSH08xWGmlWoIxb91IAef7Ni1u+6BKsiLZgahW2VFqNx9fa+o8GWUE76wgZ0J6CWvD5xvuqbjfRh1VwRIeNE1ICLaN6sdwdHu3qJASss1rDKtH5S8IXZVW3YVlD4aGunE8pr8kLfOLjIOHQ8iRVsqH6nhXfj8SU5SISLDNEXeAjNW0K1SkS2L9Iw1mhYLkQO9IJ3nVgLSCrDBcYcou4KFgUhqo6Co4K;20:TTIvbvt6g4EEF7oRctP3BChsXeBG/aOcpb2UyQRE2i3tfnGCE1zrqwghvn3GitV2bshhTW94ETq2au3l6u+irTHppmREE5gpNTwFTrVf39D8drvi7dO54DhkJgXEuxY+T7RNVp+/288fY/+TN3bEX+oh7zx3lslwVPmcjZf2oMyG4tzS5vZvTfMjzlebop+du3jfYkcpjC2EgT+NbbDFD2Un8W+V7V1UsN4bGpgibnTfH+eDIM4SXEaUpuXHYf+G
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 05:48:00.2265
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24b902e3-f5ae-4ba9-c242-08d5e7bb06fc
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR07MB2296
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch adds functionality used during resetting USB port.
During this process driver must finish all queued transfers,
and enter the controller to default state.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/usbssp/gadget-dbg.c |   9 +
 drivers/usb/usbssp/gadget-mem.c | 100 +++++++++++
 drivers/usb/usbssp/gadget.c     | 304 +++++++++++++++++++++++++++++++-
 drivers/usb/usbssp/gadget.h     |  12 ++
 4 files changed, 424 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/usbssp/gadget-dbg.c b/drivers/usb/usbssp/gadget-dbg.c
index 88e4e8d38e4b..cb744e26ab39 100644
--- a/drivers/usb/usbssp/gadget-dbg.c
+++ b/drivers/usb/usbssp/gadget-dbg.c
@@ -12,6 +12,15 @@
 
 #include "gadget.h"
 
+char *usbssp_get_slot_state(struct usbssp_udc *usbssp_data,
+		struct usbssp_container_ctx *ctx)
+{
+	struct usbssp_slot_ctx *slot_ctx = usbssp_get_slot_ctx(usbssp_data, ctx);
+	int state = GET_SLOT_STATE(le32_to_cpu(slot_ctx->dev_state));
+
+	return usbssp_slot_state_string(state);
+}
+
 void usbssp_dbg_trace(struct usbssp_udc *usbssp_data,
 		      void (*trace)(struct va_format *),
 		      const char *fmt, ...)
diff --git a/drivers/usb/usbssp/gadget-mem.c b/drivers/usb/usbssp/gadget-mem.c
index fd3c0557feef..60c78d1d7f11 100644
--- a/drivers/usb/usbssp/gadget-mem.c
+++ b/drivers/usb/usbssp/gadget-mem.c
@@ -710,6 +710,106 @@ int usbssp_alloc_priv_device(struct usbssp_udc *usbssp_data, gfp_t flags)
 	return 0;
 }
 
+void usbssp_copy_ep0_dequeue_into_input_ctx(struct usbssp_udc *usbssp_data)
+{
+	struct usbssp_device *priv_dev;
+	struct usbssp_ep_ctx *ep0_ctx;
+	struct usbssp_ring *ep_ring;
+
+	priv_dev = &usbssp_data->devs;
+	ep0_ctx = usbssp_get_ep_ctx(usbssp_data, priv_dev->in_ctx, 0);
+	ep_ring = priv_dev->eps[0].ring;
+	/*
+	 * We don't keep track of the dequeue pointer very well after a
+	 * Set TR dequeue pointer, so we're setting the dequeue pointer of the
+	 * device to our enqueue pointer.  This should only be called after a
+	 * configured device has reset, so all control transfers should have
+	 * been completed or cancelled before the reset.
+	 */
+	ep0_ctx->deq = cpu_to_le64(usbssp_trb_virt_to_dma(ep_ring->enq_seg,
+			ep_ring->enqueue) | ep_ring->cycle_state);
+}
+
+/* Setup an DC private device for a Set Address command */
+int usbssp_setup_addressable_priv_dev(struct usbssp_udc *usbssp_data)
+{
+	struct usbssp_device *dev_priv;
+	struct usbssp_ep_ctx *ep0_ctx;
+	struct usbssp_slot_ctx *slot_ctx;
+	u32 max_packets;
+
+	dev_priv = &usbssp_data->devs;
+	/* Slot ID 0 is reserved */
+	if (usbssp_data->slot_id == 0 || !dev_priv->gadget) {
+		usbssp_warn(usbssp_data,
+			"Slot ID %d is not assigned to this device\n",
+			usbssp_data->slot_id);
+		return -EINVAL;
+	}
+
+	ep0_ctx = usbssp_get_ep_ctx(usbssp_data, dev_priv->in_ctx, 0);
+	slot_ctx = usbssp_get_slot_ctx(usbssp_data, dev_priv->in_ctx);
+
+	/* 3) Only the control endpoint is valid - one endpoint context */
+	slot_ctx->dev_info |= cpu_to_le32(LAST_CTX(1) /*| udev->route*/);
+
+	switch (dev_priv->gadget->speed) {
+	case USB_SPEED_SUPER_PLUS:
+		slot_ctx->dev_info |= cpu_to_le32(SLOT_SPEED_SSP);
+		max_packets = MAX_PACKET(512);
+		break;
+	case USB_SPEED_SUPER:
+		slot_ctx->dev_info |= cpu_to_le32(SLOT_SPEED_SS);
+		max_packets = MAX_PACKET(512);
+		break;
+	case USB_SPEED_HIGH:
+		slot_ctx->dev_info |= cpu_to_le32(SLOT_SPEED_HS);
+		max_packets = MAX_PACKET(64);
+		break;
+	case USB_SPEED_FULL:
+		slot_ctx->dev_info |= cpu_to_le32(SLOT_SPEED_FS);
+		max_packets = MAX_PACKET(64);
+		break;
+	case USB_SPEED_LOW:
+		slot_ctx->dev_info |= cpu_to_le32(SLOT_SPEED_LS);
+		max_packets = MAX_PACKET(8);
+		break;
+	case USB_SPEED_WIRELESS:
+		usbssp_dbg(usbssp_data,
+			"USBSSP doesn't support wireless speeds\n");
+		return -EINVAL;
+	default:
+		/* Speed was not set , this shouldn't happen. */
+		return -EINVAL;
+	}
+
+	if (!usbssp_data->devs.port_num)
+		return -EINVAL;
+
+	slot_ctx->dev_info2 |=
+			cpu_to_le32(ROOT_DEV_PORT(usbssp_data->devs.port_num));
+	slot_ctx->dev_state |= (usbssp_data->device_address & DEV_ADDR_MASK);
+
+	ep0_ctx->tx_info = EP_AVG_TRB_LENGTH(0x8);
+		/*cpu_to_le32(EP_MAX_ESIT_PAYLOAD_LO(max_esit_payload) |*/
+
+	/* Step 4 - ring already allocated */
+	/* Step 5 */
+	ep0_ctx->ep_info2 = cpu_to_le32(EP_TYPE(CTRL_EP));
+
+	/* EP 0 can handle "burst" sizes of 1, so Max Burst Size field is 0 */
+	ep0_ctx->ep_info2 |= cpu_to_le32(MAX_BURST(0) | ERROR_COUNT(3) |
+			max_packets);
+
+	ep0_ctx->deq = cpu_to_le64(dev_priv->eps[0].ring->first_seg->dma |
+			dev_priv->eps[0].ring->cycle_state);
+
+	trace_usbssp_setup_addressable_priv_device(dev_priv);
+	/* Steps 7 and 8 were done in usbssp_alloc_priv_device() */
+
+	return 0;
+}
+
 struct usbssp_command *usbssp_alloc_command(struct usbssp_udc *usbssp_data,
 					    bool allocate_completion,
 					    gfp_t mem_flags)
diff --git a/drivers/usb/usbssp/gadget.c b/drivers/usb/usbssp/gadget.c
index 0ae4e1c07035..f198d7e308c6 100644
--- a/drivers/usb/usbssp/gadget.c
+++ b/drivers/usb/usbssp/gadget.c
@@ -72,7 +72,27 @@ void usbssp_bottom_irq(struct work_struct *work)
 	}
 
 	if (usbssp_data->defered_event & EVENT_USB_RESET) {
-		/*TODO: implement handling of USB_RESET*/
+		__le32 __iomem *port_regs;
+		u32 temp;
+
+		usbssp_dbg(usbssp_data, "Beginning USB reset device sequence\n");
+
+		/*Reset Device Command*/
+		usbssp_data->defered_event &= ~EVENT_USB_RESET;
+		usbssp_reset_device(usbssp_data);
+		usbssp_data->devs.eps[0].ep_state |= USBSSP_EP_ENABLED;
+		usbssp_data->defered_event &= ~EVENT_DEV_CONNECTED;
+
+		usbssp_enable_device(usbssp_data);
+		if ((usbssp_data->gadget.speed == USB_SPEED_SUPER) ||
+		    (usbssp_data->gadget.speed == USB_SPEED_SUPER_PLUS)) {
+			usbssp_dbg(usbssp_data, "Set U1/U2 enable\n");
+			port_regs = usbssp_get_port_io_addr(usbssp_data);
+			temp = readl(port_regs+PORTPMSC);
+			temp &= ~(PORT_U1_TIMEOUT_MASK | PORT_U2_TIMEOUT_MASK);
+			temp |= PORT_U1_TIMEOUT(1) | PORT_U2_TIMEOUT(1);
+			writel(temp, port_regs+PORTPMSC);
+		}
 	}
 
 	/*handle setup packet*/
@@ -495,6 +515,107 @@ int usbssp_halt_endpoint(struct usbssp_udc *usbssp_data, struct usbssp_ep *dep,
 	return 0;
 }
 
+/*
+ * This submits a Reset Device Command, which will set the device state to 0,
+ * set the device address to 0, and disable all the endpoints except the default
+ * control endpoint. The USB core should come back and call
+ * usbssp_address_device(), and then re-set up the configuration.
+ *
+ * Wait for the Reset Device command to finish. Remove all structures
+ * associated with the endpoints that were disabled. Clear the input device
+ * structure? Reset the control endpoint 0 max packet size?
+ */
+int usbssp_reset_device(struct usbssp_udc *usbssp_data)
+{
+	struct usbssp_device *dev_priv;
+	struct usbssp_command *reset_device_cmd;
+	struct usbssp_slot_ctx *slot_ctx;
+	int slot_state;
+	int ret = 0;
+
+	ret = usbssp_check_args(usbssp_data, NULL, 0, false, __func__);
+	if (ret <= 0)
+		return ret;
+
+	dev_priv = &usbssp_data->devs;
+
+	/* If device is not setup, there is no point in resetting it */
+	slot_ctx = usbssp_get_slot_ctx(usbssp_data, dev_priv->out_ctx);
+	slot_state = GET_SLOT_STATE(le32_to_cpu(slot_ctx->dev_state));
+	pr_info("usbssp_reset_deviceslot_stated\n");
+	if (slot_state == SLOT_STATE_DISABLED ||
+	    slot_state == SLOT_STATE_ENABLED ||
+	    slot_state == SLOT_STATE_DEFAULT) {
+		usbssp_dbg(usbssp_data,
+			"Slot in DISABLED/ENABLED state - reset not allowed\n");
+		return 0;
+	}
+
+	trace_usbssp_reset_device(slot_ctx);
+
+	usbssp_dbg(usbssp_data, "Resetting device with slot ID %u\n",
+			usbssp_data->slot_id);
+	/* Allocate the command structure that holds the struct completion.
+	 */
+	reset_device_cmd = usbssp_alloc_command(usbssp_data, true, GFP_ATOMIC);
+
+	if (!reset_device_cmd) {
+		usbssp_dbg(usbssp_data,
+			"Couldn't allocate command structure.\n");
+		return -ENOMEM;
+	}
+
+	/* Attempt to submit the Reset Device command to the command ring */
+	ret = usbssp_queue_reset_device(usbssp_data, reset_device_cmd);
+	if (ret) {
+		usbssp_dbg(usbssp_data,
+			"FIXME: allocate a command ring segment\n");
+		goto command_cleanup;
+	}
+	usbssp_ring_cmd_db(usbssp_data);
+
+	spin_unlock_irqrestore(&usbssp_data->irq_thread_lock,
+			usbssp_data->irq_thread_flag);
+
+	/* Wait for the Reset Device command to finish */
+	wait_for_completion(reset_device_cmd->completion);
+	spin_lock_irqsave(&usbssp_data->irq_thread_lock,
+			usbssp_data->irq_thread_flag);
+
+	/* The Reset Device command can't fail, according to spec,
+	 * unless we tried to reset a slot ID that wasn't enabled,
+	 * or the device wasn't in the addressed or configured state.
+	 */
+	ret = reset_device_cmd->status;
+	switch (ret) {
+	case COMP_COMMAND_ABORTED:
+	case COMP_COMMAND_RING_STOPPED:
+		usbssp_warn(usbssp_data,
+			"Timeout waiting for reset device command\n");
+		ret = -ETIME;
+		goto command_cleanup;
+	case COMP_SLOT_NOT_ENABLED_ERROR: /*completion code for bad slot ID */
+	case COMP_CONTEXT_STATE_ERROR: /* completion code for same thing */
+		usbssp_dbg(usbssp_data, "Not freeing device rings.\n");
+		ret = 0;
+		goto command_cleanup;
+	case COMP_SUCCESS:
+		usbssp_dbg(usbssp_data, "Successful reset device command.\n");
+		break;
+	default:
+		usbssp_warn(usbssp_data, "Unknown completion code %u for "
+			"reset device command.\n", ret);
+		ret = -EINVAL;
+		goto command_cleanup;
+	}
+
+	ret = 0;
+
+command_cleanup:
+	usbssp_free_command(usbssp_data, reset_device_cmd);
+	return ret;
+}
+
 /*
  * At this point, the struct usb_device is about to go away, the device has
  * disconnected, and all traffic has been stopped and the endpoints have been
@@ -605,6 +726,187 @@ int usbssp_alloc_dev(struct usbssp_udc *usbssp_data)
 	return 0;
 }
 
+/*
+ * Issue an Address Device command
+ */
+static int usbssp_setup_device(struct usbssp_udc *usbssp_data,
+			       enum usbssp_setup_dev setup)
+{
+	const char *act = setup == SETUP_CONTEXT_ONLY ? "context" : "address";
+	struct usbssp_device *dev_priv;
+	int ret = 0;
+	struct usbssp_slot_ctx *slot_ctx;
+	struct usbssp_input_control_ctx *ctrl_ctx;
+	u64 temp_64;
+	struct usbssp_command *command = NULL;
+	int dev_state = 0;
+	int slot_id = usbssp_data->slot_id;
+
+	if (usbssp_data->usbssp_state) {/* dying, removing or halted */
+		ret = -ESHUTDOWN;
+		goto out;
+	}
+
+	if (!slot_id) {
+		usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_address,
+				"Bad Slot ID %d", slot_id);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	dev_priv = &usbssp_data->devs;
+
+	slot_ctx = usbssp_get_slot_ctx(usbssp_data, dev_priv->out_ctx);
+	trace_usbssp_setup_device_slot(slot_ctx);
+
+	dev_state = GET_SLOT_STATE(le32_to_cpu(slot_ctx->dev_state));
+
+	if (setup == SETUP_CONTEXT_ONLY) {
+		if (dev_state == SLOT_STATE_DEFAULT) {
+			usbssp_dbg(usbssp_data,
+				"Slot already in default state\n");
+			goto out;
+		}
+	}
+
+	command = usbssp_alloc_command(usbssp_data, true, GFP_ATOMIC);
+	if (!command) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	command->in_ctx = dev_priv->in_ctx;
+
+	slot_ctx = usbssp_get_slot_ctx(usbssp_data, dev_priv->in_ctx);
+	ctrl_ctx = usbssp_get_input_control_ctx(dev_priv->in_ctx);
+
+	if (!ctrl_ctx) {
+		usbssp_warn(usbssp_data,
+			"%s: Could not get input context, bad type.\n",
+			__func__);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/*
+	 * If this is the first Set Address (BSR=0) or driver trays
+	 * transition to Default (BSR=1) since device plug-in or
+	 * priv device reallocation after a resume with an USBSSP power loss,
+	 * then set up the slot context or update device address in slot
+	 * context.
+	 */
+	if (!slot_ctx->dev_info || dev_state == SLOT_STATE_DEFAULT)
+		usbssp_setup_addressable_priv_dev(usbssp_data);
+
+	if (dev_state == SLOT_STATE_DEFAULT)
+		usbssp_copy_ep0_dequeue_into_input_ctx(usbssp_data);
+
+	ctrl_ctx->add_flags = cpu_to_le32(SLOT_FLAG | EP0_FLAG);
+	ctrl_ctx->drop_flags = 0;
+
+	trace_usbssp_address_ctx(usbssp_data, dev_priv->in_ctx,
+			le32_to_cpu(slot_ctx->dev_info) >> 27);
+
+	ret = usbssp_queue_address_device(usbssp_data, command,
+			dev_priv->in_ctx->dma, setup);
+
+	if (ret) {
+		usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_address,
+				"Prabably command ring segment is full");
+		goto out;
+	}
+
+	usbssp_ring_cmd_db(usbssp_data);
+
+	spin_unlock_irqrestore(&usbssp_data->irq_thread_lock,
+			usbssp_data->irq_thread_flag);
+	wait_for_completion(command->completion);
+	spin_lock_irqsave(&usbssp_data->irq_thread_lock,
+			usbssp_data->irq_thread_flag);
+
+	switch (command->status) {
+	case COMP_COMMAND_ABORTED:
+	case COMP_COMMAND_RING_STOPPED:
+		usbssp_warn(usbssp_data,
+			"Timeout while waiting for setup device command\n");
+		ret = -ETIME;
+		break;
+	case COMP_CONTEXT_STATE_ERROR:
+	case COMP_SLOT_NOT_ENABLED_ERROR:
+		usbssp_err(usbssp_data,
+			"Setup ERROR: setup %s command for slot %d.\n",
+			act, slot_id);
+		ret = -EINVAL;
+		break;
+	case COMP_INCOMPATIBLE_DEVICE_ERROR:
+		dev_warn(usbssp_data->dev,
+			"ERROR: Incompatible device for setup %s command\n",
+			act);
+		ret = -ENODEV;
+		break;
+	case COMP_SUCCESS:
+		usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_address,
+				"Successful setup %s command", act);
+		break;
+	default:
+		usbssp_err(usbssp_data,
+			"ERROR: unexpected setup %s command completion code 0x%x.\n",
+			 act, command->status);
+
+		trace_usbssp_address_ctx(usbssp_data, dev_priv->out_ctx, 1);
+		ret = -EINVAL;
+		break;
+	}
+
+	if (ret)
+		goto out;
+
+	temp_64 = usbssp_read_64(usbssp_data, &usbssp_data->op_regs->dcbaa_ptr);
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_address,
+			"Op regs DCBAA ptr = %#016llx", temp_64);
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_address,
+		"Slot ID %d dcbaa entry @%p = %#016llx",
+		slot_id, &usbssp_data->dcbaa->dev_context_ptrs[slot_id],
+		(unsigned long long)
+		le64_to_cpu(usbssp_data->dcbaa->dev_context_ptrs[slot_id]));
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_address,
+			"Output Context DMA address = %#08llx",
+			(unsigned long long)dev_priv->out_ctx->dma);
+
+	trace_usbssp_address_ctx(usbssp_data, dev_priv->in_ctx,
+				le32_to_cpu(slot_ctx->dev_info) >> 27);
+
+	slot_ctx = usbssp_get_slot_ctx(usbssp_data, dev_priv->out_ctx);
+	trace_usbssp_address_ctx(usbssp_data, dev_priv->out_ctx,
+				le32_to_cpu(slot_ctx->dev_info) >> 27);
+	/* Zero the input context control for later use */
+	ctrl_ctx->add_flags = 0;
+	ctrl_ctx->drop_flags = 0;
+
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_address,
+			"Internal device address = %d",
+			le32_to_cpu(slot_ctx->dev_state) & DEV_ADDR_MASK);
+
+	if (setup == SETUP_CONTEXT_ADDRESS)
+		usbssp_status_stage(usbssp_data);
+out:
+	if (command) {
+		kfree(command->completion);
+		kfree(command);
+	}
+	return ret;
+}
+
+int usbssp_address_device(struct usbssp_udc *usbssp_data)
+{
+	return usbssp_setup_device(usbssp_data, SETUP_CONTEXT_ADDRESS);
+}
+
+int usbssp_enable_device(struct usbssp_udc *usbssp_data)
+{
+	return usbssp_setup_device(usbssp_data, SETUP_CONTEXT_ONLY);
+}
+
 int usbssp_gen_setup(struct usbssp_udc *usbssp_data)
 {
 	int	retval;
diff --git a/drivers/usb/usbssp/gadget.h b/drivers/usb/usbssp/gadget.h
index 45b568d33723..5f653f3caabd 100644
--- a/drivers/usb/usbssp/gadget.h
+++ b/drivers/usb/usbssp/gadget.h
@@ -1673,6 +1673,8 @@ static inline void usbssp_write_64(struct usbssp_udc *usbssp_data,
 }
 
 /* USBSSP memory management */
+char *usbssp_get_slot_state(struct usbssp_udc *usbssp_data,
+		struct usbssp_container_ctx *ctx);
 void usbssp_dbg_trace(struct usbssp_udc *usbssp_data,
 		void (*trace)(struct va_format *),
 		const char *fmt, ...);
@@ -1681,6 +1683,8 @@ void usbssp_mem_cleanup(struct usbssp_udc *usbssp_data);
 int usbssp_mem_init(struct usbssp_udc *usbssp_data, gfp_t flags);
 void usbssp_free_priv_device(struct usbssp_udc *usbssp_data);
 int usbssp_alloc_priv_device(struct usbssp_udc *usbssp_data, gfp_t flags);
+int usbssp_setup_addressable_priv_dev(struct usbssp_udc *usbssp_data);
+void usbssp_copy_ep0_dequeue_into_input_ctx(struct usbssp_udc *usbssp_data);
 unsigned int usbssp_get_endpoint_index(const struct usb_endpoint_descriptor *desc);
 unsigned int usbssp_last_valid_endpoint(u32 added_ctxs);
 int usbssp_ring_expansion(struct usbssp_udc *usbssp_data,
@@ -1717,6 +1721,8 @@ irqreturn_t usbssp_irq(int irq, void *priv);
 
 int usbssp_alloc_dev(struct usbssp_udc *usbssp_data);
 void usbssp_free_dev(struct usbssp_udc *usbssp_data);
+int usbssp_address_device(struct usbssp_udc *usbssp_data);
+int usbssp_enable_device(struct usbssp_udc *usbssp_data);
 /* USBSSP ring, segment, TRB, and TD functions */
 dma_addr_t usbssp_trb_virt_to_dma(struct usbssp_segment *seg,
 		union usbssp_trb *trb);
@@ -1730,6 +1736,9 @@ int usbssp_is_vendor_info_code(struct usbssp_udc *usbssp_data,
 void usbssp_ring_cmd_db(struct usbssp_udc *usbssp_data);
 int usbssp_queue_slot_control(struct usbssp_udc *usbssp_data,
 		struct usbssp_command *cmd, u32 trb_type);
+int usbssp_queue_address_device(struct usbssp_udc *usbssp_data,
+		struct usbssp_command *cmd,
+		dma_addr_t in_ctx_ptr, enum usbssp_setup_dev setup);
 int usbssp_queue_stop_endpoint(struct usbssp_udc *usbssp_data,
 		struct usbssp_command *cmd,
 		unsigned int ep_index, int suspend);
@@ -1744,6 +1753,8 @@ void usbssp_cleanup_halted_endpoint(struct usbssp_udc *usbssp_data,
 int usbssp_queue_halt_endpoint(struct usbssp_udc *usbssp_data,
 		struct usbssp_command *cmd,
 		unsigned int ep_index);
+int usbssp_queue_reset_device(struct usbssp_udc *usbssp_data,
+		struct usbssp_command *cmd);
 void usbssp_handle_command_timeout(struct work_struct *work);
 
 void usbssp_cleanup_command_queue(struct usbssp_udc *usbssp_data);
@@ -1778,6 +1789,7 @@ int usbssp_cmd_stop_ep(struct usbssp_udc *usbssp_data, struct usb_gadget *g,
 		struct usbssp_ep *ep_priv);
 int usbssp_status_stage(struct usbssp_udc *usbssp_data);
 
+int usbssp_reset_device(struct usbssp_udc *usbssp_data);
 static inline char *usbssp_slot_state_string(u32 state)
 {
 	switch (state) {
-- 
2.17.1

