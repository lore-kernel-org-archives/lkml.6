Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81835C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4242F208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=llnl.gov header.i=@llnl.gov header.b="omE2YYCV";
	dkim=pass (1024-bit key) header.d=doellnl.onmicrosoft.com header.i=@doellnl.onmicrosoft.com header.b="cIgcCkcZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730803AbfAJRmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:42:40 -0500
Received: from prdesa-1.llnl.gov ([128.15.143.181]:36568 "EHLO
        prdesa-1.llnl.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730764AbfAJRmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:42:32 -0500
X-Greylist: delayed 571 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Jan 2019 12:42:31 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=llnl.gov; i=@llnl.gov; q=dns/txt; s=08082017;
  t=1547142151; x=1578678151;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5j2qzBV4Sh9ZYh6WhKm/kdhhaNyqzS/EUVW5A2UTdwc=;
  b=omE2YYCVuskBafPYN7C6BqUOhaMk/GcQRinlLJ7DDp7E3WQXsXoLJ4kC
   0azPmkQKzJTIc03dbLlE776at+eud24cT8+tyidb3H5y2xjkKo1cM71Aa
   IqVIXCGi6vnlr2XjPuj94XBvMJhKtcmiODBfb2NEJpxOJf0Q910kozz9/
   E=;
X-Attachments: 
Received: from prdex-04-snat.llnl.gov (HELO prdex-04.the-lab.llnl.gov) ([128.15.143.14])
  by prdesa-1.llnl.gov with ESMTP; 10 Jan 2019 09:33:00 -0800
Received: from prdex-04.the-lab.llnl.gov (128.15.143.187) by
 prdex-04.the-lab.llnl.gov (128.15.143.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Thu, 10 Jan 2019 09:33:00 -0800
Received: from GCC01-DM2-obe.outbound.protection.outlook.com (23.103.198.56)
 by prdex-04.the-lab.llnl.gov (128.15.143.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Thu, 10 Jan 2019 09:33:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=doellnl.onmicrosoft.com; s=selector1-llnl-gov;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5j2qzBV4Sh9ZYh6WhKm/kdhhaNyqzS/EUVW5A2UTdwc=;
 b=cIgcCkcZuOHTpeuRyzdE0aTS/igDyDgeWJAUxfUM4RxVqeqxYM64uhOAb+VdRMINfOjCkRAsrsf0BI0VTnf0HMkBT2mBysOSK10TeNjNozOzHL9H7/IDI3z/4vI1cNhrADVedDRdiqO4KDjwRWcNp7y4cJBdMB0hOj5zmKL/TdA=
Received: from SN6PR09MB3101.namprd09.prod.outlook.com (20.177.249.209) by
 SN6PR09MB3104.namprd09.prod.outlook.com (20.177.249.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.7; Thu, 10 Jan 2019 17:32:58 +0000
Received: from SN6PR09MB3101.namprd09.prod.outlook.com
 ([fe80::b5f0:7b82:fe90:248c]) by SN6PR09MB3101.namprd09.prod.outlook.com
 ([fe80::b5f0:7b82:fe90:248c%2]) with mapi id 15.20.1495.011; Thu, 10 Jan 2019
 17:32:58 +0000
From:   "Hutter, Tony" <hutter2@llnl.gov>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     Marc Dionne <marc.c.dionne@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: x86/fpu: Don't export __kernel_fpu_{begin,end}()
Thread-Topic: x86/fpu: Don't export __kernel_fpu_{begin,end}()
Thread-Index: AQHUqOYTNkFmwcv9h0ytV8RbbDWPCaWowz6A
Date:   Thu, 10 Jan 2019 17:32:58 +0000
Message-ID: <ba74ed88-06d0-5063-799f-c9c6ddbc7da0@llnl.gov>
References: <git-mailbomb-linux-master-12209993e98c5fa1855c467f22a24e3d5b8be205@kernel.org>
 <CAB9dFdsZb-sZixeOzrt8F50h1pnUK2W2Cxx8+xjhgd0=6xs7iw@mail.gmail.com>
 <20190109111951.5zvnj7ls6jv56p2u@linutronix.de>
 <20190109165235.GA8151@kroah.com>
 <20190109170935.e6b6rwzpk6dlruu4@linutronix.de>
 <20190110131132.GC20217@kroah.com>
In-Reply-To: <20190110131132.GC20217@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0017.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::30) To SN6PR09MB3101.namprd09.prod.outlook.com
 (2603:10b6:805:e5::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=hutter2@llnl.gov; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [128.115.190.37]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR09MB3104;6:RHtKC1PxWBYEOIjX43DJk7Vu0ApSNok/enWBfibFK5sggJb4pAnVk4Nz7P9JUWvkrZv07Bb0EpPZmo1/Vj6Yc1GxYNumaNmMoGJh+TJ0zk7SsW99oj+zcIT26JU+h/H6YpO7UOB2PpKE8orQ3/3kwYJUOfHdgDTyv6g5QkR8yO0JMaOm491Y8xXPp+r57K8TCRdqfxTHtocbBHy/UmiXuoFPYd2kmWetHmiNIF/3bDt0wWb5qWuBtMWegDINemr8reQZUUBF4OuMrM+iAEHr4R98bAEdD77jNW2ga8kE6R+PSStDk8SIjF7jUtcmd4yqTWODBh2fA4uzwK/bnwhI1UAmv3fC1G92RXwDaYTE1Wwy/XY94JmCkDoGw0AhwaFcKnjIkMieGtWqLOMyT/HO9guuTfOgRwVNzTCzilJMJDHFnpyfq5F7mBTVn8SP1ErvmwT4/jrOk/vzyRQduHUKuw==;5:XJnHh8rps84XaXV/5O7uOF3WEjbG9ccWMPkl6qnnxVKQUtC+PRSkBlXDopFTBIqjxiwR9VOnsVUfA8aZ0HpGQh496YDTOS1J7pH9QjB/5BNJ2Yo1cSU4mDVvWYM9AIgYt4PamlVrpdqTfxOo69VkWGvZESbYgMrjlocJRtG8JWwloQQBRjQM6sjqUCfD5rd5REoJYAwOpFU7QqA1R4YzGg==;7:2TLn3fYWs0mc73d6SUafBkuqaArlDcyicpWOaD7E4Tmf4HOYTZPMEvhO8wrgr3LpYDLXxKl+CXOqHm752UhDTAIWPUzxHQWUP77IVUZtg/8PRG4wtw/6GNNRKt9x67NworuRZbr/Ya2JevO4aIP+Xg==
x-ms-office365-filtering-correlation-id: 96888e63-bec6-4422-554d-08d67721a99c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:SN6PR09MB3104;
x-ms-traffictypediagnostic: SN6PR09MB3104:
x-microsoft-antispam-prvs: <SN6PR09MB3104C8DDA41E187D0144AFB990840@SN6PR09MB3104.namprd09.prod.outlook.com>
x-forefront-prvs: 0913EA1D60
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(346002)(366004)(136003)(396003)(189003)(199004)(93886005)(6306002)(36756003)(14454004)(53936002)(6246003)(966005)(31696002)(86362001)(3846002)(6116002)(305945005)(7736002)(8936002)(81166006)(8676002)(81156014)(558084003)(6512007)(478600001)(6436002)(4326008)(25786009)(39060400002)(97736004)(6486002)(71200400001)(71190400001)(486006)(229853002)(256004)(68736007)(99286004)(66066001)(5660300001)(26005)(102836004)(2616005)(446003)(476003)(11346002)(110136005)(54906003)(106356001)(105586002)(52116002)(186003)(76176011)(31686004)(2906002)(6506007)(386003)(316002)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR09MB3104;H:SN6PR09MB3101.namprd09.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: llnl.gov does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: //osK4OU6mOoamx2g/8TM8+gythfhksWIKoOlmYziTmV50zIuKbYg/KaLlPH+MSLDSJuwblSPVaLRN1s7gqGy8YE5vbU1X07sH7nU1hJR0sQ066LC6jsJkaeIuil3zWM3vMbOk/hynVwu7mL+/f+r7OQqA4AkgrFxx1N5JYjlk1oWFsMDM1y81xRsZWzFTMoNIdvnFQ3nOW/3TzpvzvOmFxA9onz10QPvQTcWZTKHEOTuvYXgAc5RFTB1PxAz8wl/qhucP06DC1z+9IXTbonduJd2QfdQBU1NCqWkZdEeJM6J6cvPJhlzcB027diwl42izWh3X6LNWn7Hko3t/SF1Xklp3hBbFNQodXC1pOcqyZvk/etmBihxSo8ebx3g1wVa7Mhq8NU51EtVDoP7czchvcuWFsFvjkFDoEqZoVrteTndGBgLIkYHYxTxdYQTMB2baZxt0ruqzHWQBQ+gBI4PA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E9DE120F4844C4DB57F05679D7CEC40@namprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 96888e63-bec6-4422-554d-08d67721a99c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2019 17:32:58.6474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a722dec9-ae4e-4ae3-9d75-fd66e2680a63
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR09MB3104
X-OriginatorOrg: llnl.gov
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBCdXQgc2luY2Ugd2hlbiBkaWQgb3V0LW9mLXRyZWUgbW9kdWxlcyB1c2UgX19rZXJuZWxfZnB1
X2JlZ2luPyAgSXQncyBhbg0KPiB4ODYtb25seSB0aGluZywgYW5kIHNob3VsZG4ndCByZWFsbHkg
YmUgdXNlZCBieSBhbnlvbmUsIHJpZ2h0Pw0KDQpaRlMgb24gTGludXggdXNlcyBpdCBmb3IgY2hl
Y2tzdW1zLiAgSXRzIHJlbW92YWwgaXMgY3VycmVudGx5IGJyZWFraW5nIFpGUyBidWlsZHMgYWdh
aW5zdCA1LjA6DQoNCmh0dHBzOi8vZ2l0aHViLmNvbS96ZnNvbmxpbnV4L3pmcy9pc3N1ZXMvODI1
OSNpc3N1ZWNvbW1lbnQtNDUyOTAyNTEwDQoNCg==
