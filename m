Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3E8C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 16:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DB6C2098A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 16:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="MmGrNDES"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DB6C2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731348AbeISVp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 17:45:56 -0400
Received: from mail-sn1nam02on0124.outbound.protection.outlook.com ([104.47.36.124]:39040
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731242AbeISVp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 17:45:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUpYrB4lrvYk16YG3dhTz71t1v+rRKZbCO8TXiQiOLU=;
 b=MmGrNDES+EbpHptiv4gcR+K4EtCmb9rf8VlLfbtxSQkneXt/y72HeCwNOeamEQnZYNRGP+7crcvHxRDHy8T3Gi1fJHM1uI/bpVhBTrWo88GLI6Ms+iS7p3f74ZYfjm5g4o7IoDqYywFfeeiz6iZWplGHNHU8gRRdPXpk8CgUMxc=
Received: from CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Wed, 19 Sep 2018 16:07:18 +0000
Received: from CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::d1f6:46cd:d8b4:880c]) by CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::d1f6:46cd:d8b4:880c%5]) with mapi id 15.20.1185.003; Wed, 19 Sep 2018
 16:07:18 +0000
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
Subject: RE: [PATCH V2 2/13] KVM/MMU: Add tlb flush with range helper function
Thread-Topic: [PATCH V2 2/13] KVM/MMU: Add tlb flush with range helper
 function
Thread-Index: AQHUTv5ECNGroN/7Ak2aGvCB0vKdcqT3xo2g
Date:   Wed, 19 Sep 2018 16:07:18 +0000
Message-ID: <CY4PR21MB0773253EB4F0CED66A9A6F6BDC1C0@CY4PR21MB0773.namprd21.prod.outlook.com>
References: <20180918031754.113013-1-Tianyu.Lan@microsoft.com>
 <20180918031754.113013-3-Tianyu.Lan@microsoft.com>
In-Reply-To: <20180918031754.113013-3-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-09-19T16:07:16.4434182Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:b+e+qTUEr+MN8wSNQOYpnbLtVSL55oKPkMDHmbJgkYz/XnjzEMpK8ZexYYvCS+7ntXvc4s/52DGI8ZMoWeVX/9SSrukpD6UCQoT2vVAtyrg8x5O9y1iBk9dZBoVydB7YMMokLugIyBu9Mr1de8GwXjeyq6nujEt9tmfZ60z8ujZ/yIKQQjfZW3NEffqJw2m0raVBJbrIpPsxq349mGgBhpd5TAnjmTfgQcjt5VyB0riYbHG84t+cGMxdCk8DnIkPncJ0pv5duD8qBioonpFbSqL4Lbh6PNiDEZv42avxjNgaMHDuKKipbajC6qGcruNL5uiCwaeT6ag0o1Dy9bhNn0kM/CMnQNy2NSIjLR77RKvOZ05D3SzJCtPD6NvHwMtH0ZXpoe/t/a5JuOEc2eeeW/KfzJJ8X2RdM7Rb3yBGW4ed8OZeJJgdJ5TDUHaj2/BCNkdhQuPIUelGSP+CWVRq2w==;5:b/bIYJLTB/OHzjsE1tzpNCXQ7q8fFYbekqxn1LOJNR3GApohJc8XNVTKT26QM9kxEYWEpZzxPg9YmqAUTEjt1wcczD9HHkHAauP5SNcQpM9xZoqoBTpiYvsTqHaYaMEEnu2+s+eIo/bMUmIKN6YHhHJEQTs64y7fNrSB1NVP1z4=;7:VWcURjZlFCXiIQn307wJ2CdoFCyqz34wypZhTChgC3U5F9SqzkTiveQ2ivR93wUVcNPzex6bx0rYPlNfASpO0+uNkhiTiwCXRvL9lk3+3gQDg/5Xqn7tDYTPQMV8aopR4mWGm8g/XsVqD9gJ+vou94n9Q2erBOU+ipSbSLhNOKxhJrFSfNMkEsrJ1juvTgS1VhL910sayFXox5Fs6fHbmHXBkUJM9Eqw7Z9CqWGYCnup3yHk+tO6lgYaURLfRGPO
x-ms-office365-filtering-correlation-id: 3a5740b8-c2ed-4a17-a5e9-08d61e49f998
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB08559A8E1ACF2079CF5867CDDC1C0@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0800C0C167
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(39860400002)(396003)(136003)(199004)(189003)(446003)(1511001)(229853002)(6246003)(106356001)(5250100002)(105586002)(486006)(22452003)(86362001)(86612001)(53936002)(107886003)(11346002)(6862004)(476003)(316002)(97736004)(2900100001)(68736007)(8990500004)(54906003)(8676002)(9686003)(66066001)(14454004)(7736002)(5660300001)(102836004)(6506007)(10090500001)(33656002)(478600001)(74316002)(14444005)(26005)(72206003)(305945005)(6346003)(3846002)(6116002)(81166006)(99286004)(81156014)(7416002)(10290500003)(6436002)(4326008)(6636002)(25786009)(8936002)(76176011)(55016002)(7696005)(256004)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0773.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com; 
x-microsoft-antispam-message-info: a5r20xEYTlESbDTzLZieG6JPiwowm7nQSgU8Q+qlo4Qa7he8sgzHU2CdLBifne/Icbdl/aH94HmUJssCLwOND6bCJSFOVSbPA9vlS/oaIyrNLElTAz8Cv9FYCjJSpZyBhlHTaSp+jinVMNj0SlK5TX4XZXvm4pV21C5W32bUuyFfjWNJ8KqHxn+ZSMy24yKr2fVlu7oJsGV2rxFq+9r8pjFHluHlnaHED+jEVjm7PD4yiMPRpYAu5oKXf5qGtI5T9B6FRq0zkPvZxjs6GndGIhGLlsVPLar1OFKY61GkjmX4X8/565LCAQhNe+pRjRG/bwVZkB+dzPkAERalRAL3poQDNQwlSzQzwRwVDkxPIXA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a5740b8-c2ed-4a17-a5e9-08d61e49f998
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2018 16:07:18.6538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tianyu Lan  Sent: Monday, September 17, 2018 8:18 PM
>
> +static void kvm_flush_remote_tlbs_with_range(struct kvm *kvm,
> +		struct kvm_tlb_range *range)
> +{
> +	int ret =3D -ENOTSUPP;
> +
> +	if (range && kvm_x86_ops->tlb_remote_flush_with_range) {
> +		/*
> +		 * Read tlbs_dirty before setting KVM_REQ_TLB_FLUSH in
> +		 * kvm_make_all_cpus_request.
> +		 */
> +		long dirty_count =3D smp_load_acquire(&kvm->tlbs_dirty);
> +
> +		ret =3D kvm_x86_ops->tlb_remote_flush_with_range(kvm, range);
> +		cmpxchg(&kvm->tlbs_dirty, dirty_count, 0);
> +	}

The comment and the code that manipulates kvm->tlbs_dirty appears
to have been copied from kvm_flush_remote_tlbs().  But the above
code doesn't call kvm_make_all_cpus_request().   I haven't traced
all the details, but it seems like the comment should be updated,
or the code isn't needed.

Michael
