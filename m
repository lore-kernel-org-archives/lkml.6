Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08B9C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF8D220877
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="gBiEmWcG";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="k3t0raCp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF8D220877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbeIYPY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:24:29 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:50270 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727606AbeIYPY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:24:28 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8P9BhJa019845;
        Tue, 25 Sep 2018 02:16:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=tSXO58g5ii+lE8PmFHi4TgBwFwkaPtbJkTgA6PzdUcE=;
 b=gBiEmWcGTpCnyRFu7iV4NrmXLQHrEbKsS19Eb98ARYg4A3Cn/0P12lYCC+jGo2gLSUgz
 SzC03LTPP0PXkBUafEKo7UWD7EKDRO4eiorgpIDJIw8533TO1ObcDRzCLjuH80ha8mOB
 ZQIumBPrBaaLIS/wwS9nvuYSu5MLu+Kfl/RPotBID4YtJps6mt5ixFOP3G+MDI6lKLIX
 03MTrDxGxwrTpFr+6zVXBevhuBjfUsR+zvQyDh04UetaMl03Te9QgDkzUd2g6QMFHfef
 hEhnYYV0ZZDa+TJZYu5qQ0bK4hUe0w3HLwGRlcPKbFH0zZhKVBT8p9thcVOqdttbGtpo wg== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=dkos@cadence.com
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp0020.outbound.protection.outlook.com [216.32.181.20])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2mnj9vkfmt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 25 Sep 2018 02:15:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSXO58g5ii+lE8PmFHi4TgBwFwkaPtbJkTgA6PzdUcE=;
 b=k3t0raCpcuEkwFTD1m0RZ16vSTblibBovsYB2RQsntSKBZ/pCj1bVWPPwBe9T8zZUIdnR17jKgdqyJcjjRb3u4FW5q8LR4W7v9K96xeITu6BwKpnDpVlyxyLncCsCdERK74bnxyGhYV2Ioy29zNugVSQA/diSTRQX9KmBbpsQYg=
