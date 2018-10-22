Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389EAC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 11:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE13120652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 11:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kdab.com header.i=@kdab.com header.b="SIhdGt21"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE13120652
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kdab.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbeJVTf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 15:35:57 -0400
Received: from mail.kdab.com ([176.9.126.58]:21026 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727587AbeJVTf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 15:35:57 -0400
Authentication-Results: mail.kdab.com (amavisd-new); dkim=pass (1024-bit key)
 reason="pass (just generated,
 assumed good)" header.d=kdab.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kdab.com; h=
 content-type:content-type:mime-version:references:in-reply-to
 :organization:message-id:date:date:subject:subject:from:from; s=
 dkim; t=1540207063; x=1541071064; bh=WQIaS4No+hX0/G1ZzA0wCpbQ8dU
 ei2lb6M+cHCoIHuc=; b=SIhdGt215Cwc5bESyHqqZqH6mUuIPCwBw5arOoqTRK1
 1PEScDZ2lj3fIV+2emd39zizVQ0V3Ygp/LN7na/9+q8IXwPEMqNSKq3gbrnUW6LM
 LgYiMbzUr/YeR7OhRp03TlHdt7K5B5ZjWZwXBs42vV8+fTA/QsHDdk2fMiKMkszU
 =
X-Virus-Scanned: amavisd-new at kdab.com
From:   Milian Wolff <milian.wolff@kdab.com>
To:     Milian Wolff <milian.wolff@kdab.com>
Cc:     Milian Wolff <mail@milianw.de>, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho <acme@kernel.org>
Subject: Re: Broken dwarf unwinding - wrong stack pointer register value?
Date:   Mon, 22 Oct 2018 13:17:42 +0200
Message-ID: <1775744.0RuD2nMEIt@agathebauer>
Organization: KDAB
In-Reply-To: <3129539.p6j0Z5hDSJ@agathebauer>
References: <2335309.gnWok9HYb4@agathebauer> <3129539.p6j0Z5hDSJ@agathebauer>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart9119043.urHAWtRQlT";
 micalg="sha256"; protocol="application/pkcs7-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart9119043.urHAWtRQlT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Montag, 22. Oktober 2018 12:35:39 CEST Milian Wolff wrote:
