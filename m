Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04C9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6BC3218FE
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389842AbeLTVKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 16:10:06 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:58718 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728858AbeLTVKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 16:10:06 -0500
Received: from 89-77-194-223.dynamic.chello.pl (89.77.194.223) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 90aa37423e1904d5; Thu, 20 Dec 2018 22:10:03 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>, Lukas Wunner <lukas@wunner.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] i2c: add suspended flag and accessors for i2c adapters
Date:   Thu, 20 Dec 2018 22:09:37 +0100
Message-ID: <2368540.q2jLLRDsj0@aspire.rjw.lan>
In-Reply-To: <e8bfcadc-7c1a-6659-7173-4ce484ceeca3@redhat.com>
References: <20181219164827.20985-1-wsa+renesas@sang-engineering.com> <20181219223341.GA998@kunai> <e8bfcadc-7c1a-6659-7173-4ce484ceeca3@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, December 20, 2018 11:00:29 AM CET Hans de Goede wrote:
> Hi,
> 
> On 19-12-18 23:33, Wolfram Sang wrote:
> > Hi Lukas, Hans,
> > 
> > On Wed, Dec 19, 2018 at 07:36:54PM +0100, Hans de Goede wrote:
> >> Hi,
> >>
> >> On 19-12-18 18:22, Lukas Wunner wrote:
> >>> On Wed, Dec 19, 2018 at 05:48:17PM +0100, Wolfram Sang wrote:
> >>>> +static inline void i2c_mark_adapter_suspended(struct i2c_adapter *adap)
> >>>> +{
> >>>> +	i2c_lock_bus(adap, I2C_LOCK_ROOT_ADAPTER);
> >>>> +	set_bit(I2C_ALF_IS_SUSPENDED, &adap->locked_flags);
> >>>> +	i2c_unlock_bus(adap, I2C_LOCK_ROOT_ADAPTER);
> >>>> +}
> >>>
> >>> This looks like a duplication of the is_suspended flag in struct dev_pm_info.
> >>> Any reason why you can't use that?  If so, it would be good to document the
> >>> reason in the commit message.
> >>
> >> Oh, that is a very good point and that one only gets set on system suspend
> >> and not on resume suspend, working around the problems with the i2c-designware
> > 
> > Just to make it clear: you mean runtime suspend, not resume suspend, or?
> 
> Yes I mean runtime-suspend, sorry.

The power.is_suspended flag is about system-wide suspend, however.

