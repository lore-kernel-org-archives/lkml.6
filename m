Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEBEC6787E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 21:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBCDA2086D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 21:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O4e7XWyR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBCDA2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbeJHEKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 00:10:42 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38456 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725755AbeJHEKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 00:10:42 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w97L0Dsi084838;
        Sun, 7 Oct 2018 21:02:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=DiWlLkcuyaA8x/ZpCBRfIi+uAckyxbxXNYWbwuw0ues=;
 b=O4e7XWyRHe9TrTumR64HvNA0hVSafcTJ/hp9R0SkwXvnorwgFU6gDLHhTZeCiQHtCQDj
 gQc0hxw1/WdVj3e2FT2PrRZI0Tgyn9bwcyBkMouUltXR8cDb3vbb16b8cwEytOY+Kgtt
 /PL6rCQSpM4u1oRbafT5pmI3TCo7YxLmeEoaumZCgDhCu4E3BZevLacHQPmZXopup/ly
 id2DiwrmtcQ8tcJABfpLjBlj4a056bmqkepko2j5lSEEdmSeW9w9nCtqbkeWXSoL6yXJ
 nJYZVHSu9Ch94IGUFwpuSYq234cA+ZSRs4HYf5oz/Wnglrgn1929vDkmFB7ZGZ6LrtPI uw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2mxnpqk8h4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 07 Oct 2018 21:02:05 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w97L24CP022638
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 7 Oct 2018 21:02:04 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w97L240t016892;
        Sun, 7 Oct 2018 21:02:04 GMT
Received: from [192.168.14.112] (/79.178.223.28)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 07 Oct 2018 21:02:03 +0000
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH] KVM: LAPIC: Tune lapic_timer_advance_ns automatically
From:   Liran Alon <liran.alon@oracle.com>
In-Reply-To: <1538115136-20092-1-git-send-email-wanpengli@tencent.com>
Date:   Mon, 8 Oct 2018 00:02:00 +0300
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8847332B-9759-4FF2-B6D8-02334AE11015@oracle.com>
References: <1538115136-20092-1-git-send-email-wanpengli@tencent.com>
To:     Wanpeng Li <kernellwp@gmail.com>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9039 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810070214
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 28 Sep 2018, at 9:12, Wanpeng Li <kernellwp@gmail.com> wrote:
>=20
> From: Wanpeng Li <wanpengli@tencent.com>
>=20
> In cloud environment, lapic_timer_advance_ns is needed to be tuned for =
every CPU=20
> generations, and every host kernel versions(the =
kvm-unit-tests/tscdeadline_latency.flat=20
> is 5700 cycles for upstream kernel and 9600 cycles for our 3.10 =
product kernel,=20
> both preemption_timer=3DN, Skylake server).
>=20
> This patch adds the capability to automatically tune =
lapic_timer_advance_ns
> step by step, the initial value is 1000ns as d0659d946be05 (KVM: x86: =
add=20
> option to advance tscdeadline hrtimer expiration) recommended, it will =
be=20
> reduced when it is too early, and increased when it is too late. The =
guest_tsc=20
> and tsc_deadline are hard to equal, so we assume we are done when the =
delta=20
> is within a small scope e.g. 100 cycles. This patch reduces latency=20
> (kvm-unit-tests/tscdeadline_latency, busy waits, preemption_timer =
enabled)
> from ~2600 cyles to ~1200 cyles on our Skylake server.
>=20
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
> arch/x86/kvm/lapic.c | 7 +++++++
> arch/x86/kvm/x86.c   | 2 +-
> 2 files changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index fbb0e6d..b756f12 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -70,6 +70,8 @@
> #define APIC_BROADCAST			0xFF
> #define X2APIC_BROADCAST		0xFFFFFFFFul
>=20
> +static bool __read_mostly lapic_timer_advance_adjust_done =3D false;
> +
> static inline int apic_test_vector(int vec, void *bitmap)
> {
> 	return test_bit(VEC_POS(vec), (bitmap) + REG_POS(vec));
> @@ -1492,6 +1494,11 @@ void wait_lapic_expire(struct kvm_vcpu *vcpu)
> 	if (guest_tsc < tsc_deadline)
> 		__delay(min(tsc_deadline - guest_tsc,
> 			nsec_to_cycles(vcpu, lapic_timer_advance_ns)));
> +	if (!lapic_timer_advance_adjust_done) {
> +		lapic_timer_advance_ns +=3D (s64)(guest_tsc - =
tsc_deadline) / 8;

I don=E2=80=99t understand how this =E2=80=9C/ 8=E2=80=9D converts =
between guest TSC units to host nanoseconds.

I think that instead you should do something like:
s64 ns =3D (s64)(guest_tsc - tsc_deadline) * 1000000ULL;
do_div(ns, vcpu->arch.virtual_tsc_khz);
lapic_timer_advance_ns +=3D ns;

> +		if (abs(guest_tsc - tsc_deadline) < 100)

I would put this =E2=80=9C100=E2=80=9D hard-coded value as some =
=E2=80=9C#define=E2=80=9D to make code more clear.

> +			lapic_timer_advance_adjust_done =3D true;
> +	}
> }
>=20
> static void start_sw_tscdeadline(struct kvm_lapic *apic)
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index edbf00e..e865d12 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -136,7 +136,7 @@ static u32 __read_mostly tsc_tolerance_ppm =3D =
250;
> module_param(tsc_tolerance_ppm, uint, S_IRUGO | S_IWUSR);
>=20
> /* lapic timer advance (tscdeadline mode only) in nanoseconds */
> -unsigned int __read_mostly lapic_timer_advance_ns =3D 0;
> +unsigned int lapic_timer_advance_ns =3D 1000;
> module_param(lapic_timer_advance_ns, uint, S_IRUGO | S_IWUSR);
> EXPORT_SYMBOL_GPL(lapic_timer_advance_ns);
>=20
> --=20
> 2.7.4
>=20