Received: from DM5PR07CA0103.namprd07.prod.outlook.com (2603:10b6:4:ae::32) by
 SN6PR07MB4415.namprd07.prod.outlook.com (2603:10b6:805:59::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.17; Tue, 25 Sep 2018 09:15:55 +0000
Received: from CO1NAM05FT021.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::201) by DM5PR07CA0103.outlook.office365.com
 (2603:10b6:4:ae::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1164.22 via Frontend
 Transport; Tue, 25 Sep 2018 09:15:55 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 CO1NAM05FT021.mail.protection.outlook.com (10.152.96.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.1185.5 via Frontend Transport; Tue, 25 Sep 2018 09:15:47 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w8P9Fi2S028621
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 25 Sep 2018 02:15:45 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 25 Sep 2018 11:15:51 +0200
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 25 Sep 2018 11:15:51 +0200
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id w8P9Fh9f009594;
        Tue, 25 Sep 2018 10:15:43 +0100
Received: (from dkos@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id w8P9Fh1o009593;
        Tue, 25 Sep 2018 10:15:43 +0100
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
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        Damian Kos <dkos@cadence.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>
CC:     <pgaj@cadence.com>, <ltyrala@cadence.com>, <rafalc@cadence.com>,
        <jartur@cadence.com>, <piotrs@cadence.com>,
        <quentin.schulz@bootlin.com>, <jbergsagel@ti.com>
Subject: [PATCH v5 5/5] drm: bridge: add support for Cadence MHDP DPI/DP bridge
Date:   Tue, 25 Sep 2018 10:13:35 +0100
Message-ID: <1537866837-4408-6-git-send-email-dkos@cadence.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1537866837-4408-1-git-send-email-dkos@cadence.com>
References: <1537866837-4408-1-git-send-email-dkos@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(136003)(39860400002)(2980300002)(36092001)(199004)(189003)(53946003)(54906003)(126002)(246002)(316002)(478600001)(47776003)(106466001)(2906002)(26826003)(87636003)(36756003)(575784001)(16586007)(42186006)(76176011)(2201001)(446003)(26005)(105596002)(336012)(426003)(86362001)(305945005)(7416002)(50226002)(110136005)(2616005)(5660300001)(186003)(50466002)(486006)(48376002)(8676002)(11346002)(4326008)(51416003)(476003)(6666003)(8936002)(7636002)(5024004)(14444005)(356003)(921003)(2101003)(1121003)(83996005)(579004)(559001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4415;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT021;1:9sTG7XXTQcFcs/Q1r8yNwmAngaEkstDmYLw4JrESSVWmv7m1bRjOIs5lccAKbPgul6d2Q3lT2z2kWyEVwJD/VR1z15nOD9khhNlJTRKL/eEli+c0iP68WPzdx0DXRk1z
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca410c71-eca6-4225-938a-08d622c77f4c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060);SRVR:SN6PR07MB4415;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4415;3:TzsMqulEGewRa1UC0OLa6EAPEFewfkDG68+/LO+VEW6cPucCvqyr4RWcFCE+ySJkXt8Sja9rSF69I7E9XRKZIkJWAjYTWaNLBOuc6cV37BwTy3CNoSQpv2tgw3GKvGWsLpkK9iqVnLtIiblhGVgId5OQjnXXlI2Lhj0IDUplTShw9qOKllP5GN6l+cdUtFdO2PVCpwZBoDgJeyX6jXe8IRbs5G4PpIdLpjzJDu6lIBXFOzYIbBXd2zquKSDs+inku40k6lIWm1+Y3tdd000s+aicDVvLymkdary/c86WMMIb12y3fCRfYGppK862Ap+tm5tYxEU4tDpYnTXAZO8jtb017t1uYtj+3CBsfWqh0dY=;25:VTZmRdh4qC5BzD6voysTCU0SwVxdRLZ4e4sSmhRNQgmRURuLfmcy6+pI71j5mCOPxgabY+46yftndzgALPPqngvsdQicuDDZqB6/u8l8TGCH999kg3YzO9TP8rECEYjHETGhCL6r5mK58LW25n7e5xvvWJLfkE1lxWs7Chgb6jrw2vVe1mkYNb/bqAYndzpXC+Z8iHIbwXvAK7+nvrkW37UYhKc63o+7GzW5mpxSsSrw6SNURlUHbNvs7MACxakWRn1x90ibKOdYrvedOK0+snYUYTioZaexThkM8cK48+9xbPou4LZveMJamRiwOBfCuALV6pNkW2g78NyHErkINw==
X-MS-TrafficTypeDiagnostic: SN6PR07MB4415:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4415;31:yOVYgFvBhLOGhHblg9ICjyupUo1rVYmShANGWJWi3ERxtBMsOaBOGkNTX+/5O3q+YzafmYSd14IXT/tWketCnwSUGHFk5sPazXU46+M0w4SKtr8ryOmpqfocz53c1yUos0pyRUm8hBZWsI5iZR9YDXQMZAjIsOg3YmwD0azGYwQ/+TNAYv5vAtMD5Yv8bRRXMWkbd7xG5nHxTmwT1LPf2+DQeoBVmGx0aDEvweOjwHI=;20:WtiWLYjTSHRMtAeKfEhIhA4kZRxXuQmIzZYUP0mU+ygD+tVFnAJt+c+iGvNbmtOS2kmJW7SjItbfBmJusYOGADSpOIKqOuh/fP0KejL9lr3dQJ3gSVAOYPHlgYGc3iaL8alWoXrfNS+rqHbASjy412zDyPjLZoM0m5KgzXmT0joQZAJwtln97FhDWLeikBN7XjIY2BuRr/aBL6W2xxRZ9GH1+gXW2LcLrV6fmUiXqBaEculeDapmRZizYLivMx6PPW5/amtYJ9N88gtzGMXhCzwdC3j7HK/TpQPvtcZ/EofA+qraMqkAMtL5wnOxwfW1tSp4/dhwq/A5C3/Wa+BUUB3y9LY+PmrlMR2U3wGnKYEGHoGgLsxhRM7fzjzuleueoX9EFAGFOPIbGuGcTkEocP8ZGHfHjOqG5YhN9cAIZ3ALbTXuIASoB+gufbQTpEtuc9B/DzdCJGsh5SZ4Un0ND3ZdrclkUeAVf5YEFfxoBiVrVPOP054duIZ3T+Zf9cbw
X-Microsoft-Antispam-PRVS: <SN6PR07MB44150503D6AE6BBE6DEC0483CD160@SN6PR07MB4415.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(58145275503218)(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(93006095)(93003095)(10201501046)(3002001)(149066)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:SN6PR07MB4415;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB4415;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4415;4:DySiyxiYI+S2DwsXHYoN/lABTjfw+3HJIJsFO1jWL9Cjoevth6iuOZFOKy/VRNQFPkp0Usc+bGo1cJ/68LTBxRU5PbygPrwGqPhvk9lbMfjldHh+rdnY4ievUYZsvFmumQjU+OzIsINUUqpUDfmjGLZDslGkIz2lu14Nja+NBIN0QJBBINvVn7AuK5VAC2RZpbkjfwoenSKRrSG+wwzYSj+NLVmqHf6fbhj7QR6mQiBIv0LqXVPzUI/3kZbl+eYV/DFuS3hd7VjN27iUpBPwgj6comnLmdOX7aGzWpY57uwOTQNBJ0hgv3PtnfjuOPMz5or+GuWar/TcfWT/sIG5Bel087YN/WiZAfygCK7AS3I=
X-Forefront-PRVS: 08062C429B
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR07MB4415;23:+mqJuJplGEzDUCnk2iK4TSrKyAXw9PEhIllZphYWA?=
 =?us-ascii?Q?x9AsCwvmM785XPuJ26mPjgYlnoR8GxeARwDmn68c1KUe7y5sqSTvhj0oTlaT?=
 =?us-ascii?Q?okfpt2iYaj3C6ktJy392vSrBgKzVW2IXx+iovF6ji6/iGa7KC4yBEbi3BYM2?=
 =?us-ascii?Q?xi/ZtJB8o2FknkmoBMwVhJnEx0v8rHtwDBmPg9F0BboqQSReZ9TEoZ/edLQ5?=
 =?us-ascii?Q?3r1nmNLlzM/6YASEe2gqgQnmvzU0H/yp9oKWdTUM5tW6iKYDHkxKwjBZPPYu?=
 =?us-ascii?Q?g/3CJiH7/7LmisY7sTqmWwFs6vTLNEJHVYApi+C60SVnFIVJH00LKI66GOQg?=
 =?us-ascii?Q?rm/w9bsvg+MU4xEcTO2hm+CihQ6rIdF3FxCh33MyFONBfqzo5PEJlkg/uX9r?=
 =?us-ascii?Q?ZCTCh5hPh8STiIXQhPxWjC4T7e/AfZGTWY4D5mxfrHjhIpwNX0BQlqjaXxfV?=
 =?us-ascii?Q?tku4WbxtAo1sykHgxLPqBL2pHIOtDWMXXAvauyW5R6hMnld5oBs3STZuXapn?=
 =?us-ascii?Q?bPfzWY9tuBpYL38L15xqfIkbD/j5buK/ksynhXWs20sn+c8uYCe7fjz91Sml?=
 =?us-ascii?Q?HhDIjcALThhbd24y6IS5RwfpwbRJ5zQhlRc53zBdfTuHBawcJvSAhHLLohIk?=
 =?us-ascii?Q?hsqnXKsiZ6kJPA99/lVDk8kXQCg/gffjlq1hdBG/5lIC10+0CPXWskpMiMSG?=
 =?us-ascii?Q?PMIMfF/uv9z08icZqxdiSRCfWgDR5AzHu0S7i5RXQL634u+btssM94f162G+?=
 =?us-ascii?Q?Ylnv/ssZHyRN/XEW7XtmeyLw4HB8VLwU8QVXtVQX30iMt02vkB3xVvyok9qd?=
 =?us-ascii?Q?t6qwM8OZNWo6BuV3OBH5m4+1n65OFWEx72eQz5wuF7f7KBj+wiMfQ5GpYfe/?=
 =?us-ascii?Q?ZbExUu6NHEhPnuz66FtsSTPzzcm92YXLnE3rr8yRbZoKSFrJ6xB0l8gF4Chm?=
 =?us-ascii?Q?udKpmJFlfn2musWPxricgA5dSZ9wjEW9LGPX6t/WpwH34f/wOyxfjeA3DNUl?=
 =?us-ascii?Q?giNBXfd71u3ebpBxcypDfhOqN+hVVhDxtWpltKipfQj8fK5gek5peNbXbu+T?=
 =?us-ascii?Q?iKeq279Q/VLInYOXm+ehm4dqw3EJJ4KbkkSGWmyijeypJ/GIdGARSxhzBCVj?=
 =?us-ascii?Q?NoG8Ctoeq6OY/6BS/geVPW5NvhLBDX/omTK4lypenuLwCnhdJg4hF0h+1Mgd?=
 =?us-ascii?Q?15ZFJIRW3H0zDe5Ng1k6yRXUNyXLXshFaMlC5q67y+Y6jXJFydLHeQm5DIW5?=
 =?us-ascii?Q?kGVhnLrPMnbw0fs/ivACB8shEqlJZ3rucE0afDE?=
X-Microsoft-Antispam-Message-Info: LKr84JwMzdHkWma4jXnJpPNCqYis4lMm0EfoMBNq1JtaHpHSLSR8GOOUnE7aKZLEu6Ln9eiy4T2kv1wpWTBxA/2GiNAURYx3Z8CodX/D+vhcXQgf6/JqXRFaD9MeoxqJCF9aQeCR5HJDRfvcfb2M5sJ9x9ScrRIVZahQSrSKBj/XH+JPdsKlnnWvMUKjUW1D3ak1LXvBbEqzKmXNLVpS16CfKNwKlOSbZIXH+qqRxM4gwRFJCDHemnqnv4NXZ0cfJ6MhrTO6qScf/KnndCBYQj+ltrzNWiU9zBddkfAImVgqAOwPIE2eZHlXIT2UbrNoQethdLBt7Nu8HsMPbdWJBtBvSeWPnvlPJJuCfKCm2RO/OfWg4/M73Xv2Qv9JIIljD8JLl9H2vMIwb7FS/FZcJA==
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4415;6:P0e5LQ5a3Z81e9R+uhguIf+s0ms+8H1f5h7V4cUXfdwqZM5o9o9mv4WKG00591b1+7sOCdWQDZluLpkxty8d0Zmmttkyy01ET+Xda1e1ctiUhRKuqGz4XRavGEzDzUoGeerfKhE8AxSm7btBptDwXg4wVlfFCY4p2EeVyHGUm2+470QpN7SjaQudMzzfpgfeOWaPPDbMVoQlII6Ygkfxa1B2tIj4QlOJQt8YYpRV2LxPSwVWJzK4gMG/8P+8CRHIHuWvCs7pDc0XMJ5kXE6x0l5jFWMNY+hdQwydGh3OjcNGFjeKp2N9fN9sF7LckZbUzb4juZbcEQ7ARQZbsYVPwigE9qv7k+cgimvQ2cS/io42Akhe5Z9y5BvU/tWs7PjeB5j42fBiwAQK4URo/R957I+t8HrMLvCNGtZp5sCgbY+k13q6hgqCahLcwGZiZ1NOQrsx9b5e6YPfjhPuarRoYQ==;5:S3on6bRwa2287QmKwilUrvFSp/qsZgYHIfIEeFnsc+U464tFaeeJTuafDe9/Dq5cvVW/8tAKGrnFLQSnaL7DtU5Obu3t4pTdjV6YgzdBZ5J5sdvkdbNzQjtKWeepzHTw4WpA/cAYTjzVdUhF91koS/2r0zKdxmFSsehUtBA+2GY=;7:W78FxPK6DGLO7s6YoJ/vffltW/X72lo573sACfXyX/JgXqw5PmO3uvI9Mg13/3DB/GTCEJBgdoUayu8QkbF3T6l+rtyDzWM+1UxhGBdDoci6+djebc1KyHs2+iqK8rCMfktcbUusHZhmC+Cq25gnQO3neV+qh9wMVTgNLX2k2o8KBBpT3mPmxqqiQu7LpWjhsWd1zZ43pkSe0QbgykvutZqnoxWvRQ99v2Tjfw44ustlyrtYvOP8MjufrapGPNrB
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4415;20:TWBPw0G7Ij8MpdDp2ayI5m6cUEA56N0HzrGWAJGPzP+tSd4lAbsb+3qQ7IVYjnrwR0kjmiqalPEfU3gjM6rBFP6+g/eb68WKG6bxfMF/VQjKywyjpmfaAXwPdoVfYjo4aEPFfmRcAY+LXkvqWSl3/QwZVr00Ks4F8EAIMGaL5XJXsbkH325zR66ZPCv4c8TUmxgQBmrbK82oV0jjKuEriE0T6Kwoh3iC4yTkrAVErULph5fHe4IfeN9eB89VYOyY
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2018 09:15:47.9846
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca410c71-eca6-4225-938a-08d622c77f4c
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4415
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-25_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1809250096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@free-electrons.com>

This adds basic support for Cadence MHDP DPI to DP bridge.

Basically, it takes a DPI stream as input and output it encoded in DP
format. It's missing proper HPD, HDCP and currently supports only
SST mode.

Changes made in the low level driver (cdn-dp-reg.*):
- moved it to from drivers/gpu/drm/rockchip to
  drivers/gpu/drm/bridge/cdns-mhdp-common.c and
  include/drm/bridge/cdns-mhdp-common.h
- functions for sending/receiving commands are now public
- added functions for reading registers and link training
  adjustment

Changes made in RK's driver (cdn-dp-core.*):
- Moved audio_info and audio_pdev fields from cdn_dp_device to
  cdns_mhdp_device structure.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Signed-off-by: Damian Kos <dkos@cadence.com>
---
 drivers/gpu/drm/bridge/Kconfig                |    9 +
 drivers/gpu/drm/bridge/Makefile               |    3 +
 .../cdns-mhdp-common.c}                       |  136 +-
 drivers/gpu/drm/bridge/cdns-mhdp.c            | 1304 +++++++++++++++++
 drivers/gpu/drm/rockchip/Kconfig              |    4 +-
 drivers/gpu/drm/rockchip/Makefile             |    2 +-
 drivers/gpu/drm/rockchip/cdn-dp-core.c        |   16 +-
 drivers/gpu/drm/rockchip/cdn-dp-core.h        |    5 +-
 .../drm/bridge/cdns-mhdp-common.h             |   21 +-
 9 files changed, 1480 insertions(+), 20 deletions(-)
 rename drivers/gpu/drm/{rockchip/cdn-dp-reg.c => bridge/cdns-mhdp-common.c} (87%)
 create mode 100644 drivers/gpu/drm/bridge/cdns-mhdp.c
 rename drivers/gpu/drm/rockchip/cdn-dp-reg.h => include/drm/bridge/cdns-mhdp-common.h (95%)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 9eeb8ef0b174..90a4810a8c96 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -35,6 +35,15 @@ config DRM_CDNS_DSI
 	  Support Cadence DPI to DSI bridge. This is an internal
 	  bridge and is meant to be directly embedded in a SoC.
 
+config DRM_CDNS_MHDP
+	tristate "Cadence DPI/DP bridge"
+	select DRM_KMS_HELPER
+	select DRM_PANEL_BRIDGE
+	depends on OF
+	help
+	  Support Cadence DPI to DP bridge. This is an internal
+	  bridge and is meant to be directly embedded in a SoC.
+
 config DRM_DUMB_VGA_DAC
 	tristate "Dumb VGA DAC Bridge support"
 	depends on OF
diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
index 4934fcf5a6f8..e802fdb85750 100644
--- a/drivers/gpu/drm/bridge/Makefile
+++ b/drivers/gpu/drm/bridge/Makefile
@@ -16,4 +16,7 @@ obj-$(CONFIG_DRM_ANALOGIX_DP) += analogix/
 obj-$(CONFIG_DRM_I2C_ADV7511) += adv7511/
 obj-$(CONFIG_DRM_TI_SN65DSI86) += ti-sn65dsi86.o
 obj-$(CONFIG_DRM_TI_TFP410) += ti-tfp410.o
+obj-$(CONFIG_DRM_CDNS_MHDP) += mhdp8546.o
 obj-y += synopsys/
+
+mhdp8546-objs := cdns-mhdp-common.o cdns-mhdp.o
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-reg.c b/drivers/gpu/drm/bridge/cdns-mhdp-common.c
similarity index 87%
rename from drivers/gpu/drm/rockchip/cdn-dp-reg.c
rename to drivers/gpu/drm/bridge/cdns-mhdp-common.c
index c1a76e6fff88..fda1bee7adb5 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-reg.c
+++ b/drivers/gpu/drm/bridge/cdns-mhdp-common.c
@@ -19,8 +19,9 @@
 #include <linux/iopoll.h>
 #include <linux/reset.h>
 
-#include "cdn-dp-core.h"
-#include "cdn-dp-reg.h"
+#include <drm/drm_print.h>
+#include <drm/drm_modes.h>
+#include <drm/bridge/cdns-mhdp-common.h>
 
 #define CDNS_DP_SPDIF_CLK		200000000
 #define FW_ALIVE_TIMEOUT_US		1000000
@@ -33,6 +34,7 @@ void cdns_mhdp_set_fw_clk(struct cdns_mhdp_device *mhdp, unsigned long clk)
 {
 	writel(clk / 1000000, mhdp->regs + SW_CLK_H);
 }
+EXPORT_SYMBOL(cdns_mhdp_set_fw_clk);
 
 void cdns_mhdp_clock_reset(struct cdns_mhdp_device *mhdp)
 {
@@ -82,6 +84,7 @@ void cdns_mhdp_clock_reset(struct cdns_mhdp_device *mhdp)
 	/* enable Mailbox and PIF interrupt */
 	writel(0, mhdp->regs + APB_INT_MASK);
 }
+EXPORT_SYMBOL(cdns_mhdp_clock_reset);
 
 static int cdns_mhdp_mailbox_read(struct cdns_mhdp_device *mhdp)
 {
@@ -189,7 +192,56 @@ static int cdns_mhdp_mailbox_send(struct cdns_mhdp_device *mhdp, u8 module_id,
 	return 0;
 }
 
-static int cdns_mhdp_reg_write(struct cdns_mhdp_device *mhdp, u16 addr, u32 val)
+int cdns_mhdp_reg_read(struct cdns_mhdp_device *mhdp, u32 addr, u32 *value)
+{
+	u8 msg[4], resp[8];
+	int ret;
+
+	if (addr == 0) {
+		ret = -EINVAL;
+		goto err_reg_read;
+	}
+
+	msg[0] = (u8)(addr >> 24);
+	msg[1] = (u8)(addr >> 16);
+	msg[2] = (u8)(addr >> 8);
+	msg[3] = (u8)addr;
+
+	ret = cdns_mhdp_mailbox_send(mhdp, MB_MODULE_ID_GENERAL,
+				     GENERAL_REGISTER_READ,
+				     sizeof(msg), msg);
+	if (ret)
+		goto err_reg_read;
+
+	ret = cdns_mhdp_mailbox_validate_receive(mhdp, MB_MODULE_ID_GENERAL,
+						 GENERAL_REGISTER_READ,
+						 sizeof(resp));
+	if (ret)
+		goto err_reg_read;
+
+	ret = cdns_mhdp_mailbox_read_receive(mhdp, resp, sizeof(resp));
+	if (ret)
+		goto err_reg_read;
+
+	/* Returned address value should be the same as requested */
+	if (memcmp(msg, resp, sizeof(msg))) {
+		ret = -EINVAL;
+		goto err_reg_read;
+	}
+
+	*value = (resp[4] << 24) | (resp[5] << 16) | (resp[6] << 8) | resp[7];
+
+err_reg_read:
+	if (ret) {
+		DRM_DEV_ERROR(mhdp->dev, "Failed to read register.\n");
+		*value = 0;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(cdns_mhdp_reg_read);
+
+int cdns_mhdp_reg_write(struct cdns_mhdp_device *mhdp, u16 addr, u32 val)
 {
 	u8 msg[6];
 
@@ -202,8 +254,9 @@ static int cdns_mhdp_reg_write(struct cdns_mhdp_device *mhdp, u16 addr, u32 val)
 	return cdns_mhdp_mailbox_send(mhdp, MB_MODULE_ID_DP_TX,
 				      DPTX_WRITE_REGISTER, sizeof(msg), msg);
 }
+EXPORT_SYMBOL(cdns_mhdp_reg_write);
 
-static int cdns_mhdp_reg_write_bit(struct cdns_mhdp_device *mhdp, u16 addr,
+int cdns_mhdp_reg_write_bit(struct cdns_mhdp_device *mhdp, u16 addr,
 				   u8 start_bit, u8 bits_no, u32 val)
 {
 	u8 field[8];
@@ -220,6 +273,7 @@ static int cdns_mhdp_reg_write_bit(struct cdns_mhdp_device *mhdp, u16 addr,
 	return cdns_mhdp_mailbox_send(mhdp, MB_MODULE_ID_DP_TX,
 				      DPTX_WRITE_FIELD, sizeof(field), field);
 }
+EXPORT_SYMBOL(cdns_mhdp_reg_write_bit);
 
 int cdns_mhdp_dpcd_read(struct cdns_mhdp_device *mhdp,
 			u32 addr, u8 *data, u16 len)
@@ -252,6 +306,7 @@ int cdns_mhdp_dpcd_read(struct cdns_mhdp_device *mhdp,
 err_dpcd_read:
 	return ret;
 }
+EXPORT_SYMBOL(cdns_mhdp_dpcd_read);
 
 int cdns_mhdp_dpcd_write(struct cdns_mhdp_device *mhdp, u32 addr, u8 value)
 {
@@ -286,6 +341,7 @@ int cdns_mhdp_dpcd_write(struct cdns_mhdp_device *mhdp, u32 addr, u8 value)
 		DRM_DEV_ERROR(mhdp->dev, "dpcd write failed: %d\n", ret);
 	return ret;
 }
+EXPORT_SYMBOL(cdns_mhdp_dpcd_write);
 
 int cdns_mhdp_load_firmware(struct cdns_mhdp_device *mhdp, const u32 *i_mem,
 			    u32 i_size, const u32 *d_mem, u32 d_size)
@@ -328,6 +384,7 @@ int cdns_mhdp_load_firmware(struct cdns_mhdp_device *mhdp, const u32 *i_mem,
 
 	return 0;
 }
+EXPORT_SYMBOL(cdns_mhdp_load_firmware);
 
 int cdns_mhdp_set_firmware_active(struct cdns_mhdp_device *mhdp, bool enable)
 {
@@ -362,6 +419,7 @@ int cdns_mhdp_set_firmware_active(struct cdns_mhdp_device *mhdp, bool enable)
 		DRM_DEV_ERROR(mhdp->dev, "set firmware active failed\n");
 	return ret;
 }
+EXPORT_SYMBOL(cdns_mhdp_set_firmware_active);
 
 int cdns_mhdp_set_host_cap(struct cdns_mhdp_device *mhdp, u8 lanes, bool flip)
 {
@@ -391,6 +449,7 @@ int cdns_mhdp_set_host_cap(struct cdns_mhdp_device *mhdp, u8 lanes, bool flip)
 		DRM_DEV_ERROR(mhdp->dev, "set host cap failed: %d\n", ret);
 	return ret;
 }
+EXPORT_SYMBOL(cdns_mhdp_set_host_cap);
 
 int cdns_mhdp_event_config(struct cdns_mhdp_device *mhdp)
 {
@@ -408,11 +467,13 @@ int cdns_mhdp_event_config(struct cdns_mhdp_device *mhdp)
 
 	return ret;
 }
+EXPORT_SYMBOL(cdns_mhdp_event_config);
 
 u32 cdns_mhdp_get_event(struct cdns_mhdp_device *mhdp)
 {
 	return readl(mhdp->regs + SW_EVENTS0);
 }
+EXPORT_SYMBOL(cdns_mhdp_get_event);
 
 int cdns_mhdp_get_hpd_status(struct cdns_mhdp_device *mhdp)
 {
@@ -440,6 +501,7 @@ int cdns_mhdp_get_hpd_status(struct cdns_mhdp_device *mhdp)
 	DRM_DEV_ERROR(mhdp->dev, "get hpd status failed: %d\n", ret);
 	return ret;
 }
+EXPORT_SYMBOL(cdns_mhdp_get_hpd_status);
 
 int cdns_mhdp_get_edid_block(void *data, u8 *edid,
 			  unsigned int block, size_t length)
@@ -482,6 +544,7 @@ int cdns_mhdp_get_edid_block(void *data, u8 *edid,
 
 	return ret;
 }
+EXPORT_SYMBOL(cdns_mhdp_get_edid_block);
 
 static int cdns_mhdp_training_start(struct cdns_mhdp_device *mhdp)
 {
@@ -580,6 +643,7 @@ int cdns_mhdp_train_link(struct cdns_mhdp_device *mhdp)
 			  mhdp->link.num_lanes);
 	return ret;
 }
+EXPORT_SYMBOL(cdns_mhdp_train_link);
 
 int cdns_mhdp_set_video_status(struct cdns_mhdp_device *mhdp, int active)
 {
@@ -595,6 +659,7 @@ int cdns_mhdp_set_video_status(struct cdns_mhdp_device *mhdp, int active)
 
 	return ret;
 }
+EXPORT_SYMBOL(cdns_mhdp_set_video_status);
 
 static int cdns_mhdp_get_msa_misc(struct video_info *video,
 				  struct drm_display_mode *mode)
@@ -797,6 +862,7 @@ int cdns_mhdp_config_video(struct cdns_mhdp_device *mhdp)
 		DRM_DEV_ERROR(mhdp->dev, "config video failed: %d\n", ret);
 	return ret;
 }
+EXPORT_SYMBOL(cdns_mhdp_config_video);
 
 int cdns_mhdp_audio_stop(struct cdns_mhdp_device *mhdp,
 			 struct audio_info *audio)
@@ -831,6 +897,7 @@ int cdns_mhdp_audio_stop(struct cdns_mhdp_device *mhdp,
 
 	return 0;
 }
+EXPORT_SYMBOL(cdns_mhdp_audio_stop);
 
 int cdns_mhdp_audio_mute(struct cdns_mhdp_device *mhdp, bool enable)
 {
@@ -842,6 +909,7 @@ int cdns_mhdp_audio_mute(struct cdns_mhdp_device *mhdp, bool enable)
 
 	return ret;
 }
+EXPORT_SYMBOL(cdns_mhdp_audio_mute);
 
 static void cdns_mhdp_audio_config_i2s(struct cdns_mhdp_device *mhdp,
 				       struct audio_info *audio)
@@ -977,3 +1045,63 @@ int cdns_mhdp_audio_config(struct cdns_mhdp_device *mhdp,
 		DRM_DEV_ERROR(mhdp->dev, "audio config failed: %d\n", ret);
 	return ret;
 }
+EXPORT_SYMBOL(cdns_mhdp_audio_config);
+
+int cdns_mhdp_adjust_lt(struct cdns_mhdp_device *mhdp,
+			u8 nlanes, u16 udelay, u8 *lanes_data, u8 *dpcd)
+{
+	u8 payload[7];
+	u8 hdr[5]; /* For DPCD read response header */
+	u32 addr;
+	u8 const nregs = 6; /* Registers 0x202-0x207 */
+	int ret;
+
+	if (nlanes != 4 && nlanes != 2 && nlanes != 1) {
+		DRM_DEV_ERROR(mhdp->dev, "invalid number of lanes: %d\n",
+			      nlanes);
+		ret = -EINVAL;
+		goto err_adjust_lt;
+	}
+
+	payload[0] = nlanes;
+	payload[1] = (u8)(udelay >> 8);
+	payload[2] = (u8)udelay;
+
+	payload[3] = lanes_data[0];
+	if (nlanes > 1)
+		payload[4] = lanes_data[1];
+	if (nlanes > 2) {
+		payload[5] = lanes_data[2];
+		payload[6] = lanes_data[3];
+	}
+
+	ret = cdns_mhdp_mailbox_send(mhdp, MB_MODULE_ID_DP_TX,
+				     DPTX_ADJUST_LT,
+				     sizeof(payload), payload);
+	if (ret)
+		goto err_adjust_lt;
+
+	/* Yes, read the DPCD read command response */
+	ret = cdns_mhdp_mailbox_validate_receive(mhdp, MB_MODULE_ID_DP_TX,
+						 DPTX_READ_DPCD,
+						 sizeof(hdr) + nregs);
+	if (ret)
+		goto err_adjust_lt;
+
+	ret = cdns_mhdp_mailbox_read_receive(mhdp, hdr, sizeof(hdr));
+	if (ret)
+		goto err_adjust_lt;
+
+	addr = (hdr[2] << 24) | (hdr[3] << 8) | hdr[4];
+	if (addr != DP_LANE0_1_STATUS)
+		goto err_adjust_lt;
+
+	ret = cdns_mhdp_mailbox_read_receive(mhdp, dpcd, nregs);
+
+err_adjust_lt:
+	if (ret)
+		DRM_DEV_ERROR(mhdp->dev, "Failed to adjust Link Training.\n");
+
+	return ret;
+}
+EXPORT_SYMBOL(cdns_mhdp_adjust_lt);
diff --git a/drivers/gpu/drm/bridge/cdns-mhdp.c b/drivers/gpu/drm/bridge/cdns-mhdp.c
new file mode 100644
index 000000000000..a3bbc0e809a5
--- /dev/null
+++ b/drivers/gpu/drm/bridge/cdns-mhdp.c
@@ -0,0 +1,1304 @@
+// SPDX-License-Identifier: GPL v2
+/*
+ * Cadence MHDP DP bridge driver.
+ *
+ * Copyright: 2018 Cadence Design Systems, Inc.
+ *
+ * Author: Quentin Schulz <quentin.schulz@free-electrons.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/firmware.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_bridge.h>
+#include <drm/drm_connector.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_dp_helper.h>
+#include <drm/drm_modeset_helper_vtables.h>
+#include <drm/bridge/cdns-mhdp-common.h>
+
+#include <sound/hdmi-codec.h>
+
+
+#define DEBUG_MSG
+
+#define FW_NAME					"cadence/mhdp8546.bin"
+
+#define CDNS_APB_CFG				0x00000
+#define CDNS_APB_CTRL				(CDNS_APB_CFG + 0x00)
+#define CDNS_MAILBOX_FULL			(CDNS_APB_CFG + 0x08)
+#define CDNS_MAILBOX_EMPTY			(CDNS_APB_CFG + 0x0c)
+#define CDNS_MAILBOX_TX_DATA			(CDNS_APB_CFG + 0x10)
+#define CDNS_MAILBOX_RX_DATA			(CDNS_APB_CFG + 0x14)
+#define CDNS_KEEP_ALIVE				(CDNS_APB_CFG + 0x18)
+#define CDNS_KEEP_ALIVE_MASK			GENMASK(7, 0)
+
+#define CDNS_SW_CLK_L				(CDNS_APB_CFG + 0x3c)
+#define CDNS_SW_CLK_H				(CDNS_APB_CFG + 0x40)
+#define CDNS_SW_EVENT0				(CDNS_APB_CFG + 0x44)
+#define CDNS_DPTX_HPD				BIT(0)
+
+#define CDNS_SW_EVENT1				(CDNS_APB_CFG + 0x48)
+#define CDNS_SW_EVENT2				(CDNS_APB_CFG + 0x4c)
+#define CDNS_SW_EVENT3				(CDNS_APB_CFG + 0x50)
+
+#define CDNS_DPTX_CAR				(CDNS_APB_CFG + 0x904)
+#define CDNS_VIF_CLK_EN				BIT(0)
+#define CDNS_VIF_CLK_RSTN			BIT(1)
+
+#define CDNS_SOURCE_VIDEO_INTERFACE		0x00b00
+#define CDNS_BND_HSYNC2VSYNC			(CDNS_SOURCE_VIDEO_INTERFACE + \
+						 0x00)
+#define CDNS_IP_DTCT_WIN			GENMASK(11, 0)
+#define CDNS_IP_DET_INTERLACE_FORMAT		BIT(12)
+#define CDNS_IP_BYPASS_V_INTERFACE		BIT(13)
+
+#define CDNS_HSYNC2VSYNC_POL_CTRL		(CDNS_SOURCE_VIDEO_INTERFACE + \
+						 0x10)
+#define CDNS_H2V_HSYNC_POL_ACTIVE_LOW		BIT(1)
+#define CDNS_H2V_VSYNC_POL_ACTIVE_LOW		BIT(2)
+
+#define CDNS_DPTX_PHY_CONFIG			0x02000
+#define CDNS_PHY_TRAINING_EN			BIT(0)
+#define CDNS_PHY_TRAINING_TYPE(x)		(((x) & GENMASK(3, 0)) << 1)
+#define CDNS_PHY_SCRAMBLER_BYPASS		BIT(5)
+#define CDNS_PHY_ENCODER_BYPASS			BIT(6)
+#define CDNS_PHY_SKEW_BYPASS			BIT(7)
+#define CDNS_PHY_TRAINING_AUTO			BIT(8)
+#define CDNS_PHY_LANE0_SKEW(x)			(((x) & GENMASK(2, 0)) << 9)
+#define CDNS_PHY_LANE1_SKEW(x)			(((x) & GENMASK(2, 0)) << 12)
+#define CDNS_PHY_LANE2_SKEW(x)			(((x) & GENMASK(2, 0)) << 15)
+#define CDNS_PHY_LANE3_SKEW(x)			(((x) & GENMASK(2, 0)) << 18)
+#define CDNS_PHY_COMMON_CONFIG			(CDNS_PHY_LANE1_SKEW(1) | \
+						CDNS_PHY_LANE2_SKEW(2) |  \
+						CDNS_PHY_LANE3_SKEW(3))
+#define CDNS_PHY_10BIT_EN			BIT(21)
+
+#define CDNS_DPTX_FRAMER			0x02200
+#define CDNS_DP_FRAMER_GLOBAL_CONFIG		(CDNS_DPTX_FRAMER + 0x00)
+#define CDNS_DP_NUM_LANES(x)			(x - 1)
+#define CDNS_DP_FRAMER_EN			BIT(3)
+#define CDNS_DP_RATE_GOVERNOR_EN		BIT(4)
+#define CDNS_DP_NO_VIDEO_MODE			BIT(5)
+#define CDNS_DP_DISABLE_PHY_RST			BIT(6)
+#define CDNS_DP_WR_FAILING_EDGE_VSYNC		BIT(7)
+
+#define CDNS_DP_SW_RESET			(CDNS_DPTX_FRAMER + 0x04)
+#define CDNS_DP_FRAMER_TU			(CDNS_DPTX_FRAMER + 0x08)
+#define CDNS_DP_FRAMER_TU_SIZE(x)		(((x) & GENMASK(6, 0)) << 8)
+#define CDNS_DP_FRAMER_TU_VS(x)			((x) & GENMASK(5, 0))
+#define CDNS_DP_FRAMER_TU_CNT_RST_EN		BIT(15)
+
+#define CDNS_DPTX_STREAM			0x03000
+#define CDNS_DP_MSA_HORIZONTAL_0		(CDNS_DPTX_STREAM + 0x00)
+#define CDNS_DP_MSAH0_H_TOTAL(x)		(x)
+#define CDNS_DP_MSAH0_HSYNC_START(x)		((x) << 16)
+
+#define CDNS_DP_MSA_HORIZONTAL_1		(CDNS_DPTX_STREAM + 0x04)
+#define CDNS_DP_MSAH1_HSYNC_WIDTH(x)		(x)
+#define CDNS_DP_MSAH1_HSYNC_POL_LOW		BIT(15)
+#define CDNS_DP_MSAH1_HDISP_WIDTH(x)		((x) << 16)
+
+#define CDNS_DP_MSA_VERTICAL_0			(CDNS_DPTX_STREAM + 0x08)
+#define CDNS_DP_MSAV0_V_TOTAL(x)		(x)
+#define CDNS_DP_MSAV0_VSYNC_START(x)		((x) << 16)
+
+#define CDNS_DP_MSA_VERTICAL_1			(CDNS_DPTX_STREAM + 0x0c)
+#define CDNS_DP_MSAV1_VSYNC_WIDTH(x)		(x)
+#define CDNS_DP_MSAV1_VSYNC_POL_LOW		BIT(15)
+#define CDNS_DP_MSAV1_VDISP_WIDTH(x)		((x) << 16)
+
+#define CDNS_DP_MSA_MISC			(CDNS_DPTX_STREAM + 0x10)
+#define CDNS_DP_STREAM_CONFIG			(CDNS_DPTX_STREAM + 0x14)
+#define CDNS_DP_RATE_GOVERNOR_STATUS		(CDNS_DPTX_STREAM + 0x2c)
+#define CDNS_DP_RG_TU_VS_DIFF(x)		((x) << 8)
+
+#define CDNS_DP_HORIZONTAL			(CDNS_DPTX_STREAM + 0x30)
+#define CDNS_DP_H_HSYNC_WIDTH(x)		(x)
+#define CDNS_DP_H_H_TOTAL(x)			((x) << 16)
+
+#define CDNS_DP_VERTICAL_0			(CDNS_DPTX_STREAM + 0x34)
+#define CDNS_DP_V0_VHEIGHT(x)			(x)
+#define CDNS_DP_V0_VSTART(x)			((x) << 16)
+
+#define CDNS_DP_VERTICAL_1			(CDNS_DPTX_STREAM + 0x38)
+#define CDNS_DP_V1_VTOTAL(x)			(x)
+#define CDNS_DP_V1_VTOTAL_EVEN			BIT(16)
+
+#define CDNS_DP_FRAMER_PXL_REPR			(CDNS_DPTX_STREAM + 0x4c)
+#define CDNS_DP_FRAMER_6_BPC			BIT(0)
+#define CDNS_DP_FRAMER_8_BPC			BIT(1)
+#define CDNS_DP_FRAMER_10_BPC			BIT(2)
+#define CDNS_DP_FRAMER_12_BPC			BIT(3)
+#define CDNS_DP_FRAMER_16_BPC			BIT(4)
+#define CDNS_DP_FRAMER_PXL_FORMAT		0x8
+#define CDNS_DP_FRAMER_RGB			BIT(0)
+#define CDNS_DP_FRAMER_YCBCR444			BIT(1)
+#define CDNS_DP_FRAMER_YCBCR422			BIT(2)
+#define CDNS_DP_FRAMER_YCBCR420			BIT(3)
+#define CDNS_DP_FRAMER_Y_ONLY			BIT(4)
+
+#define CDNS_DP_FRAMER_SP			(CDNS_DPTX_STREAM + 0x10)
+#define CDNS_DP_FRAMER_VSYNC_POL_LOW		BIT(0)
+#define CDNS_DP_FRAMER_HSYNC_POL_LOW		BIT(1)
+#define CDNS_DP_FRAMER_INTERLACE		BIT(2)
+
+#define CDNS_DP_LINE_THRESH			(CDNS_DPTX_STREAM + 0x64)
+#define CDNS_DP_VB_ID				(CDNS_DPTX_STREAM + 0x68)
+#define CDNS_DP_VB_ID_INTERLACED		BIT(2)
+
+#define CDNS_DP_FRONT_BACK_PORCH		(CDNS_DPTX_STREAM + 0x78)
+#define CDNS_DP_BACK_PORCH(x)			(x)
+#define CDNS_DP_FRONT_PORCH(x)			((x) << 16)
+
+#define CDNS_DP_BYTE_COUNT			(CDNS_DPTX_STREAM + 0x7c)
+
+#define CDNS_DPTX_GLOBAL			0x02300
+#define CDNS_DP_LANE_EN				(CDNS_DPTX_GLOBAL + 0x00)
+#define CDNS_DP_LANE_EN_LANES(x)		GENMASK(x - 1, 0)
+#define CDNS_DP_ENHNCD				(CDNS_DPTX_GLOBAL + 0x04)
+
+#define CDNS_MHDP_IMEM				0x10000
+#define CDNS_MHDP_DMEM				0x20000
+
+#define CDNS_DP_TRAINING_PATTERN_4		0x7
+
+/* 3min delay because of EDID mb being VERY slow */
+/* FIXME: should be >615000 when upstreaming */
+#define CDNS_TIMEOUT_MAILBOX			(1000 * 1000 * 60 * 3)
+
+/* FIXME: Should be 2000 */
+#define CDNS_KEEP_ALIVE_TIMEOUT			40000
+#define CDNS_SW_EVENT0_TIMEOUT			40000
+
+static const struct of_device_id mhdp_ids[] = {
+	{ .compatible = "cdns,mhdp8546", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mhdp_ids);
+
+#define CDNS_LANE_1				BIT(0)
+#define CDNS_LANE_2				BIT(1)
+#define CDNS_LANE_4				BIT(2)
+#define CDNS_SSC				BIT(3)
+#define CDNS_SCRAMBLER				BIT(4)
+
+#define CDNS_VOLT_SWING(x)			((x) & GENMASK(1, 0))
+#define CDNS_FORCE_VOLT_SWING			BIT(2)
+
+#define CDNS_PRE_EMPHASIS(x)			((x) & GENMASK(1, 0))
+#define CDNS_FORCE_PRE_EMPHASIS			BIT(2)
+
+#define CDNS_SUPPORT_TPS(x)			BIT((x) - 1)
+
+#define CDNS_FAST_LINK_TRAINING			BIT(0)
+
+#define CDNS_LANE_MAPPING_TYPE_C_LANE_0(x)	((x) & GENMASK(1, 0))
+#define CDNS_LANE_MAPPING_TYPE_C_LANE_1(x)	((x) & GENMASK(3, 2))
+#define CDNS_LANE_MAPPING_TYPE_C_LANE_2(x)	((x) & GENMASK(5, 4))
+#define CDNS_LANE_MAPPING_TYPE_C_LANE_3(x)	((x) & GENMASK(7, 6))
+#define CDNS_LANE_MAPPING_NORMAL		0xe4
+#define CDNS_LANE_MAPPING_FLIPPED		0x1b
+
+#define CDNS_DP_MAX_NUM_LANES			4
+#define CDNS_DP_TEST_VSC_SDP			(1 << 6) /* 1.3+ */
+#define CDNS_DP_TEST_COLOR_FORMAT_RAW_Y_ONLY	(1 << 7)
+
+static inline struct cdns_mhdp_device *connector_to_mhdp(
+	struct drm_connector *conn)
+{
+	return container_of(conn, struct cdns_mhdp_device, connector);
+}
+
+static inline struct cdns_mhdp_device *bridge_to_mhdp(
+	struct drm_bridge *bridge)
+{
+	return container_of(bridge, struct cdns_mhdp_device, bridge);
+}
+
+static unsigned int max_link_rate(struct cdns_mhdp_host host,
+				  struct cdns_mhdp_sink sink)
+{
+	return min(host.link_rate, sink.link_rate);
+}
+
+static u8 eq_training_pattern_supported(struct cdns_mhdp_host host,
+					struct cdns_mhdp_sink sink)
+{
+	return fls(host.pattern_supp & sink.pattern_supp);
+}
+
+static ssize_t mhdp_transfer(struct drm_dp_aux *aux,
+			     struct drm_dp_aux_msg *msg)
+{
+	struct cdns_mhdp_device *mhdp = dev_get_drvdata(aux->dev);
+	int ret;
+
+	if (msg->request != DP_AUX_NATIVE_WRITE &&
+	    msg->request != DP_AUX_NATIVE_READ)
+		return -ENOTSUPP;
+
+	if (msg->request == DP_AUX_NATIVE_WRITE) {
+		int i;
+
+		for (i = 0; i < msg->size; ++i) {
+			ret = cdns_mhdp_dpcd_write(mhdp,
+						   msg->address + i,
+						   *((u8 *)msg->buffer + i));
+			if (!ret)
+				continue;
+
+			DRM_DEV_ERROR(mhdp->dev, "Failed to write DPCD\n");
+
+			return i;
+		}
+	} else {
+		ret = cdns_mhdp_dpcd_read(mhdp, msg->address,
+					  msg->buffer, msg->size);
+		if (ret) {
+			DRM_DEV_ERROR(mhdp->dev, "Failed to read DPCD\n");
+			return 0;
+		}
+	}
+
+	return msg->size;
+}
+
+static int cdns_mhdp_get_modes(struct drm_connector *connector)
+{
+	struct cdns_mhdp_device *mhdp = connector_to_mhdp(connector);
+	struct edid *edid;
+	int num_modes;
+
+	edid = drm_do_get_edid(connector, cdns_mhdp_get_edid_block, mhdp);
+
+	drm_connector_update_edid_property(connector, edid);
+
+	num_modes = drm_add_edid_modes(connector, edid);
+
+	return num_modes;
+}
+
+static const struct drm_connector_helper_funcs cdns_mhdp_conn_helper_funcs = {
+	.get_modes = cdns_mhdp_get_modes,
+};
+
+static enum drm_connector_status cdns_mhdp_detect(struct drm_connector *conn,
+						  bool force)
+{
+	struct cdns_mhdp_device *mhdp = connector_to_mhdp(conn);
+	enum drm_connector_status status = connector_status_disconnected;
+	int ret;
+
+	ret = cdns_mhdp_get_hpd_status(mhdp);
+	if (ret > 0)
+		status = connector_status_connected;
+	else if (ret < 0)
+		dev_err(mhdp->dev, "Failed to obtain HPD state\n");
+
+	return status;
+}
+
+static const struct drm_connector_funcs cdns_mhdp_conn_funcs = {
+	.fill_modes = drm_helper_probe_single_connector_modes,
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+	.reset = drm_atomic_helper_connector_reset,
+	.destroy = drm_connector_cleanup,
+	.dpms = drm_helper_connector_dpms,
+	.detect = cdns_mhdp_detect,
+};
+
+static int cdns_mhdp_attach(struct drm_bridge *bridge)
+{
+	struct cdns_mhdp_device *mhdp = bridge_to_mhdp(bridge);
+	struct drm_connector *conn = &mhdp->connector;
+	int ret;
+
+	conn->polled = DRM_CONNECTOR_POLL_CONNECT |
+		DRM_CONNECTOR_POLL_DISCONNECT;
+
+	ret = drm_connector_init(bridge->dev, conn, &cdns_mhdp_conn_funcs,
+				 DRM_MODE_CONNECTOR_DisplayPort);
+	if (ret) {
+		dev_err(mhdp->dev, "failed to init connector\n");
+		return ret;
+	}
+
+	drm_connector_helper_add(conn, &cdns_mhdp_conn_helper_funcs);
+
+	ret = drm_connector_attach_encoder(conn, bridge->encoder);
+	if (ret) {
+		dev_err(mhdp->dev, "failed to attach connector to encoder\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+enum pixel_format {
+	PIXEL_FORMAT_RGB = 1,
+	PIXEL_FORMAT_YCBCR_444 = 2,
+	PIXEL_FORMAT_YCBCR_422 = 4,
+	PIXEL_FORMAT_YCBCR_420 = 8,
+	PIXEL_FORMAT_Y_ONLY = 16,
+};
+
+static void mhdp_link_training_init(struct cdns_mhdp_device *mhdp)
+{
+	u32 reg32;
+
+	drm_dp_dpcd_writeb(&mhdp->aux, DP_TRAINING_PATTERN_SET,
+			   DP_TRAINING_PATTERN_DISABLE);
+
+	/* Reset PHY configuration */
+	reg32 = CDNS_PHY_COMMON_CONFIG | CDNS_PHY_TRAINING_TYPE(1);
+	if (!(mhdp->host.lanes_cnt & CDNS_SCRAMBLER))
+		reg32 |= CDNS_PHY_SCRAMBLER_BYPASS;
+
+	cdns_mhdp_reg_write(mhdp, CDNS_DPTX_PHY_CONFIG, reg32);
+
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_ENHNCD,
+			    mhdp->sink.enhanced & mhdp->host.enhanced);
+
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_LANE_EN,
+			    CDNS_DP_LANE_EN_LANES(mhdp->link.num_lanes));
+
+	drm_dp_link_configure(&mhdp->aux, &mhdp->link);
+
+	cdns_mhdp_reg_write(mhdp, CDNS_DPTX_PHY_CONFIG,
+			    CDNS_PHY_COMMON_CONFIG |
+			    CDNS_PHY_TRAINING_EN |
+			    CDNS_PHY_TRAINING_TYPE(1) |
+			    CDNS_PHY_SCRAMBLER_BYPASS);
+
+	drm_dp_dpcd_writeb(&mhdp->aux, DP_TRAINING_PATTERN_SET,
+			   DP_TRAINING_PATTERN_1 | DP_LINK_SCRAMBLING_DISABLE);
+}
+
+static void mhdp_get_adjust_train(struct cdns_mhdp_device *mhdp,
+				  u8 link_status[DP_LINK_STATUS_SIZE],
+				  u8 lanes_data[CDNS_DP_MAX_NUM_LANES])
+{
+	unsigned int i;
+	u8 adjust, max_pre_emphasis, max_volt_swing;
+
+	max_pre_emphasis = CDNS_PRE_EMPHASIS(mhdp->host.pre_emphasis)
+		<< DP_TRAIN_PRE_EMPHASIS_SHIFT;
+	max_volt_swing = CDNS_VOLT_SWING(mhdp->host.volt_swing);
+
+	for (i = 0; i < mhdp->link.num_lanes; i++) {
+		adjust = drm_dp_get_adjust_request_voltage(link_status, i);
+		lanes_data[i] = min_t(u8, adjust, max_volt_swing);
+		if (lanes_data[i] != adjust)
+			lanes_data[i] |= DP_TRAIN_MAX_SWING_REACHED;
+
+		adjust = drm_dp_get_adjust_request_pre_emphasis(link_status, i);
+		lanes_data[i] |= min_t(u8, adjust, max_pre_emphasis);
+		if ((lanes_data[i] >> DP_TRAIN_PRE_EMPHASIS_SHIFT) != adjust)
+			lanes_data[i] |= DP_TRAIN_MAX_PRE_EMPHASIS_REACHED;
+	}
+}
+
+static void mhdp_set_adjust_request_voltage(
+	u8 link_status[DP_LINK_STATUS_SIZE], int lane, u8 volt)
+{
+	int i = DP_ADJUST_REQUEST_LANE0_1 + (lane >> 1);
+	int s = ((lane & 1) ?
+		 DP_ADJUST_VOLTAGE_SWING_LANE1_SHIFT :
+		 DP_ADJUST_VOLTAGE_SWING_LANE0_SHIFT);
+	int idx = i - DP_LANE0_1_STATUS;
+
+	link_status[idx] &= ~(DP_ADJUST_VOLTAGE_SWING_LANE0_MASK << s);
+	link_status[idx] |= volt << s;
+}
+
+static void mhdp_set_adjust_request_pre_emphasis(
+	u8 link_status[DP_LINK_STATUS_SIZE], int lane, u8 pre_emphasis)
+{
+	int i = DP_ADJUST_REQUEST_LANE0_1 + (lane >> 1);
+	int s = ((lane & 1) ?
+		 DP_ADJUST_PRE_EMPHASIS_LANE1_SHIFT :
+		 DP_ADJUST_PRE_EMPHASIS_LANE0_SHIFT);
+	int idx = i - DP_LANE0_1_STATUS;
+
+	link_status[idx] &= ~(DP_ADJUST_PRE_EMPHASIS_LANE0_MASK << s);
+	link_status[idx] |= pre_emphasis << s;
+}
+
+static void mhdp_adjust_requested_eq(struct cdns_mhdp_device *mhdp,
+				     u8 link_status[DP_LINK_STATUS_SIZE])
+{
+	unsigned int i;
+	u8 pre, volt, max_pre = CDNS_VOLT_SWING(mhdp->host.volt_swing),
+	   max_volt = CDNS_PRE_EMPHASIS(mhdp->host.pre_emphasis);
+
+	for (i = 0; i < mhdp->link.num_lanes; i++) {
+		volt = drm_dp_get_adjust_request_voltage(link_status, i);
+		pre = drm_dp_get_adjust_request_pre_emphasis(link_status, i);
+		if (volt + pre > 3)
+			mhdp_set_adjust_request_voltage(link_status, i,
+							3 - pre);
+		if (mhdp->host.volt_swing & CDNS_FORCE_VOLT_SWING)
+			mhdp_set_adjust_request_voltage(link_status, i,
+							max_volt);
+		if (mhdp->host.pre_emphasis & CDNS_FORCE_PRE_EMPHASIS)
+			mhdp_set_adjust_request_pre_emphasis(link_status, i,
+							     max_pre);
+	}
+}
+
+static bool mhdp_link_training_channel_eq(struct cdns_mhdp_device *mhdp,
+					  u8 eq_tps,
+					  unsigned int training_interval)
+{
+	u8 lanes_data[CDNS_DP_MAX_NUM_LANES], fail_counter_short = 0;
+	u8 dpcd[DP_LINK_STATUS_SIZE];
+	u32 reg32;
+
+	dev_dbg(mhdp->dev, "Link training - Starting EQ phase\n");
+
+	/* Enable link training TPS[eq_tps] in PHY */
+	reg32 = CDNS_PHY_COMMON_CONFIG | CDNS_PHY_TRAINING_EN |
+		CDNS_PHY_TRAINING_TYPE(eq_tps);
+	if (eq_tps != 4)
+		reg32 |= CDNS_PHY_SCRAMBLER_BYPASS;
+	cdns_mhdp_reg_write(mhdp, CDNS_DPTX_PHY_CONFIG, reg32);
+
+	drm_dp_dpcd_writeb(&mhdp->aux, DP_TRAINING_PATTERN_SET,
+			   (eq_tps != 4) ? eq_tps | DP_LINK_SCRAMBLING_DISABLE :
+			   CDNS_DP_TRAINING_PATTERN_4);
+
+	drm_dp_dpcd_read_link_status(&mhdp->aux, dpcd);
+
+	do {
+		mhdp_get_adjust_train(mhdp, dpcd, lanes_data);
+
+		cdns_mhdp_adjust_lt(mhdp, mhdp->link.num_lanes,
+				    training_interval, lanes_data, dpcd);
+
+		if (!drm_dp_clock_recovery_ok(dpcd, mhdp->link.num_lanes))
+			goto err;
+
+		if (drm_dp_channel_eq_ok(dpcd, mhdp->link.num_lanes)) {
+			dev_dbg(mhdp->dev,
+				"Link training: EQ phase succeeded\n");
+			return true;
+		}
+
+		fail_counter_short++;
+
+		mhdp_adjust_requested_eq(mhdp, dpcd);
+	} while (fail_counter_short < 5);
+
+err:
+	dev_dbg(mhdp->dev,
+		"Link training - EQ phase failed for %d lanes and %d rate\n",
+		mhdp->link.num_lanes, mhdp->link.rate);
+
+	return false;
+}
+
+static void mhdp_adjust_requested_cr(struct cdns_mhdp_device *mhdp,
+				     u8 link_status[DP_LINK_STATUS_SIZE],
+				     u8 *req_volt, u8 *req_pre)
+{
+	unsigned int i, max_volt = CDNS_VOLT_SWING(mhdp->host.volt_swing),
+		     max_pre = CDNS_PRE_EMPHASIS(mhdp->host.pre_emphasis);
+
+	for (i = 0; i < mhdp->link.num_lanes; i++) {
+		if (mhdp->host.volt_swing & CDNS_FORCE_VOLT_SWING)
+			mhdp_set_adjust_request_voltage(link_status, i,
+							max_volt);
+		else
+			mhdp_set_adjust_request_voltage(link_status, i,
+							req_volt[i]);
+
+		if (mhdp->host.pre_emphasis & CDNS_FORCE_PRE_EMPHASIS)
+			mhdp_set_adjust_request_pre_emphasis(link_status, i,
+							     max_pre);
+		else
+			mhdp_set_adjust_request_pre_emphasis(link_status, i,
+							     req_pre[i]);
+	}
+}
+
+static void mhdp_validate_cr(struct cdns_mhdp_device *mhdp, bool *cr_done,
+			     bool *same_before_adjust, bool *max_swing_reached,
+			     u8 before_cr[DP_LINK_STATUS_SIZE],
+			     u8 after_cr[DP_LINK_STATUS_SIZE], u8 *req_volt,
+			     u8 *req_pre)
+{
+	unsigned int i;
+	u8 tmp, max_volt = CDNS_VOLT_SWING(mhdp->host.volt_swing),
+	   max_pre = CDNS_PRE_EMPHASIS(mhdp->host.pre_emphasis);
+	bool same_pre, same_volt;
+
+	*same_before_adjust = false;
+	*max_swing_reached = false;
+	*cr_done = drm_dp_clock_recovery_ok(after_cr, mhdp->link.num_lanes);
+
+	for (i = 0; i < mhdp->link.num_lanes; i++) {
+		tmp = drm_dp_get_adjust_request_voltage(after_cr, i);
+		req_volt[i] = min_t(u8, tmp, max_volt);
+
+		tmp = drm_dp_get_adjust_request_pre_emphasis(after_cr, i) >>
+			DP_TRAIN_PRE_EMPHASIS_SHIFT;
+		req_pre[i] = min_t(u8, tmp, max_pre);
+
+		same_pre = (before_cr[i] & DP_TRAIN_PRE_EMPHASIS_MASK) ==
+			(req_pre[i] << DP_TRAIN_PRE_EMPHASIS_SHIFT);
+		same_volt = (before_cr[i] & DP_TRAIN_VOLTAGE_SWING_MASK) ==
+			req_volt[i];
+		if (same_pre && same_volt)
+			*same_before_adjust = true;
+
+		/* 3.1.5.2 in DP Standard v1.4. Table 3-1 */
+		if (!*cr_done && req_volt[i] + req_pre[i] >= 3) {
+			*max_swing_reached = true;
+			return;
+		}
+	}
+}
+
+static bool mhdp_link_training_clock_recovery(struct cdns_mhdp_device *mhdp)
+{
+	u8 lanes_data[CDNS_DP_MAX_NUM_LANES], fail_counter_short = 0,
+	   fail_counter_cr_long = 0;
+	u8 dpcd[DP_LINK_STATUS_SIZE];
+	bool cr_done;
+
+	dev_dbg(mhdp->dev, "Link training starting CR phase\n");
+
+	mhdp_link_training_init(mhdp);
+
+	drm_dp_dpcd_read_link_status(&mhdp->aux, dpcd);
+
+	do {
+		u8 requested_adjust_volt_swing[CDNS_DP_MAX_NUM_LANES] = {},
+		   requested_adjust_pre_emphasis[CDNS_DP_MAX_NUM_LANES] = {};
+		bool same_before_adjust, max_swing_reached;
+
+		mhdp_get_adjust_train(mhdp, dpcd, lanes_data);
+
+		cdns_mhdp_adjust_lt(mhdp, mhdp->link.num_lanes, 100,
+				    lanes_data, dpcd);
+
+		mhdp_validate_cr(mhdp, &cr_done, &same_before_adjust,
+				 &max_swing_reached, lanes_data, dpcd,
+				 requested_adjust_volt_swing,
+				 requested_adjust_pre_emphasis);
+
+		if (max_swing_reached)
+			goto err;
+
+		if (cr_done) {
+			dev_dbg(mhdp->dev,
+				"Link training: CR phase succeeded\n");
+			return true;
+		}
+
+		/* Not all CR_DONE bits set */
+		fail_counter_cr_long++;
+
+		if (same_before_adjust) {
+			fail_counter_short++;
+			continue;
+		}
+
+		fail_counter_short = 0;
+		/*
+		 * Voltage swing/pre-emphasis adjust requested
+		 * during CR phase
+		 */
+		mhdp_adjust_requested_cr(mhdp, dpcd,
+					 requested_adjust_volt_swing,
+					 requested_adjust_pre_emphasis);
+	} while (fail_counter_short < 5 && fail_counter_cr_long < 10);
+
+err:
+	dev_dbg(mhdp->dev,
+		"Link training: CR phase failed for %d lanes and %d rate\n",
+		mhdp->link.num_lanes, mhdp->link.rate);
+
+	return false;
+}
+
+static void lower_link_rate(struct drm_dp_link *link)
+{
+	switch (drm_dp_link_rate_to_bw_code(link->rate)) {
+	case DP_LINK_BW_2_7:
+		link->rate = drm_dp_bw_code_to_link_rate(DP_LINK_BW_1_62);
+		break;
+	case DP_LINK_BW_5_4:
+		link->rate = drm_dp_bw_code_to_link_rate(DP_LINK_BW_2_7);
+		break;
+	case DP_LINK_BW_8_1:
+		link->rate = drm_dp_bw_code_to_link_rate(DP_LINK_BW_5_4);
+		break;
+	}
+}
+
+static int mhdp_link_training(struct cdns_mhdp_device *mhdp,
+			      unsigned int video_mode,
+			      unsigned int training_interval)
+{
+	u32 reg32;
+	u8 eq_tps = eq_training_pattern_supported(mhdp->host, mhdp->sink);
+
+	while (1) {
+		if (!mhdp_link_training_clock_recovery(mhdp)) {
+			if (drm_dp_link_rate_to_bw_code(mhdp->link.rate) !=
+			    DP_LINK_BW_1_62) {
+				dev_dbg(mhdp->dev,
+					"Reducing link rate during CR phase\n");
+				lower_link_rate(&mhdp->link);
+				drm_dp_link_configure(&mhdp->aux, &mhdp->link);
+
+				continue;
+			} else if (mhdp->link.num_lanes > 1) {
+				dev_dbg(mhdp->dev,
+					"Reducing lanes number during CR phase\n");
+				mhdp->link.num_lanes >>= 1;
+				mhdp->link.rate = max_link_rate(mhdp->host,
+								mhdp->sink);
+				drm_dp_link_configure(&mhdp->aux, &mhdp->link);
+
+				continue;
+			}
+
+			dev_dbg(mhdp->dev,
+				"Link training failed during CR phase\n");
+			goto err;
+		}
+
+		if (mhdp_link_training_channel_eq(mhdp, eq_tps,
+						  training_interval))
+			break;
+
+		if (mhdp->link.num_lanes > 1) {
+			dev_dbg(mhdp->dev,
+				"Reducing lanes number during EQ phase\n");
+			mhdp->link.num_lanes >>= 1;
+			drm_dp_link_configure(&mhdp->aux, &mhdp->link);
+
+			continue;
+		} else if (drm_dp_link_rate_to_bw_code(mhdp->link.rate) !=
+			   DP_LINK_BW_1_62) {
+			dev_dbg(mhdp->dev,
+				"Reducing link rate during EQ phase\n");
+			lower_link_rate(&mhdp->link);
+			drm_dp_link_configure(&mhdp->aux, &mhdp->link);
+
+			continue;
+		}
+
+		dev_dbg(mhdp->dev, "Link training failed during EQ phase\n");
+		goto err;
+	}
+
+	dev_dbg(mhdp->dev, "Link training successful\n");
+
+	drm_dp_dpcd_writeb(&mhdp->aux, DP_TRAINING_PATTERN_SET,
+			   (mhdp->host.lanes_cnt & CDNS_SCRAMBLER) ? 0 :
+			   DP_LINK_SCRAMBLING_DISABLE);
+
+	/* SW reset DPTX framer */
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_SW_RESET, 1);
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_SW_RESET, 0);
+
+	/* Enable framer */
+	/* FIXME: update when MST supported, BIT(2) */
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_FRAMER_GLOBAL_CONFIG,
+			    CDNS_DP_FRAMER_EN |
+			    CDNS_DP_NUM_LANES(mhdp->link.num_lanes) |
+			    CDNS_DP_DISABLE_PHY_RST |
+			    CDNS_DP_WR_FAILING_EDGE_VSYNC |
+			    (!video_mode ? CDNS_DP_NO_VIDEO_MODE : 0));
+
+	/* Reset PHY config */
+	reg32 = CDNS_PHY_COMMON_CONFIG | CDNS_PHY_TRAINING_TYPE(1);
+	if (!(mhdp->host.lanes_cnt & CDNS_SCRAMBLER))
+		reg32 |= CDNS_PHY_SCRAMBLER_BYPASS;
+	cdns_mhdp_reg_write(mhdp, CDNS_DPTX_PHY_CONFIG, reg32);
+
+	return 0;
+err:
+	/* Reset PHY config */
+	reg32 = CDNS_PHY_COMMON_CONFIG | CDNS_PHY_TRAINING_TYPE(1);
+	if (!(mhdp->host.lanes_cnt & CDNS_SCRAMBLER))
+		reg32 |= CDNS_PHY_SCRAMBLER_BYPASS;
+	cdns_mhdp_reg_write(mhdp, CDNS_DPTX_PHY_CONFIG, reg32);
+
+	drm_dp_dpcd_writeb(&mhdp->aux, DP_TRAINING_PATTERN_SET,
+			   DP_TRAINING_PATTERN_DISABLE);
+
+	return -EIO;
+}
+
+static void cdns_mhdp_disable(struct drm_bridge *bridge)
+{
+	struct cdns_mhdp_device *mhdp = bridge_to_mhdp(bridge);
+
+	cdns_mhdp_set_video_status(mhdp, 0);
+
+	drm_dp_link_power_down(&mhdp->aux, &mhdp->link);
+}
+
+static void cdns_mhdp_enable(struct drm_bridge *bridge)
+{
+	struct cdns_mhdp_device *mhdp = bridge_to_mhdp(bridge);
+	struct drm_display_mode *mode;
+	struct drm_display_info *disp_info = &mhdp->connector.display_info;
+	enum pixel_format pxlfmt;
+	int pxlclock;
+	unsigned int rate, tu_size = 30, vs, vs_f, bpp, required_bandwidth,
+		     available_bandwidth, dp_framer_sp = 0, msa_horizontal_1,
+		     msa_vertical_1, bnd_hsync2vsync, hsync2vsync_pol_ctrl,
+		     misc0 = 0, misc1 = 0, line_thresh = 0, pxl_repr,
+		     front_porch, back_porch, msa_h0, msa_v0, hsync, vsync,
+		     dp_vertical_1, line_thresh1, line_thresh2;
+	u32 resp;
+
+	unsigned int size = DP_RECEIVER_CAP_SIZE, dp_framer_global_config,
+		     video_mode, training_interval_us;
+	u8 reg0[size], reg8, amp[2];
+
+	mode = &bridge->encoder->crtc->state->adjusted_mode;
+	pxlclock = mode->crtc_clock;
+
+	/*
+	 * Upon power-on reset/device disconnection: [2:0] bits should be 0b001
+	 * and [7:5] bits 0b000.
+	 */
+	drm_dp_dpcd_writeb(&mhdp->aux, DP_SET_POWER, 1);
+
+	drm_dp_link_probe(&mhdp->aux, &mhdp->link);
+
+	dev_dbg(mhdp->dev, "Set sink device power state via DPCD\n");
+	drm_dp_link_power_up(&mhdp->aux, &mhdp->link);
+	/* FIXME (CDNS): do we have to wait for 100ms before going on? */
+	mdelay(100);
+
+	mhdp->sink.link_rate = mhdp->link.rate;
+	mhdp->sink.lanes_cnt = mhdp->link.num_lanes;
+	mhdp->sink.enhanced = !!(mhdp->link.capabilities &
+				 DP_LINK_CAP_ENHANCED_FRAMING);
+
+	drm_dp_dpcd_read(&mhdp->aux, DP_DPCD_REV, reg0, size);
+
+	mhdp->sink.pattern_supp = CDNS_SUPPORT_TPS(1) | CDNS_SUPPORT_TPS(2);
+	if (drm_dp_tps3_supported(reg0))
+		mhdp->sink.pattern_supp |= CDNS_SUPPORT_TPS(3);
+	if (drm_dp_tps4_supported(reg0))
+		mhdp->sink.pattern_supp |= CDNS_SUPPORT_TPS(4);
+
+	mhdp->sink.fast_link = !!(reg0[DP_MAX_DOWNSPREAD] &
+				  DP_NO_AUX_HANDSHAKE_LINK_TRAINING);
+
+	mhdp->link.rate = max_link_rate(mhdp->host, mhdp->sink);
+	mhdp->link.num_lanes = min_t(u8, mhdp->sink.lanes_cnt,
+				     mhdp->host.lanes_cnt & GENMASK(2, 0));
+
+	reg8 = reg0[DP_TRAINING_AUX_RD_INTERVAL] &
+		DP_TRAINING_AUX_RD_MASK;
+	switch (reg8) {
+	case 0:
+		training_interval_us = 400;
+		break;
+	case 1:
+	case 2:
+	case 3:
+	case 4:
+		training_interval_us = 4000 << (reg8 - 1);
+		break;
+	default:
+		dev_err(mhdp->dev,
+			"wrong training interval returned by DPCD: %d\n", reg8);
+		return;
+	}
+
+	cdns_mhdp_reg_read(mhdp, CDNS_DP_FRAMER_GLOBAL_CONFIG, &resp);
+
+	dp_framer_global_config = be32_to_cpu(resp);
+
+	video_mode = !(dp_framer_global_config & CDNS_DP_NO_VIDEO_MODE);
+
+	if (dp_framer_global_config & CDNS_DP_FRAMER_EN)
+		cdns_mhdp_reg_write(mhdp, CDNS_DP_FRAMER_GLOBAL_CONFIG,
+				    dp_framer_global_config &
+				    ~CDNS_DP_FRAMER_EN);
+
+	/* Spread AMP if required, enable 8b/10b coding */
+	amp[0] = (mhdp->host.lanes_cnt & CDNS_SSC) ? DP_SPREAD_AMP_0_5 : 0;
+	amp[1] = DP_SET_ANSI_8B10B;
+	drm_dp_dpcd_write(&mhdp->aux, DP_DOWNSPREAD_CTRL, amp, 2);
+
+	if (mhdp->host.fast_link & mhdp->sink.fast_link) {
+		/* FIXME: implement fastlink */
+		dev_dbg(mhdp->dev, "fastlink\n");
+	} else {
+		if (mhdp_link_training(mhdp, video_mode,
+				       training_interval_us)) {
+			dev_err(mhdp->dev, "Link training failed. Exiting.\n");
+			return;
+		}
+	}
+
+	rate = mhdp->link.rate / 1000;
+
+	/* FIXME: what about Y_ONLY? how is it handled in the kernel? */
+	if (disp_info->color_formats & DRM_COLOR_FORMAT_YCRCB444)
+		pxlfmt = PIXEL_FORMAT_YCBCR_444;
+	else if (disp_info->color_formats & DRM_COLOR_FORMAT_YCRCB422)
+		pxlfmt = PIXEL_FORMAT_YCBCR_422;
+	else if (disp_info->color_formats & DRM_COLOR_FORMAT_YCRCB420)
+		pxlfmt = PIXEL_FORMAT_YCBCR_420;
+	else
+		pxlfmt = PIXEL_FORMAT_RGB;
+
+	/* if YCBCR supported and stream not SD, use ITU709 */
+	/* FIXME: handle ITU version with YCBCR420 when supported */
+	if ((pxlfmt == PIXEL_FORMAT_YCBCR_444 ||
+	     pxlfmt == PIXEL_FORMAT_YCBCR_422) && mode->crtc_vdisplay >= 720)
+		misc0 = DP_YCBCR_COEFFICIENTS_ITU709;
+
+	switch (pxlfmt) {
+	case PIXEL_FORMAT_RGB:
+		bpp = disp_info->bpc * 3;
+		pxl_repr = CDNS_DP_FRAMER_RGB << CDNS_DP_FRAMER_PXL_FORMAT;
+		misc0 |= DP_COLOR_FORMAT_RGB;
+		break;
+	case PIXEL_FORMAT_YCBCR_444:
+		bpp = disp_info->bpc * 3;
+		pxl_repr = CDNS_DP_FRAMER_YCBCR444 << CDNS_DP_FRAMER_PXL_FORMAT;
+		misc0 |= DP_COLOR_FORMAT_YCbCr444 | DP_TEST_DYNAMIC_RANGE_CEA;
+		break;
+	case PIXEL_FORMAT_YCBCR_422:
+		bpp = disp_info->bpc * 2;
+		pxl_repr = CDNS_DP_FRAMER_YCBCR422 << CDNS_DP_FRAMER_PXL_FORMAT;
+		misc0 |= DP_COLOR_FORMAT_YCbCr422 | DP_TEST_DYNAMIC_RANGE_CEA;
+		break;
+	case PIXEL_FORMAT_YCBCR_420:
+		bpp = disp_info->bpc * 3 / 2;
+		pxl_repr = CDNS_DP_FRAMER_YCBCR420 << CDNS_DP_FRAMER_PXL_FORMAT;
+		break;
+	default:
+		bpp = disp_info->bpc;
+		pxl_repr = CDNS_DP_FRAMER_Y_ONLY << CDNS_DP_FRAMER_PXL_FORMAT;
+	}
+
+	switch (disp_info->bpc) {
+	case 6:
+		misc0 |= DP_TEST_BIT_DEPTH_6;
+		pxl_repr |= CDNS_DP_FRAMER_6_BPC;
+		break;
+	case 8:
+		misc0 |= DP_TEST_BIT_DEPTH_8;
+		pxl_repr |= CDNS_DP_FRAMER_8_BPC;
+		break;
+	case 10:
+		misc0 |= DP_TEST_BIT_DEPTH_10;
+		pxl_repr |= CDNS_DP_FRAMER_10_BPC;
+		break;
+	case 12:
+		misc0 |= DP_TEST_BIT_DEPTH_12;
+		pxl_repr |= CDNS_DP_FRAMER_12_BPC;
+		break;
+	case 16:
+		misc0 |= DP_TEST_BIT_DEPTH_16;
+		pxl_repr |= CDNS_DP_FRAMER_16_BPC;
+		break;
+	}
+
+	/* find optimal tu_size */
+	required_bandwidth = pxlclock * bpp / 8;
+	available_bandwidth = mhdp->link.num_lanes * rate;
+	do {
+		tu_size += 2;
+
+		vs_f = tu_size * required_bandwidth / available_bandwidth;
+		vs = vs_f / 1000;
+		vs_f = vs_f % 1000;
+		/*
+		 * FIXME (CDNS): downspreading?
+		 * It's unused is what I've been told.
+		 */
+	} while ((vs == 1 || ((vs_f > 850 || vs_f < 100) && vs_f != 0) ||
+		  tu_size - vs < 2) && tu_size < 64);
+
+	if (vs > 64)
+		return;
+
+	bnd_hsync2vsync = CDNS_IP_BYPASS_V_INTERFACE;
+	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
+		bnd_hsync2vsync |= CDNS_IP_DET_INTERLACE_FORMAT;
+
+	cdns_mhdp_reg_write(mhdp, CDNS_BND_HSYNC2VSYNC, bnd_hsync2vsync);
+
+	if (mode->flags & DRM_MODE_FLAG_INTERLACE &&
+	    mode->flags & DRM_MODE_FLAG_PHSYNC)
+		hsync2vsync_pol_ctrl = CDNS_H2V_HSYNC_POL_ACTIVE_LOW |
+			CDNS_H2V_VSYNC_POL_ACTIVE_LOW;
+	else
+		hsync2vsync_pol_ctrl = 0;
+
+	cdns_mhdp_reg_write(mhdp, CDNS_HSYNC2VSYNC_POL_CTRL,
+			    hsync2vsync_pol_ctrl);
+
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_FRAMER_TU,
+			    CDNS_DP_FRAMER_TU_VS(vs) |
+			    CDNS_DP_FRAMER_TU_SIZE(tu_size) |
+			    CDNS_DP_FRAMER_TU_CNT_RST_EN);
+
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_FRAMER_PXL_REPR, pxl_repr);
+
+	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
+		dp_framer_sp |= CDNS_DP_FRAMER_INTERLACE;
+	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
+		dp_framer_sp |= CDNS_DP_FRAMER_HSYNC_POL_LOW;
+	if (mode->flags & DRM_MODE_FLAG_NVSYNC)
+		dp_framer_sp |= CDNS_DP_FRAMER_VSYNC_POL_LOW;
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_FRAMER_SP, dp_framer_sp);
+
+	front_porch = mode->crtc_hsync_start - mode->crtc_hdisplay;
+	back_porch = mode->crtc_htotal - mode->crtc_hsync_end;
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_FRONT_BACK_PORCH,
+			    CDNS_DP_FRONT_PORCH(front_porch) |
+			    CDNS_DP_BACK_PORCH(back_porch));
+
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_BYTE_COUNT,
+			    mode->crtc_hdisplay * bpp / 8);
+
+	msa_h0 = mode->crtc_htotal - mode->crtc_hsync_start;
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_MSA_HORIZONTAL_0,
+			    CDNS_DP_MSAH0_H_TOTAL(mode->crtc_htotal) |
+			    CDNS_DP_MSAH0_HSYNC_START(msa_h0));
+
+	hsync = mode->crtc_hsync_end - mode->crtc_hsync_start;
+	msa_horizontal_1 = CDNS_DP_MSAH1_HSYNC_WIDTH(hsync) |
+		CDNS_DP_MSAH1_HDISP_WIDTH(mode->crtc_hdisplay);
+	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
+		msa_horizontal_1 |= CDNS_DP_MSAH1_HSYNC_POL_LOW;
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_MSA_HORIZONTAL_1,
+			    msa_horizontal_1);
+
+	msa_v0 = mode->crtc_vtotal - mode->crtc_vsync_start;
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_MSA_VERTICAL_0,
+			    CDNS_DP_MSAV0_V_TOTAL(mode->crtc_vtotal) |
+			    CDNS_DP_MSAV0_VSYNC_START(msa_v0));
+
+	vsync = mode->crtc_vsync_end - mode->crtc_vsync_start;
+	msa_vertical_1 = CDNS_DP_MSAV1_VSYNC_WIDTH(vsync) |
+		CDNS_DP_MSAV1_VDISP_WIDTH(mode->crtc_vdisplay);
+	if (mode->flags & DRM_MODE_FLAG_NVSYNC)
+		msa_vertical_1 |= CDNS_DP_MSAV1_VSYNC_POL_LOW;
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_MSA_VERTICAL_1, msa_vertical_1);
+
+	if ((mode->flags & DRM_MODE_FLAG_INTERLACE) &&
+	    mode->crtc_vtotal % 2 == 0)
+		misc1 = DP_TEST_INTERLACED;
+	if (pxlfmt == PIXEL_FORMAT_Y_ONLY)
+		misc1 |= CDNS_DP_TEST_COLOR_FORMAT_RAW_Y_ONLY;
+	/* FIXME: use VSC SDP for Y420 */
+	/* FIXME: (CDNS) no code for Y420 in bare metal test */
+	if (pxlfmt == PIXEL_FORMAT_YCBCR_420)
+		misc1 = CDNS_DP_TEST_VSC_SDP;
+
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_MSA_MISC, misc0 | (misc1 << 8));
+
+	/* FIXME: to be changed if MST mode */
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_STREAM_CONFIG, 1);
+
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_HORIZONTAL,
+			    CDNS_DP_H_HSYNC_WIDTH(hsync) |
+			    CDNS_DP_H_H_TOTAL(mode->crtc_hdisplay));
+
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_VERTICAL_0,
+			    CDNS_DP_V0_VHEIGHT(mode->crtc_vdisplay) |
+			    CDNS_DP_V0_VSTART(msa_v0));
+
+	dp_vertical_1 = CDNS_DP_V1_VTOTAL(mode->crtc_vtotal);
+	if ((mode->flags & DRM_MODE_FLAG_INTERLACE) &&
+	    mode->crtc_vtotal % 2 == 0)
+		dp_vertical_1 |= CDNS_DP_V1_VTOTAL_EVEN;
+
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_VERTICAL_1, dp_vertical_1);
+
+	cdns_mhdp_reg_write_bit(mhdp, CDNS_DP_VB_ID, 2, 1,
+				(mode->flags & DRM_MODE_FLAG_INTERLACE) ?
+				CDNS_DP_VB_ID_INTERLACED : 0);
+
+	line_thresh1 = ((vs + 1) << 5) * 8 / bpp;
+	line_thresh2 = (pxlclock << 5) / 1000 / rate * (vs + 1) - (1 << 5);
+	line_thresh = line_thresh1 - line_thresh2 / mhdp->link.num_lanes;
+	line_thresh = (line_thresh >> 5) + 2;
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_LINE_THRESH,
+			    line_thresh & GENMASK(5, 0));
+
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_RATE_GOVERNOR_STATUS,
+			    CDNS_DP_RG_TU_VS_DIFF((tu_size - vs > 3) ?
+						       0 : tu_size - vs));
+
+	cdns_mhdp_set_video_status(mhdp, 1);
+}
+
+static const struct drm_bridge_funcs cdns_mhdp_bridge_funcs = {
+	.enable = cdns_mhdp_enable,
+	.disable = cdns_mhdp_disable,
+	.attach = cdns_mhdp_attach,
+};
+
+static int load_firmware(struct cdns_mhdp_device *mhdp, const char *name,
+			 unsigned int addr)
+{
+	const struct firmware *fw;
+	int ret;
+
+	ret = request_firmware(&fw, name, mhdp->dev);
+	if (ret) {
+		dev_err(mhdp->dev, "failed to load firmware (%s), ret: %d\n",
+			name, ret);
+		return ret;
+	}
+
+	memcpy_toio(mhdp->regs + addr, fw->data, fw->size);
+
+	release_firmware(fw);
+
+	return 0;
+}
+
+static int cdns_mhdp_audio_hw_params(struct device *dev, void *data,
+				     struct hdmi_codec_daifmt *daifmt,
+				     struct hdmi_codec_params *params)
+{
+	struct cdns_mhdp_device *mhdp = dev_get_drvdata(dev);
+	struct audio_info audio = {
+		.sample_width = params->sample_width,
+		.sample_rate = params->sample_rate,
+		.channels = params->channels,
+	};
+	int ret;
+
+	if (daifmt->fmt != HDMI_I2S) {
+		DRM_DEV_ERROR(dev, "Invalid format %d\n", daifmt->fmt);
+		return -EINVAL;
+	}
+
+	audio.format = AFMT_I2S;
+
+	ret = cdns_mhdp_audio_config(mhdp, &audio);
+	if (!ret)
+		mhdp->audio_info = audio;
+
+	return 0;
+}
+
+static void cdns_mhdp_audio_shutdown(struct device *dev, void *data)
+{
+	struct cdns_mhdp_device *mhdp = dev_get_drvdata(dev);
+	int ret;
+
+	ret = cdns_mhdp_audio_stop(mhdp, &mhdp->audio_info);
+	if (!ret)
+		mhdp->audio_info.format = AFMT_UNUSED;
+}
+
+static int cdns_mhdp_audio_digital_mute(struct device *dev, void *data,
+					bool enable)
+{
+	struct cdns_mhdp_device *mhdp = dev_get_drvdata(dev);
+
+	return cdns_mhdp_audio_mute(mhdp, enable);
+}
+
+static int cdns_mhdp_audio_get_eld(struct device *dev, void *data,
+				   u8 *buf, size_t len)
+{
+	struct cdns_mhdp_device *mhdp = dev_get_drvdata(dev);
+
+	memcpy(buf, mhdp->connector.eld,
+	       min(sizeof(mhdp->connector.eld), len));
+
+	return 0;
+}
+
+static const struct hdmi_codec_ops audio_codec_ops = {
+	.hw_params = cdns_mhdp_audio_hw_params,
+	.audio_shutdown = cdns_mhdp_audio_shutdown,
+	.digital_mute = cdns_mhdp_audio_digital_mute,
+	.get_eld = cdns_mhdp_audio_get_eld,
+};
+
+static int mhdp_probe(struct platform_device *pdev)
+{
+	struct resource *regs;
+	struct cdns_mhdp_device *mhdp;
+	struct clk *clk;
+	int ret;
+	unsigned int reg;
+	unsigned long rate;
+	u32 resp;
+
+	struct hdmi_codec_pdata codec_data = {
+		.i2s = 1,
+		.max_i2s_channels = 8,
+		.ops = &audio_codec_ops,
+	};
+
+	mhdp = devm_kzalloc(&pdev->dev, sizeof(struct cdns_mhdp_device),
+			    GFP_KERNEL);
+	if (!mhdp)
+		return -ENOMEM;
+
+	clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(clk)) {
+		dev_err(&pdev->dev, "couldn't get clk: %ld\n", PTR_ERR(clk));
+		return PTR_ERR(clk);
+	}
+
+	mhdp->dev = &pdev->dev;
+	dev_set_drvdata(&pdev->dev, mhdp);
+
+	drm_dp_aux_init(&mhdp->aux);
+	mhdp->aux.dev = &pdev->dev;
+	mhdp->aux.transfer = mhdp_transfer;
+
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	mhdp->regs = devm_ioremap_resource(&pdev->dev, regs);
+	if (IS_ERR(mhdp->regs))
+		return PTR_ERR(mhdp->regs);
+
+	platform_set_drvdata(pdev, mhdp);
+
+	ret = load_firmware(mhdp, FW_NAME, CDNS_MHDP_IMEM);
+	if (ret)
+		return ret;
+
+	rate = clk_get_rate(clk);
+	writel(rate % 1000000, mhdp->regs + CDNS_SW_CLK_L);
+	writel(rate / 1000000, mhdp->regs + CDNS_SW_CLK_H);
+
+	/* Leave debug mode */
+	writel(0, mhdp->regs + CDNS_APB_CTRL);
+
+	/*
+	 * Wait for the KEEP_ALIVE "message" on the first 8 bits.
+	 * Updated each sched "tick" (~2ms)
+	 */
+	ret = readl_poll_timeout(mhdp->regs + CDNS_KEEP_ALIVE, reg,
+				 reg & CDNS_KEEP_ALIVE_MASK, 500,
+				 CDNS_KEEP_ALIVE_TIMEOUT);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"device didn't give any life sign: reg %d\n", reg);
+		return -EIO;
+	}
+
+	/*
+	 * FIXME (CDNS): how are the characteristics/features of the host
+	 * defined? Will they be always hardcoded?
+	 */
+	/* FIXME: link rate 2.7; num_lanes = 2,	 */
+	/* FIXME: read capabilities from PHY */
+	mhdp->host.link_rate = drm_dp_bw_code_to_link_rate(DP_LINK_BW_5_4);
+	mhdp->host.lanes_cnt = CDNS_LANE_4 | CDNS_SCRAMBLER;
+	mhdp->host.volt_swing = CDNS_VOLT_SWING(3);
+	mhdp->host.pre_emphasis = CDNS_PRE_EMPHASIS(2);
+	mhdp->host.pattern_supp = CDNS_SUPPORT_TPS(1) |
+		CDNS_SUPPORT_TPS(2) | CDNS_SUPPORT_TPS(3) |
+		CDNS_SUPPORT_TPS(4);
+	mhdp->host.fast_link = 0;
+	mhdp->host.lane_mapping = CDNS_LANE_MAPPING_FLIPPED;
+	mhdp->host.enhanced = true;
+
+	mhdp->bridge.of_node = pdev->dev.of_node;
+	mhdp->bridge.funcs = &cdns_mhdp_bridge_funcs;
+
+	/* Init events to 0 as it's not cleared by FW at boot but on read */
+	readl(mhdp->regs + CDNS_SW_EVENT0);
+	readl(mhdp->regs + CDNS_SW_EVENT1);
+	readl(mhdp->regs + CDNS_SW_EVENT2);
+	readl(mhdp->regs + CDNS_SW_EVENT3);
+
+	/* Activate uCPU */
+	ret = cdns_mhdp_set_firmware_active(mhdp, true);
+	if (ret) {
+		dev_err(mhdp->dev, "Failed to activate DP\n");
+		return ret;
+	}
+
+	mhdp->audio_pdev = platform_device_register_data(
+			   mhdp->dev, HDMI_CODEC_DRV_NAME, PLATFORM_DEVID_AUTO,
+			   &codec_data, sizeof(codec_data));
+
+	/* Enable VIF clock for stream 0 */
+	cdns_mhdp_reg_read(mhdp, CDNS_DPTX_CAR, &resp);
+	cdns_mhdp_reg_write(mhdp, CDNS_DPTX_CAR,
+			    resp | CDNS_VIF_CLK_EN | CDNS_VIF_CLK_RSTN);
+
+	/* Loop over HDP change */
+	/*
+	 * FIXME: does not work when put in mhdp_bridge_enable.
+	 * Where should we put it?
+	 */
+	/* Is it still needed with use of mb message HPD STATUS? */
+	ret = readl_poll_timeout(mhdp->regs + CDNS_SW_EVENT0, reg,
+				 reg & CDNS_DPTX_HPD, 500,
+				 CDNS_SW_EVENT0_TIMEOUT);
+	if (ret) {
+		dev_err(mhdp->dev, "no HPD received %d\n", reg);
+		return -ENODEV;
+	}
+
+	drm_bridge_add(&mhdp->bridge);
+
+	return 0;
+}
+
+MODULE_FIRMWARE(FW_NAME);
+
+static int mhdp_remove(struct platform_device *pdev)
+{
+	struct cdns_mhdp_device *mhdp = dev_get_drvdata(&pdev->dev);
+	int ret;
+
+	platform_device_unregister(mhdp->audio_pdev);
+
+	drm_bridge_remove(&mhdp->bridge);
+
+	ret = cdns_mhdp_set_firmware_active(mhdp, false);
+	if (ret) {
+		dev_err(mhdp->dev, "Failed to de-activate DP\n");
+		return ret;
+	}
+
+	/* FIXME: check for missing functions */
+
+	return 0;
+}
+
+static struct platform_driver mhdp_driver = {
+	.driver	= {
+		.name		= "cdns-mhdp",
+		.of_match_table	= of_match_ptr(mhdp_ids),
+	},
+	.probe	= mhdp_probe,
+	.remove	= mhdp_remove,
+};
+module_platform_driver(mhdp_driver);
+
+MODULE_AUTHOR("Quentin Schulz <quentin.schulz@free-electrons.com>");
+MODULE_DESCRIPTION("Cadence MHDP DP bridge driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:cdns-mhdp");
diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
index 0ccc76217ee4..341572184b17 100644
--- a/drivers/gpu/drm/rockchip/Kconfig
+++ b/drivers/gpu/drm/rockchip/Kconfig
@@ -27,7 +27,9 @@ config ROCKCHIP_ANALOGIX_DP
 
 config ROCKCHIP_CDN_DP
         bool "Rockchip cdn DP"
