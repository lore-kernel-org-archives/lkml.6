Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2402FC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 20:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B1A4219AB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 20:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Mu7c6GQ8";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="et45Jz7/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B1A4219AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbeHQXJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 19:09:38 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:63523 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbeHQXJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 19:09:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1534536294; x=1566072294;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JvARfvlZb3RSubdjFfNUlyc0WEbAjN1iVJOcvJS1d7A=;
  b=Mu7c6GQ8Y4SsQKzOvThMEsTbQi6F2j0OYet0RuqlU086PUvnp+Gqx1Hu
   nLBMzAY6isPL3Xh5eLd3gNVJ4pEUL1HzSmWhyiLLWuOvBfONWlLlwlHMr
   KckjTN6ZexGjKhPnSW6jylaf2u43TpOnJqKWfNxZ4VX1PomzuEMyhfNkT
   0hzXAqU8k/o4c0zTt2I7akpxQJ8FBcOTYrf8R+dPEiqKsSXYzRJyz6VzA
   EDhFzatzQbJG7EARWb6rkVUOYAiSDyxcexrg8KJZdwBS/RIc1nM5PHJvz
   FRMkJ1YYgWmpLkPvZ6flAGTu5KTHKNGauIx+q/BXbIbpExaoAwAHAVieE
   w==;
X-IronPort-AV: E=Sophos;i="5.53,251,1531756800"; 
   d="scan'208";a="88731586"
Received: from mail-sn1nam04lp0079.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([216.32.180.79])
  by ob1.hgst.iphmx.com with ESMTP; 18 Aug 2018 04:04:53 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XzmM+vEFjhrxvH5LndDwis2nrSxP5AbXZCw9BRlsDmc=;
 b=et45Jz7/iEGutEUPh5K2972ac/CdUwMpCk6CvoRl5pNOw1DEioYkTp3tUGl6/boOc6mgBBTov8d/kQIKUZMxkT7gm6fnQJoYxKQIMNiGlt4JrlcTJG8IBkyw/6KrtE/zVxqSyZO0an5wRlKfEIOZY2UTVqZfC6roxdZo6VoXLj8=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB0688.namprd04.prod.outlook.com (10.172.167.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.20; Fri, 17 Aug 2018 20:04:50 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::855a:8758:5f65:f8ee]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::855a:8758:5f65:f8ee%9]) with mapi id 15.20.1038.026; Fri, 17 Aug 2018
 20:04:50 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "hch@lst.de" <hch@lst.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "hare@suse.de" <hare@suse.de>, "axboe@kernel.dk" <axboe@kernel.dk>,
        "hare@suse.com" <hare@suse.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "keith.busch@intel.com" <keith.busch@intel.com>
Subject: Re: [PATCH 2/5] nvme: register ns_id attributes as default sysfs
 groups
Thread-Topic: [PATCH 2/5] nvme: register ns_id attributes as default sysfs
 groups
Thread-Index: AQHUNmWNIuNkawx+1kuyXDH2tO8f5A==
Date:   Fri, 17 Aug 2018 20:04:50 +0000
Message-ID: <e3861d6482bef5595720c4e296a1c0e864226323.camel@wdc.com>
References: <20180814073305.87255-1-hare@suse.de>
         <20180814073305.87255-3-hare@suse.de>
         <5a4aab8b5f509d8090ad10107b01d11285fe1528.camel@wdc.com>
         <e4c9ba55-ad92-dcb2-1126-38e5ea4c0a13@suse.de>
         <f9ad4ed4685e51a7b0378f11d3ce9d0a76235095.camel@wdc.com>
         <20180817070013.GD11170@lst.de>
