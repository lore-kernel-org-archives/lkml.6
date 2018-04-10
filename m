Return-Path: <kernel-hardening-return-12962-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4/IYzOeNH4SQtep3qSZx3wUESpebtGMNLLlQ1Xz548ukgYIMKKcmvD5zjSIiL8q0PAmqZ3v
ARC-Seal: i=1; a=rsa-sha256; t=1523397177; cv=none;
        d=google.com; s=arc-20160816;
        b=rz8Uv7ON1AYr7nQGW2uGPfkQGOF/KbwlWSdkqMHX2nzs4w6rTNeLQHRPqWVJC4+bYC
         sBFwvIDmw0s9ZtC1rzLhxMSdv/HnbrcxImADabXldU5giimtsmOEtYEpsbEmv1hSkXaI
         SGmHw1YGPtQaTuIhcxm+2JXbDGTytzyNmBwOS/4RSfaxmv5liPUvtFKJIim9bK7iTzWT
         WBkkYsy09EqKridWVDTRTHGctv/QK6bJuQ46iYNrnJwvxFiBJH6glYv64At6+EJjpRgT
         c6emxC9OGpfMQUmQLVnYA8LSlx3ppYK0H8uS594KcMnePO4EogkbI2Gq+V5HmOfBpCJG
         7xwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=Ebtv7zbmt8FlFhkr60155qkgVpLXFfWHOK7tt956aOo=;
        b=JEGFZeZ8iKJt4BsKYb3V44LZFzimnHTxuYkeFYzkRvt/M8kfJUA89+U7jWh5Vo/MWU
         eS9Puxslae+LTIzEAjgDvbRX6pR/Amv5k3a7AoEJr4USuCUTrW8qO5HmHTaUUJoh48SQ
         XAgCor03y6IwHARfVA3UwYiqdpuNBoo9RMzBm5XdG3I7C1j53PLMZuLAiJcqJSeh+kXT
         22k5sUCY1VrhlSKmkgev1omYqjl7yDC8s2XaTzVpuHgBy2wManzL0NgexblD4BGsw64A
         xelSg8+LYDvWJF/+4FJSXNXXDi4mLHAe4VMzAazBD+m6DgLGeZcpJLk0+Ls/sQKbAwjF
         sXHQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12962-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12962-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12962-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12962-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH] drm/i2c: tda998x: Remove VLA usage
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
 Kees Cook <keescook@chromium.org>
References: <20180409210703.3787-1-labbott@redhat.com>
 <20180409222141.GR16141@n2100.armlinux.org.uk>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <855433a0-72f5-df29-3a17-5c2016e988e1@redhat.com>
Date: Tue, 10 Apr 2018 14:52:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180409222141.GR16141@n2100.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597304263905140111?=
X-GMAIL-MSGID: =?utf-8?q?1597397718989188253?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/09/2018 03:21 PM, Russell King - ARM Linux wrote:
> On Mon, Apr 09, 2018 at 02:07:03PM -0700, Laura Abbott wrote:
>> There's an ongoing effort to remove VLAs[1] from the kernel to eventually
>> turn on -Wvla. The vla in reg_write_range is based on the length of data
>> passed. The one use of a non-constant size for this range is bounded by
>> the size buffer passed to hdmi_infoframe_pack which is a fixed size.
>> Switch to this upper bound.
> 
> Does this _really_ make it safer?  What if the code is modified to write
> more than 32 bytes in the future?
> 
> Sorry, I don't think this is safer at all.
> 

Yeah I wasn't 100% sure about this one. Elsewhere, we've added bounds
checks against the new static size buffer so we could do that here
to ensure we don't overrun the stack if we do need to write more
than 32 bytes in the future. Another option is to switch to
a kmalloc buffer. Are either of those options acceptable to you or
do you have a better idea of how to get rid of the VLA?

Thanks,
Laura
