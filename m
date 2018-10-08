Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70415C677E4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 21:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CB21204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 21:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="PXY9w105";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="DJ6W3Spl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CB21204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbeJIE7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 00:59:07 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:40502 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725794AbeJIE7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 00:59:06 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w98LgBG1007395;
        Mon, 8 Oct 2018 14:44:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=rCa4aD1FQtqZJUDQQ+3e/20hsSUH/TQtRJW6J2td36U=;
 b=PXY9w105hc3CSF+00UfH+VwsnywqfQI7AF1VsVcOvPd8RWejfwvGnuxbAT1/gWLynpJ0
 pncqN7zjcWKM5h4mSh87Cu0yFAOACrG5vSMIUaj+TdDU5bv6giVptM6l92W/MRJuFxfu
 jwrdof7Ev8BLLAhETsXKO2ofOqtTAdoInrekGzS1gRfKumbsXJt4GmPgZLf0jOsev9Wg
 pqJo4AutqffspYvoENSVUIEgvzTzj+AfJB7TBUwaMoId3g9fH1i2gYJGvnHvlpyceoFD
 Gm/8Ie9/3caRr5Ir+Taj3btGTvCX4ohAX0ytTiSJ8r+YIOF5KcNbLd+ol+GxgfrgbSwM gQ== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=dkos@cadence.com
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp0022.outbound.protection.outlook.com [216.32.181.22])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2mxuwwt04j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 08 Oct 2018 14:44:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rCa4aD1FQtqZJUDQQ+3e/20hsSUH/TQtRJW6J2td36U=;
 b=DJ6W3Spl5zvojY3cQanlaCOnqgx7sqlUcXYCWgjkVJ8vONEcWQ8JlwD4SWB+SuX7EeakEtkXVR5dTFTyLP9M9dqgJqQGinIsT1KGidfsjfNfN82QrBE5vQmMyEvrmSRsXk7XVyYHXJqArGCbneVCFhrbaORTj9OhjHB2ZbTgBkE=
Received: from CY1PR07CA0033.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::43) by CY1PR07MB2167.namprd07.prod.outlook.com
 (2a01:111:e400:59d7::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1207.26; Mon, 8 Oct
 2018 21:44:12 +0000
Received: from DM3NAM05FT029.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::209) by CY1PR07CA0033.outlook.office365.com
 (2a01:111:e400:c60a::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1207.21 via Frontend
 Transport; Mon, 8 Oct 2018 21:44:12 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM3NAM05FT029.mail.protection.outlook.com (10.152.98.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.2 via Frontend Transport; Mon, 8 Oct 2018 21:44:11 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w98Li8If017391
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Mon, 8 Oct 2018 14:44:10 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 8 Oct 2018 23:44:14 +0200
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Mon, 8 Oct 2018 23:44:14 +0200
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id w98Li7PT014714;
        Mon, 8 Oct 2018 22:44:07 +0100
Received: (from dkos@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id w98Li7Lt014713;
        Mon, 8 Oct 2018 22:44:07 +0100
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
        "Piotr Sroka" <piotrs@cadence.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>
CC:     <rafalc@cadence.com>, <quentin.schulz@bootlin.com>,
        <jbergsagel@ti.com>
Subject: [PATCH v6 5/6] drm/bridge: add support for MST in mhdp8546 driver
Date:   Mon, 8 Oct 2018 22:42:11 +0100
Message-ID: <1539034953-11274-6-git-send-email-dkos@cadence.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1539034953-11274-1-git-send-email-dkos@cadence.com>
References: <1539034953-11274-1-git-send-email-dkos@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(136003)(396003)(2980300002)(36092001)(199004)(189003)(8936002)(50466002)(14444005)(5024004)(54906003)(110136005)(356003)(42186006)(16586007)(36756003)(4326008)(8676002)(53946003)(7636002)(246002)(48376002)(16200700003)(316002)(106466001)(105596002)(305945005)(5660300001)(446003)(26005)(2201001)(86362001)(575784001)(47776003)(186003)(426003)(51416003)(2906002)(76176011)(486006)(87636003)(26826003)(336012)(478600001)(11346002)(7416002)(476003)(50226002)(2616005)(126002)(4744004)(6666003)(921003)(2101003)(83996005)(1121003)(559001)(569006);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR07MB2167;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT029;1:ozYx1NcN0rScH3tl4vk9GCEN9R2QKlSxKE+i8dIImyt0WFTOCYnUywM5mB3z46OpD6uJI7cvr3H/xSjK0Tm1wJ3AgIiO7q+5uEwU/m5+X49Pi86FklYdiDO+dhc/ZovC
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f55929a-9059-40fd-3782-08d62d672f82
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060);SRVR:CY1PR07MB2167;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2167;3:Umgb1ajDQ8fqHZyP95QCCEz6zELW8eqq3tjysVWnp7CtgUaPYxPCVhgu+JZ0z0Bg+T2kTXsFgBHwvTEN75sg/px7xkqC3hIOkjJjh4TVIu+yNAVXyX+bR9nHVz8UDvu1/5hP+icrK2QhfLEYvLpTmajBMTKOUvS5kAHryAh1VRYbP3kyiqNQsmkHjxMl54IcsoLLKWNrFmXc3KN6+IEbIxrOJ/E4vLjYvArnOjRn1vERi+qre+0DAWfTNARWLwbINFlG7y15PMB2fbNkD6p6An99/3ZK2PrZTbaVcPw5ejCszE8eWPnrQdgc6k4VO3E1qYVPEydGDNoqwwEbeEG1+RX8YbgfPM4acKOstHjtdIM=;25:fT4ZpYcxW3DaaW2q8mjdaYEG3oORqep0P+SiYmaDHEIP0lGuSKv1/TS3J4XpI/6QDIjj0+vvKSjkdHCVW/i/6MDGSad+5swcjvGk+UYoNthT+wixt1v8cgauicyt0+A92/YvjLlSR4tSfocFoN6L8nZyUmL03L3jp5HVAFi/trQBtKIvmN9+vxq9wytptungueFotd1eLSbTnWJPOcfEZU+02Ho0L25l7G4S6EwitEQq6dPTc2pl+5g2OyKCTDEolwqgmfUV+M705s6MKWWrVPyP3zhRaceN1cXuXsE7nVvhBUoVHDbfBBVGFO3V3b8bvKaeT3ju2ID4JAMZwiw+bQ==
X-MS-TrafficTypeDiagnostic: CY1PR07MB2167:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2167;31:B39gF+tG8deafsIYMP4U+mmXQ3m+6WRrDaKEQP4xwoEZR1lwSD3ezGg9eYfpR6s831zZro+4439Y/Rzt+H0HaaKSTl6HhxEU6dSxeSmKxOZ0FwWAGKxqaofXpbmzm7hMEd3uWCuG5i95qmOooP+bQJuYeuGIKym7wiSY40+admfhFvrHAUZlcpjkmRsCWKNZmXW9IO2wF1uc3IZ3QjNOpu/xPkSd2eR0dFNDREtokgk=;20:9ZLQJDKh4Hym0Yz27eNokkvTYYNsfG8Y9aKkGBYpod1SHPEyTX8v3zFza5pq2zLknLLMxavhwcB4Q1rxAW5jY4xkxE+q5lP0JW+oDg+gBN8dNxY94R2NAIxIhnqd1n6MONcsJMJ68ZcUOvq+8a0jXFZ9rJtzreH54tE0JbdG1t0/G0zCGgWnLTZllrI+HpYgmstePwip4L9IY8VyZSEidLkRANYGkz7bHrAj7Af/6ATTj92LXgn3mToeWS6JCglBD7UwnCtiTBPtkQooAmhNmkrFMeHOqG+373e3NJhcrln7Ew6Z4/7JOhhw9zh0Vykl9bxpUkY8Ue1dpRbLaZpMSmhYXYNLTDBaehrZ0BdWQ3iT14sVL/IpQhYpSK4ciEEfBcDQOXheHeGrB5MoR6umWEId9WJZrMkAbvHV0x+Y9FyfUq5Cwj+xIE01nJTDwFWgr9asf1vUhhyEbG3ibti77KwQV9fKBgCvIrGd0+DCTMQ899psdkscMhBVt5EyrsGt
X-Microsoft-Antispam-PRVS: <CY1PR07MB2167739F9C8E5A32044F963BCDE60@CY1PR07MB2167.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110)(58145275503218);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93003095)(10201501046)(3002001)(3231355)(944501410)(52105095)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051);SRVR:CY1PR07MB2167;BCL:0;PCL:0;RULEID:;SRVR:CY1PR07MB2167;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2167;4:b53pBixbCeFhmKhuvuO6/AIN4yZXBOc8h99DeGH6VL3Y6GkVI0RLcTEGrQ+W74y9qRyi6A8bIs/s/AQMSQTuGdRAl2y/r7j2ZQP01b+t1IHEnc7HigdJMSxgAblbHF+Rw80cxAFIKgTWnsz7PIe73FutsGQ+YETKf842VlnAqEhEDbb/kKu61L2ChdUgI15kqYfg3WVRN90ElIgwtASX+jzaKQgHpFppZRTdACr4zr8V4Opl+Zu3WlQwmhRVHFrMqXrA05zVwBv2461IfWXyahGUdIqg+mQd13NdevtfhDuE54RjoggKoPFcqW2uNMyISSlrFyg1imfmk2UzJZLvztbO76YJ4zfsBDnZGd2/314=
X-Forefront-PRVS: 081904387B
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR07MB2167;23:fgzM0+YhdfELY4AdiJOS/Dw2j8pE9YRQxQ1nmtSOz?=
 =?us-ascii?Q?FroFAHKLymG/z6UFGxflLpYu6ZcmRjT3AUFBggK8MSDFCK86ZUuSmNHnJg1a?=
 =?us-ascii?Q?n3E3EimBxbyDtOLo01ZFz4o4xjOmIqrQeIl22EIXeZGOSoZbhDMWGUzsA4tj?=
 =?us-ascii?Q?iG7lKwMoKmeuotuExl1EHcnhFEKDR2+xbG3uGvmz0w7pD94nuFNrDJaQkenf?=
 =?us-ascii?Q?DPzGi5FqlrOs3kZLeejLabl7+i69ZgJcS6T/CmEWxDv7GVlciM2hnhik+MFr?=
 =?us-ascii?Q?ZB+SeLCD91BlbKZ5O1R6S/fkfLJWiCSWMwlad6Da6ydaJCQW1qqW3ANpl7F8?=
 =?us-ascii?Q?eLJnLFt46jUNo7eDJ/pY0jz2uOx4FarIdKJLmqYhc5an4dhqW2bJbY1UHszG?=
 =?us-ascii?Q?wl1MO44Mz5wja/TFTW3JshkP/azgA8KPlmdWJZ7Dv9tgW7I5syDwhaC0l55Q?=
 =?us-ascii?Q?QKwB0nz6Lo8rsJc1N/lmfswo0efORS39RPqWpuqx2DooRho1vqU2UwpOKdA5?=
 =?us-ascii?Q?OpxIUm6KM6zqZ9qUovqBC4DhZvWEOpLHllh2nN9zycMrbF6MMG8izl656v+e?=
 =?us-ascii?Q?u6kU3K9JOFMmVGkFsTrAiBrjxA3xAYgSLO1pWqSQbhFrY1bSTD3WRBBOTpDG?=
 =?us-ascii?Q?XuHpKy7DROxVeNlieNNvdVqDRw0fw6Ga8Nbn1O5Mcm6gBWX4mF6bGPYDXb7u?=
 =?us-ascii?Q?c485E43VjvTCrzcZqq7NzyCuoHLIuV1c50UFz1E/WJInNlt9v6gt4nupfZ2Z?=
 =?us-ascii?Q?Y94LlsJiUeAzVhLXTP5SHVka9XAoORJNEC7XSdckk1yrfZRP7xNm25itX+uU?=
 =?us-ascii?Q?BJQgZWeHnQ0U48NKE+ZpYDqAZ1JW1628Zud6qOV72wz/2ZKv0Zpm32D3eup+?=
 =?us-ascii?Q?pkKGZOoriM2dOgt5GG4sSFSJkIO8hfYE9dF9Ca3/mtoJc4nbyaHC3Kw92gND?=
 =?us-ascii?Q?TgXHWwYT4wPhUOvwYgFyldraBx8oEJtu0mOOSUmqON4KyaN5nVOxz+YriveH?=
 =?us-ascii?Q?ukbdH3xLv7nY3ZV8HOpEdYEDHkb81tQEMRHpPrlVgL9rxW4j5VRRJi70wfkf?=
 =?us-ascii?Q?zfG5VLutArvnZc1Y8waxAwQMsXtU0v2MOPMD18T+RnCHXpv5F4AijT+U+X4i?=
 =?us-ascii?Q?kkbz18kgoBXNVefovqmS0hDLQm3Ac29c/istPN5vGgoqzB/kYljuOo3X0aYe?=
 =?us-ascii?Q?b/66QX78qzzotVh6nBIVGX2/8B5opdHrGnqXoWckRZ4yL85doyjaT4+DTPpw?=
 =?us-ascii?Q?kObNjJthbbCeTtLzzN4kIqMR92VDZRKuNFPjQtV1FNmxV+4nxusVwVMfRrqU?=
 =?us-ascii?Q?fYXW1iQMGmD0DcYb3NtbYw8necas9p3UTIRqQo4xXhz?=
