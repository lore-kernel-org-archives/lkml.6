Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5682C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 22:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61FB4206B2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 22:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kY92xw1k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61FB4206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbeJBFHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 01:07:44 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:45185 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbeJBFHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 01:07:43 -0400
Received: by mail-yb1-f195.google.com with SMTP id d9-v6so6319358ybr.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 15:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qiWHG4Dgx9fa+Wn3UGykfw3svCqVxxYaSRv8xlRJIC0=;
        b=kY92xw1khe3By6mw0Xem4VGnQPNeu2dBNvwIvCFWa2ivWBXfRQBI8i0SBm4t9jprju
         H6BUKDPtv8yqZ9DQ2KGyIThPW4E/QwSWrL+boVdxYXDskW6AHkQDUvSo67LnD+oowNtF
         3tstWJme0Hkz9uGAYMGGDuz8gPpSeEpSrQwKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qiWHG4Dgx9fa+Wn3UGykfw3svCqVxxYaSRv8xlRJIC0=;
        b=P4I42mNNyPNtcqlKjpJ2YrEbvTyF4CT4uFsN2ObR56s2iUWggAPm2UchKpno3jJKYA
         EYbqRmSPUkBl2/TRr2bjo5nIzskIFIO9JmrNFgqG+89WolGfdQpcd2FH09HiY/X4OiOK
         iPAng+UqosnqWa/lDQYXwhTWu5j0pNFDoFUp99YxMVisdKIrJMu9s7a3867fa5HHeZ4V
         yKYi8hp/u3OG824L63hUhO6M/+vA/FqrgZZ6ByseZfIyuL9zLexWQRLdYafh2FzfvJ0A
         KxpIRKKw0errRtRD9TVU8qXffegvLfBKbJvvU4xEHz4Gdh7TCwTQX7o9ugaJrz4U+rmT
         KfdA==
X-Gm-Message-State: ABuFfoirCtiNoiD8jOwQNt3ydRy0DZ48qOnw8yhB2nat8Hu8Buvv1K3S
        VY4ekFNiV4gLka94+Nrp6Mdh2dFHZXg=
X-Google-Smtp-Source: ACcGV611V4bhtK5988CVWzKVqE6k/Gt5dMs5P9gSnYiHUg9qhEa4YnxnXFr+T/H0rCsb2pJE2906bw==
X-Received: by 2002:a25:5107:: with SMTP id f7-v6mr2624093ybb.438.1538432863041;
        Mon, 01 Oct 2018 15:27:43 -0700 (PDT)
Received: from mail-yw1-f54.google.com (mail-yw1-f54.google.com. [209.85.161.54])
        by smtp.gmail.com with ESMTPSA id o202-v6sm33760713ywo.38.2018.10.01.15.27.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 15:27:42 -0700 (PDT)
Received: by mail-yw1-f54.google.com with SMTP id v198-v6so1360297ywg.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 15:27:41 -0700 (PDT)
X-Received: by 2002:a81:1194:: with SMTP id 142-v6mr7226725ywr.168.1538432861376;
 Mon, 01 Oct 2018 15:27:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Mon, 1 Oct 2018 15:27:40 -0700 (PDT)
In-Reply-To: <68e4e323-3216-7e77-2807-c3207126ae68@canonical.com>
References: <20180925001832.18322-1-keescook@chromium.org> <20180925001832.18322-19-keescook@chromium.org>
 <68e4e323-3216-7e77-2807-c3207126ae68@canonical.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 1 Oct 2018 15:27:40 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+jzmFh-iuXDVHQTq7e=mftpfaqS-45TP_UR3B+qtGcLQ@mail.gmail.com>
Message-ID: <CAGXu5j+jzmFh-iuXDVHQTq7e=mftpfaqS-45TP_UR3B+qtGcLQ@mail.gmail.com>
Subject: Re: [PATCH security-next v3 18/29] LSM: Introduce lsm.enable= and lsm.disable=
To:     John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     James Morris <jmorris@namei.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
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

