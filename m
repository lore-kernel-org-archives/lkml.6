Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3287DC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F4A20875
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="SnpymROm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9F4A20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbeGLFzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 01:55:50 -0400
Received: from mail-cys01nam02on0061.outbound.protection.outlook.com ([104.47.37.61]:38202
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725860AbeGLFzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 01:55:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1dAXH9c3EFx7bKzyGrNQi0xKYwioNZlfVi1LyYRmTM=;
 b=SnpymROm4+wu6hJ/O7J2BBJs3CmVwADGezXAmSsgV+752QubBA3TOuBmgCYzw+s0FpK2oGsS5iptmprgBTdWP4lvuwV1KVVydPA2e/DDo2dv769mF1+tLffR8fWI1LzHUCmN7KS3XWg4PdhkipOSRTZlAcDJbDQgh3jRC7eXFYc=
Received: from BYAPR07CA0064.namprd07.prod.outlook.com (2603:10b6:a03:60::41)
 by SN1PR07MB2301.namprd07.prod.outlook.com (2a01:111:e400:7a45::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.20; Thu, 12 Jul
 2018 05:47:50 +0000
Received: from CO1NAM05FT049.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::207) by BYAPR07CA0064.outlook.office365.com
 (2603:10b6:a03:60::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.952.18 via Frontend
 Transport; Thu, 12 Jul 2018 05:47:49 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 CO1NAM05FT049.mail.protection.outlook.com (10.152.96.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.973.9 via Frontend Transport; Thu, 12 Jul 2018 05:47:49 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5lkvs032054
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 11 Jul 2018 22:47:47 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 12 Jul 2018 07:48:01 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Jul 2018 07:48:01 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5ljhN029440;
        Thu, 12 Jul 2018 06:47:45 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6C5lixS029393;
        Thu, 12 Jul 2018 06:47:44 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 00/31] Introduced new Cadence USBSSP DRD Driver
Date:   Thu, 12 Jul 2018 06:46:57 +0100
Message-ID: <1531374448-26532-1-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(346002)(376002)(2980300002)(199004)(189003)(36092001)(2906002)(356003)(14444005)(5820100001)(8936002)(126002)(2616005)(316002)(54906003)(486006)(246002)(107886003)(42186006)(109986005)(476003)(7636002)(23676004)(8676002)(106466001)(47776003)(105596002)(26826003)(36756003)(426003)(478600001)(87636003)(305945005)(50466002)(6666003)(4720700003)(86362001)(336012)(4326008)(5660300001)(26005)(186003)(1671002)(2870700001)(50226002)(266003)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR07MB2301;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT049;1:3M/Njq5eQ5PuHggnTGKW2G675B+UDAYJUowRCwfunDi2hmfhx2CAE/LmjXLnV3mt5uZTsgECw33qpPvPsqvtngR/L/2xAyj631YFKzlUsgp7hjZbqbTzRCbEn5q5v6wi
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf7ac82f-eff4-4602-0777-08d5e7bb0079
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:SN1PR07MB2301;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2301;3:FfOxVmAKgsiIRU0/mdBj1BQin517OiEkHXe7oB/DlMMw1jq3NwxbMsrxv6BhuDVy5Ds0vCWrtKTA+q6sc2swVlZJQzUSqvyXPYjKfG/b2XwO+N2tm1yqjEcwZg0SLTAOVHyonKzqOo1Ca79KyEeMHu5OU3tqFkM4TnTKexixZjpWbOf+nBenNIbR/ChgrvrV1gbDZNAMrOtGO0BXr/nKnZkr1nsZb0LFI5vaJv77Q/ruJQawkcvpwmtvOJkepgy6NUoWazwDHpKxeptHCYOekJ1CKJhplyD++HRTPoxNTKPkf16w7STpyGaUUGw9kS/VAX07q03TJ2VyitoUqCYxVhInqi1MawKkn9jGQLggUiY=;25:GTGlPps59U5nw3H2D6Fpxt6qSj5FGiahGU3dSRTrX2ru3lVNoOZoHNrizWtTSoCzwVIjTVfY+CjsQ3mECoqMH7TkjUyKDX+QB+pvxd0KsPFd1E/zZWEOlv/ZV5INxGP/5Bn74YHQkRbtmBhVJzYkO2JCyQQCb6n1cTdt8BR6qEd1uaLfnHIfNJAunDwonA3jArEoSp/KYlTUY79e8hllzPkQWrGxykdayniHWFr+luzFTEgtN2RZEfMzZh0PQzXX/PmxezDHPWgwGGD/dvNSijR4OgIuCGnLtIM7lCLXhvnI0cZctW1DfmaSNNAwdA/pzky/lZRmKcHKgCu63AkKZQ==
X-MS-TrafficTypeDiagnostic: SN1PR07MB2301:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2301;31:r6qHXMcghzpI+8ZYFdHqvJq/1ZP3LKNgh2FlWY/uy/H62KPizTE5bs3jIWogGzNgZ4GMTQ17JoY8oE3XzJo6xCm9CzYCMS0kWpr+p1z+juB8F+qrIkNba930IpeHbZMx5WT+adaAjZWSi8jvhymzbdLHvaoDA9+cJI8oadMGiS/yFPFrTR/sSuIijXUwPJxG5di2mjw2wBZo2pzHiXBYfuNWFfW4NKzrudyPqvPLt+Y=;20:UMuJe58NOrn3NeEY8/tUR6/wh+L5yKxz0asaib5RDgh8FFydETkKXJZ21YZDyII0r/HQTASaDXbZ/xsLfJuW85biPez7lwwTMIiwuRBSH9MJX2vFdBxZInSLvIcSH2dJYC6Z0vV4umuuWTiM0/cUGJ0fouCDeh4lsgoQdxGTPqWBmLFSBY/kyEbxOYRAzXDTbhVDD3F6Jm0EAKQWjMosNDVYkityD8aMKSMNIwERBJNdFm1QIuJfS7zQxKF/x8GpTFBTi/WuUxdSv2Zni3dfLmCdyOlt6TvbramyEa1yy9pxdMFwOCUkVlzb50gHfygRCLIN8Ea8XHM0Qdc7dCqSbnKYmBJr/JcFsNx8E8OSXV8AaSD0uCeEvMHB0xkTbCbCqEWoOuyzzEtxT6zsQppLqWJsqkHd6dtugSHh8cfOjSor7OTtvhnyau6yyVXZTf2qbX+hS/ETzOnw+16s049zaIBD7B4fupbVi2ubUuDLBHKEZyKpFcDUUeIAfyOH9maK
X-Microsoft-Antispam-PRVS: <SN1PR07MB23013A50896AAB56A43D06EBDD590@SN1PR07MB2301.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(21532816269658);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93003095)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:SN1PR07MB2301;BCL:0;PCL:0;RULEID:;SRVR:SN1PR07MB2301;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2301;4:lF30rhtcZmtzUMJ40G0fNwZadamVnBWMB9dl7nC2ZMlGrj+0rbf9CA6xbcYYxB6lZ+t2/QBgsn3eWhnw2+/Gs0i1fpSK0eBax2mAeHJ76rivqirD1WbrMOQtaXCdhF33rQe3bSHNviIdcMy2iaPDnLy40SPpASdT5OgPgEYy46XFsF9PYhxdIA4zOEEXNwjsiC/MdJJXLPVCMpwZuMFnzKshFQcCtC4ZrtM0OdHFQQ0xXl49oOcJ9sIlnBUEbjaF7F/lxDLeJru5QOjrJljrOKYu926wglGswVsHcpzMJY374WQPHI5nDZfS6b8fTD4j
X-Forefront-PRVS: 0731AA2DE6
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjFQUjA3TUIyMzAxOzIzOk0zdjA4bk01UHJRVDVEWWp0OCtEbzMwT01I?=
 =?utf-8?B?bEtmelB6Rmc4V1NOK2VoWDFnaisyeUlrR2ZUZEhjVHpYNk9ER1hTUEQ2eDY1?=
 =?utf-8?B?aG9oNkw4ZTJpdGVyQTZpaGlqOGZDUUhiZm0vWkpyQTR0cnBJTnRrZEROWjFt?=
 =?utf-8?B?UUNYdDhhajBZdUVLemZNd3FOMHBReEZhUE1tWmh0QWMvMW5wYnJrM3Nlc24x?=
 =?utf-8?B?TUViR1kwM0FScGpOcElOOXBldzcreVlTOWU3Zk9LeWlLWVluS2lzMkh3cGZR?=
 =?utf-8?B?MnJKMlVJaFpyTGowL2I2Q3JiMEhDdnhXL2VIRS9mYmE5Z3F3UWZSdXRONnAw?=
 =?utf-8?B?aEZpWWozUVJzc1VrUVRVUzlxVktsd1o0RzRDTEJjd0E1dlk2cjlUcW5SZWY5?=
 =?utf-8?B?VWJUU0VHR0hDd0M5VmZlbC9sSExTM052T21jcDhrcElHSnpOUWd6MTY5dzdZ?=
 =?utf-8?B?b0JGWmJOaFlxa3VEQUN3RVdoUUZtSU9OdkhDenlsZ2hSQzNHRHJIVHF1eC9T?=
 =?utf-8?B?dWxSM3g4ZkVBQzJHSHpPSWpwVURBNE1ucmhDRGpuVmdQOHgrQ0VjWVp0TG5t?=
 =?utf-8?B?bmxJakk3emRQN0QvRUhPSjVOWHJYTFVacDlDc2tIaGhHQ0g1eHJKUGVhdUUr?=
 =?utf-8?B?M1JYQzFYRVRnbWQxQmREamtwY1dwVUpPbExub051TGxOT3NuNWlINGdBUVlC?=
 =?utf-8?B?RTJ0TmhvVGFvclozMFVIVUx2YmxtTkljZG5iN2dDSUJZMzRYRjBBZTVvUzI1?=
 =?utf-8?B?aHkwdS9QWFh0L3cwdHZBc09Pbys5ejNOSnBGdHFWS0dSTWM4WFBDVXpsN1Ry?=
 =?utf-8?B?cjNWc3lPN3pWLy95bWlQYnQ4R2ZFcHZYZVlkc05mcnNLR3ZwdEw1SXgwcVpJ?=
 =?utf-8?B?ZW5QQzdySUdzR1Uza0lGWmkwdTFCVFBRZytUd2hjRzNMZUJiZkZvT3V4R1l3?=
 =?utf-8?B?cTJsNmxKNjRMYktxT2NlRTBURjZhVDEyRWJXZ2pmU01KMzNZWkdocGJ6VU9n?=
 =?utf-8?B?RzcrQk1qSUZJUTQyYXZpZVdCekFVQTJKU2dIRERFMWFQNm1WWEpVcGU4bEQ2?=
 =?utf-8?B?K0NJUVphbFZNNnI5dWUvT2t1Ryt0Q0ZvVWVvbEFuOThraC9QZHNjSmZnRzlK?=
 =?utf-8?B?VkZxdkhPVVlGL2pTUHVwWk93bU5LV050RzhqNmhMbW4yRzNaWGxvTHJhWnNK?=
 =?utf-8?B?RmFQaUZVT24rcTdVdjAwek14dkp0clF5T3lCdEg3S01lckxUQXFSUUQ2eDhF?=
 =?utf-8?B?U0t4TjcwZnNXT2tMWXdWaytMQTVqTlJNN3Nub2lZdnh3MzUzNzNvbnR3dXE1?=
 =?utf-8?B?dlhkL1ZlL3JRcVRWY2lTM0tLWjRORDZLdlJOOVZUdTlTQUVPUHJ2aTJqQnJB?=
 =?utf-8?B?Q1BzOVd3ZXhyQngwZkg3d1FxQUhiaFQvYlJBWlk4SC9INzl4RTV6NHlBaVBa?=
 =?utf-8?B?T3FwRm93Y0Z3YTBzdy9XSThRQWIzRUh5ZllpcVM2QnkxS2h0bEovQTUvSjBF?=
 =?utf-8?Q?Mmb2tmO/fTPdulJsBjg4WmE34=3D?=
X-Microsoft-Antispam-Message-Info: k5+U4Yb8h408o+lIp2M61XFoyP6Z/tjOBQaXxxGhQSn0fhoL4IqJfSPIwClA7YqQiyRcUKjiHvtA1hN28+Tz2yFFWhSqn6Vl45ZnClbbqJayWax0V4p99Oub28nlz3yhI/P4lO0mP2Gd2LRJTUQGhqsKIWxL0+3wEZQCRfd7h2YJDiS7Q2u+/2KmgWI9J3QnWcI3KM+/ipJf6IpKydmWtC3uP6ndaiIIrASrnXmejmrWu58mgC4ikytSJel7xeTpjHMzdVDQrJ8TwfzUAtSy1rmLSqrn3ffUD205KnELL9vLR4oTQHSh4Fzsxx758R/8/sKjayAsn1j3ehD9LozsjH7HKOcUUs6aiEEbkr5YmH2oplHz2OoF6H4zPue5eqHzc19nHBtxupG3ntevLC2RtA==
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2301;6:IoHEOpT13+6f9TKC+IKQA13XfLL/A0oRjnns73XhDaiopOma78fT1rtZEbKFLudRszClSGgNkCb0K69zZ0ETLb7ULZYtfb3O0YQPHKWEz1x0MSy0N5iR2uio7G7ecVqhfw6o832/UR8Wm1PHiV65aPN1LLoImaJJ+OMeNny2j84Eh/MQdMNm+BV+q/ZW0fsJOA25WmLcqJ7+dtd/xhTgcLXLZVo4O9/xD9Vy07eAx3VyHA3vvgQ3sDnvJ2uMNFyKTQmW4m/FF95nGv2lC+XlTdoSeDewgERf7qxEzvKfakhM3VbfZ4RJkZsjTManHuBWaP5jGQrsjq6b1+8+Zrbtq3GvWqMEfhFcDQfp+4di2H/uHHCGBZmu7dKSJFLzGxxrf/oXZsweSL0lLkKihmngt9Mfzh3n0WWnNPn4dAmvb66ihHU2US2lffFfUiKbeSek4cGgrm8+dni2IZAEVafJxw==;5:A/dVBddeoJyOyP/PdK1qWJEEcqb3OcDfG3ka0UXGRICNQL/0r7F31LfCvJYUz0yXtVrNCruqFYKz+xTZ0GRo7x4xjgZY0ffplnu28C0iV5ZPFmqKw7peAp/oxFzgh4X++4tvtXkQPkd8ipBUtJC4hYFWyRRKKBimZEF6IjHjv4I=;24:bgt0U+/1AWyQcDdjRUPV6PlnJmpdWjpO3H+pnQCejC1AyUQt3R9Ti994ZKb3zAoRdbNMAWiVjNFw99w+Y0Q/CofpyUnd4BPC6Qr2Edls67o=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2301;7:8UB24PJls1jdJPE/FplI8aiU3qxUc9WceNxmN0muuubPMRyfDyWJYQBk1/VV1IwMLOtMUiqFOiSnHFsPaOy29bKBBg+ZxqrSjfyHig8Ju/NOczGlZjGGrwwKRBKhhDK47sx80uVaANQIvRwc47d4Fejz537j/A8CEQLSGaHVF3EOx0/ZXmEf0wHF5MB4g1j+FTi4kXHgMkRCx82W3CXRjSBBYV2KroiBKBW+XOVZVKrGqooD2lwGUWEf8q5as5hM;20:yN87tbaOltsarDoB8zLemlgjg3L2dPzbeeP9GoGN3CWpCevvxazs7ER8/Eli8I0BIJ8Peob+035M+XvRHFx7Wr/KGfcnQvl4ReR+cQ6OGK4gxjdClxbSq2xWJiTJ5INBILepwJFl9aqDBWKxelmkwo50uTCahnf3c6pnJlI7MsRcSoRLSllxNC8hhZMyIkj4Izfhkkh9Nfl0MeiclTZmY0fsEvlduRomJdakIUYIzAM9jAaTPBbSrVc9H8jUXAO/
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 05:47:49.3906
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf7ac82f-eff4-4602-0777-08d5e7bb0079
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR07MB2301
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set introduce new Cadence USBSSP DRD driver
to linux kernel.

The Cadence USBSSP DRD Driver s a highly
configurable IP Core which can be
instantiated as Dual-Role Device (DRD),
Peripheral Only and Host Only (XHCI)
configurations.

The current driver has been validated with
FPGA burned. We have support for PCIe
bus, which is used on FPGA prototyping.

The host site of USBSSP controller is compliance
with XHCI specification, so it works with
standard XHCI linux driver.

Also, device side of USBSSP controller was designed
in such way to looks like XHCI. It means that
most of logic of USBSSP controller is also compliance
with XHCI specification.

Consequently, the USBSSP driver for peripheral mode
is very similar to XHCI driver.

This version of driver supports only Device mode but
DRD and Host mode will be added in the future.

---

Pawel Laszczak (31):
  usb: usbssp: Defined register maps and other useful structures.
  usb: usbssp: Added some decoding functions.
  usb: usbssp: Add trace events used in driver
  usb: usbssp: Added USBSSP platform driver
  usb: usbssp: Added first part of initialization sequence.
  usb: usbssp: added template functions used by upper layer.
  usb: usbssp: Initialization - added usbssp_mem_init
  usb: usbssp: Added ring and segment handling functions.
  usb: usbssp: add implementation of usbssp_mem_cleanup
  usb: usbssp: added usbssp_trb_in_td function.
  usb: usbssp: added function for stopping driver.
  usb: usbssp: added functions for queuing commands.
  usb: usbssp: addec procedure for handlin Port Status Change events.
  usb: usbssp: added procedure handling command completion events.
  usb: usbssp: added device controller error, transfer and SETUP
    completion event.
  usb: usbssp: added connect/disconnect procedures.
  usb: usbssp: added implementation of usbssp_halt_endpoint function.
  usb: usbssp: added handling of Port Reset event.
  usb: usbssp: added support for USB enumeration process.
  usb: usbssp: added queuing procedure for control transfer.
  usb: usbssp: added queuing procedure for BULK and INT transfer.
  usb: usbssp: added procedure removing request from transfer ring
  usb: usbssp: added implementation of transfer events.
  usb: usbssp: added detecting command timeout.
  usb: usbssp: added implementation of usbssp interface.
  usb: usbssp: added endpoint configuration functionality.
  usb: usbssp: implements usbssp_gadget_ep_enable function
  usb: usbssp: implemented usbssp_gadget_ep_disable function.
  usb: usbssp: added support for LPM.
  usb: usbssp: added support for TEST_MODE.
  usb: usbssp: add pci to platform driver wrapper.

 drivers/usb/Kconfig                  |    2 +
 drivers/usb/Makefile                 |    2 +
 drivers/usb/usbssp/Kconfig           |   29 +
 drivers/usb/usbssp/Makefile          |   15 +
 drivers/usb/usbssp/gadget-dbg.c      |   39 +
 drivers/usb/usbssp/gadget-ep0.c      |  567 +++++
 drivers/usb/usbssp/gadget-ext-caps.h |  101 +
 drivers/usb/usbssp/gadget-if.c       |  568 +++++
 drivers/usb/usbssp/gadget-mem.c      | 1927 ++++++++++++++
 drivers/usb/usbssp/gadget-port.c     |  284 +++
 drivers/usb/usbssp/gadget-ring.c     | 3444 ++++++++++++++++++++++++++
 drivers/usb/usbssp/gadget-trace.c    |   13 +
 drivers/usb/usbssp/gadget-trace.h    |  482 ++++
 drivers/usb/usbssp/gadget.c          | 1907 ++++++++++++++
 drivers/usb/usbssp/gadget.h          | 2336 +++++++++++++++++
 drivers/usb/usbssp/usbssp-pci-wrap.c |  229 ++
 drivers/usb/usbssp/usbssp-plat.c     |  186 ++
 17 files changed, 12131 insertions(+)
 create mode 100644 drivers/usb/usbssp/Kconfig
 create mode 100644 drivers/usb/usbssp/Makefile
 create mode 100644 drivers/usb/usbssp/gadget-dbg.c
 create mode 100644 drivers/usb/usbssp/gadget-ep0.c
 create mode 100644 drivers/usb/usbssp/gadget-ext-caps.h
 create mode 100644 drivers/usb/usbssp/gadget-if.c
 create mode 100644 drivers/usb/usbssp/gadget-mem.c
 create mode 100644 drivers/usb/usbssp/gadget-port.c
 create mode 100644 drivers/usb/usbssp/gadget-ring.c
 create mode 100644 drivers/usb/usbssp/gadget-trace.c
 create mode 100644 drivers/usb/usbssp/gadget-trace.h
 create mode 100644 drivers/usb/usbssp/gadget.c
 create mode 100644 drivers/usb/usbssp/gadget.h
 create mode 100644 drivers/usb/usbssp/usbssp-pci-wrap.c
 create mode 100644 drivers/usb/usbssp/usbssp-plat.c

-- 
2.17.1