X-Microsoft-Antispam-Message-Info: pr9vIiWU+7y79TvWrlIbpyDAJtB7vX+nZ6hR60naAGeLfaluGzfCqwOyPEBL/vPF/23cAMa8RBi9GWNX0mi6yl9JwZwjDiNkCb3+fYyXOTtMe/0FxIFzZJCxq73m0exu95odrHUQv4ZQ2DfMDTJZFDbyAfK8V4DMFHtHxxVgU7VFrBtAnlgHypnV8LNtcalf6plv9HQR2/nVp3Uoik/hsqw2ptvRaRUnMuTZju5OfaAJz8QOE0DRDgM0YTpPhT1ET30ZWM4G+SWpLbjeId9Lx0nwqT6eU7ueuiVudwEnTV0tk31q9EhMJSmPDv/m1ssBtUC9GpUA/4MggDXHyvKUSziGVHfzEmSkV8Riyeh1LN4+ndWFue9wryy2p4WHb4BLq5qUjDqzU2P/IyfRuIeQ7w==
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2167;6:1NvTYWaomXJ1xeVf8U/SXLdT2yilLPuXOBpIyCQrA3KuNSDbhVmJTp5YO7MqQgqXNziTVVpF2C7AFBqqQKm9/Rl4jjh6t38RfVhQ/6zTw+cEfmJlOIJSNqGWMqzUZinN1X8UhiaGWN5+5OEsor7T39DJed8xiA25ijj5PrQDkG4suaZVQTjnsGtBIoob4i6NuVP3LEbnozY+5S8Cp/Plt2/GH9gn7TslfWYaRrKBMlSAj7PyhgdmxBCzabguiVQ3j2HGQXTA0oVlCdtqPlKpE6UetTMfWg8si4ly7ihS1SdX7Ry64bhayIeY+2/XIrkOg6ae8ePcbr4wFAks80rHcC6U/+GgXxmHuhrtIVyfwvs2oe/C1e6+YXxxswiQ+00wY/Z5MFhEgeDWUGH+NARkZQ22JzUrJjDGJ7KQmOFkscMYyW1Z5vXh6NXHQfVAW6NhOv2X3dHUMiTXrSHJunisuQ==;5:GRX2n1Nw6fLN6hChvOWY0o+frJ5mgPXliOYFHf3uPdfcbzvAJDusQb+EjCiSEDb96xGEsE2ZpCLQFFX61pXhkK4dGb3B/Vbv1G7WpENSm3sKm7/zN6apBRuhRap2Jy6KgZHZ/WCYEGDS6OYM6XOLvgDSsKNkyJkrttYb1RsdJlI=;7:Fn8lCbeTvDiTq/8M5LPaBzuJisAL5AoJQCLETbubSLrwnStJAwk3nooAoiHroGJ4yBYyxvhq4blMDhwJ8eCoVRPJOJi3+wqPx18pHcJF1LTpwgsNELO31UjOsxtOkKxWZ7oH5ALEFp0lE3qJgF9daJYiOOa/az9D2mYur6ddyNq7XfRRJuASnoTLSloVirDzhGQilMpWyvPUIVq/OzReAnuiu7DZyovwjyaU/n4k+2huBalm4IhOo/PFj0rxRhkn
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2167;20:CwQHZgBwJofsAb79XG7IjzoStc8ni3MGGyI0XU74sdlglwDm1hTOOrsqV6Gnw/cEyVwQMvTJm+HgTW1MRYEPj72pTeqYTJTvrxpOv86zM0tzr12FnxAb+YOq18fKuwPdjlVs7m7VGsCLiZV0eqgl9tWUXT3+v59M8fA0vdt8rGwthNLaLcwYYQ7UaxRuicRvSh6gTyn/llTUxmYnxSY1ddrspcYyk6m2RxyIFg0mRP/Mi1LJwTmdmxRnaPG5f4A6
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2018 21:44:11.3166
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f55929a-9059-40fd-3782-08d62d672f82
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR07MB2167
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-08_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810080203
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Piotr Sroka <piotrs@cadence.com>

- add hot plug support to handle HDP IRQ interrupts in case sideband
  message is ready to read.
- there is only one connector created at initialization stage. It is
  used as SST connector when controller works in SST mode. If controller
  works in MST mode then the SST connector status is disconnected all the
  time. MST connectors are created/destroyed in runtime depends on what
  devices are connected to the DP controller.
- add callbacks functions to be able to inform module managing encoders
  objects to create or destroy an encoder in case new a MST connector is
  created/destroyed

Signed-off-by: Piotr Sroka <piotrs@cadence.com>
Signed-off-by: Damian Kos <dkos@cadence.com>
---
 drivers/gpu/drm/bridge/Makefile        |   2 +-
 drivers/gpu/drm/bridge/cdns-mhdp-mst.c | 594 +++++++++++++++++++++++++
 drivers/gpu/drm/bridge/cdns-mhdp.c     | 560 ++++++++++++-----------
 drivers/gpu/drm/bridge/cdns-mhdp.h     | 209 +++++++++
 drivers/gpu/drm/rockchip/cdn-dp-core.c |  18 +-
 include/drm/bridge/cdns-mhdp-cbs.h     |  27 ++
 include/drm/bridge/cdns-mhdp-common.h  |  48 +-
 7 files changed, 1189 insertions(+), 269 deletions(-)
 create mode 100644 drivers/gpu/drm/bridge/cdns-mhdp-mst.c
 create mode 100644 drivers/gpu/drm/bridge/cdns-mhdp.h
 create mode 100644 include/drm/bridge/cdns-mhdp-cbs.h

diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
index e802fdb85750..b80f3d6ed2a6 100644
--- a/drivers/gpu/drm/bridge/Makefile
+++ b/drivers/gpu/drm/bridge/Makefile
@@ -19,4 +19,4 @@ obj-$(CONFIG_DRM_TI_TFP410) += ti-tfp410.o
 obj-$(CONFIG_DRM_CDNS_MHDP) += mhdp8546.o
 obj-y += synopsys/
 
