Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751979AbeBYT5x (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 14:57:53 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34049 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751762AbeBYT5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 14:57:51 -0500
Date: Sun, 25 Feb 2018 20:57:48 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
To: Tobias Jordan <Tobias.Jordan@elektrobit.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa@the-dreams.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] i2c: imx: Fix PM device usage count
Message-ID: <20180225195748.5itrchj36wz5mquu@pengutronix.de>
References: <20180224224328.2pfki7rqcxqetmlz@agrajag.zerfleddert.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180224224328.2pfki7rqcxqetmlz@agrajag.zerfleddert.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 24, 2018 at 11:43:28PM +0100, Tobias Jordan wrote:
> pm_runtime_get_sync() increases the device's usage count even when
> reporting an error, so add a call to pm_runtime_put_noidle() in the
> related error branches.
> 
> Fixes: 588eb93ea49f ("i2c: imx: add runtime pm support to improve the
>   performance")
> Signed-off-by: Tobias Jordan <Tobias.Jordan@elektrobit.com>
> ---
> In i2c_imx_xfer(), one could also move the "out" label up (in front of
> the call to pm_runtime_put_autosuspend()), but I'm not sure what the
> underlying error scenario is; calling _put_noidle() seems to be the
> safer bet.
> 
> This is one of a number of patches for problems found using coccinelle 
> scripting in the SIL2LinuxMP project. The patch has been compile-tested;
> it's based on linux-next-20180223.
> 
> For a discussion of the corresponding issue, see
> https://marc.info/?l=linux-pm&m=151904483924999&w=2

I don't get the original mail, so reply here. In reply to the question I
would have asked here, too:

> Why isn't ...get_sync() directly calling ...put_noidle() but relies on
> the driver implementation to do it? It seems unintuitive for a _get_
> function to increase the usage count although returning an error.

Rafael replied:

> Because ...get_sync() returns an error when runtime PM is disabled and
> we wanted that case to be transparent for the users of it.
> 
> In the majority of cases (if not always) errors returned by
> ...get_sync()
> mean disabled runtime PM or flaky hardware and the latter is much less
> common (and generally there's not much to do about them in the kernel
> anyway).

If pm_runtime_get_sync() should be transparent for the users if PM is
disable, why not simply return success then? Or introduce a return value
convention like:

	<0 (i.e. -ESOMETHIN) is error
	0 success
	1 PM is disabled

(Taking a quick glimpse there seem to be already some cases where 1 or
-ESOMETHING is returned, but I didn't find documentation explaining the
return values.)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
