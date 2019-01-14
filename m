Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CFCC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF7A720659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfANRJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 12:09:41 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:56911 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726643AbfANRJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 12:09:39 -0500
Received: from keineahnung.molgen.mpg.de (keineahnung.molgen.mpg.de [141.14.17.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 48A1D201353427;
        Mon, 14 Jan 2019 18:09:36 +0100 (CET)
Subject: Re: General protection fault in `switch_mm_irqs_off()`
To:     Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jiri Kosina <jikos@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
References: <alpine.LRH.2.00.1901041737290.28043@gjva.wvxbf.pm>
 <cb7ba667-562b-1e4c-f16e-7c11804bc98a@molgen.mpg.de>
 <alpine.DEB.2.21.1901091410500.1755@nanos.tec.linutronix.de>
 <5c38f377-f088-5684-91a5-c2cc2d64dbbd@molgen.mpg.de>
 <ea49acb9-8165-80a3-e6fe-b29123ad5795@amd.com>
 <206f4322-c15e-6f0b-733d-fd19cd9c24a7@molgen.mpg.de>
 <98ed83c0-3077-848b-9de4-add70e9b417a@amd.com>
 <9bca3e26-1dfc-6e86-cf28-90cadd983ff4@molgen.mpg.de>
 <20190109211104.GG15665@zn.tnic>
 <9bbcbaa7-b164-fcef-0588-7c5f25aa2440@molgen.mpg.de>
 <20190110160054.GD17621@zn.tnic>
 <4de0b458-6028-3ab1-fef6-04c7fc440277@molgen.mpg.de>
 <3a35722f-969b-e720-1f3f-c60be7818ed1@amd.com>
 <8d6c854c-cbb9-adbf-345b-f04a40206573@amd.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <e45c8578-37e8-0aee-b235-d4d9bcedc8ee@molgen.mpg.de>
Date:   Mon, 14 Jan 2019 18:09:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <8d6c854c-cbb9-adbf-345b-f04a40206573@amd.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms050107040704030809010506"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms050107040704030809010506
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Dear Thomas,


Thank you for checking this, and coming back with the results so quickly.=


On 01/14/19 18:00, Lendacky, Thomas wrote:
> On 1/10/19 12:34 PM, Lendacky, Thomas wrote:
>> On 1/10/19 10:49 AM, Paul Menzel wrote:
>>> Dear Boris, dear Thomas,
>>>
>>>
>>> On 01/10/19 17:00, Borislav Petkov wrote:
>>>> On Thu, Jan 10, 2019 at 02:57:40PM +0100, Paul Menzel wrote:
>>>>> Thank you very much. Indeed, the machine does not crash. I used Lin=
us=E2=80=99
>>>>> master branch for testing, and applied your patch on top. Please fi=
nd
>>>>> the full log attached.
>>>>
>>>>> 80.649: [    3.197107] Spectre V2 : spectre_v2_user_select_mitigati=
on: set X86_FEATURE_USE_IBPB
>>>>
>>>> This is amazing.
>>>>
>>>> Ok, next diff, same exercise. Thx.>=20
>>>> ---
>>>> diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include=
/asm/nospec-branch.h
>>>> index dad12b767ba0..528ef8336f5f 100644
>>>> --- a/arch/x86/include/asm/nospec-branch.h
>>>> +++ b/arch/x86/include/asm/nospec-branch.h
>>>> @@ -284,6 +284,12 @@ static inline void indirect_branch_prediction_b=
arrier(void)
>>>>  {
>>>>  	u64 val =3D PRED_CMD_IBPB;
>>>> =20
>>>> +	if (WARN_ON(boot_cpu_has(X86_FEATURE_USE_IBPB))) {
>>>> +		pr_info("%s: c: %px, array: 0x%x\n",
>>>> +			__func__, &boot_cpu_data, boot_cpu_data.x86_capability[7]);
>>>> +		return;
>>>> +	}
>>>> +
>>>>  	alternative_msr_write(MSR_IA32_PRED_CMD, val, X86_FEATURE_USE_IBPB=
);
>>>>  }
>>>> =20
>>>> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c=

>>>> index 8654b8b0c848..e818e5abe611 100644
>>>> --- a/arch/x86/kernel/cpu/bugs.c
>>>> +++ b/arch/x86/kernel/cpu/bugs.c
>>>> @@ -371,6 +371,9 @@ spectre_v2_user_select_mitigation(enum spectre_v=
2_mitigation_cmd v2_cmd)
>>>>  	if (boot_cpu_has(X86_FEATURE_IBPB)) {
>>>>  		setup_force_cpu_cap(X86_FEATURE_USE_IBPB);
>>>> =20
>>>> +		pr_err("%s: set X86_FEATURE_USE_IBPB, c: %px, array: 0x%x\n",
>>>> +			__func__, &boot_cpu_data, boot_cpu_data.x86_capability[7]);
>>>> +
>>>>  		switch (cmd) {
>>>>  		case SPECTRE_V2_USER_CMD_FORCE:
>>>>  		case SPECTRE_V2_USER_CMD_PRCTL_IBPB:
>>>> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/comm=
on.c
>>>> index cb28e98a0659..8566737fa500 100644
>>>> --- a/arch/x86/kernel/cpu/common.c
>>>> +++ b/arch/x86/kernel/cpu/common.c
>>>> @@ -765,6 +765,9 @@ static void apply_forced_caps(struct cpuinfo_x86=
 *c)
>>>>  		c->x86_capability[i] &=3D ~cpu_caps_cleared[i];
>>>>  		c->x86_capability[i] |=3D cpu_caps_set[i];
>>>>  	}
>>>> +
>>>> +	if (c =3D=3D &boot_cpu_data)
>>>> +		pr_info("%s: c: %px, array: 0x%x\n", __func__, c, c->x86_capabili=
ty[7]);
>>>>  }
>>>> =20
>>>>  static void init_speculation_control(struct cpuinfo_x86 *c)
>>>> @@ -778,6 +781,10 @@ static void init_speculation_control(struct cpu=
info_x86 *c)
>>>>  	if (cpu_has(c, X86_FEATURE_SPEC_CTRL)) {
>>>>  		set_cpu_cap(c, X86_FEATURE_IBRS);
>>>>  		set_cpu_cap(c, X86_FEATURE_IBPB);
>>>> +
>>>> +		pr_info("%s: X86_FEATURE_SPEC_CTRL: c: %px, array: 0x%x, CPUID: 0=
x%x\n",
>>>> +			__func__, c, c->x86_capability[7], cpuid_edx(7));
>>>> +
>>>>  		set_cpu_cap(c, X86_FEATURE_MSR_SPEC_CTRL);
>>>>  	}
>>>> =20
>>>> @@ -793,9 +800,13 @@ static void init_speculation_control(struct cpu=
info_x86 *c)
>>>>  		set_cpu_cap(c, X86_FEATURE_MSR_SPEC_CTRL);
>>>>  	}
>>>> =20
>>>> -	if (cpu_has(c, X86_FEATURE_AMD_IBPB))
>>>> +	if (cpu_has(c, X86_FEATURE_AMD_IBPB)) {
>>>>  		set_cpu_cap(c, X86_FEATURE_IBPB);
>>>> =20
>>>> +		pr_info("%s: X86_FEATURE_AMD_IBPB: c: %px, array: 0x%x, CPUID: 0x=
%x\n",
>>>> +			__func__, c, c->x86_capability[7], cpuid_ebx(0x80000008));
>>>> +	}
>>>> +
>>>>  	if (cpu_has(c, X86_FEATURE_AMD_STIBP)) {
>>>>  		set_cpu_cap(c, X86_FEATURE_STIBP);
>>>>  		set_cpu_cap(c, X86_FEATURE_MSR_SPEC_CTRL);
>>>
>>> Please find the logs attached.
>>
>> Ah, so the CPUID value is showing X86_FEATURE_AMD_IBPB (not sure why t=
he
>> cpuid command was showing a value of zero for EBX in your previous ema=
il).
>> Let me see what I can find out about this processor/firmware relation.=
 I
>> wouldn't expect to see the #GP given that the firmware says IBPB is
>> supported.
>=20
> I'm not able to reproduce this issue on my family 21, model 1, stepping=
 2
> processor (AMD Opteron(TM) Processor 6274) as I am able to successfully=

> write to the PRED_CMD MSR.

It=E2=80=99s not exactly the same processor, but I guess the same family =
should be
good enough. What board do you have? Do you have two sockets, and both
populated?

Here is an Asus KGPE-D16 with two AMD Opterons put in.

Lastly, my microcode updates are applied in firmware, and not by GNU/Linu=
x.

> Let's check the firmware file that you're loading. The one I'm using is=
:
>=20
> $ sha1sum /lib/firmware/amd-ucode/microcode_amd_fam15h.bin=20
> 90896256951d8edf7baf8181ae11e2dc618a5171  /lib/firmware/amd-ucode/micro=
code_amd_fam15h.bin
>=20
> Does that match what you have?

Yes, that matches exactly.

    90896256951d8edf7baf8181ae11e2dc618a5171  3rdparty/blobs/cpu/amd/fami=
ly_15h/microcode_amd_fam15h.bin


Kind regards,

Paul


--------------ms050107040704030809010506
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
EFowggUSMIID+qADAgECAgkA4wvV+K8l2YEwDQYJKoZIhvcNAQELBQAwgYIxCzAJBgNVBAYT
AkRFMSswKQYDVQQKDCJULVN5c3RlbXMgRW50ZXJwcmlzZSBTZXJ2aWNlcyBHbWJIMR8wHQYD
VQQLDBZULVN5c3RlbXMgVHJ1c3QgQ2VudGVyMSUwIwYDVQQDDBxULVRlbGVTZWMgR2xvYmFs
Um9vdCBDbGFzcyAyMB4XDTE2MDIyMjEzMzgyMloXDTMxMDIyMjIzNTk1OVowgZUxCzAJBgNV
BAYTAkRFMUUwQwYDVQQKEzxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMgRGV1dHNjaGVu
IEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsTB0RGTi1QS0kxLTArBgNVBAMTJERG
Ti1WZXJlaW4gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgMjCCASIwDQYJKoZIhvcNAQEBBQAD
ggEPADCCAQoCggEBAMtg1/9moUHN0vqHl4pzq5lN6mc5WqFggEcVToyVsuXPztNXS43O+FZs
FVV2B+pG/cgDRWM+cNSrVICxI5y+NyipCf8FXRgPxJiZN7Mg9mZ4F4fCnQ7MSjLnFp2uDo0p
eQcAIFTcFV9Kltd4tjTTwXS1nem/wHdN6r1ZB+BaL2w8pQDcNb1lDY9/Mm3yWmpLYgHurDg0
WUU2SQXaeMpqbVvAgWsRzNI8qIv4cRrKO+KA3Ra0Z3qLNupOkSk9s1FcragMvp0049ENF4N1
xDkesJQLEvHVaY4l9Lg9K7/AjsMeO6W/VRCrKq4Xl14zzsjz9AkH4wKGMUZrAcUQDBHHWekC
AwEAAaOCAXQwggFwMA4GA1UdDwEB/wQEAwIBBjAdBgNVHQ4EFgQUk+PYMiba1fFKpZFK4OpL
4qIMz+EwHwYDVR0jBBgwFoAUv1kgNgB5oKAia4zV8mHSuCzLgkowEgYDVR0TAQH/BAgwBgEB
/wIBAjAzBgNVHSAELDAqMA8GDSsGAQQBga0hgiwBAQQwDQYLKwYBBAGBrSGCLB4wCAYGZ4EM
AQICMEwGA1UdHwRFMEMwQaA/oD2GO2h0dHA6Ly9wa2kwMzM2LnRlbGVzZWMuZGUvcmwvVGVs
ZVNlY19HbG9iYWxSb290X0NsYXNzXzIuY3JsMIGGBggrBgEFBQcBAQR6MHgwLAYIKwYBBQUH
MAGGIGh0dHA6Ly9vY3NwMDMzNi50ZWxlc2VjLmRlL29jc3ByMEgGCCsGAQUFBzAChjxodHRw
Oi8vcGtpMDMzNi50ZWxlc2VjLmRlL2NydC9UZWxlU2VjX0dsb2JhbFJvb3RfQ2xhc3NfMi5j
ZXIwDQYJKoZIhvcNAQELBQADggEBAIcL/z4Cm2XIVi3WO5qYi3FP2ropqiH5Ri71sqQPrhE4
eTizDnS6dl2e6BiClmLbTDPo3flq3zK9LExHYFV/53RrtCyD2HlrtrdNUAtmB7Xts5et6u5/
MOaZ/SLick0+hFvu+c+Z6n/XUjkurJgARH5pO7917tALOxrN5fcPImxHhPalR6D90Bo0fa3S
PXez7vTXTf/D6OWST1k+kEcQSrCFWMBvf/iu7QhCnh7U3xQuTY+8npTD5+32GPg8SecmqKc2
2CzeIs2LgtjZeOJVEqM7h0S2EQvVDFKvaYwPBt/QolOLV5h7z/0HJPT8vcP9SpIClxvyt7bP
ZYoaorVyGTkwggWNMIIEdaADAgECAgwcOtRQhH7u81j4jncwDQYJKoZIhvcNAQELBQAwgZUx
CzAJBgNVBAYTAkRFMUUwQwYDVQQKEzxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMgRGV1
dHNjaGVuIEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsTB0RGTi1QS0kxLTArBgNV
BAMTJERGTi1WZXJlaW4gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgMjAeFw0xNjExMDMxNTI0
NDhaFw0zMTAyMjIyMzU5NTlaMGoxCzAJBgNVBAYTAkRFMQ8wDQYDVQQIDAZCYXllcm4xETAP
BgNVBAcMCE11ZW5jaGVuMSAwHgYDVQQKDBdNYXgtUGxhbmNrLUdlc2VsbHNjaGFmdDEVMBMG
A1UEAwwMTVBHIENBIC0gRzAyMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAnhx4
59Lh4WqgOs/Md04XxU2yFtfM15ZuJV0PZP7BmqSJKLLPyqmOrADfNdJ5PIGBto2JBhtRRBHd
G0GROOvTRHjzOga95WOTeura79T21FWwwAwa29OFnD3ZplQs6HgdwQrZWNi1WHNJxn/4mA19
rNEBUc5urSIpZPvZi5XmlF3v3JHOlx3KWV7mUteB4pwEEfGTg4npPAJbp2o7arxQdoIq+Pu2
OsvqhD7Rk4QeaX+EM1QS4lqd1otW4hE70h/ODPy1xffgbZiuotWQLC6nIwa65Qv6byqlIX0q
Zuu99Vsu+r3sWYsL5SBkgecNI7fMJ5tfHrjoxfrKl/ErTAt8GQIDAQABo4ICBTCCAgEwEgYD
VR0TAQH/BAgwBgEB/wIBATAOBgNVHQ8BAf8EBAMCAQYwKQYDVR0gBCIwIDANBgsrBgEEAYGt
IYIsHjAPBg0rBgEEAYGtIYIsAQEEMB0GA1UdDgQWBBTEiKUH7rh7qgwTv9opdGNSG0lwFjAf
BgNVHSMEGDAWgBST49gyJtrV8UqlkUrg6kviogzP4TCBjwYDVR0fBIGHMIGEMECgPqA8hjpo
dHRwOi8vY2RwMS5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1Yi9jcmwvY2Fjcmwu
Y3JsMECgPqA8hjpodHRwOi8vY2RwMi5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1
Yi9jcmwvY2FjcmwuY3JsMIHdBggrBgEFBQcBAQSB0DCBzTAzBggrBgEFBQcwAYYnaHR0cDov
L29jc3AucGNhLmRmbi5kZS9PQ1NQLVNlcnZlci9PQ1NQMEoGCCsGAQUFBzAChj5odHRwOi8v
Y2RwMS5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1Yi9jYWNlcnQvY2FjZXJ0LmNy
dDBKBggrBgEFBQcwAoY+aHR0cDovL2NkcDIucGNhLmRmbi5kZS9nbG9iYWwtcm9vdC1nMi1j
YS9wdWIvY2FjZXJ0L2NhY2VydC5jcnQwDQYJKoZIhvcNAQELBQADggEBABLpeD5FygzqOjj+
/lAOy20UQOGWlx0RMuPcI4nuyFT8SGmK9lD7QCg/HoaJlfU/r78ex+SEide326evlFAoJXIF
jVyzNltDhpMKrPIDuh2N12zyn1EtagqPL6hu4pVRzcBpl/F2HCvtmMx5K4WN1L1fmHWLcSap
dhXLvAZ9RG/B3rqyULLSNN8xHXYXpmtvG0VGJAndZ+lj+BH7uvd3nHWnXEHC2q7iQlDUqg0a
wIqWJgdLlx1Q8Dg/sodv0m+LN0kOzGvVDRCmowBdWGhhusD+duKV66pBl+qhC+4LipariWaM
qK5ppMQROATjYeNRvwI+nDcEXr2vDaKmdbxgDVwwggWvMIIEl6ADAgECAgweKlJIhfynPMVG
/KIwDQYJKoZIhvcNAQELBQAwajELMAkGA1UEBhMCREUxDzANBgNVBAgMBkJheWVybjERMA8G
A1UEBwwITXVlbmNoZW4xIDAeBgNVBAoMF01heC1QbGFuY2stR2VzZWxsc2NoYWZ0MRUwEwYD
VQQDDAxNUEcgQ0EgLSBHMDIwHhcNMTcxMTE0MTEzNDE2WhcNMjAxMTEzMTEzNDE2WjCBizEL
MAkGA1UEBhMCREUxIDAeBgNVBAoMF01heC1QbGFuY2stR2VzZWxsc2NoYWZ0MTQwMgYDVQQL
DCtNYXgtUGxhbmNrLUluc3RpdHV0IGZ1ZXIgbW9sZWt1bGFyZSBHZW5ldGlrMQ4wDAYDVQQL
DAVNUElNRzEUMBIGA1UEAwwLUGF1bCBNZW56ZWwwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAw
ggEKAoIBAQDIh/UR/AX/YQ48VWWDMLTYtXjYJyhRHMc81ZHMMoaoG66lWB9MtKRTnB5lovLZ
enTIUyPsCrMhTqV9CWzDf6v9gOTWVxHEYqrUwK5H1gx4XoK81nfV8oGV4EKuVmmikTXiztGz
peyDmOY8o/EFNWP7YuRkY/lPQJQBeBHYq9AYIgX4StuXu83nusq4MDydygVOeZC15ts0tv3/
6WmibmZd1OZRqxDOkoBbY3Djx6lERohs3IKS6RKiI7e90rCSy9rtidJBOvaQS9wvtOSKPx0a
+2pAgJEVzZFjOAfBcXydXtqXhcpOi2VCyl+7+LnnTz016JJLsCBuWEcB3kP9nJYNAgMBAAGj
ggIxMIICLTAJBgNVHRMEAjAAMA4GA1UdDwEB/wQEAwIF4DAdBgNVHSUEFjAUBggrBgEFBQcD
AgYIKwYBBQUHAwQwHQYDVR0OBBYEFHM0Mc3XjMLlhWpp4JufRELL4A/qMB8GA1UdIwQYMBaA
FMSIpQfuuHuqDBO/2il0Y1IbSXAWMCAGA1UdEQQZMBeBFXBtZW56ZWxAbW9sZ2VuLm1wZy5k
ZTB9BgNVHR8EdjB0MDigNqA0hjJodHRwOi8vY2RwMS5wY2EuZGZuLmRlL21wZy1nMi1jYS9w
dWIvY3JsL2NhY3JsLmNybDA4oDagNIYyaHR0cDovL2NkcDIucGNhLmRmbi5kZS9tcGctZzIt
Y2EvcHViL2NybC9jYWNybC5jcmwwgc0GCCsGAQUFBwEBBIHAMIG9MDMGCCsGAQUFBzABhido
dHRwOi8vb2NzcC5wY2EuZGZuLmRlL09DU1AtU2VydmVyL09DU1AwQgYIKwYBBQUHMAKGNmh0
dHA6Ly9jZHAxLnBjYS5kZm4uZGUvbXBnLWcyLWNhL3B1Yi9jYWNlcnQvY2FjZXJ0LmNydDBC
BggrBgEFBQcwAoY2aHR0cDovL2NkcDIucGNhLmRmbi5kZS9tcGctZzItY2EvcHViL2NhY2Vy
dC9jYWNlcnQuY3J0MEAGA1UdIAQ5MDcwDwYNKwYBBAGBrSGCLAEBBDARBg8rBgEEAYGtIYIs
AQEEAwYwEQYPKwYBBAGBrSGCLAIBBAMGMA0GCSqGSIb3DQEBCwUAA4IBAQCQs6bUDROpFO2F
Qz2FMgrdb39VEo8P3DhmpqkaIMC5ZurGbbAL/tAR6lpe4af682nEOJ7VW86ilsIJgm1j0ueY
aOuL8jrN4X7IF/8KdZnnNnImW3QVni6TCcc+7+ggci9JHtt0IDCj5vPJBpP/dKXLCN4M+exl
GXYpfHgxh8gclJPY1rquhQrihCzHfKB01w9h9tWZDVMtSoy9EUJFhCXw7mYUsvBeJwZesN2B
fndPkrXx6XWDdU3S1LyKgHlLIFtarLFm2Hb5zAUR33h+26cN6ohcGqGEEzgIG8tXS8gztEaj
1s2RyzmKd4SXTkKR3GhkZNVWy+gM68J7jP6zzN+cMYIDmjCCA5YCAQEwejBqMQswCQYDVQQG
EwJERTEPMA0GA1UECAwGQmF5ZXJuMREwDwYDVQQHDAhNdWVuY2hlbjEgMB4GA1UECgwXTWF4
LVBsYW5jay1HZXNlbGxzY2hhZnQxFTATBgNVBAMMDE1QRyBDQSAtIEcwMgIMHipSSIX8pzzF
RvyiMA0GCWCGSAFlAwQCAQUAoIIB8TAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqG
SIb3DQEJBTEPFw0xOTAxMTQxNzA5MzZaMC8GCSqGSIb3DQEJBDEiBCB9esUeXcUSLzv7mrCl
/T3klnXE1KxfSDr6D/ij5HQnLzBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcG
BSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGJBgkrBgEEAYI3EAQxfDB6MGoxCzAJBgNVBAYTAkRF
MQ8wDQYDVQQIDAZCYXllcm4xETAPBgNVBAcMCE11ZW5jaGVuMSAwHgYDVQQKDBdNYXgtUGxh
bmNrLUdlc2VsbHNjaGFmdDEVMBMGA1UEAwwMTVBHIENBIC0gRzAyAgweKlJIhfynPMVG/KIw
gYsGCyqGSIb3DQEJEAILMXygejBqMQswCQYDVQQGEwJERTEPMA0GA1UECAwGQmF5ZXJuMREw
DwYDVQQHDAhNdWVuY2hlbjEgMB4GA1UECgwXTWF4LVBsYW5jay1HZXNlbGxzY2hhZnQxFTAT
BgNVBAMMDE1QRyBDQSAtIEcwMgIMHipSSIX8pzzFRvyiMA0GCSqGSIb3DQEBAQUABIIBACK1
AJB28Qyv2b6rDAOGdDK1S6VgzCkLA3miueCY70M5idi3tpYtJtvWYshiW25IV33Ch9hY2G3C
64vBuq7n1LQy8wodaBMjqbHvyE9r6Tru273bMHe+BIFI+ANNdhcv2MsZUvPW7FYZXJPfSf58
upZUZZWrtUnmCS+p6PbyQ69+m4l41JVGs3K9mzZfCSjlSBA7upkUsUAk5Imc/4GdOrazK4Pl
uRJGAKjaprx0Q9YCur69W+0JK8hB23Ak8h/kVIaazrimi4Y6nDUNWnbCR34W04YrgaJJqK4z
VWoRRcZZlF0TKmcfBOyaCBoC3R4yh9mzc7EADYQxk4d/CZP6LdgAAAAAAAA=
--------------ms050107040704030809010506--
