Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61EA4C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 004B32064A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="SNBHuzx1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 004B32064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbeH2RlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 13:41:17 -0400
Received: from mail-cys01nam02on0068.outbound.protection.outlook.com ([104.47.37.68]:30240
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728360AbeH2RlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 13:41:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=paOXBig5IpiXf9apUDrBNorjQUCyk4+hhnN82v6W9Pc=;
 b=SNBHuzx1qIl/JQBuu/+vfFIhODElzP4SHS8j5/LS5lSkS3a7tU3rXBR5SaXOGupNwhQ8ITn25OdEpzLrVQpTCc07ZAI0rjQA5VUekkIyLVAaBwsVGQCD2DRt24blmOGnZYwzIIQEx/vAzoBUwHx/5ym+sBdeIoZyQrUSvCGw6yQ=
Received: from CO2PR06MB538.namprd06.prod.outlook.com (10.141.199.23) by
 CO2PR06MB523.namprd06.prod.outlook.com (10.141.198.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.14; Wed, 29 Aug 2018 13:41:31 +0000
Received: from CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150]) by CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150%3]) with mapi id 15.20.1080.015; Wed, 29 Aug 2018
 13:41:31 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] lightnvm: encapsule rqd dma allocations
Thread-Topic: [PATCH 2/3] lightnvm: encapsule rqd dma allocations
Thread-Index: AQHUP3Yv1B8v0wHAWUKxOPILV9HfF6TWsZSAgAAFFoCAAAT4AIAAAWoA
Date:   Wed, 29 Aug 2018 13:41:31 +0000
Message-ID: <1CF9AE13-2C0C-426C-8B62-E0B111EDEB5E@cnexlabs.com>
References: <1535532980-27672-1-git-send-email-javier@cnexlabs.com>
 <1535532980-27672-3-git-send-email-javier@cnexlabs.com>
 <559e39f2-1601-95ea-9305-6a0566943798@lightnvm.io>
 <8B4755CD-3C36-49B4-9F94-1169E19EF090@cnexlabs.com>
 <e5d4678d-814d-e2a5-da3e-66245034743f@lightnvm.io>
