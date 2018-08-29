Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7700BC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19C9E2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="W4Bn5WsN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19C9E2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbeH2RPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 13:15:38 -0400
Received: from mail-eopbgr730061.outbound.protection.outlook.com ([40.107.73.61]:65091
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727204AbeH2RPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 13:15:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DvBiP88xnPGeW/Qn3eSX4badb5FOFeKHss1yvKSiR4M=;
 b=W4Bn5WsNZcYkMD5VZ0Phnhd2DY4AzMvnZU3kur0FSkzMhpz33VSS8kfujtIJrqPXA7J6Y/NObR8/G3B2GY3BCdwYhDIxCJgTNAsUqbr8C6Ut90886CrY2l2mmAAoo03wWLraliFbHmS3tSF4dJFBJJHH5ds3+rfvwmtJL1oehRE=
Received: from CO2PR06MB538.namprd06.prod.outlook.com (10.141.199.23) by
 CO2PR06MB907.namprd06.prod.outlook.com (10.141.228.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Wed, 29 Aug 2018 13:18:39 +0000
Received: from CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150]) by CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150%3]) with mapi id 15.20.1080.015; Wed, 29 Aug 2018
 13:18:39 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] lightnvm: encapsule rqd dma allocations
Thread-Topic: [PATCH 2/3] lightnvm: encapsule rqd dma allocations
Thread-Index: AQHUP3Yv1B8v0wHAWUKxOPILV9HfF6TWsZSAgAAFFoA=
Date:   Wed, 29 Aug 2018 13:18:39 +0000
Message-ID: <8B4755CD-3C36-49B4-9F94-1169E19EF090@cnexlabs.com>
References: <1535532980-27672-1-git-send-email-javier@cnexlabs.com>
 <1535532980-27672-3-git-send-email-javier@cnexlabs.com>
 <559e39f2-1601-95ea-9305-6a0566943798@lightnvm.io>
