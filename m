Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6651C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 05:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 965822086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 05:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="o2s2WRbB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 965822086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbeK0QTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 11:19:04 -0500
Received: from mail-eopbgr760113.outbound.protection.outlook.com ([40.107.76.113]:24439
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728591AbeK0QTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 11:19:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybsZKVA1TYFEFcasAQHBsk8RlMOHLxT9J22RQmPDt3Q=;
 b=o2s2WRbB+atn37iHRLh0ntNNf673s/GyZIZNCeQim6UvycRTfwGFiYLB6r+zNetmOv1LwqwJQrTqzyatsXxCBB6OvgZP6mRUgTgndflK+uGCehjVPzWkJm0NEnptndhzawaL60FBOz8IsSvBYZ/nRJPlqoh+2+gs3N1qF3yDktQ=
Received: from CY4PR2101MB0804.namprd21.prod.outlook.com (52.132.100.38) by
 CY4PR2101MB0866.namprd21.prod.outlook.com (52.132.101.161) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.4; Tue, 27 Nov 2018 05:22:20 +0000
Received: from CY4PR2101MB0804.namprd21.prod.outlook.com
 ([fe80::b922:44e9:332d:aab5]) by CY4PR2101MB0804.namprd21.prod.outlook.com
 ([fe80::b922:44e9:332d:aab5%6]) with mapi id 15.20.1361.019; Tue, 27 Nov 2018
 05:22:20 +0000
From:   KY Srinivasan <kys@microsoft.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        vkuznets <vkuznets@redhat.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 2/2] Drivers: hv: vmbus: offload the handling of channels
 to two workqueues
Thread-Topic: [PATCH 2/2] Drivers: hv: vmbus: offload the handling of channels
 to two workqueues
Thread-Index: AQHUhTATSbMww4cHK0OqMUaDw9hpgaVic+CAgAB/4AA=
Date:   Tue, 27 Nov 2018 05:22:20 +0000
Message-ID: <CY4PR2101MB0804C7E84D48FCDFB61F7569A0D00@CY4PR2101MB0804.namprd21.prod.outlook.com>
References: <20181126022821.11269-1-kys@linuxonhyperv.com>
 <20181126022958.11320-1-kys@linuxonhyperv.com>
 <20181126022958.11320-2-kys@linuxonhyperv.com>
 <20181126193503.GA25649@kroah.com>
