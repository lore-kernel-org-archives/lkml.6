Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C896C282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D83FA2080A
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="2C0fwmL3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfBEKhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 05:37:03 -0500
Received: from mail-eopbgr690057.outbound.protection.outlook.com ([40.107.69.57]:23392
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725773AbfBEKhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 05:37:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50bBTzjwhVlmueHY3ClaK25zxijSyvma9ohEff/1P5Y=;
 b=2C0fwmL3p2f0DhH43ywvPiFUaSXy/i8bqo70/l2773nR0qkDkdP0dQRRnrADQTP+s8AYWuU1GjlD4rHoRsWexqsXUkMyhjlUARWglOMJXURShNkLNYp1W9wc3kh1ZvmVpZQU9++YknvdBRABg3iZsYshiAAvpGIySkEF7ZR2f8E=
Received: from BN7PR02CA0029.namprd02.prod.outlook.com (2603:10b6:408:20::42)
 by MWHPR02MB2655.namprd02.prod.outlook.com (2603:10b6:300:44::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1580.20; Tue, 5 Feb
 2019 10:36:59 +0000
Received: from BL2NAM02FT061.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::201) by BN7PR02CA0029.outlook.office365.com
 (2603:10b6:408:20::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.20 via Frontend
 Transport; Tue, 5 Feb 2019 10:36:58 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT061.mail.protection.outlook.com (10.152.77.7) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1580.10
 via Frontend Transport; Tue, 5 Feb 2019 10:36:57 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gqy65-0001Ny-D7; Tue, 05 Feb 2019 02:36:57 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gqy60-0001ZN-9G; Tue, 05 Feb 2019 02:36:52 -0800
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x15AalMl007979;
        Tue, 5 Feb 2019 02:36:47 -0800
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1gqy5v-0001YP-6L; Tue, 05 Feb 2019 02:36:47 -0800
Subject: Re: [PATCH v2 1/3] firmware: xilinx: Add zynqmp_pm_get_chipid() API
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Nava kishore Manne <nava.manne@xilinx.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>, <jollys@xilinx.com>,
        <rajanv@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20190204070951.6933-1-nava.manne@xilinx.com>
 <20190204070951.6933-2-nava.manne@xilinx.com>
 <d949520b-452f-9e66-42ae-263959a8c549@linaro.org>
 <f317c341-9706-3a24-6faf-711f2627bcce@xilinx.com>
 <bf3f2ab4-f355-c862-f2bb-2bd579b0cafa@linaro.org>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <1fb9dd1b-cde9-2ed8-0789-2f7eb73b310c@xilinx.com>
Date:   Tue, 5 Feb 2019 11:36:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <bf3f2ab4-f355-c862-f2bb-2bd579b0cafa@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(136003)(346002)(2980300002)(199004)(189003)(305945005)(31686004)(65806001)(65956001)(9786002)(47776003)(6246003)(106466001)(44832011)(65826007)(230700001)(63266004)(36386004)(478600001)(64126003)(53546011)(31696002)(23676004)(2486003)(2906002)(93886005)(50466002)(2201001)(6666004)(356004)(316002)(58126008)(81166006)(76176011)(81156014)(77096007)(486006)(106002)(110136005)(186003)(36756003)(2616005)(126002)(446003)(8936002)(229853002)(11346002)(8676002)(426003)(476003)(4744005)(26005)(336012)(107986001)(921003)(83996005)(2101003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2655;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT061;1:1XR9DWGUZUwTpgZUwlOzq/8VphEIfJ4GyLIm2GHWjyMmAP1DfcSKqbIqA+zK8r86AudOUqOpWx8y8wrSyUFHOqpZeqx6V3i8teeSCs6SNPBv6XhiHEKpzlUAHNb3eb2s3kH7XpJh2qLeHWEq4TuxGw==
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef714ed5-faa6-4127-6e10-08d68b55daf1
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060);SRVR:MWHPR02MB2655;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2655;3:+u7kCzmfK8bzvuwDkU6wziI/mcoYIh7ZqQVdFuOMrQtdfzxyDpmu/mtueKglQBznfVYln+Sv9pSvU/TKUuFmSfwEv5lj93mhoySsFMZTrqXnE95cdPvp2gcJgGyqjXu2n6pu015ob8fXP4+qhYe/kGjwRVs8XHW4hjfDegHlbwaveBIn8J7sqTG3hQqn7wmEzPrNufwu4qX0POdoxSj3LeWSr4Iz3xpQ3jbgGQN2Gk1DefrG7G6tcn5+OD8LqShpwsYRNtOk5N8sEXQFKm4UVEx7Zyjh2Y7ttoG33O67bs4ho9ViONdeSlwz7WMEzSy5BwNRVNkKHrUy61mtq3K/QNIOH2Kb9soXo22zeJYPh9Lq2E/xdevW4iV4c7Aq14Nb;25:MK5QUsGoPwPYf4AQeX/Wx4McjPsktw+v9FDhM6DVvT0Mq6G1A57FwL8zwuvBAplabobcW1M15QqJsGUeulQLPTuvCM0cfoZ1Qqp2Wz+He06Ski7N0Ek37zboYFFsSJfu/bhoXOnT7i5X2lX9X8qnt6eqHHVcKOrnsgBjxZaIE7zdLn551gSOdSHNwKPElKW4nwEKiSAX6dqKbgz5SdqUYeAnsphOSnrmWre2hXGqU21oGgb3EJTj+Vl0PsjInsDQh45xKWRa6yOdBBDppB9NYbatT995IzlfwwqkfDWp95xIEAaxcJSdrhE3K4eFppKKBSVEZgJ/t248vakoZHy3Ew==
X-MS-TrafficTypeDiagnostic: MWHPR02MB2655:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2655;31:vKsXUcMWwGb5kxQ7gkIW56kNwnEQYoN7NG/iAmaKUvaG0l/RDqykqWlvWCXCGRc2ybLn7MbKDDcSoA2kkvXdKfrbvyazp0lmC5jx7mRRovrEFqdfLwfQK19sD67gnFSaklECQqYDuwfNef7bufo/o2EVp6i9vPo+s8CD9lXjbCN720oY62LfCrZpqHtNP4hWhbgv5BnRf6mS0AOFa1IU1zB94nUYxqWHsibSDfm6NWs=;20:XwQ3xiS8SV+aEnWmCplJAkKN9r31NmGoMFUpxI9bmgus1s/SCZ0R+/UfBd/+RnruQ5V8nxZFlx7+XcMhoBT/81a7e+OHpbNm1QFtErYpnNhhGa6I3oK1RtuSE/pYIIzhH9SRD5+BgbRNRihEjZnwpKBNwNPf+81B73VAnle3V8ZcKZCET0vyRd71WEwLGcYHA8zC9U5vpourZou2pSsLCJtFBsdIFgRdlOi+RumRxxpqLjWvBYTsc7FfhvqoKjWKUgt5JljkB/9MQIWtrbkL5+7dMHpQsEK5WiAgehf6ZD9J6gjvVo2E8VAvhQ3M2LdeuDYaKsXuUxaG6tRrG4lom49/Ccgm7ulRG/YHBpMaZwlRGiQxthw969as5Ks3l9g7anSR2Kl69aSA+CV+y/wsYIjAxAEY/NEyiUJ5C+5Jub0x4HC7r2d108SKJhr8I/M3WmX4vK9KstmuvQofuCXgHFsdej9EgpQ29Gv+x4eDsv8r60GMnD/wp/pmysqJ+xFr
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <MWHPR02MB26550ADFB91AC34C7E5A35CAC66E0@MWHPR02MB2655.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2655;4:uVRg/CEe4IzcggWR6o/2NHV3du5J5Bc5Y/l0OGwiY+IxniwPyQaqIgLvxrnM3vOMas/bIn2FfyQULCV54KP3DRrLEcLoFuqEwbQzrqfZoiSgUxnpAfwMnnCnIFW7BOvefiBIrCwuul7y8IKCSLlX8SgZljA5+BT7Sx8/NTQ51WJgV5dTmybGVExYRZM6QjOJFxP8g06S2KB3BtJXR9Ds5z9RGb6dKR4stAmTbT53EjmdLYr0RIgY95dggudDy0a1KlDXKQvYIEsoZWgarvyYxRC5DYGbDBmHHnLPSIorf0E=
X-Forefront-PRVS: 0939529DE2
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjAyTUIyNjU1OzIzOklQQ21NNERQTGNQaktoTmxrTm9GZ2MvdGhk?=
 =?utf-8?B?SStNQ0xqN01NdHJhRDRIcEV1K2pjL0JXZDVEc3B0Ni9qdmI3M0tQaGpjNE9H?=
 =?utf-8?B?WERJRUJ1Qk4rRys0MFpzOWJKV3lCdDFQakJrOGdpOFhQRThuRTBDWnRYejdW?=
 =?utf-8?B?aGlyOXFtMVc4cUd0d1VHd2VOTWtmSnR1bXJpVk43SW94VEZERnpMaStDVzFU?=
 =?utf-8?B?Y1NBbjdhNGxwaTVLV0lZWVpRUnF6QnNIMkxjRk55Q0toMi9aaGtFQjRGbUJh?=
 =?utf-8?B?Z0NxeUlqZk1XWU1NL0VKNFEvYkJLV0dQS3hOeVdHVS8xTll4ZThXWG5pZUJI?=
 =?utf-8?B?RSsraWtsdjAyQ2g4cXRVaTF3UkRXbUdiMzRCRTZ2TTcyK2JJelJwOENjZmNx?=
 =?utf-8?B?Zm1mM0ZielBBTzZKYjBvdEd0azk2WFRZdG9sN1EySE9NQ3BKbEczakhybnJo?=
 =?utf-8?B?b1dKcVEzZ3BITmluZXk2eWt3S1hxVlFYbzRSNWJlR09oZ0oyNXAwOWNRcjZx?=
 =?utf-8?B?MTc4aFJBaG9iVVlHa1E2WXJFVFBZNjhBQzhvb1BLYjk3VTFKL2p3R3R5WlVG?=
 =?utf-8?B?M3YvVCtvRE1iNW5iSFZtb1ZHZzU2WGg3bG9PK2F0d0xoSzZBQjBzdVdVNUEv?=
 =?utf-8?B?L2NMWUpLSTAwcE9qdHNOemhpOHFjTlE0RHROa1pEcFJtMFNYcmhpOGpYTzRL?=
 =?utf-8?B?YWtqeW9uZ0p1Ri9ndTFPSDFqdnlWTnlXSFVoY1FtR2k1ak5aR0RxMUNHMjcw?=
 =?utf-8?B?cGg1OE9EZ3BFNTlseHZaZjVUYWZscUozYS94SmFwby8zdkY5TWxJcXJlUjlG?=
 =?utf-8?B?LythYjB5dEpWbmlXZ1ovcDFOWmtMUU01eWNPdjNIVE4xb3o0Wnd2Z3pWdFZE?=
 =?utf-8?B?MlVlWFRwdjBuZXd0TlVhQmQ4clpLL0FyT3NLbDV4RjYvNUN3N1NWamh5YU1t?=
 =?utf-8?B?djc2U0FOMm9mdjBuSFN2djJZUmlFWlhiK3hxUGo5Y1IvRzFjYTVBZGEvSGhJ?=
 =?utf-8?B?ZUtkRytjUDZPb0hyOE9abEhkVE1vOGQxUytteVlLTlRmOU1WZVVSaUN4RURn?=
 =?utf-8?B?alpLSmVzQVR5aVJsTEw2MXFUd3hWRkVtQXlpSjJORk9qTUQ3YytBZk8vV2JC?=
 =?utf-8?B?N25zWGsveVIzVmpMOHdyYnRuQnFCd2dtbjh6bjk0a1pYWlFGR0pPWmU3V0FY?=
 =?utf-8?B?Nmw5MkdsTUNiaWRLT0FqdThFYWUwdDNlcVh4TCtDTnZjcytMeGtYZDMwNXRL?=
 =?utf-8?B?Q3E4ZUV3Z0JYbHFMcUZzcXpxckcyQ29BckpaZVZpM0w5OERZUmdkQXpaSUJy?=
 =?utf-8?B?elFncThIMm92eXh4S2ovUUlVQllFejlaR0tSeWxOVXJkaXd1dHlwMTViVUZS?=
 =?utf-8?B?Q1R1VG1tSTk2WEZENGl0TEh1TUVsUE0xd0tNcjlrQnMyRG1Zc2VUZEoyb0Jn?=
 =?utf-8?B?WU53Nk1sWk9UNkt4Wk9EN0dkSFZPWWIrSHduVC9GZmlhVFo5NElySENrVldU?=
 =?utf-8?B?L0kzZjg5bVl5ZVlJVzFDRzEvRHVGUmV2OE5QQmFVcmFVdUJmMVpkazJWcUQ4?=
 =?utf-8?B?NCtzZUJ1WVJkOTZoQ2NvL1RlZU9LUk9XalhBWkZkM09Fd3I1YVFRTlpLMW1a?=
 =?utf-8?B?eDdqa21WOHZNbDFjZVhOYzgva3BxT1ZhUllwVVNmWjVkdHdUY1VEdy9mbzY4?=
 =?utf-8?B?a3h2ODhKYyt5bzJjK3NoaVpOUmNsVG5vVUNOQk1HRjJoTmNSelh1Y010c1dE?=
 =?utf-8?B?aXBBK3BLa05SZFZMaXpWYTU2Uit2ZHEzVDFVUGEvT0Evb1NRQ0RvQnFkQ2sv?=
 =?utf-8?Q?jfJ58m11udMtX?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: Uk1MPT6b6W3Tg+RGIP/DAafaIPZlsq/az/nklMdlmmwk42GmZ2WHIH8rZU4rth8rc/IFkcCgiVgUXpIwrDD1nbt23HnRCGrp1WrCp3Ueknqq5TzhQeon05eAao/Owi7xDRaRpVoCLw29qst17+UBHDQdNqSmjkM8wM+ooVQ4Ux3WBA/lDNi0jYswRQneQOFd+yP90aJLz6pbucbYKeiGS7mObXOvwx3v84iIEyVE6LGaN8MY4uKXLQN+huIj62vP/16mnzlY6LEpUB28kq/1GR7aqY0CaszzN5r0m6oe7tS7bMkC56Xt9YJh8xkE33sTugKvl19nsYJr7Ecv+fGAaFWD6IaT4Eu0WcmICI4lpYvqFi+LarZcZ2GA+wptZ+91bhZlnfVvHPxgbHESriHMWsp/AEzZ8WW5GIx1N7nyaVI=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2655;6:5Bu2n7Fj60cMhxmK/cON5dxTnVRi80FNRLnZaBcfd1C949sw6eN6RnKk6q3B/+OTGgJmflnHsztjl2YOAWpsOIvd/pFfz/AffCr3s8dPaUVD5Nlz8RGIcWVnmhd2lxetE41UI71yrzXwez7U2fajtesv7InEjnAvk6sCX3GR8MeWcxN0xSiDy4hY2OHNX54N2InC0n+EPGHYz2KTDyJpfkCLIhu5mNqZ9Qvb5FY8fNGFJPhAAyns0Q4c+5fJ50yEqDhYQHnJZBHAE8T6Rnzxl18r3h94ImC8LIUEKse+ovq7yW7nBfdkq5MVDEzrn8JitMrBsbWZD6pgnqkh7nU2elsUE3hEH7ytKcSdc3Vldyts1YLcuwJD5go5otbJV1/GEl0ggGAY3wrH05oDz4HwVfCsUGDbfOHkwzEWs+FbhYCoW2hPwb5MVcjhUzbgXq07mlZhWLX9p93elbDEMuvuTQ==;5:nVfKeBxojPL6sptubWTHenntuWlBpToPWcSV6uya4A7hbnmEaG0QMmEMBtNAGr+Pis15KpusbYrCO6YqptY19MoIHpRUg1f4pxzS2dIqOBODSO4oF4tWnDrjX8axtPSNxtD69GvnS9KICAmWYz9ziYWC5mS6t2QXnu0A8rTswDKcQnsj7O6OTxCF6fGPmdhTOqxLxKoXLK5ylJ2oAPWD5Q==;7:/BjruDIf8/jLku89HglyqfFY/ETguzko9AM+Of6jwOsywfNsoxRAEsKy0OdWPsKo1Oo50KJkzNl86MpKv9aaUHscEwkPazokCJ/pbPdQaMf/xsJ0hfUAQV260HSvZVBQYqBOufl+VtIWEaWaLfacyw==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2019 10:36:57.9498
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef714ed5-faa6-4127-6e10-08d68b55daf1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2655
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05. 02. 19 11:33, Srinivas Kandagatla wrote:
> 
> 
> On 05/02/2019 10:29, Michal Simek wrote:
>> Hi,
>>
>> On 03. 02. 19 9:50, Srinivas Kandagatla wrote:
>>> Hi Kishore,
>>>
>>> I need ack for this patch from Michal Simek to take this via nvmem tree.
>>
>> not sure if my reaction went through. Just for a record. There is high
>> chance that there is collision in firmware interface. It means if you
>> can ack/review that patches then I would take them via arm-soc trees.
>>
> 
> I got the message! There are outstanding comments on the nvmem patch!

ok thanks.
Michal
