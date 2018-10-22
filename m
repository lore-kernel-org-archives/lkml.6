Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6677DC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 19:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E24220652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 19:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kdab.com header.i=@kdab.com header.b="S4ALRdDV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E24220652
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kdab.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbeJWDqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 23:46:10 -0400
Received: from mail.kdab.com ([176.9.126.58]:42908 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728710AbeJWDqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 23:46:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kdab.com; h=
 content-type:content-type:mime-version:references:in-reply-to
 :organization:message-id:date:date:subject:subject:from:from; s=
 dkim; t=1540236377; x=1541100378; bh=Drd7SXkONWcqXioJx0+HsXqNN25
 1/KJtIOVRzz+LyLA=; b=S4ALRdDVuuJr77ABRgdc2vSx8VraxOhMKFbtHAlXxYi
 O2E3xUDizK/KO2hk9w8IJERoRb2MkCZmJclzwW4Zsqo61f6Us2yeoJnfvjsNqX8W
 rRgnbIbDlN1lXchSR8AoBkWinV+6felSSyTdYZFkKEqVSEKbvezz/99fMTj0woxA
 =
X-Virus-Scanned: amavisd-new at kdab.com
From:   Milian Wolff <milian.wolff@kdab.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho <acme@kernel.org>
Subject: Re: Broken dwarf unwinding - wrong stack pointer register value?
Date:   Mon, 22 Oct 2018 21:26:08 +0200
Message-ID: <2679413.U8bCfAhSQu@agathebauer>
Organization: KDAB
In-Reply-To: <87o9bmrsli.fsf@linux.intel.com>
References: <2335309.gnWok9HYb4@agathebauer> <1775744.0RuD2nMEIt@agathebauer>
 <87o9bmrsli.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2349739.eefo29Zioj";
 micalg="sha256"; protocol="application/pkcs7-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2349739.eefo29Zioj
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Montag, 22. Oktober 2018 15:58:17 CEST Andi Kleen wrote:
> Milian Wolff <milian.wolff@kdab.com> writes:
> > After more digging, it turns out that I've apparently chased a red
> > herring.
> > I'm running archlinux which isn't shipping debug symbols for libm.
> 
> 64bit executables normally have unwind information even when stripped.
> Unless someone forcefully stripped those too.
> 
> You can checkout with objdump --sections.

Right, we do have .eh_frame and .eh_frame_hdr according to readelf:

```
$ readelf  --sections /usr/lib/libm.so.6        
There are 26 section headers, starting at offset 0x183120:

Section Headers:
  [Nr] Name              Type             Address           Offset
       Size              EntSize          Flags  Link  Info  Align
  [ 0]                   NULL             0000000000000000  00000000
       0000000000000000  0000000000000000           0     0     0
  [ 1] .note.gnu.build-i NOTE             0000000000000270  00000270
       0000000000000024  0000000000000000   A       0     0     4
  [ 2] .note.ABI-tag     NOTE             0000000000000294  00000294
       0000000000000020  0000000000000000   A       0     0     4
  [ 3] .note.gnu.propert NOTE             00000000000002b8  000002b8
       0000000000000020  0000000000000000   A       0     0     8
  [ 4] .gnu.hash         GNU_HASH         00000000000002d8  000002d8
       00000000000024d0  0000000000000000   A       5     0     8
  [ 5] .dynsym           DYNSYM           00000000000027a8  000027a8
       00000000000066c0  0000000000000018   A       6     1     8
  [ 6] .dynstr           STRTAB           0000000000008e68  00008e68
       0000000000002352  0000000000000000   A       0     0     1
  [ 7] .gnu.version      VERSYM           000000000000b1ba  0000b1ba
       0000000000000890  0000000000000002   A       5     0     2
  [ 8] .gnu.version_d    VERDEF           000000000000ba50  0000ba50
       000000000000017c  0000000000000000   A       6    11     8
  [ 9] .gnu.version_r    VERNEED          000000000000bbd0  0000bbd0
       0000000000000060  0000000000000000   A       6     2     8
  [10] .rela.dyn         RELA             000000000000bc30  0000bc30
       0000000000000480  0000000000000018   A       5     0     8
  [11] .init             PROGBITS         000000000000d000  0000d000
       000000000000001b  0000000000000000  AX       0     0     4
  [12] .text             PROGBITS         000000000000d020  0000d020
       00000000000a063b  0000000000000000  AX       0     0     16
  [13] .fini             PROGBITS         00000000000ad65c  000ad65c
       000000000000000d  0000000000000000  AX       0     0     4
  [14] .rodata           PROGBITS         00000000000ae000  000ae000
       00000000000c76a4  0000000000000000   A       0     0     32
  [15] .eh_frame_hdr     PROGBITS         00000000001756a4  001756a4
       0000000000001c34  0000000000000000   A       0     0     4
  [16] .eh_frame         PROGBITS         00000000001772d8  001772d8
       00000000000093f0  0000000000000000   A       0     0     8
  [17] .hash             HASH             00000000001806c8  001806c8
       000000000000210c  0000000000000004   A       5     0     8
  [18] .init_array       INIT_ARRAY       0000000000183c80  00182c80
       0000000000000008  0000000000000008  WA       0     0     8
  [19] .fini_array       FINI_ARRAY       0000000000183c88  00182c88
       0000000000000008  0000000000000008  WA       0     0     8
  [20] .dynamic          DYNAMIC          0000000000183c90  00182c90
       00000000000001f0  0000000000000010  WA       6     0     8
  [21] .got              PROGBITS         0000000000183e80  00182e80
       0000000000000180  0000000000000008  WA       0     0     8
  [22] .data             PROGBITS         0000000000184000  00183000
       000000000000000c  0000000000000000  WA       0     0     8
  [23] .bss              NOBITS           000000000018400c  0018300c
       000000000000000c  0000000000000000  WA       0     0     4
  [24] .comment          PROGBITS         0000000000000000  0018300c
       000000000000001a  0000000000000001  MS       0     0     1
  [25] .shstrtab         STRTAB           0000000000000000  00183026
       00000000000000fa  0000000000000000           0     0     1
Key to Flags:
  W (write), A (alloc), X (execute), M (merge), S (strings), I (info),
  L (link order), O (extra OS processing required), G (group), T (TLS),
  C (compressed), x (unknown), o (OS specific), E (exclude),
  l (large), p (processor specific)
```

But should that be enough information to be able to unwind from a function 
prologue? I mean, it obviously seems to work when we unwind from the function 
body. But how would I know whether it should work from the prologue too?

Reading e.g. https://www.airs.com/blog/archives/460, I can find:

> There should be exactly one FDE covering each instruction which may be being 
executed when an exception occurs. By default an exception can only occur 
during a function call or a throw. When using the -fnon-call-exceptions gcc 
option, an exception can also occur on most memory references and floating 
point operations. When using -fasynchronous-unwind-tables, the FDE will cover 
every instruction, to permit unwinding from a signal handler.

So what if my libm wasn't compiled with -fasynchronous-unwind-tables? We 
probably cannot throw an exception in the function prologue, so potentially 
that range is simply not mapped? But this is just a shot in the dark, I have 
no clue how to get more information about what contents are actually stored in 
the .eh_frame section. I would love to find out though! Does anyone know a 
tool to sched some light into this section?

I found http://www.bitlackeys.org/#eh_frame which at least shows me that 
__hypot_finite is mentioned in the .eh_frame section:

$ nm -aD /usr/lib/libm.so.6 |& grep hypot_finite
0000000000029660 T __hypot_finite
$ ./eh_frame /usr/lib/libm.so.6 |& grep 29660
Function size: 878 Function Addr: 29660

Thanks

-- 
Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt, C++ and OpenGL Experts
--nextPart2349739.eefo29Zioj
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
DQEHATAcBgkqhkiG9w0BCQUxDxcNMTgxMDIyMTkyNjA4WjAoBgkqhkiG9w0BCQ8xGzAZMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzAvBgkqhkiG9w0BCQQxIgQgd6vzW8PHwAdY0m8wdAMb6cx9U2NW
lqvv3xgcaZ4V+7YwDQYJKoZIhvcNAQEBBQAEggEAs7lTD/cBA1DJDYFFKz6P/eFLdHQ0AwK1UFpz
od23/5Xa9lc4e8hU2OTsfpmVnB5UGmtqcjCiWQXlwFtTBiUJI327sH4iF/lWjBad/MfuACF+ExF6
+YEk3RvWBdyNcjh236m5c753iB2zVwIZsgz+zddsmuPeNVUMPH7KcuOo2NIEKNi9xgAO3Ycscw/M
6qchDJIaWx/H+1rRz9H4UBonFsmkgrMme9KZIQqYBMWpmn4ts6WxFjbKZb6HvjJEY6flsmkKw+Ad
CSdmdQcX74kmw22qzWP2sURSmR/CoAKk0ng/XQroKPPWyLXV9MMiY7jMwiGkuBge6td8iBucqJFy
7QAAAAAAAA==


--nextPart2349739.eefo29Zioj--


