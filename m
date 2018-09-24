Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545A2C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 07:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03FBD208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 07:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dM3qtpg+";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="M80JPn2g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03FBD208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbeIXN66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 09:58:58 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:2882 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbeIXN66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 09:58:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1537775889; x=1569311889;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3SnO3QkFMTrTHIdLEr19expUp9TAoFrSr7DUo6sNlUs=;
  b=dM3qtpg+zdDvHcL91VIwLd5JF1rh5hBExNN4Lj7OoF6A5KAxFF+qePgN
   WzB74i0IQpbIFtDqUhf4GPq5XYUx6i/jHd1wDFehO1QI4VLuakWqlfdy+
   yDLbPfCjsajcakSH4dWUI52+9zZWLXFjJbOo75acbSkFDNv55FYmNrZJh
   1qN3torlFGcl7vjzUCk5fXnWHmMqV68KjeXE6bU1uEZeQJoT8gPYfZH+F
   dHErjnLU8vrtMnH8UOPxLXgxIkdzgmkSPdQzVeSPPK4Smtb5gOvvTc6u5
   pKYlelNhgB6rWKb7bgwbcT8k0RCnxN8B2m93hLcPvg47AfGjpaO6mIESs
   w==;
X-IronPort-AV: E=Sophos;i="5.54,297,1534780800"; 
   d="scan'208";a="90399387"
Received: from mail-bn3nam01lp0179.outbound.protection.outlook.com (HELO NAM01-BN3-obe.outbound.protection.outlook.com) ([216.32.180.179])
  by ob1.hgst.iphmx.com with ESMTP; 24 Sep 2018 15:58:07 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OR3FkFUsScwo5tpX1GucioUVtMdtLT7vz18DyZ3fwp8=;
 b=M80JPn2gzWEtXNJelnBfLS7gxOTFxumaJMeSnkU1bc/XDUmze3fH6FmfKzdy4T5HzFvqPYFx6GcUT0JNsGUnS+ojcx30HALx8jEtNNiRzfoKdqHuKFEvCbt8W7UUVBMh9KJMDMqd8cY9HOdzF9NsVljCCeZuFqZlcvCncGkPZKQ=
Received: from SN6PR04MB4925.namprd04.prod.outlook.com (52.135.114.82) by
 SN6PR04MB4880.namprd04.prod.outlook.com (52.135.114.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.20; Mon, 24 Sep 2018 07:58:04 +0000
Received: from SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::acfd:8e39:37f4:1151]) by SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::acfd:8e39:37f4:1151%4]) with mapi id 15.20.1143.019; Mon, 24 Sep 2018
 07:58:04 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Sayali Lokhande <sayalil@codeaurora.org>,
        "subhashj@codeaurora.org" <subhashj@codeaurora.org>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "vivek.gautam@codeaurora.org" <vivek.gautam@codeaurora.org>,
        "rnayak@codeaurora.org" <rnayak@codeaurora.org>,
        "vinholikatti@gmail.com" <vinholikatti@gmail.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "evgreen@chromium.org" <evgreen@chromium.org>,
        "riteshh@codeaurora.org" <riteshh@codeaurora.org>
CC:     "stummala@codeaurora.org" <stummala@codeaurora.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "jlbec@evilplan.org" <jlbec@evilplan.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V14 1/2] scsi: ufs: set the device reference clock setting
Thread-Topic: [PATCH V14 1/2] scsi: ufs: set the device reference clock
 setting
