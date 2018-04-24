Return-Path: <dan.carpenter@oracle.com>
X-Google-Smtp-Source: AIpwx49DkuUVKHL5YxU5FDRcjjOGNkMtL4hzEhieVGXUAyk4cJ677vRs9BBkg1DHC06FzcCtcQh7
ARC-Seal: i=1; a=rsa-sha256; t=1524570675; cv=none;
        d=google.com; s=arc-20160816;
        b=IfINAoKPoFnPL+Fm1mPH80Q1iCfrP3gvVMyXof07u9rcyyI+Fr4nc8b2vTvkOdFzIc
         x17SKPAQqkdKGLHzDbWQzrC+c5wwAwRnCzMk0hwgQRzxmom0bDqHYKpsH73eKLkD+TRe
         K3BfPu1Fgu0gcL2EUoiXr17/FUOeRzMDk2W2REchTAmbTrGmbOyyQsZgGQ5TxUyXShKm
         VU1vCKVxDBDogkQOl+TbrPRf6uPr2BEuhDg838Dcn3lgXQQnmfpRHFVoqKfrTNXpS2iz
         b9Zx3kInjMhoxb/kIl2QHsMqflw564d3IqljqrpmkDEPJp/36RyIe/Epj/4u7DbkjEXg
         dM5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=YVRog/Fvn/2EKH0X7WrD6B19qIrsjNKjZAZOl1cmb8o=;
        b=OP6csJfa25TO+R5q25ePLZ82Vt3Yzu45NFUqaX4OtKEIeZPO+G0pXRoU1GfJmHNRy2
         hxbU9AdIy7wpikUPPlyLwohLRtHTXvpdZUn2/f+dSFdoqbOm5PkyAj7u0xhc+iHvRYrW
         QWZeK/3c1Q4VHFHZTfbZeDlhinL/m5z6aVf9NxNia6+Li7eZ2i/dFX4+UQfAnTepBr0j
         nCyOJ2cfcgxDnstT470tkpZqIEW+R7W+hA/8y3HQsNV+vQWcZOPEgg6X1bGhi1q52BF0
         wH6BuhgKwEpAp+lenLLO/JnDTkhkrngBarjCQs0sE2pP+njfhY7TCsDWUNH3OfC0Bo+N
         QidA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=sNe/S3Cf;
       spf=pass (google.com: domain of dan.carpenter@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=dan.carpenter@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=sNe/S3Cf;
       spf=pass (google.com: domain of dan.carpenter@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=dan.carpenter@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Date: Tue, 24 Apr 2018 14:50:52 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Kirill Marinushkin <k.marinushkin@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RESEND PATCH] staging: bcm2835-audio: Disconnect and free
 vchi_instance on module_exit()
Message-ID: <20180424115052.pqdblbts2ko36njh@mwanda>
References: <20180424071618.GB17825@kroah.com>
 <20180424074459.7215-1-k.marinushkin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424074459.7215-1-k.marinushkin@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8872 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804240117
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597968190615569586?=
X-GMAIL-MSGID: =?utf-8?q?1598628221226880277?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 09:44:59AM +0200, Kirill Marinushkin wrote:
> In the current implementation, vchi_instance is inited during the first
> call of bcm2835_audio_open_connection(), and is never freed. It causes a
> memory leak when the module `snd_bcm2835` is removed.
> 
> Here is how this commit fixes it:
> 
> * the VCHI context (including vchi_instance) is created once in the
>   platform's devres
> * the VCHI context is allocated and connected once during module_init()
> * all created bcm2835_chips have a pointer to this VCHI context
> * bcm2835_audio_open_connection() can access the VCHI context through the
>   associated bcm2835_chip
> * the VCHI context is disconnected and freed once during module_exit()
> 
> After this commit is applied, I don't see other issues with the module's
> init/exit, so I also remove the associated TODO task.
> 
> Steps to reproduce the memory leak before this commit:
> 
> ~~~~
> root@raspberrypi:/home/pi# aplay test0.wav
> Playing WAVE 'test0.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Ster
> ^CAborted by signal Interrupt...
> root@raspberrypi:/home/pi# rmmod snd_bcm2835
> root@raspberrypi:/home/pi# modprobe snd_bcm2835
> root@raspberrypi:/home/pi# aplay test0.wav
> Playing WAVE 'test0.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Ster
> ^CAborted by signal Interrupt...
> root@raspberrypi:/home/pi# echo scan > /sys/kernel/debug/kmemleak
> root@raspberrypi:/home/pi# cat /sys/kernel/debug/kmemleak
> unreferenced object 0xb6794c00 (size 128):
>   comm "aplay", pid 406, jiffies 36870 (age 116.650s)
>   hex dump (first 32 bytes):
>     08 a5 82 81 01 00 00 00 08 4c 79 b6 08 4c 79 b6  .........Ly..Ly.
>     00 00 00 00 00 00 00 00 ad 4e ad de ff ff ff ff  .........N......
>   backtrace:
>     [<802af5e0>] kmem_cache_alloc_trace+0x294/0x3d0
>     [<806ce620>] vchiq_initialise+0x98/0x1b0
>     [<806d0b34>] vchi_initialise+0x24/0x34
>     [<7f1311ec>] 0x7f1311ec
>     [<7f1303bc>] 0x7f1303bc
>     [<7f130590>] 0x7f130590
>     [<7f111fd8>] snd_pcm_open_substream+0x68/0xc4 [snd_pcm]
>     [<7f112108>] snd_pcm_open+0xd4/0x248 [snd_pcm]
>     [<7f112334>] snd_pcm_playback_open+0x4c/0x6c [snd_pcm]
>     [<7f0e250c>] snd_open+0xa8/0x14c [snd]
>     [<802ce590>] chrdev_open+0xac/0x188
>     [<802c57b4>] do_dentry_open+0x10c/0x314
>     [<802c6ba8>] vfs_open+0x5c/0x88
>     [<802d9a68>] path_openat+0x368/0x944
>     [<802dacd4>] do_filp_open+0x70/0xc4
>     [<802c6f70>] do_sys_open+0x110/0x1d4
> ~~~~
> 
> Signed-off-by: Kirill Marinushkin <k.marinushkin@gmail.com>
> Cc: Eric Anholt <eric@anholt.net>
> Cc: Stefan Wahren <stefan.wahren@i2se.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: bcm-kernel-feedback-list@broadcom.com
> Cc: linux-rpi-kernel@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: devel@driverdev.osuosl.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  .../vc04_services/bcm2835-audio/bcm2835-vchiq.c    | 64 +++++++++++++---------
>  .../staging/vc04_services/bcm2835-audio/bcm2835.c  | 43 ++++++++++++++-
>  .../staging/vc04_services/bcm2835-audio/bcm2835.h  | 12 ++++
>  3 files changed, 91 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
> index 3c6f1d91d22d..389a18f9350a 100644
> --- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
> +++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
> @@ -33,7 +33,6 @@
>  
>  /* ---- Include Files -------------------------------------------------------- */
>  
> -#include "interface/vchi/vchi.h"
>  #include "vc_vchi_audioserv_defs.h"
>  
>  /* ---- Private Constants and Types ------------------------------------------ */
> @@ -371,14 +370,46 @@ static int vc_vchi_audio_deinit(struct bcm2835_audio_instance *instance)
>  	return 0;
>  }
>  
> +int bcm2835_new_vchi_ctx(struct bcm2835_vchi_ctx *vchi_ctx)
> +{
> +	int ret;
> +
> +	/* Initialize and create a VCHI connection */
> +	ret = vchi_initialise(&vchi_ctx->vchi_instance);
> +	if (ret) {
> +		LOG_ERR("%s: failed to initialise VCHI instance (ret=%d)\n",
> +			__func__, ret);
> +
> +		return -EIO;
> +	}
> +
> +	ret = vchi_connect(NULL, 0, vchi_ctx->vchi_instance);
> +	if (ret) {
> +		LOG_ERR("%s: failed to connect VCHI instance (ret=%d)\n",
> +			__func__, ret);
> +
> +		kfree(vchi_ctx->vchi_instance);
> +		vchi_ctx->vchi_instance = NULL;
> +
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +void bcm2835_free_vchi_ctx(struct bcm2835_vchi_ctx *vchi_ctx)
> +{
> +	/* Close the VCHI connection - it will also free vchi_instance */
> +	WARN_ON(vchi_disconnect(vchi_ctx->vchi_instance));
> +
> +	vchi_ctx->vchi_instance = NULL;
> +}
> +
>  static int bcm2835_audio_open_connection(struct bcm2835_alsa_stream *alsa_stream)
>  {
> -	static VCHI_INSTANCE_T vchi_instance;
> -	static VCHI_CONNECTION_T *vchi_connection;
> -	static int initted;
>  	struct bcm2835_audio_instance *instance =
>  		(struct bcm2835_audio_instance *)alsa_stream->instance;
> -	int ret;
> +	struct bcm2835_vchi_ctx *vhci_ctx = alsa_stream->chip->vchi_ctx;
>  
>  	LOG_INFO("%s: start\n", __func__);
>  	BUG_ON(instance);
> @@ -390,28 +421,9 @@ static int bcm2835_audio_open_connection(struct bcm2835_alsa_stream *alsa_stream
>  		return 0;
>  	}
>  
> -	/* Initialize and create a VCHI connection */
> -	if (!initted) {
> -		ret = vchi_initialise(&vchi_instance);
> -		if (ret) {
> -			LOG_ERR("%s: failed to initialise VCHI instance (ret=%d)\n",
> -				__func__, ret);
> -
> -			return -EIO;
> -		}
> -		ret = vchi_connect(NULL, 0, vchi_instance);
> -		if (ret) {
> -			LOG_ERR("%s: failed to connect VCHI instance (ret=%d)\n",
> -				__func__, ret);
> -
> -			kfree(vchi_instance);
> -			return -EIO;
> -		}
> -		initted = 1;
> -	}
> -
>  	/* Initialize an instance of the audio service */
> -	instance = vc_vchi_audio_init(vchi_instance, &vchi_connection, 1);
> +	instance = vc_vchi_audio_init(vhci_ctx->vchi_instance,
> +				      &vhci_ctx->vchi_connection, 1);
>  
>  	if (IS_ERR(instance)) {
>  		LOG_ERR("%s: failed to initialize audio service\n", __func__);
> diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
> index 9030d71a3d0b..009c972d93d6 100644
> --- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
> +++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
> @@ -65,6 +65,36 @@ static int snd_devm_add_child(struct device *dev, struct device *child)
>  	return 0;
>  }
>  
> +static void bcm2835_devm_free_vchi_ctx(struct device *dev, void *res)
> +{
> +	struct bcm2835_vchi_ctx *vchi_ctx = res;
> +
> +	bcm2835_free_vchi_ctx(vchi_ctx);
> +}
> +
> +static int bcm2835_devm_add_vchi_ctx(struct device *dev)
> +{
> +	struct bcm2835_vchi_ctx *vchi_ctx;
> +	int ret;
> +
> +	vchi_ctx = devres_alloc(bcm2835_devm_free_vchi_ctx, sizeof(*vchi_ctx),
> +				GFP_KERNEL);
> +	if (!vchi_ctx)
> +		return -ENOMEM;
> +
> +	memset(vchi_ctx, 0, sizeof(*vchi_ctx));
> +
> +	ret = bcm2835_new_vchi_ctx(vchi_ctx);
> +	if (ret) {
> +		devres_free(vchi_ctx);
> +		return ret;
> +	}
> +
> +	devres_add(dev, vchi_ctx);
> +
> +	return 0;
> +}
> +
>  static void snd_bcm2835_release(struct device *dev)
>  {
>  	struct bcm2835_chip *chip = dev_get_drvdata(dev);
> @@ -106,8 +136,6 @@ static int snd_bcm2835_dev_free(struct snd_device *device)
>  	struct bcm2835_chip *chip = device->device_data;
>  	struct snd_card *card = chip->card;
>  
> -	/* TODO: free pcm, ctl */
> -
>  	snd_device_free(card, chip);
>  
>  	return 0;
> @@ -133,6 +161,13 @@ static int snd_bcm2835_create(struct snd_card *card,
>  
>  	chip->card = card;
>  
> +	chip->vchi_ctx = devres_find(card->dev->parent,
> +				     bcm2835_devm_free_vchi_ctx, NULL, NULL);
> +	if (!chip->vchi_ctx) {
> +		kfree(chip);
> +		return err;

kbuild is complaining that "err" is uninitialized here but for some
reason the line numbers are off.  It's a real bug.

regards,
dan carpenter
