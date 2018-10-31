Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F79ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38AC02080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="sRYpvH0j";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="RAJCDgRs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38AC02080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729824AbeKABdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 21:33:39 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:54878 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729798AbeKABdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 21:33:38 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.23/8.16.0.23) with SMTP id w9VGQKAR001219;
        Wed, 31 Oct 2018 09:34:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=zAcpbyTrpyy4zeRu22hp884Ll06tsutMUhIPGVrG3t8=;
 b=sRYpvH0jaJ3iyQweRLGCJinnl8PaKxKMHtFHNp1HIx+JlzFgrtJUVetLnY1xHuXhMirV
 sMPruVojS+gh5VvSZSfZUp+uaw4hzPPOUiL56BhmZEL9DQqpRAcHdKZvG/tKDui1M2UH
 u4CcZKZxiDFqbNO2yBxjGyomCnplOqjW3lnZ9BTvgCZqv+K4PN9pzVf8yoW5kjkTySVV
 0Vl8DTakROee9ZwoQm5S9WGczvimUmccCtEMxg+tgFSBGRFodGwTTtjXBFZfHNEmuK/7
 zQ01JJCRU2JewJLtnct5XRT9oG0oOJKEKojBp0i8AYUKmW/h4MeR6oHCWyvFru8+yDVP SA== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=adouglas@cadence.com
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp0047.outbound.protection.outlook.com [207.46.163.47])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2nfb6f1294-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 31 Oct 2018 09:34:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAcpbyTrpyy4zeRu22hp884Ll06tsutMUhIPGVrG3t8=;
 b=RAJCDgRsXrysT32NLlmRtLi81YOI5qc4MG+LbvD/RTgjOH8zHsBwaifyVaP7YMuLnihyOgeJtZ69u6IFOYelOiY7GW2P5fomiq/MC1f8uBhAxU1LzRjASgO4jPlJJsE/S0fAvyMuwrq3FUvXZdkMm8XzcPpHGeuhVDR/4KCZ0uw=
