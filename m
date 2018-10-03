Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAF1C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 16:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FD912089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 16:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="f6FFfEFl";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="V6ktCxwZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FD912089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbeJCWvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 18:51:42 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:44128 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726833AbeJCWvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 18:51:41 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w93G2HuH028519;
        Wed, 3 Oct 2018 09:02:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=si4+m9IezPR1GyPAf0glTgoIdbedj8b/xUgUb39KPiU=;
 b=f6FFfEFlXGpHUYGCwUMTh3dE2lIeJ7yV8/oEwhd+88sW/J4Ic5kNuqa54SFeQ/oW4Bvg
 fCoY1R3Fp8X539/M/h0hqHd2tyVQlO1gi5O1ztE+2+b8YId+bp3wsvPW5BMK3PzjbSlv
 2C3SEKBwMwRw2eqpkTVz15vkCo2906uIzpj13mVYSJWQpfZo6EDoNmsB4rj3wwThXRyG
 0Ds0rAngXchacOCG8daRg47jUOtbQFsExv6m3Ebu56dLgjqzIJ4yDbg5S8Rd1YJIeaT6
 TjAtZYH/x5SvZ0Z2jC2GP4I3zyWQoO/LWl+Sh4fm/KL59iVGyN6W9sMMXpG7RQRPPY73 pQ== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=adouglas@cadence.com
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp0178.outbound.protection.outlook.com [216.32.180.178])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2mvw32s0t2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 03 Oct 2018 09:02:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=si4+m9IezPR1GyPAf0glTgoIdbedj8b/xUgUb39KPiU=;
 b=V6ktCxwZhw4CyR1MWkskYFkda2TjB3VKS+RO6WrWLPKJYXPJgBR7H3M1PFZiGCzVsTQnmNZfBdSH+mh1FDJhjlAyGJf38rbGONIkIC8HpLJBgcWHtjDRs/Vv/0Z0/JMdlpkm0kSy6lHXN1mBQBnO02G/WKWkWWPYxV7jUoBmbEQ=
