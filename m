Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC17C5CFC1
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 00:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14975208DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 00:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="NJKwfQgK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14975208DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936534AbeFPA4v (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 20:56:51 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:39802 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936470AbeFPA4t (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 20:56:49 -0400
Received: by mail-vk0-f68.google.com with SMTP id r83-v6so6665825vkf.6
        for <Linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 17:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NKhvtpJ6iO/c8QqDFdx+TkrAWfegvUX5ktQ84DfjVJI=;
        b=NJKwfQgKeMXA069zDat3nY2CBLN6QePjJ8vML4C5N0kX4AwPExazUDNTrL8nDeqv5r
         io2V8Xy6qBNs9/vNmuSdDz4kCOPlxL+wHMd4JBsGQamZM/yt0x9asS7K2jlvLEUTJcnM
         uhw3cm7XSe55Jq/rhfNEupATX+glYoGtyZktoEhhkEJsK8SZimpHV9wCDpYO9Zp+dGMb
         s4OXnvsYqw/DnRlO8uTsN4AH++/al3TRCW2HfHjf4dzoMep21rdfak0o492gbVKQbwEi
         mIurnTnpcjt6rZGqPiqITsoE5EWLv5Ki3r85bRtna9P7FSffdOvYlHlh0bAG3QmC8SbX
         udQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NKhvtpJ6iO/c8QqDFdx+TkrAWfegvUX5ktQ84DfjVJI=;
        b=g07XdJSPPczGHSF68zCUcWYsXL/qqqXd3cJvIwMvxyy1eIuDgU8PX4WsxYaZ86jaf+
         Gy2yLYgNrm/LbYIRzCXBGIY7DDLg0icCxZlbCpdQrgh05RCf/bkZd5Mj41yC6SCND3is
         NobnNFEKkKQLaZe/z996BwzyCagW3N3Z36zb2h00cp6M5ugEAwvZ6HZ3MEoCFM7pd8+7
         fbfUd7LTf/7neIoBqWQLtwiBAGLxw77s94Ocox2eOGx0i3XRxAFWEuEC3h0ueBya5+++
         UohGE600BQGZJrNdtA9MJJQjR7gmzlKMapTPvvkKxwNRIlH3YuXqqDfKfVAL7IWd493i
         K0ZA==
X-Gm-Message-State: APt69E1HCie29q4gvpIulmYzWtodvHg3KgKInMQcPzzXZgYf5hgVWy3y
        cJ2SFcbZXivLMTm8mWjPX1xcCtywIvuR5Pa3ZctuDg==
X-Google-Smtp-Source: ADUXVKJjO/zaaZHkudp7gd7KwZsa/1BscXqLk7Xx3vfL7Kv5DrHMHFeCVUL1KiH+3o0bj30RUVsBRQzyW4SK8tyfT/E=
X-Received: by 2002:a1f:58c:: with SMTP id 134-v6mr2288784vkf.55.1529110608875;
 Fri, 15 Jun 2018 17:56:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:11c9:0:0:0:0:0 with HTTP; Fri, 15 Jun 2018 17:56:48
 -0700 (PDT)
In-Reply-To: <9b3259e8-1d07-adb1-a57c-8b276c133aa6@linux.intel.com>
References: <1529057003-2212-1-git-send-email-yao.jin@linux.intel.com>
 <CAP045Aq_FEc_pEeRL86uXbOLBeW7aPvTqtnaq+Mbi-2=vp2BNA@mail.gmail.com>
 <1a442b37-7a97-86f0-11e3-58d940ecfbc9@linux.intel.com> <CAP045ApFKUqUUf76GtWyxpYWdWe1RxYkPm1R2kUxaQyc4Fhucg@mail.gmail.com>
 <CAOp6jLadgwdiW+1BNFFhNSBD-i1ACju4PeuozxvD26Mrekwd9w@mail.gmail.com> <9b3259e8-1d07-adb1-a57c-8b276c133aa6@linux.intel.com>
From:   Kyle Huey <me@kylehuey.com>
Date:   Fri, 15 Jun 2018 17:56:48 -0700
Message-ID: <CAP045ApiQpOdgqK-Wn-2scsu5WycPYmSTQtoHGkviuwuhs5jDg@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] perf: Drop leaked kernel samples
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     "Robert O'Callahan" <robert@ocallahan.org>, acme@kernel.org,
        jolsa@kernel.org, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        open list <Linux-kernel@vger.kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Will Deacon <will.deacon@arm.com>,
        Stephane Eranian <eranian@google.com>,
        Namhyung Kim <namhyung@kernel.org>, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 5:50 PM, Jin, Yao <yao.jin@linux.intel.com> wrote:
> Hi All,
>
> This patch raised many questions, I was prepared. :)
>
> I'd like to try another proposal that it adds a special flag in the returned
> perf_sample_data to indicate the perf binary that this sample is a leaked
> sample.
>
> For example, create a new PERF_SAMPLE_RETURN_LEAKAGE in
> perf_event_sample_format.
>
> In perf_prepare_sample(),
>
> if (event->attr.exclude_kernel && !user_mode(regs))
>         data->type |= PERF_SAMPLE_RETURN_LEAKAGE;
>
> Now all the samples are kept and the leaked kernel samples are tagged with
> PERF_SAMPLE_RETURN_LEAKAGE.
>
> In perf binary, it filters out the samples with PERF_SAMPLE_RETURN_LEAKAGE.
> It needs perf binary modification but rr doesn't need to be changed.
>
> I don't 0-stuffing some fields because:
>
> 1. Keeping the skid info should allow us to look at that if we have
> interesting later.
>
> 2. Not sure if 0-stuffing some fields has potential conflicts with some
> applications.
>
> Is this proposal reasonable?
>
> Thanks
> Jin Yao
>
>
> On 6/16/2018 1:34 AM, Robert O'Callahan wrote:
>>
>> On Fri, Jun 15, 2018 at 10:16 AM, Kyle Huey <me@kylehuey.com> wrote:
>>>
>>>
>>> If you want a sysctl for your own reasons that's fine. But we don't
>>> want a sysctl. We want to work without any further configuration.
>>
>>
>> Also toggling a sysctl would require root privileges, but rr does not
>> currently need to run as root. Thus rr users would have to either
>> permanently change their system configuration (and every extra
>> configuration step is a pain), or run rr as root so rr can toggle the
>> sysctl itself. Running rr as root is highly undesirable.
>>
>> Rob
>>
>

If the problem you're trying to fix is an inappropriate disclosure of
kernel-space information to user-space, how does filtering the samples
in user space solve anything?

- Kyle