-mhdp8546-objs := cdns-mhdp-common.o cdns-mhdp.o
+mhdp8546-objs := cdns-mhdp-common.o cdns-mhdp.o cdns-mhdp-mst.o
diff --git a/drivers/gpu/drm/bridge/cdns-mhdp-mst.c b/drivers/gpu/drm/bridge/cdns-mhdp-mst.c
new file mode 100644
index 000000000000..782d4bf9b667
--- /dev/null
+++ b/drivers/gpu/drm/bridge/cdns-mhdp-mst.c
@@ -0,0 +1,594 @@
+// SPDX-License-Identifier: GPL v2
+/*
+ * Cadence MHDP DP MST bridge driver.
+ *
+ * Copyright: 2018 Cadence Design Systems, Inc.
+ *
+ * Author: Piotr Sroka <piotrs@cadence.com>
+ */
+#include <drm/drm_print.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_fixed.h>
+#include <drm/drm_connector.h>
+#include <linux/iopoll.h>
+
+#include <drm/bridge/cdns-mhdp-common.h>
+#include "cdns-mhdp.h"
+
+
+static void cdns_mhdp_mst_stream_enable(struct cdns_mhdp_bridge *mhdp_bridge,
+					bool enable)
+{
+	u32 reg;
+	struct cdns_mhdp_device *mhdp = mhdp_bridge->mhdp;
+	u8 stream_id = mhdp_bridge->stream_id;
+
+	cdns_mhdp_reg_read(mhdp, CDNS_DP_MST_STREAM_CONFIG(stream_id), &reg);
+
+	if (enable) {
+		reg |= CDNS_DP_MST_STRM_CFG_STREAM_EN;
+		reg &= ~CDNS_DP_MST_STRM_CFG_NO_VIDEO;
+	} else {
+		reg &= ~CDNS_DP_MST_STRM_CFG_STREAM_EN;
+		reg |= CDNS_DP_MST_STRM_CFG_NO_VIDEO;
+	}
+
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_MST_STREAM_CONFIG(stream_id), reg);
+}
+
+static inline s64 calc_fixed_avg_slots(u32 pbn, u32 pbn_div)
+{
+	s64 fixed_pbn, fixed_pbn_div, fixed_targ_avg_slots;
+
+	fixed_pbn = drm_int2fixp(pbn);
+	fixed_pbn_div = drm_int2fixp(pbn_div);
+	fixed_targ_avg_slots = drm_fixp_div(fixed_pbn, fixed_pbn_div);
+
+	return fixed_targ_avg_slots;
+}
+
+static void cdns_mhdp_mst_set_threshold(struct cdns_mhdp_bridge *bridge)
+{
+	u32 threshold;
+	u8 stream_id = bridge->stream_id;
+	struct cdns_mhdp_device *mhdp = bridge->mhdp;
+	s64 fixed_targ_avg_slots, fixed_thresh, fixed_targ_entries;
+
+	fixed_targ_avg_slots = calc_fixed_avg_slots(bridge->pbn,
+						    mhdp->mst_mgr.pbn_div);
+
+	fixed_targ_entries = drm_fixp_div(fixed_targ_avg_slots,
+					  drm_int2fixp(2));
+	fixed_thresh = drm_fixp_mul(fixed_targ_entries, fixed_targ_entries);
+	fixed_thresh = drm_fixp_div(fixed_thresh, drm_int2fixp(32));
+	fixed_thresh = fixed_targ_entries - fixed_thresh;
+	fixed_thresh = drm_fixp_mul(fixed_thresh,
+				    drm_int2fixp(mhdp->link.num_lanes));
+	fixed_thresh = drm_fixp_div(fixed_thresh, drm_int2fixp(4));
+
+	threshold = drm_fixp2int_ceil(fixed_thresh);
+	if (threshold < 2)
+		threshold = 2;
+
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_LINE_THRESH(stream_id),
+			    CDNS_DP_ACTIVE_LINE_THRESH(threshold));
+}
+
+static void cdns_mhdp_set_rate_governing(struct cdns_mhdp_bridge *bridge,
+					 bool enable)
+{
+	struct cdns_mhdp_device *mhdp = bridge->mhdp;
+	u8 stream_id = bridge->stream_id;
+
+	if (enable) {
+		s64 fixed_targ_avg_slots, fixed_y;
+		u32 x, y;
+
+		fixed_targ_avg_slots =
+			calc_fixed_avg_slots(bridge->pbn,
+					     mhdp->mst_mgr.pbn_div);
+
+		x = drm_fixp2int(fixed_targ_avg_slots);
+
+		fixed_y = (fixed_targ_avg_slots - drm_int2fixp(x));
+		fixed_y = drm_fixp_mul(fixed_y, drm_int2fixp(16));
+		y = drm_fixp2int_ceil(fixed_y);
+
+		cdns_mhdp_reg_write(mhdp, CDNS_DP_RATE_GOVERNING(stream_id),
+				    CDNS_DP_RG_TARG_AV_SLOTS_Y(y) |
+				    CDNS_DP_RG_TARG_AV_SLOTS_X(x) |
+				    CDNS_DP_RG_ENABLE);
+	} else
+		cdns_mhdp_reg_write(mhdp, CDNS_DP_RATE_GOVERNING(stream_id), 0);
+}
+
+
+static struct drm_dp_payload *
+cdns_mhdp_get_payload(struct cdns_mhdp_bridge *bridge)
+{
+	int vcpi = bridge->connector->port->vcpi.vcpi, i;
+	struct cdns_mhdp_device *mhdp = bridge->mhdp;
+
+	for (i = 0; i < mhdp->mst_mgr.max_payloads; i++) {
+		struct drm_dp_payload *payload = &mhdp->mst_mgr.payloads[i];
+
+		if (payload->vcpi == vcpi)
+			return payload;
+	}
+
+	return NULL;
+}
+
+
+static int
+cdns_mhdp_set_act_enable(struct cdns_mhdp_device *mhdp)
+{
+	u32 reg;
+	int ret;
+
+	cdns_mhdp_reg_read(mhdp, CDNS_DP_MTPH_CONTROL, &reg);
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_MTPH_CONTROL,
+			    reg | CDNS_DP_MTPH_ACT_EN);
+
+	ret = readl_poll_timeout(mhdp->regs + CDNS_DP_MTPH_STATUS, reg,
+				 ((reg & CDNS_DP_MTPH_ACT_STATUS) == 0), 0,
+				 30);
+	if (ret) {
+		dev_err(mhdp->dev,
+			"ACT sequence cannot complete in 30us\n");
+		return -EIO;
+	}
+
+	return drm_dp_check_act_status(&mhdp->mst_mgr);
+}
+
+
+static int
+cdns_mhdp_apply_slot_allocation(struct cdns_mhdp_bridge *mhdp_bridge)
+{
+	struct drm_dp_payload *payload;
+	struct cdns_mhdp_device *mhdp = mhdp_bridge->mhdp;
+	u8 stream_id = mhdp_bridge->stream_id;
+
+	payload = cdns_mhdp_get_payload(mhdp_bridge);
+
+	if (!payload) {
+		DRM_ERROR("payload is not found\n");
+		return -EIO;
+	}
+
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_MST_SLOT_ALLOCATE(stream_id),
+			    CDNS_DP_S_ALLOC_START_SLOT(payload->start_slot) |
+			    CDNS_DP_S_ALLOC_END_SLOT(payload->start_slot
+						     + payload->num_slots - 1));
+
+	return 0;
+}
+
+static void
+cdns_mhdp_update_slot_allocation(struct cdns_mhdp_bridge *mhdp_bridge)
+{
+	struct drm_device *dev = mhdp_bridge->base.dev;
+	struct drm_connector *connector;
+
+	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
+		struct cdns_mhdp_connector *mhdp_connector;
+
+		mhdp_connector = to_mhdp_connector(connector);
+		if (!connector->encoder)
+			continue;
+		if (!mhdp_connector->is_mst_connector)
+			continue;
+
+		if (mhdp_connector->bridge->stream_id != -1)
+			cdns_mhdp_apply_slot_allocation(mhdp_connector->bridge);
+	}
+}
+
+static enum drm_connector_status
+cdns_dp_mst_detect(struct drm_connector *connector, bool force)
+{
+	enum drm_connector_status stat;
+	struct cdns_mhdp_connector *mhdp_connector;
+	struct cdns_mhdp_device *mhdp;
+
+	mhdp_connector = to_mhdp_connector(connector);
+	mhdp =  mhdp_connector->bridge->mhdp;
+
+	stat = drm_dp_mst_detect_port(connector, &mhdp->mst_mgr,
+				      mhdp_connector->port);
+	return stat;
+}
+
+static void
+cdns_dp_mst_connector_destroy(struct drm_connector *connector)
+{
+	struct cdns_mhdp_connector *mhdp_connector;
+	struct cdns_mhdp_bridge *mhdp_bridge;
+
+	mhdp_connector = to_mhdp_connector(connector);
+	mhdp_bridge = mhdp_connector->bridge;
+
+	drm_connector_cleanup(&mhdp_connector->base);
+	drm_bridge_remove(&mhdp_bridge->base);
+	kfree(mhdp_connector);
+	kfree(mhdp_bridge);
+}
+
+static const struct drm_connector_funcs cdns_mhdp_mst_connector_funcs = {
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+	.reset = drm_atomic_helper_connector_reset,
+	.dpms = drm_helper_connector_dpms,
+	.detect = cdns_dp_mst_detect,
+	.fill_modes = drm_helper_probe_single_connector_modes,
+	.destroy = cdns_dp_mst_connector_destroy,
+};
+
+
+static int cdns_mhdp_mst_get_ddc_modes(struct drm_connector *connector)
+{
+	struct cdns_mhdp_connector *mhdp_connector;
+	struct cdns_mhdp_device *mhdp;
+	struct edid *edid;
+	int ret = 0;
+
+	mhdp_connector = to_mhdp_connector(connector);
+	mhdp =  mhdp_connector->bridge->mhdp;
+
+	edid = drm_dp_mst_get_edid(connector, &mhdp->mst_mgr,
+				   mhdp_connector->port);
+
+	DRM_DEBUG_KMS("edid retrieved %p\n", edid);
+	if (edid) {
+		drm_connector_update_edid_property(connector, edid);
+		ret = drm_add_edid_modes(connector, edid);
+		return ret;
+	}
+	drm_connector_update_edid_property(connector, NULL);
+
+	return ret;
+}
+
+static int cdns_mhdp_mst_get_modes(struct drm_connector *connector)
+{
+	return cdns_mhdp_mst_get_ddc_modes(connector);
+}
+
+
+static struct
+drm_encoder *cdns_mhdp_mst_best_encoder(struct drm_connector *connector)
+{
+	struct cdns_mhdp_connector *mhdp_connector;
+
+	mhdp_connector = to_mhdp_connector(connector);
+
+	return mhdp_connector->bridge->base.encoder;
+}
+
+static const struct drm_connector_helper_funcs cdns_mhdp_mst_conn_helper_fun = {
+	.get_modes = cdns_mhdp_mst_get_modes,
+	.best_encoder = cdns_mhdp_mst_best_encoder,
+};
+
+void cdns_mhdp_mst_enable(struct drm_bridge *bridge)
+{
+	struct cdns_mhdp_bridge *mhdp_bridge = to_mhdp_bridge(bridge);
+	struct cdns_mhdp_device *mhdp = mhdp_bridge->mhdp;
+	struct drm_display_info *disp_info;
+	struct drm_display_mode *mode;
+	struct cdns_mhdp_connector *mhdp_connector;
+	u32 bpp;
+	enum pixel_format pxlfmt;
+	int ret, slots, stream_id;
+
+	disp_info = &mhdp_bridge->connector->base.display_info;
+
+	pxlfmt = cdns_mhdp_get_pxlfmt(disp_info->color_formats);
+	bpp = cdns_mhdp_get_bpp(disp_info->bpc, pxlfmt);
+
+	mhdp_connector = mhdp_bridge->connector;
+	if (mhdp_bridge->stream_id > -1) {
+		DRM_ERROR("ERROR stream id is attached before bridge is enabled\n");
+		return;
+	}
+
+	stream_id = bridge->encoder->crtc->index;
+
+	mode = &bridge->encoder->crtc->state->adjusted_mode;
+	mhdp_bridge->pbn = drm_dp_calc_pbn_mode(mode->clock, bpp);
+
+	slots = drm_dp_find_vcpi_slots(&mhdp->mst_mgr, mhdp_bridge->pbn);
+	ret = drm_dp_mst_allocate_vcpi(&mhdp->mst_mgr,
+				       mhdp_connector->port,
+				       mhdp_bridge->pbn, slots);
+	if (ret == false) {
+		DRM_ERROR("failed to allocate vcpi\n");
+		return;
+	}
+	ret = drm_dp_update_payload_part1(&mhdp->mst_mgr);
+	if (ret < 0)
+		DRM_ERROR("failed update_payload_part1\n");
+
+	mhdp_bridge->stream_id = stream_id;
+	mhdp_bridge->is_active = true;
+
+	cdns_mhdp_mst_stream_enable(mhdp_bridge, true);
+	cdns_mhdp_configure_video(bridge);
+
+	ret = cdns_mhdp_apply_slot_allocation(mhdp_bridge);
+	if (ret < 0) {
+		cdns_mhdp_mst_stream_enable(mhdp_bridge, false);
+		mhdp_bridge->stream_id = -1;
+		mhdp_bridge->is_active = false;
+		return;
+	}
+
+	ret = cdns_mhdp_set_act_enable(mhdp);
+	if (ret)
+		DRM_ERROR("failed ACT sequence\n");
+
+	cdns_mhdp_set_rate_governing(mhdp_bridge, true);
+
+	cdns_mhdp_mst_set_threshold(mhdp_bridge);
+
+	drm_dp_update_payload_part2(&mhdp->mst_mgr);
+}
+
+void cdns_mhdp_mst_disable(struct drm_bridge *bridge)
+{
+	struct cdns_mhdp_bridge *mhdp_bridge = to_mhdp_bridge(bridge);
+	struct cdns_mhdp_device *mhdp = mhdp_bridge->mhdp;
+	struct cdns_mhdp_connector *connector = mhdp_bridge->connector;
+
+	drm_dp_mst_reset_vcpi_slots(&mhdp->mst_mgr, connector->port);
+	drm_dp_update_payload_part1(&mhdp->mst_mgr);
+
+	cdns_mhdp_update_slot_allocation(mhdp_bridge);
+
+	drm_dp_check_act_status(&mhdp->mst_mgr);
+
+	drm_dp_update_payload_part2(&mhdp->mst_mgr);
+
+	drm_dp_mst_deallocate_vcpi(&mhdp->mst_mgr, connector->port);
+
+	cdns_mhdp_set_rate_governing(mhdp_bridge, false);
+	cdns_mhdp_mst_stream_enable(mhdp_bridge, false);
+	mhdp_bridge->stream_id = -1;
+	mhdp_bridge->is_active = false;
+}
+
+static const struct drm_bridge_funcs cdns_mhdp_mst_bridge_funcs = {
+	.enable = cdns_mhdp_enable,
+	.disable = cdns_mhdp_mst_disable,
+};
+
+
+static struct cdns_mhdp_bridge*
+cdns_mhpd_create_fake_mst_bridge(struct cdns_mhdp_device *mhdp,
+				struct cdns_mhdp_connector *mhdp_connector)
+{
+	struct cdns_mhdp_bridge *mhdp_bridge;
+	struct drm_encoder *encoder = NULL;
+	struct cdns_mhdp_mst_cbs *cbs = &mhdp->cbs;
+
+	mhdp_bridge = kzalloc(sizeof(*mhdp_bridge), GFP_KERNEL);
+	if (!mhdp_bridge)
+		return NULL;
+
+	mhdp_bridge->mhdp = mhdp;
+	mhdp_bridge->stream_id = -1;
+	mhdp_bridge->connector = mhdp_connector;
+	mhdp_bridge->is_active = false;
+
+	mhdp_bridge->base.funcs = &cdns_mhdp_mst_bridge_funcs;
+
+	drm_bridge_add(&mhdp_bridge->base);
+
+	if (cbs->funcs.create_mst_encoder)
+		encoder = cbs->funcs.create_mst_encoder(cbs->priv_data,
+							&mhdp_bridge->base);
+	if (encoder) {
+		int ret;
+		/* use the same drm device as is in the first encoder */
+		encoder->dev = mhdp->bridge.base.encoder->dev;
+		encoder->possible_crtcs &= ((1 << CDNS_MHDP_MAX_STREAMS) - 1);
+		ret = drm_bridge_attach(encoder, &mhdp_bridge->base, NULL);
+		if (ret) {
+			dev_err(mhdp->dev, "bridge attaching error %d\n", ret);
+			return NULL;
+		}
+
+		ret = drm_connector_attach_encoder(&mhdp_connector->base,
+							encoder);
+		if (ret) {
+			dev_err(mhdp->dev, "failed to attach connector to encoder\n");
+			return NULL;
+		}
+	}
+
+	return mhdp_bridge;
+}
+
+static struct drm_connector *
+cdns_mhdp_mst_cbs_add_connector(struct drm_dp_mst_topology_mgr *mgr,
+				struct drm_dp_mst_port *port,
+				const char *pathprop)
+{
+	struct cdns_mhdp_device *mhdp = mgr_to_mhdp(mgr);
+	struct drm_device *dev = mhdp->bridge.base.dev;
+	struct cdns_mhdp_connector *mhdp_connector;
+	struct drm_connector *connector;
+	struct drm_connector_state  *conn_state;
+	int ret;
+
+	mhdp_connector = kzalloc(sizeof(struct cdns_mhdp_connector),
+				 GFP_KERNEL);
+	if (!mhdp_connector)
+		return NULL;
+
+	mhdp_connector->is_mst_connector = true;
+	connector = &mhdp_connector->base;
+	mhdp_connector->port = port;
+	DRM_DEBUG_KMS("\n");
+
+	conn_state = kzalloc(sizeof(*conn_state), GFP_KERNEL);
+	if (!conn_state)
+		return NULL;
+
+	__drm_atomic_helper_connector_reset(connector,
+					    conn_state);
+
+	drm_connector_init(dev, connector, &cdns_mhdp_mst_connector_funcs,
+			   DRM_MODE_CONNECTOR_DisplayPort);
+	drm_connector_helper_add(connector, &cdns_mhdp_mst_conn_helper_fun);
+	mhdp_connector->bridge =
+		cdns_mhpd_create_fake_mst_bridge(mhdp, mhdp_connector);
+
+	drm_object_attach_property(&connector->base,
+				   dev->mode_config.path_property, 0);
+	drm_object_attach_property(&connector->base,
+				   dev->mode_config.tile_property, 0);
+	ret = drm_connector_set_path_property(connector, pathprop);
+
+	if (ret)
+		DRM_ERROR("ERROR set path propertty failed\n");
+
+	return connector;
+}
+
+static void
+cdns_mhdp_mst_cbs_destroy_connector(struct drm_dp_mst_topology_mgr *mgr,
+				    struct drm_connector *connector)
+{
+	struct cdns_mhdp_connector *mhdp_connector;
+	struct cdns_mhdp_device *mhdp;
+	struct cdns_mhdp_bridge *mhdp_bridge;
+
+	mhdp_connector = to_mhdp_connector(connector);
+	mhdp_bridge = mhdp_connector->bridge;
+	mhdp = mhdp_bridge->mhdp;
+
+	drm_connector_unregister(&mhdp_connector->base);
+
+	if (mhdp->cbs.funcs.create_mst_encoder)
+		mhdp->cbs.funcs.destroy_mst_encoder(mhdp->cbs.priv_data,
+						    &mhdp_bridge->base);
+	drm_connector_unreference(&mhdp_connector->base);
+}
+
+static void cdns_mhdp_mst_cbs_hotplug(struct drm_dp_mst_topology_mgr *mgr)
+{
+	struct cdns_mhdp_device *mhdp = mgr_to_mhdp(mgr);
+	struct drm_device *dev = mhdp->bridge.base.encoder->dev;
+
+	drm_kms_helper_hotplug_event(dev);
+}
+
+static void
+cdns_mhdp_mst_cbs_register_connector(struct drm_connector *connector)
+{
+	int ret;
+
+	ret = drm_connector_register(connector);
+	if (ret)
+		DRM_ERROR("Register connector failed\n");
+
+}
+
+static const struct drm_dp_mst_topology_cbs mst_cbs = {
+	.add_connector = cdns_mhdp_mst_cbs_add_connector,
+	.register_connector = cdns_mhdp_mst_cbs_register_connector,
+	.destroy_connector = cdns_mhdp_mst_cbs_destroy_connector,
+	.hotplug = cdns_mhdp_mst_cbs_hotplug,
+};
+
+
+static void cdns_mhdp_set_mst_enable(struct cdns_mhdp_device *mhdp, bool enable)
+{
+	u32 reg_val;
+
+	cdns_mhdp_reg_read(mhdp, CDNS_DP_FRAMER_GLOBAL_CONFIG, &reg_val);
+
+	if (enable)
+		reg_val |= CDNS_DP_MST_EN;
+	else
+		reg_val &= ~CDNS_DP_MST_EN;
+
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_FRAMER_GLOBAL_CONFIG, reg_val);
+}
+
+bool cdns_mhdp_mst_probe(struct cdns_mhdp_device *mhdp)
+{
+	u8 mstm_cap;
+	u8 dpcd_cap[DP_RECEIVER_CAP_SIZE];
+
+	bool is_mst;
+
+	if (!mhdp->can_mst)
+		return false;
+
+	drm_dp_dpcd_read(&mhdp->aux, DP_DPCD_REV, dpcd_cap,
+			 DP_RECEIVER_CAP_SIZE);
+
+	if (dpcd_cap[DP_DPCD_REV] < 0x12)
+		return false;
+
+	if (drm_dp_dpcd_readb(&mhdp->aux, DP_MSTM_CAP, &mstm_cap) != 1)
+		return false;
+
+	if (mstm_cap & DP_MST_CAP) {
+		DRM_DEBUG_KMS("Sink is MST capable\n");
+		is_mst = true;
+	} else {
+		DRM_DEBUG_KMS("Sink is not MST capable\n");
+		is_mst = false;
+	}
+
+	if (is_mst != mhdp->is_mst) {
+		mhdp->is_mst = is_mst;
+		cdns_mhdp_set_mst_enable(mhdp, mhdp->is_mst);
+
+		drm_dp_mst_topology_mgr_set_mst(&mhdp->mst_mgr,
+						mhdp->is_mst);
+	}
+
+	return mhdp->is_mst;
+}
+
+int cdns_mhdp_mst_init(struct cdns_mhdp_device *mhdp)
+{
+	struct cdns_mhdp_bridge *bridge = &mhdp->bridge;
+	struct drm_device *dev = bridge->base.dev;
+	struct cdns_mhdp_connector *connector = bridge->connector;
+	int ret;
+
+	mhdp->mst_mgr.cbs = &mst_cbs;
+	ret = drm_dp_mst_topology_mgr_init(&mhdp->mst_mgr, dev,
+					   &mhdp->aux, 16,
+					   CDNS_MHDP_MAX_STREAMS,
+					   connector->base.base.id);
+	if (ret)
+		mhdp->can_mst = false;
+	else
+		mhdp->can_mst = true;
+
+	mhdp->is_mst = false;
+
+	bridge->stream_id = -1;
+
+	return ret;
+}
+
+void cdns_mhdp_mst_deinit(struct cdns_mhdp_device *mhdp)
+{
+	if (mhdp->is_mst) {
+		mhdp->is_mst = false;
+		drm_dp_mst_topology_mgr_set_mst(&mhdp->mst_mgr,
+						mhdp->is_mst);
+	}
+
+	if (mhdp->can_mst)
+		drm_dp_mst_topology_mgr_destroy(&mhdp->mst_mgr);
+}
diff --git a/drivers/gpu/drm/bridge/cdns-mhdp.c b/drivers/gpu/drm/bridge/cdns-mhdp.c
index a3bbc0e809a5..48ac5cf1e031 100644
--- a/drivers/gpu/drm/bridge/cdns-mhdp.c
+++ b/drivers/gpu/drm/bridge/cdns-mhdp.c
@@ -27,146 +27,15 @@
 #include <drm/bridge/cdns-mhdp-common.h>
 
 #include <sound/hdmi-codec.h>