In-Reply-To: <20180817070013.GD11170@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [199.255.44.174]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0688;6:xVokVAayygJ8ZCCFNAAeQAABOT0cbid8fAdyIzdqwktPt3V4IYd5ioZm2uG61S1GQWBXW0m1veofDcyLa9JPxwKwgSiX/Akbw9lYX38/LD05hKX3ZJLwIXZf7yGL1MHPaV5ieYO9A/P+aT8n4zI+flLyuU/7EPYCXfPVufpV3qPbQMstZf9tENJkfaZbAzDGNlvyTXvabNssiBDP1xE9hPJ8k5n7fVHmhOroXN6gdevLQ4MdekcKUDiCLB9emkGKjqBSuXChsM+65+6bvpkvAt3I7pLvK9mN3BD6tcsoNSwT0VhFpjVI7ci+e0LLLyx4/pxALGlFG1kJ9zAIPXN/7nNNN53H6WdPVxJZa72ONZ5NoTlKwP1TyoG0YQ0iQ27mwIWJS8wUEPbsPAB21zG3VOnQfkTeAJYYL9fUTawy+cT/5S7PBnzfBNh1zx/UbxpFT/GfZbScdYRIMRkswaPqWA==;5:0k0l4uhRXyUgdw0HcC4A8iv9XZRPhxjC1awAAD/8qvPtMRJYPhV2dLxp+KSpJugfOYbRaRVc67P+MhhWF+VNyrX5OhS+3inNorwO8urmxJbwc5+2r7IcfExzoZt2wAtBTrjv/Vs/pfGAiz452MoyTtAiyUy9scqVqQ79Em7aic4=;7:a/dlxt2zSBu4mB2NgxgaQl6aiDMkQaGrz6j3xK4lrOX7idAc3s1ovn9hFOD71FF2Y9ZCjdxHD0//NR02afQlmND8ZCFbORLGF/Cq2B2KSkjSjgMbCcMPDhOPeAyHPkgqBVuN9cNXbN46xCh38mqBhGzwlQLf1gAluiG6ZhF2tA2WCU5J6P5vcsJ3pl3LIAAvrhBrWNixu/TKJLkNHcp4JWVb1uTdZsuQXSVVzXgfQ5WMxYxuXEvBcq7V6mQTYIk4
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d14163d0-d399-4d73-5ad7-08d6047cb0a0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0688;
x-ms-traffictypediagnostic: MWHPR04MB0688:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB06884DDC530ECF52F45ACA34983D0@MWHPR04MB0688.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699016);SRVR:MWHPR04MB0688;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0688;
x-forefront-prvs: 076777155F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(366004)(39860400002)(396003)(189003)(51444003)(199004)(2501003)(4326008)(99286004)(5250100002)(6512007)(5660300001)(54906003)(486006)(5640700003)(6246003)(8936002)(8676002)(305945005)(25786009)(256004)(7736002)(11346002)(68736007)(446003)(36756003)(2616005)(316002)(81166006)(1730700003)(81156014)(3846002)(14444005)(6116002)(476003)(102836004)(66066001)(118296001)(6506007)(14454004)(72206003)(229853002)(6916009)(2900100001)(186003)(86362001)(575784001)(26005)(478600001)(6486002)(6436002)(76176011)(53936002)(2906002)(2351001)(105586002)(106356001)(93886005)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0688;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: DV2uCL4YaCQ4IGywIYGjoh4REui9WAXgQoAQ9l3pfBqg/Z5l1MRU9MUP3rrDHOne6Hw1jRO8tnTHCwK+U0tqu2B5lMarHXMLwWPiMR+t7L1bcaQryuT22Qmzc2ymv8TXMBsEZMPM04eOTmGS1pCPP5ztf8oFRxiJj0Lz1Tt1h5cJCmpmgNLmxuv2OPEPdrXUd8US0SX0K1RRQBONCCXwCkqqzmlpRBhXoElOjSO8H4CNmDSSwxocWifBMv0/jM5Jz9/9lElR3y0BGte2itEIJFf/zIQH+wCec4dJlqAvX/m3yDSbZS3QUZm/FeQCHYVtNchgT5XXXGGRpuv1xYWPZHgnEEY/ZYamUyYuUMnwfVo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-7"
Content-ID: <5FA981B31A21B248AC1740D610E103B1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d14163d0-d399-4d73-5ad7-08d6047cb0a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2018 20:04:50.2826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0688
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-17 at 09:00 +-0200, hch+AEA-lst.de wrote:
+AD4- On Tue, Aug 14, 2018 at 03:44:57PM +-0000, Bart Van Assche wrote:
+AD4- +AD4- On Tue, 2018-08-14 at 17:39 +-0200, Hannes Reinecke wrote:
+AD4- +AD4- +AD4- While I have considered having nvme+AF8-nvm+AF8-register+=
AF8-sysfs() returning a
+AD4- +AD4- +AD4- pointer I would then have to remove the 'static' declarat=
ion from the
+AD4- +AD4- +AD4- nvm+AF8-dev+AF8-attr+AF8-group+AF8-12/20.
+AD4- +AD4- +AD4- Which I didn't really like, either.
+AD4- +AD4-=20
+AD4- +AD4- Hmm ... I don't see why the static declaration would have to be=
 removed from
