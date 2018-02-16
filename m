Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933018AbeBPJ53 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 04:57:29 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36365 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932979AbeBPJ51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 04:57:27 -0500
X-Google-Smtp-Source: AH8x226zzYS0GaMVDsFNj/F/NheOfNJq0e3TGLg9MwWbfgiHaUuJZ1RRsPMwrRsGoQJV5nkh/Kq7Qg==
Date: Fri, 16 Feb 2018 10:57:22 +0100
From: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH 2/3] HID: steam: add serial number information.
Message-ID: <20180216095722.GC18755@casa>
References: <20180213120308.23879-1-rodrigorivascosta@gmail.com>
 <20180213120308.23879-2-rodrigorivascosta@gmail.com>
 <CAO-hwJK5sos9=RDajS_cXBzfePqf6TJs3Z-jk568sumR-zjqdw@mail.gmail.com>
 <20180215221633.GA18755@casa>
 <CAO-hwJLjFaP3ZLoM+EDbruoRhOyPPFXmo7FWGoXESc9XgkD4Kg@mail.gmail.com>
 <20180216090243.GB18755@casa>
 <CAO-hwJKuWWiNX63=X1GSEQQ1cPhi35g6NuX7gsFNGj_s0UdM+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
In-Reply-To: <CAO-hwJKuWWiNX63=X1GSEQQ1cPhi35g6NuX7gsFNGj_s0UdM+Q@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 16, 2018 at 10:31:35AM +0100, Benjamin Tissoires wrote:
> > Ok, I'll do that. The weird thing, however, is that:
> >
> >         hid_hw_raw_request(steam->hid_dev, 0x00,
> >                 buf, hid_report_len(r), /* 64 */
> >                 HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
> >
> > fails with EOVERFLOW. I have to use:
> >
> >         hid_hw_raw_request(steam->hid_dev, 0x00,
> >                 buf, 65
> >                 HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
> >
> > which just feels wrong to me.
> 
> Indeed
> 
> >
> > And looking around drivers/hid/*.c I see that most calls to
> > hid_hw_raw_request(..., HID_REQ_GET_REPORT) use a buffer allocated with
> > {devm_,}kzalloc() and a constant length, never using
> > hid_alloc_report_buf() or hid_report_len().
> 
> well, hid-input.c and hid-multitouch.c are using
> hid_alloc_report_buf() and these two are the most generic ones. We
> haven't converted everybody to use hid_alloc_report_buf(), but it's
> not a reason to not use it for new drivers :)

Agreed. And they use hid_report_len() on the hid_hw_raw_request().

Now my guess is that hid_report_len() should return 65 instead of 64.
And it would do that if the report.id would be >0, but, alas, it is =0.
Maybe feature reports should add 1 without checking id>0? Or maybe
the Steam report descriptor is wrong and I should use report_fixup or
something?

> No, it's unlikely that there is a bug. Can you forward to me the
> report descriptors of the Steam controller (ideally with the tool
> hid-recorder from http://bentiss.github.io/hid-replay-docs/, so I can
> get a few events too)?

Sure, see the attached file. It is the wired one, I opened jstest and
moved the joystick around to get a few events. Unfortunately the
HID_REQ_GET_REPORT are not recorded.

For the casual reader, here is the decoded report descriptor [1]:

0x06, 0x00, 0xFF,  // Usage Page (Vendor Defined 0xFF00)
0x09, 0x01,        // Usage (0x01)
0xA1, 0x01,        // Collection (Application)
0x15, 0x00,        //   Logical Minimum (0)
0x26, 0xFF, 0x00,  //   Logical Maximum (255)
0x75, 0x08,        //   Report Size (8)
0x95, 0x40,        //   Report Count (64)
0x09, 0x01,        //   Usage (0x01)
0x81, 0x02,        //   Input (Data,Var,Abs,No Wrap,Linear,Preferred State,No Null Position)
0x95, 0x40,        //   Report Count (64)
0x09, 0x01,        //   Usage (0x01)
0x91, 0x02,        //   Output (Data,Var,Abs,No Wrap,Linear,Preferred State,No Null Position,Non-volatile)
0x95, 0x40,        //   Report Count (64)
0x09, 0x01,        //   Usage (0x01)
0xB1, 0x02,        //   Feature (Data,Var,Abs,No Wrap,Linear,Preferred State,No Null Position,Non-volatile)
0xC0,              // End Collection


Regards.
Rodrigo

[1]: http://eleccelerator.com/usbdescreqparser/

--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Description: hid-recorder-steam.txt
Content-Disposition: attachment; filename="steam-hid.txt"

D: 0
R: 33 06 00 ff 09 01 a1 01 15 00 26 ff 00 75 08 95 40 09 01 81 02 95 40 09 01 91 02 95 40 09 01 b1 02 c0
N: Valve Software Wired Controller
P: usb-0000:00:1d.0-1.2/input2
I: 3 28de 1102
D: 0
E: 0.000000 64 01 00 04 0b 06 01 00 00 00 00 00 00 67 14 64 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 1.007977 64 01 00 04 0b 07 01 00 00 00 00 00 00 67 14 64 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
E: 1.087971 64 01 00 01 3c 08 01 00 00 00 00 00 00 00 00 00 00 8b f7 9b 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 78 01 78 01 3b 02 0c 02 00 00 00 00 67 14
E: 1.095962 64 01 00 01 3c 09 01 00 00 00 00 00 00 00 00 00 00 57 f0 d1 06 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 78 01 78 01 42 02 17 02 00 00 00 00 67 14
E: 1.103966 64 01 00 01 3c 0a 01 00 00 00 00 00 00 00 00 00 00 11 e5 1e 0d 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 78 01 78 01 4f 02 22 02 00 00 00 00 67 14
E: 1.115961 64 01 00 01 3c 0b 01 00 00 00 00 00 00 00 00 00 00 4a d7 c5 1a 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 79 01 78 01 5e 02 3a 02 00 00 00 00 67 14
E: 1.123963 64 01 00 01 3c 0c 01 00 00 00 00 00 00 00 00 00 00 40 cb 24 28 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 79 01 78 01 6c 02 4f 02 00 00 00 00 67 14
E: 1.131962 64 01 00 01 3c 0d 01 00 00 00 00 00 00 00 00 00 00 fc be 92 3e 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 78 01 78 01 7a 02 71 02 00 00 00 00 67 14
E: 1.139954 64 01 00 01 3c 0e 01 00 00 00 00 00 00 00 00 00 00 40 b5 2e 4d 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 78 01 78 01 86 02 86 02 00 00 00 00 67 14
E: 1.151964 64 01 00 01 3c 0f 01 00 00 00 00 00 00 00 00 00 00 3c ac 98 61 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 78 01 78 01 91 02 a3 02 00 00 00 00 67 14
E: 1.159960 64 01 00 01 3c 10 01 00 00 00 00 00 00 00 00 00 00 72 a0 6b 76 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 79 01 79 01 a0 02 c0 02 00 00 00 00 67 14
E: 1.167958 64 01 00 01 3c 11 01 00 00 00 00 00 00 00 00 00 00 26 94 ff 7f 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 78 01 78 01 b0 02 d8 02 00 00 00 00 67 14
E: 1.175961 64 01 00 01 3c 12 01 00 00 00 00 00 00 00 00 00 00 9d 92 ff 7f 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 78 01 78 01 b2 02 f8 02 00 00 00 00 67 14
E: 1.239961 64 01 00 01 3c 13 01 00 00 00 00 00 00 00 00 00 00 62 93 ff 7f 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 78 01 78 01 b1 02 fc 02 00 00 00 00 67 14
E: 1.247958 64 01 00 01 3c 14 01 00 00 00 00 00 00 00 00 00 00 e9 94 ff 7f 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 78 01 78 01 af 02 01 03 00 00 00 00 67 14
E: 1.259967 64 01 00 01 3c 15 01 00 00 00 00 00 00 00 00 00 00 40 a0 ff 7f 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 78 01 78 01 a0 02 05 03 00 00 00 00 67 14
E: 1.267959 64 01 00 01 3c 16 01 00 00 00 00 00 00 00 00 00 00 cb ac ff 7f 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 78 01 78 01 8f 02 0f 03 00 00 00 00 67 14
E: 1.275960 64 01 00 01 3c 17 01 00 00 00 00 00 00 00 00 00 00 f5 b8 ff 7f 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 79 01 79 01 7e 02 14 03 00 00 00 00 67 14
E: 1.283957 64 01 00 01 3c 18 01 00 00 00 00 00 00 00 00 00 00 ba ca ff 7f 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 77 01 78 01 64 02 1c 03 00 00 00 00 67 14
E: 1.295958 64 01 00 01 3c 19 01 00 00 00 00 00 00 00 00 00 00 de e0 ff 7f 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 78 01 78 01 41 02 27 03 00 00 00 00 67 14
E: 1.303943 64 01 00 01 3c 1a 01 00 00 00 00 00 00 00 00 00 00 0b f1 ff 7f 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 78 01 78 01 25 02 2c 03 00 00 00 00 67 14
E: 1.311956 64 01 00 01 3c 1b 01 00 00 00 00 00 00 00 00 00 00 11 02 ff 7f 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 79 01 78 01 ff 01 2e 03 00 00 00 00 67 14
E: 1.319957 64 01 00 01 3c 1c 01 00 00 00 00 00 00 00 00 00 00 bf 11 ff 7f 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 78 01 78 01 e2 01 2e 03 00 00 00 00 67 14
E: 1.331959 64 01 00 01 3c 1d 01 00 00 00 00 00 00 00 00 00 00 2b 22 ff 7f 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 78 01 78 01 c6 01 2c 03 00 00 00 00 67 14
E: 1.339957 64 01 00 01 3c 1e 01 00 00 00 00 00 00 00 00 00 00 fa 31 ff 7f 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 78 01 78 01 ad 01 27 03 00 00 00 00 67 14
E: 1.347956 64 01 00 01 3c 1f 01 00 00 00 00 00 00 00 00 00 00 28 42 ff 7f 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 78 01 78 01 95 01 1d 03 00 00 00 00 67 14
E: 1.355970 64 01 00 01 3c 20 01 00 00 00 00 00 00 00 00 00 00 97 4f ff 7f 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 78 01 78 01 82 01 15 03 00 00 00 00 67 14
E: 1.367958 64 01 00 01 3c 21 01 00 00 00 00 00 00 00 00 00 00 f2 61 f0 7d 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 78 01 78 01 69 01 0f 03 00 00 00 00 67 14
E: 1.375951 64 01 00 01 3c 22 01 00 00 00 00 00 00 00 00 00 00 a0 6f 84 78 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 79 01 78 01 57 01 05 03 00 00 00 00 67 14
E: 1.383956 64 01 00 01 3c 23 01 00 00 00 00 00 00 00 00 00 00 c1 79 af 72 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 78 01 78 01 4a 01 fa 02 00 00 00 00 67 14
E: 1.391957 64 01 00 01 3c 24 01 00 00 00 00 00 00 00 00 00 00 ff 7f e8 6b 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 78 01 78 01 35 01 ed 02 00 00 00 00 67 14
E: 1.403955 64 01 00 01 3c 25 01 00 00 00 00 00 00 00 00 00 00 ff 7f 99 62 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 78 01 78 01 26 01 db 02 00 00 00 00 67 14
E: 1.411955 64 01 00 01 3c 26 01 00 00 00 00 00 00 00 00 00 00 ff 7f 72 59 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 78 01 78 01 1b 01 c9 02 00 00 00 00 67 14
E: 1.419958 64 01 00 01 3c 27 01 00 00 00 00 00 00 00 00 00 00 ff 7f fe 4f 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 78 01 78 01 0b 01 b6 02 00 00 00 00 67 14
E: 1.427953 64 01 00 01 3c 28 01 00 00 00 00 00 00 00 00 00 00 ff 7f cf 45 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 79 01 79 01 fa 00 a1 02 00 00 00 00 67 14

--EVF5PPMfhYS0aIcm--
