Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C51EC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 20:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C14942133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 20:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="CXBtuuZG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C14942133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730252AbeISCAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 22:00:09 -0400
Received: from mail-eopbgr700106.outbound.protection.outlook.com ([40.107.70.106]:12040
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729200AbeISCAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 22:00:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cV6xLE5nFzoVkhmpUPced5pRHl4l0LXr6P8TG1tUC4=;
 b=CXBtuuZGNmZsiQJ24mUOJwX4wutgAVET55laXOA9qVjW5VDmkO7pAiyP9E8ZBuC+AIumVoYwRueye+e6woXjWEeguVdZNjcQpy62bxVeK9klQ9KEijJ9J/fnos3IJ68PCbYF9H0lG8Ve4sRjUXgTblXvTELYfa3uC/PI6XuOzGw=
Received: from BYAPR08MB4934.namprd08.prod.outlook.com (20.176.255.143) by
 BYAPR08MB4597.namprd08.prod.outlook.com (52.135.234.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.17; Tue, 18 Sep 2018 20:25:51 +0000
Received: from BYAPR08MB4934.namprd08.prod.outlook.com
 ([fe80::d9a4:818:86af:8981]) by BYAPR08MB4934.namprd08.prod.outlook.com
 ([fe80::d9a4:818:86af:8981%5]) with mapi id 15.20.1143.017; Tue, 18 Sep 2018
 20:25:51 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        =?iso-8859-1?Q?Ren=E9_van_Dorst?= <opensource@vdorst.com>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andy Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH net-next v5 06/20] zinc: ChaCha20 MIPS32r2 implementation
Thread-Topic: [PATCH net-next v5 06/20] zinc: ChaCha20 MIPS32r2 implementation
Thread-Index: AQHUT2ssvD8BQbrqKUCOadU3V+C8vaT2fLyA
Date:   Tue, 18 Sep 2018 20:25:51 +0000
Message-ID: <20180918202549.ogfyunppxaha7sfu@pburton-laptop>
References: <20180918161646.19105-1-Jason@zx2c4.com>
 <20180918161646.19105-7-Jason@zx2c4.com>
In-Reply-To: <20180918161646.19105-7-Jason@zx2c4.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR18CA0002.namprd18.prod.outlook.com
 (2603:10b6:404:121::12) To BYAPR08MB4934.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::15)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR08MB4597;6:7n2JfPGE8scowTsBHT61lvrg7GYBrH1oL7yZozFroNUNiHlLohN0I84ESK999jx3eFy+0EiqUtLk4rAvPb9h4ztyyh455lQ7S9kAA7w0WIJJKXZBV9xd8rk9Py1rW7enjbmZ04qrAzdLBJyY3AklYZ38Mmub85quMK2ms7l4N14Gke26YVXcxtFqaTsdSFHAaKTeFmgnj+FbOqGGtJcUrsHcw7+caStNlkoiFIdfQ7MBv7DSVIZt/LtQHnrizV24YOt3Q22J+tZ0YHtBaMWT+JBcXuZdeSE0K1P4BoGex1+7Gyo/+KXc3J6VBVC3gCFa+gyETVYbitCaEjgtuVLl6Y2YckL464V+jjLPh3GelITescgnjYAY9K6wrBoJLxdtMU+VNe1qumD8MSbThXiCUOfQ7xzVrG8Mj66qjLnqsf4/Q0LUXtyxyBeSlNlwqMFQpfmPdwaZwLik0tiRKlwKuw==;5:w0UsW0vSagoTFZBw3SXAgFj00OvCT6ulnbckDmjgsHgQC5GsI8UhPdCpWlNBhAcuYBQgSSExKjcAf5HR0j3jJ5twk6qwp1s/A++rFsNLV5k1/2PkdrAgdjLTQJ4w3fh564TfJTg/JerGuXuSrmSh1u9kOBTg70ltnmBzQynd1ZE=;7:/ofrDs5YUNVogYQ/474tXR9o+nwiu6DntMzoZQzsRSbQGOw02VjOznRFSFM1UlKNqVjam8bnoiQXIrFPZh4788+OHA+AQwni6T8AgAbsTRsnhz+ZiJBGt7sT8TWshZWQwjxaPPNYaezI2TCFaPFj5070EyEJdml/9ISYQ6FRR+u3lYk37QeR/eck2B5YAs1Hzq9cRAkPQ/oj66jnDz2P/263NL1lVPe6pAeuF3nrGssRwThmNuXv74mC8Sxm0s5W
