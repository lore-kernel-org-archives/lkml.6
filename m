Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753048AbeBUJJN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 04:09:13 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:39441 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751760AbeBUJJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 04:09:11 -0500
X-Google-Smtp-Source: AG47ELvey5Fx+3j/qHR6F9osjm0AoM65dkol9UAbalO/nLAoGIDTDEMLo4y7EH1lLEvBEHfcz443vOy/KwWOuxKD8qo=
MIME-Version: 1.0
In-Reply-To: <20180220213839.GA12082@light.dominikbrodowski.net>
References: <4287858.bFmM5lK9H6@aspire.rjw.lan> <20180220213839.GA12082@light.dominikbrodowski.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 21 Feb 2018 10:09:10 +0100
X-Google-Sender-Auth: CdacndpwWuPW6pJfFGvPVAiptW4
Message-ID: <CAJZ5v0jHdd=1HALbUPQ2TDYJuzxfW6+UHH6+2jss-6NJ1v64rw@mail.gmail.com>
Subject: Re: [PATCH] PCMCIA / PM: Combine system resume callbacks
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 10:38 PM, Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
> On Tue, Feb 20, 2018 at 12:47:27PM +0100, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> There is a problem with PCMCIA system resume callbacks with respect
>> to suspend-to-idle in which the ->suspend_noirq() callback may be
>> invoked after the ->resume_noirq() one without resuming the system
>> entirely in some cases.  This doesn't work for PCMCIA because of
>> the lack of symmetry between its system suspend and system resume
>> "noirq" callbacks.
>>
>> The system resume handling in PCMCIA is split between
>> socket_early_resume() and socket_late_resume() which are called in
>> different phases of system resume and both need to run for
>> socket_suspend() (invoked by the system suspend "noirq" callback)
>> to work.  Specifically, socket_suspend() returns an error when
>> called after socket_early_resume() without socket_late_resume(),
>> so if the suspend-to-idle core detects a spurious wakeup event and
>> attempts to put the system back to sleep, that is aborted by the
>> error coming from socket_suspend().
>>
>> This design doesn't follow the power management documentation
>> stating that the "noirq" resume callback is expected to reverse
>> the changes made by the "noirq" suspend one.  Moreover, I don't see
>> a reason for splitting the PCMCIA socket system resume handling this
>> way
>
> Unless I am mistaken, this split was introduced by commit
> 9905d1b411946 . So we should take into account the reasons stated
> in that commit message.

Well, I should have done more research, thanks for reminding me about that.

I guess I'll need to add one more state flag, then.