Received: from DM5PR07CA0059.namprd07.prod.outlook.com (2603:10b6:4:ad::24) by
 BY1PR0701MB1861.namprd07.prod.outlook.com (2a01:111:e400:51ab::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1273.26; Wed, 31 Oct
 2018 16:34:43 +0000
Received: from CO1NAM05FT055.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::206) by DM5PR07CA0059.outlook.office365.com
 (2603:10b6:4:ad::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1294.21 via Frontend
 Transport; Wed, 31 Oct 2018 16:34:42 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 CO1NAM05FT055.mail.protection.outlook.com (10.152.96.171) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1318.5 via Frontend Transport; Wed, 31 Oct 2018 16:34:41 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id w9VGYZsf011759
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 31 Oct 2018 09:34:40 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 31 Oct 2018 17:34:40 +0100
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Wed, 31 Oct 2018 17:34:40 +0100
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id w9VGYYKP027228;
        Wed, 31 Oct 2018 16:34:34 GMT
Received: (from adouglas@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id w9VGYYkh027212;
        Wed, 31 Oct 2018 16:34:34 GMT
From:   Alan Douglas <adouglas@cadence.com>
To:     <kishon@ti.com>, <linux-kernel@vger.kernel.org>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
CC:     Alan Douglas <adouglas@cadence.com>
Subject: [PATCH v2 2/2] phy: cadence: Add driver for Sierra PHY
Date:   Wed, 31 Oct 2018 16:34:19 +0000
Message-ID: <1541003659-26890-1-git-send-email-adouglas@cadence.com>
X-Mailer: git-send-email 1.9.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(136003)(39860400002)(2980300002)(36092001)(189003)(199004)(105596002)(356004)(486006)(14444005)(6666004)(87636003)(2616005)(478600001)(7636002)(50226002)(107886003)(4744004)(36756003)(305945005)(26005)(426003)(476003)(126002)(106466001)(8936002)(246002)(26826003)(2906002)(16586007)(2201001)(336012)(51416003)(8676002)(50466002)(86362001)(48376002)(316002)(575784001)(186003)(5660300001)(110136005)(47776003)(42186006)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:BY1PR0701MB1861;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT055;1:dFNfI+SL7LDCUEE86dLCUhYVy7uEAH/sW+eKJdtSmq4pLongCXKkmXzZ0PMgSrz037yqHE9Bif8uNAAZS+pIc6iZaIZAkhW17+YTICrIMPYiKysw+sVRbDXVCw2K9t8m
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17e35e22-b0e6-49f2-588b-08d63f4ec275
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:BY1PR0701MB1861;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1861;3:8A5x1i/dULqS7yzjPquAo8kFTO8rS0Cv8PV/HLtxQo2AtLaGJTfKn9KvOwWitxYvZ5R99eNSZTn/RWoo0638IKfew09pXS/cv0RH6fMJNNR7doJA+ObFaqK1qQupL+SYFnSkmMQap0ma+tMtqD62Ud2OjH/reG5VkxvD+glL7C6Fr5KSRFOVqlJC9JXlf8APsKVcdYVSz6/iZEdSvYx2OVqSyEiXgtFMnhCDycr7N0vQa/nU0XODr8SjO/ECfzWH3BiDjUlWRJWyJ2mqP8Jx1cUwXN8R0ybEPqsx+BUrU/Utmb4UM0QoQ34z86MXS4sncVxGXrdgGyH8To2vRfbH2u0BU0xpVsq1FfYM4EwmmOA=;25:RrkwoeE28clOMeeu7eWioCw69Z6wBvT4ynJeLCz3kSPlC+ACv8cTWm69dmYhBW/dgPOeeX3dobe+iAX7TonirwxE3n+33RKJ49KgC0TZe5qTxlULcShipFCNGBM8aQ9knf70wDOJ2sN7qkoJioAzoHnk+f9dCTu7yNzRgcw0I/REVeJW8BW6XcWEwWX6WH7JUq5oPfL8WWvs8D0U+DTVw59CFTLMAGYeBcTZ5R8k/V2WT3FM+KFsp1Prl5OY1SXlZlCM+Y/1GY+HXsdPH+6lmE9vbrbiR9codleU1h7MHWXb8Rly0oSzrj4h/LMLuJepKtFV6QzaKd6weo04y8tJFcLu0FVreK2Gu2yiIqy2lnA=
X-MS-TrafficTypeDiagnostic: BY1PR0701MB1861:
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1861;31:vzlir3VZ2oPllezg8ow08LD86suZzyKlheKhoz87n8y82i01Jhw2QY8aVlZDupxUK+z4PAIDCbaZpK9brcGICch1PhNs39j58/ZElE05hp9p/26xs1/316yFMiyrmUICGUB4MO5o4BrSi5vvfqUts1WMhKSOYnlcqilHk/KqJjxtVBeARSC1JnM38Rb+HPjHNE+07L1FawoTJfkGaqD/KobRCJRUkNEOrtyFW48Z+us=;20:Y+RETpXECYcanlsO0WQpPlBWNysZzelRWSbhXZ6+uvUi/nCJfFSSeLj3xx9eD4aew86iE/9H5/2kuG7tQ7UtRZinlG701MhW2SZWT+hyWGjLikMADvxbDhXCAasZg+dHNam23knhQllwcS3fjcbDX/aOjXhy6kxjglSCZdWxr6XcdUYc0hDDhBhqH/iRiVO4LzDqMvyqqusZ/AuNhTM2UwOkERm2LMmDM4Q24vCwMVXBrsmKHua3OqZse1fYHwjFhUgEXdl0ns9XPrFcJEMQ2tAuQTK7CpDaka7Ct09NkT36j3So16XFWfaAxwBdBkbjuAUH22P0MJFHsZJPh8E82EoJ/9ibRvCa8g0zH2RuA6bJAsmE/2QXx58Shz9l6uH89v3oEnrNoNsnlJkBu2Y43e9qMtiqpBzHjBb02cDwxNu3uySPIDhIq2KDWm01c0WrS6aNeeqgXkdwVtupCEQFxI7Nvs7/Q6vRY8YA/r8Jo+4hcIcScfAV67YWzp90yXgM
X-Microsoft-Antispam-PRVS: <BY1PR0701MB1861005D12C5B39FCD018205D8CD0@BY1PR0701MB1861.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93003095)(3231382)(944501410)(52105095)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BY1PR0701MB1861;BCL:0;PCL:0;RULEID:;SRVR:BY1PR0701MB1861;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1861;4:qh5Jo2LiAog1S8xEFbwvVO07M1MUhCj8VbVbbOMR+CdEtsC9oNlPDREmVcr/qvpf3bUSBaOQ3WOlSyMEohZZbIe+vjJbCMIKTVy9rDB1/T4v9xa29mBVgAHjC+5EUQLWWiHkp3/8OhsD3CIgikLVWCZxtA0V8nzGorAWwS9GgKQwRZ0IFgDEfwh9Gr5wiLaC6rQHfm2+7J/BrqQKms8TBhROneJGMQt+/m8eA6pLtjoOnDigBUZ7TCg4Fr+SjWgvzvSzqQyPjrDixYrQcqZWFBrlMCCNdJglWojAqdbDesTDbcftfA9wuqa04b9Yq2rp
X-Forefront-PRVS: 084285FC5C
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY1PR0701MB1861;23:uf6WA0BCwtF0Z1Hq1RV57aOJ/owkBgEf3rzNF5I?=
 =?us-ascii?Q?utcwgM50flZiPLQ1WS/hPPLowXs3/Ok0jQ+0GTepPPOHyW3Equvt8uZ83PiX?=
 =?us-ascii?Q?e4Ttg15oVQYdxpLicU6OD+YprocIHAfrtguZldJauCVlREgZPW5HiQ/TTbYe?=
 =?us-ascii?Q?0CmpGl2T3LSF+TpPuVqPeNzzoOa3DyRnB2kIIkGx9rN2LCvkLU61xa+PLXDm?=
 =?us-ascii?Q?cdCgc0mKP/AXjZCdl7jY/iUAoF0HR3WN5Yc5/tdBcOU1Su7LhCUgJ7DDb6gu?=
 =?us-ascii?Q?4PW4Z0o62DyXvwBRXT9a1BMLHi3Awg66OOgbYxslKkwOzRy2+ES/J/IwhT0z?=
 =?us-ascii?Q?x02Ee5PEUdrtlCe/KC67jKyIt7ypC7z9KraAG7Ec+CcUshmwVcBXeViFEefU?=
 =?us-ascii?Q?cdJQgjvnPIskIJ35kjtPHNDq9dnqcGsK4obNA5cDblB5xLey6m6zzUY0aYW+?=
 =?us-ascii?Q?Rpo9H7/Ov0Ck42d+fqgUC7JEIsfe0qscmz83O7ZWlC05YUmEVeyi9/jC/IxI?=
 =?us-ascii?Q?GjrAMW26BTCRRJeLWIUzE82EzZHifNukPjmNmly9cyjxYaadQgEtAFTCGCXl?=
 =?us-ascii?Q?yRt/Js5WsYfzpba52AZ81mju/Dzb6ojXBKlL8hSizTnQ0zb2mhw9W7zkcYAX?=
 =?us-ascii?Q?Ao3Zamtbx1NJwh8Z6+JQBm8XA80IEpk6u7E4biR29f3raEiiFwWje1ZBaYQ4?=
 =?us-ascii?Q?H8JNo2nVAd/QzhMxzNas6aHuiFizaHjeeWW95wjWBL3kmBvuhFCrBSZOWzvn?=
 =?us-ascii?Q?yZJ5xxQvBkeUHGYmg+toAxTHHJrc2hNQvOKVWxiCBNJxxBiCA2xJmNarHVgd?=
 =?us-ascii?Q?Wy8iVTfKB1FN0bSgZjOXvVsbPNXuHym6GK6Zn1hXjWfrHkhTLXBqn8f3IyBB?=
 =?us-ascii?Q?Wk8YOQxben5psjgsgi0jH2kwUmFhGoCjoRWVnXzU3GsHJLoZUpGDcMTv7JM2?=
 =?us-ascii?Q?uJpLKxIWoy4/YJr9oy/t9XmQKCML3R68/N8syEciqnLGmS2AIFcS6JyL6e0t?=
 =?us-ascii?Q?RJzVB0UiWr+M8Eu0TYP3VxMHKPPoxpiTuX1ZgkK6jffJJsDHktySQl4aNtQU?=
 =?us-ascii?Q?9e/5jU1/vVLnnka6C7alZR5yANRqh?=
X-Microsoft-Antispam-Message-Info: G0GWLt6G4XC0iwNZtso/Aw+lcPr+lZ26zjMKjQ9Osvbjkr8EVDaVIdXHZRWeXDECV10fg/MdkdnRokvkehtPkMK8NpIJpAUI+6+XKvH5ZdN6vCYdfLCra3YPYqqeb/H6goT3aiEgcTT15dNnt9zBk3yiIPMqtJkoaeMoWCDDbK7qgFBWxujoIeoRbQtiAOFakzQE8bynMiocJ8JiJnBSakTCet0yOXlkimyQMcyGUPvvv42oaTi4HUt/2D4mTvOkoKqW09qZNuYF3AOORomuM6W2JPIj99OX7LmaBAWv6I75Ycdl//V4Za2oSkxP0aXJzgGs37ggzEqeEjXqZ3Hq8lqNjrUgOAdMoq8IRI4p0Hp2uTFo8JLT9qyCE8VkToJo1hHqgY26iepbrv+j/sXSjQ==
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1861;6:pzf3pUHrL7nEjDju+opeetKaUVrYa8YT1YmH5Td/IehZcIuq2ALF6vyq3gtPpC/d2IuoeLj2NwUOsXM728DhI19G3AX3VO05tLgwAfQAFp4a3HErLTvQZKYW1YvWoYqUQGIuWWm5ohXysa6Z3l2wRmeCOHD2O7BOcm+AFfSIvTVRszIHCXscbQ/Ctkn0K3RoGqgCFxZ8EIr+9aBiPNcsJJIt0DHPvnf+nuTNFMh/UqwhWN+ytKhSa+7z5m20dFDQz/v289bQOztmBdxKKeae8zjJk/FipbCSknY0eHrslckFJ5AOevuHMBxg1QLCHNDSSCU58vfWTVwhFGPwCdD83WmZNZyO7NofKG5TP7fpp6Ug4cX2LqHq2Xy2Fhu628C9NYX2MIA0l4ql5AWaxnJr7Y+uchuFYQ6Dl307Wo+zoADje21JrNGr22AEAwy5z2B/ycMWbd3L6U6dATL0yQnmOA==;5:XcqsDvdk7AS+pkdiylZy7tghrYwZStSq7jGRftNsayT3z2Q2E3r/LmEqQP4G5Ebm5zdHPRU5xqSxI6othD43Gt2B1K8dz/bQmsodSqOG453D5o9ClgOF5WrcNspIfquUL7iWpQ+ific6X9GpNwQikvqLyaCFGgnDQllnKZV50R0=;7:Y3SeQ5Yrky5NONrw2wG4itz8FSRCXN+xaKt2QMKngCgeWe1+N+wyMAY//a+nAa7oijMRgcJU203TTygzXaNfe0/DcdZurVET+P/LIc7BUxcM/eJ8AcqvlNfnNikrhYvDr/BQTe875vX2QgapEvbiBg==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1861;20:fLRR4ecFS+kjozFdcK5sWPdQ5A2I+zrZ5b8sD1BIlorjv6uMnmVtOCIDh3oZrJiHUEKfyrtyKkW9ZgaaACZ0v1XaqCe74kJxvnXITxGDXEu5hFtzj00yD9IjJA6Otl8x9JnhAafz157hJp9HKiIyquT9tF6oNHRRK5SL2bxGt8cdHIULTVEdITnKUy/TVrDdBwyfiYrDNUeX9RG8GZTc5INaG6IAQGpao5y43biDvvlCmB3ynRWQsvzNM9bvtsLh
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2018 16:34:41.9160
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e35e22-b0e6-49f2-588b-08d63f4ec275
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR0701MB1861
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-31_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810310137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a Sierra PHY driver with PCIe and USB support.

The PHY has multiple lanes, which can be configured into
groups, and a generic PHY device is created for each group.

There are two resets controlling the overall PHY block, one
to enable the APB interface for programming registers, and
another to enable the PHY itself.  Additionally there are
resets for each PHY lane.

The PHY can be configured in hardware to read register
settings from ROM, or they can be written by the driver.

The sequence of operation on startup is to enable the APB
bus, write the PHY registers (if required)  for each lane
group, and then enable the PHY.  Each group of lanes
can then be individually controlled using the power_on()/
power_off() function for that generic PHY

Signed-off-by: Alan Douglas <adouglas@cadence.com>
---
 drivers/phy/Kconfig                   |   1 +
 drivers/phy/Makefile                  |   1 +
 drivers/phy/cadence/Kconfig           |   9 +
 drivers/phy/cadence/Makefile          |   2 +
 drivers/phy/cadence/phy-cdns-sierra.c | 395 ++++++++++++++++++++++++++++++++++
 5 files changed, 408 insertions(+)
 create mode 100644 drivers/phy/cadence/Kconfig
 create mode 100644 drivers/phy/cadence/Makefile
 create mode 100644 drivers/phy/cadence/phy-cdns-sierra.c

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 5c8d452..cc47f85 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -43,6 +43,7 @@ config PHY_XGENE
 source "drivers/phy/allwinner/Kconfig"
 source "drivers/phy/amlogic/Kconfig"
 source "drivers/phy/broadcom/Kconfig"
+source "drivers/phy/cadence/Kconfig"
 source "drivers/phy/hisilicon/Kconfig"
 source "drivers/phy/lantiq/Kconfig"
 source "drivers/phy/marvell/Kconfig"
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index 84e3bd9..ba48acd 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_ARCH_RENESAS)		+= renesas/
 obj-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip/
 obj-$(CONFIG_ARCH_TEGRA)		+= tegra/
 obj-y					+= broadcom/	\
