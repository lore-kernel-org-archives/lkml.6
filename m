Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD0FC5ACCA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 19:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE26D2098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 19:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kdab.com header.i=@kdab.com header.b="J+nInHzL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE26D2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kdab.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbeJQCws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 22:52:48 -0400
Received: from mail.kdab.com ([176.9.126.58]:39647 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727097AbeJQCws (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 22:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kdab.com; h=
 content-type:content-type:mime-version:references:in-reply-to
 :organization:message-id:date:date:subject:subject:from:from; s=
 dkim; t=1539716454; x=1540580455; bh=uw6k5GeYO8FYJPzwj4KQ5FvoqCU
 756vPg5R9GfaspFg=; b=J+nInHzLbwQ5oJbQnLmz4EqSjMLFzYpDUyrQL5nxFo1
 bxMLH/t40+KSyFktX1cKT8Uwd1htUXyeQge8G3AJf3zMrVFdiGmwDVsLK0bE0LQH
 aECe6EotBO71sJbofD7TxQ4ZluU4qIn3m3DfSXiw8zyeOXr3bJpsLNWOlRWBBC1o
 =
X-Virus-Scanned: amavisd-new at kdab.com
From:   Milian Wolff <milian.wolff@kdab.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jin Yao <yao.jin@linux.intel.com>
Subject: Re: [PATCH 3/3] perf report: don't crash on invalid inline debug
 information
Date:   Tue, 16 Oct 2018 21:00:48 +0200
Message-ID: <19251847.rgPmgX8CgI@agathebauer>
Organization: KDAB
In-Reply-To: <20181016175204.GF3849@kernel.org>
References: <20180926135207.30263-1-milian.wolff@kdab.com>
 <20181016174923.GE3849@kernel.org> <20181016175204.GF3849@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2546178.Pi7catLKb7";
 micalg="sha256"; protocol="application/pkcs7-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2546178.Pi7catLKb7
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Dienstag, 16. Oktober 2018 19:52:04 CEST Arnaldo Carvalho de Melo wrote:
> Em Tue, Oct 16, 2018 at 02:49:23PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Mon, Oct 15, 2018 at 10:51:36PM +0200, Milian Wolff escreveu:
> > > On Donnerstag, 11. Oktober 2018 21:39:20 CEST Arnaldo Carvalho de Melo 
wrote:
> > > > Em Thu, Oct 11, 2018 at 08:23:31PM +0200, Milian Wolff escreveu:
> > > > > On Donnerstag, 27. September 2018 21:10:37 CEST Arnaldo Carvalho de
> > > > > Melo
> > > > > 
> > > > > wrote:
> > > > > > Em Wed, Sep 26, 2018 at 03:52:07PM +0200, Milian Wolff escreveu:
> > > > > > > When the function name for an inline frame is invalid, we must
> > > > > > > not try to demangle this symbol, otherwise we crash with:
> > > > > > > 
> > > > > > > #0  0x0000555555895c01 in bfd_demangle ()
> > > > > > > #1  0x0000555555823262 in demangle_sym (dso=0x555555d92b90,
> > > > > > > elf_name=0x0,
> > > > > > > kmodule=0) at util/symbol-elf.c:215 #2  dso__demangle_sym
> > > > > > > (dso=dso@entry=0x555555d92b90, kmodule=<optimized out>,
> > > > > > > kmodule@entry=0,
> > > > > > > elf_name=elf_name@entry=0x0) at util/symbol-elf.c:400 #3
> > > > > > > 0x00005555557fef4b in new_inline_sym (funcname=0x0,
> > > > > > > base_sym=0x555555d92b90, dso=0x555555d92b90) at
> > > > > > > util/srcline.c:89 #4
> > > > > > > inline_list__append_dso_a2l (dso=dso@entry=0x555555c7bb00,
> > > > > > > node=node@entry=0x555555e31810, sym=sym@entry=0x555555d92b90) at
> > > > > > > util/srcline.c:264 #5  0x00005555557ff27f in addr2line
> > > > > > > (dso_name=dso_name@entry=0x555555d92430
> > > > > > > "/home/milian/.debug/.build-id/f7/186d14bb94f3c6161c010926da6603
> > > > > > > 3d24fc
> > > > > > > e5/
> > > > > > > elf", addr=addr@entry=2888, file=file@entry=0x0,>
> > > > > > > 
> > > > > > >     line=line@entry=0x0, dso=dso@entry=0x555555c7bb00,
> > > > > > >     unwind_inlines=unwind_inlines@entry=true,
> > > > > > >     node=0x555555e31810,
> > > > > > >     sym=0x555555d92b90) at util/srcline.c:313>
> > > > > > > 
> > > > > > > #6  0x00005555557ffe7c in addr2inlines (sym=0x555555d92b90,
> > > > > > > dso=0x555555c7bb00, addr=2888, dso_name=0x555555d92430
> > > > > > > "/home/milian/.debug/.build-id/f7/186d14bb94f3c6161c010926da6603
> > > > > > > 3d24fc
> > > > > > > e5/
> > > > > > > elf")>
> > > > > > > 
> > > > > > >     at util/srcline.c:358
> > > > > > > 
> > > > > > > So instead handle the case where we get invalid function names
> > > > > > > for inlined frames and use a fallback '??' function name
> > > > > > > instead.
> > > > > > > 
> > > > > > > While this crash was originally reported by Hadrien for rust
> > > > > > > code,
> > > > > > > I can now also reproduce it with trivial C++ code. Indeed, it
> > > > > > > seems
> > > > > > > like libbfd fails to interpret the debug information for the
> > > > > > > inline
> > > > > > > frame symbol name:
> > > > > > > 
> > > > > > > $ addr2line -e
> > > > > > > /home/milian/.debug/.build-id/f7/186d14bb94f3c6161c010926da66033
> > > > > > > d24fce
> > > > > > > 5/e
> > > > > > > lf -if b48 main
> > > > > > > /usr/include/c++/8.2.1/complex:610
> > > > > > > ??
> > > > > > > /usr/include/c++/8.2.1/complex:618
> > > > > > > ??
> > > > > > > /usr/include/c++/8.2.1/complex:675
> > > > > > > ??
> > > > > > > /usr/include/c++/8.2.1/complex:685
> > > > > > > main
> > > > > > > /home/milian/projects/kdab/rnd/hotspot/tests/test-clients/cpp-in
> > > > > > > lining
> > > > > > > /mai
> > > > > > > n.cpp:39
> > > > > > > 
> > > > > > > I've reported this bug upstream and also attached a patch there
> > > > > > > which should fix this issue:
> > > > > > > https://sourceware.org/bugzilla/show_bug.cgi?id=23715
> > > > > > 
> > > > > > Millian, what about this one, which is the cset it is fixing?
> > > > > 
> > > > > Hey Arnaldo,
> > > > > 
> > > > > just noticed this email and that the corresponding patch hasn't
> > > > > landed in
> > > > > perf/core yet. The patch set which introduced this is a64489c56c307
> > > > > ("perf
> > > > > report: Find the inline stack for a given address"). Note that the
> > > > > code
> > > > > was
> > > > > introduced by this patch, but then subsequently touched and moved by
> > > > > follow up patches. So, is this the patch you want to see referenced?
> > > > > Otherwise, the latest patch which gets fixed is afaik: 7285cf3325b4a
> > > > > ("perf srcline: Show correct function name for srcline of
> > > > > callchains").
> > > > > 
> > > > > Can you please pick either of these patches and amend the commit
> > > > > message
> > > > > of my patch and push it to perf/urgent and perf/core?
> > > > 
> > > > I'll reread all this later or tomorrow and continue, going AFK now.
> > > 
> > > Ping?
> > 
> > Applied, seems simple enough, makes this code a bit more robust.
> > 
> > With regards to the cset where the problem originally was introduced,
> > i.e. not checking if a2l->funcname was NULL before either passing it to
> > strdup() or all the way to bfd_demangle(), that would cause the crash in
> > 
> > either place, I think this is the cset:
> >   commit a64489c56c307bf0955f0489158c5ecf6aa10fe2
> >   Author: Jin Yao <yao.jin@linux.intel.com>
> >   Date:   Sun Mar 26 04:34:26 2017 +0800
> >   
> >       perf report: Find the inline stack for a given address
> >> 
> >> Agreed?
> 
> But I'm not sure this will be worth for doing backports, as before
> applying this patch a series of other patches touching this code would
> have to be applied :-\
> 
> I can leave it there, so that we know when the problem was introduced,
> i.e. I _guess_ that if this rust or C++ reproducers would be used with
> perf built with a64489c56c307bf0955f0489158c5ecf6aa10fe2 as head, we
> would see a crash as well.

Yes, probably. And backporting this patch should be easily doable for anyone 
with a little C knowledge ;-)

Cheers

-- 
Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt, C++ and OpenGL Experts
--nextPart2546178.Pi7catLKb7
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
DQEHATAcBgkqhkiG9w0BCQUxDxcNMTgxMDE2MTkwMDQ4WjAoBgkqhkiG9w0BCQ8xGzAZMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzAvBgkqhkiG9w0BCQQxIgQgtBt1E6SxkWIISsovkMv9J0Vg3f2i
feYySH6C7fUB6UgwDQYJKoZIhvcNAQEBBQAEggEAhy1L6ocgdU2bP+XOe2K9V8qg3xXTSZ/AJdV2
Y32Sia5A+UJo0L3FnJd+iHlPmaWwVkBofVyITQxm64btW7DaOvuruxqQqBSWFXNaNSlVB+17XoPc
nsNbFCKQlLqw7ArYZgGcsVFS+Hw9v7DqigxMJvmP/fsLkbPYfb4/c5brIjZI774k2My9JigjGJ/t
23a6NZD23joRNk4FdgsSsdfYXli5s+9d704UTTeGrFXAote1MdcdzC5rqiRmgGxtES2V8gMfck9z
Es4ssDIN6Emb/m1pS6E7vs950hPsBmEU1yViebsuC2M1ht5d/tVOnv5w7MafEZf+jZMJKbknAdaI
KQAAAAAAAA==


--nextPart2546178.Pi7catLKb7--


