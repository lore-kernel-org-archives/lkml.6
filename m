Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9196C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 08:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77B8020859
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 08:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfAGIvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 03:51:06 -0500
Received: from mx-ginzinger.sigmacloud.services ([185.154.235.147]:38812 "EHLO
        mx-ginzinger.sigmacloud.services" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726590AbfAGIvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 03:51:06 -0500
Received: from [31.193.165.228] (port=35348 helo=mx-ginzinger.sigmacloud.services)
        by mx-ginzinger.sigmacloud.services with esmtps (TLSv1.2:AES256-GCM-SHA384:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <Manfred.Schlaegl@ginzinger.com>)
        id 1ggQcd-0004AV-21; Mon, 07 Jan 2019 09:50:59 +0100
Received: from [10.10.1.106] (10.10.1.106) by exc1.buero.ginzinger.com
 (10.1.1.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Mon, 7 Jan 2019
 09:50:59 +0100
X-CTCH-RefID: str=0001.0A0B0202.5C3312F3.0077:SCFSTAT16437741,ss=1,re=-4.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Subject: Re: [PATCH] Revert "can: dev: __can_get_echo_skb(): print error message, if trying to echo non existing skb"
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>,
        "David S. Miller" <davem@davemloft.net>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <eaac34af-7058-e434-7d39-7cb221e5ea88@ginzinger.com>
 <976e38b6-072e-a88b-b51d-e85a37fc71ea@pengutronix.de>
From:   Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
Message-ID: <73bd9bcf-f78c-97c0-0c36-105dc0fa16c6@ginzinger.com>
Date:   Mon, 7 Jan 2019 09:50:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
In-Reply-To: <976e38b6-072e-a88b-b51d-e85a37fc71ea@pengutronix.de>
X-Originating-IP: [10.10.1.106]
X-ClientProxiedBy: exc1.buero.ginzinger.com (10.1.1.204) To
 exc1.buero.ginzinger.com (10.1.1.204)
X-EXCLAIMER-MD-CONFIG: 9dd172f7-de2e-4231-b886-ec11f46e03b3
X-EXCLAIMER-MD-BIFURCATION-INSTANCE: 0
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha-256"; boundary="----B2AAC6C5620D57ED7095C916097B03E9"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an S/MIME signed message

------B2AAC6C5620D57ED7095C916097B03E9
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: de-AT
Content-Transfer-Encoding: quoted-printable

=EF=BB=BF

Manfred=C2=A0Schlaegl=C2=A0|=C2=A0Leitung Entwicklung Linz=C2=A0

GINZINGER ELECTRONIC SYSTEMS GMBH

Tel.: +43 7723 5422 153
Mobil: +43 676 841 208 253
Mail: manfred.schlaegl@ginzinger.com
Web: www.ginzinger.com




On 04.01.19 16:23, Marc Kleine-Budde wrote:
> On 12/19/18 7:39 PM, Manfred Schlaegl wrote:
>> This reverts commit 7da11ba5c5066dadc2e96835a6233d56d7b7764a.
>>
>> After introduction of this change we encountered following new error
>> message on various i.MX plattforms (flexcan)
>> flexcan 53fc8000.can can0: __can_get_echo_skb: BUG! Trying to echo non
>> existing skb: can_priv::echo_skb[0]
>=20
> Doh! I should have tested more extensive. Sorry.
>=20
>> The introduction of the message was a mistake because
>> priv->echo_skb[idx] =3D NULL is a perfectly valid in following case:
>> If CAN_RAW_LOOPBACK is disabled (setsockopt) in applications, the
>> pkt_type of the tx skb's given to can_put_echo_skb is set to
>> PACKET_LOOPBACK. In this case can_put_echo_skb will not set
>> priv->echo_skb[idx]. It is therefore kept NULL.
>>
>> (As additional argument for revert: The order of check and usage of idx
>> was changed. idx is used to access an array element before checking it's
>> boundaries)
>>
>> Signed-off-by: Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
>=20
> Applied to linux-can.

Great, thanks!

>=20
> Tnx,
> Marc
>=20




________________________________________

Ginzinger electronic systems GmbH
Gewerbegebiet Pirath 16
4952 Weng im Innkreis
www.ginzinger.com

Firmenbuchnummer: FN 364958d
Firmenbuchgericht: Ried im Innkreis
UID-Nr.: ATU66521089


Diese Nachricht ist vertraulich und darf nicht an andere Personen weitergeg=
eben oder von diesen verwendet werden. Verst=C3=A4ndigen Sie uns, wenn Sie =
irrt=C3=BCmlich eine Mitteilung empfangen haben.

This message is confidential. It may not be disclosed to, or used by, anyon=
e other than the addressee. If you receive this message by mistake, please =
advise the sender.

------B2AAC6C5620D57ED7095C916097B03E9
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIIOGgYJKoZIhvcNAQcCoIIOCzCCDgcCAQExDzANBglghkgBZQMEAgEFADALBgkq
hkiG9w0BBwGgggsfMIIF5jCCA86gAwIBAgIQapvhODv/K2ufAdXZuKdSVjANBgkq
hkiG9w0BAQwFADCBhTELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFu
Y2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExp
bWl0ZWQxKzApBgNVBAMTIkNPTU9ETyBSU0EgQ2VydGlmaWNhdGlvbiBBdXRob3Jp
dHkwHhcNMTMwMTEwMDAwMDAwWhcNMjgwMTA5MjM1OTU5WjCBlzELMAkGA1UEBhMC
R0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9y
ZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENPTU9ETyBS
U0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EwggEi
MA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC+s55XrCh2dUAWxzgDmNPGGHYh
UPMleQtMtaDRfTpYPpynMS6n9jR22YRq2tA9NEjk6vW7rN/5sYFLIP1of3l0NKZ6
fLWfF2VgJ5cijKYy/qlAckY1wgOkUMgzKlWlVJGyK+UlNEQ1/5ErCsHq9x9aU/x1
KwTdF/LCrT03Rl/FwFrf1XTCwa2QZYL55AqLPikFlgqOtzk06kb2qvGlnHJvijjI
03BOrNpo+kZGpcHsgyO1/u1OZTaOo8wvEU17VVeP1cHWse9tGKTDyUGg2hJZjrqc
k39UIm/nKbpDSZ0JsMoIw/JtOOg0JC56VzQgBo7ictReTQE5LFLG3yQK+xS1AgMB
AAGjggE8MIIBODAfBgNVHSMEGDAWgBS7r34CPfqm8TyEjq3uOJjs2TIy1DAdBgNV
HQ4EFgQUgq9sjPjF/pZhfOgfPStxSF7Ei8AwDgYDVR0PAQH/BAQDAgGGMBIGA1Ud
EwEB/wQIMAYBAf8CAQAwEQYDVR0gBAowCDAGBgRVHSAAMEwGA1UdHwRFMEMwQaA/
oD2GO2h0dHA6Ly9jcmwuY29tb2RvY2EuY29tL0NPTU9ET1JTQUNlcnRpZmljYXRp
b25BdXRob3JpdHkuY3JsMHEGCCsGAQUFBwEBBGUwYzA7BggrBgEFBQcwAoYvaHR0
cDovL2NydC5jb21vZG9jYS5jb20vQ09NT0RPUlNBQWRkVHJ1c3RDQS5jcnQwJAYI
KwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmNvbW9kb2NhLmNvbTANBgkqhkiG9w0BAQwF
AAOCAgEAeFyygSg0TzzuX1bOn5dW7I+iaxf28/ZJCAbU2C81zd9A/tNx4+jsQgwR
GiHjZrAYayZrrm78hOx7aEpkfNPQIHGG6Fvq3EzWf/Lvx7/hk6zSPwIal9v5IkDc
ZoFD7f3iT7PdkHJY9B51csvU50rxpEg1OyOT8fk2zvvPBuM4qQNqbGWlnhMpIMwp
WZT89RY0wpJO+2V6eXEGGHsROs3njeP9DqqqAJaBa4wBeKOdGCWn1/Jp2oY6dyNm
NppI4ZNMUH4Tam85S1j6E95u4+1Nuru84OrMIzqvISE2HN/56ebTOWlcrurffade
2022O/tUU1gb4jfWCcyvB8czm12FgX/y/lRjmDbEA08QJNB2729Y+io1IYO3ztve
BdvUCIYZojTq/OCR6MvnzS6X72HP0PRLRTiOSEmIDsS5N5w/8IW1Hva5hEFy6fDA
fd9yI+O+IMMAj1KcL/Zo9jzJ16HO5m60ttl1Enk8MQkz/W3JlHaeI5iKFn4UJu1/
cP2YHXYPiWf2JyBzsLBrGk1II+3yL8aorYew6CQvdVifC3HtwlSam9V1niiCfOBe
2C12TdKGu05LWIA3ZkFcWJGaNXOZ6Ggyh/TqvXG5v7zmEVDNXFnHn9tFpMpOUvxh
csjycBtH0dZ0WrNw6gH+HF8TIhCnH3+zzWuDN0Rk6h9KVkfKehIwggUxMIIEGaAD
AgECAhAVuN6n5eZlkokswwu9CiaWMA0GCSqGSIb3DQEBCwUAMIGXMQswCQYDVQQG
EwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxm
b3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0Q09NT0RP
IFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTAe
Fw0xODA3MTgwMDAwMDBaFw0yMTA3MTcyMzU5NTlaMC8xLTArBgkqhkiG9w0BCQEW
Hm1hbmZyZWQuc2NobGFlZ2xAZ2luemluZ2VyLmNvbTCCASIwDQYJKoZIhvcNAQEB
BQADggEPADCCAQoCggEBANuvwEqX7INJV7N6ebdlXbK6yo1vBpZ5RnCazmItsGzy
DRZdfP8GI8m4+A1iHmwF/s+EzYskMYFKqMWvYd4CwRvhuYxFyybYXAl8HeKLjPSj
PovMab+PYJQxqQJp/cOrcvzoL/tZZ4Z6EnvxiwkrL7gEyiqjEveuJiwiVF3E0xBU
AWIqFoKNuxdMGFJb7Al1K2ub4OEx+LtK/JtC8nHctYRli8usu5HQKQRT2ghNDkVr
octDSlZPnWVzCRF+Vi2PIiHwMmKta/7FtSnOuPSHHn0xyHjLtkX5zhKFR1t2JzOf
YsHOYJXwgkDBZdJkwcwp4/HepI82+5/N76Y7h4lMb/ECAwEAAaOCAd4wggHaMB8G
A1UdIwQYMBaAFIKvbIz4xf6WYXzoHz0rcUhexIvAMB0GA1UdDgQWBBRo6er5dpiB
GN/6nuU4bNJGB0mLXjAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIwADAdBgNV
HSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwRgYDVR0gBD8wPTA7BgwrBgEEAbIx
AQIBAwUwKzApBggrBgEFBQcCARYdaHR0cHM6Ly9zZWN1cmUuY29tb2RvLm5ldC9D
UFMwWgYDVR0fBFMwUTBPoE2gS4ZJaHR0cDovL2NybC5jb21vZG9jYS5jb20vQ09N
T0RPUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNybDCB
iwYIKwYBBQUHAQEEfzB9MFUGCCsGAQUFBzAChklodHRwOi8vY3J0LmNvbW9kb2Nh
LmNvbS9DT01PRE9SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWls
Q0EuY3J0MCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5jb21vZG9jYS5jb20wKQYD
VR0RBCIwIIEebWFuZnJlZC5zY2hsYWVnbEBnaW56aW5nZXIuY29tMA0GCSqGSIb3
DQEBCwUAA4IBAQBF+zubtkZ8iMPKmi2USbYoYZo4RIK4kVmMcQpYlifGCBR1qpHb
kq420yCFp/4UKg+QiXq7WZWOTEMV9IaLLVZv13LrC5oqF7dQPXDF66W8rpxy19wG
Cmdmfj1hhAf/NkrH0Xii7VG99gVP27zIYVZaBWWb2R/UfjB56XziJXuu9nkSpeI8
5+MdoFN9UwAs3MZG2nyxk6yIdKJunD5xTXN/gFjchfK6QKcX9GYgSFbxBKfzvzBa
z51GgSWGi+rDTOy55dI961NAQdogqFVrertXxNAhGkFMHzpk1XRGyRr4wL52C8FS
ffy4+OP7WB9wI8LQwXHsj3wiYh+EjCfsXAogMYICvzCCArsCAQEwgawwgZcxCzAJ
BgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcT
B1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMT0wOwYDVQQDEzRD
T01PRE8gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWls
IENBAhAVuN6n5eZlkokswwu9CiaWMA0GCWCGSAFlAwQCAQUAoIHkMBgGCSqGSIb3
DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE5MDEwNzA4NTEwMlow
LwYJKoZIhvcNAQkEMSIEIBM8kDmkbNBfjochVx8VLRdQtdfiiPOnQu/TvwzqJq1P
MHkGCSqGSIb3DQEJDzFsMGowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMC
AgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMA0GCSqGSIb3DQEBAQUABIIBAHWW
kJoBradOvZv45pVp1eRwjpkeD6nNTBW0ioHpNrzZx/sGBxfqHZsuaGVyIPWHOPfx
6o6oKgLW/gYM4IPd3FYvPbXjcz0waD9qJSxPo3v9ERYija9FngXA0DHpoDnCVFgh
X5q0Wn0xe0sYwp0z3iDM2pgkXRO0mqMEy1kIDqYiCa68P/+Wyemyj1+vgDGJTYnU
q7J6uClS5OOs31740aJ3ajHibrhUV8FNh0Emf1o2ZGJJO4Z2U8VtfN2ZiPVxvWVY
ZQJ17FXkzHPmkDPxhmYS9iM7k9iLTmOOCKyHPzC5vK4YjvxIXltynTXm0htjOwpe
5sVH3ym3I6WlJuUpIPY=

------B2AAC6C5620D57ED7095C916097B03E9--

