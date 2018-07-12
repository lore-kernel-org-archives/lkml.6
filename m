Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA48BC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EC5920875
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="NDB5nsah"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EC5920875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732458AbeGLF6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 01:58:32 -0400
Received: from mail-eopbgr680054.outbound.protection.outlook.com ([40.107.68.54]:28992
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727019AbeGLFz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 01:55:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjDHqjztvU0lNlHf9U6H5Xq3PbsD7Y9cE4mczzQcOss=;
 b=NDB5nsahD/eN7B31pEJaogNBgm1EKcNZ+5RmCK0UKLu+3+o3h7lEs5HNZuxg8fKDG8QvetbVQtTq3IqgyeawRs9OH7Xoc7VKZJz/xxIs2/aM2dyfGeEq4bDU4CGpQ9oHu60P97skoYJovJMMZTu1uNOS0MnPutTFRJiNcNjpuc4=
Received: from CO2PR07CA0051.namprd07.prod.outlook.com (2603:10b6:100::19) by
 BYAPR07MB4711.namprd07.prod.outlook.com (2603:10b6:a02:f0::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.17; Thu, 12 Jul 2018 05:47:59 +0000
Received: from BY2NAM05FT038.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::204) by CO2PR07CA0051.outlook.office365.com
 (2603:10b6:100::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.952.17 via Frontend
 Transport; Thu, 12 Jul 2018 05:47:58 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 BY2NAM05FT038.mail.protection.outlook.com (10.152.100.175) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.20.973.9 via
 Frontend Transport; Thu, 12 Jul 2018 05:47:58 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5luUQ017906
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 11 Jul 2018 22:47:57 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 12 Jul 2018 07:48:05 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Jul 2018 07:48:04 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5lme4029648;
        Thu, 12 Jul 2018 06:47:48 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6C5lm6C029647;
        Thu, 12 Jul 2018 06:47:48 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 12/31] usb: usbssp: added functions for queuing commands.
Date:   Thu, 12 Jul 2018 06:47:09 +0100
Message-ID: <1531374448-26532-13-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1531374448-26532-1-git-send-email-pawell@cadence.com>
References: <1531374448-26532-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39860400002)(396003)(2980300002)(189003)(199004)(36092001)(42186006)(54906003)(575784001)(86362001)(26005)(486006)(4720700003)(186003)(126002)(2906002)(316002)(36756003)(16586007)(446003)(336012)(4326008)(11346002)(476003)(76176011)(2616005)(51416003)(426003)(246002)(50466002)(5660300001)(107886003)(109986005)(8936002)(7636002)(50226002)(8676002)(356003)(47776003)(1671002)(106466001)(87636003)(105596002)(478600001)(26826003)(48376002)(14444005)(305945005)(6666003)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4711;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM05FT038;1:WrhTUDpTJ2L5nekTTmqe166bHZBnJl3v0WLs7OlZlq9k/rk4D0QLrXIaUlwLs0742fNxDcIfZ4tCk5lthTY7+TxzuadLmkUf1klGL0AB6Q+TwEav/XaemqT0NexSX1Js
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03d95338-9e4f-4672-db49-08d5e7bb05ef
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BYAPR07MB4711;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4711;3:OClX4uLUtguzwa5oAl0jQ9BPOeN2cSGBhok48SOTR0k1w5247qe+H38fb3skZ5n2eymFzQReX55iqrNIDUW31vglcNRuo5mRBqoRn8EGRHpP4d1KrPQQEVOm4RHJm3/poN6nNs3lDSe23L702P+du/EBTH20+w0ks279NTi7EDW6QYXnlm+rtDIdinqMDjw6oA05elCd6x/U7LOz50jaPcAAXjtuCDTTx0ApX/1okVk5Ub36/zvfaDOSpDtG9Z0CJhMTKqbCcZJOV03PnXpFAvv7Bf0HkjogpJKYEC98SW335YVj8cg459lI+Mfc16JGkpiEd51BMZimKqyb5YZDNSMppTu2AaVlhykmI9q2gRQ=;25:88fUE2sjt1aTkjwbQxZw2dlxOCI0DwNZr8JdNelziyuS9/arev5ooqosbxqW7pzLs7HCQCNiTU5sXRfDNQq0Pnp4Phvxm+1xX7t3NKdR3vI0okx2HwTX63WcpFPuO8LNEazVkWZJO+hFcqNP27ZebUP+N/x4Scp69mW1iDTEPmWBVMpb8bW6aWxxJ/UP/t2eHrpVgkw0Xwo0tFn78dhzGoFet5Q8RP68LvRqs+uX1L4H+K3rkvSo5tHBrdvMAVsr5LgJM/gTs57rY4Gh1an/Nw6OkpLw9GhjDmURW24IjsIEWruJhWkTqipy59E024pTB+8tM0AD5vBNx/O9BgBMHg==
X-MS-TrafficTypeDiagnostic: BYAPR07MB4711:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4711;31:pQL+ZUcR52mOBuT7xDR+tJ1j+NpfOmYSUkTVyppb+iPE0IjNFKmLfASUN2F5eFGeQOrwXCZpKFESy280XswO7IkrWLOXJt8PSjn1fvCQuIpla25KPjTwpjLYAhP7kkt7klO6imu4YQw/5PRqZvXWL3R+D0fAiV+AZU2fMnDkr6+R5yvq5vcwpbLwl2421RBtRRkL2908Pq0N92rOm4wyZAfx3oKD1rSxhwD3Svx+ddo=;20:dXbQLkibz5UkQhLcdbK5rbWw0pVWrElTWwKBFN7XdeR2b6HRUNlAO/94ZvOqggrHzppzc/Oo+bkK+jCMGdYVcFREQ0H7dP9U8OlH9d7jXQnP0LV7/4H7lnGvFyuEDPeUIZB82G+zO4O5bKWlcg7LPu/ovx08w5NkFaMtAjPHtLIKduHjFcuiBGbI2IMlGauZi5mOUnplcbfmmnwfh3ZG0e7F44a3ULdmLGKFtMrQAHpKxT3GWn2j8VFwL+VbVe2vDgQuooljCAzXXyOcPJpR9k9YN8tuhhonejJvF/nwY5WFZt5ZWsCzbyLC0+CpL0U5W1uN88PubwxLekBO3roX3BCCm/qAiOXKHwXh2z4P3tBFG+UPUgPyBYRbYkXrV7LNWudcznqbrIkU1MEP6UxilHpcN/ORCreYj4/h7zdSPqBl58/I5/gHBder+d651krqsm7qEqg3iOFnALTVfls6DyG0cDnhhA75PnroTFLXBFa3Cidw0iH2bNPJOqrefmnD
X-Microsoft-Antispam-PRVS: <BYAPR07MB4711D27A6F35303D2AD92FCADD590@BYAPR07MB4711.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93003095)(3002001)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BYAPR07MB4711;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4711;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4711;4:3uC9THwq9LiGMwq4/5ycox4LxJGLC7dxu71a8uX+kFhHK25lKv8O3lM4FR+tj3IlIVgU/hnEPlsb0RFJ8un8gskmGqyGL+m182SH3bnxyxtU/J6oSuBgaJ4OoJT0/vaO4K9LJuLwCZ1o0Y/Qv1HSF2jAfF8zrbC5o65P3IZuLx4vpGiXUHQHtIr1vYW4PosZS7wgfBP7R8PcUAhJrMOZzetLSC5XZdKYOaPq+MfnLWpKWNMcXKs7fBC38B8rN/FTiLkGyX8INS/BzYuJGVxJZdOpsMPTyZwokeMx6ad470L9HxOrDViNTMKmVjRek4Vc
X-Forefront-PRVS: 0731AA2DE6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR07MB4711;23:YgcqCxCJv8t4lk50zhJbqzbqjfwHcJ8wspp1kmYuW?=
 =?us-ascii?Q?R0Pn3Y67rE2yS8hPdLFeCadPdeDWxfY0iOE+N9vG8MA+PC/Qbp38b2L5vmAy?=
 =?us-ascii?Q?dZ5PiqaKYWcerDQn6aOW7ESXn3FMIq7Sbvlwtkk8x53GHV+73gjh/B4CNU/L?=
 =?us-ascii?Q?11LM5G1fQptwam0wkOwqohoTf+pb6uI1PND1KSswKq4mGlTW8kQqk6mNaPxZ?=
 =?us-ascii?Q?OpAeV7kVJidrgZCXRYvvRXocgK6aT/7mfMvOmPJ5lIKCT4XSKhCywAcym9jy?=
 =?us-ascii?Q?nDynEgy6ZeumP+lamM9OyMV2dFsROp4mcbdulizQ5ZsKayyfLJp85HrOjbe2?=
 =?us-ascii?Q?+f4RxwfSALWAfbzOb/ozSW1NHFn1wlq5eudm+v+nbetwoJg8Q+ADD3amZ56P?=
 =?us-ascii?Q?ww+WS9MlHYMNo05c6L4lR9Imuz3sopfJMkaTzuCx5hIIjxkU6t1n4xpQqh9K?=
 =?us-ascii?Q?PguNoWHlNvZ91c1NrxRMAky3RiXeGVRRb141NxPHYI6qbTN/xVNmKWSQLhye?=
 =?us-ascii?Q?fgZ+vutPCsbK8Je78SOB8QgTLZut2lW1GDvAkckhnDMZ8LMmw34/O4PFZo48?=
 =?us-ascii?Q?K3B7BcLPsTFV7YhxRURe4zp8P94iy9ok2m6DtQ5Fwy2NTAdNHn+T+p5D9jHZ?=
 =?us-ascii?Q?rBfAlCghl9ogHQihZoqYO2FmsyQqE7Op2DVUJVVJx+BN5cxdYsN71gImHcPM?=
 =?us-ascii?Q?hT59PzjJ/eNNTLxpW4eyUklLSAn7OUWWATkSNU1OP6eDwV/V7PuI8mV2FKZ0?=
 =?us-ascii?Q?inDMXy8e/hfzaq/qrFUMP8L//e0jJ3R5EzxF9cJcIA4aRvT1mf0Ko8u2pZjg?=
 =?us-ascii?Q?b4G/ld79bxYv34Gm+vt0gXVRdTeFh/PVTSo4U8jBpTRxABugMko8G8SY5NiR?=
 =?us-ascii?Q?a8b36+jvl0lfhfiJIm+fTBNO8mJCSohG1IwKyXlLvHYH2/fuvX/ixvFdMHqC?=
 =?us-ascii?Q?0HDBJuigVn4btjtRLskmeP3rfApf8cuDDUfFbC9MOu6R47nqbYjiJaDVb6NQ?=
 =?us-ascii?Q?qjwxEuKfhidcLMUjc3U186qSDxFCZKPGJfgHgfhl8tMYPZrajInFfG4TTyvL?=
 =?us-ascii?Q?5lEhVGvv4wAIbzMbOc5GUBP0mn8lCkkKXuYb0w2v96g5aN0mh2FpgzNSoR+1?=
 =?us-ascii?Q?RlXIeSevQF1zS23cjWaMDICm7xouFAXeDZ08K1wGvHkLQJ4AS/n0y2abOxeb?=
 =?us-ascii?Q?BtSxPG2qZZiBzs=3D?=
