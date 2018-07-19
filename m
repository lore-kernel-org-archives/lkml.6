Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C804C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D7320856
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="QaJHiK8X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3D7320856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387855AbeGSSnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 14:43:49 -0400
Received: from mail-sn1nam02on0040.outbound.protection.outlook.com ([104.47.36.40]:22848
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731661AbeGSSns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 14:43:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrbcjVP7DtiPDApvLyOItGVSRiWF3x1FRaG0c+O9qu0=;
 b=QaJHiK8X5pPJacb+HoWxpnmVJ6nf5CueB2mq48+rc51Rd/hMTyl1sAUqHhsIHgHodliBqXZ2T81e/tYtOtdw+aWZ9eGBy14uZkzp7vzWxr24HHIrdxO2HfxWcIar02HrDV+I4KlZadgJoJaXFDe/u/79I80523spf7gUaVpRD8E=
Received: from DM6PR07CA0034.namprd07.prod.outlook.com (2603:10b6:5:94::47) by
 BY2PR07MB2293.namprd07.prod.outlook.com (2a01:111:e400:c50d::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.19; Thu, 19 Jul
 2018 17:59:29 +0000
Received: from BY2NAM05FT038.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::206) by DM6PR07CA0034.outlook.office365.com
 (2603:10b6:5:94::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.21 via Frontend
 Transport; Thu, 19 Jul 2018 17:59:28 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 BY2NAM05FT038.mail.protection.outlook.com (10.152.100.175) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.20.995.0 via
 Frontend Transport; Thu, 19 Jul 2018 17:59:28 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHxNgF025447
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 19 Jul 2018 10:59:27 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 19 Jul 2018 19:59:31 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 19 Jul 2018 19:59:31 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHxGYZ006035;
        Thu, 19 Jul 2018 18:59:16 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6JHxGqq006016;
        Thu, 19 Jul 2018 18:59:16 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 25/31] usb: usbssp: added implementation of usbssp interface.
Date:   Thu, 19 Jul 2018 18:57:58 +0100
Message-ID: <1532023084-28083-26-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1532023084-28083-1-git-send-email-pawell@cadence.com>
References: <1532023084-28083-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(346002)(376002)(2980300002)(189003)(199004)(36092001)(8936002)(50226002)(6666003)(4720700003)(8676002)(7636002)(305945005)(356003)(246002)(105596002)(106466001)(87636003)(2906002)(4326008)(47776003)(478600001)(50466002)(48376002)(26826003)(1671002)(5660300001)(109986005)(107886003)(36756003)(42186006)(186003)(51416003)(11346002)(54906003)(336012)(426003)(446003)(16586007)(126002)(2616005)(76176011)(476003)(19627235002)(486006)(26005)(14444005)(575784001)(316002)(86362001)(266003)(309714004);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR07MB2293;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM05FT038;1:3wBlkYvE6JUfS0eE1wsCjtm02KCCX+WPmzIbS7Z6Pu6QtW3TLsLHv/+5neSDhS3PDnBbAmf7O3ZVL51tONHPtdeRh8qCOg3Bs9Ear9BNrNG9HHnEBICQ8HqX49STBaDN
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6395709-25de-45d2-6c7f-08d5eda15f1a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BY2PR07MB2293;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2293;3:v96bvs8jjteky6fTHhKqFV/EYLnFgeZeqjH+AJlUXDN07jyHjzh9Dh7HkF1wat0nOaQdtNzPUPduLwvHJ7aSqE7k/+lJfNQU2Yfu+ODExaVpk4Rw6tPxqKZwZ+DHPyQPP0Q4PDmVyVf7J1fpVMFnueiJhuP5nqaEqO4inSGs5xFS6xKcWNqbvpZuX+87HMPt7UvlQ+fdZVy/l5mbE0Txcb/BX16ZyG91qq9e9DPp0ECMCKA9cgvnLTY6o8fz8fHR/HQd27JumlrZK+jTqeAVPVZOjMgsImLwiagmgu3G0XzMJDfVDUt40NxIvsKO9histX3EYD72uKkqLSk4tz7tR4Ry+qvOtnsanYfcILFoT3Y=;25:7lNOfxlmrcRaNIxijCMl07o89auewiCuxVNjj+trA24/SuTC20U2se5Q9h1pmFSUPvbLHZs+hw8sib0G/XryATVxf2cNsDkMASFIk9Fb3fcknhuIv7t8b6ZDPZPuXKKJq20XrV2/M5nkL6iSe3HO+0st8iGh6wFVhgaxeL8mOGPD5TgVPettonqI4wtvUY6jblC6D+TSzYZF6X1oQ3YmZIF46ZOYWTLGZnsCoPJdyqyWlWoranwsQQ9kvoaXUNIwsW2kcdwFanqa5meNPUS+PlMiDVFZH6LqB8z/D4RTP/+pep6SyO70wFIpDQhOf2nnK1f7Y9jK+HSPFd8u00/bcQ==
X-MS-TrafficTypeDiagnostic: BY2PR07MB2293:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2293;31:Nr3utrWj78HE07FyUMrQ8/WqxPoquKXkP/xPOesVHVSWSfYTWHIojW6WVgi8PpOP3jGScYuaLmYwXl/OlhqTQvfXM0Q/AihK7Pe7IL3Pn+Ga0dR9R1+BxP9G+QRYIVFJVEKPJbvOXF8CmryX1ovgaC2BV1wnha7kcTSYhKL9g9UXgksi7EZP0iKo2ZDLdwvtB4bKzioFVIOWKjDWfkbWWxARgaV44PVECnfKWEnYB0I=;20:8eGswsiBPlEAbi+YmLos2zF0cYyNIhW0e+eXgFacW7z4joGKqAudsfhmSHQcCbmBy99lmlxcQOoCuYtNHtFbb244KPyXU1Ekbj7SMinxFCOA5O8U0H5h2ixMkwNgnlPCrXwWGwtdbBoZrMtPW0zOUOX5EsD9RVUokWxJOxAlSDwurx72ehhQK45RLe6VidUe9xmOECY5kf0yWsoZ1m9pP/qbQ78G0EtlzIAN2sB4MlYB4BB8BWbmjAr/j233fZ1r6f72vvuZqzad53biemEiESWYJD5LKk5Vi5b2sXjreIPtqBNYb+f4FfVBDJQ18IFXPBrdm2x5EOa96zPU96i4/auAPKn67LSYJF6b53CMp0WwtxaPvYplp7ainPbbAe79rsa7Nayt9PKAy7uGjTnmhGFzVh1z4D8z8x4zWjFU0+1WN3R5DJrWdwDDsepaU3IBnMMIXiBsTyHG06v6L+Hxx9mz5z10K33/z5EpiIWgeObUgx0jCyjp6arhHtbM1hlE
X-Microsoft-Antispam-PRVS: <BY2PR07MB229343527044B900BDFB4E00DD520@BY2PR07MB2293.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93003095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BY2PR07MB2293;BCL:0;PCL:0;RULEID:;SRVR:BY2PR07MB2293;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2293;4:Kwx7BLKDggXBKT6A5xhzKgY6yTeRusrmQbPULAX7PzNJKwuTdjzWJ5HzwIRiu/ol2c2fdNZXEd1umFUnesKmCZNFe840ecagU5N9MDRdKSzv3AdWYsqryKOVYFIUOus/N4Ql7E89S1AFm3xclFXq7tgyIhbifxKhf1o1ZBZBTW62Zb1INesPkJV+cN5AqtOg0fOgX3NmLJOy6m6QeXp19w7M6YUfEkI3+edZhjwZ57bt4y51TZNJEeHIwXGxOM8shN5DD/a1Oz9+5vBcH2gTlLp/sNaT1FNugL8HhyN/7feiQgl4NyEjvLUR0Enjrz2a
X-Forefront-PRVS: 0738AF4208
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR07MB2293;23:I6xpn+/Wi6DGlHZ6nfElTaZshqZo76a8h6//xWy22?=
 =?us-ascii?Q?lzix/kqy2zRU4aLiw8tqC475i7+Fazm/KtfDJLiDfKsWxUmpynqNhCAaxd84?=
 =?us-ascii?Q?HoDHwKeqRev7ERlgwoIWYy7JlSVxtj3zaaQW5x5APt/0T0RQp2kSMk/xdJKL?=
 =?us-ascii?Q?rsZQOT+CxvVzY23/cC2MhXl0X/JRR/xxWQIB5WuxWohhwMy0JGoZNW+RpG2j?=
 =?us-ascii?Q?SJbTGpO3ipMu7b9TDk2PdvUrENgY2fTg/DGLFvWFsh1USy56QSTjhPjFnWo+?=
 =?us-ascii?Q?cZnW+M0gTpXxWbRwYKTnU0G/3tDc0oUJwo7ZUYlAd9dMkIP81He1lYF+6Lhc?=
 =?us-ascii?Q?j5HyBgdRXRIPE10sRgEtwQwx+9y49xlrFib02bdlldz7CKEYEpyEFaP0h0OQ?=
 =?us-ascii?Q?OBz0DXNsY+LjR02OYMGZwXMKf62Kkl8OqyFRGZXNmaeP1QSLYLUOLDgZqJJK?=
 =?us-ascii?Q?2lNZM08dZ/bW7x7cBlR5W873MceaPHdMMw3pV6bvlATPIN/a4QzhpBVtw98s?=
 =?us-ascii?Q?I5rXVg++HqooA42MCl29Ru6J6/dUM8wGEBORcgCqHfSD+33RmZNEqCb1fAlp?=
 =?us-ascii?Q?lmO1fETB6rcOUARiRVmYDgtoZqKzdqRliQuiNF09GAplEo/AmdKkwT8PShLg?=
 =?us-ascii?Q?QLVjNdl1/zosGIJ8Q1EO4DMV3AppJeAVa5kNeaS+LFMHTzOB0M59rhLKN1+V?=
 =?us-ascii?Q?o205jD7mRy+Z4nIGyWnXahhVo8fp9rk6y6t38cbu6qh08Sgil6YZFV4Hol+n?=
 =?us-ascii?Q?t/60K5C9nbILAJ3WdUitMFCdsy/IsF7Fz54znYkpJg8UV5KFI0J1cB6tV1dB?=
 =?us-ascii?Q?E+MBcIWgylTOQWoltEsXxOPutH8QqjqcsNHvmtch/xw7Xxv/YX/QzDosUup1?=
 =?us-ascii?Q?Y9neBpAdqWL/ErBXE9bQ59ScwZNYFagRULNRY389tHNJzwU/iUzBwV1YAESI?=
 =?us-ascii?Q?eO7bofI2yJrH37CAolO6+2XrEx/qy3Q/SN54ukx1F0FPz7eDLc2eYJTK7I8/?=
 =?us-ascii?Q?EF8+xKAdBldDZjllCh3VgYUFzBJphOv9idAYqe3wO4YtW+f8bo8jb0yZFMcf?=
 =?us-ascii?Q?5JEDGjyq8hJbi5Fvz6CqrQHfToaOtDANifB+Xfd9iYVJi5X6p9ocHvj7Gvx4?=
 =?us-ascii?Q?2yv4w9InLyKfl772Gpku41rDMNn7az9VXi+vggr1kP50JmxCbCK0huOvqz/j?=
 =?us-ascii?Q?En0x5T7egmQJqhyYDEBE1HWbix+Yc2YyKYUh+NAsZEsFOgOINl83OcVRA=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: N8vA7jU0TkjTFiE1LSi5MSMLIxEEyviU7x9v/6OO+J7mp5D2HNn6/ZxnDGNGYmN2vyDy66yqXWDWX5aaSjRSMznYRgBjqpY+tq5Jv9b1oPqt4EXUgNdl+yYWfQAFa1WxlgYYd/4q/ciuneWJPUmVKvaAIAuOZ/MK6GB8Rz7q7OxUdXqLo3bTs0z2cT+gJNVNNcuh+1FhXha3hnNQAbM0SrwPlBMBHhs4Ato5oOtgXRA4Lknf8dHBupkRZRq1M7RC9iBlRZAlrLQJl65sTBGKOUSzmvsN3lfiv9pWe5/xB4gy69PQugnLlCqcW3kbi+OZ/+Tv5ECOi58n9vu3agHWr4ovR/S53gW+e1lNo3o/S7AGMOcGqlVNtlSRicGExiv7tOR6kHCdLFWpx/Fx/tt7FQ==
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2293;6:oMqjV7VD5zGnvTmEjL92yt880q8ofinorc1gjTsWDI9Brvv1fqp1jmB/+5MjVJZLvUhIMWqiInFaPD4rtYyILvBoMNxRyU2+/F8zyiqgrW3yw7OVmlnHZB5Dnr618BfDcISSqRc8znFBOLYVtlSDmm/EtSO3PMHiOVJYRFsmCkAabntqvFp+PGNHGh4l9IPOkvZ0hp1BrU+tnnnpG+hcMq3gCNyAmJXJEbW/xGM9vvZ31RNn6oMUjabupR5TJ1ISpNdi8E5EiD9etIGC1CaAD4QqXzRDm1GYBjln1WwKvDYl3b5AJqqu6CKgwR8wkaZWkN8lDmx6D1yf5FJ4zVBkDmbA84gjel6ylhRfh+5SLjku/CDEuWtWsCkoQ6nYwciTNUd/ilEFYu5/uc75TMWJ6ej7mLiAmK86qw6x3u3M38Ng/pbc/zQjxJ0fP+kPBVDFLvuYGVmS1gDkn+ul9Ykw6A==;5:pYaXSVZOcui0oyDRANy9nbllwded5oDxOa+OgO6JNKQclFQQquR8dliXAOvZY9U6ndBdQ/h0D81hNSRtsgS3NavCQFCo5NQNXvmzN9gsqLhfBSfZCM6G+6vhHxzmKSjpkw6o0Tz8PSr4BTu1OrdBvd9PWPa7H7O0Tkf9/m0O45E=;24:llaRX6B8I7Wt1ytvjXu6Tni5+jRZlTXd2RXKqMGGkJsIGglrtIynHpOH0stUGgrJnJNkc6GgiCfWfm2/pD7mTqWRUJgphzgdrPZjNyhIJW0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2293;7:an7BWGYwZNjwhC1zISNITnPZpTVG8IOnjZnkHzK3qRYtW3VaENtvxj+ra4Z3aLh6hILwq/Qz7G4rPEb0UuczsnS0lgKr5t6bbWD3+9snx2uYFLixM4LZF0SqAmjdxVoU065jGfwaJCXTAZkb6rxQyBUF+q05URD3kic9+C+Uuzf4XBl+5c/7ZU1uCfOCEN4ypxn2kieLPzXlzYX75AYpMn2EmRRGaen+vFPRWxC+NeBszE/NZLBlhiyU/2Zidmqc;20:wI0CDCvShLABBa8BA3TGd9+NNqrG7CPfHbpLFvYddXy2F5XEMNWNI71CrXl+vH8L1YHYwFgXELzNpzRmU7VmhwC/WP0M87HdPjz/Yj2p6QclHwNPqab25A1go6YmHd76U2M1yzWo0lIM8Q6liMbMQxZviuluqyVSQcgBppgBSHnb+urqlWD2PSHNW5wqVi38bRsgdw4CY/eoFER499rglrXT50i3tTvvsoCqH0WW4RRpX7LSX9Z2azfA7MRKAHg+
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2018 17:59:28.3252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6395709-25de-45d2-6c7f-08d5eda15f1a
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR07MB2293
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch add implementation of most function from usb_ep_ops and
usbssp_gadget_ops objects. The implementation of
usbssp_gadget_ep_enable and usbssp_gadget_ep_disable functions
will be added as separate patch.

Patch also adds usbssp_g_lock and usbssp_g_unlock macros.
They are responsible for proper handling of semaphores.
Some functions belonging to usb_ep_ops and usbssp_gadget_ops
can be invoked from some different context.
In usbssp driver we have Hard Irq interrupt context and deferred interrupt
context (thread context). Additionally, driver in thread context can
calls commands on which ends it must wait and must enable
interrupts to detect completion.
Therefor when driver is waiting for command completion, the new event can
be reported and driver starts handling it in Hard Irq context.
Therefor driver use two separate SpinLock objects. The first usbssp->lock
is used in Hard Irq context and second usbssp->irq_thread_lock is used
in kernel thread context.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/usbssp/gadget-if.c | 182 +++++++++++++++++++++++++--------
 drivers/usb/usbssp/gadget.c    | 104 +++++++++++++++++++
 2 files changed, 246 insertions(+), 40 deletions(-)

diff --git a/drivers/usb/usbssp/gadget-if.c b/drivers/usb/usbssp/gadget-if.c
index dbff5a400676..376e03b7ef1f 100644
--- a/drivers/usb/usbssp/gadget-if.c
+++ b/drivers/usb/usbssp/gadget-if.c
@@ -7,11 +7,35 @@
  * Author: Pawel Laszczak
  *
  */
-
+#include <linux/pm_runtime.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb/composite.h>
 #include "gadget.h"
 
+#define usbssp_g_lock(flag, save_flags) { \
+	if (in_interrupt()) {\
+		spin_lock_irqsave(&usbssp_data->lock, save_flags); \
+	} else { \
+		if (!irqs_disabled()) { \
+			spin_lock_irqsave(&usbssp_data->irq_thread_lock,\
+					usbssp_data->irq_thread_flag);\
+			flag = 1; \
+		} else \
+			spin_lock(&usbssp_data->irq_thread_lock); \
+	} }
+
+
+#define usbssp_g_unlock(flag, save_flags) { \
+	if (in_interrupt()) \
+		spin_unlock_irqrestore(&usbssp_data->lock, save_flags); \
+	else { \
+		if (flag) \
+			spin_unlock_irqrestore(&usbssp_data->irq_thread_lock,\
+					usbssp_data->irq_thread_flag);\
+		else \
+			spin_unlock(&usbssp_data->irq_thread_lock); \
+	} }
+
 static int usbssp_gadget_ep_enable(struct usb_ep *ep,
 				   const struct usb_endpoint_descriptor *desc)
 {
@@ -40,24 +64,27 @@ int usbssp_gadget_ep_disable(struct usb_ep *ep)
 static struct usb_request *usbssp_gadget_ep_alloc_request(struct usb_ep *ep,
 							  gfp_t gfp_flags)
 {
+	struct usbssp_request *req_priv;
 	struct usbssp_ep *ep_priv = to_usbssp_ep(ep);
 
-	if (!ep_priv)
+	req_priv = kzalloc(sizeof(*req_priv), gfp_flags);
+	if (!req_priv)
 		return NULL;
 
-	/*TODO: implements this function*/
-	return NULL;
+	req_priv->epnum = ep_priv->number;
+	req_priv->dep = ep_priv;
+
+	trace_usbssp_alloc_request(&req_priv->request);
+	return &req_priv->request;
 }
 
 static void usbssp_gadget_ep_free_request(struct usb_ep *ep,
 					  struct usb_request *request)
 {
-	struct usbssp_ep *ep_priv = to_usbssp_ep(ep);
+	struct usbssp_request *req_priv = to_usbssp_request(request);
 
-	if (!ep_priv)
-		return;
-
-	/*TODO: implements this function*/
+	trace_usbssp_free_request(&req_priv->request);
+	kfree(req_priv);
 }
 
 static int usbssp_gadget_ep_queue(struct usb_ep *ep,
@@ -65,12 +92,32 @@ static int usbssp_gadget_ep_queue(struct usb_ep *ep,
 				  gfp_t gfp_flags)
 {
 	struct usbssp_ep *ep_priv = to_usbssp_ep(ep);
-	int ret = 0;
+	struct usbssp_request *req_priv = to_usbssp_request(request);
+	struct usbssp_udc *usbssp_data = ep_priv->usbssp_data;
+	unsigned long flags = 0;
+	int irq_disabled_locally = 0;
+	int ret;
+
+	if (!ep_priv->endpoint.desc) {
+		dev_err(usbssp_data->dev,
+			"%s: can't queue to disabled endpoint\n",
+			ep_priv->name);
+		return -ESHUTDOWN;
+	}
 
-	if (!ep_priv)
-		return -EINVAL;
+	if ((ep_priv->ep_state & USBSSP_EP_DISABLE_PENDING ||
+			!(ep_priv->ep_state & USBSSP_EP_ENABLED))) {
+		dev_err(usbssp_data->dev,
+			"%s: can't queue to disabled endpoint\n",
+			ep_priv->name);
+		ret = -ESHUTDOWN;
+		goto out;
+	}
 
-	/*TODO: implements this function*/
+	usbssp_g_lock(irq_disabled_locally, flags);
+	ret = usbssp_enqueue(ep_priv, req_priv);
+	usbssp_g_unlock(irq_disabled_locally, flags);
+out:
 	return ret;
 }
 
@@ -78,36 +125,53 @@ static int usbssp_gadget_ep_dequeue(struct usb_ep *ep,
 				    struct usb_request *request)
 {
 	struct usbssp_ep *ep_priv = to_usbssp_ep(ep);
-	int ret = 0;
+	struct usbssp_request *req_priv = to_usbssp_request(request);
+	struct usbssp_udc *usbssp_data = ep_priv->usbssp_data;
+	unsigned long flags = 0;
+	int ret;
+	int irq_disabled_locally = 0;
+
+	if (!ep_priv->endpoint.desc) {
+		dev_err(usbssp_data->dev,
+			"%s: can't queue to disabled endpoint\n",
+			ep_priv->name);
+		return -ESHUTDOWN;
+	}
 
-	if (!ep_priv)
-		return -EINVAL;
+	usbssp_g_lock(irq_disabled_locally, flags);
+	ret = usbssp_dequeue(ep_priv, req_priv);
+	usbssp_g_unlock(irq_disabled_locally, flags);
 
-	/*TODO: implements this function*/
 	return ret;
 }
 
 static int usbssp_gadget_ep_set_halt(struct usb_ep *ep, int value)
 {
 	struct usbssp_ep *ep_priv = to_usbssp_ep(ep);
-	int ret = 0;
-
-	if (!ep_priv)
-		return -EINVAL;
+	struct usbssp_udc *usbssp_data = ep_priv->usbssp_data;
+	int ret;
+	int irq_disabled_locally = 0;
+	unsigned long flags = 0;
 
-	/*TODO: implements this function*/
+	usbssp_g_lock(irq_disabled_locally, flags);
+	ret = usbssp_halt_endpoint(usbssp_data, ep_priv, value);
+	usbssp_g_unlock(irq_disabled_locally, flags);
 	return ret;
 }
 
 static int usbssp_gadget_ep_set_wedge(struct usb_ep *ep)
 {
 	struct usbssp_ep *ep_priv = to_usbssp_ep(ep);
-	int ret = 0;
+	struct usbssp_udc *usbssp_data = ep_priv->usbssp_data;
+	unsigned long flags = 0;
+	int ret;
+	int irq_disabled_locally = 0;
 
-	if (!ep_priv)
-		return -EINVAL;
+	usbssp_g_lock(irq_disabled_locally, flags);
+	ep_priv->ep_state |= USBSSP_EP_WEDGE;
+	ret = usbssp_halt_endpoint(usbssp_data, ep_priv, 1);
+	usbssp_g_unlock(irq_disabled_locally, flags);
 
-	/*TODO: implements this function*/
 	return ret;
 }
 
@@ -182,19 +246,39 @@ static int usbssp_gadget_start(struct usb_gadget *g,
 				usbssp_data->gadget.name,
 				usbssp_data->gadget_driver->driver.name);
 		ret = -EBUSY;
+		goto err1;
 	}
 
-	/*TODO: add implementation*/
+	usbssp_data->gadget_driver = driver;
+
+	if (pm_runtime_active(usbssp_data->dev)) {
+		usbssp_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(512);
+		usbssp_data->ep0state = USBSSP_EP0_UNCONNECTED;
+		ret = usbssp_run(usbssp_data);
+		if (ret < 0)
+			goto err1;
+	}
+	return 0;
+err1:
 	return ret;
 }
 
 static int usbssp_gadget_stop(struct usb_gadget *g)
 {
+	unsigned long flags = 0;
+	int irq_disabled_locally = 0;
 	struct usbssp_udc *usbssp_data = gadget_to_usbssp(g);
 
-	if (!usbssp_data)
-		return -EINVAL;
-	/*TODO: add implementation*/
+	usbssp_g_lock(irq_disabled_locally, flags);
+	if (pm_runtime_suspended(usbssp_data->dev))
+		goto out;
+
+	usbssp_free_dev(usbssp_data);
+	usbssp_stop(usbssp_data);
+out:
+	usbssp_data->gadget_driver = NULL;
+	usbssp_g_unlock(irq_disabled_locally, flags);
+
 	return 0;
 }
 
