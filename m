Date: Wed, 25 Apr 2018 08:16:38 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kirill Marinushkin <k.marinushkin@gmail.com>
Cc: Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] staging: bcm2835-audio: Disconnect and free
 vchi_instance on module_exit()
Message-ID: <20180425061638.GA1450@kroah.com>
References: <9e4fc4a0-370b-9101-2809-4040de58553c@gmail.com>
 <20180424195729.8433-1-k.marinushkin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424195729.8433-1-k.marinushkin@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 09:57:29PM +0200, Kirill Marinushkin wrote:
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
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
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

What changed from v1?  Always put that below the --- line as the
documentation says to do so.

v3?  :)

thanks,

greg k-h
