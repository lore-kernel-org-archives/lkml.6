Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89621C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 04:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4467C20684
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 04:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q4hUwcKU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4467C20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbeJBL27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 07:28:59 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:32847 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbeJBL27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 07:28:59 -0400
Received: by mail-yb1-f193.google.com with SMTP id u88-v6so294127ybi.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 21:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Cpxv9Irzh5aDs0QGpKP7cNXs2u6/amX9TqmHjX6gKyU=;
        b=Q4hUwcKUWLe6OAegh5LekwopNJDP3KItLdEIlUooMI7FhelnmlTg0yAeXderwxn9Ru
         rOas1qDRMp+cjcnuplYzNeWaliK98coqpeWFmaXZDjxrhSbI5nW+lPrVu78OcE9B+pfq
         0EtjiyCbV8Ed5o7kYejZsaDides859g/5NDDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Cpxv9Irzh5aDs0QGpKP7cNXs2u6/amX9TqmHjX6gKyU=;
        b=sqGCP7lo0K4QI2zMnVjaTJVlrbTOevlpUTk7br3bluvP8zz0CoZkTIRALcSmOesYw0
         i/C5ZQQ0J8Ht7rax5iERNNbJQW5NsLdy+P3dAaZE6yWjEgGtN0qa1rTKGN4YjE1VwtfD
         q/wCUrIOUxYxOTANFyq/Ae9h7jy/S3VDIPAA/iiQT6y89CFgR9YiOBUl3fyqnQQqIbXW
         Xcmwu+9aujDHvbEbYbJwsE1Xmu7HxDqE9i29TmS0uT4DEnz5G6VmoE7czzi5qVv9jkNv
         VGA5gIqbrvWpEzMBRYF1NX4yZqQEa8ePhWlTKd+8exPpPfOa2jK6F4wVPF+NRzwNrJGg
         0m+w==
X-Gm-Message-State: ABuFfojxeAOcAnHTSq/JS3GhACEZN1oUfeY9J8LP+c1X3fl0rx1gZuPf
        Fuulo/M480p3QhFR8h6HSWjo0nC7fs0=
X-Google-Smtp-Source: ACcGV61qDGv/tudJ9WMtWa1x02pwJGnMaBH93r7b+veWG61RfPBs6OvfAFXvlE0+TbsSeKaVkhsQEQ==
X-Received: by 2002:a25:d2d6:: with SMTP id j205-v6mr7530244ybg.470.1538455662698;
        Mon, 01 Oct 2018 21:47:42 -0700 (PDT)
Received: from mail-yw1-f52.google.com (mail-yw1-f52.google.com. [209.85.161.52])
        by smtp.gmail.com with ESMTPSA id p185-v6sm2746071ywc.14.2018.10.01.21.47.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 21:47:41 -0700 (PDT)
Received: by mail-yw1-f52.google.com with SMTP id a197-v6so262330ywh.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 21:47:40 -0700 (PDT)
X-Received: by 2002:a0d:fec6:: with SMTP id o189-v6mr7732638ywf.237.1538455660237;
 Mon, 01 Oct 2018 21:47:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Mon, 1 Oct 2018 21:47:39 -0700 (PDT)
In-Reply-To: <0d76adea-93b9-9512-a57b-8605b7928bc2@infradead.org>
References: <20181002005505.6112-1-keescook@chromium.org> <20181002005505.6112-14-keescook@chromium.org>
 <0d76adea-93b9-9512-a57b-8605b7928bc2@infradead.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 1 Oct 2018 21:47:39 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+SwjKEFURa2ijYNkUYNj4jVd15QWj-u6cfpU-jVrjoew@mail.gmail.com>
Message-ID: <CAGXu5j+SwjKEFURa2ijYNkUYNj4jVd15QWj-u6cfpU-jVrjoew@mail.gmail.com>
Subject: Re: [PATCH security-next v4 13/32] LoadPin: Rename "enable" to "enforce"
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     James Morris <jmorris@namei.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
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

On Mon, Oct 1, 2018 at 6:06 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 10/1/18 5:54 PM, Kees Cook wrote:
>> LoadPin's "enable" setting is really about enforcement, not whether
>> or not the LSM is using LSM hooks. Instead, split this out so that LSM
>> enabling can be logically distinct from whether enforcement is happening
>> (for example, the pinning happens when the LSM is enabled, but the pin
>> is only checked when "enforce" is set). This allows LoadPin to continue
>
> ISTB:             when "enforcing" is set).  ??

Whoops, thanks. And I need to do s/enable/enabled/ in the log. I'll fix this up.

-Kees

