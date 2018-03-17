Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753169AbeCQMnd (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 08:43:33 -0400
Received: from mailout5.zih.tu-dresden.de ([141.30.67.74]:50533 "EHLO
        mailout5.zih.tu-dresden.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752340AbeCQMna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 08:43:30 -0400
Subject: Re: [RFT][PATCH v5 0/7] sched/cpuidle: Idle loop rework
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Frederic Weisbecker" <fweisbec@gmail.com>
CC: Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Doug Smythies <dsmythies@telus.net>, "Rik van Riel" <riel@surriel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Mike Galbraith" <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
References: <2142751.3U6XgWyF8u@aspire.rjw.lan>
From: Thomas Ilsche <thomas.ilsche@tu-dresden.de>
Date: Sat, 17 Mar 2018 13:42:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <2142751.3U6XgWyF8u@aspire.rjw.lan>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
        micalg=sha-256; boundary="------------ms050108040009040706000308"
X-ClientProxiedBy: MSX-L102.msx.ad.zih.tu-dresden.de (172.26.34.102) To
 MSX-L104.msx.ad.zih.tu-dresden.de (172.26.34.104)
X-PMWin-Version: 4.0.3, Antispam-Engine: 2.7.2, Antispam-Data:
 2018.3.17.122415, Antivirus-Engine: 3.70.2, Antivirus-Data: 5.49
X-PMWin-Spam: Gauge=XXIIIIIIIII, Probability=29,
 Report='__BOUNCE_CHALLENGE_SUBJ 0, __BOUNCE_NDR_SUBJ_EXEMPT 0,
 __SUBJ_ALPHA_END 0, __TO_MALFORMED_2 0, __TO_NAME 0, __TO_NAME_DIFF_FROM_ACC
 0, __HAS_CC_HDR 0, __MULTIPLE_RCPTS_CC_X2 0, __CC_NAME 0,
 __CC_NAME_DIFF_FROM_ACC 0, __REFERENCES 0, __HAS_FROM 0, __HAS_MSGID 0,
 __SANE_MSGID 0, __USER_AGENT 0, __MOZILLA_USER_AGENT 0, __MIME_VERSION 0,
 __IN_REP_TO 0, __CT 0, __CTYPE_HAS_BOUNDARY 0, __CTYPE_MULTIPART 0,
 __BAT_BOUNDARY 0, __MIME_TEXT_P2 0, __HAS_ATTACHMENT1 0, __ANY_URI 0,
 __HTTPS_URI 0, __URI_WITH_PATH 0, LINK_TO_IMAGE 0, __MAL_TELEKOM_URI 0,
 __URI_NO_WWW 0, __FRAUD_CONTACT_NUM 0, __CP_URI_IN_BODY 0, __FRAUD_URGENCY 0,
 __SUBJ_ALPHA_NEGATE 0, __MULTIPLE_URI_TEXT 0, __URI_IN_BODY 0, __URI_NOT_IMG
 0, __FORWARDED_MSG 0, __NO_HTML_TAG_RAW 0, BODY_SIZE_10000_PLUS 0,
 __ATTACHMENT_SIZE_0_10K 0, __HAS_ATTACHMENT2 0, __ATTACHMENT_SIZE_10_25K 0,
 __MIME_TEXT_P1 0, __RDNS_POOLED_10 0, __URI_NS 0, SXL_IP_DYNAMIC 3,
 HTML_00_01 0.05, HTML_00_10 0.05, RDNS_POOLED 0, RDNS_SUSP_SPECIFIC 0,
 IN_REP_TO 0, MSG_THREAD 0, __TO_REAL_NAMES 0, __CC_REAL_NAMES 0,
 MULTIPLE_REAL_RCPTS 0, LEGITIMATE_SIGNS 0, __FRAUD_COMMON 0, __HAS_ATTACHMENT
 0, MULTIPLE_RCPTS 0.1, RDNS_SUSP 0, __MIME_TEXT_P 0, REFERENCES 0,
 URI_WITH_PATH_ONLY 0'
X-PMWin-SpamScore: 29
Message-ID: <dfddfd651256472fa1b7c9db2a4dcb54@MSX-L104.msx.ad.zih.tu-dresden.de>
X-TUD-Virus-Scanned: mailout5.zih.tu-dresden.de
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------ms050108040009040706000308
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Over the last week I tested v4+pollv2 and now v5+pollv3. With v5, I
observe a particular idle behavior, that I have not seen before with
v4. On a dual-socket Skylake system the idle power increases from
74.1 W (system total) to 85.5 W with a 300 HZ build and even to
138.3 W with a 1000 HZ build. A similar Haswell-EP system is also
affected.

There are phases during which one core will keep switching to the
highest C-state, but not disable the sched tick. Every 4th sched tick,
a kworker on that core is scheduled shortly. Every wakeup from C6 of a
single core will more than double the package power consumption of
*both8 sockets for ~500 us resulting in the significantly increased
sustained power consumption.

This is illustrated in [1]. For a comparison of a "normal" phase
(samekernel), see [2]. For a global view of the effect on a 1000 Hz
build, see [3].

I have not yet found any particular triggers or the specific
interaction between the sched tick and the kworker. I'm not sure how
this was introduced in v5. I would guess it could be a feedback loop
that I was concerned about initially.

I have more findings from v4, but this seems much more impactful.

[1] https://wwwpub.zih.tu-dresden.de/~tilsche/powernightmares/rjwv5_idle_=
300Hz.png
[2] https://wwwpub.zih.tu-dresden.de/~tilsche/powernightmares/rjwv5_idle_=
300Hz_ok.png
[3] https://wwwpub.zih.tu-dresden.de/~tilsche/powernightmares/rjwv5_idle_=
1000Hz.png

On 2018-03-15 22:59, Rafael J. Wysocki wrote:
> Hi All,
>=20
> Thanks a lot for the feedback so far!
>=20
> One more respin after the last batch of comments from Peter and Frederi=
c.
>=20
> The previous summary that still applies:
>=20
> On Sunday, March 4, 2018 11:21:30 PM CET Rafael J. Wysocki wrote:
>>
>> The problem is that if we stop the sched tick in
>> tick_nohz_idle_enter() and then the idle governor predicts short idle
>> duration, we lose regardless of whether or not it is right.
>>
>> If it is right, we've lost already, because we stopped the tick
>> unnecessarily.  If it is not right, we'll lose going forward, because
>> the idle state selected by the governor is going to be too shallow and=

>> we'll draw too much power (that has been reported recently to actually=

>> happen often enough for people to care).
>>
>> This patch series is an attempt to improve the situation and the idea
>> here is to make the decision whether or not to stop the tick deeper in=

>> the idle loop and in particular after running the idle state selection=

>> in the path where the idle governor is invoked.  This way the problem
>> can be avoided, because the idle duration predicted by the idle govern=
or
>> can be used to decide whether or not to stop the tick so that the tick=

>> is only stopped if that value is large enough (and, consequently, the
>> idle state selected by the governor is deep enough).
>>
>> The series tires to avoid adding too much new code, rather reorder the=

>> existing code and make it more fine-grained.
>>
>> Patch 1 prepares the tick-sched code for the subsequent modifications =
and it
>> doesn't change the code's functionality (at least not intentionally).
>>
>> Patch 2 starts pushing the tick stopping decision deeper into the idle=

>> loop, but that is limited to do_idle() and tick_nohz_irq_exit().
>>
>> Patch 3 makes cpuidle_idle_call() decide whether or not to stop the ti=
ck
>> and sets the stage for the subsequent changes.
>>
>> Patch 4 adds a bool pointer argument to cpuidle_select() and the ->sel=
ect
>> governor callback allowing them to return a "nohz" hint on whether or =
not to
>> stop the tick to the caller.  It also adds code to decide what value t=
o
>> return as "nohz" to the menu governor.
>>
>> Patch 5 reorders the idle state selection with respect to the stopping=
 of
>> the tick and causes the additional "nohz" hint from cpuidle_select() t=
o be
>> used for deciding whether or not to stop the tick.
>>
>> Patch 6 causes the menu governor to refine the state selection in case=
 the
>> tick is not going to be stopped and the already selected state may not=
 fit
>> before the next tick time.
>>
>> Patch 7 Deals with the situation in which the tick was stopped previou=
sly,
>> but the idle governor still predicts short idle.
>=20
> This series is complementary to the poll_idle() patch at
>=20
> https://patchwork.kernel.org/patch/10282237/
>=20
> Thanks,
> Rafael
>=20

--=20
Dipl. Inf. Thomas Ilsche
Computer Scientist
Highly Adaptive Energy-Efficient Computing
CRC 912 HAEC: http://tu-dresden.de/sfb912
Technische Universit=C3=A4t Dresden
Center for Information Services and High Performance Computing (ZIH)
01062 Dresden, Germany

Phone: +49 351 463-42168
Fax: +49 351 463-37773
E-Mail: thomas.ilsche@tu-dresden.de


--------------ms050108040009040706000308
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
EGIwggUSMIID+qADAgECAgkA4wvV+K8l2YEwDQYJKoZIhvcNAQELBQAwgYIxCzAJBgNVBAYT
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
ZYoaorVyGTkwggWWMIIEfqADAgECAgwcbjQkPzrYLBvMkTUwDQYJKoZIhvcNAQELBQAwgZUx
CzAJBgNVBAYTAkRFMUUwQwYDVQQKEzxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMgRGV1
dHNjaGVuIEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsTB0RGTi1QS0kxLTArBgNV
BAMTJERGTi1WZXJlaW4gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgMjAeFw0xNjEyMTIxNDM5
MTZaFw0zMTAyMjIyMzU5NTlaMHMxCzAJBgNVBAYTAkRFMRAwDgYDVQQIDAdTYWNoc2VuMRAw
DgYDVQQHDAdEcmVzZGVuMSgwJgYDVQQKDB9UZWNobmlzY2hlIFVuaXZlcnNpdGFldCBEcmVz
ZGVuMRYwFAYDVQQDDA1UVSBEcmVzZGVuIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIB
CgKCAQEA5+CCc42Y1+0J5tpASWPSYx/0Pxqj97P1DdzCbTh3XwppRsAMtqNwS8sTxgHMmbNA
ol18t3EqIkTH/iSXEhd5cf6OSyHumVbgvZTvjMh/c7R3VGZiwqimlhk4/UJV8nVPvrL24Guk
D17Rsv+iLe5Mse7HIMJ7e9ciArdCBV5W6kk/5O24/ZhttIEs/2I3i8MTlGoBaesNgkUy/cRa
A0hw1BBTrDbfK1vhbxV/CWb+czy0F0M5W31LToGrXuwoFrhggn5X/LrFXvCb8/9w+jSk8WzG
vJw6MlPGXHwuTfjf7oei/S0j7iHq5fyIH3lEs58M4kwxlLViv2rc3KJkTX5xmQIDAQABo4IC
BTCCAgEwEgYDVR0TAQH/BAgwBgEB/wIBATAOBgNVHQ8BAf8EBAMCAQYwKQYDVR0gBCIwIDAN
BgsrBgEEAYGtIYIsHjAPBg0rBgEEAYGtIYIsAQEEMB0GA1UdDgQWBBRS/r63JMIbCh1GUo5E
JCr0SEA9ATAfBgNVHSMEGDAWgBST49gyJtrV8UqlkUrg6kviogzP4TCBjwYDVR0fBIGHMIGE
MECgPqA8hjpodHRwOi8vY2RwMS5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1Yi9j
cmwvY2FjcmwuY3JsMECgPqA8hjpodHRwOi8vY2RwMi5wY2EuZGZuLmRlL2dsb2JhbC1yb290
LWcyLWNhL3B1Yi9jcmwvY2FjcmwuY3JsMIHdBggrBgEFBQcBAQSB0DCBzTAzBggrBgEFBQcw
AYYnaHR0cDovL29jc3AucGNhLmRmbi5kZS9PQ1NQLVNlcnZlci9PQ1NQMEoGCCsGAQUFBzAC
hj5odHRwOi8vY2RwMS5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1Yi9jYWNlcnQv
Y2FjZXJ0LmNydDBKBggrBgEFBQcwAoY+aHR0cDovL2NkcDIucGNhLmRmbi5kZS9nbG9iYWwt
cm9vdC1nMi1jYS9wdWIvY2FjZXJ0L2NhY2VydC5jcnQwDQYJKoZIhvcNAQELBQADggEBAEzY
RPywOGl/wZ/Mdz2gLDMbO39f7+iQcrVPRy/lbjjLt+0bouai8xTj1I9N+W4ZOhGww55gXMNO
nBiKouODdNcazTxW6+glA4+5K9bxkAKu9kl9J2ezpcMw1PNTFFcS1yG+thGQTtuy+3S3fI6V
Ifxi+RawFri9sC7010qS3RwOShmhsLk3iEjlDQ180zkBzsdevWHt1svALpqsc+7DcHuP+MgY
vkow/1uyHp3vyeTE9K7hdxcfXwRQ9IkeCo9xLJUeykuosqrTOQNe4Yw4hPhrJfRtoyH92SFq
deZenVeU6+rkquev61X3fPi+/ySpUOGyWPdggN65bQ81E8nLFYUwggWuMIIElqADAgECAgwc
vTmIr0re9lfFR20wDQYJKoZIhvcNAQELBQAwczELMAkGA1UEBhMCREUxEDAOBgNVBAgMB1Nh
Y2hzZW4xEDAOBgNVBAcMB0RyZXNkZW4xKDAmBgNVBAoMH1RlY2huaXNjaGUgVW5pdmVyc2l0
YWV0IERyZXNkZW4xFjAUBgNVBAMMDVRVIERyZXNkZW4gQ0EwHhcNMTcwMjEwMTMxMTIwWhcN
MjAwMjEwMTMxMTIwWjBdMQswCQYDVQQGEwJERTEoMCYGA1UECgwfVGVjaG5pc2NoZSBVbml2
ZXJzaXRhZXQgRHJlc2RlbjEMMAoGA1UECwwDWklIMRYwFAYDVQQDDA1UaG9tYXMgSWxzY2hl
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAw5dKRIicycpBdQWviYlPQxn61uc0
dMnov1GqB3JoJpRyWICwOBn0EWcbKatI1VS6PbAbmCaXjujAZnhIppGj8NQdU15E4HaC0TDp
ucodW2vxb75srHBQ5WBwo3SDHF1gT1l6mAzr1fVddmLi2yV0kK6gaervW4gAh46l5Es6jjnp
ugT1eatFuUy2M/H/MXEeW/lWgOG3POatGOmOR/OC3c321z4OynPk2/LIEnPfrSvpCQZDrKsF
9miwvoXbkYWUAN/qhDEkyYPh/YPQ9YMg5Bgs4xz+EqEECOi8v0DWfxwgQ5zyfRW5aBj5bw0b
PLOydh4m2ufwM+Q7KQfgF04eZwIDAQABo4ICVjCCAlIwCQYDVR0TBAIwADAOBgNVHQ8BAf8E
BAMCBeAwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMB0GA1UdDgQWBBQ5omhFY59I
NNeLxf+a6i2MFhszdjAfBgNVHSMEGDAWgBRS/r63JMIbCh1GUo5EJCr0SEA9ATAmBgNVHREE
HzAdgRt0aG9tYXMuaWxzY2hlQHR1LWRyZXNkZW4uZGUwgY0GA1UdHwSBhTCBgjA/oD2gO4Y5
aHR0cDovL2NkcDEucGNhLmRmbi5kZS90dS1kcmVzZGVuLWcyLWNhL3B1Yi9jcmwvY2Fjcmwu
Y3JsMD+gPaA7hjlodHRwOi8vY2RwMi5wY2EuZGZuLmRlL3R1LWRyZXNkZW4tZzItY2EvcHVi
L2NybC9jYWNybC5jcmwwgdsGCCsGAQUFBwEBBIHOMIHLMDMGCCsGAQUFBzABhidodHRwOi8v
b2NzcC5wY2EuZGZuLmRlL09DU1AtU2VydmVyL09DU1AwSQYIKwYBBQUHMAKGPWh0dHA6Ly9j
ZHAxLnBjYS5kZm4uZGUvdHUtZHJlc2Rlbi1nMi1jYS9wdWIvY2FjZXJ0L2NhY2VydC5jcnQw
SQYIKwYBBQUHMAKGPWh0dHA6Ly9jZHAyLnBjYS5kZm4uZGUvdHUtZHJlc2Rlbi1nMi1jYS9w
dWIvY2FjZXJ0L2NhY2VydC5jcnQwQAYDVR0gBDkwNzARBg8rBgEEAYGtIYIsAQEEAwUwEQYP
KwYBBAGBrSGCLAIBBAMBMA8GDSsGAQQBga0hgiwBAQQwDQYJKoZIhvcNAQELBQADggEBACfM
PajpRlVEBvEeDqkek2aRlU1xLCR1ulK4Z8WlMN+cPnjONaEfYp3oBwqiUNKjNa4VpniQLvXM
xDWgncPOavlajnIH5urkss7iDV9ImaZEyW6sU9ZemBXGN3PP5xI1xX4dKA32N/8J57D+0Im5
I2aa6wLpeFa24qr2b5tXke77ZQwAOxp0CryiVkVP/5rp4C8D43I7x/uRhWbmxzaj+/bMwyZ0
gTsJ/k9KQaR+8oqdDn/X/PI1e7GWNykhhjG+QP1hwj2HqRRAYlTN4S3OAedvNPxtBK+28TGu
bAfD2IQZdvYAqSQT6qt2W1KkUMN38bRKdcICdqm8+fUMe7yKuvQxggO6MIIDtgIBATCBgzBz
MQswCQYDVQQGEwJERTEQMA4GA1UECAwHU2FjaHNlbjEQMA4GA1UEBwwHRHJlc2RlbjEoMCYG
A1UECgwfVGVjaG5pc2NoZSBVbml2ZXJzaXRhZXQgRHJlc2RlbjEWMBQGA1UEAwwNVFUgRHJl
c2RlbiBDQQIMHL05iK9K3vZXxUdtMA0GCWCGSAFlAwQCAQUAoIICBzAYBgkqhkiG9w0BCQMx
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xODAzMTcxMjQyMTlaMC8GCSqGSIb3DQEJ
BDEiBCBFUhT27ITg5EzjAZ5eNAv9Z15CXQ0NMd5T8PsfeIC4jDBsBgkqhkiG9w0BCQ8xXzBd
MAsGCWCGSAFlAwQBKjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCA
MA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGUBgkrBgEEAYI3EAQx
gYYwgYMwczELMAkGA1UEBhMCREUxEDAOBgNVBAgMB1NhY2hzZW4xEDAOBgNVBAcMB0RyZXNk
ZW4xKDAmBgNVBAoMH1RlY2huaXNjaGUgVW5pdmVyc2l0YWV0IERyZXNkZW4xFjAUBgNVBAMM
DVRVIERyZXNkZW4gQ0ECDBy9OYivSt72V8VHbTCBlgYLKoZIhvcNAQkQAgsxgYaggYMwczEL
MAkGA1UEBhMCREUxEDAOBgNVBAgMB1NhY2hzZW4xEDAOBgNVBAcMB0RyZXNkZW4xKDAmBgNV
BAoMH1RlY2huaXNjaGUgVW5pdmVyc2l0YWV0IERyZXNkZW4xFjAUBgNVBAMMDVRVIERyZXNk
ZW4gQ0ECDBy9OYivSt72V8VHbTANBgkqhkiG9w0BAQEFAASCAQArtG5dis8E5wxPhcxDUHGJ
kvNfMcNZ+c/MA9DrG7QT7XxAk2sJsnpZt/btd3PlduEI5idEtM40dkwd/TnTu0Ke+8LJKTpP
O+kPbz3C5aO+pVto8q2r5VZJA6LNhKbPYfUzr0o/TjH+HhhzENCUBh/5EX4NRGzjDFlBvPYs
KP1KO1oFDo8Dl1SlANHoeeIw3vvziL98lpwQwN5EX26/mzu+EWntHKq3UZgZO5jjxReMB73V
lfxl2qx9k0c1cqK+1X8UvbSuoRx8JnEsCXF5uEsGKJUAmeVjwsBbgzKsM8UX/MWdbKULVg9A
Ydb0YQ+egfMGg4Oo2IJ1TbMieIoLtAJ9AAAAAAAA
--------------ms050108040009040706000308--
