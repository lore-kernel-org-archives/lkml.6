Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B34ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B93E2208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="LtCRarln"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B93E2208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729520AbeIQI4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:56:20 -0400
Received: from mail-by2nam03on0112.outbound.protection.outlook.com ([104.47.42.112]:14944
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729336AbeIQI1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:27:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+b87wHcsbQ49Yz5gjabW+s+EmO9fPz3fpblunJEZbq8=;
 b=LtCRarlntRtanZaP59inJke8XfkfBm/OiMseLcod0KTA8ieuinp0QIKhAW0MSK0SH4Z1FsCRmvmjFmOdDqE1P+5nzPGCQvQoMQ0+rQzY+i4IktPcNkjecCpeYo6RcWnLXrJ8uCbgn8K6AMLtyB1dtY98Xp9wvt9FgCSMHRoSvA4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0502.namprd21.prod.outlook.com (10.172.122.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.7; Mon, 17 Sep 2018 03:01:59 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:01:59 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 078/136] drivers/tty: add error handling for
 pcmcia_loop_config
Thread-Topic: [PATCH AUTOSEL 4.18 078/136] drivers/tty: add error handling for
 pcmcia_loop_config
Thread-Index: AQHUTjKqAPM+hukgfUiVpdSKaGCeKg==
Date:   Mon, 17 Sep 2018 03:01:00 +0000
Message-ID: <20180917030006.245495-78-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0502;6:kofy2gjkBucCCbuPQvWNhOD8cSThvw6BFPHyVxybHvJ+Mn/V91gXwEUBHkv23qOnfR6Uc9ZEBI+KY2Fe0ry5IGYmEG5eH2xTP3h8DcRMpjcgfa6N6UxniUoXGfkQm7LIjxFFL4IGlkuI4fW3oPJjZhmqGO0XCf91FfwJ3P8D4YDjS7yDL4rGZuMSfgnbrKWxOMoS7a7OvFaOohN9AhX19c+8xaGpmsL7I+l0U8uP+ZEisAXorfmeMvRwcsarLRpL4c6w//7V3NUROWLnAKzPseDu96yP/zffzANb2WH040h+uwyuXvx58xzED4sZjZIj98KxlmVw5wQpsQeFgF+Iev/aMGeo/philgT1o/41CV4/hwokbEb0I0mf1M/PIAdyzOSOd00W6UDEqgsGw2UcmQrh++QIju8lbj1iPsgVMI87EUFVhMf3g9wNmlOibcTDEPxly81k2PxykSu4v/ZkKQ==;5:bKM6qnvXJuPgqDFBbSe7R1CWZJNIefKmS+xVrUe9H6ocrVzXJ5TGfssVaSa16ksEG2br211tUxspSUGXz/R9i4LYBvYMDV2zK0sNxzIOpkEhWBGoeUyF0EIQIQXHMhcSSESH0NPIKSXx5lMXzDjeQNy45c0FUEZ1scLkQkBcPn8=;7:byplHJKgoTWvFk8gJsemBE1xc1bPZtrC1TfbvTIPVOQbKkDmk7DOr3PRhlvbPMSfkz3e5s5g2TPNe/EDb/AbZ+DxKsQ6YQuDAS+v6jk+AK81kRBTG10pUWPTVJgiQj0tIVcq0Q/JIYdos6tGbtylnqxNVlGteJ5Dwd0fwu43ZDDZmmPcxhNBdJ1tDXYAVYaXaqu9bOr76uzAxK1VQmZLfRA9uf5JGc+DTFOx9/NU66wZ+b/Zzs2afESM61LqIXve
x-ms-office365-filtering-correlation-id: 718f5846-c0fe-4fcc-6e67-08d61c49ef66
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0502;
x-ms-traffictypediagnostic: CY4PR21MB0502:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0502E348289461C32E7F220AFB1E0@CY4PR21MB0502.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(2017102700009)(2017102701064)(6040522)(2401047)(5005006)(8121501046)(2017102702064)(20171027021009)(20171027022009)(20171027023009)(20171027024009)(20171027025009)(20171027026009)(2017102703076)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0502;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0502;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(136003)(366004)(376002)(189003)(199004)(86362001)(2616005)(99286004)(5660300001)(1076002)(6116002)(3846002)(6666003)(10290500003)(39060400002)(2900100001)(72206003)(68736007)(8676002)(22452003)(26005)(217873002)(86612001)(486006)(76176011)(66066001)(102836004)(2906002)(476003)(186003)(256004)(6506007)(446003)(11346002)(36756003)(316002)(5250100002)(6512007)(97736004)(2501003)(107886003)(110136005)(54906003)(6486002)(8936002)(53936002)(81156014)(81166006)(10090500001)(25786009)(305945005)(7736002)(105586002)(106356001)(478600001)(4326008)(14454004)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0502;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 78T4ERFgVj0ITJFO5qLvV2mSb4447uU0j2rkU+AxZ4pUmDd0B8wDA+WzW7hhqca80lTEVgazNSqgzd8tJmUVKC6+CcYAUwcEYc7GynBT9/nVTFZsRAyIxAWgRPzoXjk29NdIaA2zDmuXvZrcTTr2iEaaqhQwMSPZezZwDYnY5Whw5gFMPBYx1B3kpkgOf/Aj8+tdqVSqDWGliEUog4SFUTwinLPreNar5kBry15UT2PYHk+AIi4B8oD8lRoNFUeIsCl7j9SbLCl/DJm2+qzVZ/vRLlzDe2AQWKNfaAzzqyowfximYAhvTL+hi8gJ3L4ow/FbDbdcIK4zStrvevnef4ER8/NwDZldiVpQyQEvaz4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 718f5846-c0fe-4fcc-6e67-08d61c49ef66
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:01:00.9950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0502
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhouyang Jia <jiazhouyang09@gmail.com>

[ Upstream commit 85c634e919bd6ef17427f26a52920aeba12e16ee ]

When pcmcia_loop_config fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling pcmcia_loop_config.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/tty/serial/8250/serial_cs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/serial_cs.c b/drivers/tty/serial/8250/=
serial_cs.c
index 9963a766dcfb..c8186a05a453 100644
--- a/drivers/tty/serial/8250/serial_cs.c
+++ b/drivers/tty/serial/8250/serial_cs.c
@@ -638,8 +638,10 @@ static int serial_config(struct pcmcia_device *link)
 	    (link->has_func_id) &&
 	    (link->socket->pcmcia_pfc =3D=3D 0) &&
 	    ((link->func_id =3D=3D CISTPL_FUNCID_MULTI) ||
-	     (link->func_id =3D=3D CISTPL_FUNCID_SERIAL)))
-		pcmcia_loop_config(link, serial_check_for_multi, info);
+	     (link->func_id =3D=3D CISTPL_FUNCID_SERIAL))) {
+		if (pcmcia_loop_config(link, serial_check_for_multi, info))
+			goto failed;
+	}
=20
 	/*
 	 * Apply any multi-port quirk.
--=20
2.17.1
