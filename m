Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBFEC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D512C25DCD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="J3piKh3M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D512C25DCD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755365AbeFYQHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 12:07:07 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:38464 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755078AbeFYQHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 12:07:04 -0400
Received: by mail-pg0-f67.google.com with SMTP id c9-v6so6272274pgf.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 09:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=r1RPv17L4++qu86la0K0F4j7zBMOUnwka3AIC53pU/0=;
        b=J3piKh3MrlafDPR8KwlmUJH8oUZQL5pEQ0nbhgnVht8gSg3vMUSFhpfYaWIrVkV8qy
         CHx79E7s9s5BJtpu+dVx2nODIHOLyywFlPgTc/Hn9GLxH6f7t4fXt8h419CluQNwmWez
         Byt1ElmflrStQw7LeRVoe9cTYwKamZfXx6QH0dFaZMn9VTO+j/rCyyORhhzU41AqxjMQ
         Smn3lf1eRXZOZ+97VMpBa0CYklB56IIv16GojQQcw2fSmdTX53Mv77CkeakJqk4r6lbr
         x4V6q8IaRAlBi4WWGw6LVXUG3QbF+l7NPdynhN7YZvI+Q/oMxXrXc5aEOmkrJz8jiSMQ
         KI5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=r1RPv17L4++qu86la0K0F4j7zBMOUnwka3AIC53pU/0=;
        b=Wrd2Acrw1FXEzhEw82hvr9mc+JPWlV/pWWHR3Y11GCVeCo+2s98ul/rwnEIGzQvXVm
         1AytqHFmH+RlNaYS5Ij9NEu7yKrkihF4aXmP7p2NbLHCW/bkk0sZqTrx9AxB6+xqKt5Z
         Zw8BtiHoXccJJQNwhGeTnC4WXc/QXztuDC7I/DFVMv+rrLIYNNKC09JMO/2sIP3WlNhr
         vUULI5OkkYoncjpahv7kN+5azcJTGvaisPB1yGWQDVNI4Mj54Kr+S/dwjKNvYgul06EG
         iWzNuiY3082U9TcyfVBiSEVD5j9ThoVbYlqBhBgr37FyFTuDchGfyA0w90OplIZXAwb7
         jFxg==
X-Gm-Message-State: APt69E3ph60NBIkjO7R1SeevSEwR4K2Ost1H0827dsNSEOVjluBsHuR/
        7+H5/ms8AnmO/lGts7VTmo/DzA==
X-Google-Smtp-Source: ADUXVKJbJeddA3qRul0n1EDMaj/Wld+FMprK+Q0IA7c4I8j+eQJYgyYGg819/T7xUr4JJKQRGzH6zw==
X-Received: by 2002:a62:ab0e:: with SMTP id p14-v6mr13575881pff.211.1529942823720;
        Mon, 25 Jun 2018 09:07:03 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1611:6077:8eec:bc7e:d0f4])
        by smtp.googlemail.com with ESMTPSA id v13-v6sm35066280pfa.131.2018.06.25.09.07.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 09:07:03 -0700 (PDT)
Subject: Re: [PATCH v4] overlayfs: override_creds=off option bypass
 creator_cred
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-doc@vger.kernel.org
References: <20180622171605.52989-1-salyzyn@android.com>
 <CAOQ4uxiUaJHZ5coUNwH1ZYQjVB8dmAo0Y0bDKOmZM81tzCqC8g@mail.gmail.com>
From:   Mark Salyzyn <salyzyn@android.com>
Message-ID: <058082af-c3cd-9d0a-8d5c-1999703342d0@android.com>
Date:   Mon, 25 Jun 2018 09:07:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxiUaJHZ5coUNwH1ZYQjVB8dmAo0Y0bDKOmZM81tzCqC8g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/22/2018 11:46 PM, Amir Goldstein wrote:
> Mark,
>
> Thanks for the properly documented patch, but this documentation it
> missing the caveats of this config option and there are severe caveats
> as was discussed on earlier version of the patch.
>
> You should mention the not so minor detail that this option can result
> in inability to delete files/directories from overlay and there me be other
> side effects. This is one of those features that should be warning
> unconditionally that user should really know what user is doing
Agreed, I would like to prevent it becoming a treatise ...

The upperdir tree should match the privileges of the lower tree, and in 
Android that is enforced by a hard-coded built-in map (fs_config for 
DAC, restorecon map for MAC) for the caller writers that never causes 
unexpected adjustments (famous last wurds). The active 
(writers/creators) callers have _more_ privileges than init 
(creator/mounter), and are only available on development (userdebug) 
builds. All else are passive (readers), and although less privileged 
than init, have demonstrable read MAC privs where init does not.
> You did not address my concern that the test for setting trusted xattr
> on mount (ovl_make_workdir) should emit a different kind of warning
> when override_creds=off. In fact, I think it should emit a warning
> when override_creds=off unconditionally to indicate that weird things
> can be expected and we "really hope you know what you are doing".
>
> A new security concern I just noticed - overlayfs calls some vfs
> functions directly to perform operations that are typically not
> allowed to unprivileged users without checking credentials.
> In those cases your patch introduces a security vulnerability.
>
> Examples:
> - overlayfs calls exportfs_decode_fh() on underlying
> fs without checking CAP_DAC_READ_SEARCH
> - overlayfs calls vfs_whiteout() which calls underlying fs mknod
> without checking CAP_MKNOD
>
> Those examples could be easily fixed and you may righfully
> claim that they are bugs, but the fact is that those "bugs" are
> harmless until someone creates an irregular security model
> without capabilities to mount, without capability to mknod.
>
> What's worse is that you have to audit the overlayfs code and
> find all these potential bugs and fix them before changing the
> assumptions that were made over the years about mounter
> credentials.
Thanks, _this_ is what a good review is all about. I will need a deeper 
dive (b/c I did not see these) into all the 'command paths' to determine 
any missed/assumed checks. In Android, all the 'caller' issues I have 
with the existing checks are passive (read), and I would _hate_ to be 
providing them (unchecked and assumed) DAC privileges. In Android, it is 
simpler, they would not pass the first barriers, to the internal assumed 
points in any case, but multilevel security _requires_ us to recheck. 
The active (create/write) callers are few and trusted, but _should_ be 
checked w/o assumption (eg: if 'adb push' is not granted CAP_MKNOD, it 
should be blocked).
> Thanks,
> Amir.

Sincerely -- Mark Salyzyn


