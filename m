Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B395BC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 451752251D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="iqQ+Rqzk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 451752251D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934048AbeGCKFf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 06:05:35 -0400
Received: from mail-by2nam03on0085.outbound.protection.outlook.com ([104.47.42.85]:31456
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933512AbeGCKDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 06:03:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IocJyDoAi3Ef/dIOaj5MU2Kxy8FqA6nOfvXiUYUVnbE=;
 b=iqQ+RqzkejME3tikoHX7d1Z6o9uosu6ZbnI/7snf6AjyYZprL4YJ7KbNDeumD2jxuT1g2Zigd96k0FI1oY2WHB/Q6/F1XPEm6lJiuZnVCq4h4YmItWeUEFtlENyiSHTLQ0AGY3fhlRj+ANQDHOzlBRYZjY2A7Sm0chXy2tD9QjI=
Received: from CY1PR07CA0039.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::49) by BN3PR0701MB1332.namprd07.prod.outlook.com
 (2a01:111:e400:4018::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.18; Tue, 3 Jul
 2018 10:03:31 +0000
Received: from DM3NAM05FT022.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::200) by CY1PR07CA0039.outlook.office365.com
 (2a01:111:e400:c60a::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.930.19 via Frontend
 Transport; Tue, 3 Jul 2018 10:03:31 +0000
Authentication-Results: spf=softfail (sender IP is 199.43.4.28)
 smtp.mailfrom=cadence.com; linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 199.43.4.28 as permitted sender)
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 DM3NAM05FT022.mail.protection.outlook.com (10.152.98.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.930.2 via Frontend Transport; Tue, 3 Jul 2018 10:03:29 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w63A3QXe018943
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 3 Jul 2018 06:03:27 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 3 Jul 2018 12:03:42 +0200
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 3 Jul 2018 12:03:42 +0200
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id w63A3Pld029617;
        Tue, 3 Jul 2018 11:03:25 +0100
Received: (from dkos@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id w63A3Pcp029616;
        Tue, 3 Jul 2018 11:03:25 +0100
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
Subject: [PATCH 06/12] drm/dp: fix drm_dp_link_power_* for DP 1.2+
Date:   Tue, 3 Jul 2018 11:02:17 +0100
Message-ID: <1530612152-27555-7-git-send-email-dkos@cadence.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1530612152-27555-1-git-send-email-dkos@cadence.com>
References: <1530612152-27555-1-git-send-email-dkos@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39860400002)(136003)(2980300002)(3190300001)(36092001)(189003)(199004)(2616005)(50466002)(476003)(126002)(486006)(446003)(11346002)(426003)(105596002)(106466001)(478600001)(69596002)(87636003)(50226002)(76176011)(68736007)(54906003)(26005)(53936002)(26826003)(51416003)(81156014)(81166006)(14444005)(48376002)(110136005)(186003)(16586007)(8936002)(6666003)(2201001)(305945005)(47776003)(5660300001)(316002)(4326008)(86362001)(42186006)(356003)(336012)(2906002)(8676002)(36756003)(7416002)(97736004)(921003)(1121003)(83996005)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR0701MB1332;H:rmmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT022;1:WZQVZ4gSW+bGfZMZbd1RtiAmF6cQ+XAaegLKk4I/yXY+p6Fn5vLYvT62dFXMA9deYeG604mM4tmpSANruiykS7Fmi2lFmchqsBdrTDdKAixbWL4/suqsDKCDRiLCHAhR
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a57e2a88-3846-46c0-23df-08d5e0cc3aae
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BN3PR0701MB1332;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1332;3:QEjlgC3uQBDUaYqVdZJC2DKFDZAIxs7TVwyh0+mxUwkD4a6VANKbI/2TtgqLulBpVOYkaAvdgsTZQf5t2SQ5WHIhSWMAiRY2J/FzOUYjHoyid63P+VKd0TeIo/dvEoPw1d4h5aUnWGD1D38xhu0cn/lk76poegBwBwBU/2H0s6v8m4cIxpA1agPGw5X0IMI48p/z1a3knuAQIMnAnZkABMWIh/sRIpP3O7JkA5U6TYKJV45T5G6x3vUIXAylq8cgBHwUPFp1ObDry1oSXKgLAJKQzDrzuF6MD8LQrK8I+KqBn5MS619lbUD3i/+bfd0YwVRPA0aeNVKiwp+e22Xyaw==;25:bo/3CTufr/Y7eOoHGDbWs5EQccpYCFOAODIEumaCKdb1SqhuOL7EbiaDxJol0UYAY34EZgBLhQGapyCULdlm3JR5cuN6ALTaBpWIhw0ngtkWbRJgx6vUqCnrQQWv/hpMAj9W/zTbrArrzcJahS84pVHNEMVNgqOw6B2EoHAsXZKrbDD6TFUsm6cOS7EhJrQpRyt9ysnIcoJ266MPNJKYksM0cEla2lVwiaCWtX2OdIyBjd+zh2n9MHVMgZNmbrMtG7fosPxvIjmg1jv3Lfq87p6qW861DahI4vCWDQdhzrBrMyzwakjFgZ/tbIq51fQdIKIFo5Xjlm8LQ8M82P/M5w==;31:TRkVQ/PVNl9gqfq/Xk9vuDGqjVGGAI0Kajq1mAkGGqrFIxYeismwRI9b/1d01n3xIqXba7ZtRgyIUb8MT/gvR4tlXFoD6b+vy/B2su+kFM07ga6JkG9i9kIpA/ME449qXNN8h3Fa0z2HXA7gnsw38Ws8SJZArRJhDhxok4uSnaDLJz4NBQI0YMfpgO0EMTgAKxUNKpiYW1V0N8q/3scdsDo9aB4+TK7gXfkH5zGymMQ=
X-MS-TrafficTypeDiagnostic: BN3PR0701MB1332:
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1332;20:u5BuDO3evyHeCVt8lh3zOQF5LNMEyJLzbn2fuB9fRXx+fPJi2tQToqpTzsJBPVXrf6iQQ8WF1aFsGHGEsP6+Nytt01jkWMmhzsb/zkrlFchizq/VRiZj7UY/cW0yxfRfh1g3dL1yYtcTHACEb7U/xE4fUGkk9cqXQyruFN/JLL0hM1XDzh3Xw/6aCIaOBSGW3KXXolfXB7z+GOqy+XJYq+CCej91jn3+O6W2nbBh86A3UhGoRp7T5rrPwgmOthTpiFQN9w8y3ITLK5pjgUtsr5PbpwTKwpISN8fw7vcaIUxcwuQkoYJix/I5DNBklvO9lpg23n7aIY3X+uMLwPA2+a/jZjAVBTRsCuIobw/hdat4F46hvcRMFJKbcDY/zrbh2nWP/+RTlubUP8GqyrWWpcLiaPWWXzaFiiJK6DuZgWB5jFveCkNjFAMWsItG4i1aizIUBOcWR+YfJqx4OdUbqbUanAhnK54o7RJZA1SAqevq7OuIQ2KoFIXeR6J09QYJ;4:iGiwOTMb0JL2+tcB95u0G+cGtG1t/WypeHtIm6D7yPL62uaBLnksVcqcsKbrrkIpOwb5M4I82axIi2RvSBXWmNFGPX6o+o/D4opj09WxIjzAHPajzMpe9ZVuKHck9rvnnsTy5pkkM1rI3GRpswrI4fpeiCLBAQcVPTaaejHisOAchFOilnMFRR3roQOphzCx4m7Q9hdKyvMbkWE8Mz30603FDH+oiKHa1Epktn7SD05Q7nkDlYcbDQ7+eteVjEKuWUrRRE/sZ5oAKM0goGIsRNA1z0j29rCj631nowiSs0VO0/+s4OV4nu9EhjihDwBNcUn6HAhPCV1ORCfMtH3U+Nd7W3uldzBU10OsXg0hGn0=
X-Microsoft-Antispam-PRVS: <BN3PR0701MB1332AD887919E8DCEB4F6136CD420@BN3PR0701MB1332.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(58145275503218)(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93003095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BN3PR0701MB1332;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0701MB1332;
X-Forefront-PRVS: 0722981D2A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN3PR0701MB1332;23:ia2gkq0oFidjufxL82tziKko2AgEuL5+/vTTU0l?=
 =?us-ascii?Q?jQed8grA8Qlotn8eCEHCZ8+9Z9oghJhhFIoYmoaoUHYqMnd8r8Q6Nk9b3uXy?=
 =?us-ascii?Q?AWB5maV252jiHAZAk8O7EfOeWNm6cMa6G0u7qy9TahzDltMdr7vNinKHqNQ9?=
 =?us-ascii?Q?ccvvyGHgGs+pPOEPuDZOT0EDF+NxsEF98dyWXBmUfHLc0G6vwoEOezISh1lw?=
 =?us-ascii?Q?HGqrYA6iNwvcao+ajsbaYG+krIA/Lfw88kx4YKZQjmPAIt81+ihQBWQ4r7IV?=
 =?us-ascii?Q?0eMNFNEUFKKqD1iJLEAIt9UgltYXGB1visVRSbemNpE5SVaJm5N5fuRP0iwY?=
 =?us-ascii?Q?wiJGrXSN7NQ/jNn7lGc92IRmFfT6wpfo9SpB2Q5/iVG4OeZkttL59rtLYjRB?=
 =?us-ascii?Q?T93yt58EoZxMDolG6rybOK+gygJxiJiUws75zWYL7WhbEOiskWrhy9YdHBs6?=
 =?us-ascii?Q?ln2EfFGPNQ4JwzNd+JRo/CbWAPy0DmQHrM/45Wcm/6LVajzLuym6QlVeaV07?=
 =?us-ascii?Q?zoe1Uwa2qoiFrOzjxuOlpfD6gcbD3BnL4tYgaku7yk96MuWNcNWYs8aPVp8z?=
 =?us-ascii?Q?CTH/ZDtrp/oHQie6RQBeKJxanhoscGjBCKVYWjvoCfYBwgrljfF1Lykfzbvh?=
 =?us-ascii?Q?Q2fUTNYRuQxlvlbwkzVaDAQjHC7uX42i9eFSoK7q0x21sU1mxyxwPI/PtFO7?=
 =?us-ascii?Q?mh7xXjDVo6hTUL2yMV7/9Fju07bjsEFbf8KoH1Hr1xBMyG3puy0oENOwEjBr?=
 =?us-ascii?Q?sKH9rdkeAW58jhdgD+pWr5P6kn2TdMKKWH/nHkEPkYyrTTLwswGpc1vCWSp3?=
 =?us-ascii?Q?8Q4FTfd+QA1MGladGSqvMBZcOh+Pk+3LKZ4mo5AD4od0QtGAkyRVH+DNeK1u?=
 =?us-ascii?Q?jK6WEAosEVHQqIFA93N3y1JvD+WGYrq6Q/PKso9BO9fNmfFL/wI7Ebxf+ZNC?=
 =?us-ascii?Q?oGB9TXilOX10z5mbwXJEf3aV2X3lCG6CMfqUx3VQLhKYnW20GQcMoS8UjBBa?=
 =?us-ascii?Q?OLU/p12b8jmXl++XAS4NVrJuQw0qsBXtQ688U4W26L/Ws2CuS12Bh+47JkQi?=
 =?us-ascii?Q?MhLgyeYLjc1D2Ob48rndp/IR5OnWYeWbzikPQwxGjNX53Nj/J4HwDNzYxTNM?=
 =?us-ascii?Q?cpCJe/TuIN2qFUktR9iB37IGV9ze3sexRqmwI18Ji2Y0PRGrjTlt/D063nSB?=
 =?us-ascii?Q?iWbMLfd5fAhex1FXrngPsfMdGZi6xMGkMFtb8JvW2xh62GDy6KIyU9yj0RqT?=
 =?us-ascii?Q?MNpe4jF9uwfMzedYzAcu66Gkx3mnXqcDSTH0AlrpQHGXNP1chrW9B+B+zT2I?=
 =?us-ascii?Q?Uyw=3D=3D?=
X-Microsoft-Antispam-Message-Info: 5XDGYgiwB1io5QZIkDvo6Ya6FHcEWu6IUWqbsdBTG6jlPafna5ZbRSiKNN/RjX1R2MFwG8KVZQVDBWK68jbx6GH+Wz3I85EQUtMB/FT8rL8wAM16kkqLwSg3/NWdKSSnwH99S1tGu5JwPfRtcIqEhF1Nf9Izvmf+JWUG7kwMVYtOkPFfuVWQFclwnNcA6A/fZoBP064qZ8/YTEJzVx4hiiOa6LcVZ8Mke7mOrNnR0VcQLtLiNFAZ8N1SRkGgTE78Ozps7hH+0ydrfjm5gOFcUfHsUSxcwULtYe87jf7PihzSMVJEMzlOYQjBV8ZMJeoLF3m3vtcBV5E2L31nah8UX5hp31kJ3TCEec7QN5BqbUmTRLfbKB6BZyMibetn7snAJ1DCUAu6zOC0ZA8lBEOvdw==
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1332;6:Ja0GrMd23s99lz+heb12LmjnKuAvrpSU3FSLZIfBEX4OzB1f1D1GP1NoZ4I2mMh7DQRVE+9jFzgySnI4ffZDLmORzByYQkIwbbmDnjyXuJWFm1MEpdiKNHn9Yt7qXY3XibP5r44GytjOzGxuRs11zycewJQ+PNtSRxN3L/R+2nqFpnlWssxJgpMdiqRDZ1aL/ihHWLLiY4uaDBFDRcm88xuSbLf3cP3AET414QP7ZQvTuzaH3o79iDKIjTpA8z2XS3k5evpmpjT7ATB1AzUMrywqWDwCTFBfKeKZYPS9uoOGSsuuR+QcB5QnhamL+Vc9rkYHeWUtiCiS21BPzRftcQUQ/5cP3VMcEBwcdLhfKBpFHYadQApqnS0W4WZnKuBV1PwQcBkA6s82CdU6B6iwKvef8wcNveHKiNAzgPaRpnjv3pD8mjKVDJmtwKGjwmtvieWODxWFLTSZ2tLb3pZtAA==;5:+cdT7kY0ixcxniBn6OZ5SHkjyGxEXQE2CHneIHdFvCL6iqw/BmoK+tFAtuKyGYMNISZ9gIR3714+wHForui4dKjc5bm5dlRUF7nGQyvSXs5CQSlpX4rJ1hJbAF8xH9XXxYIiJRgJL49d76SbL/QVFgxgsiSs9DsjrqoFuyVCfzc=;24:ShZbB9Lezd3gh74yZKthFfrPC8qwj7wmtpVwTLK/usilUQN/K9uW0cmkt3NLu5WZhDUbb6NjNUyFmtT9DTlkrs2JnnXXA9nXEH3dKGmU8+Y=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1332;7:fWDvZiS5pi//SVbgZu5wCivEIX2JbCr/vBw1ioZTwGFS/T+aFoipVAg8VGVM7IB4DVuIA7OB8eZ+v2yV1dRYOAR/pTPnT9C2vQn/qpJaDcL8/yuqqVNdODO5fHE7Eq473yS3srKa0e6DIhueItH4t79HOP71r43hRAcdtysSZGc+s8VZpYejJGpDdt+ppEHnUnvqY3n6e0hOMcjyvhmlU5yKjdLYX9el4tpGqnS99bCpp+uPHfGvHCc0PB6QmTRs;20:Hgw68w+38KiTIDLcqkY5WCMqVhtrC9lOKZuHizN0aDymCu2fzPxWGhaP+mWDthIKgWuqREc4OvqLjCyRXzTSV0NJRyeu1oDllBY69jfe0DThNEdohYyPV5COP1sJOxup+Wz9s8Ts9jxwejsUxtxwoRfbLwMDMsDsV9hqs0f4RqksC6bxK+zWkDXZD44PC8XspSShlkaZuKAteBILmIojbGHCsudCsJJD8tm4uVMzJ0I1JOwnsgQAIMKhbhicvseK
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 10:03:29.8359
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a57e2a88-3846-46c0-23df-08d5e0cc3aae
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0701MB1332
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@free-electrons.com>

In DP 1.1, DP_SET_POWER had only two bits for the power state (D0 or D3
and two other reserved values), thus DP_SET_POWER_MASK being 0x3.

However, since DP 1.2, DP_SET_POWER has 3 bits (same values for D0 and
D3, a mixed D3 which leaves only AUX powered and five other reserved
values). Thus, we need to expand DP_SET_POWER_MASK to 3 bits (thus 0x7).

It is safe to expand DP_SET_POWER_MASK to 3 bits since bit 2 in DP 1.1
is reserved and read 0.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Signed-off-by: Damian Kos <dkos@cadence.com>
---
 include/drm/drm_dp_helper.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
index bd593df..a63a548 100644
--- a/include/drm/drm_dp_helper.h
+++ b/include/drm/drm_dp_helper.h
@@ -671,7 +671,7 @@
 #define DP_SET_POWER                        0x600
 # define DP_SET_POWER_D0                    0x1
 # define DP_SET_POWER_D3                    0x2
-# define DP_SET_POWER_MASK                  0x3
+# define DP_SET_POWER_MASK                  0x7
 # define DP_SET_POWER_D3_AUX_ON             0x5
 
 #define DP_EDP_DPCD_REV			    0x700    /* eDP 1.2 */
-- 
1.7.1

