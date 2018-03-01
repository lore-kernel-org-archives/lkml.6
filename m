Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161235AbeCATOA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 14:14:00 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:37887 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161161AbeCATNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 14:13:53 -0500
X-Google-Smtp-Source: AG47ELs+GJ84DQGj5EvnVrjdA6FrX8ySFfdz0ZY8ZaOd2yySV4fHHXYw5jiFfFFjfDDbXtiwd4jIOg==
Date: Thu, 1 Mar 2018 20:13:48 +0100
From: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        Cameron Gutman <aicommander@gmail.com>,
        =?iso-8859-1?Q?Cl=E9ment?= VUCHENER <clement.vuchener@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>
Subject: Re: [PATCH v4 1/4] HID: add driver for Valve Steam Controller
Message-ID: <20180301191348.GA9281@casa>
References: <20180228184322.29636-1-rodrigorivascosta@gmail.com>
 <20180228184322.29636-2-rodrigorivascosta@gmail.com>
 <CAHp75VfPK=yAx9TLEX-W0SrK8xXQzrP4wAuFWS3zEjHGoPJRsw@mail.gmail.com>
 <20180228224926.GA7009@casa>
 <CAHp75Vd9wgX8S=4hGFERN5bEN9q4=DxYcDea9Z=mvSRi2GcxeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vd9wgX8S=4hGFERN5bEN9q4=DxYcDea9Z=mvSRi2GcxeQ@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2018 at 12:20:37PM +0200, Andy Shevchenko wrote:
> On Thu, Mar 1, 2018 at 12:49 AM, Rodrigo Rivas Costa
> <rodrigorivascosta@gmail.com> wrote:
> > On Wed, Feb 28, 2018 at 09:21:15PM +0200, Andy Shevchenko wrote:
> >> On Wed, Feb 28, 2018 at 8:43 PM, Rodrigo Rivas Costa
> >> <rodrigorivascosta@gmail.com> wrote:
> 
> >> > +       if (input) {
> >>
> >> if (!input)
> >>  return;
> >>
> >> ?
> > That was because of symmetry, because further patches add more objects.
> > Then
> > if (input)
> >         free(input);
> > if (battery)
> >         free(battery);
> > /* in the future *(
> > if (input_gyro)
> >         free(input_gyro);
> >
> > Sure, the last one can do an early return, but you break symmetry.
> 
> The generic APIs when designed properly are NULL aware at freeing resources.
> 
> So, it should look like
> 
> free(input);
> free(battery);
> free(input_gyro);

My bad, I didn't mean a literal free() call. More like:

static void steam_unregister(struct steam_device *steam)
{
	struct input_dev *input;
	struct power_supply *battery;

	rcu_read_lock();
	input = rcu_dereference(steam->input);
	battery = rcu_dereference(steam->battery);
	input_gyro = rcu_dereference(steam->input_gyro);
	rcu_read_unlock();

	if (input) {
		RCU_INIT_POINTER(steam->input, NULL);
		synchronize_rcu();
		hid_info(steam->hdev, "Steam Controller '%s' disconnected",
				steam->serial_no);
		input_unregister_device(input);
	}
	if (battery) {
		RCU_INIT_POINTER(steam->battery, NULL);
		synchronize_rcu();
		power_supply_unregister(battery);
	}
	if (input_gyro) {
		RCU_INIT_POINTER(steam->input_gyro, NULL);
		synchronize_rcu();
		input_unregister_device(input_gyro);
	}
}

Also I think input_unregister_device() does not admit a NULL pointer.
Having a special `if (!input_gyro)return;` at the end looks just
wrong to me, it is no different from the other ones.

> 
> >> > +       if (steam) {
> >> > +               cancel_work_sync(&steam->work_connect);
> >> > +               steam_unregister(steam);
> >>
> >> > +               hid_set_drvdata(hdev, NULL);
> >>
> >> Hmm.. Doesn't HID do this?
> >
> > Do you mean the hid_set_drvdata(hdev, NULL)? I'm not sure, I didn't see
> > that on hid-core.c or hid-generic.c. And a call like this is done in
> > many modules... so I did the same, just to be sure.
> 
> What you are looking for is, AFAIU:
> 
> drivers/base/dd.c:902:          dev_set_drvdata(dev, NULL);

Ah, yes. I usually feel more comfortable setting the pointer to NULL
just after freeing the object. But currently I'm not freeing the steam
anymore, it is devm'ed, and the actual free happens from dd.c:900.

You convinced me, I'll remove that line.

> 
> >>
> >> > +       }
> >>
> >> if (steam) {
> >> ...
> >>        hid_hw_stop(hdev);
> >> ...
> >> } else {
> >>        hid_hw_stop(hdev);
> >> }
> >>
> >> ?
> >
> > I have no real preference. Your version has two 'if', mine has two 'if'.
> > What about:
> >
> > static void steam_remove(struct hid_device *hdev)
> > {
> >         struct steam_device *steam = hid_get_drvdata(hdev);
> >
> >         if (!steam) {
> >                 hid_hw_stop(hdev);
> >                 return;
> >         }
> >
> >         if (steam->quirks & STEAM_QUIRK_WIRELESS) {
> >                 hid_info(hdev, "Steam wireless receiver disconnected");
> >                 hid_hw_close(hdev);
> >         }
> >         hid_hw_stop(hdev);
> >         cancel_work_sync(&steam->work_connect);
> >         steam_unregister(steam);
> 
> >         hid_set_drvdata(hdev, NULL);
> 
> w/o this one.
> 
> > }
> 
> For me my version looks more compact to read, but at the end it's up to you.
> Another option split if (steam) variant into helper, and thus
> 
> if (steam)
>  steam_non_null_device_remove();
> else
>  hid_hw_stop();
> 
> But again, up to you (that's why question mark in the first place above).

Well, I don't like code such as:

	if (cond) {
		/* a lot of code */
	} else {
		/* one line */
	}

because at the time I get to the else I don't remember what the
condition was about.

Regards.
Rodrigo

> -- 
> With Best Regards,
> Andy Shevchenko
