Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416F6C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC89021479
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="mysC1px7";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="LeSNkeYz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC89021479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387652AbeITVFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 17:05:44 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:49016 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731946AbeITVFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 17:05:44 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8KEqCih025328;
        Thu, 20 Sep 2018 07:56:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=9hF5p61lXEPYmzPaaQrAx83Ryau8Ft71kqnNwJGlB18=;
 b=mysC1px7F+QeJvjIERNHMM+nWlLoS02Ewv95Nb/CXJXqYu/a2EBlPe7R82Ne21N5MTxB
 g5uQLSkNH1q6kRUCKsaGysF4+GVWhlICSwp6Y4+oQc5xPNv7OJJOgGDtnlr2tXV7mIgG
 XCMIpp2Bvx1KluIpBfepgR5/VAtoCx6D25MQYkA1KfOVmhvEiOqda1sHBih0d4668C/G
 0xK9p+qZ8uLe2zk2hRv6La8G09Rpd8B9JMuOCa4fHjA/KxVzp0Ek/0HqVRKivc+gGM7j
 99IPyji+foc4kBBRdhSM6kIqtyvJEnRViZ6Cnrp6RKqfxLQqtEUK+KuHLx2sKWrNA7Vy /w== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=dkos@cadence.com
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp0024.outbound.protection.outlook.com [216.32.181.24])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2mm4h1a6tg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 20 Sep 2018 07:56:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hF5p61lXEPYmzPaaQrAx83Ryau8Ft71kqnNwJGlB18=;
 b=LeSNkeYzG1wtPIgNgjs2GDbroqsElAOrU9QDFxrQipwswM1dfqU7S8JZ2s0wvcXuwe5PjTfkqV6O8n3mUiYXpeSwdYsuE4qOiVpxGsVZbjiK/rKaDqAmL7+LxUF6qg8dd0dzAlnl4XBpB+WVspJ4106U/J0iGCCKLj6xfewozzU=