-	depends on EXTCON=y || (EXTCON=m && DRM_ROCKCHIP=m)
+	depends on DRM_ROCKCHIP
+	select EXTCON
+	select DRM_CDNS_MHDP
         help
 	  This selects support for Rockchip SoC specific extensions
 	  for the cdn DP driver. If you want to enable Dp on
diff --git a/drivers/gpu/drm/rockchip/Makefile b/drivers/gpu/drm/rockchip/Makefile
index a314e2109e76..f2d462779186 100644
--- a/drivers/gpu/drm/rockchip/Makefile
+++ b/drivers/gpu/drm/rockchip/Makefile
@@ -9,7 +9,7 @@ rockchipdrm-y := rockchip_drm_drv.o rockchip_drm_fb.o \
 rockchipdrm-$(CONFIG_DRM_FBDEV_EMULATION) += rockchip_drm_fbdev.o
 
 rockchipdrm-$(CONFIG_ROCKCHIP_ANALOGIX_DP) += analogix_dp-rockchip.o
-rockchipdrm-$(CONFIG_ROCKCHIP_CDN_DP) += cdn-dp-core.o cdn-dp-reg.o
+rockchipdrm-$(CONFIG_ROCKCHIP_CDN_DP) += cdn-dp-core.o
 rockchipdrm-$(CONFIG_ROCKCHIP_DW_HDMI) += dw_hdmi-rockchip.o
 rockchipdrm-$(CONFIG_ROCKCHIP_DW_MIPI_DSI) += dw-mipi-dsi.o
 rockchipdrm-$(CONFIG_ROCKCHIP_INNO_HDMI) += inno_hdmi.o
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index bf7e206326f0..343f381e3440 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -816,7 +816,7 @@ static int cdn_dp_audio_hw_params(struct device *dev,  void *data,
 
 	ret = cdns_mhdp_audio_config(&dp->mhdp, &audio);
 	if (!ret)
-		dp->audio_info = audio;
+		dp->mhdp.audio_info = audio;
 
 out:
 	mutex_unlock(&dp->lock);
@@ -832,9 +832,9 @@ static void cdn_dp_audio_shutdown(struct device *dev, void *data)
 	if (!dp->active)
 		goto out;
 
-	ret = cdns_mhdp_audio_stop(&dp->mhdp, &dp->audio_info);
+	ret = cdns_mhdp_audio_stop(&dp->mhdp, &dp->mhdp.audio_info);
 	if (!ret)
-		dp->audio_info.format = AFMT_UNUSED;
+		dp->mhdp.audio_info.format = AFMT_UNUSED;
 out:
 	mutex_unlock(&dp->lock);
 }
