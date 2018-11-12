Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B243CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EC462241E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="ahh0MWMl";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="LjEYNpIs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EC462241E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730162AbeKMCgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 21:36:20 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:53196 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727976AbeKMCgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 21:36:19 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wACGcOvr009962;
        Mon, 12 Nov 2018 08:42:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=scTxhGAJ//e7gUkoBWM8p/s0Lg1US/mBn4du4yZf9l0=;
 b=ahh0MWMlOs5a8HDUgu7127/hS9yNYJ0guDaMs8NeFJ7jfdOmgQbz7ExgA9RgncHD5vcG
 Au5nlLHTvt1RUItSaVIXrnzYs70bnAAyh00atQAKO/dR7wdbzLdR1jt2TyQEadEF4u4a
 QGml8mRfja5cuEtPnboA7isqdqCvzGkUFfjxG0oQhz8KCTXx9nDSeSrKZLHXAliMIrHB
 GiIXatZx4QCNpp+iMJFggcsmIUZGnrACefGB7naZRq+qg9oKdgYmdijdMjen0WpKefsr
 gY4sFd60b9t8iYNfu2sIUmcbu7Bw6aN6RmPIslhHcPoeTAvDKyv+rvfkWJjxdNrQV+2E Qg== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=adouglas@cadence.com
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp0119.outbound.protection.outlook.com [216.32.181.119])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2nnut7kc21-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Nov 2018 08:42:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scTxhGAJ//e7gUkoBWM8p/s0Lg1US/mBn4du4yZf9l0=;
 b=LjEYNpIsY0nlWZiyBM77m4vVPfKHDf2jvqZd23b8H8Q9K3nKGsWFV9T36ZHcH7JkxE6j5OkRCCkeUuBNLEjieoiw2BwX6nRJB3TDfnTEfg9yyarg6vMo8aIxH7PLnEd+PtsfVgf5w8mxdRKDiuVgrfaJcWby4rtLPHrksUZrp6A=
