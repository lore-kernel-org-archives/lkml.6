Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A91DC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1481E22ACA
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Lsl29czX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1481E22ACA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933952AbeGCKD4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 06:03:56 -0400
Received: from mail-co1nam03on0064.outbound.protection.outlook.com ([104.47.40.64]:35459
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933929AbeGCKDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 06:03:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JfNUsLdb9VneHynwHc9ov7+Zva2xagUqXJRTPsTPK7Y=;
 b=Lsl29czXiQpOAMu/4bRsfudwthBaPfDoKIqN8M8HgVsGnG68B78KRRJnxOVtNlqjC57iZUcaRRruUYZdj5JS8lTRdvH2ghiGEGYT2Ldm+djcfGubIziqTJsTd/mM3mLGqjiv2sEzTwV8Uhw+AMN4v9gCQFO2z54oc8T1sLHJxPk=
Received: from SN1PR0701CA0010.namprd07.prod.outlook.com
 (2a01:111:e400:5173::20) by BYAPR07MB4711.namprd07.prod.outlook.com
 (2603:10b6:a02:f0::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.24; Tue, 3 Jul
 2018 10:03:47 +0000
Received: from DM3NAM05FT021.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::205) by SN1PR0701CA0010.outlook.office365.com
 (2a01:111:e400:5173::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.906.23 via Frontend
 Transport; Tue, 3 Jul 2018 10:03:47 +0000
Authentication-Results: spf=softfail (sender IP is 199.43.4.28)
 smtp.mailfrom=cadence.com; linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 199.43.4.28 as permitted sender)
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 DM3NAM05FT021.mail.protection.outlook.com (10.152.98.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.930.2 via Frontend Transport; Tue, 3 Jul 2018 10:03:46 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w63A3hDZ018958
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 3 Jul 2018 06:03:44 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 3 Jul 2018 12:03:59 +0200
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 3 Jul 2018 12:03:59 +0200
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id w63A3gEP030118;
        Tue, 3 Jul 2018 11:03:42 +0100
Received: (from dkos@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id w63A3feu030110;
        Tue, 3 Jul 2018 11:03:41 +0100
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
        "Quentin Schulz" <quentin.schulz@bootlin.com>
Subject: [PATCH 09/12] drm/dp: add pixel encoding and colorimetry format indicator field in MISC1
Date:   Tue, 3 Jul 2018 11:02:20 +0100
Message-ID: <1530612152-27555-10-git-send-email-dkos@cadence.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1530612152-27555-1-git-send-email-dkos@cadence.com>
References: <1530612152-27555-1-git-send-email-dkos@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(39860400002)(376002)(396003)(2980300002)(3190300001)(189003)(199004)(36092001)(6666003)(7416002)(36756003)(50226002)(68736007)(4326008)(478600001)(2906002)(53936002)(26826003)(87636003)(186003)(316002)(81166006)(5660300001)(336012)(42186006)(16586007)(476003)(47776003)(305945005)(76176011)(110136005)(54906003)(51416003)(26005)(486006)(86362001)(356003)(126002)(2616005)(48376002)(105596002)(446003)(11346002)(50466002)(2201001)(106466001)(8936002)(69596002)(426003)(8676002)(97736004)(81156014)(921003)(83996005)(1121003)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4711;H:rmmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT021;1:pugPzCBkmW6yzWpqeVdMsoCqfFaQbwLFHby91z6B/JmSDGxLB/8utmfHvoa/gms/zBs9jowuyzPIYiIq5N2Q12cxaohczS9Ub4dpkmf4suvusddRHJqf/1as8EM2wT3h
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d83cc421-da52-4f89-fc36-08d5e0cc44a6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BYAPR07MB4711;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4711;3:umcJxMpz4mNbqGrCN7IpWI7oQwXiernIOOSTV3JRDyRAFORFJwSgjIthIvtKsl8DBUcqfUXOF0I8oi5u6Z8Th6zqXT2NQl/X7aU9JH0ivNFl3f662Fu55wuRu+ST4NHcpIjwOiWMAbtLQwIOf3BCVARJC5jv0xpW79ifSpFM3xhZDQMF0xkT0pmK+S8rJUTH7uLhpZHLItiRfYan8gvh5xvA3gv4Ju/EniCfQ/XE08aGlXzQaoqoSJY6EYmRKotibiYAGOs/VHn/vcRzb/arQrDUv6aBlXakEu4QI2UTSav0Cr7R5xtl+nWnFm4VIXPA88ax+5LQuAhbzhuR6XpWoA==;25:UqMXuZglEfMXX9ktghbAVbegxMQr9yU2h0NO1DGDLcR9A1T0eFkxa3LMTfG+ksetLXvwNwCwi2f+ce1RQQChAhqw9SzsQ6vhHtE9oad0bi2hhU/1/MPMeIbfkmtMg2XA8LS6t/NnOuKla9aZ9+uPC1nbYh8OVSGLOs6e8x5AWwmIigIZled2GaqqI+0sd+s4Q0Pn0SCN8ZsXn9Unnle0+zuXhSgFCidsfpqE70KQ3/z7U3FofT8hwj1FQG00pPzGzVzM0HpGzH/gNJTdom6M6PUbfhhb11TTRZ5CtFqJfB6raENYU1M31k5u/zLQQzUgSOK0KED3XwIoHjVkCSIACw==;31:WV2VlBxT1Ft3M5FeR6i0KiIxpeZBUEnpTSAdkBAW/eqt3CYrp1h9++qxgzL6RFlSdFZ1RlDMqN9LBO4xM+dUVj/IhZXjZ6pNehE1vYTcQ24t6bHrvp0P6r3wdw51KKDEtdt8X7ZDzPD0f9sJJZGE/bqi2272wsDcVRxjv0KtIry6ipmATl+lqpVuApJMOqANd3aPfwmY8uMov2BvN2gGbQlGp+0mIhlR9VToRAW6UWw=
X-MS-TrafficTypeDiagnostic: BYAPR07MB4711:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4711;20:7w7OolvJDF9JmbEYpRLF+kumkMGJF8hYvjkCxYRQwAaf1D/z/1Q5ZuA2XoZHzX8ssiOSa5bwf/zSokeisRc/U3Yqc0mEM2bEj8aG4rM65gp/McvBzZApYwlXl+3FxLle+CB1X69D8FkWQ+oviGbBH+gsXAM3Zpif3ovdnxohsJwqZE9m4orGMRCSIDGkjWlJMRUaGj95gmXPpD7H+YR4+0VdlepXWtQf3UDkndu34GqnKCfsCIIcp4WET6U5CzIEfP9AdxXL5gCRr25w2Tz2800Mn0qUFi/YumiEPkwO+7HnWf39up26l3LC0CcD2Rv/1WvhfQxYOUjCNELpQPi0QEjYzFgPeJAiUWyZ9GvEZU2i44AnW8dfVhrE7H/CmprJT7kbOgG4IUInL1tPF2vMnyS3KEE6Z0ljrqrS4m9mi4eQp2yW/YEB8H66Ebdoiaa12X4XlhLRo5go6jW5GBpRvwSZIcvQNjMNxJWUr+3TNOZ3IvNzaXJJMm+T+THOVSCu;4:MQSe7ZcR33GbRsKzybAqN96rSHWpzdVp41jsrCT49L8tujyJYPKYOIZOYvuAKAgShREmpJe4/MHyMdh7V4CdJS6RgYbPk1axEows2JO/qTcTxF6usaWYiF7vwU6osJchnNeMoOPeoBRz5z34IcyL/Sew7+NPx00OYqJWOcsiO7f4/yy8oIAMW5ZCPA2R7Dl17BVrMCBKocuAi/EXOnWQ2lWdqrLxr+etXBbj4QGYOMBkYiTwbyFQgpLtvRfHFC/O1vxgk1V1xuZHR6Q1qUtB0X0fw5ySBFt3m3b0X5xuhhkoyHAqeI7swDH891R7w7A6
X-Microsoft-Antispam-PRVS: <BYAPR07MB4711E8D87F1CFF216DF2EA6FCD420@BYAPR07MB4711.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93003095)(10201501046)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BYAPR07MB4711;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4711;
X-Forefront-PRVS: 0722981D2A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR07MB4711;23:dfRZoMpTZmf5WzhsuMWVTKLfjSnAIk7kajTNJE52q?=
 =?us-ascii?Q?zJaKCDE4BeIG21Vi6I13bS3SN1ekYIFiNUzzoPCc188QqFQi/8MAIC6o4up8?=
 =?us-ascii?Q?azN/QtU9LAhKQDga19Mu9G8tlW5SKbqTFpJpAVTn8NqJr849Qq7W19TwHJt0?=
 =?us-ascii?Q?nZgAocLHPKgikOTY2naiXPn+hdcTgmdYX3ghVyebpemE9GYemYZm/8YeOerO?=
 =?us-ascii?Q?roSkjyZyFHm7boYo0G6VOWzje/kes6P59rwV6P5qME00Bh748A/7EOWrlJRX?=
 =?us-ascii?Q?lgj0e8oGCqkhEq9NdxfUakkO03EUgAo0wdPjH5urEagaXuCjHmTsFMwt2LVu?=
 =?us-ascii?Q?HYFPZ44aS0bv9pL5gQyAvoEJy5HeYta1bc1KtbuqXNqKgFFcRgbjOo6dkuNQ?=
 =?us-ascii?Q?+QlZUf6KA8LjErTuqffn7Kuo11iI2uvFiav2Oh1IPkHxQoWMtqDPGgXInAVH?=
 =?us-ascii?Q?EMyRYCHiVMNrW7eykRwmUx47rg9P7yjE/8BK9u8yBzY59vHLCSfVf1xRJzuD?=
 =?us-ascii?Q?im8o40JvmVjPPI2oOh2riofMwR7Ms58Z5IqopBFP21KbIKG45LcPoj0V80bi?=
 =?us-ascii?Q?+spebbidLqk5DSglFD/9Hw/ZYaMyadqP6q7d+jAY9u6XST4FhLYRNwOgLWi0?=
 =?us-ascii?Q?P/E5ZI0Ym/feSKbVpItFoXun3xDqIkcNTUoX4Z2LgNp8SrmdtSy62QuynD3/?=
 =?us-ascii?Q?FsMLR9snyuyd0PbLLf57uPC9kLZn21caevGmM1yAMXDR39qfXw6N64M58RR1?=
 =?us-ascii?Q?mJekFzKhw9yGttvyp2wlZBuPxR4POvCT+paW7neeJudwLdBRMxEljQ9J/BVX?=
 =?us-ascii?Q?KRp5nv5ZELbfdo0UcDUmBfnCcS6+tJHWopdAj0wq3GIxxMVW7iMZWA52+W/z?=
 =?us-ascii?Q?03rPFtHQE29NRatqxbNMXf4fiNzmWozrqxSPl0VsuTW1qRMTQXsFeUiU49XS?=
 =?us-ascii?Q?ShJpTfDiZnAKPqm6sa0PH4uinNPxfu8Dhi4zLgQFmLkVIRwz9UCf0o5o4AXg?=
 =?us-ascii?Q?TnE6+JLTU7eoKtEewP9r5ZsKu8tDOvPXpxpl1zyToDp5XQlAWasOve0z+4MQ?=
 =?us-ascii?Q?BznfddrHNvNFnp4L3EZRZBtLf+j5QLh2J9NkQTUgMXNKm90JvWA6GT9Q5OCr?=
 =?us-ascii?Q?cHCDF1PWCPRAcW7+xSrd8dfrvQ50FDkBJzXhrVoFiteGLP9GP8XnjKkW5KW8?=
 =?us-ascii?Q?3nh6avbNzWaoVj1EKPaNBGXgmQ2x9ZtEkuZBZXd3My4Z6Hw84HKCEyuoRC6x?=
 =?us-ascii?Q?1aL3Dvq8VeReGjVSrIl44/p9Ljxwwj/apS+IhmNVUWsFBB+nthAqNIEMyXFL?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: IBhJvSv/Ux3FtoUqBDme5KaI0sSYzpOsmTFj8RtQvPs/zqoFF/BSziY6xMJRInyU2ebqY6xmCex2F+fJj6246yZ5CTaAjZzF17l/Yhh+p3RFh3FQF5AHu+gP/c8NnDCgaIir0AOuh1uXv/TMqAvIUT9yagCRGz/ez47yMrhYh4QABK0f3KwE5FH58oarPAS3kDycPrI6uzuideKMn+KxNX1DH/tFihqUWMflXZh9NoePKVJZpcXfsiZTDFtY4zL2+qCLe5RdlQ4Df1whazTsNL/noYOaln08nDUB6PE2CEXjkmpTqyP7V2GCrGurxMXNnDNV/TysUoaEYZhQS43xHifAhdAzuDWMKE+jyr2Guj/0iJprnHmdfZfbcMqrN2Co3UIcC9/sTBmTcvBZuNsPkA==
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4711;6:GjGCEwCowwGgrlE+rYS+txMWCetSVatvNgYRbc/PT5LaFHFOS9RazfKZzx4cPCdVSHsDmbEI0FTfyqp9D+lA6++zBzz4YCFjqHbupwU7z/oSNhJq/ZMagR+7BLkJhBX0KOejHt4asCViRWgNCIOfxPaG4ZQFUG51ZT1FUDX1cM2jeRaZlUn0qGo/RymvBi+cv3HCn8BBQcHN/ZTH+4yYiuo8MkSAbfS3yeS2siyOR10wo23qJBDftGxXLTOlQYS+jsGolTnC1VK6ZvUP3zlyA6xOQtir766VRkgOMTgasVaRLDVRDZh6yYTB8wg5yLb+lxlH2ovuN3beaucpjqeXwB0CdXAycyIOgJGvTfRQMfRlhgCX37GvZ9i7qBmSGQon7i8Kh1y7joZQQNC1WjzjZzk2nlKd5UrTtuTxGMgivgLq12O+USbUNb9TpvvNTcNeMXJYe4swwEy8Z1NyyPMg8w==;5:odOnwHea8ZGEfW2COTWKt5xcSXwld3jfCvuDfptvpzbBtMl0CVqINVUfIu296CLlLI4QKXuX9wCv7mjh5ef3e6VQmDCLgVqzDfDqkNwOOeEeSD2N7vlj8dOQcqoBXNP0vdjLNfyuB5YU1S+lXjsV3hkUGv6HCJlf4nlmq/KpUx8=;24:ESNIDdaqAnxwA86Aw3Is+LZsLxNysLn/MY3fTF+7+gUdSs+QlJJ0GuP69HIFqDacMLzFGiFabLWbOOEDmj/SBDX2xmqBBlcP4BuPjSs5iY4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4711;7:vW3lTu/LF8hwq8rcq5E/0b1zyvaxojYpTUWDActP0t+LaUAzk92flATLhAFXrgoxCitNg3zI6dgikFvqUj1R3zpywuTQgaVm3lnM9NwgPFY0W2LIDLY6C5+489bzNJpssaMSTrDCO8dTGWLbCl2HkBKft/9W3oKaY5qQ8U6DarGrK0ARWoVsaY4fvRdI2AMq3isrn1H7DUffcHa1yLGOzKBXozNW/nZKmcmEX/iTFvgOadDrkYYHtrLyGWsXU9gw;20:jG9bNetMRJbYJr0QkVSbYGNTahZgSZCgL3mgMYY2ttc6X567VZoFuTHWhoNyXHyE8GNwpSz1OAmVRxDbLoV+W+eQG6D8tt24GRNlAwEmL7tp771hZXgl1J9Tp6eaMla0uu6fmTxMhhVVaalVszMtiuTYMJlsvJY7g069gZVl9O6gPj5tE0mxdDAYqi2Rtnib/aHAEyYA8Fl9f6hJFksoBKPe6FVQlSnC+XpQ2P2OOe2R7HsaZGh+n17dmfM0YZzu
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 10:03:46.5974
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d83cc421-da52-4f89-fc36-08d5e0cc44a6
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4711
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@bootlin.com>

If DP_TEST_COLOR_FORMAT_RAW_Y_ONLY is set, if MISC0 color format is
DP_COLOR_FORMAT_RGB and all other bits are 0, then color format is
actually Y-Only.

If DP_TEST_COLOR_FORMAT_RAW_Y_ONLY is set, if MISC0 color format is
DP_COLOR_FORMAT_YCbCr422, DP_TEST_DYNAMIC_RANGE_CEA is not set and
chosen ITU is 601, then color format is actually RAW.

If DP_TEST_VSC_SDP is set, then DP_TEST_COLOR_FORMAT_RAW_Y_ONLY,
DP_TEST_COLOR_FORMAT, DP_TEST_DYNAMIC_RANGE_CEA,
DP_TEST_YCBCR_COEFFICIENTS and DP_TEST_BIT_DEPTH are ignored and we
should use VSC SDP for setting the colorimetry. This is used for Y420.

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
Signed-off-by: Damian Kos <dkos@cadence.com>
---
 include/drm/drm_dp_helper.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
index accefbb..22f6c3e 100644
--- a/include/drm/drm_dp_helper.h
+++ b/include/drm/drm_dp_helper.h
@@ -609,6 +609,8 @@
 #define DP_TEST_MISC1                       0x233
 # define DP_TEST_REFRESH_DENOMINATOR        (1 << 0)
 # define DP_TEST_INTERLACED                 (1 << 1)
+# define DP_TEST_VSC_SDP		    (1 << 6) /* 1.3+ */
+# define DP_TEST_COLOR_FORMAT_RAW_Y_ONLY    (1 << 7)
 
 #define DP_TEST_REFRESH_RATE_NUMERATOR      0x234
 
-- 
1.7.1

