Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73D1C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8296120658
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kdab.com header.i=@kdab.com header.b="VKXdzszu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8296120658
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kdab.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbeJVS1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:27:24 -0400
Received: from mail.kdab.com ([176.9.126.58]:60187 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727554AbeJVS1X (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:27:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kdab.com; h=
 content-type:content-type:mime-version:references:in-reply-to
 :organization:message-id:date:date:subject:subject:from:from; s=
 dkim; t=1540202966; x=1541066967; bh=XK+0f2NthNGHWAL093QGqGT71nX
 ea1FsUufq2tPozew=; b=VKXdzszuQBTE2mU0fvzo9aTBMCIxt09l7cC2MAgq5sP
 oA7wwxV+rw6c6VzqR3KxgBlfG4QeFPdFvggIlrG0euClFCPNz9VCikPH1ReJR0ig
 H5s1P39szlFOSI7D+xVZ61DwejO3LJ2ywsDHt9uRKsjVYLCwlO4DRVNhLYoelTE8
 =
X-Virus-Scanned: amavisd-new at kdab.com
From:   Milian Wolff <milian.wolff@kdab.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, Linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/2] perf script: flush output stream after events in
 verbose mode
Date:   Mon, 22 Oct 2018 12:09:22 +0200
Message-ID: <4444017.LnbBPIbh24@agathebauer>
Organization: KDAB
In-Reply-To: <20181022094317.GG2452@krava>
References: <20181021191424.16183-1-milian.wolff@kdab.com>
 <20181021191424.16183-2-milian.wolff@kdab.com> <20181022094317.GG2452@krava>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3629398.2PHXbrJRRo";
 micalg="sha256"; protocol="application/pkcs7-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3629398.2PHXbrJRRo
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Montag, 22. Oktober 2018 11:43:17 CEST Jiri Olsa wrote:
> On Sun, Oct 21, 2018 at 09:14:24PM +0200, Milian Wolff wrote:
> > When the perf script output is written to a terminal stream,
> > the normal output of `perf script` would get buffered, but its
> > debug output would be written directly. This made it quite hard
> > to figure out where a given debug output is coming from. We can
> > improve on this by flushing the output buffer after processing an
> > event. To see the value, compare the following output for a
> > `perf script -v` run:
> > 
> > Before this patch:
> > ```
> > unwind: reg 16, val 7faf7dfdc000
> > unwind: reg 7, val 7ffc80811e30
> > unwind: find_proc_info dso /usr/lib/ld-2.28.so
> > unwind: reg 6, val 0
> > unwind: _start:ip = 0x7faf7dfdc000 (0x2000)
> > unwind: reg 16, val 7faf7dfdc000
> > unwind: reg 7, val 7ffc80811e30
> > unwind: find_proc_info dso /usr/lib/ld-2.28.so
> > unwind: reg 6, val 0
> > unwind: _start:ip = 0x7faf7dfdc000 (0x2000)
> > unwind: reg 16, val 7faf7dfdc000
> > unwind: reg 7, val 7ffc80811e30
> > unwind: find_proc_info dso /usr/lib/ld-2.28.so
> > unwind: reg 6, val 0
> > unwind: _start:ip = 0x7faf7dfdc000 (0x2000)
> > unwind: reg 16, val 7faf7dfdc000
> > unwind: reg 7, val 7ffc80811e30
> > ... lots and lots of verbose debug output
> > 
> > cpp-inlining 24617 90229.122036534:          1 cycles:uppp:
> >             7faf7dfdc000 _start+0x0 (/usr/lib/ld-2.28.so)
> > 
> > cpp-inlining 24617 90229.122043974:          1 cycles:uppp:
> >             7faf7dfdc000 _start+0x0 (/usr/lib/ld-2.28.so)
> > 
> > ...
> > ```
> > 
> > After this patch:
> > ```
> > ...
> > unwind: reg 16, val 7faf7dfdc000
> > unwind: reg 7, val 7ffc80811e30
> > unwind: find_proc_info dso /usr/lib/ld-2.28.so
> > unwind: reg 6, val 0
> > unwind: _start:ip = 0x7faf7dfdc000 (0x2000)
> > 
> > cpp-inlining 24617 90229.122036534:          1 cycles:uppp:
> >             7faf7dfdc000 _start+0x0 (/usr/lib/ld-2.28.so)
> > 
> > unwind: reg 16, val 7faf7dfdc000
> > unwind: reg 7, val 7ffc80811e30
> > unwind: find_proc_info dso /usr/lib/ld-2.28.so
> > unwind: reg 6, val 0
> > unwind: _start:ip = 0x7faf7dfdc000 (0x2000)
> > 
> > cpp-inlining 24617 90229.122043974:          1 cycles:uppp:
> >             7faf7dfdc000 _start+0x0 (/usr/lib/ld-2.28.so)
> > 
> > ...
> > ```
> > 
> > This new output format makes it much easier to use perf script
> > output for debugging purposes, e.g. to investigate broken dwarf
> > unwinding.
> 
> yep, I plan to check on this ;-)
> 
> > Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
> > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > ---
> > 
> >  tools/perf/builtin-script.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> > index bd468b90801b..ca09b7d2adb7 100644
> > --- a/tools/perf/builtin-script.c
> > +++ b/tools/perf/builtin-script.c
> > @@ -1737,6 +1737,9 @@ static void process_event(struct perf_script
> > *script,
> > 
> >  	if (PRINT_FIELD(METRIC))
> >  	
> >  		perf_sample__fprint_metric(script, thread, evsel, sample, fp);
> > 
> > +
> > +	if (verbose)
> > +		fflush(fp);
> 
> should we call fflush(NULL) to dump all the streams?
> 
> the verbose goes to stderr and fp seems to be stdout byt default

stderr isn't buffered, so we don't need to flush it. So personally, I don't 
see a need to dump all streams - fp should be enough? Can you maybe explain 
where it would be required to flush more buffers?

Thanks

-- 
Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt, C++ and OpenGL Experts
--nextPart3629398.2PHXbrJRRo
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
DQEHATAcBgkqhkiG9w0BCQUxDxcNMTgxMDIyMTAwOTIyWjAoBgkqhkiG9w0BCQ8xGzAZMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzAvBgkqhkiG9w0BCQQxIgQgOvoeynrwaK5JrAGRMTM8sMQol2kr
39GEJZcrbWw8eOEwDQYJKoZIhvcNAQEBBQAEggEASecpXDlLTvQsvKPhER3ElSWHpuyEDn1cm0yJ
7ISdaoryu8tKy7DIyT7zb7iKfUS3gFD3HQ5PWqeKDNIU0CbpkwysZZTCE+TbqxQGTi5qhDRh/cQF
GWK0K208vlJctth3uTCKS1npANBvaWzjQf0FuukBUwtKlV4Tq/cvo1e5CXIVvXuXwPye4AC6Wr6u
L6B/smdhKjjToGdh6bWtgX4GvXwOJIHkVaag9h2VSOBANdGaxXdxOu4HzTUbKQxmzUQ9yOC6XkYh
cFQ8HWQRvchfQeT8N98dRQ1y2ZvYjHV9AWrQwQCO0IsEDqEVParfgW5yk2SyUNRpVgI+7Wtm8s/G
5QAAAAAAAA==


--nextPart3629398.2PHXbrJRRo--


