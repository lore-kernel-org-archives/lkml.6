Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57D7ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 16:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E2BF2098A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 16:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ZxJJE9Qr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E2BF2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731668AbeISVrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 17:47:37 -0400
Received: from mail-by2nam01on0128.outbound.protection.outlook.com ([104.47.34.128]:58225
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731402AbeISVrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 17:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cs9dBbwunuFFQMLdmWocRo3cy6cGil7csKfcj1alxco=;
 b=ZxJJE9Qr5Yo+1HUtBjmUBiATkFKPLP/GV1z7FlzImLPQYNgg/2cO/Y19w44MXhtemUepcR3PA1ilqLJeU9yK1CRSdzlvFghp9N/7J93FRG2bgJOgG5sPO8Qer8391daZyotkbGe53cAXPkLUq2e1vQ0tdqT4LdS6C6K59U3fJ/Y=
Received: from CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) by
 CY4PR21MB0134.namprd21.prod.outlook.com (10.173.189.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.9; Wed, 19 Sep 2018 16:08:58 +0000
Received: from CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::d1f6:46cd:d8b4:880c]) by CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::d1f6:46cd:d8b4:880c%5]) with mapi id 15.20.1185.003; Wed, 19 Sep 2018
 16:08:58 +0000
From:   "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To:     Tianyu Lan <Tianyu.Lan@microsoft.com>
CC:     KY Srinivasan <kys@microsoft.com>,
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
        vkuznets <vkuznets@redhat.com>,
        Jork Loeser <Jork.Loeser@microsoft.com>
Subject: RE: [PATCH V2 4/13] KVM/MMU: Flush tlb directly in the
 kvm_handle_hva_range()
Thread-Topic: [PATCH V2 4/13] KVM/MMU: Flush tlb directly in the
 kvm_handle_hva_range()
Thread-Index: AQHUTv5LoppePkpNT0ychcducOMOjqT3x7YA
Date:   Wed, 19 Sep 2018 16:08:58 +0000
Message-ID: <CY4PR21MB077308B3F20B235B994FF6A5DC1C0@CY4PR21MB0773.namprd21.prod.outlook.com>
References: <20180918031754.113013-1-Tianyu.Lan@microsoft.com>
 <20180918031754.113013-5-Tianyu.Lan@microsoft.com>
In-Reply-To: <20180918031754.113013-5-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-09-19T16:08:56.6767536Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0134;6:cpQG6bQ5exKOmeFYSQHTWutQMs02E0Pa2jU36ITyeD7fsJqOscDKxUB72C+MCwYlqDh/vA+CO0Ac2sdjjXzcyd1zjOTcwhe2ctx+GTIs3wSqzer49vS3nZIApwdvEfSZKmW91KSCT8gEAGJqqtOSTzTiaCsDCAWhhGrqDG5gim0wQjZ+YKtc8hXzKZkRKpafM21fWCVlrSUuFqsBIUIzogfZRTymIRfR4YK8TizbzFkevYGKOku7mN/3yq+n0+sIwP9LvMT9/YATRxSg8zkacNmirmES5+UJkr8xccxprA32o24FU1CDNhIc+/fCHi0QnZ7npxTgYcyDVtU65tet9ES6HzePoTS1ju37CXFcfz+LCMLRkQ2fTHi3cNJsNkkloZOmrmMPQwvubBPmM4Xr0IwkogIspwh8JMVXwGFHp3UndberB4eyoRb2jJ4+2ccfIZ3zJXeG2pP+1+8060mIhA==;5:2h0J/+IUFGDIsw5xTur5pgvEtKjxbuO0TqrwuA2T7x5aZue/KLy89sQK4dUJ61m4pxAwYB3kbRH1CSEE4xfZ0q7VsrhD1WP9mY41j+dwGrGRA6jhyR0Wd60OEUN5tvgd2Pffz7kM3l9il7aokNvwCJHuAhlkVYbIzAfE9D3raxM=;7:tZ83deRmUi0aSdG0R5sPkwHxf0nIgKB1c0XGbQkDprdH1hYFt9dUR1EDUHM1y3tyrzh3KY9XJlu/L8iSMNWxYKexZzjsuMK3wpzM7x3rcm5HCbviugm5dhAms45IMKqwSnMIZNZGMoZfzugwlx2PhfGJ5Kq/rak17X7lo6e4380eE9KXf0GZn5ik4lLX8nSQog7qogODvwQHIf88qzAAN6Rj8w4FRbvnEy82JSgk8PzzUdGbJBldwmSqZ5QSMkpI
x-ms-office365-filtering-correlation-id: f8bddff1-caaf-4f09-a3b9-08d61e4a3514
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(2017052603328)(7193020);SRVR:CY4PR21MB0134;
x-ms-traffictypediagnostic: CY4PR21MB0134:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB0134C170F6EF98AA1E12FBA7DC1C0@CY4PR21MB0134.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0134;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0134;
x-forefront-prvs: 0800C0C167
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(366004)(39860400002)(136003)(189003)(199004)(486006)(86362001)(446003)(55016002)(81166006)(8936002)(81156014)(8990500004)(6436002)(25786009)(11346002)(476003)(86612001)(478600001)(2906002)(3846002)(102836004)(6116002)(10290500003)(26005)(14454004)(72206003)(53936002)(9686003)(10090500001)(229853002)(68736007)(107886003)(6506007)(6346003)(66066001)(256004)(76176011)(305945005)(74316002)(2900100001)(6636002)(6246003)(1511001)(106356001)(7696005)(97736004)(105586002)(558084003)(4326008)(316002)(8676002)(54906003)(5660300001)(33656002)(22452003)(7416002)(99286004)(5250100002)(6862004)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0134;H:CY4PR21MB0773.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com; 
x-microsoft-antispam-message-info: l6OjhC7KHYloMaSpSfvGx5ek2PvvkA+cjgRepQI/DHX21XuYDYRRKUgbyQWYPDigE8753QUMZwy0eiV/DBCwbnTTAWr9MjQBxeWSwkHK9cXAtnD/sjUQ7LRXPGGgr3VNsS7OF+HOJSlQQUdyIXTuXjnviQ51yA2lPUlwJ2wjDgp3DA3vvpfXsqlPfw+c7j7WlBYZxGS7EzhWeMFvNPTXwm4ozaP2fr88sTULsaqQD3sjoRpPeI8sKWjJLlsyV9Jy0ACob+vGu3B1xNhV/Z4AtkmagRlZ51riTkGCV9pxOidlzlyEtsR/0xdiwEOIfA1IhLJ7FrR/qLn7KV8W/ZbFLCkHJFa2jj3utXBKx2morSg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8bddff1-caaf-4f09-a3b9-08d61e4a3514
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2018 16:08:58.5251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tianyu Lan  Sent: Monday, September 17, 2018 8:19 PM
> +
> +			if (ret && kvm_available_flush_tlb_with_range()) {
> +				kvm_flush_remote_tlbs_with_address(kvm,
> +						gfn_start,
> +						gfn_end - gfn_start);

Does the above need to be gfn_end - gfn_start + 1?

> +				ret =3D 0;
> +			}

Michael
