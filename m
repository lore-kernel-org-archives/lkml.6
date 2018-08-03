Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6444BC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 138DA2175E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="kPJ6+yP6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 138DA2175E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731311AbeHCOgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 10:36:43 -0400
Received: from mail-bn3nam01on0045.outbound.protection.outlook.com ([104.47.33.45]:1736
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728198AbeHCOgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 10:36:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gVS8f9FqXuGJvaTaxXsnwbINTwOGoHnioatuyHhZ4RE=;
 b=kPJ6+yP6j/fWD4YfjFEyfsymCSfHiWkn2Wujb8Ocr3S0x5xLMEftKMVob6RBCi36ll0RjLrK2pPExU+ufui3ay1Yv3rz2PZdTVHyVWIKI6/1q6otADroQcZVDn+ZNh3AencwFUC0HXDxzE0IGsPRxGy1N4eyFTqnqEsFxnZRcAA=
Received: from CO2PR06MB538.namprd06.prod.outlook.com (10.141.199.23) by
 CO2PR06MB905.namprd06.prod.outlook.com (10.141.228.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.21; Fri, 3 Aug 2018 12:40:13 +0000
Received: from CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::311c:7e3f:3043:5287]) by CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::311c:7e3f:3043:5287%8]) with mapi id 15.20.1017.010; Fri, 3 Aug 2018
 12:40:12 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC:     "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        Heiner Litz <hlitz@ucsc.edu>,
        Young Tack Tack Jin <youngtack.jin@circuitblvd.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: move device L2P detection to core
Thread-Topic: [PATCH] lightnvm: move device L2P detection to core
Thread-Index: AQHUKweuBQbrOBanp0uVNhhgjqWapKSt8ZYAgAAF5ICAAACwgA==
Date:   Fri, 3 Aug 2018 12:40:12 +0000
Message-ID: <C29BF7B1-4C9A-47C7-9E5F-AD63356B01BC@cnexlabs.com>
References: <20180803085449.3436-1-mb@lightnvm.io>
 <31319710-8A72-49DC-9CFA-521CA06843F3@cnexlabs.com>
 <9349be00-4d14-9b25-ed11-fb9244428d7f@lightnvm.io>
In-Reply-To: <9349be00-4d14-9b25-ed11-fb9244428d7f@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB905;6:kT5iCfq07JU24eF+Eibpnl5+sFlbZdGVTlUYiOr6Lf7r9YoFHuTfdTCwZzRjD9bcIxoNUxQOwQ54Va55PhoPkFx2DVJZkGV1EsGlhRMWbzGcVv0HNRI0zT48j3DpjK20p9zPmKIda/1U5rLcVPG/7+jil1Ty9EQLAdMURXTtnHEjNIZX5riBTlEq8P1yEpFhJIuFi+mkVKbOXwHY0cczKazsLkIrwDZRPd+EcB0NZxen1bmDa+Y5Lk6FBifOT85/Gs7mcx4Jl2GhcX4agU3d1EbdnMZLjM88cSxSW0sIn6sTfIWlcZyQruLC9iMkUXiBNt2UYLJlTzVM5BPMxG05aAmsaY4sMCwh33Vmxh8HFAeJXZQTKOtsw4qYCYX/QhqPym5LPaeyUwFV9t74m3xHpeXEP7vVBudh9WqP9GZ2QZ/6xYjWsRdQbHJk8Ja5lPR96C0xRWvqIZMXuW/v+fBXrA==;5:roFky/nK5OQ2rw0zXlUuLdtzeK91j8lIyzulTSXKhjmGslgmyjmeMS2+KvL4lWcUOVADLaGo3b/2N2W8VwTtGroPPaKt0AAgwgDMYq4d1YCiodC/sD2yeNxp79OMwnbbFa8YDBn05/tuf9fgMfYd3rogDLsah2/dypvfLqH5juc=;7:AhEhe9y+1/IGMHCheiOXbLDKKTut1odlfNkO0FtNEe85np3uzelqmc3se0gh7lnpfYeXmqxJ+Kdp5YnOSW0pnryB9U3mlnQcpKF1FkK6KFtAejnyn1FspAsMOTvL0MDTlT7MDo2uEahphbERa3O7oXw5WCdHZVTCrzY2WH8PnXi+1cDc4VF4/tjk/d73StG8qYqo4X2MNjZwzu1CHpXfLIxNV5rVzmcnFTU5k6ZeiXmmuVCRgf7tNmcecezyWUuK
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(376002)(39840400004)(366004)(189003)(199004)(81156014)(3846002)(97736004)(2900100001)(186003)(99936001)(33656002)(14454004)(53546011)(446003)(6512007)(25786009)(8676002)(6116002)(5250100002)(6486002)(478600001)(86362001)(102836004)(6916009)(11346002)(26005)(4326008)(81166006)(2906002)(53936002)(6506007)(8936002)(2616005)(316002)(7736002)(486006)(68736007)(6246003)(54906003)(76176011)(106356001)(5660300001)(36756003)(66066001)(105586002)(229853002)(256004)(83716003)(476003)(82746002)(305945005)(6436002)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB905;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 4125dff0-be7c-4a4d-ac1b-08d5f93e41b8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(49563074)(7193020);SRVR:CO2PR06MB905;
x-ms-traffictypediagnostic: CO2PR06MB905:
x-microsoft-antispam-prvs: <CO2PR06MB9057F2889F9DA587487A16CBA230@CO2PR06MB905.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:CO2PR06MB905;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB905;
x-forefront-prvs: 0753EA505A
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: NbYCfjt7GVuJ56sECQl/C8weavIFxgldg24jK4RSMB70UvW53sr8KNIxoEIESmsg71YrVCQuhVmohFAWZkAdYgPrPEI5AFVnhbZDCgpDn3qr/VzrAlkG1ucagcyfI4f4QDJWgYCZX9UrRRf58pmTFUj9fgB3Y8OAX7HiXOksNM0vw1qsg33iwP2QgeS4ichELwHJbUXxsq9oDBLqJtdlmLRILSjGTUXRb32RjnmxGWmec63NRox8QDWylURdyqNA/xgUKEP8xNv6Z3gEJqMUPnMYLygA7IyEuLKJxpQCgzCkdB41JlcZ64tPmL5M/85PO3v+SIRRF9CTt15vGLmxKUUyaFtK4w7uvSSfs8BDGvM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_10966F8B-E1ED-47DA-AC7B-FFAE67A46EAF";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4125dff0-be7c-4a4d-ac1b-08d5f93e41b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2018 12:40:12.6001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB905
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_10966F8B-E1ED-47DA-AC7B-FFAE67A46EAF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 3 Aug 2018, at 14.37, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 08/03/2018 02:16 PM, Javier Gonzalez wrote:
>>> On 3 Aug 2018, at 10.54, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>=20
>>> A 1.2 device is able to manage the logical to physical mapping
>>> table internally or leave it to the host.
>>>=20
>>> A target only supports one of those approaches, and therefore must
>>> check on initialization. Move this check to core to avoid each =
target
>>> implement the check.
>>>=20
>>> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
>>> ---
>> I see where you want to go with these changes, but the way targets =
are
>> layered on top of the LightNVM subsystem does not align with it.
>> LightNVM can support different OCSSD versions and capabilities, but =
that
>> does not mean that a target (e.g., pblk) does. The way I see it, core
>> should only check for (i) the drive to expose itself in a known =
revision
>> and (ii) the reported structures to be consistent. However, specific
>> functionality is not for core to check upo.
>=20
> Why try to initialize a target, if we already know that it is =
incompatible?

