Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DF1C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13CC62082F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="N0Y8wJfW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13CC62082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbeLAG1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 01:27:41 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:23247 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbeLAG1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 01:27:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1543605441; x=1575141441;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=J8S5S6j4wqr7xvijkGA1Qw2vYVz3BECabR9YnpDFL1Y=;
  b=N0Y8wJfWxLGzaEpSST+hjjmC18Xkc8Je4DyjQr+yvXuXPGKEhj6k97oc
   v3VMabzoVkp2TRhl6st4fjGHI9PDp2A1NFDtO0l3kikZJpXRYAxd3N5d6
   VHvJ+OVrM7NRbl9Yy1pnd+qxCKlbj/amlJlJm2rG1YXpmWKXAHzXw0T0Y
   M=;
X-IronPort-AV: E=Sophos;i="5.56,253,1539648000"; 
   d="scan'208";a="370367514"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-2c665b5d.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 30 Nov 2018 19:17:20 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-2c665b5d.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id wAUJHC0e061203
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Fri, 30 Nov 2018 19:17:15 GMT
Received: from EX13D02EUB001.ant.amazon.com (10.43.166.150) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 30 Nov 2018 19:17:14 +0000
Received: from uc1a35a69ae4659.ant.amazon.com (10.43.161.74) by
 EX13D02EUB001.ant.amazon.com (10.43.166.150) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 30 Nov 2018 19:17:08 +0000
Subject: Re: [PATCH] io_apic: initialize irq with -EINVAL
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Ingo Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Mike Rapoport" <rppt@linux.vnet.ibm.com>,
        Baoquan He <bhe@redhat.com>,
        "Nicolai Stange" <nstange@suse.de>,
        Jan Beulich <JBeulich@suse.com>,
        Jan Kiszka <jan.kiszka@siemens.com>
References: <1543403393-6004-1-git-send-email-nmanthey@amazon.de>
 <alpine.DEB.2.21.1811301239460.17702@nanos.tec.linutronix.de>
