Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2344C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 03:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9898420818
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 03:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfBVDhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 22:37:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43882 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbfBVDhj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 22:37:39 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E545B30001EF;
        Fri, 22 Feb 2019 03:37:38 +0000 (UTC)
Received: from llong.remote.csb (ovpn-125-186.rdu2.redhat.com [10.10.125.186])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DE6BA5C297;
        Fri, 22 Feb 2019 03:37:35 +0000 (UTC)
Subject: Re: [PATCH-tip v2 02/10] locking/rwsem: Move owner setting code from
 rwsem.c to rwsem.h
To:     Will Deacon <will.deacon@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
References: <1550263810-31947-1-git-send-email-longman@redhat.com>
 <1550263810-31947-3-git-send-email-longman@redhat.com>
 <20190221141525.GF12696@fuggles.cambridge.arm.com>
From:   Waiman Long <longman@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=longman@redhat.com; prefer-encrypt=mutual; keydata=
 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
 weim8xU=
Organization: Red Hat
Message-ID: <5f58af2f-b333-d3c3-a1e6-099dddd91f89@redhat.com>
Date:   Thu, 21 Feb 2019 22:37:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190221141525.GF12696@fuggles.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 22 Feb 2019 03:37:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDIvMjEvMjAxOSAwOToxNSBBTSwgV2lsbCBEZWFjb24gd3JvdGU6Cj4gSGkgV2FpbWFu
LAo+Cj4gT24gRnJpLCBGZWIgMTUsIDIwMTkgYXQgMDM6NTA6MDJQTSAtMDUwMCwgV2FpbWFu
IExvbmcgd3JvdGU6Cj4+IE1vdmVzIGFsbCB0aGUgb3duZXIgc2V0dGluZyBjb2RlIGNsb3Nl
ciB0byB0aGUgcndzZW0teGFkZCBmYXN0IHBhdGhzCj4+IGRpcmVjdGx5IHdpdGhpbiByd3Nl
bS5oIGZpbGUuCj4+Cj4+IEZvciBfX2Rvd25fcmVhZCgpIGFuZCBfX2Rvd25fcmVhZF9raWxs
YWJsZSgpLCBpdCBpcyBhc3N1bWVkIHRoYXQKPj4gcndzZW0gd2lsbCBiZSBtYXJrZWQgYXMg
cmVhZGVyLW93bmVkIHdoZW4gdGhlIGZ1bmN0aW9ucyByZXR1cm4uIFRoYXQKPj4gaXMgY3Vy
cmVudGx5IHRydWUgZXhjZXB0IGluIHRoZSB0cmFuc2llbnQgY2FzZSB0aGF0IHRoZSB3YWl0
ZXIgcXVldWUKPj4ganVzdCBiZWNvbWVzIGVtcHR5LiBTbyBhIHJ3c2VtX3NldF9yZWFkZXJf
b3duZWQoKSBjYWxsIGlzIGFkZGVkIGZvcgo+PiB0aGlzIGNhc2UuCj4gU29ycnksIGJ1dCBJ
J20gaGF2aW5nIGEgcmVhbGx5IGhhcmQgdGltZSB1bmRlcnN0YW5kaW5nIHRoZSBwYXJhZ3Jh
cGgKPiBhYm92ZS4gWW91IG1ha2UgaXQgc291bmQgbGlrZSB5b3UncmUgZml4aW5nIGEgYnVn
IGhlcmUsIGJ1dCB0aGF0IGRvZXNuJ3QKPiBhcHBlYXIgdG8gYmUgdGhlIGNhc2UuIFBsZWFz
ZSBjYW4geW91IGVsYWJvcmF0ZT8KClNvcnJ5IGZvciB0aGUgY29uZnVzaW9uLiBJIGFtIHJl
ZmVycmluZyB0byB0aGUgY29kZQoKaWYgKGxpc3RfZW1wdHkoJnNlbS0+d2FpdF9saXN0KSkg
ewrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyoKwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgKiBJbiBjYXNlIHRoZSB3YWl0IHF1ZXVlIGlzIGVtcHR5IGFuZCB0
aGUgbG9jayBpc24ndCBvd25lZArCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAq
IGJ5IGEgd3JpdGVyLCB0aGlzIHJlYWRlciBjYW4gZXhpdCB0aGUgc2xvd3BhdGggYW5kIHJl
dHVybgrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIGltbWVkaWF0ZWx5IGFz
IGl0cyBSV1NFTV9BQ1RJVkVfUkVBRF9CSUFTIGhhcyBhbHJlYWR5CsKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgICogYmVlbiBzZXQgaW4gdGhlIGNvdW50LgrCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqLwrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgaWYgKGF0b21pY19sb25nX3JlYWQoJnNlbS0+Y291bnQpID49IDApIHsKwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByYXdfc3Bpbl91bmxvY2tf
aXJxKCZzZW0tPndhaXRfbG9jayk7CsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgcmV0dXJuIHNlbTsKwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIH0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFkanVzdG1lbnQgKz0gUldT
RU1fV0FJVElOR19CSUFTOwrCoMKgwqDCoMKgwqDCoCB9CgpIZXJlLCBhIHJlYWRlciB3aWxs
IHJldHVybiB3aXRob3V0IGdvaW5nIHRocm91Z2ggdGhlIHdha2V1cCBwYXRoLiBJdCBpcwpo
ZXJlIHRoYXQgSSBuZWVkIHRvIGluc2VydCBhbiBleHBsaWNpdCBvd25lciBzZXR0aW5nIGNh
bGwuCgo+PiBUaGUgX19yd3NlbV9zZXRfcmVhZGVyX293bmVkKCkgY2FsbCBpbiBfX3J3c2Vt
X21hcmtfd2FrZSgpCj4+IGlzIG5vdyBuZWNlc3NhcnkuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6
IFdhaW1hbiBMb25nIDxsb25nbWFuQHJlZGhhdC5jb20+Cj4+IC0tLQo+PiAga2VybmVsL2xv
Y2tpbmcvcndzZW0teGFkZC5jIHwgIDYgKysrLS0tCj4+ICBrZXJuZWwvbG9ja2luZy9yd3Nl
bS5jICAgICAgfCAxOSArKy0tLS0tLS0tLS0tLS0tLS0tCj4+ICBrZXJuZWwvbG9ja2luZy9y
d3NlbS5oICAgICAgfCAxNyArKysrKysrKysrKysrKystLQo+PiAgMyBmaWxlcyBjaGFuZ2Vk
LCAyMCBpbnNlcnRpb25zKCspLCAyMiBkZWxldGlvbnMoLSkKPiBJIHBlcnNvbmFsbHkgZmlu
ZCB0aGUgZXhpc3RpbmcgY29kZSBlYXNpZXIgdG8gcmVhZCwgYnV0IEkgZG9uJ3Qga25vdyBp
Zgo+IHRoYXQncyBqdXN0IGJlY2F1c2UgSSdtIHVzZWQgdG8gaXQuLi4KClRoZSBjaGVjayBy
ZWFzb24gZm9yIHRoaXMgcGF0Y2ggaXMgYmVjYXVzZSBJIHdhbnQgdG8gYWRkIGEgUldTRU1f
REVCVUcKY2hlY2sgd2hlbiBhIHJlYWRlciByZXR1cm5zIGZyb20gdGhlIHNsb3dwYXRoIHRv
IG1ha2Ugc3VyZSB0aGF0IHRoZQp3YWtldXAgcGF0aCBpcyBiZWluZyBjYWxsIGFuZCBiZWNh
dXNlIG9mIHNvbWUga2luZCByYWNlIGNvbmRpdGlvbi4gVGhpcwpjaGVjayBtYXkgYmUgYWJs
ZSB0byBzcG90IHRoZSB3YWtlX3EgcmFjZSBjb25kaXRpb24gdGhhdCB3YXMgZml4ZWQKZWFy
bGllci4gSSB3aWxsIHVwZGF0ZSB0aGUgY29tbWl0IGxvZyB0byBtYWtlIG15IGludGVudGlv
biBjbGVhcmVyLgoKQ2hlZXJzLApMb25nbWFuCgoK
