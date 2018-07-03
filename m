Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42679C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E92322251D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="BjQhoX82"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E92322251D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933988AbeGCKGH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 06:06:07 -0400
Received: from mail-eopbgr720081.outbound.protection.outlook.com ([40.107.72.81]:48748
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754469AbeGCKDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 06:03:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYrpp2zmUqnDQGCFyoPn6ockHrlDO0MVzHtau67Q890=;
 b=BjQhoX82nh5HUiyxi/6pf+ZbaNhz+N6Av4NzO7VLip5On9z7yMBoV9/1B49lw5vGwmPe3JndU4s3cGkNVmf5IEV5uPmA9rRDrmpe8Br7hDBaxdVct19frQH7wdDGNfpHlS6yHJLavmtMhQUHJ0P2lWyGWVYYKC/T6F0v9GwbFpU=
Received: from SN4PR0701CA0016.namprd07.prod.outlook.com
 (2603:10b6:803:28::26) by BY2PR07MB2295.namprd07.prod.outlook.com
 (2a01:111:e400:c50d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.18; Tue, 3 Jul
 2018 10:03:20 +0000
Received: from BY2NAM05FT011.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::209) by SN4PR0701CA0016.outlook.office365.com
 (2603:10b6:803:28::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.906.23 via Frontend
 Transport; Tue, 3 Jul 2018 10:03:19 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 BY2NAM05FT011.mail.protection.outlook.com (10.152.100.148) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.20.930.2 via
 Frontend Transport; Tue, 3 Jul 2018 10:03:19 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w63A3GAS024705
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 3 Jul 2018 03:03:18 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 3 Jul 2018 12:03:32 +0200
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 3 Jul 2018 12:03:32 +0200
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id w63A3F42029301;
        Tue, 3 Jul 2018 11:03:15 +0100
Received: (from dkos@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id w63A3FWO029293;
        Tue, 3 Jul 2018 11:03:15 +0100
From:   Damian Kos <dkos@cadence.com>
To:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Damian Kos <dkos@cadence.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>
CC:     <ltyrala@cadence.com>, <pgaj@cadence.com>, <stelford@cadence.com>,
        "Quentin Schulz" <quentin.schulz@free-electrons.com>
Subject: [PATCH 04/12] drm/dp: fix training interval formula for DP 1.3+
Date:   Tue, 3 Jul 2018 11:02:15 +0100
Message-ID: <1530612152-27555-5-git-send-email-dkos@cadence.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1530612152-27555-1-git-send-email-dkos@cadence.com>
References: <1530612152-27555-1-git-send-email-dkos@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(346002)(376002)(2980300002)(3190300001)(36092001)(199004)(189003)(5660300001)(106466001)(105596002)(50226002)(47776003)(4326008)(7416002)(26826003)(478600001)(87636003)(336012)(36756003)(2906002)(14444005)(356003)(186003)(305945005)(7636002)(48376002)(50466002)(446003)(11346002)(426003)(486006)(2616005)(110136005)(76176011)(26005)(86362001)(42186006)(246002)(54906003)(51416003)(2201001)(316002)(8936002)(126002)(476003)(8676002)(16586007)(921003)(21314002)(83996005)(2101003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR07MB2295;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM05FT011;1:wLDfj8OHy2A1d0QGnKcJPYILFlStkgaSxtjashSsDdEkJr629WL7ufMgIrn5YS5QXhR8eC9NkVJrx7xjrsFegIyKWsTLklD6d6T5UfoUC8ZDxEoBjqcGKSzyiKW2aHz9
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53fe9ef7-4065-46cd-f803-08d5e0cc3449
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BY2PR07MB2295;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2295;3:o/xpRoQLXM4oOkmbwNAW/v1AHNwfRG7Q2qZ+d4ttOtxpJ6QJsOYNl22209RQknj91K66vbVk22C/Lk20ktuWYmPjd9c1GeT8jmR0K2pBRz2Bi3u0a8AFQy+M8vUmP4J/Uw30HDlvvLqtUP3o5yYVGUeazIaUZ7jAC3YPZMwkJDkgmXTI1slcPTKh0+mU90plf60UHNJ/MD8wA6785nR3wZhx4OWpNZtWUZ/dFYZUUoifGg5yNDxSXSq/a9nZsg40HClwkhSm5S0ghZV+xGM+aLTqK7hSZl0MjmMgjNtUegRZ9KEShtnFZoNfozC2gLVVUq695nMtwBEhz3hQy9miFJrzrj5N1OR5ldK4LPmfkCA=;25:TbR1vEzKjbq/Pkqt8zPLEMtairoOC8HeRMWQ4w7KGFoyMdveA60EbNF+6W/3HlvPMfcIdKQxvc5MjuOXIInoPEpwYKc4xWX6OMSRj+ldi8QOy44Kv8M38lh1SkPDlWLx/7It7Q0g4HthBCdzjkpY78TeGMTsWBq4An0g7yOT4eoTwJKiCO7Gl59aY4COgDDLr2kHVvB4bpYnOJkhIDwURghmx8mAVVhEjCjKb0f1XFe9K5p6DWyecoioY2zjdb17shNVKHOazfhnnSONQ21cgDQhyTvN11gpmQ5ux3swfAl4Hxf2m53AxgnK3hzFqdliEVyKSfrNERF4xPKpSR97pg==
X-MS-TrafficTypeDiagnostic: BY2PR07MB2295:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2295;31:ofZnDbpCtRM0HEP9rQFezgEkbz18Fg+m6rNG+8YG9XSAElrEpG/CsW53ApWt799bZ+fM6TyKWFPhRUS6isgutrTHTJMoUkKCgYG8rDQ4oCJF+45NLWXqjKS8tnZUXDd8QO9yaVw0E4dB3u5Ld9E25D0ukBvyKsincx1ifab5VBI/dY/b378a97e5ND0dnq3btChmiDk5SKvLERBIfdy0QvFPw/EySBJYxVsDjVODwDA=;20:H/vK8nxiXpmumypn0DoWDXCmDhnI8bNJxszH1c6z7UqJQaI6bkDhqkCMDRet8jAT5EYA2oxv0OClM3WIHevHw1bJcMHE7XOEKO75UfDzSQXn6WjDFtsIJROzgD+s479yoacoedr2Yg6k6mTiT24cYfQ0PxC4T8xQIjhwMDND0EcrSBLrobABsMK9yayBb7gohzi+OhB7nZVwLMN+FOt/b+GCwwuCSoUyLUDiyDjOWsn/PEjU7kbRW8Jes3trDytLn2Dtu71837+Rmq9GbDa7nTaUdgGd6yd6jg9JNfLOtOLpwWhyPO6XdVzZN+YHoXwzwa0AEQNcFc1U6YD7SI+EKyo1KbE9G9Gy9UwShPd0oDKSBHgLVENlsjNGXITmdvsRnGa8p8nPEa3Qns5KinJB+4S2jvcNTJQJD6sqEOBIHAkJBAwyXzvXK8/DDlbC1IXyfJetEiYLT9Xsjq5mdsyvO3GPWBdFIJRzQo0wXqszJ7bjZwTJfgVyLBv8V9dgtawt
X-Microsoft-Antispam-PRVS: <BY2PR07MB22951B67C691BEC4F9C99828CD420@BY2PR07MB2295.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(58145275503218)(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93003095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BY2PR07MB2295;BCL:0;PCL:0;RULEID:;SRVR:BY2PR07MB2295;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2295;4:S2yRKcZrDgRLVaN+5uMORNK2i6Alm69T6A49690aXCvHgw0ER5YibMKMwJx1Nyo+1TQFR1/gIl7h+Mj+N110QO70LrR6kJ8tFLNDKjGkLWtGe6c1hS9Alzl/d/VjnTRUoJLDVUkj7n1KkmHu36vH2sHNwCYUmtP5JovsTLzwkolMTgDDkgMiIhYJZz4l8Jz89mHd1vf0HfetZ1eCrm8a88/FoYpkQXAcCgL6ZihpV8iLrz03xA7gJzx7QF6ZeGhkTln6jUHMKLS5Ht0hJy93ywbX56ae9Lok0K4hkKVNELjGaDRKZqsTv0wStIYRTF/2hsqCSI9sr4IulhvazdEiTw==
X-Forefront-PRVS: 0722981D2A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR07MB2295;23:p+a5G4QdQOV00cWFBOgADWj3Ks7JgRL9abdbY4XdB?=
 =?us-ascii?Q?F/DqiO/phGuwGnipsK36rJ4lQPYqChXcXK7vRIrKoGkysYx8+KQh1A/tSaiH?=
 =?us-ascii?Q?ZR1WdX5O7Vd4rVSo11Aaje7yLwN9RzjZEh/Wo3Mamfk0g6/CqX8jdJiP0xCw?=
 =?us-ascii?Q?HNNUhLLbXtlFJzFBOL8IkvLiWllyUeXZW4gncRYYI36IUw0AYNm8vX5VP+2x?=
 =?us-ascii?Q?igwPDPlL7TZWLqQxHoQO6GbycbuAPaDvDo7ZO6JFv5K14isnoygmicnKABFb?=
 =?us-ascii?Q?2VjL3pDdjYWXUAUc+F3dRDIfRttpOWK8eb5FowhP0rrCey29JbXtblDiLOo6?=
 =?us-ascii?Q?3reQtKKMOHn8hUQIAfXgnNsfbG4PbHHIaDzQKQrcJaU/KjTNGj378huJcbAI?=
 =?us-ascii?Q?TRem4eMyj7DGdt9quhBA9DEr1Mhf1f1axl2ITvwz+3820t5yWO//8eqR3JRc?=
 =?us-ascii?Q?VbqPSONEgnPsxa63KVFIoQM8hpIn4nz9Da2/JgXA2uOpxk4XRWJ8gMNa4nmC?=
 =?us-ascii?Q?H8DX2D1Xr6HRFS2RglBMTz8Zmkhjfw9gXWw2rjifAbHEkL7R5YiL7zN8UZMt?=
 =?us-ascii?Q?6Dxrq+N2kOkjynCfm5Lkra/2R5QzIDavjFKwvWAP1g9tdjcxKcP0YfYPKFwk?=
 =?us-ascii?Q?wbFSmsFNX/BoR5rB3qZfwOaXAXJFl9I2nB0wE6DKWIDe+AeYXK0UK1wEPSxB?=
 =?us-ascii?Q?mS/yGIxErp5wKZ7+1NqeFF2GLzw5wG6wrw2MQ2R4sjIsEm+S9v4dBJfWtcZq?=
 =?us-ascii?Q?pqBiWyNxK7PejpNfkB3EsOVjhWAR0dY8P5aDsliqe4f+nuriyk/qgBlKgbhD?=
 =?us-ascii?Q?sh2OCmTtMSTLC0SJAY2IKlVG0OUXVPJMLb3Qrj6kLXcZtcgEY18eGkPXoULp?=
 =?us-ascii?Q?Ag0Ym3PRKtgB+mT7mrF0loUAjSZJyKZqLHpJEtm9vHzUyCfdU+/T4+/Vxk89?=
 =?us-ascii?Q?vl9DA1UDPUyoUzDk3f7896mmVFbvOHxpdgch0gTVx5TEEYd0S6sKn7CeDDUy?=
 =?us-ascii?Q?Dyn3EKQBGs+5MjBS/iw6Rky9UWMAs8zYHf+/yGsAT/3aIsNMu5OpZEZMgX1k?=
 =?us-ascii?Q?uIQZK8j3eeMpZJ2Tm87VOtyFFC6dNlob/xU/sZU7vLQSVUY2A2md1J0fo+Nt?=
 =?us-ascii?Q?MPtf2VmfGxQ31hiwHgiotSXjBVpSwWKIWc15nW2WMZJwbfn6+jFEpyUU8djq?=
 =?us-ascii?Q?71jM+07VOTNDzH7jVuaihLuh5HgaleLvUMj?=
X-Microsoft-Antispam-Message-Info: 2Ld0pRQIvNcOVx1VmNsRTE3wdGPaqkltEMHfl03HC9fBBs+mjpapv/QRdJpjM4PGH6y5IHECS+AX0XzDl+yQnsetjww5IpGXoYHisBrB9K3+zvbzbgEFUPDg9UcKSklJaZ5XxXkolQrQt0IyNCagKKFE6NrJHTEndUTtLbyxzUsRaDh+VCDNtMdmZkMpBqL5wfEnI3kJ25+33iKdresK7RyUGsqkNsfL6NH8RjcN/8pIxu+4wuziv7zE46ohWoXeJTDGV7JZoa2YDJv3C9WnVmVO42O5t+yoFi+LqPI0jdNN80QfCOk7Lnd7VzV03kuxa0u6te+LND5WquLGGoVQl4wYSx7WzGcd556vHG/bhQT1WeooINEgqzRMXp5wrBVWyf2Q8j4ulMHYZp/JSZR65A==
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2295;6:2v7MrvnZaHaeKZm9vPW/UNLpD+NjQGiYnj0EATdF7/gAUwv/sBHQo1LHE/bGuNb67UGfFmU1b9YN3JJRSl2bC8ByTnfdM5ZOzuWL8c9W8+ZJlnHNB+eSmyHdD+HvTEKdkBmtdUvUCwJQyScFjSNLREyNVylCo6jyYfQlJkfIs8S3bQSaiSFbYVgvZWGXItDYfrjoipIrIJfzVfcViZwTRoPjPVtntZxLMMl9lS30D4VD+uiZ4Atxw5TLPM55JhfaxqDz65Gf4wX2zJQ2TT5h2qWy+NSLFRaJphTGdEOLI0G6Hq/xIlzBj6mgmKR9EeyRaloiUyloDX+OpZ5Qt/cRB4y5H3CvMwsNMzyw4YRNwzd3YLRJ4fPQiZ31M0B/U6J0BazsfpuFAIfjGqHt3LknRG9bYvkgOBy0nedmgmIf/k+5YCitJgUr/lhsQ6ZfXnYnK1sBUdNf/u9dgB8NrhAPZQ==;5:h0Qggc2O30c2TkcRQDG3OT0vg6E7XcIKqJ2uaRbyYuDAqyK4UfUIxT+m/nMvJ9xsEXl7276KOw9AAooB5Vk99y0N9t18wT6DtmySJzM73Lum/cuGd7AG/u2TDC8OGZSdNHoarHo5KO96XvWQvJREk1S+mBp++SOmXhNOQY8/V6k=;24:uQI4yyMOCdvGPNdhBGhN5SIkHkYo+dvl66ES3MhvCDIo3FB7qQvJTYRnpfmExgWwaraPTGghTSWBcvJ8t0sWb4Pi7S170r3+Wp419sP3/c0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2295;7:fWokVq0A9kiPJsOgQqf/D4WdZGGOKfc9eYZxBo1KFqvtEq5dqpmduP5+31IlVBg2yjZu4Q7TLyUKhdo1NR68ctW6fdRM3vE1uDsxBEW/xU5Deqni5YzutViG0o5RxzgoSjy3ZdXf9v4ieLot5hhW/a5zo7AuOOGw5BmIThl0bPC1haZ8kR3Y3E+mCucm7aqVYv/wxVUdPqmVQ1pF7aYghukV+HNeU84BUPKE3JibqJTk0d+Tn2Cl6ob+KAVkN47m;20:wImM04Lkixxr56wTmX8/WXUNr0TMPAZRxPRwwk7+aQJIXNtMfCWW1LLpCXAepezhrtbyFtGP4nvGj0sCy6ikTuygouMiCcyaThLSgvoz2p/IQA2s3IZ+Cccv0AuYYE2dy5xM7xWMO3+OLBt65kwqFEHc86qvEMsq2nLwJWtu31ILG4tT1BaI7Kmw5VFkUcYJAYqdUxmXmFHLis1ANYeN20g4/gj6nRDN4G+YmihJSCx9QsRHknbMaS7P/zG77+Ra
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 10:03:19.6443
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53fe9ef7-4065-46cd-f803-08d5e0cc3449
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR07MB2295
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@free-electrons.com>

In DP standard v1.2, DP_TRAINING_AUX_RD_INTERVAL DPCD "register" only
has 0x0 to 0x4 values that are valid, the rest is reserved.

In DP standard v1.3+, DP_TRAINING_AUX_RD_INTERVAL DPCD "register" has
the same 0x0 to 0x4 valid values but there is an additional bit (bit 7)
that specifies if there is an Extended Receiver Capability field or not.

Thus, the formula for getting the training interval is now broken on DP
1.3+.

Let's add a mask for the training interval and a define for the Extended
Receiver Capability field presence.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Signed-off-by: Damian Kos <dkos@cadence.com>
---
 drivers/gpu/drm/drm_dp_helper.c |   14 ++++++++++----
 include/drm/drm_dp_helper.h     |    2 ++
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
index ca2f469..7f5d568 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -149,18 +149,24 @@ void drm_dp_set_adjust_request_pre_emphasis(u8 link_status[DP_LINK_STATUS_SIZE],
 EXPORT_SYMBOL(drm_dp_set_adjust_request_pre_emphasis);
 
 void drm_dp_link_train_clock_recovery_delay(const u8 dpcd[DP_RECEIVER_CAP_SIZE]) {
-	if (dpcd[DP_TRAINING_AUX_RD_INTERVAL] == 0)
+	unsigned int training_interval = dpcd[DP_TRAINING_AUX_RD_INTERVAL] &
+		DP_TRAINING_AUX_RD_INTERVAL_MASK;
+
+	if (training_interval == 0)
 		udelay(100);
 	else
-		mdelay(dpcd[DP_TRAINING_AUX_RD_INTERVAL] * 4);
+		mdelay(training_interval * 4);
 }
 EXPORT_SYMBOL(drm_dp_link_train_clock_recovery_delay);
 
 void drm_dp_link_train_channel_eq_delay(const u8 dpcd[DP_RECEIVER_CAP_SIZE]) {
-	if (dpcd[DP_TRAINING_AUX_RD_INTERVAL] == 0)
+	unsigned int training_interval = dpcd[DP_TRAINING_AUX_RD_INTERVAL] &
+		DP_TRAINING_AUX_RD_INTERVAL_MASK;
+
+	if (training_interval == 0)
 		udelay(400);
 	else
-		mdelay(dpcd[DP_TRAINING_AUX_RD_INTERVAL] * 4);
+		mdelay(training_interval * 4);
 }
 EXPORT_SYMBOL(drm_dp_link_train_channel_eq_delay);
 
diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
index 6e64b2a..bd593df 100644
--- a/include/drm/drm_dp_helper.h
+++ b/include/drm/drm_dp_helper.h
@@ -119,6 +119,8 @@
 # define DP_DPCD_DISPLAY_CONTROL_CAPABLE     (1 << 3) /* edp v1.2 or higher */
 
 #define DP_TRAINING_AUX_RD_INTERVAL         0x00e   /* XXX 1.2? */
+# define DP_TRAINING_AUX_RD_INTERVAL_MASK   GENMASK(6, 0)
+# define DP_EXTENDED_RCVR_CAPA_FIELD_PRESENT BIT(7) /* 1.3 */
 
 #define DP_ADAPTER_CAP			    0x00f   /* 1.2 */
 # define DP_FORCE_LOAD_SENSE_CAP	    (1 << 0)
-- 
1.7.1