+AD4- +AD4- nvm+AF8-dev+AF8-attr+AF8-group+AF8-12/20 if nvme+AF8-nvm+AF8-re=
gister+AF8-sysfs() would return a pointer?
+AD4- +AD4- Am I perhaps missing something?
+AD4-=20
+AD4- No, I think that would be the preferable approach IFF patching the gl=
obal
+AD4- table of groups would be viable.  I don't think it is, though - we ca=
n
+AD4- have both normal NVMe and LightNVM devices in the same system, so we
+AD4- can't just patch it over.
+AD4-=20
+AD4- So we'll need three different attribut group arrays:
+AD4-=20
+AD4- const struct attribute+AF8-group +ACo-nvme+AF8-ns+AF8-id+AF8-attr+AF8=
-groups+AFsAXQ- +AD0- +AHs-
+AD4- 	+ACY-nvme+AF8-ns+AF8-id+AF8-attr+AF8-group,
+AD4- 	NULL,
+AD4- +AH0AOw-
+AD4-=20
+AD4- const struct attribute+AF8-group +ACo-lightnvm12+AF8-ns+AF8-id+AF8-at=
tr+AF8-groups+AFsAXQ- +AD0- +AHs-
+AD4- 	+ACY-nvme+AF8-ns+AF8-id+AF8-attr+AF8-group,
+AD4- 	+ACY-nvm+AF8-dev+AF8-attr+AF8-group+AF8-12,
+AD4- 	NULL,
+AD4- +AH0AOw-
+AD4-=20
+AD4- const struct attribute+AF8-group +ACo-lightnvm20+AF8-ns+AF8-id+AF8-at=
tr+AF8-groups+AFsAXQ- +AD0- +AHs-
+AD4- 	+ACY-nvme+AF8-ns+AF8-id+AF8-attr+AF8-group,
+AD4- 	+ACY-nvm+AF8-dev+AF8-attr+AF8-group+AF8-20,
+AD4- 	NULL,
+AD4- +AH0AOw-
+AD4-=20
+AD4- and a function to select which one to use.

Hello Christoph,

How about applying the patch below on top of Hannes' patch? The patch below
has the advantage that it completely separates the open channel sysfs
attributes from the NVMe core sysfs attributes - the open channel code
doesn't have to know anything about the NVMe core sysfs attributes and the
NVMe core does not have to know anything about the open channel sysfs
attributes.

Thanks,

Bart.


diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8e26d98e9a8f..e0a9e1c5b30e 100644
--- a/drivers/nvme/host/core.c
+-+-+- b/drivers/nvme/host/core.c
+AEAAQA- -2736,7 +-2736,9 +AEAAQA- const struct attribute+AF8-group nvme+AF=
8-ns+AF8-id+AF8-attr+AF8-group +AD0- +AHs-
=20
 const struct attribute+AF8-group +ACo-nvme+AF8-ns+AF8-id+AF8-attr+AF8-grou=
ps+AFsAXQ- +AD0- +AHs-
 	+ACY-nvme+AF8-ns+AF8-id+AF8-attr+AF8-group,
-	NULL, /+ACo- Will be filled in by lightnvm if present +ACo-/
+-+ACM-ifdef CONFIG+AF8-NVM
+-	+ACY-nvme+AF8-nvm+AF8-attr+AF8-group,
+-+ACM-endif
 	NULL,
 +AH0AOw-
=20
+AEAAQA- -3105,8 +-3107,6 +AEAAQA- static void nvme+AF8-alloc+AF8-ns(struct=
 nvme+AF8-ctrl +ACo-ctrl, unsigned nsid)
=20
 	nvme+AF8-get+AF8-ctrl(ctrl)+ADs-
=20
-	if (ns-+AD4-ndev)
-		nvme+AF8-nvm+AF8-register+AF8-sysfs(ns)+ADs-
 	device+AF8-add+AF8-disk(ctrl-+AD4-device, ns-+AD4-disk, nvme+AF8-ns+AF8-i=
d+AF8-attr+AF8-groups)+ADs-
=20
 	nvme+AF8-mpath+AF8-add+AF8-disk(ns, id)+ADs-
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 7bf2f9da6293..b7b19d3561a4 100644
--- a/drivers/nvme/host/lightnvm.c
+-+-+- b/drivers/nvme/host/lightnvm.c
+AEAAQA- -1190,10 +-1190,29 +AEAAQA- static NVM+AF8-DEV+AF8-ATTR+AF8-12+AF8=
-RO(multiplane+AF8-modes)+ADs-
 static NVM+AF8-DEV+AF8-ATTR+AF8-12+AF8-RO(media+AF8-capabilities)+ADs-
 static NVM+AF8-DEV+AF8-ATTR+AF8-12+AF8-RO(max+AF8-phys+AF8-secs)+ADs-