+					   cadence/	\
 					   hisilicon/	\
 					   marvell/	\
 					   motorola/	\
diff --git a/drivers/phy/cadence/Kconfig b/drivers/phy/cadence/Kconfig
new file mode 100644
index 0000000..098df0f
--- /dev/null
+++ b/drivers/phy/cadence/Kconfig
@@ -0,0 +1,9 @@
+#
+# Phy drivers for Cadence PHYs
+#
+config CDNS_SIERRA_PHY
+	tristate "Cadence Sierra PHY Driver"
+	depends on OF && HAS_IOMEM && RESET_CONTROLLER
+	select GENERIC_PHY
+	help
+	  Enable this to support the Cadence Sierra PHY driver
diff --git a/drivers/phy/cadence/Makefile b/drivers/phy/cadence/Makefile
new file mode 100644
index 0000000..0ef6752
--- /dev/null
+++ b/drivers/phy/cadence/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_CDNS_SIERRA_PHY)		+= phy-cdns-sierra.o
diff --git a/drivers/phy/cadence/phy-cdns-sierra.c b/drivers/phy/cadence/phy-cdns-sierra.c
new file mode 100644
index 0000000..de10402
--- /dev/null
+++ b/drivers/phy/cadence/phy-cdns-sierra.c
@@ -0,0 +1,395 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Cadence Sierra PHY Driver
+ *
+ * Copyright (c) 2018 Cadence Design Systems
+ * Author: Alan Douglas <adouglas@cadence.com>
+ *
+ */
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <dt-bindings/phy/phy.h>
+
+/* PHY register offsets */
+#define SIERRA_PHY_PLL_CFG		(0xc00e << 2)
+#define SIERRA_DET_STANDEC_A		(0x4000 << 2)
+#define SIERRA_DET_STANDEC_B		(0x4001 << 2)
+#define SIERRA_DET_STANDEC_C		(0x4002 << 2)
+#define SIERRA_DET_STANDEC_D		(0x4003 << 2)
+#define SIERRA_DET_STANDEC_E		(0x4004 << 2)
+#define SIERRA_PSM_LANECAL		(0x4008 << 2)
+#define SIERRA_PSM_DIAG			(0x4015 << 2)
+#define SIERRA_PSC_TX_A0		(0x4028 << 2)
+#define SIERRA_PSC_TX_A1		(0x4029 << 2)
+#define SIERRA_PSC_TX_A2		(0x402A << 2)
+#define SIERRA_PSC_TX_A3		(0x402B << 2)
+#define SIERRA_PSC_RX_A0		(0x4030 << 2)
+#define SIERRA_PSC_RX_A1		(0x4031 << 2)
+#define SIERRA_PSC_RX_A2		(0x4032 << 2)
+#define SIERRA_PSC_RX_A3		(0x4033 << 2)
+#define SIERRA_PLLCTRL_SUBRATE		(0x403A << 2)
+#define SIERRA_PLLCTRL_GEN_D		(0x403E << 2)
+#define SIERRA_DRVCTRL_ATTEN		(0x406A << 2)
+#define SIERRA_CLKPATHCTRL_TMR		(0x4081 << 2)
+#define SIERRA_RX_CREQ_FLTR_A_MODE1	(0x4087 << 2)
+#define SIERRA_RX_CREQ_FLTR_A_MODE0	(0x4088 << 2)
+#define SIERRA_CREQ_CCLKDET_MODE01	(0x408E << 2)
+#define SIERRA_RX_CTLE_MAINTENANCE	(0x4091 << 2)
+#define SIERRA_CREQ_FSMCLK_SEL		(0x4092 << 2)
+#define SIERRA_CTLELUT_CTRL		(0x4098 << 2)
+#define SIERRA_DFE_ECMP_RATESEL		(0x40C0 << 2)
+#define SIERRA_DFE_SMP_RATESEL		(0x40C1 << 2)
+#define SIERRA_DEQ_VGATUNE_CTRL		(0x40E1 << 2)
+#define SIERRA_TMRVAL_MODE3		(0x416E << 2)
+#define SIERRA_TMRVAL_MODE2		(0x416F << 2)
+#define SIERRA_TMRVAL_MODE1		(0x4170 << 2)
+#define SIERRA_TMRVAL_MODE0		(0x4171 << 2)
+#define SIERRA_PICNT_MODE1		(0x4174 << 2)
+#define SIERRA_CPI_OUTBUF_RATESEL	(0x417C << 2)
+#define SIERRA_LFPSFILT_NS		(0x418A << 2)
+#define SIERRA_LFPSFILT_RD		(0x418B << 2)
+#define SIERRA_LFPSFILT_MP		(0x418C << 2)
+#define SIERRA_SDFILT_H2L_A		(0x4191 << 2)
+
+#define SIERRA_MACRO_ID			0x00007364
+#define SIERRA_MAX_LANES		4
+
+struct cdns_sierra_inst {
+	struct phy *phy;
+	u32 phy_type;
+	u32 num_lanes;
+	u32 mlane;
+	struct reset_control *lnk_rst;
+};
+
+struct cdns_reg_pairs {
+	u16 val;
+	u32 off;
+};
+
+struct cdns_sierra_data {
+		u32 id_value;
+		u32 pcie_regs;
+		u32 usb_regs;
+		struct cdns_reg_pairs *pcie_vals;
+		struct cdns_reg_pairs  *usb_vals;
+};
+
+struct cdns_sierra_phy {
+	struct device *dev;
+	void __iomem *base;
+	struct cdns_sierra_data *init_data;
+	struct cdns_sierra_inst phys[SIERRA_MAX_LANES];
+	struct reset_control *phy_rst;
+	struct reset_control *apb_rst;
+	struct clk *clk;
+	int nsubnodes;
+	bool autoconf;
+};
+
+static void cdns_sierra_phy_init(struct phy *gphy)
+{
+	struct cdns_sierra_inst *ins = phy_get_drvdata(gphy);
+	struct cdns_sierra_phy *phy = dev_get_drvdata(gphy->dev.parent);
+	int i, j;
+	struct cdns_reg_pairs *vals;
+	u32 num_regs;
+
+	if (ins->phy_type == PHY_TYPE_PCIE) {
+		num_regs = phy->init_data->pcie_regs;
+		vals = phy->init_data->pcie_vals;
+	} else if (ins->phy_type == PHY_TYPE_USB3) {
+		num_regs = phy->init_data->usb_regs;
+		vals = phy->init_data->usb_vals;
+	} else {
+		return;
+	}
+	for (i = 0; i < ins->num_lanes; i++)
+		for (j = 0; j < num_regs ; j++)
+			writel(vals[j].val, phy->base +
+				vals[j].off + (i + ins->mlane) * 0x800);
+}
+
+static int cdns_sierra_phy_on(struct phy *gphy)
+{
+	struct cdns_sierra_inst *ins = phy_get_drvdata(gphy);
+
+	/* Take the PHY lane group out of reset */
+	return reset_control_deassert(ins->lnk_rst);
+}
+
+static int cdns_sierra_phy_off(struct phy *gphy)
+{
+	struct cdns_sierra_inst *ins = phy_get_drvdata(gphy);
+
+	return reset_control_assert(ins->lnk_rst);
+}
+
+static const struct phy_ops ops = {
+	.power_on	= cdns_sierra_phy_on,
+	.power_off	= cdns_sierra_phy_off,
+	.owner		= THIS_MODULE,
+};
+
+static int cdns_sierra_get_optional(struct cdns_sierra_inst *inst,
+				    struct device_node *child)
+{
+	if (of_property_read_u32(child, "reg", &inst->mlane))
+		return -EINVAL;
+
+	if (of_property_read_u32(child, "cdns,num-lanes", &inst->num_lanes))
+		return -EINVAL;
+
+	if (of_property_read_u32(child, "cdns,phy-type", &inst->phy_type))
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct of_device_id cdns_sierra_id_table[];
+
+static int cdns_sierra_phy_probe(struct platform_device *pdev)
+{
+	struct cdns_sierra_phy *sp;
+	struct phy_provider *phy_provider;
+	struct device *dev = &pdev->dev;
+	const struct of_device_id *match;
+	struct resource *res;
+	int i, ret, node = 0;
+	struct device_node *dn = dev->of_node, *child;
+
+	if (of_get_child_count(dn) == 0)
+		return -ENODEV;
+
+	sp = devm_kzalloc(dev, sizeof(*sp), GFP_KERNEL);
+	if (!sp)
+		return -ENOMEM;
+	dev_set_drvdata(dev, sp);
+	sp->dev = dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	sp->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(sp->base)) {
+		dev_err(dev, "missing \"reg\"\n");
+		return PTR_ERR(sp->base);
+	}
+
+	/* Get init data for this PHY */
+	match = of_match_device(cdns_sierra_id_table, dev);
+	if (!match)
+		return -EINVAL;
+	sp->init_data = (struct cdns_sierra_data *)match->data;
+
+	platform_set_drvdata(pdev, sp);
+
+	sp->clk = devm_clk_get(dev, "phy_clk");
+	if (IS_ERR(sp->clk)) {
+		dev_err(dev, "failed to get clock phy_clk\n");
+		return PTR_ERR(sp->clk);
+	}
+
+	sp->phy_rst = devm_reset_control_get(dev, "sierra_reset");
+	if (IS_ERR(sp->phy_rst)) {
+		dev_err(dev, "failed to get reset\n");
+		return PTR_ERR(sp->phy_rst);
+	}
+
+	sp->apb_rst = devm_reset_control_get(dev, "sierra_apb");
+	if (IS_ERR(sp->apb_rst)) {
+		dev_err(dev, "failed to get apb reset\n");
+		return PTR_ERR(sp->apb_rst);
+	}
+
+	ret = clk_prepare_enable(sp->clk);
+	if (ret)
+		return ret;
+
+	/* Enable APB */
+	reset_control_deassert(sp->apb_rst);
+
+	/* Check that PHY is present */
+	if  (sp->init_data->id_value != readl(sp->base)) {
+		ret = -EINVAL;
+		goto clk_disable;
+	}
+
+	sp->autoconf = of_property_read_bool(dn, "cdns,autoconf");
+
+	for_each_available_child_of_node(dn, child) {
+		struct phy *gphy;
+
+		sp->phys[node].lnk_rst =
+			of_reset_control_get_exclusive_by_index(child, 0);
+
+		if (IS_ERR(sp->phys[node].lnk_rst)) {
+			dev_err(dev, "failed to get reset %s\n",
+				child->full_name);
+			ret = PTR_ERR(sp->phys[node].lnk_rst);
+			goto put_child2;
+		}
+
+		if (!sp->autoconf) {
+			ret = cdns_sierra_get_optional(&sp->phys[node], child);
+			if (ret) {
+				dev_err(dev, "missing property in node %s\n",
+					child->name);
+				goto put_child;
+			}
+		}
+
+		gphy = devm_phy_create(dev, child, &ops);
+
+		if (IS_ERR(gphy)) {
+			ret = PTR_ERR(gphy);
+			goto put_child;
+		}
+		sp->phys[node].phy = gphy;
+		phy_set_drvdata(gphy, &sp->phys[node]);
+
+		/* Initialise the PHY registers, unless auto configured */
+		if (!sp->autoconf)
+			cdns_sierra_phy_init(gphy);
+
+		node++;
+	}
+	sp->nsubnodes = node;
+
+	/* If more than one subnode, configure the PHY as multilink */
+	if (!sp->autoconf && sp->nsubnodes > 1)
+		writel(2, sp->base + SIERRA_PHY_PLL_CFG);
+
+	pm_runtime_enable(dev);
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+	reset_control_deassert(sp->phy_rst);
+	return PTR_ERR_OR_ZERO(phy_provider);
+
+put_child:
+	node++;
+put_child2:
+	for (i = 0; i < node; i++)
+		reset_control_put(sp->phys[i].lnk_rst);
+	of_node_put(child);
+clk_disable:
+	clk_disable_unprepare(sp->clk);
+	reset_control_assert(sp->apb_rst);
+	return ret;
+}
+
+static int cdns_sierra_phy_remove(struct platform_device *pdev)
+{
+	struct cdns_sierra_phy *phy = dev_get_drvdata(pdev->dev.parent);
+	int i;
+
+	reset_control_assert(phy->phy_rst);
+	reset_control_assert(phy->apb_rst);
+	pm_runtime_disable(&pdev->dev);
+
+	/*
+	 * The device level resets will be put automatically.
+	 * Need to put the subnode resets here though.
+	 */
+	for (i = 0; i < phy->nsubnodes; i++) {
+		reset_control_assert(phy->phys[i].lnk_rst);
+		reset_control_put(phy->phys[i].lnk_rst);
+	}
+	return 0;
+}
+
+static struct cdns_reg_pairs cdns_usb_regs[] = {
+	/*
+	 * Write USB configuration parameters to the PHY.
+	 * These values are specific to this specific hardware
+	 * configuration.
+	 */
+	{0xFE0A, SIERRA_DET_STANDEC_A},
+	{0x000F, SIERRA_DET_STANDEC_B},
+	{0x55A5, SIERRA_DET_STANDEC_C},
+	{0x69AD, SIERRA_DET_STANDEC_D},
+	{0x0241, SIERRA_DET_STANDEC_E},
+	{0x0110, SIERRA_PSM_LANECAL},
+	{0xCF00, SIERRA_PSM_DIAG},
+	{0x001F, SIERRA_PSC_TX_A0},
+	{0x0007, SIERRA_PSC_TX_A1},
+	{0x0003, SIERRA_PSC_TX_A2},
+	{0x0003, SIERRA_PSC_TX_A3},
+	{0x0FFF, SIERRA_PSC_RX_A0},
+	{0x0003, SIERRA_PSC_RX_A1},
+	{0x0003, SIERRA_PSC_RX_A2},
+	{0x0001, SIERRA_PSC_RX_A3},
+	{0x0001, SIERRA_PLLCTRL_SUBRATE},
+	{0x0406, SIERRA_PLLCTRL_GEN_D},
+	{0x0000, SIERRA_DRVCTRL_ATTEN},
+	{0x823E, SIERRA_CLKPATHCTRL_TMR},
+	{0x078F, SIERRA_RX_CREQ_FLTR_A_MODE1},
+	{0x078F, SIERRA_RX_CREQ_FLTR_A_MODE0},
+	{0x7B3C, SIERRA_CREQ_CCLKDET_MODE01},
+	{0x023C, SIERRA_RX_CTLE_MAINTENANCE},
+	{0x3232, SIERRA_CREQ_FSMCLK_SEL},
+	{0x8452, SIERRA_CTLELUT_CTRL},
+	{0x4121, SIERRA_DFE_ECMP_RATESEL},
+	{0x4121, SIERRA_DFE_SMP_RATESEL},
+	{0x9999, SIERRA_DEQ_VGATUNE_CTRL},
+	{0x0330, SIERRA_TMRVAL_MODE0},
+	{0x01FF, SIERRA_PICNT_MODE1},
+	{0x0009, SIERRA_CPI_OUTBUF_RATESEL},
+	{0x000F, SIERRA_LFPSFILT_NS},
+	{0x0009, SIERRA_LFPSFILT_RD},
+	{0x0001, SIERRA_LFPSFILT_MP},
+	{0x8013, SIERRA_SDFILT_H2L_A},
+	{0x0400, SIERRA_TMRVAL_MODE1},
+};
+
+static struct cdns_reg_pairs cdns_pcie_regs[] = {
+	/*
+	 * Write PCIe configuration parameters to the PHY.
+	 * These values are specific to this specific hardware
+	 * configuration.
+	 */
+	{0x891f, SIERRA_DET_STANDEC_D},
+	{0x0053, SIERRA_DET_STANDEC_E},
+	{0x0400, SIERRA_TMRVAL_MODE2},
+	{0x0200, SIERRA_TMRVAL_MODE3},
+};
+
+static const struct cdns_sierra_data cdns_map_sierra = {
+	SIERRA_MACRO_ID,
+	ARRAY_SIZE(cdns_pcie_regs),
+	ARRAY_SIZE(cdns_usb_regs),
+	cdns_pcie_regs,
+	cdns_usb_regs
+};
+
+static const struct of_device_id cdns_sierra_id_table[] = {
+	{
+		.compatible = "cdns,sierra-phy-t0",
+		.data = &cdns_map_sierra,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, cdns_sierra_id_table);
+
+static struct platform_driver cdns_sierra_driver = {
+	.probe		= cdns_sierra_phy_probe,
+	.remove		= cdns_sierra_phy_remove,
+	.driver		= {
+		.name	= "cdns-sierra-phy",
+		.of_match_table = cdns_sierra_id_table,
+	},
+};
+module_platform_driver(cdns_sierra_driver);
+
+MODULE_ALIAS("platform:cdns_sierra");
+MODULE_AUTHOR("Cadence Design Systems");
+MODULE_DESCRIPTION("CDNS sierra phy driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.0

