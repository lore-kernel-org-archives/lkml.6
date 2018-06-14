Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6962CC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 19:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D8CA208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 19:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="IvzD137p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D8CA208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964957AbeFNTu1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 15:50:27 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:25652 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964920AbeFNTuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 15:50:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1529005821; x=1560541821;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DjisnX76ISZKz2ufba6nDezXi9l8Ee7vbTV1dTnawE8=;
  b=IvzD137pbiWSC7eREiEqPcEZOPudlzr7SWd1fsWstJg6upICwhpdTCfZ
   fx3eYsKprrHOQtyqMejCDg0vT3d//cfZ2qSqDsMhWZqrwoGXTX+nXfccZ
   TcfnzcutTcTJMo1NXH7VCP+pBYk46WbLL1Un9Y79k5g+MM8TxMn6LWZBu
   8=;
X-IronPort-AV: E=Sophos;i="5.51,224,1526342400"; 
   d="scan'208";a="682964406"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Jun 2018 19:50:20 +0000
Received: from EX13MTAUWC001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w5EJoFX3025518
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 14 Jun 2018 19:50:15 GMT
Received: from EX13D02UWC002.ant.amazon.com (10.43.162.6) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 14 Jun 2018 19:50:15 +0000
Received: from EX13D12UWC003.ant.amazon.com (10.43.162.12) by
 EX13D02UWC002.ant.amazon.com (10.43.162.6) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 14 Jun 2018 19:50:15 +0000
Received: from EX13D12UWC003.ant.amazon.com ([10.43.162.12]) by
 EX13D12UWC003.ant.amazon.com ([10.43.162.12]) with mapi id 15.00.1367.000;
 Thu, 14 Jun 2018 19:50:15 +0000
From:   "Besogonov, Aleksei" <cyberax@amazon.com>
To:     Pavel Machek <pavel@ucw.cz>,
        "Agarwal, Anchal" <anchalag@amazon.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "roger.pau@citrix.com" <roger.pau@citrix.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "jgross@suse.com" <jgross@suse.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Kamata, Munehisa" <kamatam@amazon.com>,
        "van der Linden, Frank" <fllinden@amazon.com>,
        "Vaidyeshwara, Vallish" <vallish@amazon.com>,
        "Anbalagane, Guru" <guruanb@amazon.com>,
        "Valentin, Eduardo" <eduval@amazon.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [RFC PATCH 12/12] PM / hibernate: update the resume offset on
 SNAPSHOT_SET_SWAP_AREA
Thread-Topic: [RFC PATCH 12/12] PM / hibernate: update the resume offset on
 SNAPSHOT_SET_SWAP_AREA
Thread-Index: AQHUAo/c7GtY+YV2eEu7vcTSCMOdZKRgK06A//+MDgA=
Date:   Thu, 14 Jun 2018 19:50:15 +0000
Message-ID: <23092841-89AD-4D68-9790-AF0BD8702F0A@amazon.com>
References: <20180612205619.28156-1-anchalag@amazon.com>
 <20180612205619.28156-13-anchalag@amazon.com> <20180614194515.GE17808@amd>
In-Reply-To: <20180614194515.GE17808@amd>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.161.178]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D00608EDB57CB446B588E18069F89FA0@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KHNvcnJ5IGZvciB0b3AtcG9zdGluZykNCg0KV2VsbCwgbm90IGNvbXBsZXRlbHkgYnJva2VuLiBJ
dCBqdXN0IHJlcXVpcmVkIGEgcmVzdGFydCBmb3IgdGhlIG9mZnNldCBzZXR0aW5nIHRvIHRha2Ug
YW4gZWZmZWN0Lg0KDQrvu79PbiA2LzE0LzE4LCAxMjo0NiwgIlBhdmVsIE1hY2hlayIgPHBhdmVs
QHVjdy5jej4gd3JvdGU6DQoNCiAgICBIaSENCiAgICANCiAgICA+IEZyb206IEFsZWtzZWkgQmVz
b2dvbm92IDxjeWJlcmF4QGFtYXpvbi5jb20+DQogICAgPiANCiAgICA+IFRoZSBTTkFQU0hPVF9T
RVRfU1dBUF9BUkVBIGlzIHN1cHBvc2VkIHRvIGJlIHVzZWQgdG8gc2V0IHRoZSBoaWJlcm5hdGlv
bg0KICAgID4gb2Zmc2V0IG9uIGEgcnVubmluZyBrZXJuZWwgdG8gZW5hYmxlIGhpYmVybmF0aW5n
IHRvIGEgc3dhcCBmaWxlLg0KICAgID4gSG93ZXZlciwgaXQgZG9lc24ndCBhY3R1YWxseSB1cGRh
dGUgdGhlIHN3c3VzcF9yZXN1bWVfYmxvY2sgdmFyaWFibGUuIEFzDQogICAgPiBhIHJlc3VsdCwg
dGhlIGhpYmVybmF0aW9uIGZhaWxzIGF0IHRoZSBsYXN0IHN0ZXAgKGFmdGVyIGFsbCB0aGUgZGF0
YSBpcw0KICAgID4gd3JpdHRlbiBvdXQpIGluIHRoZSB2YWxpZGF0aW9uIG9mIHRoZSBzd2FwIHNp
Z25hdHVyZSBpbg0KICAgID4gbWFya19zd2FwZmlsZXMoKS4NCiAgICA+IA0KICAgID4gQmVmb3Jl
IHRoaXMgcGF0Y2gsIHRoZSBjb21tYW5kIGxpbmUgcHJvY2Vzc2luZyB3YXMgdGhlIG9ubHkgcGxh
Y2Ugd2hlcmUNCiAgICA+IHN3c3VzcF9yZXN1bWVfYmxvY2sgd2FzIHNldC4NCiAgICANCiAgICBB
cmUgeW91IHNheWluZyB0aGF0IHN1c3BlbmQtdG8tZmlsZSB3YXMgYnJva2VuLCBldmVuIG9uDQog
ICAgbm9uLXZpcnR1YWxpemVkIHN5c3RlbXM/DQogICAgDQogICAgSWYgc28sIHdlIG1heSB0aGlz
IHRvIGdvIGluIGZpcnN0Li4uDQogICAgCQkJCQkJCQlQYXZlbA0KICAgIAkJCQkJCQkJDQogICAg
LS0gDQogICAgKGVuZ2xpc2gpIGh0dHA6Ly93d3cubGl2ZWpvdXJuYWwuY29tL35wYXZlbG1hY2hl
aw0KICAgIChjZXNreSwgcGljdHVyZXMpIGh0dHA6Ly9hdHJleS5rYXJsaW4ubWZmLmN1bmkuY3ov
fnBhdmVsL3BpY3R1cmUvaG9yc2VzL2Jsb2cuaHRtbA0KICAgIA0KDQo=
