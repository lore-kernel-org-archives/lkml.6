Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A512C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F5121522
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="n/t8FZlN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45F5121522
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388613AbeITIbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:31:14 -0400
Received: from mail-sn1nam02on0096.outbound.protection.outlook.com ([104.47.36.96]:62018
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388598AbeITIbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:31:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fujRDGyfHbJgJcfmlot/211MA/swvBvA6eebiM8w3Gc=;
 b=n/t8FZlNLsZXos1M0bHdS98GMdBbGDW7G/S36KBFrv7GHWKmGM36A+4qd7Cmghcoq5WHv1oxHw9cznwhkS5iZWAOlYOnxoe14vlHtqHpO8R5idD12IFEjEAr+HZHnheUM6djIKheku4A/TQ2w3+QYXjX7uBAoch6GHJr7gV7qoI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Thu, 20 Sep 2018 02:50:06 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:50:06 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Bo Chen <chenbo@pdx.edu>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 4/7] e1000: ensure to free old tx/rx rings in
 set_ringparam()
Thread-Topic: [PATCH AUTOSEL 4.4 4/7] e1000: ensure to free old tx/rx rings in
 set_ringparam()
Thread-Index: AQHUUIyS9cTxYDRC30ScHn8UWU3FPg==
Date:   Thu, 20 Sep 2018 02:49:38 +0000
Message-ID: <20180920024932.58727-4-alexander.levin@microsoft.com>
References: <20180920024932.58727-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024932.58727-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:2KZ9JZVHn1a076dMbVMU+FcQJwW+KiiYXcljnKfeah+fHwp92HIdTuIvBVGplMjIXRIyy59iclFcoO3CtMkuzZZjYa8NXevlM6pmIr4pJ2jnn61O2kv+3PZzpp2NGOGi/hPT/yqfjJSPpeqhmOF7+GGmyIZJTZqtZWc76oQByqYyUPsuL+FfkzLC+mCo7aU5UKgFC0sHhI143Ex3AWYjSYgHTZzfrwqzEKjeHU8tXeoCbXm6YbhnIlblX3U6rHCQWfzQlWx5WIlypsrP79y8mhLlyDjh/6Hrg/t6ZKoa+Fe7/IYykNIkoLwjPW4eYBwDuzq/jGyF2kp5psoTTJqrK3EOKipBhBqsSghgHnwAOZXtrDuObgbXl9kNu/CSn0LItvKqOTNLj6xgZj9ebqLUyJs5/1+aAms9VCvhP9O76Jw9OT9IYm9hlHyd+6vALrfz1/k1DNYHHhsJPMzpqUs/Ug==;5:iETrAnSZjuyh3nnJqV1Sykw0sKy0d4kvUDsVZiIdmYxXVlHZF2hbifTGVmk1S5xoFLqvJa/cZMWyB5YiqYVDAj9M3UobjjMoidWppgp7oLNj8w3zu5V303YbMILreGniHjfvU53FH1sHB3A3hxsWK9Hcpz+/BvDwhBLDPlqnYfA=;7:aJVerN6wPprgTVvhGUvooHTbG8kk7EdbLsJMc1GdyNb5fLe4JmDmoyNmMMd2ODeU7CN+i3Il2pdA8ssfatY4ADaHsTDyRkgskxd3/d3D1wC4pTH8hk8olviGkevZOHw84QQXpBs7hyFNd74ME9eH1JDj3AWcBVkfqv66ryDYuoNmTXlTxhuRgPY4J8aautbcS0wSf1IRX2GniqcviEWkwv0GPA9BXB8nBNEjCMqypKj1arbcqL6r2a8sbTPUEhfg
x-ms-office365-filtering-correlation-id: 0eaeb2c6-1380-4666-0bde-08d61ea3c5ce
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
x-microsoft-antispam-prvs: <CY4PR21MB08557476BBD8C470223A7388FB130@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(240347492878265)(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(346002)(136003)(396003)(376002)(189003)(199004)(2501003)(186003)(86612001)(10290500003)(478600001)(2906002)(86362001)(6666003)(106356001)(3846002)(5660300001)(2900100001)(6116002)(8936002)(105586002)(1076002)(53936002)(14454004)(7736002)(305945005)(81156014)(81166006)(8676002)(6512007)(68736007)(72206003)(6346003)(107886003)(102836004)(26005)(256004)(6506007)(36756003)(446003)(476003)(2616005)(71200400001)(71190400001)(486006)(217873002)(66066001)(11346002)(97736004)(25786009)(22452003)(5250100002)(10090500001)(6436002)(316002)(6486002)(110136005)(54906003)(99286004)(4326008)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 5CDJkKCKaB/M3pXw+AmjM7WdgyvCbuIpiw+sa1JsSNqVJHkCGg1hsz6uLxAhx+bOZrpYeDVWsnyWWVXl/7xw9ku47VVqxIdWBFoBCGvtyFOSAHcJoDFUDmHx3S2chhAF1spwW+w9nNv/UWYOeWfSJGiqzotyLx0OXvmW/HVan2VC/YmT/EVHWld6d948NmYpOwXgHZZtK8h4m7ZDZwYvefzvdtYDSuWBTNGBJCVE8VZIojAwFyB3MRmhq0HITUge/nN1x5yI1gDCDatZgQC+sNDHUiPmyjnD25fXl6gdttjI+fLb5IheYAg4PRHP4jgmA4jB/gv/c1+Ma/T+RyjLSdfFd2smRrHUcCxmhY0TKt8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eaeb2c6-1380-4666-0bde-08d61ea3c5ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:49:38.4281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bo Chen <chenbo@pdx.edu>

[ Upstream commit ee400a3f1bfe7004a3e14b81c38ccc5583c26295 ]

In 'e1000_set_ringparam()', the tx_ring and rx_ring are updated with new va=
lue
and the old tx/rx rings are freed only when the device is up. There are res=
ource
leaks on old tx/rx rings when the device is not up. This bug is reported by=
 COD,
a tool for testing kernel module binaries I am building.

This patch fixes the bug by always calling 'kfree()' on old tx/rx rings in
'e1000_set_ringparam()'.

Signed-off-by: Bo Chen <chenbo@pdx.edu>
Reviewed-by: Alexander Duyck <alexander.h.duyck@intel.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/intel/e1000/e1000_ethtool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c b/drivers/net=
/ethernet/intel/e1000/e1000_ethtool.c
index 52129b214c09..5ae8874bbf72 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
@@ -645,14 +645,14 @@ static int e1000_set_ringparam(struct net_device *net=
dev,
 		adapter->tx_ring =3D tx_old;
 		e1000_free_all_rx_resources(adapter);
 		e1000_free_all_tx_resources(adapter);
-		kfree(tx_old);
-		kfree(rx_old);
 		adapter->rx_ring =3D rxdr;
 		adapter->tx_ring =3D txdr;
 		err =3D e1000_up(adapter);
 		if (err)
 			goto err_setup;
 	}
+	kfree(tx_old);
+	kfree(rx_old);
=20
 	clear_bit(__E1000_RESETTING, &adapter->flags);
 	return 0;
--=20
2.17.1
