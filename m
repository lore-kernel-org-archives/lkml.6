Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6911BC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 10:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1741B2082B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 10:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kdab.com header.i=@kdab.com header.b="xIoQEV5b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1741B2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kdab.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbeJWS5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 14:57:07 -0400
Received: from mail.kdab.com ([176.9.126.58]:32826 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbeJWS5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 14:57:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kdab.com; h=
 content-type:content-type:mime-version:references:in-reply-to
 :organization:message-id:date:date:subject:subject:from:from; s=
 dkim; t=1540290852; x=1541154853; bh=NDLDifv+AgK8Bg0JZlPbd6n1Pca
 Eldwhd9zSSzReBFw=; b=xIoQEV5bzujFshFKcvNlbuk+EaRb1Q8Hn6w4tWNMs5l
 PjOfr+17UYnC5slJ9qcw40/yMmOJAoXo8cv1DSDHLlDndaAxQPxrEDrH8vBnulDg
 IPwKdAdBwms6tUPQaF/SVmEkHNdZRFmuGVcgTEIf0cVQWWk2W9TX9lHzSJqMQOJE
 =
X-Virus-Scanned: amavisd-new at kdab.com
From:   Milian Wolff <milian.wolff@kdab.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho <acme@kernel.org>
Subject: Re: Broken dwarf unwinding - wrong stack pointer register value?
Date:   Tue, 23 Oct 2018 12:34:08 +0200
Message-ID: <2086866.px82jjA6i7@agathebauer>
Organization: KDAB
In-Reply-To: <20181023040356.GA6218@tassilo.jf.intel.com>
References: <2335309.gnWok9HYb4@agathebauer> <2679413.U8bCfAhSQu@agathebauer>
 <20181023040356.GA6218@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart18126460.CQvsUfvVS4";
 micalg="sha256"; protocol="application/pkcs7-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart18126460.CQvsUfvVS4
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Dienstag, 23. Oktober 2018 06:03:56 CEST Andi Kleen wrote:
> > So what if my libm wasn't compiled with -fasynchronous-unwind-tables? We
> 
> It's default (64bit since always and 32bit now too) Unless someone disabled
> it.

Excellent, good to know. Since [1] doesn't explicitly disable it, I would 
assume the information should be available.

[1]: https://git.archlinux.org/svntogit/packages.git/tree/trunk/PKGBUILD?
h=packages/glibc

> However libm might be partially written in assembler and hand written
> assembler often has problems with unwind tables because the programmer has
> to get them correct explicitely.

Yes, that could be the case. I'm unsure about the glibc build system and what 
actually gets compiled, but I found a potential source at [2]:

[2]: https://github.com/bminor/glibc/blob/
43b1048ab9418e902aac8c834a7a9a88c501620a/sysdeps/ieee754/dbl-64/e_hypot.c

I believe this is what is used on my system, since I can spot calls to 
__issignaling@@GLIBC_2.18 etc. in the disassembly of __hypot_finite ([3]), 
which matches the sources referenced in [2].

[3]: https://paste.kde.org/poywa7y2z

If [2] is used, then it's not hand written assembler but code compiled by the 
compiler. So unwinding should work, even from the prologue? 

I have since also figured out how to dump the .eh_frame contents in a human 
readable format via readelf. Remember, __hypot_finite on my system is at 
offset 0x29660 of libm, so I think the following are the corresponding 
.eh_frame contents:

```
$ readelf --debug-dump=frames /usr/lib/libm.so.6 |& less
...
00002b60 000000000000004c 00002b64 FDE cie=00000000 
pc=0000000000029660..00000000000299ce
  DW_CFA_advance_loc: 6 to 0000000000029666
  DW_CFA_def_cfa_offset: 16
  DW_CFA_offset: r13 (r13) at cfa-16
  DW_CFA_advance_loc: 2 to 0000000000029668
  DW_CFA_def_cfa_offset: 24
  DW_CFA_offset: r12 (r12) at cfa-24
  DW_CFA_advance_loc: 1 to 0000000000029669
  DW_CFA_def_cfa_offset: 32
  DW_CFA_offset: r6 (rbp) at cfa-32
  DW_CFA_advance_loc: 6 to 000000000002966f
  DW_CFA_def_cfa_offset: 40
  DW_CFA_offset: r3 (rbx) at cfa-40
  DW_CFA_advance_loc: 29 to 000000000002968c
  DW_CFA_def_cfa_offset: 80
  DW_CFA_advance_loc2: 291 to 00000000000297af
  DW_CFA_remember_state
  DW_CFA_def_cfa_offset: 40
  DW_CFA_advance_loc: 5 to 00000000000297b4
  DW_CFA_def_cfa_offset: 32
  DW_CFA_advance_loc: 1 to 00000000000297b5
  DW_CFA_def_cfa_offset: 24
  DW_CFA_advance_loc: 2 to 00000000000297b7
  DW_CFA_def_cfa_offset: 16
  DW_CFA_advance_loc: 2 to 00000000000297b9
  DW_CFA_def_cfa_offset: 8
  DW_CFA_advance_loc: 7 to 00000000000297c0
  DW_CFA_restore_state
  DW_CFA_advance_loc1: 88 to 0000000000029818
  DW_CFA_remember_state
  DW_CFA_def_cfa_offset: 40
  DW_CFA_advance_loc: 1 to 0000000000029819
  DW_CFA_def_cfa_offset: 32
  DW_CFA_advance_loc: 1 to 000000000002981a
  DW_CFA_def_cfa_offset: 24
  DW_CFA_advance_loc: 2 to 000000000002981c
  DW_CFA_def_cfa_offset: 16
  DW_CFA_advance_loc: 2 to 000000000002981e
  DW_CFA_def_cfa_offset: 8
  DW_CFA_advance_loc: 18 to 0000000000029830
  DW_CFA_restore_state
  DW_CFA_nop
```

I notice that this does not touch the rsp register at all, even though it's 
mutated by the code, leading to the issue. See again this paste for the 
disassembly at [3], and note that the broken sample frame points at 

0x0000000000029688 <+40>:    sub    $0x28,%rsp

Can someone at least confirm whether unwinding from a function prologue via 
.eh_frame (but without .debug_frame) should actually be possible?

Thanks
-- 
Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt, C++ and OpenGL Experts
--nextPart18126460.CQvsUfvVS4
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
DQEHATAcBgkqhkiG9w0BCQUxDxcNMTgxMDIzMTAzNDA4WjAoBgkqhkiG9w0BCQ8xGzAZMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzAvBgkqhkiG9w0BCQQxIgQgODrAP7nq9kGbXnW22bo01Y2GprNE
kKesTe3gn0lD2cAwDQYJKoZIhvcNAQEBBQAEggEAgepwLxP+SZ/CLchFzosuybmCwZw1/+G+4s6e
M5pnXoNidVCEFI+HNzSK9VuayhLTulpML5HShwvRBxLG3WWHupEuyA7xCSSG7eiYauYcrFl5aESY
dJjBPipQaHffCW+/dtrMw1OT5XnEhzVG2S6oMQLvpuUtyEBxBVhwusEnCQR83OhvmwfS0jzepFmy
uVj8wPFI/WizaPyu5eW7EC8U5Zc6hP1hs2+5IWS2gLKPr9bVbpP0CPz7SwvsocpCdb8E1eXOTMJv
hC83SBLQEluzuszHiN6isku8NaTz8TqrRARX8wfaJpIJhEeSTOxT8X/ElNQzgMkBDOUP/nIMSYwj
kwAAAAAAAA==


--nextPart18126460.CQvsUfvVS4--


