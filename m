Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E76ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3F1920684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="LL4pw8iZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3F1920684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388030AbeGSSoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 14:44:14 -0400
Received: from mail-eopbgr730070.outbound.protection.outlook.com ([40.107.73.70]:35633
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732089AbeGSSoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 14:44:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FSQAkbViVw8S5UjGTvRt5nTrhIo12DkDiPCLXSjM664=;
 b=LL4pw8iZIARVqfEqbN3zOgbTqa11ycqAL44eyEE81SA5lZh136SL+SGoUfHJZJEwopkzLdSD19ynLHNrZTvthNV5sX5yh93vEW628Cg4dsBvd5BaOW+07Icq/emSbcLmk7UAJnv3aHkLhA4El0evQBFJRW5Pe3gYJfhVLyG+PB0=
Received: from SN1PR0701CA0078.namprd07.prod.outlook.com
 (2a01:111:e400:52fd::46) by BN3PR0701MB1330.namprd07.prod.outlook.com
 (2a01:111:e400:4019::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.20; Thu, 19 Jul
 2018 17:59:28 +0000
Received: from DM3NAM05FT051.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::203) by SN1PR0701CA0078.outlook.office365.com
 (2a01:111:e400:52fd::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Thu, 19 Jul 2018 17:59:28 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 DM3NAM05FT051.mail.protection.outlook.com (10.152.98.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.995.0 via Frontend Transport; Thu, 19 Jul 2018 17:59:27 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHxNgD025447
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 19 Jul 2018 10:59:26 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 19 Jul 2018 19:59:31 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 19 Jul 2018 19:59:31 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHxF8J005988;
        Thu, 19 Jul 2018 18:59:15 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6JHxFTK005980;
        Thu, 19 Jul 2018 18:59:15 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 23/31] usb: usbssp: added implementation of transfer events.
Date:   Thu, 19 Jul 2018 18:57:56 +0100
Message-ID: <1532023084-28083-24-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1532023084-28083-1-git-send-email-pawell@cadence.com>
References: <1532023084-28083-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(346002)(39860400002)(2980300002)(36092001)(199004)(189003)(43544003)(36756003)(87636003)(50226002)(478600001)(486006)(50466002)(76176011)(4326008)(8936002)(42186006)(16586007)(316002)(26826003)(86362001)(5660300001)(575784001)(26005)(14444005)(426003)(48376002)(107886003)(1671002)(109986005)(186003)(246002)(8676002)(2616005)(51416003)(336012)(305945005)(476003)(7636002)(126002)(356003)(6666003)(11346002)(446003)(4720700003)(106466001)(105596002)(551934003)(2906002)(54906003)(47776003)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR0701MB1330;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT051;1:nSH3KUaWWKPSL662snU+432bXsTnLNdL6xSX4zHSMXey7YPeKO0sFErJao11wPL4hlIgH4RLzPvA0Fn8POl13FPV1+hz4U+1Zj38aqHqanuZ+pAF39rfYbIgIPMqxf53
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8020bbdd-ab6c-4bb2-488c-08d5eda15eeb
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BN3PR0701MB1330;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1330;3:2cLltF/5LWk2Ld6bQo/xnEXrb0XpSgtZwew6cdVM/n/17jKf+dl0mPDlQYvALX3R6mQTlP8GDMr0TpRxyRKX4PYl0YNLRJU1iozs2oiYgQw8NpVH90qm7Kc7UZBSmFp+CISTP3c4CbPOMbICRhKjSUUxdxByvbyK242rlcWsjhTewGOcXxTXoj0vv5dPSvtMm5quQQtOgdJ8lPrrq8NkN9ELpDP8J0XefWIJGv0tNDlT1XBsAH8Mldd28Wzr2ilzBX/FJngdI8kCBnJ73vt8UB5hAk481e+XUZkabQ2YcZFmXEdM8EmoKh5aZ5oeT4MXW0oiQz+CQ0GHNbfGNydCbui5yU0nDq7IboHcMopx3E4=;25:aK21VWE/Z36/5XLa4iuwMFxc1N6WRqvBXMhLT9yDHcrLCfqvXDv3KOyebRBg2oX/vr5kKHr3vGzxLU3R2RC1+l069KnMpM1eInncauiOA0pjhXyyYBlTn+b681tBwfo5EPEgps9OumUc4gbx59nMmLv0BHDEdA6KUz2k00t+sd8m2Yn3Zdq35EziMmIyDxZ4VjaruMC9EYje8Od5wZKpQA9pGqZHnVMvlWv3wwM/qnpCcbqVJVf6jotxgjEnKA1cEeMfLWNcGnB02vz9wAxRFh/Mdmg9yD08etT9u6ds5ybDWUf1aJennC9VhcmdKs/ql1KT1JNpY3lCFBta4ATZiw==
X-MS-TrafficTypeDiagnostic: BN3PR0701MB1330:
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1330;31:Rh7v2R2NY8eCVGyHjKXjVzFC1U3lxh8UxcdBDbAQKiQMDlG17QPOhomT3t9o2lzkOGuOZkF1DUxAgPBuAY8iUTGOLZHTcfMJnp2L7bknHhD5avViBo+JqcH1VNTWv4au3mWYlqgC5Q9zHji57A/oMg2dYYcMkijN85tpQvaZSvGVx7sN5G2Jm5ht5MamzTMs4xqmblME35pCNHzcLVcz9BefSswUXLvRFzAgcoKKZTU=;20:OmCL4Ot7YoBdXMmicUwylr4i1ofAiXACJCe4hkML7ejho0nnuHL50RtPNdjYeTWtwEv8v7AL+r3fwSv4uo23oAq1P9d+dHPyYUoCJc+aX/+7o3du5OKULcGniJ/wVGemBKb20FACBiY9uKmxKBF/s+muoCibvwNb3dm5CGA5IQXRxyjDxEe1k633A9JMWHmf+AFgHNJMW93TF+qG8+43FAFptyxFIu3+6usOFybDhF+qUme9Nw45KnBl0Nf7a8NxynjLGbsyyY085fvtQZoJv5w+C07msmXg47FZQjvYzSPc2RPGRMdMr4BLUxIOB25iqi2P5el+K+VDBkNwZ4177+nmth8H+o8JLj93BIIph4CYkY1e38B82QIcv1pcJbAKYbKdQ5GYRdyJY4jio88GK6Vqg4idY/AEvysPOuPTyRMf0kYfaRhl0wuUNpzGhd46lsqyvYN5IllVHFZLLnLPwFnbsbYRlgvUpvcy+Erphe2rZDErC608fh+mMBvE6O7Y
X-Microsoft-Antispam-PRVS: <BN3PR0701MB1330B0C60FD83592C5673590DD520@BN3PR0701MB1330.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93003095)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BN3PR0701MB1330;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0701MB1330;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1330;4:rsvNV1dsaCXcC9Lqqf05VIlRBl2eEEOaj/+wYbMccYKZR72ZOuVu4THFU1U3SBqW4J2pCSf9j2AOYvaeAB8e5NY/GrfPSLqShlbjKfGhDWXIwxPfX1yoVu0oplaPIQzkaXTyCnpH+FnFNpr8jTM5rQU8MUiIaJCRd2i8lwRlHRL27f/y5yvIustiir5+22F/785Y4SDgE9wQ+1fJAmLbS4p45odxMVRPBzAYN1Ks0Se+Z0YAxGsltDZCBBc7VKOuLcJgMUuujhFqO5mpLMZGFfKW2NiO4fch620wuAjXSUxXWLVLcUnjPE4pZ0YEty0l
X-Forefront-PRVS: 0738AF4208
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN3PR0701MB1330;23:+8QZwRbiFqNTaNjHYhzbBhaUazJbxGFfI4XZFlY?=
 =?us-ascii?Q?utqMuxsXeY048U5Nv5qZCjh3iS1z4GTur6zlZH/xZPDPvd9V2enuQ9kqLxwg?=
 =?us-ascii?Q?EX/HB7vkkEH0Pnh1ROhHE8fFNs3d45L5CfnkMCbU41GTmdUVhboBEDpHvFLg?=
 =?us-ascii?Q?54qgjcuL24Y82eTHaP75cwaj+lzlRJpWCT1jZ/I883a2cIg0k5NYVp+8Zq9l?=
 =?us-ascii?Q?6fkjQjabHnPDv1dVcYn25Ip31SdqhsGi4cc7DDu1NvkxQycUm4qCgwsou6yG?=
 =?us-ascii?Q?erNzQECRePbr6ff/YV58iH/waVuxjzQqKbHTV+XFwr9e1/izV/WnL0Ssvl7c?=
 =?us-ascii?Q?It/qES/BLaRgDMm3WQOCJRJNTNtoxHV4291O9oZyt033FX6RPye6Xxfp70MI?=
 =?us-ascii?Q?X2/vGOtzet9cXGD1PNbX9ejOyVb3wlLFWWxog3tjFfLRAfuP8ac5CraV3yhY?=
 =?us-ascii?Q?pe5LuGLwuN+w0YdpgfRAkzdchyhwwDQ3Oxxqi/9kZDs04uOkzYtn7KD4SxVL?=
 =?us-ascii?Q?M1XA2tFR60x12xo4H/fREfwmorgX9MZzaG2yzaUjy2KWECaxfFSwy/QXpWxd?=
 =?us-ascii?Q?D4JejpUAGkhptjB5mUj+YYNcGdJY4WDfXWTqttBI0tBSOs4LsYRkIh8W2BcG?=
 =?us-ascii?Q?6/zJlwr3CHIx+4obDJL05fF+gtx2jmg4yCMR8DBXGb1W+SHtYjwtNnhqyLgv?=
 =?us-ascii?Q?n4ptIf5sdFB/zptG4O2bQRjCojlD8z2zoYQ2cNqVfPMRMpSeOfRByMLKglnJ?=
 =?us-ascii?Q?kEXBFUZJkEP+wKm2nVKKUbga+9/DG6+CtYMLp1Cjmsualdl/6SL+OMUd8/K0?=
 =?us-ascii?Q?OLgipKGPQ/YX69KOB2m7akM5PUM0Pwu+44hy3HJMC3RsJ16rmiHrO8Xp1/KJ?=
 =?us-ascii?Q?FUf/6tZ09JC8hobJmc3owKHBUobEQoy21NF6SfT3C2Ld0Vib/R5tXiPf89UV?=
 =?us-ascii?Q?xH6+6MQZIrkUjeh46TnwjhNwZTQdoylRgJprxosKnO+5WJd4jvBnjHrnHm2u?=
 =?us-ascii?Q?UPQ5He4Y7PBhXYhSloVrXcW/MHFGZmBD2anc/EorBEBtF+Pg+wgpwsjz1544?=
 =?us-ascii?Q?mBYL3EDTzMfVa+6FESa1spGLD9uJcKG4fagSSo6ZUYby54zyZiluR0gju4aW?=
 =?us-ascii?Q?hhhCXHgUyjb7dqLQw2pDgzXWG0J92+TfGxfTEkSSev3BAmMxNc1u7keYwvgl?=
 =?us-ascii?Q?nzgC5DuvTApv5ahH+z3DlYvj7Nx4+udH3QuFJkl5mjRJtblWaaSdrPRuK3Q?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: 8aNMwBab2IReWa5yYh5Rpsa1TS9roElJDWf1x3QsxmKwMhYcV7OAp5fMtBqfRPgSPG6JLMBRCvLzXN9u6dEr13bvkt2w8pWXJmh/6XT27MANjL0z/lCNbELgCkea5ilxXn9sEB8nJEScwjrvVoDpeFemdJbc/CSn4ES0tLXxxndr94ERGZgnVGf2L6rR6U2JjtACeXb5NxD16VvDdcguH+tzCMh8gfZC/7OTFlbZC+JGHLU54EG3hBE3ya1buZ0TTPouzokWSZRlxaJy01H8xmWlxfkPF0PAiUAs4N2iTzcuCo69/hhLawV3rWek7dLCO1l8Joh+2nGtm+2yHvtEgEcrMhRvWOFuuZdvYM3cd3eGdwkknd8njp0qnVJXekYPONSQZvKLzs5V5XVz3Vq9tA==
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1330;6:R8Phx5bXWjoT5oDFUgtL0XxwvU+QOFOFX4nec9zVWnQeiEaIjwiaL+J4khxdJ651BnEg8Ah1PAadxHmX9VBFB+v+ezeglVB8J0G0JbBCIhFxYXSfCgUAmNvAGE0YJDY9636EQ+Tn+eVUcET2q6KeoxER618HZ1CIUz2JbtM1zxTE+h+d4F4AEzcmt4kiSHV9jqoZUOEbzKFEJPgqGvJVQq7/QssOyuN6YiZvRRwY8lISvCYkgXseBsupiOFHMK99K8GnHt/qp6tQqRU4on7udrxKc/6xYVS17Tf7iWOaiSbjJDTrBqCRzRMO8H2qz/jeMXFvVivRhYPYwODLqfgfFP1XBUuFqAYzdKjnC42XbRSrsmUClbBB6N97JZNn+QV9fjupcLGcHHvLf7zeKBD09Wcye9TDudfglQ0EISXAY4Zv3O6gx9rW9m9NM0/Plczkh3r78i8vk90rY38ojXV+Xg==;5:iO7WfeM7CvAe+l9526UHfuDBHJvHZp6jg/qMCC0WVQt9EkfyD74HESyv5IWV/qsG7wdaEH2z+pru+tzlcqUOatxEvZojrEzK0L3niKeZlZtosiGMfC0WmrWZc8ULCwAkmElhBLLQkPGRNpidwYHX2EIYA+aVVYI2Mc5RTkFrmMQ=;7:6Hn3G4NLOa2RxOynDreDSmAIOz3ZejSFDenHHronZfeW0dNDs5tdL3Mvqn21xJHyI1BuYpn7E6EZIN2A4UxhXECGUah9FP01E18eRbmWB85AhDkO5RxNkDNgYBWWa51F6HObMBbG8vcV9bfe5saADH6gH+pjDMWDZfp9aOdbiXPoIaEFNuEoXqfpbMKWkfgqtRzMJC9EcpIJSZJ9pdlt44ru25t80gldmt3mGVT+1mSZLHXPhBpFeI6fLeWN6y2j
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1330;20:clspRWW4tJHI4sxhprG/aRpDMlvff4j83ZqjVvXPUqJOEOGV9vz/nWrmd7NWPtD4/cQ3hdqo7eDVlM3GNk0rNcwkAdWirWw+jvwGNVhfIbPoHkhUG/dz1Fruqhmi85GuUTszpt2FBlj3AC38rdMhk7ag9QN9PPkOuW0t0Jt3575TauP2hXW4wTAu4WSnPsT+8mxsi+uxTOfGDB+sZkOGe/nDT18bcxJ/vHQJTVsYhzMLccLYH4cjBZuyjrdiOawL
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2018 17:59:27.7351
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8020bbdd-ab6c-4bb2-488c-08d5eda15eeb
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0701MB1330
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch add functionality related to handling transfer events.
This kind of events are added to event ring after completion transfer.

This patch add supports for handling transfer events only for
control, interrupt and bulk transfer.

After the transfer, usbssp driver release the TD and informs about it
gadget core driver by means of usbssp_gadget_giveback function.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/usbssp/gadget-mem.c  |   9 +
 drivers/usb/usbssp/gadget-ring.c | 602 ++++++++++++++++++++++++++++++-
 drivers/usb/usbssp/gadget.h      |   5 +
 3 files changed, 615 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/usbssp/gadget-mem.c b/drivers/usb/usbssp/gadget-mem.c
index 858bee77b0dc..d5d732b94454 100644
--- a/drivers/usb/usbssp/gadget-mem.c
+++ b/drivers/usb/usbssp/gadget-mem.c
@@ -555,6 +555,15 @@ static void usbssp_free_stream_ctx(struct usbssp_udc *usbssp_data,
 				stream_ctx, dma);
 }
 
