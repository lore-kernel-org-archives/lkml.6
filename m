Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754205AbeDMJsS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 05:48:18 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36586 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753238AbeDMJsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 05:48:17 -0400
X-Google-Smtp-Source: AIpwx4/BwHIBdUgH7NXZhXxbs7hk6jl9Bni1dOoO5LS0dRafhSkTXpIb+ECjOfPDR3J+mxloR91CXQ==
To: x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, tglx@linutronix.de, hpa@zytor.com
From: Xiaoming Gao <gxm.linux.kernel@gmail.com>
Subject: [PATCH] x86/tsc: fix 64bit divisor be truncated in calc_hpet_ref
Message-ID: <38894564-4fc9-b8ec-353f-de702839e44e@gmail.com>
Date: Fri, 13 Apr 2018 17:48:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------B00133F40DFE9772D6ACE9BC"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------B00133F40DFE9772D6ACE9BC
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

 From ba3d2fb699c4d8ee61b05d7e70be48b9c4e22baf Mon Sep 17 00:00:00 2001
From: Xiaoming Gao <newtongao@tencent.com>
Date: Fri, 13 Apr 2018 17:05:18 +0800
Subject: [PATCH] x86/tsc: fix 64bit divisor be truncated in calc_hpet_ref

the HPET frequency got larger on intel skylake, thus could cause tmp to
exceed 32bits.
do_div will truncate 64bits tmp to 32bits, so the frequency calced via
HPET will be wrong, use div64_u64 can fix it.

Signed-off-by: Xiaoming Gao <newtongao@tencent.com>
---
  arch/x86/kernel/tsc.c |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 9714a7a..8700269 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -160,7 +160,7 @@ static unsigned long calc_hpet_ref(u64 deltatsc, u64 
hpet1, u64 hpet2)
      hpet2 -= hpet1;
      tmp = ((u64)hpet2 * hpet_readl(HPET_PERIOD));
      do_div(tmp, 1000000);
-    do_div(deltatsc, tmp);
+    deltatsc = div64_u64(deltatsc, tmp);

      return (unsigned long) deltatsc;
  }
-- 
1.7.1



--------------B00133F40DFE9772D6ACE9BC
Content-Type: text/plain; charset=UTF-8;
 name="0001-x86-tsc-fix-64bit-divisor-be-truncated-in-calc_hpet_.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-x86-tsc-fix-64bit-divisor-be-truncated-in-calc_hpet_.pa";
 filename*1="tch"

RnJvbSBiYTNkMmZiNjk5YzRkOGVlNjFiMDVkN2U3MGJlNDhiOWM0ZTIyYmFmIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBYaWFvbWluZyBHYW8gPG5ld3Rvbmdhb0B0ZW5jZW50
LmNvbT4KRGF0ZTogRnJpLCAxMyBBcHIgMjAxOCAxNzowNToxOCArMDgwMApTdWJqZWN0OiBb
UEFUQ0hdIHg4Ni90c2M6IGZpeCA2NGJpdCBkaXZpc29yIGJlIHRydW5jYXRlZCBpbiBjYWxj
X2hwZXRfcmVmCgp0aGUgSFBFVCBmcmVxdWVuY3kgZ290IGxhcmdlciBvbiBpbnRlbCBza3ls
YWtlLCB0aHVzIGNvdWxkIGNhdXNlIHRtcCB0bwpleGNlZWQgMzJiaXRzLgpkb19kaXYgd2ls
bCB0cnVuY2F0ZSA2NGJpdHMgdG1wIHRvIDMyYml0cywgc28gdGhlIGZyZXF1ZW5jeSBjYWxj
ZWQgdmlhCkhQRVQgd2lsbCBiZSB3cm9uZywgdXNlIGRpdjY0X3U2NCBjYW4gZml4IGl0LgoK
U2lnbmVkLW9mZi1ieTogWGlhb21pbmcgR2FvIDxuZXd0b25nYW9AdGVuY2VudC5jb20+Ci0t
LQogYXJjaC94ODYva2VybmVsL3RzYy5jIHwgICAgMiArLQogMSBmaWxlcyBjaGFuZ2VkLCAx
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC94ODYv
a2VybmVsL3RzYy5jIGIvYXJjaC94ODYva2VybmVsL3RzYy5jCmluZGV4IDk3MTRhN2EuLjg3
MDAyNjkgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2tlcm5lbC90c2MuYworKysgYi9hcmNoL3g4
Ni9rZXJuZWwvdHNjLmMKQEAgLTE2MCw3ICsxNjAsNyBAQCBzdGF0aWMgdW5zaWduZWQgbG9u
ZyBjYWxjX2hwZXRfcmVmKHU2NCBkZWx0YXRzYywgdTY0IGhwZXQxLCB1NjQgaHBldDIpCiAJ
aHBldDIgLT0gaHBldDE7CiAJdG1wID0gKCh1NjQpaHBldDIgKiBocGV0X3JlYWRsKEhQRVRf
UEVSSU9EKSk7CiAJZG9fZGl2KHRtcCwgMTAwMDAwMCk7Ci0JZG9fZGl2KGRlbHRhdHNjLCB0
bXApOworCWRlbHRhdHNjID0gZGl2NjRfdTY0KGRlbHRhdHNjLCB0bXApOwogCiAJcmV0dXJu
ICh1bnNpZ25lZCBsb25nKSBkZWx0YXRzYzsKIH0KLS0gCjEuNy4xCgo=
--------------B00133F40DFE9772D6ACE9BC--
