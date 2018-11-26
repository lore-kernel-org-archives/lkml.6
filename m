Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F84C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D0EF20817
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="dQVBKuWx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D0EF20817
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbeK0IHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 03:07:53 -0500
Received: from mail-eopbgr1300094.outbound.protection.outlook.com ([40.107.130.94]:45927
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727107AbeK0IHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 03:07:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOyE4iRY0270WdLkpchm47IPLo3TEj3/P4ml4jZGVkU=;
 b=dQVBKuWxXOqo+UzsMe8IYcRlRuyQGf8xxr3kQIwoSwMrOgJ1+nyZ2oWQDtiRqJQKFPe0CxAQsOiaE+A1Kca6F0sroxZhUCr1C5+efXDnB1Bys7ftN8vSScPWQJ6a2StU8j3kTnZnPBbJuNTZ2BPmjoxpEdRAUo4Bvi7qB2DNv6Q=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0186.APCP153.PROD.OUTLOOK.COM (10.170.187.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.3; Mon, 26 Nov 2018 21:12:11 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::3d50:29f2:1244:8b4b]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::3d50:29f2:1244:8b4b%8]) with mapi id 15.20.1404.002; Mon, 26 Nov 2018
 21:12:11 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        KY Srinivasan <kys@microsoft.com>
CC:     "olaf@aepfle.de" <olaf@aepfle.de>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "apw@canonical.com" <apw@canonical.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        vkuznets <vkuznets@redhat.com>,
        Haiyang Zhang <haiyangz@microsoft.com>
Subject: RE: [PATCH 2/2] Drivers: hv: vmbus: offload the handling of channels
 to two workqueues
Thread-Topic: [PATCH 2/2] Drivers: hv: vmbus: offload the handling of channels
 to two workqueues
Thread-Index: AQHUhb8pO1CMOExZuUGVZGfhBLOv2aVijH4w
Date:   Mon, 26 Nov 2018 21:12:10 +0000
Message-ID: <PU1P153MB01694507DD4FB2097D76CA8BBFD70@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <20181126022821.11269-1-kys@linuxonhyperv.com>
 <20181126022958.11320-1-kys@linuxonhyperv.com>
 <20181126022958.11320-2-kys@linuxonhyperv.com>
 <20181126193503.GA25649@kroah.com>
In-Reply-To: <20181126193503.GA25649@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-11-26T21:12:06.8497006Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [2001:4898:80e8:a:c89a:7a8:d1d9:2c8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PU1P153MB0186;6:HThvjAm2AAiOBWehxMKjx+aG+Qc/jBiW47UrIbuq3G9hLcekTbU7jJXSwR/y4cKASJF55Q/D2FWnVUGPlJwo0JqIJP1+Wn6Lq4kbVLchMImhiBNXhKAAcyIYliFcZITHYhl7LLj3QEa5WQQlYFajuZ9nMvlTZyBXUXGVyJWbSvQAECpIzb/GJLgsIX4qYkBtKZLJeV4bD2YEzP7wR+5qHQepY/naPjP9o2a+NptFhxU0aiYBk405fIvJrkxMCQXtuipvy0VfmwK2hE+mvYU26RNGs6FR+AiftlBFeiZng8tne4gaUqihwnJvQB85zITdsdXBHxlwCtBkUamFDnPBpaSkN0D/AZCGyteYrCLQL1iK+XlFgUAm0gwUnnuS2aZEai8pDa2PYu53v3xCzIqAOzmub1vxuIHB0+U/kdzCQbDUSvtw3LU6VGd5BPqCnTDqXsVV6VQuF3OF6mEJgLplsg==;5:q46I6sx2iAfjp6M50qfYhrsPOnDDQvkVmuQLZ3lISdEAMZmlxJ4yUShFdhSO3T+VM3SX1lB2xnWxgxJFG3T0ZSNiwAHWLPEUHHlca5yN4cjH4K9K0WIb1IgnZ1P0cjZBDjAX3sgKucJEoZy4Hlqfg/7vaZCF9gO+Sr9qU7i+JPc=;7:XnK92NIwGf53kbA3/WRBl/SHgGxIXX2F+ABW4WTHkTwvZFLhRuk3E9IW6YYsWEDYNT4b2Pu5EPqUuyCcubqDacrjIF0Cfq+lO6hpw8w+WozlVXGtKi5m37EN6JO3rJeR7dQBXhr1GLygADmrLBAzlg==
x-ms-office365-filtering-correlation-id: 160db977-ce9e-436a-e497-08d653e3d4de
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:PU1P153MB0186;
x-ms-traffictypediagnostic: PU1P153MB0186:
x-ms-exchange-purlcount: -3
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB0186DEB79F20371BA09BABD3BFD70@PU1P153MB0186.APCP153.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(2017102700009)(2017102701064)(6040522)(8220035)(2401047)(5005006)(8121501046)(2017102702064)(20171027021009)(20171027022009)(20171027023009)(20171027024009)(20171027025009)(20171027026009)(2017102703076)(3002001)(10201501046)(3231443)(944501421)(2018427008)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:PU1P153MB0186;BCL:0;PCL:0;RULEID:;SRVR:PU1P153MB0186;
x-forefront-prvs: 086831DFB4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(366004)(396003)(346002)(376002)(199004)(189003)(102836004)(76176011)(7736002)(6506007)(305945005)(46003)(86612001)(229853002)(86362001)(74316002)(6636002)(68736007)(446003)(99286004)(105586002)(1511001)(5660300001)(106356001)(7696005)(11346002)(486006)(107886003)(4326008)(25786009)(93886005)(6436002)(256004)(33656002)(9686003)(53936002)(55016002)(6246003)(110136005)(8936002)(22452003)(54906003)(316002)(81156014)(8676002)(81166006)(8990500004)(14454004)(478600001)(6116002)(2906002)(71200400001)(97736004)(10090500001)(71190400001)(476003)(10290500003)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0186;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: KqEUi5V8SQHcfwSJ7O7C7gNWrssOrvmf27SkTmYzxmt7JfT+KXGeobbFisbvVFGDB0Lix1tmATDdfmMPLWctF2i61LyNIl1UmrpSvEjcFKr9eh8DaUQC70ee5bGEXlMDWan3XmyyS8sWunmI7ZmyxC3uqDM77Q/mqV7lm1HK5xu6dnwOuegArLJhojmSmino9/IZSrsjfj858mEimAYzK05UrlehzTXsxadXvXzeUPWz1Eo1hpTYMh7A7dQq1nQzvhPKBBIuiDQkG6YRj72I+BL86/6Tx0UlQ8QHq8i+1F/LEB5JhDObCeKQHXlRSgIjRDAAv3LH7XKlooZPxFicRfVg3V/KuBgnKuuEjL8J8YI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 160db977-ce9e-436a-e497-08d653e3d4de
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2018 21:12:10.9319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0186
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: devel <driverdev-devel-bounces@linuxdriverproject.org> On Behalf Of
> Greg KH
> Sent: Monday, November 26, 2018 11:35 AM
> As Sasha pointed out, this patch does not even apply :(

Sorry, I'll rebase to char-misc's char-misc-testing branch, which has had o=
ne of the patches, i.e.

4d3c5c69191f ("Drivers: hv: vmbus: Remove the useless API vmbus_get_outgoin=
g_channel()")

Thanks,
-- Dexuan
=20
