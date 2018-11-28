Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C035C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA364206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:48:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA364206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lge.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbeK2Kvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 05:51:45 -0500
Received: from lgeamrelo12.lge.com ([156.147.23.52]:40692 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726382AbeK2Kvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 05:51:44 -0500
Received: from unknown (HELO lgeamrelo02.lge.com) (156.147.1.126)
        by 156.147.23.52 with ESMTP; 29 Nov 2018 08:48:21 +0900
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: chanho.min@lge.com
Received: from unknown (HELO WMRRD11NA101CK) (10.178.32.163)
        by 156.147.1.126 with ESMTP; 29 Nov 2018 08:48:20 +0900
X-Original-SENDERIP: 10.178.32.163
X-Original-MAILFROM: chanho.min@lge.com
From:   "Chanho Min" <chanho.min@lge.com>
To:     "'Takashi Iwai'" <tiwai@suse.de>
Cc:     "'Jaroslav Kysela'" <perex@perex.cz>,
        "'Takashi Iwai'" <tiwai@kernel.org>,
        "'Vinod Koul'" <vkoul@kernel.org>,
        "'Daniel Mentz'" <danielmentz@google.com>,
        <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        "'Seungho Park'" <seungho1.park@lge.com>,
        "'Jongsung Kim'" <neidhard.kim@lge.com>,
        "'Wonmin Jung'" <wonmin.jung@lge.com>,
        "'Jaehyun Kim'" <jehn.kim@lge.com>,
        "'Hyonwoo Park'" <hyonwoo.park@lge.com>
References: <1543210597-6717-1-git-send-email-chanho.min@lge.com>       <s5hin0k6xqy.wl-tiwai@suse.de>  <1aaf01d486ab$8017a5b0$8046f110$@lge.com> <s5hwoox61ic.wl-tiwai@suse.de>
In-Reply-To: <s5hwoox61ic.wl-tiwai@suse.de>
Subject: RE: [PATCH] ALSA: pcm: Fix starvation on down_write_nonblock()
Date:   Thu, 29 Nov 2018 08:48:20 +0900
Message-ID: <046401d48774$d7d1e440$8775acc0$@lge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQMaVnIxoQzG0mth21qziKuhS7dD/AHddrpxAUNqWssDIGjXzqKoJSuQ
Content-Language: ko
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > On Mon, 26 Nov 2018 06:36:37 +0100,
> > > Chanho Min wrote:
> > > >
> > > > Commit 67ec1072b053 ("ALSA: pcm: Fix rwsem deadlock for non-atomic
> > > > PCM
> > > > stream") fixes deadlock for non-atomic PCM stream. But, This patch
> > > causes antother stuck.
> > > > If writer is RT thread and reader is a normal thread, the reader
> > > > thread will be difficult to get scheduled. It may not give chance
> > > > to release readlocks and writer gets stuck for a long time if they
> > > > are
> > > pinned to single cpu.
> > > >
> > > > The deadlock described in the previous commit is because the linux
> > > > rwsem queues like a FIFO. So, we might need non-FIFO writelock,
> > > > not non-
> > > block one.
> > > >
> > > > My suggestion is that the writer gives reader a chance to be
> > > > scheduled by using the minimum msleep() instaed of spinning
> > > > without blocking by writer. Also, The *_nonblock may be changed to
> > > > *_nonfifo appropriately
> > > to this concept.
> > > > In terms of performance, when trylock is failed, this minimum
> > > > periodic msleep will have the same performance as the tick-based
> > > schedule()/wake_up_q().
> > > >
> > > > Suggested-by: Wonmin Jung <wonmin.jung@lge.com>
> > > > Signed-off-by: Chanho Min <chanho.min@lge.com>
> > >
> > > Hrm, converting unconditionally with msleep() looks too drastic.
> >
> > Yes, it looks drastic. But, IMHO, I can't say busy-spin is not non-
> drastic.
> > To fix the root cause, We may need another rwsem that does not work as
> > a FIFO.
> 
> Right, but applying msleep(1) unconditionally is really bad.
> 
> > > I guess you've hit this while not explicitly using the linked PCM
> > > streams, i.e. in the call of snd_pcm_unlink() at close, right?
> > >
> > > Then this can be worked around by checking the link before calling it.
> > > Could you check the patch below?
> >
> > More testing is needed, but it seems to be fixed by your patch.
> > We may not use the linked PCM.
> 
> Then I'm sure that my patch papers over.
Thanks, Plz let me know when the patch is merged.

> 
> > But, If the linked PCM is enabled,  Can snd_pcm_unlink() be called?
> > This also seems to be a workaround.
> 
> Yes, for the linked streams, something else is needed *in addition*.
> 
> The original fix with busy loop also assumed that this code path (via
> snd_pcm_link() and snd_pcm_unlink()) is the rare occasion, and it didn't
> consider that it were called for regular use cases.  So the fix to make
> things just works for regular use cases without any artifact must be
> implemented in the first place.  The fix for the linked streams comes at
> next.  It might be like your msleep() change as a workaround, but in
> anyway it's far less urgency.

msleep is worst, but If it is harmless, can I apply my patch to the private
tree
temporarily until your next fix comes?
We may use the linked streams in the near future. It makes our product
unstable.
It's urgency for us. How is your opinion?

Thanks
Chanho

