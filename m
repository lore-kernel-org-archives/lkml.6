Return-Path: <ebiggers3@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517646647; cv=none;
        d=google.com; s=arc-20160816;
        b=uLcbg2QWHzdzxyTij4jxp82+rkX0fEtWocX5v6RQeCuWzU/0dW86TuEb+fnMkFlDta
         +i1eI+3hZ8B7AzkHkP5cPFoJWMb2wpiuaOQZhOCOA2sfgQ2gOwbeXPTrAz/V1dcmB1NJ
         V3uH7NeyQ1TOgfszHmiNNkfRzt77j5jFAqGkS4F3IBBwyoRu1bU4C1BfYTjU1hbgv/pk
         5eQ3LVD1Vic3bSMln7be20SLW7c5c7eVa6GEl27VHek3ECfVhL8bYo5X7pvWBauJGk3w
         7ZEDt0lzEjdb8q2K4fVEKPWPM4GRfe78DjdWUvHtPxjW0pxiass/Esjx0Qx+c2e3nuyC
         Cp2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=1syQpqDBkF/Bh02HsGHapZqlWMfNqzTNFZMm1bEyYVw=;
        b=oVLgHJUN9Kt7HyOmKvguHtkQtpTmawHV8Jup59chti4kvaPiUPrz7W8YH6KvabaZp2
         +zb4eCYcn62rVns8tIX+v+CYD1za+Mp6Ss8lpbWe3UWUJwiVp6XHfO/9D5RY6d7ZYyKq
         Dyguaco0ee+WKYpiobQ4ucmwe9LFVH6c8TaAyiOibV7z2G59Qn1E48iQoNRe3BWH4z5g
         GrZZAeB9RDKSe5bHQO60wEjZlXtdkuEKgASuvDpHQvq65yahMu2t+Lx4vrVuZWx+gMJd
         IPNEjOA6gxXlrn7AC/IPw5h7zl/bpg2oMV2k0dYNTji5L/Yr3euZe3UWVC4mY5r+IxAn
         C9zA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=nnP+JT3Y;
       spf=pass (google.com: domain of ebiggers3@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ebiggers3@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=nnP+JT3Y;
       spf=pass (google.com: domain of ebiggers3@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ebiggers3@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x225ZzBSGxbBfsPGkz9eB4L2ug+RiGTitilO95LE8898s6SwCxUJF/FzvP04OHQ8gDQ5CLpt6ZQ==
Date: Sat, 3 Feb 2018 00:30:44 -0800
From: Eric Biggers <ebiggers3@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Secunia Research <vuln@secunia.com>,
	Shuah Khan <shuahkh@osg.samsung.com>
Subject: Re: [PATCH 4.4 02/74] usbip: prevent vhci_hcd driver from leaking a
 socket pointer address
Message-ID: <20180203083044.GA6126@zzz.localdomain>
References: <20180129123847.507563674@linuxfoundation.org>
 <20180129123847.617716392@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180129123847.617716392@linuxfoundation.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590958705205797601?=
X-GMAIL-MSGID: =?utf-8?q?1591367851204432946?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Jan 29, 2018 at 01:56:07PM +0100, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Shuah Khan <shuahkh@osg.samsung.com>
> 
> commit 2f2d0088eb93db5c649d2a5e34a3800a8a935fc5 upstream.
> 
> When a client has a USB device attached over IP, the vhci_hcd driver is
> locally leaking a socket pointer address via the
> 
> /sys/devices/platform/vhci_hcd/status file (world-readable) and in debug
> output when "usbip --debug port" is run.
> 
> Fix it to not leak. The socket pointer address is not used at the moment
> and it was made visible as a convenient way to find IP address from socket
> pointer address by looking up /proc/net/{tcp,tcp6}.
> 
> As this opens a security hole, the fix replaces socket pointer address with
> sockfd.
> 
> Reported-by: Secunia Research <vuln@secunia.com>
> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> 
> ---
>  drivers/usb/usbip/usbip_common.h     |    1 +
>  drivers/usb/usbip/vhci_sysfs.c       |   25 +++++++++++++++----------
>  tools/usb/usbip/libsrc/vhci_driver.c |    8 ++++----
>  3 files changed, 20 insertions(+), 14 deletions(-)
> 
> --- a/drivers/usb/usbip/usbip_common.h
> +++ b/drivers/usb/usbip/usbip_common.h
> @@ -261,6 +261,7 @@ struct usbip_device {
>  	/* lock for status */
>  	spinlock_t lock;
>  
> +	int sockfd;
>  	struct socket *tcp_socket;
>  
>  	struct task_struct *tcp_rx;
> --- a/drivers/usb/usbip/vhci_sysfs.c
> +++ b/drivers/usb/usbip/vhci_sysfs.c
> @@ -39,16 +39,20 @@ static ssize_t status_show(struct device
>  
>  	/*
>  	 * output example:
> -	 * prt sta spd dev socket           local_busid
> -	 * 000 004 000 000         c5a7bb80 1-2.3
> -	 * 001 004 000 000         d8cee980 2-3.4
> +	 * port sta spd dev      sockfd local_busid
> +	 * 0000 004 000 00000000 000003 1-2.3
> +	 * 0001 004 000 00000000 000004 2-3.4
>  	 *
> -	 * IP address can be retrieved from a socket pointer address by looking
> -	 * up /proc/net/{tcp,tcp6}. Also, a userland program may remember a
> -	 * port number and its peer IP address.
> +	 * Output includes socket fd instead of socket pointer address to
> +	 * avoid leaking kernel memory address in:
> +	 *	/sys/devices/platform/vhci_hcd.0/status and in debug output.
> +	 * The socket pointer address is not used at the moment and it was
> +	 * made visible as a convenient way to find IP address from socket
> +	 * pointer address by looking up /proc/net/{tcp,tcp6}. As this opens
> +	 * a security hole, the change is made to use sockfd instead.
>  	 */
>  	out += sprintf(out,
> -		       "prt sta spd bus dev socket           local_busid\n");
> +		       "prt sta spd bus dev sockfd local_busid\n");
>  
>  	for (i = 0; i < VHCI_NPORTS; i++) {
>  		struct vhci_device *vdev = port_to_vdev(i);
> @@ -60,11 +64,11 @@ static ssize_t status_show(struct device
>  			out += sprintf(out, "%03u %08x ",
>  				       vdev->speed, vdev->devid);
>  			out += sprintf(out, "%16p ", vdev->ud.tcp_socket);
> +			out += sprintf(out, "%06u", vdev->ud.sockfd);
>  			out += sprintf(out, "%s", dev_name(&vdev->udev->dev));

This backport is wrong; it's still printing the pointer...

Eric