Received: from BYAPR07CA0063.namprd07.prod.outlook.com (2603:10b6:a03:60::40)
 by BL0PR07MB4098.namprd07.prod.outlook.com (2603:10b6:207:4c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.26; Mon, 12 Nov
 2018 16:42:10 +0000
Received: from DM3NAM05FT040.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::206) by BYAPR07CA0063.outlook.office365.com
 (2603:10b6:a03:60::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.21 via Frontend
 Transport; Mon, 12 Nov 2018 16:42:10 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 199.43.4.28 as permitted sender)
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 DM3NAM05FT040.mail.protection.outlook.com (10.152.98.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.3 via Frontend Transport; Mon, 12 Nov 2018 16:42:09 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id wACGg5us008872
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Mon, 12 Nov 2018 11:42:07 -0500
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 12 Nov 2018 17:42:09 +0100
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Mon, 12 Nov 2018 17:42:09 +0100
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id wACGg5ZQ010600;
        Mon, 12 Nov 2018 16:42:05 GMT
Received: (from adouglas@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id wACGg4oJ010594;
        Mon, 12 Nov 2018 16:42:04 GMT
From:   Alan Douglas <adouglas@cadence.com>
To:     <kishon@ti.com>, <linux-kernel@vger.kernel.org>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
CC:     Alan Douglas <adouglas@cadence.com>
Subject: [PATCH v3 1/2] dt-bindings: phy: Document cadence Sierra PHY bindings
Date:   Mon, 12 Nov 2018 16:42:01 +0000
Message-ID: <1542040921-10187-1-git-send-email-adouglas@cadence.com>
X-Mailer: git-send-email 1.9.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(376002)(396003)(39860400002)(136003)(346002)(2980300002)(36092001)(199004)(189003)(86362001)(105596002)(186003)(53936002)(50226002)(2201001)(87636003)(478600001)(336012)(126002)(26826003)(486006)(107886003)(48376002)(51416003)(2616005)(426003)(50466002)(106466001)(110136005)(42186006)(8676002)(8936002)(476003)(81166006)(16586007)(26005)(316002)(81156014)(97736004)(356004)(6666004)(4326008)(305945005)(47776003)(5660300001)(14444005)(69596002)(68736007)(36756003)(2906002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR07MB4098;H:rmmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT040;1:5i2MYe7CeQ8BETUk/xkLrNZ+HOtwS3p61jNZdX0hYtYwG6MSCp4LNTmYTQsWOBgTXOOh9iVdlqQHSHJ9Wl2ZX5IItnMbZvNjKakOWywleRnHXOJAjlyFCDgP26QF8tDQ
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47f24a50-a547-482c-e76e-08d648bdca5f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390040)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:BL0PR07MB4098;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR07MB4098;3:D5qYvry8H9v8WxT6oDEWHLssKbvOnmyMYMP6pp/QjvMHDmHJomW+Zm3LuqiDr590ZxIr6mFVxj1MtWHM5vopbVy668hyN9iji7YbzbBlF5mUX6y33J7aggjHcfZ1wiwIvtEgdBnXmIlNgnRHQuatta2kSF1L2TCre0j4CpDcRfROvd+VmF3xP2gwSC81RwMNZRbudoJZjAvK3qhtYOPRCpYWODn6v8Mi9EFDGvY5Evc0W99XUS8ubYF+ZOiBv1bHvoz9ZPqS+npmVNBqVVai9FBt0eiW1UNsdT3ZWFffYqBE7WJlyvUYHdtfZsvKjMn9w7g7xyrg6jkbqVEeL9FG4g==;25:WE30njeSXCZ014s/Q6ZS0XgRsU91Dg7tOfu1/53UgcljzoXjX0ESWe+S7jA2hknUtaEbtKyCooDo/Q/d5M/qn0LGTUAI3Qg1eYBwfBAaO5S4jLgdyYqmXgbKiJiIwlNnuAFvDeSgzpoOn4Gknw83Qjr3Do8HtXSw6BJDwVbyeqiCo9xH+VnJdbVdGb8icZq3QcQJxdgfrwZCUgN0aQe3/h7/JuHxqsX5CKA7dDEAprmk4RQm3shAmV/e88hnVjM+bi7ZBxZ5cUuJmgc7i0nkQOyEXro/0hCFM2+nQVhmfhWxwgjGnss+2YqOeObZq7TmU0crGcp89rSVuYIUpPhLvw==;31:HShVw+0F/2rqI2lIK9ZP8wOP1jhC45uvHvsygLu8P/hsk/BDmelg5LHmCxKM0g/SCqdJ3SrZVm1eR4st7hFf+Xfh6h9mbxzjDQdaLBRwyJvc/eW6y15ViNaZsA0+q7qkURAdloGPJ4wkf0Q98KF2q2l+a8+bdC8UpM32IuDDAB3QxAlt6POfWIYAAP+VkMRvbL9yZbvbAlDfh+hVaSlBnbJ8GjaP+kpim3JZTra4tPg=
X-MS-TrafficTypeDiagnostic: BL0PR07MB4098:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR07MB4098;20:Gq+8jU8+joETX9OGbvayCj0uGBk86sqpXVEaImTue0h+udgFps3vLhuBbe8yPaaCjSl+acyoyfbWX1wLFVFzBrPMgScKTLZgvNrsPa+vDUemy6yjw3ugZwB4ew3sZy+oXYXC/jvDw0BYacOS8Yg/dTNB2I9vlfOPJJL6clkqZZ5GW9pGzniJNxtson6YhOXRKMVQSe7tLdfMaEkQgTQ4vOS29kdvYklZO2pLFLmv2O2mh/KN6O1oEGwuwH52SNVTHcfz3qmzsbSJSGgSyN+wo5zbXQbKGDRvDhFckZ+wncFgCKDPTYWhN6d28N1W+YURPWTjhrk8wmqZ5cEwhj4nnuMW2+FEy/QG2I3w75KlXJJFHsr28l4R3/D0TWQFtJDEGJCAUx6GOCiQoLbEgYR5HjREfZDQ53LPy1mtHiANZmpHL7GDqw7+9+Q71tMT+4rjT6LFNw6qh9x8iqu6bd2wYrSizrVd8SW/H58/8oXh+oWPWXwaOGaNSDdXu8AFNvBE;4:Cc5rVsl3y+0ijLasWrruiiDUiPGgLgNJNJ6fYJ+XY7lovXg5DTsmSNGlX75qypZtLBaNgaRNDSMK72HbYzwRtYTeKc4VI5FKXns32lz7XTy78dE+v7X1TjvKyLnMmqrrglb257yCSRnB2Lk+d1EyLgr0jV9oB9pI0BR+JSFYGvKJyxtJq75Aew/9/hyol3FPhOc4S7lPeyClRMqqUAMyakRFS0AnTqMsNU54JV0YKZe0iI12ggOIK+0oSFh/Xt0yha7HKVQibOUcuTg8Gzeikyn/aYLe+JwtinyPhIdTPDgG37S7E7lfRowYpMEETWvc
X-Microsoft-Antispam-PRVS: <BL0PR07MB4098D98E871C69BCBE9BA76DD8C10@BL0PR07MB4098.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231382)(944501410)(52105112)(93006095)(93003095)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BL0PR07MB4098;BCL:0;PCL:0;RULEID:;SRVR:BL0PR07MB4098;
X-Forefront-PRVS: 0854128AF0
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR07MB4098;23:WFykm3SM94UGQ7ljNOH4BQPeCo1UAW6G3W+Vd1JY1?=
 =?us-ascii?Q?yJgBKaDOL/a6senjrskdCRGEDmJSBWsm08b0FgEhd5LV/5uQSpl/Z5DNvH1c?=
 =?us-ascii?Q?oywi7i/UAyiiorfS1mPr/VwN3pt5wuhTu4WbV1KkN11TgiqnvkUTcNyA3l2E?=
 =?us-ascii?Q?0iRMPNNt2dgVT0ILpyLBDal5Fhj4Qrz+qVWl0GNEddXlrd2QsGXQ0fS4FaNU?=
 =?us-ascii?Q?h5ZRchxbDI8v9Y41T46cmb8oCRBPrNK7hNje/zRaKgqmqunmC8ip1+awCq9+?=
 =?us-ascii?Q?0XOIHlJBuLoMpEwnMG54uEpuaoNcHBi8iHMm82f57iKQtABaBsy+JLsNPIID?=
 =?us-ascii?Q?kZcPLyOHi3NrnwH3JZkZrXtuqVxgFlBnFUEqF0D6BZxQSeZR4VWs17lp64/K?=
 =?us-ascii?Q?YtTOf03bxs1p1rmQGmM7H8MatZE1KmtMH2l5hzr5YLDSCizFrGwUiKCucAGv?=
 =?us-ascii?Q?bUPRwYIGZcHPCePy4q4VnIjcbhtpt0WITgBi4J77Qtda1kYicuvR2SKCXckD?=
 =?us-ascii?Q?nYwIJ76fpbRfCEBVbtArqg2F9vRoZ8ACwRzYFZ/bAdO7HN/yx16kWYYkm909?=
 =?us-ascii?Q?AJQKPiWYF8Ccqd6VvKLhs/XEaJ5CBtfi2UfW87FZnQt4QGxKiNWXgxDg1KTe?=
 =?us-ascii?Q?29pPz0WSrraZHtLD6dk5CaWkWPK0ctUMxK5XRtcNfxRpWTdI3XurgV0MIRNO?=
 =?us-ascii?Q?CkEHDPuia+KfbrTtlLVZs5P1UeKuySQnxUT0ytGljecg8wyBJtNFu30TL+Xl?=
 =?us-ascii?Q?kdfSSl1shx4FqHUjjI8R8xsl1YbPF9kPF/Umk7gL+DJJxLWK4Oq0qNFwIp1c?=
 =?us-ascii?Q?4IFnqxUTlK9GZpIbU2TVt8b3OlAl+TyL6PpR8T6qRecFcMNW9h5uKM7pqnXk?=
 =?us-ascii?Q?4dqJGp3PgIaooJw/88ZI45qNUtRX1HPIwpucrLU7m8GcD8QG2MrkkBYJSH0H?=
 =?us-ascii?Q?C+KhYO9prh8hJjKK9xCaX8czp5yeDpk4TPrbC/cAPtQdywOxUbu1OGSYqr1F?=
 =?us-ascii?Q?NrSPl1ce0PDT54bdpAj4Vd/zSzRomI4vc+FxbAFRGdzpPQ6naCNJDdD/u58V?=
 =?us-ascii?Q?SmYRI9/3Mt9p2ZdABT38XEuM4tVmh2dmR+3hZa5lFyJUGKU/rDMEJ+unV/yI?=
 =?us-ascii?Q?Bvvd9p5TT/n7a+Ag3EvZXJAJWe5yqN4A1O9Bg0+PxLVpvmQLFCP+ljw3kvnr?=
 =?us-ascii?Q?miOcTc+IqjQ8urH4ExddFZ0rIZU9PSzJt+UeljR8eP607HNz7nk4wF6qw=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: p2DKtJkVZf5msVWMN8zhwl6r5x9F8GGoMN3Jd6MXEQ9CXSfJU/TDxV+FA2l7uf9y4xzCOumJvO+J+QnQuGQAisKxJscf/lGb+fbdEnvWqdyQbtiYaDQha6BEq3t5oht+tFru+SO6dnviS7K5CvV8qjrS4U++JwuS4l5YBOqU/TsvbCLadAlSvqhzuL94Y+fzYP+EZsaGSECAbIluM2Ac/AqoFRMs/9fARpV+mtKM8xCFipdeM8Cg3HCG4x5fBrQBGm6NvLQnqrDwlJnpjyzCAOI6hOGXrtWIqZGKHW8FN7lIsViuQStM7RsqygBfPGvwhiHoMtJMkLKVkvczrh8SHB0uXJZuDspMAGWt3A1ux9g=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR07MB4098;6:gixckMz0NYdhmWeenlbvamDMpbqn7P4yGxgSwl4p1crzFS45ZSF9wD55o3xgbfZWWf6VICshwRShvtL2H4Cb/+/pilWefk+jIWObqTtJB3s1VS9etR57M5P5pUUG2JxXmWoDrSmdL1x0QICYHdaXnAyAG39M/JwUxi4AfFT4YtND8xr4Y0qg4ByioYfRJpM7Yv/ggHBHPl5Uqcx5C8UW8cbgga/mevjtdHe+kuRgqlM2Mg8RFK6ejY/OZG2MUqRgTsupIOMz+kKKcumrh54HCrhoEio+b73tXLgu9ribS9BT9klOEi93tHzHfaP67bMQYoQg7lUR3rHfOFjFSKvvCiVSQULe/w5wkGAhSE8lnNS+IozYXaFtwef5zQCLGtuzSvmNGQMFmW1fAVBBQBClz2en7bF2vf8MVo86aRR74DAODqGhiHWe/NJ5nE4wpqdAq3HHFEn+2SCxpZoN7dNGzQ==;5:Ny4iPSuYDNFRNChEvQYvLbp0XWMCSCX+FXCV7ayIWJ6QZq93dOYBcI5ruJafDQ1zKomI+z+UKzQTiBc3B2seTQS78JJI6gj6Jf0TEdXeXh/QgYBbem+1qnNQH1szHWx+bZXRXroLDfUjPT35ZpHIgr5YrsK/esWfhGGfM1stNcU=;7:UJSEsRcm9xra91iKTAxyAYjOunKAyCZT4LZbvmJ/fZ8fh7vRr8tMdRnCjcvB1CukayQhD1IwZKyAvDWomCHZHqw7E8gEmkBwUFNw2w7qygo4DAl2O6C15R82Tvwi3XphtwTlR2SKhXK87tEL+F/wpQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL0PR07MB4098;20:gJPhwwlPLiYug4IoUCB0yltOEcnXI4kzIVgduFF2Q4us82SjbkBgAaO1gg3MteiSVUyRXjnML0aBYBj5YAr4Mpqy+7BNJNztJqw1/fkzpmgWjG1ilVlPYyQFkNluyIS5zuwtBmNcuBXu1mL4b08lC2TW7Qu3AQ8GB+sIm6Qp49st6F24+BfZX0UfD6z4JN8os85JqBBnIhTxuzgIyc35QnJPlN913EpOeLpznc65PCU9RyaXFc1B65E2xzWVWOd5
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2018 16:42:09.7367
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47f24a50-a547-482c-e76e-08d648bdca5f
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR07MB4098
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-12_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811120146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT binding documentation for Sierra PHY.  The PHY supports
a number of different protocols, including PCIe and USB.

The PHY lanes may be configured as single or multi-lane links.
Each link is treated as a separate sub-node.  For example, if
there are 4 lanes in total the first 2 might be configured as
a multi-lane PCIe link while the other two are single lane
USB links, and in this case there would be 3 sub-nodes.

There are two resets for the PHY block (one for APB register
access, one for the PHY link) and separate resets for each
link.  For multi-lane links, the reset corresponds to the
reset line on the master lane, the resets on other lanes
have no effect.

Signed-off-by: Alan Douglas <adouglas@cadence.com>
---
 .../devicetree/bindings/phy/phy-cadence-sierra.txt | 67 ++++++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-cadence-sierra.txt

diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-sierra.txt b/Documentation/devicetree/bindings/phy/phy-cadence-sierra.txt
new file mode 100644
index 0000000..6e1b47b
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-cadence-sierra.txt
@@ -0,0 +1,67 @@
+Cadence Sierra PHY
+-----------------------
+
+Required properties:
+- compatible:	cdns,sierra-phy-t0
+- clocks:	Must contain an entry in clock-names.
+		See ../clocks/clock-bindings.txt for details.
+- clock-names:	Must be "phy_clk"
+- resets:	Must contain an entry for each in reset-names.
+		See ../reset/reset.txt for details.
+- reset-names:	Must include "sierra_reset" and "sierra_apb".
+		"sierra_reset" must control the reset line to the PHY.
+		"sierra_apb" must control the reset line to the APB PHY
+		interface.
+- reg:		register range for the PHY.
+- #address-cells: Must be 1
+- #size-cells:	Must be 0
+
+Optional properties:
+- cdns,autoconf:	A boolean property whose presence indicates that the
+			PHY registers will be configured by hardware. If not
+			present, all sub-node optional properties must be
+			provided.
+
+Sub-nodes:
+  Each group of PHY lanes with a single master lane should be represented as
+  a sub-node. Note that the actual configuration of each lane is determined by
+  hardware strapping, and must match the configuration specified here.
+
+Sub-node required properties:
+- #phy-cells:	Generic PHY binding; must be 0.
+- reg:		The master lane number.  This is the lowest numbered lane
+		in the lane group.
+- resets:	Must contain one entry which controls the reset line for the
+		master lane of the sub-node.
+		See ../reset/reset.txt for details.
+
+Sub-node optional properties:
+- cdns,num-lanes:	Number of lanes in this group.  From 1 to 4.  The
+			group is made up of consecutive lanes.
+- cdns,phy-type:	Can be PHY_TYPE_PCIE or PHY_TYPE_USB3, depending on
+			configuration of lanes.
+
+Example:
+	pcie_phy4: pcie-phy@fd240000 {
+		compatible = "cdns,sierra-phy-t0";
+		reg = <0x0 0xfd240000 0x0 0x40000>;
+		resets = <&phyrst 0>, <&phyrst 1>;
+		reset-names = "sierra_reset", "sierra_apb";
+		clocks = <&phyclock>;
+		clock-names = "phy_clk";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pcie0_phy0: pcie-phy@0 {
+				reg = <0>;
+				resets = <&phyrst 2>;
+				cdns,num-lanes = <2>;
+				#phy-cells = <0>;
+				cdns,phy-type = <PHY_TYPE_PCIE>;
+		};
+		pcie0_phy1: pcie-phy@2 {
+				reg = <2>;
+				resets = <&phyrst 4>;
+				cdns,num-lanes = <1>;
+				#phy-cells = <0>;
+				cdns,phy-type = <PHY_TYPE_PCIE>;
+		};
-- 
1.9.0

