Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF5FC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4B5220841
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="aN5hey+9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4B5220841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392134AbeHPSxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 14:53:01 -0400
Received: from mail-eopbgr720049.outbound.protection.outlook.com ([40.107.72.49]:26822
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388913AbeHPSxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 14:53:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73++gCV7yOlAqG1p+n8fGPurasSrOcM5lQ8AacgHZRY=;
 b=aN5hey+9GI5xWWlpfGhfjcpFJ1LswHfmVANqQcXG2qKrtriCGfUvDlaWKGXMXHlpvUSx6asYLu5qQ3GKCDxAAmM/fQsUustkuObTBaS/KpFKn5gMZoMvinM/DATdbV3Hc1Dsbo5ZKzUeADUgDbCV+DvDQ4KKWxKNUXIts67j6do=
Received: from CO2PR06MB538.namprd06.prod.outlook.com (10.141.199.23) by
 CO2PR06MB681.namprd06.prod.outlook.com (10.141.226.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.22; Thu, 16 Aug 2018 15:53:38 +0000
Received: from CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150]) by CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150%3]) with mapi id 15.20.1059.021; Thu, 16 Aug 2018
 15:53:34 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC:     "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        Heiner Litz <hlitz@ucsc.edu>,
        Young Tack Tack Jin <youngtack.jin@circuitblvd.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 0/1] lightnvm: move bad block and chunk state logic
 to core
Thread-Topic: [RFC PATCH v2 0/1] lightnvm: move bad block and chunk state
 logic to core
Thread-Index: AQHUNVUeXq4DdiVw8EyZjeI6nLyujqTCh+WA
Date:   Thu, 16 Aug 2018 15:53:34 +0000
Message-ID: <00698BD3-4382-4033-908F-BEB63E7FAD57@cnexlabs.com>
References: <20180816113417.3641-1-mb@lightnvm.io>
In-Reply-To: <20180816113417.3641-1-mb@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB681;6:U0zlz5weVdvr5feLnesv8fxNgpPTmvQ20Cq3Fck4h7fEeGxpjbOEwJDykSc9GFuMGIGuCB8b46/4D/Svorc+Nok7ijM72sPvK6KNVaZcKXfZFdHB80624fk/RgZotyXe6kKh8suTrcY7iD+VHPHWoPEX20Yrv9/vDXQhESRjvVp2nsvD50XxIDWI3qqHIRWC2T14kfMi0vI/GEg/xLUz6FgsGMXy0mdg/gSh64tSIbcWSms+ReclmkMd1xQWmw0k0szS0Pum1WJOcOscnP07agwT0cVyHAm5S7iwmosPdVPoMFiLQOjkVBOJ4GPhVBEBDXAN80Ce+jrqP8ff4vQcpvdfYOLaFG+bIZx+PVphurTySp7vnRVUrgMVcQNkYxDmqWQnRHwb+H7vPs7DexVZd2yzk8YAD0udMb5beyfMssJzOuHC5bq8ldEI/qVKubtmspTm6DeHDeYc9EOSrQKw3A==;5:/chVvjvZVwtcHDQ/mnxzZDh4xg8JENUeju6+ABF+1NvrUyD0ovCZOsiKC3LbwqwHEO3LFRrO2yuUii9UKbDh37SeENv29mXhc2YnNpxlz8AnPZjkvXlDXJ5o2oGT6ywrKAsrtxmZ/WK/VaR9PPtQTU3icoG6iM3+xvoQiuM3tdE=;7:l++gf84KQTOCOn9vamXvQ0NvNVAabuEtVlch/PTa9e30C0ODm2vl2AhvunRQk5SdTUVefA+Way0CllmS7HE9umpAnIEUQiF85cjQbQcEgrMK0FKl4aBedoBHDfBBFrNjh3b1Kk7fI5IdTY7yZ9f5wXjxvUBqN5cpRN5ZM4hYrzP5/xUbM7b9+f05ANKjOIKIxjPEhnJboEIYgRV+Urnl23MnIEcvtl3hWwdhY3biFuDLVVRkL1R3AjNBBrKkqdM9
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(136003)(346002)(366004)(376002)(396003)(39840400004)(199004)(189003)(105586002)(83716003)(8676002)(486006)(7736002)(478600001)(2616005)(6306002)(6512007)(81156014)(26005)(2906002)(14444005)(14454004)(6436002)(99936001)(3846002)(106356001)(966005)(305945005)(81166006)(5250100002)(33656002)(97736004)(476003)(6916009)(446003)(6116002)(36756003)(256004)(11346002)(99286004)(86362001)(8936002)(68736007)(82746002)(4326008)(229853002)(217873002)(25786009)(6246003)(6486002)(53936002)(316002)(54906003)(186003)(2900100001)(5660300001)(102836004)(6506007)(76176011)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB681;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 2f043596-b07c-4361-a3f2-08d603906c4d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(49563074)(7193020);SRVR:CO2PR06MB681;
x-ms-traffictypediagnostic: CO2PR06MB681:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-microsoft-antispam-prvs: <CO2PR06MB68140F79C9366839E78ADDBBA3E0@CO2PR06MB681.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(166708455590820);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(8121501046)(5005006)(823301047)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(201708071742011)(7699016);SRVR:CO2PR06MB681;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB681;
x-forefront-prvs: 07665BE9D1
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: hwp6CThL1yfZpJmTPIEZ9s3T4O03iBedaivywU8deLBXX3Qcy2GDxouDmoVloATvwaZSm1Co9wTEyneVhTSWHkw+qLNSC3qqIfa+3uPrjizYKNCt/ks8m0mqXRPDe9+1N3oKHRyVowJSEUdyir0duqqgMC7G25q7JQG0wutnPqQfVGtBJRYfiM+gKDhrorRuOtUk9Rd066SHmahFHbMnEm1YmESPOSNziWvVtky5gmHyJ4vJ4uKj8wIjmEh8auhVBDii5cenO2v0PmwZP8Rya3yxWNujQvDbNYnXOgRefoeEV8tOftYx2xP9keFq0+GDf7KKa/j3VWFdGEwVpt1x1zmyu0gWclOikJPpdEtQeQA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_9EAC1DCF-70BC-4BA1-A748-4D710507DC92";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f043596-b07c-4361-a3f2-08d603906c4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2018 15:53:34.2017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB681
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_9EAC1DCF-70BC-4BA1-A748-4D710507DC92
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 16 Aug 2018, at 13.34, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> This patch moves the 1.2 and 2.0 block/chunk metadata retrieval to
> core.
>=20
> Hi Javier, I did not end up using your patch. I had misunderstood what
> was implemented. Instead I implemented the detection of the each chunk =
by
> first sensing the first page, then the last page, and if the chunk
> is sensed as open, a per page scan will be executed to update the =
write
> pointer appropriately.
>=20

