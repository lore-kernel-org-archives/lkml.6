Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933656AbeDXOEB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 10:04:01 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:37819 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933353AbeDXOD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 10:03:56 -0400
Subject: Re: [PATCH] ALSA: hda: Request driver probe from an async task
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <ac50d966-5443-a833-7fcd-d4480a531097@molgen.mpg.de>
 <s5hpo2qru3r.wl-tiwai@suse.de>
 <92d47260-8d68-15f9-02b5-9846f9957106@molgen.mpg.de>
 <s5hlgdertjg.wl-tiwai@suse.de>
 <d1fdbf70-018e-1d35-ae21-a3c8a29e7aa2@molgen.mpg.de>
 <s5hfu3kreb5.wl-tiwai@suse.de>
From: Paul Menzel <pmenzel+alsa-devel@molgen.mpg.de>
Message-ID: <56165337-caed-e8d3-1908-c7894911a645@molgen.mpg.de>
Date: Tue, 24 Apr 2018 16:03:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <s5hfu3kreb5.wl-tiwai@suse.de>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms020704030306010107090501"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms020704030306010107090501
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Dear Takashi,


On 04/24/18 14:15, Takashi Iwai wrote:
> On Tue, 24 Apr 2018 13:59:58 +0200,
> Paul Menzel wrote:

>> On 04/23/18 14:33, Takashi Iwai wrote:
>>> On Mon, 23 Apr 2018 14:30:36 +0200, Paul Menzel wrote:
>>
>>>> On 04/23/18 14:21, Takashi Iwai wrote:
>>>>> On Mon, 23 Apr 2018 14:05:52 +0200, Paul Menzel wrote:
>>>>>>
>>>>>> From: Paul Menzel <pmenzel@molgen.mpg.de>
>>>>>> Date: Sat, 24 Mar 2018 09:28:43 +0100
>>>>>>
>>>>>> On an ASRock E350M1, with Linux 4.17-rc1 according to `initcall_de=
bug`
>>>>>> calling `azx_driver_init` takes sometimes more than a few millisec=
onds,
>>>>>> and up to 200 ms.
>>>>>>
>>>>>> ```
>>>>>> [    2.892598] calling  azx_driver_init+0x0/0xfe4 [snd_hda_intel] =
@ 218
>>>>>> [    2.943002] initcall azx_driver_init+0x0/0xfe4 [snd_hda_intel]
>>>>>> returned 0 after 49195 usecs
>>>>>> ```
>>>>>>
>>>>>> Trying to execute the Linux kernel in less than 500 ms, this is qu=
ite a
>>>>>> hold-up, and therefore request the probe from an async task.
>>>>>>
>>>>>> With this change, the test shows, that the function returns earlie=
r.
>>>>>>
>>>>>> ```
>>>>>> [    3.254800] calling  azx_driver_init+0x0/0xfe4 [snd_hda_intel] =
@ 227
>>>>>> [    3.254887] initcall azx_driver_init+0x0/0xfe4 [snd_hda_intel]
>>>>>> returned 0 after 66 usecs
>>>>>> ```
>>>>>>
>>>>>> The same behavior is visible on a Dell OptiPlex 7010. The longer t=
imes
>>>>>> seem to happen, when the module *e1000e* is probed during the same=
 time.
>>>>>>
>>>>>> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
>>>>>
>>>>> What actually took so long?  Could you analyze further instead of
>>>>> blindly putting the flag?
>>>>
>>>> Well, I am not sure. Could you please give me hints, how to debug th=
is
>>>> further? Is there some debug flag?
>>>
>>> Usually perf would help, but even a simple printk() should suffice to=

>>> see what's going on there :)
>>
>> Please find the messages for a 23 ms run below, and the debug patch
>> attached.
>>
>>> [    2.996238] calling  azx_driver_init+0x0/0xfe4 [snd_hda_intel] @ 2=
14
>>> [    3.009838] calling  rtl8169_pci_driver_init+0x0/0x1000 [r8169] @ =
217
>>> [    3.009904] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
>>> [    3.010721] random: get_random_bytes called from ipv6_regen_rndid+=
0x2c/0x100 with crng_init=3D1
>>> [    3.011283] r8169 0000:03:00.0 eth0: RTL8168e/8111e at 0x(ptrval),=
 bc:5f:f4:c8:d3:98, XID 0c200000 IRQ 26
