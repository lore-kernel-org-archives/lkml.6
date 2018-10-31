Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B0BC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E58A20847
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="DYJOKCDW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E58A20847
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731527AbeKAIYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:24:24 -0400
Received: from mail-hk2apc01on0130.outbound.protection.outlook.com ([104.47.124.130]:19648
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729429AbeKAIYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:24:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h15o3ZU3mtqfxxZkXhnrU9eNUW9JMwQqJmpMMrFsq4E=;
 b=DYJOKCDWqsgUAHkbTmnlIwHIKSIoK39Rv8mfVPXDyUCvLfTnqNrCfsi1UCuHXkKiTI/5bRSI/DK6gZ79cUR6c5gE/9657kkVs/xWWxUqEGEbtbMLXeycNqkyZpabC0ydfjk9OwMZ77ML19cCoyKtcQ6SpqIvdLy2t5GMDwCEUP4=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0172.APCP153.PROD.OUTLOOK.COM (10.170.189.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.2; Wed, 31 Oct 2018 23:23:54 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::e85a:f0c0:9810:d217]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::e85a:f0c0:9810:d217%3]) with mapi id 15.20.1294.014; Wed, 31 Oct 2018
 23:23:54 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        vkuznets <vkuznets@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
CC:     Haiyang Zhang <haiyangz@microsoft.com>,
        "Stable@vger.kernel.org" <Stable@vger.kernel.org>
Subject: RE: [PATCH V2 3/5] Drivers: hv: kvp: Fix the recent regression caused
 by incorrect clean-up
Thread-Topic: [PATCH V2 3/5] Drivers: hv: kvp: Fix the recent regression
 caused by incorrect clean-up
Thread-Index: AQHUZqDqbasvay7PwkmlHkiKerM2nqUukUpwgAuBcqA=
Date:   Wed, 31 Oct 2018 23:23:54 +0000
Message-ID: <PU1P153MB0169588D48E567E0551D4A9FBFCD0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <20181018050835.27828-1-kys@linuxonhyperv.com>
 <20181018050932.27932-1-kys@linuxonhyperv.com>
 <20181018050932.27932-3-kys@linuxonhyperv.com>
 <CY4PR21MB077329FE239A11054FFDD661D7F60@CY4PR21MB0773.namprd21.prod.outlook.com>
