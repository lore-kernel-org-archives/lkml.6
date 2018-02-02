Return-Path: <Shigeru.Yoshida@windriver.com>
X-Google-Smtp-Source: AH8x227hsVCzMNMQsL9fZcJQbSEHrdlMV+OR0aoMR/nHXFDUniD+f3BPiCHmG9qUMapp+og+6WyC
ARC-Seal: i=1; a=rsa-sha256; t=1517535964; cv=none;
        d=google.com; s=arc-20160816;
        b=rFW45YFiWAP+mr1xcHtoublA5avQnEUFUTSEzkDY8B9ewe2zeFWbFUjxpOOfMSqthD
         4EKsHSLfdhvQCYu2U1bT73+37FeIHskdvKXfRmjLrfw9hDuF8S2WDE1dgAp4J6WgavgD
         aBSA/73Pg23qLTsxKksZvB/CFXfwkz1qGajFmVZ1JtM43/3FMgV+Sz4Yt4PVJwLWJbU9
         VhdYzVfrXIhcE9WBvjRE25R36PSlS6Q29m1Fzan8HChTvRGcsbg0rlD6otxvKWFdxQj4
         Be+V541NiuXPn5+8H3lhQ7YWDboUXHNn3/8156LfxIiD/7WOQaInkpuWozebijFxDS3J
         YjcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=urAUzF8EbSqoJKrA8sgo0Zp56owkhiGIg1fSwyOv1CQ=;
        b=mD3NGt7nG/8CtFG7QazbvydFpz5iJ9N+hpEWew7ABL1QOlkgF+1Avd3/LPnnNq8/6s
         zr1vWKNekxbNelxkZyfSDBOjHgfXQ5omHoIF7CxnzF1epNKR242DEcM7zAGDJwFNom8x
         h7jNPD0rF7IxF+reqAztmfVjzaKlr3K27WhSo4wkRIya56+tL6RP9KAkbRkGH/Izvenn
         IBjjX9LL/WHtmKLFZP30M0xZyfnQnTlPe3aYqmjJrIBjIaP3S5/eb0ILDK2atJf36bK9
         AUrZBjrs1OCdO/JOfhXmbOlf4TpXPFsmNa1TYYhtErH/fB38eP4HtfGcwLy198otjI3O
         4mpQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of shigeru.yoshida@windriver.com designates 147.11.146.13 as permitted sender) smtp.mailfrom=Shigeru.Yoshida@windriver.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of shigeru.yoshida@windriver.com designates 147.11.146.13 as permitted sender) smtp.mailfrom=Shigeru.Yoshida@windriver.com
From: "Yoshida, Shigeru" <Shigeru.Yoshida@windriver.com>
To: "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>
CC: "Bai, Haiqing" <Haiqing.Bai@windriver.com>,
        "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ohci-hcd: Fix race condition caused by
 ohci_urb_enqueue() and io_watchdog_func()
Thread-Topic: [PATCH] ohci-hcd: Fix race condition caused by
 ohci_urb_enqueue() and io_watchdog_func()
Thread-Index: AQHTmncRqxjtZV1slkO7r5QpQNTFa6OOqw2AgADm5YCAAKNFgIAAq14A
Date: Fri, 2 Feb 2018 01:46:01 +0000
Message-ID: <20180202.104654.1854598770724026730.shigeru.yoshida@windriver.com>
References: <20180201.144911.2171407625301691891.shigeru.yoshida@windriver.com>
	<Pine.LNX.4.44L0.1802011029160.1677-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1802011029160.1677-100000@iolanthe.rowland.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [128.224.232.213]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DBB7DA941DBEF641983CB7C10AEBA9A9@local>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591100238204595234?=
X-GMAIL-MSGID: =?utf-8?q?1591251791185691746?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Alan,

On Thu, 1 Feb 2018 10:33:33 -0500, Alan Stern wrote:
>> I think we must choose an invalid frame number for the special
>> sentinel value, but I'm not sure which value is adequate for it.
>> Is 0xffffff00 an invalid frame number, otherwise how about simply
>> -1(0xffffffff)?
>=20
> Well, the frame_no register is 32 bits wide, but only the 16 low-order=20
> bits are meaningful.  ohci_frame_no() strips off the high-order 16=20
> bits, so any value with one of those bits set would be acceptable. =20
> (Besides, valid frame numbers only go up to 2047.)
>=20
> I chose 0xffffff00 because PCI reads from a non-working device=20
> generally get a value with all the bits set.  But since the upper 16=20
> bits are masked away anyhow, it doesn't matter.  -1u would be fine.

Thanks, I choose 0xffffff00 as you suggested, and will prepare v2 patch.

Thanks,
Shigeru=
