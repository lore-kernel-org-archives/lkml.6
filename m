Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6CDC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C37A2054F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="UWsvUthk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C37A2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbeIDVmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 17:42:15 -0400
Received: from mail-sn1nam01on0043.outbound.protection.outlook.com ([104.47.32.43]:16168
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726410AbeIDVmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 17:42:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rQZbmTybWYnlaPiIm5P3hIdm191IuzcYn9DyIu1++E=;
 b=UWsvUthkfgTurgEuQMRVCyYl7MJ4H0FC877xftMQ/BV9Ms00vOKufTzaRFpQFdyrpzo7bkS5g/BzV2FMlkww+NV/GlLfgjmv4uZSaYMdBLTZoLZ52vFV4JPmvgYO2+qaq/Z1kIaXtEdbBnn2LsnainssDRfh/5RBG751nRYPNWU=
Received: from CO2PR06MB538.namprd06.prod.outlook.com (10.141.199.23) by
 CO2PR06MB668.namprd06.prod.outlook.com (10.141.227.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.15; Tue, 4 Sep 2018 17:16:07 +0000
Received: from CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150]) by CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150%3]) with mapi id 15.20.1101.016; Tue, 4 Sep 2018
 17:16:07 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: Re: [PATCH 0/4] lightnvm: pblk: add support for chunk metadata on
 erase
Thread-Topic: [PATCH 0/4] lightnvm: pblk: add support for chunk metadata on
 erase
Thread-Index: AQHUQS9kK77UY0ca10mNeY2WW/uzcqTZ4p6AgARotACAAZzSgIAAe2gA
Date:   Tue, 4 Sep 2018 17:16:07 +0000
Message-ID: <9D0772CA-73AE-41AC-A489-4187185C696D@cnexlabs.com>
References: <1535722477-31288-1-git-send-email-javier@cnexlabs.com>
 <71f5f8b3-66d5-a0e0-85ab-cb22e5ac621c@lightnvm.io>
 <7FBEB635-C943-484D-A970-D3BF870BAFFB@cnexlabs.com>
 <95ae2794-c671-5dc7-3a2d-2b062ea86fba@lightnvm.io>
