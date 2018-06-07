Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id JcFpHwV5GFveYgAAmS7hNA
	; Thu, 07 Jun 2018 00:15:01 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5DB786089E; Thu,  7 Jun 2018 00:15:01 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="YvgjEyx1"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,URIBL_SBL,
	URIBL_SBL_A autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B0D86607F7;
	Thu,  7 Jun 2018 00:15:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B0D86607F7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752520AbeFGAO7 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 20:14:59 -0400
Received: from mail-pu1apc01on0093.outbound.protection.outlook.com ([104.47.126.93]:15369
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752213AbeFGAO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 20:14:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AptLwHSunMkUed8bSwit4tAXP9VE5YqjHUXBIAfCZBY=;
 b=YvgjEyx12kEZ2G7YKdmFZSDLLnlSzV/4ajJSZOMjSv4RE+MYqQUrT05FSP52nKkVumBfC2Y86UXh6+y0T3A3Pg8fyEjfFaOgeYMKMQhbDfkQRDVydwSWUt1EQrgDnzdG8RbpNQJ4EgTmhxhn+xUSltTxnPHNK3UQtCpu/A1hw2I=
Received: from KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM (10.170.167.17) by
 KL1P15301MB0054.APCP153.PROD.OUTLOOK.COM (10.170.168.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.2; Thu, 7 Jun 2018 00:14:40 +0000
Received: from KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM ([10.170.167.17]) by
 KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM ([10.170.167.17]) with mapi id
 15.20.0863.004; Thu, 7 Jun 2018 00:14:40 +0000
From: Dexuan Cui <decui@microsoft.com>
To: Haiyang Zhang <haiyangz@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "driverdev-devel@linuxdriverproject.org"
        <driverdev-devel@linuxdriverproject.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>
Subject: RE: [PATCH] PCI: hv: Fix a __local_bh_enable_ip warning in
 hv_compose_msi_msg()
Thread-Topic: [PATCH] PCI: hv: Fix a __local_bh_enable_ip warning in
 hv_compose_msi_msg()
Thread-Index: AdPyKucLHxE0xn3+RTSKXedSJeHHcgCNtVtQAmSYQFA=
Date: Thu, 7 Jun 2018 00:14:39 +0000
Message-ID: <KL1P15301MB0006D8314C8B40A939598056BF640@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
References: <KL1P15301MB0006EE546A7C2567B61EA783BF6B0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <BN6PR21MB016112A4E32D76EC669818C3CA690@BN6PR21MB0161.namprd21.prod.outlook.com>
In-Reply-To: <BN6PR21MB016112A4E32D76EC669818C3CA690@BN6PR21MB0161.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-05-23T00:18:18.8931354Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com;
x-originating-ip: [2001:4898:80e8:0:512f:6303:d09e:a11f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;KL1P15301MB0054;7:wVzuXfuw1kHDyysSWN7ljOFu32WMu71vqketLcS2aQh1aPuKLjJHir22PK8XNbvC6wp/3xf/0G2QO1DeVNxWaLSstc8QLQMo6FQ57L2flBBYJosMfu1rin7AQN5WSmMfTplcoh63ZvRkVIY6jWJUMavvvX7sPDOhrLXAz+gkxl7wiKMlZ6hOonvr9u+5fh/U+iPSWtdtqrpVqO+aOKMff9sNEe579VJO1wt2p+KZmVSFXEcct/KKWnRaVo6kSH9k
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7193020);SRVR:KL1P15301MB0054;
x-ms-traffictypediagnostic: KL1P15301MB0054:
x-microsoft-antispam-prvs: <KL1P15301MB0054C4456C35BE291135BDFFBF640@KL1P15301MB0054.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(9452136761055)(211936372134217)(153496737603132)(198206253151910);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:KL1P15301MB0054;BCL:0;PCL:0;RULEID:;SRVR:KL1P15301MB0054;
x-forefront-prvs: 06968FD8C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(39860400002)(366004)(346002)(376002)(199004)(189003)(105586002)(106356001)(77096007)(10290500003)(14454004)(10090500001)(22452003)(2906002)(316002)(6246003)(1511001)(3280700002)(3660700001)(8990500004)(4326008)(33656002)(2900100001)(68736007)(7416002)(6116002)(478600001)(5660300001)(53936002)(9686003)(11346002)(97736004)(54906003)(476003)(6506007)(53546011)(59450400001)(446003)(76176011)(486006)(102836004)(110136005)(46003)(99286004)(86612001)(81156014)(2201001)(86362001)(25786009)(8936002)(8676002)(74316002)(6436002)(7736002)(305945005)(81166006)(575784001)(55016002)(229853002)(7696005)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:KL1P15301MB0054;H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Zv3+ZLqmvGj7YCVaf9TJUVMQ2y3uXVmFg+RvQjPnld0QZBL8fN18A8ku2Qxr+uzDSHa79Z8Xgn8wrS4t0ebhY4fAv76f97Z+hSaVyC40w/E8yX05x+xgepsQP4ffiEeVe25puVOsPD6GLBe+0ba25m+dZyauli4f/v5NiCUL2bTuV0S447vS3CSYchVlHsXc
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 0e3ce6f9-2009-46a2-35af-08d5cc0ba99d
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e3ce6f9-2009-46a2-35af-08d5cc0ba99d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2018 00:14:39.9987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0054
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Haiyang Zhang
> Sent: Friday, May 25, 2018 12:52
> To: Dexuan Cui <decui@microsoft.com>; Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com>; Bjorn Helgaas <bhelgaas@google.com>;
> linux-pci@vger.kernel.org; KY Srinivasan <kys@microsoft.com>; Stephen
> Hemminger <sthemmin@microsoft.com>; olaf@aepfle.de;
> apw@canonical.com; jasowang@redhat.com
> Cc: linux-kernel@vger.kernel.org; driverdev-devel@linuxdriverproject.org;
> vkuznets@redhat.com; marcelo.cerri@canonical.com
> Subject: RE: [PATCH] PCI: hv: Fix a __local_bh_enable_ip warning in
> hv_compose_msi_msg()
>=20
> > From: Dexuan Cui
> > Sent: Tuesday, May 22, 2018 8:18 PM
> > To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>; Bjorn Helgaas
> > <bhelgaas@google.com>; linux-pci@vger.kernel.org; KY Srinivasan
> > <kys@microsoft.com>; Stephen Hemminger <sthemmin@microsoft.com>;
> > olaf@aepfle.de; apw@canonical.com; jasowang@redhat.com
> > Cc: linux-kernel@vger.kernel.org; driverdev-devel@linuxdriverproject.or=
g;
> > Haiyang Zhang <haiyangz@microsoft.com>; vkuznets@redhat.com;
> > marcelo.cerri@canonical.com
> > Subject: [PATCH] PCI: hv: Fix a __local_bh_enable_ip warning in
> > hv_compose_msi_msg()
> >
> >
> > Commit de0aa7b2f97d ("PCI: hv: Fix 2 hang issues in
> hv_compose_msi_msg()")
> > uses local_bh_disable()/enable(), because hv_pci_onchannelcallback() ca=
n
> also
> > run in tasklet context as the channel event callback.
> >
> > With CONFIG_PROVE_LOCKING=3Dy in the latest mainline, or old kernels th=
at
> > don't have commit f71b74bca637 ("irq/softirqs: Use lockdep to assert IR=
Qs
> are
> > disabled/enabled"), it turns out can we trigger a warning at the beginn=
ing of
> > __local_bh_enable_ip(), because the upper layer irq code can call
> > hv_compose_msi_msg() with local irqs disabled.
> >
> > Let's fix the warning by switching to local_irq_save()/restore(). This =
is not an
> > issue because hv_pci_onchannelcallback() is not slow, and it not a hot =
path.
> >
> > Fixes: de0aa7b2f97d ("PCI: hv: Fix 2 hang issues in hv_compose_msi_msg(=
)")
> > Signed-off-by: Dexuan Cui <decui@microsoft.com>
> > Cc: <stable@vger.kernel.org>
> > Cc: Stephen Hemminger <sthemmin@microsoft.com>
> > Cc: K. Y. Srinivasan <kys@microsoft.com>
> > ---
>=20
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
>=20
> Thanks you.

Hi Lorenzo,

Can I have your reply to this patch?

-- Dexuan
