Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C62EC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1FE62075C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kNu6xOl0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1FE62075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbeJHTQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 15:16:22 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43330 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbeJHTQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 15:16:22 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w98C4CMr012748;
        Mon, 8 Oct 2018 12:04:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=aBna1xgjxE65z0twGtMv8p2gO2AARvY6+fn3bpevcOI=;
 b=kNu6xOl0gfRXq3J1EppkZ67++qPINyI3CO8ED2p8s30sO4cltKpx+G7rw6R0/YPwaUig
 u+uAyv9ZlJVpdZAArbwpeEj++2TRdLCpNiQlC82aH4N54yjDR4sXmr9YBXAP5wK0laUM
 jpix0YHyyXE0/OD0WgLBIcy/TinYJmIeHg4AjE+ghV/oPt0bOQ0OhYxOEPDBqH0EIXv6
 5wMV/yIWOjjqTMVnV5eXAXCoy+/QMIA1wGaSgVSfFyS6oMQ8Qzh/RGKA2xk3eYWaEeY5
 jTpLHj2Xz4kd7q7MSg9edLrq4dYkFQsGIidb2nj0UQoIjMUIc9yhvcvW9QmhG2U6ijQf qA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2mxn0pp34y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Oct 2018 12:04:54 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w98C4sMc010122
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Oct 2018 12:04:54 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w98C4r3A018556;
        Mon, 8 Oct 2018 12:04:54 GMT
Received: from [192.168.14.112] (/79.178.223.28)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 08 Oct 2018 12:04:53 +0000
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH] KVM: LAPIC: Tune lapic_timer_advance_ns automatically
From:   Liran Alon <liran.alon@oracle.com>
In-Reply-To: <CANRm+CzML6RwAOCtPFCBwccECwO+Y=DQhWD_s5mK+uCtHUCFQg@mail.gmail.com>
Date:   Mon, 8 Oct 2018 15:04:50 +0300
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5A4E140E-BC3D-46E4-AF7B-E8053FD4C683@oracle.com>
References: <1538115136-20092-1-git-send-email-wanpengli@tencent.com>
 <8847332B-9759-4FF2-B6D8-02334AE11015@oracle.com>
 <CANRm+CzML6RwAOCtPFCBwccECwO+Y=DQhWD_s5mK+uCtHUCFQg@mail.gmail.com>