In-Reply-To: <559e39f2-1601-95ea-9305-6a0566943798@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB907;6:O1KH5mtPOQaAmnEWOmyfJLB8NILHNRqlCS7K39bYC9aaGZc2M8Dg2TqoH/QeS7CQtRRiRF08i076kjaXvrt/gfpZpZbzX/HY4Oja/YtbzvH/pIxuafqJiimtMuHGTt0vo6nGZP98XWvJHY2Go/v3AJpFKJT4QhlI7cBbL6wzXHghKLSK9XXTSE790JwXf5n20TiObqhL2TIxMpVRoYJnQsOrSA5RgjFVbPFvrhbRvljc7tmS24gbox4jfK6CyNUGT60CkxJcFdKzeiKOhBdliawZ3bZfvI1nWMZglkx2ocy47gGMAAxnHSurhna9GTJrjWGNHNEd6LIQUdtHCnSVY1gSLiQl1jotikSs/F6/nZag2UzRoZzhz/YNUAoIoV0SJxDvQTQGEbFW0CdbYI30/BA5aycYnIL3k3EhFufd9PPUb3DDvJmEcW2rBPeXEjiop3sIFpCSm49z/hSbWQj6Tg==;5:Wvbz9qJmXe4sB7XE6gHT65ruFlgd6qSkQCHbWiPlaPGOCsnHAu7/iNfvcO6WIRXu8Dp6+dXQBveNdgn8KKsDl92+iTEO1q538xwiDAud1ft8t7Y9nbF+WHNvogfVPEClFw3jtXPpb4n2W9HhIuge5WdFFdSy9uHPVZgzFkH7Gto=;7:rmuIemW4vXK5DyzSDYimOuh225+5uT1hokKmxsgjrwaC1VuvT2NwpiBZo1GdnGU+TwyDt1sGhcHuKwRjnp0KoK8WE3KufkTwAPkqnHISpChfYor0CkWPGrA2QeNxF4w7n0ROUmJ2VwHkmNyQWngQDGDg5vsgI6tPeyfYlbks8QdvDopkKaa2iGKDHpksytP1VTOfiEnXNz1ec2YUCCp5rHdCOgHhU2phttcTV0KXLjrjZatAMAf233rUuTsaG319
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 244dddf9-87f8-4cbd-ca9e-08d60db1ef67
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(49563074)(7193020);SRVR:CO2PR06MB907;
x-ms-traffictypediagnostic: CO2PR06MB907:
x-microsoft-antispam-prvs: <CO2PR06MB90732BA1D19D406DAEAC14DBA090@CO2PR06MB907.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699016);SRVR:CO2PR06MB907;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB907;
x-forefront-prvs: 077929D941
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39840400004)(396003)(376002)(346002)(189003)(199004)(102836004)(54906003)(99936001)(2906002)(83716003)(36756003)(8676002)(105586002)(106356001)(6116002)(26005)(3846002)(186003)(6506007)(53546011)(305945005)(7736002)(5250100002)(4326008)(6512007)(25786009)(53936002)(6916009)(99286004)(76176011)(6486002)(6246003)(6436002)(14454004)(5660300001)(256004)(14444005)(478600001)(2900100001)(66066001)(316002)(86362001)(33656002)(82746002)(11346002)(446003)(229853002)(97736004)(68736007)(476003)(486006)(8936002)(2616005)(81156014)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB907;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 3jwkvt3BTOfFA/IRRWLyhFty9nV9WAOqpI+97shr4W3oUlu9PnRpRaaa4cxUL9UoY33lCwPV/+JrUkqhDvKuzDXBLNPNP4eXVXzv+Tj89EaedUlioGFFJjq1qcDBXuQVB0/AIyZlH1YcpKJc7pKg+BEQZTyUFh6eGZ/Ib3AYmkmotpnwEUPUt9OVQfTBRQZ5rBO/+up5SHaFK5b1n4zQSTojlceCN1q32t//tuwbptgdxPc7Ytz1C70vhZ1aF5OSOPHmK+s8uFnKVJC67xZcCbhuKtN3Ut2HK3JTrXjRGkKLw0QXO7ryr9J+M/2Ik01bfUfI342dDcapDcEQj7funhsxNutA3sFAZQI1hOCra20=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_D36F3E69-FB42-4BDA-B9ED-9BEC89603104";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 244dddf9-87f8-4cbd-ca9e-08d60db1ef67
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2018 13:18:39.5192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB907
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_D36F3E69-FB42-4BDA-B9ED-9BEC89603104
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 29 Aug 2018, at 15.00, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 08/29/2018 10:56 AM, Javier Gonz=C3=A1lez wrote:
>> dma allocations for ppa_list and meta_list in rqd are replicated in
>> several places across the pblk codebase. Make helpers to encapsulate
>> creation and deletion to simplify the code.
>> Signed-off-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
>> ---
>>  drivers/lightnvm/pblk-core.c     | 69 =
+++++++++++++++++++++++++---------------
>>  drivers/lightnvm/pblk-read.c     | 35 ++++++++++----------
>>  drivers/lightnvm/pblk-recovery.c | 29 ++++++-----------
>>  drivers/lightnvm/pblk-write.c    | 15 ++-------
>>  drivers/lightnvm/pblk.h          |  3 ++
>>  5 files changed, 74 insertions(+), 77 deletions(-)
>> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
>> index 09160ec02c5f..767178185f19 100644
>> --- a/drivers/lightnvm/pblk-core.c
>> +++ b/drivers/lightnvm/pblk-core.c
>> @@ -237,6 +237,34 @@ static void pblk_invalidate_range(struct pblk =
*pblk, sector_t slba,
>>  	spin_unlock(&pblk->trans_lock);
>>  }
>>  +int pblk_setup_rqd(struct pblk *pblk, struct nvm_rq *rqd, gfp_t =
mem_flags,
>> +		   bool is_vector)
>=20
>=20
> The mem_flags argument can be removed. It is GFP_KERNEL from all the
> places it is called.
>=20

Thought it was better to have the flexibility in a helper function, but
we can always add it later on if needed...