=20
-static struct attribute +ACo-nvm+AF8-dev+AF8-attrs+AF8-12+AFsAXQ- +AD0- +A=
Hs-
+-/+ACo- 2.0 values +ACo-/
+-static NVM+AF8-DEV+AF8-ATTR+AF8-20+AF8-RO(groups)+ADs-
+-static NVM+AF8-DEV+AF8-ATTR+AF8-20+AF8-RO(punits)+ADs-
+-static NVM+AF8-DEV+AF8-ATTR+AF8-20+AF8-RO(chunks)+ADs-
+-static NVM+AF8-DEV+AF8-ATTR+AF8-20+AF8-RO(clba)+ADs-
+-static NVM+AF8-DEV+AF8-ATTR+AF8-20+AF8-RO(ws+AF8-min)+ADs-
+-static NVM+AF8-DEV+AF8-ATTR+AF8-20+AF8-RO(ws+AF8-opt)+ADs-
+-static NVM+AF8-DEV+AF8-ATTR+AF8-20+AF8-RO(maxoc)+ADs-
+-static NVM+AF8-DEV+AF8-ATTR+AF8-20+AF8-RO(maxocpu)+ADs-
+-static NVM+AF8-DEV+AF8-ATTR+AF8-20+AF8-RO(mw+AF8-cunits)+ADs-
+-static NVM+AF8-DEV+AF8-ATTR+AF8-20+AF8-RO(write+AF8-typ)+ADs-
+-static NVM+AF8-DEV+AF8-ATTR+AF8-20+AF8-RO(write+AF8-max)+ADs-
+-static NVM+AF8-DEV+AF8-ATTR+AF8-20+AF8-RO(reset+AF8-typ)+ADs-
+-static NVM+AF8-DEV+AF8-ATTR+AF8-20+AF8-RO(reset+AF8-max)+ADs-
+-
+-static struct attribute +ACo-nvm+AF8-dev+AF8-attrs+AFsAXQ- +AD0- +AHs-
+-	/+ACo- version agnostic attrs +ACo-/
 	+ACY-dev+AF8-attr+AF8-version.attr,
 	+ACY-dev+AF8-attr+AF8-capabilities.attr,
+-	+ACY-dev+AF8-attr+AF8-read+AF8-typ.attr,
+-	+ACY-dev+AF8-attr+AF8-read+AF8-max.attr,
=20
+-	/+ACo- 1.2 attrs +ACo-/
 	+ACY-dev+AF8-attr+AF8-vendor+AF8-opcode.attr,
 	+ACY-dev+AF8-attr+AF8-device+AF8-mode.attr,
 	+ACY-dev+AF8-attr+AF8-media+AF8-manager.attr,
+AEAAQA- -1208,8 +-1227,6 +AEAAQA- static struct attribute +ACo-nvm+AF8-dev=
+AF8-attrs+AF8-12+AFsAXQ- +AD0- +AHs-
 	+ACY-dev+AF8-attr+AF8-page+AF8-size.attr,
 	+ACY-dev+AF8-attr+AF8-hw+AF8-sector+AF8-size.attr,
 	+ACY-dev+AF8-attr+AF8-oob+AF8-sector+AF8-size.attr,
-	+ACY-dev+AF8-attr+AF8-read+AF8-typ.attr,
-	+ACY-dev+AF8-attr+AF8-read+AF8-max.attr,
 	+ACY-dev+AF8-attr+AF8-prog+AF8-typ.attr,
 	+ACY-dev+AF8-attr+AF8-prog+AF8-max.attr,
 	+ACY-dev+AF8-attr+AF8-erase+AF8-typ.attr,
+AEAAQA- -1218,33 +-1235,7 +AEAAQA- static struct attribute +ACo-nvm+AF8-de=
v+AF8-attrs+AF8-12+AFsAXQ- +AD0- +AHs-
 	+ACY-dev+AF8-attr+AF8-media+AF8-capabilities.attr,
 	+ACY-dev+AF8-attr+AF8-max+AF8-phys+AF8-secs.attr,