Received: from DM5PR07CA0025.namprd07.prod.outlook.com (2603:10b6:3:16::11) by
 BN4PR07MB2164.namprd07.prod.outlook.com (2a01:111:e400:59c6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.15; Thu, 20 Sep
 2018 14:56:00 +0000
Received: from CO1NAM05FT044.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::202) by DM5PR07CA0025.outlook.office365.com
 (2603:10b6:3:16::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1143.15 via Frontend
 Transport; Thu, 20 Sep 2018 14:56:00 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 CO1NAM05FT044.mail.protection.outlook.com (10.152.96.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1185.5 via Frontend Transport; Thu, 20 Sep 2018 14:55:59 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w8KEtsWP002306
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 20 Sep 2018 07:55:58 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 20 Sep 2018 16:55:46 +0200
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 20 Sep 2018 16:55:46 +0200
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id w8KEtbrt021886;
        Thu, 20 Sep 2018 15:55:37 +0100
Received: (from dkos@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id w8KEtatN021860;
        Thu, 20 Sep 2018 15:55:36 +0100
From:   Damian Kos <dkos@cadence.com>
To:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>
CC:     <dkos@cadence.com>, <pgaj@cadence.com>, <ltyrala@cadence.com>,
        <stelford@cadence.com>, <jartur@cadence.com>, <piotrs@cadence.com>,
        <quentin.schulz@bootlin.com>, <jbergsagel@ti.com>,
        Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH v4 2/5] drm/dp: fix link probing for devices supporting DP 1.4+
Date:   Thu, 20 Sep 2018 15:54:37 +0100
Message-ID: <1537455288-20223-3-git-send-email-dkos@cadence.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1537455288-20223-1-git-send-email-dkos@cadence.com>
References: <1537455288-20223-1-git-send-email-dkos@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(39860400002)(376002)(2980300002)(189003)(199004)(36092001)(8936002)(478600001)(48376002)(50466002)(5660300001)(4326008)(76176011)(11346002)(87636003)(51416003)(36756003)(26826003)(305945005)(50226002)(426003)(2906002)(14444005)(356003)(110136005)(316002)(54906003)(8676002)(476003)(26005)(246002)(186003)(336012)(446003)(47776003)(7636002)(42186006)(2201001)(486006)(16586007)(105596002)(2616005)(106466001)(86362001)(7416002)(126002)(921003)(2101003)(1121003)(83996005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN4PR07MB2164;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT044;1:zdmQfY4Ip+BRaJwd8xMF1FpCEe0+5o6U0WjvYsFYajkjohVu7jyc3MFpa400ADpkhkJFnlImYkA8D08qJZdkhq9LcpTZtRHEIw5XWEUNMZEneA043wfz4Rz/imNJBlv/
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6028355-1685-43ce-7d16-08d61f092db2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060);SRVR:BN4PR07MB2164;
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2164;3:WSHxIMipnWEG3cTqv4HPawESkuQfjeA6moIWyJw/m1WncVMYjG8UnywQi//gJZgLw1gg09CYRf9iZ2CmKN1LAgzNdz9o6NI5sZeg69sdJPHOTAuKJSKGLxe9SlpWxQa5yHPlvpJuHC7vCmRfzie+8hoyHjpg1ZOuA1u82HriG95zl/pfj8p9OFC4G10R9OBYM7ayHeQPeo/Enfi7IQwiveCgcMme0NMDhRJOyC74bg6uJTL2vSjQJVovFUjC4+SgqqpMcaLgXA3VKoUVzVEvJXC4ZCR0Acho31WkPk00GSTqMYHZuhNdzgAMxrqChIyRtFlIkaniNKOTL7/7+D+yQtNG87Sn3eC+T3TMhix86c8=;25:u1EWhVaCpyaHq392bCawaPdyd2Y6mHjsiPd5tFBicJa5HlV/wd0N3uk0CbHPqPWtJFkldcn+75hsSJdrfPohFvAH22j5TgzoXJ+NgWXzD12BwJs9w8ssheYN6Gte1JcnMrpOHwlzK63tIelGth+pU1t6j5esRtj0BmcRWOePf/qbTPoWYjJq5Y7M39u4oGa79BlAnUmirKp6KLsL8cmhnvnR6bXIaBGjQ2IJPuHKQmwEojDDbOt6gl9YGELab9QiNw/T0zEYXNqnITZqqaZ/zTZ/7EajDhgaTN/fc5M2jAZ1+F67iQGpluQKSrF/ERr/p/LYr/sWjgOJQuqhWV1GXA==
X-MS-TrafficTypeDiagnostic: BN4PR07MB2164:
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2164;31:4vsjN8uNlsBPRu3lVrlyGMUokueAl4WE0rXdyAdfP1c1/y7vfd7zc0yty8nHNlui7JsGohTIJ/Z1PBS6YvJzEImOjLUy6aEz/JvAel+qHR/5G61i3VyorXH1ibnjcE+IHnkBDZf+A9/Z3DZlUWTaQ/KB0G4GsXjANgZ3GMQ2BF7vrQsVdx/fwgnZVS458QbA12iGmWFiF8W3y5CTgxaYvx1yHuAsIkNE1waB2VXpfE4=;20:pOFlPFt0+3g9WMPAUBl3VKSqfmpcDG5W6IbgqIy4kdFJbl8F+H1pddd4foY45+j6UVzrYXr9eTPifbOc1bfVRrDK4OgVovk1neQ4zpORyJpHprvQcsekqBDYnkWYJTnsKYPgMgM0nGyfQ/BG7Z6HeuCSAzQW/nwLK2ozyI4g/zNzetPibvX0EGDO4U3vud+k3iBRQ9B8GDmo+/20QzpSjDc8ZEzVaYzwFl3zI6sWdMv9pkcLrNo2jdztUQGBSld/AVJNLQFL+d1P3vLHlslyA+AUDcEEehjAJ1KCHDTFQJfSFY1/mazQ+G4ygaQxSyaMxFr/vO+5W68Cju+gVgVAyQsX+Lh7wNwC4WamEod92bxnhx38xuPNep7YFO7JtAKMwIEMpP2auTeLxiYh+RxCw1IVOGM4h8coZXFQeBAo2c9SEqJ9cUvQRWIlCnDYV4Yx3VlRAoqoXtrj63u3Fwo4VsoAvFZMlRCvqZzxTfKgouYFEjEdqKyJPWEm/bEzKlP1
X-Microsoft-Antispam-PRVS: <BN4PR07MB21641BA9F9138AAADDD2FAFDCD130@BN4PR07MB2164.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(58145275503218)(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93003095)(10201501046)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:BN4PR07MB2164;BCL:0;PCL:0;RULEID:;SRVR:BN4PR07MB2164;
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2164;4:fn9+elFWqPhlyv4Ea9XE4wul9sWbem8QPKmV4qlHprawmz8379hAjeXkNrv4jRzCm5CmuLdfys8jV2OJBSwWI41fkKV7fQl1Yv9OF1P0FVYr3iv9XvWtAD1AGUbFrcObjYvRxKUERPZ8+48dPAa8egrEjXjdAef27zrTeO86cGHXe9z0XfGPygjNtuVCcP5FVS1GuX4Cirv47PxrFs/78w9wiEur5+MTRpvozSw26Z230rZJb59NT5aihmNaE72dHElAGp6oMofDUFIniP7ha8F/FE/LTl66tbpDlZ5jiJw2FZB5X+2wyJqZHnV7nbCI203s2zwryzNpSFm3VtaP0+IT0+HHN8WkRDcE9vOZjDA=
X-Forefront-PRVS: 0801F2E62B
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN4PR07MB2164;23:gOp0iy8AQksT9j9Olui8/17wdGp/ZVizsSXkzZcIT?=
 =?us-ascii?Q?2sj+270qNTrUk4NHK/Fbd/a6esnp9JK6gtLWlSCErhGc0Pj9L4TxFemlWVc4?=
 =?us-ascii?Q?sh59mMhfjSZYRITXKmqZfsen4u0o5oNduwWf83VHXgyKwwdkMZW4qARftxoc?=
 =?us-ascii?Q?RS0tHPl/g+arKSV5J2Ps1CsfIH4Psw7G1B3FH6v56ZFFQfBdhXeSS2z56qZv?=
 =?us-ascii?Q?+0TYpBghwCnd0pvaB5Bc8OyUVyGCnqU+4Pxz+MfiqYfY+wqXYfZGO6vKGT6Z?=
 =?us-ascii?Q?MdZN0bbu+gNpDHhljYgTupgWdBCFgAtrUvIQiUZOF7lo9cz6wZeBA0zzf5Mg?=
 =?us-ascii?Q?mWZjUAiKwLghcAfuKWQSFcFg84F1tO96YEyc5afe/wKh6wi1WiMF2+aI1/kU?=
 =?us-ascii?Q?9SUSkNyt+TQQezXs+OSvWHeC6NqaNwQaZZZpVqcvi5aXQ7mjSDxU028QpdS3?=
 =?us-ascii?Q?ZagslCdO8pQk9QMhCl482hEw6tIgRT6c85RmZSWOd151JReVGj34IVwQPFc2?=
 =?us-ascii?Q?3mWKUWr9cpl58gGjF2/vMbcGwxw8oJ2YqFZoJKOYNnuIASrx5w2F2Exej9g3?=
 =?us-ascii?Q?xwHgqiKkL8jRYGMhtIDjy+/9OwzQQcWIc09RG93FJxrTSmnPJHRhSJ7YZL47?=
 =?us-ascii?Q?P/7SQ90vlU88rGCIhcKfHJRkScTcPHPXM8+9ArczUvF/uq1gbiaTzwN2ox8i?=
 =?us-ascii?Q?UQuBfbizNb6PoEB/3veco/Y+esjEuvneZAYkWZ22D0qp23To14+3kUGADb1D?=
 =?us-ascii?Q?bAjUgUQK2GtTko0FTimUoPCiEkS/1h8Um6Yy+1ctmuICPnB25aigoFCXBjZe?=
 =?us-ascii?Q?bsmNPDVxwB8us0M9H3TF2OuZObZs4QvE74JNCB8xpk7yo0gGyOfGQ9XBNHbg?=
 =?us-ascii?Q?2XJWH6nvBLYV+23LcdLSyGTr6gsQdETiFuomcajx6jW5Zwyo2ARgQU+F05Pr?=
 =?us-ascii?Q?wGltEOIraQO0a3efUOF9G8APnRgp6YT5r/dEwHTu2rHduHElruqHfYjZV27U?=
 =?us-ascii?Q?ex+VMiLN/1rA6+k3teJ+ZMKERYm1P088dFkngUjuCoVGnG3ZiTNXalDJ+Xnh?=
 =?us-ascii?Q?lzF3dTxR8Os1aQJkPkkVQlLJlgR4GGteoDUlO4/ubY0tqgwQLwOi9t5FX6HD?=
 =?us-ascii?Q?r01pI/ITDD9WnPqs+Hwp47GnJYWqe+3BwR8CrLKvgcRuPGzWgieYQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: XcjiiD7Pq22kvB04PXYPE+bz4JqS/VUiB+L7A7KgpDvWadhSK9kGN4TKkENAyybxCAy6j9Y2vhm/l8o779zG5Dpp0lARmxrUk349bxrNfCoIh00jHgaTQHMVxDqAj8DdMs2dCw4KtjsDRyfavWbHUnl36TFYUP/qywuYxePAY+e3LbvBpUAJEfqHoPE4P0jtyDHYDY1Rb1CpfOwjmpPIMxiqEtzsQUyn5UiWaVWykgPxCkXfAlsAlvCyymuU9LMXQw1hGplhvpKrrx1xWQgHT7Q6MD/UM1wSCMq+xpFeCEAi0/eT3PerALqIKSP8nX40IH9GKIrqtZ+uBmnwru+fzDHyjGnD8/CMBRD3eB8YB67B4CKYM0pIvfgUzUn90fL1eHdT7dBPouqloip9MAMFsw==
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2164;6:hzJwdBVINgN9Kh4Dcty4xxR8p1UbodNTsJViYKrcXy9KaAp5IyTK1hTX9Bg5Uxr/QRKO4Cj2DHfhCDSJ1Pi5rXhBcXJCLirttWkqRG1kSiaJOVHvSHq8X1ZeN3kempMl8WCv4YN2EpeUojSFCokr7TbTXjG8kHY99uIE8x4vsNSzMoxv3i2YgCIZyinREM14VODwe2oM1i6dRSul2fp6Z0hUs0UXzMJkWS9aU2wLhcgNWm1ATAxZVMa4eEXZ9O7Q1G/f3XTVh01RKpBB/ZJyF9YJv97W414rfkKNmh5gLBjZ+t2u5y7wucgXCJGQ6DYgDfBXztozboBzEWfnnQTCelgh5kTVQ0y7ENIFNgiI6OZDQjfiT8HLwTirBMKNz9TnebqFSAznUTG8GhDfWI74qYdUY5JcIBa/n62xHP5Dyh/SXz1D4xh/ugGyqg1NCPxEK/xnNg7mz1YzD8gRbusNzQ==;5:84fpDeJ/P9eJ35cRppR12jGWSf++1VZ6v2i073zDtqEcrmaFrxn30N0BKqJlwzzTQyN+kSLt2PUBW9ZMmkcUmVBlvt9q2hjoYPGQZY5QHsgACTPyJ6l9xGHulbdOKIwiazKAcwJuAwrxEfKzu16YP9CYF8fROOO1Vsyu9yHOLnI=;7:zl+rJ52grTlO/nFax1g/WxtM2r8xg0riXyvcRuU3OWEiIClIZT4x7NCJlN6cQNLJh75knjluHlbqRihvrHsK01iT8EFlYT+D4r17UBYveLM9ZHdf+f/MFpJQ0K59k/tUoxdYq9K0T/0LA7Gk8R+M6tTw5WJKJGVCqF2tlyp43TcFjNCef02kgszpN0e9ll+fvjZ6FLsz7t+fzWN958UtSFzi6d/DUGPxbz/fYxlnDhW+g465bbSfVnVchI4cYCe4
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2164;20:QP//x+817kG1ELR7SgztvQ9yGxh/Z9MjI4tAwZOkJau43Ky/AAXplHmfEyJkA1Hq+pumTxAAJg1CRhyvk06FZYfPKvtjjbgK51PFiivJV71gPc0yqzvibOgoJcEnMujXUc0LaNnm11t5Zql+bKYQQn/VsGs+nC+9p/r6Q/yac9WiRx4NM+hJdaJmpewIig7gVlrLmk3im9Z68wCQENFv7flCH23x2tTypy/rRYZTHxBsQabKb3CLyjZ+9k5OD21S
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2018 14:55:59.5405
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6028355-1685-43ce-7d16-08d61f092db2
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN4PR07MB2164
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-20_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=786 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1809200147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@free-electrons.com>

DP 1.4 introduced a DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT bit in
DP_TRAINING_AUX_RD_INTERVAL register. If set, DPCD registers from
DP_DPCD_REV to DP_ADAPTER_CAP should be retrieved starting from
DP_DPCD_REV_EXTENDED. All registers are copied except DP_DPCD_REV,
DP_MAX_LINK_RATE and DP_DOWNSTREAMPORT_PRESENT which represent the
"true capabilities" of DPRX device.

Original DP_DPCD_REV, DP_MAX_LINK_RATE and DP_DOWNSTREAMPORT_PRESENT
might falsely return lower capabilities to "avoid interoperability
issues with some of the existing DP Source devices that malfunction
when they discover the higher capabilities within those three
registers.".

Before DP 1.4, DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT bit was reserved
and read 0 so it's safe to check against it even if DP revision is
<1.4

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Signed-off-by: Damian Kos <dkos@cadence.com>
---
 drivers/gpu/drm/drm_dp_helper.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
index 8c6b9fd89f8a..735ebde5c2f0 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -370,10 +370,38 @@ int drm_dp_link_probe(struct drm_dp_aux *aux, struct drm_dp_link *link)
 {
 	u8 values[3];
 	int err;
+	unsigned int addr;
 
 	memset(link, 0, sizeof(*link));
 
-	err = drm_dp_dpcd_read(aux, DP_DPCD_REV, values, sizeof(values));
+	/*
+	 * DP 1.4 introduced a DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT bit in
+	 * DP_TRAINING_AUX_RD_INTERVAL register. If set, DPCD registers from
+	 * DP_DPCD_REV to DP_ADAPTER_CAP should be retrieved starting from
+	 * DP_DPCD_REV_EXTENDED. All registers are copied except DP_DPCD_REV,
+	 * DP_MAX_LINK_RATE and DP_DOWNSTREAMPORT_PRESENT which represent the
+	 * "true capabilities" of DPRX device.
+	 *
+	 * Original DP_DPCD_REV, DP_MAX_LINK_RATE and DP_DOWNSTREAMPORT_PRESENT
+	 * might falsely return lower capabilities to "avoid interoperability
+	 * issues with some of the existing DP Source devices that malfunction
+	 * when they discover the higher capabilities within those three
+	 * registers.".
+	 *
+	 * Before DP 1.4, DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT bit was reserved
+	 * and read 0 so it's safe to check against it even if DP revision is
+	 * <1.4
+	 */
+	err = drm_dp_dpcd_readb(aux, DP_TRAINING_AUX_RD_INTERVAL, values);
+	if (err < 0)
+		return err;
+
+	if (values[0] & DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT)
+		addr = DP_DP13_DPCD_REV;
+	else
+		addr = DP_DPCD_REV;
+
+	err = drm_dp_dpcd_read(aux, addr, values, sizeof(values));
 	if (err < 0)
 		return err;
 
-- 
2.17.1

