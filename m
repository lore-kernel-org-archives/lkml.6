Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F35FC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 10:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBF9E271D6
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 10:07:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBF9E271D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965342AbeF1KHT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 06:07:19 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:34186 "EHLO
        slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S965296AbeF1KHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 06:07:18 -0400
Received: from relay10.mail.gandi.net (unknown [217.70.178.230])
        by slow1-d.mail.gandi.net (Postfix) with ESMTP id 979683AED80
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 11:34:41 +0200 (CEST)
Received: from classic (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
        (Authenticated sender: hadess@hadess.net)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 3CBAA240002;
        Thu, 28 Jun 2018 09:34:37 +0000 (UTC)
Message-ID: <b5f394c5f8395cd72ecdd5b6f9b2ff2d24253cf7.camel@hadess.net>
Subject: Re: staging: rtl8723bs: bug or pointless if else ?
From:   Bastien Nocera <hadess@hadess.net>
To:     Hans de Goede <hdegoede@redhat.com>,
        Michael Straube <straube.linux@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 28 Jun 2018 11:34:37 +0200
In-Reply-To: <9b1993c2-0b81-35cd-fe27-293f9e8f45c6@redhat.com>
References: <473d9997-8c30-a3f3-85b6-076decc7a7c2@gmail.com>
         <9b1993c2-0b81-35cd-fe27-293f9e8f45c6@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.2 (3.28.2-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-06-28 at 10:22 +0200, Hans de Goede wrote:
> Hi,
> 
> On 28-06-18 09:43, Michael Straube wrote:
> > Hi,
> > 
> > I stumbled upon the following if else construct in
> > drivers/staging/rtl8723bs/os_dep/sdio_intf.c:618
> > 
> >          if (pwrpriv->bInternalAutoSuspend)
> >          {
> >                  ret = rtw_resume_process(padapter);
> >          }
> >          else
> >          {
> >                  if (pwrpriv->wowlan_mode || pwrpriv-
> > >wowlan_ap_mode)
> >                  {
> >                          ret = rtw_resume_process(padapter);
> >                  }
> >                  else
> >                  {
> >                          ret = rtw_resume_process(padapter);
> >                  }
> >          }
> > 
> > It does not matter if the conditions are true or not,
> > ret is always set to:
> > 
> > ret = rtw_resume_process(padapter)
> > 
> > Is this a bug or is the if else construct just pointless?
> 
> It probably is just pointless, my guess would be that once
> upon a time there was a difference in the paths and at some
> point that difference went away.

Quite:
https://github.com/hadess/rtl8723bs/blob/7d36e26f78bbc709844c12ad0c62e3e8503fdbc5/os_dep/linux/sdio_intf.c#L1757
