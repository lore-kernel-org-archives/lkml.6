Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1678C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 928C321536
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="cZpBSiIy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 928C321536
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbeIZX10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 19:27:26 -0400
Received: from mail-eopbgr720125.outbound.protection.outlook.com ([40.107.72.125]:49809
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728236AbeIZX1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 19:27:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arfkxfdgfnCq7rRV/7dvyTtzXzoNJdcSo3/KhgKnRWA=;
 b=cZpBSiIy7ENmwL33ml0dbsyA0fV4lUEMoVKVvwIC+OVsS6UbZnxaYPCjsgVKqK7sZj2UKVf5SziK2DCPAdejXXj5wfuSW6FnHduFCzwA3DLpB4AFknsidTtT3hFh7Bm9pIcBYUHLs+cv4CWl8w53egaFRKNv+GWfU6DZpJocVXI=
Received: from BN6PR21MB0161.namprd21.prod.outlook.com (10.173.200.7) by
 BN6PR21MB0177.namprd21.prod.outlook.com (10.173.200.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.2; Wed, 26 Sep 2018 17:13:25 +0000
Received: from BN6PR21MB0161.namprd21.prod.outlook.com
 ([fe80::2dba:ece1:ce16:551a]) by BN6PR21MB0161.namprd21.prod.outlook.com
 ([fe80::2dba:ece1:ce16:551a%4]) with mapi id 15.20.1207.006; Wed, 26 Sep 2018
 17:13:25 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     Mohammed Gamal <mgamal@redhat.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>, vkuznets <vkuznets@redhat.com>,
        "otubo@redhat.com" <otubo@redhat.com>, cavery <cavery@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
Subject: RE: [PATCH] hv_netvsc: Make sure out channel is fully opened on send
Thread-Topic: [PATCH] hv_netvsc: Make sure out channel is fully opened on send
Thread-Index: AQHUVbbTYlvPQ7JayUeyDPYKZ6ML+KUCxiHA
Date:   Wed, 26 Sep 2018 17:13:24 +0000
Message-ID: <BN6PR21MB01612C60B5421AF2BB09742CCA150@BN6PR21MB0161.namprd21.prod.outlook.com>
References: <1537979659-26979-1-git-send-email-mgamal@redhat.com>
In-Reply-To: <1537979659-26979-1-git-send-email-mgamal@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=haiyangz@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-09-26T17:13:23.3048225Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [96.61.92.94]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR21MB0177;6:dEBupOZK4uPSE87oCb8JLA+y0z3JxxMUH1Pp9BHyyL3Akn20a+aTDcK4cX7gSuBkI5IzS9OrbSqCqeu3Zr2EHjt86F43WtSHZQCn25A7U2puth4IzHggpQNX+ww6kdXocR1U6Tjwe+CMNK2HeFOMhT/QRrr9rRmhzu/doAg45s9sfnKkyDInCzuv/cQQwUHQUwF7cBVxmssiXWbknVzRJoXHDmr3ZBz4TfcCwktNYJrJS+r74MIpRtYAlx8m1rU+Y/dmwZMiHIaIMZDn9vAcJ5nxvfM/qM3SCe43dGddkD68Lgc359CziKEK8ATMBLoEOrsjfdD6KNIjSy5K3DT60HCmRwm2ThE2hrGsc+Y6CR5Q1/K5dA8WF4GqvhV3RyPcucOVjimdyAC49+p5qpoCw5O2TGelUetyIcQ1vS6jxfoptoAKpWyfWg+CJJACYovarpOJkO7RNOvbtSTpdsA4mg==;5:A1d+5TtxlwwD/RzC78j0pKypo43gu0k6txHoaEMUS2aqNA1oQTjxICO/9nrDKqvz5iIaCHOJoOJy3gKGxO+jC/spyhIxr9UHkLw9VG8rW1KeONINUpzvHEucPro3DKPK3MJzE25O1qefX6dM+3fjfT0fOym+gVhWhcETH419EN8=;7:2pazJXDL1JfYmuYshc5G+5joW8BYmkPoZhTbxKXCc2WF0qaVpXCVX6D6ghDax7E/LAp4xr1fZLWX9h/YSmKPyfpqsJTkrvGTDNecW41EFOy3IICYlBDwXxGVt44gOgnveg3iY7hBokV4lgTnKeLKungRYoTEPME2smGKiXOQdbtPKH5mhUanXpa+Z5vHdJGmbwaftvqPsCCsy6RhDx3nVLCGO4r7eVZcMFzXWuUUmnZ+9XIzu29OOd7ZjGHHbcqg
x-ms-office365-filtering-correlation-id: 617be01e-d25e-4e98-df65-08d623d35e99
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:BN6PR21MB0177;
x-ms-traffictypediagnostic: BN6PR21MB0177:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <BN6PR21MB0177294D3585C4D7D92D85FCCA150@BN6PR21MB0177.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(84791874153150)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:BN6PR21MB0177;BCL:0;PCL:0;RULEID:;SRVR:BN6PR21MB0177;
x-forefront-prvs: 08076ABC99
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(366004)(136003)(396003)(189003)(199004)(13464003)(7696005)(14454004)(4326008)(1511001)(34290500001)(10290500003)(2906002)(76176011)(106356001)(6246003)(25786009)(229853002)(105586002)(66066001)(22452003)(8990500004)(6436002)(26005)(6346003)(6306002)(55016002)(102836004)(53936002)(9686003)(2900100001)(256004)(6506007)(5660300001)(478600001)(68736007)(305945005)(2501003)(5250100002)(110136005)(53546011)(97736004)(33656002)(486006)(14444005)(476003)(99286004)(6116002)(86362001)(81156014)(575784001)(71190400001)(54906003)(11346002)(86612001)(966005)(71200400001)(446003)(81166006)(8676002)(10090500001)(3846002)(186003)(74316002)(8936002)(7736002)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR21MB0177;H:BN6PR21MB0161.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haiyangz@microsoft.com; 
x-microsoft-antispam-message-info: 9JunNWEvMAs1bnnwEUeaE3Ymy/5zYDMZtl/Nj0u78xYLMr+sRWowtV1wymKoyKHoP5TgweZovWSusTVEPAsJUsDVe8CtYQxAJc859lRbhV9nvJ4UY5l74wzwxN0e8ZZjRR/5UO5dmXSMnFiyBeezLTzZ/L/bi/zv1t72eSd2WYYcmMbdGaN2iqxtkByz1hOxEmy5mqI/pFaVDKFs8U0GAV40W+oglvoAJD1xdiNNN+hYxwSHIRmNiILYBIVxh5yGhXRFSWfzLxUggjRMI1D4TuvWpDsBbytefOb4mnvXOSzGL8gfb00btmW3j/83egQyUgtwYQGlXrVxbKCwx961YksoMUw35OswNTGpaial1gg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 617be01e-d25e-4e98-df65-08d623d35e99
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2018 17:13:24.9035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0177
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Mohammed Gamal <mgamal@redhat.com>
> Sent: Wednesday, September 26, 2018 12:34 PM
> To: Stephen Hemminger <sthemmin@microsoft.com>; netdev@vger.kernel.org
> Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; vkuznets <vkuznets@redhat.com>;
> otubo@redhat.com; cavery <cavery@redhat.com>; linux-
> kernel@vger.kernel.org; devel@linuxdriverproject.org; Mohammed Gamal
> <mgamal@redhat.com>
> Subject: [PATCH] hv_netvsc: Make sure out channel is fully opened on send
>=20
> Dring high network traffic changes to network interface parameters such a=
s
> number of channels or MTU can cause a kernel panic with a NULL pointer
> dereference. This is due to netvsc_device_remove() being called and
> deallocating the channel ring buffers, which can then be accessed by
> netvsc_send_pkt() before they're allocated on calling
> netvsc_device_add()
>=20
> The patch fixes this problem by checking the channel state and returning
> ENODEV if not yet opened. We also move the call to hv_ringbuf_avail_perce=
nt()
> which may access the uninitialized ring buffer.
>=20
> Signed-off-by: Mohammed Gamal <mgamal@redhat.com>
> ---
>  drivers/net/hyperv/netvsc.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c in=
dex
> fe01e14..75f1b31 100644
> --- a/drivers/net/hyperv/netvsc.c
> +++ b/drivers/net/hyperv/netvsc.c
> @@ -825,7 +825,12 @@ static inline int netvsc_send_pkt(
>  	struct netdev_queue *txq =3D netdev_get_tx_queue(ndev, packet->q_idx);
>  	u64 req_id;
>  	int ret;
> -	u32 ring_avail =3D hv_get_avail_to_write_percent(&out_channel-
> >outbound);
> +	u32 ring_avail;
> +
> +	if (out_channel->state !=3D CHANNEL_OPENED_STATE)
> +		return -ENODEV;
> +
> +	ring_avail =3D hv_get_avail_to_write_percent(&out_channel->outbound);

When you reproducing the NULL ptr panic, does your kernel include the follo=
wing patch?
hv_netvsc: common detach logic
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/=
?id=3D7b2ee50c0cd513a176a26a71f2989facdd75bfea

We call netif_tx_disable(ndev) and netif_device_detach(ndev) before doing t=
he changes=20
on MTU or #channels. So there should be no call to start_xmit() when channe=
l is not ready.

If you see the check for CHANNEL_OPENED_STATE is still necessary on upstrea=
m kernel (including=20
the patch " common detach logic "), we should debug further on the code and=
 find out the=20
root cause.

Thanks,
- Haiyang