+#include <linux/irq.h>
+#include <linux/of_irq.h>
 
+#include "cdns-mhdp.h"
 
 #define DEBUG_MSG
 
 #define FW_NAME					"cadence/mhdp8546.bin"
 
-#define CDNS_APB_CFG				0x00000
-#define CDNS_APB_CTRL				(CDNS_APB_CFG + 0x00)
-#define CDNS_MAILBOX_FULL			(CDNS_APB_CFG + 0x08)
-#define CDNS_MAILBOX_EMPTY			(CDNS_APB_CFG + 0x0c)
-#define CDNS_MAILBOX_TX_DATA			(CDNS_APB_CFG + 0x10)
-#define CDNS_MAILBOX_RX_DATA			(CDNS_APB_CFG + 0x14)
-#define CDNS_KEEP_ALIVE				(CDNS_APB_CFG + 0x18)
-#define CDNS_KEEP_ALIVE_MASK			GENMASK(7, 0)
-
-#define CDNS_SW_CLK_L				(CDNS_APB_CFG + 0x3c)
-#define CDNS_SW_CLK_H				(CDNS_APB_CFG + 0x40)
-#define CDNS_SW_EVENT0				(CDNS_APB_CFG + 0x44)
-#define CDNS_DPTX_HPD				BIT(0)
-
-#define CDNS_SW_EVENT1				(CDNS_APB_CFG + 0x48)
-#define CDNS_SW_EVENT2				(CDNS_APB_CFG + 0x4c)
-#define CDNS_SW_EVENT3				(CDNS_APB_CFG + 0x50)
-
-#define CDNS_DPTX_CAR				(CDNS_APB_CFG + 0x904)
-#define CDNS_VIF_CLK_EN				BIT(0)
-#define CDNS_VIF_CLK_RSTN			BIT(1)
-
-#define CDNS_SOURCE_VIDEO_INTERFACE		0x00b00
-#define CDNS_BND_HSYNC2VSYNC			(CDNS_SOURCE_VIDEO_INTERFACE + \
-						 0x00)
-#define CDNS_IP_DTCT_WIN			GENMASK(11, 0)
-#define CDNS_IP_DET_INTERLACE_FORMAT		BIT(12)
-#define CDNS_IP_BYPASS_V_INTERFACE		BIT(13)
-
-#define CDNS_HSYNC2VSYNC_POL_CTRL		(CDNS_SOURCE_VIDEO_INTERFACE + \
-						 0x10)
-#define CDNS_H2V_HSYNC_POL_ACTIVE_LOW		BIT(1)
-#define CDNS_H2V_VSYNC_POL_ACTIVE_LOW		BIT(2)
-
-#define CDNS_DPTX_PHY_CONFIG			0x02000
-#define CDNS_PHY_TRAINING_EN			BIT(0)
-#define CDNS_PHY_TRAINING_TYPE(x)		(((x) & GENMASK(3, 0)) << 1)
-#define CDNS_PHY_SCRAMBLER_BYPASS		BIT(5)
-#define CDNS_PHY_ENCODER_BYPASS			BIT(6)
-#define CDNS_PHY_SKEW_BYPASS			BIT(7)
-#define CDNS_PHY_TRAINING_AUTO			BIT(8)
-#define CDNS_PHY_LANE0_SKEW(x)			(((x) & GENMASK(2, 0)) << 9)
-#define CDNS_PHY_LANE1_SKEW(x)			(((x) & GENMASK(2, 0)) << 12)
-#define CDNS_PHY_LANE2_SKEW(x)			(((x) & GENMASK(2, 0)) << 15)
-#define CDNS_PHY_LANE3_SKEW(x)			(((x) & GENMASK(2, 0)) << 18)
-#define CDNS_PHY_COMMON_CONFIG			(CDNS_PHY_LANE1_SKEW(1) | \
-						CDNS_PHY_LANE2_SKEW(2) |  \
-						CDNS_PHY_LANE3_SKEW(3))
-#define CDNS_PHY_10BIT_EN			BIT(21)
-
-#define CDNS_DPTX_FRAMER			0x02200
-#define CDNS_DP_FRAMER_GLOBAL_CONFIG		(CDNS_DPTX_FRAMER + 0x00)
-#define CDNS_DP_NUM_LANES(x)			(x - 1)
-#define CDNS_DP_FRAMER_EN			BIT(3)
-#define CDNS_DP_RATE_GOVERNOR_EN		BIT(4)
-#define CDNS_DP_NO_VIDEO_MODE			BIT(5)
-#define CDNS_DP_DISABLE_PHY_RST			BIT(6)
-#define CDNS_DP_WR_FAILING_EDGE_VSYNC		BIT(7)
-
-#define CDNS_DP_SW_RESET			(CDNS_DPTX_FRAMER + 0x04)
-#define CDNS_DP_FRAMER_TU			(CDNS_DPTX_FRAMER + 0x08)
-#define CDNS_DP_FRAMER_TU_SIZE(x)		(((x) & GENMASK(6, 0)) << 8)
-#define CDNS_DP_FRAMER_TU_VS(x)			((x) & GENMASK(5, 0))
-#define CDNS_DP_FRAMER_TU_CNT_RST_EN		BIT(15)
-
-#define CDNS_DPTX_STREAM			0x03000
-#define CDNS_DP_MSA_HORIZONTAL_0		(CDNS_DPTX_STREAM + 0x00)
-#define CDNS_DP_MSAH0_H_TOTAL(x)		(x)
-#define CDNS_DP_MSAH0_HSYNC_START(x)		((x) << 16)
-
-#define CDNS_DP_MSA_HORIZONTAL_1		(CDNS_DPTX_STREAM + 0x04)
-#define CDNS_DP_MSAH1_HSYNC_WIDTH(x)		(x)
-#define CDNS_DP_MSAH1_HSYNC_POL_LOW		BIT(15)
-#define CDNS_DP_MSAH1_HDISP_WIDTH(x)		((x) << 16)
-
-#define CDNS_DP_MSA_VERTICAL_0			(CDNS_DPTX_STREAM + 0x08)
-#define CDNS_DP_MSAV0_V_TOTAL(x)		(x)
-#define CDNS_DP_MSAV0_VSYNC_START(x)		((x) << 16)
-
-#define CDNS_DP_MSA_VERTICAL_1			(CDNS_DPTX_STREAM + 0x0c)
-#define CDNS_DP_MSAV1_VSYNC_WIDTH(x)		(x)
-#define CDNS_DP_MSAV1_VSYNC_POL_LOW		BIT(15)
-#define CDNS_DP_MSAV1_VDISP_WIDTH(x)		((x) << 16)
-
-#define CDNS_DP_MSA_MISC			(CDNS_DPTX_STREAM + 0x10)
-#define CDNS_DP_STREAM_CONFIG			(CDNS_DPTX_STREAM + 0x14)
-#define CDNS_DP_RATE_GOVERNOR_STATUS		(CDNS_DPTX_STREAM + 0x2c)
-#define CDNS_DP_RG_TU_VS_DIFF(x)		((x) << 8)
-
-#define CDNS_DP_HORIZONTAL			(CDNS_DPTX_STREAM + 0x30)
-#define CDNS_DP_H_HSYNC_WIDTH(x)		(x)
-#define CDNS_DP_H_H_TOTAL(x)			((x) << 16)
-
-#define CDNS_DP_VERTICAL_0			(CDNS_DPTX_STREAM + 0x34)
-#define CDNS_DP_V0_VHEIGHT(x)			(x)
-#define CDNS_DP_V0_VSTART(x)			((x) << 16)
-
-#define CDNS_DP_VERTICAL_1			(CDNS_DPTX_STREAM + 0x38)
-#define CDNS_DP_V1_VTOTAL(x)			(x)
-#define CDNS_DP_V1_VTOTAL_EVEN			BIT(16)
-
-#define CDNS_DP_FRAMER_PXL_REPR			(CDNS_DPTX_STREAM + 0x4c)
-#define CDNS_DP_FRAMER_6_BPC			BIT(0)
-#define CDNS_DP_FRAMER_8_BPC			BIT(1)
-#define CDNS_DP_FRAMER_10_BPC			BIT(2)
-#define CDNS_DP_FRAMER_12_BPC			BIT(3)
-#define CDNS_DP_FRAMER_16_BPC			BIT(4)
-#define CDNS_DP_FRAMER_PXL_FORMAT		0x8
-#define CDNS_DP_FRAMER_RGB			BIT(0)
-#define CDNS_DP_FRAMER_YCBCR444			BIT(1)
-#define CDNS_DP_FRAMER_YCBCR422			BIT(2)
-#define CDNS_DP_FRAMER_YCBCR420			BIT(3)
-#define CDNS_DP_FRAMER_Y_ONLY			BIT(4)
-
-#define CDNS_DP_FRAMER_SP			(CDNS_DPTX_STREAM + 0x10)
-#define CDNS_DP_FRAMER_VSYNC_POL_LOW		BIT(0)
-#define CDNS_DP_FRAMER_HSYNC_POL_LOW		BIT(1)
-#define CDNS_DP_FRAMER_INTERLACE		BIT(2)
-
-#define CDNS_DP_LINE_THRESH			(CDNS_DPTX_STREAM + 0x64)
-#define CDNS_DP_VB_ID				(CDNS_DPTX_STREAM + 0x68)
-#define CDNS_DP_VB_ID_INTERLACED		BIT(2)
-
-#define CDNS_DP_FRONT_BACK_PORCH		(CDNS_DPTX_STREAM + 0x78)
-#define CDNS_DP_BACK_PORCH(x)			(x)
-#define CDNS_DP_FRONT_PORCH(x)			((x) << 16)
-
-#define CDNS_DP_BYTE_COUNT			(CDNS_DPTX_STREAM + 0x7c)
-
-#define CDNS_DPTX_GLOBAL			0x02300
-#define CDNS_DP_LANE_EN				(CDNS_DPTX_GLOBAL + 0x00)
-#define CDNS_DP_LANE_EN_LANES(x)		GENMASK(x - 1, 0)
-#define CDNS_DP_ENHNCD				(CDNS_DPTX_GLOBAL + 0x04)
-
 #define CDNS_MHDP_IMEM				0x10000
 #define CDNS_MHDP_DMEM				0x20000
 