In-Reply-To: <20181126193503.GA25649@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2601:600:a280:b50:744e:9865:5066:c4c8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR2101MB0866;6:zvuLCx3Nry/ObBhn9NPG6A3N/yDsfvU8NMUOSfRcXwSRGhekFOld2rGOLP5iUZcOo9qYZEQXUSFGLZw6+r5Zz1mVEPnjJIT6O6LqBNTcyK1Q97dDqJNFOE5P9mQHChxfKEtEsyA+kPVvk+2wkSQHnQQhWNw3MS8itYpXdzd7gw0TGeVnWY5ZjqTkVNLoRvdXU61jxUWdmA/eKPwHIuXgr6y1eVpDskbcHMcxV5Tj4k7VzpI6ycOIIK4TJqK6CNyi+weDYh1c55kVlR/Gh5C7nwLNIo8aYwYZg17bdxBUmbTvwyZ3f4lJGyi1VZtA7vEG3SpiXwDcDrmVR3ZOW9sGkgNba6/tdIT8Yl3q+GpUPthBFpYfkyQ7r65oMjNQMKwxL8tvJHIdouwAbXmInD1xzV+zVBxuSDSezwxtFOcrYFKB2DVyGhULfqjBgnmG4tQL86t20igDvRYeCK8Nkkx2wA==;5:PZzmmN9KXPKx3cQayjq0AqrApkTxkkN7cowdS1JI1jzBqXi4YpAD1AA2P2v+hBauQyvBRtFlbEmCmjvNmHw30aYXhOQ8d2TrTLxbIP0vvt0/nNuYvwiQQxQOAgE/RFITmcuhfQVYUz89EuGgTlhyku7tXzBb1usZa00kPJu88n0=;7:fGMkYCjTelJygrAQikpUU4aL+/GIktxfEFYitFT//Dv9Bz1NHQCTVN6dZ0Tpyy+GdsyqgDYiZqaX3XZnVX6y0T+DLVIr6Hu9tIiPzDrSQp3urXRtFLMCxnyAPDlWjwB/GGfHquuRZ7HyL1x6xTj/7Q==
x-ms-office365-filtering-correlation-id: 504504fc-c002-4b1e-d437-08d654284e23
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(4534185)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR2101MB0866;
x-ms-traffictypediagnostic: CY4PR2101MB0866:
x-ms-exchange-purlcount: -3
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kys@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR2101MB0866895E02753F5BAD2CBBB3A0D00@CY4PR2101MB0866.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(8220035)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231443)(944501430)(2018427008)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:CY4PR2101MB0866;BCL:0;PCL:0;RULEID:;SRVR:CY4PR2101MB0866;
x-forefront-prvs: 086943A159
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(346002)(39860400002)(136003)(189003)(199004)(13464003)(2906002)(6436002)(6916009)(8990500004)(74316002)(316002)(6116002)(305945005)(33656002)(229853002)(22452003)(7736002)(93886005)(55016002)(10090500001)(53936002)(14454004)(9686003)(6246003)(86612001)(14444005)(86362001)(97736004)(4326008)(256004)(478600001)(25786009)(11346002)(102836004)(446003)(476003)(71190400001)(71200400001)(186003)(106356001)(5660300001)(105586002)(10290500003)(8936002)(76176011)(81156014)(8676002)(53546011)(486006)(6506007)(68736007)(54906003)(46003)(99286004)(81166006)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR2101MB0866;H:CY4PR2101MB0804.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: h9RPAdoMcXmXvSTF+VY4SWeejXvNnesmtdG6J5PQ6QUCTspPvY6mNZSDhwfE8PLzgYM6PCAGEJTZgNUQtHRlIdYDOs2/gZRulcO+TjXB71hEJu6vrUJpMj/Jeo2OJZjeKFqoI9eBC7TPpUzpBm1aSgJQJCKspkBG2skmsdEg+Z5YJ5kE2Xq61Yxc+AC8HhJ9DF0AG6fyMq7s5dPgvxEhHWR4/q5ZJjuFAwo1Kqk6BmR8UqPZ41miYc/2DDg43YxLmWahvKZwqy0H/1WKdsH4oeZ7gS3B1MNrnuC08Pw+V74fnfKzdZrCffXAlkAeIS2ZKMuWOFoD5I3nJwFvfSbI41IOv42Suy2u8TOw2FB4vs0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 504504fc-c002-4b1e-d437-08d654284e23
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 05:22:20.4198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2101MB0866
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Monday, November 26, 2018 11:35 AM
> To: KY Srinivasan <kys@microsoft.com>
> Cc: linux-kernel@vger.kernel.org; devel@linuxdriverproject.org;
> olaf@aepfle.de; apw@canonical.com; jasowang@redhat.com; Stephen
> Hemminger <sthemmin@microsoft.com>; Michael Kelley
> <mikelley@microsoft.com>; vkuznets <vkuznets@redhat.com>; Haiyang
> Zhang <haiyangz@microsoft.com>; stable@vger.kernel.org
> Subject: Re: [PATCH 2/2] Drivers: hv: vmbus: offload the handling of chan=
nels
> to two workqueues
>=20
> On Mon, Nov 26, 2018 at 02:29:57AM +0000, kys@linuxonhyperv.com wrote:
> > From: Dexuan Cui <decui@microsoft.com>
> >
> > vmbus_process_offer() mustn't call channel->sc_creation_callback()
> > directly for sub-channels, because sc_creation_callback() ->
> > vmbus_open() may never get the host's response to the
> > OPEN_CHANNEL message (the host may rescind a channel at any time,
> > e.g. in the case of hot removing a NIC), and vmbus_onoffer_rescind()
> > may not wake up the vmbus_open() as it's blocked due to a non-zero
> > vmbus_connection.offer_in_progress, and finally we have a deadlock.
> >
> > The above is also true for primary channels, if the related device
> > drivers use sync probing mode by default.
> >
> > And, usually the handling of primary channels and sub-channels can
> > depend on each other, so we should offload them to different
> > workqueues to avoid possible deadlock, e.g. in sync-probing mode,
> > NIC1's netvsc_subchan_work() can race with NIC2's netvsc_probe() ->
> > rtnl_lock(), and causes deadlock: the former gets the rtnl_lock
> > and waits for all the sub-channels to appear, but the latter
> > can't get the rtnl_lock and this blocks the handling of sub-channels.
> >
> > The patch can fix the multiple-NIC deadlock described above for
> > v3.x kernels (e.g. RHEL 7.x) which don't support async-probing
> > of devices, and v4.4, v4.9, v4.14 and v4.18 which support async-probing
> > but don't enable async-probing for Hyper-V drivers (yet).
> >
> > The patch can also fix the hang issue in sub-channel's handling describ=
ed
> > above for all versions of kernels, including v4.19 and v4.20-rc3.
> >
> > So the patch should be applied to all the existing kernels.
> >
> > Fixes: 8195b1396ec8 ("hv_netvsc: fix deadlock on hotplug")
> > Cc: stable@vger.kernel.org
> > Cc: Stephen Hemminger <sthemmin@microsoft.com>
> > Cc: K. Y. Srinivasan <kys@microsoft.com>
> > Cc: Haiyang Zhang <haiyangz@microsoft.com>
> > Signed-off-by: Dexuan Cui <decui@microsoft.com>
> > Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> > ---
> >  drivers/hv/channel_mgmt.c | 188 +++++++++++++++++++++++++---------
> ----
> >  drivers/hv/connection.c   |  24 ++++-
> >  drivers/hv/hyperv_vmbus.h |   7 ++
> >  include/linux/hyperv.h    |   7 ++
> >  4 files changed, 161 insertions(+), 65 deletions(-)
>=20
> As Sasha pointed out, this patch does not even apply :(

Sorry about that. These patches applied cleanly on my tree (misc-next).
This series is to be applied on top of
patch 0001-Drivers-hv-vmbus-Remove-the-useless-API-vmbus_get_ou.patch
While the patch 0001-Drivers-hv-vmbus-Remove-the-useless-API-vmbus_get_ou.p=
atch
has been committed to the char-misc-testing branch, it is not in the misc-l=
inus  branch and
that is the reason for this problem.

Regards,

K. Y
>=20

