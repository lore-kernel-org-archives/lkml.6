Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84BEC41536
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B9D20685
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="SO5zkZ06"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63B9D20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730441AbeKUDyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:54:35 -0500
Received: from mail-eopbgr680069.outbound.protection.outlook.com ([40.107.68.69]:5067
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726314AbeKUDyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:54:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TlMCiTdWyZNckLf09e3bJsM3WiDRaG7z2KoR+YMBB1k=;
 b=SO5zkZ06chrltfF8sakbGTyscM1POiyMRLBS/KHVl6bWG8Xycjs85zZ86dw2NF1UFvq9yMzD4sRbIHUgm4zOf9AIU07yn3IF9Yg+9grHtujqKOX6Y2UVeW66obBkPDXo8KYsPWoK3o/QavK7Ymw2FeJYhhXtMphvKfEXfkogdE8=
Received: from MWHPR0201MB3628.namprd02.prod.outlook.com (10.167.162.139) by
 MWHPR0201MB3547.namprd02.prod.outlook.com (10.167.162.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.25; Tue, 20 Nov 2018 17:24:16 +0000
Received: from MWHPR0201MB3628.namprd02.prod.outlook.com
 ([fe80::bdb1:a728:19ef:e8fb]) by MWHPR0201MB3628.namprd02.prod.outlook.com
 ([fe80::bdb1:a728:19ef:e8fb%2]) with mapi id 15.20.1294.048; Tue, 20 Nov 2018
 17:24:16 +0000
From:   Radhey Shyam Pandey <radheys@xilinx.com>
To:     Andrea Merello <andrea.merello@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] dmaengine: fix dmaengine_desc_callback_valid() doesn't
 check for callback_result
Thread-Topic: [PATCH] dmaengine: fix dmaengine_desc_callback_valid() doesn't
 check for callback_result
Thread-Index: AQHUfbQ+OHCXhV6E90WqnewOaYTRNKVY65nw
Date:   Tue, 20 Nov 2018 17:24:16 +0000
Message-ID: <MWHPR0201MB3628DCBC951F5DF41F5A796CC7D90@MWHPR0201MB3628.namprd02.prod.outlook.com>
References: <20181116135628.19388-1-andrea.merello@gmail.com>
In-Reply-To: <20181116135628.19388-1-andrea.merello@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=radheys@xilinx.com; 
x-originating-ip: [183.83.158.204]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0201MB3547;6:Rz3VspEX2Id5khVs0sdkQ/N8iZcaohKC2SA3BVBCMZLEO1S6uBZF4RRrbe9ccWPgz2zS+3YopwkFeZ//AOXS8Z3YtDnImBI8VQ50y+8cdKGeg4nHPmA/D1Ir+3II1lDKUFxq2Ztrw7QUK2oXm4t5rortwS5Bq5+nV03Q+clwqzYbz0LtgUsiPy/o16g6W42gRWXf5YuITNKmfI1r5ckqwKi/cP5S/a+ziSU9maLiATZZ6rTwbmvrqAZgkMftghrFDGiJEXKQ5G6ALASPzWNWQX7eQt6mdcQuUxNncwwl4Dtu1uY5d1Da4gHMHris5WSNb+03diHq0gnQ0an5mjhKUpe8eWiVjLoPVwLcAQ7USvQzpCrOFoH/d0DMtjjFaWqdcGgXTXFtctN+Hqat8TbfYVwBjyFp93C+CogyOSazEm2jrvWhFtt7PX4dcSAE+PKQcxmCIXcPt3ByPCp9xb3HVg==;5:o9DTHWHXuCrmLaR53wE/DqW8hh4E8mMKR81Ws/c6E9KdT9wjz6eEhWZHG9kK3BG+nF4oRZwzsq2l2QZW3UMfmqv78fgzVn930eOHyX9uxKGcivZl/LhpFe6pv0y02BzbLTsKtdDoOO85+X/UypIyLfupp0Jf0Vj2R0gttqLm3Qc=;7:mBvLHc1rS1my+o0GNxpNSLw2fetzYsatGnUfwFeyndH2V3iKUNITPSBSqUBiXhsEU3QVW4u+z+oPciLeA6/2MM3leAwNmaGnp/fiuEfX2dlxEl/rJVCMymy67z5jEXIR51414jp6GG7pf8r1JlvNqw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 40a31945-c975-4531-18d9-08d64f0cffa0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR0201MB3547;
x-ms-traffictypediagnostic: MWHPR0201MB3547:
x-microsoft-antispam-prvs: <MWHPR0201MB3547881499B1A21EAD67E6B0C7D90@MWHPR0201MB3547.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231442)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:MWHPR0201MB3547;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0201MB3547;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(39860400002)(376002)(366004)(51914003)(13464003)(43544003)(199004)(189003)(14444005)(106356001)(14454004)(71190400001)(71200400001)(256004)(478600001)(229853002)(25786009)(2906002)(39060400002)(33656002)(105586002)(6246003)(186003)(476003)(446003)(11346002)(26005)(55016002)(102836004)(486006)(2900100001)(6436002)(53936002)(68736007)(76176011)(2501003)(8676002)(53546011)(7696005)(6506007)(97736004)(99286004)(9686003)(66066001)(6116002)(81166006)(2201001)(8936002)(575784001)(305945005)(7736002)(86362001)(4326008)(74316002)(3846002)(5660300001)(316002)(81156014)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0201MB3547;H:MWHPR0201MB3628.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: eDdCQ2Re7UD+pvvlGTXlQjM0wU1RSAG2LK1njkRSrpCMOEIiSXhyMgdaCIEVTTAlPOj2K8+8TOEbLKW+aJ7rY7eSWlBgVX21YlrOb/gq/Lk4CksqpDsapQuP625DfskEKf0T9wlaCpHeNOowqCNe5oie2uCk8PUauZRInyMSL7nmF+gxS65zwqmWHBpMFmx0M0qylcHv3gwpw3mcaJ5/Nve4gt0qsT+A09NRX0ot17Agi0sVPh4WUysmGP3qPpiTDXwDsMPgm7Vs23M/wIVH9Jq68b1ADXDwF8agqQ7YFAUjIIxyEqYsrrhqQ2pCLtOdfz0OaCCfXIBX2wvZ6z5sJmwD3hPMOVDHx/bpW9wgFoc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40a31945-c975-4531-18d9-08d64f0cffa0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 17:24:16.4686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3547
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Andrea Merello <andrea.merello@gmail.com>
> Sent: Friday, November 16, 2018 7:26 PM
> To: vkoul@kernel.org; dan.j.williams@intel.com; dmaengine@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; Radhey Shyam Pandey
> <radheys@xilinx.com>; Andrea Merello <andrea.merello@gmail.com>
> Subject: [PATCH] dmaengine: fix dmaengine_desc_callback_valid() doesn't
> check for callback_result
>=20
> There are two flavors of DMA completion callbacks: callback() and
> callback_result(); the latter takes an additional parameter that carries
> result information.
>=20
> Most dmaengine helper functions that work with callbacks take care of bot=
h
> flavors i.e. dmaengine_desc_get_callback_invoke() first checks for
> callback_result() to be not NULL, and eventually it calls this one;
> otherwise it goes on checking for callback().
>=20
> It seems however that dmaengine_desc_callback_valid() does not care about
> callback_result(), and it returns false in case callback() is NULL but
> callback_result() is not; unless there is a (hidden to me) reason for doi=
ng
> so then I'd say this is wrong.
>=20
> I've hit this by using a DMA controller driver (xilinx_dma) that doesn't
> trigger any callback invocation unless dmaengine_desc_callback_valid()
> returns true, while I had only callback_result() implemented in my client
> driver (which AFAICT is always fine since dmaengine documentation says th=
at
> callback() will be deprecated).

Thanks for the patch. In xilinx_dma driver call to _desc_callback_valid
can be safely removed as callback ptrs are anyway checked in invoke().
There is no much benefit in having redundant checks.

Related to dmaengine_desc_callback_valid extension will let Vinod comment.

>=20
> This patch fixes this by making dmaengine_desc_callback_valid() to return
> true in the said scenario.
>=20
> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
> ---
>  drivers/dma/dmaengine.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/dma/dmaengine.h b/drivers/dma/dmaengine.h
> index 501c0b063f85..0ba2c1f3c55d 100644
> --- a/drivers/dma/dmaengine.h
> +++ b/drivers/dma/dmaengine.h
> @@ -168,7 +168,7 @@ dmaengine_desc_get_callback_invoke(struct
> dma_async_tx_descriptor *tx,
>  static inline bool
>  dmaengine_desc_callback_valid(struct dmaengine_desc_callback *cb)
>  {
> -	return (cb->callback) ? true : false;
> +	return (cb->callback || cb->callback_result);
>  }
>=20
>  #endif
> --
> 2.17.1

