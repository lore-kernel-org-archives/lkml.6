Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753976AbeBGL3X (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 06:29:23 -0500
Received: from twosheds.infradead.org ([90.155.92.209]:40298 "EHLO
        twosheds.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753736AbeBGL3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 06:29:22 -0500
Message-ID: <1518002943.3677.109.camel@infradead.org>
Subject: Re: [RFC PATCH 3/4] x86/speculation: Use IBRS if available before
 calling into firmware
From: David Woodhouse <dwmw2@infradead.org>
To: Borislav Petkov <bp@alien8.de>
Cc: tglx@linutronix.de, torvalds@linux-foundation.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        tim.c.chen@linux.intel.com, dave.hansen@intel.com,
        arjan.van.de.ven@intel.com
In-Reply-To: <20180207111739.GA8698@pd.tnic>
References: <1517961794-14972-1-git-send-email-dwmw@amazon.co.uk>
         <1517961794-14972-4-git-send-email-dwmw@amazon.co.uk>
         <20180207111739.GA8698@pd.tnic>
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAG1BMVEUHBwcUFBQpKSlGRkZhYWF9fX2Xl5eysrLMzMxFF+rXAAACaElEQVQ4y21UQXbbIBQE9wJALmAg6ToWON22FrhZthHgbvssUPathC7QWMful2JHSmtWwGg+zPxBCE0DU4QoJQgRgsg4w2gJjBNE8PjFBZgnQMBs+uZ1NQNQjZO3BV4AGDFC0f+l4DBG0VUAM4yv7SO8IgRdHXQ+A78HKL5OAeCfNQV5cHX8DsBUyIJKtYbt98BKaGNCKjfgFVkqYVLbkHKsRsbSCSa0T6npIqLrpRBgQKHUpQmgs9eEKaiUcooE8WWfCGVnBiUcn1uF2XhbfmN9apKnmMP2K4kizKkQWxuaVNOpU2cACIyxO1Po8ETHcXEDMVnozcejkAYA9iaD4pU0ZvNQ8VurNnTuFAYVtuIPUZW25PjDIjQAlGyffIiRQxoWAZBmJ0LTdW2Nyc0iP3DqRhxizvGJkBWZmyFVyZkddWzmBoIBVMpCCJ1CFzl98xav4VJKSSD45KbUT75ixikTphDSRh8+Uz7JLgUTAgAFwzqzjxc/nDY7WUApqY0OMdTwCKZSXplSKkgIRCHElCp8ZnhnKqXuwcNbk1L0VXE+I9alUXoHlLHl3mv7/dWQlJwtjREC7mu9L/U2jQyMUuO2EDS4q9Kl2ddm232bxIE5pjJuVwiljNn/Cfv25/T0cu5cZbwHGVq7h/zp0B4n3S99V/utD+Uo8BiGx9xCsOAV5z7/tjo4Z4z1Lvb90KZ7eFOoOeXOukqF2seo234YYuaQPpRP+cVZU5adT1Edun5Iz3z8fTz3+eSDh0Ip1c7zx1MaijGzTd/3MbRuBHz8cvcVgCMBRpOHvgu59WDhoat+nIZm+LWm9C/aaaGq5DCP9QAAAABJRU5ErkJggg==
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/x-pkcs7-signature"; boundary="=-Ek06kkiruPXHGsNbmwO3"
Date: Wed, 07 Feb 2018 11:29:03 +0000
Mime-Version: 1.0
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by twosheds.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Ek06kkiruPXHGsNbmwO3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Wed, 2018-02-07 at 12:17 +0100, Borislav Petkov wrote:
> Just some random thoughts:
>=20
> On Wed, Feb 07, 2018 at 12:03:13AM +0000, David Woodhouse wrote:
> >=20
> > +#define alternative_msr_write(_msr, _val, _feature)		\
> > +	asm volatile(ALTERNATIVE("",				\
> > +				=C2=A0"movl %[msr], %%ecx\n\t"	\
> > +				=C2=A0"movl %[val], %%eax\n\t"	\
> > +				=C2=A0"movl $0, %%edx\n\t"		\
> We'll never write anything except 0 in %edx?

For these uses, no.

> >=20
> > +				=C2=A0"wrmsr",			\
> > +				=C2=A0_feature)			\
> > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0: : [msr] "i" (_msr), [val] "i" (_val)=
	\
> > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0: "eax", "ecx", "edx", "memory")
>
> So I'm not crazy about making it a separate macro because TBH it doesn't
> look too generic to do that but then again what do I know, considering
> recent history. :-)

It was mostly split out so that if you want to keep playing silly
buggers with it, you can do so in only one place and not three.

If you don't want to keep messing with it, I'm happy to not bother ;)

