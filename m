Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C13C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 03:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 812382085A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 03:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="YCwCgx0s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfAVDq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 22:46:58 -0500
Received: from mail-eopbgr1300107.outbound.protection.outlook.com ([40.107.130.107]:20928
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726819AbfAVDq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 22:46:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHVQhqNMgPtD/q6/LqZ7F+c2/kywCciFRmeGKt9Kzng=;
 b=YCwCgx0se3a//xyl2X4gczxvx5p3RyA9XFzPRlpmrpVe8gKdg8ojn6vLgRvRLqKJH4GY5C+wj42arFsnNrmnHNjSDiNVTd0RQf/6oVf7/BwY6+GW9s6ywQ+PxK+r4a1F/AgTjf6bVJJMsjbFWpGTGpAFHRCLTxGBTPpGOiGxTcQ=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0202.APCP153.PROD.OUTLOOK.COM (52.133.192.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.5; Tue, 22 Jan 2019 03:46:49 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::400f:fc5:d099:9710]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::400f:fc5:d099:9710%7]) with mapi id 15.20.1580.004; Tue, 22 Jan 2019
 03:46:49 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     kimbrownkd <kimbrownkd@gmail.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Drivers: hv: vmbus: Add mutex lock to channel show
 functions
Thread-Topic: [PATCH] Drivers: hv: vmbus: Add mutex lock to channel show
 functions
Thread-Index: AQHUsfdSwFQKguS0PEqWQ+jwS7iPOKW6o/sw
Date:   Tue, 22 Jan 2019 03:46:48 +0000
Message-ID: <PU1P153MB0169EB8CFC0A69407A8AE2C2BF980@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <20190122020759.GA4054@ubu-Virtual-Machine>
In-Reply-To: <20190122020759.GA4054@ubu-Virtual-Machine>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-01-22T03:46:44.1145032Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4f52563b-f667-4055-a07a-f7985c31f9d2;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [2601:600:a280:1760:c061:215c:bb79:2436]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PU1P153MB0202;6:OSYgxgtvEPTh38WNEwfYJ24iJrE1ZBc8xflk8TEPh8QGCC5dXxnCwCIMk7gyL5mAsAY6nLODxgewX/YfCpr3TgpnzfsXQi63wFj9t5vWGBEksfDKkRY5hssBcfQipJfRV1eq15B7fRbqrM4K32jXGHKAbDAZtr/wU9WJTy7EyTqGxAsPN3LDA8kvtJA+2jCpJubtl3PkrqY+2PdVxdFiqJTm5Pt+dVYvr39U2XxWrPGzX4tDSVY6NqwDxXdQCswvrdBVbsq/JhAtRXbgWA7zH0uiEHe4Fdg6XVmUkYNeR7Pl7DrzrYC93RJXV+Yv6pCXeoV6hu4ycYHknafbaP1JhmICPjxdCeeQ2/p9BBRW2Q4pE+weZdnkC4iDi1jdIeBYGcyOXJ6bG/w28ywqPtXIyY8udemvRZ5Xkmz8SKcZrsQYiRljQzSijgiiBdENN0ChtLcX4ML4qe4+OnChTO0RnQ==;5:5EOqwdfp1DJTq42RyOxzHD3ZxVZbVncWn2/DgBRA1v+PMgfWp4oV07KrGmN+v9jM/yjVRYA71bVALx0atn18CLtd6gi6vukNs6ZX7xtRIRgeqGYhgXY1TsrK+ipUvwgMUwCTq0U+i2NcTrjbWHd1E5bArFOXLi0rMEgUR7HshqgIAEzlVC9WENlQLtz5Thtcg+zS94fQ6xqeRu87Vwvcjg==;7:keFGVc56vFw9Ljdn2/4AQr9laI53VBDkKdbJa625liWrc5L2CrSRLsazWAFPSuMB2m5Un6yZevFmkmNlyRPTqV4BhdI4rlOKwEKc3k1zX5M6IGgN/6hZIfDbDFVR6L0iwWrzmKmu+QNazsjgCCAVcA==
x-ms-office365-filtering-correlation-id: d69cc012-e02b-44da-a375-08d6801c3d07
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0202;
x-ms-traffictypediagnostic: PU1P153MB0202:
x-ms-exchange-purlcount: 1
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB02027ACBFC4441BD3E987012BF980@PU1P153MB0202.APCP153.PROD.OUTLOOK.COM>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(346002)(376002)(39860400002)(136003)(189003)(199004)(22452003)(7696005)(7736002)(11346002)(446003)(305945005)(8936002)(76176011)(81156014)(54906003)(46003)(110136005)(74316002)(33656002)(10090500001)(1511001)(4326008)(25786009)(316002)(81166006)(8676002)(14454004)(39060400002)(186003)(6346003)(53936002)(6246003)(9686003)(6306002)(966005)(478600001)(6436002)(229853002)(71200400001)(486006)(71190400001)(99286004)(6636002)(86612001)(55016002)(86362001)(10290500003)(476003)(102836004)(97736004)(105586002)(6116002)(68736007)(106356001)(8990500004)(53546011)(6506007)(2906002)(14444005)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0202;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3zDfv7mhWSaqvnL01TmNOCgSITHVdK+7kISX2pyRMGzEpcNcbyE7N50lXNDWXPcQb+E8fk2LEkNHoS5eKujemuFA+07nB/GmItvW/TRxXtpY4I/vQ5EqYC73xp4wj97+UMSv2/T3oxh6C3Gen3ztTPwbBLmGcKgIaS1CTzK20aT+Rt+YUjcWXA/9i2dXT2LT6Paxnej9e/YAqLh63+OEApC7B0ljaINyifZujwYo/rq5iN9/01AWsslQIesFAO/VlkI9FY7QJ069CDX4oYTtGgYzBiHcPBSpxK6t2kslYhNU1IPPcLLrfdjGLfsXofc2n74wAOMe4kVVzW+BLDMm1OB5wZh39erdw9du9pnaoczyCk4pWMTO8QXZ3N9NvCtu8ffMcqR2Ieh9cxT8QJBZYXX1HQjSk7NoPBuE4440qtI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d69cc012-e02b-44da-a375-08d6801c3d07
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 03:46:48.6771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0202
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Kimberly Brown <kimbrownkd@gmail.com>
> Sent: Monday, January 21, 2019 6:08 PM
> Subject: [PATCH] Drivers: hv: vmbus: Add mutex lock to channel show funct=
ions
>=20
> The channel level "_show" functions are vulnerable to race conditions.
> Add a mutex lock and unlock around the call to the channel level "_show"
> functions in vmbus_chan_attr_show().
>=20
> This problem was discussed here:
> https://lkml.org/lkml/2018/10/18/830
>=20
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1414,6 +1414,7 @@ static ssize_t vmbus_chan_attr_show(struct kobject
> *kobj,
>  		=3D container_of(attr, struct vmbus_chan_attribute, attr);
>  	const struct vmbus_channel *chan
>  		=3D container_of(kobj, struct vmbus_channel, kobj);
> +	ssize_t ret;
>=20
>  	if (!attribute->show)
>  		return -EIO;
> @@ -1421,7 +1422,10 @@ static ssize_t vmbus_chan_attr_show(struct
> kobject *kobj,
>  	if (chan->state !=3D CHANNEL_OPENED_STATE)
>  		return -EINVAL;
>=20
> -	return attribute->show(chan, buf);
> +	mutex_lock(&vmbus_connection.channel_mutex);
> +	ret =3D attribute->show(chan, buf);
> +	mutex_unlock(&vmbus_connection.channel_mutex);
> +	return ret;
>  }

It looks this patch is already able to fix the original issue:
6712cc9c2211 ("vmbus: don't return values for uninitalized channels"),
as chan->state can't be CHANNEL_OPENED_STATE when
channel->ringbuffer_page is not set up yet, or has been freed.

Thanks,
-- Dexuan
