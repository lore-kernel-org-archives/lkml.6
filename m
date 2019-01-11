Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F68C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68F53218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="jPqC0Ort";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="STfuA025"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392096AbfAKPOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:14:54 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:51300 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732584AbfAKPOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 10:14:52 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0BFBY5d005559;
        Fri, 11 Jan 2019 07:14:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=ETDIrzDPI3nfSVAmaataAg0eoRdvCyS0UCenUTGwE6Y=;
 b=jPqC0Ortm0abV9Eb/uQmx7/iLiN9UtCj8ouUVY6VV3QY4FvRCwg+sAMsFM5PtaExDXhS
 tFgQU2begnecgIYaBOR2amY/lCIosZW6DaRcBCRVxZq3FjHZfORVgEMact3TI3NCgCDO
 sPmoCkXDoTy3EIlBfhUqmIH7meh/xS+8MdvAOkbw4YBTTfVKaHnIgb1T26A4J0cyEITp
 rAJtFBm31uV5zYH0P75cEImNhAczeESw4eEQ1+HI4CJwfQBFj3/ZMKrneX3t0nynI6Zk
 A+fBArHCqJV9kNWbjDXV+eWMmxzyPo8jgyQa/XvyPeDC0ctE1ieu+kp6e0p1ODJW0Fkz cA== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=jank@cadence.com
Received: from nam05-by2-obe.outbound.protection.outlook.com (mail-by2nam05lp2053.outbound.protection.outlook.com [104.47.50.53])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2px0jqe8ev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Jan 2019 07:14:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETDIrzDPI3nfSVAmaataAg0eoRdvCyS0UCenUTGwE6Y=;
 b=STfuA02507DIL9exRorD2OL93eGmH8ufoJufXKvd1BbJS+gwsd5EgSVwgnN5t+r8V2ihpf1JCC08MEsDEH/lTDCzXzg8VqIGmEOxY1vwiOP7uzQt4iX0aC/xMiPBNCaWQLRy28G+3QNvY1nob5BXA+dg/zzOXfdvXHG3AhzNoFo=
