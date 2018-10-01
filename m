Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201F2C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 21:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C01F20666
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 21:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fortanix.onmicrosoft.com header.i=@fortanix.onmicrosoft.com header.b="gFDMKxrG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C01F20666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fortanix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbeJBEYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 00:24:46 -0400
Received: from mail-co1nam03on0115.outbound.protection.outlook.com ([104.47.40.115]:20256
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726027AbeJBEYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 00:24:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fortanix.onmicrosoft.com; s=selector1-fortanix-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PNqjmW4HpliytZhAhMEZ7z/d27pzJHFYTMZVgkFHRuY=;
 b=gFDMKxrGV1Y3jqgHRkLnl6DAX5LeVdTCIrO0AYqhfSRe4+6f6aQCCE5U8eQX3bvEnSOGEHT/ZHpQBESety2R823fnDXeG6uTDZTeeT2SWqUDrnwTem4EG27+HnrxZp6wXzOL4Wo6H9o9iDWP4COv8WAjFRwN0TtJqc/2B3jbiuU=
Received: from SN6PR11MB3167.namprd11.prod.outlook.com (52.135.109.144) by
 SN6PR11MB2943.namprd11.prod.outlook.com (52.135.124.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.25; Mon, 1 Oct 2018 21:42:48 +0000
Received: from SN6PR11MB3167.namprd11.prod.outlook.com
 ([fe80::78d2:bba5:7e78:3ef6]) by SN6PR11MB3167.namprd11.prod.outlook.com
 ([fe80::78d2:bba5:7e78:3ef6%2]) with mapi id 15.20.1185.024; Mon, 1 Oct 2018
 21:42:48 +0000
From:   Jethro Beekman <jethro@fortanix.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>
CC:     Andy Lutomirski <luto@amacapital.net>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Andrew Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        "nhorman@redhat.com" <nhorman@redhat.com>,
        "npmccallum@redhat.com" <npmccallum@redhat.com>,
        "Ayoun, Serge" <serge.ayoun@intel.com>,
        "shay.katz-zamir@intel.com" <shay.katz-zamir@intel.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v14 09/19] x86/mm: x86/sgx: Signal SEGV_SGXERR for #PFs w/
 PF_SGX
Thread-Topic: [PATCH v14 09/19] x86/mm: x86/sgx: Signal SEGV_SGXERR for #PFs
 w/ PF_SGX
Thread-Index: AQHUWc+y8zusVL/kHkSM4W4SDz7psw==
Date:   Mon, 1 Oct 2018 21:42:48 +0000
Message-ID: <ae76dfe7-3587-0d21-37b7-535279edc235@fortanix.com>
References: <20180925130845.9962-1-jarkko.sakkinen@linux.intel.com>
 <20180925130845.9962-10-jarkko.sakkinen@linux.intel.com>
 <CALCETrVAhiwv+g5fzVO3ZSHZgcQKbeeG8r3HUcXO9k7Gi94NdQ@mail.gmail.com>
 <20180926173516.GA10920@linux.intel.com>
 <2D60780F-ADB4-48A4-AB74-15683493D369@amacapital.net>
 <9835e288-ba98-2f9e-ac73-504db9512bb9@intel.com>
 <20180926204400.GA11446@linux.intel.com>
 <b7e14c6e-fc05-93fa-eef9-5e3f06ab4729@intel.com>
 <CALCETrXByb2UVuZ6AXUeOd8y90NAikbZuvdN3wf_TjHZ+CxNhA@mail.gmail.com>
 <992b1d6d-cc0f-776f-d938-2a1f7cad52c8@intel.com>
 <20180927135603.GF8242@linux.intel.com>
In-Reply-To: <20180927135603.GF8242@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR2001CA0039.namprd20.prod.outlook.com
 (2603:10b6:405:16::25) To SN6PR11MB3167.namprd11.prod.outlook.com
 (2603:10b6:805:c4::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jethro@fortanix.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.107.146]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR11MB2943;6:DMZNah0hwOpZJ2y52v1RhgO+n4OkK5bMOuC27RnlpAA09XSRz2uE0hrcU2pPBQ/yn1eI+x9YtnKqxtOvfyW6uujjDYsMdRg2Sz+kmKrS9Dz2QoS4Hx32TQzBUAkF6TMNXpI4QdTaxwHpCfzF37wTaWVcMNEbD0xBFrjMYBuVaNXkI/OslpHu7UcH3v4f7HkFAG5rnRb12On2hgpxqm/ul/rM0i5LwoFg9nb14E7OlDxqVtBM+FMwwHqYJEswKfTxA8dwCfCI46RLEyRgpn0F6rJieX3FJFAorlHfewiYe/HNmzRX+D3M656w5PDYB1+/CrMf5jK22alNFG29aqrl49HuZ5jaAQ0xS+wiaFIIOCgz0bweQaRmsaIMY5/GUZAncSyN2fJgycs4b0yjDxpxufSv5345k3vM2hjsxRW7bwbf+LG9JEbQEN+NttGt2dSVhViidmnseiGYuVIqHvj6OQ==;5:xathiuch/kkeSMBcWbY4m05oGLm+cXM4LHHlt06Ep7zfpvs4ivIK7p2cSoZ9lSxD/G4VdV7Pe/Tysh7pSnZOIRjHqQZmHhK8hVPHT7Ti758ZnPa57WfqcoTsxq7eozX1bYQ6mBS4GVLMw5wKdPqZwK6NyJBtLlnQzjtK8tNdi84=;7:lHbGSpI+iWGcIeKlOFg8DnHfBfXZnA4hPRRvhy0bgPvvKDi6fJ8z4mhnmKj/7OyJpVNZgaT7qlvvrlSwfy1sWtk4hkQzffO4TMp/dQ6B32ndIH8Rz4nghRVCPsXI1KGBC1kedIIhG0jAJx3zIfmexOscrhfZ13XkyMsu9WKXL0Kw8h0JzwvpJVcNb7+5S/5j14yCUGKq9YImhvSG0qqnpDJZWriefZpyUxXZRf9maQOqKU87uX22t1x/h3zhm9tc
x-ms-office365-filtering-correlation-id: 8fe584b6-8a2b-4ca0-ba08-08d627e6d49f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989299)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(49563074)(7193020);SRVR:SN6PR11MB2943;
x-ms-traffictypediagnostic: SN6PR11MB2943:
x-microsoft-antispam-prvs: <SN6PR11MB294309F32C2B3F489EDFB100AAEF0@SN6PR11MB2943.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(102415395)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(4983020)(52105095)(149066)(150057)(6041310)(20161123560045)(20161123558120)(2016111802025)(20161123564045)(20161123562045)(6043046)(201708071742011)(7699051);SRVR:SN6PR11MB2943;BCL:0;PCL:0;RULEID:;SRVR:SN6PR11MB2943;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39830400003)(376002)(366004)(136003)(346002)(199004)(189003)(106356001)(68736007)(31696002)(6506007)(446003)(52116002)(386003)(11346002)(86362001)(76176011)(508600001)(6512007)(2616005)(31686004)(486006)(105586002)(8936002)(81156014)(6486002)(81166006)(476003)(6116002)(53936002)(5660300001)(3846002)(99936001)(6436002)(26005)(36756003)(256004)(305945005)(7736002)(6246003)(99286004)(71200400001)(97736004)(71190400001)(2906002)(66066001)(93886005)(2900100001)(8676002)(186003)(229853002)(5250100002)(102836004)(14454004)(316002)(53546011)(110136005)(7416002)(4326008)(54906003)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR11MB2943;H:SN6PR11MB3167.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fortanix.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: AYuwUm11mvxVUBrTXWvlAQFf7K+zVJNOnFnNfCfzjMwi0fj/mbBhhP6TufuZs8ZIIPGVpvC0ZHuhQkFhUBl1M+b92XZuZ6Ga4rFnf1YCH2rBovx+uaXA6RBshqCw6RJJef8wqdn5otZcoC+Yk87aPsBbJ17M4svr1DSHYtVaGVQE4xv6KgjOM+pEr7Dam/1UWMT9uqSWdC11Ps9Tst4vm+lh4mdN967uAfyvDx9DfSk4C5YgABAO5GUKobgUglBFqLYp2Jl/vqMGIG7TYsO0RYVvI3yZMuo9T3tio92LecWa/DTkqLoJ8H4JCXqPP7tehrkdaR7WohSWI+Vf4QuZfFiA3VguFnqjHBPfMYcERYE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms030003080308000300010403"
MIME-Version: 1.0
X-OriginatorOrg: fortanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fe584b6-8a2b-4ca0-ba08-08d627e6d49f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 21:42:48.8015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: de7becae-4883-43e8-82c7-7dbdbb988ae6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2943
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------ms030003080308000300010403
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2018-09-27 06:56, Jarkko Sakkinen wrote:
> On Wed, Sep 26, 2018 at 02:45:17PM -0700, Dave Hansen wrote:
>> On 09/26/2018 02:15 PM, Andy Lutomirski wrote:
>>> Could we perhaps have a little vDSO entry (or syscall, I suppose) tha=
t
>>> runs an enclave an returns an error code, and rig up the #PF handler
>>> to check if the error happened in the vDSO entry and fix it up rather=

