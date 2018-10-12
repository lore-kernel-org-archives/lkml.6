Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05A5C6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 22:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 603A02098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 22:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Ss4WXvcg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 603A02098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbeJMGB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 02:01:58 -0400
Received: from mail-cys01nam02on0112.outbound.protection.outlook.com ([104.47.37.112]:51456
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725785AbeJMGB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 02:01:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P250nh7dngdnvUO9FWi9B+huRLLcq5lhmeZPETDxcxY=;
 b=Ss4WXvcg3PBq0L9xsGjr0iMv6GioWMo36L/kk04FIO/TRTykrAxcDw0krcsIE3ZcwPDnbE5AVgeSzrzIcqjDsItJAScTB3oYXfeIsRRd3yDwr4v/Sem7RZ4tG+kMOXNKj4o8L6K8XI924UMJhHXRLyDRotgaQzcpkGYvvQZVNy4=
Received: from MWHPR21MB0176.namprd21.prod.outlook.com (10.173.52.22) by
 MWHPR21MB0783.namprd21.prod.outlook.com (10.173.51.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.4; Fri, 12 Oct 2018 22:27:22 +0000
Received: from MWHPR21MB0176.namprd21.prod.outlook.com
 ([fe80::8817:5ea6:f97f:aa10]) by MWHPR21MB0176.namprd21.prod.outlook.com
 ([fe80::8817:5ea6:f97f:aa10%2]) with mapi id 15.20.1250.004; Fri, 12 Oct 2018
 22:27:22 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     Stephen Hemminger <stephen@networkplumber.org>,
        Haiyang Zhang <haiyangz@linuxonhyperv.com>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        vkuznets <vkuznets@redhat.com>
Subject: RE: [PATCH net-next, v2] hv_netvsc: fix vf serial matching with pci
 slot info
Thread-Topic: [PATCH net-next, v2] hv_netvsc: fix vf serial matching with pci
 slot info
Thread-Index: AQHUYnncn2wHzuYxykKi1gVbpCt7laUcMGHA
Date:   Fri, 12 Oct 2018 22:27:22 +0000
Message-ID: <MWHPR21MB0176BDF86A3D9E1864E903E9CAE20@MWHPR21MB0176.namprd21.prod.outlook.com>
References: <20181012205515.23355-1-haiyangz@linuxonhyperv.com>
 <20181012152030.4f58c65e@xeon-e3>
In-Reply-To: <20181012152030.4f58c65e@xeon-e3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=haiyangz@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-10-12T22:27:20.5838830Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [96.61.92.94]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR21MB0783;6:0LWOkecFcAiogsiRGZ9hqkhl32XHd2GKHmKmT3tWoGwgl2EVvtkYsI8FN8zJ/Jg2CqxQJai7bE9nzDL47rZrbhK+RCNdHYiSZ1QAeobbiCro9L6y67QkTqW6Ams6G4ijSI9qEoIibHWx3iiLme81fIqOEtki/Y2i0LPBRy0M6J6auneDd9zKyQRns+VLKnqXd/GAt3zE42uqFvTtRkUuHE1/k+9LvUIHRVmruZ1qL9DCv88ODtyr1khUQ3GyKAd5NU5WD6ZWmnBAUxbcx08WdxWt6PMTK1bNUTcURzErW2VQR5/mjIBDS6C2m8fll5k7DIandMUw7/NOpdYml01fg5zJT2dnVQ+SyDPgRmGUo0gnwJwTOC9qBnvtUFuz3g2au6O7wdl1At+bGK57PbC3oBPpWSD8Yxsnn5QzeiVw+3mpQZl4cU7CUlhzkWhFiC43j9bKeKH9f8llO2ks7jA45g==;5:XCyGrHy5b+zdcNwwo+e1QMYwn/VEOQnZI+xWuMj3yCipSFZngVfIu9I+hSQNMjiAZA9Ter+OV0QeqrIR2yDSEwEguG2aGZw582LuJL5n+thwvdjmW9ieYTXnXfyi+Mttmun2HpIuba3ZYNptN9KisB07Z2TvUVNQjmnirT4puBA=;7:fPH9CfNDbjMAl0oco1MRya3CjMvsn8RauU687I8EVB3wc7SW5CfPds+OUFSKbLPD9SWHdiWLYNhTFAYtKg79OZgOAF9hs/YXT1kPUpvWF9OBs13qBe5pP2P96rbVXIF7Uy7EILlJzfSZJJZ8qlI+rsfkS+3R3Jdc96VOzw33V5KOdLJeoGrBrrEBUuvkUTGBeTSwmbhUGoFxgFhH0SMMD3GECL2FaHleQB8+klcI3Exa836A2ctoheqSbwTCMQfm
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: ebcb12cd-6911-499d-9fcf-08d63091e141
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MWHPR21MB0783;
x-ms-traffictypediagnostic: MWHPR21MB0783:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MWHPR21MB0783CA733E59BE0F835B1641CAE20@MWHPR21MB0783.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991067);SRVR:MWHPR21MB0783;BCL:0;PCL:0;RULEID:;SRVR:MWHPR21MB0783;
x-forefront-prvs: 0823A5777B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(376002)(396003)(136003)(346002)(199004)(189003)(13464003)(6346003)(86612001)(25786009)(66066001)(186003)(14454004)(6246003)(110136005)(53936002)(74316002)(55016002)(6436002)(9686003)(10290500003)(478600001)(476003)(99286004)(71190400001)(81156014)(486006)(54906003)(71200400001)(76176011)(86362001)(81166006)(4326008)(446003)(256004)(11346002)(26005)(7696005)(305945005)(8676002)(102836004)(8936002)(6506007)(14444005)(53546011)(229853002)(33656002)(68736007)(5660300001)(7736002)(10090500001)(5250100002)(316002)(8990500004)(22452003)(2900100001)(3846002)(105586002)(106356001)(6116002)(97736004)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR21MB0783;H:MWHPR21MB0176.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haiyangz@microsoft.com; 
x-microsoft-antispam-message-info: QtXGK3QHfN+N7t1/jp17hI6ZDL+iC1HstQpy1iGWJ+H9Je59MMzvTZanIkOreFpf6gDcIAFY/CNNQAj4No7669NhBKx4WPK4kpGF/4IfBl83CdHV3K6+JFxqP5DX/kCrmSimEbP70pI+nP32xQpK7+O20PUzIIcEUYcQg92GBzNdjLYoffmlUg0kg2sYLvhieslfT1RmJj6MeQKhxaVj4YDrTZg+DJCvd13eb2nsuCkTh+yMRwN+AKf/1KNbUv22wL0OCpvGZJjgIPDo2HVMBnBbHdeKIYpzySxDhDKbklM4FW0VZzgK3ne4Wo8NqVTY9WMFZ7+GqMKTyEjmRCskLKTgXMcPeeBNCStebexw5qE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebcb12cd-6911-499d-9fcf-08d63091e141
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2018 22:27:22.5038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0783
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Friday, October 12, 2018 6:21 PM
> To: Haiyang Zhang <haiyangz@linuxonhyperv.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>; davem@davemloft.net;
> netdev@vger.kernel.org; olaf@aepfle.de; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; vkuznets <vkuznets@redhat.com>
> Subject: Re: [PATCH net-next, v2] hv_netvsc: fix vf serial matching with =
pci slot
> info
>=20
> On Fri, 12 Oct 2018 20:55:15 +0000
> Haiyang Zhang <haiyangz@linuxonhyperv.com> wrote:
>=20
> Thanks for fixing this.
>=20
>=20
> > +	if (kstrtou32(kobject_name(&pdev->slot->kobj), 10, &serial)) {
> > +		netdev_notice(vf_netdev, "Invalid vf serial:%s\n",
> > +			      pdev->slot->kobj.name);
> > +		return NULL;
> > +	}
>=20
> Shouldn't this use kobject_name() in the message as well.
>=20
> Looking at the pci.h code there is already an API to get name from slot (=
it uses
> kobject_name()). So please use that one.

Sure, I will look for that api. Thanks.

