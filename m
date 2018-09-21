Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706ADECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 20:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE49421522
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 20:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Srvr665R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE49421522
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391436AbeIVCTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 22:19:34 -0400
Received: from mail-by2nam01on0113.outbound.protection.outlook.com ([104.47.34.113]:27036
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391089AbeIVCTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 22:19:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adfEtzKTxk4T8UyEAQoXLBd9heI5Mq6b23GXwbbekp0=;
 b=Srvr665RQqTwPAIYNZvZ/dhxmfRjEY2NIStatIT5hyx6bK3CdPfXKKFGSqg8Yc550VnkozBB43iu4LYvwvQqRpAg7N/C//btQTLzb/YoMmS08ZSlBrA6YFPHz+iG5JuJSY9Np86r2BVqtXDbtve/tgtYt9hFhE8w4mW7WjH0An4=
Received: from BN6PR21MB0161.namprd21.prod.outlook.com (10.173.200.7) by
 BN6PR21MB0737.namprd21.prod.outlook.com (10.173.199.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Fri, 21 Sep 2018 20:29:00 +0000
Received: from BN6PR21MB0161.namprd21.prod.outlook.com
 ([fe80::2dba:ece1:ce16:551a]) by BN6PR21MB0161.namprd21.prod.outlook.com
 ([fe80::2dba:ece1:ce16:551a%4]) with mapi id 15.20.1185.010; Fri, 21 Sep 2018
 20:29:00 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     Stephen Hemminger <stephen@networkplumber.org>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        vkuznets <vkuznets@redhat.com>
Subject: RE: [PATCH net-next, v2, 1/3] hv_netvsc: Add support for LRO/RSC in
 the vSwitch
Thread-Topic: [PATCH net-next, v2, 1/3] hv_netvsc: Add support for LRO/RSC in
 the vSwitch
Thread-Index: AQHUUdoPKfeeW+WL/UOZ5UolOzJblaT7EbCAgAAcIwCAAAFfAA==
Date:   Fri, 21 Sep 2018 20:29:00 +0000
Message-ID: <BN6PR21MB0161724984CA29DE89C64505CA120@BN6PR21MB0161.namprd21.prod.outlook.com>
References: <20180921182037.10077-1-haiyangz@linuxonhyperv.com>
        <20180921182037.10077-2-haiyangz@linuxonhyperv.com>
        <20180921113620.62a004cb@xeon-e3>
        <BN6PR21MB0161160A6A07055B24473327CA120@BN6PR21MB0161.namprd21.prod.outlook.com>
 <20180921132206.417f3714@xeon-e3>
In-Reply-To: <20180921132206.417f3714@xeon-e3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=haiyangz@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-09-21T20:28:59.2467758Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [96.61.92.94]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR21MB0737;6:qyjz+GcMGKn1I1Xpxv6kWZ7GCm15SdeCo+NIFmQkPz/4rk0GLa/R5BynYROqJFhHpMqsp//hjpPQ/qSc5KBHWiJwxc2wT7lH3h0TYteB3uRfLPdkJxLHs0GE6fLZ3OydQHERLdOUa/VpQeH1HDcKU31yceudJa9FmBwoUIzEknyOp1FoN09qN4LMfy7iIfLTHFFaDHx2iDQSg2EWAY3AJNoBQJu3L9fVUGfScZGFprt71IiSMZ1HagJ3YV1RlPDtuHy1X+ltlkNls4QADr9UqF6DjS0u0ltYN6rHSGFIU0mPpU5m3f19VcnPL58mkT11cwUzy/LP6l/O24Y5B5uUBDSGUnmNBMYUhoWoqrgFt8AYqVauTJ77IMQa2JIYBB1AjdNzAmbxy/FDEeKuTQvXmkbtf+GYKJ+q19uiqpEUqaqih2f4PCGQIE2L4xWzstAXi1VM6pV2oDzhhHXSPuIXNQ==;5:vOybtdSL/Yd4hGriOkghRL1Ao5Ol8AIl6+Z9zs+pSSusCqyaRBEarWAiHsFrDP3H3QBKjYNQ+hzA0cegM9IfFs3MiftlHkq97ih5mL/9r2NVIo2+F9GC63AkLfgdRXsieTljBYaVlYLPTTwXhrjBlfp4x1gl3QVf9ct42TgbviU=;7:5iBxIcyKzNMi2HC0mNmSXJblTZoTd7JsVJugJF7gCNUVbCjoOQVkjnc89iLYMpcWm5eWbn8OD/8M0P2efGSHdOin5Iu7RhuEw5+AwdAo0gdi6+e3GwGiXmmeJ5o1Lgmmt7xi4IhBmbyJynUeMezkTTXHbrQEO/a9vcSYoSYRk2gEWjWQy3JUIczNXgqFeUQ7Cf/rCTK5U07YDCSpGFbR5O65Ra0jPrQ6Bt4n5Ljm92ok933SVGs828MlS1s7/lB3
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a89d5fff-525f-4d74-7ee0-08d62000dd94
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:BN6PR21MB0737;
x-ms-traffictypediagnostic: BN6PR21MB0737:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <BN6PR21MB073758DFBE9B4152B6F9A262CA120@BN6PR21MB0737.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149051)(150027)(6041310)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:BN6PR21MB0737;BCL:0;PCL:0;RULEID:;SRVR:BN6PR21MB0737;
x-forefront-prvs: 0802ADD973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(376002)(396003)(346002)(39860400002)(199004)(13464003)(189003)(256004)(102836004)(93886005)(6506007)(7696005)(53546011)(99286004)(76176011)(5660300001)(11346002)(446003)(486006)(186003)(6916009)(8990500004)(476003)(10090500001)(54906003)(26005)(10290500003)(478600001)(22452003)(14454004)(316002)(14444005)(6346003)(105586002)(229853002)(4326008)(6116002)(3846002)(106356001)(2900100001)(81166006)(68736007)(97736004)(5250100002)(8936002)(25786009)(86362001)(8676002)(33656002)(86612001)(71190400001)(6246003)(71200400001)(7736002)(9686003)(305945005)(55016002)(66066001)(2906002)(81156014)(74316002)(6436002)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR21MB0737;H:BN6PR21MB0161.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haiyangz@microsoft.com; 
x-microsoft-antispam-message-info: SkuSDMOmuoHSgdhOtc3GkROfCwEX4hHVRhAruq8mNwm7Q9OuNFZ89i/LZVlmSkQQZ0Vkl4VuCOxyADVek9nZNb/r0TlRJrNW/Gg2L27T1BOMqGs4DVWnLZ3AhBUMeAIG6HEE8rfcpPdnFLea5o5hxTSnWUyKobhz8X+XPyK7hvPyo8V5EVEn4CFGLWzCOo2V4juLwzJeL6yhmHTPLZ5UBatREW4S8DM0Eno98sydsOiCqROzLhJsYPHbWWKpn3tjxLsGUbyM8cm6aBDrh/HMv4d2L8GhLJpdPcmMTNaMLlQRNu27d1aX+3qTgokMZ5m+yq39MffxROzBPnsjA8Un44r6SLReVTbSnpyL8hLtYfE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a89d5fff-525f-4d74-7ee0-08d62000dd94
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2018 20:29:00.7878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0737
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Friday, September 21, 2018 4:22 PM
> To: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: davem@davemloft.net; netdev@vger.kernel.org; olaf@aepfle.de; linux-
> kernel@vger.kernel.org; devel@linuxdriverproject.org; vkuznets
> <vkuznets@redhat.com>
> Subject: Re: [PATCH net-next, v2, 1/3] hv_netvsc: Add support for LRO/RSC=
 in
> the vSwitch
>=20
> On Fri, 21 Sep 2018 18:51:54 +0000
> Haiyang Zhang <haiyangz@microsoft.com> wrote:
>=20
> > > -----Original Message-----
> > > From: Stephen Hemminger <stephen@networkplumber.org>
> > > Sent: Friday, September 21, 2018 2:37 PM
> > > To: Haiyang Zhang <haiyangz@linuxonhyperv.com>
> > > Cc: Haiyang Zhang <haiyangz@microsoft.com>; davem@davemloft.net;
> > > netdev@vger.kernel.org; olaf@aepfle.de;
> > > linux-kernel@vger.kernel.org; devel@linuxdriverproject.org; vkuznets
> > > <vkuznets@redhat.com>
> > > Subject: Re: [PATCH net-next, v2, 1/3] hv_netvsc: Add support for
> > > LRO/RSC in the vSwitch
> > >
> > > On Fri, 21 Sep 2018 18:20:35 +0000
> > > Haiyang Zhang <haiyangz@linuxonhyperv.com> wrote:
> > >
> > > Overall, this looks good. Some minor suggestions.
> > >
> > > > +struct nvsc_rsc {
> > > > +	const struct ndis_pkt_8021q_info *vlan;
> > > > +	const struct ndis_tcp_ip_checksum_info *csum_info;
> > > > +	u8 is_last; /* last RNDIS msg in a vmtransfer_page */
> > > > +	u32 cnt; /* #fragments in an RSC packet */
> > > > +	u32 pktlen; /* Full packet length */
> > > > +	void *data[NVSP_RSC_MAX];
> > > > +	u32 len[NVSP_RSC_MAX];
> > > > +};
> > > > +
> > >
> > > This new state structure is state on a per-channel basis.
> > > Do you really need this to be persistent across packets?
> > >
> > > Could this be on stack or do you need it to handle split packets
> > > arriving in different polls? Or is the stack space a problem?
> > >
> > > Also, maybe data and length could be in one structure since they are
> related.
> >
> > The stack space is a problem. NVSP_RSC_MAX is 562, which is defined by =
host.
> > It will be too large for limited stack space.
> >
> > struct nvsc_rsc includes the data, len, cnt, chksum, vlan for one RSC
> > packet. They are all related to construction of one SKB and its meta
> > data. So I put them in one structure.
> >
> > Thanks,
> > - Haiyang
> >
>=20
> That makes sense. How big is sizeof(struct net_device) + netdev_priv now?
> Need to make sure it doesn't become an order 2 (ie keep it less than 4K).

This patch does not change struct net_device or netdev_priv, so their size
stays the same. Thanks.

