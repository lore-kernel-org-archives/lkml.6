Return-Path: <arend.vanspriel@broadcom.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519301879; cv=none;
        d=google.com; s=arc-20160816;
        b=trISwpnwVcIStrNh5JOvJ4QfVhLOF/mVYgtrO9qUh+6VTR7BB6/ZMeQ4yPcroc9X65
         8+E67GZwfFPyAiMV1f79VdmJ97jRcqw7KHEP0A+JuZ0SD0PfQ7lBEg9kmgCgR3w9ogNr
         9kcXmeijdBjBp2rFizJhCuJXusujGW72couSxAhMVb/aX04vQ1DImxz3E1YovEYr7n3x
         QPbFzxAnvjDP6DRns7Y2njWJ/bKKX8xhZViRNw16hRgYNYOHK5UHLaSpNm+WKKOseokP
         mMLbnkf2UMdxVYPXKBfCsqZIMTTWHmPPGfHXIzFscVW+jQGaHSpYwME1kfWtDlttw30d
         zXyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:dkim-signature
         :arc-authentication-results;
        bh=4XT3+zhgMDmcDk3R1L1yCvgUISRTwtoD7Zasn3+3Sxk=;
        b=nu09QPNuBO83UBZGP8MHnPGymZC7HgmG5Zd8xdeXv6FltHXzYUpxViGd+00nyDVGJF
         Ud8MzFpykE+SzC6nZrxTSKI4u97Y36+B+VaxAlJD5PsCAyjmqOdL40EApNIei+nphDeM
         8WJT77xllLGBa5sxmZCMhNXW6w9AGj4Vf1IHxowZFRIH9J5qazkTwEyPF2IbXt9ZohZ6
         31MUWiKI8RZRpsDxcJ8TSXAm0dButGY71zzmy2okxUjJwoPGrkjVW+lve+hh/ijGx+mz
         +9JW4sTWmhc8X4bjldpIvooa9KZG5pP9yMswtG4ceNrQXhx/6pp2VvJk8IUGYtIqCC5T
         jlbw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@broadcom.com header.s=google header.b=GtTgABKj;
       spf=pass (google.com: domain of arend.vanspriel@broadcom.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arend.vanspriel@broadcom.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=broadcom.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@broadcom.com header.s=google header.b=GtTgABKj;
       spf=pass (google.com: domain of arend.vanspriel@broadcom.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arend.vanspriel@broadcom.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=broadcom.com
X-Google-Smtp-Source: AG47ELuiT7q7sDEgRemD+DfgndHi/hsAeqgRIRB+0PJaCLtELPz6wF6IIrGEcFefbfUKdEoiIBmDDA==
Subject: Re: [PATCH 2/3] mwifiex: support sysfs initiated device coredump
To: Brian Norris <briannorris@chromium.org>
References: <1519210220-22437-1-git-send-email-arend.vanspriel@broadcom.com>
 <1519210220-22437-3-git-send-email-arend.vanspriel@broadcom.com>
 <20180221225903.GA42395@rodete-desktop-imager.corp.google.com>
Cc: Kalle Valo <kvalo@codeaurora.org>, Marcel Holtmann <marcel@holtmann.org>,
 linux-wireless@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <5A8EB4F4.2030103@broadcom.com>
Date: Thu, 22 Feb 2018 13:17:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <20180221225903.GA42395@rodete-desktop-imager.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593007398864870404?=
X-GMAIL-MSGID: =?utf-8?q?1593103487529217635?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2/21/2018 11:59 PM, Brian Norris wrote:
> On Wed, Feb 21, 2018 at 11:50:19AM +0100, Arend van Spriel wrote:
>> Since commit 3c47d19ff4dc ("drivers: base: add coredump driver ops")
>> it is possible to initiate a device coredump from user-space. This
>> patch adds support for it adding the .coredump() driver callback.
>> As there is no longer a need to initiate it through debugfs remove
>> that code.
>>
>> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>> ---
>>   drivers/net/wireless/marvell/mwifiex/debugfs.c | 31 +-------------------------
>>   drivers/net/wireless/marvell/mwifiex/pcie.c    | 19 ++++++++++++++--
>>   drivers/net/wireless/marvell/mwifiex/sdio.c    | 13 +++++++++++
>>   drivers/net/wireless/marvell/mwifiex/usb.c     | 14 ++++++++++++
>>   4 files changed, 45 insertions(+), 32 deletions(-)
>
> The documentation doesn't really say [1], but is the coredump supposed
> to happen synchronously? Because the mwifiex implementation is
> asynchronous, whereas it looks like the brcmfmac one is synchronous.

Well, that depends on the eye of the beholder I guess. From user-space 
perspective it is asynchronous regardless. A write access to the 
coredump sysfs file eventually results in a uevent when the devcoredump 
entry is created, ie. after driver has made a dev_coredump API call. 
Whether the driver does that synchronously or asynchronously is 
irrelevant as far as user-space is concerned.

> Brian
>
> [1] In fact, the ABI documentation really just describes kernel
> internals, rather than documenting any user-facing details, from what I
> can tell.

You are right. Clearly I did not reach the end my learning curve here. I 
assumed referring to the existing dev_coredump facility was sufficient, 
but maybe it is worth a patch to be more explicit and mention the uevent 
behavior. Also dev_coredump facility may be disabled upon which the 
trigger will have no effect in sysfs. In the kernel the data passed by 
the driver is simply freed by dev_coredump facility.

Regards,
Arend
