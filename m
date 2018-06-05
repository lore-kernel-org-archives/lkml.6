Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751805AbeFEL1L (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 07:27:11 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57484 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751748AbeFEL1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 07:27:10 -0400
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86l <x86@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
CC: <yaomin2@huawei.com>
Subject: [Question] Can we use SIGRTMIN when vdso disabled on X86?
Message-ID: <5B1672FE.4050705@huawei.com>
Date: Tue, 5 Jun 2018 19:24:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="------------060806090701040900040200"
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------060806090701040900040200
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

After I executed "echo 0 > /proc/sys/abi/vsyscall32" to disable vdso, the rt_sigaction01 test case from ltp_2015 failed.
The test case source code please refer to the attachment, and the output as blow:

-----------------
./rt_sigaction01
rt_sigaction01    0  TINFO  :  signal: 34
rt_sigaction01    1  TPASS  :  rt_sigaction call succeeded: result = 0
rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 34

Segmentation fault
------------------


Is this the desired result? In function ia32_setup_rt_frame, I found below code:

	if (ksig->ka.sa.sa_flags & SA_RESTORER)
		restorer = ksig->ka.sa.sa_restorer;
	else
		restorer = current->mm->context.vdso +
			vdso_image_32.sym___kernel_rt_sigreturn;
	put_user_ex(ptr_to_compat(restorer), &frame->pretcode);

Because the vdso is disabled, so current->mm->context.vdso is NULL, which cause the result of frame->pretcode invalid.

I'm not sure whether this is a kernel bug or just an error of test case itself. Can anyone help me?

-- 
Thanks!
BestRegards

--------------060806090701040900040200
Content-Type: text/plain; charset="UTF-8"; name="rt_sigaction01.c"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="rt_sigaction01.c"

LyoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKi8KLyogQ29weXJpZ2h0IChjKSBDcmFja2VyamFj
ayBQcm9qZWN0LiwgMjAwNyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKi8K
LyogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgKi8KLyogVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29m
dHdhcmU7ICB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5ICAgICAgKi8K
LyogaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5z
ZSBhcyBwdWJsaXNoZWQgYnkgICAgICAgKi8KLyogdGhlIEZyZWUgU29mdHdhcmUgRm91bmRh
dGlvbjsgZWl0aGVyIHZlcnNpb24gMiBvZiB0aGUgTGljZW5zZSwgb3IgICAgICAgICAgKi8K
LyogKGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgKi8KLyogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKi8K
LyogVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBob3BlIHRoYXQgaXQgd2ls
bCBiZSB1c2VmdWwsICAgICAgICAgICAgKi8KLyogYnV0IFdJVEhPVVQgQU5ZIFdBUlJBTlRZ
OyAgd2l0aG91dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mICAgICAgICAgICAgKi8K
LyogTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NF
LiAgU2VlICAgICAgICAgICAgICAgICAgKi8KLyogdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBM
aWNlbnNlIGZvciBtb3JlIGRldGFpbHMuICAgICAgICAgICAgICAgICAgICAgICAgICAgKi8K
LyogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgKi8KLyogWW91IHNob3VsZCBoYXZlIHJlY2VpdmVk
IGEgY29weSBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgICAgICAgICAgKi8K
LyogYWxvbmcgd2l0aCB0aGlzIHByb2dyYW07ICBpZiBub3QsIHdyaXRlIHRvIHRoZSBGcmVl
IFNvZnR3YXJlIEZvdW5kYXRpb24sICAgKi8KLyogSW5jLiwgNTEgRnJhbmtsaW4gU3RyZWV0
LCBGaWZ0aCBGbG9vciwgQm9zdG9uLCBNQSAwMjExMC0xMzAxIFVTQSAgICAgICAgICAgKi8K
LyogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgKi8KLyogSGlzdG9yeTogICAgIFBvcnRpbmcgZnJv
bSBDcmFja2VyamFjayB0byBMVFAgaXMgZG9uZSBieSAgICAgICAgICAgICAgICAgICAgKi8K
LyogICAgICAgICAgICAgIE1hbmFzIEt1bWFyIE5heWFrIG1ha25heWFrQGluLmlibS5jb20+
ICAgICAgICAgICAgICAgICAgICAgICAgKi8KLyoqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKi8K
Ci8qKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKiovCi8qIERlc2NyaXB0aW9uOiBUaGlzIHRlc3Rz
IHRoZSBydF9zaWdhY3Rpb24oKSBzeXNjYWxsICAgICAgICAgICAgICAgICAgICAgICAgICov
Ci8qCQlydF9zaWdhY3Rpb24gYWx0ZXJzIGFuIGFjdGlvbiB0YWtlbiBieSBhIHByb2Nlc3Mg
b24gcmVjZWlwdCAgICovCi8qIAkJb2YgYSBwYXJ0aWN1bGFyIHNpZ25hbC4gVGhlIGFjdGlv
biBpcyBzcGVjaWZpZWQgYnkgdGhlICAgICAgICAqLwovKgkJc2lnYWN0aW9uIHN0cnVjdHVy
ZS4gVGhlIHByZXZpb3VzIGFjdGlvbiBvbiB0aGUgc2lnbmFsIGlzICAgICAqLwovKgkJc2F2
ZWQgaW4gb2FjdC5zaWdzZXRzaXplIHNob3VsZCBpbmRpY2F0ZSB0aGUgc2l6ZSBvZiBhICAg
ICAgICAqLwovKgkJc2lnc2V0X3QgdHlwZS4gICAgICAgICAgICAgICAgICAgICAgIAkJCSAg
ICAgICovCi8qKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKiovCgojaW5jbHVkZSA8c3RkaW8uaD4K
I2luY2x1ZGUgPHN0ZGxpYi5oPgojaW5jbHVkZSA8dW5pc3RkLmg+CiNpbmNsdWRlIDxzaWdu
YWwuaD4KI2luY2x1ZGUgPGVycm5vLmg+CiNpbmNsdWRlIDxzeXMvc3lzY2FsbC5oPgojaW5j
bHVkZSA8c3RyaW5nLmg+CgojaW5jbHVkZSAidGVzdC5oIgojaW5jbHVkZSAibGludXhfc3lz
Y2FsbF9udW1iZXJzLmgiCiNpbmNsdWRlICJsYXBpL3J0X3NpZ2FjdGlvbi5oIgoKY2hhciAq
VENJRCA9ICJydF9zaWdhY3Rpb24wMSI7CnN0YXRpYyBpbnQgdGVzdG5vOwppbnQgVFNUX1RP
VEFMID0gMTsKCnN0YXRpYyB2b2lkIGNsZWFudXAodm9pZCkKewoJdHN0X3JtZGlyKCk7Cn0K
CnN0YXRpYyB2b2lkIHNldHVwKHZvaWQpCnsKCVRFU1RfUEFVU0U7Cgl0c3RfdG1wZGlyKCk7
Cn0KCnN0YXRpYyBpbnQgdGVzdF9mbGFnc1tdID0KICAgIHsgU0FfUkVTRVRIQU5EIHwgU0Ff
U0lHSU5GTywgU0FfUkVTRVRIQU5ELCBTQV9SRVNFVEhBTkQgfCBTQV9TSUdJTkZPLApTQV9S
RVNFVEhBTkQgfCBTQV9TSUdJTkZPLCBTQV9OT01BU0sgfTsKY2hhciAqdGVzdF9mbGFnc19s
aXN0W10gPQogICAgeyAiU0FfUkVTRVRIQU5EfFNBX1NJR0lORk8iLCAiU0FfUkVTRVRIQU5E
IiwgIlNBX1JFU0VUSEFORHxTQV9TSUdJTkZPIiwKIlNBX1JFU0VUSEFORHxTQV9TSUdJTkZP
IiwgIlNBX05PTUFTSyIgfTsKCnN0YXRpYyB2b2lkIGhhbmRsZXIoaW50IHNpZykKewoJdHN0
X3Jlc20oVElORk8sICJTaWduYWwgSGFuZGxlciBDYWxsZWQgd2l0aCBzaWduYWwgbnVtYmVy
ICVkXG4iLCBzaWcpOwoJcmV0dXJuOwp9CgpzdGF0aWMgaW50IHNldF9oYW5kbGVyKGludCBz
aWcsIGludCBzaWdfdG9fbWFzaywgaW50IG1hc2tfZmxhZ3MpCnsKCXN0cnVjdCBzaWdhY3Rp
b24gc2EsIG9sZGFjdGlvbjsKCglzYS5zYV9oYW5kbGVyID0gKHZvaWQgKiloYW5kbGVyOwoJ
c2Euc2FfZmxhZ3MgPSBtYXNrX2ZsYWdzOwoJc2lnZW1wdHlzZXQoJnNhLnNhX21hc2spOwoJ
c2lnYWRkc2V0KCZzYS5zYV9tYXNrLCBzaWcpOwoKCXJldHVybiBsdHBfcnRfc2lnYWN0aW9u
KHNpZywgJnNhLCAmb2xkYWN0aW9uLCBTSUdTRVRTSVpFKTsKfQoKaW50IG1haW4oaW50IGFj
LCBjaGFyICoqYXYpCnsKCXVuc2lnbmVkIGludCBmbGFnOwoJaW50IHNpZ25hbDsKCWludCBs
YzsKCgl0c3RfcGFyc2Vfb3B0cyhhYywgYXYsIE5VTEwsIE5VTEwpOwoKCXNldHVwKCk7CgoJ
Zm9yIChsYyA9IDA7IFRFU1RfTE9PUElORyhsYyk7ICsrbGMpIHsKCgkJdHN0X2NvdW50ID0g
MDsKCgkJZm9yICh0ZXN0bm8gPSAwOyB0ZXN0bm8gPCBUU1RfVE9UQUw7ICsrdGVzdG5vKSB7
CgoJCQlmb3IgKHNpZ25hbCA9IFNJR1JUTUlOOyBzaWduYWwgPD0gU0lHUlRNQVg7IHNpZ25h
bCsrKSB7CgkJCQlmb3IgKGZsYWcgPSAwOwoJCQkJICAgICBmbGFnIDwKCQkJCSAgICAgKHNp
emVvZih0ZXN0X2ZsYWdzKSAvCgkJCQkgICAgICBzaXplb2YodGVzdF9mbGFnc1swXSkpOyBm
bGFnKyspIHsKCgkJCQkJVEVTVChzZXRfaGFuZGxlcgoJCQkJCSAgICAgKHNpZ25hbCwgMCwg
dGVzdF9mbGFnc1tmbGFnXSkpOwoKCQkJCQlpZiAoVEVTVF9SRVRVUk4gPT0gMCkgewoJCQkJ
CQl0c3RfcmVzbShUSU5GTywgInNpZ25hbDogJWQgIiwKCQkJCQkJCSBzaWduYWwpOwoJCQkJ
CQl0c3RfcmVzbShUUEFTUywKCQkJCQkJCSAicnRfc2lnYWN0aW9uIGNhbGwgc3VjY2VlZGVk
OiByZXN1bHQgPSAlbGQgIiwKCQkJCQkJCSBURVNUX1JFVFVSTik7CgkJCQkJCXRzdF9yZXNt
KFRJTkZPLAoJCQkJCQkJICJzYS5zYV9mbGFncyA9ICVzICIsCgkJCQkJCQkgdGVzdF9mbGFn
c19saXN0W2ZsYWddKTsKCQkJCQkJa2lsbChnZXRwaWQoKSwgc2lnbmFsKTsKCQkJCQl9IGVs
c2UgewoJCQkJCQl0c3RfcmVzbShURkFJTCB8IFRURVJSTk8sCgkJCQkJCQkgInJ0X3NpZ2Fj
dGlvbiBjYWxsICIKCQkJCQkJCSAiZmFpbGVkIik7CgkJCQkJfQoKCQkJCX0KCgkJCX0KCgkJ
fQoKCX0KCWNsZWFudXAoKTsKCXRzdF9leGl0KCk7Cn0K
--------------060806090701040900040200--