>>> [    3.011289] r8169 0000:03:00.0 eth0: jumbo features [frames: 9200 =
bytes, tx checksumming: ko]
>>> [    3.013876] initcall rtl8169_pci_driver_init+0x0/0x1000 [r8169] re=
turned 0 after 3917 usecs
>>> [    3.031754] calling  pcspkr_platform_driver_init+0x0/0x1000 [pcspk=
r] @ 221
>>> [    3.031904] input: PC Speaker as /devices/platform/pcspkr/input/in=
put4
>>> [    3.032288] initcall pcspkr_platform_driver_init+0x0/0x1000 [pcspk=
r] returned 0 after 508 usecs
>>> [    3.034795] calling  psmouse_init+0x0/0x7c [psmouse] @ 220
>>> [    3.034903] initcall psmouse_init+0x0/0x7c [psmouse] returned 0 af=
ter 87 usecs
>>> [    3.043051] random: get_random_u32 called from cache_random_seq_cr=
eate+0xa3/0x1f0 with crng_init=3D1
>>> [    3.043154] random: get_random_u32 called from cache_alloc_refill+=
0x5bb/0x13d0 with crng_init=3D1
>>> [    3.043187] random: get_random_u32 called from cache_random_seq_cr=
eate+0xa3/0x1f0 with crng_init=3D1
>>> [    3.043198] random: get_random_u32 called from cache_alloc_refill+=
0x5bb/0x13d0 with crng_init=3D1
>>> [    3.043229] random: get_random_u32 called from cache_random_seq_cr=
eate+0xa3/0x1f0 with crng_init=3D1
>>> [    3.043265] random: get_random_u32 called from cache_alloc_refill+=
0x5bb/0x13d0 with crng_init=3D1
>>> [    3.043429] random: get_random_u32 called from cache_random_seq_cr=
eate+0xa3/0x1f0 with crng_init=3D1
>>> [    3.043479] random: get_random_u32 called from cache_alloc_refill+=
0x5bb/0x13d0 with crng_init=3D1
>>> [    3.043749] random: get_random_bytes called from key_alloc+0x1fc/0=
x5e0 with crng_init=3D1
>>> [    3.043973] random: get_random_u32 called from cache_random_seq_cr=
eate+0xa3/0x1f0 with crng_init=3D1
>>> [    3.045483] random: get_random_u32 called from arch_rnd.part.2+0x1=
8/0x40 with crng_init=3D1
>>> [    3.045501] random: get_random_u32 called from load_elf_binary+0x7=
6a/0x1d20 with crng_init=3D1
>>> [    3.045507] random: get_random_u32 called from arch_align_stack+0x=
45/0x70 with crng_init=3D1
>>> [    3.045528] random: get_random_u32 called from arch_rnd.part.2+0x1=
8/0x40 with crng_init=3D1
>>> [    3.045558] random: get_random_u32 called from cache_alloc_refill+=
0x5bb/0x13d0 with crng_init=3D1
>>> [    3.045771] random: get_random_u32 called from cache_random_seq_cr=
eate+0xa3/0x1f0 with crng_init=3D1
>>> [    3.046127] random: get_random_u32 called from cache_alloc_refill+=
0x5bb/0x13d0 with crng_init=3D1
>>> [    3.046197] calling  pcsp_init+0x0/0x1000 [snd_pcsp] @ 221
>>> [    3.046206] Error: Driver 'pcspkr' is already registered, aborting=
=2E..
>>> [    3.046337] initcall pcsp_init+0x0/0x1000 [snd_pcsp] returned -16 =
after 128 usecs
>>> [    3.046348] random: get_random_u32 called from arch_align_stack+0x=
45/0x70 with crng_init=3D1
>>> [    3.046363] random: get_random_bytes called from load_elf_binary+0=
xaf8/0x1d20 with crng_init=3D1
>>> [    3.046383] random: get_random_u32 called from randomize_page+0x42=
/0x57 with crng_init=3D1
>>> [    3.047312] random: get_random_u32 called from cache_alloc_refill+=
0x5bb/0x13d0 with crng_init=3D1
>>> [    3.048151] random: get_random_u32 called from cache_random_seq_cr=
eate+0xa3/0x1f0 with crng_init=3D1
>>> [    3.048638] random: get_random_u32 called from cache_alloc_refill+=
0x5bb/0x13d0 with crng_init=3D1
>>> [    3.054325] random: get_random_u32 called from copy_process.part.3=
3+0x186/0x2100 with crng_init=3D1
>>> [    3.054371] random: get_random_u32 called from cache_alloc_refill+=
0x5bb/0x13d0 with crng_init=3D1
>>> [    3.067344] usb usb3: New USB device found, idVendor=3D1d6b, idPro=
duct=3D0001, bcdDevice=3D 4.17
>>> [    3.067350] usb usb3: New USB device strings: Mfr=3D3, Product=3D2=
, SerialNumber=3D1
>>> [    3.067353] usb usb3: Product: OHCI PCI host controller
>>> [    3.067356] usb usb3: Manufacturer: Linux 4.17.0-rc2+ ohci_hcd
>>> [    3.067359] usb usb3: SerialNumber: 0000:00:12.0
>>> [    3.067850] random: get_random_u32 called from cache_random_seq_cr=
eate+0xa3/0x1f0 with crng_init=3D1
>>> [    3.067864] hub 3-0:1.0: USB hub found
>>> [    3.067960] hub 3-0:1.0: 5 ports detected
>>> [    3.068141] random: get_random_u32 called from cache_alloc_refill+=
0x5bb/0x13d0 with crng_init=3D1
>>> [    3.068618] 1
>>> [    3.068644] 2
>>> [    3.068953] 3
>>> [    3.068954] 4
>>> [    3.068955] 5
>>> [    3.068959] 6
>>> [    3.068960] 7
>>> [    3.068966] 8
>>> [    3.068967] 9
>>> [    3.069204] 1
>>> [    3.069217] 2
>>> [    3.069565] 3
>>> [    3.069566] 4
>>> [    3.069567] 5
>>> [    3.069568] 6
>>> [    3.069569] 7
>>> [    3.069581] 8
>>> [    3.069583] 9
>>> [    3.069774] random: get_random_u32 called from copy_process.part.3=
3+0x186/0x2100 with crng_init=3D1
>>> [    3.069924] initcall azx_driver_init+0x0/0xfe4 [snd_hda_intel] ret=
urned 0 after 23153 usecs
>>
>> Unfortunately, it looks like the time stamps of the Linux kernel and
>> the initcall_debug time do not match. From the Linux time stamps it
>> should be 73 ms.
>=20
> Indeed.  But even from this result, you can have a rough idea.
> As you can see, the most of time was spent before "1" point, which is
> the very beginning of azx_probe().  That is, the slowness is not in
> HD-audio driver probe itself.  Rather it's likely because of parallel
> probing with other multiple devices.