> 	 [ Maybe I need to not look at the spectral meltdown for a
> 	=C2=A0=C2=A0=C2=A0couple of weeks and simply take a break. ]
>=20
> I guess it is fine if it is in nospec-branch.h and not prefix it with
> alternative_ so that it doesn't give people ideas.

Right. It wasn't really being proposed as a generic alternative.

> Oh and firmware_restrict_branch_speculation_start/end() is just too long
> a name.

Yeah... Thomas wanted descriptive names; I'm not really convinced.

--=-Ek06kkiruPXHGsNbmwO3
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCEFQw
ggUxMIIEGaADAgECAhBNRhEyk/HZ7naOeTHWrzuAMA0GCSqGSIb3DQEBCwUAMIGXMQswCQYDVQQG
EwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYD
VQQKExFDT01PRE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0Q09NT0RPIFJTQSBDbGllbnQgQXV0aGVu
dGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTAeFw0xNzEyMjEwMDAwMDBaFw0xODEyMjEyMzU5
NTlaMCQxIjAgBgkqhkiG9w0BCQEWE2R3bXcyQGluZnJhZGVhZC5vcmcwggEiMA0GCSqGSIb3DQEB
AQUAA4IBDwAwggEKAoIBAQDgzLNWa18DNpGUj/ZeH0Sgz53ESIbzdPw3OJeuNP6jZhxZojbyfxbM
hETscxI/Hj6UZ4a7sHm5BkVjlsB1Af2Za/PXUt8MmLAcPMHkMPGunvkUibEvblDvpqMkQZlaZM+t
5PqFmWkbehLaEvbpNY7dmEAAeKh4klTzJzrr5AAzaCQ32cA2e3+DEIv5O5l9ViMIjy/JM+xMQrfX
3PZ0chY1PaVWjg59d4Uno+5LRDbgCnPkKJX4ysBGadibjBGQGJEZCjh94iiEebn2KsRLvtrJ72Ph
3W2HDEdngW3YP0wujFQVs81U7L8XN3kdPRsa9zNqGtYQP/+1KMMJQ57hnfi9AgMBAAGjggHpMIIB
5TAfBgNVHSMEGDAWgBSCr2yM+MX+lmF86B89K3FIXsSLwDAdBgNVHQ4EFgQUpL+/5lli9jmj2KHj
ryyhnB2xRt0wDgYDVR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwIAYDVR0lBBkwFwYIKwYBBQUH
AwQGCysGAQQBsjEBAwUCMBEGCWCGSAGG+EIBAQQEAwIFIDBGBgNVHSAEPzA9MDsGDCsGAQQBsjEB
AgEBATArMCkGCCsGAQUFBwIBFh1odHRwczovL3NlY3VyZS5jb21vZG8ubmV0L0NQUzBaBgNVHR8E
UzBRME+gTaBLhklodHRwOi8vY3JsLmNvbW9kb2NhLmNvbS9DT01PRE9SU0FDbGllbnRBdXRoZW50
aWNhdGlvbmFuZFNlY3VyZUVtYWlsQ0EuY3JsMIGLBggrBgEFBQcBAQR/MH0wVQYIKwYBBQUHMAKG
SWh0dHA6Ly9jcnQuY29tb2RvY2EuY29tL0NPTU9ET1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5k
U2VjdXJlRW1haWxDQS5jcnQwJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmNvbW9kb2NhLmNvbTAe
BgNVHREEFzAVgRNkd213MkBpbmZyYWRlYWQub3JnMA0GCSqGSIb3DQEBCwUAA4IBAQCK28BdbVJ9
QKQqTDfXwogAYiRBEGptfE1Bjy4F5vC6eWJqOJ15vunxjLwdbZYb4L0qrJlh+ZHHHlbIK8uEZu7N
XHUntmWMbGbZiu7JgrbSXJK1ct9gxrN/sdWYJ+JDjVHg7GfDTvTTPa26JMRqJsO1TjjyDX7A3K39
TjV8C0hqXvwF9BsNf+qBeWO6GVzJ5572awY221hc1umibmZaKV4fg+7fS7qscx5TSuIc6uvMBQhm
7NQiCq6euMMWBDUDlotQCDW0ilm0OuLW3IVLuZCm6Msc+6hT9+dCT4JUvxTHZnnO7uLCxV+Ujad+
PH3itRm38i96p2zvwgLr8vwWA0ckMIIFMTCCBBmgAwIBAgIQTUYRMpPx2e52jnkx1q87gDANBgkq
hkiG9w0BAQsFADCBlzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQ
MA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENP
TU9ETyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EwHhcNMTcx
MjIxMDAwMDAwWhcNMTgxMjIxMjM1OTU5WjAkMSIwIAYJKoZIhvcNAQkBFhNkd213MkBpbmZyYWRl
YWQub3JnMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA4MyzVmtfAzaRlI/2Xh9EoM+d
xEiG83T8NziXrjT+o2YcWaI28n8WzIRE7HMSPx4+lGeGu7B5uQZFY5bAdQH9mWvz11LfDJiwHDzB
5DDxrp75FImxL25Q76ajJEGZWmTPreT6hZlpG3oS2hL26TWO3ZhAAHioeJJU8yc66+QAM2gkN9nA
Nnt/gxCL+TuZfVYjCI8vyTPsTEK319z2dHIWNT2lVo4OfXeFJ6PuS0Q24Apz5CiV+MrARmnYm4wR
kBiRGQo4feIohHm59irES77aye9j4d1thwxHZ4Ft2D9MLoxUFbPNVOy/Fzd5HT0bGvczahrWED//
tSjDCUOe4Z34vQIDAQABo4IB6TCCAeUwHwYDVR0jBBgwFoAUgq9sjPjF/pZhfOgfPStxSF7Ei8Aw
HQYDVR0OBBYEFKS/v+ZZYvY5o9ih468soZwdsUbdMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8E
AjAAMCAGA1UdJQQZMBcGCCsGAQUFBwMEBgsrBgEEAbIxAQMFAjARBglghkgBhvhCAQEEBAMCBSAw
RgYDVR0gBD8wPTA7BgwrBgEEAbIxAQIBAQEwKzApBggrBgEFBQcCARYdaHR0cHM6Ly9zZWN1cmUu
Y29tb2RvLm5ldC9DUFMwWgYDVR0fBFMwUTBPoE2gS4ZJaHR0cDovL2NybC5jb21vZG9jYS5jb20v
Q09NT0RPUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNybDCBiwYIKwYB
BQUHAQEEfzB9MFUGCCsGAQUFBzAChklodHRwOi8vY3J0LmNvbW9kb2NhLmNvbS9DT01PRE9SU0FD
bGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWlsQ0EuY3J0MCQGCCsGAQUFBzABhhhodHRw
Oi8vb2NzcC5jb21vZG9jYS5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5mcmFkZWFkLm9yZzANBgkq
hkiG9w0BAQsFAAOCAQEAitvAXW1SfUCkKkw318KIAGIkQRBqbXxNQY8uBebwunliajideb7p8Yy8
HW2WG+C9KqyZYfmRxx5WyCvLhGbuzVx1J7ZljGxm2YruyYK20lyStXLfYMazf7HVmCfiQ41R4Oxn
w0700z2tuiTEaibDtU448g1+wNyt/U41fAtIal78BfQbDX/qgXljuhlcyeee9msGNttYXNbpom5m
WileH4Pu30u6rHMeU0riHOrrzAUIZuzUIgqunrjDFgQ1A5aLUAg1tIpZtDri1tyFS7mQpujLHPuo
U/fnQk+CVL8Ux2Z5zu7iwsVflI2nfjx94rUZt/Iveqds78IC6/L8FgNHJDCCBeYwggPOoAMCAQIC
EGqb4Tg7/ytrnwHV2binUlYwDQYJKoZIhvcNAQEMBQAwgYUxCzAJBgNVBAYTAkdCMRswGQYDVQQI
ExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBD
QSBMaW1pdGVkMSswKQYDVQQDEyJDT01PRE8gUlNBIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MB4X
DTEzMDExMDAwMDAwMFoXDTI4MDEwOTIzNTk1OVowgZcxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJH
cmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBM
aW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2Vj
dXJlIEVtYWlsIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAvrOeV6wodnVAFsc4
A5jTxhh2IVDzJXkLTLWg0X06WD6cpzEup/Y0dtmEatrQPTRI5Or1u6zf+bGBSyD9aH95dDSmeny1
nxdlYCeXIoymMv6pQHJGNcIDpFDIMypVpVSRsivlJTRENf+RKwrB6vcfWlP8dSsE3Rfywq09N0Zf
xcBa39V0wsGtkGWC+eQKiz4pBZYKjrc5NOpG9qrxpZxyb4o4yNNwTqzaaPpGRqXB7IMjtf7tTmU2
jqPMLxFNe1VXj9XB1rHvbRikw8lBoNoSWY66nJN/VCJv5ym6Q0mdCbDKCMPybTjoNCQuelc0IAaO
4nLUXk0BOSxSxt8kCvsUtQIDAQABo4IBPDCCATgwHwYDVR0jBBgwFoAUu69+Aj36pvE8hI6t7jiY
7NkyMtQwHQYDVR0OBBYEFIKvbIz4xf6WYXzoHz0rcUhexIvAMA4GA1UdDwEB/wQEAwIBhjASBgNV
HRMBAf8ECDAGAQH/AgEAMBEGA1UdIAQKMAgwBgYEVR0gADBMBgNVHR8ERTBDMEGgP6A9hjtodHRw
Oi8vY3JsLmNvbW9kb2NhLmNvbS9DT01PRE9SU0FDZXJ0aWZpY2F0aW9uQXV0aG9yaXR5LmNybDBx
BggrBgEFBQcBAQRlMGMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9jcnQuY29tb2RvY2EuY29tL0NPTU9E
T1JTQUFkZFRydXN0Q0EuY3J0MCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5jb21vZG9jYS5jb20w
DQYJKoZIhvcNAQEMBQADggIBAHhcsoEoNE887l9Wzp+XVuyPomsX9vP2SQgG1NgvNc3fQP7TcePo
7EIMERoh42awGGsma65u/ITse2hKZHzT0CBxhuhb6txM1n/y78e/4ZOs0j8CGpfb+SJA3GaBQ+39
4k+z3ZByWPQedXLL1OdK8aRINTsjk/H5Ns77zwbjOKkDamxlpZ4TKSDMKVmU/PUWNMKSTvtlenlx
Bhh7ETrN543j/Q6qqgCWgWuMAXijnRglp9fyadqGOncjZjaaSOGTTFB+E2pvOUtY+hPebuPtTbq7
vODqzCM6ryEhNhzf+enm0zlpXK7q332nXttNtjv7VFNYG+I31gnMrwfHM5tdhYF/8v5UY5g2xANP
ECTQdu9vWPoqNSGDt87b3gXb1AiGGaI06vzgkejL580ul+9hz9D0S0U4jkhJiA7EuTecP/CFtR72
uYRBcunwwH3fciPjviDDAI9SnC/2aPY8ydehzuZutLbZdRJ5PDEJM/1tyZR2niOYihZ+FCbtf3D9
mB12D4ln9icgc7CwaxpNSCPt8i/GqK2HsOgkL3VYnwtx7cJUmpvVdZ4ognzgXtgtdk3ShrtOS1iA
N2ZBXFiRmjVzmehoMof06r1xub+85hFQzVxZx5/bRaTKTlL8YXLI8nAbR9HWdFqzcOoB/hxfEyIQ
px9/s81rgzdEZOofSlZHynoSMYIDxzCCA8MCAQEwgawwgZcxCzAJBgNVBAYTAkdCMRswGQYDVQQI
ExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBD
QSBMaW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQg
U2VjdXJlIEVtYWlsIENBAhBNRhEyk/HZ7naOeTHWrzuAMA0GCWCGSAFlAwQCAQUAoIIB6zAYBgkq
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xODAyMDcxMTI5MDNaMC8GCSqG
SIb3DQEJBDEiBCAUjYonZd8allN9W0LWdyUagpj8rMyIVV0mxkhl6bvnTTCBvQYJKwYBBAGCNxAE
MYGvMIGsMIGXMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYD
VQQHEwdTYWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0Q09NT0RP
IFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIQTUYRMpPx2e52
jnkx1q87gDCBvwYLKoZIhvcNAQkQAgsxga+ggawwgZcxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJH
cmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBM
aW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2Vj
dXJlIEVtYWlsIENBAhBNRhEyk/HZ7naOeTHWrzuAMA0GCSqGSIb3DQEBAQUABIIBAAONSfU9IkDX
FHTlxVkiOJ5OsLfWIFjQrYDftljySQawoQFrtZ83ud64ZRdXbfwLzvLdEtBO8TiBXjo1wSz/rxmQ
TSF1wl4P6lJDRYr2HX4tuaLNU2BHfW+z2UvNhxCS3bd5+g44gv7J+CpLjpGk78ohYrxfk8bHspMm
feXvDYhiHr94stdUk8+nMuHgcF804OZ5JnVzKeUOHVSp/6uOsBj89kkD5hAoEa82tsgCGRn4mreo
GMkeCnYj86EenA4q0B3KLgcOVetutMBvMWrma3C2kwFTIhLbFteXMyV0gzKWz8E9D51MrToTUfwG
yhD2qjS3k75oJTx8UcvGzdjlUtQAAAAAAAA=


--=-Ek06kkiruPXHGsNbmwO3--
