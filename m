Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E7DC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEB242087E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="VGK7o7sb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEB242087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbeH2ANj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 20:13:39 -0400
Received: from mail-eopbgr700109.outbound.protection.outlook.com ([40.107.70.109]:61772
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727086AbeH2ANj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 20:13:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/34QkH+ZO6j6TUuPF41Fff0anCrb2fG0oy6tyT0oeM=;
 b=VGK7o7sbq0mXo95rZXCqewEvK9sUBmIgkqaJa8blxHo4onFRMOcPngvfE/4vbNrcADlCDRQCpulse4rTcxUTdCVeFWBm8Vc5UoNPejWK9MQowRYabExoGhUbGMPxrsPBFOluYo2Un8BIMHPoPwkjkMqNwCaic6N0co2R+eOU/p8=
Received: from CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) by
 CY4PR21MB0135.namprd21.prod.outlook.com (10.173.189.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Tue, 28 Aug 2018 20:20:19 +0000
Received: from CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::9039:1f12:39f1:267f]) by CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::9039:1f12:39f1:267f%9]) with mapi id 15.20.1122.000; Tue, 28 Aug 2018
 20:20:19 +0000
From:   "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To:     vkuznets <vkuznets@redhat.com>
CC:     "mhkelley58@gmail.com" <mhkelley58@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH char-misc 1/1] Drivers: hv: vmbus: Make synic_initialized
 flag per-cpu
Thread-Topic: [PATCH char-misc 1/1] Drivers: hv: vmbus: Make synic_initialized
 flag per-cpu
Thread-Index: AQHUKHxDlEyTLKiml0qH4U3EvoNZ3KSpL9oigAEw2VCAAEG/yYArJRXQ
Date:   Tue, 28 Aug 2018 20:20:19 +0000
Message-ID: <CY4PR21MB077375C31D9211486C328328DC0A0@CY4PR21MB0773.namprd21.prod.outlook.com>
References: <1533004484-3937-1-git-send-email-mikelley@microsoft.com>
        <87ftzzodnv.fsf@vitty.brq.redhat.com>
        <CY4PR21MB0773EFCF6EA21CF8F9CE01E0DC2D0@CY4PR21MB0773.namprd21.prod.outlook.com>
 <8736vyo2tm.fsf@vitty.brq.redhat.com>
In-Reply-To: <8736vyo2tm.fsf@vitty.brq.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-08-28T20:20:18.1031421Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [2001:4898:80e8:1:7185:78a3:76ad:ce74]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0135;6:EvTbTVA7W8MCnUvRAWkNt2kmdjXyOViczPVb+pAB2nvxGbWIxqA5q4ZvuEMv8M1BocJggL9LJg85c+f2Dy1cKI+K90b110Xlnxotx2mVV6c97qAUX/SzMkwSUsUhLZv5Mbo0IIqVXiEfLzYIeBcURlf/i0bjXsPCuFGk6MkvrtEp+SuHWXcmoc8XU3x9C3vnEA9xL+nANBtWX1z8zphn0XwDAgRHb/MFDTq/B4okxsbyuYPdluh3WjJmIev6FROx1hQ09+mTBE0fYnqqvMDA8x798PpedgEe2UDQZYbOOIWT+fThA02EfIS96FP9zXy8b+H+OIhDGMW5vK4qQi1019v6tFJH/yDIjJpAiLMnwaKzm3DNACnKhpEMLrctlV0UDC3WmmLdyNoKYlmnhBmHpv9vw1wNn4yyWyQkTXVoq+ygqf7ijlSphv6KMqUJNJYNNiWFupZt6cviAND29Uti3g==;5:SBNFOyakOcTegSoa3X8NJOuhHl2Fdth92bjD1ToOmj+ZqafhELILQVutURJwLfmv29NuXYeHfWqVB6McSA6vBTEcB9NlrVXzrFznLw+GN5arpi2lE6VDPQKiKHxUdyD8Uy/ZmICVcJnX9hAgLURlU4NAQPqwvQue50hRJMDo20I=;7:LRR/2WL0s9DGAzBtlBpHR0tZ7mMBBxBosljhVvWaKLHR1MdT+puaQPQdgpwbsixs0jpPOW94h0jzR9t35a1FrP18ecFmmsyUcQiqfOzSmhbSpa9shx8HHX5q7bRkn1u4xSUcY3r601+5x9f6CLOryHfXWbQ9gUeLEwc/AkDKolB4henyo9mEjG1XUytZHMFgwKfPlBai2CY/OW+db2B204tK7tNkWNDq2VxXC2vXEMgk1+l383r/nVJLE2+ApQUL
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 868746e0-05d8-45f5-3a6e-08d60d23ad15
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0135;
x-ms-traffictypediagnostic: CY4PR21MB0135:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB01350642A2211ED007A52BCDDC0A0@CY4PR21MB0135.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231336)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0135;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0135;
x-forefront-prvs: 077884B8B5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(366004)(346002)(376002)(39860400002)(189003)(199004)(6436002)(5250100002)(86612001)(486006)(53936002)(2900100001)(99286004)(9686003)(46003)(478600001)(186003)(14444005)(10290500003)(256004)(6116002)(93886005)(7696005)(54906003)(86362001)(72206003)(6506007)(102836004)(446003)(76176011)(55016002)(11346002)(476003)(2906002)(5660300001)(14454004)(33656002)(8936002)(305945005)(74316002)(22452003)(97736004)(316002)(229853002)(7736002)(6916009)(68736007)(107886003)(106356001)(39060400002)(105586002)(4326008)(10090500001)(81166006)(81156014)(8676002)(25786009)(8990500004)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0135;H:CY4PR21MB0773.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: KPd1ZpQcqfnUGkPwQL5gnJXKyDTGb1oGtGLpIQJjE6A1WWl/9Oebs6jV/augc0FYoTNsFHiJ2NDMxDliKkNVvIbH8bluCsdAJ8jAkZ3I3WK+RX80G/zl5dHxKOqPyuTBJem+6MYXvMybmtVtjNqDcSnY51v989mSWy5zyINxHz07JK4QCUFb+PtApoEZ/1D9o/lVKX+NiONj49HtG+pqx9EdGvvDe/S41S9bXRS/fxZ3IsqFpadeLL6z3aOQAIhc2Bc77daFB8EUj93mJjQ54OcFktoOZr2O41b6Uxzic0S1Ft+BH8wuu0NjsjYo4RLtHWRyPCz0SfKPPBgQwXpk3tRbxV/Qby8N8fDdSKmX2hk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 868746e0-05d8-45f5-3a6e-08d60d23ad15
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2018 20:20:19.7068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com>  Sent: Wednesday, August 1, 20=
18 2:26 AM

> > I was trying to decide if there are any arguments in favor of one
> > approach vs. the other:  a per-cpu flag in memory or checking
> > the synic_control "enable" bit.   Seems like a wash to me, in which
> > case I have a slight preference for the per-cpu flag in memory vs.
> > creating another function to return sctrl.enable.  But I'm completely
> > open to reasons why checking sctrl.enable is better.
>=20
> Just a few thoughts: reading MSR is definitely slower but we avoid
> 'shadowing' the state, the reading is always correct. In case there's a
> chance the SynIC will get disabled from host side we can only find this
> out by doing MSR read. This is a purely theoretical possibility, I
> believe, we can go ahead with this patch.

Vitaly -- just to confirm:  you are OK with the patch as is?  (I'll
check, but I may need to rebase on the latest code.)

Michael
