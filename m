Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753990AbeEWDbi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 23:31:38 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:36041 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753998AbeEWDbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 23:31:24 -0400
MIME-Version: 1.0
In-Reply-To: <20180522184702.64cd62f6@xeon-e3>
References: <20180523001743.8492-1-chenbo@pdx.edu> <20180522184702.64cd62f6@xeon-e3>
From: Bo Chen <chenbo@pdx.edu>
Date: Tue, 22 May 2018 20:31:22 -0700
Message-ID: <CAO8TxNjyhXuG-9EqH82urxWzHH8XnxcwmjX37=Ew4ifP8-+Wxg@mail.gmail.com>
Subject: Re: [PATCH] e1000: check the return of pci_get_drvdata() in e1000_remove()
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re-send to mailing lists as the previous email was rejected because of
not using plain text.

-----

Hi Stephen,

Thanks for the quick reply and your comments. I am new to network
drivers, and certainly trust your assessment.

I was assuming 'pdev->dev.p' can be NULL with a 'kzalloc()' failure in
'pci_set_drvdata()' invoked by 'e1000_probe()', in which case the
"pci_get_drvdata()" will return a NULL pointer. But I did not trace
back to confirm whether 'pdev->dev.p' has to be valid before
'e1000_probe()' is invoked. Maybe this is what I am missing? Please
excuse my newbie questions and mistakes.

Here is some context about why I started this patch. I am building a
tool to perform "grey-box" fault injection on linux-kernel-module
binaries. In my tool, there is a set of kernel API functions that
faults can be generated, for example making the return of
'__kmalloc()' be NULL. My tool fired an alarm (a kernel panic), when a
fault on ''dev_get_drvdata()" is injected to 'e1000.ko' (and other
drivers were fine, such as e100.ko and pcnet32.ko). It seems that I
was wrong to assume 'dev_get_drvdata()' can return NULL and inject
faults from it. Do you have any suggestions about how I can avoid such
wrong assumptions?

Thanks again for your time and attention. I hope this patch is not
wasting too much effort from the netdev community. Any other comments
or suggestions will be appreciated.

Best Regards,
Bo Chen

On Tue, May 22, 2018 at 6:47 PM, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Tue, 22 May 2018 17:17:43 -0700
> Bo Chen <chenbo@pdx.edu> wrote:
>
> > This check on pci_get_drvdata() prevents potential invalid pointer dereferences,
> > and is a common practice in *_remove() functions from other drivers, such as
> > 'intel/e100.c', 'amd/pcnet32.c', 'realtek/8139too.c', and 'broadcom/tg3.c'.
> >
> > Signed-off-by: Bo Chen <chenbo@pdx.edu>
>
> Why check for something that can never be true.
> You are creating dead code paths that can never be exercised.