> On Sonntag, 21. Oktober 2018 00:39:51 CEST Milian Wolff wrote:
> > Hey all,
> > 
> > I'm on the quest to figure out why perf regularly fails to unwind (some)
> > samples. I am seeing very strange behavior, where an apparently wrong
> > stack
> > pointer value is read from the register - see below for more information
> > and the end of this (long) mail for my open questions. Any help would be
> > greatly appreciated.
> > 
> > I am currently using this trivial C++ code to reproduce the issue:
> > 
> > ```
> > #include <cmath>
> > #include <complex>
> > #include <iostream>
> > #include <random>
> > 
> > using namespace std;
> > 
> > int main()
> > {
> > 
> >     uniform_real_distribution<double> uniform(-1E5, 1E5);
> >     default_random_engine engine;
> >     double s = 0;
> >     for (int i = 0; i < 10000000; ++i) {
> >     
> >         s += norm(complex<double>(uniform(engine), uniform(engine)));
> >     
> >     }
> >     cout << s << '\n';
> >     return 0;
> > 
> > }
> > ```
> > 
> > I compile it with `g++ -O2 -g` and then record it with `perf record
> > --call-
> > graph dwarf`. Using perf script, I then see e.g.:
> > 
> > ```
> > $ perf script -v --no-inline --time 90229.12668,90229.127158 --ns
> > ...
> > # first frame (working unwinding from __hypot_finite):
> > unwind: reg 16, val 7faf7dca2696
> > unwind: reg 7, val 7ffc80811ca0
> > unwind: find_proc_info dso /usr/lib/libm-2.28.so
> > unwind: access_mem addr 0x7ffc80811ce8 val 7faf7dc88af9, offset 72
> > unwind: find_proc_info dso /usr/lib/libm-2.28.so
> > unwind: access_mem addr 0x7ffc80811d08 val 56382b0fc129, offset 104
> > unwind: find_proc_info dso
> > /home/milian/projects/kdab/rnd/hotspot/build/tests/
> > test-clients/cpp-inlining/cpp-inlining
> > unwind: access_mem addr 0x7ffc80811d58 val 7faf7dabf223, offset 184
> > unwind: find_proc_info dso /usr/lib/libc-2.28.so
> > unwind: access_mem addr 0x7ffc80811e18 val 56382b0fc1ee, offset 376
> > unwind: find_proc_info dso
> > /home/milian/projects/kdab/rnd/hotspot/build/tests/
> > test-clients/cpp-inlining/cpp-inlining
> > unwind: __hypot_finite:ip = 0x7faf7dca2696 (0x29696)
> > unwind: hypotf32x:ip = 0x7faf7dc88af8 (0xfaf8)
> > unwind: main:ip = 0x56382b0fc128 (0x1128)
> > unwind: __libc_start_main:ip = 0x7faf7dabf222 (0x24222)
> > unwind: _start:ip = 0x56382b0fc1ed (0x11ed)
> > # second frame (unrelated)
> > unwind: reg 16, val 56382b0fc114
> > unwind: reg 7, val 7ffc80811d10
> > unwind: find_proc_info dso
> > /home/milian/projects/kdab/rnd/hotspot/build/tests/
> > test-clients/cpp-inlining/cpp-inlining
> > unwind: access_mem addr 0x7ffc80811d58 val 7faf7dabf223, offset 72
> > unwind: access_mem addr 0x7ffc80811e18 val 56382b0fc1ee, offset 264
> > unwind: main:ip = 0x56382b0fc114 (0x1114)
> > unwind: __libc_start_main:ip = 0x7faf7dabf222 (0x24222)
> > unwind: _start:ip = 0x56382b0fc1ed (0x11ed)
> > # third frame (broken unwinding from __hypot_finite)
> > unwind: reg 16, val 7faf7dca2688
> > unwind: reg 7, val 7ffc80811ca0
> > unwind: find_proc_info dso /usr/lib/libm-2.28.so
> > unwind: access_mem addr 0x7ffc80811cc0 val 0, offset 32
> > unwind: __hypot_finite:ip = 0x7faf7dca2688 (0x29688)
> > unwind: '':ip = 0xffffffffffffffff (0x0)
> > 
> > cpp-inlining 24617 90229.126685606:     711026 cycles:uppp:
> > 	    7faf7dca2696 __hypot_finite+0x36 (/usr/lib/libm-2.28.so)
> > 	    7faf7dc88af8 hypotf32x+0x18 (/usr/lib/libm-2.28.so)
> > 	    56382b0fc128 main+0x88 (/home/milian/projects/kdab/rnd/hotspot/
> > 
> > build/tests/test-clients/cpp-inlining/cpp-inlining)
> > 
> > 	    7faf7dabf222 __libc_start_main+0xf2 (/usr/lib/libc-2.28.so)
> > 	    56382b0fc1ed _start+0x2d (/home/milian/projects/kdab/rnd/hotspot/
> > 
> > build/tests/test-clients/cpp-inlining/cpp-inlining)
> > 
> > cpp-inlining 24617 90229.126921551:     714657 cycles:uppp:
> > 	    56382b0fc114 main+0x74 (/home/milian/projects/kdab/rnd/hotspot/
> > 
> > build/tests/test-clients/cpp-inlining/cpp-inlining)
> > 
> > 	    7faf7dabf222 __libc_start_main+0xf2 (/usr/lib/libc-2.28.so)
> > 	    56382b0fc1ed _start+0x2d (/home/milian/projects/kdab/rnd/hotspot/
> > 
> > build/tests/test-clients/cpp-inlining/cpp-inlining)
> > 
> > cpp-inlining 24617 90229.127157818:     719976 cycles:uppp:
> > 	    7faf7dca2688 __hypot_finite+0x28 (/usr/lib/libm-2.28.so)
> > 	
> > 	ffffffffffffffff [unknown] ([unknown])
> > 
> > ...
> > ```
> > 
> > Now I'm trying to figure out why one __hypot_finite sample works but the
> > other one breaks for no apparent reason.
> 
> I've now collected some more background information, which is quite helpful
> I believe for the analysis of this issue:
> 
> Note how the broken sample has the IP pointing at __hypot_finite+0x28:
> 
> unwind: __hypot_finite:ip = 0x7faf7dca2688 (0x29688)
> 
> When we run my reproducer code in GDB, we can see that obtaining a backtrace
> from that address works just fine there:
> 
> ```
> $ gdb ./cpp-inlining
> GNU gdb (GDB) 8.2
> Copyright (C) 2018 Free Software Foundation, Inc.
> License GPLv3+: GNU GPL version 3 or later
> <http://gnu.org/licenses/gpl.html> This is free software: you are free to
> change and redistribute it. There is NO WARRANTY, to the extent permitted
> by law.
> Type "show copying" and "show warranty" for details.
> This GDB was configured as "x86_64-pc-linux-gnu".
> Type "show configuration" for configuration details.
> For bug reporting instructions, please see:
> <http://www.gnu.org/software/gdb/bugs/>.
> Find the GDB manual and other documentation resources online at:
>     <http://www.gnu.org/software/gdb/documentation/>.
> 
> For help, type "help".
> Type "apropos word" to search for commands related to "word"...
> Reading symbols from ./cpp-inlining...done.
> (gdb) break main
> Breakpoint 1 at 0x10a0: file /home/milian/projects/kdab/rnd/hotspot/tests/
> test-clients/cpp-inlining/main.cpp, line 34.
> (gdb) run
> Starting program: /home/milian/projects/kdab/rnd/hotspot/build/tests/test-
> clients/cpp-inlining/cpp-inlining
> 
> Breakpoint 1, main () at /home/milian/projects/kdab/rnd/hotspot/tests/test-
> clients/cpp-inlining/main.cpp:34
> 34      {
> (gdb) disassemble __hypot_finite
> Dump of assembler code for function __hypot_finite:
>    0x00007ffff7c96660 <+0>:     endbr64
>    0x00007ffff7c96664 <+4>:     push   %r13
>    0x00007ffff7c96666 <+6>:     push   %r12
>    0x00007ffff7c96668 <+8>:     push   %rbp
>    0x00007ffff7c96669 <+9>:     movq   %xmm1,%rbp
>    0x00007ffff7c9666e <+14>:    push   %rbx
>    0x00007ffff7c9666f <+15>:    movq   %xmm0,%rbx
>    0x00007ffff7c96674 <+20>:    shr    $0x20,%rbp
>    0x00007ffff7c96678 <+24>:    shr    $0x20,%rbx
>    0x00007ffff7c9667c <+28>:    and    $0x7fffffff,%ebp
>    0x00007ffff7c96682 <+34>:    and    $0x7fffffff,%ebx
>    0x00007ffff7c96688 <+40>:    sub    $0x28,%rsp
>    0x00007ffff7c9668c <+44>:    cmp    %ebp,%ebx
>    0x00007ffff7c9668e <+46>:    jge    0x7ffff7c966a2 <__hypot_finite+66>
>    0x00007ffff7c96690 <+48>:    mov    %ebx,%eax
>    0x00007ffff7c96692 <+50>:    movapd %xmm0,%xmm2
>    0x00007ffff7c96696 <+54>:    movapd %xmm1,%xmm0
>    0x00007ffff7c9669a <+58>:    mov    %ebp,%ebx
>    0x00007ffff7c9669c <+60>:    movapd %xmm2,%xmm1
>    0x00007ffff7c966a0 <+64>:    mov    %eax,%ebp
>    0x00007ffff7c966a2 <+66>:    movq   %xmm0,%r13
>    0x00007ffff7c966a7 <+71>:    mov    %rbx,%rax
>    0x00007ffff7c966aa <+74>:    movq   %xmm1,%r12
> --Type <RET> for more, q to quit, c to continue without paging--q
> Quit
> (gdb) break *0x00007ffff7c96688
> Breakpoint 2 at 0x7ffff7c96688
> (gdb) cont
> Continuing.
> 
> Breakpoint 2, 0x00007ffff7c96688 in __hypot_finite () from
> /usr/lib/libm.so.6 (gdb) bt
> #0  0x00007ffff7c96688 in __hypot_finite () from /usr/lib/libm.so.6
> #1  0x00007ffff7c7caf9 in hypotf64 () from /usr/lib/libm.so.6
> #2  0x0000555555555129 in std::__complex_abs (__z=<optimized out>) at /usr/
> include/c++/8.2.1/complex:1362
> #3  std::abs<double> (__z=...) at /usr/include/c++/8.2.1/complex:618
> #4  std::_Norm_helper<true>::_S_do_it<double> (__z=...) at /usr/include/c++/
> 8.2.1/complex:675
> #5  std::norm<double> (__z=...) at /usr/include/c++/8.2.1/complex:685
> #6  main () at
> /home/milian/projects/kdab/rnd/hotspot/tests/test-clients/cpp-
> inlining/main.cpp:39
> ```
> 
> But note how __hypot_finite+0x28 actually points at an instruction that
> modifies the stack pointer by 40, just like I did manually to "fix"
> unwinding for this sample (see my initial email):
> 
>    0x00007ffff7c96688 <+40>:    sub    $0x28,%rsp
> 
> So we are still in the function prologue, and can't properly unwind from
> there apparently! Any suggestions on how this should be handled? Can we
> figure out the size of the function prologue somehow and manually fix the
> stack pointer then?