@@ -216,13 +85,17 @@ MODULE_DEVICE_TABLE(of, mhdp_ids);
 static inline struct cdns_mhdp_device *connector_to_mhdp(
 	struct drm_connector *conn)
 {
-	return container_of(conn, struct cdns_mhdp_device, connector);
+	struct cdns_mhdp_connector *mhdp_connector = to_mhdp_connector(conn);
+
+	return mhdp_connector->bridge->mhdp;
 }
 
 static inline struct cdns_mhdp_device *bridge_to_mhdp(
 	struct drm_bridge *bridge)
 {
-	return container_of(bridge, struct cdns_mhdp_device, bridge);
+	struct cdns_mhdp_bridge *mhdp_bridge = to_mhdp_bridge(bridge);
+
+	return mhdp_bridge->mhdp;
 }
 
 static unsigned int max_link_rate(struct cdns_mhdp_host host,
@@ -237,6 +110,62 @@ static u8 eq_training_pattern_supported(struct cdns_mhdp_host host,
 	return fls(host.pattern_supp & sink.pattern_supp);
 }
 
+static void mhdp_hotplug_work_func(struct work_struct *work)
+{
+	struct cdns_mhdp_device *mhdp;
+	int dret, retry;
+	u8 esi[16] = { 0 };
+	bool new_irq_handled;
+	struct drm_connector *connector;
+	bool old_plugged;
+
+
+	mhdp = container_of(work, struct cdns_mhdp_device,
+			    hotplug_work.work);
+	connector = &mhdp->connector.base;
+
+	old_plugged = mhdp->plugged;
+	connector->status = connector->funcs->detect(connector, false);
+	if (old_plugged != mhdp->plugged) {
+		drm_kms_helper_hotplug_event(mhdp->bridge.base.dev);
+		return;
+	}
+
+	if (mhdp->plugged) {
+		dret = drm_dp_dpcd_read(&mhdp->aux,
+					DP_SINK_COUNT_ESI, esi, 8);
+
+		if (dret == 8) {
+			drm_dp_mst_hpd_irq(&mhdp->mst_mgr,
+					   esi,
+					   &new_irq_handled);
+		}
+
+		if (new_irq_handled) {
+			for (retry = 0; retry < 3; retry++) {
+				int wret;
+
+				wret = drm_dp_dpcd_write(&mhdp->aux,
+							 DP_SINK_COUNT_ESI+1,
+							 &esi[1], 3);
+				if (wret == 3)
+					break;
+			}
+		}
+	}
+
+}
+
+static irqreturn_t mhdp_irq_handler(int irq, void *data)
+{
+	struct cdns_mhdp_device *mhdp = (struct cdns_mhdp_device *)data;
+
+	if (readl(mhdp->regs + CDNS_SW_EVENT0) & CDNS_DPTX_HPD)
+		schedule_delayed_work(&mhdp->hotplug_work, 0);
+
+	return IRQ_HANDLED;
+}
+
 static ssize_t mhdp_transfer(struct drm_dp_aux *aux,
 			     struct drm_dp_aux_msg *msg)
 {
@@ -300,10 +229,16 @@ static enum drm_connector_status cdns_mhdp_detect(struct drm_connector *conn,
 	int ret;
 
 	ret = cdns_mhdp_get_hpd_status(mhdp);
-	if (ret > 0)
-		status = connector_status_connected;
-	else if (ret < 0)
+	if (ret > 0) {
+		mhdp->plugged = true;
+		cdns_mhdp_mst_probe(mhdp);
+		// for MST mode this connector will be always disconnected
+		if (!mhdp->is_mst)
+			status = connector_status_connected;
+	} else if (ret < 0)
 		dev_err(mhdp->dev, "Failed to obtain HPD state\n");
+	else
+		mhdp->plugged = false;
 
 	return status;
 }
@@ -321,11 +256,15 @@ static const struct drm_connector_funcs cdns_mhdp_conn_funcs = {
 static int cdns_mhdp_attach(struct drm_bridge *bridge)
 {
 	struct cdns_mhdp_device *mhdp = bridge_to_mhdp(bridge);
-	struct drm_connector *conn = &mhdp->connector;
+	struct drm_connector *conn = &mhdp->connector.base;
 	int ret;
 
-	conn->polled = DRM_CONNECTOR_POLL_CONNECT |
-		DRM_CONNECTOR_POLL_DISCONNECT;
+	if (&mhdp->bridge.base != bridge)
+		return -ENODEV;
+
+	cdns_mhdp_mst_init(mhdp);
+
+	conn->polled = DRM_CONNECTOR_POLL_HPD;
 
 	ret = drm_connector_init(bridge->dev, conn, &cdns_mhdp_conn_funcs,
 				 DRM_MODE_CONNECTOR_DisplayPort);
@@ -342,17 +281,12 @@ static int cdns_mhdp_attach(struct drm_bridge *bridge)
 		return ret;
 	}
 
+	/* enable interrupts */
+	writel(~CDNS_APB_INT_MASK_SW_EVENT_INT, mhdp->regs + CDNS_APB_INT_MASK);
+
 	return 0;
 }
 
-enum pixel_format {
-	PIXEL_FORMAT_RGB = 1,
-	PIXEL_FORMAT_YCBCR_444 = 2,
-	PIXEL_FORMAT_YCBCR_422 = 4,
-	PIXEL_FORMAT_YCBCR_420 = 8,
-	PIXEL_FORMAT_Y_ONLY = 16,
-};
-
 static void mhdp_link_training_init(struct cdns_mhdp_device *mhdp)
 {
 	u32 reg32;
@@ -716,13 +650,11 @@ static int mhdp_link_training(struct cdns_mhdp_device *mhdp,
 	cdns_mhdp_reg_write(mhdp, CDNS_DP_SW_RESET, 1);
 	cdns_mhdp_reg_write(mhdp, CDNS_DP_SW_RESET, 0);
 
-	/* Enable framer */
-	/* FIXME: update when MST supported, BIT(2) */
 	cdns_mhdp_reg_write(mhdp, CDNS_DP_FRAMER_GLOBAL_CONFIG,
-			    CDNS_DP_FRAMER_EN |
 			    CDNS_DP_NUM_LANES(mhdp->link.num_lanes) |
 			    CDNS_DP_DISABLE_PHY_RST |
 			    CDNS_DP_WR_FAILING_EDGE_VSYNC |
+			    (mhdp->is_mst ? CDNS_DP_MST_EN : 0) |
 			    (!video_mode ? CDNS_DP_NO_VIDEO_MODE : 0));
 
 	/* Reset PHY config */
@@ -751,31 +683,20 @@ static void cdns_mhdp_disable(struct drm_bridge *bridge)
 
 	cdns_mhdp_set_video_status(mhdp, 0);
 
+	mhdp->link_up = false;
+
 	drm_dp_link_power_down(&mhdp->aux, &mhdp->link);
+	if (mhdp->is_mst)
+		cdns_mhdp_mst_disable(bridge);
 }
 
-static void cdns_mhdp_enable(struct drm_bridge *bridge)
+static int cdns_mhdp_link_up(struct cdns_mhdp_device *mhdp)
 {
-	struct cdns_mhdp_device *mhdp = bridge_to_mhdp(bridge);
-	struct drm_display_mode *mode;
-	struct drm_display_info *disp_info = &mhdp->connector.display_info;
-	enum pixel_format pxlfmt;
-	int pxlclock;
-	unsigned int rate, tu_size = 30, vs, vs_f, bpp, required_bandwidth,
-		     available_bandwidth, dp_framer_sp = 0, msa_horizontal_1,
-		     msa_vertical_1, bnd_hsync2vsync, hsync2vsync_pol_ctrl,
-		     misc0 = 0, misc1 = 0, line_thresh = 0, pxl_repr,
-		     front_porch, back_porch, msa_h0, msa_v0, hsync, vsync,
-		     dp_vertical_1, line_thresh1, line_thresh2;
 	u32 resp;
-
-	unsigned int size = DP_RECEIVER_CAP_SIZE, dp_framer_global_config,
+	u32 size = DP_RECEIVER_CAP_SIZE, dp_framer_global_config,
 		     video_mode, training_interval_us;
 	u8 reg0[size], reg8, amp[2];
 
-	mode = &bridge->encoder->crtc->state->adjusted_mode;
-	pxlclock = mode->crtc_clock;
-
 	/*
 	 * Upon power-on reset/device disconnection: [2:0] bits should be 0b001
 	 * and [7:5] bits 0b000.
@@ -824,13 +745,17 @@ static void cdns_mhdp_enable(struct drm_bridge *bridge)
 	default:
 		dev_err(mhdp->dev,
 			"wrong training interval returned by DPCD: %d\n", reg8);
-		return;
+		return -EIO;
 	}
 
 	cdns_mhdp_reg_read(mhdp, CDNS_DP_FRAMER_GLOBAL_CONFIG, &resp);
 
 	dp_framer_global_config = be32_to_cpu(resp);
 
+	cdns_mhdp_mst_probe(mhdp);
+	if (mhdp->is_mst)
+		dp_framer_global_config |= CDNS_DP_MST_EN;
+
 	video_mode = !(dp_framer_global_config & CDNS_DP_NO_VIDEO_MODE);
 
 	if (dp_framer_global_config & CDNS_DP_FRAMER_EN)
@@ -850,50 +775,168 @@ static void cdns_mhdp_enable(struct drm_bridge *bridge)
 		if (mhdp_link_training(mhdp, video_mode,
 				       training_interval_us)) {
 			dev_err(mhdp->dev, "Link training failed. Exiting.\n");
-			return;
+			return -EIO;
 		}
 	}
 
+	mhdp->link_up = true;
+
+	return 0;
+}
+
+static int cdns_mhdp_sst_enable(struct drm_bridge *bridge)
+{
+	struct cdns_mhdp_bridge *mhdp_bridge = to_mhdp_bridge(bridge);
+	struct cdns_mhdp_device *mhdp = mhdp_bridge->mhdp;
+	u32 rate, vs, vs_f, required_bandwidth, available_bandwidth;
+	u32 bpp, tu_size = 30, line_thresh1, line_thresh2, line_thresh = 0;
+	struct drm_display_mode *mode;
+	int pxlclock;
+	enum pixel_format pxlfmt;
+	struct drm_display_info *disp_info = &mhdp->connector.base.display_info;
+
+
+	mode = &bridge->encoder->crtc->state->adjusted_mode;
+	pxlclock = mode->crtc_clock;
+
+	mhdp_bridge->stream_id = 0;
+
 	rate = mhdp->link.rate / 1000;
 
+	pxlfmt = cdns_mhdp_get_pxlfmt(disp_info->color_formats);
+	bpp = cdns_mhdp_get_bpp(disp_info->bpc, pxlfmt);
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
+		return -EINVAL;
+
+
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_FRAMER_TU,
+			    CDNS_DP_FRAMER_TU_VS(vs) |
+			    CDNS_DP_FRAMER_TU_SIZE(tu_size) |
+			    CDNS_DP_FRAMER_TU_CNT_RST_EN);
+
+	line_thresh1 = ((vs + 1) << 5) * 8 / bpp;
+	line_thresh2 = (pxlclock << 5) / 1000 / rate * (vs + 1) - (1 << 5);
+	line_thresh = line_thresh1 - line_thresh2 / mhdp->link.num_lanes;
+	line_thresh = (line_thresh >> 5) + 2;
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_LINE_THRESH(0),
+			    line_thresh & GENMASK(5, 0));
+
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_STREAM_CONFIG_2(0),
+			    CDNS_DP_SC2_TU_VS_DIFF((tu_size - vs > 3) ?
+						       0 : tu_size - vs));
+
+	cdns_mhdp_configure_video(bridge);
+
+	cdns_mhdp_set_video_status(mhdp, 1);
+
+	return 0;
+}
+
+enum pixel_format cdns_mhdp_get_pxlfmt(u32 color_formats)
+{
+	enum pixel_format pxlfmt;
+
 	/* FIXME: what about Y_ONLY? how is it handled in the kernel? */
-	if (disp_info->color_formats & DRM_COLOR_FORMAT_YCRCB444)
+	if (color_formats & DRM_COLOR_FORMAT_YCRCB444)
 		pxlfmt = PIXEL_FORMAT_YCBCR_444;
-	else if (disp_info->color_formats & DRM_COLOR_FORMAT_YCRCB422)
+	else if (color_formats & DRM_COLOR_FORMAT_YCRCB422)
 		pxlfmt = PIXEL_FORMAT_YCBCR_422;
-	else if (disp_info->color_formats & DRM_COLOR_FORMAT_YCRCB420)
+	else if (color_formats & DRM_COLOR_FORMAT_YCRCB420)
 		pxlfmt = PIXEL_FORMAT_YCBCR_420;
 	else
 		pxlfmt = PIXEL_FORMAT_RGB;
 
+	return pxlfmt;
+}
+
+
+u32 cdns_mhdp_get_bpp(u32 bpc, enum pixel_format pxlfmt)
+{
+	u32 bpp;
+
+	switch (pxlfmt) {
+	case PIXEL_FORMAT_RGB:
+		bpp = bpc * 3;
+		break;
+	case PIXEL_FORMAT_YCBCR_444:
+		bpp = bpc * 3;
+		break;
+	case PIXEL_FORMAT_YCBCR_422:
+		bpp = bpc * 2;
+		break;
+	case PIXEL_FORMAT_YCBCR_420:
+		bpp = bpc * 3 / 2;
+		break;
+	default:
+		bpp = bpc;
+	}
+	return bpp;
+}
+
+void cdns_mhdp_configure_video(struct drm_bridge *bridge)
+{
+	struct cdns_mhdp_bridge *mhdp_bridge = to_mhdp_bridge(bridge);
+	struct cdns_mhdp_device *mhdp = mhdp_bridge->mhdp;
+	struct drm_display_info *disp_info;
+	unsigned int bpp,  dp_framer_sp = 0, msa_horizontal_1,
+		     msa_vertical_1, bnd_hsync2vsync, hsync2vsync_pol_ctrl,
+		     misc0 = 0, misc1 = 0, pxl_repr,
+		     front_porch, back_porch, msa_h0, msa_v0, hsync, vsync,
+		     dp_vertical_1;
+	struct drm_display_mode *mode;
+	enum pixel_format pxlfmt;
+	int pxlclock;
+	u32 tmp;
+	u8 stream_id = mhdp_bridge->stream_id;
+
+	mode = &bridge->encoder->crtc->state->adjusted_mode;
+	pxlclock = mode->crtc_clock;
+
+	disp_info = &mhdp_bridge->connector->base.display_info;
+	pxlfmt = cdns_mhdp_get_pxlfmt(disp_info->color_formats);
+
 	/* if YCBCR supported and stream not SD, use ITU709 */
 	/* FIXME: handle ITU version with YCBCR420 when supported */
 	if ((pxlfmt == PIXEL_FORMAT_YCBCR_444 ||
 	     pxlfmt == PIXEL_FORMAT_YCBCR_422) && mode->crtc_vdisplay >= 720)
 		misc0 = DP_YCBCR_COEFFICIENTS_ITU709;
 
+	bpp = cdns_mhdp_get_bpp(disp_info->bpc, pxlfmt);
+
 	switch (pxlfmt) {
 	case PIXEL_FORMAT_RGB:
-		bpp = disp_info->bpc * 3;
 		pxl_repr = CDNS_DP_FRAMER_RGB << CDNS_DP_FRAMER_PXL_FORMAT;
 		misc0 |= DP_COLOR_FORMAT_RGB;
 		break;
 	case PIXEL_FORMAT_YCBCR_444:
-		bpp = disp_info->bpc * 3;
 		pxl_repr = CDNS_DP_FRAMER_YCBCR444 << CDNS_DP_FRAMER_PXL_FORMAT;
 		misc0 |= DP_COLOR_FORMAT_YCbCr444 | DP_TEST_DYNAMIC_RANGE_CEA;
 		break;
 	case PIXEL_FORMAT_YCBCR_422:
-		bpp = disp_info->bpc * 2;
 		pxl_repr = CDNS_DP_FRAMER_YCBCR422 << CDNS_DP_FRAMER_PXL_FORMAT;
 		misc0 |= DP_COLOR_FORMAT_YCbCr422 | DP_TEST_DYNAMIC_RANGE_CEA;
 		break;
 	case PIXEL_FORMAT_YCBCR_420:
-		bpp = disp_info->bpc * 3 / 2;
 		pxl_repr = CDNS_DP_FRAMER_YCBCR420 << CDNS_DP_FRAMER_PXL_FORMAT;
 		break;
 	default:
-		bpp = disp_info->bpc;
 		pxl_repr = CDNS_DP_FRAMER_Y_ONLY << CDNS_DP_FRAMER_PXL_FORMAT;
 	}
 
@@ -920,30 +963,12 @@ static void cdns_mhdp_enable(struct drm_bridge *bridge)
 		break;
 	}
 
-	/* find optimal tu_size */
-	required_bandwidth = pxlclock * bpp / 8;
-	available_bandwidth = mhdp->link.num_lanes * rate;
-	do {
-		tu_size += 2;
-
-		vs_f = tu_size * required_bandwidth / available_bandwidth;
-		vs = vs_f / 1000;
-		vs_f = vs_f % 1000;
-		/*
-		 * FIXME (CDNS): downspreading?
-		 * It's unused is what I've been told.
-		 */
-	} while ((vs == 1 || ((vs_f > 850 || vs_f < 100) && vs_f != 0) ||
-		  tu_size - vs < 2) && tu_size < 64);
-
-	if (vs > 64)
-		return;
-
 	bnd_hsync2vsync = CDNS_IP_BYPASS_V_INTERFACE;
 	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
 		bnd_hsync2vsync |= CDNS_IP_DET_INTERLACE_FORMAT;
 
-	cdns_mhdp_reg_write(mhdp, CDNS_BND_HSYNC2VSYNC, bnd_hsync2vsync);
+	cdns_mhdp_reg_write(mhdp, CDNS_BND_HSYNC2VSYNC(stream_id),
+			    bnd_hsync2vsync);
 
 	if (mode->flags & DRM_MODE_FLAG_INTERLACE &&
 	    mode->flags & DRM_MODE_FLAG_PHSYNC)
@@ -952,15 +977,10 @@ static void cdns_mhdp_enable(struct drm_bridge *bridge)
 	else
 		hsync2vsync_pol_ctrl = 0;
 
-	cdns_mhdp_reg_write(mhdp, CDNS_HSYNC2VSYNC_POL_CTRL,
+	cdns_mhdp_reg_write(mhdp, CDNS_HSYNC2VSYNC_POL_CTRL(stream_id),
 			    hsync2vsync_pol_ctrl);
 
-	cdns_mhdp_reg_write(mhdp, CDNS_DP_FRAMER_TU,
-			    CDNS_DP_FRAMER_TU_VS(vs) |
-			    CDNS_DP_FRAMER_TU_SIZE(tu_size) |
-			    CDNS_DP_FRAMER_TU_CNT_RST_EN);
-
-	cdns_mhdp_reg_write(mhdp, CDNS_DP_FRAMER_PXL_REPR, pxl_repr);
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_FRAMER_PXL_REPR(stream_id), pxl_repr);
 
 	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
 		dp_framer_sp |= CDNS_DP_FRAMER_INTERLACE;
@@ -968,19 +988,19 @@ static void cdns_mhdp_enable(struct drm_bridge *bridge)
 		dp_framer_sp |= CDNS_DP_FRAMER_HSYNC_POL_LOW;
 	if (mode->flags & DRM_MODE_FLAG_NVSYNC)
 		dp_framer_sp |= CDNS_DP_FRAMER_VSYNC_POL_LOW;
-	cdns_mhdp_reg_write(mhdp, CDNS_DP_FRAMER_SP, dp_framer_sp);
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_FRAMER_SP(stream_id), dp_framer_sp);
 
 	front_porch = mode->crtc_hsync_start - mode->crtc_hdisplay;
 	back_porch = mode->crtc_htotal - mode->crtc_hsync_end;
-	cdns_mhdp_reg_write(mhdp, CDNS_DP_FRONT_BACK_PORCH,
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_FRONT_BACK_PORCH(stream_id),
 			    CDNS_DP_FRONT_PORCH(front_porch) |
 			    CDNS_DP_BACK_PORCH(back_porch));
 
-	cdns_mhdp_reg_write(mhdp, CDNS_DP_BYTE_COUNT,
+		cdns_mhdp_reg_write(mhdp, CDNS_DP_BYTE_COUNT(stream_id),
 			    mode->crtc_hdisplay * bpp / 8);
 
 	msa_h0 = mode->crtc_htotal - mode->crtc_hsync_start;
-	cdns_mhdp_reg_write(mhdp, CDNS_DP_MSA_HORIZONTAL_0,
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_MSA_HORIZONTAL_0(stream_id),
 			    CDNS_DP_MSAH0_H_TOTAL(mode->crtc_htotal) |
 			    CDNS_DP_MSAH0_HSYNC_START(msa_h0));
 
@@ -989,11 +1009,11 @@ static void cdns_mhdp_enable(struct drm_bridge *bridge)
 		CDNS_DP_MSAH1_HDISP_WIDTH(mode->crtc_hdisplay);
 	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
 		msa_horizontal_1 |= CDNS_DP_MSAH1_HSYNC_POL_LOW;
-	cdns_mhdp_reg_write(mhdp, CDNS_DP_MSA_HORIZONTAL_1,
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_MSA_HORIZONTAL_1(stream_id),
 			    msa_horizontal_1);
 
 	msa_v0 = mode->crtc_vtotal - mode->crtc_vsync_start;
-	cdns_mhdp_reg_write(mhdp, CDNS_DP_MSA_VERTICAL_0,
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_MSA_VERTICAL_0(stream_id),
 			    CDNS_DP_MSAV0_V_TOTAL(mode->crtc_vtotal) |
 			    CDNS_DP_MSAV0_VSYNC_START(msa_v0));
 
@@ -1002,7 +1022,8 @@ static void cdns_mhdp_enable(struct drm_bridge *bridge)
 		CDNS_DP_MSAV1_VDISP_WIDTH(mode->crtc_vdisplay);
 	if (mode->flags & DRM_MODE_FLAG_NVSYNC)
 		msa_vertical_1 |= CDNS_DP_MSAV1_VSYNC_POL_LOW;
-	cdns_mhdp_reg_write(mhdp, CDNS_DP_MSA_VERTICAL_1, msa_vertical_1);
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_MSA_VERTICAL_1(stream_id),
+			    msa_vertical_1);
 
 	if ((mode->flags & DRM_MODE_FLAG_INTERLACE) &&
 	    mode->crtc_vtotal % 2 == 0)
@@ -1014,16 +1035,14 @@ static void cdns_mhdp_enable(struct drm_bridge *bridge)
 	if (pxlfmt == PIXEL_FORMAT_YCBCR_420)
 		misc1 = CDNS_DP_TEST_VSC_SDP;
 
-	cdns_mhdp_reg_write(mhdp, CDNS_DP_MSA_MISC, misc0 | (misc1 << 8));
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_MSA_MISC(stream_id),
+			    misc0 | (misc1 << 8));
 
-	/* FIXME: to be changed if MST mode */
-	cdns_mhdp_reg_write(mhdp, CDNS_DP_STREAM_CONFIG, 1);
-
-	cdns_mhdp_reg_write(mhdp, CDNS_DP_HORIZONTAL,
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_HORIZONTAL(stream_id),
 			    CDNS_DP_H_HSYNC_WIDTH(hsync) |
 			    CDNS_DP_H_H_TOTAL(mode->crtc_hdisplay));
 
-	cdns_mhdp_reg_write(mhdp, CDNS_DP_VERTICAL_0,
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_VERTICAL_0(stream_id),
 			    CDNS_DP_V0_VHEIGHT(mode->crtc_vdisplay) |
 			    CDNS_DP_V0_VSTART(msa_v0));
 
@@ -1032,30 +1051,51 @@ static void cdns_mhdp_enable(struct drm_bridge *bridge)
 	    mode->crtc_vtotal % 2 == 0)
 		dp_vertical_1 |= CDNS_DP_V1_VTOTAL_EVEN;
 
