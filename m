Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934155AbeEILPa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 07:15:30 -0400
Received: from smtprelay0163.hostedemail.com ([216.40.44.163]:36715 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934083AbeEILP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 07:15:27 -0400
X-Session-Marker: 7368656140736865616C6576792E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,shea@shealevy.com,:::::::::,RULES_HIT:41:355:379:599:800:871:960:965:966:967:973:988:989:1000:1260:1313:1314:1345:1359:1437:1516:1518:1535:1543:1575:1605:1711:1730:1747:1777:1792:1978:1981:2194:2196:2198:2199:2200:2201:2393:2525:2553:2559:2564:2682:2685:2859:2892:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:4362:4385:4390:4395:4605:5007:6119:6261:6506:6747:7281:7903:7909:7974:9025:9036:10004:10848:11026:11232:11473:11658:11914:12043:12050:12555:12663:12740:12895:13149:13230:14096:14180:14181:14721:21060:21080:21325:21433:21451:21627:30012:30054:30056:30070:30075:30090:30091,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:ff,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:22,LUA_SUMMARY:none
X-HE-Tag: horn46_4c7e7daa7471c
X-Filterd-Recvd-Size: 5384
From: Shea Levy <shea@shealevy.com>
To: Palmer Dabbelt <palmer@sifive.com>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 01/16] initrd: Add weakly-linked generic free_initrd_mem.
In-Reply-To: <87muxx1oim.fsf@xps13.shealevy.com>
References: <mhng-72f2db2a-5505-4736-b39b-66b85db4d21c@palmer-si-x1c4> <87muxx1oim.fsf@xps13.shealevy.com>
Date: Wed, 09 May 2018 07:15:24 -0400
Message-ID: <8736z1hygj.fsf@xps13.shealevy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi all,

Shea Levy <shea@shealevy.com> writes:

> Hi Palmer,
>
> Palmer Dabbelt <palmer@sifive.com> writes:
>
>> On Wed, 18 Apr 2018 04:10:16 PDT (-0700), shea@shealevy.com wrote:
>>> Hi all,
>>>
>>> Shea Levy <shea@shealevy.com> writes:
>>>
>>>> This function is effectively identical across 14 architectures, and
>>>> the generic implementation is small enough to be negligible in the
>>>> architectures that do override it. Many of the remaining divergent
>>>> implementations can be included in the common code path in future,
>>>> further reducing code duplication and sharing improvements between
>>>> architectures.
>>>>
>>>> Series boot-tested on RISC-V (which now uses the generic
>>>> implementation) and x86_64 (which doesn't).
>>>>
>>>> v6: Add information about build/run testing.
>>>> v5: Add more complete commit messages.
>>>> v4: Use weak symbols instead of Kconfig.
>>>> v3: Make the generic path opt-out instead of opt-in.
>>>> v2: Mark generic free_initrd_mem __init.
>>>>
>>>> Signed-off-by: Shea Levy <shea@shealevy.com>
>>>> ---
>>>>  init/initramfs.c | 5 +++++
>>>>  1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/init/initramfs.c b/init/initramfs.c
>>>> index 7e99a0038942..c8fe150f958a 100644
>>>> --- a/init/initramfs.c
>>>> +++ b/init/initramfs.c
>>>> @@ -526,6 +526,11 @@ extern unsigned long __initramfs_size;
>>>>  #include <linux/initrd.h>
>>>>  #include <linux/kexec.h>
>>>>=20=20
>>>> +void __init __weak free_initrd_mem(unsigned long start, unsigned long=
 end)
>>>> +{
>>>> +       free_reserved_area((void *)start, (void *)end, -1, "initrd");
>>>> +}
>>>> +
>>>>  static void __init free_initrd(void)
>>>>  {
>>>>  #ifdef CONFIG_KEXEC_CORE
>>>> --=20
>>>> 2.16.2
>>>
>>> This series has been quiet for a few weeks other than picking up some
>>> arch-specific acks. What is the next step here?
>>
>> I'm not sure.  I don't really think it's sane for the RISC-V tree becaus=
e it=20
>> touches so many architectures -- I haven't looked closely, though.
>
> Yeah, I think that makes sense.
>
>> IIRC=20
>> there's a slight behavior change to the RISC-V port, which I'd be OK tak=
ing=20
>> through my tree (and then obviously the RISC-V cleanup as well, unless i=
t goes=20
>> in as a whole patch set).
>>
>
> So currently the behavior for RISC-V is changed by simply deleting the
> arch-specific free_initrd_mem, which was a noop. Would you like me to
> first submit a patch to have the arch-specific free_initrd_mem and then
> change that in this series?
>
>>
>> For the IRQ cleanup I currently have in flight
>>
>> * Add the generic support
>> * Move every arch over (RISC-V is in, the rest aren't yet)
>> * Clean up a bit now that everyone is generic
>>
>> That lets all the arch-specific patches go in parallel, but can be a bit=
 of a=20
>> headache to manage.
>
> With the current series, the first patch could go in on its own and all
> of the arch-specific patches can go in in parallel if we wanted to, but
> beyond the above-suggested implementation of the RISC-V free_initrd_mem
> there's no real reordering meaningful here.
>
>>
>> I'm adding Arnd and Olof, as they know a lot more about Linux than I do.=
=20=20
>> Here's the top-level of the v4 patch set: https://lkml.org/lkml/2018/3/2=
8/744
>
> And here's the top-level of v6, the latest: https://lkml.org/lkml/2018/4/=
1/50

What's the right next step here?

Thanks,
Shea

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE6ESKvwKkwnxgMLnaXAvWlX2G/icFAlry2EwACgkQXAvWlX2G
/icZHQ/9HJ5TAg38KVwL8SZNITn9Lxm6hM9F2HFmEjRAjqkasDJpre2dDWzBmaFg
sSM/LCLTtE7BUTgUGPLU/gCx8gUOCxKPIdynlyYfFYSN8VLkoTh/FX9a4inun2E9
1xua8H4oKQ87HVC/7Pfdd/5yBgjU3P+Am0Y/syAMP6YKQLqQ91XzsW9Gutp2NR6M
2MpmWgE3IhsaXt+KYkGLo7pI15frvrQGo8pUfc0WMGm2D76A0fZ+kXFjw1vsxx2s
IIP3YOCjRHx3T0CF2MrQCFEVeSqqrGEc5JDc/ZQgDx5hIPAYk64aiLadyIEA1d/g
Jl7eruFCd1McleP+9lsw20JNl87HBaJcQRfDrgbdLV7+M28ug2C+BGPN/UzItjk4
rxx+VXUjaAa2VT6QicCoGaBPt9P45aNDlH0NpyVLWlUA7JtEC7+lzNw4AO8c1Zu0
E8sHB1WhxsiA2iP19pbyzxIvKPTzJai4ZZaZCcVCPYQLFk7ioQEEwIld3Ydua5ka
OTfw4Oj4R9U6EUckmHnyq/676fy28qArkSebAz2VI4/iN7wsXlOMi7dEHfRmYDW2
cSsBE6fHWpyG2W2VaQ+cu6X04TT2jJ676EWThe8y9EdA7j53JlCvO9rX5QLB3Vi5
U90tTFSzloA95ozGdpkrUsnO8OGFfIIJRDy6sZQuWcyvkcofGaQ=
=HmXa
-----END PGP SIGNATURE-----
--=-=-=--