In-Reply-To: <e5d4678d-814d-e2a5-da3e-66245034743f@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB523;6:x6wybDu30kC8wW2PSpmsg29fhenE+aWmhBD+l+ctqv8iWdzSXFncmoONvAUccARL9+Hl0ixEKWp4k0xx1tuNLN567hsVqp/yJfECHBIaHQQCugd1fwe3GFAzUJfIPoBD57QaXKNuxqvQG1+6Mp0vDF+j6TocFJQgBziCORtpWVvOVm2KnNv1J5KLFeHGggvKlRTiP+ns/9eM3I2sL8rFWiExI78XSMdc0Jxu+mXGnf+Lgx6mulcxjpaXV5c9jTYlN2qC+pCJeXHDeNlGDu8CzYT+HX9u4wnbngosKNIbrJzMBCw01dCei2JiikcBrGEPtYLOq10VMp3EIC4LLbPx8MZCtQmYqj/etyzBUoAD+LSzD3l1lmavdkwbrTY2FN7kVYKlem0wzAhi5dAyOZQXxyayqLqQJ0t4zSlUJVvkG2PMgyzGkcW5yLd3I4ijZxBlOdtZD1fd7/bSOSxP/fyBrw==;5:PSEmNogLHrn6ElfDN+lE+z7UKqw2Mv/DUGLdgx2qkoFv5DZCcS/F5sro/I+pGkkU7DMCdmyAzYl2TcjrGPrej1/ZwoZHsIa5bb6EFA6oarJ8dMpO2fC6BIIATfcdtgC3o7E2i9jKH337zmThM/uOAg6Le60ZO3jVkvWjyp5aA8I=;7:Po9UtT1JWVCOjYZLfrXAlY1srTpRqDe3xE+R10beNgRQsVMscnB/5tszkVXlcC+YeMkJh4q6EA+9EhsfGrAWuhXTCWybMaOVzQvrOd+sdVY8O5rms/T9Ld66Y7alLcRipGnRNIkSMO+LteBJPK61V3eIg/phBsKg4gXqXVoaGe/YBLCZnqY4QwWXCi+EnUb0C48p6aW2TJYHIC1VQrhHe7QfUQIoVsxwzAIMuYGbyHegCoF/HXkVQg3FTPcBezWi
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 0104fda8-9da4-407f-634c-08d60db52103
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(49563074)(7193020);SRVR:CO2PR06MB523;
x-ms-traffictypediagnostic: CO2PR06MB523:
x-microsoft-antispam-prvs: <CO2PR06MB52353C5818E3A2D64C9CB1BBA090@CO2PR06MB523.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:CO2PR06MB523;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB523;
x-forefront-prvs: 077929D941
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(396003)(39840400004)(136003)(346002)(376002)(366004)(199004)(189003)(54906003)(186003)(26005)(53546011)(6506007)(68736007)(316002)(102836004)(14444005)(256004)(2616005)(486006)(11346002)(446003)(476003)(97736004)(3846002)(6116002)(5660300001)(6916009)(99936001)(105586002)(106356001)(93886005)(6246003)(33656002)(25786009)(86362001)(4326008)(66066001)(8936002)(2900100001)(83716003)(81156014)(478600001)(82746002)(53936002)(8676002)(81166006)(5250100002)(6512007)(229853002)(6436002)(36756003)(305945005)(6486002)(7736002)(76176011)(99286004)(14454004)(2906002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB523;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: gNONSedYZQURa64wqqGvvi7M6UeSdYSfw3mdAsDELvHKsspPuXIxMf1e+5rbGarOuhhEEf+oaeHxuOJip3ZOJ0c93C41k7DSH8dJivYUh1F/Ro8KFBSxBV+HcpXOOUqr2mcNtIhPiyHR43rkdbVez9Wx7y23xCobhVAAIPEOYrKSULgshB6BhSeeOdv6Pu5G7zVA3G2GLlNjr7vL5l9nc04pRJJwAGznRGS5o1UPT27yYZfrCHl0ffI8qVK/wfNkvUfLNY029bMsQTq1zSRCd7ODyFOnvj3hAIcAAHCbEjOvtPuIPhjiMbszqCFrDobbTus4ShZwvuIX2/dVlIkFkQSVIWjKEbwa01OCFMCPpzw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_374DE656-96F6-42B8-814F-1FA0FD472052";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0104fda8-9da4-407f-634c-08d60db52103
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2018 13:41:31.1874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB523
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_374DE656-96F6-42B8-814F-1FA0FD472052
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 29 Aug 2018, at 15.36, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 08/29/2018 03:18 PM, Javier Gonzalez wrote:
>>> On 29 Aug 2018, at 15.00, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>=20
>>> On 08/29/2018 10:56 AM, Javier Gonz=C3=A1lez wrote:
>>>> dma allocations for ppa_list and meta_list in rqd are replicated in
>>>> several places across the pblk codebase. Make helpers to =
encapsulate
>>>> creation and deletion to simplify the code.
>>>> Signed-off-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
>>>> ---
>>>>  drivers/lightnvm/pblk-core.c     | 69 =
+++++++++++++++++++++++++---------------
>>>>  drivers/lightnvm/pblk-read.c     | 35 ++++++++++----------
>>>>  drivers/lightnvm/pblk-recovery.c | 29 ++++++-----------
>>>>  drivers/lightnvm/pblk-write.c    | 15 ++-------
>>>>  drivers/lightnvm/pblk.h          |  3 ++
>>>>  5 files changed, 74 insertions(+), 77 deletions(-)
>>>> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
>>>> index 09160ec02c5f..767178185f19 100644
>>>> --- a/drivers/lightnvm/pblk-core.c
>>>> +++ b/drivers/lightnvm/pblk-core.c
>>>> @@ -237,6 +237,34 @@ static void pblk_invalidate_range(struct pblk =
*pblk, sector_t slba,
>>>>  	spin_unlock(&pblk->trans_lock);
>>>>  }
>>>>  +int pblk_setup_rqd(struct pblk *pblk, struct nvm_rq *rqd, gfp_t =
mem_flags,
>>>> +		   bool is_vector)
>>>=20
>>>=20
>>> The mem_flags argument can be removed. It is GFP_KERNEL from all the
>>> places it is called.
>> Thought it was better to have the flexibility in a helper function, =
but
>> we can always add it later on if needed...
>>> is_vector, will be better to do nr_ppas (or similar name). Then
>>> pblk_submit_read/pblk_submit_read_gc are a bit cleaner.
>> We can do that too, yes.
>>>> +{
>>>> +	struct nvm_tgt_dev *dev =3D pblk->dev;
>>>> +
>>>> +	rqd->meta_list =3D nvm_dev_dma_alloc(dev->parent, mem_flags,
>>>> +							=
&rqd->dma_meta_list);
>>>> +	if (!rqd->meta_list)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	if (!is_vector)
>>>> +		return 0;
>>>> +
>>>> +	rqd->ppa_list =3D rqd->meta_list + pblk_dma_meta_size;
>>>> +	rqd->dma_ppa_list =3D rqd->dma_meta_list + pblk_dma_meta_size;
>>>=20
>>> Wrt to is_vector, does it matter if we just set ppa_list and
>>> dma_ppa_list? If we have them, we use them, else leave them alone?
>> If we only have 1 address then ppa_addr is set and the ppa_list =
attempt
>> to free in the completion path interpreting ppa_addr as the dma =
address.
>> So I don't think so - unless I'm missing something?
>=20
> In that case, we could drop is_vector/nr_ppas all together? That would =
be nice.
>=20

The problem is that the metadata region still needs to be used, even if
the ppa_list is not set. Thing that the oob area can be larger than
64bits, so we cannot do the dma address is the actual value trick.

So if encapsulating, we need to know if we need to allocate the ppa_list
or not.

Does it make sense?

>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +void pblk_clear_rqd(struct pblk *pblk, struct nvm_rq *rqd)
>>>> +{
>>>> +	struct nvm_tgt_dev *dev =3D pblk->dev;
>>>> +
>>>> +	if (rqd->meta_list)
>>>> +		nvm_dev_dma_free(dev->parent, rqd->meta_list,
>>>> +				rqd->dma_meta_list);
>>>> +}
>>>=20
>>> Looks like setup/clear is mainly about managing the metadata. Would
>>> pblk_alloc_rqd_meta()/pblk_free/rqd_meta be better names? Unless we
>>> can fold it all into pblk_alloc_rqd/pblk_free_rqd.
>> It's not easy to fold them there as we use nvm_rq allocations without
>> extra space in the rqd for metadata. This is also a problem for rqd
>> allocated in the stack. But I can change the names to make the
>> functionality more clear.
>=20
> Yep, that was what I felt as well. Renaming will be good.

Cool. Will do.

--Apple-Mail=_374DE656-96F6-42B8-814F-1FA0FD472052
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAluGoogACgkQIX4xUKFR
nnRXxRAAxxJ/WsmBXfJiysYosPG+8VK26oBcpmFAF7We79TbP48V1oAYukwgfDGn
79s/umkCmvFOZ7/G3ff56GjUdMiTybAxO2Z8niCgCn7xmafNQ24s6eeJMB4bI/Xi
oNIGpUTyauyZqLhZiRVIw1lvcyxbrL52ze/zA2JW4mh02BszdbAMDGo0hbbvv8TG
SykmiDlxZHB320gVeKNfGL4PJLgs1eQQZw8B/n0TMzmQh9vMmPMbUPqM1UrMZZ3J
cBlkzncOAzLPbHhp58s6GvSVKBQGcnLChbtTXG2a2ruLbBUjuFJL3fWx0WPgbv1Y
dBWhqwHQ19AD/OYOXTSOufLgt17abbhT+76S1F28sszK+Qp05SODjEdEh/DtbBxG
ktI4Onb+OYHOWx5yGkmsejuUMpRIrt0uZpWhDaAcE115u3LVBcCCu0rMJ6LE/4a+
zqmf3dfmmIefHuKYfvO6WLr5qU2BGmCiIJ+gJXk6Eo0pXKVOBMzr+JpVAKUHhYXB
pevuKoDP1iKQ+utPMbXAz1EgHxfifxhciKZHrMQxfh5QLtJ3RhPT77YkmRagkCTs
iGUvtpHNgjJRv47TH20gJr9L0JjM9Y0QNL6/sAkEGguwFDQ5SCdW5vuNVmWd9gwM
zbqiTK9o8GVRHszybkPOuHUn+SD+ebRer46D5owXIdHaDLsE9j0=
=sRjE
-----END PGP SIGNATURE-----

--Apple-Mail=_374DE656-96F6-42B8-814F-1FA0FD472052--