I see why you want to do it this way for maintaining the chunk
abstraction, but this is potentially very inefficient as blocks not used
by any target will be recovered unnecessarily. Note that in 1.2, it is
expected that targets will need to recover the write pointer themselves.
What is more, in the normal path, this will be part of the metadata
being stored so no wp recovery is needed. Still, this approach forces
recovery on each 1.2 instance creation (also on factory reset). In this
context, you are right, the patch I proposed only addresses the double
erase issue, which was the original motivator, and left the actual
pointer recovery to the normal pblk recovery process.

Besides this, in order to consider this as a real possibility, we need
to measure the impact on startup time. For this, could you implement
nvm_bb_scan_chunk() and nvm_bb_chunk_sense() more efficiently by
recovering (i) asynchronously and (ii) concurrently across luns so that
we can establish the recovery cost more fairly? We can look at a
specific penalty ranges afterwards.

Also, the recovery scheme in pblk will change significantly by doing
this, so I assume you will send a followup patchset reimplementing
recovery for the 1.2 path? I am rebasing wp recovery for 2.0 now and
expect to post in the next couple of days. This logic can be reused, but
it requires some work and testing. A preliminary version of this patch
can be found here [1].

> Note that one needs a real drive to test the implementation. The 1.2
> qemu implementation is lacking. I did update it a bit, such that
> it defaults to all blocks being free. It can be picked up in the ocssd
> qemu repository.

I added patches to fix store/recover chunk metadata in qemu. This
should help you generating an arbitrary chunk state and test sanity for
these patches.

Can you share the tests that you have run to verify this patch? I can
run them on a 1.2 device next week (preferably on a V3 that includes the
comments above).

[1] https://github.com/OpenChannelSSD/linux/commits/for-4.20/pblk: =
3c9c548a83ce

Javier

--Apple-Mail=_9EAC1DCF-70BC-4BA1-A748-4D710507DC92
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlt1nfsACgkQIX4xUKFR
nnTCxA/9H2fQ6aK1r5o1UNRzSigoJBrztOGauenTcpTgs9S/i/JcCgcxbGCPyX6M
SrhySUK7DJ1YGR4EfDwFpb15R+LJkzBBvYEPf13fQrZcCBruU8+A6bHt3Fi9yUD9
EwAVlOwa79X3xbHLCnRoD9+vIVO/Rd9VId50kOPsxYGylc55oiwpyZsDWNjsSp21
6327ImqiJhnIwFX1WWK8uEFXXAQPhLKRFNncIPU4sCLSTtHM60nSTgbJo7NjNavD
ltfM8en+MIsu2TPVAU/1KKKTuIfXwJC4eZwrliBVWWoLhHc6aqS/ZeBHdJaHWDue
qQQIf4JepAf+a1gKxcEm50rjH1RtI0hcZk2JEyA+4hTfrSg2E4w3rlHApLGiHKdg
/NL8oxHWYZXI3y01gMOje4AadkELV6rMM7mEv75kT39bwCA3VzFWW+bIqC9uqgcj
pMsxuhRsIZ4UMizEnvs77v2zJryPiBn6eZcIFPShk9uIwf+w/5ZV6iJatkW4J1cj
+MC0t4q1KbbUh86zxYrQgWXnoK17dkc0QiuLZ1CBXewbDBMcnv+I2SnABFNaxBvM
y7RhBFgQ9WyEt/+zCkorkXb+1/yYve1hn4wIiWePliH4SIl/wAWu0Ky7PTw0hwMM
9+HrZpgbnGJa/lzj6UWUpWOJEO4Kr1dkgjGvh4BbInDsoFJ6oFE=
=bPTN
-----END PGP SIGNATURE-----

--Apple-Mail=_9EAC1DCF-70BC-4BA1-A748-4D710507DC92--
