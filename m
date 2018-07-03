Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A150C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 253D92477C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="GcKHAkfO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 253D92477C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933926AbeGCKDp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 06:03:45 -0400
Received: from mail-by2nam01on0070.outbound.protection.outlook.com ([104.47.34.70]:35136
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933565AbeGCKDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 06:03:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvKI4ODc0F7DsR//kW4i/+iZBb25AAvkT4Zm8yoe5XQ=;
 b=GcKHAkfO53pwHFZs8CiZbDJ1+1nAgaj7jB7xpEnAWOC0s3K3yiwLc5OGNPqM+MPisSvP/xr3zb33/qeg0lm8kPt+H36fwwWIrMLzYYb0S2LXHevHc+a+q/0zcjjlIWJiwTkwIEttgpZnwyuXElt/7WhoYkoTxhHznq/DHD0+uvg=
Received: from BY2PR07CA0097.namprd07.prod.outlook.com
 (2a01:111:e400:7bff::50) by DM6PR07MB4715.namprd07.prod.outlook.com
 (2603:10b6:5:a1::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.24; Tue, 3 Jul
 2018 10:03:35 +0000
Received: from BY2NAM05FT054.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::202) by BY2PR07CA0097.outlook.office365.com
 (2a01:111:e400:7bff::50) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.930.18 via Frontend
 Transport; Tue, 3 Jul 2018 10:03:35 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 BY2NAM05FT054.mail.protection.outlook.com (10.152.100.191) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.20.930.2 via
 Frontend Transport; Tue, 3 Jul 2018 10:03:34 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w63A3WiX024732
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 3 Jul 2018 03:03:34 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 3 Jul 2018 12:03:48 +0200
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 3 Jul 2018 12:03:48 +0200
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id w63A3VPL029781;
        Tue, 3 Jul 2018 11:03:31 +0100
Received: (from dkos@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id w63A3VLS029780;
        Tue, 3 Jul 2018 11:03:31 +0100
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
Subject: [PATCH 07/12] drm/dp: fix drm_dp_link_train_clock_recovery_delay for DP 1.4
Date:   Tue, 3 Jul 2018 11:02:18 +0100
Message-ID: <1530612152-27555-8-git-send-email-dkos@cadence.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1530612152-27555-1-git-send-email-dkos@cadence.com>
References: <1530612152-27555-1-git-send-email-dkos@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(136003)(396003)(2980300002)(3190300001)(36092001)(189003)(199004)(7636002)(36756003)(87636003)(8936002)(186003)(14444005)(5660300001)(126002)(11346002)(26826003)(2906002)(2616005)(476003)(446003)(478600001)(26005)(426003)(305945005)(486006)(105596002)(356003)(336012)(76176011)(51416003)(6666003)(2201001)(86362001)(7416002)(54906003)(8676002)(246002)(316002)(110136005)(47776003)(16586007)(42186006)(106466001)(50226002)(50466002)(4326008)(48376002)(921003)(83996005)(2101003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB4715;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM05FT054;1:5szGR52j/O7ds/8XuEP91lhtOmLkm2PrsNfydFowMtWP5J7pvIo4cOBLX9iEbkeeDGUPokY3pHMza0ex12aYuafUP8QkSzzUcrmy3PGae7qWbIwMr6Zts+DhkXNoXZgk
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0e686ef-f7b9-485f-2d17-08d5e0cc3d57
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:DM6PR07MB4715;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4715;3:y3tt2ehE04EbLsON5UYcs+M8jcKXSs5xVecSGPU81QuB9qV0v7o3pfOgVDhHMgoKO4fN/Gmc6mRc1ucizKI+fl4+FLuzwGDsnQsfPsPodxUgGjPg3f4IF4uYTj9NePVlno95l10u2DRZuta8Ll8wqOVDp2wSfRKLDUT2gKDxlc0REhRIyNBjcoaDmaPSCTmhhQn63OEEYSkRNNsQtxLWUsTSkA2yL+PYIZMWSepq+aZSfRJ+FaLSp39LItL7C5/jsXKRYQHkPycfeqFncyKFSWyopUYxjvsjNDjjlVQdtwNDFGmzSysaY6l1L1dpQwv9UedWvJonO6nH9qe/SU23u8HPhzI8ouDOH3w1ChHSxFQ=;25:b2azuTyLPgtEJnuo5nhgGsPsCW98283D8GKK6s4hg/mlyPicFMnPf+IDzRyBCpJwL4RKah5HiPX7dmZigX6RFs12H/VuyLyoj4C7Xq/W1TOhjiVakLD95BYfM2DW/W+60KXmloMYGG8QN4ey5oIkzbHEGivFc8Z59QzKZQAE5m/Ih1LjkSZppFWzSiN4IPJoInv20P/LMui8oD0knJk6ztqNXdU2pg1zlhRai6PmKd7QBB8MB/TAqVxUS7MtRYT2W8f8DWkRx5a4aweF7XK7qEmZCMi5qdodNWchUK54ijxzQLgRnR0stsocn0tWxi2GE7126P5VaCm4XoM4fptdnQ==
X-MS-TrafficTypeDiagnostic: DM6PR07MB4715:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4715;31:O0wbcJGVkeEf0nuSE8DtMk1/HJzq6E7dzvC4Pytinr4BqRAheLL/wfbs2U3Jt5nTpCuJCI+zLvN8e+zTZAbt3KNwnut9MQjUP2X1/bxJT5WnKPVFsEBaXDTE7OCkZG1nHuGQoB11t2/ASBpXjBYSDIrMh7Ul+6HkaJM3DcP+u2RY2Jyftu1u2qaujUPdYrsciSUCVh1RwuRiyJPonL2F7EAVxd//kv+/5kgniN28P+I=;20:eN7532PpDQr5wtzpHhJSCTe+IouYd56Nz+IRkIV5xNPMk/N4IRA4YDPci1lG+opI5m6IEN1LbrxHuBbhyYbpP/BumHzZ6TCvPtlXEX3FRpfFGFAh46PZsDR/rWvB3qcEiDWZlsEfimC9+1W4nZbDv2nA3GNLuVxgNX98qX5B56Y1NLuA37TKi2Ah3sV2oNZMMJOhXsBHeK9w49Lqa7fNzSKS8skbq5JzhDxl8Q9yfkmOtx/ylTlieUyXp8uQYiTMYL5r/UwuM7/Q3Q1X0gIZOAm7Ub/4nc9TIGov+DVXJ9GEdE3TUi53jOvB2edTdagNXJNKBzM7ecOyfOryMm2pcrCcWMeOld/4JbgHtJKoaS2vTWXsrXwvrZdNDrYUW/uezfgfM76KQdIjRCWa5lElFzlcZvnP1gfLECNy3WmuxaTwy0Z6gcPlGReO5T7iZLXA7vaMYWxgWlFY6HGR4tkiFTzhsvlbc43R+f8ePHgwe9PGrDT66RaS6y6+DHDibi4j
X-Microsoft-Antispam-PRVS: <DM6PR07MB47154E94E794A77224477409CD420@DM6PR07MB4715.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(58145275503218)(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93003095)(10201501046)(3231254)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM6PR07MB4715;BCL:0;PCL:0;RULEID:;SRVR:DM6PR07MB4715;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4715;4:MWFHQC5VtO5BMc/+CxlFlwWxsgxxZHK8piF+ISec0mBXld67iIR3Rx6q3sv4IcWfuI0FjlmEVFCH7RD8SOmGlX2+RX5x3OrKmH4AlEOoRwPWiMykoZ+AluShgFIQSMlBv+0qOxljKrIN4rH25tn+06y0A8RRmTYRNH9b/YMrgV27lFwsZRV9Y+gUUtpbKqQUKadIV8ibROR5+0u6Kqkp+JqnnuK26/8PK7BqgTaGkaa/YXeBgXyWTziLYIU7wBsTXQ04vCKYFRjwb8dUKoAOruE3KOdqzGm+G8dkFq3V1L/Pyc/4jPLwXLdaq62vMvVdYoFRiJDvpSSGTuQKHtgPIAIgjWkcXVwCnkL3qP0Scvo=
X-Forefront-PRVS: 0722981D2A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR07MB4715;23:rjsE4ShptGBbbE6qlpyylcvQNzZfZ4TQjdhaFEMDo?=
 =?us-ascii?Q?Ja1vrftTb8IuYsSw9UwFqszIoNYyetqFrQRNEbkzlaid8Md/ONpKjrafIIQx?=
 =?us-ascii?Q?wCDdmJ/YOMzO3pZVbH0fmbqE/q+hlCf7fRFIZazs69/62+XVPvY5WrVkv9Dv?=
 =?us-ascii?Q?qsu2BxdSZ8TKvl+58VS+HCSXSXiHR9WF8FrM6O3rZvtxTWKZV7G5AUcC3IGa?=
 =?us-ascii?Q?Wol07jQZ5+3D36Mg0Aibcyrsjmw+Q7fyEslmE3AX9OZfU+7X+fgs61wvTMUQ?=
 =?us-ascii?Q?XiFXNxZll8s41rocGOzJgo27z0TrBlOD/vUqcW8uiLLxekGYCveYH8/qRVGs?=
 =?us-ascii?Q?NtSNNPQjANH2XcaYNgaz5/Bs7uJ26u89wKHMJ4vFbJCfE/JrWquASe4rDcL/?=
 =?us-ascii?Q?xlVznoY1u1UutsQ8wOk3oZNbyvTeKqZeQ8+zaWwicOl7fycTsvGQw+204rZP?=
 =?us-ascii?Q?jo8uNyjjcBWXFp0wi0ujVvMH5OY2QuaEaWOrGPPG0Nn/haHNRxlD6WAr5WFB?=
 =?us-ascii?Q?8voezBzzJAPiWOToc3u2q266thpO+hyXFS/zPwRoHOmB+rYBIfp/mW+4FzUf?=
 =?us-ascii?Q?ZnYJMlKyh3UU9jHxSgIizc3c6kJUaTlQyIR3Juw4WNYvie0Mf0lAm0M07qQl?=
 =?us-ascii?Q?iqICOExIPmh3ELY5xYPmSIn6skqWfsAK2xffjUAM+6WAyRwH+DSyzE12O0Ol?=
 =?us-ascii?Q?pOmO6q4ZAzAFTwyHmv5/oV8UTzCG+xkf8cHJsaaCNYKnGE3Hyjb6PpjADyP2?=
 =?us-ascii?Q?eQcVL3ioDWctP8GQbHrYPQ5w73rbGH+Ma9+/8mRH6ktGjR7ZTNRzG8b4xAMy?=
 =?us-ascii?Q?msYxcdDR615qrhDXGb1K5Ol09BSoMy6P3jShY+HRT5k+liVNBRgo4P7wZrDL?=
 =?us-ascii?Q?F7n2/r1pNalbPlBAKxxp5NoMZAsmip85OtiASu+xL9FDeEcaUc3Wma2tSnuy?=
 =?us-ascii?Q?CyzPty+g/wlNOcLq9FBnkBK4CcJRZ96xN10+d2d8peGIMBd5vSMXJzlxfFmY?=
 =?us-ascii?Q?u4oWI2wEJkhzpjrlo1Z38AE4Eqg6h1cIaDQWakkywmA9sGewLyYKIKIimD/N?=
 =?us-ascii?Q?j1FNCLxcfv60snFYvEtXNeZ7I4zCvtPeAbgMxJMX0glL0HTXrIGuOiP1iMKg?=
 =?us-ascii?Q?pod4BF5ZqLnEwb0dOTAVat94KPKT4rvmVZxrmVLCBMrRxoRYp+UyzLDimt6z?=
 =?us-ascii?Q?oPUTg5HPkS5+QZJnECIzB+zVlAegtNh3EWL?=
X-Microsoft-Antispam-Message-Info: l0yBTpPAG2gBO2LM8hriZVkRjJjss47/Hyd4ApXLTJQe+TOz6Y5SsdcTSl1qDkGTyBJzLiySIKrpSy4WI2oauysjzsCkjOrY1knNlzXQ/VXyZH6LNiGZmAttFfZQfXMO6Ynb6KfTDJRjZhr1m23yPa5FvHaCGBIGUprEHI6scEUQlhc3PJrTkXnACxjwsGipGc9AYww+6UwsqebPmdaUV32HAKiHcKusK51LyZoOKqIoa9/tZNyB5vXEPkSrIkf4EGHw1WW6uTaV6AmCN03I8byXEYh7dT6SvcoKBYHoz2lP2O4GB6hYV+flcfWEOv10Q4K/Gew6dcdTbTMMAp1+PtX6lKClJDGajMD69XbS/NtOJiVxU+sOj4PEmBIlBgY3Yj7WyQsWRAlU3hFx0E1DJg==
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4715;6:6d4pLv/syhwWlhDyer36+pnNngJKhVvoXbwlH3X4pXAON5FGoLudg9ubCoer9AJ1CbNai1qFZK4WTGSTH5djq+diMiJ5iqgQUB/hjHSvFkwz0AspSVxMWwgXIBX9aQKfU3uWuZw29H8pSZfh7t9WkS2CFTz14saVmgNPw8HJpgEAukfY8lpR23Md5SIu1dh/ySvM4yboyqKPerixPf4o7n2hlW+H4Y4gD+IDv/jzGE2nSfQEHYN24A7yMSM00OnM22J/u3YzikKAz6E/iHhtFMY3qqSaHQ7n3s5P0xfr8Oesvx14sVZMn+sp4QYJZKudDyaxHrzEMnD14fgvnH4Zv3NtOlBrLp1UL15aqW900DFM7Rqh0iJl8lGlDggVehKwXxNTt5WbsL7i+u8yQzLXkiOHT02QzeidBW00BLrDOYmIaufx59cpIvxSzn/0C0fxvDOH8fVTWMilglvZFyFRHg==;5:yvHzC4lBu19C4asKNs3ACNhAEybQX+hKeNIsc6NOzL/XNvdBupO9atpgpx1rtRXxFoP2CdlppwXv3HkAuXEJ4ZpwJu1x2uiyy4874asnB57tyCveEQ8QviRmbw/pbD69XBo4To2HmB9HFIQt8AZOXsJ4KlT0lTfOASu4+l6eDH0=;24:StsAcSgzPn1Lvrd/k3u5aCyJatc8/khe0iy4hN3vzIHhGAX7vXZCKFcdFlL98SUEdwv/zauvgN8+JvHaTZoH6pODF+8SbqsEW/OEKEtDLF8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4715;7:CO03hBhDCb6J+4vxCmb8eezPJAeQhNtLXutmQKOiUuZik2jpuwtxqNSEG5yDQimQ0sfQlL0riXSN2EMqdkvS2VgbKeqQAgl9Keb5FhJDWlBMK19RKqSKEKdqYNHn6noCgfsOERgJeszKLUCFR1Dduw5b87j8UYIPMA8K3OVav/qwGC3pkgxNpMsOVPYmOPhmjsJ7TXZepbhHYPnxZ4JJknLQ0RgoRR1e3l7Aerlla8c+C9rHCyt63BnTERaBCeqP;20:9YmEReAD7VOSgUpea3LLt7k1LNzE2eQVKLF+U4Angk9Bhh5b6HsF0bs+HGRlQaAwYI48ra4KzmjhNUTu1aYasaQ5LtcxwuI7bWWw9UeKPZDLpWl3DzulPUqrqW69fYHgGFUoP1l7UW+MVvfbgOaw5zVawZgKAfHBRqVCTimhFv68w3hHBocOUV+ZGtxivjrXWwIc8BJvAVS4tfDgTFuAEHB7bEH14TPdlXNgLIeyZhGk/mSewHLVQ6H72n9dJTQ4
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 10:03:34.8773
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0e686ef-f7b9-485f-2d17-08d5e0cc3d57
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4715
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@free-electrons.com>

In DP 1.4, interval between link status and adjust request read for the
clock recovery phase is fixed to 100us whatever the value of the
register is.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Signed-off-by: Damian Kos <dkos@cadence.com>
---
 drivers/gpu/drm/drm_dp_helper.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
index b6a27ab..92f3880 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -152,6 +152,11 @@ void drm_dp_link_train_clock_recovery_delay(const u8 dpcd[DP_RECEIVER_CAP_SIZE])
 	unsigned int training_interval = dpcd[DP_TRAINING_AUX_RD_INTERVAL] &
 		DP_TRAINING_AUX_RD_INTERVAL_MASK;
 
+	if (dpcd[DP_DPCD_REV] == 0x14) {
+		udelay(100);
+		return;
+	}
+
 	if (training_interval == 0)
 		udelay(100);
 	else
-- 
1.7.1

