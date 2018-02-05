Return-Path: <shuahkh@osg.samsung.com>
X-Google-Smtp-Source: AH8x2247o2m4vkcif5GD0g3EtGmow7v7z/0a/YJOn93LR2yADuyqOgtHAhpGL82DiExIJDyX5jmO
ARC-Seal: i=1; a=rsa-sha256; t=1517842714; cv=none;
        d=google.com; s=arc-20160816;
        b=ghHyiZ2iZX6h1GYfsgQwl84MuHOPCYRLR8lK7bv8kTeQmvqw3hGPHVdZR8tiE6XXXT
         9/WLN7FpIOeZi4+YX8KCHd/y+snOxmDE6aGmCEN8lsglhgGaGt0Zut2l2+7UcuxqCOJ3
         Uviq08q++ak0egPVlKUQDomiSb256VuEePIVPib7qe5y31i20jgSPsZRFFRgYubDY9XD
         9MjL3kYMbIGJaVp0VsjsV52MJCQJ3Noe/OdcWVRqfsS6e9f+gN3qcX0sf0jXgnHZWiaH
         IpT2ONRO9czQ+aS8jfQpvznfRF6xa7Oba7EpvCryiOjvhLsudDS0F4w5R1P3uqIMSITN
         s55w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=ONNXGwInwYo3RN2cpNC7eK3iF9MA1/4ylskinGAKm30=;
        b=xWcTZKSH7nI+TArySyvOucwJLx1D74v//Fiu74zMhdLASRJiimz1WTsMlPYATZQZUe
         d97mdixN9FeJH4aRNsoC1z7+h4UnN/AdQQlTn/lEHgRHtHBupHWotHi4zHfX4iwS/pAf
         +2lh8Qiu62baLkJ94o968BNzinG3STB/CA/rXuw0hQgNJ8SX4y6YGGBuC9l+YFQAxZU7
         cDZ4NWn38uIEXUe/yqM7XkHjADiIiC/CWk9etk4hSnQJQZSnT3+l4KvjzoKzRn+2wrXu
         oAmjJylsdeZDUbe13yYFOA/CDRCK7vBQydfatL6ax2Vf2RjgoMM6hzxPXMJm5SlK4Njz
         9Ehg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of shuahkh@osg.samsung.com designates 64.30.133.232 as permitted sender) smtp.mailfrom=shuahkh@osg.samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of shuahkh@osg.samsung.com designates 64.30.133.232 as permitted sender) smtp.mailfrom=shuahkh@osg.samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Subject: Re: [PATCH 4.4 02/74] usbip: prevent vhci_hcd driver from leaking a
 socket pointer address
To: Eric Biggers <ebiggers3@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Secunia Research <vuln@secunia.com>, Shuah Khan <shuahkh@osg.samsung.com>,
 Shuah Khan <shuah@kernel.org>
References: <20180129123847.507563674@linuxfoundation.org>
 <20180129123847.617716392@linuxfoundation.org>
 <20180203083044.GA6126@zzz.localdomain>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <6e15f208-a10e-96e2-55f8-36ab86d415b9@osg.samsung.com>
Date: Mon, 5 Feb 2018 07:58:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180203083044.GA6126@zzz.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590958705205797601?=
X-GMAIL-MSGID: =?utf-8?q?1591573441988873400?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/03/2018 01:30 AM, Eric Biggers wrote:
> On Mon, Jan 29, 2018 at 01:56:07PM +0100, Greg Kroah-Hartman wrote:
>> 4.4-stable review patch.  If anyone has any objections, please let me know.
>>
>> ------------------
>>
>> From: Shuah Khan <shuahkh@osg.samsung.com>
>>
>> commit 2f2d0088eb93db5c649d2a5e34a3800a8a935fc5 upstream.
>>
>> When a client has a USB device attached over IP, the vhci_hcd driver is
>> locally leaking a socket pointer address via the
>>
>> /sys/devices/platform/vhci_hcd/status file (world-readable) and in debug
>> output when "usbip --debug port" is run.
>>
>> Fix it to not leak. The socket pointer address is not used at the moment
>> and it was made visible as a convenient way to find IP address from socket
>> pointer address by looking up /proc/net/{tcp,tcp6}.
>>
>> As this opens a security hole, the fix replaces socket pointer address with
>> sockfd.
>>
>> Reported-by: Secunia Research <vuln@secunia.com>
>> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>
>>
>> ---
>>  drivers/usb/usbip/usbip_common.h     |    1 +
>>  drivers/usb/usbip/vhci_sysfs.c       |   25 +++++++++++++++----------
>>  tools/usb/usbip/libsrc/vhci_driver.c |    8 ++++----
>>  3 files changed, 20 insertions(+), 14 deletions(-)
>>
>> --- a/drivers/usb/usbip/usbip_common.h
>> +++ b/drivers/usb/usbip/usbip_common.h
>> @@ -261,6 +261,7 @@ struct usbip_device {
>>  	/* lock for status */
>>  	spinlock_t lock;
>>  
>> +	int sockfd;
>>  	struct socket *tcp_socket;
>>  
>>  	struct task_struct *tcp_rx;
>> --- a/drivers/usb/usbip/vhci_sysfs.c
>> +++ b/drivers/usb/usbip/vhci_sysfs.c
>> @@ -39,16 +39,20 @@ static ssize_t status_show(struct device
>>  
>>  	/*
>>  	 * output example:
>> -	 * prt sta spd dev socket           local_busid
>> -	 * 000 004 000 000         c5a7bb80 1-2.3
>> -	 * 001 004 000 000         d8cee980 2-3.4
>> +	 * port sta spd dev      sockfd local_busid
>> +	 * 0000 004 000 00000000 000003 1-2.3
>> +	 * 0001 004 000 00000000 000004 2-3.4
>>  	 *
>> -	 * IP address can be retrieved from a socket pointer address by looking
>> -	 * up /proc/net/{tcp,tcp6}. Also, a userland program may remember a
>> -	 * port number and its peer IP address.
>> +	 * Output includes socket fd instead of socket pointer address to
>> +	 * avoid leaking kernel memory address in:
>> +	 *	/sys/devices/platform/vhci_hcd.0/status and in debug output.
>> +	 * The socket pointer address is not used at the moment and it was
>> +	 * made visible as a convenient way to find IP address from socket
>> +	 * pointer address by looking up /proc/net/{tcp,tcp6}. As this opens
>> +	 * a security hole, the change is made to use sockfd instead.
>>  	 */
>>  	out += sprintf(out,
>> -		       "prt sta spd bus dev socket           local_busid\n");
>> +		       "prt sta spd bus dev sockfd local_busid\n");
>>  
>>  	for (i = 0; i < VHCI_NPORTS; i++) {
>>  		struct vhci_device *vdev = port_to_vdev(i);
>> @@ -60,11 +64,11 @@ static ssize_t status_show(struct device
>>  			out += sprintf(out, "%03u %08x ",
>>  				       vdev->speed, vdev->devid);
>>  			out += sprintf(out, "%16p ", vdev->ud.tcp_socket);
>> +			out += sprintf(out, "%06u", vdev->ud.sockfd);
>>  			out += sprintf(out, "%s", dev_name(&vdev->udev->dev));
> 
> This backport is wrong; it's still printing the pointer...
> 
> Eric
> 

Eric,

Yes I have a patch ready to send to fix this problem. My bad.

thanks,
-- Shuah
