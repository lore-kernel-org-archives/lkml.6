Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B7CECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E2BF2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="H2S7mf1J";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jp9/B+3b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E2BF2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731587AbeGRSJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 14:09:06 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:51762 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731314AbeGRSJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 14:09:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1531935012; x=1563471012;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kBgpJJoVFjmWBEwM9cCVMA0MG3iqkaODasMiB6CrDeg=;
  b=H2S7mf1JZCJFE3Nd8x7tc4tUPRbV+++2OuQ3gblUC8fnYmRmFywcU27y
   s2dgQt9lPddiqb2eUcBoStDaM8o9TGyx9xFyfPKOMe9Pp1JSXiNtAn6hE
   Es5uUhzcOehMh3N8fiOSqXIdrcTvEa+U9UelpXnWqT+ECzXIltgx+DsfF
   sqH6Cb7ovHZ8P3wDJBTNpBqfBwAEx4XIjhsKl8Gg1nU2e6+3TXUySJkTy
   +VzGgZPiyat3fB3gid/S/R0v/ND9q3O8DyHULTgHHx/GA5OwOzXn8q0G3
   oIQCgTcxo+ABrW18vuPB1tWsqV+MCc5IJbzjYp6sJbZ0g+6P3cOnWDhR8
   A==;
X-IronPort-AV: E=Sophos;i="5.51,371,1526313600"; 
   d="scan'208";a="85093056"
Received: from mail-bn3nam04lp0118.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([216.32.180.118])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jul 2018 01:30:08 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lfeu5i3yoGySHaYJxl89uma07wqxxNnYWjHXU/N+21Y=;
 b=jp9/B+3blYm3ueLbjS/5rmujryqXHQPO1slZRnYh6AEqywrlpuRLHTf60wC8ZfoDGVGUbWiddLdjX+rcYFJ48H5JFAX2l06qNaIXmvXxzIy1R9ZKuNwPR/r3ASRPDbqkzrksMIjUsw2l/Lyp5cSf5z2ax/nL4tFLHYgpd4zdzmo=
