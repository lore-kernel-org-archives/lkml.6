Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE3AC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FF7820656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="OBNLqv4z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfANMsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 07:48:17 -0500
Received: from mx-rz-3.rrze.uni-erlangen.de ([131.188.11.22]:57422 "EHLO
        mx-rz-3.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726467AbfANMsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 07:48:16 -0500
X-Greylist: delayed 591 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Jan 2019 07:48:14 EST
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTPS id 43dY0t5kWTz1yWX;
        Mon, 14 Jan 2019 13:38:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1547469502; bh=Fs5b4j17eD6ij0JDqdGFXqkOh4ycAEt3i37BF/JEZTU=;
        h=To:Cc:From:Subject:Date:From:To:CC:Subject;
        b=OBNLqv4zmrumKcRflypixU38zZECEhl5OSq9p6T+qBdSjwHq4OxUwP9TkqAzLsAUd
         LhmOLGiJM1u4VrD9fXrk5lvk9+7M0+57yXNaMwDAeFTg1tYtYrxYP5bSAlTnnkm7m4
         1MpE2440gvAfLFN8Q5iDBFJMpPcHjUc7tK4Fdq7/7/uLf8N1JdjTb2nxBi8s1zkbKK
         f4Cm+/0i1MBZt1JuJWVtsgCEZT1NJHA4vU2ius7ytdJsf6ZJRLDrkO39KzFUjT5ypH
         CNsF5ReFE8JRYiqYyROcYDUcx0wYEfiqrei8lYAgeUJwmd4SYV+OAm13SOiTbKYZF3
         ZFCGCmk6asbdQ==
X-Virus-Scanned: amavisd-new at boeck5.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:638:a000:4142::ffff:149
Received: from [IPv6:2001:638:a000:4142::ffff:149] (faui49copter1.informatik.uni-erlangen.de [IPv6:2001:638:a000:4142::ffff:149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX19zl1UEo1gn2N3vXYToWGQYAPXflRCIwEU=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 43dY0r3zRGz1y19;
        Mon, 14 Jan 2019 13:38:20 +0100 (CET)
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Andreas Ziegler <andreas.ziegler@fau.de>
Subject: uprobes: bug in comm/string output?
Message-ID: <bf358673-ceb2-65bf-80c9-4b1c09a8a264@fau.de>
Date:   Mon, 14 Jan 2019 13:38:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms050207060301000502010706"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms050207060301000502010706
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

Hi,

I've been playing around with uprobes today and found the following weird=
=20
behaviour/output when using more than one string argument (or using the $=
comm=20
argument). This was run on a v4.20 mainline build on Ubuntu 18.04.

root@ubuntu1810:~# uname -a
Linux ubuntu1810 4.20.0-042000-generic #201812232030 SMP Mon Dec 24 01:32=
:58 UTC=20
2018 x86_64 x86_64 x86_64 GNU/Linux

I'm trying to track calls to dlopen so I'm looking up the correct offset =
in=20
libdl.so:

root@ubuntu1810:/sys/kernel/debug/tracing# readelf -s=20
/lib/x86_64-linux-gnu/libdl-2.28.so | grep dlopen
     34: 00000000000012a0   133 FUNC    GLOBAL DEFAULT   14 dlopen@@GLIBC=
_2.2.5

Then I'm creating a uprobe with two prints of $comm and two prints of the=
 first=20
argument to dlopen, and enable that probe. The '/root/test' program only =
does a=20
dlopen("libc.so.6", RTLD_LAZY) in main().

root@ubuntu1810:/sys/kernel/debug/tracing# echo 'p:dlopen=20
/lib/x86_64-linux-gnu/libdl-2.28.so:0x12a0 $comm $comm +0(%di):string=20
+0(%di):string' > uprobe_events
root@ubuntu1810:/sys/kernel/debug/tracing# echo 1 > events/uprobes/dlopen=
/enable
root@ubuntu1810:/sys/kernel/debug/tracing# /root/test

The trace output looks like this:

root@ubuntu1810:/sys/kernel/debug/tracing# cat trace
# tracer: nop
#
#                              _-----=3D> irqs-off
#                             / _----=3D> need-resched
#                            | / _---=3D> hardirq/softirq
#                            || / _--=3D> preempt-depth
#                            ||| /     delay
#           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
#              | |       |   ||||       |         |
             test-1617  [000] d...  1237.959168: dlopen: (0x7fbd5272e2a0)=
=20
arg1=3D(fault) arg2=3D(fault) arg3=3D"libc.so.6libc.so.6" arg4=3D"libc.so=
=2E6"

That's very weird for two reasons:
- fetching $comm seems to fail with an invalid pointer
- arg3 contains the text twice (if I add another print of the argument, a=
rg3=20
will contain the wanted string three times, arg4 two times and the last a=
rgument=20
will contain it once).

On the "standard" kernel shipped with Ubuntu 18.04 (4.18) printing $comm =
works=20
but also "accumulates" (in lack of a better word) the later string argume=
nts in=20
the earlier output arguments, so for the probe above arg1 would be=20
"testtestlibc.so.6libc.so.6", arg2 would be "testlibc.so.6libc.so.6" and =

arg3/arg4 will be the same as in the output above.

Is there anything in the documentation why multiple string outputs might =
not=20
work with uprobes? Am I installing the uprobe wrong? Or is this a bug?

I found that the kprobe selftest at=20
tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc contai=
ns a=20
similar situation for kprobes (it prints the parameter two times) which w=
orks=20
fine on the same system.

Regards,

Andreas


--------------ms050207060301000502010706
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
ELswggTVMIIDvaADAgECAghQTsb1PRG0ZDANBgkqhkiG9w0BAQsFADBxMQswCQYDVQQGEwJE
RTEcMBoGA1UEChMTRGV1dHNjaGUgVGVsZWtvbSBBRzEfMB0GA1UECxMWVC1UZWxlU2VjIFRy
dXN0IENlbnRlcjEjMCEGA1UEAxMaRGV1dHNjaGUgVGVsZWtvbSBSb290IENBIDIwHhcNMTQw
NzIyMTIwODI2WhcNMTkwNzA5MjM1OTAwWjBaMQswCQYDVQQGEwJERTETMBEGA1UEChMKREZO
LVZlcmVpbjEQMA4GA1UECxMHREZOLVBLSTEkMCIGA1UEAxMbREZOLVZlcmVpbiBQQ0EgR2xv
YmFsIC0gRzAxMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA6ZvDZ4X5Da71jVTD
llA1PWLpbkztlNcAW5UidNQg6zSP1uzAMQQLmYHiphTSUqAoI4SLdIkEXlvg4njBeMsWyyg1
OXstkEXQ7aAAeny/Sg4bAMOG6VwrMRF7DPOCJEOMHDiLamgAmu7cT3ir0sYTm3at7t4m6O8B
r3QPwQmi9mvOvdPNFDBP9eXjpMhim4IaAycwDQJlYE3t0QkjKpY1WCfTdsZxtpAdxO3/NYZ9
bzOz2w/FEcKKg6GUXUFr2NIQ9Uz9ylGs2b3vkoO72uuLFlZWQ8/h1RM9ph8nMM1JVNvJEzSa
cXXFbOqnC5j5IZ0nrz6jOTlIaoytyZn7wxLyvQIDAQABo4IBhjCCAYIwDgYDVR0PAQH/BAQD
AgEGMB0GA1UdDgQWBBRJt8bP6D0ff+pEexMp9/EKcD7eZDAfBgNVHSMEGDAWgBQxw3kbuvVT
1xfgiXotF2wKsyudMzASBgNVHRMBAf8ECDAGAQH/AgECMGIGA1UdIARbMFkwEQYPKwYBBAGB
rSGCLAEBBAICMBEGDysGAQQBga0hgiwBAQQDADARBg8rBgEEAYGtIYIsAQEEAwEwDwYNKwYB
BAGBrSGCLAEBBDANBgsrBgEEAYGtIYIsHjA+BgNVHR8ENzA1MDOgMaAvhi1odHRwOi8vcGtp
MDMzNi50ZWxlc2VjLmRlL3JsL0RUX1JPT1RfQ0FfMi5jcmwweAYIKwYBBQUHAQEEbDBqMCwG
CCsGAQUFBzABhiBodHRwOi8vb2NzcDAzMzYudGVsZXNlYy5kZS9vY3NwcjA6BggrBgEFBQcw
AoYuaHR0cDovL3BraTAzMzYudGVsZXNlYy5kZS9jcnQvRFRfUk9PVF9DQV8yLmNlcjANBgkq
hkiG9w0BAQsFAAOCAQEAYyAo/ZwhhnK+OUZZOTIlvKkBmw3Myn1BnIZtCm4ssxNZdbEzkhth
Jxb/w7LVNYL7hCoBSb1mu2YvssIGXW4/buMBWlvKQ2NclbbhMacf1QdfTeZlgk4y+cN8ekvN
TVx07iHydQLsUj7SyWrTkCNuSWc1vn9NVqTszC/Pt6GXqHI+ybxA1lqkCD3WvILDt7cyjrEs
jmpttzUCGc/1OURYY6ckABCwu/xOr24vOLulV0k/2G5QbyyXltwdRpplic+uzPLl2Z9Tsz6h
L5Kp2AvGhB8Exuse6J99tXulAvEkxSRjETTMWpMgKnmIOiVCkKllO3yG0xIVIyn8LNrMOVtU
FzCCBYUwggRtoAMCAQICBxekJTUNxL8wDQYJKoZIhvcNAQELBQAwWjELMAkGA1UEBhMCREUx
EzARBgNVBAoTCkRGTi1WZXJlaW4xEDAOBgNVBAsTB0RGTi1QS0kxJDAiBgNVBAMTG0RGTi1W
ZXJlaW4gUENBIEdsb2JhbCAtIEcwMTAeFw0xNDA1MjcxNDU2MzdaFw0xOTA3MDkyMzU5MDBa
MIGjMQswCQYDVQQGEwJERTEPMA0GA1UECBMGQmF5ZXJuMREwDwYDVQQHEwhFcmxhbmdlbjEo
MCYGA1UEChMfVW5pdmVyc2l0YWV0IEVybGFuZ2VuLU51ZXJuYmVyZzENMAsGA1UECxMEUlJa
RTEPMA0GA1UEAxMGRkFVLUNBMSYwJAYJKoZIhvcNAQkBFhdjYUBycnplLnVuaS1lcmxhbmdl
bi5kZTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALeM6O3UbAkUYBzi+4jBEF8F
klzGxWvAHHou8+iNKcRVMU9fMiuJ/n4KuH/3AgzGloyieClmOqe/KlIhWURtMwsOmD3rMclX
p9ilG7eIU70uE82az1Cw7N2V3o9tlIPlDH61ZXK8XCQO05u/zubqLREeOidcV+irlur548hu
y+iURMGuowGgH1tm9l1X3735XqkvkFwnUzUkhFiABwtajxIZ022gMCJba5RXj+LSZv+67MPT
qQmdoMf3WSs8zpM854+RSSPNbinKDo4KARkfaNkTib36HPMfMTu5ViBR5TIuRJ/gAHtV3YC+
Uccjpj/y4XUN+EoqsqODlFsVv994KAkCAwEAAaOCAgQwggIAMBIGA1UdEwEB/wQIMAYBAf8C
AQEwDgYDVR0PAQH/BAQDAgEGMBEGA1UdIAQKMAgwBgYEVR0gADAdBgNVHQ4EFgQU9HPz+sZC
s8ZcacBYvnQ4+WErjmIwHwYDVR0jBBgwFoAUSbfGz+g9H3/qRHsTKffxCnA+3mQwIgYDVR0R
BBswGYEXY2FAcnJ6ZS51bmktZXJsYW5nZW4uZGUwgYgGA1UdHwSBgDB+MD2gO6A5hjdodHRw
Oi8vY2RwMS5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWNhL3B1Yi9jcmwvY2FjcmwuY3JsMD2g
O6A5hjdodHRwOi8vY2RwMi5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWNhL3B1Yi9jcmwvY2Fj
cmwuY3JsMIHXBggrBgEFBQcBAQSByjCBxzAzBggrBgEFBQcwAYYnaHR0cDovL29jc3AucGNh
LmRmbi5kZS9PQ1NQLVNlcnZlci9PQ1NQMEcGCCsGAQUFBzAChjtodHRwOi8vY2RwMS5wY2Eu
ZGZuLmRlL2dsb2JhbC1yb290LWNhL3B1Yi9jYWNlcnQvY2FjZXJ0LmNydDBHBggrBgEFBQcw
AoY7aHR0cDovL2NkcDIucGNhLmRmbi5kZS9nbG9iYWwtcm9vdC1jYS9wdWIvY2FjZXJ0L2Nh
Y2VydC5jcnQwDQYJKoZIhvcNAQELBQADggEBAAvdv5tQXS8Y3D2t/HCEcmY7UzcK/b8XU6IY
0o8b25SNIVX0qkNyC6nkx2NJNpas2cCVs5PgKmAV59oCiNupcUBJ126wiTlzuy4wI1YSJgHw
PX0rEMLefI/6YAfxgCqH0fcRy0WS845CSZNY7raVwyZBjrvCYio0i2jmniSAT6RPfWATXsrB
l3gmfBtJ7OFt0l1zLeKhhPhMeIUMojGUKsdyMslBC6Qm5UDA/N683/eGCfk3KOwKVQZ06hml
bEDwfa8j70R3XFmOVDCKcXJWlTRA/TAExQCz4Y0AWoZJ76PdMzQtjIKpvBq2Kh4L8D5azsp0
lBqMJ/8X8jD51omx47cwggZVMIIFPaADAgECAgwclFi/j/PFlOAOvOwwDQYJKoZIhvcNAQEL
BQAwgaMxCzAJBgNVBAYTAkRFMQ8wDQYDVQQIEwZCYXllcm4xETAPBgNVBAcTCEVybGFuZ2Vu
MSgwJgYDVQQKEx9Vbml2ZXJzaXRhZXQgRXJsYW5nZW4tTnVlcm5iZXJnMQ0wCwYDVQQLEwRS
UlpFMQ8wDQYDVQQDEwZGQVUtQ0ExJjAkBgkqhkiG9w0BCQEWF2NhQHJyemUudW5pLWVybGFu
Z2VuLmRlMB4XDTE3MDExMDEzMDEzNVoXDTE5MDcwOTIzNTkwMFowgaAxCzAJBgNVBAYTAkRF
MQ8wDQYDVQQIDAZCYXllcm4xETAPBgNVBAcMCEVybGFuZ2VuMTwwOgYDVQQKDDNGcmllZHJp
Y2gtQWxleGFuZGVyLVVuaXZlcnNpdGFldCBFcmxhbmdlbi1OdWVybmJlcmcxFTATBgNVBAsM
DEluZm9ybWF0aWsgNDEYMBYGA1UEAwwPQW5kcmVhcyBaaWVnbGVyMIIBIjANBgkqhkiG9w0B
AQEFAAOCAQ8AMIIBCgKCAQEAmtyQgCgFPnLKIEH2ckMjkdT6/Z9QqAOAvLrD3CPGYVBjX60K
D/vNCSxjmiljAIgA12c8atTvXjm0MPicbp6G1HAwiOZHompyuab7gF8lMiR+6aQTNwawwMRY
lEeuXVxslwVu4kMu4N5AVid2VRgnodtMdEWzhlnRF1Z4wuY9egLYdZjVVJyWKPGDrgvREn9U
P5wjvR2IjnrrjXBcEb1StUIYnQGIWySb+TjNd+LAlFy6mBVWiDOaHZO7VTZmwQOl/ezw+8LZ
b7aVxTPZsJV/Jx4sNDt1XextSSCnGDYUVGSlOhNOeFzJufdNwW6O7ZlS/DT3d1/OLcjf37SA
XWB/qwIDAQABo4ICiDCCAoQwQAYDVR0gBDkwNzARBg8rBgEEAYGtIYIsAQEEAwUwEQYPKwYB
BAGBrSGCLAIBBAMBMA8GDSsGAQQBga0hgiwBAQQwCQYDVR0TBAIwADAOBgNVHQ8BAf8EBAMC
BeAwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMB0GA1UdDgQWBBTgq5FcX/tTXVoT
pjxFcHQMQIw8NzAfBgNVHSMEGDAWgBT0c/P6xkKzxlxpwFi+dDj5YSuOYjA0BgNVHREELTAr
gRZhbmRyZWFzLnppZWdsZXJAZmF1LmRlgRF6aWVnbGVyQGNzLmZhdS5kZTCBnwYDVR0fBIGX
MIGUMEigRqBEhkJodHRwOi8vY2RwMS5wY2EuZGZuLmRlL3VuaS1lcmxhbmdlbi1udWVybmJl
cmctY2EvcHViL2NybC9jYWNybC5jcmwwSKBGoESGQmh0dHA6Ly9jZHAyLnBjYS5kZm4uZGUv
dW5pLWVybGFuZ2VuLW51ZXJuYmVyZy1jYS9wdWIvY3JsL2NhY3JsLmNybDCB7QYIKwYBBQUH
AQEEgeAwgd0wMwYIKwYBBQUHMAGGJ2h0dHA6Ly9vY3NwLnBjYS5kZm4uZGUvT0NTUC1TZXJ2
ZXIvT0NTUDBSBggrBgEFBQcwAoZGaHR0cDovL2NkcDEucGNhLmRmbi5kZS91bmktZXJsYW5n
ZW4tbnVlcm5iZXJnLWNhL3B1Yi9jYWNlcnQvY2FjZXJ0LmNydDBSBggrBgEFBQcwAoZGaHR0
cDovL2NkcDIucGNhLmRmbi5kZS91bmktZXJsYW5nZW4tbnVlcm5iZXJnLWNhL3B1Yi9jYWNl
cnQvY2FjZXJ0LmNydDANBgkqhkiG9w0BAQsFAAOCAQEAeakOmEmyphLw/P5o/WzEtqrvAa1/
JhcrbhqS4z+3ffCBxr6vz0Corp4ZqRv5mZ4aPQtP65/w/n28lFQm3AphDnmZCvUB3bH21BM1
aHOU3vGPTjuK7Ae/E9m77CbVTqnpOed7Dg2mBgy2PcdWOlqoNweM8AWEb3thsPcCdk1AueqZ
3Mp89KOHzj5wklaDyaA2k+qJdsf9GSdvXvYmoF1g9RgPPVFhwjfmgsixfTYD69E9SNVWP56B
/iQBm3wPeU+C2e8JGbAnjEoS7mOvrloGqjfpsQ7vg8vYmMwd1fu1ImLrYfxMU3wPsnv1hOd+
uGVmBu8Qu8FqH8mmhbYmwiUiUDGCBE0wggRJAgEBMIG0MIGjMQswCQYDVQQGEwJERTEPMA0G
A1UECBMGQmF5ZXJuMREwDwYDVQQHEwhFcmxhbmdlbjEoMCYGA1UEChMfVW5pdmVyc2l0YWV0
IEVybGFuZ2VuLU51ZXJuYmVyZzENMAsGA1UECxMEUlJaRTEPMA0GA1UEAxMGRkFVLUNBMSYw
JAYJKoZIhvcNAQkBFhdjYUBycnplLnVuaS1lcmxhbmdlbi5kZQIMHJRYv4/zxZTgDrzsMA0G
CWCGSAFlAwQCAQUAoIICaTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0xOTAxMTQxMjM4MjBaMC8GCSqGSIb3DQEJBDEiBCAp2SehzkZeu9XbAt295c07dUKG
4u97fM672Vwx5mmwVDBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjALBglghkgBZQME
AQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIH
MA0GCCqGSIb3DQMCAgEoMIHFBgkrBgEEAYI3EAQxgbcwgbQwgaMxCzAJBgNVBAYTAkRFMQ8w
DQYDVQQIEwZCYXllcm4xETAPBgNVBAcTCEVybGFuZ2VuMSgwJgYDVQQKEx9Vbml2ZXJzaXRh
ZXQgRXJsYW5nZW4tTnVlcm5iZXJnMQ0wCwYDVQQLEwRSUlpFMQ8wDQYDVQQDEwZGQVUtQ0Ex
JjAkBgkqhkiG9w0BCQEWF2NhQHJyemUudW5pLWVybGFuZ2VuLmRlAgwclFi/j/PFlOAOvOww
gccGCyqGSIb3DQEJEAILMYG3oIG0MIGjMQswCQYDVQQGEwJERTEPMA0GA1UECBMGQmF5ZXJu
MREwDwYDVQQHEwhFcmxhbmdlbjEoMCYGA1UEChMfVW5pdmVyc2l0YWV0IEVybGFuZ2VuLU51
ZXJuYmVyZzENMAsGA1UECxMEUlJaRTEPMA0GA1UEAxMGRkFVLUNBMSYwJAYJKoZIhvcNAQkB
FhdjYUBycnplLnVuaS1lcmxhbmdlbi5kZQIMHJRYv4/zxZTgDrzsMA0GCSqGSIb3DQEBAQUA
BIIBABcS4UqXO43lGJhI+yje8YHMagJrG5nksC4ptNOUkgej8tuJDpm/NRAiioc1UTjgCar6
n6a8qI+z/O9DUd+eco2HOmTTBtdxiYTv6XM8MqsqREQ8yzR59uOTIU5v1AFIrnqP+itSFI4p
Ql68zIuQFnfVn6pxRkgWMMEuyBnf6vP14aRVQPXgI43Md9HT0uSTWNREBuF4W8GMonfBgbCd
UOgGzYMA8mHLKcBbN+iYNLFoxGXLs6ihLstqNkQJFwWNf8FIah0RAsV2v9EccDgcHgWkzqop
2dTakspNALlJo7GcYmitvyBsb6xp3GGFh0DC2BRk99VBsUSqlEtPdLvRPBsAAAAAAAA=
--------------ms050207060301000502010706--
