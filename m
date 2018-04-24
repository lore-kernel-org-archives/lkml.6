Return-Path: <hdegoede@redhat.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524582595; cv=none;
        d=google.com; s=arc-20160816;
        b=xPGkTLNIyYXMr4HyHevVyb88djJ79BpUncidYdN6hC0VqQH5mmFwKox5tgUK08tC2v
         zEPFAirknlk58CSz5GqdD349QXaDxQTY4DiExejDpGS//7DhBivdU4TazuBRZyaj7ben
         nRLEd9G1hy6ce37LP9CanOcQnDOj7Pxv4lDwDo/X7tIIrnDvOlyF08+bBNHt7p7B6Svk
         80Pxx4Zz61YoOt19qxZa84jkbxLta+21Z/IViA9ONiLUl0jLSgFjofXJHHYERY/gpb+C
         JXDj9Af9YX4hmjwjcH3z/rbpER0FVUQuxeU/7+i3mjg8sqB02OX99etvjPYgDRxWP9h/
         xqXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=UDpbBgUS/VQYS1rmJ7/3JRRPR9jZ4TV2wRpjSlExLnU=;
        b=sMC9aI3APtx3Si9W4IUZujR36DlDwJJdXVEx9flDNQ9W8Zj0LQ8BTWZ2Jb3d2D8VNb
         u4AI/HdjD4CI/bvoVVUV8kleXDv+3oM6w+OkckIkTjtzIpN5tSgxtA9qW1b6iWIP5sSB
         MqMzIG05LvbqZKMtyZswhaMstm0yHEOP/0aFWVgd2InRKp+EgBRM9WTo0+m4LNt28NgY
         4mSEpKItVeTbSws31UsshX7KKwi29tUmod16+55362bVh4hWkROozrgcI37EqKzDhNnx
         KxezBVqOBntENPLGtluUzT0rLvCs3+WneW2C5d2i0loCc4wB0iXN/S+IVa2jHTvWRoxH
         ++Xg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
X-Google-Smtp-Source: AIpwx4/8FeXpy4pv+QalWob/b3POMj9TteKywqgOnegvpDETJbfRquRQ+dRWPfn26U48qjAi360ceQ==
Subject: Re: [PATCH v3 2/5] efi: Add embedded peripheral firmware support
To: "Luis R. Rodriguez" <mcgrof@kernel.org>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>, Kees Cook <keescook@chromium.org>
Cc: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H . Peter Anvin" <hpa@zytor.com>, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, Peter Jones <pjones@redhat.com>,
 Dave Olsthoorn <dave@bewaar.me>, Will Deacon <will.deacon@arm.com>,
 Andy Lutomirski <luto@kernel.org>, Matt Fleming <matt@codeblueprint.co.uk>,
 David Howells <dhowells@redhat.com>, Josh Triplett <josh@joshtriplett.org>,
 dmitry.torokhov@gmail.com, mfuzzey@parkeon.com,
 Kalle Valo <kvalo@codeaurora.org>,
 Arend Van Spriel <arend.vanspriel@broadcom.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, nbroeking@me.com,
 bjorn.andersson@linaro.org, Torsten Duwe <duwe@suse.de>, x86@kernel.org,
 linux-efi@vger.kernel.org
References: <20180408174014.21908-1-hdegoede@redhat.com>
 <20180408174014.21908-3-hdegoede@redhat.com>
 <20180423211143.GZ14440@wotan.suse.de>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <71e6a45a-398d-b7a4-dab0-8b9936683226@redhat.com>
Date: Tue, 24 Apr 2018 17:09:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180423211143.GZ14440@wotan.suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597199782052351527?=
X-GMAIL-MSGID: =?utf-8?q?1598640719215925017?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 23-04-18 23:11, Luis R. Rodriguez wrote:
> Hans, please see use of READING_FIRMWARE_PREALLOC_BUFFER, we'll need a new ID
> and security for this type of request so IMA can reject it if the policy is
> configured for it.

Hmm, interesting, actually it seems like the whole existence
of READING_FIRMWARE_PREALLOC_BUFFER is a mistake, the IMA
framework really does not care if we are loading the firmware
into memory allocated by the firmware-loader code, or into
memory allocated by the device-driver requesting the firmware.

As such the current IMA code (from v4.17-rc2) actually does
not handle READING_FIRMWARE_PREALLOC_BUFFER at all, here
are bits of code from: security/integrity/ima/ima_main.c:

static int read_idmap[READING_MAX_ID] = {
         [READING_FIRMWARE] = FIRMWARE_CHECK,
         [READING_MODULE] = MODULE_CHECK,
         [READING_KEXEC_IMAGE] = KEXEC_KERNEL_CHECK,
         [READING_KEXEC_INITRAMFS] = KEXEC_INITRAMFS_CHECK,
         [READING_POLICY] = POLICY_CHECK
};

int ima_post_read_file(struct file *file, void *buf, loff_t size,
	...
         if (!file && read_id == READING_FIRMWARE) {
                 if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
                     (ima_appraise & IMA_APPRAISE_ENFORCE))
                         return -EACCES; /* INTEGRITY_UNKNOWN */
                 return 0;
         }

Which show that the IMA code is not handling
READING_FIRMWARE_PREALLOC_BUFFER as it should (I believe it
should handle it the same as READING_FIRMWARE).

Now we could fix that, but the only user of
READING_FIRMWARE_PREALLOC_BUFFER is the code which originally
introduced it:

https://patchwork.kernel.org/patch/9162011/

So I believe it might be better to instead replace it
with just READING_FIRMWARE and find another way to tell
kernel_read_file() that there is a pre-allocated buffer,
perhaps the easiest way there is that  *buf must be
NULL when the caller wants kernel_read_file() to
vmalloc the mem. This would of course require auditing
all callers that the buf which the pass in is initialized
to NULL.

Either way adding a third READING_FIRMWARE_FOO to the
kernel_read_file_id enum seems like a bad idea, from
the IMA pov firmware is firmware.

What this whole exercise has shown me though is that
I need to call security_kernel_post_read_file() when
loading EFI embedded firmware. I will add a call to
security_kernel_post_read_file() for v4 of the patch-set.

> Please Cc Kees in future patches.

Will do.

Regards,

Hans
