Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E631C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 23:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA3D92073D
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 23:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="QWfdVkfq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA3D92073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbeKDJHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 04:07:24 -0500
Received: from mail-sn1nam02on0092.outbound.protection.outlook.com ([104.47.36.92]:19587
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726990AbeKDJHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 04:07:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XrqK2xqEO36VjUXyAWEKuJ1YXjL+7YiMw6I1NiPGFo=;
 b=QWfdVkfqeAMvuXb4oT0ntPryocQJb3BjIbWZh9PGWkWwA+DrFThhBab1re+4nDiGHNYuh3JVfRM2106EbnOdhCphP6+Euo7AGu7XgaP9FXzIerNmqKfuK6io4gdlcx00zrzJntKd1IytTkRapAzXkWum+lmSc4enHfOhXIt8eHA=
Received: from MWHPR2101MB0729.namprd21.prod.outlook.com (10.167.161.167) by
 MWHPR2101MB0874.namprd21.prod.outlook.com (10.167.237.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.6; Sat, 3 Nov 2018 23:54:30 +0000
Received: from MWHPR2101MB0729.namprd21.prod.outlook.com
 ([fe80::b9b2:7591:8264:1e79]) by MWHPR2101MB0729.namprd21.prod.outlook.com
 ([fe80::b9b2:7591:8264:1e79%3]) with mapi id 15.20.1294.014; Sat, 3 Nov 2018
 23:54:30 +0000
From:   Long Li <longli@microsoft.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] genirq/matrix: Choose CPU for managed IRQs based on
 how many of them are allocated
Thread-Topic: [PATCH v3] genirq/matrix: Choose CPU for managed IRQs based on
 how many of them are allocated
Thread-Index: AQHUckPvsNWahPtFA0ekrPYSRIC2D6U+KPIAgAAkSoCAAG7v4A==
Date:   Sat, 3 Nov 2018 23:54:30 +0000
Message-ID: <MWHPR2101MB0729E7703751C2D393CF66B7CEC80@MWHPR2101MB0729.namprd21.prod.outlook.com>
References: <20181102003412.28229-1-longli@linuxonhyperv.com>
 <alpine.DEB.2.21.1811031604540.3160@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1811031815080.3160@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1811031815080.3160@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [73.193.116.27]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2101MB0874;6:zCD6gzS4TN/VnRCYCvueTfO+Ukblu8YQTbQOhby8rG3thGau3OBp0W8utSaqeopj7MKDd+qrJd5w0kqiiiehjsY1kxIRa5Q3cKQWqLeTWUIU+wxpw+0jK6WtfNMGWc/Qo+uG4WzejZlAWF5vvIqw1htIJyC28KjrGqBX7uaAA2N1FmpLsGGr3uobQRR7EtK/vyuIFEoFLfE9SMgQK2V0IF3fB3quSPCBBJUbMwiUJ2DgVKuTXdreSON/BxARrRtbYb4Jzw5DI83pmoT6smdZvmfbszZOYstfd+rse/XSc47jBeKRCjnrCPoW8op6chdvbXAVcgvOcwqScjND3oWMbKrA2fqT80Hww5S7eH1SBt47meRmpcj1crhGloXz5N0mY7M1VkQxsncHzKdGUa3a5cqqIjYxYYtuAFqtNBxsmsNqjInwyxo6vGBGA/m1b5dDW4T9if3VEnCfGgwrajTvyA==;5:aFK/I3OUUyzmaseqjpBxepuIZjG4RIXrftLrqqYGsQu0FpsoAV076WQkngYuj2SNkBWGjSqZM2Y/6ewO+sSS9aIO3HN4AdgUMqX8AN0sPpKbCGLvisbgQJXQCMvwy2CSQ4WWcAI+4hOvaNTodUf59AD36zapt1DkFEUC+suw/II=;7:JO2+8MiRkiVee5Z/XAIVJENWoEZALQ9/DUWLPq4Qp4wj1jRlzgEEL7OWoSXi3kY1SKBpaG88kmh5+UhmgUnkEDMODMAZS8wxZYoDoNGWsP+SRfcImdT2oQ2IL2GW7nCUGOXXUSs/liIxdTJ6pfSqQw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d93b93b3-5f28-4cc7-d18f-08d641e7b275
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:MWHPR2101MB0874;
x-ms-traffictypediagnostic: MWHPR2101MB0874:
x-microsoft-antispam-prvs: <MWHPR2101MB08741E7F01DC512133301CF9CEC80@MWHPR2101MB0874.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(8220035)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231382)(944501410)(52105095)(2018427008)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:MWHPR2101MB0874;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2101MB0874;
x-forefront-prvs: 08457955C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(366004)(39860400002)(396003)(346002)(199004)(189003)(8990500004)(71190400001)(71200400001)(86362001)(86612001)(105586002)(2906002)(229853002)(74316002)(8936002)(106356001)(55016002)(5660300001)(97736004)(6246003)(478600001)(7696005)(76176011)(81166006)(8676002)(81156014)(4326008)(305945005)(6436002)(33656002)(7736002)(10290500003)(10090500001)(6506007)(9686003)(53936002)(11346002)(316002)(2900100001)(68736007)(14454004)(22452003)(6116002)(3846002)(446003)(25786009)(186003)(66066001)(102836004)(6916009)(6346003)(476003)(26005)(14444005)(486006)(256004)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2101MB0874;H:MWHPR2101MB0729.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com; 
x-microsoft-antispam-message-info: 2S39jnyy5Gpo7Luk2DiUZkdL3XXGhEMvhx3mIfo9ZfVYjhUQLvZIFl42igcVGXTqKxnDUPMZnPoE53fFEbkTmimMHDzkOLyhe9oLyFZ15bCcAi+aFy5XtZPDcxoMzRp+MEjEEdpa2s6Dl2JNEvaqLtcDMDXp5E0vUqE8cxUOfVo5cI9/GExfvN19h0wmpsi0KFyYuzWDEyyHuJASoeuIj2sn9XQrs2hMnR3RtHWu3qcq0gAAj8tKvPNQD7RuY7Nt93jl1ez1t9eQd6bss+IP5gH743VZWbV3gntXd8/xtNGcSL+dtjsfOdbQM3in3jwehGI+BIrz7DzPgC/J9ge6wwyyj0Cr3mmmsOC1vx2GAsY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d93b93b3-5f28-4cc7-d18f-08d641e7b275
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2018 23:54:30.4138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0874
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH v3] genirq/matrix: Choose CPU for managed IRQs based
> on how many of them are allocated
>=20
> On Sat, 3 Nov 2018, Thomas Gleixner wrote:
> > On Fri, 2 Nov 2018, Long Li wrote:
> > >  /**
> > >   * irq_matrix_assign_system - Assign system wide entry in the matrix
> > >   * @m:		Matrix pointer
> > > @@ -269,7 +291,7 @@ int irq_matrix_alloc_managed(struct irq_matrix
> *m, const struct cpumask *msk,
> > >  	if (cpumask_empty(msk))
> > >  		return -EINVAL;
> > >
> > > -	cpu =3D matrix_find_best_cpu(m, msk);
> > > +	cpu =3D matrix_find_best_cpu_managed(m, msk);
> > >  	if (cpu =3D=3D UINT_MAX)
> > >  		return -ENOSPC;
> > >
> > > @@ -282,6 +304,7 @@ int irq_matrix_alloc_managed(struct irq_matrix
> *m, const struct cpumask *msk,
> > >  		return -ENOSPC;
> > >  	set_bit(bit, cm->alloc_map);
> > >  	cm->allocated++;
> > > +	cm->managed_allocated++;
> > >  	m->total_allocated++;
> > >  	*mapped_cpu =3D cpu;
> > >  	trace_irq_matrix_alloc_managed(bit, cpu, m, cm);
> >
> > so far so good. But what exactly decrements managed_allocated ?
>=20
> Another thing. If we add that counter, then it would be good to expose it=
 in
> the debugfs files as well.

I will send an update to address those.

Long

>=20
> Thanks,
>=20
> 	tglx
