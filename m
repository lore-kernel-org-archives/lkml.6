Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E211DECE561
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 03:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 993D021547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 03:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TYuXHdbJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 993D021547
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389042AbeIUIss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 04:48:48 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:40315 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbeIUIsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 04:48:47 -0400
Received: by mail-yw1-f67.google.com with SMTP id z143-v6so4644162ywa.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 20:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pyD3m6E5xpzzgx6cR5aSzJI3I2qIkiqcmrw12FtYyUA=;
        b=TYuXHdbJe0RBgK90gj1Yb0ScC3ZbfBO/AJ1UCb8S0xGExW4mvDkveDyN50fIA/JagA
         PtitRVPTGnlvjOkDGIvzbqtx/hfrqQqTKofjA3bopDKHRcTS55ibEuwJQGTkI7Jf4KkG
         16jjGvhYs0qQAMRtvM8rspSVZzeuwlqPqUXYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pyD3m6E5xpzzgx6cR5aSzJI3I2qIkiqcmrw12FtYyUA=;
        b=A7NE7Qf4i/6W5f4tErqHXjl9CnKej2//uG1tsUu/QRzOMdNZEvxGvZGtNZzJA1LZ1+
         Mok9YLtRbFsa3G81j9SjNtRkPbvV+QR6STK+ijIW92BmjLonC7oGDmBuHfDFQ8NTsOCG
         nZFK2VTS2DS3RbGq1RDLEzD0g7ArODcJAHZjSznSfWkegwY9VpoTd6br/kx5v4908cVS
         bNVaVaphAadVLhX97bzz4AbFChxrXKbDQSKA+9mnIde/3cYL5EXpeF9+3zNkyvaYIjbb
         uTJFIDl27IvNiBRAfYXuKq23PB8z5TCJTslSHKxBBnWRQ6uzdj0dUbwRwXUPFRGSWOnp
         1NWA==
X-Gm-Message-State: APzg51Dw2WD2RTjNZjTVqETFsw8Wuo8y5cbb1SqHEilKuT1cwS/VS9YY
        dQxG3BmAx51k0oTpArZQKH7rR/XFUQM=
X-Google-Smtp-Source: ANB0VdafW+t8yjVEG+jusfIq1++sYqcciaCDqvtPTox6VRfIaxMOXOe8KuV0u2rqTRQm6cLRLPizqw==
X-Received: by 2002:a81:4689:: with SMTP id t131-v6mr19653147ywa.496.1537498924026;
        Thu, 20 Sep 2018 20:02:04 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id j8-v6sm6071166ywj.6.2018.09.20.20.02.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 20:02:02 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id c4-v6so4854834ybl.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 20:02:02 -0700 (PDT)
X-Received: by 2002:a25:238d:: with SMTP id j135-v6mr2067179ybj.137.1537498921935;
 Thu, 20 Sep 2018 20:02:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Thu, 20 Sep 2018 20:02:01
 -0700 (PDT)
In-Reply-To: <74ecd4ec-491b-93d7-4e3f-46f92121130b@canonical.com>
References: <20180920162338.21060-1-keescook@chromium.org> <20180920162338.21060-27-keescook@chromium.org>
 <a0165ce9-d15b-eaef-a5e8-2aeb6bdc69f6@schaufler-ca.com> <CAGXu5j++wXMUXuqT7m5MZdeXqO=i7RgyKZoLwELfSTx6UPOVSA@mail.gmail.com>
 <7d2cc28b-aee5-ee91-9362-f92f8ca30adc@schaufler-ca.com> <6c899d9e-45aa-8159-c402-b3c4d1936112@canonical.com>
 <CAGXu5jKzqij5dY2FYm5rafPNPpF1Tx9BPmK+=FvG+=tpFxpscw@mail.gmail.com> <74ecd4ec-491b-93d7-4e3f-46f92121130b@canonical.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 20 Sep 2018 20:02:01 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+QhU2HOicYKqfNo17n9k6DKgt1upa3O2p1b5Gvn6icbQ@mail.gmail.com>
