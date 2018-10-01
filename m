Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0EAC64EB0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA6D52089D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="WLuP0Abm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA6D52089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbeJAH14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:27:56 -0400
Received: from mail-dm3nam03on0101.outbound.protection.outlook.com ([104.47.41.101]:12851
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728839AbeJAHNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:13:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TaxC5X1mxKI1VZJ8HTJXZqzrjaHWTjb2m5br1uYF0Bk=;
 b=WLuP0Abm9d+w5pItplKa4LxHiGdNahmy0HVwte4Tt9jbmDx/xjg4paDuVmorBuEzg6pw23kimo4iYh9Qow5dy3Bmf9uumaGnA+YCdZeMdBHJ4Up4bzRjnE1nvrLfayLVfAzIWto4+W0KC6X/lIf7jLDLCCbJqY2by4IgeHXP0uw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0472.namprd21.prod.outlook.com (10.172.121.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:38:15 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:38:15 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Guenter Roeck <linux@roeck-us.net>,
        Palmer Dabbelt <palmer@sifive.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 21/65] riscv: Do not overwrite initrd_start and
 initrd_end
Thread-Topic: [PATCH AUTOSEL 4.18 21/65] riscv: Do not overwrite initrd_start
 and initrd_end
Thread-Index: AQHUWR8KV9ghGIIsIUC/tNCxkhg1LA==
Date:   Mon, 1 Oct 2018 00:38:15 +0000
Message-ID: <20181001003754.146961-21-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0472;6:v4LGF+u0dodWMeCGsO/Tf7wTmTAEgDYx5SfVyl/J9LZL7JOTcz7nsaRVsmShEPjIxBv/1tUw3UCzidxqLKEO5Jyhsk764twZf02poMJyr3jBrJqBKW+hdtC4Rz4VBGjOE+yngHnlrvzjWmUxyDl53AUy4sKEVKUhTHdnJtjuTDRuScIIythgyGyp4qcwBQ1vdlllSSV5J72mj2KCTS+BeJeHqxQLzxoHZvv7ZNt1ZMMUNmU6UKKEWryASE/TikI9Jui4g8pkPs9/TK+3IXMnu3/CXSZQyb1igvvxyeUrn4tdtRpi5C4OXmVLpNv9zBHplHAt9hzTR+TOT38WjrahyT/pgRda/UpQul2ZrrTIYOPHh+/eefzDSMfq08Wd3vIjny2AysqzUWjk7AqarSB24opoucflrOf4nFy0QNMz53fbUdO3px06DJJ+GhQCdivKRqfr2eBzIrBbwjDEdxFFag==;5:rWQuNem6hKRrBX00h8kJCr+41QIMwm7n9vJoeZujXfahemb2VWMos17w8jBFF7tj67Byv99wUuKbujTzC+ZVDVWdOjmxSsHFLRJmg1AmzeRYUzIW1D8GqlQS6Nnhy+yZKOSaQsQQQ/vunMVY81/ktPpQZKZb8IRW1SFqZuonDIk=;7:Ttm5+c8K/HkUp+MfOrx0rIdIK5ZpA+j+FPLqO2tE1net9B5/1PN2ZCE5wuMf/yl5zAABGzTQ1mT4A9tGEtX5SBncoc/9XIToUK6dpaLCqVhOXIVstM7NjxvNYY0djEOCYDSxZOvcTDxwBwwSmr1V3lmN6bDApPtWASe3HVqAIhBvRup7q3375ULvB786JIAQ4Dyv3D9+kgFr+IVi+DaFOeXUhKFhxOUYNpieJgphAKBDDfTV0JdpaIWEnn10UlHO
x-ms-office365-filtering-correlation-id: 55635c18-f026-4b5b-7900-08d627362d34
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0472;
x-ms-traffictypediagnostic: CY4PR21MB0472:
x-microsoft-antispam-prvs: <CY4PR21MB0472CB0F680D26388941A604FBEF0@CY4PR21MB0472.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0472;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0472;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(396003)(376002)(39860400002)(346002)(199004)(189003)(5660300001)(6486002)(8936002)(68736007)(486006)(6436002)(2616005)(6506007)(6346003)(8676002)(6512007)(81166006)(81156014)(5250100002)(6116002)(2906002)(3846002)(107886003)(2501003)(1076002)(22452003)(478600001)(102836004)(25786009)(4326008)(97736004)(10090500001)(11346002)(256004)(14444005)(106356001)(105586002)(99286004)(86362001)(575784001)(53936002)(316002)(71200400001)(71190400001)(305945005)(2900100001)(217873002)(7736002)(10290500003)(14454004)(34290500001)(446003)(66066001)(72206003)(110136005)(54906003)(186003)(86612001)(476003)(76176011)(26005)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0472;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 5sdVVblEsg6ZOdJEKJzLIbOMOWi2OQmAkbEyRGHPPJd4ZEdBd1Neqkmevbig0KJLNDffs7jBVwz7XQNWTQ07TCKugBfgBWNhnTMlHcNGoAIWTRN+MPV1E6cCByQThJZuIMEG2ekWC5IBepPuBSDlVNjZJXxBNl3xo8cHpydWpUlpD5dJ6948l0+c60l/cYsNyoEAyyMSWB6uYvrR1/CtfXQ5Kz10G3HfeTVYBWTcFYnkKiwqpA3HcoGvpy9oyipSjrU90pCsn9gWK5TcW7FpQGr5BTreBlL5Aq9WCXVbVdTyGFeTkc6SgK6huOFYYAVfYAhNK2iTwH/uHrhNFaRYlsGb8ksBH8E0Z34A0RXcJt0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55635c18-f026-4b5b-7900-08d627362d34
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:15.8113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0472
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit e866d3e84eb7c9588afb77604d417e8cc49fe216 ]

setup_initrd() overwrites initrd_start and initrd_end if __initramfs_size
is larger than 0, which is always true even if there is no embedded
initramfs. This prevents booting qemu with "-initrd" parameter.
Overwriting initrd_start and initrd_end is not necessary since
__initramfs_start and __initramfs_size are used directly in
populate_rootfs() to load the built-in initramfs, so just drop
that code.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/riscv/kernel/setup.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index f0d2070866d4..0efa5b29d0a3 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -64,15 +64,8 @@ atomic_t hart_lottery;
 #ifdef CONFIG_BLK_DEV_INITRD
 static void __init setup_initrd(void)
 {
-	extern char __initramfs_start[];
-	extern unsigned long __initramfs_size;
 	unsigned long size;
=20
-	if (__initramfs_size > 0) {
-		initrd_start =3D (unsigned long)(&__initramfs_start);
-		initrd_end =3D initrd_start + __initramfs_size;
-	}
-
 	if (initrd_start >=3D initrd_end) {
 		printk(KERN_INFO "initrd not found or empty");
 		goto disable;
--=20
2.17.1
