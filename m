Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5CEC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 17:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 536692082D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 17:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="gbuPhOs8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 536692082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbeKCDBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:01:10 -0400
Received: from mail-eopbgr820110.outbound.protection.outlook.com ([40.107.82.110]:1056
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725816AbeKCDBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:01:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80FainhrDRGOB33uS/rja+wp/nt68o3mWMoke9JQzhE=;
 b=gbuPhOs8UtGqcjVRPPOr893YPLliP7UGkeFV3BsFMsmsV8WWpM0MlLFqMOGmxaln6rFrVDYjNXH2tJkrMfFqDRSEtN1o3YWzOdKaonjL9VFVAQR5Qf/Ng+5WK82xgdtcTe6V2YH9VJnUVVG4kpbxHOqDVDllhOZonkJeAjj3b34=
Received: from MWHPR2101MB0729.namprd21.prod.outlook.com (10.167.161.167) by
 MWHPR2101MB0732.namprd21.prod.outlook.com (10.167.238.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.8; Fri, 2 Nov 2018 17:53:08 +0000
Received: from MWHPR2101MB0729.namprd21.prod.outlook.com
 ([fe80::b9b2:7591:8264:1e79]) by MWHPR2101MB0729.namprd21.prod.outlook.com
 ([fe80::b9b2:7591:8264:1e79%3]) with mapi id 15.20.1294.014; Fri, 2 Nov 2018
 17:53:08 +0000
From:   Long Li <longli@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] genirq/affinity: Spread IRQs to all available NUMA nodes
Thread-Topic: [PATCH] genirq/affinity: Spread IRQs to all available NUMA nodes
Thread-Index: AQHUcj4Q+mcDofX4X0CCbjkzFD1I1qU8wQiAgAAD67A=
Date:   Fri, 2 Nov 2018 17:53:08 +0000
Message-ID: <MWHPR2101MB072985A6219256609C99190FCECF0@MWHPR2101MB0729.namprd21.prod.outlook.com>
References: <20181101235157.27607-1-longli@linuxonhyperv.com>
 <CY4PR21MB077387C5E70FD9D96D00FE62D7CF0@CY4PR21MB0773.namprd21.prod.outlook.com>
In-Reply-To: <CY4PR21MB077387C5E70FD9D96D00FE62D7CF0@CY4PR21MB0773.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [73.193.116.27]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2101MB0732;6:Z8f++yy5vVuP4nG2o4qi3jS5xUoV302kg3IoUQtFg3bJmBM9nTb8G8GDg16G4/6j1yCE8D1Y8OlSaJ8Llwfy60O+wVbJ/aRgCZy3XMDbwjoJAVQ9SZsJwCzYGc6AHg56Aa4P3SiV7Ut6wYKrI81T11oQ4Yw7QCZXU/kYI9PwP1CWiRbf0cjJuYsJKvdj/e9d1iD+tjWvL+ZSO2nQf3Oz9s9aSM5kPDfZhnY4850Eq72tBligOe79rRBIIIU4LESJfyYT5vH8bNKw2WrS6AMr6WQz9CtkzEXE481PGN1wjDD/c4eNOTPPImyE70KKlVkc4oUCGd9tgQbQzXM6+3eavowkWAIk5gnkMD7k4+hhLz8nhyJeMZGdTHzT/FAGaXWETspRgGGzoDHSVm7OmAnFsSaBY5nY6EhwEldxmdG+iNHwj2m/OQ04un6Y2nW9rVrtr4iTx80WwKjXHQpI2aRpZg==;5:JG1i/GOhE4/xH79Eb1F0IC+8KbW1x4QQy/ZkZvfYwgrsWzrfCm+vp65bfdLX3kMfYKLigWuQ7O3IdhuLSZrDQGUYPLPvU28DvQ0cbvnhzFWeNB/FOZaVyG1PMYFxSEUTtsbr7gR1Gj3hpDEZKkGX8bGOprb4D7CsJv5VZbUk2+8=;7:6qZgmkQfv4MTUxeD+LB1UtIKcHDCrCyfQTyc5vVdl7xvUtCgIUFLeg+vSInRKNsz6zPIeE3ccxCzEXhgw7v2wWOKOq8YTFIE8ZT02Veumt3vt8mUVFdnbPEZ/S5f0N329/umpKMxEdywssUNsWd+BA==
x-ms-office365-filtering-correlation-id: 34a4b8a4-352a-4c87-6cf8-08d640ec0c66
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR2101MB0732;
x-ms-traffictypediagnostic: MWHPR2101MB0732:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com; 
x-microsoft-antispam-prvs: <MWHPR2101MB07321D1B69BCEF4094BDA34FCECF0@MWHPR2101MB0732.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(8220035)(2401047)(8121501046)(5005006)(3002001)(3231382)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:MWHPR2101MB0732;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2101MB0732;
x-forefront-prvs: 08444C7C87
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(366004)(396003)(39860400002)(189003)(199004)(74316002)(508600001)(1511001)(305945005)(97736004)(68736007)(25786009)(6436002)(7736002)(6116002)(229853002)(2501003)(3846002)(11346002)(486006)(476003)(446003)(10290500003)(8990500004)(8936002)(14454004)(81156014)(8676002)(81166006)(55016002)(5660300001)(66066001)(102836004)(106356001)(33656002)(6506007)(7696005)(105586002)(86612001)(99286004)(256004)(26005)(110136005)(86362001)(186003)(2906002)(10090500001)(9686003)(53936002)(2900100001)(316002)(71190400001)(76176011)(71200400001)(6246003)(22452003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2101MB0732;H:MWHPR2101MB0729.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: LbSFsxPlYxhI3mNSujnoz38UcHH5h0QgI6L0+uh11kBBuSTvWSzfnQZNZet0n21yUHxU5/8x4YSxoQfBdYBTu+xFVGnYhLoo1z5N34EobKc2X2+uKfAxyZkHwaYjYIbE2mKoA8XV3cNOctixeO7TyLEdiWeagZESEh7MTH7NEl6lwiaj466HCtVcQ3hrNnjot85mEdIexAKoJ5re8K4vp27LhjyVWWR9hvN+/+gBZ8l+w3CLXZGO0XxqhVR/28XGvstAC0sQGxa3rfAtWz1lou/gBCp4ZoeESaP6vsIAIHQg+ahMhWHTNXH9ZLJleiZaEyVxevJUoXTWQVWQzxYXiQ9xLssX3LZ2INnfbeoGYQw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34a4b8a4-352a-4c87-6cf8-08d640ec0c66
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2018 17:53:08.2621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0732
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: RE: [PATCH] genirq/affinity: Spread IRQs to all available NUMA
> nodes
>=20
> From: Long Li <longli@microsoft.com>  Sent: Thursday, November 1, 2018
> 4:52 PM
> >
> > --- a/kernel/irq/affinity.c
> > +++ b/kernel/irq/affinity.c
> > @@ -117,12 +117,13 @@ static int irq_build_affinity_masks(const struct
> irq_affinity *affd,
> >  	 */
> >  	if (numvecs <=3D nodes) {
> >  		for_each_node_mask(n, nodemsk) {
> > -			cpumask_copy(masks + curvec,
> node_to_cpumask[n]);
> > -			if (++done =3D=3D numvecs)
> > -				break;
> > +			cpumask_or(masks + curvec, masks + curvec,
> node_to_cpumask[n]);
> > +			done++;
> >  			if (++curvec =3D=3D last_affv)
> >  				curvec =3D affd->pre_vectors;
> >  		}
>=20
> When the above for loop is exited, 'done' will always be equal to 'nodes'
> since there are no early exits from the loop.  Hence there's no need to b=
e
> incrementing 'done' in the loop.
>=20
> > +		if (done > numvecs)
> > +			done =3D numvecs;
>=20
> And if 'done' would always be equal to 'nodes', there is no need for the =
test.
> Just always set 'done' to 'numvecs'.

Thanks. I will fix this in v2.

>=20
> >  		goto out;
> >  	}
> >
> > --
> > 2.14.1
