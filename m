Return-Path: <jrosen@cisco.com>
X-Google-Smtp-Source: AB8JxZpmbObUnQfw95qXH5dMKKuX596mjNM8sGzLoVqIq8sTXchl72WKHUVWoayCQ0dAvb6yc8i4
ARC-Seal: i=1; a=rsa-sha256; t=1526998336; cv=none;
        d=google.com; s=arc-20160816;
        b=bMwPVtF+lUrxrmmYunoMKcza3I7nja5mt669EeXc6FlyXpf3OdQN4wVkhM9hHzWlBL
         n4jZIqChyvE9ujW3nhSi1uCH0lYMZugdVjShzIeOjob/lRUYOhtW3/FO4zbhY72sPozh
         4gNOoOZ2Z9t2DvY/LFAHDTvx7oS/jnWbXIQ09lyOLv00107cbQUQKlkQrpYyCYX5DTL7
         1tugnsihbIwS4DxBPikgTpP6QUQNAx+WGAIIa8kILfEWxuq4HdOuvGl5LNtguuME5zlp
         CPmrwSLzXcNJSxLZlVOvWhCfZaQaG9kYEmlHjGhgJHNN2iU7qhxxBn8F7zaOnwzcOdQ/
         b2ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=kKpn7jHbuEqcOvB7cNl5xM8OBcfQJVViyXt5Ae8FTo0=;
        b=VIbb5h08mUJdgUYJ4jV3PSj9ET+ezvIMakfuNUPcyv+yR4SrwoKw/8znDkQjj3lOUk
         UM53E949pQ3Y6AwvJkRXUZdZG7Wt/J64tCJl61+GITchDux6UA4Mz0rGvsA4NqjyS9Rn
         G7dhOEA3tEj3xOTmg2MKRBlzXQqe4MaxoMl3J2GHFNoJFJiArUnMlFBfiftAPnYWPGut
         rWBUQqVHgbuvkJfT9kiFjZS44+KehT6iBXvDa+eP2mHdLqC3Fq9VwW68B5EcqKSbKI6T
         NNJobVaNgYydDs/prd+MkE68AhpmDMTC3wyEqiJtCZLoKI0M1/01aygMGAt9wJwvUUU5
         wBaQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@cisco.com header.s=iport header.b=I0rRXkeZ;
       spf=pass (google.com: domain of jrosen@cisco.com designates 173.37.86.72 as permitted sender) smtp.mailfrom=jrosen@cisco.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=cisco.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@cisco.com header.s=iport header.b=I0rRXkeZ;
       spf=pass (google.com: domain of jrosen@cisco.com designates 173.37.86.72 as permitted sender) smtp.mailfrom=jrosen@cisco.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=cisco.com
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AfAQBVJARb/51dJa1dGQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQcBAQEBAYMUL4FfKAqDa4gEjHeBeYEPhwOMM4F4C4RsHIIHITQYAQI?=
 =?us-ascii?q?BAQEBAQECbCiFKAEBAQEDIxFFEAIBCBgCAiYCAgIfERUQAgQOBQgThHADFah?=
 =?us-ascii?q?mghyHDQ2BK4IPgQmHLIFUP4Qcgk+FJIJUAocckQcsCQKLVoJ3gT+DbodZiiq?=
 =?us-ascii?q?GKQIREwGBJAEcOIFScBWCfoJIjgZvjUaBGAEB?=
X-IronPort-AV: E=Sophos;i="5.49,430,1520899200";
   d="scan'208";a="398908403"
From: "Jon Rosen (jrosen)" <jrosen@cisco.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>,
        Willem de Bruijn
	<willemb@google.com>,
        Eric Dumazet <edumazet@google.com>, Kees Cook
	<keescook@chromium.org>,
        David Windsor <dwindsor@gmail.com>,
        "Rosen, Rami"
	<rami.rosen@intel.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Mike
 Maloney" <maloney@google.com>,
        Benjamin Poirier <bpoirier@suse.com>,
        "Thomas
 Gleixner" <tglx@linutronix.de>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        "open list:NETWORKING [GENERAL]"
	<netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] packet: track ring entry use using a shadow ring to
 prevent RX ring overrun
Thread-Topic: [PATCH v2] packet: track ring entry use using a shadow ring to
 prevent RX ring overrun
