Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88D2C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DAF620869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="cf/eoXQ4";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="fRPvz/mk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DAF620869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388659AbeKGBES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 20:04:18 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:58348 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387480AbeKGBES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 20:04:18 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wA6Fb4Sp022695;
        Tue, 6 Nov 2018 07:37:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=2/bUPwSjooFnytRRA1m9S79C5+o5q+L6RYdZXMrNHYg=;
 b=cf/eoXQ4h+Li5c4qVhb7qmXjmTXkoZyXB4oF2xy9y0in4l9n4Zuo1vYNRttr64szu0sc
 y3F/A03RmUPAVLyhr8IhH6/2CEyz0vClvmpSepyfxm9ILhRGuFShDflatKvsgeK2JTzO
 vjw2czQQZd3Ya03OaPURAomhGhxgC5ynUJ+J4mNIpuQwCWYM/T2SUke7aruLPwuAs3x7
 i+uczCHSgMkdIb6Ybd0rQLL647Vhsy98obzUsexOhaxznakMsX+yeMVaiheluWBOAt5k
 OypEroxC0WiOfHvsAJYB8/8S1CpsfKwTvc9DaY3h1j60LRH4GCFJpvxFe5MpEeSFvozz +w== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=dkos@cadence.com
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp0182.outbound.protection.outlook.com [216.32.180.182])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2nh87rx9s2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 06 Nov 2018 07:37:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/bUPwSjooFnytRRA1m9S79C5+o5q+L6RYdZXMrNHYg=;
 b=fRPvz/mkfxyCmglyiQUBPy3BKwbEeR8HjbTmgs+y7iR2pRvQ3aRP4b5ZRbjyOy5uZtrhMqJa8IIMDrEuAt03h5cOsOfbmWLv9ZRVb+opGU9/5hg/b2DPTGLEle2r/3kxsYHmyg9AcJEMmJFRMIu0BOfUJwZmdYzaXY48wcIy4Co=
