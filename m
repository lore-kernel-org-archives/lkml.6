Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965246AbeBPLkN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 06:40:13 -0500
Received: from mx01.bbu.dsd.mx.bitdefender.com ([91.199.104.161]:43110 "EHLO
        mx01.bbu.dsd.mx.bitdefender.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965217AbeBPLkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 06:40:11 -0500
Message-ID: <1518781201.20980.17.camel@bitdefender.com>
Subject: Re: [RFC 00/12] KVM/X86: Introduce a new guest mapping API
From: Mihai =?UTF-8?Q?Don=C8=9Bu?= <mdontu@bitdefender.com>
To: KarimAllah Ahmed <karahmed@amazon.com>,
        KarimAllah Ahmed <karahmed@amazon.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Mircea CIRJALIU-MELIU <mcirjaliu@bitdefender.com>
Date: Fri, 16 Feb 2018 13:40:01 +0200
In-Reply-To: <266d9b21-0431-39cf-bb6f-61327fa5e0a0@amazon.com>
References: <1517856451-2932-1-git-send-email-karahmed@amazon.de>
         <1517858790.22345.62.camel@bitdefender.com>
         <266d9b21-0431-39cf-bb6f-61327fa5e0a0@amazon.com>
Organization: Bitdefender
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-dreuGpwnTSfG1azKGrDZ"
X-Mailer: Evolution 3.24.6 
Mime-Version: 1.0
X-BitDefender-Scanner: Clean, Agent: BitDefender qmail 3.1.6 on
 smtp02.buh.bitdefender.net, sigver: 7.74993
X-BitDefender-Spam: No (0)
X-BitDefender-SpamStamp: Build: [Engines: 2.15.8.1136, Dats: 475742,
 Stamp: 3], Multi: [Enabled, t: (0.000011,0.008061)], BW: [Enabled, t:
 (0.000008,0.000001)], RBL DNSBL: [Disabled], APM: [Disabled], SGN:
 [Enabled, t: (0.011020,0.000149)], URL: [Enabled, t:
 (0.000017,0.000001)], RTDA: [Enabled, t: (0.097531), Hit: No, Details:
 v2.6.22; Id: 15.1i6063g.1c5tf647s.58e0b], total: 0(775)
X-BitDefender-CF-Stamp: none
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-dreuGpwnTSfG1azKGrDZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2018-02-10 at 12:33 +0100, KarimAllah Ahmed wrote:
> On 02/05/2018 08:26 PM, Mihai Don=C8=9Bu wrote:
> > On Mon, 2018-02-05 at 19:47 +0100, KarimAllah Ahmed wrote:
> > > Guest memory can either be directly managed by the kernel (i.e. have =
a "struct
> > > page") or they can simply live outside kernel control (i.e. do not ha=
ve a
> > > "struct page"). KVM mostly support these two modes, except in a few p=
laces
> > > where the code seems to assume that guest memory must have a "struct =
page".
> >=20
> > In cases where there is no 'struct page', would it be possible to get
> > two VM-s to share memory (in the way Xen's grant tables do)?
> >=20
> > We are working on a page sharing mechanism and would like to know if
> > this use case can be accommodated.
>=20
> If your code is posted somewhere, I can take a look and let you know it
> can be accommodated or not.

Here is the latest patch: https://patchwork.kernel.org/patch/10121697/

The work is fairly alpha quality, but my colleague Mircea Cirjaliu is
essentially trying to get two VMA-s (one belonging to a guest and one
to the other) to point to the same page (much like KSM does). I'm not
very familiar with the mm subsystem and whether something similar can
be achieved with VMA-s of type VM_PFNMAP.

> > > This patchset introduces a new mapping function to map guest memory i=
nto host
> > > kernel memory. Ideally I should also get rid of all guest mapping fun=
ctions
> > > that end up converting a guest address to a page, but I decided to ge=
t feedback
> > > on this first and see if this is an acceptable API.
> > >=20
> > > Most of the offending code paths that has been updated are in the nes=
ted code
> > > base. Mostly because I stumbled upon this code while looking at the n=
ested MSR
> > > bitmap handling for the IBRS patches. There are also offending code p=
aths in
> > > SVM code, but I will do that once the interface is accepted.
> > >=20
> > > KarimAllah Ahmed (12):
> > >    KVM: Introduce helper functions to map/unmap guest memory
> > >    KVM/VMX: Use the new host mapping API for apic_access_page
> > >    KVM/VMX: Use the new host mapping API for virtual_apic_page
> > >    KVM/VMX: Use the new host mapping API for pi_desc_page
> > >    KVM/VMX: Use the new host mapping API for mapping nested vmptr
> > >    KVM/VMX: Use the new host mapping API for handle_vmptrld
> > >    KVM/VMX: Use the new host mapping API for mapping L12 MSR bitmap
> > >    KVM/VMX: Use the new host mapping API for mapping nested PML
> > >    KVM/VMX: Use the new host mapping API for cmpxchg_emulated
> > >    KVM/VMX: Use the new host mapping API for synic_clear_sint_msg_pen=
ding
> > >    KVM/VMX: Use the new host mapping API for synic_deliver_msg
> > >    KVM/VMX: Remove kvm_vcpu_gpa_to_page as it is now unused
> > >=20
> > >   arch/x86/kvm/hyperv.c    |  24 +++----
> > >   arch/x86/kvm/vmx.c       | 159 ++++++++++++++++++++----------------=
-----------
> > >   arch/x86/kvm/x86.c       |  12 ++--
> > >   include/linux/kvm_host.h |  18 +++++-
> > >   virt/kvm/kvm_main.c      |  62 ++++++++++++++++++
> > >   5 files changed, 161 insertions(+), 114 deletions(-)
> > >=20
> > > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > > Cc: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
> > > Cc: kvm@vger.kernel.org
> > > Cc: linux-kernel@vger.kernel.org

--=20
Mihai Don=C8=9Bu

--=-dreuGpwnTSfG1azKGrDZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEUttt6eV9itAPfgP+MTp0wyirvw4FAlqGwxEACgkQMTp0wyir
vw4FxAf/VBgLXBaR0Qd4fipUmvn2jMfp1q3HzayGxdzCxnKQ5ZwkrLu5T9Bczoxk
EbImCVGeeEAD1/PRVdds/IqInmgoDmK/Mzw17UPmV0DthidspmpSvy5w74xV0dGQ
r2Ngbho2C6yJXrxhw1MwUAOzPUXoK5iQMmV1ACPbhArpL4MNxTKmo96/MJ27gGyu
OgxYXBOcWQfqsQYZzLHkfrrqEfIKbsjyA+/4oOEo29148xFA3nKJLMBR6smPnBS3
AjlxghyiutNYmhcw+nCiaoIusnDCU2+dDapeauy+LkzIX193tJ4KvTY7+vIjAKFx
3YClhGFmQo9CzJfZENS4MV/NOkXS8Q==
=ABzs
-----END PGP SIGNATURE-----

--=-dreuGpwnTSfG1azKGrDZ--