=20
-	NULL,
-+AH0AOw-
-
-static const struct attribute+AF8-group nvm+AF8-dev+AF8-attr+AF8-group+AF8=
-12 +AD0- +AHs-
-	.name		+AD0- +ACI-lightnvm+ACI-,
-	.attrs		+AD0- nvm+AF8-dev+AF8-attrs+AF8-12,
-+AH0AOw-
-
-/+ACo- 2.0 values +ACo-/
-static NVM+AF8-DEV+AF8-ATTR+AF8-20+AF8-RO(groups)+ADs-
-static NVM+AF8-DEV+AF8-ATTR+AF8-20+AF8-RO(punits)+ADs-
-static NVM+AF8-DEV+AF8-ATTR+AF8-20+AF8-RO(chunks)+ADs-
-static NVM+AF8-DEV+AF8-ATTR+AF8-20+AF8-RO(clba)+ADs-
-static NVM+AF8-DEV+AF8-ATTR+AF8-20+AF8-RO(ws+AF8-min)+ADs-
-static NVM+AF8-DEV+AF8-ATTR+AF8-20+AF8-RO(ws+AF8-opt)+ADs-
-static NVM+AF8-DEV+AF8-ATTR+AF8-20+AF8-RO(maxoc)+ADs-
-static NVM+AF8-DEV+AF8-ATTR+AF8-20+AF8-RO(maxocpu)+ADs-
-static NVM+AF8-DEV+AF8-ATTR+AF8-20+AF8-RO(mw+AF8-cunits)+ADs-
-static NVM+AF8-DEV+AF8-ATTR+AF8-20+AF8-RO(write+AF8-typ)+ADs-
-static NVM+AF8-DEV+AF8-ATTR+AF8-20+AF8-RO(write+AF8-max)+ADs-
-static NVM+AF8-DEV+AF8-ATTR+AF8-20+AF8-RO(reset+AF8-typ)+ADs-
-static NVM+AF8-DEV+AF8-ATTR+AF8-20+AF8-RO(reset+AF8-max)+ADs-
-
-static struct attribute +ACo-nvm+AF8-dev+AF8-attrs+AF8-20+AFsAXQ- +AD0- +A=
Hs-
-	+ACY-dev+AF8-attr+AF8-version.attr,
-	+ACY-dev+AF8-attr+AF8-capabilities.attr,
-
+-	/+ACo- 2.0 attrs +ACo-/
 	+ACY-dev+AF8-attr+AF8-groups.attr,
 	+ACY-dev+AF8-attr+AF8-punits.attr,
 	+ACY-dev+AF8-attr+AF8-chunks.attr,
+AEAAQA- -1255,8 +-1246,6 +AEAAQA- static struct attribute +ACo-nvm+AF8-dev=
+AF8-attrs+AF8-20+AFsAXQ- +AD0- +AHs-
 	+ACY-dev+AF8-attr+AF8-maxocpu.attr,
 	+ACY-dev+AF8-attr+AF8-mw+AF8-cunits.attr,
=20
-	+ACY-dev+AF8-attr+AF8-read+AF8-typ.attr,
-	+ACY-dev+AF8-attr+AF8-read+AF8-max.attr,
 	+ACY-dev+AF8-attr+AF8-write+AF8-typ.attr,
 	+ACY-dev+AF8-attr+AF8-write+AF8-max.attr,
 	+ACY-dev+AF8-attr+AF8-reset+AF8-typ.attr,
+AEAAQA- -1265,25 +-1254,35 +AEAAQA- static struct attribute +ACo-nvm+AF8-d=
ev+AF8-attrs+AF8-20+AFsAXQ- +AD0- +AHs-
 	NULL,
 +AH0AOw-
=20
-static const struct attribute+AF8-group nvm+AF8-dev+AF8-attr+AF8-group+AF8=
-20 +AD0- +AHs-
-	.name		+AD0- +ACI-lightnvm+ACI-,
-	.attrs		+AD0- nvm+AF8-dev+AF8-attrs+AF8-20,
-+AH0AOw-
-
-void nvme+AF8-nvm+AF8-register+AF8-sysfs(struct nvme+AF8-ns +ACo-ns)
+-static umode+AF8-t nvm+AF8-dev+AF8-attrs+AF8-visible(struct kobject +ACo-=
kobj,
+-				     struct attribute +ACo-attr, int index)
 +AHs-
+-	struct device +ACo-dev +AD0- container+AF8-of(kobj, struct device, kobj)=
+ADs-
+-	struct gendisk +ACo-disk +AD0- dev+AF8-to+AF8-disk(dev)+ADs-
+-	struct nvme+AF8-ns +ACo-ns +AD0- disk-+AD4-private+AF8-data+ADs-
 	struct nvm+AF8-dev +ACo-ndev +AD0- ns-+AD4-ndev+ADs-
