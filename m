Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACD7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2EA120663
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfBYO4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 09:56:13 -0500
Received: from mga05.intel.com ([192.55.52.43]:8811 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727444AbfBYO4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 09:56:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2019 06:56:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,411,1544515200"; 
   d="scan'208";a="149791247"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.172])
  by fmsmga001.fm.intel.com with ESMTP; 25 Feb 2019 06:56:09 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [Intel-gfx] BUG: KASAN: use-after-free in intel_hdmi_destroy+0x79/0x80
In-Reply-To: <0df373d6-99e0-7509-1404-f3eadd9f23f7@xs4all.nl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <dc22722f-a55c-6160-6485-a02f3bb91836@infradead.org> <87y364q924.fsf@intel.com> <0df373d6-99e0-7509-1404-f3eadd9f23f7@xs4all.nl>
Date:   Mon, 25 Feb 2019 16:58:13 +0200
Message-ID: <87va17rk3e.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Feb 2019, Hans Verkuil <hverkuil@xs4all.nl> wrote:
> Hi Jani,
>
> On 2/25/19 2:40 PM, Jani Nikula wrote:
>> On Fri, 22 Feb 2019, Randy Dunlap <rdunlap@infradead.org> wrote:
>>> This is 5.0-rc7 on an old Toshiba Portege laptop.
>>> No hdmi or other external video.
>>>
>>> Linux dragon.dunlab 5.0.0-rc7mod #3 SMP PREEMPT Wed Feb 20 00:05:17 PST 2019 x86_64 x86_64 x86_64 GNU/Linux
>>>
>>> on openSUSE LEAP 15.0 distro.
>>>
>>> Full boot log is attached.
>> 
>> On a hunch, caused by 9c229127aee2 ("drm/i915: hdmi: add CEC notifier to
>> intel_hdmi") referencing the encoder in connector destroy hook. We
>> should probably move the cec_notifier_put() call in the encoder destroy
>> hook.
>
> So the intel_encoder_destroy function is/can be called before the 
> intel_hdmi_destroy function? Sounds odd. I would expect that the 
> connectors are destroyed before the encoders.
>
> In any case, I am happy to try it in another destroy hook, but I need
> advice which hook I should use and how I get to the cec_notifier from
> whatever structure pointer I have in that destroy hook.
>
> I tried to figure it out, but I became very confused :-)

It's... hairy.

Looks like in this case the destroy hook gets called via
drm_connector_free_work_fn() and __drm_connector_put_safe() the
documentation of which says, "Should only be used from the
connector_iter functions, where we never really expect to actually
release the connector when dropping our final reference."

Can and does happen anyway it seems. :/

BR,
Jani.

-- 
Jani Nikula, Intel Open Source Graphics Center