Received: from CY4PR04MB1191.namprd04.prod.outlook.com (10.173.192.16) by
 CY4PR04MB0808.namprd04.prod.outlook.com (10.172.138.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.20; Wed, 18 Jul 2018 17:30:07 +0000
Received: from CY4PR04MB1191.namprd04.prod.outlook.com
 ([fe80::648d:84ce:4614:6e77]) by CY4PR04MB1191.namprd04.prod.outlook.com
 ([fe80::648d:84ce:4614:6e77%4]) with mapi id 15.20.0952.021; Wed, 18 Jul 2018
 17:30:07 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "vinholikatti@gmail.com" <vinholikatti@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "sayalil@codeaurora.org" <sayalil@codeaurora.org>,
        "riteshh@codeaurora.org" <riteshh@codeaurora.org>,
        "evgreen@chromium.org" <evgreen@chromium.org>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "subhashj@codeaurora.org" <subhashj@codeaurora.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "vivek.gautam@codeaurora.org" <vivek.gautam@codeaurora.org>,
        "rnayak@codeaurora.org" <rnayak@codeaurora.org>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>
Subject: Re: [PATCH V5 2/2] scsi: ufs: Add configfs support for ufs
 provisioning
Thread-Topic: [PATCH V5 2/2] scsi: ufs: Add configfs support for ufs
 provisioning
Thread-Index: AQHUFPGUXhOvLaP+Fk+rdyg77FCdGqSHMD2AgApewYCAAQWrAIAABPAAgAFUl4CAAAwCAIAAxnOAgACPZoA=
Date:   Wed, 18 Jul 2018 17:30:07 +0000
Message-ID: <16c8acaec092ef989ec20d0b006a434bc0de250c.camel@wdc.com>
References: <1530858040-13971-1-git-send-email-sayalil@codeaurora.org>
         <1530858040-13971-3-git-send-email-sayalil@codeaurora.org>
         <CAE=gft5U1-Jo-GvTF7sNAV3Q565AmuUrHpmBdxUL+UwkKxesqA@mail.gmail.com>
         <0dce9e9c-4f93-9857-72ee-f65ff195c41a@codeaurora.org>
         <CAE=gft6_=SQjgv7_kHXKJKa8_45NKKFwwE7UaXsijPpMd35LOg@mail.gmail.com>
         <4cb931e199599314829f5ff750797c88fc123f1f.camel@wdc.com>
         <CAE=gft6zm2mw3rnNuktDe0NWs-NM1CFQw1BUeGhaBi3eoEDXBg@mail.gmail.com>
         <aa697186c00937c18519fe5eb1355d3fc458cfb6.camel@wdc.com>
         <20180718085651.GA23599@kroah.com>
In-Reply-To: <20180718085651.GA23599@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [199.255.44.174]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR04MB0808;7:2jnvbuFelZaI78poe0RfHsgDJ9Q09VFF0JPO0CpUugIA1Dy6VZxupAR9kcMgQkeLQlIwlEi3gcitEhJxPvOnCr+Uys3+IGJKSOYzH63SPdQBu5qzJkxERx9lIC/9rrX8cUlwAYO8jCI8MRhZM2wiodzwDmwXD23fl4DCPgJTlL2WNOCMto2bOlvvOnl/VrHr77HRg1arLUxQf+Eqr7EG4w6PvzcnwpT8NkS18cEVgDP8O0E7wRiyt90Bzaj1M0Ld;20:URQ9AFmkClrAxRRIAG42pJwkHI3tE4TiX80H0/awN01Nmshx260aLIVGzoLOGwd1Af13OXCQh6MCH5LVHovEN6rKVB798rX3W8aw+e5ErbAhQ612wbhyoUmGtcIUWaWLh3xIlZBffWhsaVbZMO372R/zfr+r+1M5eskcNk4WRVQ=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 6f5a34e6-28bd-4b30-6aee-08d5ecd41b25
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:CY4PR04MB0808;
x-ms-traffictypediagnostic: CY4PR04MB0808:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <CY4PR04MB0808CBC800AFF4D8B604499098530@CY4PR04MB0808.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:CY4PR04MB0808;BCL:0;PCL:0;RULEID:;SRVR:CY4PR04MB0808;
x-forefront-prvs: 0737B96801
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(136003)(396003)(39860400002)(189003)(199004)(54906003)(2900100001)(486006)(2906002)(1730700003)(81166006)(7736002)(81156014)(2351001)(4326008)(305945005)(25786009)(256004)(7416002)(93886005)(5660300001)(6486002)(68736007)(14454004)(446003)(11346002)(2616005)(106356001)(99286004)(72206003)(316002)(478600001)(8676002)(2501003)(5250100002)(476003)(8936002)(86362001)(229853002)(3846002)(6116002)(6506007)(26005)(66066001)(97736004)(76176011)(36756003)(186003)(53936002)(105586002)(102836004)(39060400002)(6916009)(6512007)(5640700003)(118296001)(6436002)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR04MB0808;H:CY4PR04MB1191.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Raio1uff3wT3CaqtXdq3bDS58Ak6rbMucg4OC6Fc/WGVmmmBjAn26xiApOuRgxCqTRkrhqgMnWz0hYfobvjxvxE5RAvJtM8VLozue71BA5IwkyVYfyr46NgA4Q5ovksK+3IlnBTByWOcQ+XkOR1YYipCgVBOvL7CUE0wkrXpLuPCFnnH7b5cMm1vEwhhXNTaropk5yf8YNZFZlEpwWoDznVK3lG5R+Q5gAXBTnr/vLm0UhEZn0jXDUO/Dv8b+VdviYkP6r7yjZX95qq6mzfyVSvghAJC7gpczAHgAMgjWXDtB3WUmV5vfD7hJVE6wCXL2rHTth41jYYuiTkyTcpDmP5cZCiRDUyNrPBU6g7Zi4Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-7"
Content-ID: <B6F2F304B1EC044498753A5EA62D7C74@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f5a34e6-28bd-4b30-6aee-08d5ecd41b25
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2018 17:30:07.3577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0808
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-18 at 10:56 +-0200, gregkh+AEA-linuxfoundation.org wrote:
+AD4- On Tue, Jul 17, 2018 at 09:06:35PM +-0000, Bart Van Assche wrote:
+AD4- +AD4- On Tue, 2018-07-17 at 13:23 -0700, Evan Green wrote:
+AD4- +AD4- +AD4- I'm not dead set on binary, since as above I could do it =
either way,
+AD4- +AD4- +AD4- but it seemed worth at least talking through. Let me know=
 what you
+AD4- +AD4- +AD4- think.
+AD4- +AD4-=20
+AD4- +AD4- The configfs documentation (Documentation/filesystems/configfs/=
configfs.txt)
+AD4- +AD4- is clear about this: +ACI-Preferably only one value per file sh=
ould be used.+ACI- So
+AD4- +AD4- I would like to hear the opinion of someone who has more author=
ity than I
+AD4- +AD4- with regard to configfs.
+AD4-=20
+AD4- Don't we have +ACI-binary+ACI- files for configfs?  We have them for =
sysfs, they
+AD4- are for files that are not touched by the kernel and just +ACI-pass-t=
hrough+ACI-
+AD4- to the hardware.  Would that work here as well?

If a new version of the UFS spec would be introduced and that new version o=
f the
spec introduces a new layout for the binary descriptor, will it be possible=
 for
user space software to figure out which version of the binary descriptor fo=
rmat
that has to be used?

Thanks,

Bart.=
