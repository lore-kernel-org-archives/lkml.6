Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A064FECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4712220856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:59:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4712220856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388713AbeGXQGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 12:06:42 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:44572 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S2388614AbeGXQGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 12:06:42 -0400
Received: (qmail 1358 invoked by uid 2102); 24 Jul 2018 10:59:49 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 Jul 2018 10:59:49 -0400
Date:   Tue, 24 Jul 2018 10:59:49 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Paul Menzel <pmenzel+linux-usb@molgen.mpg.de>
cc:     linux-usb@vger.kernel.org, <linux-kernel@vger.kernel.org>
Subject: Re: `ohci_rh_resume()` called during `usb_dev_suspend()`
In-Reply-To: <a8d7fe54-5fa8-3569-f615-5ee3d967fd18@molgen.mpg.de>
Message-ID: <Pine.LNX.4.44L0.1807241057260.1311-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jul 2018, Paul Menzel wrote:

> Dear Alan,
> 
> 
> Thank you for your quick response.
> 
> On 07/24/18 16:21, Alan Stern wrote:
> > On Tue, 24 Jul 2018, Paul Menzel wrote:
> 
> >> Profiling the suspend to and resume/wake-up from ACPI S3 with 
> >> `sleepgraph.py` on an ASRock E350M1, I noticed that resume methods are 
> >> called during suspend.
> >>
> >> Here is an excerpt from the callgraph.
> >>
> >>>   600.376906 |   0)   kworker-81   |               |  /* device_pm_callback_start: usb usb5, parent: 0000:00:14.5, type [suspend] */
> >>>   600.376909 |   0)   kworker-81   |               |    usb_dev_suspend() {
> >>>   600.376911 |   0)   kworker-81   |               |      usb_suspend() {
> >>>   600.376913 |   0)   kworker-81   |               |        __pm_runtime_resume() {
> >>>   600.376915 |   0)   kworker-81   |               |          _cond_resched() {
> >>>   600.376917 |   0)   kworker-81   |   0.565 us    |            rcu_all_qs();
> >>>   600.376921 |   0)   kworker-81   |   4.034 us    |          } /* _cond_resched */
> >>>   600.376922 |   0)   kworker-81   |   0.505 us    |          _raw_spin_lock_irqsave();
> >>>   600.376926 |   0)   kworker-81   |               |          rpm_resume() {
> >>>   600.376928 |   0)   kworker-81   |   0.573 us    |            _raw_spin_lock();
> >>>   600.376934 |   0)   kworker-81   |   0.706 us    |            rpm_resume();
> >>>   600.376937 |   0)   kworker-81   |   0.556 us    |            _raw_spin_lock();
> >>>   600.376942 |   0)   kworker-81   |   0.721 us    |            __rpm_get_callback();
> >>>   600.376946 |   0)   kworker-81   |   0.564 us    |            dev_pm_disable_wake_irq_check();
> >>>   600.376949 |   0)   kworker-81   |               |            rpm_callback() {
> >>>   600.376952 |   0)   kworker-81   |               |              __rpm_callback() {
> >>>   600.376954 |   0)   kworker-81   |               |                usb_runtime_resume() {
> >>>   600.376956 |   0)   kworker-81   |               |                  usb_resume_both() {
> >>>   600.376959 |   0)   kworker-81   |               |                    generic_resume() {
> >>>   600.376960 |   0)   kworker-81   |               |                      hcd_bus_resume() {
> >>>   600.376963 |   0)   kworker-81   |               |                        ohci_bus_resume [ohci_hcd]() {
> >>>   600.376964 |   0)   kworker-81   |   0.588 us    |                          _raw_spin_lock_irq();
> >>>   600.376968 |   0)   kworker-81   |               |                          ohci_rh_resume [ohci_hcd]() {
> >>>   600.377043 |   0)   kworker-81   |               |                            msleep() {
> >>
> >> Please find the full callgraph and the HTML output attached.
> >>
> >> Is that expected?
> > 
> > I can't tell exactly what's happening from your callgraph and HTML, but
> > yes, in general it is expected.
> > 
> > The reason is because some devices have different wakeup settings for
> > runtime suspend and system suspend: A device that is enabled for wakeup
> > signalling during runtime suspend often is not enabled for wakeup
> > during system suspend.
> > 
> > As a result, the device's wakeup setting has to be changed when the 
> > system goes to sleep, and to do that, we have to wake the device up 
> > temporarily if it is already in runtime suspend.
> 
> Understood. Thank you for the explanation.
> 
> Sorry for being ignorant, but I have two more questions.
> 
> 1.  Should this also happen, if no USB device is connected to a hub?

Yes, it can happen, because the root hub (which is built into the USB 
controller hardware on the computer) may have different wakeup settings 
for runtime suspend and system suspend.

> 2.  If somebody point me to the code, how the callback(?)
>     `pm_runtime_resume()` is hooked up in `usb_suspend()` that’d help
>     me to better understand, what is going on.

usb_suspend() calls choose_wakeup(), and under certain conditions, 
choose_wakeup() calls pm_runtime_resume().

Alan Stern

> Kind regards and thank you very much in advance,
> 
> Paul
> 
> 

