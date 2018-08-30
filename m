Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6E7C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 00:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1419420671
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 00:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Wj4ZcU37"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1419420671
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbeH3E63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 00:58:29 -0400
Received: from mail-pu1apc01on0118.outbound.protection.outlook.com ([104.47.126.118]:58056
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725836AbeH3E63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 00:58:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGBvWKU8b0bc7/9cYPpxO3F8OyWbBr40y4XRmEge9b0=;
 b=Wj4ZcU37Qr+TlB3XfXe/kB8JZtiJJiKFOfnm+XmQolnagL+d44il1Cx+2q+uFXpmtaCdmeRbb1gLOeConS2ye7b2K+uKnQk8DeHhkIojd4W+FzsOWRqnAr0VT37KQG3C4P+8g/i4lQs02fZg9Ee+nsYZ/Tul4+X2KtlG9U+9BQc=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0139.APCP153.PROD.OUTLOOK.COM (10.170.188.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.1; Thu, 30 Aug 2018 00:58:48 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::b835:d23a:7cda:c4e1]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::b835:d23a:7cda:c4e1%2]) with mapi id 15.20.1122.009; Thu, 30 Aug 2018
 00:58:48 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     David Miller <davem@davemloft.net>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        vkuznets <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        Josh Poulson <jopoulso@microsoft.com>
Subject: RE: [PATCH] hv_netvsc: Fix a deadlock by getting rtnl_lock earlier in
 netvsc_probe()
Thread-Topic: [PATCH] hv_netvsc: Fix a deadlock by getting rtnl_lock earlier
 in netvsc_probe()
Thread-Index: AdQ6XXUw8kE8DKeUTSmE1/NI7CjYQwFnbziAAAAsndA=
Date:   Thu, 30 Aug 2018 00:58:48 +0000
Message-ID: <PU1P153MB016903725D5E8EF56C07FF69BF080@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <PU1P153MB01692432D92B3A726FBDDC68BF300@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20180829.174841.833303774555397982.davem@davemloft.net>
In-Reply-To: <20180829.174841.833303774555397982.davem@davemloft.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-08-30T00:58:44.3896877Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a27f:df20:bdf7:7909:bd8f:3027]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PU1P153MB0139;6:tydU5Z9aJUpWxo21aTf3kj+f6tjaxbL9C2LWS5efeID4XYmmz3XaPmX9zO1z01Ruc781NZ7P++adX0rQw5JjxXynp3OpBIrQXwgtEUFbIOMjaQWD1y5DiogKZvl/5Cy6ufYabjwgpzJJ9xE04wUwRCmPMccUb0r/0tvSIZvGAnnEMdkPbGiasS4AvYtTmdc0XtTq2dUIm566ippF/pu0LOk74qHwKrVM1XUv5d5Oo1foDuohAlfie2V+vqznsZNqm+yqZI1iPPtfp6kxzomKuKWxkOJR48xIQ3iDogp2zFoyB5sxjEhjePfxuM0/oDx5i7hFwl9C+3tyb5r4fXGw0UaZrw0QSzOjTDcj9qzGFxdo9ZUIzMdy60wtOfM21k0M3C/tQtqfQcivBiLJZwZaft0gPj/orCNrUcFCayACm/8ZlM+NGL8JSbu3i952VW2zYxH5PubZLvnjE8G8BGfk2w==;5:g95U9M4bU7Qg4tczi13pJGJrERhXDnG0XUAwUIBoeiyUBdTRk9WM5k7DU6NSAa3Po6gW7IlRLUsegoTgpesqXacObkjWzjTOw0TwrzhBln7ikJjC0xG5W+scLPYDExZerVDiDoXnGXFH8i8c6LkBzk+OZN2Jgq+kte4u7OuzNS0=;7:ou5T+l0ZG1SAKdAgzpF0UgV5jml7pbfo+eXLihWSUczmDhCG9/WBR8el68SzJNPKSeYoMY4xxOnDMmIZwlTSN4o69N2VioT5ff9EyDTNxTp8zDhN7WAwbGzGi+/vnvVBI4Ym5KHGfza+HyqAleBYA8YV/bwvA/MoFWoNcP2GT5IVYz+eSXCP7BEWnxH0OgoL+Bf2yYPAECe4JkAGd0rzHkpI/c9XAx+Hi/If84XNjg579U7s+LRyEfjZjI1n8DWH
x-ms-office365-filtering-correlation-id: 7775c3e2-f8df-4918-f5f9-08d60e13bed5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0139;
x-ms-traffictypediagnostic: PU1P153MB0139:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB01399F9332D6F35F8F40B3C0BF080@PU1P153MB0139.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699016);SRVR:PU1P153MB0139;BCL:0;PCL:0;RULEID:;SRVR:PU1P153MB0139;
x-forefront-prvs: 07807C55DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(366004)(39860400002)(136003)(199004)(189003)(69234005)(102836004)(5250100002)(6916009)(105586002)(53936002)(106356001)(8990500004)(10090500001)(5660300001)(316002)(2900100001)(186003)(86362001)(6116002)(9686003)(97736004)(6506007)(54906003)(76176011)(86612001)(7696005)(55016002)(22452003)(8676002)(6436002)(46003)(25786009)(81156014)(33656002)(446003)(229853002)(476003)(99286004)(6246003)(81166006)(107886003)(4326008)(11346002)(486006)(2906002)(14444005)(305945005)(74316002)(68736007)(14454004)(478600001)(256004)(7736002)(10290500003)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0139;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +ucywzJCqsuGg7yo2pnJ2lh0FGM3Pj7gmSsxec/t89fXkm11nzgya+P6brJNOk6gojt7t8CjM4BC5gVlNavdgqWe+jCo4t6jW+RH02DwNx2j9SBax3+IIKL5x2oOHhx6s1FcaDjx/Mb9iP0WUfjof763VeIgkOHBeBDlkwgqnCdlOSVGJvsTqJivC4v9kBWJqcRT/49yjduf8g6mNrBa7YJG94bGcBQTxerk/3yt2+hThNLaO4mvwcv8KI5q1pkfct871fwRVLghgXqW9QfJVnuCsufkgsEwn0DC3abqXvyZVEKgmPHcndEpXoIg7Hd/XmHCfr1K90afYt6fSX3F5qOWMmthdxPYvkVQK68PdYs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7775c3e2-f8df-4918-f5f9-08d60e13bed5
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2018 00:58:48.4031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: David Miller <davem@davemloft.net>
> Sent: Wednesday, August 29, 2018 17:49
>=20
> From: Dexuan Cui <decui@microsoft.com>
> Date: Wed, 22 Aug 2018 21:20:03 +0000
>=20
> > ---
> >  drivers/net/hyperv/netvsc_drv.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> >
> > FYI: these are the related 3 paths which show the deadlock:
>=20
> This incredibly useful information belongs in the commit log
> message, and therefore before the --- and signoffs.

Hi David,
I was afraid the call-traces are too detailed. :-)

Can you please move the info to before the --- line?

Or, should I resend the patch with the commit log updated?

Thanks,
-- Dexuan