X-Microsoft-Antispam-Message-Info: AdpC18hUJIOrWX+9giQkJRd4yJkxpYrvn6ePU8R7hytSJU7XKIku3/7rLP760eQUimhCzpyzy0ZUpXwmP2tG9aGsC0NThT2UI3Mycpd0w7V/528O2Z5ckmiMUH+pt26v11+GXoH7VmuFFSgPNmqv4Q0zpwdBRhNNbX+bUx+8Rluan/kMUrNsec0cDppuywCukOoa6p0TI9F5Gv0rELJGi1s19AlcQAQIqdXg7LbvjVJJrtSgfvZIWRwZe+0KmImbVoTq6FXEIZAwObzzHVzzrMMoU5N+2AmnZ/NQWJxu/u2bChlFEzbo8Q6jMQ9ijZxNIJUDYiWYU4T/ATENPOzQu0NoVUW8vy7YzQIaffDYAPSqVynNrMvzUxLRCnsFdH0M9fHoO1CgtdtVo5+Ht8s4fg==
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4711;6:He17egDXVLncO7TiGoj7mR3nUkdgKyepZJQnThAHd5efxtZqypBCslwMsWw9CyBq19cSFi6Z8LCwUsNLltTQqaQgoSQUcZ/D3HVDkqwwjGj2j58SHgPxCAS39xc/cOrD0EvHo45EhgSLu8xyTtQ1wZaZZ2/v3ErpwoX3zXjK3188lvgUPKEEMaeZtbH3PVSN/GFx1NYzCaPYPqCf3vnBmyR7jpPVzIdau12dahjZlz6bIDJmkNysTOQYW7chwy9DPdaj+Vgz2m2aipPyWcZw3x6sNGg2hFfwbMPzcryxzl+2VQMKa2w23ZcZ3MyB4vlUVPW3NOzRxbnXnc3WdAJ2VDbaYg6JvUP4HbPtnmgykf2HdK2ShQbrt0XkbN3ni3J7rcCsiDsAAqyBC5UkwF54ItnDc44WS61PI0c6gWTAp5xIhvbnvjctcBVwP8sg3T+bcJPXlaWKyFUx2vlcFrLKwg==;5:0CIT5/l7ZF3DNXl/kq/Q6gDE2oBTReIWtV21VAgNijMegYDzxZaiKN+2IL90hyiqytikjMMWW01n2SLZPDrzcIJr/flyUSYv7GLd3BqQNBDMHcq20En0bW+f7PDlRv7FuF2Pp9UEaltrAv9g1j9svi0MWtTlX5FTuSsOsVSI0FE=;24:4JHXdq8ZyMB+CBPCxEt3gO2FkD/zSS76jE3jFAT2e57Y11obzFOUuI9P16sdu0e1zDbFigd/34UJhAMJGwgp0BAzYTQeynhhefKZY6Wfs1M=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4711;7:PrpxzA/U2KEekXq2eK+YdP8dqJSnq74rdgDZSiL620ALd7lymNRnT1p5iJK7QLEoHR5eUf9Al+JGy6XxCY2PoIWfArFCStFBQrUWVi35pY+VL6nJUft3LB/dWtb/vOnSpeKqtG6sxwGm57I7Nfr2vMQoF1XgYXXk/4ZKQ6xa08wjJ/qkf+y/9G0XYvUKM349mAUpg09oMD1wI/No9T/gJdDID+EPsoRNf1YDH6t1D5l9lrcjqxMGgRMiGZgtWE2b;20:R4O+XVwljH2+681T9KfIWB533R+KeQ5U57GrueKKWl2vRxTrwnLIbl4ojyPJ2jN7WTfqSJjX0J8Skjr/BBAWIJj5OZ3mutt8pyMicmcmiwwfiHE+mxpdVD4u2l3BM7+A3sxgJPC2EGHN7ZyFJB0I/o3tFoyDGLGSNxmpkYtSuaYFd3jEoxMPU5rPfm+xvDrxAl28fDHHChvFOs54z02ZcdRgFNRx5W8nCBrPIPuyL6ok7RhnlpDLZT/WnX3GCLK4
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 05:47:58.6673
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03d95338-9e4f-4672-db49-08d5e7bb05ef
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4711
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch defines a set of functions used to send
commands to command ring.