@@ -202,33 +286,51 @@ static int usbssp_gadget_get_frame(struct usb_gadget *g)
 {
 	struct usbssp_udc *usbssp_data = gadget_to_usbssp(g);
 
-	if (!usbssp_data)
-		return -EINVAL;
-
-	/*TODO: add implementation*/
-	return 0;
+	return usbssp_get_frame(usbssp_data);
 }
 
 static int usbssp_gadget_wakeup(struct usb_gadget *g)
 {
 	struct usbssp_udc *usbssp_data = gadget_to_usbssp(g);
+	unsigned long flags = 0;
+	int irq_disabled_locally = 0;
+	__le32 __iomem *port_regs;
+	u32 temp;
+
+	if (!usbssp_data->port_remote_wakeup)
+		return -EINVAL;
 
-	if (!usbssp_data)
+	if (!usbssp_data->port_suspended)
 		return -EINVAL;
 
-	/*TODO: add implementation*/
+	usbssp_g_lock(irq_disabled_locally, flags);
+
+	port_regs = usbssp_get_port_io_addr(usbssp_data);
+	temp = readl(port_regs+PORTPMSC);
+
+	if (!(temp & PORT_RWE))
+		return 0;
+
+	temp = readl(port_regs + PORTSC);
+
+	temp &= ~PORT_PLS_MASK;
+	writel(temp, port_regs + PORTPMSC);
+	usbssp_g_unlock(irq_disabled_locally, flags);
 	return 0;
 }
 
 static int usbssp_gadget_set_selfpowered(struct usb_gadget *g,
 					 int is_selfpowered)
 {
+	unsigned long flags = 0;
+	int irq_disabled_locally = 0;
 	struct usbssp_udc *usbssp_data = gadget_to_usbssp(g);
 
-	if (!usbssp_data)
-		return -EINVAL;
+	usbssp_g_lock(irq_disabled_locally, flags);
+
+	g->is_selfpowered = !!is_selfpowered;
+	usbssp_g_unlock(irq_disabled_locally, flags);
 
-	/*TODO: add implementation*/
 	return 0;
 }
 