Message-ID: <CAGXu5j+QhU2HOicYKqfNo17n9k6DKgt1upa3O2p1b5Gvn6icbQ@mail.gmail.com>
Subject: Re: [PATCH security-next v2 26/26] LSM: Add all exclusive LSMs to
 ordered initialization
To:     John Johansen <john.johansen@canonical.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 7:14 PM, John Johansen
<john.johansen@canonical.com> wrote:
> On 09/20/2018 07:05 PM, Kees Cook wrote:
>> On Thu, Sep 20, 2018 at 6:39 PM, John Johansen
>> <john.johansen@canonical.com> wrote:
>>> On 09/20/2018 06:10 PM, Casey Schaufler wrote:
>>>> On 9/20/2018 5:45 PM, Kees Cook wrote:
>>>>> On Thu, Sep 20, 2018 at 5:25 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>>>> On 9/20/2018 9:23 AM, Kees Cook wrote:
>>>>>>>  config LSM_ORDER
>>>>>>>       string "Default initialization order of builtin LSMs"
>>>>>>> -     default "yama,loadpin,integrity"
>>>>>>> +     default "yama,loadpin,integrity,selinux,smack,tomoyo,apparmor"
>>>>>> If I want to compile all the major modules into my kernel and use
>>>>>> AppArmor by default would I use
>>>>>>
>>>>>>         default "yama,loadpin,integrity,apparmor,selinux,smack,tomoyo"
>>>>>>
>>>>>> or
>>>>>>
>>>>>>         default "yama,loadpin,integrity,apparmor"
>>>>> I was expecting the former, but the latter will have the same result.
>>>
>>> t find having the two be equivalent violates expectations. At least
>>> when considering the end goal of full/extreme stacking, its trivially
>>> the same with current major lsms being exclusive
>>
>> This mixes "enablement" with "ordering", though, and I think the past
>> threads have shown this to be largely problematic.
>>
>> However, with CONFIG_LSM_ENABLED, we get the effect you're looking for, IIUC.
>
> no, I was just stating in a world where we have full stacking those two
> are not equivalent, as I would assume the order of any lsm not listed
> may end up being different.

Right, the ordering would be defined first by runtime (lsm.order=)
followed any missing LSMs then ordered by their order in
CONFIG_LSM_ORDER=, followed by any still missing LSMs then ordered by
their order at link-time (which *may* be Makefile order, but could
change with LTO, etc).

>>>>>> When we have "blob-sharing" how could I compile in tomoyo,
>>>>>> but exclude it without a boot line option?
>>>>> Ooh, yes, this series has no way to do that. Perhaps
>>>>> CONFIG_LSM_DISABLE in the same form as CONFIG_LSM_ORDER? I would
>>>>> totally remove LoadPin's CONFIG for this in favor it.
>>>>
>>>> I would generally prefer an optional CONFIG_LSM_ENABLE to
>>>> CONFIG_LSM_DISABLE, but I understand the logic behind your
>>>> approach. I would be looking for something like
>>>>
>>> +1 on the CONFIG_LSM_ENABLE ove DISABLE
>>>
>>>> CONFIG LSM_ENABLE
>>>>       string "Default set of enabled LSMs"
>>>>       default ""
>>>>
>>>> as opposed to
>>>>
>>>> CONFIG LSM_DISABLE
>>>>       string "Default set of disabled LSMs"
>>>>       default ""
>>>>
>>>> where an empty string is interpreted as "use 'em all"
>>>> in either case.
>>
>> Yes, I like CONFIG_LSM_ENABLE if "empty" means "enable all". Should
>> CONFIG_LSM_ENABLE replace all the other CONFIG-based LSM
>> enabling/disabling?
>
> I don't particularly like "empty" being "enable all". With that
> how would I disable all builtin lsms so that I just boot with
> capability.
>
> An option of all or even * is more explicit and leaves the empty
> set to mean disable everything

Okay, that works. I prefer "all" FWIW.

-Kees

-- 
Kees Cook
Pixel Security