Received: from SN4PR0701CA0020.namprd07.prod.outlook.com
 (2603:10b6:803:28::30) by SN4PR0701MB3725.namprd07.prod.outlook.com
 (2603:10b6:803:4d::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1516.18; Fri, 11 Jan
 2019 15:14:21 +0000
Received: from DM3NAM05FT046.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::204) by SN4PR0701CA0020.outlook.office365.com
 (2603:10b6:803:28::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1516.14 via Frontend
 Transport; Fri, 11 Jan 2019 15:14:21 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM3NAM05FT046.mail.protection.outlook.com (10.152.98.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.10 via Frontend Transport; Fri, 11 Jan 2019 15:14:20 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x0BFEHA9001005
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 11 Jan 2019 07:14:19 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 11 Jan 2019 16:14:16 +0100
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 11 Jan 2019 16:14:16 +0100
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id x0BFEFMM025525;
        Fri, 11 Jan 2019 15:14:15 GMT
Received: (from jank@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id x0BFEFDK025524;
        Fri, 11 Jan 2019 15:14:15 GMT
From:   Jan Kotas <jank@cadence.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jan Kotas <jank@cadence.com>
Subject: [PATCH v2 2/2] rtc: Add Cadence RTC driver
Date:   Fri, 11 Jan 2019 15:14:01 +0000
Message-ID: <20190111151401.25047-3-jank@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190111151401.25047-1-jank@cadence.com>
References: <20190111151401.25047-1-jank@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(346002)(39860400002)(396003)(376002)(136003)(2980300002)(36092001)(199004)(189003)(305945005)(1076003)(7636002)(2616005)(476003)(126002)(446003)(426003)(106466001)(105596002)(336012)(76176011)(51416003)(478600001)(26826003)(87636003)(30864003)(186003)(11346002)(575784001)(86362001)(26005)(50466002)(48376002)(5660300001)(486006)(107886003)(54906003)(4326008)(110136005)(42186006)(2906002)(36756003)(16586007)(316002)(8676002)(47776003)(50226002)(8936002)(246002)(14444005)(6666004)(356004)(2101003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0701MB3725;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT046;1:ieo0S+dMwLjcBVHuqZLV81UFGWr+4c+oJLABXaVvcym53/25RFT8wb6dMHoy+m8iy/m2nFVTbaD2PeLvbRlwvmDLMMVogk8mYlmVU3FjixkcyR8BF1pCZ8h3ZHC+g2/krFbP9iCNY5/arVFR7sXInQ==
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb38999f-c106-46f0-e559-08d677d77690
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060);SRVR:SN4PR0701MB3725;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3725;3:FqESqq1yk5Y2zAFYTmTftsNMGd8axi4mnfRddTIpfwnL1hBo7zKFmyX8/GpSHK25LLgDlETbl1Vl1UMbdgyE2EWrzj3SFh5TWRzbJIfg67CDPjamf7r7Ki3qwxbM3dwxftlPhHBHVxxb+0Dr6PuaTCnokrc0Tt3Q6JfUuoumGaYy051Qnf2K04GRAS07fQIg+AciDXD+ECxqTGVGlXiErqKRt+qjhomN0Ape89T0OWUTeSX1SmrtRnuBxNEPOCn84xnQdrKzXo1CFyg3uBkeoOSTbomuaKXnwurQyZKLaPMyr3Jd2oR/QpE0fmQXl0fJiwIL/7GZKl9CSAJykIfSfaBcKGo6GZuvd/h0byGm05uTGb/CTi2wrUsMc6P6cg6i;25:C06jo/BAj8JXW3GMQ6o31Yp8n3vKf+89jIbH8wHwj6zChC5+t3+pRImGpm+WNeJ3riFsC6krw/GpSufYzsgq39e+rePaAbYkFqO/p0/8ZZB5kMylcCBeqW+tVjNxoPI2w0ys90DxGScwIQFkxQvBIlZ0QD7JG/o3BpiGxeBFDrSgov25qmdqB4/B4l7mAz6ggQ/zb56c5ZpNSuZQ6FFuIF2UnVBcnzTMUKdHhZd4deF6pXADF1Y/FvJZZ2AA7ieU6ZKtx1ExI0l8uQf/n3cMruhr4S4+ZzMD98wd7O0AmHSHyYu8g1asgWt/EfABSsNFaYLm7YXOg1t06JRzgUSwQg==
X-MS-TrafficTypeDiagnostic: SN4PR0701MB3725:
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3725;31:VOP9PdiJjidpTLED2tb2dm2ba04aLCBAId8oukR7K+4f5up4BFOas8RDMl2uYtkVwhmtyUIboBrxI0fF6bJ7Tysogv2tGlROIeQLIWPuNKGdjM4VfqqQ5quWQMtkLWktT9MQHCrbpW4Rsqpv4em+FD0qupBDpDxLUM0D5A/mE7kMrI/za+5gcoB1cQRamAj6O+wyn0hEeCNXIYMcQGpA8PUAaB2boplBt4MBOTHl9WQ=;20:4Sq6q8+iX5Ptp06MYxwL9vUMCXmZQMfSHQ9/iivt0wTxFWsPIdrhZArZjJwDZLi9Vc7g/4ZUkAT/1IkmY02WTS3p9MjeV9JLpQOqsIg526SnWnqcvvHx03Ax4bzTQakVqTuYB+Fz7thyo9kAtfwcLpdl/Qxae9fjmJ0uM1TypyjypLly+LAehH1u39b5buf8wfo/9UpqE4Is9APICNn6LCamCWosk4jOZzXqs5rKS0Ga61J0gDjh/MVjU6f1hPw7+p7K+34AYU0my/kZpgvrJX3My9H1dcF6V2rcuEIa1Kf6p3BAR3QiG8dxmEIW7MyvfG/f3sG/bML+n8mYVrhPGOu2z89XnayDXwXQ0LEcGvP4ANd3wHDlDaWu1QBYxEtQurPAwR2qG/jAPlzm/fA7uYeEt+eP0Al1g4iD71sL0jkuXVWmNAobyc36bVChXBC5HXeSREE9q0lE+uKX5iR84aFtCFkKzPm9fxvJjaRnWGnjiRxBfzQ8qPmg/a+TixXm
X-Microsoft-Antispam-PRVS: <SN4PR0701MB37255CF5F2BAB58EB2999107D0850@SN4PR0701MB3725.namprd07.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3725;4:1macf1J8Bo9vICr0Rb1sT5ykLcho+kL3k0bF60pEVmf99MOWlPP3yu/G0N3wRgTNJl0C3lqPD/JKB5vr7Lf6W6PU/wm/DAyrSs+4LQSm1cTIhIGNJR+x3rKSGn3pLGW919RUdzmFPZacmvBgunfqQxggCufVb7nDOYbYKtMgC+vR3pvET+kGZ4sXfuz8W3aJqBUgY/1zcfm1yC4DOJn3mbjQKelBEItX0+nndqx48QoQbfDt61cT27l3o9MhCgcjGfzQcDeb22IB2v+yuFCDtgVyXTa6OyrygMxeRyNxmso=
X-Forefront-PRVS: 09144DB0F7
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN4PR0701MB3725;23:KcV/w1AuqVUtb3rzyMqSQHwFl4zU3UD6VHl7Ca/?=
 =?us-ascii?Q?oyWraXo+IUZ2pFZoxvoBSJf0OrSajpws18AsH5L8PHRM260CMrOg0YrhWXWk?=
 =?us-ascii?Q?ZxhxsfJlgQ96RMvZWcarhFez6Za5ptUuMrdKp6/XF/lha+xZFAZ+oJeeokbi?=
 =?us-ascii?Q?CDgglOVZ9QtAC6padxmdyD5o9B2XT0hIhTY09oeeWxCkzeK6jlyoERChdNAq?=
 =?us-ascii?Q?RiheN9aBwWwY+ka2UCitx3u8AFL8naofkZu/uvIbx2ly7c8rgyGIf9dDBXce?=
 =?us-ascii?Q?8jGVM9pKjCu6M64hfvhuYvlrU24plqOMiU9nz9CgDgDsHboeu4uyhlt4IWRj?=
 =?us-ascii?Q?VGfR4/f2LlofdZ/kGtdcGD5Yq+Bi3umzdILkEcpyVl/50HIgSpQw4hDfhKBO?=
 =?us-ascii?Q?DV64jdlxvpz7GdmTFS+YOwyuyemKCzaKJgKgnmCZ84RolPyiubwnvNIhTijs?=
 =?us-ascii?Q?i+srPs7ueN/pDHg9Spmuoy1g0Txg9XzzozvD9IwYJLWPx5xWZ5T8i1mVxUyr?=
 =?us-ascii?Q?5LXr4nQuKy91tOP1NHOxE5D3aRR+FTikov9qJV3yJQgThQ9MxYw57xudNRJ/?=
 =?us-ascii?Q?LUSMUmGqxUGdzdQfebV4/Sg3C/k9f61Th0eArywcmwjJhpiMn9ird2tHBq1O?=
 =?us-ascii?Q?qNWWJbK0Ez6ga4XK/aZcJyCn31RQhHWBl0eD2+7LKBRIxihe1yVSR8VmFEtP?=
 =?us-ascii?Q?8zHrvrZbFGRsB8kNXO4CGubFDdkvJIf886tFJL2t6l/dPkM9wckFxnbCOPy5?=
 =?us-ascii?Q?uSob5LjWTAJPNRtPVwvSD4q3E1Ed/eLKpMdBLrfP0Y+MNPwZ2NztA7RXiYj2?=
 =?us-ascii?Q?5woILyRCz5734ovB9kL/6DfXoBo9Ms+t+t7lNtBuGFSTd8TtbYLdJNmeWClP?=
 =?us-ascii?Q?MV0sVVr3IkLrY0Wh5V3uE5VlU/4/tkE1L8R8LdcDDPNDPy4PWsWmfRYs8dfs?=
 =?us-ascii?Q?NiYML0MMLDLpY/UkKOCFFBoFhdjpakYgOOxFysaQnNRP7Del50KXbKWStXGu?=
 =?us-ascii?Q?XjqvKUlYghGQz6bGQHNfpIy/052FWo4wY8ipmpOxVPGMLTj6xnq3qevXgzTs?=
 =?us-ascii?Q?/Q3r2cNAt0nJf8BomNKq3TRy+crTfDaxdKL+0MSvUTKDr3SfjjHkK3Psoj46?=
 =?us-ascii?Q?ZD1YYPVArP2+/dHO8faoVbKxzFVrbEDHVzaX6fKDEf827cWdhB1MXkWzyL33?=
 =?us-ascii?Q?K7mY49emNhIHyKuN+/NlSRII7d1Mh68Eu/VSg+PKCUvg1AjBKKNGLWgoCODq?=
 =?us-ascii?Q?Md/zOnJkXthDVCa0X89maSF+zeW7s8nQ1snkEEb5s?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: bnjZqaWs5GpUBzoYiAiA/mB+e5wzeYPO9SQ63gYS7qXXXncoxKqa1qofOW9+TbreVIwb+3kIpI5c7eIKzEzL5rF6StZxaVtW7Sb6RDMfmFIAZ2yXCO1raFAZU6ijeCYGfacB7OAqj0gGVV1PrWocZEIJU5cuJS5BcNMbLaMeRJcmALx7A/3F6NXOg73IwE33O/8A5GwNP23i+SuhRB8I4dXdZowMgc7Oe0bVfAYhm6a8WPIrcnpMkLYoY2IjC6jB5XvYBIhJdLHpOW2Igj/3Qg/HpfWOgBBeHdZZdcglcE14egsc1ozNRFEkC1Ums6gat/qNV12egqGBT8Xih0NNgvDN3B3pY4FY02C3nWzk/i0LEIoIY6JisZY7SfgUneOV2a0xBeZMku8rBfArik5rRwC1mol26mBd98cjgbuZoGU=
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3725;6:/jJB8dzsye4zZlFbLMI0RmLxXfIMYqDReRSqj3W2ryu96C0/CHsXb0dyapj/Fk08azJqXVDtPKAiJc0Ij0HEtFuedBEblTl9K0Tm5K/oNIyjn9/6z9xZI53v1XBAwZiKiKtAUnu788GvUlblMaqwvS0KFqw8QgQvOobTvHEvpFBLZPDDnnuhycxnvMmg9OMv1aiX4ySIhCY709UePRQEtAsUTP74f0ie0joDjtkt0c34rb3vhIPEjxjViJHmO8cE74URmjdJ+FlWo+WUdpC04nwTWzK1gHBzV853T4lEeGtSNTAUgTRshTEwx1m0SseMpv+imcuYVjXvvbX9X+DdUSJbGkBUycNSYYC3+AVL4NOFRRwnVH+GuBa2+9DGT3jziqPsNFcufHkQn5nYe1edZj3VDSv5CEZPY5GL7uSmbR0skHxpktOEtN9bY+Xk/re6wiJIXj33cKlSfjqihs/wow==;5:5BeLblt93k1mfqGGOPkwpiLUNimI9sToAAjhYgrKPwhlGXnhc9EXEow4JrYlijz2OE58ii3yJ+ifAgubA0TH5kasyS1csIV/gAgvgOfwTzOZ4w9NZODx4etfO2oFcwaOMD+AD3gwqUGy2RfM0XSW9NTeEDHjv4dFoIJIvN9jPwyjxFnC5jSfDFF57JAqbA1VylwO2R3UhJzlRoRwUcUNrg==;7:pSXdEut/zOJBQyj4UGHy4dWOisJ90iwB4mMWbCkXWHBhVFUF26zqpLIJdNRlZ4dFkhI/hPPqOVCD/+5ZZwP0dIBfGJbg4fmzYssnrgyV8IuE5p03zeV/nz/LQsl5j1tp9seAyGyDx2xkCwRVqtgsYg==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3725;20:6XgqhB24B4E8P/uu6/mZcUllMwrO7kghmSO0bmVkcBkgA1WKtjKruxNr1hmwlChZ4Y8KQLFDqty0Nf7NB6oJyqFKSLtdornPzlGb2RcJ53wVKHcj+oQe8SC+ya4XiOGBRSELIN4ejRB8SeWVU8e8T0+a3QG2Zu7OLwdHHx+ag0yxNgUsBzDqhJ2HfL+bo32u1qrgkiYZXUWnB/kch78vS9CJYlytgq2yYp2yMXkF7ZkIb1A/Hjg3tPgVqT74Kc+H
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2019 15:14:20.5697
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb38999f-c106-46f0-e559-08d677d77690
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0701MB3725
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-11_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901110125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a driver for Cadence RTC controller.

It can be enabled with RTC_DRV_CADENCE Kconfig option.
It supports waking system from sleep modes.

Signed-off-by: Jan Kotas <jank@cadence.com>
---
 drivers/rtc/Kconfig       |  10 ++
 drivers/rtc/Makefile      |   1 +
 drivers/rtc/rtc-cadence.c | 423 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 434 insertions(+)
 create mode 100644 drivers/rtc/rtc-cadence.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 225b0b851..0aba341ad 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1508,6 +1508,16 @@ config RTC_DRV_ARMADA38X
 	  This driver can also be built as a module. If so, the module
 	  will be called armada38x-rtc.
 
+config RTC_DRV_CADENCE
+	tristate "Cadence RTC driver"
+	depends on OF && HAS_IOMEM
+	help
+	  If you say Y here you will get access to Cadence RTC IP
+	  found on certain SOCs.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called rtc-cadence.
+
 config RTC_DRV_FTRTC010
 	tristate "Faraday Technology FTRTC010 RTC"
 	depends on HAS_IOMEM
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index df022d820..5adb41b45 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_RTC_DRV_AU1XXX)	+= rtc-au1xxx.o
 obj-$(CONFIG_RTC_DRV_BQ32K)	+= rtc-bq32k.o
 obj-$(CONFIG_RTC_DRV_BQ4802)	+= rtc-bq4802.o
 obj-$(CONFIG_RTC_DRV_BRCMSTB)	+= rtc-brcmstb-waketimer.o
+obj-$(CONFIG_RTC_DRV_CADENCE)	+= rtc-cadence.o
 obj-$(CONFIG_RTC_DRV_CMOS)	+= rtc-cmos.o
 obj-$(CONFIG_RTC_DRV_COH901331)	+= rtc-coh901331.o
 obj-$(CONFIG_RTC_DRV_CPCAP)	+= rtc-cpcap.o
diff --git a/drivers/rtc/rtc-cadence.c b/drivers/rtc/rtc-cadence.c
new file mode 100644
index 000000000..3b7d643c8
--- /dev/null
+++ b/drivers/rtc/rtc-cadence.c
@@ -0,0 +1,423 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2019 Cadence
+ *
+ * Authors:
+ *  Jan Kotas <jank@cadence.com>
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/io.h>
+#include <linux/rtc.h>
+#include <linux/clk.h>
+#include <linux/bcd.h>
+#include <linux/bitfield.h>
+#include <linux/interrupt.h>
+#include <linux/pm_wakeirq.h>
+
+/* Registers */
+#define CDNS_RTC_CTLR		0x00
+#define CDNS_RTC_HMR		0x04
+#define CDNS_RTC_TIMR		0x08
+#define CDNS_RTC_CALR		0x0C
+#define CDNS_RTC_TIMAR		0x10
+#define CDNS_RTC_CALAR		0x14
+#define CDNS_RTC_AENR		0x18
+#define CDNS_RTC_EFLR		0x1C
+#define CDNS_RTC_IENR		0x20
+#define CDNS_RTC_IDISR		0x24
+#define CDNS_RTC_IMSKR		0x28
+#define CDNS_RTC_STSR		0x2C
+#define CDNS_RTC_KRTCR		0x30
+
+/* Control */
+#define CDNS_RTC_CTLR_TIME	BIT(0)
+#define CDNS_RTC_CTLR_CAL	BIT(1)
+#define CDNS_RTC_CTLR_TIME_CAL	(CDNS_RTC_CTLR_TIME | CDNS_RTC_CTLR_CAL)
+
+/* Status */
+#define CDNS_RTC_STSR_VT	BIT(0)
+#define CDNS_RTC_STSR_VC	BIT(1)
+#define CDNS_RTC_STSR_VTA	BIT(2)
+#define CDNS_RTC_STSR_VCA	BIT(3)
+#define CDNS_RTC_STSR_VT_VC	(CDNS_RTC_STSR_VT | CDNS_RTC_STSR_VC)
+#define CDNS_RTC_STSR_VTA_VCA	(CDNS_RTC_STSR_VTA | CDNS_RTC_STSR_VCA)
+
+/* Keep RTC */
+#define CDNS_RTC_KRTCR_KRTC	BIT(0)
+
+/* Alarm, Event, Interrupt */
+#define CDNS_RTC_AEI_HOS	BIT(0)
+#define CDNS_RTC_AEI_SEC	BIT(1)
+#define CDNS_RTC_AEI_MIN	BIT(2)
+#define CDNS_RTC_AEI_HOUR	BIT(3)
+#define CDNS_RTC_AEI_DATE	BIT(4)
+#define CDNS_RTC_AEI_MNTH	BIT(5)
+#define CDNS_RTC_AEI_ALRM	BIT(6)
+
+/* Time */
+#define CDNS_RTC_TIME_H		GENMASK(7, 0)
+#define CDNS_RTC_TIME_S		GENMASK(14, 8)
+#define CDNS_RTC_TIME_M		GENMASK(22, 16)
+#define CDNS_RTC_TIME_HR	GENMASK(29, 24)
+#define CDNS_RTC_TIME_PM	BIT(30)
+#define CDNS_RTC_TIME_CH	BIT(31)
+
+/* Calendar */
+#define CDNS_RTC_CAL_DAY	GENMASK(2, 0)
+#define CDNS_RTC_CAL_M		GENMASK(7, 3)
+#define CDNS_RTC_CAL_D		GENMASK(13, 8)
+#define CDNS_RTC_CAL_Y		GENMASK(23, 16)
+#define CDNS_RTC_CAL_C		GENMASK(29, 24)
+#define CDNS_RTC_CAL_CH		BIT(31)
+
+#define CDNS_RTC_MAX_REGS_TRIES	3
+
+struct cdns_rtc {
+	struct rtc_device *rtc_dev;
+	struct clk *pclk;
+	struct clk *ref_clk;
+	void __iomem *regs;
+	int irq;
+};
+
+static void cdns_rtc_set_enabled(struct cdns_rtc *crtc, bool enabled)
+{
+	u32 reg = enabled ? 0x0 : CDNS_RTC_CTLR_TIME_CAL;
+
+	writel(reg, crtc->regs + CDNS_RTC_CTLR);
+}
+
+static bool cdns_rtc_get_enabled(struct cdns_rtc *crtc)
+{
+	return !(readl(crtc->regs + CDNS_RTC_CTLR) & CDNS_RTC_CTLR_TIME_CAL);
+}
+
+static irqreturn_t cdns_rtc_irq_handler(int irq, void *id)
+{
+	struct device *dev = id;
+	struct cdns_rtc *crtc = dev_get_drvdata(dev);
+
+	/* Reading the register clears it */
+	if (!(readl(crtc->regs + CDNS_RTC_EFLR) & CDNS_RTC_AEI_ALRM))
+		return IRQ_NONE;
+
+	rtc_update_irq(crtc->rtc_dev, 1, RTC_IRQF | RTC_AF);
+	return IRQ_HANDLED;
+}
+
+static u32 cdns_rtc_time2reg(struct rtc_time *tm)
+{
+	return FIELD_PREP(CDNS_RTC_TIME_S,  bin2bcd(tm->tm_sec))
+	     | FIELD_PREP(CDNS_RTC_TIME_M,  bin2bcd(tm->tm_min))
+	     | FIELD_PREP(CDNS_RTC_TIME_HR, bin2bcd(tm->tm_hour));
+}
+
+static void cdns_rtc_reg2time(u32 reg, struct rtc_time *tm)
+{
+	tm->tm_sec  = bcd2bin(FIELD_GET(CDNS_RTC_TIME_S, reg));
+	tm->tm_min  = bcd2bin(FIELD_GET(CDNS_RTC_TIME_M, reg));
+	tm->tm_hour = bcd2bin(FIELD_GET(CDNS_RTC_TIME_HR, reg));
+}
+
+static int cdns_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct cdns_rtc *crtc = dev_get_drvdata(dev);
+	u32 reg;
+
+	/* If the RTC is disabled, assume the values are invalid */
+	if (!cdns_rtc_get_enabled(crtc))
+		return -EINVAL;
+
+	cdns_rtc_set_enabled(crtc, false);
+
+	reg = readl(crtc->regs + CDNS_RTC_TIMR);
+	cdns_rtc_reg2time(reg, tm);
+
+	reg = readl(crtc->regs + CDNS_RTC_CALR);
+	tm->tm_mday = bcd2bin(FIELD_GET(CDNS_RTC_CAL_D, reg));
+	tm->tm_mon  = bcd2bin(FIELD_GET(CDNS_RTC_CAL_M, reg)) - 1;
+	tm->tm_year = bcd2bin(FIELD_GET(CDNS_RTC_CAL_Y, reg))
+		    + bcd2bin(FIELD_GET(CDNS_RTC_CAL_C, reg)) * 100 - 1900;
+	tm->tm_wday = bcd2bin(FIELD_GET(CDNS_RTC_CAL_DAY, reg)) - 1;
+
+	cdns_rtc_set_enabled(crtc, true);
+	return 0;
+}
+
+static int cdns_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct cdns_rtc *crtc = dev_get_drvdata(dev);
+	u32 timr, calr, stsr;
+	int ret = -EIO;
+	int year = tm->tm_year + 1900;
+	int tries;
+
+	cdns_rtc_set_enabled(crtc, false);
+
+	timr = cdns_rtc_time2reg(tm);
+
+	calr = FIELD_PREP(CDNS_RTC_CAL_D, bin2bcd(tm->tm_mday))
+	     | FIELD_PREP(CDNS_RTC_CAL_M, bin2bcd(tm->tm_mon + 1))
+	     | FIELD_PREP(CDNS_RTC_CAL_Y, bin2bcd(year % 100))
+	     | FIELD_PREP(CDNS_RTC_CAL_C, bin2bcd(year / 100))
+	     | FIELD_PREP(CDNS_RTC_CAL_DAY, tm->tm_wday + 1);
+
+	/* Update registers, check valid flags */
+	for (tries = 0; tries < CDNS_RTC_MAX_REGS_TRIES; tries++) {
+		writel(timr, crtc->regs + CDNS_RTC_TIMR);
+		writel(calr, crtc->regs + CDNS_RTC_CALR);
+		stsr = readl(crtc->regs + CDNS_RTC_STSR);
+
+		if ((stsr & CDNS_RTC_STSR_VT_VC) == CDNS_RTC_STSR_VT_VC) {
+			ret = 0;
+			break;
+		}
+	}
+
+	cdns_rtc_set_enabled(crtc, true);
+	return ret;
+}
+
+static int cdns_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
+{
+	struct cdns_rtc *crtc = dev_get_drvdata(dev);
+
+	if (enabled) {
+		writel((CDNS_RTC_AEI_SEC | CDNS_RTC_AEI_MIN | CDNS_RTC_AEI_HOUR
+			| CDNS_RTC_AEI_DATE | CDNS_RTC_AEI_MNTH),
+		       crtc->regs + CDNS_RTC_AENR);
+		writel(CDNS_RTC_AEI_ALRM, crtc->regs + CDNS_RTC_IENR);
+	} else {
+		writel(0, crtc->regs + CDNS_RTC_AENR);
+		writel(CDNS_RTC_AEI_ALRM, crtc->regs + CDNS_RTC_IDISR);
+	}
+
+	return 0;
+}
+
+static int cdns_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
+{
+	struct cdns_rtc *crtc = dev_get_drvdata(dev);
+	u32 reg;
+
+	reg = readl(crtc->regs + CDNS_RTC_TIMAR);
+	cdns_rtc_reg2time(reg, &alarm->time);
+
+	reg = readl(crtc->regs + CDNS_RTC_CALAR);
+	alarm->time.tm_mday = bcd2bin(FIELD_GET(CDNS_RTC_CAL_D, reg));
+	alarm->time.tm_mon  = bcd2bin(FIELD_GET(CDNS_RTC_CAL_M, reg)) - 1;
+
+	return 0;
+}
+
+static int cdns_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
+{
+	struct cdns_rtc *crtc = dev_get_drvdata(dev);
+	int ret = -EIO;
+	int tries;
+	u32 timar, calar, stsr;
+
+	cdns_rtc_alarm_irq_enable(dev, 0);
+
+	timar = cdns_rtc_time2reg(&alarm->time);
+	calar = FIELD_PREP(CDNS_RTC_CAL_D, bin2bcd(alarm->time.tm_mday))
+	      | FIELD_PREP(CDNS_RTC_CAL_M, bin2bcd(alarm->time.tm_mon + 1));
+
+	/* Update registers, check valid alarm flags */
+	for (tries = 0; tries < CDNS_RTC_MAX_REGS_TRIES; tries++) {
+		writel(timar, crtc->regs + CDNS_RTC_TIMAR);
+		writel(calar, crtc->regs + CDNS_RTC_CALAR);
+		stsr = readl(crtc->regs + CDNS_RTC_STSR);
+
+		if ((stsr & CDNS_RTC_STSR_VTA_VCA) == CDNS_RTC_STSR_VTA_VCA) {
+			ret = 0;
+			break;
+		}
+	}
+
+	if (!ret)
+		cdns_rtc_alarm_irq_enable(dev, alarm->enabled);
+	return ret;
+}
+
+static const struct rtc_class_ops cdns_rtc_ops = {
+	.read_time	= cdns_rtc_read_time,
+	.set_time	= cdns_rtc_set_time,
+	.read_alarm	= cdns_rtc_read_alarm,
+	.set_alarm	= cdns_rtc_set_alarm,
+	.alarm_irq_enable = cdns_rtc_alarm_irq_enable,
+};
+
+static int cdns_rtc_probe(struct platform_device *pdev)
+{
+	struct cdns_rtc *crtc;
+	struct resource *res;
+	int ret;
+	unsigned long ref_clk_freq;
+
+	crtc = devm_kzalloc(&pdev->dev, sizeof(*crtc), GFP_KERNEL);
+	if (!crtc)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	crtc->regs = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(crtc->regs))
+		return PTR_ERR(crtc->regs);
+
+	crtc->irq = platform_get_irq(pdev, 0);
+	if (crtc->irq < 0)
+		return -EINVAL;
+
+	crtc->pclk = devm_clk_get(&pdev->dev, "pclk");
+	if (IS_ERR(crtc->pclk)) {
+		ret = PTR_ERR(crtc->pclk);
+		dev_err(&pdev->dev,
+			"Failed to retrieve the peripheral clock, %d\n", ret);
+		return ret;
+	}
+
+	crtc->ref_clk = devm_clk_get(&pdev->dev, "ref_clk");
+	if (IS_ERR(crtc->ref_clk)) {
+		ret = PTR_ERR(crtc->ref_clk);
+		dev_err(&pdev->dev,
+			"Failed to retrieve the reference clock, %d\n", ret);
+		return ret;
+	}
+
+	crtc->rtc_dev = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(crtc->rtc_dev)) {
+		ret = PTR_ERR(crtc->rtc_dev);
+		dev_err(&pdev->dev,
+			"Failed to allocate the RTC device, %d\n", ret);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, crtc);
+
+	ret = clk_prepare_enable(crtc->pclk);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"Failed to enable the peripheral clock, %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(crtc->ref_clk);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"Failed to enable the reference clock, %d\n", ret);
+		goto err_disable_pclk;
+	}
+
+	ref_clk_freq = clk_get_rate(crtc->ref_clk);
+	if ((ref_clk_freq != 1) && (ref_clk_freq != 100)) {
+		dev_err(&pdev->dev,
+			"Invalid reference clock frequency %lu Hz.\n",
+			ref_clk_freq);
+		ret = -EINVAL;
+		goto err_disable_ref_clk;
+	}
+
+	ret = devm_request_irq(&pdev->dev, crtc->irq,
+			       cdns_rtc_irq_handler, 0,
+			       dev_name(&pdev->dev), &pdev->dev);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"Failed to request interrupt for the device, %d\n",
+			ret);
+		goto err_disable_ref_clk;
+	}
+
+	/* The RTC supports 01.01.1900 - 31.12.2999 */
+	crtc->rtc_dev->range_min = mktime64(1900,  1,  1,  0,  0,  0);
+	crtc->rtc_dev->range_max = mktime64(2999, 12, 31, 23, 59, 59);
+
+	crtc->rtc_dev->ops = &cdns_rtc_ops;
+	device_init_wakeup(&pdev->dev, true);
+
+	/* Always use 24-hour mode and keep the RTC values */
+	writel(0, crtc->regs + CDNS_RTC_HMR);
+	writel(CDNS_RTC_KRTCR_KRTC, crtc->regs + CDNS_RTC_KRTCR);
+
+	ret = rtc_register_device(crtc->rtc_dev);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"Failed to register the RTC device, %d\n", ret);
+		goto err_disable_wakeup;
+	}
+
+	return 0;
+
+err_disable_wakeup:
+	device_init_wakeup(&pdev->dev, false);
+
+err_disable_ref_clk:
+	clk_disable_unprepare(crtc->ref_clk);
+
+err_disable_pclk:
+	clk_disable_unprepare(crtc->pclk);
+
+	return ret;
+}
+
+static int cdns_rtc_remove(struct platform_device *pdev)
+{
+	struct cdns_rtc *crtc = platform_get_drvdata(pdev);
+
+	cdns_rtc_alarm_irq_enable(&pdev->dev, 0);
+	device_init_wakeup(&pdev->dev, 0);
+
+	clk_disable_unprepare(crtc->pclk);
+	clk_disable_unprepare(crtc->ref_clk);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int cdns_rtc_suspend(struct device *dev)
+{
+	struct cdns_rtc *crtc = dev_get_drvdata(dev);
+
+	if (device_may_wakeup(dev))
+		enable_irq_wake(crtc->irq);
+
+	return 0;
+}
+
+static int cdns_rtc_resume(struct device *dev)
+{
+	struct cdns_rtc *crtc = dev_get_drvdata(dev);
+
+	if (device_may_wakeup(dev))
+		disable_irq_wake(crtc->irq);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(cdns_rtc_pm_ops, cdns_rtc_suspend, cdns_rtc_resume);
+
+static const struct of_device_id cdns_rtc_of_match[] = {
+	{ .compatible = "cdns,rtc-r109v3" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, cdns_rtc_of_match);
+
+static struct platform_driver cdns_rtc_driver = {
+	.driver = {
+		.name = "cdns-rtc",
+		.of_match_table = cdns_rtc_of_match,
+		.pm = &cdns_rtc_pm_ops,
+	},
+	.probe = cdns_rtc_probe,
+	.remove = cdns_rtc_remove,
+};
+module_platform_driver(cdns_rtc_driver);
+
+MODULE_AUTHOR("Jan Kotas <jank@cadence.com>");
+MODULE_DESCRIPTION("Cadence RTC driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:cdns-rtc");
-- 
2.15.0