x-ms-office365-filtering-correlation-id: 5121a821-adfe-47dc-3a53-08d61da4ed3b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4597;
x-ms-traffictypediagnostic: BYAPR08MB4597:
x-microsoft-antispam-prvs: <BYAPR08MB4597F1FA409D13DD73E4948FC11D0@BYAPR08MB4597.namprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(3002001)(3231355)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699050);SRVR:BYAPR08MB4597;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4597;
x-forefront-prvs: 0799B1B2D7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(396003)(346002)(136003)(39850400004)(366004)(376002)(189003)(199004)(54906003)(68736007)(8936002)(6116002)(9686003)(3846002)(102836004)(99286004)(25786009)(42882007)(6916009)(97736004)(186003)(81156014)(316002)(58126008)(4326008)(81166006)(446003)(26005)(386003)(33716001)(2900100001)(5660300001)(2906002)(6512007)(6506007)(11346002)(39060400002)(229853002)(6246003)(1076002)(44832011)(486006)(6436002)(52116002)(8676002)(76176011)(305945005)(476003)(6486002)(5250100002)(106356001)(7416002)(14454004)(7736002)(53936002)(33896004)(256004)(478600001)(105586002)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4597;H:BYAPR08MB4934.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: aHJ2780nfB468I/tmdBO1iPw3DX7E0vBANbSs/T4TFzc+JPzbm1GkplZO1ovKfVWW1h/ffh6CcsturI1KGFfpTnBypEGIK2Z1N8O+nn76LUWdGLix814IRJsLtjzv1urGxEyE8T+XQtVAgBEWa0/WUx1hr3PkoBmeE9oo7jZNgvDgUlVIzCiy7UzXfB4nd6yknwB+EIKxdMMP2MpFsSMBmydFq+GymkpK5Jnhp170icGNbS39iMwJKFnbZSC4iBLl3Knm4mewvPe9hi9fP+XBZ2TuKQX33dYc06wXjrohY9kB57XtOyotUX0QP/DQ2JAg07QIisaX4L6VC8mrirrkX50oLXT7T3SXMXM/3CbRLg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <63642532067635489B41DE900E363F85@namprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5121a821-adfe-47dc-3a53-08d61da4ed3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2018 20:25:51.7351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4597
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Tue, Sep 18, 2018 at 06:16:32PM +0200, Jason A. Donenfeld wrote:
> +.Lchacha20_mips_xor_aligned_4_b:
> +	/* STORE_ALIGNED( 4,  0, $sp, 0+CONSTANT_OFS_SP) */
> +	lw	T0, 0+CONSTANT_OFS_SP($sp)
> +	lw	T1, 0(IN)
> +	addu	X0, T0
> +	CPU_TO_LE32(X0)
> +	xor	X0, T1
> +	.set noreorder
> +	bne	OUT, PTR_LAST_ROUND, .Loop_chacha20_rounds
> +	sw	X0, 0(OUT)
> +	.set reorder
> +
> +	.set noreorder
> +	bne	$at, BYTES, .Lchacha20_mips_xor_bytes
> +	/* Empty delayslot, Increase NONCE_0, return NONCE_0 value */
> +	addiu	NONCE_0, 1
> +	.set noreorder

Should this be .set reorder?

Even better - could we not just place the addiu before the bne & drop
the .set noreorder, allowing the assembler to fill the delay slot with
the addiu? Likewise in many other places throughout the patch.

That would be more future proof - particularly if we ever want to adjust
this for use with the nanoMIPS ISA which has no delay slots. It may also
allow the assembler the choice to use compact branches (ie. branches
without visible delay slots) when targeting MIPS32r6. I know neither of
these will currently build this code, but I think avoiding all the
noreorder blocks would be a nice cleanup just for the sake of
readability anyway.

Thanks,
    Paul
