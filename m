Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F794C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 10:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4781D2080F
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 10:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="Eo+cPsOE";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Fm4rnqng"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4781D2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbeKRUcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 15:32:32 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:36314 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726258AbeKRUay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 15:30:54 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wAIA6m2U016126;
        Sun, 18 Nov 2018 02:10:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=Arf43ZtvLsNPLtnGOxAd4T17ad51DKPvS5I3RCNruZ0=;
 b=Eo+cPsOEwrH28gMYbFNDLCtEXD5XHPhWHguhM907GhSCuDyIx//NYDe9BiEF4P00Wij0
 rDn66rvpIzpUs6yZCcGJ+EzSa4Jv3fGuASt9kzSsYSI++O3TdeKSlahFSJ5LILVL+f3B
 ZbNiXfyiklxAV+BaDdiGE77A2vaUXZrQU6Yw/Sa+g0/CxE6MXyj5vCigU3dWpf3P4qHN
 n4ErTMRaO4ahGgVKQNc3e3WZjgN21LtDdJs50tgITTNeVtUgH70+hGAEJBvWNUUO5ENB
 xV2JQv+eRKvAy3dtQYghC3fWjERQBk9Um8uAFmR1s3rCTnXe3x1EkK8stJyS+qMby01G fg== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam03-dm3-obe.outbound.protection.outlook.com (mail-dm3nam03lp0016.outbound.protection.outlook.com [207.46.163.16])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2ntge14vgc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 18 Nov 2018 02:10:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Arf43ZtvLsNPLtnGOxAd4T17ad51DKPvS5I3RCNruZ0=;
 b=Fm4rnqng01o85BwSAJuURV34uQBugaVUFl6tG9O3ounv2e0I9mw2BRY/HkXY57OS7sgEUrDxurI0BvMl/v+wdzQ03/gsYIDxjjBMceJbc/DSBNykolGX7JX1CZAaqbzgr9vVTBUqj4DDXyx+QKUJj4mVL+4xcCvMTPfnsDbQ+wQ=