On Mon, Oct 1, 2018 at 2:46 PM, John Johansen
<john.johansen@canonical.com> wrote:
> On 09/24/2018 05:18 PM, Kees Cook wrote:
>> This introduces the "lsm.enable=..." and "lsm.disable=..." boot parameters
>> which each can contain a comma-separated list of LSMs to enable or
>> disable, respectively. The string "all" matches all LSMs.
>>
>> This has very similar functionality to the existing per-LSM enable
>> handling ("apparmor.enabled=...", etc), but provides a centralized
>> place to perform the changes. These parameters take precedent over any
>> LSM-specific boot parameters.
>>
>> Disabling an LSM means it will not be considered when performing
>> initializations. Enabling an LSM means either undoing a previous
>> LSM-specific boot parameter disabling or a undoing a default-disabled
>> CONFIG setting.
>>
>> For example: "lsm.disable=apparmor apparmor.enabled=1" will result in
>> AppArmor being disabled. "selinux.enabled=0 lsm.enable=selinux" will
>> result in SELinux being enabled.
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>
> I don't like this. It brings about conflicting kernel params that are
> bound to confuse users. Its pretty easy for a user to understand that
> when they specify a parameter manually at boot, that  it overrides the
> build time default. But conflicting kernel parameters are a lot harder
> to deal with.
>
> I prefer a plain enabled= list being an override of the default build
> time value. Where conflicts with LSM-specific configs always result in
> the LSM being disabled with a complaint about the conflict.
>
> Though I have yet to be convinced its worth the cost, I do recognize
> it is sometimes convenient to disable a single LSM, instead of typing
> in a whole list of what to enable. If we have to have conflicting
> kernel parameters I would prefer that the conflict throw up a warning
> and leaving the LSM with the conflicting config disabled.

Alright, let's drill down a bit more. I thought I had all the
requirements sorted out here. :)

AppArmor and SELinux are "special" here in that they have both:

- CONFIG for enable-ness
- boot param for enable-ness

Now, the way this worked in the past was that combined with
CONFIG_DEFAULT_SECURITY and the link-time ordering, this resulted in a
way to get the LSM enabled, skipped, etc. But it was highly CONFIG
dependent.

SELinux does:

#ifdef CONFIG_SECURITY_SELINUX_BOOTPARAM
int selinux_enabled = CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE;

static int __init selinux_enabled_setup(char *str)
{
        unsigned long enabled;
        if (!kstrtoul(str, 0, &enabled))
                selinux_enabled = enabled ? 1 : 0;
        return 1;
}
__setup("selinux=", selinux_enabled_setup);
#else
int selinux_enabled = 1;
#endif
...
        if (!security_module_enable("selinux")) {
                selinux_enabled = 0;
                return 0;
        }

        if (!selinux_enabled) {
                pr_info("SELinux:  Disabled at boot.\n");
                return 0;
        }


AppArmor does:

/* Boot time disable flag */
static bool apparmor_enabled = CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE;
module_param_named(enabled, apparmor_enabled, bool, S_IRUGO);

static int __init apparmor_enabled_setup(char *str)
{
        unsigned long enabled;
        int error = kstrtoul(str, 0, &enabled);
        if (!error)
                apparmor_enabled = enabled ? 1 : 0;
        return 1;
}

__setup("apparmor=", apparmor_enabled_setup);
...
        if (!apparmor_enabled || !security_module_enable("apparmor")) {
                aa_info_message("AppArmor disabled by boot time parameter");
                apparmor_enabled = false;
                return 0;
        }


Smack and TOMOYO each do:

        if (!security_module_enable("smack"))
                return 0;

        if (!security_module_enable("tomoyo"))
                return 0;


Capability, Integrity, Yama, and LoadPin always run init. (This series
fixes LoadPin to separate enable vs enforce, so we can ignore its
"enable" setting, which isn't an "am I active?" boolean -- its init
was always run.) With the enable logic is lifted out of the LSMs, we
want to have "implicit enable" for 6 of 8 of the LSMs. (Which is why I
had originally suggested CONFIG_LSM_DISABLE, since the normal state is
enabled.) But given your feedback, I made this "implicit disable" and
added CONFIG_LSM_ENABLE instead. (For which "CONFIG_LSM_ENABLE=all"
gets the same results.)


I think, then, the first question (mainly for you and Paul) is:

Should we remove CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE and
CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE in favor of only
CONFIG_LSM_ENABLE?

The answer will affect the next question: what should be done with the
boot parameters? AppArmor has two ways to change enablement:
apparmor=0/1 and apparmor.enabled=0/1. SELinux just has selinux=0/1.
Should those be removed in favor of "lsm.enable=..."? (And if they're
not removed, how do people imagine they should interact?)

Thanks!

-Kees

-- 
Kees Cook
Pixel Security
