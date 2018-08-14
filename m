Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD219C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 21:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8879E216F9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 21:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Bshx6jqk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8879E216F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731260AbeHOAjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 20:39:09 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:35839 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728080AbeHOAjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 20:39:09 -0400
Received: by mail-yw1-f65.google.com with SMTP id s68-v6so17395619ywg.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 14:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TvTM1FZBAS/0f5S9VCXZt+ETCtg8eHLiqbc4OUkzREs=;
        b=Bshx6jqkld0ogK8tI8Ybn8WhozQsIkltgNiPRgouT3CachEQbOhmF+YF0gjyG0TFMp
         AdVDC9yELTMJptOiOiRhaAyFrAK1AstBEUWVCU9IHxcE+uP4HGeE9fEp6EMCSgRd0qKI
         OchXp9wX3QgPBdFaduaJQk3ZsGqU+7WbegAic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TvTM1FZBAS/0f5S9VCXZt+ETCtg8eHLiqbc4OUkzREs=;
        b=Cp7RN8mWxK42KQuEEy1WjjRlA/SVoN+jRszuKAJ5L+xgXJk5p4wQPfsrrpG5IT9Qe0
         Xu83HS+H6OAiHn7bmuiAbHl/cOY718cZRdg/PRNa8URtHX/1dbQMqfjmpw2x5xdEctuw
         +hHW56eA1WQIczzte8Ct6rZyQkeAZ0GaXzcqs9aZWymjoeqJ0x/Fw8sFPsEIIj7yRsxs
         sQEqGPXnBfuM6PJ+vghFIhz8Pvzc7GDDYzkj8BAvuDyGg1BK53vRVwSb+mOAkmcvbDQU
         +cwN5ivfRgUKDlnXTMOEWGwce95doXnV48CfT2l8dEAvNEmdCgZqxiZMgvS5VOR43Juw
         tJBA==
X-Gm-Message-State: AOUpUlE4SrIFYfWzt80/2w5HHNUP5A63UcFLIJGpzujwNvyY1USyRbpJ
        Q4eL4Oac/6KfxPUahOC4XHrPHfnGv2M=
X-Google-Smtp-Source: AA+uWPy8c+1jQxEMBbKIt7lxrfiXJxzIwvS2ZZq4aURjsv9XQvJjxDcNvN3gqxg14Fc0wLAo3iBbhg==
X-Received: by 2002:a25:f406:: with SMTP id q6-v6mr12260716ybd.460.1534283398065;
        Tue, 14 Aug 2018 14:49:58 -0700 (PDT)
Received: from mail-yw1-f44.google.com (mail-yw1-f44.google.com. [209.85.161.44])
        by smtp.gmail.com with ESMTPSA id f82-v6sm15285529ywf.58.2018.08.14.14.49.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 14:49:56 -0700 (PDT)
Received: by mail-yw1-f44.google.com with SMTP id r184-v6so17397115ywg.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 14:49:56 -0700 (PDT)
X-Received: by 2002:a25:b219:: with SMTP id i25-v6mr13820509ybj.112.1534283395623;
 Tue, 14 Aug 2018 14:49:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cc84:0:0:0:0:0 with HTTP; Tue, 14 Aug 2018 14:49:54
 -0700 (PDT)
In-Reply-To: <CAJuCfpEX69Sbd=0i0ismP6q2NsZGUF4gMSCr1G5NdXd3n1NyZA@mail.gmail.com>
References: <20180813223910.26276-1-surenb@google.com> <20180814095413.vbjkcjkmytkffyaz@mwanda>
 <CAJuCfpF0Y6wc1z-rbn2wdWROgc_FkD2EX5HzDMcZ1oB5Z=dXSw@mail.gmail.com>
 <CAJuCfpHSZuabLr6+t_n7UDamJCAP6EPTNEZ6kNqWOhk2mpYADg@mail.gmail.com>
 <CAGXu5jKqcpbpG0Ky4-yXV4d5q10HtGwJtdyPKcrwkJUPhA_Mpg@mail.gmail.com> <CAJuCfpEX69Sbd=0i0ismP6q2NsZGUF4gMSCr1G5NdXd3n1NyZA@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 14 Aug 2018 14:49:54 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJB9wMDJnfsurpxsXm6_0WsWWCaTuWBfy+3aMSE_LL9Rw@mail.gmail.com>
Message-ID: <CAGXu5jJB9wMDJnfsurpxsXm6_0WsWWCaTuWBfy+3aMSE_LL9Rw@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFC: Fix possible memory corruption when handling
 SHDLC I-Frame commands
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Security Officers <security@kernel.org>,
        Kevin Deus <kdeus@google.com>,
        Samuel Ortiz <sameo@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Allen Pais <allen.pais@oracle.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 1:55 PM, Suren Baghdasaryan <surenb@google.com> wrote:
> On Tue, Aug 14, 2018 at 1:33 PM, Kees Cook <keescook@chromium.org> wrote:
>> On Tue, Aug 14, 2018 at 1:26 PM, Suren Baghdasaryan <surenb@google.com> wrote:
>>> On Tue, Aug 14, 2018 at 9:57 AM, Suren Baghdasaryan <surenb@google.com> wrote:
>>>> On Tue, Aug 14, 2018 at 2:54 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>>>>> Thanks.  This is great.  I'm so glad these are finally getting fixed.
>>>>>
>>>>> Do we need to fix nfc_hci_msg_rx_work() and nfc_hci_recv_from_llc() as
>>>>> well?  In nfc_hci_recv_from_llc() we allow pipe to be NFC_HCI_FRAGMENT
>>>>> (0x7f) so that's one element beyond the end of the array and the
>>>>> NFC_HCI_HCP_RESPONSE isn't checked.
>>>>>
>>>>> Also nci_hci_msg_rx_work() and nci_hci_data_received_cb() use
>>>>> NCI_HCP_MSG_GET_PIPE() so those could be off by one.
>>>>
>>>> Good point. From hci.h:
>>>>
>>>> /*
>>>>  * According to specification 102 622 chapter 4.4 Pipes,
>>>>  * the pipe identifier is 7 bits long.
>>>>  */
>>>> #define NFC_HCI_MAX_PIPES 127
>>>>
>>>> And then:
>>>>
>>>> struct nfc_hci_dev {
>>>>   ...
>>>>   struct nfc_hci_pipe pipes[NFC_HCI_MAX_PIPES];
>>>>   ...
>>>> }
>>>>
>>>> I think the correct fix would be to change it to:
>>>>
>>>>   struct nfc_hci_pipe pipes[NFC_HCI_MAX_PIPES + 1];
>>>>
>>>> What do you think?
>>>>
>>>
>>> Just to be clear, this would fix the problem Dan described in his
>>> reply and it should be implemented in a separate patch. The original
>>> fix is still valid.
>>
>> I think you could merge the fixes into a single patch.
>
> Couple reasons I would prefer to keep them separate:
> - I feel that descriptions for these two issues should be different
> and it's easier if we don't mix them up
> - This one is already merged into Android kernels, so would be easier
> to introduce the second fix separately
> - I would like to give credit to people who noticed the problem (in
> this case those are different people)
>
> However if more people think we should fix both issues in the same
> patch I'll happily do that.
> Thanks!

If it's already landed separately somewhere else, then yeah, 2 patches
sounds good. No objection either way from me!

-Kees

-- 
Kees Cook
Pixel Security
