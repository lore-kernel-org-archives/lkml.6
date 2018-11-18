Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFC4C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 10:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2955E2080F
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 10:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="m54xYOb2";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="YXYJ9KS0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2955E2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbeKRUcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 15:32:04 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:41228 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726287AbeKRUaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 15:30:55 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wAIA8s0x007707;
        Sun, 18 Nov 2018 02:10:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=Ml6q2VyDM6T5cCTv/BOLUqUu3MkLPOuZH5iFCAWBYUo=;
 b=m54xYOb2z0x1L8SIQnzjl4VVpoDe64QjJTSOz+QibH0yczXcylyxJPFkbkbTyWT3pdLt
 +BSWv0SIzOpJRQP0rcMBR8F5HSS59MMLPTtlaaZTI/BqAuSTxfYJgnwi9Hb6M4rV/YDz
 gnoEhyI59Q9dw00TU3X9MQXb+HWJKDOsRgeCkh2NxuhETBBCQYt64O9VhF0yG7aA/M69
 atlB8q5UKLzTonWHrx8MzsveyRqbAdT9MhO520r5G2pWXQ91SEWpoke+vX8Psc/smlc5
 y8yDrUrBpkkYNVwTTz7ioQC3zyjnmr6pUJKRkVjrakmg2XsgCMEa8Igg0dRcy3WyG7tg iQ== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam03-dm3-obe.outbound.protection.outlook.com (mail-dm3nam03lp0019.outbound.protection.outlook.com [207.46.163.19])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2ntff7w44n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 18 Nov 2018 02:10:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ml6q2VyDM6T5cCTv/BOLUqUu3MkLPOuZH5iFCAWBYUo=;
 b=YXYJ9KS0KmPRzvMv7SxzjJxbbqJQ8lS71ZboYOFjxOmzUT/KfMh+/O5jJres0437t5vZ3uzTTpuArTqc753gR3pg/Wm3Au/h4u0CtEFVN+bG+zOCI9cOSxeD9AuF3zEPPqgy/Ndp6wjTRYCDR71jMaKioI6z93E22Iyx02kF5g8=