@@ -886,11 +886,11 @@ static int cdn_dp_audio_codec_init(struct cdn_dp_device *dp,
 		.max_i2s_channels = 8,
 	};
 
-	dp->audio_pdev = platform_device_register_data(
-			 dev, HDMI_CODEC_DRV_NAME, PLATFORM_DEVID_AUTO,
-			 &codec_data, sizeof(codec_data));
+	dp->mhdp.audio_pdev = platform_device_register_data(
+			      dev, HDMI_CODEC_DRV_NAME, PLATFORM_DEVID_AUTO,
+			      &codec_data, sizeof(codec_data));
 
-	return PTR_ERR_OR_ZERO(dp->audio_pdev);
+	return PTR_ERR_OR_ZERO(dp->mhdp.audio_pdev);
 }
 
 static int cdn_dp_request_firmware(struct cdn_dp_device *dp)
@@ -1217,7 +1217,7 @@ static int cdn_dp_remove(struct platform_device *pdev)
 {
 	struct cdn_dp_device *dp = platform_get_drvdata(pdev);
 
-	platform_device_unregister(dp->audio_pdev);
+	platform_device_unregister(dp->mhdp.audio_pdev);
 	cdn_dp_suspend(dp->mhdp.dev);
 	component_del(&pdev->dev, &cdn_dp_component_ops);
 
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.h b/drivers/gpu/drm/rockchip/cdn-dp-core.h
index bad65c2fe610..a086dad31287 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.h
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.h
@@ -19,8 +19,9 @@
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_dp_helper.h>
 #include <drm/drm_panel.h>
+#include <drm/bridge/cdns-mhdp-common.h>
+
 #include "rockchip_drm_drv.h"
-#include "cdn-dp-reg.h"
 
 #define MAX_PHY		2
 
@@ -45,7 +46,6 @@ struct cdn_dp_device {
 	struct cdns_mhdp_device mhdp;
 	struct drm_device *drm_dev;
 	struct drm_encoder encoder;
-	struct platform_device *audio_pdev;
 	struct work_struct event_work;
 	struct edid *edid;
 
@@ -64,7 +64,6 @@ struct cdn_dp_device {
 	struct reset_control *dptx_rst;
 	struct reset_control *apb_rst;
 	struct reset_control *core_rst;
-	struct audio_info audio_info;
 	struct cdn_dp_port *port[MAX_PHY];
 	u8 ports;
 	u8 lanes;
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-reg.h b/include/drm/bridge/cdns-mhdp-common.h
similarity index 95%
rename from drivers/gpu/drm/rockchip/cdn-dp-reg.h
rename to include/drm/bridge/cdns-mhdp-common.h
index 3cb40d719515..c5a5c4fa7fc4 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-reg.h
+++ b/include/drm/bridge/cdns-mhdp-common.h
@@ -12,10 +12,13 @@
  * GNU General Public License for more details.
  */
 
-#ifndef _CDN_DP_REG_H
-#define _CDN_DP_REG_H
+#ifndef CDNS_MHDP_COMMON_H_
+#define CDNS_MHDP_COMMON_H_
 
 #include <linux/bitops.h>
+#include <drm/drm_dp_helper.h>
+#include <drm/drm_connector.h>
+#include <drm/drm_bridge.h>
 
 #define ADDR_IMEM		0x10000
 #define ADDR_DMEM		0x20000
@@ -327,6 +330,7 @@
 #define GENERAL_TEST_ECHO               0x02
 #define GENERAL_BUS_SETTINGS            0x03
 #define GENERAL_TEST_ACCESS             0x04
+#define GENERAL_REGISTER_READ           0x07
 
 #define DPTX_SET_POWER_MNG			0x00
 #define DPTX_SET_HOST_CAPABILITIES		0x01
@@ -346,6 +350,7 @@
 #define DPTX_SET_LINK_BREAK_POINT		0x0f
 #define DPTX_FORCE_LANES			0x10
 #define DPTX_HPD_STATE				0x11
+#define DPTX_ADJUST_LT				0x12
 
 #define FW_STANDBY				0
 #define FW_ACTIVE				1
@@ -517,6 +522,9 @@ struct cdns_mhdp_device {
 	struct clk		*spdif_clk;
 	struct reset_control	*spdif_rst;
 
+	struct platform_device	*audio_pdev;
+	struct audio_info	audio_info;
+
 	struct drm_dp_aux	aux;
 	struct cdns_mhdp_host	host;
 	struct cdns_mhdp_sink	sink;
@@ -551,4 +559,11 @@ int cdns_mhdp_audio_stop(struct cdns_mhdp_device *mhdp,
 int cdns_mhdp_audio_mute(struct cdns_mhdp_device *mhdp, bool enable);
 int cdns_mhdp_audio_config(struct cdns_mhdp_device *mhdp,
 			   struct audio_info *audio);
-#endif /* _CDN_DP_REG_H */
+int cdns_mhdp_reg_read(struct cdns_mhdp_device *mhdp, u32 addr, u32 *value);
+int cdns_mhdp_reg_write(struct cdns_mhdp_device *mhdp, u16 addr, u32 val);
+int cdns_mhdp_reg_write_bit(struct cdns_mhdp_device *mhdp, u16 addr,
+				   u8 start_bit, u8 bits_no, u32 val);
+int cdns_mhdp_adjust_lt(struct cdns_mhdp_device *mhdp, u8 nlanes,
+			u16 udelay, u8 *lanes_data,
+			u8 *dpcd);
+#endif /* CDNS_MHDP_COMMON_H_ */
-- 
2.17.1

