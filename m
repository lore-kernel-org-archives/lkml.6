Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A2FC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2B5F22419
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="nnCHzrpG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2B5F22419
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbeKNFwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 00:52:22 -0500
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131]:43600 "EHLO
        mx0a-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725748AbeKNFwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 00:52:21 -0500
Received: from pps.filterd (m0122333.ppops.net [127.0.0.1])
        by mx0a-00190b01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wADJl8aJ026728;
        Tue, 13 Nov 2018 19:52:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=jan2016.eng;
 bh=J/xbIr70NunOZRiBgiJGcdqA/V77ozvyT5xNeTsP2RA=;
 b=nnCHzrpGwP2rgprWsFb7hpx7uACj2KvW6S9RqWTI8UGMcur+0mxb7nqmTERDmcrpxWQF
 p93i6kqP4VDuZ6t2KeXS+GDnzjXMs9QJLaId8aKzlb+Cp/w/2H49bSeM3JBR60bue9PF
 2xf3Sgvm2gfR1U1uhm9E7zZNedYloaegbxG8YX724nAqtT7HdQujE6byhFWp+07d5udA
 oPeUw/syW/vZlFGfQ9hD5Y93aGdoCilaz2GY0bMiLztNmR0V9q6rMrxmzEwsngdlcw0+
 qqZYkq8QHaMJBJCxMRiOfRnqPL9eknb96Vvb4GcYIY4eqVRS5QhykaC2BVDPBSpiPZsl Bg== 
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18])
        by mx0a-00190b01.pphosted.com with ESMTP id 2nqayech6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Nov 2018 19:52:26 +0000
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
        by prod-mail-ppoint1.akamai.com (8.16.0.21/8.16.0.21) with SMTP id wADJolp2011380;
        Tue, 13 Nov 2018 14:52:25 -0500
Received: from email.msg.corp.akamai.com ([172.27.25.30])
        by prod-mail-ppoint1.akamai.com with ESMTP id 2nnujeq51d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 13 Nov 2018 14:52:24 -0500
Received: from USTX2EX-DAG3MB1.msg.corp.akamai.com (172.27.27.22) by
 ustx2ex-dag1mb1.msg.corp.akamai.com (172.27.27.101) with Microsoft SMTP
 Server (TLS) id 15.0.1365.1; Tue, 13 Nov 2018 13:52:15 -0600
Received: from USTX2EX-DAG3MB1.msg.corp.akamai.com ([172.27.27.22]) by
 USTX2EX-DAG3MB1.msg.corp.akamai.com ([172.27.27.22]) with mapi id
 15.00.1365.000; Tue, 13 Nov 2018 14:52:15 -0500
From:   "Zhivich, Michael" <mzhivich@akamai.com>
To:     John Stultz <john.stultz@linaro.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jason Wessel <jason.wessel@windriver.com>,
        "Hunt, Joshua" <johunt@akamai.com>,
        "Banerjee, Debabrata" <dbanerje@akamai.com>
Subject: Re: [PATCH] Revert "clocksource: Make clocksource validation work for
 all clocksources"
Thread-Topic: [PATCH] Revert "clocksource: Make clocksource validation work
 for all clocksources"
Thread-Index: AQHUermOKqr/WMoIJUWiYH0Cmjr/86VNCxSAgAEUOYA=
Date:   Tue, 13 Nov 2018 19:52:15 +0000
Message-ID: <68E373EE-86DC-4219-80F9-DAAF5A34977A@akamai.com>
References: <20181112185651.17138-1-mzhivich@akamai.com>
 <CALAqxLVCwWATXruj+PAAtKMuE4TDCgHCeQAmpz39k33xFm_68Q@mail.gmail.com>