+struct usbssp_ring *usbssp_dma_to_transfer_ring(struct usbssp_ep *ep,
+						u64 address)
+{
+	if (ep->ep_state & EP_HAS_STREAMS)
+		return radix_tree_lookup(&ep->stream_info->trb_address_map,
+					 address >> TRB_SEGMENT_SHIFT);
+	return ep->ring;
+}
+
 struct usbssp_ring *usbssp_stream_id_to_ring(struct usbssp_device *dev,
 					     unsigned int ep_index,
 					     unsigned int stream_id)
diff --git a/drivers/usb/usbssp/gadget-ring.c b/drivers/usb/usbssp/gadget-ring.c
index cfb31120eef8..8cc6e4247eef 100644
--- a/drivers/usb/usbssp/gadget-ring.c
+++ b/drivers/usb/usbssp/gadget-ring.c
@@ -62,6 +62,13 @@
 #include "gadget-trace.h"
 #include "gadget.h"
 
+static void giveback_first_trb(struct usbssp_udc *usbssp_data,
+			       unsigned int ep_index,
+			       unsigned int stream_id,
+			       int start_cycle,
+			       struct usbssp_generic_trb
+			       *start_trb);
+
 /*
  * Returns zero if the TRB isn't in this segment, otherwise it returns the DMA
  * address of the TRB.
@@ -80,6 +87,11 @@ dma_addr_t usbssp_trb_virt_to_dma(struct usbssp_segment *seg,
 	return seg->dma + (segment_offset * sizeof(*trb));
 }
 
+static bool trb_is_noop(union usbssp_trb *trb)
+{
+	return TRB_TYPE_NOOP_LE32(trb->generic.field[3]);
+}
+
 static bool trb_is_link(union usbssp_trb *trb)
 {
 	return TRB_TYPE_LINK_LE32(trb->link.control);
@@ -1528,6 +1540,289 @@ int usbssp_is_vendor_info_code(struct usbssp_udc *usbssp_data,
 	return 0;
 }
 
+static int usbssp_td_cleanup(struct usbssp_udc *usbssp_data,
+			     struct usbssp_td *td, struct usbssp_ring *ep_ring,
+			     int *status)
+{
+	struct usbssp_request *req_priv = NULL;
+
+	/* Clean up the endpoint's TD list */
+	req_priv = td->priv_request;
+
+	/* if a bounce buffer was used to align this td then unmap it */
+	usbssp_unmap_td_bounce_buffer(usbssp_data, ep_ring, td);
+
+	/*
+	 * Do one last check of the actual transfer length.
+	 * If the DC controller said we transferred more data than the buffer
+	 * length, req_priv->request.actual will be a very big number (since it's
+	 * unsigned). Play it safe and say we didn't transfer anything.
+	 */
+	if (req_priv->request.actual > req_priv->request.length) {
+		dev_warn(usbssp_data->dev,
+			"USB req %u and actual %u transfer length mismatch\n",
+			req_priv->request.length, req_priv->request.actual);
+		req_priv->request.actual = 0;
+		*status = 0;
+	}
+	list_del_init(&td->td_list);
+
+	inc_td_cnt(req_priv);
+	/* Giveback the USB request when all the tds are completed */
+	if (last_td_in_request(td)) {
+		if ((req_priv->request.actual != req_priv->request.length &&
+		    td->priv_request->request.short_not_ok) || (*status != 0 &&
+		    !usb_endpoint_xfer_isoc(req_priv->dep->endpoint.desc)))
+			dev_dbg(usbssp_data->dev,
+				"Giveback Request %p, len = %d, expected = %d"
+				" status = %d\n",
+				req_priv, req_priv->request.actual,
+				req_priv->request.length, *status);
+
+		if (usb_endpoint_xfer_isoc(req_priv->dep->endpoint.desc))
+			*status = 0;
+
+		usbssp_giveback_request_in_irq(usbssp_data, td, *status);
+	}
+
+	return 0;
+}
+
+static int finish_td(struct usbssp_udc *usbssp_data, struct usbssp_td *td,
+		     struct usbssp_transfer_event *event, struct usbssp_ep *ep,
+		     int *status)
+{
+	struct usbssp_device *dev_priv;
+	struct usbssp_ring *ep_ring;
+	unsigned int slot_id;
+	int ep_index;
+	struct usbssp_ep_ctx *ep_ctx;
+	u32 trb_comp_code;
+
+	slot_id = TRB_TO_SLOT_ID(le32_to_cpu(event->flags));
+	dev_priv = &usbssp_data->devs;
+	ep_index = TRB_TO_EP_ID(le32_to_cpu(event->flags)) - 1;
+	ep_ring = usbssp_dma_to_transfer_ring(ep, le64_to_cpu(event->buffer));
+	ep_ctx = usbssp_get_ep_ctx(usbssp_data, dev_priv->out_ctx, ep_index);
+	trb_comp_code = GET_COMP_CODE(le32_to_cpu(event->transfer_len));
+
+	if (trb_comp_code == COMP_STOPPED_LENGTH_INVALID ||
+	    trb_comp_code == COMP_STOPPED ||
+	    trb_comp_code == COMP_STOPPED_SHORT_PACKET) {
+		/*
+		 * The Endpoint Stop Command completion will take care of any
+		 * stopped TDs. A stopped TD may be restarted, so don't update
+		 * the ring dequeue pointer or take this TD off any lists yet.
+		 */
+		return 0;
+	}
+
+	/* Update ring dequeue pointer */
+	while (ep_ring->dequeue != td->last_trb)
+		inc_deq(usbssp_data, ep_ring);
+
+	inc_deq(usbssp_data, ep_ring);
+
+	return usbssp_td_cleanup(usbssp_data, td, ep_ring, status);
+}
+
+/* sum trb lengths from ring dequeue up to stop_trb, _excluding_ stop_trb */
+static int sum_trb_lengths(struct usbssp_udc *usbssp_data,
+			   struct usbssp_ring *ring,
+			   union usbssp_trb *stop_trb)
+{
+	u32 sum;
+	union usbssp_trb *trb = ring->dequeue;
+	struct usbssp_segment *seg = ring->deq_seg;
+
+	for (sum = 0; trb != stop_trb; next_trb(usbssp_data, ring, &seg, &trb)) {
+		if (!trb_is_noop(trb) && !trb_is_link(trb))
+			sum += TRB_LEN(le32_to_cpu(trb->generic.field[2]));
+	}
+	return sum;
+}
+
+/*
+ * Process control tds, update USB request status and actual_length.
+ */
+static int process_ctrl_td(struct usbssp_udc *usbssp_data, struct usbssp_td *td,
+			   union usbssp_trb *event_trb,
+			   struct usbssp_transfer_event *event,
+			   struct usbssp_ep *ep_priv, int *status)
+{
+	struct usbssp_device *dev_priv;
+	struct usbssp_ring *ep_ring;
+	unsigned int slot_id;
+	int ep_index;
+	struct usbssp_ep_ctx *ep_ctx;
+	u32 trb_comp_code;
+	u32 remaining, requested;
+	u32 trb_type;
+
+	trb_type = TRB_FIELD_TO_TYPE(le32_to_cpu(event_trb->generic.field[3]));
+	slot_id = TRB_TO_SLOT_ID(le32_to_cpu(event->flags));
+	dev_priv = &usbssp_data->devs;
+	ep_index = TRB_TO_EP_ID(le32_to_cpu(event->flags)) - 1;
+	ep_ring = usbssp_dma_to_transfer_ring(ep_priv, le64_to_cpu(event->buffer));
+	ep_ctx = usbssp_get_ep_ctx(usbssp_data, dev_priv->out_ctx, ep_index);
+	trb_comp_code = GET_COMP_CODE(le32_to_cpu(event->transfer_len));
+	requested = td->priv_request->request.length;
+	remaining = EVENT_TRB_LEN(le32_to_cpu(event->transfer_len));
+
+	switch (trb_comp_code) {
+	case COMP_SUCCESS:
+		*status = 0;
+		break;
+	case COMP_SHORT_PACKET:
+		*status = 0;
+		break;
+	case COMP_STOPPED_SHORT_PACKET:
+		if (trb_type == TRB_DATA || trb_type == TRB_NORMAL)
+			td->priv_request->request.actual = remaining;
+	goto finish_td;
+	case COMP_STOPPED:
+		switch (trb_type) {
+		case TRB_DATA:
+		case TRB_NORMAL:
+			td->priv_request->request.actual = requested - remaining;
+			goto finish_td;
+		case TRB_STATUS:
+			td->priv_request->request.actual = requested;
+			goto finish_td;
+		default:
+			dev_warn(usbssp_data->dev,
+				"WARN: unexpected TRB Type %d\n",
+				trb_type);
+			goto finish_td;
+		}
+	case COMP_STOPPED_LENGTH_INVALID:
+		goto finish_td;
+	default:
+		dev_dbg(usbssp_data->dev, "TRB error code %u, "
+			"halted endpoint index = %u\n",
+			trb_comp_code, ep_index);
+	}
+
+	/*
+	 * if on data stage then update the actual_length of the USB
+	 * request and flag it as set, so it won't be overwritten in the event
+	 * for the last TRB.
+	 */
+	if (trb_type == TRB_DATA ||
+	    trb_type == TRB_NORMAL) {
+		td->request_length_set = true;
+		td->priv_request->request.actual = requested - remaining;
+	}
+
+	/* at status stage */
+	if (!td->request_length_set)
+		td->priv_request->request.actual = requested;
+
+	if (usbssp_data->ep0state == USBSSP_EP0_DATA_PHASE
+	   && ep_priv->number == 0
+	   && usbssp_data->three_stage_setup) {
+
+		td = list_entry(ep_ring->td_list.next, struct usbssp_td, td_list);
+		usbssp_data->ep0state = USBSSP_EP0_STATUS_PHASE;
+		dev_dbg(usbssp_data->dev, "Arm Status stage\n");
+		giveback_first_trb(usbssp_data, ep_index, 0,
+				ep_ring->cycle_state, &td->last_trb->generic);
+		return 0;
+	}
+finish_td:
+	return finish_td(usbssp_data, td, event, ep_priv, status);
+}
+
+/*
+ * Process isochronous tds, update usb request status and actual_length.
+ */
+static int process_isoc_td(struct usbssp_udc *usbssp_data, struct usbssp_td *td,
+			   union usbssp_trb *ep_trb,
+			   struct usbssp_transfer_event *event,
+			   struct usbssp_ep *ep_priv, int *status)
+{
+	/*TODO: this function must be implemented*/
+	return 0;
+}
+
+static int skip_isoc_td(struct usbssp_udc *usbssp_data,
+			struct usbssp_td *td,
+			struct usbssp_transfer_event *event,
+			struct usbssp_ep *ep_priv,
+			int *status)
+{
+	/*TODO: this function must be implemented*/
+	return 0;
+}
+
+/*
+ * Process bulk and interrupt tds, update usb request status and actual_length.
+ */
+static int process_bulk_intr_td(struct usbssp_udc *usbssp_data,
+				struct usbssp_td *td,
+				union usbssp_trb *ep_trb,
+				struct usbssp_transfer_event *event,
+				struct usbssp_ep *ep, int *status)
+{
+	struct usbssp_ring *ep_ring;
+	u32 trb_comp_code;
+	u32 remaining, requested, ep_trb_len;
+
+	ep_ring = usbssp_dma_to_transfer_ring(ep, le64_to_cpu(event->buffer));
+	trb_comp_code = GET_COMP_CODE(le32_to_cpu(event->transfer_len));
+	remaining = EVENT_TRB_LEN(le32_to_cpu(event->transfer_len));
+	ep_trb_len = TRB_LEN(le32_to_cpu(ep_trb->generic.field[2]));
+	requested = td->priv_request->request.length;
+
+	switch (trb_comp_code) {
+	case COMP_SUCCESS:
+		/* handle success with untransferred data as short packet */
+		if (ep_trb != td->last_trb || remaining) {
+			dev_warn(usbssp_data->dev, "WARN Successful completion "
+				"on short TX\n");
+			dev_dbg(usbssp_data->dev,
+				"ep %#x - asked for %d bytes, %d bytes untransferred\n",
+				td->priv_request->dep->endpoint.desc->bEndpointAddress,
+				requested, remaining);
+		}
+		*status = 0;
+		break;
+	case COMP_SHORT_PACKET:
+		dev_dbg(usbssp_data->dev,
+			"ep %#x - asked for %d bytes, %d bytes untransferred\n",
+			 td->priv_request->dep->endpoint.desc->bEndpointAddress,
+			 requested, remaining);
+
+		*status = 0;
+		break;
+	case COMP_STOPPED_SHORT_PACKET:
+		td->priv_request->request.length = remaining;
+		goto finish_td;
+	case COMP_STOPPED_LENGTH_INVALID:
+		/* stopped on ep trb with invalid length, exclude it */
+		ep_trb_len = 0;
+		remaining = 0;
+		break;
+	default:
+		/* Others already handled above */
+		break;
+	}
+
+	if (ep_trb == td->last_trb)
+		td->priv_request->request.actual = requested - remaining;
+	else
+		td->priv_request->request.actual =
+			sum_trb_lengths(usbssp_data, ep_ring, ep_trb) + ep_trb_len - remaining;
+finish_td:
+	if (remaining > requested) {
+		dev_warn(usbssp_data->dev,
+			"bad transfer trb length %d in event trb\n",
+			remaining);
+		td->priv_request->request.actual = 0;
+	}
+
+	return finish_td(usbssp_data, td, event, ep, status);
+}
 /*
  * If this function returns an error condition, it means it got a Transfer
  * event with a corrupted Slot ID, Endpoint ID, or TRB DMA address.
@@ -1536,8 +1831,313 @@ int usbssp_is_vendor_info_code(struct usbssp_udc *usbssp_data,
 static int handle_tx_event(struct usbssp_udc *usbssp_data,
 			   struct usbssp_transfer_event *event)
 {
-	/*TODO: implement function handling transfer event*/
+	struct usbssp_device *dev_priv;
+	struct usbssp_ep *ep_priv;
+	struct usbssp_ring *ep_ring;
+	unsigned int slot_id;
+	int ep_index;
+	struct usbssp_td *td = NULL;
+	dma_addr_t ep_trb_dma;
+	struct usbssp_segment *ep_seg;
+	union usbssp_trb *ep_trb;
+	int status = -EINPROGRESS;
+	struct usbssp_ep_ctx *ep_ctx;
+	struct list_head *tmp;
+	u32 trb_comp_code;
+	int ret = 0;
+	int td_num = 0;
+	bool handling_skipped_tds = false;
+	const struct usb_endpoint_descriptor *desc;
+
+	slot_id = TRB_TO_SLOT_ID(le32_to_cpu(event->flags));
+	ep_index = TRB_TO_EP_ID(le32_to_cpu(event->flags)) - 1;
+	trb_comp_code = GET_COMP_CODE(le32_to_cpu(event->transfer_len));
+	ep_trb_dma = le64_to_cpu(event->buffer);
+
+	dev_priv = &usbssp_data->devs;
+
+	ep_priv = &dev_priv->eps[ep_index];
+	ep_ring = usbssp_dma_to_transfer_ring(ep_priv, le64_to_cpu(event->buffer));
+	ep_ctx = usbssp_get_ep_ctx(usbssp_data, dev_priv->out_ctx, ep_index);
+
+	if (GET_EP_CTX_STATE(ep_ctx) == EP_STATE_DISABLED) {
+		dev_err(usbssp_data->dev,
+			"ERROR Transfer event for disabled endpoint slot %u ep %u\n",
+			slot_id, ep_index);
+		goto err_out;
+	}
+
+	/* Some transfer events don't always point to a trb*/
+	if (!ep_ring) {
+		switch (trb_comp_code) {
+		case COMP_USB_TRANSACTION_ERROR:
+		case COMP_INVALID_STREAM_TYPE_ERROR:
+		case COMP_INVALID_STREAM_ID_ERROR:
+			goto cleanup;
+		case COMP_RING_UNDERRUN:
+		case COMP_RING_OVERRUN:
+			goto cleanup;
+		default:
+			dev_err(usbssp_data->dev, "ERROR Transfer event for "
+				"unknown stream ring slot %u ep %u\n",
+				 slot_id, ep_index);
+			goto err_out;
+		}
+	}
+
+	/* Count current td numbers if ep->skip is set */
+	if (ep_priv->skip) {
+		list_for_each(tmp, &ep_ring->td_list)
+			td_num++;
+	}
+
+	/* Look for common error cases */
+	switch (trb_comp_code) {
+	/*
+	 * Skip codes that require special handling depending on
+	 * transfer type
+	 */
+	case COMP_SUCCESS:
+		if (EVENT_TRB_LEN(le32_to_cpu(event->transfer_len)) == 0)
+			break;
+
+		dev_warn_ratelimited(usbssp_data->dev,
+			"WARN Successful completion on short TX\n");
+	case COMP_SHORT_PACKET:
+		break;
+	case COMP_STOPPED:
+		dev_dbg(usbssp_data->dev, "Stopped on Transfer TRB for ep %u\n",
+			ep_index);
+		break;
+	case COMP_STOPPED_LENGTH_INVALID:
+		dev_dbg(usbssp_data->dev,
+			"Stopped on No-op or Link TRB for ep %u\n",
+			ep_index);
+		break;
+	case COMP_STOPPED_SHORT_PACKET:
+		dev_dbg(usbssp_data->dev,
+			"Stopped with short packet transfer detected for ep %u\n",
+			ep_index);
+		break;
+	case COMP_BABBLE_DETECTED_ERROR:
+		dev_dbg(usbssp_data->dev, "Babble error for ep %u on endpoint\n",
+			ep_index);
+		status = -EOVERFLOW;
+		break;
+	case COMP_TRB_ERROR:
+		dev_warn(usbssp_data->dev, "WARN: TRB error on endpoint %u\n",
+			ep_index);
+		status = -EILSEQ;
+		break;
+	/* completion codes not indicating endpoint state change */
+	case COMP_DATA_BUFFER_ERROR:
+		dev_warn(usbssp_data->dev,
+			"WARN: USBSSP couldn't access mem fast enough for ep %u\n",
+			ep_index);
+		status = -ENOSR;
+		break;
+	case COMP_ISOCH_BUFFER_OVERRUN:
+		dev_warn(usbssp_data->dev,
+			"WARN: buffer overrun event for ep %u on endpoint",
+			ep_index);
+		break;
+	case COMP_RING_UNDERRUN:
+		/*
+		 * When the Isoch ring is empty, the DC will generate
+		 * a Ring Overrun Event for IN Isoch endpoint or Ring
+		 * Underrun Event for OUT Isoch endpoint.
+		 */
+		dev_dbg(usbssp_data->dev, "underrun event on endpoint\n");
+		if (!list_empty(&ep_ring->td_list))
+			dev_dbg(usbssp_data->dev, "Underrun Event for ep %d "
+				"still with TDs queued?\n", ep_index);
+		goto cleanup;
+	case COMP_RING_OVERRUN:
+		dev_dbg(usbssp_data->dev, "overrun event on endpoint\n");
+		if (!list_empty(&ep_ring->td_list))
+			dev_dbg(usbssp_data->dev, "Overrun Event for ep %d "
+				"still with TDs queued?\n",
+				ep_index);
+		goto cleanup;
+	case COMP_MISSED_SERVICE_ERROR:
+		/*
+		 * When encounter missed service error, one or more isoc tds
+		 * may be missed by DC.
+		 * Set skip flag of the ep_ring; Complete the missed tds as
+		 * short transfer when process the ep_ring next time.
+		 */
+		ep_priv->skip = true;
+		dev_dbg(usbssp_data->dev,
+			"Miss service interval error for ep %u, set skip flag\n",
+			ep_index);
+		goto cleanup;
+	case COMP_INCOMPATIBLE_DEVICE_ERROR:
+		/* needs disable slot command to recover */
+		dev_warn(usbssp_data->dev,
+			"WARN: detect an incompatible device for ep %u",
+			ep_index);
+		status = -EPROTO;
+		break;
+	default:
+		if (usbssp_is_vendor_info_code(usbssp_data, trb_comp_code)) {
+			status = 0;
+			break;
+		}
+
+		dev_warn(usbssp_data->dev,
+			"ERROR Unknown event condition %u, for ep %u - USBSSP probably busted\n",
+			trb_comp_code, ep_index);
+		goto cleanup;
+	}
+
+	do {
+		/*
+		 * This TRB should be in the TD at the head of this ring's TD
+		 * list.
+		 */
+		if (list_empty(&ep_ring->td_list)) {
+			/*
+			 * Don't print wanings if it's due to a stopped endpoint
+			 * generating an extra completion event if the device
+			 * was suspended. Or, a event for the last TRB of a
+			 * short TD we already got a short event for.
+			 * The short TD is already removed from the TD list.
+			 */
+			if (!(trb_comp_code == COMP_STOPPED ||
+			    trb_comp_code == COMP_STOPPED_LENGTH_INVALID ||
+			    ep_ring->last_td_was_short)) {
+				dev_warn(usbssp_data->dev,
+					"WARN Event TRB for ep %d with no TDs queued?\n",
+					ep_index);
+			}
+
+			if (ep_priv->skip) {
+				ep_priv->skip = false;
+				dev_dbg(usbssp_data->dev,
+					"td_list is empty while skip "
+					"flag set. Clear skip flag for ep %u.\n",
+					ep_index);
+			}
+			goto cleanup;
+		}
+
+		/* We've skipped all the TDs on the ep ring when ep->skip set */
+		if (ep_priv->skip && td_num == 0) {
+			ep_priv->skip = false;
+			dev_dbg(usbssp_data->dev,
+				"All tds on the ep_ring skipped. "
+				"Clear skip flag for ep %u.\n", ep_index);
+			goto cleanup;
+		}
+
+		td = list_entry(ep_ring->td_list.next, struct usbssp_td, td_list);
+
+		if (ep_priv->skip)
+			td_num--;
+
+		/* Is this a TRB in the currently executing TD? */
+		ep_seg = usbssp_trb_in_td(usbssp_data, ep_ring->deq_seg,
+					ep_ring->dequeue, td->last_trb,
+					ep_trb_dma, false);
+
+		/*
+		 * Skip the Force Stopped Event. The event_trb(ep_trb_dma)
+		 * of FSE is not in the current TD pointed by ep_ring->dequeue
+		 * because that the hardware dequeue pointer still at the
+		 * previous TRB of the current TD. The previous TRB maybe a
+		 * Link TD or the last TRB of the previous TD. The command
+		 * completion handle will take care the rest.
+		 */
+		if (!ep_seg && (trb_comp_code == COMP_STOPPED ||
+		    trb_comp_code == COMP_STOPPED_LENGTH_INVALID)) {
+			goto cleanup;
+		}
+
+		desc = td->priv_request->dep->endpoint.desc;
+		if (!ep_seg) {
+			if (!ep_priv->skip || !usb_endpoint_xfer_isoc(desc)) {
+
+				/* USBSSP is busted, give up! */
+				dev_err(usbssp_data->dev,
+					"ERROR Transfer event TRB DMA ptr not "
+					"part of current TD ep_index %d "
+					"comp_code %u\n", ep_index,
+					trb_comp_code);
+
+				usbssp_trb_in_td(usbssp_data, ep_ring->deq_seg,
+					ep_ring->dequeue, td->last_trb,
+					ep_trb_dma, true);
+				return -ESHUTDOWN;
+			}
+
+			ret = skip_isoc_td(usbssp_data, td, event, ep_priv,
+					&status);
+			goto cleanup;
+		}
+
+		if (trb_comp_code == COMP_SHORT_PACKET)
+			ep_ring->last_td_was_short = true;
+		else
+			ep_ring->last_td_was_short = false;
+
+		if (ep_priv->skip) {
+			dev_dbg(usbssp_data->dev,
+				"Found td. Clear skip flag for ep %u.\n",
+				ep_index);
+			ep_priv->skip = false;
+		}
+
+		ep_trb = &ep_seg->trbs[(ep_trb_dma - ep_seg->dma) / sizeof(*ep_trb)];
+
+		trace_usbssp_handle_transfer(ep_ring,
+					(struct usbssp_generic_trb *) ep_trb);
+
+		if (trb_is_noop(ep_trb)) {
+			dev_dbg(usbssp_data->dev,
+				"event_trb is a no-op TRB. Skip it\n");
+			goto cleanup;
+		}
+
+		if (usb_endpoint_xfer_control(desc)) {
+			ret = process_ctrl_td(usbssp_data, td, ep_trb, event,
+					ep_priv, &status);
+		} else if (usb_endpoint_xfer_isoc(desc)) {
+			ret = process_isoc_td(usbssp_data, td, ep_trb,
+					event, ep_priv, &status);
+		} else {
+			ret = process_bulk_intr_td(usbssp_data, td, ep_trb,
+						event, ep_priv, &status);
+		}
+cleanup:
+		handling_skipped_tds = ep_priv->skip &&
+			trb_comp_code != COMP_MISSED_SERVICE_ERROR;
+
+		/*
+		 * Do not update event ring dequeue pointer if we're in a loop
+		 * processing missed tds.
+		 */
+		if (!handling_skipped_tds)
+			inc_deq(usbssp_data, usbssp_data->event_ring);
+	/*
+	 * If ep->skip is set, it means there are missed tds on the
+	 * endpoint ring need to take care of.
+	 * Process them as short transfer until reach the td pointed by
+	 * the event.
+	 */
+	} while (handling_skipped_tds);
+
 	return 0;
