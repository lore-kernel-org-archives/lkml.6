Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751372AbeBTVir (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 16:38:47 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:48384 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751135AbeBTViq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 16:38:46 -0500
Date: Tue, 20 Feb 2018 22:38:39 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCMCIA / PM: Combine system resume callbacks
Message-ID: <20180220213839.GA12082@light.dominikbrodowski.net>
References: <4287858.bFmM5lK9H6@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4287858.bFmM5lK9H6@aspire.rjw.lan>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 12:47:27PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> There is a problem with PCMCIA system resume callbacks with respect
> to suspend-to-idle in which the ->suspend_noirq() callback may be
> invoked after the ->resume_noirq() one without resuming the system
> entirely in some cases.  This doesn't work for PCMCIA because of
> the lack of symmetry between its system suspend and system resume
> "noirq" callbacks.
> 
> The system resume handling in PCMCIA is split between
> socket_early_resume() and socket_late_resume() which are called in
> different phases of system resume and both need to run for
> socket_suspend() (invoked by the system suspend "noirq" callback)
> to work.  Specifically, socket_suspend() returns an error when
> called after socket_early_resume() without socket_late_resume(),
> so if the suspend-to-idle core detects a spurious wakeup event and
> attempts to put the system back to sleep, that is aborted by the
> error coming from socket_suspend().
> 
> This design doesn't follow the power management documentation
> stating that the "noirq" resume callback is expected to reverse
> the changes made by the "noirq" suspend one.  Moreover, I don't see
> a reason for splitting the PCMCIA socket system resume handling this
> way

Unless I am mistaken, this split was introduced by commit
9905d1b411946 . So we should take into account the reasons stated
in that commit message.

Thanks,
	Dominik
