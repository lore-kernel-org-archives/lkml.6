Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753356AbeA3SfI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 13:35:08 -0500
Received: from mail-qt0-f179.google.com ([209.85.216.179]:46303 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752770AbeA3SfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 13:35:04 -0500
X-Google-Smtp-Source: AH8x224PtUe6mzUhbO+29JyRTBbvAGmrY8lp+7E+JSs/xpV3L8NzK3RyhJe89R3vvA8bUv/wkia3Gg==
Subject: Re: [PATCH v2] iio: accel: bmc150: Check for a second ACPI device for
 BOSC0200
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Hartmut Knaack <knaack.h@gmx.de>,
        Jeremy Cline <jeremy@jcline.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
        Lars Kellogg-Stedman <lars@oddbit.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Wolfram Sang <wsa@the-dreams.de>, linux-iio@vger.kernel.org
References: <010001602cf53153-39ad69f1-1b39-4e6d-a748-9455a16c2fbd-000000@email.amazonses.com>
 <20171210182152.70ad8fbf@archlinux>
 <01000160dccefcb4-25edfd89-56f3-486f-88a4-cb8c07253974-000000@email.amazonses.com>
 <20180114104330.2aa7c1fd@archlinux> <20180128094021.572ab366@archlinux>
 <CAHp75VenBEYSZ9okZfGZUmBX+ikL236a9_qjtn-DJtSihw5X+g@mail.gmail.com>
 <20180130160107.000006df@huawei.com>
 <CAHp75VchRJzp1CM33q18e9x8Uq7bNrPZykz-GdpRgB3=y2C+KQ@mail.gmail.com>
 <CAHp75Vf==OQ=Cx4Nzrd+vAOJshT-oL6L8Y54aWt0cGyJJuacjg@mail.gmail.com>
 <CADXBfmvKF_doLv0Vg0TY4cH_rDBEP5NvJ4jHJf85iuOjJB6TzA@mail.gmail.com>
 <CAHp75VdsDAbgJ1XmhaxA5C8FTcYX7tBa4x_Y4ZYk6Sub510nqw@mail.gmail.com>
From: Steven Presser <steve@pressers.name>
Message-ID: <f42f6acc-cb30-e36d-0c98-42b7e3d40457@pressers.name>
Date: Tue, 30 Jan 2018 13:34:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAHp75VdsDAbgJ1XmhaxA5C8FTcYX7tBa4x_Y4ZYk6Sub510nqw@mail.gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-512; boundary="------------ms030107060805090207030105"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms030107060805090207030105
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

Andy,

I apologize for the long response, but there's several issues to address =

here.

First, I believe the "bmc150" in the subject line is in some way a=20
misnomer.=C2=A0 You'd have to ask Jeremy for more details on what he inte=
nded=20
it to refer to.=C2=A0 However, I believe the device in question is actual=
ly=20
the bma250[1], which does not have a magnetometer component.=C2=A0 I'm=20
unfortunately away from my notes, but I can check later if you need me=20
to verify the exact chip.

Second, we're seeing a difference between what's in the data sheet and=20
what's exposed in the wild via ACPI.=C2=A0 I own the laptop that started =
the=20
process of building this patch and I did the original ACPI-tables=20
investigation.

The device in question (BOSC0200) appears in the Lenovo Yoga 11e (and=20
possibly other laptops - this happens to be the one I own). These=20
laptops have a 360-degree hinge between the screen and the keyboard,=20
letting them convert into tablets, if the user desires. The 11e=20
implements this mode-switching by placing an accelerometer in each of=20
the screen and keyboard, then doing math with the resulting vectors to=20
figure out the angle between the two.=C2=A0 For whatever reason, Lenovo c=
hose=20
to expose these two (physically separate) accelerometers via a single=20
ACPI device which presents two i2c devices at sequential addresses.

As part of my original investigation of the Yoga 11e, I wrote a=20
proof-of-concept of pulling accelerometer data from the two devices=20
exposed under the BOSC0200 ID and using that to calculate the position=20
of the screen relative to the keyboard.=C2=A0 So based on my empirical=20
experience, I can tell you the BOSC0200 device ID can expose two=20
accelerometers at sequential addresses in the wild.

I don't understand why Lenovo has reused the BOSC0200 ACPI device ID for =

a device that is fundamentally different from the base device. The ID=20
doesn't belong to them and we're (apparently) now stuck in this=20
situation where this ACPI device ID could represent two different device =

layouts.

Finally - Andy, I apologize if I came across as challenging you in my=20
initial mail.=C2=A0 I was trying to strike a balance between=20
brevity/respecting your time and asking a question.=C2=A0 Evidently I str=
uck=20
the wrong balance and should have given you more background on why I was =

doubting what you saw.=C2=A0 This is my fault and you have my sincerest=20
apologies for any offense I have caused.

Steve

[1]=20
https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BMA250=
E-DS004-06.pdf


On 01/30/2018 12:38 PM, Andy Shevchenko wrote:
> On Tue, Jan 30, 2018 at 7:25 PM, Steve Presser <steve@pressers.name> wr=
ote:
>> Andy,
>>
>> Where did the assertion the second device is a magnetometer come from?=
 Just
>> the data sheet?
> Yep. See chapter 8.2. Isn't enough proof? Or you believe in two
> accelerometers with off-by-one conflicting address on a cheap laptop
> with left unused two magnetometers on the same time?
>
> And we have a driver for magnetometer separately.
>
> So, it looks like we need to move ACPI ID to a new "kinda I2C mfd" IIO
> driver under drivers/iio/imu/bmc150_i2c.c
>
>
>> Steve
>>
>>
>> On Tue, Jan 30, 2018, 12:05 PM Andy Shevchenko <andy.shevchenko@gmail.=
com>
>> wrote:
>>> On Tue, Jan 30, 2018 at 6:40 PM, Andy Shevchenko
>>> <andy.shevchenko@gmail.com> wrote:
>>>> On Tue, Jan 30, 2018 at 6:01 PM, Jonathan Cameron
>>>> <Jonathan.Cameron@huawei.com> wrote:
>>>>> On Mon, 29 Jan 2018 16:07:02 +0200
>>>>> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>>>>>>> But that would take much longer.  Feel free to propose it and a
>>>>>>> patch
>>>>>>> removing the ifdef fun if you like!
>>>>>> Where can I see the patch?
>>>>> Doh. I clearly forgot to push out.  Should be able to push to
>>>>> iio.git on kernel.org later.
>>>> Thanks, I can see it now.
>>>>
>>>> This patch almost wrong. Not by functionality it brings, but by styl=
e.
>>> Oy vey, the second device is *not* accelerometer, it is a magnetomete=
r
>>> [1].
>>>
>>> [1]: https://www.mouser.com/ds/2/783/BST-BMC150-DS000-04-786477.pdf
>>>
>>>> I'll send soon a series of fixes to the driver (compile tested only)=

>>>> to provide my view on the matters.
>>>>
>>>> P.S. In the future (I have some kind of deja vu I have told this
>>>> already to someone), please, Cc one or more of Rafael, Mika and/or m=
e
>>>> for ACPI matters.
>>> --
>>> With Best Regards,
>>> Andy Shevchenko
>
>



--------------ms030107060805090207030105
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgMFADCABgkqhkiG9w0BBwEAAKCC
C+QwggXiMIIDyqADAgECAhBrp4p9CteI1lEK+Vnk57ThMA0GCSqGSIb3DQEBCwUAMH0xCzAJ
BgNVBAYTAklMMRYwFAYDVQQKEw1TdGFydENvbSBMdGQuMSswKQYDVQQLEyJTZWN1cmUgRGln
aXRhbCBDZXJ0aWZpY2F0ZSBTaWduaW5nMSkwJwYDVQQDEyBTdGFydENvbSBDZXJ0aWZpY2F0
aW9uIEF1dGhvcml0eTAeFw0xNTEyMTYwMTAwMDVaFw0zMDEyMTYwMTAwMDVaMHUxCzAJBgNV
BAYTAklMMRYwFAYDVQQKEw1TdGFydENvbSBMdGQuMSkwJwYDVQQLEyBTdGFydENvbSBDZXJ0
aWZpY2F0aW9uIEF1dGhvcml0eTEjMCEGA1UEAxMaU3RhcnRDb20gQ2xhc3MgMSBDbGllbnQg
Q0EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC9fdr3w6J9g/Zbgv3bW1+uHht1
wLUZr5gkrLtXedg17AkefMyUGwrQdvwObhajcVmnKVxhrUwkZPXRAwZZosRHfEIi5FH7x6SV
/8Sp5lZEuiMnvMFG2MzLA84J6Ws5T4NfXZ0qn4TPgnr3X2vPVS51M7Ua9nIJgn8jvTra4eyy
QzxvuA/GZwKg7VQfDCmCS+kICslYYWgXOMt2xlsSslxLce0CGWRsT8EpMyt1iDflSjXZIsE7
m1uTyHaKZspMLyIyz6mySu8j8BWWHpChNNeTrFuhVfrOAyDPFJVUvKZCLKBhibTLloyy+Lat
oWELrjdI4a8StZY8+dIR9t4APXGzAgMBAAGjggFkMIIBYDAOBgNVHQ8BAf8EBAMCAQYwHQYD
VR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwMgYDVR0f
BCswKTAnoCWgI4YhaHR0cDovL2NybC5zdGFydHNzbC5jb20vc2ZzY2EuY3JsMGYGCCsGAQUF
BwEBBFowWDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3Auc3RhcnRzc2wuY29tMDAGCCsGAQUF
BzAChiRodHRwOi8vYWlhLnN0YXJ0c3NsLmNvbS9jZXJ0cy9jYS5jcnQwHQYDVR0OBBYEFCSB
bDlhvkkPj7cbRivJKLUnSG1oMB8GA1UdIwQYMBaAFE4L7xqkQFulF2mHMMo0aEPQQa7yMD8G
A1UdIAQ4MDYwNAYEVR0gADAsMCoGCCsGAQUFBwIBFh5odHRwOi8vd3d3LnN0YXJ0c3NsLmNv
bS9wb2xpY3kwDQYJKoZIhvcNAQELBQADggIBAIvj94fsAYuErQ8BAluc4SMnIwS9NPBwAm5S
H9uh2NCXTq7im61g7F1LIiNI/+wq37fUuaMbz4g7VarKQTgf8ubs0p7NZWcIe7Bvem2AWaXB
sxsaRTYw5kG3DN8pd1hSEUuFoTa7DmNeFe8tiK1BrL3rbA/m48jp4AiFXgvxprJrW7izsyet
OrRHPbkW4Y07v29MdhaPv3u1JELyszXqOzjIYo4sWlC8iDQXwgSW/ntvWy2n4LuiaozlCfXl
149tKeqvwlvrla2Yklue/quWp9j9ou4T/OY0CXMuY+B8wNK0ohd2D4ShgFlMSjzAFRoHGKF8
1snTr2d1A7Ew02oF6UQyCkC2aNNsK5cWOojBar5c7HplX9aHYUCZouxIeU28SONJAxnATgR4
cJ2jrpmYSz/kliUJ46S6UpVDo/ebn9c6PaM/XtDYCCaM/7XX6wc3s++sbQ7CtCn1Ax7df6uf
QbwyO0V+oFa9H0KAsjHMzcwk3EV2B2NLatidKE/m7G+rB9m+FlVgIiSp0mGlg43QO9Kh1+Jq
vTCIzv2bJJkmPMLQJNuKKwHNL8F4GGp6jbAV+WL+LDeGfVcq8DHS3LrD+xyYEXQBiqZEdiPV
OMxLDSUCXsDO0uCWpaNQ8j6y6S9p0xE/Ga0peVLadVHhqf9nXqKaxnr358VgfrxzUIrvOaOj
MIIF+jCCBOKgAwIBAgIQblaS/9kadBN5WggiIMdzXzANBgkqhkiG9w0BAQsFADB1MQswCQYD
VQQGEwJJTDEWMBQGA1UEChMNU3RhcnRDb20gTHRkLjEpMCcGA1UECxMgU3RhcnRDb20gQ2Vy
dGlmaWNhdGlvbiBBdXRob3JpdHkxIzAhBgNVBAMTGlN0YXJ0Q29tIENsYXNzIDEgQ2xpZW50
IENBMB4XDTE2MDgxMDIyNDkxN1oXDTE5MTExMDIyNDkxN1owQjEcMBoGA1UEAwwTc3RldmVA
cHJlc3NlcnMubmFtZTEiMCAGCSqGSIb3DQEJARYTc3RldmVAcHJlc3NlcnMubmFtZTCCAiIw
DQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBANawlmrhSo5cCRT6pKi1VGoktCtiFh3vwsY3
D+KnXNxrTaVWcrqvEnWrcx6CYctQbvUWnxPt1Yrgnsev4TSNqPqIv+oqkwiho3UOM9AutTLa
U8RsNkoercgA7klslpjC3ItaWazN5BlRaZ8QWwpg6TjRATEG5RvNMbi31DHNM/1yinv7U495
SOSue5jvKvW639GlwxTUfWrUmtmtKJZSMpAYKwnhSehxyN8E3vzd82j4MvlrFSvPEdfIVPkt
o3K0BNAwYd2eHPVlHlWEBekNAzCQqY2vxPTjzlsusYV9lKzCPQ439D4XEWRvEDVS+wCcWepv
dgXqz38rzm4BO3T7udBDBvy2KaImZpPm1y/VHQ8ZFuRHJsdkq+E63wZuTuYFY1RJGm68vaV/
gxFSDZc4adZ/HG0+2/kPc/NuZa66yP4n58irIZXWBe6b6PvET3SUEA7HmsU1arLXVwE/TkPS
/QmGKZLCRrzpgeAP2bwuZMr+dXoNeGlGaf9TBhMXRqrRM+rvWrTst/745uqV5pUTQSJE8xha
SXUanZWZ3COcHiepdq7Lr09XAXU4QU29SgOi7cpxdZAUe0apsTMMWhJYBvISQVBvYZqPPj1X
WuCR4mAUouL8zFvt108F8iTh3VU1lCAI3ulrGqPPlJF7AXEtUGggkxwxnQR7p1Kk/BYeJn4T
AgMBAAGjggG3MIIBszAOBgNVHQ8BAf8EBAMCBLAwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsG
AQUFBwMEMAkGA1UdEwQCMAAwHQYDVR0OBBYEFHEeAfB8TH+O1yTnfhhCM4F+NomZMB8GA1Ud
IwQYMBaAFCSBbDlhvkkPj7cbRivJKLUnSG1oMG8GCCsGAQUFBwEBBGMwYTAkBggrBgEFBQcw
AYYYaHR0cDovL29jc3Auc3RhcnRzc2wuY29tMDkGCCsGAQUFBzAChi1odHRwOi8vYWlhLnN0
YXJ0c3NsLmNvbS9jZXJ0cy9zY2EuY2xpZW50MS5jcnQwOAYDVR0fBDEwLzAtoCugKYYnaHR0
cDovL2NybC5zdGFydHNzbC5jb20vc2NhLWNsaWVudDEuY3JsMB4GA1UdEQQXMBWBE3N0ZXZl
QHByZXNzZXJzLm5hbWUwIwYDVR0SBBwwGoYYaHR0cDovL3d3dy5zdGFydHNzbC5jb20vMEcG
A1UdIARAMD4wPAYLKwYBBAGBtTcBAgUwLTArBggrBgEFBQcCARYfaHR0cHM6Ly93d3cuc3Rh
cnRzc2wuY29tL3BvbGljeTANBgkqhkiG9w0BAQsFAAOCAQEAOBc5QbBzQ4Ghvh1xoHKcCsMj
xm38z1Z3bPWYmEWs0mQVjfT6otJ5dAhmJW8MS2I3MTIg/s8w8b9nSzah84JZT4/pqN0BLvfW
paEn3R3k2OtMnqYNglNEd45PwZO17wD1vqBSoArRXsgGn3X/jTbM+bC7E1c1AnqTePhNdd+d
nGvzFA52eL1HeyecgofMANKiFGViUBFVBW5No1rtw0cF9FVrNMubsLE5J/e/j8OOPYO/pMfr
ruOcbAPTHTEmDJJhYQ/9GQoTBOAR2J2BzbLmjNIjwnxCKggIP5QR59JBQ11JPn9MoX82GRGB
wVGNBj2Rifdg20JXDLuhQUdNVZIIhDGCBOwwggToAgEBMIGJMHUxCzAJBgNVBAYTAklMMRYw
FAYDVQQKEw1TdGFydENvbSBMdGQuMSkwJwYDVQQLEyBTdGFydENvbSBDZXJ0aWZpY2F0aW9u
IEF1dGhvcml0eTEjMCEGA1UEAxMaU3RhcnRDb20gQ2xhc3MgMSBDbGllbnQgQ0ECEG5Wkv/Z
GnQTeVoIIiDHc18wDQYJYIZIAWUDBAIDBQCgggIzMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0B
BwEwHAYJKoZIhvcNAQkFMQ8XDTE4MDEzMDE4MzQ1OVowTwYJKoZIhvcNAQkEMUIEQKmre+u8
MkEkAWRDlegBV0aB3FI3UqOf4WYe5hi4Dyi0D+e9QCvKGALxvJZ1lswdcVpmSKEpOAVaa5jC
qampmS4wbAYJKoZIhvcNAQkPMV8wXTALBglghkgBZQMEASowCwYJYIZIAWUDBAECMAoGCCqG
SIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG
9w0DAgIBKDCBmgYJKwYBBAGCNxAEMYGMMIGJMHUxCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1T
dGFydENvbSBMdGQuMSkwJwYDVQQLEyBTdGFydENvbSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0
eTEjMCEGA1UEAxMaU3RhcnRDb20gQ2xhc3MgMSBDbGllbnQgQ0ECEG5Wkv/ZGnQTeVoIIiDH
c18wgZwGCyqGSIb3DQEJEAILMYGMoIGJMHUxCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1TdGFy
dENvbSBMdGQuMSkwJwYDVQQLEyBTdGFydENvbSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTEj
MCEGA1UEAxMaU3RhcnRDb20gQ2xhc3MgMSBDbGllbnQgQ0ECEG5Wkv/ZGnQTeVoIIiDHc18w
DQYJKoZIhvcNAQEBBQAEggIAGvnolYMiFrlKVoji16iOCDRkOb1qSPjK0rLY6NW1gCCeL+xw
BwndssfUoklCKAwkvgsdc204TQDM4CE02Uf/ISzcybfmAEso9rz+N4+uPk/2Q6XtPRwm0Dar
mi6Y7V/YOtZYduou9UESpG8V3gf4CschuXs86EepvQYf5ADOcM3dg3mxbaTGcpA+iaLltbUY
Q5H69PDWnLhAYzIemX2En4JPY1hudLQpWFFSpqEg4ELviPygxERlYt/g2Ri5v141tQumClDJ
LIZHbnBFT/PqBGJp0/Z9rC8+Ufv0Aejuk3nXo6buw7QLqHPf1CxgchU30aad3ZppDtxZMlsX
+LG8DD+fawddhSS0OW2SIhMMZSm7mFr8PSeoFB4LEKtpodsYmLOSEvt43wn7nNsEXu/N9NdZ
RPy8Z1S/Vf/hpSxq1lpwhefqUG/yP2rDOMYxRKStRv4dBIzaXIgAzWkOygD15ePsf7Tybg2v
/TAPMoNMqf7NnVweyRoGwZjnilKJIxYYu16xibGTNZoQT7i+7uzX66FHePxfWsSnFD8G6OZN
Od11lkFzXrabG18QSqtiDm33p3o+bdlbdIVIdA0p9qzyyYF8guolAlcDA5jfAuq9nFX46D/Q
W0SzAxTOBIiilb72w2ph1ajqG7k/tz3R3mNv9JMv+Z9NJ8L9OddLvah/0BMAAAAAAAA=
--------------ms030107060805090207030105--