Thread-Index: AQHT72oCSQesQH+wcU+iC1K5zWLMg6Q5fnUAgAAIkQCAAJ/kcIAAiZoA///PyiCAAUxXoA==
Date: Tue, 22 May 2018 14:12:13 +0000
Message-ID: <00de829386b04823bb58a555fb620317@XCH-RTP-016.cisco.com>
References: <1526731655-10087-1-git-send-email-jrosen@cisco.com>
 <CAF=yD-+kjceErK=CApiu1oY9uTjVWG2qeX=NkGVYufVVC_L2PA@mail.gmail.com>
 <CAF=yD-KvTyTibhqpKP79Obfk8KRVDLMyb6THNwNgrJzs47bAtQ@mail.gmail.com>
 <b7f6cc54a9f04132a279b15de0187ddd@XCH-RTP-016.cisco.com>
 <CAF=yD-Kfto4jJYMFzn=PV8OYdhEmdNfW+aakDhRMzRBWhWY0UQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.150.24.124]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600894186810885957?=
X-GMAIL-MSGID: =?utf-8?q?1601173807534179958?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gTW9uZGF5LCBNYXkgMjEsIDIwMTggMjoxNyBQTSwgSm9uIFJvc2VuIChqcm9zZW4pIDxqcm9z
ZW5AY2lzY28uY29tPiB3cm90ZToNCj4gT24gTW9uZGF5LCBNYXkgMjEsIDIwMTggMTowNyBQTSwg
V2lsbGVtIGRlIEJydWlqbg0KPiA8d2lsbGVtZGVicnVpam4ua2VybmVsQGdtYWlsLmNvbT4gd3Jv
dGU6DQo+PiBPbiBNb24sIE1heSAyMSwgMjAxOCBhdCA4OjU3IEFNLCBKb24gUm9zZW4gKGpyb3Nl
bikgPGpyb3NlbkBjaXNjby5jb20+IHdyb3RlOg0KDQouLi5zbmlwLi4uDQoNCj4+DQo+PiBBIHNl
dHNvY2tvcHQgZm9yIHVzZXJzcGFjZSB0byBzaWduYWwgYSBzdHJpY3RlciBpbnRlcnByZXRhdGlv
biBvZg0KPj4gdHBfc3RhdHVzIHRvIGVsaWRlIHRoZSBzaGFkb3cgaGFjayBjb3VsZCB0aGVuIGJl
IGNvbnNpZGVyZWQuDQo+PiBJdCdzIG5vdCBwcmV0dHkuIEVpdGhlciB3YXksIG5vIGZ1bGwgbmV3
IHZlcnNpb24gaXMgcmVxdWlyZWQuDQo+Pg0KPj4+IEFzIG11Y2ggYXMgSSB3b3VsZCBsaWtlIHRv
IGZpbmQgYSBzb2x1dGlvbiB0aGF0IGRvZXNuJ3QgcmVxdWlyZQ0KPj4+IHRoZSBzcGluIGxvY2sg
SSBoYXZlIHlldCB0byBkbyBzby4gTWF5YmUgdGhlIGFuc3dlciBpcyB0aGF0DQo+Pj4gZXhpc3Rp
bmcgYXBwbGljYXRpb25zIHdpbGwgbmVlZCB0byBzdWZmZXIgdGhlIHBlcmZvcm1hbmNlIGltcGFj
dA0KPj4+IGJ1dCBhIG5ldyB2ZXJzaW9uIG9yIG9wdGlvbiBmb3IgVFBBQ0tFVF9WMS9WMiBjb3Vs
ZCBiZSBhZGRlZCB0bw0KPj4+IGluZGljYXRlIHN0cmljdCBhZGhlcmVuY2Ugb2YgdGhlIFRQX1NU
QVRVU19VU0VSIGJpdCBhbmQgdGhlbiB0aGUNCj4+PiBvcmlnaW5hbCBkaWZmcyBjb3VsZCBiZSB1
c2VkLg0KDQpJdCBsb29rcyBsaWtlIGFkZGluZyBuZXcgc29ja2V0IG9wdGlvbnMgaXMgcHJldHR5
IHJhcmUgc28gSQ0Kd29uZGVyIGlmIGEgYmV0dGVyIG9wdGlvbiBtaWdodCBiZSB0byBkZWZpbmUg
YSBuZXcgVFBfU1RBVFVTX1hYWA0KYml0IHdoaWNoIHdvdWxkIHNpZ25hbCBmcm9tIGEgdXNlcnNw
YWNlIGFwcGxpY2F0aW9uIHRvIHRoZSBrZXJuZWwNCnRoYXQgaXQgc3RyaWN0bHkgaW50ZXJwcmV0
cyB0aGUgVFBfU1RBVFVTX1VTRVIgYml0IHRvIGRldGVybWluZQ0Kb3duZXJzaGlwLg0KDQpUb2Rh
eXMgYXBwbGljYXRpb25zIHNldCB0cF9zdGF0dXMgPSBUUF9TVEFUVVNfS0VSTkVMKDApIGZvciB0
aGUNCmtlcm5lbCB0byBwaWNrIHVwIHRoZSBlbnRyeS4gIFdlIGNvdWxkIGRlZmluZSBhIG5ldyB2
YWx1ZSB0byBwYXNzDQpvd25lcnNoaXAgYXMgd2VsbCBhcyBvbmUgdG8gaW5kaWNhdGUgdG8gb3Ro
ZXIga2VybmVsIHRocmVhZHMgdGhhdA0KYW4gZW50cnkgaXMgaW51c2U6DQoNCiAgICAgICAgI2Rl
ZmluZSBUUF9TVEFUVVNfVVNFUl9UT19LRVJORUwgICAgICAgICgxIDw8IDgpDQogICAgICAgICNk
ZWZpbmUgVFBfU1RBVFVTX0lOVVNFICAgICAgICAgICAgICAgICAoMSA8PCA5KQ0KDQpJZiB0aGUg
a2VybmVsIHNlZXMgdHBfc3RhdHVzID09IFRQX1NUQVRVU19LRVJORUwgdGhlbiBpdCBzaG91bGQN
CnVzZSB0aGUgc2hhZG93IG1ldGhvZCBmb3IgdGFja2luZyBvd25lcnNoaXAuIElmIGl0IHNlZXMg
dHBfc3RhdHVzDQo9PSBUUF9TVEFUVVNfVVNFUl9UT19LRVJORUwgdGhlbiBpdCBjYW4gdXNlIHRo
ZSBUUF9TVEFUVVNfSU5VU0UNCm1ldGhvZC4NCg0KPj4+DQo+Pj4gVGhlcmUgaXMgYW5vdGhlciBv
cHRpb24gSSB3YXMgY29uc2lkZXJpbmcgYnV0IGhhdmUgeWV0IHRvIHRyeQ0KPj4+IHdoaWNoIHdv
dWxkIGF2b2lkIG5lZWRpbmcgYSBzaGFkb3cgcmluZyBieSB1c2luZyBjb3VudGVyKHMpIHRvDQo+
Pj4gdHJhY2sgbWF4aW11bSBzZXF1ZW5jZSBudW1iZXIgcXVldWVkIHRvIHVzZXJzcGFjZSB2cy4g
dGhlIG5leHQNCj4+PiBzZXF1ZW5jZSBudW1iZXIgdG8gYmUgYWxsb2NhdGVkIGluIHRoZSByaW5n
LiAgSWYgdGhlIGRpZmZlcmVuY2UNCj4+PiBpcyBncmVhdGVyIHRoYW4gdGhlIHNpemUgb2YgdGhl
IHJpbmcgdGhlbiB0aGUgcmluZyBjYW4gYmUNCj4+PiBjb25zaWRlcmVkIGZ1bGwgYW5kIHRoZSBh
bGxvY2F0aW9uIHdvdWxkIGZhaWwuIE9mIGNvdXJzZSB0aGlzIG1heQ0KPj4+IGNyZWF0ZSBhbiBh
ZGRpdGlvbmFsIGhvdHNwb3QgYmV0d2VlbiBjb3Jlcywgbm90IHN1cmUgaWYgdGhhdA0KPj4+IHdv
dWxkIGJlIHNpZ25pZmljYW50IG9yIG5vdC4NCj4+DQo+PiBQbGVhc2UgZG8gaGF2ZSBhIGxvb2ss
IGJ1dCBJIGRvbid0IHRoaW5rIHRoYXQgdGhpcyB3aWxsIHdvcmsgaW4gdGhpcw0KPj4gY2FzZSBp
biBwcmFjdGljZS4gSXQgcmVxdWlyZXMgdHJhY2tpbmcgdGhlIHByb2R1Y2VyIHRhaWwuIFVwZGF0
aW5nDQo+PiB0aGUgc2xvd2VzdCB3cml0ZXIgcmVxdWlyZXMgcHJvYmluZyBlYWNoIHN1YnNlcXVl
bnQgc2xvdCdzIHN0YXR1cw0KPj4gYnl0ZSB0byBmaW5kIHRoZSBuZXcgdGFpbCwgd2hpY2ggaXMg
YSBsb3Qgb2YgKGJ5IHRoZW4gY29sZCkgY2FjaGVsaW5lDQo+PiByZWFkcy4NCj4NCj4gSSd2ZSB0
aG91Z2h0IGFib3V0IGl0IGEgbGl0dGxlIG1vcmUgYW5kIGFtIG5vdCBjb252aW5jZWQgaXQncw0K
PiB3b3JrYWJsZSBidXQgSSdsbCBzcGVuZCBhIGxpdHRsZSBtb3JlIHRpbWUgb24gaXQgYmVmb3Jl
IGdpdmluZw0KPiB1cC4NCg0KSSd2ZSBnaXZlbiB1cCBvbiB0aGlzIG1ldGhvZC4gIEp1c3QgZG9u
J3Qgc2VlIGhvdyB0byBtYWtlIGl0IHdvcmsuDQoNCg==
