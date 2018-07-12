Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C63C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54ED020875
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="GShknGvt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54ED020875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732300AbeGLF4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 01:56:01 -0400
Received: from mail-eopbgr730061.outbound.protection.outlook.com ([40.107.73.61]:56976
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726800AbeGLF4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 01:56:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wE/Z/tcqTfNn0uouFS+x2+UwXtUPBuhfgCUnL6bzEo=;
 b=GShknGvtj5/tkSSMyju9LNkWWLMjyjMp8ri7QCVxh+6os/VKuJRPhyb3qqbTIxHQuJt+Z6FU690S2NUOOC2Y9VkVI/eDkXUbQrvJcfukC2fXWfG6s+Y8d8HWsn/CMmN74udtmcMQTWPwEjN+Uy1sAuurHp2x5IjrKC4H0/vn1xc=
Received: from BYAPR07CA0049.namprd07.prod.outlook.com (2603:10b6:a03:60::26)
 by BN7PR07MB4707.namprd07.prod.outlook.com (2603:10b6:406:f0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.22; Thu, 12 Jul
 2018 05:47:55 +0000
Received: from BY2NAM05FT007.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::206) by BYAPR07CA0049.outlook.office365.com
 (2603:10b6:a03:60::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.952.18 via Frontend
 Transport; Thu, 12 Jul 2018 05:47:55 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 BY2NAM05FT007.mail.protection.outlook.com (10.152.100.144) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.973.9 via
 Frontend Transport; Thu, 12 Jul 2018 05:47:54 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5lkw2032054
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 11 Jul 2018 22:47:54 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 12 Jul 2018 07:48:03 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Jul 2018 07:48:03 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5llwR029573;
        Thu, 12 Jul 2018 06:47:47 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6C5llK7029572;
        Thu, 12 Jul 2018 06:47:47 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 08/31] usb: usbssp: Added ring and segment handling functions.
Date:   Thu, 12 Jul 2018 06:47:05 +0100
Message-ID: <1531374448-26532-9-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1531374448-26532-1-git-send-email-pawell@cadence.com>
References: <1531374448-26532-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(346002)(376002)(2980300002)(36092001)(189003)(199004)(1671002)(478600001)(4720700003)(486006)(50466002)(6666003)(336012)(126002)(51416003)(26826003)(446003)(476003)(2906002)(26005)(36756003)(107886003)(4326008)(305945005)(2616005)(246002)(11346002)(426003)(7636002)(14444005)(86362001)(356003)(76176011)(575784001)(48376002)(109986005)(47776003)(8676002)(316002)(42186006)(16586007)(186003)(5660300001)(106466001)(50226002)(105596002)(8936002)(87636003)(54906003)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB4707;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM05FT007;1:8H60X4Tcgk3hhhuti9Z59ggAN7B02NBYB73BM7RfQstcwwCTxiA5bd5y5zgHQ21ODYU/bn+BnbVYcsK0QX6/6GzWYIgb0rPtZyTOdtiWO81cof6CwcKkN/Y2vNaVCVvl
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06a9ee44-42ed-45b5-c218-08d5e7bb03b3
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BN7PR07MB4707;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4707;3:DF1hijSK4G3/u9HxkpyCM1tMTWhgpRCTq0gAkZ7/kxHN4MxazZgAtBAKiLF0aQQXwZe/kPaS7PwwHZwpopkBSLMtA5lJeWUQbu6SfQNpIbnqv9ghkhUspYYvomMqkmI/E0Xmc54gwiTJlqObhup2bySCeai73t7CqZyjgQ+fHOqmRG8YTNwMTdyArR4GXe5+Bu7asRuxt5M/02cJ0LuRUsX47IwVkeXR25kNHpJEprRNaj1tI/YM/hTEzS70LQPek4WhJJqB7KrLpSvC9yBStOz9JcB94A51x7sPGLPU2IEu/IcJjYGQa3iudXJrmKakct43L91MBM6UisDunC9mUkGPFjiVXnYL0xWgZWdnmCk=;25:GPb3R8v0pQuF+LNMHpyUMfDz01AWmGGAL1ujH2H6qmFCEegwwD5LA1r3jO1nAorlil1DDLr5bqL+DmyxGCjq4y3DPWtFT8MSNmnfOiiLca3uaf+IAZTLHEaPKyWGU2AoYaPhrjRgW+dYsKyOIuhQio9NiVHhZRERTic7Ad/cmwawil0ZiBHVAymYB7YuVI5r9drPEEf1lfnIoXvVBRP29rxgffFvUHroIDWVJ9C1TsEHkjfw+AbYO1ybV3RZiLeigdvSXy0N6BeXFk7DCMxeU5S6+dpWPDDOPT61KA3QS+Nmpghgnsz0va7bBxw63I/QAYtcYH+/dy2GL5oXDZM7xg==
X-MS-TrafficTypeDiagnostic: BN7PR07MB4707:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4707;31:rVW4Sk6U1Rq3PB8yZ30W7oxweN980RIs6YoaugqfAPG8Ji/1+Git+dkrTgtqrfKASrWlVvX/wuFZ76HCqplH9OZmbw2ROulfsXFCgB0sqVlRjDbmz70JSCUoVvS1WQmt4nGf3v5cPL+7KatKxfk/KL+ZFxx0wLA5d0VUju8I3J04VK9IPfDY5DJomKi8HXwX9BDyJm52Txl5scyw7rOIIXh2Mw/uGgZgbfPpa+1mXjU=;20:qKo+jXJI7eEorTvwK49vBLc7arSAbpMOMhwt4GfWE6ui3BUrdtjJhPjnhu6Oqgp34EeN0H9JS8C9ZVY9qZh2RZ/Ft0Y958cxl9fnArhH/T5LRbRkgAj4DEa+3xCOosE4mZr7euBdsXam+Hp4YLSK3CtfibO/aT5fHadk0e+koUqfA5NbQ6/WdHMZqFKhMmN0VEb4jjL3cvQ1JoWogmmK9FAYfQPyw5rvaxmnO2sEdzJqy974gAQi+g/C51J/QvInZ2UyOKIl+VRlUgIe4xUuR7W9eeZJXnCxGO242Twt8IOYysT8GW7XWme+xmIb/ah6bLplUxvW0qTtquMf97buK9kCTU6/kAV6mJ6AI5fv2U+yVObRozbvYk8TP1VFDy1gqkd0LJH5Zh+58zlJH1d5em2hWD6ah8aI0dCyM31SO4R7Ei4GaeyVRiKm3WnMl4vXKuEch2PjejeiKjdTQNTvpiNtJ2wnOt4OO2YVpHre1mpvjAtN029m0KY9x6mCpkC3
X-Microsoft-Antispam-PRVS: <BN7PR07MB4707FFB5EF78985E6543F023DD590@BN7PR07MB4707.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(60795455431006)(131327999870524)(211171220733660)(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(10201501046)(93006095)(93003095)(3002001)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BN7PR07MB4707;BCL:0;PCL:0;RULEID:;SRVR:BN7PR07MB4707;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4707;4:goeG5Bmtty0S4SI/6Y1Zu4IJz7FmLISzSU9vVY3YpjNSfpfZ6UEcN4i2RoS2Im2ua7JHslvkwf1cEjABPyc5n48MZDKSG2EONNRUE3pOlbov0EYaqq/XaGA05cyBYGGU8y9gdN1WTdDxowzLF+nA2bv5WlYEAvIMsxOWjb3bUzUiTdqkiaehhRypWhpe1o6AseGv1K8RzVgaHzqeDb+08WAnxwzBIFNsBOTZzKtChOjoictl6tjMovQk6lITBIcOGSOyXB3dqpxwNMH3oDP67NPZ3OZplDjoko+AIy9K46USgVxAUV6i6fjsQJpU4tU3fGMNaxyrm7K3uN692xRnu2vPXiqkkXnm1gfLIbule5IBn4LztyfBgmH/qi/RKJk3h1KeBxzpCT1umLQ7VwFIseTThxpQ/AfyRhnAcLFyOnU=
X-Forefront-PRVS: 0731AA2DE6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR07MB4707;23:jfeA9waKRw8dn3ioVW0bHBywpZCBx9L90V37B1Cl7?=
 =?us-ascii?Q?7HAaeCDGOn/hBdsGv9OOV8toCWjmDL4YoYkg3dFeqKcEhxInTTa0wyB8P5tF?=
 =?us-ascii?Q?oOjggGMuYQGsAMXFRvGL12xvrJ1msTmejdIq7FRC2rzkwtVeAaydSaXZw5SP?=
 =?us-ascii?Q?pupLRQCQ40IR1ol2OejFeBfQJm3p1O0LAh2EFwcZ/eQAoZU+1dr1fn5XcKSL?=
 =?us-ascii?Q?AEyvGjTF0I51nwkd8jN0Kv3P02CNyD43A2fkhsF5F7yxlXDs79+bgTpjaDZx?=
 =?us-ascii?Q?YLnZ2M0WF5uO9LquJYsEKzILMo1yXazqY6avo1Bo068F+kDt7lDWr4J94MkM?=
 =?us-ascii?Q?VF6Kl6/fDC6YKdmJtTg5m6wRkjAn+z9q6tlvESsH2vYb8dJPouP3BjjC7VJI?=
 =?us-ascii?Q?0oYfwQEbj3g0Iyc6cN/9PdutJbm3aFCZZFpbWSsl+e2eaFV+qYuQFnMxMACE?=
 =?us-ascii?Q?js4B4hiFDwiVJSznC/2u8o1Vtm2DTJCjd8bAfVW2USm6JvTd3fRtN25wHGCE?=
 =?us-ascii?Q?rN1ENLyH3d0/Ym92li7okPbifXYUYYU/3w9P4BghhER581ON5EeFlz67O844?=
 =?us-ascii?Q?KYJfVc2ODDv4c2Eu10dIV+ToxheVk7KtqrjdycB2p6YsDZ9M0a9SWVItrPWo?=
 =?us-ascii?Q?h7bMNaIdSbX/8fKjeL5MODeRY0ii8wJlTR0RrqFF15P1f+RIrjVVA1rBZ8D2?=
 =?us-ascii?Q?bpApMbwDE65ideASmaDHdK2g4mhHPKjulmyCq15Ere+iDNEGz3CWyXyVNID5?=
 =?us-ascii?Q?j7fV1Aj1aH0hR8/Xb59Ma0UMeDmUoGnrc4jcX+iWKiOObKG9VnKAY3LtSrI4?=
 =?us-ascii?Q?1D+oT5d9LTIL9WzkUIDLzAnw3uHgtzRBpUmkqXK5NQ3uGSpzADBacOkXbabH?=
 =?us-ascii?Q?Gs0TLfN98gF4ied2tpfTpL8Q4xMoPdtv3tCyF2eiBnEQXbFafX4CdqaneP3g?=
 =?us-ascii?Q?kWiqFaCKlZS2VHhDyvGuIwbFkyNo31MrNt9H9omHiqXlmXDXm0xIputdkEj4?=
 =?us-ascii?Q?oW05FiFLNmKgavllXqXZdgw76tqpcQ3ukjETwW6JOoypwUAyAONczSfX2F3/?=
 =?us-ascii?Q?lLycb6eqNM1Yp/1t13dBvGi5W8jIJ/WL7G6vNsJhReUvzUQNDzhxULEAGrVl?=
 =?us-ascii?Q?FvGxUSTl3h2G7k1T5APGbl5VI/+hAXjK56f8qcAP+P5CeMR3LOtAIRr/IL+Z?=
 =?us-ascii?Q?52ubFyRdeHhIYo=3D?=
X-Microsoft-Antispam-Message-Info: qrGE6kEM3jb//ea1u/i3JpGBLNwQ2Etbs1vP6P+3HmNL1cCWU+Whkoy4IliToXSxEUFvJtPyCxXSysW3Vtq4AuaU5qLPkrODYL0YxaRLwu5g4FmfAZ2sb3NnU8sDwfZTygqE3BjfNVVkbUE+cw0ntDn7CLKfDNpvqRg/OJAAlhZ6XbIRDVRHc82FrpAyiB+AppSSo1uvbYNZD0W6+1+FLMu5pUb11UQ8CNBBaM3fBfEX15yYTw6ivdBlZoOCjzb42hMiRIomKz3qAIf1Gmg8wG30mlk/gfqZNWNjEpbNp/btRQBVVts+cJmDsPf7R5ORIStBV+BuCkWqSZvRT69jLNpPJiZRnfeCLvaEbavxKX+qGtzpk6T/x9B9n9B+7QxY4klJHD35Lq18mhe56O20PQ==
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4707;6:K1XlD4nQhfSL3UByaPM4gRVwT2P7yq9GR6mPclJz1sIryylWbiSudtHy/3qp/U09LHQLcDsP8LukWmpTEbN97uS3Ych29o/Cjoq2I+MQEpwYJBQdgS/Zmrkox8RXCkJxmY2flkVuewsz+jKFX5JYQlLzFfU2hHhu5VKBkRNc29biO9LwO4itvY4tgG2ReyrcZvJtUx38W0Wh4IMZf6b3JHHzhRWLJG6sbdbMGugxespz8sxN1zpdfgipqSoZGpVPR+2fZ49CrvtPF6RiIffQ8zg913/TT7AGwzZDggnwQKp9xN/FBdvbvYDUpTK1QfI8iSBhxvodC2A2H+Aj+oB/xsXuL0qLp2TEPNrKNVYq7cH7jmTYJsFi/GDgF/Wd/u271NtAJXStk0cXrIcSW+qMiReBSorcCl8Yycpzd3YfL1e0fADGVazdO4reqe0I6QbYKNx7y+b0kCFUg/Q1tKe4hw==;5:Tpe49tjZA26OkaXC4C0x+mRXj7P4Kg3hB2xOev4fAd6SUzHpQE8B9Mpwl1ZF3LsWHkirk67YvHUzuZJb6XG25IR4WxviI2q7D2xXaE2radzSdiXb6+Ola+l85HCVIG8+7GswC3YoIoPAfGRaRFt0xJiJKeczFdNFPX9EYbjQiTE=;24:cj9I2+Qqain0YIBsqUb2DdtLZ9oaPPwOdotjLknrlckwbmfdj6IVgkgjcNAtH8nK8rt1G++JNYWd+TFrstZXJDgMORZIkrT7Wk5A7Ha4enQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4707;7:UaHfnNAJeFuFBoxQdJG52eJpgRJ1/eOWPnOlaiVqDDNRJR8Pc7s1T/rPyoC8KFEQSJ/KTjlStDj+sVFfNXYm6AA/KQUC6N8AlnrkcqrBIBEv64z13iTkjH6JJKq/BVRwtnQmirrfGC0sR/oLbAwsI9L0rzXwy3vt7KRkDM8oZMFm88O0bPHvihYVdfYdcD1RoucK8Kumds5lfQFZ8fe6KuOcmlO0ipx5w73dIQgXl9qBmjPKNhioxwh7advh9Zv/;20:ntsZ2fuhOqr6m4ACKN+cNmbGuK7qmSy+7x4YDZbD36mBGlUXteEt4AEuQFxR3ZR5GRJa3wnW5Lz0gnP1/R29TCs0+pPXIVJ65NEt6Jr1yERQxyn0WFl4x/q6a8wmSYnYwYUxwJvxjeeiNHwpEcmtIyaOhS7634B5Ym3Vo79EUtSsala8tH8AW1TK963JmQCozIvuiAjiAPN88pY6jSGvJ8xmrQ9OaIF1Iwyo1iO20YoUbK4BGKibaaMXtDTKM0tA
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 05:47:54.9181
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06a9ee44-42ed-45b5-c218-08d5e7bb03b3
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4707
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch add generic function used for handling rings in driver.

USBSSP controller use three types of ring:
 - command ring - is used for handling commands. In this case driver
			is producer and HW is consumer.
 - event ring - ring for reporting events to driver. In this kind of
			ring HW is producer and driver is consumer.
 - transfer ring - ring used for queuing transfers. In this case
			software is producer and hardware is consumer.

Driver has only single event and transfer ring, but it uses many of
transfer rings. Each endpoint has own transfer rings.
If endpoint use streams than have many transfer rings for such endpoint.

Each ring can contain segments and each segment contains
Transfer Request blocks (TRB). The set of elements create
Transfer Descriptor (TD).

For more information please refer to XHCI specification.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/usbssp/gadget-mem.c | 437 +++++++++++++++++++++++++++++++-
 1 file changed, 436 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/usbssp/gadget-mem.c b/drivers/usb/usbssp/gadget-mem.c
index f0c529cf824a..b3d86d400dba 100644
--- a/drivers/usb/usbssp/gadget-mem.c
+++ b/drivers/usb/usbssp/gadget-mem.c
@@ -17,6 +17,350 @@
 #include <linux/dma-mapping.h>
 #include "gadget.h"
 #include "gadget-trace.h"
+/*
+ * Allocates a generic ring segment from the ring pool, sets the dma address,
+ * initializes the segment to zero, and sets the private next pointer to NULL.
+ *
+ * "All components of all Command and Transfer TRBs shall be initialized to '0'"
+ */
+static struct usbssp_segment *usbssp_segment_alloc(
+		struct usbssp_udc *usbssp_data, unsigned int cycle_state,
+		unsigned int max_packet, gfp_t flags)
+{
+	struct usbssp_segment *seg;
+	dma_addr_t dma;
+	int i;
+
+	seg = kzalloc(sizeof(*seg), flags);
+	if (!seg)
+		return NULL;
+
+	seg->trbs = dma_pool_zalloc(usbssp_data->segment_pool, flags, &dma);
+	if (!seg->trbs) {
+		kfree(seg);
+		return NULL;
+	}
+
+	if (max_packet) {
+		seg->bounce_buf = kzalloc(max_packet, flags | GFP_DMA);
+		if (!seg->bounce_buf) {
+			dma_pool_free(usbssp_data->segment_pool,
+				seg->trbs, dma);
+			kfree(seg);
+			return NULL;
+		}
+	}
+
+	/* If the cycle state is 0, set the cycle bit to 1 for all the TRBs */
+	if (cycle_state == 0) {
+		for (i = 0; i < TRBS_PER_SEGMENT; i++)
+			seg->trbs[i].link.control |= cpu_to_le32(TRB_CYCLE);
+	}
+	seg->dma = dma;
+	seg->next = NULL;
+
+	return seg;
+}
+
+static void usbssp_segment_free(struct usbssp_udc *usbssp_data,
+				struct usbssp_segment *seg)
+{
+	if (seg->trbs) {
+		dma_pool_free(usbssp_data->segment_pool, seg->trbs, seg->dma);
+		seg->trbs = NULL;
+	}
+	kfree(seg->bounce_buf);
+	kfree(seg);
+}
+
+static void usbssp_free_segments_for_ring(struct usbssp_udc *usbssp_data,
+					  struct usbssp_segment *first)
+{
+	struct usbssp_segment *seg;
+
+	seg = first->next;
+	while (seg != first) {
+		struct usbssp_segment *next = seg->next;
+
+		usbssp_segment_free(usbssp_data, seg);
+		seg = next;
+	}
+	usbssp_segment_free(usbssp_data, first);
+}
+
+/*
+ * Make the prev segment point to the next segment.
+ *
+ * Change the last TRB in the prev segment to be a Link TRB which points to the
+ * DMA address of the next segment.  The caller needs to set any Link TRB
+ * related flags, such as End TRB, Toggle Cycle, and no snoop.
+ */
+static void usbssp_link_segments(struct usbssp_udc *usbssp_data,
+				 struct usbssp_segment *prev,
+				 struct usbssp_segment *next,
+				 enum usbssp_ring_type type)
+{
+	u32 val;
+
+	if (!prev || !next)
+		return;
+	prev->next = next;
+	if (type != TYPE_EVENT) {
+		prev->trbs[TRBS_PER_SEGMENT-1].link.segment_ptr =
+			cpu_to_le64(next->dma);
+
+		/* Set the last TRB in the segment to have a TRB type ID
+		 * of Link TRB
+		 */
+		val = le32_to_cpu(prev->trbs[TRBS_PER_SEGMENT-1].link.control);
+		val &= ~TRB_TYPE_BITMASK;
+		val |= TRB_TYPE(TRB_LINK);
+		prev->trbs[TRBS_PER_SEGMENT-1].link.control = cpu_to_le32(val);
+	}
+}
+
+/*
+ * Link the ring to the new segments.
+ * Set Toggle Cycle for the new ring if needed.
+ */
+static void usbssp_link_rings(struct usbssp_udc *usbssp_data,
+			      struct usbssp_ring *ring,
+			      struct usbssp_segment *first,
+			      struct usbssp_segment *last,
+			      unsigned int num_segs)
+{
+	struct usbssp_segment *next;
+
+	if (!ring || !first || !last)
+		return;
+
+	next = ring->enq_seg->next;
+	usbssp_link_segments(usbssp_data, ring->enq_seg, first, ring->type);
+	usbssp_link_segments(usbssp_data, last, next, ring->type);
+	ring->num_segs += num_segs;
+	ring->num_trbs_free += (TRBS_PER_SEGMENT - 1) * num_segs;
+
+	if (ring->type != TYPE_EVENT && ring->enq_seg == ring->last_seg) {
+		ring->last_seg->trbs[TRBS_PER_SEGMENT-1].link.control
+			&= ~cpu_to_le32(LINK_TOGGLE);
+		last->trbs[TRBS_PER_SEGMENT-1].link.control
+			|= cpu_to_le32(LINK_TOGGLE);
+		ring->last_seg = last;
+	}
+}
+
+/*
+ * We need a radix tree for mapping physical addresses of TRBs to which stream
+ * ID they belong to.  We need to do this because the device controller won't
+ * tell us which stream ring the TRB came from.  We could store the stream ID
+ * in an event data TRB, but that doesn't help us for the cancellation case,
+ * since the endpoint may stop before it reaches that event data TRB.
+ *
+ * The radix tree maps the upper portion of the TRB DMA address to a ring
+ * segment that has the same upper portion of DMA addresses.  For example,
+ * say I have segments of size 1KB, that are always 1KB aligned.  A segment may
+ * start at 0x10c91000 and end at 0x10c913f0.  If I use the upper 10 bits, the
+ * key to the stream ID is 0x43244.  I can use the DMA address of the TRB to
+ * pass the radix tree a key to get the right stream ID:
+ *
+ *	0x10c90fff >> 10 = 0x43243
+ *	0x10c912c0 >> 10 = 0x43244
+ *	0x10c91400 >> 10 = 0x43245
+ *
+ * Obviously, only those TRBs with DMA addresses that are within the segment
+ * will make the radix tree return the stream ID for that ring.
+ *
+ * Caveats for the radix tree:
+ *
+ * The radix tree uses an unsigned long as a key pair.  On 32-bit systems, an
+ * unsigned long will be 32-bits; on a 64-bit system an unsigned long will be
+ * 64-bits.  Since we only request 32-bit DMA addresses, we can use that as the
+ * key on 32-bit or 64-bit systems (it would also be fine if we asked for 64-bit
+ * PCI DMA addresses on a 64-bit system).  There might be a problem on 32-bit
+ * extended systems (where the DMA address can be bigger than 32-bits),
+ * if we allow the PCI dma mask to be bigger than 32-bits.  So don't do that.
+ */
+static int usbssp_insert_segment_mapping(
+		struct radix_tree_root *trb_address_map,
+		struct usbssp_ring *ring,
+		struct usbssp_segment *seg,
+		gfp_t mem_flags)
+{
+	unsigned long key;
+	int ret;
+
+	key = (unsigned long)(seg->dma >> TRB_SEGMENT_SHIFT);
+	/* Skip any segments that were already added. */
+	if (radix_tree_lookup(trb_address_map, key))
+		return 0;
+
+	ret = radix_tree_maybe_preload(mem_flags);
+	if (ret)
+		return ret;
+	ret = radix_tree_insert(trb_address_map, key, ring);
+	radix_tree_preload_end();
+	return ret;
+}
+
+static void usbssp_remove_segment_mapping(
+				struct radix_tree_root *trb_address_map,
+				struct usbssp_segment *seg)
+{
+	unsigned long key;
+
+	key = (unsigned long)(seg->dma >> TRB_SEGMENT_SHIFT);
+	if (radix_tree_lookup(trb_address_map, key))
+		radix_tree_delete(trb_address_map, key);
+}
+
+static int usbssp_update_stream_segment_mapping(
+		struct radix_tree_root *trb_address_map,
+		struct usbssp_ring *ring,
+		struct usbssp_segment *first_seg,
+		struct usbssp_segment *last_seg,
+		gfp_t mem_flags)
+{
+	struct usbssp_segment *seg;
+	struct usbssp_segment *failed_seg;
+	int ret;
+
+	if (WARN_ON_ONCE(trb_address_map == NULL))
+		return 0;
+
+	seg = first_seg;
+	do {
+		ret = usbssp_insert_segment_mapping(trb_address_map,
+				ring, seg, mem_flags);
+		if (ret)
+			goto remove_streams;
+		if (seg == last_seg)
+			return 0;
+		seg = seg->next;
+	} while (seg != first_seg);
+
+	return 0;
+
+remove_streams:
+	failed_seg = seg;
+	seg = first_seg;
+	do {
+		usbssp_remove_segment_mapping(trb_address_map, seg);
+		if (seg == failed_seg)
+			return ret;
+		seg = seg->next;
+	} while (seg != first_seg);
+
+	return ret;
+}
+
+static void usbssp_remove_stream_mapping(struct usbssp_ring *ring)
+{
+	struct usbssp_segment *seg;
+
+	if (WARN_ON_ONCE(ring->trb_address_map == NULL))
+		return;
+
+	seg = ring->first_seg;
+	do {
+		usbssp_remove_segment_mapping(ring->trb_address_map, seg);
+		seg = seg->next;
+	} while (seg != ring->first_seg);
+}
+
+static int usbssp_update_stream_mapping(struct usbssp_ring *ring,
+					gfp_t mem_flags)
+{
+	return usbssp_update_stream_segment_mapping(ring->trb_address_map, ring,
+			ring->first_seg, ring->last_seg, mem_flags);
+}
+
+void usbssp_ring_free(struct usbssp_udc *usbssp_data, struct usbssp_ring *ring)
+{
+	if (!ring)
+		return;
+
+	trace_usbssp_ring_free(ring);
+
+	if (ring->first_seg) {
+		if (ring->type == TYPE_STREAM)
+			usbssp_remove_stream_mapping(ring);
+		usbssp_free_segments_for_ring(usbssp_data, ring->first_seg);
+	}
+
+	kfree(ring);
+}
+
+static void usbssp_initialize_ring_info(struct usbssp_ring *ring,
+					unsigned int cycle_state)
+{
+	/* The ring is empty, so the enqueue pointer == dequeue pointer */
+	ring->enqueue = ring->first_seg->trbs;
+	ring->enq_seg = ring->first_seg;
+	ring->dequeue = ring->enqueue;
+	ring->deq_seg = ring->first_seg;
+	/* The ring is initialized to 0. The producer must write 1 to the cycle
+	 * bit to handover ownership of the TRB, so PCS = 1.  The consumer must
+	 * compare CCS to the cycle bit to check ownership, so CCS = 1.
+	 *
+	 * New rings are initialized with cycle state equal to 1; if we are
+	 * handling ring expansion, set the cycle state equal to the old ring.
+	 */
+	ring->cycle_state = cycle_state;
+
+	/*
+	 * Each segment has a link TRB, and leave an extra TRB for SW
+	 * accounting purpose
+	 */
+	ring->num_trbs_free = ring->num_segs * (TRBS_PER_SEGMENT - 1) - 1;
+}
+
+/* Allocate segments and link them for a ring */
+static int usbssp_alloc_segments_for_ring(struct usbssp_udc *usbssp_data,
+					  struct usbssp_segment **first,
+					  struct usbssp_segment **last,
+					  unsigned int num_segs,
+					  unsigned int cycle_state,
+					  enum usbssp_ring_type type,
+					  unsigned int max_packet,
+					  gfp_t flags)
+{
+	struct usbssp_segment *prev;
+
+	/*allocation first segment */
+	prev = usbssp_segment_alloc(usbssp_data, cycle_state,
+			max_packet, flags);
+	if (!prev)
+		return -ENOMEM;
+	num_segs--;
+
+	*first = prev;
+	/*allocation all other segments*/
+	while (num_segs > 0) {
+		struct usbssp_segment	*next;
+
+		next = usbssp_segment_alloc(usbssp_data, cycle_state,
+				max_packet, flags);
+		if (!next) {
+			prev = *first;
+			/*Free all reserved segment*/
+			while (prev) {
+				next = prev->next;
+				usbssp_segment_free(usbssp_data, prev);
+				prev = next;
+			}
+			return -ENOMEM;
+		}
+		usbssp_link_segments(usbssp_data, prev, next, type);
+
+		prev = next;
+		num_segs--;
+	}
+	usbssp_link_segments(usbssp_data, prev, *first, type);
+	*last = prev;
+
+	return 0;
+}
+
 /**
  * Create a new ring with zero or more segments.
  *
@@ -31,10 +375,101 @@ static struct usbssp_ring *usbssp_ring_alloc(struct usbssp_udc *usbssp_data,
 					     unsigned int max_packet,
 					     gfp_t flags)
 {
-	/*TODO: implements function*/
+	struct usbssp_ring *ring;
+	int ret;
+
+	ring = kzalloc(sizeof *(ring), flags);
+	if (!ring)
+		return NULL;
+
+	ring->num_segs = num_segs;
+	ring->bounce_buf_len = max_packet;
+	INIT_LIST_HEAD(&ring->td_list);
+	ring->type = type;
+	if (num_segs == 0)
+		return ring;
+
+	ret = usbssp_alloc_segments_for_ring(usbssp_data, &ring->first_seg,
+			&ring->last_seg, num_segs, cycle_state, type,
+			max_packet, flags);
+	if (ret)
+		goto fail;
+
+	/* Only event ring does not use link TRB */
+	if (type != TYPE_EVENT) {
+		/* See section 4.9.2.1 and 6.4.4.1 */
+		ring->last_seg->trbs[TRBS_PER_SEGMENT - 1].link.control |=
+			cpu_to_le32(LINK_TOGGLE);
+	}
+	usbssp_initialize_ring_info(ring, cycle_state);
+	trace_usbssp_ring_alloc(ring);
+	return ring;
+fail:
+	kfree(ring);
 	return NULL;
 }
 
+void usbssp_free_endpoint_ring(struct usbssp_udc *usbssp_data,
+			       struct usbssp_device *dev_priv,
+			       unsigned int ep_index)
+{
+	usbssp_ring_free(usbssp_data, dev_priv->eps[ep_index].ring);
+	dev_priv->eps[ep_index].ring = NULL;
+}
+
+/*
+ * Expand an existing ring.
+ * Allocate a new ring which has same segment numbers and link the two rings.
+ */
+int usbssp_ring_expansion(struct usbssp_udc *usbssp_data,
+			  struct usbssp_ring *ring,
+			  unsigned int num_trbs, gfp_t flags)
+{
+	struct usbssp_segment *first;
+	struct usbssp_segment *last;
+	unsigned int num_segs;
+	unsigned int num_segs_needed;
+	int ret;
+
+	num_segs_needed = (num_trbs + (TRBS_PER_SEGMENT - 1) - 1) /
+			(TRBS_PER_SEGMENT - 1);
+
+	/* Allocate number of segments we needed, or double the ring size */
+	num_segs = ring->num_segs > num_segs_needed ?
+			ring->num_segs : num_segs_needed;
+
+	ret = usbssp_alloc_segments_for_ring(usbssp_data, &first, &last,
+			num_segs, ring->cycle_state, ring->type,
+			ring->bounce_buf_len, flags);
+	if (ret)
+		return -ENOMEM;
+
+	if (ring->type == TYPE_STREAM)
+		ret = usbssp_update_stream_segment_mapping(
+				ring->trb_address_map, ring, first,
+				last, flags);
+	if (ret) {
+		struct usbssp_segment *next;
+
+		do {
+			next = first->next;
+			usbssp_segment_free(usbssp_data, first);
+			if (first == last)
+				break;
+			first = next;
+		} while (true);
+		return ret;
+	}
+
+	usbssp_link_rings(usbssp_data, ring, first, last, num_segs);
+	trace_usbssp_ring_expansion(ring);
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_ring_expansion,
+			"ring expansion succeed, now has %d segments",
+			ring->num_segs);
+
+	return 0;
+}
+
 struct usbssp_container_ctx *usbssp_alloc_container_ctx(
 					struct usbssp_udc *usbssp_data,
 					int type, gfp_t flags)
-- 
2.17.1