-	cdns_mhdp_reg_write(mhdp, CDNS_DP_VERTICAL_1, dp_vertical_1);
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_VERTICAL_1(stream_id), dp_vertical_1);
 
-	cdns_mhdp_reg_write_bit(mhdp, CDNS_DP_VB_ID, 2, 1,
+	cdns_mhdp_reg_write_bit(mhdp, CDNS_DP_VB_ID(stream_id), 2, 1,
 				(mode->flags & DRM_MODE_FLAG_INTERLACE) ?
 				CDNS_DP_VB_ID_INTERLACED : 0);
 
-	line_thresh1 = ((vs + 1) << 5) * 8 / bpp;
-	line_thresh2 = (pxlclock << 5) / 1000 / rate * (vs + 1) - (1 << 5);
-	line_thresh = line_thresh1 - line_thresh2 / mhdp->link.num_lanes;
-	line_thresh = (line_thresh >> 5) + 2;
-	cdns_mhdp_reg_write(mhdp, CDNS_DP_LINE_THRESH,
-			    line_thresh & GENMASK(5, 0));
 
-	cdns_mhdp_reg_write(mhdp, CDNS_DP_RATE_GOVERNOR_STATUS,
-			    CDNS_DP_RG_TU_VS_DIFF((tu_size - vs > 3) ?
-						       0 : tu_size - vs));
+	cdns_mhdp_reg_read(mhdp, CDNS_DP_FRAMER_GLOBAL_CONFIG, &tmp);
+	tmp |= CDNS_DP_FRAMER_EN;
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_FRAMER_GLOBAL_CONFIG, tmp);
+}
 
