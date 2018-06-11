Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 96A70C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 23:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A15A20869
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 23:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Bh5cL2I0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A15A20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933622AbeFKXrv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 19:47:51 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:61946 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932471AbeFKXru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 19:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1528760869; x=1560296869;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Z5dDSmZj6qFreAA+pPza8apgRJwJx/IjsGERtfvRK18=;
  b=Bh5cL2I0M29kHzxyC3NUJrWmdHaY5ryee3hBAcxXm1VWvjXYXkw8c5ed
   tqRUZJ3tco3PdW/KWc9oiMjEGKohzhIOXGJqBa10DK/v3tsPdxuK9IS7w
   kNnWdXoy5i46D4Pq/qhuwhkfvQVSEH057PNV0IlRg14ttXXHbcRqP22yy
   Y=;
X-IronPort-AV: E=Sophos;i="5.51,212,1526342400"; 
   d="scan'208";a="745628939"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2c-cd289015.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 11 Jun 2018 23:47:48 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2c-cd289015.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w5BNljQa130297
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Mon, 11 Jun 2018 23:47:47 GMT
Received: from EX13D14UWB001.ant.amazon.com (10.43.161.158) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 11 Jun 2018 23:47:46 +0000
Received: from EX13D14UWB004.ant.amazon.com (10.43.161.137) by
 EX13D14UWB001.ant.amazon.com (10.43.161.158) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 11 Jun 2018 23:47:46 +0000
Received: from EX13D14UWB004.ant.amazon.com ([10.43.161.137]) by
 EX13D14UWB004.ant.amazon.com ([10.43.161.137]) with mapi id 15.00.1367.000;
 Mon, 11 Jun 2018 23:47:46 +0000
From:   "Farnitano, Jarrett" <jmf@amazon.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
CC:     "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kexec: yield to scheduler when loading kimage segments
Thread-Topic: [PATCH] kexec: yield to scheduler when loading kimage segments
Thread-Index: AQHUAaqqqRIAcr0dukqBB5E6cebsQ6RbrIy///+X9wA=
Date:   Mon, 11 Jun 2018 23:47:46 +0000
Message-ID: <588FC7E2-C106-456A-81E7-A98F99F0E392@amazon.com>
References: <1528738546-3328-1-git-send-email-jmf@amazon.com>
 <87po0xszdx.fsf@xmission.com>
In-Reply-To: <87po0xszdx.fsf@xmission.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.161.203]
Content-Type: text/plain; charset="utf-8"
Content-ID: <DFF30CE69CB1FC47BBEACD8BDD8A772F@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiDvu79PbiA2LzExLzE4LCA0OjAwIFBNLCAiRXJpYyBXLiBCaWVkZXJtYW4iIDxlYmllZGVybUB4
bWlzc2lvbi5jb20+IHdyb3RlOg0KPiANCj4gICAgIElzIHRoZXJlIGEgcHJhY3RpY2FsIHByb2Js
ZW0gd2l0aCB1bnJlc3BvbnNpdmVuZXNzPyAgWW91IGFyZSB0YWxraW5nDQo+ICAgICBhbiBlbWJl
ZGRlZCBtYWNoaW5lIGFuZCByYXJlbHkgYXJlIHRoZXJlIHBlb3BsZSBpbiBmcm9udCBvZiBlbWJl
ZGRlZA0KPiAgICAgY29tcHV0ZXJzIHRoZXNlIGRheXMuDQoNCkkgZGlkIHJ1biBpbnRvIGEgcHJh
Y3RpY2FsIHByb2JsZW0uIEhhcmR3YXJlIHdhdGNoZG9ncyBvbiBlbWJlZGRlZCBzeXN0ZW1zIGNh
biBoYXZlIHNob3J0IHRpbWVycyBvbiB0aGUgb3JkZXIgb2Ygc2Vjb25kcy4gSWYgdGhlIHN5c3Rl
bSBpcyBsb2NrZWQgdXAgZm9yIGEgZmV3IHNlY29uZHMgd2l0aCBvbmx5IGEgc2luZ2xlIGNvcmUg
YXZhaWxhYmxlLCB0aGUgd2F0Y2hkb2cgbWF5IG5vdCBiZSBwZXQgaW4gYSB0aW1lbHkgZmFzaGlv
bi4gSWYgdGhpcyBoYXBwZW5zLCB0aGUgaGFyZHdhcmUgd2F0Y2hkb2cgd2lsbCBmaXJlIGFuZCBy
ZXNldCB0aGUgc3lzdGVtLg0KDQpUaGlzIHJlYWxseSBvbmx5IGJlY29tZXMgYSBwcm9ibGVtIHdo
ZW4geW91IGFyZSB3b3JraW5nIHdpdGggYSBzaW5nbGUgY29yZSwgYSBkZWNlbnRseSBzaXplZCBp
bml0cmQsIGFuZCBoYXZlIGEgY29uc3RyYWluZWQgaGFyZHdhcmUgd2F0Y2hkb2cuICANCg0KSmFy
cmV0dA0KDQo=
