Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967010AbeCAKUn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 05:20:43 -0500
Received: from mail-qk0-f173.google.com ([209.85.220.173]:39725 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966921AbeCAKUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 05:20:39 -0500
X-Google-Smtp-Source: AG47ELsTkUUFDX3vPFQyHtCAoqCJUCn8fbHTu+10NZT0A2iSotQuf98tLSxQzmKbf0rT66SG/Kaep7FzelmhLj+3Xqs=
MIME-Version: 1.0
In-Reply-To: <20180228224926.GA7009@casa>
References: <20180228184322.29636-1-rodrigorivascosta@gmail.com>
 <20180228184322.29636-2-rodrigorivascosta@gmail.com> <CAHp75VfPK=yAx9TLEX-W0SrK8xXQzrP4wAuFWS3zEjHGoPJRsw@mail.gmail.com>
 <20180228224926.GA7009@casa>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 1 Mar 2018 12:20:37 +0200
Message-ID: <CAHp75Vd9wgX8S=4hGFERN5bEN9q4=DxYcDea9Z=mvSRi2GcxeQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] HID: add driver for Valve Steam Controller
To: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        Cameron Gutman <aicommander@gmail.com>,
        =?UTF-8?Q?Cl=C3=A9ment_VUCHENER?= <clement.vuchener@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 1, 2018 at 12:49 AM, Rodrigo Rivas Costa
<rodrigorivascosta@gmail.com> wrote:
> On Wed, Feb 28, 2018 at 09:21:15PM +0200, Andy Shevchenko wrote:
>> On Wed, Feb 28, 2018 at 8:43 PM, Rodrigo Rivas Costa
>> <rodrigorivascosta@gmail.com> wrote:

>> > +       if (input) {
>>
>> if (!input)
>>  return;
>>
>> ?
> That was because of symmetry, because further patches add more objects.
> Then
> if (input)
>         free(input);
> if (battery)
>         free(battery);
> /* in the future *(
> if (input_gyro)
>         free(input_gyro);
>
> Sure, the last one can do an early return, but you break symmetry.

The generic APIs when designed properly are NULL aware at freeing resources.

So, it should look like

free(input);
free(battery);
free(input_gyro);


>> > +       if (steam) {
>> > +               cancel_work_sync(&steam->work_connect);
>> > +               steam_unregister(steam);
>>
>> > +               hid_set_drvdata(hdev, NULL);
>>
>> Hmm.. Doesn't HID do this?
>
> Do you mean the hid_set_drvdata(hdev, NULL)? I'm not sure, I didn't see
> that on hid-core.c or hid-generic.c. And a call like this is done in
> many modules... so I did the same, just to be sure.

What you are looking for is, AFAIU:

drivers/base/dd.c:902:          dev_set_drvdata(dev, NULL);


>>
>> > +       }
>>
>> if (steam) {
>> ...
>>        hid_hw_stop(hdev);
>> ...
>> } else {
>>        hid_hw_stop(hdev);
>> }
>>
>> ?
>
> I have no real preference. Your version has two 'if', mine has two 'if'.
> What about:
>
> static void steam_remove(struct hid_device *hdev)
> {
>         struct steam_device *steam = hid_get_drvdata(hdev);
>
>         if (!steam) {
>                 hid_hw_stop(hdev);
>                 return;
>         }
>
>         if (steam->quirks & STEAM_QUIRK_WIRELESS) {
>                 hid_info(hdev, "Steam wireless receiver disconnected");
>                 hid_hw_close(hdev);
>         }
>         hid_hw_stop(hdev);
>         cancel_work_sync(&steam->work_connect);
>         steam_unregister(steam);

>         hid_set_drvdata(hdev, NULL);

w/o this one.

> }

For me my version looks more compact to read, but at the end it's up to you.
Another option split if (steam) variant into helper, and thus

if (steam)
 steam_non_null_device_remove();
else
 hid_hw_stop();

But again, up to you (that's why question mark in the first place above).

-- 
With Best Regards,
Andy Shevchenko