Received: from SN4PR0701CA0015.namprd07.prod.outlook.com
 (2603:10b6:803:28::25) by CY4PR07MB2950.namprd07.prod.outlook.com
 (2603:10b6:903:27::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.18; Wed, 3 Oct
 2018 16:02:31 +0000
Received: from DM3NAM05FT047.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::203) by SN4PR0701CA0015.outlook.office365.com
 (2603:10b6:803:28::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1207.21 via Frontend
 Transport; Wed, 3 Oct 2018 16:02:30 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM3NAM05FT047.mail.protection.outlook.com (10.152.98.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1207.13 via Frontend Transport; Wed, 3 Oct 2018 16:02:30 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w93G2RUP008653
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 3 Oct 2018 09:02:28 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 3 Oct 2018 18:02:13 +0200
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Wed, 3 Oct 2018 18:02:13 +0200
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id w93G25K6021469;
        Wed, 3 Oct 2018 17:02:05 +0100
Received: (from adouglas@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id w93G24YU021437;
        Wed, 3 Oct 2018 17:02:04 +0100
From:   Alan Douglas <adouglas@cadence.com>
To:     <kishon@ti.com>, <linux-kernel@vger.kernel.org>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
CC:     Alan Douglas <adouglas@cadence.com>
Subject: [PATCH 0/2] phy: cadence: Add driver and dt-bindings for Sierra PHY
Date:   Wed, 3 Oct 2018 17:01:59 +0100
Message-ID: <1538582519-20957-1-git-send-email-adouglas@cadence.com>
X-Mailer: git-send-email 1.9.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(39860400002)(346002)(2980300002)(36092001)(199004)(189003)(107886003)(48376002)(486006)(305945005)(478600001)(2616005)(186003)(87636003)(7636002)(2201001)(86362001)(246002)(26826003)(50466002)(26005)(105596002)(426003)(51416003)(126002)(50226002)(5660300001)(356003)(106466001)(2906002)(42186006)(4326008)(36756003)(110136005)(6666003)(336012)(316002)(476003)(8936002)(8676002)(16586007)(47776003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB2950;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT047;1:PbjnD0Etf/mvktj8TRdUkB/y9qxbaD+ehoSIdoS9OGyHIkSbGjZBPJwNAsHh5YrYEbI7oAU720v+CRW9edCNH6YWG4M6Iuzj3pLQYnYvYVWzX+JemaXkdvZ90NnEugJ5
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9cff429-6284-4413-083d-08d629499fba
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060);SRVR:CY4PR07MB2950;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2950;3:CdeQLq3Aox0E69KV3Ez9ZJUhOg8fnlui8MpdP/nS8I6+CoHKPktkwmQm6MJAvXQFq3td5pdAG1nmAHVFb8COos3MJdmOgjHtR5O+elFG8yjIgpIyYsVNhciMIm4/BKvKptgp/hGTSUu3J5SmRH2UvMtP/sdy6rkvsxDz0CeYHpGSuXrHhJUf5zyG1O/fdSVWxfDyhRkpmUZRZReYxmYqSz6Gq4d80LTEow/mBVqc7/L+0F0L1asVN5Ru+Y5cvzISptqSSGItd4MrDUP+GRgUWLTyOuYNV2OxuwRA+pkwqUlQ7OojCwP0caDDV91if4+xwGQKmJN3xZPqPxtCcBSfbD4TCw+DWXSi+6K8gPYH404=;25:OcVVmEggYZsGFgDXID9+9gox8wsks3WicGusyBNndbKxtKQ+AfUuJe688/6U1C42byR4xeoe7kmD3ImZcmBr8xB/53nZOp8Xq43czI0bjMpkF0zYIiXRAeXbDijvlPG7XXhY2RVndk7CihUQuzJvyLwNCliYQhFc3NytLUb07fnwD8IVciBN0OF8I9EbTqk5aG5jmld2CHlkNC3TAxi+Ohtpr1QHh2qxoHfeLvonTY/axGeI1iFq0dmPDjlScJmbhbdunCEWvRwbzGHr3eA1nwnMvyFpYn9lU8uvs8a+a+wwZJt34BSL66DW+pZmnjeXwbHUE5WcTBLFf94h1uXlOg==
X-MS-TrafficTypeDiagnostic: CY4PR07MB2950:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2950;31:mxMMm/S4v5eBYetqtD5PbcFnbrgguWU+VXAICFWNax1XB0e69255ccqnhE3znOdo84hiT9CYs3k/ytPpOOrvmoQu0fdbJAqL4We1CvxGi33d4bEKrwWYzRj+vvsfuyY28dqoR2nyZeHQj8ScAQMi+Ku3PUKiQEXr6HfslULP/iOhzqaU1qxoZxf0XijziPeqFpO/QQ4OMaqJ5AdyOIXxRLUxgv42qPKEXH4Kom3VNwI=;20:WnnO2mlwVGAAXEtxm04ZzDBTAj7a2lcjJQ+hUTOYdsNsNP/kfyEu/fDqkjN7SNUEbKNRuPTa0PFjsnoPx7urYNRhiLQj/RcIj2yXVv/0dDSD/UbUfc8j3JX0gjmiXlUb09N4cbb0bqfKbECK8BiPaCKiQuFShvo+sBjZfoSbRqIxFYtNds+yBu4kmEPevELkHRhaYyJc3pm12aYGkK6Oy90+fmw4UhT79W6Rus2WLCkqdkFEXR/BzUTYZ9toZ5RACuQCvxzXE3xl5oFj8N5K/CtaCREtD5I0kHypclGaWvobHWuQf0cAJuLia9BR9FTkOirw656zMh1vRI6Oza5wGkntwDD1Du0c1mlILdRkTuTGkPhJgZza59/jiiQIuVlXgk/iy3CUPDeu13Jif8zMx5GWy11M88hkS723hVla2MI0EmGD99bVMD5bOATpluAuWErPKpDBmDLec4CsT1+aTRxKtGKuCEe2BdF2SWYCr81gYrCgyA4YMKaLtWeWJ2p2
X-Microsoft-Antispam-PRVS: <CY4PR07MB295080191E8AC2BB019B2277D8E90@CY4PR07MB2950.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(93006095)(93003095)(10201501046)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699051);SRVR:CY4PR07MB2950;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB2950;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2950;4:BoLH820w/HYo7lLddIOtSWMKNWYn8HwdDW1ujHejxcpyav1je1BXUDWRc+DPisoDr8d/Xj1bq9fPlFvp2P7Si44Fap+uTtPiwKb593wweRlVyqqgwivCaJ8TU1wE6bP/wQWqxJhxhUJR9mupbn/0+92vk7po7Z0qX3UekDYtVIzsKYDywYefmC0jcUsHQjyKmMrTLev4dHVG89ixng09oWP4K1LMD0hEbtj9p27DCvYH6NjbGYqWvT058JwDVC/EEXMBJUgu2HgwPp+LP1g2OA==
X-Forefront-PRVS: 0814A2C7A3
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB2950;23:cgiMmCfV4OCsKOV7YY/lsISq2bBc4+nAoRsjCEyWQ?=
 =?us-ascii?Q?9MJfUdm9WzkHjnyKCi5+RIblSlMlieqyAQnl9Y0TzN4ImVYLTBlLc+likAOS?=
 =?us-ascii?Q?4NX2yh6be9QRzGti0q+H5xhqQPHFokY+guhlpruAlGax1rJG1K+S10Uyguz4?=
 =?us-ascii?Q?27EKJNoWKWpvq5goUUUCHbhfUtpr+lbk3W0IOIWJtGixOBv/NWcozc4UQUln?=
 =?us-ascii?Q?eAMZv3iSvAWE2532tlWsJEMIfkIKhQyNWmlaqpdI4Pet9UZHdgujsca0R4ag?=
 =?us-ascii?Q?ACexv0hYmk/kCgP0+4JOcFRwsXmuhlQSpiqZ3oiQbfp7YZcs0D7eR7FXTdlx?=
 =?us-ascii?Q?IBGZ8Qkl7ESiFmgeEWpCms0Fd4t5hr1Bi8ILexFUwalFpsPvn9R4u2CCydJC?=
 =?us-ascii?Q?WvLlGoo9MrB4JAbSldP0qKeRVDOTtS5/9cLerkReBBAEskQSQIo4R0gteNra?=
 =?us-ascii?Q?jHfwtyweW1XSSk416EHqUyMvvtGdvE3iITxhuvPBY2iy4/m2WAVts5Iy7gzs?=
 =?us-ascii?Q?UfETM3elbdbkxXHbwUpSAaWCq/W30gkv2Mk6siaZcFl++8h0uKGTUROskhYT?=
 =?us-ascii?Q?S2wdf87KluDonoaXT4EYIVTwoMC0/VbRT0fxDdjHnpA7kUxsUTbyZADJfoks?=
 =?us-ascii?Q?z7R4uHz0DVocWzd36QOV0u5w5sbXYJ2+oc7qAhZccc7W1z6FFrmBj+kCbgXK?=
 =?us-ascii?Q?NbYRD1nmTZ/RCV6XHQmULmMl5zB2CXYpcimuJ7srXkTFQ1VIXH5V6PJ8WHPC?=
 =?us-ascii?Q?CjI0hMdfxegw6PVvm/LxKo9vf9Fi/MAc2CTHLNEa0pwuARTYdYCQIVaJmtSI?=
 =?us-ascii?Q?uTQ/BurNVAZZvypkWdl5fb2AAIXuErsKBzoEcUB9q9vUtPCMmmRO5H2d1ubr?=
 =?us-ascii?Q?aGUDrW89mpWIEN+06vzlQRNNcbkXswoHw6uH3hPUU43VV/seZjP1syZW+tEx?=
 =?us-ascii?Q?UfPYnPJ2s9RntkL0gD2TDidgEQ7mft4ILHtBktcBM+esQPXjWL3Y0+Skady/?=
 =?us-ascii?Q?8ajclMtTT9HyE3rDQlIfQjd?=
X-Microsoft-Antispam-Message-Info: YWj6P+ztXjnbORwEdMzSpPGmRIIVK3y3tX6Ik8jObAPL+RjXCiM8u9YJNXTTmZN64g+zcZcQwZqQHdKJS3tkVdaZCyC2TEScJ9qBrD+FLK5KLEHasLJQp32KBWEI+YjKnaE45A24zjN9el/tA7T7nsxW+7Aaj//Vq5zeUhoYzoV2g55XliyOSRbFxgWMwkAnhvwYR7P0TK04bqRbsu2qRliukWkGon4+vw3nPWZfkeiCid4D/EdBSlYwA7aE4JEVlywGTxntj7+BGDrLkw0xb7dp1fUsAwPm3qUxNLri4rxNKR4DR0BayOUrIhjPVTHTXSBDKkgWtViYYzd16+2Xs80w741M8+l3ss9ijbBqrX4Ex8KMr4ViVme8jmmCwPsJaGyP68gSkMpGUZN+beZ/Cw==
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2950;6:QtdwZhq1hbwFv2FGjDZBbziEBeO9kNonwSFs62JTJ9wzUcsUdq29oZn1bmJ+z4/SyEA1ism6GyNpKuhdeNRE593azm/zolApXufrW42woxwp5Ojwy6WfUHWDznCffM8MGqaaEjJKw6aMXFLjN0QzoyCQ5KzrV0ILYfs0xNHlh67RXSAsS28/75DZx3bIzGE8PVRD1Y7s5ETsLGXY+IiQv3NZZDp8bgFseRYzxJw7llPVUOD3wyNmCfNv4VCyzIh6qtUC4yuS3B3vqTiIU0DnJsGBhUvs/iRBjLe2ViBq4JVC8ETQyuWEtt89BeTsHwwLq3z10wnw6oxy4zWCmOHiCcbEOap2VwPefDB9e8V9xFD80xuLtJ8WEoUcdQQ2UfH3c9e+Y7s5xhsJXoadJ++ioBwGOWWLUX5VsmitdYrZnDQJsDhmdm6x5PPRWCOE0nCDob5WmTHFBayP4GGT4axIHQ==;5:+sVfg+0kXXNxdg13mG/fVhTwW4pY2oIAZdIEzj1oE7EuU2sGy95yiON+IbQjH4q2eewRi10yBzyjP7nS0JAb2bbdH96ahPT5nUvqsuDg9xoJJzqUFLj0qP7YYs/qG669p1wKPh8vWoj6bGAAOf03vvCGuzdqH0K5wFHQNlDgNhQ=;7:xFPfABifHvwucHCnEDpGjlohVMtI6pv8JM11Bta7cDoj/PHmaDu1e3+27W5bNBliP5mwh0Wu4xQjKKGkZGby6VB6HbnILx+GAhGjRucBh5zl1nAYgJuBPz9MfCBqDFxpVxXSgAg0TQMrXlvHYWXaJOMmqIw3hpoMfRwpduFl7N0MPY7P28dNLFxEkcX9+WQCjfVEYQQLTa+SqhRznZiO/mQWWkGdT5EtTRiGYQhq+9IUwc1H7b5IzKz2NZrwFAfJ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2950;20:k/05FKrTde8lNTguJo4JXtwVkTQmZeWBBeagGJlC2Fyopkrw7VAxZgrXebDZpLnvM5KZUtCq8kDMyV1k2NjPx/kfuwd16st+qlMSyh/sZsxUht7ozFqt3MjqZmUwkM6hdJ4fyVjTyb0octr04i32QAKiAeP0b9E+DtgxMtPJGn4EYm/NFFCaLHTRc9Ccf/DhRww74zqvlYqgIbH0+WwozLpRz1Y6ZoJIKPM68YRporfE27WLv8vNVI5rbnrByAQ1
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2018 16:02:30.5343
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9cff429-6284-4413-083d-08d629499fba
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB2950
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-03_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1810030154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Cadence Sierra PHY supports a number of different protocols.  This
series adds a driver with support for USB3 and PCIe modes.

Only one clock frequency is currently supported, so the value of clock
provided in device tree is ignored.

Changes since RFC v2:
* Devicetree bindings modified as suggested by Rob Herring.
* Tidy up and correction of return paths in probe function.

Changes since RFC v1:
* Each group of lanes is now treated as a subnode, and a generic PHY
  device is created for each group.
* General cleanup based on comments
* A reset is now required for each subnode.  The complete PHY block
  is taken out of reset at initial probe, and remains out of reset.
* Added a binding to allow for hardware configuration of PHY registers


Alan Douglas (2):
  dt-bindings: phy: Document cadence Sierra PHY bindings
  phy: cadence: Add driver for Sierra PHY

 .../devicetree/bindings/phy/cdns-sierra-phy.txt    |  68 ++++
 drivers/phy/Kconfig                                |   1 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/cadence/Kconfig                        |   9 +
 drivers/phy/cadence/Makefile                       |   2 +
 drivers/phy/cadence/cdns-sierra.c                  | 380 +++++++++++++++++++++
 6 files changed, 461 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/cdns-sierra-phy.txt
 create mode 100644 drivers/phy/cadence/Kconfig
 create mode 100644 drivers/phy/cadence/Makefile
 create mode 100644 drivers/phy/cadence/cdns-sierra.c

-- 
1.9.0

