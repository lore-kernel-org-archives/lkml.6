Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129FCC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D68D320880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfBTP2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:28:19 -0500
Received: from mx-ginzinger.sigmacloud.services ([185.154.235.147]:48210 "EHLO
        mx-ginzinger.sigmacloud.services" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727284AbfBTP2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 10:28:19 -0500
Received: from [31.193.165.228] (port=40473 helo=mx-ginzinger.sigmacloud.services)
        by mx-ginzinger.sigmacloud.services with esmtps (TLSv1.2:AES256-GCM-SHA384:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <Martin.Kepplinger@ginzinger.com>)
        id 1gwTmv-0003bQ-0a; Wed, 20 Feb 2019 16:27:57 +0100
Received: from martin-laptop.buero.ginzinger.com (10.10.1.120) by
 exc1.buero.ginzinger.com (10.1.1.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1466.3; Wed, 20 Feb 2019 16:27:56 +0100
X-CTCH-RefID: str=0001.0A0B020A.5C6D71FD.0021,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
From:   Martin Kepplinger <martin.kepplinger@ginzinger.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <jslaby@suse.com>, <corbet@lwn.net>,
        <richard.genoud@gmail.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/9] serial: omap-serial: add support for rs485 RTS delays in microseconds
Date:   Wed, 20 Feb 2019 16:27:27 +0100
Message-ID: <20190220152731.4051-5-martin.kepplinger@ginzinger.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190220152731.4051-1-martin.kepplinger@ginzinger.com>
References: <20190220152731.4051-1-martin.kepplinger@ginzinger.com>
X-Originating-IP: [10.10.1.120]
X-ClientProxiedBy: exc1.buero.ginzinger.com (10.1.1.204) To
 exc1.buero.ginzinger.com (10.1.1.204)
X-EXCLAIMER-MD-ORIGINAL-SUBJECT: [NOSIG][NODISC][PATCH 5/9] serial:
 omap-serial: add support for rs485 RTS delays in microseconds
X-EXCLAIMER-MD-CONFIG: 9dd172f7-de2e-4231-b886-ec11f46e03b3
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha-256"; boundary="----D0169E5C45AF5223496F140D7C16D638"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an S/MIME signed message

------D0169E5C45AF5223496F140D7C16D638
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Read struct serial_rs485's flag SER_RS485_DELAY_IN_USEC and apply the delay
accordingly.

Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
---
 drivers/tty/serial/omap-serial.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 6420ae581a80..adcd75ce5112 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -310,7 +310,11 @@ static void serial_omap_stop_tx(struct uart_port *port)
 			res = (port->rs485.flags & SER_RS485_RTS_AFTER_SEND) ?
 				1 : 0;
 			if (gpio_get_value(up->rts_gpio) != res) {
-				if (port->rs485.delay_rts_after_send > 0)
+				if (port->rs485.delay_rts_after_send > 0 &&
+				    port->rs485.flags & SER_RS485_DELAY_IN_USEC)
+					udelay(
+					port->rs485.delay_rts_after_send);
+				else if (port->rs485.delay_rts_after_send > 0)
 					mdelay(
 					port->rs485.delay_rts_after_send);
 				gpio_set_value(up->rts_gpio, res);
@@ -420,7 +424,11 @@ static void serial_omap_start_tx(struct uart_port *port)
 		res = (port->rs485.flags & SER_RS485_RTS_ON_SEND) ? 1 : 0;
 		if (gpio_get_value(up->rts_gpio) != res) {
 			gpio_set_value(up->rts_gpio, res);
-			if (port->rs485.delay_rts_before_send > 0)
+			if (port->rs485.delay_rts_before_send > 0 &&
+			    port->rs485.flags & SER_RS485_DELAY_IN_USEC)
+				udelay(port->rs485.delay_rts_before_send);
+			else if (port->rs485.delay_rts_before_send > 0 &&
+				 !(port->rs485.flags & SER_RS485_DELAY_IN_USEC)
 				mdelay(port->rs485.delay_rts_before_send);
 		}
 	}
@@ -1407,8 +1415,17 @@ serial_omap_config_rs485(struct uart_port *port, struct serial_rs485 *rs485)
 	serial_out(up, UART_IER, 0);
 
 	/* Clamp the delays to [0, 100ms] */
-	rs485->delay_rts_before_send = min(rs485->delay_rts_before_send, 100U);
-	rs485->delay_rts_after_send  = min(rs485->delay_rts_after_send, 100U);
+	if (port->rs485.flags & SER_RS485_DELAY_IN_USEC) {
+		rs485->delay_rts_before_send = min(rs485->delay_rts_before_send,
+						   100000U);
+		rs485->delay_rts_after_send  = min(rs485->delay_rts_after_send,
+						   100000U);
+	} else {
+		rs485->delay_rts_before_send = min(rs485->delay_rts_before_send,
+						   100);
+		rs485->delay_rts_after_send  = min(rs485->delay_rts_after_send,
+						   100U);
+	}
 
 	/* store new config */
 	port->rs485 = *rs485;
-- 
2.20.1


------D0169E5C45AF5223496F140D7C16D638
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIIOHAYJKoZIhvcNAQcCoIIODTCCDgkCAQExDzANBglghkgBZQMEAgEFADALBgkq
hkiG9w0BBwGgggshMIIF5jCCA86gAwIBAgIQapvhODv/K2ufAdXZuKdSVjANBgkq
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
csjycBtH0dZ0WrNw6gH+HF8TIhCnH3+zzWuDN0Rk6h9KVkfKehIwggUzMIIEG6AD
AgECAhBNQrEzGzrZ6FVYh1EEYH4+MA0GCSqGSIb3DQEBCwUAMIGXMQswCQYDVQQG
EwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxm
b3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0Q09NT0RP
IFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTAe
Fw0xODA3MTgwMDAwMDBaFw0yMTA3MTcyMzU5NTlaMDAxLjAsBgkqhkiG9w0BCQEW
H21hcnRpbi5rZXBwbGluZ2VyQGdpbnppbmdlci5jb20wggEiMA0GCSqGSIb3DQEB
AQUAA4IBDwAwggEKAoIBAQDsMC77L0D+2D8I8X5ubnBhADLgU+HtlwMTFt/WJIhc
kgbvnawYXWrCIpk8F6BJ0R/iFCykPdG7741EmlcHRKOJfhVxjXhwnoGFqnYmurCt
fvZLR3+mT3FWnVv2RAdrXscXH3BpijqqWabdtTbiTvmcl86Zc6mNlVhYZSbDul/E
voIGZotGcGIWrgZxN+8MQJQHKb0KHyWlPVPkrjvEfOJHKKLFsBNSnNMR95Ijg3Sp
h8/8RG490/zRHflGzUlxDSlLyY9YJGzSdDzcFKoYcc4oaaUY5N3uhRna43TLUIQh
6ybt3DKVz1Pw/ikwYJrOsulJrVr3D8KVHdGxq7HYl7jnAgMBAAGjggHfMIIB2zAf
BgNVHSMEGDAWgBSCr2yM+MX+lmF86B89K3FIXsSLwDAdBgNVHQ4EFgQU/GtSUbHg
14sPDlmo27eQYwtjaS0wDgYDVR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYD
VR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMCMEYGA1UdIAQ/MD0wOwYMKwYBBAGy
MQECAQMFMCswKQYIKwYBBQUHAgEWHWh0dHBzOi8vc2VjdXJlLmNvbW9kby5uZXQv
Q1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9jcmwuY29tb2RvY2EuY29tL0NP
TU9ET1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcmww
gYsGCCsGAQUFBwEBBH8wfTBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5jb21vZG9j
YS5jb20vQ09NT0RPUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFp
bENBLmNydDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuY29tb2RvY2EuY29tMCoG
A1UdEQQjMCGBH21hcnRpbi5rZXBwbGluZ2VyQGdpbnppbmdlci5jb20wDQYJKoZI
hvcNAQELBQADggEBAGEuG01K1tt5i3gUdQkYem/KpbJUYBZd43QwmoTa0TGXUiYq
b+g/TeGG9QQ1yq+73xOr8fu6oT2608C7EiJc6JmjTs485/OZmTqgYkrLfs71F1kB
3Z59WPf5aoR/pnn5vdfkkoO29V1cKPJR4z+iOG2hOlcK/dXrX8i6mnL5DGIe8l5n
udUPvIbUhbMavrDd6kwhs0oCjylwdKGlFkCpKMn3HPflfDeHuV9Z8Nrpeq/7+Pm0
I/fLPkaYlULASJoJCucMYcedY9rmuro9JhV+NuVXaqLIrQPc1vyKFeRuLHh84M6c
1h1DArdGTykXZUwjXnnHtuOtzjIAzkx2Ns43vEsxggK/MIICuwIBATCBrDCBlzEL
MAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UE
BxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMT
NENPTU9ETyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1h
aWwgQ0ECEE1CsTMbOtnoVViHUQRgfj4wDQYJYIZIAWUDBAIBBQCggeQwGAYJKoZI
hvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTkwMjIwMTUyODEy
WjAvBgkqhkiG9w0BCQQxIgQg570FavXu3hMCYzYb4yIQ9IrAWVYZ0NU24SrhpZ2H
GLoweQYJKoZIhvcNAQkPMWwwajALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcN
AwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwDQYJKoZIhvcNAQEBBQAEggEA
2BQNKajiWO1xl/8XCTJUdaTYq4GVrJhYTv9A7qoIXItyAwyD6EH6monaaGQW4e5u
eFFXGPkua0J64gAMPfog9T5gmohW20y4v53jsdQxj6l3YjAi05OGAj+EC0TqcTrQ
pwmqzykpMvMoUy1pbZ9o50V9CNKqcLQUOroHSax6FNXDS6XeLOQH2xJzYB2tjx4O
cqiacYUbFpVJD3aFOqj4PtEqxK6+8iPAvkm/3DuLbanoQ1sUquU5eRev0G0klwxQ
mH9SG8YOXbv4DQC8EogKoimlLouQHU3nh4uugvlGTucdgz4E7dAS/KxmVkuRTAsl
lFqEnKqC7PlVVfPmiJU2UA==

------D0169E5C45AF5223496F140D7C16D638--

