Return-Path: <marcel@holtmann.org>
X-Google-Smtp-Source: AB8JxZplNi10jvIMJz6znovtWE+X2LNPneNNMgCF2IG7Pw9gfF5x5kB3vy1Xqrm51GQbE7SQ06Ii
ARC-Seal: i=1; a=rsa-sha256; t=1525765778; cv=none;
        d=google.com; s=arc-20160816;
        b=CpxHR1LoNnf41h5Jopi9d+zXOJa/wGSJR4en+HrIJHx1Xh4s7qLSksvKNf4Z5M8r9S
         PAD70vVGqFurmiAXnSztowzz5ljG2k4QAxzkG0iTYTv20FwzM9YihAUOMlXo62N9Z5Ql
         TWWCKyNgmaW7iLxWBUqigCgySnJf/k/8S2+szKAOI6VZEGlxD/ce+E5opcYFz91ugJEu
         KG74WxI1jCBzqcDcSylyAJmbzaxjgi6Npv7hcJ/WhpFXAH7jN2LaUhsk4asSZHF8QfSq
         sM+cjP8r8lPE8mZtuVzvBAC/uPhNMi8RZAwSMEBsR6TJNJRgHi0/wXLULFrm7wb3sKsE
         Er6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:arc-authentication-results;
        bh=R78tCEANF4t1YXSzcnEtuw/0560DycNqjj9wTm57Qoc=;
        b=s8lnx750VYHEEbfBYG56PbbYlFeJt1890xrSPzUbtVk7nzCxhzwLiSYT4MzQwOFYMo
         LWt6d6PZ7fpEjcbzPfVoZ5v8JW4aEfvGECeHMyyHzJFs0WUJIndnaOW/MkVoKmdi/0mZ
         8clkmVIHxdZ0iiAbL3wED9pG4uUYSx7iWm8H+nALlrxQIRDrosHL5tBgHYWwsWk3m7iG
         uskgpTPhzBE+L0O6DKaoEyKve1wmWH6WeIYfHyfYdRNxsRiP63fWn1GKtZpE0KO5sfBj
         viBbLq2ENjWYjQWMHcPd4vuYrHZTr+S2cpXynKgATeeixRWKgGKSFcTHtkXudKrAOkHX
         x3Qw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of marcel@holtmann.org designates 212.227.132.17 as permitted sender) smtp.mailfrom=marcel@holtmann.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of marcel@holtmann.org designates 212.227.132.17 as permitted sender) smtp.mailfrom=marcel@holtmann.org
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH 0/7] gnss: add new GNSS subsystem
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180508070153.GX2285@localhost>
Date: Tue, 8 May 2018 09:49:36 +0200
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Andreas Kemnade <andreas@kemnade.info>,
 Arnd Bergmann <arnd@arndb.de>,
 "H . Nikolaus Schaller" <hns@goldelico.com>,
 Pavel Machek <pavel@ucw.cz>,
 LKML <linux-kernel@vger.kernel.org>,
 devicetree@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C8F35484-132F-466C-B87F-B209B2BC8B37@holtmann.org>
References: <20180424163458.11947-1-johan@kernel.org>
 <20180504132741.brn5jqv5ufjhp7ky@earth.universe>
 <20180507102056.GU2285@localhost>
 <FA27606D-AB12-4D62-8EBD-3CC6F0900AF7@holtmann.org>
 <20180508070153.GX2285@localhost>
To: Johan Hovold <johan@kernel.org>
X-Mailer: Apple Mail (2.3445.6.18)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598647061282688193?=
X-GMAIL-MSGID: =?utf-8?q?1599881376737589501?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Johan,

>>>> I have one concern, though. While providing raw data by
>>>> default is fine generally, it is a problem with device
>>>> auto-discovery. I think there should be some IOCTL from
>>>> the start, that can be used to inform userspace about
>>>> the raw protocol being used (i.e. "NMEA"). I fear, that
>>>> userspace may start to just assume raw =3D NMEA without
>>>> having this (especially since all initial drivers provide
>>>> NMEA).
>>>=20
>>> One problem I see here would be that the driver does not necessarily
>>> know either what protocol is currently being used. Some devices have
>>> boot-pins which can be used to configure the initial protocol used =
(and
>>> this could perhaps be reflected in DT), but this can often later be
>>> changed (by user space) and even be made persistent using =
battery-backed
>>> ram or eeproms.
>>>=20
>>> Also note that at least u-blox devices supports having more than one
>>> protocol active on the same port...
>>=20
>> as long as userspace can determine that it is GNSS hardware and what
>> hardware it is, then you deal with the rest in userspace.
>=20
> Yeah, I think that will do for now.

I forgot to mention that this part should be simple. So providing a =
DEVTYPE attribute that can be easily associated to the /dev/gnssX nodes =
is a must have here. Doing complex mapping of USB or DT layouts to =
figure out this is NMEA vs some vendor vs I need extra code to change =
the mode etc.

So a proper GNSS daemon will require some hardware abstraction anyway. =
There will be still a few GNSS devices that are part of the cellular =
modem, where you have to go via the telephony daemon to get access to =
it. We have done this within oFono since there would be otherwise no =
access to it. So only extra pieces that could be done here is to provide =
a /dev/ugnss (like /dev/uinput, /dev/uhid) so that you can emulate GNSS =
hardware from userspace as well. In oFono, we could then just hook this =
up with /dev/ugnss and the GNSS daemon would not have to have to know =
how to talk to oFono.

Regards

Marcel
