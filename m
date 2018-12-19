Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D94C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D8962070D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729845AbeLSSqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 13:46:03 -0500
Received: from mx-ginzinger.sigmacloud.services ([185.154.235.147]:43762 "EHLO
        mx-ginzinger.sigmacloud.services" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727494AbeLSSqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 13:46:02 -0500
X-Greylist: delayed 345 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Dec 2018 13:46:01 EST
Received: from [31.193.165.228] (port=29147 helo=mx-ginzinger.sigmacloud.services)
        by mx-ginzinger.sigmacloud.services with esmtps (TLSv1.2:AES256-GCM-SHA384:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <Manfred.Schlaegl@ginzinger.com>)
        id 1gZglD-0001fd-2e; Wed, 19 Dec 2018 19:39:59 +0100
Received: from [10.10.1.106] (10.10.1.106) by exc1.buero.ginzinger.com
 (10.1.1.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Wed, 19 Dec
 2018 19:39:59 +0100
X-CTCH-RefID: str=0001.0A0B0212.5C1A907F.006D:SCFSTAT16437741,ss=1,re=-4.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
From:   Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
Subject: [PATCH] Revert "can: dev: __can_get_echo_skb(): print error message, if trying to echo non existing skb"
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Message-ID: <eaac34af-7058-e434-7d39-7cb221e5ea88@ginzinger.com>
Date:   Wed, 19 Dec 2018 19:39:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
X-Originating-IP: [10.10.1.106]
X-ClientProxiedBy: exc1.buero.ginzinger.com (10.1.1.204) To
 exc1.buero.ginzinger.com (10.1.1.204)
X-EXCLAIMER-MD-ORIGINAL-SUBJECT: [PATCH] Revert "can: dev:
 __can_get_echo_skb(): print error message, if trying to echo non existing
 skb"[NOSIG][NODISC]
X-EXCLAIMER-MD-CONFIG: 9dd172f7-de2e-4231-b886-ec11f46e03b3
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha-256"; boundary="----A5E473DAD6402B9E89BD65D5D8686D6A"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an S/MIME signed message

------A5E473DAD6402B9E89BD65D5D8686D6A
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Language: de-AT
Content-Transfer-Encoding: 7bit

This reverts commit 7da11ba5c5066dadc2e96835a6233d56d7b7764a.

After introduction of this change we encountered following new error
message on various i.MX plattforms (flexcan)
flexcan 53fc8000.can can0: __can_get_echo_skb: BUG! Trying to echo non
existing skb: can_priv::echo_skb[0]

The introduction of the message was a mistake because
priv->echo_skb[idx] = NULL is a perfectly valid in following case:
If CAN_RAW_LOOPBACK is disabled (setsockopt) in applications, the
pkt_type of the tx skb's given to can_put_echo_skb is set to
PACKET_LOOPBACK. In this case can_put_echo_skb will not set
priv->echo_skb[idx]. It is therefore kept NULL.

(As additional argument for revert: The order of check and usage of idx
was changed. idx is used to access an array element before checking it's
boundaries)

Signed-off-by: Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
---
 drivers/net/can/dev.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 3b3f88ffab53..c05e4d50d43d 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -480,8 +480,6 @@ EXPORT_SYMBOL_GPL(can_put_echo_skb);
 struct sk_buff *__can_get_echo_skb(struct net_device *dev, unsigned int idx, u8 *len_ptr)
 {
 	struct can_priv *priv = netdev_priv(dev);
-	struct sk_buff *skb = priv->echo_skb[idx];
-	struct canfd_frame *cf;
 
 	if (idx >= priv->echo_skb_max) {
 		netdev_err(dev, "%s: BUG! Trying to access can_priv::echo_skb out of bounds (%u/max %u)\n",
@@ -489,20 +487,21 @@ struct sk_buff *__can_get_echo_skb(struct net_device *dev, unsigned int idx, u8
 		return NULL;
 	}
 
-	if (!skb) {
-		netdev_err(dev, "%s: BUG! Trying to echo non existing skb: can_priv::echo_skb[%u]\n",
-			   __func__, idx);
-		return NULL;
-	}
+	if (priv->echo_skb[idx]) {
+		/* Using "struct canfd_frame::len" for the frame
+		 * length is supported on both CAN and CANFD frames.
+		 */
+		struct sk_buff *skb = priv->echo_skb[idx];
+		struct canfd_frame *cf = (struct canfd_frame *)skb->data;
+		u8 len = cf->len;
 
-	/* Using "struct canfd_frame::len" for the frame
-	 * length is supported on both CAN and CANFD frames.
-	 */
-	cf = (struct canfd_frame *)skb->data;
-	*len_ptr = cf->len;
-	priv->echo_skb[idx] = NULL;
+		*len_ptr = len;
+		priv->echo_skb[idx] = NULL;
 
-	return skb;
+		return skb;
+	}
+
+	return NULL;
 }
 
 /*
-- 
2.11.0


------A5E473DAD6402B9E89BD65D5D8686D6A
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
DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE4MTIxOTE4NDAxM1ow
LwYJKoZIhvcNAQkEMSIEIOsat7AVTUXFRUd6Ee3H6MNHjG3j9zAu1d/RV6OUkG7J
MHkGCSqGSIb3DQEJDzFsMGowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMC
AgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMA0GCSqGSIb3DQEBAQUABIIBANil
w/6CtuXVKDN5j7hrS3eUu+G/IObq1clcNTGo3L19nLHHrDFSjbQggIroeHROxT0d
nWsO69Ty0IFlwJPAqL44A0GsG04Ju2b9hpd4z6CL96Ftiaco4WJZkmF3nLX6Sd06
eEJrBpPmQBh7MLWbwHSb3mnzte5+tZTLftwWVe1PZ+4rSAyX+ZL5xVtJ2UZYL9Ax
tPiKDwP9e9PXn7Bn8JwM5XOoKE24hEhe9pI2zT4wpBWQvmhsgkRvdgwztfsPeIWb
pjxDDHpgl5dAu411ngNMjVOf0VY4vf07swyOkZ0psNjlB+N5/9hp+ij6WdRGYr9K
E9t4L4sRrntlEfNl1Rw=

------A5E473DAD6402B9E89BD65D5D8686D6A--

