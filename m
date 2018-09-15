Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5AF4ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83CEA21476
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Ppu8A62k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83CEA21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbeIOGtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:49:52 -0400
Received: from mail-sn1nam02on0127.outbound.protection.outlook.com ([104.47.36.127]:18752
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728682AbeIOGtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:49:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/PjX/+RPL8dXXxfAp9OvFiJlHhLl2qROgnAx5CmVlk=;
 b=Ppu8A62keGxa1SsGtcNMG4YkrFN2IcVF8/hvpPRNNL2ngTxJQOhMq7YkPfheSNO+1qmY2+zSR+rCL3tKFxheePrLr8Tv5KUitH85nF207HZiisPMXarte2lM70WtAFLQgkWCJIs1RgSC0fHLW4hApUvSXE3jl+FIQh7QE5QZ9lM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Sat, 15 Sep 2018 01:32:45 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:32:45 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 25/57] tty: fix termios input-speed encoding
Thread-Topic: [PATCH AUTOSEL 4.14 25/57] tty: fix termios input-speed encoding
Thread-Index: AQHUTJQAnvLvpjn9e0CApUDgUzN4Og==
Date:   Sat, 15 Sep 2018 01:32:45 +0000
Message-ID: <20180915013223.179909-25-alexander.levin@microsoft.com>
References: <20180915013223.179909-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013223.179909-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:m12OrJNKXn7CgSc1wWzV4mF+LuxAEVb6evfmvlQmT3mqIzEMiriaF5vxWaciDp8V0fErbHiSpugSCXeHwiGS2uB+8J0V1J+wnSn7ULW9Q3C5oqRSdren5IbWriiqchVEjBhBbkgrITgAOamT6OvalB0LMlu1rmI8jUT/zKxkhyZTYOroTtr7AQK64fgftuMaUFVDnISA/8ltcj8H/2SMNpBSUogyN8R+sjcH/TJ3tI3kvtatYu79j5k4+vxcoQiLdI9SKMP0mNeXR64YSPQTqrzyCZ9CZO27Sa7D9jkGy2NRNMr0gb9taDXm+TGQ5jqfXnlodEe/4ADc4aIJ1qPYkBonrcPeLvlXdf2s5MqGoZhqHEcyIcODIBZUgAkBvu6yqE26VncmcpzJ5sKmJYNpATMx9u2+eECiqxrhhpHtH8Mf+InCahRIwkBxL6M74Wj0+ufB2V9KfoBzTcdsQ62/LQ==;5:fhyZ7lTiMD+H0Fs63ICfKijy5KVPM9nJju/E7tQoWfK3yDgzSfjQgtdzEiBH0r+a3fPHNcv6gE0dTmERpG64gETd93rJu5llyECS3VFhE/VM4AHgP8aOFCMibaXb4IE6wWZ+pLv14YEeokKZrY29E7T5usEyNc0uWWK8dGBgFXU=;7:ZHRf1krpcabFW2bXTzH+Uc2t5rWDAyCYQvgKb2EyYJ0tnxTVvsoOAGPYlejMiT9uJbdQ/45jqrccydRKWWWEFto5zRPJCe5Be7dHB6FP1WTkz5CRTtk1qllLk+pVOUPe1stnEYOWRIlUdBCcAj3DwKoJQpkbUfRZrGAR/wKGqkRYHLnpDhihXzeSjoFW2TkQS726taDVv2UlqB25/1HdhVo3vXFe88arM7W07x+elft0vOW+FHp++dTymDXSEb9j
x-ms-office365-filtering-correlation-id: 941a3029-6399-41a2-6fa4-08d61aab2371
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0822C4B894FAC3A3F5777FACFB180@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231353)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(396003)(346002)(376002)(189003)(199004)(1076002)(72206003)(6506007)(102836004)(478600001)(8936002)(10290500003)(2906002)(81166006)(81156014)(5660300001)(22452003)(2900100001)(8676002)(110136005)(54906003)(107886003)(99286004)(25786009)(4326008)(316002)(10090500001)(97736004)(305945005)(7736002)(6116002)(3846002)(256004)(14444005)(66066001)(76176011)(217873002)(6436002)(14454004)(36756003)(476003)(86612001)(6512007)(26005)(5250100002)(53936002)(486006)(106356001)(11346002)(2616005)(6486002)(86362001)(446003)(186003)(105586002)(2501003)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: HEijnbYzQuVrHnygBl2+u6izMujVXrmTNjvAFZWhMWxQYTJUaEJ6gr/BmmBGH56qPzUZ814J2Tjv6jNkMRCprjbI34dmJBET7YaHvs37BUlpew7K+N3Ufoe2HEhhmWjuV6aBBQDCLPKQrfKuWQ/YgPD2vpW5mG3mezL2G6Ew5xrwzC5uHMLTMdJl4y0imoTXrxT+pQ3kO6UHy6+relwjpJzsu+6Aw5tOALFaDFjyULTXDhev9EbREgoly85QOREhK1WlZy10VGOZiYNB1dsTEaEGGhr6uxSp83Ds5iu5GCqs3h94Z5bdjGSPDDOrKlHUneqFcHA4/jfFXOfpvOqK59CxhNr+Su3Fftef7EOb1C0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 941a3029-6399-41a2-6fa4-08d61aab2371
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:32:45.4776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

[ Upstream commit fada18c48d774b9e837928ecdce6a5d5fdd11ee7 ]

Make sure to clear the CIBAUD bits before OR-ing the new mask when
encoding the termios input baud rate.

This could otherwise lead to an incorrect input rate being reported back
and incidentally set on subsequent termios updates.

Fixes: edc6afc54968 ("[PATCH] tty: switch to ktermios and new framework")
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/tty/tty_baudrate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/tty_baudrate.c b/drivers/tty/tty_baudrate.c
index 8457bb941e1a..ebc797fc1afd 100644
--- a/drivers/tty/tty_baudrate.c
+++ b/drivers/tty/tty_baudrate.c
@@ -172,6 +172,9 @@ void tty_termios_encode_baud_rate(struct ktermios *term=
ios,
 		iclose =3D 0;
 #endif
 	termios->c_cflag &=3D ~CBAUD;
+#ifdef IBSHIFT
+	termios->c_cflag &=3D ~(CBAUD << IBSHIFT);
+#endif
=20
 	/*
 	 *	Our goal is to find a close match to the standard baud rate
--=20
2.17.1