From:   Norbert Manthey <nmanthey@amazon.de>
Openpgp: preference=signencrypt
Autocrypt: addr=nmanthey@amazon.de; prefer-encrypt=mutual; keydata=
 xsFNBFoJQc0BEADM8Z7hB7AnW6ErbSMsYkKh4HLAPfoM+wt7Fd7axHurcOgFJEBOY2gz0isR
 /EDiGxYyTgxt5PZHJIfra0OqXRbWuLltbjhJACbu35eaAo8UM4/awgtYx3O1UCbIlvHGsYDg
 kXjF8bBrVjPu0+g55XizX6ot/YPAgmWTdH8qXoLYVZVWJilKlTqpYEVvarSn/BVgCbIsQIps
 K93sOTN9eJKDSqHvbkgKl9XG3WsZ703431egIpIZpfN0zZtzumdZONb7LiodcFHJ717vvd89
 3Hv2bYv8QLSfYsZcSnyU0NVzbPhb1WtaduwXwNmnX1qHJuExzr8EnRT1pyhVSqouxt+xkKbV
 QD9r+cWLChumg3g9bDLzyrOTlEfAUNxIqbzSt03CRR43dWgfgGiLDcrqC2b1QR886WDpz4ok
 xX3fdLaqN492s/3c59qCGNG30ebAj8AbV+v551rsfEba+IWTvvoQnbstc6vKJCc2uG8rom5o
 eHG/bP1Ug2ht6m/0uWRyFq9C27fpU9+FDhb0ZsT4UwOCbthe35/wBZUg72zDpT/h5lm64G6C
 0TRqYRgYcltlP705BJafsymmAXOZ1nTCuXnYAB9G9LzZcKKq5q0rP0kp7KRDbniirCUfp7jK
 VpPCOUEc3tS1RdCCSeWNuVgzLnJdR8W2h9StuEbb7hW4aFhwRQARAQABzSROb3JiZXJ0IE1h
 bnRoZXkgPG5tYW50aGV5QGFtYXpvbi5kZT7CwX0EEwEIACcFAloJQc0CGyMFCQlmAYAFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AACgkQZ+8yS8zN62ajmQ/6AlChoY5UlnUaH/jgcabyAfUC
 XayHgCcpL1SoMKvc2rCA8PF0fza3Ep2Sw0idLqC/LyAYbI6gMYavSZsLcsvY6KYAZKeaEriG
 7R6cSdrbmRcKpPjwvv4iY6G0DBTeaqfNjGe1ECY8u522LprDQVquysJIf3YaEyxoK/cLSb0c
 kjzpqI1P9Vh+8BQb5H9gWpakbhFIwbRGHdAF1roT7tezmEshFS0IURJ2ZFEI+ZgWgtl1MBwN
 sBt65im7x5gDo25h8A5xC9gLXTc4j3tk+3huaZjUJ9mCbtI12djVtspjNvDyUPQ5Mxw2Jwar
 C3/ZC+Nkb+VlymmErpnEUZNltcq8gsdYND4TlNbZ2JhD0ibiYFQPkyuCVUiVtimXfh6po9Yt
 OkE0DIgEngxMYfTTx01Zf6iwrbi49eHd/eQQw3zG5nn+yZsEG8UcP1SCrUma8p93KiKOedoL
 n43kTg4RscdZMjj4v6JkISBcGTR4uotMYP4M0zwjklnFXPmrZ6/E5huzUpH9B7ZIe/SUu8Ur
 xww/4dN6rfqbNzMxmya8VGlEQZgUMWcck+cPrRLB09ZOk4zq9i/yaHDEZA1HNOfQ9UCevXV5
 7seXSX7PCY6WDAdsT3+FuaoQ7UoWN3rdpb+064QKZ0FsHeGzUd7MZtlgU4EKrh25mTSNZYRs
 nTz2zT/J33fOwU0EWglBzQEQAKioD1gSELj3Y47NE11oPkzWWdxKZdVr8B8VMu6nVAAGFRSf
 Dms4ZmwGY27skMmOH2srnZyTfm9FaTKr8RI+71Fh9nfB9PMmwzA7OIY9nD73/HqPywzTTleG
 MlALmnuY6xFRSDmqmvxDHgWyzB4TgPWt8+hW3+TJKCx2RgLAdSuULZla4lia+NlS8WNRUDGK
 sFJCCB3BW5I/cocfpBEUqLbbmnPuD9UKpEnFcYWD9YaDNcBTjSc7iDsvtpdrBXg5VETOz/TQ
 /CmVs9h/5zug8O4bXxHEEJpCAxs4cGKxowBqx/XJfkwdWeo/LdaeR+LRbXvq4A32HSkyj9sV
 vygwt2OFEk493JGik8qtAA/oPvuqVPJGacxmZ7zKR12c0mnKCHiexFJzFbC7MSiUhhe8nNiM
 p6Sl6EZmsTUXhV2bd2M12Bqcss3TTJ1AcW04T4HYHVCSxwl0dVfcf3TIaH0BSPiwFxz0FjMk
 10umoRvUhYYoYpPFCz8dujXBlfB8q2tnHltEfoi/EIptt1BMNzTYkHKArj8Fwjf6K+nQ3a8p
 1cWfkYpA5bRqbhbplzpa0u1Ex0hZk6pka0qcVgqmH31O2OcSsqeKfUfHkzj3Q6dmuwm1je/f
 HWH9N1gDPEp1RB5bIxPnOG1Z4SNl9oVQJhc4qoJiqbvkciivYcH7u2CBkboFABEBAAHCwWUE
 GAEIAA8FAloJQc0CGwwFCQlmAYAACgkQZ+8yS8zN62YU9Q//WTnN28aBX1EhDidVho80Ql2b
 tV1cDRh/vWTcM4qoM8vzW4+F/Ive6wDVAJ7zwAv8F8WPzy+acxtHLkyYk14M6VZ1eSy0kV0+
 RZQdQ+nPtlb1MoDKw2N5zhvs8A+WD8xjDIA9i21hQ/BNILUBINuYKyR19448/41szmYIEhuJ
 R2fHoLzNdXNKWQnN3/NPTuvpjcrkXKJm2k32qfiys9KBcZX8/GpuMCc9hMuymzOr+YlXo4z4
 1xarEJoPOQOXnrmxN4Y30/qmf70KHLZ0GQccIm/o/XSOvNGluaYv0ZVJXHoCnYvTbi0eYvz5
 OfOcndqLOfboq9kVHC6Yye1DLNGjIVoShJGSsphxOx2ryGjHwhzqDrLiRkV82gh6dUHKxBWd
 DXfirT8a4Gz/tY9PMxan67aSxQ5ONpXe7g7FrfrAMe91XRTf50G3rHb8+AqZfxZJFrBn+06i
 p1cthq7rJSlYCqna2FedTUT+tK1hU9O0aK4ZYYcRzuTRxjd4gKAWDzJ1F/MQ12ftrfCAvs7U
 sVbXv2TndGIleMnheYv1pIrXEm0+sdz5v91l2/TmvkyyWT8s2ksuZis9luh+OubeLxHq090C
 hfavI9WxhitfYVsfo2kr3EotGG1MnW+cOkCIX68w+3ZS4nixZyJ/TBa7RcTDNr+gjbiGMtd9
 pEddsOqYwOs=