Commands added to Command Ring are handled sequentially
by hardware. After completion, controller should
add appropriate event to Event Ring.

Controller specification said that command may not be
completed. For this reason, driver should start
watchdog timer before arming Command Ring.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/usbssp/gadget-ring.c | 535 ++++++++++++++++++++++++++++++-
 drivers/usb/usbssp/gadget.h      |   4 +
 2 files changed, 538 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/usbssp/gadget-ring.c b/drivers/usb/usbssp/gadget-ring.c
index c3612f4bc2a9..e2fb81259ca1 100644
--- a/drivers/usb/usbssp/gadget-ring.c
+++ b/drivers/usb/usbssp/gadget-ring.c
@@ -10,10 +10,55 @@
  * Origin: Copyright (C) 2008 Intel Corp
  */
 
+/*
+ * Ring initialization rules:
+ * 1. Each segment is initialized to zero, except for link TRBs.
+ * 2. Ring cycle state = 0.  This represents Producer Cycle State (PCS) or
+ *    Consumer Cycle State (CCS), depending on ring function.
+ * 3. Enqueue pointer = dequeue pointer = address of first TRB in the segment.
+ *
+ * Ring behavior rules:
+ * 1. A ring is empty if enqueue == dequeue.  This means there will always be at
+ *    least one free TRB in the ring.  This is useful if you want to turn that
+ *    into a link TRB and expand the ring.
+ * 2. When incrementing an enqueue or dequeue pointer, if the next TRB is a
+ *    link TRB, then load the pointer with the address in the link TRB.  If the
+ *    link TRB had its toggle bit set, you may need to update the ring cycle
+ *    state (see cycle bit rules).  You may have to do this multiple times
+ *    until you reach a non-link TRB.
+ * 3. A ring is full if enqueue++ (for the definition of increment above)
+ *    equals the dequeue pointer.
+ *
+ * Cycle bit rules:
+ * 1. When a consumer increments a dequeue pointer and encounters a toggle bit
+ *    in a link TRB, it must toggle the ring cycle state.
+ * 2. When a producer increments an enqueue pointer and encounters a toggle bit
+ *    in a link TRB, it must toggle the ring cycle state.
+ *
+ * Producer rules:
+ * 1. Check if ring is full before you enqueue.
+ * 2. Write the ring cycle state to the cycle bit in the TRB you're enqueuing.
+ *    Update enqueue pointer between each write (which may update the ring
+ *    cycle state).
+ * 3. Notify consumer.  If SW is producer, it rings the doorbell for command
+ *    and endpoint rings.  If DC is the producer for the event ring,
+ *    and it generates an interrupt according to interrupt modulation rules.
+ *
+ * Consumer rules:
+ * 1. Check if TRB belongs to you.  If the cycle bit == your ring cycle state,
+ *    the TRB is owned by the consumer.
+ * 2. Update dequeue pointer (which may update the ring cycle state) and
+ *    continue processing TRBs until you reach a TRB which is not owned by you.
+ * 3. Notify the producer.  SW is the consumer for the event ring, and it
+ *   updates event ring dequeue pointer.  DC is the consumer for the command and
+ *   endpoint rings; it generates events on the event ring for these.
+ */
+
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
 #include <linux/dma-mapping.h>
 #include <linux/irq.h>
