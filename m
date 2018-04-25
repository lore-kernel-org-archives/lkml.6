Return-Path: <k.marinushkin@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524677675; cv=none;
        d=google.com; s=arc-20160816;
        b=Ocs5rmaJ+JWrPqk2qGUMiaGG+jeZiUpS2AMtN9jlbsAyqnrCnwT2n4rhjVI1GHzqd6
         1/Xyq4hUG3z1Xbs09rezfDWjeJolmArQF29YKywlz9k7cLcQA252GfiZGAJEulp+p9HB
         WTi/g/IAR21862JBGEL1AlSCM0xhBLxGQQrGzaXUs/FLOxDiAor7GHMV3TDreRd6RRFQ
         CYd6UeXGvJNoeWL9dxwPR4NhzZ67wJ023kEU2SFvuJn+TfFEDyMhkWVqfFPBAKkEyM3f
         FRkvApFYnJWQzgam/WRT/mg+2AKWtelFj/uKna3QDBshIE/EXSZ722XaeB/X2rl2lY41
         s4BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=6m6pEO3MZcHkJ/Mf5QyaahtD9Uw3cOF7WeyIWTXZzoA=;
        b=oIgSZFm0qOkRnuScx1BeBh/9XP2SwuAs3607u2Y7+2KHmlfmtAtEPvLXw8Ux8JUWps
         BIZt8xPSFS60/XKjupNxs1iMBqDhoUShkzU6+J8GmKULnkXvK/hCJrkZCNoOhrbkgl/1
         P+/Y6FqGF0S2OPAjOQ5Nq38dWXPveEjb3oHJPIEyc0vcx8w984iaHoh7pgTr7KuZwR5B
         MGrBdqbahFrdSXgKil8A1zNm//2C/yuCkS1j5sz8WQ7CPKygpx52LLnIz1SjCR8Ai7cM
         cNbM/F+THbtw7yjAPCXm+D282a+lq6VOwXL7splvyR7Ar1ktZqCbB+cwVvidTcj/c2eQ
         k6wQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=mcozP/0O;
       spf=pass (google.com: domain of k.marinushkin@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=k.marinushkin@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=mcozP/0O;
       spf=pass (google.com: domain of k.marinushkin@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=k.marinushkin@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4/WiYcLEJpblloURe+nJGbl8kA209657ZocymX7E5MVduvc0srhEewzBuGWdZzRs4Rs43f6KA==
Subject: Re: [PATCH v2] staging: bcm2835-audio: Disconnect and free
 vchi_instance on module_exit()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Dan Carpenter <dan.carpenter@oracle.com>, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <9e4fc4a0-370b-9101-2809-4040de58553c@gmail.com>
 <20180424195729.8433-1-k.marinushkin@gmail.com>
 <20180425061638.GA1450@kroah.com>
From: Kirill Marinushkin <k.marinushkin@gmail.com>
Message-ID: <d2690e90-f3ff-8a3a-38bc-edf0a0c7c754@gmail.com>
Date: Wed, 25 Apr 2018 19:35:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180425061638.GA1450@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597968190615569586?=
X-GMAIL-MSGID: =?utf-8?q?1598740417956248963?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/25/18 08:16, Greg Kroah-Hartman wrote:
> On Tue, Apr 24, 2018 at 09:57:29PM +0200, Kirill Marinushkin wrote:
>> In the current implementation, vchi_instance is inited during the first
>> call of bcm2835_audio_open_connection(), and is never freed. It causes a
>> memory leak when the module `snd_bcm2835` is removed.
>>
>> Here is how this commit fixes it:
>>
>> * the VCHI context (including vchi_instance) is created once in the
>>   platform's devres
>> * the VCHI context is allocated and connected once during module_init()
>> * all created bcm2835_chips have a pointer to this VCHI context
>> * bcm2835_audio_open_connection() can access the VCHI context through the
>>   associated bcm2835_chip
>> * the VCHI context is disconnected and freed once during module_exit()
>>
>> After this commit is applied, I don't see other issues with the module's
>> init/exit, so I also remove the associated TODO task.
>>
>> Steps to reproduce the memory leak before this commit:
>>
>> ~~~~
>> root@raspberrypi:/home/pi# aplay test0.wav
>> Playing WAVE 'test0.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Ster
>> ^CAborted by signal Interrupt...
>> root@raspberrypi:/home/pi# rmmod snd_bcm2835
>> root@raspberrypi:/home/pi# modprobe snd_bcm2835
>> root@raspberrypi:/home/pi# aplay test0.wav
>> Playing WAVE 'test0.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Ster
>> ^CAborted by signal Interrupt...
>> root@raspberrypi:/home/pi# echo scan > /sys/kernel/debug/kmemleak
>> root@raspberrypi:/home/pi# cat /sys/kernel/debug/kmemleak
>> unreferenced object 0xb6794c00 (size 128):
>>   comm "aplay", pid 406, jiffies 36870 (age 116.650s)
>>   hex dump (first 32 bytes):
>>     08 a5 82 81 01 00 00 00 08 4c 79 b6 08 4c 79 b6  .........Ly..Ly.
>>     00 00 00 00 00 00 00 00 ad 4e ad de ff ff ff ff  .........N......
>>   backtrace:
>>     [<802af5e0>] kmem_cache_alloc_trace+0x294/0x3d0
>>     [<806ce620>] vchiq_initialise+0x98/0x1b0
>>     [<806d0b34>] vchi_initialise+0x24/0x34
>>     [<7f1311ec>] 0x7f1311ec
>>     [<7f1303bc>] 0x7f1303bc
>>     [<7f130590>] 0x7f130590
>>     [<7f111fd8>] snd_pcm_open_substream+0x68/0xc4 [snd_pcm]
>>     [<7f112108>] snd_pcm_open+0xd4/0x248 [snd_pcm]
>>     [<7f112334>] snd_pcm_playback_open+0x4c/0x6c [snd_pcm]
>>     [<7f0e250c>] snd_open+0xa8/0x14c [snd]
>>     [<802ce590>] chrdev_open+0xac/0x188
>>     [<802c57b4>] do_dentry_open+0x10c/0x314
>>     [<802c6ba8>] vfs_open+0x5c/0x88
>>     [<802d9a68>] path_openat+0x368/0x944
>>     [<802dacd4>] do_filp_open+0x70/0xc4
>>     [<802c6f70>] do_sys_open+0x110/0x1d4
>> ~~~~
>>
>> Signed-off-by: Kirill Marinushkin <k.marinushkin@gmail.com>
>> Cc: Eric Anholt <eric@anholt.net>
>> Cc: Stefan Wahren <stefan.wahren@i2se.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Florian Fainelli <f.fainelli@gmail.com>
>> Cc: Ray Jui <rjui@broadcom.com>
>> Cc: Scott Branden <sbranden@broadcom.com>
>> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
>> Cc: Dan Carpenter <dan.carpenter@oracle.com>
>> Cc: bcm-kernel-feedback-list@broadcom.com
>> Cc: linux-rpi-kernel@lists.infradead.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: devel@driverdev.osuosl.org
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>  .../vc04_services/bcm2835-audio/bcm2835-vchiq.c    | 64 +++++++++++++---------
>>  .../staging/vc04_services/bcm2835-audio/bcm2835.c  | 43 ++++++++++++++-
>>  .../staging/vc04_services/bcm2835-audio/bcm2835.h  | 12 ++++
>>  3 files changed, 91 insertions(+), 28 deletions(-)
> What changed from v1?  Always put that below the --- line as the
> documentation says to do so.
>
> v3?  :)
>
> thanks,
>
> greg k-h
:)

Below is the git diff v1..v2

~~~~
diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
index 009c972d93d6..662e05bd8f05 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
@@ -165,7 +165,7 @@ static int snd_bcm2835_create(struct snd_card *card,
                                     bcm2835_devm_free_vchi_ctx, NULL, NULL);
        if (!chip->vchi_ctx) {
                kfree(chip);
-               return err;
+               return -ENODEV;
        }
 
        err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
~~~~

Best Regards,
Kirill
