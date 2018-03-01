Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034192AbeCAT5R (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 14:57:17 -0500
Received: from mail-qk0-f173.google.com ([209.85.220.173]:44076 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033214AbeCAT5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 14:57:15 -0500
X-Google-Smtp-Source: AG47ELtu4Z9Hk9KQE0NPZALJRaCyubui3tQT5sZtmRQlGgVs9RmAs1nSk3SYxUI0mkcUn1SLjgU38bZdORMTpAyHcsM=
MIME-Version: 1.0
In-Reply-To: <20180301191348.GA9281@casa>
References: <20180228184322.29636-1-rodrigorivascosta@gmail.com>
 <20180228184322.29636-2-rodrigorivascosta@gmail.com> <CAHp75VfPK=yAx9TLEX-W0SrK8xXQzrP4wAuFWS3zEjHGoPJRsw@mail.gmail.com>
 <20180228224926.GA7009@casa> <CAHp75Vd9wgX8S=4hGFERN5bEN9q4=DxYcDea9Z=mvSRi2GcxeQ@mail.gmail.com>
 <20180301191348.GA9281@casa>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 1 Mar 2018 21:57:13 +0200
Message-ID: <CAHp75Vd05R3fRhWp-A=nBaqgC9t_4CUe1fUPSknBDCVr9vdt_A@mail.gmail.com>
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

On Thu, Mar 1, 2018 at 9:13 PM, Rodrigo Rivas Costa
<rodrigorivascosta@gmail.com> wrote:
> On Thu, Mar 01, 2018 at 12:20:37PM +0200, Andy Shevchenko wrote:
>> On Thu, Mar 1, 2018 at 12:49 AM, Rodrigo Rivas Costa
>> <rodrigorivascosta@gmail.com> wrote:
>> > On Wed, Feb 28, 2018 at 09:21:15PM +0200, Andy Shevchenko wrote:
>> >> On Wed, Feb 28, 2018 at 8:43 PM, Rodrigo Rivas Costa
>> >> <rodrigorivascosta@gmail.com> wrote:

> My bad, I didn't mean a literal free() call. More like:
>
> static void steam_unregister(struct steam_device *steam)
> {
>         struct input_dev *input;
>         struct power_supply *battery;
>
>         rcu_read_lock();
>         input = rcu_dereference(steam->input);
>         battery = rcu_dereference(steam->battery);
>         input_gyro = rcu_dereference(steam->input_gyro);
>         rcu_read_unlock();
>

>         if (input) {
>                 RCU_INIT_POINTER(steam->input, NULL);
>                 synchronize_rcu();
>                 hid_info(steam->hdev, "Steam Controller '%s' disconnected",
>                                 steam->serial_no);
>                 input_unregister_device(input);

Candidate for a helper

static void steam_unregister_input(...)
{
...
}


steam_unregister_input(input);

>         }

>         if (battery) {
>                 RCU_INIT_POINTER(steam->battery, NULL);
>                 synchronize_rcu();
>                 power_supply_unregister(battery);
>         }

Ditto.

>         if (input_gyro) {
>                 RCU_INIT_POINTER(steam->input_gyro, NULL);
>                 synchronize_rcu();
>                 input_unregister_device(input_gyro);
>         }

Ditto.

> }
>
> Also I think input_unregister_device() does not admit a NULL pointer.
> Having a special `if (!input_gyro)return;` at the end looks just
> wrong to me, it is no different from the other ones.

See above. Hide that detail in a helper function.

-- 
With Best Regards,
Andy Shevchenko