-	cdns_mhdp_set_video_status(mhdp, 1);
+void cdns_mhdp_enable(struct drm_bridge *bridge)
+{
+	struct cdns_mhdp_bridge *mhdp_bridge = to_mhdp_bridge(bridge);
+	struct cdns_mhdp_device *mhdp = mhdp_bridge->mhdp;
+	int ret = 0;
+
+	bool link_up = mhdp->link_up;
+
+	if (!link_up)
+		cdns_mhdp_link_up(mhdp);
+
+
+	if (!mhdp->is_mst)
+		ret = cdns_mhdp_sst_enable(bridge);
+	else
+		cdns_mhdp_mst_enable(bridge);
+
+}
+
+static void cdns_mhdp_detach(struct drm_bridge *bridge)
+{
+	struct cdns_mhdp_device *mhdp = bridge_to_mhdp(bridge);
+	struct cdns_mhdp_mst_cbs cbs_null = {0};
+
+	cdns_mhdp_mst_deinit(mhdp);
+	mhdp->cbs = cbs_null;
 }
 
 static const struct drm_bridge_funcs cdns_mhdp_bridge_funcs = {
 	.enable = cdns_mhdp_enable,
 	.disable = cdns_mhdp_disable,
 	.attach = cdns_mhdp_attach,
+	.detach = cdns_mhdp_detach,
 };
 
 static int load_firmware(struct cdns_mhdp_device *mhdp, const char *name,
@@ -1127,8 +1167,8 @@ static int cdns_mhdp_audio_get_eld(struct device *dev, void *data,
 {
 	struct cdns_mhdp_device *mhdp = dev_get_drvdata(dev);
 
-	memcpy(buf, mhdp->connector.eld,
-	       min(sizeof(mhdp->connector.eld), len));
+	memcpy(buf, mhdp->connector.base.eld,
+	       min(sizeof(mhdp->connector.base.eld), len));
 
 	return 0;
 }
@@ -1149,6 +1189,7 @@ static int mhdp_probe(struct platform_device *pdev)
 	unsigned int reg;
 	unsigned long rate;
 	u32 resp;
+	int irq;
 
 	struct hdmi_codec_pdata codec_data = {
 		.i2s = 1,
@@ -1192,6 +1233,14 @@ static int mhdp_probe(struct platform_device *pdev)
 	/* Leave debug mode */
 	writel(0, mhdp->regs + CDNS_APB_CTRL);
 
+	irq = platform_get_irq(pdev, 0);
+	ret = request_irq(irq, mhdp_irq_handler, 0, "mhdp8546", mhdp);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"cannot install IRQ %d\n", irq);
+		return -EIO;
+	}
+
 	/*
 	 * Wait for the KEEP_ALIVE "message" on the first 8 bits.
 	 * Updated each sched "tick" (~2ms)
@@ -1222,8 +1271,8 @@ static int mhdp_probe(struct platform_device *pdev)
 	mhdp->host.lane_mapping = CDNS_LANE_MAPPING_FLIPPED;
 	mhdp->host.enhanced = true;
 
-	mhdp->bridge.of_node = pdev->dev.of_node;
-	mhdp->bridge.funcs = &cdns_mhdp_bridge_funcs;
+	mhdp->bridge.base.of_node = pdev->dev.of_node;
+	mhdp->bridge.base.funcs = &cdns_mhdp_bridge_funcs;
 
 	/* Init events to 0 as it's not cleared by FW at boot but on read */
 	readl(mhdp->regs + CDNS_SW_EVENT0);
@@ -1247,21 +1296,14 @@ static int mhdp_probe(struct platform_device *pdev)
 	cdns_mhdp_reg_write(mhdp, CDNS_DPTX_CAR,
 			    resp | CDNS_VIF_CLK_EN | CDNS_VIF_CLK_RSTN);
 
-	/* Loop over HDP change */
-	/*
-	 * FIXME: does not work when put in mhdp_bridge_enable.
-	 * Where should we put it?
-	 */
-	/* Is it still needed with use of mb message HPD STATUS? */
-	ret = readl_poll_timeout(mhdp->regs + CDNS_SW_EVENT0, reg,
-				 reg & CDNS_DPTX_HPD, 500,
-				 CDNS_SW_EVENT0_TIMEOUT);
-	if (ret) {
-		dev_err(mhdp->dev, "no HPD received %d\n", reg);
-		return -ENODEV;
-	}
+	INIT_DELAYED_WORK(&mhdp->hotplug_work, mhdp_hotplug_work_func);
+
+	mhdp->bridge.connector = &mhdp->connector;
+	mhdp->connector.bridge = &mhdp->bridge;
+	mhdp->bridge.mhdp = mhdp;
+	mhdp->bridge.is_active = false;
 
-	drm_bridge_add(&mhdp->bridge);
+	drm_bridge_add(&mhdp->bridge.base);
 
 	return 0;
 }
@@ -1273,9 +1315,11 @@ static int mhdp_remove(struct platform_device *pdev)
 	struct cdns_mhdp_device *mhdp = dev_get_drvdata(&pdev->dev);
 	int ret;
 
+	flush_delayed_work(&mhdp->hotplug_work);
 	platform_device_unregister(mhdp->audio_pdev);
 
-	drm_bridge_remove(&mhdp->bridge);
+	cdns_mhdp_mst_deinit(mhdp);
+	drm_bridge_remove(&mhdp->bridge.base);
 
 	ret = cdns_mhdp_set_firmware_active(mhdp, false);
 	if (ret) {
@@ -1288,6 +1332,17 @@ static int mhdp_remove(struct platform_device *pdev)
 	return 0;
 }
 
