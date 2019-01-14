Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99672C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D59A20657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="RiGLhXsz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfANOsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 09:48:23 -0500
Received: from mail-eopbgr700075.outbound.protection.outlook.com ([40.107.70.75]:42557
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726554AbfANOsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 09:48:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpShgA/TIuiU/4tjUKts3w6GUvCxREIGEXMUDX5i1WE=;
 b=RiGLhXszemNnqlEnTmYbnqSM/f6l9y+TxgcExkDlk9NGoMj15hvDozxV3pXl3SM9V0Z3131/CON2t44/6vyGy1GjFkl9O+KPtMMLjzqocYfLgi459Bb8IL9Eg6Btgu9cnsw2y+KH9OHfBr/qZg2hBgpoHz63BJNC2kmGqdNPRu4=
Received: from MWHPR05MB3376.namprd05.prod.outlook.com (10.174.175.149) by
 MWHPR05MB3229.namprd05.prod.outlook.com (10.173.229.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.10; Mon, 14 Jan 2019 14:47:37 +0000
Received: from MWHPR05MB3376.namprd05.prod.outlook.com
 ([fe80::c899:1cd:6502:a0d8]) by MWHPR05MB3376.namprd05.prod.outlook.com
 ([fe80::c899:1cd:6502:a0d8%3]) with mapi id 15.20.1537.018; Mon, 14 Jan 2019
 14:47:37 +0000
From:   "Jorgen S. Hansen" <jhansen@vmware.com>
To:     "Jorgen S. Hansen" <jhansen@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Pv-drivers <Pv-drivers@vmware.com>
Subject: RE: [PATCH] VMCI: Verify PPNs before sending to device
Thread-Topic: [PATCH] VMCI: Verify PPNs before sending to device
Thread-Index: AQHUqc7Jig0o7KSPMEmIW2sVBkuIaqWu2ORA
Date:   Mon, 14 Jan 2019 14:47:36 +0000
Message-ID: <MWHPR05MB33768E548EF9B5AA752F129DDA800@MWHPR05MB3376.namprd05.prod.outlook.com>
References: <1547225865-53408-1-git-send-email-jhansen@vmware.com>
In-Reply-To: <1547225865-53408-1-git-send-email-jhansen@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jhansen@vmware.com; 
x-originating-ip: [208.91.2.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR05MB3229;20:PYmq7VxM5ujfH/QPMPDN7e6KKH8kKjxPUITKhZ9giTTGTknialtEEEgPe+zjBRw33eS5TqNsmtJtN/gGD066x93vMXpHG8AedgjixX37EtT4m8EoFCjAYKmOsZZ0hBVyw3n+9u8Ur++qqc3NBv5hXIhGRt1hcj8UBHbbJfqdfzE=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 4798d6a6-a085-479d-73dd-08d67a2f39dc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR05MB3229;
x-ms-traffictypediagnostic: MWHPR05MB3229:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-microsoft-antispam-prvs: <MWHPR05MB32299ED8555B93EA258DE028DA800@MWHPR05MB3229.namprd05.prod.outlook.com>
x-forefront-prvs: 0917DFAC67
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(366004)(376002)(136003)(189003)(199004)(13464003)(43544003)(5660300001)(66066001)(6436002)(97736004)(4326008)(106356001)(6246003)(107886003)(25786009)(74316002)(229853002)(9686003)(54906003)(55016002)(305945005)(105586002)(7736002)(14454004)(2501003)(110136005)(53936002)(316002)(8676002)(81166006)(2906002)(6506007)(81156014)(76176011)(99286004)(7696005)(33656002)(476003)(486006)(6116002)(3846002)(53546011)(256004)(14444005)(86362001)(15650500001)(68736007)(71190400001)(186003)(478600001)(8936002)(26005)(446003)(102836004)(71200400001)(2201001)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR05MB3229;H:MWHPR05MB3376.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EWlB8DrbiX48vJ5Wh0AnFFDxa6oSkGYwLl4O+vImFhrkP/GWu58nXDadqqs6Q9k8xbXlLe24iWMxS5a9kUcdCcg1FULhEKN3c4I+rnr+sNveBWhT50rmUkVB6ylYwBnioZnG3+sRgLwODgn4WcCK42kjwhieiHe10Z0HVk+yHUq64Z1lEoYVAklmlKp5QnaX/i8RnsnNgw6UAIMA3x5T1NZjP8TRbxhqr31s5UbZm9dbVCiocKGIrSvDe3V2p6cHRlX6dIOfnAcAxVBMop5yZq4wM87CEmoGm5911i8Y67As9JjVu9m/Fpi5MKYGUf8m9GthZw0S9Ga9Wqx2CUYi9Q+/H3HcGzV2LftSZe3Ys+793c2E4bCoiBGjeoD916PiCUwxXhtiqUGkTKPA9qG3U4JCPtd0lvXBW7ZdxwXqSM0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4798d6a6-a085-479d-73dd-08d67a2f39dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2019 14:47:37.0273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR05MB3229
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Jorgen Hansen [mailto:jhansen@vmware.com]
> Sent: Friday, January 11, 2019 8:58 AM
> To: linux-kernel@vger.kernel.org; virtualization@lists.linux-foundation.o=
rg
> Cc: gregkh@linuxfoundation.org; Pv-drivers <Pv-drivers@vmware.com>;
> Jorgen S. Hansen <jhansen@vmware.com>
> Subject: [PATCH] VMCI: Verify PPNs before sending to device
>=20
> The current version of the VMCI device only supports 32 bit PPNs, so chec=
k
> whether we are truncating PPNs, and fail the operation if we do. One such
> check did exist, but was wrong. Another check was missing.
>=20
> Testing through code modification: constructed PPN not representable by
> 32-bit and observed that failure was reported.
>=20
> Fixes: 1f166439917b ("VMCI: guest side driver implementation.")
> Fixes: 06164d2b72aa ("VMCI: queue pairs implementation.")
>=20
> Signed-off-by: Jorgen Hansen <jhansen@vmware.com>
> Reviewed-by: Adit Ranadive <aditr@vmware.com>
> Reviewed-by: Vishnu Dasa <vdasa@vmware.com>
> ---
>  drivers/misc/vmw_vmci/vmci_guest.c      | 10 +++++++---
>  drivers/misc/vmw_vmci/vmci_queue_pair.c | 10 ++++------
>  2 files changed, 11 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/misc/vmw_vmci/vmci_guest.c
> b/drivers/misc/vmw_vmci/vmci_guest.c
> index dad5abee656e..02bb3866cf9e 100644
> --- a/drivers/misc/vmw_vmci/vmci_guest.c
> +++ b/drivers/misc/vmw_vmci/vmci_guest.c
> @@ -532,10 +532,14 @@ static int vmci_guest_probe_device(struct pci_dev
> *pdev,
>  	if (capabilities & VMCI_CAPS_NOTIFICATIONS) {
>  		unsigned long bitmap_ppn =3D
>  			vmci_dev->notification_base >> PAGE_SHIFT;
> -		if (!vmci_dbell_register_notification_bitmap(bitmap_ppn)) {
> +		u32 bitmap_ppn32 =3D bitmap_ppn;
> +
> +		if ((sizeof(bitmap_ppn) > sizeof(bitmap_ppn32)
> +		     && bitmap_ppn !=3D bitmap_ppn32) ||
> +		    !vmci_dbell_register_notification_bitmap(bitmap_ppn)) {
>  			dev_warn(&pdev->dev,
> -				 "VMCI device unable to register notification
> bitmap with PPN 0x%x\n",
> -				 (u32) bitmap_ppn);
> +				 "VMCI device unable to register notification
> bitmap with PPN 0x%lx\n",
> +				 bitmap_ppn);
>  			error =3D -ENXIO;
>  			goto err_remove_vmci_dev_g;
>  		}
> diff --git a/drivers/misc/vmw_vmci/vmci_queue_pair.c
> b/drivers/misc/vmw_vmci/vmci_queue_pair.c
> index 264f4ed8eef2..1da4f6cb01b2 100644
> --- a/drivers/misc/vmw_vmci/vmci_queue_pair.c
> +++ b/drivers/misc/vmw_vmci/vmci_queue_pair.c
> @@ -465,9 +465,8 @@ static int qp_alloc_ppn_set(void *prod_q,
>  	for (i =3D 0; i < num_produce_pages; i++) {
>  		unsigned long pfn;
>=20
> -		produce_ppns[i] =3D
> -			produce_q->kernel_if->u.g.pas[i] >> PAGE_SHIFT;
> -		pfn =3D produce_ppns[i];
> +		pfn =3D produce_q->kernel_if->u.g.pas[i] >> PAGE_SHIFT;
> +		produce_ppns[i] =3D pfn;
>=20
>  		/* Fail allocation if PFN isn't supported by hypervisor. */
>  		if (sizeof(pfn) > sizeof(*produce_ppns) @@ -478,9 +477,8
> @@ static int qp_alloc_ppn_set(void *prod_q,
>  	for (i =3D 0; i < num_consume_pages; i++) {
>  		unsigned long pfn;
>=20
> -		consume_ppns[i] =3D
> -			consume_q->kernel_if->u.g.pas[i] >> PAGE_SHIFT;
> -		pfn =3D consume_ppns[i];
> +		pfn =3D consume_q->kernel_if->u.g.pas[i] >> PAGE_SHIFT;
> +		consume_ppns[i] =3D pfn;
>=20
>  		/* Fail allocation if PFN isn't supported by hypervisor. */
>  		if (sizeof(pfn) > sizeof(*consume_ppns)
> --
> 2.17.1

Please ignore this patch.

Thomas Hellstrom reminded me that the dma mask for the device should
be able to take care of this and since the VMCI device uses the default
DMA mask, the device should only get 32-bit addresses. So we should
Just remove the (wrong) overflow checks in vmci_queue_pair.c

Another patch supporting larger addresses will be sent out later.

Thanks,
Jorgen