I agree. But that also makes it clear, that the probe can be done in=20
async task, doesn=E2=80=99t it?


Kind regards,

Paul


--------------ms020704030306010107090501
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
SIb3DQEJBTEPFw0xODA0MjQxNDAzNTNaMC8GCSqGSIb3DQEJBDEiBCB5c8AqxUMimt5oOC97
DrBQiqNZ1MUn+0854U5xctuipjBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcG
BSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGJBgkrBgEEAYI3EAQxfDB6MGoxCzAJBgNVBAYTAkRF
MQ8wDQYDVQQIDAZCYXllcm4xETAPBgNVBAcMCE11ZW5jaGVuMSAwHgYDVQQKDBdNYXgtUGxh
bmNrLUdlc2VsbHNjaGFmdDEVMBMGA1UEAwwMTVBHIENBIC0gRzAyAgweKlJIhfynPMVG/KIw
gYsGCyqGSIb3DQEJEAILMXygejBqMQswCQYDVQQGEwJERTEPMA0GA1UECAwGQmF5ZXJuMREw
DwYDVQQHDAhNdWVuY2hlbjEgMB4GA1UECgwXTWF4LVBsYW5jay1HZXNlbGxzY2hhZnQxFTAT
BgNVBAMMDE1QRyBDQSAtIEcwMgIMHipSSIX8pzzFRvyiMA0GCSqGSIb3DQEBAQUABIIBAMSp
58BYTE1Iws1ehYLdAH20MNg2OWqtDXFqex7B5o1N+CXZCoXpRzuqPPgdUeIX1XrTfcPRZ3WX
32ur+9p8OAEHx3Uc0rrLqIhI2ewna+ADEvUSnu5tsuLrryWtcAdiGU/RNO9AxQeQXee9G5CA
SgviLGJujlJbX3sA7iaQ8yVEPEznKmAJzPsposANntNZEmu12nFpmu8ND7gXMGcajT2ePlbt
kMgtfSLeGT1L5VtI0zXImVHBGP4GpvfLX+Lp8Ahh36mygB06zxy3KnRQWGBMX6n0iquUpBq1
MVdXNARYE/lFIX6oxPIPIM681xq24FUBPQhQKitp1rwxmi0X1z0AAAAAAAA=
--------------ms020704030306010107090501--