> is_vector, will be better to do nr_ppas (or similar name). Then
> pblk_submit_read/pblk_submit_read_gc are a bit cleaner.
>=20

We can do that too, yes.


>> +{
>> +	struct nvm_tgt_dev *dev =3D pblk->dev;
>> +
>> +	rqd->meta_list =3D nvm_dev_dma_alloc(dev->parent, mem_flags,
>> +							=
&rqd->dma_meta_list);
>> +	if (!rqd->meta_list)
>> +		return -ENOMEM;
>> +
>> +	if (!is_vector)
>> +		return 0;
>> +
>> +	rqd->ppa_list =3D rqd->meta_list + pblk_dma_meta_size;
>> +	rqd->dma_ppa_list =3D rqd->dma_meta_list + pblk_dma_meta_size;
>=20
> Wrt to is_vector, does it matter if we just set ppa_list and
> dma_ppa_list? If we have them, we use them, else leave them alone?
>=20

If we only have 1 address then ppa_addr is set and the ppa_list attempt
to free in the completion path interpreting ppa_addr as the dma address.
So I don't think so - unless I'm missing something?

>> +
>> +	return 0;
>> +}
>> +
>> +void pblk_clear_rqd(struct pblk *pblk, struct nvm_rq *rqd)
>> +{
>> +	struct nvm_tgt_dev *dev =3D pblk->dev;
>> +
>> +	if (rqd->meta_list)
>> +		nvm_dev_dma_free(dev->parent, rqd->meta_list,
>> +				rqd->dma_meta_list);
>> +}
>=20
> Looks like setup/clear is mainly about managing the metadata. Would
> pblk_alloc_rqd_meta()/pblk_free/rqd_meta be better names? Unless we
> can fold it all into pblk_alloc_rqd/pblk_free_rqd.
>=20

It's not easy to fold them there as we use nvm_rq allocations without
extra space in the rqd for metadata. This is also a problem for rqd
allocated in the stack. But I can change the names to make the
functionality more clear.

Javier

--Apple-Mail=_D36F3E69-FB42-4BDA-B9ED-9BEC89603104
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAluGnS0ACgkQIX4xUKFR
nnSwkRAAhTcqZsLkkGQoaf7zJKEoBhR5SG9ZV2BFWtGaq5Hy9npoLW/gIyVp05TD
2w/XIzamuC5SdG0hRBehPHDjygr2ZZDO3fLHezhTSbeUzBZznKTAVlgSFExuuMrd
yW4e1Fk2oaa5rRuBUgRbfq/7+tR/yJWFrX8yi6xj7K3CAwj/Gk0UuGD7ProaL8gm
A/vHSqrpjckH8EXTetP95qhQs2ti3Df4MDvcLmrFghJjWdmeh7TWTPovD23ztYHj
SYdt2UyRWBxLkap/LGzpIIy96Z3sBtCTkiA2MVu1Sna3bgikDYKuL9gn12WiVILa
BrhQO/J+/ELfpW/uE6GjdT6DcK2XUu/TG+/F6G/U8ISDkn3nZszAcNdEjN/g10WN
L+AyiKMbcxHeroSSiK7sMSjjwgWcKhXcfSwtkOKeR3DRe7fg+DKurZFCiOWOQ0bu
UiT5tiQJoK4lJ+fWlXZmnvcKQlVkeI3fvu8k/cihtKHP4GWas0mPJ4FqUfgF5FnA
ucuXfWeg0J5hwZEhJ22AmpCNDa5AiFoD2ymK/eUxPXZvRJxFt7qyKa8TA/7DyYuJ
EwSL+Em/mppdrqLA0D6f5+NBe7le+s4dH9GAJ7y4BxDitH/ZVGfE+f3JPd8+w9S0
3y6lm0Y7tHoYLJ4YwX1TZA7OQpbdf9UfBI+qH4X2bOs8k3Mev30=
=Bk37
-----END PGP SIGNATURE-----

--Apple-Mail=_D36F3E69-FB42-4BDA-B9ED-9BEC89603104--