+int mhdp_bridge_attach_mst_cbs(struct drm_bridge *bridge,
+			       struct cdns_mhdp_mst_cbs *cbs)
+{
+	struct cdns_mhdp_device *mhdp = bridge_to_mhdp(bridge);
+
+	mhdp->cbs = *cbs;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mhdp_bridge_attach_mst_cbs);
+
 static struct platform_driver mhdp_driver = {
 	.driver	= {
 		.name		= "cdns-mhdp",
@@ -1299,6 +1354,9 @@ static struct platform_driver mhdp_driver = {
 module_platform_driver(mhdp_driver);
 
 MODULE_AUTHOR("Quentin Schulz <quentin.schulz@free-electrons.com>");
+MODULE_AUTHOR("Przemyslaw Gaj <pgaj@cadence.com>");
+MODULE_AUTHOR("Damian Kos <dkos@cadence.com>");
+MODULE_AUTHOR("Piotr Sroka <piotrs@cadence.com>");
 MODULE_DESCRIPTION("Cadence MHDP DP bridge driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:cdns-mhdp");
diff --git a/drivers/gpu/drm/bridge/cdns-mhdp.h b/drivers/gpu/drm/bridge/cdns-mhdp.h
new file mode 100644
index 000000000000..abc1fa3f51a6
--- /dev/null
+++ b/drivers/gpu/drm/bridge/cdns-mhdp.h
@@ -0,0 +1,209 @@
+/* SPDX-License-Identifier: GPL v2 */
+/*
+ * Cadence MHDP DP MST bridge driver.
+ *
+ * Copyright: 2018 Cadence Design Systems, Inc.
+ *
+ * Author: Quentin Schulz <quentin.schulz@free-electrons.com>
+ */
+
+
+#ifndef CDNS_MHDP_H
+#define CDNS_MHDP_H
+
+#include <drm/drm_dp_mst_helper.h>
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
+#define CDNS_MB_INT_MASK			(CDNS_APB_CFG + 0x34)
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
+#define CDNS_APB_INT_MASK			(CDNS_APB_CFG + 0x6C)
+#define CDNS_APB_INT_MASK_MAILBOX_INT		BIT(0)
+#define CDNS_APB_INT_MASK_SW_EVENT_INT		BIT(1)
+
+#define CDNS_DPTX_CAR				(CDNS_APB_CFG + 0x904)
+#define CDNS_VIF_CLK_EN				BIT(0)
+#define CDNS_VIF_CLK_RSTN			BIT(1)
+
+#define CDNS_SOURCE_VIDEO_IF(s)			(0x00b00 + (s * 0x20))
+#define CDNS_BND_HSYNC2VSYNC(s)			(CDNS_SOURCE_VIDEO_IF(s) + \
+						 0x00)
+#define CDNS_IP_DTCT_WIN			GENMASK(11, 0)
+#define CDNS_IP_DET_INTERLACE_FORMAT		BIT(12)
+#define CDNS_IP_BYPASS_V_INTERFACE		BIT(13)
+
+#define CDNS_HSYNC2VSYNC_POL_CTRL(s)		(CDNS_SOURCE_VIDEO_IF(s) + \
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
+#define CDNS_DP_MST_EN				BIT(2)
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
+#define CDNS_DPTX_STREAM(s)			(0x03000 + s * 0x80)
+#define CDNS_DP_MSA_HORIZONTAL_0(s)		(CDNS_DPTX_STREAM(s) + 0x00)
+#define CDNS_DP_MSAH0_H_TOTAL(x)		(x)
+#define CDNS_DP_MSAH0_HSYNC_START(x)		((x) << 16)
+
+#define CDNS_DP_MSA_HORIZONTAL_1(s)		(CDNS_DPTX_STREAM(s) + 0x04)
+#define CDNS_DP_MSAH1_HSYNC_WIDTH(x)		(x)
+#define CDNS_DP_MSAH1_HSYNC_POL_LOW		BIT(15)
+#define CDNS_DP_MSAH1_HDISP_WIDTH(x)		((x) << 16)
+
+#define CDNS_DP_MSA_VERTICAL_0(s)		(CDNS_DPTX_STREAM(s) + 0x08)
+#define CDNS_DP_MSAV0_V_TOTAL(x)		(x)
+#define CDNS_DP_MSAV0_VSYNC_START(x)		((x) << 16)
+
+#define CDNS_DP_MSA_VERTICAL_1(s)		(CDNS_DPTX_STREAM(s) + 0x0c)
+#define CDNS_DP_MSAV1_VSYNC_WIDTH(x)		(x)
+#define CDNS_DP_MSAV1_VSYNC_POL_LOW		BIT(15)
+#define CDNS_DP_MSAV1_VDISP_WIDTH(x)		((x) << 16)
+
+#define CDNS_DP_MSA_MISC(s)			(CDNS_DPTX_STREAM(s) + 0x10)
+#define CDNS_DP_STREAM_CONFIGs(s)		(CDNS_DPTX_STREAM(s) + 0x14)
+#define CDNS_DP_STREAM_CONFIG_2(s)		(CDNS_DPTX_STREAM(s) + 0x2c)
+#define CDNS_DP_SC2_TU_VS_DIFF(x)		((x) << 8)
+
+#define CDNS_DP_HORIZONTAL(s)			(CDNS_DPTX_STREAM(s) + 0x30)
+#define CDNS_DP_H_HSYNC_WIDTH(x)		(x)
+#define CDNS_DP_H_H_TOTAL(x)			((x) << 16)
+
+#define CDNS_DP_VERTICAL_0(s)			(CDNS_DPTX_STREAM(s) + 0x34)
+#define CDNS_DP_V0_VHEIGHT(x)			(x)
+#define CDNS_DP_V0_VSTART(x)			((x) << 16)
+
+#define CDNS_DP_VERTICAL_1(s)			(CDNS_DPTX_STREAM(s) + 0x38)
+#define CDNS_DP_V1_VTOTAL(x)			(x)
+#define CDNS_DP_V1_VTOTAL_EVEN			BIT(16)
+
+#define CDNS_DP_FRAMER_PXL_REPR(s)		(CDNS_DPTX_STREAM(s) + 0x4c)
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
+#define CDNS_DP_FRAMER_SP(s)			(CDNS_DPTX_STREAM(s) + 0x10)
+#define CDNS_DP_FRAMER_VSYNC_POL_LOW		BIT(0)
+#define CDNS_DP_FRAMER_HSYNC_POL_LOW		BIT(1)
+#define CDNS_DP_FRAMER_INTERLACE		BIT(2)
+
+#define CDNS_DP_LINE_THRESH(s)			(CDNS_DPTX_STREAM(s) + 0x64)
+#define CDNS_DP_ACTIVE_LINE_THRESH(x)		(x)
+
+#define CDNS_DP_VB_ID(s)			(CDNS_DPTX_STREAM(s) + 0x68)
+#define CDNS_DP_VB_ID_INTERLACED		BIT(2)
+#define CDNS_DP_VB_ID_COMPRESSED		BIT(6)
+
+#define CDNS_DP_FRONT_BACK_PORCH(s)		(CDNS_DPTX_STREAM(s) + 0x78)
+#define CDNS_DP_BACK_PORCH(x)			(x)
+#define CDNS_DP_FRONT_PORCH(x)			((x) << 16)
+
+#define CDNS_DP_BYTE_COUNT(s)			(CDNS_DPTX_STREAM(s) + 0x7c)
+#define CDNS_DP_BYTE_COUNT_BYTES_IN_CHUNK_SHIFT	16
+
+#define CDNS_DP_MST_STREAM_CONFIG(s)		(CDNS_DPTX_STREAM(s) + 0x14)
+#define CDNS_DP_MST_STRM_CFG_STREAM_EN		BIT(0)
+#define CDNS_DP_MST_STRM_CFG_NO_VIDEO		BIT(1)
+
+#define CDNS_DP_MST_SLOT_ALLOCATE(s)		(CDNS_DPTX_STREAM(s) + 0x44)
+#define CDNS_DP_S_ALLOC_START_SLOT(x)		(x)
+#define CDNS_DP_S_ALLOC_END_SLOT(x)		((x) << 8)
+
+#define CDNS_DP_RATE_GOVERNING(s)		(CDNS_DPTX_STREAM(s) + 0x48)
+#define CDNS_DP_RG_TARG_AV_SLOTS_Y(x)		(x)
+#define CDNS_DP_RG_TARG_AV_SLOTS_X(x)		(x << 4)
+#define CDNS_DP_RG_ENABLE			BIT(10)
+
+#define CDNS_DP_MTPH_CONTROL			0x2264
+#define CDNS_DP_MTPH_ECF_EN			BIT(0)
+#define CDNS_DP_MTPH_ACT_EN			BIT(1)
+#define CDNS_DP_MTPH_LVP_EN			BIT(2)
+
+#define CDNS_DP_MTPH_STATUS			0x226C
+#define CDNS_DP_MTPH_ACT_STATUS			BIT(0)
+
+
+#define CDNS_DPTX_GLOBAL			0x02300
+#define CDNS_DP_LANE_EN				(CDNS_DPTX_GLOBAL + 0x00)
+#define CDNS_DP_LANE_EN_LANES(x)		GENMASK(x - 1, 0)
+#define CDNS_DP_ENHNCD				(CDNS_DPTX_GLOBAL + 0x04)
+
+
+#define to_mhdp_connector(x) container_of(x, struct cdns_mhdp_connector, base)
+#define to_mhdp_bridge(x) container_of(x, struct cdns_mhdp_bridge, base)
+#define mgr_to_mhdp(x) container_of(x, struct cdns_mhdp_device, mst_mgr)
+
+#define CDNS_MHDP_MAX_STREAMS   4
+
+enum pixel_format {
+	PIXEL_FORMAT_RGB = 1,
+	PIXEL_FORMAT_YCBCR_444 = 2,
+	PIXEL_FORMAT_YCBCR_422 = 4,
+	PIXEL_FORMAT_YCBCR_420 = 8,
+	PIXEL_FORMAT_Y_ONLY = 16,
+};
+
+
+int cdns_mhdp_mst_init(struct cdns_mhdp_device *mhdp);
+void cdns_mhdp_mst_deinit(struct cdns_mhdp_device *mhdp);
+bool cdns_mhdp_mst_probe(struct cdns_mhdp_device *mhdp);
+enum pixel_format cdns_mhdp_get_pxlfmt(u32 color_formats);
+u32 cdns_mhdp_get_bpp(u32 bpc, u32 color_formats);
+void cdns_mhdp_configure_video(struct drm_bridge *bridge);
+void cdns_mhdp_mst_enable(struct drm_bridge *bridge);
+void cdns_mhdp_mst_disable(struct drm_bridge *bridge);
+void cdns_mhdp_enable(struct drm_bridge *bridge);
+
+#endif
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index 343f381e3440..a5a668f1912b 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -34,7 +34,7 @@
 #include "rockchip_drm_vop.h"
 
 #define connector_to_dp(c) \
-		container_of(c, struct cdn_dp_device, mhdp.connector)
+		container_of(c, struct cdn_dp_device, mhdp.connector.base)
 
 #define encoder_to_dp(c) \
 		container_of(c, struct cdn_dp_device, encoder)
@@ -291,7 +291,7 @@ static int cdn_dp_connector_mode_valid(struct drm_connector *connector,
 {
 	struct cdn_dp_device *dp = connector_to_dp(connector);
 	struct drm_display_info *display_info =
-		&dp->mhdp.connector.display_info;
+		&dp->mhdp.connector.base.display_info;
 	u32 requested, actual, rate, sink_max, source_max = 0;
 	u8 lanes, bpc;
 
@@ -387,7 +387,7 @@ static int cdn_dp_get_sink_capability(struct cdn_dp_device *dp)
 	}
 
 	kfree(dp->edid);
-	dp->edid = drm_do_get_edid(&dp->mhdp.connector,
+	dp->edid = drm_do_get_edid(&dp->mhdp.connector.base,
 				   cdns_mhdp_get_edid_block, &dp->mhdp);
 	return 0;
 }
@@ -559,7 +559,7 @@ static void cdn_dp_encoder_mode_set(struct drm_encoder *encoder,
 {
 	struct cdn_dp_device *dp = encoder_to_dp(encoder);
 	struct drm_display_info *display_info =
-		&dp->mhdp.connector.display_info;
+		&dp->mhdp.connector.base.display_info;
 	struct video_info *video = &dp->mhdp.video_info;
 
 	switch (display_info->bpc) {
@@ -863,8 +863,8 @@ static int cdn_dp_audio_get_eld(struct device *dev, void *data,
 {
 	struct cdn_dp_device *dp = dev_get_drvdata(dev);
 
-	memcpy(buf, dp->mhdp.connector.eld,
-	       min(sizeof(dp->mhdp.connector.eld), len));
+	memcpy(buf, dp->mhdp.connector.base.eld,
+	       min(sizeof(dp->mhdp.connector.base.eld), len));
 
 	return 0;
 }
@@ -936,7 +936,7 @@ static void cdn_dp_pd_event_work(struct work_struct *work)
 {
 	struct cdn_dp_device *dp = container_of(work, struct cdn_dp_device,
 						event_work);
-	struct drm_connector *connector = &dp->mhdp.connector;
+	struct drm_connector *connector = &dp->mhdp.connector.base;
 	enum drm_connector_status old_status;
 	struct device *dev = dp->mhdp.dev;
 
@@ -1062,7 +1062,7 @@ static int cdn_dp_bind(struct device *dev, struct device *master, void *data)
 
 	drm_encoder_helper_add(encoder, &cdn_dp_encoder_helper_funcs);
 
-	connector = &dp->mhdp.connector;
+	connector = &dp->mhdp.connector.base;
 	connector->polled = DRM_CONNECTOR_POLL_HPD;
 	connector->dpms = DRM_MODE_DPMS_OFF;
 
@@ -1113,7 +1113,7 @@ static void cdn_dp_unbind(struct device *dev, struct device *master, void *data)
 {
 	struct cdn_dp_device *dp = dev_get_drvdata(dev);
 	struct drm_encoder *encoder = &dp->encoder;
-	struct drm_connector *connector = &dp->mhdp.connector;
+	struct drm_connector *connector = &dp->mhdp.connector.base;
 
 	cancel_work_sync(&dp->event_work);
 	cdn_dp_encoder_disable(encoder);
diff --git a/include/drm/bridge/cdns-mhdp-cbs.h b/include/drm/bridge/cdns-mhdp-cbs.h
new file mode 100644
index 000000000000..af07cbfcb729
--- /dev/null
+++ b/include/drm/bridge/cdns-mhdp-cbs.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL v2 */
+/*
+ * Cadence MHDP DP bridge callbacks.
+ *
+ * Copyright: 2018 Cadence Design Systems, Inc.
+ *
+ * Author: Piotr Sroka <piotrs@cadence.com>
+ */
+
+#ifndef CDNS_MHDP_CBS_H
+#define CDNS_MHDP_CBS_H
+
+struct cdns_mhdp_mst_cbs_funcs {
+	struct drm_encoder *(*create_mst_encoder)(void *priv_data,
+						  struct drm_bridge *bridge);
+	void (*destroy_mst_encoder)(void *priv_data, struct drm_bridge *bridge);
+};
+
+struct cdns_mhdp_mst_cbs {
+	struct cdns_mhdp_mst_cbs_funcs funcs;
+	void *priv_data;
+};
+
+int mhdp_bridge_attach_mst_cbs(struct drm_bridge *bridge,
+			       struct cdns_mhdp_mst_cbs *cbs);
+
+#endif
diff --git a/include/drm/bridge/cdns-mhdp-common.h b/include/drm/bridge/cdns-mhdp-common.h
index c5a5c4fa7fc4..d4711091ff2b 100644
--- a/include/drm/bridge/cdns-mhdp-common.h
+++ b/include/drm/bridge/cdns-mhdp-common.h
@@ -15,10 +15,12 @@
 #ifndef CDNS_MHDP_COMMON_H_
 #define CDNS_MHDP_COMMON_H_
 
+#include <drm/drm_dp_mst_helper.h>
 #include <linux/bitops.h>
 #include <drm/drm_dp_helper.h>
 #include <drm/drm_connector.h>
 #include <drm/drm_bridge.h>
+#include <drm/bridge/cdns-mhdp-cbs.h>
 
 #define ADDR_IMEM		0x10000
 #define ADDR_DMEM		0x20000
@@ -326,11 +328,11 @@
 #define MB_MODULE_ID_GENERAL		0x0a
 
 /* general opcode */
-#define GENERAL_MAIN_CONTROL            0x01
-#define GENERAL_TEST_ECHO               0x02
-#define GENERAL_BUS_SETTINGS            0x03
-#define GENERAL_TEST_ACCESS             0x04
-#define GENERAL_REGISTER_READ           0x07
+#define GENERAL_MAIN_CONTROL		0x01
+#define GENERAL_TEST_ECHO		0x02
+#define GENERAL_BUS_SETTINGS		0x03
+#define GENERAL_TEST_ACCESS		0x04
+#define GENERAL_REGISTER_READ		0x07
 
 #define DPTX_SET_POWER_MNG			0x00
 #define DPTX_SET_HOST_CAPABILITIES		0x01
@@ -512,13 +514,34 @@ struct cdns_mhdp_sink {
 	u8	enhanced;
 };
 
+struct cdns_mhdp_bridge;
+struct cdns_mhdp_connector;
+
+struct cdns_mhdp_bridge {
+	struct cdns_mhdp_device *mhdp;
+	struct drm_bridge base;
+	int pbn;
+	int8_t stream_id;
+	struct cdns_mhdp_connector *connector;
+	bool is_active;
+};
+
+
+struct cdns_mhdp_connector {
+	struct drm_connector base;
+	bool is_mst_connector;
+	struct drm_dp_mst_port *port;
+	struct cdns_mhdp_bridge *bridge;
+};
+
+
 struct cdns_mhdp_device {
 	void __iomem		*regs;
 
 	struct device		*dev;
 
 	struct drm_dp_link	link;
-	struct drm_connector	connector;
+	struct cdns_mhdp_connector  connector;
 	struct clk		*spdif_clk;
 	struct reset_control	*spdif_rst;
 
@@ -528,13 +551,22 @@ struct cdns_mhdp_device {
 	struct drm_dp_aux	aux;
 	struct cdns_mhdp_host	host;
 	struct cdns_mhdp_sink	sink;
-	struct drm_bridge	bridge;
+	struct cdns_mhdp_bridge	bridge;
 	struct phy		*phy;
 	void __iomem		*dbg_regs;
 
 	struct video_info	video_info;
 	struct drm_display_mode	mode;
 	unsigned int		fw_version;
+
+	struct drm_dp_mst_topology_mgr mst_mgr;
+	struct delayed_work hotplug_work;
+
+	struct cdns_mhdp_mst_cbs cbs;
+	bool is_mst;
+	bool can_mst;
+	bool link_up;
+	bool plugged;
 };
 
 void cdns_mhdp_clock_reset(struct cdns_mhdp_device *mhdp);
@@ -562,7 +594,7 @@ int cdns_mhdp_audio_config(struct cdns_mhdp_device *mhdp,
 int cdns_mhdp_reg_read(struct cdns_mhdp_device *mhdp, u32 addr, u32 *value);
 int cdns_mhdp_reg_write(struct cdns_mhdp_device *mhdp, u16 addr, u32 val);
 int cdns_mhdp_reg_write_bit(struct cdns_mhdp_device *mhdp, u16 addr,
-				   u8 start_bit, u8 bits_no, u32 val);
+			    u8 start_bit, u8 bits_no, u32 val);
 int cdns_mhdp_adjust_lt(struct cdns_mhdp_device *mhdp, u8 nlanes,
 			u16 udelay, u8 *lanes_data,
 			u8 *dpcd);
-- 
2.17.1