In-Reply-To: <CALAqxLVCwWATXruj+PAAtKMuE4TDCgHCeQAmpz39k33xFm_68Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.19.35.23]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C4A0F4A61B3BAB478BCE59DC76258EFA@akamai.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-13_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811130180
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-13_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1811130179
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMTIvMTgsIDU6MjMgUE0sICJKb2huIFN0dWx0eiIgPGpvaG4uc3R1bHR6QGxpbmFyby5v
cmc+IHdyb3RlOg0KDQogICAgT24gTW9uLCBOb3YgMTIsIDIwMTggYXQgMTA6NTYgQU0sIE1pY2hh
ZWwgWmhpdmljaCA8bXpoaXZpY2hAYWthbWFpLmNvbT4gd3JvdGU6DQogICAgPiBSZXZlcnQgY29t
bWl0IDFmNDVmMWYzM2M4YyAoImNsb2Nrc291cmNlOiBNYWtlIGNsb2Nrc291cmNlIHZhbGlkYXRp
b24gd29yaw0KICAgID4gZm9yIGFsbCBjbG9ja3NvdXJjZXMiKSB0byByZXN0b3JlIGNvcnJlY3Qg
Y2xvY2tzb3VyY2VfZGVsdGEoKSBjb21wdXRhdGlvbg0KICAgID4gZm9yIGNsb2Nrc291cmNlcyB0
aGF0IHdyYXAgZnJlcXVlbnRseSwgd2hpbGUgcmV0YWluaW5nIHRoZSBjaGVjayBmb3IgdHNjDQog
ICAgPiBkcmlmdGluZy4NCiAgICA+DQogICAgPiBUcnVuY2F0aW5nIHJlc3VsdCBvZiBjbG9ja3Nv
dXJjZV9kZWx0YSgpIHRvIDAgY2F1c2VzIGluY29ycmVjdCBiZWhhdmlvciBmb3INCiAgICA+IGNs
b2Nrc291cmNlcyB0aGF0IHdyYXAgZnJlcXVlbnRseSAoZS5nLiBhY3BpX3BtIHdoaWNoIGlzIG9u
bHkgMjQtYml0IHdpZGUpLg0KICAgID4gSW4gcGFydGljdWxhciwgbGFyZ2UgdGltZSBkZWx0YXMg
KGUuZy4gbGFzdCA9IDB4MDAwMDAwLCBub3cgPSAweDgwMDAwMCkNCiAgICA+IHdpbGwgYmUgaW5j
b3JyZWN0bHkgY29tcHV0ZWQgYXMgMC4NCiAgICA+DQogICAgPiBJZiBhY3BpX3BtIGlzIHVzZWQg
YXMgdGhlIGNsb2Nrc291cmNlIHdhdGNoZG9nLCBhbmQgbWFjaGluZSBpcyB1bmRlciBoZWF2eQ0K
ICAgID4gbG9hZCwgdGhlIHRpbWUgcGVyaW9kIGZvciB0aGUgd2F0Y2hkb2cgY2hlY2sgbWF5IGJl
IHNpZ25pZmljYW50bHkgbG9uZ2VyDQogICAgPiB0aGFuIHRoZSByZXF1ZXN0ZWQgMC41IHNlY29u
ZHMuICBJZiB0aGUgd2F0Y2hkb2cgY2hlY2sgaXMgZGVsYXllZCBieSAyDQogICAgPiBzZWNvbmRz
IChvYnNlcnZlZCBiZWhhdmlvciksIHRoZW4gYWNwaV9wbSB0aW1lIGRlbHRhIHdpbGwgYmUNCiAg
ICA+DQogICAgPiAgICAgICAgIDIuNSBzZWMgKiAzNTc5NTQ1IHRpY2tzL3NlYyA9IDg5NDg4NjMg
PSAweDg4OGMzZg0KICAgID4NCiAgICA+IHdoaWNoIHdpbGwgYmUgdHJlYXRlZCBhcyBuZWdhdGl2
ZSBhbmQgdHJ1bmNhdGVkIHRvIDAuICBUaGlzIGJlaGF2aW9yIHdpbGwNCiAgICA+IGNhdXNlIHRz
YyB0byBiZSBpbmNvcnJlY3RseSBkZWNsYXJlZCB1bnN0YWJsZSBpbiBjbG9ja3NvdXJjZV93YXRj
aGRvZygpLCBhcw0KICAgID4gaXQgbm8gbG9uZ2VyIGFncmVlcyB3aXRoIGFjcGlfcG0uDQogICAg
DQogICAgVGhhbmtzIGZvciByYWlzaW5nIHRoaXMgaXNzdWUgYW5kIHN1Ym1pdHRpbmcgdGhlIHBh
dGNoIQ0KICAgIA0KICAgIFllYSwgdGhpcyBpcyBhIGNvbmNlcm4gcGFydGljdWxhcmx5IHdpdGgg
cXVpY2sgd3JhcHBpbmcgY2xvY2tzb3VyY2VzLg0KICAgIFRob3VnaCBJIHdvcnJ5IHRoYXQgaWYg
eW91J3JlIGFscmVhZHkgYmxvY2tpbmcgdGhlIHdhdGNoZG9nIGZyb20NCiAgICBydW5uaW5nIGZv
ciAyLjUgc2Vjb25kcywgeW91J3JlIGxpa2VseSB0byBhbHNvIGJsb2NrIHRoZSB3YXRjaGRvZyBm
b3INCiAgICBtb3JlIHRoZW4gNSBzZWNvbmRzLCB3aGljaCBpZiBJJ20gcmVtZW1iZXJpbmcgd291
bGQgcmVzdWx0IGluIHRoZSBzYW1lDQogICAgcHJvYmxlbT8gIEluIG90aGVyIHdvcmRzLCBkb2Vz
IHRoaXMgcmVhbGx5IHNvbHZlIHRoZSBwcm9ibGVtLCBvciBkb2VzDQogICAgaXQganVzdCBwdXNo
IHRoZSBiYXIgYSBsaXR0bGUgZnVydGhlciBvdXQ/DQogICAgDQogICAgU28sIEknbSB3b25kZXJp
bmcgdG8gcmVhbGx5IGZpeCB0aGlzLCBkbyB3ZSBuZWVkIHRvIGZpbmQgc29tZSB3YXkgdG8NCiAg
ICByYWlzZSB0aGUgcHJpb3JpdHkgb2YgdGhlIGNsb2Nrc291cmNlIHdhdGNoZG9nLCBzbyBpdCBp
c24ndCBkZWZlcnJlZA0KICAgIGZvciBxdWl0ZSBzbyBsb25nPw0KICAgIA0KICAgIHRoYW5rcw0K
ICAgIC1qb2huDQogICAgDQoNClRoYW5rcyBmb3IgdGhlIHF1aWNrIHJlc3BvbnNlLiAgDQoNCklu
IHByaW5jaXBsZSwgSSBhZ3JlZSB0aGF0IGEgcHJvcGVyIHNvbHV0aW9uIHdvdWxkIGhhdmUgdG8g
ZW5zdXJlIHRoYXQgd2F0Y2hkb2cgdGltZXIgaXMgbm90IGJsb2NrZWQgZm9yIHRvbyBsb25nLiAg
TXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0IHdhdGNoZG9nIHdvcmsgaXMgdHJpZ2dlcmVkIHZpYSBU
SU1FUiBzb2Z0aXJxIGFuZCB3aWxsIGdldCBwdXNoZWQgdG8ga3NvZnRpcnFkIHdoZW4gdGhlIHN5
c3RlbSBpcyBidXN5LiAgSW4gcGFydGljdWxhciwgaXQgYXBwZWFycyB0aGF0IGRvX3NvZnRpcnEo
KSBhbmQgaW52b2tlX3NvZnRpcnEoKSBib3RoIGNoZWNrIGtzb2Z0aXJxZF9ydW5uaW5nKCkgYmVm
b3JlIGRlY2lkaW5nIHRvIGFjdHVhbGx5IGRvIHdvcmsuDQoNCk9uZSBpbnRlcmVzdGluZyBiaXQg
aXMgdGhhdCBrc29mdGlycV9ydW5uaW5nKCkgd2lsbCBkaXNyZWdhcmQgYW4gYWN0aXZlIGtzb2Z0
aXJxZCB0aHJlYWQgYW5kIHJldHVybiAiZmFsc2UiIHdoZW4gSElfU09GVElSUSBvciBUQVNLTEVU
X1NPRlRJUlEgaXMgc2V0IChyZXN1bHRpbmcgaW4gYXQgbGVhc3QgYSBzaW5nbGUgcGFzcyBvdmVy
IHBlbmRpbmcgc29mdGlycXMpLiAgSSB0aGluayBpdCB3b3VsZCBtYWtlIHNlbnNlIHRvIGFkZCBU
SU1FUl9TT0ZUSVJRIHRvIHRoaXMgZXhjZXB0aW9uIGxpc3QgYXMgd2VsbC4NCg0KSW4gZmFjdCwg
bG9va2luZyBiYWNrIGF0IHRoZSBjb21taXQgbG9nLCBJJ20gZmluZGluZyBzaW1pbGFyIHRob3Vn
aHRzIG9uIHRoZSBzdWJqZWN0Og0KDQogICAgY29tbWl0IDNjNTM3NzZlMjlmODE3MTllZmNmOGY3
YTZlMzBjZGY3NTNiZWU5NGQNCiAgICBBdXRob3I6IExpbnVzIFRvcnZhbGRzIDx0b3J2YWxkc0Bs
aW51eC1mb3VuZGF0aW9uLm9yZz4gDQogICAgRGF0ZTogICBNb24gSmFuIDggMTE6NTE6MDQgMjAx
OCAtMDgwMA0KDQogICAgTWFyayBISSBhbmQgVEFTS0xFVCBzb2Z0aXJxIHN5bmNocm9ub3VzDQog
ICAgLi4uDQogICAgV2Ugc2hvdWxkIHByb2JhYmx5IGFsc28gY29uc2lkZXIgdGhlIHRpbWVyIHNv
ZnRpcnFzIHRvIGJlIHN5bmNocm9ub3VzDQogICAgYW5kIG5vdCBiZSBkZWxheWVkIHRvIGtzb2Z0
aXJxZCAoc2luY2UgdGhleSB3ZXJlIHRoZSBpc3N1ZSB3aXRoIHRoZQ0KICAgIGVhcmxpZXIgd2F0
Y2hkb2cgcHJvYmxlbXMpLCBidXQgdGhhdCBzaG91bGQgYmUgZG9uZSBhcyBhIHNlcGFyYXRlIHBh
dGNoLg0KICAgIFRoaXMgZG9lcyBvbmx5IHRoZSB0YXNrbGV0IGNhc2VzLg0KDQpJZiB0aGF0IG1h
a2VzIHNlbnNlLCBJJ20gaGFwcHkgdG8gd3JpdGUgdXAgYSBwYXRjaC4NCg0KVGhhbmtzLA0KfiBN
aWNoYWVsDQoNCg0K