Yes, that is my point. But the one who knows if the targets supports
something or not is the target, not the subsystem. Here, you are making
an assumption knowing the pblk requires the L2P on the host, but that
could change in the future...

--Apple-Mail=_10966F8B-E1ED-47DA-AC7B-FFAE67A46EAF
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAltkTSkACgkQIX4xUKFR
nnTGlA//YWk05KrbuSeK59x845B+LPOYfFl7v4191hCJjM10oE7hhgI7fzMZ5OKw
anR0SKx7w7dyZiZBHNnjpTgSi7b4NYAFAyEK0FPvkPj2IzFObvKt+OvfFOOWs0Ts
/bkL8I0XO6nSdXmoorFLXco8U1+L1/oYnmQmDlxy3/5Eujl2RX37Nk1JpK/vXwsm
FsghooPwB6z0QE+jV+eUIk7iVFTyPQege6H9Qo1Fu3k41i+q+1dTdas8dbEHGVjV
bB/iLXccoeTP3WZZWdwRVlcOhRzHZbqE/aQZI3tahsO/jNfHX/elo8k7bN9C3PKR
fxaDOHFzZ81fvoVeMN88ha40SlyJqwYt+2Lk45MNNb3fkUTypVeel+xTL8jUXFSt
vM4Hc35qMMXuxW3ieyzXWM2+Ii/2J9cvgib0YcFt4bdpLPD7djNmjHLMOxwdi+gP
5ZhUF+E0f9WKUkJ5fIq8Z9Dgh19N+tHHJbBQkJVYHqtVk5wnHxgNVneArjypA4HZ
gsUId9pn4xIOCQYb/y5a6YHrng7svjnQ4M7IiyjWsf5tWXDYJZn7YvCKYIrmHaNQ
Cxxxeq6aATz91hp4+izkmbEZV797U0izo6qVcnGyDRpazQ5iH8UHaEmzcXv9BH/q
G5W4sawXE3aI+Rm1jQaXOwsw28vyR6BCwiEfHcw5oSbRKwy8PQA=
=tIbH
-----END PGP SIGNATURE-----

--Apple-Mail=_10966F8B-E1ED-47DA-AC7B-FFAE67A46EAF--
