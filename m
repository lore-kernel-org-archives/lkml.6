Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AEBFC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 02:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABEE1205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 02:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="XLR0+Sv/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABEE1205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbeH3GKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 02:10:25 -0400
Received: from mail-pu1apc01on0113.outbound.protection.outlook.com ([104.47.126.113]:50353
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725844AbeH3GKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 02:10:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QmNMtiVQHxdkMFxyt5j3MyBNextSWAdrSUb5Roep3Y8=;
 b=XLR0+Sv/8OiQOqeLQ8uZwspx2yhY6re0DkDkufD0FX92ZCvcEDPmwoffayFCjPs5ZbeR032TMzuVq/0pyQTJkaq8vAmb0x67D9DN9Fyy4vb42XMLlIebSh5V4pNlMWrYyjsEsVTfmUHvHDiZRYcsqOoZ4rh3e/zIM5YRU5wYvxw=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0107.APCP153.PROD.OUTLOOK.COM (10.170.188.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Thu, 30 Aug 2018 02:10:02 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::b835:d23a:7cda:c4e1]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::b835:d23a:7cda:c4e1%2]) with mapi id 15.20.1122.009; Thu, 30 Aug 2018
 02:10:02 +0000
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
Thread-Index: AdQ6XXUw8kE8DKeUTSmE1/NI7CjYQwFnbziAAAAsndAAAp5YgAAABJCQ
Date:   Thu, 30 Aug 2018 02:10:01 +0000
Message-ID: <PU1P153MB01698809BB13C1EC895C4D23BF080@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <PU1P153MB01692432D92B3A726FBDDC68BF300@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
        <20180829.174841.833303774555397982.davem@davemloft.net>
        <PU1P153MB016903725D5E8EF56C07FF69BF080@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20180829.190839.1082082323658260994.davem@davemloft.net>
In-Reply-To: <20180829.190839.1082082323658260994.davem@davemloft.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-08-30T02:09:57.7363143Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a27f:df20:bdf7:7909:bd8f:3027]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PU1P153MB0107;6:y+6PFMHfu4PPETrVDjqH9yzQ4acHavJRIkqQTUddGf9wGXOAFs38yMnUKF1UANhUPdOoUJSGlNuUXwwWMr5rxPAGfnCyIBhktq5GTFSOuxXLDWJYP4RExo2PI+F2cYcZwnaFveBgI6yiXG1ntPYFeDX3Xl2IwoVv62BuzJ9pTErW+3z+drc0mqoVry7EMcRv2sWRtBa0o4gjPF1rKTBzNsL/2qChpo3Nc0qN5ygBGuDxha5v2zPUadkiUisbwxzhMRt+fIBMpb3K94DMe7g3jja9vZFyOccuajrdVNu/vgmvA3FXbwEZxXkVhBfRkB+PvPJdxuf1WToXwjoRXUWI5o8aYQjUGBsjnW+KGxC5by+og8CkURKGMVLZ9J4PTpcCkKWfxha4yDE67K13oXbfCGMS1vojvlm/RPeSOnmdGzXX0cdapgrNq9qRQJHNA11igIVWhWQHR3v6HZmv7UqCgQ==;5:f8KVyl7qYAEKpZc69L9bmpMxxRC9IvsY9da/mQU1yA2HUVznqD1BGdjx9skzcBN+nz1OWrUp2maborZOZYTR7bVOhKcSJZWgBA460su1F84Umox4vmbngcIH+ndbjee6nIzeqnUdIdcP1KCoYn6ymwA68AsHmRgSZ6DZzj/8Hug=;7:HkPbHOaYhHjhZSDf603tfK+GIiyxHXGa9gU9c7I/HZrFGWwUcA+Fs4CeWIJExRpOmzzSugCj4M8qsEmFvwuHoEFqwtijxsQr8xv9p+V+5JyTB5SF+EvKR1I8nOH9DciWPcJsdMU2DeH24Ycl8o8iAbsMN5yWv4Yt2uzFOGpPsjsvtN7UQbGc2oHH6GAaGDCPJgb1IcboPmqoLISe9MF/jnPuzcJTOqshtWRk0trisHR+Q9Onhu8xuWW1OURW5+WV
x-ms-office365-filtering-correlation-id: 7b04fd9e-f280-46cc-a70a-08d60e1db220
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0107;
x-ms-traffictypediagnostic: PU1P153MB0107:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB0107E030137B1C3A2D990EC0BF080@PU1P153MB0107.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699016);SRVR:PU1P153MB0107;BCL:0;PCL:0;RULEID:;SRVR:PU1P153MB0107;
x-forefront-prvs: 07807C55DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(396003)(376002)(136003)(366004)(39860400002)(346002)(189003)(199004)(53936002)(86362001)(14454004)(256004)(446003)(478600001)(46003)(99286004)(10090500001)(7696005)(11346002)(6116002)(54906003)(25786009)(22452003)(2900100001)(4326008)(486006)(8990500004)(476003)(316002)(107886003)(6246003)(86612001)(6916009)(93886005)(5660300001)(2906002)(97736004)(33656002)(68736007)(305945005)(74316002)(76176011)(106356001)(229853002)(7736002)(558084003)(81166006)(81156014)(55016002)(9686003)(5250100002)(8676002)(10290500003)(102836004)(6506007)(8936002)(6436002)(186003)(105586002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0107;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: WtnJelhw/fLlcd0gCXTuZ3D7YboWjocPeDUSMlo7MEEx06Nec8ISPEu05ZqmW5FnYRFpSMmlqPmeWqQld1nFIDwwuIVgqYQdGBExAK4CtEgnyQjP9EEgOc3Ma89HsjdA2HlpvLDAfJjyOqbHcWjSVNC1wfxopJGlJYpck7x/cQd6ofzoDCUtqldcdreyxzdxKwHq4GA6KJPXig8yOZ+Q/fqNVqF/bulyIcgLZ01J3mvfmpD1qo/SW5RlbnzqmHi78nRzDvqmJ7B1Cwa6s/y8GSDxQC7kBSqBctVDcjgn67ArJ7T5Ok2AroPsGJ78vNtIt48XV1HiDcx/JlVBm82zFNoCR+sMz9XJ6rMsIAy9vVE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b04fd9e-f280-46cc-a70a-08d60e1db220
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2018 02:10:01.6162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: David Miller <davem@davemloft.net>
> Sent: Wednesday, August 29, 2018 19:09
> > Hi David,
> > I was afraid the call-traces are too detailed. :-)
> >
> > Can you please move the info to before the --- line?
> >
> > Or, should I resend the patch with the commit log updated?
>=20
> Please resend.

OK. Will do.

-- Dexuan