In-Reply-To: <CY4PR21MB077329FE239A11054FFDD661D7F60@CY4PR21MB0773.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-10-24T15:37:42.0398357Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [2601:600:a27f:df20:584e:e773:fba4:7fdb]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PU1P153MB0172;6:G7mz/DfmyrxlRz1JUd89n9FrN7QdldOT6+Qc+P5+ZRjxlH/4X/ICf03edlw9wuvAkfgq8KmkQYYa6zS56/STQ9AdQoqnALB8byZC07INzo3dFhyOEamCS4cLQYQR37J3TfPulDf8/UQAYK8yqhj5ySgGsGZISViYLqg7V9I6j9WIRwZj2Ks9663KGq8cVV1tgBzAEPwSqllDVtwboON/Uzc5vAjjm0LSeq3AxOa44RCyMZUeYNZfbEhBvrxXoyafTSanhSIjVAdhjPUNgSaPNtsmd8ol4zXxqSXQ3DoSn+fl9FSKjgoUv2cqNdu5ePgHtI8Em5+nlIYKAhKtHMnYt5B/Xs9caPuQMSMp2a8m2x/zwiMbhNWg0fd5BweEPBBzJrgWR+MsBfVdsOKlFO4Ilx4K21Q6qUlU/p7rWH1VrYujqj+kHfFfHp5dYgdkgvrrFiNM5N73ltMG1VgcqmAAqg==;5:KCl3eA7eC/uZDB0PxXLXrMV2pQmOi/1DlH8tzvTL0VXNjPfHRV4iQrMIVU9bnPriN7wzZNCRRHuV2v1Tqco1iIL+gWROHRGHuDQyYfUwOQpenIPqkN1WPla32Q41sjAHX4lQTP/OcG9gw4Nr1Fhini0YrsiVV7V2EtNKTLkxDqI=;7:3EKHZf9/crxUpsM5QECz1ke5rSUF8MhPxIHoqihmrWLZkeT15HqDFFVE7IVxLGsMx+sJtXv8ahFemc88UPM9hHEy3uX5dTJy9DZkdZIdn2JMD39IPuevYi5se98bjIxwpl3EDFAFwH7dwCeMDcYgKw==
x-ms-office365-filtering-correlation-id: 02951e2e-0826-4282-7bbe-08d63f87ecd6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0172;
x-ms-traffictypediagnostic: PU1P153MB0172:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB01720C5EFEE5E422EA88243CBFCD0@PU1P153MB0172.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(8220035)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:PU1P153MB0172;BCL:0;PCL:0;RULEID:;SRVR:PU1P153MB0172;
x-forefront-prvs: 084285FC5C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(396003)(376002)(346002)(366004)(199004)(189003)(25786009)(476003)(6506007)(7696005)(1511001)(68736007)(6116002)(11346002)(46003)(446003)(186003)(76176011)(71200400001)(7736002)(486006)(71190400001)(102836004)(305945005)(33656002)(14454004)(74316002)(6246003)(81156014)(4326008)(10290500003)(229853002)(81166006)(478600001)(6636002)(5250100002)(8676002)(105586002)(10090500001)(2201001)(53936002)(2501003)(22452003)(86362001)(6436002)(54906003)(2900100001)(106356001)(316002)(256004)(110136005)(97736004)(5660300001)(86612001)(2906002)(55016002)(99286004)(8936002)(9686003)(93886005)(8990500004)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0172;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: krRZm/GDQ8UWZ258zqaNosV7zAeDvBRgzE6Ghoj9iQrnwwvLPdBMpXZ3zt0lzMRjMlPcvJ8ZFuNNYo/ZilTIgJegpdDki2aeeDL2qz6ns6rvum/+kmYYfYIKM0U8FtXWl4tK06ztEdazo+e5G8OiY3A0/ECwV5j2cYLaLIvoaOZdG5LmBXlJ+Ng2EC6uuID68pvZa/N5ZB1he+7OtNlrIM0xyQXLRRZm/9l6CdjqreqSs4TSQmStCMCLhR7v1fdVr0axC00osGKfj8pcLJtn885R2yM5qVSNgzlqAMAb/AVNQucz30vusSzI8DaR1tmSMeMPJGyIeFx0HVhPu7Qkwx7Zgg6mxArqk3ix6oB/eH8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02951e2e-0826-4282-7bbe-08d63f87ecd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2018 23:23:54.1614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Michael Kelley <mikelley@microsoft.com>
> Sent: Wednesday, October 24, 2018 08:38
> From: kys@linuxonhyperv.com <kys@linuxonhyperv.com>  Sent: Wednesday,
> October 17, 2018 10:10 PM
> > From: Dexuan Cui <decui@microsoft.com>
> >
> > In kvp_send_key(), we do need call process_ib_ipinfo() if
> > message->kvp_hdr.operation is KVP_OP_GET_IP_INFO, because it turns out
> > the userland hv_kvp_daemon needs the info of operation, adapter_id and
> > addr_family. With the incorrect fc62c3b1977d, the host can't get the
> > VM's IP via KVP.
> >
> > And, fc62c3b1977d added a "break;", but actually forgot to initialize
> > the key_size/value in the case of KVP_OP_SET, so the default key_size o=
f
> > 0 is passed to the kvp daemon, and the pool files
> > /var/lib/hyperv/.kvp_pool_* can't be updated.
> >
> > This patch effectively rolls back the previous fc62c3b1977d, and
> > correctly fixes the "this statement may fall through" warnings.
> >
> > This patch is tested on WS 2012 R2 and 2016.
> >
> > Fixes: fc62c3b1977d ("Drivers: hv: kvp: Fix two "this statement may fal=
l
> through" warnings")
> > Signed-off-by: Dexuan Cui <decui@microsoft.com>
> > Cc: K. Y. Srinivasan <kys@microsoft.com>
> > Cc: Haiyang Zhang <haiyangz@microsoft.com>
> > Cc: Stephen Hemminger <sthemmin@microsoft.com>
> > Cc: <Stable@vger.kernel.org>
> > Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> > ---
> >  drivers/hv/hv_kvp.c | 26 ++++++++++++++++++++++----
> >  1 file changed, 22 insertions(+), 4 deletions(-)
> >
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>

Hi Greg,
Can you please take a look at this patch?

We need it to fix a regression introduced by me in:
Fixes: fc62c3b1977d ("Drivers: hv: kvp: Fix two "this statement may fall th=
rough" warnings")

The faulty patch is being meged into the old stable kernels... So we need t=
o
take this patch ASAP. Thanks!

-- Dexuan