Message-ID: <91ae6742-0ffe-3ff1-0a0c-c91878c1c849@amazon.de>
Date:   Fri, 30 Nov 2018 20:17:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1811301239460.17702@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
X-Originating-IP: [10.43.161.74]
X-ClientProxiedBy: EX13P01UWB001.ant.amazon.com (10.43.161.59) To
 EX13D02EUB001.ant.amazon.com (10.43.166.150)
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMzAvMTggMTM6MTQsIFRob21hcyBHbGVpeG5lciB3cm90ZToKPiBOb3JiZXJ0LAo+Cj4g
T24gV2VkLCAyOCBOb3YgMjAxOCwgTm9yYmVydCBNYW50aGV5IHdyb3RlOgo+Cj4gdGhhbmtzIGZv
ciB0aGUgcGF0Y2guCj4KPj4gU3ViamVjdDogW1BBVENIXSBpb19hcGljOiBpbml0aWFsaXplIGly
cSB3aXRoIC1FSU5WQUwKPiBpb19hcGljIGlzIG5vdCBhIHByb3BlciBzdWJzeXN0ZW0gcHJlZml4
LiBnaXQgbG9nIHNob3VsZCBnaXZlIHlvdSBhIGhpbnQ6Cj4KPiAgICB4ODYvaW9hcGljOiAuLi4u
Cj4KPiBBbHNvIHBsZWFzZSBzdGFydCB0aGUgZmlyc3Qgd29yZCBhZnRlciB0aGUgY29sb24gd2l0
aCBhbiB1cHBlcmNhc2UgbGV0dGVyLgo+Cj4gTm93ICdJbml0aWFsaXplIGlycSB3aXRoIC1FSU5W
QUwnIGlzIG5vdCByZWFsbHkgaW5mb3JtYXRpdmUuIEl0IHRlbGxzIHdoYXQKPiB0aGUgcGF0Y2gg
ZG9lcywgYnV0IGRvZXMgbm90IGdpdmUgYSBjb25zaXNlIGhpbnQsIHdoYXQgdGhpcyBpcyBhYm91
dCBhbmQKPiB3aHkgeW91IHdhbnQgdG8gZG8gaXQuIFNvbWV0aGluZyBsaWtlOgo+Cj4gICAgeDg2
L2lvYXBpYzogUHJldmVudCB1bmluaXRpYWxpemVkIHJldHVybiB2YWx1ZQo+Cj4gcHJvdmlkZXMg
cHJlY2lzZSBpbmZvcm1hdGlvbiBhYm91dCB0aGUgc2NvcGUgb2YgdGhlIHBhdGNoLgo+Cj4+IFRv
IGNhdGNoIHRoZSBjYXNlIHdoZXJlIHRoZSB1bmluaXRpYWxpemVkIHZhcmlhYmxlIGlycSBtaWdo
dCBiZQo+PiByZXR1cm5lZC4KPiBJIGhhZCB0byByZWFkIHRoaXMgaW5jb21wbGV0ZSBzZW50ZW5j
ZSAzIHRpbWVzIHVudGlsIEkgZGlzY292ZXJlZCB0aGF0IHRoaXMKPiBpcyB0aGUgc2Vjb25kIHBh
cnQgb2YgdGhlIHN1YmplY3QgbGluZS4gUGxlYXNlIGRvbid0IGRvIHRoYXQuCj4KPj4gQXMgdGhl
IHBhdGggdGhhdCBtaWdodCBsZWFkIHRvIHRoaXMgc2l0dWF0aW9uIGNhbiBvbmx5Cj4+IG9jY3Vy
IGJhc2VkIG9uIGludmFsaWQgYXJndW1lbnRzLCB3ZSBpbml0aWFsaXplIHRoaXMgdmFyaWFibGUg
d2l0aAo+PiB0aGUgdmFsdWUgLUVJTlZBTCwgc28gdGhhdCBjYWxsZXJzIGFyZSBub3RpZmllZCBh
Y2NvcmRpbmdseSwgYW5kIG5vCj4+IHVuaW5pdGlhbGl6ZWQgdmFsdWUgaXMgcmV0dXJuZWQuCj4+
Cj4+IFRoZSBwYXRoIHRoYXQgd291bGQgYWxsb3cgdG8gcmV0dXJuIGFuIHVuaW5pdGlhbGl6ZWQg
dmFsdWUgZm9yIHRoZQo+PiB2YXJpYWJsZSBpcnEgd291bGQgcmVxdWlyZSBsZWdhY3kgSVJRcyB3
aXRob3V0IHRoZSBBTExPQyBmbGFnLgo+IElkZWFsbHkgeW91IGRlc2NyaWJlIHRoZSBwcm9ibGVt
IGZpcnN0IGFuZCBub3QgZWxhYm9yYXRlIGxlbmd0aHkgb24gdGhlCj4gc29sdXRpb24sIGJlY2F1
c2UgdGhlIHNvbHV0aW9uIGlzIG9idmlvdXMgb25jZSB0aGUgcHJvYmxlbSBpcwo+IGNsZWFyLiBT
b21ldGhpbmcgbGlrZSB0aGlzOgo+Cj4gICBtcF9tYXBfcGluX3RvX2lycSgpIGhhcyBhbiBleGl0
IHBhdGggd2hpY2ggcmV0dXJucyBhbiB1bmluaXRpYWxpemVkCj4gICB2YXJpYWJsZS4gVGhpcyBp
cyByZWFjaGVkLCB3aGVuICBjYWxsZWQgd2l0aCBhcmd1bWVudHMgLi4uLi4uCj4KPiAgIEluaXRp
YWxpemUgJ2lycScgd2l0aCAtRUlOVkFMIHRvIHByZXZlbnQgdGhhdC4KPgo+PiBTaWduZWQtb2Zm
LWJ5OiBOb3JiZXJ0IE1hbnRoZXkgPG5tYW50aGV5QGFtYXpvbi5kZT4KPj4gU2lnbmVkLW9mZi1i
eTogRGF2aWQgV29vZGhvdXNlIDxkd213QGFtYXpvbi5jby51az4KPiBUaGlzIFNPQiBjaGFpbiBp
cyB3cm9uZy4gSG93IGlzIERhdmlkIGludm9sdmVkIGluIHRoaXM/IElmIGhlIGNvLWRldmVsb3Bl
ZAo+IHRoZSBwYXRjaCwgdGhlbiBhICdDby1EZXZlbG9wZWQtYnk6IERhdmlkLi4uJyB0YWcgaXMg
bWlzc2luZy4gSWYgbm90LCB0aGVuCj4gaGlzIFNPQiBpcyBqdXN0IHdyb25nIGhlcmUuCj4KPj4g
LS0tCj4+ICBhcmNoL3g4Ni9rZXJuZWwvYXBpYy9pb19hcGljLmMgfCAyICstCj4+ICAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPj4KPj4gZGlmZiAtLWdpdCBh
L2FyY2gveDg2L2tlcm5lbC9hcGljL2lvX2FwaWMuYyBiL2FyY2gveDg2L2tlcm5lbC9hcGljL2lv
X2FwaWMuYwo+PiBpbmRleCAyOTUzYmJmLi4yMTlkYmMxIDEwMDY0NAo+PiAtLS0gYS9hcmNoL3g4
Ni9rZXJuZWwvYXBpYy9pb19hcGljLmMKPj4gKysrIGIvYXJjaC94ODYva2VybmVsL2FwaWMvaW9f
YXBpYy5jCj4+IEBAIC0xMDMxLDcgKzEwMzEsNyBAQCBzdGF0aWMgaW50IGFsbG9jX2lzYV9pcnFf
ZnJvbV9kb21haW4oc3RydWN0IGlycV9kb21haW4gKmRvbWFpbiwKPj4gIHN0YXRpYyBpbnQgbXBf
bWFwX3Bpbl90b19pcnEodTMyIGdzaSwgaW50IGlkeCwgaW50IGlvYXBpYywgaW50IHBpbiwKPj4g
IAkJCSAgICAgdW5zaWduZWQgaW50IGZsYWdzLCBzdHJ1Y3QgaXJxX2FsbG9jX2luZm8gKmluZm8p
Cj4+ICB7Cj4+IC0JaW50IGlycTsKPj4gKwlpbnQgaXJxID0gLUVJTlZBTDsKPj4gIAlib29sIGxl
Z2FjeSA9IGZhbHNlOwo+PiAgCXN0cnVjdCBpcnFfYWxsb2NfaW5mbyB0bXA7Cj4+ICAJc3RydWN0
IG1wX2NoaXBfZGF0YSAqZGF0YTsKPiBOb3csIGxldHMgbG9vayBhdCB0aGUgYWN0dWFsIGVycm9y
IHBhdGg6Cj4KPiAgICAgICAgIGlmICghKGZsYWdzICYgSU9BUElDX01BUF9BTExPQykpIHsKPiAg
ICAgICAgICAgICAgICAgaWYgKCFsZWdhY3kpIHsKPiAgICAgICAgICAgICAgICAgICAgICAgICBp
cnEgPSBpcnFfZmluZF9tYXBwaW5nKGRvbWFpbiwgcGluKTsKPiAgICAgICAgICAgICAgICAgICAg
ICAgICBpZiAoaXJxID09IDApCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpcnEg
PSAtRU5PRU5UOwo+ICAgICAgICAgICAgICAgICB9Cj4gCQkgPC0tLS0tLS0tLS0tIChpLmUuIGlm
IGxlZ2FjeSA9PSB0cnVlKQo+IAl9Cj4KPiBUaGF0IGxvb2tzIGFib3V0IHJpZ2h0LCBidXQgdG8g
Z2V0IHRoZXJlIHNvbWV0aGluZyBtdXN0IHNldCBsZWdhY3kgdG8KPiAndHJ1ZScgYW5kIHRoZSBv
bmx5IGNvZGUgcGF0aCB3aGljaCBkb2VzIHNvIGlzOgo+Cj4gICAgICAgICBpZiAoaWR4ID49IDAg
JiYgdGVzdF9iaXQobXBfaXJxc1tpZHhdLnNyY2J1cywgbXBfYnVzX25vdF9wY2kpKSB7Cj4gICAg
ICAgICAgICAgICAgIGlycSA9IG1wX2lycXNbaWR4XS5zcmNidXNpcnE7Cj4gICAgICAgICAgICAg
ICAgIGxlZ2FjeSA9IG1wX2lzX2xlZ2FjeV9pcnEoaXJxKTsKPiAgICAgICAgIH0KPgo+IGFuZCB0
aGlzIGNvZGUgcGF0aCBhY3R1YWxseSBpbml0aWFsaXplcyAnaXJxJy4gU28gcmV0dXJuaW5nIHVu
aW5pdGlhbGl6ZWQKPiAnaXJxJyBjYW5ub3QgaGFwcGVuLgo+Cj4gSG93IGRpZCB5b3UgZmluZCB0
aGF0PyBDb2RlIGluc3BlY3Rpb24sIHN0YXRpYyBjaGVja2VyLCAuLi4gPwoKSSBkaWQgYSBtYW51
YWwgY29kZSBpbnNwZWN0aW9uLCBhY3R1YWxseSByZWFzb25pbmcgYWJvdXQgc29tZXRoaW5nIGVs
c2UKYW5kIGR1cmluZyB0aGF0IGp1c3Qgc3BvdHRlZCB0aGUgaXJxIHZhcmlhYmxlLiBBcHBhcmVu
dGx5LCBJIG1pc3NlZCB0aGUKY2FzZSB0aGF0IGhhbmRsZXMgd3JpdGluZyB0byB0aGUgdmFyaWFi
bGUgImxlZ2FjeSIgYW5kIGhlbmNlIGJsb2NrcyB0aGUKZmF1bHR5IGV4aXQgcGF0aC4KClRoYW5r
cyBmb3IgYWxsIHRoZSBjb25zdHJ1Y3RpdmUgY3JpdGljaXNtIQoKQmVzdCwKTm9yYmVydAoKPgo+
IFRoYW5rcywKPgo+IAl0Z2x4CgoKCgpBbWF6b24gRGV2ZWxvcG1lbnQgQ2VudGVyIEdlcm1hbnkg
R21iSApLcmF1c2Vuc3RyLiAzOAoxMDExNyBCZXJsaW4KR2VzY2hhZWZ0c2Z1ZWhyZXI6IENocmlz
dGlhbiBTY2hsYWVnZXIsIFJhbGYgSGVyYnJpY2gKVXN0LUlEOiBERSAyODkgMjM3IDg3OQpFaW5n
ZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyBIUkIgMTQ5MTczIEIKCg==