+
+err_out:
+	dev_err(usbssp_data->dev, "@%016llx %08x %08x %08x %08x\n",
+		 (unsigned long long) usbssp_trb_virt_to_dma(
+					usbssp_data->event_ring->deq_seg,
+					usbssp_data->event_ring->dequeue),
+		 lower_32_bits(le64_to_cpu(event->buffer)),
+		 upper_32_bits(le64_to_cpu(event->buffer)),
+		 le32_to_cpu(event->transfer_len),
+		 le32_to_cpu(event->flags));
+	return -ENODEV;
 }
 
 /*
diff --git a/drivers/usb/usbssp/gadget.h b/drivers/usb/usbssp/gadget.h
index 000f2cb93723..c4e440db6b23 100644
--- a/drivers/usb/usbssp/gadget.h
+++ b/drivers/usb/usbssp/gadget.h
@@ -1699,6 +1699,11 @@ int usbssp_ring_expansion(struct usbssp_udc *usbssp_data,
 struct usbssp_ring *usbssp_stream_id_to_ring(struct usbssp_device *dev,
 					unsigned int ep_index,
 					unsigned int stream_id);
+struct usbssp_ring *usbssp_dma_to_transfer_ring(struct usbssp_ep *ep,
+						u64 address);
+struct usbssp_ring *usbssp_stream_id_to_ring(struct usbssp_device *dev,
+					unsigned int ep_index,
+					unsigned int stream_id);
 
 struct usbssp_command *usbssp_alloc_command(struct usbssp_udc *usbssp_data,
 					bool allocate_completion,
-- 
2.17.1

