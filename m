Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FF0ECDE3B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 847FF21477
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="BpV3pRWK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 847FF21477
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbeJRDyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 23:54:38 -0400
Received: from mail-hk2apc01on0122.outbound.protection.outlook.com ([104.47.124.122]:6512
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727108AbeJRDyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 23:54:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4N9wv51EPl7tuzkqV7FGtT7RLZECtTj50IM6D9+FTs=;
 b=BpV3pRWKjEZjki4KbFlSyVSS6LBkg5dIGK7ShpGGjaiu1CpaYkE7Kbqg+TrjgxTMJExzie64da5Ba+LXhkcRSRZeCEmQEeQ2F4BlhXtjoYwj8YaK9NrHJbvKX1zqALdrvE9UWHIjCxsJOV8LDMvYJRMLi6nLMqtAMeaFfE/9y6s=
Received: from KU1P153MB0166.APCP153.PROD.OUTLOOK.COM (10.170.173.13) by
 KU1P153MB0200.APCP153.PROD.OUTLOOK.COM (52.133.204.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.1; Wed, 17 Oct 2018 19:57:11 +0000
Received: from KU1P153MB0166.APCP153.PROD.OUTLOOK.COM
 ([fe80::ad50:c821:fe34:27d2]) by KU1P153MB0166.APCP153.PROD.OUTLOOK.COM
 ([fe80::ad50:c821:fe34:27d2%2]) with mapi id 15.20.1273.008; Wed, 17 Oct 2018
 19:57:11 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        KY Srinivasan <kys@microsoft.com>
CC:     "olaf@aepfle.de" <olaf@aepfle.de>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Stable@vger.kernel.org" <Stable@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "apw@canonical.com" <apw@canonical.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        vkuznets <vkuznets@redhat.com>,
        Haiyang Zhang <haiyangz@microsoft.com>
Subject: RE: [PATCH 5/5] Tools: hv: kvp: Fix a warning of buffer overflow with
 gcc 8.0.1
Thread-Topic: [PATCH 5/5] Tools: hv: kvp: Fix a warning of buffer overflow
 with gcc 8.0.1
Thread-Index: AQHUZceh6b+BMOYFh0ycWQy2BKpeOqUi4woAgAD3YKA=
Date:   Wed, 17 Oct 2018 19:57:10 +0000
Message-ID: <KU1P153MB01661641307510EC5952A6B9BFFF0@KU1P153MB0166.APCP153.PROD.OUTLOOK.COM>
References: <20181017031241.669-1-kys@linuxonhyperv.com>
 <20181017031406.773-1-kys@linuxonhyperv.com>
 <20181017031406.773-5-kys@linuxonhyperv.com>
 <20181017050728.GF22447@kroah.com>
In-Reply-To: <20181017050728.GF22447@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-10-17T19:57:06.7968784Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2001:4898:80e8:9:1471:6c20:c44d:d299]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;KU1P153MB0200;6:eh06mrn5f90sjRfpWLKI99EdAmcL720E+7mEAqGfAwbme+PIk7/Pnu7DDvvH7MrEFejFssO5IISfMuf4upG/zZzOP9PA6HGXPcT01EkmII9z5UWjenitSqw6A4UYyMPnzldOl+Mlrm3o+4gfhe3lDgVWpQuH8tna53pxuPDs/HSHsbh7HO6mVb5Io3qHVJ9cgcvAzf0+WW6gKIkjo3l0LiIb6ct9+wKY8jYkbbBLHVecj0XQZKb42hfl2fOWMYf46hxkc26jO6/7FS26umCjmWK3Du1RlfpdshRNrYk1YA4Y3j3IyIu4H+0pPAovu9PyKg8PUjChddIxjlaR282X/dh0LW6bhkwBiehvg8EZ2i7osTG25IGCRocoPVcF4lXH/Gi7uvuDo9Bv+PlmO88P+Z4gZzl2FLrBLoEmKQwGiv5RSeQcGAz3pPK/583Rg/o1lU5Nj8Ni+QbjyHZ0jnvszg==;5:vjCh7yMIhtgjXhsZUiIb7pCed6kFVJ8chOBqDpeyGI1b6Sk5HUi5kpILIs14vdP25jbRV6mjxDCGuqFrrzyMhmz2lw5dPuRZJ7NtcSnDMT0xWMWalt4SscFVGJn4SR/kTxWTPgoTtbwxU0RGmCdRHnBEKLQ2QbhROYkKMYdEqH8=;7:MHkFL5TXtu6zp6Abx+9xLmR1S5hSyOKZ8WA/1JEbd73P4oD2doAYxKUdY9hkeFAys1PhNwIPNSXGTPUN4YSxkD+Y89PZDUM3mxf0Im2J3xrMNLcoxh1eq9vKJ1O8AW5rhybkNzgtQWGALWy4HcVg9w==
x-ms-office365-filtering-correlation-id: d3ba96c0-4101-49c8-783b-08d6346aba08
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:KU1P153MB0200;
x-ms-traffictypediagnostic: KU1P153MB0200:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <KU1P153MB020011FEFCF81CF776727575BFFF0@KU1P153MB0200.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:KU1P153MB0200;BCL:0;PCL:0;RULEID:;SRVR:KU1P153MB0200;
x-forefront-prvs: 08286A0BE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(366004)(39860400002)(396003)(199004)(189003)(5660300001)(9686003)(6506007)(46003)(110136005)(186003)(22452003)(97736004)(54906003)(105586002)(8936002)(2906002)(478600001)(6116002)(106356001)(55016002)(256004)(10090500001)(68736007)(86362001)(99286004)(7696005)(93886005)(316002)(14444005)(76176011)(8990500004)(14454004)(53936002)(107886003)(486006)(86612001)(71190400001)(71200400001)(2900100001)(25786009)(102836004)(33656002)(5250100002)(6246003)(4326008)(6436002)(8676002)(74316002)(305945005)(229853002)(11346002)(446003)(6636002)(1511001)(7736002)(10290500003)(81156014)(81166006)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:KU1P153MB0200;H:KU1P153MB0166.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 2/Jc6U/xaJZq97QOk2H0pmlMSRpyJd3uAqKILQsuXtC/1pO8MQIGBrFrHqByZgpxM+W7XEg17iuWRHlosPeCxV8lE4gU2E/04iGu+7x5tesgIwZCCue+vN6asIM297ac07ghiByxLDFC0DoQXNofoEot9PG83QrG0KE0Msn8LKuK0lCCad6A4LVuXWbHSCTbOQphAZSKGoJMnpTAmjZt5nx0OVcVR/MaCoioQUB5+EtN85tQxvZ64UhylW2ayl8KpXR6KISXbrPASyh8H+AjUWbhCUaVgDemTY83+gaEjkHAlhvT1KiQ20+WGkMO6HJQn/IUdzAYpfoy7wcQg6RF9f/zH48Vyq+A0f6yBWxprFo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3ba96c0-4101-49c8-783b-08d6346aba08
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2018 19:57:10.6935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU1P153MB0200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: devel <driverdev-devel-bounces@linuxdriverproject.org> On Behalf Of
> Greg KH
> Sent: Tuesday, October 16, 2018 22:07
>=20
> On Wed, Oct 17, 2018 at 03:14:06AM +0000, kys@linuxonhyperv.com wrote:
> > From: Dexuan Cui <decui@microsoft.com>
> >
> > The patch fixes:
> >
> > hv_kvp_daemon.c: In function 'kvp_set_ip_info':
> > hv_kvp_daemon.c:1305:2: note: 'snprintf' output between 41 and 4136 byt=
es
> > into a destination of size 4096
> > ...
> > --- a/tools/hv/hv_kvp_daemon.c
> > +++ b/tools/hv/hv_kvp_daemon.c
> > @@ -1176,7 +1176,7 @@ static int kvp_set_ip_info(char *if_name, struct
> hv_kvp_ipaddr_value *new_val)
> >  	int error =3D 0;
> >  	char if_file[PATH_MAX];
> >  	FILE *file;
> > -	char cmd[PATH_MAX];
> > +	char cmd[PATH_MAX * 2];
>=20
> Overkill?

Well, I found the -Wformat-truncation warning can be suppressed by checking
the return value of snprintf, so I'm going to do a new patch for KY to rese=
nd like this:

@@ -1178,6 +1178,7 @@ static int kvp_set_ip_info(char *if_name, struct hv_k=
vp_ipaddr_value *new_val)
        FILE *file;
        char cmd[PATH_MAX];
        char *mac_addr;
+       int str_len;

        /*
         * Set the configuration for the specified interface with
@@ -1301,8 +1302,19 @@ static int kvp_set_ip_info(char *if_name, struct hv_=
kvp_ipaddr_value *new_val)
         * invoke the external script to do its magic.
         */

-       snprintf(cmd, sizeof(cmd), KVP_SCRIPTS_PATH "%s %s",
-                "hv_set_ifconfig", if_file);
+       str_len =3D snprintf(cmd, sizeof(cmd), KVP_SCRIPTS_PATH "%s %s",
+                    "hv_set_ifconfig", if_file);
+
+       /*
+        * This is a little overcautious, but it's necessary to suppress so=
me
+        * false warnings from gcc 8.0.1.
+        */
+       if (str_len <=3D 0 || (unsigned int)str_len >=3D sizeof(cmd)) {
+               syslog(LOG_ERR, "Cmd '%s' (len=3D%d) may be too long",
+                      cmd, str_len);
+               return HV_E_FAIL;
+       }


Thanks,
-- Dexuan