+
 #include "gadget-trace.h"
 #include "gadget.h"
 
@@ -35,6 +80,145 @@ dma_addr_t usbssp_trb_virt_to_dma(struct usbssp_segment *seg,
 	return seg->dma + (segment_offset * sizeof(*trb));
 }
 
+static bool trb_is_link(union usbssp_trb *trb)
+{
+	return TRB_TYPE_LINK_LE32(trb->link.control);
+}
+
+static bool last_trb_on_seg(struct usbssp_segment *seg, union usbssp_trb *trb)
+{
+	return trb == &seg->trbs[TRBS_PER_SEGMENT - 1];
+}
+
+static bool last_trb_on_ring(struct usbssp_ring *ring,
+			     struct usbssp_segment *seg,
+			     union usbssp_trb *trb)
+{
+	return last_trb_on_seg(seg, trb) && (seg->next == ring->first_seg);
+}
+
+static bool link_trb_toggles_cycle(union usbssp_trb *trb)
+{
+	return le32_to_cpu(trb->link.control) & LINK_TOGGLE;
+}
+/*
+ * See Cycle bit rules. SW is the consumer for the event ring only.
+ * Don't make a ring full of link TRBs.  That would be dumb and this would loop.
+ */
+void inc_deq(struct usbssp_udc *usbssp_data, struct usbssp_ring *ring)
+{
+	/* event ring doesn't have link trbs, check for last trb */
+	if (ring->type == TYPE_EVENT) {
+		if (!last_trb_on_seg(ring->deq_seg, ring->dequeue)) {
+			ring->dequeue++;
+			goto out;
+		}
+		if (last_trb_on_ring(ring, ring->deq_seg, ring->dequeue))
+			ring->cycle_state ^= 1;
+		ring->deq_seg = ring->deq_seg->next;
+		ring->dequeue = ring->deq_seg->trbs;
+		goto out;
+	}
+
+	/* All other rings have link trbs */
+	if (!trb_is_link(ring->dequeue)) {
+		ring->dequeue++;
+		ring->num_trbs_free++;
+	}
+	while (trb_is_link(ring->dequeue)) {
+		ring->deq_seg = ring->deq_seg->next;
+		ring->dequeue = ring->deq_seg->trbs;
+	}
+out:
+	trace_usbssp_inc_deq(ring);
+}
+
+/*
+ * See Cycle bit rules. SW is the consumer for the event ring only.
+ * Don't make a ring full of link TRBs.  That would be dumb and this would loop.
+ *
+ * If we've just enqueued a TRB that is in the middle of a TD (meaning the
+ * chain bit is set), then set the chain bit in all the following link TRBs.
+ * If we've enqueued the last TRB in a TD, make sure the following link TRBs
+ * have their chain bit cleared (so that each Link TRB is a separate TD).
+ *
+ * @more_trbs_coming:	Will you enqueue more TRBs before calling
+ *			prepare_transfer()?
+ */
+static void inc_enq(struct usbssp_udc *usbssp_data,
+		    struct usbssp_ring *ring,
+		    bool more_trbs_coming)
+{
+	u32 chain;
+	union usbssp_trb *next;
+
+	chain = le32_to_cpu(ring->enqueue->generic.field[3]) & TRB_CHAIN;
+	/* If this is not event ring, there is one less usable TRB */
+	if (!trb_is_link(ring->enqueue))
+		ring->num_trbs_free--;
+	next = ++(ring->enqueue);
+
+	/* Update the dequeue pointer further if that was a link TRB */
+	while (trb_is_link(next)) {
+
+		/*
+		 * If the caller doesn't plan on enqueueing more TDs before
+		 * ringing the doorbell, then we don't want to give the link TRB
+		 * to the hardware just yet. We'll give the link TRB back in
+		 * prepare_ring() just before we enqueue the TD at the top of
+		 * the ring.
+		 */
+		if (!chain && !more_trbs_coming)
+			break;
+
+		next->link.control &= cpu_to_le32(~TRB_CHAIN);
+		next->link.control |= cpu_to_le32(chain);
+
+		/* Give this link TRB to the hardware */
+		wmb();
+		next->link.control ^= cpu_to_le32(TRB_CYCLE);
+
+		/* Toggle the cycle bit after the last ring segment. */
+		if (link_trb_toggles_cycle(next))
+			ring->cycle_state ^= 1;
+
+		ring->enq_seg = ring->enq_seg->next;
+		ring->enqueue = ring->enq_seg->trbs;
+		next = ring->enqueue;
+	}
+	trace_usbssp_inc_enq(ring);
+}
+
+/*
+ * Check to see if there's room to enqueue num_trbs on the ring and make sure
+ * enqueue pointer will not advance into dequeue segment. See rules above.
+ */
+static inline int room_on_ring(struct usbssp_udc *usbssp_data,
+			       struct usbssp_ring *ring,
+			       unsigned int num_trbs)
+{
+	int num_trbs_in_deq_seg;
+
+	if (ring->num_trbs_free < num_trbs)
+		return 0;
+
+	if (ring->type != TYPE_COMMAND && ring->type != TYPE_EVENT) {
+		num_trbs_in_deq_seg = ring->dequeue - ring->deq_seg->trbs;
+
+		if (ring->num_trbs_free < num_trbs + num_trbs_in_deq_seg)
+			return 0;
+	}
+
+	return 1;
+}
+
+static bool usbssp_mod_cmd_timer(struct usbssp_udc *usbssp_data,
+				  unsigned long delay)
+{
+	return mod_delayed_work(system_wq, &usbssp_data->cmd_timer, delay);
+	return 0;
+}
+
 irqreturn_t usbssp_irq(int irq, void *priv)
 {
 	struct usbssp_udc *usbssp_data = (struct usbssp_udc *)priv;
@@ -47,7 +231,6 @@ irqreturn_t usbssp_irq(int irq, void *priv)
 	return ret;
 }
 
