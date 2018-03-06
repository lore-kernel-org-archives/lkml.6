Return-Path: <k.marinushkin@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520358115; cv=none;
        d=google.com; s=arc-20160816;
        b=sSCfAxVVgisiP4Jkh03HgD8LPM+Vxs1GHqOsvfZ/ASQ/2zn8CZtupGrSx0EDxzpVko
         vMfeBiZY5MscjMPu/z9rk1zUqZZpdmjbuHO+9LIim0IKWgt19KTzXoaCFJ+6s/Bxhzi9
         6irUGnhx3+IaX7NDgUiZvZZSeJevhh3956FB8KCR7afiQPOFmBZdSUM/LEdz60lciP+s
         6C98BCL715w1j5YqHDAV6a4GjCMCINpVwDLBBZi5L+ngQTP5BTTteESfBOAd6Wm+7QgT
         3H2ImjvCPNWdTTIeMZP55vn6MZ/mRm94xwDC7O+qOoqyySR4cWXbDu/R2b5KdOEsOS0w
         bfBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=IGcyfmNmeuvspvHXiE353sD5HED0VhI+CTBIIEQZlTw=;
        b=f1hmZs0EQ/vV8YMdGyiN2PYimAISurxehjAprSREG9VcHWjTfwIL25EIZ3DfkwVfnG
         FN/hsV56PFz38aE9jOZc3E5hDaDoWPHHZpSonGv0YS67jGDjwCS9rn+2RfMb3WVA64cg
         ZFGStC1kHC/TEovOqbn02zNcr96JxEFyhLtEFLIG4hvN5aW6YAp/KD7HFsIx7T/oMnkb
         Hj1uotfO+4pZ+iE7AczbYJEy9Vsie1UOxafDBVbv8ivb2EYcpYnNNGNS+O14/PRGuA8L
         /vuoRsTkcx/+Ro7Yq7vad25Xfq/UmfNxkmMGu5BdmaKzerV9BbgpTyI7WlTMu1vZoZbF
         zBWA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ZfDn3N1M;
       spf=pass (google.com: domain of k.marinushkin@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=k.marinushkin@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ZfDn3N1M;
       spf=pass (google.com: domain of k.marinushkin@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=k.marinushkin@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELv85CvnN8EcCvSm8GbbdsOUDdVe9BDLgRKnZ0OHV7xoYuo/eH/KjYTKMBNwT8iJyqcguJouHA==
Subject: Re: [PATCH] staging: bcm2835-audio: Release resources on
 module_exit()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, Michael Zoran <mzoran@crowfest.net>,
 bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
References: <20180305055254.29875-1-k.marinushkin@gmail.com>
 <20180306121441.GA7177@kroah.com>
From: Kirill Marinushkin <k.marinushkin@gmail.com>
Message-ID: <63ee611d-9fd7-a67a-45aa-229cc4a83ed2@gmail.com>
Date: Tue, 6 Mar 2018 18:42:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180306121441.GA7177@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594075828670099193?=
X-GMAIL-MSGID: =?utf-8?q?1594211030843658959?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/06/18 13:14, Greg Kroah-Hartman wrote:
> On Mon, Mar 05, 2018 at 06:52:54AM +0100, Kirill Marinushkin wrote:
>> In the current implementation, `rmmod snd_bcm2835` does not release
>> resources properly. It causes an oops when trying to list sound devices.
>>
>> This commit fixes it.
>>
>> Steps to reproduce:
>>
>> ~~~~
>> $ rmmod snd_bcm2835
>> $ aplay -L
>> [  138.648130] Unable to handle kernel paging request at virtual address 7f1343c0
>> [  138.660415] pgd = ad8f0000
>> [  138.665567] [7f1343c0] *pgd=3864c811, *pte=00000000, *ppte=00000000
>> [  138.674887] Internal error: Oops: 7 [#1] SMP ARM
>> [  138.683571] Modules linked in: sha256_generic cfg80211 rfkill snd_pcm snd_timer
>>  snd fixed uio_pdrv_genirq uio ip_tables x_tables ipv6 [last unloaded: snd_bcm2835
>> ]
>> [  138.706594] CPU: 3 PID: 463 Comm: aplay Tainted: G        WC       4.15.0-rc1-v
>> 7+ #6
>> [  138.719833] Hardware name: BCM2835
>> [  138.726016] task: b877ac00 task.stack: aebec000
>> [  138.733408] PC is at try_module_get+0x38/0x24c
>> [  138.740813] LR is at snd_ctl_open+0x58/0x194 [snd]
>> [  138.748485] pc : [<801c4d5c>]    lr : [<7f0e6b2c>]    psr: 20000013
>> [  138.757709] sp : aebedd60  ip : aebedd88  fp : aebedd84
>> [  138.765884] r10: 00000000  r9 : 00000004  r8 : 7f0ed440
>> [  138.774040] r7 : b7e469b0  r6 : 7f0e6b2c  r5 : afd91900  r4 : 7f1343c0
>> [  138.783571] r3 : aebec000  r2 : 00000001  r1 : b877ac00  r0 : 7f1343c0
>> [  138.793084] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
>> [  138.803300] Control: 10c5387d  Table: 2d8f006a  DAC: 00000055
>> [  138.812064] Process aplay (pid: 463, stack limit = 0xaebec210)
>> [  138.820868] Stack: (0xaebedd60 to 0xaebee000)
>> [  138.828207] dd60: 00000000 b848d000 afd91900 00000000 b7e469b0 7f0ed440 aebedda4 aebedd88
>> [  138.842371] dd80: 7f0e6b2c 801c4d30 afd91900 7f0ea4dc 00000000 b7e469b0 aebeddcc aebedda8
>> [  138.856611] dda0: 7f0e250c 7f0e6ae0 7f0e2464 b8478ec0 b7e469b0 afd91900 7f0ea388 00000000
>> [  138.870864] ddc0: aebeddf4 aebeddd0 802ce590 7f0e2470 8090ab64 afd91900 afd91900 b7e469b0
>> [  138.885301] dde0: afd91908 802ce4e4 aebede1c aebeddf8 802c57b4 802ce4f0 afd91900 aebedea8
>> [  138.900110] de00: b7fa4c00 00000000 00000000 00000004 aebede3c aebede20 802c6ba8 802c56b4
>> [  138.915260] de20: aebedea8 00000000 aebedf5c 00000000 aebedea4 aebede40 802d9a68 802c6b58
>> [  138.930661] de40: b874ddd0 00000000 00000000 00000001 00000041 00000000 afd91900 aebede70
>> [  138.946402] de60: 00000000 00000000 00000002 b7e469b0 b8a87610 b8d6ab80 801852f8 00080000
>> [  138.962314] de80: aebedf5c aebedea8 00000001 80108464 aebec000 00000000 aebedf4c aebedea8
>> [  138.978414] dea0: 802dacd4 802d970c b8a87610 b8d6ab80 a7982bc6 00000009 af363019 b9231480
>> [  138.994617] dec0: 00000000 b8c038a0 b7e469b0 00000101 00000002 00000238 00000000 00000000
>> [  139.010823] dee0: 00000000 aebedee8 00080000 0000000f aebedf3c aebedf00 802ed7e4 80843f94
>> [  139.027025] df00: 00000003 00080000 b9231490 b9231480 00000000 00080000 af363000 00000000
>> [  139.043229] df20: 00000005 00000002 ffffff9c 00000000 00080000 ffffff9c af363000 00000003
>> [  139.059430] df40: aebedf94 aebedf50 802c6f70 802dac70 aebec000 00000000 00000001 00000000
>> [  139.075629] df60: 00020000 00000004 00000100 00000001 7ebe577c 0002e038 00000000 00000005
>> [  139.091828] df80: 80108464 aebec000 aebedfa4 aebedf98 802c7060 802c6e6c 00000000 aebedfa8
>> [  139.108025] dfa0: 801082c0 802c7040 7ebe577c 0002e038 7ebe577c 00080000 00000b98 e81c8400
>> [  139.124222] dfc0: 7ebe577c 0002e038 00000000 00000005 7ebe57e4 00a20af8 7ebe57f0 76f87394
>> [  139.140419] dfe0: 00000000 7ebe55c4 76ec88e8 76df1d9c 60000010 7ebe577c 00000000 00000000
>> [  139.156715] [<801c4d5c>] (try_module_get) from [<7f0e6b2c>] (snd_ctl_open+0x58/0x194 [snd])
>> [  139.173222] [<7f0e6b2c>] (snd_ctl_open [snd]) from [<7f0e250c>] (snd_open+0xa8/0x14c [snd])
>> [  139.189683] [<7f0e250c>] (snd_open [snd]) from [<802ce590>] (chrdev_open+0xac/0x188)
>> [  139.205465] [<802ce590>] (chrdev_open) from [<802c57b4>] (do_dentry_open+0x10c/0x314)
>> [  139.221347] [<802c57b4>] (do_dentry_open) from [<802c6ba8>] (vfs_open+0x5c/0x88)
>> [  139.236788] [<802c6ba8>] (vfs_open) from [<802d9a68>] (path_openat+0x368/0x944)
>> [  139.248270] [<802d9a68>] (path_openat) from [<802dacd4>] (do_filp_open+0x70/0xc4)
>> [  139.263731] [<802dacd4>] (do_filp_open) from [<802c6f70>] (do_sys_open+0x110/0x1d4)
>> [  139.279378] [<802c6f70>] (do_sys_open) from [<802c7060>] (SyS_open+0x2c/0x30)
>> [  139.290647] [<802c7060>] (SyS_open) from [<801082c0>] (ret_fast_syscall+0x0/0x28)
>> [  139.306021] Code: e3c3303f e5932004 e2822001 e5832004 (e5943000)
>> [  139.316265] ---[ end trace 7f3f7f6193b663ed ]---
>> [  139.324956] note: aplay[463] exited with preempt_count 1
>> ~~~~
>>
>> Signed-off-by: Kirill Marinushkin <k.marinushkin@gmail.com>
>> Cc: Eric Anholt <eric@anholt.net>
>> Cc: Stefan Wahren <stefan.wahren@i2se.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Florian Fainelli <f.fainelli@gmail.com>
>> Cc: Ray Jui <rjui@broadcom.com>
>> Cc: Scott Branden <sbranden@broadcom.com>
>> Cc: bcm-kernel-feedback-list@broadcom.com
>> Cc: Michael Zoran <mzoran@crowfest.net>
>> Cc: linux-rpi-kernel@lists.infradead.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: devel@driverdev.osuosl.org
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>  .../staging/vc04_services/bcm2835-audio/bcm2835.c  | 37 +++++++++++-----------
>>  1 file changed, 19 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
>> index 8f2d508183b2..01187df7d85f 100644
>> --- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
>> +++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
>> @@ -36,6 +36,11 @@ MODULE_PARM_DESC(enable_compat_alsa,
>>  static void snd_devm_unregister_child(struct device *dev, void *res)
>>  {
>>  	struct device *childdev = *(struct device **)res;
>> +	struct snd_card *snd_card =
>> +		(struct snd_card *)dev_get_drvdata(childdev);
>> +
>> +	snd_card_free(snd_card);
>> +	dev_set_drvdata(childdev, NULL);
>>  
>>  	device_unregister(childdev);
>>  }
>> @@ -61,6 +66,11 @@ static int snd_devm_add_child(struct device *dev, struct device *child)
>>  	return 0;
>>  }
>>  
>> +static void snd_devm_release(struct device *dev)
>> +{
>> +	/* avoid warnings when releasing the resources */
>> +}
> As per the in-kernel documentation, I get to make fun of you for trying
> to "fool" the kernel here :(
>
> Please please please do not do stuff like this.  There is a good reason
> the kernel is warning you that you need to do something "real" here.  I
> didn't put that logic in the kernel for no good reason, so don't try to
> "shut it up" by being sneaky and trying to fool it.
>
> Properly clean up your memory here, that is what is needed.
>
> thanks,
>
> greg k-h

Hello Greg,

Thank you for the clarification. I didn't realize the problem, but now I understand
and agree, that my implementation is not correct.

I apologize for this misunderstanding. I will release the resources in a proper way,
and I will send the cleaner solution as a patch v2.

Best Regards,
Kirill
