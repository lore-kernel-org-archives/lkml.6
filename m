Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8868C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 03:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84BA62152C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 03:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="B6EWdkZc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84BA62152C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbeI0KGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 06:06:52 -0400
Received: from mail-pu1apc01on0133.outbound.protection.outlook.com ([104.47.126.133]:32445
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726659AbeI0KFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 06:05:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMMdkAvpobM9yPpwcOIrH9VoI6bK3mTFqa/ckguBWJY=;
 b=B6EWdkZc5IulZjpdDYS/VrIQudgCnlbwG052znkwdrZSorDEmNGTfKlhmW31T5/9LKtjV3+/V8wzCk8yIyc9yqVCirPDgmALqHGcnHLcFYp+vL8mp/mxOQNwb8OICaJ9BMM1OCOqG2zvfrGgKo+eYMKbxFfD7IsvGvyU7bJkmqY=
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM (52.133.156.18) by
 HK0P153MB0177.APCP153.PROD.OUTLOOK.COM (52.133.210.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Thu, 27 Sep 2018 03:49:11 +0000
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::8584:ad93:130a:6267]) by HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::8584:ad93:130a:6267%3]) with mapi id 15.20.1207.011; Thu, 27 Sep 2018
 03:49:11 +0000
From:   Tianyu Lan <Tianyu.Lan@microsoft.com>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        vkuznets <vkuznets@redhat.com>,
        Jork Loeser <Jork.Loeser@microsoft.com>
Subject: [PATCH V3 4/13] KVM/MMU: Flush tlb directly in the
 kvm_handle_hva_range()
Thread-Topic: [PATCH V3 4/13] KVM/MMU: Flush tlb directly in the
 kvm_handle_hva_range()
Thread-Index: AQHUVhUMM7vZmqB5P0uFL9SQiBZyBA==
Date:   Thu, 27 Sep 2018 03:49:10 +0000
Message-ID: <20180927034829.2230-5-Tianyu.Lan@microsoft.com>
References: <20180927034829.2230-1-Tianyu.Lan@microsoft.com>
In-Reply-To: <20180927034829.2230-1-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com; 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK0P153MB0177;6:JM2Em5DUdYqs/oTXQCg+ioVBgvawgHNigZNrhVrfqV9veqfNMF1WUTBBzGdm3+6kXZkxU2GjOHCO8/EOe1sBBWxJC8PHyxy+XdfoBrd3CxC2IQMujmoN9euMefwnTqzp3v4/MBFxpK0BRbrHgbZwJqJYT1XdVtm9Nx5wpPuxPhtWACe1GnFbIsa6her4KvskPb9jZhVyc9zmw7WAnRxyfzQqXPeoS72IKKiMEBBvNv8bZMVR7gSupHMQTjqJJWJTbMsZLDlWqzZbB8iC2JgZVA6K31nSEU/y3WW3XAEUmAjTPeU97r79nvArpQB6s1tVdfmcam2Z0iR1FnSutYTB0887VgAxxGRYV51ywoxOpmak+l3oyJwvpsliS6Bf+CluwBX7uS5s2xs6wi6uh/R4v5P9zP8xbglCXEfuHNYrj6Zq+wsFLH9oeq7srbyGX89LigvHTv6VSqnlDAGrE8tXSg==;5:kJ8NIg4inEL1pMKy4tiurmMc4WVP/mzKO8ATPoBORB5UdV73HKeTlZKl09S0xcWILbXtNeGNO5Flf7mNyX+Lo+bEisAFznr/O4mkfv7NSxlVoA4DhHieD9qfCSUlQtrMdyFem8gtymDornRIqG3STaMTZqPqH/fnG0K+4vomljA=;7:6E09DFNpZYIJGUfcEUHBYMhItsre2e1btb8kpFTQcjv5ZjrppYG/f93+90gGzzsQPqsWyiB9o88KtZQ72CsQV4KbrriLGMZQ5IpSq8JeV3HK5eXjwYfv2oy3x7UU+MqDrWyDKFLgztvdSiLz1xJJ9vgo5ateWQvJJs385N7KK0q3V+EUzpVfveFYxM3636O7qCbw38PDLLxmONtUpgcghsrW1ignFsmxQTn+y3uz1p3iu/meYcaUI1g4xXUd/xmw
x-ms-office365-filtering-correlation-id: 2ae8cd92-67c1-43d7-9937-08d6242c2f56
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:HK0P153MB0177;
x-ms-traffictypediagnostic: HK0P153MB0177:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB0177093FF2FB1270EB8707D192140@HK0P153MB0177.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051);SRVR:HK0P153MB0177;BCL:0;PCL:0;RULEID:;SRVR:HK0P153MB0177;
x-forefront-prvs: 0808323E97
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(396003)(346002)(39860400002)(366004)(199004)(189003)(105586002)(99286004)(10290500003)(486006)(478600001)(68736007)(106356001)(14454004)(72206003)(81156014)(6486002)(8676002)(6506007)(1671002)(81166006)(6512007)(2900100001)(2906002)(6436002)(76176011)(8936002)(10090500001)(3846002)(6116002)(54906003)(36756003)(316002)(59246006)(102836004)(26005)(1076002)(5660300001)(5250100002)(109986005)(107886003)(11346002)(446003)(2616005)(4326008)(25786009)(476003)(22452003)(7416002)(53936002)(86612001)(86362001)(71190400001)(71200400001)(66066001)(7736002)(256004)(305945005)(34290500001)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0177;H:HK0P153MB0129.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: E8j2nNw0D/ZRA3qBszlyLJrBCkpTCtXwdrCU8pC/NQXZmMy/A9neOm6c9DTjOsSEb430iQOYHdYjc1m/shANdGpnzdBckQUtyP5/WGhZZiMrceEg01dYCNu6+TqZ3o93yHfPITUzgYM9NwCR9nKn/TKPy4ot9Kid6P9vGDn+5HwMkyO5p34Q49vn5IBBNpODgJRbrCK4zrlnjaOh/E8NUUnX17d39y8PjMl5PlMyVZ3CIOZ3am8Vt7aOQQgYWQsDxfAdSGHu5F28jKxlET0b9ccPyKkT0QX+WIil1S8GX/p+mAvUYFaVbFbzhIEmvIgMi5b9wSs72BwJsoa/AKwMzDmL3xbU8ajxJ+enqyg/mCg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ae8cd92-67c1-43d7-9937-08d6242c2f56
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2018 03:49:10.6436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0177
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to flush tlb directly in the kvm_handle_hva_range()
when range flush is available.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/kvm/mmu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index d10d8423e8d6..877edae0401f 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -1888,6 +1888,13 @@ static int kvm_handle_hva_range(struct kvm *kvm,
 						 &iterator)
 				ret |=3D handler(kvm, iterator.rmap, memslot,
 					       iterator.gfn, iterator.level, data);
+
+			if (ret && kvm_available_flush_tlb_with_range()) {
+				kvm_flush_remote_tlbs_with_address(kvm,
+						gfn_start,
+						gfn_end - gfn_start);
+				ret =3D 0;
+			}
 		}
 	}
=20
--=20
2.14.4