Received: from BYAPR07CA0039.namprd07.prod.outlook.com (2603:10b6:a03:60::16)
 by SN1PR07MB4112.namprd07.prod.outlook.com (2603:10b6:802:30::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1339.23; Sun, 18 Nov
 2018 10:10:48 +0000
Received: from CO1NAM05FT032.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::203) by BYAPR07CA0039.outlook.office365.com
 (2603:10b6:a03:60::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1339.20 via Frontend
 Transport; Sun, 18 Nov 2018 10:10:48 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 CO1NAM05FT032.mail.protection.outlook.com (10.152.96.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.3 via Frontend Transport; Sun, 18 Nov 2018 10:10:44 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id wAIAAb5Q029622
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Sun, 18 Nov 2018 02:10:43 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sun, 18 Nov 2018 11:10:42 +0100
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Sun, 18 Nov 2018 11:10:42 +0100
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id wAIAAdvO031498;
        Sun, 18 Nov 2018 10:10:39 GMT
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id wAIAAcZK031458;
        Sun, 18 Nov 2018 10:10:38 GMT
From:   Pawel Laszczak <pawell@cadence.com>
To:     <devicetree@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <rogerq@ti.com>, <linux-kernel@vger.kernel.org>,
        <adouglas@cadence.com>, <jbergsagel@ti.com>, <nsekhar@ti.com>,
        <nm@ti.com>, <sureshp@cadence.com>, <peter.chen@nxp.com>,
        <pjez@cadence.com>, <kurahul@cadence.com>,
        "Pawel Laszczak" <pawell@cadence.com>
Subject: [RFC PATCH v2 08/15] usb:cdns3: Implements device operations part of the API
Date:   Sun, 18 Nov 2018 10:09:04 +0000
Message-ID: <1542535751-16079-9-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1542535751-16079-1-git-send-email-pawell@cadence.com>
References: <1542535751-16079-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(396003)(39860400002)(2980300002)(36092001)(199004)(189003)(50466002)(48376002)(316002)(42186006)(26826003)(16586007)(305945005)(87636003)(7636002)(478600001)(54906003)(11346002)(446003)(8936002)(426003)(50226002)(486006)(476003)(8676002)(126002)(2616005)(336012)(5660300001)(246002)(76176011)(86362001)(51416003)(186003)(26005)(2351001)(105596002)(106466001)(47776003)(2906002)(36756003)(217873002)(14444005)(356004)(6666004)(4326008)(6916009)(107886003)(4720700003)(309714004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR07MB4112;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT032;1:IcD8cP822NapHUO4lWQml/oa7tct4wuIdn0eEck6w7h0JKw0/xdEKE2zHmw+5FgN37ND1uJYZ3dMx/91nMxV6eIkyNCgWG9ETfIQ+XgczY648NK3s06QQlwbVyLoedjS
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a93ef498-d0d2-43db-1fd5-08d64d3e1c6e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:SN1PR07MB4112;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB4112;3:i8Oel7C4m34Ui7psLOgd/51sVkG/4mLDXGkzs3PXfNIxDVps4UeBqmeZB29/7ND58RWs/QQXAPAluWyds2Wy0zvUB08SSm7uyCcG5wU6sshr5cy+UTA907FHKF4dRnBM5QVvvDIf45TalMN+4HcYeeyRz4sAW+nxHYWjtCRmLV9feNEKBlv5NMppJx8CIG7jtNyokaLo5RriRZqHkofDfCcxEKnzPR/JDm6lrciaOsreANQ1I7qGw+dItVq2ymLTuQ79Wx33LjYvj2GU/wN0Af71JZcfeLrWr1i9hnyCq+pcwcpmjnFjbziZCLKS0liGt2mLPKK0/j7kaUxMPpRcdRoXEVrkyUgcto9sud8eYzQ=;25:vvh/A1W1QJ3/sqZM0Qn9r4soLBdBCuX1deflI6w4Ibcv9zOVtEyhqsoBqzjwMegdHCC7Z3okrxrnJmPqcngAaCZ6uoYxZ+ewFo51UvpS8PfWX6g7DoOetsOu6lU6QVM3oTyexw5ZDA6+msQUmtj8jNzi9T7227iphuu5M7i+56ESyjONLDqqxL1/zzlWxt+d0NNicc99NbQ/Xo8ERIyxDj8VTvi/jMVwbiZEd2kk8d96Ji+RRnMq+B1bbI5fdxk+Mw/WyJlNwXleFiPcc/VM5EVYiCkWk0IVpvb25sdaBXM+tHcaS9Ck/J0G1CuqnNBoBPSpt491LPC7zZ3k+xkNOQ==
X-MS-TrafficTypeDiagnostic: SN1PR07MB4112:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB4112;31:ge3JklZ2kZZBC9N4LXccySYI5YRiFZheCuMxA6OsMEZdv8vnUi41rpRxvYM/Jcf3jLnGsnAocf4BLA+sCAc9I+JHC3NH0BKpb0Xj60bt8/k7EduDH+NfZmAdsQm+NQzntSFqZGzdu+7kyMOf2qQPl2i/WCBQUaNHOMXLpRmbY9gfP/Z0mP0WqbYAa+Y0fYojry4hCdwZPUOdMupxKBqUG3Imkj4f/srOPF6lLXqCl4k=;20:jUXijJzJiZe00/AlhHcW8s55DhfT4qr3a/A7zo5Q+aVz63Xc0Eh8KJ0XMfTZmjx6sxFTX7cFQdoSmu46M5mSY/FVEuRBjDfNjLsIP4SwOXGzQkF4sZNX5+cxrAd50qrdIFyIhSyLSufOjFKRizSmDtbSVjvs78bYKN1qQ/WHbEtIrTiTV0U0muDQUurITKn8z2vpCOJVk87tRMMTdt1xa4kSRyb02RycMK4EOEKdvbZA3apTQB+0c4ZKvlNV03ogNlYFykB49yHHf9lgBhSH7JUhQeOx1ow0c4XtBhk77bZ+nWIGgxrXDkqn78zzIiTeZNO9XMo04HYmfLLKzrdzltFpjiHxxaVv/rtRb9zMieEhvudS3blnTPzjc8Byp6ppHHDCq4cLHj0x5pZSU9Blw1R6S3nlyqqoXlGqUc8XjUeAk02StaTD8GwbNjViIGH7RGRRHgJvT+6jXUHCJbjIijAsUztZ/cnH4tlqIvTUhAvrcZoYLrk+vonqgoAw5N+o
X-Microsoft-Antispam-PRVS: <SN1PR07MB411265017E181626849E2537DDDF0@SN1PR07MB4112.namprd07.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93003095)(10201501046)(3002001)(3231415)(944501410)(52105112)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:SN1PR07MB4112;BCL:0;PCL:0;RULEID:;SRVR:SN1PR07MB4112;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB4112;4:kOl+AfkoaKYItysjNcxThq9fQHk4wHHCe8BaS+54S1bQpCoW1VO/KW5q7Y6bfbI0vuQrVfBfPB9dugDeMyA1tampqnIjwXOiw/f6URXgp7qqyg951cECON6r3y2XOZr4a29ZwfBfG1dTrwoh0f0gjxU5t+uAIvfoGCA/8dMgjIAtcZIlLG9YWhEJZPI7YkNK6NoTtMveBPK3/42jFX56I5SjNxmAv15ufr0ECPj5eAoxWVCWucTcAOWVLKRjYNiyaS9fRgPtqT/fvmujHaW8zA==
X-Forefront-PRVS: 0860FE717F
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR07MB4112;23:H/0SJugcatVAThZKG/NQDb6MXDeqEEoeJmCaKT1nv?=
 =?us-ascii?Q?VUdCi18sVa9l0s4bcGjo+6nxNqfy3UrWQ4ndZsRm+KcwO6jUBXBa/H+RjxMP?=
 =?us-ascii?Q?IuMU95XNRxZz+F2AzGI6p7a1inDXmE35FSpfGFjqXy1fNRhl6VLqSXm/Quty?=
 =?us-ascii?Q?AQ3AXkpOxCKS73WTV6gfc19qmgHT3B397DvlhTunEOF0X5UGn1ptOtBDF0mt?=
 =?us-ascii?Q?/JvmNzUMbD4Pgs1EHtzTObqM8e4Gku3tFoilj3itVuM97HJ6v+w8C2axMw2n?=
 =?us-ascii?Q?wYh2gTkJ6dYYCWMYt735aHWeKX/6TB3DGXBbbTS0B+OsGYv0LPw9rSJv/Jfd?=
 =?us-ascii?Q?VDwJnBTBH/F35fmwzk2cqsukQ+GGm/VpNiu8ICWzZXyg+PS6OL/H3pHPgQdu?=
 =?us-ascii?Q?F/+9Uqb0Hy2nRETnAbZbHmnY+/MJtMvQSXlzNmFgV1qcuUz3O5EUSUcl0Iv/?=
 =?us-ascii?Q?2bz182alEK78kYWvy1mjRUvrcevHYDeowmwDRA7acwG2iP7rVwziE2Z9j+wj?=
 =?us-ascii?Q?/HcVJT7BPwRVNu6slmDWlqrh6TwBKZp/HOmfYyTuptienkR3WZAMQTs+EWld?=
 =?us-ascii?Q?wLCk769tOY/56YKf2JS/G78BxW1jhQLir4ZFW6L8wcUsxFAfteVm2ojeLE5N?=
 =?us-ascii?Q?H4gsdkCJii01mNXFyJVMG2c2KK3x/SQ0RlZT38oMoedkYUlrQoiY+8tNoV4r?=
 =?us-ascii?Q?MooCfsw0U0I2UNdhSo1yLZoUoJKN/ZVX8JnV2fAlpWnBHCMHd9z45oUo27sU?=
 =?us-ascii?Q?KSh7k5YQ0zv/3kUtCxGIVeLJE61HnUsGzHMfDsePigTNJJOubg9D7sGQYVzb?=
 =?us-ascii?Q?GtNIry+00xbgkjWIiHuZV5TO0ttZ1yW9ZzkCFPiMdLyNDT7/z/KDO6PP1KBf?=
 =?us-ascii?Q?RXonaTr1CImp1SU4mrKL+V+zoBmvR9L4uyBzijH6gIrrWSs6jTk+xE/L2jFr?=
 =?us-ascii?Q?A2M8rM46yp0NBMB2B7titzC4CmaFoJ9Zldi6RgI6dEACT6ZYeIhHbnFGefqi?=
 =?us-ascii?Q?oGGVjzpWhNKAGAjsRVlzitbasAQSQYQ28IHy9YCsl7Zg6Hl9WHzXpR7FP6uZ?=
 =?us-ascii?Q?mHC67jIRUfhLO12Rar8Hq8E28OY0N2n2vRhXy3KGhP9FCMLzyEY5F5HVALcU?=
 =?us-ascii?Q?mboEUtbhyTkoOCe6o7IG74/oLNJlSAzRhti33dFUmldEZi4rgUxfd/a7VePP?=
 =?us-ascii?Q?bbRzy0rupEBFfg=3D?=
X-Microsoft-Antispam-Message-Info: NiuMTIfz2hpEEnZGZ+ZARKzIMuG2q0whTSPvQyGz1uP+L21TfAbbC2aQg3ATzyUewkVf0f/mCf9Hb16kGIz/q/ha5I6WGsKw5o0TRueA9gvb697rDxZ+fb0ZnIAWSJVea6JdNozrVSY6WX7H2/g/FQ+grUJhwjSZODMobkjkRPbF2aCsyGw0P88aRvjWkvUO46Yc7lVSWjz26I4PAjqqK40h4S9qNPqAx+up2Fe8gajIStCgncXEvqCJgWCbbbdHWIAeq562OzTSFxXnBX5M+ta2vvSuqy8BDV/v7ANcecMUXJADazYR0Lq8TY1hZCiJgvZuYLPLq4ta0GDf8ebCa4ys0BhiL6I4OhfDV76kBNU=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB4112;6:+Ob1puyOXiHn6Ko4SB40XIDlORexInUr9smAFLPVSTKXjrKlHm4OIF2ikJ14A2JbRhhehdNCBsNDObTPuAuNHvZnaD/aX23hud1Mq3qk4D0ppjVbi8OSJBJ9MaKctq1lc5cr7dHesXnE8OPLyjSV60XnlOHc5jUAEOP2pmiWkcyyI/7d0FA2J99XosVCOCglf472e/nig9qISDGA5bySlK8ZbxySU7gb5RUzl8vsPQ5c9lU8scMwxurHnrsP8Wye8hS8r6lFkqtA2otkgJwZfoUXy48n6mRYhCKN40P18Qv7EXuwN+cCdVP2dD1TaFxjLXxR+w0WOl867lM73ymPHmTjYW0tJyVdURtZ816PCWKnTn9LvY47baEHiLOTJzM/XMs00yjoo8aOIWKiiIKWjFedRFX4n6apiM4xRbL7sa3HMxJFfSJZUlqQXsAqVjKCuWLABH8ONCkrtNBxAf1L+w==;5:ZpQ24i6lrUMLKP1GQWno0zKMcOV3H0aN0Va6DysUK0rK2zF/Vku5PtPaoxL8pAogRXJm1gxDkqzhNPotf1mSCNuOxvb16kwfGHyflftlb6XmKRmqFGvb5tORDDN4UvtVr62s2WGG7uWriuGz6mCfRHp9OIUvJCvPMnoUM0So+rw=;7:NhGNnflUJ+vt3SrHkhP4khFjYRsavL9CxeKA2ZBG/zpvUUcgxKgGhz3JoCveyLx+37/KLB8eKXrAdDy2h/eo76TNPvnLB3okRzieMUaT211QQIIfj/NxIN2dIq7Oi41Z0EX4e5sB6jsKFMuf2rCZDg==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB4112;20:I7QahwH2v/cCFtUM8OfTfg51lEqCbl5qjYY0rYhJN3TddTYwTbAKQ/NiEr8NOI8RlAJNCLvjA5NNbUUGibeRZU17VANO5B+xOEe8xs6jQBGE+xWAGIgUbjO4kfB40I5fItPn+5Yi8DXOkMxLAZA+Y/53odIbHpaiLpcL5KyK2o9xTxwLTULdkT0j2TD41tbRjt7Yzlfv6vCsqkJH6Ep5CUdu2cr3o47NLmRur7cZda9NRozHZntI8kXjAgvjPF+g
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2018 10:10:44.4949
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a93ef498-d0d2-43db-1fd5-08d64d3e1c6e
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR07MB4112
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-18_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811180096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch adds implementation callback function defined in
usb_gadget_ops object.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/gadget.c | 249 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 247 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
index 376b68b13d1b..702a05faa664 100644
--- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/gadget.c
@@ -17,6 +17,36 @@
 #include "gadget-export.h"
 #include "gadget.h"
 
+/**
+ * cdns3_handshake - spin reading  until handshake completes or fails
+ * @ptr: address of device controller register to be read
+ * @mask: bits to look at in result of read
+ * @done: value of those bits when handshake succeeds
+ * @usec: timeout in microseconds
+ *
+ * Returns negative errno, or zero on success
+ *
+ * Success happens when the "mask" bits have the specified value (hardware
+ * handshake done). There are two failure modes: "usec" have passed (major
+ * hardware flakeout), or the register reads as all-ones (hardware removed).
+ */
+int cdns3_handshake(void __iomem *ptr, u32 mask, u32 done, int usec)
+{
+	u32	result;
+
+	do {
+		result = readl(ptr);
+		if (result == ~(u32)0)	/* card removed */
+			return -ENODEV;
+		result &= mask;
+		if (result == done)
+			return 0;
+		udelay(1);
+		usec--;
+	} while (usec > 0);
+	return -ETIMEDOUT;
+}
+
 /**
  * cdns3_set_register_bit - set bit in given register.
  * @ptr: address of device controller register to be read and changed
@@ -43,6 +73,25 @@ void cdns3_select_ep(struct cdns3_device *priv_dev, u32 ep)
 	writel(ep, &priv_dev->regs->ep_sel);
 }
 
+static void cdns3_free_trb_pool(struct cdns3_endpoint *priv_ep)
+{
+	struct cdns3_device *priv_dev = priv_ep->cdns3_dev;
+
+	if (priv_ep->trb_pool) {
+		dma_free_coherent(priv_dev->sysdev,
+				  TRB_RIGN_SIZE,
+				  priv_ep->trb_pool, priv_ep->trb_pool_dma);
+		priv_ep->trb_pool = NULL;
+	}
+
+	if (priv_ep->aligned_buff) {
+		dma_free_coherent(priv_dev->sysdev, CDNS3_UNALIGNED_BUF_SIZE,
+				  priv_ep->aligned_buff,
+				  priv_ep->aligned_dma_addr);
+		priv_ep->aligned_buff = NULL;
+	}
+}
+
 /**
  * cdns3_irq_handler - irq line interrupt handler
  * @cdns: cdns3 instance
@@ -58,6 +107,114 @@ static irqreturn_t cdns3_irq_handler_thread(struct cdns3 *cdns)
 	return ret;
 }
 
+/* Find correct direction for HW endpoint according to description */
+static int cdns3_ep_dir_is_correct(struct usb_endpoint_descriptor *desc,
+				   struct cdns3_endpoint *priv_ep)
+{
+	return (priv_ep->endpoint.caps.dir_in && usb_endpoint_dir_in(desc)) ||
+	       (priv_ep->endpoint.caps.dir_out && usb_endpoint_dir_out(desc));
+}
+
+static struct cdns3_endpoint *cdns3_find_available_ss_ep(struct cdns3_device *priv_dev,
+							 struct usb_endpoint_descriptor *desc)
+{
+	struct usb_ep *ep;
+	struct cdns3_endpoint *priv_ep;
+
+	list_for_each_entry(ep, &priv_dev->gadget.ep_list, ep_list) {
+		unsigned long num;
+		int ret;
+		/* ep name pattern likes epXin or epXout */
+		char c[2] = {ep->name[2], '\0'};
+
+		ret = kstrtoul(c, 10, &num);
+		if (ret)
+			return ERR_PTR(ret);
+
+		priv_ep = ep_to_cdns3_ep(ep);
+		if (cdns3_ep_dir_is_correct(desc, priv_ep)) {
+			if (!(priv_ep->flags & EP_USED)) {
+				priv_ep->num  = num;
+				priv_ep->flags |= EP_USED;
+				return priv_ep;
+			}
+		}
+	}
+	return ERR_PTR(-ENOENT);
+}
+
+static struct usb_ep *cdns3_gadget_match_ep(struct usb_gadget *gadget,
+					    struct usb_endpoint_descriptor *desc,
+					    struct usb_ss_ep_comp_descriptor *comp_desc)
+{
+	struct cdns3_device *priv_dev = gadget_to_cdns3_device(gadget);
+	struct cdns3_endpoint *priv_ep;
+	unsigned long flags;
+
+	priv_ep = cdns3_find_available_ss_ep(priv_dev, desc);
+	if (IS_ERR(priv_ep)) {
+		dev_err(&priv_dev->dev, "no available ep\n");
+		return NULL;
+	}
+
+	dev_dbg(&priv_dev->dev, "match endpoint: %s\n", priv_ep->name);
+
+	spin_lock_irqsave(&priv_dev->lock, flags);
+	priv_ep->endpoint.desc = desc;
+	priv_ep->dir  = usb_endpoint_dir_in(desc) ? USB_DIR_IN : USB_DIR_OUT;
+	priv_ep->type = usb_endpoint_type(desc);
+
+	list_add_tail(&priv_ep->ep_match_pending_list,
+		      &priv_dev->ep_match_list);
+	spin_unlock_irqrestore(&priv_dev->lock, flags);
+	return &priv_ep->endpoint;
+}
+
+/**
+ * cdns3_gadget_get_frame Returns number of actual ITP frame
+ * @gadget: gadget object
+ *
+ * Returns number of actual ITP frame
+ */
+static int cdns3_gadget_get_frame(struct usb_gadget *gadget)
+{
+	struct cdns3_device *priv_dev = gadget_to_cdns3_device(gadget);
+
+	return readl(&priv_dev->regs->usb_iptn);
+}
+
+static int cdns3_gadget_wakeup(struct usb_gadget *gadget)
+{
+	return 0;
+}
+
+static int cdns3_gadget_set_selfpowered(struct usb_gadget *gadget,
+					int is_selfpowered)
+{
+	struct cdns3_device *priv_dev = gadget_to_cdns3_device(gadget);
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv_dev->lock, flags);
+	gadget->is_selfpowered = !!is_selfpowered;
+	spin_unlock_irqrestore(&priv_dev->lock, flags);
+	return 0;
+}
+
+static int cdns3_gadget_pullup(struct usb_gadget *gadget, int is_on)
+{
+	struct cdns3_device *priv_dev = gadget_to_cdns3_device(gadget);
+
+	if (!priv_dev->start_gadget)
+		return 0;
+
+	if (is_on)
+		writel(USB_CONF_DEVEN, &priv_dev->regs->usb_conf);
+	else
+		writel(USB_CONF_DEVDS, &priv_dev->regs->usb_conf);
+
+	return 0;
+}
+
 static void cdns3_gadget_config(struct cdns3_device *priv_dev)
 {
 	struct cdns3_usb_regs __iomem *regs = priv_dev->regs;
@@ -74,6 +231,95 @@ static void cdns3_gadget_config(struct cdns3_device *priv_dev)
 	writel(USB_CONF_DEVEN, &regs->usb_conf);
 }
 
+/**
+ * cdns3_gadget_udc_start Gadget start
+ * @gadget: gadget object
+ * @driver: driver which operates on this gadget
+ *
+ * Returns 0 on success, error code elsewhere
+ */
+static int cdns3_gadget_udc_start(struct usb_gadget *gadget,
+				  struct usb_gadget_driver *driver)
+{
+	struct cdns3_device *priv_dev = gadget_to_cdns3_device(gadget);
+	unsigned long flags;
+
+	if (priv_dev->gadget_driver) {
+		dev_err(&priv_dev->dev, "%s is already bound to %s\n",
+			priv_dev->gadget.name,
+			priv_dev->gadget_driver->driver.name);
+		return -EBUSY;
+	}
+
+	spin_lock_irqsave(&priv_dev->lock, flags);
+	priv_dev->gadget_driver = driver;
+	if (!priv_dev->start_gadget)
+		goto unlock;
+
+	cdns3_gadget_config(priv_dev);
+unlock:
+	spin_unlock_irqrestore(&priv_dev->lock, flags);
+	return 0;
+}
+
+/**
+ * cdns3_gadget_udc_stop Stops gadget
+ * @gadget: gadget object
+ *
+ * Returns 0
+ */
+static int cdns3_gadget_udc_stop(struct usb_gadget *gadget)
+{
+	struct cdns3_device *priv_dev = gadget_to_cdns3_device(gadget);
+	struct cdns3_endpoint *priv_ep, *temp_ep;
+	u32 bEndpointAddress;
+	struct usb_ep *ep;
+	int ret = 0;
+	int i;
+
+	priv_dev->gadget_driver = NULL;
+	list_for_each_entry_safe(priv_ep, temp_ep, &priv_dev->ep_match_list,
+				 ep_match_pending_list) {
+		list_del(&priv_ep->ep_match_pending_list);
+		priv_ep->flags &= ~EP_USED;
+	}
+
+	priv_dev->onchip_mem_allocated_size = 0;
+	priv_dev->out_mem_is_allocated = 0;
+	priv_dev->gadget.speed = USB_SPEED_UNKNOWN;
+
+	for (i = 0; i < priv_dev->ep_nums ; i++)
+		cdns3_free_trb_pool(priv_dev->eps[i]);
+
+	if (!priv_dev->start_gadget)
+		return 0;
+
+	list_for_each_entry(ep, &priv_dev->gadget.ep_list, ep_list) {
+		priv_ep = ep_to_cdns3_ep(ep);
+		bEndpointAddress = priv_ep->num | priv_ep->dir;
+		cdns3_select_ep(priv_dev, bEndpointAddress);
+		writel(EP_CMD_EPRST, &priv_dev->regs->ep_cmd);
+		ret = cdns3_handshake(&priv_dev->regs->ep_cmd,
+				      EP_CMD_EPRST, 0, 100);
+	}
+
+	/* disable interrupt for device */
+	writel(0, &priv_dev->regs->usb_ien);
+	writel(USB_CONF_DEVDS, &priv_dev->regs->usb_conf);
+
+	return ret;
+}
+
+static const struct usb_gadget_ops cdns3_gadget_ops = {
+	.get_frame = cdns3_gadget_get_frame,
+	.wakeup = cdns3_gadget_wakeup,
+	.set_selfpowered = cdns3_gadget_set_selfpowered,
+	.pullup = cdns3_gadget_pullup,
+	.udc_start = cdns3_gadget_udc_start,
+	.udc_stop = cdns3_gadget_udc_stop,
+	.match_ep = cdns3_gadget_match_ep,
+};
+
 /**
  * cdns3_init_ep Initializes software endpoints of gadget
  * @cdns3: extended gadget object
@@ -184,8 +430,7 @@ static int __cdns3_gadget_init(struct cdns3 *cdns)
 	/* fill gadget fields */
 	priv_dev->gadget.max_speed = USB_SPEED_SUPER;
 	priv_dev->gadget.speed = USB_SPEED_UNKNOWN;
-	//TODO: Add implementation of cdns3_gadget_ops
-	//priv_dev->gadget.ops = &cdns3_gadget_ops;
+	priv_dev->gadget.ops = &cdns3_gadget_ops;
 	priv_dev->gadget.name = "usb-ss-gadget";
 	priv_dev->gadget.sg_supported = 1;
 	priv_dev->is_connected = 0;
-- 
2.17.1