In-Reply-To: <95ae2794-c671-5dc7-3a2d-2b062ea86fba@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [50.207.153.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB668;6:OQm0xJElV9Wt/Btv4lCetRevhzbwrDLlt6CSsNfyF0LW9Fa3osq134G6CsvoCbCxw4WLCwIWAJY4mfKM7/L4ytoVyqk+eOCgxM9sDO1wWvU2R/Zt/ghC+XII11/+L26/cCpTrcKOn/SJaaZYKXMoop+YPwG2cAIFMvXkT6kLycE9L1KwIjQfO2gagWmLjMix6XXJL4fgqmVghLv/m/vYSzyx2D3f0ZBDlbHin/C+Xy6pfkMXIeiS+oLOQRXHo8RQkBTAD6FsS2ivSDOtC/g+kCX/G0E6tilgFVfltZFqde+vBHdQdnhTqeUPqd7CIz7Z9U2VQVmekNaZfelhfY99m09glRyFmagsK4eVjLhpLpEp4olMKA+3JQ0yzXUzMsU+5UKBD4k2xQvijSsn9N82vYMvyTdOaH9Kh0tuPrCQT+rszmMa/0JN7UNnB6X3/GM5KhujrMvLy5CB18ucTShvtg==;5:V920MLKjSLtzYvN6Gb/nSoXndLU7InLRGgrvqHfW6xV2CR+f1V9Y4nKXQKOi66fswVmLXED6vyZT9lYZ769npXbVhb5Gys7WMPYAnYHd3ic33YrPRjTk04Au86slOKJ2/hymYkWW8rPcgkDyz0+tZOE781m8p3ZdK6oNsEFJLWg=;7:v2HSUEOIx9dhWTRSVR/Z1pE9BCThvwpxBAYtc2k+CUEplgOdeNX9DvSU+NFa1Kvkj1Ez1bcQj9h5l1Mi8yYDIwcFS/GxZec5vJX4lj13tpM0d+ru7ijFhkmKZYcocKsJO9+DoEYCPKO35dc5QD4wUWhFx9ab8ffO1tlxzROzz6iT/OjVZiqdAe53ZQVUj2dwPinMLMn2BmxoU2f/8lhJizvm1ElY2ltbrb264hB67MDi2W3BS2etu0WlUj4L8oE/
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(376002)(136003)(346002)(396003)(39830400003)(189003)(199004)(86362001)(26005)(102836004)(66066001)(6346003)(83716003)(4326008)(186003)(5250100002)(6506007)(53546011)(105586002)(54906003)(106356001)(478600001)(316002)(107886003)(6916009)(25786009)(2906002)(6246003)(5660300001)(99936001)(14444005)(256004)(476003)(76176011)(99286004)(6436002)(14454004)(6116002)(33656002)(2616005)(82746002)(6486002)(305945005)(486006)(6512007)(446003)(97736004)(36756003)(81166006)(229853002)(8936002)(53936002)(8676002)(68736007)(3846002)(11346002)(2900100001)(7736002)(93886005)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB668;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 1ac1067f-c92d-4a1b-b4ed-08d6128a1a12
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(49563074)(7193020);SRVR:CO2PR06MB668;
x-ms-traffictypediagnostic: CO2PR06MB668:
x-microsoft-antispam-prvs: <CO2PR06MB6686A25FB427121C238DE4EBA030@CO2PR06MB668.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(271806183753584);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CO2PR06MB668;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB668;
x-forefront-prvs: 0785459C39
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-microsoft-antispam-message-info: WYURiNx0r1dC4mJ5mIMXPOGQsln9MYZaUO/Yd/yABGrtN6BmEdyAX94f6jHtK5Vnts9cePv9z5fsUlFEOXPEBI4vw1NQ4FHzcFqPaCufY2P7ZGFwyt6S2pWKvwf//NZnDOEX7My4VHOPBknw6JBQ2x7pjKjv54GzxzvXhYUdk3rYizK1KiRJQOP2bx6JvAkMbABv1aOSGzKFhqmOsofvLdmlZmp6nllJZuMAl+Vt5SVoi2PAZ5YbrAIxSYxFWR0Bm3xSI/tLWGiogmhKzw3bG51fcgG40JM8zuw0F8AKfZNFew4Bl0WvYFcZbVkqGLCfwtl/xEoZ9rtn3e5ms3Apz/hxiFJh3ncAs57uwrVfZVs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_B05885B8-E56F-4085-89AE-4348953D675F";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ac1067f-c92d-4a1b-b4ed-08d6128a1a12
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2018 17:16:07.0312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB668
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_B05885B8-E56F-4085-89AE-4348953D675F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 4 Sep 2018, at 02.54, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 09/03/2018 11:16 AM, Javier Gonzalez wrote:
>>> On 31 Aug 2018, at 15.57, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>=20
>>> On 08/31/2018 03:34 PM, Javier Gonz=C3=A1lez wrote:
>>>> Matias,
>>>> This patchset implements support for retrieving chunk metadata when
>>>> submitting a reset/erase command. Patches 0 and 1 are small fixes =
that
>>>> can be directly merged into your patch:
>>>>      lightnvm: move bad block and chunk state logic to core
>>>> Also, note that these do not apply on top of your for-4.20/core due =
them
>>>> depending on patches that I sent before that you have not picked up =
yet.
>>>> You can see them though in for-4.20/pblk. I'll rebase as patches in =
the
>>>> list appear in your tree.
>>>=20
>>> Thanks. It is really confusing when you guys maintains an implicit =
order and posts the patches separately. I will appreciate that patches =
that are related are posted together, such that I don't have to manually =
track what comes before another. That makes it less of a pain for me to =
keep track of and we can keep the reviews together.
>>>=20
>>> This is the patches that I have in the pipeline (from before the =
e-mails from today):
>>>=20
>>>  - This serie - Pending review
>>>  - Serie: pblk: support variable OOB size - Waiting on review from =
Igor
>>>  - lightnvm: pblk: recover open lines on 2.0 devices. Which doesn't =
apply due to the fixes to the pad distance patch.
>> Yes, I know and I apologize - we should have a better flow. What do =
you
>> say that for windows like this, where we have a number of patches =
that
>> have dependencies that we post them in meaningful patchsets and point =
to
>> a branch where they are ordered, like in a PR? Then we can rebase and
>> propagate changes properly?
>=20
> I am with the patchset posted, that should have the order. I just
> wanted to mention it. One thing that would be good, if you do have
> patches you have upstream, feel free to push them in smaller
> increments, so we can pull them in as we go. Only a nitpick, it is
> obviously up to you guys how you want to do it :)
>=20

Sure. If we can improve the workflow to make things easier for you, then
we should.


--Apple-Mail=_B05885B8-E56F-4085-89AE-4348953D675F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAluOvdQACgkQIX4xUKFR
nnTi1g//dRvNzCyRxxqd8KxuQNss4wYOojWUYeAaz4hw9Loqp3Kgo0TLCUScWT26
IJgtxC9MAws2ArCbWTmhEKF4KVbHtnmUHkut9L85BV4L+eCIUqzYfufH9tYNTKEb
aigmd+6BTdS2G7g60AIBmSoqK0ZDCQgsQfCaavdii24FWOrx47CXT0kzUmcvPhGD
4mfNRusdSbfZcyoBVDT+tJTRzg3XG+rkY0b6Stxzn+IoVNumCE6HpPCtq9bYPDmx
VbJfJrL/8kiw0v8cUvjWtOsL3uE+QW/AylzFRHenWWI3fK0O/wdfCfGnhlDJiXdR
Z02f91WYupNrIL5be5ywBuQ+dYtE2YUotDnxJi7TJHzTcEo0Xq6IoKgJ2faeASgf
aiOMZwfTYCAXHEuRLF/wTQJfXqBVftF6PNhlpfz0mRPAiDx0rizgKufw9YEiut9o
ucwgReS/LiF2qjjZCkztjnCCQyxjjaPglODiLtO4UjHSeGvT+ieXx3dBEoc/9gHN
tgpgJ/a4J2woBSmdlO7OPBWiRRAkCVCORhXfMXF8mBxyndscnN8pKhii1AGGap1U
wYoAKTcW46v26x3VDVWG13muk0Gc+zEtcfv3rE44TMj7JgPsu7zmpF9ybqPkVCZs
w4yjJlbcJcRxM+UMgkpw8Nj5G2ATdNqa38TwmPvQwLygyAzoEJE=
=H9Ci
-----END PGP SIGNATURE-----

--Apple-Mail=_B05885B8-E56F-4085-89AE-4348953D675F--