To:     Wanpeng Li <kernellwp@gmail.com>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9039 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810080120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 8 Oct 2018, at 13:59, Wanpeng Li <kernellwp@gmail.com> wrote:
>=20
> On Mon, 8 Oct 2018 at 05:02, Liran Alon <liran.alon@oracle.com> wrote:
>>=20
>>=20
>>=20
>>> On 28 Sep 2018, at 9:12, Wanpeng Li <kernellwp@gmail.com> wrote:
>>>=20
>>> From: Wanpeng Li <wanpengli@tencent.com>
>>>=20
>>> In cloud environment, lapic_timer_advance_ns is needed to be tuned =
for every CPU
>>> generations, and every host kernel versions(the =
kvm-unit-tests/tscdeadline_latency.flat
>>> is 5700 cycles for upstream kernel and 9600 cycles for our 3.10 =
product kernel,
>>> both preemption_timer=3DN, Skylake server).
>>>=20
>>> This patch adds the capability to automatically tune =
lapic_timer_advance_ns
>>> step by step, the initial value is 1000ns as d0659d946be05 (KVM: =
x86: add
>>> option to advance tscdeadline hrtimer expiration) recommended, it =
will be
>>> reduced when it is too early, and increased when it is too late. The =
guest_tsc
>>> and tsc_deadline are hard to equal, so we assume we are done when =
the delta
>>> is within a small scope e.g. 100 cycles. This patch reduces latency
>>> (kvm-unit-tests/tscdeadline_latency, busy waits, preemption_timer =
enabled)
>>> from ~2600 cyles to ~1200 cyles on our Skylake server.
>>>=20
>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>> Cc: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
>>> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
>>> ---
>>> arch/x86/kvm/lapic.c | 7 +++++++
>>> arch/x86/kvm/x86.c   | 2 +-
>>> 2 files changed, 8 insertions(+), 1 deletion(-)
>>>=20
>>> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
>>> index fbb0e6d..b756f12 100644
>>> --- a/arch/x86/kvm/lapic.c
>>> +++ b/arch/x86/kvm/lapic.c
>>> @@ -70,6 +70,8 @@
>>> #define APIC_BROADCAST                        0xFF
>>> #define X2APIC_BROADCAST              0xFFFFFFFFul
>>>=20
>>> +static bool __read_mostly lapic_timer_advance_adjust_done =3D =
false;
>>> +
>>> static inline int apic_test_vector(int vec, void *bitmap)
>>> {
>>>      return test_bit(VEC_POS(vec), (bitmap) + REG_POS(vec));
>>> @@ -1492,6 +1494,11 @@ void wait_lapic_expire(struct kvm_vcpu *vcpu)
>>>      if (guest_tsc < tsc_deadline)
>>>              __delay(min(tsc_deadline - guest_tsc,
>>>                      nsec_to_cycles(vcpu, lapic_timer_advance_ns)));
>>> +     if (!lapic_timer_advance_adjust_done) {
>>> +             lapic_timer_advance_ns +=3D (s64)(guest_tsc - =
tsc_deadline) / 8;
>>=20
>> I don=E2=80=99t understand how this =E2=80=9C/ 8=E2=80=9D converts =
between guest TSC units to host nanoseconds.
>=20
> Oh, I miss it. In addition, /8 here I mean adjust
> lapic_timer_advance_ns step by step. I can observe big fluctuated

If that=E2=80=99s the case, I would also put the =E2=80=9C8=E2=80=9D as =
a #define to make it more clear of it=E2=80=99s purpose.

> value between early and late when running real guest os like linux
> instead of kvm-unit-tests. After more testing, I saw
> lapic_timer_advance_ns can be overflow since the delta between
> guest_tsc and tsc_deadline is too huge.
>=20
>>=20
>> I think that instead you should do something like:
>> s64 ns =3D (s64)(guest_tsc - tsc_deadline) * 1000000ULL;
>> do_div(ns, vcpu->arch.virtual_tsc_khz);
>> lapic_timer_advance_ns +=3D ns;
>>=20
>>> +             if (abs(guest_tsc - tsc_deadline) < 100)
>>=20
>> I would put this =E2=80=9C100=E2=80=9D hard-coded value as some =
=E2=80=9C#define=E2=80=9D to make code more clear.
>=20
> How about something like below:
>=20
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index fbb0e6d..354eb13c 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -70,6 +70,9 @@
> #define APIC_BROADCAST            0xFF
> #define X2APIC_BROADCAST        0xFFFFFFFFul
>=20
> +static bool __read_mostly lapic_timer_advance_adjust_done =3D false;
> +#define LAPIC_TIMER_ADVANCE_ADJUST_DONE 100
> +
> static inline int apic_test_vector(int vec, void *bitmap)
> {
>     return test_bit(VEC_POS(vec), (bitmap) + REG_POS(vec));
> @@ -1472,7 +1475,7 @@ static bool lapic_timer_int_injected(struct
> kvm_vcpu *vcpu)
> void wait_lapic_expire(struct kvm_vcpu *vcpu)
> {
>     struct kvm_lapic *apic =3D vcpu->arch.apic;
> -    u64 guest_tsc, tsc_deadline;
> +    u64 guest_tsc, tsc_deadline, ns;
>=20
>     if (!lapic_in_kernel(vcpu))
>         return;
> @@ -1492,6 +1495,19 @@ void wait_lapic_expire(struct kvm_vcpu *vcpu)
>     if (guest_tsc < tsc_deadline)
>         __delay(min(tsc_deadline - guest_tsc,
>             nsec_to_cycles(vcpu, lapic_timer_advance_ns)));
> +    if (!lapic_timer_advance_adjust_done) {
> +        if (guest_tsc < tsc_deadline) {
> +            ns =3D (tsc_deadline - guest_tsc) * 1000000ULL;
> +            do_div(ns, vcpu->arch.virtual_tsc_khz);
> +            lapic_timer_advance_ns -=3D min((unsigned int)ns,
> lapic_timer_advance_ns / 8);
> +        } else {
> +            ns =3D (guest_tsc - tsc_deadline) * 1000000ULL;
> +            do_div(ns, vcpu->arch.virtual_tsc_khz);
> +            lapic_timer_advance_ns +=3D min((unsigned int)ns,
> lapic_timer_advance_ns / 8);
> +        }
> +        if (ns < LAPIC_TIMER_ADVANCE_ADJUST_DONE)

Didn=E2=80=99t you meant to compare here that abs(guest_tsc - =
tsc_deadline) < LAPIC_TIMER_ADVANCE_ADJUST_DONE?
This is also a good example on why I would also rename =
LAPIC_TIMER_ADVANCE_ADJUST_DONE to something
which indicates it represents a number in guest TSC units.

> +            lapic_timer_advance_adjust_done =3D true;
> +    }
> }
>=20
> static void start_sw_tscdeadline(struct kvm_lapic *apic)
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index ca71773..1f3f955 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -136,7 +136,7 @@ static u32 __read_mostly tsc_tolerance_ppm =3D =
250;
> module_param(tsc_tolerance_ppm, uint, S_IRUGO | S_IWUSR);
>=20
> /* lapic timer advance (tscdeadline mode only) in nanoseconds */
> -unsigned int __read_mostly lapic_timer_advance_ns =3D 0;
> +unsigned int __read_mostly lapic_timer_advance_ns =3D 1000;
> module_param(lapic_timer_advance_ns, uint, S_IRUGO | S_IWUSR);
> EXPORT_SYMBOL_GPL(lapic_timer_advance_ns);

