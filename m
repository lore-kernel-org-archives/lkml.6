Return-Path: <marcel@holtmann.org>
X-Google-Smtp-Source: AB8JxZrw8hiVtnINaIMKekylpPL5M0pjGCN3jSUeQK4f9ZqRVCEBQY0IQ/Ynvy6zrTHLflrtsBeW
ARC-Seal: i=1; a=rsa-sha256; t=1525720006; cv=none;
        d=google.com; s=arc-20160816;
        b=luYVlYrM5pbE1327hcxEpQQPe4Xvobc6XRGP1ADoyzRsBVuIxr2ohLVTzb/0186pcc
         u42s3ds3BRedORkXf25/aiYwgNVmzJCUuUmMRhMzT7nrRuFF+Ddl2Ad0XsuIR5+krmng
         zaJKsEU7YxVTpQ9Jw41NNZTRbo5Wy9HaxoH9BLif/hjJ9+6gw8L1UygOT5orwFf5VhkT
         kmxJ1sRHH1HPrrZQ34YTq5UDMJ76OrTgacQInBTbrGipxS4oXFFJiMXDAIRMKor8hZjL
         6K+2yt/uYTjUAk1mIFXgB9A0fP0IdXMiauXU+qeRxMDl5OIw/Je7P+nAvgpi+IC5/M7O
         KuVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:arc-authentication-results;
        bh=nfCkKL0Z66fdhj0ZHezOGQ5BmeHK8Yi3gM1nAnqO9SM=;
        b=1LE7nXyFx713r4QKzmfcTYG+Yv6xQIRLt452S4xgvJMeQ6aIcAcpUxvjI3uqcxTu5f
         o3E+fP6lzl04dTTHyeOXwIoi/HgSqgyFhFTELUVUCiP4pzpRTah+YO1rJFVf/qtw7Yud
         8x9FImxODtepJ9wexoCZlNhZnlbS+JqeZAxHr/Kud+6gOu0Dz4b44P9+9+HJPYhU6UZD
         yrr4dRXrMeRpuVD5gSzSWltNhnPBr2SEjMtqeRRtbjQfLeM0gMXQqaTajeLEBzlvQvxA
         U06ZRRS69IsgukX5inrLyQXkSiE6J0Pld6W5tkHvb7tH017fEfPe57GR1zjWgsOd88cT
         trEA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of marcel@holtmann.org designates 212.227.132.17 as permitted sender) smtp.mailfrom=marcel@holtmann.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of marcel@holtmann.org designates 212.227.132.17 as permitted sender) smtp.mailfrom=marcel@holtmann.org
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH 0/7] gnss: add new GNSS subsystem
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180507102056.GU2285@localhost>
Date: Mon, 7 May 2018 21:06:44 +0200
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
Message-Id: <FA27606D-AB12-4D62-8EBD-3CC6F0900AF7@holtmann.org>
References: <20180424163458.11947-1-johan@kernel.org>
 <20180504132741.brn5jqv5ufjhp7ky@earth.universe>
 <20180507102056.GU2285@localhost>
To: Johan Hovold <johan@kernel.org>
X-Mailer: Apple Mail (2.3445.6.18)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598647061282688193?=
X-GMAIL-MSGID: =?utf-8?q?1599833380864173283?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Johan,

>>> This series adds a new subsystem for GNSS receivers (e.g. GPS
>>> receivers).
>>>=20
>>> While GNSS receivers are typically accessed using a UART interface =
they
>>> often also support other I/O interfaces such as I2C, SPI and USB, =
while
>>> yet other devices use iomem or even some form of remote-processor
>>> messaging (rpmsg).
>>>=20
>>> The new GNSS subsystem abstracts the underlying interface and =
provides a
>>> new "gnss" class type, which exposes a character-device interface =
(e.g.
>>> /dev/gnss0) to user space. This allows GNSS receivers to have a
>>> representation in the Linux device model, something which is =
important
>>> not least for power management purposes and which also allows for =
easy
>>> detection and (eventually) identification of GNSS devices.
>>>=20
>>> Note that the character-device interface provides raw access to =
whatever
>>> protocol the receiver is (currently) using, such as NMEA 0183, UBX =
or
>>> SiRF Binary. These protocols are expected to be continued to be =
handled
>>> by user space for the time being, even if some hybrid solutions are =
also
>>> conceivable (e.g. to have kernel drivers issue management commands).
>=20
>> Great work. I like your design decisions. I have quite a few devices
>> with have non-serial based GPS peripherals using binary protocols =
(*).
>> As far as I can see it should be possible to add support for those.
>=20
> Thanks! Yeah, the aim here was to abstract the actual I/O interface
> used.
>=20
>> I have one concern, though. While providing raw data by
>> default is fine generally, it is a problem with device
>> auto-discovery. I think there should be some IOCTL from
>> the start, that can be used to inform userspace about
>> the raw protocol being used (i.e. "NMEA"). I fear, that
>> userspace may start to just assume raw =3D NMEA without
>> having this (especially since all initial drivers provide
>> NMEA).
>=20
> One problem I see here would be that the driver does not necessarily
> know either what protocol is currently being used. Some devices have
> boot-pins which can be used to configure the initial protocol used =
(and
> this could perhaps be reflected in DT), but this can often later be
> changed (by user space) and even be made persistent using =
battery-backed
> ram or eeproms.
>=20
> Also note that at least u-blox devices supports having more than one
> protocol active on the same port...

as long as userspace can determine that it is GNSS hardware and what =
hardware it is, then you deal with the rest in userspace.

Regards

Marcel