Thread-Index: AQHUU8/pU5Sym2iywUaSQab1sjVORKT/D4Cl
Date:   Mon, 24 Sep 2018 07:58:04 +0000
Message-ID: <SN6PR04MB49250F1D665127DBA82137A3FC170@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <1537770516-28410-1-git-send-email-sayalil@codeaurora.org>,<1537770516-28410-2-git-send-email-sayalil@codeaurora.org>
In-Reply-To: <1537770516-28410-2-git-send-email-sayalil@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [213.57.170.193]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR04MB4880;6:nyr2gw853BKBjgouO4M9K16mGgHFvbIJRuqcxO3b74HA/fYxdN7FlCsg8j64m312G3nPa0i0s1YeSM3BsOujh7CBdh9q4CH43mkuRtH2vBXThGCbO6B/4bXIiCX2gtS+Lr9kEVVNN4ljsoSj2jxpuHYb9L2i2Y/nEIcJ/oX01LXl0RpSDhP4TB7Eg/NxbMUHtkdnmHEdt0Wiy7mor3mF9e4HN7oIh7SdX6/7vkm1aoJnC3BLcUbuwEjbbj99CNaKpVuVqLr7W8LflxUyV4uIWisZZ2JJ56T7/6zO0DMRuHdwlP497S0xAmJoz+nC0SaYsKC37YyCHvjfS3IukjB8taWbAZZqkGX+xN5dS/IdMnXdID6/VKmW2cVsi4zxqd54bzTnolLgYNVtmnnLUviam9MV9jFTXKNILCnTMAGCFYKKoyRO/E7dnt1aWbI+iJB6gihmvdO5zbbkErnL1Rt1qQ==;5:rPWWf2gOHxShsdcve8dD7FvPS8DUMPABY5xPbspFtn1xrGYLtsbSP6MYPIWfKYftnJ67pQLr4TU+3d1cyAJwDD91IJBKrxelWjtfJ/EhERgfxa9hGn9qdGZIFLKxwTveGqPUJMKtf24+yc+y7ftm7oHtmOnMjB4N3YMrv615btA=;7:wA5KG0cbzOjdAG0yV9/S4j657v17b/qHly1iANzpc1DnhPsGTAjEJACnj3YK/w7CnZNUE84bDgTV2S8wsnD2E005U60RxUPAioeGhkGSKILJ7kXmZTolfGtfDNtXBvKg15uy3HLOg328yGDvqqJtghDS1DkdDZYxQjwT7Cwq00/xgmlTq4hPkWg6nG2f364GuUhvjd4wdjOGeoHW1KDx0y4WHDJT+4/M2W8jcjcYAUgqjGrgqbdG8GxaPsj9mBMN
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f99c1089-39f3-4567-ebb3-08d621f37531
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB4880;
x-ms-traffictypediagnostic: SN6PR04MB4880:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB488000AF13B6F57212E0D811FC170@SN6PR04MB4880.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(3002001)(10201501046)(6055026)(149066)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051);SRVR:SN6PR04MB4880;BCL:0;PCL:0;RULEID:;SRVR:SN6PR04MB4880;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(376002)(39860400002)(136003)(199004)(189003)(256004)(72206003)(68736007)(229853002)(478600001)(8676002)(33656002)(7736002)(2906002)(5660300001)(9686003)(86362001)(7416002)(8936002)(74316002)(53936002)(186003)(71190400001)(55016002)(66066001)(316002)(81156014)(2201001)(305945005)(71200400001)(81166006)(6506007)(5250100002)(2501003)(99286004)(11346002)(105586002)(4326008)(446003)(6436002)(6116002)(3846002)(25786009)(102836004)(26005)(97736004)(6246003)(54906003)(476003)(7696005)(106356001)(110136005)(76176011)(2900100001)(39060400002)(486006)(14454004)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4880;H:SN6PR04MB4925.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 1u+WVG/DKVXJaLRS8S12IBkJ8k/JtV72AWPP2nGebztEkUzljd3dawtz5fX+5enryycpT6qjAsAnIfwwBa+/AHb7JH3O/siKyMyW8MFviFhOQVMfH6ReVXqXBgHJn9v7mNhVcDQb1AXyWdKxg6IGjRxmw8BHF+7979+J4AmuTraZGkvnkcLsDTrkBNYvk+G9ZC3CW2EBYwBfGNMVUFa4B+Dy2wPn8r/xy6bObx9zLG1HnZHmKWw6fXUMjqv7/BZ0iwH+DOqf9D2V1mpEjyhFRY8Ay+UUm6wknCrAfE4BTHuv9GFeb1R7sURyFDUd+1jNnjuexVLWMSi5P/CJNLo06vx7XFc0O0aPfehTY75QfiE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f99c1089-39f3-4567-ebb3-08d621f37531
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 07:58:04.4968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4880
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>+static struct ufs_ref_clk ufs_ref_clk_freqs[] =3D {
>+       {19200000, REF_CLK_FREQ_19_2_MHZ},
>+       {26000000, REF_CLK_FREQ_26_MHZ},
>+       {38400000, REF_CLK_FREQ_38_4_MHZ},
>+       {52000000, REF_CLK_FREQ_52_MHZ},
>+       {0, REF_CLK_FREQ_INVAL},
>+};
>+
>+static inline enum ufs_ref_clk_freq
>+ufs_get_bref_clk_from_hz(u32 freq)
>+{
>+       int i =3D 0;
>+
>+       while (ufs_ref_clk_freqs[i].freq_hz !=3D freq) {
>+               if (!ufs_ref_clk_freqs[i].freq_hz)
>+                       return REF_CLK_FREQ_INVAL;
Is the if clause really needed?
you will return REF_CLK_FREQ_INVAL anyway

>+               i++;
You might overrun here if freq is not what you've expected

>+       }
>+
>+       return ufs_ref_clk_freqs[i].val;
>+}