Received: from BYAPR07CA0092.namprd07.prod.outlook.com (2603:10b6:a03:12b::33)
 by SN1PR07MB4112.namprd07.prod.outlook.com (2603:10b6:802:30::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.26; Tue, 6 Nov
 2018 15:37:56 +0000
Received: from DM3NAM05FT045.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::202) by BYAPR07CA0092.outlook.office365.com
 (2603:10b6:a03:12b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.25 via Frontend
 Transport; Tue, 6 Nov 2018 15:37:55 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 DM3NAM05FT045.mail.protection.outlook.com (10.152.98.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.3 via Frontend Transport; Tue, 6 Nov 2018 15:37:54 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id wA6Fbp2g002567
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 6 Nov 2018 07:37:53 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 6 Nov 2018 16:37:55 +0100
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 6 Nov 2018 16:37:54 +0100
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id wA6Fbos1026807;
        Tue, 6 Nov 2018 15:37:50 GMT
Received: (from dkos@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id wA6FblRJ026769;
        Tue, 6 Nov 2018 15:37:47 GMT
From:   Damian Kos <dkos@cadence.com>
To:     Chris Zhong <zyw@rock-chips.com>, Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Damian Kos <dkos@cadence.com>
Subject: [PATCH] drm/rockchip: fix for mailbox read size
Date:   Tue, 6 Nov 2018 15:37:05 +0000
Message-ID: <1541518625-25984-1-git-send-email-dkos@cadence.com>
X-Mailer: git-send-email 1.9.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(346002)(39860400002)(2980300002)(36092001)(189003)(199004)(426003)(50466002)(1857600001)(2201001)(14444005)(6306002)(186003)(6666004)(48376002)(4326008)(107886003)(356004)(476003)(2616005)(87636003)(8936002)(478600001)(486006)(50226002)(2906002)(5660300001)(126002)(336012)(8676002)(110136005)(47776003)(26005)(106466001)(316002)(16586007)(42186006)(36756003)(305945005)(966005)(26826003)(7636002)(105596002)(51416003)(86362001)(246002)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR07MB4112;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT045;1:ZTNTbqAnwcJa1Wl1YdWIYeCWj9DO7z+ZR1qlBX1lOuaw/6VMRY6vk2pbKVuNRQFNRo/dnquWY2EWmVzkz1LVBOWop2tcSPbERpf0H5nfPXN2SO10srmj8XicX7lSUjSv
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a28d773-aab6-4881-4fc5-08d643fdd25f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:SN1PR07MB4112;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB4112;3:afBYERWKaxDxI39oT/kW3hu1w4zkiELSMrq2P/30QTSBRxT8+S37H2PUWPIdZwmQlwuwCT1JIKTs4Q8mkU3mJeqUZeINVTlEVRypRM1LFMqMq2IimOeWzoV34e3j+v1cFZX4n9fFMK/Tvu+cHNwqgnV7KRC3EOu8cTZhUPnmY3ivsLCiip65VLeLT5xSGQJ+HuVu3CfMrYzwn/StCYkTTbfklsP4pMMGKKUfbmKOCVkyGMqGjII4C1WoWYPoCQB+C8WNngSQkRErKmfK+XSxXxDaKNiEe6DvDLwFUlUWmyZK/JxeuUklZipbU1OgoUD2cKrwMJ26iJ6u3enQeDB70YOHJ892PQi6JgNIEk3J/LY=;25:YUniVsdNYHuyMNsHam3CxCXWf9BJ07hGYC1z9NRt/guPtd0m//9fI0itT1NbYcFgD0gChy09XFt7Bxdj3pUpoTPJcf7C555oWe6rrjZsMhdkAsCWuSJwSgwHBXh/ldwLmHpSKmlEH5FFDRjSXPmF47h6KQnFDNTq5292c0hPXxcZC8HfV2oZ1nJPknG+S2bklMLV4++7yZoMlX+nIMYkfLOlATiVs6gKSj4nd2ssdeifDYT1Vb6GAScfHGLEL83DNyh7hn6g5MfUQiirOabcti4hUyDbDr8G9N2hLFxagu95e1QrQjxeO48znWuElFRyS3MUtuZ/Q0DwwPV62DYq4w==
X-MS-TrafficTypeDiagnostic: SN1PR07MB4112:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB4112;31:eyTkuojHgf68QEfyI5z3l7dm3w88DRgRvsLkHG/QZ8c+KCQq1onG3P2rO9MBjQeP8bY8UujkMx9vopeCCYiZAJRm2faTdOpTZUWcDbAjNVNAA41EZ5N8FgXyrb0q2on6QMSjkRVGHEVizSzJ4OqOK0Z28HQzK9lOQL2nhc2nVD0eDejw9WFjHHXJw0c+QYgMR/rRMvFNmTgy5Rj7joS51UkaICjObOfxcjiTQwBtstU=;20:UPTRssr/To5Gwnw+VCTVKelUMeAcQ8PFcfNSclDwKZKrNdSwo8vBknVUdV0p7hZFkV3myG1Hg2wLujtmDN9PNsrup9N6wRPlIC9snbOPh0Ykn21TcSKQ/RXdt+I2UYSNWK9XCwW/vhjvz/AyCD0lbNKaS56ZU7BpAgW+aSt7cMmBQCAhDqCC7TsQYfAvGGeiuFlRlhWv2F9NuMMzi71WM8JPDBUNEY/pSbiAW6qddfJ04+seJlEHJhAWbEjMneJ+a4Nrehz5A+DJYc9c/0gJA0Em2aG8fS1GLUHVKErruimoP7EfKql6Be1MQFlQXPO8+lWdXQcWPXheoXb9Iw+uLtFPMvCXeUC/ebRIEkchB9QR4Yd/svnp7sJKVY64mExH/eR1Bl1a9Fz11xtu9oVFOsdJ2RcJJ7Dwcgwvhv7zIkSxdRs58G3WqqZ4/uOQ1jfxK1FimNlMFpl27lmT395Wvot2Cpcj6LtXPtf0ky1JpQOJuKnHwBRzF7gs5oPNV5kv
X-Microsoft-Antispam-PRVS: <SN1PR07MB41127A7FBA956B896B9A51D3CDCB0@SN1PR07MB4112.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(10201501046)(93006095)(93003095)(3002001)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:SN1PR07MB4112;BCL:0;PCL:0;RULEID:;SRVR:SN1PR07MB4112;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB4112;4:lYHExb0+VHshXgJK3wAfB1S0PYTNUx7T1ine47yh14sOPBbVM/8DWYhXtpDNwa8J2ByYRyD87EFbb81iYt7Vqiz5rCk2Nog3qj5dpfctSD8IcfIfQ51i5MqDknwO18f48W6DUHqXExs/iXxnfaFSAqowQ9T0qMunEkBHtYf4aoNVpZMp+RDhDLrTj2ourSxfANJ54foZcrncDheyxVf4v/yxqiF5cocr9VAv3ce2ACrrAA8yWNWoWSHdHGBTkaKGhlqzwI7gsx9PLrTOy5GMnXVigPhNwQCSbXkAaU3hJ3TzQnO/sXzqRLBx7c5RLAzD
X-Forefront-PRVS: 0848C1A6AA
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR07MB4112;23:myu6/8wnAfOR7xjbs5/ktrQX44Hb4ITFI2sHqkg4v?=
 =?us-ascii?Q?aAFnnqr9RhK/pTCYE5WgU/jmB6QbwIqCS03aEOEVRTDKabCw/X4hUqWyuIa+?=
 =?us-ascii?Q?o5VR8dXvPLXOikXTvHuiX8HcFsfyvy04/Xgk5GiRNuUnlrvQirSl4oI8rndc?=
 =?us-ascii?Q?zOsexYCEEM39KUeGNG79ZzNAoHtGbCdCxj4JI+M7LXP72YJKQ7My/uEIydHB?=
 =?us-ascii?Q?CIkrWDf0rfDcRWtv6rFPxP9DZVv5nGiyEf4fBpKZFUvDBI9op12r/djr18BB?=
 =?us-ascii?Q?aQR1HAArOT5eG4KVqGQav8ugbbqRqFcuM/MtVudgXlY7nyHqKa7RjkC1rzfT?=
 =?us-ascii?Q?atFccWdRq1l6p5zk6sRnmXD6H0AdVrx8g80N36257YRaQBU53fdB9cCBQ843?=
 =?us-ascii?Q?Sd2fyi0zSuptU9uhvC+wvXkPM9nJ2jkR1C33egXqQrFwwTo5SE6vDI8r5yPT?=
 =?us-ascii?Q?hjF9AAKRky3zsjQ6+t/mbr3t6dMznzwkNDkCFCCUaISXFIcp374s8oQM+ZeY?=
 =?us-ascii?Q?6eAxKj4FyKXowdp2Uh4loJHXdUt5Os3+GglvTd/W5FdOKtzYubP5nt8FfoMc?=
 =?us-ascii?Q?H1cIlA3rs2Hllv9JiXPbVyJ5dMDPGfx4dWrHaMZDdXtsAaro6G2wost783wx?=
 =?us-ascii?Q?Y+5mLNwvLMPF0FS8RWH/97pmvvz8HCoOh3gad7YeH6lKpGBTijxGjXd8c+Fw?=
 =?us-ascii?Q?O49VBFgQNJ0aFhjgYXSQ5CCi71tYxlvFBWi+qjYooo4mTYpfZ0wPB8yaWV80?=
 =?us-ascii?Q?Fk4wX5wJgYcdhecBHqeAi2ADWyVwY7/VWRGBFr6ok9VAQv8dnkT1Hjgmewad?=
 =?us-ascii?Q?Yz3pu0pPA1OUuWxKK6gQnL0yg2OeQYwoyaHxXIZRp+00AooUTPk77vuWMEaQ?=
 =?us-ascii?Q?efPS0aYE6tdzzP0ylnSG4w10fp4FTCywplvOLiv6Ucc8km6DXUOy+Teim4ch?=
 =?us-ascii?Q?v8NgXRJy/25VeurTYiPJPr5L2Xp4z6pfb5uE++bIR8eJqRVWXiLgYYxMGXSc?=
 =?us-ascii?Q?GwvbVBEG4kMfIY0pDfvNfoVUcwzg2VS0nnFKSNqmZ8cCIK81IUj+Dil0/GPG?=
 =?us-ascii?Q?oRdCPp76L1Zgp8rfEqIgOdaKBnagJnIlkJPPvinoARRdvOMisqij0NhSxvVj?=
 =?us-ascii?Q?XTabBMuGow=3D?=
X-Microsoft-Antispam-Message-Info: x2vCtEFf61uroaIJEeKfGE0mZAgPD1sPCPXem96eU62Rmqj25gKkTg/OT9qoACiRvPKfdAtEDiX5zPomej+IDsNEs79JN4DysJ84mLU0V3j+fP+gkOV7lamGwTcjuv/SsXnPiOSru5d1Dl02OiBi+pkFVhjR0b36MWjdmRkwj/lDBuOIORMhqQq/+zoVU1sj+KZXYdGL9hPvhoySki4P18VT34iSam7CRVhdG63KKEzBhcGzUovEiwHV7y1w1XKocgPJ/NqCKYrJMYNZYFPWmUdp9QqYy+X7K8F9SklcWMWB7KSe6m0noNWkqinnEsq+oN62iUda8nksAdTn4aJypDZDVoOMk+OFjkx5ltSKUR4=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB4112;6:ljK2AxEa+lh5uNtVW+OSkVYD6QsuWMyohV+4TdSuRa5xuTk5xGQqsQuGFOuOfoZMaus/5hQ5gCrbS1zzhNqX9WUEofhkn784Q8z2btFpjWltMnkPdnSEg694y7Y3YOI01K9OyQOsAZQLbmBiHEBNVdFd8tmbz7xr2A1WC/3Dnthn0FHlaJruZUvZ7VKptXI6D9eqebHLdkTKWTEQ4uHTsULVBze7gAEHqA6rz/Xdjt0Vl+PFDwzCj3KzJ0U9TALb9sP6UdJ7o6eWhVBUF3Iv2XdIxlr9PrPlZmOvU7+JD1aivfDxKa/Pn11dav+pUXCZqSEj3pVgfSEJY7g4nQisOaG2uEdSgpIa61eDDTEesRqtiV6pVrUrOSVKGOTagLHX6T7GOfOC/Edq5JoaYvm36Gb8z0zAh5ucrvYER7urNM3Fg5P/8XQ+HdeD/viLmy3Dnl6R8fZvDj6CDv4SLQsLkQ==;5:W1ci2ZD578TmUYYPDyeJrMsU6P2plZB5N6bZa4T9/SBPMIH5ByZGnlFG3kYcI9c83M4nFHgsY7LCIK+C+vqH+O+SNT8D1BAZzWLkqaB8ZZIzT7Sz04ys+yEZuOHKAS5VD82csfoexz8nSC1HM4y5tM1OjXK6MRqgBp2Ltr+RlhA=;7:yWlq0FSV56vKDuhjuSQn+gUyCxsbDOCOqo1q4MHyLON42/YZ8Rtxu1HpojMieOLh6a2Uf2rhEyQU/PLjcJCto/oYlzd0aDUzi4Ws3xthucwrSQRiYhMg6ltQbo59ENoA1Uh86u7IvHmI1HWeL0IwPg==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB4112;20:MTOQfNw6AfWdulTIYMGDyWAWNq2sSQs/XK7jiOv2nM55SL8nBVB7zIO3xNNzAoa8f6ek3eLRT6ergk7ITeQqSfBM87NjJRJ9Sdh4e2g3KrZrOYKAuoOS7ByVLlp2ShWm6viP4o9CIsPbK5TGhFQQel1buFdDarU8p0PpgZ/SaSKozuRQYWcs8Eh9XEF3vuxO44kZwXr/N01oLPViq4wm1xTLL4rwijyEqA0fo92LLxqa4uR5usG+w3xJOur2J2oP
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2018 15:37:54.9752
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a28d773-aab6-4881-4fc5-08d643fdd25f
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR07MB4112
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-06_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811060136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the functions (like cdn_dp_dpcd_read, cdn_dp_get_edid_block)
allow to read 64KiB, but the cdn_dp_mailbox_read_receive, that is
used by them, can read only up to 255 bytes at once. Normally, it's
not a big issue as DPCD or EDID reads won't (hopefully) exceed that
value.
The real issue here is the revocation list read during the HDCP
authentication process. (problematic use case:
https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-4.4/drivers/gpu/drm/rockchip/cdn-dp-reg.c#1152)
The list can reach 127*5+4 bytes (num devs * 5 bytes per ID/Bksv +
4 bytes of an additional info).
In other words - CTSes with HDCP Repeater won't pass without this
fix. Oh, and the driver will most likely stop working (best case
scenario).

Signed-off-by: Damian Kos <dkos@cadence.com>
---
 drivers/gpu/drm/rockchip/cdn-dp-reg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/cdn-dp-reg.c b/drivers/gpu/drm/rockchip/cdn-dp-reg.c
index 3105965fc260..5a485489a1e2 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-reg.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-reg.c
@@ -147,7 +147,7 @@ static int cdn_dp_mailbox_validate_receive(struct cdn_dp_device *dp,
 }
 
 static int cdn_dp_mailbox_read_receive(struct cdn_dp_device *dp,
-				       u8 *buff, u8 buff_size)
+				       u8 *buff, u16 buff_size)
 {
 	u32 i;
 	int ret;
-- 
2.17.1