>
>> to operate sanely in test environments once LSM enable/disable is
>> centrally handled (i.e. we want LoadPin to be enabled separately from
>> its enforcement).
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
>> Reviewed-by: John Johansen <john.johansen@canonical.com>
>> ---
>>  security/loadpin/Kconfig   |  4 ++--
>>  security/loadpin/loadpin.c | 21 +++++++++++----------
>>  2 files changed, 13 insertions(+), 12 deletions(-)
>>
>> diff --git a/security/loadpin/Kconfig b/security/loadpin/Kconfig
>> index dd01aa91e521..8653608a3693 100644
>> --- a/security/loadpin/Kconfig
>> +++ b/security/loadpin/Kconfig
>> @@ -10,10 +10,10 @@ config SECURITY_LOADPIN
>>         have a root filesystem backed by a read-only device such as
>>         dm-verity or a CDROM.
>>
>> -config SECURITY_LOADPIN_ENABLED
>> +config SECURITY_LOADPIN_ENFORCING
>>       bool "Enforce LoadPin at boot"
>>       depends on SECURITY_LOADPIN
>>       help
>>         If selected, LoadPin will enforce pinning at boot. If not
>>         selected, it can be enabled at boot with the kernel parameter
>> -       "loadpin.enabled=1".
>> +       "loadpin.enforcing=1".
>> diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
>> index 0716af28808a..d8a68a6f6fef 100644
>> --- a/security/loadpin/loadpin.c
>> +++ b/security/loadpin/loadpin.c
>> @@ -44,7 +44,7 @@ static void report_load(const char *origin, struct file *file, char *operation)
>>       kfree(pathname);
>>  }
>>
>> -static int enabled = IS_ENABLED(CONFIG_SECURITY_LOADPIN_ENABLED);
>> +static int enforcing = IS_ENABLED(CONFIG_SECURITY_LOADPIN_ENFORCING);
>>  static struct super_block *pinned_root;
>>  static DEFINE_SPINLOCK(pinned_root_spinlock);
>>
>> @@ -60,8 +60,8 @@ static struct ctl_path loadpin_sysctl_path[] = {
>>
>>  static struct ctl_table loadpin_sysctl_table[] = {
>>       {
>> -             .procname       = "enabled",
>> -             .data           = &enabled,
>> +             .procname       = "enforcing",
>> +             .data           = &enforcing,
>>               .maxlen         = sizeof(int),
>>               .mode           = 0644,
>>               .proc_handler   = proc_dointvec_minmax,
>> @@ -97,7 +97,7 @@ static void check_pinning_enforcement(struct super_block *mnt_sb)
>>                                          loadpin_sysctl_table))
>>                       pr_notice("sysctl registration failed!\n");
>>               else
>> -                     pr_info("load pinning can be disabled.\n");
>> +                     pr_info("enforcement can be disabled.\n");
>>       } else
>>               pr_info("load pinning engaged.\n");
>>  }
>> @@ -128,7 +128,7 @@ static int loadpin_read_file(struct file *file, enum kernel_read_file_id id)
>>
>>       /* This handles the older init_module API that has a NULL file. */
>>       if (!file) {
>> -             if (!enabled) {
>> +             if (!enforcing) {
>>                       report_load(origin, NULL, "old-api-pinning-ignored");
>>                       return 0;
>>               }
>> @@ -151,7 +151,7 @@ static int loadpin_read_file(struct file *file, enum kernel_read_file_id id)
>>                * Unlock now since it's only pinned_root we care about.
>>                * In the worst case, we will (correctly) report pinning
>>                * failures before we have announced that pinning is
>> -              * enabled. This would be purely cosmetic.
>> +              * enforcing. This would be purely cosmetic.
>>                */
>>               spin_unlock(&pinned_root_spinlock);
>>               check_pinning_enforcement(pinned_root);
>> @@ -161,7 +161,7 @@ static int loadpin_read_file(struct file *file, enum kernel_read_file_id id)
>>       }
>>
>>       if (IS_ERR_OR_NULL(pinned_root) || load_root != pinned_root) {
>> -             if (unlikely(!enabled)) {
>> +             if (unlikely(!enforcing)) {
>>                       report_load(origin, file, "pinning-ignored");
>>                       return 0;
>>               }
>> @@ -186,10 +186,11 @@ static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init = {
>>
>>  void __init loadpin_add_hooks(void)
>>  {
>> -     pr_info("ready to pin (currently %sabled)", enabled ? "en" : "dis");
>> +     pr_info("ready to pin (currently %senforcing)\n",
>> +             enforcing ? "" : "not ");
>>       security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks), "loadpin");
>>  }
>>
>>  /* Should not be mutable after boot, so not listed in sysfs (perm == 0). */
>> -module_param(enabled, int, 0);
>> -MODULE_PARM_DESC(enabled, "Pin module/firmware loading (default: true)");
>> +module_param(enforcing, int, 0);
>> +MODULE_PARM_DESC(enforcing, "Enforce module/firmware pinning");
>>
>
>
> --
> ~Randy



-- 
Kees Cook
Pixel Security