>>> than sending a signal?
>=20
> For me this plan sounds simple and sound.

I support avoiding the need for a signal handler for various=20
SGX-specific operations. Looking forward to v15.

I have some thoughts regarding the design of the vDSO function. Please=20
consider the following as you work on the next patch set.

1) Even though the vDSO function exists, userspace may still call=20
`ENCLU[EENTER]` manually, so the fault handling as described in the=20
current patch should also be maintained.

2) All the information that would normally be provided through the=20
signal handler (x86 fault number, reason) should be provided to userspace=
=2E

3) vDSO functions should be provided for all standard non-enclave ENCLU=20
leafs, and should support most ways that an application might want to=20
use. This includes:

* EENTER with a automatic AEX handler (as in Jarkko's sgx_get_token examp=
le)
* EENTER & ERESUME with a user-specified AEX handler, or possibly just a =

special return value from the ENCLU function on AEX

4) I think the vDSO functions should have a special calling convention=20
(not conforming to the standard SysV ABI), such that most registers are=20
passed between user space and enclave space untouched. Basically, only=20
RAX, RBX, RCX are available as input and output registers.

--
Jethro Beekman | Fortanix


--------------ms030003080308000300010403
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
Cx8wggUxMIIEGaADAgECAhBdZC9mIseKJlmxx1xn+g00MA0GCSqGSIb3DQEBCwUAMIGXMQsw
CQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxm
b3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0Q09NT0RPIFJTQSBD
bGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTAeFw0xODA5MTUwMDAw
MDBaFw0xOTA5MTUyMzU5NTlaMCQxIjAgBgkqhkiG9w0BCQEWE2pldGhyb0Bmb3J0YW5peC5j
b20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDRQDOQsroKjy2xAQCXLyqryJt4
Xwj8hcweJCzOnjILKHIoWlOQ0b9yIbFLIWBRt/9zdxlE5ZabDVHnkIyhcVgtU/BA73e78Wx2
LOObdg0wfs9U2CVRYhz2EPHFjGvkYKihItt69ye91hj1w7RKCrYC8KZGSZ/+sbkJzQdXVy32
lxmiNEt17GNRebpkJCaFnznd6C2a8tBAS2Fa/UNyFdEs4eoRoYSKswclRhbe81aVhqY2hjcd
O6puyyaYp5hkmau2UPih6OpRSOhbe6Tuebceg1yvumoVX3OZtGPS1VdQ+p0bxB0RE6gNs140
ZKUhrvAJDETuGaaQD4A2/6ksLunjAgMBAAGjggHpMIIB5TAfBgNVHSMEGDAWgBSCr2yM+MX+
lmF86B89K3FIXsSLwDAdBgNVHQ4EFgQUsFUcmGtaJBU7/52LyTYHC/M+LscwDgYDVR0PAQH/
BAQDAgWgMAwGA1UdEwEB/wQCMAAwIAYDVR0lBBkwFwYIKwYBBQUHAwQGCysGAQQBsjEBAwUC
MBEGCWCGSAGG+EIBAQQEAwIFIDBGBgNVHSAEPzA9MDsGDCsGAQQBsjEBAgEBATArMCkGCCsG
AQUFBwIBFh1odHRwczovL3NlY3VyZS5jb21vZG8ubmV0L0NQUzBaBgNVHR8EUzBRME+gTaBL
hklodHRwOi8vY3JsLmNvbW9kb2NhLmNvbS9DT01PRE9SU0FDbGllbnRBdXRoZW50aWNhdGlv
bmFuZFNlY3VyZUVtYWlsQ0EuY3JsMIGLBggrBgEFBQcBAQR/MH0wVQYIKwYBBQUHMAKGSWh0
dHA6Ly9jcnQuY29tb2RvY2EuY29tL0NPTU9ET1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5k
U2VjdXJlRW1haWxDQS5jcnQwJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmNvbW9kb2NhLmNv
bTAeBgNVHREEFzAVgRNqZXRocm9AZm9ydGFuaXguY29tMA0GCSqGSIb3DQEBCwUAA4IBAQB6
v3tFEUSGv9+yY4wUjvcMyz3126nJrX5LkfEvrnCEpEiImECuoYvxOYNLYYynell7BQGtTaZg
shMfDvwpy2isoi3w1AWAfbn6npnSKLzu0BMRvcCPWY8VPmePPizTqXoPkLwgTJfSaWkxMP1u
rfL9S5NeRdkjwjHklX5IWuwwDu1hsKVZrxSSY2unCtvq67UHWz+z6rG1JQrP2YDfb98xun3y
eLBNe/LFBNnGISbkT5q6D+e5c0bgzoH9nH4bsw3t8aDqJTfT3BqQdWr4pF05ODzzeOmEqeYE
qGlD9hIL2AbmTZLjunAnARr6Fv7Sfqt23ptsGkmoZ9ZQNjT3TlwvMIIF5jCCA86gAwIBAgIQ
apvhODv/K2ufAdXZuKdSVjANBgkqhkiG9w0BAQwFADCBhTELMAkGA1UEBhMCR0IxGzAZBgNV
BAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09N
T0RPIENBIExpbWl0ZWQxKzApBgNVBAMTIkNPTU9ETyBSU0EgQ2VydGlmaWNhdGlvbiBBdXRo
b3JpdHkwHhcNMTMwMTEwMDAwMDAwWhcNMjgwMTA5MjM1OTU5WjCBlzELMAkGA1UEBhMCR0Ix
GzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UE
ChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhl
bnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAw
ggEKAoIBAQC+s55XrCh2dUAWxzgDmNPGGHYhUPMleQtMtaDRfTpYPpynMS6n9jR22YRq2tA9
NEjk6vW7rN/5sYFLIP1of3l0NKZ6fLWfF2VgJ5cijKYy/qlAckY1wgOkUMgzKlWlVJGyK+Ul
NEQ1/5ErCsHq9x9aU/x1KwTdF/LCrT03Rl/FwFrf1XTCwa2QZYL55AqLPikFlgqOtzk06kb2
qvGlnHJvijjI03BOrNpo+kZGpcHsgyO1/u1OZTaOo8wvEU17VVeP1cHWse9tGKTDyUGg2hJZ
jrqck39UIm/nKbpDSZ0JsMoIw/JtOOg0JC56VzQgBo7ictReTQE5LFLG3yQK+xS1AgMBAAGj
ggE8MIIBODAfBgNVHSMEGDAWgBS7r34CPfqm8TyEjq3uOJjs2TIy1DAdBgNVHQ4EFgQUgq9s
jPjF/pZhfOgfPStxSF7Ei8AwDgYDVR0PAQH/BAQDAgGGMBIGA1UdEwEB/wQIMAYBAf8CAQAw
EQYDVR0gBAowCDAGBgRVHSAAMEwGA1UdHwRFMEMwQaA/oD2GO2h0dHA6Ly9jcmwuY29tb2Rv
Y2EuY29tL0NPTU9ET1JTQUNlcnRpZmljYXRpb25BdXRob3JpdHkuY3JsMHEGCCsGAQUFBwEB
BGUwYzA7BggrBgEFBQcwAoYvaHR0cDovL2NydC5jb21vZG9jYS5jb20vQ09NT0RPUlNBQWRk
VHJ1c3RDQS5jcnQwJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmNvbW9kb2NhLmNvbTANBgkq
hkiG9w0BAQwFAAOCAgEAeFyygSg0TzzuX1bOn5dW7I+iaxf28/ZJCAbU2C81zd9A/tNx4+js
QgwRGiHjZrAYayZrrm78hOx7aEpkfNPQIHGG6Fvq3EzWf/Lvx7/hk6zSPwIal9v5IkDcZoFD
7f3iT7PdkHJY9B51csvU50rxpEg1OyOT8fk2zvvPBuM4qQNqbGWlnhMpIMwpWZT89RY0wpJO
+2V6eXEGGHsROs3njeP9DqqqAJaBa4wBeKOdGCWn1/Jp2oY6dyNmNppI4ZNMUH4Tam85S1j6
E95u4+1Nuru84OrMIzqvISE2HN/56ebTOWlcrurffade2022O/tUU1gb4jfWCcyvB8czm12F
gX/y/lRjmDbEA08QJNB2729Y+io1IYO3ztveBdvUCIYZojTq/OCR6MvnzS6X72HP0PRLRTiO
SEmIDsS5N5w/8IW1Hva5hEFy6fDAfd9yI+O+IMMAj1KcL/Zo9jzJ16HO5m60ttl1Enk8MQkz
/W3JlHaeI5iKFn4UJu1/cP2YHXYPiWf2JyBzsLBrGk1II+3yL8aorYew6CQvdVifC3HtwlSa
m9V1niiCfOBe2C12TdKGu05LWIA3ZkFcWJGaNXOZ6Ggyh/TqvXG5v7zmEVDNXFnHn9tFpMpO
UvxhcsjycBtH0dZ0WrNw6gH+HF8TIhCnH3+zzWuDN0Rk6h9KVkfKehIxggQ1MIIEMQIBATCB
rDCBlzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UE
BxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENPTU9E
TyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0ECEF1kL2Yi
x4omWbHHXGf6DTQwDQYJYIZIAWUDBAIBBQCgggJZMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0B
BwEwHAYJKoZIhvcNAQkFMQ8XDTE4MTAwMTIxNDI0MlowLwYJKoZIhvcNAQkEMSIEIGBp0jV0
eOgukdbTmNIVZPkUDcUslfcfFi+9DaTHQ58mMGwGCSqGSIb3DQEJDzFfMF0wCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcN
AwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwgb0GCSsGAQQBgjcQBDGBrzCBrDCBlzEL
MAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2Fs
Zm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENPTU9ETyBSU0Eg
Q2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0ECEF1kL2Yix4omWbHH
XGf6DTQwgb8GCyqGSIb3DQEJEAILMYGvoIGsMIGXMQswCQYDVQQGEwJHQjEbMBkGA1UECBMS
R3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYDVQQKExFDT01PRE8g
Q0EgTGltaXRlZDE9MDsGA1UEAxM0Q09NT0RPIFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24g
YW5kIFNlY3VyZSBFbWFpbCBDQQIQXWQvZiLHiiZZscdcZ/oNNDANBgkqhkiG9w0BAQEFAASC
AQBb6fLSkezQdtdLyn1lkJEPUQUFhazrNYTkht0UAEBTl8y4TaYYKUjf5Ac72Uvv09wsXfkZ
nWnNZlSLM1hxcntpFGm6t19IFz5NgUeh4h+e0nEECI0gJye3d2GMN9exoBlO0Euoj7UYRTc9
ypDUC+sBF++PlI58oidTllhk76BWbk2KQIh35qSo0aSqWryk/9qUYlomJeroZ8i8bmzQBYi8
5gA1Gv768UCSy2jCA0etiqjhC93kMrWJMUsniFZuMXhWNuFtmRr3MlZw9tR1/jPsXQa/zjq5
SdY2WfpnZRsimqgJdAh2im/KDSb1NOJOL8HvqU7AL9MAMivSmMrYNBomAAAAAAAA

--------------ms030003080308000300010403--
