Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754422AbeBGT0e (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 14:26:34 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:57647 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753995AbeBGT0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 14:26:32 -0500
X-ME-Sender: <xms:51J7WjwbOU4yWXpI19h-S-X-OqUuX2FB-Gx-IwMMNWcMsLgtbQLV5Q>
Subject: Re: [v6,3/3] x86/smpboot: Fix __max_logical_packages estimate
To: Prarit Bhargava <prarit@redhat.com>,
        xen-devel <xen-devel@lists.xen.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>,
        Piotr Luc <piotr.luc@intel.com>, Kan Liang <kan.liang@intel.com>,
        Borislav Petkov <bp@suse.de>, Stephane Eranian <eranian@google.com>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        He Chen <he.chen@linux.intel.com>,
        Mathias Krause <minipli@googlemail.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20171114124257.22013-4-prarit@redhat.com>
 <370a7ab2-8f57-b99b-428b-d0b1dfe401e7@invisiblethingslab.com>
 <6fdee802-bf24-7fbb-c95a-a6e0d840fbde@redhat.com>
From: Simon Gaiser <simon@invisiblethingslab.com>
Message-ID: <a6bdbf62-3d93-1f5c-6c05-c4c391bc8a9e@invisiblethingslab.com>
Date: Wed, 07 Feb 2018 19:26:00 +0000
MIME-Version: 1.0
In-Reply-To: <6fdee802-bf24-7fbb-c95a-a6e0d840fbde@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="zEb3dtN5X1hXtVqIYFiB94gIdH9QFZ7rB"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zEb3dtN5X1hXtVqIYFiB94gIdH9QFZ7rB
Content-Type: multipart/mixed; boundary="7Eg4keRvJj0Q2v1JgP6detAjOTlIG3ndk";
 protected-headers="v1"
From: Simon Gaiser <simon@invisiblethingslab.com>
To: Prarit Bhargava <prarit@redhat.com>, xen-devel <xen-devel@lists.xen.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>,
 Piotr Luc <piotr.luc@intel.com>, Kan Liang <kan.liang@intel.com>,
 Borislav Petkov <bp@suse.de>, Stephane Eranian <eranian@google.com>,
 Arvind Yadav <arvind.yadav.cs@gmail.com>, Andy Lutomirski <luto@kernel.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, He Chen <he.chen@linux.intel.com>,
 Mathias Krause <minipli@googlemail.com>,
 Tim Chen <tim.c.chen@linux.intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
Message-ID: <a6bdbf62-3d93-1f5c-6c05-c4c391bc8a9e@invisiblethingslab.com>
Subject: Re: [v6,3/3] x86/smpboot: Fix __max_logical_packages estimate
References: <20171114124257.22013-4-prarit@redhat.com>
 <370a7ab2-8f57-b99b-428b-d0b1dfe401e7@invisiblethingslab.com>
 <6fdee802-bf24-7fbb-c95a-a6e0d840fbde@redhat.com>
In-Reply-To: <6fdee802-bf24-7fbb-c95a-a6e0d840fbde@redhat.com>

--7Eg4keRvJj0Q2v1JgP6detAjOTlIG3ndk
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

Prarit Bhargava:
> On 02/07/2018 01:44 PM, Simon Gaiser wrote:
>> Prarit Bhargava:
>>> A system booted with a small number of cores enabled per package
>>> panics because the estimate of __max_logical_packages is too low.
>>> This occurs when the total number of active cores across all packages=

>>> is less than the maximum core count for a single package.
>>>
>>> ie) On a 4 package system with 20 cores/package where only 4 cores
>>> are enabled on each package, the value of __max_logical_packages is
>>> calculated as DIV_ROUND_UP(16 / 20) =3D 1 and not 4.
>>>
>>> Calculate __max_logical_packages after the cpu enumeration has comple=
ted.
>>> Use the boot cpu's data to extrapolate the number of packages.
>>>
>>> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Ingo Molnar <mingo@redhat.com>
>>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>>> Cc: x86@kernel.org
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>> Cc: Andi Kleen <ak@linux.intel.com>
>>> Cc: Dave Hansen <dave.hansen@intel.com>
>>> Cc: Piotr Luc <piotr.luc@intel.com>
>>> Cc: Kan Liang <kan.liang@intel.com>
>>> Cc: Borislav Petkov <bp@suse.de>
>>> Cc: Stephane Eranian <eranian@google.com>
>>> Cc: Prarit Bhargava <prarit@redhat.com>
>>> Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>
>>> Cc: Andy Lutomirski <luto@kernel.org>
>>> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
>>> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>>> Cc: Tom Lendacky <thomas.lendacky@amd.com>
>>> Cc: He Chen <he.chen@linux.intel.com>
>>> Cc: Mathias Krause <minipli@googlemail.com>
>>> Cc: Tim Chen <tim.c.chen@linux.intel.com>
>>> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
>>> ---
>>>  arch/x86/kernel/smpboot.c | 55 +++++++++----------------------------=
----------
>>>  1 file changed, 10 insertions(+), 45 deletions(-)
>>>
>>> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
>>> index 838d36ff7ba6..2e3c5a394e79 100644
>>> --- a/arch/x86/kernel/smpboot.c
>>> +++ b/arch/x86/kernel/smpboot.c
>>> @@ -308,12 +308,6 @@ int topology_update_package_map(unsigned int pkg=
, unsigned int cpu)
>>>  	if (new >=3D 0)
>>>  		goto found;
>>> =20
>>> -	if (logical_packages >=3D __max_logical_packages) {
>>> -		pr_warn("Package %u of CPU %u exceeds BIOS package data %u.\n",
>>> -			logical_packages, cpu, __max_logical_packages);
>>> -		return -ENOSPC;
>>> -	}
>>> -
>>>  	new =3D logical_packages++;
>>>  	if (new !=3D pkg)
>>>  		pr_info("CPU %u Converting physical %u to logical package %u\n",
>>> @@ -323,44 +317,6 @@ int topology_update_package_map(unsigned int pkg=
, unsigned int cpu)
>>>  	return 0;
>>>  }
>>> =20
>>> -static void __init smp_init_package_map(struct cpuinfo_x86 *c, unsig=
ned int cpu)
>>> -{
>>> -	unsigned int ncpus;
>>> -
>>> -	/*
>>> -	 * Today neither Intel nor AMD support heterogenous systems. That
>>> -	 * might change in the future....
>>> -	 *
>>> -	 * While ideally we'd want '* smp_num_siblings' in the below @ncpus=

>>> -	 * computation, this won't actually work since some Intel BIOSes
>>> -	 * report inconsistent HT data when they disable HT.
>>> -	 *
>>> -	 * In particular, they reduce the APIC-IDs to only include the core=
s,
>>> -	 * but leave the CPUID topology to say there are (2) siblings.
>>> -	 * This means we don't know how many threads there will be until
>>> -	 * after the APIC enumeration.
>>> -	 *
>>> -	 * By not including this we'll sometimes over-estimate the number o=
f
>>> -	 * logical packages by the amount of !present siblings, but this is=

>>> -	 * still better than MAX_LOCAL_APIC.
>>> -	 *
>>> -	 * We use total_cpus not nr_cpu_ids because nr_cpu_ids can be limit=
ed
>>> -	 * on the command line leading to a similar issue as the HT disable=

>>> -	 * problem because the hyperthreads are usually enumerated after th=
e
>>> -	 * primary cores.
>>> -	 */
>>> -	ncpus =3D boot_cpu_data.x86_max_cores;
>>> -	if (!ncpus) {
>>> -		pr_warn("x86_max_cores =3D=3D zero !?!?");
>>> -		ncpus =3D 1;
>>> -	}
>>> -
>>> -	__max_logical_packages =3D DIV_ROUND_UP(total_cpus, ncpus);
>>> -	pr_info("Max logical packages: %u\n", __max_logical_packages);
>>> -
>>> -	topology_update_package_map(c->phys_proc_id, cpu);
>>> -}
>>> -
>>>  void __init smp_store_boot_cpu_info(void)
>>>  {
>>>  	int id =3D 0; /* CPU 0 */
>>> @@ -368,7 +324,7 @@ void __init smp_store_boot_cpu_info(void)
>>> =20
>>>  	*c =3D boot_cpu_data;
>>>  	c->cpu_index =3D id;
>>> -	smp_init_package_map(c, id);
>>> +	topology_update_package_map(c->phys_proc_id, id);
>>>  	cpu_data(id).set =3D 1;
>>>  }
>>> =20
>>> @@ -1371,7 +1327,16 @@ void __init native_smp_prepare_boot_cpu(void)
>>> =20
>>>  void __init native_smp_cpus_done(unsigned int max_cpus)
>>>  {
>>> +	int ncpus;
>>> +
>>>  	pr_debug("Boot done\n");
>>> +	/*
>>> +	 * Today neither Intel nor AMD support heterogenous systems so
>>> +	 * extrapolate the boot cpu's data to all packages.
>>> +	 */
>>> +	ncpus =3D cpu_data(0).booted_cores * smp_num_siblings;
>>> +	__max_logical_packages =3D DIV_ROUND_UP(nr_cpu_ids, ncpus);
>>> +	pr_info("Max logical packages: %u\n", __max_logical_packages);
>>> =20
>>>  	if (x86_has_numa_in_package)
>>>  		set_sched_topology(x86_numa_in_package_topology);
>>
>> This breaks booting as Xen PV domain for me. The problem seems to be
>> that native_smp_cpus_done() is never called on a PV domain. So
>> __max_logical_packages is uninitialized and this leads to a NULL
>> pointer dereference in coretemp.
>>
>=20
> I'll see if I can figure out a way to test that.

Ok, thanks. If you need some logs, or if I should test something just
ask.

> Does 947134d9b00f
> ("x86/smpboot: Do not use smp_num_siblings in __max_logical_packages
> calculation") help?

No.


--7Eg4keRvJj0Q2v1JgP6detAjOTlIG3ndk--

--zEb3dtN5X1hXtVqIYFiB94gIdH9QFZ7rB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE3E8ezGzG3N1CTQ//kO9xfO/xly8FAlp7UuQACgkQkO9xfO/x
ly+8shAAgNR7wu+z6+8wievT146gAHFsOeWiLeWUAlTSUXtX0OiOdknnKsW6Prj5
HOyNGXvVZ3Om/f6aeSSrRAcsD3D/WiglH94v3OT6sUpGiTU8UsH+O6BNVhFcmTQP
w27KCWPlQQZ+qOHGp0MVnruojZJSh9CgpHnktrHwsOq1/Crv8dtaZzF6M4g3lU96
f65+J2gczYuIrwYeDmAntt7h6b1Nzw7ZOBBwZ6tVrf7/r1SUzBBM6cXjaXccRZ51
NCK8Vb1yHIKa90eS3mUHtcQHzRoC1+k1d1zhzuV8ncz4pIT9y4qrvpsAJhBRDtGR
nPaXIDmedDjRRvn5Tuy+jr5pmLCm0aKL9e/7y7CNU3SzPLA3rkEmGlc1E7npIbQp
1CoD1fWKAYNueW/C5AwJRIpX8ZJsEJkQk62ECu9kRDfObhqm47Zphgb/fulMviZD
PL0GIwKJCg6STjsbhOJsU/FAp2oYHShNWuU6iBVstYhSh+g2ZOk5MhjxcZbVrs4N
7Yd128JU8Jo8D0/EdzW/HR99ROOFfggvR0myrZHOmxj6bWhKEWMIJhseJ0J7hJ4O
SsaXpkn4HOfRDv3ojDr/0xINOmgAi3VCxWFH+tEXe2PDrvThEc0j2hZHByqxSSey
UeIAWxu5TW4A2smxgPv+cRspxbmeaGn0VDhyD1Q7XXuWriRlEPc=
=c1oq
-----END PGP SIGNATURE-----

--zEb3dtN5X1hXtVqIYFiB94gIdH9QFZ7rB--
