Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3180BC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFD11218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732067AbfAaKOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 05:14:39 -0500
Received: from mx-ginzinger.sigmacloud.services ([185.154.235.147]:54069 "EHLO
        mx-ginzinger.sigmacloud.services" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729635AbfAaKOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 05:14:38 -0500
Received: from [31.193.165.228] (port=32328 helo=mx-ginzinger.sigmacloud.services)
        by mx-ginzinger.sigmacloud.services with esmtps (TLSv1.2:AES256-GCM-SHA384:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <Martin.Kepplinger@ginzinger.com>)
        id 1gp9Me-00017h-0h; Thu, 31 Jan 2019 11:14:32 +0100
Received: from martin-laptop.buero.ginzinger.com (10.10.1.120) by
 exc1.buero.ginzinger.com (10.1.1.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1466.3; Thu, 31 Jan 2019 11:14:31 +0100
X-CTCH-RefID: str=0001.0A0B0213.5C52CA88.002F,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
From:   Martin Kepplinger <martin.kepplinger@ginzinger.com>
To:     <corbet@lwn.net>, <davem@davemloft.net>, <kuznet@ms2.inr.ac.ru>,
        <yoshfuji@linux-ipv6.org>, <linux-doc@vger.kernel.org>,
        <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <manfred.schlaegl@ginzinger.com>
Subject: [PATCH v2] ipconfig: add carrier_timeout kernel parameter
Date:   Thu, 31 Jan 2019 11:14:18 +0100
Message-ID: <20190131101419.3988-1-martin.kepplinger@ginzinger.com>
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [10.10.1.120]
X-ClientProxiedBy: exc1.buero.ginzinger.com (10.1.1.204) To
 exc1.buero.ginzinger.com (10.1.1.204)
X-EXCLAIMER-MD-ORIGINAL-SUBJECT: [NOSIG][NODISC][PATCH v2] ipconfig: add
 carrier_timeout kernel parameter
X-EXCLAIMER-MD-CONFIG: 9dd172f7-de2e-4231-b886-ec11f46e03b3
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha-256"; boundary="----A44007675ADC1AFB88D1CD3652032DF2"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an S/MIME signed message

------A44007675ADC1AFB88D1CD3652032DF2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

commit 3fb72f1e6e61 ("ipconfig wait for carrier") added a
"wait for carrier" policy, with a fixed worst case maximum wait
of two minutes.

Now make the wait for carrier timeout configurable on the kernel
commandline and use the 120s as the default.

The timeout messages introduced with
commit 5e404cd65860 ("ipconfig: add informative timeout messages while
waiting for carrier") are done in a fixed interval of 20 seconds, just
like they were before (240/12).

Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
---

so the "carrier_timeout" name really is a first suggestion and
feels a bit too generic, but from reading other parameters I took
that for now.

thanks
                            martin



revision history
----------------
v2: create a kernel parameter instead
v1: initial idea using kconfig


 .../admin-guide/kernel-parameters.txt         |  5 ++++
 net/ipv4/ipconfig.c                           | 27 +++++++++++++++----
 2 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 17ce83cc48f4..45743ed3e7b6 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -461,6 +461,11 @@
 			possible to determine what the correct size should be.
 			This option provides an override for these situations.
 
+	carrier_timeout=
+			[NET] Specifies amount of time (in seconds) that
+			the kernel should wait for a network carrier. By default
+			it waits 120 seconds.
+
 	ca_keys=	[KEYS] This parameter identifies a specific key(s) on
 			the system trusted keyring to be used for certificate
 			trust validation.
diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
index b9a9873c25c6..9bcca08efec9 100644
--- a/net/ipv4/ipconfig.c
+++ b/net/ipv4/ipconfig.c
@@ -85,7 +85,6 @@
 
 /* Define the friendly delay before and after opening net devices */
 #define CONF_POST_OPEN		10	/* After opening: 10 msecs */
-#define CONF_CARRIER_TIMEOUT	120000	/* Wait for carrier timeout */
 
 /* Define the timeout for waiting for a DHCP/BOOTP/RARP reply */
 #define CONF_OPEN_RETRIES 	2	/* (Re)open devices twice */
@@ -101,6 +100,9 @@
 #define NONE cpu_to_be32(INADDR_NONE)
 #define ANY cpu_to_be32(INADDR_ANY)
 
+/* Wait for carrier timeout default in seconds */
+static unsigned int carrier_timeout = 120;
+
 /*
  * Public IP configuration
  */
@@ -268,9 +270,9 @@ static int __init ic_open_devs(void)
 
 	/* wait for a carrier on at least one device */
 	start = jiffies;
-	next_msg = start + msecs_to_jiffies(CONF_CARRIER_TIMEOUT/12);
+	next_msg = start + msecs_to_jiffies(20000);
 	while (time_before(jiffies, start +
-			   msecs_to_jiffies(CONF_CARRIER_TIMEOUT))) {
+			   msecs_to_jiffies(carrier_timeout * 1000))) {
 		int wait, elapsed;
 
 		for_each_netdev(&init_net, dev)
@@ -283,9 +285,9 @@ static int __init ic_open_devs(void)
 			continue;
 
 		elapsed = jiffies_to_msecs(jiffies - start);
-		wait = (CONF_CARRIER_TIMEOUT - elapsed + 500)/1000;
+		wait = (carrier_timeout * 1000 - elapsed + 500) / 1000;
 		pr_info("Waiting up to %d more seconds for network.\n", wait);
-		next_msg = jiffies + msecs_to_jiffies(CONF_CARRIER_TIMEOUT/12);
+		next_msg = jiffies + msecs_to_jiffies(20000);
 	}
 have_carrier:
 	rtnl_unlock();
@@ -1780,3 +1782,18 @@ static int __init vendor_class_identifier_setup(char *addrs)
 	return 1;
 }
 __setup("dhcpclass=", vendor_class_identifier_setup);
+
+static int __init set_carrier_timeout(char *str)
+{
+	ssize_t ret;
+
+	if (!str)
+		return 0;
+
+	ret = kstrtouint(str, 0, &carrier_timeout);
+	if (ret)
+		return 0;
+
+	return 1;
+}
+__setup("carrier_timeout=", set_carrier_timeout);
-- 
2.20.1


------A44007675ADC1AFB88D1CD3652032DF2
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
hvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTkwMTMxMTAxNDM0
WjAvBgkqhkiG9w0BCQQxIgQghglsO2C1qY4uJfJRBJWD/Sy/RMRnW9JyvHdMJZEj
QFkweQYJKoZIhvcNAQkPMWwwajALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcN
AwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwDQYJKoZIhvcNAQEBBQAEggEA
3StX65Cw2ThzmMSjbD9VhaEHzckl/8EwTBqsxqqcWAYFmThvOq5olrr2T06LGFiW
17irHI2rHRniZwNKtd3hGUIuOZfobbLnjvm/3wOObFg4StokypHF2RrwmEAJdicD
JnoNzJP4BHVEc8lAqQdVqWZMb9d9Y/WoC3sK8JgCwwb03HQeE8KN9LBZwN78dLu3
n/EftKUEF4m1GtmyYTTjmBYiaVtfuNTnQaXF+YwAFxH4N4W4G69fPc6GP5GTsOJ+
h32wC/rH5LgrLm4AurCU0GR71zxULodViuQxOZTFqF03KkPLwyBwy0vl8jBL60UE
GvJ/EnfTLt7Ok9saxj4qRg==

------A44007675ADC1AFB88D1CD3652032DF2--

