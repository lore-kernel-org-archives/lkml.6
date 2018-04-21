Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AIpwx48PZ1Y4oae08tHHy+y9oaizm/PzfPezk83b4hWzYDsgX/0CvCgDEFfmuuTgP500JoSoWGgY
ARC-Seal: i=1; a=rsa-sha256; t=1524320819; cv=none;
        d=google.com; s=arc-20160816;
        b=EIsF+7JH85VY09JK8ev0bNc43RTW6YOnIKtCgCVt65fvsZJo5N8W5BxVM6tJveQgFe
         S5krU3CMWB5EFUJ3jmb5wMIgRVQ74zsWhJxZX3OYqvspYT3ahvER/9mcSYJqg0ntFLC/
         wpZnw3e8hHl3Lvfh0GgLcA8En9npYHmoZk0TPLp8e7CFcEgw8O9/WrtfeYi4InZl6ojn
         wprhHrV9Qv9yHFvlncFZ977Mz0N+6cqxZInnz41nmAyOc2T8xVV+Z/+OLZmCCDcRBt4S
         WUYawDH7wuKW7Ok5+UtfCc+ANbSr0ANaUBphCHYJKdtqxMZk3daKv2Z2Hi4ygYrHp/tB
         zQ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=1AqN43Ya/z/vDHEsSiW4FTGn80k5JpOHRZDmNSVuk/k=;
        b=W89QMjj7L0MP5ycba7lGMxoRrI+vWuypNAM8JrhsZ67RjeJvY16x7gDDYjMN0b8OtI
         HlU4NODeZDuFNt207e1dYv5bbzr3D2L0L1vZfq11OgceOEP1hIWe6aP3NZ8KbkGo762Z
         lr/rzO9f4XIzh8HfTbkKpZM7F8iXJWJZTrFfh32cVMjI6Xjcem22ECR4oJPSqgPtD5vH
         0s4CblbzmI0BRQdidRlaIk3eaGLj47tqyjnvwvFPG2flGx10uw9wCqB52efmMAvE7WfT
         37BH4q0/zBuYAW2gfNcfr99LS5h3PtFuhjWubbv/J9u5nMsr9L5DJbKKPIyRA60qugGu
         vS5g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Date: Sat, 21 Apr 2018 16:26:56 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Andres Rodriguez <andresx7@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	mcgrof@kernel.org, alexdeucher@gmail.com,
	ckoenig.leichtzumerken@gmail.com, kvalo@codeaurora.org,
	arend.vanspriel@broadcom.com
Subject: Re: [PATCH 3/9] firmware: add kernel-doc for enum fw_opt
Message-ID: <20180421142656.GP14440@wotan.suse.de>
References: <20180417153307.3693-1-andresx7@gmail.com>
 <20180417153307.3693-4-andresx7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180417153307.3693-4-andresx7@gmail.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598008013395123690?=
X-GMAIL-MSGID: =?utf-8?q?1598366227835859538?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 17, 2018 at 11:33:01AM -0400, Andres Rodriguez wrote:
> Some basic definitions for the FW_OPT_* values
> 
> Signed-off-by: Andres Rodriguez <andresx7@gmail.com>
> ---
>  drivers/base/firmware_loader/firmware.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/base/firmware_loader/firmware.h b/drivers/base/firmware_loader/firmware.h
> index 957396293b92..8ef23c334135 100644
> --- a/drivers/base/firmware_loader/firmware.h
> +++ b/drivers/base/firmware_loader/firmware.h
> @@ -10,6 +10,17 @@
>  
>  #include <generated/utsrelease.h>
>  
> +/**
> + * enum fw_opt - options to control firmware loading behaviour
> + *
> + * @FW_OPT_UEVENT: Enable the uevent fallback path.

No, that is not what this does. This sends a kobject uevent to userspace when the
fallback mechanism is used. So please use:

"Enables the fallback mechanism to send a kobject uevent when the firmware
is not found. Userspace is in charge to load the firmware using the sysfs
loading facility."

> + * @FW_OPT_NOWAIT: Executing inside an asynchronous firmware request.

Please use "Used to describe the firmware request is asynchronous.".

> + * @FW_OPT_USERHELPER: Enable the usermode fallback path.

The notion of "userhelper" only causes confusion since the kernel has its
own usermode helper (kernel/umh.c), and the only use case that the firmware loader
has for it is for when CONFIG_UEVENT_HELPER_PATH is set to call  out to
userspace helper for kobject uevents. In practice *no one* is setting  or using
this these days.

So I have been going on a small nomenclature crusade to clean this mess up bon
on kernel/umh.c and the firmware loader. This is why the entire fallback mechanism
is now stuffed into a file called fallback.c. I don't want to confuse people
further so please do not refer to "usermode" anymore for the fallback mechanism,
it is completely misleading. We should eventually just rename this flag to
fallback or something.

Therefore please be consistent with the documentation and use:

"Enable the fallback mechanism, in case the direct filesystem lookup
fails at finding the firmware. For details refer to fw_sysfs_fallback()."

Since fw_sysfs_fallback() is used in documentation and we don't want to clash
with other documentation names, then rename fw_sysfs_fallback() to use the
firmware_ prefix. That would be a separate patch.

So Hans -- same goes for your call which can be added after Andres' patch series.

> + * @FW_OPT_NO_WARN: Quiet, avoid printing warning messages.
> + * @FW_OPT_NOCACHE: Firmware caching will be disabled for this request.

Although we have good documentation about this on
Documentation/driver-api/firmware/firmware_cache.rst best to describe this
a bit more here.

Please use (modulo adjust lengths accordingly):

* @FW_OPT_NOCACHE: Disables firmware caching. Firmware caching is used to
	           cache the firmware upon suspend, so that upon resume
		   races against the firmware file lookup on storage is
		   avoided. Used for calls where the file may be too
                   big, or where the driver takes charge of its own firmware
		   caching mechanism.

Note that an example driver which does its own firmware caching mechanism is
iwlwifi, IIRC.

> + * @FW_OPT_NOFALLBACK: Disable the fallback path. Takes precedence over
> + *                     &FW_OPT_UEVENT and &FW_OPT_USERHELPER.

Please replace "fallback path" with "fallback mechanism" to be consistent
with the documentation.

  Luis

> + */
>  enum fw_opt {
>  	FW_OPT_UEVENT =         (1U << 0),
>  	FW_OPT_NOWAIT =         (1U << 1),
> -- 
> 2.14.1
> 
> 

-- 
Do not panic