-	struct nvm+AF8-geo +ACo-geo +AD0- +ACY-ndev-+AD4-geo+ADs-
+-	struct device+AF8-attribute +ACo-dev+AF8-attr +AD0-
+-		container+AF8-of(attr, typeof(+ACo-dev+AF8-attr), attr)+ADs-
=20
-	if (+ACE-ndev)
-		return+ADs-
+-	if (dev+AF8-attr-+AD4-show +AD0APQ- nvm+AF8-dev+AF8-attr+AF8-show)
+-		return attr-+AD4-mode+ADs-
=20
-	switch (geo-+AD4-major+AF8-ver+AF8-id) +AHs-
+-	switch (ndev ? ndev-+AD4-geo.major+AF8-ver+AF8-id : 0) +AHs-
 	case 1:
-		nvme+AF8-ns+AF8-id+AF8-attr+AF8-groups+AFs-1+AF0- +AD0- +ACY-nvm+AF8-dev=
+AF8-attr+AF8-group+AF8-12+ADs-
+-		if (dev+AF8-attr-+AD4-show +AD0APQ- nvm+AF8-dev+AF8-attr+AF8-show+AF8-1=
2)
+-			return attr-+AD4-mode+ADs-
 		break+ADs-
 	case 2:
-		nvme+AF8-ns+AF8-id+AF8-attr+AF8-groups+AFs-1+AF0- +AD0- +ACY-nvm+AF8-dev=
+AF8-attr+AF8-group+AF8-20+ADs-
+-		if (dev+AF8-attr-+AD4-show +AD0APQ- nvm+AF8-dev+AF8-attr+AF8-show+AF8-2=
0)
+-			return attr-+AD4-mode+ADs-
 		break+ADs-
 	+AH0-
+-
+-	return 0+ADs-
 +AH0-
+-
+-const struct attribute+AF8-group nvm+AF8-dev+AF8-attr+AF8-group +AD0- +AH=
s-
+-	.name		+AD0- +ACI-lightnvm+ACI-,
+-	.attrs		+AD0- nvm+AF8-dev+AF8-attrs,
+-	.is+AF8-visible	+AD0- nvm+AF8-dev+AF8-attrs+AF8-visible,
+-+AH0AOw-
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9ba6d67d8e0a..2503f8fd54da 100644
--- a/drivers/nvme/host/nvme.h
+-+-+- b/drivers/nvme/host/nvme.h
+AEAAQA- -551,7 +-551,7 +AEAAQA- static inline void nvme+AF8-mpath+AF8-stop=
(struct nvme+AF8-ctrl +ACo-ctrl)
 void nvme+AF8-nvm+AF8-update+AF8-nvm+AF8-info(struct nvme+AF8-ns +ACo-ns)+=
ADs-
 int nvme+AF8-nvm+AF8-register(struct nvme+AF8-ns +ACo-ns, char +ACo-disk+A=
F8-name, int node)+ADs-
 void nvme+AF8-nvm+AF8-unregister(struct nvme+AF8-ns +ACo-ns)+ADs-
-void nvme+AF8-nvm+AF8-register+AF8-sysfs(struct nvme+AF8-ns +ACo-ns)+ADs-
+-extern const struct attribute+AF8-group nvme+AF8-nvm+AF8-attr+AF8-group+A=
Ds-
 int nvme+AF8-nvm+AF8-ioctl(struct nvme+AF8-ns +ACo-ns, unsigned int cmd, u=
nsigned long arg)+ADs-
 +ACM-else
 static inline void nvme+AF8-nvm+AF8-update+AF8-nvm+AF8-info(struct nvme+AF=
8-ns +ACo-ns) +AHsAfQA7-
+AEAAQA- -562,7 +-562,6 +AEAAQA- static inline int nvme+AF8-nvm+AF8-registe=
r(struct nvme+AF8-ns +ACo-ns, char +ACo-disk+AF8-name,
 +AH0-
=20
 static inline void nvme+AF8-nvm+AF8-unregister(struct nvme+AF8-ns +ACo-ns)=
 +AHsAfQA7-
-static inline void nvme+AF8-nvm+AF8-register+AF8-sysfs(struct nvme+AF8-ns =
+ACo-ns) +AHsAfQA7-
 static inline int nvme+AF8-nvm+AF8-ioctl(struct nvme+AF8-ns +ACo-ns, unsig=
ned int cmd,
 							unsigned long arg)
 +AHs-