Received: from DM5PR07CA0045.namprd07.prod.outlook.com (2603:10b6:3:16::31) by
 BLUPR0701MB1860.namprd07.prod.outlook.com (2a01:111:e400:5165::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1339.21; Sun, 18 Nov
 2018 10:10:44 +0000
Received: from BY2NAM05FT052.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::203) by DM5PR07CA0045.outlook.office365.com
 (2603:10b6:3:16::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1339.21 via Frontend
 Transport; Sun, 18 Nov 2018 10:10:44 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 BY2NAM05FT052.mail.protection.outlook.com (10.152.100.189) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.3 via Frontend Transport; Sun, 18 Nov 2018 10:10:40 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id wAIAAb5J029622
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Sun, 18 Nov 2018 02:10:39 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sun, 18 Nov 2018 11:10:40 +0100
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Sun, 18 Nov 2018 11:10:40 +0100
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id wAIAAaGC030892;
        Sun, 18 Nov 2018 10:10:36 GMT
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id wAIAAafU030891;
        Sun, 18 Nov 2018 10:10:36 GMT
From:   Pawel Laszczak <pawell@cadence.com>
To:     <devicetree@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <rogerq@ti.com>, <linux-kernel@vger.kernel.org>,
        <adouglas@cadence.com>, <jbergsagel@ti.com>, <nsekhar@ti.com>,
        <nm@ti.com>, <sureshp@cadence.com>, <peter.chen@nxp.com>,
        <pjez@cadence.com>, <kurahul@cadence.com>,
        "Pawel Laszczak" <pawell@cadence.com>
Subject: [RFC PATCH v2 01/15] usb:cdns3: add pci to platform driver wrapper.
Date:   Sun, 18 Nov 2018 10:08:57 +0000
Message-ID: <1542535751-16079-2-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1542535751-16079-1-git-send-email-pawell@cadence.com>
References: <1542535751-16079-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(39860400002)(136003)(2980300002)(36092001)(189003)(199004)(50226002)(36756003)(47776003)(2351001)(107886003)(106466001)(86362001)(575784001)(426003)(446003)(11346002)(316002)(4720700003)(16586007)(336012)(42186006)(54906003)(6916009)(2616005)(186003)(26005)(105596002)(486006)(126002)(476003)(4326008)(50466002)(26826003)(305945005)(48376002)(8676002)(478600001)(6666004)(246002)(7636002)(87636003)(356004)(8936002)(217873002)(76176011)(51416003)(5660300001)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0701MB1860;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM05FT052;1:8ntxFeeauwJ97dWuQN1mGGnvEzd7Kz9/cPU2B1v+dL5x8dokq+wqEYvH5cIQ9xQgjhCZjYndbRRTxymyHDgsCrb4nJsA6qx4+eGiZSFtE0ThzE2C/+GtYdCBqe40E20S
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ba51b55-ade6-42a5-2eca-08d64d3e19c1
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:BLUPR0701MB1860;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0701MB1860;3:ek/4GZcWXQptA8Baa0BUd+Msah55b9LLUevWlD+fui1ueMFyNCCGFzSyN7FII0Dj0KRHDCwDz92q6rBeAJRV/B58NR7rlA/JWAnwu+8BAjozfN1In7WLKjBOAUV7wcSeuvkElgmFo6LuhodkfkStaSZqNRcXkOGNA0VXr6J/X2OX7+lqjHwS+W62F16Y8UJ0HYFd+UdYWW6dmGTBDSU+lAOXi39ZkhbIVrCfobkWupYe2HOYdOxr6BPAPbXLvr4Of95ScgrWUMxxnQZi4Lr8/57WSUr2zGwxR8wrzRznHrN0Pddneoeo9g8Y40dFtlTU+Y/haE2l60KaoObIGjabrrlwdDE3DOomMfex3v1K/5I=;25:vVMyJ6XaJyFQtJDBtdHIfWNKK+K9svAtiZlFxMvzAmhCFKsRVx/ig/JkAtmNWbeiAheNtMSnIq280/SHwhxGYZ4pfTYq6udmk1vE3QCfh/uL7S3LxiLTQdQ7mXMODHtlg2m1OhO+gJOosmjRhqyLEXH1zWsOxnhbKWPfzxHEtzL4D6gcSP+lAbbLs3kONArnLt4GDTLlYSYkZCid5ffHkzn6DWQN676J91R1/LyT3OwJEw/2dAlLbEsvRN587MvdgUu8MlzyKaEYMLUZiNvu7xJRudJ6+RnTwXCJ94y3s1HEgcdp+xx5nMqqdSeXEJqSDqGWgccg4TPVE/JAQQbRCXOTy4VKktlK9aaEWccjBUo=
X-MS-TrafficTypeDiagnostic: BLUPR0701MB1860:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0701MB1860;31:uB7ob1SzVMXIENNH8WaSPgQk+3KHhy6+Nfz90Y97mS3N6QlJkE2p42W2CJFMk/vAcp6q1vv4nPQX336EWooYstNNLBaiUHgCz5F7lttjRUoPhVJsdfQh9Re/PHDttqgX6OeVmfEdKzp1JrOXptYIj//2GXjdKsLKT8zq5TxydBxIh52mhVHgAele88nI9smaLWOrEniWZemdhnR7NQYrP3U2Y5ftFYDmdLMO1M6lfLQ=;20:Ay6VBdEUa6R8YKS7hugQzleqxwmzFE5s4N4Rxx6Vfm1/h+h6gm7HLHaTes1mM4i45ClzHTUk401IXuZ27VE6R4QV/ohLyXIu5qEt6v7pcl1qRhTgdeaIBxqZseWy5wTEfyUNg1u3VQud/dCGqqUsBB5nwCU5Xzz63vt6KtYVKc+sCYmrNBugu0fp7Ja+zAm3ZjZzhelnZz/NRUJ5REUYxdoLbFt/vKqMri/VSSI+NClg5uucxQtCetL8lFBF2g2KWCeC+1lCTqGlw2RytqMXToRmXL5cXn5Eaa5jc+Ja9fq/2LJf7eNybmVsZJVs0LJ4Mt7/oVeJtTWfzMP7Xez/Gu1gqOZgM8OrK5lWx9TNOuhN7nZAmgTzBNkKCd84WeYWA9RmQEcdcCjx13FTM+xRl7eyQiIc93YAmBvrwJg3rjnTHuCOdjVsTAgUQsysNmuYVwHbNDox4VugD1VRZDf0ftYTo6SVxWU1/mlKdhR3fH6AjJqsONWzu/1Lb5ia+4qS
X-Microsoft-Antispam-PRVS: <BLUPR0701MB18606535659502571DD42C08DDDF0@BLUPR0701MB1860.namprd07.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93003095)(10201501046)(3002001)(3231415)(944501410)(52105112)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BLUPR0701MB1860;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0701MB1860;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0701MB1860;4:VKS6Wo3CC/E4IvXH6bkaHZ54PZ7zremSwi7cUKtGahC3Gw4X7cNmzEc1WEZWFqu67FvV0n4UjF2WjJEZjyg0y3oOtJpkvVwm2MSyzv12glEPP3t1urXLyqg/MhmJZmlG57igLMNDabFTQHGOoRpC6GOihKcGRvcmF2p+4AAOvyYWQODH7g/xolJvTL1Xxb3SaKenlvatx5JWew4RXZBT4ZfcH1vbI8nBhTI79qU2gMR22W4rNlMSfm8WOfpiXpjLBJkyXsM39GRnvzDIv1YiMQ==
X-Forefront-PRVS: 0860FE717F
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR0701MB1860;23:WEAEo/b870Fu8g2imHC6aclAqQbzE5xY3SBsMma?=
 =?us-ascii?Q?zsx1stYhwoCj/OrHf2wKmwwoP/GVMTSlhsuf3wE5x3bTL1nGVELjDYT0laug?=
 =?us-ascii?Q?Q+MK9kbJ8Xp3DkS9WX8TsZRv+fBNCMIB026bnfNM+vacs1PfTkG/0A44Rvz/?=
 =?us-ascii?Q?Uc1MsgKsmD5k+kC0ofjSCO5Dp9LdUUQhF8tTgZLO/lJXogfhhuR+Bsp9UsS7?=
 =?us-ascii?Q?pD4ujErrwoHpmiIAviwQKn7ziEYsLEK+WyI61mvWvleTMrS2GmjZ+BegCRFF?=
 =?us-ascii?Q?s77bqAsWYGBqcuiww+eFVDRBK8d/sXmT8qy1omc8Orqbei4joTwU0FTKqWRQ?=
 =?us-ascii?Q?1oXD/AgQgh5NtcLjpRkaxy2Ilm/7H2DS8twLuXXK+ZxfdVPPYQAvZwdSjWgF?=
 =?us-ascii?Q?CfBiZ6GOtfE0S6pwGjcrgc030syu0a25/mEk4Ox9Nj2u1jehUo6o5idHgzXb?=
 =?us-ascii?Q?2+SiiSn0VrM0R1XYCkizLBwxC6XqJHXZxPLTDWmQWlAZwGHediHnHbBLqaYf?=
 =?us-ascii?Q?20zzYeeKi7pPFTt/8C9tmtmCPUmORW4pA1/9gQouKn05I7yS+8f/+sxB30nZ?=
 =?us-ascii?Q?kbwlg3acNSKfvg2wcXtHEyidFt3QIHolO6hv8Q1PGyUqNtdkThRGvV3NosX5?=
 =?us-ascii?Q?lCXx3pLH97q5WBJXCGDNotRGuyD5aFe4yeiM7J50gqrGR3UhI56V5QzbpOqb?=
 =?us-ascii?Q?UHzwDORHplrBGaBpcBo8Am/cPUsq7BIjpNFpU/8kJIfz2rzvlXT+oqZxRxau?=
 =?us-ascii?Q?K0bo6fo8QNywxJYIyT6e2KXfnnEmv1UZ49DLWcGM5fNTWVwEeECpU2n53z22?=
 =?us-ascii?Q?suqXaSdfLDaOzyqeFqZ0BJewbiEdLLZ7sXGGpRbna04LA0BIAGfvhat9pdTL?=
 =?us-ascii?Q?sTYPL005k5rQ37xGHcAbBVQVxv8NHsvf6M+FRaK7Qgh+aoUkEdfqgJYpuJCU?=
 =?us-ascii?Q?EwgayWO/2gd7Cpj8NJvTpXrHoLEurUZlI8pZAs94PH5g0ei7fpyYF0RVqdEV?=
 =?us-ascii?Q?bQSV6m2llBtlE7E/Mg6hLBKSsF//m38EDVuV94YuyphKhiYVIrOYCRlJ9T6H?=
 =?us-ascii?Q?RgzS37+L9cwal6VmrWQel55gp4M9ht5waoZ4ntTum/ZqJ8GwWdOIKkIl3Fc8?=
 =?us-ascii?Q?Z5HMfrRoXM/dWHggEpZivJtwo7zgJl0o4xa69kD7frQWst4AmiDECyg=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: mec57mwTvH3SMw3j0Y02BTwHoh7ZnHK6F+ewZDD042SwwV8kQKP/IBl8xUEBFEFnVZ//ZkCM+JqqJxfiqq5/m3vHhx4BGao28UuJLcH7ZpP3fyWlkm5WGUBaC/aaZICQx9Jt/Q13xJykCWErhGWZX8ZEO5XVdW393ddfAYNJxqwUqOTOQ/nSzShPajao/4pnnTmqdh7WC9X6VpYUrBgeeZHpAxb02A6O5GlOr0qvRKX5zjGOWJUITYZiOPWpUfC7RRpj75tJ0Re0+kS51qMMRjRjRExjWWmeccME37ii6E5DcGjVn6p6iWrFGo60LNXZDu/bhKQMa3E2U30+oZs7wntoCALYZBJ1QGwMKvqQl24=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0701MB1860;6:ZM+syGDIICWjcAqEQR94F+Hm+UAPo1A8tHww03UBHr8cSXa0Pnsk9NKh89S1cI47xMx47kq5vyjJTrlvi0Nyj+XixdZHnjK3L32sIziasqVMhdT/1L6mjCpDbjo1Glca8WtxioBipUbuX5S77nAlNzqqE8PvNrpgRGOMYmCTkgq6V1ejBV9GHZpSVkYX9N6D1DDg85+vLXcaS1+EaeKCpY82dG+UKCleKHhahkTx6SpWppWrIlJA+ZEoTHVfiacU6RS7fSOLtKVAXtSwHoFMKIZ+LKJau7A7aKg/AqdxhKYsRFvy8WyDtyBYjCkdAZtJnOuVgb1S8KaG/Evnq0komhAwJxvVrr2h+nMaEd38dlkkOEu8vZ6Y9IDNSULUPRxBU8rgdla2FKRqbyTHxvIiQdWsyGe8KNWBoOudGXoFFM94cozEGpKCcQhYat36ly4DaQg6YBUQmu7ceiAltAfeTdHTG68eyl3T0clbyE8kC2w=;5:S88aHlZ/S+ZUrZh4FoZfdiRg6PObNqPcJfpYND+XRALNVKVSl0w+KbxO8meKSbjJqvtwNqCoCt2i5H5XTNV3uJC1yAECQ/BTmOZGMSVvW9Jkcwunk6Z0CsXtXa7w5hSvdWHozG3aCFpk05BWYVuIh1b9fM7ZGlnFVeIMcWR4mPY=;7:nG4OnB+Nf+e5cI2ufEAk/NqJZVR8rlZJS8UUU7PgZdcjvoqa/r2SZhNVXCo2jSelkD1FRT+ZI/bQlwD1zSV2dTU1tvYBQAxOh8iCdYPbOk5kgKY2zAHjsbDZy1CNXHMIBVtslQJgqD3UhrEQnLSYrw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0701MB1860;20:In4Poghvqa55f/gL73Z3IKEzPMHXn8uRjxVpjrqjZo+Cw+5g7stvLwq/PxTC63qXGRO++eJ9qOtCZE+b1Ap4EaQ+orrpOYmmCYHtrtrYSx3Ac4DI64nl76VmuMA8i7P+Mop3jeeKIOSCdWoQz7ITCxVrfSkTA8rbO5E/SWvGfWaiyaMjRCIc19Y3x/l+LPGQHW92Af+Gx72iyEdJdZSl+wOgmm5OiNWe9OPOsO5S6l6+ZkYF4JIO9IqNkEGhVwbU
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2018 10:10:40.2561
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ba51b55-ade6-42a5-2eca-08d64d3e19c1
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0701MB1860
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-18_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=827 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811180097
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch adds PCI specific glue driver that creates and registers in-system
cdns-usb3 platform device. Thanks to that we will be able to use
the cdns-usb3 platform driver for USBSS-DEV controller
build on PCI board

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/Kconfig                |   2 +
 drivers/usb/Makefile               |   2 +
 drivers/usb/cdns3/Kconfig          |  24 +++++
 drivers/usb/cdns3/Makefile         |   3 +
 drivers/usb/cdns3/cdns3-pci-wrap.c | 157 +++++++++++++++++++++++++++++
 5 files changed, 188 insertions(+)
 create mode 100644 drivers/usb/cdns3/Kconfig
 create mode 100644 drivers/usb/cdns3/Makefile
 create mode 100644 drivers/usb/cdns3/cdns3-pci-wrap.c

diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index 987fc5ba6321..5f9334019d04 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -112,6 +112,8 @@ source "drivers/usb/usbip/Kconfig"
 
 endif
 
+source "drivers/usb/cdns3/Kconfig"
+
 source "drivers/usb/mtu3/Kconfig"
 
 source "drivers/usb/musb/Kconfig"
diff --git a/drivers/usb/Makefile b/drivers/usb/Makefile
index 7d1b8c82b208..82093a60ea2c 100644
--- a/drivers/usb/Makefile
+++ b/drivers/usb/Makefile
@@ -8,6 +8,8 @@
 obj-$(CONFIG_USB)		+= core/
 obj-$(CONFIG_USB_SUPPORT)	+= phy/
 
+obj-$(CONFIG_USB_CDNS3)		+= cdns3/
+
 obj-$(CONFIG_USB_DWC3)		+= dwc3/
 obj-$(CONFIG_USB_DWC2)		+= dwc2/
 obj-$(CONFIG_USB_ISP1760)	+= isp1760/
diff --git a/drivers/usb/cdns3/Kconfig b/drivers/usb/cdns3/Kconfig
new file mode 100644
index 000000000000..eb22a8692991
--- /dev/null
+++ b/drivers/usb/cdns3/Kconfig
@@ -0,0 +1,24 @@
+config USB_CDNS3
+	tristate "Cadence USB3 Dual-Role Controller"
+	depends on USB_SUPPORT && (USB || USB_GADGET) && HAS_DMA
+	help
+	  Say Y here if your system has a cadence USB3 dual-role controller.
+	  It supports: dual-role switch, Host-only, and Peripheral-only.
+
+	  If you choose to build this driver is a dynamically linked
+	  module, the module will be called cdns3.ko.
+
+if USB_CDNS3
+
+config USB_CDNS3_PCI_WRAP
+	tristate "PCIe-based Platforms"
+	depends on USB_PCI && ACPI
+	default USB_CDNS3
+	help
+	  If you're using the USBSS Core IP with a PCIe, please say
+	  'Y' or 'M' here.
+
+	  If you choose to build this driver as module it will
+	  be dynamically linked and module will be called cdns3-pci.ko
+
+endif
diff --git a/drivers/usb/cdns3/Makefile b/drivers/usb/cdns3/Makefile
new file mode 100644
index 000000000000..dcdd62003c6a
--- /dev/null
+++ b/drivers/usb/cdns3/Makefile
@@ -0,0 +1,3 @@
+obj-$(CONFIG_USB_CDNS3_PCI_WRAP)	+= cdns3-pci.o
+
+cdns3-pci-y		 		:= cdns3-pci-wrap.o
diff --git a/drivers/usb/cdns3/cdns3-pci-wrap.c b/drivers/usb/cdns3/cdns3-pci-wrap.c
new file mode 100644
index 000000000000..d0a15cc0b738
--- /dev/null
+++ b/drivers/usb/cdns3/cdns3-pci-wrap.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Cadence USBSS PCI Glue driver
+ *
+ * Copyright (C) 2018 Cadence.
+ *
+ * Author: Pawel Laszczak <pawell@cadence.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
+#include <linux/slab.h>
+
+struct cdns3_wrap {
+	struct platform_device *plat_dev;
+	struct pci_dev *hg_dev;
+	struct resource dev_res[4];
+};
+
+struct cdns3_wrap wrap;
+
+#define RES_IRQ_ID		0
+#define RES_HOST_ID		1
+#define RES_DEV_ID		2
+#define RES_DRD_ID		3
+
+#define PCI_BAR_HOST		0
+#define PCI_BAR_DEV		2
+#define PCI_BAR_OTG		4
+
+#define PCI_DEV_FN_HOST_DEVICE	0
+#define PCI_DEV_FN_OTG		1
+
+#define PCI_DRIVER_NAME		"cdns3-pci-usbss"
+#define PLAT_DRIVER_NAME	"cdns-usb3"
+
+#define CDNS_VENDOR_ID 0x17cd
+#define CDNS_DEVICE_ID 0x0100
+
+/**
+ * cdns3_pci_probe - Probe function for Cadence USB wrapper driver
+ * @pdev: platform device object
+ * @id: pci device id
+ *
+ * Returns 0 on success otherwise negative errno
+ */
+static int cdns3_pci_probe(struct pci_dev *pdev,
+			   const struct pci_device_id *id)
+{
+	struct platform_device_info plat_info;
+	struct cdns3_wrap *wrap;
+	struct resource *res;
+	int err;
+
+	/*
+	 * for GADGET/HOST PCI (devfn) function number is 0,
+	 * for OTG PCI (devfn) function number is 1
+	 */
+	if (!id || pdev->devfn != PCI_DEV_FN_HOST_DEVICE)
+		return -EINVAL;
+
+	err = pcim_enable_device(pdev);
+	if (err) {
+		dev_err(&pdev->dev, "Enabling PCI device has failed %d\n", err);
+		return err;
+	}
+
+	pci_set_master(pdev);
+	wrap = devm_kzalloc(&pdev->dev, sizeof(*wrap), GFP_KERNEL);
+	if (!wrap) {
+		dev_err(&pdev->dev, "Failed to load PCI module\n");
+		return -ENOMEM;
+	}
+
+	/* function 0: host(BAR_0) + device(BAR_1) + otg(BAR_2)). */
+	memset(wrap->dev_res, 0x00,
+	       sizeof(struct resource) * ARRAY_SIZE(wrap->dev_res));
+	dev_dbg(&pdev->dev, "Initialize Device resources\n");
+	res = wrap->dev_res;
+
+	res[RES_DEV_ID].start = pci_resource_start(pdev, PCI_BAR_DEV);
+	res[RES_DEV_ID].end =   pci_resource_end(pdev, PCI_BAR_DEV);
+	res[RES_DEV_ID].name = "cdns3-dev-regs";
+	res[RES_DEV_ID].flags = IORESOURCE_MEM;
+	dev_dbg(&pdev->dev, "USBSS-DEV physical base addr: %pa\n",
+		&res[RES_DEV_ID].start);
+
+	res[RES_HOST_ID].start = pci_resource_start(pdev, PCI_BAR_HOST);
+	res[RES_HOST_ID].end = pci_resource_end(pdev, PCI_BAR_HOST);
+	res[RES_HOST_ID].name = "cdns3-xhci-regs";
+	res[RES_HOST_ID].flags = IORESOURCE_MEM;
+	dev_dbg(&pdev->dev, "USBSS-XHCI physical base addr: %pa\n",
+		&res[RES_HOST_ID].start);
+
+	res[RES_DRD_ID].start = pci_resource_start(pdev, PCI_BAR_OTG);
+	res[RES_DRD_ID].end =   pci_resource_end(pdev, PCI_BAR_OTG);
+	res[RES_DRD_ID].name = "cdns3-otg";
+	res[RES_DRD_ID].flags = IORESOURCE_MEM;
+	dev_dbg(&pdev->dev, "USBSS-DRD physical base addr: %pa\n",
+		&res[RES_DRD_ID].start);
+
+	/* Interrupt common for both device and XHCI */
+	wrap->dev_res[RES_IRQ_ID].start = pdev->irq;
+	wrap->dev_res[RES_IRQ_ID].name = "cdns3-irq";
+	wrap->dev_res[RES_IRQ_ID].flags = IORESOURCE_IRQ;
+
+	/* set up platform device info */
+	memset(&plat_info, 0, sizeof(plat_info));
+	plat_info.parent = &pdev->dev;
+	plat_info.fwnode = pdev->dev.fwnode;
+	plat_info.name = PLAT_DRIVER_NAME;
+	plat_info.id = pdev->devfn;
+	plat_info.res = wrap->dev_res;
+	plat_info.num_res = ARRAY_SIZE(wrap->dev_res);
+	plat_info.dma_mask = pdev->dma_mask;
+
+	/* register platform device */
+	wrap->plat_dev = platform_device_register_full(&plat_info);
+	if (IS_ERR(wrap->plat_dev)) {
+		err = PTR_ERR(wrap->plat_dev);
+		return err;
+	}
+
+	pci_set_drvdata(pdev, wrap);
+
+	return err;
+}
+
+void cdns3_pci_remove(struct pci_dev *pdev)
+{
+	struct cdns3_wrap *wrap = (struct cdns3_wrap *)pci_get_drvdata(pdev);
+
+	platform_device_unregister(wrap->plat_dev);
+}
+
+static const struct pci_device_id cdns3_pci_ids[] = {
+	{ PCI_DEVICE(CDNS_VENDOR_ID, CDNS_DEVICE_ID), },
+	{ 0, }
+};
+
+static struct pci_driver cdns3_pci_driver = {
+	.name = PCI_DRIVER_NAME,
+	.id_table = cdns3_pci_ids,
+	.probe = cdns3_pci_probe,
+	.remove = cdns3_pci_remove,
+};
+
+module_pci_driver(cdns3_pci_driver);
+MODULE_DEVICE_TABLE(pci, cdns3_pci_ids);
+
+MODULE_AUTHOR("Pawel Laszczak <pawell@cadence.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Cadence USBSS PCI wrapperr");
+
-- 
2.17.1

