Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB182C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 04:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4131520894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 04:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="H/vBCUb4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4131520894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733050AbeHAGWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 02:22:23 -0400
Received: from mail-eopbgr30042.outbound.protection.outlook.com ([40.107.3.42]:19240
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733010AbeHAGWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 02:22:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5wki22dm1VYnHlV5iC2at2MjiYwWrhRIFP8Gd+hTBo=;
 b=H/vBCUb4Bpx3iVek9wztbPTzYpMNJs/B2yQ0cMqN87rHl3nAX5LQhoDtHEokWRs0z/+88kTe/F1wXRFz6C94qkW2XiJAB46N+KOLSdRnZq7n0cB2VYPaKSrGiT1IT4/rKeOxfPkxO55wXL787TQZ/veC97igSwZbnpKL6OQc6AA=
Received: from DB6PR0401MB2536.eurprd04.prod.outlook.com (10.169.224.151) by
 DB6PR0401MB2344.eurprd04.prod.outlook.com (10.168.55.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.14; Wed, 1 Aug 2018 04:38:41 +0000
Received: from DB6PR0401MB2536.eurprd04.prod.outlook.com
 ([fe80::4c47:d558:823:271b]) by DB6PR0401MB2536.eurprd04.prod.outlook.com
 ([fe80::4c47:d558:823:271b%6]) with mapi id 15.20.1017.010; Wed, 1 Aug 2018
 04:38:41 +0000
From:   "Y.b. Lu" <yangbo.lu@nxp.com>
To:     David Miller <davem@davemloft.net>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Madalin-cristian Bucur <madalin.bucur@nxp.com>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/3] ptp_qoriq: convert to use module parameters for
 initialization
Thread-Topic: [PATCH 3/3] ptp_qoriq: convert to use module parameters for
 initialization
Thread-Index: AQHUJ+4m7ji74zU7lkWu9l5BQ4RFQqSn9BKAgAJeyRA=
Date:   Wed, 1 Aug 2018 04:38:41 +0000
Message-ID: <DB6PR0401MB2536D7611DEB88210C5AEFEFF82D0@DB6PR0401MB2536.eurprd04.prod.outlook.com>
References: <20180730100154.27906-1-yangbo.lu@nxp.com>
        <20180730100154.27906-3-yangbo.lu@nxp.com>
 <20180730.092545.225621578249887012.davem@davemloft.net>
In-Reply-To: <20180730.092545.225621578249887012.davem@davemloft.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yangbo.lu@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0401MB2344;6:TqZXcs048ODD4fQvDmohiODYjfTSyNeYwHHVrhJ+vKuX4QVepN8xEWV4eX/Z+SVySJ36TyUwVI3Zup2AYJt3oRXP3dxRMRB4ExRKliusNwLAOPA8CvyP3tru4XT5BmbQiyDkZzMihzaKxYQ4P0oaWsknPTqZ6rtm4UEwjMKeXHKzOV98P0VChp6qdS5nUN3/oipWKiJtJTAUpmRnlL0A5npGmXdm/DrojJWKe8kVkbrZvzylEt73KCW7qIaPr0e8FRkdKd9n+k9uX3nYw2/QtvGE3tFMDpR/DIPFd62lDPPdaf6rWtOf5uEGhb6r6Kos+5sYrEcdtZE2vphMxFd575xAkBk/RXMLH3Gy0oVS2DuZ3aHEFu+nkeFzwtBNLsEkHTR/5QuV/8Xfk41GLt8lnPP3fw1joIsxiz+pHzpf1nDpGqvPJsmmN0Flt4riOql3aXsRPUFMMMqJbRmZKivfeQ==;5:S7b9zoe+mHhXxSj+cIKgokA+cAmzVMDAsZEqi1vxsrLD8HdigGjqLqVD0TaOow82xcFM0GE2rcT68akz3/qIzFZG0RmcGvWhZ4oa/ZdJ5p5sUqf4avaqHIxw80DUQCGxNlnV9eE9oMZsQaTpK0vJgghiItqesMB+0SRh/UWfrl4=;7:5F+4Hxsq9p5h45XHi6NPlIbFa26ykBCJekMaXCSgDSgwI180wc4z//WEBg3UYaoMXIPX3OU//xzuVWAl0lyqBUWN94IeSAvh8NgkpuVaiR7KXnBzP8HHKg6jGcBnQc1jrdXOWmXUlW+ldXed9fG2j6pUmprq5IM+T8q4ESoaUNNl/FfyDapFWMsFFh3NXIWx2/afy3IBCHI9NiuQR+9w9SEhVmP4cXJ3UTfXsW2qJOQt9i5wJN6Ye7mKG0tk//1q
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 95729a1b-81cd-48ff-a42d-08d5f768a84a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB6PR0401MB2344;
x-ms-traffictypediagnostic: DB6PR0401MB2344:
x-microsoft-antispam-prvs: <DB6PR0401MB2344CA74BF4819E822FAB7DBF82D0@DB6PR0401MB2344.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(65623756079841)(185117386973197)(85827821059158)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DB6PR0401MB2344;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0401MB2344;
x-forefront-prvs: 0751474A44
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(136003)(396003)(376002)(366004)(199004)(189003)(13464003)(6436002)(5250100002)(2900100001)(316002)(14444005)(66066001)(86362001)(3846002)(486006)(229853002)(5660300001)(6116002)(476003)(55016002)(99286004)(97736004)(6916009)(106356001)(105586002)(478600001)(53936002)(2906002)(68736007)(8676002)(4326008)(74316002)(33656002)(8936002)(9686003)(7736002)(305945005)(6506007)(102836004)(53546011)(26005)(14454004)(76176011)(256004)(186003)(39060400002)(81166006)(6246003)(25786009)(81156014)(54906003)(7696005)(446003)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0401MB2344;H:DB6PR0401MB2536.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Ou8HJaH0Uf9Lif7wLHHxTSWhKgOrmzZ3Q4miDWEZSD4JfUVTapHXbCMGMlDD7O7cvMx/gohzOVdYEqKGyMA14AR7Zz4vsn1azyN6aX/Fzw37olMD56De20pEPqt8Z4kH3rW83zIEmfGN0boPuFmBDbgfTt5GZ0H3bTMTToq+btk10jgOw2Aelts8kQmvaxAeSyf6ru6m2GwATGlDEUDjmPQhhLkvePV3uloBgI3W2QapvLIstZbd5QHmQoQdNcI2fpqPEQXzxGguCZhQ3YabtfNZdjtRWXWJ+If7iOIhPSaqp/8RHTCxN52JQWvWLJ5qcZtOIviKKqe/Li2TFOY+ABfjgChuLEXlNgG0lk03ScI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95729a1b-81cd-48ff-a42d-08d5f768a84a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2018 04:38:41.3635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2344
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

> -----Original Message-----
> From: David Miller [mailto:davem@davemloft.net]
> Sent: Tuesday, July 31, 2018 12:26 AM
> To: Y.b. Lu <yangbo.lu@nxp.com>
> Cc: netdev@vger.kernel.org; Madalin-cristian Bucur
> <madalin.bucur@nxp.com>; richardcochran@gmail.com; robh+dt@kernel.org;
> shawnguo@kernel.org; devicetree@vger.kernel.org;
> linuxppc-dev@lists.ozlabs.org; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 3/3] ptp_qoriq: convert to use module parameters for
> initialization
>=20
> From: Yangbo Lu <yangbo.lu@nxp.com>
> Date: Mon, 30 Jul 2018 18:01:54 +0800
>=20
> > +static unsigned int cksel =3D DEFAULT_CKSEL; module_param(cksel, uint,
> > +0644); MODULE_PARM_DESC(cksel, "Select reference clock");
> > +
> > +static unsigned int clk_src;
> > +module_param(clk_src, uint, 0644);
> > +MODULE_PARM_DESC(clk_src, "Reference clock frequency (if clocks
> > +property not provided in dts)");
> > +
> > +static unsigned int tmr_prsc =3D 2;
> > +module_param(tmr_prsc, uint, 0644);
> > +MODULE_PARM_DESC(tmr_prsc, "Output clock division/prescale factor");
> > +
> > +static unsigned int tmr_fiper1 =3D 1000000000; module_param(tmr_fiper1=
,
> > +uint, 0644); MODULE_PARM_DESC(tmr_fiper1, "Desired fixed interval
> > +pulse period (ns)");
> > +
> > +static unsigned int tmr_fiper2 =3D 100000; module_param(tmr_fiper2,
> > +uint, 0644); MODULE_PARM_DESC(tmr_fiper2, "Desired fixed interval
> > +pulse period (ns)");
>=20
> Sorry, there is no way I am every applying something like this.  Module
> parameters are to be avoided at all costs.
>=20
> And you don't need it here, you have DTS, please use it.
>=20
> You are required to support the existing DTS cases, in order to avoid bre=
aking
> things, anyways.
[Y.b. Lu] I get your point. Will drop module_param method.
Thanks a lot for your suggestion.