After more digging, it turns out that I've apparently chased a red herring. 
I'm running archlinux which isn't shipping debug symbols for libm. Without 
those, we are apparently out of luck to unwind from the function prologue.

I still wonder whether we could catch this somehow and handle it ourselves. I 
wonder what GDB does to unwind here, despite the lack of debug information in 
libm...

Cheers

-- 
Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt, C++ and OpenGL Experts
--nextPart9119043.urHAWtRQlT
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCDEIw
ggXmMIIDzqADAgECAhBqm+E4O/8ra58B1dm4p1JWMA0GCSqGSIb3DQEBDAUAMIGFMQswCQYDVQQG
EwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYD
VQQKExFDT01PRE8gQ0EgTGltaXRlZDErMCkGA1UEAxMiQ09NT0RPIFJTQSBDZXJ0aWZpY2F0aW9u
IEF1dGhvcml0eTAeFw0xMzAxMTAwMDAwMDBaFw0yODAxMDkyMzU5NTlaMIGXMQswCQYDVQQGEwJH
QjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYDVQQK
ExFDT01PRE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0Q09NT0RPIFJTQSBDbGllbnQgQXV0aGVudGlj
YXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEB
AL6znlesKHZ1QBbHOAOY08YYdiFQ8yV5C0y1oNF9Olg+nKcxLqf2NHbZhGra0D00SOTq9bus3/mx
gUsg/Wh/eXQ0pnp8tZ8XZWAnlyKMpjL+qUByRjXCA6RQyDMqVaVUkbIr5SU0RDX/kSsKwer3H1pT
/HUrBN0X8sKtPTdGX8XAWt/VdMLBrZBlgvnkCos+KQWWCo63OTTqRvaq8aWccm+KOMjTcE6s2mj6
RkalweyDI7X+7U5lNo6jzC8RTXtVV4/Vwdax720YpMPJQaDaElmOupyTf1Qib+cpukNJnQmwygjD
8m046DQkLnpXNCAGjuJy1F5NATksUsbfJAr7FLUCAwEAAaOCATwwggE4MB8GA1UdIwQYMBaAFLuv
fgI9+qbxPISOre44mOzZMjLUMB0GA1UdDgQWBBSCr2yM+MX+lmF86B89K3FIXsSLwDAOBgNVHQ8B
Af8EBAMCAYYwEgYDVR0TAQH/BAgwBgEB/wIBADARBgNVHSAECjAIMAYGBFUdIAAwTAYDVR0fBEUw
QzBBoD+gPYY7aHR0cDovL2NybC5jb21vZG9jYS5jb20vQ09NT0RPUlNBQ2VydGlmaWNhdGlvbkF1
dGhvcml0eS5jcmwwcQYIKwYBBQUHAQEEZTBjMDsGCCsGAQUFBzAChi9odHRwOi8vY3J0LmNvbW9k
b2NhLmNvbS9DT01PRE9SU0FBZGRUcnVzdENBLmNydDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3Au
Y29tb2RvY2EuY29tMA0GCSqGSIb3DQEBDAUAA4ICAQB4XLKBKDRPPO5fVs6fl1bsj6JrF/bz9kkI
BtTYLzXN30D+03Hj6OxCDBEaIeNmsBhrJmuubvyE7HtoSmR809AgcYboW+rcTNZ/8u/Hv+GTrNI/
AhqX2/kiQNxmgUPt/eJPs92Qclj0HnVyy9TnSvGkSDU7I5Px+TbO+88G4zipA2psZaWeEykgzClZ
lPz1FjTCkk77ZXp5cQYYexE6zeeN4/0OqqoAloFrjAF4o50YJafX8mnahjp3I2Y2mkjhk0xQfhNq
bzlLWPoT3m7j7U26u7zg6swjOq8hITYc3/np5tM5aVyu6t99p17bTbY7+1RTWBviN9YJzK8HxzOb
XYWBf/L+VGOYNsQDTxAk0Hbvb1j6KjUhg7fO294F29QIhhmiNOr84JHoy+fNLpfvYc/Q9EtFOI5I
SYgOxLk3nD/whbUe9rmEQXLp8MB933Ij474gwwCPUpwv9mj2PMnXoc7mbrS22XUSeTwxCTP9bcmU
dp4jmIoWfhQm7X9w/Zgddg+JZ/YnIHOwsGsaTUgj7fIvxqith7DoJC91WJ8Lce3CVJqb1XWeKIJ8
4F7YLXZN0oa7TktYgDdmQVxYkZo1c5noaDKH9Oq9cbm/vOYRUM1cWcef20Wkyk5S/GFyyPJwG0fR
1nRas3DqAf4cXxMiEKcff7PNa4M3RGTqH0pWR8p6EjCCBlQwggU8oAMCAQICEAf6KCF9+1doL2oE
OTPysLwwDQYJKoZIhvcNAQELBQAwgZcxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1h
bmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMT0w
OwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWls
IENBMB4XDTE3MDUyMzAwMDAwMFoXDTIwMDUyMjIzNTk1OVowggFZMQswCQYDVQQGEwJTRTEPMA0G
A1UEERMGNjgzIDMxMRIwEAYDVQQIEwlWYWVybWxhbmQxEDAOBgNVBAcTB0hhZ2ZvcnMxGDAWBgNV
BAkTD05vcnJpbmdzIHZhZWcgMjEPMA0GA1UEEhMGQm94IDMwMSYwJAYDVQQKDB1LbGFyw6RsdmRh
bGVucyBEYXRha29uc3VsdCBBQjEdMBsGA1UECxMUQSBLREFCIEdyb3VwIENvbXBhbnkxQzBBBgNV
BAsMOklzc3VlZCB0aHJvdWdoIEtsYXLDpGx2ZGFsZW5zIERhdGFrb25zdWx0IEFCIEUtUEtJIE1h
bmFnZXIxHzAdBgNVBAsTFkNvcnBvcmF0ZSBTZWN1cmUgRW1haWwxFTATBgNVBAMTDE1pbGlhbiBX
b2xmZjEkMCIGCSqGSIb3DQEJARYVbWlsaWFuLndvbGZmQGtkYWIuY29tMIIBIjANBgkqhkiG9w0B
AQEFAAOCAQ8AMIIBCgKCAQEAxrzfNBVvRbiAknuTBXuQnNm9sLIFLo0vbPB6kswk78A3tA++Zn5c
lQUHhGlQq1cdYxagnUpqwvG3Sod15mPSOLkAPf/mabLN7p+lFbRaUP+97ZkTZtvb4BCC3osIEFI4
G393OSFWqc2qmIPE/SwSASbAA20Fcaa2M6P1lhOk/ttUh2jIurTPF0wUycIA7lBddrOgaOA8e2m6
iLTNHtlrfRbBaUX91D5ebY+UWmIjXSQ9+CtutMzBkwnF0rZKririvOkklg9VzEGNQVHrQfDF2s/U
pOtmtuVSwElauGT/KALyCFuIrYC1pmaKH8S1xODJqiRaf6jH8E+KQzKjyM/ErwIDAQABo4IB1TCC
AdEwHwYDVR0jBBgwFoAUgq9sjPjF/pZhfOgfPStxSF7Ei8AwHQYDVR0OBBYEFN+m99RtIuA1bSdw
6b1brOX7X3AJMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMB0GA1UdJQQWMBQGCCsGAQUF
BwMEBggrBgEFBQcDAjBGBgNVHSAEPzA9MDsGDCsGAQQBsjEBAgEDBTArMCkGCCsGAQUFBwIBFh1o
dHRwczovL3NlY3VyZS5jb21vZG8ubmV0L0NQUzBaBgNVHR8EUzBRME+gTaBLhklodHRwOi8vY3Js
LmNvbW9kb2NhLmNvbS9DT01PRE9SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWls
Q0EuY3JsMIGLBggrBgEFBQcBAQR/MH0wVQYIKwYBBQUHMAKGSWh0dHA6Ly9jcnQuY29tb2RvY2Eu
Y29tL0NPTU9ET1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcnQwJAYI
KwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmNvbW9kb2NhLmNvbTAgBgNVHREEGTAXgRVtaWxpYW4ud29s
ZmZAa2RhYi5jb20wDQYJKoZIhvcNAQELBQADggEBABf47LSJADqH+ow9INv3QM1NC/qq2bjxGvsZ
68iD11VEUAFlsYfsVTgQqUirwPVTYenXtwVBELHZyywsui1JxL7HKQetLQegDDP/RyfjReVaWxhy
3OpuItsgLVbru9QVgPifnoBFPtfZcwjeJDmeSbLT8oj4Rd0KYBOIve7WKvsfNPsNwfbLwY2zILkE
LjxZcVi2AwZHDyab+dzL/3YcLuJj1lSawBGn7ilpcdZydlv4aye51pD/MemLIYLcylt+ImrmjnTV
y+QlAHRF3s5FE8yAr+W1MBD/1bKZCSgFt8VQoAlz3hiQh8QqZp4Zl8WuVL4+mP/mT6VDEWgq/0Bo
cukxggJuMIICagIBATCBrDCBlzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hl
c3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNV
BAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EC
EAf6KCF9+1doL2oEOTPysLwwDQYJYIZIAWUDBAIBBQCggZMwGAYJKoZIhvcNAQkDMQsGCSqGSIb3
DQEHATAcBgkqhkiG9w0BCQUxDxcNMTgxMDIyMTExNzQyWjAoBgkqhkiG9w0BCQ8xGzAZMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzAvBgkqhkiG9w0BCQQxIgQg0sEp/T1JZONYWUKXNhciapLo2HUL
3tlmMyF+U/cv9oYwDQYJKoZIhvcNAQEBBQAEggEAsLpKCZw0s1zJ5/N8oUaVWmCNyrmlaHJ+KXMe
0LHpcdrfDMytHEdQFjWmZ+Ua8idrMq3r/osrKNuplkkR4GXIB2U+nOv1QEYkgfEhnKalLTK7WNlv
6MGo6PkPbAteojIzrgNjaP8ifXmJ9JFjTb5JU2/LNICdwDSw+C5OWaE4onWUmLDLaTlQEMhk6lkT
DZyqo1Asx/mwQrcGdPGrkKNMgw8tSOdNCtu2CSgt50DcV5NJS6cTVDI4EgaGcW16FJHQduG/FPWQ
z2/3j+a1+1tGEuB5MFCdTv2qZRLTnsjwdLySFZlUuDNIeXyY8eadGcMl2wQAPaGEJORbhRHXZoZ7
ngAAAAAAAA==


--nextPart9119043.urHAWtRQlT--


