Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB74C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 157992083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="o6ypWUra"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 157992083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731235AbeIGFU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:20:26 -0400
Received: from mail-by2nam01on0120.outbound.protection.outlook.com ([104.47.34.120]:44004
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729702AbeIGFUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:20:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0RMpxYC/9e+m8EWL1tXpjzg87Fobt7SIZIw6BbB3PY=;
 b=o6ypWUraC82Qdfrog4zDmhBYOApPQrU7tsLM4HGu2nROXky4BSUzmoUcG9DdZylbY38sD2Y1TfI5CEwdHPYjRAEdexcVe5Z/Bpz61XUgPXDY/21WxnsbqEXCwg8f4UJzbHSBpfw2BY32hoF/1tTTHeD7rHD4HK+aYO8FT41yu+c=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:42:06 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:42:06 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Julian Wiedmann <jwi@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 28/30] s390/qeth: reset layer2 attribute on layer
 switch
Thread-Topic: [PATCH AUTOSEL 4.4 28/30] s390/qeth: reset layer2 attribute on
 layer switch
Thread-Index: AQHURkM1/w3Mp5rIAEqzs58O/nZAJg==
Date:   Fri, 7 Sep 2018 00:39:17 +0000
Message-ID: <20180907003853.57942-28-alexander.levin@microsoft.com>
References: <20180907003853.57942-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003853.57942-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:dR/IuZTyqg8S3L3x240xFBE9lWNZIRoauMVrQO4+TY2c0Q00NlYsgj5HeuON8deMImIiiyvx78BESEfBMzniTZcH86GNnar9Qf5w/tSAPg9u3d2sSZA0aozIrwqxto60UsLevgsKbO6BpcIlPizB25kl+XoAPtozTt2Ub66kWP1lTPlFqxqVYtl/TKO2E4smwRZjn/QBiGs2KrXtfV978m7Ebdd2/kelwnXBB8RpX2x/6duPZgY/cpdaR6kiXRnE9ypwz8f24uSaKR+FZxtLXoSff0KCE9LOxzKoAeOKsy0kmHtKXpVYLohVf3tCUZaANaReRhNJtYBn6BQrDHg4qiCcFpmuWuxqjVNDyyupcVlJGOioLH2n9npInNe5R/TzcZhkmUQNhWmIUBL/R26lzH31KeF9IWd5VO+pGfyXJSYNWXnz8bvv7jgYyb8uXhvNH6sz04l6cRuoIKkz+VUsOA==;5:ZsA27ZIMiQ9qs868eGmDzSxh9uFsa9+RVLh0vKZj+yrcCZvr7+n8ZiEPDXPRqxpWXmTkHMHdglcEiziH3tvVriqC+uQbbqA9PX58lLLd2ctscxHU2aqo5pfgwjsag47QjjWecMAWuEMyFMQM1256KkWIB0VnNQTGRcrrFoiEOQ0=;7:PYSLmtzP49lD+Gf8HWi0Pkzi4YfYa8gbQOFBt0TyH8132MPhHUaRF7WEjfrk28hfL93q0v+qREdf/fmzTxXYWgdfZfJl7624WX3O9rdqNZatUbIIXxtCKTZl6Tc7dupDGuJy5bZOzFrXDATBf2gwiO6EowweQgm0XM9HH08R9zRuCjna7Q9ZpeweXRz6CTjpcuLidpnPCQ01+p3kc4zFffywfakgl51qDlljn3SwldspxG1Qq7fefQD5P6aLGmyR
x-ms-office365-filtering-correlation-id: eaa88a16-9e6e-4ca8-06f0-08d6145abcdb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0822D2DBDF46B38D971EDF8FFB000@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(136003)(366004)(199004)(189003)(6506007)(10290500003)(478600001)(102836004)(81166006)(14454004)(22452003)(6486002)(26005)(53936002)(186003)(6436002)(72206003)(2501003)(5250100002)(110136005)(6666003)(54906003)(3846002)(316002)(6512007)(36756003)(1076002)(97736004)(8676002)(81156014)(6116002)(5660300001)(10090500001)(76176011)(2906002)(256004)(8936002)(2900100001)(99286004)(66066001)(305945005)(7736002)(486006)(217873002)(68736007)(4326008)(25786009)(476003)(106356001)(11346002)(107886003)(575784001)(446003)(105586002)(86362001)(86612001)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: uzWPMvn5aTY+HJPqyrO7YKNFKLS4pA7nTPVfMP1NRqhnlFcAI2BpI11zd3HX9EO1gDRnznbzfj8TWRd5Hwlw66CTjVFEARnIszOc8g7JmSpzfrY+j9PrKmSZRN0RU1wpFXiga11Ri6pjuv/PzL+XcYfBzFXSZcstLZ2xEAS0w8NCa5XASEfFbXdh8aF7ED9+lr2/ZQo/yILjLL5Ibmu/PZveDF644ENWkO9rv106NT9tFUCJGA7W0xmwyb1YodC6Nt0vaUlqhAEpOS6vZM+pxIPwbgslturcewmPseARW3DNBs+OBMhVFikHvOKv6KJVR4nBzZs2V/S428vDE14Sp7eExl7hvbkKLMsVH08hOCo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaa88a16-9e6e-4ca8-06f0-08d6145abcdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:39:17.6568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julian Wiedmann <jwi@linux.ibm.com>

[ Upstream commit 70551dc46ffa3555a0b5f3545b0cd87ab67fd002 ]

After the subdriver's remove() routine has completed, the card's layer
mode is undetermined again. Reflect this in the layer2 field.

If qeth_dev_layer2_store() hits an error after remove() was called, the
card _always_ requires a setup(), even if the previous layer mode is
requested again.
But qeth_dev_layer2_store() bails out early if the requested layer mode
still matches the current one. So unless we reset the layer2 field,
re-probing the card back to its previous mode is currently not possible.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/s390/net/qeth_core_sys.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/s390/net/qeth_core_sys.c b/drivers/s390/net/qeth_core_=
sys.c
index fa844b0ff847..7bcf0dae3a65 100644
--- a/drivers/s390/net/qeth_core_sys.c
+++ b/drivers/s390/net/qeth_core_sys.c
@@ -419,6 +419,7 @@ static ssize_t qeth_dev_layer2_store(struct device *dev=
,
 	if (card->discipline) {
 		card->discipline->remove(card->gdev);
 		qeth_core_free_discipline(card);
+		card->options.layer2 =3D -1;
 	}
=20
 	rc =3D qeth_core_load_discipline(card, newdis);
--=20
2.17.1
