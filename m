Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68532C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 22:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 195F820827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 22:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kdab.com header.i=@kdab.com header.b="WLTCjJm/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 195F820827
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kdab.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbeJaHaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 03:30:02 -0400
Received: from mail.kdab.com ([176.9.126.58]:34050 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbeJaHaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 03:30:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kdab.com; h=
 content-type:content-type:mime-version:references:in-reply-to
 :organization:message-id:date:date:subject:subject:from:from; s=
 dkim; t=1540938876; x=1541802877; bh=8c3dP16FVm4vwgwW6hpnZeVCb04
 TBkvgBeNgJ1x8uVc=; b=WLTCjJm/Tjnveks1H56XWF6Ow6/0muxG7xx7HSWDhNw
 UaWQXMs6NGQZKJ6I+ho4B5j4WgHom4xPKBu6HGMENlCw1Ka8KU8+wTlGt6OyHOQJ
 VZfK0/Qpla6pZkWJRfGnLoWmYkbOBRVqPzWiWnF0hgs7EEJ+Ea2J4WCK0vWq5kVw
 =
X-Virus-Scanned: amavisd-new at kdab.com
From:   Milian Wolff <milian.wolff@kdab.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho <acme@kernel.org>
Subject: Re: Broken dwarf unwinding - wrong stack pointer register value?
Date:   Tue, 30 Oct 2018 23:34:35 +0100
Message-ID: <2122395.LD3O1NFKj8@agathebauer>
Organization: KDAB
In-Reply-To: <20181024144818.GF6218@tassilo.jf.intel.com>
References: <2335309.gnWok9HYb4@agathebauer> <2086866.px82jjA6i7@agathebauer>
 <20181024144818.GF6218@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3302464.k7scMqzeI8";
 micalg="sha256"; protocol="application/pkcs7-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3302464.k7scMqzeI8
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Mittwoch, 24. Oktober 2018 16:48:18 CET Andi Kleen wrote:
> > Can someone at least confirm whether unwinding from a function prologue
> > via
> > .eh_frame (but without .debug_frame) should actually be possible?
> 
> Yes it should be possible. Asynchronous unwind tables should work
> from any instruction.

I'm still trying to figure out what's going on here... I have remembered, that 
libunwind has a quite helpful debug mode, which I further extended to generate 
a more detailed report of the failed unwinding attempt. For one of the broken 
samples, I see:

```
$ UNW_DEBUG_LEVEL=15 perf script -v
...
cpp-inlining 30227 18486.357148:     788066 cycles:ppp:  
>_Ux86_64_init_remote: (cursor=0x7fffafa55c10)
unwind: reg 16, val 7f91345d77b4
unwind: reg 7, val 7ffd1e276f18
 >_Ux86_64_step: (cursor=0x7fffafa55c10, ip=0x00007f91345d77b4, 
cfa=0x00007ffd1e276f18)
unwind: find_proc_info dso /usr/lib/libm-2.28.so
               >_Ux86_64_dwarf_search_unwind_table: ip=0x7f91345d77b4, 
start_ip=0xffffffffffeb3fbc
 >_Ux86_64_dwarf_search_unwind_table: e->fde_offset = 4794, segbase = 
7f91347236a4, debug_frame_base = 0, fde_addr = 7f9134727e38
            >_Ux86_64_dwarf_extract_proc_info_from_fde: FDE @ 0x7f9134727e38
               >_Ux86_64_dwarf_extract_proc_info_from_fde: looking for CIE at 
address 7f91347252d8
               >parse_cie: CIE parsed OK, augmentation = "zR", handler=0x0
               >_Ux86_64_dwarf_extract_proc_info_from_fde: FDE covers IP 
0x7f91345d7660-0x7f91345d79ce, LSDA=0x0
     >_Ux86_64_fetch_frame: fetch frame ip=0x7f91345d77b4 cfa=0x7ffd1e276f18 
format=0
               >run_cfi_program: CFA_def_cfa r7+0x8
               >run_cfi_program: CFA_offset r16 at cfa+0xfffffffffffffff8
               >run_cfi_program: CFA_advance_loc to 0x7f91345d7666
               >run_cfi_program: CFA_def_cfa_offset 0x10
               >run_cfi_program: CFA_offset r13 at cfa+0xfffffffffffffff0
               >run_cfi_program: CFA_advance_loc to 0x7f91345d7668
               >run_cfi_program: CFA_def_cfa_offset 0x18
               >run_cfi_program: CFA_offset r12 at cfa+0xffffffffffffffe8
               >run_cfi_program: CFA_advance_loc to 0x7f91345d7669
               >run_cfi_program: CFA_def_cfa_offset 0x20
               >run_cfi_program: CFA_offset r6 at cfa+0xffffffffffffffe0
               >run_cfi_program: CFA_advance_loc to 0x7f91345d766f
               >run_cfi_program: CFA_def_cfa_offset 0x28
               >run_cfi_program: CFA_offset r3 at cfa+0xffffffffffffffd8
               >run_cfi_program: CFA_advance_loc to 0x7f91345d768c
               >run_cfi_program: CFA_def_cfa_offset 0x50
               >run_cfi_program: CFA_advance_loc2 to 0x7f91345d77af
               >run_cfi_program: CFA_remember_state
               >run_cfi_program: CFA_def_cfa_offset 0x28
               >run_cfi_program: CFA_advance_loc to 0x7f91345d77b4
               >run_cfi_program: CFA_def_cfa_offset 0x20
               >run_cfi_program: CFA_advance_loc to 0x7f91345d77b5
     >_Ux86_64_cache_frame: cache frame ip=0x7f91345d77b4 cfa=0x7ffd1e276f18 
format=0
     >_Ux86_64_reuse_frame: reuse frame ip=0x7f91345d77b4 cfa=0x7ffd1e276f18 
format=0 addr=0x0 offset=+0
               >apply_reg_state: CFA_REG_COLUMN[17] = 0x7, 
DWARF_CFA_OFF_COLUMN[18] = 0x20
               >apply_reg_state: CFA = 0x7ffd1e276f18 (pop) + 0x20 = 
0x7ffd1e276f38
               >apply_reg_state: 0: DWARF_WHERE_SAME = (0, 2)
               >apply_reg_state: 1: DWARF_WHERE_SAME = (1, 2)
               >apply_reg_state: 2: DWARF_WHERE_SAME = (2, 2)
               >apply_reg_state: 3: DWARF_WHERE_CFAREL = 7ffd1e276f38 + -40 = 
(7ffd1e276f10, 0)
               >apply_reg_state: 4: DWARF_WHERE_SAME = (4, 2)
               >apply_reg_state: 5: DWARF_WHERE_SAME = (5, 2)
               >apply_reg_state: 6: DWARF_WHERE_CFAREL = 7ffd1e276f38 + -32 = 
(7ffd1e276f18, 0)
               >apply_reg_state: 7: DWARF_WHERE_SAME = (7, 2)
               >apply_reg_state: 8: DWARF_WHERE_SAME = (8, 2)
               >apply_reg_state: 9: DWARF_WHERE_SAME = (9, 2)
               >apply_reg_state: 10: DWARF_WHERE_SAME = (a, 2)
               >apply_reg_state: 11: DWARF_WHERE_SAME = (b, 2)
               >apply_reg_state: 12: DWARF_WHERE_CFAREL = 7ffd1e276f38 + -24 = 
(7ffd1e276f20, 0)
               >apply_reg_state: 13: DWARF_WHERE_CFAREL = 7ffd1e276f38 + -16 = 
(7ffd1e276f28, 0)
               >apply_reg_state: 14: DWARF_WHERE_SAME = (e, 2)
               >apply_reg_state: 15: DWARF_WHERE_SAME = (f, 2)
               >apply_reg_state: 16: DWARF_WHERE_CFAREL = 7ffd1e276f38 + -8 = 
(7ffd1e276f30, 0)
unwind: access_mem addr 0x7ffd1e276f30 val c0d885722245b5e4, offset 24
               >apply_reg_state: ret_addr_column: 16, ip: c0d885722245b5e4
               >_Ux86_64_step: dwarf_step returned 1
  >_Ux86_64_step: returning 1
 >_Ux86_64_step: (cursor=0x7fffafa55c10, ip=0xc0d885722245b5e4, 
cfa=0x00007ffd1e276f38)
               >_Ux86_64_step: dwarf_step returned -22
  >_Ux86_64_step: returning -22
unwind: __hypot_finite:ip = 0x7f91345d77b4 (0x297b4)
unwind: '':ip = 0xc0d885722245b5e3 (0x0)

            7f91345d77b4 __hypot_finite+0x154 (/usr/lib/libm-2.28.so)
        c0d885722245b5e3 [unknown] ([unknown])
```


Now, I also tried the following:

```
$ perf probe -x /usr/lib/libm-2.28.so -a __hypot_finite+0x154
$ perf record -F 1000 --call-graph dwarf -e probe_libm:__hypot_finite ./cpp-
inlining
```

And all of the samples unwind correctly! This makes me believe that it's not 
the .eh_frame information which is wrong - otherwise unwinding would always 
fail from these locations, esp. when using the custom probe trace point. But 
since this is not happening, what else could it be? I only see two 
possibilities: the register values or the stack memory stored in in the sample 
by perf.

The register values is unlikely, since I now understand how the .eh_frame 
contents get analyzed. For __hypot_finite+0x154, we will always end up asking 
for the address at SP+24. access_mem thus will always look at the address at 
offset 24, independent of the actual value of SP.

So, what remains is that the stack dump is somehow wrong, i.e. its contents 
are moved by some offset. Note how I can "fix" the unwinding for such broken 
samples by manually applying some offset in access_mem. By looking at other 
samples where unwinding works from __hypot_finite, I could figure out that the 
correct address to be read for unwnding should be 7f91345bdaf8, e.g.:

```
            7f91345d76ed __hypot_finite+0x8d (/usr/lib/libm-2.28.so)
            7f91345bdaf8 hypotf32x+0x18 (/usr/lib/libm-2.28.so)
            5620579cb128 main+0x88 (/home/milian/projects/kdab/rnd/hotspot/
build/tests/test-clients/cpp-inlining/cpp-inlining)
```

This address indeed occurs in the user stack dump (starting at 0xe0 in the raw 
event data) for the broken sample, cf.:


```
.  00e0:  00 20 00 00 00 00 00 00 c0 b1 9c 57 20 56 00 00  . .........W V..
.  00f0:  70 70 27 1e fd 7f 00 00 f9 da 5b 34 91 7f 00 00  pp'.......[4....
.  0100:  e4 b5 45 22 72 85 d8 c0 c0 1d 16 84 43 30 bb c0  ..E"r.......C0..
.
```

We can find `7f91345bdaf8+1 = 7f91345bdaf9" at offset 16 (search for "f9 da 5b 
34 91 7f"). Using that address makes unwinding work for this sample. What 
could be the reason for this shift?

Thanks

-- 
Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt, C++ and OpenGL Experts
--nextPart3302464.k7scMqzeI8
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
cukxggJsMIICaAIBATCBrDCBlzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hl
c3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNV
BAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EC
EAf6KCF9+1doL2oEOTPysLwwDQYJYIZIAWUDBAIBBQCggZMwGAYJKoZIhvcNAQkDMQsGCSqGSIb3
DQEHATAcBgkqhkiG9w0BCQUxDxcNMTgxMDMwMjIzNDM1WjAoBgkqhkiG9w0BCQ8xGzAZMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzAvBgkqhkiG9w0BCQQxIgQgONQc6XwK11iiY16R7FH+SqQ0PGoT
1JdwZ+s6aPDE7wYwDQYJKoZIhvcNAQEBBQAEgf98i3X3ES5IUL8eQcSFGrdYZNZic30OOV3abkPw
YHOY+rXqHxLHqVoAt9YYhzdTMX7v7MoegbnRYmYHtzZSq0w0LDWEVc0fgTF1fpWUtcWv75SaQE43
yD3zO0i0190U69GCvpJMKG4cmnSBf0WIohHDwsuQaolUVO+3PDO6H2ag270GO1sXsvBjB3HB9uNo
4z1Ka2kFXDIDzMsyrpBqluwXlQIYOto589LK7qXynYz9+AVeh0DtxRT65jDVqhU2SFRwIp0enjTE
YZpHVT1B3h6IhTpWMOjbfG/Crn2zy7SjT8uCo0S4DqU91wJz1t/u8XWpGIzZ8FezPzzyo1i6KBcA
AAAAAAA=


--nextPart3302464.k7scMqzeI8--


