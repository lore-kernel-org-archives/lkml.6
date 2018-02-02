Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751916AbeBBW5N (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 17:57:13 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41771 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751468AbeBBW5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 17:57:05 -0500
X-Google-Smtp-Source: AH8x225xypDUHhM24EmZE3aQCRnbBrAV+o8izsdGLg6++jMq2w9YugAeqoDshxyQ//dZ2JBTEyQSvw==
Date: Fri, 2 Feb 2018 14:57:01 -0800
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Jeremy McNicoll <jmcnicol@redhat.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Will Newton <will.newton@gmail.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Chris Lew <clew@quicinc.com>
Subject: Re: [PATCH 2/5] rpmsg: smd: Create device for all channels
Message-ID: <20180202225701.GJ12728@builder>
References: <20171212235857.10432-1-bjorn.andersson@linaro.org>
 <20171212235857.10432-3-bjorn.andersson@linaro.org>
 <20180127010152.GA32527@mini-rhel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180127010152.GA32527@mini-rhel.redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 26 Jan 17:01 PST 2018, Jeremy McNicoll wrote:

> On Tue, Dec 12, 2017 at 03:58:54PM -0800, Bjorn Andersson wrote:
[..]
> > 
> > The result of this patch is that we will actively open the RPM channel
> > even though it's left in a state other than "opening" after the boot
> > loader's closing of the channel.
> >
> 
> Its been a while since I looked at this closely but, isn't the result
> of this patch that we now will create a channel / register a platform
> device if the state of the channel is left in any state. 
> 

Correct, we will create devices for all channels found (on the specific
edge), rather than just the ones that are in opening state. Looking
through a few platforms does however indicate that the two cases where
channels appear but are not in this state are:

1) The rpm_request channel when LK has been communicating with the RPM
before jumping to the kernel.

2) You stop a remote processor, switch firmware to one with less
features and the start it again. Any channels not used by the new
firmware will still be found and we will fail to open them - as
described above. I would be surprised if this would happen in reality.


So with the added handshake mechanism we're supporting #1 and we deal
with #2 - if it ever would happen.

Regards,
Bjorn