diff --git a/drivers/usb/usbssp/gadget.c b/drivers/usb/usbssp/gadget.c
index fe373a7b7198..0180ecfdaf9c 100644
--- a/drivers/usb/usbssp/gadget.c
+++ b/drivers/usb/usbssp/gadget.c
@@ -261,6 +261,22 @@ int usbssp_reset(struct usbssp_udc *usbssp_data)
 	return ret;
 }
 
+static inline int usbssp_try_enable_msi(struct usbssp_udc *usbssp_data)
+{
+	usbssp_data->msi_enabled = 1;
+	return 0;
+}
+
+static inline void usbssp_cleanup_msix(struct usbssp_udc *usbssp_data)
+{
+	usbssp_data->msi_enabled = 0;
+}
+
+static inline void usbssp_msix_sync_irqs(struct usbssp_udc *usbssp_data)
+{
+	/*TODO*/
+}
+
 /*
  * Initialize memory for gadget driver and USBSSP (one-time init).
  *
@@ -280,6 +296,88 @@ int usbssp_init(struct usbssp_udc *usbssp_data)
 	return retval;
 }
 
+/*-------------------------------------------------------------------------*/
+/*
+ * Start the USBSSP after it was halted.
+ *
+ * This function is called by the usbssp_gadget_start function when the
+ * gadget driver is started. Its opposite is usbssp_stop().
+ *
+ * usbssp_init() must be called once before this function can be called.
+ * Reset the USBSSP, enable device slot contexts, program DCBAAP, and
+ * set command ring pointer and event ring pointer.
+ */
+int usbssp_run(struct usbssp_udc *usbssp_data)
+{
+	u32 temp;
+	u64 temp_64;
+	int ret;
+	__le32 __iomem	*portsc;
+	u32 portsc_val = 0;
+	int i = 0;
+
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init, "Driver running");
+
+	ret = usbssp_try_enable_msi(usbssp_data);
+	if (ret)
+		return ret;
+
+	temp_64 = usbssp_read_64(usbssp_data,
+				 &usbssp_data->ir_set->erst_dequeue);
+	temp_64 &= ~ERST_PTR_MASK;
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+			"ERST deq = 64'h%0lx",
+			(unsigned long int) temp_64);
+
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+		"// Set the interrupt modulation register");
+	temp = readl(&usbssp_data->ir_set->irq_control);
+	temp &= ~ER_IRQ_INTERVAL_MASK;
+	temp |= (usbssp_data->imod_interval / 250) & ER_IRQ_INTERVAL_MASK;
+	writel(temp, &usbssp_data->ir_set->irq_control);
+
+	/*enable USB2 port*/
+	for (i = 0; i < usbssp_data->num_usb2_ports; i++) {
+		portsc = usbssp_data->usb2_ports + PORTSC;
+		portsc_val = readl(portsc) & ~PORT_PLS_MASK;
+		portsc_val = portsc_val | (5 << 5) | PORT_LINK_STROBE;
+		writel(portsc_val, portsc);
+	}
+
+	/*enable USB3.0 port*/
+	for (i = 0; i < usbssp_data->num_usb3_ports; i++) {
+		portsc = usbssp_data->usb3_ports + PORTSC;
+		portsc_val = readl(portsc) & ~PORT_PLS_MASK;
+		portsc_val = portsc_val | (5 << 5) | PORT_LINK_STROBE;
+		writel(portsc_val, portsc);
+	}
+
+	if (usbssp_start(usbssp_data)) {
+		usbssp_halt(usbssp_data);
+		return -ENODEV;
+	}
+
+	/* Set the USBSSP state before we enable the irqs */
+	temp = readl(&usbssp_data->op_regs->command);
+	temp |= (CMD_EIE);
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+			"// Enable interrupts, cmd = 0x%x.", temp);
+	writel(temp, &usbssp_data->op_regs->command);
+
+	temp = readl(&usbssp_data->ir_set->irq_pending);
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+		"// Enabling event ring interrupter %p by writing 0x%x to irq_pending",
+		usbssp_data->ir_set, (unsigned int) ER_IRQ_ENABLE(temp));
+	writel(ER_IRQ_ENABLE(temp), &usbssp_data->ir_set->irq_pending);
+
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+			"Finished usbssp_run for USBSSP controller");
+
+	usbssp_data->cmd_ring_state = CMD_RING_STATE_RUNNING;
+
+	return 0;
+}
+
 /*
  * Stop USBSSP controller.
  *
@@ -1098,6 +1196,12 @@ int usbssp_enable_device(struct usbssp_udc *usbssp_data)
 	return usbssp_setup_device(usbssp_data, SETUP_CONTEXT_ONLY);
 }
 
+
+int usbssp_get_frame(struct usbssp_udc *usbssp_data)
+{
+	return readl(&usbssp_data->run_regs->microframe_index) >> 3;
+}
+
 int usbssp_gen_setup(struct usbssp_udc *usbssp_data)
 {
 	int retval;
-- 
2.17.1

