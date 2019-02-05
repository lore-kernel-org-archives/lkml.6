Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE5FC282DA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D32217D6
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730044AbfBEPmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 10:42:44 -0500
Received: from mx-ginzinger.sigmacloud.services ([185.154.235.147]:57404 "EHLO
        mx-ginzinger.sigmacloud.services" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729917AbfBEPmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 10:42:31 -0500
Received: from [31.193.165.228] (port=43503 helo=mx-ginzinger.sigmacloud.services)
        by mx-ginzinger.sigmacloud.services with esmtps (TLSv1.2:AES256-GCM-SHA384:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <Martin.Kepplinger@ginzinger.com>)
        id 1gr2re-0001Ex-1x; Tue, 05 Feb 2019 16:42:22 +0100
Received: from [10.10.1.120] (10.10.1.120) by exc1.buero.ginzinger.com
 (10.1.1.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Tue, 5 Feb 2019
 16:42:22 +0100
X-CTCH-RefID: str=0001.0A0B0209.5C59AEDE.0052,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Subject: Re: [PATCH] mtd: rawnand: gpmi: fix MX28 bus master lockup problem
To:     Fabio Estevam <festevam@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Martin Kepplinger <martink@posteo.de>, <bbrezillon@kernel.org>,
        Manfred Schlaegl <manfred.schlaegl@ginzinger.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        <linux-mtd@lists.infradead.org>, Han Xu <han.xu@nxp.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
References: <20190129153700.18717-1-martink@posteo.de>
 <20190205135946.64eda55c@xps13>
 <CAOMZO5Cbhr-Wxu8W-oCKBP9NS3UN92=NUfYdkyYp-yy2oy12SQ@mail.gmail.com>
From:   Martin Kepplinger <martin.kepplinger@ginzinger.com>
Message-ID: <ff0c92b8-f26c-eb86-30bf-ec9f255b8ed5@ginzinger.com>
Date:   Tue, 5 Feb 2019 16:42:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <CAOMZO5Cbhr-Wxu8W-oCKBP9NS3UN92=NUfYdkyYp-yy2oy12SQ@mail.gmail.com>
X-Originating-IP: [10.10.1.120]
X-ClientProxiedBy: exc1.buero.ginzinger.com (10.1.1.204) To
 exc1.buero.ginzinger.com (10.1.1.204)
X-EXCLAIMER-MD-ORIGINAL-SUBJECT: [NODISC][NOSIG]Re: [PATCH] mtd: rawnand:
 gpmi: fix MX28 bus master lockup problem
X-EXCLAIMER-MD-CONFIG: 9dd172f7-de2e-4231-b886-ec11f46e03b3
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha-256"; boundary="----853D10A693A45AC26B1F9C48150E96F5"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an S/MIME signed message

------853D10A693A45AC26B1F9C48150E96F5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit

On 05.02.19 16:22, Fabio Estevam wrote:
> On Tue, Feb 5, 2019 at 11:00 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>>
>> Hi Martin,
>>
>> Martin Kepplinger <martink@posteo.de> wrote on Tue, 29 Jan 2019
>> 16:37:00 +0100:
>>
>>> From: Martin Kepplinger <martin.kepplinger@ginzinger.com>
>>>
>>> Disable BCH soft reset according to MX23 erratum #2847 ("BCH soft
>>> reset may cause bus master lock up") for MX28 too. It has the same
>>> problem.
>>>
>>> Observed problem: once per 100,000+ MX28 reboots NAND read failed on
>>> DMA timeout errors:
>>> [    1.770823] UBI: attaching mtd3 to ubi0
>>> [    2.768088] gpmi_nand: DMA timeout, last DMA :1
>>> [    3.958087] gpmi_nand: BCH timeout, last DMA :1
>>> [    4.156033] gpmi_nand: Error in ECC-based read: -110
>>> [    4.161136] UBI warning: ubi_io_read: error -110 while reading 64
>>> bytes from PEB 0:0, read only 0 bytes, retry
>>> [    4.171283] step 1 error
>>> [    4.173846] gpmi_nand: Chip: 0, Error -1
>>>
>>> Without BCH soft reset we successfully executed 1,000,000 MX28 reboots.
>>>
>>> I have a quote from NXP regarding this problem, from July 18th 2016:
>>>
>>> "As the i.MX23 and i.MX28 are of the same generation, they share many
>>> characteristics. Unfortunately, also the erratas may be shared.
>>> In case of the documented erratas and the workarounds, you can also
>>> apply the workaround solution of one device on the other one. This have
>>> been reported, but I’m afraid that there are not an estimated date for
>>> updating the Errata documents.
>>> Please accept our apologies for any inconveniences this may cause."
>>>
>>> Signed-off-by: Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
>>> Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> 
> Does this also need a Fixes tag so that it can be backported to stable?
> 

Actually I rebased this from our 4.14 stable tree, so yes, I just forgot 
about that and I guess it would be

Fixes: 6f2a6a52560a ("mtd: nand: gpmi: reset BCH earlier, too, to avoid 
NAND startup problems")

Do you want me to add this and CC stable?

thanks
                                   martin

------853D10A693A45AC26B1F9C48150E96F5
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
hvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTkwMjA1MTU0MjI2
WjAvBgkqhkiG9w0BCQQxIgQgb8wklmwi/rzNQ9BA4cSgErkXR3rKUmYveG9RPphu
E+sweQYJKoZIhvcNAQkPMWwwajALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcN
AwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwDQYJKoZIhvcNAQEBBQAEggEA
XcPOyPPlj4iihqYm9eLK7X9ttOf/mpxIRxzBYW6pr/t2MIPNYr0vBAqL5FiDEqwa
5q47h0D1boAdpgsplwPsv+Qz3qB7qLwHBVupGZgrF8LfpIZgFOEfrxf0kiucwoKU
wbId4CjjxE70joQZoOmT8r9IJG+4ArqKk4b7s30Rxq53d1whMfC4/00P4oaxp+Nh
2FEiHOiI6MlYR27vP79GUuU6YdTwnyjsk2UyJjTsU14u4+ybfo1kq8trz0yUKGds
Wqtsow0UHT3lLEgMmtGghKtCpPVDWkmygc7dD2gY/j9ckDsJwFuCqBTG0Q1LT4XJ
kyhO2PzC6w4K+0SMQ0ThJA==

------853D10A693A45AC26B1F9C48150E96F5--