-
 void usbssp_handle_command_timeout(struct work_struct *work)
 {
 	/*TODO: implements function*/
@@ -146,3 +329,353 @@ struct usbssp_segment *usbssp_trb_in_td(struct usbssp_udc *usbssp_data,
 
 	return NULL;
 }
+
+/****		Endpoint Ring Operations	****/
+
+/*
+ * Generic function for queueing a TRB on a ring.
+ * The caller must have checked to make sure there's room on the ring.
+ *
+ * @more_trbs_coming:	Will you enqueue more TRBs before calling
+ *			prepare_transfer()?
+ */
+static void queue_trb(struct usbssp_udc *usbssp_data, struct usbssp_ring *ring,
+		bool more_trbs_coming,
+		u32 field1, u32 field2, u32 field3, u32 field4)
+{
+	struct usbssp_generic_trb *trb;
+
+	trb = &ring->enqueue->generic;
+
+	usbssp_dbg(usbssp_data, "Queue TRB at virt: %p, dma: %llx\n", trb,
+			usbssp_trb_virt_to_dma(ring->enq_seg, ring->enqueue));
+
+	trb->field[0] = cpu_to_le32(field1);
+	trb->field[1] = cpu_to_le32(field2);
+	trb->field[2] = cpu_to_le32(field3);
+	trb->field[3] = cpu_to_le32(field4);
+
+	trace_usbssp_queue_trb(ring, trb);
+	inc_enq(usbssp_data, ring, more_trbs_coming);
+}
+
+/*
+ * Does various checks on the endpoint ring, and makes it ready to
+ * queue num_trbs.
+ */
+static int prepare_ring(struct usbssp_udc *usbssp_data,
+			struct usbssp_ring *ep_ring,
+			u32 ep_state, unsigned
+			int num_trbs,
+			gfp_t mem_flags)
+{
+	unsigned int num_trbs_needed;
+
+	/* Make sure the endpoint has been added to USBSSP schedule */
+	switch (ep_state) {
+	case EP_STATE_DISABLED:
+		usbssp_warn(usbssp_data,
+			"WARN request submitted to disabled ep\n");
+		return -ENOENT;
+	case EP_STATE_ERROR:
+		usbssp_warn(usbssp_data,
+			"WARN waiting for error on ep to be cleared\n");
+		return -EINVAL;
+	case EP_STATE_HALTED:
+		usbssp_dbg(usbssp_data,
+			"WARN halted endpoint, queueing request anyway.\n");
+	case EP_STATE_STOPPED:
+	case EP_STATE_RUNNING:
+		break;
+	default:
+		usbssp_err(usbssp_data,
+			"ERROR unknown endpoint state for ep\n");
+		return -EINVAL;
+	}
+
+	while (1) {
+		if (room_on_ring(usbssp_data, ep_ring, num_trbs))
+			break;
+
+		if (ep_ring == usbssp_data->cmd_ring) {
+			usbssp_err(usbssp_data,
+				"Do not support expand command ring\n");
+			return -ENOMEM;
+		}
+
+		usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_ring_expansion,
+				"ERROR no room on ep ring, try ring expansion");
+
+		num_trbs_needed = num_trbs - ep_ring->num_trbs_free;
+		if (usbssp_ring_expansion(usbssp_data, ep_ring, num_trbs_needed,
+					mem_flags)) {
+			usbssp_err(usbssp_data, "Ring expansion failed\n");
+			return -ENOMEM;
+		}
+	}
+
+	while (trb_is_link(ep_ring->enqueue)) {
+
+		ep_ring->enqueue->link.control |= cpu_to_le32(TRB_CHAIN);
+		wmb();
+		ep_ring->enqueue->link.control ^= cpu_to_le32(TRB_CYCLE);
+
+		/* Toggle the cycle bit after the last ring segment. */
+		if (link_trb_toggles_cycle(ep_ring->enqueue))
+			ep_ring->cycle_state ^= 1;
+		ep_ring->enq_seg = ep_ring->enq_seg->next;
+		ep_ring->enqueue = ep_ring->enq_seg->trbs;
+	}
+	return 0;
+}
+
+/****		Command Ring Operations		****/
+/* Generic function for queueing a command TRB on the command ring.
+ * Check to make sure there's room on the command ring for one command TRB.
+ * Also check that there's room reserved for commands that must not fail.
+ * If this is a command that must not fail, meaning command_must_succeed = TRUE,
+ * then only check for the number of reserved spots.
+ * Don't decrement usbssp_data->cmd_ring_reserved_trbs after we've queued the
+ * TRB because the command event handler may want to resubmit a failed command.
+ */
+static int queue_command(struct usbssp_udc *usbssp_data,
+			 struct usbssp_command *cmd,
+			 u32 field1, u32 field2,
+			 u32 field3, u32 field4,
+			 bool command_must_succeed)
+{
+	int reserved_trbs = usbssp_data->cmd_ring_reserved_trbs;
+	int ret;
+
+	if ((usbssp_data->usbssp_state & USBSSP_STATE_DYING) ||
+		(usbssp_data->usbssp_state & USBSSP_STATE_HALTED)) {
+		usbssp_dbg(usbssp_data,
+			"USBSSP dying or halted, can't queue command\n");
+		return -ESHUTDOWN;
+	}
+
+	if (!command_must_succeed)
+		reserved_trbs++;
+
+	ret = prepare_ring(usbssp_data, usbssp_data->cmd_ring, EP_STATE_RUNNING,
+			reserved_trbs, GFP_ATOMIC);
+	if (ret < 0) {
+		usbssp_err(usbssp_data,
+			"ERR: No room for command on command ring\n");
+		if (command_must_succeed)
+			usbssp_err(usbssp_data,
+				"ERR: Reserved TRB counting for "
+				"unfailable commands failed.\n");
+		return ret;
+	}
+
+	cmd->command_trb = usbssp_data->cmd_ring->enqueue;
+
+	/* if there are no other commands queued we start the timeout timer */
+	if (list_empty(&usbssp_data->cmd_list)) {
+		usbssp_data->current_cmd = cmd;
+		usbssp_mod_cmd_timer(usbssp_data, USBSSP_CMD_DEFAULT_TIMEOUT);
+	}
+
+	list_add_tail(&cmd->cmd_list, &usbssp_data->cmd_list);
+
+	queue_trb(usbssp_data, usbssp_data->cmd_ring, false, field1, field2,
+		field3, field4 | usbssp_data->cmd_ring->cycle_state);
+	return 0;
+}
+
+/* Queue a slot enable or disable request on the command ring */
+int usbssp_queue_slot_control(struct usbssp_udc *usbssp_data,
+			      struct usbssp_command *cmd,
+			      u32 trb_type)
+{
+	return queue_command(usbssp_data, cmd, 0, 0, 0,
+			TRB_TYPE(trb_type) |
+			SLOT_ID_FOR_TRB(usbssp_data->slot_id), false);
+}
+
+/* Queue an address device command TRB */
+int usbssp_queue_address_device(struct usbssp_udc *usbssp_data,
+				struct usbssp_command *cmd,
+				dma_addr_t in_ctx_ptr,
+				enum usbssp_setup_dev setup)
+{
+	return queue_command(usbssp_data, cmd, lower_32_bits(in_ctx_ptr),
+			upper_32_bits(in_ctx_ptr), 0,
+			TRB_TYPE(TRB_ADDR_DEV) |
+			SLOT_ID_FOR_TRB(usbssp_data->slot_id)
+			| (setup == SETUP_CONTEXT_ONLY ? TRB_BSR : 0), false);
+}
+
+int usbssp_queue_vendor_command(struct usbssp_udc *usbssp_data,
+				struct usbssp_command *cmd,
+				u32 field1, u32 field2, u32 field3, u32 field4)
+{
+	return queue_command(usbssp_data, cmd, field1, field2, field3,
+			field4, false);
+}
+
+/* Queue a reset device command TRB */
+int usbssp_queue_reset_device(struct usbssp_udc *usbssp_data,
+			      struct usbssp_command *cmd)
+{
+	return queue_command(usbssp_data, cmd, 0, 0, 0,
+			TRB_TYPE(TRB_RESET_DEV) |
+			SLOT_ID_FOR_TRB(usbssp_data->slot_id),
+			false);
+}
+
+/* Queue a configure endpoint command TRB */
+int usbssp_queue_configure_endpoint(struct usbssp_udc *usbssp_data,
+				    struct usbssp_command *cmd,
+				    dma_addr_t in_ctx_ptr,
+				    bool command_must_succeed)
+{
+	return queue_command(usbssp_data, cmd, lower_32_bits(in_ctx_ptr),
+			upper_32_bits(in_ctx_ptr), 0,
+			TRB_TYPE(TRB_CONFIG_EP) |
+			SLOT_ID_FOR_TRB(usbssp_data->slot_id),
+			command_must_succeed);
+}
+
+/* Queue an evaluate context command TRB */
+int usbssp_queue_evaluate_context(struct usbssp_udc *usbssp_data,
+				  struct usbssp_command *cmd,
+				  dma_addr_t in_ctx_ptr,
+				  bool command_must_succeed)
+{
+	return queue_command(usbssp_data, cmd, lower_32_bits(in_ctx_ptr),
+			upper_32_bits(in_ctx_ptr), 0,
+			TRB_TYPE(TRB_EVAL_CONTEXT) |
+			SLOT_ID_FOR_TRB(usbssp_data->slot_id),
+			command_must_succeed);
+}
+
+/*
+ * Suspend is set to indicate "Stop Endpoint Command" is being issued to stop
+ * activity on an endpoint that is about to be suspended.
+ */
+int usbssp_queue_stop_endpoint(struct usbssp_udc *usbssp_data,
+			       struct usbssp_command *cmd,
+			       unsigned int ep_index, int suspend)
+{
+	u32 trb_slot_id = SLOT_ID_FOR_TRB(usbssp_data->slot_id);
+	u32 trb_ep_index = EP_ID_FOR_TRB(ep_index);
+	u32 type = TRB_TYPE(TRB_STOP_RING);
+	u32 trb_suspend = SUSPEND_PORT_FOR_TRB(suspend);
+
+	return queue_command(usbssp_data, cmd, 0, 0, 0,
+			trb_slot_id | trb_ep_index | type | trb_suspend, false);
+}
+
+/* Set Transfer Ring Dequeue Pointer command */
+void usbssp_queue_new_dequeue_state(struct  usbssp_udc *usbssp_data,
+				    unsigned int ep_index,
+				    struct usbssp_dequeue_state *deq_state)
+{
+	dma_addr_t addr;
+	u32 trb_slot_id = SLOT_ID_FOR_TRB(usbssp_data->slot_id);
+	u32 trb_ep_index = EP_ID_FOR_TRB(ep_index);
+	u32 trb_stream_id = STREAM_ID_FOR_TRB(deq_state->stream_id);
+	u32 trb_sct = 0;
+	u32 type = TRB_TYPE(TRB_SET_DEQ);
+	struct usbssp_ep *ep_priv;
+	struct usbssp_command *cmd;
+	int ret;
+
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_cancel_request,
+		"Set TR Deq Ptr cmd, new deq seg = %p (0x%llx dma), "
+		"new deq ptr = %p (0x%llx dma), new cycle = %u",
+		deq_state->new_deq_seg,
+		(unsigned long long)deq_state->new_deq_seg->dma,
+		deq_state->new_deq_ptr,
+		(unsigned long long)usbssp_trb_virt_to_dma(
+			deq_state->new_deq_seg, deq_state->new_deq_ptr),
+		deq_state->new_cycle_state);
+
+	addr = usbssp_trb_virt_to_dma(deq_state->new_deq_seg,
+				    deq_state->new_deq_ptr);
+	if (addr == 0) {
+		usbssp_warn(usbssp_data, "WARN Cannot submit Set TR Deq Ptr\n");
+		usbssp_warn(usbssp_data, "WARN deq seg = %p, deq pt = %p\n",
+			  deq_state->new_deq_seg, deq_state->new_deq_ptr);
+		return;
+	}
+	ep_priv = &usbssp_data->devs.eps[ep_index];
+	if ((ep_priv->ep_state & SET_DEQ_PENDING)) {
+		usbssp_warn(usbssp_data, "WARN Cannot submit Set TR Deq Ptr\n");
+		usbssp_warn(usbssp_data,
+			"A Set TR Deq Ptr command is pending.\n");
+		return;
+	}
+
+	/* This function gets called from contexts where it cannot sleep */
+	cmd = usbssp_alloc_command(usbssp_data, false, GFP_ATOMIC);
+	if (!cmd) {
+		usbssp_warn(usbssp_data,
+			"WARN Cannot submit Set TR Deq Ptr: ENOMEM\n");
+		return;
+	}
+
+	ep_priv->queued_deq_seg = deq_state->new_deq_seg;
+	ep_priv->queued_deq_ptr = deq_state->new_deq_ptr;
+	if (deq_state->stream_id)
+		trb_sct = SCT_FOR_TRB(SCT_PRI_TR);
+	ret = queue_command(usbssp_data, cmd,
+		lower_32_bits(addr) | trb_sct | deq_state->new_cycle_state,
+		upper_32_bits(addr), trb_stream_id,
+		trb_slot_id | trb_ep_index | type, false);
+	if (ret < 0) {
+		usbssp_free_command(usbssp_data, cmd);
+		return;
+	}
+
+	/* Stop the TD queueing code from ringing the doorbell until
+	 * this command completes.  The DC won't set the dequeue pointer
+	 * if the ring is running, and ringing the doorbell starts the
+	 * ring running.
+	 */
+	ep_priv->ep_state |= SET_DEQ_PENDING;
+}
+
+int usbssp_queue_reset_ep(struct usbssp_udc *usbssp_data,
+			  struct usbssp_command *cmd,
+			  unsigned int ep_index,
+			  enum usbssp_ep_reset_type reset_type)
+{
+	u32 trb_slot_id = SLOT_ID_FOR_TRB(usbssp_data->slot_id);
+	u32 trb_ep_index = EP_ID_FOR_TRB(ep_index);
+	u32 type = TRB_TYPE(TRB_RESET_EP);
+
+	if (reset_type == EP_SOFT_RESET)
+		type |= TRB_TSP;
+
+	return queue_command(usbssp_data, cmd, 0, 0, 0,
+			trb_slot_id | trb_ep_index | type, false);
+}
+
+/*
+ * Queue an NOP command TRB
+ */
+int usbssp_queue_nop(struct usbssp_udc *usbssp_data,
+		     struct usbssp_command *cmd)
+{
+	return queue_command(usbssp_data, cmd, 0, 0, 0,
+			TRB_TYPE(TRB_CMD_NOOP), false);
+}
+
+/*
+ * Queue a halt endpoint request on the command ring
+ */
+int usbssp_queue_halt_endpoint(struct usbssp_udc *usbssp_data,
+			       struct usbssp_command *cmd,
+			       unsigned int ep_index)
+{
+	u32 trb_slot_id = SLOT_ID_FOR_TRB(usbssp_data->slot_id);
+	u32 trb_ep_index = EP_ID_FOR_TRB(ep_index);
+
+	return queue_command(usbssp_data, cmd, 0, 0, 0,
+			TRB_TYPE(TRB_HALT_ENDPOINT) | trb_slot_id |
+			trb_ep_index, false);
+}
+
diff --git a/drivers/usb/usbssp/gadget.h b/drivers/usb/usbssp/gadget.h
index 374c85995dd7..d0ce20f35ec6 100644
--- a/drivers/usb/usbssp/gadget.h
+++ b/drivers/usb/usbssp/gadget.h
@@ -1679,7 +1679,11 @@ void usbssp_dbg_trace(struct usbssp_udc *usbssp_data,
 /* USBSSP memory management */
 void usbssp_mem_cleanup(struct usbssp_udc *usbssp_data);
 int usbssp_mem_init(struct usbssp_udc *usbssp_data, gfp_t flags);
+int usbssp_ring_expansion(struct usbssp_udc *usbssp_data,
+		struct usbssp_ring *ring, unsigned int num_trbs, gfp_t flags);
 
+struct usbssp_command *usbssp_alloc_command(struct usbssp_udc *usbssp_data,
+		bool allocate_completion, gfp_t mem_flags);
 void usbssp_free_command(struct usbssp_udc *usbssp_data,
 		struct usbssp_command *command);
 
-- 
2.17.1

