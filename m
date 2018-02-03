Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753521AbeBCUTI (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 15:19:08 -0500
Received: from mail-lf0-f47.google.com ([209.85.215.47]:39964 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752777AbeBCUTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 15:19:02 -0500
X-Google-Smtp-Source: AH8x225Xlhr/ad57pvUupmZVhZV+fpUgawHw5EcXqgj12Z+OOlDKSOB5X6CCrSoAK6FT2nnII0wpCA==
Date: Sat, 3 Feb 2018 23:22:43 +0300
From: Alexander Sergeyev <sergeev917@gmail.com>
To: Mario Limonciello <mario.limonciello@dell.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: NULL pointer dereference in dell_set_arguments() in 4.15
Message-ID: <20180203202243.GA5109@localhost.localdomain>
References: <20180203162021.GA4571@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180203162021.GA4571@localhost.localdomain>
User-Agent: mtt
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 03, 2018 at 07:20:21PM +0300, Alexander Sergeyev wrote:
> # first bad commit: [549b4930f057658dc50d8010e66219233119a4d8] platform/x86: 
>dell-smbios: Introduce dispatcher for SMM calls

>From source code (at 549b4930f057) it looks like dell_set_arguments() which
>writes to `buffer` is called before the buffer gets allocated

Turns out that the problem has already surfaced before, but from a different 
origin -- namely, rfkill interface [1]. This was subsequently fixed in 
5246741a3f2e and c6f9288ee460.

This time there is an ordering problem between initialization of the 
dell-laptop module and audio modules which are trying to flash a microphone 
mute led on keyboard (via dell-laptop interface).

And about suspend-to-ram wakeup problem -- is it possible that there was some 
buggy interaction with smbios that led to the observed behaviour?

[1] https://lkml.org/lkml/2017/11/15/705
